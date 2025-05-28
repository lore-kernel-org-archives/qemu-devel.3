Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C519DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 19:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKM9j-00075C-Og; Wed, 28 May 2025 15:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKM9i-00073p-Cc
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKM9f-0004Fw-UA
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748459375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hpc5lSmlPYOb09Vw5vORJdIYSdR2P9cx3comlxLFLP4=;
 b=i/VsK/6f3ex1oLI09wBmHoifbVZekYMd7hTHbXAMsqfuP99/nOK9teP37zwdhjMG99FfVw
 WnjBy3K4j14dfN/uc1Ti9fkolZIq5M2DIUSuznvWBkSjWKCB5Bt8o4jZK3/LwxvsDcEC5r
 VYxx9SD6R5E54QKQETWsEqoB89bKAwc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-MUFBmn5kMYG9LsP5-ay1AQ-1; Wed,
 28 May 2025 15:09:29 -0400
X-MC-Unique: MUFBmn5kMYG9LsP5-ay1AQ-1
X-Mimecast-MFC-AGG-ID: MUFBmn5kMYG9LsP5-ay1AQ_1748459369
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0113180034E; Wed, 28 May 2025 19:09:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.178])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 724AE19560AA; Wed, 28 May 2025 19:09:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 hibriansong@gmail.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [RFC 05/11] aio: remove aio_context_use_g_source()
Date: Wed, 28 May 2025 15:09:10 -0400
Message-ID: <20250528190916.35864-6-stefanha@redhat.com>
In-Reply-To: <20250528190916.35864-1-stefanha@redhat.com>
References: <20250528190916.35864-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

There is no need for aio_context_use_g_source() now that epoll(7) and
io_uring(7) file descriptor monitoring works with the glib event loop.
AioContext doesn't need to be notified that GSource is being used.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h               |  3 ---
 tests/unit/test-nested-aio-poll.c |  6 ------
 util/aio-posix.c                  | 12 ------------
 util/aio-win32.c                  |  4 ----
 util/async.c                      |  1 -
 5 files changed, 26 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 39ed86d14d..1657740a0e 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -728,9 +728,6 @@ void aio_context_setup(AioContext *ctx);
  */
 void aio_context_destroy(AioContext *ctx);
 
-/* Used internally, do not call outside AioContext code */
-void aio_context_use_g_source(AioContext *ctx);
-
 /**
  * aio_context_set_poll_params:
  * @ctx: the aio context
diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
index 45484e745b..d13ecccd8c 100644
--- a/tests/unit/test-nested-aio-poll.c
+++ b/tests/unit/test-nested-aio-poll.c
@@ -83,12 +83,6 @@ static void test(void)
     /* Enable polling */
     aio_context_set_poll_params(td.ctx, 1000000, 2, 2, &error_abort);
 
-    /*
-     * The GSource is unused but this has the side-effect of changing the fdmon
-     * that AioContext uses.
-     */
-    aio_get_g_source(td.ctx);
-
     /* Make the event notifier active (set) right away */
     event_notifier_init(&td.poll_notifier, 1);
     aio_set_event_notifier(td.ctx, &td.poll_notifier,
diff --git a/util/aio-posix.c b/util/aio-posix.c
index dd135c7baa..5634da7d27 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -736,18 +736,6 @@ void aio_context_destroy(AioContext *ctx)
     aio_free_deleted_handlers(ctx);
 }
 
-void aio_context_use_g_source(AioContext *ctx)
-{
-    /*
-     * Disable io_uring when the glib main loop is used because it doesn't
-     * support mixed glib/aio_poll() usage. It relies on aio_poll() being
-     * called regularly so that changes to the monitored file descriptors are
-     * submitted, otherwise a list of pending fd handlers builds up.
-     */
-    fdmon_io_uring_destroy(ctx);
-    aio_free_deleted_handlers(ctx);
-}
-
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink, Error **errp)
 {
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 6583d5c5f3..34c4074133 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -427,10 +427,6 @@ void aio_context_destroy(AioContext *ctx)
 {
 }
 
-void aio_context_use_g_source(AioContext *ctx)
-{
-}
-
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink, Error **errp)
 {
diff --git a/util/async.c b/util/async.c
index 2719c629ae..a39410d675 100644
--- a/util/async.c
+++ b/util/async.c
@@ -430,7 +430,6 @@ static GSourceFuncs aio_source_funcs = {
 
 GSource *aio_get_g_source(AioContext *ctx)
 {
-    aio_context_use_g_source(ctx);
     g_source_ref(&ctx->source);
     return &ctx->source;
 }
-- 
2.49.0


