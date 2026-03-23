Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B05F483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iGP-00054F-Jl; Mon, 23 Mar 2026 12:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4iGK-00053N-19
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4iGI-0004r0-7i
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774283776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIkbjBHjvn8E76gPlCC8uOvatQxjMWJmWzMeWl472RU=;
 b=iCUZ1OB0f+gW8aOj6+mW66thv/HJYk025S++XJxyMxg4Jj7zHK52wzv02WGZyS0GkdUE+H
 EYhdMKPMX20wuyNFaoIXOfZPcANUgQOwc/pMkg9kebKlSVU4DEfspbD2eNVHjVqZseGB3j
 v1u759lf6RNk0GgpxIFDp0/4udr3CE8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-8x7UaTg4O4Sjc_Ym6yr8BA-1; Mon,
 23 Mar 2026 12:36:12 -0400
X-MC-Unique: 8x7UaTg4O4Sjc_Ym6yr8BA-1
X-Mimecast-MFC-AGG-ID: 8x7UaTg4O4Sjc_Ym6yr8BA_1774283771
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93B7719560B4; Mon, 23 Mar 2026 16:36:11 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.184])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99BD5300019F; Mon, 23 Mar 2026 16:36:09 +0000 (UTC)
Date: Mon, 23 Mar 2026 17:36:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH for-11.0 1/3] linux-aio: Put all parameters into
 qemu_laiocb
Message-ID: <acFqulONusPdbQHY@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
 <20260318153206.171494-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318153206.171494-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 18.03.2026 um 16:32 hat Hanna Czenczek geschrieben:
> Put all request parameters into the qemu_laiocb struct, which will allow
> re-submitting the tail of short reads/writes.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/linux-aio.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/block/linux-aio.c b/block/linux-aio.c
> index 53c3e9af8a..1f25339dc9 100644
> --- a/block/linux-aio.c
> +++ b/block/linux-aio.c
> @@ -40,10 +40,15 @@ struct qemu_laiocb {
>      Coroutine *co;
>      LinuxAioState *ctx;
>      struct iocb iocb;
> +    int fd;
>      ssize_t ret;
> +    off_t offset;
>      size_t nbytes;
>      QEMUIOVector *qiov;
> -    bool is_read;
> +
> +    int type;

If you put fd and type next to each other, you'd avoid a hole in the
struct.

> +    BdrvRequestFlags flags;
> +    uint64_t dev_max_batch;
>      QSIMPLEQ_ENTRY(qemu_laiocb) next;
>  };
>  
> @@ -87,7 +92,7 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
>              ret = 0;
>          } else if (ret >= 0) {
>              /* Short reads mean EOF, pad with zeros. */
> -            if (laiocb->is_read) {
> +            if (laiocb->type == QEMU_AIO_READ) {
>                  qemu_iovec_memset(laiocb->qiov, ret, 0,
>                      laiocb->qiov->size - ret);
>              } else {
> @@ -367,23 +372,23 @@ static void laio_deferred_fn(void *opaque)
>      }
>  }
>  
> -static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
> -                          int type, BdrvRequestFlags flags,
> -                          uint64_t dev_max_batch)
> +static int laio_do_submit(struct qemu_laiocb *laiocb)
>  {
>      LinuxAioState *s = laiocb->ctx;
>      struct iocb *iocbs = &laiocb->iocb;
>      QEMUIOVector *qiov = laiocb->qiov;
> +    int fd = laiocb->fd;
> +    off_t offset = laiocb->offset;
>  
> -    switch (type) {
> +    switch (laiocb->type) {
>      case QEMU_AIO_WRITE:
>  #ifdef HAVE_IO_PREP_PWRITEV2
>      {
> -        int laio_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
> +        int laio_flags = (laiocb->flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
>          io_prep_pwritev2(iocbs, fd, qiov->iov, qiov->niov, offset, laio_flags);
>      }
>  #else
> -        assert(flags == 0);
> +        assert(laiocb->flags == 0);
>          io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
>  #endif
>          break;
> @@ -399,7 +404,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
>      /* Currently Linux kernel does not support other operations */
>      default:
>          fprintf(stderr, "%s: invalid AIO request type 0x%x.\n",
> -                        __func__, type);
> +                        __func__, laiocb->type);
>          return -EIO;
>      }
>      io_set_eventfd(&laiocb->iocb, event_notifier_get_fd(&s->e));
> @@ -407,7 +412,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
>      QSIMPLEQ_INSERT_TAIL(&s->io_q.pending, laiocb, next);
>      s->io_q.in_queue++;
>      if (!s->io_q.blocked) {
> -        if (s->io_q.in_queue >= laio_max_batch(s, dev_max_batch)) {
> +        if (s->io_q.in_queue >= laio_max_batch(s, laiocb->dev_max_batch)) {
>              ioq_submit(s);
>          } else {
>              defer_call(laio_deferred_fn, s);
> @@ -425,14 +430,18 @@ int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
>      AioContext *ctx = qemu_get_current_aio_context();
>      struct qemu_laiocb laiocb = {
>          .co         = qemu_coroutine_self(),
> -        .nbytes     = qiov ? qiov->size : 0,
> +        .fd         = fd,
> +        .offset     = offset,
> +        .nbytes     = (qiov ? qiov->size : 0),

Adding parentheses around the expression seems both unrelated and
unnecessary.

>          .ctx        = aio_get_linux_aio(ctx),
>          .ret        = -EINPROGRESS,
> -        .is_read    = (type == QEMU_AIO_READ),
>          .qiov       = qiov,
> +        .type       = type,
> +        .flags      = flags,
> +        .dev_max_batch = dev_max_batch,
>      };
>  
> -    ret = laio_do_submit(fd, &laiocb, offset, type, flags, dev_max_batch);
> +    ret = laio_do_submit(&laiocb);
>      if (ret < 0) {
>          return ret;
>      }

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


