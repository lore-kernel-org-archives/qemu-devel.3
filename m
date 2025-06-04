Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFCAC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsML-0002SZ-V2; Wed, 04 Jun 2025 13:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM8-0002HM-Pc
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM2-0000RY-5A
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WVTPl2xJxIHd7bd/R0wzw8RdW6bS95C72o/1lBqTgxI=;
 b=OhWWGLXbUPRb4bwbJA90gYJHjm8sErwI2CuKBLjWE3ooL+X8H9BEZyzI9kZ+52kfKwURP8
 FhzqqVyPdIFpcEgc2LBRy0AFzQbOHozerO93K70ygtj70wd2GvmoKGzpujmckmTB70muy3
 kdNvIQEurkVtxYVoKR0nz8uUlV7TikE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-Vs3xXsJFML6q8Q8IMQiwkg-1; Wed,
 04 Jun 2025 13:56:38 -0400
X-MC-Unique: Vs3xXsJFML6q8Q8IMQiwkg-1
X-Mimecast-MFC-AGG-ID: Vs3xXsJFML6q8Q8IMQiwkg_1749059797
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B56DB18001D0; Wed,  4 Jun 2025 17:56:37 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7232118003FD; Wed,  4 Jun 2025 17:56:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 10/24] block: move drain outside of
 bdrv_attach_child_common(_abort)()
Date: Wed,  4 Jun 2025 19:55:59 +0200
Message-ID: <20250604175613.344113-11-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

The function bdrv_attach_child_common_abort() is used only as the
abort callback in bdrv_attach_child_common_drv transactions, so the
tran_finalize() calls of such transactions need to be in drained
sections too.

All code paths are covered:
The bdrv_attach_child_common_drv transactions are only used in
bdrv_attach_child_common(), so it is enough to check callers of
bdrv_attach_child_common() following the transactions.

bdrv_attach_child_common() is called by:
1. bdrv_attach_child_noperm(), which does not finalize the
   transaction yet.
2. bdrv_root_attach_child(), where a drained section is introduced.

bdrv_attach_child_noperm() is called by:
1. bdrv_attach_child(), where a drained section is introduced.
2. bdrv_set_file_or_backing_noperm(), which does not finalize the
   transaction yet.
3. bdrv_append(), where a drained section is introduced.

bdrv_set_file_or_backing_noperm() is called by:
1. bdrv_set_backing_hd_drained(), where a drained section is
   introduced.
2. bdrv_reopen_parse_file_or_backing(), which does not finalize the
   transaction yet. Draining the old child bs currently happens under
   the graph lock there. This is replaced with an assertion, because
   the drain will be moved further up to the caller.

bdrv_reopen_parse_file_or_backing() is called by:
1. bdrv_reopen_prepare(), which does not finalize the transaction yet.

bdrv_reopen_prepare() is called by:
1. bdrv_reopen_multiple(), which does finalize the transaction. It is
   called after bdrv_reopen_queue(), which starts a drained section.
   The drained section ends, when bdrv_reopen_queue_free() is called
   at the end of bdrv_reopen_multiple().

This resolves all code paths.

The functions bdrv_set_backing_hd_drained(), bdrv_attach_child() and
bdrv_root_attach_child() run under the graph lock, so they are not
actually allowed to drain. This will be addressed in the following
commits.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-11-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/block.c b/block.c
index 3aaacabf7f..46eb2fe449 100644
--- a/block.c
+++ b/block.c
@@ -3028,10 +3028,8 @@ static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
     bdrv_replace_child_noperm(s->child, NULL);
 
     if (bdrv_get_aio_context(bs) != s->old_child_ctx) {
-        bdrv_drain_all_begin();
         bdrv_try_change_aio_context_locked(bs, s->old_child_ctx, NULL,
                                            &error_abort);
-        bdrv_drain_all_end();
     }
 
     if (bdrv_child_get_parent_aio_context(s->child) != s->old_parent_ctx) {
@@ -3043,10 +3041,8 @@ static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
 
         /* No need to visit `child`, because it has been detached already */
         visited = g_hash_table_new(NULL, NULL);
-        bdrv_drain_all_begin();
         ret = s->child->klass->change_aio_ctx(s->child, s->old_parent_ctx,
                                               visited, tran, &error_abort);
-        bdrv_drain_all_end();
         g_hash_table_destroy(visited);
 
         /* transaction is supposed to always succeed */
@@ -3075,6 +3071,9 @@ static TransactionActionDrv bdrv_attach_child_common_drv = {
  *
  * Both @parent_bs and @child_bs can move to a different AioContext in this
  * function.
+ *
+ * All block nodes must be drained before this function is called until after
+ * the transaction is finalized.
  */
 static BdrvChild * GRAPH_WRLOCK
 bdrv_attach_child_common(BlockDriverState *child_bs,
@@ -3118,10 +3117,8 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
     parent_ctx = bdrv_child_get_parent_aio_context(new_child);
     if (child_ctx != parent_ctx) {
         Error *local_err = NULL;
-        bdrv_drain_all_begin();
         int ret = bdrv_try_change_aio_context_locked(child_bs, parent_ctx, NULL,
                                                      &local_err);
-        bdrv_drain_all_end();
 
         if (ret < 0 && child_class->change_aio_ctx) {
             Transaction *aio_ctx_tran = tran_new();
@@ -3129,11 +3126,9 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
             bool ret_child;
 
             g_hash_table_add(visited, new_child);
-            bdrv_drain_all_begin();
             ret_child = child_class->change_aio_ctx(new_child, child_ctx,
                                                     visited, aio_ctx_tran,
                                                     NULL);
-            bdrv_drain_all_end();
             if (ret_child == true) {
                 error_free(local_err);
                 ret = 0;
@@ -3189,6 +3184,9 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
  *
  * After calling this function, the transaction @tran may only be completed
  * while holding a writer lock for the graph.
+ *
+ * All block nodes must be drained before this function is called until after
+ * the transaction is finalized.
  */
 static BdrvChild * GRAPH_WRLOCK
 bdrv_attach_child_noperm(BlockDriverState *parent_bs,
@@ -3244,6 +3242,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 
     GLOBAL_STATE_CODE();
 
+    bdrv_drain_all_begin();
     child = bdrv_attach_child_common(child_bs, child_name, child_class,
                                    child_role, perm, shared_perm, opaque,
                                    tran, errp);
@@ -3256,6 +3255,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 
 out:
     tran_finalize(tran, ret);
+    bdrv_drain_all_end();
 
     bdrv_schedule_unref(child_bs);
 
@@ -3283,6 +3283,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
     GLOBAL_STATE_CODE();
 
+    bdrv_drain_all_begin();
     child = bdrv_attach_child_noperm(parent_bs, child_bs, child_name,
                                      child_class, child_role, tran, errp);
     if (!child) {
@@ -3297,6 +3298,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
 out:
     tran_finalize(tran, ret);
+    bdrv_drain_all_end();
 
     bdrv_schedule_unref(child_bs);
 
@@ -3465,6 +3467,9 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
  *
  * After calling this function, the transaction @tran may only be completed
  * while holding a writer lock for the graph.
+ *
+ * All block nodes must be drained before this function is called until after
+ * the transaction is finalized.
  */
 static int GRAPH_WRLOCK
 bdrv_set_file_or_backing_noperm(BlockDriverState *parent_bs,
@@ -3573,6 +3578,7 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
         assert(bs->backing->bs->quiesce_counter > 0);
     }
 
+    bdrv_drain_all_begin();
     ret = bdrv_set_file_or_backing_noperm(bs, backing_hd, true, tran, errp);
     if (ret < 0) {
         goto out;
@@ -3581,6 +3587,7 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
     ret = bdrv_refresh_perms(bs, tran, errp);
 out:
     tran_finalize(tran, ret);
+    bdrv_drain_all_end();
     return ret;
 }
 
@@ -4721,6 +4728,9 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
  * Return 0 on success, otherwise return < 0 and set @errp.
  *
  * @reopen_state->bs can move to a different AioContext in this function.
+ *
+ * All block nodes must be drained before this function is called until after
+ * the transaction is finalized.
  */
 static int GRAPH_UNLOCKED
 bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
@@ -4814,7 +4824,7 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
 
     if (old_child_bs) {
         bdrv_ref(old_child_bs);
-        bdrv_drained_begin(old_child_bs);
+        assert(old_child_bs->quiesce_counter > 0);
     }
 
     bdrv_graph_rdunlock_main_loop();
@@ -4826,7 +4836,6 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
     bdrv_graph_wrunlock();
 
     if (old_child_bs) {
-        bdrv_drained_end(old_child_bs);
         bdrv_unref(old_child_bs);
     }
 
@@ -4855,6 +4864,9 @@ out_rdlock:
  *
  * After calling this function, the transaction @change_child_tran may only be
  * completed while holding a writer lock for the graph.
+ *
+ * All block nodes must be drained before this function is called until after
+ * the transaction is finalized.
  */
 static int GRAPH_UNLOCKED
 bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
@@ -5501,9 +5513,7 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
     assert(!bs_new->backing);
     bdrv_graph_rdunlock_main_loop();
 
-    bdrv_drained_begin(bs_top);
-    bdrv_drained_begin(bs_new);
-
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     child = bdrv_attach_child_noperm(bs_new, bs_top, "backing",
@@ -5525,9 +5535,7 @@ out:
 
     bdrv_refresh_limits(bs_top, NULL, NULL);
     bdrv_graph_wrunlock();
-
-    bdrv_drained_end(bs_top);
-    bdrv_drained_end(bs_new);
+    bdrv_drain_all_end();
 
     return ret;
 }
-- 
2.49.0


