Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E70C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hgV-0005pf-98; Sun, 13 Sep 2026 06:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgT-0005pO-O1
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgS-0008Ia-32
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZCywqz+vhDR3FMIArWEl+c1mXnNGS588f6R6cn+Z8k=;
 b=HM1LgYwliiV9VB0zbmGTzEeMPTUvUD5M/HMfaueWtdHGr4GnmqKVQ4BkYjFMlathZsZswb
 1+3/wOXZGS+0SYliUS2FOv/mjta3r4DPnvFyaishem+amGgNCe9lak5uWLCvQbleCRQxF0
 bnCmhr1Qw1SRPH+R9qvB1Nd9ILxJrXc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-ov6jmawPNh-dTT_ZdttC7w-1; Sun,
 13 Sep 2026 06:43:38 -0400
X-MC-Unique: ov6jmawPNh-dTT_ZdttC7w-1
X-Mimecast-MFC-AGG-ID: ov6jmawPNh-dTT_ZdttC7w_1789296217
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D95F1953951
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DCBF30001A2; Sun, 13 Sep 2026 10:43:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:32 +0400
Subject: [GIT PULL 14/14] ui/gtk: Clean up GL resources on tab detach,
 re-attach, and VC free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-14-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5024;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EiEaQKJ2IjJ2NJt0VKa7papXMumQRcV1BPgrXUq7QbA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4jiZucOHaCFZk1PuQ6aqPe8gboo89QJ50Wt
 r8uEN/wqKKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IwAKCRDa6OEJdZac
 5WA2D/0S9LJA9dctn4d6sZiGObG+Sx+XRfGZp+qnK8sQv5TcW7Xcgh1o7Af61QIeTsoS+zEXgpl
 5IbrmM3qIPyeceYz2RispnNf/4h8OW+bZK0U1+esDayhjCMH/b3Y9V5l44Ha5eW2Hr75lY0XZ6m
 Hkebk2n3roZvdnBD1K/rqzYDihSaTbidwZPKuJHtnTI/WAMMwJgrmiYUfB1aS4FgaixeMLGhCix
 wFiVPEbv0rt/UXfrG9r5TjwedvaVXq9rdprvWhGZuw5GQofEgziFQzWNcsFPb8MFZRTHFFsMmQK
 ntVy69B0pLcfTgwp602k6fnd+w59HFxB3ULbtzSKqFTgWb4V7djcNG9f/a9AEGWCbYY32uhc8vW
 EUyhPvUwlTjYCFeVEt+O7UnK8vaoVYOVWueAuwC+Zs1U+FctK9KQtAxWS96MlQm+69nB9Sq1kr4
 3k3gw7v2PWbRZJSKR2gdM+/7szjqCZ45NJq35NjkOmTM8HxYGLGzS7QnPMeD62jG1cofwGy1N/n
 3CsjEoH6QRIzo811BhitWuk3IvIOM6AcPoG6leQorqXx0xFKvUSKTxlJGy+Ulrq909zcWsK0Q5m
 8v1WJFgHIrGsdxaKhxvgBCjWbVoI1L1WDAlX4oBhWVtGdZAwGwje3avf7HmBuGroG6W/LN5XYU9
 1sQTi01/hybwHHQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260729134759.2877-1-dongwon.kim@intel.com>
---
 ui/gtk.c | 67 ++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index a194488a0cf3..ed7ffc06b154 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1497,6 +1497,28 @@ static int gd_vc_notebook_pos(GtkDisplayState *s, VirtualConsole *target)
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
@@ -1513,13 +1535,17 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
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
 
@@ -1556,12 +1582,9 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 
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
@@ -1571,6 +1594,11 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
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
@@ -2707,19 +2735,8 @@ static void gd_vc_free(void *p)
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
2.55.0.543.g5ebe2ebe4ea8


