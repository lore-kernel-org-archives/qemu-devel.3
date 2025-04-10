Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7619C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 11:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2pzb-00087Z-L4; Thu, 10 Apr 2025 07:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u2pzZ-00087E-5d
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 07:22:45 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u2pzX-0000E6-08
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 07:22:44 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 775001C15D0; Thu, 10 Apr 2025 13:22:40 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v2 4/6] h264: remove wrong libavcodec_ prefix from function
 names
Date: Thu, 10 Apr 2025 13:22:36 +0200
Message-Id: <20250410112238.3550155-5-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410112238.3550155-1-dietmar@proxmox.com>
References: <20250410112238.3550155-1-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc-enc-h264.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
index ca8e206335..9e01b8a548 100644
--- a/ui/vnc-enc-h264.c
+++ b/ui/vnc-enc-h264.c
@@ -3,7 +3,7 @@
 
 #include <gst/gst.h>
 
-static void libavcodec_destroy_encoder_context(VncState *vs)
+static void destroy_encoder_context(VncState *vs)
 {
     if (!vs->h264) {
         return;
@@ -35,13 +35,13 @@ static void libavcodec_destroy_encoder_context(VncState *vs)
     }
 }
 
-static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
+static bool create_encoder_context(VncState *vs, int w, int h)
 {
     g_assert(vs->h264 != NULL);
 
     if (vs->h264->sink) {
         if (w != vs->h264->width || h != vs->h264->height) {
-            libavcodec_destroy_encoder_context(vs);
+            destroy_encoder_context(vs);
         }
     }
 
@@ -55,21 +55,21 @@ static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
     vs->h264->source = gst_element_factory_make("appsrc", "source");
     if (!vs->h264->source) {
         VNC_DEBUG("Could not create gst source\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
     vs->h264->convert = gst_element_factory_make("videoconvert", "convert");
     if (!vs->h264->convert) {
         VNC_DEBUG("Could not create gst convert element\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
     vs->h264->gst_encoder = gst_element_factory_make("x264enc", "gst-encoder");
     if (!vs->h264->gst_encoder) {
         VNC_DEBUG("Could not create gst x264 encoder\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
@@ -86,14 +86,14 @@ static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
     vs->h264->sink = gst_element_factory_make("appsink", "sink");
     if (!vs->h264->sink) {
         VNC_DEBUG("Could not create gst sink\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
     vs->h264->pipeline = gst_pipeline_new("vnc-h264-pipeline");
     if (!vs->h264->pipeline) {
         VNC_DEBUG("Could not create gst pipeline\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
@@ -101,7 +101,7 @@ static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
     if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
         gst_object_unref(vs->h264->source);
         VNC_DEBUG("Could not add source to gst pipeline\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
@@ -109,7 +109,7 @@ static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
     if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->convert)) {
         gst_object_unref(vs->h264->convert);
         VNC_DEBUG("Could not add convert to gst pipeline\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
@@ -117,7 +117,7 @@ static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
     if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->gst_encoder)) {
         gst_object_unref(vs->h264->gst_encoder);
         VNC_DEBUG("Could not add encoder to gst pipeline\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
@@ -125,7 +125,7 @@ static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
     if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->sink)) {
         gst_object_unref(vs->h264->sink);
         VNC_DEBUG("Could not add sink to gst pipeline\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
@@ -139,7 +139,7 @@ static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
 
     if (!source_caps) {
         VNC_DEBUG("Could not create source caps filter\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
@@ -154,7 +154,7 @@ static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
             NULL
         ) != TRUE) {
         VNC_DEBUG("Elements could not be linked.\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
@@ -162,7 +162,7 @@ static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
     int ret = gst_element_set_state(vs->h264->pipeline, GST_STATE_PLAYING);
     if (ret == GST_STATE_CHANGE_FAILURE) {
         VNC_DEBUG("Unable to set the pipeline to the playing state.\n");
-        libavcodec_destroy_encoder_context(vs);
+        destroy_encoder_context(vs);
         return FALSE;
     }
 
@@ -183,7 +183,7 @@ int vnc_h264_send_framebuffer_update(
     int _x,
     int _y,
     int _w,
-    int _h,
+    int _h
 ) {
     g_assert(vs->h264 != NULL);
     g_assert(vs->vd != NULL);
@@ -205,7 +205,7 @@ int vnc_h264_send_framebuffer_update(
         rdb_h264_flags = 2;
     }
 
-    if (!libavcodec_create_encoder_context(vs, width, height)) {
+    if (!create_encoder_context(vs, width, height)) {
         VNC_DEBUG("Create encoder context failed\n");
         return -1;
     }
@@ -262,7 +262,7 @@ void vnc_h264_clear(VncState *vs)
         return;
     }
 
-    libavcodec_destroy_encoder_context(vs);
+    destroy_encoder_context(vs);
 
     g_free(vs->h264);
     vs->h264 = NULL;
-- 
2.39.5


