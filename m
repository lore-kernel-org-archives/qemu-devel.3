Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA9AEA4E18
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 15:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx4m1-0004WG-Ek; Mon, 02 Mar 2026 10:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vx4lU-0004FN-ME
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:00:57 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vx4lR-00042O-6Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:00:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772463628; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mk9BlPwQppN/o9h0hQmgIvM0vuKdmun6VPkewbm4IO2iZBypAed0+fnUFNutZ9D3/Ow+rkKnIL/vK7tv1Y+vqzVckHWrj2yq7Sg1q4+mERHZ2JtGRiTTtT75u+XLY7q3DVI10fW5o4oR7euB9YuRiR6sv/GuQCOLqFD0RLmRQr8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772463628;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=C6bVJ5uFMUnYseJrdFu6UyXmpjkVTiLLY8DT2cYl7iM=; 
 b=T8l/cmRMly33tr7d7t17qyNKPYlt9PygKdWRC5e1KqRAC7i8KrsYrrx2NecczltflCedTT3rnA9rIhtw3bY9EonCNFM8iBVzAtoMZQfkJPb4DVrSx0BnIKU7+DPvwXrAvs7CEU0jfOVjCA0Zd0l11iKrMETkP5ATQVtvGq0VT7s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772463628; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=C6bVJ5uFMUnYseJrdFu6UyXmpjkVTiLLY8DT2cYl7iM=;
 b=bUnGOmAL37AxbGIE/z2qQedBNWxodippHN2eaxSfIazLDH+S7zha9jERFZkyIsxd
 1HmnWoQFMqnG4/4RqG3nHgGgD4jw1E+PUl8OcuZvU6jY76s8qbtMqDaH47zePyU3UCA
 snvP5TNa6LkZCshMgI+Kznvx3tgf63kbhOOvSH0k=
Received: by mx.zohomail.com with SMTPS id 1772463627488906.8360510487804;
 Mon, 2 Mar 2026 07:00:27 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v21 03/18] ui/egl: Don't change bound GL context when creating
 new context
Date: Mon,  2 Mar 2026 17:59:05 +0300
Message-ID: <20260302145920.735423-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
References: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Don't change bound GL context when creating new GL context for consistency
with behavior expected by virglrenderer that assumes context-creation doesn't
switch context. eglCreateContext() doesn't require GL context to be bound
when it's invoked. Update qemu_egl_create_context() to spawn GL sub-contexts
from a common parent GL context instead of a currently-bound context.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/dbus.c          | 2 --
 ui/egl-context.c   | 3 +--
 ui/egl-headless.c  | 2 --
 ui/gtk-egl.c       | 4 ----
 ui/spice-display.c | 2 --
 5 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/ui/dbus.c b/ui/dbus.c
index 905ee6fea71b..750a064e3fbf 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -47,8 +47,6 @@ static DBusDisplay *dbus_display;
 static QEMUGLContext dbus_create_context(DisplayGLCtx *dgc,
                                          QEMUGLParams *params)
 {
-    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
-                   qemu_egl_rn_ctx);
     return qemu_egl_create_context(dgc, params);
 }
 
diff --git a/ui/egl-context.c b/ui/egl-context.c
index aed3e3ba1f3f..f9a998768beb 100644
--- a/ui/egl-context.c
+++ b/ui/egl-context.c
@@ -19,8 +19,7 @@ QEMUGLContext qemu_egl_create_context(DisplayGLCtx *dgc,
    };
    bool gles = (qemu_egl_mode == DISPLAY_GL_MODE_ES);
 
-   ctx = eglCreateContext(qemu_egl_display, qemu_egl_config,
-                          eglGetCurrentContext(),
+   ctx = eglCreateContext(qemu_egl_display, qemu_egl_config, qemu_egl_rn_ctx,
                           gles ? ctx_att_gles : ctx_att_core);
    return ctx;
 }
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 1f6b845500dd..19955792ac95 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -42,8 +42,6 @@ static void egl_gfx_switch(DisplayChangeListener *dcl,
 static QEMUGLContext egl_create_context(DisplayGLCtx *dgc,
                                         QEMUGLParams *params)
 {
-    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
-                   qemu_egl_rn_ctx);
     return qemu_egl_create_context(dgc, params);
 }
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0dbb429958e5..6b3519419039 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -217,10 +217,6 @@ void gd_egl_switch(DisplayChangeListener *dcl,
 QEMUGLContext gd_egl_create_context(DisplayGLCtx *dgc,
                                     QEMUGLParams *params)
 {
-    VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
-
-    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                   vc->gfx.esurface, vc->gfx.ectx);
     return qemu_egl_create_context(dgc, params);
 }
 
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 28399f8a8174..ae0f771c2a38 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1033,8 +1033,6 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
 static QEMUGLContext qemu_spice_gl_create_context(DisplayGLCtx *dgc,
                                                   QEMUGLParams *params)
 {
-    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
-                   qemu_egl_rn_ctx);
     return qemu_egl_create_context(dgc, params);
 }
 
-- 
2.52.0


