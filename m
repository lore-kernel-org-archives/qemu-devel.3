Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0982DCDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1j-0005sh-L7; Wed, 24 Jun 2026 07:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1g-0005iJ-6W
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1c-0008Gq-No
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQ+AmLqOBXswCrNh2TEozyDCdA3KR/XjPZRFYDEEfn0=;
 b=ejTzU0tFHboqjGc8y6uv/TXr5Goujc1oYFVKuefoaylIiKXeKB6jBbHXRxE3Eu0jdsSpYu
 ZTiEGVeIzXQpArx5VrQuwsaQnfq9k0jS47FcRKNYSP9WjCcTdSDIFhwYR8WiK/oEkRPEQN
 RmQCx6USxL2c77dVmT5eJyeoShD12go=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-ybv6DdIjOx27AW6RJ8S4OQ-1; Wed,
 24 Jun 2026 07:44:10 -0400
X-MC-Unique: ybv6DdIjOx27AW6RJ8S4OQ-1
X-Mimecast-MFC-AGG-ID: ybv6DdIjOx27AW6RJ8S4OQ_1782301449
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D0761955F44
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:44:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A218180028B; Wed, 24 Jun 2026 11:44:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:51 +0400
Subject: [GIT PULL 29/35] ui/gtk: centralize console menu and shortcut
 management
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-29-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11758;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zRVnHYFnOTV49gZmsELLbX0EIR4iua2PFIT11izje5w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JoT3HAYSAQLJpwI2c16B+Nf9FHIoAWQ90I2
 dA5Uj3n1RWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaAAKCRDa6OEJdZac
 5VPoD/9eQWVdmj5vr6/iA1cbfCDGWBiYQVGK/xzYag0GU105e1jXy25TTwAAIb0wj9YaVnNV0Qa
 s1+N94vOirseWFdultFvA5EFtRplB1FNGE5TQQTqG/mbE0eK6wzQSkU+vHuKZZdVrHgtxA5271Z
 n1dDzCtskiDVNs9W91FmN5FFVxZcvMBtWQQs11HqRFwxl6IIMpax6xiCQnR9bEMi+L2QSpQTUJP
 DASlLAcXhmN2sr1xFMbhv8xgALY7Q/sd9/Rmq50XHnBTFg3r5hizmh3dtvMvzOlpkvau7IyUypi
 bxsLlSxMsXHiCjJfmBb9dlLIjMF2VAlSJtHpsAYTyouaVJn+MHgbKrXKSSDPWlmLAbpCPNr4veK
 /5Cq3ojygM1iawdDA50Gr2FYDwzoMPFhiO7nKZLAjtcpuZoYDnfrAraKkPMGws3rxFBtrfoed1n
 T6ZmMnng5QIYG4zkdKLLRBfB31IiOHZMz94Lk2mpaZvu68kjDEgVXjEf0Is3H6RHpoB2n6+yFIp
 DDi7g6fiVu+wjeHWnT+FLEhyJ+6p/OnttZwBXVQWcKpdEyBdf2TZKgaI4o2p2ZXT6YgtbfzrKHI
 Ct5f9XAgSInmZoWT7DAT1piLGyo2EdUMms82Gv1WG8kYzhN9VeGEXeEwNQBkOT004z8/ZOP3sgb
 jNeR3xSMeNZU/4w==
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

Replace the per-console gd_vc_menu_init() with gd_rebuild_vc_menu()
that tears down and rebuilds all console radio menu items and
Ctrl+Alt+N accelerators at once. This is called from initialization
and whenever consoles are detached or reattached.

Shortcuts now skip detached (windowed) consoles, so they always map
to reachable tabs. Rename gd_vc_gfx_init() to add_gfx_console()
and simplify the init function signatures now that menu creation is
decoupled.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-29-4656aec3398d@redhat.com>
---
 include/ui/gtk.h |   1 +
 ui/gtk.c         | 127 ++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 85 insertions(+), 43 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index fb60cbfda5d..53d0e447a23 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -120,6 +120,7 @@ struct GtkDisplayState {
 
     GPtrArray *vcs;
 
+    GtkWidget *vc_menu_separator;
     GtkWidget *show_tabs_item;
     GtkWidget *untabify_item;
     GtkWidget *show_menubar_item;
diff --git a/ui/gtk.c b/ui/gtk.c
index 741f7bfe373..e7a9156f206 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -142,6 +142,7 @@ static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_pointer(GtkDisplayState *s);
 static void gd_grab_keyboard(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_keyboard(GtkDisplayState *s);
+static void gd_rebuild_vc_menu(GtkDisplayState *s);
 
 /** Utility Functions **/
 
@@ -1488,7 +1489,6 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     GtkDisplayState *s = vc->s;
     int page;
 
-    gtk_widget_set_sensitive(vc->menu_item, true);
     g_object_ref(vc->tab_item);
     gtk_container_remove(GTK_CONTAINER(vc->window), vc->tab_item);
     page = gd_vc_notebook_pos(s, vc);
@@ -1508,6 +1508,8 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     }
 #endif
 
+    gd_rebuild_vc_menu(s);
+
     if (vc == gd_vc_find_by_menu(s)) {
         gtk_widget_grab_focus(vc->focus);
     }
@@ -1539,7 +1541,6 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
                                        FALSE);
     }
     if (!vc->window) {
-        gtk_widget_set_sensitive(vc->menu_item, false);
         vc->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
 #if defined(CONFIG_OPENGL)
         if (vc->gfx.esurface) {
@@ -1566,6 +1567,7 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
             gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb);
         }
 
+        gd_rebuild_vc_menu(s);
         gd_update_geometry_hints(vc);
         gd_update_caption(s);
     }
@@ -1906,22 +1908,73 @@ static gboolean gd_configure(GtkWidget *widget,
 
 /** Virtual Console Callbacks **/
 
-static GSList *gd_vc_menu_init(GtkDisplayState *s, VirtualConsole *vc,
-                               int idx, GSList *group, GtkWidget *view_menu)
+static void gd_rebuild_vc_menu(GtkDisplayState *s)
 {
-    vc->menu_item = gtk_radio_menu_item_new_with_mnemonic(group, vc->label);
-    gtk_accel_group_connect(s->accel_group, GDK_KEY_1 + idx,
-            HOTKEY_MODIFIERS, 0,
-            g_cclosure_new_swap(G_CALLBACK(gd_accel_switch_vc), vc, NULL));
-    gtk_accel_label_set_accel(
-            GTK_ACCEL_LABEL(gtk_bin_get_child(GTK_BIN(vc->menu_item))),
-            GDK_KEY_1 + idx, HOTKEY_MODIFIERS);
+    GSList *group = NULL;
+    VirtualConsole *vc;
+    GList *children;
+    gint insert_pos;
+    int shortcut_idx = 0;
+    guint i;
+
+    for (i = 0; i < s->vcs->len; i++) {
+        vc = g_ptr_array_index(s->vcs, i);
+        if (vc->menu_item) {
+            gtk_widget_destroy(vc->menu_item);
+            vc->menu_item = NULL;
+        }
+    }
+
+    for (i = 0; i < 9; i++) {
+        gtk_accel_group_disconnect_key(s->accel_group,
+                                       GDK_KEY_1 + i, HOTKEY_MODIFIERS);
+    }
+
+    /* find insertion position (just before vc_menu_separator) */
+    children = gtk_container_get_children(GTK_CONTAINER(s->view_menu));
+    insert_pos = g_list_index(children, s->vc_menu_separator);
+    g_list_free(children);
+
+    /* create new menu items for each console */
+    for (i = 0; i < s->vcs->len; i++) {
+        vc = g_ptr_array_index(s->vcs, i);
 
-    g_signal_connect(vc->menu_item, "activate",
-                     G_CALLBACK(gd_menu_switch_vc), s);
-    gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), vc->menu_item);
+        vc->menu_item = gtk_radio_menu_item_new_with_mnemonic(group,
+                                                               vc->label);
+        group = gtk_radio_menu_item_get_group(
+            GTK_RADIO_MENU_ITEM(vc->menu_item));
+
+        if (vc->window) {
+            gtk_widget_set_sensitive(vc->menu_item, false);
+        } else if (shortcut_idx < 9) {
+            guint key = GDK_KEY_1 + shortcut_idx;
+            gtk_accel_group_connect(s->accel_group, key,
+                    HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_accel_switch_vc),
+                                        vc, NULL));
+            gtk_accel_label_set_accel(
+                    GTK_ACCEL_LABEL(gtk_bin_get_child(GTK_BIN(vc->menu_item))),
+                    key, HOTKEY_MODIFIERS);
+            shortcut_idx++;
+        }
 
-    return gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_item));
+        g_signal_connect(vc->menu_item, "activate",
+                         G_CALLBACK(gd_menu_switch_vc), s);
+        gtk_menu_shell_insert(GTK_MENU_SHELL(s->view_menu),
+                              vc->menu_item, insert_pos + i);
+        gtk_widget_show(vc->menu_item);
+    }
+
+    /* sync active menu item with current notebook page */
+    vc = gd_vc_find_current(s);
+    if (vc && vc->menu_item) {
+        g_signal_handlers_block_by_func(vc->menu_item,
+                                        gd_menu_switch_vc, s);
+        gtk_check_menu_item_set_active(
+            GTK_CHECK_MENU_ITEM(vc->menu_item), TRUE);
+        g_signal_handlers_unblock_by_func(vc->menu_item,
+                                          gd_menu_switch_vc, s);
+    }
 }
 
 #if defined(CONFIG_VTE)
@@ -2064,9 +2117,8 @@ static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
     return TRUE;
 }
 
-static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
-                              Chardev *chr, int idx,
-                              GSList *group, GtkWidget *view_menu)
+static void gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
+                           Chardev *chr, int idx)
 {
     char buffer[32];
     GtkWidget *box;
@@ -2082,7 +2134,6 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
 
     snprintf(buffer, sizeof(buffer), "vc%d", idx);
     vc->label = g_strdup(vc->vte.chr->label ? : buffer);
-    group = gd_vc_menu_init(s, vc, idx, group, view_menu);
 
     vc->vte.terminal = vte_terminal_new();
     g_signal_connect(vc->vte.terminal, "commit", G_CALLBACK(gd_vc_in), vc);
@@ -2128,20 +2179,16 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
                              gtk_label_new(vc->label));
 
     qemu_chr_be_event(vc->vte.chr, CHR_EVENT_OPENED);
-
-    return group;
 }
 
-static void gd_vcs_init(GtkDisplayState *s, GSList *group,
-                        GtkWidget *view_menu)
+static void gd_vcs_init(GtkDisplayState *s)
 {
     int i;
 
     for (i = 0; i < nb_vcs; i++) {
         VirtualConsole *vc = g_new0(VirtualConsole, 1);
         g_ptr_array_add(s->vcs, vc);
-        group = gd_vc_vte_init(s, vc, vcs[i], s->vcs->len - 1,
-                               group, view_menu);
+        gd_vc_vte_init(s, vc, vcs[i], s->vcs->len - 1);
     }
 }
 #endif /* CONFIG_VTE */
@@ -2285,12 +2332,12 @@ static bool gd_scale_valid(double scale)
     return scale >= VC_SCALE_MIN && scale <= VC_SCALE_MAX;
 }
 
-static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
-                              QemuConsole *con, int idx,
-                              GSList *group, GtkWidget *view_menu)
+static void add_gfx_console(GtkDisplayState *s, QemuConsole *con)
 {
+    VirtualConsole *vc = g_new0(VirtualConsole, 1);
     const DisplayChangeListenerOps *ops = &dcl_ops;
 
+    g_ptr_array_add(s->vcs, vc);
     vc->label = qemu_console_get_label(con);
     vc->s = s;
     vc->gfx.preferred_scale = 1.0;
@@ -2367,14 +2414,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
     qemu_console_register_listener(con, &vc->gfx.dcl, ops);
 
     gd_connect_vc_gfx_signals(vc);
-    group = gd_vc_menu_init(s, vc, idx, group, view_menu);
-
-    return group;
 }
 
-static GtkWidget *gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
+static void gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
 {
-    GSList *group = NULL;
     GtkWidget *view_menu;
     GtkWidget *separator;
     QemuConsole *con;
@@ -2382,6 +2425,7 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
     int vc, i;
 
     view_menu = gtk_menu_new();
+    s->view_menu = view_menu;
     gtk_menu_set_accel_group(GTK_MENU(view_menu), s->accel_group);
 
     s->full_screen_item = gtk_menu_item_new_with_mnemonic(_("_Fullscreen"));
@@ -2445,14 +2489,11 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
 
     /* gfx */
     for (vc = 0;; vc++) {
-        VirtualConsole *v;
         con = qemu_console_lookup_by_index(vc);
         if (!con) {
             break;
         }
-        v = g_new0(VirtualConsole, 1);
-        g_ptr_array_add(s->vcs, v);
-        group = gd_vc_gfx_init(s, v, con, vc, group, view_menu);
+        add_gfx_console(s, con);
         if (qemu_console_ui_info_supported(con)) {
             zoom_to_fit = true;
         }
@@ -2478,11 +2519,13 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
 
 #if defined(CONFIG_VTE)
     /* vte */
-    gd_vcs_init(s, group, view_menu);
+    gd_vcs_init(s);
 #endif
 
-    separator = gtk_separator_menu_item_new();
-    gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), separator);
+    s->vc_menu_separator = gtk_separator_menu_item_new();
+    gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->vc_menu_separator);
+
+    gd_rebuild_vc_menu(s);
 
     s->show_tabs_item = gtk_check_menu_item_new_with_mnemonic(_("Show _Tabs"));
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->show_tabs_item);
@@ -2501,8 +2544,6 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
             GTK_ACCEL_LABEL(gtk_bin_get_child(GTK_BIN(s->show_menubar_item))),
             GDK_KEY_m, HOTKEY_MODIFIERS);
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->show_menubar_item);
-
-    return view_menu;
 }
 
 static void gd_create_menus(GtkDisplayState *s, DisplayOptions *opts)
@@ -2511,7 +2552,7 @@ static void gd_create_menus(GtkDisplayState *s, DisplayOptions *opts)
 
     s->accel_group = gtk_accel_group_new();
     s->machine_menu = gd_create_menu_machine(s);
-    s->view_menu = gd_create_menu_view(s, opts);
+    gd_create_menu_view(s, opts);
 
     s->machine_menu_item = gtk_menu_item_new_with_mnemonic(_("_Machine"));
     gtk_menu_item_set_submenu(GTK_MENU_ITEM(s->machine_menu_item),

-- 
2.54.0


