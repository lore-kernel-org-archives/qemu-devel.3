Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA260CAC59D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqlw-0001SH-LS; Wed, 17 Sep 2025 07:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyqky-0007hm-D3; Wed, 17 Sep 2025 07:55:28 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyqkv-0004bv-GD; Wed, 17 Sep 2025 07:55:28 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7FB204DC09;
 Wed, 17 Sep 2025 13:55:20 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com
Subject: [PATCH v2 3/5] block: implement 'resize' callback for child_of_bds
 class
Date: Wed, 17 Sep 2025 13:54:50 +0200
Message-ID: <20250917115509.401015-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250917115509.401015-1-f.ebner@proxmox.com>
References: <20250917115509.401015-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1758110111502
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

If a filtered child is resized, the size of the parent node is now
also refreshed (recursively for chains of filtered children).

For filter block drivers that do not implement .bdrv_co_getlength(),
this commit does not change the current behavior, because
bdrv_co_refresh_total_sectors() will used the current size via the
passed-in hint. This is the case for block drivers for (some) block
jobs, as well as copy-before-write.

Block jobs already set up a blocker preventing a QMP block_resize
operation while the job is running. That does not directly cover an
associated 'file' node of a 'raw' node, but resizing such a 'file'
node is already prevented too (backup, commit, mirror and stream were
checked).

The other case is copy-before-write. This commit does not change the
fact that the copy-before-write node still has the same size after its
filtered child is resized.

Block drivers that do implement .bdrv_co_getlength() and where
.is_filter is true, already returned the length of the file child, so
there is no change before and after this commit, with two exceptions:
1. preallocate can return an early data_end and otherwise queries the
   file child, but that special casing is not changed.
2. blkverify returns the length of the test file. This commit does not
   affect that behavior.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Check for BDRV_CHILD_FILTERED rather than bs->drv->is_filter which
  is more generic and for example, also covers the case when the
  child of a 'raw' node is resized.
* Expand commit message.

 block.c                          | 12 ++++++++++++
 include/block/block_int-common.h |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 8848e9a7ed..cf08e64add 100644
--- a/block.c
+++ b/block.c
@@ -1497,6 +1497,17 @@ static void GRAPH_WRLOCK bdrv_child_cb_detach(BdrvChild *child)
     }
 }
 
+static void coroutine_fn GRAPH_RDLOCK bdrv_child_cb_resize(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+
+    if (child->role & BDRV_CHILD_FILTERED) {
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
index 8a3d427356..c55b35da8e 100644
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



