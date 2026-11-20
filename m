Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2D606A333
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JfaFPyci
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURbK-0001VL-RV; Fri, 20 Nov 2026 11:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xURbI-0001Tv-GV
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:36:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xURbG-0000H2-Ih
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795192594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DIgWRL/Ip4Kq7LgYFNKoZNBu2Fv99FvXBs/fK3s03Y0=;
 b=JfaFPycis46VI1HNvuie7OYmkEzZGKsYEXOSXeAbAsgOz8SWQZEnsYj9BplReTD/OcUPyI
 t9V15r8x8oFD8tltTNqvtiBGrdcVAY6w6qZBMUqFLZlwKudVKFUw5y/vpeKAKquiV/CrLj
 1APP/elxBIzcISHm2XYEBMlgDUtkXxU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-8NCkKcDsPROB2jn_gf7V2Q-1; Fri,
 20 Nov 2026 16:36:29 +0000
X-MC-Unique: 8NCkKcDsPROB2jn_gf7V2Q-1
X-Mimecast-MFC-AGG-ID: 8NCkKcDsPROB2jn_gf7V2Q_1795192587
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB4331955F3E; Fri, 20 Nov 2026 16:36:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CBB4195B3C8; Fri, 20 Nov 2026 16:36:25 +0000 (UTC)
Date: Fri, 20 Nov 2026 11:36:24 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 jmaguire2013@gmail.com, axboe@kernel.dk, kwolf@redhat.com,
 hreitz@redhat.com, t.lamprecht@proxmox.com, qemu-stable@nongnu.org,
 casasfernando@outlook.com, ncopa@alpinelinux.org
Subject: Re: [PATCH] fdmon-io_uring: avoid idle event loop being accounted as
 IO wait
Message-ID: <20261120163624.GC780462@shajnocz.csb>
References: <20261119150839.439544-1-f.ebner@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119150839.439544-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 04:08:08PM +0100, Fiona Ebner wrote:
> From: Thomas Lamprecht <t.lamprecht@proxmox.com>
> 
> Since QEMU 10.2, iothreads use io_uring for file descriptor monitoring
> when available at build time. The blocking wait in io_uring_enter()
> gets accounted as IO wait by the kernel even when only poll or timeout
> SQEs are present. The result is nearly 100% IO pressure in PSI on idle
> VMs.
> 
> The Linux kernel also has a bug conflating reservations for task
> references and real in-flight requests [0], so the issue would occur
> even if no poll or timeout SQE was present.
> 
> Split io_uring_submit_and_wait() into separate submit and wait calls
> so the IORING_ENTER_NO_IOWAIT flag can be passed to io_uring_enter().
> Track the number of in-flight requests that represent real block-layer
> IO (currently, anything submitted via aio_add_sqe() is) in a
> per-AioContext counter, and pass the flag when the count is zero.
> 
> SQ-ring composition alone is not a usable signal here: poll SQEs get
> re-armed by process_cqe_aio_handler() on every fd-event cycle, so
> workloads with constant fd wakeups (observed with librbd) always leave
> a non-timeout SQE in the ring even when the guest is idle. Block
> drivers that do not go through aio_add_sqe() (e.g. librbd, libaio,
> thread-pool) never increment the counter and thus always get the flag
> passed, which matches the semantic intent: their iothreads block on
> completion notifications from other threads, not on IO they issued
> themselves.
> 
> The flag is gated on IORING_FEAT_NO_IOWAIT so older kernels are
> unaffected.
> 
> The iowait_accounting_reqs counter added to the AioContext struct,
> must be accessed with atomics, since a vCPU thread can reach
> fdmon_io_uring_wait() via aio_poll() (for example via
> virtio_scsi_dataplane_stop()).
> 
> Even with this change, some users observe higher IO pressure than
> before the switch to io_uring in the event loop, but at least not
> nearly 100% when idle anymore.
> 
> [0]: https://lore.kernel.org/io-uring/b4d2aa36-8301-4e58-be3e-1451267b8c43@proxmox.com/T/
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ded29e64c6f3 ("aio-posix: integrate fdmon into glib event loop")
> Suggested-by: Fiona Ebner <f.ebner@proxmox.com>
> Link: https://lore.proxmox.com/pve-devel/525c4dad-6d04-41f0-8a21-9302b0c6baa4@proxmox.com/
> Co-authored-by: Fiona Ebner <f.ebner@proxmox.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> ---
>  include/qemu/aio.h    | 12 ++++++++++++
>  util/fdmon-io_uring.c | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/aio.h b/include/qemu/aio.h
> index e65e90093a..17bc145eb6 100644
> --- a/include/qemu/aio.h
> +++ b/include/qemu/aio.h
> @@ -55,6 +55,12 @@ struct CqeHandler {
>  
>      /* This field is filled in before ->cb() is called */
>      struct io_uring_cqe cqe;
> +
> +    /*
> +     * Whether the in-flight request should count towards IO wait.
> +     * Set by the fdmon layer; callers must not touch it.

"callers must not touch it"

This is a struct field and there are no callers since it's not a
function. Is the intent that this field is private to the fdmon
implementation and nothing outside should access this field?

> +     */
> +    bool iowait_accounting;
>  };
>  
>  typedef QSIMPLEQ_HEAD(, CqeHandler) CqeHandlerSimpleQ;
> @@ -295,6 +301,12 @@ struct AioContext {
>  
>      /* Pending callback state for cqe handlers */
>      CqeHandlerSimpleQ cqe_handler_ready_list;
> +
> +    /*
> +     * Number of in-flight requests that should count towards IO wait.
> +     * Must be accessed using atomics.
> +     */
> +    unsigned int iowait_accounting_reqs;
>  #endif /* CONFIG_LINUX_IO_URING */
>  
>      /* TimerLists for calling timers - one per clock type.  Has its own
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index b81e412402..d308ddfb04 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -51,6 +51,15 @@
>  #include "aio-posix.h"
>  #include "trace.h"
>  
> +/* Compat defines for liburing versions that lack NO_IOWAIT support */
> +#ifndef IORING_ENTER_NO_IOWAIT
> +#define IORING_ENTER_NO_IOWAIT (1U << 7)
> +#endif
> +
> +#ifndef IORING_FEAT_NO_IOWAIT
> +#define IORING_FEAT_NO_IOWAIT  (1U << 17)
> +#endif
> +
>  enum {
>      FDMON_IO_URING_ENTRIES  = 128, /* sq/cq ring size */
>  
> @@ -176,9 +185,14 @@ static void fdmon_io_uring_add_sqe(AioContext *ctx,
>  {
>      struct io_uring_sqe *sqe = get_sqe(ctx);
>  
> +    /* Currently, IO wait should be accounted for all requests here. */
> +    cqe_handler->iowait_accounting = true;
> +
>      prep_sqe(sqe, opaque);
>      io_uring_sqe_set_data(sqe, cqe_handler);
>  
> +    qatomic_inc(&ctx->iowait_accounting_reqs);
> +
>      trace_fdmon_io_uring_add_sqe(ctx, opaque, sqe->opcode, sqe->fd, sqe->off,
>                                   cqe_handler);
>  }
> @@ -286,6 +300,10 @@ static bool process_cqe(AioContext *ctx,
>          return false;
>      }
>  
> +    if (cqe_handler->iowait_accounting) {
> +        qatomic_dec(&ctx->iowait_accounting_reqs);
> +    }
> +
>      /*
>       * Special handling for AioHandler cqes. They need ready_list and have a
>       * return value.
> @@ -422,9 +440,25 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
>       * 1. If no SQEs were submitted, then -EINTR is returned.
>       * 2. If SQEs were submitted then the number of SQEs submitted is returned
>       *    rather than -EINTR.
> +     *
> +     * Submit and wait are split into separate calls so we can pass
> +     * IORING_ENTER_NO_IOWAIT when no request that should count against IO
> +     * wait is in flight.
>       */
>      do {
> -        ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
> +        ret = io_uring_submit(&ctx->fdmon_io_uring);
> +
> +        if (ret >= 0 && wait_nr > io_uring_cq_ready(&ctx->fdmon_io_uring)) {
> +            unsigned flags = IORING_ENTER_GETEVENTS;
> +
> +            if ((ctx->fdmon_io_uring.features & IORING_FEAT_NO_IOWAIT) &&
> +                qatomic_read(&ctx->iowait_accounting_reqs) == 0) {
> +                flags |= IORING_ENTER_NO_IOWAIT;
> +            }
> +
> +            ret = io_uring_enter(ctx->fdmon_io_uring.ring_fd, 0, wait_nr,
> +                                 flags, NULL);
> +        }

Can you use io_uring_set_iowait() instead of splitting
io_uring_submit_and_wait() so that all liburing APIs automatically
set/clear the flag when calling io_uring_enter(2)?

Perhaps that will also reduce the remaining iowait that you observed
because there are other (indirect) io_uring_enter(2) calls in
fdmon-io_uring.c aside from.

>      } while (ret == -EINTR ||
>               (ret >= 0 && wait_nr > io_uring_cq_ready(&ctx->fdmon_io_uring)));
>  
> -- 
> 2.47.3
> 
> 


