Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497CECCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tMx-0006L1-2M; Thu, 09 Oct 2025 12:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6tMs-0006K9-7t
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6tMh-0000bQ-Ru
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760026766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kKfCoBWm+OS//HCHsarxXGzfMm867upCKyg0n3twxuU=;
 b=dUAdVruBGUTncAoJVbf1U8B+wBiyHN2cs9DTPbkZJq3iZDqW59r1KYmlGdoz7TQG/udeeI
 9Tj1bdK8/cySBi6x3DiyJFri2wU6Ww4zyuHp5UAd2V1WwnRCcnKlNT1px1TlyymLRUY+HF
 C6W15Tq2JVW+WGkl1iN3sUx58tf2AZY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-NDPXsooKNkGMbKumYGy1Dw-1; Thu,
 09 Oct 2025 12:19:24 -0400
X-MC-Unique: NDPXsooKNkGMbKumYGy1Dw-1
X-Mimecast-MFC-AGG-ID: NDPXsooKNkGMbKumYGy1Dw_1760026762
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E8601800576; Thu,  9 Oct 2025 16:19:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC95519560BB; Thu,  9 Oct 2025 16:19:18 +0000 (UTC)
Date: Thu, 9 Oct 2025 18:19:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 08/12] aio-posix: gracefully handle
 io_uring_queue_init() failure
Message-ID: <aOfgg0rhCUcpgObo@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-9-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910175703.374499-9-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> io_uring may not be available at runtime due to system policies (e.g.
> the io_uring_disabled sysctl) or creation could fail due to file
> descriptor resource limits.
> 
> Handle failure scenarios as follows:
> 
> If another AioContext already has io_uring, then fail AioContext
> creation so that the aio_add_sqe() API is available uniformly from all
> QEMU threads. Otherwise fall back to epoll(7) if io_uring is
> unavailable.
> 
> Notes:
> - Update the comment about selecting the fastest fdmon implementation.
>   At this point it's not about speed anymore, it's about aio_add_sqe()
>   API availability.
> - Uppercase the error message when converting from error_report() to
>   error_setg_errno() for consistency (but there are instances of
>   lowercase in the codebase).
> - It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

> @@ -369,7 +370,7 @@ static const FDMonOps fdmon_io_uring_ops = {
>      .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
>  };
>  
> -bool fdmon_io_uring_setup(AioContext *ctx)
> +void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
>  {
>      int ret;

Same as in the previous patch, it would be more conventional to keep the
bool return code in addition to the Error **. Either way:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


