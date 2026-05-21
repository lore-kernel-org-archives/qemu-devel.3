Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021B2CD5BB4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3wQ-0000fT-A4; Thu, 21 May 2026 10:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3vE-0007TR-Me
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3vC-0002Xq-Ij
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1k9ze6YWErIgmVSMwxO43L2UxMS0Nawp0xFT0NHEbY=;
 b=X3c4VXWd+vkZkuBO/DcmplYwXmWSLrKMAVYrabIxUTHM4OlFJBt79m2H+vwTvaa9Kiy6a4
 mM33zuL3DMcy//9CfbQCGt+IRlXFrM4171xey2xKu5Pd7WPm5q2Bazr5i/Dmt4c/5aqieH
 XKiO12y3PIkyjHcR8EwLMwrUMk2sg7s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-xgOaE0xoMSO7sqOAStTxfA-1; Thu,
 21 May 2026 09:58:31 -0400
X-MC-Unique: xgOaE0xoMSO7sqOAStTxfA-1
X-Mimecast-MFC-AGG-ID: xgOaE0xoMSO7sqOAStTxfA_1779371911
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEB341800451; Thu, 21 May 2026 13:58:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89DBE1956056; Thu, 21 May 2026 13:58:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 27/38] ui/gtk: Use Linux key codes
Date: Thu, 21 May 2026 17:55:38 +0400
Message-ID: <20260521135551.1752945-28-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-19-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/x_keymap.h   |  3 ++-
 ui/gtk.c        | 51 ++++++++++++++++++++++++++++---------------------
 ui/x_keymap.c   | 24 ++++++++++++-----------
 ui/trace-events |  2 +-
 4 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/ui/x_keymap.h b/ui/x_keymap.h
index 0395e335fff..0d58459dd21 100644
--- a/ui/x_keymap.h
+++ b/ui/x_keymap.h
@@ -27,6 +27,7 @@
 
 #include <X11/Xlib.h>
 
-const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen);
+const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen,
+                                          bool *evdev);
 
 #endif
diff --git a/ui/gtk.c b/ui/gtk.c
index 757ee80fa6a..9f9b2416c8a 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -55,6 +55,7 @@
 #include <math.h>
 
 #include "trace.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/input.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -120,6 +121,7 @@
 
 static const guint16 *keycode_map;
 static size_t keycode_maplen;
+static bool keycode_xorgevdev;
 
 struct VCChardev {
     Chardev parent;
@@ -1211,39 +1213,42 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
     return TRUE;
 }
 
-static const guint16 *gd_get_keymap(size_t *maplen)
+static const guint16 *gd_get_keymap(size_t *maplen, bool *xorgevdev)
 {
     GdkDisplay *dpy = gdk_display_get_default();
 
+    *maplen = 0;
+    *xorgevdev = false;
+
 #ifdef GDK_WINDOWING_X11
     if (GDK_IS_X11_DISPLAY(dpy)) {
         trace_gd_keymap_windowing("x11");
         return qemu_xkeymap_mapping_table(
-            gdk_x11_display_get_xdisplay(dpy), maplen);
+            gdk_x11_display_get_xdisplay(dpy), maplen, xorgevdev);
     }
 #endif
 
 #ifdef GDK_WINDOWING_WAYLAND
     if (GDK_IS_WAYLAND_DISPLAY(dpy)) {
         trace_gd_keymap_windowing("wayland");
-        *maplen = qemu_input_map_xorgevdev_to_qcode_len;
-        return qemu_input_map_xorgevdev_to_qcode;
+        *xorgevdev = true;
+        return NULL;
     }
 #endif
 
 #ifdef GDK_WINDOWING_WIN32
     if (GDK_IS_WIN32_DISPLAY(dpy)) {
         trace_gd_keymap_windowing("win32");
-        *maplen = qemu_input_map_atset1_to_qcode_len;
-        return qemu_input_map_atset1_to_qcode;
+        *maplen = qemu_input_map_atset1_to_linux_len;
+        return qemu_input_map_atset1_to_linux;
     }
 #endif
 
 #ifdef GDK_WINDOWING_QUARTZ
     if (GDK_IS_QUARTZ_DISPLAY(dpy)) {
         trace_gd_keymap_windowing("quartz");
-        *maplen = qemu_input_map_osx_to_qcode_len;
-        return qemu_input_map_osx_to_qcode;
+        *maplen = qemu_input_map_osx_to_linux_len;
+        return qemu_input_map_osx_to_linux;
     }
 #endif
 
@@ -1253,8 +1258,8 @@ static const guint16 *gd_get_keymap(size_t *maplen)
         g_warning("experimental: using broadway, x11 virtual keysym\n"
                   "mapping - with very limited support. See also\n"
                   "https://bugzilla.gnome.org/show_bug.cgi?id=700105");
-        *maplen = qemu_input_map_x11_to_qcode_len;
-        return qemu_input_map_x11_to_qcode;
+        *maplen = qemu_input_map_x11_to_linux_len;
+        return qemu_input_map_x11_to_linux;
     }
 #endif
 
@@ -1269,8 +1274,11 @@ static const guint16 *gd_get_keymap(size_t *maplen)
 }
 
 
-static int gd_map_keycode(int scancode)
+static unsigned int gd_map_keycode(int scancode)
 {
+    if (keycode_xorgevdev) {
+        return scancode < 8 ? KEY_RESERVED : scancode - 8;
+    }
     if (!keycode_map) {
         return 0;
     }
@@ -1307,12 +1315,12 @@ static gboolean gd_text_key_down(GtkWidget *widget,
     QemuTextConsole *con = QEMU_TEXT_CONSOLE(vc->gfx.dcl.con);
 
     if (key->keyval == GDK_KEY_Delete) {
-        qemu_text_console_put_qcode(con, Q_KEY_CODE_DELETE, false);
+        qemu_text_console_put_linux(con, KEY_DELETE, false);
     } else if (key->length) {
         qemu_text_console_put_string(con, key->string, key->length);
     } else {
-        int qcode = gd_map_keycode(gd_get_keycode(key));
-        qemu_text_console_put_qcode(con, qcode, false);
+        unsigned int lnx = gd_map_keycode(gd_get_keycode(key));
+        qemu_text_console_put_linux(con, lnx, false);
     }
     return TRUE;
 }
@@ -1320,7 +1328,8 @@ static gboolean gd_text_key_down(GtkWidget *widget,
 static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
 {
     VirtualConsole *vc = opaque;
-    int keycode, qcode;
+    int keycode;
+    unsigned int lnx;
 
 #ifdef G_OS_WIN32
     /* on windows, we ought to ignore the reserved key event? */
@@ -1343,20 +1352,18 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
         || key->hardware_keycode == VK_PAUSE
 #endif
         ) {
-        qkbd_state_key_event(vc->gfx.kbd,
-                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_PAUSE],
+        qkbd_state_key_event(vc->gfx.kbd, KEY_PAUSE,
                              key->type == GDK_KEY_PRESS);
         return TRUE;
     }
 
     keycode = gd_get_keycode(key);
-    qcode = gd_map_keycode(keycode);
+    lnx = gd_map_keycode(keycode);
 
-    trace_gd_key_event(vc->label, keycode, qemu_input_map_qcode_to_linux[qcode],
+    trace_gd_key_event(vc->label, keycode, lnx,
                        (key->type == GDK_KEY_PRESS) ? "down" : "up");
 
-    qkbd_state_key_event(vc->gfx.kbd, qemu_input_map_qcode_to_linux[qcode],
-                         key->type == GDK_KEY_PRESS);
+    qkbd_state_key_event(vc->gfx.kbd, lnx, key->type == GDK_KEY_PRESS);
 
     return TRUE;
 }
@@ -2660,7 +2667,7 @@ static void early_gtk_display_init(DisplayOptions *opts)
 #endif
     }
 
-    keycode_map = gd_get_keymap(&keycode_maplen);
+    keycode_map = gd_get_keymap(&keycode_maplen, &keycode_xorgevdev);
 
 #if defined(CONFIG_VTE)
     type_register_static(&char_gd_vc_type_info);
diff --git a/ui/x_keymap.c b/ui/x_keymap.c
index 2ce7b899615..f7dc2edb91d 100644
--- a/ui/x_keymap.c
+++ b/ui/x_keymap.c
@@ -52,11 +52,12 @@ static gboolean check_for_xquartz(Display *dpy)
     return match;
 }
 
-const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen)
+const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen,
+                                          bool *evdev)
 {
     XkbDescPtr desc;
     const gchar *keycodes = NULL;
-    const guint16 *map;
+    const guint16 *map = NULL;
 
     /* There is no easy way to determine what X11 server
      * and platform & keyboard driver is in use. Thus we
@@ -81,24 +82,26 @@ const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen)
         XkbFreeKeyboard(desc, XkbGBN_AllComponentsMask, True);
     }
 
+    *maplen = 0;
+    *evdev = false;
+
     if (check_for_xwin(dpy)) {
         trace_xkeymap_keymap("xwin");
-        *maplen = qemu_input_map_xorgxwin_to_qcode_len;
-        map = qemu_input_map_xorgxwin_to_qcode;
+        *maplen = qemu_input_map_xorgxwin_to_linux_len;
+        map = qemu_input_map_xorgxwin_to_linux;
     } else if (check_for_xquartz(dpy)) {
         trace_xkeymap_keymap("xquartz");
-        *maplen = qemu_input_map_xorgxquartz_to_qcode_len;
-        map = qemu_input_map_xorgxquartz_to_qcode;
+        *maplen = qemu_input_map_xorgxquartz_to_linux_len;
+        map = qemu_input_map_xorgxquartz_to_linux;
     } else if ((keycodes && g_str_has_prefix(keycodes, "evdev")) ||
                (XKeysymToKeycode(dpy, XK_Page_Up) == 0x70)) {
         trace_xkeymap_keymap("evdev");
-        *maplen = qemu_input_map_xorgevdev_to_qcode_len;
-        map = qemu_input_map_xorgevdev_to_qcode;
+        *evdev = true;
     } else if ((keycodes && g_str_has_prefix(keycodes, "xfree86")) ||
                (XKeysymToKeycode(dpy, XK_Page_Up) == 0x63)) {
         trace_xkeymap_keymap("kbd");
-        *maplen = qemu_input_map_xorgkbd_to_qcode_len;
-        map = qemu_input_map_xorgkbd_to_qcode;
+        *maplen = qemu_input_map_xorgkbd_to_linux_len;
+        map = qemu_input_map_xorgkbd_to_linux;
     } else {
         trace_xkeymap_keymap("NULL");
         g_warning("Unknown X11 keycode mapping '%s'.\n"
@@ -110,7 +113,6 @@ const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen)
                   "  - xprop -root\n"
                   "  - xdpyinfo\n",
                   keycodes ? keycodes : "<null>");
-        map = NULL;
     }
     if (keycodes) {
         XFree((void *)keycodes);
diff --git a/ui/trace-events b/ui/trace-events
index 1c0d96a92c3..237f5a65af2 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -22,7 +22,7 @@ ppm_save(int fd, void *image) "fd=%d image=%p"
 # gtk.c
 gd_switch(const char *tab, int width, int height) "tab=%s, width=%d, height=%d"
 gd_update(const char *tab, int x, int y, int w, int h) "tab=%s, x=%d, y=%d, w=%d, h=%d"
-gd_key_event(const char *tab, int gdk_keycode, int qkeycode, const char *action) "tab=%s, translated GDK keycode %d to QKeyCode %d (%s)"
+gd_key_event(const char *tab, int gdk_keycode, unsigned int lnx, const char *action) "tab=%s, translated GDK keycode %d to Linux %u (%s)"
 gd_grab(const char *tab, const char *device, const char *reason) "tab=%s, dev=%s, reason=%s"
 gd_ungrab(const char *tab, const char *device) "tab=%s, dev=%s"
 gd_keymap_windowing(const char *name) "backend=%s"
-- 
2.54.0


