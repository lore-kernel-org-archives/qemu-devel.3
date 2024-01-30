Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA61C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 23:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUxrG-0000qI-RS; Tue, 30 Jan 2024 18:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rUxrD-0000pb-Tr
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 18:49:36 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rUxrB-0003Zp-R5
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 18:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706658573; x=1738194573;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=y85khj6V6EsqOOpJ23xy73wtS49z/4+TEmxb+QPXG+0=;
 b=m4TOli8mtBg2ZLU3cIESjTXACVIqhls+Rr+6Oq8EEPuuM4pq2YbyyBGx
 Pc3G3i3asaZoUl6CVNpHECiVZwchleTRAN68YLBMU34uHykocXYoqTfWG
 sm5EI8r9KV+dFIScmqmg9bwRXBCgn2lGV5+aptfGlAqGtR0fHxPX1458E
 S6oGiESgVU7zsl5C9xJvtE6k8X4vE5wkfpdWtK63q+YRDoN3SeYWvQI7p
 UsrRpFusnDt45BfU3/L8/32Wrq36mo2DGEE13fXnnIsq2n8GUAesD3ixA
 GNI8U7SoP2DdLD7eZnDo6SsSI0bg7AXAoDO+NgX/So8PmD08s4riaJj7s w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="393887942"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; d="scan'208";a="393887942"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 15:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="737919636"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; d="scan'208";a="737919636"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orsmga003.jf.intel.com with ESMTP; 30 Jan 2024 15:49:23 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] ui/gtk: reset visible flag when window is minimized
Date: Tue, 30 Jan 2024 15:48:40 -0800
Message-Id: <20240130234840.53122-4-dongwon.kim@intel.com>
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

Adding a callback for window-state-event that resets the flag, 'visible'
when associated window is minimized or restored. When minimizing, it cancels
any of queued draw events associated with the VC.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 651ed3492f..5bbcb7de62 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1381,6 +1381,37 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     return TRUE;
 }
 
+static gboolean gd_window_state_event(GtkWidget *widget, GdkEvent *event,
+                                      void *opaque)
+{
+    VirtualConsole *vc = opaque;
+
+    if (!vc) {
+        return TRUE;
+    }
+
+    if (event->window_state.new_window_state & GDK_WINDOW_STATE_ICONIFIED) {
+        vc->gfx.visible = false;
+        gd_set_ui_size(vc, 0, 0);
+        if (vc->gfx.guest_fb.dmabuf &&
+            vc->gfx.guest_fb.dmabuf->draw_submitted) {
+            vc->gfx.guest_fb.dmabuf->draw_submitted = false;
+            graphic_hw_gl_block(vc->gfx.dcl.con, false);
+        }
+    /* Showing the ui only if window exists except for the current vc as GTK
+     * window for 's' is being used to display the GUI */
+    } else if (vc->window || vc == gd_vc_find_current(vc->s)) {
+        GdkWindow *window;
+        window = gtk_widget_get_window(vc->gfx.drawing_area);
+        gd_set_ui_size(vc, gdk_window_get_width(window),
+                       gdk_window_get_height(window));
+
+        vc->gfx.visible = true;
+    }
+
+    return TRUE;
+}
+
 static gboolean gd_win_grab(void *opaque)
 {
     VirtualConsole *vc = opaque;
@@ -1422,6 +1453,9 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 
         g_signal_connect(vc->window, "delete-event",
                          G_CALLBACK(gd_tab_window_close), vc);
+        g_signal_connect(vc->window, "window-state-event",
+                         G_CALLBACK(gd_window_state_event), vc);
+
         gtk_widget_show_all(vc->window);
 
         if (qemu_console_is_graphic(vc->gfx.dcl.con)) {
@@ -2470,6 +2504,11 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 
     vc = gd_vc_find_current(s);
+
+    g_signal_connect(s->window, "window-state-event",
+                     G_CALLBACK(gd_window_state_event),
+                     vc);
+
     gtk_widget_set_sensitive(s->view_menu, vc != NULL);
 #ifdef CONFIG_VTE
     gtk_widget_set_sensitive(s->copy_item,
-- 
2.34.1


