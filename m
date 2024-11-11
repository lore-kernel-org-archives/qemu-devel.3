Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AB4D2E9FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 14:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAV04-00009w-Gf; Mon, 11 Nov 2024 09:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tAV02-00009Y-Nx
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:02:38 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tAUzq-0005OK-86
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:02:38 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7eda47b7343so3002197a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731333744; x=1731938544;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/r8uqvyuHbsX5L3lvPG2yWXMu00Q4BTaNWx+b1xHXC0=;
 b=joL6O8F7MB5oVQWwYiSPv9cusvEr2lZhJAsxFMH2PozXxbjOUp9gDR+p5Cg08B8F8k
 5d53AlpPVy3/FJjJcX/2tlIX7x/5ZFQYM76xeip+uSuS39ju3Y4tlx+0e7blOUuPsAgj
 +7b6/F6Xg1YjZe3wpOW61oIxElFty/aCAs4LPVNVYQkZDCklwK/Ro3DtHko+X5SODczf
 Ax19BmXV8NpIGxTarjoyGObS4zdynN2fUC0L+AbmsZhmy5SWza76mn7wQLpoxNvOUCn9
 MtEKUHSFagkyQpgB5Luvx+P+HFjTbDM0BVQzI8JMoLZUNY3WRvgU3Rr7/tvkBw78Ro7D
 er0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731333744; x=1731938544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/r8uqvyuHbsX5L3lvPG2yWXMu00Q4BTaNWx+b1xHXC0=;
 b=jnJ7ByUejgjz2ihJAmwVQJKEA8zoOeypkrfKqRgZU2dAk8eH6r58pAp6K8bQXkHzQ9
 LtkfWkddKP/CSckYa2gqr9+Buo1zKQX3+D4LlMmbNizWUBXzqoYSaxOg1I1Jz4L1iapx
 Otl/Sl4g5S9P0CuLNwRj6Ie97k+bMCvcyGPTbPmgKMxUBXt7H6tqeNgJhU+ev31lfe/e
 4PA4OFT0lR2xfWUeRlemaPybNKI+mtSFz3O7TqKWqLbtqvWKW0d+QjdUQ067PNKO/l5z
 xBychecOZTcBhURkQmQ+z+jfe5UoOUW7S0PyxNuwTnGb1zeB6lstRVZfQ7w0BBpXMs0v
 ejuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTmba8XgObyPiIRz94JVhOjOmFqlVAcVJ2AKqDCOGPwgiSjMtpShDAf6I2kurqP6WhszkR/utCWRoU@nongnu.org
X-Gm-Message-State: AOJu0Yyxq/M00jAOjcBViltxt497PuaTz14k96Leo65GE4Zopnxd3vBI
 s99a0+sTZ+CmHljvv/efTnqBFWFO6eIrTfbCNEmoEsbiiQD/XAgD6Ih2M2sTk4rEdmRhBLCRopN
 mgdKAVS6n8p9MMAQSgp7nwkWm0vR7FUizLjvo
X-Google-Smtp-Source: AGHT+IHOXqb+geiT1LZcNdcYAkAHcoMPWlS8JSZdpwb0kvNPkalT11BFLvVixucXrDlb63DE8bSKU2aFv0xYfJJnaEw=
X-Received: by 2002:a17:90b:1344:b0:2c9:5a85:f8dd with SMTP id
 98e67ed59e1d1-2e9b174124cmr19227169a91.18.1731333742125; Mon, 11 Nov 2024
 06:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-16-phil@philjordan.eu>
 <388c911e-bd7a-45ad-8188-c1321b12f80c@daynix.com>
 <CAGCz3vsnUqeVxtgqbcDibtTzvdxYDGWMAGHDygGVdzbSis=cgQ@mail.gmail.com>
 <6a9ad03e-dff8-4229-97f2-9bace2721fed@daynix.com>
In-Reply-To: <6a9ad03e-dff8-4229-97f2-9bace2721fed@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Mon, 11 Nov 2024 15:02:10 +0100
Message-ID: <CAGCz3vvcPOoHPFRNx7wncrSN-Bdet+M0iDeTO6reWQ5gF-4MvA@mail.gmail.com>
Subject: Re: [PATCH v8 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, pbonzini@redhat.com, rad@semihalf.com, 
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/mixed; boundary="000000000000b077ca0626a38ca0"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::529;
 envelope-from=lists@philjordan.eu; helo=mail-pg1-x529.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000b077ca0626a38ca0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 at 05:42, Akihiko Odaki <akihiko.odaki@daynix.com> wrot=
e:
>
> On 2024/11/11 5:18, Phil Dennis-Jordan wrote:
> > I've applied the majority of this feedback in the soon-to-be-posted v9
> > of the patch set, thanks!
> >
> > Just a few extra comments/replies below:
> >
> > On Sun, 10 Nov 2024 at 08:38, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
> >>
> >> On 2024/11/08 23:47, Phil Dennis-Jordan wrote:
> >>> From: Alexander Graf <graf@amazon.com>
> >>>
> >>> Apple defines a new "vmapple" machine type as part of its proprietary
> >>> macOS Virtualization.Framework vmm. This machine type is similar to t=
he
> >>> virt one, but with subtle differences in base devices, a few special
> >>> vmapple device additions and a vastly different boot chain.
> >>>
> >>> This patch reimplements this machine type in QEMU. To use it, you
> >>> have to have a readily installed version of macOS for VMApple,
> >>> run on macOS with -accel hvf, pass the Virtualization.Framework
> >>> boot rom (AVPBooter) in via -bios, pass the aux and root volume as pf=
lash
> >>> and pass aux and root volume as virtio drives. In addition, you also
> >>> need to find the machine UUID and pass that as -M vmapple,uuid=3D par=
ameter:
> >>>
> >>> $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G \
> >>>       -bios /System/Library/Frameworks/Virtualization.framework/Versi=
ons/A/Resources/AVPBooter.vmapple2.bin
> >>>       -drive file=3Daux,if=3Dpflash,format=3Draw \
> >>>       -drive file=3Droot,if=3Dpflash,format=3Draw \
> >>>       -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw \
> >>>       -device vmapple-virtio-aux,drive=3Daux \
> >>>       -drive file=3Droot,if=3Dnone,id=3Droot,format=3Draw \
> >>>       -device vmapple-virtio-root,drive=3Droot
> >>>
> >>> With all these in place, you should be able to see macOS booting
> >>> successfully.
> >>>
> >>> Known issues:
> >>>    - Keyboard and mouse/tablet input is laggy. The reason for this is
> >>>      either that macOS's XHCI driver is broken when the device/platfo=
rm
> >>>      does not support MSI/MSI-X, or there's some unfortunate interpla=
y
> >>>      with Qemu's XHCI implementation in this scenario.
> >>>    - Currently only macOS 12 guests are supported. The boot process f=
or
> >>>      13+ will need further investigation and adjustment.
> >>>
> >>> Signed-off-by: Alexander Graf <graf@amazon.com>
> >>> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> >>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> >>> ---
> >>>
> >>> v3:
> >>>    * Rebased on latest upstream, updated affinity and NIC creation
> >>>      API usage
> >>>    * Included Apple-variant virtio-blk in build dependency
> >>>    * Updated API usage for setting 'redist-region-count' array-typed =
property
> >>>      on GIC.
> >>>    * Switched from virtio HID devices (for which macOS 12 does not co=
ntain
> >>>      drivers) to an XHCI USB controller and USB HID devices.
> >>>
> >>> v4:
> >>>    * Fixups for v4 changes to the other patches in the set.
> >>>    * Corrected the assert macro to use
> >>>    * Removed superfluous endian conversions corresponding to cfg's.
> >>>    * Init error handling improvement.
> >>>    * No need to select CPU type on TCG, as only HVF is supported.
> >>>    * Machine type version bumped to 9.2
> >>>    * #include order improved
> >>>
> >>> v5:
> >>>    * Fixed memory reservation for ecam alias region.
> >>>    * Better error handling setting properties on devices.
> >>>    * Simplified the machine ECID/UUID extraction script and actually =
created a
> >>>      file for it rather than quoting its code in documentation.
> >>>
> >>> v7:
> >>>    * Tiny error handling fix, un-inlined function.
> >>>
> >>> v8:
> >>>    * Use object_property_add_uint64_ptr rather than defining custom U=
UID
> >>>      property get/set functions.
> >>>
> >>>    MAINTAINERS                 |   1 +
> >>>    contrib/vmapple/uuid.sh     |   9 +
> >>>    docs/system/arm/vmapple.rst |  60 ++++
> >>>    docs/system/target-arm.rst  |   1 +
> >>>    hw/vmapple/Kconfig          |  20 ++
> >>>    hw/vmapple/meson.build      |   1 +
> >>>    hw/vmapple/vmapple.c        | 638 ++++++++++++++++++++++++++++++++=
++++
> >>>    7 files changed, 730 insertions(+)
> >>>    create mode 100755 contrib/vmapple/uuid.sh
> >>>    create mode 100644 docs/system/arm/vmapple.rst
> >>>    create mode 100644 hw/vmapple/vmapple.c
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 9d0d26cb65f..9591fd44a34 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -2767,6 +2767,7 @@ R: Phil Dennis-Jordan <phil@philjordan.eu>
> >>>    S: Maintained
> >>>    F: hw/vmapple/*
> >>>    F: include/hw/vmapple/*
> >>> +F: docs/system/arm/vmapple.rst
> >>>
> >>>    Subsystems
> >>>    ----------
> >>> diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
> >>> new file mode 100755
> >>> index 00000000000..956e8c3afed
> >>> --- /dev/null
> >>> +++ b/contrib/vmapple/uuid.sh
> >>> @@ -0,0 +1,9 @@
> >>> +#!/bin/sh
> >>> +# Used for converting a guest provisioned using Virtualization.frame=
work
> >>> +# for use with the QEMU 'vmapple' aarch64 machine type.
> >>> +#
> >>> +# Extracts the Machine UUID from Virtualization.framework VM JSON fi=
le.
> >>> +# (as produced by 'macosvm', passed as command line argument)
> >>> +
> >>> +plutil -extract machineId raw "$1" | base64 -d | plutil -extract ECI=
D raw -
> >>> +
> >>> diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rs=
t
> >>> new file mode 100644
> >>> index 00000000000..6a634fa4572
> >>> --- /dev/null
> >>> +++ b/docs/system/arm/vmapple.rst
> >>> @@ -0,0 +1,60 @@
> >>> +VMApple machine emulation
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +VMApple is the device model that the macOS built-in hypervisor calle=
d "Virtualization.framework"
> >>> +exposes to Apple Silicon macOS guests. The "vmapple" machine model i=
n QEMU implements the same
> >>> +device model, but does not use any code from Virtualization.Framewor=
k.
> >>> +
> >>> +Prerequisites
> >>> +-------------
> >>> +
> >>> +To run the vmapple machine model, you need to
> >>> +
> >>> + * Run on Apple Silicon
> >>> + * Run on macOS 12.0 or above
> >>> + * Have an already installed copy of a Virtualization.Framework macO=
S 12 virtual machine. I will
> >>> +   assume that you installed it using the macosvm CLI.
> >>
> >> Add a URL to macosvm.
> >>
> >>> +
> >>> +First, we need to extract the UUID from the virtual machine that you=
 installed. You can do this
> >>> +by running the shell script in contrib/vmapple/uuid.sh on the macosv=
m.json file.
> >>> +
> >>> +.. code-block:: bash
> >>> +  :caption: uuid.sh script to extract the UUID from a macosvm.json f=
ile
> >>> +
> >>> +  $ contrib/vmapple/uuid.sh "path/to/macosvm.json"
> >>> +
> >>> +Now we also need to trim the aux partition. It contains metadata tha=
t we can just discard:
> >>> +
> >>> +.. code-block:: bash
> >>> +  :caption: Command to trim the aux file
> >>> +
> >>> +  $ dd if=3D"aux.img" of=3D"aux.img.trimmed" bs=3D$(( 0x4000 )) skip=
=3D1
> >>
> >> Quoting is inconsistent. aux.img.trimmed is not quoted below but it is
> >> quoted here.
> >>
> >>> +
> >>> +How to run
> >>> +----------
> >>> +
> >>> +Then, we can launch QEMU with the Virtualization.Framework pre-boot =
environment and the readily
> >>> +installed target disk images. I recommend to port forward the VM's s=
sh and vnc ports to the host
> >>> +to get better interactive access into the target system:
> >>> +
> >>> +.. code-block:: bash
> >>> +  :caption: Example execution command line
> >>> +
> >>> +  $ UUID=3D$(uuid.sh macosvm.json)
> >>> +  $ AVPBOOTER=3D/System/Library/Frameworks/Virtualization.framework/=
Resources/AVPBooter.vmapple2.bin
> >>> +  $ AUX=3Daux.img.trimmed
> >>> +  $ DISK=3Ddisk.img
> >>> +  $ qemu-system-aarch64 \
> >>> +       -serial mon:stdio \
> >>> +       -m 4G \
> >>> +       -accel hvf \
> >>> +       -M vmapple,uuid=3D$UUID \
> >>> +       -bios $AVPBOOTER \
> >>
> >> $AUX and $DISK are quoted but $UUID and $AVPBOOTER are not.
> >>
> >>> +        -drive file=3D"$AUX",if=3Dpflash,format=3Draw \
> >>> +        -drive file=3D"$DISK",if=3Dpflash,format=3Draw \
> >>
> >> These two lines are misaligned.
> >>
> >>> +       -drive file=3D"$AUX",if=3Dnone,id=3Daux,format=3Draw \
> >>> +       -drive file=3D"$DISK",if=3Dnone,id=3Droot,format=3Draw \
> >>> +       -device vmapple-virtio-aux,drive=3Daux \
> >>> +       -device vmapple-virtio-root,drive=3Droot \
> >>> +       -net user,ipv6=3Doff,hostfwd=3Dtcp::2222-:22,hostfwd=3Dtcp::5=
901-:5900 \
> >>> +       -net nic,model=3Dvirtio-net-pci \
> >>
> >> -net is a legacy option and creates a unnecessary indirection with hub=
.
> >> Use -netdev and -device options. Also plug virtio-net-pci into a PCIe
> >> root port as suggested in: docs/pcie.txt
> >
> > I have not had any success with booting macOS with the block devices
> > connected to PCIe root ports, and similarly the network doesn't come
> > up if I attach just the virtio-net-pci device to one.
> >
> > As far as I can tell (ioreg), Apple's own VMapple machine type does
> > not use PCIe root ports, but I'm not 100% sure. The PCIe documentation
> > is generally rather focused on x86 and on running Linux in the 'virt'
> > machine type.
>
> Without a PCIe root port, virtio devices will be forced to work as a PCI
> device (not PCIe) and to use its "legacy" interface. I don't think
> Virtualization.framework uses the legacy interface though.

I'm not sure that's true, the GPEX controller purports to support PCIe
in some form. And even if it is falling back to legacy Virtio mode,
the guest OS doesn't appear to care. The guest's view of the PCI(e?)
setup looks extremely similar between Virtualization.framework and the
Qemu vmapple machine type we're adding here. I've attached `ioreg`
output for some relevant I/O registry node types for both Qemu
(vmapple-qemu-ioreg.txt) and macosvm (vmapple-vzfwk-ioreg.txt).

> > In any case, a far more pressing issue is MSI support, without which
> > the XHCI driver fails to receive most kinds of notifications from the
> > USB controller. (Therefore keyboard/mouse is currently very laggy.)
> > The arm 'virt' machine type supposedly supports it via the GIC ITS
> > device, but I've so far not managed to transfer this to 'vmapple' in a
> > way that makes the guest OS detect MSI support. Anyway, in its current
> > iteration, the machine type is good enough to be used for some tasks,
> > and we can always refine it later. (Another major limitation is of
> > course guest support for OS versions > 12 - but those issues might
> > even be related.)
>
> Perhaps the MSI issue may be also related to PCIe.

MSI is certainly intended to be the "native" method for implementing
interrupts on PCIe. However:

Reviewing the ioreg output, I actually see no evidence that
Virtualization.framework is even using MSIs. In particular, take note
of the IOInterruptControllers property on each IOPCIDevice. In both
VZ.fwk and Qemu vmapple, the Virtio and XHCI devices use this:

                |   "IOInterruptControllers" =3D ("IOInterruptController000=
00037")

This in turn simply corresponds to the GIC:

            +-o AppleARMGICv3  <class AppleARMGICv3, id 0x10000016b,
registered, matched, active, busy 0 (4 ms), retain 6>
                {
=E2=80=A6
                  "InterruptControllerName" =3D "IOInterruptController00000=
037"
=E2=80=A6

On a physical Mac, or an x86-64 VM, there will additionally be a
separate interrupt controller object for MSIs, which is a subclass of
IOPCIMessagedInterruptController.

So perhaps the problem isn't lack of MSIs after all (the guest even
may not support them) but rather that Qemu's XHCI controller doesn't
implement the case of 1 interrupter in a way that macOS's XHCI driver
supports.

(Qemu's XHCI controller defaults to 16 interrupters, with 1 MSI vector
per interrupter. When MSIs are unavailable, numintrs remains 16 even
though the legacy interrupt mechanism only provides a single IRQ line,
and when the XHCI controller tries to signal vector 1 or higher, the
guest isn't notified. Unfortunately, a quick hack that detects lack of
MSI support and sets numintrs to 1 makes things even worse. I've tried
this with an x86-64 VM as well, and the macOS guest stops being able
to drive the XHCI controller correctly when I force numintrs to 1.

Linux guests were able to cope with it if I remember correctly though,
so I'm not sure where exactly the problem lies:
 A. Does Qemu implement numintrs=3D1 badly, but Linux's driver is
tolerant enough to make it work regardless?
 B. Or does macOS's XHCI driver expect a very specific device
behaviour with numintrs=3D1, which doesn't match Qemu's?
Either way, we can't fix it on the guest side here=E2=80=A6

Interestingly, Virtualization.framework also exposes an
AppleVirtIOUSBDeviceController to the guest. This isn't used for the
virtual keyboard and digitiser though, and I've not found any protocol
information on USB-over-Virtio, so who knows if that would be in any
way useful as a generic USB controller.)

Long story short: I think we're best off leaving the PCI(e) setup as
it is for the moment until we figure out exactly what's needed to fix
the XHCI controller.

> > One thing I am thinking about changing (as we've now missed the 9.2
> > merge window anyway, sigh) as it would be non-backwards-compatible is
> > replacing the vmapple-virtio-aux/vmapple-virtio-root pair of devices
> > with just the the base type, vmapple-virtio-blk-pci, and adding a
> > variant property to it. So:
> >
> >         -device vmapple-virtio-blk-pci,variant=3Daux,drive=3Daux \
> >         -device vmapple-virtio-blk-pci,variant=3Droot,drive=3Droot \
> >
> > I think this would make hw/vmapple/virtio-blk.c somewhat more readable
> > and also significantly shorter.
>
> I agree. It will be a nice improvement.

--000000000000b077ca0626a38ca0
Content-Type: text/plain; charset="US-ASCII"; name="vmapple-vzfwk-ioreg.txt"
Content-Disposition: attachment; filename="vmapple-vzfwk-ioreg.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m3d3e99f0>
X-Attachment-Id: f_m3d3e99f0

JSBpb3JlZyAtdHJjIElPUENJRGV2aWNlCistbyBSb290ICA8Y2xhc3MgSU9SZWdpc3RyeUVudHJ5
LCBpZCAweDEwMDAwMDEwMCwgcmV0YWluIDc+CiAgKy1vIFZNQTJNQUNPU0FQICA8Y2xhc3MgSU9Q
bGF0Zm9ybUV4cGVydERldmljZSwgaWQgMHgxMDAwMDAxMzUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICg4ODYxIG1zKSwgcmV0YWluIDI2PgogICAgKy1vIEFwcGxlVmlydHVh
bFBsYXRmb3JtQVJNUEUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUFSTVBFLCBpZCAweDEw
MDAwMDEzOSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI4NSBtcyksIHJl
dGFpbiAyMSQKICAgICAgKy1vIGFybS1pbyAgPGNsYXNzIElPUGxhdGZvcm1EZXZpY2UsIGlkIDB4
MTAwMDAwMTE1LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjg0IG1zKSwg
cmV0YWluIDE1PgogICAgICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUlPICA8Y2xhc3MgQXBw
bGVWaXJ0dWFsUGxhdGZvcm1JTywgaWQgMHgxMDAwMDAxNjEsICFyZWdpc3RlcmVkLCAhbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDI4MSBtcyksIHJldGFpbiAxMiQKICAgICAgICAgICstbyBwY2ll
QDMwMDAwMDAwICA8Y2xhc3MgQXBwbGVBUk1JT0RldmljZSwgaWQgMHgxMDAwMDAxMWEsIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyMjcgbXMpLCByZXRhaW4gMTc+CiAgICAg
ICAgICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQ
bGF0Zm9ybVBDSUUsIGlkIDB4MTAwMDAwMTZlLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUs
IGJ1c3kgMCAoMjI0IG1zKSwgcmV0JAogICAgICAgICAgICAgICstbyBwY2kxMDZiLDFhMDVAMCAg
PGNsYXNzIElPUENJRGV2aWNlLCBpZCAweDEwMDAwMDE3MCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDIgbXMpLCByZXRhaW4gOD4KICAgICAgICAgICAgICAgICAgewogICAg
ICAgICAgICAgICAgICAgICJjb21wYXRpYmxlIiA9IDwicGNpMTA2YiwxYTA1IiwicGNpY2xhc3Ms
MDYwMDAwIj4KICAgICAgICAgICAgICAgICAgICAiSU9TZXJ2aWNlREVYVEVudGl0bGVtZW50cyIg
PSAoKCJjb20uYXBwbGUuZGV2ZWxvcGVyLmRyaXZlcmtpdC50cmFuc3BvcnQucGNpIikpCiAgICAg
ICAgICAgICAgICAgICAgIklPTmFtZSIgPSAicGNpMTA2YiwxYTA1IgogICAgICAgICAgICAgICAg
ICAgICJyZWciID0gPDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA+CiAg
ICAgICAgICAgICAgICAgICAgImRldmljZS1pZCIgPSA8MDUxYTAwMDA+CiAgICAgICAgICAgICAg
ICAgICAgIklPUG93ZXJNYW5hZ2VtZW50IiA9IHsiQ3VycmVudFBvd2VyU3RhdGUiPTIsIkNhcGFi
aWxpdHlGbGFncyI9MjU4LCJDaGlsZFByb3h5UG93ZXJTdGF0ZSI9MiwiTWF4UG93ZXJTdGF0ZSI9
M30KICAgICAgICAgICAgICAgICAgICAiSU9QQ0lSZXNvdXJjZWQiID0gWWVzCiAgICAgICAgICAg
ICAgICAgICAgInJldmlzaW9uLWlkIiA9IDwwMDAwMDAwMD4KICAgICAgICAgICAgICAgICAgICAi
dmVuZG9yLWlkIiA9IDw2YjEwMDAwMD4KICAgICAgICAgICAgICAgICAgICAicGNpZGVidWciID0g
IjA6MDowIgogICAgICAgICAgICAgICAgICAgICJjbGFzcy1jb2RlIiA9IDwwMDAwMDYwMD4KICAg
ICAgICAgICAgICAgICAgICAibmFtZSIgPSA8InBjaTEwNmIsMWEwNSI+CiAgICAgICAgICAgICAg
ICAgIH0KICAgICAgICAgICAgICAgICAgCgorLW8gUm9vdCAgPGNsYXNzIElPUmVnaXN0cnlFbnRy
eSwgaWQgMHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAgPGNsYXNzIElP
UGxhdGZvcm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM1LCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhY3RpdmUsIGJ1c3kgMCAoODg2MSBtcyksIHJldGFpbiAyNj4KICAgICstbyBBcHBsZVZpcnR1
YWxQbGF0Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSwgaWQgMHgx
MDAwMDAxMzksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyODUgbXMpLCBy
ZXRhaW4gMjEkCiAgICAgICstbyBhcm0taW8gIDxjbGFzcyBJT1BsYXRmb3JtRGV2aWNlLCBpZCAw
eDEwMDAwMDExNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI4NCBtcyks
IHJldGFpbiAxNT4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTyAgPGNsYXNzIEFw
cGxlVmlydHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTYxLCAhcmVnaXN0ZXJlZCwgIW1hdGNo
ZWQsIGFjdGl2ZSwgYnVzeSAwICgyODEgbXMpLCByZXRhaW4gMTIkCiAgICAgICAgICArLW8gcGNp
ZUAzMDAwMDAwMCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlkIDB4MTAwMDAwMTFhLCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjI3IG1zKSwgcmV0YWluIDE3PgogICAg
ICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFICA8Y2xhc3MgQXBwbGVWaXJ0dWFs
UGxhdGZvcm1QQ0lFLCBpZCAweDEwMDAwMDE2ZSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZl
LCBidXN5IDAgKDIyNCBtcyksIHJldCQKICAgICAgICAgICAgICArLW8gZXRoZXJuZXRAMSAgPGNs
YXNzIElPUENJRGV2aWNlLCBpZCAweDEwMDAwMDE3MSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0
aXZlLCBidXN5IDAgKDE0IG1zKSwgcmV0YWluIDk+CiAgICAgICAgICAgICAgICB8IHsKICAgICAg
ICAgICAgICAgIHwgICAiYXNzaWduZWQtYWRkcmVzc2VzIiA9IDwxMDA4MDA4MjAwODAwMTUwMDAw
MDAwMDAwMDQwMDAwMDAwMDAwMDAwMTgwODAwODJjMGQ1MDE1MDAwMDAwMDAwNDAwMDAwMDAwMDAw
MDAwMD4KICAgICAgICAgICAgICAgIHwgICAiSU9JbnRlcnJ1cHRTcGVjaWZpZXJzIiA9ICg8NDEw
MDAwMDAwMTAwMDAwMD4pCiAgICAgICAgICAgICAgICB8ICAgImNsYXNzLWNvZGUiID0gPDAwMDAw
MjAwPgogICAgICAgICAgICAgICAgfCAgICJJT0RldmljZU1lbW9yeSIgPSAoKHsiYWRkcmVzcyI9
MTM0MjI3NTU4NCwibGVuZ3RoIj0xNjM4NH0pLCh7ImFkZHJlc3MiPTEzNDIyOTc1MzYsImxlbmd0
aCI9NjR9KSkKICAgICAgICAgICAgICAgIHwgICAiSU9SZXBvcnRMZWdlbmRQdWJsaWMiID0gWWVz
CiAgICAgICAgICAgICAgICB8ICAgIklPUG93ZXJNYW5hZ2VtZW50IiA9IHsiQ3VycmVudFBvd2Vy
U3RhdGUiPTIsIkNhcGFiaWxpdHlGbGFncyI9MjU4LCJDaGlsZFByb3h5UG93ZXJTdGF0ZSI9Miwi
TWF4UG93ZXJTdGF0ZSI9M30KICAgICAgICAgICAgICAgIHwgICAic3Vic3lzdGVtLXZlbmRvci1p
ZCIgPSA8ZjQxYTAwMDA+CiAgICAgICAgICAgICAgICB8ICAgIklPSW50ZXJydXB0Q29udHJvbGxl
cnMiID0gKCJJT0ludGVycnVwdENvbnRyb2xsZXIwMDAwMDAzNyIpCiAgICAgICAgICAgICAgICB8
ICAgInZlbmRvci1pZCIgPSA8ZjQxYTAwMDA+CiAgICAgICAgICAgICAgICB8ICAgIm5hbWUiID0g
PCJldGhlcm5ldCI+CiAgICAgICAgICAgICAgICB8ICAgImRldmljZS1pZCIgPSA8NDExMDAwMDA+
CiAgICAgICAgICAgICAgICB8ICAgIklPUENJUmVzb3VyY2VkIiA9IFllcwogICAgICAgICAgICAg
ICAgfCAgICJjb21wYXRpYmxlIiA9IDwicGNpMWFmNCw0MSIsInBjaTFhZjQsMTA0MSIsInBjaWNs
YXNzLDAyMDAwMCI+CiAgICAgICAgICAgICAgICB8ICAgIklPU2VydmljZURFWFRFbnRpdGxlbWVu
dHMiID0gKCgiY29tLmFwcGxlLmRldmVsb3Blci5kcml2ZXJraXQudHJhbnNwb3J0LnBjaSIpKQog
ICAgICAgICAgICAgICAgfCAgICJzdWJzeXN0ZW0taWQiID0gPDQxMDAwMDAwPgogICAgICAgICAg
ICAgICAgfCAgICJyZXZpc2lvbi1pZCIgPSA8MDEwMDAwMDA+CiAgICAgICAgICAgICAgICB8ICAg
InBjaWRlYnVnIiA9ICIwOjE6MCIKICAgICAgICAgICAgICAgIHwgICAiSU9OYW1lIiA9ICJldGhl
cm5ldCIKICAgICAgICAgICAgICAgIHwgICAiSU9SZXBvcnRMZWdlbmQiID0gKHsiSU9SZXBvcnRH
cm91cE5hbWUiPSJJbnRlcnJ1cHQgU3RhdGlzdGljcyAoYnkgaW5kZXgpIiwiSU9SZXBvcnRDaGFu
bmVscyI9KCg1MjkxMjk0NjQ1MTgyMDA1MjQ4LDQyOTUkCiAgICAgICAgICAgICAgICB8ICAgInJl
ZyIgPSA8MDAwODAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDEwMDgwMDAyMDAw
MDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAwMDAwMDAxODA4MDAwMjAwMDAwMDAwMDAwMDAwMDA0MDAw
MDAwJAogICAgICAgICAgICAgICAgfCB9CiAgICAgICAgICAgICAgICB8IAogICAgICAgICAgICAg
ICAgKy1vIEFwcGxlVmlydElPUENJVHJhbnNwb3J0ICA8Y2xhc3MgQXBwbGVWaXJ0SU9QQ0lUcmFu
c3BvcnQsIGlkIDB4MTAwMDAwMTg1LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kg
MCAoMTEgbXMpLCByZSQKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVmlydElPTmV0d29yayAg
PGNsYXNzIEFwcGxlVmlydElPTmV0d29yaywgaWQgMHgxMDAwMDAxOGUsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YWluIDk+CiAgICAgICAgICAgICAgICAg
ICAgKy1vIGVuMCAgPGNsYXNzIElPRXRoZXJuZXRJbnRlcmZhY2UsIGlkIDB4MTAwMDAwMjBiLCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpbiAxMz4KICAg
ICAgICAgICAgICAgICAgICAgICstbyBJT05ldHdvcmtTdGFjayAgPGNsYXNzIElPTmV0d29ya1N0
YWNrLCBpZCAweDEwMDAwMDFiYSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAg
KDAgbXMpLCByZXRhaW4gMTI+CiAgICAgICAgICAgICAgICAgICAgICAgICstbyBJT05ldHdvcmtT
dGFja1VzZXJDbGllbnQgIDxjbGFzcyBJT05ldHdvcmtTdGFja1VzZXJDbGllbnQsIGlkIDB4MTAw
MDAwMjkxLCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwJAoKKy1vIFJvb3Qg
IDxjbGFzcyBJT1JlZ2lzdHJ5RW50cnksIGlkIDB4MTAwMDAwMTAwLCByZXRhaW4gNz4KICArLW8g
Vk1BMk1BQ09TQVAgIDxjbGFzcyBJT1BsYXRmb3JtRXhwZXJ0RGV2aWNlLCBpZCAweDEwMDAwMDEz
NSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDg4NjEgbXMpLCByZXRhaW4g
MjY+CiAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSAgPGNsYXNzIEFwcGxlVmlydHVh
bFBsYXRmb3JtQVJNUEUsIGlkIDB4MTAwMDAwMTM5LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3Rp
dmUsIGJ1c3kgMCAoMjg1IG1zKSwgcmV0YWluIDIxJAogICAgICArLW8gYXJtLWlvICA8Y2xhc3Mg
SU9QbGF0Zm9ybURldmljZSwgaWQgMHgxMDAwMDAxMTUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFj
dGl2ZSwgYnVzeSAwICgyODQgbXMpLCByZXRhaW4gMTU+CiAgICAgICAgKy1vIEFwcGxlVmlydHVh
bFBsYXRmb3JtSU8gIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUlPLCBpZCAweDEwMDAwMDE2
MSwgIXJlZ2lzdGVyZWQsICFtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjgxIG1zKSwgcmV0YWlu
IDEyJAogICAgICAgICAgKy1vIHBjaWVAMzAwMDAwMDAgIDxjbGFzcyBBcHBsZUFSTUlPRGV2aWNl
LCBpZCAweDEwMDAwMDExYSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDIy
NyBtcyksIHJldGFpbiAxNz4KICAgICAgICAgICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtUENJ
RSAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtUENJRSwgaWQgMHgxMDAwMDAxNmUsIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyMjQgbXMpLCByZXQkCiAgICAgICAgICAg
ICAgKy1vIHBjaTFhZjQsMTA0M0A1ICA8Y2xhc3MgSU9QQ0lEZXZpY2UsIGlkIDB4MTAwMDAwMTcy
LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTQgbXMpLCByZXRhaW4gOT4K
ICAgICAgICAgICAgICAgIHwgewogICAgICAgICAgICAgICAgfCAgICJhc3NpZ25lZC1hZGRyZXNz
ZXMiID0gPDEwMjgwMDgyMDA0MDAxNTAwMDAwMDAwMDAwNDAwMDAwMDAwMDAwMDAxODI4MDA4MjAw
ZDQwMTUwMDAwMDAwMDA4MDAwMDAwMDAwMDAwMDAwPgogICAgICAgICAgICAgICAgfCAgICJJT0lu
dGVycnVwdFNwZWNpZmllcnMiID0gKDw0NTAwMDAwMDAxMDAwMDAwPikKICAgICAgICAgICAgICAg
IHwgICAiY2xhc3MtY29kZSIgPSA8MDA4MDA3MDA+CiAgICAgICAgICAgICAgICB8ICAgIklPRGV2
aWNlTWVtb3J5IiA9ICgoeyJhZGRyZXNzIj0xMzQyMjU5MjAwLCJsZW5ndGgiPTE2Mzg0fSksKHsi
YWRkcmVzcyI9MTM0MjI5NzA4OCwibGVuZ3RoIj0xMjh9KSkKICAgICAgICAgICAgICAgIHwgICAi
SU9SZXBvcnRMZWdlbmRQdWJsaWMiID0gWWVzCiAgICAgICAgICAgICAgICB8ICAgIklPUG93ZXJN
YW5hZ2VtZW50IiA9IHsiQ3VycmVudFBvd2VyU3RhdGUiPTIsIkNhcGFiaWxpdHlGbGFncyI9MjU4
LCJDaGlsZFByb3h5UG93ZXJTdGF0ZSI9MiwiTWF4UG93ZXJTdGF0ZSI9M30KICAgICAgICAgICAg
ICAgIHwgICAic3Vic3lzdGVtLXZlbmRvci1pZCIgPSA8ZjQxYTAwMDA+CiAgICAgICAgICAgICAg
ICB8ICAgIklPSW50ZXJydXB0Q29udHJvbGxlcnMiID0gKCJJT0ludGVycnVwdENvbnRyb2xsZXIw
MDAwMDAzNyIpCiAgICAgICAgICAgICAgICB8ICAgInZlbmRvci1pZCIgPSA8ZjQxYTAwMDA+CiAg
ICAgICAgICAgICAgICB8ICAgIm5hbWUiID0gPCJwY2kxYWY0LDEwNDMiPgogICAgICAgICAgICAg
ICAgfCAgICJkZXZpY2UtaWQiID0gPDQzMTAwMDAwPgogICAgICAgICAgICAgICAgfCAgICJJT1BD
SVJlc291cmNlZCIgPSBZZXMKICAgICAgICAgICAgICAgIHwgICAiY29tcGF0aWJsZSIgPSA8InBj
aTFhZjQsNDMiLCJwY2kxYWY0LDEwNDMiLCJwY2ljbGFzcywwNzgwMDAiPgogICAgICAgICAgICAg
ICAgfCAgICJJT1NlcnZpY2VERVhURW50aXRsZW1lbnRzIiA9ICgoImNvbS5hcHBsZS5kZXZlbG9w
ZXIuZHJpdmVya2l0LnRyYW5zcG9ydC5wY2kiKSkKICAgICAgICAgICAgICAgIHwgICAic3Vic3lz
dGVtLWlkIiA9IDw0MzAwMDAwMD4KICAgICAgICAgICAgICAgIHwgICAicmV2aXNpb24taWQiID0g
PDAxMDAwMDAwPgogICAgICAgICAgICAgICAgfCAgICJwY2lkZWJ1ZyIgPSAiMDo1OjAiCiAgICAg
ICAgICAgICAgICB8ICAgIklPTmFtZSIgPSAicGNpMWFmNCwxMDQzIgogICAgICAgICAgICAgICAg
fCAgICJJT1JlcG9ydExlZ2VuZCIgPSAoeyJJT1JlcG9ydEdyb3VwTmFtZSI9IkludGVycnVwdCBT
dGF0aXN0aWNzIChieSBpbmRleCkiLCJJT1JlcG9ydENoYW5uZWxzIj0oKDUyOTEyOTQ2NDUxODIw
MDUyNDgsNDI5NSQKICAgICAgICAgICAgICAgIHwgICAicmVnIiA9IDwwMDI4MDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMTAyODAwMDIwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAw
MDAwMDAwMDE4MjgwMDAyMDAwMDAwMDAwMDAwMDAwMDgwMDAwMDAkCiAgICAgICAgICAgICAgICB8
IH0KICAgICAgICAgICAgICAgIHwgCiAgICAgICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9QQ0lU
cmFuc3BvcnQgIDxjbGFzcyBBcHBsZVZpcnRJT1BDSVRyYW5zcG9ydCwgaWQgMHgxMDAwMDAxODYs
IHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxMCBtcyksIHJlJAogICAgICAg
ICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9Db25zb2xlICA8Y2xhc3MgQXBwbGVWaXJ0SU9Db25z
b2xlLCBpZCAweDEwMDAwMDE4ZiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAg
KDkgbXMpLCByZXRhaW4gOD4KICAgICAgICAgICAgICAgICAgICArLW8gSU9TZXJpYWxTdHJlYW1T
eW5jICA8Y2xhc3MgSU9TZXJpYWxTdHJlYW1TeW5jLCBpZCAweDEwMDAwMDE5MSwgcmVnaXN0ZXJl
ZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDkgbXMpLCByZXRhaW4gNz4KICAgICAgICAgICAg
ICAgICAgICAgICstbyBJT1NlcmlhbEJTRENsaWVudCAgPGNsYXNzIElPU2VyaWFsQlNEQ2xpZW50
LCBpZCAweDEwMDAwMDE5OSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAg
bXMpLCByZXRhaW4gNT4KCistbyBSb290ICA8Y2xhc3MgSU9SZWdpc3RyeUVudHJ5LCBpZCAweDEw
MDAwMDEwMCwgcmV0YWluIDc+CiAgKy1vIFZNQTJNQUNPU0FQICA8Y2xhc3MgSU9QbGF0Zm9ybUV4
cGVydERldmljZSwgaWQgMHgxMDAwMDAxMzUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICg4ODYxIG1zKSwgcmV0YWluIDI2PgogICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3Jt
QVJNUEUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUFSTVBFLCBpZCAweDEwMDAwMDEzOSwg
cmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI4NSBtcyksIHJldGFpbiAyMSQK
ICAgICAgKy1vIGFybS1pbyAgPGNsYXNzIElPUGxhdGZvcm1EZXZpY2UsIGlkIDB4MTAwMDAwMTE1
LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjg0IG1zKSwgcmV0YWluIDE1
PgogICAgICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUlPICA8Y2xhc3MgQXBwbGVWaXJ0dWFs
UGxhdGZvcm1JTywgaWQgMHgxMDAwMDAxNjEsICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWN0aXZl
LCBidXN5IDAgKDI4MSBtcyksIHJldGFpbiAxMiQKICAgICAgICAgICstbyBwY2llQDMwMDAwMDAw
ICA8Y2xhc3MgQXBwbGVBUk1JT0RldmljZSwgaWQgMHgxMDAwMDAxMWEsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyMjcgbXMpLCByZXRhaW4gMTc+CiAgICAgICAgICAgICst
byBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBD
SUUsIGlkIDB4MTAwMDAwMTZlLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAo
MjI0IG1zKSwgcmV0JAogICAgICAgICAgICAgICstbyBwY2kxMDZiLDFhMDBANiAgPGNsYXNzIElP
UENJRGV2aWNlLCBpZCAweDEwMDAwMDE3MywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBi
dXN5IDAgKDg5IG1zKSwgcmV0YWluIDEwPgogICAgICAgICAgICAgICAgfCB7CiAgICAgICAgICAg
ICAgICB8ICAgImFzc2lnbmVkLWFkZHJlc3NlcyIgPSA8MTAzMDAwODIwMDAwMDE1MDAwMDAwMDAw
MDA0MDAwMDAwMDAwMDAwMDE4MzAwMDgyODBkNTAxNTAwMDAwMDAwMDQwMDAwMDAwMDAwMDAwMDA+
CiAgICAgICAgICAgICAgICB8ICAgIklPSW50ZXJydXB0U3BlY2lmaWVycyIgPSAoPDQ2MDAwMDAw
MDEwMDAwMDA+KQogICAgICAgICAgICAgICAgfCAgICJjbGFzcy1jb2RlIiA9IDwwMDgwMDEwMD4K
ICAgICAgICAgICAgICAgIHwgICAiSU9EZXZpY2VNZW1vcnkiID0gKCh7ImFkZHJlc3MiPTEzNDIy
NDI4MTYsImxlbmd0aCI9MTYzODR9KSwoeyJhZGRyZXNzIj0xMzQyMjk3NDcyLCJsZW5ndGgiPTY0
fSkpCiAgICAgICAgICAgICAgICB8ICAgIklPUmVwb3J0TGVnZW5kUHVibGljIiA9IFllcwogICAg
ICAgICAgICAgICAgfCAgICJJT1Bvd2VyTWFuYWdlbWVudCIgPSB7IkN1cnJlbnRQb3dlclN0YXRl
Ij0yLCJDYXBhYmlsaXR5RmxhZ3MiPTI1OCwiQ2hpbGRQcm94eVBvd2VyU3RhdGUiPTIsIk1heFBv
d2VyU3RhdGUiPTN9CiAgICAgICAgICAgICAgICB8ICAgInN1YnN5c3RlbS12ZW5kb3ItaWQiID0g
PGY0MWEwMDAwPgogICAgICAgICAgICAgICAgfCAgICJJT0ludGVycnVwdENvbnRyb2xsZXJzIiA9
ICgiSU9JbnRlcnJ1cHRDb250cm9sbGVyMDAwMDAwMzciKQogICAgICAgICAgICAgICAgfCAgICJ2
ZW5kb3ItaWQiID0gPDZiMTAwMDAwPgogICAgICAgICAgICAgICAgfCAgICJuYW1lIiA9IDwicGNp
MTA2YiwxYTAwIj4KICAgICAgICAgICAgICAgIHwgICAiZGV2aWNlLWlkIiA9IDwwMDFhMDAwMD4K
ICAgICAgICAgICAgICAgIHwgICAiSU9QQ0lSZXNvdXJjZWQiID0gWWVzCiAgICAgICAgICAgICAg
ICB8ICAgImNvbXBhdGlibGUiID0gPCJwY2kxYWY0LDQyIiwicGNpMTA2YiwxYTAwIiwicGNpY2xh
c3MsMDE4MDAwIj4KICAgICAgICAgICAgICAgIHwgICAiSU9TZXJ2aWNlREVYVEVudGl0bGVtZW50
cyIgPSAoKCJjb20uYXBwbGUuZGV2ZWxvcGVyLmRyaXZlcmtpdC50cmFuc3BvcnQucGNpIikpCiAg
ICAgICAgICAgICAgICB8ICAgInN1YnN5c3RlbS1pZCIgPSA8NDIwMDAwMDA+CiAgICAgICAgICAg
ICAgICB8ICAgInJldmlzaW9uLWlkIiA9IDwwMTAwMDAwMD4KICAgICAgICAgICAgICAgIHwgICAi
cGNpZGVidWciID0gIjA6NjowIgogICAgICAgICAgICAgICAgfCAgICJJT05hbWUiID0gInBjaTEw
NmIsMWEwMCIKICAgICAgICAgICAgICAgIHwgICAiSU9SZXBvcnRMZWdlbmQiID0gKHsiSU9SZXBv
cnRHcm91cE5hbWUiPSJJbnRlcnJ1cHQgU3RhdGlzdGljcyAoYnkgaW5kZXgpIiwiSU9SZXBvcnRD
aGFubmVscyI9KCg1MjkxMjk0NjQ1MTgyMDA1MjQ4LDQyOTUkCiAgICAgICAgICAgICAgICB8ICAg
InJlZyIgPSA8MDAzMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDEwMzAwMDAy
MDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAwMDAwMDAxODMwMDAwMjAwMDAwMDAwMDAwMDAwMDA0
MDAwMDAwJAogICAgICAgICAgICAgICAgfCB9CiAgICAgICAgICAgICAgICB8IAogICAgICAgICAg
ICAgICAgKy1vIEFwcGxlVmlydElPUENJVHJhbnNwb3J0ICA8Y2xhc3MgQXBwbGVWaXJ0SU9QQ0lU
cmFuc3BvcnQsIGlkIDB4MTAwMDAwMTg3LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1
c3kgMCAoODUgbXMpLCByZSQKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVmlydElPU3RvcmFn
ZURldmljZSAgPGNsYXNzIEFwcGxlVmlydElPU3RvcmFnZURldmljZSwgaWQgMHgxMDAwMDAxOTAs
IHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg4NCBtcykkCiAgICAgICAgICAg
ICAgICAgICAgKy1vIEFwcGxlVmlydElPRGlza1N0b3JhZ2VEZXZpY2VAMSAgPGNsYXNzIEFwcGxl
VmlydElPRGlza1N0b3JhZ2VEZXZpY2UsIGlkIDB4MTAwMDAwMTkyLCByZWdpc3RlcmVkLCBtYXRj
aGVkLCBhY3RpdmUsIGJ1JAogICAgICAgICAgICAgICAgICAgICAgKy1vIElPQmxvY2tTdG9yYWdl
RHJpdmVyICA8Y2xhc3MgSU9CbG9ja1N0b3JhZ2VEcml2ZXIsIGlkIDB4MTAwMDAwMTkzLCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoODQgbXMpLCByZSQKICAgICAgICAgICAg
ICAgICAgICAgICAgKy1vIEFwcGxlIEluYy4gVmlydElPIEJsb2NrIE1lZGlhICA8Y2xhc3MgSU9N
ZWRpYSwgaWQgMHgxMDAwMDAxOTUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAw
ICg4NCBtcyksIHJldGEkCiAgICAgICAgICAgICAgICAgICAgICAgICAgKy1vIElPTWVkaWFCU0RD
bGllbnQgIDxjbGFzcyBJT01lZGlhQlNEQ2xpZW50LCBpZCAweDEwMDAwMDFhMCwgcmVnaXN0ZXJl
ZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gJAogICAgICAgICAgICAg
ICAgICAgICAgICAgICstbyBJT0dVSURQYXJ0aXRpb25TY2hlbWUgIDxjbGFzcyBJT0dVSURQYXJ0
aXRpb25TY2hlbWUsIGlkIDB4MTAwMDAwMWUyLCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2
ZSwgYnVzeSAwICg3NyQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICstbyBpQm9vdFN5c3Rl
bUNvbnRhaW5lckAxICA8Y2xhc3MgSU9NZWRpYSwgaWQgMHgxMDAwMDAxZjIsIHJlZ2lzdGVyZWQs
IG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyOSBtcyksIHJldGFpbiAkCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICstbyBJT01lZGlhQlNEQ2xpZW50ICA8Y2xhc3MgSU9NZWRpYUJTRENs
aWVudCwgaWQgMHgxMDAwMDAxZjUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAw
ICgwIG1zKSwgcmV0JAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCArLW8gQXBwbGVBUEZT
Q29udGFpbmVyU2NoZW1lICA8Y2xhc3MgQXBwbGVBUEZTQ29udGFpbmVyU2NoZW1lLCBpZCAweDEw
MDAwMDFmNiwgIXJlZ2lzdGVyZWQsICFtYXRjaGVkLCBhY3RpdmUsICQKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICArLW8gQXBwbGVBUEZTTWVkaWEgIDxjbGFzcyBBcHBsZUFQRlNNZWRp
YSwgaWQgMHgxMDAwMDAxZmIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgy
OCBtcyksIHJldGEkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICArLW8gQXBwbGVB
UEZTTWVkaWFCU0RDbGllbnQgIDxjbGFzcyBBcHBsZUFQRlNNZWRpYUJTRENsaWVudCwgaWQgMHgx
MDAwMDAxZmMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgJAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAgKy1vIEFwcGxlQVBGU0NvbnRhaW5lciAgPGNsYXNzIEFwcGxlQVBG
U0NvbnRhaW5lciwgaWQgMHgxMDAwMDAyMTgsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgwICQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgKy1vIGlTQ1By
ZWJvb3RAMSAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMWQsIHJlZ2lzdGVy
ZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgICAgIHwgKy1vIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCAgPGNsYXNz
IEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCwgaWQgMHgxMDAwMDAyMjEsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8geEFSVEAy
ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIxZSwgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gMSQKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAgICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3Mg
QXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDIyMywgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWMkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICstbyBIYXJkd2Fy
ZUAzICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIxZiwgcmVnaXN0ZXJlZCwg
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhJAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICB8ICstbyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQgIDxjbGFzcyBB
cHBsZUFQRlNWb2x1bWVCU0RDbGllbnQsIGlkIDB4MTAwMDAwMjI1LCByZWdpc3RlcmVkLCBtYXRj
aGVkLCBhYyQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgKy1vIFJlY292ZXJ5
QDQgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWUsIGlkIDB4MTAwMDAwMjIwLCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGEkCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAgICAgKy1vIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCAgPGNsYXNzIEFw
cGxlQVBGU1ZvbHVtZUJTRENsaWVudCwgaWQgMHgxMDAwMDAyMjcsIHJlZ2lzdGVyZWQsIG1hdGNo
ZWQsIGFjJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgKy1vIENvbnRhaW5lckAyICA8Y2xh
c3MgSU9NZWRpYSwgaWQgMHgxMDAwMDAxZjMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICg3NyBtcyksIHJldGFpbiAxMj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
Ky1vIElPTWVkaWFCU0RDbGllbnQgIDxjbGFzcyBJT01lZGlhQlNEQ2xpZW50LCBpZCAweDEwMDAw
MDFmNywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXQkCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICstbyBBcHBsZUFQRlNDb250YWluZXJTY2hlbWUg
IDxjbGFzcyBBcHBsZUFQRlNDb250YWluZXJTY2hlbWUsIGlkIDB4MTAwMDAwMWY4LCAhcmVnaXN0
ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICstbyBBcHBsZUFQRlNNZWRpYSAgPGNsYXNzIEFwcGxlQVBGU01lZGlhLCBpZCAweDEwMDAwMDFm
ZiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDc3IG1zKSwgcmV0YSQKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICstbyBBcHBsZUFQRlNNZWRpYUJTRENsaWVu
dCAgPGNsYXNzIEFwcGxlQVBGU01lZGlhQlNEQ2xpZW50LCBpZCAweDEwMDAwMDIwMCwgcmVnaXN0
ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCAkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
ICArLW8gQXBwbGVBUEZTQ29udGFpbmVyICA8Y2xhc3MgQXBwbGVBUEZTQ29udGFpbmVyLCBpZCAw
eDEwMDAwMDIxYSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDEgJAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8gTWFjaW50b3NoIEhEQDEgIDxjbGFz
cyBBcHBsZUFQRlNWb2x1bWUsIGlkIDB4MTAwMDAwMjJmLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBh
Y3RpdmUsIGJ1c3kgMCAoMCBtcyksICQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1l
QlNEQ2xpZW50LCBpZCAweDEwMDAwMDIzNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWMkCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwgKy1vIGNvbS5hcHBsZS5vcy51cGRhdGUt
N0U1RjYyMUU3MTczODZDMEY2REQ1RDkyN0YyM0MyQUZCMzVDNDIzODFBNUVBNjFDOTkzMjMyNDI4
RjBFNkU1NUAxICA8Y2xhc3MgQXBwJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICB8ICAgKy1vIElPTWVkaWFCU0RDbGllbnQgIDxjbGFzcyBJT01lZGlhQlNEQ2xpZW50LCBpZCAw
eDEwMDAwMDI0MywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKCQKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgKy1vIFByZWJvb3RAMiAgPGNsYXNzIEFwcGxl
QVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMzAsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgwIG1zKSwgcmV0YWkkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAg
IHwgKy1vIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZUJT
RENsaWVudCwgaWQgMHgxMDAwMDAyMzcsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjJAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8gUmVjb3ZlcnlAMyAgPGNsYXNzIEFwcGxl
QVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMzEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgwIG1zKSwgcmV0YSQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
fCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lQlNE
Q2xpZW50LCBpZCAweDEwMDAwMDIzOSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWMkCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICstbyBVcGRhdGVANCAgPGNsYXNzIEFwcGxlQVBG
U1ZvbHVtZSwgaWQgMHgxMDAwMDAyMzIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVz
eSAwICgwIG1zKSwgcmV0YWluJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICB8
ICstbyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWVCU0RD
bGllbnQsIGlkIDB4MTAwMDAwMjNiLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhYyQKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgKy1vIERhdGFANSAgPGNsYXNzIEFwcGxlQVBGU1Zv
bHVtZSwgaWQgMHgxMDAwMDAyMzMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAw
ICgwIG1zKSwgcmV0YWluIDEkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwg
Ky1vIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZUJTRENs
aWVudCwgaWQgMHgxMDAwMDAyM2UsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjJAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8gVk1ANiAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVt
ZSwgaWQgMHgxMDAwMDAyMzQsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgw
IG1zKSwgcmV0YWluIDExPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICst
byBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWVCU0RDbGll
bnQsIGlkIDB4MTAwMDAwMjQwLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhYyQKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICstbyBSZWNvdmVyeU9TQ29udGFpbmVyQDMgIDxjbGFzcyBJT01lZGlh
LCBpZCAweDEwMDAwMDFmNCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDQ0
IG1zKSwgcmV0YWluIDEkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICstbyBJT01lZGlh
QlNEQ2xpZW50ICA8Y2xhc3MgSU9NZWRpYUJTRENsaWVudCwgaWQgMHgxMDAwMDAxZjksIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0JAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICArLW8gQXBwbGVBUEZTQ29udGFpbmVyU2NoZW1lICA8Y2xhc3MgQXBw
bGVBUEZTQ29udGFpbmVyU2NoZW1lLCBpZCAweDEwMDAwMDFmYSwgIXJlZ2lzdGVyZWQsICFtYXRj
aGVkLCBhY3RpdmUsICQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLW8gQXBwbGVB
UEZTTWVkaWEgIDxjbGFzcyBBcHBsZUFQRlNNZWRpYSwgaWQgMHgxMDAwMDAyMDMsIHJlZ2lzdGVy
ZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg0MyBtcyksIHJldGEkCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArLW8gQXBwbGVBUEZTTWVkaWFCU0RDbGllbnQgIDxjbGFzcyBB
cHBsZUFQRlNNZWRpYUJTRENsaWVudCwgaWQgMHgxMDAwMDAyMDQsIHJlZ2lzdGVyZWQsIG1hdGNo
ZWQsIGFjdGl2ZSwgJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKy1vIEFwcGxl
QVBGU0NvbnRhaW5lciAgPGNsYXNzIEFwcGxlQVBGU0NvbnRhaW5lciwgaWQgMHgxMDAwMDAyMWMs
IHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwICQKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKy1vIFJlY292ZXJ5QDEgIDxjbGFzcyBBcHBsZUFQRlNWb2x1
bWUsIGlkIDB4MTAwMDAwMjI5LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAo
MCBtcyksIHJldGEkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgKy1vIEFw
cGxlQVBGU1ZvbHVtZUJTRENsaWVudCAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCwg
aWQgMHgxMDAwMDAyMmIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjJAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArLW8gVXBkYXRlQDIgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWUs
IGlkIDB4MTAwMDAwMjJhLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBt
cyksIHJldGFpbiQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLW8gQXBw
bGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50LCBp
ZCAweDEwMDAwMDIyZCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWMkCgorLW8gUm9vdCAgPGNsYXNz
IElPUmVnaXN0cnlFbnRyeSwgaWQgMHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFD
T1NBUCAgPGNsYXNzIElPUGxhdGZvcm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM1LCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoODg2MSBtcyksIHJldGFpbiAyNj4KICAg
ICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZv
cm1BUk1QRSwgaWQgMHgxMDAwMDAxMzksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVz
eSAwICgyODUgbXMpLCByZXRhaW4gMjEkCiAgICAgICstbyBhcm0taW8gIDxjbGFzcyBJT1BsYXRm
b3JtRGV2aWNlLCBpZCAweDEwMDAwMDExNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBi
dXN5IDAgKDI4NCBtcyksIHJldGFpbiAxNT4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZv
cm1JTyAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTYxLCAhcmVn
aXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyODEgbXMpLCByZXRhaW4gMTIkCiAg
ICAgICAgICArLW8gcGNpZUAzMDAwMDAwMCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlkIDB4
MTAwMDAwMTFhLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjI3IG1zKSwg
cmV0YWluIDE3PgogICAgICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFICA8Y2xh
c3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFLCBpZCAweDEwMDAwMDE2ZSwgcmVnaXN0ZXJlZCwg
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDIyNCBtcyksIHJldCQKICAgICAgICAgICAgICArLW8g
cGNpMTA2YiwxYTAwQDcgIDxjbGFzcyBJT1BDSURldmljZSwgaWQgMHgxMDAwMDAxNzQsIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg3IG1zKSwgcmV0YWluIDEwPgogICAgICAg
ICAgICAgICAgfCB7CiAgICAgICAgICAgICAgICB8ICAgImFzc2lnbmVkLWFkZHJlc3NlcyIgPSA8
MTAzODAwODIwMGMwMDA1MDAwMDAwMDAwMDA0MDAwMDAwMDAwMDAwMDE4MzgwMDgyNDBkNTAxNTAw
MDAwMDAwMDQwMDAwMDAwMDAwMDAwMDA+CiAgICAgICAgICAgICAgICB8ICAgIklPSW50ZXJydXB0
U3BlY2lmaWVycyIgPSAoPDQ3MDAwMDAwMDEwMDAwMDA+KQogICAgICAgICAgICAgICAgfCAgICJj
bGFzcy1jb2RlIiA9IDwwMDgwMDEwMD4KICAgICAgICAgICAgICAgIHwgICAiSU9EZXZpY2VNZW1v
cnkiID0gKCh7ImFkZHJlc3MiPTEzNDIyMjY0MzIsImxlbmd0aCI9MTYzODR9KSwoeyJhZGRyZXNz
Ij0xMzQyMjk3NDA4LCJsZW5ndGgiPTY0fSkpCiAgICAgICAgICAgICAgICB8ICAgIklPUmVwb3J0
TGVnZW5kUHVibGljIiA9IFllcwogICAgICAgICAgICAgICAgfCAgICJJT1Bvd2VyTWFuYWdlbWVu
dCIgPSB7IkN1cnJlbnRQb3dlclN0YXRlIj0yLCJDYXBhYmlsaXR5RmxhZ3MiPTI1OCwiQ2hpbGRQ
cm94eVBvd2VyU3RhdGUiPTIsIk1heFBvd2VyU3RhdGUiPTN9CiAgICAgICAgICAgICAgICB8ICAg
InN1YnN5c3RlbS12ZW5kb3ItaWQiID0gPGY0MWEwMDAwPgogICAgICAgICAgICAgICAgfCAgICJJ
T0ludGVycnVwdENvbnRyb2xsZXJzIiA9ICgiSU9JbnRlcnJ1cHRDb250cm9sbGVyMDAwMDAwMzci
KQogICAgICAgICAgICAgICAgfCAgICJ2ZW5kb3ItaWQiID0gPDZiMTAwMDAwPgogICAgICAgICAg
ICAgICAgfCAgICJuYW1lIiA9IDwicGNpMTA2YiwxYTAwIj4KICAgICAgICAgICAgICAgIHwgICAi
ZGV2aWNlLWlkIiA9IDwwMDFhMDAwMD4KICAgICAgICAgICAgICAgIHwgICAiSU9QQ0lSZXNvdXJj
ZWQiID0gWWVzCiAgICAgICAgICAgICAgICB8ICAgImNvbXBhdGlibGUiID0gPCJwY2kxYWY0LDQy
IiwicGNpMTA2YiwxYTAwIiwicGNpY2xhc3MsMDE4MDAwIj4KICAgICAgICAgICAgICAgIHwgICAi
SU9TZXJ2aWNlREVYVEVudGl0bGVtZW50cyIgPSAoKCJjb20uYXBwbGUuZGV2ZWxvcGVyLmRyaXZl
cmtpdC50cmFuc3BvcnQucGNpIikpCiAgICAgICAgICAgICAgICB8ICAgInN1YnN5c3RlbS1pZCIg
PSA8NDIwMDAwMDA+CiAgICAgICAgICAgICAgICB8ICAgInJldmlzaW9uLWlkIiA9IDwwMTAwMDAw
MD4KICAgICAgICAgICAgICAgIHwgICAicGNpZGVidWciID0gIjA6NzowIgogICAgICAgICAgICAg
ICAgfCAgICJJT05hbWUiID0gInBjaTEwNmIsMWEwMCIKICAgICAgICAgICAgICAgIHwgICAiSU9S
ZXBvcnRMZWdlbmQiID0gKHsiSU9SZXBvcnRHcm91cE5hbWUiPSJJbnRlcnJ1cHQgU3RhdGlzdGlj
cyAoYnkgaW5kZXgpIiwiSU9SZXBvcnRDaGFubmVscyI9KCg1MjkxMjk0NjQ1MTgyMDA1MjQ4LDQy
OTUkCiAgICAgICAgICAgICAgICB8ICAgInJlZyIgPSA8MDAzODAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDEwMzgwMDAyMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAwMDAwMDAx
ODM4MDAwMjAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwJAogICAgICAgICAgICAgICAgfCB9CiAgICAg
ICAgICAgICAgICB8IAogICAgICAgICAgICAgICAgKy1vIEFwcGxlVmlydElPUENJVHJhbnNwb3J0
ICA8Y2xhc3MgQXBwbGVWaXJ0SU9QQ0lUcmFuc3BvcnQsIGlkIDB4MTAwMDAwMTg4LCByZWdpc3Rl
cmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMyBtcyksIHJldCQKICAgICAgICAgICAgICAg
ICAgKy1vIEFwcGxlVmlydElPU3RvcmFnZURldmljZSAgPGNsYXNzIEFwcGxlVmlydElPU3RvcmFn
ZURldmljZSwgaWQgMHgxMDAwMDAxOTQsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVz
eSAwICgwIG1zKSwkCiAgICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVmlydElPVXRpbFN0b3Jh
Z2VEZXZpY2UgIDxjbGFzcyBBcHBsZVZpcnRJT1V0aWxTdG9yYWdlRGV2aWNlLCBpZCAweDEwMDAw
MDE5OCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5JAogICAgICAgICAgICAgICAg
ICAgICAgKy1vIEFwcGxlRW1iZWRkZWRTaW1wbGVTUElOT1JGbGFzaGVyRHJpdmVyICA8Y2xhc3Mg
QXBwbGVFbWJlZGRlZFNpbXBsZVNQSU5PUkZsYXNoZXJEcml2ZXIsIGlkIDB4MTAwMDAwMTlhLCBy
ZWdpc3RlcmVkLCQKICAgICAgICAgICAgICAgICAgICAgICstbyBBcHBsZVZpcnRJT05WUkFNICA8
Y2xhc3MgQXBwbGVWaXJ0SU9OVlJBTSwgaWQgMHgxMDAwMDAxOWIsIHJlZ2lzdGVyZWQsIG1hdGNo
ZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YWluIDU+CiAgICAgICAgICAgICAgICAgICAg
ICArLW8gQXBwbGVOVk1lTmFtZXNwYWNlRGV2aWNlICA8Y2xhc3MgQXBwbGVOVk1lTmFtZXNwYWNl
RGV2aWNlLCBpZCAweDEwMDAwMDFhOSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5
IDAgKDAgJAogICAgICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlTlZNZUVBTiAgPGNsYXNzIEFw
cGxlTlZNZUVBTiwgaWQgMHgxMDAwMDAxYWMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgwIG1zKSwgcmV0YWluIDY+CgorLW8gUm9vdCAgPGNsYXNzIElPUmVnaXN0cnlFbnRy
eSwgaWQgMHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAgPGNsYXNzIElP
UGxhdGZvcm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM1LCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhY3RpdmUsIGJ1c3kgMCAoODg2MSBtcyksIHJldGFpbiAyNj4KICAgICstbyBBcHBsZVZpcnR1
YWxQbGF0Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSwgaWQgMHgx
MDAwMDAxMzksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyODUgbXMpLCBy
ZXRhaW4gMjEkCiAgICAgICstbyBhcm0taW8gIDxjbGFzcyBJT1BsYXRmb3JtRGV2aWNlLCBpZCAw
eDEwMDAwMDExNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI4NCBtcyks
IHJldGFpbiAxNT4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTyAgPGNsYXNzIEFw
cGxlVmlydHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTYxLCAhcmVnaXN0ZXJlZCwgIW1hdGNo
ZWQsIGFjdGl2ZSwgYnVzeSAwICgyODEgbXMpLCByZXRhaW4gMTIkCiAgICAgICAgICArLW8gcGNp
ZUAzMDAwMDAwMCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlkIDB4MTAwMDAwMTFhLCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjI3IG1zKSwgcmV0YWluIDE3PgogICAg
ICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFICA8Y2xhc3MgQXBwbGVWaXJ0dWFs
UGxhdGZvcm1QQ0lFLCBpZCAweDEwMDAwMDE2ZSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZl
LCBidXN5IDAgKDIyNCBtcyksIHJldCQKICAgICAgICAgICAgICArLW8gcGNpMWFmNCwxMDQ0QDgg
IDxjbGFzcyBJT1BDSURldmljZSwgaWQgMHgxMDAwMDAxNzUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICg1IG1zKSwgcmV0YWluIDk+CiAgICAgICAgICAgICAgICB8IHsKICAg
ICAgICAgICAgICAgIHwgICAiYXNzaWduZWQtYWRkcmVzc2VzIiA9IDwxMDQwMDA4MjAwODAwMDUw
MDAwMDAwMDAwMDQwMDAwMDAwMDAwMDAwMTg0MDAwODIwMGQ1MDE1MDAwMDAwMDAwNDAwMDAwMDAw
MDAwMDAwMD4KICAgICAgICAgICAgICAgIHwgICAiSU9JbnRlcnJ1cHRTcGVjaWZpZXJzIiA9ICg8
NDgwMDAwMDAwMTAwMDAwMD4pCiAgICAgICAgICAgICAgICB8ICAgImNsYXNzLWNvZGUiID0gPDAw
MDAxMDAwPgogICAgICAgICAgICAgICAgfCAgICJJT0RldmljZU1lbW9yeSIgPSAoKHsiYWRkcmVz
cyI9MTM0MjIxMDA0OCwibGVuZ3RoIj0xNjM4NH0pLCh7ImFkZHJlc3MiPTEzNDIyOTczNDQsImxl
bmd0aCI9NjR9KSkKICAgICAgICAgICAgICAgIHwgICAiSU9SZXBvcnRMZWdlbmRQdWJsaWMiID0g
WWVzCiAgICAgICAgICAgICAgICB8ICAgIklPUG93ZXJNYW5hZ2VtZW50IiA9IHsiQ3VycmVudFBv
d2VyU3RhdGUiPTIsIkNhcGFiaWxpdHlGbGFncyI9MjU4LCJDaGlsZFByb3h5UG93ZXJTdGF0ZSI9
MiwiTWF4UG93ZXJTdGF0ZSI9M30KICAgICAgICAgICAgICAgIHwgICAic3Vic3lzdGVtLXZlbmRv
ci1pZCIgPSA8ZjQxYTAwMDA+CiAgICAgICAgICAgICAgICB8ICAgIklPSW50ZXJydXB0Q29udHJv
bGxlcnMiID0gKCJJT0ludGVycnVwdENvbnRyb2xsZXIwMDAwMDAzNyIpCiAgICAgICAgICAgICAg
ICB8ICAgInZlbmRvci1pZCIgPSA8ZjQxYTAwMDA+CiAgICAgICAgICAgICAgICB8ICAgIm5hbWUi
ID0gPCJwY2kxYWY0LDEwNDQiPgogICAgICAgICAgICAgICAgfCAgICJkZXZpY2UtaWQiID0gPDQ0
MTAwMDAwPgogICAgICAgICAgICAgICAgfCAgICJJT1BDSVJlc291cmNlZCIgPSBZZXMKICAgICAg
ICAgICAgICAgIHwgICAiY29tcGF0aWJsZSIgPSA8InBjaTFhZjQsNDQiLCJwY2kxYWY0LDEwNDQi
LCJwY2ljbGFzcywxMDAwMDAiPgogICAgICAgICAgICAgICAgfCAgICJJT1NlcnZpY2VERVhURW50
aXRsZW1lbnRzIiA9ICgoImNvbS5hcHBsZS5kZXZlbG9wZXIuZHJpdmVya2l0LnRyYW5zcG9ydC5w
Y2kiKSkKICAgICAgICAgICAgICAgIHwgICAic3Vic3lzdGVtLWlkIiA9IDw0NDAwMDAwMD4KICAg
ICAgICAgICAgICAgIHwgICAicmV2aXNpb24taWQiID0gPDAxMDAwMDAwPgogICAgICAgICAgICAg
ICAgfCAgICJwY2lkZWJ1ZyIgPSAiMDo4OjAiCiAgICAgICAgICAgICAgICB8ICAgIklPTmFtZSIg
PSAicGNpMWFmNCwxMDQ0IgogICAgICAgICAgICAgICAgfCAgICJJT1JlcG9ydExlZ2VuZCIgPSAo
eyJJT1JlcG9ydEdyb3VwTmFtZSI9IkludGVycnVwdCBTdGF0aXN0aWNzIChieSBpbmRleCkiLCJJ
T1JlcG9ydENoYW5uZWxzIj0oKDUyOTEyOTQ2NDUxODIwMDUyNDgsNDI5NSQKICAgICAgICAgICAg
ICAgIHwgICAicmVnIiA9IDwwMDQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MTA0MDAwMDIwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDAwMDAwMDE4NDAwMDAyMDAwMDAwMDAw
MDAwMDAwMDQwMDAwMDAkCiAgICAgICAgICAgICAgICB8IH0KICAgICAgICAgICAgICAgIHwgCiAg
ICAgICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9QQ0lUcmFuc3BvcnQgIDxjbGFzcyBBcHBsZVZp
cnRJT1BDSVRyYW5zcG9ydCwgaWQgMHgxMDAwMDAxODksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFj
dGl2ZSwgYnVzeSAwICgyIG1zKSwgcmV0JAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVWaXJ0
SU9FbnRyb3B5ICA8Y2xhc3MgQXBwbGVWaXJ0SU9FbnRyb3B5LCBpZCAweDEwMDAwMDE5NiwgcmVn
aXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gNj4KCistbyBS
b290ICA8Y2xhc3MgSU9SZWdpc3RyeUVudHJ5LCBpZCAweDEwMDAwMDEwMCwgcmV0YWluIDc+CiAg
Ky1vIFZNQTJNQUNPU0FQICA8Y2xhc3MgSU9QbGF0Zm9ybUV4cGVydERldmljZSwgaWQgMHgxMDAw
MDAxMzUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg4ODYxIG1zKSwgcmV0
YWluIDI2PgogICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUgIDxjbGFzcyBBcHBsZVZp
cnR1YWxQbGF0Zm9ybUFSTVBFLCBpZCAweDEwMDAwMDEzOSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDI4NSBtcyksIHJldGFpbiAyMSQKICAgICAgKy1vIGFybS1pbyAgPGNs
YXNzIElPUGxhdGZvcm1EZXZpY2UsIGlkIDB4MTAwMDAwMTE1LCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhY3RpdmUsIGJ1c3kgMCAoMjg0IG1zKSwgcmV0YWluIDE1PgogICAgICAgICstbyBBcHBsZVZp
cnR1YWxQbGF0Zm9ybUlPICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTywgaWQgMHgxMDAw
MDAxNjEsICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI4MSBtcyksIHJl
dGFpbiAxMiQKICAgICAgICAgICstbyBwY2llQDMwMDAwMDAwICA8Y2xhc3MgQXBwbGVBUk1JT0Rl
dmljZSwgaWQgMHgxMDAwMDAxMWEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAw
ICgyMjcgbXMpLCByZXRhaW4gMTc+CiAgICAgICAgICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9y
bVBDSUUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUsIGlkIDB4MTAwMDAwMTZlLCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjI0IG1zKSwgcmV0JAogICAgICAg
ICAgICAgICstbyBwY2kxMDZiLDFhMDZAOSAgPGNsYXNzIElPUENJRGV2aWNlLCBpZCAweDEwMDAw
MDE3NiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDE0MyBtcyksIHJldGFp
biAxMj4KICAgICAgICAgICAgICAgIHwgewogICAgICAgICAgICAgICAgfCAgICJjb21wYXRpYmxl
IiA9IDwicGNpMTA2YiwxYTA2IiwicGNpY2xhc3MsMGMwMzMwIj4KICAgICAgICAgICAgICAgIHwg
ICAiSU9TZXJ2aWNlREVYVEVudGl0bGVtZW50cyIgPSAoKCJjb20uYXBwbGUuZGV2ZWxvcGVyLmRy
aXZlcmtpdC50cmFuc3BvcnQucGNpIikpCiAgICAgICAgICAgICAgICB8ICAgIklPTmFtZSIgPSAi
cGNpMTA2YiwxYTA2IgogICAgICAgICAgICAgICAgfCAgICJyZWciID0gPDAwNDgwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxMDQ4MDAwMjAwMDAwMDAwMDAwMDAwMDAwMDEwMDAw
MDAwMDAwMDAwMTQ0ODAwMDIwMDAwMDAwMDAwMDAwMDAwMDAwNDAwMCQKICAgICAgICAgICAgICAg
IHwgICAiYXNzaWduZWQtYWRkcmVzc2VzIiA9IDwxMDQ4MDA4MjAwYzAwMTUwMDAwMDAwMDAwMDEw
MDAwMDAwMDAwMDAwMTQ0ODAwODIwMGQwMDE1MDAwMDAwMDAwMDAwNDAwMDAwMDAwMDAwMD4KICAg
ICAgICAgICAgICAgIHwgICAiZGV2aWNlLWlkIiA9IDwwNjFhMDAwMD4KICAgICAgICAgICAgICAg
IHwgICAiSU9Qb3dlck1hbmFnZW1lbnQiID0geyJDaGlsZHJlblBvd2VyU3RhdGUiPTIsIkN1cnJl
bnRQb3dlclN0YXRlIj0yLCJDYXBhYmlsaXR5RmxhZ3MiPTI1OCwiQ2hpbGRQcm94eVBvd2VyU3Rh
dGUiPTIsIk1heFAkCiAgICAgICAgICAgICAgICB8ICAgIklPUENJUmVzb3VyY2VkIiA9IFllcwog
ICAgICAgICAgICAgICAgfCAgICJJT0RldmljZU1lbW9yeSIgPSAoKHsiYWRkcmVzcyI9MTM0MjI5
MTk2OCwibGVuZ3RoIj00MDk2fSksKHsiYWRkcmVzcyI9MTM0MjI5NjA2NCwibGVuZ3RoIj0xMDI0
fSkpCiAgICAgICAgICAgICAgICB8ICAgInJldmlzaW9uLWlkIiA9IDwwMDAwMDAwMD4KICAgICAg
ICAgICAgICAgIHwgICAiSU9JbnRlcnJ1cHRDb250cm9sbGVycyIgPSAoIklPSW50ZXJydXB0Q29u
dHJvbGxlcjAwMDAwMDM3IikKICAgICAgICAgICAgICAgIHwgICAidmVuZG9yLWlkIiA9IDw2YjEw
MDAwMD4KICAgICAgICAgICAgICAgIHwgICAicGNpZGVidWciID0gIjA6OTowIgogICAgICAgICAg
ICAgICAgfCAgICJjbGFzcy1jb2RlIiA9IDwzMDAzMGMwMD4KICAgICAgICAgICAgICAgIHwgICAi
SU9JbnRlcnJ1cHRTcGVjaWZpZXJzIiA9ICg8NDkwMDAwMDAwMTAwMDAwMD4pCiAgICAgICAgICAg
ICAgICB8ICAgIklPUmVwb3J0TGVnZW5kIiA9ICh7IklPUmVwb3J0R3JvdXBOYW1lIj0iSW50ZXJy
dXB0IFN0YXRpc3RpY3MgKGJ5IGluZGV4KSIsIklPUmVwb3J0Q2hhbm5lbHMiPSgoNTI5MTI5NDY0
NTE4MjAwNTI0OCw0Mjk1JAogICAgICAgICAgICAgICAgfCAgICJJT1JlcG9ydExlZ2VuZFB1Ymxp
YyIgPSBZZXMKICAgICAgICAgICAgICAgIHwgICAibmFtZSIgPSA8InBjaTEwNmIsMWEwNiI+CiAg
ICAgICAgICAgICAgICB8IH0KICAgICAgICAgICAgICAgIHwgCiAgICAgICAgICAgICAgICArLW8g
QXBwbGVVU0JYSENJUENJQDA5MDAwMDAwICA8Y2xhc3MgQXBwbGVVU0JYSENJUENJLCBpZCAweDEw
MDAwMDE4YSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDEzNiBtcyksIHJl
dGFpbiAxJAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVVU0IzMFhIQ0lQb3J0QDA5MTAwMDAw
ICA8Y2xhc3MgQXBwbGVVU0IzMFhIQ0lQb3J0LCBpZCAweDEwMDAwMDFjMywgcmVnaXN0ZXJlZCwg
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZSQKICAgICAgICAgICAgICAgICAgKy1v
IEFwcGxlVVNCMzBYSENJUG9ydEAwOTIwMDAwMCAgPGNsYXNzIEFwcGxlVVNCMzBYSENJUG9ydCwg
aWQgMHgxMDAwMDAxYzQsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1z
KSwgcmUkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQjMwWEhDSVBvcnRAMDkzMDAwMDAg
IDxjbGFzcyBBcHBsZVVTQjMwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMWM1LCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJlJAogICAgICAgICAgICAgICAgICArLW8g
QXBwbGVVU0IzMFhIQ0lQb3J0QDA5NDAwMDAwICA8Y2xhc3MgQXBwbGVVU0IzMFhIQ0lQb3J0LCBp
ZCAweDEwMDAwMDFjNiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMp
LCByZSQKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNCMzBYSENJUG9ydEAwOTUwMDAwMCAg
PGNsYXNzIEFwcGxlVVNCMzBYSENJUG9ydCwgaWQgMHgxMDAwMDAxYzcsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAgICAgICAgICAgICstbyBB
cHBsZVVTQjMwWEhDSVBvcnRAMDk2MDAwMDAgIDxjbGFzcyBBcHBsZVVTQjMwWEhDSVBvcnQsIGlk
IDB4MTAwMDAwMWM4LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyks
IHJlJAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVVU0IzMFhIQ0lQb3J0QDA5NzAwMDAwICA8
Y2xhc3MgQXBwbGVVU0IzMFhIQ0lQb3J0LCBpZCAweDEwMDAwMDFjOSwgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZSQKICAgICAgICAgICAgICAgICAgKy1vIEFw
cGxlVVNCMzBYSENJUG9ydEAwOTgwMDAwMCAgPGNsYXNzIEFwcGxlVVNCMzBYSENJUG9ydCwgaWQg
MHgxMDAwMDAxY2EsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwg
cmUkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQjIwWEhDSVBvcnRAMDk5MDAwMDAgIDxj
bGFzcyBBcHBsZVVTQjIwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMWNiLCByZWdpc3RlcmVkLCBtYXRj
aGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTMzIG1zKSwgJAogICAgICAgICAgICAgICAgICB8ICstbyBW
aXJ0dWFsIFVTQiBLZXlib2FyZEAwOTkwMDAwMCAgPGNsYXNzIElPVVNCSG9zdERldmljZSwgaWQg
MHgxMDAwMDAyNmIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxMzIgbXMp
LCQKICAgICAgICAgICAgICAgICAgfCAgICstbyBBcHBsZVVTQkhvc3RDb21wb3NpdGVEZXZpY2Ug
IDxjbGFzcyBBcHBsZVVTQkhvc3RDb21wb3NpdGVEZXZpY2UsIGlkIDB4MTAwMDAwMjZlLCAhcmVn
aXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnUkCiAgICAgICAgICAgICAgICAgIHwgICArLW8g
SU9VU0JIb3N0SW50ZXJmYWNlQDAgIDxjbGFzcyBJT1VTQkhvc3RJbnRlcmZhY2UsIGlkIDB4MTAw
MDAwMjZmLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTMyIG1zKSwgcmV0
JAogICAgICAgICAgICAgICAgICB8ICAgICArLW8gQXBwbGVVc2VyVVNCSG9zdEhJRERldmljZSAg
PGNsYXNzIEFwcGxlVXNlckhJRERldmljZSwgaWQgMHgxMDAwMDAyYzMsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyIG1zKSQKICAgICAgICAgICAgICAgICAgfCAgICAgICAr
LW8gSU9ISURJbnRlcmZhY2UgIDxjbGFzcyBJT0hJREludGVyZmFjZSwgaWQgMHgxMDAwMDAyZDMs
IHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyIG1zKSwgcmV0YWluIDEwPgog
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgKy1vIEFwcGxlVXNlckhJREV2ZW50RHJpdmVyICA8
Y2xhc3MgQXBwbGVVc2VySElERXZlbnRTZXJ2aWNlLCBpZCAweDEwMDAwMDJkNSwgcmVnaXN0ZXJl
ZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5ICQKICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAg
Ky1vIElPSElERXZlbnRTZXJ2aWNlVXNlckNsaWVudCAgPGNsYXNzIElPSElERXZlbnRTZXJ2aWNl
VXNlckNsaWVudCwgaWQgMHgxMDAwMDAyZDksICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWMkCiAg
ICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQjIwWEhDSVBvcnRAMDlhMDAwMDAgIDxjbGFzcyBB
cHBsZVVTQjIwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMWNjLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBh
Y3RpdmUsIGJ1c3kgMCAoMTMxIG1zKSwgJAogICAgICAgICAgICAgICAgICB8ICstbyBWaXJ0dWFs
IFVTQiBEaWdpdGl6ZXJAMDlhMDAwMDAgIDxjbGFzcyBJT1VTQkhvc3REZXZpY2UsIGlkIDB4MTAw
MDAwMjY2LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTMwIG1zKSQKICAg
ICAgICAgICAgICAgICAgfCAgICstbyBBcHBsZVVTQkhvc3RDb21wb3NpdGVEZXZpY2UgIDxjbGFz
cyBBcHBsZVVTQkhvc3RDb21wb3NpdGVEZXZpY2UsIGlkIDB4MTAwMDAwMjY5LCAhcmVnaXN0ZXJl
ZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnUkCiAgICAgICAgICAgICAgICAgIHwgICArLW8gSU9VU0JI
b3N0SW50ZXJmYWNlQDAgIDxjbGFzcyBJT1VTQkhvc3RJbnRlcmZhY2UsIGlkIDB4MTAwMDAwMjZh
LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTI4IG1zKSwgcmV0JAogICAg
ICAgICAgICAgICAgICB8ICAgICArLW8gQXBwbGVVc2VyVVNCSG9zdEhJRERldmljZSAgPGNsYXNz
IEFwcGxlVXNlckhJRERldmljZSwgaWQgMHgxMDAwMDAyYzIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICgxIG1zKSQKICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8gSU9I
SURJbnRlcmZhY2UgIDxjbGFzcyBJT0hJREludGVyZmFjZSwgaWQgMHgxMDAwMDAyY2IsIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxIG1zKSwgcmV0YWluIDg+CiAgICAgICAg
ICAgICAgICAgIHwgICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1ISURFdmVudERyaXZl
ciAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtSElERXZlbnREcml2ZXIsIGlkIDB4MTAwMDAw
MmNjLCByZWdpc3RlcmVkLCBtJAogICAgICAgICAgICAgICAgICB8ICAgICAgICAgICArLW8gSU9I
SURFdmVudFNlcnZpY2VVc2VyQ2xpZW50ICA8Y2xhc3MgSU9ISURFdmVudFNlcnZpY2VVc2VyQ2xp
ZW50LCBpZCAweDEwMDAwMDJkMCwgIXJlZ2lzdGVyZWQsICFtYXRjaGVkLCBhYyQKICAgICAgICAg
ICAgICAgICAgKy1vIEFwcGxlVVNCMjBYSENJUG9ydEAwOWIwMDAwMCAgPGNsYXNzIEFwcGxlVVNC
MjBYSENJUG9ydCwgaWQgMHgxMDAwMDAxY2QsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQjIwWEhDSVBv
cnRAMDljMDAwMDAgIDxjbGFzcyBBcHBsZVVTQjIwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMWNlLCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJlJAogICAgICAgICAg
ICAgICAgICArLW8gQXBwbGVVU0IyMFhIQ0lQb3J0QDA5ZDAwMDAwICA8Y2xhc3MgQXBwbGVVU0Iy
MFhIQ0lQb3J0LCBpZCAweDEwMDAwMDFjZiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBi
dXN5IDAgKDAgbXMpLCByZSQKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNCMjBYSENJUG9y
dEAwOWUwMDAwMCAgPGNsYXNzIEFwcGxlVVNCMjBYSENJUG9ydCwgaWQgMHgxMDAwMDAxZDAsIHJl
Z2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAgICAg
ICAgICAgICstbyBBcHBsZVVTQjIwWEhDSVBvcnRAMDlmMDAwMDAgIDxjbGFzcyBBcHBsZVVTQjIw
WEhDSVBvcnQsIGlkIDB4MTAwMDAwMWQxLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1
c3kgMCAoMCBtcyksIHJlJAoKKy1vIFJvb3QgIDxjbGFzcyBJT1JlZ2lzdHJ5RW50cnksIGlkIDB4
MTAwMDAwMTAwLCByZXRhaW4gNz4KICArLW8gVk1BMk1BQ09TQVAgIDxjbGFzcyBJT1BsYXRmb3Jt
RXhwZXJ0RGV2aWNlLCBpZCAweDEwMDAwMDEzNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZl
LCBidXN5IDAgKDg4NjEgbXMpLCByZXRhaW4gMjY+CiAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZv
cm1BUk1QRSAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUsIGlkIDB4MTAwMDAwMTM5
LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjg1IG1zKSwgcmV0YWluIDIx
JAogICAgICArLW8gYXJtLWlvICA8Y2xhc3MgSU9QbGF0Zm9ybURldmljZSwgaWQgMHgxMDAwMDAx
MTUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyODQgbXMpLCByZXRhaW4g
MTU+CiAgICAgICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtSU8gIDxjbGFzcyBBcHBsZVZpcnR1
YWxQbGF0Zm9ybUlPLCBpZCAweDEwMDAwMDE2MSwgIXJlZ2lzdGVyZWQsICFtYXRjaGVkLCBhY3Rp
dmUsIGJ1c3kgMCAoMjgxIG1zKSwgcmV0YWluIDEyJAogICAgICAgICAgKy1vIHBjaWVAMzAwMDAw
MDAgIDxjbGFzcyBBcHBsZUFSTUlPRGV2aWNlLCBpZCAweDEwMDAwMDExYSwgcmVnaXN0ZXJlZCwg
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDIyNyBtcyksIHJldGFpbiAxNz4KICAgICAgICAgICAg
Ky1vIEFwcGxlVmlydHVhbFBsYXRmb3JtUENJRSAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3Jt
UENJRSwgaWQgMHgxMDAwMDAxNmUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAw
ICgyMjQgbXMpLCByZXQkCiAgICAgICAgICAgICAgKy1vIHBjaTEwNmIsMWEwMUBBICA8Y2xhc3Mg
SU9QQ0lEZXZpY2UsIGlkIDB4MTAwMDAwMTc3LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUs
IGJ1c3kgMCAoMTMgbXMpLCByZXRhaW4gOT4KICAgICAgICAgICAgICAgIHwgewogICAgICAgICAg
ICAgICAgfCAgICJhc3NpZ25lZC1hZGRyZXNzZXMiID0gPDEwNTAwMDgyMDA0MDAwNTAwMDAwMDAw
MDAwNDAwMDAwMDAwMDAwMDAxODUwMDA4MmMwZDQwMTUwMDAwMDAwMDA0MDAwMDAwMDAwMDAwMDAw
PgogICAgICAgICAgICAgICAgfCAgICJJT0ludGVycnVwdFNwZWNpZmllcnMiID0gKDw0YTAwMDAw
MDAxMDAwMDAwPikKICAgICAgICAgICAgICAgIHwgICAiY2xhc3MtY29kZSIgPSA8ZmUwMzBjMDA+
CiAgICAgICAgICAgICAgICB8ICAgIklPRGV2aWNlTWVtb3J5IiA9ICgoeyJhZGRyZXNzIj0xMzQy
MTkzNjY0LCJsZW5ndGgiPTE2Mzg0fSksKHsiYWRkcmVzcyI9MTM0MjI5NzI4MCwibGVuZ3RoIj02
NH0pKQogICAgICAgICAgICAgICAgfCAgICJJT1JlcG9ydExlZ2VuZFB1YmxpYyIgPSBZZXMKICAg
ICAgICAgICAgICAgIHwgICAiSU9Qb3dlck1hbmFnZW1lbnQiID0geyJDdXJyZW50UG93ZXJTdGF0
ZSI9MiwiQ2FwYWJpbGl0eUZsYWdzIj0yNTgsIkNoaWxkUHJveHlQb3dlclN0YXRlIj0yLCJNYXhQ
b3dlclN0YXRlIj0zfQogICAgICAgICAgICAgICAgfCAgICJzdWJzeXN0ZW0tdmVuZG9yLWlkIiA9
IDw2YjEwMDAwMD4KICAgICAgICAgICAgICAgIHwgICAiSU9JbnRlcnJ1cHRDb250cm9sbGVycyIg
PSAoIklPSW50ZXJydXB0Q29udHJvbGxlcjAwMDAwMDM3IikKICAgICAgICAgICAgICAgIHwgICAi
dmVuZG9yLWlkIiA9IDw2YjEwMDAwMD4KICAgICAgICAgICAgICAgIHwgICAibmFtZSIgPSA8InBj
aTEwNmIsMWEwMSI+CiAgICAgICAgICAgICAgICB8ICAgImRldmljZS1pZCIgPSA8MDExYTAwMDA+
CiAgICAgICAgICAgICAgICB8ICAgIklPUENJUmVzb3VyY2VkIiA9IFllcwogICAgICAgICAgICAg
ICAgfCAgICJjb21wYXRpYmxlIiA9IDwicGNpMTA2YiwxYTAxIiwicGNpY2xhc3MsMGMwM2ZlIj4K
ICAgICAgICAgICAgICAgIHwgICAiSU9TZXJ2aWNlREVYVEVudGl0bGVtZW50cyIgPSAoKCJjb20u
YXBwbGUuZGV2ZWxvcGVyLmRyaXZlcmtpdC50cmFuc3BvcnQucGNpIikpCiAgICAgICAgICAgICAg
ICB8ICAgInN1YnN5c3RlbS1pZCIgPSA8MDExYTAwMDA+CiAgICAgICAgICAgICAgICB8ICAgInJl
dmlzaW9uLWlkIiA9IDwwMTAwMDAwMD4KICAgICAgICAgICAgICAgIHwgICAicGNpZGVidWciID0g
IjA6MTA6MCIKICAgICAgICAgICAgICAgIHwgICAiSU9OYW1lIiA9ICJwY2kxMDZiLDFhMDEiCiAg
ICAgICAgICAgICAgICB8ICAgIklPUmVwb3J0TGVnZW5kIiA9ICh7IklPUmVwb3J0R3JvdXBOYW1l
Ij0iSW50ZXJydXB0IFN0YXRpc3RpY3MgKGJ5IGluZGV4KSIsIklPUmVwb3J0Q2hhbm5lbHMiPSgo
NTI5MTI5NDY0NTE4MjAwNTI0OCw0Mjk1JAogICAgICAgICAgICAgICAgfCAgICJyZWciID0gPDAw
NTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxMDUwMDAwMjAwMDAwMDAwMDAw
MDAwMDAwMDQwMDAwMDAwMDAwMDAwMTg1MDAwMDIwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMCQKICAg
ICAgICAgICAgICAgIHwgfQogICAgICAgICAgICAgICAgfCAKICAgICAgICAgICAgICAgICstbyBB
cHBsZVZpcnRJT1BDSVRyYW5zcG9ydCAgPGNsYXNzIEFwcGxlVmlydElPUENJVHJhbnNwb3J0LCBp
ZCAweDEwMDAwMDE4YiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDkgbXMp
LCByZXQkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVZpcnRJT1VTQkNvbmZpZ3VyYXRpb24g
IDxjbGFzcyBBcHBsZVZpcnRJT1VTQkNvbmZpZ3VyYXRpb24sIGlkIDB4MTAwMDAwMTk3LCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoJAogICAgICAgICAgICAgICAgICAgICst
byBBcHBsZVZpcnRJT1VTQkRldmljZUNvbnRyb2xsZXJAMCAgPGNsYXNzIEFwcGxlVmlydElPVVNC
RGV2aWNlQ29udHJvbGxlciwgaWQgMHgxMDAwMDAxYTIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFj
dGl2ZSQKICAgICAgICAgICAgICAgICAgICAgICstbyBJT1VTQkRldmljZUNvbmZpZ3VyYXRvciAg
PGNsYXNzIElPVVNCRGV2aWNlQ29uZmlndXJhdG9yLCBpZCAweDEwMDAwMDFhMywgIXJlZ2lzdGVy
ZWQsICFtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCwgcmUkCiAgICAgICAgICAgICAgICAgICAgICAr
LW8gQXBwbGVVU0JOQ01Db250cm9sQDAgIDxjbGFzcyBJT1VTQkRldmljZUludGVyZmFjZSwgaWQg
MHgxMDAwMDAxYTUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwg
cmV0JAogICAgICAgICAgICAgICAgICAgICAgfCArLW8gQXBwbGVVU0JEZXZpY2VOQ01Db250cm9s
QDAgIDxjbGFzcyBBcHBsZVVTQkRldmljZU5DTUNvbnRyb2wsIGlkIDB4MTAwMDAwMWFhLCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCQKICAgICAgICAgICAgICAgICAgICAgICst
byBBcHBsZVVTQk5DTURhdGFAMSAgPGNsYXNzIElPVVNCRGV2aWNlSW50ZXJmYWNlLCBpZCAweDEw
MDAwMDFhNiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDcgbXMpLCByZXRh
aW4kCiAgICAgICAgICAgICAgICAgICAgICB8ICstbyBBcHBsZVVTQkRldmljZU5DTURhdGEgIDxj
bGFzcyBBcHBsZVVTQkRldmljZU5DTURhdGEsIGlkIDB4MTAwMDAwMWFkLCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksJAogICAgICAgICAgICAgICAgICAgICAgfCAg
ICstbyBlbjEgIDxjbGFzcyBJT0V0aGVybmV0SW50ZXJmYWNlLCBpZCAweDEwMDAwMDIwZCwgcmVn
aXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gMTE+CiAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICArLW8gSU9OZXR3b3JrU3RhY2sgIDxjbGFzcyBJT05ldHdv
cmtTdGFjaywgaWQgMHgxMDAwMDAxYmEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVz
eSAwICgwIG1zKSwgcmV0YWluIDEyJAogICAgICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8g
SU9OZXR3b3JrU3RhY2tVc2VyQ2xpZW50ICA8Y2xhc3MgSU9OZXR3b3JrU3RhY2tVc2VyQ2xpZW50
LCBpZCAweDEwMDAwMDI5MSwgIXJlZ2lzdGVyZWQsICFtYXRjaGVkLCBhY3RpdmUsICQKICAgICAg
ICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQk5DTUNvbnRyb2xBdXhAMiAgPGNsYXNzIElPVVNC
RGV2aWNlSW50ZXJmYWNlLCBpZCAweDEwMDAwMDFhNywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0
aXZlLCBidXN5IDAgKDEgbXMpLCAkCiAgICAgICAgICAgICAgICAgICAgICB8ICstbyBBcHBsZVVT
QkRldmljZU5DTUNvbnRyb2xAMiAgPGNsYXNzIEFwcGxlVVNCRGV2aWNlTkNNQ29udHJvbCwgaWQg
MHgxMDAwMDAxYjYsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwJAogICAgICAg
ICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNCTkNNRGF0YUF1eEAzICA8Y2xhc3MgSU9VU0JEZXZp
Y2VJbnRlcmZhY2UsIGlkIDB4MTAwMDAwMWE4LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUs
IGJ1c3kgMCAoNCBtcyksIHJldCQKICAgICAgICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNC
RGV2aWNlTkNNRGF0YSAgPGNsYXNzIEFwcGxlVVNCRGV2aWNlTkNNRGF0YSwgaWQgMHgxMDAwMDAx
YjAsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxIG1zKSwkCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgKy1vIGFucGkwICA8Y2xhc3MgQXBwbGVVU0JEZXZpY2VOQ01Qcml2
YXRlRXRoZXJuZXRJbnRlcmZhY2UsIGlkIDB4MTAwMDAwMWUxLCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhY3RpdmUsIGJ1c3kgMCAoJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgKy1vIElPTmV0
d29ya1N0YWNrICA8Y2xhc3MgSU9OZXR3b3JrU3RhY2ssIGlkIDB4MTAwMDAwMWJhLCByZWdpc3Rl
cmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpbiAxMiQKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKy1vIElPTmV0d29ya1N0YWNrVXNlckNsaWVudCAgPGNsYXNz
IElPTmV0d29ya1N0YWNrVXNlckNsaWVudCwgaWQgMHgxMDAwMDAyOTEsICFyZWdpc3RlcmVkLCAh
bWF0Y2hlZCwgYWN0aXZlLCAkCgorLW8gUm9vdCAgPGNsYXNzIElPUmVnaXN0cnlFbnRyeSwgaWQg
MHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAgPGNsYXNzIElPUGxhdGZv
cm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM1LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3Rp
dmUsIGJ1c3kgMCAoODg2MSBtcyksIHJldGFpbiAyNj4KICAgICstbyBBcHBsZVZpcnR1YWxQbGF0
Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSwgaWQgMHgxMDAwMDAx
MzksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyODUgbXMpLCByZXRhaW4g
MjEkCiAgICAgICstbyBhcm0taW8gIDxjbGFzcyBJT1BsYXRmb3JtRGV2aWNlLCBpZCAweDEwMDAw
MDExNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI4NCBtcyksIHJldGFp
biAxNT4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTyAgPGNsYXNzIEFwcGxlVmly
dHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTYxLCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFj
dGl2ZSwgYnVzeSAwICgyODEgbXMpLCByZXRhaW4gMTIkCiAgICAgICAgICArLW8gcGNpZUAzMDAw
MDAwMCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlkIDB4MTAwMDAwMTFhLCByZWdpc3RlcmVk
LCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjI3IG1zKSwgcmV0YWluIDE3PgogICAgICAgICAg
ICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZv
cm1QQ0lFLCBpZCAweDEwMDAwMDE2ZSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5
IDAgKDIyNCBtcyksIHJldCQKICAgICAgICAgICAgICArLW8gcGNpMTA2YiwxYTA0QEIgIDxjbGFz
cyBJT1BDSURldmljZSwgaWQgMHgxMDAwMDAxNzgsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2
ZSwgYnVzeSAwICg0IG1zKSwgcmV0YWluIDg+CiAgICAgICAgICAgICAgICAgIHsKICAgICAgICAg
ICAgICAgICAgICAic3Vic3lzdGVtLXZlbmRvci1pZCIgPSA8NmIxMDAwMDA+CiAgICAgICAgICAg
ICAgICAgICAgImNvbXBhdGlibGUiID0gPCJwY2kxMDZiLDFhMDQiLCJwY2ljbGFzcywwMDAwMDAi
PgogICAgICAgICAgICAgICAgICAgICJJT05hbWUiID0gInBjaTEwNmIsMWEwNCIKICAgICAgICAg
ICAgICAgICAgICAicmVnIiA9IDwwMDU4MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMTA1ODAwMDIwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDAwMDAwMDE4NTgwMDAyMDAwMDAw
MDAwMDAwMDAwMDQwMDAwMDAkCiAgICAgICAgICAgICAgICAgICAgImFzc2lnbmVkLWFkZHJlc3Nl
cyIgPSA8MTA1ODAwODIwMDAwMDA1MDAwMDAwMDAwMDA0MDAwMDAwMDAwMDAwMDE4NTgwMDgyODBk
NDAxNTAwMDAwMDAwMDQwMDAwMDAwMDAwMDAwMDA+CiAgICAgICAgICAgICAgICAgICAgImRldmlj
ZS1pZCIgPSA8MDQxYTAwMDA+CiAgICAgICAgICAgICAgICAgICAgIklPU2VydmljZURFWFRFbnRp
dGxlbWVudHMiID0gKCgiY29tLmFwcGxlLmRldmVsb3Blci5kcml2ZXJraXQudHJhbnNwb3J0LnBj
aSIpKQogICAgICAgICAgICAgICAgICAgICJJT1Bvd2VyTWFuYWdlbWVudCIgPSB7IkN1cnJlbnRQ
b3dlclN0YXRlIj0yLCJDYXBhYmlsaXR5RmxhZ3MiPTI1OCwiQ2hpbGRQcm94eVBvd2VyU3RhdGUi
PTIsIk1heFBvd2VyU3RhdGUiPTN9CiAgICAgICAgICAgICAgICAgICAgIklPUENJUmVzb3VyY2Vk
IiA9IFllcwogICAgICAgICAgICAgICAgICAgICJyZXZpc2lvbi1pZCIgPSA8MDEwMDAwMDA+CiAg
ICAgICAgICAgICAgICAgICAgIklPRGV2aWNlTWVtb3J5IiA9ICgoeyJhZGRyZXNzIj0xMzQyMTc3
MjgwLCJsZW5ndGgiPTE2Mzg0fSksKHsiYWRkcmVzcyI9MTM0MjI5NzIxNiwibGVuZ3RoIj02NH0p
KQogICAgICAgICAgICAgICAgICAgICJ2ZW5kb3ItaWQiID0gPDZiMTAwMDAwPgogICAgICAgICAg
ICAgICAgICAgICJwY2lkZWJ1ZyIgPSAiMDoxMTowIgogICAgICAgICAgICAgICAgICAgICJjbGFz
cy1jb2RlIiA9IDwwMDAwMDAwMD4KICAgICAgICAgICAgICAgICAgICAic3Vic3lzdGVtLWlkIiA9
IDwwNDFhMDAwMD4KICAgICAgICAgICAgICAgICAgICAibmFtZSIgPSA8InBjaTEwNmIsMWEwNCI+
CiAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgCgoKJSBpb3JlZyAtdHJjIElP
SW50ZXJydXB0Q29udHJvbGxlcgorLW8gUm9vdCAgPGNsYXNzIElPUmVnaXN0cnlFbnRyeSwgaWQg
MHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAgPGNsYXNzIElPUGxhdGZv
cm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM1LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3Rp
dmUsIGJ1c3kgMCAoODg2MiBtcyksIHJldGFpbiAyNj4KICAgICstbyBBcHBsZVZpcnR1YWxQbGF0
Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSwgaWQgMHgxMDAwMDAx
MzksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyODYgbXMpLCByZXRhaW4g
MjEkCiAgICAgICstbyBhcm0taW8gIDxjbGFzcyBJT1BsYXRmb3JtRGV2aWNlLCBpZCAweDEwMDAw
MDExNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI4NCBtcyksIHJldGFp
biAxNT4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTyAgPGNsYXNzIEFwcGxlVmly
dHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTYxLCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFj
dGl2ZSwgYnVzeSAwICgyODEgbXMpLCByZXRhaW4gMTIkCiAgICAgICAgICArLW8gZ2ljQDAgIDxj
bGFzcyBBcHBsZUFSTUlPRGV2aWNlLCBpZCAweDEwMDAwMDExNywgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDUgbXMpLCByZXRhaW4gOT4KICAgICAgICAgICAgKy1vIEFwcGxl
QVJNR0lDdjMgIDxjbGFzcyBBcHBsZUFSTUdJQ3YzLCBpZCAweDEwMDAwMDE2YiwgcmVnaXN0ZXJl
ZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDQgbXMpLCByZXRhaW4gNj4KICAgICAgICAgICAg
ICAgIHsKICAgICAgICAgICAgICAgICAgIklPQ2xhc3MiID0gIkFwcGxlQVJNR0lDdjMiCiAgICAg
ICAgICAgICAgICAgICJDRkJ1bmRsZUlkZW50aWZpZXIiID0gImNvbS5hcHBsZS5kcml2ZXIuQXBw
bGVBUk1HSUMiCiAgICAgICAgICAgICAgICAgICJJT1Byb3ZpZGVyQ2xhc3MiID0gIkFwcGxlQVJN
SU9EZXZpY2UiCiAgICAgICAgICAgICAgICAgICJTeXN0ZW1Qb3dlclByb2ZpbGVPdmVycmlkZURp
Y3QiID0geyJTeXN0ZW0gU2xlZXAgVGltZXIiPTIxNDc0ODM2NDd9CiAgICAgICAgICAgICAgICAg
ICJJT1Byb2JlU2NvcmUiID0gMTAwMAogICAgICAgICAgICAgICAgICAiSU9OYW1lTWF0Y2giID0g
IkFSTSxnaWN2MyIKICAgICAgICAgICAgICAgICAgIklPTWF0Y2hlZEF0Qm9vdCIgPSBZZXMKICAg
ICAgICAgICAgICAgICAgIklPTWF0Y2hDYXRlZ29yeSIgPSAiSU9EZWZhdWx0TWF0Y2hDYXRlZ29y
eSIKICAgICAgICAgICAgICAgICAgIklPTmFtZU1hdGNoZWQiID0gIkFSTSxnaWN2MyIKICAgICAg
ICAgICAgICAgICAgIklPUGVyc29uYWxpdHlQdWJsaXNoZXIiID0gImNvbS5hcHBsZS5kcml2ZXIu
QXBwbGVBUk1HSUMiCiAgICAgICAgICAgICAgICAgICJJbnRlcnJ1cHRDb250cm9sbGVyTmFtZSIg
PSAiSU9JbnRlcnJ1cHRDb250cm9sbGVyMDAwMDAwMzciCiAgICAgICAgICAgICAgICAgICJDRkJ1
bmRsZUlkZW50aWZpZXJLZXJuZWwiID0gImNvbS5hcHBsZS5kcml2ZXIuQXBwbGVBUk1HSUMiCiAg
ICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAKCistbyBSb290ICA8Y2xhc3MgSU9SZWdp
c3RyeUVudHJ5LCBpZCAweDEwMDAwMDEwMCwgcmV0YWluIDc+CiAgKy1vIFZNQTJNQUNPU0FQICA8
Y2xhc3MgSU9QbGF0Zm9ybUV4cGVydERldmljZSwgaWQgMHgxMDAwMDAxMzUsIHJlZ2lzdGVyZWQs
IG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg4ODYyIG1zKSwgcmV0YWluIDI2PgogICAgKy1vIEFw
cGxlVmlydHVhbFBsYXRmb3JtQVJNUEUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUFSTVBF
LCBpZCAweDEwMDAwMDEzOSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI4
NiBtcyksIHJldGFpbiAyMSQKICAgICAgKy1vIFBhc3N0aHJ1SW50ZXJydXB0Q29udHJvbGxlciAg
PGNsYXNzIFBhc3N0aHJ1SW50ZXJydXB0Q29udHJvbGxlciwgaWQgMHgxMDAwMDAxNjcsIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YWkkCiAgICAgICAgICB7
CiAgICAgICAgICAgICJJT1BsYXRmb3JtSW50ZXJydXB0Q29udHJvbGxlciIgPSBZZXMKICAgICAg
ICAgIH0KCiUgaW9yZWcgLXRyYyBBcHBsZVVTQlhIQ0kKKy1vIFJvb3QgIDxjbGFzcyBJT1JlZ2lz
dHJ5RW50cnksIGlkIDB4MTAwMDAwMTAwLCByZXRhaW4gNz4KICArLW8gVk1BMk1BQ09TQVAgIDxj
bGFzcyBJT1BsYXRmb3JtRXhwZXJ0RGV2aWNlLCBpZCAweDEwMDAwMDEzNSwgcmVnaXN0ZXJlZCwg
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDY2NTcgbXMpLCByZXRhaW4gMjY+CiAgICArLW8gQXBw
bGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUs
IGlkIDB4MTAwMDAwMTM5LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMzEw
IG1zKSwgcmV0YWluIDIxJAogICAgICArLW8gYXJtLWlvICA8Y2xhc3MgSU9QbGF0Zm9ybURldmlj
ZSwgaWQgMHgxMDAwMDAxMTUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgz
MDkgbXMpLCByZXRhaW4gMTU+CiAgICAgICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtSU8gIDxj
bGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUlPLCBpZCAweDEwMDAwMDE2MSwgIXJlZ2lzdGVyZWQs
ICFtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMzA2IG1zKSwgcmV0YWluIDEyJAogICAgICAgICAg
Ky1vIHBjaWVAMzAwMDAwMDAgIDxjbGFzcyBBcHBsZUFSTUlPRGV2aWNlLCBpZCAweDEwMDAwMDEx
YSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI1MyBtcyksIHJldGFpbiAx
Nz4KICAgICAgICAgICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtUENJRSAgPGNsYXNzIEFwcGxl
VmlydHVhbFBsYXRmb3JtUENJRSwgaWQgMHgxMDAwMDAxNmUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICgyNTAgbXMpLCByZXQkCiAgICAgICAgICAgICAgKy1vIHBjaTEwNmIs
MWEwNkA5ICA8Y2xhc3MgSU9QQ0lEZXZpY2UsIGlkIDB4MTAwMDAwMTc2LCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTg0IG1zKSwgcmV0YWluIDEyPgogICAgICAgICAgICAg
ICAgKy1vIEFwcGxlVVNCWEhDSVBDSUAwOTAwMDAwMCAgPGNsYXNzIEFwcGxlVVNCWEhDSVBDSSwg
aWQgMHgxMDAwMDAxOGEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxNzAg
bXMpLCByZXRhaW4gMSQKICAgICAgICAgICAgICAgICAgfCB7CiAgICAgICAgICAgICAgICAgIHwg
ICAiSU9DbGFzcyIgPSAiQXBwbGVVU0JYSENJUENJIgogICAgICAgICAgICAgICAgICB8ICAgIkNG
QnVuZGxlSWRlbnRpZmllciIgPSAiY29tLmFwcGxlLmRyaXZlci51c2IuQXBwbGVVU0JYSENJUENJ
IgogICAgICAgICAgICAgICAgICB8ICAgIklPUHJvdmlkZXJDbGFzcyIgPSAiSU9QQ0lEZXZpY2Ui
CiAgICAgICAgICAgICAgICAgIHwgICAia1VTQlNsZWVwU3VwcG9ydGVkIiA9IE5vCiAgICAgICAg
ICAgICAgICAgIHwgICAiSU9QQ0lDbGFzc01hdGNoIiA9ICIweDBjMDMzMDAwIgogICAgICAgICAg
ICAgICAgICB8ICAgIklPUENJVHVubmVsQ29tcGF0aWJsZSIgPSBZZXMKICAgICAgICAgICAgICAg
ICAgfCAgICJJT1Bvd2VyTWFuYWdlbWVudCIgPSB7IkNoaWxkcmVuUG93ZXJTdGF0ZSI9MywiRGV2
aWNlUG93ZXJTdGF0ZSI9MCwiQ3VycmVudFBvd2VyU3RhdGUiPTMsIkNhcGFiaWxpdHlGbGFncyI9
MzI3NjgsIk1heFAkCiAgICAgICAgICAgICAgICAgIHwgICAiSU9Qcm9iZVNjb3JlIiA9IDAKICAg
ICAgICAgICAgICAgICAgfCAgICJJT01hdGNoZWRBdEJvb3QiID0gWWVzCiAgICAgICAgICAgICAg
ICAgIHwgICAiSU9QQ0lQYXVzZUNvbXBhdGlibGUiID0gWWVzCiAgICAgICAgICAgICAgICAgIHwg
ICAiSU9NYXRjaENhdGVnb3J5IiA9ICJJT0RlZmF1bHRNYXRjaENhdGVnb3J5IgogICAgICAgICAg
ICAgICAgICB8ICAgImxvY2F0aW9uSUQiID0gMTUwOTk0OTQ0CiAgICAgICAgICAgICAgICAgIHwg
ICAiUmV2aXNpb24iID0gPDAxMDM+CiAgICAgICAgICAgICAgICAgIHwgICAiY29udHJvbGxlci1z
dGF0aXN0aWNzIiA9IHsia0NvbnRyb2xsZXJTdGF0SU9Db3VudCI9NjIsImtDb250cm9sbGVyU3Rh
dFBvd2VyU3RhdGVUaW1lIj17ImtQb3dlclN0YXRlT2ZmIj0iMG1zICgwJSkiLCJrJAogICAgICAg
ICAgICAgICAgICB8ICAgIklPUGVyc29uYWxpdHlQdWJsaXNoZXIiID0gImNvbS5hcHBsZS5kcml2
ZXIudXNiLkFwcGxlVVNCWEhDSVBDSSIKICAgICAgICAgICAgICAgICAgfCAgICJDRkJ1bmRsZUlk
ZW50aWZpZXJLZXJuZWwiID0gImNvbS5hcHBsZS5kcml2ZXIudXNiLkFwcGxlVVNCWEhDSVBDSSIK
ICAgICAgICAgICAgICAgICAgfCAgICJVc2JIb3N0Q29udHJvbGxlclN0cmVhbVBvbGljeSIgPSAw
CiAgICAgICAgICAgICAgICAgIHwgICAiSU9QQ0lVc2VEZXZpY2VNYXBwZXIiID0gWWVzCiAgICAg
ICAgICAgICAgICAgIHwgfQogICAgICAgICAgICAgICAgICB8IAogICAgICAgICAgICAgICAgICAr
LW8gQXBwbGVVU0IzMFhIQ0lQb3J0QDA5MTAwMDAwICA8Y2xhc3MgQXBwbGVVU0IzMFhIQ0lQb3J0
LCBpZCAweDEwMDAwMDFmZiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAg
bXMpLCByZSQKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNCMzBYSENJUG9ydEAwOTIwMDAw
MCAgPGNsYXNzIEFwcGxlVVNCMzBYSENJUG9ydCwgaWQgMHgxMDAwMDAyMDAsIHJlZ2lzdGVyZWQs
IG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAgICAgICAgICAgICst
byBBcHBsZVVTQjMwWEhDSVBvcnRAMDkzMDAwMDAgIDxjbGFzcyBBcHBsZVVTQjMwWEhDSVBvcnQs
IGlkIDB4MTAwMDAwMjAxLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBt
cyksIHJlJAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVVU0IzMFhIQ0lQb3J0QDA5NDAwMDAw
ICA8Y2xhc3MgQXBwbGVVU0IzMFhIQ0lQb3J0LCBpZCAweDEwMDAwMDIwMiwgcmVnaXN0ZXJlZCwg
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZSQKICAgICAgICAgICAgICAgICAgKy1v
IEFwcGxlVVNCMzBYSENJUG9ydEAwOTUwMDAwMCAgPGNsYXNzIEFwcGxlVVNCMzBYSENJUG9ydCwg
aWQgMHgxMDAwMDAyMDMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1z
KSwgcmUkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQjMwWEhDSVBvcnRAMDk2MDAwMDAg
IDxjbGFzcyBBcHBsZVVTQjMwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMjA0LCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJlJAogICAgICAgICAgICAgICAgICArLW8g
QXBwbGVVU0IzMFhIQ0lQb3J0QDA5NzAwMDAwICA8Y2xhc3MgQXBwbGVVU0IzMFhIQ0lQb3J0LCBp
ZCAweDEwMDAwMDIwNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMp
LCByZSQKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNCMzBYSENJUG9ydEAwOTgwMDAwMCAg
PGNsYXNzIEFwcGxlVVNCMzBYSENJUG9ydCwgaWQgMHgxMDAwMDAyMDYsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAgICAgICAgICAgICstbyBB
cHBsZVVTQjIwWEhDSVBvcnRAMDk5MDAwMDAgIDxjbGFzcyBBcHBsZVVTQjIwWEhDSVBvcnQsIGlk
IDB4MTAwMDAwMjA3LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTY5IG1z
KSwgJAogICAgICAgICAgICAgICAgICB8ICstbyBWaXJ0dWFsIFVTQiBLZXlib2FyZEAwOTkwMDAw
MCAgPGNsYXNzIElPVVNCSG9zdERldmljZSwgaWQgMHgxMDAwMDAyNjYsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxNjkgbXMpLCQKICAgICAgICAgICAgICAgICAgfCAgICst
byBBcHBsZVVTQkhvc3RDb21wb3NpdGVEZXZpY2UgIDxjbGFzcyBBcHBsZVVTQkhvc3RDb21wb3Np
dGVEZXZpY2UsIGlkIDB4MTAwMDAwMjY5LCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwg
YnUkCiAgICAgICAgICAgICAgICAgIHwgICArLW8gSU9VU0JIb3N0SW50ZXJmYWNlQDAgIDxjbGFz
cyBJT1VTQkhvc3RJbnRlcmZhY2UsIGlkIDB4MTAwMDAwMjZhLCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhY3RpdmUsIGJ1c3kgMCAoMTY3IG1zKSwgcmV0JAogICAgICAgICAgICAgICAgICB8ICAgICAr
LW8gQXBwbGVVc2VyVVNCSG9zdEhJRERldmljZSAgPGNsYXNzIEFwcGxlVXNlckhJRERldmljZSwg
aWQgMHgxMDAwMDAyYjIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyIG1z
KSQKICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8gSU9ISURJbnRlcmZhY2UgIDxjbGFzcyBJ
T0hJREludGVyZmFjZSwgaWQgMHgxMDAwMDAyYmYsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2
ZSwgYnVzeSAwICgyIG1zKSwgcmV0YWluIDEwPgogICAgICAgICAgICAgICAgICB8ICAgICAgICAg
Ky1vIEFwcGxlVXNlckhJREV2ZW50RHJpdmVyICA8Y2xhc3MgQXBwbGVVc2VySElERXZlbnRTZXJ2
aWNlLCBpZCAweDEwMDAwMDJjNiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5ICQK
ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgKy1vIElPSElERXZlbnRTZXJ2aWNlVXNlckNs
aWVudCAgPGNsYXNzIElPSElERXZlbnRTZXJ2aWNlVXNlckNsaWVudCwgaWQgMHgxMDAwMDAyY2Es
ICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWMkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVT
QjIwWEhDSVBvcnRAMDlhMDAwMDAgIDxjbGFzcyBBcHBsZVVTQjIwWEhDSVBvcnQsIGlkIDB4MTAw
MDAwMjA4LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTY2IG1zKSwgJAog
ICAgICAgICAgICAgICAgICB8ICstbyBWaXJ0dWFsIFVTQiBEaWdpdGl6ZXJAMDlhMDAwMDAgIDxj
bGFzcyBJT1VTQkhvc3REZXZpY2UsIGlkIDB4MTAwMDAwMjZjLCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhY3RpdmUsIGJ1c3kgMCAoMTY2IG1zKSQKICAgICAgICAgICAgICAgICAgfCAgICstbyBBcHBs
ZVVTQkhvc3RDb21wb3NpdGVEZXZpY2UgIDxjbGFzcyBBcHBsZVVTQkhvc3RDb21wb3NpdGVEZXZp
Y2UsIGlkIDB4MTAwMDAwMjZmLCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnUkCiAg
ICAgICAgICAgICAgICAgIHwgICArLW8gSU9VU0JIb3N0SW50ZXJmYWNlQDAgIDxjbGFzcyBJT1VT
Qkhvc3RJbnRlcmZhY2UsIGlkIDB4MTAwMDAwMjcwLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3Rp
dmUsIGJ1c3kgMCAoMTY1IG1zKSwgcmV0JAogICAgICAgICAgICAgICAgICB8ICAgICArLW8gQXBw
bGVVc2VyVVNCSG9zdEhJRERldmljZSAgPGNsYXNzIEFwcGxlVXNlckhJRERldmljZSwgaWQgMHgx
MDAwMDAyYjEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxIG1zKSQKICAg
ICAgICAgICAgICAgICAgfCAgICAgICArLW8gSU9ISURJbnRlcmZhY2UgIDxjbGFzcyBJT0hJRElu
dGVyZmFjZSwgaWQgMHgxMDAwMDAyYmQsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVz
eSAwICgxIG1zKSwgcmV0YWluIDg+CiAgICAgICAgICAgICAgICAgIHwgICAgICAgICArLW8gQXBw
bGVWaXJ0dWFsUGxhdGZvcm1ISURFdmVudERyaXZlciAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRm
b3JtSElERXZlbnREcml2ZXIsIGlkIDB4MTAwMDAwMmMwLCByZWdpc3RlcmVkLCBtJAogICAgICAg
ICAgICAgICAgICB8ICAgICAgICAgICArLW8gSU9ISURFdmVudFNlcnZpY2VVc2VyQ2xpZW50ICA8
Y2xhc3MgSU9ISURFdmVudFNlcnZpY2VVc2VyQ2xpZW50LCBpZCAweDEwMDAwMDJjNSwgIXJlZ2lz
dGVyZWQsICFtYXRjaGVkLCBhYyQKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNCMjBYSENJ
UG9ydEAwOWIwMDAwMCAgPGNsYXNzIEFwcGxlVVNCMjBYSENJUG9ydCwgaWQgMHgxMDAwMDAyMDks
IHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAg
ICAgICAgICAgICstbyBBcHBsZVVTQjIwWEhDSVBvcnRAMDljMDAwMDAgIDxjbGFzcyBBcHBsZVVT
QjIwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMjBhLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUs
IGJ1c3kgMCAoMCBtcyksIHJlJAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVVU0IyMFhIQ0lQ
b3J0QDA5ZDAwMDAwICA8Y2xhc3MgQXBwbGVVU0IyMFhIQ0lQb3J0LCBpZCAweDEwMDAwMDIwYiwg
cmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZSQKICAgICAgICAg
ICAgICAgICAgKy1vIEFwcGxlVVNCMjBYSENJUG9ydEAwOWUwMDAwMCAgPGNsYXNzIEFwcGxlVVNC
MjBYSENJUG9ydCwgaWQgMHgxMDAwMDAyMGMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQjIwWEhDSVBv
cnRAMDlmMDAwMDAgIDxjbGFzcyBBcHBsZVVTQjIwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMjBkLCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJlJAoKCgolIGlvcmVn
IC10cmMgQXBwbGVWaXJ0SU9QQ0lUcmFuc3BvcnQKKy1vIFJvb3QgIDxjbGFzcyBJT1JlZ2lzdHJ5
RW50cnksIGlkIDB4MTAwMDAwMTAwLCByZXRhaW4gNz4KICArLW8gVk1BMk1BQ09TQVAgIDxjbGFz
cyBJT1BsYXRmb3JtRXhwZXJ0RGV2aWNlLCBpZCAweDEwMDAwMDEzNSwgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDY2NjIgbXMpLCByZXRhaW4gMjY+CiAgICArLW8gQXBwbGVW
aXJ0dWFsUGxhdGZvcm1BUk1QRSAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUsIGlk
IDB4MTAwMDAwMTM5LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMzExIG1z
KSwgcmV0YWluIDIxJAogICAgICArLW8gYXJtLWlvICA8Y2xhc3MgSU9QbGF0Zm9ybURldmljZSwg
aWQgMHgxMDAwMDAxMTUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgzMTAg
bXMpLCByZXRhaW4gMTU+CiAgICAgICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtSU8gIDxjbGFz
cyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUlPLCBpZCAweDEwMDAwMDE2MSwgIXJlZ2lzdGVyZWQsICFt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMzA3IG1zKSwgcmV0YWluIDEyJAogICAgICAgICAgKy1v
IHBjaWVAMzAwMDAwMDAgIDxjbGFzcyBBcHBsZUFSTUlPRGV2aWNlLCBpZCAweDEwMDAwMDExYSwg
cmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI1MyBtcyksIHJldGFpbiAxNz4K
ICAgICAgICAgICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtUENJRSAgPGNsYXNzIEFwcGxlVmly
dHVhbFBsYXRmb3JtUENJRSwgaWQgMHgxMDAwMDAxNmUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFj
dGl2ZSwgYnVzeSAwICgyNTAgbXMpLCByZXQkCiAgICAgICAgICAgICAgKy1vIGV0aGVybmV0QDEg
IDxjbGFzcyBJT1BDSURldmljZSwgaWQgMHgxMDAwMDAxNzEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICgxNCBtcyksIHJldGFpbiA5PgogICAgICAgICAgICAgICAgKy1vIEFw
cGxlVmlydElPUENJVHJhbnNwb3J0ICA8Y2xhc3MgQXBwbGVWaXJ0SU9QQ0lUcmFuc3BvcnQsIGlk
IDB4MTAwMDAwMTg1LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTAgbXMp
LCByZSQKICAgICAgICAgICAgICAgICAgfCB7CiAgICAgICAgICAgICAgICAgIHwgICAiSU9QQ0lQ
cmltYXJ5TWF0Y2giID0gIjB4MDAwMDFhZjQmMHgwMDAwRkZGRiIKICAgICAgICAgICAgICAgICAg
fCAgICJDRkJ1bmRsZUlkZW50aWZpZXIiID0gImNvbS5hcHBsZS5kcml2ZXIuQXBwbGVWaXJ0SU8i
CiAgICAgICAgICAgICAgICAgIHwgICAiSU9Qcm92aWRlckNsYXNzIiA9ICJJT1BDSURldmljZSIK
ICAgICAgICAgICAgICAgICAgfCAgICJJT0NsYXNzIiA9ICJBcHBsZVZpcnRJT1BDSVRyYW5zcG9y
dCIKICAgICAgICAgICAgICAgICAgfCAgICJJT1BlcnNvbmFsaXR5UHVibGlzaGVyIiA9ICJjb20u
YXBwbGUuZHJpdmVyLkFwcGxlVmlydElPIgogICAgICAgICAgICAgICAgICB8ICAgIkNGQnVuZGxl
SWRlbnRpZmllcktlcm5lbCIgPSAiY29tLmFwcGxlLmRyaXZlci5BcHBsZVZpcnRJTyIKICAgICAg
ICAgICAgICAgICAgfCAgICJJT1Byb2JlU2NvcmUiID0gMTAwMDAKICAgICAgICAgICAgICAgICAg
fCAgICJJT01hdGNoZWRBdEJvb3QiID0gWWVzCiAgICAgICAgICAgICAgICAgIHwgICAiSU9NYXRj
aENhdGVnb3J5IiA9ICJJT0RlZmF1bHRNYXRjaENhdGVnb3J5IgogICAgICAgICAgICAgICAgICB8
ICAgImJ1aWx0LWluIiA9IDwwMD4KICAgICAgICAgICAgICAgICAgfCB9CiAgICAgICAgICAgICAg
ICAgIHwgCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVZpcnRJT05ldHdvcmsgIDxjbGFzcyBB
cHBsZVZpcnRJT05ldHdvcmssIGlkIDB4MTAwMDAwMThlLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBh
Y3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpbiA5PgogICAgICAgICAgICAgICAgICAgICstbyBl
bjAgIDxjbGFzcyBJT0V0aGVybmV0SW50ZXJmYWNlLCBpZCAweDEwMDAwMDFmNywgcmVnaXN0ZXJl
ZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gMTM+CiAgICAgICAgICAg
ICAgICAgICAgICArLW8gSU9OZXR3b3JrU3RhY2sgIDxjbGFzcyBJT05ldHdvcmtTdGFjaywgaWQg
MHgxMDAwMDAxY2IsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwg
cmV0YWluIDEyPgogICAgICAgICAgICAgICAgICAgICAgICArLW8gSU9OZXR3b3JrU3RhY2tVc2Vy
Q2xpZW50ICA8Y2xhc3MgSU9OZXR3b3JrU3RhY2tVc2VyQ2xpZW50LCBpZCAweDEwMDAwMDI5Niwg
IXJlZ2lzdGVyZWQsICFtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCQKCistbyBSb290ICA8Y2xhc3Mg
SU9SZWdpc3RyeUVudHJ5LCBpZCAweDEwMDAwMDEwMCwgcmV0YWluIDc+CiAgKy1vIFZNQTJNQUNP
U0FQICA8Y2xhc3MgSU9QbGF0Zm9ybUV4cGVydERldmljZSwgaWQgMHgxMDAwMDAxMzUsIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg2NjYyIG1zKSwgcmV0YWluIDI2PgogICAg
Ky1vIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9y
bUFSTVBFLCBpZCAweDEwMDAwMDEzOSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5
IDAgKDMxMSBtcyksIHJldGFpbiAyMSQKICAgICAgKy1vIGFybS1pbyAgPGNsYXNzIElPUGxhdGZv
cm1EZXZpY2UsIGlkIDB4MTAwMDAwMTE1LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1
c3kgMCAoMzEwIG1zKSwgcmV0YWluIDE1PgogICAgICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9y
bUlPICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTywgaWQgMHgxMDAwMDAxNjEsICFyZWdp
c3RlcmVkLCAhbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDMwNyBtcyksIHJldGFpbiAxMiQKICAg
ICAgICAgICstbyBwY2llQDMwMDAwMDAwICA8Y2xhc3MgQXBwbGVBUk1JT0RldmljZSwgaWQgMHgx
MDAwMDAxMWEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyNTMgbXMpLCBy
ZXRhaW4gMTc+CiAgICAgICAgICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUgIDxjbGFz
cyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUsIGlkIDB4MTAwMDAwMTZlLCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjUwIG1zKSwgcmV0JAogICAgICAgICAgICAgICstbyBw
Y2kxYWY0LDEwNDNANSAgPGNsYXNzIElPUENJRGV2aWNlLCBpZCAweDEwMDAwMDE3MiwgcmVnaXN0
ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDE0IG1zKSwgcmV0YWluIDk+CiAgICAgICAg
ICAgICAgICArLW8gQXBwbGVWaXJ0SU9QQ0lUcmFuc3BvcnQgIDxjbGFzcyBBcHBsZVZpcnRJT1BD
SVRyYW5zcG9ydCwgaWQgMHgxMDAwMDAxODYsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgxMCBtcyksIHJlJAogICAgICAgICAgICAgICAgICB8IHsKICAgICAgICAgICAgICAg
ICAgfCAgICJJT1BDSVByaW1hcnlNYXRjaCIgPSAiMHgwMDAwMWFmNCYweDAwMDBGRkZGIgogICAg
ICAgICAgICAgICAgICB8ICAgIkNGQnVuZGxlSWRlbnRpZmllciIgPSAiY29tLmFwcGxlLmRyaXZl
ci5BcHBsZVZpcnRJTyIKICAgICAgICAgICAgICAgICAgfCAgICJJT1Byb3ZpZGVyQ2xhc3MiID0g
IklPUENJRGV2aWNlIgogICAgICAgICAgICAgICAgICB8ICAgIklPQ2xhc3MiID0gIkFwcGxlVmly
dElPUENJVHJhbnNwb3J0IgogICAgICAgICAgICAgICAgICB8ICAgIklPUGVyc29uYWxpdHlQdWJs
aXNoZXIiID0gImNvbS5hcHBsZS5kcml2ZXIuQXBwbGVWaXJ0SU8iCiAgICAgICAgICAgICAgICAg
IHwgICAiQ0ZCdW5kbGVJZGVudGlmaWVyS2VybmVsIiA9ICJjb20uYXBwbGUuZHJpdmVyLkFwcGxl
VmlydElPIgogICAgICAgICAgICAgICAgICB8ICAgIklPUHJvYmVTY29yZSIgPSAxMDAwMAogICAg
ICAgICAgICAgICAgICB8ICAgIklPTWF0Y2hlZEF0Qm9vdCIgPSBZZXMKICAgICAgICAgICAgICAg
ICAgfCAgICJJT01hdGNoQ2F0ZWdvcnkiID0gIklPRGVmYXVsdE1hdGNoQ2F0ZWdvcnkiCiAgICAg
ICAgICAgICAgICAgIHwgICAiYnVpbHQtaW4iID0gPDAwPgogICAgICAgICAgICAgICAgICB8IH0K
ICAgICAgICAgICAgICAgICAgfCAKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVmlydElPQ29u
c29sZSAgPGNsYXNzIEFwcGxlVmlydElPQ29uc29sZSwgaWQgMHgxMDAwMDAxOGYsIHJlZ2lzdGVy
ZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg4IG1zKSwgcmV0YWluIDg+CiAgICAgICAgICAg
ICAgICAgICAgKy1vIElPU2VyaWFsU3RyZWFtU3luYyAgPGNsYXNzIElPU2VyaWFsU3RyZWFtU3lu
YywgaWQgMHgxMDAwMDAxOTEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg4
IG1zKSwgcmV0YWluIDc+CiAgICAgICAgICAgICAgICAgICAgICArLW8gSU9TZXJpYWxCU0RDbGll
bnQgIDxjbGFzcyBJT1NlcmlhbEJTRENsaWVudCwgaWQgMHgxMDAwMDAxOWIsIHJlZ2lzdGVyZWQs
IG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YWluIDU+CgorLW8gUm9vdCAgPGNs
YXNzIElPUmVnaXN0cnlFbnRyeSwgaWQgMHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEy
TUFDT1NBUCAgPGNsYXNzIElPUGxhdGZvcm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM1LCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoNjY2MiBtcyksIHJldGFpbiAyNj4K
ICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxh
dGZvcm1BUk1QRSwgaWQgMHgxMDAwMDAxMzksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgzMTEgbXMpLCByZXRhaW4gMjEkCiAgICAgICstbyBhcm0taW8gIDxjbGFzcyBJT1Bs
YXRmb3JtRGV2aWNlLCBpZCAweDEwMDAwMDExNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZl
LCBidXN5IDAgKDMxMCBtcyksIHJldGFpbiAxNT4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxh
dGZvcm1JTyAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTYxLCAh
cmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgzMDcgbXMpLCByZXRhaW4gMTIk
CiAgICAgICAgICArLW8gcGNpZUAzMDAwMDAwMCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlk
IDB4MTAwMDAwMTFhLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjUzIG1z
KSwgcmV0YWluIDE3PgogICAgICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFICA8
Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFLCBpZCAweDEwMDAwMDE2ZSwgcmVnaXN0ZXJl
ZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI1MCBtcyksIHJldCQKICAgICAgICAgICAgICAr
LW8gcGNpMTA2YiwxYTAwQDYgIDxjbGFzcyBJT1BDSURldmljZSwgaWQgMHgxMDAwMDAxNzMsIHJl
Z2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg4MCBtcyksIHJldGFpbiAxMD4KICAg
ICAgICAgICAgICAgICstbyBBcHBsZVZpcnRJT1BDSVRyYW5zcG9ydCAgPGNsYXNzIEFwcGxlVmly
dElPUENJVHJhbnNwb3J0LCBpZCAweDEwMDAwMDE4NywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0
aXZlLCBidXN5IDAgKDc2IG1zKSwgcmUkCiAgICAgICAgICAgICAgICAgIHwgewogICAgICAgICAg
ICAgICAgICB8ICAgIklPUENJUHJpbWFyeU1hdGNoIiA9ICIweDFhMDAxMDZiJjB4RkZGRkZGRkYi
CiAgICAgICAgICAgICAgICAgIHwgICAiQ0ZCdW5kbGVJZGVudGlmaWVyIiA9ICJjb20uYXBwbGUu
ZHJpdmVyLkFwcGxlVmlydElPIgogICAgICAgICAgICAgICAgICB8ICAgIklPUHJvdmlkZXJDbGFz
cyIgPSAiSU9QQ0lEZXZpY2UiCiAgICAgICAgICAgICAgICAgIHwgICAiSU9DbGFzcyIgPSAiQXBw
bGVWaXJ0SU9QQ0lUcmFuc3BvcnQiCiAgICAgICAgICAgICAgICAgIHwgICAiSU9QZXJzb25hbGl0
eVB1Ymxpc2hlciIgPSAiY29tLmFwcGxlLmlva2l0LkFwcGxlVmlydElPU3RvcmFnZSIKICAgICAg
ICAgICAgICAgICAgfCAgICJDRkJ1bmRsZUlkZW50aWZpZXJLZXJuZWwiID0gImNvbS5hcHBsZS5k
cml2ZXIuQXBwbGVWaXJ0SU8iCiAgICAgICAgICAgICAgICAgIHwgICAiSU9Qcm9iZVNjb3JlIiA9
IDEwMDAwCiAgICAgICAgICAgICAgICAgIHwgICAiSU9NYXRjaGVkQXRCb290IiA9IFllcwogICAg
ICAgICAgICAgICAgICB8ICAgIklPTWF0Y2hDYXRlZ29yeSIgPSAiSU9EZWZhdWx0TWF0Y2hDYXRl
Z29yeSIKICAgICAgICAgICAgICAgICAgfCAgICJidWlsdC1pbiIgPSA8MDA+CiAgICAgICAgICAg
ICAgICAgIHwgfQogICAgICAgICAgICAgICAgICB8IAogICAgICAgICAgICAgICAgICArLW8gQXBw
bGVWaXJ0SU9TdG9yYWdlRGV2aWNlICA8Y2xhc3MgQXBwbGVWaXJ0SU9TdG9yYWdlRGV2aWNlLCBp
ZCAweDEwMDAwMDE5MCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDc0IG1z
KSQKICAgICAgICAgICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9EaXNrU3RvcmFnZURldmljZUAx
ICA8Y2xhc3MgQXBwbGVWaXJ0SU9EaXNrU3RvcmFnZURldmljZSwgaWQgMHgxMDAwMDAxOTMsIHJl
Z2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnUkCiAgICAgICAgICAgICAgICAgICAgICArLW8g
SU9CbG9ja1N0b3JhZ2VEcml2ZXIgIDxjbGFzcyBJT0Jsb2NrU3RvcmFnZURyaXZlciwgaWQgMHgx
MDAwMDAxOTQsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg3NCBtcyksIHJl
JAogICAgICAgICAgICAgICAgICAgICAgICArLW8gQXBwbGUgSW5jLiBWaXJ0SU8gQmxvY2sgTWVk
aWEgIDxjbGFzcyBJT01lZGlhLCBpZCAweDEwMDAwMDE5NSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDc0IG1zKSwgcmV0YSQKICAgICAgICAgICAgICAgICAgICAgICAgICAr
LW8gSU9NZWRpYUJTRENsaWVudCAgPGNsYXNzIElPTWVkaWFCU0RDbGllbnQsIGlkIDB4MTAwMDAw
MWEwLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMSBtcyksIHJldGFpbiAk
CiAgICAgICAgICAgICAgICAgICAgICAgICAgKy1vIElPR1VJRFBhcnRpdGlvblNjaGVtZSAgPGNs
YXNzIElPR1VJRFBhcnRpdGlvblNjaGVtZSwgaWQgMHgxMDAwMDAxYjAsICFyZWdpc3RlcmVkLCAh
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDcyJAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ky1vIGlCb290U3lzdGVtQ29udGFpbmVyQDEgIDxjbGFzcyBJT01lZGlhLCBpZCAweDEwMDAwMDFi
YiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDE3IG1zKSwgcmV0YWluICQK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgKy1vIElPTWVkaWFCU0RDbGllbnQgIDxjbGFz
cyBJT01lZGlhQlNEQ2xpZW50LCBpZCAweDEwMDAwMDFiZSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXQkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICstbyBBcHBsZUFQRlNDb250YWluZXJTY2hlbWUgIDxjbGFzcyBBcHBsZUFQRlNDb250YWluZXJT
Y2hlbWUsIGlkIDB4MTAwMDAwMWJmLCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgJAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICstbyBBcHBsZUFQRlNNZWRpYSAgPGNsYXNz
IEFwcGxlQVBGU01lZGlhLCBpZCAweDEwMDAwMDFjMCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0
aXZlLCBidXN5IDAgKDE2IG1zKSwgcmV0YSQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgICstbyBBcHBsZUFQRlNNZWRpYUJTRENsaWVudCAgPGNsYXNzIEFwcGxlQVBGU01lZGlhQlNE
Q2xpZW50LCBpZCAweDEwMDAwMDFjZiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCAkCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICArLW8gQXBwbGVBUEZTQ29udGFpbmVyICA8
Y2xhc3MgQXBwbGVBUEZTQ29udGFpbmVyLCBpZCAweDEwMDAwMDFlYSwgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICAgICArLW8gaVNDUHJlYm9vdEAxICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAw
MDIxZCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZSQKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNE
Q2xpZW50ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDIyMSwg
cmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWMkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
ICAgICstbyB4QVJUQDIgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWUsIGlkIDB4MTAwMDAwMjFlLCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpbiAxJAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICB8ICstbyBBcHBsZUFQRlNWb2x1bWVCU0RD
bGllbnQgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQsIGlkIDB4MTAwMDAwMjIzLCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhYyQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICAgKy1vIEhhcmR3YXJlQDMgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWUsIGlkIDB4MTAwMDAwMjFm
LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGEkCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwgKy1vIEFwcGxlQVBGU1ZvbHVtZUJTRENs
aWVudCAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCwgaWQgMHgxMDAwMDAyMjUsIHJl
Z2lzdGVyZWQsIG1hdGNoZWQsIGFjJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICArLW8gUmVjb3ZlcnlANCAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMjAs
IHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YSQKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xp
ZW50ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDIyNywgcmVn
aXN0ZXJlZCwgbWF0Y2hlZCwgYWMkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICArLW8gQ29u
dGFpbmVyQDIgIDxjbGFzcyBJT01lZGlhLCBpZCAweDEwMDAwMDFiYywgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDcyIG1zKSwgcmV0YWluIDEyPgogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCArLW8gSU9NZWRpYUJTRENsaWVudCAgPGNsYXNzIElPTWVkaWFCU0RDbGll
bnQsIGlkIDB4MTAwMDAwMWRhLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAo
MCBtcyksIHJldCQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgKy1vIEFwcGxlQVBGU0Nv
bnRhaW5lclNjaGVtZSAgPGNsYXNzIEFwcGxlQVBGU0NvbnRhaW5lclNjaGVtZSwgaWQgMHgxMDAw
MDAxZGIsICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWN0aXZlLCAkCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgKy1vIEFwcGxlQVBGU01lZGlhICA8Y2xhc3MgQXBwbGVBUEZTTWVkaWEs
IGlkIDB4MTAwMDAwMWUyLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoNzAg
bXMpLCByZXRhJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgKy1vIEFwcGxlQVBG
U01lZGlhQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVBUEZTTWVkaWFCU0RDbGllbnQsIGlkIDB4MTAw
MDAwMWUzLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsICQKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAgICstbyBBcHBsZUFQRlNDb250YWluZXIgIDxjbGFzcyBBcHBsZUFQRlND
b250YWluZXIsIGlkIDB4MTAwMDAwMWYzLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1
c3kgMCAoMSAkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICstbyBNYWNpbnRv
c2ggSERAMSAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMmYsIHJlZ2lzdGVy
ZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxIG1zKSwgJAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICB8ICstbyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQgIDxjbGFzcyBB
cHBsZUFQRlNWb2x1bWVCU0RDbGllbnQsIGlkIDB4MTAwMDAwMjM1LCByZWdpc3RlcmVkLCBtYXRj
aGVkLCBhYyQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgfCArLW8gY29tLmFw
cGxlLm9zLnVwZGF0ZS03RTVGNjIxRTcxNzM4NkMwRjZERDVEOTI3RjIzQzJBRkIzNUM0MjM4MUE1
RUE2MUM5OTMyMzI0MjhGMEU2RTU1QDEgIDxjbGFzcyBBcHAkCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAgIHwgICArLW8gSU9NZWRpYUJTRENsaWVudCAgPGNsYXNzIElPTWVkaWFC
U0RDbGllbnQsIGlkIDB4MTAwMDAwMjQzLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1
c3kgMCAoJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8gUHJlYm9vdEAy
ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIzMCwgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaSQKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3MgQXBw
bGVBUEZTVm9sdW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDIzNywgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWMkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICstbyBSZWNvdmVyeUAz
ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIzMSwgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhJAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICB8ICstbyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQgIDxjbGFzcyBBcHBs
ZUFQRlNWb2x1bWVCU0RDbGllbnQsIGlkIDB4MTAwMDAwMjM5LCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhYyQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgKy1vIFVwZGF0ZUA0ICA8
Y2xhc3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIzMiwgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4kCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgICAgIHwgKy1vIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCAgPGNsYXNzIEFwcGxl
QVBGU1ZvbHVtZUJTRENsaWVudCwgaWQgMHgxMDAwMDAyM2IsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8gRGF0YUA1ICA8Y2xh
c3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIzMywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gMSQKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVB
UEZTVm9sdW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDI0MCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWMkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICstbyBWTUA2ICA8Y2xhc3Mg
QXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIzNCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0
aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gMTE+CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICAgKy1vIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCAgPGNsYXNzIEFwcGxlQVBG
U1ZvbHVtZUJTRENsaWVudCwgaWQgMHgxMDAwMDAyM2UsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFj
JAogICAgICAgICAgICAgICAgICAgICAgICAgICAgKy1vIFJlY292ZXJ5T1NDb250YWluZXJAMyAg
PGNsYXNzIElPTWVkaWEsIGlkIDB4MTAwMDAwMWJkLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3Rp
dmUsIGJ1c3kgMCAoNDAgbXMpLCByZXRhaW4gMSQKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKy1vIElPTWVkaWFCU0RDbGllbnQgIDxjbGFzcyBJT01lZGlhQlNEQ2xpZW50LCBpZCAweDEw
MDAwMDFkOCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXQk
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICstbyBBcHBsZUFQRlNDb250YWluZXJTY2hl
bWUgIDxjbGFzcyBBcHBsZUFQRlNDb250YWluZXJTY2hlbWUsIGlkIDB4MTAwMDAwMWQ5LCAhcmVn
aXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgJAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICstbyBBcHBsZUFQRlNNZWRpYSAgPGNsYXNzIEFwcGxlQVBGU01lZGlhLCBpZCAweDEwMDAw
MDFkZCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDM4IG1zKSwgcmV0YSQK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICstbyBBcHBsZUFQRlNNZWRpYUJTRENs
aWVudCAgPGNsYXNzIEFwcGxlQVBGU01lZGlhQlNEQ2xpZW50LCBpZCAweDEwMDAwMDFkZSwgcmVn
aXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCAkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArLW8gQXBwbGVBUEZTQ29udGFpbmVyICA8Y2xhc3MgQXBwbGVBUEZTQ29udGFpbmVyLCBp
ZCAweDEwMDAwMDFmMCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgJAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLW8gUmVjb3ZlcnlAMSAgPGNsYXNz
IEFwcGxlQVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMjksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFj
dGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YSQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVBUEZTVm9s
dW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDIyYiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWMkCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICstbyBVcGRhdGVAMiAgPGNsYXNzIEFw
cGxlQVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMmEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2
ZSwgYnVzeSAwICgwIG1zKSwgcmV0YWluJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICstbyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQgIDxjbGFzcyBBcHBsZUFQRlNWb2x1
bWVCU0RDbGllbnQsIGlkIDB4MTAwMDAwMjJkLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhYyQKCist
byBSb290ICA8Y2xhc3MgSU9SZWdpc3RyeUVudHJ5LCBpZCAweDEwMDAwMDEwMCwgcmV0YWluIDc+
CiAgKy1vIFZNQTJNQUNPU0FQICA8Y2xhc3MgSU9QbGF0Zm9ybUV4cGVydERldmljZSwgaWQgMHgx
MDAwMDAxMzUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg2NjYyIG1zKSwg
cmV0YWluIDI2PgogICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUgIDxjbGFzcyBBcHBs
ZVZpcnR1YWxQbGF0Zm9ybUFSTVBFLCBpZCAweDEwMDAwMDEzOSwgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDMxMSBtcyksIHJldGFpbiAyMSQKICAgICAgKy1vIGFybS1pbyAg
PGNsYXNzIElPUGxhdGZvcm1EZXZpY2UsIGlkIDB4MTAwMDAwMTE1LCByZWdpc3RlcmVkLCBtYXRj
aGVkLCBhY3RpdmUsIGJ1c3kgMCAoMzEwIG1zKSwgcmV0YWluIDE1PgogICAgICAgICstbyBBcHBs
ZVZpcnR1YWxQbGF0Zm9ybUlPICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTywgaWQgMHgx
MDAwMDAxNjEsICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDMwNyBtcyks
IHJldGFpbiAxMiQKICAgICAgICAgICstbyBwY2llQDMwMDAwMDAwICA8Y2xhc3MgQXBwbGVBUk1J
T0RldmljZSwgaWQgMHgxMDAwMDAxMWEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVz
eSAwICgyNTMgbXMpLCByZXRhaW4gMTc+CiAgICAgICAgICAgICstbyBBcHBsZVZpcnR1YWxQbGF0
Zm9ybVBDSUUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUsIGlkIDB4MTAwMDAwMTZl
LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjUwIG1zKSwgcmV0JAogICAg
ICAgICAgICAgICstbyBwY2kxMDZiLDFhMDBANyAgPGNsYXNzIElPUENJRGV2aWNlLCBpZCAweDEw
MDAwMDE3NCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDcgbXMpLCByZXRh
aW4gMTA+CiAgICAgICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9QQ0lUcmFuc3BvcnQgIDxjbGFz
cyBBcHBsZVZpcnRJT1BDSVRyYW5zcG9ydCwgaWQgMHgxMDAwMDAxODgsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgzIG1zKSwgcmV0JAogICAgICAgICAgICAgICAgICB8IHsK
ICAgICAgICAgICAgICAgICAgfCAgICJJT1BDSVByaW1hcnlNYXRjaCIgPSAiMHgxYTAwMTA2YiYw
eEZGRkZGRkZGIgogICAgICAgICAgICAgICAgICB8ICAgIkNGQnVuZGxlSWRlbnRpZmllciIgPSAi
Y29tLmFwcGxlLmRyaXZlci5BcHBsZVZpcnRJTyIKICAgICAgICAgICAgICAgICAgfCAgICJJT1By
b3ZpZGVyQ2xhc3MiID0gIklPUENJRGV2aWNlIgogICAgICAgICAgICAgICAgICB8ICAgIklPQ2xh
c3MiID0gIkFwcGxlVmlydElPUENJVHJhbnNwb3J0IgogICAgICAgICAgICAgICAgICB8ICAgIklP
UGVyc29uYWxpdHlQdWJsaXNoZXIiID0gImNvbS5hcHBsZS5pb2tpdC5BcHBsZVZpcnRJT1N0b3Jh
Z2UiCiAgICAgICAgICAgICAgICAgIHwgICAiQ0ZCdW5kbGVJZGVudGlmaWVyS2VybmVsIiA9ICJj
b20uYXBwbGUuZHJpdmVyLkFwcGxlVmlydElPIgogICAgICAgICAgICAgICAgICB8ICAgIklPUHJv
YmVTY29yZSIgPSAxMDAwMAogICAgICAgICAgICAgICAgICB8ICAgIklPTWF0Y2hlZEF0Qm9vdCIg
PSBZZXMKICAgICAgICAgICAgICAgICAgfCAgICJJT01hdGNoQ2F0ZWdvcnkiID0gIklPRGVmYXVs
dE1hdGNoQ2F0ZWdvcnkiCiAgICAgICAgICAgICAgICAgIHwgICAiYnVpbHQtaW4iID0gPDAwPgog
ICAgICAgICAgICAgICAgICB8IH0KICAgICAgICAgICAgICAgICAgfCAKICAgICAgICAgICAgICAg
ICAgKy1vIEFwcGxlVmlydElPU3RvcmFnZURldmljZSAgPGNsYXNzIEFwcGxlVmlydElPU3RvcmFn
ZURldmljZSwgaWQgMHgxMDAwMDAxOTIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVz
eSAwICgwIG1zKSwkCiAgICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVmlydElPVXRpbFN0b3Jh
Z2VEZXZpY2UgIDxjbGFzcyBBcHBsZVZpcnRJT1V0aWxTdG9yYWdlRGV2aWNlLCBpZCAweDEwMDAw
MDE5NywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5JAogICAgICAgICAgICAgICAg
ICAgICAgKy1vIEFwcGxlRW1iZWRkZWRTaW1wbGVTUElOT1JGbGFzaGVyRHJpdmVyICA8Y2xhc3Mg
QXBwbGVFbWJlZGRlZFNpbXBsZVNQSU5PUkZsYXNoZXJEcml2ZXIsIGlkIDB4MTAwMDAwMTk4LCBy
ZWdpc3RlcmVkLCQKICAgICAgICAgICAgICAgICAgICAgICstbyBBcHBsZVZpcnRJT05WUkFNICA8
Y2xhc3MgQXBwbGVWaXJ0SU9OVlJBTSwgaWQgMHgxMDAwMDAxOTksIHJlZ2lzdGVyZWQsIG1hdGNo
ZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YWluIDU+CiAgICAgICAgICAgICAgICAgICAg
ICArLW8gQXBwbGVOVk1lTmFtZXNwYWNlRGV2aWNlICA8Y2xhc3MgQXBwbGVOVk1lTmFtZXNwYWNl
RGV2aWNlLCBpZCAweDEwMDAwMDFhNCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5
IDAgKDAgJAogICAgICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlTlZNZUVBTiAgPGNsYXNzIEFw
cGxlTlZNZUVBTiwgaWQgMHgxMDAwMDAxYTUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgwIG1zKSwgcmV0YWluIDY+CgorLW8gUm9vdCAgPGNsYXNzIElPUmVnaXN0cnlFbnRy
eSwgaWQgMHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAgPGNsYXNzIElP
UGxhdGZvcm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM1LCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhY3RpdmUsIGJ1c3kgMCAoNjY2MiBtcyksIHJldGFpbiAyNj4KICAgICstbyBBcHBsZVZpcnR1
YWxQbGF0Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSwgaWQgMHgx
MDAwMDAxMzksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgzMTEgbXMpLCBy
ZXRhaW4gMjEkCiAgICAgICstbyBhcm0taW8gIDxjbGFzcyBJT1BsYXRmb3JtRGV2aWNlLCBpZCAw
eDEwMDAwMDExNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDMxMCBtcyks
IHJldGFpbiAxNT4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTyAgPGNsYXNzIEFw
cGxlVmlydHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTYxLCAhcmVnaXN0ZXJlZCwgIW1hdGNo
ZWQsIGFjdGl2ZSwgYnVzeSAwICgzMDcgbXMpLCByZXRhaW4gMTIkCiAgICAgICAgICArLW8gcGNp
ZUAzMDAwMDAwMCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlkIDB4MTAwMDAwMTFhLCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjUzIG1zKSwgcmV0YWluIDE3PgogICAg
ICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFICA8Y2xhc3MgQXBwbGVWaXJ0dWFs
UGxhdGZvcm1QQ0lFLCBpZCAweDEwMDAwMDE2ZSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZl
LCBidXN5IDAgKDI1MCBtcyksIHJldCQKICAgICAgICAgICAgICArLW8gcGNpMWFmNCwxMDQ0QDgg
IDxjbGFzcyBJT1BDSURldmljZSwgaWQgMHgxMDAwMDAxNzUsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICg2IG1zKSwgcmV0YWluIDk+CiAgICAgICAgICAgICAgICArLW8gQXBw
bGVWaXJ0SU9QQ0lUcmFuc3BvcnQgIDxjbGFzcyBBcHBsZVZpcnRJT1BDSVRyYW5zcG9ydCwgaWQg
MHgxMDAwMDAxODksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyIG1zKSwg
cmV0JAogICAgICAgICAgICAgICAgICB8IHsKICAgICAgICAgICAgICAgICAgfCAgICJJT1BDSVBy
aW1hcnlNYXRjaCIgPSAiMHgwMDAwMWFmNCYweDAwMDBGRkZGIgogICAgICAgICAgICAgICAgICB8
ICAgIkNGQnVuZGxlSWRlbnRpZmllciIgPSAiY29tLmFwcGxlLmRyaXZlci5BcHBsZVZpcnRJTyIK
ICAgICAgICAgICAgICAgICAgfCAgICJJT1Byb3ZpZGVyQ2xhc3MiID0gIklPUENJRGV2aWNlIgog
ICAgICAgICAgICAgICAgICB8ICAgIklPQ2xhc3MiID0gIkFwcGxlVmlydElPUENJVHJhbnNwb3J0
IgogICAgICAgICAgICAgICAgICB8ICAgIklPUGVyc29uYWxpdHlQdWJsaXNoZXIiID0gImNvbS5h
cHBsZS5kcml2ZXIuQXBwbGVWaXJ0SU8iCiAgICAgICAgICAgICAgICAgIHwgICAiQ0ZCdW5kbGVJ
ZGVudGlmaWVyS2VybmVsIiA9ICJjb20uYXBwbGUuZHJpdmVyLkFwcGxlVmlydElPIgogICAgICAg
ICAgICAgICAgICB8ICAgIklPUHJvYmVTY29yZSIgPSAxMDAwMAogICAgICAgICAgICAgICAgICB8
ICAgIklPTWF0Y2hlZEF0Qm9vdCIgPSBZZXMKICAgICAgICAgICAgICAgICAgfCAgICJJT01hdGNo
Q2F0ZWdvcnkiID0gIklPRGVmYXVsdE1hdGNoQ2F0ZWdvcnkiCiAgICAgICAgICAgICAgICAgIHwg
ICAiYnVpbHQtaW4iID0gPDAwPgogICAgICAgICAgICAgICAgICB8IH0KICAgICAgICAgICAgICAg
ICAgfCAKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVmlydElPRW50cm9weSAgPGNsYXNzIEFw
cGxlVmlydElPRW50cm9weSwgaWQgMHgxMDAwMDAxOTYsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFj
dGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YWluIDY+CgorLW8gUm9vdCAgPGNsYXNzIElPUmVnaXN0
cnlFbnRyeSwgaWQgMHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAgPGNs
YXNzIElPUGxhdGZvcm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM1LCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoNjY2MiBtcyksIHJldGFpbiAyNj4KICAgICstbyBBcHBs
ZVZpcnR1YWxQbGF0Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSwg
aWQgMHgxMDAwMDAxMzksIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgzMTEg
bXMpLCByZXRhaW4gMjEkCiAgICAgICstbyBhcm0taW8gIDxjbGFzcyBJT1BsYXRmb3JtRGV2aWNl
LCBpZCAweDEwMDAwMDExNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDMx
MCBtcyksIHJldGFpbiAxNT4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTyAgPGNs
YXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTYxLCAhcmVnaXN0ZXJlZCwg
IW1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgzMDcgbXMpLCByZXRhaW4gMTIkCiAgICAgICAgICAr
LW8gcGNpZUAzMDAwMDAwMCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlkIDB4MTAwMDAwMTFh
LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjUzIG1zKSwgcmV0YWluIDE3
PgogICAgICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFICA8Y2xhc3MgQXBwbGVW
aXJ0dWFsUGxhdGZvcm1QQ0lFLCBpZCAweDEwMDAwMDE2ZSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDI1MCBtcyksIHJldCQKICAgICAgICAgICAgICArLW8gcGNpMTA2Yiwx
YTAxQEEgIDxjbGFzcyBJT1BDSURldmljZSwgaWQgMHgxMDAwMDAxNzcsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxNCBtcyksIHJldGFpbiA5PgogICAgICAgICAgICAgICAg
Ky1vIEFwcGxlVmlydElPUENJVHJhbnNwb3J0ICA8Y2xhc3MgQXBwbGVWaXJ0SU9QQ0lUcmFuc3Bv
cnQsIGlkIDB4MTAwMDAwMThiLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAo
OSBtcyksIHJldCQKICAgICAgICAgICAgICAgICAgfCB7CiAgICAgICAgICAgICAgICAgIHwgICAi
SU9QQ0lQcmltYXJ5TWF0Y2giID0gIjB4MWEwMTEwNmIiCiAgICAgICAgICAgICAgICAgIHwgICAi
Q0ZCdW5kbGVJZGVudGlmaWVyIiA9ICJjb20uYXBwbGUuZHJpdmVyLkFwcGxlVmlydElPIgogICAg
ICAgICAgICAgICAgICB8ICAgIklPUHJvdmlkZXJDbGFzcyIgPSAiSU9QQ0lEZXZpY2UiCiAgICAg
ICAgICAgICAgICAgIHwgICAiSU9DbGFzcyIgPSAiQXBwbGVWaXJ0SU9QQ0lUcmFuc3BvcnQiCiAg
ICAgICAgICAgICAgICAgIHwgICAiSU9QZXJzb25hbGl0eVB1Ymxpc2hlciIgPSAiY29tLmFwcGxl
LmRyaXZlci5BcHBsZVZpcnR1YWxQbGF0Zm9ybSIKICAgICAgICAgICAgICAgICAgfCAgICJDRkJ1
bmRsZUlkZW50aWZpZXJLZXJuZWwiID0gImNvbS5hcHBsZS5kcml2ZXIuQXBwbGVWaXJ0SU8iCiAg
ICAgICAgICAgICAgICAgIHwgICAiSU9Qcm9iZVNjb3JlIiA9IDEwMDAwCiAgICAgICAgICAgICAg
ICAgIHwgICAiSU9NYXRjaGVkQXRCb290IiA9IFllcwogICAgICAgICAgICAgICAgICB8ICAgIklP
TWF0Y2hDYXRlZ29yeSIgPSAiSU9EZWZhdWx0TWF0Y2hDYXRlZ29yeSIKICAgICAgICAgICAgICAg
ICAgfCAgICJidWlsdC1pbiIgPSA8MDA+CiAgICAgICAgICAgICAgICAgIHwgfQogICAgICAgICAg
ICAgICAgICB8IAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9VU0JDb25maWd1cmF0
aW9uICA8Y2xhc3MgQXBwbGVWaXJ0SU9VU0JDb25maWd1cmF0aW9uLCBpZCAweDEwMDAwMDE5YSwg
cmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKCQKICAgICAgICAgICAgICAgICAg
ICArLW8gQXBwbGVWaXJ0SU9VU0JEZXZpY2VDb250cm9sbGVyQDAgIDxjbGFzcyBBcHBsZVZpcnRJ
T1VTQkRldmljZUNvbnRyb2xsZXIsIGlkIDB4MTAwMDAwMWE2LCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhY3RpdmUkCiAgICAgICAgICAgICAgICAgICAgICArLW8gSU9VU0JEZXZpY2VDb25maWd1cmF0
b3IgIDxjbGFzcyBJT1VTQkRldmljZUNvbmZpZ3VyYXRvciwgaWQgMHgxMDAwMDAxYTgsICFyZWdp
c3RlcmVkLCAhbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAsIHJlJAogICAgICAgICAgICAgICAgICAg
ICAgKy1vIEFwcGxlVVNCTkNNQ29udHJvbEAwICA8Y2xhc3MgSU9VU0JEZXZpY2VJbnRlcmZhY2Us
IGlkIDB4MTAwMDAwMWE5LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBt
cyksIHJldCQKICAgICAgICAgICAgICAgICAgICAgIHwgKy1vIEFwcGxlVVNCRGV2aWNlTkNNQ29u
dHJvbEAwICA8Y2xhc3MgQXBwbGVVU0JEZXZpY2VOQ01Db250cm9sLCBpZCAweDEwMDAwMDFhZSwg
cmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAkCiAgICAgICAgICAgICAgICAgICAg
ICArLW8gQXBwbGVVU0JOQ01EYXRhQDEgIDxjbGFzcyBJT1VTQkRldmljZUludGVyZmFjZSwgaWQg
MHgxMDAwMDAxYWEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg3IG1zKSwg
cmV0YWluJAogICAgICAgICAgICAgICAgICAgICAgfCArLW8gQXBwbGVVU0JEZXZpY2VOQ01EYXRh
ICA8Y2xhc3MgQXBwbGVVU0JEZXZpY2VOQ01EYXRhLCBpZCAweDEwMDAwMDFiMSwgcmVnaXN0ZXJl
ZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCQKICAgICAgICAgICAgICAgICAgICAg
IHwgICArLW8gZW4xICA8Y2xhc3MgSU9FdGhlcm5ldEludGVyZmFjZSwgaWQgMHgxMDAwMDAxZjks
IHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YWluIDExPgog
ICAgICAgICAgICAgICAgICAgICAgfCAgICAgKy1vIElPTmV0d29ya1N0YWNrICA8Y2xhc3MgSU9O
ZXR3b3JrU3RhY2ssIGlkIDB4MTAwMDAwMWNiLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUs
IGJ1c3kgMCAoMCBtcyksIHJldGFpbiAxMiQKICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
Ky1vIElPTmV0d29ya1N0YWNrVXNlckNsaWVudCAgPGNsYXNzIElPTmV0d29ya1N0YWNrVXNlckNs
aWVudCwgaWQgMHgxMDAwMDAyOTYsICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWN0aXZlLCAkCiAg
ICAgICAgICAgICAgICAgICAgICArLW8gQXBwbGVVU0JOQ01Db250cm9sQXV4QDIgIDxjbGFzcyBJ
T1VTQkRldmljZUludGVyZmFjZSwgaWQgMHgxMDAwMDAxYWIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgJAogICAgICAgICAgICAgICAgICAgICAgfCArLW8gQXBw
bGVVU0JEZXZpY2VOQ01Db250cm9sQDIgIDxjbGFzcyBBcHBsZVVTQkRldmljZU5DTUNvbnRyb2ws
IGlkIDB4MTAwMDAwMWIzLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCQKICAg
ICAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQk5DTURhdGFBdXhAMyAgPGNsYXNzIElPVVNC
RGV2aWNlSW50ZXJmYWNlLCBpZCAweDEwMDAwMDFhYywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0
aXZlLCBidXN5IDAgKDggbXMpLCByZXQkCiAgICAgICAgICAgICAgICAgICAgICAgICstbyBBcHBs
ZVVTQkRldmljZU5DTURhdGEgIDxjbGFzcyBBcHBsZVVTQkRldmljZU5DTURhdGEsIGlkIDB4MTAw
MDAwMWI1LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksJAogICAg
ICAgICAgICAgICAgICAgICAgICAgICstbyBhbnBpMCAgPGNsYXNzIEFwcGxlVVNCRGV2aWNlTkNN
UHJpdmF0ZUV0aGVybmV0SW50ZXJmYWNlLCBpZCAweDEwMDAwMDFmYiwgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKCQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICstbyBJ
T05ldHdvcmtTdGFjayAgPGNsYXNzIElPTmV0d29ya1N0YWNrLCBpZCAweDEwMDAwMDFjYiwgcmVn
aXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gMTIkCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICstbyBJT05ldHdvcmtTdGFja1VzZXJDbGllbnQgIDxj
bGFzcyBJT05ldHdvcmtTdGFja1VzZXJDbGllbnQsIGlkIDB4MTAwMDAwMjk2LCAhcmVnaXN0ZXJl
ZCwgIW1hdGNoZWQsIGFjdGl2ZSwgJAoK
--000000000000b077ca0626a38ca0
Content-Type: text/plain; charset="US-ASCII"; name="vmapple-qemu-ioreg.txt"
Content-Disposition: attachment; filename="vmapple-qemu-ioreg.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m3d3edlo1>
X-Attachment-Id: f_m3d3edlo1

JSBpb3JlZyAtdHJjIElPUENJRGV2aWNlICAgICAgICAgIAorLW8gUm9vdCAgPGNsYXNzIElPUmVn
aXN0cnlFbnRyeSwgaWQgMHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAg
PGNsYXNzIElPUGxhdGZvcm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM4LCByZWdpc3RlcmVk
LCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMzA3NjYgbXMpLCByZXRhaW4gMjY+CiAgICArLW8g
QXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJN
UEUsIGlkIDB4MTAwMDAwMTNjLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAo
MjQ0NTQgbXMpLCByZXRhaW4gJAogICAgICArLW8gYXJtLWlvICA8Y2xhc3MgSU9QbGF0Zm9ybURl
dmljZSwgaWQgMHgxMDAwMDAxMTcsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAw
ICgyNDQ1MiBtcyksIHJldGFpbiAxNj4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1J
TyAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTY2LCAhcmVnaXN0
ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyNDQ0OSBtcyksIHJldGFpbiAkCiAgICAg
ICAgICArLW8gcGNpZUAzMDAwMDAwMCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlkIDB4MTAw
MDAwMTFkLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0MzMgbXMpLCBy
ZXRhaW4gMTM+CiAgICAgICAgICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUgIDxjbGFz
cyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUsIGlkIDB4MTAwMDAwMTdiLCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0MzIgbXMpLCByJAogICAgICAgICAgICAgICstbyBw
Y2kxYjM2LDhAMCAgPGNsYXNzIElPUENJRGV2aWNlLCBpZCAweDEwMDAwMDE3ZCwgcmVnaXN0ZXJl
ZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDIgbXMpLCByZXRhaW4gOD4KICAgICAgICAgICAg
ICAgICAgewogICAgICAgICAgICAgICAgICAgICJzdWJzeXN0ZW0tdmVuZG9yLWlkIiA9IDxmNDFh
MDAwMD4KICAgICAgICAgICAgICAgICAgICAiY29tcGF0aWJsZSIgPSA8InBjaTFhZjQsMTEwMCIs
InBjaTFiMzYsOCIsInBjaWNsYXNzLDA2MDAwMCI+CiAgICAgICAgICAgICAgICAgICAgIklPTmFt
ZSIgPSAicGNpMWIzNiw4IgogICAgICAgICAgICAgICAgICAgICJyZWciID0gPDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA+CiAgICAgICAgICAgICAgICAgICAgImRldmlj
ZS1pZCIgPSA8MDgwMDAwMDA+CiAgICAgICAgICAgICAgICAgICAgIklPU2VydmljZURFWFRFbnRp
dGxlbWVudHMiID0gKCgiY29tLmFwcGxlLmRldmVsb3Blci5kcml2ZXJraXQudHJhbnNwb3J0LnBj
aSIpKQogICAgICAgICAgICAgICAgICAgICJJT1Bvd2VyTWFuYWdlbWVudCIgPSB7IkN1cnJlbnRQ
b3dlclN0YXRlIj0yLCJDYXBhYmlsaXR5RmxhZ3MiPTI1OCwiQ2hpbGRQcm94eVBvd2VyU3RhdGUi
PTIsIk1heFBvd2VyU3RhdGUiPTN9CiAgICAgICAgICAgICAgICAgICAgIklPUENJUmVzb3VyY2Vk
IiA9IFllcwogICAgICAgICAgICAgICAgICAgICJyZXZpc2lvbi1pZCIgPSA8MDAwMDAwMDA+CiAg
ICAgICAgICAgICAgICAgICAgInZlbmRvci1pZCIgPSA8MzYxYjAwMDA+CiAgICAgICAgICAgICAg
ICAgICAgInBjaWRlYnVnIiA9ICIwOjA6MCIKICAgICAgICAgICAgICAgICAgICAiY2xhc3MtY29k
ZSIgPSA8MDAwMDA2MDA+CiAgICAgICAgICAgICAgICAgICAgInN1YnN5c3RlbS1pZCIgPSA8MDAx
MTAwMDA+CiAgICAgICAgICAgICAgICAgICAgIm5hbWUiID0gPCJwY2kxYjM2LDgiPgogICAgICAg
ICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgIAoKKy1vIFJvb3QgIDxjbGFzcyBJT1JlZ2lz
dHJ5RW50cnksIGlkIDB4MTAwMDAwMTAwLCByZXRhaW4gNz4KICArLW8gVk1BMk1BQ09TQVAgIDxj
bGFzcyBJT1BsYXRmb3JtRXhwZXJ0RGV2aWNlLCBpZCAweDEwMDAwMDEzOCwgcmVnaXN0ZXJlZCwg
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDMwNzY2IG1zKSwgcmV0YWluIDI2PgogICAgKy1vIEFw
cGxlVmlydHVhbFBsYXRmb3JtQVJNUEUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUFSTVBF
LCBpZCAweDEwMDAwMDEzYywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI0
NDU0IG1zKSwgcmV0YWluICQKICAgICAgKy1vIGFybS1pbyAgPGNsYXNzIElPUGxhdGZvcm1EZXZp
Y2UsIGlkIDB4MTAwMDAwMTE3LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAo
MjQ0NTIgbXMpLCByZXRhaW4gMTY+CiAgICAgICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtSU8g
IDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUlPLCBpZCAweDEwMDAwMDE2NiwgIXJlZ2lzdGVy
ZWQsICFtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0NDkgbXMpLCByZXRhaW4gJAogICAgICAg
ICAgKy1vIHBjaWVAMzAwMDAwMDAgIDxjbGFzcyBBcHBsZUFSTUlPRGV2aWNlLCBpZCAweDEwMDAw
MDExZCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI0NDMzIG1zKSwgcmV0
YWluIDEzPgogICAgICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFICA8Y2xhc3Mg
QXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFLCBpZCAweDEwMDAwMDE3YiwgcmVnaXN0ZXJlZCwgbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI0NDMyIG1zKSwgciQKICAgICAgICAgICAgICArLW8gcGNp
MWIzNixkQDEgIDxjbGFzcyBJT1BDSURldmljZSwgaWQgMHgxMDAwMDAxN2UsIHJlZ2lzdGVyZWQs
IG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyNDQxOSBtcyksIHJldGFpbiAxMj4KICAgICAgICAg
ICAgICAgIHwgewogICAgICAgICAgICAgICAgfCAgICJhc3NpZ25lZC1hZGRyZXNzZXMiID0gPDEw
MDgwMDgyMDBjMDAwNTAwMDAwMDAwMDAwNDAwMDAwMDAwMDAwMDA+CiAgICAgICAgICAgICAgICB8
ICAgIklPSW50ZXJydXB0U3BlY2lmaWVycyIgPSAoPDQxMDAwMDAwMDEwMDAwMDA+KQogICAgICAg
ICAgICAgICAgfCAgICJjbGFzcy1jb2RlIiA9IDwzMDAzMGMwMD4KICAgICAgICAgICAgICAgIHwg
ICAiSU9EZXZpY2VNZW1vcnkiID0gKCh7ImFkZHJlc3MiPTEzNDIyMjY0MzIsImxlbmd0aCI9MTYz
ODR9KSkKICAgICAgICAgICAgICAgIHwgICAiSU9SZXBvcnRMZWdlbmRQdWJsaWMiID0gWWVzCiAg
ICAgICAgICAgICAgICB8ICAgIklPUG93ZXJNYW5hZ2VtZW50IiA9IHsiQ2hpbGRyZW5Qb3dlclN0
YXRlIj0yLCJDdXJyZW50UG93ZXJTdGF0ZSI9MiwiQ2FwYWJpbGl0eUZsYWdzIj0yNTgsIkNoaWxk
UHJveHlQb3dlclN0YXRlIj0yLCJNYXhQJAogICAgICAgICAgICAgICAgfCAgICJzdWJzeXN0ZW0t
dmVuZG9yLWlkIiA9IDxmNDFhMDAwMD4KICAgICAgICAgICAgICAgIHwgICAicGNpLWFzcG0tZGVm
YXVsdCIgPSAxCiAgICAgICAgICAgICAgICB8ICAgIklPSW50ZXJydXB0Q29udHJvbGxlcnMiID0g
KCJJT0ludGVycnVwdENvbnRyb2xsZXIwMDAwMDAzNyIpCiAgICAgICAgICAgICAgICB8ICAgInZl
bmRvci1pZCIgPSA8MzYxYjAwMDA+CiAgICAgICAgICAgICAgICB8ICAgIm5hbWUiID0gPCJwY2kx
YjM2LGQiPgogICAgICAgICAgICAgICAgfCAgICJkZXZpY2UtaWQiID0gPDBkMDAwMDAwPgogICAg
ICAgICAgICAgICAgfCAgICJJT1BDSVJlc291cmNlZCIgPSBZZXMKICAgICAgICAgICAgICAgIHwg
ICAiY29tcGF0aWJsZSIgPSA8InBjaTFhZjQsMTEwMCIsInBjaTFiMzYsZCIsInBjaWNsYXNzLDBj
MDMzMCI+CiAgICAgICAgICAgICAgICB8ICAgIklPU2VydmljZURFWFRFbnRpdGxlbWVudHMiID0g
KCgiY29tLmFwcGxlLmRldmVsb3Blci5kcml2ZXJraXQudHJhbnNwb3J0LnBjaSIpKQogICAgICAg
ICAgICAgICAgfCAgICJJT1BDSUV4cHJlc3NMaW5rQ2FwYWJpbGl0aWVzIiA9IDEwNDEKICAgICAg
ICAgICAgICAgIHwgICAic3Vic3lzdGVtLWlkIiA9IDwwMDExMDAwMD4KICAgICAgICAgICAgICAg
IHwgICAicmV2aXNpb24taWQiID0gPDAxMDAwMDAwPgogICAgICAgICAgICAgICAgfCAgICJJT1BD
SUV4cHJlc3NMaW5rU3RhdHVzIiA9IDE3CiAgICAgICAgICAgICAgICB8ICAgIklPUENJRXhwcmVz
c0NhcGFiaWxpdGllcyIgPSAxNDYKICAgICAgICAgICAgICAgIHwgICAicGNpZGVidWciID0gIjA6
MTowIgogICAgICAgICAgICAgICAgfCAgICJJT05hbWUiID0gInBjaTFiMzYsZCIKICAgICAgICAg
ICAgICAgIHwgICAiSU9SZXBvcnRMZWdlbmQiID0gKHsiSU9SZXBvcnRHcm91cE5hbWUiPSJJbnRl
cnJ1cHQgU3RhdGlzdGljcyAoYnkgaW5kZXgpIiwiSU9SZXBvcnRDaGFubmVscyI9KCg1MjkxMjk0
NjQ1MTgyMDA1MjQ4LDQyOTUkCiAgICAgICAgICAgICAgICB8ICAgInJlZyIgPSA8MDAwODAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDEwMDgwMDAyMDAwMDAwMDAwMDAwMDAwMDAw
NDAwMDAwMDAwMDAwMDA+CiAgICAgICAgICAgICAgICB8IH0KICAgICAgICAgICAgICAgIHwgCiAg
ICAgICAgICAgICAgICArLW8gQXBwbGVVU0JYSENJUENJQDAxMDAwMDAwICA8Y2xhc3MgQXBwbGVV
U0JYSENJUENJLCBpZCAweDEwMDAwMDE4YSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBi
dXN5IDAgKDI0NDA2IG1zKSwgcmV0YWluJAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVVU0Iy
MFhIQ0lQb3J0QDAxNTAwMDAwICA8Y2xhc3MgQXBwbGVVU0IyMFhIQ0lQb3J0LCBpZCAweDEwMDAw
MDFiYywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDIwNDg1IG1zKSQKICAg
ICAgICAgICAgICAgICAgfCArLW8gUUVNVSBVU0IgS2V5Ym9hcmRAMDE1MDAwMDAgIDxjbGFzcyBJ
T1VTQkhvc3REZXZpY2UsIGlkIDB4MTAwMDAwMjgwLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3Rp
dmUsIGJ1c3kgMCAoMjA0ODUgbXMpLCAkCiAgICAgICAgICAgICAgICAgIHwgICArLW8gQXBwbGVV
U0JIb3N0Q29tcG9zaXRlRGV2aWNlICA8Y2xhc3MgQXBwbGVVU0JIb3N0Q29tcG9zaXRlRGV2aWNl
LCBpZCAweDEwMDAwMDJkZSwgIXJlZ2lzdGVyZWQsICFtYXRjaGVkLCBhY3RpdmUsIGJ1JAogICAg
ICAgICAgICAgICAgICB8ICAgKy1vIElPVVNCSG9zdEludGVyZmFjZUAwICA8Y2xhc3MgSU9VU0JI
b3N0SW50ZXJmYWNlLCBpZCAweDEwMDAwMDJlOCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZl
LCBidXN5IDAgKDE0MzU1IG1zKSwgciQKICAgICAgICAgICAgICAgICAgfCAgICAgKy1vIEFwcGxl
VXNlclVTQkhvc3RISUREZXZpY2UgIDxjbGFzcyBBcHBsZVVzZXJISUREZXZpY2UsIGlkIDB4MTAw
MDAwMmU5LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTAyNDAkCiAgICAg
ICAgICAgICAgICAgIHwgICAgICAgKy1vIElPSElESW50ZXJmYWNlICA8Y2xhc3MgSU9ISURJbnRl
cmZhY2UsIGlkIDB4MTAwMDAwMmVmLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kg
MCAoMTAyNDAgbXMpLCByZXRhaW4gJAogICAgICAgICAgICAgICAgICB8ICAgICAgICAgKy1vIEFw
cGxlVXNlckhJREV2ZW50RHJpdmVyICA8Y2xhc3MgQXBwbGVVc2VySElERXZlbnRTZXJ2aWNlLCBp
ZCAweDEwMDAwMDJmMCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5ICQKICAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgKy1vIElPSElERXZlbnRTZXJ2aWNlVXNlckNsaWVudCAg
PGNsYXNzIElPSElERXZlbnRTZXJ2aWNlVXNlckNsaWVudCwgaWQgMHgxMDAwMDAyZjUsICFyZWdp
c3RlcmVkLCAhbWF0Y2hlZCwgYWMkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQjIwWEhD
SVBvcnRAMDE2MDAwMDAgIDxjbGFzcyBBcHBsZVVTQjIwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMWJk
LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMzkyMCBtcyksJAogICAgICAg
ICAgICAgICAgICB8ICstbyBRRU1VIFVTQiBUYWJsZXRAMDE2MDAwMDAgIDxjbGFzcyBJT1VTQkhv
c3REZXZpY2UsIGlkIDB4MTAwMDAwMjRjLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1
c3kgMCAoMzkyMCBtcyksIHJldCQKICAgICAgICAgICAgICAgICAgfCAgICstbyBBcHBsZVVTQkhv
c3RDb21wb3NpdGVEZXZpY2UgIDxjbGFzcyBBcHBsZVVTQkhvc3RDb21wb3NpdGVEZXZpY2UsIGlk
IDB4MTAwMDAwMjdmLCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnUkCiAgICAgICAg
ICAgICAgICAgIHwgICArLW8gSU9VU0JIb3N0SW50ZXJmYWNlQDAgIDxjbGFzcyBJT1VTQkhvc3RJ
bnRlcmZhY2UsIGlkIDB4MTAwMDAwMjhhLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1
c3kgMCAoMjA1MCBtcyksIHJlJAogICAgICAgICAgICAgICAgICB8ICAgICArLW8gQXBwbGVVc2Vy
VVNCSG9zdEhJRERldmljZSAgPGNsYXNzIEFwcGxlVXNlckhJRERldmljZSwgaWQgMHgxMDAwMDAy
OGIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyIG1zKSQKICAgICAgICAg
ICAgICAgICAgfCAgICAgICArLW8gSU9ISURJbnRlcmZhY2UgIDxjbGFzcyBJT0hJREludGVyZmFj
ZSwgaWQgMHgxMDAwMDAyYTIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgy
IG1zKSwgcmV0YWluIDEwPgogICAgICAgICAgICAgICAgICB8ICAgICAgICAgKy1vIEFwcGxlVXNl
ckhJREV2ZW50RHJpdmVyICA8Y2xhc3MgQXBwbGVVc2VySElERXZlbnRTZXJ2aWNlLCBpZCAweDEw
MDAwMDJhMywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5ICQKICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgKy1vIElPSElERXZlbnRTZXJ2aWNlVXNlckNsaWVudCAgPGNsYXNz
IElPSElERXZlbnRTZXJ2aWNlVXNlckNsaWVudCwgaWQgMHgxMDAwMDAyYTcsICFyZWdpc3RlcmVk
LCAhbWF0Y2hlZCwgYWMkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQjIwWEhDSVBvcnRA
MDE3MDAwMDAgIDxjbGFzcyBBcHBsZVVTQjIwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMWJlLCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJlJAogICAgICAgICAgICAg
ICAgICArLW8gQXBwbGVVU0IyMFhIQ0lQb3J0QDAxODAwMDAwICA8Y2xhc3MgQXBwbGVVU0IyMFhI
Q0lQb3J0LCBpZCAweDEwMDAwMDFiZiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5
IDAgKDAgbXMpLCByZSQKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNCMzBYSENJUG9ydEAw
MTEwMDAwMCAgPGNsYXNzIEFwcGxlVVNCMzBYSENJUG9ydCwgaWQgMHgxMDAwMDAxYzAsIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAgICAgICAg
ICAgICstbyBBcHBsZVVTQjMwWEhDSVBvcnRAMDEyMDAwMDAgIDxjbGFzcyBBcHBsZVVTQjMwWEhD
SVBvcnQsIGlkIDB4MTAwMDAwMWMxLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kg
MCAoMCBtcyksIHJlJAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVVU0IzMFhIQ0lQb3J0QDAx
MzAwMDAwICA8Y2xhc3MgQXBwbGVVU0IzMFhIQ0lQb3J0LCBpZCAweDEwMDAwMDFjMiwgcmVnaXN0
ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZSQKICAgICAgICAgICAgICAg
ICAgKy1vIEFwcGxlVVNCMzBYSENJUG9ydEAwMTQwMDAwMCAgPGNsYXNzIEFwcGxlVVNCMzBYSENJ
UG9ydCwgaWQgMHgxMDAwMDAxYzMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAw
ICgwIG1zKSwgcmUkCgorLW8gUm9vdCAgPGNsYXNzIElPUmVnaXN0cnlFbnRyeSwgaWQgMHgxMDAw
MDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAgPGNsYXNzIElPUGxhdGZvcm1FeHBl
cnREZXZpY2UsIGlkIDB4MTAwMDAwMTM4LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1
c3kgMCAoMzA3NjYgbXMpLCByZXRhaW4gMjY+CiAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1B
Uk1QRSAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUsIGlkIDB4MTAwMDAwMTNjLCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0NTQgbXMpLCByZXRhaW4gJAog
ICAgICArLW8gYXJtLWlvICA8Y2xhc3MgSU9QbGF0Zm9ybURldmljZSwgaWQgMHgxMDAwMDAxMTcs
IHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyNDQ1MiBtcyksIHJldGFpbiAx
Nj4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTyAgPGNsYXNzIEFwcGxlVmlydHVh
bFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTY2LCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2
ZSwgYnVzeSAwICgyNDQ0OSBtcyksIHJldGFpbiAkCiAgICAgICAgICArLW8gcGNpZUAzMDAwMDAw
MCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlkIDB4MTAwMDAwMTFkLCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0MzMgbXMpLCByZXRhaW4gMTM+CiAgICAgICAgICAg
ICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9y
bVBDSUUsIGlkIDB4MTAwMDAwMTdiLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kg
MCAoMjQ0MzIgbXMpLCByJAogICAgICAgICAgICAgICstbyBzY3NpQDIgIDxjbGFzcyBJT1BDSURl
dmljZSwgaWQgMHgxMDAwMDAxN2YsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAw
ICgxMyBtcyksIHJldGFpbiAxMD4KICAgICAgICAgICAgICAgIHwgewogICAgICAgICAgICAgICAg
fCAgICJhc3NpZ25lZC1hZGRyZXNzZXMiID0gPDE0MTAwMDgyMDAyMDAxNTAwMDAwMDAwMDAwMTAw
MDAwMDAwMDAwMDAyMDEwMDBjMjAwODAwMDUwMDAwMDAwMDAwMDQwMDAwMDAwMDAwMDAwPgogICAg
ICAgICAgICAgICAgfCAgICJJT0ludGVycnVwdFNwZWNpZmllcnMiID0gKDw0MjAwMDAwMDAxMDAw
MDAwPikKICAgICAgICAgICAgICAgIHwgICAiY2xhc3MtY29kZSIgPSA8MDAwMDAxMDA+CiAgICAg
ICAgICAgICAgICB8ICAgIklPRGV2aWNlTWVtb3J5IiA9ICgoeyJhZGRyZXNzIj0xMzQyMjUxMDA4
LCJsZW5ndGgiPTQwOTZ9KSwoeyJhZGRyZXNzIj0xMzQyMjEwMDQ4LCJsZW5ndGgiPTE2Mzg0fSkp
CiAgICAgICAgICAgICAgICB8ICAgIklPUmVwb3J0TGVnZW5kUHVibGljIiA9IFllcwogICAgICAg
ICAgICAgICAgfCAgICJJT1Bvd2VyTWFuYWdlbWVudCIgPSB7IkN1cnJlbnRQb3dlclN0YXRlIj0y
LCJDYXBhYmlsaXR5RmxhZ3MiPTI1OCwiQ2hpbGRQcm94eVBvd2VyU3RhdGUiPTIsIk1heFBvd2Vy
U3RhdGUiPTN9CiAgICAgICAgICAgICAgICB8ICAgInN1YnN5c3RlbS12ZW5kb3ItaWQiID0gPGY0
MWEwMDAwPgogICAgICAgICAgICAgICAgfCAgICJJT0ludGVycnVwdENvbnRyb2xsZXJzIiA9ICgi
SU9JbnRlcnJ1cHRDb250cm9sbGVyMDAwMDAwMzciKQogICAgICAgICAgICAgICAgfCAgICJ2ZW5k
b3ItaWQiID0gPDZiMTAwMDAwPgogICAgICAgICAgICAgICAgfCAgICJuYW1lIiA9IDwic2NzaSI+
CiAgICAgICAgICAgICAgICB8ICAgImRldmljZS1pZCIgPSA8MDAxYTAwMDA+CiAgICAgICAgICAg
ICAgICB8ICAgIklPUENJUmVzb3VyY2VkIiA9IFllcwogICAgICAgICAgICAgICAgfCAgICJjb21w
YXRpYmxlIiA9IDwicGNpMWFmNCwxMTAwIiwicGNpMTA2YiwxYTAwIiwicGNpY2xhc3MsMDEwMDAw
Ij4KICAgICAgICAgICAgICAgIHwgICAiSU9TZXJ2aWNlREVYVEVudGl0bGVtZW50cyIgPSAoKCJj
b20uYXBwbGUuZGV2ZWxvcGVyLmRyaXZlcmtpdC50cmFuc3BvcnQucGNpIikpCiAgICAgICAgICAg
ICAgICB8ICAgInN1YnN5c3RlbS1pZCIgPSA8MDAxMTAwMDA+CiAgICAgICAgICAgICAgICB8ICAg
InJldmlzaW9uLWlkIiA9IDwwMTAwMDAwMD4KICAgICAgICAgICAgICAgIHwgICAicGNpZGVidWci
ID0gIjA6MjowIgogICAgICAgICAgICAgICAgfCAgICJJT05hbWUiID0gInNjc2kiCiAgICAgICAg
ICAgICAgICB8ICAgIklPUmVwb3J0TGVnZW5kIiA9ICh7IklPUmVwb3J0R3JvdXBOYW1lIj0iSW50
ZXJydXB0IFN0YXRpc3RpY3MgKGJ5IGluZGV4KSIsIklPUmVwb3J0Q2hhbm5lbHMiPSgoNTI5MTI5
NDY0NTE4MjAwNTI0OCw0Mjk1JAogICAgICAgICAgICAgICAgfCAgICJyZWciID0gPDAwMTAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxNDEwMDAwMjAwMDAwMDAwMDAwMDAwMDAw
MDEwMDAwMDAwMDAwMDAwMjAxMDAwNDIwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMCQKICAgICAgICAg
ICAgICAgIHwgfQogICAgICAgICAgICAgICAgfCAKICAgICAgICAgICAgICAgICstbyBBcHBsZVZp
cnRJT1BDSVRyYW5zcG9ydCAgPGNsYXNzIEFwcGxlVmlydElPUENJVHJhbnNwb3J0LCBpZCAweDEw
MDAwMDE4YiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDkgbXMpLCByZXQk
CiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVZpcnRJT1N0b3JhZ2VEZXZpY2UgIDxjbGFzcyBB
cHBsZVZpcnRJT1N0b3JhZ2VEZXZpY2UsIGlkIDB4MTAwMDAwMTkxLCByZWdpc3RlcmVkLCBtYXRj
aGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksJAogICAgICAgICAgICAgICAgICAgICstbyBBcHBs
ZVZpcnRJT1V0aWxTdG9yYWdlRGV2aWNlICA8Y2xhc3MgQXBwbGVWaXJ0SU9VdGlsU3RvcmFnZURl
dmljZSwgaWQgMHgxMDAwMDAxOTIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSQK
ICAgICAgICAgICAgICAgICAgICAgICstbyBBcHBsZUVtYmVkZGVkU2ltcGxlU1BJTk9SRmxhc2hl
ckRyaXZlciAgPGNsYXNzIEFwcGxlRW1iZWRkZWRTaW1wbGVTUElOT1JGbGFzaGVyRHJpdmVyLCBp
ZCAweDEwMDAwMDE5MywgcmVnaXN0ZXJlZCwkCiAgICAgICAgICAgICAgICAgICAgICArLW8gQXBw
bGVWaXJ0SU9OVlJBTSAgPGNsYXNzIEFwcGxlVmlydElPTlZSQU0sIGlkIDB4MTAwMDAwMTk0LCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpbiA1PgogICAg
ICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlTlZNZU5hbWVzcGFjZURldmljZSAgPGNsYXNzIEFw
cGxlTlZNZU5hbWVzcGFjZURldmljZSwgaWQgMHgxMDAwMDAxYjIsIHJlZ2lzdGVyZWQsIG1hdGNo
ZWQsIGFjdGl2ZSwgYnVzeSAwICgwICQKICAgICAgICAgICAgICAgICAgICAgICstbyBBcHBsZU5W
TWVFQU4gIDxjbGFzcyBBcHBsZU5WTWVFQU4sIGlkIDB4MTAwMDAwMWIzLCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpbiA2PgoKKy1vIFJvb3QgIDxjbGFz
cyBJT1JlZ2lzdHJ5RW50cnksIGlkIDB4MTAwMDAwMTAwLCByZXRhaW4gNz4KICArLW8gVk1BMk1B
Q09TQVAgIDxjbGFzcyBJT1BsYXRmb3JtRXhwZXJ0RGV2aWNlLCBpZCAweDEwMDAwMDEzOCwgcmVn
aXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDMwNzY2IG1zKSwgcmV0YWluIDI2Pgog
ICAgKy1vIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUgIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0
Zm9ybUFSTVBFLCBpZCAweDEwMDAwMDEzYywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBi
dXN5IDAgKDI0NDU0IG1zKSwgcmV0YWluICQKICAgICAgKy1vIGFybS1pbyAgPGNsYXNzIElPUGxh
dGZvcm1EZXZpY2UsIGlkIDB4MTAwMDAwMTE3LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUs
IGJ1c3kgMCAoMjQ0NTIgbXMpLCByZXRhaW4gMTY+CiAgICAgICAgKy1vIEFwcGxlVmlydHVhbFBs
YXRmb3JtSU8gIDxjbGFzcyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUlPLCBpZCAweDEwMDAwMDE2Niwg
IXJlZ2lzdGVyZWQsICFtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0NDkgbXMpLCByZXRhaW4g
JAogICAgICAgICAgKy1vIHBjaWVAMzAwMDAwMDAgIDxjbGFzcyBBcHBsZUFSTUlPRGV2aWNlLCBp
ZCAweDEwMDAwMDExZCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI0NDMz
IG1zKSwgcmV0YWluIDEzPgogICAgICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lF
ICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1QQ0lFLCBpZCAweDEwMDAwMDE3YiwgcmVnaXN0
ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI0NDMyIG1zKSwgciQKICAgICAgICAgICAg
ICArLW8gc2NzaUAzICA8Y2xhc3MgSU9QQ0lEZXZpY2UsIGlkIDB4MTAwMDAwMTgwLCByZWdpc3Rl
cmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjYgbXMpLCByZXRhaW4gMTA+CiAgICAgICAg
ICAgICAgICB8IHsKICAgICAgICAgICAgICAgIHwgICAiYXNzaWduZWQtYWRkcmVzc2VzIiA9IDwx
NDE4MDA4MjAwMTAwMTUwMDAwMDAwMDAwMDEwMDAwMDAwMDAwMDAwMjAxODAwYzIwMDQwMDA1MDAw
MDAwMDAwMDA0MDAwMDAwMDAwMDAwMD4KICAgICAgICAgICAgICAgIHwgICAiSU9JbnRlcnJ1cHRT
cGVjaWZpZXJzIiA9ICg8NDMwMDAwMDAwMTAwMDAwMD4pCiAgICAgICAgICAgICAgICB8ICAgImNs
YXNzLWNvZGUiID0gPDAwMDAwMTAwPgogICAgICAgICAgICAgICAgfCAgICJJT0RldmljZU1lbW9y
eSIgPSAoKHsiYWRkcmVzcyI9MTM0MjI0NjkxMiwibGVuZ3RoIj00MDk2fSksKHsiYWRkcmVzcyI9
MTM0MjE5MzY2NCwibGVuZ3RoIj0xNjM4NH0pKQogICAgICAgICAgICAgICAgfCAgICJJT1JlcG9y
dExlZ2VuZFB1YmxpYyIgPSBZZXMKICAgICAgICAgICAgICAgIHwgICAiSU9Qb3dlck1hbmFnZW1l
bnQiID0geyJDdXJyZW50UG93ZXJTdGF0ZSI9MiwiQ2FwYWJpbGl0eUZsYWdzIj0yNTgsIkNoaWxk
UHJveHlQb3dlclN0YXRlIj0yLCJNYXhQb3dlclN0YXRlIj0zfQogICAgICAgICAgICAgICAgfCAg
ICJzdWJzeXN0ZW0tdmVuZG9yLWlkIiA9IDxmNDFhMDAwMD4KICAgICAgICAgICAgICAgIHwgICAi
SU9JbnRlcnJ1cHRDb250cm9sbGVycyIgPSAoIklPSW50ZXJydXB0Q29udHJvbGxlcjAwMDAwMDM3
IikKICAgICAgICAgICAgICAgIHwgICAidmVuZG9yLWlkIiA9IDw2YjEwMDAwMD4KICAgICAgICAg
ICAgICAgIHwgICAibmFtZSIgPSA8InNjc2kiPgogICAgICAgICAgICAgICAgfCAgICJkZXZpY2Ut
aWQiID0gPDAwMWEwMDAwPgogICAgICAgICAgICAgICAgfCAgICJJT1BDSVJlc291cmNlZCIgPSBZ
ZXMKICAgICAgICAgICAgICAgIHwgICAiY29tcGF0aWJsZSIgPSA8InBjaTFhZjQsMTEwMCIsInBj
aTEwNmIsMWEwMCIsInBjaWNsYXNzLDAxMDAwMCI+CiAgICAgICAgICAgICAgICB8ICAgIklPU2Vy
dmljZURFWFRFbnRpdGxlbWVudHMiID0gKCgiY29tLmFwcGxlLmRldmVsb3Blci5kcml2ZXJraXQu
dHJhbnNwb3J0LnBjaSIpKQogICAgICAgICAgICAgICAgfCAgICJzdWJzeXN0ZW0taWQiID0gPDAw
MTEwMDAwPgogICAgICAgICAgICAgICAgfCAgICJyZXZpc2lvbi1pZCIgPSA8MDEwMDAwMDA+CiAg
ICAgICAgICAgICAgICB8ICAgInBjaWRlYnVnIiA9ICIwOjM6MCIKICAgICAgICAgICAgICAgIHwg
ICAiSU9OYW1lIiA9ICJzY3NpIgogICAgICAgICAgICAgICAgfCAgICJJT1JlcG9ydExlZ2VuZCIg
PSAoeyJJT1JlcG9ydEdyb3VwTmFtZSI9IkludGVycnVwdCBTdGF0aXN0aWNzIChieSBpbmRleCki
LCJJT1JlcG9ydENoYW5uZWxzIj0oKDUyOTEyOTQ2NDUxODIwMDUyNDgsNDI5NSQKICAgICAgICAg
ICAgICAgIHwgICAicmVnIiA9IDwwMDE4MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMTQxODAwMDIwMDAwMDAwMDAwMDAwMDAwMDAxMDAwMDAwMDAwMDAwMDIwMTgwMDQyMDAwMDAw
MDAwMDAwMDAwMDAwNDAwMDAkCiAgICAgICAgICAgICAgICB8IH0KICAgICAgICAgICAgICAgIHwg
CiAgICAgICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9QQ0lUcmFuc3BvcnQgIDxjbGFzcyBBcHBs
ZVZpcnRJT1BDSVRyYW5zcG9ydCwgaWQgMHgxMDAwMDAxOGMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICgyMiBtcyksIHJlJAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVW
aXJ0SU9TdG9yYWdlRGV2aWNlICA8Y2xhc3MgQXBwbGVWaXJ0SU9TdG9yYWdlRGV2aWNlLCBpZCAw
eDEwMDAwMDE5NSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDIxIG1zKSQK
ICAgICAgICAgICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9EaXNrU3RvcmFnZURldmljZUAxICA8
Y2xhc3MgQXBwbGVWaXJ0SU9EaXNrU3RvcmFnZURldmljZSwgaWQgMHgxMDAwMDAxOTYsIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnUkCiAgICAgICAgICAgICAgICAgICAgICArLW8gSU9C
bG9ja1N0b3JhZ2VEcml2ZXIgIDxjbGFzcyBJT0Jsb2NrU3RvcmFnZURyaXZlciwgaWQgMHgxMDAw
MDAxOTcsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyMSBtcyksIHJlJAog
ICAgICAgICAgICAgICAgICAgICAgICArLW8gQXBwbGUgSW5jLiBWaXJ0SU8gQmxvY2sgTWVkaWEg
IDxjbGFzcyBJT01lZGlhLCBpZCAweDEwMDAwMDE5OCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0
aXZlLCBidXN5IDAgKDIxIG1zKSwgcmV0YSQKICAgICAgICAgICAgICAgICAgICAgICAgICArLW8g
SU9NZWRpYUJTRENsaWVudCAgPGNsYXNzIElPTWVkaWFCU0RDbGllbnQsIGlkIDB4MTAwMDAwMTlh
LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpbiAkCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgKy1vIElPR1VJRFBhcnRpdGlvblNjaGVtZSAgPGNsYXNz
IElPR1VJRFBhcnRpdGlvblNjaGVtZSwgaWQgMHgxMDAwMDAxY2MsICFyZWdpc3RlcmVkLCAhbWF0
Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDExJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgKy1v
IGlCb290U3lzdGVtQ29udGFpbmVyQDEgIDxjbGFzcyBJT01lZGlhLCBpZCAweDEwMDAwMDFkMCwg
cmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDQgbXMpLCByZXRhaW4gMSQKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgKy1vIElPTWVkaWFCU0RDbGllbnQgIDxjbGFzcyBJ
T01lZGlhQlNEQ2xpZW50LCBpZCAweDEwMDAwMDFkMywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0
aXZlLCBidXN5IDAgKDAgbXMpLCByZXQkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICst
byBBcHBsZUFQRlNDb250YWluZXJTY2hlbWUgIDxjbGFzcyBBcHBsZUFQRlNDb250YWluZXJTY2hl
bWUsIGlkIDB4MTAwMDAwMWQ0LCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgJAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICstbyBBcHBsZUFQRlNNZWRpYSAgPGNsYXNzIEFw
cGxlQVBGU01lZGlhLCBpZCAweDEwMDAwMDFkOSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZl
LCBidXN5IDAgKDQgbXMpLCByZXRhaSQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICstbyBBcHBsZUFQRlNNZWRpYUJTRENsaWVudCAgPGNsYXNzIEFwcGxlQVBGU01lZGlhQlNEQ2xp
ZW50LCBpZCAweDEwMDAwMDFkYSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCAkCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICArLW8gQXBwbGVBUEZTQ29udGFpbmVyICA8Y2xh
c3MgQXBwbGVBUEZTQ29udGFpbmVyLCBpZCAweDEwMDAwMDFlZiwgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDAgJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICArLW8gaVNDUHJlYm9vdEAxICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDFm
NCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZSQKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xp
ZW50ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDFmOCwgcmVn
aXN0ZXJlZCwgbWF0Y2hlZCwgYWMkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAg
ICstbyB4QVJUQDIgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWUsIGlkIDB4MTAwMDAwMWY1LCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpbiAxJAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAgICB8ICstbyBBcHBsZUFQRlNWb2x1bWVCU0RDbGll
bnQgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQsIGlkIDB4MTAwMDAwMWZhLCByZWdp
c3RlcmVkLCBtYXRjaGVkLCBhYyQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
Ky1vIEhhcmR3YXJlQDMgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWUsIGlkIDB4MTAwMDAwMWY2LCBy
ZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGEkCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwgKy1vIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVu
dCAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCwgaWQgMHgxMDAwMDAxZmMsIHJlZ2lz
dGVyZWQsIG1hdGNoZWQsIGFjJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAr
LW8gUmVjb3ZlcnlANCAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAxZjcsIHJl
Z2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmV0YSQKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgICArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50
ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDFmZSwgcmVnaXN0
ZXJlZCwgbWF0Y2hlZCwgYWMkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICArLW8gQ29udGFp
bmVyQDIgIDxjbGFzcyBJT01lZGlhLCBpZCAweDEwMDAwMDFkMSwgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDExIG1zKSwgcmV0YWluIDEyPgogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCArLW8gSU9NZWRpYUJTRENsaWVudCAgPGNsYXNzIElPTWVkaWFCU0RDbGllbnQs
IGlkIDB4MTAwMDAwMWQ1LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBt
cyksIHJldCQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgKy1vIEFwcGxlQVBGU0NvbnRh
aW5lclNjaGVtZSAgPGNsYXNzIEFwcGxlQVBGU0NvbnRhaW5lclNjaGVtZSwgaWQgMHgxMDAwMDAx
ZDYsICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWN0aXZlLCAkCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgKy1vIEFwcGxlQVBGU01lZGlhICA8Y2xhc3MgQXBwbGVBUEZTTWVkaWEsIGlk
IDB4MTAwMDAwMWRkLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMTEgbXMp
LCByZXRhJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgKy1vIEFwcGxlQVBGU01l
ZGlhQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVBUEZTTWVkaWFCU0RDbGllbnQsIGlkIDB4MTAwMDAw
MWRlLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsICQKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgICstbyBBcHBsZUFQRlNDb250YWluZXIgIDxjbGFzcyBBcHBsZUFQRlNDb250
YWluZXIsIGlkIDB4MTAwMDAwMWYzLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kg
MCAoMSAkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICstbyBNYWNpbnRvc2gg
SERAMSAgPGNsYXNzIEFwcGxlQVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMDYsIHJlZ2lzdGVyZWQs
IG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxIG1zKSwgJAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICB8ICstbyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQgIDxjbGFzcyBBcHBs
ZUFQRlNWb2x1bWVCU0RDbGllbnQsIGlkIDB4MTAwMDAwMjBjLCByZWdpc3RlcmVkLCBtYXRjaGVk
LCBhYyQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgfCArLW8gY29tLmFwcGxl
Lm9zLnVwZGF0ZS03RTVGNjIxRTcxNzM4NkMwRjZERDVEOTI3RjIzQzJBRkIzNUM0MjM4MUE1RUE2
MUM5OTMyMzI0MjhGMEU2RTU1QDEgIDxjbGFzcyBBcHAkCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgICAgIHwgICArLW8gSU9NZWRpYUJTRENsaWVudCAgPGNsYXNzIElPTWVkaWFCU0RD
bGllbnQsIGlkIDB4MTAwMDAwMjFhLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kg
MCAoJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8gUHJlYm9vdEAyICA8
Y2xhc3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIwNywgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaSQKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVB
UEZTVm9sdW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDIwZiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWMkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICstbyBSZWNvdmVyeUAzICA8
Y2xhc3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIwOCwgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhJAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICAgICB8ICstbyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQgIDxjbGFzcyBBcHBsZUFQ
RlNWb2x1bWVCU0RDbGllbnQsIGlkIDB4MTAwMDAwMjExLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBh
YyQKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgKy1vIFVwZGF0ZUA0ICA8Y2xh
c3MgQXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIwOSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4kCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgIHwgKy1vIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCAgPGNsYXNzIEFwcGxlQVBG
U1ZvbHVtZUJTRENsaWVudCwgaWQgMHgxMDAwMDAyMTMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFj
JAogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICArLW8gRGF0YUA1ICA8Y2xhc3Mg
QXBwbGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIwYSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0
aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gMSQKICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVBUEZT
Vm9sdW1lQlNEQ2xpZW50LCBpZCAweDEwMDAwMDIxNSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWMk
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICstbyBWTUA2ICA8Y2xhc3MgQXBw
bGVBUEZTVm9sdW1lLCBpZCAweDEwMDAwMDIwYiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZl
LCBidXN5IDAgKDAgbXMpLCByZXRhaW4gMTE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgICAgICAgKy1vIEFwcGxlQVBGU1ZvbHVtZUJTRENsaWVudCAgPGNsYXNzIEFwcGxlQVBGU1Zv
bHVtZUJTRENsaWVudCwgaWQgMHgxMDAwMDAyMTcsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjJAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKy1vIFJlY292ZXJ5T1NDb250YWluZXJAMyAgPGNs
YXNzIElPTWVkaWEsIGlkIDB4MTAwMDAwMWQyLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUs
IGJ1c3kgMCAoNSBtcyksIHJldGFpbiAxMSQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ky1vIElPTWVkaWFCU0RDbGllbnQgIDxjbGFzcyBJT01lZGlhQlNEQ2xpZW50LCBpZCAweDEwMDAw
MDFkNywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXQkCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICstbyBBcHBsZUFQRlNDb250YWluZXJTY2hlbWUg
IDxjbGFzcyBBcHBsZUFQRlNDb250YWluZXJTY2hlbWUsIGlkIDB4MTAwMDAwMWQ4LCAhcmVnaXN0
ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICstbyBBcHBsZUFQRlNNZWRpYSAgPGNsYXNzIEFwcGxlQVBGU01lZGlhLCBpZCAweDEwMDAwMDFl
MSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDUgbXMpLCByZXRhaSQKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICstbyBBcHBsZUFQRlNNZWRpYUJTRENsaWVu
dCAgPGNsYXNzIEFwcGxlQVBGU01lZGlhQlNEQ2xpZW50LCBpZCAweDEwMDAwMDFlMiwgcmVnaXN0
ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCAkCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICArLW8gQXBwbGVBUEZTQ29udGFpbmVyICA8Y2xhc3MgQXBwbGVBUEZTQ29udGFpbmVyLCBpZCAw
eDEwMDAwMDFmMSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgJAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLW8gUmVjb3ZlcnlAMSAgPGNsYXNzIEFw
cGxlQVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMDAsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2
ZSwgYnVzeSAwICgwIG1zKSwgcmV0YSQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCArLW8gQXBwbGVBUEZTVm9sdW1lQlNEQ2xpZW50ICA8Y2xhc3MgQXBwbGVBUEZTVm9sdW1l
QlNEQ2xpZW50LCBpZCAweDEwMDAwMDIwMiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWMkCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICstbyBVcGRhdGVAMiAgPGNsYXNzIEFwcGxl
QVBGU1ZvbHVtZSwgaWQgMHgxMDAwMDAyMDEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAwICgwIG1zKSwgcmV0YWluJAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICstbyBBcHBsZUFQRlNWb2x1bWVCU0RDbGllbnQgIDxjbGFzcyBBcHBsZUFQRlNWb2x1bWVC
U0RDbGllbnQsIGlkIDB4MTAwMDAwMjA0LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhYyQKCistbyBS
b290ICA8Y2xhc3MgSU9SZWdpc3RyeUVudHJ5LCBpZCAweDEwMDAwMDEwMCwgcmV0YWluIDc+CiAg
Ky1vIFZNQTJNQUNPU0FQICA8Y2xhc3MgSU9QbGF0Zm9ybUV4cGVydERldmljZSwgaWQgMHgxMDAw
MDAxMzgsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgzMDc2NiBtcyksIHJl
dGFpbiAyNj4KICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVW
aXJ0dWFsUGxhdGZvcm1BUk1QRSwgaWQgMHgxMDAwMDAxM2MsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICgyNDQ1NCBtcyksIHJldGFpbiAkCiAgICAgICstbyBhcm0taW8gIDxj
bGFzcyBJT1BsYXRmb3JtRGV2aWNlLCBpZCAweDEwMDAwMDExNywgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDI0NDUyIG1zKSwgcmV0YWluIDE2PgogICAgICAgICstbyBBcHBs
ZVZpcnR1YWxQbGF0Zm9ybUlPICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTywgaWQgMHgx
MDAwMDAxNjYsICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI0NDQ5IG1z
KSwgcmV0YWluICQKICAgICAgICAgICstbyBwY2llQDMwMDAwMDAwICA8Y2xhc3MgQXBwbGVBUk1J
T0RldmljZSwgaWQgMHgxMDAwMDAxMWQsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVz
eSAwICgyNDQzMyBtcyksIHJldGFpbiAxMz4KICAgICAgICAgICAgKy1vIEFwcGxlVmlydHVhbFBs
YXRmb3JtUENJRSAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtUENJRSwgaWQgMHgxMDAwMDAx
N2IsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyNDQzMiBtcyksIHIkCiAg
ICAgICAgICAgICAgKy1vIGV0aGVybmV0QDQgIDxjbGFzcyBJT1BDSURldmljZSwgaWQgMHgxMDAw
MDAxODEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxMiBtcyksIHJldGFp
biA5PgogICAgICAgICAgICAgICAgfCB7CiAgICAgICAgICAgICAgICB8ICAgImFzc2lnbmVkLWFk
ZHJlc3NlcyIgPSA8MTQyMDAwODIwMDAwMDE1MDAwMDAwMDAwMDAxMDAwMDAwMDAwMDAwMDIwMjAw
MGMyMDAwMDAwNTAwMDAwMDAwMDAwNDAwMDAwMDAwMDAwMDA+CiAgICAgICAgICAgICAgICB8ICAg
IklPSW50ZXJydXB0U3BlY2lmaWVycyIgPSAoPDQ0MDAwMDAwMDEwMDAwMDA+KQogICAgICAgICAg
ICAgICAgfCAgICJjbGFzcy1jb2RlIiA9IDwwMDAwMDIwMD4KICAgICAgICAgICAgICAgIHwgICAi
SU9EZXZpY2VNZW1vcnkiID0gKCh7ImFkZHJlc3MiPTEzNDIyNDI4MTYsImxlbmd0aCI9NDA5Nn0p
LCh7ImFkZHJlc3MiPTEzNDIxNzcyODAsImxlbmd0aCI9MTYzODR9KSkKICAgICAgICAgICAgICAg
IHwgICAiSU9SZXBvcnRMZWdlbmRQdWJsaWMiID0gWWVzCiAgICAgICAgICAgICAgICB8ICAgIklP
UG93ZXJNYW5hZ2VtZW50IiA9IHsiQ3VycmVudFBvd2VyU3RhdGUiPTIsIkNhcGFiaWxpdHlGbGFn
cyI9MjU4LCJDaGlsZFByb3h5UG93ZXJTdGF0ZSI9MiwiTWF4UG93ZXJTdGF0ZSI9M30KICAgICAg
ICAgICAgICAgIHwgICAic3Vic3lzdGVtLXZlbmRvci1pZCIgPSA8ZjQxYTAwMDA+CiAgICAgICAg
ICAgICAgICB8ICAgIklPSW50ZXJydXB0Q29udHJvbGxlcnMiID0gKCJJT0ludGVycnVwdENvbnRy
b2xsZXIwMDAwMDAzNyIpCiAgICAgICAgICAgICAgICB8ICAgInZlbmRvci1pZCIgPSA8ZjQxYTAw
MDA+CiAgICAgICAgICAgICAgICB8ICAgIm5hbWUiID0gPCJldGhlcm5ldCI+CiAgICAgICAgICAg
ICAgICB8ICAgImRldmljZS1pZCIgPSA8NDExMDAwMDA+CiAgICAgICAgICAgICAgICB8ICAgIklP
UENJUmVzb3VyY2VkIiA9IFllcwogICAgICAgICAgICAgICAgfCAgICJjb21wYXRpYmxlIiA9IDwi
cGNpMWFmNCwxMTAwIiwicGNpMWFmNCwxMDQxIiwicGNpY2xhc3MsMDIwMDAwIj4KICAgICAgICAg
ICAgICAgIHwgICAiSU9TZXJ2aWNlREVYVEVudGl0bGVtZW50cyIgPSAoKCJjb20uYXBwbGUuZGV2
ZWxvcGVyLmRyaXZlcmtpdC50cmFuc3BvcnQucGNpIikpCiAgICAgICAgICAgICAgICB8ICAgInN1
YnN5c3RlbS1pZCIgPSA8MDAxMTAwMDA+CiAgICAgICAgICAgICAgICB8ICAgInJldmlzaW9uLWlk
IiA9IDwwMTAwMDAwMD4KICAgICAgICAgICAgICAgIHwgICAicGNpZGVidWciID0gIjA6NDowIgog
ICAgICAgICAgICAgICAgfCAgICJJT05hbWUiID0gImV0aGVybmV0IgogICAgICAgICAgICAgICAg
fCAgICJJT1JlcG9ydExlZ2VuZCIgPSAoeyJJT1JlcG9ydEdyb3VwTmFtZSI9IkludGVycnVwdCBT
dGF0aXN0aWNzIChieSBpbmRleCkiLCJJT1JlcG9ydENoYW5uZWxzIj0oKDUyOTEyOTQ2NDUxODIw
MDUyNDgsNDI5NSQKICAgICAgICAgICAgICAgIHwgICAicmVnIiA9IDwwMDIwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMTQyMDAwMDIwMDAwMDAwMDAwMDAwMDAwMDAxMDAwMDAw
MDAwMDAwMDIwMjAwMDQyMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAkCiAgICAgICAgICAgICAgICB8
IH0KICAgICAgICAgICAgICAgIHwgCiAgICAgICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9QQ0lU
cmFuc3BvcnQgIDxjbGFzcyBBcHBsZVZpcnRJT1BDSVRyYW5zcG9ydCwgaWQgMHgxMDAwMDAxOGQs
IHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICg4IG1zKSwgcmV0JAogICAgICAg
ICAgICAgICAgICArLW8gQXBwbGVWaXJ0SU9OZXR3b3JrICA8Y2xhc3MgQXBwbGVWaXJ0SU9OZXR3
b3JrLCBpZCAweDEwMDAwMDE5OSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAg
KDAgbXMpLCByZXRhaW4gMTA+CiAgICAgICAgICAgICAgICAgICAgKy1vIGVuMCAgPGNsYXNzIElP
RXRoZXJuZXRJbnRlcmZhY2UsIGlkIDB4MTAwMDAwMWI2LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBh
Y3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpbiAxMz4KICAgICAgICAgICAgICAgICAgICAgICst
byBJT05ldHdvcmtTdGFjayAgPGNsYXNzIElPTmV0d29ya1N0YWNrLCBpZCAweDEwMDAwMDFhNywg
cmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZXRhaW4gOD4KICAg
ICAgICAgICAgICAgICAgICAgICAgKy1vIElPTmV0d29ya1N0YWNrVXNlckNsaWVudCAgPGNsYXNz
IElPTmV0d29ya1N0YWNrVXNlckNsaWVudCwgaWQgMHgxMDAwMDAyNjUsICFyZWdpc3RlcmVkLCAh
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAkCgoKJSBpb3JlZyAtdHJjIElPSW50ZXJydXB0Q29udHJv
bGxlcgorLW8gUm9vdCAgPGNsYXNzIElPUmVnaXN0cnlFbnRyeSwgaWQgMHgxMDAwMDAxMDAsIHJl
dGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAgPGNsYXNzIElPUGxhdGZvcm1FeHBlcnREZXZpY2Us
IGlkIDB4MTAwMDAwMTM4LCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMzA3
NjYgbXMpLCByZXRhaW4gMjY+CiAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSAgPGNs
YXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUsIGlkIDB4MTAwMDAwMTNjLCByZWdpc3RlcmVk
LCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0NTQgbXMpLCByZXRhaW4gJAogICAgICArLW8g
YXJtLWlvICA8Y2xhc3MgSU9QbGF0Zm9ybURldmljZSwgaWQgMHgxMDAwMDAxMTcsIHJlZ2lzdGVy
ZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyNDQ1MiBtcyksIHJldGFpbiAxNj4KICAgICAg
ICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTyAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3Jt
SU8sIGlkIDB4MTAwMDAwMTY2LCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAw
ICgyNDQ0OSBtcyksIHJldGFpbiAkCiAgICAgICAgICArLW8gZ2ljQDAgIDxjbGFzcyBBcHBsZUFS
TUlPRGV2aWNlLCBpZCAweDEwMDAwMDExYSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBi
dXN5IDAgKDQgbXMpLCByZXRhaW4gOT4KICAgICAgICAgICAgKy1vIEFwcGxlQVJNR0lDdjMgIDxj
bGFzcyBBcHBsZUFSTUdJQ3YzLCBpZCAweDEwMDAwMDE3NywgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDQgbXMpLCByZXRhaW4gNj4KICAgICAgICAgICAgICAgIHsKICAgICAg
ICAgICAgICAgICAgIklPQ2xhc3MiID0gIkFwcGxlQVJNR0lDdjMiCiAgICAgICAgICAgICAgICAg
ICJDRkJ1bmRsZUlkZW50aWZpZXIiID0gImNvbS5hcHBsZS5kcml2ZXIuQXBwbGVBUk1HSUMiCiAg
ICAgICAgICAgICAgICAgICJJT1Byb3ZpZGVyQ2xhc3MiID0gIkFwcGxlQVJNSU9EZXZpY2UiCiAg
ICAgICAgICAgICAgICAgICJTeXN0ZW1Qb3dlclByb2ZpbGVPdmVycmlkZURpY3QiID0geyJTeXN0
ZW0gU2xlZXAgVGltZXIiPTIxNDc0ODM2NDd9CiAgICAgICAgICAgICAgICAgICJJT1Byb2JlU2Nv
cmUiID0gMTAwMAogICAgICAgICAgICAgICAgICAiSU9OYW1lTWF0Y2giID0gIkFSTSxnaWN2MyIK
ICAgICAgICAgICAgICAgICAgIklPTWF0Y2hlZEF0Qm9vdCIgPSBZZXMKICAgICAgICAgICAgICAg
ICAgIklPTWF0Y2hDYXRlZ29yeSIgPSAiSU9EZWZhdWx0TWF0Y2hDYXRlZ29yeSIKICAgICAgICAg
ICAgICAgICAgIklPTmFtZU1hdGNoZWQiID0gIkFSTSxnaWN2MyIKICAgICAgICAgICAgICAgICAg
IklPUGVyc29uYWxpdHlQdWJsaXNoZXIiID0gImNvbS5hcHBsZS5kcml2ZXIuQXBwbGVBUk1HSUMi
CiAgICAgICAgICAgICAgICAgICJJbnRlcnJ1cHRDb250cm9sbGVyTmFtZSIgPSAiSU9JbnRlcnJ1
cHRDb250cm9sbGVyMDAwMDAwMzciCiAgICAgICAgICAgICAgICAgICJDRkJ1bmRsZUlkZW50aWZp
ZXJLZXJuZWwiID0gImNvbS5hcHBsZS5kcml2ZXIuQXBwbGVBUk1HSUMiCiAgICAgICAgICAgICAg
ICB9CiAgICAgICAgICAgICAgICAKCistbyBSb290ICA8Y2xhc3MgSU9SZWdpc3RyeUVudHJ5LCBp
ZCAweDEwMDAwMDEwMCwgcmV0YWluIDc+CiAgKy1vIFZNQTJNQUNPU0FQICA8Y2xhc3MgSU9QbGF0
Zm9ybUV4cGVydERldmljZSwgaWQgMHgxMDAwMDAxMzgsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFj
dGl2ZSwgYnVzeSAwICgzMDc2NiBtcyksIHJldGFpbiAyNj4KICAgICstbyBBcHBsZVZpcnR1YWxQ
bGF0Zm9ybUFSTVBFICA8Y2xhc3MgQXBwbGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSwgaWQgMHgxMDAw
MDAxM2MsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyNDQ1NCBtcyksIHJl
dGFpbiAkCiAgICAgICstbyBQYXNzdGhydUludGVycnVwdENvbnRyb2xsZXIgIDxjbGFzcyBQYXNz
dGhydUludGVycnVwdENvbnRyb2xsZXIsIGlkIDB4MTAwMDAwMTZmLCByZWdpc3RlcmVkLCBtYXRj
aGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJldGFpJAogICAgICAgICAgewogICAgICAgICAg
ICAiSU9QbGF0Zm9ybUludGVycnVwdENvbnRyb2xsZXIiID0gWWVzCiAgICAgICAgICB9CgoKJSBp
b3JlZyAtdHJjIEFwcGxlVVNCWEhDSSAgICAgICAgIAorLW8gUm9vdCAgPGNsYXNzIElPUmVnaXN0
cnlFbnRyeSwgaWQgMHgxMDAwMDAxMDAsIHJldGFpbiA3PgogICstbyBWTUEyTUFDT1NBUCAgPGNs
YXNzIElPUGxhdGZvcm1FeHBlcnREZXZpY2UsIGlkIDB4MTAwMDAwMTM4LCByZWdpc3RlcmVkLCBt
YXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMzA3NjYgbXMpLCByZXRhaW4gMjY+CiAgICArLW8gQXBw
bGVWaXJ0dWFsUGxhdGZvcm1BUk1QRSAgPGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtQVJNUEUs
IGlkIDB4MTAwMDAwMTNjLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0
NTQgbXMpLCByZXRhaW4gJAogICAgICArLW8gYXJtLWlvICA8Y2xhc3MgSU9QbGF0Zm9ybURldmlj
ZSwgaWQgMHgxMDAwMDAxMTcsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgy
NDQ1MyBtcyksIHJldGFpbiAxNj4KICAgICAgICArLW8gQXBwbGVWaXJ0dWFsUGxhdGZvcm1JTyAg
PGNsYXNzIEFwcGxlVmlydHVhbFBsYXRmb3JtSU8sIGlkIDB4MTAwMDAwMTY2LCAhcmVnaXN0ZXJl
ZCwgIW1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgyNDQ1MCBtcyksIHJldGFpbiAkCiAgICAgICAg
ICArLW8gcGNpZUAzMDAwMDAwMCAgPGNsYXNzIEFwcGxlQVJNSU9EZXZpY2UsIGlkIDB4MTAwMDAw
MTFkLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0MzMgbXMpLCByZXRh
aW4gMTM+CiAgICAgICAgICAgICstbyBBcHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUgIDxjbGFzcyBB
cHBsZVZpcnR1YWxQbGF0Zm9ybVBDSUUsIGlkIDB4MTAwMDAwMTdiLCByZWdpc3RlcmVkLCBtYXRj
aGVkLCBhY3RpdmUsIGJ1c3kgMCAoMjQ0MzIgbXMpLCByJAogICAgICAgICAgICAgICstbyBwY2kx
YjM2LGRAMSAgPGNsYXNzIElPUENJRGV2aWNlLCBpZCAweDEwMDAwMDE3ZSwgcmVnaXN0ZXJlZCwg
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDI0NDE5IG1zKSwgcmV0YWluIDEyPgogICAgICAgICAg
ICAgICAgKy1vIEFwcGxlVVNCWEhDSVBDSUAwMTAwMDAwMCAgPGNsYXNzIEFwcGxlVVNCWEhDSVBD
SSwgaWQgMHgxMDAwMDAxOGEsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgy
NDQwNiBtcyksIHJldGFpbiQKICAgICAgICAgICAgICAgICAgfCB7CiAgICAgICAgICAgICAgICAg
IHwgICAiSU9DbGFzcyIgPSAiQXBwbGVVU0JYSENJUENJIgogICAgICAgICAgICAgICAgICB8ICAg
IkNGQnVuZGxlSWRlbnRpZmllciIgPSAiY29tLmFwcGxlLmRyaXZlci51c2IuQXBwbGVVU0JYSENJ
UENJIgogICAgICAgICAgICAgICAgICB8ICAgIklPUHJvdmlkZXJDbGFzcyIgPSAiSU9QQ0lEZXZp
Y2UiCiAgICAgICAgICAgICAgICAgIHwgICAia1VTQlNsZWVwU3VwcG9ydGVkIiA9IE5vCiAgICAg
ICAgICAgICAgICAgIHwgICAiSU9QQ0lDbGFzc01hdGNoIiA9ICIweDBjMDMzMDAwIgogICAgICAg
ICAgICAgICAgICB8ICAgIklPUENJVHVubmVsQ29tcGF0aWJsZSIgPSBZZXMKICAgICAgICAgICAg
ICAgICAgfCAgICJJT1Bvd2VyTWFuYWdlbWVudCIgPSB7IkNoaWxkcmVuUG93ZXJTdGF0ZSI9Mywi
RGV2aWNlUG93ZXJTdGF0ZSI9MCwiQ3VycmVudFBvd2VyU3RhdGUiPTMsIkNhcGFiaWxpdHlGbGFn
cyI9MzI3NjgsIk1heFAkCiAgICAgICAgICAgICAgICAgIHwgICAiSU9Qcm9iZVNjb3JlIiA9IDAK
ICAgICAgICAgICAgICAgICAgfCAgICJJT01hdGNoZWRBdEJvb3QiID0gWWVzCiAgICAgICAgICAg
ICAgICAgIHwgICAiSU9QQ0lQYXVzZUNvbXBhdGlibGUiID0gWWVzCiAgICAgICAgICAgICAgICAg
IHwgICAiSU9NYXRjaENhdGVnb3J5IiA9ICJJT0RlZmF1bHRNYXRjaENhdGVnb3J5IgogICAgICAg
ICAgICAgICAgICB8ICAgImxvY2F0aW9uSUQiID0gMTY3NzcyMTYKICAgICAgICAgICAgICAgICAg
fCAgICJSZXZpc2lvbiIgPSA8MDAwMz4KICAgICAgICAgICAgICAgICAgfCAgICJjb250cm9sbGVy
LXN0YXRpc3RpY3MiID0geyJrQ29udHJvbGxlclN0YXRJT0NvdW50Ij0yMDMwLCJrQ29udHJvbGxl
clN0YXRQb3dlclN0YXRlVGltZSI9eyJrUG93ZXJTdGF0ZU9mZiI9IjBtcyAoMCUpIiwkCiAgICAg
ICAgICAgICAgICAgIHwgICAiSU9QZXJzb25hbGl0eVB1Ymxpc2hlciIgPSAiY29tLmFwcGxlLmRy
aXZlci51c2IuQXBwbGVVU0JYSENJUENJIgogICAgICAgICAgICAgICAgICB8ICAgIkNGQnVuZGxl
SWRlbnRpZmllcktlcm5lbCIgPSAiY29tLmFwcGxlLmRyaXZlci51c2IuQXBwbGVVU0JYSENJUENJ
IgogICAgICAgICAgICAgICAgICB8ICAgIklPUENJVXNlRGV2aWNlTWFwcGVyIiA9IFllcwogICAg
ICAgICAgICAgICAgICB8IH0KICAgICAgICAgICAgICAgICAgfCAKICAgICAgICAgICAgICAgICAg
Ky1vIEFwcGxlVVNCMjBYSENJUG9ydEAwMTUwMDAwMCAgPGNsYXNzIEFwcGxlVVNCMjBYSENJUG9y
dCwgaWQgMHgxMDAwMDAxYmMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgy
MDQ4NSBtcykkCiAgICAgICAgICAgICAgICAgIHwgKy1vIFFFTVUgVVNCIEtleWJvYXJkQDAxNTAw
MDAwICA8Y2xhc3MgSU9VU0JIb3N0RGV2aWNlLCBpZCAweDEwMDAwMDI4MCwgcmVnaXN0ZXJlZCwg
bWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDIwNDg1IG1zKSwgJAogICAgICAgICAgICAgICAgICB8
ICAgKy1vIEFwcGxlVVNCSG9zdENvbXBvc2l0ZURldmljZSAgPGNsYXNzIEFwcGxlVVNCSG9zdENv
bXBvc2l0ZURldmljZSwgaWQgMHgxMDAwMDAyZGUsICFyZWdpc3RlcmVkLCAhbWF0Y2hlZCwgYWN0
aXZlLCBidSQKICAgICAgICAgICAgICAgICAgfCAgICstbyBJT1VTQkhvc3RJbnRlcmZhY2VAMCAg
PGNsYXNzIElPVVNCSG9zdEludGVyZmFjZSwgaWQgMHgxMDAwMDAyZTgsIHJlZ2lzdGVyZWQsIG1h
dGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgxNDM1NSBtcyksIHIkCiAgICAgICAgICAgICAgICAgIHwg
ICAgICstbyBBcHBsZVVzZXJVU0JIb3N0SElERGV2aWNlICA8Y2xhc3MgQXBwbGVVc2VySElERGV2
aWNlLCBpZCAweDEwMDAwMDJlOSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAg
KDEwMjQwJAogICAgICAgICAgICAgICAgICB8ICAgICAgICstbyBJT0hJREludGVyZmFjZSAgPGNs
YXNzIElPSElESW50ZXJmYWNlLCBpZCAweDEwMDAwMDJlZiwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDEwMjQwIG1zKSwgcmV0YWluICQKICAgICAgICAgICAgICAgICAgfCAg
ICAgICAgICstbyBBcHBsZVVzZXJISURFdmVudERyaXZlciAgPGNsYXNzIEFwcGxlVXNlckhJREV2
ZW50U2VydmljZSwgaWQgMHgxMDAwMDAyZjAsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwg
YnVzeSAkCiAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICstbyBJT0hJREV2ZW50U2Vydmlj
ZVVzZXJDbGllbnQgIDxjbGFzcyBJT0hJREV2ZW50U2VydmljZVVzZXJDbGllbnQsIGlkIDB4MTAw
MDAwMmY1LCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjJAogICAgICAgICAgICAgICAgICArLW8g
QXBwbGVVU0IyMFhIQ0lQb3J0QDAxNjAwMDAwICA8Y2xhc3MgQXBwbGVVU0IyMFhIQ0lQb3J0LCBp
ZCAweDEwMDAwMDFiZCwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDM5MjAg
bXMpLCQKICAgICAgICAgICAgICAgICAgfCArLW8gUUVNVSBVU0IgVGFibGV0QDAxNjAwMDAwICA8
Y2xhc3MgSU9VU0JIb3N0RGV2aWNlLCBpZCAweDEwMDAwMDI0YywgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDM5MjAgbXMpLCByZXQkCiAgICAgICAgICAgICAgICAgIHwgICAr
LW8gQXBwbGVVU0JIb3N0Q29tcG9zaXRlRGV2aWNlICA8Y2xhc3MgQXBwbGVVU0JIb3N0Q29tcG9z
aXRlRGV2aWNlLCBpZCAweDEwMDAwMDI3ZiwgIXJlZ2lzdGVyZWQsICFtYXRjaGVkLCBhY3RpdmUs
IGJ1JAogICAgICAgICAgICAgICAgICB8ICAgKy1vIElPVVNCSG9zdEludGVyZmFjZUAwICA8Y2xh
c3MgSU9VU0JIb3N0SW50ZXJmYWNlLCBpZCAweDEwMDAwMDI4YSwgcmVnaXN0ZXJlZCwgbWF0Y2hl
ZCwgYWN0aXZlLCBidXN5IDAgKDIwNTAgbXMpLCByZSQKICAgICAgICAgICAgICAgICAgfCAgICAg
Ky1vIEFwcGxlVXNlclVTQkhvc3RISUREZXZpY2UgIDxjbGFzcyBBcHBsZVVzZXJISUREZXZpY2Us
IGlkIDB4MTAwMDAwMjhiLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMiBt
cykkCiAgICAgICAgICAgICAgICAgIHwgICAgICAgKy1vIElPSElESW50ZXJmYWNlICA8Y2xhc3Mg
SU9ISURJbnRlcmZhY2UsIGlkIDB4MTAwMDAwMmEyLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3Rp
dmUsIGJ1c3kgMCAoMiBtcyksIHJldGFpbiAxMD4KICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICstbyBBcHBsZVVzZXJISURFdmVudERyaXZlciAgPGNsYXNzIEFwcGxlVXNlckhJREV2ZW50U2Vy
dmljZSwgaWQgMHgxMDAwMDAyYTMsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAk
CiAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICstbyBJT0hJREV2ZW50U2VydmljZVVzZXJD
bGllbnQgIDxjbGFzcyBJT0hJREV2ZW50U2VydmljZVVzZXJDbGllbnQsIGlkIDB4MTAwMDAwMmE3
LCAhcmVnaXN0ZXJlZCwgIW1hdGNoZWQsIGFjJAogICAgICAgICAgICAgICAgICArLW8gQXBwbGVV
U0IyMFhIQ0lQb3J0QDAxNzAwMDAwICA8Y2xhc3MgQXBwbGVVU0IyMFhIQ0lQb3J0LCBpZCAweDEw
MDAwMDFiZSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwgYWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZSQK
ICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNCMjBYSENJUG9ydEAwMTgwMDAwMCAgPGNsYXNz
IEFwcGxlVVNCMjBYSENJUG9ydCwgaWQgMHgxMDAwMDAxYmYsIHJlZ2lzdGVyZWQsIG1hdGNoZWQs
IGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmUkCiAgICAgICAgICAgICAgICAgICstbyBBcHBsZVVT
QjMwWEhDSVBvcnRAMDExMDAwMDAgIDxjbGFzcyBBcHBsZVVTQjMwWEhDSVBvcnQsIGlkIDB4MTAw
MDAwMWMwLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBhY3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJlJAog
ICAgICAgICAgICAgICAgICArLW8gQXBwbGVVU0IzMFhIQ0lQb3J0QDAxMjAwMDAwICA8Y2xhc3Mg
QXBwbGVVU0IzMFhIQ0lQb3J0LCBpZCAweDEwMDAwMDFjMSwgcmVnaXN0ZXJlZCwgbWF0Y2hlZCwg
YWN0aXZlLCBidXN5IDAgKDAgbXMpLCByZSQKICAgICAgICAgICAgICAgICAgKy1vIEFwcGxlVVNC
MzBYSENJUG9ydEAwMTMwMDAwMCAgPGNsYXNzIEFwcGxlVVNCMzBYSENJUG9ydCwgaWQgMHgxMDAw
MDAxYzIsIHJlZ2lzdGVyZWQsIG1hdGNoZWQsIGFjdGl2ZSwgYnVzeSAwICgwIG1zKSwgcmUkCiAg
ICAgICAgICAgICAgICAgICstbyBBcHBsZVVTQjMwWEhDSVBvcnRAMDE0MDAwMDAgIDxjbGFzcyBB
cHBsZVVTQjMwWEhDSVBvcnQsIGlkIDB4MTAwMDAwMWMzLCByZWdpc3RlcmVkLCBtYXRjaGVkLCBh
Y3RpdmUsIGJ1c3kgMCAoMCBtcyksIHJlJAoK
--000000000000b077ca0626a38ca0--

