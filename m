Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6114DCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLFa-0001Dv-MS; Tue, 04 Nov 2025 12:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLEp-0000r2-NO
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:54:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLEo-0006iw-2A
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762278873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+CpWO3JCH0B/CwO232sJN6EEvF1wViIZzhnu7FRhIc=;
 b=jIFtBWCJ9hJ82VoUo9jXfS9o3g0PRvnoJWSNzJkXOA4+t5yW8st4hNAGrgZpIQSgCr5zf0
 dLQbWlEMrczLquJ9Xt9p8T7cBZ0hJG6bux8TS9D6jVpaVrin+1yHgZ7gL1ia/7Gfqnl91p
 fnezeYzeJrof3zQKy5VPl/K3UWSB+ng=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-b4318xe2O6eVBT_fpTfHeA-1; Tue,
 04 Nov 2025 12:54:30 -0500
X-MC-Unique: b4318xe2O6eVBT_fpTfHeA-1
X-Mimecast-MFC-AGG-ID: b4318xe2O6eVBT_fpTfHeA_1762278868
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40E6D19560B0; Tue,  4 Nov 2025 17:54:28 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA434180044F; Tue,  4 Nov 2025 17:54:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/27] aio-posix: fix fdmon-io_uring.c timeout stack variable
 lifetime
Date: Tue,  4 Nov 2025 18:53:50 +0100
Message-ID: <20251104175415.525388-3-kwolf@redhat.com>
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

io_uring_prep_timeout() stashes a pointer to the timespec struct rather
than copying its fields. That means the struct must live until after the
SQE has been submitted by io_uring_enter(2). add_timeout_sqe() violates
this constraint because the SQE is not submitted within the function.

Inline add_timeout_sqe() into fdmon_io_uring_wait() so that the struct
lives at least as long as io_uring_enter(2).

This fixes random hangs (bogus timeout values) when the kernel loads
undefined timespec struct values from userspace after the original
struct on the stack has been destroyed.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251104022933.618123-3-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/fdmon-io_uring.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index ad89160f31..b64ce42513 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -188,20 +188,6 @@ static void add_poll_remove_sqe(AioContext *ctx, AioHandler *node)
     io_uring_sqe_set_data(sqe, NULL);
 }
 
-/* Add a timeout that self-cancels when another cqe becomes ready */
-static void add_timeout_sqe(AioContext *ctx, int64_t ns)
-{
-    struct io_uring_sqe *sqe;
-    struct __kernel_timespec ts = {
-        .tv_sec = ns / NANOSECONDS_PER_SECOND,
-        .tv_nsec = ns % NANOSECONDS_PER_SECOND,
-    };
-
-    sqe = get_sqe(ctx);
-    io_uring_prep_timeout(sqe, &ts, 1, 0);
-    io_uring_sqe_set_data(sqe, NULL);
-}
-
 /* Add sqes from ctx->submit_list for submission */
 static void fill_sq_ring(AioContext *ctx)
 {
@@ -291,13 +277,24 @@ static int process_cq_ring(AioContext *ctx, AioHandlerList *ready_list)
 static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
                                int64_t timeout)
 {
+    struct __kernel_timespec ts;
     unsigned wait_nr = 1; /* block until at least one cqe is ready */
     int ret;
 
     if (timeout == 0) {
         wait_nr = 0; /* non-blocking */
     } else if (timeout > 0) {
-        add_timeout_sqe(ctx, timeout);
+        /* Add a timeout that self-cancels when another cqe becomes ready */
+        struct io_uring_sqe *sqe;
+
+        ts = (struct __kernel_timespec){
+            .tv_sec = timeout / NANOSECONDS_PER_SECOND,
+            .tv_nsec = timeout % NANOSECONDS_PER_SECOND,
+        };
+
+        sqe = get_sqe(ctx);
+        io_uring_prep_timeout(sqe, &ts, 1, 0);
+        io_uring_sqe_set_data(sqe, NULL);
     }
 
     fill_sq_ring(ctx);
-- 
2.51.1


