Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FF8F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHOx-0004hy-Lk; Fri, 10 Apr 2026 15:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOv-0004g1-QR
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOs-000170-Vc
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+3nHPs9xR2D8mkEMq5b7qsnC0hTkTfJrxig+fdBYlo=;
 b=gIBEn14NZQO7mcnfrXktjhAoxNAW0KldkUyOVebIBw66qTuUi8MKH6mOhwyATWtU6oR7x0
 H7aCpW7UTQspkF5YGwbjS68f0BilNLro39xVH+mk1Q40hHQXmaRi9nGg3QEg+pfdbEAXFc
 E7uWD+WxnKL3WWid7paPTpS8r8oLoDQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-jtfE0P7fOAig-na2HDDHVQ-1; Fri,
 10 Apr 2026 15:20:15 -0400
X-MC-Unique: jtfE0P7fOAig-na2HDDHVQ-1
X-Mimecast-MFC-AGG-ID: jtfE0P7fOAig-na2HDDHVQ_1775848814
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A7FA19560BB; Fri, 10 Apr 2026 19:20:14 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42DDF1801ACE; Fri, 10 Apr 2026 19:20:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:35 +0400
Subject: [PATCH v2 13/67] ui/console-vc: introduce QemuVT100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-13-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=28456;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5qFx7O1tTryueCgr78HCGFQy8xKJFAZYAw5dmxbXGno=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0Usn9NDLkDIVGcTE5NIt0lyX6IA841K3Ff4
 rKXL/HWk6GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5aMsD/4yLqeuuM7moJpAaPsfIkXQ+DUt+b0lN0Z7tqn9RiE/9BOxYn+J5qCZk1t1G4V5HxQs3Y1
 oWrH2OJkPMevI6kV8rnlfafM0+ZiGlpCMENcwEK5dS2WBCTwRGVwNaKYzCKETRyKfGQEfYifIW3
 BkFcOpkxYuorm2ghvDt/Ol0KK3nex8To/9SkP1N3RjtDb8FPUP/63yOCRDucRQIMeYJ+qoIQ3yb
 EqXY9OL29OuwxdEIemiPsoR0k0W9EVxqOcbLN03EjqQ4XxgoD4CRa+QWLJuwXtcirmcVHfggt60
 7tMoI/GNGwTA0Jbfv7rn6+FGULetRnT/Dr4GxDq7bJpx5+1tBPiOKKpI8su+5fmwowNt85ZAyE8
 2uc+nGGLpRyVBVmcdQpqxGciIJrQprDxcmdr1CeNTQYaPeh38bt7WcgxgiD+GoMoizlhMtXa5lK
 wmsiGVJDDSKwgVUQ5UfJ6UMIsMayar/sDH+ABnOsmz4gJwH4qXOFE9iAc8yVRfPbnD5CxYmzFHS
 vkwVPI/bvdvpl5+pw9R/eCTh7cpAKN6OgnPrxAXYMFYH8IPCAAN/VlypK8cHwxtdrALaHwtQjOT
 3le8jHQxQeDU99X1w/FWTQFGEWOAuCfdWBuwiZ3wK3uXOFUIT2xBUUXzbVDAwW6BI7azNjbYbLi
 tQreR9yYq3pqBmg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Start moving VT100 emulation specific code in a different structure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 399 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 210 insertions(+), 189 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 7b9acf1adb1..cc061dff769 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -48,9 +48,7 @@ enum TTYState {
     TTY_STATE_OSC,
 };
 
-typedef struct QemuTextConsole {
-    QemuConsole parent;
-
+typedef struct QemuVT100 {
     int width;
     int height;
     int total_height;
@@ -66,7 +64,12 @@ typedef struct QemuTextConsole {
     int update_y0;
     int update_x1;
     int update_y1;
+} QemuVT100;
 
+typedef struct QemuTextConsole {
+    QemuConsole parent;
+
+    QemuVT100 vt;
     Chardev *chr;
     /* fifo for key pressed */
     Fifo8 out_fifo;
@@ -183,37 +186,40 @@ static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
 
 static void invalidate_xy(QemuTextConsole *s, int x, int y)
 {
+    QemuVT100 *vt = &s->vt;
+
     if (!qemu_console_is_visible(QEMU_CONSOLE(s))) {
         return;
     }
-    if (s->update_x0 > x * FONT_WIDTH)
-        s->update_x0 = x * FONT_WIDTH;
-    if (s->update_y0 > y * FONT_HEIGHT)
-        s->update_y0 = y * FONT_HEIGHT;
-    if (s->update_x1 < (x + 1) * FONT_WIDTH)
-        s->update_x1 = (x + 1) * FONT_WIDTH;
-    if (s->update_y1 < (y + 1) * FONT_HEIGHT)
-        s->update_y1 = (y + 1) * FONT_HEIGHT;
+    if (vt->update_x0 > x * FONT_WIDTH)
+        vt->update_x0 = x * FONT_WIDTH;
+    if (vt->update_y0 > y * FONT_HEIGHT)
+        vt->update_y0 = y * FONT_HEIGHT;
+    if (vt->update_x1 < (x + 1) * FONT_WIDTH)
+        vt->update_x1 = (x + 1) * FONT_WIDTH;
+    if (vt->update_y1 < (y + 1) * FONT_HEIGHT)
+        vt->update_y1 = (y + 1) * FONT_HEIGHT;
 }
 
 static void console_show_cursor(QemuTextConsole *s, int show)
 {
+    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int y, y1;
-    int x = s->x;
+    int x = vt->x;
 
-    s->cursor_invalidate = 1;
+    vt->cursor_invalidate = 1;
 
-    if (x >= s->width) {
-        x = s->width - 1;
+    if (x >= vt->width) {
+        x = vt->width - 1;
     }
-    y1 = (s->y_base + s->y) % s->total_height;
-    y = y1 - s->y_displayed;
+    y1 = (vt->y_base + vt->y) % vt->total_height;
+    y = y1 - vt->y_displayed;
     if (y < 0) {
-        y += s->total_height;
+        y += vt->total_height;
     }
-    if (y < s->height) {
-        c = &s->cells[y1 * s->width + x];
+    if (y < vt->height) {
+        c = &vt->cells[y1 * vt->width + x];
         if (show && cursor_visible_phase) {
             TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
@@ -228,27 +234,28 @@ static void console_show_cursor(QemuTextConsole *s, int show)
 static void console_refresh(QemuTextConsole *s)
 {
     DisplaySurface *surface = qemu_console_surface(QEMU_CONSOLE(s));
+    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int x, y, y1;
 
     assert(surface);
-    s->text_x[0] = 0;
-    s->text_y[0] = 0;
-    s->text_x[1] = s->width - 1;
-    s->text_y[1] = s->height - 1;
-    s->cursor_invalidate = 1;
+    vt->text_x[0] = 0;
+    vt->text_y[0] = 0;
+    vt->text_x[1] = vt->width - 1;
+    vt->text_y[1] = vt->height - 1;
+    vt->cursor_invalidate = 1;
 
     qemu_console_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
                            color_table_rgb[0][QEMU_COLOR_BLACK]);
-    y1 = s->y_displayed;
-    for (y = 0; y < s->height; y++) {
-        c = s->cells + y1 * s->width;
-        for (x = 0; x < s->width; x++) {
+    y1 = vt->y_displayed;
+    for (y = 0; y < vt->height; y++) {
+        c = vt->cells + y1 * vt->width;
+        for (x = 0; x < vt->width; x++) {
             vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch,
                           &(c->t_attrib));
             c++;
         }
-        if (++y1 == s->total_height) {
+        if (++y1 == vt->total_height) {
             y1 = 0;
         }
     }
@@ -259,28 +266,29 @@ static void console_refresh(QemuTextConsole *s)
 
 static void console_scroll(QemuTextConsole *s, int ydelta)
 {
+    QemuVT100 *vt = &s->vt;
     int i, y1;
 
     if (ydelta > 0) {
         for(i = 0; i < ydelta; i++) {
-            if (s->y_displayed == s->y_base)
+            if (vt->y_displayed == vt->y_base)
                 break;
-            if (++s->y_displayed == s->total_height)
-                s->y_displayed = 0;
+            if (++vt->y_displayed == vt->total_height)
+                vt->y_displayed = 0;
         }
     } else {
         ydelta = -ydelta;
-        i = s->backscroll_height;
-        if (i > s->total_height - s->height)
-            i = s->total_height - s->height;
-        y1 = s->y_base - i;
+        i = vt->backscroll_height;
+        if (i > vt->total_height - vt->height)
+            i = vt->total_height - vt->height;
+        y1 = vt->y_base - i;
         if (y1 < 0)
-            y1 += s->total_height;
+            y1 += vt->total_height;
         for(i = 0; i < ydelta; i++) {
-            if (s->y_displayed == y1)
+            if (vt->y_displayed == y1)
                 break;
-            if (--s->y_displayed < 0)
-                s->y_displayed = s->total_height - 1;
+            if (--vt->y_displayed < 0)
+                vt->y_displayed = vt->total_height - 1;
         }
     }
     console_refresh(s);
@@ -306,6 +314,7 @@ static void kbd_send_chars(QemuTextConsole *s)
 /* called when an ascii key is pressed */
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 {
+    QemuVT100 *vt = &s->vt;
     uint8_t buf[16], *q;
     int c;
     uint32_t num_free;
@@ -338,13 +347,13 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
             *q++ = '\033';
             *q++ = '[';
             *q++ = keysym & 0xff;
-        } else if (s->echo && (keysym == '\r' || keysym == '\n')) {
+        } else if (vt->echo && (keysym == '\r' || keysym == '\n')) {
             qemu_chr_write(s->chr, (uint8_t *)"\r", 1, true);
             *q++ = '\n';
         } else {
             *q++ = keysym;
         }
-        if (s->echo) {
+        if (vt->echo) {
             qemu_chr_write(s->chr, buf, q - buf, true);
         }
         num_free = fifo8_num_free(&s->out_fifo);
@@ -357,29 +366,30 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 static void text_console_update(void *opaque, console_ch_t *chardata)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
+    QemuVT100 *vt = &s->vt;
     int i, j, src;
 
-    if (s->text_x[0] <= s->text_x[1]) {
-        src = (s->y_base + s->text_y[0]) * s->width;
-        chardata += s->text_y[0] * s->width;
-        for (i = s->text_y[0]; i <= s->text_y[1]; i ++)
-            for (j = 0; j < s->width; j++, src++) {
+    if (vt->text_x[0] <= vt->text_x[1]) {
+        src = (vt->y_base + vt->text_y[0]) * vt->width;
+        chardata += vt->text_y[0] * vt->width;
+        for (i = vt->text_y[0]; i <= vt->text_y[1]; i ++)
+            for (j = 0; j < vt->width; j++, src++) {
                 console_write_ch(chardata ++,
-                                 ATTR2CHTYPE(s->cells[src].ch,
-                                             s->cells[src].t_attrib.fgcol,
-                                             s->cells[src].t_attrib.bgcol,
-                                             s->cells[src].t_attrib.bold));
+                                 ATTR2CHTYPE(vt->cells[src].ch,
+                                             vt->cells[src].t_attrib.fgcol,
+                                             vt->cells[src].t_attrib.bgcol,
+                                             vt->cells[src].t_attrib.bold));
             }
-        dpy_text_update(QEMU_CONSOLE(s), s->text_x[0], s->text_y[0],
-                        s->text_x[1] - s->text_x[0], i - s->text_y[0]);
-        s->text_x[0] = s->width;
-        s->text_y[0] = s->height;
-        s->text_x[1] = 0;
-        s->text_y[1] = 0;
+        dpy_text_update(QEMU_CONSOLE(s), vt->text_x[0], vt->text_y[0],
+                        vt->text_x[1] - vt->text_x[0], i - vt->text_y[0]);
+        vt->text_x[0] = vt->width;
+        vt->text_y[0] = vt->height;
+        vt->text_x[1] = 0;
+        vt->text_y[1] = 0;
     }
-    if (s->cursor_invalidate) {
-        dpy_text_cursor(QEMU_CONSOLE(s), s->x, s->y);
-        s->cursor_invalidate = 0;
+    if (vt->cursor_invalidate) {
+        dpy_text_cursor(QEMU_CONSOLE(s), vt->x, vt->y);
+        vt->cursor_invalidate = 0;
     }
 }
 
@@ -393,76 +403,77 @@ static void text_console_resize(QemuTextConsole *t)
 
     w = surface_width(s->surface) / FONT_WIDTH;
     h = surface_height(s->surface) / FONT_HEIGHT;
-    if (w == t->width && h == t->height) {
+    if (w == t->vt.width && h == t->vt.height) {
         return;
     }
 
-    last_width = t->width;
-    t->width = w;
-    t->height = h;
+    last_width = t->vt.width;
+    t->vt.width = w;
+    t->vt.height = h;
 
-    w1 = MIN(t->width, last_width);
+    w1 = MIN(t->vt.width, last_width);
 
-    cells = g_new(TextCell, t->width * t->total_height + 1);
-    for (y = 0; y < t->total_height; y++) {
-        c = &cells[y * t->width];
+    cells = g_new(TextCell, t->vt.width * t->vt.total_height + 1);
+    for (y = 0; y < t->vt.total_height; y++) {
+        c = &cells[y * t->vt.width];
         if (w1 > 0) {
-            c1 = &t->cells[y * last_width];
+            c1 = &t->vt.cells[y * last_width];
             for (x = 0; x < w1; x++) {
                 *c++ = *c1++;
             }
         }
-        for (x = w1; x < t->width; x++) {
+        for (x = w1; x < t->vt.width; x++) {
             c->ch = ' ';
             c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             c++;
         }
     }
-    g_free(t->cells);
-    t->cells = cells;
+    g_free(t->vt.cells);
+    t->vt.cells = cells;
 }
 
 static void vc_put_lf(VCChardev *vc)
 {
     QemuTextConsole *s = vc->console;
+    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int x, y1;
 
-    s->y++;
-    if (s->y >= s->height) {
-        s->y = s->height - 1;
+    vt->y++;
+    if (vt->y >= vt->height) {
+        vt->y = vt->height - 1;
 
-        if (s->y_displayed == s->y_base) {
-            if (++s->y_displayed == s->total_height)
-                s->y_displayed = 0;
+        if (vt->y_displayed == vt->y_base) {
+            if (++vt->y_displayed == vt->total_height)
+                vt->y_displayed = 0;
         }
-        if (++s->y_base == s->total_height)
-            s->y_base = 0;
-        if (s->backscroll_height < s->total_height)
-            s->backscroll_height++;
-        y1 = (s->y_base + s->height - 1) % s->total_height;
-        c = &s->cells[y1 * s->width];
-        for(x = 0; x < s->width; x++) {
+        if (++vt->y_base == vt->total_height)
+            vt->y_base = 0;
+        if (vt->backscroll_height < vt->total_height)
+            vt->backscroll_height++;
+        y1 = (vt->y_base + vt->height - 1) % vt->total_height;
+        c = &vt->cells[y1 * vt->width];
+        for(x = 0; x < vt->width; x++) {
             c->ch = ' ';
             c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             c++;
         }
-        if (s->y_displayed == s->y_base) {
-            s->text_x[0] = 0;
-            s->text_y[0] = 0;
-            s->text_x[1] = s->width - 1;
-            s->text_y[1] = s->height - 1;
+        if (vt->y_displayed == vt->y_base) {
+            vt->text_x[0] = 0;
+            vt->text_y[0] = 0;
+            vt->text_x[1] = vt->width - 1;
+            vt->text_y[1] = vt->height - 1;
 
             qemu_console_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
-                                s->width * FONT_WIDTH,
-                                (s->height - 1) * FONT_HEIGHT);
-            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (s->height - 1) * FONT_HEIGHT,
-                                   s->width * FONT_WIDTH, FONT_HEIGHT,
+                                vt->width * FONT_WIDTH,
+                                (vt->height - 1) * FONT_HEIGHT);
+            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (vt->height - 1) * FONT_HEIGHT,
+                                   vt->width * FONT_WIDTH, FONT_HEIGHT,
                                    color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
-            s->update_x0 = 0;
-            s->update_y0 = 0;
-            s->update_x1 = s->width * FONT_WIDTH;
-            s->update_y1 = s->height * FONT_HEIGHT;
+            vt->update_x0 = 0;
+            vt->update_y0 = 0;
+            vt->update_x1 = vt->width * FONT_WIDTH;
+            vt->update_y1 = vt->height * FONT_HEIGHT;
         }
     }
 }
@@ -567,24 +578,25 @@ static void vc_handle_escape(VCChardev *vc)
 static void vc_update_xy(VCChardev *vc, int x, int y)
 {
     QemuTextConsole *s = vc->console;
+    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int y1, y2;
 
-    s->text_x[0] = MIN(s->text_x[0], x);
-    s->text_x[1] = MAX(s->text_x[1], x);
-    s->text_y[0] = MIN(s->text_y[0], y);
-    s->text_y[1] = MAX(s->text_y[1], y);
+    vt->text_x[0] = MIN(vt->text_x[0], x);
+    vt->text_x[1] = MAX(vt->text_x[1], x);
+    vt->text_y[0] = MIN(vt->text_y[0], y);
+    vt->text_y[1] = MAX(vt->text_y[1], y);
 
-    y1 = (s->y_base + y) % s->total_height;
-    y2 = y1 - s->y_displayed;
+    y1 = (vt->y_base + y) % vt->total_height;
+    y2 = y1 - vt->y_displayed;
     if (y2 < 0) {
-        y2 += s->total_height;
+        y2 += vt->total_height;
     }
-    if (y2 < s->height) {
-        if (x >= s->width) {
-            x = s->width - 1;
+    if (y2 < vt->height) {
+        if (x >= vt->width) {
+            x = vt->width - 1;
         }
-        c = &s->cells[y1 * s->width + x];
+        c = &vt->cells[y1 * vt->width + x];
         vga_putcharxy(QEMU_CONSOLE(s), x, y2, c->ch,
                       &(c->t_attrib));
         invalidate_xy(s, x, y2);
@@ -594,11 +606,12 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
 static void vc_clear_xy(VCChardev *vc, int x, int y)
 {
     QemuTextConsole *s = vc->console;
-    int y1 = (s->y_base + y) % s->total_height;
-    if (x >= s->width) {
-        x = s->width - 1;
+    QemuVT100 *vt = &s->vt;
+    int y1 = (vt->y_base + y) % vt->total_height;
+    if (x >= vt->width) {
+        x = vt->width - 1;
     }
-    TextCell *c = &s->cells[y1 * s->width + x];
+    TextCell *c = &vt->cells[y1 * vt->width + x];
     c->ch = ' ';
     c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     vc_update_xy(vc, x, y);
@@ -647,19 +660,20 @@ static uint32_t bh_utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
 static void vc_put_one(VCChardev *vc, int ch)
 {
     QemuTextConsole *s = vc->console;
+    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int y1;
-    if (s->x >= s->width) {
+    if (vt->x >= vt->width) {
         /* line wrap */
-        s->x = 0;
+        vt->x = 0;
         vc_put_lf(vc);
     }
-    y1 = (s->y_base + s->y) % s->total_height;
-    c = &s->cells[y1 * s->width + s->x];
+    y1 = (vt->y_base + vt->y) % vt->total_height;
+    c = &vt->cells[y1 * vt->width + vt->x];
     c->ch = ch;
     c->t_attrib = vc->t_attrib;
-    vc_update_xy(vc, s->x, s->y);
-    s->x++;
+    vc_update_xy(vc, vt->x, vt->y);
+    vt->x++;
 }
 
 static void vc_respond_str(VCChardev *vc, const char *buf)
@@ -673,6 +687,7 @@ static void vc_respond_str(VCChardev *vc, const char *buf)
 static void vc_set_cursor(VCChardev *vc, int x, int y)
 {
     QemuTextConsole *s = vc->console;
+    QemuVT100 *vt = &s->vt;
 
     if (x < 0) {
         x = 0;
@@ -680,15 +695,15 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
     if (y < 0) {
         y = 0;
     }
-    if (y >= s->height) {
-        y = s->height - 1;
+    if (y >= vt->height) {
+        y = vt->height - 1;
     }
-    if (x >= s->width) {
-        x = s->width - 1;
+    if (x >= vt->width) {
+        x = vt->width - 1;
     }
 
-    s->x = x;
-    s->y = y;
+    vt->x = x;
+    vt->y = y;
 }
 
 /**
@@ -700,6 +715,7 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
 static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
 {
     QemuTextConsole *s = vc->console;
+    QemuVT100 *vt = &s->vt;
     TextCell *c1, *c2;
     unsigned int x1, x2, y;
     unsigned int end, len;
@@ -707,28 +723,28 @@ static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
     if (!nr) {
         nr = 1;
     }
-    if (nr > s->width - s->x) {
-        nr = s->width - s->x;
+    if (nr > vt->width - vt->x) {
+        nr = vt->width - vt->x;
         if (!nr) {
             return;
         }
     }
 
-    x1 = s->x;
-    x2 = s->x + nr;
-    len = s->width - x2;
+    x1 = vt->x;
+    x2 = vt->x + nr;
+    len = vt->width - x2;
     if (len) {
-        y = (s->y_base + s->y) % s->total_height;
-        c1 = &s->cells[y * s->width + x1];
-        c2 = &s->cells[y * s->width + x2];
+        y = (vt->y_base + vt->y) % vt->total_height;
+        c1 = &vt->cells[y * vt->width + x1];
+        c2 = &vt->cells[y * vt->width + x2];
         memmove(c1, c2, len * sizeof(*c1));
         for (end = x1 + len; x1 < end; x1++) {
-            vc_update_xy(vc, x1, s->y);
+            vc_update_xy(vc, x1, vt->y);
         }
     }
     /* Clear the rest */
-    for (; x1 < s->width; x1++) {
-        vc_clear_xy(vc, x1, s->y);
+    for (; x1 < vt->width; x1++) {
+        vc_clear_xy(vc, x1, vt->y);
     }
 }
 
@@ -741,6 +757,7 @@ static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
 static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
 {
     QemuTextConsole *s = vc->console;
+    QemuVT100 *vt = &s->vt;
     TextCell *c1, *c2;
     unsigned int x1, x2, y;
     unsigned int end, len;
@@ -748,28 +765,28 @@ static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
     if (!nr) {
         nr = 1;
     }
-    if (nr > s->width - s->x) {
-        nr = s->width - s->x;
+    if (nr > vt->width - vt->x) {
+        nr = vt->width - vt->x;
         if (!nr) {
             return;
         }
     }
 
-    x1 = s->x + nr;
-    x2 = s->x;
-    len = s->width - x1;
+    x1 = vt->x + nr;
+    x2 = vt->x;
+    len = vt->width - x1;
     if (len) {
-        y = (s->y_base + s->y) % s->total_height;
-        c1 = &s->cells[y * s->width + x1];
-        c2 = &s->cells[y * s->width + x2];
+        y = (vt->y_base + vt->y) % vt->total_height;
+        c1 = &vt->cells[y * vt->width + x1];
+        c2 = &vt->cells[y * vt->width + x2];
         memmove(c1, c2, len * sizeof(*c1));
         for (end = x1 + len; x1 < end; x1++) {
-            vc_update_xy(vc, x1, s->y);
+            vc_update_xy(vc, x1, vt->y);
         }
     }
     /* Insert blanks */
-    for (x1 = s->x; x1 < s->x + nr; x1++) {
-        vc_clear_xy(vc, x1, s->y);
+    for (x1 = vt->x; x1 < vt->x + nr; x1++) {
+        vc_clear_xy(vc, x1, vt->y);
     }
 }
 
@@ -779,9 +796,10 @@ static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
 static void vc_save_cursor(VCChardev *vc)
 {
     QemuTextConsole *s = vc->console;
+    QemuVT100 *vt = &s->vt;
 
-    vc->x_saved = s->x;
-    vc->y_saved = s->y;
+    vc->x_saved = vt->x;
+    vc->y_saved = vt->y;
     vc->t_attrib_saved = vc->t_attrib;
 }
 
@@ -792,15 +810,17 @@ static void vc_save_cursor(VCChardev *vc)
 static void vc_restore_cursor(VCChardev *vc)
 {
     QemuTextConsole *s = vc->console;
+    QemuVT100 *vt = &s->vt;
 
-    s->x = vc->x_saved;
-    s->y = vc->y_saved;
+    vt->x = vc->x_saved;
+    vt->y = vc->y_saved;
     vc->t_attrib = vc->t_attrib_saved;
 }
 
 static void vc_putchar(VCChardev *vc, int ch)
 {
     QemuTextConsole *s = vc->console;
+    QemuVT100 *vt = &s->vt;
     int i;
     int x, y;
     g_autofree char *response = NULL;
@@ -827,21 +847,21 @@ static void vc_putchar(VCChardev *vc, int ch)
         vc->utf8_state = BH_UTF8_ACCEPT;
         switch(ch) {
         case '\r':  /* carriage return */
-            s->x = 0;
+            vt->x = 0;
             break;
         case '\n':  /* newline */
             vc_put_lf(vc);
             break;
         case '\b':  /* backspace */
-            if (s->x > 0)
-                s->x--;
+            if (vt->x > 0)
+                vt->x--;
             break;
         case '\t':  /* tabspace */
-            if (s->x + (8 - (s->x % 8)) > s->width) {
-                s->x = 0;
+            if (vt->x + (8 - (vt->x % 8)) > vt->width) {
+                vt->x = 0;
                 vc_put_lf(vc);
             } else {
-                s->x = s->x + (8 - (s->x % 8));
+                vt->x = vt->x + (8 - (vt->x % 8));
             }
             break;
         case '\a':  /* alert aka. bell */
@@ -909,32 +929,32 @@ static void vc_putchar(VCChardev *vc, int ch)
                 if (vc->esc_params[0] == 0) {
                     vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x, s->y - vc->esc_params[0]);
+                vc_set_cursor(vc, vt->x, vt->y - vc->esc_params[0]);
                 break;
             case 'B':
                 /* move cursor down */
                 if (vc->esc_params[0] == 0) {
                     vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x, s->y + vc->esc_params[0]);
+                vc_set_cursor(vc, vt->x, vt->y + vc->esc_params[0]);
                 break;
             case 'C':
                 /* move cursor right */
                 if (vc->esc_params[0] == 0) {
                     vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x + vc->esc_params[0], s->y);
+                vc_set_cursor(vc, vt->x + vc->esc_params[0], vt->y);
                 break;
             case 'D':
                 /* move cursor left */
                 if (vc->esc_params[0] == 0) {
                     vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x - vc->esc_params[0], s->y);
+                vc_set_cursor(vc, vt->x - vc->esc_params[0], vt->y);
                 break;
             case 'G':
                 /* move cursor to column */
-                vc_set_cursor(vc, vc->esc_params[0] - 1, s->y);
+                vc_set_cursor(vc, vc->esc_params[0] - 1, vt->y);
                 break;
             case 'f':
             case 'H':
@@ -945,9 +965,9 @@ static void vc_putchar(VCChardev *vc, int ch)
                 switch (vc->esc_params[0]) {
                 case 0:
                     /* clear to end of screen */
-                    for (y = s->y; y < s->height; y++) {
-                        for (x = 0; x < s->width; x++) {
-                            if (y == s->y && x < s->x) {
+                    for (y = vt->y; y < vt->height; y++) {
+                        for (x = 0; x < vt->width; x++) {
+                            if (y == vt->y && x < vt->x) {
                                 continue;
                             }
                             vc_clear_xy(vc, x, y);
@@ -956,9 +976,9 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 1:
                     /* clear from beginning of screen */
-                    for (y = 0; y <= s->y; y++) {
-                        for (x = 0; x < s->width; x++) {
-                            if (y == s->y && x > s->x) {
+                    for (y = 0; y <= vt->y; y++) {
+                        for (x = 0; x < vt->width; x++) {
+                            if (y == vt->y && x > vt->x) {
                                 break;
                             }
                             vc_clear_xy(vc, x, y);
@@ -967,8 +987,8 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 2:
                     /* clear entire screen */
-                    for (y = 0; y < s->height; y++) {
-                        for (x = 0; x < s->width; x++) {
+                    for (y = 0; y < vt->height; y++) {
+                        for (x = 0; x < vt->width; x++) {
                             vc_clear_xy(vc, x, y);
                         }
                     }
@@ -979,20 +999,20 @@ static void vc_putchar(VCChardev *vc, int ch)
                 switch (vc->esc_params[0]) {
                 case 0:
                     /* clear to eol */
-                    for(x = s->x; x < s->width; x++) {
-                        vc_clear_xy(vc, x, s->y);
+                    for(x = vt->x; x < vt->width; x++) {
+                        vc_clear_xy(vc, x, vt->y);
                     }
                     break;
                 case 1:
                     /* clear from beginning of line */
-                    for (x = 0; x <= s->x && x < s->width; x++) {
-                        vc_clear_xy(vc, x, s->y);
+                    for (x = 0; x <= vt->x && x < vt->width; x++) {
+                        vc_clear_xy(vc, x, vt->y);
                     }
                     break;
                 case 2:
                     /* clear entire line */
-                    for(x = 0; x < s->width; x++) {
-                        vc_clear_xy(vc, x, s->y);
+                    for(x = 0; x < vt->width; x++) {
+                        vc_clear_xy(vc, x, vt->y);
                     }
                     break;
                 }
@@ -1012,7 +1032,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                 case 6:
                     /* report cursor position */
                     response = g_strdup_printf("\033[%d;%dR",
-                                               s->y + 1, s->x + 1);
+                                               vt->y + 1, vt->x + 1);
                     vc_respond_str(vc, response);
                     break;
                 }
@@ -1063,21 +1083,22 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     VCChardev *drv = VC_CHARDEV(chr);
     QemuTextConsole *s = drv->console;
+    QemuVT100 *vt = &s->vt;
     int i;
 
-    s->update_x0 = s->width * FONT_WIDTH;
-    s->update_y0 = s->height * FONT_HEIGHT;
-    s->update_x1 = 0;
-    s->update_y1 = 0;
+    vt->update_x0 = vt->width * FONT_WIDTH;
+    vt->update_y0 = vt->height * FONT_HEIGHT;
+    vt->update_x1 = 0;
+    vt->update_y1 = 0;
     console_show_cursor(s, 0);
     for(i = 0; i < len; i++) {
         vc_putchar(drv, buf[i]);
     }
     console_show_cursor(s, 1);
-    if (s->update_x0 < s->update_x1) {
-        dpy_gfx_update(QEMU_CONSOLE(s), s->update_x0, s->update_y0,
-                       s->update_x1 - s->update_x0,
-                       s->update_y1 - s->update_y0);
+    if (vt->update_x0 < vt->update_x1) {
+        dpy_gfx_update(QEMU_CONSOLE(s), vt->update_x0, vt->update_y0,
+                       vt->update_x1 - vt->update_x0,
+                       vt->update_y1 - vt->update_y0);
     }
     return len;
 }
@@ -1136,7 +1157,7 @@ qemu_text_console_init(Object *obj)
     QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
 
     fifo8_create(&c->out_fifo, 16);
-    c->total_height = DEFAULT_BACKSCROLL;
+    c->vt.total_height = DEFAULT_BACKSCROLL;
     QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
     QEMU_CONSOLE(c)->hw = c;
 }
@@ -1167,12 +1188,12 @@ static void vc_chr_set_echo(Chardev *chr, bool echo)
 {
     VCChardev *drv = VC_CHARDEV(chr);
 
-    drv->console->echo = echo;
+    drv->console->vt.echo = echo;
 }
 
 void qemu_text_console_update_size(QemuTextConsole *c)
 {
-    dpy_text_resize(QEMU_CONSOLE(c), c->width, c->height);
+    dpy_text_resize(QEMU_CONSOLE(c), c->vt.width, c->vt.height);
 }
 
 static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)

-- 
2.53.0


