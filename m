Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DE2CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLIm-0003rk-Gb; Tue, 04 Nov 2025 12:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLF0-00010G-AI
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLEy-0006ln-Kt
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762278884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5m6CnJjLsW3KWMdRnhw/z7QIRE3ddEIq/HKKN+JGB9E=;
 b=O+gneFMOHa9lG/4i51VOnb7u9eMpYEpYfYIrXmlxXl5zUaAysF3F2VUHu/ua76IL/jG/3I
 WIBWzyA/nLa/KHwNz2/wRR/N4hV6BgZ/+id9yhiU/DODnrs0raQXSjW9Htn2NqTg7Ol0MJ
 n4iuE96EnAEVH3YeJYw5oDOYt7OORrg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-uRmAda5yPou5XOEoYNIxiQ-1; Tue,
 04 Nov 2025 12:54:39 -0500
X-MC-Unique: uRmAda5yPou5XOEoYNIxiQ-1
X-Mimecast-MFC-AGG-ID: uRmAda5yPou5XOEoYNIxiQ_1762278879
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 102151956094; Tue,  4 Nov 2025 17:54:39 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFBBD180045B; Tue,  4 Nov 2025 17:54:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/27] aio: free AioContext when aio_context_new() fails
Date: Tue,  4 Nov 2025 18:53:56 +0100
Message-ID: <20251104175415.525388-9-kwolf@redhat.com>
In-Reply-To: <20251104175415.525388-1-kwolf@redhat.com>
References: <20251104175415.525388-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

g_source_destroy() only removes the GSource from the GMainContext it's
attached to, if any. It does not free it.

Use g_source_unref() instead so that the AioContext (which embeds a
GSource) is freed. There is no need to call g_source_destroy() in
aio_context_new() because the GSource isn't attached to a GMainContext
yet.

aio_ctx_finalize() expects everything to be set up already, so introduce
the new ctx->initialized boolean and do nothing when called with
!initialized. This also requires moving aio_context_setup() down after
event_notifier_init() since aio_ctx_finalize() won't release any
resources that aio_context_setup() acquired.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20251104022933.618123-9-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h |  3 +++
 util/async.c        | 31 ++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 1657740a0e..2760f308f5 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -291,6 +291,9 @@ struct AioContext {
     gpointer epollfd_tag;
 
     const FDMonOps *fdmon_ops;
+
+    /* Was aio_context_new() successful? */
+    bool initialized;
 };
 
 /**
diff --git a/util/async.c b/util/async.c
index cb72ad3777..7d06ff98f3 100644
--- a/util/async.c
+++ b/util/async.c
@@ -366,12 +366,16 @@ aio_ctx_dispatch(GSource     *source,
 }
 
 static void
-aio_ctx_finalize(GSource     *source)
+aio_ctx_finalize(GSource *source)
 {
     AioContext *ctx = (AioContext *) source;
     QEMUBH *bh;
     unsigned flags;
 
+    if (!ctx->initialized) {
+        return;
+    }
+
     thread_pool_free_aio(ctx->thread_pool);
 
 #ifdef CONFIG_LINUX_AIO
@@ -579,16 +583,35 @@ AioContext *aio_context_new(Error **errp)
     int ret;
     AioContext *ctx;
 
+    /*
+     * ctx is freed by g_source_unref() (e.g. aio_context_unref()). ctx's
+     * resources are freed as follows:
+     *
+     * 1. By aio_ctx_finalize() after aio_context_new() has returned and set
+     *    ->initialized = true.
+     *
+     * 2. By manual cleanup code in this function's error paths before goto
+     *    fail.
+     *
+     * Be careful to free resources in both cases!
+     */
     ctx = (AioContext *) g_source_new(&aio_source_funcs, sizeof(AioContext));
     QSLIST_INIT(&ctx->bh_list);
     QSIMPLEQ_INIT(&ctx->bh_slice_list);
-    aio_context_setup(ctx);
 
     ret = event_notifier_init(&ctx->notifier, false);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to initialize event notifier");
         goto fail;
     }
+
+    /*
+     * Resources cannot easily be freed manually after aio_context_setup(). If
+     * you add any new resources to AioContext, it's probably best to acquire
+     * them before aio_context_setup().
+     */
+    aio_context_setup(ctx);
+
     g_source_set_can_recurse(&ctx->source, true);
     qemu_lockcnt_init(&ctx->list_lock);
 
@@ -622,9 +645,11 @@ AioContext *aio_context_new(Error **errp)
 
     register_aiocontext(ctx);
 
+    ctx->initialized = true;
+
     return ctx;
 fail:
-    g_source_destroy(&ctx->source);
+    g_source_unref(&ctx->source);
     return NULL;
 }
 
-- 
2.51.1


