Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB37E7718E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 22:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPqkK-0002h7-2q; Mon, 23 Dec 2024 17:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqk9-0002CG-4S
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:41 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqk4-00076O-SY
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:40 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4b11a11a4f0so1166555137.3
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 14:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734992256; x=1735597056;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ze0paOZD6nY1B5tUxUzBHwsLbyzsnOvf/b8pwDwYHg=;
 b=ezD3cmd/2Xca4lORBqz59MLLRzrA6RLqk4cvTfvr6VEPWOwSQ1pKqrxiSuzHsNa5WO
 4lpRJF0ngynd2OPfkSf93XY/U77ffJrQ/MGLcZIavBYuShrIlvq51HybRnrY6wtv64pG
 qGbWSpIP3irbQuaQUqvsZxTOvOCfWic2ASCs1FGf8ZZsya4HFciXEYk44wa8kEdRi7QH
 Od2jKQrPhqW1z6Ww5p6pkA99jJGF2jiaTmyZqNiqONH+kIiZvh3Tid+IAfMXxGQ33WLq
 QfWXU4Dvdg/i55Q6kcHu07A0JzdgtQUyicivv0U3i5oMWPLKCkHXH3teFt0Dl1zZDI7h
 2AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734992256; x=1735597056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ze0paOZD6nY1B5tUxUzBHwsLbyzsnOvf/b8pwDwYHg=;
 b=wOnhTjZS7yWJpkatJWc1zFSqSVrZ42TQZjhXkwFabjD8OpzTaeQVzmZSxLqXI2kW+l
 4mrHANJZoBLm77Thjx7H+njSP/WFqjcirrxrFXrM1MHZaXXxGmYT9ZDDl+QSii07T7r3
 W/UbJ7VMWC7IU7QqOaJh6JjbXanEKhFi2txkOV+V2Op80WkB6Te2RzdG/Ye2knWRQm+y
 2wCQg6E1CT9XG8VJw2DxjYnQ2mBddQNKyaHybhtJw00kuhAkKbNmnlw/jzZed7LzLZVp
 GD556dFBNxvtsbADWQiY9jcYfSXodObNZWFafad2lqoWXkgQhKemZOKkTdKHjUcrZaEH
 N3jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdAOThHfKQDfRkCLMvXlRE+UgKWMyqhIMB45xWLHydP4wh8FtpHl+hUfcz3VG0ENk1PXIHtJiDffmC@nongnu.org
X-Gm-Message-State: AOJu0YycLA5CyPr4NGF+N7k7ZtCC9IibHckL+9PHBO5bq8XLbDRUksdm
 RDrNUdZGkCnUM3+aQvbCCuDuhN/FJTOiTCbCIPNMwAGZEsrtz69g0A+2/BLyPT2fwxh+4BvRPHS
 4WORS7TiReIRUmVNzVhyA7IfLROOKEr6GnpMe
X-Gm-Gg: ASbGncv2UTLADhyJrZTU5sswCenNHIbLqY6fYD2ukdtGSw3P/foQQdIEaUVEnpXYKZa
 bS1kL+jCFJBV8KGd4h2BO9TO2DA8Fb6hBce2bsA==
X-Google-Smtp-Source: AGHT+IEKqVlsAFU5mgv4t6tBx8PW0gbL/Q2cNX8NkKcj7aZj0QK13TJvDjWkDREjmUP6BH5iLYUlHDTxfcKI+syaNdA=
X-Received: by 2002:a05:6102:1524:b0:4af:f32e:ea76 with SMTP id
 ada2fe7eead31-4b2cc31c4bcmr13972802137.5.1734992255447; Mon, 23 Dec 2024
 14:17:35 -0800 (PST)
MIME-Version: 1.0
References: <167ca349-980c-43a7-82f2-264b2f7250cb@linaro.org>
 <50ABB5B0-4B7C-4F32-A956-82BD76C235E3@philjordan.eu>
In-Reply-To: <50ABB5B0-4B7C-4F32-A956-82BD76C235E3@philjordan.eu>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 23 Dec 2024 23:17:24 +0100
Message-ID: <CAAibmn1sJ8cCyExHaEw853bek1hUt8QrA4Lv5=1R=zX=v=51QQ@mail.gmail.com>
Subject: Re: [PATCH v15 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, pbonzini@redhat.com, rad@semihalf.com, 
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="000000000000130bd60629f75dc0"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e35;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe35.google.com
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

--000000000000130bd60629f75dc0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Dec 2024 at 18:38, Phil Dennis-Jordan <phil@philjordan.eu> wrote=
:

> Hi Philippe,
>
> > On 23.12.2024, at 17:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
>
> wrote:
> >
> > =EF=BB=BFHi Phil,
> >
> >> On 23/12/24 14:53, Phil Dennis-Jordan wrote:
> >> On Thu, 19 Dec 2024 at 11:50, Akihiko Odaki <akihiko.odaki@daynix.com
> <mailto:akihiko.odaki@daynix.com>> wrote:
> >>    Reviewing "[PATCH v2 6/6] hw/vmapple: XHCI controller's interrupt
> >>    mapping workaround for macOS", I found a few problems so I'm adding
> >>    comments for them:
> >>    On 2024/12/19 5:20, Phil Dennis-Jordan wrote:
> >>     > From: Alexander Graf <graf@amazon.com <mailto:graf@amazon.com>>
> >>     >
> >>     > Apple defines a new "vmapple" machine type as part of its
> proprietary
> >>     > macOS Virtualization.Framework vmm. This machine type is similar
> >>    to the
> >>     > virt one, but with subtle differences in base devices, a few
> special
> >>     > vmapple device additions and a vastly different boot chain.
> >>     >
> >>     > This patch reimplements this machine type in QEMU. To use it, yo=
u
> >>     > have to have a readily installed version of macOS for VMApple,
> >>     > run on macOS with -accel hvf, pass the Virtualization.Framework
> >>     > boot rom (AVPBooter) in via -bios, pass the aux and root volume
> >>    as pflash
> >>     > and pass aux and root volume as virtio drives. In addition, you
> also
> >>     > need to find the machine UUID and pass that as -M vmapple,uuid=
=3D
> >>    parameter:
> >>     >
> >>     > $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G =
\
> >>     >      -bios /System/Library/Frameworks/Virtualization.framework/
> >>    Versions/A/Resources/AVPBooter.vmapple2.bin
> >>     >      -drive file=3Daux,if=3Dpflash,format=3Draw \
> >>     >      -drive file=3Droot,if=3Dpflash,format=3Draw \
> >>     >      -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw \
> >>     >      -device vmapple-virtio-blk-pci,variant=3Daux,drive=3Daux \
> >>     >      -drive file=3Droot,if=3Dnone,id=3Droot,format=3Draw \
> >>     >      -device vmapple-virtio-blk-pci,variant=3Droot,drive=3Droot
> >>     >
> >>     > With all these in place, you should be able to see macOS booting
> >>     > successfully.
> >>     >
> >>     > Known issues:
> >>     >   - Keyboard and mouse/tablet input is laggy. The reason for thi=
s
> is
> >>     >     that macOS's XHCI driver seems to expect interrupter mapping
> to
> >>     >     be disabled when MSI/MSI-X is unavailable. I have found a
> >>     >     workaround but discovered a bunch of other XHCI spec non-
> >>    compliance
> >>     >     in the process, so I'm fixing all of those in a separate pat=
ch
> >>     >     set.
> >>     >   - Currently only macOS 12 guests are supported. The boot
> >>    process for
> >>     >     13+ will need further investigation and adjustment.
> >>     >
> >>     > Signed-off-by: Alexander Graf <graf@amazon.com
> >>    <mailto:graf@amazon.com>>
> >>     > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu
> >>    <mailto:phil@philjordan.eu>>
> >>     > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
> >>    <mailto:phil@philjordan.eu>>
> >>     > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com
> >>    <mailto:akihiko.odaki@daynix.com>>
> >>     > Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com
> >>    <mailto:akihiko.odaki@daynix.com>>
> >>     > ---
> >>     >
> >>     > v3:
> >>     >   * Rebased on latest upstream, updated affinity and NIC creatio=
n
> >>     >     API usage
> >>     >   * Included Apple-variant virtio-blk in build dependency
> >>     >   * Updated API usage for setting 'redist-region-count' array-
> >>    typed property on GIC.
> >>     >   * Switched from virtio HID devices (for which macOS 12 does no=
t
> >>    contain
> >>     >     drivers) to an XHCI USB controller and USB HID devices.
> >>     >
> >>     > v4:
> >>     >   * Fixups for v4 changes to the other patches in the set.
> >>     >   * Corrected the assert macro to use
> >>     >   * Removed superfluous endian conversions corresponding to cfg'=
s.
> >>     >   * Init error handling improvement.
> >>     >   * No need to select CPU type on TCG, as only HVF is supported.
> >>     >   * Machine type version bumped to 9.2
> >>     >   * #include order improved
> >>     >
> >>     > v5:
> >>     >   * Fixed memory reservation for ecam alias region.
> >>     >   * Better error handling setting properties on devices.
> >>     >   * Simplified the machine ECID/UUID extraction script and
> >>    actually created a
> >>     >     file for it rather than quoting its code in documentation.
> >>     >
> >>     > v7:
> >>     >   * Tiny error handling fix, un-inlined function.
> >>     >
> >>     > v8:
> >>     >   * Use object_property_add_uint64_ptr rather than defining
> >>    custom UUID
> >>     >     property get/set functions.
> >>     >
> >>     > v9:
> >>     >   * Documentation improvements
> >>     >   * Fixed variable name and struct field used during pvpanic
> >>    device creation.
> >>     >
> >>     > v10:
> >>     >   * Documentation fixup for changed virtio-blk device type.
> >>     >   * Small improvements to shell commands in documentation.
> >>     >   * Improved propagation of errors during cfg device
> instantiation.
> >>     >
> >>     > v11:
> >>     >   * Quoted more strings in the documentation's shell script code=
.
> >>     >
> >>     > v13:
> >>     >   * Bumped the machine type version from 9.2 to 10.0.
> >>     >
> >>     >   MAINTAINERS                 |   1 +
> >>     >   contrib/vmapple/uuid.sh     |   9 +
> >>     >   docs/system/arm/vmapple.rst |  63 ++++
> >>     >   docs/system/target-arm.rst  |   1 +
> >>     >   hw/vmapple/Kconfig          |  20 ++
> >>     >   hw/vmapple/meson.build      |   1 +
> >>     >   hw/vmapple/vmapple.c        | 648 ++++++++++++++++++++++++++++=
+
> >>    +++++++
> >>     >   7 files changed, 743 insertions(+)
> >>     >   create mode 100755 contrib/vmapple/uuid.sh
> >>     >   create mode 100644 docs/system/arm/vmapple.rst
> >>     >   create mode 100644 hw/vmapple/vmapple.c
> >>     >
> >>     > diff --git a/MAINTAINERS b/MAINTAINERS
> >>     > index 5d9d65e6df7..a8e3d3b74a2 100644
> >>     > --- a/MAINTAINERS
> >>     > +++ b/MAINTAINERS
> >>     > @@ -2777,6 +2777,7 @@ M: Phil Dennis-Jordan <phil@philjordan.eu
> >>    <mailto:phil@philjordan.eu>>
> >>     >   S: Maintained
> >>     >   F: hw/vmapple/*
> >>     >   F: include/hw/vmapple/*
> >>     > +F: docs/system/arm/vmapple.rst
> >>     >
> >>     >   Subsystems
> >>     >   ----------
> >>     > diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
> >>     > new file mode 100755
> >>     > index 00000000000..956e8c3afed
> >>     > --- /dev/null
> >>     > +++ b/contrib/vmapple/uuid.sh
> >>     > @@ -0,0 +1,9 @@
> >>     > +#!/bin/sh
> >>     > +# Used for converting a guest provisioned using
> >>    Virtualization.framework
> >>     > +# for use with the QEMU 'vmapple' aarch64 machine type.
> >>     > +#
> >>     > +# Extracts the Machine UUID from Virtualization.framework VM
> >>    JSON file.
> >>     > +# (as produced by 'macosvm', passed as command line argument)
> >>     > +
> >>     > +plutil -extract machineId raw "$1" | base64 -d | plutil -extrac=
t
> >>    ECID raw -
> >>     > +
> >>     > diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/
> >>    vmapple.rst
> >>     > new file mode 100644
> >>     > index 00000000000..5090a8997c3
> >>     > --- /dev/null
> >>     > +++ b/docs/system/arm/vmapple.rst
> >>     > @@ -0,0 +1,63 @@
> >>     > +VMApple machine emulation
> >>     >
> >>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>     > +
> >>     > +VMApple is the device model that the macOS built-in hypervisor
> >>    called "Virtualization.framework"
> >>     > +exposes to Apple Silicon macOS guests. The "vmapple" machine
> >>    model in QEMU implements the same
> >>     > +device model, but does not use any code from
> >>    Virtualization.Framework.
> >>     > +
> >>     > +Prerequisites
> >>     > +-------------
> >>     > +
> >>     > +To run the vmapple machine model, you need to
> >>     > +
> >>     > + * Run on Apple Silicon
> >>     > + * Run on macOS 12.0 or above
> >>     > + * Have an already installed copy of a Virtualization.Framework
> >>    macOS 12 virtual
> >>     > +   machine. Note that newer versions than 12.x are currently NO=
T
> >>    supported on
> >>     > +   the guest side. I will assume that you installed it using th=
e
> >>     > +   `macosvm <https://github.com/s-u/macosvm <https://github.com=
/
> >>    s-u/macosvm>>` CLI.
> >>     > +
> >>     > +First, we need to extract the UUID from the virtual machine tha=
t
> >>    you installed. You can do this
> >>     > +by running the shell script in contrib/vmapple/uuid.sh on the
> >>    macosvm.json file.
> >>     > +
> >>     > +.. code-block:: bash
> >>     > +  :caption: uuid.sh script to extract the UUID from a
> >>    macosvm.json file
> >>     > +
> >>     > +  $ contrib/vmapple/uuid.sh "path/to/macosvm.json"
> >>     > +
> >>     > +Now we also need to trim the aux partition. It contains metadat=
a
> >>    that we can just discard:
> >>     > +
> >>     > +.. code-block:: bash
> >>     > +  :caption: Command to trim the aux file
> >>     > +
> >>     > +  $ dd if=3D"aux.img" of=3D"aux.img.trimmed" bs=3D$(( 0x4000 ))=
 skip=3D1
> >>     > +
> >>     > +How to run
> >>     > +----------
> >>     > +
> >>     > +Then, we can launch QEMU with the Virtualization.Framework pre-
> >>    boot environment and the readily
> >>     > +installed target disk images. I recommend to port forward the
> >>    VM's ssh and vnc ports to the host
> >>     > +to get better interactive access into the target system:
> >>     > +
> >>     > +.. code-block:: bash
> >>     > +  :caption: Example execution command line
> >>     > +
> >>     > +  $ UUID=3D"$(contrib/vmapple/uuid.sh 'macosvm.json')"
> >>     > +  $ AVPBOOTER=3D"/System/Library/Frameworks/
> >>    Virtualization.framework/Resources/AVPBooter.vmapple2.bin"
> >>     > +  $ AUX=3D"aux.img.trimmed"
> >>     > +  $ DISK=3D"disk.img"
> >>     > +  $ qemu-system-aarch64 \
> >>     > +       -serial mon:stdio \
> >>     > +       -m 4G \
> >>     > +       -accel hvf \
> >>     > +       -M vmapple,uuid=3D"$UUID" \
> >>     > +       -bios "$AVPBOOTER" \
> >>     > +       -drive file=3D"$AUX",if=3Dpflash,format=3Draw \
> >>     > +       -drive file=3D"$DISK",if=3Dpflash,format=3Draw \
> >>     > +       -drive file=3D"$AUX",if=3Dnone,id=3Daux,format=3Draw \
> >>     > +       -drive file=3D"$DISK",if=3Dnone,id=3Droot,format=3Draw \
> >>     > +       -device vmapple-virtio-blk-pci,variant=3Daux,drive=3Daux=
 \
> >>     > +       -device vmapple-virtio-blk-pci,variant=3Droot,drive=3Dro=
ot \
> >>     > +       -netdev
> >>    user,id=3Dnet0,ipv6=3Doff,hostfwd=3Dtcp::2222-:22,hostfwd=3Dtcp::59=
01-:5900 \
> >>     > +       -device virtio-net-pci,netdev=3Dnet0
> >>     > +
> >>     > diff --git a/docs/system/target-arm.rst
> b/docs/system/target-arm.rst
> >>     > index 9aaa9c414c9..3426f79100b 100644
> >>     > --- a/docs/system/target-arm.rst
> >>     > +++ b/docs/system/target-arm.rst
> >>     > @@ -102,6 +102,7 @@ Board-specific documentation
> >>     >      arm/stellaris
> >>     >      arm/stm32
> >>     >      arm/virt
> >>     > +   arm/vmapple
> >>     >      arm/xenpvh
> >>     >      arm/xlnx-versal-virt
> >>     >      arm/xlnx-zynq
> >>     > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> >>     > index bcd1be63e3c..6a4c4a7fa2e 100644
> >>     > --- a/hw/vmapple/Kconfig
> >>     > +++ b/hw/vmapple/Kconfig
> >>     > @@ -10,3 +10,23 @@ config VMAPPLE_CFG
> >>     >   config VMAPPLE_VIRTIO_BLK
> >>     >       bool
> >>     >
> >>     > +config VMAPPLE
> >>     > +    bool
> >>     > +    depends on ARM
> >>     > +    depends on HVF
> >>     > +    default y if ARM
> >>     > +    imply PCI_DEVICES
> >>     > +    select ARM_GIC
> >>     > +    select PLATFORM_BUS
> >>     > +    select PCI_EXPRESS
> >>     > +    select PCI_EXPRESS_GENERIC_BRIDGE
> >>     > +    select PL011 # UART
> >>     > +    select PL031 # RTC
> >>     > +    select PL061 # GPIO
> >>     > +    select GPIO_PWR
> >>     > +    select PVPANIC_MMIO
> >>     > +    select VMAPPLE_AES
> >>     > +    select VMAPPLE_BDIF
> >>     > +    select VMAPPLE_CFG
> >>     > +    select MAC_PVG_MMIO
> >>     > +    select VMAPPLE_VIRTIO_BLK
> >>     > diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> >>     > index bf17cf906c9..e572f7d5602 100644
> >>     > --- a/hw/vmapple/meson.build
> >>     > +++ b/hw/vmapple/meson.build
> >>     > @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_VMAPPLE_AES',
>  if_true: files('aes.c'))
> >>     >   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true:
> >>    files('bdif.c'))
> >>     >   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true:
> files('cfg.c'))
> >>     >   system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true:
> >>    files('virtio-blk.c'))
> >>     > +specific_ss.add(when: 'CONFIG_VMAPPLE',     if_true:
> >>    files('vmapple.c'))
> >>     > diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
> >>     > new file mode 100644
> >>     > index 00000000000..66336942c8d
> >>     > --- /dev/null
> >>     > +++ b/hw/vmapple/vmapple.c
> >>     > @@ -0,0 +1,648 @@
> >>     > +/*
> >>     > + * VMApple machine emulation
> >>     > + *
> >>     > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. Al=
l
> >>    Rights Reserved.
> >>     > + *
> >>     > + * This work is licensed under the terms of the GNU GPL, versio=
n
> >>    2 or later.
> >>     > + * See the COPYING file in the top-level directory.
> >>     > + *
> >>     > + * SPDX-License-Identifier: GPL-2.0-or-later
> >>     > + *
> >>     > + * VMApple is the device model that the macOS built-in
> >>    hypervisor called
> >>     > + * "Virtualization.framework" exposes to Apple Silicon macOS
> >>    guests. The
> >>     > + * machine model in this file implements the same device model
> >>    in QEMU, but
> >>     > + * does not use any code from Virtualization.Framework.
> >>     > + */
> >>     > +
> >>     > +#include "qemu/osdep.h"
> >>     > +#include "qemu/bitops.h"
> >>     > +#include "qemu/datadir.h"
> >>     > +#include "qemu/error-report.h"
> >>     > +#include "qemu/guest-random.h"
> >>     > +#include "qemu/help-texts.h"
> >>     > +#include "qemu/log.h"
> >>     > +#include "qemu/module.h"
> >>     > +#include "qemu/option.h"
> >>     > +#include "qemu/units.h"
> >>     > +#include "monitor/qdev.h"
> >>     > +#include "hw/boards.h"
> >>     > +#include "hw/irq.h"
> >>     > +#include "hw/loader.h"
> >>     > +#include "hw/qdev-properties.h"
> >>     > +#include "hw/sysbus.h"
> >>     > +#include "hw/usb.h"
> >>     > +#include "hw/arm/boot.h"
> >>     > +#include "hw/arm/primecell.h"
> >>     > +#include "hw/char/pl011.h"
> >>     > +#include "hw/intc/arm_gic.h"
> >>     > +#include "hw/intc/arm_gicv3_common.h"
> >>     > +#include "hw/misc/pvpanic.h"
> >>     > +#include "hw/pci-host/gpex.h"
> >>     > +#include "hw/usb/xhci.h"
> >>     > +#include "hw/virtio/virtio-pci.h"
> >>     > +#include "hw/vmapple/vmapple.h"
> >>     > +#include "net/net.h"
> >>     > +#include "qapi/error.h"
> >>     > +#include "qapi/qmp/qlist.h"
> >>     > +#include "qapi/visitor.h"
> >>     > +#include "qapi/qapi-visit-common.h"
> >>     > +#include "standard-headers/linux/input.h"
> >>     > +#include "sysemu/hvf.h"
> >>     > +#include "sysemu/kvm.h"
> >>     > +#include "sysemu/reset.h"
> >>     > +#include "sysemu/runstate.h"
> >>     > +#include "sysemu/sysemu.h"
> >>     > +#include "target/arm/internals.h"
> >>     > +#include "target/arm/kvm_arm.h"
> >>     > +
> >>     > +struct VMAppleMachineClass {
> >>     > +    MachineClass parent;
> >>     > +};
> >>     > +
> >>     > +struct VMAppleMachineState {
> >>     > +    MachineState parent;
> >>     > +
> >>     > +    Notifier machine_done;
> >>     > +    struct arm_boot_info bootinfo;
> >>     > +    MemMapEntry *memmap;
> >>     > +    const int *irqmap;
> >>     > +    DeviceState *gic;
> >>     > +    DeviceState *cfg;
> >>     > +    DeviceState *pvpanic;
> >>     > +    Notifier powerdown_notifier;
> >>     > +    PCIBus *bus;
> >>     > +    MemoryRegion fw_mr;
> >>     > +    MemoryRegion ecam_alias;
> >>     > +    uint64_t uuid;
> >>     > +};
> >>     > +
> >>     > +#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \
> >>    This macro has suffix "_LATEST", but it is used not only for the
> latest
> >>    version but also for older versions.
> >>    include/hw/boards.h suggests using "_IMPL" suffix.
> >> Thanks for pointing this out, I've fixed it locally and will include i=
t
> in v16.
> >
> > Do you have other changes in your v16? I'm quite happy to integrate thi=
s
> > v15.
>
> The ones proposed by Akihiko are the only ones. I=E2=80=99ve already impl=
emented
> them, so I=E2=80=99m happy to post v16.
>

OK, rebasing on the upstream master branch has revealed it's not quite so
simple: there are a bunch of clashes with the recent sysemu->system rename
and the removal of DEFINE_PROP_END_OF_LIST(). They amount to pretty trivial
changes, but almost all commits needed adjusting, so pulling v15 would be
painful. I've just posted my v16 (including all the changes discussed here)=
.

Thanks for taking an interest in this patch set!


> >> Adapting this giant macro for each machine type seems rather
> error-prone and the kind of thing a computer does better than a human
> writing the code. I can't help but wonder if we could define a generic
> version in boards.h and only implement the DEFINE_*_MACHINE{_LATEST,}()
> wrappers specifically for each machine type. I've created an issue for th=
is
> on GitLab: https://gitlab.com/qemu-project/qemu/-/issues/2744 <https://
> gitlab.com/qemu-project/qemu/-/issues/2744> I might attack that once I've
> cut down my backlog of unmerged patches.
> >
> > Do we really want the vmapple machines to be versioned? I see 3 options=
:
> > 1/ No (simplest)
> > 2/ Not yet, adding versioning when we see the needs
> > 3/ Yes
> >
> > Personally I prefer/recommend 1/ or 2/ ;)
>
> I didn=E2=80=99t realise these were an option. :-) I was just inheriting =
Alex=E2=80=99s
> code here and assumed it was the standard thing to do.
>
> I could imagine we might change a few things to get better guest version
> support and perhaps the guest iCloud support that was added to the
> Virtualization.framework in macOS 15. But yeah it seems unlikely that any
> of this would cause regressions.
>
> What change would you propose to remove the versioning? Is there a
> specific machine type I should use as reference? Or do you just want to
> change that yourself, if I push my v16 code to a public repository?
>
>
OK, grepping through the code base reveals there are quite a number of the
"smaller" machine types are unversioned. So I guess that's a no-brainer
then. I've worked out I essentially just need to move the compat properties
registration to the main init, the "desc" field on the machine class needs
to be set, and the type becomes non-abstract. Everything still appears to
work when I add that back in after removing all the macro definitions and
instantiations. Change included in v16, but I've still got the reverse of
the removal commit around, so if anyone has good arguments why we need it,
I can easily add versioning back in.




> >>     > +    static void
> >>    vmapple##major##_##minor##_class_init(ObjectClass *oc, \
> >>     > +                                                    void *data)=
 \
> >>     > +    { \
> >>     > +        MachineClass *mc =3D MACHINE_CLASS(oc); \
> >>     > +        vmapple_machine_##major##_##minor##_options(mc); \
> >>     > +        mc->desc =3D "QEMU " # major "." # minor " Apple Virtua=
l
> >>    Machine"; \
> >>     > +        if (latest) { \
> >>     > +            mc->alias =3D "vmapple"; \
> >>     > +        } \
> >>     > +    } \
> >>     > +    static const TypeInfo machvmapple##major##_##minor##_info =
=3D
> { \
> >>     > +        .name =3D MACHINE_TYPE_NAME("vmapple-" # major "." #
> minor), \
> >>     > +        .parent =3D TYPE_VMAPPLE_MACHINE, \
> >>     > +        .class_init =3D vmapple##major##_##minor##_class_init, =
\
> >>     > +    }; \
> >>     > +    static void
> machvmapple_machine_##major##_##minor##_init(void) \
> >>     > +    { \
> >>     > +
>  type_register_static(&machvmapple##major##_##minor##_info); \
> >>     > +    } \
> >>     > +    type_init(machvmapple_machine_##major##_##minor##_init);
> >>     > +
> >>     > +#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(major, minor) \
> >>     > +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, true)
> >>     > +#define DEFINE_VMAPPLE_MACHINE(major, minor) \
> >>     > +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, false)
> >>     > +
> >>     > +#define TYPE_VMAPPLE_MACHINE   MACHINE_TYPE_NAME("vmapple")
> >>     > +OBJECT_DECLARE_TYPE(VMAppleMachineState, VMAppleMachineClass,
> >>    VMAPPLE_MACHINE)
> >>     > +
> >>     > +/* Number of external interrupt lines to configure the GIC with
> */
> >>     > +#define NUM_IRQS 256
> >>     > +
> >>     > +enum {
> >>     > +    VMAPPLE_FIRMWARE,
> >>     > +    VMAPPLE_CONFIG,
> >>     > +    VMAPPLE_MEM,
> >>     > +    VMAPPLE_GIC_DIST,
> >>     > +    VMAPPLE_GIC_REDIST,
> >>     > +    VMAPPLE_UART,
> >>     > +    VMAPPLE_RTC,
> >>     > +    VMAPPLE_PCIE,
> >>     > +    VMAPPLE_PCIE_MMIO,
> >>     > +    VMAPPLE_PCIE_ECAM,
> >>     > +    VMAPPLE_GPIO,
> >>     > +    VMAPPLE_PVPANIC,
> >>     > +    VMAPPLE_APV_GFX,
> >>     > +    VMAPPLE_APV_IOSFC,
> >>     > +    VMAPPLE_AES_1,
> >>     > +    VMAPPLE_AES_2,
> >>     > +    VMAPPLE_BDOOR,
> >>     > +    VMAPPLE_MEMMAP_LAST,
> >>     > +};
> >>     > +
> >>     > +static MemMapEntry memmap[] =3D {
> >
> > const
>
>
Ack, fixed.


> >>     > +    [VMAPPLE_FIRMWARE] =3D           { 0x00100000, 0x00100000 }=
,
> >>     > +    [VMAPPLE_CONFIG] =3D             { 0x00400000, 0x00010000 }=
,
> >>     > +
> >>     > +    [VMAPPLE_GIC_DIST] =3D           { 0x10000000, 0x00010000 }=
,
> >>     > +    [VMAPPLE_GIC_REDIST] =3D         { 0x10010000, 0x00400000 }=
,
> >>     > +
> >>     > +    [VMAPPLE_UART] =3D               { 0x20010000, 0x00010000 }=
,
> >>     > +    [VMAPPLE_RTC] =3D                { 0x20050000, 0x00001000 }=
,
> >>     > +    [VMAPPLE_GPIO] =3D               { 0x20060000, 0x00001000 }=
,
> >>     > +    [VMAPPLE_PVPANIC] =3D            { 0x20070000, 0x00000002 }=
,
> >>     > +    [VMAPPLE_BDOOR] =3D              { 0x30000000, 0x00200000 }=
,
> >>     > +    [VMAPPLE_APV_GFX] =3D            { 0x30200000, 0x00010000 }=
,
> >>     > +    [VMAPPLE_APV_IOSFC] =3D          { 0x30210000, 0x00010000 }=
,
> >>     > +    [VMAPPLE_AES_1] =3D              { 0x30220000, 0x00004000 }=
,
> >>     > +    [VMAPPLE_AES_2] =3D              { 0x30230000, 0x00004000 }=
,
> >>     > +    [VMAPPLE_PCIE_ECAM] =3D          { 0x40000000, 0x10000000 }=
,
> >>     > +    [VMAPPLE_PCIE_MMIO] =3D          { 0x50000000, 0x1fff0000 }=
,
> >>     > +
> >>     > +    /* Actual RAM size depends on configuration */
> >>     > +    [VMAPPLE_MEM] =3D                { 0x70000000ULL, GiB},
> >>     > +};
> >>     > +
> >>     > +static const int irqmap[] =3D {
> >>     > +    [VMAPPLE_UART] =3D 1,
> >>     > +    [VMAPPLE_RTC] =3D 2,
> >>     > +    [VMAPPLE_GPIO] =3D 0x5,
> >>     > +    [VMAPPLE_APV_IOSFC] =3D 0x10,
> >>     > +    [VMAPPLE_APV_GFX] =3D 0x11,
> >>     > +    [VMAPPLE_AES_1] =3D 0x12,
> >>     > +    [VMAPPLE_PCIE] =3D 0x20,
> >>     > +};
> >
>

--000000000000130bd60629f75dc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 23 Dec 2024 =
at 18:38, Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu" targ=
et=3D"_blank">phil@philjordan.eu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Philippe,<br>
<br>
&gt; On 23.12.2024, at 17:36, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:<=
br>
&gt; <br>
&gt; =EF=BB=BFHi Phil,<br>
&gt; <br>
&gt;&gt; On 23/12/24 14:53, Phil Dennis-Jordan wrote:<br>
&gt;&gt; On Thu, 19 Dec 2024 at 11:50, Akihiko Odaki &lt;<a href=3D"mailto:=
akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> &l=
t;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akih=
iko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 Reviewing &quot;[PATCH v2 6/6] hw/vmapple: XHCI contr=
oller&#39;s interrupt<br>
&gt;&gt;=C2=A0 =C2=A0 mapping workaround for macOS&quot;, I found a few pro=
blems so I&#39;m adding<br>
&gt;&gt;=C2=A0 =C2=A0 comments for them:<br>
&gt;&gt;=C2=A0 =C2=A0 On 2024/12/19 5:20, Phil Dennis-Jordan wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; From: Alexander Graf &lt;<a href=3D"mailto=
:graf@amazon.com" target=3D"_blank">graf@amazon.com</a> &lt;mailto:<a href=
=3D"mailto:graf@amazon.com" target=3D"_blank">graf@amazon.com</a>&gt;&gt;<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Apple defines a new &quot;vmapple&quot; ma=
chine type as part of its proprietary<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; macOS Virtualization.Framework vmm. This m=
achine type is similar<br>
&gt;&gt;=C2=A0 =C2=A0 to the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; virt one, but with subtle differences in b=
ase devices, a few special<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; vmapple device additions and a vastly diff=
erent boot chain.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; This patch reimplements this machine type =
in QEMU. To use it, you<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; have to have a readily installed version o=
f macOS for VMApple,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; run on macOS with -accel hvf, pass the Vir=
tualization.Framework<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; boot rom (AVPBooter) in via -bios, pass th=
e aux and root volume<br>
&gt;&gt;=C2=A0 =C2=A0 as pflash<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; and pass aux and root volume as virtio dri=
ves. In addition, you also<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; need to find the machine UUID and pass tha=
t as -M vmapple,uuid=3D<br>
&gt;&gt;=C2=A0 =C2=A0 parameter:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; $ qemu-system-aarch64 -accel hvf -M vmappl=
e,uuid=3D0x1234 -m 4G \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 -bios /System/Library/=
Frameworks/Virtualization.framework/<br>
&gt;&gt;=C2=A0 =C2=A0 Versions/A/Resources/AVPBooter.vmapple2.bin<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=
=3Dpflash,format=3Draw \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=
=3Dpflash,format=3Draw \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=
=3Dnone,id=3Daux,format=3Draw \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio=
-blk-pci,variant=3Daux,drive=3Daux \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=
=3Dnone,id=3Droot,format=3Draw \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio=
-blk-pci,variant=3Droot,drive=3Droot<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; With all these in place, you should be abl=
e to see macOS booting<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; successfully.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Known issues:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0- Keyboard and mouse/tablet in=
put is laggy. The reason for this is<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0that macOS&#39;s XHCI d=
river seems to expect interrupter mapping to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0be disabled when MSI/MS=
I-X is unavailable. I have found a<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0workaround but discover=
ed a bunch of other XHCI spec non-<br>
&gt;&gt;=C2=A0 =C2=A0 compliance<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0in the process, so I&#3=
9;m fixing all of those in a separate patch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0set.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0- Currently only macOS 12 gues=
ts are supported. The boot<br>
&gt;&gt;=C2=A0 =C2=A0 process for<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A013+ will need further i=
nvestigation and adjustment.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Alexander Graf &lt;<a href=
=3D"mailto:graf@amazon.com" target=3D"_blank">graf@amazon.com</a><br>
&gt;&gt;=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:graf@amazon.com" target=
=3D"_blank">graf@amazon.com</a>&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Co-authored-by: Phil Dennis-Jordan &lt;<a =
href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a>=
<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:phil@philjordan.eu" targ=
et=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a h=
ref=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a><=
br>
&gt;&gt;=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:phil@philjordan.eu" targ=
et=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"=
mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com=
</a><br>
&gt;&gt;=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Tested-by: Akihiko Odaki &lt;<a href=3D"ma=
ilto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</=
a><br>
&gt;&gt;=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; v3:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Rebased on latest upstream, =
updated affinity and NIC creation<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0API usage<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Included Apple-variant virti=
o-blk in build dependency<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Updated API usage for settin=
g &#39;redist-region-count&#39; array-<br>
&gt;&gt;=C2=A0 =C2=A0 typed property on GIC.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Switched from virtio HID dev=
ices (for which macOS 12 does not<br>
&gt;&gt;=C2=A0 =C2=A0 contain<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0drivers) to an XHCI USB=
 controller and USB HID devices.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; v4:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Fixups for v4 changes to the=
 other patches in the set.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Corrected the assert macro t=
o use<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Removed superfluous endian c=
onversions corresponding to cfg&#39;s.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Init error handling improvem=
ent.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* No need to select CPU type o=
n TCG, as only HVF is supported.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Machine type version bumped =
to 9.2<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* #include order improved<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; v5:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Fixed memory reservation for=
 ecam alias region.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Better error handling settin=
g properties on devices.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Simplified the machine ECID/=
UUID extraction script and<br>
&gt;&gt;=C2=A0 =C2=A0 actually created a<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0file for it rather than=
 quoting its code in documentation.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; v7:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Tiny error handling fix, un-=
inlined function.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; v8:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Use object_property_add_uint=
64_ptr rather than defining<br>
&gt;&gt;=C2=A0 =C2=A0 custom UUID<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0property get/set functi=
ons.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; v9:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Documentation improvements<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Fixed variable name and stru=
ct field used during pvpanic<br>
&gt;&gt;=C2=A0 =C2=A0 device creation.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; v10:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Documentation fixup for chan=
ged virtio-blk device type.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Small improvements to shell =
commands in documentation.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Improved propagation of erro=
rs during cfg device instantiation.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; v11:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Quoted more strings in the d=
ocumentation&#39;s shell script code.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; v13:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0* Bumped the machine type vers=
ion from 9.2 to 10.0.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0contrib/vmapple/uuid.sh=C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A09 +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0docs/system/arm/vmapple.rst |=
=C2=A0 63 ++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0docs/system/target-arm.rst=C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 20 ++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/vmapple/vmapple.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 648 +++++++++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0 +++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A07 files changed, 743 insertion=
s(+)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100755 contrib/vma=
pple/uuid.sh<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 docs/system=
/arm/vmapple.rst<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/=
vmapple.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 5d9d65e6df7..a8e3d3b74a2 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/MAINTAINERS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/MAINTAINERS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -2777,6 +2777,7 @@ M: Phil Dennis-Jorda=
n &lt;<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjord=
an.eu</a><br>
&gt;&gt;=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:phil@philjordan.eu" targ=
et=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0S: Maintained<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0F: hw/vmapple/*<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0F: include/hw/vmapple/*<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +F: docs/system/arm/vmapple.rst<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0Subsystems<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0----------<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/contrib/vmapple/uuid.sh b/con=
trib/vmapple/uuid.sh<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; new file mode 100755<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 00000000000..956e8c3afed<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- /dev/null<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/contrib/vmapple/uuid.sh<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -0,0 +1,9 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#!/bin/sh<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +# Used for converting a guest provisioned=
 using<br>
&gt;&gt;=C2=A0 =C2=A0 Virtualization.framework<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +# for use with the QEMU &#39;vmapple&#39;=
 aarch64 machine type.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +# Extracts the Machine UUID from Virtuali=
zation.framework VM<br>
&gt;&gt;=C2=A0 =C2=A0 JSON file.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +# (as produced by &#39;macosvm&#39;, pass=
ed as command line argument)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +plutil -extract machineId raw &quot;$1&qu=
ot; | base64 -d | plutil -extract<br>
&gt;&gt;=C2=A0 =C2=A0 ECID raw -<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/docs/system/arm/vmapple.rst b=
/docs/system/arm/<br>
&gt;&gt;=C2=A0 =C2=A0 vmapple.rst<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; new file mode 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 00000000000..5090a8997c3<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- /dev/null<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/docs/system/arm/vmapple.rst<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -0,0 +1,63 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +VMApple machine emulation<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +VMApple is the device model that the macO=
S built-in hypervisor<br>
&gt;&gt;=C2=A0 =C2=A0 called &quot;Virtualization.framework&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +exposes to Apple Silicon macOS guests. Th=
e &quot;vmapple&quot; machine<br>
&gt;&gt;=C2=A0 =C2=A0 model in QEMU implements the same<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +device model, but does not use any code f=
rom<br>
&gt;&gt;=C2=A0 =C2=A0 Virtualization.Framework.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +Prerequisites<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +-------------<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +To run the vmapple machine model, you nee=
d to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * Run on Apple Silicon<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * Run on macOS 12.0 or above<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * Have an already installed copy of a Vi=
rtualization.Framework<br>
&gt;&gt;=C2=A0 =C2=A0 macOS 12 virtual<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0machine. Note that newer ver=
sions than 12.x are currently NOT<br>
&gt;&gt;=C2=A0 =C2=A0 supported on<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0the guest side. I will assum=
e that you installed it using the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0`macosvm &lt;<a href=3D"http=
s://github.com/s-u/macosvm" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/s-u/macosvm</a> &lt;<a href=3D"https://github.com/" rel=3D"norefer=
rer" target=3D"_blank">https://github.com/</a><br>
&gt;&gt;=C2=A0 =C2=A0 s-u/macosvm&gt;&gt;` CLI.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +First, we need to extract the UUID from t=
he virtual machine that<br>
&gt;&gt;=C2=A0 =C2=A0 you installed. You can do this<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +by running the shell script in contrib/vm=
apple/uuid.sh on the<br>
&gt;&gt;=C2=A0 =C2=A0 macosvm.json file.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +.. code-block:: bash<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 :caption: uuid.sh script to extrac=
t the UUID from a<br>
&gt;&gt;=C2=A0 =C2=A0 macosvm.json file<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 $ contrib/vmapple/uuid.sh &quot;pa=
th/to/macosvm.json&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +Now we also need to trim the aux partitio=
n. It contains metadata<br>
&gt;&gt;=C2=A0 =C2=A0 that we can just discard:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +.. code-block:: bash<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 :caption: Command to trim the aux =
file<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 $ dd if=3D&quot;aux.img&quot; of=
=3D&quot;aux.img.trimmed&quot; bs=3D$(( 0x4000 )) skip=3D1<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +How to run<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +----------<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +Then, we can launch QEMU with the Virtual=
ization.Framework pre-<br>
&gt;&gt;=C2=A0 =C2=A0 boot environment and the readily<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +installed target disk images. I recommend=
 to port forward the<br>
&gt;&gt;=C2=A0 =C2=A0 VM&#39;s ssh and vnc ports to the host<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +to get better interactive access into the=
 target system:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +.. code-block:: bash<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 :caption: Example execution comman=
d line<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 $ UUID=3D&quot;$(contrib/vmapple/u=
uid.sh &#39;macosvm.json&#39;)&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 $ AVPBOOTER=3D&quot;/System/Librar=
y/Frameworks/<br>
&gt;&gt;=C2=A0 =C2=A0 Virtualization.framework/Resources/AVPBooter.vmapple2=
.bin&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 $ AUX=3D&quot;aux.img.trimmed&quot=
;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 $ DISK=3D&quot;disk.img&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 $ qemu-system-aarch64 \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-serial mon:st=
dio \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-m 4G \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-accel hvf \<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-M vmapple,uui=
d=3D&quot;$UUID&quot; \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-bios &quot;$A=
VPBOOTER&quot; \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D=
&quot;$AUX&quot;,if=3Dpflash,format=3Draw \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D=
&quot;$DISK&quot;,if=3Dpflash,format=3Draw \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D=
&quot;$AUX&quot;,if=3Dnone,id=3Daux,format=3Draw \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D=
&quot;$DISK&quot;,if=3Dnone,id=3Droot,format=3Draw \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmappl=
e-virtio-blk-pci,variant=3Daux,drive=3Daux \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmappl=
e-virtio-blk-pci,variant=3Droot,drive=3Droot \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-netdev<br>
&gt;&gt;=C2=A0 =C2=A0 user,id=3Dnet0,ipv6=3Doff,hostfwd=3Dtcp::2222-:22,hos=
tfwd=3Dtcp::5901-:5900 \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device virtio=
-net-pci,netdev=3Dnet0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/docs/system/target-arm.rst b/=
docs/system/target-arm.rst<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 9aaa9c414c9..3426f79100b 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/docs/system/target-arm.rst<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/docs/system/target-arm.rst<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -102,6 +102,7 @@ Board-specific documen=
tation<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 arm/stellaris<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 arm/stm32<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 arm/virt<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0arm/vmapple<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 arm/xenpvh<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 arm/xlnx-versal-virt<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 arm/xlnx-zynq<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapp=
le/Kconfig<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index bcd1be63e3c..6a4c4a7fa2e 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/vmapple/Kconfig<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/vmapple/Kconfig<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -10,3 +10,23 @@ config VMAPPLE_CFG<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0config VMAPPLE_VIRTIO_BLK<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +config VMAPPLE<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 bool<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 depends on ARM<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 depends on HVF<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 default y if ARM<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select ARM_GIC<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select PLATFORM_BUS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select PCI_EXPRESS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select PCI_EXPRESS_GENERIC_=
BRIDGE<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select PL011 # UART<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select PL031 # RTC<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select PL061 # GPIO<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select GPIO_PWR<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select PVPANIC_MMIO<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select VMAPPLE_AES<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select VMAPPLE_BDIF<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select VMAPPLE_CFG<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select MAC_PVG_MMIO<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 select VMAPPLE_VIRTIO_BLK<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/vmapple/meson.build b/hw/v=
mapple/meson.build<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index bf17cf906c9..e572f7d5602 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/vmapple/meson.build<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/vmapple/meson.build<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -2,3 +2,4 @@ system_ss.add(when: &#39;C=
ONFIG_VMAPPLE_AES&#39;,=C2=A0 =C2=A0 =C2=A0if_true: files(&#39;aes.c&#39;))=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFI=
G_VMAPPLE_BDIF&#39;, if_true:<br>
&gt;&gt;=C2=A0 =C2=A0 files(&#39;bdif.c&#39;))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFI=
G_VMAPPLE_CFG&#39;,=C2=A0 if_true: files(&#39;cfg.c&#39;))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFI=
G_VMAPPLE_VIRTIO_BLK&#39;,=C2=A0 if_true:<br>
&gt;&gt;=C2=A0 =C2=A0 files(&#39;virtio-blk.c&#39;))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +specific_ss.add(when: &#39;CONFIG_VMAPPLE=
&#39;,=C2=A0 =C2=A0 =C2=A0if_true:<br>
&gt;&gt;=C2=A0 =C2=A0 files(&#39;vmapple.c&#39;))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/vmapple/vmapple.c b/hw/vma=
pple/vmapple.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; new file mode 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 00000000000..66336942c8d<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- /dev/null<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/vmapple/vmapple.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -0,0 +1,648 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +/*<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * VMApple machine emulation<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + *<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc.=
 or its affiliates. All<br>
&gt;&gt;=C2=A0 =C2=A0 Rights Reserved.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + *<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * This work is licensed under the terms =
of the GNU GPL, version<br>
&gt;&gt;=C2=A0 =C2=A0 2 or later.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * See the COPYING file in the top-level =
directory.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + *<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * SPDX-License-Identifier: GPL-2.0-or-la=
ter<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + *<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * VMApple is the device model that the m=
acOS built-in<br>
&gt;&gt;=C2=A0 =C2=A0 hypervisor called<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * &quot;Virtualization.framework&quot; e=
xposes to Apple Silicon macOS<br>
&gt;&gt;=C2=A0 =C2=A0 guests. The<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * machine model in this file implements =
the same device model<br>
&gt;&gt;=C2=A0 =C2=A0 in QEMU, but<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * does not use any code from Virtualizat=
ion.Framework.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; + */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/datadir.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/error-report.h&quot;<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/guest-random.h&quot;<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/help-texts.h&quot;<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/log.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/module.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/option.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qemu/units.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;monitor/qdev.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/boards.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/irq.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/loader.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/qdev-properties.h&quot;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/usb.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/arm/boot.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/arm/primecell.h&quot;<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/char/pl011.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/intc/arm_gic.h&quot;<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/intc/arm_gicv3_common.h=
&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/misc/pvpanic.h&quot;<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/pci-host/gpex.h&quot;<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/usb/xhci.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/virtio/virtio-pci.h&quo=
t;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;hw/vmapple/vmapple.h&quot;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;net/net.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qapi/error.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qapi/qmp/qlist.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;qapi/qapi-visit-common.h&q=
uot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;standard-headers/linux/inp=
ut.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;sysemu/hvf.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;sysemu/kvm.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;sysemu/reset.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;sysemu/runstate.h&quot;<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;target/arm/internals.h&quo=
t;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#include &quot;target/arm/kvm_arm.h&quot;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +struct VMAppleMachineClass {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 MachineClass parent;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +};<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +struct VMAppleMachineState {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 MachineState parent;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 Notifier machine_done;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 struct arm_boot_info bootin=
fo;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 MemMapEntry *memmap;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 const int *irqmap;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 DeviceState *gic;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 DeviceState *cfg;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 DeviceState *pvpanic;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 Notifier powerdown_notifier=
;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 PCIBus *bus;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 MemoryRegion fw_mr;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 MemoryRegion ecam_alias;<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 uint64_t uuid;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +};<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define DEFINE_VMAPPLE_MACHINE_LATEST(maj=
or, minor, latest) \<br>
&gt;&gt;=C2=A0 =C2=A0 This macro has suffix &quot;_LATEST&quot;, but it is =
used not only for the latest<br>
&gt;&gt;=C2=A0 =C2=A0 version but also for older versions.<br>
&gt;&gt;=C2=A0 =C2=A0 include/hw/boards.h suggests using &quot;_IMPL&quot; =
suffix.<br>
&gt;&gt; Thanks for pointing this out, I&#39;ve fixed it locally and will i=
nclude it in v16.<br>
&gt; <br>
&gt; Do you have other changes in your v16? I&#39;m quite happy to integrat=
e this<br>
&gt; v15.<br>
<br>
The ones proposed by Akihiko are the only ones. I=E2=80=99ve already implem=
ented them, so I=E2=80=99m happy to post v16.<br></blockquote><div><br></di=
v><div>OK, rebasing on the upstream master branch has revealed it&#39;s not=
 quite so simple: there are a bunch of clashes with the recent sysemu-&gt;s=
ystem rename and the removal of DEFINE_PROP_END_OF_LIST(). They amount to p=
retty trivial changes, but almost all commits needed adjusting, so pulling =
v15 would be painful. I&#39;ve just posted my v16 (including all the change=
s discussed here).</div><div><br></div><div>Thanks for taking an interest i=
n this patch set!<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt;&gt; Adapting this giant macro for each machine type seems rather error=
-prone and the kind of thing a computer does better than a human writing th=
e code. I can&#39;t help but wonder if we could define a generic version in=
 boards.h and only implement the DEFINE_*_MACHINE{_LATEST,}() wrappers spec=
ifically for each machine type. I&#39;ve created an issue for this on GitLa=
b: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2744" rel=3D"no=
referrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/2=
744</a> &lt;https:// <a href=3D"http://gitlab.com/qemu-project/qemu/-/issue=
s/2744" rel=3D"noreferrer" target=3D"_blank">gitlab.com/qemu-project/qemu/-=
/issues/2744</a>&gt; I might attack that once I&#39;ve cut down my backlog =
of unmerged patches.<br>
&gt; <br>
&gt; Do we really want the vmapple machines to be versioned? I see 3 option=
s:<br>
&gt; 1/ No (simplest)<br>
&gt; 2/ Not yet, adding versioning when we see the needs<br>
&gt; 3/ Yes<br>
&gt; <br>
&gt; Personally I prefer/recommend 1/ or 2/ ;)<br>
<br>
I didn=E2=80=99t realise these were an option. :-) I was just inheriting Al=
ex=E2=80=99s code here and assumed it was the standard thing to do.<br>
<br>
I could imagine we might change a few things to get better guest version su=
pport and perhaps the guest iCloud support that was added to the Virtualiza=
tion.framework in macOS 15. But yeah it seems unlikely that any of this wou=
ld cause regressions.<br>
<br>
What change would you propose to remove the versioning? Is there a specific=
 machine type I should use as reference? Or do you just want to change that=
 yourself, if I push my v16 code to a public repository?<br>
<br></blockquote><div><br></div><div>OK, grepping through the code base rev=
eals there are quite a number of the &quot;smaller&quot; machine types are =
unversioned. So I guess that&#39;s a no-brainer then. I&#39;ve worked out I=
 essentially just need to move the compat properties registration to the ma=
in init, the &quot;desc&quot; field on the machine class needs to be set, a=
nd the type becomes non-abstract. Everything still appears to work when I a=
dd that back in after removing all the macro definitions and instantiations=
. Change included in v16, but I&#39;ve still got the reverse of the removal=
 commit around, so if anyone has good arguments why we need it, I can easil=
y add versioning back in.<br></div><div><br></div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 static void<br>
&gt;&gt;=C2=A0 =C2=A0 vmapple##major##_##minor##_class_init(ObjectClass *oc=
, \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *da=
ta) \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 { \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MachineClass =
*mc =3D MACHINE_CLASS(oc); \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmapple_machi=
ne_##major##_##minor##_options(mc); \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;desc =
=3D &quot;QEMU &quot; # major &quot;.&quot; # minor &quot; Apple Virtual<br=
>
&gt;&gt;=C2=A0 =C2=A0 Machine&quot;; \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (latest) {=
 \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 mc-&gt;alias =3D &quot;vmapple&quot;; \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 } \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 static const TypeInfo machv=
mapple##major##_##minor##_info =3D { \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D MAC=
HINE_TYPE_NAME(&quot;vmapple-&quot; # major &quot;.&quot; # minor), \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D T=
YPE_VMAPPLE_MACHINE, \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =
=3D vmapple##major##_##minor##_class_init, \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 }; \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 static void machvmapple_mac=
hine_##major##_##minor##_init(void) \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 { \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
type_register_static(&amp;machvmapple##major##_##minor##_info); \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 } \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 type_init(machvmapple_machi=
ne_##major##_##minor##_init);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(=
major, minor) \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 DEFINE_VMAPPLE_MACHINE_LATE=
ST(major, minor, true)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define DEFINE_VMAPPLE_MACHINE(major, min=
or) \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 DEFINE_VMAPPLE_MACHINE_LATE=
ST(major, minor, false)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define TYPE_VMAPPLE_MACHINE=C2=A0 =C2=A0=
MACHINE_TYPE_NAME(&quot;vmapple&quot;)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +OBJECT_DECLARE_TYPE(VMAppleMachineState, =
VMAppleMachineClass,<br>
&gt;&gt;=C2=A0 =C2=A0 VMAPPLE_MACHINE)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +/* Number of external interrupt lines to =
configure the GIC with */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define NUM_IRQS 256<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +enum {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_FIRMWARE,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_CONFIG,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_MEM,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_GIC_DIST,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_GIC_REDIST,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_UART,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_RTC,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_PCIE,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_PCIE_MMIO,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_PCIE_ECAM,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_GPIO,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_PVPANIC,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_APV_GFX,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_APV_IOSFC,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_AES_1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_AES_2,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_BDOOR,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 VMAPPLE_MEMMAP_LAST,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +};<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +static MemMapEntry memmap[] =3D {<br>
&gt; <br>
&gt; const<br><br></blockquote><div><br></div><div>Ack, fixed.<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_FIRMWARE] =3D=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x00100000, 0x00100000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_CONFIG] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x00400000, 0x00010000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_GIC_DIST] =3D=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x10000000, 0x00010000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_GIC_REDIST] =3D=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x10010000, 0x00400000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_UART] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x20010000, 0x00010000 },=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_RTC] =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x20050000, 0x00001000 },<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_GPIO] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x20060000, 0x00001000 },=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_PVPANIC] =3D=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x20070000, 0x00000002 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_BDOOR] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30000000, 0x00200000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_GFX] =3D=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30200000, 0x00010000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_IOSFC] =3D=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30210000, 0x00010000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_AES_1] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30220000, 0x00004000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_AES_2] =3D=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x30230000, 0x00004000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_PCIE_ECAM] =3D=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x40000000, 0x10000000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_PCIE_MMIO] =3D=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x50000000, 0x1fff0000 },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /* Actual RAM size depends =
on configuration */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_MEM] =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x70000000ULL, GiB},<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +};<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +static const int irqmap[] =3D {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_UART] =3D 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_RTC] =3D 2,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_GPIO] =3D 0x5,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_IOSFC] =3D 0x1=
0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_GFX] =3D 0x11,=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_AES_1] =3D 0x12,<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 [VMAPPLE_PCIE] =3D 0x20,<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; +};<br>
&gt; <br>
</blockquote></div></div>
</div>

--000000000000130bd60629f75dc0--

