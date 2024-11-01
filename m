Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B8DE6F08E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 21:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6zKu-0008Ut-Kd; Fri, 01 Nov 2024 17:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t6zKm-0008TW-By
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:37:34 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t6zKY-0000AW-Jd
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:37:31 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-50d4213c5f6so788375e0c.3
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730497036; x=1731101836;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BdlhVKdkiZ1GTcq5Fw6yyxc7hTAGx2Pleturxr98vVU=;
 b=SxtXaH3WlndMJEjOWKWEk0rqJfsfkzzpb3rWnsgkmzsXS/gQ8zdlBVpUJP2DUHdGEM
 opr4/ZocRLF8gD5w6HXgoNyyfl9SEa+5p8v2h6uJl0G4t4PYRbv8wgVyAfUmZpTG4GAj
 rQDVz/I7W1/my8vXA/AkJOPL+ItMfeuQCWYm4kGrdFg6vlze+hf621e+vwOcYJiMVX00
 crg4kfOuwVN6T9gPXJzDQKscoR94+Dg4dgACQbr2LJhRK+wFBpZFDilx7xNsiCeDLszi
 40/BAaBxiQ+vhtKkht2Qlc074o1JBAKOTEals59XoRi5wuuIkamln7+2ieh2imbjdan6
 TbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730497036; x=1731101836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BdlhVKdkiZ1GTcq5Fw6yyxc7hTAGx2Pleturxr98vVU=;
 b=NLKWyqlp7V52PYDiBF58jZnQjP5zwLkuxLaoI1HHC3fR/qp1P8qmKOGoSfNEw3N24v
 Xq+Gq6wujP0Llfrl8ZYzEMfMVySV70uKLQJ9I2HSXn1/4+pG2gLsYayhADAp+EEApE3t
 TQklOxN//5rWnk0jloWKP35JGI0OShsdLfaXxiFKDUD1WLXpd8DryIuOaZ4DprJODzcH
 461VkopWfTBwfOKmn4+GOUOP0y8thQZkDe8X9LLqAcO8O/wUB+TXIO3imSE76qyVS94K
 FEWQZlHhFCpSvbWoUfoHUcd11PJ7y9EVd1UuJIjZPe5LJfx39zc/F4zo/sq0/0p/g6E6
 Va2w==
X-Gm-Message-State: AOJu0YyyQXMJfxgN6SbgrpkxEFWRopIPYhRRkuvMURswia7KglLgMbHk
 ExGMxiZUGPuCXZnZIcQUOk8KJ5ZoCDEgRWfgXvu9G15+MxCWGQInv51MTJux1jQ2VxZS2yEXiAh
 9AKRhQI/6VaN9fLLIGLwWr5dvZTgKkSYJz/FM
X-Google-Smtp-Source: AGHT+IEEtUYPOOHKO06UQSwzMVgPRUzFScYJ5jqvmQ0HCacTdUxGaXPDoNy46l0mRVALaLznPSrDnEhCNKq6R61vjgs=
X-Received: by 2002:a05:6122:d9c:b0:50d:85c8:af3e with SMTP id
 71dfb90a1353d-5106b0a8e69mr10067735e0c.3.1730497035550; Fri, 01 Nov 2024
 14:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241029205819.69888-1-phil@philjordan.eu>
 <20241029205819.69888-3-phil@philjordan.eu>
 <56e6f39d-9db1-4ee2-bcd4-b50a5096cbf8@daynix.com>
In-Reply-To: <56e6f39d-9db1-4ee2-bcd4-b50a5096cbf8@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 1 Nov 2024 22:37:04 +0100
Message-ID: <CAAibmn3hWka3tVFLvtKuheE02ivx8E1fe6+Hv7e0AL9OnxaXmg@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="00000000000016df020625e0bdd3"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a31;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa31.google.com
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

--00000000000016df020625e0bdd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for taking a look at this latest iteration. Some thoughts on your
comments inline:

On Thu, 31 Oct 2024 at 10:32, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/10/30 5:58, Phil Dennis-Jordan wrote:
> > MacOS provides a framework (library) that allows any vmm to implement a
> > paravirtualized 3d graphics passthrough to the host metal stack called
> > ParavirtualizedGraphics.Framework (PVG). The library abstracts away
> > almost every aspect of the paravirtualized device model and only provid=
es
> > and receives callbacks on MMIO access as well as to share memory addres=
s
> > space between the VM and PVG.
> >
> > This patch implements a QEMU device that drives PVG for the VMApple
> > variant of it.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-authored-by: Alexander Graf <graf@amazon.com>
> >
> > Subsequent changes:
> >
> >   * Cherry-pick/rebase conflict fixes, API use updates.
> >   * Moved from hw/vmapple/ (useful outside that machine type)
> >   * Overhaul of threading model, many thread safety improvements.
> >   * Asynchronous rendering.
> >   * Memory and object lifetime fixes.
> >   * Refactoring to split generic and (vmapple) MMIO variant specific
> >     code.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> > v2:
> >
> >   * Cherry-pick/rebase conflict fixes
> >   * BQL function renaming
> >   * Moved from hw/vmapple/ (useful outside that machine type)
> >   * Code review comments: Switched to DEFINE_TYPES macro & little endia=
n
> >     MMIO.
> >   * Removed some dead/superfluous code
> >   * Mad set_mode thread & memory safe
> >   * Added migration blocker due to lack of (de-)serialisation.
> >   * Fixes to ObjC refcounting and autorelease pool usage.
> >   * Fixed ObjC new/init misuse
> >   * Switched to ObjC category extension for private property.
> >   * Simplified task memory mapping and made it thread safe.
> >   * Refactoring to split generic and vmapple MMIO variant specific
> >     code.
> >   * Switched to asynchronous MMIO writes on x86-64
> >   * Rendering and graphics update are now done asynchronously
> >   * Fixed cursor handling
> >   * Coding convention fixes
> >   * Removed software cursor compositing
> >
> > v3:
> >
> >   * Rebased on latest upstream, fixed breakages including switching to
> Resettable methods.
> >   * Squashed patches dealing with dGPUs, MMIO area size, and GPU pickin=
g.
> >   * Allow re-entrant MMIO; this simplifies the code and solves the
> divergence
> >     between x86-64 and arm64 variants.
> >
> > v4:
> >
> >   * Renamed '-vmapple' device variant to '-mmio'
> >   * MMIO device type now requires aarch64 host and guest
> >   * Complete overhaul of the glue code for making Qemu's and
> >     ParavirtualizedGraphics.framework's threading and synchronisation
> models
> >     work together. Calls into PVG are from dispatch queues while the
> >     BQL-holding initiating thread processes AIO context events;
> callbacks from
> >     PVG are scheduled as BHs on the BQL/main AIO context, awaiting
> completion
> >     where necessary.
> >   * Guest frame rendering state is covered by the BQL, with only the PV=
G
> calls
> >     outside the lock, and serialised on the named render_queue.
> >   * Simplified logic for dropping frames in-flight during mode changes,
> fixed
> >     bug in pending frames logic.
> >   * Addressed smaller code review notes such as: function naming, objec=
t
> type
> >     declarations, type names/declarations/casts, code formatting,
> #include
> >     order, over-cautious ObjC retain/release, what goes in init vs
> realize,
> >     etc.
> >
> > v5:
> >
> >   * Smaller non-functional fixes in response to review comments, such a=
s
> using
> >     NULL for the AIO_WAIT_WHILE context argument, type name formatting,
> >     deleting leftover debug code, logging improvements, state struct
> field
> >     order and documentation improvements, etc.
> >   * Instead of a single condition variable for all synchronous BH job
> types,
> >     there is now one for each callback block. This reduces the number
> >     of threads being awoken unnecessarily to near zero.
> >   * MMIO device variant: Unified the BH job for raising interrupts.
> >   * Use DMA APIs for PVG framework's guest memory read requests.
> >   * Thread safety improvements: ensure mutable AppleGFXState fields are
> not
> >     accessed outside the appropriate lock. Added dedicated mutex for th=
e
> task
> >     list.
> >   * Retain references to MemoryRegions for which there exist mappings i=
n
> each
> >     PGTask, and for IOSurface mappings.
> >
> >   hw/display/Kconfig          |   9 +
> >   hw/display/apple-gfx-mmio.m | 387 ++++++++++++++++++
> >   hw/display/apple-gfx.h      |  79 ++++
> >   hw/display/apple-gfx.m      | 773 +++++++++++++++++++++++++++++++++++=
+
> >   hw/display/meson.build      |   4 +
> >   hw/display/trace-events     |  28 ++
> >   meson.build                 |   4 +
> >   7 files changed, 1284 insertions(+)
> >   create mode 100644 hw/display/apple-gfx-mmio.m
> >   create mode 100644 hw/display/apple-gfx.h
> >   create mode 100644 hw/display/apple-gfx.m
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 2250c740078..6a9b7b19ada 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -140,3 +140,12 @@ config XLNX_DISPLAYPORT
> >
> >   config DM163
> >       bool
> > +
> > +config MAC_PVG
> > +    bool
> > +    default y
> > +
> > +config MAC_PVG_MMIO
> > +    bool
> > +    depends on MAC_PVG && AARCH64
> > +
> > diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
> > new file mode 100644
> > index 00000000000..b0c5669a344
> > --- /dev/null
> > +++ b/hw/display/apple-gfx-mmio.m
> > @@ -0,0 +1,387 @@
> > +/*
> > + * QEMU Apple ParavirtualizedGraphics.framework device, MMIO (arm64)
> variant
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s
> Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * ParavirtualizedGraphics.framework is a set of libraries that macOS
> provides
> > + * which implements 3d graphics passthrough to the host as well as a
> > + * proprietary guest communication channel to drive it. This device
> model
> > + * implements support to drive that library from within QEMU as an
> MMIO-based
> > + * system device for macOS on arm64 VMs.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> > +#include "apple-gfx.h"
> > +#include "monitor/monitor.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/irq.h"
> > +#include "trace.h"
> > +#include "qemu/log.h"
> > +
> > +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXMMIOState, APPLE_GFX_MMIO)
> > +
> > +/*
> > + * ParavirtualizedGraphics.Framework only ships header files for the P=
CI
> > + * variant which does not include IOSFC descriptors and host devices.
> We add
> > + * their definitions here so that we can also work with the ARM versio=
n.
> > + */
> > +typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);
> > +typedef bool(^IOSFCUnmapMemory)(
> > +    void *, void *, void *, void *, void *, void *);
> > +typedef bool(^IOSFCMapMemory)(
> > +    uint64_t phys, uint64_t len, bool ro, void **va, void *, void *);
> > +
> > +@interface PGDeviceDescriptor (IOSurfaceMapper)
> > +@property (readwrite, nonatomic) bool usingIOSurfaceMapper;
> > +@end
> > +
> > +@interface PGIOSurfaceHostDeviceDescriptor : NSObject
> > +-(PGIOSurfaceHostDeviceDescriptor *)init;
> > +@property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory
> mapMemory;
> > +@property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory
> unmapMemory;
> > +@property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt
> raiseInterrupt;
> > +@end
> > +
> > +@interface PGIOSurfaceHostDevice : NSObject
> > +-(instancetype)initWithDescriptor:(PGIOSurfaceHostDeviceDescriptor
> *)desc;
> > +-(uint32_t)mmioReadAtOffset:(size_t)offset;
> > +-(void)mmioWriteAtOffset:(size_t)offset value:(uint32_t)value;
> > +@end
> > +
> > +struct AppleGFXMapSurfaceMemoryJob;
> > +struct AppleGFXMMIOState {
> > +    SysBusDevice parent_obj;
> > +
> > +    AppleGFXState common;
> > +
> > +    QemuCond iosfc_map_job_cond;
> > +    QemuCond iosfc_unmap_job_cond;
> > +    qemu_irq irq_gfx;
> > +    qemu_irq irq_iosfc;
> > +    MemoryRegion iomem_iosfc;
> > +    PGIOSurfaceHostDevice *pgiosfc;
> > +
> > +    GArray *iosfc_mapped_regions; /* array of AppleGFXMMIOMappedRegion
> */
>
> We don't need to have an array but we can get the memory region with
> address_space_translate() when mapping or with memory_region_from_host()
> when unmapping.
>

Yeah, I guess that works. Lots of memory_region_ref()/memory_region_unref()
calls, but I guess the address_space_translate() call is much more
expensive anyway. I originally wanted to store the physical range of the
RAM region so we don't need to keep looking up the physical address on
mapping, but there does not seem to be a good way to obtain the
guest-physical start address of the result of a address_space_translate()
call as only part of the region might be mapped contiguously. (Unless
you've got a good suggestion for that? I was wondering about subtracting
the offset returned from address_space_translate() from the guest physical
address then re-running address_space_translate() with that and the memory
region's size to check if all of it is mapped.)

For background:
In my testing, the system performs thousands of these IOSurface memory
mappings per second, with tens of thousands of mappings alive at any time.
The vast majority are 1 page [16KiB] in size, and they are unmapped in
batches of tens of thousands. In practice, there is only one MemoryRegion
involved in all of this, which is the MemoryRegion containing all of the
VM's system memory. So all of this lookup and referencing and unreferencing
ultimately seems pretty pointless because all that really needs to be done
is work out the offset in guest RAM and add it to the host-side pointer.
But hypothetically, the RAM topology could be more complex, so we have to
jump through all these hoops.
The situation is similar in the task memory-mapping callback of the
main/common PVG device, except there aren't so many mappings and they are
larger. As that's also used in the PCI variant, you also get to deal with
the fun of the non-contiguous x86-64 guest system memory.


> > +};
> > +
> > +typedef struct AppleGFXMMIOJob {
> > +    AppleGFXMMIOState *state;
> > +    uint64_t offset;
> > +    uint64_t value;
> > +    bool completed;
> > +} AppleGFXMMIOJob;
> > +
> > +static void iosfc_do_read(void *opaque)
> > +{
> > +    AppleGFXMMIOJob *job =3D opaque;
> > +    job->value =3D [job->state->pgiosfc mmioReadAtOffset:job->offset];
> > +    qatomic_set(&job->completed, true);
> > +    aio_wait_kick();
> > +}
> > +
> > +static uint64_t iosfc_read(void *opaque, hwaddr offset, unsigned size)
> > +{
> > +    AppleGFXMMIOJob job =3D {
> > +        .state =3D opaque,
> > +        .offset =3D offset,
> > +        .completed =3D false,
> > +    };
> > +    dispatch_queue_t queue =3D
> dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
> > +
> > +    dispatch_async_f(queue, &job, iosfc_do_read);
> > +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
> > +
> > +    trace_apple_gfx_mmio_iosfc_read(offset, job.value);
> > +    return job.value;
> > +}
> > +
> > +static void iosfc_do_write(void *opaque)
> > +{
> > +    AppleGFXMMIOJob *job =3D opaque;
> > +    [job->state->pgiosfc mmioWriteAtOffset:job->offset
> value:job->value];
> > +    qatomic_set(&job->completed, true);
> > +    aio_wait_kick();
> > +}
> > +
> > +static void iosfc_write(void *opaque, hwaddr offset, uint64_t val,
> > +                        unsigned size)
> > +{
> > +    AppleGFXMMIOJob job =3D {
> > +        .state =3D opaque,
> > +        .offset =3D offset,
> > +        .value =3D val,
> > +        .completed =3D false,
> > +    };
> > +    dispatch_queue_t queue =3D
> dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
> > +
> > +    dispatch_async_f(queue, &job, iosfc_do_write);
> > +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
> > +
> > +    trace_apple_gfx_mmio_iosfc_write(offset, val);
> > +}
> > +
> > +static const MemoryRegionOps apple_iosfc_ops =3D {
> > +    .read =3D iosfc_read,
> > +    .write =3D iosfc_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    },
> > +};
> > +
> > +static void raise_irq(void *opaque)
> > +{
> > +    qemu_irq *irq =3D opaque;
> > +
> > +    qemu_irq_pulse(*irq);
> > +}
> > +
> > +typedef struct AppleGFXMapSurfaceMemoryJob {
> > +    uint64_t guest_physical_address;
> > +    uint64_t guest_physical_length;
> > +    void *result_mem;
> > +    AppleGFXMMIOState *state;
> > +    bool read_only;
> > +    bool success;
> > +    bool done;
> > +} AppleGFXMapSurfaceMemoryJob;
> > +
> > +typedef struct AppleGFXMMIOMappedRegion {
> > +    MemoryRegion *region;
> > +    uint64_t map_count;
> > +    uintptr_t host_virtual_start;
> > +    uintptr_t host_virtual_end;
> > +} AppleGFXMMIOMappedRegion;
> > +
> > +static void apple_gfx_mmio_map_surface_memory(void *opaque)
> > +{
> > +    AppleGFXMapSurfaceMemoryJob *job =3D opaque;
> > +    AppleGFXMMIOState *s =3D job->state;
> > +    mach_vm_address_t mem;
> > +    MemoryRegion *region =3D NULL;
> > +    GArray *regions =3D s->iosfc_mapped_regions;
> > +    AppleGFXMMIOMappedRegion *mapped_region;
> > +    size_t i;
> > +
> > +    mem =3D
> apple_gfx_host_address_for_gpa_range(job->guest_physical_address,
> > +
>  job->guest_physical_length,
> > +                                               job->read_only, &region=
);
> > +
> > +    if (mem !=3D 0) {
> > +        for (i =3D 0; i < regions->len; ++i) {
> > +            mapped_region =3D &g_array_index(regions,
> AppleGFXMMIOMappedRegion, i);
> > +            if (region =3D=3D mapped_region->region) {
> > +                ++mapped_region->map_count;
> > +                break;
> > +            }
> > +        }
> > +
> > +        if (i >=3D regions->len) {
> > +            /* No existing mapping to this region found, keep a
> reference and save
> > +             */
> > +            uintptr_t start =3D
> (uintptr_t)memory_region_get_ram_ptr(region);
> > +            AppleGFXMMIOMappedRegion new_region =3D {
> > +                region, 1,
> > +                start,
> > +                start + memory_region_size(region)
> > +            };
> > +            memory_region_ref(region);
> > +            g_array_append_val(regions, new_region);
> > +            trace_apple_gfx_iosfc_map_memory_new_region(
> > +                i, region, start, new_region.host_virtual_end);
> > +        }
> > +    }
> > +
> > +    qemu_mutex_lock(&s->common.job_mutex);
> > +    job->result_mem =3D (void *)mem;
> > +    job->success =3D mem !=3D 0;
> > +    job->done =3D true;
> > +    qemu_cond_broadcast(&s->iosfc_map_job_cond);
> > +    qemu_mutex_unlock(&s->common.job_mutex);
> > +}
> > +
> > +typedef struct AppleGFXUnmapSurfaceMemoryJob {
> > +    void *virtual_address;
> > +    AppleGFXMMIOState *state;
> > +    bool done;
> > +} AppleGFXUnmapSurfaceMemoryJob;
> > +
> > +static AppleGFXMMIOMappedRegion *find_mapped_region_containing(GArray
> *regions,
> > +
>  uintptr_t va,
> > +                                                               size_t
> *index)
> > +{
> > +    size_t i;
> > +    AppleGFXMMIOMappedRegion *mapped_region;
> > +
> > +    for (i =3D 0; i < regions->len; ++i) {
> > +        mapped_region =3D &g_array_index(regions,
> AppleGFXMMIOMappedRegion, i);
> > +        if (va >=3D mapped_region->host_virtual_start &&
> > +            va < mapped_region->host_virtual_end) {
>  > +            *index =3D i;> +            return mapped_region;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +static void apple_gfx_mmio_unmap_surface_memory(void *opaque)
> > +{
> > +    AppleGFXUnmapSurfaceMemoryJob *job =3D opaque;
> > +    AppleGFXMMIOState *s =3D job->state;
> > +    uintptr_t mem =3D (uintptr_t)job->virtual_address;
> > +    GArray *regions =3D s->iosfc_mapped_regions;
> > +    size_t region_index;
> > +    AppleGFXMMIOMappedRegion *mapped_region =3D
> > +        find_mapped_region_containing(regions, mem, &region_index);
> > +
> > +    if (mapped_region) {
> > +        trace_apple_gfx_iosfc_unmap_memory_region(mem, region_index,
> mapped_region->map_count, mapped_region->region);
> > +        if (--mapped_region->map_count =3D=3D 0) {
> > +            memory_region_unref(mapped_region->region);
> > +            g_array_remove_index_fast(regions, region_index);
> > +        }
> > +    } else {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: memory at %p to be unmappe=
d
> not "
> > +                      "found in any of %u mapped regions.\n",
> > +                      __func__,
> > +                      job->virtual_address, regions->len);
> > +    }
> > +
> > +    qemu_mutex_lock(&s->common.job_mutex);
> > +    job->done =3D true;
> > +    qemu_cond_broadcast(&s->iosfc_unmap_job_cond);
> > +    qemu_mutex_unlock(&s->common.job_mutex);
> > +}
> > +
> > +static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(
> > +    AppleGFXMMIOState *s)
> > +{
> > +    PGIOSurfaceHostDeviceDescriptor *iosfc_desc =3D
> > +        [PGIOSurfaceHostDeviceDescriptor new];
> > +    PGIOSurfaceHostDevice *iosfc_host_dev =3D nil;
> > +
> > +    iosfc_desc.mapMemory =3D
> > +        ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e=
,
> void *f) {
> > +            AppleGFXMapSurfaceMemoryJob job =3D {
> > +                .guest_physical_address =3D phys, .guest_physical_leng=
th
> =3D len,
> > +                .read_only =3D ro, .state =3D s,
> > +            };
> > +
> > +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                    apple_gfx_mmio_map_surface_memory,
> &job);
> > +            apple_gfx_await_bh_job(&s->common, &s->iosfc_map_job_cond,
> &job.done);
> > +
> > +            *va =3D job.result_mem;
> > +
> > +            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f,
> *va,
> > +                                             job.success);
> > +
> > +            return job.success;
> > +        };
> > +
> > +    iosfc_desc.unmapMemory =3D
> > +        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
> > +            AppleGFXUnmapSurfaceMemoryJob job =3D { va, s };
> > +            trace_apple_gfx_iosfc_unmap_memory(va, b, c, d, e, f);
> > +
> > +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +
> apple_gfx_mmio_unmap_surface_memory, &job);
> > +            apple_gfx_await_bh_job(&s->common,
> &s->iosfc_unmap_job_cond, &job.done);
> > +
> > +            return true;
> > +        };
> > +
> > +    iosfc_desc.raiseInterrupt =3D ^bool(uint32_t vector) {
> > +        trace_apple_gfx_iosfc_raise_irq(vector);
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                raise_irq, &s->irq_iosfc);
> > +        return true;
> > +    };
> > +
> > +    iosfc_host_dev =3D
> > +        [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
> > +    [iosfc_desc release];
> > +    return iosfc_host_dev;
> > +}
> > +
> > +static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
> > +{
> > +    @autoreleasepool {
> > +        AppleGFXMMIOState *s =3D APPLE_GFX_MMIO(dev);
> > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];
> > +
> > +        desc.raiseInterrupt =3D ^(uint32_t vector) {
> > +            trace_apple_gfx_raise_irq(vector);
> > +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                    raise_irq, &s->irq_gfx);
> > +        };
> > +
> > +        desc.usingIOSurfaceMapper =3D true;
> > +        s->pgiosfc =3D apple_gfx_prepare_iosurface_host_device(s);
> > +
> > +        s->iosfc_mapped_regions =3D
> > +            g_array_sized_new(false /* no termination */, true /* clea=
r
> */,
> > +                              sizeof(AppleGFXMMIOMappedRegion),
> > +                              2 /* Usually no more RAM regions*/);
> > +
> > +        apple_gfx_common_realize(&s->common, desc, errp);
> > +        qemu_cond_init(&s->iosfc_map_job_cond);
> > +        qemu_cond_init(&s->iosfc_unmap_job_cond);
> > +
> > +        [desc release];
> > +        desc =3D nil;
> > +    }
> > +}
> > +
> > +static void apple_gfx_mmio_init(Object *obj)
> > +{
> > +    AppleGFXMMIOState *s =3D APPLE_GFX_MMIO(obj);
> > +
> > +    apple_gfx_common_init(obj, &s->common, TYPE_APPLE_GFX_MMIO);
> > +
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->common.iomem_gfx);
> > +    memory_region_init_io(&s->iomem_iosfc, obj, &apple_iosfc_ops, s,
> > +                          TYPE_APPLE_GFX_MMIO, 0x10000);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem_iosfc);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_gfx);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_iosfc);
> > +}
> > +
> > +static void apple_gfx_mmio_reset(Object *obj, ResetType type)
> > +{
> > +    AppleGFXMMIOState *s =3D APPLE_GFX_MMIO(obj);
> > +    [s->common.pgdev reset];
> > +}
> > +
> > +
> > +static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +
> > +    rc->phases.hold =3D apple_gfx_mmio_reset;
> > +    dc->hotpluggable =3D false;
> > +    dc->realize =3D apple_gfx_mmio_realize;
> > +}
> > +
> > +static TypeInfo apple_gfx_mmio_types[] =3D {
> > +    {
> > +        .name          =3D TYPE_APPLE_GFX_MMIO,
> > +        .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +        .instance_size =3D sizeof(AppleGFXMMIOState),
> > +        .class_init    =3D apple_gfx_mmio_class_init,
> > +        .instance_init =3D apple_gfx_mmio_init,
> > +    }
> > +};
> > +DEFINE_TYPES(apple_gfx_mmio_types)
> > diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> > new file mode 100644
> > index 00000000000..ef34e8160c8
> > --- /dev/null
> > +++ b/hw/display/apple-gfx.h
> > @@ -0,0 +1,79 @@
> > +/*
> > + * Data structures and functions shared between variants of the macOS
> > + * ParavirtualizedGraphics.framework based apple-gfx display adapter.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef QEMU_APPLE_GFX_H
> > +#define QEMU_APPLE_GFX_H
> > +
> > +#define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
> > +#define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
> > +
> > +#include "qemu/osdep.h"
> > +#include <dispatch/dispatch.h>
> > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> > +#include "qemu/typedefs.h"
> > +#include "exec/memory.h"
> > +#include "ui/surface.h"
> > +
> > +@class PGDeviceDescriptor;
> > +@protocol PGDevice;
> > +@protocol PGDisplay;
> > +@protocol MTLDevice;
> > +@protocol MTLTexture;
> > +@protocol MTLCommandQueue;
> > +
> > +typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
> > +
> > +typedef struct AppleGFXState {
> > +    /* Initialised on init/realize() */
> > +    MemoryRegion iomem_gfx;
> > +    id<PGDevice> pgdev;
> > +    id<PGDisplay> pgdisp;
> > +    QemuConsole *con;
> > +    id<MTLDevice> mtl;
> > +    id<MTLCommandQueue> mtl_queue;
> > +    dispatch_queue_t render_queue;
> > +    /*
> > +     * QemuMutex & QemuConds for awaiting completion of PVG
> memory-mapping and
> > +     * reading requests after submitting them to run in the AIO contex=
t.
> > +     * QemuCond (rather than QemuEvent) are used so multiple concurren=
t
> jobs
> > +     * can be handled safely.
> > +     * The state associated with each job is tracked in a AppleGFX*Job
> struct
> > +     * for each kind of job; instances are allocated on the caller's
> stack.
> > +     * This struct also contains the completion flag which is used in
> > +     * conjunction with the condition variable.
> > +     */
> > +    QemuMutex job_mutex;
> > +    QemuCond task_map_job_cond;
> > +    QemuCond mem_read_job_cond;
> > +
> > +    /* tasks is protected by task_mutex */
> > +    QemuMutex task_mutex;
> > +    PGTaskList tasks;
> > +
> > +    /* Mutable state (BQL) */
> > +    QEMUCursor *cursor;
> > +    bool cursor_show;
> > +    bool gfx_update_requested;
> > +    bool new_frame_ready;
> > +    bool using_managed_texture_storage;
> > +    int32_t pending_frames;
> > +    void *vram;
> > +    DisplaySurface *surface;
> > +    id<MTLTexture> texture;
> > +} AppleGFXState;
> > +
> > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*
> obj_name);
> > +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor
> *desc,
> > +                              Error **errp);
> > +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical=
,
> > +                                               uint64_t length, bool
> read_only,
> > +                                               MemoryRegion
> **mapping_in_region);
> > +void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond,
> > +                            bool *job_done_flag);
> > +
> > +#endif
> > +
> > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> > new file mode 100644
> > index 00000000000..101b38e8a6e
> > --- /dev/null
> > +++ b/hw/display/apple-gfx.m
> > @@ -0,0 +1,773 @@
> > +/*
> > + * QEMU Apple ParavirtualizedGraphics.framework device
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s
> Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * ParavirtualizedGraphics.framework is a set of libraries that macOS
> provides
> > + * which implements 3d graphics passthrough to the host as well as a
> > + * proprietary guest communication channel to drive it. This device
> model
> > + * implements support to drive that library from within QEMU.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> > +#include <mach/mach_vm.h>
> > +#include "apple-gfx.h"
> > +#include "trace.h"
> > +#include "qemu-main.h"
> > +#include "exec/address-spaces.h"
> > +#include "migration/blocker.h"
> > +#include "monitor/monitor.h"
> > +#include "qemu/main-loop.h"
> > +#include "qemu/cutils.h"
> > +#include "qemu/log.h"
> > +#include "qapi/visitor.h"
> > +#include "qapi/error.h"
> > +#include "sysemu/dma.h"
> > +#include "ui/console.h"
> > +
> > +static const PGDisplayCoord_t apple_gfx_modes[] =3D {
> > +    { .x =3D 1440, .y =3D 1080 },
> > +    { .x =3D 1280, .y =3D 1024 },
> > +};
> > +
> > +/* This implements a type defined in
> <ParavirtualizedGraphics/PGDevice.h>
> > + * which is opaque from the framework's point of view. Typedef PGTask_=
t
> already
> > + * exists in the framework headers. */
> > +struct PGTask_s {
> > +    QTAILQ_ENTRY(PGTask_s) node;
> > +    AppleGFXState *s;
> > +    mach_vm_address_t address;
> > +    uint64_t len;
> > +    /*
> > +     * All unique MemoryRegions for which a mapping has been created i=
n
> in this
> > +     * task, and on which we have thus called memory_region_ref().
> There are
> > +     * usually very few regions of system RAM in total, so we expect
> this array
> > +     * to be very short. Therefore, no need for sorting or fancy searc=
h
> > +     * algorithms, linear search will do. */
> > +    GArray *mapped_regions;
>
> Use GPtrArray.
>
>
Thanks, I wasn't aware of this variant.


> > +};
> > +
> > +static Error *apple_gfx_mig_blocker;
> > +
> > +static void apple_gfx_render_frame_completed(AppleGFXState *s,
> > +                                             uint32_t width, uint32_t
> height);
> > +
> > +static dispatch_queue_t get_background_queue(void)
> > +{
> > +    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
> 0);
> > +}
> > +
> > +static PGTask_t *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
> > +{
> > +    mach_vm_address_t task_mem;
> > +    PGTask_t *task;
> > +    kern_return_t r;
> > +
> > +    r =3D mach_vm_allocate(mach_task_self(), &task_mem, len,
> VM_FLAGS_ANYWHERE);
> > +    if (r !=3D KERN_SUCCESS) {
> > +        return NULL;
> > +    }
> > +
> > +    task =3D g_new0(PGTask_t, 1);
> > +    task->s =3D s;
> > +    task->address =3D task_mem;
> > +    task->len =3D len;
> > +    task->mapped_regions =3D g_array_sized_new(false /* no termination=
 */,
> > +                                             true /* clear */,
> > +                                             sizeof(MemoryRegion *),
> > +                                             2 /* Usually no more RAM
> regions*/);
> > +
> > +    QEMU_LOCK_GUARD(&s->task_mutex);
> > +    QTAILQ_INSERT_TAIL(&s->tasks, task, node);
> > +
> > +    return task;
> > +}
> > +
> > +typedef struct AppleGFXIOJob {
> > +    AppleGFXState *state;
> > +    uint64_t offset;
> > +    uint64_t value;
> > +    bool completed;
> > +} AppleGFXIOJob;
> > +
> > +static void apple_gfx_do_read(void *opaque)
> > +{
> > +    AppleGFXIOJob *job =3D opaque;
> > +    job->value =3D [job->state->pgdev mmioReadAtOffset:job->offset];
> > +    qatomic_set(&job->completed, true);
> > +    aio_wait_kick();
> > +}
> > +
> > +static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned
> size)
> > +{
> > +    AppleGFXIOJob job =3D {
> > +        .state =3D opaque,
> > +        .offset =3D offset,
> > +        .completed =3D false,
> > +    };
> > +    dispatch_queue_t queue =3D get_background_queue();
> > +
> > +    dispatch_async_f(queue, &job, apple_gfx_do_read);
> > +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
> > +
> > +    trace_apple_gfx_read(offset, job.value);
> > +    return job.value;
> > +}
> > +
> > +static void apple_gfx_do_write(void *opaque)
> > +{
> > +    AppleGFXIOJob *job =3D opaque;
> > +    [job->state->pgdev mmioWriteAtOffset:job->offset value:job->value]=
;
> > +    qatomic_set(&job->completed, true);
> > +    aio_wait_kick();
> > +}
> > +
> > +static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val,
> > +                            unsigned size)
> > +{
> > +    /* The methods mmioReadAtOffset: and especially mmioWriteAtOffset:
> can
> > +     * trigger and block on operations on other dispatch queues, which
> in turn
> > +     * may call back out on one or more of the callback blocks. For
> this reason,
> > +     * and as we are holding the BQL, we invoke the I/O methods on a
> pool
> > +     * thread and handle AIO tasks while we wait. Any work in the
> callbacks
> > +     * requiring the BQL will in turn schedule BHs which this thread
> will
> > +     * process while waiting. */
> > +    AppleGFXIOJob job =3D {
> > +        .state =3D opaque,
> > +        .offset =3D offset,
> > +        .value =3D val,
> > +        .completed =3D false,
> > +    };
> > +    dispatch_queue_t queue =3D get_background_queue();
> > +
> > +    dispatch_async_f(queue, &job, apple_gfx_do_write);
> > +    AIO_WAIT_WHILE(NULL, !qatomic_read(&job.completed));
> > +
> > +    trace_apple_gfx_write(offset, val);
> > +}
> > +
> > +static const MemoryRegionOps apple_gfx_ops =3D {
> > +    .read =3D apple_gfx_read,
> > +    .write =3D apple_gfx_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void apple_gfx_render_new_frame_bql_unlock(AppleGFXState *s)
> > +{
> > +    BOOL r;
> > +    bool managed_texture =3D s->using_managed_texture_storage;
> > +    uint32_t width =3D surface_width(s->surface);
> > +    uint32_t height =3D surface_height(s->surface);
> > +    MTLRegion region =3D MTLRegionMake2D(0, 0, width, height);
> > +    id<MTLCommandBuffer> command_buffer =3D [s->mtl_queue commandBuffe=
r];
> > +    id<MTLTexture> texture =3D s->texture;
> > +
> > +    assert(bql_locked());
> > +    [texture retain];
> > +
> > +    bql_unlock();
> > +
> > +    /* This is not safe to call from the BQL due to PVG-internal locks
> causing
> > +     * deadlocks. */
> > +    r =3D [s->pgdisp encodeCurrentFrameToCommandBuffer:command_buffer
> > +                                             texture:texture
> > +                                              region:region];
> > +    if (!r) {
> > +        [texture release];
> > +        bql_lock();
> > +        --s->pending_frames;
> > +        bql_unlock();
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s:
> encodeCurrentFrameToCommandBuffer:texture:region: "
> > +                      "failed\n", __func__);
> > +        return;
> > +    }
> > +
> > +    if (managed_texture) {
> > +        /* "Managed" textures exist in both VRAM and RAM and must be
> synced. */
> > +        id<MTLBlitCommandEncoder> blit =3D [command_buffer
> blitCommandEncoder];
> > +        [blit synchronizeResource:texture];
> > +        [blit endEncoding];
> > +    }
> > +    [texture release];
> > +    [command_buffer addCompletedHandler:
> > +        ^(id<MTLCommandBuffer> cb)
> > +        {
> > +            dispatch_async(s->render_queue, ^{
> > +                apple_gfx_render_frame_completed(s, width, height);
> > +            });
> > +        }];
> > +    [command_buffer commit];
> > +}
> > +
> > +static void copy_mtl_texture_to_surface_mem(id<MTLTexture> texture,
> void *vram)
> > +{
> > +    /* TODO: Skip this entirely on a pure Metal or headless/guest-only
> > +     * rendering path, else use a blit command encoder? Needs careful
> > +     * (double?) buffering design. */
> > +    size_t width =3D texture.width, height =3D texture.height;
> > +    MTLRegion region =3D MTLRegionMake2D(0, 0, width, height);
> > +    [texture getBytes:vram
> > +          bytesPerRow:(width * 4)
> > +        bytesPerImage:(width * height * 4)
> > +           fromRegion:region
> > +          mipmapLevel:0
> > +                slice:0];
> > +}
> > +
> > +static void apple_gfx_render_frame_completed(AppleGFXState *s,
> > +                                             uint32_t width, uint32_t
> height)
> > +{
> > +    bql_lock();
> > +    --s->pending_frames;
> > +    assert(s->pending_frames >=3D 0);
> > +
> > +    /* Only update display if mode hasn't changed since we started
> rendering. */
> > +    if (width =3D=3D surface_width(s->surface) &&
> > +        height =3D=3D surface_height(s->surface)) {
> > +        copy_mtl_texture_to_surface_mem(s->texture, s->vram);
> > +        if (s->gfx_update_requested) {
> > +            s->gfx_update_requested =3D false;
> > +            dpy_gfx_update_full(s->con);
> > +            graphic_hw_update_done(s->con);
> > +            s->new_frame_ready =3D false;
> > +        } else {
> > +            s->new_frame_ready =3D true;
> > +        }
> > +    }
> > +    if (s->pending_frames > 0) {
> > +        apple_gfx_render_new_frame_bql_unlock(s);
> > +    } else {
> > +        bql_unlock();
> > +    }
> > +}
> > +
> > +static void apple_gfx_fb_update_display(void *opaque)
> > +{
> > +    AppleGFXState *s =3D opaque;
> > +
> > +    assert(bql_locked());
> > +    if (s->new_frame_ready) {
> > +        dpy_gfx_update_full(s->con);
> > +        s->new_frame_ready =3D false;
> > +        graphic_hw_update_done(s->con);
> > +    } else if (s->pending_frames > 0) {
> > +        s->gfx_update_requested =3D true;
> > +    } else {
> > +        graphic_hw_update_done(s->con);
> > +    }
> > +}
> > +
> > +static const GraphicHwOps apple_gfx_fb_ops =3D {
> > +    .gfx_update =3D apple_gfx_fb_update_display,
> > +    .gfx_update_async =3D true,
> > +};
> > +
> > +static void update_cursor(AppleGFXState *s)
> > +{
> > +    assert(bql_locked());
> > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> > +                  s->pgdisp.cursorPosition.y, s->cursor_show);
> > +}
> > +
> > +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height=
)
> > +{
> > +    MTLTextureDescriptor *textureDescriptor;
> > +
> > +    if (s->surface &&
> > +        width =3D=3D surface_width(s->surface) &&
> > +        height =3D=3D surface_height(s->surface)) {
> > +        return;
> > +    }
> > +
> > +    g_free(s->vram);
> > +    [s->texture release];
> > +
> > +    s->vram =3D g_malloc0_n(width * height, 4);
> > +    s->surface =3D qemu_create_displaysurface_from(width, height,
> PIXMAN_LE_a8r8g8b8,
> > +                                                 width * 4, s->vram);
>
> Use qemu_create_displaysurface() and let DisplaySurface manage the
> memory for us.
>

Yeah, I guess the default pixel format is a close enough match, and now
that the texture content is copied synchronously under the BQL we don't
need to deal with the memory ourselves anymore.



> > +
> > +    @autoreleasepool {
> > +        textureDescriptor =3D
> > +            [MTLTextureDescriptor
> > +
> texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> > +                                             width:width
> > +                                            height:height
> > +                                         mipmapped:NO];
> > +        textureDescriptor.usage =3D s->pgdisp.minimumTextureUsage;
> > +        s->texture =3D [s->mtl
> newTextureWithDescriptor:textureDescriptor];
> > +    }
> > +
> > +    s->using_managed_texture_storage =3D
> > +        (s->texture.storageMode =3D=3D MTLStorageModeManaged);
> > +    dpy_gfx_replace_surface(s->con, s->surface);
> > +}
> > +
> > +static void create_fb(AppleGFXState *s)
> > +{
> > +    s->con =3D graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
> > +    set_mode(s, 1440, 1080);
> > +
> > +    s->cursor_show =3D true;
> > +}
> > +
> > +static size_t apple_gfx_get_default_mmio_range_size(void)
> > +{
> > +    size_t mmio_range_size;
> > +    @autoreleasepool {
> > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];
> > +        mmio_range_size =3D desc.mmioLength;
> > +        [desc release];
> > +    }
> > +    return mmio_range_size;
> > +}
> > +
> > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*
> obj_name)
> > +{
> > +    size_t mmio_range_size =3D apple_gfx_get_default_mmio_range_size()=
;
> > +
> > +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
> > +    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s,
> obj_name,
> > +                          mmio_range_size);
> > +
> > +    /* TODO: PVG framework supports serialising device state: integrat=
e
> it! */
> > +}
> > +
> > +typedef struct AppleGFXMapMemoryJob {
> > +    AppleGFXState *state;
> > +    PGTask_t *task;
> > +    uint64_t virtual_offset;
> > +    PGPhysicalMemoryRange_t *ranges;
> > +    uint32_t range_count;
> > +    bool read_only;
> > +    bool success;
> > +    bool done;
> > +} AppleGFXMapMemoryJob;
> > +
> > +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physical=
,
> > +                                               uint64_t length, bool
> read_only,
> > +                                               MemoryRegion
> **mapping_in_region)
> > +{
> > +    MemoryRegion *ram_region;
> > +    uintptr_t host_address;
> > +    hwaddr ram_region_offset =3D 0;
> > +    hwaddr ram_region_length =3D length;
> > +
> > +    ram_region =3D address_space_translate(&address_space_memory,
> > +                                         guest_physical,
> > +                                         &ram_region_offset,
> > +                                         &ram_region_length, !read_onl=
y,
> > +                                         MEMTXATTRS_UNSPECIFIED);
> > +
> > +    if (!ram_region || ram_region_length < length ||
> > +        !memory_access_is_direct(ram_region, !read_only)) {
> > +        return 0;
> > +    }
> > +
> > +    host_address =3D (uintptr_t)memory_region_get_ram_ptr(ram_region);
> > +    if (host_address =3D=3D 0) {
> > +        return 0;
> > +    }
> > +    host_address +=3D ram_region_offset;
> > +    *mapping_in_region =3D ram_region;
> > +    return host_address;
> > +}
> > +
> > +/* Returns false if the region is already in the array */
> > +static bool add_new_region(GArray *regions, MemoryRegion *region)
> > +{
> > +    MemoryRegion *existing;
> > +    size_t i;
> > +
> > +    for (i =3D 0; i < regions->len; ++i) {
> > +        existing =3D g_array_index(regions, MemoryRegion *, i);
> > +        if (existing =3D=3D region) {
> > +            return false;
> > +        }
> > +    }
> > +    g_array_append_val(regions, region);
> > +    return true;
> > +}
> > +
> > +static void apple_gfx_map_memory(void *opaque)
> > +{
> > +    AppleGFXMapMemoryJob *job       =3D opaque;
> > +    AppleGFXState *s                =3D job->state;
> > +    PGTask_t *task                  =3D job->task;
> > +    uint32_t range_count            =3D job->range_count;
> > +    uint64_t virtual_offset         =3D job->virtual_offset;
> > +    PGPhysicalMemoryRange_t *ranges =3D job->ranges;
> > +    bool read_only                  =3D job->read_only;
> > +    kern_return_t r;
> > +    mach_vm_address_t target, source;
> > +    vm_prot_t cur_protection, max_protection;
> > +    bool success =3D true;
> > +    MemoryRegion *region;
> > +
> > +    g_assert(bql_locked());
>
> It seems this function only requires RCU read lock and we can avoid
> using bottom half.
>

Yes, I think that should work. We'll still need something to serialise
access to the task's mapped_regions array, but we can use the task_mutex
instead of the BQL for that.

I guess dma_memory_read() also only needs an RCU guard, so readMemory
should also be safe to run without the BQL?


> > +
> > +    trace_apple_gfx_map_memory(task, range_count, virtual_offset,
> read_only);
> > +    for (int i =3D 0; i < range_count; i++) {
> > +        PGPhysicalMemoryRange_t *range =3D &ranges[i];
> > +
> > +        target =3D task->address + virtual_offset;
> > +        virtual_offset +=3D range->physicalLength;
> > +
> > +        trace_apple_gfx_map_memory_range(i, range->physicalAddress,
> > +                                         range->physicalLength);
> > +
> > +        region =3D NULL;
> > +        source =3D
> apple_gfx_host_address_for_gpa_range(range->physicalAddress,
> > +
> range->physicalLength,
> > +                                                      read_only,
> &region);
> > +        if (source =3D=3D 0) {
> > +            success =3D false;
> > +            continue;
> > +        }
> > +
> > +        if (add_new_region(task->mapped_regions, region)) {
> > +            memory_region_ref(region);
> > +        }
> > +
> > +        cur_protection =3D 0;
> > +        max_protection =3D 0;
> > +        // Map guest RAM at range->physicalAddress into PG task memory
> range
> > +        r =3D mach_vm_remap(mach_task_self(),
> > +                          &target, range->physicalLength, vm_page_size
> - 1,
> > +                          VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,
> > +                          mach_task_self(),
> > +                          source, false /* shared mapping, no copy */,
> > +                          &cur_protection, &max_protection,
> > +                          VM_INHERIT_COPY);
> > +        trace_apple_gfx_remap(r, source, target);
> > +        g_assert(r =3D=3D KERN_SUCCESS);
> > +    }
> > +
> > +    qemu_mutex_lock(&s->job_mutex);
> > +    job->success =3D success;
> > +    job->done =3D true;
> > +    qemu_cond_broadcast(&s->task_map_job_cond);
> > +    qemu_mutex_unlock(&s->job_mutex);
> > +}
> > +
> > +void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond, bool
> *job_done_flag)
> > +{
> > +    qemu_mutex_lock(&s->job_mutex);
> > +    while (!*job_done_flag) {
> > +        qemu_cond_wait(job_cond, &s->job_mutex);
> > +    }
> > +    qemu_mutex_unlock(&s->job_mutex);
> > +}
> > +
> > +typedef struct AppleGFXReadMemoryJob {
> > +    AppleGFXState *s;
> > +    hwaddr physical_address;
> > +    uint64_t length;
> > +    void *dst;
> > +    bool done;
> > +    bool success;
> > +} AppleGFXReadMemoryJob;
> > +
> > +static void apple_gfx_do_read_memory(void *opaque)
> > +{
> > +    AppleGFXReadMemoryJob *job =3D opaque;
> > +    AppleGFXState *s =3D job->s;
> > +    MemTxResult r;
> > +
> > +    r =3D dma_memory_read(&address_space_memory, job->physical_address=
,
> > +                        job->dst, job->length, MEMTXATTRS_UNSPECIFIED)=
;
> > +    job->success =3D r =3D=3D MEMTX_OK;
> > +
> > +    qemu_mutex_lock(&s->job_mutex);
> > +    job->done =3D true;
> > +    qemu_cond_broadcast(&s->mem_read_job_cond);
> > +    qemu_mutex_unlock(&s->job_mutex);
> > +}
> > +
> > +static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr
> physical_address,
> > +                                  uint64_t length, void *dst)
> > +{
> > +    AppleGFXReadMemoryJob job =3D {
> > +        s, physical_address, length, dst
> > +    };
> > +
> > +    trace_apple_gfx_read_memory(physical_address, length, dst);
> > +
> > +    /* Traversing the memory map requires RCU/BQL, so do it in a BH. *=
/
> > +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> apple_gfx_do_read_memory,
> > +                            &job);
> > +    apple_gfx_await_bh_job(s, &s->mem_read_job_cond, &job.done);
> > +    return job.success;
> > +}
> > +
> > +static void apple_gfx_task_destroy(AppleGFXState *s, PGTask_t *task)
> > +{
> > +    GArray *regions =3D task->mapped_regions;
> > +    MemoryRegion *region;
> > +    size_t i;
> > +
> > +    for (i =3D 0; i < regions->len; ++i) {
> > +        region =3D g_array_index(regions, MemoryRegion *, i);
> > +        memory_region_unref(region);
> > +    }
> > +    g_array_unref(regions);
> > +
> > +    mach_vm_deallocate(mach_task_self(), task->address, task->len);
> > +
> > +    QEMU_LOCK_GUARD(&s->task_mutex);
> > +    QTAILQ_REMOVE(&s->tasks, task, node);
> > +    g_free(task);
> > +}
> > +
> > +static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> > +                                                     PGDeviceDescripto=
r
> *desc)
> > +{
> > +    desc.createTask =3D ^(uint64_t vmSize, void * _Nullable * _Nonnull
> baseAddress) {
> > +        PGTask_t *task =3D apple_gfx_new_task(s, vmSize);
> > +        *baseAddress =3D (void *)task->address;
> > +        trace_apple_gfx_create_task(vmSize, *baseAddress);
> > +        return task;
> > +    };
> > +
> > +    desc.destroyTask =3D ^(PGTask_t * _Nonnull task) {
> > +        trace_apple_gfx_destroy_task(task, task->mapped_regions->len);
> > +
> > +        apple_gfx_task_destroy(s, task);
> > +    };
> > +
> > +    desc.mapMemory =3D ^bool(PGTask_t * _Nonnull task, uint32_t
> range_count,
> > +                           uint64_t virtual_offset, bool read_only,
> > +                           PGPhysicalMemoryRange_t * _Nonnull ranges) =
{
> > +        AppleGFXMapMemoryJob job =3D {
> > +            .state =3D s,
> > +            .task =3D task, .ranges =3D ranges, .range_count =3D range=
_count,
> > +            .read_only =3D read_only, .virtual_offset =3D virtual_offs=
et,
> > +            .done =3D false, .success =3D true,
> > +        };
> > +        if (range_count > 0) {
> > +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                    apple_gfx_map_memory, &job);
> > +            apple_gfx_await_bh_job(s, &s->task_map_job_cond, &job.done=
);
> > +        }
> > +        return job.success;
> > +    };
> > +
> > +    desc.unmapMemory =3D ^bool(PGTask_t * _Nonnull task, uint64_t
> virtualOffset,
> > +                             uint64_t length) {
> > +        kern_return_t r;
> > +        mach_vm_address_t range_address;
> > +
> > +        trace_apple_gfx_unmap_memory(task, virtualOffset, length);
> > +
> > +        /* Replace task memory range with fresh pages, undoing the
> mapping
> > +         * from guest RAM. */
> > +        range_address =3D task->address + virtualOffset;
> > +        r =3D mach_vm_allocate(mach_task_self(), &range_address, lengt=
h,
> > +                             VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE);
>  > +        g_assert(r =3D=3D KERN_SUCCESS);> +
> > +        return true;
> > +    };
> > +
> > +    desc.readMemory =3D ^bool(uint64_t physical_address, uint64_t leng=
th,
> > +                            void * _Nonnull dst) {
> > +        return apple_gfx_read_memory(s, physical_address, length, dst)=
;
> > +    };
> > +}
> > +
> > +static PGDisplayDescriptor
> *apple_gfx_prepare_display_descriptor(AppleGFXState *s)
> > +{
> > +    PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor new];
> > +
> > +    disp_desc.name =3D @"QEMU display";
> > +    disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.); /* A 20"
> display */
> > +    disp_desc.queue =3D dispatch_get_main_queue();
> > +    disp_desc.newFrameEventHandler =3D ^(void) {
> > +        trace_apple_gfx_new_frame();
> > +        dispatch_async(s->render_queue, ^{
> > +            /* Drop frames if we get too far ahead. */
> > +            bql_lock();
> > +            if (s->pending_frames >=3D 2) {
> > +                bql_unlock();
> > +                return;
> > +            }
> > +            ++s->pending_frames;
> > +            if (s->pending_frames > 1) {
> > +                bql_unlock();
> > +                return;
> > +            }
> > +            @autoreleasepool {
> > +                apple_gfx_render_new_frame_bql_unlock(s);
> > +            }
> > +        });
> > +    };
> > +    disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t sizeInPixels,
> > +                                    OSType pixelFormat) {
> > +        trace_apple_gfx_mode_change(sizeInPixels.x, sizeInPixels.y);
> > +
> > +        BQL_LOCK_GUARD();
> > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> > +    };
> > +    disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *glyph,
> > +                                     PGDisplayCoord_t hotSpot) {
> > +        [glyph retain];
> > +        dispatch_async(get_background_queue(), ^{
> > +            BQL_LOCK_GUARD();
>
> This would be better off using a bottom half since it is going to take
> the BQL.
>

Yeah, I guess that should work now that we've eliminated any calls into PVG
while holding the BQL.


> > +            uint32_t bpp =3D glyph.bitsPerPixel;
> > +            size_t width =3D glyph.pixelsWide;
> > +            size_t height =3D glyph.pixelsHigh;
> > +            size_t padding_bytes_per_row =3D glyph.bytesPerRow - width=
 *
> 4;
> > +            const uint8_t* px_data =3D glyph.bitmapData;
> > +
> > +            trace_apple_gfx_cursor_set(bpp, width, height);
> > +
> > +            if (s->cursor) {
> > +                cursor_unref(s->cursor);
> > +                s->cursor =3D NULL;
> > +            }
> > +
> > +            if (bpp =3D=3D 32) { /* Shouldn't be anything else, but ju=
st to
> be safe...*/
> > +                s->cursor =3D cursor_alloc(width, height);
> > +                s->cursor->hot_x =3D hotSpot.x;
> > +                s->cursor->hot_y =3D hotSpot.y;
> > +
> > +                uint32_t *dest_px =3D s->cursor->data;
> > +
> > +                for (size_t y =3D 0; y < height; ++y) {
> > +                    for (size_t x =3D 0; x < width; ++x) {
> > +                        /* NSBitmapImageRep's red & blue channels are
> swapped
> > +                         * compared to QEMUCursor's. */
> > +                        *dest_px =3D
> > +                            (px_data[0] << 16u) |
> > +                            (px_data[1] <<  8u) |
> > +                            (px_data[2] <<  0u) |
> > +                            (px_data[3] << 24u);
> > +                        ++dest_px;
> > +                        px_data +=3D 4;
> > +                    }
> > +                    px_data +=3D padding_bytes_per_row;
> > +                }
> > +                dpy_cursor_define(s->con, s->cursor);
> > +                update_cursor(s);
> > +            }
> > +            [glyph release];
> > +        });
> > +    };
> > +    disp_desc.cursorShowHandler =3D ^(BOOL show) {
> > +        dispatch_async(get_background_queue(), ^{
> > +            BQL_LOCK_GUARD();
> > +            trace_apple_gfx_cursor_show(show);
> > +            s->cursor_show =3D show;
> > +            update_cursor(s);
> > +        });
> > +    };
> > +    disp_desc.cursorMoveHandler =3D ^(void) {
> > +        dispatch_async(get_background_queue(), ^{
> > +            BQL_LOCK_GUARD();
> > +            trace_apple_gfx_cursor_move();
> > +            update_cursor(s);
> > +        });
> > +    };
> > +
> > +    return disp_desc;
> > +}
> > +
> > +static NSArray<PGDisplayMode*>*
> apple_gfx_prepare_display_mode_array(void)
> > +{
> > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> > +    NSArray<PGDisplayMode*>* mode_array =3D nil;
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> > +        modes[i] =3D
> > +            [[PGDisplayMode alloc]
> initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
> > +    }
> > +
> > +    mode_array =3D [NSArray arrayWithObjects:modes
> count:ARRAY_SIZE(apple_gfx_modes)];
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> > +        [modes[i] release];
> > +        modes[i] =3D nil;
> > +    }
> > +
> > +    return mode_array;
> > +}
> > +
> > +static id<MTLDevice> copy_suitable_metal_device(void)
> > +{
> > +    id<MTLDevice> dev =3D nil;
> > +    NSArray<id<MTLDevice>> *devs =3D MTLCopyAllDevices();
> > +
> > +    /* Prefer a unified memory GPU. Failing that, pick a non-removable
> GPU. */
> > +    for (size_t i =3D 0; i < devs.count; ++i) {
> > +        if (devs[i].hasUnifiedMemory) {
> > +            dev =3D devs[i];
> > +            break;
> > +        }
> > +        if (!devs[i].removable) {
> > +            dev =3D devs[i];
> > +        }
> > +    }
> > +
> > +    if (dev !=3D nil) {
> > +        [dev retain];
> > +    } else {
> > +        dev =3D MTLCreateSystemDefaultDevice();
> > +    }
> > +    [devs release];
> > +
> > +    return dev;
> > +}
> > +
> > +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor
> *desc,
> > +                              Error **errp)
> > +{
> > +    PGDisplayDescriptor *disp_desc =3D nil;
> > +
> > +    if (apple_gfx_mig_blocker =3D=3D NULL) {
> > +        error_setg(&apple_gfx_mig_blocker,
> > +                  "Migration state blocked by apple-gfx display
> device");
> > +        if (migrate_add_blocker(&apple_gfx_mig_blocker, errp) < 0) {
> > +            return;
> > +        }
> > +    }
> > +
> > +    qemu_mutex_init(&s->task_mutex);
> > +    QTAILQ_INIT(&s->tasks);
> > +    s->render_queue =3D dispatch_queue_create("apple-gfx.render",
> > +                                            DISPATCH_QUEUE_SERIAL);
> > +    s->mtl =3D copy_suitable_metal_device();
> > +    s->mtl_queue =3D [s->mtl newCommandQueue];
> > +
> > +    desc.device =3D s->mtl;
> > +
> > +    apple_gfx_register_task_mapping_handlers(s, desc);
> > +
> > +    s->pgdev =3D PGNewDeviceWithDescriptor(desc);
> > +
> > +    disp_desc =3D apple_gfx_prepare_display_descriptor(s);
> > +    s->pgdisp =3D [s->pgdev newDisplayWithDescriptor:disp_desc
> > +                                              port:0 serialNum:1234];
> > +    [disp_desc release];
> > +    s->pgdisp.modeList =3D apple_gfx_prepare_display_mode_array();
> > +
> > +    create_fb(s);
> > +
> > +    qemu_mutex_init(&s->job_mutex);
> > +    qemu_cond_init(&s->task_map_job_cond);
> > +    qemu_cond_init(&s->mem_read_job_cond);
> > +}
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index 20a94973fa2..619e642905a 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -61,6 +61,10 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true:
> files('artist.c'))
> >
> >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c',
> 'ati_2d.c', 'ati_dbg.c'), pixman])
> >
> > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
> [files('apple-gfx.m'), pvg, metal])
> > +if cpu =3D=3D 'aarch64'
> > +  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true:
> [files('apple-gfx-mmio.m'), pvg, metal])
> > +endif
> >
> >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >     virtio_gpu_ss =3D ss.source_set()
> > diff --git a/hw/display/trace-events b/hw/display/trace-events
> > index 781f8a33203..d63fba6d094 100644
> > --- a/hw/display/trace-events
> > +++ b/hw/display/trace-events
> > @@ -191,3 +191,31 @@ dm163_bits_ppi(unsigned dest_width) "dest_width :
> %u"
> >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> >   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
> >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> > +
> > +# apple-gfx.m
> > +apple_gfx_read(uint64_t offset, uint64_t res) "offset=3D0x%"PRIx64"
> res=3D0x%"PRIx64
> > +apple_gfx_write(uint64_t offset, uint64_t val) "offset=3D0x%"PRIx64"
> val=3D0x%"PRIx64
> > +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=3D0x%x
> base_addr=3D%p"
> > +apple_gfx_destroy_task(void *task, unsigned int num_mapped_regions)
> "task=3D%p, task->mapped_regions->len=3D%u"
> > +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t
> virtual_offset, uint32_t read_only) "task=3D%p range_count=3D0x%x
> virtual_offset=3D0x%"PRIx64" read_only=3D%d"
> > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t
> phys_len) "[%d] phys_addr=3D0x%"PRIx64" phys_len=3D0x%"PRIx64
> > +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t target)
> "retval=3D%"PRId64" source=3D0x%"PRIx64" target=3D0x%"PRIx64
> > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t
> length) "task=3D%p virtual_offset=3D0x%"PRIx64" length=3D0x%"PRIx64
> > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void
> *dst) "phys_addr=3D0x%"PRIx64" length=3D0x%"PRIx64" dest=3D%p"
> > +apple_gfx_raise_irq(uint32_t vector) "vector=3D0x%x"
> > +apple_gfx_new_frame(void) ""
> > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=3D%"PRId64" y=3D%"PRI=
d64
> > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height)
> "bpp=3D%d width=3D%"PRId64" height=3D0x%"PRId64
> > +apple_gfx_cursor_show(uint32_t show) "show=3D%d"
> > +apple_gfx_cursor_move(void) ""
> > +apple_gfx_common_init(const char *device_name, size_t mmio_size)
> "device: %s; MMIO size: %zu bytes"
> > +
> > +# apple-gfx-mmio.m
> > +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res)
> "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> > +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val)
> "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> > +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro,
> void *va, void *e, void *f, void* va_result, int success) "phys=3D0x%"PRI=
x64"
> len=3D0x%"PRIx64" ro=3D%d va=3D%p e=3D%p f=3D%p -> *va=3D%p, success =3D =
%d"
> > +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_t
> start, uint64_t end) "index=3D%zu, region=3D%p, 0x%"PRIx64"-0x%"PRIx64
> > +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void
> *e, void *f) "a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p"
> > +apple_gfx_iosfc_unmap_memory_region(uint64_t mem, size_t region_index,
> uint64_t map_count, void *region) "mapping @ 0x%"PRIx64" in region %zu, m=
ap
> count %"PRIu64", memory region %p"
> > +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=3D0x%x"
> > +
> > diff --git a/meson.build b/meson.build
> > index f7d45175212..5eab46f704f 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -769,6 +769,8 @@ socket =3D []
> >   version_res =3D []
> >   coref =3D []
> >   iokit =3D []
> > +pvg =3D []
> > +metal =3D []
> >   emulator_link_args =3D []
> >   midl =3D not_found
> >   widl =3D not_found
> > @@ -790,6 +792,8 @@ elif host_os =3D=3D 'darwin'
> >     coref =3D dependency('appleframeworks', modules: 'CoreFoundation')
> >     iokit =3D dependency('appleframeworks', modules: 'IOKit', required:
> false)
> >     host_dsosuf =3D '.dylib'
> > +  pvg =3D dependency('appleframeworks', modules:
> 'ParavirtualizedGraphics')
> > +  metal =3D dependency('appleframeworks', modules: 'Metal')
> >   elif host_os =3D=3D 'sunos'
> >     socket =3D [cc.find_library('socket'),
> >               cc.find_library('nsl'),
>
>

--00000000000016df020625e0bdd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for taking a look at this latest iteration. So=
me thoughts on your comments inline:<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 31 Oct 2024 at 10:32, Akihi=
ko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@dayn=
ix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 2024/10/30 5:58, Phil Dennis-Jordan wrote:<br>
&gt; MacOS provides a framework (library) that allows any vmm to implement =
a<br>
&gt; paravirtualized 3d graphics passthrough to the host metal stack called=
<br>
&gt; ParavirtualizedGraphics.Framework (PVG). The library abstracts away<br=
>
&gt; almost every aspect of the paravirtualized device model and only provi=
des<br>
&gt; and receives callbacks on MMIO access as well as to share memory addre=
ss<br>
&gt; space between the VM and PVG.<br>
&gt; <br>
&gt; This patch implements a QEMU device that drives PVG for the VMApple<br=
>
&gt; variant of it.<br>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Co-authored-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" =
target=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; Subsequent changes:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Cherry-pick/rebase conflict fixes, API use updates.<br>
&gt;=C2=A0 =C2=A0* Moved from hw/vmapple/ (useful outside that machine type=
)<br>
&gt;=C2=A0 =C2=A0* Overhaul of threading model, many thread safety improvem=
ents.<br>
&gt;=C2=A0 =C2=A0* Asynchronous rendering.<br>
&gt;=C2=A0 =C2=A0* Memory and object lifetime fixes.<br>
&gt;=C2=A0 =C2=A0* Refactoring to split generic and (vmapple) MMIO variant =
specific<br>
&gt;=C2=A0 =C2=A0 =C2=A0code.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt; v2:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Cherry-pick/rebase conflict fixes<br>
&gt;=C2=A0 =C2=A0* BQL function renaming<br>
&gt;=C2=A0 =C2=A0* Moved from hw/vmapple/ (useful outside that machine type=
)<br>
&gt;=C2=A0 =C2=A0* Code review comments: Switched to DEFINE_TYPES macro &am=
p; little endian<br>
&gt;=C2=A0 =C2=A0 =C2=A0MMIO.<br>
&gt;=C2=A0 =C2=A0* Removed some dead/superfluous code<br>
&gt;=C2=A0 =C2=A0* Mad set_mode thread &amp; memory safe<br>
&gt;=C2=A0 =C2=A0* Added migration blocker due to lack of (de-)serialisatio=
n.<br>
&gt;=C2=A0 =C2=A0* Fixes to ObjC refcounting and autorelease pool usage.<br=
>
&gt;=C2=A0 =C2=A0* Fixed ObjC new/init misuse<br>
&gt;=C2=A0 =C2=A0* Switched to ObjC category extension for private property=
.<br>
&gt;=C2=A0 =C2=A0* Simplified task memory mapping and made it thread safe.<=
br>
&gt;=C2=A0 =C2=A0* Refactoring to split generic and vmapple MMIO variant sp=
ecific<br>
&gt;=C2=A0 =C2=A0 =C2=A0code.<br>
&gt;=C2=A0 =C2=A0* Switched to asynchronous MMIO writes on x86-64<br>
&gt;=C2=A0 =C2=A0* Rendering and graphics update are now done asynchronousl=
y<br>
&gt;=C2=A0 =C2=A0* Fixed cursor handling<br>
&gt;=C2=A0 =C2=A0* Coding convention fixes<br>
&gt;=C2=A0 =C2=A0* Removed software cursor compositing<br>
&gt; <br>
&gt; v3:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Rebased on latest upstream, fixed breakages including sw=
itching to Resettable methods.<br>
&gt;=C2=A0 =C2=A0* Squashed patches dealing with dGPUs, MMIO area size, and=
 GPU picking.<br>
&gt;=C2=A0 =C2=A0* Allow re-entrant MMIO; this simplifies the code and solv=
es the divergence<br>
&gt;=C2=A0 =C2=A0 =C2=A0between x86-64 and arm64 variants.<br>
&gt; <br>
&gt; v4:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Renamed &#39;-vmapple&#39; device variant to &#39;-mmio&=
#39;<br>
&gt;=C2=A0 =C2=A0* MMIO device type now requires aarch64 host and guest<br>
&gt;=C2=A0 =C2=A0* Complete overhaul of the glue code for making Qemu&#39;s=
 and<br>
&gt;=C2=A0 =C2=A0 =C2=A0ParavirtualizedGraphics.framework&#39;s threading a=
nd synchronisation models<br>
&gt;=C2=A0 =C2=A0 =C2=A0work together. Calls into PVG are from dispatch que=
ues while the<br>
&gt;=C2=A0 =C2=A0 =C2=A0BQL-holding initiating thread processes AIO context=
 events; callbacks from<br>
&gt;=C2=A0 =C2=A0 =C2=A0PVG are scheduled as BHs on the BQL/main AIO contex=
t, awaiting completion<br>
&gt;=C2=A0 =C2=A0 =C2=A0where necessary.<br>
&gt;=C2=A0 =C2=A0* Guest frame rendering state is covered by the BQL, with =
only the PVG calls<br>
&gt;=C2=A0 =C2=A0 =C2=A0outside the lock, and serialised on the named rende=
r_queue.<br>
&gt;=C2=A0 =C2=A0* Simplified logic for dropping frames in-flight during mo=
de changes, fixed<br>
&gt;=C2=A0 =C2=A0 =C2=A0bug in pending frames logic.<br>
&gt;=C2=A0 =C2=A0* Addressed smaller code review notes such as: function na=
ming, object type<br>
&gt;=C2=A0 =C2=A0 =C2=A0declarations, type names/declarations/casts, code f=
ormatting, #include<br>
&gt;=C2=A0 =C2=A0 =C2=A0order, over-cautious ObjC retain/release, what goes=
 in init vs realize,<br>
&gt;=C2=A0 =C2=A0 =C2=A0etc.<br>
&gt; <br>
&gt; v5:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Smaller non-functional fixes in response to review comme=
nts, such as using<br>
&gt;=C2=A0 =C2=A0 =C2=A0NULL for the AIO_WAIT_WHILE context argument, type =
name formatting,<br>
&gt;=C2=A0 =C2=A0 =C2=A0deleting leftover debug code, logging improvements,=
 state struct field<br>
&gt;=C2=A0 =C2=A0 =C2=A0order and documentation improvements, etc.<br>
&gt;=C2=A0 =C2=A0* Instead of a single condition variable for all synchrono=
us BH job types,<br>
&gt;=C2=A0 =C2=A0 =C2=A0there is now one for each callback block. This redu=
ces the number<br>
&gt;=C2=A0 =C2=A0 =C2=A0of threads being awoken unnecessarily to near zero.=
<br>
&gt;=C2=A0 =C2=A0* MMIO device variant: Unified the BH job for raising inte=
rrupts.<br>
&gt;=C2=A0 =C2=A0* Use DMA APIs for PVG framework&#39;s guest memory read r=
equests.<br>
&gt;=C2=A0 =C2=A0* Thread safety improvements: ensure mutable AppleGFXState=
 fields are not<br>
&gt;=C2=A0 =C2=A0 =C2=A0accessed outside the appropriate lock. Added dedica=
ted mutex for the task<br>
&gt;=C2=A0 =C2=A0 =C2=A0list.<br>
&gt;=C2=A0 =C2=A0* Retain references to MemoryRegions for which there exist=
 mappings in each<br>
&gt;=C2=A0 =C2=A0 =C2=A0PGTask, and for IOSurface mappings.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/display/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx-mmio.m | 387 ++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 79 ++++=
<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx.m=C2=A0 =C2=A0 =C2=A0 | 773 +++++++++=
+++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04=
 +<br>
&gt;=C2=A0 =C2=A0hw/display/trace-events=C2=A0 =C2=A0 =C2=A0|=C2=A0 28 ++<b=
r>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A07 files changed, 1284 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/apple-gfx-mmio.m<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/apple-gfx.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/apple-gfx.m<br>
&gt; <br>
&gt; diff --git a/hw/display/Kconfig b/hw/display/Kconfig<br>
&gt; index 2250c740078..6a9b7b19ada 100644<br>
&gt; --- a/hw/display/Kconfig<br>
&gt; +++ b/hw/display/Kconfig<br>
&gt; @@ -140,3 +140,12 @@ config XLNX_DISPLAYPORT<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0config DM163<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt; +<br>
&gt; +config MAC_PVG<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 default y<br>
&gt; +<br>
&gt; +config MAC_PVG_MMIO<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 depends on MAC_PVG &amp;&amp; AARCH64<br>
&gt; +<br>
&gt; diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m=
<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..b0c5669a344<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/apple-gfx-mmio.m<br>
&gt; @@ -0,0 +1,387 @@<br>
&gt; +/*<br>
&gt; + * QEMU Apple ParavirtualizedGraphics.framework device, MMIO (arm64) =
variant<br>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Righ=
ts Reserved.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + *<br>
&gt; + * ParavirtualizedGraphics.framework is a set of libraries that macOS=
 provides<br>
&gt; + * which implements 3d graphics passthrough to the host as well as a<=
br>
&gt; + * proprietary guest communication channel to drive it. This device m=
odel<br>
&gt; + * implements support to drive that library from within QEMU as an MM=
IO-based<br>
&gt; + * system device for macOS on arm64 VMs.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#import &lt;ParavirtualizedGraphics/ParavirtualizedGraphics.h&gt;<br>
&gt; +#include &quot;apple-gfx.h&quot;<br>
&gt; +#include &quot;monitor/monitor.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXMMIOState, APPLE_GFX_MMIO)<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * ParavirtualizedGraphics.Framework only ships header files for the =
PCI<br>
&gt; + * variant which does not include IOSFC descriptors and host devices.=
 We add<br>
&gt; + * their definitions here so that we can also work with the ARM versi=
on.<br>
&gt; + */<br>
&gt; +typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);<br>
&gt; +typedef bool(^IOSFCUnmapMemory)(<br>
&gt; +=C2=A0 =C2=A0 void *, void *, void *, void *, void *, void *);<br>
&gt; +typedef bool(^IOSFCMapMemory)(<br>
&gt; +=C2=A0 =C2=A0 uint64_t phys, uint64_t len, bool ro, void **va, void *=
, void *);<br>
&gt; +<br>
&gt; +@interface PGDeviceDescriptor (IOSurfaceMapper)<br>
&gt; +@property (readwrite, nonatomic) bool usingIOSurfaceMapper;<br>
&gt; +@end<br>
&gt; +<br>
&gt; +@interface PGIOSurfaceHostDeviceDescriptor : NSObject<br>
&gt; +-(PGIOSurfaceHostDeviceDescriptor *)init;<br>
&gt; +@property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMe=
mory;<br>
&gt; +@property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unm=
apMemory;<br>
&gt; +@property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt =
raiseInterrupt;<br>
&gt; +@end<br>
&gt; +<br>
&gt; +@interface PGIOSurfaceHostDevice : NSObject<br>
&gt; +-(instancetype)initWithDescriptor:(PGIOSurfaceHostDeviceDescriptor *)=
desc;<br>
&gt; +-(uint32_t)mmioReadAtOffset:(size_t)offset;<br>
&gt; +-(void)mmioWriteAtOffset:(size_t)offset value:(uint32_t)value;<br>
&gt; +@end<br>
&gt; +<br>
&gt; +struct AppleGFXMapSurfaceMemoryJob;<br>
&gt; +struct AppleGFXMMIOState {<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState common;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QemuCond iosfc_map_job_cond;<br>
&gt; +=C2=A0 =C2=A0 QemuCond iosfc_unmap_job_cond;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq_gfx;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq_iosfc;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem_iosfc;<br>
&gt; +=C2=A0 =C2=A0 PGIOSurfaceHostDevice *pgiosfc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 GArray *iosfc_mapped_regions; /* array of AppleGFXMMIOM=
appedRegion */<br>
<br>
We don&#39;t need to have an array but we can get the memory region with <b=
r>
address_space_translate() when mapping or with memory_region_from_host() <b=
r>
when unmapping.<br></blockquote><div><br></div><div>Yeah, I guess that work=
s. Lots of memory_region_ref()/memory_region_unref() calls, but I guess the=
 address_space_translate() call is much more expensive anyway. I originally=
 wanted to store the physical range of the RAM region so we don&#39;t need =
to keep looking up the physical address on mapping, but there does not seem=
 to be a good way to obtain the guest-physical start address of the result =
of a address_space_translate() call as only part of the region might be map=
ped contiguously. (Unless you&#39;ve got a good suggestion for that? I was =
wondering about subtracting the offset returned from address_space_translat=
e() from the guest physical address then re-running address_space_translate=
() with that and the memory region&#39;s size to check if all of it is mapp=
ed.)</div><div><br></div><div>For background:</div><div>In my testing, the =
system performs  thousands of these IOSurface memory mappings per second, w=
ith tens of thousands of mappings alive at any time. The vast majority are =
1 page [16KiB] in size, and they are unmapped in batches of tens of thousan=
ds. In practice, there is only one MemoryRegion involved in all of this, wh=
ich is the MemoryRegion containing all of the VM&#39;s system memory. So al=
l of this lookup and referencing and unreferencing ultimately seems pretty =
pointless because all that really needs to be done is work out the offset i=
n guest RAM and add it to the host-side pointer. But hypothetically, the RA=
M topology could be more complex, so we have to jump through all these hoop=
s.</div><div>The situation is similar in the task memory-mapping callback o=
f the main/common PVG device, except there aren&#39;t so many mappings and =
they are larger. As that&#39;s also used in the PCI variant, you also get t=
o deal with the fun of the non-contiguous x86-64 guest system memory.<br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +};<br>
&gt; +<br>
&gt; +typedef struct AppleGFXMMIOJob {<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOState *state;<br>
&gt; +=C2=A0 =C2=A0 uint64_t offset;<br>
&gt; +=C2=A0 =C2=A0 uint64_t value;<br>
&gt; +=C2=A0 =C2=A0 bool completed;<br>
&gt; +} AppleGFXMMIOJob;<br>
&gt; +<br>
&gt; +static void iosfc_do_read(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 job-&gt;value =3D [job-&gt;state-&gt;pgiosfc mmioReadAt=
Offset:job-&gt;offset];<br>
&gt; +=C2=A0 =C2=A0 qatomic_set(&amp;job-&gt;completed, true);<br>
&gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t iosfc_read(void *opaque, hwaddr offset, unsigned size=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =3D offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .completed =3D false,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D dispatch_get_global_queue(DI=
SPATCH_QUEUE_PRIORITY_DEFAULT, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_async_f(queue, &amp;job, iosfc_do_read);<br>
&gt; +=C2=A0 =C2=A0 AIO_WAIT_WHILE(NULL, !qatomic_read(&amp;job.completed))=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_mmio_iosfc_read(offset, job.value);<br>
&gt; +=C2=A0 =C2=A0 return job.value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void iosfc_do_write(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 [job-&gt;state-&gt;pgiosfc mmioWriteAtOffset:job-&gt;of=
fset value:job-&gt;value];<br>
&gt; +=C2=A0 =C2=A0 qatomic_set(&amp;job-&gt;completed, true);<br>
&gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void iosfc_write(void *opaque, hwaddr offset, uint64_t val,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =3D offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .value =3D val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .completed =3D false,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D dispatch_get_global_queue(DI=
SPATCH_QUEUE_PRIORITY_DEFAULT, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_async_f(queue, &amp;job, iosfc_do_write);<br>
&gt; +=C2=A0 =C2=A0 AIO_WAIT_WHILE(NULL, !qatomic_read(&amp;job.completed))=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_mmio_iosfc_write(offset, val);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps apple_iosfc_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D iosfc_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D iosfc_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void raise_irq(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_irq *irq =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_irq_pulse(*irq);<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct AppleGFXMapSurfaceMemoryJob {<br>
&gt; +=C2=A0 =C2=A0 uint64_t guest_physical_address;<br>
&gt; +=C2=A0 =C2=A0 uint64_t guest_physical_length;<br>
&gt; +=C2=A0 =C2=A0 void *result_mem;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOState *state;<br>
&gt; +=C2=A0 =C2=A0 bool read_only;<br>
&gt; +=C2=A0 =C2=A0 bool success;<br>
&gt; +=C2=A0 =C2=A0 bool done;<br>
&gt; +} AppleGFXMapSurfaceMemoryJob;<br>
&gt; +<br>
&gt; +typedef struct AppleGFXMMIOMappedRegion {<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *region;<br>
&gt; +=C2=A0 =C2=A0 uint64_t map_count;<br>
&gt; +=C2=A0 =C2=A0 uintptr_t host_virtual_start;<br>
&gt; +=C2=A0 =C2=A0 uintptr_t host_virtual_end;<br>
&gt; +} AppleGFXMMIOMappedRegion;<br>
&gt; +<br>
&gt; +static void apple_gfx_mmio_map_surface_memory(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMapSurfaceMemoryJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOState *s =3D job-&gt;state;<br>
&gt; +=C2=A0 =C2=A0 mach_vm_address_t mem;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *region =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 GArray *regions =3D s-&gt;iosfc_mapped_regions;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOMappedRegion *mapped_region;<br>
&gt; +=C2=A0 =C2=A0 size_t i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mem =3D apple_gfx_host_address_for_gpa_range(job-&gt;gu=
est_physical_address,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0job-&gt;guest_physical_length,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0job-&gt;read_only, &amp;region);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (mem !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; regions-&gt;len; ++i=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mapped_region =3D &amp;g_ar=
ray_index(regions, AppleGFXMMIOMappedRegion, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (region =3D=3D mapped_re=
gion-&gt;region) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++mapped_regi=
on-&gt;map_count;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D regions-&gt;len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No existing mapping to t=
his region found, keep a reference and save<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t start =3D (uintpt=
r_t)memory_region_get_ram_ptr(region);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXMMIOMappedRegion ne=
w_region =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 region, 1,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start + memor=
y_region_size(region)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_ref(region);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_array_append_val(regions,=
 new_region);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_iosfc_map_m=
emory_new_region(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i, region, st=
art, new_region.host_virtual_end);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;common.job_mutex);<br>
&gt; +=C2=A0 =C2=A0 job-&gt;result_mem =3D (void *)mem;<br>
&gt; +=C2=A0 =C2=A0 job-&gt;success =3D mem !=3D 0;<br>
&gt; +=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
&gt; +=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt;iosfc_map_job_cond);<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;common.job_mutex);<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct AppleGFXUnmapSurfaceMemoryJob {<br>
&gt; +=C2=A0 =C2=A0 void *virtual_address;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOState *state;<br>
&gt; +=C2=A0 =C2=A0 bool done;<br>
&gt; +} AppleGFXUnmapSurfaceMemoryJob;<br>
&gt; +<br>
&gt; +static AppleGFXMMIOMappedRegion *find_mapped_region_containing(GArray=
 *regions,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uintptr_t va,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0size_t *index)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t i;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOMappedRegion *mapped_region;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; regions-&gt;len; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mapped_region =3D &amp;g_array_index(regi=
ons, AppleGFXMMIOMappedRegion, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (va &gt;=3D mapped_region-&gt;host_vir=
tual_start &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 va &lt; mapped_region-&gt;h=
ost_virtual_end) {<br>
=C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *index =3D i;&gt; +=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mapped_region;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_mmio_unmap_surface_memory(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXUnmapSurfaceMemoryJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOState *s =3D job-&gt;state;<br>
&gt; +=C2=A0 =C2=A0 uintptr_t mem =3D (uintptr_t)job-&gt;virtual_address;<b=
r>
&gt; +=C2=A0 =C2=A0 GArray *regions =3D s-&gt;iosfc_mapped_regions;<br>
&gt; +=C2=A0 =C2=A0 size_t region_index;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOMappedRegion *mapped_region =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 find_mapped_region_containing(regions, me=
m, &amp;region_index);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (mapped_region) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_iosfc_unmap_memory_region=
(mem, region_index, mapped_region-&gt;map_count, mapped_region-&gt;region);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (--mapped_region-&gt;map_count =3D=3D =
0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_unref(mapped_=
region-&gt;region);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_array_remove_index_fast(r=
egions, region_index);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
memory at %p to be unmapped not &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;found in any of %u mapped regions.\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 job-&gt;virtual_address, regions-&gt;len);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;common.job_mutex);<br>
&gt; +=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
&gt; +=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt;iosfc_unmap_job_cond);<b=
r>
&gt; +=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;common.job_mutex);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device=
(<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGIOSurfaceHostDeviceDescriptor *iosfc_desc =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [PGIOSurfaceHostDeviceDescriptor new];<br=
>
&gt; +=C2=A0 =C2=A0 PGIOSurfaceHostDevice *iosfc_host_dev =3D nil;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_desc.mapMemory =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^bool(uint64_t phys, uint64_t len, bool r=
o, void **va, void *e, void *f) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXMapSurfaceMemoryJob=
 job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .guest_physic=
al_address =3D phys, .guest_physical_length =3D len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read_only =
=3D ro, .state =3D s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qem=
u_get_aio_context(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_mmio_map=
_surface_memory, &amp;job);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_await_bh_job(&amp=
;s-&gt;common, &amp;s-&gt;iosfc_map_job_cond, &amp;job.done);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *va =3D job.result_mem;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_iosfc_map_m=
emory(phys, len, ro, va, e, f, *va,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0job.success);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return job.success;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_desc.unmapMemory =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^bool(void *va, void *b, void *c, void *d=
, void *e, void *f) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXUnmapSurfaceMemoryJ=
ob job =3D { va, s };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_iosfc_unmap=
_memory(va, b, c, d, e, f);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qem=
u_get_aio_context(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_mmio_unm=
ap_surface_memory, &amp;job);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_await_bh_job(&amp=
;s-&gt;common, &amp;s-&gt;iosfc_unmap_job_cond, &amp;job.done);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_desc.raiseInterrupt =3D ^bool(uint32_t vector) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_iosfc_raise_irq(vector);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_cont=
ext(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_irq, &amp;s-&gt;irq_iosfc)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_host_dev =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[PGIOSurfaceHostDevice alloc] initWithDe=
scriptor:iosfc_desc];<br>
&gt; +=C2=A0 =C2=A0 [iosfc_desc release];<br>
&gt; +=C2=A0 =C2=A0 return iosfc_host_dev;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXMMIOState *s =3D APPLE_GFX_MMIO(d=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDeviceDescriptor *desc =3D [PGDeviceDes=
criptor new];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.raiseInterrupt =3D ^(uint32_t vector=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_raise_irq(v=
ector);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qem=
u_get_aio_context(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_irq, &amp;s-=
&gt;irq_gfx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.usingIOSurfaceMapper =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;pgiosfc =3D apple_gfx_prepare_iosur=
face_host_device(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;iosfc_mapped_regions =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_array_sized_new(false /* =
no termination */, true /* clear */,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(AppleGFXMMIOMappedRegion),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 /* Usually no more RAM regions*/);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_common_realize(&amp;s-&gt;commo=
n, desc, errp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cond_init(&amp;s-&gt;iosfc_map_job_c=
ond);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cond_init(&amp;s-&gt;iosfc_unmap_job=
_cond);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [desc release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc =3D nil;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_mmio_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOState *s =3D APPLE_GFX_MMIO(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 apple_gfx_common_init(obj, &amp;s-&gt;common, TYPE_APPL=
E_GFX_MMIO);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(s), &amp;s-&gt;common.i=
omem_gfx);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem_iosfc, obj, &amp=
;apple_iosfc_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_APPLE_GFX_MMIO, 0x10000);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(s), &amp;s-&gt;iomem_io=
sfc);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(s), &amp;s-&gt;irq_gfx);=
<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(s), &amp;s-&gt;irq_iosfc=
);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_mmio_reset(Object *obj, ResetType type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMMIOState *s =3D APPLE_GFX_MMIO(obj);<br>
&gt; +=C2=A0 =C2=A0 [s-&gt;common.pgdev reset];<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc-&gt;phases.hold =3D apple_gfx_mmio_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;hotpluggable =3D false;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D apple_gfx_mmio_realize;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static TypeInfo apple_gfx_mmio_types[] =3D {<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_APPLE_GFX_MMIO,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TY=
PE_SYS_BUS_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(AppleGFXMMIOSta=
te),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D apple_gfx_mm=
io_class_init,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D apple_gfx_mmio_init,<b=
r>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +DEFINE_TYPES(apple_gfx_mmio_types)<br>
&gt; diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..ef34e8160c8<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/apple-gfx.h<br>
&gt; @@ -0,0 +1,79 @@<br>
&gt; +/*<br>
&gt; + * Data structures and functions shared between variants of the macOS=
<br>
&gt; + * ParavirtualizedGraphics.framework based apple-gfx display adapter.=
<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef QEMU_APPLE_GFX_H<br>
&gt; +#define QEMU_APPLE_GFX_H<br>
&gt; +<br>
&gt; +#define TYPE_APPLE_GFX_MMIO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ap=
ple-gfx-mmio&quot;<br>
&gt; +#define TYPE_APPLE_GFX_PCI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ap=
ple-gfx-pci&quot;<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &lt;dispatch/dispatch.h&gt;<br>
&gt; +#import &lt;ParavirtualizedGraphics/ParavirtualizedGraphics.h&gt;<br>
&gt; +#include &quot;qemu/typedefs.h&quot;<br>
&gt; +#include &quot;exec/memory.h&quot;<br>
&gt; +#include &quot;ui/surface.h&quot;<br>
&gt; +<br>
&gt; +@class PGDeviceDescriptor;<br>
&gt; +@protocol PGDevice;<br>
&gt; +@protocol PGDisplay;<br>
&gt; +@protocol MTLDevice;<br>
&gt; +@protocol MTLTexture;<br>
&gt; +@protocol MTLCommandQueue;<br>
&gt; +<br>
&gt; +typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;<br>
&gt; +<br>
&gt; +typedef struct AppleGFXState {<br>
&gt; +=C2=A0 =C2=A0 /* Initialised on init/realize() */<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem_gfx;<br>
&gt; +=C2=A0 =C2=A0 id&lt;PGDevice&gt; pgdev;<br>
&gt; +=C2=A0 =C2=A0 id&lt;PGDisplay&gt; pgdisp;<br>
&gt; +=C2=A0 =C2=A0 QemuConsole *con;<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLDevice&gt; mtl;<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLCommandQueue&gt; mtl_queue;<br>
&gt; +=C2=A0 =C2=A0 dispatch_queue_t render_queue;<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* QemuMutex &amp; QemuConds for awaiting completi=
on of PVG memory-mapping and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* reading requests after submitting them to run i=
n the AIO context.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* QemuCond (rather than QemuEvent) are used so mu=
ltiple concurrent jobs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* can be handled safely.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The state associated with each job is tracked i=
n a AppleGFX*Job struct<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* for each kind of job; instances are allocated o=
n the caller&#39;s stack.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* This struct also contains the completion flag w=
hich is used in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* conjunction with the condition variable.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 QemuMutex job_mutex;<br>
&gt; +=C2=A0 =C2=A0 QemuCond task_map_job_cond;<br>
&gt; +=C2=A0 =C2=A0 QemuCond mem_read_job_cond;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* tasks is protected by task_mutex */<br>
&gt; +=C2=A0 =C2=A0 QemuMutex task_mutex;<br>
&gt; +=C2=A0 =C2=A0 PGTaskList tasks;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Mutable state (BQL) */<br>
&gt; +=C2=A0 =C2=A0 QEMUCursor *cursor;<br>
&gt; +=C2=A0 =C2=A0 bool cursor_show;<br>
&gt; +=C2=A0 =C2=A0 bool gfx_update_requested;<br>
&gt; +=C2=A0 =C2=A0 bool new_frame_ready;<br>
&gt; +=C2=A0 =C2=A0 bool using_managed_texture_storage;<br>
&gt; +=C2=A0 =C2=A0 int32_t pending_frames;<br>
&gt; +=C2=A0 =C2=A0 void *vram;<br>
&gt; +=C2=A0 =C2=A0 DisplaySurface *surface;<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLTexture&gt; texture;<br>
&gt; +} AppleGFXState;<br>
&gt; +<br>
&gt; +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*=
 obj_name);<br>
&gt; +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *d=
esc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp);<br>
&gt; +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physica=
l,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length, bool read_only,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion **mapping_in_region);<br>
&gt; +void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *job_done_flag);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; +<br>
&gt; diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..101b38e8a6e<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/apple-gfx.m<br>
&gt; @@ -0,0 +1,773 @@<br>
&gt; +/*<br>
&gt; + * QEMU Apple ParavirtualizedGraphics.framework device<br>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Righ=
ts Reserved.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + *<br>
&gt; + * ParavirtualizedGraphics.framework is a set of libraries that macOS=
 provides<br>
&gt; + * which implements 3d graphics passthrough to the host as well as a<=
br>
&gt; + * proprietary guest communication channel to drive it. This device m=
odel<br>
&gt; + * implements support to drive that library from within QEMU.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#import &lt;ParavirtualizedGraphics/ParavirtualizedGraphics.h&gt;<br>
&gt; +#include &lt;mach/mach_vm.h&gt;<br>
&gt; +#include &quot;apple-gfx.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#include &quot;qemu-main.h&quot;<br>
&gt; +#include &quot;exec/address-spaces.h&quot;<br>
&gt; +#include &quot;migration/blocker.h&quot;<br>
&gt; +#include &quot;monitor/monitor.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt; +#include &quot;qemu/cutils.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;sysemu/dma.h&quot;<br>
&gt; +#include &quot;ui/console.h&quot;<br>
&gt; +<br>
&gt; +static const PGDisplayCoord_t apple_gfx_modes[] =3D {<br>
&gt; +=C2=A0 =C2=A0 { .x =3D 1440, .y =3D 1080 },<br>
&gt; +=C2=A0 =C2=A0 { .x =3D 1280, .y =3D 1024 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* This implements a type defined in &lt;ParavirtualizedGraphics/PGDe=
vice.h&gt;<br>
&gt; + * which is opaque from the framework&#39;s point of view. Typedef PG=
Task_t already<br>
&gt; + * exists in the framework headers. */<br>
&gt; +struct PGTask_s {<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_ENTRY(PGTask_s) node;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s;<br>
&gt; +=C2=A0 =C2=A0 mach_vm_address_t address;<br>
&gt; +=C2=A0 =C2=A0 uint64_t len;<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* All unique MemoryRegions for which a mapping ha=
s been created in in this<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* task, and on which we have thus called memory_r=
egion_ref(). There are<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* usually very few regions of system RAM in total=
, so we expect this array<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* to be very short. Therefore, no need for sortin=
g or fancy search<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* algorithms, linear search will do. */<br>
&gt; +=C2=A0 =C2=A0 GArray *mapped_regions;<br>
<br>
Use GPtrArray.<br>
<br></blockquote><div><br></div><div>Thanks, I wasn&#39;t aware of this var=
iant.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
&gt; +};<br>
&gt; +<br>
&gt; +static Error *apple_gfx_mig_blocker;<br>
&gt; +<br>
&gt; +static void apple_gfx_render_frame_completed(AppleGFXState *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t width, uint32_t height);<br>
&gt; +<br>
&gt; +static dispatch_queue_t get_background_queue(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORIT=
Y_DEFAULT, 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static PGTask_t *apple_gfx_new_task(AppleGFXState *s, uint64_t len)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 mach_vm_address_t task_mem;<br>
&gt; +=C2=A0 =C2=A0 PGTask_t *task;<br>
&gt; +=C2=A0 =C2=A0 kern_return_t r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 r =3D mach_vm_allocate(mach_task_self(), &amp;task_mem,=
 len, VM_FLAGS_ANYWHERE);<br>
&gt; +=C2=A0 =C2=A0 if (r !=3D KERN_SUCCESS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 task =3D g_new0(PGTask_t, 1);<br>
&gt; +=C2=A0 =C2=A0 task-&gt;s =3D s;<br>
&gt; +=C2=A0 =C2=A0 task-&gt;address =3D task_mem;<br>
&gt; +=C2=A0 =C2=A0 task-&gt;len =3D len;<br>
&gt; +=C2=A0 =C2=A0 task-&gt;mapped_regions =3D g_array_sized_new(false /* =
no termination */,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0true /* clear */,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sizeof(MemoryRegion *),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02 /* Usually no more RAM regions*/);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;s-&gt;task_mutex);<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_TAIL(&amp;s-&gt;tasks, task, node);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return task;<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct AppleGFXIOJob {<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *state;<br>
&gt; +=C2=A0 =C2=A0 uint64_t offset;<br>
&gt; +=C2=A0 =C2=A0 uint64_t value;<br>
&gt; +=C2=A0 =C2=A0 bool completed;<br>
&gt; +} AppleGFXIOJob;<br>
&gt; +<br>
&gt; +static void apple_gfx_do_read(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXIOJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 job-&gt;value =3D [job-&gt;state-&gt;pgdev mmioReadAtOf=
fset:job-&gt;offset];<br>
&gt; +=C2=A0 =C2=A0 qatomic_set(&amp;job-&gt;completed, true);<br>
&gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned =
size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXIOJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =3D offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .completed =3D false,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D get_background_queue();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_async_f(queue, &amp;job, apple_gfx_do_read);<b=
r>
&gt; +=C2=A0 =C2=A0 AIO_WAIT_WHILE(NULL, !qatomic_read(&amp;job.completed))=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_read(offset, job.value);<br>
&gt; +=C2=A0 =C2=A0 return job.value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_do_write(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXIOJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 [job-&gt;state-&gt;pgdev mmioWriteAtOffset:job-&gt;offs=
et value:job-&gt;value];<br>
&gt; +=C2=A0 =C2=A0 qatomic_set(&amp;job-&gt;completed, true);<br>
&gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* The methods mmioReadAtOffset: and especially mmioWri=
teAtOffset: can<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* trigger and block on operations on other dispat=
ch queues, which in turn<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* may call back out on one or more of the callbac=
k blocks. For this reason,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and as we are holding the BQL, we invoke the I/=
O methods on a pool<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* thread and handle AIO tasks while we wait. Any =
work in the callbacks<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* requiring the BQL will in turn schedule BHs whi=
ch this thread will<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* process while waiting. */<br>
&gt; +=C2=A0 =C2=A0 AppleGFXIOJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =3D offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .value =3D val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .completed =3D false,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D get_background_queue();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_async_f(queue, &amp;job, apple_gfx_do_write);<=
br>
&gt; +=C2=A0 =C2=A0 AIO_WAIT_WHILE(NULL, !qatomic_read(&amp;job.completed))=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_write(offset, val);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps apple_gfx_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D apple_gfx_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D apple_gfx_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void apple_gfx_render_new_frame_bql_unlock(AppleGFXState *s)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 BOOL r;<br>
&gt; +=C2=A0 =C2=A0 bool managed_texture =3D s-&gt;using_managed_texture_st=
orage;<br>
&gt; +=C2=A0 =C2=A0 uint32_t width =3D surface_width(s-&gt;surface);<br>
&gt; +=C2=A0 =C2=A0 uint32_t height =3D surface_height(s-&gt;surface);<br>
&gt; +=C2=A0 =C2=A0 MTLRegion region =3D MTLRegionMake2D(0, 0, width, heigh=
t);<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLCommandBuffer&gt; command_buffer =3D [s-&gt;mt=
l_queue commandBuffer];<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLTexture&gt; texture =3D s-&gt;texture;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt; +=C2=A0 =C2=A0 [texture retain];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* This is not safe to call from the BQL due to PVG-int=
ernal locks causing<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* deadlocks. */<br>
&gt; +=C2=A0 =C2=A0 r =3D [s-&gt;pgdisp encodeCurrentFrameToCommandBuffer:c=
ommand_buffer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0texture:texture<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 region:region];<br>
&gt; +=C2=A0 =C2=A0 if (!r) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [texture release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 --s-&gt;pending_frames;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;%s: encodeCurrentFrameToCommandBuffer:texture:region: &quot;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;failed\n&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (managed_texture) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* &quot;Managed&quot; textures exist in =
both VRAM and RAM and must be synced. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 id&lt;MTLBlitCommandEncoder&gt; blit =3D =
[command_buffer blitCommandEncoder];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [blit synchronizeResource:texture];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [blit endEncoding];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 [texture release];<br>
&gt; +=C2=A0 =C2=A0 [command_buffer addCompletedHandler:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^(id&lt;MTLCommandBuffer&gt; cb)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(s-&gt;render=
_queue, ^{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_ren=
der_frame_completed(s, width, height);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }];<br>
&gt; +=C2=A0 =C2=A0 [command_buffer commit];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void copy_mtl_texture_to_surface_mem(id&lt;MTLTexture&gt; text=
ure, void *vram)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* TODO: Skip this entirely on a pure Metal or headless=
/guest-only<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* rendering path, else use a blit command encoder=
? Needs careful<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* (double?) buffering design. */<br>
&gt; +=C2=A0 =C2=A0 size_t width =3D texture.width, height =3D texture.heig=
ht;<br>
&gt; +=C2=A0 =C2=A0 MTLRegion region =3D MTLRegionMake2D(0, 0, width, heigh=
t);<br>
&gt; +=C2=A0 =C2=A0 [texture getBytes:vram<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytesPerRow:(width * 4)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytesPerImage:(width * height * 4)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fromRegion:region<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mipmapLevel:0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slice:0];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_render_frame_completed(AppleGFXState *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t width, uint32_t height)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt; +=C2=A0 =C2=A0 --s-&gt;pending_frames;<br>
&gt; +=C2=A0 =C2=A0 assert(s-&gt;pending_frames &gt;=3D 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Only update display if mode hasn&#39;t changed since=
 we started rendering. */<br>
&gt; +=C2=A0 =C2=A0 if (width =3D=3D surface_width(s-&gt;surface) &amp;&amp=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 height =3D=3D surface_height(s-&gt;surfac=
e)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 copy_mtl_texture_to_surface_mem(s-&gt;tex=
ture, s-&gt;vram);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;gfx_update_requested) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update_requested =
=3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update_full(s-&gt;c=
on);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&g=
t;con);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D f=
alse;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D t=
rue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;pending_frames &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_render_new_frame_bql_unlock(s);=
<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_fb_update_display(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;new_frame_ready) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update_full(s-&gt;con);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&gt;con);<br>
&gt; +=C2=A0 =C2=A0 } else if (s-&gt;pending_frames &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update_requested =3D true;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&gt;con);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const GraphicHwOps apple_gfx_fb_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .gfx_update =3D apple_gfx_fb_update_display,<br>
&gt; +=C2=A0 =C2=A0 .gfx_update_async =3D true,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void update_cursor(AppleGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt; +=C2=A0 =C2=A0 dpy_mouse_set(s-&gt;con, s-&gt;pgdisp.cursorPosition.x,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;=
pgdisp.cursorPosition.y, s-&gt;cursor_show);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t heigh=
t)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MTLTextureDescriptor *textureDescriptor;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;surface &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D=3D surface_width(s-&gt;surface)=
 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 height =3D=3D surface_height(s-&gt;surfac=
e)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(s-&gt;vram);<br>
&gt; +=C2=A0 =C2=A0 [s-&gt;texture release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;vram =3D g_malloc0_n(width * height, 4);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;surface =3D qemu_create_displaysurface_from(width=
, height, PIXMAN_LE_a8r8g8b8,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0width * 4, s-&gt;vram);<br>
<br>
Use qemu_create_displaysurface() and let DisplaySurface manage the <br>
memory for us.<br></blockquote><div><br></div><div>Yeah, I guess the defaul=
t pixel format is a close enough match, and now that the texture content is=
 copied synchronously under the BQL we don&#39;t need to deal with the memo=
ry ourselves anymore. <br></div><div><br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescriptor =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [MTLTextureDescriptor<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 texture2DDesc=
riptorWithPixelFormat:MTLPixelFormatBGRA8Unorm<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0width:width<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 height:height<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mipmapped:NO];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescriptor.usage =3D s-&gt;pgdisp.=
minimumTextureUsage;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;texture =3D [s-&gt;mtl newTextureWi=
thDescriptor:textureDescriptor];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;using_managed_texture_storage =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;texture.storageMode =3D=3D MTLStor=
ageModeManaged);<br>
&gt; +=C2=A0 =C2=A0 dpy_gfx_replace_surface(s-&gt;con, s-&gt;surface);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_fb(AppleGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 s-&gt;con =3D graphic_console_init(NULL, 0, &amp;apple_=
gfx_fb_ops, s);<br>
&gt; +=C2=A0 =C2=A0 set_mode(s, 1440, 1080);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;cursor_show =3D true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static size_t apple_gfx_get_default_mmio_range_size(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t mmio_range_size;<br>
&gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDeviceDescriptor *desc =3D [PGDeviceDes=
criptor new];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_range_size =3D desc.mmioLength;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [desc release];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return mmio_range_size;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*=
 obj_name)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t mmio_range_size =3D apple_gfx_get_default_mmio_r=
ange_size();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_common_init(obj_name, mmio_range_size);=
<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem_gfx, obj, &amp;a=
pple_gfx_ops, s, obj_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mmio_range_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* TODO: PVG framework supports serialising device stat=
e: integrate it! */<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct AppleGFXMapMemoryJob {<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *state;<br>
&gt; +=C2=A0 =C2=A0 PGTask_t *task;<br>
&gt; +=C2=A0 =C2=A0 uint64_t virtual_offset;<br>
&gt; +=C2=A0 =C2=A0 PGPhysicalMemoryRange_t *ranges;<br>
&gt; +=C2=A0 =C2=A0 uint32_t range_count;<br>
&gt; +=C2=A0 =C2=A0 bool read_only;<br>
&gt; +=C2=A0 =C2=A0 bool success;<br>
&gt; +=C2=A0 =C2=A0 bool done;<br>
&gt; +} AppleGFXMapMemoryJob;<br>
&gt; +<br>
&gt; +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t guest_physica=
l,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length, bool read_only,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion **mapping_in_region)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *ram_region;<br>
&gt; +=C2=A0 =C2=A0 uintptr_t host_address;<br>
&gt; +=C2=A0 =C2=A0 hwaddr ram_region_offset =3D 0;<br>
&gt; +=C2=A0 =C2=A0 hwaddr ram_region_length =3D length;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ram_region =3D address_space_translate(&amp;address_spa=
ce_memory,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0guest_physical,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;ram_region_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;ram_region_length, !read_only,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0MEMTXATTRS_UNSPECIFIED);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!ram_region || ram_region_length &lt; length ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !memory_access_is_direct(ram_region, !rea=
d_only)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 host_address =3D (uintptr_t)memory_region_get_ram_ptr(r=
am_region);<br>
&gt; +=C2=A0 =C2=A0 if (host_address =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 host_address +=3D ram_region_offset;<br>
&gt; +=C2=A0 =C2=A0 *mapping_in_region =3D ram_region;<br>
&gt; +=C2=A0 =C2=A0 return host_address;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Returns false if the region is already in the array */<br>
&gt; +static bool add_new_region(GArray *regions, MemoryRegion *region)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *existing;<br>
&gt; +=C2=A0 =C2=A0 size_t i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; regions-&gt;len; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 existing =3D g_array_index(regions, Memor=
yRegion *, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (existing =3D=3D region) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 g_array_append_val(regions, region);<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_map_memory(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXMapMemoryJob *job=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 opaque;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D job-&gt;state;<br>
&gt; +=C2=A0 =C2=A0 PGTask_t *task=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D job-&gt;task;<br>
&gt; +=C2=A0 =C2=A0 uint32_t range_count=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D job-&gt;range_count;<br>
&gt; +=C2=A0 =C2=A0 uint64_t virtual_offset=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D job-&gt;virtual_offset;<br>
&gt; +=C2=A0 =C2=A0 PGPhysicalMemoryRange_t *ranges =3D job-&gt;ranges;<br>
&gt; +=C2=A0 =C2=A0 bool read_only=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D job-&gt;read_only;<br>
&gt; +=C2=A0 =C2=A0 kern_return_t r;<br>
&gt; +=C2=A0 =C2=A0 mach_vm_address_t target, source;<br>
&gt; +=C2=A0 =C2=A0 vm_prot_t cur_protection, max_protection;<br>
&gt; +=C2=A0 =C2=A0 bool success =3D true;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *region;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert(bql_locked());<br>
<br>
It seems this function only requires RCU read lock and we can avoid <br>
using bottom half.<br></blockquote><div>=C2=A0</div><div>Yes, I think that =
should work. We&#39;ll still need something to serialise access to the task=
&#39;s mapped_regions array, but we can use the task_mutex instead of the B=
QL for that.</div><div><br></div><div>I guess dma_memory_read() also only n=
eeds an RCU guard, so readMemory should also be safe to run without the BQL=
?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_map_memory(task, range_count, virtual_o=
ffset, read_only);<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; range_count; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGPhysicalMemoryRange_t *range =3D &amp;r=
anges[i];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target =3D task-&gt;address + virtual_off=
set;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtual_offset +=3D range-&gt;physicalLen=
gth;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_map_memory_range(i, range=
-&gt;physicalAddress,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0range-&gt;physicalLength);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 region =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 source =3D apple_gfx_host_address_for_gpa=
_range(range-&gt;physicalAddress,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 range-&gt;physicalLength,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_only, &amp;region);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (source =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 success =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (add_new_region(task-&gt;mapped_region=
s, region)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_ref(region);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cur_protection =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_protection =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Map guest RAM at range-&gt;physicalAdd=
ress into PG task memory range<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D mach_vm_remap(mach_task_self(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &amp;target, range-&gt;physicalLength, vm_page_size -=
 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mach_task_self(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 source, false /* shared mapping, no copy */,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &amp;cur_protection, &amp;max_protection,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 VM_INHERIT_COPY);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_remap(r, source, target);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(r =3D=3D KERN_SUCCESS);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;job_mutex);<br>
&gt; +=C2=A0 =C2=A0 job-&gt;success =3D success;<br>
&gt; +=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
&gt; +=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt;task_map_job_cond);<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;job_mutex);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void apple_gfx_await_bh_job(AppleGFXState *s, QemuCond *job_cond, boo=
l *job_done_flag)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;job_mutex);<br>
&gt; +=C2=A0 =C2=A0 while (!*job_done_flag) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cond_wait(job_cond, &amp;s-&gt;job_m=
utex);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;job_mutex);<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct AppleGFXReadMemoryJob {<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s;<br>
&gt; +=C2=A0 =C2=A0 hwaddr physical_address;<br>
&gt; +=C2=A0 =C2=A0 uint64_t length;<br>
&gt; +=C2=A0 =C2=A0 void *dst;<br>
&gt; +=C2=A0 =C2=A0 bool done;<br>
&gt; +=C2=A0 =C2=A0 bool success;<br>
&gt; +} AppleGFXReadMemoryJob;<br>
&gt; +<br>
&gt; +static void apple_gfx_do_read_memory(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXReadMemoryJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D job-&gt;s;<br>
&gt; +=C2=A0 =C2=A0 MemTxResult r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 r =3D dma_memory_read(&amp;address_space_memory, job-&g=
t;physical_address,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 job-&gt;dst, job-&gt;length, MEMTXATTRS_UNSPECIFIED);<br>
&gt; +=C2=A0 =C2=A0 job-&gt;success =3D r =3D=3D MEMTX_OK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;job_mutex);<br>
&gt; +=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
&gt; +=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt;mem_read_job_cond);<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;job_mutex);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr physical_a=
ddress,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t length, void *ds=
t)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXReadMemoryJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s, physical_address, length, dst<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_read_memory(physical_address, length, d=
st);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Traversing the memory map requires RCU/BQL, so do it=
 in a BH. */<br>
&gt; +=C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_context(), apple_g=
fx_do_read_memory,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;job);<br>
&gt; +=C2=A0 =C2=A0 apple_gfx_await_bh_job(s, &amp;s-&gt;mem_read_job_cond,=
 &amp;job.done);<br>
&gt; +=C2=A0 =C2=A0 return job.success;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_task_destroy(AppleGFXState *s, PGTask_t *task)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GArray *regions =3D task-&gt;mapped_regions;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *region;<br>
&gt; +=C2=A0 =C2=A0 size_t i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; regions-&gt;len; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 region =3D g_array_index(regions, MemoryR=
egion *, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_unref(region);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 g_array_unref(regions);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mach_vm_deallocate(mach_task_self(), task-&gt;address, =
task-&gt;len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;s-&gt;task_mutex);<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;s-&gt;tasks, task, node);<br>
&gt; +=C2=A0 =C2=A0 g_free(task);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor *desc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 desc.createTask =3D ^(uint64_t vmSize, void * _Nullable=
 * _Nonnull baseAddress) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGTask_t *task =3D apple_gfx_new_task(s, =
vmSize);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *baseAddress =3D (void *)task-&gt;address=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_create_task(vmSize, *base=
Address);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return task;<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.destroyTask =3D ^(PGTask_t * _Nonnull task) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_destroy_task(task, task-&=
gt;mapped_regions-&gt;len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_task_destroy(s, task);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.mapMemory =3D ^bool(PGTask_t * _Nonnull task, uint=
32_t range_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t virtual_offset, bool read_only,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGPhysicalMemoryRange_t * _Nonnull ranges) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXMapMemoryJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .task =3D task, .ranges =3D=
 ranges, .range_count =3D range_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read_only =3D read_only, .=
virtual_offset =3D virtual_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .done =3D false, .success =
=3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (range_count &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qem=
u_get_aio_context(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_map_memo=
ry, &amp;job);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_await_bh_job(s, &=
amp;s-&gt;task_map_job_cond, &amp;job.done);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return job.success;<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.unmapMemory =3D ^bool(PGTask_t * _Nonnull task, ui=
nt64_t virtualOffset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kern_return_t r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mach_vm_address_t range_address;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_unmap_memory(task, virtua=
lOffset, length);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Replace task memory range with fresh p=
ages, undoing the mapping<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* from guest RAM. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 range_address =3D task-&gt;address + virt=
ualOffset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D mach_vm_allocate(mach_task_self(), =
&amp;range_address, length,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE);<br=
>
=C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(r =3D=3D KERN_SUCCESS);&gt=
; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.readMemory =3D ^bool(uint64_t physical_address, ui=
nt64_t length,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void * _Nonnull dst) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return apple_gfx_read_memory(s, physical_=
address, length, dst);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +}<br>
&gt; +<br>
&gt; +static PGDisplayDescriptor *apple_gfx_prepare_display_descriptor(Appl=
eGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor=
 new];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 <a href=3D"http://disp_desc.name" rel=3D"noreferrer" ta=
rget=3D"_blank">disp_desc.name</a> =3D @&quot;QEMU display&quot;;<br>
&gt; +=C2=A0 =C2=A0 disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.);=
 /* A 20&quot; display */<br>
&gt; +=C2=A0 =C2=A0 disp_desc.queue =3D dispatch_get_main_queue();<br>
&gt; +=C2=A0 =C2=A0 disp_desc.newFrameEventHandler =3D ^(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_new_frame();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(s-&gt;render_queue, ^{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Drop frames if we get to=
o far ahead. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending_frames &g=
t;=3D 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++s-&gt;pending_frames;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending_frames &g=
t; 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_ren=
der_new_frame_bql_unlock(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t size=
InPixels,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OSType pixelFormat=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_mode_change(sizeInPixels.=
x, sizeInPixels.y);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_mode(s, sizeInPixels.x, sizeInPixels.=
y);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *gl=
yph,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGDisplayCoo=
rd_t hotSpot) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [glyph retain];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(get_background_queue(), ^{=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
<br>
This would be better off using a bottom half since it is going to take <br>
the BQL.<br></blockquote><div><br></div><div>Yeah, I guess that should work=
 now that we&#39;ve eliminated  any calls into PVG while holding the BQL.<b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t bpp =3D glyph.bits=
PerPixel;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t width =3D glyph.pixe=
lsWide;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t height =3D glyph.pix=
elsHigh;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t padding_bytes_per_ro=
w =3D glyph.bytesPerRow - width * 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t* px_data =3D =
glyph.bitmapData;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_set(=
bpp, width, height);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;cursor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor_unref(=
s-&gt;cursor);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =
=3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bpp =3D=3D 32) { /* Sho=
uldn&#39;t be anything else, but just to be safe...*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =
=3D cursor_alloc(width, height);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-=
&gt;hot_x =3D hotSpot.x;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-=
&gt;hot_y =3D hotSpot.y;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *des=
t_px =3D s-&gt;cursor-&gt;data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t y=
 =3D 0; y &lt; height; ++y) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 for (size_t x =3D 0; x &lt; width; ++x) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /* NSBitmapImageRep&#39;s red &amp; blue channels are swappe=
d<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0* compared to QEMUCursor&#39;s. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 *dest_px =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[0] &lt;&lt; 16u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[1] &lt;&lt;=C2=A0 8u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[2] &lt;&lt;=C2=A0 0u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[3] &lt;&lt; 24u);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ++dest_px;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 px_data +=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 px_data +=3D padding_bytes_per_row;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_cursor_de=
fine(s-&gt;con, s-&gt;cursor);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor=
(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [glyph release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorShowHandler =3D ^(BOOL show) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(get_background_queue(), ^{=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_show=
(show);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor_show =3D show;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorMoveHandler =3D ^(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(get_background_queue(), ^{=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_move=
();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return disp_desc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static NSArray&lt;PGDisplayMode*&gt;* apple_gfx_prepare_display_mode_=
array(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];<br>
&gt; +=C2=A0 =C2=A0 NSArray&lt;PGDisplayMode*&gt;* mode_array =3D nil;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[PGDisplayMode alloc] init=
WithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mode_array =3D [NSArray arrayWithObjects:modes count:AR=
RAY_SIZE(apple_gfx_modes)];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [modes[i] release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D nil;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return mode_array;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static id&lt;MTLDevice&gt; copy_suitable_metal_device(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLDevice&gt; dev =3D nil;<br>
&gt; +=C2=A0 =C2=A0 NSArray&lt;id&lt;MTLDevice&gt;&gt; *devs =3D MTLCopyAll=
Devices();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Prefer a unified memory GPU. Failing that, pick a no=
n-removable GPU. */<br>
&gt; +=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; devs.count; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (devs[i].hasUnifiedMemory) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D devs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!devs[i].removable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D devs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (dev !=3D nil) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [dev retain];<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D MTLCreateSystemDefaultDevice();<b=
r>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 [devs release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return dev;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *d=
esc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc =3D nil;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (apple_gfx_mig_blocker =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;apple_gfx_mig_blocker,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
Migration state blocked by apple-gfx display device&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migrate_add_blocker(&amp;apple_gfx_mi=
g_blocker, errp) &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_init(&amp;s-&gt;task_mutex);<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INIT(&amp;s-&gt;tasks);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;render_queue =3D dispatch_queue_create(&quot;appl=
e-gfx.render&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DISPATCH_QUEUE_SERIAL);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mtl =3D copy_suitable_metal_device();<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mtl_queue =3D [s-&gt;mtl newCommandQueue];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.device =3D s-&gt;mtl;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 apple_gfx_register_task_mapping_handlers(s, desc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdev =3D PGNewDeviceWithDescriptor(desc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 disp_desc =3D apple_gfx_prepare_display_descriptor(s);<=
br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdisp =3D [s-&gt;pgdev newDisplayWithDescriptor:=
disp_desc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 port:0 serialNum:1234];<br>
&gt; +=C2=A0 =C2=A0 [disp_desc release];<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdisp.modeList =3D apple_gfx_prepare_display_mod=
e_array();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 create_fb(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_mutex_init(&amp;s-&gt;job_mutex);<br>
&gt; +=C2=A0 =C2=A0 qemu_cond_init(&amp;s-&gt;task_map_job_cond);<br>
&gt; +=C2=A0 =C2=A0 qemu_cond_init(&amp;s-&gt;mem_read_job_cond);<br>
&gt; +}<br>
&gt; diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
&gt; index 20a94973fa2..619e642905a 100644<br>
&gt; --- a/hw/display/meson.build<br>
&gt; +++ b/hw/display/meson.build<br>
&gt; @@ -61,6 +61,10 @@ system_ss.add(when: &#39;CONFIG_ARTIST&#39;, if_tru=
e: files(&#39;artist.c&#39;))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_ATI_VGA&#39;, if_true: [fi=
les(&#39;ati.c&#39;, &#39;ati_2d.c&#39;, &#39;ati_dbg.c&#39;), pixman])<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +system_ss.add(when: &#39;CONFIG_MAC_PVG&#39;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if_true: [files(&#39;apple-gfx.m&#39;), pvg, metal])<br>
&gt; +if cpu =3D=3D &#39;aarch64&#39;<br>
&gt; +=C2=A0 system_ss.add(when: &#39;CONFIG_MAC_PVG_MMIO&#39;,=C2=A0 if_tr=
ue: [files(&#39;apple-gfx-mmio.m&#39;), pvg, metal])<br>
&gt; +endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0if config_all_devices.has_key(&#39;CONFIG_VIRTIO_GPU&#39;)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_gpu_ss =3D ss.source_set()<br>
&gt; diff --git a/hw/display/trace-events b/hw/display/trace-events<br>
&gt; index 781f8a33203..d63fba6d094 100644<br>
&gt; --- a/hw/display/trace-events<br>
&gt; +++ b/hw/display/trace-events<br>
&gt; @@ -191,3 +191,31 @@ dm163_bits_ppi(unsigned dest_width) &quot;dest_wi=
dth : %u&quot;<br>
&gt;=C2=A0 =C2=A0dm163_leds(int led, uint32_t value) &quot;led %d: 0x%x&quo=
t;<br>
&gt;=C2=A0 =C2=A0dm163_channels(int channel, uint8_t value) &quot;channel %=
d: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0dm163_refresh_rate(uint32_t rr) &quot;refresh rate %d&quot=
;<br>
&gt; +<br>
&gt; +# apple-gfx.m<br>
&gt; +apple_gfx_read(uint64_t offset, uint64_t res) &quot;offset=3D0x%&quot=
;PRIx64&quot; res=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_write(uint64_t offset, uint64_t val) &quot;offset=3D0x%&quo=
t;PRIx64&quot; val=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_create_task(uint32_t vm_size, void *va) &quot;vm_size=3D0x%=
x base_addr=3D%p&quot;<br>
&gt; +apple_gfx_destroy_task(void *task, unsigned int num_mapped_regions) &=
quot;task=3D%p, task-&gt;mapped_regions-&gt;len=3D%u&quot;<br>
&gt; +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtu=
al_offset, uint32_t read_only) &quot;task=3D%p range_count=3D0x%x virtual_o=
ffset=3D0x%&quot;PRIx64&quot; read_only=3D%d&quot;<br>
&gt; +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t p=
hys_len) &quot;[%d] phys_addr=3D0x%&quot;PRIx64&quot; phys_len=3D0x%&quot;P=
RIx64<br>
&gt; +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t target) &q=
uot;retval=3D%&quot;PRId64&quot; source=3D0x%&quot;PRIx64&quot; target=3D0x=
%&quot;PRIx64<br>
&gt; +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t =
length) &quot;task=3D%p virtual_offset=3D0x%&quot;PRIx64&quot; length=3D0x%=
&quot;PRIx64<br>
&gt; +apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void *d=
st) &quot;phys_addr=3D0x%&quot;PRIx64&quot; length=3D0x%&quot;PRIx64&quot; =
dest=3D%p&quot;<br>
&gt; +apple_gfx_raise_irq(uint32_t vector) &quot;vector=3D0x%x&quot;<br>
&gt; +apple_gfx_new_frame(void) &quot;&quot;<br>
&gt; +apple_gfx_mode_change(uint64_t x, uint64_t y) &quot;x=3D%&quot;PRId64=
&quot; y=3D%&quot;PRId64<br>
&gt; +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) &=
quot;bpp=3D%d width=3D%&quot;PRId64&quot; height=3D0x%&quot;PRId64<br>
&gt; +apple_gfx_cursor_show(uint32_t show) &quot;show=3D%d&quot;<br>
&gt; +apple_gfx_cursor_move(void) &quot;&quot;<br>
&gt; +apple_gfx_common_init(const char *device_name, size_t mmio_size) &quo=
t;device: %s; MMIO size: %zu bytes&quot;<br>
&gt; +<br>
&gt; +# apple-gfx-mmio.m<br>
&gt; +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res) &quot;offset=
=3D0x%&quot;PRIx64&quot; res=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val) &quot;offse=
t=3D0x%&quot;PRIx64&quot; val=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, =
void *va, void *e, void *f, void* va_result, int success) &quot;phys=3D0x%&=
quot;PRIx64&quot; len=3D0x%&quot;PRIx64&quot; ro=3D%d va=3D%p e=3D%p f=3D%p=
 -&gt; *va=3D%p, success =3D %d&quot;<br>
&gt; +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_=
t start, uint64_t end) &quot;index=3D%zu, region=3D%p, 0x%&quot;PRIx64&quot=
;-0x%&quot;PRIx64<br>
&gt; +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void=
 *e, void *f) &quot;a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p&quot;<br>
&gt; +apple_gfx_iosfc_unmap_memory_region(uint64_t mem, size_t region_index=
, uint64_t map_count, void *region) &quot;mapping @ 0x%&quot;PRIx64&quot; i=
n region %zu, map count %&quot;PRIu64&quot;, memory region %p&quot;<br>
&gt; +apple_gfx_iosfc_raise_irq(uint32_t vector) &quot;vector=3D0x%x&quot;<=
br>
&gt; +<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index f7d45175212..5eab46f704f 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -769,6 +769,8 @@ socket =3D []<br>
&gt;=C2=A0 =C2=A0version_res =3D []<br>
&gt;=C2=A0 =C2=A0coref =3D []<br>
&gt;=C2=A0 =C2=A0iokit =3D []<br>
&gt; +pvg =3D []<br>
&gt; +metal =3D []<br>
&gt;=C2=A0 =C2=A0emulator_link_args =3D []<br>
&gt;=C2=A0 =C2=A0midl =3D not_found<br>
&gt;=C2=A0 =C2=A0widl =3D not_found<br>
&gt; @@ -790,6 +792,8 @@ elif host_os =3D=3D &#39;darwin&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0coref =3D dependency(&#39;appleframeworks&#39;, mod=
ules: &#39;CoreFoundation&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0iokit =3D dependency(&#39;appleframeworks&#39;, mod=
ules: &#39;IOKit&#39;, required: false)<br>
&gt;=C2=A0 =C2=A0 =C2=A0host_dsosuf =3D &#39;.dylib&#39;<br>
&gt; +=C2=A0 pvg =3D dependency(&#39;appleframeworks&#39;, modules: &#39;Pa=
ravirtualizedGraphics&#39;)<br>
&gt; +=C2=A0 metal =3D dependency(&#39;appleframeworks&#39;, modules: &#39;=
Metal&#39;)<br>
&gt;=C2=A0 =C2=A0elif host_os =3D=3D &#39;sunos&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0socket =3D [cc.find_library(&#39;socket&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc.find_library(=
&#39;nsl&#39;),<br>
<br>
</blockquote></div></div>

--00000000000016df020625e0bdd3--

