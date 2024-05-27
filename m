Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9412BC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVhq-0002pe-Ov; Mon, 27 May 2024 04:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVee-0004hz-P4; Mon, 27 May 2024 04:24:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVec-00016e-Uv; Mon, 27 May 2024 04:24:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D791A6A57D;
 Mon, 27 May 2024 11:22:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0EBBFD851A;
 Mon, 27 May 2024 11:21:41 +0300 (MSK)
Received: (nullmailer pid 66449 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, hikalium <hikalium@hikalium.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 32/44] ui/gtk: Fix mouse/motion event scaling issue
 with GTK display backend
Date: Mon, 27 May 2024 11:21:23 +0300
Message-Id: <20240527082138.66217-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: hikalium <hikalium@hikalium.com>

Remove gtk_widget_get_scale_factor() usage from the calculation of
the motion events in the GTK backend to make it work correctly on
environments that have `gtk_widget_get_scale_factor() != 1`.

This scale factor usage had been introduced in the commit f14aab420c and
at that time the window size was used for calculating the things and it
was working correctly. However, in the commit 2f31663ed4 the logic
switched to use the widget size instead of window size and because of
the change the usage of scale factor becomes invalid (since widgets use
`vc->gfx.scale_{x, y}` for scaling).

Tested on Crostini on ChromeOS (15823.51.0) with an external display.

Fixes: 2f31663ed4 ("ui/gtk: use widget size for cursor motion event")
Fixes: f14aab420c ("ui: fix incorrect pointer position on highdpi with
gtk")

Signed-off-by: hikalium <hikalium@hikalium.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240512111435.30121-3-hikalium@hikalium.com>
(cherry picked from commit 37e91415018db3656b46cdea8f9e4d47b3ff130d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..c4a9662085 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -887,7 +887,7 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
     int x, y;
     int mx, my;
     int fbh, fbw;
-    int ww, wh, ws;
+    int ww, wh;
 
     if (!vc->gfx.ds) {
         return TRUE;
@@ -895,11 +895,15 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
 
     fbw = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
     fbh = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
-
     ww = gtk_widget_get_allocated_width(widget);
     wh = gtk_widget_get_allocated_height(widget);
-    ws = gtk_widget_get_scale_factor(widget);
 
+    /*
+     * `widget` may not have the same size with the frame buffer.
+     * In such cases, some paddings are needed around the `vc`.
+     * To achieve that, `vc` will be displayed at (mx, my)
+     * so that it is displayed at the center of the widget.
+     */
     mx = my = 0;
     if (ww > fbw) {
         mx = (ww - fbw) / 2;
@@ -908,8 +912,12 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
         my = (wh - fbh) / 2;
     }
 
-    x = (motion->x - mx) / vc->gfx.scale_x * ws;
-    y = (motion->y - my) / vc->gfx.scale_y * ws;
+    /*
+     * `motion` is reported in `widget` coordinates
+     * so translating it to the coordinates in `vc`.
+     */
+    x = (motion->x - mx) / vc->gfx.scale_x;
+    y = (motion->y - my) / vc->gfx.scale_y;
 
     if (qemu_input_is_absolute(vc->gfx.dcl.con)) {
         if (x < 0 || y < 0 ||
-- 
2.39.2


