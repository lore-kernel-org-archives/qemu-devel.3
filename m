Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33613C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 08:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9JSz-0004qL-KF; Mon, 28 Apr 2025 04:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u9JSt-0004jV-Sd
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:03:49 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u9JSs-00052S-2A
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:03:47 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id DF1221C0ACB; Mon, 28 Apr 2025 10:03:38 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v4 5/8] h264: search for available h264 encoder
Date: Mon, 28 Apr 2025 10:03:33 +0200
Message-Id: <20250428080336.2574852-6-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428080336.2574852-1-dietmar@proxmox.com>
References: <20250428080336.2574852-1-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The search list is currently hardcoded to: ["x264enc", "openh264enc"]

x264enc: is probably the best available software encoder
openh264enc: lower quality, but available on more systems.

We restrict encoders to a known list because each encoder requires
fine tuning to get reasonable/usable results.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc-enc-h264.c | 82 ++++++++++++++++++++++++++++++++++++++---------
 ui/vnc.h          |  1 +
 2 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
index 26e8c19270..191e3aeb39 100644
--- a/ui/vnc-enc-h264.c
+++ b/ui/vnc-enc-h264.c
@@ -9,6 +9,61 @@
 
 #include <gst/gst.h>
 
+const char *encoder_list[] = { "x264enc", "openh264enc" };
+
+static const char *get_available_encoder(void)
+{
+    for (int i = 0; i < G_N_ELEMENTS(encoder_list); i++) {
+        GstElement *element = gst_element_factory_make(
+            encoder_list[i], "video-encoder");
+        if (element != NULL) {
+            gst_object_unref(element);
+            return encoder_list[i];
+        }
+    }
+    return NULL;
+}
+
+static GstElement *create_encoder(const char *encoder_name)
+{
+    GstElement *encoder = gst_element_factory_make(
+        encoder_name, "video-encoder");
+    if (!encoder) {
+        VNC_DEBUG("Could not create gst '%s' video encoder\n", encoder_name);
+        return NULL;
+    }
+
+    if (!strcmp(encoder_name, "x264enc")) {
+        g_object_set(
+            encoder,
+            "tune", 4, /* zerolatency */
+            /*
+             * fix for zerolatency with novnc (without,
+             * noVNC displays green stripes)
+             */
+            "threads", 1,
+            "pass", 5, /* Constant Quality */
+            "quantizer", 26,
+            /* avoid access unit delimiters (Nal Unit Type 9) - not required */
+            "aud", false,
+            NULL);
+    } else if (!strcmp(encoder_name, "openh264enc")) {
+        g_object_set(
+            encoder,
+            "usage-type", 1, /* screen content */
+            "complexity", 0, /* low, high speed */
+            "rate-control", 0, /* quality mode */
+            "qp-min", 20,
+            "qp-max", 27,
+            NULL);
+    } else {
+        VNC_DEBUG("Unknown H264 encoder name '%s' - not setting any properties",
+            encoder_name);
+    }
+
+    return encoder;
+}
+
 static void destroy_encoder_context(VncState *vs)
 {
     gst_clear_object(&vs->h264->source);
@@ -46,26 +101,12 @@ static bool create_encoder_context(VncState *vs, int w, int h)
         goto error;
     }
 
-    vs->h264->gst_encoder = gst_element_factory_make("x264enc", "gst-encoder");
+    vs->h264->gst_encoder = create_encoder(vs->h264->encoder_name);
     if (!vs->h264->gst_encoder) {
         VNC_DEBUG("Could not create gst x264 encoder\n");
         goto error;
     }
 
-    g_object_set(
-        vs->h264->gst_encoder,
-        "tune", 4, /* zerolatency */
-        /*
-         * fix for zerolatency with novnc (without, noVNC displays
-         * green stripes)
-         */
-        "threads", 1,
-        "pass", 5, /* Constant Quality */
-        "quantizer", 26,
-        /* avoid access unit delimiters (Nal Unit Type 9) - not required */
-        "aud", false,
-        NULL);
-
     vs->h264->sink = gst_element_factory_make("appsink", "sink");
     if (!vs->h264->sink) {
         VNC_DEBUG("Could not create gst sink\n");
@@ -150,9 +191,20 @@ static bool create_encoder_context(VncState *vs, int w, int h)
 
 bool vnc_h264_encoder_init(VncState *vs)
 {
+    const char *encoder_name;
+
     g_assert(vs->h264 == NULL);
 
+    encoder_name = get_available_encoder();
+    if (encoder_name == NULL) {
+        VNC_DEBUG("No H264 encoder available.\n");
+        return -1;
+    }
+
     vs->h264 = g_new0(VncH264, 1);
+    vs->h264->encoder_name = encoder_name;
+
+    VNC_DEBUG("Allow H264 using encoder '%s`\n", encoder_name);
 
     return true;
 }
diff --git a/ui/vnc.h b/ui/vnc.h
index 29012b75c7..4afc68d6ec 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -239,6 +239,7 @@ typedef struct VncZywrle {
 /* Number of frames we send after the display is clean. */
 #define VNC_H264_KEEP_DIRTY 10
 typedef struct VncH264 {
+    const char *encoder_name;
     GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
     size_t width;
     size_t height;
-- 
2.39.5


