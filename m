Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17773C5B543
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXnL-0001bc-SX; Mon, 26 May 2025 09:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJXmc-0000G3-27; Mon, 26 May 2025 09:22:26 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJXmV-0000K0-V7; Mon, 26 May 2025 09:22:24 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 200DB44552;
 Mon, 26 May 2025 15:21:50 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v3 09/24] block: move drain outside of
 bdrv_try_change_aio_context()
Date: Mon, 26 May 2025 15:21:25 +0200
Message-Id: <20250526132140.1641377-10-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250526132140.1641377-1-f.ebner@proxmox.com>
References: <20250526132140.1641377-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

Convert the function to a _locked() version that has to be called with
the graph lock held and add a convenience wrapper that has to be
called with the graph unlocked, which drains and takes the lock
itself. Since bdrv_try_change_aio_context() is global state code, the
wrapper is too.

Callers are adapted to use the appropriate variant, depending on
whether the caller already holds the lock. In the
test_set_aio_context() unit test, prior drains can be removed, because
draining already happens inside the new wrapper.

Note that bdrv_attach_child_common_abort(), bdrv_attach_child_common()
and bdrv_root_unref_child() hold the graph lock and are not actually
allowed to drain either. This will be addressed in the following
commits.

Functions like qmp_blockdev_mirror() query the nodes to act on before
draining and locking. In theory, draining could invalidate those nodes.
This kind of issue is not addressed by these commits.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v3:
* Clarify that _locked() version was used iff caller already holds the
  graph lock.
* Mention that certain kinds of issues are not solved by these
  changes alone.
* Rebase on changes to previous patch.

 block.c                            | 58 ++++++++++++++++++++++--------
 blockdev.c                         | 15 +++++---
 include/block/block-global-state.h |  8 +++--
 tests/unit/test-bdrv-drain.c       |  4 ---
 4 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/block.c b/block.c
index 6f42c0f1ab..3aaacabf7f 100644
--- a/block.c
+++ b/block.c
@@ -3028,7 +3028,10 @@ static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
     bdrv_replace_child_noperm(s->child, NULL);
 
     if (bdrv_get_aio_context(bs) != s->old_child_ctx) {
-        bdrv_try_change_aio_context(bs, s->old_child_ctx, NULL, &error_abort);
+        bdrv_drain_all_begin();
+        bdrv_try_change_aio_context_locked(bs, s->old_child_ctx, NULL,
+                                           &error_abort);
+        bdrv_drain_all_end();
     }
 
     if (bdrv_child_get_parent_aio_context(s->child) != s->old_parent_ctx) {
@@ -3115,8 +3118,10 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
     parent_ctx = bdrv_child_get_parent_aio_context(new_child);
     if (child_ctx != parent_ctx) {
         Error *local_err = NULL;
-        int ret = bdrv_try_change_aio_context(child_bs, parent_ctx, NULL,
-                                              &local_err);
+        bdrv_drain_all_begin();
+        int ret = bdrv_try_change_aio_context_locked(child_bs, parent_ctx, NULL,
+                                                     &local_err);
+        bdrv_drain_all_end();
 
         if (ret < 0 && child_class->change_aio_ctx) {
             Transaction *aio_ctx_tran = tran_new();
@@ -3319,8 +3324,10 @@ void bdrv_root_unref_child(BdrvChild *child)
          * When the parent requiring a non-default AioContext is removed, the
          * node moves back to the main AioContext
          */
-        bdrv_try_change_aio_context(child_bs, qemu_get_aio_context(), NULL,
-                                    NULL);
+        bdrv_drain_all_begin();
+        bdrv_try_change_aio_context_locked(child_bs, qemu_get_aio_context(),
+                                           NULL, NULL);
+        bdrv_drain_all_end();
     }
 
     bdrv_schedule_unref(child_bs);
@@ -7719,9 +7726,13 @@ bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
  *
  * If ignore_child is not NULL, that child (and its subgraph) will not
  * be touched.
+ *
+ * Called with the graph lock held.
+ *
+ * Called while all bs are drained.
  */
-int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
-                                BdrvChild *ignore_child, Error **errp)
+int bdrv_try_change_aio_context_locked(BlockDriverState *bs, AioContext *ctx,
+                                       BdrvChild *ignore_child, Error **errp)
 {
     Transaction *tran;
     GHashTable *visited;
@@ -7730,17 +7741,15 @@ int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
 
     /*
      * Recursion phase: go through all nodes of the graph.
-     * Take care of checking that all nodes support changing AioContext
-     * and drain them, building a linear list of callbacks to run if everything
-     * is successful (the transaction itself).
+     * Take care of checking that all nodes support changing AioContext,
+     * building a linear list of callbacks to run if everything is successful
+     * (the transaction itself).
      */
     tran = tran_new();
     visited = g_hash_table_new(NULL, NULL);
     if (ignore_child) {
         g_hash_table_add(visited, ignore_child);
     }
-    bdrv_drain_all_begin();
-    bdrv_graph_rdlock_main_loop();
     ret = bdrv_change_aio_context(bs, ctx, visited, tran, errp);
     g_hash_table_destroy(visited);
 
@@ -7754,15 +7763,34 @@ int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
     if (!ret) {
         /* Just run clean() callbacks. No AioContext changed. */
         tran_abort(tran);
-        bdrv_graph_rdunlock_main_loop();
-        bdrv_drain_all_end();
         return -EPERM;
     }
 
     tran_commit(tran);
+    return 0;
+}
+
+/*
+ * Change bs's and recursively all of its parents' and children's AioContext
+ * to the given new context, returning an error if that isn't possible.
+ *
+ * If ignore_child is not NULL, that child (and its subgraph) will not
+ * be touched.
+ */
+int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
+                                BdrvChild *ignore_child, Error **errp)
+{
+    int ret;
+
+    GLOBAL_STATE_CODE();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
+    ret = bdrv_try_change_aio_context_locked(bs, ctx, ignore_child, errp);
     bdrv_graph_rdunlock_main_loop();
     bdrv_drain_all_end();
-    return 0;
+
+    return ret;
 }
 
 void bdrv_add_aio_context_notifier(BlockDriverState *bs,
diff --git a/blockdev.c b/blockdev.c
index 3982f9776b..750beba41f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3601,12 +3601,13 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     AioContext *new_context;
     BlockDriverState *bs;
 
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     bs = bdrv_find_node(node_name);
     if (!bs) {
         error_setg(errp, "Failed to find node with node-name='%s'", node_name);
-        return;
+        goto out;
     }
 
     /* Protects against accidents. */
@@ -3614,14 +3615,14 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
         error_setg(errp, "Node %s is associated with a BlockBackend and could "
                          "be in use (use force=true to override this check)",
                          node_name);
-        return;
+        goto out;
     }
 
     if (iothread->type == QTYPE_QSTRING) {
         IOThread *obj = iothread_by_id(iothread->u.s);
         if (!obj) {
             error_setg(errp, "Cannot find iothread %s", iothread->u.s);
-            return;
+            goto out;
         }
 
         new_context = iothread_get_aio_context(obj);
@@ -3629,7 +3630,11 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
         new_context = qemu_get_aio_context();
     }
 
-    bdrv_try_change_aio_context(bs, new_context, NULL, errp);
+    bdrv_try_change_aio_context_locked(bs, new_context, NULL, errp);
+
+out:
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
 }
 
 QemuOptsList qemu_common_drive_opts = {
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index aad160956a..91f249b5ad 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -278,8 +278,12 @@ bool GRAPH_RDLOCK
 bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
                               GHashTable *visited, Transaction *tran,
                               Error **errp);
-int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
-                                BdrvChild *ignore_child, Error **errp);
+int GRAPH_UNLOCKED
+bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
+                            BdrvChild *ignore_child, Error **errp);
+int GRAPH_RDLOCK
+bdrv_try_change_aio_context_locked(BlockDriverState *bs, AioContext *ctx,
+                                   BdrvChild *ignore_child, Error **errp);
 
 int GRAPH_RDLOCK bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz);
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo);
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 290cd2a70e..3185f3f429 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -1396,14 +1396,10 @@ static void test_set_aio_context(void)
     bs = bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
                               &error_abort);
 
-    bdrv_drained_begin(bs);
     bdrv_try_change_aio_context(bs, ctx_a, NULL, &error_abort);
-    bdrv_drained_end(bs);
 
-    bdrv_drained_begin(bs);
     bdrv_try_change_aio_context(bs, ctx_b, NULL, &error_abort);
     bdrv_try_change_aio_context(bs, qemu_get_aio_context(), NULL, &error_abort);
-    bdrv_drained_end(bs);
 
     bdrv_unref(bs);
     iothread_join(a);
-- 
2.39.5



