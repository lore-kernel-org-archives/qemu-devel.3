Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AC5F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QA8-0006Ve-Rd; Tue, 17 Mar 2026 04:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9w-0006MO-SA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9u-00036c-JU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v84VBpSQgz2PPhXB8Ma6dazp9VnMQEVtuOehucqBMT4=;
 b=Yi8E3zVoKMWPiLDXFZknodOPkY2pvuDlitgox6tb4xrbicNPrSB6jhB6bk3HrIYoujCon7
 RsNd6183LRjOrriJhU59Jor1j6/OxTymHueil0n5BiTgToTthvz7nlXl9D/ByTQbRiwPre
 tXPJeldz5i1Xq/8g967oNQR1epiPkBM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-XQubV-tqPiaFLNgCpTxx6g-1; Tue,
 17 Mar 2026 04:52:12 -0400
X-MC-Unique: XQubV-tqPiaFLNgCpTxx6g-1
X-Mimecast-MFC-AGG-ID: XQubV-tqPiaFLNgCpTxx6g_1773737531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C127A195609D
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7CD61800107
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:30 +0400
Subject: [PATCH 16/60] ui/console-vc: set vt100 associated pixman image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-16-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=6201;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dllytJgn8BKfG5SylgaGTl1vNecfGPX/OUJOPjb45E0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXaArWNiEtVi6lekkhc2CEcWwxRhZXRmSb2M
 LAKXbtObqyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5fuHD/oDCDqWf82576YCPgvVbrpf6mh4XwEGXOVSBPhv6c4Y1iz/pAAP/OOy5xUnjdwL4P5HBGF
 AkJn1+suljEw5Eu5RV1ZnP8VOcuK86odDC/vfriHIsZOYt1Z/3C67sbBY5yTN8dACaOF5QWZ4B6
 oAQkQ4gzKyuxR/SWLwXVOs8wMxV90xZzUkMUB0gwUYJz0A+pka8n7RtBppDGcVMbE2JuYNqpBwr
 E9qi+/1ZVq3xcM2uk1WrGHpBwdFDOVXfD8os6TuxTg5vVNHI1Nrt12/SeR6+UmRk3+y5m3a1NDR
 ipvwYDYOwxKMaAeGxF5d8VU8+fUYuedUG8KYulzHtIVCOYaHi8wrSaKPwEkmR1zVwbjmvqp5eYm
 oHNseQAMx6BEIOpW29BuVV60ZqozFbVbOHtyjTXsDO7HfDCDbmaF8+Af1axUb8QfVGI566ExEBL
 aA2mHxl9ugQ9f1/cZaVrXccDfG+lUAbdgguluSdnCDXf12W+GSzPnTBX2tj9E7C9jSiwgJGgN5k
 +Yr2VxAF+YqMtVAhcZliS6HaXbeg6J770GlJjlpKKWWFIPomeGdDPgdLOqoKApc1Xrjxx2F20Xc
 qJpT1rZk4fOjA9rSZClx6zrNyUqeGxiJF5avD3Tc7J2sVVJyjH3rdnGQoPwo7fCFrF9QR8dtF7N
 iDvjyydN6LawFFg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 54 +++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 41436a38eb5..0e0a9ad245d 100644
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
 
@@ -230,19 +226,19 @@ static void console_show_cursor(QemuTextConsole *s, int show)
 
 static void console_refresh(QemuTextConsole *s)
 {
-    DisplaySurface *surface = qemu_console_surface(QEMU_CONSOLE(s));
     TextCell *c;
     int x, y, y1;
+    int w = pixman_image_get_width(s->vt.image);
+    int h = pixman_image_get_height(s->vt.image);
 
-    assert(surface);
     s->vt.text_x[0] = 0;
     s->vt.text_y[0] = 0;
     s->vt.text_x[1] = s->vt.width - 1;
     s->vt.text_y[1] = s->vt.height - 1;
     s->vt.cursor_invalidate = 1;
 
-    qemu_console_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
-                           color_table_rgb[0][QEMU_COLOR_BLACK]);
+    image_fill_rect(s->vt.image, 0, 0, w, h,
+                    color_table_rgb[0][QEMU_COLOR_BLACK]);
     y1 = s->vt.y_displayed;
     for (y = 0; y < s->vt.height; y++) {
         c = s->vt.cells + y1 * s->vt.width;
@@ -256,8 +252,7 @@ static void console_refresh(QemuTextConsole *s)
         }
     }
     console_show_cursor(s, 1);
-    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0,
-                   surface_width(surface), surface_height(surface));
+    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0, w, h);
 }
 
 static void console_scroll(QemuTextConsole *s, int ydelta)
@@ -394,8 +389,9 @@ static void text_console_resize(QemuTextConsole *t)
 
     assert(s->scanout.kind == SCANOUT_SURFACE);
 
-    w = surface_width(s->surface) / FONT_WIDTH;
-    h = surface_height(s->surface) / FONT_HEIGHT;
+    t->vt.image = s->surface->image;
+    w = pixman_image_get_width(t->vt.image) / FONT_WIDTH;
+    h = pixman_image_get_height(t->vt.image) / FONT_HEIGHT;
     if (w == t->vt.width && h == t->vt.height) {
         return;
     }
@@ -456,12 +452,12 @@ static void vc_put_lf(VCChardev *vc)
             s->vt.text_x[1] = s->vt.width - 1;
             s->vt.text_y[1] = s->vt.height - 1;
 
-            qemu_console_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
-                                s->vt.width * FONT_WIDTH,
-                                (s->vt.height - 1) * FONT_HEIGHT);
-            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (s->vt.height - 1) * FONT_HEIGHT,
-                                   s->vt.width * FONT_WIDTH, FONT_HEIGHT,
-                                   color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
+            image_bitblt(s->vt.image, 0, FONT_HEIGHT, 0, 0,
+                         s->vt.width * FONT_WIDTH,
+                         (s->vt.height - 1) * FONT_HEIGHT);
+            image_fill_rect(s->vt.image, 0, (s->vt.height - 1) * FONT_HEIGHT,
+                            s->vt.width * FONT_WIDTH, FONT_HEIGHT,
+                            color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
             s->vt.update_x0 = 0;
             s->vt.update_y0 = 0;
             s->vt.update_x1 = s->vt.width * FONT_WIDTH;

-- 
2.53.0


