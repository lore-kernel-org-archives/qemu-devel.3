Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F779E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 16:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPlQG-0005hR-80; Mon, 23 Dec 2024 11:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPlQD-0005cm-8u
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 11:36:45 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPlQ1-0005GD-81
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 11:36:38 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so2513308f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 08:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734971791; x=1735576591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jNCW6j+MvxRNgZGe1/3p77BdKRVb0x/KpDQe7yIW37g=;
 b=mmW65iQlZEciZ7IO8ooP7LGcWxm9g80H+NeUcxKupHMjdb2sF2hAdjHHs8vmusYM6N
 yQhajDydDBVUOLqXcQTQAh1W6FH4LYegZ3EpXsy9/INXXy6a1/H3MBawRKvG3jlBI2he
 GI8yn11aRoIQX9FomuTWMIBizEUYM8lw1KGjD8Mqaeaxab7UZRj3SuLq0nQXKtj0cTim
 25hNRReGgAhVWmsys1DDe2yV54bFp1AlqfmiycyeQy7kfZUWIkUCUcfZXRIDvDT6wYeG
 wpANojnmXmS0SNSeL9wwGflPVqg/R7fByxJadqp6lBWWktJd0pOjPD+vhy89Avp6e2zV
 qulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734971791; x=1735576591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jNCW6j+MvxRNgZGe1/3p77BdKRVb0x/KpDQe7yIW37g=;
 b=RjGgEM6okmRNUEFfHciRaFAfIEuUc+Fq9EuRzUAFKWlshZnRrQEY3CbEF6A/RnB4iC
 ZEZuJV5Aet1bFcrrukwCVbIp1Tp7zIiSgNH/W9F4kURUyLUIAAZIUN+BzOrpMBdtk/NR
 WroyTUSjQCrvv+yqKDfnmtr/PAEeSc+INQCI6eURwx+BKFhIGzt4KVMlIMBB7isqggxZ
 7QgXsri3VXgP+gD/QHfZ4xgDLYGY9gOKI/T7ZHByK6FoP72nB4oDEF6eh2tGt82ESbGd
 OVRwHY5edEObkuYMozmX4iaRnv3EA8QhPRVwhlxuFlnNOl4aiQvlsI2X1t7Cgcn3EaYC
 TpQQ==
X-Gm-Message-State: AOJu0YwJorPYSQ3FiHvyPVvKxZX1+jz6c0ByX1VD8HA3FR3jrwuYmdsl
 sGCzm6Pojas2GQLo5Ong1GBbQt3V408y/YkMBf41TXqSj0IO7vTut1ibEtdwQ5o=
X-Gm-Gg: ASbGncs/JGEPg28vgqDylVkoplOQMAS+/kGAwGXnCJBa01cFu9qcMgitE0It0p74+E+
 e/Eo/aw62xph/g/J2dbgBSbqWb4FoRITNREkOF87F61IlD49ELsfLiiCYVYIq7uOSjLiIIJVjdx
 9sKOPddT5DclHMO55LRtw0BgjElNEqj2EHBhvsg8Gz4LdTlhjx7O/0TKArUZ2h6TPvrYS2K1Hor
 nuCjaHUjfnVKxxwVXgZgJShaeq9xOrF7zmKBXGAdNLjz/Ls3bzYxweopSErqpmSHJeUujtPdKhz
 haZSNVyDn1dgUj4zcKg=
X-Google-Smtp-Source: AGHT+IGAKu+51yNelWLy6/dt+wHzrmyv68jrQxkzSXheg2IOmApXwcJaQvdLDBzh5bhT5Jhr9Rpguw==
X-Received: by 2002:a5d:5f82:0:b0:382:4f9e:711f with SMTP id
 ffacd0b85a97d-38a221e14a7mr10413654f8f.6.1734971791152; 
 Mon, 23 Dec 2024 08:36:31 -0800 (PST)
Received: from [10.89.88.213] (51.171.88.92.rev.sfr.net. [92.88.171.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8332absm11635737f8f.38.2024.12.23.08.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 08:36:30 -0800 (PST)
Message-ID: <167ca349-980c-43a7-82f2-264b2f7250cb@linaro.org>
Date: Mon, 23 Dec 2024 17:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <20241218202036.80064-1-phil@philjordan.eu>
 <20241218202036.80064-16-phil@philjordan.eu>
 <1253b5c5-ddf3-4b55-8a7a-f3ab6ccb0fbe@daynix.com>
 <CAAibmn1w46yD3qXueCMNZOge6PSXPdAgj9PhOn1CG+n9AcmsXg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAibmn1w46yD3qXueCMNZOge6PSXPdAgj9PhOn1CG+n9AcmsXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Phil,

On 23/12/24 14:53, Phil Dennis-Jordan wrote:
> On Thu, 19 Dec 2024 at 11:50, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     Reviewing "[PATCH v2 6/6] hw/vmapple: XHCI controller's interrupt
>     mapping workaround for macOS", I found a few problems so I'm adding
>     comments for them:
> 
>     On 2024/12/19 5:20, Phil Dennis-Jordan wrote:
>      > From: Alexander Graf <graf@amazon.com <mailto:graf@amazon.com>>
>      >
>      > Apple defines a new "vmapple" machine type as part of its proprietary
>      > macOS Virtualization.Framework vmm. This machine type is similar
>     to the
>      > virt one, but with subtle differences in base devices, a few special
>      > vmapple device additions and a vastly different boot chain.
>      >
>      > This patch reimplements this machine type in QEMU. To use it, you
>      > have to have a readily installed version of macOS for VMApple,
>      > run on macOS with -accel hvf, pass the Virtualization.Framework
>      > boot rom (AVPBooter) in via -bios, pass the aux and root volume
>     as pflash
>      > and pass aux and root volume as virtio drives. In addition, you also
>      > need to find the machine UUID and pass that as -M vmapple,uuid=
>     parameter:
>      >
>      > $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>      >      -bios /System/Library/Frameworks/Virtualization.framework/
>     Versions/A/Resources/AVPBooter.vmapple2.bin
>      >      -drive file=aux,if=pflash,format=raw \
>      >      -drive file=root,if=pflash,format=raw \
>      >      -drive file=aux,if=none,id=aux,format=raw \
>      >      -device vmapple-virtio-blk-pci,variant=aux,drive=aux \
>      >      -drive file=root,if=none,id=root,format=raw \
>      >      -device vmapple-virtio-blk-pci,variant=root,drive=root
>      >
>      > With all these in place, you should be able to see macOS booting
>      > successfully.
>      >
>      > Known issues:
>      >   - Keyboard and mouse/tablet input is laggy. The reason for this is
>      >     that macOS's XHCI driver seems to expect interrupter mapping to
>      >     be disabled when MSI/MSI-X is unavailable. I have found a
>      >     workaround but discovered a bunch of other XHCI spec non-
>     compliance
>      >     in the process, so I'm fixing all of those in a separate patch
>      >     set.
>      >   - Currently only macOS 12 guests are supported. The boot
>     process for
>      >     13+ will need further investigation and adjustment.
>      >
>      > Signed-off-by: Alexander Graf <graf@amazon.com
>     <mailto:graf@amazon.com>>
>      > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu
>     <mailto:phil@philjordan.eu>>
>      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
>     <mailto:phil@philjordan.eu>>
>      > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      > Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      > ---
>      >
>      > v3:
>      >   * Rebased on latest upstream, updated affinity and NIC creation
>      >     API usage
>      >   * Included Apple-variant virtio-blk in build dependency
>      >   * Updated API usage for setting 'redist-region-count' array-
>     typed property on GIC.
>      >   * Switched from virtio HID devices (for which macOS 12 does not
>     contain
>      >     drivers) to an XHCI USB controller and USB HID devices.
>      >
>      > v4:
>      >   * Fixups for v4 changes to the other patches in the set.
>      >   * Corrected the assert macro to use
>      >   * Removed superfluous endian conversions corresponding to cfg's.
>      >   * Init error handling improvement.
>      >   * No need to select CPU type on TCG, as only HVF is supported.
>      >   * Machine type version bumped to 9.2
>      >   * #include order improved
>      >
>      > v5:
>      >   * Fixed memory reservation for ecam alias region.
>      >   * Better error handling setting properties on devices.
>      >   * Simplified the machine ECID/UUID extraction script and
>     actually created a
>      >     file for it rather than quoting its code in documentation.
>      >
>      > v7:
>      >   * Tiny error handling fix, un-inlined function.
>      >
>      > v8:
>      >   * Use object_property_add_uint64_ptr rather than defining
>     custom UUID
>      >     property get/set functions.
>      >
>      > v9:
>      >   * Documentation improvements
>      >   * Fixed variable name and struct field used during pvpanic
>     device creation.
>      >
>      > v10:
>      >   * Documentation fixup for changed virtio-blk device type.
>      >   * Small improvements to shell commands in documentation.
>      >   * Improved propagation of errors during cfg device instantiation.
>      >
>      > v11:
>      >   * Quoted more strings in the documentation's shell script code.
>      >
>      > v13:
>      >   * Bumped the machine type version from 9.2 to 10.0.
>      >
>      >   MAINTAINERS                 |   1 +
>      >   contrib/vmapple/uuid.sh     |   9 +
>      >   docs/system/arm/vmapple.rst |  63 ++++
>      >   docs/system/target-arm.rst  |   1 +
>      >   hw/vmapple/Kconfig          |  20 ++
>      >   hw/vmapple/meson.build      |   1 +
>      >   hw/vmapple/vmapple.c        | 648 +++++++++++++++++++++++++++++
>     +++++++
>      >   7 files changed, 743 insertions(+)
>      >   create mode 100755 contrib/vmapple/uuid.sh
>      >   create mode 100644 docs/system/arm/vmapple.rst
>      >   create mode 100644 hw/vmapple/vmapple.c
>      >
>      > diff --git a/MAINTAINERS b/MAINTAINERS
>      > index 5d9d65e6df7..a8e3d3b74a2 100644
>      > --- a/MAINTAINERS
>      > +++ b/MAINTAINERS
>      > @@ -2777,6 +2777,7 @@ M: Phil Dennis-Jordan <phil@philjordan.eu
>     <mailto:phil@philjordan.eu>>
>      >   S: Maintained
>      >   F: hw/vmapple/*
>      >   F: include/hw/vmapple/*
>      > +F: docs/system/arm/vmapple.rst
>      >
>      >   Subsystems
>      >   ----------
>      > diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
>      > new file mode 100755
>      > index 00000000000..956e8c3afed
>      > --- /dev/null
>      > +++ b/contrib/vmapple/uuid.sh
>      > @@ -0,0 +1,9 @@
>      > +#!/bin/sh
>      > +# Used for converting a guest provisioned using
>     Virtualization.framework
>      > +# for use with the QEMU 'vmapple' aarch64 machine type.
>      > +#
>      > +# Extracts the Machine UUID from Virtualization.framework VM
>     JSON file.
>      > +# (as produced by 'macosvm', passed as command line argument)
>      > +
>      > +plutil -extract machineId raw "$1" | base64 -d | plutil -extract
>     ECID raw -
>      > +
>      > diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/
>     vmapple.rst
>      > new file mode 100644
>      > index 00000000000..5090a8997c3
>      > --- /dev/null
>      > +++ b/docs/system/arm/vmapple.rst
>      > @@ -0,0 +1,63 @@
>      > +VMApple machine emulation
>      >
>     +========================================================================================
>      > +
>      > +VMApple is the device model that the macOS built-in hypervisor
>     called "Virtualization.framework"
>      > +exposes to Apple Silicon macOS guests. The "vmapple" machine
>     model in QEMU implements the same
>      > +device model, but does not use any code from
>     Virtualization.Framework.
>      > +
>      > +Prerequisites
>      > +-------------
>      > +
>      > +To run the vmapple machine model, you need to
>      > +
>      > + * Run on Apple Silicon
>      > + * Run on macOS 12.0 or above
>      > + * Have an already installed copy of a Virtualization.Framework
>     macOS 12 virtual
>      > +   machine. Note that newer versions than 12.x are currently NOT
>     supported on
>      > +   the guest side. I will assume that you installed it using the
>      > +   `macosvm <https://github.com/s-u/macosvm <https://github.com/
>     s-u/macosvm>>` CLI.
>      > +
>      > +First, we need to extract the UUID from the virtual machine that
>     you installed. You can do this
>      > +by running the shell script in contrib/vmapple/uuid.sh on the
>     macosvm.json file.
>      > +
>      > +.. code-block:: bash
>      > +  :caption: uuid.sh script to extract the UUID from a
>     macosvm.json file
>      > +
>      > +  $ contrib/vmapple/uuid.sh "path/to/macosvm.json"
>      > +
>      > +Now we also need to trim the aux partition. It contains metadata
>     that we can just discard:
>      > +
>      > +.. code-block:: bash
>      > +  :caption: Command to trim the aux file
>      > +
>      > +  $ dd if="aux.img" of="aux.img.trimmed" bs=$(( 0x4000 )) skip=1
>      > +
>      > +How to run
>      > +----------
>      > +
>      > +Then, we can launch QEMU with the Virtualization.Framework pre-
>     boot environment and the readily
>      > +installed target disk images. I recommend to port forward the
>     VM's ssh and vnc ports to the host
>      > +to get better interactive access into the target system:
>      > +
>      > +.. code-block:: bash
>      > +  :caption: Example execution command line
>      > +
>      > +  $ UUID="$(contrib/vmapple/uuid.sh 'macosvm.json')"
>      > +  $ AVPBOOTER="/System/Library/Frameworks/
>     Virtualization.framework/Resources/AVPBooter.vmapple2.bin"
>      > +  $ AUX="aux.img.trimmed"
>      > +  $ DISK="disk.img"
>      > +  $ qemu-system-aarch64 \
>      > +       -serial mon:stdio \
>      > +       -m 4G \
>      > +       -accel hvf \
>      > +       -M vmapple,uuid="$UUID" \
>      > +       -bios "$AVPBOOTER" \
>      > +       -drive file="$AUX",if=pflash,format=raw \
>      > +       -drive file="$DISK",if=pflash,format=raw \
>      > +       -drive file="$AUX",if=none,id=aux,format=raw \
>      > +       -drive file="$DISK",if=none,id=root,format=raw \
>      > +       -device vmapple-virtio-blk-pci,variant=aux,drive=aux \
>      > +       -device vmapple-virtio-blk-pci,variant=root,drive=root \
>      > +       -netdev
>     user,id=net0,ipv6=off,hostfwd=tcp::2222-:22,hostfwd=tcp::5901-:5900 \
>      > +       -device virtio-net-pci,netdev=net0
>      > +
>      > diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
>      > index 9aaa9c414c9..3426f79100b 100644
>      > --- a/docs/system/target-arm.rst
>      > +++ b/docs/system/target-arm.rst
>      > @@ -102,6 +102,7 @@ Board-specific documentation
>      >      arm/stellaris
>      >      arm/stm32
>      >      arm/virt
>      > +   arm/vmapple
>      >      arm/xenpvh
>      >      arm/xlnx-versal-virt
>      >      arm/xlnx-zynq
>      > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
>      > index bcd1be63e3c..6a4c4a7fa2e 100644
>      > --- a/hw/vmapple/Kconfig
>      > +++ b/hw/vmapple/Kconfig
>      > @@ -10,3 +10,23 @@ config VMAPPLE_CFG
>      >   config VMAPPLE_VIRTIO_BLK
>      >       bool
>      >
>      > +config VMAPPLE
>      > +    bool
>      > +    depends on ARM
>      > +    depends on HVF
>      > +    default y if ARM
>      > +    imply PCI_DEVICES
>      > +    select ARM_GIC
>      > +    select PLATFORM_BUS
>      > +    select PCI_EXPRESS
>      > +    select PCI_EXPRESS_GENERIC_BRIDGE
>      > +    select PL011 # UART
>      > +    select PL031 # RTC
>      > +    select PL061 # GPIO
>      > +    select GPIO_PWR
>      > +    select PVPANIC_MMIO
>      > +    select VMAPPLE_AES
>      > +    select VMAPPLE_BDIF
>      > +    select VMAPPLE_CFG
>      > +    select MAC_PVG_MMIO
>      > +    select VMAPPLE_VIRTIO_BLK
>      > diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
>      > index bf17cf906c9..e572f7d5602 100644
>      > --- a/hw/vmapple/meson.build
>      > +++ b/hw/vmapple/meson.build
>      > @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_VMAPPLE_AES', 
>     if_true: files('aes.c'))
>      >   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true:
>     files('bdif.c'))
>      >   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
>      >   system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true:
>     files('virtio-blk.c'))
>      > +specific_ss.add(when: 'CONFIG_VMAPPLE',     if_true:
>     files('vmapple.c'))
>      > diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
>      > new file mode 100644
>      > index 00000000000..66336942c8d
>      > --- /dev/null
>      > +++ b/hw/vmapple/vmapple.c
>      > @@ -0,0 +1,648 @@
>      > +/*
>      > + * VMApple machine emulation
>      > + *
>      > + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All
>     Rights Reserved.
>      > + *
>      > + * This work is licensed under the terms of the GNU GPL, version
>     2 or later.
>      > + * See the COPYING file in the top-level directory.
>      > + *
>      > + * SPDX-License-Identifier: GPL-2.0-or-later
>      > + *
>      > + * VMApple is the device model that the macOS built-in
>     hypervisor called
>      > + * "Virtualization.framework" exposes to Apple Silicon macOS
>     guests. The
>      > + * machine model in this file implements the same device model
>     in QEMU, but
>      > + * does not use any code from Virtualization.Framework.
>      > + */
>      > +
>      > +#include "qemu/osdep.h"
>      > +#include "qemu/bitops.h"
>      > +#include "qemu/datadir.h"
>      > +#include "qemu/error-report.h"
>      > +#include "qemu/guest-random.h"
>      > +#include "qemu/help-texts.h"
>      > +#include "qemu/log.h"
>      > +#include "qemu/module.h"
>      > +#include "qemu/option.h"
>      > +#include "qemu/units.h"
>      > +#include "monitor/qdev.h"
>      > +#include "hw/boards.h"
>      > +#include "hw/irq.h"
>      > +#include "hw/loader.h"
>      > +#include "hw/qdev-properties.h"
>      > +#include "hw/sysbus.h"
>      > +#include "hw/usb.h"
>      > +#include "hw/arm/boot.h"
>      > +#include "hw/arm/primecell.h"
>      > +#include "hw/char/pl011.h"
>      > +#include "hw/intc/arm_gic.h"
>      > +#include "hw/intc/arm_gicv3_common.h"
>      > +#include "hw/misc/pvpanic.h"
>      > +#include "hw/pci-host/gpex.h"
>      > +#include "hw/usb/xhci.h"
>      > +#include "hw/virtio/virtio-pci.h"
>      > +#include "hw/vmapple/vmapple.h"
>      > +#include "net/net.h"
>      > +#include "qapi/error.h"
>      > +#include "qapi/qmp/qlist.h"
>      > +#include "qapi/visitor.h"
>      > +#include "qapi/qapi-visit-common.h"
>      > +#include "standard-headers/linux/input.h"
>      > +#include "sysemu/hvf.h"
>      > +#include "sysemu/kvm.h"
>      > +#include "sysemu/reset.h"
>      > +#include "sysemu/runstate.h"
>      > +#include "sysemu/sysemu.h"
>      > +#include "target/arm/internals.h"
>      > +#include "target/arm/kvm_arm.h"
>      > +
>      > +struct VMAppleMachineClass {
>      > +    MachineClass parent;
>      > +};
>      > +
>      > +struct VMAppleMachineState {
>      > +    MachineState parent;
>      > +
>      > +    Notifier machine_done;
>      > +    struct arm_boot_info bootinfo;
>      > +    MemMapEntry *memmap;
>      > +    const int *irqmap;
>      > +    DeviceState *gic;
>      > +    DeviceState *cfg;
>      > +    DeviceState *pvpanic;
>      > +    Notifier powerdown_notifier;
>      > +    PCIBus *bus;
>      > +    MemoryRegion fw_mr;
>      > +    MemoryRegion ecam_alias;
>      > +    uint64_t uuid;
>      > +};
>      > +
>      > +#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \
> 
>     This macro has suffix "_LATEST", but it is used not only for the latest
>     version but also for older versions.
> 
>     include/hw/boards.h suggests using "_IMPL" suffix.
> 
> 
> Thanks for pointing this out, I've fixed it locally and will include it 
> in v16.

Do you have other changes in your v16? I'm quite happy to integrate this
v15.

> 
> Adapting this giant macro for each machine type seems rather error-prone 
> and the kind of thing a computer does better than a human writing the 
> code. I can't help but wonder if we could define a generic version in 
> boards.h and only implement the DEFINE_*_MACHINE{_LATEST,}() wrappers 
> specifically for each machine type. I've created an issue for this on 
> GitLab: https://gitlab.com/qemu-project/qemu/-/issues/2744 <https:// 
> gitlab.com/qemu-project/qemu/-/issues/2744> I might attack that once 
> I've cut down my backlog of unmerged patches.

Do we really want the vmapple machines to be versioned? I see 3 options:
1/ No (simplest)
2/ Not yet, adding versioning when we see the needs
3/ Yes

Personally I prefer/recommend 1/ or 2/ ;)

> 
>      > +    static void
>     vmapple##major##_##minor##_class_init(ObjectClass *oc, \
>      > +                                                    void *data) \
>      > +    { \
>      > +        MachineClass *mc = MACHINE_CLASS(oc); \
>      > +        vmapple_machine_##major##_##minor##_options(mc); \
>      > +        mc->desc = "QEMU " # major "." # minor " Apple Virtual
>     Machine"; \
>      > +        if (latest) { \
>      > +            mc->alias = "vmapple"; \
>      > +        } \
>      > +    } \
>      > +    static const TypeInfo machvmapple##major##_##minor##_info = { \
>      > +        .name = MACHINE_TYPE_NAME("vmapple-" # major "." # minor), \
>      > +        .parent = TYPE_VMAPPLE_MACHINE, \
>      > +        .class_init = vmapple##major##_##minor##_class_init, \
>      > +    }; \
>      > +    static void machvmapple_machine_##major##_##minor##_init(void) \
>      > +    { \
>      > +       
>     type_register_static(&machvmapple##major##_##minor##_info); \
>      > +    } \
>      > +    type_init(machvmapple_machine_##major##_##minor##_init);
>      > +
>      > +#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(major, minor) \
>      > +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, true)
>      > +#define DEFINE_VMAPPLE_MACHINE(major, minor) \
>      > +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, false)
>      > +
>      > +#define TYPE_VMAPPLE_MACHINE   MACHINE_TYPE_NAME("vmapple")
>      > +OBJECT_DECLARE_TYPE(VMAppleMachineState, VMAppleMachineClass,
>     VMAPPLE_MACHINE)
>      > +
>      > +/* Number of external interrupt lines to configure the GIC with */
>      > +#define NUM_IRQS 256
>      > +
>      > +enum {
>      > +    VMAPPLE_FIRMWARE,
>      > +    VMAPPLE_CONFIG,
>      > +    VMAPPLE_MEM,
>      > +    VMAPPLE_GIC_DIST,
>      > +    VMAPPLE_GIC_REDIST,
>      > +    VMAPPLE_UART,
>      > +    VMAPPLE_RTC,
>      > +    VMAPPLE_PCIE,
>      > +    VMAPPLE_PCIE_MMIO,
>      > +    VMAPPLE_PCIE_ECAM,
>      > +    VMAPPLE_GPIO,
>      > +    VMAPPLE_PVPANIC,
>      > +    VMAPPLE_APV_GFX,
>      > +    VMAPPLE_APV_IOSFC,
>      > +    VMAPPLE_AES_1,
>      > +    VMAPPLE_AES_2,
>      > +    VMAPPLE_BDOOR,
>      > +    VMAPPLE_MEMMAP_LAST,
>      > +};
>      > +
>      > +static MemMapEntry memmap[] = {

const

>      > +    [VMAPPLE_FIRMWARE] =           { 0x00100000, 0x00100000 },
>      > +    [VMAPPLE_CONFIG] =             { 0x00400000, 0x00010000 },
>      > +
>      > +    [VMAPPLE_GIC_DIST] =           { 0x10000000, 0x00010000 },
>      > +    [VMAPPLE_GIC_REDIST] =         { 0x10010000, 0x00400000 },
>      > +
>      > +    [VMAPPLE_UART] =               { 0x20010000, 0x00010000 },
>      > +    [VMAPPLE_RTC] =                { 0x20050000, 0x00001000 },
>      > +    [VMAPPLE_GPIO] =               { 0x20060000, 0x00001000 },
>      > +    [VMAPPLE_PVPANIC] =            { 0x20070000, 0x00000002 },
>      > +    [VMAPPLE_BDOOR] =              { 0x30000000, 0x00200000 },
>      > +    [VMAPPLE_APV_GFX] =            { 0x30200000, 0x00010000 },
>      > +    [VMAPPLE_APV_IOSFC] =          { 0x30210000, 0x00010000 },
>      > +    [VMAPPLE_AES_1] =              { 0x30220000, 0x00004000 },
>      > +    [VMAPPLE_AES_2] =              { 0x30230000, 0x00004000 },
>      > +    [VMAPPLE_PCIE_ECAM] =          { 0x40000000, 0x10000000 },
>      > +    [VMAPPLE_PCIE_MMIO] =          { 0x50000000, 0x1fff0000 },
>      > +
>      > +    /* Actual RAM size depends on configuration */
>      > +    [VMAPPLE_MEM] =                { 0x70000000ULL, GiB},
>      > +};
>      > +
>      > +static const int irqmap[] = {
>      > +    [VMAPPLE_UART] = 1,
>      > +    [VMAPPLE_RTC] = 2,
>      > +    [VMAPPLE_GPIO] = 0x5,
>      > +    [VMAPPLE_APV_IOSFC] = 0x10,
>      > +    [VMAPPLE_APV_GFX] = 0x11,
>      > +    [VMAPPLE_AES_1] = 0x12,
>      > +    [VMAPPLE_PCIE] = 0x20,
>      > +};


