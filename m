Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74F4CEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveYK-000533-3O; Tue, 01 Oct 2024 11:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sveYI-00052r-Mu
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:12:38 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sveYE-0002Qi-ID
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:12:38 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-50792ed3b0bso1159625e0c.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727795553; x=1728400353;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p0Aup5XqRstI3xr6iG/dcVRd55UaTvfcE4UXS8J3z9k=;
 b=z00680dnkcKb1lKnXnO0xnUAfK35tqyIFOV5eNPdhFDX9LceJEpRO7kBDaDUC6s42Q
 Lh1ehI2ZmzcaAHjv52NlpBQQ0JdTqeCm8K2nwOAjk6tSLeZpdJL1kTmr4JjkOeOWO14v
 jkA/gIsUks+h/N4964FThRLsfSIc/qwr3eO/aEbBBW1YHDR+HunnlcoS+mUhdOy8Kf/G
 pj76hS6XiUqs8TPEh3aQyEac/2wrMvb2EISKU0pb4VOtuNmtEvMky/YXMthJd4dwk5Iy
 BduRDy5eC1KojBBR+Si5nZKFSLTPdW/HOKYez/ZKVKOVNbtgvyPeFPyFCrzNM+YqveU+
 RKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727795553; x=1728400353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0Aup5XqRstI3xr6iG/dcVRd55UaTvfcE4UXS8J3z9k=;
 b=epmT8Pk5yttvNT1MoGirKXG3/hcpqDIS+vFq2/pYcR06dHr24JC+45WNXa/plCTykw
 45gECESvciRKzdmrjX7R85dDSKHC1Xg8G4tgxZh17V2nHnUGWra33tXTg6Ip4ryp7kDw
 R01XLHx+o6PyHv2EzFcRuvnmFyPL/kZn6SBWewItoimC4jDt/dijcHQpDzVJR7ipKguH
 5NigN51e8RsjZFeHp5lyB7FfAMeI5Ppc85BJ/0NQG8oqurHrumfMAmQhvh/sK+6cEPPL
 NKyDv8rdg5lA0m1Ny6tGHgYgKha6Rc8Dmpk3sZ8NgXfgolHFiA+FQWyKc5UJ7eDl8c8F
 bLyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCq6hdNk2CurZyMTiw8KCOnGH5chFWpK5uUgu3ToJ6sq5ug6hAD6WwkFp8weAzBp0VdfURqsoA8YMY@nongnu.org
X-Gm-Message-State: AOJu0YwdCblPMliwfHeea8nPJrOX5RKAXCbX9OOnLgdNm0z1kJ+qPrRs
 VdNjhlFa/VT8N2ZqHP27rNG6tKAVeCjGxOtSQLlZqMTYw+B7hC6Uxy8k6dUDnNSyWFbTJzBzw4U
 csYA=
X-Google-Smtp-Source: AGHT+IElP4m+XnIVO/R1KiCt0nl8NbUs7RkUiIAIRbVGyropEeY3eYeIfSh9EaRUqkUmpHIgMkf18g==
X-Received: by 2002:a05:6a21:58d:b0:1d5:1260:fafa with SMTP id
 adf61e73a8af0-1d51260fda8mr10067911637.50.1727775653951; 
 Tue, 01 Oct 2024 02:40:53 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b26516771sm7630981b3a.108.2024.10.01.02.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 02:40:53 -0700 (PDT)
Message-ID: <7f3a1a60-a2f3-433c-8f2e-a2dfe0afdcb5@daynix.com>
Date: Tue, 1 Oct 2024 18:40:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
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
 <20240928085727.56883-2-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240928085727.56883-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-vk1-xa2b.google.com
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
> MacOS provides a framework (library) that allows any vmm to implement a
> paravirtualized 3d graphics passthrough to the host metal stack called
> ParavirtualizedGraphics.Framework (PVG). The library abstracts away
> almost every aspect of the paravirtualized device model and only provides
> and receives callbacks on MMIO access as well as to share memory address
> space between the VM and PVG.
> 
> This patch implements a QEMU device that drives PVG for the VMApple
> variant of it.

I think it is better to name it MMIO variant instead of VMApple. There 
is nothing specific to VMApple in: hw/display/apple-gfx-vmapple.m

> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-authored-by: Alexander Graf <graf@amazon.com>
> 
> Subsequent changes:
> 
>   * Cherry-pick/rebase conflict fixes
>   * BQL function renaming
>   * Moved from hw/vmapple/ (useful outside that machine type)
>   * Code review comments: Switched to DEFINE_TYPES macro & little endian
>     MMIO.
>   * Removed some dead/superfluous code
>   * Mad set_mode thread & memory safe
>   * Added migration blocker due to lack of (de-)serialisation.
>   * Fixes to ObjC refcounting and autorelease pool usage.
>   * Fixed ObjC new/init misuse
>   * Switched to ObjC category extension for private property.
>   * Simplified task memory mapping and made it thread safe.
>   * Refactoring to split generic and vmapple MMIO variant specific
>     code.
>   * Switched to asynchronous MMIO writes on x86-64
>   * Rendering and graphics update are now done asynchronously
>   * Fixed cursor handling
>   * Coding convention fixes
>   * Removed software cursor compositing
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> 
> ---
> 
> v3:
> 
>   * Rebased on latest upstream, fixed breakages including switching to Resettable methods.
>   * Squashed patches dealing with dGPUs, MMIO area size, and GPU picking.
>   * Allow re-entrant MMIO; this simplifies the code and solves the divergence
>     between x86-64 and arm64 variants.
> 
>   hw/display/Kconfig             |   9 +
>   hw/display/apple-gfx-vmapple.m | 215 +++++++++++++
>   hw/display/apple-gfx.h         |  57 ++++
>   hw/display/apple-gfx.m         | 536 +++++++++++++++++++++++++++++++++
>   hw/display/meson.build         |   2 +
>   hw/display/trace-events        |  26 ++
>   meson.build                    |   4 +
>   7 files changed, 849 insertions(+)
>   create mode 100644 hw/display/apple-gfx-vmapple.m
>   create mode 100644 hw/display/apple-gfx.h
>   create mode 100644 hw/display/apple-gfx.m
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index a4552c8ed78..179a479d220 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -143,3 +143,12 @@ config XLNX_DISPLAYPORT
>   
>   config DM163
>       bool
> +
> +config MAC_PVG
> +    bool
> +    default y
> +
> +config MAC_PVG_VMAPPLE
> +    bool
> +    depends on MAC_PVG
> +    depends on ARM

Use AARCH64 instead.

> diff --git a/hw/display/apple-gfx-vmapple.m b/hw/display/apple-gfx-vmapple.m
> new file mode 100644
> index 00000000000..d8fc7651dde
> --- /dev/null
> +++ b/hw/display/apple-gfx-vmapple.m
> @@ -0,0 +1,215 @@
> +/*
> + * QEMU Apple ParavirtualizedGraphics.framework device, vmapple (arm64) variant
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * ParavirtualizedGraphics.framework is a set of libraries that macOS provides
> + * which implements 3d graphics passthrough to the host as well as a
> + * proprietary guest communication channel to drive it. This device model
> + * implements support to drive that library from within QEMU as an MMIO-based
> + * system device for macOS on arm64 VMs.
> + */
> +
> +#include "apple-gfx.h"
> +#include "monitor/monitor.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +#include "trace.h"
> +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> +
> +_Static_assert(__aarch64__, "");

I don't think this assertion is worthwhile. This assertion will trigger 
if you accidentally remove depends on AARCH64 from Kconfig, but I don't 
think such code change happens by accident, and there is no reason to 
believe that this assertion won't be removed in such a case.

> +
> +/*
> + * ParavirtualizedGraphics.Framework only ships header files for the PCI
> + * variant which does not include IOSFC descriptors and host devices. We add
> + * their definitions here so that we can also work with the ARM version.
> + */
> +typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);
> +typedef bool(^IOSFCUnmapMemory)(
> +    void *a, void *b, void *c, void *d, void *e, void *f);

Omit dummy parameter names.

> +typedef bool(^IOSFCMapMemory)(
> +    uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f);
> +
> +@interface PGDeviceDescriptor (IOSurfaceMapper)
> +@property (readwrite, nonatomic) bool usingIOSurfaceMapper;
> +@end
> +
> +@interface PGIOSurfaceHostDeviceDescriptor : NSObject
> +-(PGIOSurfaceHostDeviceDescriptor *)init;
> +@property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMemory;
> +@property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unmapMemory;
> +@property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt raiseInterrupt;
> +@end
> +
> +@interface PGIOSurfaceHostDevice : NSObject
> +-(instancetype)initWithDescriptor:(PGIOSurfaceHostDeviceDescriptor *) desc;
> +-(uint32_t)mmioReadAtOffset:(size_t) offset;
> +-(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;

It has inconsistent spacing between types and parameter names. It is 
conventional to omit spaces between them as far as I remember.

> +@end
> +
> +typedef struct AppleGFXVmappleState {
> +    SysBusDevice parent_obj;
> +
> +    AppleGFXState common;
> +
> +    qemu_irq irq_gfx;
> +    qemu_irq irq_iosfc;
> +    MemoryRegion iomem_iosfc;
> +    PGIOSurfaceHostDevice *pgiosfc;
> +} AppleGFXVmappleState;
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXVmappleState, APPLE_GFX_VMAPPLE)
> +
> +
> +static uint64_t apple_iosfc_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AppleGFXVmappleState *s = opaque;
> +    uint64_t res = 0;
> +
> +    bql_unlock();

It is dangerous to unlock BQL at an arbitrary place. Instead of 
unlocking, I suggest:
- running [s->pgiosfc mmioReadAtOffset:offset] on another thread
- using a bottom half to request operations that require BQL from the 
thread running [s->pgiosfc mmioReadAtOffset:offset]
- calling AIO_WAIT_WHILE() to process the bottom half and to wait for 
the completion of [s->pgiosfc mmioReadAtOffset:offset]

> +    res = [s->pgiosfc mmioReadAtOffset:offset];
> +    bql_lock();
> +
> +    trace_apple_iosfc_read(offset, res);
> +
> +    return res;
> +}
> +
> +static void apple_iosfc_write(
> +    void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    AppleGFXVmappleState *s = opaque;
> +
> +    trace_apple_iosfc_write(offset, val);
> +
> +    [s->pgiosfc mmioWriteAtOffset:offset value:val];
> +}
> +
> +static const MemoryRegionOps apple_iosfc_ops = {
> +    .read = apple_iosfc_read,
> +    .write = apple_iosfc_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +};
> +
> +static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(
> +    AppleGFXVmappleState *s)
> +{
> +    PGIOSurfaceHostDeviceDescriptor *iosfc_desc =
> +        [PGIOSurfaceHostDeviceDescriptor new];
> +    PGIOSurfaceHostDevice *iosfc_host_dev = nil;
> +
> +    iosfc_desc.mapMemory =
> +        ^(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
> +            trace_apple_iosfc_map_memory(phys, len, ro, va, e, f);
> +            MemoryRegion *tmp_mr;
> +            *va = gpa2hva(&tmp_mr, phys, len, NULL);

Use: dma_memory_map()

> +            return (bool)true;

Why cast?

> +        };
> +
> +    iosfc_desc.unmapMemory =
> +        ^(void *a, void *b, void *c, void *d, void *e, void *f) {
> +            trace_apple_iosfc_unmap_memory(a, b, c, d, e, f);
> +            return (bool)true;
> +        };
> +
> +    iosfc_desc.raiseInterrupt = ^(uint32_t vector) {
> +        trace_apple_iosfc_raise_irq(vector);
> +        bool locked = bql_locked();
> +        if (!locked) {
> +            bql_lock();
> +        }
 > +        qemu_irq_pulse(s->irq_iosfc);> +        if (!locked) {
> +            bql_unlock();
> +        }
> +        return (bool)true;
> +    };
> +
> +    iosfc_host_dev =
> +        [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
> +    [iosfc_desc release];
> +    return iosfc_host_dev;
> +}
> +
> +static void apple_gfx_vmapple_realize(DeviceState *dev, Error **errp)
> +{
> +    @autoreleasepool {

This autoreleasepool is not used.

> +        AppleGFXVmappleState *s = APPLE_GFX_VMAPPLE(dev);
> +
> +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
> +        desc.usingIOSurfaceMapper = true;
> +        desc.raiseInterrupt = ^(uint32_t vector) {
> +            bool locked;
> +
> +            trace_apple_gfx_raise_irq(vector);
> +            locked = bql_locked();
> +            if (!locked) {
> +                bql_lock();
> +            }
> +            qemu_irq_pulse(s->irq_gfx);
> +            if (!locked) {
> +                bql_unlock();
> +            }
> +        };
> +
> +        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
> +
> +        apple_gfx_common_realize(&s->common, desc);
> +        [desc release];
> +        desc = nil;
> +    }
> +}
> +
> +static void apple_gfx_vmapple_init(Object *obj)
> +{
> +    AppleGFXVmappleState *s = APPLE_GFX_VMAPPLE(obj);
> +
> +    apple_gfx_common_init(obj, &s->common, TYPE_APPLE_GFX_VMAPPLE);
> +
> +    memory_region_init_io(&s->iomem_iosfc, obj, &apple_iosfc_ops, s,
> +                          TYPE_APPLE_GFX_VMAPPLE, 0x10000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->common.iomem_gfx);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem_iosfc);
> +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_gfx);
> +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_iosfc);
> +}
> +
> +static void apple_gfx_vmapple_reset(Object *obj, ResetType type)
> +{
> +    AppleGFXVmappleState *s = APPLE_GFX_VMAPPLE(obj);
> +    [s->common.pgdev reset];
> +}
> +
> +
> +static void apple_gfx_vmapple_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    assert(rc->phases.hold == NULL);

Please remove this assertion. Having such an assertion for all types 
that inherit TYPE_SYS_BUS_DEVICE will make the code base too cluttered, 
and there is nothing special with TYPE_APPLE_GFX_VMAPPLE.

> +    rc->phases.hold = apple_gfx_vmapple_reset;
> +
> +    dc->realize = apple_gfx_vmapple_realize;
> +}
> +
> +static TypeInfo apple_gfx_vmapple_types[] = {
> +    {
> +        .name          = TYPE_APPLE_GFX_VMAPPLE,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(AppleGFXVmappleState),
> +        .class_init    = apple_gfx_vmapple_class_init,
> +        .instance_init = apple_gfx_vmapple_init,
> +    }
> +};
> +DEFINE_TYPES(apple_gfx_vmapple_types)
> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> new file mode 100644
> index 00000000000..995ecf7f4a7
> --- /dev/null
> +++ b/hw/display/apple-gfx.h
> @@ -0,0 +1,57 @@
> +#ifndef QEMU_APPLE_GFX_H
> +#define QEMU_APPLE_GFX_H
> +
> +#define TYPE_APPLE_GFX_VMAPPLE      "apple-gfx-vmapple"
> +#define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
> +
> +#include "qemu/typedefs.h"
> +
> +typedef struct AppleGFXState AppleGFXState;
> +
> +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name);
> +
> +#ifdef __OBJC__

This ifdef is unnecessary.

> +
> +#include "qemu/osdep.h"
> +#include "exec/memory.h"
> +#include "ui/surface.h"
> +#include <dispatch/dispatch.h>
> +
> +@class PGDeviceDescriptor;
> +@protocol PGDevice;
> +@protocol PGDisplay;
> +@protocol MTLDevice;
> +@protocol MTLTexture;
> +@protocol MTLCommandQueue;
> +
> +typedef QTAILQ_HEAD(, PGTask_s) AppleGFXTaskList;
> +
> +struct AppleGFXState {
> +    MemoryRegion iomem_gfx;
> +    id<PGDevice> pgdev;
> +    id<PGDisplay> pgdisp;
> +    AppleGFXTaskList tasks;
> +    QemuConsole *con;
> +    id<MTLDevice> mtl;
> +    id<MTLCommandQueue> mtl_queue;
> +    bool handles_frames;
> +    bool new_frame;
> +    bool cursor_show;
> +    QEMUCursor *cursor;
> +
> +    dispatch_queue_t render_queue;
> +    /* The following fields should only be accessed from render_queue: */
> +    bool gfx_update_requested;
> +    bool new_frame_ready;
> +    bool using_managed_texture_storage;
> +    int32_t pending_frames;
> +    void *vram;
> +    DisplaySurface *surface;
> +    id<MTLTexture> texture;
> +};
> +
> +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc);
> +
> +#endif /* __OBJC__ */
> +
> +#endif
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> new file mode 100644
> index 00000000000..837300f9cd4
> --- /dev/null
> +++ b/hw/display/apple-gfx.m
> @@ -0,0 +1,536 @@
> +/*
> + * QEMU Apple ParavirtualizedGraphics.framework device
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * ParavirtualizedGraphics.framework is a set of libraries that macOS provides
> + * which implements 3d graphics passthrough to the host as well as a
> + * proprietary guest communication channel to drive it. This device model
> + * implements support to drive that library from within QEMU.
> + */
> +
> +#include "apple-gfx.h"
> +#include "trace.h"
> +#include "qemu/main-loop.h"
> +#include "ui/console.h"
> +#include "monitor/monitor.h"
> +#include "qapi/error.h"
> +#include "migration/blocker.h"
> +#include <mach/mach_vm.h>
> +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> +
> +static const PGDisplayCoord_t apple_gfx_modes[] = {
> +    { .x = 1440, .y = 1080 },
> +    { .x = 1280, .y = 1024 },
> +};
> +
> +typedef struct PGTask_s { // Name matches forward declaration in PG header

Let's name it AppleGFXTask. It is a common practice to have the same tag 
name and typedef in QEMU.

Please also avoid using // comment as suggested in: docs/devel/style.rst
You can just remove the comment in this case as the usage of struct tag 
names in QTAILQ_HEAD() is very common.

> +    QTAILQ_ENTRY(PGTask_s) node;
> +    mach_vm_address_t address;
> +    uint64_t len;
> +} AppleGFXTask;
> +
> +static Error *apple_gfx_mig_blocker;
> +
> +static void apple_gfx_render_frame_completed(AppleGFXState *s, void *vram,
> +                                             id<MTLTexture> texture);
> +
> +static AppleGFXTask *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
> +{
> +    mach_vm_address_t task_mem;
> +    AppleGFXTask *task;
> +    kern_return_t r;
> +
> +    r = mach_vm_allocate(mach_task_self(), &task_mem, len, VM_FLAGS_ANYWHERE);
> +    if (r != KERN_SUCCESS || task_mem == 0) {

I think you can just check r. There is no reason to reject if the kernel 
insists it successfully allocated memory at 0 though that should never 
happen.

> +        return NULL;
> +    }
> +
> +    task = g_new0(AppleGFXTask, 1);
> +
> +    task->address = task_mem;
> +    task->len = len;
> +    QTAILQ_INSERT_TAIL(&s->tasks, task, node);
> +
> +    return task;
> +}
> +
> +static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AppleGFXState *s = opaque;
> +    uint64_t res = 0;

Don't initialize it with an arbitrary value as such an initialization 
suppresses an uninitialized variable warning.

Please also keep naming consistent; you have used "r" for a similar 
variable previously.

> +
> +    bql_unlock();
> +    res = [s->pgdev mmioReadAtOffset:offset];
> +    bql_lock();
> +
> +    trace_apple_gfx_read(offset, res);
> +
> +    return res;
> +}
> +
> +static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val,
> +                            unsigned size)
> +{
> +    AppleGFXState *s = opaque;
> +
> +    trace_apple_gfx_write(offset, val);
> +
> +    bql_unlock();
> +    [s->pgdev mmioWriteAtOffset:offset value:val];
> +    bql_lock();
> +}
> +
> +static const MemoryRegionOps apple_gfx_ops = {
> +    .read = apple_gfx_read,
> +    .write = apple_gfx_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void apple_gfx_render_new_frame(AppleGFXState *s)
> +{
> +    BOOL r;
> +    void *vram = s->vram;
> +    uint32_t width = surface_width(s->surface);
> +    uint32_t height = surface_height(s->surface);
> +    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
> +    id<MTLCommandBuffer> command_buffer = [s->mtl_queue commandBuffer];
> +    id<MTLTexture> texture = s->texture;
> +    r = [s->pgdisp encodeCurrentFrameToCommandBuffer:command_buffer
> +                                             texture:texture
> +                                              region:region];
> +    if (!r) {
> +        return;
> +    }
> +    [texture retain];
> +    if (s->using_managed_texture_storage) {
> +        /* "Managed" textures exist in both VRAM and RAM and must be synced. */
> +        id<MTLBlitCommandEncoder> blit = [command_buffer blitCommandEncoder];
> +        [blit synchronizeResource:texture];
> +        [blit endEncoding];
> +    }
> +    [command_buffer retain];

I don't think this call of retain is necessary. The completion handler 
gets the command buffer via parameter, which implies the command buffer 
is automatically retained until the completion handler finishes.

> +    [command_buffer addCompletedHandler:
> +        ^(id<MTLCommandBuffer> cb)
> +        {
> +            dispatch_async(s->render_queue, ^{
> +                apple_gfx_render_frame_completed(s, vram, texture);
> +                [texture release];
> +            });
> +            [command_buffer release];
> +        }];
> +    [command_buffer commit];
> +}
> +
> +static void copy_mtl_texture_to_surface_mem(id<MTLTexture> texture, void *vram)
> +{
> +    /* TODO: Skip this entirely on a pure Metal or headless/guest-only
> +     * rendering path, else use a blit command encoder? Needs careful
> +     * (double?) buffering design. */
> +    size_t width = texture.width, height = texture.height;
> +    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
> +    [texture getBytes:vram
> +          bytesPerRow:(width * 4)
> +        bytesPerImage:(width * height * 4)
> +           fromRegion:region
> +          mipmapLevel:0
> +                slice:0];
> +}
> +
> +static void apple_gfx_render_frame_completed(AppleGFXState *s, void *vram,
> +                                             id<MTLTexture> texture)
> +{
> +    --s->pending_frames;
> +    assert(s->pending_frames >= 0);
> +
> +    if (vram != s->vram) {
> +        /* Display mode has changed, drop this old frame. */
> +        assert(texture != s->texture);
> +        g_free(vram);

This management of buffers looks a bit convoluted. I suggest remembering 
the width and height instead of pointers and comparing them. This way 
you can free resources in set_mode().

> +    } else {
> +        copy_mtl_texture_to_surface_mem(texture, vram);

Writing vram outside BQL may result in tearing.

> +        if (s->gfx_update_requested) {
> +            s->gfx_update_requested = false;
> +            dpy_gfx_update_full(s->con);
> +            graphic_hw_update_done(s->con);
 > +            s->new_frame_ready = false;

This assignment is unnecessary as s->new_frame_ready is always false 
when s->gfx_update_requested. If you want to make sure 
s->gfx_update_requested and s->new_frame_ready are mutually exclusive, 
use one enum value instead of having two bools.

> +        } else {
> +            s->new_frame_ready = true;
> +        }
> +    }
> +    if (s->pending_frames > 0) {
> +        apple_gfx_render_new_frame(s);
> +    }
> +}
> +
> +static void apple_gfx_fb_update_display(void *opaque)
> +{
> +    AppleGFXState *s = opaque;
> +
> +    dispatch_async(s->render_queue, ^{
> +        if (s->pending_frames > 0) {

It should check for s->new_frame_ready as 
apple_gfx_render_frame_completed() doesn't check if
s->pending_frames > 0 before calling graphic_hw_update_done(), which is 
inconsistent.

Checking if s->pending_frames > 0 both in apple_gfx_fb_update_display() 
and apple_gfx_render_frame_completed() is also problematic as that can 
defer graphic_hw_update_done() indefinitely if we are getting new frames 
too fast.

> +            s->gfx_update_requested = true;
> +        } else {
> +            if (s->new_frame_ready) {
> +                dpy_gfx_update_full(s->con);
> +                s->new_frame_ready = false;
> +            }
> +            graphic_hw_update_done(s->con);
 > +        }> +    });
> +}
> +
> +static const GraphicHwOps apple_gfx_fb_ops = {
> +    .gfx_update = apple_gfx_fb_update_display,
> +    .gfx_update_async = true,
> +};
> +
> +static void update_cursor(AppleGFXState *s)
> +{
> +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> +                  s->pgdisp.cursorPosition.y, s->cursor_show);
> +}
> +
> +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
> +{
> +    void *vram = NULL;
> +    DisplaySurface *surface;
> +    MTLTextureDescriptor *textureDescriptor;
> +    id<MTLTexture> texture = nil;
> +    __block bool no_change = false;
> +
> +    dispatch_sync(s->render_queue,

Calling dispatch_sync() while holding BQL may result in deadlock.

> +        ^{
> +            if (s->surface &&
> +                width == surface_width(s->surface) &&
> +                height == surface_height(s->surface)) {
> +                no_change = true;
> +            }
> +        });
> +
> +    if (no_change) {
> +        return;
> +    }
> +
> +    vram = g_malloc0(width * height * 4);
> +    surface = qemu_create_displaysurface_from(width, height, PIXMAN_LE_a8r8g8b8,
> +                                              width * 4, vram);
> +
> +    @autoreleasepool {
> +        textureDescriptor =
> +            [MTLTextureDescriptor
> +                texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> +                                             width:width
> +                                            height:height
> +                                         mipmapped:NO];
> +        textureDescriptor.usage = s->pgdisp.minimumTextureUsage;
> +        texture = [s->mtl newTextureWithDescriptor:textureDescriptor];
> +    }
> +
> +    s->using_managed_texture_storage =
> +        (texture.storageMode == MTLStorageModeManaged);
> +
> +    dispatch_sync(s->render_queue,
> +        ^{
> +            id<MTLTexture> old_texture = nil;
> +            void *old_vram = s->vram;
> +            s->vram = vram;
> +            s->surface = surface;
> +
> +            dpy_gfx_replace_surface(s->con, surface);
> +
> +            old_texture = s->texture;
> +            s->texture = texture;
> +            [old_texture release];

You can just do:
[s->texture release];
s->texture = texture;

This will make s->texture dangling between the two statements, but that 
don't matter since s->texture is not an atomic variable that can be 
safely observed from another thread anyway.

> +
> +            if (s->pending_frames == 0) {
> +                g_free(old_vram);
> +            }
> +        });
> +}
> +
> +static void create_fb(AppleGFXState *s)
> +{
> +    s->con = graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
> +    set_mode(s, 1440, 1080);
> +
> +    s->cursor_show = true;
> +}
> +
> +static size_t apple_gfx_get_default_mmio_range_size(void)
> +{
> +    size_t mmio_range_size;
> +    @autoreleasepool {
> +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
> +        mmio_range_size = desc.mmioLength;
> +        [desc release];
> +    }
> +    return mmio_range_size;
> +}
> +
> +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)

This function can be merged into apple_gfx_common_realize().

> +{
> +    Error *local_err = NULL;
> +    int r;
> +    size_t mmio_range_size = apple_gfx_get_default_mmio_range_size();
> +
> +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
> +    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s, obj_name,
> +                          mmio_range_size);
> +    s->iomem_gfx.disable_reentrancy_guard = true;

Why do you disable reentrancy guard?

> +
> +    /* TODO: PVG framework supports serialising device state: integrate it! */
> +    if (apple_gfx_mig_blocker == NULL) {
> +        error_setg(&apple_gfx_mig_blocker,
> +                  "Migration state blocked by apple-gfx display device");
> +        r = migrate_add_blocker(&apple_gfx_mig_blocker, &local_err);
> +        if (r < 0) {
> +            error_report_err(local_err);

Please report the error to the caller of apple_gfx_common_realize() instead.

> +        }
> +    }
 > +}> +
> +static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> +                                                     PGDeviceDescriptor *desc)
> +{
> +    desc.createTask = ^(uint64_t vmSize, void * _Nullable * _Nonnull baseAddress) {
> +        AppleGFXTask *task = apple_gfx_new_task(s, vmSize);
> +        *baseAddress = (void*)task->address;

nit: please write as (void *) instead of (void*).

> +        trace_apple_gfx_create_task(vmSize, *baseAddress);
> +        return task;
> +    };
> +
> +    desc.destroyTask = ^(AppleGFXTask * _Nonnull task) {
> +        trace_apple_gfx_destroy_task(task);
> +        QTAILQ_REMOVE(&s->tasks, task, node);
> +        mach_vm_deallocate(mach_task_self(), task->address, task->len);
> +        g_free(task);
> +    };
> +
> +    desc.mapMemory = ^(AppleGFXTask * _Nonnull task, uint32_t rangeCount,
> +                       uint64_t virtualOffset, bool readOnly,
> +                       PGPhysicalMemoryRange_t * _Nonnull ranges) {
> +        kern_return_t r;
> +        mach_vm_address_t target, source;
> +        trace_apple_gfx_map_memory(task, rangeCount, virtualOffset, readOnly);
> +        for (int i = 0; i < rangeCount; i++) {
> +            PGPhysicalMemoryRange_t *range = &ranges[i];
> +            MemoryRegion *tmp_mr;
> +            /* TODO: Bounds checks? r/o? */
> +            bql_lock();
> +
> +            trace_apple_gfx_map_memory_range(i, range->physicalAddress,
> +                                             range->physicalLength);
> +
> +            target = task->address + virtualOffset;
> +            source = (mach_vm_address_t)gpa2hva(&tmp_mr,
> +                                                range->physicalAddress,
> +                                                range->physicalLength, NULL);
> +            vm_prot_t cur_protection = 0;
> +            vm_prot_t max_protection = 0;
> +            // Map guest RAM at range->physicalAddress into PG task memory range
> +            r = mach_vm_remap(mach_task_self(),
> +                              &target, range->physicalLength, vm_page_size - 1,
> +                              VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,
> +                              mach_task_self(),
> +                              source, false /* shared mapping, no copy */,
> +                              &cur_protection, &max_protection,
> +                              VM_INHERIT_COPY);
> +            trace_apple_gfx_remap(r, source, target);
> +            g_assert(r == KERN_SUCCESS);
> +
> +            bql_unlock();
> +
> +            virtualOffset += range->physicalLength;
> +        }
> +        return (bool)true;
> +    };
> +
> +    desc.unmapMemory = ^(AppleGFXTask * _Nonnull task, uint64_t virtualOffset,
> +                         uint64_t length) {
> +        kern_return_t r;
> +        mach_vm_address_t range_address;
> +
> +        trace_apple_gfx_unmap_memory(task, virtualOffset, length);
> +
> +        /* Replace task memory range with fresh pages, undoing the mapping
> +         * from guest RAM. */
> +        range_address = task->address + virtualOffset;
> +        r = mach_vm_allocate(mach_task_self(), &range_address, length,
> +                             VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE);
> +        g_assert(r == KERN_SUCCESS);
> +
> +        return (bool)true;
> +    };
> +
> +    desc.readMemory = ^(uint64_t physicalAddress, uint64_t length,
> +                        void * _Nonnull dst) {
> +        trace_apple_gfx_read_memory(physicalAddress, length, dst);
> +        cpu_physical_memory_read(physicalAddress, dst, length);
> +        return (bool)true;
> +    };
> +
> +}
> +
> +static PGDisplayDescriptor *apple_gfx_prepare_display_handlers(AppleGFXState *s)

This name is misleading as it does a bit more than preparing handlers 
but sets properties like name and sizeInMillimeters.

> +{
> +    PGDisplayDescriptor *disp_desc = [PGDisplayDescriptor new];
> +
> +    disp_desc.name = @"QEMU display";
> +    disp_desc.sizeInMillimeters = NSMakeSize(400., 300.); /* A 20" display */
> +    disp_desc.queue = dispatch_get_main_queue();
> +    disp_desc.newFrameEventHandler = ^(void) {
> +        trace_apple_gfx_new_frame();
> +        dispatch_async(s->render_queue, ^{
> +            /* Drop frames if we get too far ahead. */
> +            if (s->pending_frames >= 2)
> +                return;
> +            ++s->pending_frames;
> +            if (s->pending_frames > 1) {
> +                return;
> +            }
> +            @autoreleasepool {
> +                apple_gfx_render_new_frame(s);
> +            }
> +        });
> +    };
> +    disp_desc.modeChangeHandler = ^(PGDisplayCoord_t sizeInPixels,
> +                                    OSType pixelFormat) {
> +        trace_apple_gfx_mode_change(sizeInPixels.x, sizeInPixels.y);
> +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> +    };
> +    disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
> +                                     PGDisplayCoord_t hotSpot) {
> +        uint32_t bpp = glyph.bitsPerPixel;
> +        size_t width = glyph.pixelsWide;
> +        size_t height = glyph.pixelsHigh;
> +        size_t padding_bytes_per_row = glyph.bytesPerRow - width * 4;
> +        const uint8_t* px_data = glyph.bitmapData;
> +
> +        trace_apple_gfx_cursor_set(bpp, width, height);
> +
> +        if (s->cursor) {
> +            cursor_unref(s->cursor);
> +            s->cursor = NULL;
> +        }
> +
> +        if (bpp == 32) { /* Shouldn't be anything else, but just to be safe...*/
> +            s->cursor = cursor_alloc(width, height);
> +            s->cursor->hot_x = hotSpot.x;
> +            s->cursor->hot_y = hotSpot.y;
> +
> +            uint32_t *dest_px = s->cursor->data;
> +
> +            for (size_t y = 0; y < height; ++y) {
> +                for (size_t x = 0; x < width; ++x) {
> +                    /* NSBitmapImageRep's red & blue channels are swapped
> +                     * compared to QEMUCursor's. */
> +                    *dest_px =
> +                        (px_data[0] << 16u) |
> +                        (px_data[1] <<  8u) |
> +                        (px_data[2] <<  0u) |
> +                        (px_data[3] << 24u);
> +                    ++dest_px;
> +                    px_data += 4;
> +                }
> +                px_data += padding_bytes_per_row;
> +            }
> +            dpy_cursor_define(s->con, s->cursor);
> +            update_cursor(s);
> +        }
> +    };
> +    disp_desc.cursorShowHandler = ^(BOOL show) {
> +        trace_apple_gfx_cursor_show(show);
> +        s->cursor_show = show;
> +        update_cursor(s);
> +    };
> +    disp_desc.cursorMoveHandler = ^(void) {
> +        trace_apple_gfx_cursor_move();
> +        update_cursor(s);
> +    };
> +
> +    return disp_desc;
> +}
> +
> +static NSArray<PGDisplayMode*>* apple_gfx_prepare_display_mode_array(void)
> +{
> +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> +    NSArray<PGDisplayMode*>* mode_array = nil;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> +        modes[i] =
> +            [[PGDisplayMode alloc] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
> +    }
> +
> +    mode_array = [NSArray arrayWithObjects:modes count:ARRAY_SIZE(apple_gfx_modes)];
> +
> +    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> +        [modes[i] release];
> +        modes[i] = nil;
> +    }
> +
> +    return mode_array;
> +}
> +
> +static id<MTLDevice> copy_suitable_metal_device(void)
> +{
> +    id<MTLDevice> dev = nil;
> +    NSArray<id<MTLDevice>> *devs = MTLCopyAllDevices();
> +
> +    /* Prefer a unified memory GPU. Failing that, pick a non-removable GPU. */
> +    for (size_t i = 0; i < devs.count; ++i) {
> +        if (devs[i].hasUnifiedMemory) {
> +            dev = devs[i];
> +            break;
> +        }
> +        if (!devs[i].removable) {
> +            dev = devs[i];
> +        }
> +    }
> +
> +    if (dev != nil) {
> +        [dev retain];
> +    } else {
> +        dev = MTLCreateSystemDefaultDevice();
> +    }
> +    [devs release];
> +
> +    return dev;
> +}
> +
> +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
> +{
> +    PGDisplayDescriptor *disp_desc = nil;
> +
> +    QTAILQ_INIT(&s->tasks);
> +    s->render_queue = dispatch_queue_create("apple-gfx.render",
> +                                            DISPATCH_QUEUE_SERIAL);
> +    s->mtl = copy_suitable_metal_device();
> +    s->mtl_queue = [s->mtl newCommandQueue];
> +
> +    desc.device = s->mtl;
> +
> +    apple_gfx_register_task_mapping_handlers(s, desc);
> +
> +    s->pgdev = PGNewDeviceWithDescriptor(desc);
> +
> +    disp_desc = apple_gfx_prepare_display_handlers(s);
> +    s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
> +                                              port:0 serialNum:1234];
> +    [disp_desc release];
> +    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
> +
> +    create_fb(s);
> +}
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 7db05eace97..70d855749c0 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -65,6 +65,8 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
>   
>   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
>   
> +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: [files('apple-gfx.m'), pvg, metal])
> +system_ss.add(when: 'CONFIG_MAC_PVG_VMAPPLE', if_true: [files('apple-gfx-vmapple.m'), pvg, metal])
>   
>   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>     virtio_gpu_ss = ss.source_set()
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 781f8a33203..1809a358e36 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width) "dest_width : %u"
>   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
>   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
>   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> +
> +# apple-gfx.m
> +apple_gfx_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
> +apple_gfx_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
> +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=0x%x base_addr=%p"
> +apple_gfx_destroy_task(void *task) "task=%p"
> +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtual_offset, uint32_t read_only) "task=%p range_count=0x%x virtual_offset=0x%"PRIx64" read_only=%d"
> +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t phys_len) "[%d] phys_addr=0x%"PRIx64" phys_len=0x%"PRIx64
> +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t target) "retval=%"PRId64" source=0x%"PRIx64" target=0x%"PRIx64
> +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t length) "task=%p virtual_offset=0x%"PRIx64" length=0x%"PRIx64
> +apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void *dst) "phys_addr=0x%"PRIx64" length=0x%"PRIx64" dest=%p"
> +apple_gfx_raise_irq(uint32_t vector) "vector=0x%x"
> +apple_gfx_new_frame(void) ""
> +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=%"PRId64" y=%"PRId64
> +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) "bpp=%d width=%"PRId64" height=0x%"PRId64
> +apple_gfx_cursor_show(uint32_t show) "show=%d"
> +apple_gfx_cursor_move(void) ""
> +apple_gfx_common_init(const char *device_name, size_t mmio_size) "device: %s; MMIO size: %zu bytes"
> +
> +# apple-gfx-vmapple.m
> +apple_iosfc_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
> +apple_iosfc_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
> +apple_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, void *va, void *e, void *f) "phys=0x%"PRIx64" len=0x%"PRIx64" ro=%d va=%p e=%p f=%p"
> +apple_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void *e, void *f) "a=%p b=%p c=%p d=%p e=%p f=%p"
> +apple_iosfc_raise_irq(uint32_t vector) "vector=0x%x"
> +
> diff --git a/meson.build b/meson.build
> index 10464466ff3..f09df3f09d5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -741,6 +741,8 @@ socket = []
>   version_res = []
>   coref = []
>   iokit = []
> +pvg = []
> +metal = []
>   emulator_link_args = []
>   midl = not_found
>   widl = not_found
> @@ -762,6 +764,8 @@ elif host_os == 'darwin'
>     coref = dependency('appleframeworks', modules: 'CoreFoundation')
>     iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
>     host_dsosuf = '.dylib'
> +  pvg = dependency('appleframeworks', modules: 'ParavirtualizedGraphics')
> +  metal = dependency('appleframeworks', modules: 'Metal')
>   elif host_os == 'sunos'
>     socket = [cc.find_library('socket'),
>               cc.find_library('nsl'),


