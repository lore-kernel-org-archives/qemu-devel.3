Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0340C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEE4-00026D-34; Mon, 15 Jul 2024 01:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEE1-0001vx-Ab
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:14 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEDz-0000fa-G8
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:13 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3dab3b85623so965203b6e.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721021170; x=1721625970;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eynKNkc/q/6cUVvIvz9V6xDySPK0lqiqrd2y5gmcTLs=;
 b=CwAfsYf/9HqQJ67/5oYMtjtUpQIKKq2KMr+CbQZ/DdTNym8CBeq7wengqq6Phvj8Hb
 xhXu+GWNH+XXvmD1iZQvA5SZEZ5j2AX7kRx1/wJHFHZFonUr5D/hqKNYg0yYFOOCtI7y
 UsPaqf8N1cZ3gm48TVjo0r0uNRryuxqX4ThZby8z4V/Ga6niI8+N2mXlN00U854fKhnp
 qfKnLcspPMFTtvClpQoJ0kyAzWNHh89qAmv+Y3Q9atXkNI3Ud5LNKyg+/myg89nfdS0o
 hrlYMkIY7LGLAx5cIJeUicJJ4KCM7O64x6lWyPXLDW4gd/v6fUIyyfYjITKa1Vvmmn7g
 Y+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721021170; x=1721625970;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eynKNkc/q/6cUVvIvz9V6xDySPK0lqiqrd2y5gmcTLs=;
 b=RVc5YensdYoXATktIwkY6cCUOtLcLNI/PnQau8IEVsZE+zcT3PqZKaZaZhM3Q3F7Y3
 DsX9+dnPeZ3jd+whL8xkH7JiiN+M9HPEMkPYmxgqqetbkLadbRtUrJfoJV4EzTrI9P+e
 FU5LsAyq8072SHR76PdW8X8BBByNjKtNIVagXLvJ+EmZyh5fx5FyMLvJKb3jYJaAsqv6
 tYbs5Zjk/DdCLybOmZkwKhVbRXtGTY0DIpsrWBuR71H7jcUzE0nObPkbX0CH3Km5/73I
 lRmh5/VaJzFKqRi3NxhaJeK76a6nOSVuFXaJ97IlX7htseEWspWsm77N6f6XHJITMWOP
 itlQ==
X-Gm-Message-State: AOJu0YzkPmPtwg7kZ/23dakYd7Sjh7wC+DMPgQHAyxazprs6eOYlDf5F
 oxyoHdriaCY+qJVETnRv0sH0jupPONbyXJHXY86ClmSVeT3Y27b+Qyg6fdr2xl0=
X-Google-Smtp-Source: AGHT+IELWKKMOQjG9sJiQZ+X8XveJoxLWPg34gKUuERTzYog4xi9QzXYkFjGTr1+gNvRI9VjNu8ZPg==
X-Received: by 2002:a05:6808:1306:b0:3d9:324a:3db with SMTP id
 5614622812f47-3d93bdd181bmr22802771b6e.6.1721021170212; 
 Sun, 14 Jul 2024 22:26:10 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-78e34864b3esm2682982a12.42.2024.07.14.22.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:26:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:25:43 +0900
Subject: [PATCH v3 2/4] ui/console: Convert mouse visibility parameter into
 bool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240715-cursor-v3-2-afa5b9492dbf@daynix.com>
References: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
In-Reply-To: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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
index a208a68b8886..82b573e68082 100644
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
index 8d2501bd8210..b1f94f5b767d 100644
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
index d60b1b2973af..3281842bfe1b 100644
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
index 1c0f9d9a991d..512f224b9f58 100644
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
index 1b2cd0c7365d..0ec70cb50ce6 100644
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
index 54900880433e..a54123acea7d 100644
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
index 93b13b7a30ff..bc29f7a1b4f7 100644
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
index 0a0eb5a42d58..98ed97437171 100644
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
index 8a8472d0294e..c794ae06498b 100644
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
index dd530f04e579..dae5d51210be 100644
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
2.45.2


