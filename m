Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BED5C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 20:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttBEG-0000a9-9N; Fri, 14 Mar 2025 16:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ttBEB-0000ZO-RX; Fri, 14 Mar 2025 16:01:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ttBE6-0001GC-At; Fri, 14 Mar 2025 16:01:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2B0524E6065;
 Fri, 14 Mar 2025 21:01:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id W_s8oEtS1qWp; Fri, 14 Mar 2025 21:01:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2DBE74E6069; Fri, 14 Mar 2025 21:01:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ppc/amigaone: Check blk_pwrite return value
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
    clg@redhat.com
Message-Id: <20250314200140.2DBE74E6069@zero.eik.bme.hu>
Date: Fri, 14 Mar 2025 21:01:40 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Coverity reported that return value of blk_pwrite() maybe should not
be ignored. We can't do much if this happens other than report an
error but let's do that to silence this report.

Resolves: Coverity CID 1593725
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/amigaone.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 483512125f..5d787c3059 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -108,8 +108,8 @@ static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
     uint8_t *p = memory_region_get_ram_ptr(&s->mr);
 
     p[addr] = val;
-    if (s->blk) {
-        blk_pwrite(s->blk, addr, 1, &val, 0);
+    if (s->blk && blk_pwrite(s->blk, addr, 1, &val, 0) < 0) {
+        error_report("%s: could not write %s", __func__, blk_name(s->blk));
     }
 }
 
@@ -151,15 +151,17 @@ static void nvram_realize(DeviceState *dev, Error **errp)
         *c = cpu_to_be32(CRC32_DEFAULT_ENV);
         /* Also copies terminating \0 as env is terminated by \0\0 */
         memcpy(p + 4, default_env, sizeof(default_env));
-        if (s->blk) {
-            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0);
+        if (s->blk &&
+            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0) < 0
+           ) {
+            error_report("%s: could not write %s", __func__, blk_name(s->blk));
         }
         return;
     }
     if (*c == 0) {
         *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
-        if (s->blk) {
-            blk_pwrite(s->blk, 0, 4, p, 0);
+        if (s->blk && blk_pwrite(s->blk, 0, 4, p, 0) < 0) {
+            error_report("%s: could not write %s", __func__, blk_name(s->blk));
         }
     }
     if (be32_to_cpu(*c) != crc) {
-- 
2.41.3


