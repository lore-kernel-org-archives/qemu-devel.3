Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC08C28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqg0c-0002Xm-QR; Fri, 07 Mar 2025 17:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqg0E-0001xd-3Y
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqg08-0007qH-6T
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741385823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJL3WPQI5s6cGIM3kVhEFn9DBhYrLWjKFlvy/ltL1tc=;
 b=cU76rhm/KPTMR5WYnVNkp/gV3a5QqA2D4IBkD9880MNI7dgbFrUWsgpvVPe6rX8OzItzt8
 qKfCe42yGUn8I4g7M242PzOv6bK69kZVTGouPsXSR7DWqcchSrCNrMvt+0146lVGG8Gsqg
 cRgHzAFOMTvRew5Ho64eiZ5DysSofW8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-zmfypdpMMjmcEs2UiIXejA-1; Fri,
 07 Mar 2025 17:17:01 -0500
X-MC-Unique: zmfypdpMMjmcEs2UiIXejA-1
X-Mimecast-MFC-AGG-ID: zmfypdpMMjmcEs2UiIXejA_1741385820
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FB8E18004A9; Fri,  7 Mar 2025 22:17:00 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2CA018009BC; Fri,  7 Mar 2025 22:16:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 afaria@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 4/5] aio-posix: Factor out adjust_polling_time()
Date: Fri,  7 Mar 2025 23:16:33 +0100
Message-ID: <20250307221634.71951-5-kwolf@redhat.com>
In-Reply-To: <20250307221634.71951-1-kwolf@redhat.com>
References: <20250307221634.71951-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/aio-posix.c | 77 ++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 95bddb9e4b..259827c7ad 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -600,6 +600,46 @@ static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
     return false;
 }
 
+static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
+                                int64_t block_ns)
+{
+    if (block_ns <= poll->ns) {
+        /* This is the sweet spot, no adjustment needed */
+    } else if (block_ns > ctx->poll_max_ns) {
+        /* We'd have to poll for too long, poll less */
+        int64_t old = poll->ns;
+
+        if (ctx->poll_shrink) {
+            poll->ns /= ctx->poll_shrink;
+        } else {
+            poll->ns = 0;
+        }
+
+        trace_poll_shrink(ctx, old, poll->ns);
+    } else if (poll->ns < ctx->poll_max_ns &&
+               block_ns < ctx->poll_max_ns) {
+        /* There is room to grow, poll longer */
+        int64_t old = poll->ns;
+        int64_t grow = ctx->poll_grow;
+
+        if (grow == 0) {
+            grow = 2;
+        }
+
+        if (poll->ns) {
+            poll->ns *= grow;
+        } else {
+            poll->ns = 4000; /* start polling at 4 microseconds */
+        }
+
+        if (poll->ns > ctx->poll_max_ns) {
+            poll->ns = ctx->poll_max_ns;
+        }
+
+        trace_poll_grow(ctx, old, poll->ns);
+    }
+}
+
 bool aio_poll(AioContext *ctx, bool blocking)
 {
     AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
@@ -682,42 +722,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     /* Adjust polling time */
     if (ctx->poll_max_ns) {
         int64_t block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
-
-        if (block_ns <= ctx->poll.ns) {
-            /* This is the sweet spot, no adjustment needed */
-        } else if (block_ns > ctx->poll_max_ns) {
-            /* We'd have to poll for too long, poll less */
-            int64_t old = ctx->poll.ns;
-
-            if (ctx->poll_shrink) {
-                ctx->poll.ns /= ctx->poll_shrink;
-            } else {
-                ctx->poll.ns = 0;
-            }
-
-            trace_poll_shrink(ctx, old, ctx->poll.ns);
-        } else if (ctx->poll.ns < ctx->poll_max_ns &&
-                   block_ns < ctx->poll_max_ns) {
-            /* There is room to grow, poll longer */
-            int64_t old = ctx->poll.ns;
-            int64_t grow = ctx->poll_grow;
-
-            if (grow == 0) {
-                grow = 2;
-            }
-
-            if (ctx->poll.ns) {
-                ctx->poll.ns *= grow;
-            } else {
-                ctx->poll.ns = 4000; /* start polling at 4 microseconds */
-            }
-
-            if (ctx->poll.ns > ctx->poll_max_ns) {
-                ctx->poll.ns = ctx->poll_max_ns;
-            }
-
-            trace_poll_grow(ctx, old, ctx->poll.ns);
-        }
+        adjust_polling_time(ctx, &ctx->poll, block_ns);
     }
 
     progress |= aio_bh_poll(ctx);
-- 
2.48.1


