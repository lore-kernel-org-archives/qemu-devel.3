Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278B7C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua95E-0000XB-2M; Fri, 11 Jul 2025 04:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xN-0004Fq-FS; Fri, 11 Jul 2025 04:18:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xL-0003yA-2O; Fri, 11 Jul 2025 04:18:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4B8CD1356CE;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3FC8723FA43;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Weifeng Liu <weifeng.liu.z@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 03/39] ui/gtk: Document scale and coordinate handling
Date: Fri, 11 Jul 2025 11:15:59 +0300
Message-ID: <20250711081745.1785806-3-mjt@tls.msk.ru>
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

The existence of multiple scaling factors forces us to deal with various
coordinate systems and this would be confusing. It would be beneficial
to define the concepts clearly and use consistent representation for
variables in different coordinates.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-2-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 9498e2f7e1a247557cfa0f830a86c398a23c6809)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk.c b/ui/gtk.c
index 59bda83da6..582841e031 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -800,6 +800,71 @@ void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget)
 #endif
 }
 
+/**
+ * DOC: Coordinate handling.
+ *
+ * We are coping with sizes and positions in various coordinates and the
+ * handling of these coordinates is somewhat confusing. It would benefit us
+ * all if we define these coordinates explicitly and clearly. Besides, it's
+ * also helpful to follow the same naming convention for variables
+ * representing values in different coordinates.
+ *
+ * I. Definitions
+ *
+ * - (guest) buffer coordinate: this is the coordinates that the guest will
+ *   see. The x/y offsets and width/height specified in commands sent by
+ *   guest is basically in buffer coordinate.
+ *
+ * - (host) pixel coordinate: this is the coordinate in pixel level on the
+ *   host destop. A window/widget of width 300 in pixel coordinate means it
+ *   occupies 300 pixels horizontally.
+ *
+ * - (host) logical window coordinate: the existence of global scaling
+ *   factor in desktop level makes this kind of coordinate play a role. It
+ *   always holds that (logical window size) * (global scale factor) =
+ *   (pixel size).
+ *
+ * - global scale factor: this is specified in desktop level and is
+ *   typically invariant during the life cycle of the process. Users with
+ *   high-DPI monitors might set this scale, for example, to 2, in order to
+ *   make the UI look larger.
+ *
+ * - zooming scale: this can be freely controlled by the QEMU user to zoom
+ *   in/out the guest content.
+ *
+ * II. Representation
+ *
+ * We'd like to use consistent representation for variables in different
+ * coordinates:
+ * - buffer coordinate: prefix fb
+ * - pixel coordinate: prefix p
+ * - logical window coordinate: prefix w
+ *
+ * For scales:
+ * - global scale factor: prefix gs
+ * - zooming scale: prefix scale/s
+ *
+ * Example: fbw, pw, ww for width in different coordinates
+ *
+ * III. Equation
+ *
+ * - fbw * gs * scale_x = pw
+ * - pw = gs * ww
+ *
+ * Consequently we have
+ *
+ * - fbw * scale_x = ww
+ *
+ * Example: assuming we are running QEMU on a 3840x2160 screen and have set
+ * global scaling factor to 2, if the guest buffer size is 1920x1080 and the
+ * zooming scale is 0.5, then we have:
+ * - fbw = 1920, fbh = 1080
+ * - pw  = 1920, ph  = 1080
+ * - ww  = 960,  wh  = 540
+ * A bonus of this configuration is that we can achieve pixel to pixel
+ * presentation of the guest content.
+ */
+
 static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 {
     VirtualConsole *vc = opaque;
-- 
2.47.2


