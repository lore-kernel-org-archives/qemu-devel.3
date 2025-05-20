Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C914C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKEy-00073S-9j; Tue, 20 May 2025 06:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEr-0006iM-BG; Tue, 20 May 2025 06:30:25 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEo-00050t-Tx; Tue, 20 May 2025 06:30:24 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A114B43AB4;
 Tue, 20 May 2025 12:30:17 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 04/24] block: move drain outside of read-locked
 bdrv_inactivate_recurse()
Date: Tue, 20 May 2025 12:29:52 +0200
Message-Id: <20250520103012.424311-5-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520103012.424311-1-f.ebner@proxmox.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.

More granular draining is not trivially possible, because
bdrv_inactivate_recurse() can recursively call itself.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Don't use atomics to access bs->quiesce_counter.
* Use goto for error handling/cleanup in bdrv_inactivate().

 block.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 3065d5c91e..fa55dfba68 100644
--- a/block.c
+++ b/block.c
@@ -6989,6 +6989,8 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
 
     GLOBAL_STATE_CODE();
 
+    assert(bs->quiesce_counter > 0);
+
     if (!bs->drv) {
         return -ENOMEDIUM;
     }
@@ -7032,9 +7034,7 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
         return -EPERM;
     }
 
-    bdrv_drained_begin(bs);
     bs->open_flags |= BDRV_O_INACTIVE;
-    bdrv_drained_end(bs);
 
     /*
      * Update permissions, they may differ for inactive nodes.
@@ -7059,20 +7059,26 @@ int bdrv_inactivate(BlockDriverState *bs, Error **errp)
     int ret;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     if (bdrv_has_bds_parent(bs, true)) {
         error_setg(errp, "Node has active parent node");
-        return -EPERM;
+        ret = -EPERM;
+        goto out;
     }
 
     ret = bdrv_inactivate_recurse(bs, true);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to inactivate node");
-        return ret;
+        goto out;
     }
 
-    return 0;
+out:
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
+    return ret;
 }
 
 int bdrv_inactivate_all(void)
@@ -7082,7 +7088,9 @@ int bdrv_inactivate_all(void)
     int ret = 0;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         /* Nodes with BDS parents are covered by recursion from the last
@@ -7098,6 +7106,9 @@ int bdrv_inactivate_all(void)
         }
     }
 
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
+
     return ret;
 }
 
-- 
2.39.5



