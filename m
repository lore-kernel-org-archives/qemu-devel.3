Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F367AC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTme4-00047Y-KT; Tue, 16 Jul 2024 14:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdO-0001Ud-3B
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdM-0001Ib-0r
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:41 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-367b8a60b60so3236399f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153433; x=1721758233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjXvs4g8beqO1KLudvEIr0iy0B0rZvJHKWCqys4N1lI=;
 b=Y+cvOGHPXSudVzNe5H0Mql1W3/SGak6CMHmPJsiyhB75CZrI3FSPUpuXo4j88zDHCU
 mlHvHeZF1A5rMO3l90STL9nDFSmOB+coMDuC7a6Z6e1D2OKxfz4y01zyrt6KJE1IkfB6
 LNoAxBCNIo+tfC1iPYrW+bLGoG+HRCyBLeLWS/u8pZpB/a9d84GpCKpRgL4S03Lx0bbB
 u/F89OB/QOfaHS6DyoNivUaajBS/2+yV5BWBEAfEAl40u7Ui69IoShhcAdwmYsksIF5H
 u8JgJeM6ypxT57MHDCAo58d15aq+/TIhC20fdA11PkpicF4k1NnGPHLTG8zGG4IZys2L
 FPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153433; x=1721758233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjXvs4g8beqO1KLudvEIr0iy0B0rZvJHKWCqys4N1lI=;
 b=Td/hU+CnxK3qZXtWMbpoFQ4iDo88uceA0NexeyxslowwHoi0APeXMPa/DsPWBrCqVK
 kD8QdBUH68qeFhkKYycmJ1IOmFn7vPkWinnoTuYgepUqS0symZidNnV/euKtMfcR/wOt
 ttdbQcRf9Q2vLeno71UaS397g3m7JLHjtXYjhPu+4kYtzgjmX0MzbyQ7CUzgfsOw7b/q
 7CZmb3TszL+FXcM4r59s03AC14LJBjMsNYn/oLqY0HNjfr6wDFfhBMwAXCwZlztcYMl0
 19h4xfW6OgNqNCZxng6cY6nnq151f7ZjVN7mxShkFQMCxx2jFzEq888HBSvL6+qgahgm
 70NA==
X-Gm-Message-State: AOJu0Ywo/WJj8j8+RXR1ws+V3EnX8S/qAKvlwYGP+MKNF9x+6u3P0uJ2
 ykUIYIBKr+IpiB18Q0MrHQ1H+EMwJjUSM3yGBkmL85ukNK8e2K7eBXDqQEGuB7xGvo8S/IvyRsA
 5EZprhg==
X-Google-Smtp-Source: AGHT+IH/rppI31A3I4KePKXCCBaNw0iYc4GYRIDKeZHddh23bNXMwxe6zYkqUNFPddyybRlvHlenMw==
X-Received: by 2002:a5d:598f:0:b0:367:923b:656b with SMTP id
 ffacd0b85a97d-368263249e0mr2037764f8f.54.1721153433345; 
 Tue, 16 Jul 2024 11:10:33 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3f13sm9766649f8f.4.2024.07.16.11.10.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/13] ui/console: Convert mouse visibility parameter into bool
Date: Tue, 16 Jul 2024 20:09:36 +0200
Message-ID: <20240716180941.40211-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240715-cursor-v3-2-afa5b9492dbf@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/console.h    |  4 ++--
 hw/display/ati.c        |  2 +-
 hw/display/virtio-gpu.c |  3 +--
 hw/display/vmware_vga.c |  2 +-
 ui/console.c            |  5 +++--
 ui/dbus-listener.c      |  2 +-
 ui/gtk.c                |  2 +-
 ui/sdl2.c               |  4 ++--
 ui/spice-display.c      | 11 ++++++-----
 ui/vnc.c                |  2 +-
 10 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a208a68b88..82b573e680 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -233,7 +233,7 @@ typedef struct DisplayChangeListenerOps {
 
     /* optional */
     void (*dpy_mouse_set)(DisplayChangeListener *dcl,
-                          int x, int y, int on);
+                          int x, int y, bool on);
     /* optional */
     void (*dpy_cursor_define)(DisplayChangeListener *dcl,
                               QEMUCursor *cursor);
@@ -322,7 +322,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
 void dpy_text_cursor(QemuConsole *con, int x, int y);
 void dpy_text_update(QemuConsole *con, int x, int y, int w, int h);
 void dpy_text_resize(QemuConsole *con, int w, int h);
-void dpy_mouse_set(QemuConsole *con, int x, int y, int on);
+void dpy_mouse_set(QemuConsole *con, int x, int y, bool on);
 void dpy_cursor_define(QemuConsole *con, QEMUCursor *cursor);
 bool dpy_cursor_define_supported(QemuConsole *con);
 bool dpy_gfx_check_format(QemuConsole *con,
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8d2501bd82..b1f94f5b76 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -742,7 +742,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         if (!s->cursor_guest_mode &&
             (s->regs.crtc_gen_cntl & CRTC2_CUR_EN) && !(t & BIT(31))) {
             dpy_mouse_set(s->vga.con, s->regs.cur_hv_pos >> 16,
-                          s->regs.cur_hv_pos & 0xffff, 1);
+                          s->regs.cur_hv_pos & 0xffff, true);
         }
         break;
     }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index d60b1b2973..3281842bfe 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -109,8 +109,7 @@ static void update_cursor(VirtIOGPU *g, struct virtio_gpu_update_cursor *cursor)
         s->cursor.pos.x = cursor->pos.x;
         s->cursor.pos.y = cursor->pos.y;
     }
-    dpy_mouse_set(s->con, cursor->pos.x, cursor->pos.y,
-                  cursor->resource_id ? 1 : 0);
+    dpy_mouse_set(s->con, cursor->pos.x, cursor->pos.y, cursor->resource_id);
 }
 
 struct virtio_gpu_simple_resource *
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 1c0f9d9a99..512f224b9f 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1167,7 +1167,7 @@ static void vmsvga_reset(DeviceState *dev)
     s->enable = 0;
     s->config = 0;
     s->svgaid = SVGA_ID;
-    s->cursor.on = 0;
+    s->cursor.on = false;
     s->redraw_fifo_last = 0;
     s->syncing = 0;
 
diff --git a/ui/console.c b/ui/console.c
index e67c5dae2b..8e9cc1628a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -49,7 +49,8 @@ typedef struct QemuGraphicConsole {
     uint32_t head;
 
     QEMUCursor *cursor;
-    int cursor_x, cursor_y, cursor_on;
+    int cursor_x, cursor_y;
+    bool cursor_on;
 } QemuGraphicConsole;
 
 typedef QemuConsoleClass QemuGraphicConsoleClass;
@@ -957,7 +958,7 @@ void dpy_text_resize(QemuConsole *con, int w, int h)
     }
 }
 
-void dpy_mouse_set(QemuConsole *c, int x, int y, int on)
+void dpy_mouse_set(QemuConsole *c, int x, int y, bool on)
 {
     QemuGraphicConsole *con = QEMU_GRAPHIC_CONSOLE(c);
     DisplayState *s = c->ds;
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 5490088043..a54123acea 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -726,7 +726,7 @@ static void dbus_gfx_switch(DisplayChangeListener *dcl,
 }
 
 static void dbus_mouse_set(DisplayChangeListener *dcl,
-                           int x, int y, int on)
+                           int x, int y, bool on)
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 93b13b7a30..bc29f7a1b4 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -446,7 +446,7 @@ static GdkDevice *gd_get_pointer(GdkDisplay *dpy)
 }
 
 static void gd_mouse_set(DisplayChangeListener *dcl,
-                         int x, int y, int visible)
+                         int x, int y, bool visible)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GdkDisplay *dpy;
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 0a0eb5a42d..98ed974371 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -49,7 +49,7 @@ static int gui_grab_code = KMOD_LALT | KMOD_LCTRL;
 static SDL_Cursor *sdl_cursor_normal;
 static SDL_Cursor *sdl_cursor_hidden;
 static int absolute_enabled;
-static int guest_cursor;
+static bool guest_cursor;
 static int guest_x, guest_y;
 static SDL_Cursor *guest_sprite;
 static Notifier mouse_mode_notifier;
@@ -729,7 +729,7 @@ void sdl2_poll_events(struct sdl2_console *scon)
 }
 
 static void sdl_mouse_warp(DisplayChangeListener *dcl,
-                           int x, int y, int on)
+                           int x, int y, bool on)
 {
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
 
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 8a8472d029..c794ae0649 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -254,7 +254,7 @@ static void qemu_spice_create_update(SimpleSpiceDisplay *ssd)
 static SimpleSpiceCursor*
 qemu_spice_create_cursor_update(SimpleSpiceDisplay *ssd,
                                 QEMUCursor *c,
-                                int on)
+                                bool on)
 {
     size_t size = c ? c->width * c->height * 4 : 0;
     SimpleSpiceCursor *update;
@@ -448,7 +448,8 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *ssd,
     qemu_mutex_lock(&ssd->lock);
     if (ssd->cursor) {
         g_free(ssd->ptr_define);
-        ssd->ptr_define = qemu_spice_create_cursor_update(ssd, ssd->cursor, 0);
+        ssd->ptr_define =
+            qemu_spice_create_cursor_update(ssd, ssd->cursor, false);
     }
     qemu_mutex_unlock(&ssd->lock);
 }
@@ -476,7 +477,7 @@ void qemu_spice_cursor_refresh_bh(void *opaque)
         ssd->mouse_x = -1;
         ssd->mouse_y = -1;
         qemu_mutex_unlock(&ssd->lock);
-        dpy_mouse_set(ssd->dcl.con, x, y, 1);
+        dpy_mouse_set(ssd->dcl.con, x, y, true);
     } else {
         qemu_mutex_unlock(&ssd->lock);
     }
@@ -747,7 +748,7 @@ static void display_refresh(DisplayChangeListener *dcl)
 }
 
 static void display_mouse_set(DisplayChangeListener *dcl,
-                              int x, int y, int on)
+                              int x, int y, bool on)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
 
@@ -774,7 +775,7 @@ static void display_mouse_define(DisplayChangeListener *dcl,
     g_free(ssd->ptr_move);
     ssd->ptr_move = NULL;
     g_free(ssd->ptr_define);
-    ssd->ptr_define = qemu_spice_create_cursor_update(ssd, c, 0);
+    ssd->ptr_define = qemu_spice_create_cursor_update(ssd, c, false);
     qemu_mutex_unlock(&ssd->lock);
     qemu_spice_wakeup(ssd);
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index dd530f04e5..dae5d51210 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -981,7 +981,7 @@ int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 }
 
 static void vnc_mouse_set(DisplayChangeListener *dcl,
-                          int x, int y, int visible)
+                          int x, int y, bool visible)
 {
     /* can we ask the client(s) to move the pointer ??? */
 }
-- 
2.41.0


