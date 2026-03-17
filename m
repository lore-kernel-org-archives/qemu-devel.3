Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37DFF3381A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QAQ-0006oJ-0H; Tue, 17 Mar 2026 04:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9t-0006Iv-Fd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9q-000369-3d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mwFqxq0JX7/6dC/VcZ7+FFfCgrd1MnVl6PPRsnkg4w=;
 b=HOERUDGvxVIYD1DWr1g6r4O2t3PhaYxdjS7SEB10QPzxVa90ztGfKMg7otSXvqK/rzM9iD
 Yfrm4iY/kDurwxwceNAOLth0s8/ivjHK5mWTVMSCktmryCzko9jA0a5IuA0LEERs20e/7R
 guPRg0ohH2IRlXFptZVMPQbU8dQwFe4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-d1_VKgmJPcmQu3tu1XEMFQ-1; Tue,
 17 Mar 2026 04:52:07 -0400
X-MC-Unique: d1_VKgmJPcmQu3tu1XEMFQ-1
X-Mimecast-MFC-AGG-ID: d1_VKgmJPcmQu3tu1XEMFQ_1773737526
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60DA9195609E
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:06 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E2E430002DA
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:29 +0400
Subject: [PATCH 15/60] ui/console-vc: introduce QemuVT100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-15-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=26525;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2mywc0fxiG7ETDbxolXVw6dLaR6CMEUA7+x2JF445So=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXaYHkioHPrBq/OdW71ozE8DwewtHngt9hkE
 5uP0rhRYDGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5fY0EACnjASdnCXxH/SCiaGUERJv3REsm4RqJis/rl4S+GkIcVgeL+feW5VYQp0fqi+sZLLIhS/
 QYVs8WrqYvea539YuXHPUVUnSSqeCAiZ/gbsxpf4Bzqblbn2nsXG1oUEw/Ds6BxV/hC6uLhwIkx
 PVQJ9GrMEI40GDJUaL3W+95o0Kb0t0sYiL615DLTTbfJfVLYvSCe9wmntv28pIfoPJGlFCPJrnu
 HaqNK8SCYgSM39vYrJF5k/7dQ9m/MZN5aAF5MBJGyJdu+SQxHvVNSGJIAK8CsN8KK4TtdEfKmyL
 HcPXzBGecoiPGf1YAU2JuIMQSPvtjhAl/p0bK4gosFp70lZ2NXuL7nv7FzauKg+5Q80x/ylDb/7
 vNV7Zty1zLA97H85P2bGS1te7x0sX9N8I9a0tcaj1/DvbElc7Ttg4l80CwSODuW9F+T9NAQc5/F
 fum/A6Nr8tJwffm1SBGgWeC6ufqPVcZJWU6NFgvwpJQr+iwPk/UVZXI8ZNnApKADtPlyUz8Tz97
 lWHD/P5FjP/OfOz17eaBnNI562RUKKJrLUJW+RltpmY9uUm6tI/KZDaBy51lwIaahBM4ZIUZCof
 syCUsjiE01bAR1YiR+3uOQ5/Q51PI6gh6wjo+bjcA6pYV/63uWsXt5R6MxonIwObI+F6/QIkcSs
 6Y2l1J+IbNd/l5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Start moving VT100 emulation specific code in a different structure.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 381 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 192 insertions(+), 189 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index e83a0b04e3f..41436a38eb5 100644
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
+
+typedef struct QemuTextConsole {
+    QemuConsole parent;
 
+    QemuVT100 vt;
     Chardev *chr;
     /* fifo for key pressed */
     Fifo8 out_fifo;
@@ -186,34 +189,34 @@ static void invalidate_xy(QemuTextConsole *s, int x, int y)
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
+    if (s->vt.update_x0 > x * FONT_WIDTH)
+        s->vt.update_x0 = x * FONT_WIDTH;
+    if (s->vt.update_y0 > y * FONT_HEIGHT)
+        s->vt.update_y0 = y * FONT_HEIGHT;
+    if (s->vt.update_x1 < (x + 1) * FONT_WIDTH)
+        s->vt.update_x1 = (x + 1) * FONT_WIDTH;
+    if (s->vt.update_y1 < (y + 1) * FONT_HEIGHT)
+        s->vt.update_y1 = (y + 1) * FONT_HEIGHT;
 }
 
 static void console_show_cursor(QemuTextConsole *s, int show)
 {
     TextCell *c;
     int y, y1;
-    int x = s->x;
+    int x = s->vt.x;
 
-    s->cursor_invalidate = 1;
+    s->vt.cursor_invalidate = 1;
 
-    if (x >= s->width) {
-        x = s->width - 1;
+    if (x >= s->vt.width) {
+        x = s->vt.width - 1;
     }
-    y1 = (s->y_base + s->y) % s->total_height;
-    y = y1 - s->y_displayed;
+    y1 = (s->vt.y_base + s->vt.y) % s->vt.total_height;
+    y = y1 - s->vt.y_displayed;
     if (y < 0) {
-        y += s->total_height;
+        y += s->vt.total_height;
     }
-    if (y < s->height) {
-        c = &s->cells[y1 * s->width + x];
+    if (y < s->vt.height) {
+        c = &s->vt.cells[y1 * s->vt.width + x];
         if (show && cursor_visible_phase) {
             TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
@@ -232,23 +235,23 @@ static void console_refresh(QemuTextConsole *s)
     int x, y, y1;
 
     assert(surface);
-    s->text_x[0] = 0;
-    s->text_y[0] = 0;
-    s->text_x[1] = s->width - 1;
-    s->text_y[1] = s->height - 1;
-    s->cursor_invalidate = 1;
+    s->vt.text_x[0] = 0;
+    s->vt.text_y[0] = 0;
+    s->vt.text_x[1] = s->vt.width - 1;
+    s->vt.text_y[1] = s->vt.height - 1;
+    s->vt.cursor_invalidate = 1;
 
     qemu_console_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
                            color_table_rgb[0][QEMU_COLOR_BLACK]);
-    y1 = s->y_displayed;
-    for (y = 0; y < s->height; y++) {
-        c = s->cells + y1 * s->width;
-        for (x = 0; x < s->width; x++) {
+    y1 = s->vt.y_displayed;
+    for (y = 0; y < s->vt.height; y++) {
+        c = s->vt.cells + y1 * s->vt.width;
+        for (x = 0; x < s->vt.width; x++) {
             vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch,
                           &(c->t_attrib));
             c++;
         }
-        if (++y1 == s->total_height) {
+        if (++y1 == s->vt.total_height) {
             y1 = 0;
         }
     }
@@ -263,24 +266,24 @@ static void console_scroll(QemuTextConsole *s, int ydelta)
 
     if (ydelta > 0) {
         for(i = 0; i < ydelta; i++) {
-            if (s->y_displayed == s->y_base)
+            if (s->vt.y_displayed == s->vt.y_base)
                 break;
-            if (++s->y_displayed == s->total_height)
-                s->y_displayed = 0;
+            if (++s->vt.y_displayed == s->vt.total_height)
+                s->vt.y_displayed = 0;
         }
     } else {
         ydelta = -ydelta;
-        i = s->backscroll_height;
-        if (i > s->total_height - s->height)
-            i = s->total_height - s->height;
-        y1 = s->y_base - i;
+        i = s->vt.backscroll_height;
+        if (i > s->vt.total_height - s->vt.height)
+            i = s->vt.total_height - s->vt.height;
+        y1 = s->vt.y_base - i;
         if (y1 < 0)
-            y1 += s->total_height;
+            y1 += s->vt.total_height;
         for(i = 0; i < ydelta; i++) {
-            if (s->y_displayed == y1)
+            if (s->vt.y_displayed == y1)
                 break;
-            if (--s->y_displayed < 0)
-                s->y_displayed = s->total_height - 1;
+            if (--s->vt.y_displayed < 0)
+                s->vt.y_displayed = s->vt.total_height - 1;
         }
     }
     console_refresh(s);
@@ -338,13 +341,13 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
             *q++ = '\033';
             *q++ = '[';
             *q++ = keysym & 0xff;
-        } else if (s->echo && (keysym == '\r' || keysym == '\n')) {
+        } else if (s->vt.echo && (keysym == '\r' || keysym == '\n')) {
             qemu_chr_write(s->chr, (uint8_t *)"\r", 1, true);
             *q++ = '\n';
         } else {
             *q++ = keysym;
         }
-        if (s->echo) {
+        if (s->vt.echo) {
             qemu_chr_write(s->chr, buf, q - buf, true);
         }
         num_free = fifo8_num_free(&s->out_fifo);
@@ -359,27 +362,27 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
     int i, j, src;
 
-    if (s->text_x[0] <= s->text_x[1]) {
-        src = (s->y_base + s->text_y[0]) * s->width;
-        chardata += s->text_y[0] * s->width;
-        for (i = s->text_y[0]; i <= s->text_y[1]; i ++)
-            for (j = 0; j < s->width; j++, src++) {
+    if (s->vt.text_x[0] <= s->vt.text_x[1]) {
+        src = (s->vt.y_base + s->vt.text_y[0]) * s->vt.width;
+        chardata += s->vt.text_y[0] * s->vt.width;
+        for (i = s->vt.text_y[0]; i <= s->vt.text_y[1]; i ++)
+            for (j = 0; j < s->vt.width; j++, src++) {
                 console_write_ch(chardata ++,
-                                 ATTR2CHTYPE(s->cells[src].ch,
-                                             s->cells[src].t_attrib.fgcol,
-                                             s->cells[src].t_attrib.bgcol,
-                                             s->cells[src].t_attrib.bold));
+                                 ATTR2CHTYPE(s->vt.cells[src].ch,
+                                             s->vt.cells[src].t_attrib.fgcol,
+                                             s->vt.cells[src].t_attrib.bgcol,
+                                             s->vt.cells[src].t_attrib.bold));
             }
-        dpy_text_update(QEMU_CONSOLE(s), s->text_x[0], s->text_y[0],
-                        s->text_x[1] - s->text_x[0], i - s->text_y[0]);
-        s->text_x[0] = s->width;
-        s->text_y[0] = s->height;
-        s->text_x[1] = 0;
-        s->text_y[1] = 0;
+        dpy_text_update(QEMU_CONSOLE(s), s->vt.text_x[0], s->vt.text_y[0],
+                        s->vt.text_x[1] - s->vt.text_x[0], i - s->vt.text_y[0]);
+        s->vt.text_x[0] = s->vt.width;
+        s->vt.text_y[0] = s->vt.height;
+        s->vt.text_x[1] = 0;
+        s->vt.text_y[1] = 0;
     }
-    if (s->cursor_invalidate) {
-        dpy_text_cursor(QEMU_CONSOLE(s), s->x, s->y);
-        s->cursor_invalidate = 0;
+    if (s->vt.cursor_invalidate) {
+        dpy_text_cursor(QEMU_CONSOLE(s), s->vt.x, s->vt.y);
+        s->vt.cursor_invalidate = 0;
     }
 }
 
@@ -393,33 +396,33 @@ static void text_console_resize(QemuTextConsole *t)
 
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
@@ -428,41 +431,41 @@ static void vc_put_lf(VCChardev *vc)
     TextCell *c;
     int x, y1;
 
-    s->y++;
-    if (s->y >= s->height) {
-        s->y = s->height - 1;
+    s->vt.y++;
+    if (s->vt.y >= s->vt.height) {
+        s->vt.y = s->vt.height - 1;
 
-        if (s->y_displayed == s->y_base) {
-            if (++s->y_displayed == s->total_height)
-                s->y_displayed = 0;
+        if (s->vt.y_displayed == s->vt.y_base) {
+            if (++s->vt.y_displayed == s->vt.total_height)
+                s->vt.y_displayed = 0;
         }
-        if (++s->y_base == s->total_height)
-            s->y_base = 0;
-        if (s->backscroll_height < s->total_height)
-            s->backscroll_height++;
-        y1 = (s->y_base + s->height - 1) % s->total_height;
-        c = &s->cells[y1 * s->width];
-        for(x = 0; x < s->width; x++) {
+        if (++s->vt.y_base == s->vt.total_height)
+            s->vt.y_base = 0;
+        if (s->vt.backscroll_height < s->vt.total_height)
+            s->vt.backscroll_height++;
+        y1 = (s->vt.y_base + s->vt.height - 1) % s->vt.total_height;
+        c = &s->vt.cells[y1 * s->vt.width];
+        for(x = 0; x < s->vt.width; x++) {
             c->ch = ' ';
             c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             c++;
         }
-        if (s->y_displayed == s->y_base) {
-            s->text_x[0] = 0;
-            s->text_y[0] = 0;
-            s->text_x[1] = s->width - 1;
-            s->text_y[1] = s->height - 1;
+        if (s->vt.y_displayed == s->vt.y_base) {
+            s->vt.text_x[0] = 0;
+            s->vt.text_y[0] = 0;
+            s->vt.text_x[1] = s->vt.width - 1;
+            s->vt.text_y[1] = s->vt.height - 1;
 
             qemu_console_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
-                                s->width * FONT_WIDTH,
-                                (s->height - 1) * FONT_HEIGHT);
-            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (s->height - 1) * FONT_HEIGHT,
-                                   s->width * FONT_WIDTH, FONT_HEIGHT,
+                                s->vt.width * FONT_WIDTH,
+                                (s->vt.height - 1) * FONT_HEIGHT);
+            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (s->vt.height - 1) * FONT_HEIGHT,
+                                   s->vt.width * FONT_WIDTH, FONT_HEIGHT,
                                    color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
-            s->update_x0 = 0;
-            s->update_y0 = 0;
-            s->update_x1 = s->width * FONT_WIDTH;
-            s->update_y1 = s->height * FONT_HEIGHT;
+            s->vt.update_x0 = 0;
+            s->vt.update_y0 = 0;
+            s->vt.update_x1 = s->vt.width * FONT_WIDTH;
+            s->vt.update_y1 = s->vt.height * FONT_HEIGHT;
         }
     }
 }
@@ -570,21 +573,21 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
     TextCell *c;
     int y1, y2;
 
-    s->text_x[0] = MIN(s->text_x[0], x);
-    s->text_x[1] = MAX(s->text_x[1], x);
-    s->text_y[0] = MIN(s->text_y[0], y);
-    s->text_y[1] = MAX(s->text_y[1], y);
+    s->vt.text_x[0] = MIN(s->vt.text_x[0], x);
+    s->vt.text_x[1] = MAX(s->vt.text_x[1], x);
+    s->vt.text_y[0] = MIN(s->vt.text_y[0], y);
+    s->vt.text_y[1] = MAX(s->vt.text_y[1], y);
 
-    y1 = (s->y_base + y) % s->total_height;
-    y2 = y1 - s->y_displayed;
+    y1 = (s->vt.y_base + y) % s->vt.total_height;
+    y2 = y1 - s->vt.y_displayed;
     if (y2 < 0) {
-        y2 += s->total_height;
+        y2 += s->vt.total_height;
     }
-    if (y2 < s->height) {
-        if (x >= s->width) {
-            x = s->width - 1;
+    if (y2 < s->vt.height) {
+        if (x >= s->vt.width) {
+            x = s->vt.width - 1;
         }
-        c = &s->cells[y1 * s->width + x];
+        c = &s->vt.cells[y1 * s->vt.width + x];
         vga_putcharxy(QEMU_CONSOLE(s), x, y2, c->ch,
                       &(c->t_attrib));
         invalidate_xy(s, x, y2);
@@ -594,11 +597,11 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
 static void vc_clear_xy(VCChardev *vc, int x, int y)
 {
     QemuTextConsole *s = vc->console;
-    int y1 = (s->y_base + y) % s->total_height;
-    if (x >= s->width) {
-        x = s->width - 1;
+    int y1 = (s->vt.y_base + y) % s->vt.total_height;
+    if (x >= s->vt.width) {
+        x = s->vt.width - 1;
     }
-    TextCell *c = &s->cells[y1 * s->width + x];
+    TextCell *c = &s->vt.cells[y1 * s->vt.width + x];
     c->ch = ' ';
     c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     vc_update_xy(vc, x, y);
@@ -650,17 +653,17 @@ static void vc_put_one(VCChardev *vc, int ch)
     QemuTextConsole *s = vc->console;
     TextCell *c;
     int y1;
-    if (s->x >= s->width) {
+    if (s->vt.x >= s->vt.width) {
         /* line wrap */
-        s->x = 0;
+        s->vt.x = 0;
         vc_put_lf(vc);
     }
-    y1 = (s->y_base + s->y) % s->total_height;
-    c = &s->cells[y1 * s->width + s->x];
+    y1 = (s->vt.y_base + s->vt.y) % s->vt.total_height;
+    c = &s->vt.cells[y1 * s->vt.width + s->vt.x];
     c->ch = ch;
     c->t_attrib = vc->t_attrib;
-    vc_update_xy(vc, s->x, s->y);
-    s->x++;
+    vc_update_xy(vc, s->vt.x, s->vt.y);
+    s->vt.x++;
 }
 
 static void vc_respond_str(VCChardev *vc, const char *buf)
@@ -681,15 +684,15 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
     if (y < 0) {
         y = 0;
     }
-    if (y >= s->height) {
-        y = s->height - 1;
+    if (y >= s->vt.height) {
+        y = s->vt.height - 1;
     }
-    if (x >= s->width) {
-        x = s->width - 1;
+    if (x >= s->vt.width) {
+        x = s->vt.width - 1;
     }
 
-    s->x = x;
-    s->y = y;
+    s->vt.x = x;
+    s->vt.y = y;
 }
 
 /**
@@ -708,28 +711,28 @@ static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
     if (!nr) {
         nr = 1;
     }
-    if (nr > s->width - s->x) {
-        nr = s->width - s->x;
+    if (nr > s->vt.width - s->vt.x) {
+        nr = s->vt.width - s->vt.x;
         if (!nr) {
             return;
         }
     }
 
-    x1 = s->x;
-    x2 = s->x + nr;
-    len = s->width - x2;
+    x1 = s->vt.x;
+    x2 = s->vt.x + nr;
+    len = s->vt.width - x2;
     if (len) {
-        y = (s->y_base + s->y) % s->total_height;
-        c1 = &s->cells[y * s->width + x1];
-        c2 = &s->cells[y * s->width + x2];
+        y = (s->vt.y_base + s->vt.y) % s->vt.total_height;
+        c1 = &s->vt.cells[y * s->vt.width + x1];
+        c2 = &s->vt.cells[y * s->vt.width + x2];
         memmove(c1, c2, len * sizeof(*c1));
         for (end = x1 + len; x1 < end; x1++) {
-            vc_update_xy(vc, x1, s->y);
+            vc_update_xy(vc, x1, s->vt.y);
         }
     }
     /* Clear the rest */
-    for (; x1 < s->width; x1++) {
-        vc_clear_xy(vc, x1, s->y);
+    for (; x1 < s->vt.width; x1++) {
+        vc_clear_xy(vc, x1, s->vt.y);
     }
 }
 
@@ -749,28 +752,28 @@ static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
     if (!nr) {
         nr = 1;
     }
-    if (nr > s->width - s->x) {
-        nr = s->width - s->x;
+    if (nr > s->vt.width - s->vt.x) {
+        nr = s->vt.width - s->vt.x;
         if (!nr) {
             return;
         }
     }
 
-    x1 = s->x + nr;
-    x2 = s->x;
-    len = s->width - x1;
+    x1 = s->vt.x + nr;
+    x2 = s->vt.x;
+    len = s->vt.width - x1;
     if (len) {
-        y = (s->y_base + s->y) % s->total_height;
-        c1 = &s->cells[y * s->width + x1];
-        c2 = &s->cells[y * s->width + x2];
+        y = (s->vt.y_base + s->vt.y) % s->vt.total_height;
+        c1 = &s->vt.cells[y * s->vt.width + x1];
+        c2 = &s->vt.cells[y * s->vt.width + x2];
         memmove(c1, c2, len * sizeof(*c1));
         for (end = x1 + len; x1 < end; x1++) {
-            vc_update_xy(vc, x1, s->y);
+            vc_update_xy(vc, x1, s->vt.y);
         }
     }
     /* Insert blanks */
-    for (x1 = s->x; x1 < s->x + nr; x1++) {
-        vc_clear_xy(vc, x1, s->y);
+    for (x1 = s->vt.x; x1 < s->vt.x + nr; x1++) {
+        vc_clear_xy(vc, x1, s->vt.y);
     }
 }
 
@@ -781,8 +784,8 @@ static void vc_save_cursor(VCChardev *vc)
 {
     QemuTextConsole *s = vc->console;
 
-    vc->x_saved = s->x;
-    vc->y_saved = s->y;
+    vc->x_saved = s->vt.x;
+    vc->y_saved = s->vt.y;
     vc->t_attrib_saved = vc->t_attrib;
 }
 
@@ -794,8 +797,8 @@ static void vc_restore_cursor(VCChardev *vc)
 {
     QemuTextConsole *s = vc->console;
 
-    s->x = vc->x_saved;
-    s->y = vc->y_saved;
+    s->vt.x = vc->x_saved;
+    s->vt.y = vc->y_saved;
     vc->t_attrib = vc->t_attrib_saved;
 }
 
@@ -828,21 +831,21 @@ static void vc_putchar(VCChardev *vc, int ch)
         vc->utf8_state = UTF8_ACCEPT;
         switch(ch) {
         case '\r':  /* carriage return */
-            s->x = 0;
+            s->vt.x = 0;
             break;
         case '\n':  /* newline */
             vc_put_lf(vc);
             break;
         case '\b':  /* backspace */
-            if (s->x > 0)
-                s->x--;
+            if (s->vt.x > 0)
+                s->vt.x--;
             break;
         case '\t':  /* tabspace */
-            if (s->x + (8 - (s->x % 8)) > s->width) {
-                s->x = 0;
+            if (s->vt.x + (8 - (s->vt.x % 8)) > s->vt.width) {
+                s->vt.x = 0;
                 vc_put_lf(vc);
             } else {
-                s->x = s->x + (8 - (s->x % 8));
+                s->vt.x = s->vt.x + (8 - (s->vt.x % 8));
             }
             break;
         case '\a':  /* alert aka. bell */
@@ -910,32 +913,32 @@ static void vc_putchar(VCChardev *vc, int ch)
                 if (vc->esc_params[0] == 0) {
                     vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x, s->y - vc->esc_params[0]);
+                vc_set_cursor(vc, s->vt.x, s->vt.y - vc->esc_params[0]);
                 break;
             case 'B':
                 /* move cursor down */
                 if (vc->esc_params[0] == 0) {
                     vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x, s->y + vc->esc_params[0]);
+                vc_set_cursor(vc, s->vt.x, s->vt.y + vc->esc_params[0]);
                 break;
             case 'C':
                 /* move cursor right */
                 if (vc->esc_params[0] == 0) {
                     vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x + vc->esc_params[0], s->y);
+                vc_set_cursor(vc, s->vt.x + vc->esc_params[0], s->vt.y);
                 break;
             case 'D':
                 /* move cursor left */
                 if (vc->esc_params[0] == 0) {
                     vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x - vc->esc_params[0], s->y);
+                vc_set_cursor(vc, s->vt.x - vc->esc_params[0], s->vt.y);
                 break;
             case 'G':
                 /* move cursor to column */
-                vc_set_cursor(vc, vc->esc_params[0] - 1, s->y);
+                vc_set_cursor(vc, vc->esc_params[0] - 1, s->vt.y);
                 break;
             case 'f':
             case 'H':
@@ -946,9 +949,9 @@ static void vc_putchar(VCChardev *vc, int ch)
                 switch (vc->esc_params[0]) {
                 case 0:
                     /* clear to end of screen */
-                    for (y = s->y; y < s->height; y++) {
-                        for (x = 0; x < s->width; x++) {
-                            if (y == s->y && x < s->x) {
+                    for (y = s->vt.y; y < s->vt.height; y++) {
+                        for (x = 0; x < s->vt.width; x++) {
+                            if (y == s->vt.y && x < s->vt.x) {
                                 continue;
                             }
                             vc_clear_xy(vc, x, y);
@@ -957,9 +960,9 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 1:
                     /* clear from beginning of screen */
-                    for (y = 0; y <= s->y; y++) {
-                        for (x = 0; x < s->width; x++) {
-                            if (y == s->y && x > s->x) {
+                    for (y = 0; y <= s->vt.y; y++) {
+                        for (x = 0; x < s->vt.width; x++) {
+                            if (y == s->vt.y && x > s->vt.x) {
                                 break;
                             }
                             vc_clear_xy(vc, x, y);
@@ -968,8 +971,8 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 2:
                     /* clear entire screen */
-                    for (y = 0; y < s->height; y++) {
-                        for (x = 0; x < s->width; x++) {
+                    for (y = 0; y < s->vt.height; y++) {
+                        for (x = 0; x < s->vt.width; x++) {
                             vc_clear_xy(vc, x, y);
                         }
                     }
@@ -980,20 +983,20 @@ static void vc_putchar(VCChardev *vc, int ch)
                 switch (vc->esc_params[0]) {
                 case 0:
                     /* clear to eol */
-                    for(x = s->x; x < s->width; x++) {
-                        vc_clear_xy(vc, x, s->y);
+                    for(x = s->vt.x; x < s->vt.width; x++) {
+                        vc_clear_xy(vc, x, s->vt.y);
                     }
                     break;
                 case 1:
                     /* clear from beginning of line */
-                    for (x = 0; x <= s->x && x < s->width; x++) {
-                        vc_clear_xy(vc, x, s->y);
+                    for (x = 0; x <= s->vt.x && x < s->vt.width; x++) {
+                        vc_clear_xy(vc, x, s->vt.y);
                     }
                     break;
                 case 2:
                     /* clear entire line */
-                    for(x = 0; x < s->width; x++) {
-                        vc_clear_xy(vc, x, s->y);
+                    for(x = 0; x < s->vt.width; x++) {
+                        vc_clear_xy(vc, x, s->vt.y);
                     }
                     break;
                 }
@@ -1013,7 +1016,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                 case 6:
                     /* report cursor position */
                     response = g_strdup_printf("\033[%d;%dR",
-                                               s->y + 1, s->x + 1);
+                                               s->vt.y + 1, s->vt.x + 1);
                     vc_respond_str(vc, response);
                     break;
                 }
@@ -1066,19 +1069,19 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     QemuTextConsole *s = drv->console;
     int i;
 
-    s->update_x0 = s->width * FONT_WIDTH;
-    s->update_y0 = s->height * FONT_HEIGHT;
-    s->update_x1 = 0;
-    s->update_y1 = 0;
+    s->vt.update_x0 = s->vt.width * FONT_WIDTH;
+    s->vt.update_y0 = s->vt.height * FONT_HEIGHT;
+    s->vt.update_x1 = 0;
+    s->vt.update_y1 = 0;
     console_show_cursor(s, 0);
     for(i = 0; i < len; i++) {
         vc_putchar(drv, buf[i]);
     }
     console_show_cursor(s, 1);
-    if (s->update_x0 < s->update_x1) {
-        dpy_gfx_update(QEMU_CONSOLE(s), s->update_x0, s->update_y0,
-                       s->update_x1 - s->update_x0,
-                       s->update_y1 - s->update_y0);
+    if (s->vt.update_x0 < s->vt.update_x1) {
+        dpy_gfx_update(QEMU_CONSOLE(s), s->vt.update_x0, s->vt.update_y0,
+                       s->vt.update_x1 - s->vt.update_x0,
+                       s->vt.update_y1 - s->vt.update_y0);
     }
     return len;
 }
@@ -1137,7 +1140,7 @@ qemu_text_console_init(Object *obj)
     QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
 
     fifo8_create(&c->out_fifo, 16);
-    c->total_height = DEFAULT_BACKSCROLL;
+    c->vt.total_height = DEFAULT_BACKSCROLL;
     QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
     QEMU_CONSOLE(c)->hw = c;
 }
@@ -1168,12 +1171,12 @@ static void vc_chr_set_echo(Chardev *chr, bool echo)
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


