Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC13D10BF0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 10:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4dy5-0005zk-2U; Sat, 26 Oct 2024 06:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t4dy2-0005ys-1j
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 06:24:22 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t4dxu-0005kv-Pn
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 06:24:21 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-50d35639d0aso877877e0c.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1729938253; x=1730543053;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+GPYncKmPkqUVlmkN0Je87wndWiPrGneAAr59KAeYaE=;
 b=rlC6hKiCki6ibyI2ZudH3FT7ripFeGiGcedIQ03R4U/a2972/EKndiD4Q45xLQKQTU
 9D7untr0LX6kvQ3tZrI0/Lp91AR9ehsZVpQt7f7aEyrP58faun32xMtRCuTr9l97wK6j
 nxtVg/hqk9EMm48HbQn6VkvwL9D/C9yJFfxIn09xdMi17pcIQhA0M4BMJItl65niMnGY
 sWXKxQCd1GnB3TNrTYEVfQSx3PB9FW56YAWL6FNwaofKWdksQj9ShrYnnX3hIIoL6IoD
 9YZanK2DqxJ5WI6VbWX9gQZ7a1tTFPd5vQXSKaACHrwjpnwWhYuERrJ8Brly7ijR+/ur
 bytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729938253; x=1730543053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+GPYncKmPkqUVlmkN0Je87wndWiPrGneAAr59KAeYaE=;
 b=tKaZmkp/fcJfocft1pMpqeKiwFTRK33qW2ngzMASAbgq15b2qYjwlTGBJ5iJlXe1x3
 p7NBaXAcXbQkp0bY4yzHXSl0hqwQaTuO0R0moF5AI0WIwajycCNY+Cyx2HW2A1JIl1OL
 TtJv/yybcgQsB2lsguFbxdl1NVy6JI2m7Y3I4t2zehX9k7HU67u5ltkU+iMxamgfCnx9
 qBWp2dBS2MIw/gCtVMv8/akLyP1Ll7+G1rA7guo4c+Pf+vpyB8SahqFbkZn9V+o4asv1
 nn5MN91FmTKPzs4WmLIoFl+HLDjkwBh3XVHRIHPFMH2f7EMDHA09FLAtKfPiDLJc8Ryt
 My+Q==
X-Gm-Message-State: AOJu0YwaIhpdql/EZ3UQTDvPLjyrxaUcI+PY/i+Vv/c2L3W23mMvW0Hq
 HWAGnKkL0NHfthDpC6nn5D11kVCyvSCFR5728SwJqysbogQzaIY0mTDBPtQxYtPoFI7rklF5cY6
 23FRS/RjS8JCfy2KHLAreKv8VWDIogwvVbiVc
X-Google-Smtp-Source: AGHT+IH4fKOEHAubQHYXN3l6Q9YxpazcdOjCDxApTOK9cb02UxUVbW/JbewOfzeYIbZQTDtPbf0SrrW/X0j0ZIerrTg=
X-Received: by 2002:a05:6122:1820:b0:50d:2df1:4c46 with SMTP id
 71dfb90a1353d-510153353c0mr1044065e0c.13.1729938252615; Sat, 26 Oct 2024
 03:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-3-phil@philjordan.eu>
 <9e310d5e-ab73-47b9-b9ed-5a16d4db3fb9@daynix.com>
 <CAAibmn0NA+K63OvrsBpN1HivndyZo-fgeLwzY8AVE4hPrQR26w@mail.gmail.com>
 <dd2aae75-348d-44ad-bbd9-5d45aad15bc6@daynix.com>
In-Reply-To: <dd2aae75-348d-44ad-bbd9-5d45aad15bc6@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 26 Oct 2024 12:24:01 +0200
Message-ID: <CAAibmn1z+7yizwH8DogfcCWOWzA8Ox6e=p+Hc1pu-CS4SjAirg@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] hw/display/apple-gfx: Introduce
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
Content-Type: multipart/alternative; boundary="00000000000007f7f406255ea3d0"
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

--00000000000007f7f406255ea3d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Oct 2024 at 06:40, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/10/26 4:43, Phil Dennis-Jordan wrote:
> >
> >
> > On Fri, 25 Oct 2024 at 08:03, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/10/24 19:28, Phil Dennis-Jordan wrote:
> >      > +    /* For running PVG memory-mapping requests in the AIO
> context */
> >      > +    QemuCond job_cond;
> >      > +    QemuMutex job_mutex;
> >
> >     Use: QemuEvent
> >
> >
> > Hmm. I think if we were to use that, we would need to create a new
> > QemuEvent for every job and destroy it afterward, which seems expensive=
.
> > We can't rule out multiple concurrent jobs being submitted, and the
> > QemuEvent system only supports a single producer as far as I can tell.
> >
> > You can probably sort of hack around it with just one QemuEvent by
> > putting the qemu_event_wait into a loop and turning the job.done flag
> > into an atomic (because it would now need to be checked outside the
> > lock) but this all seems unnecessarily complicated considering the
> > QemuEvent uses the same mechanism QemuCond/QemuMutex internally on macO=
S
> > (the only platform relevant here), except we can use it as intended wit=
h
> > QemuCond/QemuMutex rather than having to work against the abstraction.
>
> I don't think it's going to be used concurrently. It would be difficult
> to reason even for the framework if it performs memory
> unmapping/mapping/reading operations concurrently.


I've just performed a very quick test by wrapping the job submission/wait
in the 2 mapMemory callbacks and the 1 readMemory callback with atomic
counters and logging whenever a counter went above 1.

 * Overall, concurrent callbacks across all types were common (many per
second when the VM is busy). It's not exactly a "thundering herd" (I never
saw >2) but it's probably not a bad idea to use a separate condition
variable for each job type. (task map, surface map, memory read)
 * While I did not observe any concurrent memory mapping operations *within=
*
a type of memory map (2 task mappings or 2 surface mappings) I did see very
occasional concurrent memory *read* callbacks. These would, as far as I can
tell, not be safe with QemuEvents, unless we placed the event inside the
job struct and init/destroyed it on every callback (which seems like
excessive overhead).

My recommendation would be to split it up into 3 pairs of mutex/cond; this
will almost entirely remove any contention, but continue to be safe for
when it does occur. I don't think QemuEvent is a realistic option (too
tricky to get right) for the observed-concurrent readMemory callback. I'm
nervous about assuming the mapMemory callbacks will NEVER be called
concurrently, but at a push I'll acquiesce to switching those to QemuEvent
in the absence of evidence of concurrency.


> PGDevice.h also notes
> raiseInterrupt needs to be thread-safe while it doesn't make such notes
> for memory operations. This actually makes sense.
>
> If it's ever going to be used concurrently, it's better to have
> QemuEvent for each job to avoid the thundering herd problem.
>
> >
> >      > +
> >      > +    dispatch_queue_t render_queue;
> >      > +    /* The following fields should only be accessed from the
> BQL: */
> >
> >     Perhaps it may be better to document fields that can be accessed
> >     *without* the BQL; most things in QEMU implicitly require the BQL.
> >
> >      > +    bool gfx_update_requested;
> >      > +    bool new_frame_ready;
> >      > +    bool using_managed_texture_storage;
> >      > +} AppleGFXState;
> >      > +
> >      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const
> >     char* obj_name);
> >      > +void apple_gfx_common_realize(AppleGFXState *s,
> >     PGDeviceDescriptor *desc,
> >      > +                              Error **errp);
> >      > +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t
> >     guest_physical,
> >      > +                                               uint64_t length,
> >     bool read_only);
> >      > +void apple_gfx_await_bh_job(AppleGFXState *s, bool
> *job_done_flag);
> >      > +
> >      > +#endif
> >      > +
> >      > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> >      > new file mode 100644
> >      > index 00000000000..46be9957f69
> >      > --- /dev/null
> >      > +++ b/hw/display/apple-gfx.m
> >      > @@ -0,0 +1,713 @@
> >      > +/*
> >      > + * QEMU Apple ParavirtualizedGraphics.framework device
> >      > + *
> >      > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. Al=
l
> >     Rights Reserved.
> >      > + *
> >      > + * This work is licensed under the terms of the GNU GPL, versio=
n
> >     2 or later.
> >      > + * See the COPYING file in the top-level directory.
> >      > + *
> >      > + * ParavirtualizedGraphics.framework is a set of libraries that
> >     macOS provides
> >      > + * which implements 3d graphics passthrough to the host as well
> as a
> >      > + * proprietary guest communication channel to drive it. This
> >     device model
> >      > + * implements support to drive that library from within QEMU.
> >      > + */
> >      > +
> >      > +#include "qemu/osdep.h"
> >      > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> >      > +#include <mach/mach_vm.h>
> >      > +#include "apple-gfx.h"
> >      > +#include "trace.h"
> >      > +#include "qemu-main.h"
> >      > +#include "exec/address-spaces.h"
> >      > +#include "migration/blocker.h"
> >      > +#include "monitor/monitor.h"
> >      > +#include "qemu/main-loop.h"
> >      > +#include "qemu/cutils.h"
> >      > +#include "qemu/log.h"
> >      > +#include "qapi/visitor.h"
> >      > +#include "qapi/error.h"
> >      > +#include "ui/console.h"
> >      > +
> >      > +static const PGDisplayCoord_t apple_gfx_modes[] =3D {
> >      > +    { .x =3D 1440, .y =3D 1080 },
> >      > +    { .x =3D 1280, .y =3D 1024 },
> >      > +};
> >      > +
> >      > +/* This implements a type defined in <ParavirtualizedGraphics/
> >     PGDevice.h>
> >      > + * which is opaque from the framework's point of view. Typedef
> >     PGTask_t already
> >      > + * exists in the framework headers. */
> >      > +struct PGTask_s {
> >      > +    QTAILQ_ENTRY(PGTask_s) node;
> >      > +    mach_vm_address_t address;
> >      > +    uint64_t len;
> >      > +};
> >      > +
> >      > +static Error *apple_gfx_mig_blocker;
> >
> >     This does not have to be a static variable.
> >
> >
> > Hmm, the first 5 or so examples of migration blockers in other devices
> > etc. I could find were all declared in this way. What are you suggestin=
g
> > as the alternative? And why not use the same pattern as in most of the
> > rest of the code base?
>
> I was wrong. This is better to be a static variable to ensure we won't
> add the same blocker in case we have two device instances.
>
> >
> >      > +
> >      > +static void apple_gfx_render_frame_completed(AppleGFXState *s,
> >      > +                                             uint32_t width,
> >     uint32_t height);
> >      > +
> >      > +static inline dispatch_queue_t get_background_queue(void)
> >
> >     Don't add inline. The only effect for modern compilers of inline is
> to
> >     suppress the unused function warnings.
> >
> >      > +{
> >      > +    return
> >     dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
> >      > +}
> >      > +
> >      > +static PGTask_t *apple_gfx_new_task(AppleGFXState *s, uint64_t
> len)
> >      > +{
> >      > +    mach_vm_address_t task_mem;
> >      > +    PGTask_t *task;
> >      > +    kern_return_t r;
> >      > +
> >      > +    r =3D mach_vm_allocate(mach_task_self(), &task_mem, len,
> >     VM_FLAGS_ANYWHERE);
> >      > +    if (r !=3D KERN_SUCCESS || task_mem =3D=3D 0) {
> >
> >     Let's remove the check for task_mem =3D=3D 0. We have no reason to
> >     reject it
> >     if the platform insists it allocated a memory at address 0 though
> >     such a
> >     situation should never happen in practice.
> >
> >      > +        return NULL;
> >      > +    }
> >      > +
> >      > +    task =3D g_new0(PGTask_t, 1);
> >      > +
> >      > +    task->address =3D task_mem;
> >      > +    task->len =3D len;
> >      > +    QTAILQ_INSERT_TAIL(&s->tasks, task, node);
> >      > +
> >      > +    return task;
> >      > +}
> >      > +
> >      > +typedef struct AppleGFXIOJob {
> >      > +    AppleGFXState *state;
> >      > +    uint64_t offset;
> >      > +    uint64_t value;
> >      > +    bool completed;
> >      > +} AppleGFXIOJob;
> >      > +
> >      > +static void apple_gfx_do_read(void *opaque)
> >      > +{
> >      > +    AppleGFXIOJob *job =3D opaque;
> >      > +    job->value =3D [job->state->pgdev
> mmioReadAtOffset:job->offset];
> >      > +    qatomic_set(&job->completed, true);
> >      > +    aio_wait_kick();
> >      > +}
> >      > +
> >      > +static uint64_t apple_gfx_read(void *opaque, hwaddr offset,
> >     unsigned size)
> >      > +{
> >      > +    AppleGFXIOJob job =3D {
> >      > +        .state =3D opaque,
> >      > +        .offset =3D offset,
> >      > +        .completed =3D false,
> >      > +    };
> >      > +    AioContext *context =3D qemu_get_aio_context();
> >      > +    dispatch_queue_t queue =3D get_background_queue();
> >      > +
> >      > +    dispatch_async_f(queue, &job, apple_gfx_do_read);
> >      > +    AIO_WAIT_WHILE(context, !qatomic_read(&job.completed));
> >      > +
> >      > +    trace_apple_gfx_read(offset, job.value);
> >      > +    return job.value;
> >      > +}
> >      > +
> >      > +static void apple_gfx_do_write(void *opaque)
> >      > +{
> >      > +    AppleGFXIOJob *job =3D opaque;
> >      > +    [job->state->pgdev mmioWriteAtOffset:job->offset value:job-
> >      >value];
> >      > +    qatomic_set(&job->completed, true);
> >      > +    aio_wait_kick();
> >      > +}
> >      > +
> >      > +static void apple_gfx_write(void *opaque, hwaddr offset,
> >     uint64_t val,
> >      > +                            unsigned size)
> >      > +{
> >      > +    /* The methods mmioReadAtOffset: and especially
> >     mmioWriteAtOffset: can
> >      > +     * trigger and block on operations on other dispatch queues=
,
> >     which in turn
> >      > +     * may call back out on one or more of the callback blocks.
> >     For this reason,
> >      > +     * and as we are holding the BQL, we invoke the I/O methods
> >     on a pool
> >      > +     * thread and handle AIO tasks while we wait. Any work in
> >     the callbacks
> >      > +     * requiring the BQL will in turn schedule BHs which this
> >     thread will
> >      > +     * process while waiting. */
> >      > +    AppleGFXIOJob job =3D {
> >      > +        .state =3D opaque,
> >      > +        .offset =3D offset,
> >      > +        .value =3D val,
> >      > +        .completed =3D false,
> >      > +    };
> >      > +    AioContext *context =3D qemu_get_current_aio_context();
> >      > +    dispatch_queue_t queue =3D get_background_queue();
> >      > +
> >      > +    dispatch_async_f(queue, &job, apple_gfx_do_write);
> >      > +    AIO_WAIT_WHILE(context, !qatomic_read(&job.completed));
> >      > +
> >      > +    trace_apple_gfx_write(offset, val);
> >      > +}
> >      > +
> >      > +static const MemoryRegionOps apple_gfx_ops =3D {
> >      > +    .read =3D apple_gfx_read,
> >      > +    .write =3D apple_gfx_write,
> >      > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> >      > +    .valid =3D {
> >      > +        .min_access_size =3D 4,
> >      > +        .max_access_size =3D 8,
> >      > +    },
> >      > +    .impl =3D {
> >      > +        .min_access_size =3D 4,
> >      > +        .max_access_size =3D 4,
> >      > +    },
> >      > +};
> >      > +
> >      > +static void apple_gfx_render_new_frame_bql_unlock(AppleGFXState
> *s)
> >      > +{
> >      > +    BOOL r;
> >      > +    uint32_t width =3D surface_width(s->surface);
> >      > +    uint32_t height =3D surface_height(s->surface);
> >      > +    MTLRegion region =3D MTLRegionMake2D(0, 0, width, height);
> >      > +    id<MTLCommandBuffer> command_buffer =3D [s->mtl_queue
> >     commandBuffer];
> >      > +    id<MTLTexture> texture =3D s->texture;
> >      > +
> >      > +    assert(bql_locked());
> >      > +    [texture retain];
> >      > +
> >      > +    bql_unlock();
> >      > +
> >      > +    /* This is not safe to call from the BQL due to PVG-interna=
l
> >     locks causing
> >      > +     * deadlocks. */
> >      > +    r =3D [s->pgdisp
> encodeCurrentFrameToCommandBuffer:command_buffer
> >      > +                                             texture:texture
> >      > +                                              region:region];
> >      > +    if (!r) {
> >      > +        [texture release];
> >      > +        bql_lock();
> >      > +        --s->pending_frames;
> >      > +        bql_unlock();
> >      > +        qemu_log_mask(LOG_GUEST_ERROR,
> >     "apple_gfx_render_new_frame_bql_unlock: "
> >
> >     Use: __func__
> >
> >      > +
> >     "encodeCurrentFrameToCommandBuffer:texture:region: failed\n");
> >      > +        return;
> >      > +    }
> >      > +
> >      > +    if (s->using_managed_texture_storage) {
> >      > +        /* "Managed" textures exist in both VRAM and RAM and
> >     must be synced. */
> >      > +        id<MTLBlitCommandEncoder> blit =3D [command_buffer
> >     blitCommandEncoder];
> >      > +        [blit synchronizeResource:texture];
> >      > +        [blit endEncoding];
> >      > +    }
> >      > +    [texture release];
> >      > +    [command_buffer addCompletedHandler:
> >      > +        ^(id<MTLCommandBuffer> cb)
> >      > +        {
> >      > +            dispatch_async(s->render_queue, ^{
> >      > +                apple_gfx_render_frame_completed(s, width,
> height);
> >      > +            });
> >      > +        }];
> >      > +    [command_buffer commit];
> >      > +}
> >      > +
> >      > +static void copy_mtl_texture_to_surface_mem(id<MTLTexture>
> >     texture, void *vram)
> >      > +{
> >      > +    /* TODO: Skip this entirely on a pure Metal or headless/
> >     guest-only
> >      > +     * rendering path, else use a blit command encoder? Needs
> >     careful
> >      > +     * (double?) buffering design. */
> >      > +    size_t width =3D texture.width, height =3D texture.height;
> >      > +    MTLRegion region =3D MTLRegionMake2D(0, 0, width, height);
> >      > +    [texture getBytes:vram
> >      > +          bytesPerRow:(width * 4)
> >      > +        bytesPerImage:(width * height * 4)
> >      > +           fromRegion:region
> >      > +          mipmapLevel:0
> >      > +                slice:0];
> >      > +}copy_mtl_texture_to_surface_mem
> >      > +
> >      > +static void apple_gfx_render_frame_completed(AppleGFXState *s,
> >      > +                                             uint32_t width,
> >     uint32_t height)
> >      > +{
> >      > +    bql_lock();
> >      > +    --s->pending_frames;
> >      > +    assert(s->pending_frames >=3D 0);
> >      > +
> >      > +    /* Only update display if mode hasn't changed since we
> >     started rendering. */
> >      > +    if (width =3D=3D surface_width(s->surface) &&
> >      > +        height =3D=3D surface_height(s->surface)) {
> >      > +        copy_mtl_texture_to_surface_mem(s->texture, s->vram);
> >      > +        if (s->gfx_update_requested) {
> >      > +            s->gfx_update_requested =3D false;
> >      > +            dpy_gfx_update_full(s->con);
> >      > +            graphic_hw_update_done(s->con);
> >      > +            s->new_frame_ready =3D false;
> >      > +        } else {
> >      > +            s->new_frame_ready =3D true;
> >      > +        }
> >      > +    }
> >      > +    if (s->pending_frames > 0) {
> >      > +        apple_gfx_render_new_frame_bql_unlock(s);
> >      > +    } else {
> >      > +        bql_unlock();
> >      > +    }
> >      > +}
> >      > +
> >      > +static void apple_gfx_fb_update_display(void *opaque)
> >      > +{
> >      > +    AppleGFXState *s =3D opaque;
> >      > +
> >      > +    assert(bql_locked());
> >      > +    if (s->new_frame_ready) {
> >      > +        dpy_gfx_update_full(s->con);
> >      > +        s->new_frame_ready =3D false;
> >      > +        graphic_hw_update_done(s->con);
> >      > +    } else if (s->pending_frames > 0) {
> >      > +        s->gfx_update_requested =3D true;
> >      > +    } else {
> >      > +        graphic_hw_update_done(s->con);
> >      > +    }
> >      > +}
> >      > +
> >      > +static const GraphicHwOps apple_gfx_fb_ops =3D {
> >      > +    .gfx_update =3D apple_gfx_fb_update_display,
> >      > +    .gfx_update_async =3D true,
> >      > +};
> >      > +
> >      > +static void update_cursor(AppleGFXState *s)
> >      > +{
> >      > +    assert(bql_locked());
> >      > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> >      > +                  s->pgdisp.cursorPosition.y, s->cursor_show);
> >      > +}
> >      > +
> >      > +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t
> >     height)
> >      > +{
> >      > +    MTLTextureDescriptor *textureDescriptor;
> >      > +
> >      > +    if (s->surface &&
> >      > +        width =3D=3D surface_width(s->surface) &&
> >      > +        height =3D=3D surface_height(s->surface)) {
> >      > +        return;
> >      > +    }
> >      > +
> >      > +    g_free(s->vram);
> >      > +    [s->texture release];
> >      > +
> >      > +    s->vram =3D g_malloc0_n(width * height, 4);
> >      > +    s->surface =3D qemu_create_displaysurface_from(width, heigh=
t,
> >     PIXMAN_LE_a8r8g8b8,
> >      > +                                                 width * 4, s-
> >      >vram);> +> +    @autoreleasepool {
> >      > +        textureDescriptor =3D
> >      > +            [MTLTextureDescriptor
> >      > +
> >     texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> >      > +                                             width:width
> >      > +                                            height:height
> >      > +                                         mipmapped:NO];
> >      > +        textureDescriptor.usage =3D s->pgdisp.minimumTextureUsa=
ge;
> >      > +        s->texture =3D [s->mtl
> >     newTextureWithDescriptor:textureDescriptor];
> >
> >
> >     What about creating pixman_image_t from s->texture.buffer.contents?
> >     This
> >     should save memory usage by removing the duplication of texture.
> >
> >
> > We need explicit control over when the GPU vs when the CPU may access
> > the texture - only one of them may access them at a time. As far as I
> > can tell, we can't control when the rest of Qemu might access the
> > pixman_image used in the console surface?
>
> You are right; we need to have duplicate buffers. We can still avoid
> copying by using two MTLTextures for double-buffering instead of having
> a MTLTexture and a pixman_image and copying between them for
> MTLStorageModeManaged.
>

Do I understand correctly that you intend to swap the surface->image on
every frame, or even the surface->image->data? If so, it's my understanding
from reading the source of a bunch of UI implementations a few weeks ago
that this is neither supported nor safe, as some implementations take
long-lived references to these internal data structures until a
dpy_gfx_switch callback. And the implementations for those callbacks are in
turn very expensive in some cases. This is why my conclusion in the v4
thread was that double-buffering was infeasible with the current
architecture.


> >
> >      > +    }
> >      > +
> >      > +    s->using_managed_texture_storage =3D
> >      > +        (s->texture.storageMode =3D=3D MTLStorageModeManaged);
> >      > +    dpy_gfx_replace_surface(s->con, s->surface);
> >      > +}
> >      > +
> >      > +static void create_fb(AppleGFXState *s)
> >      > +{
> >      > +    s->con =3D graphic_console_init(NULL, 0, &apple_gfx_fb_ops,=
 s);
> >      > +    set_mode(s, 1440, 1080);
> >      > +
> >      > +    s->cursor_show =3D true;
> >      > +}
> >      > +
> >      > +static size_t apple_gfx_get_default_mmio_range_size(void)
> >      > +{
> >      > +    size_t mmio_range_size;
> >      > +    @autoreleasepool {
> >      > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];
> >      > +        mmio_range_size =3D desc.mmioLength;
> >      > +        [desc release];
> >      > +    }
> >      > +    return mmio_range_size;
> >      > +}
> >      > +
> >      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const
> >     char* obj_name)
> >      > +{
> >      > +    size_t mmio_range_size =3D
> >     apple_gfx_get_default_mmio_range_size();
> >      > +
> >      > +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
> >      > +    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s=
,
> >     obj_name,
> >      > +                          mmio_range_size);
> >      > +
> >      > +    /* TODO: PVG framework supports serialising device state:
> >     integrate it! */
> >      > +}
> >      > +
> >      > +typedef struct AppleGFXMapMemoryJob {
> >      > +    AppleGFXState *state;
> >      > +    PGTask_t *task;
> >      > +    uint64_t virtual_offset;
> >      > +    PGPhysicalMemoryRange_t *ranges;
> >      > +    uint32_t range_count;
> >      > +    bool read_only;
> >      > +    bool success;
> >      > +    bool done;
> >      > +} AppleGFXMapMemoryJob;
> >      > +
> >      > +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t
> >     guest_physical,
> >      > +                                               uint64_t length,
> >     bool read_only)
> >      > +{
> >      > +    MemoryRegion *ram_region;
> >      > +    uintptr_t host_address;
> >      > +    hwaddr ram_region_offset =3D 0;
> >      > +    hwaddr ram_region_length =3D length;
> >      > +
> >      > +    ram_region =3D address_space_translate(&address_space_memor=
y,
> >      > +                                         guest_physical,
> >      > +                                         &ram_region_offset,
> >      > +                                         &ram_region_length, !
> >     read_only,
> >      > +                                         MEMTXATTRS_UNSPECIFIED=
);
> >
> >     Call memory_region_ref() so that it won't go away.
> >
> >      > +
> >      > +    if (!ram_region || ram_region_length < length ||
> >      > +        !memory_access_is_direct(ram_region, !read_only)) {
> >      > +        return 0;
> >      > +    }
> >      > +
> >      > +    host_address =3D
> >     (mach_vm_address_t)memory_region_get_ram_ptr(ram_region);
> >
> >     host_address is typed as uintptr_t, not mach_vm_address_t.
> >
> >      > +    if (host_address =3D=3D 0) {
> >      > +        return 0;
> >      > +    }
> >      > +    host_address +=3D ram_region_offset;
> >      > +
> >      > +    return host_address;
> >      > +}
> >      > +
> >      > +static void apple_gfx_map_memory(void *opaque)
> >      > +{
> >      > +    AppleGFXMapMemoryJob *job =3D opaque;
> >      > +    AppleGFXState *s =3D job->state;
> >      > +    PGTask_t *task                  =3D job->task;
> >      > +    uint32_t range_count            =3D job->range_count;
> >      > +    uint64_t virtual_offset         =3D job->virtual_offset;
> >      > +    PGPhysicalMemoryRange_t *ranges =3D job->ranges;
> >      > +    bool read_only                  =3D job->read_only;
> >      > +    kern_return_t r;
> >      > +    mach_vm_address_t target, source;
> >      > +    vm_prot_t cur_protection, max_protection;
> >      > +    bool success =3D true;
> >      > +
> >      > +    g_assert(bql_locked());
> >      > +
> >      > +    trace_apple_gfx_map_memory(task, range_count,
> >     virtual_offset, read_only);
> >      > +    for (int i =3D 0; i < range_count; i++) {
> >      > +        PGPhysicalMemoryRange_t *range =3D &ranges[i];
> >      > +
> >      > +        target =3D task->address + virtual_offset;
> >      > +        virtual_offset +=3D range->physicalLength;
> >      > +
> >      > +        trace_apple_gfx_map_memory_range(i,
> range->physicalAddress,
> >      > +                                         range->physicalLength)=
;
> >      > +
> >      > +        source =3D apple_gfx_host_address_for_gpa_range(range-
> >      >physicalAddress,
> >      > +                                                      range-
> >      >physicalLength,
> >      > +                                                      read_only=
);
> >      > +        if (source =3D=3D 0) {
> >      > +            success =3D false;
> >      > +            continue;
> >      > +        }
> >      > +
> >      > +        MemoryRegion* alt_mr =3D NULL;
> >      > +        mach_vm_address_t alt_source =3D
> >     (mach_vm_address_t)gpa2hva(&alt_mr, range->physicalAddress, range-
> >      >physicalLength, NULL);
> >      > +        g_assert(alt_source =3D=3D source);
> >
> >     Remove this; I guess this is for debugging.
> >
> >      > +
> >      > +        cur_protection =3D 0;
> >      > +        max_protection =3D 0;
> >      > +        // Map guest RAM at range->physicalAddress into PG task
> >     memory range
> >      > +        r =3D mach_vm_remap(mach_task_self(),
> >      > +                          &target, range->physicalLength,
> >     vm_page_size - 1,
> >      > +                          VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,
> >      > +                          mach_task_self(),
> >      > +                          source, false /* shared mapping, no
> >     copy */,
> >      > +                          &cur_protection, &max_protection,
> >      > +                          VM_INHERIT_COPY);
> >      > +        trace_apple_gfx_remap(r, source, target);
> >      > +        g_assert(r =3D=3D KERN_SUCCESS);
> >      > +    }
> >      > +
> >      > +    qemu_mutex_lock(&s->job_mutex);
> >      > +    job->success =3D success;
> >      > +    job->done =3D true;
> >      > +    qemu_cond_broadcast(&s->job_cond);
> >      > +    qemu_mutex_unlock(&s->job_mutex);
> >      > +}
> >      > +
> >      > +void apple_gfx_await_bh_job(AppleGFXState *s, bool
> *job_done_flag)
> >      > +{
> >      > +    qemu_mutex_lock(&s->job_mutex);
> >      > +    while (!*job_done_flag) {
> >      > +        qemu_cond_wait(&s->job_cond, &s->job_mutex);
> >      > +    }
> >      > +    qemu_mutex_unlock(&s->job_mutex);
> >      > +}
> >      > +
> >      > +typedef struct AppleGFXReadMemoryJob {
> >      > +    AppleGFXState *s;
> >      > +    hwaddr physical_address;
> >      > +    uint64_t length;
> >      > +    void *dst;
> >      > +    bool done;
> >      > +} AppleGFXReadMemoryJob;
> >      > +
> >      > +static void apple_gfx_do_read_memory(void *opaque)
> >      > +{
> >      > +    AppleGFXReadMemoryJob *job =3D opaque;
> >      > +    AppleGFXState *s =3D job->s;
> >      > +
> >      > +    cpu_physical_memory_read(job->physical_address, job->dst,
> >     job->length);
> >
> >     Use: dma_memory_read()
> >
> >      > +
> >      > +    qemu_mutex_lock(&s->job_mutex);
> >      > +    job->done =3D true;
> >      > +    qemu_cond_broadcast(&s->job_cond);
> >      > +    qemu_mutex_unlock(&s->job_mutex);
> >      > +}
> >      > +
> >      > +static void apple_gfx_read_memory(AppleGFXState *s, hwaddr
> >     physical_address,
> >      > +                                  uint64_t length, void *dst)
> >      > +{
> >      > +    AppleGFXReadMemoryJob job =3D {
> >      > +        s, physical_address, length, dst
> >      > +    };
> >      > +
> >      > +    trace_apple_gfx_read_memory(physical_address, length, dst);
> >      > +
> >      > +    /* Traversing the memory map requires RCU/BQL, so do it in =
a
> >     BH. */
> >      > +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >     apple_gfx_do_read_memory,
> >      > +                            &job);
> >      > +    apple_gfx_await_bh_job(s, &job.done);
> >      > +}
> >      > +
> >      > +static void
> >     apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> >      > +
> >       PGDeviceDescriptor *desc)
> >      > +{
> >      > +    desc.createTask =3D ^(uint64_t vmSize, void * _Nullable *
> >     _Nonnull baseAddress) {
> >      > +        PGTask_t *task =3D apple_gfx_new_task(s, vmSize);
> >      > +        *baseAddress =3D (void *)task->address;
> >      > +        trace_apple_gfx_create_task(vmSize, *baseAddress);
> >      > +        return task;
> >      > +    };
> >      > +
> >      > +    desc.destroyTask =3D ^(PGTask_t * _Nonnull task) {
> >      > +        trace_apple_gfx_destroy_task(task);
> >      > +        QTAILQ_REMOVE(&s->tasks, task, node);
> >      > +        mach_vm_deallocate(mach_task_self(), task->address,
> >     task->len);
> >      > +        g_free(task);
> >      > +    };
> >      > +
> >      > +    desc.mapMemory =3D ^bool(PGTask_t * _Nonnull task, uint32_t
> >     range_count,
> >      > +                       uint64_t virtual_offset, bool read_only,
> >      > +                       PGPhysicalMemoryRange_t * _Nonnull
> ranges) {
> >      > +        AppleGFXMapMemoryJob job =3D {
> >      > +            .state =3D s,
> >      > +            .task =3D task, .ranges =3D ranges, .range_count =
=3D
> >     range_count,
> >      > +            .read_only =3D read_only, .virtual_offset =3D
> >     virtual_offset,
> >      > +            .done =3D false, .success =3D true,
> >      > +        };
> >      > +        if (range_count > 0) {
> >      > +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >      > +                                    apple_gfx_map_memory, &job)=
;
> >      > +            apple_gfx_await_bh_job(s, &job.done);
> >      > +        }
> >      > +        return job.success;
> >      > +    };
> >      > +
> >      > +    desc.unmapMemory =3D ^bool(PGTask_t * _Nonnull task, uint64=
_t
> >     virtualOffset,
> >      > +                         uint64_t length) {
> >      > +        kern_return_t r;
> >      > +        mach_vm_address_t range_address;
> >      > +
> >      > +        trace_apple_gfx_unmap_memory(task, virtualOffset,
> length);
> >      > +
> >      > +        /* Replace task memory range with fresh pages, undoing
> >     the mapping
> >      > +         * from guest RAM. */
> >      > +        range_address =3D task->address + virtualOffset;
> >      > +        r =3D mach_vm_allocate(mach_task_self(), &range_address=
,
> >     length,
> >      > +                             VM_FLAGS_FIXED |
> VM_FLAGS_OVERWRITE);
> >      > +        g_assert(r =3D=3D KERN_SUCCESS);error_setg
> >
> >     An extra error_setg
> >
> >      > +
> >      > +        return true;
> >      > +    };
> >      > +
> >      > +    desc.readMemory =3D ^bool(uint64_t physical_address, uint64=
_t
> >     length,
> >      > +                            void * _Nonnull dst) {
> >      > +        apple_gfx_read_memory(s, physical_address, length, dst)=
;
> >      > +        return true;
> >      > +    };
> >      > +}
> >      > +
> >      > +static PGDisplayDescriptor
> >     *apple_gfx_prepare_display_descriptor(AppleGFXState *s)
> >      > +{
> >      > +    PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor new=
];
> >      > +
> >      > + disp_desc.name <http://disp_desc.name> =3D @"QEMU display";
> >      > +    disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.); /* =
A
> >     20" display */
> >      > +    disp_desc.queue =3D dispatch_get_main_queue();
> >      > +    disp_desc.newFrameEventHandler =3D ^(void) {
> >      > +        trace_apple_gfx_new_frame();
> >      > +        dispatch_async(s->render_queue, ^{
> >      > +            /* Drop frames if we get too far ahead. */
> >      > +            bql_lock();
> >      > +            if (s->pending_frames >=3D 2) {
> >      > +                bql_unlock();
> >      > +                return;
> >      > +            }
> >      > +            ++s->pending_frames;
> >      > +            if (s->pending_frames > 1) {
> >      > +                bql_unlock();
> >      > +                return;
> >      > +            }
> >      > +            @autoreleasepool {
> >      > +                apple_gfx_render_new_frame_bql_unlock(s);
> >      > +            }
> >      > +        });
> >      > +    };
> >      > +    disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t
> sizeInPixels,
> >      > +                                    OSType pixelFormat) {
> >      > +        trace_apple_gfx_mode_change(sizeInPixels.x,
> sizeInPixels.y);
> >      > +
> >      > +        BQL_LOCK_GUARD();
> >      > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> >      > +    };
> >      > +    disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *glyph,
> >      > +                                     PGDisplayCoord_t hotSpot) =
{
> >      > +        [glyph retain];
> >      > +        dispatch_async(get_background_queue(), ^{
> >      > +            BQL_LOCK_GUARD();
> >      > +            uint32_t bpp =3D glyph.bitsPerPixel;
> >      > +            size_t width =3D glyph.pixelsWide;
> >      > +            size_t height =3D glyph.pixelsHigh;
> >      > +            size_t padding_bytes_per_row =3D glyph.bytesPerRow =
-
> >     width * 4;
> >      > +            const uint8_t* px_data =3D glyph.bitmapData;
> >      > +
> >      > +            trace_apple_gfx_cursor_set(bpp, width, height);
> >      > +
> >      > +            if (s->cursor) {
> >      > +                cursor_unref(s->cursor);
> >      > +                s->cursor =3D NULL;
> >      > +            }
> >      > +
> >      > +            if (bpp =3D=3D 32) { /* Shouldn't be anything else,=
 but
> >     just to be safe...*/
> >      > +                s->cursor =3D cursor_alloc(width, height);
> >      > +                s->cursor->hot_x =3D hotSpot.x;
> >      > +                s->cursor->hot_y =3D hotSpot.y;
> >      > +
> >      > +                uint32_t *dest_px =3D s->cursor->data;
> >      > +
> >      > +                for (size_t y =3D 0; y < height; ++y) {
> >      > +                    for (size_t x =3D 0; x < width; ++x) {
> >      > +                        /* NSBitmapImageRep's red & blue
> >     channels are swapped
> >      > +                         * compared to QEMUCursor's. */
> >      > +                        *dest_px =3D
> >      > +                            (px_data[0] << 16u) |
> >      > +                            (px_data[1] <<  8u) |
> >      > +                            (px_data[2] <<  0u) |
> >      > +                            (px_data[3] << 24u);
> >      > +                        ++dest_px;
> >      > +                        px_data +=3D 4;
> >      > +                    }
> >      > +                    px_data +=3D padding_bytes_per_row;
> >      > +                }
> >      > +                dpy_cursor_define(s->con, s->cursor);
> >      > +                update_cursor(s);
> >      > +            }
> >      > +            [glyph release];
> >      > +        });
> >      > +    };
> >      > +    disp_desc.cursorShowHandler =3D ^(BOOL show) {
> >      > +        dispatch_async(get_background_queue(), ^{
> >      > +            BQL_LOCK_GUARD();
> >      > +            trace_apple_gfx_cursor_show(show);
> >      > +            s->cursor_show =3D show;
> >      > +            update_cursor(s);
> >      > +        });
> >      > +    };
> >      > +    disp_desc.cursorMoveHandler =3D ^(void) {
> >      > +        dispatch_async(get_background_queue(), ^{
> >      > +            BQL_LOCK_GUARD();
> >      > +            trace_apple_gfx_cursor_move();
> >      > +            update_cursor(s);
> >      > +        });
> >      > +    };
> >      > +
> >      > +    return disp_desc;
> >      > +}
> >      > +
> >      > +static NSArray<PGDisplayMode*>*
> >     apple_gfx_prepare_display_mode_array(void)
> >      > +{
> >      > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> >      > +    NSArray<PGDisplayMode*>* mode_array =3D nil;
> >      > +    int i;
> >      > +
> >      > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> >      > +        modes[i] =3D
> >      > +            [[PGDisplayMode alloc]
> >     initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
> >      > +    }
> >      > +
> >      > +    mode_array =3D [NSArray arrayWithObjects:modes
> >     count:ARRAY_SIZE(apple_gfx_modes)];
> >      > +
> >      > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> >      > +        [modes[i] release];
> >      > +        modes[i] =3D nil;
> >      > +    }
> >      > +
> >      > +    return mode_array;
> >      > +}
> >      > +
> >      > +static id<MTLDevice> copy_suitable_metal_device(void)
> >      > +{
> >      > +    id<MTLDevice> dev =3D nil;
> >      > +    NSArray<id<MTLDevice>> *devs =3D MTLCopyAllDevices();
> >      > +
> >      > +    /* Prefer a unified memory GPU. Failing that, pick a non-
> >     removable GPU. */
> >      > +    for (size_t i =3D 0; i < devs.count; ++i) {
> >      > +        if (devs[i].hasUnifiedMemory) {
> >      > +            dev =3D devs[i];
> >      > +            break;
> >      > +        }
> >      > +        if (!devs[i].removable) {
> >      > +            dev =3D devs[i];
> >      > +        }
> >      > +    }
> >      > +
> >      > +    if (dev !=3D nil) {
> >      > +        [dev retain];
> >      > +    } else {
> >      > +        dev =3D MTLCreateSystemDefaultDevice();
> >      > +    }
> >      > +    [devs release];
> >      > +
> >      > +    return dev;
> >      > +}
> >      > +
> >      > +void apple_gfx_common_realize(AppleGFXState *s,
> >     PGDeviceDescriptor *desc,
> >      > +                              Error **errp)
> >      > +{
> >      > +    PGDisplayDescriptor *disp_desc =3D nil;
> >      > +
> >      > +    if (apple_gfx_mig_blocker =3D=3D NULL) {
> >      > +        error_setg(&apple_gfx_mig_blocker,
> >      > +                  "Migration state blocked by apple-gfx display
> >     device");
> >      > +        if (migrate_add_blocker(&apple_gfx_mig_blocker, errp) <
> 0) {
> >      > +            return;
> >      > +        }
> >      > +    }
> >      > +
> >      > +    QTAILQ_INIT(&s->tasks);
> >      > +    s->render_queue =3D dispatch_queue_create("apple-gfx.render=
",
> >      > +
> DISPATCH_QUEUE_SERIAL);
> >      > +    s->mtl =3D copy_suitable_metal_device();
> >      > +    s->mtl_queue =3D [s->mtl newCommandQueue];
> >      > +
> >      > +    desc.device =3D s->mtl;
> >      > +
> >      > +    apple_gfx_register_task_mapping_handlers(s, desc);
> >      > +
> >      > +    s->pgdev =3D PGNewDeviceWithDescriptor(desc);
> >      > +
> >      > +    disp_desc =3D apple_gfx_prepare_display_descriptor(s);
> >      > +    s->pgdisp =3D [s->pgdev newDisplayWithDescriptor:disp_desc
> >      > +                                              port:0
> >     serialNum:1234];
> >      > +    [disp_desc release];
> >      > +    s->pgdisp.modeList =3D apple_gfx_prepare_display_mode_array=
();
> >      > +
> >      > +    create_fb(s);
> >      > +
> >      > +    qemu_mutex_init(&s->job_mutex);
> >      > +    qemu_cond_init(&s->job_cond);
> >      > +}
> >      > diff --git a/hw/display/meson.build b/hw/display/meson.build
> >      > index 20a94973fa2..619e642905a 100644
> >      > --- a/hw/display/meson.build
> >      > +++ b/hw/display/meson.build
> >      > @@ -61,6 +61,10 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true:
> >     files('artist.c'))
> >      >
> >      >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c',
> >     'ati_2d.c', 'ati_dbg.c'), pixman])
> >      >
> >      > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
> >     [files('apple-gfx.m'), pvg, metal])
> >      > +if cpu =3D=3D 'aarch64'
> >      > +  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true:
> >     [files('apple-gfx-mmio.m'), pvg, metal])
> >      > +endif
> >      >
> >      >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >      >     virtio_gpu_ss =3D ss.source_set()
> >      > diff --git a/hw/display/trace-events b/hw/display/trace-events
> >      > index 781f8a33203..214998312b9 100644
> >      > --- a/hw/display/trace-events
> >      > +++ b/hw/display/trace-events
> >      > @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width)
> >     "dest_width : %u"
> >      >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> >      >   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
> >      >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> >      > +
> >      > +# apple-gfx.m
> >      > +apple_gfx_read(uint64_t offset, uint64_t res)
> >     "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> >      > +apple_gfx_write(uint64_t offset, uint64_t val)
> >     "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> >      > +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=3D0x=
%x
> >     base_addr=3D%p"
> >      > +apple_gfx_destroy_task(void *task) "task=3D%p"
> >      > +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t
> >     virtual_offset, uint32_t read_only) "task=3D%p range_count=3D0x%x
> >     virtual_offset=3D0x%"PRIx64" read_only=3D%d"
> >      > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr,
> >     uint64_t phys_len) "[%d] phys_addr=3D0x%"PRIx64" phys_len=3D0x%"PRI=
x64
> >      > +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t
> >     target) "retval=3D%"PRId64" source=3D0x%"PRIx64" target=3D0x%"PRIx6=
4
> >      > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset,
> >     uint64_t length) "task=3D%p virtual_offset=3D0x%"PRIx64"
> length=3D0x%"PRIx64
> >      > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length,
> >     void *dst) "phys_addr=3D0x%"PRIx64" length=3D0x%"PRIx64" dest=3D%p"
> >      > +apple_gfx_raise_irq(uint32_t vector) "vector=3D0x%x"
> >      > +apple_gfx_new_frame(void) ""
> >      > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=3D%"PRId64"
> >     y=3D%"PRId64
> >      > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t
> >     height) "bpp=3D%d width=3D%"PRId64" height=3D0x%"PRId64
> >      > +apple_gfx_cursor_show(uint32_t show) "show=3D%d"
> >      > +apple_gfx_cursor_move(void) ""
> >      > +apple_gfx_common_init(const char *device_name, size_t mmio_size=
)
> >     "device: %s; MMIO size: %zu bytes"
> >      > +
> >      > +# apple-gfx-mmio.m
> >      > +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res)
> >     "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> >      > +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val)
> >     "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> >      > +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_=
t
> >     ro, void *va, void *e, void *f, void* va_result, int success)
> >     "phys=3D0x%"PRIx64" len=3D0x%"PRIx64" ro=3D%d va=3D%p e=3D%p f=3D%p=
 -> *va=3D%p,
> >     success =3D %d"
> >      > +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d=
,
> >     void *e, void *f) "a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p"
> >      > +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=3D0x%x"
> >      > +
> >      > diff --git a/meson.build b/meson.build
> >      > index d26690ce204..0e124eff13f 100644
> >      > --- a/meson.build
> >      > +++ b/meson.build
> >      > @@ -761,6 +761,8 @@ socket =3D []
> >      >   version_res =3D []
> >      >   coref =3D []
> >      >   iokit =3D []
> >      > +pvg =3D []
> >      > +metal =3D []
> >      >   emulator_link_args =3D []
> >      >   midl =3D not_found
> >      >   widl =3D not_found
> >      > @@ -782,6 +784,8 @@ elif host_os =3D=3D 'darwin'
> >      >     coref =3D dependency('appleframeworks', modules:
> 'CoreFoundation')
> >      >     iokit =3D dependency('appleframeworks', modules: 'IOKit',
> >     required: false)
> >      >     host_dsosuf =3D '.dylib'
> >      > +  pvg =3D dependency('appleframeworks', modules:
> >     'ParavirtualizedGraphics')
> >      > +  metal =3D dependency('appleframeworks', modules: 'Metal')
> >      >   elif host_os =3D=3D 'sunos'
> >      >     socket =3D [cc.find_library('socket'),
> >      >               cc.find_library('nsl'),
> >
>
>

--00000000000007f7f406255ea3d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, 26 Oct 2024 at 06:40, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2024/10/26 4:43, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, 25 Oct 2024 at 08:03, Akihiko Odaki &lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2024/10/24 19:28, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* For running PVG memory-mapp=
ing requests in the AIO context */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QemuCond job_cond;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QemuMutex job_mutex;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Use: QemuEvent<br>
&gt; <br>
&gt; <br>
&gt; Hmm. I think if we were to use that, we would need to create a new <br=
>
&gt; QemuEvent for every job and destroy it afterward, which seems expensiv=
e. <br>
&gt; We can&#39;t rule out multiple concurrent jobs being submitted, and th=
e <br>
&gt; QemuEvent system only supports a single producer as far as I can tell.=
<br>
&gt; <br>
&gt; You can probably sort of hack around it with just one QemuEvent by <br=
>
&gt; putting the qemu_event_wait into a loop and turning the job.done flag =
<br>
&gt; into an atomic (because it would now need to be checked outside the <b=
r>
&gt; lock) but this all seems unnecessarily complicated considering the <br=
>
&gt; QemuEvent uses the same mechanism QemuCond/QemuMutex internally on mac=
OS <br>
&gt; (the only platform relevant here), except we can use it as intended wi=
th <br>
&gt; QemuCond/QemuMutex rather than having to work against the abstraction.=
<br>
<br>
I don&#39;t think it&#39;s going to be used concurrently. It would be diffi=
cult <br>
to reason even for the framework if it performs memory <br>
unmapping/mapping/reading operations concurrently.</blockquote><div><br></d=
iv><div>I&#39;ve just performed a very quick test by wrapping the job submi=
ssion/wait in the 2 mapMemory callbacks and the 1 readMemory callback with =
atomic counters and logging whenever a counter went above 1.</div><div><br>=
</div><div>=C2=A0* Overall, concurrent callbacks across all types were comm=
on (many per second when the VM is busy). It&#39;s not exactly a &quot;thun=
dering herd&quot; (I never saw &gt;2) but it&#39;s probably not a bad idea =
to use a separate condition variable for each job type. (task map, surface =
map, memory read)</div><div>=C2=A0* While I did not observe any concurrent =
memory mapping operations <b>within</b> a type of memory map (2 task mappin=
gs or 2 surface mappings) I did see very occasional concurrent memory <b>re=
ad</b> callbacks. These would, as far as I can tell, not be safe with QemuE=
vents, unless we placed the event inside the job struct and init/destroyed =
it on every callback (which seems like excessive overhead).</div><div><br><=
/div><div>My recommendation would be to split it up into 3 pairs of mutex/c=
ond; this will almost entirely remove any contention, but continue to be sa=
fe for when it does occur. I don&#39;t think QemuEvent is a realistic optio=
n (too tricky to get right) for the observed-concurrent readMemory callback=
. I&#39;m nervous about assuming the mapMemory callbacks will NEVER be call=
ed concurrently, but at a push I&#39;ll acquiesce to switching those to Qem=
uEvent in the absence of evidence of concurrency.<br></div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"> PGDevice.h also notes <=
br>
raiseInterrupt needs to be thread-safe while it doesn&#39;t make such notes=
 <br>
for memory operations. This actually makes sense.<br>
<br>
If it&#39;s ever going to be used concurrently, it&#39;s better to have <br=
>
QemuEvent for each job to avoid the thundering herd problem.<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispatch_queue_t render_queue;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* The following fields should=
 only be accessed from the BQL: */<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Perhaps it may be better to document fields that ca=
n be accessed<br>
&gt;=C2=A0 =C2=A0 =C2=A0*without* the BQL; most things in QEMU implicitly r=
equire the BQL.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool gfx_update_requested;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool new_frame_ready;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool using_managed_texture_sto=
rage;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} AppleGFXState;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_common_init(Object *obj, Appl=
eGFXState *s, const<br>
&gt;=C2=A0 =C2=A0 =C2=A0char* obj_name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_common_realize(AppleGFXState =
*s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor *desc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +uintptr_t apple_gfx_host_address_for_gpa_ran=
ge(uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest_physical,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length,<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool read_only);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_await_bh_job(AppleGFXState *s=
, bool *job_done_flag);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/display/apple-gfx.m b/hw/disp=
lay/apple-gfx.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..46be9957f69<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/apple-gfx.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,713 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * QEMU Apple ParavirtualizedGraphics.framew=
ork device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or=
 its affiliates. All<br>
&gt;=C2=A0 =C2=A0 =C2=A0Rights Reserved.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This work is licensed under the terms of =
the GNU GPL, version<br>
&gt;=C2=A0 =C2=A0 =C2=A02 or later.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * See the COPYING file in the top-level dir=
ectory.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ParavirtualizedGraphics.framework is a se=
t of libraries that<br>
&gt;=C2=A0 =C2=A0 =C2=A0macOS provides<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * which implements 3d graphics passthrough =
to the host as well as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * proprietary guest communication channel t=
o drive it. This<br>
&gt;=C2=A0 =C2=A0 =C2=A0device model<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * implements support to drive that library =
from within QEMU.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#import &lt;ParavirtualizedGraphics/Paravirt=
ualizedGraphics.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &lt;mach/mach_vm.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;apple-gfx.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;trace.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu-main.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;exec/address-spaces.h&quot;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;migration/blocker.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;monitor/monitor.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/cutils.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/log.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;ui/console.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const PGDisplayCoord_t apple_gfx_mode=
s[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 { .x =3D 1440, .y =3D 1080 },<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 { .x =3D 1280, .y =3D 1024 },<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/* This implements a type defined in &lt;Par=
avirtualizedGraphics/<br>
&gt;=C2=A0 =C2=A0 =C2=A0PGDevice.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * which is opaque from the framework&#39;s =
point of view. Typedef<br>
&gt;=C2=A0 =C2=A0 =C2=A0PGTask_t already<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * exists in the framework headers. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +struct PGTask_s {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QTAILQ_ENTRY(PGTask_s) node;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mach_vm_address_t address;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static Error *apple_gfx_mig_blocker;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This does not have to be a static variable.<br>
&gt; <br>
&gt; <br>
&gt; Hmm, the first 5 or so examples of migration blockers in other devices=
 <br>
&gt; etc. I could find were all declared in this way. What are you suggesti=
ng <br>
&gt; as the alternative? And why not use the same pattern as in most of the=
 <br>
&gt; rest of the code base?<br>
<br>
I was wrong. This is better to be a static variable to ensure we won&#39;t =
<br>
add the same blocker in case we have two device instances.<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_render_frame_completed=
(AppleGFXState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t width,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static inline dispatch_queue_t get_backgroun=
d_queue(void)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Don&#39;t add inline. The only effect for modern co=
mpilers of inline is to<br>
&gt;=C2=A0 =C2=A0 =C2=A0suppress the unused function warnings.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_D=
EFAULT, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static PGTask_t *apple_gfx_new_task(AppleGFX=
State *s, uint64_t len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mach_vm_address_t task_mem;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGTask_t *task;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 kern_return_t r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 r =3D mach_vm_allocate(mach_ta=
sk_self(), &amp;task_mem, len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0VM_FLAGS_ANYWHERE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (r !=3D KERN_SUCCESS || tas=
k_mem =3D=3D 0) {<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Let&#39;s remove the check for task_mem =3D=3D 0. W=
e have no reason to<br>
&gt;=C2=A0 =C2=A0 =C2=A0reject it<br>
&gt;=C2=A0 =C2=A0 =C2=A0if the platform insists it allocated a memory at ad=
dress 0 though<br>
&gt;=C2=A0 =C2=A0 =C2=A0such a<br>
&gt;=C2=A0 =C2=A0 =C2=A0situation should never happen in practice.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 task =3D g_new0(PGTask_t, 1);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 task-&gt;address =3D task_mem;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 task-&gt;len =3D len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_TAIL(&amp;s-&gt;=
tasks, task, node);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return task;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct AppleGFXIOJob {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXState *state;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool completed;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} AppleGFXIOJob;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_do_read(void *opaque)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXIOJob *job =3D opaque;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 job-&gt;value =3D [job-&gt;sta=
te-&gt;pgdev mmioReadAtOffset:job-&gt;offset];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qatomic_set(&amp;job-&gt;compl=
eted, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static uint64_t apple_gfx_read(void *opaque,=
 hwaddr offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0unsigned size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXIOJob job =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D opaqu=
e,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =3D offs=
et,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .completed =3D f=
alse,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AioContext *context =3D qemu_g=
et_aio_context();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D get=
_background_queue();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispatch_async_f(queue, &amp;j=
ob, apple_gfx_do_read);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AIO_WAIT_WHILE(context, !qatom=
ic_read(&amp;job.completed));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_apple_gfx_read(offset, j=
ob.value);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return job.value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_do_write(void *opaque)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXIOJob *job =3D opaque;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [job-&gt;state-&gt;pgdev mmioW=
riteAtOffset:job-&gt;offset value:job-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;value];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qatomic_set(&amp;job-&gt;compl=
eted, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_write(void *opaque, hw=
addr offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t val,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* The methods mmioReadAtOffse=
t: and especially<br>
&gt;=C2=A0 =C2=A0 =C2=A0mmioWriteAtOffset: can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* trigger and block on o=
perations on other dispatch queues,<br>
&gt;=C2=A0 =C2=A0 =C2=A0which in turn<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* may call back out on o=
ne or more of the callback blocks.<br>
&gt;=C2=A0 =C2=A0 =C2=A0For this reason,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* and as we are holding =
the BQL, we invoke the I/O methods<br>
&gt;=C2=A0 =C2=A0 =C2=A0on a pool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* thread and handle AIO =
tasks while we wait. Any work in<br>
&gt;=C2=A0 =C2=A0 =C2=A0the callbacks<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* requiring the BQL will=
 in turn schedule BHs which this<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* process while waiting.=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXIOJob job =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .state =3D opaqu=
e,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =3D offs=
et,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .value =3D val,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .completed =3D f=
alse,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AioContext *context =3D qemu_g=
et_current_aio_context();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispatch_queue_t queue =3D get=
_background_queue();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispatch_async_f(queue, &amp;j=
ob, apple_gfx_do_write);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AIO_WAIT_WHILE(context, !qatom=
ic_read(&amp;job.completed));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_apple_gfx_write(offset, =
val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const MemoryRegionOps apple_gfx_ops =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .read =3D apple_gfx_read,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .write =3D apple_gfx_write,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_=
ENDIAN,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size=
 =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size=
 =3D 8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size=
 =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size=
 =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_render_new_frame_bql_u=
nlock(AppleGFXState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 BOOL r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t width =3D surface_wid=
th(s-&gt;surface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t height =3D surface_he=
ight(s-&gt;surface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MTLRegion region =3D MTLRegion=
Make2D(0, 0, width, height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 id&lt;MTLCommandBuffer&gt; com=
mand_buffer =3D [s-&gt;mtl_queue<br>
&gt;=C2=A0 =C2=A0 =C2=A0commandBuffer];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 id&lt;MTLTexture&gt; texture =
=3D s-&gt;texture;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [texture retain];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* This is not safe to call fr=
om the BQL due to PVG-internal<br>
&gt;=C2=A0 =C2=A0 =C2=A0locks causing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* deadlocks. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 r =3D [s-&gt;pgdisp encodeCurr=
entFrameToCommandBuffer:command_buffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0texture:texture<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 region:region];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!r) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [texture release=
];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 --s-&gt;pending_=
frames;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LO=
G_GUEST_ERROR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;apple_gfx_render_new_frame_bql_unlock: &quot;=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Use: __func__<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;encodeCurrentFrameToCommandBuffer:texture:reg=
ion: failed\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (s-&gt;using_managed_textur=
e_storage) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* &quot;Managed=
&quot; textures exist in both VRAM and RAM and<br>
&gt;=C2=A0 =C2=A0 =C2=A0must be synced. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 id&lt;MTLBlitCom=
mandEncoder&gt; blit =3D [command_buffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0blitCommandEncoder];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [blit synchroniz=
eResource:texture];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [blit endEncodin=
g];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [texture release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [command_buffer addCompletedHa=
ndler:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^(id&lt;MTLComma=
ndBuffer&gt; cb)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 di=
spatch_async(s-&gt;render_queue, ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 apple_gfx_render_frame_completed(s, width, height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 })=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [command_buffer commit];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void copy_mtl_texture_to_surface_mem(=
id&lt;MTLTexture&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0texture, void *vram)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* TODO: Skip this entirely on=
 a pure Metal or headless/<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest-only<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* rendering path, else u=
se a blit command encoder? Needs<br>
&gt;=C2=A0 =C2=A0 =C2=A0careful<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* (double?) buffering de=
sign. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 size_t width =3D texture.width=
, height =3D texture.height;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MTLRegion region =3D MTLRegion=
Make2D(0, 0, width, height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [texture getBytes:vram<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytesPerR=
ow:(width * 4)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytesPerImage:(w=
idth * height * 4)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fro=
mRegion:region<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mipmapLev=
el:0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 slice:0];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}copy_mtl_texture_to_surface_mem<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_render_frame_completed=
(AppleGFXState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t width,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t height)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 --s-&gt;pending_frames;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 assert(s-&gt;pending_frames &g=
t;=3D 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Only update display if mode=
 hasn&#39;t changed since we<br>
&gt;=C2=A0 =C2=A0 =C2=A0started rendering. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (width =3D=3D surface_width=
(s-&gt;surface) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 height =3D=3D su=
rface_height(s-&gt;surface)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 copy_mtl_texture=
_to_surface_mem(s-&gt;texture, s-&gt;vram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;gfx_up=
date_requested) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;gfx_update_requested =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dp=
y_gfx_update_full(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gr=
aphic_hw_update_done(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;new_frame_ready =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;new_frame_ready =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (s-&gt;pending_frames &gt; =
0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_render=
_new_frame_bql_unlock(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_fb_update_display(void=
 *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D opaque;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (s-&gt;new_frame_ready) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update_f=
ull(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_=
ready =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_updat=
e_done(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } else if (s-&gt;pending_frame=
s &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update=
_requested =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_updat=
e_done(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const GraphicHwOps apple_gfx_fb_ops =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .gfx_update =3D apple_gfx_fb_u=
pdate_display,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .gfx_update_async =3D true,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void update_cursor(AppleGFXState *s)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 assert(bql_locked());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dpy_mouse_set(s-&gt;con, s-&gt=
;pgdisp.cursorPosition.x,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 s-&gt;pgdisp.cursorPosition.y, s-&gt;cursor_show);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void set_mode(AppleGFXState *s, uint3=
2_t width, uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0height)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MTLTextureDescriptor *textureD=
escriptor;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (s-&gt;surface &amp;&amp;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D=3D sur=
face_width(s-&gt;surface) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 height =3D=3D su=
rface_height(s-&gt;surface)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 g_free(s-&gt;vram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [s-&gt;texture release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;vram =3D g_malloc0_n(wid=
th * height, 4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;surface =3D qemu_create_=
displaysurface_from(width, height,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PIXMAN_LE_a8r8g8b8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0width * 4, s-<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;vram);&gt; +&gt; +=C2=A0 =C2=A0 @autoreleasepo=
ol {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescripto=
r =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [M=
TLTextureDescriptor<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0texture2DDescriptorWithPixelFormat:MTLPixelFormatBG=
RA8Unorm<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0width:width<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 height:height<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mipmapped:NO];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescripto=
r.usage =3D s-&gt;pgdisp.minimumTextureUsage;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;texture =
=3D [s-&gt;mtl<br>
&gt;=C2=A0 =C2=A0 =C2=A0newTextureWithDescriptor:textureDescriptor];<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0What about creating pixman_image_t from s-&gt;textu=
re.buffer.contents?<br>
&gt;=C2=A0 =C2=A0 =C2=A0This<br>
&gt;=C2=A0 =C2=A0 =C2=A0should save memory usage by removing the duplicatio=
n of texture.<br>
&gt; <br>
&gt; <br>
&gt; We need explicit control over when the GPU vs when the CPU may access =
<br>
&gt; the texture - only one of them may access them at a time. As far as I =
<br>
&gt; can tell, we can&#39;t control when the rest of Qemu might access the =
<br>
&gt; pixman_image used in the console surface?<br>
<br>
You are right; we need to have duplicate buffers. We can still avoid <br>
copying by using two MTLTextures for double-buffering instead of having <br=
>
a MTLTexture and a pixman_image and copying between them for <br>
MTLStorageModeManaged.<br></blockquote><div>=C2=A0</div><div>Do I understan=
d correctly that you intend to swap the surface-&gt;image on every frame, o=
r even the surface-&gt;image-&gt;data? If so, it&#39;s my understanding fro=
m reading the source of a bunch of UI implementations a few weeks ago that =
this is neither supported nor safe, as some implementations take long-lived=
 references to these internal data structures until a  dpy_gfx_switch callb=
ack. And the implementations for those callbacks are in turn very expensive=
 in some cases. This is why my conclusion in the v4 thread was that double-=
buffering was infeasible with the current architecture.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;using_managed_texture_st=
orage =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;texture.s=
torageMode =3D=3D MTLStorageModeManaged);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dpy_gfx_replace_surface(s-&gt;=
con, s-&gt;surface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_fb(AppleGFXState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;con =3D graphic_console_=
init(NULL, 0, &amp;apple_gfx_fb_ops, s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 set_mode(s, 1440, 1080);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cursor_show =3D true;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static size_t apple_gfx_get_default_mmio_ran=
ge_size(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 size_t mmio_range_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDeviceDescript=
or *desc =3D [PGDeviceDescriptor new];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_range_size =
=3D desc.mmioLength;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [desc release];<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return mmio_range_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_common_init(Object *obj, Appl=
eGFXState *s, const<br>
&gt;=C2=A0 =C2=A0 =C2=A0char* obj_name)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 size_t mmio_range_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_get_default_mmio_range_size();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_apple_gfx_common_init(ob=
j_name, mmio_range_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&=
gt;iomem_gfx, obj, &amp;apple_gfx_ops, s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0obj_name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_range_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* TODO: PVG framework support=
s serialising device state:<br>
&gt;=C2=A0 =C2=A0 =C2=A0integrate it! */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct AppleGFXMapMemoryJob {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXState *state;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGTask_t *task;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t virtual_offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGPhysicalMemoryRange_t *range=
s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t range_count;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool read_only;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool success;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool done;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} AppleGFXMapMemoryJob;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +uintptr_t apple_gfx_host_address_for_gpa_ran=
ge(uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest_physical,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length,<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool read_only)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion *ram_region;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uintptr_t host_address;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr ram_region_offset =3D 0=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr ram_region_length =3D l=
ength;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 ram_region =3D address_space_t=
ranslate(&amp;address_space_memory,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_physical,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ram_region_offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ram_region_length, !<br>
&gt;=C2=A0 =C2=A0 =C2=A0read_only,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MEMTXATTRS_UNSPECIFIED);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Call memory_region_ref() so that it won&#39;t go aw=
ay.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!ram_region || ram_region_=
length &lt; length ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !memory_access_i=
s_direct(ram_region, !read_only)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 host_address =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0(mach_vm_address_t)memory_region_get_ram_ptr(ram_re=
gion);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0host_address is typed as uintptr_t, not mach_vm_add=
ress_t.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (host_address =3D=3D 0) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 host_address +=3D ram_region_o=
ffset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return host_address;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_map_memory(void *opaqu=
e)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXMapMemoryJob *job =3D =
opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D job-&gt;s=
tate;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGTask_t *task=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D job-&gt;task;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t range_count=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D job-&gt;range_count;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t virtual_offset=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D job-&gt;virtual_offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGPhysicalMemoryRange_t *range=
s =3D job-&gt;ranges;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool read_only=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D job-&gt;read_only;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 kern_return_t r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mach_vm_address_t target, sour=
ce;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vm_prot_t cur_protection, max_=
protection;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool success =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 g_assert(bql_locked());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_apple_gfx_map_memory(tas=
k, range_count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtual_offset, read_only);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; range=
_count; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGPhysicalMemory=
Range_t *range =3D &amp;ranges[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target =3D task-=
&gt;address + virtual_offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtual_offset +=
=3D range-&gt;physicalLength;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
map_memory_range(i, range-&gt;physicalAddress,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0range-&gt;physicalLength);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 source =3D apple=
_gfx_host_address_for_gpa_range(range-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;physicalAddress,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
ange-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;physicalLength,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
ead_only);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (source =3D=
=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 su=
ccess =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 co=
ntinue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion* al=
t_mr =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mach_vm_address_=
t alt_source =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0(mach_vm_address_t)gpa2hva(&amp;alt_mr, range-&gt;p=
hysicalAddress, range-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;physicalLength, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(alt_sou=
rce =3D=3D source);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Remove this; I guess this is for debugging.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cur_protection =
=3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_protection =
=3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Map guest RAM=
 at range-&gt;physicalAddress into PG task<br>
&gt;=C2=A0 =C2=A0 =C2=A0memory range<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D mach_vm_re=
map(mach_task_self(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;target, range-&gt;phy=
sicalLength,<br>
&gt;=C2=A0 =C2=A0 =C2=A0vm_page_size - 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VM_FLAGS_FIXED | VM_FLAGS_=
OVERWRITE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mach_task_self(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 source, false /* shared ma=
pping, no<br>
&gt;=C2=A0 =C2=A0 =C2=A0copy */,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cur_protection, &amp;=
max_protection,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VM_INHERIT_COPY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
remap(r, source, target);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(r =3D=
=3D KERN_SUCCESS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;job=
_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 job-&gt;success =3D success;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt=
;job_cond);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;j=
ob_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_await_bh_job(AppleGFXState *s=
, bool *job_done_flag)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;job=
_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 while (!*job_done_flag) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cond_wait(&=
amp;s-&gt;job_cond, &amp;s-&gt;job_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;j=
ob_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct AppleGFXReadMemoryJob {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXState *s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 hwaddr physical_address;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t length;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 void *dst;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool done;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} AppleGFXReadMemoryJob;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_do_read_memory(void *o=
paque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXReadMemoryJob *job =3D=
 opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D job-&gt;s=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 cpu_physical_memory_read(job-&=
gt;physical_address, job-&gt;dst,<br>
&gt;=C2=A0 =C2=A0 =C2=A0job-&gt;length);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Use: dma_memory_read()<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_mutex_lock(&amp;s-&gt;job=
_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 job-&gt;done =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_cond_broadcast(&amp;s-&gt=
;job_cond);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;s-&gt;j=
ob_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_read_memory(AppleGFXSt=
ate *s, hwaddr<br>
&gt;=C2=A0 =C2=A0 =C2=A0physical_address,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t length, void *dst)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXReadMemoryJob job =3D =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s, physical_addr=
ess, length, dst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_apple_gfx_read_memory(ph=
ysical_address, length, dst);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Traversing the memory map r=
equires RCU/BQL, so do it in a<br>
&gt;=C2=A0 =C2=A0 =C2=A0BH. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 aio_bh_schedule_oneshot(qemu_g=
et_aio_context(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_do_read_memory,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;job);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 apple_gfx_await_bh_job(s, &amp=
;job.done);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_register_task_mapping_handlers(AppleGFXSt=
ate *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.createTask =3D ^(uint64_t=
 vmSize, void * _Nullable *<br>
&gt;=C2=A0 =C2=A0 =C2=A0_Nonnull baseAddress) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGTask_t *task =
=3D apple_gfx_new_task(s, vmSize);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *baseAddress =3D=
 (void *)task-&gt;address;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
create_task(vmSize, *baseAddress);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return task;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.destroyTask =3D ^(PGTask_=
t * _Nonnull task) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
destroy_task(task);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_REMOVE(&a=
mp;s-&gt;tasks, task, node);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mach_vm_dealloca=
te(mach_task_self(), task-&gt;address,<br>
&gt;=C2=A0 =C2=A0 =C2=A0task-&gt;len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(task);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.mapMemory =3D ^bool(PGTas=
k_t * _Nonnull task, uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0range_count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t virtual_offset, bool read=
_only,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGPhysicalMemoryRange_t * _Nonnull=
 ranges) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXMapMemor=
yJob job =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .s=
tate =3D s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .t=
ask =3D task, .ranges =3D ranges, .range_count =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0range_count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .r=
ead_only =3D read_only, .virtual_offset =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtual_offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .d=
one =3D false, .success =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (range_count =
&gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ai=
o_bh_schedule_oneshot(qemu_get_aio_context(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 apple_gfx_map_memory, &amp;job);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ap=
ple_gfx_await_bh_job(s, &amp;job.done);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return job.succe=
ss;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.unmapMemory =3D ^bool(PGT=
ask_t * _Nonnull task, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtualOffset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t length) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kern_return_t r;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mach_vm_address_=
t range_address;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
unmap_memory(task, virtualOffset, length);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Replace task =
memory range with fresh pages, undoing<br>
&gt;=C2=A0 =C2=A0 =C2=A0the mapping<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* from gue=
st RAM. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 range_address =
=3D task-&gt;address + virtualOffset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D mach_vm_al=
locate(mach_task_self(), &amp;range_address,<br>
&gt;=C2=A0 =C2=A0 =C2=A0length,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VM_FLAGS_FIXE=
D | VM_FLAGS_OVERWRITE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(r =3D=
=3D KERN_SUCCESS);error_setg<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0An extra error_setg<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.readMemory =3D ^bool(uint=
64_t physical_address, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0length,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void * _Nonnull dst=
) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_read_m=
emory(s, physical_address, length, dst);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static PGDisplayDescriptor<br>
&gt;=C2=A0 =C2=A0 =C2=A0*apple_gfx_prepare_display_descriptor(AppleGFXState=
 *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc=
 =3D [PGDisplayDescriptor new];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + <a href=3D"http://disp_desc.name" rel=3D"no=
referrer" target=3D"_blank">disp_desc.name</a> &lt;<a href=3D"http://disp_d=
esc.name" rel=3D"noreferrer" target=3D"_blank">http://disp_desc.name</a>&gt=
; =3D @&quot;QEMU display&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.sizeInMillimeters =
=3D NSMakeSize(400., 300.); /* A<br>
&gt;=C2=A0 =C2=A0 =C2=A020&quot; display */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.queue =3D dispatch_g=
et_main_queue();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.newFrameEventHandler=
 =3D ^(void) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
new_frame();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(s=
-&gt;render_queue, ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Drop frames if we get too far ahead. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bq=
l_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (s-&gt;pending_frames &gt;=3D 2) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 bql_unlock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++=
s-&gt;pending_frames;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (s-&gt;pending_frames &gt; 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 bql_unlock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @a=
utoreleasepool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 apple_gfx_render_new_frame_bql_unlock(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.modeChangeHandler =
=3D ^(PGDisplayCoord_t sizeInPixels,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OSType pixelFormat) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
mode_change(sizeInPixels.x, sizeInPixels.y);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 BQL_LOCK_GUARD()=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_mode(s, size=
InPixels.x, sizeInPixels.y);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.cursorGlyphHandler =
=3D ^(NSBitmapImageRep *glyph,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PGDisplayCoord_t hotSpot) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [glyph retain];<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(g=
et_background_queue(), ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BQ=
L_LOCK_GUARD();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ui=
nt32_t bpp =3D glyph.bitsPerPixel;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 si=
ze_t width =3D glyph.pixelsWide;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 si=
ze_t height =3D glyph.pixelsHigh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 si=
ze_t padding_bytes_per_row =3D glyph.bytesPerRow -<br>
&gt;=C2=A0 =C2=A0 =C2=A0width * 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 co=
nst uint8_t* px_data =3D glyph.bitmapData;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tr=
ace_apple_gfx_cursor_set(bpp, width, height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (s-&gt;cursor) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 cursor_unref(s-&gt;cursor);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s-&gt;cursor =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (bpp =3D=3D 32) { /* Shouldn&#39;t be anything else, but<br>
&gt;=C2=A0 =C2=A0 =C2=A0just to be safe...*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s-&gt;cursor =3D cursor_alloc(width, height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_x =3D hotSpot.x;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_y =3D hotSpot.y;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint32_t *dest_px =3D s-&gt;cursor-&gt;data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 for (size_t y =3D 0; y &lt; height; ++y) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t x =3D 0; x &lt; width; ++x) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* NSBitmapImageRep&#39;s red &am=
p; blue<br>
&gt;=C2=A0 =C2=A0 =C2=A0channels are swapped<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* compared to QEMUCursor&#3=
9;s. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *dest_px =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[0] &lt;&lt=
; 16u) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[1] &lt;&lt=
;=C2=A0 8u) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[2] &lt;&lt=
;=C2=A0 0u) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[3] &lt;&lt=
; 24u);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++dest_px;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D padding_bytes_per_row;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dpy_cursor_define(s-&gt;con, s-&gt;cursor);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 update_cursor(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [g=
lyph release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.cursorShowHandler =
=3D ^(BOOL show) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(g=
et_background_queue(), ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BQ=
L_LOCK_GUARD();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tr=
ace_apple_gfx_cursor_show(show);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;cursor_show =3D show;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up=
date_cursor(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.cursorMoveHandler =
=3D ^(void) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(g=
et_background_queue(), ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BQ=
L_LOCK_GUARD();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tr=
ace_apple_gfx_cursor_move();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up=
date_cursor(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return disp_desc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static NSArray&lt;PGDisplayMode*&gt;*<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_prepare_display_mode_array(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGDisplayMode *modes[ARRAY_SIZ=
E(apple_gfx_modes)];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 NSArray&lt;PGDisplayMode*&gt;*=
 mode_array =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZ=
E(apple_gfx_modes); i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[=
PGDisplayMode alloc]<br>
&gt;=C2=A0 =C2=A0 =C2=A0initWithSizeInPixels:apple_gfx_modes[i] refreshRate=
InHz:60.];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mode_array =3D [NSArray arrayW=
ithObjects:modes<br>
&gt;=C2=A0 =C2=A0 =C2=A0count:ARRAY_SIZE(apple_gfx_modes)];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZ=
E(apple_gfx_modes); i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [modes[i] releas=
e];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D nil=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return mode_array;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static id&lt;MTLDevice&gt; copy_suitable_met=
al_device(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 id&lt;MTLDevice&gt; dev =3D ni=
l;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 NSArray&lt;id&lt;MTLDevice&gt;=
&gt; *devs =3D MTLCopyAllDevices();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Prefer a unified memory GPU=
. Failing that, pick a non-<br>
&gt;=C2=A0 =C2=A0 =C2=A0removable GPU. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; de=
vs.count; ++i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (devs[i].hasU=
nifiedMemory) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 de=
v =3D devs[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!devs[i].rem=
ovable) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 de=
v =3D devs[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (dev !=3D nil) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [dev retain];<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D MTLCreat=
eSystemDefaultDevice();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [devs release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_common_realize(AppleGFXState =
*s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor *desc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc=
 =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (apple_gfx_mig_blocker =3D=
=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;=
apple_gfx_mig_blocker,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;Migration state blocked by apple-gfx display<br>
&gt;=C2=A0 =C2=A0 =C2=A0device&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migrate_add_=
blocker(&amp;apple_gfx_mig_blocker, errp) &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QTAILQ_INIT(&amp;s-&gt;tasks);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;render_queue =3D dispatc=
h_queue_create(&quot;apple-gfx.render&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DISPATCH_QUEUE_SERIAL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;mtl =3D copy_suitable_me=
tal_device();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;mtl_queue =3D [s-&gt;mtl=
 newCommandQueue];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.device =3D s-&gt;mtl;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 apple_gfx_register_task_mappin=
g_handlers(s, desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;pgdev =3D PGNewDeviceWit=
hDescriptor(desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc =3D apple_gfx_prepar=
e_display_descriptor(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;pgdisp =3D [s-&gt;pgdev =
newDisplayWithDescriptor:disp_desc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port:0<br>
&gt;=C2=A0 =C2=A0 =C2=A0serialNum:1234];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [disp_desc release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;pgdisp.modeList =3D appl=
e_gfx_prepare_display_mode_array();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_fb(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_mutex_init(&amp;s-&gt;job=
_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_cond_init(&amp;s-&gt;job_=
cond);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/display/meson.build b/hw/disp=
lay/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 20a94973fa2..619e642905a 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/display/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -61,6 +61,10 @@ system_ss.add(when: &#39;C=
ONFIG_ARTIST&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;artist.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_A=
TI_VGA&#39;, if_true: [files(&#39;ati.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;ati_2d.c&#39;, &#39;ati_dbg.c&#39;), pixman])<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +system_ss.add(when: &#39;CONFIG_MAC_PVG&#39;=
,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[files(&#39;apple-gfx.m&#39;), pvg, metal])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +if cpu =3D=3D &#39;aarch64&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 system_ss.add(when: &#39;CONFIG_MAC_P=
VG_MMIO&#39;,=C2=A0 if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[files(&#39;apple-gfx-mmio.m&#39;), pvg, metal])<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0if config_all_devices.has_key(&#3=
9;CONFIG_VIRTIO_GPU&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0virtio_gpu_ss =3D ss.sourc=
e_set()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/display/trace-events b/hw/dis=
play/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 781f8a33203..214998312b9 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/display/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned =
dest_width)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;dest_width : %u&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0dm163_leds(int led, uint32_t valu=
e) &quot;led %d: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0dm163_channels(int channel, uint8=
_t value) &quot;channel %d: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0dm163_refresh_rate(uint32_t rr) &=
quot;refresh rate %d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# apple-gfx.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_read(uint64_t offset, uint64_t res=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PRIx64&quot; res=3D0x%&quot=
;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_write(uint64_t offset, uint64_t va=
l)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PRIx64&quot; val=3D0x%&quot=
;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_create_task(uint32_t vm_size, void=
 *va) &quot;vm_size=3D0x%x<br>
&gt;=C2=A0 =C2=A0 =C2=A0base_addr=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_destroy_task(void *task) &quot;tas=
k=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_map_memory(void *task, uint32_t ra=
nge_count, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtual_offset, uint32_t read_only) &quot;task=3D%p=
 range_count=3D0x%x<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtual_offset=3D0x%&quot;PRIx64&quot; read_only=3D=
%d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_map_memory_range(uint32_t i, uint6=
4_t phys_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t phys_len) &quot;[%d] phys_addr=3D0x%&quot;=
PRIx64&quot; phys_len=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_remap(uint64_t retval, uint64_t so=
urce, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0target) &quot;retval=3D%&quot;PRId64&quot; source=
=3D0x%&quot;PRIx64&quot; target=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_unmap_memory(void *task, uint64_t =
virtual_offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t length) &quot;task=3D%p virtual_offset=3D0=
x%&quot;PRIx64&quot; length=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_read_memory(uint64_t phys_address,=
 uint64_t length,<br>
&gt;=C2=A0 =C2=A0 =C2=A0void *dst) &quot;phys_addr=3D0x%&quot;PRIx64&quot; =
length=3D0x%&quot;PRIx64&quot; dest=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_raise_irq(uint32_t vector) &quot;v=
ector=3D0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_new_frame(void) &quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_mode_change(uint64_t x, uint64_t y=
) &quot;x=3D%&quot;PRId64&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0y=3D%&quot;PRId64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_cursor_set(uint32_t bpp, uint64_t =
width, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0height) &quot;bpp=3D%d width=3D%&quot;PRId64&quot; =
height=3D0x%&quot;PRId64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_cursor_show(uint32_t show) &quot;s=
how=3D%d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_cursor_move(void) &quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_common_init(const char *device_nam=
e, size_t mmio_size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;device: %s; MMIO size: %zu bytes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# apple-gfx-mmio.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_mmio_iosfc_read(uint64_t offset, u=
int64_t res)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PRIx64&quot; res=3D0x%&quot=
;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_mmio_iosfc_write(uint64_t offset, =
uint64_t val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PRIx64&quot; val=3D0x%&quot=
;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_iosfc_map_memory(uint64_t phys, ui=
nt64_t len, uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0ro, void *va, void *e, void *f, void* va_result, in=
t success)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;phys=3D0x%&quot;PRIx64&quot; len=3D0x%&quot;P=
RIx64&quot; ro=3D%d va=3D%p e=3D%p f=3D%p -&gt; *va=3D%p,<br>
&gt;=C2=A0 =C2=A0 =C2=A0success =3D %d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_iosfc_unmap_memory(void *a, void *=
b, void *c, void *d,<br>
&gt;=C2=A0 =C2=A0 =C2=A0void *e, void *f) &quot;a=3D%p b=3D%p c=3D%p d=3D%p=
 e=3D%p f=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_iosfc_raise_irq(uint32_t vector) &=
quot;vector=3D0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/meson.build b/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index d26690ce204..0e124eff13f 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -761,6 +761,8 @@ socket =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0version_res =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0coref =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0iokit =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +pvg =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +metal =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0emulator_link_args =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0midl =3D not_found<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0widl =3D not_found<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -782,6 +784,8 @@ elif host_os =3D=3D &#39;=
darwin&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0coref =3D dependency(&#39;=
appleframeworks&#39;, modules: &#39;CoreFoundation&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0iokit =3D dependency(&#39;=
appleframeworks&#39;, modules: &#39;IOKit&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0required: false)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0host_dsosuf =3D &#39;.dyli=
b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 pvg =3D dependency(&#39;appleframewor=
ks&#39;, modules:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;ParavirtualizedGraphics&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 metal =3D dependency(&#39;appleframew=
orks&#39;, modules: &#39;Metal&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0elif host_os =3D=3D &#39;sunos&#3=
9;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0socket =3D [cc.find_librar=
y(&#39;socket&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cc.find_library(&#39;nsl&#39;),<br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000007f7f406255ea3d0--

