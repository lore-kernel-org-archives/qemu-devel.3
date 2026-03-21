Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80D21099B4C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 01:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3klY-0008Qw-En; Fri, 20 Mar 2026 21:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3klX-0008QU-31
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 21:04:35 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3klU-0003zF-BG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 21:04:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8BE3E596E12;
 Sat, 21 Mar 2026 02:04:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BTIs0gQuyUnB; Sat, 21 Mar 2026 02:04:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 416A3596A4F; Sat, 21 Mar 2026 02:04:21 +0100 (CET)
Message-ID: <7d96c67f864845893d4903b988a4da7c7b010f66.1774054635.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1774054635.git.balaton@eik.bme.hu>
References: <cover.1774054635.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 3/8] ati-vga: Do not add crtc offset to src and dst data
 address
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 21 Mar 2026 02:04:21 +0100 (CET)
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

Drivers seem to program these registers with values that already
include the crtc offset so this is not needed. This fixes blit outside
of vram errors with non-0 crtc offset.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 0cbbdc33f4..cf2d4a08e2 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -110,7 +110,6 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->dst_stride = s->regs.dst_pitch;
     ctx->dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
         ctx->dst_stride *= ctx->bpp;
     }
 
@@ -121,7 +120,6 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->src_stride = s->regs.src_pitch;
     ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        ctx->src_bits += s->regs.crtc_offset & 0x07ffffff;
         ctx->src_stride *= ctx->bpp;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
-- 
2.41.3


