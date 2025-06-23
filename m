Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16988C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnxD-0003a6-S1; Mon, 23 Jun 2025 16:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uTnx5-0003Yp-Lq
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uTnx4-00072g-0Z
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750711175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caZpCOirTYtxHpQscrT6Wp684YPROU7LQZSNHgX2StI=;
 b=EgWVBSBzd0oxQc4QNMehpSzVbOEOE65aKJsz7dA+og84zs1H7DjqBxYYDyP0RkTPDLfxMY
 4JRtmTJFtLbajHzpg2zEdapXGDoB9eY+4/EDNxVXNB4B2zBdEfLcmnoZ3SZqRvXRowsqKX
 r5u3KJAHhz5WNtzwFAJGuO/FJnGLBiY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-B5jKUYSxPpi9Py0I2aLbxg-1; Mon,
 23 Jun 2025 16:39:32 -0400
X-MC-Unique: B5jKUYSxPpi9Py0I2aLbxg-1
X-Mimecast-MFC-AGG-ID: B5jKUYSxPpi9Py0I2aLbxg_1750711171
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A05CF19560AA; Mon, 23 Jun 2025 20:39:30 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.111])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D4CA19560A3; Mon, 23 Jun 2025 20:39:26 +0000 (UTC)
Date: Mon, 23 Jun 2025 15:39:24 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>, hibriansong@gmail.com
Subject: Re: [PATCH v2 08/12] aio-posix: gracefully handle
 io_uring_queue_init() failure
Message-ID: <bwzrm3l3zcblfn5wz3kvsfenabyehdndvzhns3qwp755mib5pl@qrv5hisxirac>
References: <20250620000829.1426291-1-stefanha@redhat.com>
 <20250620000829.1426291-9-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620000829.1426291-9-stefanha@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 19, 2025 at 08:08:24PM -0400, Stefan Hajnoczi wrote:
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
> ---
>  util/aio-posix.h      | 12 ++----------
>  util/aio-posix.c      | 29 ++++++++++++++++++++++++++---
>  util/fdmon-io_uring.c |  8 ++++----
>  3 files changed, 32 insertions(+), 17 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


