Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B6DC3ABCE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 00:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqLxp-0005xU-95; Mon, 16 Sep 2024 20:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1sqLxn-0005uI-4C; Mon, 16 Sep 2024 20:21:03 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1sqLxl-0004iG-EW; Mon, 16 Sep 2024 20:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=Nrke67M5HbQb77S+rBVnhrZgSHRJPyGRRcIssR0RjZo=; b=oCmR8LgvzKyOXlxt
 /jbN7jBjp11ymBguohGHuw7J86coDArWoosc+Uj/SKVtoe0h9XA+OcI+xBZHO1KFlTTwY1Muffhp4
 Z4bs+u/xV+yI2ybQtHtNTkLn1z2WEKzSrbrSE+MKA9s6T0WJKg1cgcbb5Mmctc/6hyazFeZMjbCiE
 OhmVF9QQOnwpkS0jmAo3P62yvPlbtvBlYjm9VFPWclc9FiKfMBAteOJajAKdK7uTMkB8He0gCPV8P
 BE7Gqs6lOhjsni2Wn8F3taZDaFiEidJbQNpw5ZnR3wjXKivXQsBezn8CfbrQxpBfpqKaFOwIUe/ku
 43MWUlNeVB6QEfTCCQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqLxi-0062nc-1l;
 Tue, 17 Sep 2024 00:20:58 +0000
From: dave@treblig.org
To: kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] block-backend: Remove deadcode
Date: Tue, 17 Sep 2024 01:20:56 +0100
Message-ID: <20240917002056.330818-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

blk_by_public last use was removed in 2017 by
  c61791fc23 ("block: add aio_context field in ThrottleGroupMember")

blk_activate last use was removed earlier this year by
  eef0bae3a7 ("migration: Remove block migration")

blk_add_insert_bs_notifier, blk_op_block_all, blk_op_unblock_all
last uses were removed in 2016 by
  ef8875b549 ("virtio-scsi: Remove op blocker for dataplane")

blk_iostatus_disable last use was removed in 2016 by
  66a0fae438 ("blockjob: Don't touch BDS iostatus")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 block/block-backend.c                       | 73 ---------------------
 include/sysemu/block-backend-global-state.h |  8 ---
 2 files changed, 81 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index db6f9b92a3..7bea43bf72 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -853,15 +853,6 @@ BlockBackendPublic *blk_get_public(BlockBackend *blk)
     return &blk->public;
 }
 
-/*
- * Returns a BlockBackend given the associated @public fields.
- */
-BlockBackend *blk_by_public(BlockBackendPublic *public)
-{
-    GLOBAL_STATE_CODE();
-    return container_of(public, BlockBackend, public);
-}
-
 /*
  * Disassociates the currently associated BlockDriverState from @blk.
  */
@@ -1214,12 +1205,6 @@ BlockDeviceIoStatus blk_iostatus(const BlockBackend *blk)
     return blk->iostatus;
 }
 
-void blk_iostatus_disable(BlockBackend *blk)
-{
-    GLOBAL_STATE_CODE();
-    blk->iostatus_enabled = false;
-}
-
 void blk_iostatus_reset(BlockBackend *blk)
 {
     GLOBAL_STATE_CODE();
@@ -2228,28 +2213,6 @@ void blk_set_enable_write_cache(BlockBackend *blk, bool wce)
     blk->enable_write_cache = wce;
 }
 
-void blk_activate(BlockBackend *blk, Error **errp)
-{
-    BlockDriverState *bs = blk_bs(blk);
-    GLOBAL_STATE_CODE();
-
-    if (!bs) {
-        error_setg(errp, "Device '%s' has no medium", blk->name);
-        return;
-    }
-
-    /*
-     * Migration code can call this function in coroutine context, so leave
-     * coroutine context if necessary.
-     */
-    if (qemu_in_coroutine()) {
-        bdrv_co_activate(bs, errp);
-    } else {
-        GRAPH_RDLOCK_GUARD_MAINLOOP();
-        bdrv_activate(bs, errp);
-    }
-}
-
 bool coroutine_fn blk_co_is_inserted(BlockBackend *blk)
 {
     BlockDriverState *bs = blk_bs(blk);
@@ -2380,36 +2343,6 @@ bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp)
     return bdrv_op_is_blocked(bs, op, errp);
 }
 
-void blk_op_unblock(BlockBackend *blk, BlockOpType op, Error *reason)
-{
-    BlockDriverState *bs = blk_bs(blk);
-    GLOBAL_STATE_CODE();
-
-    if (bs) {
-        bdrv_op_unblock(bs, op, reason);
-    }
-}
-
-void blk_op_block_all(BlockBackend *blk, Error *reason)
-{
-    BlockDriverState *bs = blk_bs(blk);
-    GLOBAL_STATE_CODE();
-
-    if (bs) {
-        bdrv_op_block_all(bs, reason);
-    }
-}
-
-void blk_op_unblock_all(BlockBackend *blk, Error *reason)
-{
-    BlockDriverState *bs = blk_bs(blk);
-    GLOBAL_STATE_CODE();
-
-    if (bs) {
-        bdrv_op_unblock_all(bs, reason);
-    }
-}
-
 /**
  * Return BB's current AioContext.  Note that this context may change
  * concurrently at any time, with one exception: If the BB has a root node
@@ -2564,12 +2497,6 @@ void blk_add_remove_bs_notifier(BlockBackend *blk, Notifier *notify)
     notifier_list_add(&blk->remove_bs_notifiers, notify);
 }
 
-void blk_add_insert_bs_notifier(BlockBackend *blk, Notifier *notify)
-{
-    GLOBAL_STATE_CODE();
-    notifier_list_add(&blk->insert_bs_notifiers, notify);
-}
-
 BlockAcctStats *blk_get_stats(BlockBackend *blk)
 {
     IO_CODE();
diff --git a/include/sysemu/block-backend-global-state.h b/include/sysemu/block-backend-global-state.h
index 49c12b0fa9..9cc9b008ec 100644
--- a/include/sysemu/block-backend-global-state.h
+++ b/include/sysemu/block-backend-global-state.h
@@ -54,7 +54,6 @@ bool monitor_add_blk(BlockBackend *blk, const char *name, Error **errp);
 void monitor_remove_blk(BlockBackend *blk);
 
 BlockBackendPublic *blk_get_public(BlockBackend *blk);
-BlockBackend *blk_by_public(BlockBackendPublic *public);
 
 void blk_remove_bs(BlockBackend *blk);
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp);
@@ -67,7 +66,6 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm);
 
 void blk_iostatus_enable(BlockBackend *blk);
 BlockDeviceIoStatus blk_iostatus(const BlockBackend *blk);
-void blk_iostatus_disable(BlockBackend *blk);
 void blk_iostatus_reset(BlockBackend *blk);
 int blk_attach_dev(BlockBackend *blk, DeviceState *dev);
 void blk_detach_dev(BlockBackend *blk, DeviceState *dev);
@@ -76,8 +74,6 @@ BlockBackend *blk_by_dev(void *dev);
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
 void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
 
-void blk_activate(BlockBackend *blk, Error **errp);
-
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
 void blk_aio_cancel(BlockAIOCB *acb);
 int blk_commit_all(void);
@@ -91,9 +87,6 @@ bool blk_is_sg(BlockBackend *blk);
 void blk_set_enable_write_cache(BlockBackend *blk, bool wce);
 int blk_get_flags(BlockBackend *blk);
 bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp);
-void blk_op_unblock(BlockBackend *blk, BlockOpType op, Error *reason);
-void blk_op_block_all(BlockBackend *blk, Error *reason);
-void blk_op_unblock_all(BlockBackend *blk, Error *reason);
 int blk_set_aio_context(BlockBackend *blk, AioContext *new_context,
                         Error **errp);
 void blk_add_aio_context_notifier(BlockBackend *blk,
@@ -105,7 +98,6 @@ void blk_remove_aio_context_notifier(BlockBackend *blk,
                                      void (*detach_aio_context)(void *),
                                      void *opaque);
 void blk_add_remove_bs_notifier(BlockBackend *blk, Notifier *notify);
-void blk_add_insert_bs_notifier(BlockBackend *blk, Notifier *notify);
 BlockBackendRootState *blk_get_root_state(BlockBackend *blk);
 void blk_update_root_state(BlockBackend *blk);
 bool blk_get_detect_zeroes_from_root_state(BlockBackend *blk);
-- 
2.46.0


