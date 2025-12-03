Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97BAD116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 04:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQeAO-0002IW-Rt; Tue, 02 Dec 2025 23:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.kdc83qoplvz4bg6=ssvilxbcuwhy=l7jdvdlr8nd3t7@em483429.getutm.app>)
 id 1vQeAM-0002Hp-LN
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:34 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.kdc83qoplvz4bg6=ssvilxbcuwhy=l7jdvdlr8nd3t7@em483429.getutm.app>)
 id 1vQeAL-0000X4-07
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1764734901; h=from : subject :
 to : message-id : date;
 bh=XYbku66ggetTXXScTxzERv3tWMvWPJzx0u8sArlejVU=;
 b=frj/DBPeRIkTBpYxPlTg65JYGc4x2RlGcVnNwGRM3wqCewFb87jLPA7/zX21XX//l0m++
 eqYaxGTmoR/vN+gLdbuz+qilHc3fFw801ti4bjC+5W5y30bwjYDL9TwQ+bKI48RAzCQ6v2n
 qV2atDaT1y0sN6AF5RdLb6gQGF1CETyrJ18bcFeOdCiBCy1OZ5LY3nb5Rf9TDHQu5/5pmyt
 UDntg+8d/C1a62gGeZCi9eJ/KdDPIrtPmbowISAF8Bgc2PWXR+2yBcxA8YnK6WdgeA1hk3y
 jRyrRJvVRvdLVJWHLL4a/87QK92zGKG7vSRevUQ/j0OW46bcw6QOS8APIOnQ==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vQeA4-FnQW0hPv7oK-Vio3; Wed, 03 Dec 2025 04:08:16 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH RFC 6/7] console: add cleanup callback for ScanoutTexture
Date: Tue,  2 Dec 2025 20:07:53 -0800
Message-ID: <20251203040754.94487-7-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20251203040754.94487-1-j@getutm.app>
References: <20251203040754.94487-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sV8GMzK9wO
X-smtpcorp-track: isIJ-mkK3n_R.fTP_atPLNlyE.W9qylQLHPyK
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.kdc83qoplvz4bg6=ssvilxbcuwhy=l7jdvdlr8nd3t7@em483429.getutm.app;
 helo=a4i956.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Before we introduce changes that allow for QemuConsole to take ownership
of a texture handle, we need scaffolding that will allow us to callback
into a cleanup function any time the ScanoutTexture becomes invalid, which
is whenever the `scanout.kind` or `scanout.texture` gets updated.

The ordering is important: we need to first update the DisplayScanout,
then we need to notify all the listeners, and once all the listeners have
had the chance to finish using the previous native texture, we are safe to
call the cleanup function. This means we need to hold on to the previous
scanout native handle locally until all listeners are notified.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/ui/console.h          |  9 +++++-
 hw/display/virtio-gpu-virgl.c |  2 +-
 ui/console.c                  | 56 +++++++++++++++++++++++++++++++----
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a45b524c57..df9c083a16 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -149,6 +149,11 @@ typedef struct ScanoutTextureNative {
     .type = SCANOUT_TEXTURE_NATIVE_TYPE_NONE \
 })
 
+/**
+ * Cleanup callback function when ScanoutTexture is about to be destroyed
+ */
+typedef void (*dpy_cleanup_texture)(ScanoutTextureNative *native);
+
 typedef struct ScanoutTexture {
     uint32_t backing_id;
     bool backing_y_0_top;
@@ -159,6 +164,7 @@ typedef struct ScanoutTexture {
     uint32_t width;
     uint32_t height;
     ScanoutTextureNative native;
+    dpy_cleanup_texture cb_cleanup;
 } ScanoutTexture;
 
 typedef struct QemuUIInfo {
@@ -347,7 +353,8 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_id, bool backing_y_0_top,
                             uint32_t backing_width, uint32_t backing_height,
                             uint32_t x, uint32_t y, uint32_t w, uint32_t h,
-                            ScanoutTextureNative native);
+                            ScanoutTextureNative native,
+                            dpy_cleanup_texture cb_cleanup);
 void dpy_gl_scanout_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index e091eb0c76..b7bc095676 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -492,7 +492,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
             info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
             info.width, info.height,
             ss.r.x, ss.r.y, ss.r.width, ss.r.height,
-            native);
+            native, NULL);
     } else {
         dpy_gfx_replace_surface(
             g->parent_obj.scanout[ss.scanout_id].con, NULL);
diff --git a/ui/console.c b/ui/console.c
index 9378afd53d..8271c36586 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -808,6 +808,41 @@ void dpy_gfx_update_full(QemuConsole *con)
     dpy_gfx_update(con, 0, 0, w, h);
 }
 
+struct scanout_change {
+    ScanoutTextureNative native;
+    dpy_cleanup_texture cb_cleanup;
+};
+
+#define SCANOUT_CHANGE_NONE ((struct scanout_change){ NO_NATIVE_TEXTURE })
+
+static struct scanout_change dpy_change_scanout_kind(DisplayScanout *scanout,
+                                                     enum display_scanout kind)
+{
+    struct scanout_change change = SCANOUT_CHANGE_NONE;
+
+    /**
+     * We cannot cleanup until the resource is no longer in use, so we record it
+     * You MUST call dpy_complete_scanout_change after all listeners are updated
+     */
+    if (scanout->kind == SCANOUT_TEXTURE && scanout->texture.cb_cleanup) {
+        change.native = scanout->texture.native;
+        change.cb_cleanup = scanout->texture.cb_cleanup;
+    }
+    scanout->kind = kind;
+
+    return change;
+}
+
+static void dpy_complete_scanout_change(struct scanout_change *change)
+{
+    /**
+     * If we previously have a texture and cleanup is required, we call it now
+     */
+    if (change->native.type != SCANOUT_TEXTURE_NATIVE_TYPE_NONE && change->cb_cleanup) {
+        change->cb_cleanup(&change->native);
+    }
+}
+
 void dpy_gfx_replace_surface(QemuConsole *con,
                              DisplaySurface *surface)
 {
@@ -818,6 +853,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
     DisplayChangeListener *dcl;
     int width;
     int height;
+    struct scanout_change change = SCANOUT_CHANGE_NONE;
 
     if (!surface) {
         if (old_surface) {
@@ -833,7 +869,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
 
     assert(old_surface != new_surface);
 
-    con->scanout.kind = SCANOUT_SURFACE;
+    change = dpy_change_scanout_kind(&con->scanout, SCANOUT_SURFACE);
     con->surface = new_surface;
     dpy_gfx_create_texture(con, new_surface);
     QLIST_FOREACH(dcl, &s->listeners, next) {
@@ -844,6 +880,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
     }
     dpy_gfx_destroy_texture(con, old_surface);
     qemu_free_displaysurface(old_surface);
+    dpy_complete_scanout_change(&change);
 }
 
 bool dpy_gfx_check_format(QemuConsole *con,
@@ -1002,9 +1039,10 @@ void dpy_gl_scanout_disable(QemuConsole *con)
 {
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
+    struct scanout_change change = SCANOUT_CHANGE_NONE;
 
     if (con->scanout.kind != SCANOUT_SURFACE) {
-        con->scanout.kind = SCANOUT_NONE;
+        change = dpy_change_scanout_kind(&con->scanout, SCANOUT_NONE);
     }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
@@ -1014,6 +1052,7 @@ void dpy_gl_scanout_disable(QemuConsole *con)
             dcl->ops->dpy_gl_scanout_disable(dcl);
         }
     }
+    dpy_complete_scanout_change(&change);
 }
 
 void dpy_gl_scanout_texture(QemuConsole *con,
@@ -1023,15 +1062,17 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_height,
                             uint32_t x, uint32_t y,
                             uint32_t width, uint32_t height,
-                            ScanoutTextureNative native)
+                            ScanoutTextureNative native,
+                            dpy_cleanup_texture cb_cleanup)
 {
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
+    struct scanout_change change = SCANOUT_CHANGE_NONE;
 
-    con->scanout.kind = SCANOUT_TEXTURE;
+    change = dpy_change_scanout_kind(&con->scanout, SCANOUT_TEXTURE);
     con->scanout.texture = (ScanoutTexture) {
         backing_id, backing_y_0_top, backing_width, backing_height,
-        x, y, width, height, native,
+        x, y, width, height, native, cb_cleanup
     };
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
@@ -1045,6 +1086,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                                              native);
         }
     }
+    dpy_complete_scanout_change(&change);
 }
 
 void dpy_gl_scanout_dmabuf(QemuConsole *con,
@@ -1052,8 +1094,9 @@ void dpy_gl_scanout_dmabuf(QemuConsole *con,
 {
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
+    struct scanout_change change = SCANOUT_CHANGE_NONE;
 
-    con->scanout.kind = SCANOUT_DMABUF;
+    change = dpy_change_scanout_kind(&con->scanout, SCANOUT_DMABUF);
     con->scanout.dmabuf = dmabuf;
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
@@ -1063,6 +1106,7 @@ void dpy_gl_scanout_dmabuf(QemuConsole *con,
             dcl->ops->dpy_gl_scanout_dmabuf(dcl, dmabuf);
         }
     }
+    dpy_complete_scanout_change(&change);
 }
 
 void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
-- 
2.41.0


