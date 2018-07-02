
library(shiny)
library(readr)
population_2013 <- read_csv("population_2013.csv")
population_2014 <- read_csv("population_2014.csv")
population_2015 <- read_csv("population_2015.csv")
population_2016 <- read_csv("population_2016.csv")
population_2017 <- read_csv("population_2017.csv")

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  # Return the requested dataset ----
  datasetInput <- reactive({
    switch(input$dataset,
           "2013" = population_2013,
           "2014" = population_2014,
           "2015" = population_2015,
           "2016" = population_2016,
           "2017" = population_2017)
  })
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset[,4])
  })
  
  # Show the first "n" observations ----
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
}