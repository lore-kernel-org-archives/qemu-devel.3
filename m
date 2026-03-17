Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B36DF3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QBi-0000jO-As; Tue, 17 Mar 2026 04:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAy-0007Wb-Tk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAv-0003D9-U3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jm2AeQLeY/7PKyygV7fcEQuEoBhALKKz1KnR9T9Mnk=;
 b=TlI6oOQ+DE3u4Xrmfjp8mO7WjFcVqwnYGGZjHFUTjTCCK5FHUQ17iPtCT01Tg/71ebb+QQ
 PHBoPeSxosEYftuU6Tldr4joCMiqDUUSeHw93Cr8dASKS0YUcb9eQPjZUS7lLkAybeucWF
 EJP5/hTs8rD+mZjShU3cVwaA1UvDCzU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-AB5_KiAeMOqh_lXwX5zkOw-1; Tue,
 17 Mar 2026 04:53:15 -0400
X-MC-Unique: AB5_KiAeMOqh_lXwX5zkOw-1
X-Mimecast-MFC-AGG-ID: AB5_KiAeMOqh_lXwX5zkOw_1773737595
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D814318005BD
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:14 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 974691800576
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:41 +0400
Subject: [PATCH 27/60] ui/console-vc: move VT100 state machine and output
 FIFO into QemuVT100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-27-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=32824;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FBZeB+mSYqwGVV6u9MQO/spZ7c8aebHEI6nlJf7L0k0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbJRas4i/pFkySlhrvIilWjLpLfT7/T/Xx0
 jDOAoTFKuOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5ZmcD/9iuGmsHbc98T+x/YdlVRZiUHHXb8Sum99DJoqd+nK2NzE5s+Dz7/xyIit3DnK5h931eq0
 zx4qkaoYW2ZtUts38qExXAyVS8EJUhckwtJ20cmd6i6kJPrX5iUGa3H79XOt9ZVbmPHNSNqnznl
 N7fMskct8HZFuaTK/9Fn8cCxNoPpZ9s49YOVGBRtr+eKSZwaHWGVe8IxZmws9h6mQdLgmVD6wsP
 CIgiOIup9T6i1CGzhI6eGHg9AOS5fHbNTx/apCT6LeqYFIMwTEUxxBcq+vHN5AThHIBM6Ygn9aE
 /C6mrW0448LI/7UQ906FTupreM0pQzYRN5aGMzD9uH5KCbA2wdoc223zS+HJ25b4hhdc99nUmQv
 OSHxZBXnrBF+dDMMl1UDAZG5Ql86Q5oiSLG8byD+j7rMvUdimW9ObWywrWM9nabapBuExXtvi4H
 ohp8URG2Tkt3wF+4VaI6zLD4a9DWfr/nfzKR1t8YIKKrppAj6msuI/U8lJi8nY7HBFUntBGoUcD
 mSssGr/p8Qw3RhqFCmME4yci/OVPBcpvkb+z1HOxt4JM0jhsvbeiGMopU02SuC1SWSYE/KjkGZm
 5W79QwMq5jFm3dOhNLzjm4MzQDRYlquQuf1XgUclDslXgfvWicb8T3mRvbIA5P/5xm6MdC0vMME
 vHG0IYvGcYqU2FA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
---
 ui/console-vc.c | 433 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 215 insertions(+), 218 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 8d4178f8cab..87881c072ee 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -72,6 +72,18 @@ struct QemuVT100 {
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
 
@@ -83,8 +95,6 @@ typedef struct QemuTextConsole {
 
     QemuVT100 vt;
     Chardev *chr;
-    /* fifo for key pressed */
-    Fifo8 out_fifo;
 } QemuTextConsole;
 
 typedef QemuConsoleClass QemuTextConsoleClass;
@@ -102,15 +112,6 @@ OBJECT_DEFINE_TYPE(QemuFixedTextConsole, qemu_fixed_text_console, QEMU_FIXED_TEX
 struct VCChardev {
     Chardev parent;
     QemuTextConsole *console;
-
-    enum TTYState state;
-    int esc_params[MAX_ESC_PARAMS];
-    int nb_esc_params;
-    uint32_t utf8_state;     /* UTF-8 DFA decoder state */
-    uint32_t utf8_codepoint; /* accumulated UTF-8 code point */
-    TextAttributes t_attrib; /* currently active text attributes */
-    TextAttributes t_attrib_saved;
-    int x_saved, y_saved;
 };
 typedef struct VCChardev VCChardev;
 
@@ -299,30 +300,30 @@ static void vt100_scroll(QemuVT100 *vt, int ydelta)
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
@@ -368,7 +369,7 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
         if (s->vt.echo) {
             qemu_chr_write(s->chr, buf, q - buf, true);
         }
-        qemu_text_console_write(s, buf, q - buf);
+        vt100_write(&s->vt, buf, q - buf);
         break;
     }
 }
@@ -487,137 +488,135 @@ static void vt100_put_lf(QemuVT100 *vt)
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
     TextCell *c;
     int y1, y2;
 
-    s->vt.text_x[0] = MIN(s->vt.text_x[0], x);
-    s->vt.text_x[1] = MAX(s->vt.text_x[1], x);
-    s->vt.text_y[0] = MIN(s->vt.text_y[0], y);
-    s->vt.text_y[1] = MAX(s->vt.text_y[1], y);
+    vt->text_x[0] = MIN(vt->text_x[0], x);
+    vt->text_x[1] = MAX(vt->text_x[1], x);
+    vt->text_y[0] = MIN(vt->text_y[0], y);
+    vt->text_y[1] = MAX(vt->text_y[1], y);
 
-    y1 = (s->vt.y_base + y) % s->vt.total_height;
-    y2 = y1 - s->vt.y_displayed;
+    y1 = (vt->y_base + y) % vt->total_height;
+    y2 = y1 - vt->y_displayed;
     if (y2 < 0) {
-        y2 += s->vt.total_height;
+        y2 += vt->total_height;
     }
-    if (y2 < s->vt.height) {
-        if (x >= s->vt.width) {
-            x = s->vt.width - 1;
+    if (y2 < vt->height) {
+        if (x >= vt->width) {
+            x = vt->width - 1;
         }
-        c = &s->vt.cells[y1 * s->vt.width + x];
-        vt100_putcharxy(&s->vt, x, y2, c->ch,
+        c = &vt->cells[y1 * vt->width + x];
+        vt100_putcharxy(vt, x, y2, c->ch,
                       &(c->t_attrib));
-        vt100_invalidate_xy(&s->vt, x, y2);
+        vt100_invalidate_xy(vt, x, y2);
     }
 }
 
-static void vc_clear_xy(VCChardev *vc, int x, int y)
+static void vt100_clear_xy(QemuVT100 *vt, int x, int y)
 {
-    QemuTextConsole *s = vc->console;
-    int y1 = (s->vt.y_base + y) % s->vt.total_height;
-    if (x >= s->vt.width) {
-        x = s->vt.width - 1;
+    int y1 = (vt->y_base + y) % vt->total_height;
+    if (x >= vt->width) {
+        x = vt->width - 1;
     }
-    TextCell *c = &s->vt.cells[y1 * s->vt.width + x];
+    TextCell *c = &vt->cells[y1 * vt->width + x];
     c->ch = ' ';
     c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    vc_update_xy(vc, x, y);
+    vt100_update_xy(vt, x, y);
 }
 
 /*
@@ -661,44 +660,41 @@ static uint32_t utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
     return *state;
 }
 
-static void vc_put_one(VCChardev *vc, int ch)
+static void vt100_put_one(QemuVT100 *vt, int ch)
 {
-    QemuTextConsole *s = vc->console;
     TextCell *c;
     int y1;
-    if (s->vt.x >= s->vt.width) {
+    if (vt->x >= vt->width) {
         /* line wrap */
-        s->vt.x = 0;
-        vt100_put_lf(&s->vt);
+        vt->x = 0;
+        vt100_put_lf(vt);
     }
-    y1 = (s->vt.y_base + s->vt.y) % s->vt.total_height;
-    c = &s->vt.cells[y1 * s->vt.width + s->vt.x];
+    y1 = (vt->y_base + vt->y) % vt->total_height;
+    c = &vt->cells[y1 * vt->width + vt->x];
     c->ch = ch;
-    c->t_attrib = vc->t_attrib;
-    vc_update_xy(vc, s->vt.x, s->vt.y);
-    s->vt.x++;
+    c->t_attrib = vt->t_attrib;
+    vt100_update_xy(vt, vt->x, vt->y);
+    vt->x++;
 }
 
 /* set cursor, checking bounds */
-static void vc_set_cursor(VCChardev *vc, int x, int y)
+static void vt100_set_cursor(QemuVT100 *vt, int x, int y)
 {
-    QemuTextConsole *s = vc->console;
-
     if (x < 0) {
         x = 0;
     }
     if (y < 0) {
         y = 0;
     }
-    if (y >= s->vt.height) {
-        y = s->vt.height - 1;
+    if (y >= vt->height) {
+        y = vt->height - 1;
     }
-    if (x >= s->vt.width) {
-        x = s->vt.width - 1;
+    if (x >= vt->width) {
+        x = vt->width - 1;
     }
 
-    s->vt.x = x;
-    s->vt.y = y;
+    vt->x = x;
+    vt->y = y;
 }
 
 /**
@@ -707,9 +703,8 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
  * characters between the cursor and right margin move to the
  * left. Character attributes move with the characters.
  */
-static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
+static void vt100_csi_P(QemuVT100 *vt, unsigned int nr)
 {
-    QemuTextConsole *s = vc->console;
     TextCell *c1, *c2;
     unsigned int x1, x2, y;
     unsigned int end, len;
@@ -717,28 +712,28 @@ static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
     if (!nr) {
         nr = 1;
     }
-    if (nr > s->vt.width - s->vt.x) {
-        nr = s->vt.width - s->vt.x;
+    if (nr > vt->width - vt->x) {
+        nr = vt->width - vt->x;
         if (!nr) {
             return;
         }
     }
 
-    x1 = s->vt.x;
-    x2 = s->vt.x + nr;
-    len = s->vt.width - x2;
+    x1 = vt->x;
+    x2 = vt->x + nr;
+    len = vt->width - x2;
     if (len) {
-        y = (s->vt.y_base + s->vt.y) % s->vt.total_height;
-        c1 = &s->vt.cells[y * s->vt.width + x1];
-        c2 = &s->vt.cells[y * s->vt.width + x2];
+        y = (vt->y_base + vt->y) % vt->total_height;
+        c1 = &vt->cells[y * vt->width + x1];
+        c2 = &vt->cells[y * vt->width + x2];
         memmove(c1, c2, len * sizeof(*c1));
         for (end = x1 + len; x1 < end; x1++) {
-            vc_update_xy(vc, x1, s->vt.y);
+            vt100_update_xy(vt, x1, vt->y);
         }
     }
     /* Clear the rest */
-    for (; x1 < s->vt.width; x1++) {
-        vc_clear_xy(vc, x1, s->vt.y);
+    for (; x1 < vt->width; x1++) {
+        vt100_clear_xy(vt, x1, vt->y);
     }
 }
 
@@ -748,9 +743,8 @@ static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
  * blank characters. Text between the cursor and right margin moves to
  * the right. Characters scrolled past the right margin are lost.
  */
-static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
+static void vt100_csi_at(QemuVT100 *vt, unsigned int nr)
 {
-    QemuTextConsole *s = vc->console;
     TextCell *c1, *c2;
     unsigned int x1, x2, y;
     unsigned int end, len;
@@ -758,74 +752,69 @@ static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
     if (!nr) {
         nr = 1;
     }
-    if (nr > s->vt.width - s->vt.x) {
-        nr = s->vt.width - s->vt.x;
+    if (nr > vt->width - vt->x) {
+        nr = vt->width - vt->x;
         if (!nr) {
             return;
         }
     }
 
-    x1 = s->vt.x + nr;
-    x2 = s->vt.x;
-    len = s->vt.width - x1;
+    x1 = vt->x + nr;
+    x2 = vt->x;
+    len = vt->width - x1;
     if (len) {
-        y = (s->vt.y_base + s->vt.y) % s->vt.total_height;
-        c1 = &s->vt.cells[y * s->vt.width + x1];
-        c2 = &s->vt.cells[y * s->vt.width + x2];
+        y = (vt->y_base + vt->y) % vt->total_height;
+        c1 = &vt->cells[y * vt->width + x1];
+        c2 = &vt->cells[y * vt->width + x2];
         memmove(c1, c2, len * sizeof(*c1));
         for (end = x1 + len; x1 < end; x1++) {
-            vc_update_xy(vc, x1, s->vt.y);
+            vt100_update_xy(vt, x1, vt->y);
         }
     }
     /* Insert blanks */
-    for (x1 = s->vt.x; x1 < s->vt.x + nr; x1++) {
-        vc_clear_xy(vc, x1, s->vt.y);
+    for (x1 = vt->x; x1 < vt->x + nr; x1++) {
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
-
-    vc->x_saved = s->vt.x;
-    vc->y_saved = s->vt.y;
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
-
-    s->vt.x = vc->x_saved;
-    s->vt.y = vc->y_saved;
-    vc->t_attrib = vc->t_attrib_saved;
+    vt->x = vt->x_saved;
+    vt->y = vt->y_saved;
+    vt->t_attrib = vt->t_attrib_saved;
 }
 
-static void vc_putchar(VCChardev *vc, int ch)
+static void vt100_putchar(QemuVT100 *vt, int ch)
 {
-    QemuTextConsole *s = vc->console;
     int i;
     int x, y;
     g_autofree char *response = NULL;
 
-    switch(vc->state) {
+    switch (vt->state) {
     case TTY_STATE_NORM:
         /* Feed byte through the UTF-8 DFA decoder */
         if (ch >= 0x80) {
-            switch (utf8_decode(&vc->utf8_state, &vc->utf8_codepoint, ch)) {
+            switch (utf8_decode(&vt->utf8_state, &vt->utf8_codepoint, ch)) {
             case UTF8_ACCEPT:
-                vc_put_one(vc, unicode_to_cp437(vc->utf8_codepoint));
+                vt100_put_one(vt, unicode_to_cp437(vt->utf8_codepoint));
                 break;
             case UTF8_REJECT:
                 /* Reset state so the decoder can resync */
-                vc->utf8_state = UTF8_ACCEPT;
+                vt->utf8_state = UTF8_ACCEPT;
                 break;
             default:
                 /* Need more bytes */
@@ -834,24 +823,24 @@ static void vc_putchar(VCChardev *vc, int ch)
             break;
         }
         /* ASCII byte: abort any pending UTF-8 sequence */
-        vc->utf8_state = UTF8_ACCEPT;
+        vt->utf8_state = UTF8_ACCEPT;
         switch(ch) {
         case '\r':  /* carriage return */
-            s->vt.x = 0;
+            vt->x = 0;
             break;
         case '\n':  /* newline */
-            vt100_put_lf(&s->vt);
+            vt100_put_lf(vt);
             break;
         case '\b':  /* backspace */
-            if (s->vt.x > 0)
-                s->vt.x--;
+            if (vt->x > 0)
+                vt->x--;
             break;
         case '\t':  /* tabspace */
-            if (s->vt.x + (8 - (s->vt.x % 8)) > s->vt.width) {
-                s->vt.x = 0;
-                vt100_put_lf(&s->vt);
+            if (vt->x + (8 - (vt->x % 8)) > vt->width) {
+                vt->x = 0;
+                vt100_put_lf(vt);
             } else {
-                s->vt.x = s->vt.x + (8 - (s->vt.x % 8));
+                vt->x = vt->x + (8 - (vt->x % 8));
             }
             break;
         case '\a':  /* alert aka. bell */
@@ -864,177 +853,177 @@ static void vc_putchar(VCChardev *vc, int ch)
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
-                vc_set_cursor(vc, s->vt.x, s->vt.y - vc->esc_params[0]);
+                vt100_set_cursor(vt, vt->x, vt->y - vt->esc_params[0]);
                 break;
             case 'B':
                 /* move cursor down */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->vt.x, s->vt.y + vc->esc_params[0]);
+                vt100_set_cursor(vt, vt->x, vt->y + vt->esc_params[0]);
                 break;
             case 'C':
                 /* move cursor right */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->vt.x + vc->esc_params[0], s->vt.y);
+                vt100_set_cursor(vt, vt->x + vt->esc_params[0], vt->y);
                 break;
             case 'D':
                 /* move cursor left */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->vt.x - vc->esc_params[0], s->vt.y);
+                vt100_set_cursor(vt, vt->x - vt->esc_params[0], vt->y);
                 break;
             case 'G':
                 /* move cursor to column */
-                vc_set_cursor(vc, vc->esc_params[0] - 1, s->vt.y);
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
-                    for (y = s->vt.y; y < s->vt.height; y++) {
-                        for (x = 0; x < s->vt.width; x++) {
-                            if (y == s->vt.y && x < s->vt.x) {
+                    for (y = vt->y; y < vt->height; y++) {
+                        for (x = 0; x < vt->width; x++) {
+                            if (y == vt->y && x < vt->x) {
                                 continue;
                             }
-                            vc_clear_xy(vc, x, y);
+                            vt100_clear_xy(vt, x, y);
                         }
                     }
                     break;
                 case 1:
                     /* clear from beginning of screen */
-                    for (y = 0; y <= s->vt.y; y++) {
-                        for (x = 0; x < s->vt.width; x++) {
-                            if (y == s->vt.y && x > s->vt.x) {
+                    for (y = 0; y <= vt->y; y++) {
+                        for (x = 0; x < vt->width; x++) {
+                            if (y == vt->y && x > vt->x) {
                                 break;
                             }
-                            vc_clear_xy(vc, x, y);
+                            vt100_clear_xy(vt, x, y);
                         }
                     }
                     break;
                 case 2:
                     /* clear entire screen */
-                    for (y = 0; y < s->vt.height; y++) {
-                        for (x = 0; x < s->vt.width; x++) {
-                            vc_clear_xy(vc, x, y);
+                    for (y = 0; y < vt->height; y++) {
+                        for (x = 0; x < vt->width; x++) {
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
-                    for(x = s->vt.x; x < s->vt.width; x++) {
-                        vc_clear_xy(vc, x, s->vt.y);
+                    for(x = vt->x; x < vt->width; x++) {
+                        vt100_clear_xy(vt, x, vt->y);
                     }
                     break;
                 case 1:
                     /* clear from beginning of line */
-                    for (x = 0; x <= s->vt.x && x < s->vt.width; x++) {
-                        vc_clear_xy(vc, x, s->vt.y);
+                    for (x = 0; x <= vt->x && x < vt->width; x++) {
+                        vt100_clear_xy(vt, x, vt->y);
                     }
                     break;
                 case 2:
                     /* clear entire line */
-                    for(x = 0; x < s->vt.width; x++) {
-                        vc_clear_xy(vc, x, s->vt.y);
+                    for(x = 0; x < vt->width; x++) {
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
-                                               s->vt.y + 1, s->vt.x + 1);
-                    qemu_text_console_write(s, response, strlen(response));
+                                               vt->y + 1, vt->x + 1);
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
@@ -1046,10 +1035,10 @@ static void vc_putchar(VCChardev *vc, int ch)
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
@@ -1060,7 +1049,7 @@ static void vc_putchar(VCChardev *vc, int ch)
             /* Latin-1 map */
             break;
         }
-        vc->state = TTY_STATE_NORM;
+        vt->state = TTY_STATE_NORM;
         break;
     }
 }
@@ -1081,7 +1070,7 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     s->vt.update_y1 = 0;
     vt100_show_cursor(&s->vt, 0);
     for(i = 0; i < len; i++) {
-        vc_putchar(drv, buf[i]);
+        vt100_putchar(&s->vt, buf[i]);
     }
     vt100_show_cursor(&s->vt, 1);
     if (s->vt.update_x0 < s->vt.update_x1) {
@@ -1156,9 +1145,6 @@ qemu_text_console_init(Object *obj)
 {
     QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
 
-    QTAILQ_INSERT_HEAD(&vt100s, &c->vt, list);
-    fifo8_create(&c->out_fifo, 16);
-    c->vt.total_height = DEFAULT_BACKSCROLL;
     QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
     QEMU_CONSOLE(c)->hw = c;
 }
@@ -1182,7 +1168,7 @@ static void vc_chr_accept_input(Chardev *chr)
 {
     VCChardev *drv = VC_CHARDEV(chr);
 
-    qemu_text_console_flush(drv->console);
+    qemu_text_console_out_flush(drv->console);
 }
 
 static void vc_chr_set_echo(Chardev *chr, bool echo)
@@ -1204,6 +1190,13 @@ static void text_console_image_update(QemuVT100 *vt, int x, int y, int width, in
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
@@ -1233,24 +1226,28 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
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
2.53.0


