FROM mcr.microsoft.com/dotnet/sdk:8.0 as build
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore 

COPY . ./

RUN dotnet publish -c Release -o out 

FROM mcr.microsoft.com/dotnet/aspnet:8.0 as runtime 
WORKDIR /app

COPY --from=build /app/out ./

EXPOSE 5123

ENTRYPOINT ["dotnet","HelloApi.dll"]