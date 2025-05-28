Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB5DC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 21:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKNyj-0005fM-U3; Wed, 28 May 2025 17:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKNyi-0005er-7n
 for qemu-devel@nongnu.org; Wed, 28 May 2025 17:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKNyg-0007C6-C5
 for qemu-devel@nongnu.org; Wed, 28 May 2025 17:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748466381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7HSRfvikccuebOWKaKzHiOg6D9IOC1Wo7v3KYGXPoA=;
 b=W5eRIngVHubK+yZETf6E5rPiamS00H1AtDHksYoSDlL81muXzfpoktsrzX9vZ6tCo/GTHF
 +LAW7lVrSPFlPq7BHQyLKEyn1kr9qrOqJT8HcdB3TuSIfFfITu11dAD1ig1k18MBRAtXJR
 t8wFdF2FudRVxMe6kg2A6+PGGMVuIoM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-jBjmHWqBNIKs5wxdQaCFRw-1; Wed,
 28 May 2025 17:06:19 -0400
X-MC-Unique: jBjmHWqBNIKs5wxdQaCFRw-1
X-Mimecast-MFC-AGG-ID: jBjmHWqBNIKs5wxdQaCFRw_1748466378
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 846031956086; Wed, 28 May 2025 21:06:18 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5716918003FD; Wed, 28 May 2025 21:06:15 +0000 (UTC)
Date: Wed, 28 May 2025 16:06:13 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 06/11] aio: free AioContext when aio_context_new() fails
Message-ID: <bsrzx5um4n7s4prcebziybzhxum3fjler6y7od4rbswhctiqpr@jtkwa4iu6rmc>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-7-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528190916.35864-7-stefanha@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 28, 2025 at 03:09:11PM -0400, Stefan Hajnoczi wrote:
> g_source_destroy() only removes the GSource from the GMainContext it's
> attached to, if any. It does not free it.
> 
> Use g_source_unref() instead so that the AioContext (which embeds a
> GSource) is freed. There is no need to call g_source_destroy() in
> aio_context_new() because the GSource isn't attached to a GMainContext
> yet.
> 
> aio_ctx_finalize() expects everything to be set up already, so introduce
> the new ctx->initialized boolean and do nothing when called with
> !initialized. This also requires moving aio_context_setup() down after
> event_notifier_init() since aio_ctx_finalize() won't release any
> resources that aio_context_setup() acquired.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/aio.h |  3 +++
>  util/async.c        | 12 ++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 

> +++ b/util/async.c
> @@ -369,6 +369,10 @@ aio_ctx_finalize(GSource     *source)

While you're here, is it worth cleaning up that odd spacing in the
function parameter list?

>      QEMUBH *bh;
>      unsigned flags;
>  
> +    if (!ctx->initialized) {
> +        return;
> +    }
> +
>      thread_pool_free_aio(ctx->thread_pool);

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


