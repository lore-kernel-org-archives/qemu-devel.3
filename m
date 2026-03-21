Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A681C1094480
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3zDi-0006DC-0G; Sat, 21 Mar 2026 12:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDZ-0006AO-3k
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:30 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDW-0002FH-P8
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:28 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 42F9E596E02;
 Sat, 21 Mar 2026 17:30:21 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Z9elW9acaXIw; Sat, 21 Mar 2026 17:30:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3F5A8596E0C; Sat, 21 Mar 2026 17:30:19 +0100 (CET)
Message-ID: <2ecf42bdeb96a4206b27dc39b3ff13cc8a6190d0.1774110169.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1774110169.git.balaton@eik.bme.hu>
References: <cover.1774110169.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 8/8] ati-vga: Make sure hardware cursor data is within vram
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 21 Mar 2026 17:30:19 +0100 (CET)
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

Add check to make sure we don't read past the end of vram when getting
mouse pointer image.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index e1616dc3b3..d7b131d633 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -151,6 +151,9 @@ static void ati_cursor_define(ATIVGAState *s)
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
              (s->regs.cur_hv_offs & 0xffff) * 16;
+    if (srcoff + 64 * 16 > s->vga.vram_size) {
+        return;
+    }
     for (int i = 0; i < 64; i++, srcoff += 16) {
         data[i] = ldq_le_p(&s->vga.vram_ptr[srcoff]);
         data[i + 64] = ldq_le_p(&s->vga.vram_ptr[srcoff + 8]);
@@ -205,6 +208,9 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
     }
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
+    if (srcoff + 16 > s->vga.vram_size) {
+        return;
+    }
     dp = &dp[vga->hw_cursor_x];
     h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
     abits = ldq_be_p(&vga->vram_ptr[srcoff]);
-- 
2.41.3


