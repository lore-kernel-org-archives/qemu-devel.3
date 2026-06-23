Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF64FCDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvqe-000096-NU; Tue, 23 Jun 2026 03:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqd-0008UL-71
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqb-0008KH-CC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4OdAzLtMXCE0KbwWonpJ6vMVm6YZX4iARVIMehN4nRo=;
 b=NdvuGT6hEeeYpfWlWXBCeCJczPzllzdu96Jij+GUxDVXLTWx92kL1Qr6ch1K6ps3h486Vp
 5YG7TLjJvkSv7gWJJZoDnGpWQr7N8KsVs+uO4nyKAe7uEC00Mt6CBvLnGYURU62udEW8kF
 ABcycDHb+AsDr+hX3ZGiYJCe0oT9+dM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-rgSNMrWfOrG6x0IKI852Zg-1; Tue,
 23 Jun 2026 03:47:00 -0400
X-MC-Unique: rgSNMrWfOrG6x0IKI852Zg-1
X-Mimecast-MFC-AGG-ID: rgSNMrWfOrG6x0IKI852Zg_1782200819
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C9E7180025C; Tue, 23 Jun 2026 07:46:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05D6D1800591; Tue, 23 Jun 2026 07:46:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:41 +0400
Subject: [PATCH v4 26/34] ui/gtk: convert VirtualConsole storage from fixed
 array to GPtrArray
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-26-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7432;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pYkHf4xuhYrughcwER53jaOYI+5mKVTp6HoXtiFTfzo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjlesHmJFI7xo0gXdnvNO+tvwLRQvUt2bKvep
 iW04MYCgZOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XgAKCRDa6OEJdZac
 5XFwD/0ZGiBocCZfriGx5kf3Km7uVAPyCa50O0tuyEwMWnK6BqgBTh4uBZb1uNna1+6E93LpUgf
 VOYTK5xda+uyOqQroYXUNsMePY8GwEIk+hFQC9QTlVbOwIlGgvG7fOzLdtRz/GV1Yug/rCJq3Fy
 MpqkiHcHTR7rR5rICN4dpgkQwVaGtxo/pbJ11z0BOYJT3kUTuHa5Ks8/6S2/woln1szMxZ8KbSC
 c0oRb1Yv4LflXJeECzpZ5q/Nq2aMtkmbn+JijfE083SFpR7b/caAfEQghzmAbBlbi/DUnhKYlcq
 Pt5yYpqzATjyYRYFTpv4KgJdRrX0Xwygi1tlTTDeBTz8vsLlDd2ieuOxt32UolOJq5y/aTptnCb
 L39l1LgdsU5FLEVG5FVWKq57K/hqjOD3jdVk09+sdO5oyfjYLYqGsxuixKKoLfDxNFtSTBhD/YD
 hJCSRK+itlUCzoRNOCWoW+T+JlMfBB8ghTRw40q16/447jVP6jvU4fLFhZa2xVoNN2/e/02qZhp
 nWlW+JF7t+3e2K9CVd4Lejm1o9JwIhBg+iWfn5CvRyZxQH6QxKCPmVufhsNb0gGBrrJNrvWoqLi
 Dd6DhnKVmOFpq5edlIlIze4NPQbHt8seiK+5fn6XIAcRCldweRhO60ZDHGg3WbIYgCxy5sbg0mY
 icTwcJJMFuW6DWQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace the fixed-size vc[MAX_VCS] with GPtrArray.

This is a preparatory refactoring for console hotplug support, which
needs to add/remove VCs dynamically.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/gtk.h |   3 +-
 ui/gtk.c         | 108 +++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 87 insertions(+), 24 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index f4c8e6a9f00..fb60cbfda5d 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -118,8 +118,7 @@ struct GtkDisplayState {
     GtkWidget *grab_item;
     GtkWidget *grab_on_hover_item;
 
-    int nb_vcs;
-    VirtualConsole vc[MAX_VCS];
+    GPtrArray *vcs;
 
     GtkWidget *show_tabs_item;
     GtkWidget *untabify_item;
diff --git a/ui/gtk.c b/ui/gtk.c
index dfef1b10fe3..b4dcdcd9a44 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -150,8 +150,8 @@ static VirtualConsole *gd_vc_find_by_menu(GtkDisplayState *s)
     VirtualConsole *vc;
     gint i;
 
-    for (i = 0; i < s->nb_vcs; i++) {
-        vc = &s->vc[i];
+    for (i = 0; i < s->vcs->len; i++) {
+        vc = g_ptr_array_index(s->vcs, i);
         if (gtk_check_menu_item_get_active
             (GTK_CHECK_MENU_ITEM(vc->menu_item))) {
             return vc;
@@ -165,8 +165,11 @@ static VirtualConsole *gd_vc_find_by_page(GtkDisplayState *s, gint page)
     VirtualConsole *vc;
     gint i, p;
 
-    for (i = 0; i < s->nb_vcs; i++) {
-        vc = &s->vc[i];
+    if (!s->vcs) {
+        return NULL;
+    }
+    for (i = 0; i < s->vcs->len; i++) {
+        vc = g_ptr_array_index(s->vcs, i);
         p = gtk_notebook_page_num(GTK_NOTEBOOK(s->notebook), vc->tab_item);
         if (p == page) {
             return vc;
@@ -247,8 +250,8 @@ static void gd_update_caption(GtkDisplayState *s)
     gtk_window_set_title(GTK_WINDOW(s->window), title);
     g_free(title);
 
-    for (i = 0; i < s->nb_vcs; i++) {
-        VirtualConsole *vc = &s->vc[i];
+    for (i = 0; i < s->vcs->len; i++) {
+        VirtualConsole *vc = g_ptr_array_index(s->vcs, i);
 
         if (!vc->window) {
             continue;
@@ -357,7 +360,7 @@ static void gtk_release_modifiers(GtkDisplayState *s)
 {
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    if (vc->type != GD_VC_GFX ||
+    if (!vc || vc->type != GD_VC_GFX ||
         !qemu_console_is_graphic(vc->gfx.dcl.con)) {
         return;
     }
@@ -702,8 +705,8 @@ static void gd_mouse_mode_change(Notifier *notify, void *data)
             gd_ungrab_pointer(s);
         }
     }
-    for (i = 0; i < s->nb_vcs; i++) {
-        VirtualConsole *vc = &s->vc[i];
+    for (i = 0; i < s->vcs->len; i++) {
+        VirtualConsole *vc = g_ptr_array_index(s->vcs, i);
         gd_update_cursor(vc);
     }
 }
@@ -2114,9 +2117,10 @@ static void gd_vcs_init(GtkDisplayState *s, GSList *group,
     int i;
 
     for (i = 0; i < nb_vcs; i++) {
-        VirtualConsole *vc = &s->vc[s->nb_vcs];
-        group = gd_vc_vte_init(s, vc, vcs[i], s->nb_vcs, group, view_menu);
-        s->nb_vcs++;
+        VirtualConsole *vc = g_new0(VirtualConsole, 1);
+        g_ptr_array_add(s->vcs, vc);
+        group = gd_vc_vte_init(s, vc, vcs[i], s->vcs->len - 1,
+                               group, view_menu);
     }
 }
 #endif /* CONFIG_VTE */
@@ -2441,13 +2445,14 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
 
     /* gfx */
     for (vc = 0;; vc++) {
+        VirtualConsole *v;
         con = qemu_console_lookup_by_index(vc);
         if (!con) {
             break;
         }
-        group = gd_vc_gfx_init(s, &s->vc[vc], con,
-                               vc, group, view_menu);
-        s->nb_vcs++;
+        v = g_new0(VirtualConsole, 1);
+        g_ptr_array_add(s->vcs, v);
+        group = gd_vc_gfx_init(s, v, con, vc, group, view_menu);
     }
 
 #if defined(CONFIG_VTE)
@@ -2505,6 +2510,64 @@ static void gd_create_menus(GtkDisplayState *s, DisplayOptions *opts)
 }
 
 
+static void gd_vc_free(void *p)
+{
+    VirtualConsole *vc = p;
+
+    switch (vc->type) {
+    case GD_VC_GFX:
+        qemu_console_unregister_listener(&vc->gfx.dcl);
+#if defined(CONFIG_OPENGL)
+        if (display_opengl) {
+            qemu_console_set_display_gl_ctx(vc->gfx.dcl.con, NULL);
+        }
+        if (vc->gfx.ectx) {
+            eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                           vc->gfx.esurface, vc->gfx.ectx);
+        } else if (gtk_use_gl_area) {
+            gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
+        }
+        if (vc->gfx.gls) {
+            surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
+            qemu_gl_fini_shader(vc->gfx.gls);
+        }
+        egl_fb_destroy(&vc->gfx.guest_fb);
+        egl_fb_destroy(&vc->gfx.win_fb);
+        egl_fb_destroy(&vc->gfx.cursor_fb);
+        if (vc->gfx.esurface) {
+            eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
+        }
+        if (vc->gfx.ectx) {
+            eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
+        }
+#endif
+        qkbd_state_free(vc->gfx.kbd);
+        if (vc->gfx.surface) {
+            cairo_surface_destroy(vc->gfx.surface);
+        }
+        if (vc->gfx.convert) {
+            pixman_image_unref(vc->gfx.convert);
+        }
+        break;
+    case GD_VC_VTE:
+#ifdef CONFIG_VTE
+        fifo8_destroy(&vc->vte.out_fifo);
+#endif
+        break;
+    }
+
+    if (vc->window) {
+        gtk_widget_destroy(vc->window);
+    } else if (vc->tab_item) {
+        gtk_widget_destroy(vc->tab_item);
+    }
+    if (vc->menu_item) {
+        gtk_widget_destroy(vc->menu_item);
+    }
+    g_free(vc->label);
+    g_free(vc);
+}
+
 static GtkDisplayState *gtk_display_state;
 static gboolean gtkinit;
 
@@ -2525,6 +2588,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     assert(opts->type == DISPLAY_TYPE_GTK);
     s = g_malloc0(sizeof(*s));
     gtk_display_state = s;
+    s->vcs = g_ptr_array_new_with_free_func(gd_vc_free);
     s->opts = opts;
 
     theme = gtk_icon_theme_get_default();
@@ -2582,13 +2646,10 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 
     gtk_widget_show_all(s->window);
 
-    for (idx = 0;; idx++) {
-        QemuConsole *con = qemu_console_lookup_by_index(idx);
-        if (!con) {
-            break;
-        }
-        if (s->vc[idx].type == GD_VC_GFX) {
-            gtk_widget_realize(s->vc[idx].gfx.drawing_area);
+    for (idx = 0; idx < s->vcs->len; idx++) {
+        VirtualConsole *v = g_ptr_array_index(s->vcs, idx);
+        if (v->type == GD_VC_GFX) {
+            gtk_widget_realize(v->gfx.drawing_area);
         }
     }
 
@@ -2693,6 +2754,9 @@ static void gtk_display_cleanup(void)
     qemu_del_vm_change_state_handler(s->vmse);
     qemu_remove_mouse_mode_change_notifier(&s->mouse_mode_notifier);
     gd_clipboard_cleanup(s);
+    g_signal_handlers_disconnect_by_func(s->notebook,
+                                         G_CALLBACK(gd_change_page), s);
+    g_clear_pointer(&s->vcs, g_ptr_array_unref);
     g_clear_pointer(&s->window, gtk_widget_destroy);
     g_clear_object(&s->null_cursor);
     g_clear_pointer(&gtk_display_state, g_free);

-- 
2.54.0


