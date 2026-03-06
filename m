Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA82FCC062
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDM-0005yg-Sy; Fri, 06 Mar 2026 14:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCP-0004Cj-1D
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCM-0000Qn-M1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4837584120eso74144955e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826657; x=1773431457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2kV+uwRVblqcYCucxpenxbvBTbdi2je9MkAk6XrOXE=;
 b=mnWF8Qhl4ziSh89UPWvY4MB7YxhiyvtHQrIGjg6GAZ3GR5K+ErCjlD1hxXYfno4YQu
 g7C+Aiw7/iBSAPpVXbgKQrDbSmTX/QYcUQqzFdZl4ZFvCpKwDd41cl/3qAh8NA/lytO4
 /GdospuNA9DqsJB3tPukEfv6rR1YqHwpKlrQp/WcF//itOCpR67oiiBpn0sBuUdP+fWU
 1sbHhlv/PDS8HHnUScK/FzAK/Wf3FNP1wuOcvzxS7KLlnPA9YsblmLlzmmVFm6ZHsDV0
 Fi/05GXOGChEWtl2NaBMxOshhyIzxiydSWMAofbDLyKg3Nk6CqK0cobrJhao1lVSrp8Q
 G1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826657; x=1773431457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a2kV+uwRVblqcYCucxpenxbvBTbdi2je9MkAk6XrOXE=;
 b=XeRZTG8nmxzcW6CBE3b79JIJpUJg5JyYWnkqTPyHkJ/a6lnE/cGTLUZBEuw9TSClxR
 yoWi8WID9tYYhLSBotQYXZNJUq8/7UK2IhfcbKPeKI9ywDN2emP0HQOTJGguw8HoiTRv
 liWyZ0fJkjKb6U0syVLhrmmjl1mYOO/Syku7UXjh3S45ihsxh7fkEX5OYKWiOCCbnJB/
 RYYZMj7XkKdaFpotPToghApltiBTnv3ZcNYi26gVVzBEUCIYvxoYLjC3ZDA3KkCPgFRl
 UFDoWm5MtpgKfEb40rvm5IwYbG1YCoDVmofdr9wVNfnw01YRtYEH8UZXeX9SAmWrOm7Y
 jWbw==
X-Gm-Message-State: AOJu0YzBZBtuAnhZv2QCoZOUwS9gvpCpTSIa4Dc7qMEbieRkpYJpyvmB
 MHTfzYuoyKgiVOFfI0z/Utela1RsqigPWWpGJPPWK1N7dVNlg+aFtKo5TZfbf7yfmLY=
X-Gm-Gg: ATEYQzzGWa6FavSDrsFrKBaOK5wpSyWOyE2mK8puw83cP9ObrTcwcl/N3Z9orqM/MLt
 Mv34pzx6VMQW2tt0CAQVtJKYBTnX1hIfCKPd8Y5ci0WvFBdMmQe1gkbFF756DTMf5L7cm5+Hfsc
 1GW2y6eelQaZdhOO1L/bMLX30xXYKh/2HwnYf/hMkL6LWL9FtGHDMcOwx+lxESzJF/2MWjLgVqP
 F5C0Kblum4rO53mTmMom79aPaGitJOtt1jb/TeA9e0IfIK6tKFo3MKn2jvOgzmAHZ/3WMb/wBb9
 ISk+k7CgmqMcZphb9+TG0VFKAz0suV2Z2IbKLGMeeTuR+HiVpsbCN12zCoLz5l2N/rtwyIEXGQK
 uhNcAEjkrPSX7inU7nwoFh4zfrjbsyHSlSuGPytqBOSfJHj64wajQ024fMxp4GPU/pAgWdmhCse
 9fijkdiv5mHrA3MObcPsAajLM=
X-Received: by 2002:a05:600c:4591:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-48526978664mr56717595e9.34.1772826657056; 
 Fri, 06 Mar 2026 11:50:57 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae00absm133404985e9.4.2026.03.06.11.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62130689D4;
 Fri, 06 Mar 2026 19:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 05/20] ui/egl: Don't change bound GL context when creating new
 context
Date: Fri,  6 Mar 2026 19:50:32 +0000
Message-ID: <20260306195048.2869788-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
Message-ID: <20260304165043.1437519-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


