Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED4606A32F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cXUbmMxw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJydj-0005FX-SJ; Thu, 22 Oct 2026 15:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xJydX-0005DO-HZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:39:41 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xJydT-0002bw-LL
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792697976; x=1824233976;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZNQcZx8pWbR9+hOBojzN5ro7Z8a1dMxDKtQmMu3nuGE=;
 b=cXUbmMxwFof62Np6AHTLIbTYXvOHyGw0g0WMmq/+4K5jgrsMXGYwcUd3
 5iPL6MaIbK5m01SGjCPQiyDuP30WioI3eij8DkUnlvH01/jf8+aePQ95k
 8DE3FuaA6zWjP3leUWW89WFaeXbERdMxxmRPymsFErkjWi3Xed+ACSYIr
 V6jFYnc3Lj5H75fn08lkcThhEhEuECoALO7PyaNXxCW+ry5G7BkOvB/IX
 U1wk/Np/onv7KVjfGkjI3qjYPvm6T9Y5CTsP+W1WzApUmexMdJcuEiu5K
 8BtltZv3JSo1UtOIfbdeEZK9BIqmsxzfKARM4ZR4sYjd3NZgxwW95TNpR Q==;
X-CSE-ConnectionGUID: PgNrQiUYRmOgeBblqKXcng==
X-CSE-MsgGUID: ckCkQr8SSK2L5ZMiNT2cAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1563782"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1563782"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 12:39:27 -0700
X-CSE-ConnectionGUID: BqqKjZzjRzy2Sbe/bySTaw==
X-CSE-MsgGUID: qYyBShVYQS6nNSzK+iWKvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3530577"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by orviesa006.jf.intel.com with ESMTP; 22 Oct 2026 12:39:27 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH v3 1/3] ui/gtk: Enable fullscreen and zoom hotkeys for
 detached windows
Date: Thu, 22 Oct 2026 12:39:42 -0700
Message-Id: <20261022193944.19266-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022193944.19266-1-dongwon.kim@intel.com>
References: <20261022193944.19266-1-dongwon.kim@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dongwon Kim <dongwon.kim@intel.com>

Currently, the fullscreen toggle hotkey (Ctrl+Alt+f by default) and zoom
hotkeys (Ctrl+Alt++, Ctrl+Alt+-, Ctrl+Alt+0) only function for the main
QEMU window. When a VC is detached (untabified), it loses these capabilities.

Implement toggle helpers, gd_win_full_screen and zoom helpers
(gd_win_zoom_in, gd_win_zoom_out, gd_win_zoom_fixed) and connect them
to the detached window's accelerator group in gd_menu_untabify.

Also remove a leftover debug fprintf in gd_win_grab.

v2:
 - Reuse gd_win_zoom_* in gd_menu_zoom_* to avoid duplicated scaling logic
 - Guard zoom helpers against NULL or non-GFX consoles
   (!vc || vc->type != GD_VC_GFX)
 - Keep both GDK_KEY_plus and GDK_KEY_equal accelerators

v3:
 - Add gd_is_full_screen() to query GdkWindowState directly and replace
   s->full_screen checks across attached and detached consoles
 - Keep zoom_fit_item deactivation in gd_menu_zoom_* while keeping
   gd_win_zoom_* focused on per-VC scaling
 - Restrict global free_scale handling to attached consoles so detached
   window geometry is not overridden

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/gtk.h |   2 -
 ui/gtk.c         | 183 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 135 insertions(+), 50 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 6b62e97588..d2ccbd2c0d 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -138,8 +138,6 @@ struct GtkDisplayState {
     VirtualConsole *kbd_owner;
     VirtualConsole *ptr_owner;
 
-    gboolean full_screen;
-
     GdkCursor *null_cursor;
     Notifier mouse_mode_notifier;
     VMChangeStateEntry *vmse;
diff --git a/ui/gtk.c b/ui/gtk.c
index 8d312d6a4b..724ede5633 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -202,6 +202,22 @@ static bool gd_grab_on_hover(GtkDisplayState *s)
     return gtk_check_menu_item_get_active(GTK_CHECK_MENU_ITEM(s->grab_on_hover_item));
 }
 
+static bool gd_is_full_screen(GtkWidget *widget)
+{
+    GdkWindow *window;
+
+    if (!widget || !gtk_widget_get_realized(widget)) {
+        return FALSE;
+    }
+
+    window = gtk_widget_get_window(widget);
+    if (!window) {
+        return FALSE;
+    }
+
+    return gdk_window_get_state(window) & GDK_WINDOW_STATE_FULLSCREEN;
+}
+
 static void gd_update_cursor(VirtualConsole *vc)
 {
     GtkDisplayState *s = vc->s;
@@ -217,7 +233,8 @@ static void gd_update_cursor(VirtualConsole *vc)
     }
 
     window = gtk_widget_get_window(GTK_WIDGET(vc->gfx.drawing_area));
-    if (s->full_screen || qemu_input_is_absolute(vc->gfx.dcl.con) || s->ptr_owner == vc) {
+    if (gd_is_full_screen(vc->window ? vc->window : s->window) ||
+        qemu_input_is_absolute(vc->gfx.dcl.con) || s->ptr_owner == vc) {
         gdk_window_set_cursor(window, s->null_cursor);
     } else {
         gdk_window_set_cursor(window, NULL);
@@ -341,7 +358,9 @@ void gd_update_windowsize(VirtualConsole *vc)
 
     gd_update_geometry_hints(vc);
 
-    if (vc->type == GD_VC_GFX && !s->full_screen && !s->free_scale) {
+    if (vc->type == GD_VC_GFX &&
+        !gd_is_full_screen(vc->window ? vc->window : s->window) &&
+        !s->free_scale) {
         gtk_window_resize(GTK_WINDOW(vc->window ? vc->window : s->window),
                           VC_WINDOW_X_MIN, VC_WINDOW_Y_MIN);
     }
@@ -792,7 +811,8 @@ static void gd_resize_event(GtkGLArea *area,
     GdkWindow *window = gtk_widget_get_window(GTK_WIDGET(area));
     const int gs = gdk_window_get_scale_factor(window);
 
-    if (!vc->s->free_scale && !vc->s->full_screen) {
+    if ((!vc->s->free_scale || vc->window) &&
+        !gd_is_full_screen(vc->window ? vc->window : vc->s->window)) {
         pw /= sx;
         ph /= sy;
     }
@@ -835,10 +855,10 @@ void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh)
         return;
     }
 
-    if (vc->s->full_screen) {
+    if (gd_is_full_screen(vc->window ? vc->window : vc->s->window)) {
         vc->gfx.scale_x = (double)ww / fbw;
         vc->gfx.scale_y = (double)wh / fbh;
-    } else if (vc->s->free_scale) {
+    } else if (vc->s->free_scale && !vc->window) {
         double sx, sy;
 
         sx = (double)ww / fbw;
@@ -1562,7 +1582,6 @@ static gboolean gd_win_grab(void *opaque)
 {
     VirtualConsole *vc = opaque;
 
-    fprintf(stderr, "%s: %s\n", __func__, vc->label);
     if (vc->s->ptr_owner) {
         gd_ungrab_pointer(vc->s);
     } else {
@@ -1571,6 +1590,87 @@ static gboolean gd_win_grab(void *opaque)
     return TRUE;
 }
 
+static gboolean gd_win_full_screen(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+    GdkWindow *window;
+
+    if (!vc || !vc->window || !gtk_widget_get_realized(vc->window)) {
+        return TRUE;
+    }
+
+    window = gtk_widget_get_window(vc->window);
+    if (!window) {
+        return TRUE;
+    }
+
+    if (gd_is_full_screen(vc->window)) {
+        gtk_window_unfullscreen(GTK_WINDOW(vc->window));
+
+        if (vc->type == GD_VC_GFX) {
+            vc->gfx.scale_x = vc->gfx.preferred_scale;
+            vc->gfx.scale_y = vc->gfx.preferred_scale;
+            gd_update_windowsize(vc);
+        }
+    } else {
+        if (vc->type == GD_VC_GFX) {
+            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
+        }
+        gtk_window_fullscreen(GTK_WINDOW(vc->window));
+    }
+
+    gd_update_cursor(vc);
+    return TRUE;
+}
+
+static gboolean gd_win_zoom_in(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+
+    if (!vc || vc->type != GD_VC_GFX) {
+        return TRUE;
+    }
+
+    vc->gfx.scale_x += VC_SCALE_STEP;
+    vc->gfx.scale_y += VC_SCALE_STEP;
+
+    gd_update_windowsize(vc);
+    return TRUE;
+}
+
+static gboolean gd_win_zoom_out(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+
+    if (!vc || vc->type != GD_VC_GFX) {
+        return TRUE;
+    }
+
+    vc->gfx.scale_x -= VC_SCALE_STEP;
+    vc->gfx.scale_y -= VC_SCALE_STEP;
+
+    vc->gfx.scale_x = MAX(vc->gfx.scale_x, VC_SCALE_MIN);
+    vc->gfx.scale_y = MAX(vc->gfx.scale_y, VC_SCALE_MIN);
+
+    gd_update_windowsize(vc);
+    return TRUE;
+}
+
+static gboolean gd_win_zoom_fixed(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+
+    if (!vc || vc->type != GD_VC_GFX) {
+        return TRUE;
+    }
+
+    vc->gfx.scale_x = vc->gfx.preferred_scale;
+    vc->gfx.scale_y = vc->gfx.preferred_scale;
+
+    gd_update_windowsize(vc);
+    return TRUE;
+}
+
 static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
@@ -1609,9 +1709,24 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
             GtkAccelGroup *ag = gtk_accel_group_new();
             gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
 
-            GClosure *cb = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
-                                               vc, NULL);
-            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb);
+            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_f, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_full_screen),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_plus, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_in),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_equal, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_in),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_minus, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_out),
+                                        vc, NULL));
+            gtk_accel_group_connect(ag, GDK_KEY_0, HOTKEY_MODIFIERS, 0,
+                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_fixed),
+                                        vc, NULL));
         }
 
         gd_rebuild_vc_menu(s);
@@ -1625,7 +1740,7 @@ static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    if (s->full_screen) {
+    if (gd_is_full_screen(s->window)) {
         return;
     }
 
@@ -1652,14 +1767,13 @@ static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    if (!s->full_screen) {
+    if (!gd_is_full_screen(s->window)) {
         gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
         gtk_widget_hide(s->menu_bar);
         if (vc && vc->type == GD_VC_GFX) {
             gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
         }
         gtk_window_fullscreen(GTK_WINDOW(s->window));
-        s->full_screen = TRUE;
     } else {
         gtk_window_unfullscreen(GTK_WINDOW(s->window));
         gd_menu_show_tabs(GTK_MENU_ITEM(s->show_tabs_item), s);
@@ -1667,7 +1781,6 @@ static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
                     GTK_CHECK_MENU_ITEM(s->show_menubar_item))) {
             gtk_widget_show(s->menu_bar);
         }
-        s->full_screen = FALSE;
         if (vc && vc->type == GD_VC_GFX) {
             vc->gfx.scale_x = vc->gfx.preferred_scale;
             vc->gfx.scale_y = vc->gfx.preferred_scale;
@@ -1691,17 +1804,8 @@ static void gd_menu_zoom_in(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    if (!vc) {
-        return;
-    }
-
-    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item),
-                                   FALSE);
-
-    vc->gfx.scale_x += VC_SCALE_STEP;
-    vc->gfx.scale_y += VC_SCALE_STEP;
-
-    gd_update_windowsize(vc);
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item), FALSE);
+    gd_win_zoom_in(vc);
 }
 
 static void gd_accel_zoom_in(void *opaque)
@@ -1715,20 +1819,8 @@ static void gd_menu_zoom_out(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    if (!vc) {
-        return;
-    }
-
-    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item),
-                                   FALSE);
-
-    vc->gfx.scale_x -= VC_SCALE_STEP;
-    vc->gfx.scale_y -= VC_SCALE_STEP;
-
-    vc->gfx.scale_x = MAX(vc->gfx.scale_x, VC_SCALE_MIN);
-    vc->gfx.scale_y = MAX(vc->gfx.scale_y, VC_SCALE_MIN);
-
-    gd_update_windowsize(vc);
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item), FALSE);
+    gd_win_zoom_out(vc);
 }
 
 static void gd_menu_zoom_fixed(GtkMenuItem *item, void *opaque)
@@ -1736,14 +1828,8 @@ static void gd_menu_zoom_fixed(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    if (!vc) {
-        return;
-    }
-
-    vc->gfx.scale_x = vc->gfx.preferred_scale;
-    vc->gfx.scale_y = vc->gfx.preferred_scale;
-
-    gd_update_windowsize(vc);
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item), FALSE);
+    gd_win_zoom_fixed(vc);
 }
 
 static void gd_menu_zoom_fit(GtkMenuItem *item, void *opaque)
@@ -1907,7 +1993,7 @@ static void gd_change_page(GtkNotebook *nb, gpointer arg1, guint arg2,
     if (!on_vga) {
         gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
                                        FALSE);
-    } else if (s->full_screen) {
+    } else if (gd_is_full_screen(s->window)) {
         gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
                                        TRUE);
     }
@@ -1971,7 +2057,8 @@ static gboolean gd_configure(GtkWidget *widget,
     const double sx = vc->gfx.scale_x, sy = vc->gfx.scale_y;
     double width = cfg->width, height = cfg->height;
 
-    if (!vc->s->free_scale && !vc->s->full_screen) {
+    if ((!vc->s->free_scale || vc->window) &&
+        !gd_is_full_screen(vc->window ? vc->window : vc->s->window)) {
         width /= sx;
         height /= sy;
     }
-- 
2.43.0


