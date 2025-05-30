Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE9BC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PX-0004NC-RW; Fri, 30 May 2025 11:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PV-0004GX-Oe; Fri, 30 May 2025 11:12:42 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PT-0002Jz-Uw; Fri, 30 May 2025 11:12:41 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CC67244B79;
 Fri, 30 May 2025 17:11:46 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 26/48] block/commit: switch to
 bdrv_set_backing_hd_drained() variant
Date: Fri, 30 May 2025 17:11:03 +0200
Message-Id: <20250530151125.955508-27-f.ebner@proxmox.com>
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

This is in preparation to mark bdrv_set_backing_hd() as
GRAPH_UNLOCKED.

Switch to using the bdrv_set_backing_hd_drained() variant. For the
first pair of calls to avoid draining and locking twice in a row
within the individual calls. For the third call, so that the drained
and locked section can also cover bdrv_cow_bs().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/commit.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index dc1942483b..c9690a5da0 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -514,28 +514,32 @@ int bdrv_commit(BlockDriverState *bs)
     Error *local_err = NULL;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!drv)
         return -ENOMEDIUM;
 
+    bdrv_graph_rdlock_main_loop();
+
     backing_file_bs = bdrv_cow_bs(bs);
 
     if (!backing_file_bs) {
-        return -ENOTSUP;
+        ret = -ENOTSUP;
+        goto out;
     }
 
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
         bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL))
     {
-        return -EBUSY;
+        ret = -EBUSY;
+        goto out;
     }
 
     ro = bdrv_is_read_only(backing_file_bs);
 
     if (ro) {
         if (bdrv_reopen_set_read_only(backing_file_bs, false, NULL)) {
-            return -EACCES;
+            ret = -EACCES;
+            goto out;
         }
     }
 
@@ -559,8 +563,14 @@ int bdrv_commit(BlockDriverState *bs)
         goto ro_cleanup;
     }
 
-    bdrv_set_backing_hd(commit_top_bs, backing_file_bs, &error_abort);
-    bdrv_set_backing_hd(bs, commit_top_bs, &error_abort);
+    bdrv_graph_rdunlock_main_loop();
+
+    bdrv_graph_wrlock_drained();
+    bdrv_set_backing_hd_drained(commit_top_bs, backing_file_bs, &error_abort);
+    bdrv_set_backing_hd_drained(bs, commit_top_bs, &error_abort);
+    bdrv_graph_wrunlock();
+
+    bdrv_graph_rdlock_main_loop();
 
     ret = blk_insert_bs(backing, backing_file_bs, &local_err);
     if (ret < 0) {
@@ -635,9 +645,14 @@ int bdrv_commit(BlockDriverState *bs)
     ret = 0;
 ro_cleanup:
     blk_unref(backing);
+
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_graph_wrlock_drained();
     if (bdrv_cow_bs(bs) != backing_file_bs) {
-        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
+        bdrv_set_backing_hd_drained(bs, backing_file_bs, &error_abort);
     }
+    bdrv_graph_wrunlock();
+    bdrv_graph_rdlock_main_loop();
     bdrv_unref(commit_top_bs);
     blk_unref(src);
 
@@ -646,5 +661,8 @@ ro_cleanup:
         bdrv_reopen_set_read_only(backing_file_bs, true, NULL);
     }
 
+out:
+    bdrv_graph_rdunlock_main_loop();
+
     return ret;
 }
-- 
2.39.5



