Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AFCC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 05:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv8HL-0008Ls-BM; Thu, 20 Mar 2025 01:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tv8HI-0008LX-Df
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 01:17:12 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com
 ([40.107.237.82] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tv8HF-0007iM-Cx
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 01:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZLH3aIish2L5JXQkuqUTlcttgZJ37OvoBOHaNgjZcV5Sri8puy//T9XqRUvuzPXHL8YUxWrSanLRGGzaF+YAR10HKZ5gNC1Rrlyfri9hqS/FW+vQlTXeIPIakS+Bf/aT0igwrOY3lLKVQO+19JPdl/cHsahCiCk8RkR4zf7AMraWEBrxjwmzPUFOoOIyH5MaDHAeuDq0P6L1CuLKhIr6KFikh8BQZcVo7EEvN57Zu15D9u5/VQsOEm1V31IV+d7Fm10fa6vhkaJ6BA2quQh53AC+gygaxXC9KNXVelckQi8/BIg5qB1PWaBqhiXoRVn8evH1NN3m8FLPKLdD4Ajzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBpV/Fv/1gM9o4Pwrk3wTlBWRxfo7KASfeFCh98XZgk=;
 b=n62ZOO38ljajFquu5nwEvK8FZTOqkNrXU0U4uipkngnBg0oMpqV+0dRE/0+rfiwc6336OFcfX48YbkhksroOmxicgYUvxN0+li+MQGgrcg2CJ/VSSKk/zzwOealWsaZBetqbfBjUC4pIKEHyNO81DytGTVtmFKHliQ3cYd4OnMxz3MEKQN0Ro+p1rP68/qXfHzWPkMMQQTylrx79tmA5ioga8tbUIJGsJpqCrqqIV6PtQvzZClZ+u777EvBqr7MzljbdDtVzl4xjqO8jeruSgKluquJh/p2wtOQEUlEUeO31xm+JwzMgUO7ih5KUi79tnsWokpsollpIt5aXAt/QpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBpV/Fv/1gM9o4Pwrk3wTlBWRxfo7KASfeFCh98XZgk=;
 b=FTu/pMWXtTmZqyCR3O20xEKd2BzRXZYA6SY1/n2pyoV/evKXbeR2RCCjIEx51cZUSLqk8ny8IOb5k4w+HKzr/DIIB34okvPyd5C1QG+ycADalGLlI8OxMlP2dW5E2SD5gB9rjHiaNGtu2c1MwgJwqDteALlDtzEBz9T1PIsS2IY=
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 20 Mar
 2025 05:12:02 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::59) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 05:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 05:12:01 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 00:11:56 -0500
Message-ID: <48b257fe-f3e6-4882-a7ee-9a790b1eab3e@amd.com>
Date: Thu, 20 Mar 2025 10:41:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] amd_iommu: Do not assume passthrough translation for
 devices with DTE[TV]=0
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mst@redhat.com>, <mjt@tls.msk.ru>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-7-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>
In-Reply-To: <20250311152446.45086-7-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: b346026e-eccb-4334-95e1-08dd676dbf65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEdjWExINHR6anp2OFRRNitjWlRPSUpkVGNEOEg4UFI3TlBvVWhzZFZaUXNj?=
 =?utf-8?B?eHVUaGNCSy9wenRqY083VTc2WWVYZW8yeldna0hMeVNkQ2F4dERQTEJKWWV0?=
 =?utf-8?B?WlYwUHc1cXY3dC9hWkh0czk2ZUIxM0NwVmc5TDhta3dwWk1CeDZxaDIxcmdJ?=
 =?utf-8?B?TmUwYXlBQ2JTVk9pcTlrYmpPekVwa0N6bUdDSTZrbHhTNlYzeVYwVVJpTjdG?=
 =?utf-8?B?SmhSY21ubkxqNngyZU5yM25zdHRrWEp2WVRSc1B4cndRcWJhbno2U3M4WW5i?=
 =?utf-8?B?VlEzY0wvUFQ2a0VObi9DL0tyeHJXdFhNbkdUeU1vdHpxZmZvYlpranNSQ2RX?=
 =?utf-8?B?N0xSVGViWGR5enVJWHFhcUw1VmdkMmllbEZEK0poWEZQSUZMb2tMNFBLTkdy?=
 =?utf-8?B?NWYyY1ordGJnOUxDaEhsN0ZOdUpsSjYzTnhGdnp2dklyZG9GazhFMW1DM3ZJ?=
 =?utf-8?B?eFdtUVNHVmFpUzR0SG4rczJpK3B5NlVMOWxobm05Ry9RdDVWUktqcFhVSFBz?=
 =?utf-8?B?TlUwL2svZkFIMzFOcG94VGRNZDBrcDl0TUpHbURUdTRmWWt3S1hNdGpxR2ta?=
 =?utf-8?B?ME5EMHV2bGtzcTJtNktkOVlvNDZDTU56bEtEbTVBczR3RXQ5aEVEWnBkbjBE?=
 =?utf-8?B?Y05HY1N6cVROMnJPVG83L1k1Y3JoQWs2MkYzMEJTYjZyVnQvak5MWVNFamhi?=
 =?utf-8?B?T2hoMWZDOVZGNHNxaVc1Z1drQmVRZFA4WE10STkwTFROVlhRZ08wYVBhazJV?=
 =?utf-8?B?ckRMMExLTlg0M0ZyYmtQQitFRmphRllxNkM0d2xsRGZsOUc1d1krTUNPN1Rr?=
 =?utf-8?B?dUNZWm5NT1VCdGw2TDc0bmlOZ01pSkwxL3N5NVJFa2tUSUFOY1AvU1VaU2VH?=
 =?utf-8?B?Q2tmbDMxWmIzdFNrKzhveHc5cUdaaEpwamVqaVVyREZ0cHV4cUpiTDUwejBU?=
 =?utf-8?B?V2djVlhjcW1yc0pJVm1YdkZiM1dnMjZtRllUMlVnMmh6QnRHaTNYMEtSQXpU?=
 =?utf-8?B?TkpWSnVmYk93eEx0WUxOUktnS3ZEblFHSjZFTEh4eGZ4WVppK0FQNlBXME5C?=
 =?utf-8?B?Y3RRTnRxR0RNc09HcjUxVkRQaGZnU1ZWTURBTU1WUDl5UmZxL0hGZDlUTFc2?=
 =?utf-8?B?N2h2TUhzQmFQdW9BRitPbGV1WndZRmJ0Q3pkanN1Y3dDRGo0dWdRMGdrK1hz?=
 =?utf-8?B?ZjFsM2dHTmRYNXVaK3FlSzNmd3NpT2JRNXlXTE45RjN4MEZobHliVnNJNUFk?=
 =?utf-8?B?blVOalJ3eDVDRDc3WmpPc2RVeU56NjVNV3dUUXBVTkZVb21MRzZEM25PcUN3?=
 =?utf-8?B?MDRBWWpJaHhFd3VPQzh5ckRIOVRiN1lROTgweXdmYlp0KzBMeTBxSDJLK3JI?=
 =?utf-8?B?V1R3VmJ2Z1dlVmxQWlZicy80b1hRNTRpUWd2NGxxdFcwbXZvS2RUNWFObWE3?=
 =?utf-8?B?VUpjY3lJbEd5ajhxVm9vZ280NVdFWDZJZmJscGNFNXpaSHNTUHBhb0hNbVk2?=
 =?utf-8?B?UlJGRi9jVEViQThnT3JvSlhWT2gySnR1QUFGQTNDeEtlc2t4Y3krWGtaVndY?=
 =?utf-8?B?bHRSYm1vK21XVkhJN1gyaGtCaDdUK0VsSUFFcHJKbUx3WUYrVHpSbmFpQWNT?=
 =?utf-8?B?NS9EbkZiZHVKdExoZkpCeld4ZlUyZ2RTWWp5cVBCYkZkN25qb2k0d0tjTXhh?=
 =?utf-8?B?Z1pvTnVoMmwzZDZDRnpxMzR1bDhMNGtrQ2tsK2NZMnloaEI1K0kveUg2VkFG?=
 =?utf-8?B?M1RTby9WQWlJaGFDeWJIZk5Nc1JzQUdSOGtHM0tCVi96ZFZLK3lKMFF5M1RK?=
 =?utf-8?B?Tk11WkFEdjUxU0VxUklVaC83czZVczgyMEg1UWtRandVdysza2xTSnNwcHN6?=
 =?utf-8?B?c2p4SnNqcUdHWmxqWnI0WTlCYmxRQVFLb0tHQStldEtnVVJPbXJSRTlISFFs?=
 =?utf-8?B?QVo5ZUFiYU4wcWdDOU5GTzFMeGpKSzRSSkNrYUhkNHVOajA5MDlBOUdHUnF4?=
 =?utf-8?B?dnZZMzVmTzJ3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 05:12:01.5117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b346026e-eccb-4334-95e1-08dd676dbf65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
Received-SPF: permerror client-ip=40.107.237.82;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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



On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> The AMD I/O Virtualization Technology (IOMMU) Specification (see Table 8: V,
> TV, and GV Fields in Device Table Entry), specifies that a DTE with V=0,
> TV=1 does not contain a valid address translation information.  If a request
> requires a table walk, the walk is terminated when this condition is
> encountered.
> 
> Do not assume that addresses for a device with DTE[TV]=0 are passed through
> (i.e. not remapped) and instead terminate the page table walk early.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 88 +++++++++++++++++++++++++--------------------
>   1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index cf00450ebe..31d5522a62 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -932,51 +932,61 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
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
Hi Alejandro,
According to AMD IOMMU specs TABLE 44 (IO_PAGE_FAULT Event Types), IOMMU
reports IO_PAGE_FAULT event when TV bit is not set in the DTE.

Hence you should use amdvi_page_fault to report the IO_PAGE_FAULT
event before returning.

Regards
Sairaj Kodilkar
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
> -        }
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
> -            if (!pte) {
> -                return;
> -            }
> -            oldlevel = level;
> -            level = get_pte_translation_mode(pte);
> -        } while (level > 0 && level < 7);
> -
> -        if (level == 0x7) {
> -            page_mask = pte_override_page_mask(pte);
> -        } else {
> -            page_mask = pte_get_page_mask(oldlevel);
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
> -        /* get access permissions from pte */
> -        ret->iova = addr & page_mask;
> -        ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
> -        ret->addr_mask = ~page_mask;
> -        ret->perm = amdvi_get_perms(pte);
> -        return;
> +    if (level == 0x7) {
> +        page_mask = pte_override_page_mask(pte);
> +    } else {
> +        page_mask = pte_get_page_mask(oldlevel);
>       }
> +
> +    /* get access permissions from pte */
> +    ret->iova = addr & page_mask;
> +    ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
> +    ret->addr_mask = ~page_mask;
> +    ret->perm = amdvi_get_perms(pte);
> +    return;
> +
>   no_remap:
>       ret->iova = addr & AMDVI_PAGE_MASK_4K;
>       ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;


