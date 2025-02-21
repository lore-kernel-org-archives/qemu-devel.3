Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABAEC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTP8-0000sW-Rr; Fri, 21 Feb 2025 08:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1tlTP4-0000s7-Ij
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:49:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1tlTP1-0006RY-Ub
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:49:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 51235EFA48;
 Fri, 21 Feb 2025 16:48:43 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B85371BB3A7;
 Fri, 21 Feb 2025 16:49:02 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AF5CE53E0C; Fri, 21 Feb 2025 16:49:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paul Durrant <paul@xen.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw/display/qxl-render.c: fix qxl_unpack_chunks() chunk size
 calculation
Date: Fri, 21 Feb 2025 16:48:56 +0300
Message-Id: <20250221134856.478806-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

In case of multiple chunks, code in qxl_unpack_chunks() takes size of the
wrong (next in the chain) chunk, instead of using current chunk size.
This leads to wrong number of bytes being copied, and to crashes if next
chunk size is larger than the current one.

Based on the code by Gao Yong.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1628
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/display/qxl-render.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index eda6d3de37..c6a9ac1da1 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -222,6 +222,7 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
     uint32_t max_chunks = 32;
     size_t offset = 0;
     size_t bytes;
+    QXLPHYSICAL next_chunk_phys = 0;
 
     for (;;) {
         bytes = MIN(size - offset, chunk->data_size);
@@ -230,7 +231,15 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
         if (offset == size) {
             return;
         }
-        chunk = qxl_phys2virt(qxl, chunk->next_chunk, group_id,
+        next_chunk_phys = chunk->next_chunk;
+        /* fist time, only get the next chunk's data size */
+        chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
+                              sizeof(QXLDataChunk));
+        if (!chunk) {
+            return;
+        }
+        /* second time, check data size and get data */
+        chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
                               sizeof(QXLDataChunk) + chunk->data_size);
         if (!chunk) {
             return;
-- 
2.39.5


