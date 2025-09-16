Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B97CAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 19:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyb2n-00021o-An; Tue, 16 Sep 2025 15:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uyb2l-00021I-HX
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 15:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uyb2h-0001gt-Tu
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 15:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758049721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vu+ZlQ0O/L0CT9Xua/VUpWbb26LRAV+bE/FxqWDyNfU=;
 b=Ypv8b/8UIEGEa1yao0ZeT90QQfOJO8MEDepCKyUW3fou6gaxRa6gig8AM0CkQy/FH1Hecn
 SMAdKkjMY0ivCJMtx6aoks7niVTF+JO8WIsijf2MfzCXpnijt+XHUMCJB7fN2u0CIkoUrw
 b7pmAI2f/vuXdy/N343mwzRBkCUxr/s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-P9m1zXzfOryXeKoS5lxE6Q-1; Tue,
 16 Sep 2025 15:08:38 -0400
X-MC-Unique: P9m1zXzfOryXeKoS5lxE6Q-1
X-Mimecast-MFC-AGG-ID: P9m1zXzfOryXeKoS5lxE6Q_1758049717
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77D1C180048E; Tue, 16 Sep 2025 19:08:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.124])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CF141800451; Tue, 16 Sep 2025 19:08:31 +0000 (UTC)
Date: Tue, 16 Sep 2025 21:08:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 1/4] export/fuse: add opt to enable FUSE-over-io_uring
Message-ID: <aMm1qc-JEa0FwkX3@redhat.com>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-2-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830025025.3610-2-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 30.08.2025 um 04:50 hat Brian Song geschrieben:
> This patch adds a new export option for storage-export-daemon to enable
> FUSE-over-io_uring via the switch io-uring=on|off (disableby default).
> It also implements the protocol handshake with the Linux kernel
> during the FUSE-over-io_uring initialization phase.
> 
> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
> 
> The kernel documentation describes in detail how FUSE-over-io_uring
> works. This patch implements the Initial SQE stage shown in thediagram:
> it initializes one queue per IOThread, each currently supporting a
> single submission queue entry (SQE). When the FUSE driver sends the
> first FUSE request (FUSE_INIT), storage-export-daemon calls
> fuse_uring_start() to complete initialization, ultimately submitting
> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
> successful initialization with the kernel.
> 
> We also added support for multiple IOThreads. The current Linux kernel
> requires registering $(nproc) queues when setting up FUSE-over-io_uring
> To let users customize the number of FUSE Queues (i.e., IOThreads),
> we first create nproc Ring Queues as required by the kernel, then
> distribute them in a round-robin manner to the FUSE Queues for
> registration. In addition, to support multiple in-flight requests,
> we configure each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH
> entries/requests.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>  block/export/fuse.c                  | 310 +++++++++++++++++++++++++--
>  docs/tools/qemu-storage-daemon.rst   |  11 +-
>  qapi/block-export.json               |   5 +-
>  storage-daemon/qemu-storage-daemon.c |   1 +
>  util/fdmon-io_uring.c                |   5 +-
>  5 files changed, 309 insertions(+), 23 deletions(-)
> 
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index c0ad4696ce..19bf9e5f74 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -48,6 +48,9 @@
>  #include <linux/fs.h>
>  #endif
>  
> +/* room needed in buffer to accommodate header */
> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
> +
>  /* Prevent overly long bounce buffer allocations */
>  #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
>  /*
> @@ -63,12 +66,59 @@
>      (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
>  
>  typedef struct FuseExport FuseExport;
> +typedef struct FuseQueue FuseQueue;
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +#define FUSE_DEFAULT_RING_QUEUE_DEPTH 64
> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32

Maybe it would be a little clearer if the next few types has URing in
their name instead of just Ring.

> +typedef struct FuseRingQueue FuseRingQueue;
> +typedef struct FuseRingEnt {
> +    /* back pointer */
> +    FuseRingQueue *rq;
> +
> +    /* commit id of a fuse request */
> +    uint64_t req_commit_id;
> +
> +    /* fuse request header and payload */
> +    struct fuse_uring_req_header req_header;
> +    void *op_payload;
> +    size_t req_payload_sz;
> +
> +    /* The vector passed to the kernel */
> +    struct iovec iov[2];
> +
> +    CqeHandler fuse_cqe_handler;
> +} FuseRingEnt;
> +
> +struct FuseRingQueue {

It would be good to have a comment here that explains the difference
between FuseQueue and FuseRingQueue.

Is this a distinction that should remain in the long run or would we
always have a 1:1 mapping between FuseQueue and FuseRingQueue once the
pending kernel changes are merged that allow a number of uring queues
different from the number of CPUs?

> +    int rqid;
> +
> +    /* back pointer */
> +    FuseQueue *q;
> +    FuseRingEnt *ent;
> +
> +    /* List entry for ring_queues */
> +    QLIST_ENTRY(FuseRingQueue) next;
> +};
> +
> +/*
> + * Round-robin distribution of ring queues across FUSE queues.
> + * This structure manages the mapping between kernel ring queues and user
> + * FUSE queues.
> + */
> +typedef struct FuseRingQueueManager {
> +    FuseRingQueue *ring_queues;
> +    int num_ring_queues;
> +    int num_fuse_queues;
> +} FuseRingQueueManager;

This isn't a manager, it's just the set of queues the export uses.

num_fuse_queues duplicates exp->num_queues, there is no reason for it to
exist. All users also have access to the FuseExport itself.

The other two fields can just be merged directly into FuseExport,
preferably renamed to uring_queues and num_uring_queues.

> +#endif
>  
>  /*
>   * One FUSE "queue", representing one FUSE FD from which requests are fetched
>   * and processed.  Each queue is tied to an AioContext.
>   */
> -typedef struct FuseQueue {
> +struct FuseQueue {
>      FuseExport *exp;
>  
>      AioContext *ctx;
> @@ -109,15 +159,11 @@ typedef struct FuseQueue {
>       * Free this buffer with qemu_vfree().
>       */
>      void *spillover_buf;
> -} FuseQueue;
>  
> -/*
> - * Verify that FuseQueue.request_buf plus the spill-over buffer together
> - * are big enough to be accepted by the FUSE kernel driver.
> - */
> -QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
> -                  FUSE_SPILLOVER_BUF_SIZE <
> -                  FUSE_MIN_READ_BUFFER);
> +#ifdef CONFIG_LINUX_IO_URING
> +    QLIST_HEAD(, FuseRingQueue) ring_queue_list;
> +#endif
> +};
>  
>  struct FuseExport {
>      BlockExport common;
> @@ -133,7 +179,7 @@ struct FuseExport {
>       */
>      bool halted;
>  
> -    int num_queues;
> +    size_t num_queues;

I'm not sure why this change is needed. If it is, can it be a separate
patch before this one, with a commit message describing the reason?

>      FuseQueue *queues;
>      /*
>       * True if this export should follow the generic export's AioContext.
> @@ -149,6 +195,12 @@ struct FuseExport {
>      /* Whether allow_other was used as a mount option or not */
>      bool allow_other;
>  
> +#ifdef CONFIG_LINUX_IO_URING
> +    bool is_uring;
> +    size_t ring_queue_depth;
> +    FuseRingQueueManager *ring_queue_manager;
> +#endif
> +
>      mode_t st_mode;
>      uid_t st_uid;
>      gid_t st_gid;
> @@ -205,7 +257,7 @@ static void fuse_attach_handlers(FuseExport *exp)
>          return;
>      }
>  
> -    for (int i = 0; i < exp->num_queues; i++) {
> +    for (size_t i = 0; i < exp->num_queues; i++) {
>          aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
>                             read_from_fuse_fd, NULL, NULL, NULL,
>                             &exp->queues[i]);
> @@ -257,6 +309,189 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>      .drained_poll  = fuse_export_drained_poll,
>  };
>  
> +#ifdef CONFIG_LINUX_IO_URING
> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
> +                    const unsigned int rqid,
> +                    const unsigned int commit_id)

Indentation is off here. There are two accepted styles for indentation
after breaking a long line in QEMU (see docs/devel/style.rst):

1. Indent the next line by exactly four spaces:

    do_something(x, y,
        z);

2. Align the next line with the first character after the opening
   parenthesis:

    do_something(x, y,
                 z);

The second one is the preferred one. The first one is generally only
used when the parenthesis is already too far right and we can't do much
about it.

> +{
> +    req->qid = rqid;
> +    req->commit_id = commit_id;
> +    req->flags = 0;
> +}
> +
> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
> +               __u32 cmd_op)

Indentation.

Another option here is to keep everything before the function name on a
separate line, like this:

static void
fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q, __u32 cmd_op)

This would allow the second line to stay under 80 characters.

> +{
> +    sqe->opcode = IORING_OP_URING_CMD;
> +
> +    sqe->fd = q->fuse_fd;
> +    sqe->rw_flags = 0;
> +    sqe->ioprio = 0;
> +    sqe->off = 0;
> +
> +    sqe->cmd_op = cmd_op;
> +    sqe->__pad1 = 0;
> +}
> +
> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
> +{
> +    FuseRingEnt *ent = opaque;
> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
> +
> +    fuse_uring_sqe_prepare(sqe, ent->rq->q, FUSE_IO_URING_CMD_REGISTER);
> +
> +    sqe->addr = (uint64_t)(ent->iov);
> +    sqe->len = 2;
> +
> +    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
> +}
> +
> +static void fuse_uring_submit_register(void *opaque)
> +{
> +    FuseRingEnt *ent = opaque;
> +    FuseExport *exp = ent->rq->q->exp;
> +
> +

Extra empty line.

> +    aio_add_sqe(fuse_uring_prep_sqe_register, ent, &(ent->fuse_cqe_handler));

The parentheses around ent->fuse_cqe_handler are unnecessary.

> +}
> +
> +/**
> + * Distribute ring queues across FUSE queues using round-robin algorithm.

Hm, if this function distributes (u)ring queues, then what is
fuse_distribute_ring_queues() doing? Is the term overloaded with two
meanings?

> + * This ensures even distribution of kernel ring queues across user-specified
> + * FUSE queues.
> + */
> +static
> +FuseRingQueueManager *fuse_ring_queue_manager_create(int num_fuse_queues,
> +                                                    size_t ring_queue_depth,
> +                                                    size_t bufsize)

The right style here would be something like:

static FuseRingQueueManager *
fuse_ring_queue_manager_create(int num_fuse_queues,
                               size_t ring_queue_depth,
                               size_t bufsize)

Given that I said that there is no reason to call the set of all queues
a manager, or to even have it separate from FuseExport, this probably
becomes fuse_uring_setup_queues() or something.

> +{
> +    int num_ring_queues = get_nprocs();

This could use a comment saying that this is a kernel requirement at the
moment.

> +    FuseRingQueueManager *manager = g_new(FuseRingQueueManager, 1);
> +
> +    if (!manager) {
> +        return NULL;
> +    }

g_new() never returns NULL, it aborts on error instead, so no reason to
have a NULL check here.

> +
> +    manager->ring_queues = g_new(FuseRingQueue, num_ring_queues);
> +    manager->num_ring_queues = num_ring_queues;
> +    manager->num_fuse_queues = num_fuse_queues;
> +
> +    if (!manager->ring_queues) {
> +        g_free(manager);
> +        return NULL;
> +    }

This check is unnecessary for the same reason.

> +
> +    for (int i = 0; i < num_ring_queues; i++) {
> +        FuseRingQueue *rq = &manager->ring_queues[i];
> +        rq->rqid = i;
> +        rq->ent = g_new(FuseRingEnt, ring_queue_depth);
> +
> +        if (!rq->ent) {
> +            for (int j = 0; j < i; j++) {
> +                g_free(manager->ring_queues[j].ent);
> +            }
> +            g_free(manager->ring_queues);
> +            g_free(manager);
> +            return NULL;
> +        }

This one, too.

> +
> +        for (size_t j = 0; j < ring_queue_depth; j++) {
> +            FuseRingEnt *ent = &rq->ent[j];
> +            ent->rq = rq;
> +            ent->req_payload_sz = bufsize - FUSE_BUFFER_HEADER_SIZE;
> +            ent->op_payload = g_malloc0(ent->req_payload_sz);
> +
> +            if (!ent->op_payload) {
> +                for (size_t k = 0; k < j; k++) {
> +                    g_free(rq->ent[k].op_payload);
> +                }
> +                g_free(rq->ent);
> +                for (int k = 0; k < i; k++) {
> +                    g_free(manager->ring_queues[k].ent);
> +                }
> +                g_free(manager->ring_queues);
> +                g_free(manager);
> +                return NULL;
> +            }

And this one.

Removing all of them will make the function a lot more readable.

> +
> +            ent->iov[0] = (struct iovec) {
> +                &(ent->req_header),

Unnecessary parentheses.

> +                sizeof(struct fuse_uring_req_header)
> +            };
> +            ent->iov[1] = (struct iovec) {
> +                ent->op_payload,
> +                ent->req_payload_sz
> +            };
> +
> +            ent->fuse_cqe_handler.cb = fuse_uring_cqe_handler;
> +        }
> +    }
> +
> +    return manager;
> +}
> +
> +static
> +void fuse_distribute_ring_queues(FuseExport *exp, FuseRingQueueManager *manager)
> +{
> +    int queue_index = 0;
> +
> +    for (int i = 0; i < manager->num_ring_queues; i++) {
> +        FuseRingQueue *rq = &manager->ring_queues[i];
> +
> +        rq->q = &exp->queues[queue_index];
> +        QLIST_INSERT_HEAD(&(rq->q->ring_queue_list), rq, next);
> +
> +        queue_index = (queue_index + 1) % manager->num_fuse_queues;
> +    }
> +}

Ok, no overloaded meaning of distributing queues, but this function
should probably be merged with the one above. It's part of setting up
the queues.

You don't need a separate queue_index counter, you can just directly use
exp->queues[i % manager->num_fuse_queues].

> +static
> +void fuse_schedule_ring_queue_registrations(FuseExport *exp,
> +                                            FuseRingQueueManager *manager)

Again the formatting. If you split the line before the function name, it
should be "static void" on the first line.

> +{
> +    for (int i = 0; i < manager->num_fuse_queues; i++) {
> +        FuseQueue *q = &exp->queues[i];
> +        FuseRingQueue *rq;
> +
> +        QLIST_FOREACH(rq, &q->ring_queue_list, next) {
> +            for (int j = 0; j < exp->ring_queue_depth; j++) {
> +                aio_bh_schedule_oneshot(q->ctx, fuse_uring_submit_register,
> +                                        &(rq->ent[j]));
> +            }
> +        }
> +    }
> +}

Why one BH per queue entry? This adds up quickly. All entries of the
same queue need to be processed in the same AioContext, so wouldn't it
make more sense to have a BH per (FUSE) queue and handle all of its
uring queues and their entries in a single BH?

> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
> +{
> +    /*
> +     * Since we didn't enable the FUSE_MAX_PAGES feature, the value of
> +     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which is set by
> +     * the kernel by default. Also, max_write should not exceed
> +     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
> +     */
> +    size_t bufsize = out->max_write + FUSE_BUFFER_HEADER_SIZE;
> +
> +    if (!(out->flags & FUSE_MAX_PAGES)) {
> +        bufsize = FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_page_size()
> +                         + FUSE_BUFFER_HEADER_SIZE;
> +    }
> +
> +    exp->ring_queue_manager = fuse_ring_queue_manager_create(
> +        exp->num_queues, exp->ring_queue_depth, bufsize);
> +
> +    if (!exp->ring_queue_manager) {
> +        error_report("Failed to create ring queue manager");
> +        return;
> +    }
> +
> +    /* Distribute ring queues across FUSE queues using round-robin */
> +    fuse_distribute_ring_queues(exp, exp->ring_queue_manager);
> +
> +    fuse_schedule_ring_queue_registrations(exp, exp->ring_queue_manager);
> +}
> +#endif
> +
>  static int fuse_export_create(BlockExport *blk_exp,
>                                BlockExportOptions *blk_exp_args,
>                                AioContext *const *multithread,
> @@ -270,6 +505,11 @@ static int fuse_export_create(BlockExport *blk_exp,
>  
>      assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
>  
> +#ifdef CONFIG_LINUX_IO_URING
> +    exp->is_uring = args->io_uring;
> +    exp->ring_queue_depth = FUSE_DEFAULT_RING_QUEUE_DEPTH;
> +#endif
> +
>      if (multithread) {
>          /* Guaranteed by common export code */
>          assert(mt_count >= 1);
> @@ -283,6 +523,10 @@ static int fuse_export_create(BlockExport *blk_exp,
>                  .exp = exp,
>                  .ctx = multithread[i],
>                  .fuse_fd = -1,
> +#ifdef CONFIG_LINUX_IO_URING
> +                .ring_queue_list =
> +                    QLIST_HEAD_INITIALIZER(exp->queues[i].ring_queue_list),
> +#endif
>              };
>          }
>      } else {
> @@ -296,6 +540,10 @@ static int fuse_export_create(BlockExport *blk_exp,
>              .exp = exp,
>              .ctx = exp->common.ctx,
>              .fuse_fd = -1,
> +#ifdef CONFIG_LINUX_IO_URING
> +            .ring_queue_list =
> +                QLIST_HEAD_INITIALIZER(exp->queues[0].ring_queue_list),
> +#endif
>          };
>      }
>  
> @@ -685,17 +933,39 @@ static bool is_regular_file(const char *path, Error **errp)
>   */
>  static ssize_t coroutine_fn
>  fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
> -             uint32_t max_readahead, uint32_t flags)
> +             uint32_t max_readahead, const struct fuse_init_in *in)
>  {
> -    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
> +    uint64_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO
> +                                     | FUSE_INIT_EXT;
> +    uint64_t outargflags = 0;
> +    uint64_t inargflags = in->flags;
> +
> +    ssize_t ret = 0;
> +
> +    if (inargflags & FUSE_INIT_EXT) {
> +        inargflags = inargflags | (uint64_t) in->flags2 << 32;
> +    }
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (exp->is_uring) {
> +        if (inargflags & FUSE_OVER_IO_URING) {
> +            supported_flags |= FUSE_OVER_IO_URING;
> +        } else {
> +            exp->is_uring = false;
> +            ret = -ENODEV;

Add a 'goto out' here...

> +        }
> +    }
> +#endif
> +
> +    outargflags = inargflags & supported_flags;
>  
>      *out = (struct fuse_init_out) {
>          .major = FUSE_KERNEL_VERSION,
>          .minor = FUSE_KERNEL_MINOR_VERSION,
>          .max_readahead = max_readahead,
>          .max_write = FUSE_MAX_WRITE_BYTES,
> -        .flags = flags & supported_flags,
> -        .flags2 = 0,
> +        .flags = outargflags,
> +        .flags2 = outargflags >> 32,
>  
>          /* libfuse maximum: 2^16 - 1 */
>          .max_background = UINT16_MAX,
> @@ -717,7 +987,7 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
>          .map_alignment = 0,
>      };
> -    return sizeof(*out);
> +    return ret < 0 ? ret : sizeof(*out);

...and make this:

    ret = sizeof(*out);
out:
    return ret;

>  }
>  
>  /**
> @@ -1506,6 +1776,14 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
>          fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
>                                  out_data_buffer, ret);
>          qemu_vfree(out_data_buffer);
> +#ifdef CONFIG_LINUX_IO_URING
> +    /* Handle FUSE-over-io_uring initialization */
> +    if (unlikely(opcode == FUSE_INIT && exp->is_uring)) {
> +        struct fuse_init_out *out =
> +            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT(out_buf);
> +        fuse_uring_start(exp, out);
> +    }
> +#endif

A level of indentation was lost here.

>      } else {
>          fuse_write_response(q->fuse_fd, req_id, out_hdr,
>                              ret < 0 ? ret : 0,
> diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
> index 35ab2d7807..c5076101e0 100644
> --- a/docs/tools/qemu-storage-daemon.rst
> +++ b/docs/tools/qemu-storage-daemon.rst
> @@ -78,7 +78,7 @@ Standard options:
>  .. option:: --export [type=]nbd,id=<id>,node-name=<node-name>[,name=<export-name>][,writable=on|off][,bitmap=<name>]
>    --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=unix,addr.path=<socket-path>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
>    --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=fd,addr.str=<fd>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
> -  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto]
> +  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto][,io-uring=on|off]
>    --export [type=]vduse-blk,id=<id>,node-name=<node-name>,name=<vduse-name>[,writable=on|off][,num-queues=<num-queues>][,queue-size=<queue-size>][,logical-block-size=<block-size>][,serial=<serial-number>]
>  
>    is a block export definition. ``node-name`` is the block node that should be
> @@ -111,10 +111,11 @@ Standard options:
>    that enabling this option as a non-root user requires enabling the
>    user_allow_other option in the global fuse.conf configuration file.  Setting
>    ``allow-other`` to auto (the default) will try enabling this option, and on
> -  error fall back to disabling it.
> -
> -  The ``vduse-blk`` export type takes a ``name`` (must be unique across the host)
> -  to create the VDUSE device.
> +  error fall back to disabling it. Once ``io-uring`` is enabled (off by default),
> +  the FUSE-over-io_uring-related settings will be initialized to bypass the
> +  traditional /dev/fuse communication mechanism and instead use io_uring to
> +  handle FUSE operations. The ``vduse-blk`` export type takes a ``name``
> +  (must be unique across the host) to create the VDUSE device.
>    ``num-queues`` sets the number of virtqueues (the default is 1).
>    ``queue-size`` sets the virtqueue descriptor table size (the default is 256).
>  
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 9ae703ad01..37f2fc47e2 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -184,12 +184,15 @@
>  #     mount the export with allow_other, and if that fails, try again
>  #     without.  (since 6.1; default: auto)
>  #
> +# @io-uring: Use FUSE-over-io-uring.  (since 10.2; default: false)
> +#
>  # Since: 6.0
>  ##
>  { 'struct': 'BlockExportOptionsFuse',
>    'data': { 'mountpoint': 'str',
>              '*growable': 'bool',
> -            '*allow-other': 'FuseExportAllowOther' },
> +            '*allow-other': 'FuseExportAllowOther',
> +            '*io-uring': 'bool' },
>    'if': 'CONFIG_FUSE' }
>  
>  ##
> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
> index eb72561358..0cd4cd2b58 100644
> --- a/storage-daemon/qemu-storage-daemon.c
> +++ b/storage-daemon/qemu-storage-daemon.c
> @@ -107,6 +107,7 @@ static void help(void)
>  #ifdef CONFIG_FUSE
>  "  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>\n"
>  "           [,growable=on|off][,writable=on|off][,allow-other=on|off|auto]\n"
> +"           [,io-uring=on|off]"
>  "                         export the specified block node over FUSE\n"
>  "\n"
>  #endif /* CONFIG_FUSE */
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index d2433d1d99..68d3fe8e01 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -452,10 +452,13 @@ static const FDMonOps fdmon_io_uring_ops = {
>  void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
>  {
>      int ret;
> +    int flags;
>  
>      ctx->io_uring_fd_tag = NULL;
> +    flags = IORING_SETUP_SQE128;
>  
> -    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
> +    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES,
> +                            &ctx->fdmon_io_uring, flags);

The indentation is off here.

>      if (ret != 0) {
>          error_setg_errno(errp, -ret, "Failed to initialize io_uring");
>          return;

The change to fdmon-io_uring.c should be a separate patch. It's a
prerequisite for, but not directly part of io_uring support in FUSE.

Kevin


