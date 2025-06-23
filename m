Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D0C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnyV-0004E0-Ja; Mon, 23 Jun 2025 16:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uTny2-0004Bh-Up
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uTny0-0007Hp-SW
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750711235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5WfDlh6oLa/hsPnbFUrpXBUJn7SwJaUhTExm6UmG10k=;
 b=byQQNCAOUUCLKsS9OnFzjk5xhnJDDBtGJx76Bh9FKMV6yI4CoO0TkDBHlX4qpF75Pzb6XE
 gSfr9wZb/UWOImmh8bdhSk8UXx4tMYEDZd7rkgDrfAmCqsxjr4CR8ujzCJWMGLmk+auqp+
 6wLzxD3AdRMeZ3nvCNE/o2EFQPp/RQQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-pNk0I4JQM3mq034_5dptoA-1; Mon,
 23 Jun 2025 16:40:31 -0400
X-MC-Unique: pNk0I4JQM3mq034_5dptoA-1
X-Mimecast-MFC-AGG-ID: pNk0I4JQM3mq034_5dptoA_1750711230
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 505FB19560AA; Mon, 23 Jun 2025 20:40:30 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.111])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFD2230001A1; Mon, 23 Jun 2025 20:40:26 +0000 (UTC)
Date: Mon, 23 Jun 2025 15:40:23 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>, hibriansong@gmail.com
Subject: Re: [PATCH v2 12/12] block/io_uring: use non-vectored read/write
 when possible
Message-ID: <smkbvvqfmn4lxcmjaqr3ola3v7mabm6miqrp75q3lr4sxko4iw@jjgi7dosecfw>
References: <20250620000829.1426291-1-stefanha@redhat.com>
 <20250620000829.1426291-13-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620000829.1426291-13-stefanha@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jun 19, 2025 at 08:08:28PM -0400, Stefan Hajnoczi wrote:
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

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


