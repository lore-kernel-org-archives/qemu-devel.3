Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243D4D116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 13:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOyKI-0004Yl-Mo; Fri, 28 Nov 2025 08:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vOyKC-0004YM-Qu
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vOyK6-0007lf-JG
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764335740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKX9pqpnhwe5xj4Wth0fmm7Sn93H/GiwnJJ9R9N4W+0=;
 b=HGHG3wJRissKnVfzvXifuyE2O3KiKTEoYR8EYphc3RShROq6Iu8YH2WyDqJVV1C4sD4Z7H
 8MhBT0Q1exI3mxHjF613cSVvsrpqTJft3dem4C+dsrYUX8f7B+5fWR/3Hkf5dDdTJozrOa
 vP53f06tcHz54jL69PiQG2nmg30dj0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-ZAWwZn4_OnaxX8aQoWMmDQ-1; Fri, 28 Nov 2025 08:14:30 -0500
X-MC-Unique: ZAWwZn4_OnaxX8aQoWMmDQ-1
X-Mimecast-MFC-AGG-ID: ZAWwZn4_OnaxX8aQoWMmDQ_1764335669
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so12472285e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 05:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764335669; x=1764940469; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yKX9pqpnhwe5xj4Wth0fmm7Sn93H/GiwnJJ9R9N4W+0=;
 b=tvVtgG6j7UHU59+Lt1LHvVJZiGBtJy8aNnTpmq4lWB+P0IGV+UK1JI7D/rdJplIONl
 w4u/XrxpMuBNKpE83RzLzcB8Q0q/IL/xynLWAzSVysfXGP1CY4SfOIB4uA/R4AkBjaO1
 aPqTyJmGyIdLbWVsMviWIGliNx6/GtaDXYd06yXXfgZbfWp1MEO9RhFOGJztRQFpu3fK
 xqnq3onliLPzA8FlW0I+myYAU+6IHX8m4M7Q916bh0iQqG1FeuTNC6u/nDRsVaiVL7l9
 jvdQLCmGzj1zjtyeoapkCtTB4MDe7OHeNYeBtVBjByda2EexFzNMl0ZyG3a6DDH0fmnb
 xJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764335669; x=1764940469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKX9pqpnhwe5xj4Wth0fmm7Sn93H/GiwnJJ9R9N4W+0=;
 b=T/H/bg86iIo9Kh2B52rGt6z+JYS8dnmfpYr0CHJrYNp3eEGcfOCJBIvlsY56cWB7jm
 S0CNiVT7ZigYEP5Dhk2AJXXH1mW5WiYMx+w16mzdvUGlF3XsalhsMrj6k1pnfv3Iaq1E
 P4YREkknx2JK0jMkYenHba+9bQdzNg0wF1xKIfnJrbqVFmB6n1sG9tEPJC/CwQnImcgK
 byJGCKAvXeosZJLXrZcupqzgDpaYJiNDFObrhV21Rpj3HoaYMxX47D6E/REnF138FVg3
 WFRi5CLsFisPQJ8VeP55LDFxo5ups6+BlTSH7NrIqxVHk3JoRbp1BGLm5d3m38Uw6jQX
 6XTQ==
X-Gm-Message-State: AOJu0YyN1A121sn1n0+HpqNWzsuvN4x9n6lm5mwALgqRIAaeXuuJhO5H
 vwUIpxg1NfPXmgKublkh6iTq/JsSepbHl8UKPcR5fud+BM4GZlNhctzgWeD3X0j1DHy8kf0eHP8
 Zpg/YEDtQM3RarnPMk2YBsWZ7VPCO1MYHhof+NvQHcr8K7840qTsPKfWVCKvDFp/lV2tUuyW2Hd
 15B6718Eqyup40gidW1E5j3Xfvi3saC0by7TvcZ031ZA==
X-Gm-Gg: ASbGncumQiQaI+nGTIdbqJdKhSs5nzFtJSFZcE3cJ/9UJ9JP7OcPhe+48P5BZOHi0iL
 yLYjxGvunudgcMpgb9NhAp7zOuLuCEg+ocifPy7vUreaUqjIbujpUoXbacL8jut7OLRxU2zPr7G
 JSJbhlF+HQYwmob/PEimQHFkISlYx/JccXJtTkKKo58jzR8wMN4omyDj84Wnfbn4cBrheO
X-Received: by 2002:a05:600c:4fcc:b0:471:9da:5252 with SMTP id
 5b1f17b1804b1-477c01ebe2amr262406615e9.29.1764335667649; 
 Fri, 28 Nov 2025 05:14:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQwl22xqCkumHo6Spoq7oHdaf8vYMSiP8kb81gEVZ0Ykq9+xHE+ns8Y5TC45sSPUpYCL0vEBBR+kchGUC62D8=
X-Received: by 2002:a05:600c:4fcc:b0:471:9da:5252 with SMTP id
 5b1f17b1804b1-477c01ebe2amr262405855e9.29.1764335666472; Fri, 28 Nov 2025
 05:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20251128101555.227630-1-pbonzini@redhat.com>
In-Reply-To: <20251128101555.227630-1-pbonzini@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 28 Nov 2025 18:44:08 +0530
X-Gm-Features: AWmQ_bmuGy0m5UtHEACEy8_4VzYJOx0p_2E3Pkj-H8WgkUQfF2ozEXAVzx0zpWs
Message-ID: <CAE8KmOwfKfTpE8YOwd6GV0vAetf+rfLW648ALvNWdC0ciL9k8w@mail.gmail.com>
Subject: Re: [PATCH] block: split qemu/aio.h out of block/aio.h
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 28 Nov 2025 at 15:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Rust bindings are roughly broken up according to subdirectories of
> include/ (that's not exact, but it's roughly an aim).  However,
> block/aio.h contains both block layer-specific concepts (BlockAIOCB,
> BlockCompletionFunc) and AioContext-related declarations that are
> used be qemu/main-loop.h.
>
> Break out the latter into their own header file, and use that to
> break the inclusion of block/ from qemu/main-loop.h.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         Based on top of
>         https://lore.kernel.org/qemu-devel/20251127131516.80807-3-pbonzini@redhat.com/
>
>  include/block/aio.h      | 838 +-------------------------------------
>  include/qemu/aio.h       | 852 +++++++++++++++++++++++++++++++++++++++
>  include/qemu/main-loop.h |   4 +-
>  3 files changed, 857 insertions(+), 837 deletions(-)
>  create mode 100644 include/qemu/aio.h
>
> diff --git a/include/block/aio.h b/include/block/aio.h
> index cc3d5f25a24..dba423f896e 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -11,22 +11,13 @@
>   *
>   */
>
> -#ifndef QEMU_AIO_H
> -#define QEMU_AIO_H
> +#ifndef QEMU_BLOCK_AIO_H
> +#define QEMU_BLOCK_AIO_H
>
> -#ifdef CONFIG_LINUX_IO_URING
> -#include <liburing.h>
> -#endif
> -#include "qemu/coroutine-core.h"
> -#include "qemu/queue.h"
> -#include "qemu/event_notifier.h"
> -#include "qemu/lockcnt.h"
> -#include "qemu/thread.h"
> -#include "qemu/timer.h"
> +#include "qemu/aio.h"
>  #include "block/graph-lock.h"
>  #include "hw/core/qdev.h"
>
> -
>  typedef struct BlockAIOCB BlockAIOCB;
>  typedef void BlockCompletionFunc(void *opaque, int ret);
>
> @@ -48,827 +39,4 @@ void *qemu_aio_get(const AIOCBInfo *aiocb_info, BlockDriverState *bs,
>  void qemu_aio_unref(void *p);
>  void qemu_aio_ref(void *p);
>
> -typedef struct AioHandler AioHandler;
> -typedef QLIST_HEAD(, AioHandler) AioHandlerList;
> -typedef void QEMUBHFunc(void *opaque);
> -typedef bool AioPollFn(void *opaque);
> -typedef void IOHandler(void *opaque);
> -
> -struct ThreadPoolAio;
> -struct LinuxAioState;
> -typedef struct LuringState LuringState;
> -
> -/* Is polling disabled? */
> -bool aio_poll_disabled(AioContext *ctx);
> -
> -#ifdef CONFIG_LINUX_IO_URING
> -/*
> - * Each io_uring request must have a unique CqeHandler that processes the cqe.
> - * The lifetime of a CqeHandler must be at least from aio_add_sqe() until
> - * ->cb() invocation.
> - */
> -typedef struct CqeHandler CqeHandler;
> -struct CqeHandler {
> -    /* Called by the AioContext when the request has completed */
> -    void (*cb)(CqeHandler *handler);
> -
> -    /* Used internally, do not access this */
> -    QSIMPLEQ_ENTRY(CqeHandler) next;
> -
> -    /* This field is filled in before ->cb() is called */
> -    struct io_uring_cqe cqe;
> -};
> -
> -typedef QSIMPLEQ_HEAD(, CqeHandler) CqeHandlerSimpleQ;
> -#endif /* CONFIG_LINUX_IO_URING */
> -
> -/* Callbacks for file descriptor monitoring implementations */
> -typedef struct {
> -    /*
> -     * update:
> -     * @ctx: the AioContext
> -     * @old_node: the existing handler or NULL if this file descriptor is being
> -     *            monitored for the first time
> -     * @new_node: the new handler or NULL if this file descriptor is being
> -     *            removed
> -     *
> -     * Add/remove/modify a monitored file descriptor.
> -     *
> -     * Called with ctx->list_lock acquired.
> -     */
> -    void (*update)(AioContext *ctx, AioHandler *old_node, AioHandler *new_node);
> -
> -    /*
> -     * wait:
> -     * @ctx: the AioContext
> -     * @ready_list: list for handlers that become ready
> -     * @timeout: maximum duration to wait, in nanoseconds
> -     *
> -     * Wait for file descriptors to become ready and place them on ready_list.
> -     *
> -     * Called with ctx->list_lock incremented but not locked.
> -     *
> -     * Returns: number of ready file descriptors.
> -     */
> -    int (*wait)(AioContext *ctx, AioHandlerList *ready_list, int64_t timeout);
> -
> -    /*
> -     * need_wait:
> -     * @ctx: the AioContext
> -     *
> -     * Tell aio_poll() when to stop userspace polling early because ->wait()
> -     * has fds ready.
> -     *
> -     * File descriptor monitoring implementations that cannot poll fd readiness
> -     * from userspace should use aio_poll_disabled() here.  This ensures that
> -     * file descriptors are not starved by handlers that frequently make
> -     * progress via userspace polling.
> -     *
> -     * Returns: true if ->wait() should be called, false otherwise.
> -     */
> -    bool (*need_wait)(AioContext *ctx);
> -
> -    /*
> -     * dispatch:
> -     * @ctx: the AioContext
> -     *
> -     * Dispatch any work that is specific to this file descriptor monitoring
> -     * implementation. Usually the event loop's generic file descriptor
> -     * monitoring, BH, and timer dispatching code is sufficient, but file
> -     * descriptor monitoring implementations offering additional functionality
> -     * may need to implement this function for custom behavior. Called at a
> -     * point in the event loop when it is safe to invoke user-defined
> -     * callbacks.
> -     *
> -     * This function is optional and may be NULL.
> -     *
> -     * Returns: true if progress was made (see aio_poll()'s return value),
> -     * false otherwise.
> -     */
> -    bool (*dispatch)(AioContext *ctx);
> -
> -    /*
> -     * gsource_prepare:
> -     * @ctx: the AioContext
> -     *
> -     * Prepare for the glib event loop to wait for events instead of the usual
> -     * ->wait() call. See glib's GSourceFuncs->prepare().
> -     */
> -    void (*gsource_prepare)(AioContext *ctx);
> -
> -    /*
> -     * gsource_check:
> -     * @ctx: the AioContext
> -     *
> -     * Called by the glib event loop from glib's GSourceFuncs->check() after
> -     * waiting for events.
> -     *
> -     * Returns: true when ready to be dispatched.
> -     */
> -    bool (*gsource_check)(AioContext *ctx);
> -
> -    /*
> -     * gsource_dispatch:
> -     * @ctx: the AioContext
> -     * @ready_list: list for handlers that become ready
> -     *
> -     * Place ready AioHandlers on ready_list. Called as part of the glib event
> -     * loop from glib's GSourceFuncs->dispatch().
> -     *
> -     * Called with list_lock incremented.
> -     */
> -    void (*gsource_dispatch)(AioContext *ctx, AioHandlerList *ready_list);
> -
> -#ifdef CONFIG_LINUX_IO_URING
> -    /**
> -     * add_sqe: Add an io_uring sqe for submission.
> -     * @prep_sqe: invoked with an sqe that should be prepared for submission
> -     * @opaque: user-defined argument to @prep_sqe()
> -     * @cqe_handler: the unique cqe handler associated with this request
> -     *
> -     * The caller's @prep_sqe() function is invoked to fill in the details of
> -     * the sqe. Do not call io_uring_sqe_set_data() on this sqe.
> -     *
> -     * The kernel may see the sqe as soon as @prep_sqe() returns or it may take
> -     * until the next event loop iteration.
> -     *
> -     * This function is called from the current AioContext and is not
> -     * thread-safe.
> -     */
> -    void (*add_sqe)(AioContext *ctx,
> -                    void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
> -                    void *opaque, CqeHandler *cqe_handler);
> -#endif /* CONFIG_LINUX_IO_URING */
> -} FDMonOps;
> -
> -/*
> - * Each aio_bh_poll() call carves off a slice of the BH list, so that newly
> - * scheduled BHs are not processed until the next aio_bh_poll() call.  All
> - * active aio_bh_poll() calls chain their slices together in a list, so that
> - * nested aio_bh_poll() calls process all scheduled bottom halves.
> - */
> -typedef QSLIST_HEAD(, QEMUBH) BHList;
> -typedef struct BHListSlice BHListSlice;
> -struct BHListSlice {
> -    BHList bh_list;
> -    QSIMPLEQ_ENTRY(BHListSlice) next;
> -};
> -
> -typedef QSLIST_HEAD(, AioHandler) AioHandlerSList;
> -
> -typedef struct AioPolledEvent {
> -    int64_t ns;        /* current polling time in nanoseconds */
> -} AioPolledEvent;
> -
> -struct AioContext {
> -    GSource source;
> -
> -    /* Used by AioContext users to protect from multi-threaded access.  */
> -    QemuRecMutex lock;
> -
> -    /*
> -     * Keep track of readers and writers of the block layer graph.
> -     * This is essential to avoid performing additions and removal
> -     * of nodes and edges from block graph while some
> -     * other thread is traversing it.
> -     */
> -    BdrvGraphRWlock *bdrv_graph;
> -
> -    /* The list of registered AIO handlers.  Protected by ctx->list_lock. */
> -    AioHandlerList aio_handlers;
> -
> -    /* The list of AIO handlers to be deleted.  Protected by ctx->list_lock. */
> -    AioHandlerList deleted_aio_handlers;
> -
> -    /* Used to avoid unnecessary event_notifier_set calls in aio_notify;
> -     * only written from the AioContext home thread, or under the BQL in
> -     * the case of the main AioContext.  However, it is read from any
> -     * thread so it is still accessed with atomic primitives.
> -     *
> -     * If this field is 0, everything (file descriptors, bottom halves,
> -     * timers) will be re-evaluated before the next blocking poll() or
> -     * io_uring wait; therefore, the event_notifier_set call can be
> -     * skipped.  If it is non-zero, you may need to wake up a concurrent
> -     * aio_poll or the glib main event loop, making event_notifier_set
> -     * necessary.
> -     *
> -     * Bit 0 is reserved for GSource usage of the AioContext, and is 1
> -     * between a call to aio_ctx_prepare and the next call to aio_ctx_check.
> -     * Bits 1-31 simply count the number of active calls to aio_poll
> -     * that are in the prepare or poll phase.
> -     *
> -     * The GSource and aio_poll must use a different mechanism because
> -     * there is no certainty that a call to GSource's prepare callback
> -     * (via g_main_context_prepare) is indeed followed by check and
> -     * dispatch.  It's not clear whether this would be a bug, but let's
> -     * play safe and allow it---it will just cause extra calls to
> -     * event_notifier_set until the next call to dispatch.
> -     *
> -     * Instead, the aio_poll calls include both the prepare and the
> -     * dispatch phase, hence a simple counter is enough for them.
> -     */
> -    uint32_t notify_me;
> -
> -    /* A lock to protect between QEMUBH and AioHandler adders and deleter,
> -     * and to ensure that no callbacks are removed while we're walking and
> -     * dispatching them.
> -     */
> -    QemuLockCnt list_lock;
> -
> -    /* Bottom Halves pending aio_bh_poll() processing */
> -    BHList bh_list;
> -
> -    /* Chained BH list slices for each nested aio_bh_poll() call */
> -    QSIMPLEQ_HEAD(, BHListSlice) bh_slice_list;
> -
> -    /* Used by aio_notify.
> -     *
> -     * "notified" is used to avoid expensive event_notifier_test_and_clear
> -     * calls.  When it is clear, the EventNotifier is clear, or one thread
> -     * is going to clear "notified" before processing more events.  False
> -     * positives are possible, i.e. "notified" could be set even though the
> -     * EventNotifier is clear.
> -     *
> -     * Note that event_notifier_set *cannot* be optimized the same way.  For
> -     * more information on the problem that would result, see "#ifdef BUG2"
> -     * in the docs/aio_notify_accept.promela formal model.
> -     */
> -    bool notified;
> -    EventNotifier notifier;
> -
> -    QSLIST_HEAD(, Coroutine) scheduled_coroutines;
> -    QEMUBH *co_schedule_bh;
> -
> -    int thread_pool_min;
> -    int thread_pool_max;
> -    /* Thread pool for performing work and receiving completion callbacks.
> -     * Has its own locking.
> -     */
> -    struct ThreadPoolAio *thread_pool;
> -
> -#ifdef CONFIG_LINUX_AIO
> -    struct LinuxAioState *linux_aio;
> -#endif
> -#ifdef CONFIG_LINUX_IO_URING
> -    /* State for file descriptor monitoring using Linux io_uring */
> -    struct io_uring fdmon_io_uring;
> -    AioHandlerSList submit_list;
> -    void *io_uring_fd_tag;
> -
> -    /* Pending callback state for cqe handlers */
> -    CqeHandlerSimpleQ cqe_handler_ready_list;
> -#endif /* CONFIG_LINUX_IO_URING */
> -
> -    /* TimerLists for calling timers - one per clock type.  Has its own
> -     * locking.
> -     */
> -    QEMUTimerListGroup tlg;
> -
> -    /* Number of AioHandlers without .io_poll() */
> -    int poll_disable_cnt;
> -
> -    /* Polling mode parameters */
> -    int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
> -    int64_t poll_grow;      /* polling time growth factor */
> -    int64_t poll_shrink;    /* polling time shrink factor */
> -
> -    /* AIO engine parameters */
> -    int64_t aio_max_batch;  /* maximum number of requests in a batch */
> -
> -    /*
> -     * List of handlers participating in userspace polling.  Protected by
> -     * ctx->list_lock.  Iterated and modified mostly by the event loop thread
> -     * from aio_poll() with ctx->list_lock incremented.  aio_set_fd_handler()
> -     * only touches the list to delete nodes if ctx->list_lock's count is zero.
> -     */
> -    AioHandlerList poll_aio_handlers;
> -
> -    /* Are we in polling mode or monitoring file descriptors? */
> -    bool poll_started;
> -
> -    /* epoll(7) state used when built with CONFIG_EPOLL */
> -    int epollfd;
> -
> -    /* The GSource unix fd tag for epollfd */
> -    void *epollfd_tag;
> -
> -    const FDMonOps *fdmon_ops;
> -
> -    /* Was aio_context_new() successful? */
> -    bool initialized;
> -};
> -
> -/**
> - * aio_context_new: Allocate a new AioContext.
> - *
> - * AioContext provide a mini event-loop that can be waited on synchronously.
> - * They also provide bottom halves, a service to execute a piece of code
> - * as soon as possible.
> - */
> -AioContext *aio_context_new(Error **errp);
> -
> -/**
> - * aio_context_ref:
> - * @ctx: The AioContext to operate on.
> - *
> - * Add a reference to an AioContext.
> - */
> -void aio_context_ref(AioContext *ctx);
> -
> -/**
> - * aio_context_unref:
> - * @ctx: The AioContext to operate on.
> - *
> - * Drop a reference to an AioContext.
> - */
> -void aio_context_unref(AioContext *ctx);
> -
> -/**
> - * aio_bh_schedule_oneshot_full: Allocate a new bottom half structure that will
> - * run only once and as soon as possible.
> - *
> - * @name: A human-readable identifier for debugging purposes.
> - */
> -void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
> -                                  const char *name);
> -
> -/**
> - * aio_bh_schedule_oneshot: Allocate a new bottom half structure that will run
> - * only once and as soon as possible.
> - *
> - * A convenience wrapper for aio_bh_schedule_oneshot_full() that uses cb as the
> - * name string.
> - */
> -#define aio_bh_schedule_oneshot(ctx, cb, opaque) \
> -    aio_bh_schedule_oneshot_full((ctx), (cb), (opaque), (stringify(cb)))
> -
> -/**
> - * aio_bh_new_full: Allocate a new bottom half structure.
> - *
> - * Bottom halves are lightweight callbacks whose invocation is guaranteed
> - * to be wait-free, thread-safe and signal-safe.  The #QEMUBH structure
> - * is opaque and must be allocated prior to its use.
> - *
> - * @name: A human-readable identifier for debugging purposes.
> - * @reentrancy_guard: A guard set when entering a cb to prevent
> - * device-reentrancy issues
> - */
> -QEMUBH *aio_bh_new_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
> -                        const char *name, MemReentrancyGuard *reentrancy_guard);
> -
> -/**
> - * aio_bh_new: Allocate a new bottom half structure
> - *
> - * A convenience wrapper for aio_bh_new_full() that uses the cb as the name
> - * string.
> - */
> -#define aio_bh_new(ctx, cb, opaque) \
> -    aio_bh_new_full((ctx), (cb), (opaque), (stringify(cb)), NULL)
> -
> -/**
> - * aio_bh_new_guarded: Allocate a new bottom half structure with a
> - * reentrancy_guard
> - *
> - * A convenience wrapper for aio_bh_new_full() that uses the cb as the name
> - * string.
> - */
> -#define aio_bh_new_guarded(ctx, cb, opaque, guard) \
> -    aio_bh_new_full((ctx), (cb), (opaque), (stringify(cb)), guard)
> -
> -/**
> - * aio_notify: Force processing of pending events.
> - *
> - * Similar to signaling a condition variable, aio_notify forces
> - * aio_poll to exit, so that the next call will re-examine pending events.
> - * The caller of aio_notify will usually call aio_poll again very soon,
> - * or go through another iteration of the GLib main loop.  Hence, aio_notify
> - * also has the side effect of recalculating the sets of file descriptors
> - * that the main loop waits for.
> - *
> - * Calling aio_notify is rarely necessary, because for example scheduling
> - * a bottom half calls it already.
> - */
> -void aio_notify(AioContext *ctx);
> -
> -/**
> - * aio_notify_accept: Acknowledge receiving an aio_notify.
> - *
> - * aio_notify() uses an EventNotifier in order to wake up a sleeping
> - * aio_poll() or g_main_context_iteration().  Calls to aio_notify() are
> - * usually rare, but the AioContext has to clear the EventNotifier on
> - * every aio_poll() or g_main_context_iteration() in order to avoid
> - * busy waiting.  This event_notifier_test_and_clear() cannot be done
> - * using the usual aio_context_set_event_notifier(), because it must
> - * be done before processing all events (file descriptors, bottom halves,
> - * timers).
> - *
> - * aio_notify_accept() is an optimized event_notifier_test_and_clear()
> - * that is specific to an AioContext's notifier; it is used internally
> - * to clear the EventNotifier only if aio_notify() had been called.
> - */
> -void aio_notify_accept(AioContext *ctx);
> -
> -/**
> - * aio_bh_call: Executes callback function of the specified BH.
> - */
> -void aio_bh_call(QEMUBH *bh);
> -
> -/**
> - * aio_bh_poll: Poll bottom halves for an AioContext.
> - *
> - * These are internal functions used by the QEMU main loop.
> - * And notice that multiple occurrences of aio_bh_poll cannot
> - * be called concurrently
> - */
> -int aio_bh_poll(AioContext *ctx);
> -
> -/**
> - * qemu_bh_schedule: Schedule a bottom half.
> - *
> - * Scheduling a bottom half interrupts the main loop and causes the
> - * execution of the callback that was passed to qemu_bh_new.
> - *
> - * Bottom halves that are scheduled from a bottom half handler are instantly
> - * invoked.  This can create an infinite loop if a bottom half handler
> - * schedules itself.
> - *
> - * @bh: The bottom half to be scheduled.
> - */
> -void qemu_bh_schedule(QEMUBH *bh);
> -
> -/**
> - * qemu_bh_cancel: Cancel execution of a bottom half.
> - *
> - * Canceling execution of a bottom half undoes the effect of calls to
> - * qemu_bh_schedule without freeing its resources yet.  While cancellation
> - * itself is also wait-free and thread-safe, it can of course race with the
> - * loop that executes bottom halves unless you are holding the iothread
> - * mutex.  This makes it mostly useless if you are not holding the mutex.
> - *
> - * @bh: The bottom half to be canceled.
> - */
> -void qemu_bh_cancel(QEMUBH *bh);
> -
> -/**
> - *qemu_bh_delete: Cancel execution of a bottom half and free its resources.
> - *
> - * Deleting a bottom half frees the memory that was allocated for it by
> - * qemu_bh_new.  It also implies canceling the bottom half if it was
> - * scheduled.
> - * This func is async. The bottom half will do the delete action at the finial
> - * end.
> - *
> - * @bh: The bottom half to be deleted.
> - */
> -void qemu_bh_delete(QEMUBH *bh);
> -
> -/* Return whether there are any pending callbacks from the GSource
> - * attached to the AioContext, before g_poll is invoked.
> - *
> - * This is used internally in the implementation of the GSource.
> - */
> -bool aio_prepare(AioContext *ctx);
> -
> -/* Return whether there are any pending callbacks from the GSource
> - * attached to the AioContext, after g_poll is invoked.
> - *
> - * This is used internally in the implementation of the GSource.
> - */
> -bool aio_pending(AioContext *ctx);
> -
> -/* Dispatch any pending callbacks from the GSource attached to the AioContext.
> - *
> - * This is used internally in the implementation of the GSource.
> - */
> -void aio_dispatch(AioContext *ctx);
> -
> -/* Progress in completing AIO work to occur.  This can issue new pending
> - * aio as a result of executing I/O completion or bh callbacks.
> - *
> - * Return whether any progress was made by executing AIO or bottom half
> - * handlers.  If @blocking == true, this should always be true except
> - * if someone called aio_notify.
> - *
> - * If there are no pending bottom halves, but there are pending AIO
> - * operations, it may not be possible to make any progress without
> - * blocking.  If @blocking is true, this function will wait until one
> - * or more AIO events have completed, to ensure something has moved
> - * before returning.
> - */
> -bool no_coroutine_fn aio_poll(AioContext *ctx, bool blocking);
> -
> -/* Register a file descriptor and associated callbacks.  Behaves very similarly
> - * to qemu_set_fd_handler.  Unlike qemu_set_fd_handler, these callbacks will
> - * be invoked when using aio_poll().
> - *
> - * Code that invokes AIO completion functions should rely on this function
> - * instead of qemu_set_fd_handler[2].
> - */
> -void aio_set_fd_handler(AioContext *ctx,
> -                        int fd,
> -                        IOHandler *io_read,
> -                        IOHandler *io_write,
> -                        AioPollFn *io_poll,
> -                        IOHandler *io_poll_ready,
> -                        void *opaque);
> -
> -/* Register an event notifier and associated callbacks.  Behaves very similarly
> - * to event_notifier_set_handler.  Unlike event_notifier_set_handler, these callbacks
> - * will be invoked when using aio_poll().
> - *
> - * Code that invokes AIO completion functions should rely on this function
> - * instead of event_notifier_set_handler.
> - */
> -void aio_set_event_notifier(AioContext *ctx,
> -                            EventNotifier *notifier,
> -                            EventNotifierHandler *io_read,
> -                            AioPollFn *io_poll,
> -                            EventNotifierHandler *io_poll_ready);
> -
> -/*
> - * Set polling begin/end callbacks for an event notifier that has already been
> - * registered with aio_set_event_notifier.  Do nothing if the event notifier is
> - * not registered.
> - *
> - * Note that if the io_poll_end() callback (or the entire notifier) is removed
> - * during polling, it will not be called, so an io_poll_begin() is not
> - * necessarily always followed by an io_poll_end().
> - */
> -void aio_set_event_notifier_poll(AioContext *ctx,
> -                                 EventNotifier *notifier,
> -                                 EventNotifierHandler *io_poll_begin,
> -                                 EventNotifierHandler *io_poll_end);
> -
> -/* Return a GSource that lets the main loop poll the file descriptors attached
> - * to this AioContext.
> - */
> -GSource *aio_get_g_source(AioContext *ctx);
> -
> -/* Return the ThreadPoolAio bound to this AioContext */
> -struct ThreadPoolAio *aio_get_thread_pool(AioContext *ctx);
> -
> -/* Setup the LinuxAioState bound to this AioContext */
> -struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
> -
> -/* Return the LinuxAioState bound to this AioContext */
> -struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
> -
> -/**
> - * aio_timer_new_with_attrs:
> - * @ctx: the aio context
> - * @type: the clock type
> - * @scale: the scale
> - * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR_<id> values
> - *              to assign
> - * @cb: the callback to call on timer expiry
> - * @opaque: the opaque pointer to pass to the callback
> - *
> - * Allocate a new timer (with attributes) attached to the context @ctx.
> - * The function is responsible for memory allocation.
> - *
> - * The preferred interface is aio_timer_init or aio_timer_init_with_attrs.
> - * Use that unless you really need dynamic memory allocation.
> - *
> - * Returns: a pointer to the new timer
> - */
> -static inline QEMUTimer *aio_timer_new_with_attrs(AioContext *ctx,
> -                                                  QEMUClockType type,
> -                                                  int scale, int attributes,
> -                                                  QEMUTimerCB *cb, void *opaque)
> -{
> -    return timer_new_full(&ctx->tlg, type, scale, attributes, cb, opaque);
> -}
> -
> -/**
> - * aio_timer_new:
> - * @ctx: the aio context
> - * @type: the clock type
> - * @scale: the scale
> - * @cb: the callback to call on timer expiry
> - * @opaque: the opaque pointer to pass to the callback
> - *
> - * Allocate a new timer attached to the context @ctx.
> - * See aio_timer_new_with_attrs for details.
> - *
> - * Returns: a pointer to the new timer
> - */
> -static inline QEMUTimer *aio_timer_new(AioContext *ctx, QEMUClockType type,
> -                                       int scale,
> -                                       QEMUTimerCB *cb, void *opaque)
> -{
> -    return timer_new_full(&ctx->tlg, type, scale, 0, cb, opaque);
> -}
> -
> -/**
> - * aio_timer_init_with_attrs:
> - * @ctx: the aio context
> - * @ts: the timer
> - * @type: the clock type
> - * @scale: the scale
> - * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR_<id> values
> - *              to assign
> - * @cb: the callback to call on timer expiry
> - * @opaque: the opaque pointer to pass to the callback
> - *
> - * Initialise a new timer (with attributes) attached to the context @ctx.
> - * The caller is responsible for memory allocation.
> - */
> -static inline void aio_timer_init_with_attrs(AioContext *ctx,
> -                                             QEMUTimer *ts, QEMUClockType type,
> -                                             int scale, int attributes,
> -                                             QEMUTimerCB *cb, void *opaque)
> -{
> -    timer_init_full(ts, &ctx->tlg, type, scale, attributes, cb, opaque);
> -}
> -
> -/**
> - * aio_timer_init:
> - * @ctx: the aio context
> - * @ts: the timer
> - * @type: the clock type
> - * @scale: the scale
> - * @cb: the callback to call on timer expiry
> - * @opaque: the opaque pointer to pass to the callback
> - *
> - * Initialise a new timer attached to the context @ctx.
> - * See aio_timer_init_with_attrs for details.
> - */
> -static inline void aio_timer_init(AioContext *ctx,
> -                                  QEMUTimer *ts, QEMUClockType type,
> -                                  int scale,
> -                                  QEMUTimerCB *cb, void *opaque)
> -{
> -    timer_init_full(ts, &ctx->tlg, type, scale, 0, cb, opaque);
> -}
> -
> -/**
> - * aio_compute_timeout:
> - * @ctx: the aio context
> - *
> - * Compute the timeout that a blocking aio_poll should use.
> - */
> -int64_t aio_compute_timeout(AioContext *ctx);
> -
> -/**
> - * aio_co_schedule:
> - * @ctx: the aio context
> - * @co: the coroutine
> - *
> - * Start a coroutine on a remote AioContext.
> - *
> - * The coroutine must not be entered by anyone else while aio_co_schedule()
> - * is active.  In addition the coroutine must have yielded unless ctx
> - * is the context in which the coroutine is running (i.e. the value of
> - * qemu_get_current_aio_context() from the coroutine itself).
> - */
> -void aio_co_schedule(AioContext *ctx, Coroutine *co);
> -
> -/**
> - * aio_co_reschedule_self:
> - * @new_ctx: the new context
> - *
> - * Move the currently running coroutine to new_ctx. If the coroutine is already
> - * running in new_ctx, do nothing.
> - *
> - * Note that this function cannot reschedule from iohandler_ctx to
> - * qemu_aio_context.
> - */
> -void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx);
> -
> -/**
> - * aio_co_wake:
> - * @co: the coroutine
> - *
> - * Restart a coroutine on the AioContext where it was running last, thus
> - * preventing coroutines from jumping from one context to another when they
> - * go to sleep.
> - *
> - * aio_co_wake may be executed either in coroutine or non-coroutine
> - * context.  The coroutine must not be entered by anyone else while
> - * aio_co_wake() is active.
> - *
> - * If `co`'s AioContext differs from the current AioContext, this will call
> - * aio_co_schedule(), which makes this safe to use even when `co` has not
> - * yielded yet.  In such a case, it will be entered once it yields.
> - *
> - * In contrast, if `co`'s AioContext is equal to the current one, it is
> - * required for `co` to currently be yielding.  This is generally the case
> - * if the caller is not in `co` (i.e. invoked by `co`), because the only
> - * other way for the caller to be running then is for `co` to currently be
> - * yielding.
> - *
> - * Therefore, if there is no way for the caller to be invoked/entered by
> - * `co`, it is generally safe to call this regardless of whether `co` is
> - * known to already be yielding or not -- it only has to yield at some
> - * point.
> - */
> -void aio_co_wake(Coroutine *co);
> -
> -/**
> - * aio_co_enter:
> - * @ctx: the context to run the coroutine
> - * @co: the coroutine to run
> - *
> - * Enter a coroutine in the specified AioContext.
> - */
> -void aio_co_enter(AioContext *ctx, Coroutine *co);
> -
> -/**
> - * Return the AioContext whose event loop runs in the current thread.
> - *
> - * If called from an IOThread this will be the IOThread's AioContext.  If
> - * called from the main thread or with the "big QEMU lock" taken it
> - * will be the main loop AioContext.
> - *
> - * Note that the return value is never the main loop's iohandler_ctx and the
> - * return value is the main loop AioContext instead.
> - */
> -AioContext *qemu_get_current_aio_context(void);
> -
> -void qemu_set_current_aio_context(AioContext *ctx);
> -
> -/**
> - * aio_context_setup:
> - * @ctx: the aio context
> - * @errp: error pointer
> - *
> - * Initialize the aio context.
> - *
> - * Returns: true on success, false otherwise
> - */
> -bool aio_context_setup(AioContext *ctx, Error **errp);
> -
> -/**
> - * aio_context_destroy:
> - * @ctx: the aio context
> - *
> - * Destroy the aio context.
> - */
> -void aio_context_destroy(AioContext *ctx);
> -
> -/**
> - * aio_context_set_poll_params:
> - * @ctx: the aio context
> - * @max_ns: how long to busy poll for, in nanoseconds
> - * @grow: polling time growth factor
> - * @shrink: polling time shrink factor
> - *
> - * Poll mode can be disabled by setting poll_max_ns to 0.
> - */
> -void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
> -                                 int64_t grow, int64_t shrink,
> -                                 Error **errp);
> -
> -/**
> - * aio_context_set_aio_params:
> - * @ctx: the aio context
> - * @max_batch: maximum number of requests in a batch, 0 means that the
> - *             engine will use its default
> - */
> -void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch);
> -
> -/**
> - * aio_context_set_thread_pool_params:
> - * @ctx: the aio context
> - * @min: min number of threads to have readily available in the thread pool
> - * @min: max number of threads the thread pool can contain
> - */
> -void aio_context_set_thread_pool_params(AioContext *ctx, int64_t min,
> -                                        int64_t max, Error **errp);
> -
> -#ifdef CONFIG_LINUX_IO_URING
> -/**
> - * aio_has_io_uring: Return whether io_uring is available.
> - *
> - * io_uring is either available in all AioContexts or in none, so this only
> - * needs to be called once from within any thread's AioContext.
> - */
> -static inline bool aio_has_io_uring(void)
> -{
> -    AioContext *ctx = qemu_get_current_aio_context();
> -    return ctx->fdmon_ops->add_sqe;
> -}
> -
> -/**
> - * aio_add_sqe: Add an io_uring sqe for submission.
> - * @prep_sqe: invoked with an sqe that should be prepared for submission
> - * @opaque: user-defined argument to @prep_sqe()
> - * @cqe_handler: the unique cqe handler associated with this request
> - *
> - * The caller's @prep_sqe() function is invoked to fill in the details of the
> - * sqe. Do not call io_uring_sqe_set_data() on this sqe.
> - *
> - * The sqe is submitted by the current AioContext. The kernel may see the sqe
> - * as soon as @prep_sqe() returns or it may take until the next event loop
> - * iteration.
> - *
> - * When the AioContext is destroyed, pending sqes are ignored and their
> - * CqeHandlers are not invoked.
> - *
> - * This function must be called only when aio_has_io_uring() returns true.
> - */
> -void aio_add_sqe(void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
> -                 void *opaque, CqeHandler *cqe_handler);
> -#endif /* CONFIG_LINUX_IO_URING */
> -
>  #endif
> diff --git a/include/qemu/aio.h b/include/qemu/aio.h
> new file mode 100644
> index 00000000000..8cca2360d1a
> --- /dev/null
> +++ b/include/qemu/aio.h
> @@ -0,0 +1,852 @@
> +/*
> + * QEMU aio implementation
> + *
> + * Copyright IBM, Corp. 2008
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef QEMU_AIO_H
> +#define QEMU_AIO_H
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +#include <liburing.h>
> +#endif
> +#include "qemu/coroutine-core.h"
> +#include "qemu/queue.h"
> +#include "qemu/event_notifier.h"
> +#include "qemu/lockcnt.h"
> +#include "qemu/thread.h"
> +#include "qemu/timer.h"
> +
> +struct MemReentrancyGuard;
> +
> +typedef struct AioHandler AioHandler;
> +typedef QLIST_HEAD(, AioHandler) AioHandlerList;
> +typedef void QEMUBHFunc(void *opaque);
> +typedef bool AioPollFn(void *opaque);
> +typedef void IOHandler(void *opaque);
> +
> +struct ThreadPoolAio;
> +struct LinuxAioState;
> +typedef struct LuringState LuringState;
> +
> +/* Is polling disabled? */
> +bool aio_poll_disabled(AioContext *ctx);
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +/*
> + * Each io_uring request must have a unique CqeHandler that processes the cqe.
> + * The lifetime of a CqeHandler must be at least from aio_add_sqe() until
> + * ->cb() invocation.
> + */
> +typedef struct CqeHandler CqeHandler;
> +struct CqeHandler {
> +    /* Called by the AioContext when the request has completed */
> +    void (*cb)(CqeHandler *handler);
> +
> +    /* Used internally, do not access this */
> +    QSIMPLEQ_ENTRY(CqeHandler) next;
> +
> +    /* This field is filled in before ->cb() is called */
> +    struct io_uring_cqe cqe;
> +};
> +
> +typedef QSIMPLEQ_HEAD(, CqeHandler) CqeHandlerSimpleQ;
> +#endif /* CONFIG_LINUX_IO_URING */
> +
> +/* Callbacks for file descriptor monitoring implementations */
> +typedef struct {
> +    /*
> +     * update:
> +     * @ctx: the AioContext
> +     * @old_node: the existing handler or NULL if this file descriptor is being
> +     *            monitored for the first time
> +     * @new_node: the new handler or NULL if this file descriptor is being
> +     *            removed
> +     *
> +     * Add/remove/modify a monitored file descriptor.
> +     *
> +     * Called with ctx->list_lock acquired.
> +     */
> +    void (*update)(AioContext *ctx, AioHandler *old_node, AioHandler *new_node);
> +
> +    /*
> +     * wait:
> +     * @ctx: the AioContext
> +     * @ready_list: list for handlers that become ready
> +     * @timeout: maximum duration to wait, in nanoseconds
> +     *
> +     * Wait for file descriptors to become ready and place them on ready_list.
> +     *
> +     * Called with ctx->list_lock incremented but not locked.
> +     *
> +     * Returns: number of ready file descriptors.
> +     */
> +    int (*wait)(AioContext *ctx, AioHandlerList *ready_list, int64_t timeout);
> +
> +    /*
> +     * need_wait:
> +     * @ctx: the AioContext
> +     *
> +     * Tell aio_poll() when to stop userspace polling early because ->wait()
> +     * has fds ready.
> +     *
> +     * File descriptor monitoring implementations that cannot poll fd readiness
> +     * from userspace should use aio_poll_disabled() here.  This ensures that
> +     * file descriptors are not starved by handlers that frequently make
> +     * progress via userspace polling.
> +     *
> +     * Returns: true if ->wait() should be called, false otherwise.
> +     */
> +    bool (*need_wait)(AioContext *ctx);
> +
> +    /*
> +     * dispatch:
> +     * @ctx: the AioContext
> +     *
> +     * Dispatch any work that is specific to this file descriptor monitoring
> +     * implementation. Usually the event loop's generic file descriptor
> +     * monitoring, BH, and timer dispatching code is sufficient, but file
> +     * descriptor monitoring implementations offering additional functionality
> +     * may need to implement this function for custom behavior. Called at a
> +     * point in the event loop when it is safe to invoke user-defined
> +     * callbacks.
> +     *
> +     * This function is optional and may be NULL.
> +     *
> +     * Returns: true if progress was made (see aio_poll()'s return value),
> +     * false otherwise.
> +     */
> +    bool (*dispatch)(AioContext *ctx);
> +
> +    /*
> +     * gsource_prepare:
> +     * @ctx: the AioContext
> +     *
> +     * Prepare for the glib event loop to wait for events instead of the usual
> +     * ->wait() call. See glib's GSourceFuncs->prepare().
> +     */
> +    void (*gsource_prepare)(AioContext *ctx);
> +
> +    /*
> +     * gsource_check:
> +     * @ctx: the AioContext
> +     *
> +     * Called by the glib event loop from glib's GSourceFuncs->check() after
> +     * waiting for events.
> +     *
> +     * Returns: true when ready to be dispatched.
> +     */
> +    bool (*gsource_check)(AioContext *ctx);
> +
> +    /*
> +     * gsource_dispatch:
> +     * @ctx: the AioContext
> +     * @ready_list: list for handlers that become ready
> +     *
> +     * Place ready AioHandlers on ready_list. Called as part of the glib event
> +     * loop from glib's GSourceFuncs->dispatch().
> +     *
> +     * Called with list_lock incremented.
> +     */
> +    void (*gsource_dispatch)(AioContext *ctx, AioHandlerList *ready_list);
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +    /**
> +     * add_sqe: Add an io_uring sqe for submission.
> +     * @prep_sqe: invoked with an sqe that should be prepared for submission
> +     * @opaque: user-defined argument to @prep_sqe()
> +     * @cqe_handler: the unique cqe handler associated with this request
> +     *
> +     * The caller's @prep_sqe() function is invoked to fill in the details of
> +     * the sqe. Do not call io_uring_sqe_set_data() on this sqe.
> +     *
> +     * The kernel may see the sqe as soon as @prep_sqe() returns or it may take
> +     * until the next event loop iteration.
> +     *
> +     * This function is called from the current AioContext and is not
> +     * thread-safe.
> +     */
> +    void (*add_sqe)(AioContext *ctx,
> +                    void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
> +                    void *opaque, CqeHandler *cqe_handler);
> +#endif /* CONFIG_LINUX_IO_URING */
> +} FDMonOps;
> +
> +/*
> + * Each aio_bh_poll() call carves off a slice of the BH list, so that newly
> + * scheduled BHs are not processed until the next aio_bh_poll() call.  All
> + * active aio_bh_poll() calls chain their slices together in a list, so that
> + * nested aio_bh_poll() calls process all scheduled bottom halves.
> + */
> +typedef QSLIST_HEAD(, QEMUBH) BHList;
> +typedef struct BHListSlice BHListSlice;
> +struct BHListSlice {
> +    BHList bh_list;
> +    QSIMPLEQ_ENTRY(BHListSlice) next;
> +};
> +
> +typedef QSLIST_HEAD(, AioHandler) AioHandlerSList;
> +
> +typedef struct AioPolledEvent {
> +    int64_t ns;        /* current polling time in nanoseconds */
> +} AioPolledEvent;
> +
> +struct AioContext {
> +    GSource source;
> +
> +    /* Used by AioContext users to protect from multi-threaded access.  */
> +    QemuRecMutex lock;
> +
> +    /*
> +     * Keep track of readers and writers of the block layer graph.
> +     * This is essential to avoid performing additions and removal
> +     * of nodes and edges from block graph while some
> +     * other thread is traversing it.
> +     */
> +    struct BdrvGraphRWlock *bdrv_graph;
> +
> +    /* The list of registered AIO handlers.  Protected by ctx->list_lock. */
> +    AioHandlerList aio_handlers;
> +
> +    /* The list of AIO handlers to be deleted.  Protected by ctx->list_lock. */
> +    AioHandlerList deleted_aio_handlers;
> +
> +    /* Used to avoid unnecessary event_notifier_set calls in aio_notify;
> +     * only written from the AioContext home thread, or under the BQL in
> +     * the case of the main AioContext.  However, it is read from any
> +     * thread so it is still accessed with atomic primitives.
> +     *
> +     * If this field is 0, everything (file descriptors, bottom halves,
> +     * timers) will be re-evaluated before the next blocking poll() or
> +     * io_uring wait; therefore, the event_notifier_set call can be
> +     * skipped.  If it is non-zero, you may need to wake up a concurrent
> +     * aio_poll or the glib main event loop, making event_notifier_set
> +     * necessary.
> +     *
> +     * Bit 0 is reserved for GSource usage of the AioContext, and is 1
> +     * between a call to aio_ctx_prepare and the next call to aio_ctx_check.
> +     * Bits 1-31 simply count the number of active calls to aio_poll
> +     * that are in the prepare or poll phase.
> +     *
> +     * The GSource and aio_poll must use a different mechanism because
> +     * there is no certainty that a call to GSource's prepare callback
> +     * (via g_main_context_prepare) is indeed followed by check and
> +     * dispatch.  It's not clear whether this would be a bug, but let's
> +     * play safe and allow it---it will just cause extra calls to
> +     * event_notifier_set until the next call to dispatch.
> +     *
> +     * Instead, the aio_poll calls include both the prepare and the
> +     * dispatch phase, hence a simple counter is enough for them.
> +     */
> +    uint32_t notify_me;
> +
> +    /* A lock to protect between QEMUBH and AioHandler adders and deleter,
> +     * and to ensure that no callbacks are removed while we're walking and
> +     * dispatching them.
> +     */
> +    QemuLockCnt list_lock;
> +
> +    /* Bottom Halves pending aio_bh_poll() processing */
> +    BHList bh_list;
> +
> +    /* Chained BH list slices for each nested aio_bh_poll() call */
> +    QSIMPLEQ_HEAD(, BHListSlice) bh_slice_list;
> +
> +    /* Used by aio_notify.
> +     *
> +     * "notified" is used to avoid expensive event_notifier_test_and_clear
> +     * calls.  When it is clear, the EventNotifier is clear, or one thread
> +     * is going to clear "notified" before processing more events.  False
> +     * positives are possible, i.e. "notified" could be set even though the
> +     * EventNotifier is clear.
> +     *
> +     * Note that event_notifier_set *cannot* be optimized the same way.  For
> +     * more information on the problem that would result, see "#ifdef BUG2"
> +     * in the docs/aio_notify_accept.promela formal model.
> +     */
> +    bool notified;
> +    EventNotifier notifier;
> +
> +    QSLIST_HEAD(, Coroutine) scheduled_coroutines;
> +    QEMUBH *co_schedule_bh;
> +
> +    int thread_pool_min;
> +    int thread_pool_max;
> +    /* Thread pool for performing work and receiving completion callbacks.
> +     * Has its own locking.
> +     */
> +    struct ThreadPoolAio *thread_pool;
> +
> +#ifdef CONFIG_LINUX_AIO
> +    struct LinuxAioState *linux_aio;
> +#endif
> +#ifdef CONFIG_LINUX_IO_URING
> +    /* State for file descriptor monitoring using Linux io_uring */
> +    struct io_uring fdmon_io_uring;
> +    AioHandlerSList submit_list;
> +    void *io_uring_fd_tag;
> +
> +    /* Pending callback state for cqe handlers */
> +    CqeHandlerSimpleQ cqe_handler_ready_list;
> +#endif /* CONFIG_LINUX_IO_URING */
> +
> +    /* TimerLists for calling timers - one per clock type.  Has its own
> +     * locking.
> +     */
> +    QEMUTimerListGroup tlg;
> +
> +    /* Number of AioHandlers without .io_poll() */
> +    int poll_disable_cnt;
> +
> +    /* Polling mode parameters */
> +    int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
> +    int64_t poll_grow;      /* polling time growth factor */
> +    int64_t poll_shrink;    /* polling time shrink factor */
> +
> +    /* AIO engine parameters */
> +    int64_t aio_max_batch;  /* maximum number of requests in a batch */
> +
> +    /*
> +     * List of handlers participating in userspace polling.  Protected by
> +     * ctx->list_lock.  Iterated and modified mostly by the event loop thread
> +     * from aio_poll() with ctx->list_lock incremented.  aio_set_fd_handler()
> +     * only touches the list to delete nodes if ctx->list_lock's count is zero.
> +     */
> +    AioHandlerList poll_aio_handlers;
> +
> +    /* Are we in polling mode or monitoring file descriptors? */
> +    bool poll_started;
> +
> +    /* epoll(7) state used when built with CONFIG_EPOLL */
> +    int epollfd;
> +
> +    /* The GSource unix fd tag for epollfd */
> +    void *epollfd_tag;
> +
> +    const FDMonOps *fdmon_ops;
> +
> +    /* Was aio_context_new() successful? */
> +    bool initialized;
> +};
> +
> +/**
> + * aio_context_new: Allocate a new AioContext.
> + *
> + * AioContext provide a mini event-loop that can be waited on synchronously.
> + * They also provide bottom halves, a service to execute a piece of code
> + * as soon as possible.
> + */
> +AioContext *aio_context_new(Error **errp);
> +
> +/**
> + * aio_context_ref:
> + * @ctx: The AioContext to operate on.
> + *
> + * Add a reference to an AioContext.
> + */
> +void aio_context_ref(AioContext *ctx);
> +
> +/**
> + * aio_context_unref:
> + * @ctx: The AioContext to operate on.
> + *
> + * Drop a reference to an AioContext.
> + */
> +void aio_context_unref(AioContext *ctx);
> +
> +/**
> + * aio_bh_schedule_oneshot_full: Allocate a new bottom half structure that will
> + * run only once and as soon as possible.
> + *
> + * @name: A human-readable identifier for debugging purposes.
> + */
> +void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
> +                                  const char *name);
> +
> +/**
> + * aio_bh_schedule_oneshot: Allocate a new bottom half structure that will run
> + * only once and as soon as possible.
> + *
> + * A convenience wrapper for aio_bh_schedule_oneshot_full() that uses cb as the
> + * name string.
> + */
> +#define aio_bh_schedule_oneshot(ctx, cb, opaque) \
> +    aio_bh_schedule_oneshot_full((ctx), (cb), (opaque), (stringify(cb)))
> +
> +/**
> + * aio_bh_new_full: Allocate a new bottom half structure.
> + *
> + * Bottom halves are lightweight callbacks whose invocation is guaranteed
> + * to be wait-free, thread-safe and signal-safe.  The #QEMUBH structure
> + * is opaque and must be allocated prior to its use.
> + *
> + * @name: A human-readable identifier for debugging purposes.
> + * @reentrancy_guard: A guard set when entering a cb to prevent
> + * device-reentrancy issues
> + */
> +QEMUBH *aio_bh_new_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
> +                        const char *name, struct MemReentrancyGuard *reentrancy_guard);
> +
> +/**
> + * aio_bh_new: Allocate a new bottom half structure
> + *
> + * A convenience wrapper for aio_bh_new_full() that uses the cb as the name
> + * string.
> + */
> +#define aio_bh_new(ctx, cb, opaque) \
> +    aio_bh_new_full((ctx), (cb), (opaque), (stringify(cb)), NULL)
> +
> +/**
> + * aio_bh_new_guarded: Allocate a new bottom half structure with a
> + * reentrancy_guard
> + *
> + * A convenience wrapper for aio_bh_new_full() that uses the cb as the name
> + * string.
> + */
> +#define aio_bh_new_guarded(ctx, cb, opaque, guard) \
> +    aio_bh_new_full((ctx), (cb), (opaque), (stringify(cb)), guard)
> +
> +/**
> + * aio_notify: Force processing of pending events.
> + *
> + * Similar to signaling a condition variable, aio_notify forces
> + * aio_poll to exit, so that the next call will re-examine pending events.
> + * The caller of aio_notify will usually call aio_poll again very soon,
> + * or go through another iteration of the GLib main loop.  Hence, aio_notify
> + * also has the side effect of recalculating the sets of file descriptors
> + * that the main loop waits for.
> + *
> + * Calling aio_notify is rarely necessary, because for example scheduling
> + * a bottom half calls it already.
> + */
> +void aio_notify(AioContext *ctx);
> +
> +/**
> + * aio_notify_accept: Acknowledge receiving an aio_notify.
> + *
> + * aio_notify() uses an EventNotifier in order to wake up a sleeping
> + * aio_poll() or g_main_context_iteration().  Calls to aio_notify() are
> + * usually rare, but the AioContext has to clear the EventNotifier on
> + * every aio_poll() or g_main_context_iteration() in order to avoid
> + * busy waiting.  This event_notifier_test_and_clear() cannot be done
> + * using the usual aio_context_set_event_notifier(), because it must
> + * be done before processing all events (file descriptors, bottom halves,
> + * timers).
> + *
> + * aio_notify_accept() is an optimized event_notifier_test_and_clear()
> + * that is specific to an AioContext's notifier; it is used internally
> + * to clear the EventNotifier only if aio_notify() had been called.
> + */
> +void aio_notify_accept(AioContext *ctx);
> +
> +/**
> + * aio_bh_call: Executes callback function of the specified BH.
> + */
> +void aio_bh_call(QEMUBH *bh);
> +
> +/**
> + * aio_bh_poll: Poll bottom halves for an AioContext.
> + *
> + * These are internal functions used by the QEMU main loop.
> + * And notice that multiple occurrences of aio_bh_poll cannot
> + * be called concurrently
> + */
> +int aio_bh_poll(AioContext *ctx);
> +
> +/**
> + * qemu_bh_schedule: Schedule a bottom half.
> + *
> + * Scheduling a bottom half interrupts the main loop and causes the
> + * execution of the callback that was passed to qemu_bh_new.
> + *
> + * Bottom halves that are scheduled from a bottom half handler are instantly
> + * invoked.  This can create an infinite loop if a bottom half handler
> + * schedules itself.
> + *
> + * @bh: The bottom half to be scheduled.
> + */
> +void qemu_bh_schedule(QEMUBH *bh);
> +
> +/**
> + * qemu_bh_cancel: Cancel execution of a bottom half.
> + *
> + * Canceling execution of a bottom half undoes the effect of calls to
> + * qemu_bh_schedule without freeing its resources yet.  While cancellation
> + * itself is also wait-free and thread-safe, it can of course race with the
> + * loop that executes bottom halves unless you are holding the iothread
> + * mutex.  This makes it mostly useless if you are not holding the mutex.
> + *
> + * @bh: The bottom half to be canceled.
> + */
> +void qemu_bh_cancel(QEMUBH *bh);
> +
> +/**
> + *qemu_bh_delete: Cancel execution of a bottom half and free its resources.
> + *
> + * Deleting a bottom half frees the memory that was allocated for it by
> + * qemu_bh_new.  It also implies canceling the bottom half if it was
> + * scheduled.
> + * This func is async. The bottom half will do the delete action at the finial
> + * end.
> + *
> + * @bh: The bottom half to be deleted.
> + */
> +void qemu_bh_delete(QEMUBH *bh);
> +
> +/* Return whether there are any pending callbacks from the GSource
> + * attached to the AioContext, before g_poll is invoked.
> + *
> + * This is used internally in the implementation of the GSource.
> + */
> +bool aio_prepare(AioContext *ctx);
> +
> +/* Return whether there are any pending callbacks from the GSource
> + * attached to the AioContext, after g_poll is invoked.
> + *
> + * This is used internally in the implementation of the GSource.
> + */
> +bool aio_pending(AioContext *ctx);
> +
> +/* Dispatch any pending callbacks from the GSource attached to the AioContext.
> + *
> + * This is used internally in the implementation of the GSource.
> + */
> +void aio_dispatch(AioContext *ctx);
> +
> +/* Progress in completing AIO work to occur.  This can issue new pending
> + * aio as a result of executing I/O completion or bh callbacks.
> + *
> + * Return whether any progress was made by executing AIO or bottom half
> + * handlers.  If @blocking == true, this should always be true except
> + * if someone called aio_notify.
> + *
> + * If there are no pending bottom halves, but there are pending AIO
> + * operations, it may not be possible to make any progress without
> + * blocking.  If @blocking is true, this function will wait until one
> + * or more AIO events have completed, to ensure something has moved
> + * before returning.
> + */
> +bool no_coroutine_fn aio_poll(AioContext *ctx, bool blocking);
> +
> +/* Register a file descriptor and associated callbacks.  Behaves very similarly
> + * to qemu_set_fd_handler.  Unlike qemu_set_fd_handler, these callbacks will
> + * be invoked when using aio_poll().
> + *
> + * Code that invokes AIO completion functions should rely on this function
> + * instead of qemu_set_fd_handler[2].
> + */
> +void aio_set_fd_handler(AioContext *ctx,
> +                        int fd,
> +                        IOHandler *io_read,
> +                        IOHandler *io_write,
> +                        AioPollFn *io_poll,
> +                        IOHandler *io_poll_ready,
> +                        void *opaque);
> +
> +/* Register an event notifier and associated callbacks.  Behaves very similarly
> + * to event_notifier_set_handler.  Unlike event_notifier_set_handler, these callbacks
> + * will be invoked when using aio_poll().
> + *
> + * Code that invokes AIO completion functions should rely on this function
> + * instead of event_notifier_set_handler.
> + */
> +void aio_set_event_notifier(AioContext *ctx,
> +                            EventNotifier *notifier,
> +                            EventNotifierHandler *io_read,
> +                            AioPollFn *io_poll,
> +                            EventNotifierHandler *io_poll_ready);
> +
> +/*
> + * Set polling begin/end callbacks for an event notifier that has already been
> + * registered with aio_set_event_notifier.  Do nothing if the event notifier is
> + * not registered.
> + *
> + * Note that if the io_poll_end() callback (or the entire notifier) is removed
> + * during polling, it will not be called, so an io_poll_begin() is not
> + * necessarily always followed by an io_poll_end().
> + */
> +void aio_set_event_notifier_poll(AioContext *ctx,
> +                                 EventNotifier *notifier,
> +                                 EventNotifierHandler *io_poll_begin,
> +                                 EventNotifierHandler *io_poll_end);
> +
> +/* Return a GSource that lets the main loop poll the file descriptors attached
> + * to this AioContext.
> + */
> +GSource *aio_get_g_source(AioContext *ctx);
> +
> +/* Return the ThreadPoolAio bound to this AioContext */
> +struct ThreadPoolAio *aio_get_thread_pool(AioContext *ctx);
> +
> +/* Setup the LinuxAioState bound to this AioContext */
> +struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
> +
> +/* Return the LinuxAioState bound to this AioContext */
> +struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
> +
> +/**
> + * aio_timer_new_with_attrs:
> + * @ctx: the aio context
> + * @type: the clock type
> + * @scale: the scale
> + * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR_<id> values
> + *              to assign
> + * @cb: the callback to call on timer expiry
> + * @opaque: the opaque pointer to pass to the callback
> + *
> + * Allocate a new timer (with attributes) attached to the context @ctx.
> + * The function is responsible for memory allocation.
> + *
> + * The preferred interface is aio_timer_init or aio_timer_init_with_attrs.
> + * Use that unless you really need dynamic memory allocation.
> + *
> + * Returns: a pointer to the new timer
> + */
> +static inline QEMUTimer *aio_timer_new_with_attrs(AioContext *ctx,
> +                                                  QEMUClockType type,
> +                                                  int scale, int attributes,
> +                                                  QEMUTimerCB *cb, void *opaque)
> +{
> +    return timer_new_full(&ctx->tlg, type, scale, attributes, cb, opaque);
> +}
> +
> +/**
> + * aio_timer_new:
> + * @ctx: the aio context
> + * @type: the clock type
> + * @scale: the scale
> + * @cb: the callback to call on timer expiry
> + * @opaque: the opaque pointer to pass to the callback
> + *
> + * Allocate a new timer attached to the context @ctx.
> + * See aio_timer_new_with_attrs for details.
> + *
> + * Returns: a pointer to the new timer
> + */
> +static inline QEMUTimer *aio_timer_new(AioContext *ctx, QEMUClockType type,
> +                                       int scale,
> +                                       QEMUTimerCB *cb, void *opaque)
> +{
> +    return timer_new_full(&ctx->tlg, type, scale, 0, cb, opaque);
> +}
> +
> +/**
> + * aio_timer_init_with_attrs:
> + * @ctx: the aio context
> + * @ts: the timer
> + * @type: the clock type
> + * @scale: the scale
> + * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR_<id> values
> + *              to assign
> + * @cb: the callback to call on timer expiry
> + * @opaque: the opaque pointer to pass to the callback
> + *
> + * Initialise a new timer (with attributes) attached to the context @ctx.
> + * The caller is responsible for memory allocation.
> + */
> +static inline void aio_timer_init_with_attrs(AioContext *ctx,
> +                                             QEMUTimer *ts, QEMUClockType type,
> +                                             int scale, int attributes,
> +                                             QEMUTimerCB *cb, void *opaque)
> +{
> +    timer_init_full(ts, &ctx->tlg, type, scale, attributes, cb, opaque);
> +}
> +
> +/**
> + * aio_timer_init:
> + * @ctx: the aio context
> + * @ts: the timer
> + * @type: the clock type
> + * @scale: the scale
> + * @cb: the callback to call on timer expiry
> + * @opaque: the opaque pointer to pass to the callback
> + *
> + * Initialise a new timer attached to the context @ctx.
> + * See aio_timer_init_with_attrs for details.
> + */
> +static inline void aio_timer_init(AioContext *ctx,
> +                                  QEMUTimer *ts, QEMUClockType type,
> +                                  int scale,
> +                                  QEMUTimerCB *cb, void *opaque)
> +{
> +    timer_init_full(ts, &ctx->tlg, type, scale, 0, cb, opaque);
> +}
> +
> +/**
> + * aio_compute_timeout:
> + * @ctx: the aio context
> + *
> + * Compute the timeout that a blocking aio_poll should use.
> + */
> +int64_t aio_compute_timeout(AioContext *ctx);
> +
> +/**
> + * aio_co_schedule:
> + * @ctx: the aio context
> + * @co: the coroutine
> + *
> + * Start a coroutine on a remote AioContext.
> + *
> + * The coroutine must not be entered by anyone else while aio_co_schedule()
> + * is active.  In addition the coroutine must have yielded unless ctx
> + * is the context in which the coroutine is running (i.e. the value of
> + * qemu_get_current_aio_context() from the coroutine itself).
> + */
> +void aio_co_schedule(AioContext *ctx, Coroutine *co);
> +
> +/**
> + * aio_co_reschedule_self:
> + * @new_ctx: the new context
> + *
> + * Move the currently running coroutine to new_ctx. If the coroutine is already
> + * running in new_ctx, do nothing.
> + *
> + * Note that this function cannot reschedule from iohandler_ctx to
> + * qemu_aio_context.
> + */
> +void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx);
> +
> +/**
> + * aio_co_wake:
> + * @co: the coroutine
> + *
> + * Restart a coroutine on the AioContext where it was running last, thus
> + * preventing coroutines from jumping from one context to another when they
> + * go to sleep.
> + *
> + * aio_co_wake may be executed either in coroutine or non-coroutine
> + * context.  The coroutine must not be entered by anyone else while
> + * aio_co_wake() is active.
> + *
> + * If `co`'s AioContext differs from the current AioContext, this will call
> + * aio_co_schedule(), which makes this safe to use even when `co` has not
> + * yielded yet.  In such a case, it will be entered once it yields.
> + *
> + * In contrast, if `co`'s AioContext is equal to the current one, it is
> + * required for `co` to currently be yielding.  This is generally the case
> + * if the caller is not in `co` (i.e. invoked by `co`), because the only
> + * other way for the caller to be running then is for `co` to currently be
> + * yielding.
> + *
> + * Therefore, if there is no way for the caller to be invoked/entered by
> + * `co`, it is generally safe to call this regardless of whether `co` is
> + * known to already be yielding or not -- it only has to yield at some
> + * point.
> + */
> +void aio_co_wake(Coroutine *co);
> +
> +/**
> + * aio_co_enter:
> + * @ctx: the context to run the coroutine
> + * @co: the coroutine to run
> + *
> + * Enter a coroutine in the specified AioContext.
> + */
> +void aio_co_enter(AioContext *ctx, Coroutine *co);
> +
> +/**
> + * Return the AioContext whose event loop runs in the current thread.
> + *
> + * If called from an IOThread this will be the IOThread's AioContext.  If
> + * called from the main thread or with the "big QEMU lock" taken it
> + * will be the main loop AioContext.
> + *
> + * Note that the return value is never the main loop's iohandler_ctx and the
> + * return value is the main loop AioContext instead.
> + */
> +AioContext *qemu_get_current_aio_context(void);
> +
> +void qemu_set_current_aio_context(AioContext *ctx);
> +
> +/**
> + * aio_context_setup:
> + * @ctx: the aio context
> + * @errp: error pointer
> + *
> + * Initialize the aio context.
> + *
> + * Returns: true on success, false otherwise
> + */
> +bool aio_context_setup(AioContext *ctx, Error **errp);
> +
> +/**
> + * aio_context_destroy:
> + * @ctx: the aio context
> + *
> + * Destroy the aio context.
> + */
> +void aio_context_destroy(AioContext *ctx);
> +
> +/**
> + * aio_context_set_poll_params:
> + * @ctx: the aio context
> + * @max_ns: how long to busy poll for, in nanoseconds
> + * @grow: polling time growth factor
> + * @shrink: polling time shrink factor
> + *
> + * Poll mode can be disabled by setting poll_max_ns to 0.
> + */
> +void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
> +                                 int64_t grow, int64_t shrink,
> +                                 Error **errp);
> +
> +/**
> + * aio_context_set_aio_params:
> + * @ctx: the aio context
> + * @max_batch: maximum number of requests in a batch, 0 means that the
> + *             engine will use its default
> + */
> +void aio_context_set_aio_params(AioContext *ctx, int64_t max_batch);
> +
> +/**
> + * aio_context_set_thread_pool_params:
> + * @ctx: the aio context
> + * @min: min number of threads to have readily available in the thread pool
> + * @min: max number of threads the thread pool can contain
> + */
> +void aio_context_set_thread_pool_params(AioContext *ctx, int64_t min,
> +                                        int64_t max, Error **errp);
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +/**
> + * aio_has_io_uring: Return whether io_uring is available.
> + *
> + * io_uring is either available in all AioContexts or in none, so this only
> + * needs to be called once from within any thread's AioContext.
> + */
> +static inline bool aio_has_io_uring(void)
> +{
> +    AioContext *ctx = qemu_get_current_aio_context();
> +    return ctx->fdmon_ops->add_sqe;
> +}
> +
> +/**
> + * aio_add_sqe: Add an io_uring sqe for submission.
> + * @prep_sqe: invoked with an sqe that should be prepared for submission
> + * @opaque: user-defined argument to @prep_sqe()
> + * @cqe_handler: the unique cqe handler associated with this request
> + *
> + * The caller's @prep_sqe() function is invoked to fill in the details of the
> + * sqe. Do not call io_uring_sqe_set_data() on this sqe.
> + *
> + * The sqe is submitted by the current AioContext. The kernel may see the sqe
> + * as soon as @prep_sqe() returns or it may take until the next event loop
> + * iteration.
> + *
> + * When the AioContext is destroyed, pending sqes are ignored and their
> + * CqeHandlers are not invoked.
> + *
> + * This function must be called only when aio_has_io_uring() returns true.
> + */
> +void aio_add_sqe(void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
> +                 void *opaque, CqeHandler *cqe_handler);
> +#endif /* CONFIG_LINUX_IO_URING */
> +
> +#endif
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index 0d55c636b21..8c1241a2c11 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -25,7 +25,7 @@
>  #ifndef QEMU_MAIN_LOOP_H
>  #define QEMU_MAIN_LOOP_H
>
> -#include "block/aio.h"
> +#include "qemu/aio.h"
>  #include "qom/object.h"
>  #include "system/event-loop-base.h"
>
> @@ -431,7 +431,7 @@ void qemu_cond_timedwait_bql(QemuCond *cond, int ms);
>  #define qemu_bh_new(cb, opaque) \
>      qemu_bh_new_full((cb), (opaque), (stringify(cb)), NULL)
>  QEMUBH *qemu_bh_new_full(QEMUBHFunc *cb, void *opaque, const char *name,
> -                         MemReentrancyGuard *reentrancy_guard);
> +                         struct MemReentrancyGuard *reentrancy_guard);
>  void qemu_bh_schedule_idle(QEMUBH *bh);
>
>  enum {
> --

Should  block/aio.h include qemu/aio.h?  User can include them both
where needed.

Otherwise looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


