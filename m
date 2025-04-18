Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C39CC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 11:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5jvc-0005ZB-BS; Fri, 18 Apr 2025 07:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u5jvT-0005WN-Sz
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:30:32 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u5jvL-0005oZ-VP
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:30:31 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 3BD761C168C; Fri, 18 Apr 2025 13:29:58 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v3 9/9] h264: register shutdown notifiers,
 stop pipeline in destroy_encoder_context
Date: Fri, 18 Apr 2025 13:29:53 +0200
Message-Id: <20250418112953.1744442-10-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418112953.1744442-1-dietmar@proxmox.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
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

Some encoders can hang indefinetly (i.e. nvh264enc) if
the pipeline is not stopped before it is destroyed
(Observed on Debian bookworm).

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc-enc-h264.c | 50 ++++++++++++++++++++++++++++++++++++++---------
 ui/vnc.h          |  1 +
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
index 840674dbdb..9dbfba3a16 100644
--- a/ui/vnc-enc-h264.c
+++ b/ui/vnc-enc-h264.c
@@ -23,6 +23,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/runstate.h"
+
 #include "vnc.h"
 
 #include <gst/gst.h>
@@ -114,13 +116,33 @@ static GstElement *create_encoder(const char *encoder_name)
     return encoder;
 }
 
-static void destroy_encoder_context(VncState *vs)
+static void destroy_encoder_context(VncH264 *h264)
 {
-    gst_clear_object(&vs->h264->source);
-    gst_clear_object(&vs->h264->convert);
-    gst_clear_object(&vs->h264->gst_encoder);
-    gst_clear_object(&vs->h264->sink);
-    gst_clear_object(&vs->h264->pipeline);
+    GstStateChangeReturn state_change_ret;
+
+    g_assert(h264 != NULL);
+
+    VNC_DEBUG("Destroy h264 context.\n");
+
+    /*
+     * Some encoders can hang indefinetly (i.e. nvh264enc) if
+     * the pipeline is not stopped before it is destroyed
+     * (Observed on Debian bookworm).
+     */
+    if (h264->pipeline != NULL) {
+        state_change_ret = gst_element_set_state(
+            h264->pipeline, GST_STATE_NULL);
+
+        if (state_change_ret == GST_STATE_CHANGE_FAILURE) {
+            VNC_DEBUG("Unable to stop the GST pipeline\n");
+        }
+    }
+
+    gst_clear_object(&h264->source);
+    gst_clear_object(&h264->convert);
+    gst_clear_object(&h264->gst_encoder);
+    gst_clear_object(&h264->sink);
+    gst_clear_object(&h264->pipeline);
 }
 
 static bool create_encoder_context(VncState *vs, int w, int h)
@@ -132,7 +154,7 @@ static bool create_encoder_context(VncState *vs, int w, int h)
 
     if (vs->h264->sink) {
         if (w != vs->h264->width || h != vs->h264->height) {
-            destroy_encoder_context(vs);
+            destroy_encoder_context(vs->h264);
         }
     }
 
@@ -239,10 +261,16 @@ static bool create_encoder_context(VncState *vs, int w, int h)
     return TRUE;
 
  error:
-    destroy_encoder_context(vs);
+    destroy_encoder_context(vs->h264);
     return FALSE;
 }
 
+static void shutdown_h264(Notifier *n, void *opaque)
+{
+    VncH264 *h264 =  container_of(n, VncH264, shutdown_notifier);
+    destroy_encoder_context(h264);
+}
+
 bool vnc_h264_encoder_init(VncState *vs)
 {
     char *encoder_name;
@@ -259,6 +287,8 @@ bool vnc_h264_encoder_init(VncState *vs)
 
     vs->h264 = g_new0(VncH264, 1);
     vs->h264->encoder_name = encoder_name;
+    vs->h264->shutdown_notifier.notify = shutdown_h264;
+    qemu_register_shutdown_notifier(&vs->h264->shutdown_notifier);
 
     VNC_DEBUG("Allow H264 using encoder '%s`\n", encoder_name);
 
@@ -362,7 +392,9 @@ void vnc_h264_clear(VncState *vs)
         return;
     }
 
-    destroy_encoder_context(vs);
+    notifier_remove(&vs->h264->shutdown_notifier);
+
+    destroy_encoder_context(vs->h264);
     g_free(vs->h264->encoder_name);
 
     g_clear_pointer(&vs->h264, g_free);
diff --git a/ui/vnc.h b/ui/vnc.h
index 789b18806b..ea52085b19 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -248,6 +248,7 @@ typedef struct VncH264 {
     size_t width;
     size_t height;
     guint keep_dirty;
+    Notifier shutdown_notifier;
 } VncH264;
 #endif
 
-- 
2.39.5


