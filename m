Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAB3C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 04:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRO5h-0002rF-Ty; Tue, 17 Jun 2025 00:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5g-0002qF-4y
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:32 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5e-0007jV-2E
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750135111; x=1781671111;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GSS9b1nGxtqsZ74PUq0QmxMmFYUyYN4NIY8CJ8re9Zo=;
 b=AHn67MgV6RWL/mGB6GDqQUZAKBpE+3QKH9D+9qEdmS9U6zalYZkehv07
 UndTS09EeYJj8KmSIE0NjYfe/82y+WYN7FoGFjkQ8CgAomCD8gQI8vp55
 Y5L79O0tX2S6pEphMJAPUI6ALcOABlbLmLKi4DvZBYkEJaQayP2lPWXWr
 Y/47GeZEcyK8VmX4lEwEskz2IpK5Cmdhmw0SWyxWq2AazZRUHaUyTuGV9
 qy6btoYAVbAeuZefTc8/TUAGY1dHfAt/Nh64j2ioUgKO5FvwoYsPARQck
 sAQp7dfAbWVnDqYBPptLiQvchXJeuQdLr0TgTrgbngN7Vei9HM3QNLTOI Q==;
X-CSE-ConnectionGUID: FpUtpV4QTIeWK2cM8FpTmg==
X-CSE-MsgGUID: 3OGfpT+MS6acJ6rOvL7U9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52432305"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52432305"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:25 -0700
X-CSE-ConnectionGUID: ER4iffJ0QcG3dPyZI8UoCA==
X-CSE-MsgGUID: G6lKIXGtRpulP2UB3kAqMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="149551048"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:23 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: [PATCH v6 4/7] ui/spice: Add an option to submit gl_draw requests at
 fixed rate
Date: Mon, 16 Jun 2025 21:32:28 -0700
Message-ID: <20250617043546.1022779-5-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
References: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
it makes sense to limit the maximum (streaming) rate (refresh rate)
to a fixed value using the GUI refresh timer. Otherwise, the updates
or gl_draw requests would be sent as soon as the Guest submits a new
frame which is not optimal as it would lead to increased network
traffic and wastage of GPU cycles if the frames get dropped.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/spice-display.h |  1 +
 qemu-options.hx            |  5 +++
 ui/spice-core.c            | 12 ++++++++
 ui/spice-display.c         | 62 ++++++++++++++++++++++++++++++++------
 4 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 6c55f38c8b..9bdde78266 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -152,6 +152,7 @@ struct SimpleSpiceCursor {
 
 extern bool spice_opengl;
 extern bool spice_remote_client;
+extern int spice_max_refresh_rate;
 
 int qemu_spice_rect_is_empty(const QXLRect* r);
 void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
diff --git a/qemu-options.hx b/qemu-options.hx
index 124c87311c..e06fa67b89 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2282,6 +2282,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
     "       [,playback-compression=[on|off]][,seamless-migration=[on|off]]\n"
     "       [,video-codec=<codec>\n"
+    "       [,max-refresh-rate=rate\n"
     "       [,gl=[on|off]][,rendernode=<file>]\n"
     "                enable spice\n"
     "                at least one of {port, tls-port} is mandatory\n",
@@ -2377,6 +2378,10 @@ SRST
         would be used as default. And, for the case where gl=off, the
         default codec to be used is determined by the Spice server.
 
+    ``max-refresh-rate=rate``
+        Provide the maximum refresh rate (or FPS) at which the encoding
+        requests should be sent to the Spice server. Default would be 30.
+
     ``gl=[on|off]``
         Enable/disable OpenGL context. Default is off.
 
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 5e585ed958..5477950a5e 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -56,6 +56,8 @@ struct SpiceTimer {
     QEMUTimer *timer;
 };
 
+#define DEFAULT_MAX_REFRESH_RATE 30
+
 static SpiceTimer *timer_add(SpiceTimerFunc func, void *opaque)
 {
     SpiceTimer *timer;
@@ -491,6 +493,9 @@ static QemuOptsList qemu_spice_opts = {
         },{
             .name = "video-codec",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "max-refresh-rate",
+            .type = QEMU_OPT_NUMBER,
         },{
             .name = "agent-mouse",
             .type = QEMU_OPT_BOOL,
@@ -806,6 +811,13 @@ static void qemu_spice_init(void)
         spice_server_set_streaming_video(spice_server, SPICE_STREAM_VIDEO_OFF);
     }
 
+    spice_max_refresh_rate = qemu_opt_get_number(opts, "max-refresh-rate",
+                                                 DEFAULT_MAX_REFRESH_RATE);
+    if (spice_max_refresh_rate <= 0) {
+        error_report("max refresh rate/fps is invalid");
+        exit(1);
+    }
+
     spice_server_set_agent_mouse
         (spice_server, qemu_opt_get_bool(opts, "agent-mouse", 1));
     spice_server_set_playback_compression
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 0fb72f6d6f..e409b6bdb2 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -32,6 +32,7 @@
 
 bool spice_opengl;
 bool spice_remote_client;
+int spice_max_refresh_rate;
 
 int qemu_spice_rect_is_empty(const QXLRect* r)
 {
@@ -844,12 +845,32 @@ static void qemu_spice_gl_block_timer(void *opaque)
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
+        if (spice_remote_client && ssd->gl_updates && ssd->have_scanout) {
+            glFlush();
+            spice_gl_draw(ssd, 0, 0,
+                          surface_width(ssd->ds), surface_height(ssd->ds));
+            ssd->gl_updates = 0;
+            /* E.g, to achieve 60 FPS, update_interval needs to be ~16.66 ms */
+            dcl->update_interval = 1000 / spice_max_refresh_rate;
+        }
         return;
     }
 
@@ -857,11 +878,8 @@ static void spice_gl_refresh(DisplayChangeListener *dcl)
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
@@ -954,6 +972,20 @@ static void qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
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
+        if (spice_remote_client && ssd->gl_updates && ssd->have_scanout) {
+            ssd->gl_updates = 0;
+            qemu_spice_gl_block(ssd, false);
+        }
+    }
     spice_server_gl_scanout(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DRM_FORMAT_INVALID,
                             DRM_FORMAT_MOD_INVALID, false);
     qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
@@ -1061,7 +1093,6 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     EGLint fourcc = 0;
     bool render_cursor = false;
     bool y_0_top = false; /* FIXME */
-    uint64_t cookie;
     uint32_t width, height, texture;
 
     if (!ssd->have_scanout) {
@@ -1159,8 +1190,19 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
     qemu_spice_gl_block(ssd, true);
     glFlush();
-    cookie = (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0);
-    spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
+
+    /*
+     * In the case of remote clients, the submission of gl_draw request is
+     * deferred here, so that it can be submitted later (to spice server)
+     * from spice_gl_refresh() timer callback. This is done to ensure that
+     * Guest updates are submitted at a steady rate (e.g. 60 FPS) instead
+     * of submitting them arbitrarily.
+     */
+    if (spice_remote_client) {
+        ssd->gl_updates++;
+    } else {
+        spice_gl_draw(ssd, x, y, w, h);
+    }
 }
 
 static const DisplayChangeListenerOps display_listener_gl_ops = {
-- 
2.49.0


