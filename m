Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52EBC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqg0V-0002Hc-6P; Fri, 07 Mar 2025 17:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqg0E-0001xe-3q
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqg0B-0007qn-5u
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741385826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RaQQrEx2Ahh4c2BeaSu3GJgqvoChkJywKOm5eAsE82U=;
 b=SXNnZSALnqjIqvmNesxGVdWz2jIT613KFB0ThQxZh7Thb7XGe3An8R19aLOS4ldclHH/E6
 80KUpzC79Tb9X20GDVfWuToA0sD/FPdpRkMPnIniaqHiuZkE9fsKgPHFZDO2alHo3Mkcn3
 v1UA7XxF7tCpzDxBaM3OF0xdALHGskU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-RAb5pKIAOBq8VZlPr3lolg-1; Fri,
 07 Mar 2025 17:17:03 -0500
X-MC-Unique: RAb5pKIAOBq8VZlPr3lolg-1
X-Mimecast-MFC-AGG-ID: RAb5pKIAOBq8VZlPr3lolg_1741385823
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02DC11800257; Fri,  7 Mar 2025 22:17:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95E31180174F; Fri,  7 Mar 2025 22:17:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 afaria@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 5/5] aio-posix: Separate AioPolledEvent per AioHandler
Date: Fri,  7 Mar 2025 23:16:34 +0100
Message-ID: <20250307221634.71951-6-kwolf@redhat.com>
In-Reply-To: <20250307221634.71951-1-kwolf@redhat.com>
References: <20250307221634.71951-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adaptive polling has a big problem: It doesn't consider that an event
loop can wait for many different events that may have very different
typical latencies.

For example, think of a guest that tends to send a new I/O request soon
after the previous I/O request completes, but the storage on the host is
rather slow. In this case, getting the new request from guest quickly
means that polling is enabled, but the next thing is performing the I/O
request on the backend, which is slow and disables polling again for the
next guest request. This means that in such a scenario, polling could
help for every other event, but is only ever enabled when it can't
succeed.

In order to fix this, keep a separate AioPolledEvent for each
AioHandler. We will then know that the backend file descriptor always
has a high latency and isn't worth polling for, but we also know that
the guest is always fast and we should poll for it. This solves at least
half of the problem, we can now keep polling for those cases where it
makes sense and get the improved performance from it.

Since the event loop doesn't know which event will be next, we still do
some unnecessary polling while we're waiting for the slow disk. I made
some attempts to be more clever than just randomly growing and shrinking
the polling time, and even to let callers be explicit about when they
expect a new event, but so far this hasn't resulted in improved
performance or even caused performance regressions. For now, let's just
fix the part that is easy enough to fix, we can revisit the rest later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h |  1 -
 util/aio-posix.h    |  1 +
 util/aio-posix.c    | 24 +++++++++++++++++++++---
 util/async.c        |  2 --
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 49f46e01cb..0ef7ce48e3 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -233,7 +233,6 @@ struct AioContext {
     int poll_disable_cnt;
 
     /* Polling mode parameters */
-    AioPolledEvent poll;
     int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
     int64_t poll_grow;      /* polling time growth factor */
     int64_t poll_shrink;    /* polling time shrink factor */
diff --git a/util/aio-posix.h b/util/aio-posix.h
index 4264c518be..82a0201ea4 100644
--- a/util/aio-posix.h
+++ b/util/aio-posix.h
@@ -38,6 +38,7 @@ struct AioHandler {
 #endif
     int64_t poll_idle_timeout; /* when to stop userspace polling */
     bool poll_ready; /* has polling detected an event? */
+    AioPolledEvent poll;
 };
 
 /* Add a handler to a ready list */
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 259827c7ad..2251871c61 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -579,13 +579,19 @@ static bool run_poll_handlers(AioContext *ctx, AioHandlerList *ready_list,
 static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
                           int64_t *timeout)
 {
+    AioHandler *node;
     int64_t max_ns;
 
     if (QLIST_EMPTY_RCU(&ctx->poll_aio_handlers)) {
         return false;
     }
 
-    max_ns = qemu_soonest_timeout(*timeout, ctx->poll.ns);
+    max_ns = 0;
+    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
+        max_ns = MAX(max_ns, node->poll.ns);
+    }
+    max_ns = qemu_soonest_timeout(*timeout, max_ns);
+
     if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {
         /*
          * Enable poll mode. It pairs with the poll_set_started() in
@@ -721,8 +727,14 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     /* Adjust polling time */
     if (ctx->poll_max_ns) {
+        AioHandler *node;
         int64_t block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
-        adjust_polling_time(ctx, &ctx->poll, block_ns);
+
+        QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
+            if (QLIST_IS_INSERTED(node, node_ready)) {
+                adjust_polling_time(ctx, &node->poll, block_ns);
+            }
+        }
     }
 
     progress |= aio_bh_poll(ctx);
@@ -772,10 +784,16 @@ void aio_context_use_g_source(AioContext *ctx)
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink, Error **errp)
 {
+    AioHandler *node;
+
     /* No thread synchronization here, it doesn't matter if an incorrect value
      * is used once.
      */
-    ctx->poll.ns = 0;
+    qemu_lockcnt_inc(&ctx->list_lock);
+    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+        node->poll.ns = 0;
+    }
+    qemu_lockcnt_dec(&ctx->list_lock);
 
     ctx->poll_max_ns = max_ns;
     ctx->poll_grow = grow;
diff --git a/util/async.c b/util/async.c
index 38667ea091..4124a948fd 100644
--- a/util/async.c
+++ b/util/async.c
@@ -609,8 +609,6 @@ AioContext *aio_context_new(Error **errp)
     qemu_rec_mutex_init(&ctx->lock);
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
 
-    ctx->poll.ns = 0;
-
     ctx->poll_max_ns = 0;
     ctx->poll_grow = 0;
     ctx->poll_shrink = 0;
-- 
2.48.1


