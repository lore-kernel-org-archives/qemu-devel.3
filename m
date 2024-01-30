Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722AEC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 23:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUxrC-0000pM-RR; Tue, 30 Jan 2024 18:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rUxrB-0000ow-9B
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 18:49:33 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rUxr9-0003Zp-BI
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 18:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706658571; x=1738194571;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KY/AMnlQUPEtmtyCg8/YEs9GcXSzmt79ngRlqR1yPJA=;
 b=SRBo0Cph0BFfAnQgNBQ3ANKPhrr87X/4/+SW056N85Qb1LGXSI9sAj0J
 hfPq6ABMGknJMR7OkMc4rTIxbMAGG8fwA8r3hkrgbAHqHAtLhdUGmv4ka
 a3EjmlSB1Q49iGJaHcfiagdC7Ns34COx/53aJHukvIHSQhveJdNQpxmFS
 S/EL9szEMmTmIZlvSefI7suq6ADMD3H0zEQDObhOMATH5hkgxdJJrYqzP
 V79O3IApayPVY3Zq70DcgxQJrymD2AJByVitDaWu52oeV0PF544q6SITL
 t9d84RGtH2N7O68g0s/dSxEtjc6pcU0s6DRIxlXgMMg/4h3Z6MpltVEYu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="393887939"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; d="scan'208";a="393887939"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 15:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="737919634"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; d="scan'208";a="737919634"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orsmga003.jf.intel.com with ESMTP; 30 Jan 2024 15:49:23 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated VC is
 invisible
Date: Tue, 30 Jan 2024 15:48:38 -0800
Message-Id: <20240130234840.53122-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130234840.53122-1-dongwon.kim@intel.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

A new flag "visible" is added to show visibility status of the gfx console.
The flag is set to 'true' when the VC is visible but set to 'false' when
it is hidden or closed. When the VC is invisible, drawing guest frames
should be skipped as it will never be completed and it would potentially
lock up the guest display especially when blob scanout is used.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/gtk.h |  1 +
 ui/gtk-egl.c     |  8 ++++++++
 ui/gtk-gl-area.c |  8 ++++++++
 ui/gtk.c         | 10 +++++++++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index aa3d637029..2de38e5724 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -57,6 +57,7 @@ typedef struct VirtualGfxConsole {
     bool y0_top;
     bool scanout_mode;
     bool has_dmabuf;
+    bool visible;
 #endif
 } VirtualGfxConsole;
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 3af5ac5bcf..993c283191 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -265,6 +265,10 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 #ifdef CONFIG_GBM
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
 
@@ -363,6 +367,10 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GtkWidget *area = vc->gfx.drawing_area;
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 52dcac161e..04e07bd7ee 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -285,6 +285,10 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
@@ -299,6 +303,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 #ifdef CONFIG_GBM
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     egl_dmabuf_import_texture(dmabuf);
     if (!dmabuf->texture) {
diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..02eb667d8a 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1312,15 +1312,20 @@ static void gd_menu_quit(GtkMenuItem *item, void *opaque)
 static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
-    VirtualConsole *vc = gd_vc_find_by_menu(s);
+    VirtualConsole *vc;
     GtkNotebook *nb = GTK_NOTEBOOK(s->notebook);
     gint page;
 
+    vc = gd_vc_find_current(s);
+    vc->gfx.visible = false;
+
+    vc = gd_vc_find_by_menu(s);
     gtk_release_modifiers(s);
     if (vc) {
         page = gtk_notebook_page_num(nb, vc->tab_item);
         gtk_notebook_set_current_page(nb, page);
         gtk_widget_grab_focus(vc->focus);
+        vc->gfx.visible = true;
     }
 }
 
@@ -1350,6 +1355,7 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     VirtualConsole *vc = opaque;
     GtkDisplayState *s = vc->s;
 
+    vc->gfx.visible = false;
     gtk_widget_set_sensitive(vc->menu_item, true);
     gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
     gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(s->notebook),
@@ -1423,6 +1429,7 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
         gd_update_geometry_hints(vc);
         gd_update_caption(s);
     }
+    vc->gfx.visible = true;
 }
 
 static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
@@ -2471,6 +2478,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 #ifdef CONFIG_GTK_CLIPBOARD
     gd_clipboard_init(s);
 #endif /* CONFIG_GTK_CLIPBOARD */
+    vc->gfx.visible = true;
 }
 
 static void early_gtk_display_init(DisplayOptions *opts)
-- 
2.34.1


