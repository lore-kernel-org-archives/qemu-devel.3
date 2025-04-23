Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A563C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 06:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7TGE-0003PG-D1; Wed, 23 Apr 2025 02:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7TGB-0003Mf-PM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:07:03 -0400
Received: from mail-dm6nam11on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2415::612]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7TG8-0000az-GL
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:07:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G25jm0XFzHgnMTqmvDGhV3Cz93g4UYmSNWcRG169tenOptOHgBjbOLQXzrHqwC9Ejw7ePKybT60fyh1T2hzzPHxHU8KbT4duZDHCZfZhKkGEaBxPzAXvtqY6ofj/UrdlEoNUaTBDlRG4MVg+DbDfzQgnskZnQHpnn0JMKfjB0twmoAiu9w5fBJ2IUY2jgN+L7boD36wK0NTmpNumQh/shhFZ3kcoDsiSxnB9w/1Ylud2QwngEHOV5HPY/amHsOqYCeHt2AkG613G1j5Up8GMsMR9xaPWouEixdSFW1ywnly/huqjYe7CxkxdfR362Ksnt97atQto0+BI+Lu83Wy9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB4HEcxtoYTaULgaAyyIQWeMqCiFV6+moKvMK6TQ8wM=;
 b=LMUtw2DH2e+gl3FKsQUPFciPN31I2GeGymbCY7BWSJ2OmXh8wPv300khML1rDNhyubyHdznO5Jt1uu7hSAjubSOGTg5c6dwltlLOxcW1AKdPLEOgsrqoLagD3qP1KSrpIGDHuSZlXWEXzxyeAhZ5WFjI6tdMhha02TUIwEKZ/kdXMuuJJY6Y3ClYUCzwYjPPfjj/OtKIBzaJnQcVLdCNwC0IbLE9a68P4tjFVsGTnlWO3YdbZN4dQS5xgsRr0LqYYz1r5twRavEOolDU4mWmJCNT4ik1071cNBaMI7kUBz1112z0VTbpODxy3apen6m6wp86yNu4t2zycK2SRnaZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB4HEcxtoYTaULgaAyyIQWeMqCiFV6+moKvMK6TQ8wM=;
 b=vR2cNrkUAGNuSqA5FXqHEgAaYlOpqPf1NZx2nByyIZRK0+y7lX7wkaSO1E9tpdmMquJvZG5gkqc1SrntBWStM+UnypmNRyenaxgHm0G6reC9Eq373aG1F5gGFscwuhrC4eM6PaYflqtyhbvI6nA9EwxmE341bFHwjDSepOMoyL4=
Received: from DM6PR06CA0080.namprd06.prod.outlook.com (2603:10b6:5:336::13)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:06:52 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::c0) by DM6PR06CA0080.outlook.office365.com
 (2603:10b6:5:336::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 06:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 06:06:51 +0000
Received: from [10.85.41.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 01:06:45 -0500
Message-ID: <9896f1f6-d97d-4ec5-b8f1-0860caf2e8a2@amd.com>
Date: Wed, 23 Apr 2025 11:36:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] amd_iommu: Do not assume passthrough translation
 when DTE[TV]=0
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-17-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250414020253.443831-17-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9cc854-ae16-40e6-0736-08dd822d0a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0toUU55TVpXeW9pOHlPbGtqK1J2WXRuazcwU1NQejlqYkhWWUFyb0s1WWNH?=
 =?utf-8?B?S1dCaWVLZUhmU3VkRkRXTUVTejF1MnNtZ1M5Q2hjZHhkUHdmdWFUT2c1eGVV?=
 =?utf-8?B?dVdjc2dmQWhyNW93cE1CVE5VUmJGeWVZMlp6SVRRNEs1SSsrQ0pRMC85WWtK?=
 =?utf-8?B?bjJrUFRJK1ZrUVVmRUJRdUtPeXFCbEd2ZEd3eEpENlFwMTZwZU5JMGNBakdG?=
 =?utf-8?B?UGJlZ0NaNGFMcFR5U2xmRWlTejNsUk5URVZWeXh0aTVEcUlPNlZzcUlTMXRM?=
 =?utf-8?B?aXBDYmFmam1POVN2OWxmanF4eXhVMTFlU2o2QnpkRGZHSDdBMU1rTXpqOXlt?=
 =?utf-8?B?UnQ4TFU0RDMwQ1F2M3FWaHpVRzR0YmJTQkVHYlM3UFVNTnF1Zk5obll1RGpI?=
 =?utf-8?B?eTdNNTNjZWI2VXpNelplQ2dhWGc3Y2Vtc2hnQkZITE8zWWNESWdPQWE5M3Fy?=
 =?utf-8?B?QTR2alFyWjgvSk1XTmVTcFNOUW0vdTZaUHIwT0VYaXBxNWkzZHJkRWJSdnFB?=
 =?utf-8?B?UmozemlZZWRkOGlYMFFnUllJbU8xRlJGYVVkNmNtUlQrWkRlVzVXZE1zUDFs?=
 =?utf-8?B?WFd0a0wya2tMVFkrL1EyM2lHZER2UlQvNkdyY2JkeWhmUElzN21zcC8ycVRo?=
 =?utf-8?B?NlpmS0V5ZFhna3BjZ2VEOG0yaVV5REU4ZHQ4dUFyYXZKUTYxR3VCVjRTcDVD?=
 =?utf-8?B?Z292bVMvbFJmdTA1bnR0YzFIM2V5T0NiWEYwRER2T1oyemhQSW1MaVVKU1c4?=
 =?utf-8?B?RDBjbGpBVzR0dVVjR0RzSkI4MlVIUDRxSGNzUzFSTXV5d0JUcGMrRjZkOEdk?=
 =?utf-8?B?Rzh1bDNkZ2l5ekZzYlYwWjNpTGJ1TVl1dGI2ZW5Gb0p5b3U0YkFFU2xSWUlO?=
 =?utf-8?B?RTlvMjZtSzZMUUN0b05oYW9jY1ZrKzBQTHE3WHJPWTFKbXpqdE00am4wYWtj?=
 =?utf-8?B?VEMwNHkxMUhVakE4eUpRQ0FiN0tYOGRNQmFkNkd1aFcyeEgrbHBOQVd3SEU0?=
 =?utf-8?B?Zno3L2pHNHJ2VjlCWENjZy95OS8xeSt2cGh5SHVSTVp1S2c0WlYvTXI2bDBu?=
 =?utf-8?B?NjlhT0gvaHI4YStWd0lsWTVUcHpjWUNaTGVHYWFHaXhhQjQwT3hiVmtKUEM2?=
 =?utf-8?B?cTVSaDN5Sk0yYSsrcGxtNG82c1JGc3BENnVXeFhQNmZtcVpwbkxzNmZ3YmQx?=
 =?utf-8?B?aTVGNncxUVJsZnVXZlhkRWc5VnplRkRXZlZReTZXYi8wbjZIVEhBL0pNQmlS?=
 =?utf-8?B?THF3L2hJMEFQL0h4OFlKRnVyank1N2RpL1R0bUFtSmVwVlZOZHdPb2pXeVRk?=
 =?utf-8?B?SHNJWmh4emI1TTNLNGRTNDd1OGJ3V2V2bzlRQzVNVE9jNVZDY2t2UFZ6VU5a?=
 =?utf-8?B?cVdmaHNDbHlKY3hBOFppQzQ0TXdta1M4cVlQM3k1Y0hjVkxQNWE1Q3JGeVd5?=
 =?utf-8?B?R0MxVkxSblFxeDRBK0JjOGQ5alMwRm5KbndPTmN6dThBSWFtQmdlZmUxaGtl?=
 =?utf-8?B?UUdVYmtYSlBNN3RXTjVkYnVjcmpqN2hwWWNwbmgxdmtSeFNjL0NBNW5YcU43?=
 =?utf-8?B?VWRzTlY4cm1mcExWMXVsZEJwWDhFVGNiLzhNbThjc1VmeWR5YmY3Z2tsbEZS?=
 =?utf-8?B?WmhSQ1RRbzFCQ2hsVTV5dkNWZEdkY0pMT0daMkJZOXEzVVZNN3lxckRFU3Zm?=
 =?utf-8?B?ZWRiUHVzTlRxR0ErOVFUTEhFWmR4SFliMSswNk1EQWtwQ2pGZFNIYTBKazJs?=
 =?utf-8?B?VXVhMHdKQ2h0ZG95V3BvSEdSUU92UDVhVXVRRUN2Z1YrbFJPWFhpOFZabFZG?=
 =?utf-8?B?aVFZZXZha0FoVWJNa1pZRkVtYUwwQWNlcUFUZEJxTDVhcnlPZWt1bnI5R2Nk?=
 =?utf-8?B?Vmx0OGs1YmZKRTg3a0xpTU4vS240NERPRXZJSE04MytwRWxCYUtoeUJsTUZv?=
 =?utf-8?B?UFR3N01UZWQ2OHlQaGZOTFVkNVA3YUpQODEyTWI2MXZjOVRzL05kUHM0TXZi?=
 =?utf-8?B?L0s3cUlSVll6RkUxaEVPblJTVE4wazdKVjFmMFJIeWJUdHgwTE1YeEdHWGp4?=
 =?utf-8?Q?6lcxa4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:06:51.6278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9cc854-ae16-40e6-0736-08dd822d0a75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
Received-SPF: permerror client-ip=2a01:111:f403:2415::612;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
> The AMD I/O Virtualization Technology (IOMMU) Specification (see Table
> 8: V, TV, and GV Fields in Device Table Entry), specifies that a DTE
> with V=0, TV=1 does not contain a valid address translation information.

This should be "V=1, TV=0".

Regards
Sairaj Kodilkar

> If a request requires a table walk, the walk is terminated when this
> condition is encountered.
> 
> Do not assume that addresses for a device with DTE[TV]=0 are passed
> through (i.e. not remapped) and instead terminate the page table walk
> early.
> 
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 87 +++++++++++++++++++++++++--------------------
>   1 file changed, 48 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index e502bbbbb7d3..edf2935f6a83 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1221,51 +1221,60 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>       uint64_t pte = dte[0], pte_addr, page_mask;
>   
>       /* make sure the DTE has TV = 1 */
> -    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
> -        level = get_pte_translation_mode(pte);
> -        if (level >= 7) {
> -            trace_amdvi_mode_invalid(level, addr);
> +    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
> +        /*
> +         * A DTE with V=1, TV=0 does not have a valid Page Table Root Pointer.
> +         * An IOMMU processing a request that requires a table walk terminates
> +         * the walk when it encounters this condition. Do the same and return
> +         * instead of assuming that the address is forwarded without translation
> +         * i.e. the passthrough case, as it is done for the case where DTE[V]=0.
> +         */
> +        return;
> +    }
> +
> +    level = get_pte_translation_mode(pte);
> +    if (level >= 7) {
> +        trace_amdvi_mode_invalid(level, addr);
> +        return;
> +    }
> +    if (level == 0) {
> +        goto no_remap;
> +    }
> +
> +    /* we are at the leaf page table or page table encodes a huge page */
> +    do {
> +        pte_perms = amdvi_get_perms(pte);
> +        present = pte & 1;
> +        if (!present || perms != (perms & pte_perms)) {
> +            amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
> +            trace_amdvi_page_fault(addr);
>               return;
>           }
> -        if (level == 0) {
> -            goto no_remap;
> +        /* go to the next lower level */
> +        pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
> +        /* add offset and load pte */
> +        pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
> +        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> +        if (!pte) {
> +            return;
>           }
> +        oldlevel = level;
> +        level = get_pte_translation_mode(pte);
> +    } while (level > 0 && level < 7);
>   
> -        /* we are at the leaf page table or page table encodes a huge page */
> -        do {
> -            pte_perms = amdvi_get_perms(pte);
> -            present = pte & 1;
> -            if (!present || perms != (perms & pte_perms)) {
> -                amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
> -                trace_amdvi_page_fault(addr);
> -                return;
> -            }
> -
> -            /* go to the next lower level */
> -            pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
> -            /* add offset and load pte */
> -            pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
> -            pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> -            if (!pte || (pte == (uint64_t)-1)) {
> -                return;
> -            }
> -            oldlevel = level;
> -            level = get_pte_translation_mode(pte);
> -        } while (level > 0 && level < 7);
> +    if (level == 0x7) {
> +        page_mask = pte_override_page_mask(pte);
> +    } else {
> +        page_mask = pte_get_page_mask(oldlevel);
> +    }
>   
> -        if (level == 0x7) {
> -            page_mask = pte_override_page_mask(pte);
> -        } else {
> -            page_mask = pte_get_page_mask(oldlevel);
> -        }
> +    /* get access permissions from pte */
> +    ret->iova = addr & page_mask;
> +    ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
> +    ret->addr_mask = ~page_mask;
> +    ret->perm = amdvi_get_perms(pte);
> +    return;
>   
> -        /* get access permissions from pte */
> -        ret->iova = addr & page_mask;
> -        ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
> -        ret->addr_mask = ~page_mask;
> -        ret->perm = amdvi_get_perms(pte);
> -        return;
> -    }
>   no_remap:
>       ret->iova = addr & AMDVI_PAGE_MASK_4K;
>       ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;


