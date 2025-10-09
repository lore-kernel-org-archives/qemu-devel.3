Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DD9CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tAC-0000xa-I7; Thu, 09 Oct 2025 12:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6t9z-0000wO-AS
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6t9l-0007PL-4g
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760025971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4JEmYP1t5XShIQYpC0PcoBZPFy0qgi7og0Jk/yy3zE=;
 b=hnq1pfB/hO534uuEMjdkLKs5JXXgSvBKSYrw9C8d2tyGKEbmt9NYDCa6arTkZTIaKwl/qO
 AogVC+KIKXaTG9s63LTSX+DHGdBK7xo/ODU9KGJccsNCNGp2bPIIg8sbEL/W+S5u5vNlGi
 kZTrrxbSNoJxo+7O+dw0SEbPaEzvYY8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-9L1I4UtsNV-qJF7bQKYpCQ-1; Thu,
 09 Oct 2025 12:06:09 -0400
X-MC-Unique: 9L1I4UtsNV-qJF7bQKYpCQ-1
X-Mimecast-MFC-AGG-ID: 9L1I4UtsNV-qJF7bQKYpCQ_1760025968
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8970418004D8; Thu,  9 Oct 2025 16:06:07 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.99])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 518F630001B7; Thu,  9 Oct 2025 16:06:02 +0000 (UTC)
Date: Thu, 9 Oct 2025 18:06:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 06/12] aio: free AioContext when aio_context_new() fails
Message-ID: <aOfdaCyxInxfoLhN@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-7-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910175703.374499-7-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> v2:
> - Fix spacing in aio_ctx_finalize() argument list [Eric]
> ---
>  include/block/aio.h |  3 +++
>  util/async.c        | 14 +++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 1657740a0e..2760f308f5 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -291,6 +291,9 @@ struct AioContext {
>      gpointer epollfd_tag;
>  
>      const FDMonOps *fdmon_ops;
> +
> +    /* Was aio_context_new() successful? */
> +    bool initialized;
>  };
>  
>  /**
> diff --git a/util/async.c b/util/async.c
> index a39410d675..34aaab4e9e 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -363,12 +363,16 @@ aio_ctx_dispatch(GSource     *source,
>  }
>  
>  static void
> -aio_ctx_finalize(GSource     *source)
> +aio_ctx_finalize(GSource *source)
>  {
>      AioContext *ctx = (AioContext *) source;
>      QEMUBH *bh;
>      unsigned flags;
>  
> +    if (!ctx->initialized) {
> +        return;
> +    }

You had to move aio_context_setup() down in aio_context_new() to make
sure that this doesn't leak things.

How will we make sure that nobody adds another error path after
allocating something after g_source_new()? g_source_new() doesn't seem
to guarantee that AioContext starts zeroed, which is annoying if we
wanted to just make aio_ctx_finalize() safe to be called from before the
first error path.

>      thread_pool_free_aio(ctx->thread_pool);
>  
>  #ifdef CONFIG_LINUX_AIO
> @@ -579,13 +583,15 @@ AioContext *aio_context_new(Error **errp)
>      ctx = (AioContext *) g_source_new(&aio_source_funcs, sizeof(AioContext));
>      QSLIST_INIT(&ctx->bh_list);
>      QSIMPLEQ_INIT(&ctx->bh_slice_list);
> -    aio_context_setup(ctx);
>  
>      ret = event_notifier_init(&ctx->notifier, false);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Failed to initialize event notifier");
>          goto fail;
>      }
>
> +
> +    aio_context_setup(ctx);

Can we at least add a comment here saying that there must be no error
after this aio_context_setup() call any more because we would then leak
things?

>      g_source_set_can_recurse(&ctx->source, true);
>      qemu_lockcnt_init(&ctx->list_lock);
>  
> @@ -619,9 +625,11 @@ AioContext *aio_context_new(Error **errp)
>  
>      register_aiocontext(ctx);
>  
> +    ctx->initialized = true;
> +
>      return ctx;
>  fail:
> -    g_source_destroy(&ctx->source);
> +    g_source_unref(&ctx->source);
>      return NULL;
>  }

Kevin


