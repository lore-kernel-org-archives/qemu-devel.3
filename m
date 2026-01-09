Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D7CD185DC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBJQ-0005qU-FV; Fri, 09 Jan 2026 07:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIV-0005aZ-8R; Fri, 09 Jan 2026 07:08:57 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIT-00017H-AS; Fri, 09 Jan 2026 07:08:55 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BFE8F476DB;
 Fri, 09 Jan 2026 13:08:42 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com
Subject: [PATCH 2/6] block/io: add 'bytes' parameter to bdrv_padding_rmw_read()
Date: Fri,  9 Jan 2026 13:08:29 +0100
Message-ID: <20260109120837.2772961-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109120837.2772961-1-f.ebner@proxmox.com>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1767960482305
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

Currently, all callers use bs->bl.request_alignment. This will change
when making bdrv_co_do_zero_pwritev() honor the block driver's
pwrite_zeroes_alignment. Note that the alignment for reading is not
necessarily the alignment for the request. In particular with qcow2
images, the total image length is not necessarily aligned to
pwrite_zeroes_alignment, and in such cases, a request with that bigger
alignment would cause an assertion failure.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/io.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index e80aecf194..403a45f91d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1511,7 +1511,7 @@ static bool bdrv_init_padding(BlockDriverState *bs,
 }
 
 static int coroutine_fn GRAPH_RDLOCK
-bdrv_padding_rmw_read(BdrvChild *child, BdrvTrackedRequest *req,
+bdrv_padding_rmw_read(BdrvChild *child, BdrvTrackedRequest *req, int64_t bytes,
                       BdrvRequestPadding *pad, bool zero_middle)
 {
     QEMUIOVector local_qiov;
@@ -1522,7 +1522,9 @@ bdrv_padding_rmw_read(BdrvChild *child, BdrvTrackedRequest *req,
     assert(req->serialising && pad->buf);
 
     if (pad->head || pad->merge_reads) {
-        int64_t bytes = pad->merge_reads ? pad->buf_len : align;
+        if (pad->merge_reads) {
+            bytes = pad->buf_len;
+        }
 
         qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
 
@@ -1550,13 +1552,13 @@ bdrv_padding_rmw_read(BdrvChild *child, BdrvTrackedRequest *req,
     }
 
     if (pad->tail) {
-        qemu_iovec_init_buf(&local_qiov, pad->tail_buf, align);
+        qemu_iovec_init_buf(&local_qiov, pad->tail_buf, bytes);
 
         bdrv_co_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
         ret = bdrv_aligned_preadv(
                 child, req,
-                req->overlap_offset + req->overlap_bytes - align,
-                align, align, &local_qiov, 0, 0);
+                req->overlap_offset + req->overlap_bytes - bytes,
+                bytes, align, &local_qiov, 0, 0);
         if (ret < 0) {
             return ret;
         }
@@ -2166,7 +2168,7 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
         assert(!(flags & BDRV_REQ_NO_WAIT));
         bdrv_make_request_serialising(req, align);
 
-        bdrv_padding_rmw_read(child, req, &pad, true);
+        bdrv_padding_rmw_read(child, req, align, &pad, true);
 
         if (pad.head || pad.merge_reads) {
             int64_t aligned_offset = offset & ~(align - 1);
@@ -2302,7 +2304,7 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
          */
         assert(!(flags & BDRV_REQ_NO_WAIT));
         bdrv_make_request_serialising(&req, align);
-        bdrv_padding_rmw_read(child, &req, &pad, false);
+        bdrv_padding_rmw_read(child, &req, align, &pad, false);
     }
 
     ret = bdrv_aligned_pwritev(child, &req, offset, bytes, align,
-- 
2.47.3



