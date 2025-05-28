Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D3FC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 19:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKM9m-00077Y-TU; Wed, 28 May 2025 15:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKM9k-00075W-0F
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKM9h-0004GR-SM
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748459377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b45tRwBwKuwAOQV5Gpnbjiaqvv2uOSmRfkli9y0Q/eE=;
 b=iRjCn/gyI44FU13KzA3f2T09qSJuyGSS3NsZwZnJyVlrRFNOg/TcBWH9NRdenNj7v4vzlM
 pdw5z67z6X3/P9iuwNnA5NeKZnNO4trdloaAincbZOpqv1yqy9S3Lcjwg+oi7A5YUET8cw
 uZMTSK9eqj8YLE4EChguqBaCFU853vg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-uNLibBxHPZyuRA9SEx0kCA-1; Wed,
 28 May 2025 15:09:33 -0400
X-MC-Unique: uNLibBxHPZyuRA9SEx0kCA-1
X-Mimecast-MFC-AGG-ID: uNLibBxHPZyuRA9SEx0kCA_1748459372
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E8FE180036F; Wed, 28 May 2025 19:09:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.178])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 278D31800371; Wed, 28 May 2025 19:09:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 hibriansong@gmail.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [RFC 07/11] aio: add errp argument to aio_context_setup()
Date: Wed, 28 May 2025 15:09:12 -0400
Message-ID: <20250528190916.35864-8-stefanha@redhat.com>
In-Reply-To: <20250528190916.35864-1-stefanha@redhat.com>
References: <20250528190916.35864-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

When aio_context_new() -> aio_context_setup() fails at startup it
doesn't really matter whether errors are returned to the caller or the
process terminates immediately.

However, it is not acceptable to terminate when hotplugging --object
iothread at runtime. Refactor aio_context_setup() so that errors can be
propagated. The next commit will set errp when fdmon_io_uring_setup()
fails.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h | 3 ++-
 util/aio-posix.c    | 2 +-
 util/aio-win32.c    | 2 +-
 util/async.c        | 7 ++++++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 2760f308f5..d919d7c8f4 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -718,10 +718,11 @@ void qemu_set_current_aio_context(AioContext *ctx);
 /**
  * aio_context_setup:
  * @ctx: the aio context
+ * @errp: error pointer
  *
  * Initialize the aio context.
  */
-void aio_context_setup(AioContext *ctx);
+void aio_context_setup(AioContext *ctx, Error **errp);
 
 /**
  * aio_context_destroy:
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 5634da7d27..fa047fc7ad 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -711,7 +711,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     return progress;
 }
 
-void aio_context_setup(AioContext *ctx)
+void aio_context_setup(AioContext *ctx, Error **errp)
 {
     ctx->fdmon_ops = &fdmon_poll_ops;
     ctx->epollfd = -1;
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 34c4074133..4ba401ff92 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -419,7 +419,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     return progress;
 }
 
-void aio_context_setup(AioContext *ctx)
+void aio_context_setup(AioContext *ctx, Error **errp)
 {
 }
 
diff --git a/util/async.c b/util/async.c
index bc841eeb4f..bba9622e97 100644
--- a/util/async.c
+++ b/util/async.c
@@ -577,6 +577,7 @@ static void co_schedule_bh_cb(void *opaque)
 
 AioContext *aio_context_new(Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     AioContext *ctx;
 
@@ -590,7 +591,11 @@ AioContext *aio_context_new(Error **errp)
         goto fail;
     }
 
-    aio_context_setup(ctx);
+    aio_context_setup(ctx, errp);
+    if (*errp) {
+        event_notifier_cleanup(&ctx->notifier);
+        goto fail;
+    }
 
     g_source_set_can_recurse(&ctx->source, true);
     qemu_lockcnt_init(&ctx->list_lock);
-- 
2.49.0


