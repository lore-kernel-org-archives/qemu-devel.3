Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02D8D1D485
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBJQ-0005qW-KY; Fri, 09 Jan 2026 07:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIY-0005al-12; Fri, 09 Jan 2026 07:09:00 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIW-00018H-Fz; Fri, 09 Jan 2026 07:08:57 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6201D48FBA;
 Fri, 09 Jan 2026 13:08:43 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com
Subject: [PATCH 5/6] block/io: handle image length not aligned to write zeroes
 alignment in bdrv_co_do_zero_pwritev()
Date: Fri,  9 Jan 2026 13:08:32 +0100
Message-ID: <20260109120837.2772961-6-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109120837.2772961-1-f.ebner@proxmox.com>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1767960482537
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

When making the request shorter, use bl.request_alignment as the
alignment. This partially fixes iotests 154 and 271 with qcow2.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/io.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/block/io.c b/block/io.c
index 233b2617ea..d92b30bce5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2162,6 +2162,7 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
     int ret = 0;
     bool padding;
     BdrvRequestPadding pad;
+    uint64_t total_length = bs->total_sectors * BDRV_SECTOR_SIZE;
 
     /* This flag doesn't make sense for padding or zero writes */
     flags &= ~BDRV_REQ_REGISTERED_BUF;
@@ -2177,10 +2178,21 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
             int64_t aligned_offset = offset & ~(align - 1);
             int64_t write_bytes = pad.merge_reads ? pad.buf_len : align;
 
-            qemu_iovec_init_buf(&local_qiov, pad.buf, write_bytes);
-            ret = bdrv_aligned_pwritev(child, req, aligned_offset, write_bytes,
-                                       align, &local_qiov, 0,
-                                       flags & ~BDRV_REQ_ZERO_WRITE);
+            if (total_length >= aligned_offset + write_bytes) {
+                qemu_iovec_init_buf(&local_qiov, pad.buf, write_bytes);
+                ret = bdrv_aligned_pwritev(child, req, aligned_offset,
+                                           write_bytes, align, &local_qiov, 0,
+                                           flags & ~BDRV_REQ_ZERO_WRITE);
+            } else {
+                write_bytes = total_length - aligned_offset;
+                qemu_iovec_init_buf(&local_qiov, pad.buf, write_bytes);
+                ret = bdrv_aligned_pwritev(child, req, aligned_offset,
+                                           write_bytes,
+                                           bs->bl.request_alignment,
+                                           &local_qiov, 0,
+                                           flags & ~BDRV_REQ_ZERO_WRITE);
+            }
+
             if (ret < 0 || pad.merge_reads) {
                 /* Error or all work is done */
                 goto out;
@@ -2205,12 +2217,20 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
 
     assert(!bytes || (offset & (align - 1)) == 0);
     if (bytes) {
-        assert(align == pad.tail + bytes);
+        if (total_length >= offset + align) {
+            assert(align == pad.tail + bytes);
 
-        qemu_iovec_init_buf(&local_qiov, pad.tail_buf, align);
-        ret = bdrv_aligned_pwritev(child, req, offset, align, align,
-                                   &local_qiov, 0,
-                                   flags & ~BDRV_REQ_ZERO_WRITE);
+            qemu_iovec_init_buf(&local_qiov, pad.tail_buf, align);
+            ret = bdrv_aligned_pwritev(child, req, offset, align, align,
+                                       &local_qiov, 0,
+                                       flags & ~BDRV_REQ_ZERO_WRITE);
+        } else {
+            int64_t write_bytes = total_length - offset;
+            qemu_iovec_init_buf(&local_qiov, pad.tail_buf, write_bytes);
+            ret = bdrv_aligned_pwritev(child, req, offset, write_bytes,
+                                       bs->bl.request_alignment, &local_qiov, 0,
+                                       flags & ~BDRV_REQ_ZERO_WRITE);
+        }
     }
 
 out:
-- 
2.47.3



