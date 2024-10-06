Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51935CFB43F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 23:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxadm-0004aa-K4; Sun, 06 Oct 2024 19:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxadk-0004aM-Q1
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:26:16 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxadi-0006ZN-SP
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:26:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728257164; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Qc7N+fMCbJktUQ9F22+0+Kbcd/7wnpBtQTxyb5yicH+/yAzv2RVJBrHjz7z1ETCGcFc1eRGTZpbHSmNF3oGW90KI4VhCPtlcrrKPtxOpp1E0tgbk2qZVGt3CPwAcnUZE8g5YBkLkXr45CQcHScf55/5BzsIqCUWiphUFl399g2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728257164;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=eIurEWsj2XwkNRA1nzc4g5x7lZhX2wTgCiuU0Ur/Ms0=; 
 b=KDgBMw/DCxp5E3kfJ/oLGpGTk0sSrCeWnNz0a5oRz4YcBavflcU+zHdkxCBMuWxX5M22Bd8k/rVYHLY2GbZnA7eFOC2apYMUB6b8CGh/A+pVEztt2W+VnFK1UWuUUKstcak/ELvjlCgGtnIzL82KY9dRw0OgA0FUFxU0IOmfSFg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728257164; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=eIurEWsj2XwkNRA1nzc4g5x7lZhX2wTgCiuU0Ur/Ms0=;
 b=ICcdVPTA45zUfisoULug0HLNDNfwoiRn9WpUCaN3yGyyBSAFHz6saoT3vJIRUnBp
 hqxlH9b9RnbOO81FdpBX9B6KEUOzE6auQs9cqp93iFVd0RSID8Bwqt/gKChgiyVlqrQ
 NBWY7gbBZro6v5+vL+GLI56xqGqa+zBMrN7M9KtU=
Received: by mx.zohomail.com with SMTPS id 1728257162466200.90958735807408;
 Sun, 6 Oct 2024 16:26:02 -0700 (PDT)
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
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>
Subject: [PATCH v1 2/6] ui/sdl2: Implement dpy dmabuf functions
Date: Mon,  7 Oct 2024 02:23:44 +0300
Message-ID: <20241006232350.3198759-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
References: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/ui/sdl2.h |  5 +++++
 ui/sdl2-gl.c      | 39 +++++++++++++++++++++++++++++++++++++++
 ui/sdl2.c         |  8 ++++++++
 3 files changed, 52 insertions(+)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index dbe6e3d9739b..b14552f5cd71 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -96,5 +96,10 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              void *d3d_tex2d);
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
+void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf);
+void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf);
+bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl);
 
 #endif /* SDL2_H */
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index b1fe96d6af22..24aa9108682e 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
@@ -227,6 +228,44 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                          backing_id, false);
 }
 
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
+        fprintf(stderr, "sdl2_gl_scanout_dmabuf failed fd=%d\n",
+                qemu_dmabuf_get_fd(dmabuf));
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
+    return qemu_egl_has_dmabuf();
+}
+
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4f5a9da14a..8c7b01c5e62f 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -120,6 +120,9 @@ void sdl2_window_create(struct sdl2_console *scon)
         /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
         scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
     }
+
+    qemu_egl_display = eglGetCurrentDisplay();
+
     sdl_update_caption(scon);
 }
 
@@ -820,6 +823,10 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
     .dpy_gl_scanout_disable  = sdl2_gl_scanout_disable,
     .dpy_gl_scanout_texture  = sdl2_gl_scanout_texture,
     .dpy_gl_update           = sdl2_gl_scanout_flush,
+
+    .dpy_gl_scanout_dmabuf   = sdl2_gl_scanout_dmabuf,
+    .dpy_gl_release_dmabuf   = sdl2_gl_release_dmabuf,
+    .dpy_has_dmabuf          = sdl2_gl_has_dmabuf,
 };
 
 static bool
@@ -877,6 +884,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
     SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
+    SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
     SDL_EnableScreenSaver();
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
-- 
2.46.0


