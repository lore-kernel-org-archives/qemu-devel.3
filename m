Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C81D5E39B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 07:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA2V9-0004yA-DR; Sun, 10 Nov 2024 02:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tA2V7-0004xj-UO
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 02:36:49 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tA2V1-0007w0-8O
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 02:36:49 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so39382135ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 23:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731224202; x=1731829002;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5RESIE56VPTBY2iEcESdfW+3/ct9D1qW1crES1OLJeQ=;
 b=jBa3f7qtihDu1AcGNYPwSbvmwNFaMouJyaPiX1LxrZWrPVrrw/AyK7Y6s26bZiTCp/
 FtWJw8sqAvzzVfrv+3sbHDzt8STgapeDpMrZemJ6o2aaF+VnQmoygYjuJdQjWrKqPXGf
 bCP8AXuNGNgrrt8JwTLnkdAPPRsRYqrJfjMA8txt0PbUlw9wZdcXStDn7mMNh6z08YdD
 jO/cqwDIImNxiDkCE9Oxn1gQicE+A79RlBpGjCyRObuXxp8D/UVkeyQOn8geu8KlkF+e
 T8pWlBwtKjPa844mSj4uXvDNFQaJwcUgaZnlG6J2MuJU60A3PQJVUAmXpxEJnX378Ps6
 jnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731224202; x=1731829002;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5RESIE56VPTBY2iEcESdfW+3/ct9D1qW1crES1OLJeQ=;
 b=N1i+oi+94ThV5j/6+896rqsv/isJFvr7ZSyz2UnX7E0mK2UGdi4rEHqqDmGG0uF/1V
 sXwuxzAIPyyjV5FgeI2vpsOcuv7kJzQS/qa8sJ6M16+4uBcrJ44YX3ppoM4utAlSsJBk
 s6mZLRdLBssnk+YtffnGFSCZty6fF/CjTsbRs9FXJgeeeEQa6hLDi2XjotWYh1WlOfEc
 SVzALJZiZpRaDBvtNoCFYp+LknH3MhSI1Mj5u9sZbf4g0VaVLjRUxlUYIBP4dVWrBCpT
 C6jYe74F4GR/2qWfZQhC3P8Yn7VFj1fb1+eY2mUaYHzyHXHz04fm2qlAJZ+M8CTn21me
 SOzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYQEqb2sLQNX0MwEOfPUGDf4rlv9/l8ZNciQIi6MmmkPkYCEzJfKSN8l35XLtGOnYJ3mGCJcA/ndzO@nongnu.org
X-Gm-Message-State: AOJu0YxuX+nLE/hHNIpA1m9W6vmIz6wRPmGSMnrz8ZpnZgJUfy1NRfIF
 HGgVkGcb2CpE80xFjEnidibn345+TDRxK8CHRFA46qyJb18aJFvzyeOb3MVELtI=
X-Google-Smtp-Source: AGHT+IE0xkAZAEXERB2B2u38M1LKaAsU3SuZfVAzcrbVgQ77LqwftgLhoUFDiRYDsbbZdkc8KvjMCQ==
X-Received: by 2002:a17:902:d48a:b0:20c:e5b5:608a with SMTP id
 d9443c01a7336-211834dfb92mr135458335ad.5.1731224201568; 
 Sat, 09 Nov 2024 23:36:41 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f642bedsm6218010a12.67.2024.11.09.23.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 23:36:41 -0800 (PST)
Message-ID: <388c911e-bd7a-45ad-8188-c1321b12f80c@daynix.com>
Date: Sun, 10 Nov 2024 16:36:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v8 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-16-phil@philjordan.eu>
Content-Language: en-US
In-Reply-To: <20241108144709.95498-16-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/08 23:47, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Apple defines a new "vmapple" machine type as part of its proprietary
> macOS Virtualization.Framework vmm. This machine type is similar to the
> virt one, but with subtle differences in base devices, a few special
> vmapple device additions and a vastly different boot chain.
> 
> This patch reimplements this machine type in QEMU. To use it, you
> have to have a readily installed version of macOS for VMApple,
> run on macOS with -accel hvf, pass the Virtualization.Framework
> boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
> and pass aux and root volume as virtio drives. In addition, you also
> need to find the machine UUID and pass that as -M vmapple,uuid= parameter:
> 
> $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>      -bios /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/AVPBooter.vmapple2.bin
>      -drive file=aux,if=pflash,format=raw \
>      -drive file=root,if=pflash,format=raw \
>      -drive file=aux,if=none,id=aux,format=raw \
>      -device vmapple-virtio-aux,drive=aux \
>      -drive file=root,if=none,id=root,format=raw \
>      -device vmapple-virtio-root,drive=root
> 
> With all these in place, you should be able to see macOS booting
> successfully.
> 
> Known issues:
>   - Keyboard and mouse/tablet input is laggy. The reason for this is
>     either that macOS's XHCI driver is broken when the device/platform
>     does not support MSI/MSI-X, or there's some unfortunate interplay
>     with Qemu's XHCI implementation in this scenario.
>   - Currently only macOS 12 guests are supported. The boot process for
>     13+ will need further investigation and adjustment.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
> 
> v3:
>   * Rebased on latest upstream, updated affinity and NIC creation
>     API usage
>   * Included Apple-variant virtio-blk in build dependency
>   * Updated API usage for setting 'redist-region-count' array-typed property
>     on GIC.
>   * Switched from virtio HID devices (for which macOS 12 does not contain
>     drivers) to an XHCI USB controller and USB HID devices.
> 
> v4:
>   * Fixups for v4 changes to the other patches in the set.
>   * Corrected the assert macro to use
>   * Removed superfluous endian conversions corresponding to cfg's.
>   * Init error handling improvement.
>   * No need to select CPU type on TCG, as only HVF is supported.
>   * Machine type version bumped to 9.2
>   * #include order improved
> 
> v5:
>   * Fixed memory reservation for ecam alias region.
>   * Better error handling setting properties on devices.
>   * Simplified the machine ECID/UUID extraction script and actually created a
>     file for it rather than quoting its code in documentation.
> 
> v7:
>   * Tiny error handling fix, un-inlined function.
> 
> v8:
>   * Use object_property_add_uint64_ptr rather than defining custom UUID
>     property get/set functions.
> 
>   MAINTAINERS                 |   1 +
>   contrib/vmapple/uuid.sh     |   9 +
>   docs/system/arm/vmapple.rst |  60 ++++
>   docs/system/target-arm.rst  |   1 +
>   hw/vmapple/Kconfig          |  20 ++
>   hw/vmapple/meson.build      |   1 +
>   hw/vmapple/vmapple.c        | 638 ++++++++++++++++++++++++++++++++++++
>   7 files changed, 730 insertions(+)
>   create mode 100755 contrib/vmapple/uuid.sh
>   create mode 100644 docs/system/arm/vmapple.rst
>   create mode 100644 hw/vmapple/vmapple.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d0d26cb65f..9591fd44a34 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2767,6 +2767,7 @@ R: Phil Dennis-Jordan <phil@philjordan.eu>
>   S: Maintained
>   F: hw/vmapple/*
>   F: include/hw/vmapple/*
> +F: docs/system/arm/vmapple.rst
>   
>   Subsystems
>   ----------
> diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
> new file mode 100755
> index 00000000000..956e8c3afed
> --- /dev/null
> +++ b/contrib/vmapple/uuid.sh
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +# Used for converting a guest provisioned using Virtualization.framework
> +# for use with the QEMU 'vmapple' aarch64 machine type.
> +#
> +# Extracts the Machine UUID from Virtualization.framework VM JSON file.
> +# (as produced by 'macosvm', passed as command line argument)
> +
> +plutil -extract machineId raw "$1" | base64 -d | plutil -extract ECID raw -
> +
> diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
> new file mode 100644
> index 00000000000..6a634fa4572
> --- /dev/null
> +++ b/docs/system/arm/vmapple.rst
> @@ -0,0 +1,60 @@
> +VMApple machine emulation
> +========================================================================================
> +
> +VMApple is the device model that the macOS built-in hypervisor called "Virtualization.framework"
> +exposes to Apple Silicon macOS guests. The "vmapple" machine model in QEMU implements the same
> +device model, but does not use any code from Virtualization.Framework.
> +
> +Prerequisites
> +-------------
> +
> +To run the vmapple machine model, you need to
> +
> + * Run on Apple Silicon
> + * Run on macOS 12.0 or above
> + * Have an already installed copy of a Virtualization.Framework macOS 12 virtual machine. I will
> +   assume that you installed it using the macosvm CLI.

Add a URL to macosvm.

> +
> +First, we need to extract the UUID from the virtual machine that you installed. You can do this
> +by running the shell script in contrib/vmapple/uuid.sh on the macosvm.json file.
> +
> +.. code-block:: bash
> +  :caption: uuid.sh script to extract the UUID from a macosvm.json file
> +
> +  $ contrib/vmapple/uuid.sh "path/to/macosvm.json"
> +
> +Now we also need to trim the aux partition. It contains metadata that we can just discard:
> +
> +.. code-block:: bash
> +  :caption: Command to trim the aux file
> +
> +  $ dd if="aux.img" of="aux.img.trimmed" bs=$(( 0x4000 )) skip=1

Quoting is inconsistent. aux.img.trimmed is not quoted below but it is 
quoted here.

> +
> +How to run
> +----------
> +
> +Then, we can launch QEMU with the Virtualization.Framework pre-boot environment and the readily
> +installed target disk images. I recommend to port forward the VM's ssh and vnc ports to the host
> +to get better interactive access into the target system:
> +
> +.. code-block:: bash
> +  :caption: Example execution command line
> +
> +  $ UUID=$(uuid.sh macosvm.json)
> +  $ AVPBOOTER=/System/Library/Frameworks/Virtualization.framework/Resources/AVPBooter.vmapple2.bin
> +  $ AUX=aux.img.trimmed
> +  $ DISK=disk.img
> +  $ qemu-system-aarch64 \
> +       -serial mon:stdio \
> +       -m 4G \
> +       -accel hvf \
> +       -M vmapple,uuid=$UUID \
> +       -bios $AVPBOOTER \

$AUX and $DISK are quoted but $UUID and $AVPBOOTER are not.

> +        -drive file="$AUX",if=pflash,format=raw \
> +        -drive file="$DISK",if=pflash,format=raw \

These two lines are misaligned.

> +       -drive file="$AUX",if=none,id=aux,format=raw \
> +       -drive file="$DISK",if=none,id=root,format=raw \
> +       -device vmapple-virtio-aux,drive=aux \
> +       -device vmapple-virtio-root,drive=root \
> +       -net user,ipv6=off,hostfwd=tcp::2222-:22,hostfwd=tcp::5901-:5900 \
> +       -net nic,model=virtio-net-pci \

-net is a legacy option and creates a unnecessary indirection with hub. 
Use -netdev and -device options. Also plug virtio-net-pci into a PCIe 
root port as suggested in: docs/pcie.txt

I thought it is about time to give a try on my M2 MacBook Air, but this 
command line did not work. The serial output said iBootStage2 finished, 
but it went silent after that and the display gives not output. macosvm 
can run the VM image. I used: UniversalMac_15.1_24B83_Restore.ipsw

Do you have an idea what's wrong with my setup? Doesn't it work with 15.1?

> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 9aaa9c414c9..3426f79100b 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -102,6 +102,7 @@ Board-specific documentation
>      arm/stellaris
>      arm/stm32
>      arm/virt
> +   arm/vmapple
>      arm/xenpvh
>      arm/xlnx-versal-virt
>      arm/xlnx-zynq
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index bcd1be63e3c..6a4c4a7fa2e 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -10,3 +10,23 @@ config VMAPPLE_CFG
>   config VMAPPLE_VIRTIO_BLK
>       bool
>   
> +config VMAPPLE
> +    bool
> +    depends on ARM
> +    depends on HVF
> +    default y if ARM
> +    imply PCI_DEVICES
> +    select ARM_GIC
> +    select PLATFORM_BUS
> +    select PCI_EXPRESS
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PL011 # UART
> +    select PL031 # RTC
> +    select PL061 # GPIO
> +    select GPIO_PWR
> +    select PVPANIC_MMIO
> +    select VMAPPLE_AES
> +    select VMAPPLE_BDIF
> +    select VMAPPLE_CFG
> +    select MAC_PVG_MMIO
> +    select VMAPPLE_VIRTIO_BLK
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index bf17cf906c9..e572f7d5602 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true: files('virtio-blk.c'))
> +specific_ss.add(when: 'CONFIG_VMAPPLE',     if_true: files('vmapple.c'))
> diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
> new file mode 100644
> index 00000000000..8b8710c70a2
> --- /dev/null
> +++ b/hw/vmapple/vmapple.c
> @@ -0,0 +1,638 @@
> +/*
> + * VMApple machine emulation
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * VMApple is the device model that the macOS built-in hypervisor called
> + * "Virtualization.framework" exposes to Apple Silicon macOS guests. The
> + * machine model in this file implements the same device model in QEMU, but
> + * does not use any code from Virtualization.Framework.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/datadir.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qemu/help-texts.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/option.h"
> +#include "qemu/units.h"
> +#include "monitor/qdev.h"
> +#include "hw/boards.h"
> +#include "hw/irq.h"
> +#include "hw/loader.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "hw/usb.h"
> +#include "hw/arm/boot.h"
> +#include "hw/arm/primecell.h"
> +#include "hw/char/pl011.h"
> +#include "hw/intc/arm_gic.h"
> +#include "hw/intc/arm_gicv3_common.h"
> +#include "hw/misc/pvpanic.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/usb/xhci.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/vmapple/vmapple.h"
> +#include "net/net.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qlist.h"
> +#include "qapi/visitor.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "standard-headers/linux/input.h"
> +#include "sysemu/hvf.h"
> +#include "sysemu/kvm.h"
> +#include "sysemu/reset.h"
> +#include "sysemu/runstate.h"
> +#include "sysemu/sysemu.h"
> +#include "target/arm/internals.h"
> +#include "target/arm/kvm_arm.h"
> +
> +struct VMAppleMachineClass {
> +    MachineClass parent;
> +};
> +
> +struct VMAppleMachineState {
> +    MachineState parent;
> +
> +    Notifier machine_done;
> +    struct arm_boot_info bootinfo;
> +    MemMapEntry *memmap;
> +    const int *irqmap;
> +    DeviceState *gic;
> +    DeviceState *cfg;
> +    Notifier powerdown_notifier;
> +    PCIBus *bus;
> +    MemoryRegion fw_mr;
> +    MemoryRegion ecam_alias;
> +    uint64_t uuid;
> +};
> +
> +#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \
> +    static void vmapple##major##_##minor##_class_init(ObjectClass *oc, \
> +                                                    void *data) \
> +    { \
> +        MachineClass *mc = MACHINE_CLASS(oc); \
> +        vmapple_machine_##major##_##minor##_options(mc); \
> +        mc->desc = "QEMU " # major "." # minor " Apple Virtual Machine"; \
> +        if (latest) { \
> +            mc->alias = "vmapple"; \
> +        } \
> +    } \
> +    static const TypeInfo machvmapple##major##_##minor##_info = { \
> +        .name = MACHINE_TYPE_NAME("vmapple-" # major "." # minor), \
> +        .parent = TYPE_VMAPPLE_MACHINE, \
> +        .class_init = vmapple##major##_##minor##_class_init, \
> +    }; \
> +    static void machvmapple_machine_##major##_##minor##_init(void) \
> +    { \
> +        type_register_static(&machvmapple##major##_##minor##_info); \
> +    } \
> +    type_init(machvmapple_machine_##major##_##minor##_init);
> +
> +#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(major, minor) \
> +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, true)
> +#define DEFINE_VMAPPLE_MACHINE(major, minor) \
> +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, false)
> +
> +#define TYPE_VMAPPLE_MACHINE   MACHINE_TYPE_NAME("vmapple")
> +OBJECT_DECLARE_TYPE(VMAppleMachineState, VMAppleMachineClass, VMAPPLE_MACHINE)
> +
> +/* Number of external interrupt lines to configure the GIC with */
> +#define NUM_IRQS 256
> +
> +enum {
> +    VMAPPLE_FIRMWARE,
> +    VMAPPLE_CONFIG,
> +    VMAPPLE_MEM,
> +    VMAPPLE_GIC_DIST,
> +    VMAPPLE_GIC_REDIST,
> +    VMAPPLE_UART,
> +    VMAPPLE_RTC,
> +    VMAPPLE_PCIE,
> +    VMAPPLE_PCIE_MMIO,
> +    VMAPPLE_PCIE_ECAM,
> +    VMAPPLE_GPIO,
> +    VMAPPLE_PVPANIC,
> +    VMAPPLE_APV_GFX,
> +    VMAPPLE_APV_IOSFC,
> +    VMAPPLE_AES_1,
> +    VMAPPLE_AES_2,
> +    VMAPPLE_BDOOR,
> +    VMAPPLE_MEMMAP_LAST,
> +};
> +
> +static MemMapEntry memmap[] = {
> +    [VMAPPLE_FIRMWARE] =           { 0x00100000, 0x00100000 },
> +    [VMAPPLE_CONFIG] =             { 0x00400000, 0x00010000 },
> +
> +    [VMAPPLE_GIC_DIST] =           { 0x10000000, 0x00010000 },
> +    [VMAPPLE_GIC_REDIST] =         { 0x10010000, 0x00400000 },
> +
> +    [VMAPPLE_UART] =               { 0x20010000, 0x00010000 },
> +    [VMAPPLE_RTC] =                { 0x20050000, 0x00001000 },
> +    [VMAPPLE_GPIO] =               { 0x20060000, 0x00001000 },
> +    [VMAPPLE_PVPANIC] =            { 0x20070000, 0x00000002 },
> +    [VMAPPLE_BDOOR] =              { 0x30000000, 0x00200000 },
> +    [VMAPPLE_APV_GFX] =            { 0x30200000, 0x00010000 },
> +    [VMAPPLE_APV_IOSFC] =          { 0x30210000, 0x00010000 },
> +    [VMAPPLE_AES_1] =              { 0x30220000, 0x00004000 },
> +    [VMAPPLE_AES_2] =              { 0x30230000, 0x00004000 },
> +    [VMAPPLE_PCIE_ECAM] =          { 0x40000000, 0x10000000 },
> +    [VMAPPLE_PCIE_MMIO] =          { 0x50000000, 0x1fff0000 },
> +
> +    /* Actual RAM size depends on configuration */
> +    [VMAPPLE_MEM] =                { 0x70000000ULL, GiB},
> +};
> +
> +static const int irqmap[] = {
> +    [VMAPPLE_UART] = 1,
> +    [VMAPPLE_RTC] = 2,
> +    [VMAPPLE_GPIO] = 0x5,
> +    [VMAPPLE_APV_IOSFC] = 0x10,
> +    [VMAPPLE_APV_GFX] = 0x11,
> +    [VMAPPLE_AES_1] = 0x12,
> +    [VMAPPLE_PCIE] = 0x20,
> +};
> +
> +#define GPEX_NUM_IRQS 16
> +
> +static void create_bdif(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    DeviceState *bdif;
> +    SysBusDevice *bdif_sb;
> +    DriveInfo *di_aux = drive_get(IF_PFLASH, 0, 0);
> +    DriveInfo *di_root = drive_get(IF_PFLASH, 0, 1);
> +
> +    if (!di_aux) {
> +        error_report("No AUX device. Please specify one as pflash drive.");
> +        exit(1);
> +    }
> +
> +    if (!di_root) {
> +        /* Fall back to the first IF_VIRTIO device as root device */
> +        di_root = drive_get(IF_VIRTIO, 0, 0);
> +    }
> +
> +    if (!di_root) {
> +        error_report("No root device. Please specify one as virtio drive.");
> +        exit(1);
> +    }
> +
> +    /* PV backdoor device */
> +    bdif = qdev_new(TYPE_VMAPPLE_BDIF);
> +    bdif_sb = SYS_BUS_DEVICE(bdif);
> +    sysbus_mmio_map(bdif_sb, 0, vms->memmap[VMAPPLE_BDOOR].base);
> +
> +    qdev_prop_set_drive(DEVICE(bdif), "aux", blk_by_legacy_dinfo(di_aux));
> +    qdev_prop_set_drive(DEVICE(bdif), "root", blk_by_legacy_dinfo(di_root));
> +
> +    sysbus_realize_and_unref(bdif_sb, &error_fatal);
> +}
> +
> +static void create_pvpanic(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    SysBusDevice *cfg;
> +
> +    vms->cfg = qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
> +    cfg = SYS_BUS_DEVICE(vms->cfg);
> +    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_PVPANIC].base);
> +
> +    sysbus_realize_and_unref(cfg, &error_fatal);
> +}
> +
> +static void create_cfg(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    SysBusDevice *cfg;
> +    MachineState *machine = MACHINE(vms);
> +    uint32_t rnd = 1;
> +
> +    vms->cfg = qdev_new(TYPE_VMAPPLE_CFG);
> +    cfg = SYS_BUS_DEVICE(vms->cfg);
> +    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_CONFIG].base);
> +
> +    qemu_guest_getrandom_nofail(&rnd, sizeof(rnd));
> +
> +    qdev_prop_set_uint32(vms->cfg, "nr-cpus", machine->smp.cpus);
> +    qdev_prop_set_uint64(vms->cfg, "ecid", vms->uuid);
> +    qdev_prop_set_uint64(vms->cfg, "ram-size", machine->ram_size);
> +    qdev_prop_set_uint32(vms->cfg, "rnd", rnd);
> +
> +    sysbus_realize_and_unref(cfg, &error_fatal);
> +}
> +
> +static void create_gfx(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    int irq_gfx = vms->irqmap[VMAPPLE_APV_GFX];
> +    int irq_iosfc = vms->irqmap[VMAPPLE_APV_IOSFC];
> +    SysBusDevice *gfx;
> +
> +    gfx = SYS_BUS_DEVICE(qdev_new("apple-gfx-mmio"));
> +    sysbus_mmio_map(gfx, 0, vms->memmap[VMAPPLE_APV_GFX].base);
> +    sysbus_mmio_map(gfx, 1, vms->memmap[VMAPPLE_APV_IOSFC].base);
> +    sysbus_connect_irq(gfx, 0, qdev_get_gpio_in(vms->gic, irq_gfx));
> +    sysbus_connect_irq(gfx, 1, qdev_get_gpio_in(vms->gic, irq_iosfc));
> +    sysbus_realize_and_unref(gfx, &error_fatal);
> +}
> +
> +static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    int irq = vms->irqmap[VMAPPLE_AES_1];
> +    SysBusDevice *aes;
> +
> +    aes = SYS_BUS_DEVICE(qdev_new(TYPE_APPLE_AES));
> +    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_AES_1].base);
> +    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_AES_2].base);
> +    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq));
> +    sysbus_realize_and_unref(aes, &error_fatal);
> +}
> +
> +static int arm_gic_ppi_index(int cpu_nr, int ppi_index)
> +{
> +    return NUM_IRQS + cpu_nr * GIC_INTERNAL + ppi_index;
> +}
> +
> +static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    /* We create a standalone GIC */
> +    SysBusDevice *gicbusdev;
> +    QList *redist_region_count;
> +    int i;
> +    unsigned int smp_cpus = ms->smp.cpus;
> +
> +    vms->gic = qdev_new(gicv3_class_name());
> +    qdev_prop_set_uint32(vms->gic, "revision", 3);
> +    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
> +    /*
> +     * Note that the num-irq property counts both internal and external
> +     * interrupts; there are always 32 of the former (mandated by GIC spec).
> +     */
> +    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
> +
> +    uint32_t redist0_capacity =
> +                vms->memmap[VMAPPLE_GIC_REDIST].size / GICV3_REDIST_SIZE;
> +    uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
> +
> +    redist_region_count = qlist_new();
> +    qlist_append_int(redist_region_count, redist0_count);
> +    qdev_prop_set_array(vms->gic, "redist-region-count", redist_region_count);
> +
> +    gicbusdev = SYS_BUS_DEVICE(vms->gic);
> +    sysbus_realize_and_unref(gicbusdev, &error_fatal);
> +    sysbus_mmio_map(gicbusdev, 0, vms->memmap[VMAPPLE_GIC_DIST].base);
> +    sysbus_mmio_map(gicbusdev, 1, vms->memmap[VMAPPLE_GIC_REDIST].base);
> +
> +    /*
> +     * Wire the outputs from each CPU's generic timer and the GICv3
> +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
> +     */
> +    for (i = 0; i < smp_cpus; i++) {
> +        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
> +
> +        /* Map the virt timer to PPI 27 */
> +        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
> +                              qdev_get_gpio_in(vms->gic,
> +                                               arm_gic_ppi_index(i, 27)));
> +
> +        /* Map the GIC IRQ and FIQ lines to CPU */
> +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(gicbusdev, i + smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +    }
> +}
> +
> +static void create_uart(const VMAppleMachineState *vms, int uart,
> +                        MemoryRegion *mem, Chardev *chr)
> +{
> +    hwaddr base = vms->memmap[uart].base;
> +    int irq = vms->irqmap[uart];
> +    DeviceState *dev = qdev_new(TYPE_PL011);
> +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    memory_region_add_subregion(mem, base,
> +                                sysbus_mmio_get_region(s, 0));
> +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> +}
> +
> +static void create_rtc(const VMAppleMachineState *vms)
> +{
> +    hwaddr base = vms->memmap[VMAPPLE_RTC].base;
> +    int irq = vms->irqmap[VMAPPLE_RTC];
> +
> +    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
> +}
> +
> +static DeviceState *gpio_key_dev;
> +static void vmapple_powerdown_req(Notifier *n, void *opaque)
> +{
> +    /* use gpio Pin 3 for power button event */
> +    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
> +}
> +
> +static void create_gpio_devices(const VMAppleMachineState *vms, int gpio,
> +                                MemoryRegion *mem)
> +{
> +    DeviceState *pl061_dev;
> +    hwaddr base = vms->memmap[gpio].base;
> +    int irq = vms->irqmap[gpio];
> +    SysBusDevice *s;
> +
> +    pl061_dev = qdev_new("pl061");
> +    /* Pull lines down to 0 if not driven by the PL061 */
> +    qdev_prop_set_uint32(pl061_dev, "pullups", 0);
> +    qdev_prop_set_uint32(pl061_dev, "pulldowns", 0xff);
> +    s = SYS_BUS_DEVICE(pl061_dev);
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0));
> +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> +    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> +                                        qdev_get_gpio_in(pl061_dev, 3));
> +}
> +
> +static void vmapple_firmware_init(VMAppleMachineState *vms,
> +                                  MemoryRegion *sysmem)
> +{
> +    hwaddr size = vms->memmap[VMAPPLE_FIRMWARE].size;
> +    hwaddr base = vms->memmap[VMAPPLE_FIRMWARE].base;
> +    const char *bios_name;
> +    int image_size;
> +    char *fname;
> +
> +    bios_name = MACHINE(vms)->firmware;
> +    if (!bios_name) {
> +        error_report("No firmware specified");
> +        exit(1);
> +    }
> +
> +    fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +    if (!fname) {
> +        error_report("Could not find ROM image '%s'", bios_name);
> +        exit(1);
> +    }
> +
> +    memory_region_init_ram(&vms->fw_mr, NULL, "firmware", size, &error_fatal);
> +    image_size = load_image_mr(fname, &vms->fw_mr);
> +
> +    g_free(fname);
> +    if (image_size < 0) {
> +        error_report("Could not load ROM image '%s'", bios_name);
> +        exit(1);
> +    }
> +
> +    memory_region_add_subregion(get_system_memory(), base, &vms->fw_mr);
> +}
> +
> +static void create_pcie(VMAppleMachineState *vms)
> +{
> +    hwaddr base_mmio = vms->memmap[VMAPPLE_PCIE_MMIO].base;
> +    hwaddr size_mmio = vms->memmap[VMAPPLE_PCIE_MMIO].size;
> +    hwaddr base_ecam = vms->memmap[VMAPPLE_PCIE_ECAM].base;
> +    hwaddr size_ecam = vms->memmap[VMAPPLE_PCIE_ECAM].size;
> +    int irq = vms->irqmap[VMAPPLE_PCIE];
> +    MemoryRegion *mmio_alias;
> +    MemoryRegion *mmio_reg;
> +    MemoryRegion *ecam_reg;
> +    DeviceState *dev;
> +    int i;
> +    PCIHostState *pci;
> +    DeviceState *usb_controller;
> +    USBBus *usb_bus;
> +
> +    dev = qdev_new(TYPE_GPEX_HOST);
> +    qdev_prop_set_uint32(dev, "num-irqs", GPEX_NUM_IRQS);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    /* Map only the first size_ecam bytes of ECAM space */
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(&vms->ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, size_ecam);
> +    memory_region_add_subregion(get_system_memory(), base_ecam,
> +                                &vms->ecam_alias);
> +
> +    /*
> +     * Map the MMIO window from [0x50000000-0x7fff0000] in PCI space into
> +     * system address space at [0x50000000-0x7fff0000].
> +     */
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, base_mmio, size_mmio);
> +    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);
> +
> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> +                           qdev_get_gpio_in(vms->gic, irq + i));
> +        gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> +    }
> +
> +    pci = PCI_HOST_BRIDGE(dev);
> +    vms->bus = pci->bus;
> +    g_assert(vms->bus);
> +
> +    while ((dev = qemu_create_nic_device("virtio-net-pci", true, NULL))) {
> +        qdev_realize_and_unref(dev, BUS(vms->bus), &error_fatal);
> +    }
> +
> +    usb_controller = qdev_new(TYPE_QEMU_XHCI);
> +    qdev_realize_and_unref(usb_controller, BUS(pci->bus), &error_fatal);
> +
> +    usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
> +                                                      &error_fatal));
> +    usb_create_simple(usb_bus, "usb-kbd");
> +    usb_create_simple(usb_bus, "usb-tablet");
> +}
> +
> +static void vmapple_reset(void *opaque)
> +{
> +    VMAppleMachineState *vms = opaque;
> +    hwaddr base = vms->memmap[VMAPPLE_FIRMWARE].base;
> +
> +    cpu_set_pc(first_cpu, base);
> +}
> +
> +static void mach_vmapple_init(MachineState *machine)
> +{
> +    VMAppleMachineState *vms = VMAPPLE_MACHINE(machine);
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const CPUArchIdList *possible_cpus;
> +    MemoryRegion *sysmem = get_system_memory();
> +    int n;
> +    unsigned int smp_cpus = machine->smp.cpus;
> +    unsigned int max_cpus = machine->smp.max_cpus;
> +
> +    vms->memmap = memmap;
> +    machine->usb = true;
> +
> +    possible_cpus = mc->possible_cpu_arch_ids(machine);
> +    assert(possible_cpus->len == max_cpus);
> +    for (n = 0; n < possible_cpus->len; n++) {
> +        Object *cpu;
> +        CPUState *cs;
> +
> +        if (n >= smp_cpus) {
> +            break;
> +        }
> +
> +        cpu = object_new(possible_cpus->cpus[n].type);
> +        object_property_set_int(cpu, "mp-affinity",
> +                                possible_cpus->cpus[n].arch_id, &error_fatal);
> +
> +        cs = CPU(cpu);
> +        cs->cpu_index = n;
> +
> +        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpu),
> +                          &error_fatal);
> +
> +        if (object_property_find(cpu, "has_el3")) {
> +            object_property_set_bool(cpu, "has_el3", false, &error_fatal);
> +        }
> +        if (object_property_find(cpu, "has_el2")) {
> +            object_property_set_bool(cpu, "has_el2", false, &error_fatal);
> +        }
> +        object_property_set_int(cpu, "psci-conduit", QEMU_PSCI_CONDUIT_HVC,
> +                                &error_fatal);
> +
> +        /* Secondary CPUs start in PSCI powered-down state */
> +        if (n > 0) {
> +            object_property_set_bool(cpu, "start-powered-off", true,
> +                                     &error_fatal);
> +        }
> +
> +        object_property_set_link(cpu, "memory", OBJECT(sysmem), &error_abort);
> +        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> +        object_unref(cpu);
> +    }
> +
> +    memory_region_add_subregion(sysmem, vms->memmap[VMAPPLE_MEM].base,
> +                                machine->ram);
> +
> +    create_gic(vms, sysmem);
> +    create_bdif(vms, sysmem);
> +    create_pvpanic(vms, sysmem);
> +    create_aes(vms, sysmem);
> +    create_gfx(vms, sysmem);
> +    create_uart(vms, VMAPPLE_UART, sysmem, serial_hd(0));
> +    create_rtc(vms);
> +    create_pcie(vms);
> +
> +    create_gpio_devices(vms, VMAPPLE_GPIO, sysmem);
> +
> +    vmapple_firmware_init(vms, sysmem);
> +    create_cfg(vms, sysmem);
> +
> +    /* connect powerdown request */
> +    vms->powerdown_notifier.notify = vmapple_powerdown_req;
> +    qemu_register_powerdown_notifier(&vms->powerdown_notifier);
> +
> +    vms->bootinfo.ram_size = machine->ram_size;
> +    vms->bootinfo.board_id = -1;
> +    vms->bootinfo.loader_start = vms->memmap[VMAPPLE_MEM].base;
> +    vms->bootinfo.skip_dtb_autoload = true;
> +    vms->bootinfo.firmware_loaded = true;
> +    arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
> +
> +    qemu_register_reset(vmapple_reset, vms);
> +}
> +
> +static CpuInstanceProperties
> +vmapple_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> +
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;
> +}
> +
> +
> +static int64_t vmapple_get_default_cpu_node_id(const MachineState *ms, int idx)
> +{
> +    return idx % ms->numa_state->num_nodes;
> +}
> +
> +static const CPUArchIdList *vmapple_possible_cpu_arch_ids(MachineState *ms)
> +{
> +    int n;
> +    unsigned int max_cpus = ms->smp.max_cpus;
> +
> +    if (ms->possible_cpus) {
> +        assert(ms->possible_cpus->len == max_cpus);
> +        return ms->possible_cpus;
> +    }
> +
> +    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
> +                                  sizeof(CPUArchId) * max_cpus);
> +    ms->possible_cpus->len = max_cpus;
> +    for (n = 0; n < ms->possible_cpus->len; n++) {
> +        ms->possible_cpus->cpus[n].type = ms->cpu_type;
> +        ms->possible_cpus->cpus[n].arch_id =
> +            arm_build_mp_affinity(n, GICV3_TARGETLIST_BITS);
> +        ms->possible_cpus->cpus[n].props.has_thread_id = true;
> +        ms->possible_cpus->cpus[n].props.thread_id = n;
> +    }
> +    return ms->possible_cpus;
> +}
> +
> +static void vmapple_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->init = mach_vmapple_init;
> +    mc->max_cpus = 32;
> +    mc->block_default_type = IF_VIRTIO;
> +    mc->no_cdrom = 1;
> +    mc->pci_allow_0_address = true;
> +    mc->minimum_page_bits = 12;
> +    mc->possible_cpu_arch_ids = vmapple_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props = vmapple_cpu_index_to_props;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("host");
> +    mc->get_default_cpu_node_id = vmapple_get_default_cpu_node_id;
> +    mc->default_ram_id = "mach-vmapple.ram";
> +
> +    object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy",
> +                               "on", true);
> +}
> +
> +static void vmapple_instance_init(Object *obj)
> +{
> +    VMAppleMachineState *vms = VMAPPLE_MACHINE(obj);
> +
> +    vms->irqmap = irqmap;
> +
> +    object_property_add_uint64_ptr(obj, "uuid", &vms->uuid,
> +                                   OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_description(obj, "uuid", "Machine UUID (SDOM)");
> +}
> +
> +static const TypeInfo vmapple_machine_info = {
> +    .name          = TYPE_VMAPPLE_MACHINE,
> +    .parent        = TYPE_MACHINE,
> +    .abstract      = true,
> +    .instance_size = sizeof(VMAppleMachineState),
> +    .class_size    = sizeof(VMAppleMachineClass),
> +    .class_init    = vmapple_machine_class_init,
> +    .instance_init = vmapple_instance_init,
> +};
> +
> +static void machvmapple_machine_init(void)
> +{
> +    type_register_static(&vmapple_machine_info);
> +}
> +type_init(machvmapple_machine_init);
> +
> +static void vmapple_machine_9_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VMAPPLE_MACHINE_AS_LATEST(9, 2)
> +


