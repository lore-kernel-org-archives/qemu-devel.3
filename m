Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9C8D3568C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 08:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl0bA-0005rt-KL; Wed, 28 Jan 2026 03:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl0b7-0005r8-9H
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:08:22 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl0b5-0004sV-3c
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:08:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so50620385e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 00:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769587697; x=1770192497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/Zqh75iF9/g+X3p69jmY1/g03ci5h0TTSeU8GN5oYg=;
 b=nZrjKB/VQLxg6Gzl/iBI77KcwwTPhKCxuWcQ04llvkfbb+tKrvANDnqBXEVEkkkpKV
 mfXbUHTCVi2ec5hDpVsIhkX2wzqooP29C1RDxLBkZOGb6pxOswcN3XaMn1zXM/IN76N1
 Fb4Rcb6vmjNSwGhM9mRU0qXnXwc8EdOAiYUtk2Bq1k/uZ5Gs8dQvAkK3TeM7PbBuvLGW
 Bp09A7WAtyEu9NrWWyiJ+qvHLzQaJ2Y716PejaPq1iZhJnKqDE+WHifP+n7L6jTjFrYQ
 sQyK2f9G5zrT/UJ0bR/DDLbsjZtqmHO1nF84Hyc5qMgqRi6DfaPgzGyOAr9H7EBlIxTx
 LnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769587697; x=1770192497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S/Zqh75iF9/g+X3p69jmY1/g03ci5h0TTSeU8GN5oYg=;
 b=FIkrNkzISWaw9huBl9ldRHsMn06JlaZlbU4r5ev8khKRUXHnjEw2hY9+VQpbQkUaiu
 DpafZRkm58iRF1d+zEeAM5G7fmOl6ZJjYyXwWDqU+88JtDy3VZyr/Gm12slIZOo9Y7XT
 FuVi0xp246t1+hdN7ql8qq5KIHxUfOuBbGEIKdohlSvMAxXe39FuEVGWUkQ0a9Ypc+55
 erUIv9iT8vyczL6izh5ofhI7tm1dJ4ZYPGPVQSh86bIpXQhRwIiTIQ859idTgyJR0Lx6
 mOXyfnh0JmjtMebJh7FOlq+YGpfcSRlLgL0rKv9vur+Bi7evQhd5mW0K4yYkt7Cx6zJl
 1t4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ0qWjQjnkljc6IaJF5WQuil0w+lbYMX9PRft93YphmILjZA5D6ZZLs7I09Zd2CDyT0e3E/RzU+1Nw@nongnu.org
X-Gm-Message-State: AOJu0YzBZkAMK91OeHGo85e8GOk/s1iCrKeeO7nHAAYQF9o4c2ODb7jR
 SL4N2RlbyOKKwvzc4Tm2JK+nF/WprssCoLe3UyPB9vupYXIohCpWFpBG66gaOEw+0Ms=
X-Gm-Gg: AZuq6aJ97yw8It6NTkFixvf02iO9YtEz8T5LwvnCWiLJ7nOaB8erWSfsQ45BmoVWDcB
 zskvrOFYlDPC7EWUQ+L69bBuEbhzwMSIvTp0YgHnbqp56M0UeAgcf9HKAnKY/c/62K0J9XrbA5v
 mFGVYKXnu2QEM9hdP73WLARsc45E3LU9VDUK7IhIy1HTKhdzdDa8MdQyFfiyALsQXoFDIRnA526
 lfN8fTydxHg3VcCeK56mELzp4oZKTwgmqShmqYsV5fjNDbZKJdEOwHgj51CWSdXnDBYzU/4tJQu
 XbMugaxgewil8Mn00zmaxFCqr6kO6pfiaXZa5rTHKh6UTySuUXz9xrQLLIvEG1jHGqtuzqbygb8
 5Bp+uiOj78ogIKOn7LQKdqdpaicsIdKBF8K+KBlet1RrkdrSCs+JiFml3aEYVHXe+oAgtSFXzj5
 LBoYzNQhI3P92uTeHZ0STpmsGQBCnwBr+Hev8fsaqks61Y9PnedphcXw==
X-Received: by 2002:a05:600c:34cc:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-48069c4b06emr47158245e9.14.1769587697122; 
 Wed, 28 Jan 2026 00:08:17 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c4f3edsm110447285e9.15.2026.01.28.00.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 00:08:16 -0800 (PST)
Message-ID: <9dc6e638-8a33-45d3-9b6a-89880be3f8f6@linaro.org>
Date: Wed, 28 Jan 2026 09:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/tcg: Fix iotlb_to_section() for different
 AddressSpace
Content-Language: en-US
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Mark Burton <mburton@qti.qualcomm.com>
References: <20260128063907.2066100-1-jim.shu@sifive.com>
 <20260128063907.2066100-2-jim.shu@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260128063907.2066100-2-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Hi Jim,

On 28/1/26 07:39, Jim Shu wrote:
> 'CPUTLBEntryFull.xlat_section' stores section_index in last 12 bits to
> find the correct section when CPU access the IO region over the IOTLB.
> However, section_index is only unique inside single AddressSpace. If
> address space translation is over IOMMUMemoryRegion, it could return
> section from other AddressSpace. 'iotlb_to_section()' API only finds the
> sections from CPU's AddressSpace so that it couldn't find section in
> other AddressSpace. Thus, using 'iotlb_to_section()' API will find the
> wrong section and QEMU will have wrong load/store access.
> 
> To fix this bug of iotlb_to_section(), store complete MemoryRegionSection
> pointer in CPUTLBEntryFull to replace the section_index in xlat_section.
> Rename 'xlat_section' to 'xlat' as we remove last 12 bits section_index
> inside. Also, since we directly use section pointer in the
> CPUTLBEntryFull (full->section), we can remove the unused functions:
> iotlb_to_section(), memory_region_section_get_iotlb().
> 
> This bug occurs only when
> (1) IOMMUMemoryRegion is in the path of CPU access.
> (2) IOMMUMemoryRegion returns different target_as and the section is in
> the IO region.
> 
> Common IOMMU devices don't have this issue since they are only in the
> path of DMA access. Currently, the bug only occurs when ARM MPC device
> (hw/misc/tz-mpc.c) returns 'blocked_io_as' to emulate blocked access
> handling. Upcoming RISC-V wgChecker [1] and IOPMP [2] devices are also
> affected by this bug.
> 
> [1] RISC-V WG:
> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> [2] RISC-V IOPMP:
> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   accel/tcg/cputlb.c        | 32 +++++++++++++++-----------------
>   include/accel/tcg/iommu.h | 15 ---------------
>   include/exec/cputlb.h     |  2 +-
>   include/hw/core/cpu.h     | 12 +++++++-----
>   system/physmem.c          | 25 -------------------------
>   5 files changed, 23 insertions(+), 63 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 6900a126827..c61339d10a3 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1090,7 +1090,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>           }
>       } else {
>           /* I/O or ROMD */
> -        iotlb = memory_region_section_get_iotlb(cpu, section) + xlat;
> +        iotlb = xlat;
>           /*
>            * Writes to romd devices must go through MMIO to enable write.
>            * Reads to romd devices go through the ram_ptr found above,
> @@ -1141,10 +1141,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       /*
>        * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
>        * aligned ram_addr_t of the page base of the target RAM.
> -     * Otherwise, iotlb contains
> -     *  - a physical section number in the lower TARGET_PAGE_BITS
> -     *  - the offset within section->mr of the page base (I/O, ROMD) with the
> -     *    TARGET_PAGE_BITS masked off.
> +     * Otherwise, iotlb contains a TARGET_PAGE_BITS aligned
> +     * offset within section->mr of the page base (I/O, ROMD)
> +     *
>        * We subtract addr_page (which is page aligned and thus won't
>        * disturb the low bits) to give an offset which can be added to the
>        * (non-page-aligned) vaddr of the eventual memory access to get
> @@ -1154,7 +1153,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>        */
>       desc->fulltlb[index] = *full;
>       full = &desc->fulltlb[index];
> -    full->xlat_section = iotlb - addr_page;
> +    full->xlat = iotlb - addr_page;
> +    full->section = section;
>       full->phys_addr = paddr_page;
>   
>       /* Now calculate the new entry */
> @@ -1270,14 +1270,14 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
>   }
>   
>   static MemoryRegionSection *
> -io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
> +io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
>              MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)

Can you move the io_prepare() argument change in a preliminary patch
to make this one simpler to review?

>   {
>       MemoryRegionSection *section;
>       hwaddr mr_offset;
>   
> -    section = iotlb_to_section(cpu, xlat, attrs);
> -    mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
> +    section = full->section;
> +    mr_offset = full->xlat + addr;
>       cpu->mem_io_pc = retaddr;
>       if (!cpu->neg.can_do_io) {
>           cpu_io_recompile(cpu, retaddr);
> @@ -1336,7 +1336,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
>   static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
>                              CPUTLBEntryFull *full, uintptr_t retaddr)
>   {
> -    ram_addr_t ram_addr = mem_vaddr + full->xlat_section;
> +    ram_addr_t ram_addr = mem_vaddr + full->xlat;
>   
>       trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
>   
> @@ -1593,9 +1593,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
>   
>       /* We must have an iotlb entry for MMIO */
>       if (tlb_addr & TLB_MMIO) {
> -        MemoryRegionSection *section =
> -            iotlb_to_section(cpu, full->xlat_section & ~TARGET_PAGE_MASK,
> -                             full->attrs);
> +        MemoryRegionSection *section = full->section;
>           data->is_io = true;
>           data->mr = section->mr;
>       } else {
> @@ -1981,7 +1979,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>       tcg_debug_assert(size > 0 && size <= 8);
>   
>       attrs = full->attrs;
> -    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
> +    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
>       mr = section->mr;
>   
>       BQL_LOCK_GUARD();
> @@ -2002,7 +2000,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>       tcg_debug_assert(size > 8 && size <= 16);
>   
>       attrs = full->attrs;
> -    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
> +    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
>       mr = section->mr;
>   
>       BQL_LOCK_GUARD();
> @@ -2499,7 +2497,7 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
>       tcg_debug_assert(size > 0 && size <= 8);
>   
>       attrs = full->attrs;
> -    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
> +    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
>       mr = section->mr;
>   
>       BQL_LOCK_GUARD();
> @@ -2519,7 +2517,7 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
>       tcg_debug_assert(size > 8 && size <= 16);
>   
>       attrs = full->attrs;
> -    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
> +    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
>       mr = section->mr;
>   
>       BQL_LOCK_GUARD();
> diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
> index 90cfd6c0ed1..547f8ea0ef0 100644
> --- a/include/accel/tcg/iommu.h
> +++ b/include/accel/tcg/iommu.h
> @@ -14,18 +14,6 @@
>   #include "exec/hwaddr.h"
>   #include "exec/memattrs.h"
>   
> -/**
> - * iotlb_to_section:
> - * @cpu: CPU performing the access
> - * @index: TCG CPU IOTLB entry
> - *
> - * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
> - * it refers to. @index will have been initially created and returned
> - * by memory_region_section_get_iotlb().
> - */
> -MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> -                                      hwaddr index, MemTxAttrs attrs);
> -
>   MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
>                                                          int asidx,
>                                                          hwaddr addr,
> @@ -34,8 +22,5 @@ MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
>                                                          MemTxAttrs attrs,
>                                                          int *prot);
>   
> -hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> -                                       MemoryRegionSection *section);
> -
>   #endif
>   
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index 0d1d46429c9..e599a0f7627 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -44,7 +44,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
>    * @full: the details of the tlb entry
>    *
>    * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
> - * @full must be filled, except for xlat_section, and constitute
> + * @full must be filled, except for xlat, and constitute
>    * the complete description of the translated page.
>    *
>    * This is generally called by the target tlb_fill function after
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 61da2ea4331..7de576ab602 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -219,15 +219,17 @@ typedef uint32_t MMUIdxMap;
>    */
>   struct CPUTLBEntryFull {
>       /*
> -     * @xlat_section contains:
> -     *  - in the lower TARGET_PAGE_BITS, a physical section number
> -     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
> -     *    must be added to the virtual address to obtain:
> +     * @xlat contains:
> +     *  - a TARGET_PAGE_BITS aligned offset which must be added to

Drop "contains":

   * @xlat_offset: TARGET_PAGE_BITS aligned offset which must be added to

> +     *    the virtual address to obtain:
>        *     + the ram_addr_t of the target RAM (if the physical section
>        *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
>        *     + the offset within the target MemoryRegion (otherwise)
>        */
> -    hwaddr xlat_section;
> +    hwaddr xlat;

I'd rename as 'xlat_offset' instead for clarity.

> +
> +    /* @section contains physical section. */
> +    MemoryRegionSection *section;

Good. Safe because 'the CPUIOTLBEntry layout is not as critical as that
of the CPUTLBEntry.' (commit e469b22ffda).

>   
>       /*
>        * @phys_addr contains the physical address in the address space
> diff --git a/system/physmem.c b/system/physmem.c
> index b0311f45312..d17596a77fb 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -747,31 +747,6 @@ translate_fail:
>       return &d->map.sections[PHYS_SECTION_UNASSIGNED];
>   }
>   
> -MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> -                                      hwaddr index, MemTxAttrs attrs)
> -{
> -    int asidx = cpu_asidx_from_attrs(cpu, attrs);
> -    CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
> -    AddressSpaceDispatch *d = address_space_to_dispatch(cpuas->as);
> -    int section_index = index & ~TARGET_PAGE_MASK;
> -    MemoryRegionSection *ret;
> -
> -    assert(section_index < d->map.sections_nb);
> -    ret = d->map.sections + section_index;
> -    assert(ret->mr);
> -    assert(ret->mr->ops);
> -
> -    return ret;
> -}
> -
> -/* Called from RCU critical section */
> -hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> -                                       MemoryRegionSection *section)
> -{
> -    AddressSpaceDispatch *d = flatview_to_dispatch(section->fv);
> -    return section - d->map.sections;
> -}
> -
>   #endif /* CONFIG_TCG */

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


