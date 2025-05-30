Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFFBC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Pc-0004Zk-3w; Fri, 30 May 2025 11:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PX-0004MN-FL; Fri, 30 May 2025 11:12:43 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PV-0002Kn-D9; Fri, 30 May 2025 11:12:43 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9791744B62;
 Fri, 30 May 2025 17:11:48 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 37/48] block: mark blk_remove_bs() as GRAPH_UNLOCKED
Date: Fri, 30 May 2025 17:11:14 +0200
Message-Id: <20250530151125.955508-38-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
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

The function blk_remove_bs() calls bdrv_graph_wrlock_drained() and can
also call bdrv_drained_begin(), both of which which must be called with
the graph unlocked.

Marking blk_remove_bs() as GRAPH_UNLOCKED requires temporarily
unlocking in hmp_drive_del().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/monitor/block-hmp-cmds.c              | 15 ++++++++++-----
 include/system/block-backend-global-state.h |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 6919a49bf5..282d1c386e 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -144,7 +144,7 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
     Error *local_err = NULL;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    bdrv_graph_rdlock_main_loop();
 
     bs = bdrv_find_node(id);
     if (bs) {
@@ -152,29 +152,31 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
         if (local_err) {
             error_report_err(local_err);
         }
-        return;
+        goto unlock;
     }
 
     blk = blk_by_name(id);
     if (!blk) {
         error_report("Device '%s' not found", id);
-        return;
+        goto unlock;
     }
 
     if (!blk_legacy_dinfo(blk)) {
         error_report("Deleting device added with blockdev-add"
                      " is not supported");
-        return;
+        goto unlock;
     }
 
     bs = blk_bs(blk);
     if (bs) {
         if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
             error_report_err(local_err);
-            return;
+            goto unlock;
         }
 
+        bdrv_graph_rdunlock_main_loop();
         blk_remove_bs(blk);
+        bdrv_graph_rdlock_main_loop();
     }
 
     /* Make the BlockBackend and the attached BlockDriverState anonymous */
@@ -191,6 +193,9 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
     } else {
         blk_unref(blk);
     }
+
+unlock:
+    bdrv_graph_rdunlock_main_loop();
 }
 
 void hmp_commit(Monitor *mon, const QDict *qdict)
diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
index a62dbdf0dc..1a134083b7 100644
--- a/include/system/block-backend-global-state.h
+++ b/include/system/block-backend-global-state.h
@@ -55,7 +55,7 @@ void monitor_remove_blk(BlockBackend *blk);
 
 BlockBackendPublic *blk_get_public(BlockBackend *blk);
 
-void blk_remove_bs(BlockBackend *blk);
+void GRAPH_UNLOCKED blk_remove_bs(BlockBackend *blk);
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp);
 int blk_replace_bs(BlockBackend *blk, BlockDriverState *new_bs, Error **errp);
 bool GRAPH_RDLOCK bdrv_has_blk(BlockDriverState *bs);
-- 
2.39.5



