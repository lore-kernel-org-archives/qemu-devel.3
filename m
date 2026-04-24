Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD3EFED3DA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIGH-0004T8-6l; Fri, 24 Apr 2026 11:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wGIFp-0004Fc-ST
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:15:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wGIFi-0006un-Pq
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:15:39 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-baebe98afa0so2296066b.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 08:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777043725; cv=none;
 d=google.com; s=arc-20240605;
 b=HiVHCqRj8utFYVgkixubt2k7NQH4qeFwVsC5Sn+dunZ75zLMt+jFx/Mej0QEkLkasH
 Ihcu3pIi0CPWP3YdFNoieImRBU/y3ijPI+D+iNcN3Zz+pvnUpOjrsjP6X8m2kF80xoPq
 7lsc/m1fKKHFTqqMW+pDydEtVP9JIAv0iuf6XJ6PcZ6tv4SDRIq35iKjEICXwBa27f1a
 3QSTJ3foKZSNuLlyZUx337DYAX5+Az/h2us07HK4G4WnLJsK446bJAQH3D2ThzjYswOs
 NsW7olJHkM5Ox/iE39O7QJGW4p4cJ+gmFbxDqudfblFaOTUvvK53G6UXPID3XoksiREv
 j8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NyUZUkwTVq0VIItrg3HjuCmqVkzgE5vmZe7k3sn/x38=;
 fh=NX/RkK8NlS2Ov+x46b1s22NYb6qLuiuqJyZLvKgl/YM=;
 b=eCxTH0JPlk6MlkL5egX9JunF5VXLzSAzfqeFYbBwpFfXLne9ncHmuiGIk2yeVRaOYL
 Mmg5o9oaCbkt1EtkFcWTjsxRsGmgEzkRuXAWUwoOPelBdcSA8riVDzEmVVjqXknv6dDZ
 5YAr5W0BzkPm8eTn60a+ofHTgaJgMT/zlZ5BJYYJmCqdfdLoy5HWqxneoyDA+zdj0wKf
 twUynU/MQzSOGAfCKLWrMjjUOkBBDyeSLk7gx5knueABFQ9kSCsbb95TmRsSCngWlx9v
 YIE4mx2dPaeHCU9OZnRNGm1jJUIPJKc0sf7HuOY/g5+46y9t3x/ObyNhbjALM7mQlnaB
 22nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777043725; x=1777648525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyUZUkwTVq0VIItrg3HjuCmqVkzgE5vmZe7k3sn/x38=;
 b=aAtX2GM/4JqDXwnP7/rAZ+r3vLOoifTfda8oG+wm20XM/gMfuoEDCqfLeyQ+G7RiZM
 cd6Oo1TeS4o+KG4XmIp1g4ty7mCzC8Z7X5Z5RfPPblgwFT/xQQP7SEJQmJqaPFoWguFt
 g+PnC79NIb0OceHIbqk/if0wIy9O8y1F+Io9iZt2nvK+M7hgKT1h55R/vXF9GL4k8M0g
 nLua/fdBKSGiQ1eiMycgOvwUf6YyOeStRpx6Qex+eRWhA8d6I6hMT+AKUB06cglc8mlH
 kO8CF0iDhlhwgR6qtAagimIx6m4nzcDmqJch+LYGcOAOepcXkbmCDjojGm0zX6clfPvb
 J8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043725; x=1777648525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NyUZUkwTVq0VIItrg3HjuCmqVkzgE5vmZe7k3sn/x38=;
 b=roSUr0M4A02BeO9E+fPswh1Cz4T/R/c4IIshzGFauAcnNfqiTAhjivHX+dO2Hia3Za
 btHTGTZq1nxL5Iz4HYms/bWiO2qPC5UoSKXLS6YQ7BBlxGw7MZJqTC646MenOpa8ItNo
 pegcdRmoYD7lrVQ8+FylnSghcN+11Ekv9uQC5575IMnm7WEl4V0WqG/63LVs20gxHOE+
 xKyMp9jAWZVD3f1IWcGlNtUKeI0ANK18vR8QB6w/iLR7Nz2Hf/u2qNdPb82+2XWHtABM
 hnjrbwb2WadNpGdZvukdLQIMmddoFRDqQpMdtjFUI5slJACXyFPsrWj5Lk8My5OsfrWF
 YJpw==
X-Gm-Message-State: AOJu0YyuAbuCSzazhA1FYFJw+3COwFmSUCl6IXH/Av+i+q7xc76oSuai
 q+BWwkIL6x6+Z/yTjbZIexDmzw0Ab+PMuXuFQ954Hw0CMcIHtny9FthL7RiuHVr3AoEQs7mAqEp
 QIPPrYLkunzCGDFn0H9Vjqk0ZVvJgfP3lo0WDhKvy6A==
X-Gm-Gg: AeBDiesB4FRKG5FHajBEogvIO627bLQA+KbnOjTtIT1/Rf/5vcMZC/bu69YkXusg8Cu
 0qnBv+T50Yzf/ASoXfnSKtqRW1efxKuWAqZo07lQH1F2on+JbYIBLzkJl8YS/F+H+ITCy12YJAQ
 aHJjlikjp6cmxRuSPtLzfkMdDZ6J5GsshGBlf2cR975bA6p9s4p5iU+ERuxowDEnvPlBWmgYYDU
 fhxgBrn5y4h9062XOLlVx/WSdzYcawmQeNf/59g0cdQovD3SX/pLDNX61YZVcDS6TdbwKXOaLwd
 kNrk9FiLANATyIRrW1QZ
X-Received: by 2002:a17:906:99c2:b0:ba2:63fc:f3d5 with SMTP id
 a640c23a62f3a-ba4156ccdf1mr1502233566b.0.1777043724752; Fri, 24 Apr 2026
 08:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260421162912.3295598-1-jim.shu@sifive.com>
 <a422dbe1-7955-4fb1-b88a-0d091c525019@oss.qualcomm.com>
 <CALw707ow5D9nSmNARckozOmKOTBpOATFFNPMski9Y-yjD6RiWg@mail.gmail.com>
 <bc5d23b6-1d2e-4509-a148-be39114213b7@oss.qualcomm.com>
In-Reply-To: <bc5d23b6-1d2e-4509-a148-be39114213b7@oss.qualcomm.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Fri, 24 Apr 2026 23:15:13 +0800
X-Gm-Features: AQROBzA9C9OnsIzgaq30Q84tOcASDfyi5WNsUNz3Qc13E2nNZc3yH9Zilj1VIFE
Message-ID: <CALw707qmq813FDueR2e-Sh_MiD8gtoHFxR9nn9N-Mt5rKFXamw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Defer the IOMMU translation and support access_type
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>, 
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 24, 2026 at 2:25=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 4/22/2026 11:16 PM, Jim Shu wrote:
> > On Thu, Apr 23, 2026 at 12:01=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >
> > Hi Pierrick,
> >
> > Thanks for discussing the design!
> >
> >>
> >> Hi Jim,
> >>
> >> On 4/21/2026 9:29 AM, Jim Shu wrote:
> >>> Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRegi=
on"
> >>>
> >>> Incoming security protection devices feature more complex IOMMUMemory=
Region
> >>> implementation in the CPU path than ARM MPC device. For example,
> >>> RISC-V wgChecker [1] may permit the access with only RO/WO permission=
s.
> >>> Consequently, the IOMMUMemoryRegion could return different sections f=
or
> >>> read & write access.
> >>>
> >>
> >> The consequence is not directly implied for me.
> >>
> >> Why having a single translation and page protection handle read/write
> >> access is not enough here?
> >>
> >> What is the (real world) use case to return different physical memory
> >> locations depending on read/write access for a given virtual address?
> >
> > When permission is granted, the wgChecker device returns the original
> > region of the address, called the downstream region
> > When permission is denied, the wgChecker device returns a special
> > MemoryRegion for error handling, called the blocked_io region).
> > This region may trigger an IRQ and a bus error. Additionally, memory
> > accesses to this region will result in 'read 0, write ignored' rather
> > than triggering exceptions from the MMU or MPU.
> >
> > Consequently, implementing RWX permission checks on security
> > protection devices may return different regions (either downstream or
> > blocked_io) depending on the access type.
> > This design is similar to the existing ARM MPC device
> > (hw/misc/tz-mpc.c). The primary difference is that the MPC only checks
> > the physical address rather than RWX permissions, meaning it returns
> > either the downstream or blocked_io region for a single address
> > regardless of the access type.
> >
>
> It is indeed, a big difference. Translation with MPC device still
> results in a single address space being chosen.
>
> > I also considered an alternative design where CPUTLBEntryFull stores
> > both the successful permission and the blocked_io region of the IOMMU
> > region.
> > In this scenario, the slow-path code utilizing CPUTLBEntryFull would
> > check permissions and return the blocked_io region if access is denied
> >
> > However, the address_space_translate_iommu() implementation supports
> > recursive IOMMU region translation.
> > if multiple IOMMU regions are encountered during a single address
> > translation, storing only the first region's permissions is
> > insufficient.
> > Ultimately, we still face a situation where RWX permissions might
> > return different regions separately (e.g., downstream,
> > blocked_io_iommu1, and blocked_io_iommu2).
> >
>
> The "blocked_io_iommu_X" is a consequence of the current choice of
> implementation, but I still don't see why it's an absolute necessity.
>

I am open to removing it if the community agrees. I believe platforms
with the ARM MPC do not use multiple IOMMU regions when translating a
single address.

> An alternative would be to treat all accesses as MMIO, but I guess your
> goal here is to optimize the code path where we access RAM?
>

If the downstream region is a memory region, it will update the TLB
flags and vaddr in addr_idx for the successful permissions of IOMMU
region.
To explain further: In the alternative approach, we would obtain the
downstream region, IOMMU permissions, and the blocked_io region from
the IOMMU translation function (which would require an additional
return value or API to get the blocked_io region). The TLB entry will
handle the downstream region as a non-IOMMU region but will only
update the TLB flags for the IOMMU permissions; it will also store the
permissions and the blocked_io region. The slow-path code checks the
IOMMU permissions. If permission is denied, it will perform the
transaction on the blocked_io region instead.
We can remove the lazy IOMMU translation if using an alternative approach.

> Why can't you reuse existing page protection mechanism for this,
> authorizing read or write? WorldChecker just seems to be an additional
> check on top of existing translation. The fact it's an "additional"
> device is a design/implementation details, and could simply be part of
> page protection mechanism. It might require some additional plumbing
> when an interrupt is raised though, to redirect this correctly instead
> of signaling CPU like it would normally do.
>
> The fact is does different action based on read/write attribute does not
> really fit very well with existing implementation, as you noticed. And I
> wonder if it's worth changing the global design just to optimize this
> (optional) use case for RISC-V.
>

In the SoC architecture, the wgCheckers are positioned in front of
devices (either memory or MMIO). When the CPU or DMA sends
transactions to the device, the device's wgChecker first performs a
permission check to determine if the transaction should be forwarded.
If we move this check to the architecture's tlb_fill() function, how
would the CPU code determine if transactions were sent to the device
(or to the upstream region of the wgChecker)? The CPU code would need
to be aware of the memory tree hierarchy to do that, which I believe
is more difficult to implement.

In the current QEMU architecture, when a security protection device
sits in front of a device, placing it within the memory tree seems to
be the most suitable approach, similar to the ARM MPC device. The
address_space*() API can check if a transaction will be forwarded to
the device and perform the permission check via the IOMMU region. Both
the CPU-side address_space_translate_for_iotlb() and the DMA-side
address_space_translate_iommu() handle this. The only missing
component is that the CPU TLB cannot handle RWX permission checks for
IOMMU regions within the memory tree.




> >>
> >> I'm not against the goal of this series, but trying to understand why =
it
> >> went in this direction, which complexify this already complex code pat=
h.
> >>
> >>> To support such IOMMUMemoryRegion behavior in the CPU path, the desig=
n
> >>> of IOMMU translation must be updated:
> >>>
> >>> 1. address_space_translate*() must now pass the access_type to
> >>>      IOMMUMemoryRegion.
> >>> 2. Since IOMMU translation results are too complex to be fully stored
> >>>      in the CPU TLB. we will defer the translation until the actual a=
ccess
> >>>      occurs. Also, TLB is allowed to store the untranslated IOMMU reg=
ion.
> >>>
> >>> To implement deferred IOMMU translation, this patchset introduces the
> >>> following changes:
> >>>
> >>> 1. tlb_set_page_full() no longer translates the IOMMU region
> >>>      immediately. Instead, it stores the untranslated region directly=
 in
> >>>      the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
> >>>      access into the slow path when a region has not yet been transla=
ted
> >>>      in the TLB entry.
> >>>
> >>> 2. When the CPU utilizes a TLB entry in the slow path, it should perf=
orm
> >>>      the lazy IOMMU translation of the access_type first. The resulti=
ng
> >>>      translated region and access type are stored in CPUTLBEntryFull.
> >>>      Since the slow path always performs lazy translation first, we c=
an
> >>>      switch the CPUTLBEntryFull content to the correct access type be=
fore
> >>>      use.
> >>>
> >>> 3. To accelerate memory access in the fast path, lazy translation can
> >>>      update the addend of the CPUTLBEntry when translating the region=
 to a
> >>>      host memory region. We restrict the IOMMU region to have a singl=
e
> >>>      non-zero 'addend' across all permissions. If a second 'addend' i=
s
> >>>      present for a CPUTLBEntry, QEMU will trigger an assertion. This
> >>>      limitation is sufficient for security devices, as their "seconda=
ry"
> >>>      region is typically an IO region used to emulate device error
> >>>      handling when access is rejected.
> >>>
> >>> 4. To support non-slow TLB flags, lazy translation can update the TLB
> >>>      flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation onl=
y
> >>>      updates the flags for the permissions specified in @prot. This
> >>>      ensures that each access_type of a translated region to maintain=
s
> >>>      independent TLB flags. For example, TLB_DIRTY of memory region w=
ill
> >>>      not be "polluted" from other permission that translated to diffe=
rent
> >>>      region.
> >>>
> >>> Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
> >>> feature.
> >>>
> >>> [1] RISC-V WG:
> >>> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> >>> [2] RISC-V IOPMP:
> >>> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.c=
om/
> >>>
> >>> Changed since v1:
> >>> - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
> >>>     translation until actual access in the CPU path. Provide a IOMMU
> >>>     lazy translation function with the special handling of 'addend'
> >>>     and 'addr_idx' fields of CPUTLBEntry.
> >>> - Fix the checkpatch warning.
> >>>
> >>>
> >>> Jim Shu (5):
> >>>     accel/tcg: Pass access_type as an argument of tlb_set_page*()
> >>>     accel/tcg: address_space_translate*() will pass the correct
> >>>       iommu_flags
> >>>     accel/tcg: Provide early AS translate function
> >>>     accel/tcg: Add IOMMU lazy translation function
> >>>     accel/tcg: Support IOMMU lazy translation in CPU TLB
> >>>
> >>>    accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++=
++--
> >>>    include/accel/tcg/iommu.h            |  17 +-
> >>>    include/exec/cputlb.h                |  11 +-
> >>>    include/exec/tlb-flags.h             |   4 +-
> >>>    include/hw/core/cpu.h                |  15 ++
> >>>    system/physmem.c                     |  60 ++++++-
> >>>    target/alpha/helper.c                |   2 +-
> >>>    target/avr/helper.c                  |   3 +-
> >>>    target/hppa/mem_helper.c             |   1 -
> >>>    target/i386/tcg/system/excp_helper.c |   3 +-
> >>>    target/loongarch/tcg/tlb_helper.c    |   2 +-
> >>>    target/m68k/helper.c                 |  10 +-
> >>>    target/microblaze/helper.c           |   8 +-
> >>>    target/mips/tcg/system/tlb_helper.c  |   4 +-
> >>>    target/or1k/mmu.c                    |   2 +-
> >>>    target/ppc/mmu_helper.c              |   2 +-
> >>>    target/riscv/cpu_helper.c            |   2 +-
> >>>    target/rx/cpu.c                      |   3 +-
> >>>    target/s390x/tcg/excp_helper.c       |   2 +-
> >>>    target/sh4/helper.c                  |   3 +-
> >>>    target/sparc/mmu_helper.c            |   6 +-
> >>>    target/tricore/helper.c              |   2 +-
> >>>    target/xtensa/helper.c               |   3 +-
> >>>    23 files changed, 354 insertions(+), 58 deletions(-)
> >>>
> >>
> >
> > Regards,
> > Jim
>

