Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B1BD185DC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBJf-00066F-Qa; Fri, 09 Jan 2026 07:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIW-0005ad-D7; Fri, 09 Jan 2026 07:08:59 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIT-00017F-Lk; Fri, 09 Jan 2026 07:08:56 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6A23548FBB;
 Fri, 09 Jan 2026 13:08:42 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com
Subject: [PATCH 1/6] block/io: pass alignment to bdrv_init_padding()
Date: Fri,  9 Jan 2026 13:08:28 +0100
Message-ID: <20260109120837.2772961-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109120837.2772961-1-f.ebner@proxmox.com>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1767960482239
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

Currently, all callers use bs->bl.request_alignment. This will
change in the next commit when making bdrv_co_do_zero_pwritev() honor
the block driver's pwrite_zeroes_alignment.

uint64_t is chosen as the type, because that is more common in other
functions already and in particular, in the bdrv_co_do_zero_pwritev()
caller.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index cace297f22..e80aecf194 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1474,10 +1474,9 @@ typedef struct BdrvRequestPadding {
 
 static bool bdrv_init_padding(BlockDriverState *bs,
                               int64_t offset, int64_t bytes,
-                              bool write,
+                              uint64_t align, bool write,
                               BdrvRequestPadding *pad)
 {
-    int64_t align = bs->bl.request_alignment;
     int64_t sum;
 
     bdrv_check_request(offset, bytes, &error_abort);
@@ -1716,6 +1715,7 @@ static int bdrv_pad_request(BlockDriverState *bs,
     struct iovec *sliced_iov;
     int sliced_niov;
     size_t sliced_head, sliced_tail;
+    uint64_t align = bs->bl.request_alignment;
 
     /* Should have been checked by the caller already */
     ret = bdrv_check_request32(*offset, *bytes, *qiov, *qiov_offset);
@@ -1723,7 +1723,7 @@ static int bdrv_pad_request(BlockDriverState *bs,
         return ret;
     }
 
-    if (!bdrv_init_padding(bs, *offset, *bytes, write, pad)) {
+    if (!bdrv_init_padding(bs, *offset, *bytes, align, write, pad)) {
         if (padded) {
             *padded = false;
         }
@@ -2161,7 +2161,7 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
     /* This flag doesn't make sense for padding or zero writes */
     flags &= ~BDRV_REQ_REGISTERED_BUF;
 
-    padding = bdrv_init_padding(bs, offset, bytes, true, &pad);
+    padding = bdrv_init_padding(bs, offset, bytes, align, true, &pad);
     if (padding) {
         assert(!(flags & BDRV_REQ_NO_WAIT));
         bdrv_make_request_serialising(req, align);
-- 
2.47.3



