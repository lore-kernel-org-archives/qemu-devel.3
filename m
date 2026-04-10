Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DD7F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHPE-0004zk-5Z; Fri, 10 Apr 2026 15:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOy-0004jP-Qe
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOx-000189-2N
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f95ATmdiY5d94eUC7k7kUvpTiBIL3Lv55v1kPJaIGF4=;
 b=YNrsQqX62UbvljsJx/WgIXnP3vcllvgU9TiyHRsiYFVQNcoYYVgFbKyvUmF6xB2GEVd1HA
 9Ueq+L/v+EmcPX8FT/levG2oL/cw6xgA19Gg3csd1BnXqkJq/marJsAmrM5Pi1lLKuLj0r
 ag7NFbeca8pg+MarTRa1RND8BttI3/g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-WOBWvqk7NlqgHBfxx0W9aQ-1; Fri,
 10 Apr 2026 15:20:21 -0400
X-MC-Unique: WOBWvqk7NlqgHBfxx0W9aQ-1
X-Mimecast-MFC-AGG-ID: WOBWvqk7NlqgHBfxx0W9aQ_1775848820
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 497361800345; Fri, 10 Apr 2026 19:20:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1427D180049F; Fri, 10 Apr 2026 19:20:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:36 +0400
Subject: [PATCH v2 14/67] ui/console-vc: set vt100 associated pixman image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-14-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6225;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Baw5rMs8bwBjzgkFxZfs9rC3Qi9crFdvgPbcJYPkFdA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0UiLQ1zmqXqirOk/DEQHM5sO+/yxLCRvOAn
 TrGhwD62NyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5SLDD/4y+k5xRbncqE5dUmjnNcGuf4ikWb1TZEM6+fmKPBOfgQYPLS/0Bm3lbKwYOC3mGLkt0K9
 vp6kIOvdDzozBUzINWrrMnjaro5pMcmkCaTUYbNq79x0gJ58Uzcyxd65xH0SIDfUbDxVyalAeFj
 tJUTB/4L6Oeq8c969Aa6bOchCtcsKPxdQ58R7MDjQ1jBTnZB/ig5EHi2eQTjKAhXE7o6fLG3N5Q
 ztJwqfusyd1pejBsPzPIoPRvNOErPhFWvIwIgvZTKmBX5wGkfCh9xWd0q1N/qbHrtMhqeUsroCQ
 xIKlRyYkUJ0g5jrZYUQBHquE15rkcx3g+77++tERVwJGTzPBkOlPlippATI8oTASv5bUhds9vGv
 kswdu6zKwtzdkyOMbsn71JdpXVL0nmEIAD64JAOR7V6GyGTzErXuS9vDc6bqBIA106oOO+nGKva
 z+lvGk35LV49TeAMwbLsKkONwMkO93nsNo6o3E3ur7hcRBnOGQPhdoB+SvZ82cMkBsh2qPBAixi
 aVIYUq4mghHE1PX+jLQsT7cKjAil+mzw//+kh0uqgMhaHDABZFkkujHBFIXZUUFsXrQlr1A1eAl
 d1aPYEkI+6IRzww0FjqMR5HNkoohmPZIP+wH5Zw99UfxpX3NaZGVPf7nua4ceuvTNwmv/dEDEJC
 abYWqFPC0vGOYHQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Start removing dependency on DisplaySurface for vt100 handling.

Note that before, the rendering is done on the current DisplaySurface.
It's not obvious the QemuTextConsole associated surface isn't changed
over time, in particular if it was doing resize. But
qemu_console_resize() is only implemented for QemuGraphicConsole.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 54 +++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index cc061dff769..267620689e4 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -49,6 +49,8 @@ enum TTYState {
 };
 
 typedef struct QemuVT100 {
+    pixman_image_t *image;
+
     int width;
     int height;
     int total_height;
@@ -136,28 +138,22 @@ qemu_text_console_get_label(QemuConsole *c)
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
 
@@ -165,10 +161,10 @@ static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
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
@@ -180,7 +176,7 @@ static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
     if (!glyphs[ch]) {
         glyphs[ch] = qemu_pixman_glyph_from_vgafont(FONT_HEIGHT, vgafont16, ch);
     }
-    qemu_pixman_glyph_render(glyphs[ch], surface->image,
+    qemu_pixman_glyph_render(glyphs[ch], image,
                              &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
 }
 
@@ -233,20 +229,20 @@ static void console_show_cursor(QemuTextConsole *s, int show)
 
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
@@ -260,8 +256,7 @@ static void console_refresh(QemuTextConsole *s)
         }
     }
     console_show_cursor(s, 1);
-    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0,
-                   surface_width(surface), surface_height(surface));
+    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0, w, h);
 }
 
 static void console_scroll(QemuTextConsole *s, int ydelta)
@@ -401,8 +396,9 @@ static void text_console_resize(QemuTextConsole *t)
 
     assert(s->scanout.kind == SCANOUT_SURFACE);
 
-    w = surface_width(s->surface) / FONT_WIDTH;
-    h = surface_height(s->surface) / FONT_HEIGHT;
+    t->vt.image = s->surface->image;
+    w = pixman_image_get_width(t->vt.image) / FONT_WIDTH;
+    h = pixman_image_get_height(t->vt.image) / FONT_HEIGHT;
     if (w == t->vt.width && h == t->vt.height) {
         return;
     }
@@ -464,12 +460,12 @@ static void vc_put_lf(VCChardev *vc)
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


