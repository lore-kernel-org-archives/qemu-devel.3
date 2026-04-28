Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46276FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHf9s-0004Oq-Rt; Tue, 28 Apr 2026 05:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHf9q-0004Ng-LI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:55:10 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHf9o-00082r-7O
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1777370096; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=EuN8QYLMABegW93bH0lChbTIz1DIZ96znFN8/Pwg8g0=;
 b=arbr+yMKCgMws/ofydjSXa3FM2HjHQ6mATwSzohjXsdhtwtwPkUUAmXDwCacqIaV3peSPgLAszMU6vrRCiNuukBPYRRrzcJEqp64PZaSQdlXRYR4iCdiw7j83hEKUDO80BYftnzsAS7R0GdQiLfXR4sUuOt3komOC8FZoxPoupg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X1uDXNA_1777370091; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X1uDXNA_1777370091 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 28 Apr 2026 17:54:56 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org
Subject: [PATCH 1/2] util/aio-posix: fix poll_ready handlers dropped in
 aio_prepare()
Date: Tue, 28 Apr 2026 17:54:50 +0800
Message-ID: <20260428095450.77419-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When aio_prepare() calls poll_set_started(ctx, &ready_list, false) to
disable poll mode, the last poll round may find ready handlers and mark
them poll_ready=true while inserting them into a local ready_list.
However, that local list is discarded on function return, so those
handlers are silently dropped and must wait until the next GLib main
loop iteration to be processed.

This was noted by commit 826cc32423 as a TODO comment:
  /* TODO what to do with this list? */

Fix this by:
- Extending aio_pending() to scan poll_aio_handlers for any node with
  poll_ready=true, so GLib's check phase correctly reports pending work
  and triggers dispatch.
- Collecting poll_ready handlers in aio_dispatch() before calling
  aio_dispatch_ready_handlers(), so they are actually executed in the
  same dispatch cycle.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 util/aio-posix.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 488d964611..633bffd716 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -255,9 +255,12 @@ bool aio_prepare(AioContext *ctx)
 {
     AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
 
-    /* Poll mode cannot be used with glib's event loop, disable it. */
+    /*
+     * Poll mode cannot be used with glib's event loop, disable it.
+     * Any handlers that fire in the last poll are marked poll_ready=true
+     * and will be picked up by aio_pending() / aio_dispatch().
+     */
     poll_set_started(ctx, &ready_list, false);
-    /* TODO what to do with this list? */
 
     ctx->fdmon_ops->gsource_prepare(ctx);
     return false;
@@ -265,7 +268,25 @@ bool aio_prepare(AioContext *ctx)
 
 bool aio_pending(AioContext *ctx)
 {
-    return ctx->fdmon_ops->gsource_check(ctx);
+    AioHandler *node;
+
+    if (ctx->fdmon_ops->gsource_check(ctx)) {
+        return true;
+    }
+
+    /*
+     * Check if any poll handlers became ready during aio_prepare()'s
+     * last poll (when poll mode is stopped, poll_set_started(false)).
+     */
+    qemu_lockcnt_inc(&ctx->list_lock);
+    QLIST_FOREACH_RCU(node, &ctx->poll_aio_handlers, node_poll) {
+        if (!QLIST_IS_INSERTED(node, node_deleted) && node->poll_ready) {
+            qemu_lockcnt_dec(&ctx->list_lock);
+            return true;
+        }
+    }
+    qemu_lockcnt_dec(&ctx->list_lock);
+    return false;
 }
 
 static void aio_free_deleted_handlers(AioContext *ctx)
@@ -395,6 +416,16 @@ void aio_dispatch(AioContext *ctx)
         ctx->fdmon_ops->dispatch(ctx);
     }
 
+    /* Collect handlers that became ready during aio_prepare()'s last poll */
+    {
+        AioHandler *node;
+        QLIST_FOREACH_RCU(node, &ctx->poll_aio_handlers, node_poll) {
+            if (!QLIST_IS_INSERTED(node, node_deleted) && node->poll_ready) {
+                aio_add_poll_ready_handler(&ready_list, node);
+            }
+        }
+    }
+
     /* block_ns is 0 because polling is disabled in the glib event loop */
     aio_dispatch_ready_handlers(ctx, &ready_list, 0);
 
-- 
2.50.1 (Apple Git-155)


