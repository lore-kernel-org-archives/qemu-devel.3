Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589D9CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t6O-0000eD-UW; Wed, 15 Oct 2025 00:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t6L-0000cq-HB; Wed, 15 Oct 2025 00:27:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t6F-0002up-Fw; Wed, 15 Oct 2025 00:27:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E636715D9D6;
 Wed, 15 Oct 2025 07:25:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 86A5B29FE7D;
 Wed, 15 Oct 2025 07:25:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Weifeng Liu <weifeng.liu.z@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.6 03/13] ui/gtk: Consider scaling when propagating ui
 info
Date: Wed, 15 Oct 2025 07:25:27 +0300
Message-ID: <20251015042540.68611-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
References: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
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

The ui width and height sent to guest is supposed to be in buffer
coordinate. Hence conversion is required.

If scaling (global window scale and zooming scale) is not respected in
non-free-scale mode, window size could keep changing because of the
existence of the iteration of the following steps:

1. In resize event or configure event, a size larger (or smaller) than
   the currently used one might be calculated due to not considering
   scaling.
2. On reception of the display size change event in guest, the guest
   might decide to do a mode setting and use the larger (or smaller)
   mode.
3. When the new guest scan-out command arrives, QEMU would request the
   window size to change to fit the new buffer size. This will trigger a
   resize event or a configure event, making us go back to step 1.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-8-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit a1b28f71f7ff0fcafbe0672b788e8e57ee4fe8f6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk.c b/ui/gtk.c
index ea3f403b02..2db10c46da 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -772,8 +772,21 @@ static void gd_resize_event(GtkGLArea *area,
                             gint width, gint height, gpointer *opaque)
 {
     VirtualConsole *vc = (void *)opaque;
+    double pw = width, ph = height;
+    double sx = vc->gfx.scale_x, sy = vc->gfx.scale_y;
+    GdkWindow *window = gtk_widget_get_window(GTK_WIDGET(area));
+    const int gs = gdk_window_get_scale_factor(window);
 
-    gd_set_ui_size(vc, width, height);
+    if (!vc->s->free_scale && !vc->s->full_screen) {
+        pw /= sx;
+        ph /= sy;
+    }
+
+    /**
+     * width and height here are in pixel coordinate, so we must divide it
+     * by global window scale (gs)
+     */
+    gd_set_ui_size(vc, pw / gs, ph / gs);
 }
 
 #endif
@@ -1836,8 +1849,16 @@ static gboolean gd_configure(GtkWidget *widget,
                              GdkEventConfigure *cfg, gpointer opaque)
 {
     VirtualConsole *vc = opaque;
+    const double sx = vc->gfx.scale_x, sy = vc->gfx.scale_y;
+    double width = cfg->width, height = cfg->height;
+
+    if (!vc->s->free_scale && !vc->s->full_screen) {
+        width /= sx;
+        height /= sy;
+    }
+
+    gd_set_ui_size(vc, width, height);
 
-    gd_set_ui_size(vc, cfg->width, cfg->height);
     return FALSE;
 }
 
-- 
2.47.3


