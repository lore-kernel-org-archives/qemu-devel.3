Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE00D12D46
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 15:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAAGk-0005ue-M1; Sun, 10 Nov 2024 10:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tAAGh-0005uG-PE
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:54:28 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tAAGY-0006pr-OW
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:54:26 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso2607179a12.1
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 07:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731254056; x=1731858856;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ni30CBM1vJJLeeFrOSJ2mDypbDxF4ecclHnzfzgAxqc=;
 b=AxgGwZ+4dO2u6Vqq/XA0ElyOjW1OvfZKk3Mu2S8XpiKgcSYec4J+bw8ucGssY2n2IZ
 tRi+DJdX+unW7mCLB9ALy9uFkGKjr8cZvNCC6ZVCXa3spRbgE/rJ9QiLFKTDm2Ztnrpo
 /lCP6EQiiY7miTGwGJ0OgLfJF4dYYtw4Xb+qPPJDjlNdOhXfmA80j9iPO/i9uslQ6QKx
 n7oeSaoZ9SE3TxxwGnwMTUuPY4xPXOFVtZeQeKQ9nNzA+KmbFQb7ysx8fS3yMbcjBi6x
 2EHaYljjvWTGoy7nvTudehSu1PtW5P+jo5+DlEiZ2kaKKmWkATPO2JV5+7DhczerGVD8
 ksRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731254056; x=1731858856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ni30CBM1vJJLeeFrOSJ2mDypbDxF4ecclHnzfzgAxqc=;
 b=LB9O7cip5VyOH3Pjxc+IuN0lg7kNIQTMlil3Hdv2BdYDtQvFVCkaOwrMCrtaOwFSN5
 OBqHHVggymuvYE7W6b+Amtylv2BwnpfuD5oGbmCwSvIJBC1ysppp3wA1vPV8TAkauF1M
 pHRyO+GBxS1O24PDyQBsK4hrd8WNtAK0Vzd6/61K+6y/KJlTC7amJuSm8UH5WxfXF57Q
 DpSWi1Q4sU695fMw8z+05a6QN20qJx2EXEAwipyxoq6/etbgangEAzdZyY0ZrPixzhWi
 D5IBlUx0gUg1mlATY276M+8iWLtfAn6bGoFqrbvFQD9DZ5HW7HxeM+gas0pX8m+hPu7O
 caZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZuiv+WcjgmD1s9F+hirejcYiXJ2ajnqQLPtq965c/IHsXJt2U8lZtoSF/BBhob9D4x/XcCuTmqZe1@nongnu.org
X-Gm-Message-State: AOJu0YyqRQFXBFxhSUTIwNA+sdz6rSpdgUrbg29S6UTnRRYpwT2Tqwc6
 3WM76W4ll8jxe3qrS4NzfM9ZXjAE6iN55i4zcWMsPLwhDK5eHSJRC/tSs6hRs4kO2MXkx1yoUtS
 cZ+VhEOZhct8vceFkDdeb/2UPS4LuTR68IgCR
X-Google-Smtp-Source: AGHT+IHSUYPhj0zrnoB+viqWm3OL7bbXRME3HXn4AkbMkI+f2DEmpd/mYz/V95lh1PyENVN4xkYGslW1aRES8ekPUEI=
X-Received: by 2002:a17:90b:4fc6:b0:2e0:7580:6853 with SMTP id
 98e67ed59e1d1-2e9b1f8f3c5mr14263868a91.17.1731254056144; Sun, 10 Nov 2024
 07:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-3-phil@philjordan.eu>
 <46027a27-9b86-424f-bdde-5f77f220becf@daynix.com>
In-Reply-To: <46027a27-9b86-424f-bdde-5f77f220becf@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sun, 10 Nov 2024 16:54:05 +0100
Message-ID: <CAGCz3vu7QtyAO1OOhJK_X5U5SV0R+G6KvoHmAoTkBzkfhz4LqQ@mail.gmail.com>
Subject: Re: [PATCH v8 02/15] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, pbonzini@redhat.com, rad@semihalf.com, 
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2607:f8b0:4864:20::535;
 envelope-from=lists@philjordan.eu; helo=mail-pg1-x535.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

On Sun, 10 Nov 2024 at 09:30, Akihiko Odaki <akihiko.odaki@daynix.com> wrot=
e:
>
> On 2024/11/08 23:46, Phil Dennis-Jordan wrote:
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
> > Implementation wise, most of the complexity lies in the differing threa=
ding
> > models of ParavirtualizedGraphics.framework, which uses libdispatch and
> > internal locks, versus QEMU, which heavily uses the BQL, especially dur=
ing
> > memory-mapped device I/O. Great care has therefore been taken to preven=
t
> > deadlocks by never calling into PVG methods while holding the BQL, and
> > similarly never acquiring the BQL in a callback from PVG. Different str=
ategies
> > have been used (libdispatch, blocking and non-blocking BHs, RCU, etc.)
> > depending on the specific requirements at each framework entry and exit=
 point.
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
> >   * Rebased on latest upstream, fixed breakages including switching to =
Resettable methods.
> >   * Squashed patches dealing with dGPUs, MMIO area size, and GPU pickin=
g.
> >   * Allow re-entrant MMIO; this simplifies the code and solves the dive=
rgence
> >     between x86-64 and arm64 variants.
> >
> > v4:
> >
> >   * Renamed '-vmapple' device variant to '-mmio'
> >   * MMIO device type now requires aarch64 host and guest
> >   * Complete overhaul of the glue code for making Qemu's and
> >     ParavirtualizedGraphics.framework's threading and synchronisation m=
odels
> >     work together. Calls into PVG are from dispatch queues while the
> >     BQL-holding initiating thread processes AIO context events; callbac=
ks from
> >     PVG are scheduled as BHs on the BQL/main AIO context, awaiting comp=
letion
> >     where necessary.
> >   * Guest frame rendering state is covered by the BQL, with only the PV=
G calls
> >     outside the lock, and serialised on the named render_queue.
> >   * Simplified logic for dropping frames in-flight during mode changes,=
 fixed
> >     bug in pending frames logic.
> >   * Addressed smaller code review notes such as: function naming, objec=
t type
> >     declarations, type names/declarations/casts, code formatting, #incl=
ude
> >     order, over-cautious ObjC retain/release, what goes in init vs real=
ize,
> >     etc.
> >
> > v5:
> >
> >   * Smaller non-functional fixes in response to review comments, such a=
s using
> >     NULL for the AIO_WAIT_WHILE context argument, type name formatting,
> >     deleting leftover debug code, logging improvements, state struct fi=
eld
> >     order and documentation improvements, etc.
> >   * Instead of a single condition variable for all synchronous BH job t=
ypes,
> >     there is now one for each callback block. This reduces the number
> >     of threads being awoken unnecessarily to near zero.
> >   * MMIO device variant: Unified the BH job for raising interrupts.
> >   * Use DMA APIs for PVG framework's guest memory read requests.
> >   * Thread safety improvements: ensure mutable AppleGFXState fields are=
 not
> >     accessed outside the appropriate lock. Added dedicated mutex for th=
e task
> >     list.
> >   * Retain references to MemoryRegions for which there exist mappings i=
n each
> >     PGTask, and for IOSurface mappings.
> >
> > v6:
> >
> >   * Switched PGTask_s's' mapped_regions from GPtrArray to GArray
> >   * Allow DisplaySurface to manage its own vram now that texture -> vra=
m copy
> >     occurs under BQL.
> >   * Memory mapping operations now use RCU_READ_LOCK_GUARD() where possi=
ble
> >     instead of a heavy-weight BH job to acquire the BQL.
> >   * Changed PVG cursor and mode setting callbacks to kick off BHs inste=
ad of
> >     libdispatch tasks which then locked the BQL explicitly.
> >   * The single remaining callback which must wait for a BH to complete =
now
> >     creates an ephemeral QemuSemaphore to await completion.
> >   * Re-removed tracking of mapped surface manager memory regions. Just =
look up
> >     and ref/unref the memory regions in the map/unmap callbacks.
> >   * Re-ordered functions in apple-gfx.m to group them by area of functi=
onality.
> >   * Improved comments and tweaked some names.
> >
> > v7:
> >
> >   * Use g_ptr_array_find() helper function
> >   * Error handling coding style tweak
> >
> > v8:
> >
> >   * Renamed apple_gfx_host_address_for_gpa_range() to
> >     apple_gfx_host_ptr_for_gpa_range(), and made it return a void* inst=
ead of
> >     uintptr_t. Fixed up callers and related code.
> >   * Some adjustments to types used.
> >   * Variable naming tweaks for better clarity.
> >   * Fixed leak in unlikely realize error case.
> >   * Fixed typo in unmap call.
> >   * Don't bother with dummy argument for g_ptr_array_find(), NULL works=
 too.
> >
> >   hw/display/Kconfig          |   9 +
> >   hw/display/apple-gfx-mmio.m | 282 +++++++++++++
> >   hw/display/apple-gfx.h      |  65 +++
> >   hw/display/apple-gfx.m      | 769 +++++++++++++++++++++++++++++++++++=
+
> >   hw/display/meson.build      |   4 +
> >   hw/display/trace-events     |  28 ++
> >   meson.build                 |   4 +
> >   7 files changed, 1161 insertions(+)
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
> > index 00000000000..2c5f426886c
> > --- /dev/null
> > +++ b/hw/display/apple-gfx-mmio.m
> > @@ -0,0 +1,282 @@
> > +/*
> > + * QEMU Apple ParavirtualizedGraphics.framework device, MMIO (arm64) v=
ariant
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * ParavirtualizedGraphics.framework is a set of libraries that macOS =
provides
> > + * which implements 3d graphics passthrough to the host as well as a
> > + * proprietary guest communication channel to drive it. This device mo=
del
> > + * implements support to drive that library from within QEMU as an MMI=
O-based
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
> > + * variant which does not include IOSFC descriptors and host devices. =
We add
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
> > +@property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMem=
ory;
> > +@property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unma=
pMemory;
> > +@property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt r=
aiseInterrupt;
> > +@end
> > +
> > +@interface PGIOSurfaceHostDevice : NSObject
> > +-(instancetype)initWithDescriptor:(PGIOSurfaceHostDeviceDescriptor *)d=
esc;
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
> > +    [job->state->pgiosfc mmioWriteAtOffset:job->offset value:job->valu=
e];
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
> > +static void *apple_gfx_mmio_map_surface_memory(uint64_t guest_physical=
_address,
> > +                                               uint64_t length, bool r=
ead_only)
> > +{
> > +    void *mem;
> > +    MemoryRegion *region =3D NULL;
> > +
> > +    RCU_READ_LOCK_GUARD();
> > +    mem =3D apple_gfx_host_ptr_for_gpa_range(guest_physical_address,
> > +                                           length, read_only, &region)=
;
> > +    if (mem) {
> > +        memory_region_ref(region);
> > +    }
> > +    return mem;
> > +}
> > +
> > +static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
> > +{
> > +    MemoryRegion *region;
> > +    ram_addr_t offset =3D 0;
> > +
> > +    RCU_READ_LOCK_GUARD();
> > +    region =3D memory_region_from_host(ptr, &offset);
> > +    if (!region) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: memory at %p to be unmappe=
d not "
> > +                      "found.\n",
> > +                      __func__, ptr);
> > +        return false;
> > +    }
> > +
> > +    trace_apple_gfx_iosfc_unmap_memory_region(ptr, region);
> > +    memory_region_unref(region);
> > +    return true;
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
, void *f) {
> > +            *va =3D apple_gfx_mmio_map_surface_memory(phys, len, ro);
> > +
> > +            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, =
*va);
> > +
> > +            return *va !=3D NULL;
> > +        };
> > +
> > +    iosfc_desc.unmapMemory =3D
> > +        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
> > +            return apple_gfx_mmio_unmap_surface_memory(va);
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
> > +        if (*errp) {
> > +            [s->pgiosfc release];
> > +            s->pgiosfc =3D nil;
> > +        }
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
> > index 00000000000..14ac2af8fc3
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
> > +    int8_t pending_frames; /* # guest frames in the rendering pipeline=
 */
> > +    bool gfx_update_requested; /* QEMU display system wants a new fram=
e */
> > +    bool new_frame_ready; /* Guest has rendered a frame, ready to be u=
sed */
> > +    bool using_managed_texture_storage;
> > +
> > +    /* Mutable state (atomic) */
> > +    bool cursor_show;
> > +} AppleGFXState;
> > +
> > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* =
obj_name);
> > +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *de=
sc,
> > +                              Error **errp);
> > +void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
> > +                                       uint64_t length, bool read_only=
,
> > +                                       MemoryRegion **mapping_in_regio=
n);
> > +
> > +#endif
> > +
> > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> > new file mode 100644
> > index 00000000000..913937b5255
> > --- /dev/null
> > +++ b/hw/display/apple-gfx.m
> > @@ -0,0 +1,769 @@
> > +/*
> > + * QEMU Apple ParavirtualizedGraphics.framework device
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * ParavirtualizedGraphics.framework is a set of libraries that macOS =
provides
> > + * which implements 3d graphics passthrough to the host as well as a
> > + * proprietary guest communication channel to drive it. This device mo=
del
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
> > + * This implements the type declared in <ParavirtualizedGraphics/PGDev=
ice.h>
> > + * which is opaque from the framework's point of view. It is used in c=
allbacks
> > + * in the form of its typedef PGTask_t, which also already exists in t=
he
> > + * framework headers.
> > + *
> > + * A "task" in PVG terminology represents a host-virtual contiguous ad=
dress
> > + * range which is reserved in a large chunk on task creation. The mapM=
emory
> > + * callback then requests ranges of guest system memory (identified by=
 their
> > + * GPA) to be mapped into subranges of this reserved address space.
> > + * This type of operation isn't well-supported by QEMU's memory subsys=
tem,
> > + * but it is fortunately trivial to achieve with Darwin's mach_vm_rema=
p() call,
> > + * which allows us to refer to the same backing memory via multiple vi=
rtual
> > + * address ranges. The Mach VM APIs are therefore used throughout for =
managing
> > + * task memory.
> > + */
> > +struct PGTask_s {
> > +    QTAILQ_ENTRY(PGTask_s) node;
> > +    AppleGFXState *s;
> > +    mach_vm_address_t address;
> > +    uint64_t len;
> > +    /*
> > +     * All unique MemoryRegions for which a mapping has been created i=
n in this
> > +     * task, and on which we have thus called memory_region_ref(). The=
re are
> > +     * usually very few regions of system RAM in total, so we expect t=
his array
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
> > +    r =3D mach_vm_allocate(mach_task_self(), &task_mem, len, VM_FLAGS_=
ANYWHERE);
> > +    if (r !=3D KERN_SUCCESS) {
> > +        return NULL;
> > +    }
> > +
> > +    task =3D g_new0(PGTask_t, 1);
> > +    task->s =3D s;
> > +    task->address =3D task_mem;
> > +    task->len =3D len;
> > +    task->mapped_regions =3D g_ptr_array_sized_new(2 /* Usually enough=
 */);
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
> > +void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
> > +                                       uint64_t length, bool read_only=
,
> > +                                       MemoryRegion **mapping_in_regio=
n)
> > +{
> > +    MemoryRegion *ram_region;
> > +    char *host_ptr;
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
> > +        return NULL;
> > +    }
> > +
> > +    host_ptr =3D memory_region_get_ram_ptr(ram_region);
> > +    if (!host_ptr) {
> > +        return NULL;
> > +    }
> > +    host_ptr +=3D ram_region_offset;
> > +    *mapping_in_region =3D ram_region;
> > +    return host_ptr;
> > +}
> > +
> > +/* Returns false if the region is already in the array */
> > +static bool add_new_region(GPtrArray *regions, MemoryRegion *region)
> > +{
> > +    if (g_ptr_array_find(regions, region, NULL)) {
> > +        return false;
> > +    }
> > +
> > +    g_ptr_array_add(regions, region);
> > +    return true;
> > +}
> > +
> > +static bool apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t *task=
,
> > +                                      uint64_t virtual_offset,
> > +                                      PGPhysicalMemoryRange_t *ranges,
> > +                                      uint32_t range_count, bool read_=
only)
> > +{
> > +    kern_return_t r;
> > +    void *source_ptr;
> > +    mach_vm_address_t target;
> > +    vm_prot_t cur_protection, max_protection;
> > +    bool success =3D true;
> > +    MemoryRegion *region;
> > +
> > +    RCU_READ_LOCK_GUARD();
> > +    QEMU_LOCK_GUARD(&s->task_mutex);
> > +
> > +    trace_apple_gfx_map_memory(task, range_count, virtual_offset, read=
_only);
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
> > +        source_ptr =3D apple_gfx_host_ptr_for_gpa_range(range->physica=
lAddress,
> > +                                                      range->physicalL=
ength,
> > +                                                      read_only, &regi=
on);
> > +        if (!source_ptr) {
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
> > +        /* Map guest RAM at range->physicalAddress into PG task memory=
 range */
> > +        r =3D mach_vm_remap(mach_task_self(),
> > +                          &target, range->physicalLength, vm_page_size=
 - 1,
> > +                          VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,
> > +                          mach_task_self(), (mach_vm_address_t)source_=
ptr,
> > +                          false /* shared mapping, no copy */,
> > +                          &cur_protection, &max_protection,
> > +                          VM_INHERIT_COPY);
> > +        trace_apple_gfx_remap(r, source_ptr, target);
> > +        g_assert(r =3D=3D KERN_SUCCESS);
> > +    }
> > +
> > +    return success;
> > +}
> > +
> > +static void apple_gfx_task_unmap_memory(AppleGFXState *s, PGTask_t *ta=
sk,
> > +                                        uint64_t virtual_offset, uint6=
4_t length)
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
> > +                                             uint32_t width, uint32_t =
height);
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
>
> Revisiting this rendering code, I wonder perhaps executing the
> BQL-protected part with bottom halves and calling dispatch_async() for
> the part not holding the BQL make more sense. It will avoid sleeping and
> waking up a thread for the BQL.

dispatch_async() will ALWAYS wake up another thread and forces the
working memory to be cache synced to the core performing the async
task, so I don't see how this might be a performance improvement.

But then this isn't exactly hot code (once per frame is pretty rare,
compared to other parts) so my main concern is readability. I don't
see such a change introducing any significant improvement in that
regard, but it doesn't make it much worse either.

> > +
> > +    /* This is not safe to call from the BQL due to PVG-internal locks=
 causing
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
> > +                      "%s: encodeCurrentFrameToCommandBuffer:texture:r=
egion: "
> > +                      "failed\n", __func__);
> > +        return;
> > +    }
> > +
> > +    if (managed_texture) {
> > +        /* "Managed" textures exist in both VRAM and RAM and must be s=
ynced. */
> > +        id<MTLBlitCommandEncoder> blit =3D [command_buffer blitCommand=
Encoder];
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
> > +static void copy_mtl_texture_to_surface_mem(id<MTLTexture> texture, vo=
id *vram)
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
> > +                                             uint32_t width, uint32_t =
height)
> > +{
> > +    bql_lock();
> > +    --s->pending_frames;
> > +    assert(s->pending_frames >=3D 0);
> > +
> > +    /* Only update display if mode hasn't changed since we started ren=
dering. */
> > +    if (width =3D=3D surface_width(s->surface) &&
> > +        height =3D=3D surface_height(s->surface)) {
> > +        copy_mtl_texture_to_surface_mem(s->texture, surface_data(s->su=
rface));
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
> > +                texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8=
Unorm
> > +                                             width:width
> > +                                            height:height
> > +                                         mipmapped:NO];
> > +        textureDescriptor.usage =3D s->pgdisp.minimumTextureUsage;
> > +        s->texture =3D [s->mtl newTextureWithDescriptor:textureDescrip=
tor];
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
> > +                  s->pgdisp.cursorPosition.y, qatomic_read(&s->cursor_=
show));
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
> > +    if (bpp =3D=3D 32) { /* Shouldn't be anything else, but just to be=
 safe...*/
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
> > +static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr physical_ad=
dress,
> > +                                  uint64_t length, void *dst)
> > +{
> > +    AppleGFXReadMemoryJob job =3D {
> > +        .physical_address =3D physical_address, .length =3D length, .d=
st =3D dst
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
> > +    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, =
0);
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
> > +static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned s=
ize)
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
> > +     * The methods mmioReadAtOffset: and especially mmioWriteAtOffset:=
 can
> > +     * trigger synchronous operations on other dispatch queues, which =
in turn
> > +     * may call back out on one or more of the callback blocks. For th=
is reason,
> > +     * and as we are holding the BQL, we invoke the I/O methods on a p=
ool
> > +     * thread and handle AIO tasks while we wait. Any work in the call=
backs
> > +     * requiring the BQL will in turn schedule BHs which this thread w=
ill
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
> > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* =
obj_name)
> > +{
> > +    size_t mmio_range_size =3D apple_gfx_get_default_mmio_range_size()=
;
> > +
> > +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
> > +    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s, obj_n=
ame,
> > +                          mmio_range_size);
> > +
> > +    /* TODO: PVG framework supports serialising device state: integrat=
e it! */
> > +}
> > +
> > +static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> > +                                                     PGDeviceDescripto=
r *desc)
> > +{
> > +    desc.createTask =3D ^(uint64_t vmSize, void * _Nullable * _Nonnull=
 baseAddress) {
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
> > +    desc.mapMemory =3D ^bool(PGTask_t * _Nonnull task, uint32_t range_=
count,
> > +                           uint64_t virtual_offset, bool read_only,
> > +                           PGPhysicalMemoryRange_t * _Nonnull ranges) =
{
> > +        return apple_gfx_task_map_memory(s, task, virtual_offset,
> > +                                         ranges, range_count, read_onl=
y);
> > +    };
> > +
> > +    desc.unmapMemory =3D ^bool(PGTask_t * _Nonnull task, uint64_t virt=
ual_offset,
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
> > +static PGDisplayDescriptor *apple_gfx_prepare_display_descriptor(Apple=
GFXState *s)
> > +{
> > +    PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor new];
> > +
> > +    disp_desc.name =3D @"QEMU display";
> > +    disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.); /* A 20" d=
isplay */
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
> > +static NSArray<PGDisplayMode*>* apple_gfx_prepare_display_mode_array(v=
oid)
> > +{
> > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> > +    NSArray<PGDisplayMode*>* mode_array =3D nil;
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> > +        modes[i] =3D
> > +            [[PGDisplayMode alloc] initWithSizeInPixels:apple_gfx_mode=
s[i] refreshRateInHz:60.];
> > +    }
> > +
> > +    mode_array =3D [NSArray arrayWithObjects:modes count:ARRAY_SIZE(ap=
ple_gfx_modes)];
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
> > +    /* Prefer a unified memory GPU. Failing that, pick a non-removable=
 GPU. */
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
> > +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *de=
sc,
> > +                              Error **errp)
> > +{
> > +    PGDisplayDescriptor *disp_desc =3D nil;
> > +
> > +    if (apple_gfx_mig_blocker =3D=3D NULL) {
> > +        error_setg(&apple_gfx_mig_blocker,
> > +                  "Migration state blocked by apple-gfx display device=
");
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
> > @@ -61,6 +61,10 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: files(=
'artist.c'))
> >
> >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2=
d.c', 'ati_dbg.c'), pixman])
> >
> > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: [files('apple-g=
fx.m'), pvg, metal])
> > +if cpu =3D=3D 'aarch64'
> > +  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: [files('apple-g=
fx-mmio.m'), pvg, metal])
> > +endif
> >
> >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >     virtio_gpu_ss =3D ss.source_set()
> > diff --git a/hw/display/trace-events b/hw/display/trace-events
> > index d26d663f963..a50e4eea0c0 100644
> > --- a/hw/display/trace-events
> > +++ b/hw/display/trace-events
> > @@ -194,3 +194,31 @@ dm163_bits_ppi(unsigned dest_width) "dest_width : =
%u"
> >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> >   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
> >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> > +
> > +# apple-gfx.m
> > +apple_gfx_read(uint64_t offset, uint64_t res) "offset=3D0x%"PRIx64" re=
s=3D0x%"PRIx64
> > +apple_gfx_write(uint64_t offset, uint64_t val) "offset=3D0x%"PRIx64" v=
al=3D0x%"PRIx64
> > +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=3D0x%x base=
_addr=3D%p"
> > +apple_gfx_destroy_task(void *task, unsigned int num_mapped_regions) "t=
ask=3D%p, task->mapped_regions->len=3D%u"
> > +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtua=
l_offset, uint32_t read_only) "task=3D%p range_count=3D0x%x virtual_offset=
=3D0x%"PRIx64" read_only=3D%d"
> > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t ph=
ys_len) "[%d] phys_addr=3D0x%"PRIx64" phys_len=3D0x%"PRIx64
> > +apple_gfx_remap(uint64_t retval, void *source_ptr, uint64_t target) "r=
etval=3D%"PRId64" source=3D%p target=3D0x%"PRIx64
> > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t l=
ength) "task=3D%p virtual_offset=3D0x%"PRIx64" length=3D0x%"PRIx64
> > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void *ds=
t) "phys_addr=3D0x%"PRIx64" length=3D0x%"PRIx64" dest=3D%p"
> > +apple_gfx_raise_irq(uint32_t vector) "vector=3D0x%x"
> > +apple_gfx_new_frame(void) ""
> > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=3D%"PRId64" y=3D%"PRI=
d64
> > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) "b=
pp=3D%d width=3D%"PRId64" height=3D0x%"PRId64
> > +apple_gfx_cursor_show(uint32_t show) "show=3D%d"
> > +apple_gfx_cursor_move(void) ""
> > +apple_gfx_common_init(const char *device_name, size_t mmio_size) "devi=
ce: %s; MMIO size: %zu bytes"
> > +
> > +# apple-gfx-mmio.m
> > +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res) "offset=3D0x%=
"PRIx64" res=3D0x%"PRIx64
> > +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val) "offset=3D0x=
%"PRIx64" val=3D0x%"PRIx64
> > +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, v=
oid *va, void *e, void *f, void* va_result) "phys=3D0x%"PRIx64" len=3D0x%"P=
RIx64" ro=3D%d va=3D%p e=3D%p f=3D%p -> *va=3D%p"
> > +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_t=
 start, uint64_t end) "index=3D%zu, region=3D%p, 0x%"PRIx64"-0x%"PRIx64
> > +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void =
*e, void *f) "a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p"
> > +apple_gfx_iosfc_unmap_memory_region(void* mem, void *region) "unmappin=
g @ %p from memory region %p"
> > +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=3D0x%x"
> > +
> > diff --git a/meson.build b/meson.build
> > index e0b880e4e13..427e3f61190 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -794,6 +794,8 @@ socket =3D []
> >   version_res =3D []
> >   coref =3D []
> >   iokit =3D []
> > +pvg =3D []
> > +metal =3D []
> >   emulator_link_args =3D []
> >   midl =3D not_found
> >   widl =3D not_found
> > @@ -815,6 +817,8 @@ elif host_os =3D=3D 'darwin'
> >     coref =3D dependency('appleframeworks', modules: 'CoreFoundation')
> >     iokit =3D dependency('appleframeworks', modules: 'IOKit', required:=
 false)
> >     host_dsosuf =3D '.dylib'
> > +  pvg =3D dependency('appleframeworks', modules: 'ParavirtualizedGraph=
ics')
> > +  metal =3D dependency('appleframeworks', modules: 'Metal')
> >   elif host_os =3D=3D 'sunos'
> >     socket =3D [cc.find_library('socket'),
> >               cc.find_library('nsl'),
>
>

