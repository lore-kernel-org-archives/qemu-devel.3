Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07989C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKVcr-0007ym-20; Thu, 29 May 2025 01:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVcg-0007wv-D5
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:13 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVca-0008GJ-Pz
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748495765; x=1780031765;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cT3Vr4u3LFYtemGbo8vgKnjPHY2jUHGA9ai8u8i8k0s=;
 b=Fx+yoVw2byopd1/pHyi76PX2T1bmiQ/As0NimAHIY25ZYWF2TWbtYqua
 +aIwPZW8yPlv/gsrl8bVpBn9RBsYfNUojed3pTbDmjnxSohX+2ymB+FgL
 P8PjySWb7Zz379zxc3xR99uKaxIxxq2LE3vGDPzLR1PxWu/R45f1SR4SC
 nHtslPYLUncKqdHCXE5LjIAtvLCleHMEh2gsSbdMyrvhqnxPmgat1rgm8
 h0mMqiIw9d4jLsa2aVCwM1Bk3tpmixhMUslG6L/L91oaZ1EUgwYrLWH5T
 lQ8KI1jZoOsc0+Fh/9GJMeHK9L78sc/nF8l9zmNXwhBbc4GDpOc7+MLTv A==;
X-CSE-ConnectionGUID: gYH0UoCDTGC4WAeyxKFSfA==
X-CSE-MsgGUID: Lj6Lf7jaQUCMnTVM681OlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50241898"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="50241898"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 22:15:26 -0700
X-CSE-ConnectionGUID: Q++Bj9mbQOmYB0eyGLfh1w==
X-CSE-MsgGUID: Q3Ra1WtlS5CMq0idtxhp3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="174455344"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 22:15:26 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: [PATCH v5 4/7] ui/spice: Add an option to submit gl_draw requests at
 fixed rate
Date: Wed, 28 May 2025 22:11:15 -0700
Message-ID: <20250529051352.1409904-5-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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
index fcddb583c9..98af43953d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2282,6 +2282,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
     "       [,playback-compression=[on|off]][,seamless-migration=[on|off]]\n"
     "       [,video-codecs=<encoder>:<codec>\n"
+    "       [,max-refresh-rate=rate\n"
     "       [,gl=[on|off]][,rendernode=<file>]\n"
     "                enable spice\n"
     "                at least one of {port, tls-port} is mandatory\n",
@@ -2374,6 +2375,10 @@ SRST
         Provide the preferred codec the Spice server should use.
         Default would be spice:mjpeg.
 
+    ``max-refresh-rate=rate``
+        Provide the maximum refresh rate (or FPS) at which the encoding
+        requests should be sent to the Spice server. Default would be 30.
+
     ``gl=[on|off]``
         Enable/disable OpenGL context. Default is off.
 
diff --git a/ui/spice-core.c b/ui/spice-core.c
index f92dd55392..6576bfd20d 100644
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
             .name = "video-codecs",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "max-refresh-rate",
+            .type = QEMU_OPT_NUMBER,
         },{
             .name = "agent-mouse",
             .type = QEMU_OPT_BOOL,
@@ -813,6 +818,13 @@ static void qemu_spice_init(void)
         }
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


