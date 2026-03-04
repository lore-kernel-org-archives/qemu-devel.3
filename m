Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8263DEF900B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR0-0003qw-SC; Wed, 04 Mar 2026 11:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQy-0003pt-KJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:52 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQv-0002PZ-PS
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:52 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso545654766b.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643048; x=1773247848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fXH7Ub5GEQ4cWHh3k0llbn9h1K4aZuQosk7zKiteZE=;
 b=W0+g0GqBr8rOtdvAZuSaV95AdIJDwer5bK2LJmLUH/aYR56pVFHsdCggih7V8oDtN1
 cTelGhekpTJL8YvPTZCfZLYZ8gp2dQcwwXTwlmhTT4K5DtR/yYoAj/Pl6CSfXGc3FPwy
 MyUakFEZlTnQifr3XcNGdRM0s12m+1cFqCaQ48GyaA86gnt9cUc2/eydYu6DPBX10DUS
 +7TT6TjSR4ljc4kP357NY1eV6QJpLl/XUcv+2HpTWj7miPkrg9yg71f+5IzJKGkQXEP+
 5zvhmnVWz63UAFzxalwfeX1DnPwpf9VvpXxtXyh8RIxLHTTHU/U4aEGxVvWzQQDJvXOb
 a2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643048; x=1773247848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7fXH7Ub5GEQ4cWHh3k0llbn9h1K4aZuQosk7zKiteZE=;
 b=WGqB15urThePQQuqDNdruqIZFiidyXJohoGetF74rOZkUVhuv/IAY3CJDcqvp0GO0W
 HAMtcOe6xavNPHEEpa8cjjPA6u/n1QK2XZezeB096acRe66DaO67xp01TOtONfD4wAT6
 WHjmG61oONgb7Ni+qRpA86ldppdMH0Zt0IE8vLTcMuWUUkg/nsTFEKm4cBpi92Za2Ewj
 3mhQXx9ZeZVev7Sc4tYtdjfVrOGAaq1ezcYA9e7DSW/DghXC+vaEouJ6w99EzUhk/qgd
 HGgX2b/WIeUXnG8O8/bOYZB5Tqly2xGlKiqxhZjpujZd9oipDso69gqH31EYrNSblIhf
 87yA==
X-Gm-Message-State: AOJu0YyYw0e+nGK7twEA0b2T4A6dJKBQQTfk0yXjxENyA/hBIgrn4GS1
 cxivS0mzCvQkAuic2Sz8aoWUcFTX0vjV3/fOy127xmSiNbhh3TlCeKfEkxHEfqjqxos=
X-Gm-Gg: ATEYQzw47vnEWEWKgVyAHtbyhDnSW0UVdfMztLT1BTM2CdmuId/0ixya2M2KWaC0ePy
 35ynpbmN/1WrY4RtiPY92yLZnvZXpunzMUeSzg87RTsCDkx3HQZcan+bCj8E8Is9xFUpeNlJi2p
 TnA5bF6x6qoSTtXwFphRmzzVVq4tKKaGaqjM7GUYIX+sri45xy/eGu8Qb+abXN8Sp4n5s7lQKIH
 DAtDn9ax9/Rc2kmYi0yRuACX+urKD1PFnJY00ZDzzUJ3gNz+VEL8jOSGwJw3hXNmnqKvYKT7dxH
 DQ2kZYQmNKhztycNSYGSUqrOPA66/DqGNmH4bcq6XVI4WDszsbT0E524oeyGUcUff0i1/hkPGh1
 7KFdSesjq2u9zOWpL8Fck7rjyZq/4NF384B9bqm2j10EfzjT2nD9rmYI7E7P6Glg49/Jhy2bLyP
 pLl2iuyjqyf/oULVYKpiBe9rNKz1sC0Xy9rw==
X-Received: by 2002:a17:907:c25:b0:b8f:dec3:6606 with SMTP id
 a640c23a62f3a-b93f01f5b0dmr182043266b.23.1772643047934; 
 Wed, 04 Mar 2026 08:50:47 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ae94441sm761499366b.50.2026.03.04.08.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2FF2960BBE;
 Wed, 04 Mar 2026 16:50:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/20] ui/egl: Don't change bound GL context when creating new
 context
Date: Wed,  4 Mar 2026 16:50:27 +0000
Message-ID: <20260304165043.1437519-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Don't change bound GL context when creating new GL context for consistency
with behavior expected by virglrenderer that assumes context-creation doesn't
switch context. eglCreateContext() doesn't require GL context to be bound
when it's invoked. Update qemu_egl_create_context() to spawn GL sub-contexts
from a given shared GL context instead of a currently-bound context.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-4-dmitry.osipenko@collabora.com>
---
 include/ui/egl-context.h | 3 ++-
 ui/dbus.c                | 4 +---
 ui/egl-context.c         | 6 +++---
 ui/egl-headless.c        | 4 +---
 ui/gtk-egl.c             | 4 +---
 ui/spice-display.c       | 4 +---
 6 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/ui/egl-context.h b/include/ui/egl-context.h
index c2761d747a4..4d559ae7bd4 100644
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
index 905ee6fea71..4f24215555a 100644
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
index aed3e3ba1f3..5787199347b 100644
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
index 1f6b845500d..352b30b43fb 100644
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
index 0dbb429958e..1b5c1d4533c 100644
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
index 28399f8a817..5052f371f44 100644
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
2.47.3


