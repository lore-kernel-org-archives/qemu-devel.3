Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E114FAD3E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 06:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFnMa-0001PD-2j; Thu, 23 Apr 2026 02:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFnMK-0001J5-24
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 02:16:20 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFnMH-0007XM-R2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 02:16:19 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6715594a4c2so7376718a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 23:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776924972; cv=none;
 d=google.com; s=arc-20240605;
 b=XBT6i18P5s7i9SXzgW81779g5dIGs736efjuzqlzlHyEwFWlLUSvBf6raO1LOflLbo
 BZj2J7ZAspWcNQRQtcPvxU5A+Q2q1elFqsOzE9sqYkCiHvVkH/VQ7cBaSjYx4D1Vmfps
 hcHrCaio6Wrqq0bC4GmTqVKH5C/LQ4mWxOjY/96n7GNC1pwhkpxm3ITQ89oqfpx5Ntnu
 Iny+hNL8djKzmxtGCj3vqkkq83OvZo81L11T5fR48oZQxbDDzylp+8ANvYR0VQwRiXY9
 hl9b41i5GkLg9NqkZD0WzhiOxBxKLBMkcPG/3+yfw+IjmkE8g0+S3rCjGzu9OYdnMptq
 +WZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Yr0FKpvG1qp/N1v59n7D9PHPNc4wrXsQUtHCblRhBTk=;
 fh=NX/RkK8NlS2Ov+x46b1s22NYb6qLuiuqJyZLvKgl/YM=;
 b=iAP+itoai2hSXRZw2xRf1C0VdR8yTuPUFjiqjw12lIn+Nd8DeDqaXIKpry/IODgQL0
 TFMP+xP0MRSQBp0INQB++TUf30UlbpUxVF6qmmEnt6zkWuW+/Ej0KCBLO3jFL+bD96e4
 uYXIhixkrk7icIgKGSiVLit0CwnJCT/oXlfsrFYnbqX/S7ZGZI6/BPzVwUAqbmx2Q9yy
 2/Z20s6CAyVPUc7fvetoyu5hCap8M/bm9n0DuAA5+dg2o9NLp7MXGlI4lVxOuOJAei3O
 UKvICPHdPOHD33jfkmY3bT68n6URqPHah7QM3n+i+j2Dr2FCzLrdhxGVR3colpwHhlN/
 /bkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776924972; x=1777529772; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yr0FKpvG1qp/N1v59n7D9PHPNc4wrXsQUtHCblRhBTk=;
 b=glKr0IHRAVIPcQ+E4nbuEORL2m49u/z0iTXclsZwjVQy0N3R3LJSdXWFsn3ql38AC0
 w3w2bJaP+k8cqG2d+ZAtqvY+TNtCi+O2HZF10nVQUyQTKjInLSao5FnA7dUnTHu1l8Ok
 7d551NwSK5eeK0IyV15HHlQ5FcVy3//kF2eBfwh0Jq5SHVepSq+1UgKaznAibGfG6i5M
 wfA/IOPRyVKPpRaUnZL3GxkJ9j9Yv+1iQt7JVhpOWHmbUuRVvX8jWVS2gLk3WuHPMmUf
 PkP3g8P66m8PFr1XQbo67MuN3dFw8qUdtraXPSoXYzaez+PiXcTp6m0CMQE0fPK9Idmc
 FHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776924972; x=1777529772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yr0FKpvG1qp/N1v59n7D9PHPNc4wrXsQUtHCblRhBTk=;
 b=I7O5kiHIpdjx+oa4b7SXM9sJKrW8CNOLNZ0NZbMOrYWaK28nnfWZEUZzEhrjY+kL2B
 16xZjb/xRdWpJCa6WxuTVIOhFbehw2usK2PBeQkqIJKdHj/UAdnPUym2ykIQq4q2mbeK
 iew/L1vLZvfYqzPdXfK4RgI9paNu+96mVLi20CpsgwqMQrkBJ2ByWLUJsiSA3l4MLci2
 LPWFXdiA+stVb+fdYzxrunAHqJ+paAZvH5bvTtjkIqMcI2sCa0ixyr3V57OeGgoJ9AlX
 cnry77Yb6OPpvuIS4HHLD5H3AXC4IrJn/K/+UXqD6x/dVlgQBNII2UdMzfZjpCdLJamp
 fzDQ==
X-Gm-Message-State: AOJu0Yyz6Atod3Fo+vGql9nWTSYZJ3V8rFSV8FKBtb5PX5HY60ZmfBVF
 wJvB0THgoS1w9ee9SsvzwJHknJz9jJ+I+G61g8BLi8ama0mGRqHyJn3Bx/ZvLnqYN6wcni+Rxpm
 CPxH3dk1rSGIfTGA52UupVtBPgePRrcZDRD94TfAtkw==
X-Gm-Gg: AeBDieuwY1hdQFIXE6VXnXFCnaW0oyGrpbwHddD3QHYIuL9/RlN+rmKcWFbTXZcIENw
 +rru6rIXeME1d4TnlZQSoWB0HnEyN/goX/uZLFBbsE/M6SvAERZ5cdY6HoxLEKF/D7MhR0wkAif
 e6fo63jvd7xc8Y2OTDI2AljOUa+VkYnv8CpUBFgzZ8bSQwQdVXSNg6zD7GAY3JTxo6BzQ++Mfva
 38BFNh6vWtfKeVwCv5DhhRpjwBtP26H6nyDeXMVEPNP4JDRlIA476RYlg2pK2JMnUjiZBfQpMX4
 HKRnr6lbTsVBoZPzdpKKv7QddbfyRNs=
X-Received: by 2002:a05:6402:21c9:b0:672:522d:8f90 with SMTP id
 4fb4d7f45d1cf-672bfd736fbmr11437377a12.4.1776924972201; Wed, 22 Apr 2026
 23:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260421162912.3295598-1-jim.shu@sifive.com>
 <a422dbe1-7955-4fb1-b88a-0d091c525019@oss.qualcomm.com>
In-Reply-To: <a422dbe1-7955-4fb1-b88a-0d091c525019@oss.qualcomm.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Thu, 23 Apr 2026 14:16:00 +0800
X-Gm-Features: AQROBzDc5m2HmXUCiVWD89_s0CdLyUHYFXdKXK2bcfpDdG9lUuHw6ri44EtyW_c
Message-ID: <CALw707ow5D9nSmNARckozOmKOTBpOATFFNPMski9Y-yjD6RiWg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 23, 2026 at 12:01=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:

Hi Pierrick,

Thanks for discussing the design!

>
> Hi Jim,
>
> On 4/21/2026 9:29 AM, Jim Shu wrote:
> > Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRegion=
"
> >
> > Incoming security protection devices feature more complex IOMMUMemoryRe=
gion
> > implementation in the CPU path than ARM MPC device. For example,
> > RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
> > Consequently, the IOMMUMemoryRegion could return different sections for
> > read & write access.
> >
>
> The consequence is not directly implied for me.
>
> Why having a single translation and page protection handle read/write
> access is not enough here?
>
> What is the (real world) use case to return different physical memory
> locations depending on read/write access for a given virtual address?

When permission is granted, the wgChecker device returns the original
region of the address, called the downstream region
When permission is denied, the wgChecker device returns a special
MemoryRegion for error handling, called the blocked_io region).
This region may trigger an IRQ and a bus error. Additionally, memory
accesses to this region will result in 'read 0, write ignored' rather
than triggering exceptions from the MMU or MPU.

Consequently, implementing RWX permission checks on security
protection devices may return different regions (either downstream or
blocked_io) depending on the access type.
This design is similar to the existing ARM MPC device
(hw/misc/tz-mpc.c). The primary difference is that the MPC only checks
the physical address rather than RWX permissions, meaning it returns
either the downstream or blocked_io region for a single address
regardless of the access type.

I also considered an alternative design where CPUTLBEntryFull stores
both the successful permission and the blocked_io region of the IOMMU
region.
In this scenario, the slow-path code utilizing CPUTLBEntryFull would
check permissions and return the blocked_io region if access is denied

However, the address_space_translate_iommu() implementation supports
recursive IOMMU region translation.
if multiple IOMMU regions are encountered during a single address
translation, storing only the first region's permissions is
insufficient.
Ultimately, we still face a situation where RWX permissions might
return different regions separately (e.g., downstream,
blocked_io_iommu1, and blocked_io_iommu2).

>
> I'm not against the goal of this series, but trying to understand why it
> went in this direction, which complexify this already complex code path.
>
> > To support such IOMMUMemoryRegion behavior in the CPU path, the design
> > of IOMMU translation must be updated:
> >
> > 1. address_space_translate*() must now pass the access_type to
> >     IOMMUMemoryRegion.
> > 2. Since IOMMU translation results are too complex to be fully stored
> >     in the CPU TLB. we will defer the translation until the actual acce=
ss
> >     occurs. Also, TLB is allowed to store the untranslated IOMMU region=
.
> >
> > To implement deferred IOMMU translation, this patchset introduces the
> > following changes:
> >
> > 1. tlb_set_page_full() no longer translates the IOMMU region
> >     immediately. Instead, it stores the untranslated region directly in
> >     the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
> >     access into the slow path when a region has not yet been translated
> >     in the TLB entry.
> >
> > 2. When the CPU utilizes a TLB entry in the slow path, it should perfor=
m
> >     the lazy IOMMU translation of the access_type first. The resulting
> >     translated region and access type are stored in CPUTLBEntryFull.
> >     Since the slow path always performs lazy translation first, we can
> >     switch the CPUTLBEntryFull content to the correct access type befor=
e
> >     use.
> >
> > 3. To accelerate memory access in the fast path, lazy translation can
> >     update the addend of the CPUTLBEntry when translating the region to=
 a
> >     host memory region. We restrict the IOMMU region to have a single
> >     non-zero 'addend' across all permissions. If a second 'addend' is
> >     present for a CPUTLBEntry, QEMU will trigger an assertion. This
> >     limitation is sufficient for security devices, as their "secondary"
> >     region is typically an IO region used to emulate device error
> >     handling when access is rejected.
> >
> > 4. To support non-slow TLB flags, lazy translation can update the TLB
> >     flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
> >     updates the flags for the permissions specified in @prot. This
> >     ensures that each access_type of a translated region to maintains
> >     independent TLB flags. For example, TLB_DIRTY of memory region will
> >     not be "polluted" from other permission that translated to differen=
t
> >     region.
> >
> > Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
> > feature.
> >
> > [1] RISC-V WG:
> > https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> > [2] RISC-V IOPMP:
> > https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com=
/
> >
> > Changed since v1:
> > - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
> >    translation until actual access in the CPU path. Provide a IOMMU
> >    lazy translation function with the special handling of 'addend'
> >    and 'addr_idx' fields of CPUTLBEntry.
> > - Fix the checkpatch warning.
> >
> >
> > Jim Shu (5):
> >    accel/tcg: Pass access_type as an argument of tlb_set_page*()
> >    accel/tcg: address_space_translate*() will pass the correct
> >      iommu_flags
> >    accel/tcg: Provide early AS translate function
> >    accel/tcg: Add IOMMU lazy translation function
> >    accel/tcg: Support IOMMU lazy translation in CPU TLB
> >
> >   accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++++-=
-
> >   include/accel/tcg/iommu.h            |  17 +-
> >   include/exec/cputlb.h                |  11 +-
> >   include/exec/tlb-flags.h             |   4 +-
> >   include/hw/core/cpu.h                |  15 ++
> >   system/physmem.c                     |  60 ++++++-
> >   target/alpha/helper.c                |   2 +-
> >   target/avr/helper.c                  |   3 +-
> >   target/hppa/mem_helper.c             |   1 -
> >   target/i386/tcg/system/excp_helper.c |   3 +-
> >   target/loongarch/tcg/tlb_helper.c    |   2 +-
> >   target/m68k/helper.c                 |  10 +-
> >   target/microblaze/helper.c           |   8 +-
> >   target/mips/tcg/system/tlb_helper.c  |   4 +-
> >   target/or1k/mmu.c                    |   2 +-
> >   target/ppc/mmu_helper.c              |   2 +-
> >   target/riscv/cpu_helper.c            |   2 +-
> >   target/rx/cpu.c                      |   3 +-
> >   target/s390x/tcg/excp_helper.c       |   2 +-
> >   target/sh4/helper.c                  |   3 +-
> >   target/sparc/mmu_helper.c            |   6 +-
> >   target/tricore/helper.c              |   2 +-
> >   target/xtensa/helper.c               |   3 +-
> >   23 files changed, 354 insertions(+), 58 deletions(-)
> >
>

Regards,
Jim

