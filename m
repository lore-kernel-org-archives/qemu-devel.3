Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4E9E85374
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 15:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8fzy-0003b6-Dj; Fri, 03 Apr 2026 10:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w8fzk-0003Yq-BA
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:59:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w8fzi-0006kc-Bt
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:59:36 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4F238596A24;
 Fri, 03 Apr 2026 16:59:29 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id c2VB2pSCuHUt; Fri,  3 Apr 2026 16:59:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3F955596A2A; Fri, 03 Apr 2026 16:59:27 +0200 (CEST)
Message-ID: <2b8af6022aba06aa98a249ae67922de29d82d86f.1775228029.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1775228029.git.balaton@eik.bme.hu>
References: <cover.1775228029.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/2] ati-vga: Fix setting CRTC_OFFSET
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 03 Apr 2026 16:59:27 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Offset (display start address) should also be updated when changing
the register value not only on mode change. Fix the register write
mask to hard code bits 0:2 to 0 as the chip docs say and update the
start address on register write. This fixes virtual screen panning for
screens larger than displayed resolution.

As this register allows values that cannot be handled by the VBE_DISPI
X and Y offsets (which is restricted by line length) we add a function
to set it directly not through the VBE offsets.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index eb00382902..3976f5f01c 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -48,6 +48,19 @@ static const struct {
 
 enum { VGA_MODE, EXT_MODE };
 
+static void ati_vga_set_offset(VGACommonState *vga, uint32_t offs)
+{
+    int bypp = DIV_ROUND_UP(vga->vbe_regs[VBE_DISPI_INDEX_BPP], BITS_PER_BYTE);
+
+    if (!bypp ||
+        vga->vbe_regs[VBE_DISPI_INDEX_YRES] *
+        vga->vbe_regs[VBE_DISPI_INDEX_VIRT_WIDTH] * bypp + offs >
+        vga->vbe_size) {
+        return;
+    }
+    vga->vbe_start_addr = offs / 4;
+}
+
 static void ati_vga_switch_mode(ATIVGAState *s)
 {
     DPRINTF("%d -> %d\n",
@@ -110,26 +123,12 @@ static void ati_vga_switch_mode(ATIVGAState *s)
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_ENABLED |
                 VBE_DISPI_LFB_ENABLED | VBE_DISPI_NOCLEARMEM |
                 (s->regs.dac_cntl & DAC_8BIT_EN ? VBE_DISPI_8BIT_DAC : 0));
-            /* now set offset and stride after enable as that resets these */
+            /* now set offset and stride because enable resets these */
             if (stride) {
-                int bypp = DIV_ROUND_UP(bpp, BITS_PER_BYTE);
-
                 vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_VIRT_WIDTH);
                 vbe_ioport_write_data(&s->vga, 0, stride);
-                stride *= bypp;
-                if (offs % stride) {
-                    DPRINTF("CRTC offset is not multiple of pitch\n");
-                    vbe_ioport_write_index(&s->vga, 0,
-                                           VBE_DISPI_INDEX_X_OFFSET);
-                    vbe_ioport_write_data(&s->vga, 0, offs % stride / bypp);
-                }
-                vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFFSET);
-                vbe_ioport_write_data(&s->vga, 0, offs / stride);
-                DPRINTF("VBE offset (%d,%d), vbe_start_addr=%x\n",
-                        s->vga.vbe_regs[VBE_DISPI_INDEX_X_OFFSET],
-                        s->vga.vbe_regs[VBE_DISPI_INDEX_Y_OFFSET],
-                        s->vga.vbe_start_addr);
             }
+            ati_vga_set_offset(&s->vga, offs);
         }
     } else {
         /* VGA mode enabled */
@@ -752,7 +751,8 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.crtc_v_sync_strt_wid = data & 0x9f0fff;
         break;
     case CRTC_OFFSET:
-        s->regs.crtc_offset = data & 0xc7ffffff;
+        s->regs.crtc_offset = data & 0x87fffff8;
+        ati_vga_set_offset(&s->vga, s->regs.crtc_offset & 0x07ffffff);
         break;
     case CRTC_OFFSET_CNTL:
         s->regs.crtc_offset_cntl = data; /* FIXME */
-- 
2.41.3


