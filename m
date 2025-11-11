Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B670DCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvzQ-0006uo-0e; Tue, 11 Nov 2025 16:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzN-0006tY-PS
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzL-0001qm-P7
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyHY+uxi7KNyMyWckcS9a4fpYauibRji/fQXyLOkJ+Y=;
 b=NG38YUKGqFttP66H/InbYeRrxLNV9Zyzt5fO9buqGwYqTT1H+copwW6s+38MQsciFlWYLE
 +9GLhvkPAfSLZAS6s3d7QTXimxYgB3d0lqXen8auEr/RXBccl5+HrEutGiczw/UayWQX0T
 HCeQtOZhLgMMXguUZqesCWEAg5Rj8k4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-SKqt6HNkNLu7XCBC7UBXvA-1; Tue,
 11 Nov 2025 16:33:16 -0500
X-MC-Unique: SKqt6HNkNLu7XCBC7UBXvA-1
X-Mimecast-MFC-AGG-ID: SKqt6HNkNLu7XCBC7UBXvA_1762896795
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 162DC1800447; Tue, 11 Nov 2025 21:33:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7776430044E9; Tue, 11 Nov 2025 21:33:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 07/28] aio: remove aio_context_use_g_source()
Date: Tue, 11 Nov 2025 22:32:17 +0100
Message-ID: <20251111213238.181992-8-kwolf@redhat.com>
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

There is no need for aio_context_use_g_source() now that epoll(7) and
io_uring(7) file descriptor monitoring works with the glib event loop.
AioContext doesn't need to be notified that GSource is being used.

On hosts with io_uring support this now enables fdmon-io_uring.c by
default, replacing fdmon-poll.c and fdmon-epoll.c. In other words, the
event loop will use io_uring!

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20251104022933.618123-8-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h |  3 ---
 util/aio-posix.c    | 12 ------------
 util/aio-win32.c    |  4 ----
 util/async.c        |  1 -
 4 files changed, 20 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index aef43f9c51..3ee6015424 100644
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
index c6fbce64c2..18cc9fb7a9 100644
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
index 83f1e73e34..9d6f0c73ee 100644
--- a/util/async.c
+++ b/util/async.c
@@ -434,7 +434,6 @@ static GSourceFuncs aio_source_funcs = {
 
 GSource *aio_get_g_source(AioContext *ctx)
 {
-    aio_context_use_g_source(ctx);
     g_source_ref(&ctx->source);
     return &ctx->source;
 }
-- 
2.51.1


