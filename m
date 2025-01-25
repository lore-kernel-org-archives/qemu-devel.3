Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C09FC02181
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 02:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbW9R-0007h5-N3; Fri, 24 Jan 2025 21:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tbW9P-0007gJ-FF; Fri, 24 Jan 2025 21:43:59 -0500
Received: from mail-dm6nam12on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2417::619]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tbW9N-0004fB-8E; Fri, 24 Jan 2025 21:43:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXVgNwMXmC+rPEIwvN/Hw9DfNXjzl/l5JHx5RC+JYjKviCT+fxHI3EhGfer+cNksOvEjp8DXiopAooB6Kp7TAmyZrIlcoa0QdvpiLzx66JTk76/FjSCj5LCrpX9kjsswDpkMPBxX+g2r6gWK3h1LGPc9E8WBq8vBATdI/ZWhysvawaHzZ8cGScxXJ8Jh2056MnZAqEZ0jR2xxrrf9G6IOsMvZd96lx8qfTUeTWU7Ign+4RBepbdakQeK8zFKS4MYRWB7U8iC/C619fjLYcmRndUVkmmQtRS/vFbQETMOGRZm4Hwi63E3mWAofNzE6z0+gnd/WXFOSIecNs9TESIH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogekTvyag8dflDiJ8W+ed43wIFySl/FnVNKcRBHufA8=;
 b=hogmAaJLQVaFPYtg4H2/1I5k7sA8wbQQcAj1HXtQrXbzRCPxQvSGjJCVJqhM2Cz+INwHPS5pxygLag4McjzLxmAFQMA/NCa66h4FM7SR1CD4Thmh89s/xR/24/AjK8s/WfITIFWGnJ0X4M214bngEaGRSJ9DsdDnp1aAHBWG87kP4GLiBXeLmDbjxoZhZi/KgT3e+7h1vcyTzyn95qfQLgZqH8Q4w3gLcv9hGRfbFqgTuD0I6W3l7yhiB/70v05YhHVAUklhtGL9FkYyr3/F1u1lWDhPBaAUGQLllXqLrd7KgOLlajUaQBRF+g0ctxhvDfgiNJIK5A+5Ds7pQy+bUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogekTvyag8dflDiJ8W+ed43wIFySl/FnVNKcRBHufA8=;
 b=eXi3DiTE6GwZIpRQicbWQ19ImF18SpzQwfopcPoObJv5ITO1DpHv70W7CIrxbPuPI7UOSQg82aqfMplke6ikTJpwn3yl13A45Rxlw+mkXS+d7EntkLAu8TXlz6n3qSJoVvWJP3899/dB0jMWDz0yg+DSQLKOPPyutsjg0OrPxLErrz7rbMB+zY7hkSur4nKa2e7h7e5JTOWwfYgwsBDus1U5zHFyOUtyxHsgVNlDcYOhrAE7TTajPjKhUtRhY/XFDxRW9Jp4GGflDSblSqtAFX4jk3lcZe9IjfJa8VDbedVgSbVK9dGHAMFJc9BAYZgIlEsjxc4qkKIOs5oaE2DYFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Sat, 25 Jan
 2025 02:43:50 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%6]) with mapi id 15.20.8356.020; Sat, 25 Jan 2025
 02:43:50 +0000
Message-ID: <a80c78fd-6203-4aca-a3d3-d67a68b8e595@nvidia.com>
Date: Fri, 24 Jan 2025 18:43:48 -0800
User-Agent: Mozilla Thunderbird
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: ddutile@redhat.com, eric.auger@redhat.com, jgg@nvidia.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com,
 nathanc@nvidia.com, nicolinc@nvidia.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, wangzhou1@hisilicon.com, zhangfei.gao@linaro.org,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <31db1f75110e46ccaffffb801e894605@huawei.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <31db1f75110e46ccaffffb801e894605@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::24) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb27978-354d-4dca-c460-08dd3cea1979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnVEeCs3QjBRRUhTek9UNklkWjZ0YXZsU3NrUnZkTzdxaWFwaUpSSmIyVDJi?=
 =?utf-8?B?OFFBRGg0aEVqUmlwSjkvWERMb1lYVjh3bWkwZWNXOC93Nm5GOG5mb3FNTlJV?=
 =?utf-8?B?Q0lndVd0OEZ4OHIydjduWE9RVXRvT21Kb0JqcnBGVFhuOHhpd0N6LzF0Y0k5?=
 =?utf-8?B?UFdhT3VqYzVhS1hTVHVtRGxOQjIxU0VXdGJScHl2NmE2MVlMWllhQlBKWlVh?=
 =?utf-8?B?WnVJU2JNN1BTMHE2Y2h0cHRnRFoyL3lvVndGUjd0V3JiU1ZsR2F6ZVBpYjZw?=
 =?utf-8?B?WklQT0JBSTRVdVVDckVPajJqbVlGMTdCNUdUY09qYW9aRVpGYjZTMGdDS28x?=
 =?utf-8?B?b3Z6NGdPS0dEOG9aTHJ5NSswNmR3UEpnQjdTdFNad3NKd0cwQWJET3VSRk9P?=
 =?utf-8?B?Wldzc3BxOGl2QW5tTlp1emdrV1BXS1JTV095L2tCMnI4Uk1leDFJWnFFcFVl?=
 =?utf-8?B?NXRKdTZvT3IzenZJRkwzeGNmdnZqNmpucnRiMncybnFQSm1FZFp1ZGVvK2pC?=
 =?utf-8?B?UFdRUnFGNUNNK09CalBpaFpMUjdkbjgwbTJIZk11WGVTMlJPWVB6eUlZR0My?=
 =?utf-8?B?eStrL0pIYzlxdTByemNkMW1ZY2EzK2lGbHBzcjNpK1A5V2V4NDU3cFJkRjh6?=
 =?utf-8?B?Y0Y4aUtTK0J2Si9NaEc5Y1J6bERWY3MwRVhzV2V2V2R2OTEyS2dxM2hSRGRF?=
 =?utf-8?B?emhiaW9BNU9SWEJPTHV3dUF2WUl3RDRmZklaMjZHVkJDbnluQjZ0SzZvVFR5?=
 =?utf-8?B?MWd3Ymxma3duTUJhUHZ3R08zUGovbHRlSjNDcVBsQWVTTm9YaThiUjhoZVlk?=
 =?utf-8?B?ank5aXJTcmVxaUNjUTZjTy9YcnRKT2UzWFdndWpEbTd5MHZuMU1tZ1NuVm56?=
 =?utf-8?B?M2kxbjZBVnQ2MU1RY0xtSjdlMTlzakY3aUJHRXRIZVFrWWNkQVRpTVRUd1FY?=
 =?utf-8?B?ZFZDUkVXTys1YTFoanNMb21IbFMyYjV2WWVPU3NRckJ6SlU5K09CV2RFVlRI?=
 =?utf-8?B?RlFHU0NJZXFkMHRxeDVRbUhHZ01zZHhhYysxUHhnVG1DcDlSaDVBMXpqZTFk?=
 =?utf-8?B?SitsU21HcTBOd2VBb2xwTWZRdGRPN29BYjBianVpRkJQcXU4L1h2aWdLK0tZ?=
 =?utf-8?B?OU1Ya21QdFMrLy9hTjBhUjB3QTJPa0ZZSGVaYkpWcWFpY0RNbE40TTJwQ0dM?=
 =?utf-8?B?aU92M3JGTEZRVDkwelpaYVZXaTRYdnhCaDhRSkRWOUFQdGxEK3k4YkxZMWli?=
 =?utf-8?B?KzRheS9DVEdPOVZLNzlralJXaWt1SEwwYjJHYTdzQzI1Yk1SRzJkMDViT1dT?=
 =?utf-8?B?OGtEeUNFZHJRelFNNi9jMXN3SHhBdlJnNGlXdUgwd1NvVHdTTXRtZTRwajd3?=
 =?utf-8?B?Tkw0NFA2N0RzYnoveGppMDBScUFPNXZYcGpoQzVVZ0hMMXV0RE9xdFpISERl?=
 =?utf-8?B?bHNmREd5WnFHTDlPY1FMQ1JiZXU1SDcxa3FKQTVxMnBYS3BETkt1ejg0OGhp?=
 =?utf-8?B?b0NBcDluTWVrYzFmcTlVVW5OekNDMWs3aDJGWW00NW5JTnFYVWEyY0xQQzdS?=
 =?utf-8?B?WFJsN2ZEeWErNEtncTJBa1pReDE3SDVBZGR2UjhDcE0wN25yTDFxRCs5NEhs?=
 =?utf-8?B?bzZITVQreDJubXlqUko5OG5FbWwwMkVDK2FpTlVZak40TEhhZThZSmhjV2lp?=
 =?utf-8?B?a1JHekZVVytCeWxzUVE1bkZqMVVCWndsVDMrT0pZNUV0MGVSWTQzRi92cEFq?=
 =?utf-8?B?QklyZjQ0aHYzejladlNKMVZYczF5NmJBNkNjYnM3a3d0TFFGN3IwSDgvbXl1?=
 =?utf-8?B?em1BdGRQK2VPdjNIYjZ2T3pqYnB0Rk4yaTRPaUMyL29HR0ZMVEIwT2pkWnVt?=
 =?utf-8?Q?Dbo37vpBNDgHX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHBKcVpLU2Q3YzdNZzBNZCt4U1VLYVFQNWl5OGY0ck9vS0VsNUxRZGRtSzBZ?=
 =?utf-8?B?R2VtQktZbnowWUQwN05MMUs5TlE0VTV2WVVXbjY3V2ljTC9aWjFVQnp6UmFj?=
 =?utf-8?B?YUFxcnIwMDBpMzNnTHN0emFpTlBqcnoxVlhTa1pFVzJiUEpGQWdzZkVKWTZa?=
 =?utf-8?B?U2YxcCtxKzFWa3l0eURpZlBTZ2xycnA5czA5VC8zUzc2OVkzR2x1dmZnejI0?=
 =?utf-8?B?ZVNrWEd1QWNsdGs1WmxPM2lxOGpXdkgycGF6MVRpWTdnSVdhQjBPa2hBN01s?=
 =?utf-8?B?N3Rrb0ZVYUI1RkNWdy9NQjlqMUZSU0NuTityRC9wZ1ZTR0VhMnovR3I5b3lI?=
 =?utf-8?B?MTNIaWgyUDVmWUpWK0NnN0tDcEpGaC9oL0p6YkFuMzVSSTBOQTRkQitkYkdv?=
 =?utf-8?B?SnBna2JNTDBVa20xaHR1NnhPRVpXamlSZ2pKRng3NzhUcGhZay8vM2NNbE1M?=
 =?utf-8?B?UHV5ZyswM1h2QTNld1dYZWpGaUtLYW1RRWNLVmoyNzg5UkNNVEQzRzZ0SVVH?=
 =?utf-8?B?alg3YVRkc0pmcW9HT0pBdEYwSEF4c2hENm5OSlI2YUVxMm9GZUJoMzVoYjRo?=
 =?utf-8?B?dmhzWlc5dE1OZmgra0g3Sy9Ca29IVWRmQlUyUVgrWWFLcFc3TFZaaHRSM2NL?=
 =?utf-8?B?bktsRlB2OGExSjk4U3BhUUtrSldPSnRtUCtxaGQrWWZtRnNWZytueDMrcHVu?=
 =?utf-8?B?QWpZeU91dzhrMVdSc1dBbm1leUlWUTMxMFZRaEh3QlltTjYvajIrcUhYc1JE?=
 =?utf-8?B?YmJoRXBISzZEYWJVYXB3ZW5EUzZGWWQrV3RuVXRhY1VmMnUvTXdkMkIwTFcx?=
 =?utf-8?B?SVRQN2dBWTJBc1RxNDFUU2h3eWpZYlBoOTZMVDhqWWs3VDIwanltbGZNbGZ5?=
 =?utf-8?B?VVkwOSs5azkvTXBxQ1hETHkxTUVSNXpvVjQzcCs0OTd4Tms5OVo1TG92Q0Mr?=
 =?utf-8?B?a1llU0Nma2xzQTBkUXZGZ2lrbW5qa2pEenVxR05YbzZsM0tsbjc4UzdKYlh4?=
 =?utf-8?B?MHlacFY2RG1jRUFlbmZTZWtQOGtxZnNyTzgwQ1VBcHhhbTdHNGlHM2ZHV1gz?=
 =?utf-8?B?OFJBUUllbVRlek52ck4yT2R4RlRlbUxNUTJxcmNmSW14S0NtYlFRZy9DZ2VW?=
 =?utf-8?B?MUhDRW1aUW54VExmazFDWjVYbkw4akw5Zmk2dzNKajlZcE1OSXU3TytsTlFH?=
 =?utf-8?B?Z0tKMDgydkJYeThLYy9POXRaV1h3bFdvbmUzUjhOM1hrbTdCM3hhWGFFN2VO?=
 =?utf-8?B?YzQxbkhSRVpTVE0wWld0eUlwOHVHcXNrak9MRUFZcWREVGc3YVJ2YTY0cEJQ?=
 =?utf-8?B?UEsyZGdTUVB6T1B4cnNPQitlb25uNmdzZXI0RUt6c015aWVOdmdoZVVjaUQ3?=
 =?utf-8?B?YzhEUmk4QkZYT2RPNUtZaFZEckxSMGp3U2VKNkdkTHZHa1JCYTFzVWpwbjlj?=
 =?utf-8?B?S3J1bmFsSnJlYTBpYTBPSmV3Vm5laW9ldzhxRnpMSlRLb2NxdEN2elNvWUYx?=
 =?utf-8?B?WEhFQVVvSVFMVGdDYjJOVzZ2b2g3eThTY2l3NzA5N0k4aDBxUUZFTTJSU3hX?=
 =?utf-8?B?eXo5S0Jka2pDdkorbzY1dVdXRTZ1QTJVNXpzb2NIK1M5MU9RWHh4MzhNYVVI?=
 =?utf-8?B?NThGb01TS1NoVXo1YUp2Q2htdmNNZSs5bWEwK2lYNlkrODVVYXlHM2t6c2JO?=
 =?utf-8?B?MUc0VE5xMWh2aEVQeW1pNUQrNXF6Sm5lR2ZhMDRUR2EraHppM3lrSWNLMENn?=
 =?utf-8?B?M1lKS0VpY2h5U29uQjY3YTFZaXp2QUZ1UDhJeHBOYXFLUXV4NFdtU0RmeWs2?=
 =?utf-8?B?V29pQmgvSktjcHJ1ak5PQ0hsaW5zSW84K1ZwN1c3M0xnVDNnekpBVHZJYytU?=
 =?utf-8?B?N3B5UnR6UzBlODJEYk5kVXA3ZG80engxM05sTHhPWHc5MWIvY0Y5OFgxMnd2?=
 =?utf-8?B?V1FCcndRTXFmY2JVRUI1WG5wemRoUFNwMGE1eTFDbTB0dHB6cENFbnVEd3Fh?=
 =?utf-8?B?NTN3ZXpHVWZ1R25YQS9uSVBualNRSGFtOU1KMEtJc3ZPeHJQR21tWXRiaXdj?=
 =?utf-8?B?dGFTanIwU29XODZNeXh5UXYwUVdzV3dXL2RHMktHSHZZRXVtK3Z5UE1zc1pu?=
 =?utf-8?Q?/En/FEaPHrqftVfQqVeJFRaW5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb27978-354d-4dca-c460-08dd3cea1979
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 02:43:50.5401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHdXA1/3U60kiYMu9zPpkvhEzgaL/ish9AdwV9smtwx7h7TAvDkcAJSrW3YsoDT1wpfYNCvB7/Pt095o5PsZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
Received-SPF: softfail client-ip=2a01:111:f403:2417::619;
 envelope-from=nathanc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>>  >with an error message indicating DMA mapping failed for the
>> passthrough >devices.
>> 
>> A correction - the message indicates UEFI failed to find a mapping for
>> the boot partition ("map: no mapping found"), not that DMA mapping
>> failed. But earlier EDK debug logs still show PCI host bridge resource
>> conflicts for the passthrough devices that seem related to the VM boot
>> failure.
> 
> I have tried a 2023 version EFI which works. And for more recent tests I am
> using a one built directly from,
> https://github.com/tianocore/edk2.git master
> 
> Commit: 0f3867fa6ef0("UefiPayloadPkg/UefiPayloadEntry: Fix PT protection
> in 5 level paging"
> 
> With both, I don’t remember seeing any boot failure and the above UEFI
> related "map: no mapping found" error. But the Guest kernel at times
> complaints about pci bridge window memory assignment failures.
> ...
> pci 0000:10:01.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> pci 0000:10:01.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> pci 0000:10:00.0: bridge window [io  size 0x1000]:can't assign; no space
> ...
> 
> But Guest still boots and worked fine so far.

Hi Shameer,

Just letting you know I resolved this by increasing the MMIO region size 
in hw/arm/virt.c to support passing through GPUs with large BAR regions 
(VIRT_HIGH_PCIE_MMIO). Thanks for taking a look.

Thanks,
Nathan

