Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BB6C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSSd-00088I-7O; Fri, 08 Aug 2025 15:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1ukSSV-00084k-Fy
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 15:08:56 -0400
Received: from mail-24416.protonmail.ch ([109.224.244.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1ukSSS-0007Vd-PD
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 15:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1754680127; x=1754939327;
 bh=GcQEGtFCDKZku9vYxHXZaNyhwdvUR86LISiCI4HBJTg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=uTNIlOtZHylbBbxn+dMywmTjoKQmAtnLpbpUB5+QzS70KTEe5g3zSG+9mKQ3+dceF
 JUdThXG/m5tW3T5Dq2maQAJsWmUYsbU5u53B2+uIcm612IyKuflpzvaNaUEHizUYWn
 tqCi/bpqCSOm9dx3BE+ZOzAJoUw4Xq1TJUKJOac/qLdqq5th/Nuk5zvBpKtpSdN9yu
 CwbebrIqGv1qYPgvx75Mdgfuk2KqmLGvdsYt0sPtN0c4MdlKw9hwufAvXsuF+3+K8u
 DIywgSaWcWQ5yf5e/n1D2KFsvvvRmBhwV/zG6ixrkkbdPumsNGam3s7/H+8FOOG3Wk
 pBrbcfeoJk5wQ==
Date: Fri, 08 Aug 2025 19:08:41 +0000
To: marcandre.lureau@gmail.com
From: startergo <startergo@protonmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 philmd@linaro.org, admin@xutaxkamay.com, startergo <startergo@protonmail.com>
Subject: [PATCH] ui/sdl2: Add SDL clipboard support
Message-ID: <20250808190833.42875-1-startergo@protonmail.com>
In-Reply-To: <CAJ+F1CJyGmYhBoTKg_hWibAQfL0f9-1CDWxJnQVBjaS_iXExeg@mail.gmail.com>
References: <20250731174242.65816-1-startergo@protonmail.com>
 <CAJ+F1CJyGmYhBoTKg_hWibAQfL0f9-1CDWxJnQVBjaS_iXExeg@mail.gmail.com>
Feedback-ID: 25315608:user:proton
X-Pm-Message-ID: 63f82b7b024711ddaa5f239639e2a9b41a9e787c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=109.224.244.16;
 envelope-from=startergo@protonmail.com; helo=mail-24416.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Implement bidirectional clipboard integration between QEMU and host
system when using the SDL display backend. This allows seamless
copy-paste operations between the guest and host environments.

Features:
- Bidirectional clipboard sync (guest =E2=86=94 host)
- Async clipboard request handling to prevent blocking
- Self-update detection to avoid clipboard manager conflicts
- Screen lock/unlock handling for improved reliability
- Configurable via --enable-sdl-clipboard build option
- Text-only clipboard support (following existing QEMU patterns)

The implementation follows the same patterns used by the existing
GTK and VNC clipboard implementations, integrating with QEMU's
clipboard subsystem through QemuClipboardPeer.

Changes in v2:
- Fixed meson option to use 'feature' type instead of 'boolean'
- Improved error handling with warn_report() and proper SDL_free()
- Added protection against async request loops
- Simplified clipboard data handling
- Fixed line length violations for checkpatch compliance
- Maintained compatibility with existing screen lock handling

Co-authored-by: Kamay Xutax <admin@xutaxkamay.com>
Signed-off-by: startergo <startergo@protonmail.com>
---
 include/ui/sdl2.h   |  15 ++++
 meson.build         |   1 +
 meson_options.txt   |   2 +
 ui/meson.build      |   6 ++
 ui/sdl2-clipboard.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
 ui/sdl2.c           |  30 +++++++++
 6 files changed, 202 insertions(+)
 create mode 100644 ui/sdl2-clipboard.c
--- /tmp/qemu-pristine/qemu-10.0.0/include/ui/sdl2.h=092025-04-22 16:26:11
+++ qemu-clean-workspace/include/ui/sdl2.h=092025-08-07 14:01:28
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
@@ -45,6 +49,11 @@
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
@@ -97,4 +106,11 @@
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h)=
;
=20
+#ifdef CONFIG_SDL_CLIPBOARD
+void sdl2_clipboard_init(struct sdl2_console *scon);
+void sdl2_clipboard_handle_focus_change(struct sdl2_console *scon,
+                                         bool gained_focus);
+void sdl2_clipboard_handle_request(struct sdl2_console *scon);
+#endif
+
 #endif /* SDL2_H */
--- /tmp/qemu-pristine/qemu-10.0.0/meson.build=092025-04-22 16:26:11
+++ qemu-clean-workspace/meson.build=092025-08-07 14:01:28
@@ -1594,6 +1594,11 @@
           get_option('sdl').disabled() ? 'disabled' : 'not found'))
   endif
   sdl_image =3D not_found
+endif
+
+have_sdl_clipboard =3D false
+if sdl.found()
+  have_sdl_clipboard =3D get_option('sdl_clipboard').require(sdl.found()).=
allowed()
 endif
=20
 rbd =3D not_found
@@ -2511,6 +2516,7 @@
 config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
+config_host_data.set('CONFIG_SDL_CLIPBOARD', have_sdl_clipboard)
 config_host_data.set('CONFIG_SECCOMP', seccomp.found())
 if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
--- /tmp/qemu-pristine/qemu-10.0.0/meson_options.txt=092025-04-22 16:26:11
+++ qemu-clean-workspace/meson_options.txt=092025-08-07 14:01:28
@@ -212,6 +212,8 @@
        description: 'SDL user interface')
 option('sdl_image', type : 'feature', value : 'auto',
        description: 'SDL Image support for icons')
+option('sdl_clipboard', type : 'feature', value : 'auto',
+       description: 'SDL clipboard support')
 option('seccomp', type : 'feature', value : 'auto',
        description: 'seccomp support')
 option('smartcard', type : 'feature', value : 'auto',
--- /tmp/qemu-pristine/qemu-10.0.0/ui/meson.build=092025-04-22 16:26:11
+++ qemu-clean-workspace/ui/meson.build=092025-08-07 14:01:28
@@ -126,6 +126,9 @@
     'sdl2-input.c',
     'sdl2.c',
   ))
+  if have_sdl_clipboard
+    sdl_ss.add(files('sdl2-clipboard.c'))
+  endif
   sdl_ss.add(when: opengl, if_true: files('sdl2-gl.c'))
   sdl_ss.add(when: x11, if_true: files('x_keymap.c'))
   ui_modules +=3D {'sdl' : sdl_ss}
--- /dev/null=092025-08-07 14:08:08
+++ qemu-clean-workspace/ui/sdl2-clipboard.c=092025-08-07 14:01:28
@@ -0,0 +1,206 @@
+/*
+ * SDL UI -- clipboard support
+ *
+ * Copyright (C) 2023 Kamay Xutax <admin@xutaxkamay.com>
+ * Copyright (C) 2025 startergo <startergo@protonmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "ui/console.h"
+#include "ui/clipboard.h"
+#include "ui/sdl2.h"
+
+/* Track pending clipboard requests to handle async data */
+typedef struct {
+    struct sdl2_console *scon;
+    QemuClipboardInfo *info;
+    QemuClipboardType type;
+    bool request_sent;
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
+        g_clear_pointer(&pending_request, g_free);
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
+                /*
+                 * Protect against request loops by checking if we already
+                 * sent a request
+                 */
+                if (!pending_request || !pending_request->request_sent) {
+                    sdl2_clipboard_clear_pending();
+                    pending_request =3D g_new0(SDLClipboardRequest, 1);
+                    pending_request->scon =3D scon;
+                    pending_request->info =3D
+                        qemu_clipboard_info_ref(notify->info);
+                    pending_request->type =3D QEMU_CLIPBOARD_TYPE_TEXT;
+                    pending_request->request_sent =3D true;
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
+                    warn_report("SDL clipboard: Failed to set clipboard "
+                                "text: %s", SDL_GetError());
+                }
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
+    char *text =3D NULL;
+
+    if (type !=3D QEMU_CLIPBOARD_TYPE_TEXT) {
+        return;
+    }
+
+    text =3D SDL_GetClipboardText();
+    if (!text || !text[0]) {
+        if (text) {
+            warn_report("SDL clipboard: Failed to get clipboard text: %s",
+                        SDL_GetError());
+            SDL_free(text);
+        }
+        return;
+    }
+
+    qemu_clipboard_set_data(info->owner, info, type,
+                            strlen(text), text, true);
+    SDL_free(text);
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
+void sdl2_clipboard_handle_focus_change(struct sdl2_console *scon,
+                                         bool gained_focus)
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
+    char *text =3D NULL;
+    QemuClipboardInfo *info;
+
+    /* Skip if clipboard is not active */
+    if (!scon->clipboard_active) {
+        return;
+    }
+
+    text =3D SDL_GetClipboardText();
+    if (!text || !text[0]) {
+        if (text) {
+            SDL_free(text);
+        }
+        return; /* Ignore empty clipboard */
+    }
+
+    info =3D qemu_clipboard_info_new(&scon->cbpeer,
+                                   QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
+    qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TEXT,
+                            strlen(text), text, true);
+    qemu_clipboard_update(info);
+    qemu_clipboard_info_unref(info);
+    SDL_free(text);
+}
--- /tmp/qemu-pristine/qemu-10.0.0/ui/sdl2.c=092025-04-22 16:26:11
+++ qemu-clean-workspace/ui/sdl2.c=092025-08-07 14:01:28
@@ -606,11 +606,17 @@
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
@@ -691,6 +697,11 @@
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
@@ -901,6 +912,10 @@
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


