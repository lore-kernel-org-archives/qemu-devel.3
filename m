Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A444BC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 08:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9JSw-0004lH-22; Mon, 28 Apr 2025 04:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u9JSs-0004hp-Mi
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:03:47 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u9JSp-00051R-C6
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:03:46 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id DD7C61C0A60; Mon, 28 Apr 2025 10:03:38 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v4 4/8] vnc: h264: send additional frames after the display is
 clean
Date: Mon, 28 Apr 2025 10:03:32 +0200
Message-Id: <20250428080336.2574852-5-dietmar@proxmox.com>
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

The vnc implementation only sends frames when it detects changes in
the server's framebuffer. This leads to artifacts when there are no
further changes, as the internal H264 encoder may still contain data.

This patch modifies the code to send a few additional frames in such
situations to flush the H264 encoder data.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc.c | 13 ++++++++++++-
 ui/vnc.h |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index c1f2c3ae15..0efdc9ec39 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3236,6 +3236,7 @@ static void vnc_refresh(DisplayChangeListener *dcl)
     VncDisplay *vd = container_of(dcl, VncDisplay, dcl);
     VncState *vs, *vn;
     int has_dirty, rects = 0;
+    bool keep_dirty = false;
 
     if (QTAILQ_EMPTY(&vd->clients)) {
         update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_MAX);
@@ -3253,11 +3254,21 @@ static void vnc_refresh(DisplayChangeListener *dcl)
     vnc_unlock_display(vd);
 
     QTAILQ_FOREACH_SAFE(vs, &vd->clients, next, vn) {
+#ifdef CONFIG_GSTREAMER
+        if (vs->h264) {
+            if (has_dirty) {
+                vs->h264->keep_dirty = VNC_H264_KEEP_DIRTY;
+            } else if (vs->h264->keep_dirty > 0) {
+                keep_dirty = true;
+                vs->h264->keep_dirty--;
+            }
+        }
+#endif
         rects += vnc_update_client(vs, has_dirty);
         /* vs might be free()ed here */
     }
 
-    if (has_dirty && rects) {
+    if ((has_dirty && rects) || keep_dirty) {
         vd->dcl.update_interval /= 2;
         if (vd->dcl.update_interval < VNC_REFRESH_INTERVAL_BASE) {
             vd->dcl.update_interval = VNC_REFRESH_INTERVAL_BASE;
diff --git a/ui/vnc.h b/ui/vnc.h
index 0fe9a9ab16..29012b75c7 100644
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


