Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB4BC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kGs-0004CS-Id; Mon, 21 Sep 2026 16:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x8kGh-0004BU-VV
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:05:41 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x8kGg-0004w8-5N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790021138; x=1821557138;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XfvZzDpEXLn4QuaLAjlHI0ftUmg5ZFJ7OxwmnzPDewk=;
 b=VlKYnukVJxPGrnA040t6naGD5ddjBBrhDQUT/6cSm1Bu/YzDpjWxmzif
 ORO7Pvm9YAJBONMVoigO93pv3iexG7b9xl+7yPHCuiv32fxJuVLDDzgis
 fOeHRSpcEbfOIXhllyfLocNAj5c/8/B4HyT1LQQtquSG28DJy/42Zlm68
 ulhRnVy4FlGZ0ZP3uOI+4PUNYnY/TpjswcQivsEkQ3+gXMMmHWEP0HVRA
 91rMuyIzVmwHZ7Rq82a5TqHz8R0uTQSCTAzQGLblBRAwmzZoAcxLzacNv
 LRu4WEKB14S8kyD5XA9ClcvixlErO4jPVvPsv9p/XpToIoCIVN+i8YgRc w==;
X-CSE-ConnectionGUID: ro7XrRAvTie6lcG2D1zkxA==
X-CSE-MsgGUID: vhY+2Zo0TUKmM1j7K7cwqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94399578"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="94399578"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 13:05:30 -0700
X-CSE-ConnectionGUID: P7M3tj4ST9C9M9yneqiZUw==
X-CSE-MsgGUID: 1BXPS1AVQ/qxzLkD650X0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="272001014"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2026 13:05:29 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] ui/gtk: Enable fullscreen and zoom hotkeys for
 detached windows
Date: Tue, 11 Aug 2026 03:24:24 -0700
Message-Id: <20260811102426.35538-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811102426.35538-1-dongwon.kim@intel.com>
References: <20260811102426.35538-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
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

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 148 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 111 insertions(+), 37 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index ed7ffc06b1..5427c2f174 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1562,7 +1562,6 @@ static gboolean gd_win_grab(void *opaque)
 {
     VirtualConsole *vc = opaque;
 
-    fprintf(stderr, "%s: %s\n", __func__, vc->label);
     if (vc->s->ptr_owner) {
         gd_ungrab_pointer(vc->s);
     } else {
@@ -1571,6 +1570,96 @@ static gboolean gd_win_grab(void *opaque)
     return TRUE;
 }
 
+static gboolean gd_win_full_screen(void *opaque)
+{
+    VirtualConsole *vc = opaque;
+    GdkWindow *window;
+    GdkWindowState state;
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
+    state = gdk_window_get_state(window);
+
+    if (state & GDK_WINDOW_STATE_FULLSCREEN) {
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
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(vc->s->zoom_fit_item),
+                                   FALSE);
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
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(vc->s->zoom_fit_item),
+                                   FALSE);
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
@@ -1609,9 +1698,24 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
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
@@ -1691,17 +1795,7 @@ static void gd_menu_zoom_in(GtkMenuItem *item, void *opaque)
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
+    gd_win_zoom_in(vc);
 }
 
 static void gd_accel_zoom_in(void *opaque)
@@ -1715,20 +1809,7 @@ static void gd_menu_zoom_out(GtkMenuItem *item, void *opaque)
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
+    gd_win_zoom_out(vc);
 }
 
 static void gd_menu_zoom_fixed(GtkMenuItem *item, void *opaque)
@@ -1736,14 +1817,7 @@ static void gd_menu_zoom_fixed(GtkMenuItem *item, void *opaque)
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
+    gd_win_zoom_fixed(vc);
 }
 
 static void gd_menu_zoom_fit(GtkMenuItem *item, void *opaque)
-- 
2.43.0


