Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE805C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 08:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2mvy-0008Cl-Dx; Thu, 10 Apr 2025 04:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1u2mvw-0008CU-LB
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 04:06:48 -0400
Received: from mail-bn1nam02on2049.outbound.protection.outlook.com
 ([40.107.212.49] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1u2mvu-0007oa-Hc
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 04:06:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4VuYM6cZwJnfM+Z4GYBoUjl6ghOu8kxE3RetvRs5dFMUGjH5p5gpZqRRi2pZAsTWhrDwlAQidNM59m3W+jC/sxXhkGZ3yPsKE/bfW0nX577WsS51YO5GISj+xFZpKVBh0PIYE6BE2scuGIJC5416F1jDrx7lkfs8HC3o4PHyPM6CYCaEv1yTTdas9vKV3wCvri18vYzVnVQxTJgS1kMJmYhne7iKdHOlnN/Xh5hL9mujUgmsdc7Y7JVICV6Ld1IpxO734fw3gId3C6ILNKTc1M7VYutHMaPbnnLLvOuh2//NOfSQoqdeRDZrCl4TT0vCQIJ6QKMDaI6P3Vb7QhvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDBhZ6YBrXvE/LPfFeaBM5ZJVjl8flIcS460s6G1aN0=;
 b=ithS6m9xyMXBVqudBTfs7xboVfJoxmd5L3yp4xFMBYAgFPrLyoJNeM7hiyOXso/x/Gb01TZWDExBLNZMRRQM3vnNbdt2dbruqS/QdzodFLsOZOYHEr6+A/axqh4Z4HKkeez13C9Twim6WONAkkDIfL8eE0SB60Rp40WDxmR4csRBGK2vZrGpU3vNQtFJock8V27q3Z0QXsnbhcRgcEbDtDQNFKBfvkpLUkbVfIMcM75MYwiT2p/0H1aOVO9n/t4ixGGF3UyKddvH7oQu+B2oSmB+7KuvLsBcGO7weoc5y1oN+B0gmj+Lsn1vsvHp65Vl8J9bJ+ogd+DrA23za4xDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDBhZ6YBrXvE/LPfFeaBM5ZJVjl8flIcS460s6G1aN0=;
 b=I6gvNZwkirKh7EIWnStL/R7ZDtvfir+bxTsKcf0Js4KsvNwkBnutakNrS8OE2jxB6qgSxsugMUD7/E75i9hTeIUt6dZ4F0vVHdD3N47Dh6z9s49PPBq6l9CxbE2/6om7mDaPPsGltoVLtOieUHQH80D2wOvnlmGBi/JX2zLVGIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Thu, 10 Apr
 2025 08:01:38 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%7]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 08:01:38 +0000
Message-ID: <34d03ba7-6049-492e-ad9f-dcf01bef1870@amd.com>
Date: Thu, 10 Apr 2025 13:31:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i386/amd_iommu: Fix device setup failure when PT
 is on.
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, philmd@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250410064447.29583-1-sarunkod@amd.com>
 <20250410064447.29583-2-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250410064447.29583-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::7) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f740c57-adb2-4724-d15c-08dd7805eb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0d3VC80VUlld2NUTnVSZnlDRnp4YXlXWFZQQit1akR4QytyZVR4NXhNZjFp?=
 =?utf-8?B?dHJ6K2NGbzAwWldSei90UEVoQnFvT2R4WjAzRVIzNEVHMXlGSzVpODkxeU5L?=
 =?utf-8?B?WlV5aHA3OFl4S3RKb2E0M281cmV5cW5NZ1lYamtMK1pibk1NaDlRRU1jZzR6?=
 =?utf-8?B?TDdCeVR3WE9vdHdNTHVybFZ1ektIcGVlWk1DaC93Q1MyWkdJaTVSZVlRbDNs?=
 =?utf-8?B?WUI1YUVXbkwxUkNxRzBlOE90RlNJNUM3QzloM2t2VVNvWnRKUm5MY1dubHcw?=
 =?utf-8?B?RDZ0RUdudi9qQTFIbXFrai9ZSXBTUTREQVRHYUc4R1hRbHQ4VGJ0OWthMTFx?=
 =?utf-8?B?NmxZWVZDTmFSblp1NWpSb1drSXl2QlFBQjVIZUhvRTFDdjUwcVBnOVM1TGtR?=
 =?utf-8?B?ckViVnIxREY4OVEwbmgvWHBrK0ZiVUR2TDRxTmFnSjU5eEV4VkRJUW1wb1RK?=
 =?utf-8?B?THV0N1VGOHpsK0VENUNWd3I0Mncxd0J5bmRNL2VlcHltTzI0Nk1qc0t2eFM5?=
 =?utf-8?B?VUZlcmd5WUg4dmRrY0tWQWgzbC9Ra2FIKzhsYnRxYU83MEtlUzdsc0tZMCts?=
 =?utf-8?B?dFJWcWx2U0lYb1c4Y3g0bHFIVnpXdFRqN2tlVGplakhDSTF3TW5qa3FsODBk?=
 =?utf-8?B?cUhXdVhYOU1iL2dLRlo2MWJ0SThnUUNoVEtMb1ptTXRpRGZOaWRLckkwSDl2?=
 =?utf-8?B?bHBDTVVIRk92QXdhSGMxU3hQU1IvdDF4VnpGdHppaCt5QW9uZCt5WnJUOWVU?=
 =?utf-8?B?TklrUS9FMkdSOEhWMEhCM000dFJFL3cyNWwyanhJQU9BZDN1SDliRlY0cC9i?=
 =?utf-8?B?MFRPVGdrNDJOTSs5aDJHS0tnVU9vaGo0SnBTNGR1dmZOSVorc1Y5cWV2RWpU?=
 =?utf-8?B?aWFleUxRZ1EzTVlMUXJtMU5rN1Q3dGRLMURmSklxbUFZRTFxMWNWNytBM3NP?=
 =?utf-8?B?VUYwV2ZiWWlvajVYSndoMklQME5DWVNGVEd5SlU2RGY4ZmJYNTAzUFo4MTdy?=
 =?utf-8?B?ZFkyUU14ckxJOEZidHJ3Q0hIaGZRU3IrR0dENDRCa3JlY1AyTnpUNWw0ZUFp?=
 =?utf-8?B?Unl4cnVteXVJck90akU1S2VKeEx3eUFMMXE3NFMwSVhlRDR3MFFiZVVOY3h0?=
 =?utf-8?B?bTc4MFV5ZlRyWWtqS0ZWY2hXUXBHenRTRXpsYjBHWnhXWDNPeDF0VHZZL0cv?=
 =?utf-8?B?cngvUkNRTUhiaVBOQ015V1pqUnZmS1UzUWI3SnVMN0p6UmNZQyt2dk9ORTBV?=
 =?utf-8?B?NmY1QndKSTJhZGRGeGtmNXdra3J0UVlVakx0ZDVmTGFHOWJoUnpXd01INWRM?=
 =?utf-8?B?VG1Xa1RTSVRRWnRqVU8zaGZpVjJCWmlQZElUZit5dHRiNjBUVGNXZTZnZEU3?=
 =?utf-8?B?V1FmOXlBUmNDWndjNFF4VzdodzZCT3JiUVZRUG5ZUEUzTi9NeW5HcFlOM0x5?=
 =?utf-8?B?Y0dNSCtRZDRmWnVkdWNPVTRqVU1BUUo2Q1dlcitnTFhZd1kwWWt3UklUcjlN?=
 =?utf-8?B?MEkrRmY3YXV3VWxncmZiUlJoS1ZkM3JnZ3RmZ3lCRk1YVUFtODRaS3hvUXNP?=
 =?utf-8?B?MVg5K0w4SDcxZm94cmE2MUFkZWhvcWRHRno5em0vOGhXUjNTbFcrN1lsSU96?=
 =?utf-8?B?VUpHS2pBK1cwVHRmWGc0WjR6dy82OVMwejZyTkdFWGtPMUNHOVoxZkxXUm4z?=
 =?utf-8?B?RW1UQmdyQXdveUpIZ1laSEJubCtrTVVPbXpneS94TERwaGpReEVLRXlGc1Vj?=
 =?utf-8?B?NXB5UWhVUUlCVzFYRTNNcEZVdzB3T1BOWlZIV0N6L0pnNW9kdEk2K3JkdE9z?=
 =?utf-8?B?a3ZFeWxPMkRKWDlQMVlFaFhoTHl3bmNocDlxRC91V3FxbCtPc01GSXNzVlli?=
 =?utf-8?Q?iTLhDhV3lRa9B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6043.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1IVk9DWWZQNGZnakRVWktYV2NEeTlzd0ZvR1paZVFGeCtYSVZzYUpzWVNo?=
 =?utf-8?B?Smx0ckhpWmNvNE1sZ2loL1ZjM2JtVmtNVEx6ZWdOUUZJdlYzYUQ4UkhNZ2FU?=
 =?utf-8?B?N3ZlRmZLMWdiZWowNFVmVStVV3dDU0xMaU1RdEt6ajVKdDMxWm1uR2c3WjVh?=
 =?utf-8?B?UWZzYm9FR0lWSG56ZnNmd2RsZ3BiMHU0MkIzeWZZVnJRc0NXWUtsdDh2clc2?=
 =?utf-8?B?TFQwOHQzQkVvSDBsOTdKV1FrZExHQWVVU2tURlEveVRWN0NlVm53Q05RQ0g4?=
 =?utf-8?B?UDhQa3cwWDh4K1Q4TU1xWW15amkyc0ZQTzdUZ2VsTlRMM0dOVmdKOU9QSEFK?=
 =?utf-8?B?YWl3ZlJXblY1ZUJDWDdlMXFJMGJrMzFsa3pSc09mVjk4Uy91SERlVzYwbmFm?=
 =?utf-8?B?N1FEdmFZc09sUkE1SXJIdndmMGYreWNVak16NThjd2o5MWtsbE9GMVFtZldp?=
 =?utf-8?B?N09hbDJINmUxZVJjazhHcEtFWW5jdUlNaFV4a21STG1TcWtKY3BiL1U1cWFN?=
 =?utf-8?B?Tnk3VlBqdlVCMmZTNnlQUUc0MVhpSTBjYjNNM0R6bUtKSWVzNFRMUHVUK00v?=
 =?utf-8?B?MTBJVlJnM3ZUMTRmcmZlMnp2anZBZnA3YlJ4QVJFWGlvNVVmWGwrYmlCZUpj?=
 =?utf-8?B?T29CcU42MWpWSk0reHRQdGhvcStzL1BFN2VBQWRuZlZTRVFRbGVaMnIxRUVD?=
 =?utf-8?B?OXhmVTZtcFhqQkQvSlpkd2k0OG9ZT0g3QkR3cXlIYjEvWXlwWUdwMDNUd2h2?=
 =?utf-8?B?cmNsajl0SWhlWnFHRjJmNkJWeHc0M0RFQmlQVXhKeDhiS2YrOXZsYmI2RTlZ?=
 =?utf-8?B?d1B1LzhDMWYvTWt2S1pLZDl1dS9aVlpJaXFNYkdlK3k3c0R0V2VOY2QvNC9C?=
 =?utf-8?B?dmVTU3ZUekxkS0NXSzhsOE9MWXdMYXkvUUNHSHpiNlRFcEViUnlJdzgzNE1u?=
 =?utf-8?B?aXo4MkNaQ2ZsWjV1eWVKZGVMMVNrL2tGV0pwV1AySG9UaWFrZlVtbzN6d3g4?=
 =?utf-8?B?MDZBdzlpWDRyQ1JyZEhzR0N1bDZMc2xVcStOMGVPK3Z0bUNFcTB4eVNuaDVR?=
 =?utf-8?B?NFJCbmErUHdYdkpQRXNoWE1RUi9vcXpJMnUyTCt6bTZqcW9vM0FFb3U0b1Jr?=
 =?utf-8?B?NVJXYmpSY1dPVXlPQnI1cXVYTnRiVVcvcnBlRTN3Mml5NXBUQ1NidFFOcHpz?=
 =?utf-8?B?aTZMV1p4WXJrd0FLd2p4VXJlVFViUitjVkpIS2tCU3hoL0c2QlJpNGE4M0FO?=
 =?utf-8?B?SVZtT2hxcEgvaGEzbW9rK2pVTmJQLzdRYzd1UzNqeWRma0t5WG5PTFJVVmF2?=
 =?utf-8?B?VmcvWklIdUpJb3hPUlpYU0pOcFo0am0wa3M5V1ZhS25rY2oyajBvbk4yTXJM?=
 =?utf-8?B?ZU1TWlo3bzB3UGt3RUJnUkFpU3dDQy80QUVSQkNVNWRMQVFpTTlnandZdHlW?=
 =?utf-8?B?VDlBMkNkekthbVNUbWxCUHBKc0k4R2pjTjYxbUlUUDl3K2ZGZFM1bHF6Sm9o?=
 =?utf-8?B?enppVTc0UEE1Wm5qeDFTR1FpVDlUMTF5c0pzbzVmT05EY2hpbEh0Q3RlS0F5?=
 =?utf-8?B?U1lwNDJpanZOejNNSkZSYmFza2diVlhvSUI2SitJend3Y3dpbVFxOWhOemlU?=
 =?utf-8?B?cGFJcE1NY2Z2ZzFteDJwS0hVUisycGFXak02enJhNk9QWVF5Uml5WVk3TXpq?=
 =?utf-8?B?N3lPZVdvckVNaEhoMDFvd3puaUt5YnRhWFF1VVRTcG4wbklTNkttaDltYjRO?=
 =?utf-8?B?ZTlYUXdycFk3cVkyeUwyT3dkV0QvNk5kZiszYmV1cVlsekszOUZLT0ZYQkRY?=
 =?utf-8?B?VlZFdGtaMEJGVkZGMXMwV2tkSjhxcmRWSGtFdnJ3NHpQS1UzbEhHb2ZDNjd6?=
 =?utf-8?B?YjVaYSsrek45NThHVzBFeDZTWVIwaFRuTkhTempZdGZPVGQvSnB2aHI4aTBB?=
 =?utf-8?B?NWZmOHlDQ2dkdWxub2hwTkxJMXdOR0FjeElrQjJDVTB4SnJMaFYwSjFlQjNi?=
 =?utf-8?B?cWtFdnMxRW9IZXc3d2QyQitlQldDMmdHayt4a3JHK3JxVDhIN3hhbVlVOXpD?=
 =?utf-8?B?dm13V1RmUUNEZFJuWUxna1Y5UE5wckxLWWdwRzNwVUxxakVKYzJlOEh5UE53?=
 =?utf-8?Q?71pPUUgVkbH0dc5/3r816R9QH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f740c57-adb2-4724-d15c-08dd7805eb7f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:01:38.1032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uD6RfKcUoatZe3mvmFZ2+dcjvDKaZ0MucJnUHUOGCRornEC/PyLpkF0vkjaDI6g7LXrLj4keKWm+76j8PDGb6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
Received-SPF: permerror client-ip=40.107.212.49;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


+ Michael,

On 4/10/2025 12:14 PM, Sairaj Kodilkar wrote:
> Current amd_iommu enables the iommu_nodma address space when pt_supported
> flag is on. This causes device to bypass the IOMMU and use untranslated
> address to perform DMA when guest kernel uses DMA mode, resulting in
> failure to setup the devices in the guest.
> 
> Fix the issue by removing pt_supported check and disabling nodma memory
> region. Adding pt_supported requires additional changes and we will look
> into it later.
> 
> Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



