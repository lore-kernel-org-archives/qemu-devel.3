Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FACCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcGR-0007if-Da; Sat, 09 May 2026 03:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcGP-0007VC-Hd
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcGN-0007BN-BM
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98Cqm6BjQKTa0eqNhJ32Z6It2suApfQCNYqXZHOYdYU=;
 b=JvBFmc56BaMComJr7jv/tqRKveMRa38CxNT+pik+btgBWOc/ktlQS92CHECSVqoknq01Vu
 WQHBOs12fng9n1HSg2k4pEJ8xQZcy4whCcG1GRJ1ebkgLnBJIzNNzqhi400h7qAvxUXAT6
 X9VipjW9PRUlogeNitlt1sQulIuy+Cg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-dpt0SyDyPjeM_wfd9Qyrog-1; Sat,
 09 May 2026 03:38:10 -0400
X-MC-Unique: dpt0SyDyPjeM_wfd9Qyrog-1
X-Mimecast-MFC-AGG-ID: dpt0SyDyPjeM_wfd9Qyrog_1778312289
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BA6A19560B2; Sat,  9 May 2026 07:38:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6794219560A2; Sat,  9 May 2026 07:38:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PULL 18/32] ui/console: remove console_ch_t typedef and
 console_write_ch()
Date: Sat,  9 May 2026 11:36:04 +0400
Message-ID: <20260509073621.1011778-19-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h         |  9 +--------
 hw/display/jazz_led.c        | 10 +++++-----
 hw/display/vga.c             | 16 ++++++++--------
 hw/display/virtio-gpu-base.c |  2 +-
 hw/display/virtio-vga.c      |  2 +-
 hw/display/vmware_vga.c      |  2 +-
 ui/console-vc.c              | 11 +++++------
 ui/console.c                 |  2 +-
 ui/curses.c                  |  6 +++---
 9 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 27eacc39cc0..2bf768ed482 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -336,13 +336,6 @@ int dpy_gl_ctx_make_current(QemuConsole *con, QEMUGLContext ctx);
 
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
@@ -377,7 +370,7 @@ void graphic_console_close(QemuConsole *con);
 void graphic_hw_update(QemuConsole *con);
 void graphic_hw_update_done(QemuConsole *con);
 void graphic_hw_invalidate(QemuConsole *con);
-void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
+void graphic_hw_text_update(QemuConsole *con, uint32_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
 
 void qemu_console_early_init(void);
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 7d1a020d4d9..ee9758a94b5 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -228,7 +228,7 @@ static void jazz_led_invalidate_display(void *opaque)
     s->state |= REDRAW_SEGMENTS | REDRAW_BACKGROUND;
 }
 
-static void jazz_led_text_update(void *opaque, console_ch_t *chardata)
+static void jazz_led_text_update(void *opaque, uint32_t *chardata)
 {
     LedState *s = opaque;
     char buf[3];
@@ -238,10 +238,10 @@ static void jazz_led_text_update(void *opaque, console_ch_t *chardata)
 
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
index 776aa443246..2f266f47a39 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1901,13 +1901,13 @@ static void vga_reset(void *opaque)
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
 
@@ -2007,14 +2007,14 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
 
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
@@ -2023,7 +2023,7 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
             }
             c_min = i;
             for (; i < size; src ++, dst ++, i ++) {
-                console_write_ch(&val, VMEM2CHTYPE(le32_to_cpu(*src)));
+                val = VMEM2CHTYPE(le32_to_cpu(*src));
                 if (*dst != val) {
                     *dst = val;
                     c_max = i;
@@ -2061,14 +2061,14 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
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
index 94cf362d152..bdc24492850 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -88,7 +88,7 @@ static bool virtio_gpu_update_display(void *opaque)
     return true;
 }
 
-static void virtio_gpu_text_update(void *opaque, console_ch_t *chardata)
+static void virtio_gpu_text_update(void *opaque, uint32_t *chardata)
 {
 }
 
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index f4713b91a66..efd4858f3d0 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -31,7 +31,7 @@ static bool virtio_vga_base_update_display(void *opaque)
     }
 }
 
-static void virtio_vga_base_text_update(void *opaque, console_ch_t *chardata)
+static void virtio_vga_base_text_update(void *opaque, uint32_t *chardata)
 {
     VirtIOVGABase *vvga = opaque;
     VirtIOGPUBase *g = vvga->vgpu;
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index c84c84a445e..11f13c98d7a 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1184,7 +1184,7 @@ static void vmsvga_invalidate_display(void *opaque)
     s->invalidated = 1;
 }
 
-static void vmsvga_text_update(void *opaque, console_ch_t *chardata)
+static void vmsvga_text_update(void *opaque, uint32_t *chardata)
 {
     struct vmsvga_state_s *s = opaque;
 
diff --git a/ui/console-vc.c b/ui/console-vc.c
index b58fe5de827..b9da9ddf30d 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -386,7 +386,7 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
     vt100_keysym(&s->vt, keysym);
 }
 
-static void text_console_update(void *opaque, console_ch_t *chardata)
+static void text_console_update(void *opaque, uint32_t *chardata)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
     int i, j, src;
@@ -396,11 +396,10 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
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
index 799d61ec1a5..1c75b1a355b 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -210,7 +210,7 @@ void graphic_hw_invalidate(QemuConsole *con)
     }
 }
 
-void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
+void graphic_hw_text_update(QemuConsole *con, uint32_t *chardata)
 {
     if (con && con->hw_ops->text_update) {
         con->hw_ops->text_update(con->hw, chardata);
diff --git a/ui/curses.c b/ui/curses.c
index af4ccb4227d..96427aa6bb9 100644
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
2.54.0


