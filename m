Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDCCC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxps-0007ck-Fh; Mon, 21 Jul 2025 17:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udxlu-00042b-BS
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udxls-0007hi-14
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753132201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oI0T0U66UYhX+JSzPcqtmUMvFuZBgVE4NGGub86Pn6A=;
 b=IZvBh+Xg1kTmC93sfVR0WFTizYSEKj1oWtoFTJh71+OEaKVQOgu+v+JnVlUqjjPxNTQMXL
 NTWb4wuKcypMczwuULDEtrYHaVSMr+fRIbEeCDUZ/nxI9enCL/JO3lIo5WGZibnP4x3BgQ
 SuPjMQ3Rfdcmxz8yj1uswfB0arI9n3A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-fi36AgaDP72ghwJTWYINMA-1; Mon,
 21 Jul 2025 17:09:59 -0400
X-MC-Unique: fi36AgaDP72ghwJTWYINMA-1
X-Mimecast-MFC-AGG-ID: fi36AgaDP72ghwJTWYINMA_1753132198
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F059195FD2B; Mon, 21 Jul 2025 21:09:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 328B518002B6; Mon, 21 Jul 2025 21:09:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, hibriansong@gmail.com, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v3 05/12] aio: remove aio_context_use_g_source()
Date: Mon, 21 Jul 2025 17:07:52 -0400
Message-ID: <20250721210759.179709-6-stefanha@redhat.com>
In-Reply-To: <20250721210759.179709-1-stefanha@redhat.com>
References: <20250721210759.179709-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There is no need for aio_context_use_g_source() now that epoll(7) and
io_uring(7) file descriptor monitoring works with the glib event loop.
AioContext doesn't need to be notified that GSource is being used.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
index 9de05ee7e8..bebd9ce3a2 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -743,18 +743,6 @@ void aio_context_destroy(AioContext *ctx)
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
2.50.1


