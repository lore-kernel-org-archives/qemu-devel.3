Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC2CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 20:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vECtP-0003Wq-F5; Wed, 29 Oct 2025 16:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vECsi-0003IH-2G
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vECsM-00055X-HD
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761770070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWKZgPMT1vjCWUd0Ifvhu6cxvDnIVcWg8I7oiOdLwU8=;
 b=CAQFG8AEq3eHOkc383LdXiwEX+CoV9x2bMoMghnHyV9AhAlGdAA9ToHefbmOdnWCRWCuWH
 xApN8WI2KvpSWHj/6Q9UfLzzLEiAO3tTWLi+xOqegBRXsCRbMhs40+348cO55hR6WGF+/1
 KaCswmlyFphpr/PO+t3OcqTZjBn+1Jo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-mei7mZGAMeO5Nb8olQHO0w-1; Wed,
 29 Oct 2025 16:34:29 -0400
X-MC-Unique: mei7mZGAMeO5Nb8olQHO0w-1
X-Mimecast-MFC-AGG-ID: mei7mZGAMeO5Nb8olQHO0w_1761770068
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FC7D1800D8F; Wed, 29 Oct 2025 20:34:28 +0000 (UTC)
Received: from localhost (unknown [10.2.17.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E099B1800579; Wed, 29 Oct 2025 20:34:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, hibriansong@gmail.com,
 qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 eblake@redhat.com
Subject: [PATCH v5 07/12] aio: add errp argument to aio_context_setup()
Date: Wed, 29 Oct 2025 16:34:06 -0400
Message-ID: <20251029203411.445852-8-stefanha@redhat.com>
In-Reply-To: <20251029203411.445852-1-stefanha@redhat.com>
References: <20251029203411.445852-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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
---
v5:
- Indicate error in return value from function with Error *errp arg [Kevin]
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
2.51.0


