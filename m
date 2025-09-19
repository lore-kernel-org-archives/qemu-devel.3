Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9419CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbrm-0001Gu-8t; Fri, 19 Sep 2025 10:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uzbrj-0001EU-PR
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uzbrW-0007bv-CD
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758291197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8yBlx6AWejqtmZnbcKdWUy0N+QElBRZPElK9A17CF0=;
 b=f1ny111GdRvXuCHiQfQOkW8R2v5GqYoEQYYQdbkyrmiHW53CcD+3feQ4emsU9D7t7T7tO6
 UJTyTjQtS8mP/RYWPMJ6Ws96GYIhYTnjnFL+peLXT/BxOkNgXdIrCQz/Cn7qWOV32o+RdT
 qre9F9KIJ3jvc3FmObFf7/utS/QMTWQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-k2oW-r6YM_KIwekqlk4V7g-1; Fri,
 19 Sep 2025 10:13:16 -0400
X-MC-Unique: k2oW-r6YM_KIwekqlk4V7g-1
X-Mimecast-MFC-AGG-ID: k2oW-r6YM_KIwekqlk4V7g_1758291195
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C17F195608B; Fri, 19 Sep 2025 14:13:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A78EC1800451; Fri, 19 Sep 2025 14:13:10 +0000 (UTC)
Date: Fri, 19 Sep 2025 16:13:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 1/4] export/fuse: add opt to enable FUSE-over-io_uring
Message-ID: <aM1k86KI9PRkpSkv@redhat.com>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-2-hibriansong@gmail.com>
 <aMm1qc-JEa0FwkX3@redhat.com>
 <f36a42af-4194-4563-a1a5-0c403e678d0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36a42af-4194-4563-a1a5-0c403e678d0c@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 17.09.2025 um 21:47 hat Brian Song geschrieben:
> 
> 
> On 9/16/25 3:08 PM, Kevin Wolf wrote:
> > Am 30.08.2025 um 04:50 hat Brian Song geschrieben:
> > > This patch adds a new export option for storage-export-daemon to enable
> > > FUSE-over-io_uring via the switch io-uring=on|off (disableby default).
> > > It also implements the protocol handshake with the Linux kernel
> > > during the FUSE-over-io_uring initialization phase.
> > > 
> > > See: https://docs.kernel.org/filesystems/fuse-io-uring.html
> > > 
> > > The kernel documentation describes in detail how FUSE-over-io_uring
> > > works. This patch implements the Initial SQE stage shown in thediagram:
> > > it initializes one queue per IOThread, each currently supporting a
> > > single submission queue entry (SQE). When the FUSE driver sends the
> > > first FUSE request (FUSE_INIT), storage-export-daemon calls
> > > fuse_uring_start() to complete initialization, ultimately submitting
> > > the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
> > > successful initialization with the kernel.
> > > 
> > > We also added support for multiple IOThreads. The current Linux kernel
> > > requires registering $(nproc) queues when setting up FUSE-over-io_uring
> > > To let users customize the number of FUSE Queues (i.e., IOThreads),
> > > we first create nproc Ring Queues as required by the kernel, then
> > > distribute them in a round-robin manner to the FUSE Queues for
> > > registration. In addition, to support multiple in-flight requests,
> > > we configure each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH
> > > entries/requests.
> > > 
> > > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Brian Song <hibriansong@gmail.com>
> > > ---
> > >   block/export/fuse.c                  | 310 +++++++++++++++++++++++++--
> > >   docs/tools/qemu-storage-daemon.rst   |  11 +-
> > >   qapi/block-export.json               |   5 +-
> > >   storage-daemon/qemu-storage-daemon.c |   1 +
> > >   util/fdmon-io_uring.c                |   5 +-
> > >   5 files changed, 309 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/block/export/fuse.c b/block/export/fuse.c
> > > index c0ad4696ce..19bf9e5f74 100644
> > > --- a/block/export/fuse.c
> > > +++ b/block/export/fuse.c
> > > @@ -48,6 +48,9 @@
> > >   #include <linux/fs.h>
> > >   #endif
> > > +/* room needed in buffer to accommodate header */
> > > +#define FUSE_BUFFER_HEADER_SIZE 0x1000
> > > +
> > >   /* Prevent overly long bounce buffer allocations */
> > >   #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
> > >   /*
> > > @@ -63,12 +66,59 @@
> > >       (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
> > >   typedef struct FuseExport FuseExport;
> > > +typedef struct FuseQueue FuseQueue;
> > > +
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +#define FUSE_DEFAULT_RING_QUEUE_DEPTH 64
> > > +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
> > 
> > Maybe it would be a little clearer if the next few types has URing in
> > their name instead of just Ring.
> > 
> > > +typedef struct FuseRingQueue FuseRingQueue;
> > > +typedef struct FuseRingEnt {
> > > +    /* back pointer */
> > > +    FuseRingQueue *rq;
> > > +
> > > +    /* commit id of a fuse request */
> > > +    uint64_t req_commit_id;
> > > +
> > > +    /* fuse request header and payload */
> > > +    struct fuse_uring_req_header req_header;
> > > +    void *op_payload;
> > > +    size_t req_payload_sz;
> > > +
> > > +    /* The vector passed to the kernel */
> > > +    struct iovec iov[2];
> > > +
> > > +    CqeHandler fuse_cqe_handler;
> > > +} FuseRingEnt;
> > > +
> > > +struct FuseRingQueue {
> > 
> > It would be good to have a comment here that explains the difference
> > between FuseQueue and FuseRingQueue.
> > 
> > Is this a distinction that should remain in the long run or would we
> > always have a 1:1 mapping between FuseQueue and FuseRingQueue once the
> > pending kernel changes are merged that allow a number of uring queues
> > different from the number of CPUs?
> 
> Stefan mentioned the issue, and I added some comments here. One thing to
> note is that FuseRingQueueManager and the distribution between FuseQueue and
> FuseRingQueue are just temporary measures until the kernel allows
> user-defined queues. Therefore, I don't think it's a good idea to remove
> FuseRingQueueManager at this stage.

I don't think that simplifying the code now will make it harder to make
these changes in the future, so I'd really prefer to keep e.g. all of
the queue setup in a single place even if we expect part of it to go
away in the long run.

> If you look back at the v2 patch, we put the ring entries inside the
> FuseQueue. The result was that we had to define nproc IOThreads (FuseQueue)
> in order to make it work. That's why here I separated the numbers of the two
> types of queues and RingQueue into independent abstractions: allocate nproc
> RingQueues and initialize the entries, then distribute them to FuseQueues in
> a round-robin manner. Once the kernel supports a user-defined number of
> queues, we can remove FuseRingQueueManager and the RR distribution.

Right, I'm not requesting that you change the mechanism per se. I'd just
like to see it more integrated with the rest. Additional functions and
structs can be helpful if they allow you to separate out self-contained
logic, but that's not the case here. Here it's just one additional
moving part that you have to understand when reading the code, which
makes it a little more complex and harder to read than necessary.

> Also, to keep the variable names consistent with those in the kernel and
> libfuse, I use Ring here instead of URing.

Yes, I can see that. The difference is that there, the types are
contained in a separate source file that handles only io_uring, so the
context is clear.

In QEMU's FUSE export, we're still mixing /dev/fuse code and io_uring
code in a single file, so it's a bit more confusing which name refers to
which.

But alternatively, we can also split the source file in QEMU. At almost
2000 lines of code, that might be a good idea anyway.

> > > +    int rqid;
> > > +
> > > +    /* back pointer */
> > > +    FuseQueue *q;
> > > +    FuseRingEnt *ent;
> > > +
> > > +    /* List entry for ring_queues */
> > > +    QLIST_ENTRY(FuseRingQueue) next;
> > > +};
> > > +
> > > +/*
> > > + * Round-robin distribution of ring queues across FUSE queues.
> > > + * This structure manages the mapping between kernel ring queues and user
> > > + * FUSE queues.
> > > + */
> > > +typedef struct FuseRingQueueManager {
> > > +    FuseRingQueue *ring_queues;
> > > +    int num_ring_queues;
> > > +    int num_fuse_queues;
> > > +} FuseRingQueueManager;
> > 
> > This isn't a manager, it's just the set of queues the export uses.
> > 
> > num_fuse_queues duplicates exp->num_queues, there is no reason for it to
> > exist. All users also have access to the FuseExport itself.
> > 
> > The other two fields can just be merged directly into FuseExport,
> > preferably renamed to uring_queues and num_uring_queues.
> > >> +#endif
> > >   /*
> > >    * One FUSE "queue", representing one FUSE FD from which requests are fetched
> > >    * and processed.  Each queue is tied to an AioContext.
> > >    */
> > > -typedef struct FuseQueue {
> > > +struct FuseQueue {
> > >       FuseExport *exp;
> > >       AioContext *ctx;
> > > @@ -109,15 +159,11 @@ typedef struct FuseQueue {
> > >        * Free this buffer with qemu_vfree().
> > >        */
> > >       void *spillover_buf;
> > > -} FuseQueue;
> > > -/*
> > > - * Verify that FuseQueue.request_buf plus the spill-over buffer together
> > > - * are big enough to be accepted by the FUSE kernel driver.
> > > - */
> > > -QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
> > > -                  FUSE_SPILLOVER_BUF_SIZE <
> > > -                  FUSE_MIN_READ_BUFFER);
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +    QLIST_HEAD(, FuseRingQueue) ring_queue_list;
> > > +#endif
> > > +};
> > >   struct FuseExport {
> > >       BlockExport common;
> > > @@ -133,7 +179,7 @@ struct FuseExport {
> > >        */
> > >       bool halted;
> > > -    int num_queues;
> > > +    size_t num_queues;
> > 
> > I'm not sure why this change is needed. If it is, can it be a separate
> > patch before this one, with a commit message describing the reason?
> 
> I feel there's no reason to use a signed int here, since the number of
> queues cannot be negative.

So it's unrelated to what the commit message promises, right? ("add opt
to enable FUSE-over-io_uring"). You can make it a separate cleanup patch
then.

> > >       FuseQueue *queues;
> > >       /*
> > >        * True if this export should follow the generic export's AioContext.
> > > @@ -149,6 +195,12 @@ struct FuseExport {
> > >       /* Whether allow_other was used as a mount option or not */
> > >       bool allow_other;
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +    bool is_uring;
> > > +    size_t ring_queue_depth;
> > > +    FuseRingQueueManager *ring_queue_manager;
> > > +#endif
> > > +
> > >       mode_t st_mode;
> > >       uid_t st_uid;
> > >       gid_t st_gid;
> > > @@ -205,7 +257,7 @@ static void fuse_attach_handlers(FuseExport *exp)
> > >           return;
> > >       }
> > > -    for (int i = 0; i < exp->num_queues; i++) {
> > > +    for (size_t i = 0; i < exp->num_queues; i++) {
> > >           aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
> > >                              read_from_fuse_fd, NULL, NULL, NULL,
> > >                              &exp->queues[i]);
> > > @@ -257,6 +309,189 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
> > >       .drained_poll  = fuse_export_drained_poll,
> > >   };
> > > +#ifdef CONFIG_LINUX_IO_URING
> > > +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
> > > +                    const unsigned int rqid,
> > > +                    const unsigned int commit_id)
> > 
> > Indentation is off here. There are two accepted styles for indentation
> > after breaking a long line in QEMU (see docs/devel/style.rst):
> > 
> > 1. Indent the next line by exactly four spaces:
> > 
> >      do_something(x, y,
> >          z);
> > 
> > 2. Align the next line with the first character after the opening
> >     parenthesis:
> > 
> >      do_something(x, y,
> >                   z);
> > 
> > The second one is the preferred one. The first one is generally only
> > used when the parenthesis is already too far right and we can't do much
> > about it.
> > 
> > > +{
> > > +    req->qid = rqid;
> > > +    req->commit_id = commit_id;
> > > +    req->flags = 0;
> > > +}
> > > +
> > > +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
> > > +               __u32 cmd_op)
> > 
> > Indentation.
> > 
> > Another option here is to keep everything before the function name on a
> > separate line, like this:
> > 
> > static void
> > fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q, __u32 cmd_op)
> > 
> > This would allow the second line to stay under 80 characters.
> > 
> > > +{
> > > +    sqe->opcode = IORING_OP_URING_CMD;
> > > +
> > > +    sqe->fd = q->fuse_fd;
> > > +    sqe->rw_flags = 0;
> > > +    sqe->ioprio = 0;
> > > +    sqe->off = 0;
> > > +
> > > +    sqe->cmd_op = cmd_op;
> > > +    sqe->__pad1 = 0;
> > > +}
> > > +
> > > +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
> > > +{
> > > +    FuseRingEnt *ent = opaque;
> > > +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
> > > +
> > > +    fuse_uring_sqe_prepare(sqe, ent->rq->q, FUSE_IO_URING_CMD_REGISTER);
> > > +
> > > +    sqe->addr = (uint64_t)(ent->iov);
> > > +    sqe->len = 2;
> > > +
> > > +    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
> > > +}
> > > +
> > > +static void fuse_uring_submit_register(void *opaque)
> > > +{
> > > +    FuseRingEnt *ent = opaque;
> > > +    FuseExport *exp = ent->rq->q->exp;
> > > +
> > > +
> > 
> > Extra empty line.
> > 
> > > +    aio_add_sqe(fuse_uring_prep_sqe_register, ent, &(ent->fuse_cqe_handler));
> > 
> > The parentheses around ent->fuse_cqe_handler are unnecessary.
> > 
> > > +}
> > > +
> > > +/**
> > > + * Distribute ring queues across FUSE queues using round-robin algorithm.
> > 
> > Hm, if this function distributes (u)ring queues, then what is
> > fuse_distribute_ring_queues() doing? Is the term overloaded with two
> > meanings?
> > 
> > > + * This ensures even distribution of kernel ring queues across user-specified
> > > + * FUSE queues.
> > > + */
> > > +static
> > > +FuseRingQueueManager *fuse_ring_queue_manager_create(int num_fuse_queues,
> > > +                                                    size_t ring_queue_depth,
> > > +                                                    size_t bufsize)
> > 
> > The right style here would be something like:
> > 
> > static FuseRingQueueManager *
> > fuse_ring_queue_manager_create(int num_fuse_queues,
> >                                 size_t ring_queue_depth,
> >                                 size_t bufsize)
> > 
> > Given that I said that there is no reason to call the set of all queues
> > a manager, or to even have it separate from FuseExport, this probably
> > becomes fuse_uring_setup_queues() or something.
> > 
> > > +{
> > > +    int num_ring_queues = get_nprocs();
> > 
> > This could use a comment saying that this is a kernel requirement at the
> > moment.
> > 
> > > +    FuseRingQueueManager *manager = g_new(FuseRingQueueManager, 1);
> > > +
> > > +    if (!manager) {
> > > +        return NULL;
> > > +    }
> > 
> > g_new() never returns NULL, it aborts on error instead, so no reason to
> > have a NULL check here.
> > 
> > > +
> > > +    manager->ring_queues = g_new(FuseRingQueue, num_ring_queues);
> > > +    manager->num_ring_queues = num_ring_queues;
> > > +    manager->num_fuse_queues = num_fuse_queues;
> > > +
> > > +    if (!manager->ring_queues) {
> > > +        g_free(manager);
> > > +        return NULL;
> > > +    }
> > 
> > This check is unnecessary for the same reason.
> > 
> > > +
> > > +    for (int i = 0; i < num_ring_queues; i++) {
> > > +        FuseRingQueue *rq = &manager->ring_queues[i];
> > > +        rq->rqid = i;
> > > +        rq->ent = g_new(FuseRingEnt, ring_queue_depth);
> > > +
> > > +        if (!rq->ent) {
> > > +            for (int j = 0; j < i; j++) {
> > > +                g_free(manager->ring_queues[j].ent);
> > > +            }
> > > +            g_free(manager->ring_queues);
> > > +            g_free(manager);
> > > +            return NULL;
> > > +        }
> > 
> > This one, too.
> > 
> > > +
> > > +        for (size_t j = 0; j < ring_queue_depth; j++) {
> > > +            FuseRingEnt *ent = &rq->ent[j];
> > > +            ent->rq = rq;
> > > +            ent->req_payload_sz = bufsize - FUSE_BUFFER_HEADER_SIZE;
> > > +            ent->op_payload = g_malloc0(ent->req_payload_sz);
> > > +
> > > +            if (!ent->op_payload) {
> > > +                for (size_t k = 0; k < j; k++) {
> > > +                    g_free(rq->ent[k].op_payload);
> > > +                }
> > > +                g_free(rq->ent);
> > > +                for (int k = 0; k < i; k++) {
> > > +                    g_free(manager->ring_queues[k].ent);
> > > +                }
> > > +                g_free(manager->ring_queues);
> > > +                g_free(manager);
> > > +                return NULL;
> > > +            }
> > 
> > And this one.
> > 
> > Removing all of them will make the function a lot more readable.
> > 
> > > +
> > > +            ent->iov[0] = (struct iovec) {
> > > +                &(ent->req_header),
> > 
> > Unnecessary parentheses.
> > 
> > > +                sizeof(struct fuse_uring_req_header)
> > > +            };
> > > +            ent->iov[1] = (struct iovec) {
> > > +                ent->op_payload,
> > > +                ent->req_payload_sz
> > > +            };
> > > +
> > > +            ent->fuse_cqe_handler.cb = fuse_uring_cqe_handler;
> > > +        }
> > > +    }
> > > +
> > > +    return manager;
> > > +}
> > > +
> > > +static
> > > +void fuse_distribute_ring_queues(FuseExport *exp, FuseRingQueueManager *manager)
> > > +{
> > > +    int queue_index = 0;
> > > +
> > > +    for (int i = 0; i < manager->num_ring_queues; i++) {
> > > +        FuseRingQueue *rq = &manager->ring_queues[i];
> > > +
> > > +        rq->q = &exp->queues[queue_index];
> > > +        QLIST_INSERT_HEAD(&(rq->q->ring_queue_list), rq, next);
> > > +
> > > +        queue_index = (queue_index + 1) % manager->num_fuse_queues;
> > > +    }
> > > +}
> > 
> > Ok, no overloaded meaning of distributing queues, but this function
> > should probably be merged with the one above. It's part of setting up
> > the queues.
> > 
> > You don't need a separate queue_index counter, you can just directly use
> > exp->queues[i % manager->num_fuse_queues].
> > 
> 
> There are two steps:
> 
> 1. Create uring queues and allocate buffers for each entry's payload.
> 
> 2. Distribute these uring queues to FUSE queues using a round-robin
> algorithm.
> 
> Given that this is only a temporary measure to allow users to define their
> own IOThreads/FUSE queues, we might later replace the second part of the
> logic. I believe it's better to separate these two pieces of logic rather
> than combining them.

But one of them doesn't make sense without the other currently. Looping
twice over all queues and doing half of their setup is harder to
understand than having a single loop and doing all of the setup.

You're right that we hope that the second half goes away eventually, but
we don't know if or when someone will actually do this. We shouldn't
structure our code so that it may make sense some time in the future if
someone extends it in the way we envision now, but so that it makes
sense and is easy to understand now.

Kevin


