Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE7FC02193
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 02:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfVPu-0002RO-KR; Tue, 04 Feb 2025 21:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tfVPm-0002Qk-Ap
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 21:45:23 -0500
Received: from mail-dm6nam11on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2415::619]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tfVPj-0007fC-Vf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 21:45:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8H5FyZkME//eE4Yc09WMIx07mxC3iTXBexK7hcJyiwepUkii3Ycba1Pz1cOPDnTDc3i7rc116G4ZswqkqtqtsOWGIMtmnYMnV2CaiZAK/h8sBR0+PFmX1nJcB4a1fovksn4CUMpUAhfnZWSthnnE9c5lL01ke5J3JN9QxP8ZA1SBONjCxu/NapSBpjouRk2l0K5F32h/VZsqAsyrKrkstCKCFQDsGU6JJX40vCgL0jAVzT4ag8uQeyQ1+kH82X3ozyEPJzW+ZQbVRSxDubprO5Ivm5/ZohxV/5wj16ROlmRML+6KKzji9I6mJUQ3q1l/OhbOVnN/l70ewNMMzvXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF7FOg0PKQrWqxn0/qfAkWxo0VgrtyFeH1SIi/S+wsE=;
 b=FJLqauV1k2IphMBffL8B8X4zo5ovZbyUdK42l2cdeWzJJ5ArCytOvJ5E8bwyiboyZ6xBMqw0iXXvcYo6rfOj7/+wuGszI9o8Ebn53KGLuEZBq49m0HrrFxhzp9nZ1vu/6sQdlh5WOexCg9GpMCR0cGWDeBiCGWYiGeLyAc9Q6/LWbWflveT7f0P4muoVXuxVA6qjUS/WD2BIENbmfOx5UYyMFzcMrfWbtYpOnVdxN+Rc4Iag3D8TE0UBpQp70oA26jwdE+vyQp00ovPhHxC8AO8JAa+Z7tncD+QomKg0BQ31w8HER1d6xLA9r4N/hXiNFnwcEZAL+dCgj+a4cOBXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF7FOg0PKQrWqxn0/qfAkWxo0VgrtyFeH1SIi/S+wsE=;
 b=uSgPOYJRK5C5LfiwhI+z2MttTUHYg7nDIpyi1EZP6BKnE9zBfeiPOB0tbwFd+bLPaZGJIb0dnzYA4BgugJNVSZICUpmH6uni2t4zfx7CqrU2ouNlnfqdEj60X3M9aPh3aWU9myQo1Pn8b3WNMFvsZ3EQgP+vxgw8NIRCjR+JXrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Wed, 5 Feb 2025 02:45:13 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.8377.009; Wed, 5 Feb 2025
 02:45:13 +0000
Message-ID: <e3cd0f2b-639e-4383-81a7-06a227d0db28@amd.com>
Date: Wed, 5 Feb 2025 09:45:06 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/amd_iommu: Allow migration
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, Ruihui.Dian@amd.com,
 bsd@redhat.com, berrange@redhat.com
References: <20241120073114.20774-1-suravee.suthikulpanit@amd.com>
 <cae2e18a-a090-4bdc-b3b9-cf72393436b0@oracle.com>
 <b2c19675-ba87-499b-aff6-f946d5d25eb8@oracle.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <b2c19675-ba87-499b-aff6-f946d5d25eb8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 43442bc9-17ca-4e9d-9cdc-08dd458f1d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVZ2MzdpMmtSaXpKUzdJTHo1d0o0UlUyWk1qOHd2TmpMdjFDWjdEMDR0cHA1?=
 =?utf-8?B?TzJkd3dCMlY3Z3diMGNHeGtlSnByMkltbWxOTFkwMkpEQi9FY0h2Z0xqRSti?=
 =?utf-8?B?UnU0UzRreWtYcUpEbC9wWFd3aVRSZ3J2THJ6L1h0VnlCYnVFUW9lcnd5bksy?=
 =?utf-8?B?T3lFT1d0dk5FSWEvY3I2akxEWmg1c1hTam1YbTB5a2hubGZCYlNCV0lnK1Jz?=
 =?utf-8?B?Y1VSUTNMeDF4KzlxTlhWSDYzS3JuMGw4SXd3YldsQTZUckFqd2l1RlFuTGRJ?=
 =?utf-8?B?WFlqZ0Z0RkNsS0lhOWszWlNmM291cXV6cENzY1FLRFZTVEQ4R2tiaHpwMmU4?=
 =?utf-8?B?aXNXOFU3RFFRS2ZjeFhTK2E5b2htbndSOWV1c2g5aHJpU2d1ZTZzTmU3OWU1?=
 =?utf-8?B?OFR6UnFLKzM1dHBuNFJheExlVHpGOWlIRnM3WlJRQkJpeHBMR3ZwdWw0bWxM?=
 =?utf-8?B?MysxVHdxaVhxYzRDTGZTMUV1UTFNaG9mK3FzTFJ6VkZ1US9WSWlubXppNEtC?=
 =?utf-8?B?d2hKK1ZtaCtCZkFSUnVRdVNHZlJES20xM2xMcDc1SWFLd2tVZTFkc2NFaFNQ?=
 =?utf-8?B?SDg4UzFOMUJ5RTh1NTN0SDlpaTFDWmVEbmZCanVBMHVHb3ExVFhCMkVab0l5?=
 =?utf-8?B?U1ZFR3V2d1pwNWpIU1orb3BHYmdQS01OYU9ONVk2Y1FSbUU5N3RwOEFIUXlQ?=
 =?utf-8?B?SVc5QnpWN1FYZ1ZkQk8xcU1tNjd4Q2lNV3RnTDU3RVFIcGt2QjVDV1FDblJh?=
 =?utf-8?B?dE1SSGZTOUNsOFczT21kODM4K0tEK2ZxRFF5dk93d0NpNm1UeDVuY3Y4QWNF?=
 =?utf-8?B?WldIZitnbU9OQzZ1R0FyRGdmLzFIbDdaajVSUUU4azFITGNpZXQ3Y01IWGxv?=
 =?utf-8?B?bWxPNCtIVEw5RFdCanBvQm5OOVRnSTNrVFFValorY0NranR0QnpNMDNLZ2NH?=
 =?utf-8?B?T2pKa0tyTW11eXo0Q3E5bENUSTdRakNSWFdpYmMzbklPZTRMZU1CR2Nwd2JG?=
 =?utf-8?B?L3k5TjFMNVAyS1FVV29iNkVGNDlxeFpWa2crYVVkZDZ3TTFKWnZzV2FnT1Rv?=
 =?utf-8?B?dmN3WUNyQldnVnA0clFMUFkySlAyS0d2UmxUb2tyM3BwSms2dmxia3VCeDB1?=
 =?utf-8?B?VldyWEJOMktoTy9xZ0lDajdHUEVsUjJJN1J2U0JrRWlRd0RDZVFSMGhrSEFr?=
 =?utf-8?B?YlZvMUs2K1U2Q1d4M1ZyWnREOTczU1V3Z3JibEV6Nk02MmZWZVc0YWRRam0v?=
 =?utf-8?B?SG92SmVHWFJRdDYyVFdzb25MZ0tuMU9LZjZsYkVhU3ZFZVFaY3FjQldGZFlJ?=
 =?utf-8?B?MFJJaU5BTmk2d0s5NFFKdEJhcW9aU0tPZFVuLzJXZVRueEc4K0FSdWlzZkRl?=
 =?utf-8?B?czNyZVRvOVcrWnBvM2xjMGUrUWRxUEtGUjBwdW9jTWtlSHVKN1h4dHNpY2VN?=
 =?utf-8?B?T1hZSk5oeVdyWFRscVZTblp5YnYyMDlzeVpNUEluNTN2ajdVR0RWK2RaUnZx?=
 =?utf-8?B?dThqZ1dWei9ZYjF0R2pTTk9hYXJwdmx3T1FPQjVYeXZMeUNpanl1L0krRmhJ?=
 =?utf-8?B?NFNxc0VId0JXVUdjempmcmcxM3RVS1BJWmRiYlpuNVRndlFMcXZrNnBGR0xx?=
 =?utf-8?B?Q2V6QVgxNlMwSVg2K2RCWUl4OGVRZWJ4eUlKVGduUVF0UGJROUVodzVrTmk0?=
 =?utf-8?B?YW01Q2UyT0RVZ2F5YmptUFRETGU3blNRNXRZZnkxOHBGWk5IYmNYQVpmWGZm?=
 =?utf-8?B?T3VOUThPTTl3UVl5T2hhWWdncmxIZmJlQnZPTktlVzBXTzBVSWp0ZkRsQmFj?=
 =?utf-8?B?Rnp4SjlPeUo4eWl6OXkxd2E2NmlGaE9VSFNqZW8zaXBReUc4RHFqb002ODY0?=
 =?utf-8?Q?yAZhYAa6xToNn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW4vMWFzQVBtdE5UK1dUS3pmc1VCNnBESUxzNEFVenYzSStvL3JwOWxwdWo5?=
 =?utf-8?B?YjBSSm42WjNtTDk2cmJpK2VxKzRpQjZLc0d4SEg1OWtXRmhrZ29zNTJwTW5j?=
 =?utf-8?B?dE1TWURTTkt5VlZnMFBOSUZpKzViUU5XYkgrNEVqUlRwdTlsQmNPS3A2NGdZ?=
 =?utf-8?B?clpPMzN5MWRBMThtdlZWQ1FrMDhvVDkzN0cybEFxV1FRSTQvSkVMYklmeUNk?=
 =?utf-8?B?SkhIWVlQWmwzK0dNaUNkZXNFdXJYMm4zdmZJQksydWtNTFJjRlFGbG94dHQ1?=
 =?utf-8?B?TVFGUDYyUE5tdHJGTUNjR0dKUmcvVnN1emlyeUowSGF0YmlyWlZhT2Z4SkFn?=
 =?utf-8?B?VVluQmJIV05sSHBCeHU4blE0S3pJdWtHYkQvbXRSbTRhWVJrWHMwK09iYTZn?=
 =?utf-8?B?OVRjSWlITzFHYlg4TkhmZmFrdVNiMDd0VCtvZVRoRXRab09yWUxvU3QrbkxN?=
 =?utf-8?B?V1o0MzU4WXUyTTNmR0UzWnRiblVUa2V0WE0raTVBOGxHQWpUQ0V4S2hpeThr?=
 =?utf-8?B?QlUwWEd5K245YTlyRkxKNnlYd2RIQ3BCMkt6bGQwTDFSQmtBQkRMTG5jMlo4?=
 =?utf-8?B?QXE4Z3A1bVRhNVpqeEQ3a2JMYVA1a0NWQ0M1WDh6WEs2OUVpQ0txbWpGTE93?=
 =?utf-8?B?OFIwcUVVZ01lQUlINExFVnpEQ3V3cWJGWnZkMEd3R3ExbjU3YTNnOTZid2Vr?=
 =?utf-8?B?MTNjenlDTzNjWDVGOGtYLzVPa0lOeWpCQ0dGOXlUeFltNFJKR2JWb09XTGtH?=
 =?utf-8?B?N3hHaDZncFhLUmdJTk1VNjdTNis0d093Wk1yemp4aGQveU1hNEZzc0tvQ3hr?=
 =?utf-8?B?eDQwVndwWi9XNHFtc3pDRGh5anBZUndyTnc2Y3h3Yi9EYXN5aWViZzRTbEtu?=
 =?utf-8?B?QTdXOUt6dzlaZTBCVUIyYmJIU2ZzYlpwd3F5TkFMc3VIRUg1NTA5bk5YNXNT?=
 =?utf-8?B?TlZvT1ZpTGpFSlBjbzk5K0xNRnVQRVBBSzdoQUh5dUNPRVlIUGRLSmhIc051?=
 =?utf-8?B?cHZOcCtKMkFzS1Y2aXZKa2xXRmN3WWhZSkhqSDF5UkVTdzNoS1ZnQ08vaTFm?=
 =?utf-8?B?QTFyVHZ2TEJtTTc3OU0yZ0d1ZFp1RGxNdWRiY3NzVHZPcitoMmtpaGhYNHRI?=
 =?utf-8?B?ZFc1WmsxS3dFRDZ2MWRidkErZTJDT01oaTNIcXBKVVMrWTFnREZpRXNkb3dV?=
 =?utf-8?B?c2tDQ3BLN0FQSkpSNUxKeHp2cnFyWXhFWm5UOVF0R0VMMmRqUkliYWdUZWx0?=
 =?utf-8?B?WlducFFiWEZmT3E1ci92a2RQSGJNYkt5Nlo1ZjN6WkJ3V0JGRHE5NjQ5R2ZM?=
 =?utf-8?B?a3p1VldTb1BBUWxac1I3cGNudWhocEJhb2FvY3VSdkZUUFBDS0JCTlVTcDlo?=
 =?utf-8?B?bVFabWIxT3hEM2pXMllmRkptY2MwbXV6MzlKbklXakFvZ0VkOVFLMjBNbk85?=
 =?utf-8?B?RHRLUnpBVFJGSXFYTThxcVhnaENQZlFUSlRSM3o3UmM1dDB2Ym5BekNLQ0dL?=
 =?utf-8?B?bEpsT1NVMVFPRjltSnlnMi9FdEhVTmJqYW5CRldRNjZUVVhZUHorM0VFNkMz?=
 =?utf-8?B?SzdheWtVa09ubWlxYUFqZDZLaWpQVWpscStwY1JIRFhMQWRqOHQ2S1NSVmdG?=
 =?utf-8?B?Rzg5OC9tZi9wZXJIV1NyOCtCcUU2MTE5dWNvcm9OSytPMHJ3TVFCVFgyeDdO?=
 =?utf-8?B?Q1pFWFBmSW01M21zS0g1Q2dGL3BLa3JIRThrbGJqNVFDK3ZyNjZsdGFDZkVT?=
 =?utf-8?B?Zk4yQktwTS8vaW03aEQvRGNzZFJYWUQ4TXdYd242S1lacElCMjJOd3FZUUdE?=
 =?utf-8?B?cFdTSWN2MENDQS9QbmdkZFAxNElhTXoyaFFSK3dNSXNkVFhMUk0rNldld3pa?=
 =?utf-8?B?UzVXc25IWFJCLzhScklLNTFPWmtuUEc2TGtpREIzeGxMaGRtakUzNzRBQUZz?=
 =?utf-8?B?WnJLZ1B5bjZkT3N6QmxYcFVzS0FPZHdOKzJ6UXljaTYyN3gyQVRIMDVUbER4?=
 =?utf-8?B?cGJkMmV2WlU4OG1xWVU0Zm42QTIvcVY0WlRPL0ZHMmtrUForVHF4SXZobzVZ?=
 =?utf-8?B?SWxQK0FWRytYb0twenJlVmFvTjlyUEhxQnBCWTVzb2xOeVBnaThMbERWRXRz?=
 =?utf-8?Q?GQ0fPMM2x4tkM/ngprtpLFHQY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43442bc9-17ca-4e9d-9cdc-08dd458f1d7d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 02:45:13.5297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI36DJ5xfWcGJ2dOBE3n0GybB06RrdtfWh9msb/28YSITskyWlqER5AkNQAn3jMEP36Sz8HU691xS5YFPBu/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
Received-SPF: permerror client-ip=2a01:111:f403:2415::619;
 envelope-from=Suravee.Suthikulpanit@amd.com;
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



On 11/29/2024 12:14 AM, Joao Martins wrote:
> On 21/11/2024 11:42, Joao Martins wrote:> On 20/11/2024 07:31, Suravee
> Suthikulpanit wrote:
>>> Add migration support for AMD IOMMU model by saving necessary AMDVIState
>>> parameters for MMIO registers, device table, command buffer, and event
>>> buffers.
>>>
>>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>> ---
>>>   hw/i386/amd_iommu.c | 36 +++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index 13af7211e1..3d2bb9d81e 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -1673,7 +1673,41 @@ static Property amdvi_properties[] = {
>>>
>>>   static const VMStateDescription vmstate_amdvi_sysbus = {
>>>       .name = "amd-iommu",
>>> -    .unmigratable = 1
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .priority = MIG_PRI_IOMMU,
>>> +    .fields = (VMStateField[]) {
>>> +      /* Updated in  amdvi_handle_control_write() */
>>> +      VMSTATE_BOOL(enabled, AMDVIState),
>>
>> no xtsup ?  I guess you are relying on the dest command line having xtsup=on
>> like intel-iommu
>>
> 
> Having said, I think I found a flaw here that sort of "ignores" the default
> command line param of 'device-iotlb' (broad x86-iommu param). By default it
> seems we enable device-iotlb in amd-iommu regardless, even though it's disabled
> by default in qemu command line params.
> 
> Should we enable migration I think stuff like that starts to be important to
> honor given the compability issues we would have to deal apriori. See below on
> how to fix, happy to formally send if what I explained makes sense to all

As you mentioned, AMD vIOMMU currently ignore this parameter and QEMU 
default dt_supported to false, and set the IOTLBSup in the IVRS table to 
1. If we start interpret this option, we need to also emulate the 
following cases when dt_supported=0:

* When DTE[I]=1. From AMD IOMMU Spec:

I: IOTLB enable. Controls IOMMU response to address translation requests 
from peripherals. 0=IOMMU returns target abort status when it receives 
an ATS requests from the peripheral. 1=IOMMU responds to ATS requests 
from the peripheral. This bit does not affect interrupts from the 
peripheral. If I=1 when Capability Offset 00h[IotlbSup]=0, the results 
are undefined.

* Handle the INVALIDATE_IOTLB_PAGES command, which also needs 
dt_supported=1.

Apart from trying to be compatible w/ the x86-iommu dt_supported param 
(which is mostly for Intel vIOMMU), I am not sure if handling the 
dt_supported is necessary for AMD vIOMMU. Do we have a scenario where we 
need to disable ATS support for vIOMMU?

Thanks,
Suravee

