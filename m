Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43328D2B92E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KUG-0007CU-6A; Tue, 05 Nov 2024 09:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8KUD-0007Ap-O8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:24:49 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8KU4-000552-Fq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:24:49 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e600add5dcso2531065b6e.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730816678; x=1731421478;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XUD6sO5ml/AdbSE+q042yo8qj2voiCRcX2dWhbP9T4g=;
 b=cQlce0eb3J3OAIkTUpabApPGEFleFou+UwJxSAPYoS/sqOxcIaOqXEMLCmp7rsTdxh
 KvME43xLb7AgBITpWJ+IZGuxPBFTwmZSJnmtuWK6pscGvAdzjKwf9p+Y+gC3OtmFVQyx
 uG33+Q3fBQO1IJ2ui6YELrd3Q+93Mn/B2k8ZfK/URNeQ7Do0QJwzkNDefnG0F30IaE2E
 WgKtvFBxxfBFE2Emxcw8fVbJpuRvR7q0kUhteJIrnZ2aJcLoUVODaEclD49J5i6hgtpI
 FtXmmqR0MJTg5Y4giqdXSgJ4yyJcYOWnKuk9b3Q1gYA0lYNDRbsyTxEIGgTLniOJFAJi
 XE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730816678; x=1731421478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XUD6sO5ml/AdbSE+q042yo8qj2voiCRcX2dWhbP9T4g=;
 b=n3PF0MYj4P+Pbai4sG3n9p2zI+uHdwhu6KfDGaHZvPj9TjHCyqZ7jg5dtb1ez0nWGO
 Gx/OvzGapJPhFlcBu5Y1GF+15Mur++g06mJlmj7AYpyNJVwLdU60stTp/JQ90fTgGyuv
 0Z1P4GRRyFOEZWwIuouFgyfMks6spjHpxPbowEkRM13zB8/uCoNFtsrK6YjuzcJUi/Z9
 G4gz9XOQkjfWDqmZGaUMVJtOyvFkuy/OqlIxaJHR6PsXlFA5wIKovias4KPVaP1dsfPx
 hTzomfJypV5hAKtdq8id6OK1azYd9toZiC9/TSm7ej5M6ErfDQpROmMiCF0xt0ZphblJ
 n/bg==
X-Gm-Message-State: AOJu0YxAiA67LKNGGt4MfCqhXCIqBSAqNSY+NXdUNE0vEqfKHk1zR2Et
 q42oHnwMxmxRUoD2fjtRVDILg5Huyubedrg5bjVqM+L9T8bL7uX7VpQtMBn+rYkKdBAR/s1MKlm
 Fbs19vrmUlFP2iWwmn8s9BY/WfYnQSVCuGNL6
X-Google-Smtp-Source: AGHT+IHcXdWgCSMF3adsa0m9/9PuT+IngJu2Z3Qu1fA7+mRF18pLFlYmxkHPk+c0bcMVdOUtuQZM2TKndqPTHoL7+HI=
X-Received: by 2002:a05:6359:4e41:b0:1c6:1d01:7ae1 with SMTP id
 e5c5f4694b2df-1c61d017cfamr239900955d.4.1730816678001; Tue, 05 Nov 2024
 06:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20241103150037.48194-1-phil@philjordan.eu>
 <20241103150037.48194-3-phil@philjordan.eu>
 <4a19b683-9485-44ec-80ea-2d6e3e8ec270@daynix.com>
In-Reply-To: <4a19b683-9485-44ec-80ea-2d6e3e8ec270@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 5 Nov 2024 15:24:26 +0100
Message-ID: <CAAibmn2bO3eE7b4J9bLnjiqmuQzC=Ob8xBTQdK1s8d5wFf+8zQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/15] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="000000000000439cbb06262b2968"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::234;
 envelope-from=phil@philjordan.eu; helo=mail-oi1-x234.google.com
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

--000000000000439cbb06262b2968
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Nov 2024 at 09:22, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/11/04 0:00, Phil Dennis-Jordan wrote:
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
> > Implementation wise, most of the complexity lies in the differing
> threading
> > models of ParavirtualizedGraphics.framework, which uses libdispatch and
> > internal locks, versus QEMU, which heavily uses the BQL, especially
> during
> > memory-mapped device I/O. Great care has therefore been taken to preven=
t
> > deadlocks by never calling into PVG methods while holding the BQL, and
> > similarly never acquiring the BQL in a callback from PVG. Different
> strategies
> > have been used (libdispatch, blocking and non-blocking BHs, RCU, etc.)
> > depending on the specific requirements at each framework entry and exit
> point.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >
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
> > v6:
> >
> >   * Switched PGTask_s's' mapped_regions from GPtrArray to GArray
> >   * Allow DisplaySurface to manage its own vram now that texture -> vra=
m
> copy
> >     occurs under BQL.
> >   * Memory mapping operations now use RCU_READ_LOCK_GUARD() where
> possible
> >     instead of a heavy-weight BH job to acquire the BQL.
> >   * Changed PVG cursor and mode setting callbacks to kick off BHs
> instead of
> >     libdispatch tasks which then locked the BQL explicitly.
> >   * The single remaining callback which must wait for a BH to complete
> now
> >     creates an ephemeral QemuSemaphore to await completion.
> >   * Re-removed tracking of mapped surface manager memory regions. Just
> look up
> >     and ref/unref the memory regions in the map/unmap callbacks.
> >   * Re-ordered functions in apple-gfx.m to group them by area of
> functionality.
> >   * Improved comments and tweaked some names.
> >
> >   hw/display/Kconfig          |   9 +
> >   hw/display/apple-gfx-mmio.m | 281 +++++++++++++
> >   hw/display/apple-gfx.h      |  65 +++
> >   hw/display/apple-gfx.m      | 773 +++++++++++++++++++++++++++++++++++=
+
> >   hw/display/meson.build      |   4 +
> >   hw/display/trace-events     |  28 ++
> >   meson.build                 |   4 +
> >   7 files changed, 1164 insertions(+)
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
> > index 00000000000..66d81d38326
> > --- /dev/null
> > +++ b/hw/display/apple-gfx-mmio.m
> > @@ -0,0 +1,281 @@
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
> > +    qemu_irq irq_gfx;
> > +    qemu_irq irq_iosfc;
> > +    MemoryRegion iomem_iosfc;
> > +    PGIOSurfaceHostDevice *pgiosfc;
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
> > +        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
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
> > +        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
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
> > +static void raise_irq_bh(void *opaque)
> > +{
> > +    qemu_irq *irq =3D opaque;
> > +
> > +    qemu_irq_pulse(*irq);
> > +}
> > +
> > +static void *apple_gfx_mmio_map_surface_memory(uint64_t
> guest_physical_address,
> > +                                               uint64_t length, bool
> read_only)
> > +{
> > +    mach_vm_address_t mem;
>
> The type of this variable is inconsistent with
> apple_gfx_host_address_for_gpa_range() returns uintptr_t.
>
> Perhaps it may be better to make apple_gfx_host_address_for_gpa_range()
> return void *. That function can use uint8_t * internally for pointer
> computation.


I think that technically violates C's strict aliasing rules, although char*
should be safe.


> They are more convenient as they don't need pointer casting
> and can use "NULL", which is less cryptic than "0".
>

We'll have to cast the return value at the other call site, but that's ok;
we'll always end up with a cast *somewhere* due to the way the Mach VM APIs
work. (Their arguments aren't pointers because they can operate on the
address space of any process, not just the current one.)


> > +    MemoryRegion *region =3D NULL;
> > +
> > +    RCU_READ_LOCK_GUARD();
> > +    mem =3D apple_gfx_host_address_for_gpa_range(guest_physical_addres=
s,
> > +                                               length, read_only,
> &region);
> > +
> > +    if (mem !=3D 0) {
> > +        memory_region_ref(region);
> > +    }
> > +
> > +    return (void *)mem;
> > +}
> > +
> > +static bool apple_gfx_mmio_unmap_surface_memory(void *virtual_address)
> > +{
> > +    MemoryRegion *region;
> > +    ram_addr_t offset =3D 0;
> > +
> > +    RCU_READ_LOCK_GUARD();
> > +    region =3D memory_region_from_host(virtual_address, &offset);
> > +    if (region) {
> > +        trace_apple_gfx_iosfc_unmap_memory_region(virtual_address,
> region);
> > +        memory_region_unref(region);
> > +        return true;
> > +    } else {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: memory at %p to be unmappe=
d
> not "
> > +                      "found.\n",
> > +                      __func__,
> > +                      virtual_address);
> > +        return false;
> > +    }
>
> I prefer:
>
> if (!region) {
>      ...
>      return false;
> }
>
> return true;
>
> You can save typing "else" and add more error conditions in the future.
>
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
> > +            *va =3D apple_gfx_mmio_map_surface_memory(phys, len, ro);
> > +
> > +            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f,
> *va);
> > +
> > +            return *va !=3D NULL;
> > +        };
> > +
> > +    iosfc_desc.unmapMemory =3D
> > +        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
> > +            return apple_gfx_mmio_unmap_surface_memory(s);
> > +        };
> > +
> > +    iosfc_desc.raiseInterrupt =3D ^bool(uint32_t vector) {
> > +        trace_apple_gfx_iosfc_raise_irq(vector);
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                raise_irq_bh, &s->irq_iosfc);
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
> > +                                    raise_irq_bh, &s->irq_gfx);
> > +        };
> > +
> > +        desc.usingIOSurfaceMapper =3D true;
> > +        s->pgiosfc =3D apple_gfx_prepare_iosurface_host_device(s);
> > +
> > +        apple_gfx_common_realize(&s->common, desc, errp);
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
> > index 00000000000..91b55299338
> > --- /dev/null
> > +++ b/hw/display/apple-gfx.h
> > @@ -0,0 +1,65 @@
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
> > +
> > +    /* List `tasks` is protected by task_mutex */
> > +    QemuMutex task_mutex;
> > +    PGTaskList tasks;
> > +
> > +    /* Mutable state (BQL protected) */
> > +    QEMUCursor *cursor;
> > +    DisplaySurface *surface;
> > +    id<MTLTexture> texture;
> > +    int32_t pending_frames; /* # guest frames in the rendering pipelin=
e
> */
> > +    bool gfx_update_requested; /* QEMU display system wants a new fram=
e
> */
> > +    bool new_frame_ready; /* Guest has rendered a frame, ready to be
> used */
> > +    bool using_managed_texture_storage;
> > +
> > +    /* Mutable state (atomic) */
> > +    bool cursor_show;
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
> > +
> > +#endif
> > +
> > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> > new file mode 100644
> > index 00000000000..bce08e57c3f
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
> > +/* ------ PGTask and task operations: new/destroy/map/unmap ------ */
> > +
> > +/*
> > + * This implements the type declared in
> <ParavirtualizedGraphics/PGDevice.h>
> > + * which is opaque from the framework's point of view. It is used in
> callbacks
> > + * in the form of its typedef PGTask_t, which also already exists in t=
he
> > + * framework headers.
> > + *
> > + * A "task" in PVG terminology represents a host-virtual contiguous
> address
> > + * range which is reserved in a large chunk on task creation. The
> mapMemory
> > + * callback then requests ranges of guest system memory (identified by
> their
> > + * GPA) to be mapped into subranges of this reserved address space.
> > + * This type of operation isn't well-supported by QEMU's memory
> subsystem,
> > + * but it is fortunately trivial to achieve with Darwin's
> mach_vm_remap() call,
> > + * which allows us to refer to the same backing memory via multiple
> virtual
> > + * address ranges. The Mach VM APIs are therefore used throughout for
> managing
> > + * task memory.
> > + */
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
> > +     * algorithms, linear search will do.
> > +     * Protected by AppleGFXState's task_mutex.
> > +     */
> > +    GPtrArray *mapped_regions;
> > +};
> > +
> > +static Error *apple_gfx_mig_blocker;
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
> > +    task->mapped_regions =3D g_ptr_array_sized_new(2 /* Usually enough
> */);
> > +
> > +    QEMU_LOCK_GUARD(&s->task_mutex);
> > +    QTAILQ_INSERT_TAIL(&s->tasks, task, node);
> > +
> > +    return task;
> > +}
> > +
> > +static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
> > +{
> > +    GPtrArray *regions =3D task->mapped_regions;
> > +    MemoryRegion *region;
> > +    size_t i;
> > +
> > +    for (i =3D 0; i < regions->len; ++i) {
> > +        region =3D g_ptr_array_index(regions, i);
> > +        memory_region_unref(region);
> > +    }
> > +    g_ptr_array_unref(regions);
> > +
> > +    mach_vm_deallocate(mach_task_self(), task->address, task->len);
> > +
> > +    QEMU_LOCK_GUARD(&s->task_mutex);
> > +    QTAILQ_REMOVE(&s->tasks, task, node);
> > +    g_free(task);
> > +}
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
> > +static bool add_new_region(GPtrArray *regions, MemoryRegion *region)
> > +{
> > +    MemoryRegion *existing;
> > +    size_t i;
> > +
> > +    for (i =3D 0; i < regions->len; ++i) {
> > +        existing =3D g_ptr_array_index(regions, i);
> > +        if (existing =3D=3D region) {
> > +            return false;
> > +        }
> > +    }
>
> Use: g_ptr_array_find()
>
> > +    g_ptr_array_add(regions, region);
> > +    return true;
> > +}
> > +
> > +static bool apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t *task=
,
> > +                                      uint64_t virtual_offset,
> > +                                      PGPhysicalMemoryRange_t *ranges,
> > +                                      uint32_t range_count, bool
> read_only)
> > +{
> > +    kern_return_t r;
> > +    mach_vm_address_t target, source;
> > +    vm_prot_t cur_protection, max_protection;
> > +    bool success =3D true;
> > +    MemoryRegion *region;
> > +
> > +    RCU_READ_LOCK_GUARD();
> > +    QEMU_LOCK_GUARD(&s->task_mutex);
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
> > +    return success;
> > +}
> > +
> > +static void apple_gfx_task_unmap_memory(AppleGFXState *s, PGTask_t
> *task,
> > +                                        uint64_t virtual_offset,
> uint64_t length)
> > +{
> > +    kern_return_t r;
> > +    mach_vm_address_t range_address;
> > +
> > +    trace_apple_gfx_unmap_memory(task, virtual_offset, length);
> > +
> > +    /*
> > +     * Replace task memory range with fresh 0 pages, undoing the mappi=
ng
> > +     * from guest RAM.
> > +     */
> > +    range_address =3D task->address + virtual_offset;
> > +    r =3D mach_vm_allocate(mach_task_self(), &range_address, length,
> > +                         VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE);
> > +    g_assert(r =3D=3D KERN_SUCCESS);
> > +}
> > +
> > +/* ------ Rendering and frame management ------ */
> > +
> > +static void apple_gfx_render_frame_completed(AppleGFXState *s,
> > +                                             uint32_t width, uint32_t
> height);
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
> > +        copy_mtl_texture_to_surface_mem(s->texture,
> surface_data(s->surface));
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
> > +/* ------ Mouse cursor and display mode setting ------ */
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
> > +    [s->texture release];
> > +
> > +    s->surface =3D qemu_create_displaysurface(width, height);
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
> > +static void update_cursor(AppleGFXState *s)
> > +{
> > +    assert(bql_locked());
> > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> > +                  s->pgdisp.cursorPosition.y,
> qatomic_read(&s->cursor_show));
> > +}
> > +
> > +static void update_cursor_bh(void *opaque)
> > +{
> > +    AppleGFXState *s =3D opaque;
> > +    update_cursor(s);
> > +}
> > +
> > +typedef struct AppleGFXSetCursorGlyphJob {
> > +    AppleGFXState *s;
> > +    NSBitmapImageRep *glyph;
> > +    PGDisplayCoord_t hotspot;
> > +} AppleGFXSetCursorGlyphJob;
> > +
> > +static void set_cursor_glyph(void *opaque)
> > +{
> > +    AppleGFXSetCursorGlyphJob *job =3D opaque;
> > +    AppleGFXState *s =3D job->s;
> > +    NSBitmapImageRep *glyph =3D job->glyph;
> > +    uint32_t bpp =3D glyph.bitsPerPixel;
> > +    size_t width =3D glyph.pixelsWide;
> > +    size_t height =3D glyph.pixelsHigh;
> > +    size_t padding_bytes_per_row =3D glyph.bytesPerRow - width * 4;
> > +    const uint8_t* px_data =3D glyph.bitmapData;
> > +
> > +    trace_apple_gfx_cursor_set(bpp, width, height);
> > +
> > +    if (s->cursor) {
> > +        cursor_unref(s->cursor);
> > +        s->cursor =3D NULL;
> > +    }
> > +
> > +    if (bpp =3D=3D 32) { /* Shouldn't be anything else, but just to be
> safe...*/
> > +        s->cursor =3D cursor_alloc(width, height);
> > +        s->cursor->hot_x =3D job->hotspot.x;
> > +        s->cursor->hot_y =3D job->hotspot.y;
> > +
> > +        uint32_t *dest_px =3D s->cursor->data;
> > +
> > +        for (size_t y =3D 0; y < height; ++y) {
> > +            for (size_t x =3D 0; x < width; ++x) {
> > +                /* NSBitmapImageRep's red & blue channels are swapped
> > +                 * compared to QEMUCursor's. */
> > +                *dest_px =3D
> > +                    (px_data[0] << 16u) |
> > +                    (px_data[1] <<  8u) |
> > +                    (px_data[2] <<  0u) |
> > +                    (px_data[3] << 24u);
> > +                ++dest_px;
> > +                px_data +=3D 4;
> > +            }
> > +            px_data +=3D padding_bytes_per_row;
> > +        }
> > +        dpy_cursor_define(s->con, s->cursor);
> > +        update_cursor(s);
> > +    }
> > +    [glyph release];
> > +
> > +    g_free(job);
> > +}
> > +
> > +/* ------ DMA (device reading system memory) ------ */
> > +
> > +typedef struct AppleGFXReadMemoryJob {
> > +    QemuSemaphore sem;
> > +    hwaddr physical_address;
> > +    uint64_t length;
> > +    void *dst;
> > +    bool success;
> > +} AppleGFXReadMemoryJob;
> > +
> > +static void apple_gfx_do_read_memory(void *opaque)
> > +{
> > +    AppleGFXReadMemoryJob *job =3D opaque;
> > +    MemTxResult r;
> > +
> > +    r =3D dma_memory_read(&address_space_memory, job->physical_address=
,
> > +                        job->dst, job->length, MEMTXATTRS_UNSPECIFIED)=
;
> > +    job->success =3D r =3D=3D MEMTX_OK;
> > +
> > +    qemu_sem_post(&job->sem);
> > +}
> > +
> > +static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr
> physical_address,
> > +                                  uint64_t length, void *dst)
> > +{
> > +    AppleGFXReadMemoryJob job =3D {
> > +        .physical_address =3D physical_address, .length =3D length, .d=
st =3D
> dst
> > +    };
> > +
> > +    trace_apple_gfx_read_memory(physical_address, length, dst);
> > +
> > +    /* Performing DMA requires BQL, so do it in a BH. */
> > +    qemu_sem_init(&job.sem, 0);
> > +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                            apple_gfx_do_read_memory, &job);
> > +    qemu_sem_wait(&job.sem);
> > +    qemu_sem_destroy(&job.sem);
> > +    return job.success;
> > +}
> > +
> > +/* ------ Memory-mapped device I/O operations ------ */
> > +
> > +static dispatch_queue_t get_background_queue(void)
> > +{
> > +    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
> 0);
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
> > +    /*
> > +     * The methods mmioReadAtOffset: and especially mmioWriteAtOffset:
> can
> > +     * trigger synchronous operations on other dispatch queues, which
> in turn
> > +     * may call back out on one or more of the callback blocks. For
> this reason,
> > +     * and as we are holding the BQL, we invoke the I/O methods on a
> pool
> > +     * thread and handle AIO tasks while we wait. Any work in the
> callbacks
> > +     * requiring the BQL will in turn schedule BHs which this thread
> will
> > +     * process while waiting.
> > +     */
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
> > +/* ------ Initialisation and startup ------ */
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
> > +        apple_gfx_destroy_task(s, task);
> > +    };
> > +
> > +    desc.mapMemory =3D ^bool(PGTask_t * _Nonnull task, uint32_t
> range_count,
> > +                           uint64_t virtual_offset, bool read_only,
> > +                           PGPhysicalMemoryRange_t * _Nonnull ranges) =
{
> > +        return apple_gfx_task_map_memory(s, task, virtual_offset,
> > +                                         ranges, range_count,
> read_only);
> > +    };
> > +
> > +    desc.unmapMemory =3D ^bool(PGTask_t * _Nonnull task, uint64_t
> virtual_offset,
> > +                             uint64_t length) {
> > +        apple_gfx_task_unmap_memory(s, task, virtual_offset, length);
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
> > +                                     PGDisplayCoord_t hotspot) {
> > +        AppleGFXSetCursorGlyphJob *job =3D g_malloc0(sizeof(*job));
> > +        job->s =3D s;
> > +        job->glyph =3D glyph;
> > +        job->hotspot =3D hotspot;
> > +        [glyph retain];
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                set_cursor_glyph, job);
> > +    };
> > +    disp_desc.cursorShowHandler =3D ^(BOOL show) {
> > +        trace_apple_gfx_cursor_show(show);
> > +        qatomic_set(&s->cursor_show, show);
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                update_cursor_bh, s);
> > +    };
> > +    disp_desc.cursorMoveHandler =3D ^(void) {
> > +        trace_apple_gfx_cursor_move();
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                update_cursor_bh, s);
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
> > +    s->con =3D graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
> > +
> > +    qatomic_set(&s->cursor_show, true);
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
> > index d26d663f963..260eab9146d 100644
> > --- a/hw/display/trace-events
> > +++ b/hw/display/trace-events
> > @@ -194,3 +194,31 @@ dm163_bits_ppi(unsigned dest_width) "dest_width :
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
> void *va, void *e, void *f, void* va_result) "phys=3D0x%"PRIx64"
> len=3D0x%"PRIx64" ro=3D%d va=3D%p e=3D%p f=3D%p -> *va=3D%p"
> > +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_t
> start, uint64_t end) "index=3D%zu, region=3D%p, 0x%"PRIx64"-0x%"PRIx64
> > +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void
> *e, void *f) "a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p"
> > +apple_gfx_iosfc_unmap_memory_region(void* mem, void *region) "unmappin=
g
> @ %p from memory region %p"
> > +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=3D0x%x"
> > +
> > diff --git a/meson.build b/meson.build
> > index 2c9086a3fe6..d286b876d62 100644
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

--000000000000439cbb06262b2968
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 5 Nov 2024 a=
t 09:22, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" targ=
et=3D"_blank">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On 2024/11/04 0:00, Phil Dennis-Jorda=
n wrote:<br>
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
&gt; Implementation wise, most of the complexity lies in the differing thre=
ading<br>
&gt; models of ParavirtualizedGraphics.framework, which uses libdispatch an=
d<br>
&gt; internal locks, versus QEMU, which heavily uses the BQL, especially du=
ring<br>
&gt; memory-mapped device I/O. Great care has therefore been taken to preve=
nt<br>
&gt; deadlocks by never calling into PVG methods while holding the BQL, and=
<br>
&gt; similarly never acquiring the BQL in a callback from PVG. Different st=
rategies<br>
&gt; have been used (libdispatch, blocking and non-blocking BHs, RCU, etc.)=
<br>
&gt; depending on the specific requirements at each framework entry and exi=
t point.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt; <br>
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
&gt; v6:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Switched PGTask_s&#39;s&#39; mapped_regions from GPtrArr=
ay to GArray<br>
&gt;=C2=A0 =C2=A0* Allow DisplaySurface to manage its own vram now that tex=
ture -&gt; vram copy<br>
&gt;=C2=A0 =C2=A0 =C2=A0occurs under BQL.<br>
&gt;=C2=A0 =C2=A0* Memory mapping operations now use RCU_READ_LOCK_GUARD() =
where possible<br>
&gt;=C2=A0 =C2=A0 =C2=A0instead of a heavy-weight BH job to acquire the BQL=
.<br>
&gt;=C2=A0 =C2=A0* Changed PVG cursor and mode setting callbacks to kick of=
f BHs instead of<br>
&gt;=C2=A0 =C2=A0 =C2=A0libdispatch tasks which then locked the BQL explici=
tly.<br>
&gt;=C2=A0 =C2=A0* The single remaining callback which must wait for a BH t=
o complete now<br>
&gt;=C2=A0 =C2=A0 =C2=A0creates an ephemeral QemuSemaphore to await complet=
ion.<br>
&gt;=C2=A0 =C2=A0* Re-removed tracking of mapped surface manager memory reg=
ions. Just look up<br>
&gt;=C2=A0 =C2=A0 =C2=A0and ref/unref the memory regions in the map/unmap c=
allbacks.<br>
&gt;=C2=A0 =C2=A0* Re-ordered functions in apple-gfx.m to group them by are=
a of functionality.<br>
&gt;=C2=A0 =C2=A0* Improved comments and tweaked some names.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/display/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx-mmio.m | 281 +++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 65 +++<=
br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx.m=C2=A0 =C2=A0 =C2=A0 | 773 +++++++++=
+++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04=
 +<br>
&gt;=C2=A0 =C2=A0hw/display/trace-events=C2=A0 =C2=A0 =C2=A0|=C2=A0 28 ++<b=
r>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A07 files changed, 1164 insertions(+)<br>
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
&gt; index 00000000000..66d81d38326<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/apple-gfx-mmio.m<br>
&gt; @@ -0,0 +1,281 @@<br>
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
&gt; +=C2=A0 =C2=A0 qemu_irq irq_gfx;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq_iosfc;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem_iosfc;<br>
&gt; +=C2=A0 =C2=A0 PGIOSurfaceHostDevice *pgiosfc;<br>
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
&gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_get_global_queue(DISPATCH_QUEUE_=
PRIORITY_DEFAULT, 0);<br>
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
&gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_get_global_queue(DISPATCH_QUEUE_=
PRIORITY_DEFAULT, 0);<br>
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
&gt; +static void raise_irq_bh(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_irq *irq =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_irq_pulse(*irq);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void *apple_gfx_mmio_map_surface_memory(uint64_t guest_physica=
l_address,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length, bool read_only)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 mach_vm_address_t mem;<br>
<br>
The type of this variable is inconsistent with <br>
apple_gfx_host_address_for_gpa_range() returns uintptr_t.<br>
<br>
Perhaps it may be better to make apple_gfx_host_address_for_gpa_range() <br=
>
return void *. That function can use uint8_t * internally for pointer <br>
computation.</blockquote><div><br></div><div>I think that technically viola=
tes C&#39;s strict aliasing rules, although char* should be safe.<br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">They are=
 more convenient as they don&#39;t need pointer casting <br>
and can use &quot;NULL&quot;, which is less cryptic than &quot;0&quot;.<br>=
</blockquote><div><br></div><div>We&#39;ll have to cast the return value at=
 the other call site, but that&#39;s ok; we&#39;ll always end up with a cas=
t *somewhere* due to the way the Mach VM APIs work. (Their arguments aren&#=
39;t pointers because they can operate on the address space of any process,=
 not just the current one.)<br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 MemoryRegion *region =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 RCU_READ_LOCK_GUARD();<br>
&gt; +=C2=A0 =C2=A0 mem =3D apple_gfx_host_address_for_gpa_range(guest_phys=
ical_address,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0length, read_only, &amp;region);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (mem !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_ref(region);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return (void *)mem;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool apple_gfx_mmio_unmap_surface_memory(void *virtual_address=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *region;<br>
&gt; +=C2=A0 =C2=A0 ram_addr_t offset =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 RCU_READ_LOCK_GUARD();<br>
&gt; +=C2=A0 =C2=A0 region =3D memory_region_from_host(virtual_address, &am=
p;offset);<br>
&gt; +=C2=A0 =C2=A0 if (region) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_iosfc_unmap_memory_region=
(virtual_address, region);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_unref(region);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
memory at %p to be unmapped not &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;found.\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 virtual_address);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I prefer:<br>
<br>
if (!region) {<br>
=C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
}<br>
<br>
return true;<br>
<br>
You can save typing &quot;else&quot; and add more error conditions in the f=
uture.<br>
<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *va =3D apple_gfx_mmio_map_=
surface_memory(phys, len, ro);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_iosfc_map_m=
emory(phys, len, ro, va, e, f, *va);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return *va !=3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_desc.unmapMemory =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^bool(void *va, void *b, void *c, void *d=
, void *e, void *f) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return apple_gfx_mmio_unmap=
_surface_memory(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_desc.raiseInterrupt =3D ^bool(uint32_t vector) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_iosfc_raise_irq(vector);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_cont=
ext(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_irq_bh, &amp;s-&gt;irq_ios=
fc);<br>
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
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_irq_bh, &amp=
;s-&gt;irq_gfx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.usingIOSurfaceMapper =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;pgiosfc =3D apple_gfx_prepare_iosur=
face_host_device(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_common_realize(&amp;s-&gt;commo=
n, desc, errp);<br>
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
&gt; index 00000000000..91b55299338<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/apple-gfx.h<br>
&gt; @@ -0,0 +1,65 @@<br>
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
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* List `tasks` is protected by task_mutex */<br>
&gt; +=C2=A0 =C2=A0 QemuMutex task_mutex;<br>
&gt; +=C2=A0 =C2=A0 PGTaskList tasks;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Mutable state (BQL protected) */<br>
&gt; +=C2=A0 =C2=A0 QEMUCursor *cursor;<br>
&gt; +=C2=A0 =C2=A0 DisplaySurface *surface;<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLTexture&gt; texture;<br>
&gt; +=C2=A0 =C2=A0 int32_t pending_frames; /* # guest frames in the render=
ing pipeline */<br>
&gt; +=C2=A0 =C2=A0 bool gfx_update_requested; /* QEMU display system wants=
 a new frame */<br>
&gt; +=C2=A0 =C2=A0 bool new_frame_ready; /* Guest has rendered a frame, re=
ady to be used */<br>
&gt; +=C2=A0 =C2=A0 bool using_managed_texture_storage;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Mutable state (atomic) */<br>
&gt; +=C2=A0 =C2=A0 bool cursor_show;<br>
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
&gt; +<br>
&gt; +#endif<br>
&gt; +<br>
&gt; diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..bce08e57c3f<br>
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
&gt; +/* ------ PGTask and task operations: new/destroy/map/unmap ------ */=
<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * This implements the type declared in &lt;ParavirtualizedGraphics/P=
GDevice.h&gt;<br>
&gt; + * which is opaque from the framework&#39;s point of view. It is used=
 in callbacks<br>
&gt; + * in the form of its typedef PGTask_t, which also already exists in =
the<br>
&gt; + * framework headers.<br>
&gt; + *<br>
&gt; + * A &quot;task&quot; in PVG terminology represents a host-virtual co=
ntiguous address<br>
&gt; + * range which is reserved in a large chunk on task creation. The map=
Memory<br>
&gt; + * callback then requests ranges of guest system memory (identified b=
y their<br>
&gt; + * GPA) to be mapped into subranges of this reserved address space.<b=
r>
&gt; + * This type of operation isn&#39;t well-supported by QEMU&#39;s memo=
ry subsystem,<br>
&gt; + * but it is fortunately trivial to achieve with Darwin&#39;s mach_vm=
_remap() call,<br>
&gt; + * which allows us to refer to the same backing memory via multiple v=
irtual<br>
&gt; + * address ranges. The Mach VM APIs are therefore used throughout for=
 managing<br>
&gt; + * task memory.<br>
&gt; + */<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0* algorithms, linear search will do.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Protected by AppleGFXState&#39;s task_mutex.<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 GPtrArray *mapped_regions;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static Error *apple_gfx_mig_blocker;<br>
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
&gt; +=C2=A0 =C2=A0 task-&gt;mapped_regions =3D g_ptr_array_sized_new(2 /* =
Usually enough */);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;s-&gt;task_mutex);<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_TAIL(&amp;s-&gt;tasks, task, node);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return task;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GPtrArray *regions =3D task-&gt;mapped_regions;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *region;<br>
&gt; +=C2=A0 =C2=A0 size_t i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; regions-&gt;len; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 region =3D g_ptr_array_index(regions, i);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_unref(region);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 g_ptr_array_unref(regions);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mach_vm_deallocate(mach_task_self(), task-&gt;address, =
task-&gt;len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;s-&gt;task_mutex);<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;s-&gt;tasks, task, node);<br>
&gt; +=C2=A0 =C2=A0 g_free(task);<br>
&gt; +}<br>
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
&gt; +static bool add_new_region(GPtrArray *regions, MemoryRegion *region)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *existing;<br>
&gt; +=C2=A0 =C2=A0 size_t i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; regions-&gt;len; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 existing =3D g_ptr_array_index(regions, i=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (existing =3D=3D region) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Use: g_ptr_array_find()<br>
<br>
&gt; +=C2=A0 =C2=A0 g_ptr_array_add(regions, region);<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t *tas=
k,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t vi=
rtual_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PGPhysicalM=
emoryRange_t *ranges,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t ra=
nge_count, bool read_only)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 kern_return_t r;<br>
&gt; +=C2=A0 =C2=A0 mach_vm_address_t target, source;<br>
&gt; +=C2=A0 =C2=A0 vm_prot_t cur_protection, max_protection;<br>
&gt; +=C2=A0 =C2=A0 bool success =3D true;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *region;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 RCU_READ_LOCK_GUARD();<br>
&gt; +=C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;s-&gt;task_mutex);<br>
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
&gt; +=C2=A0 =C2=A0 return success;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_task_unmap_memory(AppleGFXState *s, PGTask_t *t=
ask,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
64_t virtual_offset, uint64_t length)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 kern_return_t r;<br>
&gt; +=C2=A0 =C2=A0 mach_vm_address_t range_address;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_unmap_memory(task, virtual_offset, leng=
th);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Replace task memory range with fresh 0 pages, u=
ndoing the mapping<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* from guest RAM.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 range_address =3D task-&gt;address + virtual_offset;<br=
>
&gt; +=C2=A0 =C2=A0 r =3D mach_vm_allocate(mach_task_self(), &amp;range_add=
ress, length,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE);<br>
&gt; +=C2=A0 =C2=A0 g_assert(r =3D=3D KERN_SUCCESS);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ------ Rendering and frame management ------ */<br>
&gt; +<br>
&gt; +static void apple_gfx_render_frame_completed(AppleGFXState *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t width, uint32_t height);<br>
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
ture, surface_data(s-&gt;surface));<br>
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
&gt; +/* ------ Mouse cursor and display mode setting ------ */<br>
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
&gt; +=C2=A0 =C2=A0 [s-&gt;texture release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;surface =3D qemu_create_displaysurface(width, hei=
ght);<br>
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
&gt; +static void update_cursor(AppleGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt; +=C2=A0 =C2=A0 dpy_mouse_set(s-&gt;con, s-&gt;pgdisp.cursorPosition.x,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;=
pgdisp.cursorPosition.y, qatomic_read(&amp;s-&gt;cursor_show));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void update_cursor_bh(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 update_cursor(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct AppleGFXSetCursorGlyphJob {<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s;<br>
&gt; +=C2=A0 =C2=A0 NSBitmapImageRep *glyph;<br>
&gt; +=C2=A0 =C2=A0 PGDisplayCoord_t hotspot;<br>
&gt; +} AppleGFXSetCursorGlyphJob;<br>
&gt; +<br>
&gt; +static void set_cursor_glyph(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXSetCursorGlyphJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D job-&gt;s;<br>
&gt; +=C2=A0 =C2=A0 NSBitmapImageRep *glyph =3D job-&gt;glyph;<br>
&gt; +=C2=A0 =C2=A0 uint32_t bpp =3D glyph.bitsPerPixel;<br>
&gt; +=C2=A0 =C2=A0 size_t width =3D glyph.pixelsWide;<br>
&gt; +=C2=A0 =C2=A0 size_t height =3D glyph.pixelsHigh;<br>
&gt; +=C2=A0 =C2=A0 size_t padding_bytes_per_row =3D glyph.bytesPerRow - wi=
dth * 4;<br>
&gt; +=C2=A0 =C2=A0 const uint8_t* px_data =3D glyph.bitmapData;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_cursor_set(bpp, width, height);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;cursor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor_unref(s-&gt;cursor);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (bpp =3D=3D 32) { /* Shouldn&#39;t be anything else,=
 but just to be safe...*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =3D cursor_alloc(width, heig=
ht);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_x =3D job-&gt;hotspo=
t.x;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_y =3D job-&gt;hotspo=
t.y;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *dest_px =3D s-&gt;cursor-&gt;da=
ta;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t y =3D 0; y &lt; height; ++y) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t x =3D 0; x &lt;=
 width; ++x) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* NSBitmapIm=
ageRep&#39;s red &amp; blue channels are swapped<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* compa=
red to QEMUCursor&#39;s. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *dest_px =3D<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (px_data[0] &lt;&lt; 16u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (px_data[1] &lt;&lt;=C2=A0 8u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (px_data[2] &lt;&lt;=C2=A0 0u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (px_data[3] &lt;&lt; 24u);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++dest_px;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D =
4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D padding_bytes_=
per_row;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_cursor_define(s-&gt;con, s-&gt;cursor=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 [glyph release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(job);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ------ DMA (device reading system memory) ------ */<br>
&gt; +<br>
&gt; +typedef struct AppleGFXReadMemoryJob {<br>
&gt; +=C2=A0 =C2=A0 QemuSemaphore sem;<br>
&gt; +=C2=A0 =C2=A0 hwaddr physical_address;<br>
&gt; +=C2=A0 =C2=A0 uint64_t length;<br>
&gt; +=C2=A0 =C2=A0 void *dst;<br>
&gt; +=C2=A0 =C2=A0 bool success;<br>
&gt; +} AppleGFXReadMemoryJob;<br>
&gt; +<br>
&gt; +static void apple_gfx_do_read_memory(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXReadMemoryJob *job =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 MemTxResult r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 r =3D dma_memory_read(&amp;address_space_memory, job-&g=
t;physical_address,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 job-&gt;dst, job-&gt;length, MEMTXATTRS_UNSPECIFIED);<br>
&gt; +=C2=A0 =C2=A0 job-&gt;success =3D r =3D=3D MEMTX_OK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_sem_post(&amp;job-&gt;sem);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr physical_a=
ddress,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t length, void *ds=
t)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXReadMemoryJob job =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .physical_address =3D physical_address, .=
length =3D length, .dst =3D dst<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_read_memory(physical_address, length, d=
st);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Performing DMA requires BQL, so do it in a BH. */<br=
>
&gt; +=C2=A0 =C2=A0 qemu_sem_init(&amp;job.sem, 0);<br>
&gt; +=C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_context(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_do_read_memory, &amp;job);<br>
&gt; +=C2=A0 =C2=A0 qemu_sem_wait(&amp;job.sem);<br>
&gt; +=C2=A0 =C2=A0 qemu_sem_destroy(&amp;job.sem);<br>
&gt; +=C2=A0 =C2=A0 return job.success;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ------ Memory-mapped device I/O operations ------ */<br>
&gt; +<br>
&gt; +static dispatch_queue_t get_background_queue(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORIT=
Y_DEFAULT, 0);<br>
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
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The methods mmioReadAtOffset: and especially mm=
ioWriteAtOffset: can<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* trigger synchronous operations on other dispatc=
h queues, which in turn<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* may call back out on one or more of the callbac=
k blocks. For this reason,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and as we are holding the BQL, we invoke the I/=
O methods on a pool<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* thread and handle AIO tasks while we wait. Any =
work in the callbacks<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* requiring the BQL will in turn schedule BHs whi=
ch this thread will<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* process while waiting.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
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
&gt; +/* ------ Initialisation and startup ------ */<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_destroy_task(s, task);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.mapMemory =3D ^bool(PGTask_t * _Nonnull task, uint=
32_t range_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t virtual_offset, bool read_only,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGPhysicalMemoryRange_t * _Nonnull ranges) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return apple_gfx_task_map_memory(s, task,=
 virtual_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ranges, range_count, read_only);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.unmapMemory =3D ^bool(PGTask_t * _Nonnull task, ui=
nt64_t virtual_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_task_unmap_memory(s, task, virt=
ual_offset, length);<br>
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
rd_t hotspot) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXSetCursorGlyphJob *job =3D g_mall=
oc0(sizeof(*job));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 job-&gt;s =3D s;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 job-&gt;glyph =3D glyph;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 job-&gt;hotspot =3D hotspot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [glyph retain];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_cont=
ext(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_cursor_glyph, job);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorShowHandler =3D ^(BOOL show) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_show(show);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;s-&gt;cursor_show, show)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_cont=
ext(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor_bh, s);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorMoveHandler =3D ^(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_move();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_get_aio_cont=
ext(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor_bh, s);<br>
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
&gt; +=C2=A0 =C2=A0 s-&gt;con =3D graphic_console_init(NULL, 0, &amp;apple_=
gfx_fb_ops, s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qatomic_set(&amp;s-&gt;cursor_show, true);<br>
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
&gt; index d26d663f963..260eab9146d 100644<br>
&gt; --- a/hw/display/trace-events<br>
&gt; +++ b/hw/display/trace-events<br>
&gt; @@ -194,3 +194,31 @@ dm163_bits_ppi(unsigned dest_width) &quot;dest_wi=
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
void *va, void *e, void *f, void* va_result) &quot;phys=3D0x%&quot;PRIx64&q=
uot; len=3D0x%&quot;PRIx64&quot; ro=3D%d va=3D%p e=3D%p f=3D%p -&gt; *va=3D=
%p&quot;<br>
&gt; +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_=
t start, uint64_t end) &quot;index=3D%zu, region=3D%p, 0x%&quot;PRIx64&quot=
;-0x%&quot;PRIx64<br>
&gt; +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void=
 *e, void *f) &quot;a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p&quot;<br>
&gt; +apple_gfx_iosfc_unmap_memory_region(void* mem, void *region) &quot;un=
mapping @ %p from memory region %p&quot;<br>
&gt; +apple_gfx_iosfc_raise_irq(uint32_t vector) &quot;vector=3D0x%x&quot;<=
br>
&gt; +<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 2c9086a3fe6..d286b876d62 100644<br>
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
</div>

--000000000000439cbb06262b2968--

