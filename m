Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA20C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 12:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7CiP-0005Fm-7f; Tue, 22 Apr 2025 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7CiM-0005FJ-Ft
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:27:03 -0400
Received: from mail-mw2nam10on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61e]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7CiI-0004pK-PN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:27:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsKUAkyqjYgrWSGuyeeADIbTcbvO5ilqWXLvVB8bf2glvQvF0wuKfpq6ZBDK15V9GB0mhUNy/nUyEhAy/unvHbeLqU5hiOQHSgTEsFL0+FW9zAR5QE1NzmUhrEnkX/J8zQYgvYG7O4VEJi/b3QPPR85pM51WRmtSMKACUlVl3jCgyZD8reWK5qYcX0PWPMaQa3Na+0nur5zSQATVjinJlHTZxCypUkua4bnH3fieM84AH3zUAMP3gNcyjSr+uYIjRhzuw6ybAz9kx3KiMXe8s5s0ePBc2Xf6fEu6hlsRNRyTj60tn367/W986xQl9vn36dD/587spKE8K8JaMZWfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWoDhmMhTaIBm7WJKd1E5YgP1cKlnkBr2oPmu3Uhi1s=;
 b=RD2BoZ9AgqnpAGzGdrY8RtapALsdN9c0CVUMSOrXFeVDD1WrrjQXLf+ZbkxH4Y/oszdERFPjnZggBQNR+wLqnyL9CCRhaNBcUSTsjjTET2wFzZfrd42z3bvQmSQDIlEF5TEnlaRCeVVO/2/VZFoDVLnZxMpYXrB6ieP3J3hXueLshENWG0DZYaaMJxFc0XMHVEkWjs2ka2CiCZZqXyjqSwCt4qHo+QzzTxuh3Tf+L8rlaEQZRutdw7dcNVXBa0ev0v6rl2P3C1SGCJ8mAi1Ru3kBRkwX1WrBhqh7PcSuCRt62OCefci9mpvzp5mhlQ9BqL5BSDPOApuA58+7ze+qyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWoDhmMhTaIBm7WJKd1E5YgP1cKlnkBr2oPmu3Uhi1s=;
 b=PTDs3hVs8ay97ah2vac6bUJg20RkBGA3mdkVZX6T7KP82dT4iFBGLx9mLiJ1OjMKsPq6jmB8puikVVc1XXzt9mV2owqJBIelwgWwB2ZNs27YdPOV87qNUIDMC9Jx4Pb9a12mcUzB5wLQ+k1lFoMEZW/euRO1oePlCdsZlB5BlEk=
Received: from BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 12:26:50 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::4d) by BYAPR07CA0086.outlook.office365.com
 (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 12:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 12:26:50 +0000
Received: from [10.136.47.77] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 07:26:45 -0500
Message-ID: <36a69911-ff85-47e4-a34d-cf5e934d85da@amd.com>
Date: Tue, 22 Apr 2025 17:56:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] amd_iommu: Helper to decode size of page
 invalidation command
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-9-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250414020253.443831-9-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 37755cad-b1d3-49ea-2020-08dd8198f52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGEvdjRNZkJZQUhmdnJXallNMXd4cmdoMUV0RDh6ZmlCbHZPVVJpNHM1QW1n?=
 =?utf-8?B?N2lRcS9vVzRVckdFUjBFZnRJcGRrR0NMNFp3cmdBcHFrdmtPU2NkUEE0blR5?=
 =?utf-8?B?QUZCcHN2dHdWNFFKbGMwL0pPQTVsVXpmOWx2YjJZSXB2eHlEeGw2UUdZQTZL?=
 =?utf-8?B?c0MwR096azVBSzdVcG11dnl3eG9lOG1wZ2ZxVVZvSzFHOUFQci92Q01nSW9Y?=
 =?utf-8?B?M0NSQ0Nzc2ZQNmZsTTV2TWxqOGlsOWlMMTFHdDhnaHJueHlqMTJ6VnhzVURw?=
 =?utf-8?B?bmJpYWdBT1dYcEoyQWttcTVzQUZKWWx3bFlERS9KT05TSjJJNWR6c2ZWcU92?=
 =?utf-8?B?c1Fnb29nYWx6MVJXa0lLSFZMQUhzNmsyRHFLK3l5cnprVTg2d2t1Q0tsZmlF?=
 =?utf-8?B?WDJLM2Jzd1U2RlpNV1diRjBmcXR6cXJSYk0zbHBvbnZORFVCeStEWG1oQUVz?=
 =?utf-8?B?bkpBcGdSb2U4bkdRd2liN1dIVVJCNVY0bGQzNmFVQ2NPeXVBKzlMRExzTDVa?=
 =?utf-8?B?dlE5eEswL25XUXRMSHYxZnFTQ2JxZlFIcHlqQ1U1R0VQbkdDNE1ocnAzVk9o?=
 =?utf-8?B?WXZpV2wrODAvK2JIdU40TGo5TkdUdUlKQjNyUDJnZDdvSmdZdnhFK0xUMk5k?=
 =?utf-8?B?V0p0dnlrclJ1aUtVdE80bnQyQUpuajVWTmhsVGlCSnFxdVN2eWNFM2ZXU3ZQ?=
 =?utf-8?B?cElZZFFGVXAxNDFXWHRaOUtqMW8wQnQ2SFovQWpLcHNCUi90NnN5VVFsTVFZ?=
 =?utf-8?B?UEpPNGRWaWVLYTdpRW8wdTVleVYyMWovSTROZ2U0MkZ1WGhJa1lLbm9zcWFk?=
 =?utf-8?B?cno5YXRjbTVjbXZYOWpHU01haytaVlZUYXVLaGNKS09NNUFhZ21SNFREUU5n?=
 =?utf-8?B?YjN5dkFRN2ZGMXhrZUhnV1dJQkJGYzBVcHdjK2lPUVZ1N3N2MTNOSFVGcUJ1?=
 =?utf-8?B?WExFYXgvUW9ZYlIwT24vOGpuQzhyUm8xZWFIN2J6Mk50TlZKME9RM2lOU0Ji?=
 =?utf-8?B?TVFMWkRTKzAvQmxVQ1B6UmJQSFJGNEpmQ0NCS3F0Z1RMWFBFdWRqQWlFUlE5?=
 =?utf-8?B?MUtQS3Erc09TNHFCWURyK1JENWVMYkZnTGlRK01PNWxTQXlIRjZHVDFXKy9x?=
 =?utf-8?B?MGp0V1A5QWc5SXpSL0NGTFRLU0xuNFFsTkEwWnczeXZqMm8wc0dwempWTGVl?=
 =?utf-8?B?TWdSY1VMSlQzWW0xcXkxM3Q2czZFaFM2QlVRV1pWZ0dNNThpK1VkWktuam5l?=
 =?utf-8?B?Y3VMMkJYSTNuVmhtRnlBODR2ckZTcTVHRytRN096SUVoc3p3NGsyTEJrdWV3?=
 =?utf-8?B?SmFqbytBdmsyOXlXVUNYeGVZd0xyaTBCSDRDWWhOV1RCZUNLaVJXNnBndlNS?=
 =?utf-8?B?WUM0Z2hmZGJqejBXUjlYWGNOcHhSOTFvS1dZdHRkOVBhZlZWc1l4S3RrQXlN?=
 =?utf-8?B?VnEyVDBMeVBsWWRoY3M4bWxoWHI3b1BhTDRYTDlpMEZiL2VpN29EQmU4OFZW?=
 =?utf-8?B?dithWG9vUkF4VXBOQnllWFV0U0pYMXNUY1RuZ01vakZpd2F3RjZwQTFvWWt1?=
 =?utf-8?B?d0NKeXlsYkJPOHJ0akJXaGljUThKc1RjMU1XTUJMYmVxREdBTXU4YWxVbzYz?=
 =?utf-8?B?aW1MemtaaHYwYUh0OEp6MTRKcXJCOUNkVi9QbW5BaFFJWlByaGZHcllMR3J1?=
 =?utf-8?B?ZDQvZXY2VTAxakp0TmREMFd3WFhzRWdEbU84blNjSm9ZVTg5VnRLTStHL3Uw?=
 =?utf-8?B?NlZUa0FpM1Zta1B6eWNlNEgxenhFUzVQZFpoNUFRaGNmYkpmYmNlNm5XNkpY?=
 =?utf-8?B?OUtOUU9DNkh3ZzI1QnBWVjZ5R0RwbitQOWtmeXFmSFl0dGpwbm1QZVlNQXBj?=
 =?utf-8?B?V0Z6MDArU1k0ckd0cVlXbm1qdmdpL0FhZmNGT0RObmgvZXErR01MbnhlS2Ur?=
 =?utf-8?B?elZzOHBiNGNJUHRCREQ0eVp3c3pZekoreWJ2NTc0dGNUY0RrMEdxb0JsemFj?=
 =?utf-8?B?MGdPWUF3YVRScnFHcVhOci90QkQ5SUtQQU1oN1MxOGhudHpaWFh2em1vNmRn?=
 =?utf-8?Q?m/2wE5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:26:50.3328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37755cad-b1d3-49ea-2020-08dd8198f52b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
Received-SPF: permerror client-ip=2a01:111:f403:2412::61e;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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



On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
> The size of the region to invalidate depends on the S bit and address
> encoded in the command. Add a helper to extract this information, which
> will be used to sync shadow page tables in upcoming changes.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 34 ++++++++++++++++++++++++++++++++++
>   hw/i386/amd_iommu.h |  4 ++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 5f55be1f4d36..0af873b66a31 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -481,6 +481,40 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
>       return entry->domid == domid;
>   }
>   
> +/*
> + * Helper to decode the size of the range to invalidate encoded in the
> + * INVALIDATE_IOMMU_PAGES Command format.
> + * The size of the region to invalidate depends on the S bit and address.
> + * S bit value:
> + * 0 :  Invalidation size is 4 Kbytes.
> + * 1 :  Invalidation size is determined by first zero bit in the address
> + *      starting from Address[12].
> + *
> + * In the AMD IOMMU Linux driver, an invalidation command with address
> + * ((1 << 63) - 1) is sent when intending to clear the entire cache.
> + * However, Table 14: Example Page Size Encodings shows that an address of
> + * ((1ULL << 51) - 1) encodes the entire cache, so effectively any address with
> + * first zero at bit 51 or larger is a request to invalidate the entire address
> + * space.
> + */
> +static uint64_t __attribute__((unused))
> +amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
> +{
> +    uint64_t size = AMDVI_PAGE_SIZE;
> +    uint8_t fzbit = 0;
> +
> +    if (flags & AMDVI_CMD_INVAL_IOMMU_PAGES_S) {
> +        fzbit = cto64(addr | 0xFFF);
> +
> +        if (fzbit >= 51 || !addr) {

I am skeptical about the condition addr == 0 (!addr)

Consider the case where user wants to invalidate 8K size page, starting
from address 0. It'll cause address field to be 0, right ? If so, then
we should invalidate only 8K page not the entire address range.

Am I missing something here ?

Regards
Sairaj
> +            size = AMDVI_INV_ALL_PAGES;
> +        } else {> +            size = 1ULL << (fzbit + 1);
> +        }
> +    }
> +    return size;
> +}
> +
>   /* we don't have devid - we can't remove pages by address */
>   static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
>   {
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index e12ecade4baa..c89e7dc9947d 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -123,6 +123,10 @@
>   #define AMDVI_CMD_COMPLETE_PPR_REQUEST    0x07
>   #define AMDVI_CMD_INVAL_AMDVI_ALL         0x08
>   
> +
> +#define AMDVI_CMD_INVAL_IOMMU_PAGES_S   (1ULL << 0)
> +#define AMDVI_INV_ALL_PAGES             (1ULL << 52)
> +
>   #define AMDVI_DEVTAB_ENTRY_SIZE           32
>   
>   /* Device table entry bits 0:63 */


