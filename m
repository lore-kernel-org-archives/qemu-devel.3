Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC174C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 12:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toijy-0001Zs-O4; Sun, 02 Mar 2025 07:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1toijg-0001TE-H7
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 07:48:09 -0500
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com
 ([40.107.223.63] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1toijd-0001FE-Pc
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 07:48:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOdgmc7cWc18+y7rh1j7v38F9wDFNmX+iSzs9s2ZBj1XWCuSewQgb5Knqu7SZHu0Z/ESZN95Kab8838AXgYELQhFlYT6ChaT1UyJTyMVa9UOpDyqMWZRPHtw4D7Rx9ZoZlIPJ36NWrHnJDHgKcNmI9Uv63n0f1xufMutxI/vPwjfekyGyySa4pb7JQ5CthOQMZZxptMPXIUpyFfBL7E/hmyJTXrmOxFdoCw5Zb9/IsCbI/MwnnI4bkPXHs/yMtbg/niaBnR2jMuaQX/wEETZ/6u15uGH6sY4xN/CopO8I/F71BP6IQCuzjVJoxU20c13S0IgGB73RsltdeY74knpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkxVNnxSxoUZH33+vGZLPI7m73h2sJLq9THqIg33aCU=;
 b=uhnj5rUPlxyDxVKeHpfeDffxcIVBv+X9+bwuR/qrqeR8ee14O75Z/etk4OnbZPAJkahLBuVROl89uPRRv2cGsWGabf0nTFkssRnN8QUNndTThZNy5M7REOBnfTFIx6G6L0f1yC1JER3v3p9XeG8wdkbIlLR8l2oQSUrzcReeyr/DtQukzLFfSlc5bnxkgKopJGqYibVImf8jW/kirMaQwDNoYFano1x4SEo89LyZAIe+b66UwTFO1dVKV568pvi/TKuZg/ia4g86DoKmBoOA/VslgYbnibbitKSIVaUkxEIoG45K5lconXWTbG0l6TvKL+ky6Abtaf5trs1yxJu7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkxVNnxSxoUZH33+vGZLPI7m73h2sJLq9THqIg33aCU=;
 b=iCjvLVsN99wEbHL8rmWl1WzNClD3v3AL7zd+mBol5BHRLAoWu1iqvkfWiyCkP66ju4Et1ZQ+tPoLjbZfwP5XPd36BjOWZvxMRsRpxgCF1ePgK9DXe7t2Rwwq6ekZ93+5JNzU1kz2MltD1FayQxZ4oLlCx0ldcIyWQ3vgmB4S5P8yj18hTxb9s46xjyIW0gyl7UTRRK+lziDXfe8YxqNk3dLFzc1RvLUt+E79Z/hoEbOVWuBU9rHvcuydMxRzR1ed9V2hj77b97CRAK6aLfiiNLgnusSOqG826aPMA6vKVNWQDiO7Xifwn6z4eMC3xgJnLyANPCbSPhIgm9Tgioyoug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Sun, 2 Mar
 2025 12:42:50 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 12:42:50 +0000
Message-ID: <a55c5f70-04ad-486d-96fa-5b3b75e0a5c6@nvidia.com>
Date: Sun, 2 Mar 2025 14:42:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/36] migration/multifd: Device state transfer support
 - receive side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <8857884d14e5e854629a32dfb96011b43945088f.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <8857884d14e5e854629a32dfb96011b43945088f.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 95716c52-0ddf-448f-f974-08dd5987bdf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkVDZjB3NExFOXRvck5WMm1qdXVZVmd4cmd6MHgvcll5dTdaazY5SkRaN1BP?=
 =?utf-8?B?Q01Pajhpbzd4SThMVy9nZDEveXplWStFaFNOWDdXSUdyd2wwd0dTdWVVU1ZZ?=
 =?utf-8?B?azMrTHkvVFphOTE0Y2hVYjBSeXJNQVY2aUhtNURRM2ZlV3gvbGNsTktRKyt3?=
 =?utf-8?B?aXRPdUgrRlorK1dUWHdhSWFJdHZRMnhsS0xwV01aNUlSTkRFdVpkUGQ1L2ZC?=
 =?utf-8?B?ME1LWFY2dWpiYWZaRXdXWnAwTjZMTkJuZFlRdS82V2lwNlNhV050V0N0MlBt?=
 =?utf-8?B?R2RzTU1sYTZ6akk0dDZJeDlmVVczcy82MDcxVERSODNQUUxTTkg4ejA5NFBU?=
 =?utf-8?B?Z3haL1djWnh5VEw4cGNUQk9TWjNJbDlncklMbDBwQlNiR2l1SmJVWERPdzNn?=
 =?utf-8?B?eFIxSHdKbGdnN1M1a3FjYzY5UG5kcmxxYmx1NksrZy9OOVNucjdYNXNqSTNU?=
 =?utf-8?B?SEwzQ3JuNGRrTUlnTUt4NFlwN29DRUhCY05CL1NZOUtWQk1FUWNxcFFONmlN?=
 =?utf-8?B?STA4WVFnNyt1QkQzNVpyL0FuY1c0bDh1amthUGVLR1F5NExKN2JoblhQVTE4?=
 =?utf-8?B?VEdWVEY3WExtRTFuWUN3dmlST1QrdVpEUGtEK2pJbEdzTHBLRDliZExaektJ?=
 =?utf-8?B?U0pJbUp4MFlnK1B5d1VEcWVCN1dGN1BxMjJIOHBJVDRDYmpkRldobmxtQzdW?=
 =?utf-8?B?ZElUdUJUV0RjQXpINFN6UWY4a3FvUytXelVZY0ZKUkNhOThjYmw5SXJrWlNh?=
 =?utf-8?B?a05weGkwRWttdEJWOE1IZnEwYmxuS2k1RkdSUFUyZGpITDNZbWZFcGNpek9N?=
 =?utf-8?B?clVtWXoyaUFKS0p4YXZhSkt0VE1na1ZtMFBPMVhVd211Q1VCTFhjQjVSL0Zv?=
 =?utf-8?B?d1FHbnhKWTBwNkxxVms2djA4UjdSSUFsMkNCRnNneXBIcFlVY1JSUmc4NEJU?=
 =?utf-8?B?UVZoQ2VIMHlVS25neFFCbXViOXdxTTdQYS8zWUtqTCs1SlkySDZSNnRVRm56?=
 =?utf-8?B?MEF2UHcxcXFBc3lGMFVieiszTy9iNmV0czljUGxveW1TUWNGTkw0Kzd0eFdy?=
 =?utf-8?B?bXBPQ1g0RW1NNUVEVlZ3Vk1XK0VmS0pUOHRWOEZQT2ZoblE4cUVjNlRuUW5X?=
 =?utf-8?B?cnlHT2MzWjRualJwbDV4RENvRHRJN1B0OUQxRUZWeFljc2MrbHNWS3hTQ01s?=
 =?utf-8?B?akVJRGFxc1liUVgySGVidlZMTXc4TkpEd1RVQVBLT1FFSFBvekdOK2xZSXRW?=
 =?utf-8?B?a09sVlR4WHc4cW9QbHJMeDRucTRJckluRGdVcHVXV1VaeXBCQ2RYNFNNV1BW?=
 =?utf-8?B?b2RRYm5LR3ZxZFdxV1FxWFM5TWd0MmM4RWdadVEzb1d5aEg4TlEwbHZ4eEVS?=
 =?utf-8?B?c2RqWno0bTh5NXprRlZyUTVUV09oU1htbDRCY3hMOWFpdzVMdDJ2V0RtVWM3?=
 =?utf-8?B?bHBMcUVuSExUWmJVSTBGSEh0Tk9MQUVjY1hyVkMyeUxOWFA1L1E3Q1VnWHJB?=
 =?utf-8?B?UldCZzA1Y3UzNFZ6K2VqMmpwdVNCdkVwWWcydkJ3ZGNIcHNldkc3MEZiUklF?=
 =?utf-8?B?VnFCUWU1eTkwS0ZRUTdmQUtRZDAxY3pCbTBMd2hsbWpSS05qcDBNOFg3ZHRk?=
 =?utf-8?B?ZnBVWWJOTU1YSWtnWHBySTgvMC95QjhiTURvOTR6UWhZT3NrTS9jN3pHM3Nl?=
 =?utf-8?B?MVFtSDlQT3BUdDNFV1AzanZ2VlFaRll4Q0hOVGNqUi9CWHNqZmFNWmM2aHUy?=
 =?utf-8?B?aE44S3AvSVFLSU5RUjg5ZWhzK2NSMXBCTms4SmlCT0ZqRkEzTjB3NjNtSXZ1?=
 =?utf-8?B?TmM2aFU5NTY0VllDUzRHdlhyNTd1dzZlRXB0TVlWLzcrWWs5Yk9NMy9JMUht?=
 =?utf-8?Q?Aub3tdLsjee73?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3c0N1VqUitBWStIRGRja3V5UC9QWWZaNGZVM0RyKzBvYmtaZTJtQWNBZlpn?=
 =?utf-8?B?S0NYTjIxV1RrRyttd0NrbitzcE14Zm84eTBOYm9KV0IvVFl6djRWbGwvdjRP?=
 =?utf-8?B?bDZPVzlYU3o3b2JoV05EN2k3ZVBqRmZ6enpXdklXWWp3ZWdlNlE5STVGMGs1?=
 =?utf-8?B?TTBzME1CandQeVZlTFJtL1JjTVU1SVAzc2FKcEhkMVdVUi9xc2RlVGoxaVg1?=
 =?utf-8?B?WXpVYkNtQkZLV0J6aWFJcVVSek1ISEpUUm0yUENQZGM0RkRSUXpWb0RpL0xv?=
 =?utf-8?B?QVpKbk9EYlgyVG0yTE1vMmorTE9pYW1kNE9hODBhK1NVVnRGNWNENWVGYzIy?=
 =?utf-8?B?UWZIUnFLQ1YvUjRpRnQ2ZTYrMEJVczlrbG5nTG9oZjF6cVdFT0pLUEtFSUNs?=
 =?utf-8?B?MkhEeWpxWHpCMmwvSzNQMnRGMmlUUmp5NmxzMG1WRkswNmVEL2I2amVadmVB?=
 =?utf-8?B?WkVUR3NwQ01QanFLeGM3UVNNM1g5blFOczRld2kzQ0pYcS9YbytHdGZrRXg2?=
 =?utf-8?B?aVI1RGRWSTJkM3ovREpqcDFtYzBDM00ySzNSYldnZEdRUGNXZDQxL3FUU1hO?=
 =?utf-8?B?eml4Uk5lVm9GVVJlNUozR1MxZzUzaHVDYkE1dTZqZmtIQjJWVENZMnJVUFRx?=
 =?utf-8?B?UXBMb2NwKzRyR2JDSWFPTThGaThYNXlhVDJySkJMZnJycnlQUlVKc3RZNnNL?=
 =?utf-8?B?ZGNORlU0TG02K2gycFd5eTBjS2hrbS82KzlYcjIwbzBUTzRIUlNvWlF0WkNk?=
 =?utf-8?B?T3diL2htM1g0TUJERHk5VERtekhFcTNsbktxMlcrUENabmU1V1VCOWxwQ0Nl?=
 =?utf-8?B?RXc2SzVXYlQ3cFBOMjBNMXRrWUJrTnRpWVV3SGdsQytNYllvbWtLUGlVa2Js?=
 =?utf-8?B?VzN2RWR2ZjMxaytDR2R6UWtRbnQyRExGK3Z5T2RtNWIxZ3YrOElyWU8yZ2tK?=
 =?utf-8?B?NXBYcHloWUY4WGtOL3JYNS8vS0xQaU1QV1Ivd0UxV3UyTmN3S3RxOU56MzhW?=
 =?utf-8?B?VDk3K21vRlVuZ3M5NU1NZmtkQ3NKT2dvQkkrRmJScGMvQnBra0xYZ0ZzNmUz?=
 =?utf-8?B?YUtTMTNHbU5vazBOVG91Q3dNNTVxb1g3dng3WjdpMHJXRktEV0lQaHN2bzRK?=
 =?utf-8?B?eXAzaEo5eWVCaFZOMGVQQWVDNGNzNzJKQk9XMVFJcHFGeVNIY0s0R3lYWFRW?=
 =?utf-8?B?Z29EWFJuemNpWnAzNEkyRU5ZQjk5YjlRcFNFZFUxL3JWbDBwOXJiR3NYa3Z2?=
 =?utf-8?B?M0lkYXRxSk5TRVpEVGlXYVU4cGVrcTFBUjJWTFUycVdHbkZlNWo4Q0FKY25M?=
 =?utf-8?B?MWhOanJQQkluRXhKNWJyNEgzYyt2WW5ubnh6MTU0ZktrVnVDdFhUN1JmblY1?=
 =?utf-8?B?NnBrOU03cFVhOVdxM3hiZnJmVjJBcFI1WlNyY0hsZTFBejIxcEM5amVMRUsr?=
 =?utf-8?B?dVE5SHYzRk1VdXhwenYyeDZFQmFNRmVYVFBQWGQ4WlpSQStkdDdkTzFtTDMw?=
 =?utf-8?B?a01DWTZkSUxvK1NWRzRCdUhlQUZhdm5Bd0ZheVVXRTZtd1pzS1kvODgwVVEv?=
 =?utf-8?B?VGdudDdJSWlhdHBvQWRNVzg1MFNIT0FWY3ZvQ1VvMkhvR1ovdmxnd1BjamhR?=
 =?utf-8?B?QThIK2FYZjUxQ3lyWWc3dVk4RDlzd052cGxzNi9XbFBqVVhJcU1tQjg2UzYx?=
 =?utf-8?B?RVJNWlJyM0ozaW90UG1NQUNuQWhxWTVLS3hPQ1JteTJLRkpYN3ZBTE5WZ1BZ?=
 =?utf-8?B?MzZSbm53TXNINHpQNkJKT3NwTFBtRzdZR2JVQmxCclkwRmt2VmJyVEtvSVpN?=
 =?utf-8?B?L0tJbkxxYlIydWpseDVCWnRTN00vYVQrVDNNT3lUOUtESWJvem5pOEhnK25I?=
 =?utf-8?B?Y0ZLKzN1d1hHVTFEMHJoaEs1VklZcTh3MEFVOVZTU1JZbis2SGx4OWV3a29r?=
 =?utf-8?B?R1BHT3hWKzhwOEtkbXNtL0w0SjU1ZzNuRjJmMGZ5K2tQbXMrOEpYOXB5WnY0?=
 =?utf-8?B?M01QVTFGSTI4OE9hczRFdUlZT2pPVkhXNjVxa1JIOHhrYU8xaU51YWs4WjRN?=
 =?utf-8?B?bG9zeXlySCt0RERXaHczZ25TSXRoTWpZc2IwQWRiMkNwME1hTndXNzBuY3Zq?=
 =?utf-8?Q?a8IiGuJfmsF1Te6aTLEOb+/hO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95716c52-0ddf-448f-f974-08dd5987bdf5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 12:42:50.1187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHVltxhhzW8ty/41t/1IyuMEnIg/04LV2XxtsShvVdejv5MEaAH+IeIN9vED+iMVEX8bdc+FPT1A8IJE14eJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
Received-SPF: softfail client-ip=40.107.223.63;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Maciej,

Sorry for the long delay, I have been busy with other tasks.
I got some small comments for the series.

On 19/02/2025 22:33, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Add a basic support for receiving device state via multifd channels -
> channels that are shared with RAM transfers.
>
> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
> packet header either device state (MultiFDPacketDeviceState_t) or RAM
> data (existing MultiFDPacket_t) is read.
>
> The received device state data is provided to
> qemu_loadvm_load_state_buffer() function for processing in the
> device's load_state_buffer handler.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   migration/multifd.c | 99 ++++++++++++++++++++++++++++++++++++++++-----
>   migration/multifd.h | 26 +++++++++++-
>   2 files changed, 113 insertions(+), 12 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3b47e63c2c4a..700a385447c7 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -21,6 +21,7 @@
>   #include "file.h"
>   #include "migration.h"
>   #include "migration-stats.h"
> +#include "savevm.h"
>   #include "socket.h"
>   #include "tls.h"
>   #include "qemu-file.h"
> @@ -252,14 +253,24 @@ static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
>       return 0;
>   }
>
> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +static int multifd_recv_unfill_packet_device_state(MultiFDRecvParams *p,
> +                                                   Error **errp)
> +{
> +    MultiFDPacketDeviceState_t *packet = p->packet_dev_state;
> +
> +    packet->instance_id = be32_to_cpu(packet->instance_id);
> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
> +
> +    return 0;
> +}
> +
> +static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p, Error **errp)
>   {
>       const MultiFDPacket_t *packet = p->packet;
>       int ret = 0;
>
>       p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>       p->packet_num = be64_to_cpu(packet->packet_num);
> -    p->packets_recved++;
>
>       /* Always unfill, old QEMUs (<9.0) send data along with SYNC */
>       ret = multifd_ram_unfill_packet(p, errp);
> @@ -270,6 +281,17 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>       return ret;
>   }
>
> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +{
> +    p->packets_recved++;
> +
> +    if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
> +        return multifd_recv_unfill_packet_device_state(p, errp);
> +    }
> +
> +    return multifd_recv_unfill_packet_ram(p, errp);
> +}
> +
>   static bool multifd_send_should_exit(void)
>   {
>       return qatomic_read(&multifd_send_state->exiting);
> @@ -1057,6 +1079,7 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
>       p->packet_len = 0;
>       g_free(p->packet);
>       p->packet = NULL;
> +    g_clear_pointer(&p->packet_dev_state, g_free);
>       g_free(p->normal);
>       p->normal = NULL;
>       g_free(p->zero);
> @@ -1158,6 +1181,32 @@ void multifd_recv_sync_main(void)
>       trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
>   }
>
> +static int multifd_device_state_recv(MultiFDRecvParams *p, Error **errp)
> +{
> +    g_autofree char *idstr = NULL;
> +    g_autofree char *dev_state_buf = NULL;
> +    int ret;
> +
> +    dev_state_buf = g_malloc(p->next_packet_size);
> +
> +    ret = qio_channel_read_all(p->c, dev_state_buf, p->next_packet_size, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    idstr = g_strndup(p->packet_dev_state->idstr,
> +                      sizeof(p->packet_dev_state->idstr));
> +
> +    if (!qemu_loadvm_load_state_buffer(idstr,
> +                                       p->packet_dev_state->instance_id,
> +                                       dev_state_buf, p->next_packet_size,
> +                                       errp)) {
> +        ret = -1;
> +    }
> +
> +    return ret;
> +}
> +
>   static void *multifd_recv_thread(void *opaque)
>   {
>       MigrationState *s = migrate_get_current();
> @@ -1176,6 +1225,7 @@ static void *multifd_recv_thread(void *opaque)
>       while (true) {
>           MultiFDPacketHdr_t hdr;
>           uint32_t flags = 0;
> +        bool is_device_state = false;
>           bool has_data = false;
>           uint8_t *pkt_buf;
>           size_t pkt_len;
> @@ -1209,8 +1259,14 @@ static void *multifd_recv_thread(void *opaque)
>                   break;
>               }
>
> -            pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
> -            pkt_len = p->packet_len - sizeof(hdr);
> +            is_device_state = p->flags & MULTIFD_FLAG_DEVICE_STATE;
> +            if (is_device_state) {
> +                pkt_buf = (uint8_t *)p->packet_dev_state + sizeof(hdr);
> +                pkt_len = sizeof(*p->packet_dev_state) - sizeof(hdr);
> +            } else {
> +                pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
> +                pkt_len = p->packet_len - sizeof(hdr);
> +            }
>
>               ret = qio_channel_read_all_eof(p->c, (char *)pkt_buf, pkt_len,
>                                              &local_err);
> @@ -1235,12 +1291,17 @@ static void *multifd_recv_thread(void *opaque)
>               /* recv methods don't know how to handle the SYNC flag */
>               p->flags &= ~MULTIFD_FLAG_SYNC;
>
> -            /*
> -             * Even if it's a SYNC packet, this needs to be set
> -             * because older QEMUs (<9.0) still send data along with
> -             * the SYNC packet.
> -             */
> -            has_data = p->normal_num || p->zero_num;
> +            if (is_device_state) {
> +                has_data = p->next_packet_size > 0;
> +            } else {
> +                /*
> +                 * Even if it's a SYNC packet, this needs to be set
> +                 * because older QEMUs (<9.0) still send data along with
> +                 * the SYNC packet.
> +                 */
> +                has_data = p->normal_num || p->zero_num;
> +            }
> +
>               qemu_mutex_unlock(&p->mutex);
>           } else {
>               /*
> @@ -1269,14 +1330,29 @@ static void *multifd_recv_thread(void *opaque)
>           }
>
>           if (has_data) {
> -            ret = multifd_recv_state->ops->recv(p, &local_err);
> +            if (is_device_state) {
> +                assert(use_packets);
> +                ret = multifd_device_state_recv(p, &local_err);
> +            } else {
> +                ret = multifd_recv_state->ops->recv(p, &local_err);
> +            }
>               if (ret != 0) {
>                   break;
>               }
> +        } else if (is_device_state) {
> +            error_setg(&local_err,
> +                       "multifd: received empty device state packet");
> +            break;
>           }
>
>           if (use_packets) {
>               if (flags & MULTIFD_FLAG_SYNC) {
> +                if (is_device_state) {
> +                    error_setg(&local_err,
> +                               "multifd: received SYNC device state packet");
> +                    break;
> +                }
> +
>                   qemu_sem_post(&multifd_recv_state->sem_sync);
>                   qemu_sem_wait(&p->sem_sync);
>               }
> @@ -1345,6 +1421,7 @@ int multifd_recv_setup(Error **errp)
>               p->packet_len = sizeof(MultiFDPacket_t)
>                   + sizeof(uint64_t) * page_count;
>               p->packet = g_malloc0(p->packet_len);
> +            p->packet_dev_state = g_malloc0(sizeof(*p->packet_dev_state));
>           }
>           p->name = g_strdup_printf(MIGRATION_THREAD_DST_MULTIFD, i);
>           p->normal = g_new0(ram_addr_t, page_count);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index f7156f66c0f6..c2ebef2d319e 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -62,6 +62,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
>   #define MULTIFD_FLAG_UADK (8 << 1)
>   #define MULTIFD_FLAG_QATZIP (16 << 1)
>
> +/*
> + * If set it means that this packet contains device state
> + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
> + */
> +#define MULTIFD_FLAG_DEVICE_STATE (32 << 1)
> +
>   /* This value needs to be a multiple of qemu_target_page_size() */
>   #define MULTIFD_PACKET_SIZE (512 * 1024)
>
> @@ -94,6 +100,16 @@ typedef struct {
>       uint64_t offset[];
>   } __attribute__((packed)) MultiFDPacket_t;
>
> +typedef struct {
> +    MultiFDPacketHdr_t hdr;
> +
> +    char idstr[256] QEMU_NONSTRING;
> +    uint32_t instance_id;
> +
> +    /* size of the next packet that contains the actual data */
> +    uint32_t next_packet_size;
> +} __attribute__((packed)) MultiFDPacketDeviceState_t;
> +
>   typedef struct {
>       /* number of used pages */
>       uint32_t num;
> @@ -111,6 +127,13 @@ struct MultiFDRecvData {
>       off_t file_offset;
>   };
>
> +typedef struct {
> +    char *idstr;
> +    uint32_t instance_id;
> +    char *buf;
> +    size_t buf_len;
> +} MultiFDDeviceState_t;

This is only used in patch #14. Maybe move it there?

Thanks.

> +
>   typedef enum {
>       MULTIFD_PAYLOAD_NONE,
>       MULTIFD_PAYLOAD_RAM,
> @@ -227,8 +250,9 @@ typedef struct {
>
>       /* thread local variables. No locking required */
>
> -    /* pointer to the packet */
> +    /* pointers to the possible packet types */
>       MultiFDPacket_t *packet;
> +    MultiFDPacketDeviceState_t *packet_dev_state;
>       /* size of the next packet that contains pages */
>       uint32_t next_packet_size;
>       /* packets received through this channel */

