Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9594D5E39D
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 06:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA1p5-0000LH-Ew; Sun, 10 Nov 2024 01:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tA1p3-0000Ks-My
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 01:53:21 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tA1p1-0004BK-RN
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 01:53:21 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cbca51687so34975595ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 22:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731221598; x=1731826398;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oLdydJGsMMyuN9iZ/4SqzcEOlt77Kx/ZB6Fk6Jo1sx4=;
 b=io9D7Cnw8063PhEoHj18rqSCebrJndAu9qCt9S4koNla/LJW2hym3jmZ2knIo6lS+8
 et+fi3HjSZGmikHTUvX8e2XN0MtKmGYBQCKZnX+gmRp0dN+rX1DjjU0HLX7VjAmxuzwS
 nTK2xVkrKV6FspfLTeNTn4ItcPgzXA/j/7yTLex05fgwaGzqGv5+vBPnpHuIgnePEmZZ
 01BynigkQiBj8ArD1oSDEO85xd4LI6j4ZYXshkDbLW/0VEog9SeHOxWVr2jzrDUvwbt2
 9fQtePQqius4xInXhOC4gjWiWP5P8L967EUtJHD6/kPK4WWAoJFf3DZ4AyrWp0UBI0RU
 xiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731221598; x=1731826398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oLdydJGsMMyuN9iZ/4SqzcEOlt77Kx/ZB6Fk6Jo1sx4=;
 b=I45TyE5RopVWC+WZ2MIxMdqJT6Rwl6cX6xBm6sd6TQQy/jmGQN00BPmFy0HAmGNOLp
 NdhWiJOHVjvaoWEoCMJEvTVYPONg0tgVM/FmKlRV4CK21otxgVGkkJFQosPrUi5tb/fs
 ukWIxu9r2gMRo7/qEIPaMDM6OE5YvikhydVMBok+Shxa2bY+UNCbFelF2AMt4iq+fOmx
 CLiKn9tx5Aa5OTVwidcEYYYOOKuRVaFq+IObPk+3+iTyY64ASwdjTlrnP2U8nJSBtdho
 NZN6jyWkQTzvuZ9opvQmGMpvqfLE/2PwGab4qj62EGpD0+JM7m/q/ZmchsMJTWzxt2UV
 dSqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7p3Iuy5w4T3v6hwh6Xg/dmbjW9fTRL9xf+du/N8/CxntTVz7IE9cx+N//ELyVi3uamEVHD+WW+zHo@nongnu.org
X-Gm-Message-State: AOJu0YwWXkzYix6XUCYb7e9Go2xnnrnWc3Vc6Wa+iDU9DQ0engGD5FLN
 20eXoXtOK4Dhk+PE9fjIiOG1/eXrlZH4uEwnYUYlfsYryuRJahIWcTzGHt9A1Ao=
X-Google-Smtp-Source: AGHT+IH3/MI3VOt4Q8ZZfqyLj+AvEcLJjy/PR/qAkVvkVvq1FvUjKeC4biodk3Z3Esi82KB2mAJOmQ==
X-Received: by 2002:a17:902:cec7:b0:20b:b40b:3454 with SMTP id
 d9443c01a7336-21183327a44mr117626975ad.0.1731221598458; 
 Sat, 09 Nov 2024 22:53:18 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e580easm55134335ad.180.2024.11.09.22.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 22:53:18 -0800 (PST)
Message-ID: <39b526be-7ef8-493c-9e1e-50f5f46396d4@daynix.com>
Date: Sun, 10 Nov 2024 15:53:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/15] hw/display/apple-gfx: Adds PCI implementation
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
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-4-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241108144709.95498-4-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/11/08 23:46, Phil Dennis-Jordan wrote:
> This change wires up the PCI variant of the paravirtualised
> graphics device, mainly useful for x86-64 macOS guests, implemented
> by macOS's ParavirtualizedGraphics.framework. It builds on code
> shared with the vmapple/mmio variant of the PVG device.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
> 
> v4:
> 
>   * Threading improvements analogous to those in common apple-gfx code
>     and mmio device variant.
>   * Smaller code review issues addressed.
> 
> v5:
> 
>   * Minor error handling improvement.
> 
> v6:
> 
>   * Removed an unused function parameter.
> 
>   hw/display/Kconfig         |   4 +
>   hw/display/apple-gfx-pci.m | 148 +++++++++++++++++++++++++++++++++++++
>   hw/display/meson.build     |   1 +
>   3 files changed, 153 insertions(+)
>   create mode 100644 hw/display/apple-gfx-pci.m
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 6a9b7b19ada..2b53dfd7d26 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -149,3 +149,7 @@ config MAC_PVG_MMIO
>       bool
>       depends on MAC_PVG && AARCH64
>   
> +config MAC_PVG_PCI
> +    bool
> +    depends on MAC_PVG && PCI
> +    default y if PCI_DEVICES
> diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
> new file mode 100644
> index 00000000000..8bd7c0df443
> --- /dev/null
> +++ b/hw/display/apple-gfx-pci.m
> @@ -0,0 +1,148 @@
> +/*
> + * QEMU Apple ParavirtualizedGraphics.framework device, PCI variant
> + *
> + * Copyright © 2023-2024 Phil Dennis-Jordan
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * ParavirtualizedGraphics.framework is a set of libraries that macOS provides
> + * which implements 3d graphics passthrough to the host as well as a
> + * proprietary guest communication channel to drive it. This device model
> + * implements support to drive that library from within QEMU as a PCI device
> + * aimed primarily at x86-64 macOS VMs.
> + */
> +
> +#include "apple-gfx.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/pci/msi.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXPCIState, APPLE_GFX_PCI)
> +
> +struct AppleGFXPCIState {
> +    PCIDevice parent_obj;
> +
> +    AppleGFXState common;
> +};
> +
> +static const char* apple_gfx_pci_option_rom_path = NULL;
> +
> +static void apple_gfx_init_option_rom_path(void)
> +{
> +    NSURL *option_rom_url = PGCopyOptionROMURL();
> +    const char *option_rom_path = option_rom_url.fileSystemRepresentation;
> +    apple_gfx_pci_option_rom_path = g_strdup(option_rom_path);
> +    [option_rom_url release];
> +}
> +
> +static void apple_gfx_pci_init(Object *obj)
> +{
> +    AppleGFXPCIState *s = APPLE_GFX_PCI(obj);
> +
> +    if (!apple_gfx_pci_option_rom_path) {
> +        /* The following is done on device not class init to avoid running
> +         * ObjC code before fork() in -daemonize mode. */
> +        PCIDeviceClass *pci = PCI_DEVICE_CLASS(object_get_class(obj));
> +        apple_gfx_init_option_rom_path();
> +        pci->romfile = apple_gfx_pci_option_rom_path;
> +    }
> +
> +    apple_gfx_common_init(obj, &s->common, TYPE_APPLE_GFX_PCI);
> +}
> +
> +typedef struct AppleGFXPCIInterruptJob {
> +    PCIDevice *device;
> +    uint32_t vector;
> +} AppleGFXPCIInterruptJob;
> +
> +static void apple_gfx_pci_raise_interrupt(void *opaque)
> +{
> +    AppleGFXPCIInterruptJob *job = opaque;
> +
> +    if (msi_enabled(job->device)) {
> +        msi_notify(job->device, job->vector);
> +    }
> +    g_free(job);
> +}
> +
> +static void apple_gfx_pci_interrupt(PCIDevice *dev, uint32_t vector)
> +{
> +    AppleGFXPCIInterruptJob *job;
> +
> +    trace_apple_gfx_raise_irq(vector);
> +    job = g_malloc0(sizeof(*job));
> +    job->device = dev;
> +    job->vector = vector;
> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                            apple_gfx_pci_raise_interrupt, job);
> +}
> +
> +static void apple_gfx_pci_realize(PCIDevice *dev, Error **errp)
> +{
> +    AppleGFXPCIState *s = APPLE_GFX_PCI(dev);
> +    int ret;
> +
> +    pci_register_bar(dev, PG_PCI_BAR_MMIO,
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY, &s->common.iomem_gfx);
> +
> +    ret = msi_init(dev, 0x0 /* config offset; 0 = find space */,
> +                   PG_PCI_MAX_MSI_VECTORS, true /* msi64bit */,
> +                   false /*msi_per_vector_mask*/, errp);

Let's add whitespaces around msi_per_vector_mask for consistency:
/* msi_per_vector_mask */

> +    if (ret != 0) {
> +        return;
> +    }
> +
> +    @autoreleasepool {
> +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
> +        desc.raiseInterrupt = ^(uint32_t vector) {
> +            apple_gfx_pci_interrupt(dev, vector);
> +        };
> +
> +        apple_gfx_common_realize(&s->common, desc, errp);
> +        [desc release];
> +        desc = nil;
> +    }
> +}
> +
> +static void apple_gfx_pci_reset(Object *obj, ResetType type)
> +{
> +    AppleGFXPCIState *s = APPLE_GFX_PCI(obj);
> +    [s->common.pgdev reset];
> +}
> +
> +static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pci = PCI_DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.hold = apple_gfx_pci_reset;
> +    dc->desc = "macOS Paravirtualized Graphics PCI Display Controller";
> +    dc->hotpluggable = false;
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +
> +    pci->vendor_id = PG_PCI_VENDOR_ID;
> +    pci->device_id = PG_PCI_DEVICE_ID;
> +    pci->class_id = PCI_CLASS_DISPLAY_OTHER;
> +    pci->realize = apple_gfx_pci_realize;
> +
> +    // TODO: Property for setting mode list
> +}
> +
> +static TypeInfo apple_gfx_pci_types[] = {
> +    {
> +        .name          = TYPE_APPLE_GFX_PCI,
> +        .parent        = TYPE_PCI_DEVICE,
> +        .instance_size = sizeof(AppleGFXPCIState),
> +        .class_init    = apple_gfx_pci_class_init,
> +        .instance_init = apple_gfx_pci_init,
> +        .interfaces = (InterfaceInfo[]) {
> +            { INTERFACE_PCIE_DEVICE },
> +            { },
> +        },
> +    }
> +};
> +DEFINE_TYPES(apple_gfx_pci_types)
> +
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 619e642905a..78e1c41ea0a 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -65,6 +65,7 @@ system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: [files('apple-gfx.m'), pv
>   if cpu == 'aarch64'
>     system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: [files('apple-gfx-mmio.m'), pvg, metal])
>   endif
> +system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx-pci.m'), pvg, metal])
>   
>   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>     virtio_gpu_ss = ss.source_set()


