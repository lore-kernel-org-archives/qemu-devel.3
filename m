Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95192C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXas-00043M-QL; Wed, 07 May 2025 01:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXaa-0003eS-KT
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXaY-0004K3-54
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746596701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1H8nFHFr32C43uQsmrhy5WnkeOwM2misq6XXKdRH8mo=;
 b=U316M/6BZ1W/yFfLNp6MzL6ujZ5ot5SWAtBPsEX2VDrcqUFiE1MBMZB3U/7t1tllWcyWdi
 ZfgqOvFl2TBMWro2bDJ+VbDnTz975dXNIWQW+0/SZsU/p4gdI4k3H6YCccOqeGf1TUY4Je
 4sRSeBoYwDLYqmukKeYdbChx6GIu1hA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-NNHUp75SNwC5wHgsG1O92Q-1; Wed,
 07 May 2025 01:44:59 -0400
X-MC-Unique: NNHUp75SNwC5wHgsG1O92Q-1
X-Mimecast-MFC-AGG-ID: NNHUp75SNwC5wHgsG1O92Q_1746596698
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB7A618001D1; Wed,  7 May 2025 05:44:58 +0000 (UTC)
Received: from localhost (unknown [10.45.242.19])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 796031953B82; Wed,  7 May 2025 05:44:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PULL 6/6] ui/spice: support multi plane dmabuf scanout
Date: Wed,  7 May 2025 09:44:14 +0400
Message-ID: <20250507054414.2284129-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250507054414.2284129-1-marcandre.lureau@redhat.com>
References: <20250507054414.2284129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Qiang Yu <yuq825@gmail.com>

We need spice version >= 0.15.3 which has spice_qxl_gl_scanout2
API for multi plane scanout support.

v2:
  * use new dmabuf API and check length
  * check spice_qxl_gl_scanout2 present instead of
    bump spice version dependency

Signed-off-by: Qiang Yu <yuq825@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
[ Fix style ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250327025848.46962-7-yuq825@gmail.com>
---
 meson.build        |  5 +++
 ui/spice-display.c | 98 ++++++++++++++++++++++++++++++----------------
 2 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/meson.build b/meson.build
index 8ae70dbe45..9831f0bd71 100644
--- a/meson.build
+++ b/meson.build
@@ -3168,6 +3168,11 @@ if host_os == 'windows'
     }''', name: '_lock_file and _unlock_file'))
 endif
 
+if spice.found()
+  config_host_data.set('HAVE_SPICE_QXL_GL_SCANOUT2',
+    cc.has_function('spice_qxl_gl_scanout2', dependencies: spice))
+endif
+
 if host_os == 'windows'
   mingw_has_setjmp_longjmp = cc.links('''
     #include <setjmp.h>
diff --git a/ui/spice-display.c b/ui/spice-display.c
index a9fee87a72..9c39d2c5c8 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -28,6 +28,8 @@
 
 #include "ui/spice-display.h"
 
+#include "standard-headers/drm/drm_fourcc.h"
+
 bool spice_opengl;
 
 int qemu_spice_rect_is_empty(const QXLRect* r)
@@ -872,6 +874,26 @@ static void spice_gl_update(DisplayChangeListener *dcl,
     ssd->gl_updates++;
 }
 
+static void spice_server_gl_scanout(QXLInstance *qxl,
+                                    const int *fd,
+                                    uint32_t width, uint32_t height,
+                                    const uint32_t *offset,
+                                    const uint32_t *stride,
+                                    uint32_t num_planes, uint32_t format,
+                                    uint64_t modifier, int y_0_top)
+{
+#ifdef HAVE_SPICE_QXL_GL_SCANOUT2
+    spice_qxl_gl_scanout2(qxl, fd, width, height, offset, stride,
+                          num_planes, format, modifier, y_0_top);
+#else
+    if (num_planes <= 1) {
+        spice_qxl_gl_scanout(qxl, fd[0], width, height, stride[0], format, y_0_top);
+    } else {
+        error_report("SPICE server does not support multi plane GL scanout");
+    }
+#endif
+}
+
 static void spice_gl_switch(DisplayChangeListener *dcl,
                             struct DisplaySurface *new_surface)
 {
@@ -884,16 +906,16 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
     if (ssd->ds) {
         uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES];
         int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
+        uint64_t modifier;
 
         surface_gl_create_texture(ssd->gls, ssd->ds);
-        if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EGLint *)offset,
-                                       (EGLint *)stride, &fourcc, &num_planes, NULL)) {
-            surface_gl_destroy_texture(ssd->gls, ssd->ds);
-            return;
-        }
-
-        if (num_planes > 1) {
-            fprintf(stderr, "%s: does not support multi-plane texture\n", __func__);
+        if (!egl_dmabuf_export_texture(ssd->ds->texture,
+                                       fd,
+                                       (EGLint *)offset,
+                                       (EGLint *)stride,
+                                       &fourcc,
+                                       &num_planes,
+                                       &modifier)) {
             surface_gl_destroy_texture(ssd->gls, ssd->ds);
             return;
         }
@@ -904,10 +926,11 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
                                     fourcc);
 
         /* note: spice server will close the fd */
-        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
-                             surface_width(ssd->ds),
-                             surface_height(ssd->ds),
-                             stride[0], fourcc, false);
+        spice_server_gl_scanout(&ssd->qxl, fd,
+                                surface_width(ssd->ds),
+                                surface_height(ssd->ds),
+                                offset, stride, num_planes,
+                                fourcc, modifier, false);
         ssd->have_surface = true;
         ssd->have_scanout = false;
 
@@ -930,7 +953,8 @@ static void qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
 
     trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
-    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
+    spice_server_gl_scanout(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DRM_FORMAT_INVALID,
+                            DRM_FORMAT_MOD_INVALID, false);
     qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
     ssd->have_surface = false;
     ssd->have_scanout = false;
@@ -948,22 +972,21 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc = 0;
     int fd[DMABUF_MAX_PLANES], num_planes;
+    uint64_t modifier;
 
     assert(tex_id);
     if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &fourcc,
-                                   &num_planes, NULL)) {
+                                   &num_planes, &modifier)) {
         fprintf(stderr, "%s: failed to export dmabuf for texture\n", __func__);
         return;
     }
-    if (num_planes > 1) {
-        fprintf(stderr, "%s: does not support multi-plane dmabuf\n", __func__);
-        return;
-    }
+
     trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
 
     /* note: spice server will close the fd */
-    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backing_height,
-                         stride[0], fourcc, y_0_top);
+    spice_server_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
+                            (uint32_t *)offset, (uint32_t *)stride, num_planes,
+                            fourcc, modifier, y_0_top);
     qemu_spice_gl_monitor_config(ssd, x, y, w, h);
     ssd->have_surface = false;
     ssd->have_scanout = true;
@@ -1034,11 +1057,10 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
-    EGLint stride = 0, fourcc = 0;
+    EGLint fourcc = 0;
     bool render_cursor = false;
     bool y_0_top = false; /* FIXME */
     uint64_t cookie;
-    int fd;
     uint32_t width, height, texture;
 
     if (!ssd->have_scanout) {
@@ -1075,6 +1097,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                 ssd->blit_fb.height != height) {
                 int fds[DMABUF_MAX_PLANES], num_planes;
                 uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
+                uint64_t modifier;
 
                 trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
                                                   height);
@@ -1083,29 +1106,36 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                      width, height);
                 if (!egl_dmabuf_export_texture(ssd->blit_fb.texture, fds,
                                                (EGLint *)offsets, (EGLint *)strides,
-                                               &fourcc, &num_planes, NULL)) {
+                                               &fourcc, &num_planes, &modifier)) {
                     fprintf(stderr,
                             "%s: failed to export dmabuf for texture\n", __func__);
                     return;
                 }
-                if (num_planes > 1) {
-                    fprintf(stderr,
-                            "%s: does not support multi-plane dmabuf\n", __func__);
-                    return;
-                }
-                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, height,
-                                     strides[0], fourcc, false);
+
+                spice_server_gl_scanout(&ssd->qxl, fds, width, height, offsets, strides,
+                                        num_planes, fourcc, modifier, false);
             }
         } else {
-            stride = qemu_dmabuf_get_strides(dmabuf, NULL)[0];
+            int fds[DMABUF_MAX_PLANES];
+            int noffsets, nstrides;
+            const uint32_t *offsets = qemu_dmabuf_get_offsets(dmabuf, &noffsets);
+            const uint32_t *strides = qemu_dmabuf_get_strides(dmabuf, &nstrides);
+            uint32_t num_planes = qemu_dmabuf_get_num_planes(dmabuf);
+
+            assert(noffsets >= num_planes);
+            assert(nstrides >= num_planes);
+
             fourcc = qemu_dmabuf_get_fourcc(dmabuf);
             y_0_top = qemu_dmabuf_get_y0_top(dmabuf);
-            qemu_dmabuf_dup_fds(dmabuf, &fd, 1);
+            qemu_dmabuf_dup_fds(dmabuf, fds, DMABUF_MAX_PLANES);
 
             trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, height);
             /* note: spice server will close the fd, so hand over a dup */
-            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
-                                 stride, fourcc, y_0_top);
+            spice_server_gl_scanout(&ssd->qxl, fds, width, height,
+                                    offsets, strides, num_planes,
+                                    fourcc,
+                                    qemu_dmabuf_get_modifier(dmabuf),
+                                    y_0_top);
         }
         qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
         ssd->guest_dmabuf_refresh = false;
-- 
2.49.0


