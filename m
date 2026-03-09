Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFFFEA852F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPjO-0005pb-Ef; Sun, 08 Mar 2026 21:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiz-0005la-VW
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiv-0001IB-V0
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7FB6F5969E7;
 Mon, 09 Mar 2026 02:47:50 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id dvkVew1uYPxV; Mon,  9 Mar 2026 02:47:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 78D625969EE; Mon, 09 Mar 2026 02:47:48 +0100 (CET)
Message-ID: <367949c50ca140a2d18ae66234dafbbc586b553c.1773020351.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773020351.git.balaton@eik.bme.hu>
References: <cover.1773020351.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v12 5/9] ati-vga: Split ati_2d_do_blt from ati_2d_blt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 09 Mar 2026 02:47:48 +0100 (CET)
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

From: Chad Jablonski <chad@jablonski.xyz>

ati_2d_blt remains the public interface to the blitter but the bulk of
the implementation is moved down into ati_2d_do_blt which is passed an
ATI2DCtx.

ati_2d_do_blt returns a bool that is true when the blit succeeded, which
means that a screen region will need to be set dirty. Otherwise false is
returned.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index a83cf14a4a..0475fcb585 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,24 +123,21 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-void ati_2d_blt(ATIVGAState *s)
+static bool ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
 {
-    ATI2DCtx ctx_;
-    ATI2DCtx *ctx = &ctx_;
-    setup_2d_blt_ctx(s, ctx);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
-        return;
+        return false;
     }
     if (!ctx->dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
-        return;
+        return false;
     }
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
         ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x +
         (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-        return;
+        return false;
     }
     switch (ctx->rop3) {
     case ROP3_SRCCOPY:
@@ -148,14 +145,14 @@ void ati_2d_blt(ATIVGAState *s)
         bool fallback = false;
         if (!ctx->src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
-            return;
+            return false;
         }
         if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff ||
             ctx->src_bits >= ctx->vram_end ||
             ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height) *
             ctx->src_stride >= ctx->vram_end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-            return;
+            return false;
         }
 
         DPRINTF("pixman_blt(%p, %p, %ld, %ld, %d, %d, %d, %d, %d, %d, %d, %d)\n",
@@ -265,8 +262,17 @@ void ati_2d_blt(ATIVGAState *s)
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
                       ctx->rop3 >> 16);
-        return;
+        return false;
     }
 
-    ati_set_dirty(&s->vga, ctx);
+    return true;
+}
+
+void ati_2d_blt(ATIVGAState *s)
+{
+    ATI2DCtx ctx;
+    setup_2d_blt_ctx(s, &ctx);
+    if (ati_2d_do_blt(s, &ctx)) {
+        ati_set_dirty(&s->vga, &ctx);
+    }
 }
-- 
2.41.3


