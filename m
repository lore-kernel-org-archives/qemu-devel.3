Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35E4C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1vw-0008Pc-UM; Thu, 07 Aug 2025 10:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1uk1vK-0008CM-Vg
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:48:57 -0400
Received: from mail-24417.protonmail.ch ([109.224.244.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1uk1vG-0002b6-Gv
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1754578120; x=1754837320;
 bh=wqBswyRQvm7cfbqyLFvE1H/wDTx0sUd9cZYRiq7KtCU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=qaMCQT/CjUiGQsCIT0rT+llGOS7ytZUkP5ueLWxg1eEGLb6yqOCxHwRYKQEwSO5uA
 WLdOVlDCPqV9Mrc4HqmCJ0YOsNRROR4LBDH2s/KMNBoZIIIR8zPHr+pbNFwmC98N6w
 qOjIGigK6giu2ha/a4ZZqjVIXGQnLO8SQBbgbd8gTBvVR9u2K9hiKg95CHU+mIfWu5
 8AOB4eXZBqvqLKjKGYFGfhc7YqfbX8Fp3jr7acDpEzUbxg111jfL5u5TD9nCz1yWSb
 iNg9j6pgm3gaU35hDHI1O8XhskV91UR1fepFxynSaMHbS11thnl4EbR9/Z90RwTLko
 SS/L6e/01bXtw==
Date: Thu, 07 Aug 2025 14:48:35 +0000
To: qemu-devel@nongnu.org
From: startergo <startergo@protonmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, startergo <startergo@protonmail.com>
Subject: [PATCH] ui/sdl2: Add SDL clipboard support with screen lock handling
Message-ID: <20250807144822.35251-1-startergo@protonmail.com>
Feedback-ID: 25315608:user:proton
X-Pm-Message-ID: cc7f6715590748652828d7b0b238fa2a33b736ab
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=109.224.244.17;
 envelope-from=startergo@protonmail.com; helo=mail-24417.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch implements SDL clipboard integration for QEMU's SDL2 UI backend,
specifically addressing the issue where clipboard functionality becomes
unreliable during host screen lock/unlock scenarios.

The implementation provides:
- Bidirectional clipboard synchronization between guest and host
- Robust screen lock/unlock handling to prevent clipboard conflicts =20
- Asynchronous clipboard request processing
- Proper resource cleanup and error handling

This addresses a common usability issue where copy/paste functionality
stops working after the host screen is locked and unlocked, particularly
noticeable on macOS systems.

The patch adds a new build option --enable-sdl-clipboard (enabled by defaul=
t)
to allow users to disable the feature if needed.

Tested on QEMU 10.0.0 and master branch, passes checkpatch with zero errors=
.

Signed-off-by: startergo <startergo@protonmail.com>
---
 include/ui/sdl2.h   |  15 ++++
 meson.build         |   3 +
 meson_options.txt   |   2 +
 ui/meson.build      |   3 +
 ui/sdl2-clipboard.c | 208 ++++++++++++++++++++++++++++++++++++++++++++
 ui/sdl2.c           |  15 ++++
 6 files changed, 246 insertions(+)
 create mode 100644 ui/sdl2-clipboard.c

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index dbe6e3d97..e73f83259 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -21,6 +21,10 @@
 # include <SDL_image.h>
 #endif
=20
+#ifdef CONFIG_SDL_CLIPBOARD
+#include "ui/clipboard.h"
+#endif
+
 #include "ui/kbd-state.h"
 #ifdef CONFIG_OPENGL
 # include "ui/egl-helpers.h"
@@ -45,6 +49,11 @@ struct sdl2_console {
     bool gui_keysym;
     SDL_GLContext winctx;
     QKbdState *kbd;
+#ifdef CONFIG_SDL_CLIPBOARD
+    QemuClipboardPeer cbpeer;
+    bool clipboard_active;
+    uint32_t last_focus_time;
+#endif
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
     egl_fb guest_fb;
@@ -97,4 +106,10 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl=
,
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h)=
;
=20
+#ifdef CONFIG_SDL_CLIPBOARD
+void sdl2_clipboard_init(struct sdl2_console *scon);
+void sdl2_clipboard_handle_focus_change(struct sdl2_console *scon, bool ga=
ined_focus);
+void sdl2_clipboard_handle_request(struct sdl2_console *scon);
+#endif
+
 #endif /* SDL2_H */
diff --git a/meson.build b/meson.build
index 41f68d380..4a37df966 100644
--- a/meson.build
+++ b/meson.build
@@ -1596,6 +1596,8 @@ else
   sdl_image =3D not_found
 endif
=20
+have_sdl_clipboard =3D sdl.found() and get_option('sdl_clipboard')
+
 rbd =3D not_found
 if not get_option('rbd').auto() or have_block
   librados =3D cc.find_library('rados', required: get_option('rbd'))
@@ -2511,6 +2513,7 @@ config_host_data.set('CONFIG_RELOCATABLE', get_option=
('relocatable'))
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
   ui_modules +=3D {'sdl' : sdl_ss}
diff --git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c
new file mode 100644
index 000000000..6cc0fd79c
--- /dev/null
+++ b/ui/sdl2-clipboard.c
@@ -0,0 +1,208 @@
+/*
+ * SDL UI -- clipboard support with screen lock handling
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
+    uint32_t timestamp;
+} SDLClipboardRequest;
+
+static SDLClipboardRequest *pending_request;
+
+static void sdl2_clipboard_clear_pending(void)
+{
+    if (pending_request) {
+        if (pending_request->info) {
+            qemu_clipboard_info_unref(pending_request->info);
+        }
+        g_free(pending_request);
+        pending_request =3D NULL;
+    }
+}
+
+static void sdl2_clipboard_reset_state(struct sdl2_console *scon)
+{
+    /* Clear any pending requests when clipboard state is reset */
+    sdl2_clipboard_clear_pending();
+
+    /* Force a fresh clipboard check after reconnection */
+    if (scon->clipboard_active) {
+        scon->last_focus_time =3D SDL_GetTicks();
+    }
+}
+
+static void sdl2_clipboard_notify(Notifier *notifier, void *data)
+{
+    QemuClipboardNotify *notify =3D data;
+    struct sdl2_console *scon =3D
+        container_of(notifier, struct sdl2_console, cbpeer.notifier);
+    bool self_update =3D notify->info->owner =3D=3D &scon->cbpeer;
+    const char *text_data;
+    size_t text_size;
+
+    /* Skip processing if clipboard is not active (e.g., during screen loc=
k) */
+    if (!scon->clipboard_active) {
+        return;
+    }
+
+    switch (notify->type) {
+    case QEMU_CLIPBOARD_UPDATE_INFO:
+        {
+            /* Skip self-updates to avoid clipboard manager conflicts */
+            if (self_update) {
+                return;
+            }
+
+            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) =
{
+                return;
+            }
+
+            /* Check if this is completion of our pending request */
+            if (pending_request && pending_request->info =3D=3D notify->in=
fo &&
+                pending_request->type =3D=3D QEMU_CLIPBOARD_TYPE_TEXT) {
+                sdl2_clipboard_clear_pending();
+            }
+
+            /* Check if data is available, request asynchronously if not *=
/
+            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data) {
+                if (!pending_request) {
+                    pending_request =3D g_new0(SDLClipboardRequest, 1);
+                    pending_request->scon =3D scon;
+                    pending_request->info =3D
+                        qemu_clipboard_info_ref(notify->info);
+                    pending_request->type =3D QEMU_CLIPBOARD_TYPE_TEXT;
+                    pending_request->timestamp =3D SDL_GetTicks();
+                    qemu_clipboard_request(notify->info,
+                                           QEMU_CLIPBOARD_TYPE_TEXT);
+                }
+                return;
+            }
+
+            /* Process available data */
+            text_size =3D notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].si=
ze;
+            if (text_size =3D=3D 0) {
+                return;
+            }
+
+            text_data =3D (const char *)
+                notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data;
+
+            /* Ensure null termination for SDL clipboard */
+            g_autofree char *text =3D g_strndup(text_data, text_size);
+            if (text && text[0] !=3D '\0') {
+                if (SDL_SetClipboardText(text) < 0) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "SDL clipboard: Failed to set clipboard =
text: %s\n",
+                                  SDL_GetError());
+                }
+            } else if (!text) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "SDL clipboard: Failed to allocate memory fo=
r clipboard text\n");
+            }
+            break;
+        }
+    case QEMU_CLIPBOARD_RESET_SERIAL:
+        sdl2_clipboard_reset_state(scon);
+        break;
+    }
+}
+
+static void sdl2_clipboard_request(QemuClipboardInfo *info,
+                                   QemuClipboardType type)
+{
+    g_autofree char *text =3D NULL;
+
+    if (type !=3D QEMU_CLIPBOARD_TYPE_TEXT) {
+        return;
+    }
+
+    text =3D SDL_GetClipboardText();
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
+    scon->cbpeer.name =3D "sdl2-clipboard";
+    scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
+    scon->cbpeer.request =3D sdl2_clipboard_request;
+    scon->clipboard_active =3D true;
+    scon->last_focus_time =3D SDL_GetTicks();
+
+    qemu_clipboard_peer_register(&scon->cbpeer);
+}
+
+void sdl2_clipboard_handle_focus_change(struct sdl2_console *scon, bool ga=
ined_focus)
+{
+    uint32_t current_time =3D SDL_GetTicks();
+
+    if (gained_focus) {
+        /* Reactivate clipboard after regaining focus */
+        scon->clipboard_active =3D true;
+        scon->last_focus_time =3D current_time;
+
+        /* Clear any stale pending requests */
+        sdl2_clipboard_clear_pending();
+
+        /* Force a fresh clipboard sync after focus is regained */
+        sdl2_clipboard_handle_request(scon);
+    } else {
+        /* Deactivate clipboard when losing focus to prevent conflicts */
+        scon->clipboard_active =3D false;
+        sdl2_clipboard_clear_pending();
+    }
+}
+
+void sdl2_clipboard_handle_request(struct sdl2_console *scon)
+{
+    g_autofree char *text =3D NULL;
+    QemuClipboardInfo *info;
+
+    /* Skip if clipboard is not active */
+    if (!scon->clipboard_active) {
+        return;
+    }
+
+    text =3D SDL_GetClipboardText();
+    if (!text) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SDL clipboard: Failed to get clipboard text: %s\n",
+                      SDL_GetError());
+        return;
+    }
+
+    if (text[0] =3D=3D '\0') {
+        return; /* Ignore empty clipboard */
+    }
+
+    info =3D qemu_clipboard_info_new(&scon->cbpeer,
+                                   QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
+    qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TEXT,
+                            strlen(text), text, true);
+    qemu_clipboard_info_unref(info);
+}
+
+#endif /* CONFIG_SDL_CLIPBOARD */
diff --git a/ui/sdl2.c b/ui/sdl2.c
index cda4293a5..d89ac16dd 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -606,11 +606,17 @@ static void handle_windowevent(SDL_Event *ev)
          * key is released.
          */
         scon->ignore_hotkeys =3D get_mod_state();
+#ifdef CONFIG_SDL_CLIPBOARD
+        sdl2_clipboard_handle_focus_change(scon, true);
+#endif
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
         if (gui_grab && !gui_fullscreen) {
             sdl_grab_end(scon);
         }
+#ifdef CONFIG_SDL_CLIPBOARD
+        sdl2_clipboard_handle_focus_change(scon, false);
+#endif
         break;
     case SDL_WINDOWEVENT_RESTORED:
         update_displaychangelistener(&scon->dcl, GUI_REFRESH_INTERVAL_DEFA=
ULT);
@@ -691,6 +697,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
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
@@ -901,6 +912,10 @@ static void sdl2_display_init(DisplayState *ds, Displa=
yOptions *o)
         }
         register_displaychangelistener(&sdl2_console[i].dcl);
=20
+#ifdef CONFIG_SDL_CLIPBOARD
+        sdl2_clipboard_init(&sdl2_console[i]);
+#endif
+
 #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
         if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
 #if defined(SDL_VIDEO_DRIVER_WINDOWS)
--=20
2.50.1



