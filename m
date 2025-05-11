Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FF1C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1DF-0004Nv-L2; Sun, 11 May 2025 03:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1DD-0004Fr-TL
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:35:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1DB-0003gr-TC
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:35:03 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7423fb98cb1so1626730b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746948900; x=1747553700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNZFUhKM/GF20gbDSX5YP2B7c2PLMfDNhZ/HXQiJfjI=;
 b=A453HJfTOygxIiaPqJgn7DqhIuEPMejPSL5iOZsQsU3YierYcRGOBZ9soud/yGB2xh
 Z+vvOxenHkK9RGCeCLfle/aXuxFzwGb3L8FoJnRqSY0BFHnZzTVCQ19JOlyLbTWO7jex
 hf9ptTucZVUYsegjRL3i2jgHTPrsZVcN6gmZo4s9mi9X2nKuljLAHOw27cbNLZm00cGS
 TtmCGaz7HWOemu3C+6ys/JaK3CWFLfJcfTfwLJ/xyWVOUMjENMJmZ2Fxtfc4NosARhG/
 Oii2x7NH3/ndD6y7NzKv8vDliSXmMRCEusuU1dx+W1w6HCCn8erTBDGQd9+mN6xwaO4k
 GOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948900; x=1747553700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNZFUhKM/GF20gbDSX5YP2B7c2PLMfDNhZ/HXQiJfjI=;
 b=c8/s3Jtjq8qECzcNAtCo7APEqSw5H/QKNvIJs58NAK4HjCUCdvD9xLQouNsD3O+SQk
 j4B6IPM9ToSsvnyBspDcpsRG3J2DzxTBY1feyLuQ/d8gvWWse1OSgaN1buybEP/JJKYY
 VNDPP6a+R0D/jAKxXcieWwktnHu8zBbNV6smpHvvWhRq6TMt2PfqYlJzVk2FlgUQra53
 oMGe/cSANWJuOkhR4VCJH0qb9+B2IC8J6US7n1p/1Z0QNAdhQm0zV1V30Xis2xOWqZuy
 3zMzqTIKSBkmWCE52HIbca1ZiycRrklv7LdlFJQEvGiBOMkEn+DAql/GlXl6sk2Nt1Wy
 N0Sg==
X-Gm-Message-State: AOJu0Ywkuu8QB7l0/zPxFeujwWOQXDqN0CbZixrxvlWLcpZnTm6A/zdl
 1p8Hsj6evMuPuyyIr6KgCGzjmEZyB2RmAySzvWS1yQrc/+yyt5c1amD8vgqk
X-Gm-Gg: ASbGncshpxbLq+v4zYBCLEluSABcHgdo9jXCpGRFP5eq8sWsCwQ1BOI27nfpqUbNZaw
 WH0qPWLElixuaYzTCmeUfz1Qm8ztkBJIu1NhPI9qWCn+G8TOsY3WmcO5vGq9htgD9s+JPiC9ns9
 IgEtNFhwaIAWyKex2+t8zIx3aK1e1+MXorURVFuTxXVCrieP/ybgsJlsrVep83PW6Qy3Z+lVZUk
 fcIWEaidhZDvM+1yAyxKgiHZ9I8OTnDAT2/3VXu/JM/U0zMG9IFdYhJnL8tnkLpLWuPxhUQzlmf
 7ZM/00aeYQSMl8vsdIINNsXMKB1xKF1G3uNwXxZhBkk1W5r/xWZW5O0Zrc7DTbg1Sw==
X-Google-Smtp-Source: AGHT+IGKGCUKd4v2ejB28VWjBxfyQtM3gYKh4NZ7cGYe7y+xi7k2HAoLYm4P5MQ0r4Im4lEl+NkpwQ==
X-Received: by 2002:a05:6a00:14c7:b0:741:b3e2:635b with SMTP id
 d2e1a72fcca58-7423c098c26mr14457708b3a.24.1746948899657; 
 Sun, 11 May 2025 00:34:59 -0700 (PDT)
Received: from localhost ([103.192.227.12]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742377050bbsm4150796b3a.27.2025.05.11.00.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 00:34:58 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PATCH 9/9] ui/gtk-egl: Render guest content with padding in
 fixed-scale mode
Date: Sun, 11 May 2025 15:33:19 +0800
Message-ID: <20250511073337.876650-10-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Scaling was not respected when rendering frames in gtk-egl.c (used if
gl=on and X11 mode). To fix this, add fields x and y to struct egl_fb
for x offset and y offset so we can add padding to window.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 include/ui/egl-helpers.h |  4 +++-
 ui/egl-helpers.c         | 10 ++++++++--
 ui/gtk-egl.c             | 36 +++++++++++++++++++++++++++++++-----
 ui/sdl2-gl.c             |  2 +-
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 4b8c0d2281..8f1670fd26 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -17,6 +17,8 @@ extern bool qemu_egl_angle_d3d;
 typedef struct egl_fb {
     int width;
     int height;
+    int x;
+    int y;
     GLuint texture;
     GLuint framebuffer;
     bool delete_texture;
@@ -26,7 +28,7 @@ typedef struct egl_fb {
 #define EGL_FB_INIT { 0, }
 
 void egl_fb_destroy(egl_fb *fb);
-void egl_fb_setup_default(egl_fb *fb, int width, int height);
+void egl_fb_setup_default(egl_fb *fb, int width, int height, int x, int y);
 void egl_fb_setup_for_tex(egl_fb *fb, int width, int height,
                           GLuint texture, bool delete);
 void egl_fb_setup_new_tex(egl_fb *fb, int width, int height);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index d591159480..8b60eb1062 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -92,14 +92,18 @@ void egl_fb_destroy(egl_fb *fb)
 
     fb->width = 0;
     fb->height = 0;
+    fb->x = 0;
+    fb->y = 0;
     fb->texture = 0;
     fb->framebuffer = 0;
 }
 
-void egl_fb_setup_default(egl_fb *fb, int width, int height)
+void egl_fb_setup_default(egl_fb *fb, int width, int height, int x, int y)
 {
     fb->width = width;
     fb->height = height;
+    fb->x = x;
+    fb->y = y;
     fb->framebuffer = 0; /* default framebuffer */
 }
 
@@ -144,6 +148,7 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
     glBindFramebuffer(GL_READ_FRAMEBUFFER, src->framebuffer);
     glBindFramebuffer(GL_DRAW_FRAMEBUFFER, dst->framebuffer);
     glViewport(0, 0, dst->width, dst->height);
+    glClear(GL_COLOR_BUFFER_BIT);
 
     if (src->dmabuf) {
         x1 = qemu_dmabuf_get_x(src->dmabuf);
@@ -160,7 +165,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
     x2 = x1 + w;
 
     glBlitFramebuffer(x1, y1, x2, y2,
-                      0, 0, dst->width, dst->height,
+                      dst->x, dst->y,
+                      dst->x + dst->width, dst->y + dst->height,
                       GL_COLOR_BUFFER_BIT, GL_LINEAR);
 }
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index f8e4f4bc70..0b787bea25 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -340,7 +340,11 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GdkWindow *window;
-    int ww, wh, ws;
+    int px_offset, py_offset;
+    int gs;
+    int pw_widget, ph_widget, pw_surface, ph_surface;
+    int ww_widget, wh_widget, ww_surface, wh_surface;
+    int fbw, fbh;
 
     if (!vc->gfx.scanout_mode) {
         return;
@@ -353,10 +357,32 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                    vc->gfx.esurface, vc->gfx.ectx);
 
     window = gtk_widget_get_window(vc->gfx.drawing_area);
-    ws = gdk_window_get_scale_factor(window);
-    ww = gdk_window_get_width(window) * ws;
-    wh = gdk_window_get_height(window) * ws;
-    egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
+    gs = gdk_window_get_scale_factor(window);
+    ww_widget = gdk_window_get_width(window);
+    wh_widget = gdk_window_get_height(window);
+    fbw = surface_width(vc->gfx.ds);
+    fbh = surface_height(vc->gfx.ds);
+
+    gd_update_scale(vc, ww_widget, wh_widget, fbw, fbh);
+
+    ww_surface = fbw * vc->gfx.scale_x;
+    wh_surface = fbh * vc->gfx.scale_y;
+    pw_widget = ww_widget * gs;
+    ph_widget = wh_widget * gs;
+    pw_surface = ww_surface * gs;
+    ph_surface = wh_surface * gs;
+
+    px_offset = 0;
+    py_offset = 0;
+    if (pw_widget > pw_surface) {
+        px_offset = (pw_widget - pw_surface) / 2;
+    }
+    if (ph_widget > ph_surface) {
+        py_offset = (ph_widget - ph_surface) / 2;
+    }
+
+    egl_fb_setup_default(&vc->gfx.win_fb, pw_surface, ph_surface,
+                         px_offset, py_offset);
     if (vc->gfx.cursor_fb.texture) {
         egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,
                          vc->gfx.y0_top);
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index e01d9ab0c7..3be17d1079 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -241,7 +241,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     SDL_GetWindowSize(scon->real_window, &ww, &wh);
-    egl_fb_setup_default(&scon->win_fb, ww, wh);
+    egl_fb_setup_default(&scon->win_fb, ww, wh, 0, 0);
     egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
 
     SDL_GL_SwapWindow(scon->real_window);
-- 
2.49.0


