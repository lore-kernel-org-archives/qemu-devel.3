Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBECD606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=kenjo.org header.i=@kenjo.org header.a=rsa-sha256 header.s=mail header.b=hqiHfQUk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVhvS-0006Td-F3; Mon, 23 Nov 2026 23:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ken@kenjo.org>)
 id 1xVfe1-0008KY-Pd; Mon, 23 Nov 2026 20:48:29 -0500
Received: from h-155-4-163-233.a498.priv.bahnhof.se ([155.4.163.233]
 helo=mail.kenjo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ken@kenjo.org>)
 id 1xVfdy-0000RF-1m; Mon, 23 Nov 2026 20:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kenjo.org; 
 s=mail;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qRyehFf5U+5tEKTml/CLAy2HvZB5Ngz8+Ab2aVrj9D8=; b=hqiHfQUkYL5UmOo9+I9zMpK4yd
 qTl+JcgBJyYm+WzTo/3AGACZqI9eivEJCM89zk2Sj5SA4lC5BIrlHPUxeRbrWK7KW1Ts7Wyzq5puB
 OXvwiWC9FccYhCAhXfYlewROwbK4vNOvNaSwYYx+HWKaFcgkmPb9aJDb1Nv8ZkXPIXZ0=;
Received: from brix.kenjo.org ([172.16.2.16])
 by mail.kenjo.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <ken@kenjo.org>) id 1xVewr-00000004FUo-3At2;
 Tue, 24 Nov 2026 02:03:53 +0100
From: Kenneth Johansson <ken@kenjo.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Kenneth Johansson <ken@kenjo.org>
Subject: [PATCH 2/2] fdmon-io_uring: submit re-armed poll sqes after
 dispatching handlers
Date: Tue, 24 Nov 2026 02:03:51 +0100
Message-ID: <20261124010351.3166118-3-ken@kenjo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261124010351.3166118-1-ken@kenjo.org>
References: <20261124010351.3166118-1-ken@kenjo.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=155.4.163.233; envelope-from=ken@kenjo.org;
 helo=mail.kenjo.org
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_RDNS_DYNAMIC_FP=0.01, RDNS_DYNAMIC=0.982, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Nov 2026 23:14:35 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The io_uring fd monitor watches each fd with a one-shot poll request.
When the fd becomes ready, aio_poll() queues a new poll request for it,
but only submits it with the next wait.

A vCPU thread holding the BQL (e.g. blk_pread() from a device model)
can run aio_poll(qemu_aio_context) while the main loop sleeps in
ppoll() on the ring fd.  The new poll request for the AioContext's
notifier is then never submitted, so aio_notify() no longer wakes the
main loop, and timers stall until ppoll() times out.

Add an optional FDMonOps::post_dispatch() hook that aio_poll() calls
after the ready handlers have run, and submit the queued poll requests
there.

Fixes: ded29e64c6f3 ("aio-posix: integrate fdmon into glib event loop")
Signed-off-by: Kenneth Johansson <ken@kenjo.org>
---
 include/qemu/aio.h    | 10 ++++++++++
 util/aio-posix.c      |  4 ++++
 util/fdmon-io_uring.c | 15 +++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/qemu/aio.h b/include/qemu/aio.h
index e65e90093a..72f209d857 100644
--- a/include/qemu/aio.h
+++ b/include/qemu/aio.h
@@ -125,6 +125,16 @@ typedef struct {
      */
     bool (*dispatch)(AioContext *ctx);
 
+    /*
+     * post_dispatch:
+     * @ctx: the AioContext
+     *
+     * Called by aio_poll() after ready handlers have been dispatched.
+     *
+     * This function is optional and may be NULL.
+     */
+    void (*post_dispatch)(AioContext *ctx);
+
     /*
      * gsource_prepare:
      * @ctx: the AioContext
diff --git a/util/aio-posix.c b/util/aio-posix.c
index df1c213ce5..cc4ca9dfb7 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -745,6 +745,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
     progress |= aio_bh_poll(ctx);
     progress |= aio_dispatch_ready_handlers(ctx, &ready_list, dispatch_ns);
 
+    if (ctx->fdmon_ops->post_dispatch) {
+        ctx->fdmon_ops->post_dispatch(ctx);
+    }
+
     aio_free_deleted_handlers(ctx);
 
     if (ctx->poll_max_ns) {
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index b81e412402..3f180ef47f 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -433,6 +433,20 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
     return process_cq_ring(ctx, ready_list);
 }
 
+/*
+ * Called by aio_poll() after dispatching handlers.  Submit IORING_OP_POLL_ADD
+ * re-arms now rather than with the next wait: aio_poll() may run in a vCPU
+ * thread holding the BQL while the glib event loop sleeps in ppoll().
+ */
+static void fdmon_io_uring_post_dispatch(AioContext *ctx)
+{
+    if (io_uring_sq_ready(&ctx->fdmon_io_uring)) {
+        while (io_uring_submit(&ctx->fdmon_io_uring) == -EINTR) {
+            /* Keep trying if syscall was interrupted */
+        }
+    }
+}
+
 static bool fdmon_io_uring_need_wait(AioContext *ctx)
 {
     /* Have io_uring events completed? */
@@ -458,6 +472,7 @@ static const FDMonOps fdmon_io_uring_ops = {
     .wait = fdmon_io_uring_wait,
     .need_wait = fdmon_io_uring_need_wait,
     .dispatch = fdmon_io_uring_dispatch,
+    .post_dispatch = fdmon_io_uring_post_dispatch,
     .gsource_prepare = fdmon_io_uring_gsource_prepare,
     .gsource_check = fdmon_io_uring_gsource_check,
     .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
-- 
2.51.0


