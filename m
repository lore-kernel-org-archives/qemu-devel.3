Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85772CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPalI-0005C4-Kr; Wed, 20 May 2026 02:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak5-0003ez-Re; Wed, 20 May 2026 02:49:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak1-0001ZB-Er; Wed, 20 May 2026 02:49:21 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbg096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=uGrKUsxJcOfgTl9SgFj1e7qS4GLqbTL+vTyM9WSZRxo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259698; v=1;
 b=FGn3sLQQ0RSEyPZDQY2veFPczYWuiAQKu1ocIFl9iq7e/oxj+s2D4nACRTOO9bIS
 itzXfI8RIoBUfsP17ubuCNqk5D6a7SXhykUjMLH+toRt3H8p0ID5jKtpPRVskspG
 Kvb8jJxewwrCnYCnaXsgvfBNIzi/kES9niDI3FmAzEioKcQxOSMJB8r6zQ1FQCrl
 YGI+tyvzz8upE5ZQn/Pg4vNxwbKwbwEsxPW+FSLncH+UAI4mLAPkJ5oM9jid9GVv
 BeYd9Fzrimp1S0CU9FgeuLV6vfC0dhcpeAPL07m9tme+4yPuEqmM+tuR/6X6Z6Rv
 4/ZvkHC9ji9/2pmJPKof+A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:48:02 +0900
Subject: [PATCH v3 19/29] ui/gtk: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-19-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=9684;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=VY2ZK42wfvDDX+7rW8hSBRs4W8qTOYdVbkkX11sHJDw=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpNq6BF++13lTewXNxS3X/t7358SBAka2+zMXzCoR7
 6lYHH6xo5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCKvJzD8d3M2fXK70b/7c9k+
 A5siqwealfdPbcxTNuFv6f0g/iGGh5Hhmrqg6yZ9LfeqsgYbmZNfW4zdxT7dWC1u3miy5H0Qx2I
 eAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/x_keymap.h   |  3 ++-
 ui/gtk.c        | 51 +++++++++++++++++++++++++++++----------------------
 ui/x_keymap.c   | 24 +++++++++++++-----------
 ui/trace-events |  2 +-
 4 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/ui/x_keymap.h b/ui/x_keymap.h
index 0395e335fffd..0d58459dd210 100644
--- a/ui/x_keymap.h
+++ b/ui/x_keymap.h
@@ -27,6 +27,7 @@
 
 #include <X11/Xlib.h>
 
-const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen);
+const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen,
+                                          bool *evdev);
 
 #endif
diff --git a/ui/gtk.c b/ui/gtk.c
index 757ee80fa6a6..9f9b2416c8a1 100644
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
index 2ce7b899615f..f7dc2edb91d6 100644
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
index 1c0d96a92c39..237f5a65af23 100644
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


