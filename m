Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9939FC36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txq22-00022x-Ha; Thu, 27 Mar 2025 12:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1txq20-00022G-HG; Thu, 27 Mar 2025 12:24:36 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1txq1y-00041z-Pn; Thu, 27 Mar 2025 12:24:36 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 7521123383;
 Thu, 27 Mar 2025 19:24:31 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-block@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org,
 Denis Rastyogin <gerben@altlinux.org>
Subject: [PATCH 1/4] qemu-img: fix division by zero in bench_cb() for
 zero-sized
Date: Thu, 27 Mar 2025 19:24:20 +0300
Message-ID: <20250327162423.25154-2-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
In-Reply-To: <20250327162423.25154-1-gerben@altlinux.org>
References: <20250327162423.25154-1-gerben@altlinux.org>
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

This commit fixes a division by zero error in the bench_cb() function
that occurs when using the bench command with a zero-sized image.

The issue arises because b->image_size can be zero, leading to a
division by zero in the modulo operation (b->offset %= b->image_size).
This patch adds a check for b->image_size == 0 and resets b->offset
to 0 in such cases, preventing the error.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 qemu-img.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 89c93c1eb5..2044c22a4c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4488,7 +4488,11 @@ static void bench_cb(void *opaque, int ret)
          */
         b->in_flight++;
         b->offset += b->step;
-        b->offset %= b->image_size;
+        if (b->image_size == 0) {
+            b->offset = 0;
+        } else {
+            b->offset %= b->image_size;
+        }
         if (b->write) {
             acb = blk_aio_pwritev(b->blk, offset, b->qiov, 0, bench_cb, b);
         } else {
-- 
2.42.2


