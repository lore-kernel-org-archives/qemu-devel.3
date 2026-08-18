Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34A2C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC7r-0005BI-8G; Tue, 18 Aug 2026 01:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7q-0005Az-7b
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7n-0003lD-F9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so3336564b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029953; x=1787634753; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5iSPjR4OWYgSwQ/ju8j1WMdGvtILP0xKe6fEY1lq/RU=;
 b=eSANZ5qpn2H5yPHs5u61RjqhCrn8jYQjKhFCxxK+7Zim/Qz7Ibv5ANuSAzskZakywz
 dDsv8T1lFBIfvlHqMpUaqEQBACAB8n8/yzIABadhaCGBj2fU9T70liCVQZiZR1OGyFhH
 FEEkKct2gqA6sB4TYrfX3IeuWbiRIbMqJq8AcUw2mOwDezG9e2SceNPO5VzQqEVjqd9/
 Tr/9+6m8lUrTm5SwINpkQjJRUVy8RUpDbPXVSktXUevJ91qKG3Qi00MbHHqAHipnJ7fK
 TYcCrjv1qYTEry/URTeqezrGUhw9zskgBpD21bj4+aU7OVS4uXyi9VL0o1rYwDSxh21e
 zuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029953; x=1787634753;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5iSPjR4OWYgSwQ/ju8j1WMdGvtILP0xKe6fEY1lq/RU=;
 b=d5wtgU7JBJs6K1LpQI8cR6K33A02FYXKgfGYGxVVwmJLTyWG4IWQBpuIhx8pI75tVB
 znZt1UajkhUzPHxmE2yJMpE92q8e5LAn7SqHNdApKiOEBsqvwE0ulPejaVGFHvSfK5ir
 RlMDs+A59RIOCbfhvxs5gqQFheFPVOxSfolFvtJJR6euX06pNnqlGBvJPdIsH1EWC1nQ
 q6Z3nLNCCzOyovWrQQ+it+D4SAVoiRGEcdWV/trcVSmERvXKei3ZJ9eP055BxeseOyxA
 6Gs3nxcq28SLNJsKFYi0byt2vY1SXi/5tI4jp5AgNzF/4SDmdu+BNV/NKSwWnSQP1BLw
 Hy6g==
X-Gm-Message-State: AOJu0YwIocIq0E79xr2Qoia6ObP7a4x03WCfiSvQ9va8lyj1YsO26OQL
 GxZyXhBHT7I9jft32K/v2eVfRJgndF6tFU4gDbiWpYjL5+KS/r85bFPV
X-Gm-Gg: AR+sD12BGxChGzUc8MDi7x3gToI9nZtLkdiy1PzkoLoHxY+DdhUcPv9aYItd70/b8nL
 rypGoAOgO45v29Pr6tlTcdYS6ViHIr7uD4sOqbUIk5CnXGNg/UoGkd2JgSNBj1ACPEy22Q5wyvp
 S6e5V6gpUOhYm6QwfXa0ouRKZMFS4rOUwZsll7Wg8/LzxP1ekoOTKf0U7cHPt8spG03jV7S+K5o
 uSXAOzYaLQre3aIbRfhcqb5iD58t9+bH0ofgdF3o8ZdiOM1Re5e/5fGeRwigNF2J0jNkh93/du9
 RzlfOXCRJYO8rfl7LVsFuSW51WnnvMEv6ZPqEobqwA5kPUx5HmEWnlbl7bFwVQ8Htal9driviTv
 VICcgNqmNB6aKoM+65XVVmtswykZyJoJIVzJzTG72LRv3zH7ob6WgIZigWDQRaz9Ips0nybCNTh
 zepLFXvyzpzZ3LCgWZMwMQvb3LbGDNERObMy4mNEa0phpbj9flJ1w3auvGFMzsmP2gOg==
X-Received: by 2002:a05:6a00:9508:b0:84a:29a7:f3b1 with SMTP id
 d2e1a72fcca58-84fde12721fmr25945799b3a.16.1787029952715; 
 Mon, 17 Aug 2026 22:12:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:32 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:20 -0700
Subject: [PATCH RFC v2 05/13] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-5-948aae960abb@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=6847;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=zMLe3YYRkSQNcCO8gpXX8eru8I8FhRevRD5BzLCf9h0=;
 b=89rGEsgnDJRxANQcPGgrkm/+un/OiboC53ebypLTch0HhTgwjPLd90rOF6xBlNmgXEPieR5tO
 M3II78hh4MbBjxsLiRFIaMsN7mmmp0N/KQLgNRDJDSzS8Vf8oaBycvV
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

By default svq vrings are placed in an anonymous memory map. As svqs
will be leveraged to enable memory isolation in vhost-user, it is useful
to be able to place the vrings in a shared isolation memory region.

Adds the option to specify vring placement by providing a vring base
address before starting the svq.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 69 ++++++++++++++++++++++++++++++++------
 hw/virtio/vhost-shadow-virtqueue.h |  8 ++++-
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 496e7e58a3..f54a61439a 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -812,6 +812,13 @@ size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
     return ROUND_UP(used_size, qemu_real_host_page_size());
 }
 
+size_t vhost_svq_vring_total_size(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VhostShadowVirtqueue svq;
+    svq.vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
+    return vhost_svq_driver_area_size(&svq) + vhost_svq_device_area_size(&svq);
+}
+
 /**
  * Set a new file descriptor for the guest to kick the SVQ and notify for avail
  *
@@ -842,6 +849,19 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
     }
 }
 
+/**
+ * Set vring base address if using fixed locations
+ *
+ * @svq: Shadow Virtqueue
+ * @addr: Points to new base address
+ */
+
+ void vhost_svq_set_base_addr(VhostShadowVirtqueue *svq, void *addr)
+ {
+    svq->base_addr = addr;
+ }
+
+
 /**
  * Start the shadow virtqueue operation.
  *
@@ -849,8 +869,10 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
  * @vdev: VirtIO device
  * @vq: Virtqueue to shadow
  * @iova_tree: Tree to perform descriptors translations
+ *
+ * Return 0 on success, -errno on failure
  */
-void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
+int vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                      VirtQueue *vq, VhostIOVATree *iova_tree)
 {
     size_t desc_size;
@@ -868,14 +890,27 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
 
     svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
     svq->num_free = svq->vring.num;
-    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
-                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
-                           -1, 0);
     desc_size = sizeof(vring_desc_t) * svq->vring.num;
-    svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
-    svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
-                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
-                           -1, 0);
+    if (svq->base_addr == NULL) {
+        svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
+                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                            -1, 0);
+        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
+        svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
+                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                            -1, 0);
+    } else {
+        svq->vring.desc = (void *)svq->base_addr;
+        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
+        svq->vring.used = (void *)((char *)svq->base_addr +
+                          vhost_svq_driver_area_size(svq));
+
+        if ((uint64_t)svq->vring.used + vhost_svq_device_area_size(svq) - 1 <
+           (uint64_t)svq->vring.desc) {
+                error_report("Invalid shadow vring location");
+                return -ENOMEM;
+        }
+    }
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
         svq->batch_last.id = VIRTIO_RING_NOT_IN_BATCH;
@@ -884,6 +919,8 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
             svq->desc_state[i].next = i + 1;
         }
     }
+
+    return 0;
 }
 
 /**
@@ -920,8 +957,19 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
     }
     svq->vq = NULL;
     g_free(svq->desc_state);
-    munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
-    munmap(svq->vring.used, vhost_svq_device_area_size(svq));
+
+    if (!svq->base_addr) {
+        munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
+        munmap(svq->vring.used, vhost_svq_device_area_size(svq));
+    } else{
+        if (svq->vring.desc) {
+            memset(svq->vring.desc, 0, vhost_svq_driver_area_size(svq));
+        }
+        if (svq->vring.used) {
+            memset(svq->vring.used, 0, vhost_svq_device_area_size(svq));
+        }
+    }
+
     event_notifier_set_handler(&svq->hdev_call, NULL);
 }
 
@@ -940,6 +988,7 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
     event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
     svq->ops = ops;
     svq->ops_opaque = ops_opaque;
+    svq->base_addr = NULL;
     return svq;
 }
 
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index fd68319fb7..1e0cc9e5e4 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -150,6 +150,9 @@ typedef struct VhostShadowVirtqueue {
 
     /* Size of SVQ vring free descriptors */
     uint16_t num_free;
+
+    /* Location assigned to vrings if not in default anon memory map */
+    void *base_addr;
 } VhostShadowVirtqueue;
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
@@ -169,8 +172,9 @@ void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
                               struct vhost_vring_addr *addr);
 size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
 size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
+size_t vhost_svq_vring_total_size(VirtIODevice *vdev, VirtQueue *vq);
 
-void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
+int vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                      VirtQueue *vq, VhostIOVATree *iova_tree);
 void vhost_svq_stop(VhostShadowVirtqueue *svq);
 
@@ -178,6 +182,8 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
                                     void *ops_opaque);
 
 void vhost_svq_free(gpointer vq);
+void vhost_svq_set_base_addr(VhostShadowVirtqueue *svq, void *addr);
+
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(VhostShadowVirtqueue, vhost_svq_free);
 
 #endif

-- 
2.43.0


