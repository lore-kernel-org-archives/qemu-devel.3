Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021EB10854CB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2fow-0006bU-Af; Tue, 17 Mar 2026 21:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2fok-0006Z5-8K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:35:26 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2foh-0001iO-4k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:35:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E339E596DFC;
 Wed, 18 Mar 2026 02:35:21 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id orInmEtef46c; Wed, 18 Mar 2026 02:35:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E604A596ADE; Wed, 18 Mar 2026 02:35:19 +0100 (CET)
Message-ID: <3abba5651a31af2d40b20269e224c0dcec73fc9a.1773797056.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773797056.git.balaton@eik.bme.hu>
References: <cover.1773797056.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 3/6] ati-vga: Do not add crtc offset to src and dst data
 address
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Wed, 18 Mar 2026 02:35:19 +0100 (CET)
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

Drivers seem to program these registers with values that already
include the crtc offset so this is not needed. This fixes blit outside
of vram errors with non-0 crtc offset.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
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


