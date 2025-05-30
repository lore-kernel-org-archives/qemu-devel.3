Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2E1C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PD-0003OU-49; Fri, 30 May 2025 11:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1P9-0003Ds-SY; Fri, 30 May 2025 11:12:19 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1P7-0002HB-Jg; Fri, 30 May 2025 11:12:19 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 17E9C44A86;
 Fri, 30 May 2025 17:11:44 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 14/48] block: move drain outside of quorum_add_child()
Date: Fri, 30 May 2025 17:10:51 +0200
Message-Id: <20250530151125.955508-15-f.ebner@proxmox.com>
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

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

The quorum_add_child() callback runs under the graph lock, so it is
not allowed to drain. It is only called as the .bdrv_add_child()
callback, which is only called in the bdrv_add_child() function, which
also runs under the graph lock.

The bdrv_add_child() function is called by qmp_x_blockdev_change(),
where a drained section is introduced.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v4:
* Document requirement that all nodes need to be drained for
  bdrv_add_child() wrapper and callback.
* Split common comment for bdrv_add_child()/bdrv_del_child() to become
  one comment for each function.
* Add comment for bdrv_add_child() callback.

 block.c                          | 10 ++++++++--
 block/quorum.c                   |  2 --
 blockdev.c                       |  2 ++
 include/block/block_int-common.h |  7 +++++++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 6fc87aa318..f6c2f7e208 100644
--- a/block.c
+++ b/block.c
@@ -8220,8 +8220,10 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
 }
 
 /*
- * Hot add/remove a BDS's child. So the user can take a child offline when
- * it is broken and take a new child online
+ * Hot add a BDS's child. Used in combination with bdrv_del_child, so the user
+ * can take a child offline when it is broken and take a new child online.
+ *
+ * All block nodes must be drained.
  */
 void bdrv_add_child(BlockDriverState *parent_bs, BlockDriverState *child_bs,
                     Error **errp)
@@ -8261,6 +8263,10 @@ void bdrv_add_child(BlockDriverState *parent_bs, BlockDriverState *child_bs,
     parent_bs->drv->bdrv_add_child(parent_bs, child_bs, errp);
 }
 
+/*
+ * Hot remove a BDS's child. Used in combination with bdrv_add_child, so the
+ * user can take a child offline when it is broken and take a new child online.
+ */
 void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 {
     BdrvChild *tmp;
diff --git a/block/quorum.c b/block/quorum.c
index ea17b0ec13..ed8ce801ee 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1096,10 +1096,8 @@ quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs, Error **errp)
     /* We can safely add the child now */
     bdrv_ref(child_bs);
 
-    bdrv_drain_all_begin();
     child = bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
                               BDRV_CHILD_DATA, errp);
-    bdrv_drain_all_end();
     if (child == NULL) {
         s->next_child_index--;
         return;
diff --git a/blockdev.c b/blockdev.c
index 750beba41f..bd5ca77619 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3531,6 +3531,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
     BlockDriverState *parent_bs, *new_bs = NULL;
     BdrvChild *p_child;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     parent_bs = bdrv_lookup_bs(parent, parent, errp);
@@ -3568,6 +3569,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
 
 out:
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 BlockJobInfoList *qmp_query_block_jobs(Error **errp)
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 168f703fa1..f9e742f812 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -396,6 +396,13 @@ struct BlockDriver {
     int GRAPH_RDLOCK_PTR (*bdrv_probe_geometry)(
         BlockDriverState *bs, HDGeometry *geo);
 
+    /**
+     * Hot add a BDS's child. Used in combination with bdrv_del_child, so the
+     * user can take a child offline when it is broken and take a new child
+     * online.
+     *
+     * All block nodes must be drained.
+     */
     void GRAPH_WRLOCK_PTR (*bdrv_add_child)(
         BlockDriverState *parent, BlockDriverState *child, Error **errp);
 
-- 
2.39.5



