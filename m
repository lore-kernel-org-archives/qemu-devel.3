Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DBAC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 05:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsEiD-0007QE-6C; Wed, 12 Mar 2025 01:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tsEi1-0007PF-Pk
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:32:51 -0400
Received: from mail-dm6nam12on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2417::628]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tsEhz-0008NN-71
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:32:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frTt7wZrITeEAuOtFMM54UFyZMXo52mPXMepZwWHNIIDxJ2msREnVZg0z05MygWaiedcDRJEMtx1/V2ajAw8eQUNlN3Wv/8AZqc2DmhvQcA17UOdo2g3HppVeCv9rVjljE0GS2ku7q3a4UvptDqvzBUZ/rkJvXdkrB/C2jLEQn8gv2lFIsYvnOAhFyGyuud+CMEi9cQAsHRDtG34tQnLAtrbNc6UMprA3XfUEK9fSod2eK5J3U25iqwXkzUoos54zQEq0JLKG8IICJvm5xWBV5HeRglX8+XouaZqEwjzYSp+kPlfdfg2MQD8OcdDlNZaWSctdJ50BY5EeokqipfL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWhWpQ+ego3iPQJMzCajpgHnE7T+zd1r2dyZhHBZP7U=;
 b=OVagr5ZtVLgulSIBl9Rvh4rqFMkwIZBEAv+ivnzkLivIi3yLffitpOHp159+8q3yG20cNW/RQrak3lN5sum+XkbmPAmzRPb1mqXyo8Q6Flw6ZoD0UG3AH8MLWCDxoDXj8ec2FF7PsQsdn004vSfaxPfA5tiUaz9jTDa2t+rScDCktrpC8LujNqxfLy2tZK/EgER4vR3Vi2VX71kxVG/oZd9DWKiK2YJZ11tEvsrQbW9CojKolUao6OEjN2Xc56cINg81+H2+IQ6PWIJyshA/EnOYVSmKrV7SMpiPK02UYjzybBkXpAOYTbOo2w3dorwQOG+9XgIl7LsyH8ZFbMFlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWhWpQ+ego3iPQJMzCajpgHnE7T+zd1r2dyZhHBZP7U=;
 b=jVoqZv1Zl1bjDIHuNNaI64SAUQ55y7g2L7qLiDjuHhNOPTH5cEc4+qKLyI4FjY/ykYC1JVFRWQ5hy4ON2Pe3O6q8Ks3AE2oNO7n6XCVOGNt/k4KjkmQZHeqeFbho5xzhPZDw1aA2bv2SzpQXUyqPlVHpAsQpZsp7Yc2DmmYbxHU=
Received: from BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:32:38 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::40) by BL0PR05CA0005.outlook.office365.com
 (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Wed,
 12 Mar 2025 05:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 05:32:38 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 00:32:34 -0500
Message-ID: <7dae6c38-ce0d-4c91-84e4-9e6859cc0cf3@amd.com>
Date: Wed, 12 Mar 2025 11:02:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] amd_iommu: Fix masks for Device Table Address Register
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mst@redhat.com>, <mjt@tls.msk.ru>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>, <sarunkod@amd.com>
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-5-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>
In-Reply-To: <20250311152446.45086-5-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2845b1b1-bff6-48f7-0062-08dd61274d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGRuNXk3MTlDZE9zY21HbkI1UDRQdk1ibStNVFlXUGJaVnFmZ05neE5QSG9Y?=
 =?utf-8?B?R2FGNnpNeE5weW1nTmFjZzN1RnZWRng3MTdURUZVT2ZJc1hSYjduY3lFaXpa?=
 =?utf-8?B?K2FNbmdDVUNLU1RPNnBzcUZRZXlpK1hyRzFBUVNlYXJZNG1uakFZbytQT2sw?=
 =?utf-8?B?YjFQOVBBYUgyRmNLL0pwV0JyaDR5YU8rSGlLWUh3Y01YQVNUanc3cnV2RExx?=
 =?utf-8?B?RFROOWFXclpQdkVqaTRpRWZWN21PYlNKK3BNbXlFb2s2d0F2cFNneTFSdDdY?=
 =?utf-8?B?bkhXM2ZPcVIrSU9XUllkYTF3SVNNT041SkU2c0ordS9vREloakNTdCtGOHZY?=
 =?utf-8?B?T0I5Sk4vR0VnSWpneHZRbSttc1hrczFGVzRuOFlIb1RKRDRvcWUxWVBUTVdJ?=
 =?utf-8?B?cWIwU01CTEhaVU11RFp4ZXhnVTl1Q1E1K1V2OXMvc01GdzEyY0dYdnR5dTg2?=
 =?utf-8?B?WGxnY1EvWDFaa1puTEN2SmV2dnJjQWgxeEVhOG1IQ3ZDNmdkZTUrbW5qN0lW?=
 =?utf-8?B?a2MrSnBydHg0QkxBU1Y1UTRBd1k0b204UTBTTkVTazl6QkVPekxkR25lOCtn?=
 =?utf-8?B?L1lIa002LzhlajhveWVwaTdIZWp3TjVmMGxFWjY4ZmNYR3Q0N0xzcGJlRUh3?=
 =?utf-8?B?UXUvSzBYSjVqaFBDSm1Ld3VoRXVndkJSenFzSHJOMWF2NDYrdEpzcGtmTkxv?=
 =?utf-8?B?MkFZS2drMjA0aDJra216dE92eEhxWFFzVjFDd0lDYi9UM0JZSXU3YTVlelY4?=
 =?utf-8?B?NHR3QkpUY0laZGpNcCtUVXI2MDZTbGtnNExFRDFocEVETzBmUk9pR0tlRVp0?=
 =?utf-8?B?anl0eWNyNzhsMUdWVEdOcFVPR0VZMnVMQ1AzU1NmRlRKTXlreHRHVU9nWG00?=
 =?utf-8?B?NzJDTUhhemxqdG5RQ0p4UmxGYnpxR01jcjhRLzhsVUFWUGRIdEZIWGhkT3Z3?=
 =?utf-8?B?cmVHYlFJTUdUbms1alZOaW5aUDR4eTJZakd3WTVpV29ReHhKcFpJc1dyVkVn?=
 =?utf-8?B?VG0vTnUzR01Gc09xMzYwL0xybXYzOVZqWm9KR1N2SHp0MW9OeFlKaS9DRTRp?=
 =?utf-8?B?bVZWaDQ2WXNOWDRzVXlLR09EaGlMYVIwbDVtYlg4eVhlTlVDSU5WaDE4eWE1?=
 =?utf-8?B?YXNMQzI5WUtiWjJmbk01RlU5ZEdiVlU2YTFIU3JwRkhnaEJKQUVXQ25nSVd2?=
 =?utf-8?B?VFBMTmd1U0ZlVktWb054VlNiLzJFcGRuTnhQMEdsWHRmWWxqRzEzekllRHpm?=
 =?utf-8?B?cmQ4RlE4bk8vd0J2TE5xV1NOTm5NUUVaWDF0Yzl4cG9QcTFBRSthN1JOWS9h?=
 =?utf-8?B?R3BqV1AzSjFJeFY4RFExdVQ2M2hBVHNxVm5XNGlFWThuVjI3bERZZ2U4SWFL?=
 =?utf-8?B?cnNueEVUZyt1cCtCN1daR1RtU3JHdlYzUWNxZmdvd05vY05ObS9lM0Z0THV5?=
 =?utf-8?B?U0g4VytuZzIrRFBCb0taVWQwVVdhd3l1YktJb3Ixd0UzMVoyVThqdkJYNmNy?=
 =?utf-8?B?cVNhV0Q5WTEwZEE4Rk9NOEdkWTJZT2ZmWGYrOVlMUTJSNWgxYTlJT29kcnlB?=
 =?utf-8?B?blQ3TndXZ3VBbGZCWHYrdGZQWFhjQnR5OGMyczJQRmVONGZNdXZrQk5qdzdt?=
 =?utf-8?B?WnM3VzN4SG9yVW4rbnhCNktVU0lDT29zejMzbEZVQTR5b2x3RVJqb3VnSzRl?=
 =?utf-8?B?c1M0TzNZMm9oRzR1aDBwSFJPRTFtTUlPc0NRV0d5ZlM5ZGhIZFpxeUNOc1Ba?=
 =?utf-8?B?N2t5dkVPa2VHNzRCeDFxMzBKd1k1SUlQQjg3Ynl2c3ltcmxnV3VpQ0tmSGlz?=
 =?utf-8?B?K1hudk1zQVByWkV4bHIyT21hMWdaWWtQUjNlK0Z1OEtQVUIxYmxBQTJ3L2xV?=
 =?utf-8?B?T1ZaOThleEJGNDVGTzRvMGVmc3dVUnZhUTgvOVFxdUxFSTAvWFBGNjZMTFk0?=
 =?utf-8?B?aVgyc1dWenpHN3dvbmdSRjN4UmNlN2RSMlExUlYxUXZ0T3Q3T0lQZnBYYkdl?=
 =?utf-8?Q?q2CBAZ8Ak1Frv6ZqS/UXLuGbPSbvSU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:32:38.4742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2845b1b1-bff6-48f7-0062-08dd61274d4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
Received-SPF: permerror client-ip=2a01:111:f403:2417::628;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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



On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> The size mask currently encompasses reserved bits [11:9]. Extract only the
> corrects bits encoding size (i.e. [8:0]).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 8d5d882a06..2c5c8c70f1 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -68,16 +68,16 @@
>   
>   #define AMDVI_MMIO_SIZE               0x4000
>   
> -#define AMDVI_MMIO_DEVTAB_SIZE_MASK   ((1ULL << 12) - 1)
> -#define AMDVI_MMIO_DEVTAB_BASE_MASK   (((1ULL << 52) - 1) & ~ \
> -                                       AMDVI_MMIO_DEVTAB_SIZE_MASK)
> +#define AMDVI_MMIO_DEVTAB_SIZE_MASK     GENMASK64(8, 0)
> +#define AMDVI_MMIO_DEVTAB_BASE_MASK     GENMASK64(51, 12)
> +

Use MAKE_64BIT_MASK here as well.

>   #define AMDVI_MMIO_DEVTAB_ENTRY_SIZE  32
>   #define AMDVI_MMIO_DEVTAB_SIZE_UNIT   4096
>   
>   /* some of this are similar but just for readability */
>   #define AMDVI_MMIO_CMDBUF_SIZE_BYTE       (AMDVI_MMIO_COMMAND_BASE + 7)
>   #define AMDVI_MMIO_CMDBUF_SIZE_MASK       0x0f
> -#define AMDVI_MMIO_CMDBUF_BASE_MASK       AMDVI_MMIO_DEVTAB_BASE_MASK
> +#define AMDVI_MMIO_CMDBUF_BASE_MASK       GENMASK64(51, 12)
>   #define AMDVI_MMIO_CMDBUF_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)

I think its better to modify remaining mask fields as well (*HEAD_MASK 
and *TAIL_MASK). That way everything is consistent.

>   #define AMDVI_MMIO_CMDBUF_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
>   
> @@ -95,7 +95,7 @@
>   
>   #define AMDVI_MMIO_EXCL_ENABLED_MASK      (1ULL << 0)
>   #define AMDVI_MMIO_EXCL_ALLOW_MASK        (1ULL << 1)
> -#define AMDVI_MMIO_EXCL_LIMIT_MASK        AMDVI_MMIO_DEVTAB_BASE_MASK
> +#define AMDVI_MMIO_EXCL_LIMIT_MASK        GENMASK64(51, 12)
>   #define AMDVI_MMIO_EXCL_LIMIT_LOW         0xfff
>   
>   /* mmio control register flags */

Regards
Sairaj Kodilkar


