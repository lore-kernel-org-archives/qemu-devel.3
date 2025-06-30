Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FC2C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWCjJ-00060f-7L; Mon, 30 Jun 2025 07:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWCiw-0005tn-0W; Mon, 30 Jun 2025 07:30:58 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWCio-0004kL-9n; Mon, 30 Jun 2025 07:30:57 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2D44E4423D;
 Mon, 30 Jun 2025 13:30:40 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net
Subject: [PATCH 3/4] block: implement 'resize' callback for child_of_bds class
Date: Mon, 30 Jun 2025 13:27:32 +0200
Message-ID: <20250630113035.820557-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250630113035.820557-1-f.ebner@proxmox.com>
References: <20250630113035.820557-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If a node below a filter node is resized, the size of the filter node
is now also refreshed (recursively for filter parents).

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block.c                          | 12 ++++++++++++
 include/block/block_int-common.h |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index bfd4340b24..449f814ebe 100644
--- a/block.c
+++ b/block.c
@@ -1497,6 +1497,17 @@ static void GRAPH_WRLOCK bdrv_child_cb_detach(BdrvChild *child)
     }
 }
 
+static void coroutine_fn GRAPH_RDLOCK bdrv_child_cb_resize(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+
+    if (bs->drv && bs->drv->is_filter) {
+        /* Best effort, ignore errors. */
+        bdrv_co_refresh_total_sectors(bs, bs->total_sectors);
+        bdrv_co_parent_cb_resize(bs);
+    }
+}
+
 static int bdrv_child_cb_update_filename(BdrvChild *c, BlockDriverState *base,
                                          const char *filename,
                                          bool backing_mask_protocol,
@@ -1529,6 +1540,7 @@ const BdrvChildClass child_of_bds = {
     .detach          = bdrv_child_cb_detach,
     .inactivate      = bdrv_child_cb_inactivate,
     .change_aio_ctx  = bdrv_child_cb_change_aio_ctx,
+    .resize          = bdrv_child_cb_resize,
     .update_filename = bdrv_child_cb_update_filename,
     .get_parent_aio_context = child_of_bds_get_parent_aio_context,
 };
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 692a9696d1..6670db2f85 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1023,7 +1023,7 @@ struct BdrvChildClass {
     /*
      * Notifies the parent that the child was resized.
      */
-    void (*resize)(BdrvChild *child);
+    void GRAPH_RDLOCK_PTR (*resize)(BdrvChild *child);
 
     /*
      * Returns a name that is supposedly more useful for human users than the
-- 
2.47.2



