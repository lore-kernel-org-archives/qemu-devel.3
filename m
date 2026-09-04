Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA146C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Oo3-0001nd-BV; Fri, 04 Sep 2026 03:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2Onx-0001ls-Gl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 03:57:45 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2Onv-0005R6-2Y
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 03:57:44 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-85a50f6a7f7so8515427b3.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 00:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788508661; cv=none;
 d=google.com; s=arc-20260327;
 b=JnfqsXSgq3/8UjrMbjWQlpXkUfPDZYZNmcbb+/mB5/Y/7u9VVltLMJgC8WEo+umbAb
 kyvKUcJZRWb5RBioCuzNn5Kqg4ry1Xbe25xIqp/lNds0f2lzLz/K3/11ry93Opm4c4Jn
 qGZI6KTmBXTx+cfE5c4PoEIxlLPJaOVtvpPnpR+QqbkAwiM4pLg4+ZMWuQK0LuFtkhdB
 exTHS69jRIbdp8F0S3TFcVbluyvKdWaIWX4rs9d9vArLnAfztk23L96O55ogs/UD7s5J
 mrgZozRzIedcC0Bjp5G2pFF4O5NegprUBgqDBro0luWZcEPcR4jRd2uapjiX51mEM1Qf
 yCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F+fAQqv8Mtx05W/9+000N8Yv2TQC/wwSJn+qD/KqxRQ=;
 fh=CvvL5RCgFYNqG83R1A72L4qg+I3onr61VzjGy6O5ygw=;
 b=S1ypf6ZOTIj935EeQ804FJxszYMmuUZg6ZwSPw+2UHPkXx2Rm1YW64pbARZ6VpRby4
 ZUNVGSfYD4sIuK1fUhF86wvc8oYgiWjdwuAuMA+bj5DkXuWO28WFpDHSFluchnXfei5x
 2GgEVBUcRiPSwjJkYHCz8K1nfE+syjCQ0NHw/ejnSRR33JFwljgFFfjHCFVcsa11tBf1
 14Uk7pWKhlpz0RLYsMghhyvCqCsBlztveacON9l6weqAZG6fHuwyld2+8HSFUkQv6Klf
 l1rNIvOzofbGFCu3Ub+Kp26l41nwYYgPDnXFbhw+9FX0Y8lgCCIiSAxKa7kpoSrRQMGr
 Y6xQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788508661; x=1789113461; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F+fAQqv8Mtx05W/9+000N8Yv2TQC/wwSJn+qD/KqxRQ=;
 b=m9LXvMQOH/TnMzu8d48E+GbKOTGYHGhNXvjiBv+pQSCFfI2mFZFZMJE20dSPMPn1d+
 q5zk87cKCS6ed1HY8+UzNaSfpexqmuZs+zVUKJVixCU39QvHru0VeswKrOe58NcV5e71
 MUvpbxy9JD/NSa2JuNjhmK5gNWiDrxP41IlxmcX9TeKAaXycaCiLDFMf+XKGsho/Iwtn
 QANi148hCpVKfBvfLO8BJRDPyFtMMxfSzTDdxHBJz9e6UV7yUZnpKWa4a8LndAnu7zlN
 agDG8l4Xpc0dY3QmExB61gRHMv8yzHneWYHl+pkXSQfWGLfvEX4h9/8btg9bTdgVCWwt
 yXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788508661; x=1789113461;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F+fAQqv8Mtx05W/9+000N8Yv2TQC/wwSJn+qD/KqxRQ=;
 b=WRXDuYm8HZIzbyhZAdyxkLFp6j+ocJPyK1B97ohw/bq8y8ZKlYIS9KN3FcNFd8qqNU
 X0YysRnLBtZXhfaMkbt+PyASBrQ57dDCHq+JGPQcl1rftsxcGRBINqSUk1Wnz/0hdVUW
 apFEvcxvNYwyoZQlrqM+tjBGwHOoanm8qEPTpFxx3voWAoZ/3+6DQ1Spx2fNgh3eNwYG
 f2mrNNb/7okEMlQQhbUpA7nd856VN+e/vGu0deJd/qH5kdycR2iQDvj8nFdAwp9PH0ry
 FVgGFvY6MOI/55p54ElDJubLH8DLktykmfEMoeibCgrZydj1nOcPIKrQkLXrua/f53eE
 p4Jw==
X-Forwarded-Encrypted: i=1;
 AKwUvBycCNiC5MjAzYJTRIvbNOmAOTIv+rd4OckqThvV4jCsltB14v8I23e9gYkLJws4lc5ywEZBrBgI2R2K@nongnu.org
X-Gm-Message-State: AFuF++kZByQVIsQ75HTWOU4p4qIVowvtGQvmyxDzW7MxgXdcnsFv4rHM
 cBPYf+ISrlE3e00bmIBvtD7N1fYhBjdpdgzzHSiKlaFG/1aFTrTx/ubDc3TD3QClRtWfxRhxM1x
 kE0ArRVu7MtO6aNgMh8rP+YNclGg9JhM=
X-Gm-Gg: AYBFou0Ul+PwLSi24XsKfjiI6ACARTT4Qk5z41Amap1oLLoCUaNvyZyhSZsjrw4I12g
 WHuP9O0Jg3Kasi4IRHR8Lmm0NcRgGYi/W8ZzKBorrPOKrS1PPZXudxaTWQ9mOE+fwS6jG2QqrwC
 y1mpeAVRcz35afEp1SyyhteS3NT6GQ9BU96s+T1cTFtgkOGUsElytlSK0DFAKDIFULIzOhpUky9
 fVEUbOPKiHCW+gx0TKx90Nj5BcDH71WWbABrP2OYaWNCzns/KqDWLUFNKiv74FZDhxmDFm9I/Wh
 wWGd4IZ6XmMRRLGfzGjoswPtIdEYezRDGw5fcV/qmsd+
X-Received: by 2002:a05:690c:28f:b0:870:107b:635d with SMTP id
 00721157ae682-87129f3cdbcmr25032387b3.31.1788508661198; Fri, 04 Sep 2026
 00:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-3-bin.meng@processmission.com>
 <0795176d-4580-4acc-a3cf-c40f8d221661@oss.qualcomm.com>
In-Reply-To: <0795176d-4580-4acc-a3cf-c40f8d221661@oss.qualcomm.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 4 Sep 2026 15:57:28 +0800
X-Gm-Features: AcwNN1X4W_P2FJd-ORDICHFQUwr5Ot-Nj9d04bx9wdIHCfLRMjRg1Ifqon25950
Message-ID: <CAEUhbmW4h_-az5iBsztzy8Yuu06+WMjOYcrL51sW8VEgyAaSMw@mail.gmail.com>
Subject: Re: [PATCH 02/33] hw/arm: Add basic Phytium Pi machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Philippe,

On Fri, Sep 4, 2026 at 12:56=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 3/9/26 13:24, Bin Meng wrote:
> > Add the base topology for the Phytium Pi board built around the
> > E2000Q SoC, with two FTC310 and two FTC664 CPUs, RAM, GICv3/ITS,
> > and PL011 UARTs.
> >
> > Describe the CPUs as three non-uniform clusters matching the vendor
> > Linux device tree. Preserve the board CPU slot order so firmware
> > MPIDR 0x200 maps to QEMU CPU index 2.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > ---
> >
> >   hw/arm/Kconfig         |   8 +
> >   hw/arm/meson.build     |   1 +
> >   hw/arm/phytium_e2000.c | 406 ++++++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 415 insertions(+)
> >   create mode 100644 hw/arm/phytium_e2000.c
>
>
> > +struct PhytiumE2000State {
> > +    MachineState parent;
> > +    struct arm_boot_info bootinfo;
> > +    DeviceState *gic;
> > +    MemoryRegion ram_low;
> > +    MemoryRegion ram_high;
> > +};
>
>
> > +static void phytium_e2000_create_gic(PhytiumE2000State *s)
> > +{
> > +    MachineState *ms =3D MACHINE(s);
> > +    SysBusDevice *gicbusdev;
> > +    QList *redist_region_count;
> > +    int i;
> > +
> > +    s->gic =3D qdev_new(gicv3_class_name());
> > +    qdev_prop_set_uint32(s->gic, "revision", 3);
> > +    qdev_prop_set_uint32(s->gic, "num-cpu", ms->smp.cpus);
> > +    qdev_prop_set_uint32(s->gic, "num-irq", PHYTIUM_E2000_NUM_IRQS + 3=
2);
> > +    qdev_prop_set_bit(s->gic, "has-security-extensions", true);
> > +    qdev_prop_set_bit(s->gic, "has-lpi", true);
> > +
> > +    redist_region_count =3D qlist_new();
> > +    qlist_append_int(redist_region_count, ms->smp.cpus);
> > +    qdev_prop_set_array(s->gic, "redist-region-count", redist_region_c=
ount);
> > +
> > +    object_property_set_link(OBJECT(s->gic), "sysmem",
> > +                             OBJECT(get_system_memory()), &error_fatal=
);
> > +
> > +    gicbusdev =3D SYS_BUS_DEVICE(s->gic);
> > +    sysbus_realize_and_unref(gicbusdev, &error_fatal);
> > +    sysbus_mmio_map(gicbusdev, 0,
> > +                    phytium_e2000_memmap[PHYTIUM_E2000_GIC_DIST].base)=
;
> > +    sysbus_mmio_map(gicbusdev, 1,
> > +                    phytium_e2000_memmap[PHYTIUM_E2000_GIC_REDIST].bas=
e);
> > +
> > +    for (i =3D 0; i < ms->smp.cpus; i++) {
> > +        DeviceState *cpudev =3D DEVICE(qemu_get_cpu(i));
>
> I'd rather you keep a reference in PhytiumE2000State when creating
> in [*] and access the CPUs that way, not with qemu_get_cpu() (because
> we plan to restrict it to accel/, as it is problematic on heterogeneous
> emulation).

Will fix in v2.

>
> > +        int intidbase =3D PHYTIUM_E2000_NUM_IRQS + i * GIC_INTERNAL;
> > +        static const int timer_irq[] =3D {
> > +            [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,
> > +            [GTIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,
> > +            [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
> > +            [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
> > +        };
> > +
> > +        for (int irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> > +            qdev_connect_gpio_out(cpudev, irq,
> > +                qdev_get_gpio_in(s->gic, intidbase + timer_irq[irq]));
> > +        }
> > +        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interru=
pt", 0,
> > +            qdev_get_gpio_in(s->gic, intidbase + ARCH_GIC_MAINT_IRQ));
> > +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> > +            qdev_get_gpio_in(s->gic, intidbase + VIRTUAL_PMU_IRQ));
> > +
> > +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_=
CPU_IRQ));
> > +        sysbus_connect_irq(gicbusdev, i + ms->smp.cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> > +        sysbus_connect_irq(gicbusdev, i + 2 * ms->smp.cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> > +        sysbus_connect_irq(gicbusdev, i + 3 * ms->smp.cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> > +    }
> > +
> > +    phytium_e2000_create_its(s);
> > +}
>
>
> > +static void phytium_e2000_create_cpus(PhytiumE2000State *s)
> > +{
> > +    MachineState *ms =3D MACHINE(s);
> > +    const CPUArchIdList *possible_cpus;
> > +    int i;
> > +
> > +    possible_cpus =3D MACHINE_GET_CLASS(ms)->possible_cpu_arch_ids(ms)=
;
> > +
> > +    for (i =3D 0; i < ms->smp.cpus; i++) {
> > +        Object *cpuobj =3D object_new(possible_cpus->cpus[i].type);
>
> [*]
>
> > +        CPUState *cs;
> > +
> > +        object_property_set_int(cpuobj, "mp-affinity",
> > +                                possible_cpus->cpus[i].arch_id,
> > +                                &error_abort);
> > +        object_property_set_int(cpuobj, "cntfrq", PHYTIUM_E2000_GTIMER=
_HZ,
> > +                                &error_abort);
> > +        if (object_property_find(cpuobj, "has_el3")) {
> > +            /*
> > +             * The generic-loader U-Boot path starts after the EL3 fir=
mware
> > +             * stages that normally provide the Phytium SMC services.
> > +             */
> > +            object_property_set_bool(cpuobj, "has_el3", false, &error_=
abort);
> > +        }
> > +        object_property_set_link(cpuobj, "memory", OBJECT(get_system_m=
emory()),
> > +                                 &error_abort);
> > +        cs =3D CPU(cpuobj);
> > +        cs->cpu_index =3D i;
> > +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> > +        object_unref(cpuobj);
> > +    }
> > +}
> > +
> > +static void phytium_pi_init(MachineState *ms)
> > +{
> > +    PhytiumE2000State *s =3D PHYTIUM_PI(ms);
> > +    int i;
> > +
> > +    if (kvm_enabled()) {
> > +        error_report("phytium-pi: KVM is not supported");
>
> Why is it relevant?

This is because the machine relies on heterogeneous named
FTC310/FTC664 TCG CPU models and Arm KVM generally requires the host
CPU model. KVM is rejected explicitly instead of failing later during
vCPU initialization.

> > +        exit(1);
> > +    }
>
> > +}
> Conditional to not using qemu_get_cpu():
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Thanks for the review!

Regards,
Bin

