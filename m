Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B2DD116F7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 06:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4DPn-0002oB-4W; Fri, 25 Oct 2024 02:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t4DPm-0002no-AG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 02:03:14 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t4DPi-0004BL-0F
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 02:03:14 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so1070092a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729836188; x=1730440988;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XlpcP/sVns2pB+Kpzp0Ie40h3BGKGmbaqoQ5BNLKbc8=;
 b=CGdyInV3QfNPuC4cvuoK59rIdTnK03cmSrtv9UgiBSXccdNhMozME7nl8LuiCsjB+Y
 ZfTSm0TeTHolPQK3VtFvrq+8PsFlANrBb3HfdGfZNDtmbVEBJFMX1az+fLHc6+pRJUqq
 JiDITuRKr8U4EBMQhUfxEXrEAOHfaUx47dHIZbdnxmEzwtHN8/mBZUBGkQW1dVfDmEvK
 /leDxWHImcCWCW0lxh9UyI4WbjQw1qyOeh/+nGcx359ZQg8O3473EaoNwqLIC8LhhSDc
 FyLGjR53x1h9JWpJTe8e5pMRJWEcCfQXumvR+k5t0qgpIX4KW3ya533e4DyHmfVXnRRl
 Ve+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729836188; x=1730440988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XlpcP/sVns2pB+Kpzp0Ie40h3BGKGmbaqoQ5BNLKbc8=;
 b=eJbAynjkFVdSR+zWBFGepCesOFRvG/h+yKj5r86A+9zbTcZhV505OG9sVVB+6HimVF
 9w0zs1O7AXCY++IuLVIUidhBxEQIYtZilhJz2cpvUuUc1eYU+OExpscgzOxZsSKy/6OD
 UiP9yikiZOd9YnQENHQIYCmPWnWvTYIAI/bdcJLx8uWVuTFHKN6In8Im0kl9pgavESSY
 WFzX1sCrpn+VvLG4JZ17DwtgyWO+UdzTfp7hCQhYgemYamsCgnsSkVlO23I1aI2frsR7
 ZElJXfjrQNkR5C68ES9G+ACoJ27UgmlBrU89Yaotzur0FzXR9T8poSCuvgvJE23XCRYq
 AlIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdRMFFfdmaVtBSGAdlFPCEWXcD4KdBkKcV8ZRyCpJ4i1MiINB2oq+ZeLbn3Q7MnoEt6NSnv/xCSR1M@nongnu.org
X-Gm-Message-State: AOJu0Yx5BAcQWRhfDdGUeZpKZnKnWaE7lUFFHZjcE/z3/2OH2mKZSEHw
 +JSK/g1UlXBzp2N83olvUS0EkZfSMZEto2sa9eJL1z4VDA8t0z89faZMuJ2fXsQ=
X-Google-Smtp-Source: AGHT+IHz+t0fcLxV2CWrGCDP6KIIL+PhfIFQ9WbhsL4Rs0cNNyzhGBKo1PtQjohG+joHGb5UyKde2Q==
X-Received: by 2002:a17:90b:370e:b0:2e2:d7db:41fa with SMTP id
 98e67ed59e1d1-2e76b711b55mr9120877a91.33.1729836188065; 
 Thu, 24 Oct 2024 23:03:08 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf6bebesm3347815ad.65.2024.10.24.23.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 23:03:07 -0700 (PDT)
Message-ID: <9e310d5e-ab73-47b9-b9ed-5a16d4db3fb9@daynix.com>
Date: Fri, 25 Oct 2024 15:03:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] hw/display/apple-gfx: Introduce
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
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-3-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241024102813.9855-3-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
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

On 2024/10/24 19:28, Phil Dennis-Jordan wrote:
> MacOS provides a framework (library) that allows any vmm to implement a
> paravirtualized 3d graphics passthrough to the host metal stack called
> ParavirtualizedGraphics.Framework (PVG). The library abstracts away
> almost every aspect of the paravirtualized device model and only provides
> and receives callbacks on MMIO access as well as to share memory address
> space between the VM and PVG.
> 
> This patch implements a QEMU device that drives PVG for the VMApple
> variant of it.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-authored-by: Alexander Graf <graf@amazon.com>
> 
> Subsequent changes:
> 
>   * Cherry-pick/rebase conflict fixes, API use updates.
>   * Moved from hw/vmapple/ (useful outside that machine type)
>   * Overhaul of threading model, many thread safety improvements.
>   * Asynchronous rendering.
>   * Memory and object lifetime fixes.
>   * Refactoring to split generic and (vmapple) MMIO variant specific
>     code.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
> 
> v2:
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
> v3:
> 
>   * Rebased on latest upstream, fixed breakages including switching to Resettable methods.
>   * Squashed patches dealing with dGPUs, MMIO area size, and GPU picking.
>   * Allow re-entrant MMIO; this simplifies the code and solves the divergence
>     between x86-64 and arm64 variants.
> 
> v4:
> 
>   * Renamed '-vmapple' device variant to '-mmio'
>   * MMIO device type now requires aarch64 host and guest
>   * Complete overhaul of the glue code for making Qemu's and
>     ParavirtualizedGraphics.framework's threading and synchronisation models
>     work together. Calls into PVG are from dispatch queues while the
>     BQL-holding initiating thread processes AIO context events; callbacks from
>     PVG are scheduled as BHs on the BQL/main AIO context, awaiting completion
>     where necessary.
>   * Guest frame rendering state is covered by the BQL, with only the PVG calls
>     outside the lock, and serialised on the named render_queue.
>   * Simplified logic for dropping frames in-flight during mode changes, fixed
>     bug in pending frames logic.
>   * Addressed smaller code review notes such as: function naming, object type
>     declarations, type names/declarations/casts, code formatting, #include
>     order, over-cautious ObjC retain/release, what goes in init vs realize,
>     etc.
> 
> 
>   hw/display/Kconfig          |   9 +
>   hw/display/apple-gfx-mmio.m | 284 ++++++++++++++
>   hw/display/apple-gfx.h      |  58 +++
>   hw/display/apple-gfx.m      | 713 ++++++++++++++++++++++++++++++++++++
>   hw/display/meson.build      |   4 +
>   hw/display/trace-events     |  26 ++
>   meson.build                 |   4 +
>   7 files changed, 1098 insertions(+)
>   create mode 100644 hw/display/apple-gfx-mmio.m
>   create mode 100644 hw/display/apple-gfx.h
>   create mode 100644 hw/display/apple-gfx.m
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 2250c740078..6a9b7b19ada 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -140,3 +140,12 @@ config XLNX_DISPLAYPORT
>   
>   config DM163
>       bool
> +
> +config MAC_PVG
> +    bool
> +    default y
> +
> +config MAC_PVG_MMIO
> +    bool
> +    depends on MAC_PVG && AARCH64
> +
> diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
> new file mode 100644
> index 00000000000..06131bc23f1
> --- /dev/null
> +++ b/hw/display/apple-gfx-mmio.m
> @@ -0,0 +1,284 @@
> +/*
> + * QEMU Apple ParavirtualizedGraphics.framework device, MMIO (arm64) variant
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.

Use SPDX-License-Identifier. You can find some examples with grep.

> + *
> + * ParavirtualizedGraphics.framework is a set of libraries that macOS provides
> + * which implements 3d graphics passthrough to the host as well as a
> + * proprietary guest communication channel to drive it. This device model
> + * implements support to drive that library from within QEMU as an MMIO-based
> + * system device for macOS on arm64 VMs.
> + */
> +
> +#include "qemu/osdep.h"
> +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> +#include "apple-gfx.h"
> +#include "monitor/monitor.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +#include "trace.h"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXMMIOState, APPLE_GFX_MMIO)
> +
> +/*
> + * ParavirtualizedGraphics.Framework only ships header files for the PCI
> + * variant which does not include IOSFC descriptors and host devices. We add
> + * their definitions here so that we can also work with the ARM version.
> + */
> +typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);
> +typedef bool(^IOSFCUnmapMemory)(
> +    void *, void *, void *, void *, void *, void *);
> +typedef bool(^IOSFCMapMemory)(
> +    uint64_t phys, uint64_t len, bool ro, void **va, void *, void *);
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
> +-(instancetype)initWithDescriptor:(PGIOSurfaceHostDeviceDescriptor *)desc;
> +-(uint32_t)mmioReadAtOffset:(size_t)offset;
> +-(void)mmioWriteAtOffset:(size_t)offset value:(uint32_t)value;
> +@end
> +
> +struct AppleGFXMapSurfaceMemoryJob;
> +struct AppleGFXMMIOState {
> +    SysBusDevice parent_obj;
> +
> +    AppleGFXState common;
> +
> +    qemu_irq irq_gfx;
> +    qemu_irq irq_iosfc;
> +    MemoryRegion iomem_iosfc;
> +    PGIOSurfaceHostDevice *pgiosfc;
> +};
> +
> +typedef struct AppleGFXMMIOJob {
> +    AppleGFXMMIOState *state;
> +    uint64_t offset;
> +    uint64_t value;
> +    bool completed;
> +} AppleGFXMMIOJob;
> +
> +static void iosfc_do_read(void *opaque)
> +{
> +    AppleGFXMMIOJob *job = opaque;
> +    job->value = [job->state->pgiosfc mmioReadAtOffset:job->offset];
> +    qatomic_set(&job->completed, true);
> +    aio_wait_kick();
> +}
> +
> +static uint64_t iosfc_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AppleGFXMMIOJob job = {
> +        .state = opaque,
> +        .offset = offset,
> +        .completed = false,
> +    };
> +    AioContext *context = qemu_get_aio_context();
> +    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
> +
> +    dispatch_async_f(queue, &job, iosfc_do_read);
> +    AIO_WAIT_WHILE(context, !qatomic_read(&job.completed));

Pass NULL as the first argument of AIO_WAIT_WHILE().

> +
> +    trace_apple_gfx_mmio_iosfc_read(offset, job.value);
> +    return job.value;
> +}
> +
> +static void iosfc_do_write(void *opaque)
> +{
> +    AppleGFXMMIOJob *job = opaque;
> +    [job->state->pgiosfc mmioWriteAtOffset:job->offset value:job->value];
> +    qatomic_set(&job->completed, true);
> +    aio_wait_kick();
> +}
> +
> +static void iosfc_write(void *opaque, hwaddr offset, uint64_t val,
> +                        unsigned size)
> +{
> +    AppleGFXMMIOJob job = {
> +        .state = opaque,
> +        .offset = offset,
> +        .value = val,
> +        .completed = false,
> +    };
> +    AioContext *context = qemu_get_aio_context();
> +    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
> +
> +    dispatch_async_f(queue, &job, iosfc_do_write);
> +    AIO_WAIT_WHILE(context, !qatomic_read(&job.completed));
> +
> +    trace_apple_gfx_mmio_iosfc_write(offset, val);
> +}
> +
> +static const MemoryRegionOps apple_iosfc_ops = {
> +    .read = iosfc_read,
> +    .write = iosfc_write,
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
> +static void raise_iosfc_irq(void *opaque)
> +{
> +    AppleGFXMMIOState *s = opaque;
> +
> +    qemu_irq_pulse(s->irq_iosfc);
> +}
> +
> +typedef struct AppleGFXMapSurfaceMemoryJob {
> +    uint64_t guest_physical_address;
> +    uint64_t guest_physical_length;
> +    void *result_mem;
> +    AppleGFXMMIOState *state;
> +    bool read_only;
> +    bool success;
> +    bool done;
> +} AppleGFXMapSurfaceMemoryJob;
> +
> +static void apple_gfx_mmio_map_surface_memory(void *opaque)
> +{
> +    AppleGFXMapSurfaceMemoryJob *job = opaque;
> +    AppleGFXMMIOState *s = job->state;
> +    mach_vm_address_t mem;
> +
> +    mem = apple_gfx_host_address_for_gpa_range(job->guest_physical_address,
> +                                               job->guest_physical_length,
> +                                               job->read_only);
> +
> +    qemu_mutex_lock(&s->common.job_mutex);
> +    job->result_mem = (void*)mem;

nit: write as (void *).

> +    job->success = mem != 0;
> +    job->done = true;
> +    qemu_cond_broadcast(&s->common.job_cond);
> +    qemu_mutex_unlock(&s->common.job_mutex);
> +}
> +
> +static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(
> +    AppleGFXMMIOState *s)
> +{
> +    PGIOSurfaceHostDeviceDescriptor *iosfc_desc =
> +        [PGIOSurfaceHostDeviceDescriptor new];
> +    PGIOSurfaceHostDevice *iosfc_host_dev = nil;
> +
> +    iosfc_desc.mapMemory =
> +        ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
> +            AppleGFXMapSurfaceMemoryJob job = {
> +                .guest_physical_address = phys, .guest_physical_length = len,
> +                .read_only = ro, .state = s,
> +            };
> +
> +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                    apple_gfx_mmio_map_surface_memory, &job);
> +            apple_gfx_await_bh_job(&s->common, &job.done);
> +
> +            *va = job.result_mem;
> +
> +            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va,
> +                                             job.success);
> +
> +            return job.success;
> +        };
> +
> +    iosfc_desc.unmapMemory =
> +        ^bool(void *a, void *b, void *c, void *d, void *e, void *f) {
> +            trace_apple_gfx_iosfc_unmap_memory(a, b, c, d, e, f);
> +            return true;
> +        };
> +
> +    iosfc_desc.raiseInterrupt = ^bool(uint32_t vector) {
> +        trace_apple_gfx_iosfc_raise_irq(vector);
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(), raise_iosfc_irq, s);

Let's pass s->irq_iosfc here to unify raise_iosfc_irq() and raise_gfx_irq().

> +        return true;
> +    };
> +
> +    iosfc_host_dev =
> +        [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
> +    [iosfc_desc release];
> +    return iosfc_host_dev;
> +}
> +
> +static void raise_gfx_irq(void *opaque)
> +{
> +    AppleGFXMMIOState *s = opaque;
> +
> +    qemu_irq_pulse(s->irq_gfx);
> +}
> +
> +static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
> +{
> +    @autoreleasepool {
> +        AppleGFXMMIOState *s = APPLE_GFX_MMIO(dev);
> +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
> +
> +        desc.raiseInterrupt = ^(uint32_t vector) {
> +            trace_apple_gfx_raise_irq(vector);
> +            aio_bh_schedule_oneshot(qemu_get_aio_context(), raise_gfx_irq, s);
> +        };
> +
> +        desc.usingIOSurfaceMapper = true;
> +        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
> +
> +        apple_gfx_common_realize(&s->common, desc, errp);
> +        [desc release];
> +        desc = nil;
> +    }
> +}
> +
> +static void apple_gfx_mmio_init(Object *obj)
> +{
> +    AppleGFXMMIOState *s = APPLE_GFX_MMIO(obj);
> +
> +    apple_gfx_common_init(obj, &s->common, TYPE_APPLE_GFX_MMIO);
> +
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->common.iomem_gfx);
> +    memory_region_init_io(&s->iomem_iosfc, obj, &apple_iosfc_ops, s,
> +                          TYPE_APPLE_GFX_MMIO, 0x10000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem_iosfc);
> +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_gfx);
> +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_iosfc);
> +}
> +
> +static void apple_gfx_mmio_reset(Object *obj, ResetType type)
> +{
> +    AppleGFXMMIOState *s = APPLE_GFX_MMIO(obj);
> +    [s->common.pgdev reset];
> +}
> +
> +
> +static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.hold = apple_gfx_mmio_reset;
> +    dc->hotpluggable = false;
> +    dc->realize = apple_gfx_mmio_realize;
> +}
> +
> +static TypeInfo apple_gfx_mmio_types[] = {
> +    {
> +        .name          = TYPE_APPLE_GFX_MMIO,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(AppleGFXMMIOState),
> +        .class_init    = apple_gfx_mmio_class_init,
> +        .instance_init = apple_gfx_mmio_init,
> +    }
> +};
> +DEFINE_TYPES(apple_gfx_mmio_types)
> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> new file mode 100644
> index 00000000000..39931fba65a
> --- /dev/null
> +++ b/hw/display/apple-gfx.h
> @@ -0,0 +1,58 @@
> +#ifndef QEMU_APPLE_GFX_H
> +#define QEMU_APPLE_GFX_H
> +
> +#define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
> +#define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
> +
> +#include "qemu/osdep.h"
> +#include <dispatch/dispatch.h>
> +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> +#include "qemu/typedefs.h"
> +#include "exec/memory.h"
> +#include "ui/surface.h"
> +
> +@class PGDeviceDescriptor;
> +@protocol PGDevice;
> +@protocol PGDisplay;
> +@protocol MTLDevice;
> +@protocol MTLTexture;
> +@protocol MTLCommandQueue;
> +
> +typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
> +
> +struct AppleGFXMapMemoryJob;

Probably this declaration of AppleGFXMapMemoryJob is unnecessary.

> +typedef struct AppleGFXState {
> +    MemoryRegion iomem_gfx;
> +    id<PGDevice> pgdev;
> +    id<PGDisplay> pgdisp;
> +    PGTaskList tasks;
> +    QemuConsole *con;
> +    id<MTLDevice> mtl;
> +    id<MTLCommandQueue> mtl_queue;
> +    bool cursor_show;
> +    QEMUCursor *cursor;
> +
> +    /* For running PVG memory-mapping requests in the AIO context */
> +    QemuCond job_cond;
> +    QemuMutex job_mutex;

Use: QemuEvent

> +
> +    dispatch_queue_t render_queue;
> +    /* The following fields should only be accessed from the BQL: */

Perhaps it may be better to document fields that can be accessed 
*without* the BQL; most things in QEMU implicitly require the BQL.

> +    bool gfx_update_requested;
> +    bool new_frame_ready;
> +    bool using_managed_texture_storage;
> +} AppleGFXState;
> +
> +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name);
> +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc,
> +                              Error **errp);
> +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical,
> +                                               uint64_t length, bool read_only);
> +void apple_gfx_await_bh_job(AppleGFXState *s, bool *job_done_flag);
> +
> +#endif
> +
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> new file mode 100644
> index 00000000000..46be9957f69
> --- /dev/null
> +++ b/hw/display/apple-gfx.m
> @@ -0,0 +1,713 @@
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
> +#include "qemu/osdep.h"
> +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> +#include <mach/mach_vm.h>
> +#include "apple-gfx.h"
> +#include "trace.h"
> +#include "qemu-main.h"
> +#include "exec/address-spaces.h"
> +#include "migration/blocker.h"
> +#include "monitor/monitor.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/cutils.h"
> +#include "qemu/log.h"
> +#include "qapi/visitor.h"
> +#include "qapi/error.h"
> +#include "ui/console.h"
> +
> +static const PGDisplayCoord_t apple_gfx_modes[] = {
> +    { .x = 1440, .y = 1080 },
> +    { .x = 1280, .y = 1024 },
> +};
> +
> +/* This implements a type defined in <ParavirtualizedGraphics/PGDevice.h>
> + * which is opaque from the framework's point of view. Typedef PGTask_t already
> + * exists in the framework headers. */
> +struct PGTask_s {
> +    QTAILQ_ENTRY(PGTask_s) node;
> +    mach_vm_address_t address;
> +    uint64_t len;
> +};
> +
> +static Error *apple_gfx_mig_blocker;

This does not have to be a static variable.

> +
> +static void apple_gfx_render_frame_completed(AppleGFXState *s,
> +                                             uint32_t width, uint32_t height);
> +
> +static inline dispatch_queue_t get_background_queue(void)

Don't add inline. The only effect for modern compilers of inline is to 
suppress the unused function warnings.

> +{
> +    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
> +}
> +
> +static PGTask_t *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
> +{
> +    mach_vm_address_t task_mem;
> +    PGTask_t *task;
> +    kern_return_t r;
> +
> +    r = mach_vm_allocate(mach_task_self(), &task_mem, len, VM_FLAGS_ANYWHERE);
> +    if (r != KERN_SUCCESS || task_mem == 0) {

Let's remove the check for task_mem == 0. We have no reason to reject it 
if the platform insists it allocated a memory at address 0 though such a 
situation should never happen in practice.

> +        return NULL;
> +    }
> +
> +    task = g_new0(PGTask_t, 1);
> +
> +    task->address = task_mem;
> +    task->len = len;
> +    QTAILQ_INSERT_TAIL(&s->tasks, task, node);
> +
> +    return task;
> +}
> +
> +typedef struct AppleGFXIOJob {
> +    AppleGFXState *state;
> +    uint64_t offset;
> +    uint64_t value;
> +    bool completed;
> +} AppleGFXIOJob;
> +
> +static void apple_gfx_do_read(void *opaque)
> +{
> +    AppleGFXIOJob *job = opaque;
> +    job->value = [job->state->pgdev mmioReadAtOffset:job->offset];
> +    qatomic_set(&job->completed, true);
> +    aio_wait_kick();
> +}
> +
> +static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AppleGFXIOJob job = {
> +        .state = opaque,
> +        .offset = offset,
> +        .completed = false,
> +    };
> +    AioContext *context = qemu_get_aio_context();
> +    dispatch_queue_t queue = get_background_queue();
> +
> +    dispatch_async_f(queue, &job, apple_gfx_do_read);
> +    AIO_WAIT_WHILE(context, !qatomic_read(&job.completed));
> +
> +    trace_apple_gfx_read(offset, job.value);
> +    return job.value;
> +}
> +
> +static void apple_gfx_do_write(void *opaque)
> +{
> +    AppleGFXIOJob *job = opaque;
> +    [job->state->pgdev mmioWriteAtOffset:job->offset value:job->value];
> +    qatomic_set(&job->completed, true);
> +    aio_wait_kick();
> +}
> +
> +static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val,
> +                            unsigned size)
> +{
> +    /* The methods mmioReadAtOffset: and especially mmioWriteAtOffset: can
> +     * trigger and block on operations on other dispatch queues, which in turn
> +     * may call back out on one or more of the callback blocks. For this reason,
> +     * and as we are holding the BQL, we invoke the I/O methods on a pool
> +     * thread and handle AIO tasks while we wait. Any work in the callbacks
> +     * requiring the BQL will in turn schedule BHs which this thread will
> +     * process while waiting. */
> +    AppleGFXIOJob job = {
> +        .state = opaque,
> +        .offset = offset,
> +        .value = val,
> +        .completed = false,
> +    };
> +    AioContext *context = qemu_get_current_aio_context();
> +    dispatch_queue_t queue = get_background_queue();
> +
> +    dispatch_async_f(queue, &job, apple_gfx_do_write);
> +    AIO_WAIT_WHILE(context, !qatomic_read(&job.completed));
> +
> +    trace_apple_gfx_write(offset, val);
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
> +static void apple_gfx_render_new_frame_bql_unlock(AppleGFXState *s)
> +{
> +    BOOL r;
> +    uint32_t width = surface_width(s->surface);
> +    uint32_t height = surface_height(s->surface);
> +    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
> +    id<MTLCommandBuffer> command_buffer = [s->mtl_queue commandBuffer];
> +    id<MTLTexture> texture = s->texture;
> +
> +    assert(bql_locked());
> +    [texture retain];
> +
> +    bql_unlock();
> +
> +    /* This is not safe to call from the BQL due to PVG-internal locks causing
> +     * deadlocks. */
> +    r = [s->pgdisp encodeCurrentFrameToCommandBuffer:command_buffer
> +                                             texture:texture
> +                                              region:region];
> +    if (!r) {
> +        [texture release];
> +        bql_lock();
> +        --s->pending_frames;
> +        bql_unlock();
> +        qemu_log_mask(LOG_GUEST_ERROR, "apple_gfx_render_new_frame_bql_unlock: "

Use: __func__

> +                      "encodeCurrentFrameToCommandBuffer:texture:region: failed\n");
> +        return;
> +    }
> +
> +    if (s->using_managed_texture_storage) {
> +        /* "Managed" textures exist in both VRAM and RAM and must be synced. */
> +        id<MTLBlitCommandEncoder> blit = [command_buffer blitCommandEncoder];
> +        [blit synchronizeResource:texture];
> +        [blit endEncoding];
> +    }
> +    [texture release];
> +    [command_buffer addCompletedHandler:
> +        ^(id<MTLCommandBuffer> cb)
> +        {
> +            dispatch_async(s->render_queue, ^{
> +                apple_gfx_render_frame_completed(s, width, height);
> +            });
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
> +}copy_mtl_texture_to_surface_mem
> +
> +static void apple_gfx_render_frame_completed(AppleGFXState *s,
> +                                             uint32_t width, uint32_t height)
> +{
> +    bql_lock();
> +    --s->pending_frames;
> +    assert(s->pending_frames >= 0);
> +
> +    /* Only update display if mode hasn't changed since we started rendering. */
> +    if (width == surface_width(s->surface) &&
> +        height == surface_height(s->surface)) {
> +        copy_mtl_texture_to_surface_mem(s->texture, s->vram);
> +        if (s->gfx_update_requested) {
> +            s->gfx_update_requested = false;
> +            dpy_gfx_update_full(s->con);
> +            graphic_hw_update_done(s->con);
> +            s->new_frame_ready = false;
> +        } else {
> +            s->new_frame_ready = true;
> +        }
> +    }
> +    if (s->pending_frames > 0) {
> +        apple_gfx_render_new_frame_bql_unlock(s);
> +    } else {
> +        bql_unlock();
> +    }
> +}
> +
> +static void apple_gfx_fb_update_display(void *opaque)
> +{
> +    AppleGFXState *s = opaque;
> +
> +    assert(bql_locked());
> +    if (s->new_frame_ready) {
> +        dpy_gfx_update_full(s->con);
> +        s->new_frame_ready = false;
> +        graphic_hw_update_done(s->con);
> +    } else if (s->pending_frames > 0) {
> +        s->gfx_update_requested = true;
> +    } else {
> +        graphic_hw_update_done(s->con);
> +    }
> +}
> +
> +static const GraphicHwOps apple_gfx_fb_ops = {
> +    .gfx_update = apple_gfx_fb_update_display,
> +    .gfx_update_async = true,
> +};
> +
> +static void update_cursor(AppleGFXState *s)
> +{
> +    assert(bql_locked());
> +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> +                  s->pgdisp.cursorPosition.y, s->cursor_show);
> +}
> +
> +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
> +{
> +    MTLTextureDescriptor *textureDescriptor;
> +
> +    if (s->surface &&
> +        width == surface_width(s->surface) &&
> +        height == surface_height(s->surface)) {
> +        return;
> +    }
> +
> +    g_free(s->vram);
> +    [s->texture release];
> +
> +    s->vram = g_malloc0_n(width * height, 4);
> +    s->surface = qemu_create_displaysurface_from(width, height, PIXMAN_LE_a8r8g8b8,
> +                                                 width * 4, s->vram);> +> +    @autoreleasepool {
> +        textureDescriptor =
> +            [MTLTextureDescriptor
> +                texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> +                                             width:width
> +                                            height:height
> +                                         mipmapped:NO];
> +        textureDescriptor.usage = s->pgdisp.minimumTextureUsage;
> +        s->texture = [s->mtl newTextureWithDescriptor:textureDescriptor];


What about creating pixman_image_t from s->texture.buffer.contents? This 
should save memory usage by removing the duplication of texture.

> +    }
> +
> +    s->using_managed_texture_storage =
> +        (s->texture.storageMode == MTLStorageModeManaged);
> +    dpy_gfx_replace_surface(s->con, s->surface);
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
> +{
> +    size_t mmio_range_size = apple_gfx_get_default_mmio_range_size();
> +
> +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
> +    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s, obj_name,
> +                          mmio_range_size);
> +
> +    /* TODO: PVG framework supports serialising device state: integrate it! */
> +}
> +
> +typedef struct AppleGFXMapMemoryJob {
> +    AppleGFXState *state;
> +    PGTask_t *task;
> +    uint64_t virtual_offset;
> +    PGPhysicalMemoryRange_t *ranges;
> +    uint32_t range_count;
> +    bool read_only;
> +    bool success;
> +    bool done;
> +} AppleGFXMapMemoryJob;
> +
> +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical,
> +                                               uint64_t length, bool read_only)
> +{
> +    MemoryRegion *ram_region;
> +    uintptr_t host_address;
> +    hwaddr ram_region_offset = 0;
> +    hwaddr ram_region_length = length;
> +
> +    ram_region = address_space_translate(&address_space_memory,
> +                                         guest_physical,
> +                                         &ram_region_offset,
> +                                         &ram_region_length, !read_only,
> +                                         MEMTXATTRS_UNSPECIFIED);

Call memory_region_ref() so that it won't go away.

> +
> +    if (!ram_region || ram_region_length < length ||
> +        !memory_access_is_direct(ram_region, !read_only)) {
> +        return 0;
> +    }
> +
> +    host_address = (mach_vm_address_t)memory_region_get_ram_ptr(ram_region);

host_address is typed as uintptr_t, not mach_vm_address_t.

> +    if (host_address == 0) {
> +        return 0;
> +    }
> +    host_address += ram_region_offset;
> +
> +    return host_address;
> +}
> +
> +static void apple_gfx_map_memory(void *opaque)
> +{
> +    AppleGFXMapMemoryJob *job = opaque;
> +    AppleGFXState *s = job->state;
> +    PGTask_t *task                  = job->task;
> +    uint32_t range_count            = job->range_count;
> +    uint64_t virtual_offset         = job->virtual_offset;
> +    PGPhysicalMemoryRange_t *ranges = job->ranges;
> +    bool read_only                  = job->read_only;
> +    kern_return_t r;
> +    mach_vm_address_t target, source;
> +    vm_prot_t cur_protection, max_protection;
> +    bool success = true;
> +
> +    g_assert(bql_locked());
> +
> +    trace_apple_gfx_map_memory(task, range_count, virtual_offset, read_only);
> +    for (int i = 0; i < range_count; i++) {
> +        PGPhysicalMemoryRange_t *range = &ranges[i];
> +
> +        target = task->address + virtual_offset;
> +        virtual_offset += range->physicalLength;
> +
> +        trace_apple_gfx_map_memory_range(i, range->physicalAddress,
> +                                         range->physicalLength);
> +
> +        source = apple_gfx_host_address_for_gpa_range(range->physicalAddress,
> +                                                      range->physicalLength,
> +                                                      read_only);
> +        if (source == 0) {
> +            success = false;
> +            continue;
> +        }
> +
> +        MemoryRegion* alt_mr = NULL;
> +        mach_vm_address_t alt_source = (mach_vm_address_t)gpa2hva(&alt_mr, range->physicalAddress, range->physicalLength, NULL);
> +        g_assert(alt_source == source);

Remove this; I guess this is for debugging.

> +
> +        cur_protection = 0;
> +        max_protection = 0;
> +        // Map guest RAM at range->physicalAddress into PG task memory range
> +        r = mach_vm_remap(mach_task_self(),
> +                          &target, range->physicalLength, vm_page_size - 1,
> +                          VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,
> +                          mach_task_self(),
> +                          source, false /* shared mapping, no copy */,
> +                          &cur_protection, &max_protection,
> +                          VM_INHERIT_COPY);
> +        trace_apple_gfx_remap(r, source, target);
> +        g_assert(r == KERN_SUCCESS);
> +    }
> +
> +    qemu_mutex_lock(&s->job_mutex);
> +    job->success = success;
> +    job->done = true;
> +    qemu_cond_broadcast(&s->job_cond);
> +    qemu_mutex_unlock(&s->job_mutex);
> +}
> +
> +void apple_gfx_await_bh_job(AppleGFXState *s, bool *job_done_flag)
> +{
> +    qemu_mutex_lock(&s->job_mutex);
> +    while (!*job_done_flag) {
> +        qemu_cond_wait(&s->job_cond, &s->job_mutex);
> +    }
> +    qemu_mutex_unlock(&s->job_mutex);
> +}
> +
> +typedef struct AppleGFXReadMemoryJob {
> +    AppleGFXState *s;
> +    hwaddr physical_address;
> +    uint64_t length;
> +    void *dst;
> +    bool done;
> +} AppleGFXReadMemoryJob;
> +
> +static void apple_gfx_do_read_memory(void *opaque)
> +{
> +    AppleGFXReadMemoryJob *job = opaque;
> +    AppleGFXState *s = job->s;
> +
> +    cpu_physical_memory_read(job->physical_address, job->dst, job->length);

Use: dma_memory_read()

> +
> +    qemu_mutex_lock(&s->job_mutex);
> +    job->done = true;
> +    qemu_cond_broadcast(&s->job_cond);
> +    qemu_mutex_unlock(&s->job_mutex);
> +}
> +
> +static void apple_gfx_read_memory(AppleGFXState *s, hwaddr physical_address,
> +                                  uint64_t length, void *dst)
> +{
> +    AppleGFXReadMemoryJob job = {
> +        s, physical_address, length, dst
> +    };
> +
> +    trace_apple_gfx_read_memory(physical_address, length, dst);
> +
> +    /* Traversing the memory map requires RCU/BQL, so do it in a BH. */
> +    aio_bh_schedule_oneshot(qemu_get_aio_context(), apple_gfx_do_read_memory,
> +                            &job);
> +    apple_gfx_await_bh_job(s, &job.done);
> +}
> +
> +static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> +                                                     PGDeviceDescriptor *desc)
> +{
> +    desc.createTask = ^(uint64_t vmSize, void * _Nullable * _Nonnull baseAddress) {
> +        PGTask_t *task = apple_gfx_new_task(s, vmSize);
> +        *baseAddress = (void *)task->address;
> +        trace_apple_gfx_create_task(vmSize, *baseAddress);
> +        return task;
> +    };
> +
> +    desc.destroyTask = ^(PGTask_t * _Nonnull task) {
> +        trace_apple_gfx_destroy_task(task);
> +        QTAILQ_REMOVE(&s->tasks, task, node);
> +        mach_vm_deallocate(mach_task_self(), task->address, task->len);
> +        g_free(task);
> +    };
> +
> +    desc.mapMemory = ^bool(PGTask_t * _Nonnull task, uint32_t range_count,
> +                       uint64_t virtual_offset, bool read_only,
> +                       PGPhysicalMemoryRange_t * _Nonnull ranges) {
> +        AppleGFXMapMemoryJob job = {
> +            .state = s,
> +            .task = task, .ranges = ranges, .range_count = range_count,
> +            .read_only = read_only, .virtual_offset = virtual_offset,
> +            .done = false, .success = true,
> +        };
> +        if (range_count > 0) {
> +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                    apple_gfx_map_memory, &job);
> +            apple_gfx_await_bh_job(s, &job.done);
> +        }
> +        return job.success;
> +    };
> +
> +    desc.unmapMemory = ^bool(PGTask_t * _Nonnull task, uint64_t virtualOffset,
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
> +        g_assert(r == KERN_SUCCESS);error_setg

An extra error_setg

> +
> +        return true;
> +    };
> +
> +    desc.readMemory = ^bool(uint64_t physical_address, uint64_t length,
> +                            void * _Nonnull dst) {
> +        apple_gfx_read_memory(s, physical_address, length, dst);
> +        return true;
> +    };
> +}
> +
> +static PGDisplayDescriptor *apple_gfx_prepare_display_descriptor(AppleGFXState *s)
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
> +            bql_lock();
> +            if (s->pending_frames >= 2) {
> +                bql_unlock();
> +                return;
> +            }
> +            ++s->pending_frames;
> +            if (s->pending_frames > 1) {
> +                bql_unlock();
> +                return;
> +            }
> +            @autoreleasepool {
> +                apple_gfx_render_new_frame_bql_unlock(s);
> +            }
> +        });
> +    };
> +    disp_desc.modeChangeHandler = ^(PGDisplayCoord_t sizeInPixels,
> +                                    OSType pixelFormat) {
> +        trace_apple_gfx_mode_change(sizeInPixels.x, sizeInPixels.y);
> +
> +        BQL_LOCK_GUARD();
> +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> +    };
> +    disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
> +                                     PGDisplayCoord_t hotSpot) {
> +        [glyph retain];
> +        dispatch_async(get_background_queue(), ^{
> +            BQL_LOCK_GUARD();
> +            uint32_t bpp = glyph.bitsPerPixel;
> +            size_t width = glyph.pixelsWide;
> +            size_t height = glyph.pixelsHigh;
> +            size_t padding_bytes_per_row = glyph.bytesPerRow - width * 4;
> +            const uint8_t* px_data = glyph.bitmapData;
> +
> +            trace_apple_gfx_cursor_set(bpp, width, height);
> +
> +            if (s->cursor) {
> +                cursor_unref(s->cursor);
> +                s->cursor = NULL;
> +            }
> +
> +            if (bpp == 32) { /* Shouldn't be anything else, but just to be safe...*/
> +                s->cursor = cursor_alloc(width, height);
> +                s->cursor->hot_x = hotSpot.x;
> +                s->cursor->hot_y = hotSpot.y;
> +
> +                uint32_t *dest_px = s->cursor->data;
> +
> +                for (size_t y = 0; y < height; ++y) {
> +                    for (size_t x = 0; x < width; ++x) {
> +                        /* NSBitmapImageRep's red & blue channels are swapped
> +                         * compared to QEMUCursor's. */
> +                        *dest_px =
> +                            (px_data[0] << 16u) |
> +                            (px_data[1] <<  8u) |
> +                            (px_data[2] <<  0u) |
> +                            (px_data[3] << 24u);
> +                        ++dest_px;
> +                        px_data += 4;
> +                    }
> +                    px_data += padding_bytes_per_row;
> +                }
> +                dpy_cursor_define(s->con, s->cursor);
> +                update_cursor(s);
> +            }
> +            [glyph release];
> +        });
> +    };
> +    disp_desc.cursorShowHandler = ^(BOOL show) {
> +        dispatch_async(get_background_queue(), ^{
> +            BQL_LOCK_GUARD();
> +            trace_apple_gfx_cursor_show(show);
> +            s->cursor_show = show;
> +            update_cursor(s);
> +        });
> +    };
> +    disp_desc.cursorMoveHandler = ^(void) {
> +        dispatch_async(get_background_queue(), ^{
> +            BQL_LOCK_GUARD();
> +            trace_apple_gfx_cursor_move();
> +            update_cursor(s);
> +        });
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
> +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc,
> +                              Error **errp)
> +{
> +    PGDisplayDescriptor *disp_desc = nil;
> +
> +    if (apple_gfx_mig_blocker == NULL) {
> +        error_setg(&apple_gfx_mig_blocker,
> +                  "Migration state blocked by apple-gfx display device");
> +        if (migrate_add_blocker(&apple_gfx_mig_blocker, errp) < 0) {
> +            return;
> +        }
> +    }
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
> +    disp_desc = apple_gfx_prepare_display_descriptor(s);
> +    s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
> +                                              port:0 serialNum:1234];
> +    [disp_desc release];
> +    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
> +
> +    create_fb(s);
> +
> +    qemu_mutex_init(&s->job_mutex);
> +    qemu_cond_init(&s->job_cond);
> +}
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 20a94973fa2..619e642905a 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -61,6 +61,10 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
>   
>   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
>   
> +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: [files('apple-gfx.m'), pvg, metal])
> +if cpu == 'aarch64'
> +  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: [files('apple-gfx-mmio.m'), pvg, metal])
> +endif
>   
>   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>     virtio_gpu_ss = ss.source_set()
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 781f8a33203..214998312b9 100644
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
> +# apple-gfx-mmio.m
> +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
> +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
> +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, void *va, void *e, void *f, void* va_result, int success) "phys=0x%"PRIx64" len=0x%"PRIx64" ro=%d va=%p e=%p f=%p -> *va=%p, success = %d"
> +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void *e, void *f) "a=%p b=%p c=%p d=%p e=%p f=%p"
> +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=0x%x"
> +
> diff --git a/meson.build b/meson.build
> index d26690ce204..0e124eff13f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -761,6 +761,8 @@ socket = []
>   version_res = []
>   coref = []
>   iokit = []
> +pvg = []
> +metal = []
>   emulator_link_args = []
>   midl = not_found
>   widl = not_found
> @@ -782,6 +784,8 @@ elif host_os == 'darwin'
>     coref = dependency('appleframeworks', modules: 'CoreFoundation')
>     iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
>     host_dsosuf = '.dylib'
> +  pvg = dependency('appleframeworks', modules: 'ParavirtualizedGraphics')
> +  metal = dependency('appleframeworks', modules: 'Metal')
>   elif host_os == 'sunos'
>     socket = [cc.find_library('socket'),
>               cc.find_library('nsl'),


