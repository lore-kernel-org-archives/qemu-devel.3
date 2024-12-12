Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C4E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjp8-0007j8-Bb; Thu, 12 Dec 2024 09:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tLgeO-000731-TB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:42:32 -0500
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tLgeM-000331-H4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:42:32 -0500
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17])
 by air.basealt.ru (Postfix) with ESMTPSA id 74A47233A1;
 Thu, 12 Dec 2024 13:42:26 +0300 (MSK)
From: gerben@altlinux.org
To: den@openvz.org,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, Denis Rastyogin <gerben@altlinux.org>,
 Leonid Reviakin <L.reviakin@fobos-nt.ru>
Subject: [PATCH] parallels: fix ext_off assertion failure due to overflow
Date: Thu, 12 Dec 2024 13:41:22 +0300
Message-ID: <20241212104212.513947-2-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
In-Reply-To: <20241212104212.513947-1-gerben@altlinux.org>
References: <20241212104212.513947-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Dec 2024 09:05:35 -0500
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

When ph.ext_off has a sufficiently large value, the operation
le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS in
parallels_read_format_extension() can cause an overflow in int64_t.
This overflow triggers the assert(ext_off > 0)
check in block/parallels-ext.c: parallels_read_format_extension(), 
leading to a crash.

This commit adds a check to prevent overflow when shifting ph.ext_off
by BDRV_SECTOR_BITS, ensuring that the value remains within a valid range.

Reported-by: Leonid Reviakin <L.reviakin@fobos-nt.ru>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 block/parallels.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 9205a0864f..8f2b58e1c9 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1298,6 +1298,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         error_setg(errp, "Catalog too large");
         return -EFBIG;
     }
+    if (le64_to_cpu(ph.ext_off) >= (INT64_MAX >> BDRV_SECTOR_BITS)) {
+        error_setg(errp, "Invalid image: Too big offset");
+        return -EFBIG;
+    }
 
     size = bat_entry_off(s->bat_size);
     s->header_size = ROUND_UP(size, bdrv_opt_mem_align(bs->file->bs));
-- 
2.42.2


