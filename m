Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8DECCFA03
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 14:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFCBC-0008G0-9p; Sat, 01 Nov 2025 10:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFCB9-0008Fk-Ey
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 10:02:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFCB6-0001xf-F3
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 10:02:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0FCA0597300;
 Sat, 01 Nov 2025 15:01:56 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rp4d95b0A6LV; Sat,  1 Nov 2025 15:01:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 156A95972E9; Sat, 01 Nov 2025 15:01:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 139BB5972E3;
 Sat, 01 Nov 2025 15:01:54 +0100 (CET)
Date: Sat, 1 Nov 2025 15:01:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com, 
 qemu-devel@nongnu.org
Subject: [PATCH] ati-vga: Separate default control bit for source (fwd)
Message-ID: <f6e2b734-e10b-fc2b-a307-47f18d2a01a2@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hello,

Maybe you can also review (with Reviewed-by tag) and rebase on this patch 
I've sent before. I don't know about any problem this fixes but what we 
have now is not entirely correct.

Regards,
BALATON Zoltan

---------- Forwarded message ----------
Date: Tue, 07 Oct 2025 21:54:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com
Subject: [PATCH] ati-vga: Separate default control bit for source

The DP_GUI_MASTER_CNTL register has separate bits for src and dest but
we were only looking at the dest bit. Use the correct bit for source.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
  hw/display/ati_2d.c | 11 ++++++-----
  1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 309bb5ccb6..e69b15b570 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -43,7 +43,8 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
      }
  }

-#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
+#define DFLT_CNTL_SRC (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL)
+#define DFLT_CNTL_DST (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)

  void ati_2d_blt(ATIVGAState *s)
  {
@@ -63,12 +64,12 @@ void ati_2d_blt(ATIVGAState *s)
          qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
          return;
      }
-    int dst_stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch;
+    int dst_stride = DFLT_CNTL_DST ? s->regs.dst_pitch : s->regs.default_pitch;
      if (!dst_stride) {
          qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
          return;
      }
-    uint8_t *dst_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
+    uint8_t *dst_bits = s->vga.vram_ptr + (DFLT_CNTL_DST ?
                          s->regs.dst_offset : s->regs.default_offset);

      if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
@@ -97,13 +98,13 @@ void ati_2d_blt(ATIVGAState *s)
                         s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
          unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
                         s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
-        int src_stride = DEFAULT_CNTL ?
+        int src_stride = DFLT_CNTL_SRC ?
                           s->regs.src_pitch : s->regs.default_pitch;
          if (!src_stride) {
              qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
              return;
          }
-        uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
+        uint8_t *src_bits = s->vga.vram_ptr + (DFLT_CNTL_SRC ?
                              s->regs.src_offset : s->regs.default_offset);

          if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-- 
2.41.3



