Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320A6C3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDvg-0000PP-29; Tue, 25 Mar 2025 19:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txDvd-0000Oi-Lr
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:43:29 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txDvb-0005Gz-Uk
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742946208; x=1774482208;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gilOvD+ZFdvZm09hlDiPqRgDGyPEDoaNjCx+Ynr01Hc=;
 b=RnSv/r9x/dldEkY8JLlh9wz+kAl2Pg/3wTp2iGkl6LXBhsv7ydb5yzQ6
 KnVzPtYa/P+C+4lUnDF5kdw5czjhEQR5QdmnfHHVStcEHLLH1VHM9Ro10
 xHnwlBTUo1Pax4WLgVkZpOExeFZyVnrQyVHZggSO7LnHBPtGn4BK/wLaU
 g7d5YfC+VtdDEcspedCYHp4h9cyYTjPqIzZWN8740JmyCvcMmOAoUbHQz
 mwPJpsfjJm/cy3lPAH18E+d5IHzkMVB3qLI+6QHPmtVHLEQdPWgkVBcD+
 r9thoyx0jkZYmu47rx2xWv401KUc9ltRyCA9gN+0BfrgcsPJ7aZSZ0H6C Q==;
X-CSE-ConnectionGUID: vCf23y1fRrGcgpTTmSqHXQ==
X-CSE-MsgGUID: QlzMSoJBRTSlMeBLEhn8Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55582841"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="55582841"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 16:43:19 -0700
X-CSE-ConnectionGUID: K1PSUXKTQhaVQ+tBlD1oFQ==
X-CSE-MsgGUID: KDlAAC1xTvSP73PHYVXweA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="124332502"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 16:43:18 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v2 3/6] ui/spice: Submit the gl_draw requests at 60 FPS for
 remote clients
Date: Tue, 25 Mar 2025 16:39:33 -0700
Message-ID: <20250325234115.1332883-4-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
References: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the specific case where the display layer (virtio-gpu) is using
dmabuf, and if remote clients are enabled (-spice gl=on,port=xxxx),
it makes sense to limit the maximum (streaming) rate to 60 FPS
using the GUI timer. This matches the behavior of GTK UI where the
display updates are submitted at 60 FPS (assuming the underlying
mode is WxY@60).

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 ui/spice-display.c | 53 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index bf4caf0d1b..2c4daa0707 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -842,12 +842,32 @@ static void qemu_spice_gl_block_timer(void *opaque)
     warn_report("spice: no gl-draw-done within one second");
 }
 
+static void spice_gl_draw(SimpleSpiceDisplay *ssd,
+                           uint32_t x, uint32_t y, uint32_t w, uint32_t h)
+{
+    uint64_t cookie;
+
+    cookie = (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0);
+    spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
+}
+
 static void spice_gl_refresh(DisplayChangeListener *dcl)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
-    uint64_t cookie;
 
-    if (!ssd->ds || qemu_console_is_gl_blocked(ssd->dcl.con)) {
+    if (!ssd->ds) {
+        return;
+    }
+
+    if (qemu_console_is_gl_blocked(ssd->dcl.con)) {
+        if (remote_client && ssd->gl_updates && ssd->have_scanout) {
+            glFlush();
+            spice_gl_draw(ssd, 0, 0,
+                          surface_width(ssd->ds), surface_height(ssd->ds));
+            ssd->gl_updates = 0;
+            /* To stream at 60 FPS, the (GUI) timer delay needs to be ~17 ms */
+            dcl->update_interval = 1000 / (2 * GUI_REFRESH_INTERVAL_DEFAULT) + 1;
+        }
         return;
     }
 
@@ -855,11 +875,8 @@ static void spice_gl_refresh(DisplayChangeListener *dcl)
     if (ssd->gl_updates && ssd->have_surface) {
         qemu_spice_gl_block(ssd, true);
         glFlush();
-        cookie = (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0);
-        spice_qxl_gl_draw_async(&ssd->qxl, 0, 0,
-                                surface_width(ssd->ds),
-                                surface_height(ssd->ds),
-                                cookie);
+        spice_gl_draw(ssd, 0, 0,
+                      surface_width(ssd->ds), surface_height(ssd->ds));
         ssd->gl_updates = 0;
     }
 }
@@ -926,6 +943,20 @@ static void qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
 
     trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
+
+    /*
+     * We need to check for the case of "lost" updates, where a gl_draw
+     * was not submitted because the timer did not get a chance to run.
+     * One case where this happens is when the Guest VM is getting
+     * rebooted. If the console is blocked in this situation, we need
+     * to unblock it. Otherwise, newer updates would not take effect.
+     */
+    if (qemu_console_is_gl_blocked(ssd->dcl.con)) {
+        if (remote_client && ssd->gl_updates && ssd->have_scanout) {
+            ssd->gl_updates = 0;
+            qemu_spice_gl_block(ssd, false);
+        }
+    }
     spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
     qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
     ssd->have_surface = false;
@@ -1029,7 +1060,6 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     EGLint stride = 0, fourcc = 0;
     bool render_cursor = false;
     bool y_0_top = false; /* FIXME */
-    uint64_t cookie;
     int fd;
     uint32_t width, height, texture;
 
@@ -1107,8 +1137,11 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
     qemu_spice_gl_block(ssd, true);
     glFlush();
-    cookie = (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0);
-    spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
+    if (remote_client) {
+        ssd->gl_updates++;
+    } else {
+        spice_gl_draw(ssd, x, y, w, h);
+    }
 }
 
 static const DisplayChangeListenerOps display_listener_gl_ops = {
-- 
2.48.1


