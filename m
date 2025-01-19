Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18A9C02188
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 22:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZdN4-0006zd-Kb; Sun, 19 Jan 2025 17:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tZdN3-0006zV-NG
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 17:02:17 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tZdN1-00088T-Sg
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 17:02:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1737324122; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Cn0qTSvoODZto6H9a++Z8A94Gmhj9qEI6bggZ8KI2ZyHE79G/SpNJU+Ue+WkbQNNlrGC7w25MJm6Qtk+cOTWcDZ8J+Ey9IqW3FIm6mOttdqesz7xbmIMBSvWWysKINM1vL9/ApsRePAOOtT1Wjn5L4XT7+Lg+iyecwIxb8xtahg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1737324122;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DpPWhIypfFDYHBoj2i6RsYn1N4Ci3PZZL6BPDqW8IvE=; 
 b=C9Tk9UCugy7qqCRkjiw6x8OMMKookP6n3RbkokEWslTQcnns4Oa0EOEiydiOpMqbfLXfHcxPolYvOQFAVvsK00ZLvANB5swL4C3lNol980u6eX9Kd4zHZIUdbQ59gGhtkNdhbgBWa89KDER9kOpUnc1yysSkeh0y7+ayPgwW4/U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737324122; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DpPWhIypfFDYHBoj2i6RsYn1N4Ci3PZZL6BPDqW8IvE=;
 b=kcGOn1EdnSC4waPR0VTPBb9IFn4g+pgwmiRnRYY0ODAYSRDo7LFbQtqWrkXJDeuQ
 6bfeWs8NDQWRpQbHrQX+AgOBGoVLL6XHs3wwOAicsZzu8vzz60uNavkJTAblhT8sHSF
 F3Xi1Vubom+2g2kJJk1DhdmzbumMmtI8r3tWl7Ns=
Received: by mx.zohomail.com with SMTPS id 1737324120824538.5774136725563;
 Sun, 19 Jan 2025 14:02:00 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v5 2/8] ui/sdl2: Implement dpy dmabuf functions
Date: Mon, 20 Jan 2025 01:00:44 +0300
Message-ID: <20250119220050.15167-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.024,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

If EGL is used, we can rely on dmabuf to import textures without
doing copies.

To get this working on X11, we use the existing SDL hint:
SDL_HINT_VIDEO_X11_FORCE_EGL (because dmabuf can't be used with GLX).

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/ui/sdl2.h |  7 ++++++
 meson.build       |  6 ++---
 ui/sdl2-gl.c      | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 ui/sdl2.c         | 42 +++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index dbe6e3d9739b..9daf5ecffae7 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -45,6 +45,7 @@ struct sdl2_console {
     bool gui_keysym;
     SDL_GLContext winctx;
     QKbdState *kbd;
+    bool has_dmabuf;
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
     egl_fb guest_fb;
@@ -96,5 +97,11 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              void *d3d_tex2d);
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
+void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf);
+void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf);
+bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl);
+void sdl2_gl_console_init(struct sdl2_console *scon);
 
 #endif /* SDL2_H */
diff --git a/meson.build b/meson.build
index 15a066043b7b..dfee104582b0 100644
--- a/meson.build
+++ b/meson.build
@@ -1964,10 +1964,8 @@ if get_option('gtk') \
   endif
 endif
 
-x11 = not_found
-if gtkx11.found()
-  x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
-endif
+x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
+
 png = not_found
 if get_option('png').allowed() and have_system
    png = dependency('libpng', version: '>=1.6.34', required: get_option('png'),
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index b1fe96d6af22..8d53e340d40d 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -26,6 +26,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
@@ -249,3 +251,65 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
 
     SDL_GL_SwapWindow(scon->real_window);
 }
+
+void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf)
+{
+    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
+
+    assert(scon->opengl);
+    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
+
+    egl_dmabuf_import_texture(dmabuf);
+    if (!qemu_dmabuf_get_texture(dmabuf)) {
+        error_report("%s: failed fd=%d", __func__, qemu_dmabuf_get_fd(dmabuf));
+        return;
+    }
+
+    sdl2_gl_scanout_texture(dcl, qemu_dmabuf_get_texture(dmabuf), false,
+                            qemu_dmabuf_get_width(dmabuf),
+                            qemu_dmabuf_get_height(dmabuf),
+                            0, 0,
+                            qemu_dmabuf_get_width(dmabuf),
+                            qemu_dmabuf_get_height(dmabuf),
+                            NULL);
+
+    if (qemu_dmabuf_get_allow_fences(dmabuf)) {
+        scon->guest_fb.dmabuf = dmabuf;
+    }
+}
+
+void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf)
+{
+    egl_dmabuf_release_texture(dmabuf);
+}
+
+bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl)
+{
+    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
+
+    return scon->has_dmabuf;
+}
+
+void sdl2_gl_console_init(struct sdl2_console *scon)
+{
+    bool hidden = scon->hidden;
+
+    scon->hidden = true;
+    scon->surface = qemu_create_displaysurface(1, 1);
+    sdl2_window_create(scon);
+
+    /*
+     * QEMU checks whether console supports dma-buf before switching
+     * to the console.  To break this chicken-egg problem we pre-check
+     * dma-buf availability beforehand using a dummy SDL window.
+     */
+    scon->has_dmabuf = qemu_egl_has_dmabuf();
+
+    sdl2_window_destroy(scon);
+    qemu_free_displaysurface(scon->surface);
+
+    scon->surface = NULL;
+    scon->hidden = hidden;
+}
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 445eb1dd9f9a..3e262b994231 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -36,6 +36,10 @@
 #include "qemu/log.h"
 #include "qemu-main.h"
 
+#ifdef CONFIG_X11
+#include <X11/Xlib.h>
+#endif
+
 static int sdl2_num_outputs;
 static struct sdl2_console *sdl2_console;
 
@@ -121,6 +125,9 @@ void sdl2_window_create(struct sdl2_console *scon)
         /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
         scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
     }
+
+    qemu_egl_display = eglGetCurrentDisplay();
+
     sdl_update_caption(scon);
 }
 
@@ -821,6 +828,10 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
     .dpy_gl_scanout_disable  = sdl2_gl_scanout_disable,
     .dpy_gl_scanout_texture  = sdl2_gl_scanout_texture,
     .dpy_gl_update           = sdl2_gl_scanout_flush,
+
+    .dpy_gl_scanout_dmabuf   = sdl2_gl_scanout_dmabuf,
+    .dpy_gl_release_dmabuf   = sdl2_gl_release_dmabuf,
+    .dpy_has_dmabuf          = sdl2_gl_has_dmabuf,
 };
 
 static bool
@@ -848,6 +859,35 @@ static void sdl2_display_early_init(DisplayOptions *o)
     }
 }
 
+static void sdl2_set_hint_x11_force_egl(void)
+{
+#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) && \
+    defined(CONFIG_X11)
+    Display *x_disp = XOpenDisplay(NULL);
+    EGLDisplay egl_display;
+
+    if (!x_disp) {
+        return;
+    }
+
+    /* Prefer EGL over GLX to get dma-buf support. */
+    egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);
+
+    if (egl_display != EGL_NO_DISPLAY) {
+        /*
+         * Setting X11_FORCE_EGL hint doesn't make SDL to prefer X11 over
+         * Wayland. SDL will use Wayland driver even if XWayland presents.
+         * It's always safe to set the hint even if X11 is not used by SDL.
+         * SDL will work regardless of the hint.
+         */
+        SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
+        eglTerminate(egl_display);
+    }
+
+    XCloseDisplay(x_disp);
+#endif
+}
+
 static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 {
     uint8_t data = 0;
@@ -878,6 +918,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
     SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
+    sdl2_set_hint_x11_force_egl();
     SDL_EnableScreenSaver();
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
@@ -924,6 +965,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         sdl2_console[i].kbd = qkbd_state_init(con);
         if (display_opengl) {
             qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
+            sdl2_gl_console_init(&sdl2_console[i]);
         }
         register_displaychangelistener(&sdl2_console[i].dcl);
 
-- 
2.47.1


