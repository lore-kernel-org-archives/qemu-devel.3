Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02B0C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 11:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1kJE-0003qq-HB; Mon, 07 Apr 2025 07:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u1kJC-0003qF-AN
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:06:30 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u1kJA-0006dC-FW
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:06:30 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 761EC1C15AA; Mon,  7 Apr 2025 12:59:51 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH 3/3] vnc: h264: send additional frames after the display is
 clean
Date: Mon,  7 Apr 2025 12:59:39 +0200
Message-Id: <20250407105939.1997660-3-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407105939.1997660-1-dietmar@proxmox.com>
References: <20250407105939.1997660-1-dietmar@proxmox.com>
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

So that encoder can improve the picture quality.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc.c | 25 ++++++++++++++++++++++++-
 ui/vnc.h |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 2e60b55e47..4ba0b715fd 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3239,7 +3239,30 @@ static void vnc_refresh(DisplayChangeListener *dcl)
     vnc_unlock_display(vd);
 
     QTAILQ_FOREACH_SAFE(vs, &vd->clients, next, vn) {
-        rects += vnc_update_client(vs, has_dirty);
+        int client_dirty = has_dirty;
+        if (vs->h264) {
+            if (client_dirty) {
+                vs->h264->keep_dirty = VNC_H264_KEEP_DIRTY;
+            } else {
+                if (vs->h264->keep_dirty > 0) {
+                    client_dirty = 1;
+                    vs->h264->keep_dirty--;
+                }
+            }
+        }
+
+        int count = vnc_update_client(vs, client_dirty);
+        rects += count;
+
+        if (vs->h264 && !count && vs->h264->keep_dirty) {
+            VncJob *job = vnc_job_new(vs);
+            int height = pixman_image_get_height(vd->server);
+            int width = pixman_image_get_width(vd->server);
+            vs->job_update = vs->update;
+            vs->update = VNC_STATE_UPDATE_NONE;
+            vnc_job_add_rect(job, 0, 0, width, height);
+            vnc_job_push(job);
+        }
         /* vs might be free()ed here */
     }
 
diff --git a/ui/vnc.h b/ui/vnc.h
index 7e232f7dac..e1b81d6bcc 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -236,10 +236,13 @@ typedef struct VncZywrle {
 } VncZywrle;
 
 #ifdef CONFIG_GSTREAMER
+/* Number of frames we send after the display is clean. */
+#define VNC_H264_KEEP_DIRTY 10
 typedef struct VncH264 {
     GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
     size_t width;
     size_t height;
+    guint keep_dirty;
 } VncH264;
 #endif
 
-- 
2.39.5


