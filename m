Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204DFCF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 06:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swy1L-0007lY-NS; Sat, 05 Oct 2024 02:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swy1J-0007kC-U9
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 02:12:01 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swy1D-000144-IM
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 02:12:01 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e221a7e7baso27656a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 23:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728108714; x=1728713514;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+WWVvbVhBI6ziqtDFWimf845KFLinwDoWCR2xUYflec=;
 b=1K/3PD/ktULmR9XSwKV9gOVQnp+NEa+OcOmtFO5yHzZufrLf3fLe2SfnUj/1h4fEYH
 /l9wo7AjyOM8RrIcxV2eQRqLsSDDvEc4WLQG+K4o5Dx6vyFEjHaZy7WvpdF3bz/qaIj/
 FIxeBS7yCByw0k1Cm4cZQpFtOx3SMviAIMmlLxb82uWRSoVKq2F5wcHHfYNFhXkPbuq+
 JdSRpkGg7Ub99xLLu1ok/mrIIQSrD2wAiXqYCF5YhYRGe1LiTaROC6VNv5OlBhHGLPrx
 lmzE9O6R+1f00zz6q3qTnlPgneG6v6TeEYUz37pbObQ0U+BbatauwcHnTuUoXHfND4fm
 q/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728108714; x=1728713514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+WWVvbVhBI6ziqtDFWimf845KFLinwDoWCR2xUYflec=;
 b=k2IfykO7lW7CzXQo85oG8x3mtagEOxsxmUU/GPQ6tiQLqcSKvUGkHR9Lk3b+X0JBys
 iTNkGZ0pGm6yWutIAI8U4umxsUhC6eF14xkkc30larEbzrdYJ/9+GLPclGuYqQvRNDBH
 /ysKVUDQ0zurT88w9E8LVsS8YSwIkZEk/1w7r4tbiq7UzhUNYaOCUVyUfOtvKT99rbj6
 y/QsuIaP9U9gTLaaaLDHw5s45CASQRme6AFEq35lC2EWDHlQUxC5i3MI78XYmPnQ6u4O
 9lYOBkDASNih+hJHTuqouylteTrHg38NE+s6+W1w//Vhr3Wp64KyLtM625eRxo1lWEeY
 DhOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+mTY0CrnfHrgbnZC1zEksYVZv90Q9V6faZqX5WEk1EADmYSxhshyJj1khqjSq3Bgi8+1ZIKn5/bzo@nongnu.org
X-Gm-Message-State: AOJu0YzpBWA90/Vky6+f4kKrtM44y/TFLu1hs7Dnqx16SLqB7PBFDU3w
 mOkwef7QJnwcoIjYrt5GRlEf+CrSagPOFrZK5/gajouTZUd2TPxYYfcXJlnFwCo=
X-Google-Smtp-Source: AGHT+IHpT5Y84G1dlCD4oFVWD5soQ/YwrjaGX8LvgLE9tpJIfzQG9Bw+KefatZmHJJt+esz93yfDSg==
X-Received: by 2002:a17:90a:17e3:b0:2d3:c87e:b888 with SMTP id
 98e67ed59e1d1-2e1e636f481mr6314478a91.27.1728108713791; 
 Fri, 04 Oct 2024 23:11:53 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e85c8f14sm2771273a91.20.2024.10.04.23.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 23:11:53 -0700 (PDT)
Message-ID: <80274a57-84e8-4499-b09d-d829aca2a5c2@daynix.com>
Date: Sat, 5 Oct 2024 15:11:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] hw/vmapple/vmapple: Add vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-15-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240928085727.56883-15-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
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

On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
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
> 
> ---
> v3:
>   * Rebased on latest upstream, updated affinity and NIC creation
> API usage
>   * Included Apple-variant virtio-blk in build dependency
>   * Updated API usage for setting 'redist-region-count' array-typed property on GIC.
>   * Switched from virtio HID devices (for which macOS 12 does not contain drivers) to an XHCI USB controller and USB HID devices.
> 
>   MAINTAINERS                 |   1 +
>   docs/system/arm/vmapple.rst |  63 ++++
>   docs/system/target-arm.rst  |   1 +
>   hw/vmapple/Kconfig          |  20 ++
>   hw/vmapple/meson.build      |   1 +
>   hw/vmapple/vmapple.c        | 661 ++++++++++++++++++++++++++++++++++++
>   6 files changed, 747 insertions(+)
>   create mode 100644 docs/system/arm/vmapple.rst
>   create mode 100644 hw/vmapple/vmapple.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e7f25e5299..89ef071a01a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2783,6 +2783,7 @@ R: Phil Dennis-Jordan <phil@philjordan.eu>
>   S: Maintained
>   F: hw/vmapple/*
>   F: include/hw/vmapple/*
> +F: docs/system/arm/vmapple.rst
>   
>   Subsystems
>   ----------
> diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
> new file mode 100644
> index 00000000000..acb921ffb35
> --- /dev/null
> +++ b/docs/system/arm/vmapple.rst
> @@ -0,0 +1,63 @@
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
> +
> +First, we need to extract the UUID from the virtual machine that you installed. You can do this
> +by running the following shell script:
> +
> +.. code-block:: bash
> +  :caption: uuid.sh script to extract the UUID from a macosvm.json file
> +
> +  #!/bin/bash
> +
> +  MID=$(cat "$1" | python3 -c 'import json,sys;obj=json.load(sys.stdin);print(obj["machineId"]);')
> +  echo "$MID" | base64 -d | plutil -extract ECID raw -
> +
> +Now we also need to trim the aux partition. It contains metadata that we can just discard:
> +
> +.. code-block:: bash
> +  :caption: Command to trim the aux file
> +
> +  $ dd if="aux.img" of="aux.img.trimmed" bs=$(( 0x4000 )) skip=1
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
> +        -drive file="$AUX",if=pflash,format=raw \
> +        -drive file="$DISK",if=pflash,format=raw \
> +       -drive file="$AUX",if=none,id=aux,format=raw \
> +       -drive file="$DISK",if=none,id=root,format=raw \
> +       -device vmapple-virtio-aux,drive=aux \
> +       -device vmapple-virtio-root,drive=root \
> +       -net user,ipv6=off,hostfwd=tcp::2222-:22,hostfwd=tcp::5901-:5900 \
> +       -net nic,model=virtio-net-pci \
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 7b992722846..f1948abb545 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -107,6 +107,7 @@ undocumented; you can get a complete list by running
>      arm/stellaris
>      arm/stm32
>      arm/virt
> +   arm/vmapple
>      arm/xenpvh
>      arm/xlnx-versal-virt
>      arm/xlnx-zynq
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index bcd1be63e3c..0f83d4259fc 100644
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
> +    select MAC_PVG_VMAPPLE
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
> index 00000000000..f0060a6f7ee
> --- /dev/null
> +++ b/hw/vmapple/vmapple.c
> @@ -0,0 +1,661 @@
> +/*
> + * VMApple machine emulation
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * VMApple is the device model that the macOS built-in hypervisor called
> + * "Virtualization.framework" exposes to Apple Silicon macOS guests. The
> + * machine model in this file implements the same device model in QEMU, but
> + * does not use any code from Virtualization.Framework.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/help-texts.h"
> +#include "qemu/datadir.h"
> +#include "qemu/units.h"
> +#include "qemu/option.h"
> +#include "monitor/qdev.h"
> +#include "hw/sysbus.h"
> +#include "hw/arm/boot.h"
> +#include "hw/arm/primecell.h"
> +#include "hw/boards.h"
> +#include "hw/usb.h"
> +#include "net/net.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/runstate.h"
> +#include "sysemu/kvm.h"
> +#include "sysemu/hvf.h"
> +#include "hw/loader.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qlist.h"
> +#include "qemu/bitops.h"
> +#include "qemu/error-report.h"
> +#include "qemu/module.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/intc/arm_gic.h"
> +#include "hw/intc/arm_gicv3_common.h"
> +#include "hw/irq.h"
> +#include "hw/usb/xhci.h"
> +#include "qapi/visitor.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "standard-headers/linux/input.h"
> +#include "target/arm/internals.h"
> +#include "target/arm/kvm_arm.h"
> +#include "hw/char/pl011.h"
> +#include "qemu/guest-random.h"
> +#include "sysemu/reset.h"
> +#include "qemu/log.h"
> +#include "hw/vmapple/cfg.h"
> +#include "hw/misc/pvpanic.h"
> +#include "hw/vmapple/bdif.h"
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
> +        error_report("No AUX device found. Please specify one as pflash drive");
> +        exit(1);
> +    }
> +
> +    if (!di_root) {
> +        /* Fall back to the first IF_VIRTIO device as root device */
> +        di_root = drive_get(IF_VIRTIO, 0, 0);
> +    }
> +
> +    if (!di_root) {
> +        error_report("No root device found. Please specify one as virtio drive");
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
> +    SysBusDevice *aes;
> +
> +    aes = SYS_BUS_DEVICE(qdev_new("apple-gfx-vmapple"));
> +    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_APV_GFX].base);
> +    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_APV_IOSFC].base);
> +    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq_gfx));
> +    sysbus_connect_irq(aes, 1, qdev_get_gpio_in(vms->gic, irq_iosfc));
> +    sysbus_realize_and_unref(aes, &error_fatal);
> +}
> +
> +static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    int irq = vms->irqmap[VMAPPLE_AES_1];
> +    SysBusDevice *aes;
> +
> +    aes = SYS_BUS_DEVICE(qdev_new("apple-aes"));
> +    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_AES_1].base);
> +    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_AES_2].base);
> +    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq));
> +    sysbus_realize_and_unref(aes, &error_fatal);
> +}
> +
> +static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
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
> +    memory_region_init_ram(&vms->fw_mr, NULL, "firmware", size, NULL);

Pass: &error_fatal

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
> +    MemoryRegion *ecam_alias;
> +    MemoryRegion *ecam_reg;
> +    DeviceState *dev;
> +    int i;
> +    PCIHostState *pci;
> +    DeviceState *usb_controller;
> +    USBBus *usb_bus;
> +
> +    dev = qdev_new(TYPE_GPEX_HOST);
> +    qdev_prop_set_uint32(dev, "nr-irqs", GPEX_NUM_IRQS);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    /* Map only the first size_ecam bytes of ECAM space */
> +    ecam_alias = g_new0(MemoryRegion, 1);
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, size_ecam);
> +    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
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
> +    g_assert_nonnull(vms->bus);
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
> +                                possible_cpus->cpus[n].arch_id, NULL);
> +
> +        cs = CPU(cpu);
> +        cs->cpu_index = n;
> +
> +        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpu),
> +                          &error_fatal);
> +
> +        object_property_set_bool(cpu, "has_el3", false, NULL);
> +        object_property_set_bool(cpu, "has_el2", false, NULL);
> +        object_property_set_int(cpu, "psci-conduit", QEMU_PSCI_CONDUIT_HVC,
> +                                NULL);
> +
> +        /* Secondary CPUs start in PSCI powered-down state */
> +        if (n > 0) {
> +            object_property_set_bool(cpu, "start-powered-off", true, NULL);
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
> +static void vmapple_get_uuid(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    VMAppleMachineState *vms = VMAPPLE_MACHINE(obj);
> +    uint64_t value = be64_to_cpu(vms->uuid);
> +
> +    visit_type_uint64(v, name, &value, errp);
> +}
> +
> +static void vmapple_set_uuid(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    VMAppleMachineState *vms = VMAPPLE_MACHINE(obj);
> +    Error *error = NULL;
> +    uint64_t value;
> +
> +    visit_type_uint64(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    vms->uuid = cpu_to_be64(value);
> +}

vmapple converts the value to big endian here and vmapple-cfg converts 
it back later. What's the intention?

 > +> +static void vmapple_machine_class_init(ObjectClass *oc, void *data)
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
> +    if (hvf_enabled()) {
> +        mc->default_cpu_type = ARM_CPU_TYPE_NAME("host");
> +    } else {
> +        mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
> +    }

Remove this conditional. VMApple only works with the host model.

(I wonder if this works on KVM on Asahi Linux by the way. 
apple-gfx-vmapple won't work, but perhaps anything else may just work.)

> +    mc->get_default_cpu_node_id = vmapple_get_default_cpu_node_id;
> +    mc->default_ram_id = "mach-vmapple.ram";
> +
> +    object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy",
> +                               "on", true);
> +
> +    object_class_property_add(oc, "uuid", "uint64", vmapple_get_uuid,
> +                              vmapple_set_uuid, NULL, NULL);
> +    object_class_property_set_description(oc, "uuid", "Machine UUID (SDOM)");
> +}
> +
> +static void vmapple_instance_init(Object *obj)
> +{
> +    VMAppleMachineState *vms = VMAPPLE_MACHINE(obj);
> +
> +    vms->irqmap = irqmap;
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
> +static void vmapple_machine_8_1_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VMAPPLE_MACHINE_AS_LATEST(8, 1)

Please update this.

> +


