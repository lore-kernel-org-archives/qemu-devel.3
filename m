Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE1ECD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlHM-00045L-Kd; Sat, 09 May 2026 13:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlH3-0003Zh-UP
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlH0-00055Y-MP
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778346930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIN3fH5K8YG/CeuEI18lPsKtXONRV8pHsPAR4kROB4M=;
 b=fmT1DFfNCpy1RJxixAZdXZjfA4A7CF7m9tfQgSbVconVgS34K29slQgAxlPlAMmLwEuDm9
 yf9Zwal6+JWorqtMNz/zYqgemEwAPQdlb7TVYvpqabaHPNYceDr7FlbizWSBXSIabIds/H
 Uy9Yl/AwNx92lIfSLZHNnVy9kZ2LS3s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-hpO3y5U1PcmflKpKY2x72Q-1; Sat,
 09 May 2026 13:15:26 -0400
X-MC-Unique: hpO3y5U1PcmflKpKY2x72Q-1
X-Mimecast-MFC-AGG-ID: hpO3y5U1PcmflKpKY2x72Q_1778346925
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFCF218005BA; Sat,  9 May 2026 17:15:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEF0E1800240; Sat,  9 May 2026 17:15:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 14/33] ui/console-vc: move VT100 state machine and output
 FIFO into QemuVT100
Date: Sat,  9 May 2026 21:13:35 +0400
Message-ID: <20260509171356.1157879-15-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Move the terminal escape sequence parser state (TTYState, esc_params,
text attributes, saved cursor position) and the output FIFO from
VCChardev/QemuTextConsole into QemuVT100. Rename the corresponding
functions from vc_* to vt100_* to reflect they now operate on the VT100
layer directly, removing the indirection through vc->console->vt.

Add an out_flush callback to QemuVT100 so vt100_write() can flush
output without knowing about QemuTextConsole, and move FIFO/VT100
initialization from qemu_text_console_init() to vc_chr_open() where
the callback can be wired up.

This continues the decoupling of VT100 terminal emulation from the
chardev layer, making QemuVT100 a self-contained terminal emulator.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/console-vc.c | 382 +++++++++++++++++++++++-------------------------
 1 file changed, 184 insertions(+), 198 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 42d642afebb..cf1adfc3c71 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -58,6 +58,7 @@ struct QemuVT100 {
     pixman_image_t *image;
     void (*image_update)(QemuVT100 *vt, int x, int y, int width, int height);
 
+    ChardevVCEncoding encoding;
     int width;
     int height;
     int total_height;
@@ -74,6 +75,18 @@ struct QemuVT100 {
     int update_x1;
     int update_y1;
 
+    enum TTYState state;
+    int esc_params[MAX_ESC_PARAMS];
+    int nb_esc_params;
+    uint32_t utf8_state;     /* UTF-8 DFA decoder state */
+    uint32_t utf8_codepoint; /* accumulated UTF-8 code point */
+    TextAttributes t_attrib; /* currently active text attributes */
+    TextAttributes t_attrib_saved;
+    int x_saved, y_saved;
+    /* fifo for key pressed */
+    Fifo8 out_fifo;
+    void (*out_flush)(QemuVT100 *vt);
+
     QTAILQ_ENTRY(QemuVT100) list;
 };
 
@@ -85,8 +98,6 @@ typedef struct QemuTextConsole {
 
     QemuVT100 vt;
     Chardev *chr;
-    /* fifo for key pressed */
-    Fifo8 out_fifo;
 } QemuTextConsole;
 
 typedef QemuConsoleClass QemuTextConsoleClass;
@@ -103,17 +114,9 @@ OBJECT_DEFINE_TYPE(QemuFixedTextConsole, qemu_fixed_text_console, QEMU_FIXED_TEX
 
 struct VCChardev {
     Chardev parent;
-    QemuTextConsole *console;
 
-    enum TTYState state;
-    int esc_params[MAX_ESC_PARAMS];
-    int nb_esc_params;
-    uint32_t utf8_state;     /* UTF-8 DFA decoder state */
-    uint32_t utf8_codepoint; /* accumulated UTF-8 code point */
-    TextAttributes t_attrib; /* currently active text attributes */
-    TextAttributes t_attrib_saved;
-    int x_saved, y_saved;
     ChardevVCEncoding encoding;
+    QemuTextConsole *console;
 };
 typedef struct VCChardev VCChardev;
 
@@ -302,36 +305,35 @@ static void vt100_scroll(QemuVT100 *vt, int ydelta)
     vt100_refresh(vt);
 }
 
-static void qemu_text_console_flush(QemuTextConsole *s)
+static void qemu_text_console_out_flush(QemuTextConsole *s)
 {
     uint32_t len, avail;
 
     len = qemu_chr_be_can_write(s->chr);
-    avail = fifo8_num_used(&s->out_fifo);
+    avail = fifo8_num_used(&s->vt.out_fifo);
     while (len > 0 && avail > 0) {
         const uint8_t *buf;
         uint32_t size;
 
-        buf = fifo8_pop_bufptr(&s->out_fifo, MIN(len, avail), &size);
+        buf = fifo8_pop_bufptr(&s->vt.out_fifo, MIN(len, avail), &size);
         qemu_chr_be_write(s->chr, buf, size);
         len = qemu_chr_be_can_write(s->chr);
         avail -= size;
     }
 }
 
-static void qemu_text_console_write(QemuTextConsole *s, const void *buf, size_t len)
+static void vt100_write(QemuVT100 *vt, const void *buf, size_t len)
 {
     uint32_t num_free;
 
-    num_free = fifo8_num_free(&s->out_fifo);
-    fifo8_push_all(&s->out_fifo, buf, MIN(num_free, len));
-    qemu_text_console_flush(s);
+    num_free = fifo8_num_free(&vt->out_fifo);
+    fifo8_push_all(&vt->out_fifo, buf, MIN(num_free, len));
+    vt->out_flush(vt);
 }
 
 /* called when an ascii key is pressed */
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 {
-    QemuVT100 *vt = &s->vt;
     uint8_t buf[16], *q;
     int c;
 
@@ -363,16 +365,16 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
             *q++ = '\033';
             *q++ = '[';
             *q++ = keysym & 0xff;
-        } else if (vt->echo && (keysym == '\r' || keysym == '\n')) {
+        } else if (s->vt.echo && (keysym == '\r' || keysym == '\n')) {
             qemu_chr_write(s->chr, (uint8_t *)"\r", 1, true);
             *q++ = '\n';
         } else {
             *q++ = keysym;
         }
-        if (vt->echo) {
+        if (s->vt.echo) {
             qemu_chr_write(s->chr, buf, q - buf, true);
         }
-        qemu_text_console_write(s, buf, q - buf);
+        vt100_write(&s->vt, buf, q - buf);
         break;
     }
 }
@@ -380,30 +382,29 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 static void text_console_update(void *opaque, console_ch_t *chardata)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
-    QemuVT100 *vt = &s->vt;
     int i, j, src;
 
-    if (vt->text_x[0] <= vt->text_x[1]) {
-        src = (vt->y_base + vt->text_y[0]) * vt->width;
-        chardata += vt->text_y[0] * vt->width;
-        for (i = vt->text_y[0]; i <= vt->text_y[1]; i ++)
-            for (j = 0; j < vt->width; j++, src++) {
+    if (s->vt.text_x[0] <= s->vt.text_x[1]) {
+        src = (s->vt.y_base + s->vt.text_y[0]) * s->vt.width;
+        chardata += s->vt.text_y[0] * s->vt.width;
+        for (i = s->vt.text_y[0]; i <= s->vt.text_y[1]; i ++)
+            for (j = 0; j < s->vt.width; j++, src++) {
                 console_write_ch(chardata ++,
-                                 ATTR2CHTYPE(vt->cells[src].ch,
-                                             vt->cells[src].t_attrib.fgcol,
-                                             vt->cells[src].t_attrib.bgcol,
-                                             vt->cells[src].t_attrib.bold));
+                                 ATTR2CHTYPE(s->vt.cells[src].ch,
+                                             s->vt.cells[src].t_attrib.fgcol,
+                                             s->vt.cells[src].t_attrib.bgcol,
+                                             s->vt.cells[src].t_attrib.bold));
             }
-        dpy_text_update(QEMU_CONSOLE(s), vt->text_x[0], vt->text_y[0],
-                        vt->text_x[1] - vt->text_x[0], i - vt->text_y[0]);
-        vt->text_x[0] = vt->width;
-        vt->text_y[0] = vt->height;
-        vt->text_x[1] = 0;
-        vt->text_y[1] = 0;
+        dpy_text_update(QEMU_CONSOLE(s), s->vt.text_x[0], s->vt.text_y[0],
+                        s->vt.text_x[1] - s->vt.text_x[0], i - s->vt.text_y[0]);
+        s->vt.text_x[0] = s->vt.width;
+        s->vt.text_y[0] = s->vt.height;
+        s->vt.text_x[1] = 0;
+        s->vt.text_y[1] = 0;
     }
-    if (vt->cursor_invalidate) {
-        dpy_text_cursor(QEMU_CONSOLE(s), vt->x, vt->y);
-        vt->cursor_invalidate = 0;
+    if (s->vt.cursor_invalidate) {
+        dpy_text_cursor(QEMU_CONSOLE(s), s->vt.x, s->vt.y);
+        s->vt.cursor_invalidate = 0;
     }
 }
 
@@ -492,103 +493,101 @@ static void vt100_put_lf(QemuVT100 *vt)
  * NOTE: I know this code is not very efficient (checking every color for it
  * self) but it is more readable and better maintainable.
  */
-static void vc_handle_escape(VCChardev *vc)
+static void vt100_handle_escape(QemuVT100 *vt)
 {
     int i;
 
-    for (i = 0; i < vc->nb_esc_params; i++) {
-        switch (vc->esc_params[i]) {
+    for (i = 0; i < vt->nb_esc_params; i++) {
+        switch (vt->esc_params[i]) {
             case 0: /* reset all console attributes to default */
-                vc->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+                vt->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
                 break;
             case 1:
-                vc->t_attrib.bold = 1;
+                vt->t_attrib.bold = 1;
                 break;
             case 4:
-                vc->t_attrib.uline = 1;
+                vt->t_attrib.uline = 1;
                 break;
             case 5:
-                vc->t_attrib.blink = 1;
+                vt->t_attrib.blink = 1;
                 break;
             case 7:
-                vc->t_attrib.invers = 1;
+                vt->t_attrib.invers = 1;
                 break;
             case 8:
-                vc->t_attrib.unvisible = 1;
+                vt->t_attrib.unvisible = 1;
                 break;
             case 22:
-                vc->t_attrib.bold = 0;
+                vt->t_attrib.bold = 0;
                 break;
             case 24:
-                vc->t_attrib.uline = 0;
+                vt->t_attrib.uline = 0;
                 break;
             case 25:
-                vc->t_attrib.blink = 0;
+                vt->t_attrib.blink = 0;
                 break;
             case 27:
-                vc->t_attrib.invers = 0;
+                vt->t_attrib.invers = 0;
                 break;
             case 28:
-                vc->t_attrib.unvisible = 0;
+                vt->t_attrib.unvisible = 0;
                 break;
             /* set foreground color */
             case 30:
-                vc->t_attrib.fgcol = QEMU_COLOR_BLACK;
+                vt->t_attrib.fgcol = QEMU_COLOR_BLACK;
                 break;
             case 31:
-                vc->t_attrib.fgcol = QEMU_COLOR_RED;
+                vt->t_attrib.fgcol = QEMU_COLOR_RED;
                 break;
             case 32:
-                vc->t_attrib.fgcol = QEMU_COLOR_GREEN;
+                vt->t_attrib.fgcol = QEMU_COLOR_GREEN;
                 break;
             case 33:
-                vc->t_attrib.fgcol = QEMU_COLOR_YELLOW;
+                vt->t_attrib.fgcol = QEMU_COLOR_YELLOW;
                 break;
             case 34:
-                vc->t_attrib.fgcol = QEMU_COLOR_BLUE;
+                vt->t_attrib.fgcol = QEMU_COLOR_BLUE;
                 break;
             case 35:
-                vc->t_attrib.fgcol = QEMU_COLOR_MAGENTA;
+                vt->t_attrib.fgcol = QEMU_COLOR_MAGENTA;
                 break;
             case 36:
-                vc->t_attrib.fgcol = QEMU_COLOR_CYAN;
+                vt->t_attrib.fgcol = QEMU_COLOR_CYAN;
                 break;
             case 37:
-                vc->t_attrib.fgcol = QEMU_COLOR_WHITE;
+                vt->t_attrib.fgcol = QEMU_COLOR_WHITE;
                 break;
             /* set background color */
             case 40:
-                vc->t_attrib.bgcol = QEMU_COLOR_BLACK;
+                vt->t_attrib.bgcol = QEMU_COLOR_BLACK;
                 break;
             case 41:
-                vc->t_attrib.bgcol = QEMU_COLOR_RED;
+                vt->t_attrib.bgcol = QEMU_COLOR_RED;
                 break;
             case 42:
-                vc->t_attrib.bgcol = QEMU_COLOR_GREEN;
+                vt->t_attrib.bgcol = QEMU_COLOR_GREEN;
                 break;
             case 43:
-                vc->t_attrib.bgcol = QEMU_COLOR_YELLOW;
+                vt->t_attrib.bgcol = QEMU_COLOR_YELLOW;
                 break;
             case 44:
-                vc->t_attrib.bgcol = QEMU_COLOR_BLUE;
+                vt->t_attrib.bgcol = QEMU_COLOR_BLUE;
                 break;
             case 45:
-                vc->t_attrib.bgcol = QEMU_COLOR_MAGENTA;
+                vt->t_attrib.bgcol = QEMU_COLOR_MAGENTA;
                 break;
             case 46:
-                vc->t_attrib.bgcol = QEMU_COLOR_CYAN;
+                vt->t_attrib.bgcol = QEMU_COLOR_CYAN;
                 break;
             case 47:
-                vc->t_attrib.bgcol = QEMU_COLOR_WHITE;
+                vt->t_attrib.bgcol = QEMU_COLOR_WHITE;
                 break;
         }
     }
 }
 
-static void vc_update_xy(VCChardev *vc, int x, int y)
+static void vt100_update_xy(QemuVT100 *vt, int x, int y)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int y1, y2;
 
@@ -609,14 +608,12 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
         c = &vt->cells[y1 * vt->width + x];
         vt100_putcharxy(vt, x, y2, c->ch,
                       &(c->t_attrib));
-        vt100_invalidate_xy(&s->vt, x, y2);
+        vt100_invalidate_xy(vt, x, y2);
     }
 }
 
-static void vc_clear_xy(VCChardev *vc, int x, int y)
+static void vt100_clear_xy(QemuVT100 *vt, int x, int y)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
     int y1 = (vt->y_base + y) % vt->total_height;
     if (x >= vt->width) {
         x = vt->width - 1;
@@ -624,7 +621,7 @@ static void vc_clear_xy(VCChardev *vc, int x, int y)
     TextCell *c = &vt->cells[y1 * vt->width + x];
     c->ch = ' ';
     c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    vc_update_xy(vc, x, y);
+    vt100_update_xy(vt, x, y);
 }
 
 /*
@@ -667,10 +664,8 @@ static uint32_t bh_utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
     return *state;
 }
 
-static void vc_put_one(VCChardev *vc, int ch)
+static void vt100_put_one(QemuVT100 *vt, int ch)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int y1;
     if (vt->x >= vt->width) {
@@ -681,17 +676,14 @@ static void vc_put_one(VCChardev *vc, int ch)
     y1 = (vt->y_base + vt->y) % vt->total_height;
     c = &vt->cells[y1 * vt->width + vt->x];
     c->ch = ch;
-    c->t_attrib = vc->t_attrib;
-    vc_update_xy(vc, vt->x, vt->y);
+    c->t_attrib = vt->t_attrib;
+    vt100_update_xy(vt, vt->x, vt->y);
     vt->x++;
 }
 
 /* set cursor, checking bounds */
-static void vc_set_cursor(VCChardev *vc, int x, int y)
+static void vt100_set_cursor(QemuVT100 *vt, int x, int y)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
-
     if (x < 0) {
         x = 0;
     }
@@ -715,10 +707,8 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
  * characters between the cursor and right margin move to the
  * left. Character attributes move with the characters.
  */
-static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
+static void vt100_csi_P(QemuVT100 *vt, unsigned int nr)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
     TextCell *c1, *c2;
     unsigned int x1, x2, y;
     unsigned int end, len;
@@ -742,12 +732,12 @@ static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
         c2 = &vt->cells[y * vt->width + x2];
         memmove(c1, c2, len * sizeof(*c1));
         for (end = x1 + len; x1 < end; x1++) {
-            vc_update_xy(vc, x1, vt->y);
+            vt100_update_xy(vt, x1, vt->y);
         }
     }
     /* Clear the rest */
     for (; x1 < vt->width; x1++) {
-        vc_clear_xy(vc, x1, vt->y);
+        vt100_clear_xy(vt, x1, vt->y);
     }
 }
 
@@ -757,10 +747,8 @@ static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
  * blank characters. Text between the cursor and right margin moves to
  * the right. Characters scrolled past the right margin are lost.
  */
-static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
+static void vt100_csi_at(QemuVT100 *vt, unsigned int nr)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
     TextCell *c1, *c2;
     unsigned int x1, x2, y;
     unsigned int end, len;
@@ -784,59 +772,51 @@ static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
         c2 = &vt->cells[y * vt->width + x2];
         memmove(c1, c2, len * sizeof(*c1));
         for (end = x1 + len; x1 < end; x1++) {
-            vc_update_xy(vc, x1, vt->y);
+            vt100_update_xy(vt, x1, vt->y);
         }
     }
     /* Insert blanks */
     for (x1 = vt->x; x1 < vt->x + nr; x1++) {
-        vc_clear_xy(vc, x1, vt->y);
+        vt100_clear_xy(vt, x1, vt->y);
     }
 }
 
 /**
- * vc_save_cursor() - saves cursor position and character attributes.
+ * vt100_save_cursor() - saves cursor position and character attributes.
  */
-static void vc_save_cursor(VCChardev *vc)
+static void vt100_save_cursor(QemuVT100 *vt)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
-
-    vc->x_saved = vt->x;
-    vc->y_saved = vt->y;
-    vc->t_attrib_saved = vc->t_attrib;
+    vt->x_saved = vt->x;
+    vt->y_saved = vt->y;
+    vt->t_attrib_saved = vt->t_attrib;
 }
 
 /**
- * vc_restore_cursor() - restores cursor position and character
+ * vt100_restore_cursor() - restores cursor position and character
  * attributes from saved state.
  */
-static void vc_restore_cursor(VCChardev *vc)
+static void vt100_restore_cursor(QemuVT100 *vt)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
-
-    vt->x = vc->x_saved;
-    vt->y = vc->y_saved;
-    vc->t_attrib = vc->t_attrib_saved;
+    vt->x = vt->x_saved;
+    vt->y = vt->y_saved;
+    vt->t_attrib = vt->t_attrib_saved;
 }
 
-static void vc_putchar(VCChardev *vc, int ch)
+static void vt100_putchar(QemuVT100 *vt, int ch)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
     int i;
     int x, y;
     g_autofree char *response = NULL;
 
-    switch(vc->state) {
+    switch (vt->state) {
     case TTY_STATE_NORM:
-        if (ch >= 0x80 && vc->encoding == CHARDEV_VC_ENCODING_UTF8) {
-            switch (bh_utf8_decode(&vc->utf8_state, &vc->utf8_codepoint, ch)) {
+        if (ch >= 0x80 && vt->encoding == CHARDEV_VC_ENCODING_UTF8) {
+            switch (bh_utf8_decode(&vt->utf8_state, &vt->utf8_codepoint, ch)) {
             case BH_UTF8_ACCEPT:
-                vc_put_one(vc, unicode_to_cp437(vc->utf8_codepoint));
+                vt100_put_one(vt, unicode_to_cp437(vt->utf8_codepoint));
                 break;
             case BH_UTF8_REJECT:
-                vc->utf8_state = BH_UTF8_ACCEPT;
+                vt->utf8_state = BH_UTF8_ACCEPT;
                 break;
             default:
                 /* Need more bytes */
@@ -844,14 +824,13 @@ static void vc_putchar(VCChardev *vc, int ch)
             }
             break;
         }
-        /* ASCII byte: abort any pending UTF-8 sequence */
-        vc->utf8_state = BH_UTF8_ACCEPT;
+        vt->utf8_state = BH_UTF8_ACCEPT;
         switch(ch) {
         case '\r':  /* carriage return */
             vt->x = 0;
             break;
         case '\n':  /* newline */
-            vt100_put_lf(&s->vt);
+            vt100_put_lf(vt);
             break;
         case '\b':  /* backspace */
             if (vt->x > 0)
@@ -875,95 +854,95 @@ static void vc_putchar(VCChardev *vc, int ch)
             /* SI (shift in), character set 0 (ignored) */
             break;
         case 27:    /* esc (introducing an escape sequence) */
-            vc->state = TTY_STATE_ESC;
+            vt->state = TTY_STATE_ESC;
             break;
         default:
-            vc_put_one(vc, ch);
+            vt100_put_one(vt, ch);
             break;
         }
         break;
     case TTY_STATE_ESC: /* check if it is a terminal escape sequence */
         if (ch == '[') {
             for(i=0;i<MAX_ESC_PARAMS;i++)
-                vc->esc_params[i] = 0;
-            vc->nb_esc_params = 0;
-            vc->state = TTY_STATE_CSI;
+                vt->esc_params[i] = 0;
+            vt->nb_esc_params = 0;
+            vt->state = TTY_STATE_CSI;
         } else if (ch == '(') {
-            vc->state = TTY_STATE_G0;
+            vt->state = TTY_STATE_G0;
         } else if (ch == ')') {
-            vc->state = TTY_STATE_G1;
+            vt->state = TTY_STATE_G1;
         } else if (ch == ']' || ch == 'P' || ch == 'X'
                    || ch == '^' || ch == '_') {
             /* String sequences: OSC, DCS, SOS, PM, APC */
-            vc->state = TTY_STATE_OSC;
+            vt->state = TTY_STATE_OSC;
         } else if (ch == '7') {
-            vc_save_cursor(vc);
-            vc->state = TTY_STATE_NORM;
+            vt100_save_cursor(vt);
+            vt->state = TTY_STATE_NORM;
         } else if (ch == '8') {
-            vc_restore_cursor(vc);
-            vc->state = TTY_STATE_NORM;
+            vt100_restore_cursor(vt);
+            vt->state = TTY_STATE_NORM;
         } else {
-            vc->state = TTY_STATE_NORM;
+            vt->state = TTY_STATE_NORM;
         }
         break;
     case TTY_STATE_CSI: /* handle escape sequence parameters */
         if (ch >= '0' && ch <= '9') {
-            if (vc->nb_esc_params < MAX_ESC_PARAMS) {
-                int *param = &vc->esc_params[vc->nb_esc_params];
+            if (vt->nb_esc_params < MAX_ESC_PARAMS) {
+                int *param = &vt->esc_params[vt->nb_esc_params];
                 int digit = (ch - '0');
 
                 *param = (*param <= (INT_MAX - digit) / 10) ?
                          *param * 10 + digit : INT_MAX;
             }
         } else {
-            if (vc->nb_esc_params < MAX_ESC_PARAMS)
-                vc->nb_esc_params++;
+            if (vt->nb_esc_params < MAX_ESC_PARAMS)
+                vt->nb_esc_params++;
             if (ch == ';' || ch == '?') {
                 break;
             }
-            trace_console_putchar_csi(vc->esc_params[0], vc->esc_params[1],
-                                      ch, vc->nb_esc_params);
-            vc->state = TTY_STATE_NORM;
+            trace_console_putchar_csi(vt->esc_params[0], vt->esc_params[1],
+                                      ch, vt->nb_esc_params);
+            vt->state = TTY_STATE_NORM;
             switch(ch) {
             case 'A':
                 /* move cursor up */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, vt->x, vt->y - vc->esc_params[0]);
+                vt100_set_cursor(vt, vt->x, vt->y - vt->esc_params[0]);
                 break;
             case 'B':
                 /* move cursor down */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, vt->x, vt->y + vc->esc_params[0]);
+                vt100_set_cursor(vt, vt->x, vt->y + vt->esc_params[0]);
                 break;
             case 'C':
                 /* move cursor right */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, vt->x + vc->esc_params[0], vt->y);
+                vt100_set_cursor(vt, vt->x + vt->esc_params[0], vt->y);
                 break;
             case 'D':
                 /* move cursor left */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, vt->x - vc->esc_params[0], vt->y);
+                vt100_set_cursor(vt, vt->x - vt->esc_params[0], vt->y);
                 break;
             case 'G':
                 /* move cursor to column */
-                vc_set_cursor(vc, vc->esc_params[0] - 1, vt->y);
+                vt100_set_cursor(vt, vt->esc_params[0] - 1, vt->y);
                 break;
             case 'f':
             case 'H':
                 /* move cursor to row, column */
-                vc_set_cursor(vc, vc->esc_params[1] - 1, vc->esc_params[0] - 1);
+                vt100_set_cursor(vt, vt->esc_params[1] - 1, vt->esc_params[0] - 1);
                 break;
             case 'J':
-                switch (vc->esc_params[0]) {
+                switch (vt->esc_params[0]) {
                 case 0:
                     /* clear to end of screen */
                     for (y = vt->y; y < vt->height; y++) {
@@ -971,7 +950,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                             if (y == vt->y && x < vt->x) {
                                 continue;
                             }
-                            vc_clear_xy(vc, x, y);
+                            vt100_clear_xy(vt, x, y);
                         }
                     }
                     break;
@@ -982,7 +961,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                             if (y == vt->y && x > vt->x) {
                                 break;
                             }
-                            vc_clear_xy(vc, x, y);
+                            vt100_clear_xy(vt, x, y);
                         }
                     }
                     break;
@@ -990,62 +969,62 @@ static void vc_putchar(VCChardev *vc, int ch)
                     /* clear entire screen */
                     for (y = 0; y < vt->height; y++) {
                         for (x = 0; x < vt->width; x++) {
-                            vc_clear_xy(vc, x, y);
+                            vt100_clear_xy(vt, x, y);
                         }
                     }
                     break;
                 }
                 break;
             case 'K':
-                switch (vc->esc_params[0]) {
+                switch (vt->esc_params[0]) {
                 case 0:
                     /* clear to eol */
                     for(x = vt->x; x < vt->width; x++) {
-                        vc_clear_xy(vc, x, vt->y);
+                        vt100_clear_xy(vt, x, vt->y);
                     }
                     break;
                 case 1:
                     /* clear from beginning of line */
                     for (x = 0; x <= vt->x && x < vt->width; x++) {
-                        vc_clear_xy(vc, x, vt->y);
+                        vt100_clear_xy(vt, x, vt->y);
                     }
                     break;
                 case 2:
                     /* clear entire line */
                     for(x = 0; x < vt->width; x++) {
-                        vc_clear_xy(vc, x, vt->y);
+                        vt100_clear_xy(vt, x, vt->y);
                     }
                     break;
                 }
                 break;
             case 'P':
-                vc_csi_P(vc, vc->esc_params[0]);
+                vt100_csi_P(vt, vt->esc_params[0]);
                 break;
             case 'm':
-                vc_handle_escape(vc);
+                vt100_handle_escape(vt);
                 break;
             case 'n':
-                switch (vc->esc_params[0]) {
+                switch (vt->esc_params[0]) {
                 case 5:
                     /* report console status (always succeed)*/
-                    qemu_text_console_write(s, "\033[0n", 4);
+                    vt100_write(vt, "\033[0n", 4);
                     break;
                 case 6:
                     /* report cursor position */
                     response = g_strdup_printf("\033[%d;%dR",
                                                vt->y + 1, vt->x + 1);
-                    qemu_text_console_write(s, response, strlen(response));
+                    vt100_write(vt, response, strlen(response));
                     break;
                 }
                 break;
             case 's':
-                vc_save_cursor(vc);
+                vt100_save_cursor(vt);
                 break;
             case 'u':
-                vc_restore_cursor(vc);
+                vt100_restore_cursor(vt);
                 break;
             case '@':
-                vc_csi_at(vc, vc->esc_params[0]);
+                vt100_csi_at(vt, vt->esc_params[0]);
                 break;
             default:
                 trace_console_putchar_unhandled(ch);
@@ -1057,10 +1036,10 @@ static void vc_putchar(VCChardev *vc, int ch)
     case TTY_STATE_OSC: /* Operating System Command: ESC ] ... BEL/ST */
         if (ch == '\a') {
             /* BEL terminates OSC */
-            vc->state = TTY_STATE_NORM;
+            vt->state = TTY_STATE_NORM;
         } else if (ch == 27) {
             /* ESC might start ST (ESC \) */
-            vc->state = TTY_STATE_ESC;
+            vt->state = TTY_STATE_ESC;
         }
         /* All other bytes are silently consumed */
         break;
@@ -1071,7 +1050,7 @@ static void vc_putchar(VCChardev *vc, int ch)
             /* Latin-1 map */
             break;
         }
-        vc->state = TTY_STATE_NORM;
+        vt->state = TTY_STATE_NORM;
         break;
     }
 }
@@ -1084,22 +1063,21 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     VCChardev *drv = VC_CHARDEV(chr);
     QemuTextConsole *s = drv->console;
-    QemuVT100 *vt = &s->vt;
     int i;
 
-    vt->update_x0 = vt->width * FONT_WIDTH;
-    vt->update_y0 = vt->height * FONT_HEIGHT;
-    vt->update_x1 = 0;
-    vt->update_y1 = 0;
-    vt100_show_cursor(vt, 0);
+    s->vt.update_x0 = s->vt.width * FONT_WIDTH;
+    s->vt.update_y0 = s->vt.height * FONT_HEIGHT;
+    s->vt.update_x1 = 0;
+    s->vt.update_y1 = 0;
+    vt100_show_cursor(&s->vt, 0);
     for(i = 0; i < len; i++) {
-        vc_putchar(drv, buf[i]);
+        vt100_putchar(&s->vt, buf[i]);
     }
-    vt100_show_cursor(vt, 1);
-    if (vt->update_x0 < vt->update_x1) {
-        vt100_image_update(vt, vt->update_x0, vt->update_y0,
-                           vt->update_x1 - vt->update_x0,
-                           vt->update_y1 - vt->update_y0);
+    vt100_show_cursor(&s->vt, 1);
+    if (s->vt.update_x0 < s->vt.update_x1) {
+        vt100_image_update(&s->vt, s->vt.update_x0, s->vt.update_y0,
+                           s->vt.update_x1 - s->vt.update_x0,
+                           s->vt.update_y1 - s->vt.update_y0);
     }
     return len;
 }
@@ -1168,9 +1146,6 @@ qemu_text_console_init(Object *obj)
 {
     QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
 
-    QTAILQ_INSERT_HEAD(&vt100s, &c->vt, list);
-    fifo8_create(&c->out_fifo, 16);
-    c->vt.total_height = DEFAULT_BACKSCROLL;
     QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
     QEMU_CONSOLE(c)->hw = c;
 }
@@ -1194,7 +1169,7 @@ static void vc_chr_accept_input(Chardev *chr)
 {
     VCChardev *drv = VC_CHARDEV(chr);
 
-    qemu_text_console_flush(drv->console);
+    qemu_text_console_out_flush(drv->console);
 }
 
 static void vc_chr_set_echo(Chardev *chr, bool echo)
@@ -1216,6 +1191,13 @@ static void text_console_image_update(QemuVT100 *vt, int x, int y, int width, in
     dpy_gfx_update(QEMU_CONSOLE(console), x, y, width, height);
 }
 
+static void text_console_out_flush(QemuVT100 *vt)
+{
+    QemuTextConsole *console = container_of(vt, QemuTextConsole, vt);
+
+    qemu_text_console_out_flush(console);
+}
+
 static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
@@ -1245,27 +1227,31 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE));
     }
 
+    QTAILQ_INSERT_HEAD(&vt100s, &s->vt, list);
+    fifo8_create(&s->vt.out_fifo, 16);
+    s->vt.total_height = DEFAULT_BACKSCROLL;
     dpy_gfx_replace_surface(QEMU_CONSOLE(s), qemu_create_displaysurface(width, height));
     s->vt.image_update = text_console_image_update;
+    s->vt.out_flush = text_console_out_flush;
 
     s->chr = chr;
     drv->console = s;
     if (vc->has_encoding) {
-        drv->encoding = vc->encoding;
+        drv->encoding = s->vt.encoding = vc->encoding;
     }
 
     /* set current text attributes to default */
-    drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+    s->vt.t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
 
     if (chr->label) {
         char *msg;
 
-        drv->t_attrib.bgcol = QEMU_COLOR_BLUE;
+        s->vt.t_attrib.bgcol = QEMU_COLOR_BLUE;
         msg = g_strdup_printf("%s console\r\n", chr->label);
         qemu_chr_write(chr, (uint8_t *)msg, strlen(msg), true);
         g_free(msg);
-        drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+        s->vt.t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-- 
2.54.0


