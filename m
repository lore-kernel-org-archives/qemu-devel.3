Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0B7D59F6B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 19:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8laW-0002FX-BP; Wed, 06 Nov 2024 14:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8laJ-0002En-FS
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 14:20:56 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8laB-0001ht-Ke
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 14:20:53 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-851d2a36e6dso979130241.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 11:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730920846; x=1731525646;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MI7dMPRCaoxTBqh0BtfZgBlELiGzp8uwd6BeVQBlkOE=;
 b=kbB7GEOZS1we0ulNl07T169S5/tSfXsgZvXSN6PKQ287TI2uofACGXNWi/KD5yISWm
 ur5b+2PQkuZOYYfQijceyRk4j1ksPFg+lX7ELKb/kZwcCYtYxURMuUWHwDQKwPAwRiqc
 BVgRhLc6sXXurr45zQzKV5YTQybfUYiPuyF0C3Zsi+KpFfEyit/vNlr42mSeULaac3UP
 DBSspRJ+u5GeSOLWoom56H5aNkYjFOLfGmGYAFc91xGNz2PqjdC8Dlw9YzpfSTfknGrK
 PAiXqZ92DwRmMt324CksmXdcRb0iuTFaaoHfDxCBckDIpdryZDho/IPlE2hJa2+Xfkih
 u1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730920846; x=1731525646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MI7dMPRCaoxTBqh0BtfZgBlELiGzp8uwd6BeVQBlkOE=;
 b=pFqA4qXXbv8+LcwPgSe4GtGdvDfzL14xyepLTU49+CBoR0q1DTCVfAz7AW+Cx4RzmB
 2RgkAKEegd48QEy2+xiC2Le91yHBdiScY/f5eI4Fs14p7aClKeha2qIT9iZNWTecNWv+
 46XTJX6uM/m4iMKM7dAmI9/G41Qk6FMtQfGo94e8jMunrPeCIdXqy88pMpWn9b9NVVJJ
 9SHuopOSWIHp/TW1wl0iSaS3COtwe2Ck9U1R0dc09CEmrostk2cCH2COrXASkBU7qzFs
 nXaw/0uberyVxlYJKpL17E7QsQ1/DdfbNP+En/had6mVjbc5M1hRho6WHCz2q1R9KkI1
 r6Zw==
X-Gm-Message-State: AOJu0Yy2tSKd1g8B/oQwCVnayXvWYxqESJiZQW3zHkc4qR9QS2vyICXW
 czl6mH5koGU6+f35FMshZTQiHrxyE4cegRY5XIFahiTe7PG8tYJdkODYp2/e3/5cfZik3UwZ5Jt
 fReXTnQ4/Wm3x4TyLc4+dGNL2AmNR88modwqm
X-Google-Smtp-Source: AGHT+IHKC3mOzvtaMpQLViAAOzj3PFPJ7hwTj+3rPR8T7f2Tgrm08o+pDoU8BQJ3SE9QXmV+QO1XWef/aUilk/N9IIM=
X-Received: by 2002:a05:6102:5f07:b0:4a9:69ce:dcfb with SMTP id
 ada2fe7eead31-4a9c23a36eamr582276137.7.1730920845904; Wed, 06 Nov 2024
 11:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20241105153022.91101-1-phil@philjordan.eu>
 <20241105153022.91101-16-phil@philjordan.eu>
 <e023128a-b08d-4ce0-8ba3-02f17e8e5af8@daynix.com>
 <CAAibmn3dYaA6Di9EmK54CHiPB0B0UrVSJLRiQ4YeCPcWN95j-w@mail.gmail.com>
 <8b5f5c72-c3c8-40b6-a4b5-7e69bbcc4481@daynix.com>
In-Reply-To: <8b5f5c72-c3c8-40b6-a4b5-7e69bbcc4481@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 6 Nov 2024 20:20:34 +0100
Message-ID: <CAAibmn1f7FRFnyddVFjYn2NaKc+2pGa7xA4bA+W268QXCZV5jQ@mail.gmail.com>
Subject: Re: [PATCH v7 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="00000000000027ac9e0626436a97"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92b;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92b.google.com
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

--00000000000027ac9e0626436a97
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 at 10:16, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/11/06 18:10, Phil Dennis-Jordan wrote:
> >
> >
> > On Wed, 6 Nov 2024 at 08:42, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/11/06 0:30, Phil Dennis-Jordan wrote:
> >      > From: Alexander Graf <graf@amazon.com <mailto:graf@amazon.com>>
> >      >
> >      > Apple defines a new "vmapple" machine type as part of its
> proprietary
> >      > macOS Virtualization.Framework vmm. This machine type is similar
> >     to the
> >      > virt one, but with subtle differences in base devices, a few
> special
> >      > vmapple device additions and a vastly different boot chain.
> >      >
> >      > This patch reimplements this machine type in QEMU. To use it, yo=
u
> >      > have to have a readily installed version of macOS for VMApple,
> >      > run on macOS with -accel hvf, pass the Virtualization.Framework
> >      > boot rom (AVPBooter) in via -bios, pass the aux and root volume
> >     as pflash
> >      > and pass aux and root volume as virtio drives. In addition, you
> also
> >      > need to find the machine UUID and pass that as -M vmapple,uuid=
=3D
> >     parameter:
> >      >
> >      > $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G =
\
> >      >      -bios /System/Library/Frameworks/Virtualization.framework/
> >     Versions/A/Resources/AVPBooter.vmapple2.bin
> >      >      -drive file=3Daux,if=3Dpflash,format=3Draw \
> >      >      -drive file=3Droot,if=3Dpflash,format=3Draw \
> >      >      -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw \
> >      >      -device vmapple-virtio-aux,drive=3Daux \
> >      >      -drive file=3Droot,if=3Dnone,id=3Droot,format=3Draw \
> >      >      -device vmapple-virtio-root,drive=3Droot
> >      >
> >      > With all these in place, you should be able to see macOS booting
> >      > successfully.
> >      >
> >      > Known issues:
> >      >   - Keyboard and mouse/tablet input is laggy. The reason for thi=
s
> is
> >      >     either that macOS's XHCI driver is broken when the device/
> >     platform
> >      >     does not support MSI/MSI-X, or there's some unfortunate
> interplay
> >      >     with Qemu's XHCI implementation in this scenario.
> >      >   - Currently only macOS 12 guests are supported. The boot
> >     process for
> >      >     13+ will need further investigation and adjustment.
> >      >
> >      > Signed-off-by: Alexander Graf <graf@amazon.com
> >     <mailto:graf@amazon.com>>
> >      > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu
> >     <mailto:phil@philjordan.eu>>
> >      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
> >     <mailto:phil@philjordan.eu>>
> >      > ---
> >      > v3:
> >      >   * Rebased on latest upstream, updated affinity and NIC creatio=
n
> >      > API usage
> >      >   * Included Apple-variant virtio-blk in build dependency
> >      >   * Updated API usage for setting 'redist-region-count' array-
> >     typed property on GIC.
> >      >   * Switched from virtio HID devices (for which macOS 12 does no=
t
> >     contain
> >      >     drivers) to an XHCI USB controller and USB HID devices.
> >      >
> >      > v4:
> >      >   * Fixups for v4 changes to the other patches in the set.
> >      >   * Corrected the assert macro to use
> >      >   * Removed superfluous endian conversions corresponding to cfg'=
s.
> >      >   * Init error handling improvement.
> >      >   * No need to select CPU type on TCG, as only HVF is supported.
> >      >   * Machine type version bumped to 9.2
> >      >   * #include order improved
> >      >
> >      > v5:
> >      >   * Fixed memory reservation for ecam alias region.
> >      >   * Better error handling setting properties on devices.
> >      >   * Simplified the machine ECID/UUID extraction script and
> >     actually created a
> >      >     file for it rather than quoting its code in documentation.
> >      >
> >      > v7:
> >      >   * Tiny error handling fix, un-inlined function.
> >      >
> >      >   MAINTAINERS                 |   1 +
> >      >   contrib/vmapple/uuid.sh     |   9 +
> >      >   docs/system/arm/vmapple.rst |  60 ++++
> >      >   docs/system/target-arm.rst  |   1 +
> >      >   hw/vmapple/Kconfig          |  20 ++
> >      >   hw/vmapple/meson.build      |   1 +
> >      >   hw/vmapple/vmapple.c        | 659 ++++++++++++++++++++++++++++=
+
> >     +++++++
> >      >   7 files changed, 751 insertions(+)
> >      >   create mode 100755 contrib/vmapple/uuid.sh
> >      >   create mode 100644 docs/system/arm/vmapple.rst
> >      >   create mode 100644 hw/vmapple/vmapple.c
> >      >
> >      > diff --git a/MAINTAINERS b/MAINTAINERS
> >      > index 9d0d26cb65f..9591fd44a34 100644
> >      > --- a/MAINTAINERS
> >      > +++ b/MAINTAINERS
> >      > @@ -2767,6 +2767,7 @@ R: Phil Dennis-Jordan <phil@philjordan.eu
> >     <mailto:phil@philjordan.eu>>
> >      >   S: Maintained
> >      >   F: hw/vmapple/*
> >      >   F: include/hw/vmapple/*
> >      > +F: docs/system/arm/vmapple.rst
> >      >
> >      >   Subsystems
> >      >   ----------
> >      > diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
> >      > new file mode 100755
> >      > index 00000000000..956e8c3afed
> >      > --- /dev/null
> >      > +++ b/contrib/vmapple/uuid.sh
> >      > @@ -0,0 +1,9 @@
> >      > +#!/bin/sh
> >      > +# Used for converting a guest provisioned using
> >     Virtualization.framework
> >      > +# for use with the QEMU 'vmapple' aarch64 machine type.
> >      > +#
> >      > +# Extracts the Machine UUID from Virtualization.framework VM
> >     JSON file.
> >      > +# (as produced by 'macosvm', passed as command line argument)
> >      > +
> >      > +plutil -extract machineId raw "$1" | base64 -d | plutil -extrac=
t
> >     ECID raw -
> >      > +
> >      > diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/
> >     vmapple.rst
> >      > new file mode 100644
> >      > index 00000000000..6a634fa4572
> >      > --- /dev/null
> >      > +++ b/docs/system/arm/vmapple.rst
> >      > @@ -0,0 +1,60 @@
> >      > +VMApple machine emulation
> >      >
> >
>  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >      > +
> >      > +VMApple is the device model that the macOS built-in hypervisor
> >     called "Virtualization.framework"
> >      > +exposes to Apple Silicon macOS guests. The "vmapple" machine
> >     model in QEMU implements the same
> >      > +device model, but does not use any code from
> >     Virtualization.Framework.
> >      > +
> >      > +Prerequisites
> >      > +-------------
> >      > +
> >      > +To run the vmapple machine model, you need to
> >      > +
> >      > + * Run on Apple Silicon
> >      > + * Run on macOS 12.0 or above
> >      > + * Have an already installed copy of a Virtualization.Framework
> >     macOS 12 virtual machine. I will
> >      > +   assume that you installed it using the macosvm CLI.
> >      > +
> >      > +First, we need to extract the UUID from the virtual machine tha=
t
> >     you installed. You can do this
> >      > +by running the shell script in contrib/vmapple/uuid.sh on the
> >     macosvm.json file.
> >      > +
> >      > +.. code-block:: bash
> >      > +  :caption: uuid.sh script to extract the UUID from a
> >     macosvm.json file
> >      > +
> >      > +  $ contrib/vmapple/uuid.sh "path/to/macosvm.json"
> >      > +
> >      > +Now we also need to trim the aux partition. It contains metadat=
a
> >     that we can just discard:
> >      > +
> >      > +.. code-block:: bash
> >      > +  :caption: Command to trim the aux file
> >      > +
> >      > +  $ dd if=3D"aux.img" of=3D"aux.img.trimmed" bs=3D$(( 0x4000 ))=
 skip=3D1
> >      > +
> >      > +How to run
> >      > +----------
> >      > +
> >      > +Then, we can launch QEMU with the Virtualization.Framework pre-
> >     boot environment and the readily
> >      > +installed target disk images. I recommend to port forward the
> >     VM's ssh and vnc ports to the host
> >      > +to get better interactive access into the target system:
> >      > +
> >      > +.. code-block:: bash
> >      > +  :caption: Example execution command line
> >      > +
> >      > +  $ UUID=3D$(uuid.sh macosvm.json)
> >      > +  $ AVPBOOTER=3D/System/Library/Frameworks/
> >     Virtualization.framework/Resources/AVPBooter.vmapple2.bin
> >      > +  $ AUX=3Daux.img.trimmed
> >      > +  $ DISK=3Ddisk.img
> >      > +  $ qemu-system-aarch64 \
> >      > +       -serial mon:stdio \
> >      > +       -m 4G \
> >      > +       -accel hvf \
> >      > +       -M vmapple,uuid=3D$UUID \
> >      > +       -bios $AVPBOOTER \
> >      > +        -drive file=3D"$AUX",if=3Dpflash,format=3Draw \
> >      > +        -drive file=3D"$DISK",if=3Dpflash,format=3Draw \
> >      > +       -drive file=3D"$AUX",if=3Dnone,id=3Daux,format=3Draw \
> >      > +       -drive file=3D"$DISK",if=3Dnone,id=3Droot,format=3Draw \
> >      > +       -device vmapple-virtio-aux,drive=3Daux \
> >      > +       -device vmapple-virtio-root,drive=3Droot \
> >      > +       -net
> >     user,ipv6=3Doff,hostfwd=3Dtcp::2222-:22,hostfwd=3Dtcp::5901-:5900 \
> >      > +       -net nic,model=3Dvirtio-net-pci \
> >      > diff --git a/docs/system/target-arm.rst
> b/docs/system/target-arm.rst
> >      > index 9aaa9c414c9..3426f79100b 100644
> >      > --- a/docs/system/target-arm.rst
> >      > +++ b/docs/system/target-arm.rst
> >      > @@ -102,6 +102,7 @@ Board-specific documentation
> >      >      arm/stellaris
> >      >      arm/stm32
> >      >      arm/virt
> >      > +   arm/vmapple
> >      >      arm/xenpvh
> >      >      arm/xlnx-versal-virt
> >      >      arm/xlnx-zynq
> >      > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> >      > index bcd1be63e3c..6a4c4a7fa2e 100644
> >      > --- a/hw/vmapple/Kconfig
> >      > +++ b/hw/vmapple/Kconfig
> >      > @@ -10,3 +10,23 @@ config VMAPPLE_CFG
> >      >   config VMAPPLE_VIRTIO_BLK
> >      >       bool
> >      >
> >      > +config VMAPPLE
> >      > +    bool
> >      > +    depends on ARM
> >      > +    depends on HVF
> >      > +    default y if ARM
> >      > +    imply PCI_DEVICES
> >      > +    select ARM_GIC
> >      > +    select PLATFORM_BUS
> >      > +    select PCI_EXPRESS
> >      > +    select PCI_EXPRESS_GENERIC_BRIDGE
> >      > +    select PL011 # UART
> >      > +    select PL031 # RTC
> >      > +    select PL061 # GPIO
> >      > +    select GPIO_PWR
> >      > +    select PVPANIC_MMIO
> >      > +    select VMAPPLE_AES
> >      > +    select VMAPPLE_BDIF
> >      > +    select VMAPPLE_CFG
> >      > +    select MAC_PVG_MMIO
> >      > +    select VMAPPLE_VIRTIO_BLK
> >      > diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> >      > index bf17cf906c9..e572f7d5602 100644
> >      > --- a/hw/vmapple/meson.build
> >      > +++ b/hw/vmapple/meson.build
> >      > @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_VMAPPLE_AES',
> >     if_true: files('aes.c'))
> >      >   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true:
> >     files('bdif.c'))
> >      >   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true:
> files('cfg.c'))
> >      >   system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true:
> >     files('virtio-blk.c'))
> >      > +specific_ss.add(when: 'CONFIG_VMAPPLE',     if_true:
> >     files('vmapple.c'))
> >      > diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
> >      > new file mode 100644
> >      > index 00000000000..aac3ec35856
> >      > --- /dev/null
> >      > +++ b/hw/vmapple/vmapple.c
> >      > @@ -0,0 +1,659 @@
> >      > +/*
> >      > + * VMApple machine emulation
> >      > + *
> >      > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. Al=
l
> >     Rights Reserved.
> >      > + *
> >      > + * This work is licensed under the terms of the GNU GPL, versio=
n
> >     2 or later.
> >      > + * See the COPYING file in the top-level directory.
> >      > + *
> >      > + * SPDX-License-Identifier: GPL-2.0-or-later
> >      > + *
> >      > + * VMApple is the device model that the macOS built-in
> >     hypervisor called
> >      > + * "Virtualization.framework" exposes to Apple Silicon macOS
> >     guests. The
> >      > + * machine model in this file implements the same device model
> >     in QEMU, but
> >      > + * does not use any code from Virtualization.Framework.
> >      > + */
> >      > +
> >      > +#include "qemu/osdep.h"
> >      > +#include "qemu/bitops.h"
> >      > +#include "qemu/datadir.h"
> >      > +#include "qemu/error-report.h"
> >      > +#include "qemu/guest-random.h"
> >      > +#include "qemu/help-texts.h"
> >      > +#include "qemu/log.h"
> >      > +#include "qemu/module.h"
> >      > +#include "qemu/option.h"
> >      > +#include "qemu/units.h"
> >      > +#include "monitor/qdev.h"
> >      > +#include "hw/boards.h"
> >      > +#include "hw/irq.h"
> >      > +#include "hw/loader.h"
> >      > +#include "hw/qdev-properties.h"
> >      > +#include "hw/sysbus.h"
> >      > +#include "hw/usb.h"
> >      > +#include "hw/arm/boot.h"
> >      > +#include "hw/arm/primecell.h"
> >      > +#include "hw/char/pl011.h"
> >      > +#include "hw/intc/arm_gic.h"
> >      > +#include "hw/intc/arm_gicv3_common.h"
> >      > +#include "hw/misc/pvpanic.h"
> >      > +#include "hw/pci-host/gpex.h"
> >      > +#include "hw/usb/xhci.h"
> >      > +#include "hw/virtio/virtio-pci.h"
> >      > +#include "hw/vmapple/vmapple.h"
> >      > +#include "net/net.h"
> >      > +#include "qapi/error.h"
> >      > +#include "qapi/qmp/qlist.h"
> >      > +#include "qapi/visitor.h"
> >      > +#include "qapi/qapi-visit-common.h"
> >      > +#include "standard-headers/linux/input.h"
> >      > +#include "sysemu/hvf.h"
> >      > +#include "sysemu/kvm.h"
> >      > +#include "sysemu/reset.h"
> >      > +#include "sysemu/runstate.h"
> >      > +#include "sysemu/sysemu.h"
> >      > +#include "target/arm/internals.h"
> >      > +#include "target/arm/kvm_arm.h"
> >      > +
> >      > +struct VMAppleMachineClass {
> >      > +    MachineClass parent;
> >      > +};
> >      > +
> >      > +struct VMAppleMachineState {
> >      > +    MachineState parent;
> >      > +
> >      > +    Notifier machine_done;
> >      > +    struct arm_boot_info bootinfo;
> >      > +    MemMapEntry *memmap;
> >      > +    const int *irqmap;
> >      > +    DeviceState *gic;
> >      > +    DeviceState *cfg;
> >      > +    Notifier powerdown_notifier;
> >      > +    PCIBus *bus;
> >      > +    MemoryRegion fw_mr;
> >      > +    MemoryRegion ecam_alias;
> >      > +    uint64_t uuid;
> >      > +};
> >      > +
> >      > +#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \
> >      > +    static void
> >     vmapple##major##_##minor##_class_init(ObjectClass *oc, \
> >      > +                                                    void *data)=
 \
> >      > +    { \
> >      > +        MachineClass *mc =3D MACHINE_CLASS(oc); \
> >      > +        vmapple_machine_##major##_##minor##_options(mc); \
> >      > +        mc->desc =3D "QEMU " # major "." # minor " Apple Virtua=
l
> >     Machine"; \
> >      > +        if (latest) { \
> >      > +            mc->alias =3D "vmapple"; \
> >      > +        } \
> >      > +    } \
> >      > +    static const TypeInfo machvmapple##major##_##minor##_info =
=3D
> { \
> >      > +        .name =3D MACHINE_TYPE_NAME("vmapple-" # major "." #
> minor), \
> >      > +        .parent =3D TYPE_VMAPPLE_MACHINE, \
> >      > +        .class_init =3D vmapple##major##_##minor##_class_init, =
\
> >      > +    }; \
> >      > +    static void
> machvmapple_machine_##major##_##minor##_init(void) \
> >      > +    { \
> >      > +
> >     type_register_static(&machvmapple##major##_##minor##_info); \
> >      > +    } \
> >      > +    type_init(machvmapple_machine_##major##_##minor##_init);
> >      > +
> >      > +#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(major, minor) \
> >      > +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, true)
> >      > +#define DEFINE_VMAPPLE_MACHINE(major, minor) \
> >      > +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, false)
> >      > +
> >      > +#define TYPE_VMAPPLE_MACHINE   MACHINE_TYPE_NAME("vmapple")
> >      > +OBJECT_DECLARE_TYPE(VMAppleMachineState, VMAppleMachineClass,
> >     VMAPPLE_MACHINE)
> >      > +
> >      > +/* Number of external interrupt lines to configure the GIC with
> */
> >      > +#define NUM_IRQS 256
> >      > +
> >      > +enum {
> >      > +    VMAPPLE_FIRMWARE,
> >      > +    VMAPPLE_CONFIG,
> >      > +    VMAPPLE_MEM,
> >      > +    VMAPPLE_GIC_DIST,
> >      > +    VMAPPLE_GIC_REDIST,
> >      > +    VMAPPLE_UART,
> >      > +    VMAPPLE_RTC,
> >      > +    VMAPPLE_PCIE,
> >      > +    VMAPPLE_PCIE_MMIO,
> >      > +    VMAPPLE_PCIE_ECAM,
> >      > +    VMAPPLE_GPIO,
> >      > +    VMAPPLE_PVPANIC,
> >      > +    VMAPPLE_APV_GFX,
> >      > +    VMAPPLE_APV_IOSFC,
> >      > +    VMAPPLE_AES_1,
> >      > +    VMAPPLE_AES_2,
> >      > +    VMAPPLE_BDOOR,
> >      > +    VMAPPLE_MEMMAP_LAST,
> >      > +};
> >      > +
> >      > +static MemMapEntry memmap[] =3D {
> >      > +    [VMAPPLE_FIRMWARE] =3D           { 0x00100000, 0x00100000 }=
,
> >      > +    [VMAPPLE_CONFIG] =3D             { 0x00400000, 0x00010000 }=
,
> >      > +
> >      > +    [VMAPPLE_GIC_DIST] =3D           { 0x10000000, 0x00010000 }=
,
> >      > +    [VMAPPLE_GIC_REDIST] =3D         { 0x10010000, 0x00400000 }=
,
> >      > +
> >      > +    [VMAPPLE_UART] =3D               { 0x20010000, 0x00010000 }=
,
> >      > +    [VMAPPLE_RTC] =3D                { 0x20050000, 0x00001000 }=
,
> >      > +    [VMAPPLE_GPIO] =3D               { 0x20060000, 0x00001000 }=
,
> >      > +    [VMAPPLE_PVPANIC] =3D            { 0x20070000, 0x00000002 }=
,
> >      > +    [VMAPPLE_BDOOR] =3D              { 0x30000000, 0x00200000 }=
,
> >      > +    [VMAPPLE_APV_GFX] =3D            { 0x30200000, 0x00010000 }=
,
> >      > +    [VMAPPLE_APV_IOSFC] =3D          { 0x30210000, 0x00010000 }=
,
> >      > +    [VMAPPLE_AES_1] =3D              { 0x30220000, 0x00004000 }=
,
> >      > +    [VMAPPLE_AES_2] =3D              { 0x30230000, 0x00004000 }=
,
> >      > +    [VMAPPLE_PCIE_ECAM] =3D          { 0x40000000, 0x10000000 }=
,
> >      > +    [VMAPPLE_PCIE_MMIO] =3D          { 0x50000000, 0x1fff0000 }=
,
> >      > +
> >      > +    /* Actual RAM size depends on configuration */
> >      > +    [VMAPPLE_MEM] =3D                { 0x70000000ULL, GiB},
> >      > +};
> >      > +
> >      > +static const int irqmap[] =3D {
> >      > +    [VMAPPLE_UART] =3D 1,
> >      > +    [VMAPPLE_RTC] =3D 2,
> >      > +    [VMAPPLE_GPIO] =3D 0x5,
> >      > +    [VMAPPLE_APV_IOSFC] =3D 0x10,
> >      > +    [VMAPPLE_APV_GFX] =3D 0x11,
> >      > +    [VMAPPLE_AES_1] =3D 0x12,
> >      > +    [VMAPPLE_PCIE] =3D 0x20,
> >      > +};
> >      > +
> >      > +#define GPEX_NUM_IRQS 16
> >      > +
> >      > +static void create_bdif(VMAppleMachineState *vms, MemoryRegion
> *mem)
> >      > +{
> >      > +    DeviceState *bdif;
> >      > +    SysBusDevice *bdif_sb;
> >      > +    DriveInfo *di_aux =3D drive_get(IF_PFLASH, 0, 0);
> >      > +    DriveInfo *di_root =3D drive_get(IF_PFLASH, 0, 1);
> >      > +
> >      > +    if (!di_aux) {
> >      > +        error_report("No AUX device. Please specify one as
> >     pflash drive.");
> >      > +        exit(1);
> >      > +    }
> >      > +
> >      > +    if (!di_root) {
> >      > +        /* Fall back to the first IF_VIRTIO device as root
> device */
> >      > +        di_root =3D drive_get(IF_VIRTIO, 0, 0);
> >      > +    }
> >      > +
> >      > +    if (!di_root) {
> >      > +        error_report("No root device. Please specify one as
> >     virtio drive.");
> >      > +        exit(1);
> >      > +    }
> >      > +
> >      > +    /* PV backdoor device */
> >      > +    bdif =3D qdev_new(TYPE_VMAPPLE_BDIF);
> >      > +    bdif_sb =3D SYS_BUS_DEVICE(bdif);
> >      > +    sysbus_mmio_map(bdif_sb, 0, vms->memmap[VMAPPLE_BDOOR].base=
);
> >      > +
> >      > +    qdev_prop_set_drive(DEVICE(bdif), "aux",
> >     blk_by_legacy_dinfo(di_aux));
> >      > +    qdev_prop_set_drive(DEVICE(bdif), "root",
> >     blk_by_legacy_dinfo(di_root));
> >      > +
> >      > +    sysbus_realize_and_unref(bdif_sb, &error_fatal);
> >      > +}
> >      > +
> >      > +static void create_pvpanic(VMAppleMachineState *vms,
> >     MemoryRegion *mem)
> >      > +{
> >      > +    SysBusDevice *cfg;
> >      > +
> >      > +    vms->cfg =3D qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
> >      > +    cfg =3D SYS_BUS_DEVICE(vms->cfg);
> >      > +    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_PVPANIC].base);
> >      > +
> >      > +    sysbus_realize_and_unref(cfg, &error_fatal);
> >      > +}
> >      > +
> >      > +static void create_cfg(VMAppleMachineState *vms, MemoryRegion
> *mem)
> >      > +{
> >      > +    SysBusDevice *cfg;
> >      > +    MachineState *machine =3D MACHINE(vms);
> >      > +    uint32_t rnd =3D 1;
> >      > +
> >      > +    vms->cfg =3D qdev_new(TYPE_VMAPPLE_CFG);
> >      > +    cfg =3D SYS_BUS_DEVICE(vms->cfg);
> >      > +    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_CONFIG].base);
> >      > +
> >      > +    qemu_guest_getrandom_nofail(&rnd, sizeof(rnd));
> >      > +
> >      > +    qdev_prop_set_uint32(vms->cfg, "nr-cpus", machine->smp.cpus=
);
> >      > +    qdev_prop_set_uint64(vms->cfg, "ecid", vms->uuid);
> >      > +    qdev_prop_set_uint64(vms->cfg, "ram-size",
> machine->ram_size);
> >      > +    qdev_prop_set_uint32(vms->cfg, "rnd", rnd);
> >      > +
> >      > +    sysbus_realize_and_unref(cfg, &error_fatal);
> >      > +}
> >      > +
> >      > +static void create_gfx(VMAppleMachineState *vms, MemoryRegion
> *mem)
> >      > +{
> >      > +    int irq_gfx =3D vms->irqmap[VMAPPLE_APV_GFX];
> >      > +    int irq_iosfc =3D vms->irqmap[VMAPPLE_APV_IOSFC];
> >      > +    SysBusDevice *gfx;
> >      > +
> >      > +    gfx =3D SYS_BUS_DEVICE(qdev_new("apple-gfx-mmio"));
> >      > +    sysbus_mmio_map(gfx, 0, vms->memmap[VMAPPLE_APV_GFX].base);
> >      > +    sysbus_mmio_map(gfx, 1, vms->memmap[VMAPPLE_APV_IOSFC].base=
);
> >      > +    sysbus_connect_irq(gfx, 0, qdev_get_gpio_in(vms->gic,
> irq_gfx));
> >      > +    sysbus_connect_irq(gfx, 1, qdev_get_gpio_in(vms->gic,
> >     irq_iosfc));
> >      > +    sysbus_realize_and_unref(gfx, &error_fatal);
> >      > +}
> >      > +
> >      > +static void create_aes(VMAppleMachineState *vms, MemoryRegion
> *mem)
> >      > +{
> >      > +    int irq =3D vms->irqmap[VMAPPLE_AES_1];
> >      > +    SysBusDevice *aes;
> >      > +
> >      > +    aes =3D SYS_BUS_DEVICE(qdev_new(TYPE_APPLE_AES));
> >      > +    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_AES_1].base);
> >      > +    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_AES_2].base);
> >      > +    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq))=
;
> >      > +    sysbus_realize_and_unref(aes, &error_fatal);
> >      > +}
> >      > +
> >      > +static int arm_gic_ppi_index(int cpu_nr, int ppi_index)
> >      > +{
> >      > +    return NUM_IRQS + cpu_nr * GIC_INTERNAL + ppi_index;
> >      > +}
> >      > +
> >      > +static void create_gic(VMAppleMachineState *vms, MemoryRegion
> *mem)
> >      > +{
> >      > +    MachineState *ms =3D MACHINE(vms);
> >      > +    /* We create a standalone GIC */
> >      > +    SysBusDevice *gicbusdev;
> >      > +    QList *redist_region_count;
> >      > +    int i;
> >      > +    unsigned int smp_cpus =3D ms->smp.cpus;
> >      > +
> >      > +    vms->gic =3D qdev_new(gicv3_class_name());
> >      > +    qdev_prop_set_uint32(vms->gic, "revision", 3);
> >      > +    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
> >      > +    /*
> >      > +     * Note that the num-irq property counts both internal and
> >     external
> >      > +     * interrupts; there are always 32 of the former (mandated
> >     by GIC spec).
> >      > +     */
> >      > +    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
> >      > +
> >      > +    uint32_t redist0_capacity =3D
> >      > +                vms->memmap[VMAPPLE_GIC_REDIST].size /
> >     GICV3_REDIST_SIZE;
> >      > +    uint32_t redist0_count =3D MIN(smp_cpus, redist0_capacity);
> >      > +
> >      > +    redist_region_count =3D qlist_new();
> >      > +    qlist_append_int(redist_region_count, redist0_count);
> >      > +    qdev_prop_set_array(vms->gic, "redist-region-count",
> >     redist_region_count);
> >      > +
> >      > +    gicbusdev =3D SYS_BUS_DEVICE(vms->gic);
> >      > +    sysbus_realize_and_unref(gicbusdev, &error_fatal);
> >      > +    sysbus_mmio_map(gicbusdev, 0, vms-
> >      >memmap[VMAPPLE_GIC_DIST].base);
> >      > +    sysbus_mmio_map(gicbusdev, 1, vms-
> >      >memmap[VMAPPLE_GIC_REDIST].base);
> >      > +
> >      > +    /*
> >      > +     * Wire the outputs from each CPU's generic timer and the
> GICv3
> >      > +     * maintenance interrupt signal to the appropriate GIC PPI
> >     inputs,
> >      > +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the
> >     CPU's inputs.
> >      > +     */
> >      > +    for (i =3D 0; i < smp_cpus; i++) {
> >      > +        DeviceState *cpudev =3D DEVICE(qemu_get_cpu(i));
> >      > +
> >      > +        /* Map the virt timer to PPI 27 */
> >      > +        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
> >      > +                              qdev_get_gpio_in(vms->gic,
> >      > +
> >       arm_gic_ppi_index(i, 27)));
> >      > +
> >      > +        /* Map the GIC IRQ and FIQ lines to CPU */
> >      > +        sysbus_connect_irq(gicbusdev, i,
> >     qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> >      > +        sysbus_connect_irq(gicbusdev, i + smp_cpus,
> >      > +                           qdev_get_gpio_in(cpudev,
> ARM_CPU_FIQ));
> >      > +    }
> >      > +}
> >      > +
> >      > +static void create_uart(const VMAppleMachineState *vms, int uar=
t,
> >      > +                        MemoryRegion *mem, Chardev *chr)
> >      > +{
> >      > +    hwaddr base =3D vms->memmap[uart].base;
> >      > +    int irq =3D vms->irqmap[uart];
> >      > +    DeviceState *dev =3D qdev_new(TYPE_PL011);
> >      > +    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> >      > +
> >      > +    qdev_prop_set_chr(dev, "chardev", chr);
> >      > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal)=
;
> >      > +    memory_region_add_subregion(mem, base,
> >      > +                                sysbus_mmio_get_region(s, 0));
> >      > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> >      > +}
> >      > +
> >      > +static void create_rtc(const VMAppleMachineState *vms)
> >      > +{
> >      > +    hwaddr base =3D vms->memmap[VMAPPLE_RTC].base;
> >      > +    int irq =3D vms->irqmap[VMAPPLE_RTC];
> >      > +
> >      > +    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms-
> >      >gic, irq));
> >      > +}
> >      > +
> >      > +static DeviceState *gpio_key_dev;
> >      > +static void vmapple_powerdown_req(Notifier *n, void *opaque)
> >      > +{
> >      > +    /* use gpio Pin 3 for power button event */
> >      > +    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
> >      > +}
> >      > +
> >      > +static void create_gpio_devices(const VMAppleMachineState *vms,
> >     int gpio,
> >      > +                                MemoryRegion *mem)
> >      > +{
> >      > +    DeviceState *pl061_dev;
> >      > +    hwaddr base =3D vms->memmap[gpio].base;
> >      > +    int irq =3D vms->irqmap[gpio];
> >      > +    SysBusDevice *s;
> >      > +
> >      > +    pl061_dev =3D qdev_new("pl061");
> >      > +    /* Pull lines down to 0 if not driven by the PL061 */
> >      > +    qdev_prop_set_uint32(pl061_dev, "pullups", 0);
> >      > +    qdev_prop_set_uint32(pl061_dev, "pulldowns", 0xff);
> >      > +    s =3D SYS_BUS_DEVICE(pl061_dev);
> >      > +    sysbus_realize_and_unref(s, &error_fatal);
> >      > +    memory_region_add_subregion(mem, base,
> >     sysbus_mmio_get_region(s, 0));
> >      > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> >      > +    gpio_key_dev =3D sysbus_create_simple("gpio-key", -1,
> >      > +
> >     qdev_get_gpio_in(pl061_dev, 3));
> >      > +}
> >      > +
> >      > +static void vmapple_firmware_init(VMAppleMachineState *vms,
> >      > +                                  MemoryRegion *sysmem)
> >      > +{
> >      > +    hwaddr size =3D vms->memmap[VMAPPLE_FIRMWARE].size;
> >      > +    hwaddr base =3D vms->memmap[VMAPPLE_FIRMWARE].base;
> >      > +    const char *bios_name;
> >      > +    int image_size;
> >      > +    char *fname;
> >      > +
> >      > +    bios_name =3D MACHINE(vms)->firmware;
> >      > +    if (!bios_name) {
> >      > +        error_report("No firmware specified");
> >      > +        exit(1);
> >      > +    }
> >      > +
> >      > +    fname =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> >      > +    if (!fname) {
> >      > +        error_report("Could not find ROM image '%s'", bios_name=
);
> >      > +        exit(1);
> >      > +    }
> >      > +
> >      > +    memory_region_init_ram(&vms->fw_mr, NULL, "firmware", size,
> >     &error_fatal);
> >      > +    image_size =3D load_image_mr(fname, &vms->fw_mr);
> >      > +
> >      > +    g_free(fname);
> >      > +    if (image_size < 0) {
> >      > +        error_report("Could not load ROM image '%s'", bios_name=
);
> >      > +        exit(1);
> >      > +    }
> >      > +
> >      > +    memory_region_add_subregion(get_system_memory(), base, &vms=
-
> >      >fw_mr);
> >      > +}
> >      > +
> >      > +static void create_pcie(VMAppleMachineState *vms)
> >      > +{
> >      > +    hwaddr base_mmio =3D vms->memmap[VMAPPLE_PCIE_MMIO].base;
> >      > +    hwaddr size_mmio =3D vms->memmap[VMAPPLE_PCIE_MMIO].size;
> >      > +    hwaddr base_ecam =3D vms->memmap[VMAPPLE_PCIE_ECAM].base;
> >      > +    hwaddr size_ecam =3D vms->memmap[VMAPPLE_PCIE_ECAM].size;
> >      > +    int irq =3D vms->irqmap[VMAPPLE_PCIE];
> >      > +    MemoryRegion *mmio_alias;
> >      > +    MemoryRegion *mmio_reg;
> >      > +    MemoryRegion *ecam_reg;
> >      > +    DeviceState *dev;
> >      > +    int i;
> >      > +    PCIHostState *pci;
> >      > +    DeviceState *usb_controller;
> >      > +    USBBus *usb_bus;
> >      > +
> >      > +    dev =3D qdev_new(TYPE_GPEX_HOST);
> >      > +    qdev_prop_set_uint32(dev, "num-irqs", GPEX_NUM_IRQS);
> >      > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal)=
;
> >      > +
> >      > +    /* Map only the first size_ecam bytes of ECAM space */
> >      > +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0)=
;
> >      > +    memory_region_init_alias(&vms->ecam_alias, OBJECT(dev),
> >     "pcie-ecam",
> >      > +                             ecam_reg, 0, size_ecam);
> >      > +    memory_region_add_subregion(get_system_memory(), base_ecam,
> >      > +                                &vms->ecam_alias);
> >      > +
> >      > +    /*
> >      > +     * Map the MMIO window from [0x50000000-0x7fff0000] in PCI
> >     space into
> >      > +     * system address space at [0x50000000-0x7fff0000].
> >      > +     */
> >      > +    mmio_alias =3D g_new0(MemoryRegion, 1);
> >      > +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1)=
;
> >      > +    memory_region_init_alias(mmio_alias, OBJECT(dev),
> "pcie-mmio",
> >      > +                             mmio_reg, base_mmio, size_mmio);
> >      > +    memory_region_add_subregion(get_system_memory(), base_mmio,
> >     mmio_alias);
> >      > +
> >      > +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> >      > +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> >      > +                           qdev_get_gpio_in(vms->gic, irq + i))=
;
> >      > +        gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> >      > +    }
> >      > +
> >      > +    pci =3D PCI_HOST_BRIDGE(dev);
> >      > +    vms->bus =3D pci->bus;
> >      > +    g_assert(vms->bus);
> >      > +
> >      > +    while ((dev =3D qemu_create_nic_device("virtio-net-pci", tr=
ue,
> >     NULL))) {
> >      > +        qdev_realize_and_unref(dev, BUS(vms->bus), &error_fatal=
);
> >      > +    }
> >      > +
> >      > +    usb_controller =3D qdev_new(TYPE_QEMU_XHCI);
> >      > +    qdev_realize_and_unref(usb_controller, BUS(pci->bus),
> >     &error_fatal);
> >      > +
> >      > +    usb_bus =3D
> USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
> >      > +
> >     &error_fatal));
> >      > +    usb_create_simple(usb_bus, "usb-kbd");
> >      > +    usb_create_simple(usb_bus, "usb-tablet");
> >      > +}
> >      > +
> >      > +static void vmapple_reset(void *opaque)
> >      > +{
> >      > +    VMAppleMachineState *vms =3D opaque;
> >      > +    hwaddr base =3D vms->memmap[VMAPPLE_FIRMWARE].base;
> >      > +
> >      > +    cpu_set_pc(first_cpu, base);
> >      > +}
> >      > +
> >      > +static void mach_vmapple_init(MachineState *machine)
> >      > +{
> >      > +    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(machine);
> >      > +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >      > +    const CPUArchIdList *possible_cpus;
> >      > +    MemoryRegion *sysmem =3D get_system_memory();
> >      > +    int n;
> >      > +    unsigned int smp_cpus =3D machine->smp.cpus;
> >      > +    unsigned int max_cpus =3D machine->smp.max_cpus;
> >      > +
> >      > +    vms->memmap =3D memmap;
> >      > +    machine->usb =3D true;
> >      > +
> >      > +    possible_cpus =3D mc->possible_cpu_arch_ids(machine);
> >      > +    assert(possible_cpus->len =3D=3D max_cpus);
> >      > +    for (n =3D 0; n < possible_cpus->len; n++) {
> >      > +        Object *cpu;
> >      > +        CPUState *cs;
> >      > +
> >      > +        if (n >=3D smp_cpus) {
> >      > +            break;
> >      > +        }
> >      > +
> >      > +        cpu =3D object_new(possible_cpus->cpus[n].type);
> >      > +        object_property_set_int(cpu, "mp-affinity",
> >      > +                                possible_cpus->cpus[n].arch_id,
> >     &error_fatal);
> >      > +
> >      > +        cs =3D CPU(cpu);
> >      > +        cs->cpu_index =3D n;
> >      > +
> >      > +        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index],
> >     DEVICE(cpu),
> >      > +                          &error_fatal);
> >      > +
> >      > +        if (object_property_find(cpu, "has_el3")) {
> >      > +            object_property_set_bool(cpu, "has_el3", false,
> >     &error_fatal);
> >      > +        }
> >      > +        if (object_property_find(cpu, "has_el2")) {
> >      > +            object_property_set_bool(cpu, "has_el2", false,
> >     &error_fatal);
> >      > +        }
> >      > +        object_property_set_int(cpu, "psci-conduit",
> >     QEMU_PSCI_CONDUIT_HVC,
> >      > +                                &error_fatal);
> >      > +
> >      > +        /* Secondary CPUs start in PSCI powered-down state */
> >      > +        if (n > 0) {
> >      > +            object_property_set_bool(cpu, "start-powered-off",
> true,
> >      > +                                     &error_fatal);
> >      > +        }
> >      > +
> >      > +        object_property_set_link(cpu, "memory", OBJECT(sysmem),
> >     &error_abort);
> >      > +        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> >      > +        object_unref(cpu);
> >      > +    }
> >      > +
> >      > +    memory_region_add_subregion(sysmem, vms-
> >      >memmap[VMAPPLE_MEM].base,
> >      > +                                machine->ram);
> >      > +
> >      > +    create_gic(vms, sysmem);
> >      > +    create_bdif(vms, sysmem);
> >      > +    create_pvpanic(vms, sysmem);
> >      > +    create_aes(vms, sysmem);
> >      > +    create_gfx(vms, sysmem);
> >      > +    create_uart(vms, VMAPPLE_UART, sysmem, serial_hd(0));
> >      > +    create_rtc(vms);
> >      > +    create_pcie(vms);
> >      > +
> >      > +    create_gpio_devices(vms, VMAPPLE_GPIO, sysmem);
> >      > +
> >      > +    vmapple_firmware_init(vms, sysmem);
> >      > +    create_cfg(vms, sysmem);
> >      > +
> >      > +    /* connect powerdown request */
> >      > +    vms->powerdown_notifier.notify =3D vmapple_powerdown_req;
> >      > +    qemu_register_powerdown_notifier(&vms->powerdown_notifier);
> >      > +
> >      > +    vms->bootinfo.ram_size =3D machine->ram_size;
> >      > +    vms->bootinfo.board_id =3D -1;
> >      > +    vms->bootinfo.loader_start =3D vms->memmap[VMAPPLE_MEM].bas=
e;
> >      > +    vms->bootinfo.skip_dtb_autoload =3D true;
> >      > +    vms->bootinfo.firmware_loaded =3D true;
> >      > +    arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo=
);
> >      > +
> >      > +    qemu_register_reset(vmapple_reset, vms);
> >      > +}
> >      > +
> >      > +static CpuInstanceProperties
> >      > +vmapple_cpu_index_to_props(MachineState *ms, unsigned cpu_index=
)
> >      > +{
> >      > +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> >      > +    const CPUArchIdList *possible_cpus =3D mc-
> >      >possible_cpu_arch_ids(ms);
> >      > +
> >      > +    assert(cpu_index < possible_cpus->len);
> >      > +    return possible_cpus->cpus[cpu_index].props;
> >      > +}
> >      > +
> >      > +
> >      > +static int64_t vmapple_get_default_cpu_node_id(const
> >     MachineState *ms, int idx)
> >      > +{
> >      > +    return idx % ms->numa_state->num_nodes;
> >      > +}
> >      > +
> >      > +static const CPUArchIdList
> >     *vmapple_possible_cpu_arch_ids(MachineState *ms)
> >      > +{
> >      > +    int n;
> >      > +    unsigned int max_cpus =3D ms->smp.max_cpus;
> >      > +
> >      > +    if (ms->possible_cpus) {
> >      > +        assert(ms->possible_cpus->len =3D=3D max_cpus);
> >      > +        return ms->possible_cpus;
> >      > +    }
> >      > +
> >      > +    ms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> >      > +                                  sizeof(CPUArchId) * max_cpus)=
;
> >      > +    ms->possible_cpus->len =3D max_cpus;
> >      > +    for (n =3D 0; n < ms->possible_cpus->len; n++) {
> >      > +        ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
> >      > +        ms->possible_cpus->cpus[n].arch_id =3D
> >      > +            arm_build_mp_affinity(n, GICV3_TARGETLIST_BITS);
> >      > +        ms->possible_cpus->cpus[n].props.has_thread_id =3D true=
;
> >      > +        ms->possible_cpus->cpus[n].props.thread_id =3D n;
> >      > +    }
> >      > +    return ms->possible_cpus;
> >      > +}
> >      > +
> >      > +static void vmapple_get_uuid(Object *obj, Visitor *v, const cha=
r
> >     *name,
> >      > +                             void *opaque, Error **errp)
> >      > +{
> >      > +    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);
> >      > +
> >      > +    visit_type_uint64(v, name, &vms->uuid, errp);
> >      > +}
> >      > +
> >      > +static void vmapple_set_uuid(Object *obj, Visitor *v, const cha=
r
> >     *name,
> >      > +                             void *opaque, Error **errp)
> >      > +{
> >      > +    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);
> >      > +    Error *error =3D NULL;
> >      > +
> >      > +    visit_type_uint64(v, name, &vms->uuid, &error);
> >      > +    if (error) {
> >      > +        error_propagate(errp, error);
> >      > +        return;
> >      > +    }
> >      > +}
> >      > +
> >      > +static void vmapple_machine_class_init(ObjectClass *oc, void
> *data)
> >      > +{
> >      > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> >      > +
> >      > +    mc->init =3D mach_vmapple_init;
> >      > +    mc->max_cpus =3D 32;
> >      > +    mc->block_default_type =3D IF_VIRTIO;
> >      > +    mc->no_cdrom =3D 1;
> >      > +    mc->pci_allow_0_address =3D true;
> >      > +    mc->minimum_page_bits =3D 12;
> >      > +    mc->possible_cpu_arch_ids =3D vmapple_possible_cpu_arch_ids=
;
> >      > +    mc->cpu_index_to_instance_props =3D vmapple_cpu_index_to_pr=
ops;
> >      > +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("host");
> >      > +    mc->get_default_cpu_node_id =3D
> vmapple_get_default_cpu_node_id;
> >      > +    mc->default_ram_id =3D "mach-vmapple.ram";
> >      > +
> >      > +    object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy=
",
> >      > +                               "on", true);
> >      > +
> >      > +    object_class_property_add(oc, "uuid", "uint64",
> >     vmapple_get_uuid,
> >      > +                              vmapple_set_uuid, NULL, NULL);
> >
> >     Use: object_class_property_add_uint64_ptr
> >
> >
> > Do I understand correctly that to use this, I need to move the uuid
> > field out of VMAppleMachineState and turn it into a global/static
> > variable? There are no active uses of
> > object_class_property_add_uint64_ptr (or the uint32 version) in the Qem=
u
> > code base to use as reference, but that's what it looks like based on
> > the single use of object_class_property_add_uint8_ptr.
> >
> > I'm not convinced this is an improvement to be honest. (And the lack of
> > uptake of this API would suggest I'm not the only one who finds this an
> > awkward API - on the other hand, there are lots of examples of
> > object_class_property_add() being used for uint64-typed properties
> > exactly as Alex has done here.)
>
> I didn't mean to add a class property. object_property_add_uint64_ptr()
> will do what we want I think.
>

As far as I can tell, "class property" in general just means the
getter/setter is automatically provided for all instances of the class,
which *is* what we want, but the object_class_property_add_*_ptr() helper
functions isn't suitable for genuine per-instance values.

The object property created with object_property_add_uint64_ptr() (no
"class") applies to only that object instance, so it needs to be done
during instance init. It does seem to work in this case at least, and a
bunch of other machine types also use it in a similar way, so I'll use it.

I had a quick look to see if we could make this tidier with a macro that
uses offsetof() or so. I think it's possible, but making it safe isn't
straightforward; in any case, that improvement is out of scope here.
Another option would be to auto-generate getter/setter functions from a
macro, which would contain the correct struct field access expression
expansion. Probably also not ideal, however.

Regards,
Phil

--00000000000027ac9e0626436a97
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, 6 Nov 2024 at 10:16, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 2024/11/06 18:10, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, 6 Nov 2024 at 08:42, Akihiko Odaki &lt;<a href=3D"mailto:akihi=
ko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2024/11/06 0:30, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; From: Alexander Graf &lt;<a href=3D"mailto:gr=
af@amazon.com" target=3D"_blank">graf@amazon.com</a> &lt;mailto:<a href=3D"=
mailto:graf@amazon.com" target=3D"_blank">graf@amazon.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Apple defines a new &quot;vmapple&quot; machi=
ne type as part of its proprietary<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; macOS Virtualization.Framework vmm. This mach=
ine type is similar<br>
&gt;=C2=A0 =C2=A0 =C2=A0to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; virt one, but with subtle differences in base=
 devices, a few special<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; vmapple device additions and a vastly differe=
nt boot chain.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This patch reimplements this machine type in =
QEMU. To use it, you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; have to have a readily installed version of m=
acOS for VMApple,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; run on macOS with -accel hvf, pass the Virtua=
lization.Framework<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; boot rom (AVPBooter) in via -bios, pass the a=
ux and root volume<br>
&gt;=C2=A0 =C2=A0 =C2=A0as pflash<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; and pass aux and root volume as virtio drives=
. In addition, you also<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; need to find the machine UUID and pass that a=
s -M vmapple,uuid=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0parameter:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ qemu-system-aarch64 -accel hvf -M vmapple,u=
uid=3D0x1234 -m 4G \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 -bios /System/Library/Fra=
meworks/Virtualization.framework/<br>
&gt;=C2=A0 =C2=A0 =C2=A0Versions/A/Resources/AVPBooter.vmapple2.bin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dpf=
lash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dp=
flash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dno=
ne,id=3Daux,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-au=
x,drive=3Daux \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dn=
one,id=3Droot,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-ro=
ot,drive=3Droot<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; With all these in place, you should be able t=
o see macOS booting<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; successfully.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Known issues:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0- Keyboard and mouse/tablet input=
 is laggy. The reason for this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0either that macOS&#39;s XH=
CI driver is broken when the device/<br>
&gt;=C2=A0 =C2=A0 =C2=A0platform<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0does not support MSI/MSI-X=
, or there&#39;s some unfortunate interplay<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0with Qemu&#39;s XHCI imple=
mentation in this scenario.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0- Currently only macOS 12 guests =
are supported. The boot<br>
&gt;=C2=A0 =C2=A0 =C2=A0process for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A013+ will need further inve=
stigation and adjustment.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Alexander Graf &lt;<a href=3D"=
mailto:graf@amazon.com" target=3D"_blank">graf@amazon.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:graf@amazon.com" targe=
t=3D"_blank">graf@amazon.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Co-authored-by: Phil Dennis-Jordan &lt;<a hre=
f=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a><br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=
=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v3:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Rebased on latest upstream, upd=
ated affinity and NIC creation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; API usage<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Included Apple-variant virtio-b=
lk in build dependency<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Updated API usage for setting &=
#39;redist-region-count&#39; array-<br>
&gt;=C2=A0 =C2=A0 =C2=A0typed property on GIC.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Switched from virtio HID device=
s (for which macOS 12 does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0contain<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0drivers) to an XHCI USB co=
ntroller and USB HID devices.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v4:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Fixups for v4 changes to the ot=
her patches in the set.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Corrected the assert macro to u=
se<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Removed superfluous endian conv=
ersions corresponding to cfg&#39;s.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Init error handling improvement=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* No need to select CPU type on T=
CG, as only HVF is supported.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Machine type version bumped to =
9.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* #include order improved<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v5:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Fixed memory reservation for ec=
am alias region.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Better error handling setting p=
roperties on devices.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Simplified the machine ECID/UUI=
D extraction script and<br>
&gt;=C2=A0 =C2=A0 =C2=A0actually created a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0file for it rather than qu=
oting its code in documentation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v7:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Tiny error handling fix, un-inl=
ined function.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0contrib/vmapple/uuid.sh=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0docs/system/arm/vmapple.rst |=C2=
=A0 60 ++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0docs/system/target-arm.rst=C2=A0 =
|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 20 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/vmapple/vmapple.c=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 659 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A07 files changed, 751 insertions(+=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100755 contrib/vmappl=
e/uuid.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 docs/system/ar=
m/vmapple.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/vma=
pple.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 9d0d26cb65f..9591fd44a34 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/MAINTAINERS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/MAINTAINERS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2767,6 +2767,7 @@ R: Phil Dennis-Jordan &=
lt;<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.=
eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0S: Maintained<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0F: hw/vmapple/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0F: include/hw/vmapple/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +F: docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0Subsystems<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0----------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/contrib/vmapple/uuid.sh b/contri=
b/vmapple/uuid.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100755<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..956e8c3afed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/contrib/vmapple/uuid.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,9 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#!/bin/sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# Used for converting a guest provisioned us=
ing<br>
&gt;=C2=A0 =C2=A0 =C2=A0Virtualization.framework<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# for use with the QEMU &#39;vmapple&#39; aa=
rch64 machine type.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# Extracts the Machine UUID from Virtualizat=
ion.framework VM<br>
&gt;=C2=A0 =C2=A0 =C2=A0JSON file.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# (as produced by &#39;macosvm&#39;, passed =
as command line argument)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +plutil -extract machineId raw &quot;$1&quot;=
 | base64 -d | plutil -extract<br>
&gt;=C2=A0 =C2=A0 =C2=A0ECID raw -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/docs/system/arm/vmapple.rst b/do=
cs/system/arm/<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmapple.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..6a634fa4572<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,60 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +VMApple machine emulation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +VMApple is the device model that the macOS b=
uilt-in hypervisor<br>
&gt;=C2=A0 =C2=A0 =C2=A0called &quot;Virtualization.framework&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +exposes to Apple Silicon macOS guests. The &=
quot;vmapple&quot; machine<br>
&gt;=C2=A0 =C2=A0 =C2=A0model in QEMU implements the same<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +device model, but does not use any code from=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0Virtualization.Framework.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Prerequisites<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +-------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +To run the vmapple machine model, you need t=
o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Run on Apple Silicon<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Run on macOS 12.0 or above<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Have an already installed copy of a Virtu=
alization.Framework<br>
&gt;=C2=A0 =C2=A0 =C2=A0macOS 12 virtual machine. I will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0assume that you installed it us=
ing the macosvm CLI.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +First, we need to extract the UUID from the =
virtual machine that<br>
&gt;=C2=A0 =C2=A0 =C2=A0you installed. You can do this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +by running the shell script in contrib/vmapp=
le/uuid.sh on the<br>
&gt;=C2=A0 =C2=A0 =C2=A0macosvm.json file.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. code-block:: bash<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 :caption: uuid.sh script to extract t=
he UUID from a<br>
&gt;=C2=A0 =C2=A0 =C2=A0macosvm.json file<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 $ contrib/vmapple/uuid.sh &quot;path/=
to/macosvm.json&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Now we also need to trim the aux partition. =
It contains metadata<br>
&gt;=C2=A0 =C2=A0 =C2=A0that we can just discard:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. code-block:: bash<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 :caption: Command to trim the aux fil=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 $ dd if=3D&quot;aux.img&quot; of=3D&q=
uot;aux.img.trimmed&quot; bs=3D$(( 0x4000 )) skip=3D1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +How to run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +----------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Then, we can launch QEMU with the Virtualiza=
tion.Framework pre-<br>
&gt;=C2=A0 =C2=A0 =C2=A0boot environment and the readily<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +installed target disk images. I recommend to=
 port forward the<br>
&gt;=C2=A0 =C2=A0 =C2=A0VM&#39;s ssh and vnc ports to the host<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +to get better interactive access into the ta=
rget system:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +.. code-block:: bash<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 :caption: Example execution command l=
ine<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 $ UUID=3D$(uuid.sh macosvm.json)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 $ AVPBOOTER=3D/System/Library/Framewo=
rks/<br>
&gt;=C2=A0 =C2=A0 =C2=A0Virtualization.framework/Resources/AVPBooter.vmappl=
e2.bin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 $ AUX=3Daux.img.trimmed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 $ DISK=3Ddisk.img<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 $ qemu-system-aarch64 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-serial mon:stdio=
 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-m 4G \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-accel hvf \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-M vmapple,uuid=
=3D$UUID \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-bios $AVPBOOTER =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 -drive file=3D&q=
uot;$AUX&quot;,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 -drive file=3D&q=
uot;$DISK&quot;,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&qu=
ot;$AUX&quot;,if=3Dnone,id=3Daux,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&qu=
ot;$DISK&quot;,if=3Dnone,id=3Droot,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmapple-v=
irtio-aux,drive=3Daux \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmapple-v=
irtio-root,drive=3Droot \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-net<br>
&gt;=C2=A0 =C2=A0 =C2=A0user,ipv6=3Doff,hostfwd=3Dtcp::2222-:22,hostfwd=3Dt=
cp::5901-:5900 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-net nic,model=3D=
virtio-net-pci \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/docs/system/target-arm.rst b/doc=
s/system/target-arm.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 9aaa9c414c9..3426f79100b 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/docs/system/target-arm.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/docs/system/target-arm.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -102,6 +102,7 @@ Board-specific documentat=
ion<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 arm/stellaris<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 arm/stm32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 arm/virt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0arm/vmapple<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 arm/xenpvh<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 arm/xlnx-versal-virt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 arm/xlnx-zynq<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/=
Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index bcd1be63e3c..6a4c4a7fa2e 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -10,3 +10,23 @@ config VMAPPLE_CFG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0config VMAPPLE_VIRTIO_BLK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +config VMAPPLE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 depends on ARM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 depends on HVF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 default y if ARM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select ARM_GIC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PLATFORM_BUS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PCI_EXPRESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PCI_EXPRESS_GENERIC_BRI=
DGE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PL011 # UART<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PL031 # RTC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PL061 # GPIO<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select GPIO_PWR<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PVPANIC_MMIO<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select VMAPPLE_AES<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select VMAPPLE_BDIF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select VMAPPLE_CFG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select MAC_PVG_MMIO<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select VMAPPLE_VIRTIO_BLK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/meson.build b/hw/vmap=
ple/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index bf17cf906c9..e572f7d5602 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/vmapple/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2,3 +2,4 @@ system_ss.add(when: &#39;CONF=
IG_VMAPPLE_AES&#39;, <br>
&gt;=C2=A0 =C2=A0 =C2=A0if_true: files(&#39;aes.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_V=
MAPPLE_BDIF&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;bdif.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_V=
MAPPLE_CFG&#39;,=C2=A0 if_true: files(&#39;cfg.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_V=
MAPPLE_VIRTIO_BLK&#39;,=C2=A0 if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;virtio-blk.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +specific_ss.add(when: &#39;CONFIG_VMAPPLE&#3=
9;,=C2=A0 =C2=A0 =C2=A0if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;vmapple.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/vmapple.c b/hw/vmappl=
e/vmapple.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..aac3ec35856<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/vmapple.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,659 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * VMApple machine emulation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or=
 its affiliates. All<br>
&gt;=C2=A0 =C2=A0 =C2=A0Rights Reserved.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This work is licensed under the terms of =
the GNU GPL, version<br>
&gt;=C2=A0 =C2=A0 =C2=A02 or later.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * See the COPYING file in the top-level dir=
ectory.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * SPDX-License-Identifier: GPL-2.0-or-later=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * VMApple is the device model that the macO=
S built-in<br>
&gt;=C2=A0 =C2=A0 =C2=A0hypervisor called<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * &quot;Virtualization.framework&quot; expo=
ses to Apple Silicon macOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0guests. The<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * machine model in this file implements the=
 same device model<br>
&gt;=C2=A0 =C2=A0 =C2=A0in QEMU, but<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * does not use any code from Virtualization=
.Framework.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/datadir.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/guest-random.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/help-texts.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/log.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/option.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/units.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;monitor/qdev.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/boards.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/irq.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/loader.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/qdev-properties.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/usb.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/arm/boot.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/arm/primecell.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/char/pl011.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/intc/arm_gic.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/intc/arm_gicv3_common.h&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/misc/pvpanic.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/pci-host/gpex.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/usb/xhci.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/virtio/virtio-pci.h&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/vmapple/vmapple.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;net/net.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/qmp/qlist.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/qapi-visit-common.h&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;standard-headers/linux/input.=
h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;sysemu/hvf.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;sysemu/kvm.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;sysemu/reset.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;sysemu/runstate.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;target/arm/internals.h&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;target/arm/kvm_arm.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +struct VMAppleMachineClass {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MachineClass parent;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +struct VMAppleMachineState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MachineState parent;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 Notifier machine_done;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 struct arm_boot_info bootinfo;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemMapEntry *memmap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 const int *irqmap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceState *gic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceState *cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 Notifier powerdown_notifier;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PCIBus *bus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion fw_mr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion ecam_alias;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t uuid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define DEFINE_VMAPPLE_MACHINE_LATEST(major,=
 minor, latest) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmapple##major##_##minor##_class_init(ObjectClass *=
oc, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *da=
ta) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 { \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MachineClass *mc=
 =3D MACHINE_CLASS(oc); \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmapple_machine_=
##major##_##minor##_options(mc); \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;desc =3D =
&quot;QEMU &quot; # major &quot;.&quot; # minor &quot; Apple Virtual<br>
&gt;=C2=A0 =C2=A0 =C2=A0Machine&quot;; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (latest) { \<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mc=
-&gt;alias =3D &quot;vmapple&quot;; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 static const TypeInfo machvmap=
ple##major##_##minor##_info =3D { \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D MACHIN=
E_TYPE_NAME(&quot;vmapple-&quot; # major &quot;.&quot; # minor), \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE=
_VMAPPLE_MACHINE, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D =
vmapple##major##_##minor##_class_init, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 static void machvmapple_machin=
e_##major##_##minor##_init(void) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 { \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;machvmapple##major##_##mi=
nor##_info); \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 type_init(machvmapple_machine_=
##major##_##minor##_init);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(maj=
or, minor) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_VMAPPLE_MACHINE_LATEST(=
major, minor, true)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define DEFINE_VMAPPLE_MACHINE(major, minor)=
 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_VMAPPLE_MACHINE_LATEST(=
major, minor, false)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define TYPE_VMAPPLE_MACHINE=C2=A0 =C2=A0MAC=
HINE_TYPE_NAME(&quot;vmapple&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +OBJECT_DECLARE_TYPE(VMAppleMachineState, VMA=
ppleMachineClass,<br>
&gt;=C2=A0 =C2=A0 =C2=A0VMAPPLE_MACHINE)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/* Number of external interrupt lines to con=
figure the GIC with */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define NUM_IRQS 256<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_FIRMWARE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_CONFIG,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_MEM,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_GIC_DIST,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_GIC_REDIST,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_UART,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_RTC,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_PCIE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_PCIE_MMIO,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_PCIE_ECAM,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_GPIO,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_PVPANIC,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_APV_GFX,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_APV_IOSFC,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_AES_1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_AES_2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_BDOOR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAPPLE_MEMMAP_LAST,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static MemMapEntry memmap[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_FIRMWARE] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x00100000, 0x00100000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_CONFIG] =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x00400000, 0x00010000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_GIC_DIST] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x10000000, 0x00010000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_GIC_REDIST] =3D=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x10010000, 0x00400000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_UART] =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x20010000, 0x00010000 },<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_RTC] =3D=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x20050000, 0x00001000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_GPIO] =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x20060000, 0x00001000 },<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_PVPANIC] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x20070000, 0x00000002 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_BDOOR] =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30000000, 0x00200000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_GFX] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30200000, 0x00010000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_IOSFC] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30210000, 0x00010000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_AES_1] =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30220000, 0x00004000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_AES_2] =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30230000, 0x00004000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_PCIE_ECAM] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x40000000, 0x10000000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_PCIE_MMIO] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x50000000, 0x1fff0000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Actual RAM size depends on =
configuration */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_MEM] =3D=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x70000000ULL, GiB},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const int irqmap[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_UART] =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_RTC] =3D 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_GPIO] =3D 0x5,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_IOSFC] =3D 0x10,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_GFX] =3D 0x11,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_AES_1] =3D 0x12,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [VMAPPLE_PCIE] =3D 0x20,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define GPEX_NUM_IRQS 16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_bdif(VMAppleMachineState =
*vms, MemoryRegion *mem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceState *bdif;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice *bdif_sb;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DriveInfo *di_aux =3D drive_ge=
t(IF_PFLASH, 0, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DriveInfo *di_root =3D drive_g=
et(IF_PFLASH, 0, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!di_aux) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&qu=
ot;No AUX device. Please specify one as<br>
&gt;=C2=A0 =C2=A0 =C2=A0pflash drive.&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!di_root) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fall back to =
the first IF_VIRTIO device as root device */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 di_root =3D driv=
e_get(IF_VIRTIO, 0, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!di_root) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&qu=
ot;No root device. Please specify one as<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio drive.&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* PV backdoor device */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bdif =3D qdev_new(TYPE_VMAPPLE=
_BDIF);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bdif_sb =3D SYS_BUS_DEVICE(bdi=
f);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(bdif_sb, 0, vm=
s-&gt;memmap[VMAPPLE_BDOOR].base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_drive(DEVICE(bdi=
f), &quot;aux&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0blk_by_legacy_dinfo(di_aux));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_drive(DEVICE(bdi=
f), &quot;root&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0blk_by_legacy_dinfo(di_root));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(bdif_=
sb, &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_pvpanic(VMAppleMachineSta=
te *vms,<br>
&gt;=C2=A0 =C2=A0 =C2=A0MemoryRegion *mem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice *cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;cfg =3D qdev_new(TYPE_=
PVPANIC_MMIO_DEVICE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 cfg =3D SYS_BUS_DEVICE(vms-&gt=
;cfg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(cfg, 0, vms-&g=
t;memmap[VMAPPLE_PVPANIC].base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(cfg, =
&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_cfg(VMAppleMachineState *=
vms, MemoryRegion *mem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice *cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MachineState *machine =3D MACH=
INE(vms);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t rnd =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;cfg =3D qdev_new(TYPE_=
VMAPPLE_CFG);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 cfg =3D SYS_BUS_DEVICE(vms-&gt=
;cfg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(cfg, 0, vms-&g=
t;memmap[VMAPPLE_CONFIG].base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_guest_getrandom_nofail(&a=
mp;rnd, sizeof(rnd));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;c=
fg, &quot;nr-cpus&quot;, machine-&gt;smp.cpus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint64(vms-&gt;c=
fg, &quot;ecid&quot;, vms-&gt;uuid);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint64(vms-&gt;c=
fg, &quot;ram-size&quot;, machine-&gt;ram_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;c=
fg, &quot;rnd&quot;, rnd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(cfg, =
&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_gfx(VMAppleMachineState *=
vms, MemoryRegion *mem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int irq_gfx =3D vms-&gt;irqmap=
[VMAPPLE_APV_GFX];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int irq_iosfc =3D vms-&gt;irqm=
ap[VMAPPLE_APV_IOSFC];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice *gfx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 gfx =3D SYS_BUS_DEVICE(qdev_ne=
w(&quot;apple-gfx-mmio&quot;));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gfx, 0, vms-&g=
t;memmap[VMAPPLE_APV_GFX].base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gfx, 1, vms-&g=
t;memmap[VMAPPLE_APV_IOSFC].base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_connect_irq(gfx, 0, qde=
v_get_gpio_in(vms-&gt;gic, irq_gfx));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_connect_irq(gfx, 1, qde=
v_get_gpio_in(vms-&gt;gic,<br>
&gt;=C2=A0 =C2=A0 =C2=A0irq_iosfc));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(gfx, =
&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_aes(VMAppleMachineState *=
vms, MemoryRegion *mem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[VMA=
PPLE_AES_1];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice *aes;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 aes =3D SYS_BUS_DEVICE(qdev_ne=
w(TYPE_APPLE_AES));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(aes, 0, vms-&g=
t;memmap[VMAPPLE_AES_1].base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(aes, 1, vms-&g=
t;memmap[VMAPPLE_AES_2].base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_connect_irq(aes, 0, qde=
v_get_gpio_in(vms-&gt;gic, irq));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(aes, =
&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static int arm_gic_ppi_index(int cpu_nr, int=
 ppi_index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return NUM_IRQS + cpu_nr * GIC=
_INTERNAL + ppi_index;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_gic(VMAppleMachineState *=
vms, MemoryRegion *mem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(v=
ms);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* We create a standalone GIC =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice *gicbusdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QList *redist_region_count;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 unsigned int smp_cpus =3D ms-&=
gt;smp.cpus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;gic =3D qdev_new(gicv3=
_class_name());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;g=
ic, &quot;revision&quot;, 3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;g=
ic, &quot;num-cpu&quot;, smp_cpus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* Note that the num-irq =
property counts both internal and<br>
&gt;=C2=A0 =C2=A0 =C2=A0external<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* interrupts; there are =
always 32 of the former (mandated<br>
&gt;=C2=A0 =C2=A0 =C2=A0by GIC spec).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;g=
ic, &quot;num-irq&quot;, NUM_IRQS + 32);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t redist0_capacity =3D<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 vms-&gt;memmap[VMAPPLE_GIC_REDIST].size /<br>
&gt;=C2=A0 =C2=A0 =C2=A0GICV3_REDIST_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t redist0_count =3D MIN=
(smp_cpus, redist0_capacity);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 redist_region_count =3D qlist_=
new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qlist_append_int(redist_region=
_count, redist0_count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_array(vms-&gt;gi=
c, &quot;redist-region-count&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0redist_region_count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 gicbusdev =3D SYS_BUS_DEVICE(v=
ms-&gt;gic);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(gicbu=
sdev, &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gicbusdev, 0, =
vms-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;memmap[VMAPPLE_GIC_DIST].base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gicbusdev, 1, =
vms-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;memmap[VMAPPLE_GIC_REDIST].base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* Wire the outputs from =
each CPU&#39;s generic timer and the GICv3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* maintenance interrupt =
signal to the appropriate GIC PPI<br>
&gt;=C2=A0 =C2=A0 =C2=A0inputs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* and the GIC&#39;s IRQ/=
FIQ/VIRQ/VFIQ interrupt outputs to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0CPU&#39;s inputs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; smp_cpus;=
 i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *cpu=
dev =3D DEVICE(qemu_get_cpu(i));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Map the virt =
timer to PPI 27 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpi=
o_out(cpudev, GTIMER_VIRT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpi=
o_in(vms-&gt;gic,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0arm_gic_ppi_index(i, 27)));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Map the GIC I=
RQ and FIQ lines to CPU */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_i=
rq(gicbusdev, i,<br>
&gt;=C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_i=
rq(gicbusdev, i + smp_cpus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpu=
dev, ARM_CPU_FIQ));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_uart(const VMAppleMachine=
State *vms, int uart,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *mem, Chardev *chr)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap=
[uart].base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[uar=
t];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceState *dev =3D qdev_new(=
TYPE_PL011);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice *s =3D SYS_BUS_DE=
VICE(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_chr(dev, &quot;c=
hardev&quot;, chr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_B=
US_DEVICE(dev), &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_add_subregion(me=
m, base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbu=
s_mmio_get_region(s, 0));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_connect_irq(s, 0, qdev_=
get_gpio_in(vms-&gt;gic, irq));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_rtc(const VMAppleMachineS=
tate *vms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap=
[VMAPPLE_RTC].base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[VMA=
PPLE_RTC];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;pl0=
31&quot;, base, qdev_get_gpio_in(vms-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;gic, irq));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static DeviceState *gpio_key_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_powerdown_req(Notifier *=
n, void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* use gpio Pin 3 for power bu=
tton event */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_set_irq(qdev_get_gpio_in(=
gpio_key_dev, 0), 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_gpio_devices(const VMAppl=
eMachineState *vms,<br>
&gt;=C2=A0 =C2=A0 =C2=A0int gpio,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memor=
yRegion *mem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceState *pl061_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap=
[gpio].base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[gpi=
o];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice *s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 pl061_dev =3D qdev_new(&quot;p=
l061&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Pull lines down to 0 if not=
 driven by the PL061 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(pl061_dev=
, &quot;pullups&quot;, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(pl061_dev=
, &quot;pulldowns&quot;, 0xff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s =3D SYS_BUS_DEVICE(pl061_dev=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(s, &a=
mp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_add_subregion(me=
m, base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0sysbus_mmio_get_region(s, 0));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_connect_irq(s, 0, qdev_=
get_gpio_in(vms-&gt;gic, irq));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 gpio_key_dev =3D sysbus_create=
_simple(&quot;gpio-key&quot;, -1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(pl061_dev, 3));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_firmware_init(VMAppleMac=
hineState *vms,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MemoryRegion *sysmem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr size =3D vms-&gt;memmap=
[VMAPPLE_FIRMWARE].size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap=
[VMAPPLE_FIRMWARE].base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 const char *bios_name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int image_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char *fname;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bios_name =3D MACHINE(vms)-&gt=
;firmware;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!bios_name) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&qu=
ot;No firmware specified&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 fname =3D qemu_find_file(QEMU_=
FILE_TYPE_BIOS, bios_name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!fname) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&qu=
ot;Could not find ROM image &#39;%s&#39;&quot;, bios_name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;vm=
s-&gt;fw_mr, NULL, &quot;firmware&quot;, size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 image_size =3D load_image_mr(f=
name, &amp;vms-&gt;fw_mr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 g_free(fname);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (image_size &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&qu=
ot;Could not load ROM image &#39;%s&#39;&quot;, bios_name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_add_subregion(ge=
t_system_memory(), base, &amp;vms-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;fw_mr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_pcie(VMAppleMachineState =
*vms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr base_mmio =3D vms-&gt;m=
emmap[VMAPPLE_PCIE_MMIO].base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr size_mmio =3D vms-&gt;m=
emmap[VMAPPLE_PCIE_MMIO].size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr base_ecam =3D vms-&gt;m=
emmap[VMAPPLE_PCIE_ECAM].base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr size_ecam =3D vms-&gt;m=
emmap[VMAPPLE_PCIE_ECAM].size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[VMA=
PPLE_PCIE];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion *mmio_alias;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion *mmio_reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion *ecam_reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceState *dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PCIHostState *pci;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceState *usb_controller;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 USBBus *usb_bus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dev =3D qdev_new(TYPE_GPEX_HOS=
T);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(dev, &quo=
t;num-irqs&quot;, GPEX_NUM_IRQS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_B=
US_DEVICE(dev), &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Map only the first size_eca=
m bytes of ECAM space */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 ecam_reg =3D sysbus_mmio_get_r=
egion(SYS_BUS_DEVICE(dev), 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_init_alias(&amp;=
vms-&gt;ecam_alias, OBJECT(dev),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;pcie-ecam&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ecam_reg, 0, =
size_ecam);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_add_subregion(ge=
t_system_memory(), base_ecam,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;=
vms-&gt;ecam_alias);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* Map the MMIO window fr=
om [0x50000000-0x7fff0000] in PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0space into<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* system address space a=
t [0x50000000-0x7fff0000].<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mmio_alias =3D g_new0(MemoryRe=
gion, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mmio_reg =3D sysbus_mmio_get_r=
egion(SYS_BUS_DEVICE(dev), 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_init_alias(mmio_=
alias, OBJECT(dev), &quot;pcie-mmio&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmio_reg, bas=
e_mmio, size_mmio);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_add_subregion(ge=
t_system_memory(), base_mmio,<br>
&gt;=C2=A0 =C2=A0 =C2=A0mmio_alias);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_=
IRQS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_i=
rq(SYS_BUS_DEVICE(dev), i,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(vms=
-&gt;gic, irq + i));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpex_set_irq_num=
(GPEX_HOST(dev), i, irq + i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 pci =3D PCI_HOST_BRIDGE(dev);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;bus =3D pci-&gt;bus;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 g_assert(vms-&gt;bus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 while ((dev =3D qemu_create_ni=
c_device(&quot;virtio-net-pci&quot;, true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0NULL))) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_realize_and=
_unref(dev, BUS(vms-&gt;bus), &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 usb_controller =3D qdev_new(TY=
PE_QEMU_XHCI);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_realize_and_unref(usb_con=
troller, BUS(pci-&gt;bus),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 usb_bus =3D USB_BUS(object_res=
olve_type_unambiguous(TYPE_USB_BUS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;error_fatal));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 usb_create_simple(usb_bus, &qu=
ot;usb-kbd&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 usb_create_simple(usb_bus, &qu=
ot;usb-tablet&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_reset(void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D o=
paque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap=
[VMAPPLE_FIRMWARE].base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 cpu_set_pc(first_cpu, base);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void mach_vmapple_init(MachineState *=
machine)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D V=
MAPPLE_MACHINE(machine);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_G=
ET_CLASS(machine);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 const CPUArchIdList *possible_=
cpus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion *sysmem =3D get_s=
ystem_memory();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int n;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 unsigned int smp_cpus =3D mach=
ine-&gt;smp.cpus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 unsigned int max_cpus =3D mach=
ine-&gt;smp.max_cpus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;memmap =3D memmap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 machine-&gt;usb =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 possible_cpus =3D mc-&gt;possi=
ble_cpu_arch_ids(machine);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 assert(possible_cpus-&gt;len =
=3D=3D max_cpus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (n =3D 0; n &lt; possible_=
cpus-&gt;len; n++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Object *cpu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUState *cs;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n &gt;=3D sm=
p_cpus) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu =3D object_n=
ew(possible_cpus-&gt;cpus[n].type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_=
set_int(cpu, &quot;mp-affinity&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 possi=
ble_cpus-&gt;cpus[n].arch_id,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cs =3D CPU(cpu);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;cpu_index=
 =3D n;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 numa_cpu_pre_plu=
g(&amp;possible_cpus-&gt;cpus[cs-&gt;cpu_index],<br>
&gt;=C2=A0 =C2=A0 =C2=A0DEVICE(cpu),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (object_prope=
rty_find(cpu, &quot;has_el3&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ob=
ject_property_set_bool(cpu, &quot;has_el3&quot;, false,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (object_prope=
rty_find(cpu, &quot;has_el2&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ob=
ject_property_set_bool(cpu, &quot;has_el2&quot;, false,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_=
set_int(cpu, &quot;psci-conduit&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMU_PSCI_CONDUIT_HVC,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;=
error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Secondary CPU=
s start in PSCI powered-down state */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n &gt; 0) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ob=
ject_property_set_bool(cpu, &quot;start-powered-off&quot;, true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_=
set_link(cpu, &quot;memory&quot;, OBJECT(sysmem),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_realize(DEV=
ICE(cpu), NULL, &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(cpu=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_add_subregion(sy=
smem, vms-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;memmap[VMAPPLE_MEM].base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machi=
ne-&gt;ram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_gic(vms, sysmem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_bdif(vms, sysmem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_pvpanic(vms, sysmem);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_aes(vms, sysmem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_gfx(vms, sysmem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_uart(vms, VMAPPLE_UART,=
 sysmem, serial_hd(0));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_rtc(vms);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_pcie(vms);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_gpio_devices(vms, VMAPP=
LE_GPIO, sysmem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vmapple_firmware_init(vms, sys=
mem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_cfg(vms, sysmem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* connect powerdown request *=
/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;powerdown_notifier.not=
ify =3D vmapple_powerdown_req;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_register_powerdown_notifi=
er(&amp;vms-&gt;powerdown_notifier);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.ram_size =3D =
machine-&gt;ram_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.board_id =3D =
-1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.loader_start =
=3D vms-&gt;memmap[VMAPPLE_MEM].base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.skip_dtb_auto=
load =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.firmware_load=
ed =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 arm_load_kernel(ARM_CPU(first_=
cpu), machine, &amp;vms-&gt;bootinfo);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_register_reset(vmapple_re=
set, vms);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static CpuInstanceProperties<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +vmapple_cpu_index_to_props(MachineState *ms,=
 unsigned cpu_index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_G=
ET_CLASS(ms);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 const CPUArchIdList *possible_=
cpus =3D mc-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;possible_cpu_arch_ids(ms);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 assert(cpu_index &lt; possible=
_cpus-&gt;len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return possible_cpus-&gt;cpus[=
cpu_index].props;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static int64_t vmapple_get_default_cpu_node_=
id(const<br>
&gt;=C2=A0 =C2=A0 =C2=A0MachineState *ms, int idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return idx % ms-&gt;numa_state=
-&gt;num_nodes;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const CPUArchIdList<br>
&gt;=C2=A0 =C2=A0 =C2=A0*vmapple_possible_cpu_arch_ids(MachineState *ms)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int n;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 unsigned int max_cpus =3D ms-&=
gt;smp.max_cpus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (ms-&gt;possible_cpus) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ms-&gt;po=
ssible_cpus-&gt;len =3D=3D max_cpus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ms-&gt;po=
ssible_cpus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 ms-&gt;possible_cpus =3D g_mal=
loc0(sizeof(CPUArchIdList) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sizeof(CPUArchId) * max_cpus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 ms-&gt;possible_cpus-&gt;len =
=3D max_cpus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (n =3D 0; n &lt; ms-&gt;po=
ssible_cpus-&gt;len; n++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ms-&gt;possible_=
cpus-&gt;cpus[n].type =3D ms-&gt;cpu_type;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ms-&gt;possible_=
cpus-&gt;cpus[n].arch_id =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ar=
m_build_mp_affinity(n, GICV3_TARGETLIST_BITS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ms-&gt;possible_=
cpus-&gt;cpus[n].props.has_thread_id =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ms-&gt;possible_=
cpus-&gt;cpus[n].props.thread_id =3D n;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return ms-&gt;possible_cpus;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_get_uuid(Object *obj, Vi=
sitor *v, const char<br>
&gt;=C2=A0 =C2=A0 =C2=A0*name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque,=
 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D V=
MAPPLE_MACHINE(obj);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 visit_type_uint64(v, name, &am=
p;vms-&gt;uuid, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_set_uuid(Object *obj, Vi=
sitor *v, const char<br>
&gt;=C2=A0 =C2=A0 =C2=A0*name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque,=
 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D V=
MAPPLE_MACHINE(obj);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 Error *error =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 visit_type_uint64(v, name, &am=
p;vms-&gt;uuid, &amp;error);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (error) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(=
errp, error);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_machine_class_init(Objec=
tClass *oc, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_C=
LASS(oc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;init =3D mach_vmapple_i=
nit;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;max_cpus =3D 32;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;block_default_type =3D =
IF_VIRTIO;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;no_cdrom =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;pci_allow_0_address =3D=
 true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;minimum_page_bits =3D 1=
2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;possible_cpu_arch_ids =
=3D vmapple_possible_cpu_arch_ids;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;cpu_index_to_instance_p=
rops =3D vmapple_cpu_index_to_props;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D AR=
M_CPU_TYPE_NAME(&quot;host&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;get_default_cpu_node_id=
 =3D vmapple_get_default_cpu_node_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quo=
t;mach-vmapple.ram&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 object_register_sugar_prop(TYP=
E_VIRTIO_PCI, &quot;disable-legacy&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
on&quot;, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 object_class_property_add(oc, =
&quot;uuid&quot;, &quot;uint64&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmapple_get_uuid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmapple_set_=
uuid, NULL, NULL);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Use: object_class_property_add_uint64_ptr<br>
&gt; <br>
&gt; <br>
&gt; Do I understand correctly that to use this, I need to move the uuid <b=
r>
&gt; field out of VMAppleMachineState and turn it into a global/static <br>
&gt; variable? There are no active uses of <br>
&gt; object_class_property_add_uint64_ptr (or the uint32 version) in the Qe=
mu <br>
&gt; code base to use as reference, but that&#39;s what it looks like based=
 on <br>
&gt; the single use of object_class_property_add_uint8_ptr.<br>
&gt; <br>
&gt; I&#39;m not convinced this is an improvement to be honest. (And the la=
ck of <br>
&gt; uptake of this API would suggest I&#39;m not the only one who finds th=
is an <br>
&gt; awkward API - on the other hand, there are lots of examples of <br>
&gt; object_class_property_add() being used for uint64-typed properties <br=
>
&gt; exactly as Alex has done here.)<br>
<br>
I didn&#39;t mean to add a class property. object_property_add_uint64_ptr()=
 <br>
will do what we want I think.<br></blockquote><div><br></div><div>As far as=
 I can tell,  &quot;class property&quot; in general just means the getter/s=
etter is automatically provided for all instances of the class, which <i>is=
</i> what we want, but the object_class_property_add_*_ptr() helper functio=
ns isn&#39;t suitable for genuine per-instance values.</div><div><br></div>=
<div>The object property created with=C2=A0object_property_add_uint64_ptr()=
 (no &quot;class&quot;) applies to only that object instance, so it needs t=
o be done during instance init. It does seem to work in this case at least,=
 and a bunch of other machine types also use it in a similar way, so I&#39;=
ll use it.<br></div><div><br></div><div>I had a quick look to see if we cou=
ld make this tidier with a macro that uses offsetof() or so. I think it&#39=
;s possible, but making it safe isn&#39;t straightforward; in any case, tha=
t improvement is out of scope here. Another option would be to auto-generat=
e getter/setter functions from a macro, which would contain the correct str=
uct field access expression expansion. Probably also not ideal, however.</d=
iv><div><br></div><div>Regards,<br></div><div>Phil<br></div></div></div>

--00000000000027ac9e0626436a97--

