Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878A2106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 17:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0jRC-0000Tc-MT; Thu, 12 Mar 2026 13:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@demindiro.com>)
 id 1w0jRA-0000TS-Q7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 13:03:04 -0400
Received: from mail.salt-inc.org ([104.244.79.104] helo=vm0.salt-inc.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@demindiro.com>)
 id 1w0jR7-0003KY-2s
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 13:03:04 -0400
Received: from [192.168.2.172] (209.60-130-109.adsl-dyn.isp.belgacom.be
 [109.130.60.209])
 by vm0.salt-inc.org (Postfix) with ESMTPSA id 68FE4FF074;
 Thu, 12 Mar 2026 18:01:55 +0100 (CET)
Message-ID: <5c6c85df-c3ec-4bea-bc7b-f1b768766a12@demindiro.com>
Date: Thu, 12 Mar 2026 18:01:54 +0100
MIME-Version: 1.0
User-Agent: Icedove Daily
Subject: Re: [PATCH 1/2] amd_iommu: Follow root pointer before page walk and
 use 1-based levels
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, mst@redhat.com,
 clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, boris.ostrovsky@oracle.com
References: <20260311203943.2309841-1-alejandro.j.jimenez@oracle.com>
 <20260311203943.2309841-2-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: David Hoppenbrouwers <qemu@demindiro.com>
In-Reply-To: <20260311203943.2309841-2-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=104.244.79.104; envelope-from=qemu@demindiro.com;
 helo=vm0.salt-inc.org
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/11/26 9:39 PM, Alejandro Jimenez wrote:
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
Reviewed-By: David Hoppenbrouwers <qemu@demindiro.com>

