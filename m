Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828CEC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD2yk-0001XD-7i; Fri, 31 May 2024 10:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sD2yi-0001X0-Df
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:11:32 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sD2ye-0003FM-96
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=FlpkCbhqMxN0VfgCSedVti0RJhEy7/An8zpvLINepvc=; b=E07qHyBQ2tVytoxH
 WBOXF9GWNe0rLlounslELyaW+Qi54OI23iEBozgR31osOzMz07cjw14QxTziWKT71zpF1UzGe9m2F
 UkivSuny0IxWg4kniDiMkYlo0CjM8OXIAjw+0hJjfQL2HcqmY3KtjXrTwCmuVxBVrYlhODuugvpiE
 KtzQQH7AtPeCA1SBwbPqcaJ5SRY5koAmbmPaEfBXcmC8VhtmmVO6yzYW5gAF7Zz4rogCFfOGfBm3T
 9bBF0JGCuixNpmtNkNmYiSrlyNZc7Em9rzYMJzoZ3PQBd9z9R18Hcew8tbOVvKoyze0TqD6xjvp7W
 sdr4qeI/gjBdTXyk1w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sD2yb-003acC-1w;
 Fri, 31 May 2024 14:11:25 +0000
Date: Fri, 31 May 2024 14:11:25 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 1/6] Add an "info pg" command that prints the current
 page tables
Message-ID: <ZlnajZpUHyGDTgNx@gallifrey>
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
 <20240524170748.1842030-2-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240524170748.1842030-2-porter@cs.unc.edu>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:10:43 up 23 days, 1:24, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Don Porter (porter@cs.unc.edu) wrote:
> The new "info pg" monitor command prints the current page table,
> including virtual address ranges, flag bits, and snippets of physical
> page numbers.  Completely filled regions of the page table with
> compatible flags are "folded", with the result that the complete
> output for a freshly booted x86-64 Linux VM can fit in a single
> terminal window.  The output looks like this:
> 
> VPN range             Entry         Flags            Physical page
> [7f0000000-7f0000000] PML4[0fe]     ---DA--UWP
>   [7f28c0000-7f28fffff]  PDP[0a3]     ---DA--UWP
>     [7f28c4600-7f28c47ff]  PDE[023]     ---DA--UWP
>       [7f28c4655-7f28c4656]  PTE[055-056] X--D---U-P 0000007f14-0000007f15
>       [7f28c465b-7f28c465b]  PTE[05b]     ----A--U-P 0000001cfc
> ...
> [ff8000000-ff8000000] PML4[1ff]     ---DA--UWP
>   [ffff80000-ffffbffff]  PDP[1fe]     ---DA---WP
>     [ffff81000-ffff81dff]  PDE[008-00e] -GSDA---WP 0000001000-0000001dff
>   [ffffc0000-fffffffff]  PDP[1ff]     ---DA--UWP
>     [ffffff400-ffffff5ff]  PDE[1fa]     ---DA--UWP
>       [ffffff5fb-ffffff5fc]  PTE[1fb-1fc] XG-DACT-WP 00000fec00 00000fee00
>     [ffffff600-ffffff7ff]  PDE[1fb]     ---DA--UWP
>       [ffffff600-ffffff600]  PTE[000]     -G-DA--U-P 0000001467
> 
> This draws heavy inspiration from Austin Clements' original patch.
> 
> This also adds a generic page table walker, which other monitor
> and execution commands will be migrated to in subsequent patches.
> 
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>  hmp-commands-info.hx              |  26 ++
>  include/monitor/hmp-target.h      |   1 +
>  target/i386/arch_memory_mapping.c | 486 +++++++++++++++++++++++++++++-
>  target/i386/cpu.h                 |  16 +
>  target/i386/monitor.c             | 380 +++++++++++++++++++++++
>  5 files changed, 908 insertions(+), 1 deletion(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 20a9835ea8..918b82015c 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -237,6 +237,32 @@ ERST
>          .cmd        = hmp_info_mtree,
>      },
>  
> +#if defined(TARGET_I386)
> +    {
> +        .name       = "pg",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show the page table",
> +        .cmd        = hmp_info_pg,
> +    },
> +#endif

So that looks OK

> +
> +SRST                                                                               |
> +  ``info pg``                                                                      |
> +    Show the active page table.                                                    |
> +ERST

Are those |'s over ----->    in the actual patch?

> +    {
> +        .name       = "mtree",
> +        .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o,disabled:-D",
> +        .params     = "[-f][-d][-o][-D]",
> +        .help       = "show memory tree (-f: dump flat view for address spaces;"
> +                      "-d: dump dispatch tree, valid with -f only);"
> +                      "-o: dump region owners/parents;"
> +                      "-D: dump disabled regions",
> +        .cmd        = hmp_info_mtree,
> +    },

Hmm this looks like a copy-pasteism ?

Dave

>  SRST
>    ``info mtree``
>      Show memory tree.
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index b679aaebbf..9af72ea58d 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -50,6 +50,7 @@ CPUState *mon_get_cpu(Monitor *mon);
>  void hmp_info_mem(Monitor *mon, const QDict *qdict);
>  void hmp_info_tlb(Monitor *mon, const QDict *qdict);
>  void hmp_mce(Monitor *mon, const QDict *qdict);
> +void hmp_info_pg(Monitor *mon, const QDict *qdict);
>  void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
>  void hmp_info_sev(Monitor *mon, const QDict *qdict);
>  void hmp_info_sgx(Monitor *mon, const QDict *qdict);
> diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
> index d1ff659128..00bf2a2116 100644
> --- a/target/i386/arch_memory_mapping.c
> +++ b/target/i386/arch_memory_mapping.c
> @@ -15,6 +15,491 @@
>  #include "cpu.h"
>  #include "sysemu/memory_mapping.h"
>  
> +/**
> + ************** code hook implementations for x86 ***********
> + */
> +
> +#define PML4_ADDR_MASK 0xffffffffff000ULL /* selects bits 51:12 */
> +
> +/**
> + * mmu_page_table_root - Given a CPUState, return the physical address
> + *                       of the current page table root, as well as
> + *                       write the height of the tree into *height.
> + *
> + * @cs - CPU state
> + * @height - a pointer to an integer, to store the page table tree height
> + *
> + * Returns a hardware address on success.  Should not fail (i.e., caller is
> + * responsible to ensure that a page table is actually present).
> + */
> +static hwaddr mmu_page_table_root(CPUState *cs, int *height)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    /*
> +     * DEP 5/15/24: Some original page table walking code sets the a20
> +     * mask as a 32 bit integer and checks it on each level of hte
> +     * page table walk; some only checks it against the final result.
> +     * For 64 bits, I think we need to sign extend in the common case
> +     * it is not set (and returns -1), or we will lose bits.
> +     */
> +    int64_t a20_mask;
> +
> +    assert(cpu_paging_enabled(cs));
> +    a20_mask = x86_get_a20_mask(env);
> +
> +    if (env->cr[4] & CR4_PAE_MASK) {
> +#ifdef TARGET_X86_64
> +        if (env->hflags & HF_LMA_MASK) {
> +            if (env->cr[4] & CR4_LA57_MASK) {
> +                *height = 5;
> +            } else {
> +                *height = 4;
> +            }
> +            return (env->cr[3] & PML4_ADDR_MASK) & a20_mask;
> +        } else
> +#endif
> +        {
> +            *height = 3;
> +            return (env->cr[3] & ~0x1f) & a20_mask;
> +        }
> +    } else {
> +        *height = 2;
> +        return (env->cr[3] & ~0xfff) & a20_mask;
> +    }
> +}
> +
> +
> +/**
> + * mmu_page_table_entries_per_node - Return the number of
> + *                                   entries in a page table
> + *                                   node for the CPU at a given
> + *                                   height.
> + *
> + * @cs - CPU state
> + * @height - height of the page table tree to query, where the leaves
> + *          are 1.
> + *
> + * Returns a value greater than zero on success, -1 on error.
> + */
> +int mmu_page_table_entries_per_node(CPUState *cs, int height)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
> +
> +    assert(height < 6);
> +    assert(height > 0);
> +
> +    switch (height) {
> +#ifdef TARGET_X86_64
> +    case 5:
> +        assert(env->cr[4] & CR4_LA57_MASK);
> +    case 4:
> +        assert(env->hflags & HF_LMA_MASK);
> +        assert(pae_enabled);
> +        return 512;
> +#endif
> +    case 3:
> +        assert(pae_enabled);
> +#ifdef TARGET_X86_64
> +        if (env->hflags & HF_LMA_MASK) {
> +            return 512;
> +        } else
> +#endif
> +        {
> +            return 4;
> +        }
> +    case 2:
> +    case 1:
> +        return pae_enabled ? 512 : 1024;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;
> +}
> +
> +/**
> + * mmu_pte_leaf_page_size - Return the page size of a leaf entry,
> + *                          given the height and CPU state
> + *
> + * @cs - CPU state
> + * @height - height of the page table tree to query, where the leaves
> + *          are 1.
> + *
> + * Returns a value greater than zero on success, -1 on error.
> + */
> +target_ulong mmu_pte_leaf_page_size(CPUState *cs, int height)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
> +
> +    assert(height < 6);
> +    assert(height > 0);
> +
> +    switch (height) {
> +#ifdef TARGET_X86_64
> +    case 5:
> +        assert(pae_enabled);
> +        assert(env->cr[4] & CR4_LA57_MASK);
> +        assert(env->hflags & HF_LMA_MASK);
> +        return 1ULL << 48;
> +    case 4:
> +        assert(pae_enabled);
> +        assert(env->hflags & HF_LMA_MASK);
> +        return 1ULL << 39;
> +#endif
> +    case 3:
> +        assert(pae_enabled);
> +        return 1 << 30;
> +    case 2:
> +        if (pae_enabled) {
> +            return 1 << 21;
> +        } else {
> +            return 1 << 22;
> +        }
> +    case 1:
> +        return 4096;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;
> +}
> +
> +/*
> + * Given a CPU state and height, return the number of bits
> + * to shift right/left in going from virtual to PTE index
> + * and vice versa, the number of useful bits.
> + */
> +static void _mmu_decode_va_parameters(CPUState *cs, int height,
> +                                      int *shift, int *width)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    int _shift = 0;
> +    int _width = 0;
> +    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
> +
> +    switch (height) {
> +    case 5:
> +        _shift = 48;
> +        _width = 9;
> +        break;
> +    case 4:
> +        _shift = 39;
> +        _width = 9;
> +        break;
> +    case 3:
> +        _shift = 30;
> +        _width = 9;
> +        break;
> +    case 2:
> +        /* 64 bit page tables shift from 30->21 bits here */
> +        if (pae_enabled) {
> +            _shift = 21;
> +            _width = 9;
> +        } else {
> +            /* 32 bit page tables shift from 32->22 bits */
> +            _shift = 22;
> +            _width = 10;
> +        }
> +        break;
> +    case 1:
> +        _shift = 12;
> +        if (pae_enabled) {
> +            _width = 9;
> +        } else {
> +            _width = 10;
> +        }
> +
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (shift) {
> +        *shift = _shift;
> +    }
> +
> +    if (width) {
> +        *width = _width;
> +    }
> +}
> +
> +/**
> + * get_pte - Copy the contents of the page table entry at node[i] into pt_entry.
> + *           Optionally, add the relevant bits to the virtual address in
> + *           vaddr_pte.
> + *
> + * @cs - CPU state
> + * @node - physical address of the current page table node
> + * @i - index (in page table entries, not bytes) of the page table
> + *      entry, within node
> + * @height - height of node within the tree (leaves are 1, not 0)
> + * @pt_entry - Poiter to a PTE_t, stores the contents of the page table entry
> + * @vaddr_parent - The virtual address bits already translated in walking the
> + *                 page table to node.  Optional: only used if vaddr_pte is set.
> + * @vaddr_pte - Optional pointer to a variable storing the virtual address bits
> + *              translated by node[i].
> + * @pte_paddr - Pointer to the physical address of the PTE within node.
> + *              Optional parameter.
> + */
> +
> +static void
> +get_pte(CPUState *cs, hwaddr node, int i, int height,
> +        PTE_t *pt_entry, target_ulong vaddr_parent, target_ulong *vaddr_pte,
> +        hwaddr *pte_paddr)
> +
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    int32_t a20_mask = x86_get_a20_mask(env);
> +    hwaddr pte;
> +
> +    if (env->hflags & HF_LMA_MASK) {
> +        /* 64 bit */
> +        int pte_width = 8;
> +        pte = (node + (i * pte_width)) & a20_mask;
> +        pt_entry->pte64_t = address_space_ldq(cs->as, pte,
> +                                              MEMTXATTRS_UNSPECIFIED, NULL);
> +    } else {
> +        /* 32 bit */
> +        int pte_width = 4;
> +        pte = (node + (i * pte_width)) & a20_mask;
> +        pt_entry->pte32_t = address_space_ldl(cs->as, pte,
> +                                              MEMTXATTRS_UNSPECIFIED, NULL);
> +    }
> +
> +    if (vaddr_pte) {
> +        int shift = 0;
> +        _mmu_decode_va_parameters(cs, height, &shift, NULL);
> +        *vaddr_pte = vaddr_parent | ((i & 0x1ffULL) << shift);
> +    }
> +
> +    if (pte_paddr) {
> +        *pte_paddr = pte;
> +    }
> +}
> +
> +
> +static bool
> +mmu_pte_check_bits(CPUState *cs, PTE_t *pte, int64_t mask)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    if (env->hflags & HF_LMA_MASK) {
> +        return pte->pte64_t & mask;
> +    } else {
> +        return pte->pte32_t & mask;
> +    }
> +}
> +
> +/**
> + * mmu_pte_presetn - Return true if the pte is
> + *                   marked 'present'
> + */
> +static bool
> +mmu_pte_present(CPUState *cs, PTE_t *pte)
> +{
> +    return mmu_pte_check_bits(cs, pte, PG_PRESENT_MASK);
> +}
> +
> +/**
> + * mmu_pte_leaf - Return true if the pte is
> + *                a page table leaf, false if
> + *                the pte points to another
> + *                node in the radix tree.
> + */
> +bool
> +mmu_pte_leaf(CPUState *cs, int height, PTE_t *pte)
> +{
> +    return height == 1 || mmu_pte_check_bits(cs, pte, PG_PSE_MASK);
> +}
> +
> +/**
> + * mmu_pte_child - Returns the physical address
> + *                 of a radix tree node pointed to by pte.
> + *
> + * @cs - CPU state
> + * @pte - The page table entry
> + * @height - The height in the tree of pte
> + *
> + * Returns the physical address stored in pte on success,
> + *     -1 on error.
> + */
> +hwaddr
> +mmu_pte_child(CPUState *cs, PTE_t *pte, int height)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
> +    int32_t a20_mask = x86_get_a20_mask(env);
> +
> +    switch (height) {
> +#ifdef TARGET_X86_64
> +    case 5:
> +        assert(env->cr[4] & CR4_LA57_MASK);
> +    case 4:
> +        assert(env->hflags & HF_LMA_MASK);
> +        /* assert(pae_enabled); */
> +        /* Fall through */
> +#endif
> +    case 3:
> +        assert(pae_enabled);
> +#ifdef TARGET_X86_64
> +        if (env->hflags & HF_LMA_MASK) {
> +            return (pte->pte64_t & PG_ADDRESS_MASK) & a20_mask;
> +        } else
> +#endif
> +        {
> +            return (pte->pte64_t & ~0xfff) & a20_mask;
> +        }
> +    case 2:
> +    case 1:
> +        if (pae_enabled) {
> +            return (pte->pte64_t & PG_ADDRESS_MASK) & a20_mask;
> +        } else {
> +            return (pte->pte32_t & ~0xfff) & a20_mask;
> +        }
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;
> +}
> +
> +
> +/**
> + ************** generic page table code ***********
> + */
> +
> +/**
> + * _for_each_pte - recursive helper function
> + *
> + * @cs - CPU state
> + * @fn(cs, data, pte, vaddr, height) - User-provided function to call on each
> + *                                     pte.
> + *   * @cs - pass through cs
> + *   * @data - user-provided, opaque pointer
> + *   * @pte - current pte
> + *   * @vaddr - virtual address translated by pte
> + *   * @height - height in the tree of pte
> + * @data - user-provided, opaque pointer, passed to fn()
> + * @visit_interior_nodes - if true, call fn() on page table entries in
> + *                         interior nodes.  If false, only call fn() on page
> + *                         table entries in leaves.
> + * @visit_not_present - if true, call fn() on entries that are not present.
> + *                         if false, visit only present entries.
> + * @node - The physical address of the current page table radix tree node
> + * @vaddr - The virtual address bits translated in walking the page table to
> + *          node
> + * @height - The height of node in the radix tree
> + *
> + * height starts at the max and counts down.
> + * In a 4 level x86 page table, pml4e is level 4, pdpe is level 3,
> + *  pde is level 2, and pte is level 1
> + *
> + * Returns true on success, false on error.
> + */
> +static bool
> +_for_each_pte(CPUState *cs,
> +              int (*fn)(CPUState *cs, void *data, PTE_t *pte,
> +                        target_ulong vaddr, int height, int offset),
> +              void *data, bool visit_interior_nodes,
> +              bool visit_not_present, hwaddr node,
> +              target_ulong vaddr, int height)
> +{
> +    int ptes_per_node;
> +    int i;
> +
> +    assert(height > 0);
> +
> +    ptes_per_node = mmu_page_table_entries_per_node(cs, height);
> +
> +    for (i = 0; i < ptes_per_node; i++) {
> +        PTE_t pt_entry;
> +        target_ulong vaddr_i;
> +        bool pte_present;
> +
> +        get_pte(cs, node, i, height, &pt_entry, vaddr, &vaddr_i, NULL);
> +        pte_present = mmu_pte_present(cs, &pt_entry);
> +
> +        if (pte_present || visit_not_present) {
> +            if ((!pte_present) || mmu_pte_leaf(cs, height, &pt_entry)) {
> +                if (fn(cs, data, &pt_entry, vaddr_i, height, i)) {
> +                    /* Error */
> +                    return false;
> +                }
> +            } else { /* Non-leaf */
> +                if (visit_interior_nodes) {
> +                    if (fn(cs, data, &pt_entry, vaddr_i, height, i)) {
> +                        /* Error */
> +                        return false;
> +                    }
> +                }
> +                hwaddr child = mmu_pte_child(cs, &pt_entry, height);
> +                assert(height > 1);
> +                if (!_for_each_pte(cs, fn, data, visit_interior_nodes,
> +                                   visit_not_present, child, vaddr_i,
> +                                   height - 1)) {
> +                    return false;
> +                }
> +            }
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +/**
> + * for_each_pte - iterate over a page table, and
> + *                call fn on each entry
> + *
> + * @cs - CPU state
> + * @fn(cs, data, pte, vaddr, height) - User-provided function to call on each
> + *                                     pte.
> + *   * @cs - pass through cs
> + *   * @data - user-provided, opaque pointer
> + *   * @pte - current pte
> + *   * @vaddr - virtual address translated by pte
> + *   * @height - height in the tree of pte
> + * @data - opaque pointer; passed through to fn
> + * @visit_interior_nodes - if true, call fn() on interior entries in
> + *                         page table; if false, visit only leaf entries.
> + * @visit_not_present - if true, call fn() on entries that are not present.
> + *                         if false, visit only present entries.
> + *
> + * Returns true on success, false on error.
> + *
> + */
> +bool for_each_pte(CPUState *cs,
> +                  int (*fn)(CPUState *cs, void *data, PTE_t *pte,
> +                            target_ulong vaddr, int height, int offset),
> +                  void *data, bool visit_interior_nodes,
> +                  bool visit_not_present)
> +{
> +    int height;
> +    target_ulong vaddr = 0;
> +    hwaddr root;
> +
> +    if (!cpu_paging_enabled(cs)) {
> +        /* paging is disabled */
> +        return true;
> +    }
> +
> +    root = mmu_page_table_root(cs, &height);
> +
> +    assert(height > 1);
> +
> +    /* Recursively call a helper to walk the page table */
> +    return _for_each_pte(cs, fn, data, visit_interior_nodes, visit_not_present,
> +                         root, vaddr, height);
> +}
> +
> +/**
> + * Back to x86 hooks
> + */
> +
>  /* PAE Paging or IA-32e Paging */
>  static void walk_pte(MemoryMappingList *list, AddressSpace *as,
>                       hwaddr pte_start_addr,
> @@ -313,4 +798,3 @@ bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
>  
>      return true;
>  }
> -
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index ccccb62fc3..fc3ae55213 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2094,6 +2094,12 @@ struct X86CPUClass {
>      ResettablePhases parent_phases;
>  };
>  
> +/* Intended to become a generic PTE type */
> +typedef union PTE {
> +    uint64_t pte64_t;
> +    uint32_t pte32_t;
> +} PTE_t;
> +
>  #ifndef CONFIG_USER_ONLY
>  extern const VMStateDescription vmstate_x86_cpu;
>  #endif
> @@ -2109,6 +2115,16 @@ int x86_cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
>  int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
>                                   DumpState *s);
>  
> +bool mmu_pte_leaf(CPUState *cs, int height, PTE_t *pte);
> +target_ulong mmu_pte_leaf_page_size(CPUState *cs, int height);
> +hwaddr mmu_pte_child(CPUState *cs, PTE_t *pte, int height);
> +int mmu_page_table_entries_per_node(CPUState *cs, int height);
> +bool for_each_pte(CPUState *cs,
> +                  int (*fn)(CPUState *cs, void *data, PTE_t *pte,
> +                            target_ulong vaddr, int height, int offset),
> +                  void *data, bool visit_interior_nodes,
> +                  bool visit_not_present);
> +
>  bool x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
>                                  Error **errp);
>  
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 2d766b2637..d7aae99c73 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -32,6 +32,201 @@
>  #include "qapi/qapi-commands-misc-target.h"
>  #include "qapi/qapi-commands-misc.h"
>  
> +/* Maximum x86 height */
> +#define MAX_HEIGHT 5
> +
> +struct mem_print_state {
> +    Monitor *mon;
> +    CPUArchState *env;
> +    int vaw, paw; /* VA and PA width in characters */
> +    int max_height;
> +    bool (*flusher)(CPUState *cs, struct mem_print_state *state);
> +    bool flush_interior; /* If false, only call flusher() on leaves */
> +    bool require_physical_contiguity;
> +    /*
> +     * The height at which we started accumulating ranges, i.e., the
> +     * next height we need to print once we hit the end of a
> +     * contiguous range.
> +     */
> +    int start_height;
> +    /*
> +     * For compressing contiguous ranges, track the
> +     * start and end of the range
> +     */
> +    hwaddr vstart[MAX_HEIGHT + 1]; /* Starting virt. addr. of open pte range */
> +    hwaddr vend[MAX_HEIGHT + 1]; /* Ending virtual address of open pte range */
> +    hwaddr pstart; /* Starting physical address of open pte range */
> +    hwaddr pend; /* Ending physical address of open pte range */
> +    int64_t ent[MAX_HEIGHT + 1]; /* PTE contents on current root->leaf path */
> +    int offset[MAX_HEIGHT + 1]; /* PTE range starting offsets */
> +    int last_offset[MAX_HEIGHT + 1]; /* PTE range ending offsets */
> +};
> +
> +/********************* x86 specific hooks for printing page table stuff ****/
> +
> +const char *names[7] = {(char *)NULL, "PTE", "PDE", "PDP", "PML4", "Pml5",
> +                        (char *)NULL};
> +static char *pg_bits(hwaddr ent)
> +{
> +    static char buf[32];
> +    sprintf(buf, "%c%c%c%c%c%c%c%c%c%c",
> +            ent & PG_NX_MASK ? 'X' : '-',
> +            ent & PG_GLOBAL_MASK ? 'G' : '-',
> +            ent & PG_PSE_MASK ? 'S' : '-',
> +            ent & PG_DIRTY_MASK ? 'D' : '-',
> +            ent & PG_ACCESSED_MASK ? 'A' : '-',
> +            ent & PG_PCD_MASK ? 'C' : '-',
> +            ent & PG_PWT_MASK ? 'T' : '-',
> +            ent & PG_USER_MASK ? 'U' : '-',
> +            ent & PG_RW_MASK ? 'W' : '-',
> +            ent & PG_PRESENT_MASK ? 'P' : '-');
> +    return buf;
> +}
> +
> +static bool init_iterator(Monitor *mon, struct mem_print_state *state)
> +{
> +    CPUArchState *env;
> +    state->mon = mon;
> +    state->flush_interior = false;
> +    state->require_physical_contiguity = false;
> +
> +    for (int i = 0; i < MAX_HEIGHT; i++) {
> +        state->vstart[i] = -1;
> +        state->last_offset[i] = 0;
> +    }
> +    state->start_height = 0;
> +
> +    env = mon_get_cpu_env(mon);
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return false;
> +    }
> +    state->env = env;
> +
> +    if (!(env->cr[0] & CR0_PG_MASK)) {
> +        monitor_printf(mon, "PG disabled\n");
> +        return false;
> +    }
> +
> +    /* set va and pa width */
> +    if (env->cr[4] & CR4_PAE_MASK) {
> +        state->paw = 13;
> +#ifdef TARGET_X86_64
> +        if (env->hflags & HF_LMA_MASK) {
> +            if (env->cr[4] & CR4_LA57_MASK) {
> +                state->vaw = 15;
> +                state->max_height = 5;
> +            } else {
> +                state->vaw = 12;
> +                state->max_height = 4;
> +            }
> +        } else
> +#endif
> +        {
> +            state->vaw = 8;
> +            state->max_height = 3;
> +        }
> +    } else {
> +        state->max_height = 2;
> +        state->vaw = 8;
> +        state->paw = 8;
> +    }
> +
> +    return true;
> +}
> +
> +static void pg_print_header(Monitor *mon, struct mem_print_state *state)
> +{
> +    /* Header line */
> +    monitor_printf(mon, "%-*s %-13s %-10s %*s%s\n",
> +                   3 + 2 * (state->vaw - 3), "VPN range",
> +                   "Entry", "Flags",
> +                   2 * (state->max_height - 1), "", "Physical page(s)");
> +}
> +
> +
> +static void pg_print(CPUState *cs, Monitor *mon, uint64_t pt_ent,
> +                     target_ulong vaddr_s, target_ulong vaddr_l,
> +                     hwaddr paddr_s, hwaddr paddr_l,
> +                     int offset_s, int offset_l,
> +                     int height, int max_height, int vaw, int paw,
> +                     bool is_leaf)
> +
> +{
> +    char buf[128];
> +    char *pos = buf, *end = buf + sizeof(buf);
> +    target_ulong size = mmu_pte_leaf_page_size(cs, height);
> +
> +    /* VFN range */
> +    pos += sprintf(pos, "%*s[%0*"PRIx64"-%0*"PRIx64"] ",
> +                   (max_height - height) * 2, "",
> +                   vaw - 3, (uint64_t)vaddr_s >> 12,
> +                   vaw - 3, ((uint64_t)vaddr_l + size - 1) >> 12);
> +
> +    /* Slot */
> +    if (vaddr_s == vaddr_l) {
> +        pos += sprintf(pos, "%4s[%03x]    ",
> +                       names[height], offset_s);
> +    } else {
> +        pos += sprintf(pos, "%4s[%03x-%03x]",
> +                       names[height], offset_s, offset_l);
> +    }
> +
> +    /* Flags */
> +    pos += sprintf(pos, " %s", pg_bits(pt_ent));
> +
> +
> +    /* Range-compressed PFN's */
> +    if (is_leaf) {
> +        if (vaddr_s == vaddr_l) {
> +            pos += snprintf(pos, end - pos, " %0*"PRIx64,
> +                            paw - 3, (uint64_t)paddr_s >> 12);
> +        } else {
> +            pos += snprintf(pos, end - pos, " %0*"PRIx64"-%0*"PRIx64,
> +                            paw - 3, (uint64_t)paddr_s >> 12,
> +                            paw - 3, (uint64_t)paddr_l >> 12);
> +        }
> +        pos = MIN(pos, end);
> +    }
> +
> +    /* Trim line to fit screen */
> +    if (pos - buf > 79) {
> +        strcpy(buf + 77, "..");
> +    }
> +
> +    monitor_printf(mon, "%s\n", buf);
> +}
> +
> +static inline
> +int ent2prot(uint64_t prot)
> +{
> +    return prot & (PG_USER_MASK | PG_RW_MASK |
> +                   PG_PRESENT_MASK);
> +}
> +
> +/* Returns true if it emitted anything */
> +static
> +bool flush_print_pg_state(CPUState *cs, struct mem_print_state *state)
> +{
> +    bool ret = false;
> +    for (int i = state->start_height; i > 0; i--) {
> +        if (state->vstart[i] == -1) {
> +            break;
> +        }
> +        PTE_t my_pte;
> +        my_pte.pte64_t = state->ent[i];
> +        ret = true;
> +        pg_print(cs, state->mon, state->ent[i],
> +                 state->vstart[i], state->vend[i],
> +                 state->pstart, state->pend,
> +                 state->offset[i], state->last_offset[i],
> +                 i, state->max_height, state->vaw, state->paw,
> +                 mmu_pte_leaf(cs, i, &my_pte));
> +    }
> +
> +    return ret;
> +}
> +
>  /* Perform linear address sign extension */
>  static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>  {
> @@ -49,6 +244,191 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>      return addr;
>  }
>  
> +
> +
> +/*************************** Start generic page table monitor code *********/
> +
> +/* Assume only called on present entries */
> +static
> +int compressing_iterator(CPUState *cs, void *data, PTE_t *pte,
> +                         target_ulong vaddr, int height, int offset)
> +{
> +    struct mem_print_state *state = (struct mem_print_state *) data;
> +    hwaddr paddr = mmu_pte_child(cs, pte, height);
> +    target_ulong size = mmu_pte_leaf_page_size(cs, height);
> +    bool start_new_run = false, flush = false;
> +    bool is_leaf = mmu_pte_leaf(cs, height, pte);
> +
> +    int entries_per_node = mmu_page_table_entries_per_node(cs, height);
> +
> +    /* Prot of current pte */
> +    int prot = ent2prot(pte->pte64_t);
> +
> +
> +    /* If there is a prior run, first try to extend it. */
> +    if (state->start_height != 0) {
> +
> +        /*
> +         * If we aren't flushing interior nodes, raise the start height.
> +         * We don't need to detect non-compressible interior nodes.
> +         */
> +        if ((!state->flush_interior) && state->start_height < height) {
> +            state->start_height = height;
> +            state->vstart[height] = vaddr;
> +            state->vend[height] = vaddr;
> +            state->ent[height] = pte->pte64_t;
> +            if (offset == 0) {
> +                state->last_offset[height] = entries_per_node - 1;
> +            } else {
> +                state->last_offset[height] = offset - 1;
> +            }
> +        }
> +
> +        /* Detect when we are walking down the "left edge" of a range */
> +        if (state->vstart[height] == -1
> +            && (height + 1) <= state->start_height
> +            && state->vstart[height + 1] == vaddr) {
> +
> +            state->vstart[height] = vaddr;
> +            state->vend[height] = vaddr;
> +            state->ent[height] = pte->pte64_t;
> +            state->offset[height] = offset;
> +            state->last_offset[height] = offset;
> +
> +            if (is_leaf) {
> +                state->pstart = paddr;
> +                state->pend = paddr;
> +            }
> +
> +            /* Detect contiguous entries at same level */
> +        } else if ((state->vstart[height] != -1)
> +                   && (state->start_height >= height)
> +                   && ent2prot(state->ent[height]) == prot
> +                   && (((state->last_offset[height] + 1) % entries_per_node)
> +                       == offset)
> +                   && ((!is_leaf)
> +                       || (!state->require_physical_contiguity)
> +                       || (state->pend + size == paddr))) {
> +
> +
> +            /*
> +             * If there are entries at the levels below, make sure we
> +             * completed them.  We only compress interior nodes
> +             * without holes in the mappings.
> +             */
> +            if (height != 1) {
> +                for (int i = height - 1; i >= 1; i--) {
> +                    int entries = mmu_page_table_entries_per_node(cs, i);
> +
> +                    /* Stop if we hit large pages before level 1 */
> +                    if (state->vstart[i] == -1) {
> +                        break;
> +                    }
> +
> +                    if ((state->last_offset[i] + 1) != entries) {
> +                        flush = true;
> +                        start_new_run = true;
> +                        break;
> +                    }
> +                }
> +            }
> +
> +
> +            if (!flush) {
> +
> +                /* We can compress these entries */
> +                state->ent[height] = pte->pte64_t;
> +                state->vend[height] = vaddr;
> +                state->last_offset[height] = offset;
> +
> +                /* Only update the physical range on leaves */
> +                if (is_leaf) {
> +                    state->pend = paddr;
> +                }
> +            }
> +            /* Let PTEs accumulate... */
> +        } else {
> +            flush = true;
> +        }
> +
> +        if (flush) {
> +            /*
> +             * We hit dicontiguous permissions or pages.
> +             * Print the old entries, then start accumulating again
> +             *
> +             * Some clients only want the flusher called on a leaf.
> +             * Check that too.
> +             *
> +             * We can infer whether the accumulated range includes a
> +             * leaf based on whether pstart is -1.
> +             */
> +            if (state->flush_interior || (state->pstart != -1)) {
> +                if (state->flusher(cs, state)) {
> +                    start_new_run = true;
> +                }
> +            } else {
> +                start_new_run = true;
> +            }
> +        }
> +    } else {
> +        start_new_run = true;
> +    }
> +
> +    if (start_new_run) {
> +        /* start a new run with this PTE */
> +        for (int i = state->start_height; i > 0; i--) {
> +            if (state->vstart[i] != -1) {
> +                state->ent[i] = 0;
> +                state->last_offset[i] = 0;
> +                state->vstart[i] = -1;
> +            }
> +        }
> +        state->pstart = -1;
> +        state->vstart[height] = vaddr;
> +        state->vend[height] = vaddr;
> +        state->ent[height] = pte->pte64_t;
> +        state->offset[height] = offset;
> +        state->last_offset[height] = offset;
> +        if (is_leaf) {
> +            state->pstart = paddr;
> +            state->pend = paddr;
> +        }
> +        state->start_height = height;
> +    }
> +
> +    return 0;
> +}
> +
> +
> +void hmp_info_pg(Monitor *mon, const QDict *qdict)
> +{
> +    struct mem_print_state state;
> +
> +    CPUState *cs = mon_get_cpu(mon);
> +    if (!cs) {
> +        monitor_printf(mon, "Unable to get CPUState.  Internal error\n");
> +        return;
> +    }
> +
> +    if (!init_iterator(mon, &state)) {
> +        return;
> +    }
> +    state.flush_interior = true;
> +    state.require_physical_contiguity = true;
> +    state.flusher = &flush_print_pg_state;
> +
> +    pg_print_header(mon, &state);
> +
> +    /*
> +     * We must visit interior entries to get the hierarchy, but
> +     * can skip not present mappings
> +     */
> +    for_each_pte(cs, &compressing_iterator, &state, true, false);
> +
> +    /* Print last entry, if one present */
> +    flush_print_pg_state(cs, &state);
> +}
> +
>  static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
>                        hwaddr pte, hwaddr mask)
>  {
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

