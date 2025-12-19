Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BEBD78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfOC-00037M-LY; Fri, 19 Dec 2025 13:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.9bqyvyretsiia41=6q6mrty5gei3=zsnumrwr5apezc@em483429.getutm.app>)
 id 1vWfOA-00036i-5e
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:42 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.9bqyvyretsiia41=6q6mrty5gei3=zsnumrwr5apezc@em483429.getutm.app>)
 id 1vWfO7-0007uM-VL
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766170466; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=TlyY6MmQLO1DvinWRuQAu1BLIQdYLUHTxK0us+rd2Dk=; b=RFeznbK5rFPIiX2MAqniYCcUWx
 RDiyBq4fD7ZoYwuPQ9xs2xxdIUVIlnVDtXhX6h3/tzfDCxUhJ1ze8rTFvfiFzgb6PPFY0lQDVtnDS
 Yv6oIVgKGYOCjGkJBJhOw7K/QEfJ8paWIDfTGld/dyqVjWnfUlangyuwwSr970zKdYTy2Uo3lGCIB
 9KvHGRyyk3gxfESddt51GXtHC8CkAKgymAkwWpHFF2JYD1XT/533tY5ayISVjdaqTouw7oNxHTU1l
 Zu/XSepQKfe2z8XBQAsegjryv5Yuy0nqCfcphQe5tlJ/mpaEQxNzXVGakycOYG1I7/EnnVvhBYI9a
 DkkkYs+Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766169565; h=from : subject :
 to : message-id : date;
 bh=TlyY6MmQLO1DvinWRuQAu1BLIQdYLUHTxK0us+rd2Dk=;
 b=O5BAOWYFSkFEPzqr9m02aXMhhOP2BlxgTUZQbDhS/7zcPUpaQlwo/vfNhAq5lws6nyeUo
 l2iC5rsAeOSeMzKLzerRdvnFe8/tKpTJ2BtX2ujW59YpHeuZSxxbxwaNKMvjtqSZUtHVeJq
 ftCi3CFSulyIdd7LW2NeTC9EzY3gBaqoh8i62XqNDUuFPljgPLo9dXuFUP6ZPlAA34n8GGc
 uUIdLybQ1mzBZszlPvkZBJDtBRW+fuACKd7EhwBApBGJkfre0jHCh5lRc91RXPB6lWYaqpx
 QdfaK8OQUXT+x5FqT+20ORRH1MIXyhKOE9NGjqYZWF/uAygskCm3NXDtjMrA==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNs-pH9RPB-MV; Fri, 19 Dec 2025 18:39:24 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNr-AIkwcC8uKAK-EBRV; Fri, 19 Dec 2025 18:39:23 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH RFC v2 2/6] console: rename `d3d_tex2d` to `native`
Date: Fri, 19 Dec 2025 10:38:48 -0800
Message-ID: <20251219183853.4426-3-j@getutm.app>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251219183853.4426-1-j@getutm.app>
References: <20251219183853.4426-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 7nqv7zOdSZ0F.6t4xDg1dCAvm.IUgAMgRXFkU
Feedback-ID: 483429m:483429abrvJvs:483429sU4tCYka9m
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.9bqyvyretsiia41=6q6mrty5gei3=zsnumrwr5apezc@em483429.getutm.app;
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

In order to support native texture scanout beyond D3D, we make this more
generic allowing for multiple native texture handle types.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/ui/console.h          | 22 +++++++++++++++++++---
 include/ui/gtk.h              |  4 ++--
 include/ui/sdl2.h             |  2 +-
 hw/display/virtio-gpu-virgl.c | 10 +++++++---
 ui/console.c                  |  8 ++++----
 ui/dbus-console.c             |  2 +-
 ui/dbus-listener.c            |  8 ++++----
 ui/egl-headless.c             |  4 ++--
 ui/gtk-egl.c                  |  4 ++--
 ui/gtk-gl-area.c              |  4 ++--
 ui/sdl2-gl.c                  |  2 +-
 ui/spice-display.c            |  2 +-
 12 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 98feaa58bdd..25e45295d44 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -131,6 +131,22 @@ struct QemuConsoleClass {
     ObjectClass parent_class;
 };
 
+typedef enum ScanoutTextureNativeType {
+    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
+    SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
+} ScanoutTextureNativeType;
+
+typedef struct ScanoutTextureNative {
+    ScanoutTextureNativeType type;
+    union {
+        void *d3d_tex2d;
+    } u;
+} ScanoutTextureNative;
+
+#define NO_NATIVE_TEXTURE ((ScanoutTextureNative){ \
+    .type = SCANOUT_TEXTURE_NATIVE_TYPE_NONE \
+})
+
 typedef struct ScanoutTexture {
     uint32_t backing_id;
     bool backing_y_0_top;
@@ -140,7 +156,7 @@ typedef struct ScanoutTexture {
     uint32_t y;
     uint32_t width;
     uint32_t height;
-    void *d3d_tex2d;
+    ScanoutTextureNative native;
 } ScanoutTexture;
 
 typedef struct QemuUIInfo {
@@ -245,7 +261,7 @@ typedef struct DisplayChangeListenerOps {
                                    uint32_t backing_height,
                                    uint32_t x, uint32_t y,
                                    uint32_t w, uint32_t h,
-                                   void *d3d_tex2d);
+                                   ScanoutTextureNative native);
     /* optional (default to true if has dpy_gl_scanout_dmabuf) */
     bool (*dpy_has_dmabuf)(DisplayChangeListener *dcl);
     /* optional */
@@ -329,7 +345,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_id, bool backing_y_0_top,
                             uint32_t backing_width, uint32_t backing_height,
                             uint32_t x, uint32_t y, uint32_t w, uint32_t h,
-                            void *d3d_tex2d);
+                            ScanoutTextureNative native);
 void dpy_gl_scanout_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 3e6ce3cb48c..f88e2b281d3 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -178,7 +178,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t backing_height,
                             uint32_t x, uint32_t y,
                             uint32_t w, uint32_t h,
-                            void *d3d_tex2d);
+                            ScanoutTextureNative native);
 void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
                            QemuDmaBuf *dmabuf);
 void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
@@ -215,7 +215,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
                                 uint32_t backing_height,
                                 uint32_t x, uint32_t y,
                                 uint32_t w, uint32_t h,
-                                void *d3d_tex2d);
+                                ScanoutTextureNative native);
 void gd_gl_area_scanout_disable(DisplayChangeListener *dcl);
 void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
                               uint32_t x, uint32_t y, uint32_t w, uint32_t h);
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index dbe6e3d9739..fdefb882294 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -93,7 +93,7 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              uint32_t backing_height,
                              uint32_t x, uint32_t y,
                              uint32_t w, uint32_t h,
-                             void *d3d_tex2d);
+                             ScanoutTextureNative native);
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 20c856c04e3..f24437163fb 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -420,14 +420,18 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
 
     if (ss.resource_id && ss.r.width && ss.r.height) {
         struct virgl_renderer_resource_info info;
-        void *d3d_tex2d = NULL;
+        ScanoutTextureNative native = { .type = SCANOUT_TEXTURE_NATIVE_TYPE_NONE };
 
 #if VIRGL_VERSION_MAJOR >= 1
         struct virgl_renderer_resource_info_ext ext;
         memset(&ext, 0, sizeof(ext));
         ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
         info = ext.base;
-        d3d_tex2d = ext.d3d_tex2d;
+        native = (ScanoutTextureNative){
+            .type = ext.d3d_tex2d ? SCANOUT_TEXTURE_NATIVE_TYPE_D3D :
+                                    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
+            .u.d3d_tex2d = ext.d3d_tex2d,
+        };
 #else
         memset(&info, 0, sizeof(info));
         ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
@@ -447,7 +451,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
             info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
             info.width, info.height,
             ss.r.x, ss.r.y, ss.r.width, ss.r.height,
-            d3d_tex2d);
+            native);
     } else {
         dpy_gfx_replace_surface(
             g->parent_obj.scanout[ss.scanout_id].con, NULL);
diff --git a/ui/console.c b/ui/console.c
index 2d00828c538..9378afd53db 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -295,7 +295,7 @@ static void displaychangelistener_display_console(DisplayChangeListener *dcl,
                                          con->scanout.texture.y,
                                          con->scanout.texture.width,
                                          con->scanout.texture.height,
-                                         con->scanout.texture.d3d_tex2d);
+                                         con->scanout.texture.native);
     }
 }
 
@@ -1023,7 +1023,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_height,
                             uint32_t x, uint32_t y,
                             uint32_t width, uint32_t height,
-                            void *d3d_tex2d)
+                            ScanoutTextureNative native)
 {
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
@@ -1031,7 +1031,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
     con->scanout.kind = SCANOUT_TEXTURE;
     con->scanout.texture = (ScanoutTexture) {
         backing_id, backing_y_0_top, backing_width, backing_height,
-        x, y, width, height, d3d_tex2d,
+        x, y, width, height, native,
     };
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
@@ -1042,7 +1042,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                                              backing_y_0_top,
                                              backing_width, backing_height,
                                              x, y, width, height,
-                                             d3d_tex2d);
+                                             native);
         }
     }
 }
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 85e215ef233..651f0daeafa 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -99,7 +99,7 @@ dbus_gl_scanout_texture(DisplayChangeListener *dcl,
                         uint32_t backing_height,
                         uint32_t x, uint32_t y,
                         uint32_t w, uint32_t h,
-                        void *d3d_tex2d)
+                        ScanoutTextureNative native)
 {
     DBusDisplayConsole *ddc = container_of(dcl, DBusDisplayConsole, dcl);
 
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 52e041edb0f..f401db63c62 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -587,7 +587,7 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
                                  uint32_t backing_height,
                                  uint32_t x, uint32_t y,
                                  uint32_t w, uint32_t h,
-                                 void *d3d_tex2d)
+                                 ScanoutTextureNative native)
 {
     trace_dbus_scanout_texture(tex_id, backing_y_0_top,
                                backing_width, backing_height, x, y, w, h);
@@ -618,8 +618,8 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
     assert(surface_width(ddl->ds) == w);
     assert(surface_height(ddl->ds) == h);
 
-    if (d3d_tex2d) {
-        dbus_scanout_share_d3d_texture(ddl, d3d_tex2d, backing_y_0_top,
+    if (native.type == SCANOUT_TEXTURE_NATIVE_TYPE_D3D) {
+        dbus_scanout_share_d3d_texture(ddl, native.u.d3d_tex2d, backing_y_0_top,
                                        backing_width, backing_height, x, y, w, h);
     } else {
         dbus_scanout_map(ddl);
@@ -868,7 +868,7 @@ static void dbus_gl_gfx_switch(DisplayChangeListener *dcl,
 
         /* TODO: lazy send dmabuf (there are unnecessary sent otherwise) */
         dbus_scanout_texture(&ddl->dcl, ddl->ds->texture, false,
-                             width, height, 0, 0, width, height, NULL);
+                             width, height, 0, 0, width, height, NO_NATIVE_TEXTURE);
     }
 }
 #endif
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 1f6b845500d..ef5cc02dcc3 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -62,7 +62,7 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
                                 uint32_t backing_height,
                                 uint32_t x, uint32_t y,
                                 uint32_t w, uint32_t h,
-                                void *d3d_tex2d)
+                                ScanoutTextureNative native)
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
@@ -97,7 +97,7 @@ static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
     height = qemu_dmabuf_get_height(dmabuf);
 
     egl_scanout_texture(dcl, texture, false, width, height, 0, 0,
-                        width, height, NULL);
+                        width, height, NO_NATIVE_TEXTURE);
 }
 
 static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index ae9239999cd..24330b98b35 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -239,7 +239,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t backing_width, uint32_t backing_height,
                             uint32_t x, uint32_t y,
                             uint32_t w, uint32_t h,
-                            void *d3d_tex2d)
+                            ScanoutTextureNative native)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
@@ -290,7 +290,7 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
     y0_top = qemu_dmabuf_get_y0_top(dmabuf);
 
     gd_egl_scanout_texture(dcl, texture, y0_top, backing_width, backing_height,
-                           x, y, width, height, NULL);
+                           x, y, width, height, NO_NATIVE_TEXTURE);
 
     if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index cd86022d264..bde5db83981 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -306,7 +306,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
                                 uint32_t backing_height,
                                 uint32_t x, uint32_t y,
                                 uint32_t w, uint32_t h,
-                                void *d3d_tex2d)
+                                ScanoutTextureNative native)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
@@ -374,7 +374,7 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_gl_area_scanout_texture(dcl, texture, y0_top,
                                backing_width, backing_height,
-                               x, y, width, height, NULL);
+                               x, y, width, height, NO_NATIVE_TEXTURE);
 
     if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 3be17d1079a..b15db86f245 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -206,7 +206,7 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              uint32_t backing_height,
                              uint32_t x, uint32_t y,
                              uint32_t w, uint32_t h,
-                             void *d3d_tex2d)
+                             ScanoutTextureNative native)
 {
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
 
diff --git a/ui/spice-display.c b/ui/spice-display.c
index db71e866f89..2a2285cb1fd 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1084,7 +1084,7 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
                                           uint32_t backing_height,
                                           uint32_t x, uint32_t y,
                                           uint32_t w, uint32_t h,
-                                          void *d3d_tex2d)
+                                          ScanoutTextureNative native)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc = 0;
-- 
2.50.1 (Apple Git-155)


