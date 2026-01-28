Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4032D3F06F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl6Tj-00027u-Tb; Wed, 28 Jan 2026 09:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl6Te-00027F-46
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:25:02 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl6Tb-00077a-Cs
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:25:01 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65815ec51d3so12537971a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 06:24:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769610297; cv=none;
 d=google.com; s=arc-20240605;
 b=j6uzeiWClntRIrUzMekV6TNnqHKS7z93Q+nJ/4MybnnxWWgdpIf+LGNW62+9eXhRX+
 fShKofVXnS9pK0EPXuwudYiD2rBBzqCEhEnTXm2lyPewF6fQmdhMGcliz5+S8WHsPj6s
 CIhRpIDZ4Fs8JLws1lHC0PH+OY+iOja0TSuu+7Kcf4pku9vxAoUZwnwKOiH6lpa74Uoi
 AoZYbWYLarj3oyfSBH8HL4n+ZAhJlBVEKQ6eTWRbezaiYK+1PMbZVdRELFy4g+qFGAtP
 VMJ628/8KBz0C7qS3PIpMJgyzO/sfgVZpeJ6ZvYMlqNnSOxSWe6VmkpRKkjQuLLmzLcJ
 9fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pQAiKIkxb4tNaA5ZSMBIE0CfDSH54qUSmU/xHUt0MpU=;
 fh=e396GVSz4zS3adu+PlpwVDoC6ST1dUeugNAQPCqMUzs=;
 b=WXcwTKGYnKqtP1uaBd18y/n7kmKEZpcq+y5D5IdWYrfqfFF48LzgomKGFi6YLeD+Uz
 3tZTzcf38a9Y35VneJXDHDwRJbPPhh2qndKDrHFZ42wAgi7RTBSu3D2dqSyokVezUypo
 6EtDkSp2WSS8f1RY+XwHPgK7n0bnGD5qFRH/2pT7v9ArsytNsUTv/grfk5SApBaunCIh
 VtSR3950Kovi+mIb9Q/jhzWJG9w0/vWvfC89uBZaltCg2mOG6B0PwIm+sQtgHXTXHxf7
 q12YjMo9jwQ4BsTvghpK1NQYrCdpHCj5yGzDNGI9ot3Ej0ZXoqNGXmV2Y793Mw6Ts93y
 vfag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769610297; x=1770215097; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQAiKIkxb4tNaA5ZSMBIE0CfDSH54qUSmU/xHUt0MpU=;
 b=UBWswTJxdb/W6ConDjHMiU+NjcpqT8xlT00m4xVziGSDDSdtSG0xDXf1iukeycGyJq
 gXBIZyusfLYO7DQYzBG1bM1IHnpJB1dR37Xv/PJnOcU0ELx6gCawzj6LYUWyKbiRfe1U
 BIBc1WBnnaxB4SNv6ghSWL82ORJvhwB7J0nBgDYwfu/puTRTWPGNlDl0hTY7eCFWBoYf
 40qVSrpKCKWcp/Z8U/S7/8evSzvkDacj8ph7BefKNPpbGR3YwmVi7vSkGVA5Yp4c5d7F
 WvhkXnaWQhpt0QN4zgv8UVty+yPONMhmjz8hTYODfI2j4Qn7gQBXwe16dLcBA6+jsGLz
 0D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769610297; x=1770215097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pQAiKIkxb4tNaA5ZSMBIE0CfDSH54qUSmU/xHUt0MpU=;
 b=rIA8dl/AGdPaV4BAN+S0D9wVT3KZ5BK6oHKDo8N73PPyl3MrsfZURhCNYtLo8v6hjO
 2yikglyK+r2jXDvWjN4IjYm9nzAHApPHM2OrdpR/rxWuGjoMQFD9QGGRTSrG5zaxvKsK
 Pb4FWXaYQF49VD/CTUCJa3hCAmbdgAoSfOZxOJ232d/MbVkKFtLzz952nB7gp4btx0Iz
 G+pcYp1ef0X2Y8XT7XHe0SRTgfQMfJkJfirEp1yeAAw1xlTx0YFx6jktL+PHOiW9JnTc
 bOB2C7qSFoqR+TMXjNA/LWV3wyD2+4wYp8cVUrFwUf4Gv2zkLFVIQg5/Y9KieyQ56kTm
 80MQ==
X-Gm-Message-State: AOJu0Yyxv65oSzFhfGmGcBAR/8IdNwpJ/HTJGHeUaf5Ppzq/1/khS+/O
 sfWZ5ZaDCTadX/4WPUMjmbNIcKRMeNzD3CkdN4D4VifkTPV1Ent6EwJLd1c2YRaVi4Gzh0VV8wI
 wPLnQyOUb+4RltflxdfXxC6XpSLJnMRdgX9n0OFYggSvufFECA0EB/3U=
X-Gm-Gg: AZuq6aIqo0l85F79yKUwj52MqvGO5ONhFC9RRa4mEeTaz3UBFhJZScp0AfBRfgUGDro
 nl3otbo3puwWxct0ZuEOeQQUwtnD+I9ZVx10Nw25T/HhyfwHTETISYlEQRt3QUHwPRJFcquSJzm
 MBzBTB78fF/Siedbje9SkMaZz6PTGWDRw5lD5eQzH+vdzVNhtl8aIUoHe0BhQoDZF/rjNHt8baX
 NPdEAXP3Yar8J/qi5Uzcggoclx74BbVDS7c0ZeuTac4dcAsWRKsQg+QTpg+bqy5++sS1uvYqg==
X-Received: by 2002:a17:907:97c7:b0:b76:c498:d40f with SMTP id
 a640c23a62f3a-b8dab15bf31mr392838666b.4.1769610296614; Wed, 28 Jan 2026
 06:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20260128063907.2066100-1-jim.shu@sifive.com>
 <20260128063907.2066100-2-jim.shu@sifive.com>
 <9dc6e638-8a33-45d3-9b6a-89880be3f8f6@linaro.org>
In-Reply-To: <9dc6e638-8a33-45d3-9b6a-89880be3f8f6@linaro.org>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 28 Jan 2026 22:24:46 +0800
X-Gm-Features: AZwV_QjX2opW6BRm-pMgWVQ7AnCZ8PtmLSpWmoHL2UoZkXecJUfTHRX1ly_eRp0
Message-ID: <CALw707pw3LMDZQPjPSg3V0mZnaxHOnwFAcTp+hm7+8rAxu4ueA@mail.gmail.com>
Subject: Re: [PATCH 1/2] accel/tcg: Fix iotlb_to_section() for different
 AddressSpace
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Mark Burton <mburton@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x532.google.com
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

Hi Philippe,

Thanks for reviewing it!

On Wed, Jan 28, 2026 at 4:08=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Jim,
>
> On 28/1/26 07:39, Jim Shu wrote:
> > 'CPUTLBEntryFull.xlat_section' stores section_index in last 12 bits to
> > find the correct section when CPU access the IO region over the IOTLB.
> > However, section_index is only unique inside single AddressSpace. If
> > address space translation is over IOMMUMemoryRegion, it could return
> > section from other AddressSpace. 'iotlb_to_section()' API only finds th=
e
> > sections from CPU's AddressSpace so that it couldn't find section in
> > other AddressSpace. Thus, using 'iotlb_to_section()' API will find the
> > wrong section and QEMU will have wrong load/store access.
> >
> > To fix this bug of iotlb_to_section(), store complete MemoryRegionSecti=
on
> > pointer in CPUTLBEntryFull to replace the section_index in xlat_section=
.
> > Rename 'xlat_section' to 'xlat' as we remove last 12 bits section_index
> > inside. Also, since we directly use section pointer in the
> > CPUTLBEntryFull (full->section), we can remove the unused functions:
> > iotlb_to_section(), memory_region_section_get_iotlb().
> >
> > This bug occurs only when
> > (1) IOMMUMemoryRegion is in the path of CPU access.
> > (2) IOMMUMemoryRegion returns different target_as and the section is in
> > the IO region.
> >
> > Common IOMMU devices don't have this issue since they are only in the
> > path of DMA access. Currently, the bug only occurs when ARM MPC device
> > (hw/misc/tz-mpc.c) returns 'blocked_io_as' to emulate blocked access
> > handling. Upcoming RISC-V wgChecker [1] and IOPMP [2] devices are also
> > affected by this bug.
> >
> > [1] RISC-V WG:
> > https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> > [2] RISC-V IOPMP:
> > https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com=
/
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   accel/tcg/cputlb.c        | 32 +++++++++++++++-----------------
> >   include/accel/tcg/iommu.h | 15 ---------------
> >   include/exec/cputlb.h     |  2 +-
> >   include/hw/core/cpu.h     | 12 +++++++-----
> >   system/physmem.c          | 25 -------------------------
> >   5 files changed, 23 insertions(+), 63 deletions(-)
> >
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 6900a126827..c61339d10a3 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -1090,7 +1090,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx=
,
> >           }
> >       } else {
> >           /* I/O or ROMD */
> > -        iotlb =3D memory_region_section_get_iotlb(cpu, section) + xlat=
;
> > +        iotlb =3D xlat;
> >           /*
> >            * Writes to romd devices must go through MMIO to enable writ=
e.
> >            * Reads to romd devices go through the ram_ptr found above,
> > @@ -1141,10 +1141,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_id=
x,
> >       /*
> >        * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
> >        * aligned ram_addr_t of the page base of the target RAM.
> > -     * Otherwise, iotlb contains
> > -     *  - a physical section number in the lower TARGET_PAGE_BITS
> > -     *  - the offset within section->mr of the page base (I/O, ROMD) w=
ith the
> > -     *    TARGET_PAGE_BITS masked off.
> > +     * Otherwise, iotlb contains a TARGET_PAGE_BITS aligned
> > +     * offset within section->mr of the page base (I/O, ROMD)
> > +     *
> >        * We subtract addr_page (which is page aligned and thus won't
> >        * disturb the low bits) to give an offset which can be added to =
the
> >        * (non-page-aligned) vaddr of the eventual memory access to get
> > @@ -1154,7 +1153,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx=
,
> >        */
> >       desc->fulltlb[index] =3D *full;
> >       full =3D &desc->fulltlb[index];
> > -    full->xlat_section =3D iotlb - addr_page;
> > +    full->xlat =3D iotlb - addr_page;
> > +    full->section =3D section;
> >       full->phys_addr =3D paddr_page;
> >
> >       /* Now calculate the new entry */
> > @@ -1270,14 +1270,14 @@ static inline void cpu_unaligned_access(CPUStat=
e *cpu, vaddr addr,
> >   }
> >
> >   static MemoryRegionSection *
> > -io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
> > +io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
> >              MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
>
> Can you move the io_prepare() argument change in a preliminary patch
> to make this one simpler to review?

I will fix it in the v2 patch.

>
> >   {
> >       MemoryRegionSection *section;
> >       hwaddr mr_offset;
> >
> > -    section =3D iotlb_to_section(cpu, xlat, attrs);
> > -    mr_offset =3D (xlat & TARGET_PAGE_MASK) + addr;
> > +    section =3D full->section;
> > +    mr_offset =3D full->xlat + addr;
> >       cpu->mem_io_pc =3D retaddr;
> >       if (!cpu->neg.can_do_io) {
> >           cpu_io_recompile(cpu, retaddr);
> > @@ -1336,7 +1336,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t =
mmu_idx, size_t index,
> >   static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned s=
ize,
> >                              CPUTLBEntryFull *full, uintptr_t retaddr)
> >   {
> > -    ram_addr_t ram_addr =3D mem_vaddr + full->xlat_section;
> > +    ram_addr_t ram_addr =3D mem_vaddr + full->xlat;
> >
> >       trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
> >
> > @@ -1593,9 +1593,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr,=
 int mmu_idx,
> >
> >       /* We must have an iotlb entry for MMIO */
> >       if (tlb_addr & TLB_MMIO) {
> > -        MemoryRegionSection *section =3D
> > -            iotlb_to_section(cpu, full->xlat_section & ~TARGET_PAGE_MA=
SK,
> > -                             full->attrs);
> > +        MemoryRegionSection *section =3D full->section;
> >           data->is_io =3D true;
> >           data->mr =3D section->mr;
> >       } else {
> > @@ -1981,7 +1979,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPU=
TLBEntryFull *full,
> >       tcg_debug_assert(size > 0 && size <=3D 8);
> >
> >       attrs =3D full->attrs;
> > -    section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs,=
 addr, ra);
> > +    section =3D io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
> >       mr =3D section->mr;
> >
> >       BQL_LOCK_GUARD();
> > @@ -2002,7 +2000,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPU=
TLBEntryFull *full,
> >       tcg_debug_assert(size > 8 && size <=3D 16);
> >
> >       attrs =3D full->attrs;
> > -    section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs,=
 addr, ra);
> > +    section =3D io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
> >       mr =3D section->mr;
> >
> >       BQL_LOCK_GUARD();
> > @@ -2499,7 +2497,7 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPU=
TLBEntryFull *full,
> >       tcg_debug_assert(size > 0 && size <=3D 8);
> >
> >       attrs =3D full->attrs;
> > -    section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs,=
 addr, ra);
> > +    section =3D io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
> >       mr =3D section->mr;
> >
> >       BQL_LOCK_GUARD();
> > @@ -2519,7 +2517,7 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, C=
PUTLBEntryFull *full,
> >       tcg_debug_assert(size > 8 && size <=3D 16);
> >
> >       attrs =3D full->attrs;
> > -    section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs,=
 addr, ra);
> > +    section =3D io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
> >       mr =3D section->mr;
> >
> >       BQL_LOCK_GUARD();
> > diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
> > index 90cfd6c0ed1..547f8ea0ef0 100644
> > --- a/include/accel/tcg/iommu.h
> > +++ b/include/accel/tcg/iommu.h
> > @@ -14,18 +14,6 @@
> >   #include "exec/hwaddr.h"
> >   #include "exec/memattrs.h"
> >
> > -/**
> > - * iotlb_to_section:
> > - * @cpu: CPU performing the access
> > - * @index: TCG CPU IOTLB entry
> > - *
> > - * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
> > - * it refers to. @index will have been initially created and returned
> > - * by memory_region_section_get_iotlb().
> > - */
> > -MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> > -                                      hwaddr index, MemTxAttrs attrs);
> > -
> >   MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
> >                                                          int asidx,
> >                                                          hwaddr addr,
> > @@ -34,8 +22,5 @@ MemoryRegionSection *address_space_translate_for_iotl=
b(CPUState *cpu,
> >                                                          MemTxAttrs att=
rs,
> >                                                          int *prot);
> >
> > -hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> > -                                       MemoryRegionSection *section);
> > -
> >   #endif
> >
> > diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> > index 0d1d46429c9..e599a0f7627 100644
> > --- a/include/exec/cputlb.h
> > +++ b/include/exec/cputlb.h
> > @@ -44,7 +44,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_=
addr_t length);
> >    * @full: the details of the tlb entry
> >    *
> >    * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
> > - * @full must be filled, except for xlat_section, and constitute
> > + * @full must be filled, except for xlat, and constitute
> >    * the complete description of the translated page.
> >    *
> >    * This is generally called by the target tlb_fill function after
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 61da2ea4331..7de576ab602 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -219,15 +219,17 @@ typedef uint32_t MMUIdxMap;
> >    */
> >   struct CPUTLBEntryFull {
> >       /*
> > -     * @xlat_section contains:
> > -     *  - in the lower TARGET_PAGE_BITS, a physical section number
> > -     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
> > -     *    must be added to the virtual address to obtain:
> > +     * @xlat contains:
> > +     *  - a TARGET_PAGE_BITS aligned offset which must be added to
>
> Drop "contains":

I will fix it in the v2 patch.

>
>    * @xlat_offset: TARGET_PAGE_BITS aligned offset which must be added to
>
> > +     *    the virtual address to obtain:
> >        *     + the ram_addr_t of the target RAM (if the physical sectio=
n
> >        *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
> >        *     + the offset within the target MemoryRegion (otherwise)
> >        */
> > -    hwaddr xlat_section;
> > +    hwaddr xlat;
>
> I'd rename as 'xlat_offset' instead for clarity.

I will rename it in the v2 patch.

>
> > +
> > +    /* @section contains physical section. */
> > +    MemoryRegionSection *section;
>
> Good. Safe because 'the CPUIOTLBEntry layout is not as critical as that
> of the CPUTLBEntry.' (commit e469b22ffda).
>
> >
> >       /*
> >        * @phys_addr contains the physical address in the address space
> > diff --git a/system/physmem.c b/system/physmem.c
> > index b0311f45312..d17596a77fb 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -747,31 +747,6 @@ translate_fail:
> >       return &d->map.sections[PHYS_SECTION_UNASSIGNED];
> >   }
> >
> > -MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> > -                                      hwaddr index, MemTxAttrs attrs)
> > -{
> > -    int asidx =3D cpu_asidx_from_attrs(cpu, attrs);
> > -    CPUAddressSpace *cpuas =3D &cpu->cpu_ases[asidx];
> > -    AddressSpaceDispatch *d =3D address_space_to_dispatch(cpuas->as);
> > -    int section_index =3D index & ~TARGET_PAGE_MASK;
> > -    MemoryRegionSection *ret;
> > -
> > -    assert(section_index < d->map.sections_nb);
> > -    ret =3D d->map.sections + section_index;
> > -    assert(ret->mr);
> > -    assert(ret->mr->ops);
> > -
> > -    return ret;
> > -}
> > -
> > -/* Called from RCU critical section */
> > -hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> > -                                       MemoryRegionSection *section)
> > -{
> > -    AddressSpaceDispatch *d =3D flatview_to_dispatch(section->fv);
> > -    return section - d->map.sections;
> > -}
> > -
> >   #endif /* CONFIG_TCG */
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

