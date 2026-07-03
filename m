Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C6C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 00:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfRMn-0005ju-BN; Thu, 02 Jul 2026 20:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfRMl-0005jH-3W
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:02:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfRMh-0006p1-GC
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:02:46 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698bf7a1a2dso41604a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 17:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783036961; cv=none;
 d=google.com; s=arc-20260327;
 b=NZmnwMd10RS5zAbRp6Y2Iyhx1e+6OEmP7sre8h3sQQ7YVCzFuMgGrujgQRQksnp+We
 CsvmaORWgBR2HnriNWG5xEfzT/HZlvDO4EGIivzAO9AIC9eRCM2GcMcq+30G16NqPbK2
 BySn1wHhZJIj4MK8KTqrLEq4oGqC5SyH7ebIl/rEF2BRkrpxbK/mNXFXS7baXw7/7k/S
 zuk87mdtRyDggCLVOx/FKh/Nd5aQ5w+lIs2EwsFUsHXcQI2AcRSZ2JsFN3y+WicRDbt2
 kordTsWSBYBgKihQ1xLBrD1SzIvzcml/B2juMWvFyMEAUqVi0OC8HcEoscIVdrxhVqmP
 AF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MjmeaHwbZYAa9qqi5JxSsNx1mze/Q8vvJxTgabxAZSw=;
 fh=Vrzba2RuC5telR4P/yoFBIJkne3z9UWR41o/wRUuMvI=;
 b=ZOq25SHDW78x/uBIBWO3qYQdGKv06Z6qyafXnV62kdUZueuR6MgFFEt50P8wHnocZL
 5u1XeUarYbZr94v7mwla+iZNTX+8Zkygb/NHosGRhvEaXa9qCn5bHGqShd7N+lz+L2b7
 RCw0cq1kgzDGREvuk+h6EpzNkGQb1hRNqfkJPrjwTOUNY4LI3wHYpx/l0FBgM8dOjzLA
 mj6emifWgbyQ0mUzXlpdBouuZn8BlpJkQNZvTsyFlCVZsFe0ovygooC/JLp7mAmYtAeU
 /ofnJwiTfZ3Hua9bQXDlaEGz7xIzi5rX3vHeoBT7UNuMGt6U9FciEx6fcnayGeE3ltiu
 sZvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783036961; x=1783641761; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MjmeaHwbZYAa9qqi5JxSsNx1mze/Q8vvJxTgabxAZSw=;
 b=Cz1AMUaU9kPkPYcoPc2sAd3HlKc5mxXBPhlGBUkWTsoqFH6MKCE54g2cd4KZWs4g0j
 kApo1Y4jwk+IAXAiXm2FO28eWLiDiQKjN10NiP6/xSRXRZLlyGzOWTFD5popP6ARUug6
 goSoX6JQzIRQM/Bq75FoACzPuqK6vgpO6wfUQAS5sxNR9JKVhB5U5Po0iCYt+byyWSG6
 3ojzKATFBGJaNU4aZOQDzfllW++3ZlZS+4nfn77NAjHRL+lMTNmNcrPNAoIp2DKGG9ZW
 F8Ag/z8PDlZ95qu5RyDrEMa6wV3N7ATtU25QRqjwIVTes4t3Ub8zz5CfnvfOadjstqoT
 MrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783036961; x=1783641761;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MjmeaHwbZYAa9qqi5JxSsNx1mze/Q8vvJxTgabxAZSw=;
 b=D2q8MAB1UHrgyaiP+Dd5VkwB8QLoy5LKQz/W4jUj89iAn9cie1ZVwHE0JIF3rEkLlW
 36VhqsaAxxBU5OHu3HrLkpiX2L0I2KIZqr6ci4qkaAt4DUzIr2DrQvnBnkX9ENMzw9QH
 H7Pnv3hYTbs1XV+uLbFTjz4qOOb+iMUr+YOemgvAX2WtXxHlJDht69RRtl/sb21BxTPD
 XQmxfpPurXOkq7FRrGDsGX9pBWyvIXmeUxkxn9mwEodsrm6eM/6qx+FbrDTLoM393NWE
 NabupHzNXaGizKuoz2hHaDMJ9fEhdMdT1lY+vYqNxQga7b38pE9QAT2l1D8D7S+V7MTr
 SmqA==
X-Gm-Message-State: AOJu0Yx56aCyqWBnPDx73CEFi9COODtEljiWk1fWSWL/uxZl9F0bnhSp
 tYeOXoFX+UqNScs0YbUGss/2WRjaFq8IzHP8DzHVjFswOrzf8DfldBLUa69eTPncxvnbJaK3R98
 AG03CvcHqicFZ54HkKzobh0MHlP/pxEc=
X-Gm-Gg: AfdE7clFIgTKrPwPebahgE6g5pZC88QxxHQsUn1cN3w34vAd3l4TgcyW/aK9Xzttwgi
 UMRwHJdVpl5dzmO2B93Cd8Mu4Z+RZ1n1p0l5F5xWIF2kYvybVFF55n61lM7+hrO5TsB0SFvyxXg
 BX2ZI/0isQIdAPOTsJRbDkVmDv5nf4cCVeH+QsvVJMkXjBStqnQ9JTJq18wHDRmPwAt8MVEyqdg
 tvSXadSYclhcXEKWhVDVgrTMtwNVs1nA1SvHkdbDdKXoqAKj2qYmND2dLuF2A72HPkxp240tzJT
 UL3YtbIc2lqSAZLQPvwZ+1yxt5g=
X-Received: by 2002:a05:6402:5242:b0:698:52b4:c2c8 with SMTP id
 4fb4d7f45d1cf-6989f374a6dmr4180442a12.34.1783036961172; Thu, 02 Jul 2026
 17:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
 <edd19559-f4ba-46eb-b979-700f5491981f@tls.msk.ru>
In-Reply-To: <edd19559-f4ba-46eb-b979-700f5491981f@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Jul 2026 10:02:14 +1000
X-Gm-Features: AVVi8Ccl7Us7ZrBcc5AQ_Xzjl1Lx212Al4T_tjbnuREk82RNVor6IGGEvCxAHgo
Message-ID: <CAKmqyKPL-zVhJ0nv2xhdRs+URJ83vQtyrS44ixt6dgqZoG8HbA@mail.gmail.com>
Subject: Re: [PULL 00/39] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 qemu-stable <qemu-stable@nongnu.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jul 2, 2026 at 8:54=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> On 01.07.2026 13:17, alistair23@gmail.com wrote:
> ...
> > RISC-V PR for 11.1
> >
> > * Fix IMSIC CSR write and add tests
> > * Parametrise debug trigger number
> > * Add 'svbare' satp-mode
> > * Fix RINTC PLIC context ID for KVM
> > * Avoid abort when reading vtype before env->xl is set
> > * Skip reset for KVM irqchip
> > * Skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
> > * More FDT cleanups (PLIC)
> > * Make FCTL.BE in IOMMU read only 0
> > * Check DC.TC reserved bits in IOMMU
> > * Apply UXL WARL handling to vsstatus
> > * Set cmd_ill IOFENCE.C if rsvp bits are set in IOMMU
> > * Set RISCV_IOMMU_FQ_HDR_PV appropriately
> > * Fix MSI MRIF IOMMU interrupt-pending offset
> > * Report QEMU CPU archid as 42
> > * Check PMP before updating PTE
> > * Add the Tenstorrent Atlantis machine
> >
> > ----------------------------------------------------------------
> > Alistair Francis (1):
> >        hw/riscv/atlantis: Ensure OpenSBI has a non-zero next_addr
> >
> > Charlie Jenkins (1):
> >        target/riscv: Report QEMU CPU archid as 42
> >
> > Chris Rauer (1):
> >        hw/i2c: Add DesignWare I2C Controller
> >
> > Daniel Henrique Barboza (16):
> >        target/riscv/cpu: add CPU unrealize callback
> >        target/riscv: dynamic alloc of debug trigger arrays
> >        target/riscv: add 'num-triggers' debug property
> >        target/riscv/cpu.c: add 'svbare' satp-mode
> >        hw/riscv/sifive_u.c: remove unneeded qemu_fdt_get_phandle() call
> >        hw/riscv/sifive_u.c: use intc_phandle in plic creation
> >        hw/riscv/sifive_u: add #address-cells in PLIC FDT
> >        hw/riscv/virt.c: change 'plic' nodename to 'interrupt-controller=
'
> >        hw/riscv: add create_fdt_plic() helper
> >        hw/riscv/riscv-iommu: rename regs_rw to regs
> >        hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
> >        hw/riscv/riscv-iommu: check DC.TC reserved bits
> >        hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are set
> >        hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV appropriately
> >        hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending offset
> >        hw/riscv/riscv-iommu.c: always fault with SADE=3D0 and A=3D0
> >
> > Inochi Amaoto (1):
> >        target/riscv: Check PMP before updating PTE
> >
> > Joel Stanley (9):
> >        target/riscv: Avoid NULL deref in IMSIC CSR write
> >        tests/functional/riscv64: Use newer kernel for tuxrun boot
> >        tests/functional/riscv64: Add virt machine AIA boot test
> >        hw/riscv/virt: Move AIA initialisation to helper file
> >        hw/riscv/aia: Provide number of irq sources
> >        hw/riscv/aia: Configure stride for the M-mode IMSIC
> >        hw/riscv: Add Tenstorrent Atlantis machine
> >        hw/riscv/atlantis: Integrate i2c controllers
> >        hw/riscv/atlantis: Add some i2c peripherals
> >
> > Meng Zhuo (1):
> >        target/riscv/kvm: skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
> >
> > Nicholas Piggin (4):
> >        hw/riscv/boot: Describe discontiguous memory in boot_info
> >        hw/riscv/boot: Account for discontiguous memory when loading fir=
mware
> >        target/riscv: tt-ascalon: Enable Zkr extension
> >        tests/functional/riscv64: Add tt-atlantis tests
> >
> > Qingwei Hu (3):
> >        hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for KVM
> >        hw/intc: riscv_aplic: Skip reset for KVM irqchip
> >        hw/intc: riscv_imsic: Skip reset for KVM irqchip
> >
> > SeungJu Cheon (1):
> >        target/riscv: Apply UXL WARL handling to vsstatus
> >
> > ZhengXiang Qin (1):
> >        target/riscv: avoid abort when reading vtype before env->xl is s=
et
>
>
> Hi!
>
> Is there anything here worth picking up for the stable series
> (besides "target/riscv: Check PMP before updating PTE")?
>
> For example,
>
>   46d96da130 target/riscv: avoid abort when reading vtype before env->xl
> is set
>   5a3fd18f4f hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
>   13c2fc34f1 hw/riscv/riscv-iommu: check DC.TC reserved bits
>   6ed77682d5 hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are se=
t
>   887d2d75b1 hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV appropriat=
ely
>   3cee183ff9 hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending offse=
t
>   64ce9ac187 hw/riscv/riscv-iommu.c: always fault with SADE=3D0 and A=3D0
>
> resolves various bugs from the qemu issue/work-items tracker.

Everything with a Fixes tag should be backported to releases that have
the relevant commits

Alistair

>
> Thanks,
>
> /mjt

