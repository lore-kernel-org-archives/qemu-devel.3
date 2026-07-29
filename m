Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC027C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 23:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x45FO-0006GQ-0N; Tue, 08 Sep 2026 19:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x45FM-0006GD-Fd
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 19:29:00 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x45FK-0004Rn-II
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 19:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788910138; x=1820446138;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vZ6Jrh4f1t20yXDXLg9FfAYVbFpba477NmfLFuPL38M=;
 b=dKqGGrONH5ttVZWY86R1PKvX1UdLnC2cbXnYhaVb3BUkHKqnuUBuasq7
 R+AzVv5u3DLEklIMQ8JYckp/BdBFOZyWEjiL5s9DlLElmUrgBMcq4NBhk
 wwKUcCTxhkt0CIhMAj8AxGQvbd7Pu65BUd69URH7bPxQqUS8kfbFvOqxf
 vbMpdExqnQJ00zYRUI+53UpWj3eS7hy3dtLyJ75TChv9GDWDZ59Gxpx0m
 FjvuvkHKMUMWbJhuB2QNwkgGfrcgYRf2UvQMMFKlmTCJA5jQRVe0IkRta
 7OeqfQI45cczn2eBnOCQMVBjdEmKftw1hSgz9yfDb4BwHNXW2K70z4NjA g==;
X-CSE-ConnectionGUID: 4hppLF3bQC+qnaypCrQsNA==
X-CSE-MsgGUID: Ma4pOjviQ1uhwmW8naYTNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89530967"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89530967"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 16:28:53 -0700
X-CSE-ConnectionGUID: ywYR3LB9QJSKXEsdQpQz5w==
X-CSE-MsgGUID: 1veSaLCLRGCd5JImJOmCEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="267894203"
Received: from unknown (HELO dongwonk-Z390-AORUS-ULTRA.fm.intel.com)
 ([10.80.113.172])
 by fmviesa007.fm.intel.com with ESMTP; 08 Sep 2026 16:28:53 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Clean up GL resources on tab detach, re-attach,
 and VC free
Date: Wed, 29 Jul 2026 06:47:59 -0700
Message-Id: <20260729134759.2877-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

When a VC is detached into an independent window or re-attached back
to the main window via gd_tab_window_close(), its underlying EGL surface
and context are destroyed and recreated.

However, the associated FB objects (guest_fb, win_fb, cursor_fb),
display surface textures, and shader instances were not being cleaned up
during these transitions, leading to potential resource leaks.

Introduce a helper function, gd_gl_release_resources(), to make the
appropriate GL context current, delete the textures and framebuffers,
release the shader instance, and reset state pointers.

Use this helper in gd_tab_window_close(), gd_menu_untabify(), and refactor
gd_vc_free() to use it as well.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 67 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 0b5139ef31..c2324d273e 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1490,6 +1490,28 @@ static int gd_vc_notebook_pos(GtkDisplayState *s, VirtualConsole *target)
     g_assert_not_reached();
 }
 
+#if defined(CONFIG_OPENGL)
+static void gd_gl_release_resources(VirtualConsole *vc)
+{
+    if (vc->gfx.ectx) {
+        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                       vc->gfx.esurface, vc->gfx.ectx);
+    } else if (gtk_use_gl_area) {
+        gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
+    }
+
+    if (vc->gfx.gls) {
+        surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
+        qemu_gl_fini_shader(vc->gfx.gls);
+        vc->gfx.gls = NULL;
+    }
+
+    egl_fb_destroy(&vc->gfx.guest_fb);
+    egl_fb_destroy(&vc->gfx.win_fb);
+    egl_fb_destroy(&vc->gfx.cursor_fb);
+}
+#endif
+
 static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
                                     void *opaque)
 {
@@ -1506,13 +1528,17 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     gtk_widget_destroy(vc->window);
     vc->window = NULL;
 #if defined(CONFIG_OPENGL)
-    if (vc->gfx.esurface) {
-        eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
-        vc->gfx.esurface = NULL;
-    }
-    if (vc->gfx.ectx) {
-        eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
-        vc->gfx.ectx = NULL;
+    if (vc->type == GD_VC_GFX) {
+        gd_gl_release_resources(vc);
+
+        if (vc->gfx.esurface) {
+            eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
+            vc->gfx.esurface = NULL;
+        }
+        if (vc->gfx.ectx) {
+            eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
+            vc->gfx.ectx = NULL;
+        }
     }
 #endif
 
@@ -1549,12 +1575,9 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 
     if (vc->type == GD_VC_GFX &&
         qemu_console_is_graphic(vc->gfx.dcl.con)) {
-        gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
-                                       FALSE);
-    }
-    if (!vc->window) {
-        vc->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
 #if defined(CONFIG_OPENGL)
+        gd_gl_release_resources(vc);
+
         if (vc->gfx.esurface) {
             eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
             vc->gfx.esurface = NULL;
@@ -1564,6 +1587,11 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
             vc->gfx.ectx = NULL;
         }
 #endif
+        gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
+                                       FALSE);
+    }
+    if (!vc->window) {
+        vc->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
         gd_widget_reparent(s->notebook, vc->window, vc->tab_item);
 
         g_signal_connect(vc->window, "delete-event",
@@ -2696,19 +2724,8 @@ static void gd_vc_free(void *p)
         if (display_opengl) {
             qemu_console_set_display_gl_ctx(vc->gfx.dcl.con, NULL);
         }
-        if (vc->gfx.ectx) {
-            eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                           vc->gfx.esurface, vc->gfx.ectx);
-        } else if (gtk_use_gl_area) {
-            gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
-        }
-        if (vc->gfx.gls) {
-            surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
-            qemu_gl_fini_shader(vc->gfx.gls);
-        }
-        egl_fb_destroy(&vc->gfx.guest_fb);
-        egl_fb_destroy(&vc->gfx.win_fb);
-        egl_fb_destroy(&vc->gfx.cursor_fb);
+        gd_gl_release_resources(vc);
+
         if (vc->gfx.esurface) {
             eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
         }
-- 
2.43.0


