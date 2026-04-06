Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5FEE9D82E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 01:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Ydw-00076P-CY; Sun, 05 Apr 2026 21:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w9Ydt-00075y-EX
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 21:20:41 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w9Ydq-0001zK-RY
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 21:20:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3BC8C596A2C;
 Mon, 06 Apr 2026 03:20:33 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id hFlh91cczH3e; Mon,  6 Apr 2026 03:20:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 335A0596A24; Mon, 06 Apr 2026 03:20:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ati-vga: Do not crash on 24 bits per pixel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260406012031.335A0596A24@zero.eik.bme.hu>
Date: Mon, 06 Apr 2026 03:20:31 +0200 (CEST)
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

The stn_he_p function only supports power of two sizes so it will
assert if we call it with size 3 that happens with 24 bits per pixel.
It's not clear from the documentation if this should be supported or
not and drivers tested so far don't use it so refuse the parameters
that would crash QEMU for now.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 9baf6ff37b..f0f77cecc6 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -265,6 +265,10 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
     {
         uint32_t filler = 0;
 
+        if (ctx->bpp == 24) {
+            qemu_log_mask(LOG_UNIMP, "Fill blt unsupported in 24 bits\n");
+            return false;
+        }
         switch (ctx->rop3) {
         case ROP3_PATCOPY:
             filler = make_filler(ctx->bpp, ctx->frgd_clr);
@@ -362,6 +366,11 @@ bool ati_host_data_flush(ATIVGAState *s)
 
     setup_2d_blt_ctx(s, &ctx);
 
+    if (ctx.bpp == 24) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: unsupported in 24 bits mode\n");
+        return false;
+    }
     if (!ctx.left_to_right || !ctx.top_to_bottom) {
         qemu_log_mask(LOG_UNIMP,
                       "host_data_blt: unsupported blit direction %c%c\n",
-- 
2.41.3


