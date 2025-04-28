Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17B3C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 08:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9JSy-0004oQ-Jr; Mon, 28 Apr 2025 04:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u9JSu-0004jz-Bc
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:03:49 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u9JSs-00052R-29
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:03:47 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id E09841C0C3C; Mon, 28 Apr 2025 10:03:38 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v4 6/8] h264: new vnc options to configure h264 at server side
Date: Mon, 28 Apr 2025 10:03:34 +0200
Message-Id: <20250428080336.2574852-7-dietmar@proxmox.com>
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

h264: on/off (default is on)

h264-encoders: A colon separated list of allowed gstreamer
encoders. Select the first available encoder from that
list (default is "x264enc:openh264enc").

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc-enc-h264.c | 40 ++++++++++++++++++++++++++++++----------
 ui/vnc.c          | 29 ++++++++++++++++++++++++-----
 ui/vnc.h          |  6 +++++-
 3 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
index 191e3aeb39..09b974a787 100644
--- a/ui/vnc-enc-h264.c
+++ b/ui/vnc-enc-h264.c
@@ -9,19 +9,36 @@
 
 #include <gst/gst.h>
 
-const char *encoder_list[] = { "x264enc", "openh264enc" };
-
-static const char *get_available_encoder(void)
+static char *get_available_encoder(const char *encoder_list)
 {
-    for (int i = 0; i < G_N_ELEMENTS(encoder_list); i++) {
+    int i = 0;
+    char *ret = NULL;
+    char **encoder_array = NULL;
+    const char *encoder_name = NULL;
+
+    g_assert(encoder_list != NULL);
+
+    if (!strcmp(encoder_list, "")) {
+        /* use default list */
+        encoder_list = "x264enc:openh264enc";
+    }
+
+    encoder_array = g_strsplit(encoder_list, ":", -1);
+
+    while ((encoder_name = encoder_array[i])) {
         GstElement *element = gst_element_factory_make(
-            encoder_list[i], "video-encoder");
+            encoder_name, "video-encoder");
         if (element != NULL) {
             gst_object_unref(element);
-            return encoder_list[i];
+            ret = strdup(encoder_name);
+            break;
         }
+        i++;
     }
-    return NULL;
+
+    g_strfreev(encoder_array);
+
+    return ret;
 }
 
 static GstElement *create_encoder(const char *encoder_name)
@@ -191,14 +208,16 @@ static bool create_encoder_context(VncState *vs, int w, int h)
 
 bool vnc_h264_encoder_init(VncState *vs)
 {
-    const char *encoder_name;
+    char *encoder_name;
 
     g_assert(vs->h264 == NULL);
+    g_assert(vs->vd != NULL);
+    g_assert(vs->vd->h264_encoder_list != NULL);
 
-    encoder_name = get_available_encoder();
+    encoder_name = get_available_encoder(vs->vd->h264_encoder_list);
     if (encoder_name == NULL) {
         VNC_DEBUG("No H264 encoder available.\n");
-        return -1;
+        return false;
     }
 
     vs->h264 = g_new0(VncH264, 1);
@@ -302,6 +321,7 @@ void vnc_h264_clear(VncState *vs)
     }
 
     destroy_encoder_context(vs);
+    g_free(vs->h264->encoder_name);
 
     g_clear_pointer(&vs->h264, g_free);
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index 0efdc9ec39..2d1e741705 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2204,11 +2204,11 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             break;
 #ifdef CONFIG_GSTREAMER
         case VNC_ENCODING_H264:
-            if (vnc_h264_encoder_init(vs)) {
-                vnc_set_feature(vs, VNC_FEATURE_H264);
-                vs->vnc_encoding = enc;
-            } else {
-                VNC_DEBUG("vnc_h264_encoder_init failed\n");
+            if (vs->vd->h264_encoder_list != NULL) { /* if h264 is enabled */
+                if (vnc_h264_encoder_init(vs)) {
+                    vnc_set_feature(vs, VNC_FEATURE_H264);
+                    vs->vnc_encoding = enc;
+                }
             }
             break;
 #endif
@@ -3636,6 +3636,12 @@ static QemuOptsList qemu_vnc_opts = {
         },{
             .name = "power-control",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "h264",
+            .type = QEMU_OPT_BOOL,
+        },{
+            .name = "h264-encoders",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -4198,6 +4204,19 @@ void vnc_display_open(const char *id, Error **errp)
     }
 #endif
 
+#ifdef CONFIG_GSTREAMER
+    if (qemu_opt_get_bool(opts, "h264", true)) {
+        const char *h264_encoders = qemu_opt_get(opts, "h264-encoders");
+        if (h264_encoders) {
+            vd->h264_encoder_list = h264_encoders;
+        } else {
+            vd->h264_encoder_list = ""; /* use default encoder list */
+        }
+    } else {
+        vd->h264_encoder_list = NULL; /* disable h264 */
+    }
+#endif
+
     if (vnc_display_setup_auth(&vd->auth, &vd->subauth,
                                vd->tlscreds, password,
                                sasl, false, errp) < 0) {
diff --git a/ui/vnc.h b/ui/vnc.h
index 4afc68d6ec..d69ca710ab 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -188,6 +188,10 @@ struct VncDisplay
     VncDisplaySASL sasl;
 #endif
 
+#ifdef CONFIG_GSTREAMER
+    const char *h264_encoder_list;
+#endif
+
     AudioState *audio_state;
 };
 
@@ -239,7 +243,7 @@ typedef struct VncZywrle {
 /* Number of frames we send after the display is clean. */
 #define VNC_H264_KEEP_DIRTY 10
 typedef struct VncH264 {
-    const char *encoder_name;
+    char *encoder_name;
     GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
     size_t width;
     size_t height;
-- 
2.39.5


