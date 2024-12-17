Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F94E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNU2b-0004YY-Qx; Tue, 17 Dec 2024 04:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNU2a-0004YC-AF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:38:56 -0500
Received: from mail-dm3nam02on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2405::60f]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNU2X-0006Dk-Qw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:38:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQFs95Dp3KvfDjULghwCCqDLmHzdTG6aPvJd21vkPgVJ6+VJX+06VcMALja2j0WNar/jzC6M/GcTVuUtGVRGQxMrEj8t4rQtIq0uLr1yFsDPGBptlKWAh/4bxd6hol9udbdAU+o65HA2Gg8JUSMpzmLV944/ATGoEZiPYz6/6Ya46UK+Nw/bgQ5Q7lieKs9sG7GSOwWYVBBaxMqEk5UBATfvDOSiLzVCmgd+WhSViqhNT5uBXWJD98K2jWcX2X86mkRidBweVYTj1J1l5Zog42sNCV7MrOf5zlUz/eMi8zSbqGBhK0YdBmIFKnBPM2BtlT61neT23vxbGwWsJBk99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jt5zcHFxu8eK60DM3Cx72SANoBaD7aR+L717nq3ncaQ=;
 b=cQlf2f7O9+cuQIvkH5dqHFIlck1vVby2ngFnJPe7ob6ZZNvXAiRNcBMLWWw0VANzLX+l282Jw06I+ZONce9Pd3JJLlN5Zc3yn3g/LLDV5YkAh6kwt7byI/m0ZGq3FQVe1meA2+P7qN/T2uGPsUu++2rHzenCSCpSxdCnHBUi/X9cvrcnAYDE8E30MB2yaxkaoyU43Abx8Mf1XauLOAOnkUmw7peQl8FqUy6JjDVDeIfvIBQy75W18hssX76A1e7p9nweqZUltw56ZXI5wnsriEbYixSNxh9YbZn6K8A3akpbalFhmBFv89klF/r9kIg9B+2vR0/+cFBxMzDXNjEHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt5zcHFxu8eK60DM3Cx72SANoBaD7aR+L717nq3ncaQ=;
 b=dwKLH/UI21DG12WEksj+Vg+/CHrCHRU3FcYSz9mQpx7S7Cnn3vJyozYt9abTzXVGfJF2n8CDw0zNB4Fn+9rr89iQpBxMrLstOT1TYwtuWJ0tCReQzKahZ+4A2daAE8fCN7fma9OZpDeMXGA3erL1KTGpwPhpDXEgQ1yGqrKD2SRegl6TsqurRlozZvsBOZdDkVfJ6cKn9KTN+zeos+PrkyRcNkrQ4ufUBgj6ZL+L8aNzmFHthv5vRWkapWszI3uwCxkAQk3lXqBag6tbVJIkM7OwCZqj2vS21WcIQa9FuljFawYPthXum+c9UGVBI6ApTQjuZIWnUEa01BWIxiAyxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 09:38:48 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:38:48 +0000
Message-ID: <91f82153-280b-4782-bbe9-736494c41c44@nvidia.com>
Date: Tue, 17 Dec 2024 11:38:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] vfio/migration: Refactor
 vfio_devices_all_running_and_mig_active() logic
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-4-avihaih@nvidia.com>
 <14070e26-ef99-4a6c-b3ba-ef910270856d@oracle.com>
 <63082412-a42f-42b9-88f5-8e40a8f28c8b@nvidia.com>
 <4741b80f-cdf6-4e43-8bae-f3604e858200@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4741b80f-cdf6-4e43-8bae-f3604e858200@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4b9249-1afd-481f-bbe5-08dd1e7e9b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjZPWFpmei9ESm5qVEQya3RSOHZIaXBEMlBWVmlwdFB4WDZsUit3dzRnTzF2?=
 =?utf-8?B?MTVoSGQvUmtFUUZ6eDdZUEFCRnphUDQyS1FPSE9yVkVVcU5MS3o0WE56MzRT?=
 =?utf-8?B?aFdGc09jdHU0YW1kUzM5Ky82NmMxTDU5OWtXSHphZDRFSHl6c1lycW5jbjdH?=
 =?utf-8?B?VHJvZE9USGlvK1QzNUlKalRBMlI4NVltL2FUalE0ZU5SLzNVM0wyUmJDaWR6?=
 =?utf-8?B?SzhDMWgza2pwZW02d3NTR3I5SVh1K2F5SjVjVnJrUG5nWkRUaEQrcSsrWERk?=
 =?utf-8?B?SyttQ2hTeHpjRG9oOWJ0cjd4c2Erb0dwclMwTDVSWHRtaENXcTBxZksrY08w?=
 =?utf-8?B?U2xHVStWR1ZIRU5IeUhUV2p4NzFQWFd4Zzc3SldTWjd4TUFad1VMMmVaQ05v?=
 =?utf-8?B?TDBRUnMzNHhJV3RUU1Q1cytNNWU1NmMydSsvQ2pKUGFwMFhPb1FyWEltWGVM?=
 =?utf-8?B?aXl2OUdXT0xWRForWE4vRVVCNmZ4OGFWamthUE9Semo2ZlorTXFFcG1tTzZU?=
 =?utf-8?B?K2p4NHVDMHFISlp6dXhtR1N0a0FYMGlramdWVkQ0WWhIZW9rOEJqeXk4UWYr?=
 =?utf-8?B?SmIvWHpyYk84eDBwNkp2SzF3QUo3WlRPNkppZlNZUkppcGtEdEN2akxENk4y?=
 =?utf-8?B?K3pJTHJBcUs4YjN5d2xGVkRzZnlvemtvV3ZtaTZ6SCsxNXBxTVJkbW5YbE1r?=
 =?utf-8?B?SHIrbVRuSjd0V25RSWcxK1FSME8welNsWGpXVmJTMzhVK0xtcWxTOUl0dFJO?=
 =?utf-8?B?MFoyMXIrMmFiVGRSdFhTSXRPMkZpbjM1bDFpVUN3VzI5U0FCSHdqc2xNd2F0?=
 =?utf-8?B?YWoyNXAvVzdJbjJiZW9Lb2JKZ1lNS3RQa1ZtZWRQeEwvR1RJbk1sZlRzZno2?=
 =?utf-8?B?Qzg0ZnliMlg1UzNXMmpMd1JGMG9ieUdoSmFHOGVFMThaN0lxbER6QVd4ZnJj?=
 =?utf-8?B?RDJaT2xWbFhSZjR6TEdiUi8yOWhnWmtnKytWbUdrdlJzczJNMzdJYUMyZGhi?=
 =?utf-8?B?Nk1kQnA5S2lJT29vaWpudnMwV3p2b2dTSUp0MlF1ZzQ2Z1FXQUtxRjQ0WDlu?=
 =?utf-8?B?UDlYODNwYmlBTTBUTU9NWHNxTUR6QWN4OWtjVHQ5N1cyTkxubDFwRzhyY3Br?=
 =?utf-8?B?T1lPWWRpWnlNRWMxbDBkWDBldE54QXRyeTB0bzYwR09jL2U0UnhOYWI5T0lp?=
 =?utf-8?B?RitTWHdDczlSOExBaWhBbjZxMUtRaDFXVm1BSk5kY0h2TXBEVlIxZ1JFUHla?=
 =?utf-8?B?RHNIVkFmVFJPMjJPdFNEYXZtSGJHRW84ZVRBdElPcHllYThMVEpEaldBdmp1?=
 =?utf-8?B?QlRUYjd6eHZrd3o4STdrYkc2VmMxbzcrQ2VORmZheWxnbEwzdFpMM1d4RDlw?=
 =?utf-8?B?b1VSWnVmRUc1QURXSjA3dUZDNWpldFo5UDFmVGVheVZ0cm9CZzBhQ0hwZGtq?=
 =?utf-8?B?cDJiKzJvT2N6eS8vUzU5SU5rby8rWVhCL0E2L3JnOTdnbGdZT2hwOGUveEt1?=
 =?utf-8?B?UzFuNVZCend1cG0zQm83eXlpd0pWaWloZGZROENyTThWaUVWMHdHd1kwUUxm?=
 =?utf-8?B?eGxUR2xnZGQvRUM5R2tWNGttaFJJOXU3cnBjOU9LR1FOWG1qTVdyU3IvcnVY?=
 =?utf-8?B?UUVpRG40cnFwaTk5Z3pPMjdvQ0FJamRMd1ppREhLRFl2WU9za1RWNDZ6M2Zx?=
 =?utf-8?B?elF2MVZqR0c0KzV4WGFMUWwzNGNUMWpIQ3BicGVMVlFHU3JnWmY4WVdLcjVw?=
 =?utf-8?B?VmpwS25WaXpoZkMvR0F3NkEyUWd2VkhkTTBpTm5JTlJiNElMQThTZHRZTmg2?=
 =?utf-8?B?cjhidVRTeGlwWnp4YVFjNHVnR1hvbDhqSlN2SVhxWnFrNDZsd213bzZPcUN3?=
 =?utf-8?Q?xdLCz182BwRGe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRwTWovcVh3emVGL0xOUCtIVlJSUVpkMy9qWU5Kblp2NkxiVEFpcUQxU0pD?=
 =?utf-8?B?YjF1Rm1HcU81YmFGUzJUQS9sNkphZ0s0VG5meWdBMjQ0eEFadmJVOGVMRElG?=
 =?utf-8?B?Q2dvc2ltUVk1RklkekhIYW1LcWpmSVFabm1qcWlJN3Nhd1I0RnZKejFRL0Zk?=
 =?utf-8?B?K0hMT3JiL3NEaFlWdk9CcDdrNVpZWlNtSUZrQ2RMeG5XbzJpTWNpN09qTlUy?=
 =?utf-8?B?Q3dsYWtsZzBNTHgxZU5qRFdOemxkUlB0am5pbDQyN0FtZ3hnWkZOZ0o1cUx0?=
 =?utf-8?B?RDNqQXhkRmlmWjZIeG1LaXZMbDk1MStJa3dsaUh5VzZKa0V5WktTSXNuS3RY?=
 =?utf-8?B?Sks1Y0ZNaHRhUzJUcGIrSkxMVWo3Qkd0Vmh1VlBMeG5GOWkzS1NHcFdoNmtU?=
 =?utf-8?B?cmZJNnZXeGxuWFd2cXRtb1k1NFdIMi8vTUgreDRqc2FKSmUyNnFmUGVLQjcx?=
 =?utf-8?B?QTU1UXJGVGJQWWN4N09CZndxYVhISWdqekw3alEwc000cTI1ODhjS1MxS1VV?=
 =?utf-8?B?NDlGR1kxc1A5alVVamQrMnpSbFpxWU1IY1liVVBYOUx5RUtGQ20zdHlXR01D?=
 =?utf-8?B?OFgzaElWMjdwNGd2bFdIbEptU29MWTNBZ3loTlBNS3RnclBiYUVnTm82Y0Fh?=
 =?utf-8?B?emZiQm04cW5NZldydi9xbkJqVHJyWFhOWnRWZEVpckJxKzVtUWJZQjdKR1U5?=
 =?utf-8?B?dkVvb0NaRG9VTUxQZnNhNjc0bUwramFjU2k4NS9JdmhST0tFOVZqN090SHZ4?=
 =?utf-8?B?SjIyVGE1U0xlNUlTK1IyTzQyYzF1MG8yU1J2OTFhbDdodGs2QUJyUjNUN1FH?=
 =?utf-8?B?R2gzTnF5SzRiRjBiU3BGaFkrL0hlWUFiQm4yZWMrQnZjSUdadzBMU2pWT1lt?=
 =?utf-8?B?Y1NGbE1hWHhDQWlGcDA2RHNuNVc5TVlXRVZ6dEI4YmFRa0QzbCtvemNKeWxX?=
 =?utf-8?B?UFhQOC96eXhEWlpwckZtOEl2ZkpVcjJtNHdKbjdQY2xjZG5ud0UvZStCNmtj?=
 =?utf-8?B?Y3dPMjlnRUtHbS9DaUIzbEM2c1BOUmh4Q3BBN2xTRm5xOGZGOEM4VTc4QWRu?=
 =?utf-8?B?RFVsTzhlSCtqTHNkT1A4TE5BeDFNRm5wV2tsTkJRUllVNGxJM3diSDBmVzRI?=
 =?utf-8?B?QitsMktnMXlmbnFGNVdwcnp1eXlGWWZ3RjRvVmdrTldaTXFKTG9GT1ptYWVQ?=
 =?utf-8?B?a1JRUWlBZXQvcFdEdXFXNmsyblFXNW8yU3ZJWDVpY0JzbVluQTJyNE9OQXZi?=
 =?utf-8?B?Q3FtUEI1YXduSTZnUmNkQ3hMUE5wRXp1S0QvZW5HWkt3Q3dNYjBFZkpQVVph?=
 =?utf-8?B?Y1I2ekwrbHEzcGpMd0Q4ZGErcTNNUFBlSXFQbmhvZFNQSDBZTHhuK2J1M2xM?=
 =?utf-8?B?YjcxQU1mODNvK0grbTV3Yjd3MmtyOXRWdUkxWXdaTTNnQTBDcXdXZkZRTVFP?=
 =?utf-8?B?S3ROWHFtdURVcHZEcWRTQTRhM2Jaa0NGeXdqU2hTeGszWXoyczFJc1BQT3Ur?=
 =?utf-8?B?U3g0b2U2L3NVcHdYYlplRzlLV3Q4MmVKaHlDZnlGT1RtWG04NFk4SFpSNHdH?=
 =?utf-8?B?OGh6VWIyZnUyTUdEbHBZUDlKa3B3eU0zanRrK1VPejlYZDBzUUxoQmlYVVZo?=
 =?utf-8?B?MGpBeCthcVJBWk45eWhvZk9HM2Q5bUZlQzYyR1Brd2s3ZnlGbVAxdEFUNjRa?=
 =?utf-8?B?eGRJbURBNFRTc0ZWdHgxQ25kSVhML05IN2N6dEZMUUdxRWxCSkFSZ2diTFVC?=
 =?utf-8?B?RTJpYnFRTjFRc2YxT2t2UG04VmlUWElDV0Y5L2RpcWNtSDRHVFBHZ0NXMmRk?=
 =?utf-8?B?K1ZDczd3VVFlN2JIUExTNG81aGsvR3NNbmJLUHVYempPQXd0LzdOUklDYUR2?=
 =?utf-8?B?UnBKRWUyeVptQmZzYkhLaE5kQXFjc05IWlNCTlgySW5zTGoySmJjZ2xYMk4w?=
 =?utf-8?B?MjQ0V05KQUQwaER4Wm9DRmhuVnhNM0MzSnEzUkFTNEFYbC9qdURyQUgwTmw4?=
 =?utf-8?B?UmZ1TjZUNGo2dkVGdFE4ZmJaVFpJSkd4U0JLWlIyZlE1SjNVSHBMeWxNNGtq?=
 =?utf-8?B?ckdZUVVoMC9JSXU5eVlkWHJQUjlXVUVZUFBJTCtGQmJFSlNQWW4wbzVwT3U4?=
 =?utf-8?Q?0kzPRzv8qMo65rWQQn5oOW8PI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4b9249-1afd-481f-bbe5-08dd1e7e9b73
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:38:48.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAnTbIa7o6Hz+oqps+YhLez9+OYUTc9i9MmCztT2o9qcUtofQyGKkQgs8jPURZfSyhlXHiHpcwygDfqfjiQ26w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
Received-SPF: softfail client-ip=2a01:111:f403:2405::60f;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 16/12/2024 17:58, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 16/12/2024 14:55, Avihai Horon wrote:
>> On 16/12/2024 14:45, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 16/12/2024 09:46, Avihai Horon wrote:
>>>> During DMA unmap with vIOMMU, vfio_devices_all_running_and_mig_active()
>>>> is used to check whether a dirty page log sync of the unmapped pages is
>>>> required. Such log sync is needed during migration pre-copy phase, and
>>>> the current logic detects it by checking if migration is active and if
>>>> the VFIO devices are running.
>>>>
>>>> However, recently there has been an effort to simplify the migration
>>>> status API and reduce it to a single migration_is_running() function.
>>>>
>>>> To accommodate this, refactor vfio_devices_all_running_and_mig_active()
>>>> logic so it won't use migration_is_active().
>>>>
>>>> Do it by modifying the logic to check if migration is running and dirty
>>>> tracking has been started. This should be equivalent to the previous
>>>> logic because when the guest is stopped there shouldn't be DMA unmaps
>>>> coming from it. Also rename the function properly.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>    include/hw/vfio/vfio-common.h |  3 +--
>>>>    hw/vfio/common.c              | 28 ++++------------------------
>>>>    hw/vfio/container.c           |  2 +-
>>>>    3 files changed, 6 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index e0ce6ec3a9..c23ca34871 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -296,8 +296,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error
>>>> **errp);
>>>>    void vfio_migration_exit(VFIODevice *vbasedev);
>>>>
>>>>    int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
>>>> -bool
>>>> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
>>>> +bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer);
>>>>    bool
>>>>    vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>>>>    int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index a99796403e..81fba81a6f 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -229,34 +229,14 @@ bool vfio_devices_all_device_dirty_tracking(const
>>>> VFIOContainerBase *bcontainer)
>>>>        return true;
>>>>    }
>>>>
>>>> -/*
>>>> - * Check if all VFIO devices are running and migration is active, which is
>>>> - * essentially equivalent to the migration being in pre-copy phase.
>>>> - */
>>>> -bool
>>>> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
>>>> +bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
>>>>    {
>>>> -    VFIODevice *vbasedev;
>>>> -
>>>> -    if (!migration_is_active()) {
>>>> +    if (!migration_is_running()) {
>>>>            return false;
>>>>        }
>>>>
>>>> -    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>>>> -        VFIOMigration *migration = vbasedev->migration;
>>>> -
>>>> -        if (!migration) {
>>>> -            return false;
>>>> -        }
>>>> -
>>>> -        if (vfio_device_state_is_running(vbasedev) ||
>>>> -            vfio_device_state_is_precopy(vbasedev)) {
>>>> -            continue;
>>>> -        } else {
>>>> -            return false;
>>>> -        }
>>> Functionally the change implies that even if non-migratable VFIO devices behind
>>> IOMMUs with dirty tracking would still sync DMA bitmap. I think this is OK as it
>>> increases the coverage for calc-dirty-rate (provided my comment in an earlier
>>> patch) such that if you try to get a dirty rate included the IOMMU invalidations
>>> marking the bits accordingly.
>> We still have the "if (!migration_is_running())" check above, so non-migratable
>> VFIO devices won't sync.
>> But that's a valid point for when we'll allow VFIO log syncs for clac-dirty-rate.
>>
> It's the other way around :) This change helps calc-dirty-rate because you can
> use it and still account for DMA unmap based dirties.
>
> migration_is_running just stops logs if migration is not running. And that
> doesn't care about VFIO migation support.
>
> But if migration is running, whether the device supports migration or not...

If the device doesn't support migration then migration can't run, no?
But anyway, as we talked in the other thread, I can untie this from 
migration and then, as you said above, it may also dirty sync for 
non-migratable devices which will make calc-dirty-rate more accurate.

>   it
> will still sync for pages. It won't sync if it has no VF dirty tracking, but
> there's still the container dirty tracker.
>
> Whereby previously, you skip checking all together if the VFIO migration state
> wasn't initialized and the VF was not in the right VF device-state.

