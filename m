Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB0DEDA682
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRUg-0004zO-DN; Tue, 03 Mar 2026 10:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxRTx-0004iF-Uc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:16:23 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxRTt-00054H-II
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:16:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772550962; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m1u7ZMvTaZrKKdbNW4pf68yLwXhjrZGQEiNqh5g4F8gBqFO6pFrun6+p72dsGffivtPVzoM9pfPzLIWwYG6qBWLqAuf8xJzEcpCQJsy3Zp2QsfwkPsCPUVmsffh3bnNCmJhfSXq7aaF/LuKTNVUXKbR6vhThU72v8pG+/BURhmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772550962;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GRpBlbDlmsyTLQtznegN0hg2YNBNPJ1ljfhioI5VFgQ=; 
 b=Zemqt4/KEINxjjBci0s2yRofy+D2SJukL2neVYL1zS7oOo/ypBm3e8zfAwg1F1pjB5xPmJoENoPoREj5Dn6R0e8ZimXbNiQ+PjBmjWhjbmowfNbYZ78pxYy20te/2/BRZxfS/qu8uc9FAYV2GAcNP2EzReaTV2TsIK4F3s+qWF0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772550961; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=GRpBlbDlmsyTLQtznegN0hg2YNBNPJ1ljfhioI5VFgQ=;
 b=XbNWL1ddeTXB+LPzrjryFBI0eRICplp0G1J5cd7neBNHhU4FhA7xOgj0zPaIbQUw
 tjrF5E+8h6wrLlzZhF4TRt60JdPkbljrgUVtFCCnF6Bz+4B03bUY3mZFcPpQ0h6McRD
 AiWuv4TNQ2ZMl56LAj4d4CJHPEZbPcCym5RWYNDA=
Received: by mx.zohomail.com with SMTPS id 1772550958934978.0069638685444;
 Tue, 3 Mar 2026 07:15:58 -0800 (PST)
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
Subject: [PATCH v22 03/18] ui/egl: Don't change bound GL context when creating
 new context
Date: Tue,  3 Mar 2026 18:14:06 +0300
Message-ID: <20260303151422.977399-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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
from a given shared GL context instead of a currently-bound context.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/ui/egl-context.h | 3 ++-
 ui/dbus.c                | 4 +---
 ui/egl-context.c         | 6 +++---
 ui/egl-headless.c        | 4 +---
 ui/gtk-egl.c             | 4 +---
 ui/spice-display.c       | 4 +---
 6 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/ui/egl-context.h b/include/ui/egl-context.h
index c2761d747a4e..4d559ae7bd46 100644
--- a/include/ui/egl-context.h
+++ b/include/ui/egl-context.h
@@ -5,7 +5,8 @@
 #include "ui/egl-helpers.h"
 
 QEMUGLContext qemu_egl_create_context(DisplayGLCtx *dgc,
-                                      QEMUGLParams *params);
+                                      QEMUGLParams *params,
+                                      EGLContext share_context);
 void qemu_egl_destroy_context(DisplayGLCtx *dgc, QEMUGLContext ctx);
 int qemu_egl_make_context_current(DisplayGLCtx *dgc,
                                   QEMUGLContext ctx);
diff --git a/ui/dbus.c b/ui/dbus.c
index 905ee6fea71b..4f24215555a4 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -47,9 +47,7 @@ static DBusDisplay *dbus_display;
 static QEMUGLContext dbus_create_context(DisplayGLCtx *dgc,
                                          QEMUGLParams *params)
 {
-    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
-                   qemu_egl_rn_ctx);
-    return qemu_egl_create_context(dgc, params);
+    return qemu_egl_create_context(dgc, params, qemu_egl_rn_ctx);
 }
 
 static bool
diff --git a/ui/egl-context.c b/ui/egl-context.c
index aed3e3ba1f3f..5787199347bc 100644
--- a/ui/egl-context.c
+++ b/ui/egl-context.c
@@ -3,7 +3,8 @@
 #include "ui/egl-context.h"
 
 QEMUGLContext qemu_egl_create_context(DisplayGLCtx *dgc,
-                                      QEMUGLParams *params)
+                                      QEMUGLParams *params,
+                                      EGLContext share_context)
 {
    EGLContext ctx;
    EGLint ctx_att_core[] = {
@@ -19,8 +20,7 @@ QEMUGLContext qemu_egl_create_context(DisplayGLCtx *dgc,
    };
    bool gles = (qemu_egl_mode == DISPLAY_GL_MODE_ES);
 
-   ctx = eglCreateContext(qemu_egl_display, qemu_egl_config,
-                          eglGetCurrentContext(),
+   ctx = eglCreateContext(qemu_egl_display, qemu_egl_config, share_context,
                           gles ? ctx_att_gles : ctx_att_core);
    return ctx;
 }
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 1f6b845500dd..352b30b43fb9 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -42,9 +42,7 @@ static void egl_gfx_switch(DisplayChangeListener *dcl,
 static QEMUGLContext egl_create_context(DisplayGLCtx *dgc,
                                         QEMUGLParams *params)
 {
-    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
-                   qemu_egl_rn_ctx);
-    return qemu_egl_create_context(dgc, params);
+    return qemu_egl_create_context(dgc, params, qemu_egl_rn_ctx);
 }
 
 static void egl_scanout_disable(DisplayChangeListener *dcl)
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0dbb429958e5..1b5c1d4533c0 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -219,9 +219,7 @@ QEMUGLContext gd_egl_create_context(DisplayGLCtx *dgc,
 {
     VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
 
-    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                   vc->gfx.esurface, vc->gfx.ectx);
-    return qemu_egl_create_context(dgc, params);
+    return qemu_egl_create_context(dgc, params, vc->gfx.ectx);
 }
 
 void gd_egl_scanout_disable(DisplayChangeListener *dcl)
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 28399f8a8174..5052f371f44e 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1033,9 +1033,7 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
 static QEMUGLContext qemu_spice_gl_create_context(DisplayGLCtx *dgc,
                                                   QEMUGLParams *params)
 {
-    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
-                   qemu_egl_rn_ctx);
-    return qemu_egl_create_context(dgc, params);
+    return qemu_egl_create_context(dgc, params, qemu_egl_rn_ctx);
 }
 
 static void qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
-- 
2.52.0


