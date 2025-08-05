Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD45C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujIKx-0005N6-Jb; Tue, 05 Aug 2025 10:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <macbookpro@macbookpros-MacBook-Pro.local>)
 id 1ujHmF-00080f-6Z
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:32:27 -0400
Received: from [205.220.128.102] (helo=macbookpros-MacBook-Pro.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <macbookpro@macbookpros-MacBook-Pro.local>)
 id 1ujHmA-0007xi-Pp
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:32:26 -0400
Received: by macbookpros-MacBook-Pro.local (Postfix, from userid 501)
 id F2E75BCFF413; Tue,  5 Aug 2025 14:16:17 +0100 (BST)
Date: Tue, 5 Aug 2025 14:16:17 +0100
From: macbookpro <macbookpro@macbookpros-macbook-pro.local>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com
Subject: [PATCH] ui/sdl2: Add SDL clipboard support
Message-ID: <aJIEIS2jMQz_7skd@macbookpros-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Host-Lookup-Failed: Reverse DNS lookup failed for 205.220.128.102 (deferred)
Received-SPF: none client-ip=205.220.128.102;
 envelope-from=macbookpro@macbookpros-MacBook-Pro.local;
 helo=macbookpros-MacBook-Pro.local
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 NO_DNS_FOR_FROM=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 05 Aug 2025 10:08:17 -0400
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

From ef834d229fda71f1773f483f4ef6ef7c50e485d0 Mon Sep 17 00:00:00 2001
From: Test User <7897244+startergo@users.noreply.github.com>
Date: Tue, 5 Aug 2025 13:53:00 +0100
Subject: [PATCH] ui/sdl2: Add SDL clipboard support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement bidirectional clipboard integration between QEMU and host
system when using the SDL display backend. This allows seamless
copy-paste operations between the guest and host environments.

Features:
- Bidirectional clipboard sync (guest <-> host)
- Async clipboard request handling to prevent blocking
- Self-update detection to avoid clipboard manager conflicts
- Configurable via --enable-sdl-clipboard build option
- Text-only clipboard support (following existing QEMU patterns)

The implementation follows the same patterns used by the existing
GTK and VNC clipboard implementations, integrating with QEMU's
clipboard subsystem through QemuClipboardPeer.

Tested on macOS with successful build and runtime clipboard
functionality verification.

Co-authored-by: Kamay Xutax <admin@xutaxkamay.com>
Signed-off-by: startergo <startergo@protonmail.com>
---
 include/ui/sdl2.h   |  12 ++++
 meson.build         |   3 +
 meson_options.txt   |   2 +
 ui/meson.build      |   3 +
 ui/sdl2-clipboard.c | 154 ++++++++++++++++++++++++++++++++++++++++++++
 ui/sdl2.c           |   9 +++
 6 files changed, 183 insertions(+)
 create mode 100644 ui/sdl2-clipboard.c

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index dbe6e3d97..0cadbe8c1 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -21,6 +21,10 @@
 # include <SDL_image.h>
 #endif
 
+#ifdef CONFIG_SDL_CLIPBOARD
+#include "ui/clipboard.h"
+#endif
+
 #include "ui/kbd-state.h"
 #ifdef CONFIG_OPENGL
 # include "ui/egl-helpers.h"
@@ -45,6 +49,9 @@ struct sdl2_console {
     bool gui_keysym;
     SDL_GLContext winctx;
     QKbdState *kbd;
+#ifdef CONFIG_SDL_CLIPBOARD
+    QemuClipboardPeer cbpeer;
+#endif
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
     egl_fb guest_fb;
@@ -97,4 +104,9 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 
+#ifdef CONFIG_SDL_CLIPBOARD
+void sdl2_clipboard_init(struct sdl2_console *scon);
+void sdl2_clipboard_handle_request(struct sdl2_console *scon);
+#endif
+
 #endif /* SDL2_H */
diff --git a/meson.build b/meson.build
index 41f68d380..4a37df966 100644
--- a/meson.build
+++ b/meson.build
@@ -1596,6 +1596,8 @@ else
   sdl_image = not_found
 endif
 
+have_sdl_clipboard = sdl.found() and get_option('sdl_clipboard')
+
 rbd = not_found
 if not get_option('rbd').auto() or have_block
   librados = cc.find_library('rados', required: get_option('rbd'))
@@ -2511,6 +2513,7 @@ config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
 config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
+config_host_data.set('CONFIG_SDL_CLIPBOARD', have_sdl_clipboard)
 config_host_data.set('CONFIG_SECCOMP', seccomp.found())
 if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca..be2cba3a3 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -212,6 +212,8 @@ option('sdl', type : 'feature', value : 'auto',
        description: 'SDL user interface')
 option('sdl_image', type : 'feature', value : 'auto',
        description: 'SDL Image support for icons')
+option('sdl_clipboard', type : 'boolean', value : true,
+       description: 'SDL clipboard support')
 option('seccomp', type : 'feature', value : 'auto',
        description: 'seccomp support')
 option('smartcard', type : 'feature', value : 'auto',
diff --git a/ui/meson.build b/ui/meson.build
index 35fb04cad..6d1bf3477 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -126,6 +126,9 @@ if sdl.found()
     'sdl2-input.c',
     'sdl2.c',
   ))
+  if have_sdl_clipboard
+    sdl_ss.add(files('sdl2-clipboard.c'))
+  endif
   sdl_ss.add(when: opengl, if_true: files('sdl2-gl.c'))
   sdl_ss.add(when: x11, if_true: files('x_keymap.c'))
   ui_modules += {'sdl' : sdl_ss}
diff --git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c
new file mode 100644
index 000000000..15e68af46
--- /dev/null
+++ b/ui/sdl2-clipboard.c
@@ -0,0 +1,154 @@
+/*
+ * SDL UI -- clipboard support (improved async version)
+ *
+ * Copyright (C) 2023 Kamay Xutax <admin@xutaxkamay.com>
+ * Copyright (C) 2025 startergo <startergo@protonmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "ui/console.h"
+#include "ui/clipboard.h"
+#include "ui/sdl2.h"
+#include "qemu/log.h"
+
+#ifdef CONFIG_SDL_CLIPBOARD
+
+/* Track pending clipboard requests to handle async data */
+typedef struct {
+    struct sdl2_console *scon;
+    QemuClipboardInfo *info;
+    QemuClipboardType type;
+} SDLClipboardRequest;
+
+static SDLClipboardRequest *pending_request = NULL;
+
+static void sdl2_clipboard_clear_pending(void)
+{
+    if (pending_request) {
+        if (pending_request->info) {
+            qemu_clipboard_info_unref(pending_request->info);
+        }
+        g_free(pending_request);
+        pending_request = NULL;
+    }
+}
+
+static void sdl2_clipboard_notify(Notifier *notifier, void *data)
+{
+    QemuClipboardNotify *notify = data;
+    struct sdl2_console *scon =
+        container_of(notifier, struct sdl2_console, cbpeer.notifier);
+    bool self_update = notify->info->owner == &scon->cbpeer;
+    const char *text_data;
+    size_t text_size;
+
+    switch (notify->type) {
+    case QEMU_CLIPBOARD_UPDATE_INFO:
+        {
+            /* Skip self-updates to avoid clipboard manager conflicts */
+            if (self_update) {
+                return;
+            }
+
+            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) {
+                return;
+            }
+
+            /* Check if this is completion of our pending request */
+            if (pending_request && pending_request->info == notify->info &&
+                pending_request->type == QEMU_CLIPBOARD_TYPE_TEXT) {
+                sdl2_clipboard_clear_pending();
+            }
+
+            /* Check if data is available, request asynchronously if not */
+            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data) {
+                if (!pending_request) {
+                    pending_request = g_new0(SDLClipboardRequest, 1);
+                    pending_request->scon = scon;
+                    pending_request->info = qemu_clipboard_info_ref(notify->info);
+                    pending_request->type = QEMU_CLIPBOARD_TYPE_TEXT;
+                    qemu_clipboard_request(notify->info, QEMU_CLIPBOARD_TYPE_TEXT);
+                }
+                return;
+            }
+
+            /* Process available data */
+            text_size = notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].size;
+            if (text_size == 0) {
+                return;
+            }
+
+            text_data = (const char *)notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data;
+
+            /* Ensure null termination for SDL clipboard */
+            g_autofree char *text = g_strndup(text_data, text_size);
+            if (text && text[0] != '\0') {
+                SDL_SetClipboardText(text);
+            } else if (!text) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "SDL clipboard: Failed to allocate memory for clipboard text\n");
+            }
+            break;
+        }
+    case QEMU_CLIPBOARD_RESET_SERIAL:
+        sdl2_clipboard_clear_pending();
+        break;
+    }
+}
+
+static void sdl2_clipboard_request(QemuClipboardInfo *info,
+                                   QemuClipboardType type)
+{
+    g_autofree char *text = NULL;
+
+    if (type != QEMU_CLIPBOARD_TYPE_TEXT) {
+        return;
+    }
+
+    text = SDL_GetClipboardText();
+    if (!text) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SDL clipboard: Failed to get clipboard text: %s\n",
+                      SDL_GetError());
+        return;
+    }
+
+    qemu_clipboard_set_data(info->owner, info, type,
+                            strlen(text), text, true);
+}
+
+void sdl2_clipboard_init(struct sdl2_console *scon)
+{
+    scon->cbpeer.name = "sdl2-clipboard";
+    scon->cbpeer.notifier.notify = sdl2_clipboard_notify;
+    scon->cbpeer.request = sdl2_clipboard_request;
+
+    qemu_clipboard_peer_register(&scon->cbpeer);
+}
+
+void sdl2_clipboard_handle_request(struct sdl2_console *scon)
+{
+    g_autofree char *text = NULL;
+    QemuClipboardInfo *info;
+
+    text = SDL_GetClipboardText();
+    if (!text) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SDL clipboard: Failed to get clipboard text: %s\n",
+                      SDL_GetError());
+        return;
+    }
+
+    if (text[0] == '\0') {
+        return; /* Ignore empty clipboard */
+    }
+
+    info = qemu_clipboard_info_new(&scon->cbpeer, QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
+    qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TEXT,
+                            strlen(text), text, true);
+    qemu_clipboard_info_unref(info);
+}
+
+#endif /* CONFIG_SDL_CLIPBOARD */
diff --git a/ui/sdl2.c b/ui/sdl2.c
index cda4293a5..00a17b68a 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -691,6 +691,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
         case SDL_WINDOWEVENT:
             handle_windowevent(ev);
             break;
+#ifdef CONFIG_SDL_CLIPBOARD
+        case SDL_CLIPBOARDUPDATE:
+            sdl2_clipboard_handle_request(scon);
+            break;
+#endif
         default:
             break;
         }
@@ -901,6 +906,10 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         }
         register_displaychangelistener(&sdl2_console[i].dcl);
 
+#ifdef CONFIG_SDL_CLIPBOARD
+        sdl2_clipboard_init(&sdl2_console[i]);
+#endif
+
 #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
         if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
 #if defined(SDL_VIDEO_DRIVER_WINDOWS)
-- 
2.50.1


