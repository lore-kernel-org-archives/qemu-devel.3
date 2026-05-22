Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576BFCD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 06:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQJaZ-0000nx-No; Fri, 22 May 2026 02:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wQJaX-0000nP-PT
 for qemu-devel@nongnu.org; Fri, 22 May 2026 02:42:29 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wQJaV-0003zt-N3
 for qemu-devel@nongnu.org; Fri, 22 May 2026 02:42:29 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40974bf7781so6038048fac.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 23:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779432146; cv=none;
 d=google.com; s=arc-20240605;
 b=LB1iPrOfebVF/krMJbonX8CkbBRJ59F82JLChTJuO1tZMEF9EviXld4wyB9nUQPUs4
 AYEF+2Q2fmZUInlBmHt3L66dPTLIK0nPuePyyCX8+ALKqnh+Nkmp7rECCsoZUBZwgezp
 53slOJffVkQY7kOqOiqxtiZL4OMQa0tNS3aM6Mzr83thun6AMgC5FktS7NvEmvyA/fja
 Jzgt0vQlMXZgjTY4+ZjWPGU+YX/LWYrH9OvcvGfyMyJeI3MTqERJcoElUVkjbdbgsd+A
 a1TsfXGVBZ6lZMEl5VupXDxPfia2m5hPrF7l2o/tqQ/xA/mh5HhHRPCxUPWj32IuVdqM
 Ngxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=818F5/Vt0Xz7X6AchcboDO5bpre8FVPQQb38F6y3F1E=;
 fh=hpn9J5oRNSfv620Jv8P/hXvwzNbHNg32H9uRKAqF1vg=;
 b=VzhgRFhPddlg1VtbIk3GrccbCkJ26verCFkdwg2w8bALc696hjNI85rfrdFHy90w7p
 4K7bCgH1FEFgRKrJXLLi8rsZBNMi1MrNelzXy783r6LnRXi0OE52g/eL2tmXcyP6tNGK
 yEpd7sK1gRr8/phiL0Uqu76yBQbookuGolp4DKXwcL2YYSIfTZUJ50zBTIrhVpjXUIuc
 aDGY077/nXAGE4dLifU1FFC/AYJEE7gdYz8d/lQatFhCduHYVdmSPchZaHVDVLwQ4af+
 aderguTHzjn4S7AvUhgbzxQaKFUSquaQBfGK4i/WCkNpSMRt1A0YDUNO8PSvBZaiF6ny
 HSEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779432146; x=1780036946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=818F5/Vt0Xz7X6AchcboDO5bpre8FVPQQb38F6y3F1E=;
 b=ju1BLWRUi5DkvHYsl2da4FULwxbDHb/ipIMvh+EuawlZBpGLEl1OGuo7qhB6wi8FzK
 B6Tqcj2T4ToGtafF4NUhgH0KMUtkbXMDrd9EjHwgVXZ9PPGflY87XGg0rpv9aZ4+5fU5
 yJlPFQtL9lVASrvLDg76CSLZfboMNwnbBA1/SBr0oxNFt9Je4rF47Vl7vsrOoJ1S7KF4
 kYfssfY7DkTptqUyNHZIbZsd2cx/VaUICkSsi4hmDwtxgSzrVTId70j4Mn969D5InWtH
 aRjebZEgL7a+6D8JpEEemEpp4X953JOfKCR1r78zpA73F2O6A765VM7rWmEZsriRJsiF
 mRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779432146; x=1780036946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=818F5/Vt0Xz7X6AchcboDO5bpre8FVPQQb38F6y3F1E=;
 b=QFCdiaiPRWKl1T0xwlI1eX2FVud7bHxd432Pis8IrHIbVZcqajePmtqha8WSrMKLNT
 knV9pL9oWWlqIoVH4itbdG0JNpi2SXuGkkJeA03xK73e3xp5PKgukWn6twqCFqQRmBdb
 y+CcXXR+k3d3kdEzBXLiNcZrI652FrI6mZlpFL0mc5jr0wfVUidm0WbdULCR7OBlM4sh
 3YJLkXt5PVeJpASk71HJndQRKc9nWBmri2yrSHvag+wBSb2CabOQDwPyUbUyyaDCW3R4
 5vR1rla7VEbbCpnHb3y2Wi0lu1ysg8hQ7fpac363x4o1+U/rkjXP8aJ3+PR4GEo84Gsk
 h9Dw==
X-Gm-Message-State: AOJu0Yy19YTRV/OQtY5tLXdeb5Alz0vR66D27vKg3gpKrSWY7x7MJ0aJ
 FWEvtIctenhjAZe05gQqzmAMC7IRUGtajghZ4KC3i1XeGliykndzBUDbyAsSm1/YmJWySGsCJwN
 0098YpaIca/8RcoCSyr6tZYWduyllpKEFiBvr3KgCoj6fYDEHgcPq4Bo=
X-Gm-Gg: Acq92OHwfNB98QulSFfiX5jCAoXT1q9PNlsSRweJIHH5gPbT3B2wSBAHO9uM0Cs/aVU
 LJ896TkyEmDN3pOfT8NzSVZAkCQqcc01r6ZmnuU7HuLhfn7FUjRZ7NO9wEGHFXoqgd9CSiUpVUN
 3/5XZklvkMHXNZQPxA4iaoHFqSSO451ma02aJnUW9dOEn6AJb5q0Iclf9uHC3ti6ugCs8uRLPJK
 ChZ4ZeEQXrmepNsRfPI5NPCnQGymHZGhUoI4QeKD3xBvuwF2VQ4+Z8xxXkqQtrFu15dmQZ0cTCO
 1DZi8+nTJIxC4LBEVAiB
X-Received: by 2002:a05:6820:5059:b0:69b:85ba:bd4f with SMTP id
 006d021491bc7-69d6e38310fmr2653920eaf.33.1779432145570; Thu, 21 May 2026
 23:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260506033642.3641390-1-jim.shu@sifive.com>
In-Reply-To: <20260506033642.3641390-1-jim.shu@sifive.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Fri, 22 May 2026 14:42:15 +0800
X-Gm-Features: AVHnY4Ll2ThIYCuhzTb8M-PKWH5TSEDhdcxfOufIFhT6ZPj7uby3T6e_DKe90Nc
Message-ID: <CALw707pmiF3KDF=4wRUhdEGU7-SgFkmc3D1_RkEf6E77ZP0TNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Defer the IOMMU translation in the CPU path and
 support access_type
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>, 
 Michael Rolnik <mrolnik@gmail.com>, Song Gao <gaosong@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>,
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
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=jim.shu@sifive.com; helo=mail-oa1-x2b.google.com
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

Hi all,

Gentle ping on this patch.
Any suggestion is welcome.

Thanks,
Jim Shu





On Wed, May 6, 2026 at 11:36=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> Incoming security protection devices feature more complex IOMMUMemoryRegi=
on
> implementation in the CPU path than ARM MPC device. For example,
> RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
> Consequently, the IOMMUMemoryRegion could return different sections for
> read & write access.
>
> To support such IOMMUMemoryRegion behavior in the CPU path, the design
> of IOMMU translation must be updated:
>
> 1. address_space_translate*() must now pass the access_type to
>    IOMMUMemoryRegion.
> 2. Since IOMMU translation results are too complex to be fully stored
>    in the CPU TLB. we will defer the translation until the actual access
>    occurs. Also, TLB is allowed to store the untranslated IOMMU region.
>
> To implement deferred IOMMU translation, this patchset introduces the
> following changes:
>
> 1. tlb_set_page_full() no longer translates the IOMMU region
>    immediately. Instead, it stores the untranslated region directly in
>    the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
>    access into the slow path when a region has not yet been translated
>    in the TLB entry.
>
> 2. When the CPU utilizes a TLB entry in the slow path, it should perform
>    the lazy IOMMU translation of the access_type first. The resulting
>    translated region and access type are stored in CPUTLBEntryFull.
>    Since the slow path always performs lazy translation first, we can
>    switch the CPUTLBEntryFull content to the correct access type before
>    use.
>
> 3. To accelerate memory access in the fast path, lazy translation can
>    update the addend of the CPUTLBEntry when translating the region to a
>    host memory region. We restrict the IOMMU region to have a single
>    non-zero 'addend' across all permissions. If a second 'addend' is
>    present for a CPUTLBEntry, QEMU will trigger an assertion. This
>    limitation is sufficient for security devices, as their "secondary"
>    region is typically an IO region used to emulate device error
>    handling when access is rejected.
>
> 4. To support non-slow TLB flags, lazy translation can update the TLB
>    flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
>    updates the flags for the permissions specified in @prot. This
>    ensures that each access_type of a translated region to maintains
>    independent TLB flags. For example, TLB_DIRTY of memory region will
>    not be "polluted" from other permission that translated to different
>    region.
>
> Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
> feature.
>
> [1] RISC-V WG:
> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> [2] RISC-V IOPMP:
> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/
>
> Changed since v2:
> - Fix unused initialized memory error
>
> Changed since v1:
> - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
>   translation until actual access in the CPU path. Provide a IOMMU
>   lazy translation function with the special handling of 'addend'
>   and 'addr_idx' fields of CPUTLBEntry.
> - Fix the checkpatch warning.
>
> Jim Shu (5):
>   accel/tcg: Pass access_type as an argument of tlb_set_page*()
>   accel/tcg: address_space_translate*() will pass the correct
>     iommu_flags
>   accel/tcg: Provide early AS translate function
>   accel/tcg: Add IOMMU lazy translation function
>   accel/tcg: Support IOMMU lazy translation in CPU TLB
>
>  accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++++--
>  include/accel/tcg/iommu.h            |  17 +-
>  include/exec/cputlb.h                |  11 +-
>  include/exec/tlb-flags.h             |   4 +-
>  include/hw/core/cpu.h                |  15 ++
>  system/physmem.c                     |  60 ++++++-
>  target/alpha/helper.c                |   2 +-
>  target/avr/helper.c                  |   3 +-
>  target/i386/tcg/system/excp_helper.c |   3 +-
>  target/loongarch/tcg/tlb_helper.c    |   2 +-
>  target/m68k/helper.c                 |  10 +-
>  target/microblaze/helper.c           |   8 +-
>  target/mips/tcg/system/tlb_helper.c  |   4 +-
>  target/or1k/mmu.c                    |   2 +-
>  target/ppc/mmu_helper.c              |   2 +-
>  target/riscv/cpu_helper.c            |   2 +-
>  target/rx/cpu.c                      |   3 +-
>  target/s390x/tcg/excp_helper.c       |   2 +-
>  target/sh4/helper.c                  |   3 +-
>  target/sparc/mmu_helper.c            |   6 +-
>  target/tricore/helper.c              |   2 +-
>  target/xtensa/helper.c               |   3 +-
>  22 files changed, 354 insertions(+), 57 deletions(-)
>
> --
> 2.43.0
>

