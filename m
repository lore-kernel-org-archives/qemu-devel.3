Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FA3F9B616
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV2X-0006wy-Hc; Wed, 22 Apr 2026 06:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2U-0006i2-C3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2S-0002jh-ID
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wu7QU8wJd5/GjX/3CNoBTbJbFIFHD2dzq5oUY7oRwPU=;
 b=bgSHfYasPf2te4kFnvvFnj+olMUzn4JAjTCUZeBQ+0JvyUD7qlvaoKdN/p20essZwp0or4
 tBb7dezLjzpj91QJiZu1EVV56Pv3phAmIB90FNu36HCtDkwQL3KDaHhbhXcnU53Rj5LHZb
 +9nvjq0Xm6Y0Fwp/8zigW6oe9GXg174=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-ZhJbDx47O6aFmOY0iplPVQ-1; Wed,
 22 Apr 2026 06:42:34 -0400
X-MC-Unique: ZhJbDx47O6aFmOY0iplPVQ-1
X-Mimecast-MFC-AGG-ID: ZhJbDx47O6aFmOY0iplPVQ_1776854553
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A1AE1955F0E; Wed, 22 Apr 2026 10:42:33 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B1A63000C15; Wed, 22 Apr 2026 10:42:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 17/40] ui/console-vc: set vt100 associated pixman image
Date: Wed, 22 Apr 2026 14:40:18 +0400
Message-ID: <20260422104042.3936506-18-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Start removing dependency on DisplaySurface for vt100 handling.

Note that before, the rendering is done on the current DisplaySurface.
It's not obvious the QemuTextConsole associated surface isn't changed
over time, in particular if it was doing resize. But
qemu_console_resize() is only implemented for QemuGraphicConsole.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 54 +++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 6cdb5893d32..272240712ad 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -48,6 +48,8 @@ enum TTYState {
 };
 
 typedef struct QemuVT100 {
+    pixman_image_t *image;
+
     int width;
     int height;
     int total_height;
@@ -133,28 +135,22 @@ qemu_text_console_get_label(const QemuConsole *c)
     return tc->chr ? g_strdup(tc->chr->label) : NULL;
 }
 
-static void qemu_console_fill_rect(QemuConsole *con, int posx, int posy,
-                                   int width, int height, pixman_color_t color)
+static void image_fill_rect(pixman_image_t *image, int posx, int posy,
+                            int width, int height, pixman_color_t color)
 {
-    DisplaySurface *surface = qemu_console_surface(con);
     pixman_rectangle16_t rect = {
         .x = posx, .y = posy, .width = width, .height = height
     };
 
-    assert(surface);
-    pixman_image_fill_rectangles(PIXMAN_OP_SRC, surface->image,
-                                 &color, 1, &rect);
+    pixman_image_fill_rectangles(PIXMAN_OP_SRC, image, &color, 1, &rect);
 }
 
 /* copy from (xs, ys) to (xd, yd) a rectangle of size (w, h) */
-static void qemu_console_bitblt(QemuConsole *con,
-                                int xs, int ys, int xd, int yd, int w, int h)
+static void image_bitblt(pixman_image_t *image,
+                         int xs, int ys, int xd, int yd, int w, int h)
 {
-    DisplaySurface *surface = qemu_console_surface(con);
-
-    assert(surface);
     pixman_image_composite(PIXMAN_OP_SRC,
-                           surface->image, NULL, surface->image,
+                           image, NULL, image,
                            xs, ys, 0, 0, xd, yd, w, h);
 }
 
@@ -162,10 +158,10 @@ static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
                           TextAttributes *t_attrib)
 {
     static pixman_image_t *glyphs[256];
-    DisplaySurface *surface = qemu_console_surface(s);
+    pixman_image_t *image = QEMU_TEXT_CONSOLE(s)->vt.image;
     pixman_color_t fgcol, bgcol;
 
-    assert(surface);
+    assert(image);
     if (t_attrib->invers) {
         bgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
         fgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
@@ -177,7 +173,7 @@ static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
     if (!glyphs[ch]) {
         glyphs[ch] = qemu_pixman_glyph_from_vgafont(FONT_HEIGHT, vgafont16, ch);
     }
-    qemu_pixman_glyph_render(glyphs[ch], surface->image,
+    qemu_pixman_glyph_render(glyphs[ch], image,
                              &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
 }
 
@@ -230,20 +226,20 @@ static void console_show_cursor(QemuTextConsole *s, int show)
 
 static void console_refresh(QemuTextConsole *s)
 {
-    DisplaySurface *surface = qemu_console_surface(QEMU_CONSOLE(s));
     QemuVT100 *vt = &s->vt;
     TextCell *c;
     int x, y, y1;
+    int w = pixman_image_get_width(vt->image);
+    int h = pixman_image_get_height(vt->image);
 
-    assert(surface);
     vt->text_x[0] = 0;
     vt->text_y[0] = 0;
     vt->text_x[1] = vt->width - 1;
     vt->text_y[1] = vt->height - 1;
     vt->cursor_invalidate = 1;
 
-    qemu_console_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
-                           color_table_rgb[0][QEMU_COLOR_BLACK]);
+    image_fill_rect(vt->image, 0, 0, w, h,
+                    color_table_rgb[0][QEMU_COLOR_BLACK]);
     y1 = vt->y_displayed;
     for (y = 0; y < vt->height; y++) {
         c = vt->cells + y1 * vt->width;
@@ -257,8 +253,7 @@ static void console_refresh(QemuTextConsole *s)
         }
     }
     console_show_cursor(s, 1);
-    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0,
-                   surface_width(surface), surface_height(surface));
+    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0, w, h);
 }
 
 static void console_scroll(QemuTextConsole *s, int ydelta)
@@ -398,8 +393,9 @@ static void text_console_resize(QemuTextConsole *t)
 
     assert(s->scanout.kind == SCANOUT_SURFACE);
 
-    w = surface_width(s->surface) / FONT_WIDTH;
-    h = surface_height(s->surface) / FONT_HEIGHT;
+    t->vt.image = s->surface->image;
+    w = pixman_image_get_width(t->vt.image) / FONT_WIDTH;
+    h = pixman_image_get_height(t->vt.image) / FONT_HEIGHT;
     if (w == t->vt.width && h == t->vt.height) {
         return;
     }
@@ -461,12 +457,12 @@ static void vc_put_lf(VCChardev *vc)
             vt->text_x[1] = vt->width - 1;
             vt->text_y[1] = vt->height - 1;
 
-            qemu_console_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
-                                vt->width * FONT_WIDTH,
-                                (vt->height - 1) * FONT_HEIGHT);
-            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (vt->height - 1) * FONT_HEIGHT,
-                                   vt->width * FONT_WIDTH, FONT_HEIGHT,
-                                   color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
+            image_bitblt(vt->image, 0, FONT_HEIGHT, 0, 0,
+                         vt->width * FONT_WIDTH,
+                         (vt->height - 1) * FONT_HEIGHT);
+            image_fill_rect(vt->image, 0, (vt->height - 1) * FONT_HEIGHT,
+                            vt->width * FONT_WIDTH, FONT_HEIGHT,
+                            color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
             vt->update_x0 = 0;
             vt->update_y0 = 0;
             vt->update_x1 = vt->width * FONT_WIDTH;
-- 
2.53.0


