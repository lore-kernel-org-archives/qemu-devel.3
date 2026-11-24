Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E48606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QT9yqW48
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVsvy-0005PG-Os; Tue, 24 Nov 2026 10:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xVsvu-0005P7-Ki
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:59:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xVsvs-0003N0-6R
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795535983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIBwKmmNgJ5NT11zU8MWRsri+kg6/Ec+wa4qjNiivxo=;
 b=QT9yqW480CJTEHm6Hd+Bwwkrg/KVSh/n5OHsnCpOGRENhFAmhcsWPDjkmRIfqemBCvPTtU
 tBobvvV51gsg60ZGoGIJeBi1Ehf95v2rbFuOIcaiCB5dRebTQWDgFgxSkPlU7Ey3L2xoOq
 2/mx9TMRzBHG0oPNNJsMzL0dM1pa+lg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-niF3TavuOmSKJLGfAbpxZw-1; Tue,
 24 Nov 2026 15:59:36 +0000
X-MC-Unique: niF3TavuOmSKJLGfAbpxZw-1
X-Mimecast-MFC-AGG-ID: niF3TavuOmSKJLGfAbpxZw_1795535975
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93948195DE6C; Tue, 24 Nov 2026 15:59:34 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B950195B3C4; Tue, 24 Nov 2026 15:59:33 +0000 (UTC)
Date: Tue, 24 Nov 2026 10:59:32 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Hongyan Xu <getshell@seu.edu.cn>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-12.0 v2] coroutine: Make yield_until_fd_readable()
 detach fd handler always
Message-ID: <20261124155932.GA1640366@shajnocz.csb>
References: <20261123133747.2571462-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123133747.2571462-1-peterx@redhat.com>
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

On Mon, Nov 23, 2026 at 08:37:47AM -0500, Peter Xu wrote:
> Hongyan reported a possible use-after-free of RDMA migration code:
> 
> https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn
> 
> The issue seems real, while this patch is a proposal to fix it in a simpler
> way, meanwhile it should be a problem to the yield_until_fd_readable()
> helper in general, so it should make more sense to be fixed there too.
> 
> The problem is about the use of the stack allocated FDYieldUntilData where
> we must make sure after yield_until_fd_readable() returns it's not used
> anywhere.  If the coroutine yielded can be entered from outside of this
> helper (fd_coroutine_enter()), then the aio handler might be installed even
> after yield_until_fd_readable() returns, and that makes the stack variable
> accessible by aio codd, even if stack gone.
> 
> Fix it by moving the aio handler removal outside the handler.
> 

Fixes: 923709896b1b ("migration: poll the cm event for destination qemu")

But it looks like additional fixes are necessary for commit 923709896b1b:

1. ram_load_precopy() -> aio_co_schedule() + qemu_coroutine_yield()

   rdma_cm_poll_handler() -> qemu_coroutine_enter() hits the "Co-routine
   was already scheduled" abort in qemu_aio_coroutine_enter() if called
   before the scheduled coroutine runs.

2. qio_channel_yield() asserts when qio_channel_rdma_readv() returns QIO_CHANNEL_ERR_BLOCK

   There is a code path in qio_channel_rdma_readv() that returns
   QIO_CHANNEL_ERR_BLOCK, causing qio_channel_yield() to be called. The
   problem here is that qemu_coroutine_enter() is not allowed at this
   yield point. You have to use qio_channel_wake_read() to interrupt the
   read.

> Reported-by: Hongyan Xu <getshell@seu.edu.cn>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Hongyan Xu <getshell@seu.edu.cn>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - Drop FDYieldUntilData altogether [Kevin]
> - Drop the comment, doesn't feel as helpful now [myself]
> ---
>  util/qemu-coroutine-io.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
> index 364f4d5abf..720d27d737 100644
> --- a/util/qemu-coroutine-io.c
> +++ b/util/qemu-coroutine-io.c
> @@ -65,28 +65,18 @@ qemu_co_send_recv(int sockfd, void *buf, size_t bytes, bool do_send)
>      return qemu_co_sendv_recvv(sockfd, &iov, 1, 0, bytes, do_send);
>  }
>  
> -typedef struct {
> -    AioContext *ctx;
> -    Coroutine *co;
> -    int fd;
> -} FDYieldUntilData;
> -
>  static void fd_coroutine_enter(void *opaque)
>  {
> -    FDYieldUntilData *data = opaque;
> -    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
> -    qemu_coroutine_enter(data->co);
> +    qemu_coroutine_enter((Coroutine *)opaque);
>  }
>  
>  void coroutine_fn yield_until_fd_readable(int fd)

Please update the doc comment in include/qemu/coroutine.h to say that
yield_until_fd_readable() may be interrupted by re-entering the
coroutine early and the function will return immediately. This behavior
is part of the API.

>  {
> -    FDYieldUntilData data;
> +    AioContext *ctx = qemu_get_current_aio_context();
>  
>      assert(qemu_in_coroutine());
> -    data.ctx = qemu_get_current_aio_context();
> -    data.co = qemu_coroutine_self();
> -    data.fd = fd;
> -    aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
> -                       &data);
> +    aio_set_fd_handler(ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
> +                       (void *)qemu_coroutine_self());
>      qemu_coroutine_yield();
> +    aio_set_fd_handler(ctx, fd, NULL, NULL, NULL, NULL, NULL);
>  }
> -- 
> 2.56.0
> 


