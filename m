Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62302EA852F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMw8-0003oh-Ps; Sun, 08 Mar 2026 18:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzMw7-0003o3-Mf
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:49:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzMw5-0005TR-JG
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:49:23 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ABB21596D9A;
 Sun, 08 Mar 2026 23:49:19 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id RTM1MFTzulFa; Sun,  8 Mar 2026 23:49:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A99CC596D94; Sun, 08 Mar 2026 23:49:17 +0100 (CET)
Message-ID: <26db0715a6b9f6504f394010513facc9a37882ad.1773009887.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773009887.git.balaton@eik.bme.hu>
References: <cover.1773009887.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/2] ati-vga: Do not access pixel outside the screen
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
Date: Sun, 08 Mar 2026 23:49:17 +0100 (CET)
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

We check end of screen before writing the pixel but before that
complement color also accesses screen pixel so we have to check before
that. This fixes a segmentation fault with guest_hwcursor when pointer
is partially out of screen at lower right corner.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 7543065456..9fb798b3e9 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -216,6 +216,9 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
         uint8_t abits = vga_read_byte(vga, srcoff + i);
         uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
         for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1, idx++) {
+            if (vga->hw_cursor_x + idx >= h) {
+                return; /* end of screen, don't span to next line */
+            }
             if (abits & BIT(7)) {
                 if (xbits & BIT(7)) {
                     color = dp[idx] ^ 0xffffffff; /* complement */
@@ -226,9 +229,6 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
                 color = (xbits & BIT(7) ? s->regs.cur_color1 :
                                           s->regs.cur_color0) | 0xff000000;
             }
-            if (vga->hw_cursor_x + idx >= h) {
-                return; /* end of screen, don't span to next line */
-            }
             dp[idx] = color;
         }
     }
-- 
2.41.3


