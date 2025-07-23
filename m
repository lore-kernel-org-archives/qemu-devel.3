Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA27C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 21:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueh1g-00054u-Ar; Wed, 23 Jul 2025 17:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ueh1X-00053Q-Cq
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 17:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ueh1V-0000XH-9P
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 17:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753306152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UaGw3EyFam12NmF8RqqoTQBgLe+WygzeaMc2VSKoblI=;
 b=XZ4Gn4VLkYLH5QVkLZZkQ9dn2inFd0eAWKxelPzDZsCTCVEQufO9ihF2/44proKwxDdqnZ
 EFHPTIAU8bUzeYdY7JrVLgi0/tqQrbfGuKz5NPqcCeLGkj1ivnqQ04HlL+x6aYg1QSJRrZ
 bGnx6St/c6rqxA87dOJ0sfdVCzbtpVc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-NVULhkrdNzeEu0QjwqQEMA-1; Wed,
 23 Jul 2025 17:29:08 -0400
X-MC-Unique: NVULhkrdNzeEu0QjwqQEMA-1
X-Mimecast-MFC-AGG-ID: NVULhkrdNzeEu0QjwqQEMA_1753306147
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E38BF1800359; Wed, 23 Jul 2025 21:29:06 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B3BF195608D; Wed, 23 Jul 2025 21:29:02 +0000 (UTC)
Date: Wed, 23 Jul 2025 16:29:00 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 hibriansong@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH v3 08/12] aio-posix: gracefully handle
 io_uring_queue_init() failure
Message-ID: <hrdbituh5wjv3alr7li3gnk5zzil5tvj5b662l25coa6gbhkht@grgs4k56kw7g>
References: <20250721210759.179709-1-stefanha@redhat.com>
 <20250721210759.179709-9-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721210759.179709-9-stefanha@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 21, 2025 at 05:07:55PM -0400, Stefan Hajnoczi wrote:
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


