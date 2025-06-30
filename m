Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F43EC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWCjE-0005yU-4w; Mon, 30 Jun 2025 07:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWCis-0005t9-Gl; Mon, 30 Jun 2025 07:30:55 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWCio-0004kN-A3; Mon, 30 Jun 2025 07:30:53 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 35BC444243;
 Mon, 30 Jun 2025 13:30:40 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net
Subject: [PATCH 2/4] block: make bdrv_co_parent_cb_resize() a proper IO API
 function
Date: Mon, 30 Jun 2025 13:27:31 +0200
Message-ID: <20250630113035.820557-3-f.ebner@proxmox.com>
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

In preparation for calling it via the bdrv_child_cb_resize() callback
that will be added by the next commit. Rename it to include the "_co_"
part while at it.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/io.c                   | 9 +++------
 include/block/block_int-io.h | 6 ++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index ac5c7174f6..2e153364a9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -46,9 +46,6 @@
 /* Maximum read size for checking if data reads as zero, in bytes */
 #define MAX_ZERO_CHECK_BUFFER (128 * KiB)
 
-static void coroutine_fn GRAPH_RDLOCK
-bdrv_parent_cb_resize(BlockDriverState *bs);
-
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int64_t bytes, BdrvRequestFlags flags);
 
@@ -2041,7 +2038,7 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
          end_sector > bs->total_sectors) &&
         req->type != BDRV_TRACKED_DISCARD) {
         bs->total_sectors = end_sector;
-        bdrv_parent_cb_resize(bs);
+        bdrv_co_parent_cb_resize(bs);
         bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
     }
     if (req->bytes) {
@@ -3573,11 +3570,11 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
                                    bytes, read_flags, write_flags);
 }
 
-static void coroutine_fn GRAPH_RDLOCK
-bdrv_parent_cb_resize(BlockDriverState *bs)
+void coroutine_fn bdrv_co_parent_cb_resize(BlockDriverState *bs)
 {
     BdrvChild *c;
 
+    IO_CODE();
     assert_bdrv_graph_readable();
 
     QLIST_FOREACH(c, &bs->parents, next_parent) {
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 4f94eb3c5a..ed8b5657d6 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -191,4 +191,10 @@ void bdrv_bsc_invalidate_range(BlockDriverState *bs,
  */
 void bdrv_bsc_fill(BlockDriverState *bs, int64_t offset, int64_t bytes);
 
+/*
+ * Notify all parents that the size of the child changed.
+ */
+void coroutine_fn GRAPH_RDLOCK
+bdrv_co_parent_cb_resize(BlockDriverState *bs);
+
 #endif /* BLOCK_INT_IO_H */
-- 
2.47.2



