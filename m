Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494CBC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBPm-00018A-T3; Thu, 06 Mar 2025 08:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tqBPa-00017o-Kr
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:37:18 -0500
Received: from mail-dm6nam11on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2415::611]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tqBPY-0004to-0A
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:37:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8N+yOk3r2LEyLxMQvePW0iQK03FjwP1RYvbKcpxQVJXgbv8oRatSyM/ruAGlk1Hssq6LZosqutzRurYFmgbISC0BMxLEOsSCqo5bOgyqOrcRr7GNd3D3BtA4gThkpcpO0rwcr28EdcDOTikQctk8Wf7NbZMQcu14wTSp8BSxiV2FlX1d9y0qiHS8Da174DMlRSSZ84KTJyH6TQl+XxRZzdVA01adRkmiFBSnBDGnP7Vl5q30tq7j8c+6Cn/gvoB4ZV+pAAW8azAdjhJI54sJeQoOhTWGUCe45UzGOkeO9X2VUOlp69mqRRljVT0T5u45rSIHlLmSxEufluMM+HaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2/cUurOPvwcgbyXA8wKflbs1xZBdf17jE4NfZI6jHQ=;
 b=tewvgql1+KfamAragiCJDKDzH4o90OJd1blBucKpxtLQ+rlBJQ+4+E+5ErjpxKOVmrOzVlV29hpdCfE2eDFKmAx8Uq0ATMi9ZHXjwgRJLNgMvyZhoQL4cJjVImaCE99Jq9loYHaB0LbKrIglIMGV8RrWg6o7n8OyLFyHIAv9xNY6eKAiszMvegMHGLjKRnX+CNmdHpxYAxkiXGyFLhvQXXcvJc2HVGX4/nt+bB2vwaA1BLlojBm0vApu4hk3BhXmo0ruwn7HPkUkFib5vDh6w9qZKTMu2clUaCzM5xSmDNotx9jDntCFVh0XUGu+NSSsJKENgixB5PwU4qUH+bDqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2/cUurOPvwcgbyXA8wKflbs1xZBdf17jE4NfZI6jHQ=;
 b=HgZdoXFB2Q8IC5XsGalteY3ts1yEXrz8wPDlqeWm//tYG5IQgR6bwcYP8loC11X6xZSDo5f1Qp1evq0sA83eyJTh2b9QKgooInibZGskmr/ewwl6sLwJqO7YObQ++j6dV6TMpOeHsSZUiYGyiYDUHGVELMRQiqjunppqI2aLuNZbnN/RgMzBmFkuTEKXNvhU19AwkLb97v+q736XcDYQxPz+t7jDUpJYn3DL0INU9UBKRcpXDGK43Vl4lJyD8Yg0kug3wkUu6a/Aeb9ZDUfowu9Zj/rfxzH+0SMM2/qXi2tC3eUQQtER8uRS6elHpmVr9327SkJTq8BsjXLuxC+Hqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 13:37:10 +0000
Received: from BL0PR12MB5538.namprd12.prod.outlook.com
 ([fe80::3699:352b:fbf8:b41d]) by BL0PR12MB5538.namprd12.prod.outlook.com
 ([fe80::3699:352b:fbf8:b41d%6]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 13:37:09 +0000
Message-ID: <d85c8d21-5e1b-4162-9f5b-fe270beb5eca@nvidia.com>
Date: Thu, 6 Mar 2025 15:37:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com>
 <629dff3c-865d-47d9-a01a-d212dfed1efb@nvidia.com>
 <97b87f22-b867-4282-ba13-efba16458859@maciej.szmigiero.name>
 <973268d4-85d6-4a17-ae76-2d20d8cfd7cb@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <973268d4-85d6-4a17-ae76-2d20d8cfd7cb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::9) To BL0PR12MB5538.namprd12.prod.outlook.com
 (2603:10b6:208:1c9::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: ca80e8dc-df9f-4a2c-4e53-08dd5cb3fe80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFlzOEtKemtjVnZXYllkUGdhanhhcSsrN2JTMm5ySWpLTFlQRlcrdmlWVTNE?=
 =?utf-8?B?VExsSzFvdWFidHJYSXo1ZEdEcTd2Y0ZBZlBZY3cvbUtRWXVSUXRINkplVFhq?=
 =?utf-8?B?bXdqSEp2Y0duVVRDZG9hNUJCL1djR1FNQ3ltS0ZLd250eTVKb3Y2UGVpUXhG?=
 =?utf-8?B?UWIyczdqa3N5clR0aFBnRmZyeW1yczVUeWxVRnBsTFhTK1hFS2w0WDEySVpl?=
 =?utf-8?B?Rms5UEE3QnNqb0FDc1pPSkRmcjlTVk9Wek90cTdTN25qL0ovbVpEYXVINjlt?=
 =?utf-8?B?T0NjS05xNkdvUjlWVEhsc0Z4NnJwSjl6aWFnajFsNzJRdXY2c3JVOTF5RDVY?=
 =?utf-8?B?Z1pWcW5hdnJTWjJnTU1KLzNFWlpLd2orNXFjV3hvUlRHR2YzdnFrMlptRUdw?=
 =?utf-8?B?eGltNU1VRGtuZmxaRVJmTGh5aTdxUXhQLzNST3A4NngwNnlBLzhteGRUNkxJ?=
 =?utf-8?B?TE95NmErUmU1QjN3U3drMXpiSjFzR0oxbXhwSWhJYXlLZWtKTUZuNmJRSUdk?=
 =?utf-8?B?SFdnRjdlYWdmMUpIek9remhGdWFWajZQMGo3SDcyWm9iYWdnR0F5SEtRUkRa?=
 =?utf-8?B?ejFYT3E3ekZNeW4ybVl5NlpsM3NOQjBYT3RxWU41OFZqTUd0NVRjOTFuZCt3?=
 =?utf-8?B?VnZOS0p2dnVXTHRCSzFDVUxBWmNkcUZxbjZKSVJrRVJmcEJuaHNHN2dKUWFS?=
 =?utf-8?B?VTNkWTJjUGo4RjQ2NkxaUDRubzBCcytyR2Qrc2orNzJvRTY4aU1vWFdBYjhT?=
 =?utf-8?B?V1RYL2JMQkpRMHlCSDVrRWsrdVNram5zbjNBTS9RWWxzbHhGM0RLWlZDcUNZ?=
 =?utf-8?B?Skh1OFg1dXA4TlFuYXE5VWg0dnNDUnQ4cm50ZnlFd0x1STUvUnFNZzJBcXNI?=
 =?utf-8?B?TFVMckRYcUhhR0lXNm5EUGxpSjVsVWcwZ0JhbmpoRVl2Y25YcWlZTDQvK2ZM?=
 =?utf-8?B?Z0NjcjQ5ZEVVK2Rhb25jdlBORTBwR1hwWjQyMWNmU3VXWjVQUnBHY295dGc3?=
 =?utf-8?B?Y25TLzNjbGVwbm9WWnVSQkNZQ2VrOG54OUwxUndJUGo5UGlIbnJvUENqMExE?=
 =?utf-8?B?VzZpNUxlbHdYM1V1bE9FL0N3cWw4dFRtV2lkNk9IZGxyMVZJUzlBNzQ1RlF1?=
 =?utf-8?B?L1dJSlMvRXFMbVA2d3dRcmNFVGZqWXoyOHY3YVNwdEZBeE01S2JuMFc1Y0xm?=
 =?utf-8?B?cEtIRktTYmdvMFgyS1VmS3dSN05YK2prZ0dSUEQvTlM1UGRtN1lFSS9GTVQx?=
 =?utf-8?B?cUYwM3p3Tk5yUTI2Um5ndjBoK0RjZFNvRXpMWExGMngrL3hCTFZWVkVlNnZD?=
 =?utf-8?B?K1Y1UFU1MWxDQkpEeWRsU0hvaUJ3M0V4TERPdTUvb294T3RsL09wTGd6Sm00?=
 =?utf-8?B?KzYzdDNQOWc1YmNoMGhYdWs2OVYwWXdsb0Y4cEE0MEJRZnlHYmdyVmRYVjhR?=
 =?utf-8?B?QmNadVpNQnNFZ29BR2Qzc3piVjhTQkI2S1l0TFFmQXlmbGExNUlZTitQUGNJ?=
 =?utf-8?B?WkJZSWQ1TXQyaUttQURTbFdteHlZTHBUQjFKWDNPQTBLWDMvZ2xQVm1YZndh?=
 =?utf-8?B?Q3NOc3l2Ui93cktNR1BoSkM4Z0IwTHBDdDBNNWYyMFdIMXl5R0Rla1pnUzV0?=
 =?utf-8?B?eVVYUE0wSWJEeDJnVTcySkg3c3pMcmY1ZFNWSlJoUG55K0ZLbVRJWTMyK2ta?=
 =?utf-8?B?R05iY2VDNXlDQ0JBZFdEM1Q5anpJeWtENmc0dWc0cFM2UEVaWEZ4cVRmNG5U?=
 =?utf-8?B?eEVLU3NJc2dxN05Ca3B2R0k3aFgwQ2xrelhMcVdrT0lRaUg1c3RrRFZscUl1?=
 =?utf-8?B?Q1h4MjNYTWRIRXB0S3dpYWhXQ3NITnM0UU1mWUpUS3h3UmJmTjR0OTJmclB4?=
 =?utf-8?Q?dkGtrkU3DGIJK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJYMm8vTmg0UzdhL3NETGRQREErbXpVcGorSjNBT09KZGlCMWpmTVdUS2xn?=
 =?utf-8?B?U0NlUkYyZUQ5amdwTjR1Zit6UFZTaWZEdWRWeVVUWnhCQ21pbHpJc084NlBQ?=
 =?utf-8?B?TnNrYkRGMGQwQnloUC9uNmlkaFIwSm1BNFRKVFVhT0ZwYlZ5TWJyZ00ybEhJ?=
 =?utf-8?B?a0RZTzkvWXdKdVI5UUxqRmlwVXcyWXZUZzg0M0xMUmZBaFBKeWU5YXJUdWlK?=
 =?utf-8?B?bUlwSmd0QWppdHU3Ykt0S0lFTWlXc0IvOFZZdVg1SSt0cUxFL3ptZkczc2Zn?=
 =?utf-8?B?SkxTa2tDYno0d0UybGtPU0gyc0NiaXJUU2FvaFI3YWJmOE51ZDNNS09ZTnZQ?=
 =?utf-8?B?SkZITlQ3Vm5lOFhHMTl4UWxMaWdKWDdkWFpyUDhZdkJZaHBnVlQ4ekluNC9k?=
 =?utf-8?B?eTltVlBtZmdFd3FXWFNEamNZbDJLQ2xkSXJDeWxjbXl0Zk1waVlLR0ZxWGVV?=
 =?utf-8?B?U1ArbjZONFZFaHRxNDNmb0pKaSs5VlNETzdtTk93TVdZR0YzVXI5T0poditN?=
 =?utf-8?B?UkFlcU1YRUg2bjBveVdQaTRQdEloNW1OUG4wSkRYMDdRV1RSWGpJcmg1dWdP?=
 =?utf-8?B?Sjl0NlBmWitTc1hZUVdaOGdLdGJ5RE55MEZXcm55d1BpTGdpSVNXbTU3a2ZW?=
 =?utf-8?B?M1E5NUUzVThFU0puOWFlMlNVZStvNkpuT3FYUEpSbmpGYzFSR2xXZVcvUVNa?=
 =?utf-8?B?dncvSXQ1eEYzQ0wyNHpWcXIyQk8zQk1hdks1aEw5NGZpNjZVTStWZ3VJVUhH?=
 =?utf-8?B?RXlmS2gxRlVNN2FENnNuOTBPT3FsVzVocllPT1hJc0pKTWQ2c3RJL0hKZndQ?=
 =?utf-8?B?MWs4ZWJVZkVkbFp4OVJtSU5QWUVhK2RzakhIcnJkdzBiRWNjZXppbUEraG1y?=
 =?utf-8?B?aU9KQndzVmF6Si8ySytZcDJsNzdvRWJhL3RZenFwWUhFNUZXT2MweVRFRFVX?=
 =?utf-8?B?cnNpWERLUWlCNVV5TG5xWit2VmQ5bmJhSkp3UllWdUxVUW01NVpZWUVCYmN6?=
 =?utf-8?B?MWVtNHE2bWZaNitKTGt3bTZJK1YvMmFkY0p3L2VuRlhDNzk1ODJIKzNNVlNm?=
 =?utf-8?B?OERpTEJmWTYwdVhTYktsbUhCZDc4QW41K0hsZGlnRDVxRmJlSEd3WnllYXRv?=
 =?utf-8?B?R3NSS1pEUDNqK2d0QlUrbFZOMjF5N0hBNDBVeWd1SnZnOTVTMG1PZU04NlJE?=
 =?utf-8?B?YjZDYjBLMVIwU0w1TW1GMmZnTlovRVVaaTR1Y01WYUtoVW9EWWNHMi81VnZt?=
 =?utf-8?B?eXY2dEFkTlp6VjhpbUI2UmljVDJlUTZFeUlZcFJHTkhJZXNtTDRZUnhkV3Zz?=
 =?utf-8?B?QkFiMkRsNTk5dFpYVlBheWNtbXRTb3FWSFZycU9zS1hZNitqc0prRVJQUWhy?=
 =?utf-8?B?TXhORmdibHNPVHI3aFB3MEw5TVFWRFdGVWFTWFVFZCs5RXNjNUVxQ2VPejBN?=
 =?utf-8?B?ZjN0UzdISlNWeWxXSExqRG03b0NjYXFIdlg2bGtpbVVxYjlPaklXQS9EQUpU?=
 =?utf-8?B?aktpRXc5d0tnMFIxTm5oaG1SUDczS0t3US9waGlIN1YvTElqb0ZicW8xMUNH?=
 =?utf-8?B?KzMvZ0lkN3krbjhONktRMEpjenZYM09hSElTdGg0V3FRdW9xM3l1RXNtOVox?=
 =?utf-8?B?cEtNMlkzYk5TWU4zemhFcEU3NXVGTHB4YVJNSmhEdWhMem5ERkxJVER0cDhs?=
 =?utf-8?B?L2xiKzJxbHBBS3dGNEtIZTkrMHcxNUg3VDlZMFJvUTNxL1U3S01RUXVxNm96?=
 =?utf-8?B?ajl2ZktEK1BTSUI5M1pwd2VYRzJEdUJZNXZ1ZS9MWTJFeG9pSGtoL1ZYSTVY?=
 =?utf-8?B?Si96K2ZtRjAvTVAvNXpJT1B5dXBDTFlpWHppTHkycWJpVnU5c24weHd4TW5a?=
 =?utf-8?B?MDVaZjY1eFcxSzZsb0FtWjJ0TTlEaXpXc21wb1MvSitWUFFIWXRtT0UwQmFO?=
 =?utf-8?B?clgyRXp3UlluYnRwbEw5aDJYT0ZlcjRGNzI2ODFaWkRNdThHVjNtZ0lPb1hn?=
 =?utf-8?B?dGFLVXRGNE0rR1FLZEl4a3A1NkNPS09xK3Rxc0JzNS9yempwYUJZak9sOWg4?=
 =?utf-8?B?MEQwVktFRENJekxoYXBFRXZiU3h0c3FENGN1NjdpbTRiRU5PM0U1bENQSFBa?=
 =?utf-8?Q?6T6UPqq/7ciSgvoJewEr0RBcz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca80e8dc-df9f-4a2c-4e53-08dd5cb3fe80
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 13:37:09.8842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eFZSv8P6wGq/eDHEIbOjp9jBLi6LdxR9hdm2W396qx4qSb8v7eaq2fPzRw2tawzMW7J6ezAAjfXQcKRwqR3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
Received-SPF: softfail client-ip=2a01:111:f403:2415::611;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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


On 06/03/2025 12:32, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/6/25 11:15, Maciej S. Szmigiero wrote:
>> On 6.03.2025 07:47, Avihai Horon wrote:
>>>
>>> On 05/03/2025 0:03, Maciej S. Szmigiero wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Implement the multifd device state transfer via additional per-device
>>>> thread inside save_live_complete_precopy_thread handler.
>>>>
>>>> Switch between doing the data transfer in the new handler and doing it
>>>> in the old save_state handler depending if VFIO multifd transfer is 
>>>> enabled
>>>> or not.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>   hw/vfio/migration-multifd.c   | 142 
>>>> ++++++++++++++++++++++++++++++++++
>>>>   hw/vfio/migration-multifd.h   |   6 ++
>>>>   hw/vfio/migration.c           |  22 ++++--
>>>>   hw/vfio/trace-events          |   2 +
>>>>   include/hw/vfio/vfio-common.h |   6 ++
>>>>   5 files changed, 172 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>>> index 1d81233c755f..bfb9a72fa450 100644
>>>> --- a/hw/vfio/migration-multifd.c
>>>> +++ b/hw/vfio/migration-multifd.c
>>>> @@ -496,6 +496,148 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, 
>>>> bool alloc_multifd, Error **errp)
>>>>       return true;
>>>>   }
>>>>
>>>> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
>>>> +{
>>>> +    assert(vfio_multifd_transfer_enabled(vbasedev));
>>>> +
>>>> +    /*
>>>> +     * Emit dummy NOP data on the main migration channel since the 
>>>> actual
>>>> +     * device state transfer is done via multifd channels.
>>>> +     */
>>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>> +}
>>>> +
>>>> +static bool
>>>> +vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
>>>> +                                               char *idstr,
>>>> +                                               uint32_t instance_id,
>>>> +                                               uint32_t idx,
>>>> +                                               Error **errp)
>>>> +{
>>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>>> +    g_autoptr(QEMUFile) f = NULL;
>>>> +    int ret;
>>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>>> +    size_t packet_len;
>>>> +
>>>> +    bioc = qio_channel_buffer_new(0);
>>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), 
>>>> "vfio-device-config-save");
>>>> +
>>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>>> +
>>>> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    ret = qemu_fflush(f);
>>>> +    if (ret) {
>>>> +        error_setg(errp, "%s: save config state flush failed: %d",
>>>> +                   vbasedev->name, ret);
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>>> +    packet = g_malloc0(packet_len);
>>>> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
>>>> +    packet->idx = idx;
>>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>>
>>> The packet is sent on the wire.
>>> Shouldn't we use cpu_to_be32() for version, idx and flags? Also 
>>> below in vfio_multifd_save_complete_precopy_thread().
>>> And then use be32_to_cpu() in patch #26 when receiving the packet?
>>
>> Is it even possible to migrate to a host with different endianess here?
>>
>> Also AFAIK big endian hosts barely exist today, is any of them even 
>> VFIO-capable?
>
> s390x is VFIO capable. VFIO PCI migration is not supported on these.
>
It is indeed a niche use case and not even applicable today, but if we 
want to add support for it after the release, we will have to add a 
compatibility option for older QEMUs.
If we add support for it now, then we can avoid the compatibility option.

It's a really small change and it can come even after the series is 
merged, as a fix.
So IMHO it wouldn't hurt, for completeness.

Thanks.

