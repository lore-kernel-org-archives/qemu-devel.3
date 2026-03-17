Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7692BF33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QDJ-0003Xs-74; Tue, 17 Mar 2026 04:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBt-0001De-GA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBk-0005fh-VR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QvEdpFOkTuMJ8AUFSwX7PSaL1V7+UXlBfj5Rp+8q5E=;
 b=HRKEORZHWaGGp5tOik3vngZm+sXXA/pQ51tzgY5jaoMpmq9+zOFyl0hPsc2eM8UrRbS6Te
 T2h1OV12Yghgbxixq49yK4ayQJXfMaPZHnGIUMALRAfRC//u7d2CmTngBVvnOMhqEhSEax
 vv0v7vfOlYRKDba9bygMuG7vXji9z0Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-cpP86b5ZNw2jXzKQenzaUw-1; Tue,
 17 Mar 2026 04:54:06 -0400
X-MC-Unique: cpP86b5ZNw2jXzKQenzaUw-1
X-Mimecast-MFC-AGG-ID: cpP86b5ZNw2jXzKQenzaUw_1773737645
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C893F180035D
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F99630002DA
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:49 +0400
Subject: [PATCH 35/60] ui/console-vc: move VT100 emulation into separate unit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-35-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=71902;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ou5POjR0QnEPG4TneCR8IvUiVVhST8hyL1/WQpsoBR0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXblrH6GU/LzK+J+dagwhNOwQFFTKSvEwuor
 pTsPBWRUByJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5ZuED/4iwUeLxOYxuXqkcCBnpoS0N5eYW3DhlYnKaVm4ipTXvMnrmNG4YmY9ElpmESBlMuik9aF
 IXgdo3gOloxGPwYSIlM6O2huyefCeclnwaEDzXN78v03Ro0vkdEnr3l9/UNnG6/jOr9lQBm2XiO
 6q+DoVBC4LBq3tSGlNC7jP0RfUrmuq9cy1YbYKZzZc50/aXrD4uF9IyFfv53CW/zvXs0b9NXBb0
 KDqhb0oBD4ZUy5O+SOOt0Iz1arzo9w1dqaINQTt6VaCWodc4tYaXr5xO/ooqOrwlTkxhiiFwY3E
 TkL7zGi2wEn6JcwFoyyZQWtK3NMyjZ3gFk9TMmEWXb1Y2J+grFP4iOzsOXjQwq8iNNPTlXHmWF0
 wjTtb1+JUH3jXSRyxBkgdIJAgHd0wO3FczoB1NMhZCDh4pX29LEASEWw4zTmsKYNEjx6lBtZ1NW
 HJvP+Y9GQl23oulgqDKxUTxk2RiOfSb2nl9bAuotXtFjJ9WofhBW9xlRdXVv/2A60nu54xValsk
 dRLAebWeXymzXvq95E5VMsT5fYeY7YnPhzn5C5kHtBIl/R+q/zYZbptGKvI1SBoFvn6BtUAJQuM
 bqyb2FL94mI83dJ8jMYWAVecbuELQCbLr/qTpTXubkPOj9yTAyH1GdOev+lXfL5bky6MrPPTmEf
 r6JztSgr3nA1Saw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Move the VT100 terminal emulation code into dedicated ui/vt100.c and
ui/vt100.h files, completing the extraction from console-vc.c started
in the previous patches. This makes the VT100 layer a self-contained
module that can be reused independently of the chardev/console
infrastructure.

The code is moved as-is, with minor coding style fixes (adding missing
braces, fixing whitespace) applied during the move.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-priv.h     |    1 -
 ui/vt100.h            |   92 +++++
 ui/console-vc-stubs.c |    1 +
 ui/console-vc.c       | 1035 +------------------------------------------------
 ui/console.c          |    2 +
 ui/vt100.c            |  987 ++++++++++++++++++++++++++++++++++++++++++++++
 ui/meson.build        |    4 +-
 7 files changed, 1086 insertions(+), 1036 deletions(-)

diff --git a/ui/console-priv.h b/ui/console-priv.h
index 39798c3e9d7..f8855753e30 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -31,7 +31,6 @@ struct QemuConsole {
 };
 
 void qemu_text_console_update_size(QemuTextConsole *c);
-void vt100_update_cursor(void);
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym);
 
 #endif
diff --git a/ui/vt100.h b/ui/vt100.h
new file mode 100644
index 00000000000..18e5320766b
--- /dev/null
+++ b/ui/vt100.h
@@ -0,0 +1,92 @@
+/*
+ * SPDX-License-Identifier: MIT
+ * QEMU vt100
+ */
+#ifndef VT100_H
+#define VT100_H
+
+#include "ui/console.h"
+#include "qemu/fifo8.h"
+#include "qemu/queue.h"
+
+typedef struct TextAttributes {
+    uint8_t fgcol:4;
+    uint8_t bgcol:4;
+    uint8_t bold:1;
+    uint8_t uline:1;
+    uint8_t blink:1;
+    uint8_t invers:1;
+    uint8_t unvisible:1;
+} TextAttributes;
+
+#define TEXT_ATTRIBUTES_DEFAULT ((TextAttributes) { \
+    .fgcol = QEMU_COLOR_WHITE,                      \
+    .bgcol = QEMU_COLOR_BLACK                       \
+})
+
+typedef struct TextCell {
+    uint8_t ch;
+    TextAttributes t_attrib;
+} TextCell;
+
+#define MAX_ESC_PARAMS 3
+
+enum TTYState {
+    TTY_STATE_NORM,
+    TTY_STATE_ESC,
+    TTY_STATE_CSI,
+    TTY_STATE_G0,
+    TTY_STATE_G1,
+    TTY_STATE_OSC,
+};
+
+typedef struct QemuVT100 QemuVT100;
+
+struct QemuVT100 {
+    pixman_image_t *image;
+    void (*image_update)(QemuVT100 *vt, int x, int y, int width, int height);
+
+    int width;
+    int height;
+    int total_height;
+    int backscroll_height;
+    int x, y;
+    int y_displayed;
+    int y_base;
+    TextCell *cells;
+    int text_x[2], text_y[2], cursor_invalidate;
+    int echo;
+
+    int update_x0;
+    int update_y0;
+    int update_x1;
+    int update_y1;
+
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
+    QTAILQ_ENTRY(QemuVT100) list;
+};
+
+void vt100_init(QemuVT100 *vt,
+                pixman_image_t *image,
+                void (*image_update)(QemuVT100 *vt, int x, int y, int width, int height),
+                void (*out_flush)(QemuVT100 *vt));
+void vt100_fini(QemuVT100 *vt);
+
+void vt100_update_cursor(void);
+int vt100_input(QemuVT100 *vt, const uint8_t *buf, int len);
+void vt100_keysym(QemuVT100 *vt, int keysym);
+void vt100_set_image(QemuVT100 *vt, pixman_image_t *image);
+void vt100_refresh(QemuVT100 *vt);
+
+#endif
diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
index d911a82f263..30e4d101197 100644
--- a/ui/console-vc-stubs.c
+++ b/ui/console-vc-stubs.c
@@ -9,6 +9,7 @@
 #include "qemu/option.h"
 #include "chardev/char.h"
 #include "ui/console-priv.h"
+#include "vt100.h"
 
 void qemu_text_console_update_size(QemuTextConsole *c)
 {
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 8e785cde94c..6e8f2552e41 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -6,91 +6,15 @@
 
 #include "chardev/char.h"
 #include "qapi/error.h"
-#include "qemu/fifo8.h"
 #include "qemu/option.h"
-#include "qemu/queue.h"
 #include "ui/console.h"
-#include "ui/cp437.h"
 #include "ui/vgafont.h"
+#include "ui/vt100.h"
 
 #include "pixman.h"
 #include "trace.h"
 #include "console-priv.h"
 
-#define DEFAULT_BACKSCROLL 512
-#define CONSOLE_CURSOR_PERIOD 500
-
-typedef struct TextAttributes {
-    uint8_t fgcol:4;
-    uint8_t bgcol:4;
-    uint8_t bold:1;
-    uint8_t uline:1;
-    uint8_t blink:1;
-    uint8_t invers:1;
-    uint8_t unvisible:1;
-} TextAttributes;
-
-#define TEXT_ATTRIBUTES_DEFAULT ((TextAttributes) { \
-    .fgcol = QEMU_COLOR_WHITE,                      \
-    .bgcol = QEMU_COLOR_BLACK                       \
-})
-
-typedef struct TextCell {
-    uint8_t ch;
-    TextAttributes t_attrib;
-} TextCell;
-
-#define MAX_ESC_PARAMS 3
-
-enum TTYState {
-    TTY_STATE_NORM,
-    TTY_STATE_ESC,
-    TTY_STATE_CSI,
-    TTY_STATE_G0,
-    TTY_STATE_G1,
-    TTY_STATE_OSC,
-};
-
-typedef struct QemuVT100 QemuVT100;
-
-struct QemuVT100 {
-    pixman_image_t *image;
-    void (*image_update)(QemuVT100 *vt, int x, int y, int width, int height);
-
-    int width;
-    int height;
-    int total_height;
-    int backscroll_height;
-    int x, y;
-    int y_displayed;
-    int y_base;
-    TextCell *cells;
-    int text_x[2], text_y[2], cursor_invalidate;
-    int echo;
-
-    int update_x0;
-    int update_y0;
-    int update_x1;
-    int update_y1;
-
-    enum TTYState state;
-    int esc_params[MAX_ESC_PARAMS];
-    int nb_esc_params;
-    uint32_t utf8_state;     /* UTF-8 DFA decoder state */
-    uint32_t utf8_codepoint; /* accumulated UTF-8 code point */
-    TextAttributes t_attrib; /* currently active text attributes */
-    TextAttributes t_attrib_saved;
-    int x_saved, y_saved;
-    /* fifo for key pressed */
-    Fifo8 out_fifo;
-    void (*out_flush)(QemuVT100 *vt);
-
-    QTAILQ_ENTRY(QemuVT100) list;
-};
-
-static QTAILQ_HEAD(QemuVT100Head, QemuVT100) vt100s =
-    QTAILQ_HEAD_INITIALIZER(vt100s);
-
 typedef struct QemuTextConsole {
     QemuConsole parent;
 
@@ -116,32 +40,6 @@ struct VCChardev {
 };
 typedef struct VCChardev VCChardev;
 
-static const pixman_color_t color_table_rgb[2][8] = {
-    {   /* dark */
-        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
-        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xaa),  /* blue */
-        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0x00),  /* green */
-        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0xaa),  /* cyan */
-        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0x00),  /* red */
-        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0xaa),  /* magenta */
-        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xaa, 0xaa, 0x00),  /* yellow */
-        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR_GRAY,
-    },
-    {   /* bright */
-        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
-        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xff),  /* blue */
-        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xff, 0x00),  /* green */
-        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xff, 0xff),  /* cyan */
-        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xff, 0x00, 0x00),  /* red */
-        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xff, 0x00, 0xff),  /* magenta */
-        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xff, 0xff, 0x00),  /* yellow */
-        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR(0xff, 0xff, 0xff),  /* white */
-    }
-};
-
-static bool cursor_visible_phase;
-static QEMUTimer *cursor_timer;
-
 static char *
 qemu_text_console_get_label(QemuConsole *c)
 {
@@ -150,157 +48,6 @@ qemu_text_console_get_label(QemuConsole *c)
     return tc->chr ? g_strdup(tc->chr->label) : NULL;
 }
 
-static void image_fill_rect(pixman_image_t *image, int posx, int posy,
-                            int width, int height, pixman_color_t color)
-{
-    pixman_rectangle16_t rect = {
-        .x = posx, .y = posy, .width = width, .height = height
-    };
-
-    pixman_image_fill_rectangles(PIXMAN_OP_SRC, image, &color, 1, &rect);
-}
-
-/* copy from (xs, ys) to (xd, yd) a rectangle of size (w, h) */
-static void image_bitblt(pixman_image_t *image,
-                         int xs, int ys, int xd, int yd, int w, int h)
-{
-    pixman_image_composite(PIXMAN_OP_SRC,
-                           image, NULL, image,
-                           xs, ys, 0, 0, xd, yd, w, h);
-}
-
-static void vt100_putcharxy(QemuVT100 *vt, int x, int y, int ch,
-                            TextAttributes *t_attrib)
-{
-    static pixman_image_t *glyphs[256];
-    pixman_color_t fgcol, bgcol;
-
-    assert(vt->image);
-    if (t_attrib->invers) {
-        bgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
-        fgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
-    } else {
-        fgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
-        bgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
-    }
-
-    if (!glyphs[ch]) {
-        glyphs[ch] = qemu_pixman_glyph_from_vgafont(FONT_HEIGHT, vgafont16, ch);
-    }
-    qemu_pixman_glyph_render(glyphs[ch], vt->image,
-                             &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
-}
-
-static void vt100_invalidate_xy(QemuVT100 *vt, int x, int y)
-{
-    if (vt->update_x0 > x * FONT_WIDTH) {
-        vt->update_x0 = x * FONT_WIDTH;
-    }
-    if (vt->update_y0 > y * FONT_HEIGHT) {
-        vt->update_y0 = y * FONT_HEIGHT;
-    }
-    if (vt->update_x1 < (x + 1) * FONT_WIDTH) {
-        vt->update_x1 = (x + 1) * FONT_WIDTH;
-    }
-    if (vt->update_y1 < (y + 1) * FONT_HEIGHT) {
-        vt->update_y1 = (y + 1) * FONT_HEIGHT;
-    }
-}
-
-static void vt100_show_cursor(QemuVT100 *vt, int show)
-{
-    TextCell *c;
-    int y, y1;
-    int x = vt->x;
-
-    vt->cursor_invalidate = 1;
-
-    if (x >= vt->width) {
-        x = vt->width - 1;
-    }
-    y1 = (vt->y_base + vt->y) % vt->total_height;
-    y = y1 - vt->y_displayed;
-    if (y < 0) {
-        y += vt->total_height;
-    }
-    if (y < vt->height) {
-        c = &vt->cells[y1 * vt->width + x];
-        if (show && cursor_visible_phase) {
-            TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-            t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
-            vt100_putcharxy(vt, x, y, c->ch, &t_attrib);
-        } else {
-            vt100_putcharxy(vt, x, y, c->ch, &(c->t_attrib));
-        }
-        vt100_invalidate_xy(vt, x, y);
-    }
-}
-
-static void vt100_image_update(QemuVT100 *vt, int x, int y, int width, int height)
-{
-    vt->image_update(vt, x, y, width, height);
-}
-
-static void vt100_refresh(QemuVT100 *vt)
-{
-    TextCell *c;
-    int x, y, y1;
-    int w = pixman_image_get_width(vt->image);
-    int h = pixman_image_get_height(vt->image);
-
-    vt->text_x[0] = 0;
-    vt->text_y[0] = 0;
-    vt->text_x[1] = vt->width - 1;
-    vt->text_y[1] = vt->height - 1;
-    vt->cursor_invalidate = 1;
-
-    image_fill_rect(vt->image, 0, 0, w, h,
-                    color_table_rgb[0][QEMU_COLOR_BLACK]);
-    y1 = vt->y_displayed;
-    for (y = 0; y < vt->height; y++) {
-        c = vt->cells + y1 * vt->width;
-        for (x = 0; x < vt->width; x++) {
-            vt100_putcharxy(vt, x, y, c->ch,
-                          &(c->t_attrib));
-            c++;
-        }
-        if (++y1 == vt->total_height) {
-            y1 = 0;
-        }
-    }
-    vt100_show_cursor(vt, 1);
-    vt100_image_update(vt, 0, 0, w, h);
-}
-
-static void vt100_scroll(QemuVT100 *vt, int ydelta)
-{
-    int i, y1;
-
-    if (ydelta > 0) {
-        for(i = 0; i < ydelta; i++) {
-            if (vt->y_displayed == vt->y_base)
-                break;
-            if (++vt->y_displayed == vt->total_height)
-                vt->y_displayed = 0;
-        }
-    } else {
-        ydelta = -ydelta;
-        i = vt->backscroll_height;
-        if (i > vt->total_height - vt->height)
-            i = vt->total_height - vt->height;
-        y1 = vt->y_base - i;
-        if (y1 < 0)
-            y1 += vt->total_height;
-        for(i = 0; i < ydelta; i++) {
-            if (vt->y_displayed == y1)
-                break;
-            if (--vt->y_displayed < 0)
-                vt->y_displayed = vt->total_height - 1;
-        }
-    }
-    vt100_refresh(vt);
-}
-
 static void qemu_text_console_out_flush(QemuTextConsole *s)
 {
     uint32_t len, avail;
@@ -318,64 +65,6 @@ static void qemu_text_console_out_flush(QemuTextConsole *s)
     }
 }
 
-static void vt100_write(QemuVT100 *vt, const void *buf, size_t len)
-{
-    uint32_t num_free;
-
-    num_free = fifo8_num_free(&vt->out_fifo);
-    fifo8_push_all(&vt->out_fifo, buf, MIN(num_free, len));
-    vt->out_flush(vt);
-}
-
-static int vt100_input(QemuVT100 *vt, const uint8_t *buf, int len);
-
-static void vt100_keysym(QemuVT100 *vt, int keysym)
-{
-    uint8_t buf[16], *q;
-    int c;
-
-    switch(keysym) {
-    case QEMU_KEY_CTRL_UP:
-        vt100_scroll(vt, -1);
-        break;
-    case QEMU_KEY_CTRL_DOWN:
-        vt100_scroll(vt, 1);
-        break;
-    case QEMU_KEY_CTRL_PAGEUP:
-        vt100_scroll(vt, -10);
-        break;
-    case QEMU_KEY_CTRL_PAGEDOWN:
-        vt100_scroll(vt, 10);
-        break;
-    default:
-        /* convert the QEMU keysym to VT100 key string */
-        q = buf;
-        if (keysym >= 0xe100 && keysym <= 0xe11f) {
-            *q++ = '\033';
-            *q++ = '[';
-            c = keysym - 0xe100;
-            if (c >= 10)
-                *q++ = '0' + (c / 10);
-            *q++ = '0' + (c % 10);
-            *q++ = '~';
-        } else if (keysym >= 0xe120 && keysym <= 0xe17f) {
-            *q++ = '\033';
-            *q++ = '[';
-            *q++ = keysym & 0xff;
-        } else if (vt->echo && (keysym == '\r' || keysym == '\n')) {
-            vt100_input(vt, (uint8_t *)"\r", 1);
-            *q++ = '\n';
-        } else {
-            *q++ = keysym;
-        }
-        if (vt->echo) {
-            vt100_input(vt, buf, q - buf);
-        }
-        vt100_write(vt, buf, q - buf);
-        break;
-    }
-
-}
 /* called when an ascii key is pressed */
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 {
@@ -410,682 +99,10 @@ static void text_console_update(void *opaque, uint32_t *chardata)
     }
 }
 
-static void vt100_set_image(QemuVT100 *vt, pixman_image_t *image)
-{
-    TextCell *cells, *c, *c1;
-    int w1, x, y, last_width, w, h;
-
-    vt->image = image;
-    w = pixman_image_get_width(image) / FONT_WIDTH;
-    h = pixman_image_get_height(image) / FONT_HEIGHT;
-    if (w == vt->width && h == vt->height) {
-        return;
-    }
-
-    last_width = vt->width;
-    vt->width = w;
-    vt->height = h;
-
-    w1 = MIN(vt->width, last_width);
-
-    cells = g_new(TextCell, vt->width * vt->total_height + 1);
-    for (y = 0; y < vt->total_height; y++) {
-        c = &cells[y * vt->width];
-        if (w1 > 0) {
-            c1 = &vt->cells[y * last_width];
-            for (x = 0; x < w1; x++) {
-                *c++ = *c1++;
-            }
-        }
-        for (x = w1; x < vt->width; x++) {
-            c->ch = ' ';
-            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-            c++;
-        }
-    }
-    g_free(vt->cells);
-    vt->cells = cells;
-}
-
-static void vt100_put_lf(QemuVT100 *vt)
-{
-    TextCell *c;
-    int x, y1;
-
-    vt->y++;
-    if (vt->y >= vt->height) {
-        vt->y = vt->height - 1;
-
-        if (vt->y_displayed == vt->y_base) {
-            if (++vt->y_displayed == vt->total_height)
-                vt->y_displayed = 0;
-        }
-        if (++vt->y_base == vt->total_height)
-            vt->y_base = 0;
-        if (vt->backscroll_height < vt->total_height)
-            vt->backscroll_height++;
-        y1 = (vt->y_base + vt->height - 1) % vt->total_height;
-        c = &vt->cells[y1 * vt->width];
-        for(x = 0; x < vt->width; x++) {
-            c->ch = ' ';
-            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-            c++;
-        }
-        if (vt->y_displayed == vt->y_base) {
-            vt->text_x[0] = 0;
-            vt->text_y[0] = 0;
-            vt->text_x[1] = vt->width - 1;
-            vt->text_y[1] = vt->height - 1;
-
-            image_bitblt(vt->image, 0, FONT_HEIGHT, 0, 0,
-                         vt->width * FONT_WIDTH,
-                         (vt->height - 1) * FONT_HEIGHT);
-            image_fill_rect(vt->image, 0, (vt->height - 1) * FONT_HEIGHT,
-                            vt->width * FONT_WIDTH, FONT_HEIGHT,
-                            color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
-            vt->update_x0 = 0;
-            vt->update_y0 = 0;
-            vt->update_x1 = vt->width * FONT_WIDTH;
-            vt->update_y1 = vt->height * FONT_HEIGHT;
-        }
-    }
-}
-
-/* Set console attributes depending on the current escape codes.
- * NOTE: I know this code is not very efficient (checking every color for it
- * self) but it is more readable and better maintainable.
- */
-static void vt100_handle_escape(QemuVT100 *vt)
-{
-    int i;
-
-    for (i = 0; i < vt->nb_esc_params; i++) {
-        switch (vt->esc_params[i]) {
-            case 0: /* reset all console attributes to default */
-                vt->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-                break;
-            case 1:
-                vt->t_attrib.bold = 1;
-                break;
-            case 4:
-                vt->t_attrib.uline = 1;
-                break;
-            case 5:
-                vt->t_attrib.blink = 1;
-                break;
-            case 7:
-                vt->t_attrib.invers = 1;
-                break;
-            case 8:
-                vt->t_attrib.unvisible = 1;
-                break;
-            case 22:
-                vt->t_attrib.bold = 0;
-                break;
-            case 24:
-                vt->t_attrib.uline = 0;
-                break;
-            case 25:
-                vt->t_attrib.blink = 0;
-                break;
-            case 27:
-                vt->t_attrib.invers = 0;
-                break;
-            case 28:
-                vt->t_attrib.unvisible = 0;
-                break;
-            /* set foreground color */
-            case 30:
-                vt->t_attrib.fgcol = QEMU_COLOR_BLACK;
-                break;
-            case 31:
-                vt->t_attrib.fgcol = QEMU_COLOR_RED;
-                break;
-            case 32:
-                vt->t_attrib.fgcol = QEMU_COLOR_GREEN;
-                break;
-            case 33:
-                vt->t_attrib.fgcol = QEMU_COLOR_YELLOW;
-                break;
-            case 34:
-                vt->t_attrib.fgcol = QEMU_COLOR_BLUE;
-                break;
-            case 35:
-                vt->t_attrib.fgcol = QEMU_COLOR_MAGENTA;
-                break;
-            case 36:
-                vt->t_attrib.fgcol = QEMU_COLOR_CYAN;
-                break;
-            case 37:
-                vt->t_attrib.fgcol = QEMU_COLOR_WHITE;
-                break;
-            /* set background color */
-            case 40:
-                vt->t_attrib.bgcol = QEMU_COLOR_BLACK;
-                break;
-            case 41:
-                vt->t_attrib.bgcol = QEMU_COLOR_RED;
-                break;
-            case 42:
-                vt->t_attrib.bgcol = QEMU_COLOR_GREEN;
-                break;
-            case 43:
-                vt->t_attrib.bgcol = QEMU_COLOR_YELLOW;
-                break;
-            case 44:
-                vt->t_attrib.bgcol = QEMU_COLOR_BLUE;
-                break;
-            case 45:
-                vt->t_attrib.bgcol = QEMU_COLOR_MAGENTA;
-                break;
-            case 46:
-                vt->t_attrib.bgcol = QEMU_COLOR_CYAN;
-                break;
-            case 47:
-                vt->t_attrib.bgcol = QEMU_COLOR_WHITE;
-                break;
-        }
-    }
-}
-
-static void vt100_update_xy(QemuVT100 *vt, int x, int y)
-{
-    TextCell *c;
-    int y1, y2;
-
-    vt->text_x[0] = MIN(vt->text_x[0], x);
-    vt->text_x[1] = MAX(vt->text_x[1], x);
-    vt->text_y[0] = MIN(vt->text_y[0], y);
-    vt->text_y[1] = MAX(vt->text_y[1], y);
-
-    y1 = (vt->y_base + y) % vt->total_height;
-    y2 = y1 - vt->y_displayed;
-    if (y2 < 0) {
-        y2 += vt->total_height;
-    }
-    if (y2 < vt->height) {
-        if (x >= vt->width) {
-            x = vt->width - 1;
-        }
-        c = &vt->cells[y1 * vt->width + x];
-        vt100_putcharxy(vt, x, y2, c->ch,
-                      &(c->t_attrib));
-        vt100_invalidate_xy(vt, x, y2);
-    }
-}
-
-static void vt100_clear_xy(QemuVT100 *vt, int x, int y)
-{
-    int y1 = (vt->y_base + y) % vt->total_height;
-    if (x >= vt->width) {
-        x = vt->width - 1;
-    }
-    TextCell *c = &vt->cells[y1 * vt->width + x];
-    c->ch = ' ';
-    c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    vt100_update_xy(vt, x, y);
-}
-
-/*
- * UTF-8 DFA decoder by Bjoern Hoehrmann.
- * Copyright (c) 2008-2010 Bjoern Hoehrmann <bjoern@hoehrmann.de>
- * See https://github.com/polijan/utf8_decode for details.
- *
- * SPDX-License-Identifier: MIT
- */
-#define UTF8_ACCEPT 0
-#define UTF8_REJECT 12
-
-static const uint8_t utf8d[] = {
-    /* character class lookup */
-    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
-    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
-    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
-    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
-    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,
-    7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,  7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
-    8,8,2,2,2,2,2,2,2,2,2,2,2,2,2,2,  2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
-   10,3,3,3,3,3,3,3,3,3,3,3,3,4,3,3, 11,6,6,6,5,8,8,8,8,8,8,8,8,8,8,8,
-
-    /* state transition lookup */
-     0,12,24,36,60,96,84,12,12,12,48,72, 12,12,12,12,12,12,12,12,12,12,12,12,
-    12, 0,12,12,12,12,12, 0,12, 0,12,12, 12,24,12,12,12,12,12,24,12,24,12,12,
-    12,12,12,12,12,12,12,24,12,12,12,12, 12,24,12,12,12,12,12,12,12,24,12,12,
-    12,12,12,12,12,12,12,36,12,36,12,12, 12,36,12,12,12,12,12,36,12,36,12,12,
-    12,36,12,12,12,12,12,12,12,12,12,12,
-};
-
-static uint32_t utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
-{
-    uint32_t type = utf8d[byte];
-
-    *codep = (*state != UTF8_ACCEPT) ?
-        (byte & 0x3fu) | (*codep << 6) :
-        (0xffu >> type) & (byte);
-
-    *state = utf8d[256 + *state + type];
-    return *state;
-}
-
-static void vt100_put_one(QemuVT100 *vt, int ch)
-{
-    TextCell *c;
-    int y1;
-    if (vt->x >= vt->width) {
-        /* line wrap */
-        vt->x = 0;
-        vt100_put_lf(vt);
-    }
-    y1 = (vt->y_base + vt->y) % vt->total_height;
-    c = &vt->cells[y1 * vt->width + vt->x];
-    c->ch = ch;
-    c->t_attrib = vt->t_attrib;
-    vt100_update_xy(vt, vt->x, vt->y);
-    vt->x++;
-}
-
-/* set cursor, checking bounds */
-static void vt100_set_cursor(QemuVT100 *vt, int x, int y)
-{
-    if (x < 0) {
-        x = 0;
-    }
-    if (y < 0) {
-        y = 0;
-    }
-    if (y >= vt->height) {
-        y = vt->height - 1;
-    }
-    if (x >= vt->width) {
-        x = vt->width - 1;
-    }
-
-    vt->x = x;
-    vt->y = y;
-}
-
-/**
- * vc_csi_P() - (DCH) deletes one or more characters from the cursor
- * position to the right. As characters are deleted, the remaining
- * characters between the cursor and right margin move to the
- * left. Character attributes move with the characters.
- */
-static void vt100_csi_P(QemuVT100 *vt, unsigned int nr)
-{
-    TextCell *c1, *c2;
-    unsigned int x1, x2, y;
-    unsigned int end, len;
-
-    if (!nr) {
-        nr = 1;
-    }
-    if (nr > vt->width - vt->x) {
-        nr = vt->width - vt->x;
-        if (!nr) {
-            return;
-        }
-    }
-
-    x1 = vt->x;
-    x2 = vt->x + nr;
-    len = vt->width - x2;
-    if (len) {
-        y = (vt->y_base + vt->y) % vt->total_height;
-        c1 = &vt->cells[y * vt->width + x1];
-        c2 = &vt->cells[y * vt->width + x2];
-        memmove(c1, c2, len * sizeof(*c1));
-        for (end = x1 + len; x1 < end; x1++) {
-            vt100_update_xy(vt, x1, vt->y);
-        }
-    }
-    /* Clear the rest */
-    for (; x1 < vt->width; x1++) {
-        vt100_clear_xy(vt, x1, vt->y);
-    }
-}
-
-/**
- * vc_csi_at() - (ICH) inserts `nr` blank characters with the default
- * character attribute. The cursor remains at the beginning of the
- * blank characters. Text between the cursor and right margin moves to
- * the right. Characters scrolled past the right margin are lost.
- */
-static void vt100_csi_at(QemuVT100 *vt, unsigned int nr)
-{
-    TextCell *c1, *c2;
-    unsigned int x1, x2, y;
-    unsigned int end, len;
-
-    if (!nr) {
-        nr = 1;
-    }
-    if (nr > vt->width - vt->x) {
-        nr = vt->width - vt->x;
-        if (!nr) {
-            return;
-        }
-    }
-
-    x1 = vt->x + nr;
-    x2 = vt->x;
-    len = vt->width - x1;
-    if (len) {
-        y = (vt->y_base + vt->y) % vt->total_height;
-        c1 = &vt->cells[y * vt->width + x1];
-        c2 = &vt->cells[y * vt->width + x2];
-        memmove(c1, c2, len * sizeof(*c1));
-        for (end = x1 + len; x1 < end; x1++) {
-            vt100_update_xy(vt, x1, vt->y);
-        }
-    }
-    /* Insert blanks */
-    for (x1 = vt->x; x1 < vt->x + nr; x1++) {
-        vt100_clear_xy(vt, x1, vt->y);
-    }
-}
-
-/**
- * vt100_save_cursor() - saves cursor position and character attributes.
- */
-static void vt100_save_cursor(QemuVT100 *vt)
-{
-    vt->x_saved = vt->x;
-    vt->y_saved = vt->y;
-    vt->t_attrib_saved = vt->t_attrib;
-}
-
-/**
- * vt100_restore_cursor() - restores cursor position and character
- * attributes from saved state.
- */
-static void vt100_restore_cursor(QemuVT100 *vt)
-{
-    vt->x = vt->x_saved;
-    vt->y = vt->y_saved;
-    vt->t_attrib = vt->t_attrib_saved;
-}
-
-static void vt100_putchar(QemuVT100 *vt, int ch)
-{
-    int i;
-    int x, y;
-    g_autofree char *response = NULL;
-
-    switch (vt->state) {
-    case TTY_STATE_NORM:
-        /* Feed byte through the UTF-8 DFA decoder */
-        if (ch >= 0x80) {
-            switch (utf8_decode(&vt->utf8_state, &vt->utf8_codepoint, ch)) {
-            case UTF8_ACCEPT:
-                vt100_put_one(vt, unicode_to_cp437(vt->utf8_codepoint));
-                break;
-            case UTF8_REJECT:
-                /* Reset state so the decoder can resync */
-                vt->utf8_state = UTF8_ACCEPT;
-                break;
-            default:
-                /* Need more bytes */
-                break;
-            }
-            break;
-        }
-        /* ASCII byte: abort any pending UTF-8 sequence */
-        vt->utf8_state = UTF8_ACCEPT;
-        switch(ch) {
-        case '\r':  /* carriage return */
-            vt->x = 0;
-            break;
-        case '\n':  /* newline */
-            vt100_put_lf(vt);
-            break;
-        case '\b':  /* backspace */
-            if (vt->x > 0)
-                vt->x--;
-            break;
-        case '\t':  /* tabspace */
-            if (vt->x + (8 - (vt->x % 8)) > vt->width) {
-                vt->x = 0;
-                vt100_put_lf(vt);
-            } else {
-                vt->x = vt->x + (8 - (vt->x % 8));
-            }
-            break;
-        case '\a':  /* alert aka. bell */
-            /* TODO: has to be implemented */
-            break;
-        case 14:
-            /* SO (shift out), character set 1 (ignored) */
-            break;
-        case 15:
-            /* SI (shift in), character set 0 (ignored) */
-            break;
-        case 27:    /* esc (introducing an escape sequence) */
-            vt->state = TTY_STATE_ESC;
-            break;
-        default:
-            vt100_put_one(vt, ch);
-            break;
-        }
-        break;
-    case TTY_STATE_ESC: /* check if it is a terminal escape sequence */
-        if (ch == '[') {
-            for(i=0;i<MAX_ESC_PARAMS;i++)
-                vt->esc_params[i] = 0;
-            vt->nb_esc_params = 0;
-            vt->state = TTY_STATE_CSI;
-        } else if (ch == '(') {
-            vt->state = TTY_STATE_G0;
-        } else if (ch == ')') {
-            vt->state = TTY_STATE_G1;
-        } else if (ch == ']' || ch == 'P' || ch == 'X'
-                   || ch == '^' || ch == '_') {
-            /* String sequences: OSC, DCS, SOS, PM, APC */
-            vt->state = TTY_STATE_OSC;
-        } else if (ch == '7') {
-            vt100_save_cursor(vt);
-            vt->state = TTY_STATE_NORM;
-        } else if (ch == '8') {
-            vt100_restore_cursor(vt);
-            vt->state = TTY_STATE_NORM;
-        } else {
-            vt->state = TTY_STATE_NORM;
-        }
-        break;
-    case TTY_STATE_CSI: /* handle escape sequence parameters */
-        if (ch >= '0' && ch <= '9') {
-            if (vt->nb_esc_params < MAX_ESC_PARAMS) {
-                int *param = &vt->esc_params[vt->nb_esc_params];
-                int digit = (ch - '0');
-
-                *param = (*param <= (INT_MAX - digit) / 10) ?
-                         *param * 10 + digit : INT_MAX;
-            }
-        } else {
-            if (vt->nb_esc_params < MAX_ESC_PARAMS)
-                vt->nb_esc_params++;
-            if (ch == ';' || ch == '?') {
-                break;
-            }
-            trace_console_putchar_csi(vt->esc_params[0], vt->esc_params[1],
-                                      ch, vt->nb_esc_params);
-            vt->state = TTY_STATE_NORM;
-            switch(ch) {
-            case 'A':
-                /* move cursor up */
-                if (vt->esc_params[0] == 0) {
-                    vt->esc_params[0] = 1;
-                }
-                vt100_set_cursor(vt, vt->x, vt->y - vt->esc_params[0]);
-                break;
-            case 'B':
-                /* move cursor down */
-                if (vt->esc_params[0] == 0) {
-                    vt->esc_params[0] = 1;
-                }
-                vt100_set_cursor(vt, vt->x, vt->y + vt->esc_params[0]);
-                break;
-            case 'C':
-                /* move cursor right */
-                if (vt->esc_params[0] == 0) {
-                    vt->esc_params[0] = 1;
-                }
-                vt100_set_cursor(vt, vt->x + vt->esc_params[0], vt->y);
-                break;
-            case 'D':
-                /* move cursor left */
-                if (vt->esc_params[0] == 0) {
-                    vt->esc_params[0] = 1;
-                }
-                vt100_set_cursor(vt, vt->x - vt->esc_params[0], vt->y);
-                break;
-            case 'G':
-                /* move cursor to column */
-                vt100_set_cursor(vt, vt->esc_params[0] - 1, vt->y);
-                break;
-            case 'f':
-            case 'H':
-                /* move cursor to row, column */
-                vt100_set_cursor(vt, vt->esc_params[1] - 1, vt->esc_params[0] - 1);
-                break;
-            case 'J':
-                switch (vt->esc_params[0]) {
-                case 0:
-                    /* clear to end of screen */
-                    for (y = vt->y; y < vt->height; y++) {
-                        for (x = 0; x < vt->width; x++) {
-                            if (y == vt->y && x < vt->x) {
-                                continue;
-                            }
-                            vt100_clear_xy(vt, x, y);
-                        }
-                    }
-                    break;
-                case 1:
-                    /* clear from beginning of screen */
-                    for (y = 0; y <= vt->y; y++) {
-                        for (x = 0; x < vt->width; x++) {
-                            if (y == vt->y && x > vt->x) {
-                                break;
-                            }
-                            vt100_clear_xy(vt, x, y);
-                        }
-                    }
-                    break;
-                case 2:
-                    /* clear entire screen */
-                    for (y = 0; y < vt->height; y++) {
-                        for (x = 0; x < vt->width; x++) {
-                            vt100_clear_xy(vt, x, y);
-                        }
-                    }
-                    break;
-                }
-                break;
-            case 'K':
-                switch (vt->esc_params[0]) {
-                case 0:
-                    /* clear to eol */
-                    for(x = vt->x; x < vt->width; x++) {
-                        vt100_clear_xy(vt, x, vt->y);
-                    }
-                    break;
-                case 1:
-                    /* clear from beginning of line */
-                    for (x = 0; x <= vt->x && x < vt->width; x++) {
-                        vt100_clear_xy(vt, x, vt->y);
-                    }
-                    break;
-                case 2:
-                    /* clear entire line */
-                    for(x = 0; x < vt->width; x++) {
-                        vt100_clear_xy(vt, x, vt->y);
-                    }
-                    break;
-                }
-                break;
-            case 'P':
-                vt100_csi_P(vt, vt->esc_params[0]);
-                break;
-            case 'm':
-                vt100_handle_escape(vt);
-                break;
-            case 'n':
-                switch (vt->esc_params[0]) {
-                case 5:
-                    /* report console status (always succeed)*/
-                    vt100_write(vt, "\033[0n", 4);
-                    break;
-                case 6:
-                    /* report cursor position */
-                    response = g_strdup_printf("\033[%d;%dR",
-                                               vt->y + 1, vt->x + 1);
-                    vt100_write(vt, response, strlen(response));
-                    break;
-                }
-                break;
-            case 's':
-                vt100_save_cursor(vt);
-                break;
-            case 'u':
-                vt100_restore_cursor(vt);
-                break;
-            case '@':
-                vt100_csi_at(vt, vt->esc_params[0]);
-                break;
-            default:
-                trace_console_putchar_unhandled(ch);
-                break;
-            }
-            break;
-        }
-        break;
-    case TTY_STATE_OSC: /* Operating System Command: ESC ] ... BEL/ST */
-        if (ch == '\a') {
-            /* BEL terminates OSC */
-            vt->state = TTY_STATE_NORM;
-        } else if (ch == 27) {
-            /* ESC might start ST (ESC \) */
-            vt->state = TTY_STATE_ESC;
-        }
-        /* All other bytes are silently consumed */
-        break;
-    case TTY_STATE_G0: /* set character sets */
-    case TTY_STATE_G1: /* set character sets */
-        switch (ch) {
-        case 'B':
-            /* Latin-1 map */
-            break;
-        }
-        vt->state = TTY_STATE_NORM;
-        break;
-    }
-}
-
 #define TYPE_CHARDEV_VC "chardev-vc"
 DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
                          TYPE_CHARDEV_VC)
 
-static int vt100_input(QemuVT100 *vt, const uint8_t *buf, int len)
-{
-    int i;
-
-    vt->update_x0 = vt->width * FONT_WIDTH;
-    vt->update_y0 = vt->height * FONT_HEIGHT;
-    vt->update_x1 = 0;
-    vt->update_y1 = 0;
-    vt100_show_cursor(vt, 0);
-    for(i = 0; i < len; i++) {
-        vt100_putchar(vt, buf[i]);
-    }
-    vt100_show_cursor(vt, 1);
-    if (vt->update_x0 < vt->update_x1) {
-        vt100_image_update(vt, vt->update_x0, vt->update_y0,
-                           vt->update_x1 - vt->update_x0,
-                           vt->update_y1 - vt->update_y0);
-    }
-    return len;
-}
-
 static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     VCChardev *drv = VC_CHARDEV(chr);
@@ -1094,30 +111,6 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return vt100_input(&s->vt, buf, len);
 }
 
-void vt100_update_cursor(void)
-{
-    QemuVT100 *vt;
-
-    cursor_visible_phase = !cursor_visible_phase;
-
-    if (QTAILQ_EMPTY(&vt100s)) {
-        return;
-    }
-
-    QTAILQ_FOREACH(vt, &vt100s, list) {
-        vt100_refresh(vt);
-    }
-
-    timer_mod(cursor_timer,
-        qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + CONSOLE_CURSOR_PERIOD / 2);
-}
-
-static void
-cursor_timer_cb(void *opaque)
-{
-    vt100_update_cursor();
-}
-
 static void text_console_invalidate(void *opaque)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
@@ -1128,13 +121,6 @@ static void text_console_invalidate(void *opaque)
     vt100_refresh(&s->vt);
 }
 
-static void vt100_fini(QemuVT100 *vt)
-{
-    QTAILQ_REMOVE(&vt100s, vt, list);
-    fifo8_destroy(&vt->out_fifo);
-    g_free(vt->cells);
-}
-
 static void
 qemu_text_console_finalize(Object *obj)
 {
@@ -1213,25 +199,6 @@ static void text_console_out_flush(QemuVT100 *vt)
     qemu_text_console_out_flush(console);
 }
 
-static void vt100_init(QemuVT100 *vt,
-                       pixman_image_t *image,
-                       void (*image_update)(QemuVT100 *vt, int x, int y, int w, int h),
-                       void (*out_flush)(QemuVT100 *vt))
-{
-    if (!cursor_timer) {
-        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
-    }
-
-    QTAILQ_INSERT_HEAD(&vt100s, vt, list);
-    fifo8_create(&vt->out_fifo, 16);
-    vt->total_height = DEFAULT_BACKSCROLL;
-    vt->image_update = image_update;
-    vt->out_flush = out_flush;
-    /* set current text attributes to default */
-    vt->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    vt100_set_image(vt, image);
-}
-
 static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
diff --git a/ui/console.c b/ui/console.c
index c997e8df572..7ffea2776ef 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -39,6 +39,8 @@
 #include "system/memory.h"
 #include "qom/object.h"
 #include "qemu/memfd.h"
+#include "ui/vt100.h"
+#include "vgafont.h"
 
 #include "console-priv.h"
 
diff --git a/ui/vt100.c b/ui/vt100.c
new file mode 100644
index 00000000000..e24c91f538c
--- /dev/null
+++ b/ui/vt100.c
@@ -0,0 +1,987 @@
+/*
+ * SPDX-License-Identifier: MIT
+ * QEMU vt100
+ */
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "cp437.h"
+#include "vgafont.h"
+#include "vt100.h"
+
+#include "trace.h"
+
+#define DEFAULT_BACKSCROLL 512
+#define CONSOLE_CURSOR_PERIOD 500
+
+static const pixman_color_t color_table_rgb[2][8] = {
+    {   /* dark */
+        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
+        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xaa),  /* blue */
+        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0x00),  /* green */
+        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0xaa),  /* cyan */
+        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0x00),  /* red */
+        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0xaa),  /* magenta */
+        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xaa, 0xaa, 0x00),  /* yellow */
+        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR_GRAY,
+    },
+    {   /* bright */
+        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
+        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xff),  /* blue */
+        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xff, 0x00),  /* green */
+        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xff, 0xff),  /* cyan */
+        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xff, 0x00, 0x00),  /* red */
+        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xff, 0x00, 0xff),  /* magenta */
+        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xff, 0xff, 0x00),  /* yellow */
+        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR(0xff, 0xff, 0xff),  /* white */
+    }
+};
+
+static bool cursor_visible_phase;
+static QEMUTimer *cursor_timer;
+static QTAILQ_HEAD(QemuVT100Head, QemuVT100) vt100s =
+    QTAILQ_HEAD_INITIALIZER(vt100s);
+
+static void image_fill_rect(pixman_image_t *image, int posx, int posy,
+                            int width, int height, pixman_color_t color)
+{
+    pixman_rectangle16_t rect = {
+        .x = posx, .y = posy, .width = width, .height = height
+    };
+
+    pixman_image_fill_rectangles(PIXMAN_OP_SRC, image,
+                                 &color, 1, &rect);
+}
+
+/* copy from (xs, ys) to (xd, yd) a rectangle of size (w, h) */
+static void image_bitblt(pixman_image_t *image,
+                         int xs, int ys, int xd, int yd, int w, int h)
+{
+    pixman_image_composite(PIXMAN_OP_SRC,
+                           image, NULL, image,
+                           xs, ys, 0, 0, xd, yd, w, h);
+}
+
+static void vt100_putcharxy(QemuVT100 *vt, int x, int y, int ch,
+                            TextAttributes *t_attrib)
+{
+    static pixman_image_t *glyphs[256];
+    pixman_color_t fgcol, bgcol;
+
+    assert(vt->image);
+    if (t_attrib->invers) {
+        bgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
+        fgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
+    } else {
+        fgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
+        bgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
+    }
+
+    if (!glyphs[ch]) {
+        glyphs[ch] = qemu_pixman_glyph_from_vgafont(FONT_HEIGHT, vgafont16, ch);
+    }
+    qemu_pixman_glyph_render(glyphs[ch], vt->image,
+                             &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
+}
+
+static void vt100_invalidate_xy(QemuVT100 *vt, int x, int y)
+{
+    if (vt->update_x0 > x * FONT_WIDTH) {
+        vt->update_x0 = x * FONT_WIDTH;
+    }
+    if (vt->update_y0 > y * FONT_HEIGHT) {
+        vt->update_y0 = y * FONT_HEIGHT;
+    }
+    if (vt->update_x1 < (x + 1) * FONT_WIDTH) {
+        vt->update_x1 = (x + 1) * FONT_WIDTH;
+    }
+    if (vt->update_y1 < (y + 1) * FONT_HEIGHT) {
+        vt->update_y1 = (y + 1) * FONT_HEIGHT;
+    }
+}
+
+static void vt100_show_cursor(QemuVT100 *vt, int show)
+{
+    TextCell *c;
+    int y, y1;
+    int x = vt->x;
+
+    vt->cursor_invalidate = 1;
+
+    if (x >= vt->width) {
+        x = vt->width - 1;
+    }
+    y1 = (vt->y_base + vt->y) % vt->total_height;
+    y = y1 - vt->y_displayed;
+    if (y < 0) {
+        y += vt->total_height;
+    }
+    if (y < vt->height) {
+        c = &vt->cells[y1 * vt->width + x];
+        if (show && cursor_visible_phase) {
+            TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+            t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
+            vt100_putcharxy(vt, x, y, c->ch, &t_attrib);
+        } else {
+            vt100_putcharxy(vt, x, y, c->ch, &(c->t_attrib));
+        }
+        vt100_invalidate_xy(vt, x, y);
+    }
+}
+
+static void vt100_image_update(QemuVT100 *vt, int x, int y, int width, int height)
+{
+    vt->image_update(vt, x, y, width, height);
+}
+
+void vt100_refresh(QemuVT100 *vt)
+{
+    TextCell *c;
+    int x, y, y1;
+    int w = pixman_image_get_width(vt->image);
+    int h = pixman_image_get_height(vt->image);
+
+    vt->text_x[0] = 0;
+    vt->text_y[0] = 0;
+    vt->text_x[1] = vt->width - 1;
+    vt->text_y[1] = vt->height - 1;
+    vt->cursor_invalidate = 1;
+
+    image_fill_rect(vt->image, 0, 0, w, h,
+                    color_table_rgb[0][QEMU_COLOR_BLACK]);
+    y1 = vt->y_displayed;
+    for (y = 0; y < vt->height; y++) {
+        c = vt->cells + y1 * vt->width;
+        for (x = 0; x < vt->width; x++) {
+            vt100_putcharxy(vt, x, y, c->ch,
+                            &(c->t_attrib));
+            c++;
+        }
+        if (++y1 == vt->total_height) {
+            y1 = 0;
+        }
+    }
+    vt100_show_cursor(vt, 1);
+    vt100_image_update(vt, 0, 0, w, h);
+}
+
+static void vt100_scroll(QemuVT100 *vt, int ydelta)
+{
+    int i, y1;
+
+    if (ydelta > 0) {
+        for (i = 0; i < ydelta; i++) {
+            if (vt->y_displayed == vt->y_base) {
+                break;
+            }
+            if (++vt->y_displayed == vt->total_height) {
+                vt->y_displayed = 0;
+            }
+        }
+    } else {
+        ydelta = -ydelta;
+        i = vt->backscroll_height;
+        if (i > vt->total_height - vt->height) {
+            i = vt->total_height - vt->height;
+        }
+        y1 = vt->y_base - i;
+        if (y1 < 0) {
+            y1 += vt->total_height;
+        }
+        for (i = 0; i < ydelta; i++) {
+            if (vt->y_displayed == y1) {
+                break;
+            }
+            if (--vt->y_displayed < 0) {
+                vt->y_displayed = vt->total_height - 1;
+            }
+        }
+    }
+    vt100_refresh(vt);
+}
+
+static void vt100_write(QemuVT100 *vt, const void *buf, size_t len)
+{
+    uint32_t num_free;
+
+    num_free = fifo8_num_free(&vt->out_fifo);
+    fifo8_push_all(&vt->out_fifo, buf, MIN(num_free, len));
+    vt->out_flush(vt);
+}
+
+void vt100_set_image(QemuVT100 *vt, pixman_image_t *image)
+{
+    TextCell *cells, *c, *c1;
+    int w1, x, y, last_width, w, h;
+
+    vt->image = image;
+    w = pixman_image_get_width(vt->image) / FONT_WIDTH;
+    h = pixman_image_get_height(vt->image) / FONT_HEIGHT;
+    if (w == vt->width && h == vt->height) {
+        return;
+    }
+
+    last_width = vt->width;
+    vt->width = w;
+    vt->height = h;
+
+    w1 = MIN(vt->width, last_width);
+
+    cells = g_new(TextCell, vt->width * vt->total_height + 1);
+    for (y = 0; y < vt->total_height; y++) {
+        c = &cells[y * vt->width];
+        if (w1 > 0) {
+            c1 = &vt->cells[y * last_width];
+            for (x = 0; x < w1; x++) {
+                *c++ = *c1++;
+            }
+        }
+        for (x = w1; x < vt->width; x++) {
+            c->ch = ' ';
+            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+            c++;
+        }
+    }
+    g_free(vt->cells);
+    vt->cells = cells;
+}
+
+static void vt100_put_lf(QemuVT100 *vt)
+{
+    TextCell *c;
+    int x, y1;
+
+    vt->y++;
+    if (vt->y >= vt->height) {
+        vt->y = vt->height - 1;
+
+        if (vt->y_displayed == vt->y_base) {
+            if (++vt->y_displayed == vt->total_height) {
+                vt->y_displayed = 0;
+            }
+        }
+        if (++vt->y_base == vt->total_height) {
+            vt->y_base = 0;
+        }
+        if (vt->backscroll_height < vt->total_height) {
+            vt->backscroll_height++;
+        }
+        y1 = (vt->y_base + vt->height - 1) % vt->total_height;
+        c = &vt->cells[y1 * vt->width];
+        for (x = 0; x < vt->width; x++) {
+            c->ch = ' ';
+            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+            c++;
+        }
+        if (vt->y_displayed == vt->y_base) {
+            vt->text_x[0] = 0;
+            vt->text_y[0] = 0;
+            vt->text_x[1] = vt->width - 1;
+            vt->text_y[1] = vt->height - 1;
+
+            image_bitblt(vt->image, 0, FONT_HEIGHT, 0, 0,
+                         vt->width * FONT_WIDTH,
+                         (vt->height - 1) * FONT_HEIGHT);
+            image_fill_rect(vt->image, 0, (vt->height - 1) * FONT_HEIGHT,
+                            vt->width * FONT_WIDTH, FONT_HEIGHT,
+                            color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
+            vt->update_x0 = 0;
+            vt->update_y0 = 0;
+            vt->update_x1 = vt->width * FONT_WIDTH;
+            vt->update_y1 = vt->height * FONT_HEIGHT;
+        }
+    }
+}
+
+/*
+ * Set console attributes depending on the current escape codes.
+ * NOTE: I know this code is not very efficient (checking every color for it
+ * self) but it is more readable and better maintainable.
+ */
+static void vt100_handle_escape(QemuVT100 *vt)
+{
+    int i;
+
+    for (i = 0; i < vt->nb_esc_params; i++) {
+        switch (vt->esc_params[i]) {
+        case 0: /* reset all console attributes to default */
+            vt->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+            break;
+        case 1:
+            vt->t_attrib.bold = 1;
+            break;
+        case 4:
+            vt->t_attrib.uline = 1;
+            break;
+        case 5:
+            vt->t_attrib.blink = 1;
+            break;
+        case 7:
+            vt->t_attrib.invers = 1;
+            break;
+        case 8:
+            vt->t_attrib.unvisible = 1;
+            break;
+        case 22:
+            vt->t_attrib.bold = 0;
+            break;
+        case 24:
+            vt->t_attrib.uline = 0;
+            break;
+        case 25:
+            vt->t_attrib.blink = 0;
+            break;
+        case 27:
+            vt->t_attrib.invers = 0;
+            break;
+        case 28:
+            vt->t_attrib.unvisible = 0;
+            break;
+        /* set foreground color */
+        case 30:
+            vt->t_attrib.fgcol = QEMU_COLOR_BLACK;
+            break;
+        case 31:
+            vt->t_attrib.fgcol = QEMU_COLOR_RED;
+            break;
+        case 32:
+            vt->t_attrib.fgcol = QEMU_COLOR_GREEN;
+            break;
+        case 33:
+            vt->t_attrib.fgcol = QEMU_COLOR_YELLOW;
+            break;
+        case 34:
+            vt->t_attrib.fgcol = QEMU_COLOR_BLUE;
+            break;
+        case 35:
+            vt->t_attrib.fgcol = QEMU_COLOR_MAGENTA;
+            break;
+        case 36:
+            vt->t_attrib.fgcol = QEMU_COLOR_CYAN;
+            break;
+        case 37:
+            vt->t_attrib.fgcol = QEMU_COLOR_WHITE;
+            break;
+        /* set background color */
+        case 40:
+            vt->t_attrib.bgcol = QEMU_COLOR_BLACK;
+            break;
+        case 41:
+            vt->t_attrib.bgcol = QEMU_COLOR_RED;
+            break;
+        case 42:
+            vt->t_attrib.bgcol = QEMU_COLOR_GREEN;
+            break;
+        case 43:
+            vt->t_attrib.bgcol = QEMU_COLOR_YELLOW;
+            break;
+        case 44:
+            vt->t_attrib.bgcol = QEMU_COLOR_BLUE;
+            break;
+        case 45:
+            vt->t_attrib.bgcol = QEMU_COLOR_MAGENTA;
+            break;
+        case 46:
+            vt->t_attrib.bgcol = QEMU_COLOR_CYAN;
+            break;
+        case 47:
+            vt->t_attrib.bgcol = QEMU_COLOR_WHITE;
+            break;
+        }
+    }
+}
+
+static void vt100_update_xy(QemuVT100 *vt, int x, int y)
+{
+    TextCell *c;
+    int y1, y2;
+
+    vt->text_x[0] = MIN(vt->text_x[0], x);
+    vt->text_x[1] = MAX(vt->text_x[1], x);
+    vt->text_y[0] = MIN(vt->text_y[0], y);
+    vt->text_y[1] = MAX(vt->text_y[1], y);
+
+    y1 = (vt->y_base + y) % vt->total_height;
+    y2 = y1 - vt->y_displayed;
+    if (y2 < 0) {
+        y2 += vt->total_height;
+    }
+    if (y2 < vt->height) {
+        if (x >= vt->width) {
+            x = vt->width - 1;
+        }
+        c = &vt->cells[y1 * vt->width + x];
+        vt100_putcharxy(vt, x, y2, c->ch,
+                      &(c->t_attrib));
+        vt100_invalidate_xy(vt, x, y2);
+    }
+}
+
+static void vt100_clear_xy(QemuVT100 *vt, int x, int y)
+{
+    int y1 = (vt->y_base + y) % vt->total_height;
+    if (x >= vt->width) {
+        x = vt->width - 1;
+    }
+    TextCell *c = &vt->cells[y1 * vt->width + x];
+    c->ch = ' ';
+    c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+    vt100_update_xy(vt, x, y);
+}
+
+/*
+ * UTF-8 DFA decoder by Bjoern Hoehrmann.
+ * Copyright (c) 2008-2010 Bjoern Hoehrmann <bjoern@hoehrmann.de>
+ * See https://github.com/polijan/utf8_decode for details.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+#define UTF8_ACCEPT 0
+#define UTF8_REJECT 12
+
+static const uint8_t utf8d[] = {
+    /* character class lookup */
+    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,
+    7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,  7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
+    8,8,2,2,2,2,2,2,2,2,2,2,2,2,2,2,  2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
+   10,3,3,3,3,3,3,3,3,3,3,3,3,4,3,3, 11,6,6,6,5,8,8,8,8,8,8,8,8,8,8,8,
+
+    /* state transition lookup */
+     0,12,24,36,60,96,84,12,12,12,48,72, 12,12,12,12,12,12,12,12,12,12,12,12,
+    12, 0,12,12,12,12,12, 0,12, 0,12,12, 12,24,12,12,12,12,12,24,12,24,12,12,
+    12,12,12,12,12,12,12,24,12,12,12,12, 12,24,12,12,12,12,12,12,12,24,12,12,
+    12,12,12,12,12,12,12,36,12,36,12,12, 12,36,12,12,12,12,12,36,12,36,12,12,
+    12,36,12,12,12,12,12,12,12,12,12,12,
+};
+
+static uint32_t utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
+{
+    uint32_t type = utf8d[byte];
+
+    *codep = (*state != UTF8_ACCEPT) ?
+        (byte & 0x3fu) | (*codep << 6) :
+        (0xffu >> type) & (byte);
+
+    *state = utf8d[256 + *state + type];
+    return *state;
+}
+
+static void vt100_put_one(QemuVT100 *vt, int ch)
+{
+    TextCell *c;
+    int y1;
+    if (vt->x >= vt->width) {
+        /* line wrap */
+        vt->x = 0;
+        vt100_put_lf(vt);
+    }
+    y1 = (vt->y_base + vt->y) % vt->total_height;
+    c = &vt->cells[y1 * vt->width + vt->x];
+    c->ch = ch;
+    c->t_attrib = vt->t_attrib;
+    vt100_update_xy(vt, vt->x, vt->y);
+    vt->x++;
+}
+
+/* set cursor, checking bounds */
+static void vt100_set_cursor(QemuVT100 *vt, int x, int y)
+{
+    if (x < 0) {
+        x = 0;
+    }
+    if (y < 0) {
+        y = 0;
+    }
+    if (y >= vt->height) {
+        y = vt->height - 1;
+    }
+    if (x >= vt->width) {
+        x = vt->width - 1;
+    }
+
+    vt->x = x;
+    vt->y = y;
+}
+
+/**
+ * vt100_csi_P() - (DCH) deletes one or more characters from the cursor
+ * position to the right. As characters are deleted, the remaining
+ * characters between the cursor and right margin move to the
+ * left. Character attributes move with the characters.
+ */
+static void vt100_csi_P(QemuVT100 *vt, unsigned int nr)
+{
+    TextCell *c1, *c2;
+    unsigned int x1, x2, y;
+    unsigned int end, len;
+
+    if (!nr) {
+        nr = 1;
+    }
+    if (nr > vt->width - vt->x) {
+        nr = vt->width - vt->x;
+        if (!nr) {
+            return;
+        }
+    }
+
+    x1 = vt->x;
+    x2 = vt->x + nr;
+    len = vt->width - x2;
+    if (len) {
+        y = (vt->y_base + vt->y) % vt->total_height;
+        c1 = &vt->cells[y * vt->width + x1];
+        c2 = &vt->cells[y * vt->width + x2];
+        memmove(c1, c2, len * sizeof(*c1));
+        for (end = x1 + len; x1 < end; x1++) {
+            vt100_update_xy(vt, x1, vt->y);
+        }
+    }
+    /* Clear the rest */
+    for (; x1 < vt->width; x1++) {
+        vt100_clear_xy(vt, x1, vt->y);
+    }
+}
+
+/**
+ * vt100_csi_at() - (ICH) inserts `nr` blank characters with the default
+ * character attribute. The cursor remains at the beginning of the
+ * blank characters. Text between the cursor and right margin moves to
+ * the right. Characters scrolled past the right margin are lost.
+ */
+static void vt100_csi_at(QemuVT100 *vt, unsigned int nr)
+{
+    TextCell *c1, *c2;
+    unsigned int x1, x2, y;
+    unsigned int end, len;
+
+    if (!nr) {
+        nr = 1;
+    }
+    if (nr > vt->width - vt->x) {
+        nr = vt->width - vt->x;
+        if (!nr) {
+            return;
+        }
+    }
+
+    x1 = vt->x + nr;
+    x2 = vt->x;
+    len = vt->width - x1;
+    if (len) {
+        y = (vt->y_base + vt->y) % vt->total_height;
+        c1 = &vt->cells[y * vt->width + x1];
+        c2 = &vt->cells[y * vt->width + x2];
+        memmove(c1, c2, len * sizeof(*c1));
+        for (end = x1 + len; x1 < end; x1++) {
+            vt100_update_xy(vt, x1, vt->y);
+        }
+    }
+    /* Insert blanks */
+    for (x1 = vt->x; x1 < vt->x + nr; x1++) {
+        vt100_clear_xy(vt, x1, vt->y);
+    }
+}
+
+/**
+ * vt100_save_cursor() - saves cursor position and character attributes.
+ */
+static void vt100_save_cursor(QemuVT100 *vt)
+{
+    vt->x_saved = vt->x;
+    vt->y_saved = vt->y;
+    vt->t_attrib_saved = vt->t_attrib;
+}
+
+/**
+ * vt100_restore_cursor() - restores cursor position and character
+ * attributes from saved state.
+ */
+static void vt100_restore_cursor(QemuVT100 *vt)
+{
+    vt->x = vt->x_saved;
+    vt->y = vt->y_saved;
+    vt->t_attrib = vt->t_attrib_saved;
+}
+
+static void vt100_putchar(QemuVT100 *vt, int ch)
+{
+    int i;
+    int x, y;
+    g_autofree char *response = NULL;
+
+    switch (vt->state) {
+    case TTY_STATE_NORM:
+        /* Feed byte through the UTF-8 DFA decoder */
+        if (ch >= 0x80) {
+            switch (utf8_decode(&vt->utf8_state, &vt->utf8_codepoint, ch)) {
+            case UTF8_ACCEPT:
+                vt100_put_one(vt, unicode_to_cp437(vt->utf8_codepoint));
+                break;
+            case UTF8_REJECT:
+                /* Reset state so the decoder can resync */
+                vt->utf8_state = UTF8_ACCEPT;
+                break;
+            default:
+                /* Need more bytes */
+                break;
+            }
+            break;
+        }
+        /* ASCII byte: abort any pending UTF-8 sequence */
+        vt->utf8_state = UTF8_ACCEPT;
+        switch (ch) {
+        case '\r':  /* carriage return */
+            vt->x = 0;
+            break;
+        case '\n':  /* newline */
+            vt100_put_lf(vt);
+            break;
+        case '\b':  /* backspace */
+            if (vt->x > 0) {
+                vt->x--;
+            }
+            break;
+        case '\t':  /* tabspace */
+            if (vt->x + (8 - (vt->x % 8)) > vt->width) {
+                vt->x = 0;
+                vt100_put_lf(vt);
+            } else {
+                vt->x = vt->x + (8 - (vt->x % 8));
+            }
+            break;
+        case '\a':  /* alert aka. bell */
+            /* TODO: has to be implemented */
+            break;
+        case 14:
+            /* SO (shift out), character set 1 (ignored) */
+            break;
+        case 15:
+            /* SI (shift in), character set 0 (ignored) */
+            break;
+        case 27:    /* esc (introducing an escape sequence) */
+            vt->state = TTY_STATE_ESC;
+            break;
+        default:
+            vt100_put_one(vt, ch);
+            break;
+        }
+        break;
+    case TTY_STATE_ESC: /* check if it is a terminal escape sequence */
+        if (ch == '[') {
+            for (i = 0; i < MAX_ESC_PARAMS; i++) {
+                vt->esc_params[i] = 0;
+            }
+            vt->nb_esc_params = 0;
+            vt->state = TTY_STATE_CSI;
+        } else if (ch == '(') {
+            vt->state = TTY_STATE_G0;
+        } else if (ch == ')') {
+            vt->state = TTY_STATE_G1;
+        } else if (ch == ']' || ch == 'P' || ch == 'X'
+                   || ch == '^' || ch == '_') {
+            /* String sequences: OSC, DCS, SOS, PM, APC */
+            vt->state = TTY_STATE_OSC;
+        } else if (ch == '7') {
+            vt100_save_cursor(vt);
+            vt->state = TTY_STATE_NORM;
+        } else if (ch == '8') {
+            vt100_restore_cursor(vt);
+            vt->state = TTY_STATE_NORM;
+        } else {
+            vt->state = TTY_STATE_NORM;
+        }
+        break;
+    case TTY_STATE_CSI: /* handle escape sequence parameters */
+        if (ch >= '0' && ch <= '9') {
+            if (vt->nb_esc_params < MAX_ESC_PARAMS) {
+                int *param = &vt->esc_params[vt->nb_esc_params];
+                int digit = (ch - '0');
+
+                *param = (*param <= (INT_MAX - digit) / 10) ?
+                         *param * 10 + digit : INT_MAX;
+            }
+        } else {
+            if (vt->nb_esc_params < MAX_ESC_PARAMS) {
+                vt->nb_esc_params++;
+            }
+            if (ch == ';' || ch == '?') {
+                break;
+            }
+            trace_console_putchar_csi(vt->esc_params[0], vt->esc_params[1],
+                                      ch, vt->nb_esc_params);
+            vt->state = TTY_STATE_NORM;
+            switch (ch) {
+            case 'A':
+                /* move cursor up */
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
+                }
+                vt100_set_cursor(vt, vt->x, vt->y - vt->esc_params[0]);
+                break;
+            case 'B':
+                /* move cursor down */
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
+                }
+                vt100_set_cursor(vt, vt->x, vt->y + vt->esc_params[0]);
+                break;
+            case 'C':
+                /* move cursor right */
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
+                }
+                vt100_set_cursor(vt, vt->x + vt->esc_params[0], vt->y);
+                break;
+            case 'D':
+                /* move cursor left */
+                if (vt->esc_params[0] == 0) {
+                    vt->esc_params[0] = 1;
+                }
+                vt100_set_cursor(vt, vt->x - vt->esc_params[0], vt->y);
+                break;
+            case 'G':
+                /* move cursor to column */
+                vt100_set_cursor(vt, vt->esc_params[0] - 1, vt->y);
+                break;
+            case 'f':
+            case 'H':
+                /* move cursor to row, column */
+                vt100_set_cursor(vt, vt->esc_params[1] - 1, vt->esc_params[0] - 1);
+                break;
+            case 'J':
+                switch (vt->esc_params[0]) {
+                case 0:
+                    /* clear to end of screen */
+                    for (y = vt->y; y < vt->height; y++) {
+                        for (x = 0; x < vt->width; x++) {
+                            if (y == vt->y && x < vt->x) {
+                                continue;
+                            }
+                            vt100_clear_xy(vt, x, y);
+                        }
+                    }
+                    break;
+                case 1:
+                    /* clear from beginning of screen */
+                    for (y = 0; y <= vt->y; y++) {
+                        for (x = 0; x < vt->width; x++) {
+                            if (y == vt->y && x > vt->x) {
+                                break;
+                            }
+                            vt100_clear_xy(vt, x, y);
+                        }
+                    }
+                    break;
+                case 2:
+                    /* clear entire screen */
+                    for (y = 0; y < vt->height; y++) {
+                        for (x = 0; x < vt->width; x++) {
+                            vt100_clear_xy(vt, x, y);
+                        }
+                    }
+                    break;
+                }
+                break;
+            case 'K':
+                switch (vt->esc_params[0]) {
+                case 0:
+                    /* clear to eol */
+                    for (x = vt->x; x < vt->width; x++) {
+                        vt100_clear_xy(vt, x, vt->y);
+                    }
+                    break;
+                case 1:
+                    /* clear from beginning of line */
+                    for (x = 0; x <= vt->x && x < vt->width; x++) {
+                        vt100_clear_xy(vt, x, vt->y);
+                    }
+                    break;
+                case 2:
+                    /* clear entire line */
+                    for (x = 0; x < vt->width; x++) {
+                        vt100_clear_xy(vt, x, vt->y);
+                    }
+                    break;
+                }
+                break;
+            case 'P':
+                vt100_csi_P(vt, vt->esc_params[0]);
+                break;
+            case 'm':
+                vt100_handle_escape(vt);
+                break;
+            case 'n':
+                switch (vt->esc_params[0]) {
+                case 5:
+                    /* report console status (always succeed)*/
+                    vt100_write(vt, "\033[0n", 4);
+                    break;
+                case 6:
+                    /* report cursor position */
+                    response = g_strdup_printf("\033[%d;%dR",
+                                               vt->y + 1, vt->x + 1);
+                    vt100_write(vt, response, strlen(response));
+                    break;
+                }
+                break;
+            case 's':
+                vt100_save_cursor(vt);
+                break;
+            case 'u':
+                vt100_restore_cursor(vt);
+                break;
+            case '@':
+                vt100_csi_at(vt, vt->esc_params[0]);
+                break;
+            default:
+                trace_console_putchar_unhandled(ch);
+                break;
+            }
+            break;
+        }
+        break;
+    case TTY_STATE_OSC: /* Operating System Command: ESC ] ... BEL/ST */
+        if (ch == '\a') {
+            /* BEL terminates OSC */
+            vt->state = TTY_STATE_NORM;
+        } else if (ch == 27) {
+            /* ESC might start ST (ESC \) */
+            vt->state = TTY_STATE_ESC;
+        }
+        /* All other bytes are silently consumed */
+        break;
+    case TTY_STATE_G0: /* set character sets */
+    case TTY_STATE_G1: /* set character sets */
+        switch (ch) {
+        case 'B':
+            /* Latin-1 map */
+            break;
+        }
+        vt->state = TTY_STATE_NORM;
+        break;
+    }
+
+}
+
+int vt100_input(QemuVT100 *vt, const uint8_t *buf, int len)
+{
+    int i;
+
+    vt->update_x0 = vt->width * FONT_WIDTH;
+    vt->update_y0 = vt->height * FONT_HEIGHT;
+    vt->update_x1 = 0;
+    vt->update_y1 = 0;
+    vt100_show_cursor(vt, 0);
+    for (i = 0; i < len; i++) {
+        vt100_putchar(vt, buf[i]);
+    }
+    vt100_show_cursor(vt, 1);
+    if (vt->update_x0 < vt->update_x1) {
+        vt100_image_update(vt, vt->update_x0, vt->update_y0,
+                           vt->update_x1 - vt->update_x0,
+                           vt->update_y1 - vt->update_y0);
+    }
+    return len;
+}
+
+void vt100_keysym(QemuVT100 *vt, int keysym)
+{
+    uint8_t buf[16], *q;
+    int c;
+
+    switch (keysym) {
+    case QEMU_KEY_CTRL_UP:
+        vt100_scroll(vt, -1);
+        break;
+    case QEMU_KEY_CTRL_DOWN:
+        vt100_scroll(vt, 1);
+        break;
+    case QEMU_KEY_CTRL_PAGEUP:
+        vt100_scroll(vt, -10);
+        break;
+    case QEMU_KEY_CTRL_PAGEDOWN:
+        vt100_scroll(vt, 10);
+        break;
+    default:
+        /* convert the QEMU keysym to VT100 key string */
+        q = buf;
+        if (keysym >= 0xe100 && keysym <= 0xe11f) {
+            *q++ = '\033';
+            *q++ = '[';
+            c = keysym - 0xe100;
+            if (c >= 10) {
+                *q++ = '0' + (c / 10);
+            }
+            *q++ = '0' + (c % 10);
+            *q++ = '~';
+        } else if (keysym >= 0xe120 && keysym <= 0xe17f) {
+            *q++ = '\033';
+            *q++ = '[';
+            *q++ = keysym & 0xff;
+        } else if (vt->echo && (keysym == '\r' || keysym == '\n')) {
+            vt100_input(vt, (uint8_t *)"\r", 1);
+            *q++ = '\n';
+        } else {
+            *q++ = keysym;
+        }
+        if (vt->echo) {
+            vt100_input(vt, buf, q - buf);
+        }
+        vt100_write(vt, buf, q - buf);
+        break;
+    }
+}
+
+void vt100_update_cursor(void)
+{
+    QemuVT100 *vt;
+
+    cursor_visible_phase = !cursor_visible_phase;
+
+    if (QTAILQ_EMPTY(&vt100s)) {
+        return;
+    }
+
+    QTAILQ_FOREACH(vt, &vt100s, list) {
+        vt100_refresh(vt);
+    }
+
+    timer_mod(cursor_timer,
+        qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + CONSOLE_CURSOR_PERIOD / 2);
+}
+
+static void
+cursor_timer_cb(void *opaque)
+{
+    vt100_update_cursor();
+}
+
+void vt100_init(QemuVT100 *vt,
+                pixman_image_t *image,
+                void (*image_update)(QemuVT100 *vt, int x, int y, int w, int h),
+                void (*out_flush)(QemuVT100 *vt))
+{
+    if (!cursor_timer) {
+        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
+    }
+
+    QTAILQ_INSERT_HEAD(&vt100s, vt, list);
+    fifo8_create(&vt->out_fifo, 16);
+    vt->total_height = DEFAULT_BACKSCROLL;
+    vt->image_update = image_update;
+    vt->out_flush = out_flush;
+    /* set current text attributes to default */
+    vt->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+    vt100_set_image(vt, image);
+}
+
+void vt100_fini(QemuVT100 *vt)
+{
+    QTAILQ_REMOVE(&vt100s, vt, list);
+    fifo8_destroy(&vt->out_fifo);
+    g_free(vt->cells);
+}
diff --git a/ui/meson.build b/ui/meson.build
index 25657af50e7..9ece6f262b6 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -3,6 +3,7 @@ system_ss.add(png)
 system_ss.add(files(
   'clipboard.c',
   'console.c',
+  'cp437.c',
   'cursor.c',
   'dmabuf.c',
   'input-keymap.c',
@@ -16,8 +17,9 @@ system_ss.add(files(
   'ui-qmp-cmds.c',
   'util.c',
   'vgafont.c',
+  'vt100.c',
 ))
-system_ss.add(when: pixman, if_true: files('console-vc.c', 'cp437.c'), if_false: files('console-vc-stubs.c'))
+system_ss.add(when: pixman, if_true: files('console-vc.c'), if_false: files('console-vc-stubs.c'))
 if dbus_display
   system_ss.add(files('dbus-module.c'))
 endif

-- 
2.53.0


