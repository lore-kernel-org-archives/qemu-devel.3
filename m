Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35B3CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUHd-0003k6-5z; Mon, 08 Jun 2026 03:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGM-0002Mi-It
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGH-0000gu-JJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKa7hDp3dg6dKFZyWKTIvkgjbBHUJu0PjUsKko7hmik=;
 b=YWjsX9Wr63/W+/m27ACrczm9KoPvo9dBT1Z1riCjBLGhM+eAq8ZTaYh/qqY9iRa02s0yL8
 QToa8tTEcca1BnPk9G7YNg+LkLLwwf8lOuaLVerDPy/1AXz2xQKfTXgQF6jjDRP3SxeGPB
 udiLVjRgsLM+yN6kFCk+qX7wUAN22iY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-849LbrCINWqYHXVt9o-PXg-1; Mon,
 08 Jun 2026 03:18:55 -0400
X-MC-Unique: 849LbrCINWqYHXVt9o-PXg-1
X-Mimecast-MFC-AGG-ID: 849LbrCINWqYHXVt9o-PXg_1780903134
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1B3019560AA; Mon,  8 Jun 2026 07:18:53 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7680B180034F; Mon,  8 Jun 2026 07:18:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:43 +0400
Subject: [PATCH v2 25/33] ui/gtk: convert VirtualConsole storage from fixed
 array to GPtrArray
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-25-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7102;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pHE1CzXAmbNSqrO3NmUz+0VLV7ErcfiuC7I5Qq7DCnQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxMg7rT8dhR5+TcEWg3u4sXf1Jp3IKDxTnnY
 IviRjB7jkCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsTAAKCRDa6OEJdZac
 5e8fEACR4AsYpSO8BXWFyVGfr6rwBm0VuAgEs82Hsithru8yA7liafntqIgOLGsvApX1sfG+VmC
 vzk5rN4vP6E0KVmCX/sI1VHK4GlDJIzH2AJmqfvitN9NLAknrAfv23oqqTTLJdyW5lh/HZbeenn
 Tq4uspdcTtyQEGB2ISCfJCI2FwaRQ9+2T+VYQi+oxHUrwtUnC1mGO5rM9k473JWvkM8YOm2r+d8
 4VyJadvAVRLIkctl26NgkpnTT5ZJyVpz093Lv7dhkHKMf0yfM/iUMAuNH98GePDkRZPg7Sx+Zel
 Dsu3LFGi3CY3c/M6INobYxUJNuWZ0ZeWdNthSVATReMbDKexuhYu91QFlNgvd+Ql9ikPQvsDGsi
 DJkOCfjkH6PTZsVSi2iQ4AdzMs3x0H7T/F8b0TkQD40xgaIkkHMfaaCrJ4rqch4dfuavkBG1Hjd
 MSIyVOrLNFpMoqOgx5t9pFT4sLMmV/s7gGB1MbfVeI7NrWKrIFmhiSawGbs7RcqmGWuL1JShbNf
 enl/N1VPODrrvF6YRZvSaJGL+vXlh0hqi6tAAIYf6q7JwXipjlqxJWVZz8jypFktCIX9eprs+ZE
 04X4/pTISL1C/rgPVOG5b6gEmpbD1+8hGkyzjq3qZBZuNzPw6+21Fj1i9j9GiSfDrhNC1G9szGB
 inuOWx79fgTgixA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Replace the fixed-size vc[MAX_VCS] with GPtrArray.

This is a preparatory refactoring for console hotplug support, which
needs to add/remove VCs dynamically.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/gtk.h |   3 +-
 ui/gtk.c         | 102 +++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 5156a049509..4d54de97ea7 100644
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
index c26dc83ac3e..5bc2a04b43f 100644
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
@@ -2505,6 +2510,58 @@ static void gd_create_menus(GtkDisplayState *s, DisplayOptions *opts)
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
+        if (vc->gfx.esurface) {
+            eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
+        }
+        if (vc->gfx.ectx) {
+            eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
+        }
+        if (vc->gfx.gls) {
+            surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
+            qemu_gl_fini_shader(vc->gfx.gls);
+        }
+        egl_fb_destroy(&vc->gfx.guest_fb);
+        egl_fb_destroy(&vc->gfx.win_fb);
+        egl_fb_destroy(&vc->gfx.cursor_fb);
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
 
@@ -2525,6 +2582,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     assert(opts->type == DISPLAY_TYPE_GTK);
     s = g_malloc0(sizeof(*s));
     gtk_display_state = s;
+    s->vcs = g_ptr_array_new_with_free_func(gd_vc_free);
     s->opts = opts;
 
     theme = gtk_icon_theme_get_default();
@@ -2582,13 +2640,10 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 
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
 
@@ -2693,6 +2748,9 @@ static void gtk_display_cleanup(void)
 
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


