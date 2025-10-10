Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF39CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7G4G-0001B1-UD; Fri, 10 Oct 2025 12:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v7G4E-0001AF-LB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v7G45-0008SD-Ij
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760114035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K7AIhbAJqO/829X4D014/CHO6xh8D/I6myRXwqtt09o=;
 b=LXjouX2urs17qtvv2iJ+Gi3l/+rfign3rnxzZwvXUWwuzQrA6rojXi3NQKgpsq9LKJz7OL
 4IAk36hNqUoyz4KS1AtjIPLsFF7C96oJh4BLiy8rBQa000c58+yGparuEWV4ilR3ZFUx2e
 R/ZmgmCFlE3mDCV/9DmjBU1QRvx6s20=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-KM8eVfJRM6CYq-TBOz8iOQ-1; Fri,
 10 Oct 2025 12:33:49 -0400
X-MC-Unique: KM8eVfJRM6CYq-TBOz8iOQ-1
X-Mimecast-MFC-AGG-ID: KM8eVfJRM6CYq-TBOz8iOQ_1760114028
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F5A119560B5; Fri, 10 Oct 2025 16:33:47 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.92])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC5741800576; Fri, 10 Oct 2025 16:33:43 +0000 (UTC)
Date: Fri, 10 Oct 2025 18:33:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 12/12] block/io_uring: use non-vectored read/write
 when possible
Message-ID: <aOk1ZEmEIIXDfXpf@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-13-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910175703.374499-13-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 10.09.2025 um 19:57 hat Stefan Hajnoczi geschrieben:
> The io_uring_prep_readv2/writev2() man pages recommend using the
> non-vectored read/write operations when possible for performance
> reasons.
> 
> I didn't measure a significant difference but it doesn't hurt to have
> this optimization in place.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/io_uring.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/block/io_uring.c b/block/io_uring.c
> index dd930ee57e..bbefbddcc0 100644
> --- a/block/io_uring.c
> +++ b/block/io_uring.c
> @@ -49,12 +49,24 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
>  #ifdef HAVE_IO_URING_PREP_WRITEV2
>      {
>          int luring_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
> -        io_uring_prep_writev2(sqe, fd, qiov->iov,
> -                              qiov->niov, offset, luring_flags);
> +        if (luring_flags != 0 || qiov->niov > 1) {
> +            io_uring_prep_writev2(sqe, fd, qiov->iov,
> +                                  qiov->niov, offset, luring_flags);
> +        } else {
> +            /* The man page says non-vectored is faster than vectored */
> +            struct iovec *iov = qiov->iov;
> +            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, offset);
> +        }
>      }
>  #else
>          assert(flags == 0);
> -        io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
> +        if (qiov->niov > 1) {
> +            io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
> +        } else {
> +            /* The man page says non-vectored is faster than vectored */
> +            struct iovec *iov = qiov->iov;
> +            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, offset);
> +        }
>  #endif

We have a lot of duplication in this now. Let's use the #ifdef a little
more locally:

    {
        int luring_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
        if (luring_flags != 0 || qiov->niov > 1) {
#ifdef HAVE_IO_URING_PREP_WRITEV2
            io_uring_prep_writev2(sqe, fd, qiov->iov,
                                  qiov->niov, offset, luring_flags);
#else
            assert(luring_flags == 0);
            io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
#endif
        } else {
            /* The man page says non-vectored is faster than vectored */
            struct iovec *iov = qiov->iov;
            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, offset);
        }
    }

Kevin


