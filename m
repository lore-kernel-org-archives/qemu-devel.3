Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A792CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLIc-0003Wf-JM; Tue, 04 Nov 2025 12:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLF1-00010I-0B
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLEz-0006m4-KG
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762278885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgIonytYdqSw60SkpuBJ/nVFgBk3mbebiEwt49pbJdc=;
 b=UF/7VWYDPe5NcqFvJ9NUfS2i4Dl7albGFuwlAg/81g35L8Pl+AGsHKKypD3W0eAh5etm2I
 NpVrpbKwryJVeMyznKOmppFLYkMlZ9QZCrIMnn3FP9Co0atW874vdPz1Xq45PxTXfA49HF
 CC4Ob5kcngZJ2nz946yJMJEm78QSmMw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-O4YeRF8WPweVgbr_akuN7w-1; Tue,
 04 Nov 2025 12:54:41 -0500
X-MC-Unique: O4YeRF8WPweVgbr_akuN7w-1
X-Mimecast-MFC-AGG-ID: O4YeRF8WPweVgbr_akuN7w_1762278880
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C94D618002F5; Tue,  4 Nov 2025 17:54:40 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85FD21800451; Tue,  4 Nov 2025 17:54:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 09/27] aio: add errp argument to aio_context_setup()
Date: Tue,  4 Nov 2025 18:53:57 +0100
Message-ID: <20251104175415.525388-10-kwolf@redhat.com>
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

When aio_context_new() -> aio_context_setup() fails at startup it
doesn't really matter whether errors are returned to the caller or the
process terminates immediately.

However, it is not acceptable to terminate when hotplugging --object
iothread at runtime. Refactor aio_context_setup() so that errors can be
propagated. The next commit will set errp when fdmon_io_uring_setup()
fails.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20251104022933.618123-10-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h | 5 ++++-
 util/aio-posix.c    | 5 +++--
 util/aio-win32.c    | 3 ++-
 util/async.c        | 6 +++++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 2760f308f5..9562733fa7 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -718,10 +718,13 @@ void qemu_set_current_aio_context(AioContext *ctx);
 /**
  * aio_context_setup:
  * @ctx: the aio context
+ * @errp: error pointer
  *
  * Initialize the aio context.
+ *
+ * Returns: true on success, false otherwise
  */
-void aio_context_setup(AioContext *ctx);
+bool aio_context_setup(AioContext *ctx, Error **errp);
 
 /**
  * aio_context_destroy:
diff --git a/util/aio-posix.c b/util/aio-posix.c
index bebd9ce3a2..9806a75c12 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -718,7 +718,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     return progress;
 }
 
-void aio_context_setup(AioContext *ctx)
+bool aio_context_setup(AioContext *ctx, Error **errp)
 {
     ctx->fdmon_ops = &fdmon_poll_ops;
     ctx->epollfd = -1;
@@ -726,10 +726,11 @@ void aio_context_setup(AioContext *ctx)
 
     /* Use the fastest fd monitoring implementation if available */
     if (fdmon_io_uring_setup(ctx)) {
-        return;
+        return true;
     }
 
     fdmon_epoll_setup(ctx);
+    return true;
 }
 
 void aio_context_destroy(AioContext *ctx)
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 18cc9fb7a9..6e6f699e4b 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -419,8 +419,9 @@ bool aio_poll(AioContext *ctx, bool blocking)
     return progress;
 }
 
-void aio_context_setup(AioContext *ctx)
+bool aio_context_setup(AioContext *ctx, Error **errp)
 {
+    return true;
 }
 
 void aio_context_destroy(AioContext *ctx)
diff --git a/util/async.c b/util/async.c
index 7d06ff98f3..00e46b99f9 100644
--- a/util/async.c
+++ b/util/async.c
@@ -580,6 +580,7 @@ static void co_schedule_bh_cb(void *opaque)
 
 AioContext *aio_context_new(Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     AioContext *ctx;
 
@@ -610,7 +611,10 @@ AioContext *aio_context_new(Error **errp)
      * you add any new resources to AioContext, it's probably best to acquire
      * them before aio_context_setup().
      */
-    aio_context_setup(ctx);
+    if (!aio_context_setup(ctx, errp)) {
+        event_notifier_cleanup(&ctx->notifier);
+        goto fail;
+    }
 
     g_source_set_can_recurse(&ctx->source, true);
     qemu_lockcnt_init(&ctx->list_lock);
-- 
2.51.1


