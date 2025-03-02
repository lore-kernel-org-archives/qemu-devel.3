Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD7EC282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 13:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toj7l-000620-BC; Sun, 02 Mar 2025 08:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1toj7k-0005zG-7Z
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 08:12:52 -0500
Received: from mail-dm6nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1toj7h-0003bQ-9U
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 08:12:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIMP9xBmc2yxj6UaMaPV3T7jpJP7f3YJ+NnHIzQaYHRILc4AMi5hDQtu+DEFPXUKxMDkPz3KJkNQrygjkVlCIDgM3Cl8nzn4wOiMeS1zZx1YlutQMgUGRi0D1CgL7U399g56yF0FTw21ymx7PRMaVziU8FRDbUml+Q47lf571vhpbjI7l4IJcqqR6mh5Nyh6QV8rlL0epXZeBCrDBa10/RCV4DM4UEjK9n5+6Vo2F8ZyEUbEdCBrLBH1FxP/nMJKnm0jKVJzdIavKjH0MGOP4TGWPUyHBelxjgpXSLKD1ZFBNBtKudNkbOiVfrw5Kj5o2C5sOrzSUoupL4sLFU5aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ficGKJsKdw2O/dCMV3JAZph24YxBxi3rg0rEtdhBE0E=;
 b=JB58BDfJCcV5uBDKKRpR3N2Aqf+jDX9BIHal7pQxU7oFVFr0GLj//KD0zjWr2oSPrItU57HGbxEqf8MuMobLZEtwsGjW6T4sPVi3ZHYAZ4P9VPf8mNF5s10pAoRFzoj2Sfi6BjG89hA34/fVXqpScRMh2bB7xxv0n4sHhBrlX25BhpOvGexG1SSKvt7+X9ThbDkI8wqrcX8R4H60SZBKEzUxO/SF3YZ4crjMvYYOHWjiRiWeKgTsKkbrWHRoIo178LGhlzvIVGDsaXv1Nv9lRW0YTsWDADb2mBhYiF30XtESZrLa9i7sgp7nEs2h3rSEWcSL6/GeMqW5e91AWD2Log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ficGKJsKdw2O/dCMV3JAZph24YxBxi3rg0rEtdhBE0E=;
 b=Zu7OlwTTs8PeTqWk+YAtCFpdCky+HF6XtezhB+PR1KBres0U10Hwq0ekuYs3W+B4cszpvnNLHsFeEsuIXCv/iPMhnbyHm9l7U6elTk+DZyw+gFVm96q4AQiOHRteP3XS8L2lb/kARrPmh+CTAI+7gfjbyjfOKODXcjVf/19Kk4NFkUNw1/wihsBTJM9DXyhhtAvAJqUQReRL3oEedKP+2YYR+EDUpAFZqPPWn+jS6sLdTKgPcOxJahpmDG+42aWamfdNYHTguszXbTtAMtl2IM4R8VKVe+p37VQ4BAPyEY5yMSZKPVT7LM9tlGOWH60C3vhoxS2wI/gG9MJ2w6PvJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sun, 2 Mar 2025 13:12:44 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 13:12:44 +0000
Message-ID: <a2134c3e-0dc8-4f74-9e82-ecd2abe1a390@nvidia.com>
Date: Sun, 2 Mar 2025 15:12:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 26/36] vfio/migration: Multifd device state transfer
 support - received buffers queuing
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <4de9762ebf7e7857103eb276d1a26a092aee325d.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4de9762ebf7e7857103eb276d1a26a092aee325d.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6c3a19-8000-4687-5561-08dd598beb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzBJcDhDd2pvcmFWQWwzZmJEaXV6aUh2dmwycDUyY09SZnI5aG5EdmJUb25P?=
 =?utf-8?B?UWlrN1o2NlhCMEptclRpVzdyTEFPLzlIUWRqWkprUFpieDAzNkh0YktOTlFV?=
 =?utf-8?B?amlseS9BRVZyV1dlcHpDcFpzKzFEd0g2ZlJUdG1XWGZBckFRclRxOEdJTy92?=
 =?utf-8?B?UGZheGxnMUFiaWFHdWYxZklJTmVueEtNNnY1eWRoYm10Tjd6Uk9ybEFyVEJh?=
 =?utf-8?B?Nkx2WEJNdE9Pc2wwczRWUVp0WTBKdDVObWtSWW1kbThPOGM2WTY3MkozTU5q?=
 =?utf-8?B?YzJxQVpoNEFjL3lxdk8zdDlOcUdTdVRLS0NUd2hkYlhwbnZVOTJzVUdBeml3?=
 =?utf-8?B?S3FTYzZLaWxleUhnd3hOVWFORHBNRytQSVJNTHZacytKVkZPa3c4Rm1oTkpB?=
 =?utf-8?B?R0pmQ3VxSTA1ZUN1K0MxWTBnSWhSclRLMDh6cnNWUDZkWEtuVnBVS2QxRDB2?=
 =?utf-8?B?S3luZVlKcGtPN2xGMi9KWktpMkNnbFJvZGt2eTNGZXV0SSsydW04SzgvQW9M?=
 =?utf-8?B?TEZsWFhGU0tFdTRGQ05Dc3pITUY3cHRGV2VId2V3OUhrNnorNldFSlFLWGtn?=
 =?utf-8?B?MSs2TUJxYXp0WXRhdnp4ZE5yS3NHRUQyTHpKbFB0WHBZdUZ1blRmeUN4WUVE?=
 =?utf-8?B?SGhYL0RSOVU5V2VramdPL2R1SHZDN21WRjBJeUFXQWcxcU95S1lqb0IzOWZL?=
 =?utf-8?B?NmIvRDVMZUhNZ1gvN2R3MHZnOE1oUVd0dnBpbHFIUlZqK0t0L3J4VzBqcDBM?=
 =?utf-8?B?aTFaQXNDalRFeGRRVXhxa3NsN093UnR4RklXZlcyMkJ5R0UwMlFTUmRqMllR?=
 =?utf-8?B?Q21kekVkbHd2MWU3dFFXUG5oUjZ1OEhSSDAvM0N5RVY5MWJJYkMrUjRzS0V0?=
 =?utf-8?B?c2RHWmUwVy9HTU5mYzhiTmRVSTJQRGxMQWM0aE84Qi9vRitUbDBseHhlUjZP?=
 =?utf-8?B?LzZxUXRVbm5PdldNSXE0VTRMYTZIVldwbEZGL1B2RlhjdTluVTFIMEk3SXhW?=
 =?utf-8?B?bFRnQWFZUS8rQWUvVXJob05MaFpiTHZrTGRYS3VSTHhiODJUNkhlcWRFclBx?=
 =?utf-8?B?WlNQSEo5RzJwTTUwVnB4T0ZMSUYvcm5EYUxvSzcySUhJN0pSMUlqTkxkN1Nr?=
 =?utf-8?B?bUdISVE2YysrMWFVd0xNZHFaeGUzeEJrSnFoQ1FxWmQ1OU9hL2E2VStqZW8v?=
 =?utf-8?B?UTFGenlPQUxSM3hiajBxS1ZxcE9EUTBxZnR6UGJCMkVqNm1uWWYrVGhQcVZv?=
 =?utf-8?B?MW0yYTVLZ2pZbXNJNkVldkN1b1BIK3l3UjJRaFRueVdyZ1ZaUWVOZjFQWlFa?=
 =?utf-8?B?Z0s1d0NzZ0lVeUNZU3R1TzJzeUFhcG41MEJWNzRvS3ROTDFieHYxNTUrWDFB?=
 =?utf-8?B?VlF5NndRRnJHdlJBc1kvVE9LT05HTk9pK0R2am1tTnZ3bW0zSjBkUlU1SzUw?=
 =?utf-8?B?L1BuaS9sa1pZZjc2ekV4ZlJ0bDdWZkdueDFNbHluQk16SjNHLzl0c09LOWtZ?=
 =?utf-8?B?WWpISytxSU44QlFSLzBhU0tYbEsvOXFDSTRtZzNOcFl0RjVpWDZhWmROcEpE?=
 =?utf-8?B?S3BPZnUycWVHblpEMmNSeUVZWmtqOHQyMmVOUS9PbWxDSTBFdk40ZUhsR0NR?=
 =?utf-8?B?Q2R4R1lLcWwxcWNHWXlBcXAycS9kL1hCMTNmWmVhNC8zMjJJSHVVWWM4M1A3?=
 =?utf-8?B?cVBLYVBxblVOWHZONUR4VEgxNWZGOFlKb09nTnNULzQ3S25Lanp0bC9McEk1?=
 =?utf-8?B?d0k4NUxaakpzUXNKMk5OWGxmSFgwaW9CVlo1N2FSMVcxYkpXSXVqNjRsZWpO?=
 =?utf-8?B?QnFDN2tjbkpITzlBOVZHVzBuUzZwN3U1c0lWK0FUSU5Ec2dBWHpkMkVBbFB5?=
 =?utf-8?Q?r6No4SOiQgkhJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJJUmNVSnlQNG9ieE1DRDdFK0VYbjhSRU1xY1NvTm4vbjBpZHdEUmNpQ0Vj?=
 =?utf-8?B?cXlCa2NTZjRJR3hsakVMWFF3WDJoUkFtenJGZUcrSE92ZzhLZnFkREZsbU84?=
 =?utf-8?B?S0JzRHdUaDZIdXFvN2tGaXArV2tTdzJ2UXVoS3VQTHB1YVhtMVd2eUZnbUlz?=
 =?utf-8?B?ZFVZUVNBRkppQ3p1LzliUmJlbnBHS0VyOUliOUlZcXVpUjZieHdaTThrczV0?=
 =?utf-8?B?ZXlZNUNEVTRKR0VQRGg1dEdvY1NQcjFWUGZSL0lYQzZEeHJWV3lNT2xJeTJW?=
 =?utf-8?B?Z3dDbitwVE96QWsxZGkwZ1IzeHl3UjhMUjMyeGhGTHZ2SGQyMTBudjh0akFX?=
 =?utf-8?B?RG5hWVZzcjMzSStrMHU3Q3hERUt2TVlBNXFzeE9yckZBYU9QYnNFZitLdTMw?=
 =?utf-8?B?anNja2NVbzhJWnRSbFpqcUxQU1I2aDlYRUNSendRMjBtVkxHQzdiMkJrd29M?=
 =?utf-8?B?c0JOM1M5ek1IVk5ma092bzlTak1Eczg4M1lvWmlHWjQyVklPWWlLK2hBZ1By?=
 =?utf-8?B?VFNrSmZnM1g4K3pSTkk5VGcvdUFuSDlKdDY3RGdNZUxXZDdYbFpNMkYwOEQz?=
 =?utf-8?B?dW9DWGdOQ0RvNHlHeHhZQ0ZpbjBNWU9sQjh0UlJZb3ZVSEQ2U05va0dQd0Q1?=
 =?utf-8?B?ZXdCblUyQzM5RnBrbDVRZUdQWGdabUhnalFnVUk1TDZzRUFPSGVqaG5nMUR3?=
 =?utf-8?B?ZUNHK2ROc0YxcFJQWkg0VUxmdVRWVGpuUHJkM0RGMC9UVkxoK3EvRnNQTWdV?=
 =?utf-8?B?aS8wRHd3dXhiZkRDZUx1K0ttUDRxWGVuNU5VLzB6VFNTWndzenVNcEprbk9Z?=
 =?utf-8?B?MFlCbklYQnlzUlhJNkJCS3oxU2IrYU50Snp6TmdHeWZ2a2RmeDNnOW5FVzNs?=
 =?utf-8?B?a2tjME9WQSsxOVhURCtHaUw1V3h2Q3V0QVBERnAwTXNYMUQwTlNTQjRUOUIy?=
 =?utf-8?B?RXZUb3NZUmRWVE0yMitoLzR0SW14T0dGK1pSNUVVell0YUYvbkZyQ3pmd2M1?=
 =?utf-8?B?UmVGZUFlMDZLMWhRWGVrV0wwcm8wU1B2OW96S2NUUi9IOTFIU081VWkvcG42?=
 =?utf-8?B?ZmFRVXI3T2JMajNoVC9VTTN1N1RVWU1ZbWVVa1prS0lwV2h6VVI5NXQvKzA4?=
 =?utf-8?B?VWxDa0F1KzVjZ2lQZ0E2WmhDbGhCRzduN21kVUcyWkZnZVVFd1h4WnJuVGVT?=
 =?utf-8?B?ZERYMFdueUlEYWk2THNSTUJIQ3JkRkhtRFdmMDBEKzFMQTc2SlhHcWQyTmRX?=
 =?utf-8?B?SEFBeDR5VVBmY2lXZHNmajI4SkhCNWRNUjFNOW8wdmo1K2l0U2IxclgvZmx1?=
 =?utf-8?B?YWRtWHlPalc1bFhrU25ka25VL3hESk1YeXB4WTdOTTFZanZIYTNnVXJQWFU0?=
 =?utf-8?B?UXdBWko0dHRqc1ZKWkJXNnhKTDJidzc1MXFmc0VJR0k0ZUdLMUFZT0Iwcyta?=
 =?utf-8?B?ZGFueHN4c0t4VzdEWU84aklRZkJGMWdHMGozTlRxL0EzQ0M2U2JLcTZXN1BT?=
 =?utf-8?B?bWtJcTJ1S1l1TjRnckVkNjgyL29mdEd4Q3VTaEMwMzhqbnA4RTZnalRXK3JU?=
 =?utf-8?B?THVnT1VLcW5yZjl4NGdSdjZLaFh0UWp4TkUvM1RYSXlEK0hLcGVtSGxKS01Y?=
 =?utf-8?B?QnYvYU8wMVZEOTFVTklBKy9YVVJKVVBLd1ZrUUV4S0RQVTFmMU5rdHZMcDli?=
 =?utf-8?B?VFZpd3NObmFRSE1XbVBQUkFnNWhuRDJRU29ZYW9paktsSVV1ODVrQjJVWXJT?=
 =?utf-8?B?cGc1WW42YmM2RDBsZ05ldVU4UlRSY2F4NGQ5RnpYQnZuS2FKZlgrT29HYXp4?=
 =?utf-8?B?ZTUvWnpiQnpXbmZvWVduWUc5MzA2ZkgvSThtamxVNktxekZzd0g0Z2lUakhM?=
 =?utf-8?B?OHFPK25iRWlUbEc2QkdYcE03eXkvUUV1Y2VxUElEcXJsS2tydDFCV0hqU0VC?=
 =?utf-8?B?bFI0SllxWU1vbmlXVGJuSklRRFl5c0hUWGgzWE1MSlhvcUJCOG15d2ZFemgz?=
 =?utf-8?B?RElWbzU0SG04aVZjQnNHSW5Rbm9lL04rVUhCcFFNOVMzVm10TUp5aVhMbFlS?=
 =?utf-8?B?ZGtJelo1Q0NTYjlzTHdNZEJkekhZcWgzTENkbDRmaE1lcURnOVRSbVVMNWN0?=
 =?utf-8?Q?KU45P3CPns9S+6tJB26cwQKDo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6c3a19-8000-4687-5561-08dd598beb45
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 13:12:44.1254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lja8C3BAZL+iVjS/rgRYKrHNXKhodiSjnEd6KZbQokW0fFD1h8bU0pwrLnW9QV+L3M+kVmxhkEnEcU+ehe6yhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
Received-SPF: softfail client-ip=2a01:111:f403:2413::60a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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


On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> The multifd received data needs to be reassembled since device state
> packets sent via different multifd channels can arrive out-of-order.
>
> Therefore, each VFIO device state packet carries a header indicating its
> position in the stream.
> The raw device state data is saved into a VFIOStateBuffer for later
> in-order loading into the device.
>
> The last such VFIO device state packet should have
> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c | 103 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h |   3 ++
>   hw/vfio/migration.c         |   1 +
>   hw/vfio/trace-events        |   1 +
>   4 files changed, 108 insertions(+)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index c2defc0efef0..5d5ee1393674 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -42,6 +42,11 @@ typedef struct VFIOStateBuffer {
>   } VFIOStateBuffer;
>
>   typedef struct VFIOMultifd {
> +    VFIOStateBuffers load_bufs;
> +    QemuCond load_bufs_buffer_ready_cond;
> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
> +    uint32_t load_buf_idx;
> +    uint32_t load_buf_idx_last;
>   } VFIOMultifd;
>
>   static void vfio_state_buffer_clear(gpointer data)
> @@ -87,15 +92,113 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>       return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>   }
>
> +static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
> +                                          VFIODeviceStatePacket *packet,
> +                                          size_t packet_total_size,
> +                                          Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIOStateBuffer *lb;
> +
> +    vfio_state_buffers_assert_init(&multifd->load_bufs);
> +    if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
> +        vfio_state_buffers_size_set(&multifd->load_bufs, packet->idx + 1);
> +    }
> +
> +    lb = vfio_state_buffers_at(&multifd->load_bufs, packet->idx);
> +    if (lb->is_present) {
> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
> +                   packet->idx);

Let's add vbasedev->name to the error message so we know which device 
caused the error.

> +        return false;
> +    }
> +
> +    assert(packet->idx >= multifd->load_buf_idx);
> +
> +    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
> +    lb->len = packet_total_size - sizeof(*packet);
> +    lb->is_present = true;
> +
> +    return true;
> +}
> +
> +bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                            Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
> +
> +    /*
> +     * Holding BQL here would violate the lock order and can cause
> +     * a deadlock once we attempt to lock load_bufs_mutex below.
> +     */
> +    assert(!bql_locked());

To be clearer, I'd move the assert down to be just above 
"QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);".

> +
> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
> +        error_setg(errp,
> +                   "got device state packet but not doing multifd transfer");

Let's add vbasedev->name to the error message so we know which device 
caused the error.

> +        return false;
> +    }
> +
> +    assert(multifd);
> +
> +    if (data_size < sizeof(*packet)) {
> +        error_setg(errp, "packet too short at %zu (min is %zu)",
> +                   data_size, sizeof(*packet));

Ditto.

> +        return false;
> +    }
> +
> +    if (packet->version != VFIO_DEVICE_STATE_PACKET_VER_CURRENT) {
> +        error_setg(errp, "packet has unknown version %" PRIu32,
> +                   packet->version);

Ditto.

> +        return false;
> +    }
> +
> +    if (packet->idx == UINT32_MAX) {
> +        error_setg(errp, "packet has too high idx");

Ditto.

> +        return false;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
> +
> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
> +
> +    /* config state packet should be the last one in the stream */
> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
> +        multifd->load_buf_idx_last = packet->idx;
> +    }
> +
> +    if (!vfio_load_state_buffer_insert(vbasedev, packet, data_size, errp)) {
> +        return false;
> +    }
> +
> +    qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
> +
> +    return true;
> +}
> +
>   VFIOMultifd *vfio_multifd_new(void)
>   {
>       VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>
> +    vfio_state_buffers_init(&multifd->load_bufs);
> +
> +    qemu_mutex_init(&multifd->load_bufs_mutex);

Nit: move qemu_mutex_init() just above qemu_cond_init()?

Thanks.

> +
> +    multifd->load_buf_idx = 0;
> +    multifd->load_buf_idx_last = UINT32_MAX;
> +    qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
> +
>       return multifd;
>   }
>
>   void vfio_multifd_free(VFIOMultifd *multifd)
>   {
> +    qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
> +    qemu_mutex_destroy(&multifd->load_bufs_mutex);
> +
>       g_free(multifd);
>   }
>
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index 1eefba3b2eed..d5ab7d6f85f5 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -22,4 +22,7 @@ bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>
>   bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
>
> +bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                            Error **errp);
> +
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 4311de763885..abaf4d08d4a9 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -806,6 +806,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
>       .load_state = vfio_load_state,
> +    .load_state_buffer = vfio_load_state_buffer,
>       .switchover_ack_needed = vfio_switchover_ack_needed,
>   };
>
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1bebe9877d88..042a3dc54a33 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -153,6 +153,7 @@ vfio_load_device_config_state_start(const char *name) " (%s)"
>   vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
> +vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"

