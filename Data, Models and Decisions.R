library(shiny)
library(shinythemes)
library(shinyWidgets)
library(DT)
library(rmarkdown)
library(shinyjs)

ui <- fluidPage(
  theme = shinythemes::shinytheme("flatly"),
  tags$head(
    tags$style(HTML("
      .navbar .navbar-nav {
        width: 100%;
      }

      .navbar-brand {
        font-size: 25px; 
        margin-bottom: 30px;
        font-family: 'Verdana', sans-serif; 
      }
    "))
  ),
  
  navbarPage(
    id = "main_nav",
    title = div(class = "navbar-brand", "Sangho's Business Analytics & Decision Making Case Study"),
    tabPanel("🏠", value = "home", uiOutput("home")),
    navbarMenu("Introduction",
               tabPanel("Overview", value = "overview", uiOutput("overview")), 
               tabPanel("About Me", value = "about_me", uiOutput("about_me")), 
               tabPanel("Inspired By", value = "about_the_book", uiOutput("about_the_book"))
    ),
    navbarMenu("Data, Models, and Decisions",
               tabPanel("Chapter 1: Decision Analysis", value = "chapter1",
                        fluidPage(
                          pickerInput("chapter1_select", "Choose a Case:",
                                      choices = c("Bill Sampras Summer Job Decision", 
                                                  "Bio-Imaging Development Strategies",
                                                  "Kendall Crab and Lobster, Inc.",
                                                  "Buying a House",
                                                  "The Acquisition of DSOFT")),
                          uiOutput("chapter1_content"))),
               
               
               tabPanel("Chapter 6: Regression Models: Concepts and Practice", value = "chpater6",
                        fluidPage(
                          pickerInput("chapter6_select", "Choose a Case:",
                                      choices = c("The Construction Department at Croq'Pain")),
                          uiOutput("chapter6_content")))
               
    ),
    navbarMenu("University of California, San Diego - MSBA",
               tabPanel("Marketing Analytics", value = "mar_analytics",
                        fluidPage(
                          pickerInput("mar1_select", "Choose a Case:",
                                      choices = c("Segmentation: K-means Clustering [Palmer Penguin]",
                                                  "A/B Testing [Fund raising: Donation]",
                                                  "Maximum Likelihood Estimation [Blueprinty]",
                                                  "Maximum Likelihood Estimation [Air BnB]",
                                                  "Multi-nomial Logit (MNL) Model [Yogurt]",
                                                  "Multi-nomial Logit (MNL) Model [Minivan]",
                                                  "Variable Importance [Payment Card]")),
                          uiOutput("mar1_content")
                        )),
               
               tabPanel("Supply Chain Analytics", value = "sc_analytics",
                        fluidPage(
                          pickerInput("sup1_select", "Choose a Case:",
                                      choices = c("Clustering Analysis [Late Order Acknowledgement]",
                                                  "Distribution Center Cost Comparison: Regional vs. National",
                                                  "Customer Flow Analysis [Rogers Market: Amazon Just Walk Out Technology]"
                                      )),
                          uiOutput("sup1_content")
                        )),
               
               
               tabPanel("People Analytics", value = "pep_analytics",
                        fluidPage(
                          pickerInput("pep1_select", "Choose a Case:",
                                      choices = c("Forecasting Attrition Rates for Each Manufacturing Facility")),
                          uiOutput("pep1_content")
                        )),
               
               tabPanel("Managerial Judg/Decis Making", value = "managerial_decision_making",
                        fluidPage(
                          pickerInput("majd1_select", "Decision Making Game:",
                                      choices = c("Decision Making Game: A Reflection on Managerial Judgment and Decision Making Class from UCSD")),
                          uiOutput("majd1_content")
                        ))
               
    ),
    
    
  )
)

##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################



server <- function(input, output, session) {
  active_tab <- reactiveVal("home")
  
  
  ################################################## Home ##################################################
  observeEvent(input$main_nav, {
    if(input$main_nav == "home") {
      rendered_html <- rmarkdown::render("home.Rmd", output_dir = "www", output_file = "home.html")
      
      active_tab(input$main_nav)
    }
  })
  
  output$home <- renderUI({
    if (active_tab() == "home") {
      tags$iframe(src = "home.html", style = "width:100%; height:800px;")
    }
  })
  
  active_tab <- reactiveVal("home")
  
  ################################################## Overview ##################################################
  observeEvent(input$main_nav, {
    if(input$main_nav == "overview") {
      rendered_html <- rmarkdown::render("overview.Rmd", output_dir = "www", output_file = "overview.html")
      
      active_tab(input$main_nav)
    }
  })
  
  output$overview <- renderUI({
    if (active_tab() == "overview") {
      tags$iframe(src = "overview.html", style = "width:100%; height:800px;")
    }
  })
  
  active_tab <- reactiveVal("home")
  
  
  ################################################## About Me ##################################################
  observeEvent(input$main_nav, {
    if(input$main_nav == "about_me") {
      rendered_html <- rmarkdown::render("about_me.Rmd", output_dir = "www", output_file = "about_me.html")
      
      active_tab(input$main_nav)
    }
  })
  
  output$about_me <- renderUI({
    if (active_tab() == "about_me") {
      tags$iframe(src = "about_me.html", style = "width:100%; height:800px;")
    }
  })
  
  active_tab <- reactiveVal("home")
  
  
  
  ################################################## About The Book ##################################################
  observeEvent(input$main_nav, {
    if(input$main_nav == "about_the_book") {
      rendered_html <- rmarkdown::render("about_the_book.Rmd", output_dir = "www", output_file = "about_the_book.html")
      
      active_tab(input$main_nav)
    }
  })
  
  output$about_the_book <- renderUI({
    if (active_tab() == "about_the_book") {
      tags$iframe(src = "about_the_book.html", style = "width:100%; height:800px;")
    }
  })
  
  active_tab <- reactiveVal("home")
  
  
  ################################## Chapter 1: Descision Analysis ###########################################
  
  
  output$chapter1_content <- renderUI({
    req(input$chapter1_select) 
    
    file_name <- switch(input$chapter1_select,
                        "Bio-Imaging Development Strategies" = "Chapter_1_bio_imaging_development_strategies.html",
                        "Bill Sampras Summer Job Decision" = "Chapter_1_bill_sampras_summer_job_decision.html",
                        "Kendall Crab and Lobster, Inc." = "Chapter_1_kendall_crab_lobster.html",
                        "Buying a House" = "Chapter_1_buying_a_house.html",
                        "The Acquisition of DSOFT" = "Chapter_1_the_acquisition_of_dsoft.html")
    
    if (!is.null(file_name)) {
      tags$iframe(src = file_name, style = "width:100%; height:800px;")
    }
  })
  
  observeEvent(input$main_nav, {
    active_tab(input$main_nav)
  })
  
  
  
  
  
  
  ################################## Chapter 6: Regression Models: Concepts and Practice ###########################################
  
  
  output$chapter6_content <- renderUI({
    req(input$chapter6_select) 
    
    file_name <- switch(input$chapter6_select,
                        "The Construction Department at Croq'Pain" = "Chapter_6_the_construction_department_at_croqpain.html")
    
    if (!is.null(file_name)) {
      tags$iframe(src = file_name, style = "width:100%; height:800px;")
    }
  })
  
  observeEvent(input$main_nav, {
    active_tab(input$main_nav)
  })
  
  
  ################################## Marketing Analytics ###########################################
  
  
  output$mar1_content <- renderUI({
    req(input$mar1_select) 
    
    file_name <- switch(input$mar1_select,
                        "Segmentation: K-means Clustering [Palmer Penguin]" = "marketing_analytics_segmentation.html",
                        "A/B Testing [Fund raising: Donation]" = "marketing_analytics_abtesting.html",
                        "Maximum Likelihood Estimation [Blueprinty]" = "marketing_analytics_mle.html",
                        "Maximum Likelihood Estimation [Air BnB]" = "marketing_analytics_mle_2.html",
                        "Multi-nomial Logit (MNL) Model [Yogurt]" = "marketing_analytics_mnl_conjoint.html",
                        "Multi-nomial Logit (MNL) Model [Minivan]" = "marketing_analytics_mnl_conjoint_2.html",
                        "Variable Importance [Payment Card]" = "marketing_analytics_variable_importance.html")
    
    if (!is.null(file_name)) {
      tags$iframe(src = file_name, style = "width:100%; height:800px;")
    }
  })
  
  observeEvent(input$main_nav, {
    active_tab(input$main_nav)
  })
  
  
  
  
  ################################## Supply Chain Analytics ###########################################
  
  
  output$sup1_content <- renderUI({
    req(input$sup1_select) 
    
    file_name <- switch(input$sup1_select,
                        "Clustering Analysis [Late Order Acknowledgement]" = "supply_chain_analytics_late_order_clustering.html",
                        "Distribution Center Cost Comparison: Regional vs. National" = "supply_chain_analytics_distribution_center_cost_comparison.html",
                        "Customer Flow Analysis [Rogers Market: Amazon Just Walk Out Technology]" = "supply_chain_analytics_customer_flow_rogers.html"
    )
    
    if (!is.null(file_name)) {
      tags$iframe(src = file_name, style = "width:100%; height:800px;")
    }
  })
  
  observeEvent(input$main_nav, {
    active_tab(input$main_nav)
  })
  
  
  
  
  ################################## People Analytics ###########################################
  
  
  output$pep1_content <- renderUI({
    req(input$pep1_select) 
    
    file_name <- switch(input$pep1_select,
                        "Forecasting Attrition Rates for Each Manufacturing Facility" = "people_analytics_forecasting_attrition.html")
    
    if (!is.null(file_name)) {
      tags$iframe(src = file_name, style = "width:100%; height:800px;")
    }
  })
  
  observeEvent(input$main_nav, {
    active_tab(input$main_nav)
  })
  
  
  ################################## Decision Making Game ###########################################
  
  
  output$majd1_content <- renderUI({
    req(input$majd1_select) 
    
    file_name <- switch(input$majd1_select,
                        "Decision Making Game: A Reflection on Managerial Judgment and Decision Making Class from UCSD" = "decision_making_game.html")
    
    if (!is.null(file_name)) {
      tags$iframe(src = file_name, style = "width:100%; height:800px;")
    }
  })
  
  observeEvent(input$main_nav, {
    active_tab(input$main_nav)
  })
  
  
  
  #########################################################################################################################################################
  
  
}

shinyApp(ui = ui, server = server)


