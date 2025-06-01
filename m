Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3305CC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 04:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLahi-0006yq-AL; Sun, 01 Jun 2025 00:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uLahc-0006xs-Id
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 00:53:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uLahZ-0002Ro-Li
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 00:53:44 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso3869782b3a.2
 for <qemu-devel@nongnu.org>; Sat, 31 May 2025 21:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748753619; x=1749358419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8+mq13Ike4tII/xN10loMuJgw5sR3KYt5pU1khJptI=;
 b=CZ3XpOmfrAGWknF4cG90azSZ93oUuwRuMT8BK5gVBSLwgFsBd+vdKRBjdlETH2B/kb
 fWpFOId3QPRMDI608FQsuhgU715zsFcSdmQgco4ZIPEYtwMg257BpSNXtO+IcMvWrHAx
 Qnw8e41D2yLEX7ZyxAW504DOpwKyK8603PuNn+IU0svxKQU3/qIvHa4CKP29E1BfN/Nx
 DZkF7VO+qcHoNSXLWvXPBSBGInW3jkc79/tV91Ccqd8KGwjpEk+UqhqxvPfqxwMwca9e
 Z6nkwOM5J6yLVJJwDvdk3xK35qsWfEukP5t63ECDz/LmO+0Bv3UBOkT8STZS9oRzXnm9
 o3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748753619; x=1749358419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8+mq13Ike4tII/xN10loMuJgw5sR3KYt5pU1khJptI=;
 b=bAs8pfVgAksEEdgZSaPIpehlKGMWl1U5TkGFruorHETOCGlZAleJZ3KxZdycmh/Wpn
 HddHDpQnxer1vSu7yOkzclF2WYtebCnTVjiKJ+Dy85dd5OkPJdR/GZMHqKBRi3/5kEiE
 WJuAPY341vDC2Z4LNTTWhMG/HzutBqVjLzRSEfR8fgAKpfobMDDHE5lDvRGMYnTGUNJe
 Y7BSm27iKvEnEMPBx5mgC+uhDhrrRy5ZFL15Z2eLYd3TZj3rqA2kZajS06bspsVDah0i
 gvpohgevgy/OvsYFDmFtkONlPco+EUMZOxdxO7K+IhuZ0jGkidGfDY0gF1hF36r08K9Z
 dDEw==
X-Gm-Message-State: AOJu0YxRClO73YCF7wyhqLlBBRb78gsczjLtmdTxOL1HXs8r4EF3aniq
 zsxS7zQ3HIYQvCncIO/67nf3Xm7aRoA+ncgy5UtGpNCkp69rHM4h+pDfXqGS4EKMhb0=
X-Gm-Gg: ASbGncsWKXigKYdf+xyFlbaICcx6DH3cT/4FRFlM20CA0hH4dutIiTd1e+H3F9BAlXl
 a+NIlbZDEJzvclTCqDBl+bue3FP96ipbQqKC6w1wZzzesPZ2dHyas21eCiDfarNjJKOWxXAFGqT
 QnwuVQ7EjbEiNfaU3rzwL00vS5OJj6+IML0GJQS6sEl32MPF98Czn6UctIBTmrMKKPT2UI98Lu6
 XxBY18NMTqPYBI+kXWN22s0d8IeuZAt2YhdFWb8PJrgs8sJhvw/j6U8XHcdzenXsQxPV9k+Iyb0
 zEqBIQOz/jw86wnZNEg+GDtwYjeXqhpSc08FDc/yQQpAZg2f5Lo5muw=
X-Google-Smtp-Source: AGHT+IE29cZRw/GowY6WCBbka3EeJTjCjmKIUtKXJq98fFLDgK7oq3z5eFXgTamfo0fgw5xsjaJCIg==
X-Received: by 2002:a05:6a21:32a5:b0:21a:d7ad:e0c7 with SMTP id
 adf61e73a8af0-21ad979928cmr16035597637.34.1748753619474; 
 Sat, 31 May 2025 21:53:39 -0700 (PDT)
Received: from localhost ([103.192.227.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affaf9e5sm5411451b3a.86.2025.05.31.21.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 21:53:38 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/2] ui/gtk: Add scale option
Date: Sun,  1 Jun 2025 12:52:33 +0800
Message-ID: <20250601045245.36778-3-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601045245.36778-1-weifeng.liu.z@gmail.com>
References: <20250601045245.36778-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x42d.google.com
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

Allow user to set a preferred scale (defaulting to 1) of the virtual
display. Along with zoom-to-fix=false, this would be helpful for users
running QEMU on hi-dpi host desktop to achieve pixel to pixel display --
e.g., if the scale factor of a user's host desktop is set to 200%, then
they can set a 0.5 scale for the virtual display to avoid magnification
that might cause blurriness.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 include/ui/gtk.h |  1 +
 qapi/ui.json     |  5 ++++-
 ui/gtk.c         | 46 +++++++++++++++++++++++++++++-----------------
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index b7cfbf218e..3e6ce3cb48 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -41,6 +41,7 @@ typedef struct VirtualGfxConsole {
     DisplaySurface *ds;
     pixman_image_t *convert;
     cairo_surface_t *surface;
+    double preferred_scale;
     double scale_x;
     double scale_y;
 #if defined(CONFIG_OPENGL)
diff --git a/qapi/ui.json b/qapi/ui.json
index 4f7d994e26..023d055ef1 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1338,6 +1338,8 @@
 # @keep-aspect-ratio: Keep width/height aspect ratio of guest content when
 #     resizing host window.  Defaults to "on". (Since 10.1)
 #
+# @scale: Set preferred scale of the display.  Defaults to 1.0.  (Since 10.1)
+#
 # Since: 2.12
 ##
 { 'struct'  : 'DisplayGTK',
@@ -1345,7 +1347,8 @@
                 '*zoom-to-fit'       : 'bool',
                 '*show-tabs'         : 'bool',
                 '*show-menubar'      : 'bool',
-                '*keep-aspect-ratio' : 'bool'  } }
+                '*keep-aspect-ratio' : 'bool',
+                '*scale'             : 'number'  } }
 
 ##
 # @DisplayEGLHeadless:
diff --git a/ui/gtk.c b/ui/gtk.c
index 9104509ee1..e91d093a49 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -67,6 +67,7 @@
 #define VC_TERM_X_MIN     80
 #define VC_TERM_Y_MIN     25
 #define VC_SCALE_MIN    0.25
+#define VC_SCALE_MAX       4
 #define VC_SCALE_STEP   0.25
 
 #ifdef GDK_WINDOWING_X11
@@ -272,15 +273,11 @@ static void gd_update_geometry_hints(VirtualConsole *vc)
         if (!vc->gfx.ds) {
             return;
         }
-        if (s->free_scale) {
-            geo.min_width  = surface_width(vc->gfx.ds) * VC_SCALE_MIN;
-            geo.min_height = surface_height(vc->gfx.ds) * VC_SCALE_MIN;
-            mask |= GDK_HINT_MIN_SIZE;
-        } else {
-            geo.min_width  = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
-            geo.min_height = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
-            mask |= GDK_HINT_MIN_SIZE;
-        }
+        double scale_x = s->free_scale ? VC_SCALE_MIN : vc->gfx.scale_x;
+        double scale_y = s->free_scale ? VC_SCALE_MIN : vc->gfx.scale_y;
+        geo.min_width  = surface_width(vc->gfx.ds) * scale_x;
+        geo.min_height = surface_height(vc->gfx.ds) * scale_y;
+        mask |= GDK_HINT_MIN_SIZE;
         geo_widget = vc->gfx.drawing_area;
         gtk_widget_set_size_request(geo_widget, geo.min_width, geo.min_height);
 
@@ -1579,8 +1576,8 @@ static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
         }
         s->full_screen = FALSE;
         if (vc->type == GD_VC_GFX) {
-            vc->gfx.scale_x = 1.0;
-            vc->gfx.scale_y = 1.0;
+            vc->gfx.scale_x = vc->gfx.preferred_scale;
+            vc->gfx.scale_y = vc->gfx.preferred_scale;
             gd_update_windowsize(vc);
         }
     }
@@ -1636,8 +1633,8 @@ static void gd_menu_zoom_fixed(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    vc->gfx.scale_x = 1.0;
-    vc->gfx.scale_y = 1.0;
+    vc->gfx.scale_x = vc->gfx.preferred_scale;
+    vc->gfx.scale_y = vc->gfx.preferred_scale;
 
     gd_update_windowsize(vc);
 }
@@ -1651,8 +1648,8 @@ static void gd_menu_zoom_fit(GtkMenuItem *item, void *opaque)
         s->free_scale = TRUE;
     } else {
         s->free_scale = FALSE;
-        vc->gfx.scale_x = 1.0;
-        vc->gfx.scale_y = 1.0;
+        vc->gfx.scale_x = vc->gfx.preferred_scale;
+        vc->gfx.scale_y = vc->gfx.preferred_scale;
     }
 
     gd_update_windowsize(vc);
@@ -2243,6 +2240,11 @@ static void gl_area_realize(GtkGLArea *area, VirtualConsole *vc)
 }
 #endif
 
+static bool gd_scale_valid(double scale)
+{
+    return scale >= VC_SCALE_MIN && scale <= VC_SCALE_MAX;
+}
+
 static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               QemuConsole *con, int idx,
                               GSList *group, GtkWidget *view_menu)
@@ -2252,8 +2254,18 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
 
     vc->label = qemu_console_get_label(con);
     vc->s = s;
-    vc->gfx.scale_x = 1.0;
-    vc->gfx.scale_y = 1.0;
+    vc->gfx.preferred_scale = 1.0;
+    if (s->opts->u.gtk.has_scale) {
+        if (gd_scale_valid(s->opts->u.gtk.scale)) {
+            vc->gfx.preferred_scale = s->opts->u.gtk.scale;
+        } else {
+            error_report("Invalid scale value %lf given, being ignored",
+                         s->opts->u.gtk.scale);
+            s->opts->u.gtk.has_scale = false;
+        }
+    }
+    vc->gfx.scale_x = vc->gfx.preferred_scale;
+    vc->gfx.scale_y = vc->gfx.preferred_scale;
 
 #if defined(CONFIG_OPENGL)
     if (display_opengl) {
-- 
2.49.0


