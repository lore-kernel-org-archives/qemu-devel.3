Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81E5CCFA06
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6oB-00072B-VV; Mon, 03 Nov 2025 21:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6o5-00070f-Gr
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6o3-0003wM-CQ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762223398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hls5Ayd/gkfhHgh/tKvWVpGroj5gZuV7yYl44cIqJps=;
 b=QOddJ49wDHPvdGkuDC93Bpfe//Xwmdr12JPys9C8YCaHbrarW2DD82rN95LsjatevUGKdb
 S0Yg87LT3gKJ4+Szq0i+DH0hKWRG58U4gCPHRYIYYu3To6GXY/wjYuEqJqFewkPo6Ily3u
 BtX3ulovxaa8qagWK201JBgxFIT3uus=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-uS0DBJYyNX2FDM7u8_qYjA-1; Mon,
 03 Nov 2025 21:29:57 -0500
X-MC-Unique: uS0DBJYyNX2FDM7u8_qYjA-1
X-Mimecast-MFC-AGG-ID: uS0DBJYyNX2FDM7u8_qYjA_1762223396
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 727401956048; Tue,  4 Nov 2025 02:29:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB9A71956056; Tue,  4 Nov 2025 02:29:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com
Subject: [PATCH v6 07/15] aio: remove aio_context_use_g_source()
Date: Mon,  3 Nov 2025 21:29:25 -0500
Message-ID: <20251104022933.618123-8-stefanha@redhat.com>
In-Reply-To: <20251104022933.618123-1-stefanha@redhat.com>
References: <20251104022933.618123-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On hosts with io_uring support this now enables fdmon-io_uring.c by
default, replacing fdmon-poll.c and fdmon-epoll.c. In other words, the
event loop will use io_uring!

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
v5:
- Mention in commit message that fdmon-io_uring.c is the new default [Kevin]
---
 include/block/aio.h |  3 ---
 util/aio-posix.c    | 12 ------------
 util/aio-win32.c    |  4 ----
 util/async.c        |  1 -
 4 files changed, 20 deletions(-)

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
index a736d2cd0d..cb72ad3777 100644
--- a/util/async.c
+++ b/util/async.c
@@ -433,7 +433,6 @@ static GSourceFuncs aio_source_funcs = {
 
 GSource *aio_get_g_source(AioContext *ctx)
 {
-    aio_context_use_g_source(ctx);
     g_source_ref(&ctx->source);
     return &ctx->source;
 }
-- 
2.51.1


