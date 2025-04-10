Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A95C369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 11:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2pze-00089I-6m; Thu, 10 Apr 2025 07:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u2pzb-00088G-QQ
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 07:22:47 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u2pzZ-0000F3-MU
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 07:22:47 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 794EA1C15D1; Thu, 10 Apr 2025 13:22:40 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v2 5/6] h264: search for available h264 encoder
Date: Thu, 10 Apr 2025 13:22:37 +0200
Message-Id: <20250410112238.3550155-6-dietmar@proxmox.com>
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

The search list is currently hardcoded to: ["x264enc", "openh264enc"]

x264enc: is probably the best available software encoder
openh264enc: lower quality, but available on more systems.

We restrict encoders to a known list because each encoder requires
fine tuning to get reasonable/usable results.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc-enc-h264.c | 76 +++++++++++++++++++++++++++++++++++++++--------
 ui/vnc.h          |  1 +
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
index 9e01b8a548..3eabfc2cfe 100644
--- a/ui/vnc-enc-h264.c
+++ b/ui/vnc-enc-h264.c
@@ -3,6 +3,60 @@
 
 #include <gst/gst.h>
 
+const char *encoder_list[] = { "x264enc", "openh264enc", NULL };
+
+static const char *get_available_encoder(void)
+{
+    int i = 0;
+    do {
+        const char *encoder_name = encoder_list[i];
+        if (encoder_name == NULL) {
+            break;
+        }
+        GstElement *element = gst_element_factory_make(
+            encoder_name, "video-encoder");
+        if (element != NULL) {
+            gst_object_unref(element);
+            return encoder_name;
+        }
+        i = i + 1;
+    } while (true);
+
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
+        g_object_set(encoder, "tune", 4, NULL); /* zerolatency */
+        /*
+         * fix for zerolatency with novnc (without,
+         * noVNC displays green stripes)
+         */
+        g_object_set(encoder, "threads", 1, NULL);
+        g_object_set(encoder, "pass", 5, NULL); /* Constant Quality */
+        g_object_set(encoder, "quantizer", 26, NULL);
+        /* avoid access unit delimiters (Nal Unit Type 9) - not required */
+        g_object_set(encoder, "aud", false, NULL);
+    } else if (!strcmp(encoder_name, "openh264enc")) {
+        g_object_set(encoder, "usage-type", 1, NULL); /* screen content */
+        g_object_set(encoder, "complexity", 2, NULL); /* high */
+        g_object_set(encoder, "rate-control", 2, NULL); /* off (buffer) */
+    } else {
+        VNC_DEBUG("Unknown H264 encoder name '%s' - no setting any properties",
+            encoder_name);
+    }
+
+    return encoder;
+}
+
 static void destroy_encoder_context(VncState *vs)
 {
     if (!vs->h264) {
@@ -66,23 +120,12 @@ static bool create_encoder_context(VncState *vs, int w, int h)
         return FALSE;
     }
 
-    vs->h264->gst_encoder = gst_element_factory_make("x264enc", "gst-encoder");
+    vs->h264->gst_encoder = create_encoder(vs->h264->encoder_name);
     if (!vs->h264->gst_encoder) {
-        VNC_DEBUG("Could not create gst x264 encoder\n");
         destroy_encoder_context(vs);
         return FALSE;
     }
 
-    g_object_set(vs->h264->gst_encoder, "tune", 4, NULL); /* zerolatency */
-    /* fix for zerolatency with novnc (without, noVNC displays green stripes) */
-    g_object_set(vs->h264->gst_encoder, "threads", 1, NULL);
-
-    g_object_set(vs->h264->gst_encoder, "pass", 5, NULL); /* Constant Quality */
-    g_object_set(vs->h264->gst_encoder, "quantizer", 26, NULL);
-
-    /* avoid access unit delimiters (Nal Unit Type 9) - not required */
-    g_object_set(vs->h264->gst_encoder, "aud", false, NULL);
-
     vs->h264->sink = gst_element_factory_make("appsink", "sink");
     if (!vs->h264->sink) {
         VNC_DEBUG("Could not create gst sink\n");
@@ -173,7 +216,16 @@ int vnc_h264_encoder_init(VncState *vs)
 {
     g_assert(vs->h264 == NULL);
 
+    const char *encoder_name = get_available_encoder();
+    if (encoder_name == NULL) {
+        VNC_DEBUG("No H264 encoder available.\n");
+        return -1;
+    }
+
     vs->h264 = g_malloc0(sizeof(VncH264));
+    vs->h264->encoder_name = encoder_name;
+
+    VNC_DEBUG("Allow H264 using encoder '%s`\n", encoder_name);
 
     return 0;
 }
diff --git a/ui/vnc.h b/ui/vnc.h
index e1b81d6bcc..f39dbe21aa 100644
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


