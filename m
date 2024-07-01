Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA35C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFR9-0004wP-VW; Mon, 01 Jul 2024 07:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w.bumiller@proxmox.com>)
 id 1sOFQm-0004ol-MR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:42:50 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w.bumiller@proxmox.com>)
 id 1sOFQf-0006hQ-8T
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:42:48 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3B40445F0E;
 Mon,  1 Jul 2024 13:42:31 +0200 (CEST)
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 2/2] atomics: replace fetch-use-store with direct atomic
 operations
Date: Mon,  1 Jul 2024 13:42:30 +0200
Message-Id: <20240701114230.193307-3-w.bumiller@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701114230.193307-1-w.bumiller@proxmox.com>
References: <20240701114230.193307-1-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=w.bumiller@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Replaces the pattern `atomic_store(atomic_load() <op> something)`
pattern with its direct atomic function.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
Note: these previously used RELEASE ordering for the store and `relaxed`
ordering for the reads, while the replacement uses SEQ_CST, as there are no
other wrappers around yet.  Should we add `qatomic_fetch_{sub,and}_release`
variants?

 util/aio-posix.c | 3 +--
 util/aio-win32.c | 3 +--
 util/async.c     | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 266c9dd35f..9cf7fed8fc 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -672,8 +672,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     if (use_notify_me) {
         /* Finish the poll before clearing the flag.  */
-        qatomic_store_release(&ctx->notify_me,
-                             qatomic_read(&ctx->notify_me) - 2);
+        qatomic_fetch_sub(&ctx->notify_me, 2);
     }
 
     aio_notify_accept(ctx);
diff --git a/util/aio-win32.c b/util/aio-win32.c
index d144f9391f..ff6d1ebf97 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -387,8 +387,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
         ret = WaitForMultipleObjects(count, events, FALSE, timeout);
         if (blocking) {
             assert(first);
-            qatomic_store_release(&ctx->notify_me,
-                                  qatomic_read(&ctx->notify_me) - 2);
+            qatomic_fetch_sub(&ctx->notify_me, 2);
             aio_notify_accept(ctx);
         }
 
diff --git a/util/async.c b/util/async.c
index 0467890052..d17deeceea 100644
--- a/util/async.c
+++ b/util/async.c
@@ -330,7 +330,7 @@ aio_ctx_check(GSource *source)
     BHListSlice *s;
 
     /* Finish computing the timeout before clearing the flag.  */
-    qatomic_store_release(&ctx->notify_me, qatomic_read(&ctx->notify_me) & ~1);
+    qatomic_fetch_and(&ctx->notify_me, ~1);
     aio_notify_accept(ctx);
 
     QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
-- 
2.39.2



