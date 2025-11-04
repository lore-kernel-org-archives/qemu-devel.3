Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A304CCF9F8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6oM-000791-CN; Mon, 03 Nov 2025 21:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6oG-00074Q-GI
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6oE-0004BJ-4t
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762223409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwmgTSPPa1aT3tU4uAKxn1GGK2rmmhDBlB2T7FCydDE=;
 b=ENvcaBTlzF7iuPPs5EtHctJuV2bg+B+lmf/0kWk9rqn7sETQGVhWKahGwSJZ9wyDZOfcLs
 5yA4Z5zibrVLojT2ERKCmpIOfJI6fz2XwhXWhcYJbpyadBLoxnRS6nJmv855JM0CpqZP8c
 cKO+ZQERdVvVa2E1vMAXGRcZjX6/9Rg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-cJod-fAkM4y_Mm5kajhRCQ-1; Mon,
 03 Nov 2025 21:30:04 -0500
X-MC-Unique: cJod-fAkM4y_Mm5kajhRCQ-1
X-Mimecast-MFC-AGG-ID: cJod-fAkM4y_Mm5kajhRCQ_1762223403
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FC8B1956080; Tue,  4 Nov 2025 02:30:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E7FD19560A2; Tue,  4 Nov 2025 02:30:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com
Subject: [PATCH v6 10/15] aio-posix: gracefully handle io_uring_queue_init()
 failure
Date: Mon,  3 Nov 2025 21:29:28 -0500
Message-ID: <20251104022933.618123-11-stefanha@redhat.com>
In-Reply-To: <20251104022933.618123-1-stefanha@redhat.com>
References: <20251104022933.618123-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

io_uring may not be available at runtime due to system policies (e.g.
the io_uring_disabled sysctl) or creation could fail due to file
descriptor resource limits.

Handle failure scenarios as follows:

If another AioContext already has io_uring, then fail AioContext
creation so that the aio_add_sqe() API is available uniformly from all
QEMU threads. Otherwise fall back to epoll(7) if io_uring is
unavailable.

Notes:
- Update the comment about selecting the fastest fdmon implementation.
  At this point it's not about speed anymore, it's about aio_add_sqe()
  API availability.
- Uppercase the error message when converting from error_report() to
  error_setg_errno() for consistency (but there are instances of
  lowercase in the codebase).
- It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
v5:
- Indicate error in return value from function with Error *errp arg [Kevin]
---
 util/aio-posix.h      | 12 ++----------
 util/aio-posix.c      | 28 +++++++++++++++++++++++++---
 util/fdmon-io_uring.c |  5 +++--
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/util/aio-posix.h b/util/aio-posix.h
index f9994ed79e..dfa1a51c0b 100644
--- a/util/aio-posix.h
+++ b/util/aio-posix.h
@@ -18,6 +18,7 @@
 #define AIO_POSIX_H
 
 #include "block/aio.h"
+#include "qapi/error.h"
 
 struct AioHandler {
     GPollFD pfd;
@@ -72,17 +73,8 @@ static inline void fdmon_epoll_disable(AioContext *ctx)
 #endif /* !CONFIG_EPOLL_CREATE1 */
 
 #ifdef CONFIG_LINUX_IO_URING
-bool fdmon_io_uring_setup(AioContext *ctx);
+bool fdmon_io_uring_setup(AioContext *ctx, Error **errp);
 void fdmon_io_uring_destroy(AioContext *ctx);
-#else
-static inline bool fdmon_io_uring_setup(AioContext *ctx)
-{
-    return false;
-}
-
-static inline void fdmon_io_uring_destroy(AioContext *ctx)
-{
-}
 #endif /* !CONFIG_LINUX_IO_URING */
 
 #endif /* AIO_POSIX_H */
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 9806a75c12..c0285a26a3 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "block/block.h"
 #include "block/thread-pool.h"
+#include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "qemu/lockcnt.h"
 #include "qemu/rcu.h"
@@ -724,10 +725,29 @@ bool aio_context_setup(AioContext *ctx, Error **errp)
     ctx->epollfd = -1;
     ctx->epollfd_tag = NULL;
 
-    /* Use the fastest fd monitoring implementation if available */
-    if (fdmon_io_uring_setup(ctx)) {
-        return true;
+#ifdef CONFIG_LINUX_IO_URING
+    {
+        static bool need_io_uring;
+        Error *local_err = NULL; /* ERRP_GUARD() doesn't handle error_abort */
+
+        /* io_uring takes precedence because it provides aio_add_sqe() support */
+        if (fdmon_io_uring_setup(ctx, &local_err)) {
+            /*
+             * If one AioContext gets io_uring, then all AioContexts need io_uring
+             * so that aio_add_sqe() support is available across all threads.
+             */
+            need_io_uring = true;
+            return true;
+        }
+        if (need_io_uring) {
+            error_propagate(errp, local_err);
+            return false;
+        }
+
+        /* Silently fall back on systems where io_uring is unavailable */
+        error_free(local_err);
     }
+#endif /* CONFIG_LINUX_IO_URING */
 
     fdmon_epoll_setup(ctx);
     return true;
@@ -735,7 +755,9 @@ bool aio_context_setup(AioContext *ctx, Error **errp)
 
 void aio_context_destroy(AioContext *ctx)
 {
+#ifdef CONFIG_LINUX_IO_URING
     fdmon_io_uring_destroy(ctx);
+#endif
 
     qemu_lockcnt_lock(&ctx->list_lock);
     fdmon_epoll_disable(ctx);
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 0a5ec5ead6..9f25d6d6db 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -45,6 +45,7 @@
 
 #include "qemu/osdep.h"
 #include <poll.h>
+#include "qapi/error.h"
 #include "qemu/rcu_queue.h"
 #include "aio-posix.h"
 
@@ -373,7 +374,7 @@ static const FDMonOps fdmon_io_uring_ops = {
     .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
 };
 
-bool fdmon_io_uring_setup(AioContext *ctx)
+bool fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 {
     int ret;
 
@@ -381,6 +382,7 @@ bool fdmon_io_uring_setup(AioContext *ctx)
 
     ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
     if (ret != 0) {
+        error_setg_errno(errp, -ret, "Failed to initialize io_uring");
         return false;
     }
 
@@ -388,7 +390,6 @@ bool fdmon_io_uring_setup(AioContext *ctx)
     ctx->fdmon_ops = &fdmon_io_uring_ops;
     ctx->io_uring_fd_tag = g_source_add_unix_fd(&ctx->source,
             ctx->fdmon_io_uring.ring_fd, G_IO_IN);
-
     return true;
 }
 
-- 
2.51.1


