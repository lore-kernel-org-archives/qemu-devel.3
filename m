Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B9DCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvzR-0006w3-Si; Tue, 11 Nov 2025 16:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzQ-0006vR-IU
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzP-0001rP-1U
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ot2YRVb68vmbRabsegBRxrSHPHgWCylNtI18CWvtA6o=;
 b=h3KxkCyoM2dWYUPnZxEWCUcsH9dX18laPf3zYXpmFlHwHERFs8vAwgZIzBaiKNL60yFGPW
 i0By0G10zone+hps9AO6cLBYN83Gx7i6Nrsyu3D8D6V0nDEVUBhl0QCO3paiJ2SS1jX99l
 b6yj/jotudvCW2zVV+PWzzmTGTSaEw8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-He6cJ8AeOw-fw7jMVbLYGw-1; Tue,
 11 Nov 2025 16:33:19 -0500
X-MC-Unique: He6cJ8AeOw-fw7jMVbLYGw-1
X-Mimecast-MFC-AGG-ID: He6cJ8AeOw-fw7jMVbLYGw_1762896798
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19647180048E; Tue, 11 Nov 2025 21:33:18 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C8BF30044E0; Tue, 11 Nov 2025 21:33:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 08/28] aio: free AioContext when aio_context_new() fails
Date: Tue, 11 Nov 2025 22:32:18 +0100
Message-ID: <20251111213238.181992-9-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 3ee6015424..6cddf4d13b 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -291,6 +291,9 @@ struct AioContext {
     void *epollfd_tag;
 
     const FDMonOps *fdmon_ops;
+
+    /* Was aio_context_new() successful? */
+    bool initialized;
 };
 
 /**
diff --git a/util/async.c b/util/async.c
index 9d6f0c73ee..95b1c6b610 100644
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
@@ -580,16 +584,35 @@ AioContext *aio_context_new(Error **errp)
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
 
@@ -623,9 +646,11 @@ AioContext *aio_context_new(Error **errp)
 
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


