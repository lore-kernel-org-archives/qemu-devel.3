Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7473FC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 22:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKPAQ-0000bM-M1; Wed, 28 May 2025 18:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKPAN-0000ac-NI
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKPAF-0001XI-3Q
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748470938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foFFYAjlMpeFjBccHNzKIw+DgdTqTbC873SzXKDIQPI=;
 b=h90jc3zPZ7Lzr39M5VfeRk+SFl3xJ1vONDrI4BDqeFuf6j6piYXCwA9VzVUfs95k85S6s3
 6FwlPr8KcH+uJl3JJzfIbGSfQblFGRf/ORlxu35zNxD8uru+T2iajDrsVra5wBR/xbi7OM
 6xnkZgapznO6HHUrSpIHTybYeNTMDyI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-EthaZjUzM1KaOdoz9r2dDQ-1; Wed,
 28 May 2025 18:15:27 -0400
X-MC-Unique: EthaZjUzM1KaOdoz9r2dDQ-1
X-Mimecast-MFC-AGG-ID: EthaZjUzM1KaOdoz9r2dDQ_1748470526
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C5AF195608A; Wed, 28 May 2025 22:15:26 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1F5F19560AA; Wed, 28 May 2025 22:15:23 +0000 (UTC)
Date: Wed, 28 May 2025 17:15:20 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 09/11] aio-posix: add aio_add_sqe() API for user-defined
 io_uring requests
Message-ID: <fttfqab3stui6qkf4ypbrwmxg4rydcsxyn236ufkkvivatcxbw@p46qo3twfatg>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-10-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528190916.35864-10-stefanha@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 28, 2025 at 03:09:14PM -0400, Stefan Hajnoczi wrote:
> Introduce the aio_add_sqe() API for submitting io_uring requests in the
> current AioContext. This allows other components in QEMU, like the block
> layer, to take advantage of io_uring features without creating their own
> io_uring context.

Interesting that 8/11 refers to the function that we are just adding
now; but since the mention is only in the comments, I'm okay with
introducing the comment early and avoiding churn.

> 
> This API supports nested event loops just like file descriptor
> monitoring and BHs do. This comes at a complexity cost: a BH is required
> to dispatch CQE callbacks and they are placed on a list so that a nested
> event loop can invoke its parent's pending CQE callbacks. If you're
> wondering why CqeHandler exists instead of just a callback function
> pointer, this is why.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/aio.h   |  82 ++++++++++++++++++++++++
>  util/aio-posix.h      |   1 +
>  util/aio-posix.c      |   9 +++
>  util/fdmon-io_uring.c | 145 +++++++++++++++++++++++++++++++-----------
>  4 files changed, 200 insertions(+), 37 deletions(-)

I'll have to resume my review tomorrow.  (I'm having fun learning
about io_uring while reviewing this)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


