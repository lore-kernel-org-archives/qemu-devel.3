Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD850EC01CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dGb-0005hq-F2; Mon, 23 Mar 2026 07:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w4dGV-0005fs-Dt
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:16:14 -0400
Received: from mail-eastus2azon11010032.outbound.protection.outlook.com
 ([52.101.56.32] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1w4dGR-0004fp-VB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:16:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFP7fuBxhE3nr0QBFzYCQ1wj3FVFubzbOL7eESJQyBqGuaWlg8dUWykwi5dl0DTCSSf0LqcAJtLjPN1dnA3v/VZmFN3baS2V8xKduvCQrYcG9WggLj4vBBuM2L26WsGRq2dTYZMMolb4qRgyruxSX8wMkv/REFAOCiwiACmHobFDSmQFLH6+0r493jTX0CZun35NMCHEupB2N+q11Gj3cq9xzGTU/1c1fR/J2pnhgijTloA+ox5KXRro2cN/OKLWHtJ7GYdK8aWTJkALxV8k1HEB9GUU6zxw+oi8wqi0Q1L1Qa4i52VTz8UcplGzCrqqv4r7H1fWSp4VKd4egxM5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPB64TcFLq6QEXP893JtOruvNIem3U8VdLC4hKsRQPY=;
 b=sWhZmdIerLdXcY5bndndBCLjUEpPXPsm7mri8NAp3Cxi6ODyA6iktRGnHwJla16j4RpPeGV2d74R1DT/VBEL45lo6M+BEEbJHAPlohwF0v8LstRZ3J9aE/a3k/rjP7yJUK3XcNILUOLL09K6jqNkwdrPmr7HLjEaa3vOmZgFmb0fdLsg1o4fJWh/Obiss4G6NpKNc9MNJ1NnrJwq7SKT0M6ukTiccfAzrtWLM1sh0r9/5zDRY4aZ2MXvtaee9aauclslqXLQiMttZ4n9sffkCIp+1sMsygloqeFRGH7DsS9Eoeh/0ZdrqdlfcwA+8xC9rBTKFDhO+hg1tbZOsDEJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPB64TcFLq6QEXP893JtOruvNIem3U8VdLC4hKsRQPY=;
 b=JTW4woE7U4X3xCKtTpOvYhun25PYKF9asoQrxDInHv3EaWrQmGnE9R157ZccQ9e7S2y35uAIFbbl4oY4qphGoMw/lOlGq3XCmO854eDQfUyrIc9a/5PI+vzxePdzN3UJtdSCLRvnpSzKohGafMaYGyC1JOo8iXppxoPjJ5m9X20=
Received: from CH0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:610:b3::13)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Mon, 23 Mar
 2026 11:10:54 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::71) by CH0PR03CA0038.outlook.office365.com
 (2603:10b6:610:b3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:10:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:10:50 -0500
Received: from [10.143.201.178] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:02:01 -0700
Message-ID: <2756c509-4286-444a-815c-d6266c3e3a91@amd.com>
Date: Mon, 23 Mar 2026 16:31:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <qemu@demindiro.com>, <mst@redhat.com>,
 <clement.mathieu--drif@eviden.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 1/2] amd_iommu: Follow root pointer before page walk and
 use 1-based levels
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
References: <20260311203943.2309841-1-alejandro.j.jimenez@oracle.com>
 <20260311203943.2309841-2-alejandro.j.jimenez@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260311203943.2309841-2-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: c205fef7-f44a-479a-9573-08de88ccda27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: cuEPHzcENNn6G9EDgxLqPTxFTApY8vF528/nHcs5HYRQm3ToBCR7XXXU7+rMUsk43DNrAMey33iMqLF7xi3SC89P94d1ogYczP/VuUZ5PIqmgEZmAEpITOp86Y5KGGcAhztNcw8N5y15x293Mlnk9xCBoc5XtvYl0wuBpMgJ0VvwiMhkSFJcPx+PAP0LeUhqB9bQItcEI4TUvjBSNWdDp/S/H2nS8pRp/725xA/6LKlJlScMvg6jvm5WR8+NPD5I4ciTscxw464SoLdETVDNq3HUEumGFDyTf2c8sNCVtIaeT7DQMcQLqosHoWuUpdjOeRnmIyNDfq+D2Lc0rbAIqGaoFcBtp2uybUsi7YTMIb2/tScgFylps7wzYs41OhnSP7e+AZhpKdqdF+Q0DsQ2vKOPcVUa2PEF5n72K1Pzt347dDKgVRT80qDrqCILU04jzIYv3ef3HmPFe2g7aoKnDzEFDAVKjFago9blyaoxiUFwgK/2nz4I6C8K4FlioaUkuRsW84AuBYJ0V1E1MDdYAPXNbS9EeaExeFJG5iwGxJoBAUov10wBT7tXl7R42BEe4kXNDrHR9gKAZVSqfi4Fkr4FypI3RylnZ9yuUtHC+KgMqoObhvlCw7trGfDdHij8quK0UbcozVZEt9DRumCF9UE50nknS+ZxA22tXOjzi4I2ZACgtNbFVsVvJgT1QwboRd2cB7B+YhI+vEAfoadH+/pLZlMgTPG1fL0+eMnBape5qM+ci/XUZvbkxoE/T9Mz28iMUgl3UkQLgOJ8TfzEwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vBQhzHTPwIA0gGw9oMcdsPyA2aN7UuWjLrMZ8wbVquUzyB9GNRagxSdm/ujwi0/dJ34vmk5gLxHoer7dMX+uom1nNO4T7xynApBvLCFefVwPR6JDOZioH5mSwYlV9xbYvtqb/kdrs1Nn+FdN9eRack1vToEpe1WrYgnfilPXbQY0Yz9TF3H/SGYRwtPZIheZQ6CBvRv+uGh+HcLGtdUm6eMYScHWino5WK/Ex4sUqhc2KPKLSonurCuu8x+nHUWRreZP5jO+LCLdAaXIwf0HMarXVX9rtG8saVS1/TyF7kis0h3MYS2qRHfEK6uuB6jnRzG+VczEcYIPKpjMpFW6MFPrvH14ccnkmUbgbZIE5wAyYc8BZTLyv+k73VYX3/PJ3Es062UYpoaSCsvCKwlWUSQFoc29fL1Pt1ZQ73u877sdJDM592YbneXbRTXQUrzj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:10:54.7385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c205fef7-f44a-479a-9573-08de88ccda27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
Received-SPF: permerror client-ip=52.101.56.32;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/12/2026 2:09 AM, Alejandro Jimenez wrote:
> DTE[Mode] and PTE NextLevel encode page table levels as 1-based values, but
> fetch_pte() currently uses a 0-based level counter, making the logic
> harder to follow and requiring conversions between DTE mode and level.
>
> Switch the page table walk logic to use 1-based level accounting in
> fetch_pte() and the relevant macro helpers. To further simplify the page
> walking loop, split the root page table access from the walk i.e. rework
> fetch_pte() to follow the DTE Page Table Root Pointer and retrieve the top
> level pagetable entry before entering the loop, then iterate only over the
> PDE/PTE entries.
>
> The reworked algorithm fixes a page walk bug where the page size was
> calculated for the next level before checking if the current PTE was already
> a leaf/hugepage. That caused hugepage mappings to be reported as 4K pages,
> leading to performance degradation and failures in some setups.
>
> Fixes: a74bb3110a5b ("amd_iommu: Add helpers to walk AMD v1 Page Table format")
> Cc: qemu-stable@nongnu.org
> Reported-by: David Hoppenbrouwers <qemu@demindiro.com>
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 132 ++++++++++++++++++++++++++++++--------------
>   hw/i386/amd_iommu.h |  11 ++--
>   2 files changed, 97 insertions(+), 46 deletions(-)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2..991c6c379a 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -648,6 +648,52 @@ static uint64_t large_pte_page_size(uint64_t pte)
>       return PTE_LARGE_PAGE_SIZE(pte);
>   }
>   
> +/*
> + * Validate DTE fields and extract permissions and top level data required to
> + * initiate the page table walk.
> + *
> + * On success, returns 0 and stores:
> + *   - top_level: highest page-table level encoded in DTE[Mode]
> + *   - dte_perms: effective permissions from the DTE
> + *
> + * On failure, returns -AMDVI_FR_PT_ROOT_INV. This includes cases where:
> + *   - DTE permissions disallow read AND write
> + *   - DTE[Mode] is invalid for translation
> + *   - IOVA exceeds the address width supported by DTE[Mode]
> + * In all such cases a page walk must be aborted.
> + */
> +static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
> +                                       uint8_t *top_level,
> +                                       IOMMUAccessFlags *dte_perms)
> +{
> +    *dte_perms = amdvi_get_perms(dte);
> +    if (*dte_perms == IOMMU_NONE) {
> +        return -AMDVI_FR_PT_ROOT_INV;
> +    }
> +
> +    /* Verifying a valid mode is encoded in DTE */
> +    *top_level = get_pte_translation_mode(dte);
> +
> +    /*
> +     * Page Table Root pointer is only valid for GPA->SPA translation on
> +     * supported modes.
> +     */
> +    if (*top_level == 0 || *top_level > 6) {
> +        return -AMDVI_FR_PT_ROOT_INV;
> +    }
> +
> +    /*
> +     * If IOVA is larger than the max supported by the highest pgtable level,
> +     * there is nothing to do.
> +     */
> +    if (address > PT_LEVEL_MAX_ADDR(*top_level)) {
> +        /* IOVA too large for the current DTE */
> +        return -AMDVI_FR_PT_ROOT_INV;
> +    }
> +
> +    return 0;
> +}
> +
>   /*
>    * Helper function to fetch a PTE using AMD v1 pgtable format.
>    * On successful page walk, returns 0 and pte parameter points to a valid PTE.
> @@ -662,40 +708,49 @@ static uint64_t large_pte_page_size(uint64_t pte)
>   static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>                             uint64_t *pte, hwaddr *page_size)
>   {
> -    IOMMUAccessFlags perms = amdvi_get_perms(dte);
> -
> -    uint8_t level, mode;
>       uint64_t pte_addr;
> +    uint8_t pt_level, next_pt_level;
> +    IOMMUAccessFlags perms;
> +    int ret;
>   
> -    *pte = dte;
>       *page_size = 0;
>   
> -    if (perms == IOMMU_NONE) {
> -        return -AMDVI_FR_PT_ROOT_INV;
> -    }
> -
>       /*
> -     * The Linux kernel driver initializes the default mode to 3, corresponding
> -     * to a 39-bit GPA space, where each entry in the pagetable translates to a
> -     * 1GB (2^30) page size.
> +     * Verify the DTE is properly configured before page walk, and extract
> +     * top pagetable level and permissions.
>        */
> -    level = mode = get_pte_translation_mode(dte);
> -    assert(mode > 0 && mode < 7);
> +    ret = amdvi_get_top_pt_level_and_perms(address, dte, &pt_level, &perms);
> +    if (ret < 0) {
> +        return ret;
> +    }
>   
>       /*
> -     * If IOVA is larger than the max supported by the current pgtable level,
> -     * there is nothing to do.
> +     * Retrieve the top pagetable entry by following the DTE Page Table Root
> +     * Pointer and indexing the top level table using the IOVA from the request.
>        */
> -    if (address > PT_LEVEL_MAX_ADDR(mode - 1)) {
> -        /* IOVA too large for the current DTE */
> +    pte_addr = NEXT_PTE_ADDR(dte, pt_level, address);
> +    *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> +
> +    if (*pte == (uint64_t)-1) {
> +        /*
> +         * A returned PTE of -1 here indicates a failure to read the top level
> +         * page table from guest memory. A page walk is not possible and page
> +         * size must be returned as 0.
> +         */
>           return -AMDVI_FR_PT_ROOT_INV;
>       }
>   
> -    do {
> -        level -= 1;
> +    /*
> +     * Calculate page size for the top level page table entry.
> +     * This ensures correct results for a single level Page Table setup.
> +     */
> +    *page_size = PTE_LEVEL_PAGE_SIZE(pt_level);
>   
> -        /* Update the page_size */
> -        *page_size = PTE_LEVEL_PAGE_SIZE(level);
> +    /*
> +     * The root page table entry and its level have been determined. Begin the
> +     * page walk.
> +     */
> +    while (pt_level > 0) {
>   
>           /* Permission bits are ANDed at every level, including the DTE */
>           perms &= amdvi_get_perms(*pte);
> @@ -708,37 +763,34 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>               return 0;
>           }
>   
> +        next_pt_level = PTE_NEXT_LEVEL(*pte);
> +
>           /* Large or Leaf PTE found */
> -        if (PTE_NEXT_LEVEL(*pte) == 7 || PTE_NEXT_LEVEL(*pte) == 0) {
> +        if (next_pt_level == 0 || next_pt_level == 7) {
>               /* Leaf PTE found */
>               break;
>           }
>   
> +        pt_level = next_pt_level;
> +
>           /*
> -         * Index the pgtable using the IOVA bits corresponding to current level
> -         * and walk down to the lower level.
> +         * The current entry is a Page Directory Entry. Descend to the lower
> +         * page table level encoded in current pte, and index the new table
> +         * using the appropriate IOVA bits to retrieve the new entry.
>            */
> -        pte_addr = NEXT_PTE_ADDR(*pte, level, address);
> +        *page_size = PTE_LEVEL_PAGE_SIZE(pt_level);
> +
> +        pte_addr = NEXT_PTE_ADDR(*pte, pt_level, address);
>           *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
>   
>           if (*pte == (uint64_t)-1) {
> -            /*
> -             * A returned PTE of -1 indicates a failure to read the page table
> -             * entry from guest memory.
> -             */
> -            if (level == mode - 1) {
> -                /* Failure to retrieve the Page Table from Root Pointer */
> -                *page_size = 0;
> -                return -AMDVI_FR_PT_ROOT_INV;
> -            } else {
> -                /* Failure to read PTE. Page walk skips a page_size chunk */
> -                return -AMDVI_FR_PT_ENTRY_INV;
> -            }
> +            /* Failure to read PTE. Page walk skips a page_size chunk */
> +            return -AMDVI_FR_PT_ENTRY_INV;
>           }
> -    } while (level > 0);
> +    }
> +
> +    assert(PTE_NEXT_LEVEL(*pte) == 0 || PTE_NEXT_LEVEL(*pte) == 7);
>   
> -    assert(PTE_NEXT_LEVEL(*pte) == 0 || PTE_NEXT_LEVEL(*pte) == 7 ||
> -           level == 0);
>       /*
>        * Page walk ends when Next Level field on PTE shows that either a leaf PTE
>        * or a series of large PTEs have been reached. In the latter case, even if
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 302ccca512..7af3c742b7 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -186,17 +186,16 @@
>   
>   #define IOMMU_PTE_PRESENT(pte)          ((pte) & AMDVI_PTE_PR)
>   
> -/* Using level=0 for leaf PTE at 4K page size */
> -#define PT_LEVEL_SHIFT(level)           (12 + ((level) * 9))
> +/* Using level=1 for leaf PTE at 4K page size */
> +#define PT_LEVEL_SHIFT(level)           (12 + (((level) - 1) * 9))
>   
>   /* Return IOVA bit group used to index the Page Table at specific level */
>   #define PT_LEVEL_INDEX(level, iova)     (((iova) >> PT_LEVEL_SHIFT(level)) & \
>                                           GENMASK64(8, 0))
>   
> -/* Return the max address for a specified level i.e. max_oaddr */
> -#define PT_LEVEL_MAX_ADDR(x)    (((x) < 5) ? \
> -                                ((1ULL << PT_LEVEL_SHIFT((x + 1))) - 1) : \
> -                                (~(0ULL)))
> +/* Return the maximum output address for a specified page table level */
> +#define PT_LEVEL_MAX_ADDR(level)    (((level) > 5) ? (~(0ULL)) : \
> +                                    ((1ULL << PT_LEVEL_SHIFT((level) + 1)) - 1))
>   
>   /* Extract the NextLevel field from PTE/PDE */
>   #define PTE_NEXT_LEVEL(pte)     (((pte) & AMDVI_PTE_NEXT_LEVEL_MASK) >> 9)

Hi Alejandro,

amdvi_sync_shadow_page_table_range() does not check if DTE
**valid and translation valid** bit are set. I added this check in
my reply to david's patch. Do you think we should include that
check as well to ensure that only DTEs with **valid and translation valid**
bit are passed to the fetch_pte ?

Thanks
Sairaj Kodilkar


