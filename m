Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46BDF3381D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QDs-0004WL-Sh; Tue, 17 Mar 2026 04:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBK-0000A0-VP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBI-0003tn-62
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2QbvOfd+SV8M5vKScZ3odoTY2MoLyj/x6VAfh+kc/Q=;
 b=MZwdiNG1t54XjI6dubrLSPhW4tJq5nrRHcRxsq6sBLGueU1r4Bytt1A8pgCD9IvEJeDAHU
 d8oDUlISBmw/yYXRXFGiIl7eP0x8UqOfpY6UVOmVVfepx+SX0i6mz/WH0WuA5RE6Vlapfb
 o+qSFCBPdzQaqMf3ixfcs+Y4IS0IG60=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-XKx6mmAuOyOIJpUb65b3zA-1; Tue,
 17 Mar 2026 04:53:38 -0400
X-MC-Unique: XKx6mmAuOyOIJpUb65b3zA-1
X-Mimecast-MFC-AGG-ID: XKx6mmAuOyOIJpUb65b3zA_1773737617
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FB1719560A1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37538180075B
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:45 +0400
Subject: [PATCH 31/60] ui/console: remove console_ch_t typedef and
 console_write_ch()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-31-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=10951;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wA9U9FrKK/wUybhtmxzjutcU4bIMajNA4vD4m5xcBGo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbfxNn4XNKFxY6BaK4p/JM4f5puw9hak64x
 EZpCoWmCzaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5da2D/9LzWFbAA8/7IP+0aPSHcvqT4oMEUqmHzY1sQt8lKR0pFWYkOixO0h/2XbRBqKB3ibHtTa
 01gF+8DfZdgXXgK6DidHwpWf8bP0/5S0PaO+ITBAO9GUqpELYptT9OeAJ9ispcyj531bhFSjRs4
 VqPZaXh1xqYlvCo1Iwy93eVdsGnp7XMG3knXEh6JoloW79wEIVrqtSICtOcIOb+nSf4u+Jw+9Au
 5YsExphcP+8WQr99H5mQJozhjb8NS5dOIQDhv8BSfjWeFSSxmrki8zrZWifG7NvnjiA9jR6BBeI
 1PEk+dIn9IsXSZbcW7AQisLqo7nnFQI78j9BA9N1kwsAgmUqReMyeM3IjaKvdGDdKCnRfBnobA7
 dYPdnC2yP49b1CxiPkYUJaM1VZe/Lmw2b1lAjDM4yVS9RCzrjm5CiIuynioFbF1hrGGZJwTUzr2
 f2R5ok+/lROPRe8SZM/52d7lQ+cd9u8fYPDUBbXEQ4sKgXEDV445zsSRAp663Gm2m9jDV/Q5hq3
 s9AoL9bTGmCUMUc7yydPRe0LUkR47YqnfvyXRMlifpzkfM2LkGdg+s+swRvc+OMbWMGj/EBgYFP
 SwvSqP/Pt9ndAouU+JExP5zxs+c198XyjseY7h34mAeH1zi6a2uPivA761Zu+ODE8t7UiLG5uev
 QicELPOW83L1BZw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Since commit e2f82e924d05 ("console: purge curses bits from
console.h"), console_ch_t is a plain uint32_t typedef and
console_write_ch() is a trivial assignment (*dest = ch). These
abstractions were originally needed because console_ch_t was the
curses chtype when CONFIG_CURSES was enabled, and console_write_ch()
handled VGA-to-curses character translation. That commit moved the
curses logic into curses_update(), making the typedef and helper
dead abstractions.

Replace console_ch_t with uint32_t and console_write_ch() calls
with direct assignments.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h         | 11 ++---------
 hw/display/jazz_led.c        | 10 +++++-----
 hw/display/vga.c             | 16 ++++++++--------
 hw/display/virtio-gpu-base.c |  2 +-
 hw/display/virtio-vga.c      |  2 +-
 hw/display/vmware_vga.c      |  2 +-
 ui/console-vc.c              | 11 +++++------
 ui/console.c                 |  2 +-
 ui/curses.c                  |  6 +++---
 9 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 401e5a010fd..152333d60fc 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -350,13 +350,6 @@ int dpy_gl_ctx_make_current(QemuConsole *con, QEMUGLContext ctx);
 
 bool console_has_gl(QemuConsole *con);
 
-typedef uint32_t console_ch_t;
-
-static inline void console_write_ch(console_ch_t *dest, uint32_t ch)
-{
-    *dest = ch;
-}
-
 enum {
     GRAPHIC_FLAGS_NONE     = 0,
     /* require a console/display with GL callbacks */
@@ -370,7 +363,7 @@ typedef struct GraphicHwOps {
     void (*invalidate)(void *opaque);
     void (*gfx_update)(void *opaque);
     bool gfx_update_async; /* if true, calls graphic_hw_update_done() */
-    void (*text_update)(void *opaque, console_ch_t *text);
+    void (*text_update)(void *opaque, uint32_t *text);
     void (*ui_info)(void *opaque, uint32_t head, QemuUIInfo *info);
     void (*gl_block)(void *opaque, bool block);
 } GraphicHwOps;
@@ -386,7 +379,7 @@ void graphic_console_close(QemuConsole *con);
 void graphic_hw_update(QemuConsole *con);
 void graphic_hw_update_done(QemuConsole *con);
 void graphic_hw_invalidate(QemuConsole *con);
-void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
+void graphic_hw_text_update(QemuConsole *con, uint32_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
 
 void qemu_console_early_init(void);
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 9d62e51bed9..d5783982950 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -226,7 +226,7 @@ static void jazz_led_invalidate_display(void *opaque)
     s->state |= REDRAW_SEGMENTS | REDRAW_BACKGROUND;
 }
 
-static void jazz_led_text_update(void *opaque, console_ch_t *chardata)
+static void jazz_led_text_update(void *opaque, uint32_t *chardata)
 {
     LedState *s = opaque;
     char buf[3];
@@ -236,10 +236,10 @@ static void jazz_led_text_update(void *opaque, console_ch_t *chardata)
 
     /* TODO: draw the segments */
     snprintf(buf, 3, "%02hhx", s->segments);
-    console_write_ch(chardata++, ATTR2CHTYPE(buf[0], QEMU_COLOR_BLUE,
-                                             QEMU_COLOR_BLACK, 1));
-    console_write_ch(chardata++, ATTR2CHTYPE(buf[1], QEMU_COLOR_BLUE,
-                                             QEMU_COLOR_BLACK, 1));
+    *chardata++ = ATTR2CHTYPE(buf[0], QEMU_COLOR_BLUE,
+                              QEMU_COLOR_BLACK, 1);
+    *chardata++ = ATTR2CHTYPE(buf[1], QEMU_COLOR_BLUE,
+                              QEMU_COLOR_BLACK, 1);
 
     dpy_text_update(s->con, 0, 0, 2, 1);
 }
diff --git a/hw/display/vga.c b/hw/display/vga.c
index ee7d97b5c21..36cfc59a74e 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1899,13 +1899,13 @@ static void vga_reset(void *opaque)
         ((v & 0x00000800) << 10) | ((v & 0x00007000) >> 1))
 /* relay text rendering to the display driver
  * instead of doing a full vga_update_display() */
-static void vga_update_text(void *opaque, console_ch_t *chardata)
+static void vga_update_text(void *opaque, uint32_t *chardata)
 {
     VGACommonState *s =  opaque;
     int graphic_mode, i, cursor_offset, cursor_visible;
     int cw, cheight, width, height, size, c_min, c_max;
     uint32_t *src;
-    console_ch_t *dst, val;
+    uint32_t *dst, val;
     char msg_buffer[80];
     int full_update = 0;
 
@@ -2005,14 +2005,14 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
 
         if (full_update) {
             for (i = 0; i < size; src ++, dst ++, i ++)
-                console_write_ch(dst, VMEM2CHTYPE(le32_to_cpu(*src)));
+                *dst = VMEM2CHTYPE(le32_to_cpu(*src));
 
             dpy_text_update(s->con, 0, 0, width, height);
         } else {
             c_max = 0;
 
             for (i = 0; i < size; src ++, dst ++, i ++) {
-                console_write_ch(&val, VMEM2CHTYPE(le32_to_cpu(*src)));
+                val = VMEM2CHTYPE(le32_to_cpu(*src));
                 if (*dst != val) {
                     *dst = val;
                     c_max = i;
@@ -2021,7 +2021,7 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
             }
             c_min = i;
             for (; i < size; src ++, dst ++, i ++) {
-                console_write_ch(&val, VMEM2CHTYPE(le32_to_cpu(*src)));
+                val = VMEM2CHTYPE(le32_to_cpu(*src));
                 if (*dst != val) {
                     *dst = val;
                     c_max = i;
@@ -2059,14 +2059,14 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
     dpy_text_resize(s->con, s->last_width, height);
 
     for (dst = chardata, i = 0; i < s->last_width * height; i ++)
-        console_write_ch(dst ++, ' ');
+        *dst++ = ' ';
 
     size = strlen(msg_buffer);
     width = (s->last_width - size) / 2;
     dst = chardata + s->last_width + width;
     for (i = 0; i < size; i ++)
-        console_write_ch(dst ++, ATTR2CHTYPE(msg_buffer[i], QEMU_COLOR_BLUE,
-                                             QEMU_COLOR_BLACK, 1));
+        *dst++ = ATTR2CHTYPE(msg_buffer[i], QEMU_COLOR_BLUE,
+                             QEMU_COLOR_BLACK, 1);
 
     dpy_text_update(s->con, 0, 0, s->last_width, height);
 }
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index cb76302e2d8..7b107509510 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -87,7 +87,7 @@ static void virtio_gpu_update_display(void *opaque)
 {
 }
 
-static void virtio_gpu_text_update(void *opaque, console_ch_t *chardata)
+static void virtio_gpu_text_update(void *opaque, uint32_t *chardata)
 {
 }
 
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 5e087169f2f..02fb36b31fc 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -31,7 +31,7 @@ static void virtio_vga_base_update_display(void *opaque)
     }
 }
 
-static void virtio_vga_base_text_update(void *opaque, console_ch_t *chardata)
+static void virtio_vga_base_text_update(void *opaque, uint32_t *chardata)
 {
     VirtIOVGABase *vvga = opaque;
     VirtIOGPUBase *g = vvga->vgpu;
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index c2c6bc76e90..1e154e7f99e 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1183,7 +1183,7 @@ static void vmsvga_invalidate_display(void *opaque)
     s->invalidated = 1;
 }
 
-static void vmsvga_text_update(void *opaque, console_ch_t *chardata)
+static void vmsvga_text_update(void *opaque, uint32_t *chardata)
 {
     struct vmsvga_state_s *s = opaque;
 
diff --git a/ui/console-vc.c b/ui/console-vc.c
index b30adac83ac..ba440c50744 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -381,7 +381,7 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
     vt100_keysym(&s->vt, keysym);
 }
 
-static void text_console_update(void *opaque, console_ch_t *chardata)
+static void text_console_update(void *opaque, uint32_t *chardata)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
     int i, j, src;
@@ -391,11 +391,10 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
         chardata += s->vt.text_y[0] * s->vt.width;
         for (i = s->vt.text_y[0]; i <= s->vt.text_y[1]; i ++)
             for (j = 0; j < s->vt.width; j++, src++) {
-                console_write_ch(chardata ++,
-                                 ATTR2CHTYPE(s->vt.cells[src].ch,
-                                             s->vt.cells[src].t_attrib.fgcol,
-                                             s->vt.cells[src].t_attrib.bgcol,
-                                             s->vt.cells[src].t_attrib.bold));
+                *chardata++ = ATTR2CHTYPE(s->vt.cells[src].ch,
+                                          s->vt.cells[src].t_attrib.fgcol,
+                                          s->vt.cells[src].t_attrib.bgcol,
+                                          s->vt.cells[src].t_attrib.bold);
             }
         dpy_text_update(QEMU_CONSOLE(s), s->vt.text_x[0], s->vt.text_y[0],
                         s->vt.text_x[1] - s->vt.text_x[0], i - s->vt.text_y[0]);
diff --git a/ui/console.c b/ui/console.c
index 8af1dee0e22..b2b879e8533 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -214,7 +214,7 @@ void graphic_hw_invalidate(QemuConsole *con)
     }
 }
 
-void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
+void graphic_hw_text_update(QemuConsole *con, uint32_t *chardata)
 {
     if (con && con->hw_ops->text_update) {
         con->hw_ops->text_update(con->hw, chardata);
diff --git a/ui/curses.c b/ui/curses.c
index 161f78c35c3..78f21d940e3 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -57,7 +57,7 @@ enum maybe_keycode {
 };
 
 static DisplayChangeListener *dcl;
-static console_ch_t *screen;
+static uint32_t *screen;
 static WINDOW *screenpad = NULL;
 static int width, height, gwidth, gheight, invalidate;
 static int px, py, sminx, sminy, smaxx, smaxy;
@@ -68,7 +68,7 @@ static cchar_t *vga_to_curses;
 static void curses_update(DisplayChangeListener *dcl,
                           int x, int y, int w, int h)
 {
-    console_ch_t *line;
+    uint32_t *line;
     g_autofree cchar_t *curses_line = g_new(cchar_t, width);
     wchar_t wch[CCHARW_MAX];
     attr_t attrs;
@@ -796,7 +796,7 @@ static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
     if (opts->u.curses.charset) {
         font_charset = opts->u.curses.charset;
     }
-    screen = g_new0(console_ch_t, 160 * 100);
+    screen = g_new0(uint32_t, 160 * 100);
     vga_to_curses = g_new0(cchar_t, 256);
     curses_setup();
     curses_keyboard_setup();

-- 
2.53.0


