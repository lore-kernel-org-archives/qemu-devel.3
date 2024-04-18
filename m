Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED007C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVuL-0000Sr-90; Thu, 18 Apr 2024 13:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVuJ-0000RO-Ql; Thu, 18 Apr 2024 13:50:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVuI-0007ad-02; Thu, 18 Apr 2024 13:50:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BA3B95FD6E;
 Thu, 18 Apr 2024 20:50:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 21462B9348;
 Thu, 18 Apr 2024 20:50:00 +0300 (MSK)
Received: (nullmailer pid 947845 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 101/116] hw/block/nand: Factor nand_load_iolen() method
 out
Date: Thu, 18 Apr 2024 20:49:31 +0300
Message-Id: <20240418174955.947730-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240409135944.24997-2-philmd@linaro.org>
(cherry picked from commit 7a86544f286d8af4fa5251101c1026ddae92cc3d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/nand.c b/hw/block/nand.c
index 9c1b89cfa6..58ef547c5a 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -243,9 +243,28 @@ static inline void nand_pushio_byte(NANDFlashState *s, uint8_t value)
     }
 }
 
+/*
+ * nand_load_block: Load block containing (s->addr + @offset).
+ * Returns length of data available at @offset in this block.
+ */
+static unsigned nand_load_block(NANDFlashState *s, unsigned offset)
+{
+    unsigned iolen;
+
+    s->blk_load(s, s->addr, offset);
+
+    iolen = (1 << s->page_shift);
+    if (s->gnd) {
+        iolen += 1 << s->oob_shift;
+    }
+    assert(offset <= iolen);
+    iolen -= offset;
+
+    return iolen;
+}
+
 static void nand_command(NANDFlashState *s)
 {
-    unsigned int offset;
     switch (s->cmd) {
     case NAND_CMD_READ0:
         s->iolen = 0;
@@ -271,12 +290,7 @@ static void nand_command(NANDFlashState *s)
     case NAND_CMD_NOSERIALREAD2:
         if (!(nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP))
             break;
-        offset = s->addr & ((1 << s->addr_shift) - 1);
-        s->blk_load(s, s->addr, offset);
-        if (s->gnd)
-            s->iolen = (1 << s->page_shift) - offset;
-        else
-            s->iolen = (1 << s->page_shift) + (1 << s->oob_shift) - offset;
+        s->iolen = nand_load_block(s, s->addr & ((1 << s->addr_shift) - 1));
         break;
 
     case NAND_CMD_RESET:
@@ -597,12 +611,7 @@ uint32_t nand_getio(DeviceState *dev)
     if (!s->iolen && s->cmd == NAND_CMD_READ0) {
         offset = (int) (s->addr & ((1 << s->addr_shift) - 1)) + s->offset;
         s->offset = 0;
-
-        s->blk_load(s, s->addr, offset);
-        if (s->gnd)
-            s->iolen = (1 << s->page_shift) - offset;
-        else
-            s->iolen = (1 << s->page_shift) + (1 << s->oob_shift) - offset;
+        s->iolen = nand_load_block(s, offset);
     }
 
     if (s->ce || s->iolen <= 0) {
-- 
2.39.2


