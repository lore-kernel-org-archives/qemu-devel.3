Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6923EEA854B
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMw8-0003oQ-CX; Sun, 08 Mar 2026 18:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzMw6-0003no-MO
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:49:22 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzMw4-0005TO-O0
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:49:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9CF15596D97;
 Sun, 08 Mar 2026 23:49:18 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Z3v3a1X3OU56; Sun,  8 Mar 2026 23:49:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9C15F5969FD; Sun, 08 Mar 2026 23:49:16 +0100 (CET)
Message-ID: <90b49357b6bf80bcf8962331575ffd16a96b706a.1773009887.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773009887.git.balaton@eik.bme.hu>
References: <cover.1773009887.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/2] ati-vga: Simplify hw cursor drawing
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
Date: Sun, 08 Mar 2026 23:49:16 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Avoid calculating index at every step when we can just count the
position.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index be41f2e0e2..7543065456 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -200,7 +200,7 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
     ATIVGAState *s = container_of(vga, ATIVGAState, vga);
     uint32_t srcoff;
     uint32_t *dp = (uint32_t *)d;
-    int i, j, h;
+    int i, j, h, idx = 0;
 
     if (!(s->regs.crtc_gen_cntl & CRTC2_CUR_EN) ||
         scr_y < vga->hw_cursor_y || scr_y >= vga->hw_cursor_y + 64 ||
@@ -215,10 +215,10 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
         uint32_t color;
         uint8_t abits = vga_read_byte(vga, srcoff + i);
         uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
-        for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1) {
+        for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1, idx++) {
             if (abits & BIT(7)) {
                 if (xbits & BIT(7)) {
-                    color = dp[i * 8 + j] ^ 0xffffffff; /* complement */
+                    color = dp[idx] ^ 0xffffffff; /* complement */
                 } else {
                     continue; /* transparent, no change */
                 }
@@ -226,10 +226,10 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
                 color = (xbits & BIT(7) ? s->regs.cur_color1 :
                                           s->regs.cur_color0) | 0xff000000;
             }
-            if (vga->hw_cursor_x + i * 8 + j >= h) {
+            if (vga->hw_cursor_x + idx >= h) {
                 return; /* end of screen, don't span to next line */
             }
-            dp[i * 8 + j] = color;
+            dp[idx] = color;
         }
     }
 }
-- 
2.41.3


