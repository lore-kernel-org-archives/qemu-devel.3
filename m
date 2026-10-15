Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F73CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHODi-0007KU-1D; Thu, 15 Oct 2026 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHODg-0007JO-WB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:22:17 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHODe-0000Jp-RS
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:22:16 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b0d5ddafbcso9598957b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 09:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792081333; cv=none;
 d=google.com; s=arc-20260327;
 b=FsD5NbLmTgYqtFJG9VOy4AmAFXghYCDa4iaMhWQaAB/Oz22ssCAr+cYE/jHLBG4U5S
 0PLRP6IduHhOP7yYfZbCkvHNbY7dijxDLZf7v2G4h1UzQxVar/2Y8LUE/H44uGnibOB1
 scOtfIe3bBFNAaAGfkAQwEyZ65ixn4O7pdKHHfrUFDwVDYviLm3GdX4r9u1CKAd50Zwv
 Wto1RbPKGO/XR1Zsk5MMFP8SqdOPk20ETv5gvIzBWmF/VopDy8dSMWLfoyPVlvLY3v0L
 LyWeuLLvmH0BVOH2LwmgZu+xVjOrKwk15A8GAqsPBuvpyUt5toHwglEammZONkiuCuMn
 ePJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RQCElvh08J2BIDGN/zLgW6mGnyFT83qmeWNSYL2QSEU=;
 fh=pOu3r4QsgrV9lWKFNP/Yf6CdOaqaL/gVYgrTO6OA6mQ=;
 b=Jcdz2AIqMd5d6qoXNb5B9dF6ZXPtmxsb9JdJLCiZgIcdkP+4KnTszlThA+kB6/7NVW
 wn3U0ZImIcoKAZaZp8cJ1XwDMcZS4vHr0WrKRVKODaUSG0bL3/1NSKwVr97wC2jawJFB
 RUq+lMqF7T69t81ZEXe++8P/B/ucRlAn3Yp6CpfCPnxrDFEMdJNB8WA9HRp9fzzLkHAS
 hBUwXjz8g+RuwYx9fYUUDTzx4qTN1RUhUIa484RCs4/1NQObL1LzAE1wQRvYDt3yKibm
 xdXnGuV/EcgfC7U6cEy78i/MUahwmT3FByubcEs0VL09dDZI0wbxrOvXjU2Ip+HV4iNX
 lLbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792081333; x=1792686133; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RQCElvh08J2BIDGN/zLgW6mGnyFT83qmeWNSYL2QSEU=;
 b=RH6qKI5OjxGUiT9zOcBBod1N689VU6pnwsd0UB0RIHVvz4hNVgV8RuHs+zhyTCVIJq
 N9I9fCsXUBK1EUSxoU6ALTGl596xQx64JWTMXM4+Gy+f3qYlPgltXy4ArEvw19z4XJ+s
 OnJ3t7XO6VbR6g7g8NNKUNReR5g4kbpJ7Qx7u4V2Su8eFN/PaxMzVgXkzh9D9mDjxRrB
 TlDxYRn7R5dQjP2zC6D4cn9BB01CItx+HXgz/3pfCaa2P+LtRD5RVgbjKKqt7/u6aCuP
 9YQcP7iNeYa2GbEK1t+j19VqmlQcgTKi3p1kVDde/iFs5p5UBnfueMYWmRrINQ2nCAjP
 TDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081333; x=1792686133;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RQCElvh08J2BIDGN/zLgW6mGnyFT83qmeWNSYL2QSEU=;
 b=wKQ5PPjo59ny/7wKsl42M57VbG3VH6g4xYzHCAx7dLvqZALctBaVv+O/qD8ZHCySEb
 R0Q6x1IjtNSqvAgADcYGywPPpWnu1v/7yFV57Cg5dLxoK+j8fE9z07AiT7yRoOEpUIqW
 3it1Pbu8Y1NFnRZtrPcQx+hDEWfCgi4PwXMdCfzKoC+Nfq6sJrbODnHOv2Odvoi4gfvT
 M5PDjBAp4TvowYvxMkvm2hmhd+x4GfN5n0DWhRnWfHiU0yeFxtLnOWn1HDWvi5DnFYH/
 gKtBdeV+s4B8Z5RO6e0Y5b44dhVeRmNjvvOmAV9mr5RUSRkhOB0SCQSQsbg0BxuIgmmF
 Opog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOTXfZYVJrX3Oker4cOFGeRG4rDiaSCdrUYzvj+6VL4P7zFitONKLsDozE836UeUvp0WL6GdSTui2N@nongnu.org
X-Gm-Message-State: AFq9FYIhtYR0Sc86mAS3OqaZdKr3BmkAFQ+U62VBKszgQpLEaVswR+BK
 YrU+krwm6f/7eKh+t66akr5D1v1aa8f3I2HNMuypWq7IlIG6UGZ100vQ0bnGxBW2WNTSfdDanV9
 jr7cRVNC81GAc/3ibQsqlhZUR5WLIRaeh9LUD16Cx4Q==
X-Gm-Gg: AYBFou3JCUQ7a5gNIxoe3dstAlEoDEXJKEnsKPpHjsqGsMUOQ0X9z51wPKmnNOAxwGx
 El8yZlM8f4XZPE+605LBVhKnh26AU55gui3d5FvcSkSGCdtO020ExnQAT/AQQSwLGXQ+PyjSnkz
 prdUwHni/hmefJx06dQlVXymlVeo2z1MY4L41FvlEeKP4pxd5DcXA0DQlUpmgXLy+kg0yCoSOp0
 CPuHWgIUrQt8OBwXrEZ1/wivCoiWXrc6DRW3qxa0tyrUjk8ZI0v9LBKybhlKf+qy096A3k5U7+A
 QvDhS+ha3vVpJ2kV7vReClke7U3sAHDQD2ES4EqbaNbcdZgq4wm9LP0lH7641/JAKDKbQ+rT1nG
 ieXL1auPwx4N8zAAWdrzvVNym4BtJGre4f4zzT1I=
X-Received: by 2002:a05:690c:387:b0:8b0:6866:c55f with SMTP id
 00721157ae682-8b07ee4d12emr67505727b3.46.1792081332932; Thu, 15 Oct 2026
 09:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-6-mark.caveayland@nutanix.com>
 <CAFEAcA9eucRyzG=PR2tpx8ObHkdK6xUmOjQ+-nNbJ2dVHaptOA@mail.gmail.com>
In-Reply-To: <CAFEAcA9eucRyzG=PR2tpx8ObHkdK6xUmOjQ+-nNbJ2dVHaptOA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 17:22:00 +0100
X-Gm-Features: AclHuK_JzHSeeixZQwFB55O2lE4YIMCEsFBYUzo_EwttzyD7LQh3FodmT7dI1cQ
Message-ID: <CAFEAcA-voNwJRTb2WQuxnvzk5LwBcXahz8HHrW=Yi3WUKeKgBg@mail.gmail.com>
Subject: Re: [PATCH 05/22] i8259.c: move parent_realize from PICClass to
 I8259CommonClass
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Tue, 13 Oct 2026 at 16:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
> >
> > Both the emulated and KVM i8259 implementations store a reference to the
> > parent_realize function in their respective classes. Start by moving
> > parent_realize from PICClass to I8259CommonClass and removing PICClass since
> > it is no longer required.
> >
> > Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>
> This is one of those things where I think we're not 100% consistent
> about whether we think the parent_realize field should go in the
> child class struct or the parent class struct. The name "parent_realize"
> implies it ought to be in the child struct, though, and I think we
> do that more often than we put it in the parent class.

We do, although it's a bit closer than I thought: about 50 callsites
put the parent_realize pointer in the child class struct; about 25
put it in the parent class struct. So I think for new code we should
prefer to follow the child-class-struct version.

in child's class:

hw/arm/smmu-common.c:    device_class_set_parent_realize(dc, smmu_base_realize,
hw/arm/smmuv3.c:    device_class_set_parent_realize(dc, smmu_realize,
hw/display/macfb.c:    device_class_set_parent_realize(dc, macfb_nubus_realize,
hw/i386/kvm/i8254.c:    device_class_set_parent_realize(dc, kvm_pit_realizefn,
hw/i386/kvm/i8259.c:    device_class_set_parent_realize(dc,
kvm_pic_realize, &kpc->parent_realize);
hw/input/adb-kbd.c:    device_class_set_parent_realize(dc, adb_kbd_realizefn,
hw/input/adb-mouse.c:    device_class_set_parent_realize(dc,
adb_mouse_realizefn,
hw/intc/arm_gic.c:    device_class_set_parent_realize(dc,
arm_gic_realize, &agc->parent_realize);
hw/intc/arm_gic_kvm.c:    device_class_set_parent_realize(dc,
kvm_arm_gic_realize,
hw/intc/arm_gicv3.c:    device_class_set_parent_realize(dc,
arm_gic_realize, &agc->parent_realize);
hw/intc/arm_gicv3_hvf.c:    device_class_set_parent_realize(dc,
hvf_gicv3_realize,
hw/intc/arm_gicv3_kvm.c:    device_class_set_parent_realize(dc,
kvm_arm_gicv3_realize,
hw/intc/arm_gicv3_whpx.c:    device_class_set_parent_realize(dc,
whpx_gicv3_realize,
hw/intc/arm_gicv5.c:    device_class_set_parent_realize(dc,
gicv5_realize, &gc->parent_realize);
hw/intc/i8259.c:    device_class_set_parent_realize(dc, pic_realize,
&k->parent_realize);
hw/intc/loongarch_dintc.c:    device_class_set_parent_realize(dc,
loongarch_dintc_realize,
hw/intc/loongarch_extioi.c:    device_class_set_parent_realize(dc,
loongarch_extioi_realize,
hw/intc/loongarch_extioi_common.c:
device_class_set_parent_realize(dc, loongarch_extioi_common_realize,
hw/intc/loongarch_ipi.c:    device_class_set_parent_realize(dc,
loongarch_ipi_realize,
hw/intc/loongarch_pch_pic.c:    device_class_set_parent_realize(dc,
loongarch_pic_realize,
hw/intc/loongarch_pic_common.c:    device_class_set_parent_realize(dc,
loongarch_pic_common_realize,
hw/intc/loongson_ipi.c:    device_class_set_parent_realize(dc,
loongson_ipi_realize,
hw/intc/loongson_ipi_common.c:    device_class_set_parent_realize(dc,
loongson_ipi_common_realize,
hw/intc/pnv_xive.c:    device_class_set_parent_realize(dc,
pnv_xive_realize, &pxc->parent_realize);
hw/intc/pnv_xive2.c:    device_class_set_parent_realize(dc, pnv_xive2_realize,
hw/intc/spapr_xive.c:    device_class_set_parent_realize(dc, spapr_xive_realize,
hw/intc/xics_pnv.c:    device_class_set_parent_realize(dc, pnv_icp_realize,
hw/intc/s390_flic_kvm.c:    device_class_set_parent_realize(dc,
kvm_s390_flic_realize,
hw/nubus/nubus-virtio-mmio.c:    device_class_set_parent_realize(dc,
nubus_virtio_mmio_realize,
hw/timer/i8254.c:    device_class_set_parent_realize(dc,
pit_realizefn, &pc->parent_realize);
hw/virtio/virtio-pci.c:    device_class_set_parent_realize(dc,
virtio_pci_dc_realize,
target/alpha/cpu.c:    device_class_set_parent_realize(dc, alpha_cpu_realizefn,
target/arm/cpu.c:    device_class_set_parent_realize(dc, arm_cpu_realizefn,
target/avr/cpu.c:    device_class_set_parent_realize(dc,
avr_cpu_realizefn, &mcc->parent_realize);
target/hexagon/cpu.c:    device_class_set_parent_realize(dc,
hexagon_cpu_realize,
target/hppa/cpu.c:    device_class_set_parent_realize(dc, hppa_cpu_realizefn,
target/i386/cpu.c:    device_class_set_parent_realize(dc, x86_cpu_realizefn,
target/loongarch/cpu.c:    device_class_set_parent_realize(dc,
loongarch_cpu_realizefn,
target/m68k/cpu.c:    device_class_set_parent_realize(dc, m68k_cpu_realizefn,
target/microblaze/cpu.c:    device_class_set_parent_realize(dc,
mb_cpu_realizefn,
target/mips/cpu.c:    device_class_set_parent_realize(dc, mips_cpu_realizefn,
target/or1k/cpu.c:    device_class_set_parent_realize(dc,
openrisc_cpu_realizefn,
target/ppc/cpu_init.c:    device_class_set_parent_realize(dc, ppc_cpu_realize,
target/riscv/cpu.c:    device_class_set_parent_realize(dc, riscv_cpu_realize,
target/rx/cpu.c:    device_class_set_parent_realize(dc, rx_cpu_realize,
target/s390x/cpu.c:    device_class_set_parent_realize(dc, s390_cpu_realizefn,
target/sh4/cpu.c:    device_class_set_parent_realize(dc, superh_cpu_realizefn,
target/sparc/cpu.c:    device_class_set_parent_realize(dc, sparc_cpu_realizefn,
target/tricore/cpu.c:    device_class_set_parent_realize(dc,
tricore_cpu_realizefn,
target/xtensa/cpu.c:    device_class_set_parent_realize(dc,
xtensa_cpu_realizefn,

in parent's class:

hw/input/lasips2.c:    device_class_set_parent_realize(dc,
lasips2_kbd_port_realize,
hw/input/lasips2.c:    device_class_set_parent_realize(dc,
lasips2_mouse_port_realize,
hw/input/pl050.c:    device_class_set_parent_realize(dc, pl050_kbd_realize,
hw/input/pl050.c:    device_class_set_parent_realize(dc, pl050_mouse_realize,
hw/intc/xics_spapr.c:    device_class_set_parent_realize(dc, ics_spapr_realize,
hw/isa/pc87312.c:    device_class_set_parent_realize(dc, pc87312_realize,
hw/isa/vt82c686.c:    device_class_set_parent_realize(dc, via_superio_realize,
hw/pci-bridge/cxl_root_port.c:    device_class_set_parent_realize(dc,
cxl_rp_realize, &rpc->parent_realize);
hw/pci-bridge/gen_pcie_root_port.c:
device_class_set_parent_realize(dc, gen_rp_realize,
&rpc->parent_realize);
hw/pci-host/pnv_phb.c:    device_class_set_parent_realize(dc,
pnv_phb_root_port_realize,
hw/pci-host/pnv_phb3_msi.c:    device_class_set_parent_realize(dc,
phb3_msi_realize,
hw/ppc/pnv.c:    device_class_set_parent_realize(dc, pnv_chip_power8_realize,
hw/ppc/pnv.c:    device_class_set_parent_realize(dc, pnv_chip_power9_realize,
hw/ppc/pnv.c:    device_class_set_parent_realize(dc, pnv_chip_power10_realize,
hw/ppc/pnv.c:    device_class_set_parent_realize(dc, pnv_chip_power11_realize,
hw/ppc/pnv_lpc.c:    device_class_set_parent_realize(dc, pnv_lpc_power8_realize,
hw/ppc/pnv_lpc.c:    device_class_set_parent_realize(dc, pnv_lpc_power9_realize,
hw/s390x/tod-kvm.c:
device_class_set_parent_realize(DEVICE_CLASS(oc),
kvm_s390_tod_realize,
hw/virtio/vhost-user-gpio.c:    device_class_set_parent_realize(dc,
vgpio_realize,
hw/virtio/vhost-user-i2c.c:    device_class_set_parent_realize(dc, vi2c_realize,
hw/virtio/vhost-user-input.c:    device_class_set_parent_realize(dc,
vinput_realize,
hw/virtio/vhost-user-rng.c:    device_class_set_parent_realize(dc,
vu_rng_base_realize,
hw/virtio/vhost-user-rtc.c:    device_class_set_parent_realize(dc,
vu_rtc_base_realize,
hw/virtio/vhost-user-snd.c:    device_class_set_parent_realize(dc,
vu_snd_base_realize,
hw/virtio/vhost-user-spi.c:    device_class_set_parent_realize(dc, vspi_realize,

thanks
-- PMM

