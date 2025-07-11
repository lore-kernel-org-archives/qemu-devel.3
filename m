Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A49FC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua95d-0001HE-2a; Fri, 11 Jul 2025 04:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xR-0004Mn-38; Fri, 11 Jul 2025 04:18:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xP-0003zV-2Q; Fri, 11 Jul 2025 04:18:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D9831356D0;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 63B6823FA45;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Weifeng Liu <weifeng.liu.z@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 05/39] gtk/ui: Introduce helper gd_update_scale
Date: Fri, 11 Jul 2025 11:16:01 +0300
Message-ID: <20250711081745.1785806-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Weifeng Liu <weifeng.liu.z@gmail.com>

The code snippet updating scale_x/scale_y is general and will be used in
next patch. Make it a function.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-4-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit a19665448156f17b52b7f33e7960d57efcfca067)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index aa3d637029..d3944046db 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -224,4 +224,6 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
 /* gtk-clipboard.c */
 void gd_clipboard_init(GtkDisplayState *gd);
 
+void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh);
+
 #endif /* UI_GTK_H */
diff --git a/ui/gtk.c b/ui/gtk.c
index 956d4ab9d1..ea3f403b02 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -801,6 +801,24 @@ void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget)
 #endif
 }
 
+void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh)
+{
+    if (!vc) {
+        return;
+    }
+
+    if (vc->s->full_screen) {
+        vc->gfx.scale_x = (double)ww / fbw;
+        vc->gfx.scale_y = (double)wh / fbh;
+    } else if (vc->s->free_scale) {
+        double sx, sy;
+
+        sx = (double)ww / fbw;
+        sy = (double)wh / fbh;
+
+        vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
+    }
+}
 /**
  * DOC: Coordinate handling.
  *
@@ -908,17 +926,7 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
     ww_widget = gdk_window_get_width(gtk_widget_get_window(widget));
     wh_widget = gdk_window_get_height(gtk_widget_get_window(widget));
 
-    if (s->full_screen) {
-        vc->gfx.scale_x = (double)ww_widget / fbw;
-        vc->gfx.scale_y = (double)wh_widget / fbh;
-    } else if (s->free_scale) {
-        double sx, sy;
-
-        sx = (double)ww_widget / fbw;
-        sy = (double)wh_widget / fbh;
-
-        vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
-    }
+    gd_update_scale(vc, ww_widget, wh_widget, fbw, fbh);
 
     ww_surface = fbw * vc->gfx.scale_x;
     wh_surface = fbh * vc->gfx.scale_y;
-- 
2.47.2


