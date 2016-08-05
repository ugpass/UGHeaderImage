//
//  ViewController.m
//  UGHeaderImageDemo
//
//  Created by 樊伟杰 on 16/8/2.
//  Copyright © 2016年 樊伟杰. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+leoAdd.h"
#import "LEOHeaderView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kImageHeight 263

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) LEOHeaderView *headerView;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.headerView reloadWithScrollView:self.tableView];
}

- (LEOHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LEOHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kImageHeight)];
        [_headerView setBackgroundImage:[UIImage imageNamed:@"background.jpg"]];
        [_headerView setHeaderImage:[UIImage imageNamed:@"header.jpg"] text:@""];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(kImageHeight - kNavigationBarHeight, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    
    [self.view insertSubview:self.headerView belowSubview:self.tableView];
    
    //点击头像回调
    [self.headerView pressHeaderImageWithBlock:^{
        [[[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil] show];
    }];
    
    //navigationBar 的颜色可以根据这个方法来调整
    __weak typeof(self) weakSelf = self;
    [self.headerView scrollViewStateChangeWithBlock:^(BOOL reachtop) {
        [weakSelf.navigationController.navigationBar leo_setBackgroundColor:reachtop ? [UIColor lightGrayColor] : [UIColor clearColor]];
    }];
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.headerView reloadWithScrollView:scrollView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
