Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A5AC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPGpr-0003xl-7b; Wed, 11 Jun 2025 04:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uPGpn-0003xU-MF
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:29:23 -0400
Received: from mail-dm6nam12on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2417::617]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uPGpj-00030W-Ue
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYJerxHqH7sH50NHy/9WklixyIt7DaVChSY9nzmNSaykQwix00Mp/PUjaGJF/0EXSnhuoQUC8K/bb48H4il4tLg++XtPjHJ4Hl5VsS9U5tfaoKhp0BOT3bIKlVP8dtSPDKlrfp3U+aZ1843nXfdjsbY/8o8Y0y3ngtgrfHf2dI/FKmLgmEUws2hV9Du8lIMcQf5JSab3uACipOkP0RiIpMrpG1NE9vLFXZLxjCh3RByXMaScgusHdtChzQWRu8EZax2W3YcuY0rXedfiV7++xtLRUU3koWxUqAs3Gvba5WHaQ39/hm+axFqTQF8dLVkGkPvQ4cr9dE0ytcysMQQUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F79oZFKfNha0sVEIPl0hD1GodE+l3qj45l+T/A8JuTk=;
 b=XxcuvTcPzPpEvLdzUHZoRete0T5VdoN7pkBnZhKdxd7i7aXT1EWqNtcxjjDosrSvBYRepNs01zXcCiRG7k/gw1pLKLyfisn185QIW3CINuanttR3Qi/mqWT6H6vqec07SKwRvxdaK/ji+Z89/KdS9kdm635KKKwPZnJDJT8NMQxkucCDuO1FwtziVyYQFu1vwwM041ulgQt7+rs/ZupsR9yhilHI00Et8hRNTkiJpjYyKQW4t6umduLEJ7DiXZD+/SblIKgc6t0p6p6SadDlZYgJsz6m/HszBJcdFGcEXftqFuYE63yKtDBTwzn2iiTC8A/OONkp4vgjDr/uomY9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F79oZFKfNha0sVEIPl0hD1GodE+l3qj45l+T/A8JuTk=;
 b=kNyak2/vk1T+t8YlrF+sUgdRPgrU+Y7axORJGCA85ElsgxdO+C9GfYS/LXU4gZESNdVFZPayCoLBykHVgInx0/grga2CNN+4mDhh3+P1lpadcTq/JjYx0ZCVuSPnVTJgB/ZC9a2hFTjPh3XbDrpCOMrfKk5EzVn8ogXDhtlfpDU=
Received: from MW4PR04CA0134.namprd04.prod.outlook.com (2603:10b6:303:84::19)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 11 Jun
 2025 08:29:11 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:303:84:cafe::b3) by MW4PR04CA0134.outlook.office365.com
 (2603:10b6:303:84::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 08:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 08:29:10 +0000
Received: from [10.85.38.70] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 03:29:05 -0500
Message-ID: <ed8ac2ac-02eb-4f91-9a78-59401e64fdb8@amd.com>
Date: Wed, 11 Jun 2025 13:59:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] amd_iommu: Use iova_tree records to determine
 large page size on UNMAP
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <clement.mathieu--drif@eviden.com>,
 <ethan.milon@eviden.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-12-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250502021605.1795985-12-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: c3eecf9b-59fa-4ce4-843c-08dda8c20a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nmsvd0NRamFSZkpFZTRNMXQzUzEwQXpQeTBuRU0yUldZWTZab0ticTVMVXps?=
 =?utf-8?B?TUduZzFPSXZiZnhGWFlJOXBGNUF0SU11YzJhUXY3U3BYRVh0TEFjU1d6T1Z5?=
 =?utf-8?B?aFVWNmxmTlZwME9pRFJxbk5lYUVjTTZkbnA5VzR4dnpySjNhTkdaWjlRQ0pa?=
 =?utf-8?B?RndrNzNJa1o0S3IybHhyWG5UUXMrNUl0OWl2dElORmdFZXQyL1dEMXFvOGRD?=
 =?utf-8?B?UWV0V1h2a0VVM3M4c2JKY0l5YzF0WFBkVU41ZUQ0OExBcFF4QWZVTjlGeUFr?=
 =?utf-8?B?dXM2UXJCM2lRRVdNNjVIRTFONlhvUkp2bFNsSmgrK29KeE1GaDUzSFgzU0M4?=
 =?utf-8?B?U0JVbUpuYWxiRTFNMDFyZ1ZlSis1ZEhrYTE1dlQzbmVpTmhUT0gxTVRSU2hE?=
 =?utf-8?B?U3Z0YVk3YnpBNlNUQUZJVURQbFRvTTExZEdCZE9VUXE1VlVjMDFQWllHUTJ4?=
 =?utf-8?B?WEd3UXZtYnFGN0hVSGplMzR0Ykc4eUZqWk9nSVMyeWh0eXY4aTlYWWpTSVZK?=
 =?utf-8?B?ZDF6SExId3pqRnlYTVRrWURBLzU5VFZOK0VPSEx3RS9HNWJDc1dNaHQ3QkRv?=
 =?utf-8?B?UmkrMkFpUjR1MWZmbjhLdWZ5MmdNZVMxNjRLMzVXcFR5c1pvTnU0Y3lKTWp2?=
 =?utf-8?B?UUdBUDRXTmdwT3Q5WlJEWWx2MWlzM24rTWZQVWQ4Vm1MSHN1VDdGZW9qQ0xk?=
 =?utf-8?B?VnRseUdZRjBGMng3eUs5aHJqWUszcFJsYmFWeWdOZGdzV0xtU3BkVlUySk9H?=
 =?utf-8?B?d3BYQnBBQTdUK3YxbmI3L3VGc0VLL0orbWdaV1VVYklHbnBTZGJadTZra2cx?=
 =?utf-8?B?ZFRzQkJHMTFHMXVxQk1USWNZcFA2Nmx5UDc1SFh2K2JEQ1F5T3A1YmVTT1ZT?=
 =?utf-8?B?dk8yRmN4S2lYTnUxVU1uOGtmMUxxOUhCQnowSjkwTklwZjNJMnY2Mno4YlRE?=
 =?utf-8?B?Wi90cUpqbFV0UFJoOXI4K1duZ0xkSG9TWndSbklkMmpOZVdiVHprak9wU1oy?=
 =?utf-8?B?NFowSEhYN0VEbnBlMTNIekJtRkttSTJ2Mm9oMHdueFdoUkpSUjVoK240cUMy?=
 =?utf-8?B?dzd6eCt3LzBMclVhZ2JwNDkzK2hBTFF0RU9xOEtjZU9sSGF1bkU3OGJBM09K?=
 =?utf-8?B?Y0FUWnNqWS9ObDBQdDVLMnNPYkoxM1Q0RTZ3elQ2NWd2N1ozVlVMcTV2Z2Ni?=
 =?utf-8?B?MXhqRWVjdWpnUkxZTWV3TlIvMjN4UnljMTYvVEhNc3ZveHVrZzB6TGdvUmYy?=
 =?utf-8?B?UzVnejN5OTNPRDE0emlGT21PdTNRYUVOamkrdFEzYTFleHRPZVpIZE1CMnd0?=
 =?utf-8?B?dmpoQTFudSsxTTlzM0ZzVkJLNk9vampkVEE5aEFnaUp5N05nU2kxSVlqQk9H?=
 =?utf-8?B?NDNIZWVwaEdtbU0vM29VSHNrRy9UeFlJaEtnU3NRckx1NURYNm90N2Iyb2J2?=
 =?utf-8?B?eHUwRUw2UytpV3dlK3VuWHlTNStOVzk4Q1F4OUJOY2pxamFleGpoSTUvUW5u?=
 =?utf-8?B?MHIvalgydjA5VnkwVVhzT2h4S1lSb3FvaGR1eHpvcHNDbWJ3d0c4M3R3SU9U?=
 =?utf-8?B?eFFyWjhWK1JXaWNYeTJRV1VENXZpWkdkMCt2aUtOeHMvNlF0ZE4wVTlUMWNS?=
 =?utf-8?B?SGdvUWprVlhnNFNPMi9DNk9sKzlXby9hVHRZc0xhdTU5WUFqN0JwNjE0U2RK?=
 =?utf-8?B?YUZ6eHcxUVNLM2ptS1VmVlEzVDU4bHZUN1BJUFBZWFIrMmxzSC9CZW14ZU50?=
 =?utf-8?B?TnBadUtGOVhhUjZXaE1qZG1nRExPc1FpamNvMUZPUWJKemhMdzJuOTBPcXZw?=
 =?utf-8?B?S1JBWW0xeUxWNjJaQTI3OStXbTM4Z1AweW9vN3FxZm9IVHRvTW5vSjcrQWgx?=
 =?utf-8?B?aEpuUjRMR0gyOUhZUmxuWndPQTd4NVFhMHRVWWprQ1Z3RXlUQk9TZ0praDdw?=
 =?utf-8?B?WXgwdkk5TTZQNWh3MlVOa2lPcDRFbFR6RjNNU20vS2RnMTJXZEY1YXZYc1Rr?=
 =?utf-8?B?cE16ZUdWM1NCclJQbGROTXloM2pnVm1kb3crajAySVJXNTNDZnR3eWFqQndU?=
 =?utf-8?Q?HWLThn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 08:29:10.9130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eecf9b-59fa-4ce4-843c-08dda8c20a89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
Received-SPF: permerror client-ip=2a01:111:f403:2417::617;
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



On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:
> Keep a record of mapped IOVA ranges per address space, using the iova_tree
> implementation. Besides enabling optimizations like avoiding unnecessary
> notifications, a record of existing <IOVA, size> mappings makes it possible
> to determine if a specific IOVA is mapped by the guest using a large page,
> and adjust the size when notifying UNMAP events.
> 
> When unmapping a large page, the information in the guest PTE encoding the
> page size is lost, since the guest clears the PTE before issuing the
> invalidation command to the IOMMU. In such case, the size of the original
> mapping can be retrieved from the iova_tree and used to issue the UNMAP
> notification. Using the correct size is essential since the VFIO IOMMU
> Type1v2 driver in the host kernel will reject unmap requests that do not
> fully cover previous mappings.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 91 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 86 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index bddfe2f93136..4f44ef159ff9 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -33,6 +33,7 @@
>   #include "hw/i386/apic-msidef.h"
>   #include "hw/qdev-properties.h"
>   #include "kvm/kvm_i386.h"
> +#include "qemu/iova-tree.h"
>   
>   /* used AMD-Vi MMIO registers */
>   const char *amdvi_mmio_low[] = {
> @@ -71,6 +72,8 @@ struct AMDVIAddressSpace {
>       IOMMUNotifierFlag notifier_flags;
>       /* entry in list of Address spaces with registered notifiers */
>       QLIST_ENTRY(AMDVIAddressSpace) next;
> +    /* Record DMA translation ranges */
> +    IOVATree *iova_tree;
>   };
>   
>   /* AMDVI cache entry */
> @@ -653,6 +656,75 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>       return 0;
>   }
>   
> +/*
> + * Invoke notifiers registered for the address space. Update record of mapped
> + * ranges in IOVA Tree.
> + */
> +static void amdvi_notify_iommu(AMDVIAddressSpace *as, IOMMUTLBEvent *event)
> +{
> +    IOMMUTLBEntry *entry = &event->entry;
> +
> +    DMAMap target = {
> +        .iova = entry->iova,
> +        .size = entry->addr_mask,
> +        .translated_addr = entry->translated_addr,
> +        .perm = entry->perm,
> +    };
> +
> +    /*
> +     * Search the IOVA Tree for an existing translation for the target, and skip
> +     * the notification if the mapping is already recorded.
> +     * When the guest uses large pages, comparing against the record makes it
> +     * possible to determine the size of the original MAP and adjust the UNMAP
> +     * request to match it. This avoids failed checks against the mappings kept
> +     * by the VFIO kernel driver.
> +     */
> +    const DMAMap *mapped = iova_tree_find(as->iova_tree, &target);
> +
> +    if (event->type == IOMMU_NOTIFIER_UNMAP) {
> +        if (!mapped) {
> +            /* No record exists of this mapping, nothing to do */
> +            return;
> +        }
> +        /*
> +         * Adjust the size based on the original record. This is essential to
> +         * determine when large/contiguous pages are used, since the guest has
> +         * already cleared the PTE (erasing the pagesize encoded on it) before
> +         * issuing the invalidation command.
> +         */
> +        if (mapped->size != target.size) {
> +            assert(mapped->size > target.size);
> +            target.size = mapped->size;
> +            /* Adjust event to invoke notifier with correct range */
> +            entry->addr_mask = mapped->size;
> +        }
> +        iova_tree_remove(as->iova_tree, target);
> +    } else { /* IOMMU_NOTIFIER_MAP */
> +        if (mapped) {
> +            /*
> +             * If a mapping is present and matches the request, skip the
> +             * notification.
> +             */
> +            if (!memcmp(mapped, &target, sizeof(DMAMap))) {
> +                return;
> +            } else {
> +                /*
> +                 * This should never happen unless a buggy guest OS omits or
> +                 * sends incorrect invalidation(s). Report an error in the event
> +                 * it does happen.
> +                 */
> +                error_report("Found conflicting translation. This could be due "
> +                             "to an incorrect or missing invalidation command");
> +            }
> +        }
> +        /* Record the new mapping */
> +        iova_tree_insert(as->iova_tree, &target);
> +    }
> +
> +    /* Invoke the notifiers registered for this address space */
> +    memory_region_notify_iommu(&as->iommu, 0, *event);
> +}
> +
>   /*
>    * Walk the guest page table for an IOVA and range and signal the registered
>    * notifiers to sync the shadow page tables in the host.
> @@ -664,7 +736,7 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
>   {
>       IOMMUTLBEvent event;
>   
> -    hwaddr iova_next, page_mask, pagesize;
> +    hwaddr page_mask, pagesize;
>       hwaddr iova = addr;
>       hwaddr end = iova + size - 1;
>   
> @@ -687,7 +759,6 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
>           /* PTE has been validated for major errors and pagesize is set */
>           assert(pagesize);
>           page_mask = ~(pagesize - 1);
> -        iova_next = (iova & page_mask) + pagesize;
>   
>           if (ret == -AMDVI_FR_PT_ENTRY_INV) {
>               /*
> @@ -720,11 +791,20 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
>               event.type = IOMMU_NOTIFIER_MAP;
>           }
>   
> -        /* Invoke the notifiers registered for this address space */
> -        memory_region_notify_iommu(&as->iommu, 0, event);
> +        /*
> +         * The following call might need to adjust event.entry.size in cases
> +         * where the guest unmapped a series of large pages.
> +         */
> +        amdvi_notify_iommu(as, &event);
> +        /*
> +         * In the special scenario where the guest is unmapping a large page,
> +         * addr_mask has been adjusted before sending the notification. Update
> +         * pagesize accordingly in order to correctly compute the next IOVA.
> +         */
> +        pagesize = event.entry.addr_mask + 1;
>   
>   next:
> -        iova = iova_next;
> +        iova = (iova & ~(pagesize - 1)) + pagesize;

Hi Alejandro,
While experimenting with iommu.forcedac=1, I found that above line 
causes unsigned integer overflow for 64 bit IOVAs. This results in an 
infinite loop.

Please add a overflow check here.

Thanks
Sairaj Kodilkar


