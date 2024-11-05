Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693A7D12663
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 08:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8EsZ-0001Is-IM; Tue, 05 Nov 2024 03:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8EsX-0001IB-Hy
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 03:25:33 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8EsV-0005qR-LT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 03:25:33 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7206304f93aso4887596b3a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 00:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730795130; x=1731399930;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rNh009aKx4OQggTSCRDPYcuSvWplYhkBYwV9qbWJEvc=;
 b=wK97VusHRpAerF64WCCyB38kcv5VHxUdZjR6IclBOuJGyyCdLUFdPfYStQGfXBj1XP
 m9sfQThEHCgGtp/WUYAMJGY/fgLTeMQ84M0IzBHes7Onn25+4zPkwrMQUeyYLtHk0bpC
 bpB6jYfP/gbdIxg+lgPomHmLclIuGvSLqtzZ41xjbD5d3JNtz822tdMOQjM76q9bAsRB
 ugaVTLXK7SfXB/ufFp6pUMLe+M/3ahOy+4otnjWz/288Jwbzj8fU9L6LLcjEO2I6uCr0
 jywjpWy8G8tz+Wf+NquClPbnOKou4/BIFXsCOM+nbozoHbbcp5Gf5Jk1pdvGxjtokCit
 d5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730795130; x=1731399930;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rNh009aKx4OQggTSCRDPYcuSvWplYhkBYwV9qbWJEvc=;
 b=n9/wP/gT/7KQ2uP+vr4uy+KtbGvoF0tOOfXmDsmkbxbl3LtezXGibYRcVcK8Ig+bVk
 RAba7ct+jfSFCiNrG0ZTI+dy0c/nvMwwGCT34NJKsNPb0rk8w8VrroI0R+A6Npd+Y8DV
 0COQ1LE7pBzVNwsH7ysheg7/RD9Px8XZXpMK94+tOInB01V26ezu7IA/8vciosLSwxjl
 2el3uQbphZzpWKNnuUdmMrVHLn5EDIMbDnqNSL5/941JXaMvZaXrdPTecqTqokO1PqgX
 70K9rw8LrsLXgkQPY5Jt8DjdW4zaUyPFQiWnyLXmsZ724h4RsKEXo+8DLPyKHY5oTGp4
 3ryg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAmXsznjQvcYuoQNBM2LOP83vKChONOu4tH52Kp50ZnUKy1gWdomsg7Dy0gxZZHOSFQtKsG/Kdszpe@nongnu.org
X-Gm-Message-State: AOJu0Ywv90WOCUYQY+lHyWmtJxaBx67WXJCUFSA1s1twQc0j9GNHRlUE
 MZwf89fmWrcINzeCp2abFbEl89cjx5YNbg/+NN+0rjRvFGRSQWMG47LwoP4ktwE=
X-Google-Smtp-Source: AGHT+IGOVEEEjnQV2fYOysiNqqa9fZAREe5ZP2XC/CR8qSweN4komjbDQnbypC6kkVvRtdCP1cFOHQ==
X-Received: by 2002:a05:6a21:38f:b0:1d9:2994:ca2b with SMTP id
 adf61e73a8af0-1dba53001d9mr20597295637.19.1730795130205; 
 Tue, 05 Nov 2024 00:25:30 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93daacb29sm9145520a91.14.2024.11.05.00.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 00:25:29 -0800 (PST)
Message-ID: <8f35e1c9-4633-4ef5-83e1-fead4368255f@daynix.com>
Date: Tue, 5 Nov 2024 17:25:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/15] hw/display/apple-gfx: Adds PCI implementation
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
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20241103150037.48194-1-phil@philjordan.eu>
 <20241103150037.48194-4-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241103150037.48194-4-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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

On 2024/11/04 0:00, Phil Dennis-Jordan wrote:
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
>   hw/display/Kconfig         |   4 +
>   hw/display/apple-gfx-pci.m | 149 +++++++++++++++++++++++++++++++++++++
>   hw/display/meson.build     |   1 +
>   3 files changed, 154 insertions(+)
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
> index 00000000000..870d0c41e66
> --- /dev/null
> +++ b/hw/display/apple-gfx-pci.m
> @@ -0,0 +1,149 @@
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
> +static void apple_gfx_pci_interrupt(PCIDevice *dev, AppleGFXPCIState *s,

s is not used.

> +                                    uint32_t vector)
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
> +    if (ret != 0) {
> +        return;
> +    }
> +
> +    @autoreleasepool {
> +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
> +        desc.raiseInterrupt = ^(uint32_t vector) {
> +            apple_gfx_pci_interrupt(dev, s, vector);
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


