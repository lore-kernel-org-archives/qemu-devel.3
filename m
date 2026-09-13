Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571F4C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hgS-0005pB-Sa; Sun, 13 Sep 2026 06:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgQ-0005nx-Aa
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgO-0008ID-JF
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5dCe2Luo46iFHPC9Z2GbpIJ3CpqnnchAWjtdO6rkMk=;
 b=TwO6mUwvLZ8IFRzyFOUaBQ+Cc7nVndlcr2VoK87RBRupBxfnq08nYC/Y/pwTMNZehhyFGU
 Oh42JxJVRZhCVWvOFYk2t8DpS56KXZ48CVWatWiH5a5SYasQlNJCT8OxUyfScyVsvnvAgZ
 folsmTU0EEaceCjTZhurfEi8cxgLGO8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-NqQF6D7yNMevsD80wWfOhQ-1; Sun,
 13 Sep 2026 06:43:34 -0400
X-MC-Unique: NqQF6D7yNMevsD80wWfOhQ-1
X-Mimecast-MFC-AGG-ID: NqQF6D7yNMevsD80wWfOhQ_1789296213
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49B0D1954107
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:33 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6920C18004D4; Sun, 13 Sep 2026 10:43:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:31 +0400
Subject: [GIT PULL 13/14] ui/gtk: Handle empty notebook state in menu handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-13-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6260;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sLvAWFM1oOMDuI6batXscGLcxe2Yb8Nyq28bv/2gwa8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4jH3an+T+ZfZmPff09Zvh0c5XriIhzhuDV6
 eJF2EH77qyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IwAKCRDa6OEJdZac
 5R2CEACUk8sNvqXAg1e38ZcGtBNbHrg23S6vjgvxhyjpaZi/6VkHPmfFTbvFZ9bG7EH5VkyfBO3
 FA03F7zldmfAJmFAIrmz1cD4vN2LQJmoJuY0u4Rfr9otrhnPqSXgL5TADd0rwDJ1pfjTo0Gl18v
 ks97mwosoaw0Hzk0jRVfR8GluYEghulm8CR93y7TFGPntCZQBX2jMgTVIpC8VPgS7/jZSdx9Jtx
 Wg31uiuweqnyKTunl3R6hbP2S9blWQvkLUlJL4GfFRxpHPq6fupGrNbnHtYc9rYdExH0i+DrcCh
 bNsvLKmEVlp1QgBQNj+ri9Zpe2zqhSk+gYS8LnXY8+Nc/n6EoR8fAtkmtd3n51V35JqXpa0pv92
 A8ASdZ88oey8eRPVTKAd+6QlkkHOeiA98EsUjnCYgLxEk5ZN4Svpitp2thWWAWK+KuFxG4KNMbT
 LGkZIz0bKMsPd1574LViCUXZWmiOqMUVYIZ6Kct/oeS8ET3JoKjsxKBtwZRhatRsVPvXwgoRQ/P
 ld1ZQnampfTqW8+Lnp3Q9OL1mhkD/K2L0NUeWaQTrLC0YKtuWBTidpQKhKQzrVXgSGTMKW/S4V5
 Ra/RiYh1w5+GdXineqq6b5mG8SO8Htav+QnwMl8yPXNgxPFuAWF3sF+ov8GZQmqjNIIonCniFAk
 IrIMDMwKZqRPPyA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

When all virtual console tabs are detached (untabified) from the main
window, the notebook contains no active pages, causing
gtk_notebook_get_current_page() to return -1.

Because gtk_notebook_page_num() also returns -1 for any detached VC,
gd_vc_find_by_page(s, -1) mistakenly matches the first detached
console. As a result, gd_vc_find_current() incorrectly returns
a detached VC instead of NULL. Menu actions executed on the empty main
window then unintentionally operate on that detached VC.

Fix this by having gd_vc_find_current() explicitly check for page < 0
and return NULL when the notebook has no active page. In addition, add
NULL checks for the current VC across relevant UI menu callbacks so
actions are properly bypassed or reset when no console tab is focused
in the main window.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260729214456.3350-1-dongwon.kim@intel.com>
---
 ui/gtk.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index ae28f1fbb89b..a194488a0cf3 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -184,6 +184,11 @@ static VirtualConsole *gd_vc_find_current(GtkDisplayState *s)
     gint page;
 
     page = gtk_notebook_get_current_page(GTK_NOTEBOOK(s->notebook));
+
+    if (page < 0) {
+        return NULL;
+    }
+
     return gd_vc_find_by_page(s, page);
 }
 
@@ -1469,7 +1474,10 @@ static void gd_menu_show_tabs(GtkMenuItem *item, void *opaque)
     } else {
         gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
     }
-    gd_update_windowsize(vc);
+
+    if (vc) {
+        gd_update_windowsize(vc);
+    }
 }
 
 static int gd_vc_notebook_pos(GtkDisplayState *s, VirtualConsole *target)
@@ -1542,6 +1550,10 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     if (vc->type == GD_VC_GFX &&
         qemu_console_is_graphic(vc->gfx.dcl.con)) {
         gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
@@ -1595,7 +1607,10 @@ static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
     } else {
         gtk_widget_hide(s->menu_bar);
     }
-    gd_update_windowsize(vc);
+
+    if (vc) {
+        gd_update_windowsize(vc);
+    }
 }
 
 static void gd_accel_show_menubar(void *opaque)
@@ -1612,7 +1627,7 @@ static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
     if (!s->full_screen) {
         gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
         gtk_widget_hide(s->menu_bar);
-        if (vc->type == GD_VC_GFX) {
+        if (vc && vc->type == GD_VC_GFX) {
             gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
         }
         gtk_window_fullscreen(GTK_WINDOW(s->window));
@@ -1625,14 +1640,16 @@ static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
             gtk_widget_show(s->menu_bar);
         }
         s->full_screen = FALSE;
-        if (vc->type == GD_VC_GFX) {
+        if (vc && vc->type == GD_VC_GFX) {
             vc->gfx.scale_x = vc->gfx.preferred_scale;
             vc->gfx.scale_y = vc->gfx.preferred_scale;
             gd_update_windowsize(vc);
         }
     }
 
-    gd_update_cursor(vc);
+    if (vc) {
+        gd_update_cursor(vc);
+    }
 }
 
 static void gd_accel_full_screen(void *opaque)
@@ -1646,6 +1663,10 @@ static void gd_menu_zoom_in(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item),
                                    FALSE);
 
@@ -1666,6 +1687,10 @@ static void gd_menu_zoom_out(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item),
                                    FALSE);
 
@@ -1683,6 +1708,10 @@ static void gd_menu_zoom_fixed(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     vc->gfx.scale_x = vc->gfx.preferred_scale;
     vc->gfx.scale_y = vc->gfx.preferred_scale;
 
@@ -1694,6 +1723,10 @@ static void gd_menu_zoom_fit(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
     if (gtk_check_menu_item_get_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item))) {
         s->free_scale = TRUE;
     } else {
@@ -1807,6 +1840,11 @@ static void gd_menu_grab_input(GtkMenuItem *item, void *opaque)
     VirtualConsole *vc = gd_vc_find_current(s);
 
     if (gd_is_grab_active(s)) {
+        if (!vc) {
+            gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
+                                           FALSE);
+            return;
+        }
         gd_grab_keyboard(vc, "user-request-main-window");
         gd_grab_pointer(vc, "user-request-main-window");
     } else {
@@ -1814,7 +1852,9 @@ static void gd_menu_grab_input(GtkMenuItem *item, void *opaque)
         gd_ungrab_pointer(s);
     }
 
-    gd_update_cursor(vc);
+    if (vc) {
+        gd_update_cursor(vc);
+    }
 }
 
 static void gd_change_page(GtkNotebook *nb, gpointer arg1, guint arg2,
@@ -1990,6 +2030,10 @@ static void gd_menu_copy(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+    if (!vc) {
+        return;
+    }
+
 #if VTE_CHECK_VERSION(0, 50, 0)
     vte_terminal_copy_clipboard_format(VTE_TERMINAL(vc->vte.terminal),
                                        VTE_FORMAT_TEXT);

-- 
2.55.0.543.g5ebe2ebe4ea8


