Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2991CE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRGhJ-0002ie-4O; Fri, 27 Dec 2024 15:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRGhH-0002iA-Cb
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:12:35 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRGhD-0003Sm-Dg
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:12:35 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4afde39e360so2000949137.0
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735330348; x=1735935148;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fuEGie7JTlgp6gW4dMseEzs4l8mtigZdTOyHPGYtgmA=;
 b=VXo/uzQIsg5Cf5Xdqmolxw4/yrwxjjiQ54EDwTbC0ls8/WHSg0BjdH+GSH78xEXkvO
 mP43jGBaqi1EnxJ1We/MbPXU8l5e0K7EnLgfEZHEliN8zs7oInnjBsf5OJexny4kGVMj
 1Jje94yCzpP553I4k1uS1E5e6SPKb57ROmlMeG8cGZU8iVbl+8Xy8pI4gDo6sSW58+wL
 R07YwVmyt46lLaVty/FqQbZ20hih4GDnumlepP079tDD3fiBHPriK7+rch05qaf3i6TL
 goQ7T4ghnlYfOyWbUuWhf1YhIbgf6FWYuQkkNnX40ad7y1F0CBczvhIIuV4nZVDXOd/+
 z17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735330348; x=1735935148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fuEGie7JTlgp6gW4dMseEzs4l8mtigZdTOyHPGYtgmA=;
 b=uLaAhba5+sR4vUU4yjjglNXUWC/WYJIsDDnTNND7Zu/BIz8QG0CXZhUIFAclEpeU3T
 t26GXR+aZrLsW/8BcyBHVUcPAdRo3wlwT6g59ukv4xV+S5heJZGpdJAjzikshX1vg2Kz
 Lr/L2/Y5LQkncqvIPGaMyivAGbEmwfh4avHXCsr94RczbWlplk20kpw2xtNV8B/hO4cz
 pijOHkaYmzxcO7I7A/T5SwCwfvrqVMe5+rk0Z1s8FlVU+g//odODcuVUIdR4rqeYg0kT
 TYkEAm1Jh8nYs/XfIsW2qneQ46tAftS0qv0n/Jpo+9/h7M55fZ/uZzGUn0fTNN+Jihod
 sM1Q==
X-Gm-Message-State: AOJu0YzfpDW9HryJle33aAnWYDZBge+7lC7QJGgCed/ga4R5qHLyUHJ6
 i1nf6QxCZg6pUkPZG3Uxb/yzDcBYcPsGbQNmdfepgJDOq17dxlcz4+n8D8IbugUAjurOm4Op/Qw
 e3HPy0SAoIYF6G1NF7pCzh5+EqaWvB0h7DT0c
X-Gm-Gg: ASbGncurJILm1OocEEpGuEkR2THEYm2aaQjlWtSzViJBfkNOzqAe+7SMQh4Vprb1AOa
 Om3nayqZD5bWoUFjBL++kodXSiYjmu+GzwhrxEQ==
X-Google-Smtp-Source: AGHT+IFZfpjfDEPJb6gjs2N+rgnjgSA6IAIWvRbv7mKx2HOghaNoPA7IbaR2eaCKRdMsF9GU+5VwwGrLFWSR5cURjNw=
X-Received: by 2002:a05:6102:3909:b0:4b2:c06d:27dd with SMTP id
 ada2fe7eead31-4b2cc45e097mr22554441137.21.1735330348214; Fri, 27 Dec 2024
 12:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20241223221645.29911-1-phil@philjordan.eu>
 <20241223221645.29911-15-phil@philjordan.eu>
 <1211286e-9211-4d89-9021-f353169af6ad@linaro.org>
In-Reply-To: <1211286e-9211-4d89-9021-f353169af6ad@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 27 Dec 2024 21:12:17 +0100
Message-ID: <CAAibmn0q6cBc41J5mABd4bkUEo6pS0MhL8DU8fPfygDvjLSPBQ@mail.gmail.com>
Subject: Re: [PATCH v16 14/14] hw/vmapple/vmapple: Add vmapple machine type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="000000000000f945d6062a46146a"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000f945d6062a46146a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri 27. Dec 2024 at 20:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> On 23/12/24 23:16, Phil Dennis-Jordan wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > Apple defines a new "vmapple" machine type as part of its proprietary
> > macOS Virtualization.Framework vmm. This machine type is similar to the
> > virt one, but with subtle differences in base devices, a few special
> > vmapple device additions and a vastly different boot chain.
> >
> > This patch reimplements this machine type in QEMU. To use it, you
> > have to have a readily installed version of macOS for VMApple,
> > run on macOS with -accel hvf, pass the Virtualization.Framework
> > boot rom (AVPBooter) in via -bios, pass the aux and root volume as pfla=
sh
> > and pass aux and root volume as virtio drives. In addition, you also
> > need to find the machine UUID and pass that as -M vmapple,uuid=3D
> parameter:
> >
> > $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G \
> >      -bios
> /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/=
AVPBooter.vmapple2.bin
> >      -drive file=3Daux,if=3Dpflash,format=3Draw \
> >      -drive file=3Droot,if=3Dpflash,format=3Draw \
> >      -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw \
> >      -device vmapple-virtio-blk-pci,variant=3Daux,drive=3Daux \
> >      -drive file=3Droot,if=3Dnone,id=3Droot,format=3Draw \
> >      -device vmapple-virtio-blk-pci,variant=3Droot,drive=3Droot
> >
> > With all these in place, you should be able to see macOS booting
> > successfully.
> >
> > Known issues:
> >   - Keyboard and mouse/tablet input is laggy. The reason for this is
> >     that macOS's XHCI driver seems to expect interrupter mapping to
> >     be disabled when MSI/MSI-X is unavailable. I have found a
> >     workaround but discovered a bunch of other XHCI spec non-compliance
> >     in the process, so I'm fixing all of those in a separate patch
> >     set.
> >   - Currently only macOS 12 guests are supported. The boot process for
> >     13+ will need further investigation and adjustment.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
>
>
> > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> > index bcd1be63e3..6a4c4a7fa2 100644
> > --- a/hw/vmapple/Kconfig
> > +++ b/hw/vmapple/Kconfig
> > @@ -10,3 +10,23 @@ config VMAPPLE_CFG
> >   config VMAPPLE_VIRTIO_BLK
> >       bool
> >
> > +config VMAPPLE
> > +    bool
> > +    depends on ARM
> > +    depends on HVF
> > +    default y if ARM
> > +    imply PCI_DEVICES
> > +    select ARM_GIC
>
> Hmmm I'm getting ...:
>
> qemu-system-aarch64: unknown type 'arm-gicv3'
>
> > +    select PLATFORM_BUS
> > +    select PCI_EXPRESS
> > +    select PCI_EXPRESS_GENERIC_BRIDGE
> > +    select PL011 # UART
> > +    select PL031 # RTC
> > +    select PL061 # GPIO
> > +    select GPIO_PWR
> > +    select PVPANIC_MMIO
> > +    select VMAPPLE_AES
> > +    select VMAPPLE_BDIF
> > +    select VMAPPLE_CFG
> > +    select MAC_PVG_MMIO
> > +    select VMAPPLE_VIRTIO_BLK
>
>
> > +static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
> > +{
> > +    MachineState *ms =3D MACHINE(vms);
> > +    /* We create a standalone GIC */
> > +    SysBusDevice *gicbusdev;
> > +    QList *redist_region_count;
> > +    int i;
> > +    unsigned int smp_cpus =3D ms->smp.cpus;
> > +
> > +    vms->gic =3D qdev_new(gicv3_class_name());
>
> ... I suppose due to this call ^^^.
>
> $ git grep arm-gicv3
> hw/intc/arm_gicv3_kvm.c:45:#define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv3"
> include/hw/intc/arm_gicv3.h:18:#define TYPE_ARM_GICV3 "arm-gicv3"
> $ git grep TYPE_ARM_GICV3
> hw/intc/arm_gicv3.c:466:    .name =3D TYPE_ARM_GICV3,
> $ git grep -FW arm_gicv3.c
> hw/intc/meson.build=3D9=3Dsystem_ss.add(when: 'CONFIG_ARM_GICV3_TCG',
> if_true: files(
> hw/intc/meson.build:10:  'arm_gicv3.c',
> ...
>

Ahhh, good catch! I suppose this is with =E2=80=94disable-tcg (or equivalen=
t)


> I think commit a8a5546798c ("hw/intc/arm_gicv3: Introduce
> CONFIG_ARM_GIC_TCG Kconfig selector") is invalid as being
> too restrictive.
>
> I can go a bit further with these changes on top (ignoring
> renaming ARM_GICV3_TCG -> ARM_GICV3):
>

> -- >8 --
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index dd405bdb5d2..9e06c05b449 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -26 +26 @@ config ARM_GIC
> -    select ARM_GICV3_TCG if TCG
> +    select ARM_GICV3_TCG if TCG || HVF
> @@ -32 +32 @@ config ARM_GICV3_TCG
> -    depends on ARM_GIC && TCG
> +    depends on ARM_GIC && (TCG || HVF)
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index 6a4c4a7fa2e..374a89f6a8f 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -19 +19 @@ config VMAPPLE
> -    select ARM_GIC
> +    select ARM_GICV3_TCG


Is this last part necessary/advisable? It would seem like the above changes
in hw/intc/Kconfig should make ARM_GIC work too?
(The PVG dependency means we currently can=E2=80=99t support anything other=
 than
macOS host systems and thus HVF or theoretically TCG anyway, but if QEMU
gained support for the HVF-provided GIC implementation, we=E2=80=99d need t=
o change
this line again.)


> ---
>
> > +    qdev_prop_set_uint32(vms->gic, "revision", 3);
> > +    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
> > +    /*
> > +     * Note that the num-irq property counts both internal and externa=
l
> > +     * interrupts; there are always 32 of the former (mandated by GIC
> spec).
> > +     */
> > +    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
> > +
> > +    uint32_t redist0_capacity =3D
> > +                vms->memmap[VMAPPLE_GIC_REDIST].size /
> GICV3_REDIST_SIZE;
> > +    uint32_t redist0_count =3D MIN(smp_cpus, redist0_capacity);
> > +
> > +    redist_region_count =3D qlist_new();
> > +    qlist_append_int(redist_region_count, redist0_count);
> > +    qdev_prop_set_array(vms->gic, "redist-region-count",
> redist_region_count);
> > +
> > +    gicbusdev =3D SYS_BUS_DEVICE(vms->gic);
> > +    sysbus_realize_and_unref(gicbusdev, &error_fatal);
> > +    sysbus_mmio_map(gicbusdev, 0, vms->memmap[VMAPPLE_GIC_DIST].base);
> > +    sysbus_mmio_map(gicbusdev, 1, vms->memmap[VMAPPLE_GIC_REDIST].base=
);
> > +
> > +    /*
> > +     * Wire the outputs from each CPU's generic timer and the GICv3
> > +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> > +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's
> inputs.
> > +     */
> > +    for (i =3D 0; i < smp_cpus; i++) {
> > +        DeviceState *cpudev =3D DEVICE(qemu_get_cpu(i));
> > +
> > +        /* Map the virt timer to PPI 27 */
> > +        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
> > +                              qdev_get_gpio_in(vms->gic,
> > +                                               arm_gic_ppi_index(i,
> 27)));
> > +
> > +        /* Map the GIC IRQ and FIQ lines to CPU */
> > +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev,
> ARM_CPU_IRQ));
> > +        sysbus_connect_irq(gicbusdev, i + smp_cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> > +    }
> > +}
>
>

--000000000000f945d6062a46146a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri 27. Dec 2024 at 20:23, Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-=
color:rgb(204,204,204)">On 23/12/24 23:16, Phil Dennis-Jordan wrote:<br>
&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=3D"=
_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; Apple defines a new &quot;vmapple&quot; machine type as part of its pr=
oprietary<br>
&gt; macOS Virtualization.Framework vmm. This machine type is similar to th=
e<br>
&gt; virt one, but with subtle differences in base devices, a few special<b=
r>
&gt; vmapple device additions and a vastly different boot chain.<br>
&gt; <br>
&gt; This patch reimplements this machine type in QEMU. To use it, you<br>
&gt; have to have a readily installed version of macOS for VMApple,<br>
&gt; run on macOS with -accel hvf, pass the Virtualization.Framework<br>
&gt; boot rom (AVPBooter) in via -bios, pass the aux and root volume as pfl=
ash<br>
&gt; and pass aux and root volume as virtio drives. In addition, you also<b=
r>
&gt; need to find the machine UUID and pass that as -M vmapple,uuid=3D para=
meter:<br>
&gt; <br>
&gt; $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -bios /System/Library/Frameworks/Virtualization.fr=
amework/Versions/A/Resources/AVPBooter.vmapple2.bin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-blk-pci,variant=3Daux,drive=
=3Daux \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dnone,id=3Droot,format=3Dra=
w \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-blk-pci,variant=3Droot,driv=
e=3Droot<br>
&gt; <br>
&gt; With all these in place, you should be able to see macOS booting<br>
&gt; successfully.<br>
&gt; <br>
&gt; Known issues:<br>
&gt;=C2=A0 =C2=A0- Keyboard and mouse/tablet input is laggy. The reason for=
 this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0that macOS&#39;s XHCI driver seems to expect interr=
upter mapping to<br>
&gt;=C2=A0 =C2=A0 =C2=A0be disabled when MSI/MSI-X is unavailable. I have f=
ound a<br>
&gt;=C2=A0 =C2=A0 =C2=A0workaround but discovered a bunch of other XHCI spe=
c non-compliance<br>
&gt;=C2=A0 =C2=A0 =C2=A0in the process, so I&#39;m fixing all of those in a=
 separate patch<br>
&gt;=C2=A0 =C2=A0 =C2=A0set.<br>
&gt;=C2=A0 =C2=A0- Currently only macOS 12 guests are supported. The boot p=
rocess for<br>
&gt;=C2=A0 =C2=A0 =C2=A013+ will need further investigation and adjustment.=
<br>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Co-authored-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjord=
an.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; Tested-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.co=
m" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; ---<br>
<br>
<br>
&gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig<br>
&gt; index bcd1be63e3..6a4c4a7fa2 100644<br>
&gt; --- a/hw/vmapple/Kconfig<br>
&gt; +++ b/hw/vmapple/Kconfig<br>
&gt; @@ -10,3 +10,23 @@ config VMAPPLE_CFG<br>
&gt;=C2=A0 =C2=A0config VMAPPLE_VIRTIO_BLK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config VMAPPLE<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 depends on ARM<br>
&gt; +=C2=A0 =C2=A0 depends on HVF<br>
&gt; +=C2=A0 =C2=A0 default y if ARM<br>
&gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
&gt; +=C2=A0 =C2=A0 select ARM_GIC<br>
<br>
Hmmm I&#39;m getting ...:<br>
<br>
qemu-system-aarch64: unknown type &#39;arm-gicv3&#39;<br>
<br>
&gt; +=C2=A0 =C2=A0 select PLATFORM_BUS<br>
&gt; +=C2=A0 =C2=A0 select PCI_EXPRESS<br>
&gt; +=C2=A0 =C2=A0 select PCI_EXPRESS_GENERIC_BRIDGE<br>
&gt; +=C2=A0 =C2=A0 select PL011 # UART<br>
&gt; +=C2=A0 =C2=A0 select PL031 # RTC<br>
&gt; +=C2=A0 =C2=A0 select PL061 # GPIO<br>
&gt; +=C2=A0 =C2=A0 select GPIO_PWR<br>
&gt; +=C2=A0 =C2=A0 select PVPANIC_MMIO<br>
&gt; +=C2=A0 =C2=A0 select VMAPPLE_AES<br>
&gt; +=C2=A0 =C2=A0 select VMAPPLE_BDIF<br>
&gt; +=C2=A0 =C2=A0 select VMAPPLE_CFG<br>
&gt; +=C2=A0 =C2=A0 select MAC_PVG_MMIO<br>
&gt; +=C2=A0 =C2=A0 select VMAPPLE_VIRTIO_BLK<br>
<br>
<br>
&gt; +static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
&gt; +=C2=A0 =C2=A0 /* We create a standalone GIC */<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *gicbusdev;<br>
&gt; +=C2=A0 =C2=A0 QList *redist_region_count;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 unsigned int smp_cpus =3D ms-&gt;smp.cpus;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;gic =3D qdev_new(gicv3_class_name());<br>
<br>
... I suppose due to this call ^^^.<br>
<br>
$ git grep arm-gicv3<br>
hw/intc/arm_gicv3_kvm.c:45:#define TYPE_KVM_ARM_GICV3 &quot;kvm-arm-gicv3&q=
uot;<br>
include/hw/intc/arm_gicv3.h:18:#define TYPE_ARM_GICV3 &quot;arm-gicv3&quot;=
<br>
$ git grep TYPE_ARM_GICV3<br>
hw/intc/arm_gicv3.c:466:=C2=A0 =C2=A0 .name =3D TYPE_ARM_GICV3,<br>
$ git grep -FW arm_gicv3.c<br>
hw/intc/meson.build=3D9=3Dsystem_ss.add(when: &#39;CONFIG_ARM_GICV3_TCG&#39=
;, <br>
if_true: files(<br>
hw/intc/meson.build:10:=C2=A0 &#39;arm_gicv3.c&#39;,<br>
...<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Ahhh, good catch=
! I suppose this is with =E2=80=94disable-tcg (or equivalent)</div><div dir=
=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex=
;border-left-color:rgb(204,204,204)"><br>
I think commit a8a5546798c (&quot;hw/intc/arm_gicv3: Introduce<br>
CONFIG_ARM_GIC_TCG Kconfig selector&quot;) is invalid as being<br>
too restrictive.<br>
<br>
I can go a bit further with these changes on top (ignoring<br>
renaming ARM_GICV3_TCG -&gt; ARM_GICV3):<br>
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;border=
-left-color:rgb(204,204,204)"><br>
-- &gt;8 --<br>
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig<br>
index dd405bdb5d2..9e06c05b449 100644<br>
--- a/hw/intc/Kconfig<br>
+++ b/hw/intc/Kconfig<br>
@@ -26 +26 @@ config ARM_GIC<br>
-=C2=A0 =C2=A0 select ARM_GICV3_TCG if TCG<br>
+=C2=A0 =C2=A0 select ARM_GICV3_TCG if TCG || HVF<br>
@@ -32 +32 @@ config ARM_GICV3_TCG<br>
-=C2=A0 =C2=A0 depends on ARM_GIC &amp;&amp; TCG<br>
+=C2=A0 =C2=A0 depends on ARM_GIC &amp;&amp; (TCG || HVF)<br>
diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig<br>
index 6a4c4a7fa2e..374a89f6a8f 100644<br>
--- a/hw/vmapple/Kconfig<br>
+++ b/hw/vmapple/Kconfig<br>
@@ -19 +19 @@ config VMAPPLE<br>
-=C2=A0 =C2=A0 select ARM_GIC<br>
+=C2=A0 =C2=A0 select ARM_GICV3_TCG</blockquote><div dir=3D"auto"><br></div=
><div dir=3D"auto">Is this last part necessary/advisable? It would seem lik=
e the above changes in hw/intc/Kconfig should make ARM_GIC work too?</div><=
div dir=3D"auto">(The PVG dependency means we currently can=E2=80=99t suppo=
rt anything other than macOS host systems and thus HVF or theoretically TCG=
 anyway, but if QEMU gained support for the HVF-provided GIC implementation=
, we=E2=80=99d need to change this line again.)</div><div dir=3D"auto"><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-c=
olor:rgb(204,204,204)" dir=3D"auto"><br>
---<br>
<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;gic, &quot;revision&quot;,=
 3);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;gic, &quot;num-cpu&quot;, =
smp_cpus);<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Note that the num-irq property counts both inte=
rnal and external<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* interrupts; there are always 32 of the former (=
mandated by GIC spec).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;gic, &quot;num-irq&quot;, =
NUM_IRQS + 32);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t redist0_capacity =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vms-&gt;memma=
p[VMAPPLE_GIC_REDIST].size / GICV3_REDIST_SIZE;<br>
&gt; +=C2=A0 =C2=A0 uint32_t redist0_count =3D MIN(smp_cpus, redist0_capaci=
ty);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 redist_region_count =3D qlist_new();<br>
&gt; +=C2=A0 =C2=A0 qlist_append_int(redist_region_count, redist0_count);<b=
r>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_array(vms-&gt;gic, &quot;redist-region-co=
unt&quot;, redist_region_count);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 gicbusdev =3D SYS_BUS_DEVICE(vms-&gt;gic);<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(gicbusdev, &amp;error_fatal);<=
br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gicbusdev, 0, vms-&gt;memmap[VMAPPLE_GI=
C_DIST].base);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gicbusdev, 1, vms-&gt;memmap[VMAPPLE_GI=
C_REDIST].base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Wire the outputs from each CPU&#39;s generic ti=
mer and the GICv3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* maintenance interrupt signal to the appropriate=
 GIC PPI inputs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and the GIC&#39;s IRQ/FIQ/VIRQ/VFIQ interrupt o=
utputs to the CPU&#39;s inputs.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; smp_cpus; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *cpudev =3D DEVICE(qemu_get_c=
pu(i));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Map the virt timer to PPI 27 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(cpudev, GTIMER_VIRT=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(vms-&gt;gic,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0arm_gic_ppi_index(i, 27)));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Map the GIC IRQ and FIQ lines to CPU *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(gicbusdev, i, qdev_get=
_gpio_in(cpudev, ARM_CPU_IRQ));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(gicbusdev, i + smp_cpu=
s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
<br>
</blockquote></div></div>

--000000000000f945d6062a46146a--

