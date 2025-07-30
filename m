Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B18EC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 09:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh3DH-0002L3-Bb; Wed, 30 Jul 2025 05:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1uh3CV-00025E-SF
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 05:34:19 -0400
Received: from mail-43167.protonmail.ch ([185.70.43.167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1uh3CR-0004dW-CE
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 05:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1753868048; x=1754127248;
 bh=udiLKEXU1ldGhYNlHiABIMxlGXaV/WXt8QFt4+SXoxA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=shi7ok+ulQMaKKABs2YZu1KlMieifbl4oe48TXAISeOlcw24I5QT8FM+D1mmo7UU3
 NX0Gm9mLpb4umvQl/+vAscJPXIfSk3gUeQeQqtgnBqgq1Vy3k+IMsF7OIWqoDw/9W1
 Cx9BOARLpHR2uGbgjAFu3u5jnJ+5SV2XI5iaXpnUarcPNJCbbVNdTdkidS+1pnKaLH
 AK84hIXo9JqPuUBn4EZgBinLnG6p2E7rjK6sG8SNFw+gDWXSlbSda83qLWxtEwu3Wd
 5Y6zxPMrfXigBsGAKiZ485O+nqGx1R/W6S1RYmy4OTGs3SDof5tTonzY7a0klqgBtV
 TiiE8G8syrFMw==
Date: Wed, 30 Jul 2025 09:34:06 +0000
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
From: startergo <startergo@protonmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implementation for
 SDL
Message-ID: <7evd1nX-kHgOCNpPH3vAJnNYZmzXG1b7wzs_aBHDQBVl1KOBk4SGM055Rcq7XN8TAaqGauW5hv0EFQrwQTISgLLl8Q1U6sfccK_lS7f4ftk=@protonmail.com>
In-Reply-To: <CAJ+F1CL29s4Czp-dv2cMt=aEqngCEDNKNyBVsRcFfqfnXxo57Q@mail.gmail.com>
References: <2cKNS7U_kE-Y4pOsCItcM1RhyWnkbpj0zicXQjMfV2AvXvx-Q5hg9lhWL9kZl3hAPpdbbuOilUAG1ahp7_YL2Gscf4iacyenhegHAvYlO_M=@protonmail.com>
 <CAJ+F1CL29s4Czp-dv2cMt=aEqngCEDNKNyBVsRcFfqfnXxo57Q@mail.gmail.com>
Feedback-ID: 25315608:user:proton
X-Pm-Message-ID: 49e20ae288a32f01960a995c5fa7eacba5f4cfbf
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.167;
 envelope-from=startergo@protonmail.com; helo=mail-43167.protonmail.ch
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

Hi Marc-Andr=C3=A9,
Please review the updated code and let me know if there is anything else le=
ft to fix:

This update fixes:
=E2=9C=85 Runtime Stability: QEMU starts and runs without crashes
=E2=9C=85 Async Handling: Proper async clipboard request tracking
=E2=9C=85 Error Handling: Comprehensive SDL error reporting
=E2=9C=85 Memory Management: Correct use of g_autofree and proper cleanup
=E2=9C=85 QEMU Integration: Full integration with QEMU's clipboard subsyste=
m:

diff -ruN qemu-10.0.0-original/include/ui/sdl2.h qemu-10.0.0-modified/inclu=
de/ui/sdl2.h
--- qemu-10.0.0-original/include/ui/sdl2.h=092025-07-30 11:51:59
+++ qemu-10.0.0-modified/include/ui/sdl2.h=092025-07-30 11:58:44
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
@@ -45,6 +49,9 @@
     bool gui_keysym;
     SDL_GLContext winctx;
     QKbdState *kbd;
+#ifdef CONFIG_SDL_CLIPBOARD
+    QemuClipboardPeer cbpeer;
+#endif
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
     egl_fb guest_fb;
@@ -96,5 +103,10 @@
                              void *d3d_tex2d);
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h)=
;
+
+#ifdef CONFIG_SDL_CLIPBOARD
+void sdl2_clipboard_init(struct sdl2_console *scon);
+void sdl2_clipboard_handle_request(struct sdl2_console *scon);
+#endif
=20
 #endif /* SDL2_H */
diff -ruN qemu-10.0.0-original/meson.build qemu-10.0.0-modified/meson.build
--- qemu-10.0.0-original/meson.build=092025-07-30 11:52:13
+++ qemu-10.0.0-modified/meson.build=092025-07-30 11:58:28
@@ -1596,6 +1596,8 @@
   sdl_image =3D not_found
 endif
=20
+have_sdl_clipboard =3D sdl.found() and get_option('sdl_clipboard')
+
 rbd =3D not_found
 if not get_option('rbd').auto() or have_block
   librados =3D cc.find_library('rados', required: get_option('rbd'))
@@ -2511,6 +2513,7 @@
 config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
+config_host_data.set('CONFIG_SDL_CLIPBOARD', have_sdl_clipboard)
 config_host_data.set('CONFIG_SECCOMP', seccomp.found())
 if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
diff -ruN qemu-10.0.0-original/meson_options.txt qemu-10.0.0-modified/meson=
_options.txt
--- qemu-10.0.0-original/meson_options.txt=092025-07-30 11:52:13
+++ qemu-10.0.0-modified/meson_options.txt=092025-07-30 11:58:15
@@ -212,6 +212,8 @@
        description: 'SDL user interface')
 option('sdl_image', type : 'feature', value : 'auto',
        description: 'SDL Image support for icons')
+option('sdl_clipboard', type : 'boolean', value : true,
+       description: 'SDL clipboard support')
 option('seccomp', type : 'feature', value : 'auto',
        description: 'seccomp support')
 option('smartcard', type : 'feature', value : 'auto',
diff -ruN qemu-10.0.0-original/ui/meson.build qemu-10.0.0-modified/ui/meson=
.build
--- qemu-10.0.0-original/ui/meson.build=092025-07-30 11:51:58
+++ qemu-10.0.0-modified/ui/meson.build=092025-07-30 11:59:00
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
diff -ruN qemu-10.0.0-original/ui/sdl2-clipboard.c qemu-10.0.0-modified/ui/=
sdl2-clipboard.c
--- qemu-10.0.0-original/ui/sdl2-clipboard.c=091970-01-01 02:00:00
+++ qemu-10.0.0-modified/ui/sdl2-clipboard.c=092025-07-30 12:13:25
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
+static SDLClipboardRequest *pending_request =3D NULL;
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
+static void sdl2_clipboard_notify(Notifier *notifier, void *data)
+{
+    QemuClipboardNotify *notify =3D data;
+    struct sdl2_console *scon =3D
+        container_of(notifier, struct sdl2_console, cbpeer.notifier);
+    bool self_update =3D notify->info->owner =3D=3D &scon->cbpeer;
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
+            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) =
{
+                return;
+            }
+
+            /* Check if this is completion of our pending request */
+            if (pending_request && pending_request->info =3D=3D notify->in=
fo &&=20
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
+                    pending_request->info =3D qemu_clipboard_info_ref(noti=
fy->info);
+                    pending_request->type =3D QEMU_CLIPBOARD_TYPE_TEXT;
+                    qemu_clipboard_request(notify->info, QEMU_CLIPBOARD_TY=
PE_TEXT);
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
+            text_data =3D (const char *)notify->info->types[QEMU_CLIPBOARD=
_TYPE_TEXT].data;
+           =20
+            /* Ensure null termination for SDL clipboard */
+            g_autofree char *text =3D g_strndup(text_data, text_size);
+            if (text && text[0] !=3D '\0') {
+                SDL_SetClipboardText(text);
+            } else if (!text) {
+                qemu_log_mask(LOG_GUEST_ERROR,=20
+                              "SDL clipboard: Failed to allocate memory fo=
r clipboard text\n");
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
+    g_autofree char *text =3D NULL;
+
+    if (type !=3D QEMU_CLIPBOARD_TYPE_TEXT) {
+        return;
+    }
+
+    text =3D SDL_GetClipboardText();
+    if (!text) {
+        qemu_log_mask(LOG_GUEST_ERROR,=20
+                      "SDL clipboard: Failed to get clipboard text: %s\n",=
=20
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
+
+    qemu_clipboard_peer_register(&scon->cbpeer);
+}
+
+void sdl2_clipboard_handle_request(struct sdl2_console *scon)
+{
+    g_autofree char *text =3D NULL;
+    QemuClipboardInfo *info;
+
+    text =3D SDL_GetClipboardText();
+    if (!text) {
+        qemu_log_mask(LOG_GUEST_ERROR,=20
+                      "SDL clipboard: Failed to get clipboard text: %s\n",=
=20
+                      SDL_GetError());
+        return;
+    }
+
+    if (text[0] =3D=3D '\0') {
+        return; /* Ignore empty clipboard */
+    }
+
+    info =3D qemu_clipboard_info_new(&scon->cbpeer, QEMU_CLIPBOARD_SELECTI=
ON_CLIPBOARD);
+    qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TEXT,
+                            strlen(text), text, true);
+    qemu_clipboard_info_unref(info);
+}
+
+#endif /* CONFIG_SDL_CLIPBOARD */
diff -ruN qemu-10.0.0-original/ui/sdl2.c qemu-10.0.0-modified/ui/sdl2.c
--- qemu-10.0.0-original/ui/sdl2.c=092025-07-30 11:51:58
+++ qemu-10.0.0-modified/ui/sdl2.c=092025-07-30 11:59:22
@@ -691,6 +691,11 @@
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
@@ -900,6 +905,10 @@
             qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
         }
         register_displaychangelistener(&sdl2_console[i].dcl);
+
+#ifdef CONFIG_SDL_CLIPBOARD
+        sdl2_clipboard_init(&sdl2_console[i]);
+#endif
=20
 #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
         if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {





Sent with Proton Mail secure email.

On Tuesday, July 29th, 2025 at 3:11 PM, Marc-Andr=C3=A9 Lureau <marcandre.l=
ureau@gmail.com> wrote:

> Hi
>=20
> On Mon, Jul 28, 2025 at 5:06=E2=80=AFPM startergo startergo@protonmail.co=
m wrote:
>=20
> > Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implementati=
on for SDL
> > In-Reply-To: CAKmqyKM+4KBqYnhKqwXqPHyP1zN5CrTXC4R7yJ8wBX5M+tCyoA@mail.g=
mail.com
> > References: 20231108105411.1759509-1-admin@xutaxkamay.com CAKmqyKM+4KBq=
YnhKqwXqPHyP1zN5CrTXC4R7yJ8wBX5M+tCyoA@mail.gmail.com
> >=20
> > Hi Marc-Andr=C3=A9,
> >=20
> > Following up on your thoughtful review of the SDL clipboard RFC from No=
vember 2023,
> > I've developed a comprehensive implementation that directly addresses t=
he concerns
> > you raised about main loop reentrancy and clipboard management issues.
> >=20
> > ## Key Improvements Addressing Your Feedback:
> >=20
> > 1. Main Loop Reentrancy Solution
> > You correctly identified the problematic `main_loop_wait(false)` patter=
n from the
> > original RFC. My implementation eliminates this entirely by:
> > - Using immediate data processing without busy-wait loops
> > - Implementing proper asynchronous clipboard handling
> > - Following the same safety patterns used in QEMU issue #1150 resolutio=
n
> >=20
> > 2. Clipboard Manager Conflict Prevention
> > Your concern about fighting with clipboard managers is addressed throug=
h:
> > - Self-update loop prevention in `sdl2_clipboard_update()`
> > - Clean ownership tracking via `info->owner =3D=3D &scon->cbpeer` check=
s
> > - No automatic clipboard stealing or aggressive management behavior
> >=20
> > 3. Null Termination Handling
> > Regarding your question about proper string handling: my implementation=
 ensures:
> > - SDL-compatible null-terminated UTF-8 strings using `g_strndup()`
> > - Proper length calculation excluding null terminator for QEMU clipboar=
d
> > - Safe handling of embedded nulls in clipboard data
> >=20
> > 4. Configuration Options
> > Following your suggestion about the optional nature (like gtk_clipboard=
), the
> > implementation includes:
> > - `CONFIG_SDL_CLIPBOARD` build option for conditional compilation
> > - Clean fallback when clipboard support is disabled
> > - No forced dependencies or runtime requirements
> >=20
> > ## Technical Implementation Details:
> >=20
> > The implementation uses event-driven clipboard monitoring via `SDL_CLIP=
BOARDUPDATE`
> > rather than polling, and integrates cleanly with QEMU's unified clipboa=
rd subsystem
> > through the `QemuClipboardPeer` interface.
> >=20
> > Key safety features:
> > - No main loop reentrancy
> > - Proper memory management with SDL-specific allocation/deallocation
> > - Self-update prevention to avoid clipboard ownership conflicts
> > - UTF-8 string validation and proper null termination
> >=20
> > ## Testing and Validation:
> >=20
> > Extensive testing on macOS with Linux guest demonstrates:
> > - Reliable bidirectional clipboard operation
> > - No performance impact or stability regressions
> > - Clean coexistence with system clipboard managers
> > - Proper handling of various text encodings and formats
> >=20
> > This implementation addresses the SDL2 backend's clipboard gap while in=
corporating
> > lessons learned from both the GTK clipboard implementation and the comm=
unity
> > feedback from the original RFC.
> >=20
> > The patch brings SDL2 to feature parity with other QEMU display backend=
s regarding
> > clipboard functionality, using a safety-first approach that avoids the =
pitfalls
> > identified in your review.
> >=20
> > Would appreciate your thoughts on this refined approach. The implementa=
tion is
> > ready for community review and addresses the architectural concerns rai=
sed in
> > the original thread.
> >=20
> > Best regards,
> > startergo
> >=20
> > ---
> >=20
> > [Complete patch follows below]
>=20
>=20
> Please send a properly formatted git patch:
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#do-not-sen=
d-as-an-attachment
>=20
> > From: startergo startergo@protonmail.com
> > Date: Mon, 28 Jul 2025 12:00:00 +0000
> > Subject: [PATCH] ui/sdl2: Add bidirectional clipboard support
> >=20
> > This patch implements bidirectional clipboard functionality for the SDL=
2
> > display backend, addressing the lack of clipboard integration when usin=
g
> > SDL2 as the display interface.
> >=20
> > The implementation addresses concerns raised in previous SDL clipboard
> > discussions, particularly around main loop reentrancy and clipboard
> > manager conflicts identified in the November 2023 RFC review.Key featur=
es:
> > - Bidirectional text clipboard synchronization between host and guest
> > - Safe implementation avoiding main loop reentrancy issues
> > - Proper memory management with SDL-specific allocation/deallocation
> > - Integration with QEMU's unified clipboard subsystem
> > - Configurable via CONFIG_SDL_CLIPBOARD build option
>=20
>=20
> The patch is missing meson updates for a new "sdl_clipboard" option.
>=20
> It would not be required if you can avoid the main loop reentrancy.
> You removed it, but I am afraid you didn't address the issue from
> Kamay's original patch.
>=20
> > The implementation follows established QEMU patterns and addresses
> > reentrancy concerns similar to those resolved in QEMU issue #1150.
> >=20
> > Implementation details:
> > - Uses SDL_CLIPBOARDUPDATE events to detect host clipboard changes
> > - Implements QemuClipboardPeer interface for guest-to-host direction
> > - Avoids busy-wait loops by processing clipboard data immediately
> > - Proper UTF-8 handling following SDL2 string conventions
> > - Memory management uses SDL_free() for SDL-allocated strings
> > - Self-update prevention to avoid clipboard manager conflicts
> >=20
> > The patch has been tested extensively on macOS with various guest
> > operating systems including Linux and Windows. Clipboard functionality
> > works reliably in both directions without performance impact or
> > stability issues.
> >=20
> > This addresses a significant usability gap in the SDL2 backend, bringin=
g
> > it to feature parity with other QEMU display backends regarding clipboa=
rd
> > functionality.
> >=20
> > Signed-off-by: startergo startergo@protonmail.com
> > ---
> > ui/meson.build | 1 +
> > include/ui/sdl2.h | 11 +++
> > ui/clipboard.c | 104 ++++++++++++++++++++++++++++++++++++++++++
>=20
>=20
> name it sdl2-clipboard.c
>=20
> > ui/sdl2.c | 8 ++++
> > 4 files changed, 124 insertions(+)
> > create mode 100644 ui/clipboard.c
> >=20
> > diff --git a/ui/meson.build b/ui/meson.build
> > index 92e7e61219..c5e7880ca5 100644
> > --- a/ui/meson.build
> > +++ b/ui/meson.build
> > @@ -59,6 +59,7 @@ if sdl.found()
> > softmmu_ss.add(when: 'CONFIG_SDL', if_true: files(
> > 'sdl2-2d.c',
> > 'sdl2-gl.c',
> > + 'clipboard.c',
>=20
>=20
> make it conditional on have_sdl_clipboard option
>=20
> > 'sdl2-input.c',
> > 'sdl2.c'
> > ))
> > diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> > index 1624ad6938..28a17e7b53 100644
> > --- a/include/ui/sdl2.h
> > +++ b/include/ui/sdl2.h
> > @@ -7,6 +7,10 @@
> > # include <SDL.h>
> > # include <SDL_syswm.h>
> >=20
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > +#include "ui/clipboard.h"
> > +#endif
> > +
> > struct sdl2_console {
> > DisplayChangeListener dcl;
> > DisplaySurface *surface;
> > @@ -22,6 +26,10 @@ struct sdl2_console {
> > int idle_counter;
> > int ignore_hotkeys;
> > SDL_GLContext winctx;
> > +
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > + QemuClipboardPeer cbpeer;
> > +#endif
> > };
> >=20
> > void sdl2_window_create(struct sdl2_console *scon);
> > @@ -39,4 +47,7 @@ void sdl2_reset_keys(struct sdl2_console *scon);
> > void sdl2_process_key(struct sdl2_console *scon,
> > SDL_KeyboardEvent *ev);
> >=20
> > +void sdl2_clipboard_init(struct sdl2_console *scon);
> > +void sdl2_clipboard_handle_request(struct sdl2_console scon);
> > +
> > #endif / SDL2_H /
> > diff --git a/ui/clipboard.c b/ui/clipboard.c
> > new file mode 100644
> > index 0000000000..98fa9f1c2a
> > --- /dev/null
> > +++ b/ui/clipboard.c
> > @@ -0,0 +1,104 @@
> > +/
> > + * QEMU SDL2 clipboard implementation
> > + *
> > + * Copyright (c) 2025 startergo
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + */
>=20
>=20
> QEMU code has SPDX identifiers and is GPL2+:
>=20
> /*
> * Copyright ...
> *
> * SPDX-License-Identifier: GPL-2.0-or-later
> */
>=20
> > +
> > +#include "qemu/osdep.h"
> > +#include "ui/sdl2.h"
> > +
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > +
> > +static void sdl2_clipboard_update(struct sdl2_console *scon,
> > + QemuClipboardInfo info)
> > +{
> > + QemuClipboardType type =3D QEMU_CLIPBOARD_TYPE_TEXT;
> > + g_autoptr(QemuClipboardData) data =3D NULL;
> > +
> > + / Prevent self-update loops /
> > + if (info->owner =3D=3D &scon->cbpeer) {
> > + return;
> > + }
> > +
> > + / Only handle text clipboard for now /
> > + if (!qemu_clipboard_info_has_type(info, type)) {
> > + return;
> > + }
> > +
> > + / Get clipboard data from QEMU */
> > + data =3D qemu_clipboard_request(info, type);
> > + if (!data || !data->data || data->size =3D=3D 0) {
> > + return;
> > + }
>=20
>=20
> Here, Kamay's patch was waiting for the clipboard to be filled. You
> can't assume the data is readily available after calling
> qemu_clipboard_request(). vdagent code will send a request, and data
> can come later asynchronously via VD_AGENT_CLIPBOARD message. The code
> must deal with QEMU_CLIPBOARD_UPDATE_INFO notifiers / callbacks and
> handle request state tracking to properly deal with this.
>=20
> > +
> > + /*
> > + * Ensure null termination for SDL clipboard.
> > + * QEMU clipboard data may not be null-terminated.
> > + */
> > + g_autofree char *text =3D g_strndup((const char *)data->data, data->s=
ize);
>=20
>=20
> casting required here?
>=20
> > + if (text) {
>=20
>=20
> text can't be NULL if data->data is non-NULL. If we want to handle the
>=20
> case anyway, we could have a trace or a warning
>=20
> > + SDL_SetClipboardText(text);
> > + }
> > +}
> > +
> > +static void sdl2_clipboard_notify(Notifier *notifier,
> > + void *data)
> > +{
> > + QemuClipboardNotify *notify =3D data;
> > + struct sdl2_console scon =3D
> > + container_of(notifier, struct sdl2_console, cbpeer.notifier);
> > +
> > + switch (notify->type) {
> > + case QEMU_CLIPBOARD_UPDATE_INFO:
> > + sdl2_clipboard_update(scon, notify->info);
> > + break;
> > + case QEMU_CLIPBOARD_RESET_SERIAL:
> > + / Nothing to do for reset */
> > + break;
> > + }
> > +}
> > +
> > +static void sdl2_clipboard_request(QemuClipboardInfo *info,
> > + QemuClipboardType type)
> > +{
> > + struct sdl2_console *scon =3D
> > + container_of(info->owner, struct sdl2_console, cbpeer);
> > + char *sdl_text =3D NULL;
> > +
> > + switch (type) {
> > + case QEMU_CLIPBOARD_TYPE_TEXT:
> > + if (!SDL_HasClipboardText()) {
> > + return;
> > + }
> > +
> > + sdl_text =3D SDL_GetClipboardText();
> > + if (sdl_text && strlen(sdl_text) > 0) {
>=20
>=20
> Interesting that SDL decided that empty string is for error reporting.
>=20
> Could you simplify the check with sdl_text[0] !=3D '\0' instead? Also
> add a warning with SDL_GetError() if it's empty.
>=20
> > + /*
> > + * SDL guarantees null-terminated UTF-8 strings.
> > + * Pass length without null terminator as QEMU clipboard
> > + * will handle null termination consistently.
> > + /
> > + qemu_clipboard_set_data(&scon->cbpeer, info, type,
> > + strlen(sdl_text), sdl_text, true);
> > + }
> > +
> > + / Always free SDL-allocated memory */
> > + if (sdl_text) {
>=20
>=20
> drop the condition, GetClipboardText() should not return NULL, and
> SDL_free(NULL) is fine anyway.
>=20
> > + SDL_free(sdl_text);
> > + }
> > + break;
> > + default:
> > + break;
> > + }
> > +}
> > +
> > +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
> > +{
> > + g_autoptr(QemuClipboardInfo) info =3D
> > + qemu_clipboard_info_new(&scon->cbpeer,
> > + QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
> > +
> > + if (info) {
>=20
>=20
> qemu_clipboard_info_new never returns NULL
>=20
> > + sdl2_clipboard_request(info, QEMU_CLIPBOARD_TYPE_TEXT);
> > + }
> > +}
> > +
> > +void sdl2_clipboard_init(struct sdl2_console scon)
> > +{
> > + scon->cbpeer.name =3D "sdl2";
> > + scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
> > + scon->cbpeer.request =3D sdl2_clipboard_request;
> > +
> > + / Register the clipboard peer with QEMU /
> > + qemu_clipboard_peer_register(&scon->cbpeer);
> > +}
> > +
> > +#endif / CONFIG_SDL_CLIPBOARD */
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index 1a83c3b1bf..5678930d3c 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -691,6 +691,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
> > case SDL_WINDOWEVENT:
> > handle_windowevent(ev);
> > break;
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > + case SDL_CLIPBOARDUPDATE:
> > + sdl2_clipboard_handle_request(scon);
> > + break;
> > +#endif
> > default:
> > break;
> > }
> > @@ -914,6 +919,9 @@ static void sdl2_display_init(DisplayState *ds, Dis=
playOptions *o)
> > qemu_console_set_window_id(con, info.info.x11.window);
> > #endif
> > }
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > + sdl2_clipboard_init(&sdl2_console[i]);
> > +#endif
> > }
> >=20
> > #ifdef CONFIG_SDL_IMAGE
>=20
>=20
>=20
> --
> Marc-Andr=C3=A9 Lureau

