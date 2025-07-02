Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0524BC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwIv-0001bm-6I; Wed, 02 Jul 2025 08:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWwIu-0001bX-4y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWwIn-0004gl-ST
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751458258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YnhrzkU5vZ7tGM0aDBqmL79oz9iz1TPWWmJimRwsUPo=;
 b=OvPsxtIMy4AndUysIX+LNlSLWuY3MHbq1yfDw8qYVB6TmJelJOybfW3zG+y3KzMP52BWoC
 aL1M9Fsb2amp6bF58uJZQ9CKRaVZ1bQ+SRq15cC+6mRB3fr8vu/HVCvKPervG7LeejfDYA
 CkYSmTPem99KCQoMCPBulThOX8ggjMo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-7h0qnEr-NuKtn2-lC0EiFw-1; Wed,
 02 Jul 2025 08:10:57 -0400
X-MC-Unique: 7h0qnEr-NuKtn2-lC0EiFw-1
X-Mimecast-MFC-AGG-ID: 7h0qnEr-NuKtn2-lC0EiFw_1751458252
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E39A7195F175; Wed,  2 Jul 2025 12:10:51 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.171])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 256E318003FC; Wed,  2 Jul 2025 12:10:47 +0000 (UTC)
Date: Wed, 2 Jul 2025 14:10:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, eblake@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>, hibriansong@gmail.com
Subject: Re: [PATCH v2 01/12] aio-posix: fix race between io_uring CQE and
 AioHandler deletion
Message-ID: <aGUhxUhGk7dx4fd-@redhat.com>
References: <20250620000829.1426291-1-stefanha@redhat.com>
 <20250620000829.1426291-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620000829.1426291-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 20.06.2025 um 02:08 hat Stefan Hajnoczi geschrieben:
> When an AioHandler is enqueued on ctx->submit_list for removal, the
> fill_sq_ring() function will submit an io_uring POLL_REMOVE operation to
> cancel the in-flight POLL_ADD operation.
> 
> There is a race when another thread enqueues an AioHandler for deletion
> on ctx->submit_list when the POLL_ADD CQE has already appeared. In that
> case POLL_REMOVE is unnecessary. The code already handled this, but
> forgot that the AioHandler itself is still on ctx->submit_list when the
> POLL_ADD CQE is being processed. It's unsafe to delete the AioHandler at
> that point in time (use-after-free).
> 
> Solve this problem by keeping the AioHandler alive but setting a flag so
> that it will be deleted by fill_sq_ring() when it runs.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index b0d68bdc44..2e40fff09a 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -52,9 +52,10 @@ enum {
>      FDMON_IO_URING_ENTRIES  = 128, /* sq/cq ring size */
>  
>      /* AioHandler::flags */
> -    FDMON_IO_URING_PENDING  = (1 << 0),
> -    FDMON_IO_URING_ADD      = (1 << 1),
> -    FDMON_IO_URING_REMOVE   = (1 << 2),
> +    FDMON_IO_URING_PENDING            = (1 << 0),
> +    FDMON_IO_URING_ADD                = (1 << 1),
> +    FDMON_IO_URING_REMOVE             = (1 << 2),
> +    FDMON_IO_URING_DELETE_AIO_HANDLER = (1 << 3),
>  };
>  
>  static inline int poll_events_from_pfd(int pfd_events)
> @@ -218,6 +219,9 @@ static void fill_sq_ring(AioContext *ctx)
>          if (flags & FDMON_IO_URING_REMOVE) {
>              add_poll_remove_sqe(ctx, node);
>          }
> +        if (flags & FDMON_IO_URING_DELETE_AIO_HANDLER) {
> +            QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
> +        }
>      }
>  }

Why is it safe to add new SQEs for the node and then add it to
ctx->deleted_aio_handlers without waiting for the CQEs first?  I
expected this to be the first check in the loop iteration and to
contain a 'continue;' statement.

The POLL_REMOVE case is clear when looking at more context, it doesn't
pass the node. As for POLL_ADD, I suppose both flags are actually never
set together in practice because FDMON_IO_URING_DELETE_AIO_HANDLER is
only set when processing the CQE of POLL_ADD, so no new POLL_ADD for the
same node will be pending yet. And checking the callers, I see that
adding is only ever done with newly allocated nodes, so something like
removing and re-adding the same node doesn't happen either.

Could we then assert that FDMON_IO_URING_DELETE_AIO_HANDLER is never
combined with FDMON_IO_URING_ADD, but always with FDMON_IO_URING_REMOVE,
to make the assumptions more explicit?

> @@ -347,10 +356,13 @@ void fdmon_io_uring_destroy(AioContext *ctx)
>              unsigned flags = qatomic_fetch_and(&node->flags,
>                      ~(FDMON_IO_URING_PENDING |
>                        FDMON_IO_URING_ADD |
> -                      FDMON_IO_URING_REMOVE));
> +                      FDMON_IO_URING_REMOVE |
> +                      FDMON_IO_URING_DELETE_AIO_HANDLER));
>  
> -            if (flags & FDMON_IO_URING_REMOVE) {
> -                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
> +            if ((flags & FDMON_IO_URING_REMOVE) ||
> +                (flags & FDMON_IO_URING_DELETE_AIO_HANDLER)) {

If my conclusion above is right, FDMON_IO_URING_REMOVE will be set in
both cases, so checking FDMON_IO_URING_DELETE_AIO_HANDLER is redundant.
Maybe assert this, too, when setting FDMON_IO_URING_DELETE_AIO_HANDLER.

> +                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers,
> +                                      node, node_deleted);
>              }
>  
>              QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);

Kevin


