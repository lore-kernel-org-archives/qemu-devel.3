Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8BB109448C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3zDd-0006CZ-Rm; Sat, 21 Mar 2026 12:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDX-0006AL-22
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDP-0002E4-AE
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:23 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2BA06596DFE;
 Sat, 21 Mar 2026 17:30:17 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id m-WsSCLJNNKD; Sat, 21 Mar 2026 17:30:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0730C596A4A; Sat, 21 Mar 2026 17:30:15 +0100 (CET)
Message-ID: <9a3263a06bc72aa5a56bafe0a11ad189d5f60528.1774110169.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1774110169.git.balaton@eik.bme.hu>
References: <cover.1774110169.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 4/8] ati-vga: Avoid warnings about sign extension
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 21 Mar 2026 17:30:15 +0100 (CET)
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Coverity reports several possible sign extension errors (latest is CID
1645615). These cannot happen because the values are limited when
writing the registers and only 32 bits of the return value matter but
change type of the variable storing the return value to uint32_t to
avoid these warnings. Also change DEFAULT_SC_BOTTOM_RIGHT register
read to match what other similar registers do for consistency.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/ati.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8286f67c1c..705e4db6e4 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -266,7 +266,7 @@ static void ati_vga_vblank_irq(void *opaque)
     ati_vga_update_irq(s);
 }
 
-static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
+static inline uint32_t ati_reg_read_offs(uint32_t reg, int offs,
                                          unsigned int size)
 {
     if (offs == 0 && size == 4) {
@@ -279,7 +279,7 @@ static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
 static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
 {
     ATIVGAState *s = opaque;
-    uint64_t val = 0;
+    uint32_t val = 0;
 
     switch (addr) {
     case MM_INDEX:
@@ -514,8 +514,8 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val |= s->regs.default_tile << 16;
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        val = (s->regs.default_sc_bottom << 16) |
-              s->regs.default_sc_right;
+        val = s->regs.default_sc_right;
+        val |= s->regs.default_sc_bottom << 16;
         break;
     case SC_TOP:
         val = s->regs.sc_top;
-- 
2.41.3


