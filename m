Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A17C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJ3w-0000WZ-9U; Tue, 06 May 2025 10:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1uCJ3q-0000VK-OU; Tue, 06 May 2025 10:14:18 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1uCJ3n-0005mH-Vv; Tue, 06 May 2025 10:14:17 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id C9F5D23371;
 Tue,  6 May 2025 17:14:13 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-block@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu-devel@nongnu.org,
	sdl.qemu@linuxtesting.org
Subject: [PATCH v2] qemu-img: fix offset calculation in bench
Date: Tue,  6 May 2025 17:13:37 +0300
Message-ID: <20250506141410.100119-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

The current offset calculation leads to an EIO error
in block/block-backend.c: blk_check_byte_request():

 if (offset > len || len - offset < bytes) {
     return -EIO;
 }

This triggers the error message:
"qemu-img: Failed request: Input/output error".

Example of the issue:
 offset: 260076
 len: 260096
 bytes: 4096

This fix ensures that offset remains within a valid range.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 qemu-img.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 76ac5d3028..e64acfafb3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4488,10 +4488,10 @@ static void bench_cb(void *opaque, int ret)
          */
         b->in_flight++;
         b->offset += b->step;
-        if (b->image_size == 0) {
+        if (b->image_size - b->bufsize <= 0) {
             b->offset = 0;
         } else {
-            b->offset %= b->image_size;
+            b->offset %= b->image_size - b->bufsize;
         }
         if (b->write) {
             acb = blk_aio_pwritev(b->blk, offset, b->qiov, 0, bench_cb, b);
-- 
2.42.2


