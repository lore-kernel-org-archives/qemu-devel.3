Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F50DC79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p5O-0002B0-G8; Tue, 08 Sep 2026 02:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5M-00029y-TZ; Tue, 08 Sep 2026 02:13:36 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5K-0000ky-TS; Tue, 08 Sep 2026 02:13:36 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG95048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:28 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=RY6eYZNWGQvOJfb6U+vwIuVey1hH20wQimkxJDabnc8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847948; v=1;
 b=D/sKsOUId2l7LhEuWymyLZBBr5iamnXNWz0iJeq9YxJLh1e/LwNE7uh6+tOIjFMe
 1CHP641Xh5idoqzAiYvh3rweEHGsv0ABel7c1CESqvKiFyozi9UQn8vV8B9VFebi
 spOBmroUzVEYkAgsSQ0B81uEMQ5PKs+p5NlYjvcyRW3NBx7jWwEG5rZFi9qvyd+i
 qOKORZDeC2dE7kEP2RtH/hfprerN4hw64GiqPOt5ZayuwIAxmgNcKtxc6EMNOcCb
 M1UGjPJy7Y17WZBdY7rp0L9x/reVXV2stHPhpFgki6R4AJGdcwP7T6qer4n0bEFp
 rWy/zK3N+rcVyF9rSyNSwQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 08 Sep 2026 15:11:25 +0900
Subject: [PATCH v3 8/9] hw/display/virtio-gpu: Reject queue_reset when
 unsupported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gpu-v3-8-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4844;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=/jC8i/T5e9cBR6MWWlrh7f4HpAp3kHiWZ6R52gSjItM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85R6yH/YunscrFZm08bjpSwWFjD1Mp9d67ngdyG4zJ
 3cOi/rujlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIlMdGT4p/21etpmjcsnmlof
 mMg/ecD7iuVrT9mGZonH+4Mvveu6a8TIMMXN8e1CyfCTiqZTG761pG1fmnKsvvOhgMarRAO+h1n
 9LAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Making queue_reset functional with virtio-gpu-gl, virtio-gpu-rutabaga,
and vhost-user-gpu requires adding corresponding APIs to their backends.
queue_reset is useless for them after all since they do not have
multiple queues that contend for buffers. It is not necessary to keep
queue_reset available for migration compatibility since they don't
support migration. Reject queue_reset for these devices.

Fixes: 69e1c14aa222 ("virtio: core: vq reset feature negotation support")
Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/vhost-user-gpu.c      |  7 +++++++
 hw/display/virtio-gpu-gl.c       | 12 ++++++++++++
 hw/display/virtio-gpu-rutabaga.c | 11 +++++++++++
 3 files changed, 30 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index f8d640557c28..880a9fecc81a 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -625,6 +625,8 @@ vhost_user_gpu_instance_init(Object *obj)
     g->vhost = VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND));
     object_property_add_alias(obj, "chardev",
                               OBJECT(g->vhost), "chardev");
+
+    object_property_set_bool(obj, "queue_reset", false, &error_abort);
 }
 
 static void
@@ -661,6 +663,11 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
     VhostUserGPU *g = VHOST_USER_GPU(qdev);
     VirtIODevice *vdev = VIRTIO_DEVICE(g);
 
+    if (virtio_host_has_feature(VIRTIO_DEVICE(qdev), VIRTIO_F_RING_RESET)) {
+        error_setg(errp, "queue_reset is not supported");
+        return;
+    }
+
     vhost_dev_set_config_notifier(&g->vhost->dev, &config_ops);
     if (vhost_user_backend_dev_init(g->vhost, vdev, 2, errp) < 0) {
         return;
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c46643..d215e897c1d5 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qom/object.h"
 #include "system/system.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
@@ -119,6 +120,11 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     return;
 #endif
 
+    if (virtio_host_has_feature(VIRTIO_DEVICE(qdev), VIRTIO_F_RING_RESET)) {
+        error_setg(errp, "queue_reset is not supported");
+        return;
+    }
+
     if (!object_resolve_path_type("", TYPE_VIRTIO_GPU_GL, NULL)) {
         error_setg(errp, "at most one %s device is permitted", TYPE_VIRTIO_GPU_GL);
         return;
@@ -209,6 +215,11 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
      */
 }
 
+static void virtio_gpu_gl_instance_init(Object *obj)
+{
+    object_property_set_bool(obj, "queue_reset", false, &error_abort);
+}
+
 static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -232,6 +243,7 @@ static const TypeInfo virtio_gpu_gl_info = {
     .name = TYPE_VIRTIO_GPU_GL,
     .parent = TYPE_VIRTIO_GPU,
     .instance_size = sizeof(VirtIOGPUGL),
+    .instance_init = virtio_gpu_gl_instance_init,
     .class_init = virtio_gpu_gl_class_init,
 };
 module_obj(TYPE_VIRTIO_GPU_GL);
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index f28daa844328..c77e72c88e96 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1124,6 +1124,11 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
     return;
 #endif
 
+    if (virtio_host_has_feature(VIRTIO_DEVICE(qdev), VIRTIO_F_RING_RESET)) {
+        error_setg(errp, "queue_reset is not supported");
+        return;
+    }
+
     error_setg(&bdev->migration_blocker, "rutabaga is not yet migratable");
     if (migrate_add_blocker(&bdev->migration_blocker, errp) < 0) {
         return;
@@ -1165,6 +1170,11 @@ static const Property virtio_gpu_rutabaga_properties[] = {
     DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
 };
 
+static void virtio_gpu_rutabaga_instance_init(Object *obj)
+{
+    object_property_set_bool(obj, "queue_reset", false, &error_abort);
+}
+
 static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1187,6 +1197,7 @@ static const TypeInfo virtio_gpu_rutabaga_info[] = {
         .name = TYPE_VIRTIO_GPU_RUTABAGA,
         .parent = TYPE_VIRTIO_GPU,
         .instance_size = sizeof(VirtIOGPURutabaga),
+        .instance_init = virtio_gpu_rutabaga_instance_init,
         .class_init = virtio_gpu_rutabaga_class_init,
     },
 };

-- 
2.55.0


