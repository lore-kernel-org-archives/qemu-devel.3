Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F261099B4C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 01:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3klV-0008P0-1j; Fri, 20 Mar 2026 21:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3klT-0008OU-4L
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 21:04:31 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3klR-0003yY-2p
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 21:04:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A9C99596E0E;
 Sat, 21 Mar 2026 02:04:26 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id EIY6_Rp0i2Fw; Sat, 21 Mar 2026 02:04:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 63009596DFE; Sat, 21 Mar 2026 02:04:23 +0100 (CET)
Message-ID: <6e1b83ef3fe7a1ebc246b474eb2b0c7cd05d5deb.1774054635.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1774054635.git.balaton@eik.bme.hu>
References: <cover.1774054635.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 5/8] ati-vga: Fix display updates in non-32 bit modes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 21 Mar 2026 02:04:23 +0100 (CET)
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

The memory_region_set_dirty used to mark changes should use stride
value in vram which is normally only the same as surface_stride in 32
bit modes. This caused missed updates in 8 and 16 bit modes.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index cf2d4a08e2..23527b2c50 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -70,6 +70,7 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
 {
     DisplaySurface *ds = qemu_console_surface(vga->con);
 
+    (void)ds;
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
             surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
             ctx->rop3 >> 16);
@@ -78,8 +79,8 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
         vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
         memory_region_set_dirty(&vga->vram,
                                 vga->vbe_start_addr + ctx->dst_offset +
-                                ctx->dst.y * surface_stride(ds),
-                                ctx->dst.height * surface_stride(ds));
+                                ctx->dst.y * ctx->dst_stride,
+                                ctx->dst.height * ctx->dst_stride);
     }
 }
 
-- 
2.41.3


