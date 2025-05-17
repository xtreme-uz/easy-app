# Stage 1: Build the application
FROM gradle:8.5-jdk17 AS builder
WORKDIR /app
COPY build.gradle settings.gradle ./
COPY gradle ./gradle
COPY gradlew ./
# Copy the source code
COPY src ./src
# Build the application
RUN ./gradlew bootJar --no-daemon

# Stage 2: Runtime stage
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Copy the jar file from builder stage
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]