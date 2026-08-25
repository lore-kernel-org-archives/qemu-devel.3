Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A387C61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoJP-0007R7-Oc; Tue, 25 Aug 2026 06:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJO-0007QJ-E9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJM-0005p9-Ir
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmwS7U+IclWyeDO7uf8KVf+NlRBoCNQg+dAII7UOZAs=;
 b=FXAQ8zYJdkq+thswlqrZqRDrmZz4bQue8vzPSOiHbjtpLUDoFGkL1i3yx0jAIjKRNda0/m
 4RyaC9xEekViuJJbpj8q3qn+uvlFNue/H7IE0IcZ2Rk8BT8l2Kqs7LCQonwtMQk7tufhK8
 CX6gOMppjrEC5GbGHlg5GCK2DBsN+Qs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-zRl4fgjhOWaLlII6WWpl_w-1; Tue,
 25 Aug 2026 06:23:16 -0400
X-MC-Unique: zRl4fgjhOWaLlII6WWpl_w-1
X-Mimecast-MFC-AGG-ID: zRl4fgjhOWaLlII6WWpl_w_1787653395
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A0A3187BE2A; Tue, 25 Aug 2026 10:23:15 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 065D819560AB; Tue, 25 Aug 2026 10:23:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:43 +0400
Subject: [PATCH 06/18] ui/dmabuf: own and close fds on free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-6-d3bb612b9975@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8198;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LnYsn1AJWCMaPoZ07U+15aQlW4qWLu003IRLniecQv8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyX0wopJDSSma12WvKXx6Svum5mwjRFSIqeD
 zvMQ6JiNxSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1slwAKCRDa6OEJdZac
 5YqgD/4+S7OLQtv0uGunEJ+PPuIaidJn9oEAofwtI8KXTMsY6gnhwt4/rc+4G9a9Bsc/Z39+BXY
 QJRugs7IftPZxfx0E+ogN+Ayw4I2xj6jJEtKB72AjBNTs12s1WgJ9bkz0jlsN66XkL837zkI3EN
 HA2IXeMJtGIXITFJnV1DYQgFpwJPXsSDDCegkjXv7T3m5cmUHolK+H9nE0N5lBsZWKJyFC0i2HN
 QJBVyfzkmXZ3m7e5WJhqr/s7TA0x1qwCkB9b8sLT3S2PyohOlFg/QwaqEzc5JFhfEJmNx25pDbl
 vEJbgC1xj/yaP+j8D4UAKv6sV0JYVVfr0QFv8FF8mqAnRqI/dqzVnG8tJFxGVgssdMpRLDDx0C+
 0tAZ0e4yJZGFKHMZjAvMQ44AnDAsyDvxbG44NX1lY4g9tzJgOVbMZa4eKV61oxS4DnYtA/lFIOV
 9jx8NgA41Eiwr96hKS10ScjVeRO6zSj5qdf20Pfm5ZaEduvQTYSbl8KpQRMvJAg0X67kyzKMR10
 O6OGnWvYBaPDyFlnk9+Ll+uqKKDBZxI2s7x9Em+MNkXhGm7113b/DWL+akgjvWAGzN/EprLjcaA
 y1oDKKNkAgY1togJNo8FvCE+u7voLgeOoquK1aUomKzb7+9WEYpdM2tWOYazelYRcJoDaQPrtdl
 QsBp6syOIyIBLJw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make qemu_dmabuf_free() call qemu_dmabuf_close(), so the dmabuf always
owns and closes its fds. This removes the need for callers to
explicitly close fds before freeing and simplify the code.

To support this, virtio_gpu_create_dmabuf() now dup()s the resource fd
so each QemuDmaBuf has an independent copy. The scanout-matching loop
in virtio_gpu_fini_udmabuf() is no longer needed and is removed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c           |  1 -
 hw/display/virtio-gpu-udmabuf-stubs.c |  2 +-
 hw/display/virtio-gpu-udmabuf.c       | 32 +++++++++-----------------------
 hw/display/virtio-gpu.c               |  2 +-
 hw/vfio/display.c                     |  1 -
 include/hw/virtio/virtio-gpu.h        |  3 +--
 include/ui/dmabuf.h                   |  1 -
 ui/dbus-listener.c                    |  1 -
 ui/dmabuf.c                           | 22 ++++++++--------------
 9 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index cd684d63639e..c09aca041135 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -293,7 +293,6 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         dmabuf = g->dmabuf[m->scanout_id];
 
         if (dmabuf) {
-            qemu_dmabuf_close(dmabuf);
             qemu_console_gl_release_dmabuf(con, dmabuf);
             g_clear_pointer(&dmabuf, qemu_dmabuf_free);
         }
diff --git a/hw/display/virtio-gpu-udmabuf-stubs.c b/hw/display/virtio-gpu-udmabuf-stubs.c
index 85d03935a332..f692e1351034 100644
--- a/hw/display/virtio-gpu-udmabuf-stubs.c
+++ b/hw/display/virtio-gpu-udmabuf-stubs.c
@@ -12,7 +12,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     /* nothing (stub) */
 }
 
-void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
+void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     /* nothing (stub) */
 }
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index fd47028a1189..094646af8636 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -79,7 +79,7 @@ static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res)
     }
 }
 
-static void virtio_gpu_destroy_udmabuf(struct virtio_gpu_simple_resource *res)
+void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     if (res->remapped) {
         munmap(res->remapped, res->blob_size);
@@ -143,7 +143,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
         }
         virtio_gpu_remap_udmabuf(res);
         if (!res->remapped) {
-            virtio_gpu_destroy_udmabuf(res);
+            virtio_gpu_fini_udmabuf(res);
             return;
         }
         pdata = res->remapped;
@@ -152,42 +152,28 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     res->blob = pdata;
 }
 
-void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
-{
-    int max_outputs = g->parent_obj.conf.max_outputs;
-    int i;
-
-    for (i = 0; i < max_outputs; i++) {
-        struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[i];
-
-        if (scanout->dmabuf &&
-            qemu_dmabuf_get_num_planes(scanout->dmabuf) > 0 &&
-            qemu_dmabuf_get_fds(scanout->dmabuf, NULL)[0] == res->dmabuf_fd &&
-            res->dmabuf_fd != -1) {
-            qemu_dmabuf_close(scanout->dmabuf);
-            res->dmabuf_fd = -1;
-        }
-    }
-
-    virtio_gpu_destroy_udmabuf(res);
-}
-
 static QemuDmaBuf *
 virtio_gpu_create_dmabuf(struct virtio_gpu_simple_resource *res,
                          struct virtio_gpu_framebuffer *fb,
                          struct virtio_gpu_rect *r)
 {
     uint32_t offset = 0;
+    int fd;
 
     if (res->dmabuf_fd < 0) {
         return NULL;
     }
 
+    fd = qemu_dup(res->dmabuf_fd);
+    if (fd < 0) {
+        return NULL;
+    }
+
     return qemu_dmabuf_new(r->width, r->height,
                            &offset, &fb->stride,
                            r->x, r->y, fb->width, fb->height,
                            qemu_pixman_to_drm_format(fb->format),
-                           DRM_FORMAT_MOD_INVALID, &res->dmabuf_fd,
+                           DRM_FORMAT_MOD_INVALID, &fd,
                            1, true, false);
 }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index fbb6fec7a0ad..0335b636068d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -978,7 +978,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
     res->addrs = NULL;
 
     if (res->blob) {
-        virtio_gpu_fini_udmabuf(g, res);
+        virtio_gpu_fini_udmabuf(res);
     }
 }
 
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index cb83d98e9af6..89854eceb43c 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -263,7 +263,6 @@ static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
 {
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
 
-    qemu_dmabuf_close(dmabuf->buf);
     qemu_console_gl_release_dmabuf(dpy->con, dmabuf->buf);
     g_clear_pointer(&dmabuf->buf, qemu_dmabuf_free);
     g_free(dmabuf);
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 79eb4b1b8cec..d3ca8d82586b 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -379,8 +379,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
 /* virtio-gpu-udmabuf.c */
 bool virtio_gpu_have_udmabuf(void);
 void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
-void virtio_gpu_fini_udmabuf(VirtIOGPU *g,
-                             struct virtio_gpu_simple_resource *res);
+void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res);
 int virtio_gpu_update_dmabuf(VirtIOGPU *g,
                              uint32_t scanout_id,
                              struct virtio_gpu_simple_resource *res,
diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index 381583bd536c..e47b96b454dd 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -27,7 +27,6 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
 
 const int *qemu_dmabuf_get_fds(QemuDmaBuf *dmabuf, int *nfds);
 void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, int nfds);
-void qemu_dmabuf_close(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
 const uint32_t *qemu_dmabuf_get_offsets(QemuDmaBuf *dmabuf, int *noffsets);
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 5a72c7eeae59..c1e86648384c 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -631,7 +631,6 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
     if (dbus_call_scanout_dmabuf(ddl, dmabuf)) {
         ddl->scanout_dmabuf = NULL;
     }
-    qemu_dmabuf_close(dmabuf);
 #endif
 
 #ifdef WIN32
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index b61dc7ad2783..3651f784bd14 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -62,10 +62,18 @@ QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
 
 void qemu_dmabuf_free(QemuDmaBuf *dmabuf)
 {
+    int i;
+
     if (dmabuf == NULL) {
         return;
     }
 
+    for (i = 0; i < dmabuf->num_planes; i++) {
+        if (dmabuf->fd[i] >= 0) {
+            close(dmabuf->fd[i]);
+            dmabuf->fd[i] = -1;
+        }
+    }
     g_free(dmabuf);
 }
 
@@ -92,20 +100,6 @@ void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, int nfds)
     }
 }
 
-void qemu_dmabuf_close(QemuDmaBuf *dmabuf)
-{
-    int i;
-
-    assert(dmabuf != NULL);
-
-    for (i = 0; i < dmabuf->num_planes; i++) {
-        if (dmabuf->fd[i] >= 0) {
-            close(dmabuf->fd[i]);
-            dmabuf->fd[i] = -1;
-        }
-    }
-}
-
 uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf)
 {
     assert(dmabuf != NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


