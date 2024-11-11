Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873CDD12D72
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 04:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAMNn-000190-JN; Sun, 10 Nov 2024 23:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMNl-00017s-T8
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 23:50:33 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMNg-00062b-WC
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 23:50:33 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cb47387ceso41951455ad.1
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 20:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731300627; x=1731905427;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxEkUZdNAkP2qVSa76NmY3e5xJ4mquJ7IQlJfsVYEro=;
 b=aFNVLSqPkojBq9Pm5jePn2eWbeJWvnGJVRCzz4ZVpC5fHK1d9J5e+vp6zvDFUYug5v
 PUN+7FHDaDet+NqlWh/wETe9S1PyrNyQ19Tl1SHTijDd9hFcgEi/mEx0+UloZMIRhHxa
 DFanQfYo8YgTA+2KlgSFNK0PWAYW5qxpVUeUIdFtiFmDVpUSIfG9RRgwVCyfoEpUEPKb
 8ZAGVFCzs+eda69i8SN88SQNkTfjiMmXBeIECs/5qkwZvZSHSkGnJ7wex1NJ0dXYbW+2
 qz2L5ogG1uRC5K+bnFioAA+EMGVpswYfd1PRhxrpdrKIjUSKuFMSAO1i4QFP0YH91sc7
 LvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731300627; x=1731905427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxEkUZdNAkP2qVSa76NmY3e5xJ4mquJ7IQlJfsVYEro=;
 b=N4aJ3pngwyWRqSuvL0H3wfJrGs0N1mZtaEMLjHUMZw1xKCePSLdY3uM9zFtdLIngnk
 d4QywNTo45T/wup1PQW64w1/dTNJsxLmNh/KlyprjK2/lmRl+FxxlCO+O/U1HwBcVs29
 nEjTIe8iruVnDFLuEAhmX8yfy0OQX7HEmfJq9IaouNcQCBWPRG1CkUXvyV5Vso3jddXN
 WAPP4zEiT6oYgWR05WBCha01EU5DVCWicqYeAe2z7SpXWJR1TZHzXpvIDpDCgcsDXVg+
 oZZUQ+q3SAJSXDRwkx2Soc/RVCWZNmswFY70FNRJHWAA5Bigs22e+YxQE4MOVt0S7VK+
 sonA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAgwohcWWxGJwDRLIwqIYMCGPPrffotHXlhYDwrFi6SReN6Lx6SP758qZcZ8qkbPoNgEds/hAcnoJp@nongnu.org
X-Gm-Message-State: AOJu0YxSxE7Yl/Ba7zPRJ0JdL58BcSaA1o0b0iVsXIIjQm6tCnROvHEg
 z3vOa4qzLDD60ryWTDstQh/8tDX1fnltC4SwqOTm0TWKZla80Nm6RWxYQufQjyo=
X-Google-Smtp-Source: AGHT+IE44LmlO4ELtAcCK8h8uzs1llbPHYNDIX+K4mVLjQ8PVoH3pIHGrzvG0GQvuvsytHsEEg6hww==
X-Received: by 2002:a17:902:ccc6:b0:20c:5909:cc48 with SMTP id
 d9443c01a7336-2118359bfeemr162157525ad.40.1731300627221; 
 Sun, 10 Nov 2024 20:50:27 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e44b15sm67127215ad.163.2024.11.10.20.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 20:50:26 -0800 (PST)
Message-ID: <85ba99f0-29b4-4b29-a652-681b140a6861@daynix.com>
Date: Mon, 11 Nov 2024 13:50:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/16] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
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
References: <20241110215519.49150-1-phil@philjordan.eu>
 <20241110215519.49150-3-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241110215519.49150-3-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/11 6:55, Phil Dennis-Jordan wrote:
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
> Implementation wise, most of the complexity lies in the differing threading
> models of ParavirtualizedGraphics.framework, which uses libdispatch and
> internal locks, versus QEMU, which heavily uses the BQL, especially during
> memory-mapped device I/O. Great care has therefore been taken to prevent
> deadlocks by never calling into PVG methods while holding the BQL, and
> similarly never acquiring the BQL in a callback from PVG. Different strategies
> have been used (libdispatch, blocking and non-blocking BHs, RCU, etc.)
> depending on the specific requirements at each framework entry and exit point.
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
> v5:
> 
>   * Smaller non-functional fixes in response to review comments, such as using
>     NULL for the AIO_WAIT_WHILE context argument, type name formatting,
>     deleting leftover debug code, logging improvements, state struct field
>     order and documentation improvements, etc.
>   * Instead of a single condition variable for all synchronous BH job types,
>     there is now one for each callback block. This reduces the number
>     of threads being awoken unnecessarily to near zero.
>   * MMIO device variant: Unified the BH job for raising interrupts.
>   * Use DMA APIs for PVG framework's guest memory read requests.
>   * Thread safety improvements: ensure mutable AppleGFXState fields are not
>     accessed outside the appropriate lock. Added dedicated mutex for the task
>     list.
>   * Retain references to MemoryRegions for which there exist mappings in each
>     PGTask, and for IOSurface mappings.
> 
> v6:
> 
>   * Switched PGTask_s's' mapped_regions from GPtrArray to GArray
>   * Allow DisplaySurface to manage its own vram now that texture -> vram copy
>     occurs under BQL.
>   * Memory mapping operations now use RCU_READ_LOCK_GUARD() where possible
>     instead of a heavy-weight BH job to acquire the BQL.
>   * Changed PVG cursor and mode setting callbacks to kick off BHs instead of
>     libdispatch tasks which then locked the BQL explicitly.
>   * The single remaining callback which must wait for a BH to complete now
>     creates an ephemeral QemuSemaphore to await completion.
>   * Re-removed tracking of mapped surface manager memory regions. Just look up
>     and ref/unref the memory regions in the map/unmap callbacks.
>   * Re-ordered functions in apple-gfx.m to group them by area of functionality.
>   * Improved comments and tweaked some names.
> 
> v7:
> 
>   * Use g_ptr_array_find() helper function
>   * Error handling coding style tweak
> 
> v8:
> 
>   * Renamed apple_gfx_host_address_for_gpa_range() to
>     apple_gfx_host_ptr_for_gpa_range(), and made it return a void* instead of
>     uintptr_t. Fixed up callers and related code.
>   * Some adjustments to types used.
>   * Variable naming tweaks for better clarity.
>   * Fixed leak in unlikely realize error case.
>   * Fixed typo in unmap call.
>   * Don't bother with dummy argument for g_ptr_array_find(), NULL works too.
> 
> v9:
> 
>   * Pass device pointer to graphic_console_init().
>   * Slightly re-ordered initialisation code.
>   * Simplified error handling during realize().
>   * Simplified code without functional changes, adjusted code & comment
>     formatting.
> 
>   hw/display/Kconfig          |   9 +
>   hw/display/apple-gfx-mmio.m | 281 +++++++++++++
>   hw/display/apple-gfx.h      |  65 +++
>   hw/display/apple-gfx.m      | 764 ++++++++++++++++++++++++++++++++++++
>   hw/display/meson.build      |   4 +
>   hw/display/trace-events     |  28 ++
>   meson.build                 |   4 +
>   7 files changed, 1155 insertions(+)
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
> index 00000000000..2d76e7375bd
> --- /dev/null
> +++ b/hw/display/apple-gfx-mmio.m
> @@ -0,0 +1,281 @@
> +/*
> + * QEMU Apple ParavirtualizedGraphics.framework device, MMIO (arm64) variant
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +#include "qemu/log.h"
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
> +    dispatch_queue_t queue =
> +        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
> +
> +    dispatch_async_f(queue, &job, iosfc_do_read);
> +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
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
> +    dispatch_queue_t queue =
> +        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
> +
> +    dispatch_async_f(queue, &job, iosfc_do_write);
> +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
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
> +static void raise_irq_bh(void *opaque)
> +{
> +    qemu_irq *irq = opaque;
> +
> +    qemu_irq_pulse(*irq);
> +}
> +
> +static void *apple_gfx_mmio_map_surface_memory(uint64_t guest_physical_address,
> +                                               uint64_t length, bool read_only)
> +{
> +    void *mem;
> +    MemoryRegion *region = NULL;
> +
> +    RCU_READ_LOCK_GUARD();
> +    mem = apple_gfx_host_ptr_for_gpa_range(guest_physical_address,
> +                                           length, read_only, &region);
> +    if (mem) {
> +        memory_region_ref(region);
> +    }
> +    return mem;
> +}
> +
> +static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
> +{
> +    MemoryRegion *region;
> +    ram_addr_t offset = 0;
> +
> +    RCU_READ_LOCK_GUARD();
> +    region = memory_region_from_host(ptr, &offset);
> +    if (!region) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: memory at %p to be unmapped not "
> +                      "found.\n",
> +                      __func__, ptr);
> +        return false;
> +    }
> +
> +    trace_apple_gfx_iosfc_unmap_memory_region(ptr, region);
> +    memory_region_unref(region);
> +    return true;
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
> +            *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
> +
> +            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
> +
> +            return *va != NULL;
> +        };
> +
> +    iosfc_desc.unmapMemory =
> +        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
> +            return apple_gfx_mmio_unmap_surface_memory(va);
> +        };
> +
> +    iosfc_desc.raiseInterrupt = ^bool(uint32_t vector) {
> +        trace_apple_gfx_iosfc_raise_irq(vector);
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                raise_irq_bh, &s->irq_iosfc);
> +        return true;
> +    };
> +
> +    iosfc_host_dev =
> +        [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
> +    [iosfc_desc release];
> +    return iosfc_host_dev;
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
> +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                    raise_irq_bh, &s->irq_gfx);
> +        };
> +
> +        desc.usingIOSurfaceMapper = true;
> +        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
> +
> +        if (!apple_gfx_common_realize(&s->common, dev, desc, errp)) {
> +            [s->pgiosfc release];
> +            s->pgiosfc = nil;
> +        }
> +
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
> index 00000000000..cec3fa5ca8e
> --- /dev/null
> +++ b/hw/display/apple-gfx.h
> @@ -0,0 +1,65 @@
> +/*
> + * Data structures and functions shared between variants of the macOS
> + * ParavirtualizedGraphics.framework based apple-gfx display adapter.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
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
> +typedef struct AppleGFXState {
> +    /* Initialised on init/realize() */
> +    MemoryRegion iomem_gfx;
> +    id<PGDevice> pgdev;
> +    id<PGDisplay> pgdisp;
> +    QemuConsole *con;
> +    id<MTLDevice> mtl;
> +    id<MTLCommandQueue> mtl_queue;
> +    dispatch_queue_t render_queue;
> +
> +    /* List `tasks` is protected by task_mutex */
> +    QemuMutex task_mutex;
> +    PGTaskList tasks;
> +
> +    /* Mutable state (BQL protected) */
> +    QEMUCursor *cursor;
> +    DisplaySurface *surface;
> +    id<MTLTexture> texture;
> +    int8_t pending_frames; /* # guest frames in the rendering pipeline */
> +    bool gfx_update_requested; /* QEMU display system wants a new frame */
> +    bool new_frame_ready; /* Guest has rendered a frame, ready to be used */
> +    bool using_managed_texture_storage;
> +
> +    /* Mutable state (atomic) */
> +    bool cursor_show;
> +} AppleGFXState;
> +
> +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name);
> +bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
> +                              PGDeviceDescriptor *desc, Error **errp);
> +void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
> +                                       uint64_t length, bool read_only,
> +                                       MemoryRegion **mapping_in_region);
> +
> +#endif
> +
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> new file mode 100644
> index 00000000000..f7d251609ab
> --- /dev/null
> +++ b/hw/display/apple-gfx.m
> @@ -0,0 +1,764 @@
> +/*
> + * QEMU Apple ParavirtualizedGraphics.framework device
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +#include "sysemu/dma.h"
> +#include "ui/console.h"
> +
> +static const PGDisplayCoord_t apple_gfx_modes[] = {
> +    { .x = 1440, .y = 1080 },
> +    { .x = 1280, .y = 1024 },
> +};
> +
> +/* ------ PGTask and task operations: new/destroy/map/unmap ------ */
> +
> +/*
> + * This implements the type declared in <ParavirtualizedGraphics/PGDevice.h>
> + * which is opaque from the framework's point of view. It is used in callbacks
> + * in the form of its typedef PGTask_t, which also already exists in the
> + * framework headers.
> + *
> + * A "task" in PVG terminology represents a host-virtual contiguous address
> + * range which is reserved in a large chunk on task creation. The mapMemory
> + * callback then requests ranges of guest system memory (identified by their
> + * GPA) to be mapped into subranges of this reserved address space.
> + * This type of operation isn't well-supported by QEMU's memory subsystem,
> + * but it is fortunately trivial to achieve with Darwin's mach_vm_remap() call,
> + * which allows us to refer to the same backing memory via multiple virtual
> + * address ranges. The Mach VM APIs are therefore used throughout for managing
> + * task memory.
> + */
> +struct PGTask_s {
> +    QTAILQ_ENTRY(PGTask_s) node;
> +    AppleGFXState *s;
> +    mach_vm_address_t address;
> +    uint64_t len;
> +    /*
> +     * All unique MemoryRegions for which a mapping has been created in in this
> +     * task, and on which we have thus called memory_region_ref(). There are
> +     * usually very few regions of system RAM in total, so we expect this array
> +     * to be very short. Therefore, no need for sorting or fancy search
> +     * algorithms, linear search will do.
> +     * Protected by AppleGFXState's task_mutex.
> +     */
> +    GPtrArray *mapped_regions;
> +};
> +
> +static Error *apple_gfx_mig_blocker;
> +
> +static PGTask_t *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
> +{
> +    mach_vm_address_t task_mem;
> +    PGTask_t *task;
> +    kern_return_t r;
> +
> +    r = mach_vm_allocate(mach_task_self(), &task_mem, len, VM_FLAGS_ANYWHERE);
> +    if (r != KERN_SUCCESS) {
> +        return NULL;
> +    }
> +
> +    task = g_new0(PGTask_t, 1);
> +    task->s = s;
> +    task->address = task_mem;
> +    task->len = len;
> +    task->mapped_regions = g_ptr_array_sized_new(2 /* Usually enough */);
> +
> +    QEMU_LOCK_GUARD(&s->task_mutex);
> +    QTAILQ_INSERT_TAIL(&s->tasks, task, node);
> +
> +    return task;
> +}
> +
> +static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
> +{
> +    GPtrArray *regions = task->mapped_regions;
> +    MemoryRegion *region;
> +    size_t i;
> +
> +    for (i = 0; i < regions->len; ++i) {
> +        region = g_ptr_array_index(regions, i);
> +        memory_region_unref(region);
> +    }
> +    g_ptr_array_unref(regions);
> +
> +    mach_vm_deallocate(mach_task_self(), task->address, task->len);
> +
> +    QEMU_LOCK_GUARD(&s->task_mutex);
> +    QTAILQ_REMOVE(&s->tasks, task, node);
> +    g_free(task);
> +}
> +
> +void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
> +                                       uint64_t length, bool read_only,
> +                                       MemoryRegion **mapping_in_region)
> +{
> +    MemoryRegion *ram_region;
> +    char *host_ptr;
> +    hwaddr ram_region_offset = 0;
> +    hwaddr ram_region_length = length;
> +
> +    ram_region = address_space_translate(&address_space_memory,
> +                                         guest_physical,
> +                                         &ram_region_offset,
> +                                         &ram_region_length, !read_only,
> +                                         MEMTXATTRS_UNSPECIFIED);
> +
> +    if (!ram_region || ram_region_length < length ||
> +        !memory_access_is_direct(ram_region, !read_only)) {
> +        return NULL;
> +    }
> +
> +    host_ptr = memory_region_get_ram_ptr(ram_region);
> +    if (!host_ptr) {
> +        return NULL;
> +    }
> +    host_ptr += ram_region_offset;
> +    *mapping_in_region = ram_region;
> +    return host_ptr;
> +}
> +
> +static bool apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t *task,
> +                                      uint64_t virtual_offset,
> +                                      PGPhysicalMemoryRange_t *ranges,
> +                                      uint32_t range_count, bool read_only)
> +{
> +    kern_return_t r;
> +    void *source_ptr;
> +    mach_vm_address_t target;
> +    vm_prot_t cur_protection, max_protection;
> +    bool success = true;
> +    MemoryRegion *region;
> +
> +    RCU_READ_LOCK_GUARD();
> +    QEMU_LOCK_GUARD(&s->task_mutex);
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
> +        region = NULL;
> +        source_ptr = apple_gfx_host_ptr_for_gpa_range(range->physicalAddress,
> +                                                      range->physicalLength,
> +                                                      read_only, &region);
> +        if (!source_ptr) {
> +            success = false;
> +            continue;
> +        }
> +
> +        if (!g_ptr_array_find(task->mapped_regions, region, NULL)) {
> +            g_ptr_array_add(task->mapped_regions, region);
> +            memory_region_ref(region);
> +        }
> +
> +        cur_protection = 0;
> +        max_protection = 0;
> +        /* Map guest RAM at range->physicalAddress into PG task memory range */
> +        r = mach_vm_remap(mach_task_self(),
> +                          &target, range->physicalLength, vm_page_size - 1,
> +                          VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,
> +                          mach_task_self(), (mach_vm_address_t)source_ptr,
> +                          false /* shared mapping, no copy */,
> +                          &cur_protection, &max_protection,
> +                          VM_INHERIT_COPY);
> +        trace_apple_gfx_remap(r, source_ptr, target);
> +        g_assert(r == KERN_SUCCESS);
> +    }
> +
> +    return success;
> +}
> +
> +static void apple_gfx_task_unmap_memory(AppleGFXState *s, PGTask_t *task,
> +                                        uint64_t virtual_offset, uint64_t length)
> +{
> +    kern_return_t r;
> +    mach_vm_address_t range_address;
> +
> +    trace_apple_gfx_unmap_memory(task, virtual_offset, length);
> +
> +    /*
> +     * Replace task memory range with fresh 0 pages, undoing the mapping
> +     * from guest RAM.
> +     */
> +    range_address = task->address + virtual_offset;
> +    r = mach_vm_allocate(mach_task_self(), &range_address, length,
> +                         VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE);
> +    g_assert(r == KERN_SUCCESS);
> +}
> +
> +/* ------ Rendering and frame management ------ */
> +
> +static void apple_gfx_render_frame_completed(AppleGFXState *s,
> +                                             uint32_t width, uint32_t height);
> +
> +static void apple_gfx_render_new_frame_bql_unlock(AppleGFXState *s)
> +{
> +    BOOL r;
> +    bool managed_texture = s->using_managed_texture_storage;
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
> +    /*
> +     * This is not safe to call from the BQL due to PVG-internal locks causing
> +     * deadlocks.
> +     */
> +    r = [s->pgdisp encodeCurrentFrameToCommandBuffer:command_buffer
> +                                             texture:texture
> +                                              region:region];
> +    if (!r) {
> +        [texture release];
> +        bql_lock();
> +        --s->pending_frames;
> +        bql_unlock();
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: encodeCurrentFrameToCommandBuffer:texture:region: "
> +                      "failed\n", __func__);
> +        return;
> +    }
> +
> +    if (managed_texture) {
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

Put /* and */ in separate lines here too.

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
> +        copy_mtl_texture_to_surface_mem(s->texture, surface_data(s->surface));
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
> +/* ------ Mouse cursor and display mode setting ------ */
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
> +    [s->texture release];
> +
> +    s->surface = qemu_create_displaysurface(width, height);
> +
> +    @autoreleasepool {
> +        textureDescriptor =
> +            [MTLTextureDescriptor
> +                texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> +                                             width:width
> +                                            height:height
> +                                         mipmapped:NO];
> +        textureDescriptor.usage = s->pgdisp.minimumTextureUsage;
> +        s->texture = [s->mtl newTextureWithDescriptor:textureDescriptor];
> +    }
> +
> +    s->using_managed_texture_storage =
> +        (s->texture.storageMode == MTLStorageModeManaged);
> +    dpy_gfx_replace_surface(s->con, s->surface);
> +}
> +
> +static void update_cursor(AppleGFXState *s)
> +{
> +    assert(bql_locked());
> +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> +                  s->pgdisp.cursorPosition.y, qatomic_read(&s->cursor_show));
> +}
> +
> +static void update_cursor_bh(void *opaque)
> +{
> +    AppleGFXState *s = opaque;
> +    update_cursor(s);
> +}
> +
> +typedef struct AppleGFXSetCursorGlyphJob {
> +    AppleGFXState *s;
> +    NSBitmapImageRep *glyph;
> +    PGDisplayCoord_t hotspot;
> +} AppleGFXSetCursorGlyphJob;
> +
> +static void set_cursor_glyph(void *opaque)
> +{
> +    AppleGFXSetCursorGlyphJob *job = opaque;
> +    AppleGFXState *s = job->s;
> +    NSBitmapImageRep *glyph = job->glyph;
> +    uint32_t bpp = glyph.bitsPerPixel;
> +    size_t width = glyph.pixelsWide;
> +    size_t height = glyph.pixelsHigh;
> +    size_t padding_bytes_per_row = glyph.bytesPerRow - width * 4;
> +    const uint8_t* px_data = glyph.bitmapData;
> +
> +    trace_apple_gfx_cursor_set(bpp, width, height);
> +
> +    if (s->cursor) {
> +        cursor_unref(s->cursor);
> +        s->cursor = NULL;
> +    }
> +
> +    if (bpp == 32) { /* Shouldn't be anything else, but just to be safe...*/
> +        s->cursor = cursor_alloc(width, height);
> +        s->cursor->hot_x = job->hotspot.x;
> +        s->cursor->hot_y = job->hotspot.y;
> +
> +        uint32_t *dest_px = s->cursor->data;
> +
> +        for (size_t y = 0; y < height; ++y) {
> +            for (size_t x = 0; x < width; ++x) {
> +                /*
> +                 * NSBitmapImageRep's red & blue channels are swapped
> +                 * compared to QEMUCursor's.
> +                 */
> +                *dest_px =
> +                    (px_data[0] << 16u) |
> +                    (px_data[1] <<  8u) |
> +                    (px_data[2] <<  0u) |
> +                    (px_data[3] << 24u);
> +                ++dest_px;
> +                px_data += 4;
> +            }
> +            px_data += padding_bytes_per_row;
> +        }
> +        dpy_cursor_define(s->con, s->cursor);
> +        update_cursor(s);
> +    }
> +    [glyph release];
> +
> +    g_free(job);
> +}
> +
> +/* ------ DMA (device reading system memory) ------ */
> +
> +typedef struct AppleGFXReadMemoryJob {
> +    QemuSemaphore sem;
> +    hwaddr physical_address;
> +    uint64_t length;
> +    void *dst;
> +    bool success;
> +} AppleGFXReadMemoryJob;
> +
> +static void apple_gfx_do_read_memory(void *opaque)
> +{
> +    AppleGFXReadMemoryJob *job = opaque;
> +    MemTxResult r;
> +
> +    r = dma_memory_read(&address_space_memory, job->physical_address,
> +                        job->dst, job->length, MEMTXATTRS_UNSPECIFIED);
> +    job->success = r == MEMTX_OK;
> +
> +    qemu_sem_post(&job->sem);
> +}
> +
> +static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr physical_address,
> +                                  uint64_t length, void *dst)
> +{
> +    AppleGFXReadMemoryJob job = {
> +        .physical_address = physical_address, .length = length, .dst = dst
> +    };
> +
> +    trace_apple_gfx_read_memory(physical_address, length, dst);
> +
> +    /* Performing DMA requires BQL, so do it in a BH. */
> +    qemu_sem_init(&job.sem, 0);
> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                            apple_gfx_do_read_memory, &job);
> +    qemu_sem_wait(&job.sem);
> +    qemu_sem_destroy(&job.sem);
> +    return job.success;
> +}
> +
> +/* ------ Memory-mapped device I/O operations ------ */
> +
> +static dispatch_queue_t get_background_queue(void)
> +{
> +    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
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
> +    dispatch_queue_t queue = get_background_queue();
> +
> +    dispatch_async_f(queue, &job, apple_gfx_do_read);
> +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
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
> +    /*
> +     * The methods mmioReadAtOffset: and especially mmioWriteAtOffset: can
> +     * trigger synchronous operations on other dispatch queues, which in turn
> +     * may call back out on one or more of the callback blocks. For this reason,
> +     * and as we are holding the BQL, we invoke the I/O methods on a pool
> +     * thread and handle AIO tasks while we wait. Any work in the callbacks
> +     * requiring the BQL will in turn schedule BHs which this thread will
> +     * process while waiting.
> +     */
> +    AppleGFXIOJob job = {
> +        .state = opaque,
> +        .offset = offset,
> +        .value = val,
> +        .completed = false,
> +    };
> +    dispatch_queue_t queue = get_background_queue();
> +
> +    dispatch_async_f(queue, &job, apple_gfx_do_write);
> +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
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
> +/* ------ Initialisation and startup ------ */
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
> +        trace_apple_gfx_destroy_task(task, task->mapped_regions->len);
> +
> +        apple_gfx_destroy_task(s, task);
> +    };
> +
> +    desc.mapMemory = ^bool(PGTask_t * _Nonnull task, uint32_t range_count,
> +                           uint64_t virtual_offset, bool read_only,
> +                           PGPhysicalMemoryRange_t * _Nonnull ranges) {
> +        return apple_gfx_task_map_memory(s, task, virtual_offset,
> +                                         ranges, range_count, read_only);
> +    };
> +
> +    desc.unmapMemory = ^bool(PGTask_t * _Nonnull task, uint64_t virtual_offset,
> +                             uint64_t length) {
> +        apple_gfx_task_unmap_memory(s, task, virtual_offset, length);
> +        return true;
> +    };
> +
> +    desc.readMemory = ^bool(uint64_t physical_address, uint64_t length,
> +                            void * _Nonnull dst) {
> +        return apple_gfx_read_memory(s, physical_address, length, dst);
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
> +                                     PGDisplayCoord_t hotspot) {
> +        AppleGFXSetCursorGlyphJob *job = g_malloc0(sizeof(*job));
> +        job->s = s;
> +        job->glyph = glyph;
> +        job->hotspot = hotspot;
> +        [glyph retain];
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                set_cursor_glyph, job);
> +    };
> +    disp_desc.cursorShowHandler = ^(BOOL show) {
> +        trace_apple_gfx_cursor_show(show);
> +        qatomic_set(&s->cursor_show, show);
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                update_cursor_bh, s);
> +    };
> +    disp_desc.cursorMoveHandler = ^(void) {
> +        trace_apple_gfx_cursor_move();
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                update_cursor_bh, s);
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
> +bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
> +                              PGDeviceDescriptor *desc, Error **errp)
> +{
> +    PGDisplayDescriptor *disp_desc = nil;
> +
> +    if (apple_gfx_mig_blocker == NULL) {
> +        error_setg(&apple_gfx_mig_blocker,
> +                  "Migration state blocked by apple-gfx display device");
> +        if (migrate_add_blocker(&apple_gfx_mig_blocker, errp) < 0) {
> +            return false;
> +        }
> +    }
> +
> +    qemu_mutex_init(&s->task_mutex);
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
> +    s->cursor_show = true;
> +
> +    s->pgdev = PGNewDeviceWithDescriptor(desc);
> +
> +    disp_desc = apple_gfx_prepare_display_descriptor(s);
> +    s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
> +                                              port:0 serialNum:1234];
> +    [disp_desc release];
> +    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
> +
> +    s->con = graphic_console_init(dev, 0, &apple_gfx_fb_ops, s);
> +    return true;
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

This gives an error on Linux:
ERROR: No host machine compiler for 'hw/display/apple-gfx.m'

> +if cpu == 'aarch64'
> +  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: [files('apple-gfx-mmio.m'), pvg, metal])
> +endif
>   
>   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>     virtio_gpu_ss = ss.source_set()
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index d26d663f963..a50e4eea0c0 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -194,3 +194,31 @@ dm163_bits_ppi(unsigned dest_width) "dest_width : %u"
>   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
>   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
>   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> +
> +# apple-gfx.m
> +apple_gfx_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
> +apple_gfx_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
> +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=0x%x base_addr=%p"
> +apple_gfx_destroy_task(void *task, unsigned int num_mapped_regions) "task=%p, task->mapped_regions->len=%u"
> +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtual_offset, uint32_t read_only) "task=%p range_count=0x%x virtual_offset=0x%"PRIx64" read_only=%d"
> +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t phys_len) "[%d] phys_addr=0x%"PRIx64" phys_len=0x%"PRIx64
> +apple_gfx_remap(uint64_t retval, void *source_ptr, uint64_t target) "retval=%"PRId64" source=%p target=0x%"PRIx64
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
> +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, void *va, void *e, void *f, void* va_result) "phys=0x%"PRIx64" len=0x%"PRIx64" ro=%d va=%p e=%p f=%p -> *va=%p"
> +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_t start, uint64_t end) "index=%zu, region=%p, 0x%"PRIx64"-0x%"PRIx64
> +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void *e, void *f) "a=%p b=%p c=%p d=%p e=%p f=%p"
> +apple_gfx_iosfc_unmap_memory_region(void* mem, void *region) "unmapping @ %p from memory region %p"
> +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=0x%x"
> +
> diff --git a/meson.build b/meson.build
> index e0b880e4e13..427e3f61190 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -794,6 +794,8 @@ socket = []
>   version_res = []
>   coref = []
>   iokit = []
> +pvg = []
> +metal = []
>   emulator_link_args = []
>   midl = not_found
>   widl = not_found
> @@ -815,6 +817,8 @@ elif host_os == 'darwin'
>     coref = dependency('appleframeworks', modules: 'CoreFoundation')
>     iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
>     host_dsosuf = '.dylib'
> +  pvg = dependency('appleframeworks', modules: 'ParavirtualizedGraphics')
> +  metal = dependency('appleframeworks', modules: 'Metal')
>   elif host_os == 'sunos'
>     socket = [cc.find_library('socket'),
>               cc.find_library('nsl'),


