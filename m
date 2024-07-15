Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FA4C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TE-0004Bn-H3; Wed, 17 Jul 2024 07:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2Sb-0001Ke-2g
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:38 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SZ-00072Y-0i
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:36 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 5B102379645; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 20/26] hw/display/apple-gfx: Fixes cursor hotspot handling
Date: Mon, 15 Jul 2024 23:06:59 +0200
Message-Id: <20240715210705.32365-21-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

The ParavirtualizedGraphics framework provides the cursor's
hotspot, this change actually passes that information through to
Qemu's cursor handling.

This change also seizes the opportunity to make other cursor
related code conform to coding standards.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 437294d0fb..bc9722b420 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -223,7 +223,8 @@ static void apple_gfx_fb_update_display(void *opaque)
 
 static void update_cursor(AppleGFXState *s)
 {
-    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x, s->pgdisp.cursorPosition.y, s->cursor_show);
+    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
+                  s->pgdisp.cursorPosition.y, s->cursor_show);
 
     /* Need to render manually if cursor is not natively supported */
     if (!dpy_cursor_define_supported(s->con)) {
@@ -423,7 +424,8 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
         trace_apple_gfx_mode_change(sizeInPixels.x, sizeInPixels.y);
         set_mode(s, sizeInPixels.x, sizeInPixels.y);
     };
-    disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph, PGDisplayCoord_t hotSpot) {
+    disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
+                                     PGDisplayCoord_t hotSpot) {
         uint32_t bpp = glyph.bitsPerPixel;
         uint64_t width = glyph.pixelsWide;
         uint64_t height = glyph.pixelsHigh;
@@ -434,6 +436,8 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
             cursor_unref(s->cursor);
         }
         s->cursor = cursor_alloc(width, height);
+        s->cursor->hot_x = hotSpot.x;
+        s->cursor->hot_y = hotSpot.y;
 
         /* TODO handle different bpp */
         if (bpp == 32) {
-- 
2.39.3 (Apple Git-146)


