Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E54DD185DC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBJk-0006DA-Ft; Fri, 09 Jan 2026 07:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIY-0005ap-2u; Fri, 09 Jan 2026 07:09:00 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIW-00018J-GB; Fri, 09 Jan 2026 07:08:57 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 523AA48FB3;
 Fri, 09 Jan 2026 13:08:43 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com
Subject: [PATCH 6/6] block/io: keep zero flag for head/tail parts of
 misaligned zero write when possible
Date: Fri,  9 Jan 2026 13:08:33 +0100
Message-ID: <20260109120837.2772961-7-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109120837.2772961-1-f.ebner@proxmox.com>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1767960482599
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

This fixes io-test 179 with qcow2. Otherwise, there would be more 'data'
sectors.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Not sure if we should even attempt this without considering
detect-zeroes. While it does keep 179 working, it is a change in
behavior, since it could turn previously data sectors (with zeroes)
into zero sectors when they are part of the head or tail of a zero
write.

Would it even be tolerable from a performance perspective?


Remaining test failures after this patch are:
154 177 204 271

177 and 204 use opt-write-zero=15M with blkdebug, making an
is_power_of_2(align) assertion fail.

Changes in the output of 154 and 271 might be expected, but I didn't
look into it in detail yet, as I wanted to discuss everything first.

 block/io.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index d92b30bce5..34b523c951 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2179,10 +2179,14 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
             int64_t write_bytes = pad.merge_reads ? pad.buf_len : align;
 
             if (total_length >= aligned_offset + write_bytes) {
+                BdrvRequestFlags head_flags =
+                    buffer_is_zero(pad.buf, write_bytes) ?
+                    flags : flags & ~BDRV_REQ_ZERO_WRITE;
+
                 qemu_iovec_init_buf(&local_qiov, pad.buf, write_bytes);
                 ret = bdrv_aligned_pwritev(child, req, aligned_offset,
                                            write_bytes, align, &local_qiov, 0,
-                                           flags & ~BDRV_REQ_ZERO_WRITE);
+                                           head_flags);
             } else {
                 write_bytes = total_length - aligned_offset;
                 qemu_iovec_init_buf(&local_qiov, pad.buf, write_bytes);
@@ -2220,10 +2224,13 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
         if (total_length >= offset + align) {
             assert(align == pad.tail + bytes);
 
+            BdrvRequestFlags tail_flags =
+                buffer_is_zero(pad.tail_buf + bytes, pad.tail) ?
+                flags : flags & ~BDRV_REQ_ZERO_WRITE;
+
             qemu_iovec_init_buf(&local_qiov, pad.tail_buf, align);
             ret = bdrv_aligned_pwritev(child, req, offset, align, align,
-                                       &local_qiov, 0,
-                                       flags & ~BDRV_REQ_ZERO_WRITE);
+                                       &local_qiov, 0, tail_flags);
         } else {
             int64_t write_bytes = total_length - offset;
             qemu_iovec_init_buf(&local_qiov, pad.tail_buf, write_bytes);
-- 
2.47.3



