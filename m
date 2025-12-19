Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E1FD7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfOL-00039l-0M; Fri, 19 Dec 2025 13:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.4tw2t6a8hfceqf0=17c2odhc04zc=yrorg31hrsum3c@em483429.getutm.app>)
 id 1vWfOI-00038v-VM
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:51 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.4tw2t6a8hfceqf0=17c2odhc04zc=yrorg31hrsum3c@em483429.getutm.app>)
 id 1vWfOH-0007wI-6D
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766170474; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=AtcVhMygqosQBhVqiKaBj6C0icHOGS2ShX9ucIHuUTY=; b=3XCrpiMZZlxpELWeFz8e4SmH/d
 9/OaC1TA7xPDOU+DxNawgPQreqEKi1vnX8CFHgFEPl6eJ6rwqJPGMKvKNBVgXj0Rbb1Gi7E8BTbWF
 xf5t8v7ECoaa/8j7MfeinzZaosN4PlQY3D+f0iF1LV5vCOqt9cPBjudBQfSn+VxcW9eVoR1C0Wzbd
 iE+VbIN8iIPeEMDVztxUzJz63iOZ3pAZz5QmakmJI4fs9CDkVmsJhmfQKK6gQA3sYd2IZy0HkVB5k
 XCpPYNrLtgh14PgJN4vlJ5Vd1CNrFMBW6wtNyZsAicSX8ghEA/b8FYo/ewQcbxSw/b9urj261aKu3
 LMZWJKXA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766169574; h=from : subject :
 to : message-id : date;
 bh=AtcVhMygqosQBhVqiKaBj6C0icHOGS2ShX9ucIHuUTY=;
 b=degVDSdLr587CfMhabXiiD9G2wVnrEr3vEAQxoe5AW/sAvmsAecpq8T3qj3At4Xl9GuiQ
 sP4MKaQuBAxLDmxewjzqx64irPe0UOfyHWK2Kna3IK006CEbVINTlG1LgHN1o7RIZ+TIpjd
 ReC60KoH3iTSs+andwHnyVS1oJEZtBJDKsUkxRMRpis2ptOc2SBkoVFQ9AfBPXRGDcQpGWI
 VEoaPiZTYfKKuD+A0i6guV1MnGDO1aBotlt1Pe2/SvaprmYUwUwz9pY3DMJnvfRGaj56lLy
 P2BOspgXDhR1ZfXH508yGTz5SRit0nkXR97pKx2RCVZYCstm/MuayG4q+eow==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vWfO1-pH9Rte-Dg; Fri, 19 Dec 2025 18:39:33 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWfO0-AIkwcC8uKAK-ChF1; Fri, 19 Dec 2025 18:39:32 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH RFC v2 5/6] console: add cleanup callback for ScanoutTexture
Date: Fri, 19 Dec 2025 10:38:51 -0800
Message-ID: <20251219183853.4426-6-j@getutm.app>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251219183853.4426-1-j@getutm.app>
References: <20251219183853.4426-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 32P4t1eSs2Fa.hBT9pyMxOHO0.8JrZWgaj1Cs
Feedback-ID: 483429m:483429abrvJvs:483429smvXXI5AHR
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.4tw2t6a8hfceqf0=17c2odhc04zc=yrorg31hrsum3c@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
index a45b524c575..5caecd4d7b9 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -149,6 +149,11 @@ typedef struct ScanoutTextureNative {
     .type = SCANOUT_TEXTURE_NATIVE_TYPE_NONE \
 })
 
+/**
+ * Cleanup callback function when ScanoutTexture is about to be destroyed
+ */
+typedef void (*ScanoutTextureCleanup)(ScanoutTextureNative *native);
+
 typedef struct ScanoutTexture {
     uint32_t backing_id;
     bool backing_y_0_top;
@@ -159,6 +164,7 @@ typedef struct ScanoutTexture {
     uint32_t width;
     uint32_t height;
     ScanoutTextureNative native;
+    ScanoutTextureCleanup cb_cleanup;
 } ScanoutTexture;
 
 typedef struct QemuUIInfo {
@@ -347,7 +353,8 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_id, bool backing_y_0_top,
                             uint32_t backing_width, uint32_t backing_height,
                             uint32_t x, uint32_t y, uint32_t w, uint32_t h,
-                            ScanoutTextureNative native);
+                            ScanoutTextureNative native,
+                            ScanoutTextureCleanup cb_cleanup);
 void dpy_gl_scanout_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b3e83046643..c01587bd25c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -478,7 +478,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
             info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
             info.width, info.height,
             ss.r.x, ss.r.y, ss.r.width, ss.r.height,
-            native);
+            native, NULL);
     } else {
         dpy_gfx_replace_surface(
             g->parent_obj.scanout[ss.scanout_id].con, NULL);
diff --git a/ui/console.c b/ui/console.c
index 9378afd53db..df70ccc5535 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -808,6 +808,41 @@ void dpy_gfx_update_full(QemuConsole *con)
     dpy_gfx_update(con, 0, 0, w, h);
 }
 
+typedef struct ScanoutChange {
+    ScanoutTextureNative native;
+    ScanoutTextureCleanup cb_cleanup;
+} ScanoutChange;
+
+#define SCANOUT_CHANGE_NONE ((ScanoutChange){ NO_NATIVE_TEXTURE })
+
+static ScanoutChange dpy_change_scanout_kind(DisplayScanout *scanout,
+                                                     enum display_scanout kind)
+{
+    ScanoutChange change = SCANOUT_CHANGE_NONE;
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
+static void dpy_complete_scanout_change(ScanoutChange *change)
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
+    ScanoutChange change = SCANOUT_CHANGE_NONE;
 
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
+    ScanoutChange change = SCANOUT_CHANGE_NONE;
 
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
+                            ScanoutTextureCleanup cb_cleanup)
 {
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
+    ScanoutChange change = SCANOUT_CHANGE_NONE;
 
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
+    ScanoutChange change = SCANOUT_CHANGE_NONE;
 
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
2.50.1 (Apple Git-155)


