Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0950AC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lbQ-0008OH-OD; Wed, 16 Sep 2026 05:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lbP-0008NR-4o; Wed, 16 Sep 2026 05:06:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lbM-00071M-Uo; Wed, 16 Sep 2026 05:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549558; bh=5MYcBkhmyM4o5DOkggo6Nz0eCpywz9LbMKZq+b237qU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B/jly1mDWzh/qASOV7BRZQk+NLNoJNqT1gjI5m7lXXewQYpv7wljUq2xZuAsECObS
 BN+RIVJAsd02+L8GMMLyvv5nTQttQIBCRtlHYuc3QYEi0onoOY/yaHeY5yfTYLP1wW
 l2C5gRSOsPYPqITojtUfxIB+P/YhyuczpFOPNlFzMcPPrAtSYi0wzcLmv8LLEos8an
 fJoveDDpBpQ8j/3ohUABOpnQSEewGabOyg3A1Q+zSuXWiFJaQuQ8lD2uS8+u6iKJ+2
 6lO8lNBi3t1Xh6xrpYo96eSf7rj+TwBbkqgj3iOozgftXNVV9qpe4pEohQDVousfUq
 blL1twMg4Gr/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F3D21D56B9;
 Wed, 16 Sep 2026 12:05:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2A798429E04;
 Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0F67B5A763; Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Warisjeet Singh <sinxx198@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 05/57] hw/display/vga: fix text-mode OOB write after a
 graphics surface switch
Date: Wed, 16 Sep 2026 12:03:29 +0300
Message-ID: <20260916090516.677749-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Warisjeet Singh <sinxx198@gmail.com>

vga_draw_text() decides whether the console surface needs a resize from
its geometry cache, but none of the cache terms observe the graphics
renderer having replaced the console surface in between:

- last_width/last_height are shared with vga_draw_graphic(), which
  stores them in pixels while the text path stores characters;
- last_depth stays 0 for legacy (non-VBE) graphics modes, because
  vga_get_bpp() only reports a depth when VBE is enabled, so the
  "s->last_depth" term that normally forces a resize after a graphics
  frame does not fire.

So a graphics frame that shrinks the console surface (e.g. 80x25
pixels) followed by a text frame with matching character geometry
(80x25 chars) skips the resize, and the glyph loop then paints
width*cw x height*cheight pixels into the smaller surface, out of
bounds, with guest-controlled (DAC palette) values, on every display
refresh.

Separate the geometry cache per renderer: text paths (vga_draw_text,
vga_update_text, and the text handling in vga_invalidate_display /
vga_common_reset) now only manipulate last_text_{width,height}, in
characters; last_{width,height} become graphics-only, in pixels.
Additionally, make the text path compare the pixel size it is about
to paint against the console surface's actual dimensions.  The
surface check is the load-bearing term: caches in either unit cannot
see the other renderer swapping the surface, the surface can.

Fixes: CVE-2026-77913
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4215
Cc: qemu-stable@nongnu.org
Signed-off-by: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
Message-ID: <vga-v3-20260824.sinxx198@gmail.com>
(cherry picked from commit 418396be8013386a81f8d8d89ac0effcf03a64b6)
(Mjt: adjust across v11.0.0-787-g405a42e36550
 "ui/console: rename public API to use consistent qemu_console_ prefix")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/vga.c b/hw/display/vga.c
index f9f3d054f61..b8f7ed13013 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1240,7 +1240,10 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         return;
     }
 
-    if (width != s->last_width || height != s->last_height ||
+    if (surface == NULL ||
+        surface_width(surface) != width * cw ||
+        surface_height(surface) != height * cheight ||
+        width != s->last_text_width || height != s->last_text_height ||
         cw != s->last_cw || cheight != s->last_ch || s->last_depth) {
         s->last_scr_width = width * cw;
         s->last_scr_height = height * cheight;
@@ -1248,8 +1251,8 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         surface = qemu_console_surface(s->con);
         dpy_text_resize(s->con, width, height);
         s->last_depth = 0;
-        s->last_width = width;
-        s->last_height = height;
+        s->last_text_width = width;
+        s->last_text_height = height;
         s->last_ch = cheight;
         s->last_cw = cw;
         full_update = 1;
@@ -1828,6 +1831,8 @@ static void vga_invalidate_display(void *opaque)
 
     s->last_width = -1;
     s->last_height = -1;
+    s->last_text_width = -1;
+    s->last_text_height = -1;
 }
 
 void vga_common_reset(VGACommonState *s)
@@ -1870,6 +1875,8 @@ void vga_common_reset(VGACommonState *s)
     s->last_ch = 0;
     s->last_width = 0;
     s->last_height = 0;
+    s->last_text_width = 0;
+    s->last_text_height = 0;
     s->last_scr_width = 0;
     s->last_scr_height = 0;
     s->cursor_start = 0;
@@ -1921,8 +1928,8 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
         s->graphic_mode = graphic_mode;
         full_update = 1;
     }
-    if (s->last_width == -1) {
-        s->last_width = 0;
+    if (s->last_text_width == -1) {
+        s->last_text_width = 0;
         full_update = 1;
     }
 
@@ -1961,15 +1968,15 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
             break;
         }
 
-        if (width != s->last_width || height != s->last_height ||
+        if (width != s->last_text_width || height != s->last_text_height ||
             cw != s->last_cw || cheight != s->last_ch) {
             s->last_scr_width = width * cw;
             s->last_scr_height = height * cheight;
             qemu_console_resize(s->con, s->last_scr_width, s->last_scr_height);
             dpy_text_resize(s->con, width, height);
             s->last_depth = 0;
-            s->last_width = width;
-            s->last_height = height;
+            s->last_text_width = width;
+            s->last_text_height = height;
             s->last_ch = cheight;
             s->last_cw = cw;
             full_update = 1;
@@ -2054,22 +2061,22 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
     }
 
     /* Display a message */
-    s->last_width = 60;
-    s->last_height = height = 3;
+    s->last_text_width = 60;
+    s->last_text_height = height = 3;
     dpy_text_cursor(s->con, -1, -1);
-    dpy_text_resize(s->con, s->last_width, height);
+    dpy_text_resize(s->con, s->last_text_width, height);
 
-    for (dst = chardata, i = 0; i < s->last_width * height; i ++)
+    for (dst = chardata, i = 0; i < s->last_text_width * height; i ++)
         console_write_ch(dst ++, ' ');
 
     size = strlen(msg_buffer);
-    width = (s->last_width - size) / 2;
-    dst = chardata + s->last_width + width;
+    width = (s->last_text_width - size) / 2;
+    dst = chardata + s->last_text_width + width;
     for (i = 0; i < size; i ++)
         console_write_ch(dst ++, ATTR2CHTYPE(msg_buffer[i], QEMU_COLOR_BLUE,
                                              QEMU_COLOR_BLACK, 1));
 
-    dpy_text_update(s->con, 0, 0, s->last_width, height);
+    dpy_text_update(s->con, 0, 0, s->last_text_width, height);
 }
 
 static uint64_t vga_mem_read(void *opaque, hwaddr addr,
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 747b5cc6cf8..1950ef5fcd0 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -122,7 +122,8 @@ typedef struct VGACommonState {
     uint32_t plane_updated;
     uint32_t last_line_offset;
     uint8_t last_cw, last_ch;
-    uint32_t last_width, last_height; /* in chars or pixels */
+    uint32_t last_width, last_height; /* in pixels (graphics renderer) */
+    uint32_t last_text_width, last_text_height; /* in chars (text renderer) */
     uint32_t last_scr_width, last_scr_height; /* in pixels */
     uint32_t last_depth; /* in bits */
     bool last_byteswap;
-- 
2.47.3


