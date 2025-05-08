Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB594C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1wl-0001zs-CG; Thu, 08 May 2025 10:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1wi-0001xE-Do; Thu, 08 May 2025 10:09:56 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1wg-0008U5-Gd; Thu, 08 May 2025 10:09:56 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E7CE8436E1;
 Thu,  8 May 2025 16:09:41 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH 05/11] block: move drain outside of read-locked
 bdrv_inactivate_recurse()
Date: Thu,  8 May 2025 16:09:30 +0200
Message-Id: <20250508140936.3344485-6-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250508140936.3344485-1-f.ebner@proxmox.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
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

This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.

More granular draining is not trivially possible, because
bdrv_inactivate_recurse() can recursively call itself.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index c7c26533c9..10052027cd 100644
--- a/block.c
+++ b/block.c
@@ -6991,6 +6991,8 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
     int ret;
     uint64_t cumulative_perms, cumulative_shared_perms;
 
+    assert(qatomic_read(&bs->quiesce_counter) > 0);
+
     GLOBAL_STATE_CODE();
 
     if (!bs->drv) {
@@ -7036,9 +7038,7 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
         return -EPERM;
     }
 
-    bdrv_drained_begin(bs);
     bs->open_flags |= BDRV_O_INACTIVE;
-    bdrv_drained_end(bs);
 
     /*
      * Update permissions, they may differ for inactive nodes.
@@ -7063,14 +7063,20 @@ int bdrv_inactivate(BlockDriverState *bs, Error **errp)
     int ret;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     if (bdrv_has_bds_parent(bs, true)) {
         error_setg(errp, "Node has active parent node");
+        bdrv_graph_rdunlock_main_loop();
+        bdrv_drain_all_end();
         return -EPERM;
     }
 
     ret = bdrv_inactivate_recurse(bs, true);
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to inactivate node");
         return ret;
@@ -7086,7 +7092,9 @@ int bdrv_inactivate_all(void)
     int ret = 0;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         /* Nodes with BDS parents are covered by recursion from the last
@@ -7102,6 +7110,9 @@ int bdrv_inactivate_all(void)
         }
     }
 
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
+
     return ret;
 }
 
-- 
2.39.5



