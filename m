Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358F3CCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 05:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4vi-0005hg-Av; Tue, 21 Oct 2025 01:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vB4vZ-0005gr-R0
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:28:58 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vB4vW-0007SE-5d
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFT1lUDwqU7Nt/BgBps9Z9ahtpyDNrIMhIrIP93uL7C9c9LImdCRMFDlfGKO7/gAnrYqLq77Je/+3Ws5r6Nmg5GzE1kTRQzR2C0wQiF790hmIVVZkArgBxdCqPnt75RqiQM+czGVQjfY+5zwBHgFoEnacn4MPTUTTPq0YC5yFQ2wMWarePmy0unJ+gjNKga7bla7nYkkReLsTOhfagV+megAU6Lysnay7PmOkiQWR3utL4nHq8RGLUXfmw+Sqb4mdjVCE0Dnf+ip4CKXfE/W15jnCMSl/Q22vuevsmJXZ8QVnQxrPinGGOZFeGYXY4XWni8bTY1Id3Z+hKFp9psZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0LvfLJVAzMWdXzqk9X2xtGtlpX3f3c5O/fhM3KUAWc=;
 b=J050f+dyzxSek8V+dzxiSTujq2WibW2pAx2Ev3Ie4vKGa5iUoSssCfpT2O+VPshAy+aZOeWL0qGPh9n1HF4Ar59ke/cWzJg0IzNIdRi5prKRtW6KdTp8Sslz9VmLlCVJpG+xr1/CMZf1L1K4TLWKHBziKbAg6n/h+ORs4gTrp3kbPD3xYLB3KjMmBf0ySE8mp2oPrT7POQum5NWn2n1lpmdPjQ8f2ZYbNYmWNiKFdn3sUPBBZLyysp/wuBbDat9GIW7NnID9WV4mskSNX9Z9eEbDPq4nc05WiaPvfgwA2mxiAej5LInlhS5VGFileHvqLLu2S93oh8wTzMz5T5jHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0LvfLJVAzMWdXzqk9X2xtGtlpX3f3c5O/fhM3KUAWc=;
 b=UdSNa+sZCsIZxucWLYOuGL4nX9mG0saygMJU5IlWppWDhwjBJkTV1iomgXRUJVuB8oe9oDStCdpRYzlyhOOepcGGpt1Y0tVoIGPE81IjPgmM72pDZpfj3bceCs4SNSUYoYAxLnK+dTF7TU0NTpV3cT2agcECQ20u+HATa3QrCCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Tue, 21 Oct 2025 05:28:37 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 05:28:37 +0000
Message-ID: <7f4b9fe0-1746-4fc9-a319-abf13cf154a9@amd.com>
Date: Tue, 21 Oct 2025 10:58:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 alejandro.j.jimenez@oracle.com
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251017061322.1584-1-sarunkod@amd.com>
 <20251017061322.1584-3-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251017061322.1584-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e28c7f1-ee62-463f-ddd0-08de1062af5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2kxNWFXMTYzY014RGtYa01tT1U1aXIvaWp2dk5UQ3VhMEhJNWFzei96Zi83?=
 =?utf-8?B?SXUybUduQmlDa214d0JSQ3NwMk5va0F1bkpuY1B2VjB3Z3A3Rmw2UmhlcUEr?=
 =?utf-8?B?WDFCa3dERkpVMldSV3pLd3JrOG9GSUlrT2hUM1M1MUk4RkRuZ0s2QmR0em52?=
 =?utf-8?B?elVCa0RyUE82MElGQkZwYTNHNmxXcEFMOUxOREU4bW1ZK3VCbHlvTGpxQlBZ?=
 =?utf-8?B?UlBHTENUMk13UHdiTVZiZUhZbXUyQWd6Y1Fwdk5WdjFuNFR6NHF6S2hJQlZz?=
 =?utf-8?B?ckp1V0NpeDcvcXBCNlpRb1lKV1VRS2V0eDh2N2dKYmxjS1NUS2dWbTdzMXFw?=
 =?utf-8?B?S3BuOTR2VFVURjBJUmQwSWdJTFJkbS9jVkhUMmEzSC9lcCs4WnpXOFMxcFFG?=
 =?utf-8?B?c2FlWWJJZzZxOXVEWDdyU0d2NW4xcXRnTFpOZGtkczg0NDBTRXFEM3dudHhj?=
 =?utf-8?B?ejg0U0M1REdhT1dEdFJxK2tSTGd3M0VpN2t2WFRvdDMxalgrOVluZEI5WnBM?=
 =?utf-8?B?NURseks0TnJuN25SOElrTVBGYy9mOUduY0ZyYzhoblBqdWdLQ0ZBdHMxaWwx?=
 =?utf-8?B?NGRyaUJnWVdsRXVlcUtnbWFzcGFqRURpaytJREF3Zkg5aEFZTFI2cXI5ZzdM?=
 =?utf-8?B?a1doakNhZTE4eVhGN0JrVnEwR2R2SU95c3UzbndhMkVYd05WVmtjZ2dBMEg5?=
 =?utf-8?B?eml3UHJQZDhLaEI3cGN5bEFwbHFHZ0d2Q3FnUThPb2t6YW51OXFOV0lqdVV2?=
 =?utf-8?B?bnZreUdzemJjMU03amlNSW8zVUx0VEV2SXJpaUpZSXVjVWxzMUtQUmxwMmg4?=
 =?utf-8?B?N3lxZFJZeVlURDlUT3dUT1djak5adHV2dngxWXMvNlZoVXFQZkFTUVh5ZnJn?=
 =?utf-8?B?NVlGRFR1ckY2a0VKZ05mV01jRzhLMTdUMjAvMVVYSWR4c2FFcnlaWG5vRlFt?=
 =?utf-8?B?YVBrZ0x3NFdOakJ0eUJRN0w5R3YzdUhwdDNtcTdGcFg0WTB1SlQyei9qRVZp?=
 =?utf-8?B?M2toTmtwbWswN0k0Q0E2L01tM1BKTSt1WmMrNUVadi8rN2tmazk2NWZ2ancv?=
 =?utf-8?B?ZUFMdzF1cUVIZDdZcnpGdEFMaTZSd2R0QXF4T1A4ZFYxMy9rbE1DZzB2UmpY?=
 =?utf-8?B?TW9ZOTltRXFFZXllUEJPNXpOWWg5V045V0JnWUF3dmcwaVJQWktlSThIZjdq?=
 =?utf-8?B?aTZOMEwxRU5wWjhuRVY0U1RRNW11NDREcEtDR0pZcTNQaWZXcWlkUGttREdH?=
 =?utf-8?B?Q1pIcEx5UkVGbGswRFhKVXROK085N0lvUWRvZk9LNU0xMTZNVEJFRTRjT25x?=
 =?utf-8?B?YVJ2RWN1V1RmYWVhQmJoSTJvNmJidkR2bmt2cjJxSDA3bEMwT3JYbkt2QmMy?=
 =?utf-8?B?Uml3V2M5dmhac0xFd1g2aUlrd0lzNEVoZ0oyMU0wMGZUVEtwcnZIbTcxVFhG?=
 =?utf-8?B?VFo1UFpWMzNYdTREZjZqNWljem5NU1UvMS9tOTBqT1cybVhWcnBZaSswbEx0?=
 =?utf-8?B?Z1JVd0ZJaU5sdFBNNjFoODNiUkc0UENJbjJ1ZVEyYTdWRGhZSGljNHdnOW1Y?=
 =?utf-8?B?aXRxVzZYN0tOOUpzN1g4SkVWSVdjRFhlektWWWpQNGNSWmJzWjlvUldBYkNJ?=
 =?utf-8?B?Nks3dXFVQUlpUU5wNWVyU2JtWG5RVmtST1QvV3o3ZFk5TUsrQnJJUC9LZEZl?=
 =?utf-8?B?V3RKU0FRUU5UbkR1MkVqaW1FcWpUUkgrUkJ4cHJhd3VWR1NuRVJhQ2NTRUJQ?=
 =?utf-8?B?MDdhREhNbzNzYVo0TEVSTVpaYlFoQ0s4OEFJUFI0eWVDQzlUVUVkY2E3bDFo?=
 =?utf-8?B?Qnl1b0VDZWU4Vm5qZTV5Wld1VVFyS1hsMVEwcGFkckxPbXNRd291TzFjOVpk?=
 =?utf-8?B?VU1sNjJoYnJncC91RUpyRDVyK3c0QjRiWmZyMnJac1RCdmxHMlE3N0dwZTJD?=
 =?utf-8?Q?cu+9wMizy+xKvK2XBWxbaO51eiwRWFpV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzNvL3dMMUpzbUhKeldLa0dNdDNWWEFPZ3ExM2FKNW5Md1JkUFl1WGN0b2hU?=
 =?utf-8?B?RHVkcGQwOGl0ZkZ3a2xDQjZ5QnRKdURkVmlaOTcxZU9KcnpUaktwWi9paHUz?=
 =?utf-8?B?ZmNJaVNyY0RjSk9oaFBxNzlsRkwwbDJaUm1rNG8xQWo5OFJuSDE3Uk1iQTBN?=
 =?utf-8?B?aW9yaVpQVUJ1dEprV1NJSkdpTFRFaEduWTZYR1dnaExtSGJFQjVxZ2IxV0Ra?=
 =?utf-8?B?Wktod2YrNUdrb1dWTm8wSFBRZGtPZ2VLVldzM0l3NHp0Nlc4UVdFdjZPN1Az?=
 =?utf-8?B?bnpyblRENVZodkdxVVJBajRpWUpZMmhQbmd0N0I3aDlaS2hvTXNCL1VZUWNz?=
 =?utf-8?B?OWRyVWpjMHNRSHJvaE1DYmphdjgzU1ZmRDE3b0tBQk81eWZmNWxWN3pWK2NP?=
 =?utf-8?B?VVhFeGtiMGxnQktXU2JRVzlwMDhWUzBCZkZzS1huejhMcEdyeG1ibFg3Y094?=
 =?utf-8?B?b2U2Q3Y0aEF1NU5ncE1UM2xLL1ZpN2dFM0N4b04vQU9oTzE3YTVRVU1NWTht?=
 =?utf-8?B?R1JCUk9QdGY5NXVma29DUGM5Snd1TDZGeklQRVBXRXN6VU9QV2FEaHdqTEhk?=
 =?utf-8?B?MVYvRlg2dDdMaGJ5QnMrakM5ejFZVHlPQWZndC9MY3hmelJSTm8rUTlNcFdk?=
 =?utf-8?B?TEs0QkxaaDYvM3UxWFNBaXNtdDBNS0VvQVhZdUFRZjdnQkxoSFhMajc2cmdq?=
 =?utf-8?B?VisyWmJ1T0Y0K0FMRm1oRmpSZ1pzUy82aUorNytuakJHZDE3UmV4eDRENUdk?=
 =?utf-8?B?ZkZrL1BrKzQ1QXpDWmpkekF6WGlqOFprVW4rR05XRDRsZFJZVTlKUmJkWUpq?=
 =?utf-8?B?Zmd5RUNmSVkrMTRSSHRaTCtnSk1VSjBuVEJSS1lhYXd0aCs3OTUxTG9TdWtk?=
 =?utf-8?B?SmpZRmRDZXJhNk5FMklFTHZiZnU2dWJQSGg1UW5HMnlhQ0lSODJBSENqcUMw?=
 =?utf-8?B?ZzBlOE4rVmxBNy8yRFBSSUpWNEFvN0FGZ0FHd0E3VzBNM01LZWxKOTc1VnhF?=
 =?utf-8?B?dFIrMkdRc2k5QU16czdyLzV1dVYyWnl2VytZVE5jUytXSUpwV2g2ZG9aRHJK?=
 =?utf-8?B?a0doMGxqZnowKzRqUXpQMzN0YmxCU2EvSDBNVVlGT2txNkhFdERva2pGTG1Q?=
 =?utf-8?B?UVE1Qy9MRU1qb1dzR3NNYnNiOHhvQjNDUHQ3NUhCWHhpU2M0OFNVSE51c3Zy?=
 =?utf-8?B?K211UGZsM0hBUlRyZlFrRFJGU09LY21JQjJWYVRmU0R2NWc0REtERnAzWTVT?=
 =?utf-8?B?QWp0N3Y0SENEVHJBdEVDM2pQWXc0eXZoUytzeGl6TGpjTmpMWXNPLzFWSGVL?=
 =?utf-8?B?ZmVobnlxYVVyMEJKdkhLVjBBRXZJaDhoQyt2QU5CK1FuWTg0UzJFd1gzbnQr?=
 =?utf-8?B?RU8vSFhrNi9zN3oyNXZHR1p2UkNpblNkMDBheDVrc3ZhZzh4RHBHYURjT1dR?=
 =?utf-8?B?dzF0SVRmcWxpNjJnbGZRc3EvSzlJNkZWK3QzWExYbXp5cW1Dc2xkNmtyMGs0?=
 =?utf-8?B?ZU83MnFPLzhpbFhnYmNSVXhTdkljY0M0T1h3UnY0Wmg4ekpyWTFqdHpkR2xO?=
 =?utf-8?B?K0lMbExOMSttamtMelRSbEF5cG5ia01kOFVxbFpIVlVjZlhoOUtJTDZFY3lx?=
 =?utf-8?B?TCtONVVhTk04K0dlUHJYUVRUbEVCV1JvM1htWGZRell2RHVOSHJVMDlXbDVa?=
 =?utf-8?B?OXdXSWZmU2h0bHJyL1dlRitMUGlVWGdKWlEyRElsMnMwclRzZzdsOXh4amcr?=
 =?utf-8?B?bWQ4YVdEalBCWjlOd0gyalNDeldiYnlWQmxCRzNOQ016Vno1bFhDQnYyQklz?=
 =?utf-8?B?SkRKVkhFL09wMHYvNHJUTDRQK1lhekxTTEQzWGpoOFZKNnR1SDE0NVpDN0tD?=
 =?utf-8?B?SWNWdDFrZW5qYWM0TnJ4VzhoaElJT3RVeWtxbnY1M1B6UGVCY2IwdXNSY1pY?=
 =?utf-8?B?UVpEZDJvU0s4d2xuQ2ppYXVzcmlyVU9aY3dtVjM5S25XL0k5dHViQ3RoWitx?=
 =?utf-8?B?aGdrVlJQc080ZWpBcFNFTW4rTkp5ZzNibWtPNWFHZENDNUFUWTZvVnFQSndF?=
 =?utf-8?B?TGh0cFZGU2twNHEwUVdKZGZicWlrT041RUFzeEdjN3U4dThVeG4xUUtmWmhF?=
 =?utf-8?Q?0u+W34LX+OMjbsfSblDbots/Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e28c7f1-ee62-463f-ddd0-08de1062af5e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 05:28:37.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4qx3gqJQm1XDTbqOFHKq7Dg8/ZcCiCoa/IDBQa7ft3jkhUGQECiEvfz7WehZ3vchW6KQyDfM5LVo+5UQrZfOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Vasant.Hegde@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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



On 10/17/2025 11:43 AM, Sairaj Kodilkar wrote:
> Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
> to read or write from a given DMA address, IOMMU translates the address
> using page table assigned to that device. Since IOMMU uses per device page
> tables, the emulated IOMMU should use the cache tag of 68 bits
> (64 bit address - 12 bit page alignment + 16 bit device ID).
> 
> Current emulated AMD IOMMU uses GLib hash table to create software iotlb
> and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
> to 60 bits. This causes failure while setting up the device when guest is
> booted with "iommu.forcedac=1".
> 
> To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
> entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
> the devid to construct the 64 bit hash key in order avoid the truncation
> as much as possible (reducing hash collisions).
> 
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant



