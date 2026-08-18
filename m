Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB68AC5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC80-0005Fb-TV; Tue, 18 Aug 2026 01:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7z-0005F1-J9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:47 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7x-0003o7-Kt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:47 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso3502087a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029964; x=1787634764; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mm3IHLFoV1taMjKnzvr28Ku7UY4hQc5i3yvfG4WtmPU=;
 b=EXtHT12IUrlLdyDnPO0y8gc5+9B01nt6torrElwJjU/pXdt7ajyHTlhdqinV84UMse
 RiGc1zELT5gVGtZ++Y0RmRAyqWN3C7ChVovcqoTW51ZXcaej7xCn5WdWMaYm/FmooDss
 45vQLBucXrhKbE9kjeVgVUp6pgQBDmcWILmhN77l0CF4AXbaUVUBMXx/YBcYVFp3mLCz
 JcpirdDHTF3d8yVLgDq8S9FLj2nJqDKNTTJblXAsSR0rV+zrArPhkmmCkUfCIphnEUFq
 00WDihpnNFb7jsvH/LuZXvB2x62oXm7+oHOA4rSTifQaAyfLplD+bavRSdPp+83CWUS0
 oB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029964; x=1787634764;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mm3IHLFoV1taMjKnzvr28Ku7UY4hQc5i3yvfG4WtmPU=;
 b=cDkCQUfVDpDAdtKk4z4PN6XFOEhf3+GntD/yQ1/ZGK3Qb6lJE+la8ogLRje+1nKEG6
 3DfRapQlsvh7nXyk934qE9YyrylURnhOp0TlX/Ku0p3cKj7zA/ADEADlZX4f/I3L50en
 fNae8mbpGLsVdZKH6XzrnRkjuioPWj+K/uryoSsVEixnxYYBT9odCO07NvKG6nSZN8vr
 UdwvNKy1Ds5ltn8IIBrkP8PVTA/P7E9X3M1biQp9fAM55bFsDFZYuSCR/fN3X3NY66vZ
 NDrh4Re9TGm+HwT7lDqB/1rETROGi0hJzlIwZpQbQRBX2nlZ7MFQ4RhiDjiR2tNNtJuZ
 XmEQ==
X-Gm-Message-State: AOJu0Ywgvf4aPfD+JiiZzSJSEzZUx6oOTkSq/AesWV2GWM1h1KaMRzUK
 OYMc+vfmS++UgUuTpJPLVNnq3wZDNXTN+8Nv7VvhGjZGi3V0upTaHQte
X-Gm-Gg: AR+sD12gu1rw7UU2iO3VdIlm9gf5J2NHSVFZHSoTJXQ4FFjQKpVQnlr/cTwqLZuUSXA
 +3TqgjvqoYD3MIhGQKn4OG+DT1ZDMoh6Q3fbSj6KXcPshbb8mtJnDtl/NIsaEeeGcQSeXykfAI+
 JTVoG/4ldB22r20in4zu8tn18fFKWRsPWpfVgnxdAVc36aG18qfJD9J2zJbChsT6G34Y/1GwqKU
 /UGT57PBCZ+zWytieS5FzmWCBfVZtP1B6lU0aRDuluAyS52JcaER3PSPNfJydMbZoVHVdC3ZFIz
 SvEunxciK8nroRMw2CJ8fPpeDiiNkNsR4mtmqkOAOyj7rBZaIE26xZ5bva/gD6ytui95ApGMHcA
 EG8OIX+pA5Mm85QYsPLQL/UoCCcFdacAz4BiNrm7GIeCEKBUHnmXhiVROv1pmn09VBC5MhIaVki
 U5BCdhoOG3JfRYcHR2Fo+JGekzv2DXcN6fU81WzZuVhnbwwBzgrw6RkUpU5qK9WfK9cA==
X-Received: by 2002:a05:6a00:278b:b0:84e:2f2e:8c4f with SMTP id
 d2e1a72fcca58-851b877b568mr7241523b3a.10.1787029963893; 
 Mon, 17 Aug 2026 22:12:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:43 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:24 -0700
Subject: [PATCH RFC v2 09/13] hw/virtio/vhost-user: add shadow virtqueues
 and eventfd intercepts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-9-948aae960abb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=9404;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=EM/PjlQw++6DCEU0UaWG6Z1mgIImjSnvKqIHao8jzr4=;
 b=E3VPFG/PNlIUzUZxtU9++LwDFS+hH3gRp4CoQ/fnJjpf6gmv+Mx2dER69xXBhSKCU5v8SV8OS
 0doaRJ/cXw4Di60Rr3WEWoV19lFWLVxLxPsIr7NjE/CpsNZSC8BZZA/
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=connorkite@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Adds shadow virtqueues that will eventually be used to transfer data
between device and host via bounce buffers when isolation mode is
active.  The svqs are initalized, and eventfd assignments are
intercepted so that notifications come to svqs first before
the guest or backend receive them.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-user.c | 136 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e1e5cba53d..ace328f5eb 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -18,6 +18,7 @@
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/vhost-shadow-virtqueue.h"
 #include "hw/virtio/vhost-iova-tree.h"
 #include "chardev/char-fe.h"
 #include "io/channel-socket.h"
@@ -331,6 +332,7 @@ typedef struct {
     size_t size; /* size of the mapped shared memory */
     int fd; /* descriptor of anonymous file backing shared iso region */
     Int128 iso_iova_offset; /* translation from IOVA to hva of iso region */
+    GPtrArray *shadow_vqs; /* shadow vqs with vrings in iso region*/
 } IsolationModeCtx;
 
 struct vhost_user {
@@ -1128,15 +1130,38 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
     return 0;
 }
 
-static void cleanup_isolation_regions(struct vhost_dev *dev)
+static void vhost_user_svq_cleanup(struct vhost_user *u, bool reset)
+{
+    VhostShadowVirtqueue *svq;
+    for (int i = 0; i < u->iso_mem_ctx.shadow_vqs->len; i++) {
+        svq = g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, i);
+        vhost_svq_stop(svq);
+        event_notifier_cleanup(&svq->hdev_call);
+        event_notifier_cleanup(&svq->hdev_kick);
+    }
+
+    if (!reset) {
+        g_ptr_array_free(u->iso_mem_ctx.shadow_vqs, true);
+    }
+}
+
+static void cleanup_isolation_regions(struct vhost_dev *dev, bool reset)
 {
     struct vhost_user *u = dev->opaque;
     if (u->iso_mem_ctx.shared_mem_addr) {
+        vhost_user_svq_cleanup(u, reset);
         vhost_iova_tree_delete(u->iso_mem_ctx.tree);
         qemu_memfd_free(u->iso_mem_ctx.shared_mem_addr,
                         u->iso_mem_ctx.size,
                         u->iso_mem_ctx.fd);
+
+        GPtrArray *temp = u->iso_mem_ctx.shadow_vqs;
         memset(&u->iso_mem_ctx, 0, sizeof(IsolationModeCtx));
+
+        if (!reset) {
+            u->iso_mem_ctx.shadow_vqs = temp;
+        }
+
     }
 }
 
@@ -1234,7 +1259,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
     msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
 
     /* In case of reset, clear old regions */
-    cleanup_isolation_regions(dev);
+    cleanup_isolation_regions(dev, true);
 
     /* Gather information for bounce buffers to be mapped */
     for (u_int32_t i = 0; i < nregions; i++) {
@@ -1267,7 +1292,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
 
     if (err) {
         error_report_err(err);
-        cleanup_isolation_regions(dev);
+        cleanup_isolation_regions(dev, false);
         return -1;
     }
 
@@ -1295,7 +1320,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
                                   (hwaddr)u->iso_mem_ctx.shared_mem_addr);
 
     if (r != IOVA_OK) {
-        cleanup_isolation_regions(dev);
+        cleanup_isolation_regions(dev, false);
         return r;
     }
 
@@ -1310,7 +1335,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
                                           dev->mem->regions[i].guest_phys_addr);
 
         if (r != IOVA_OK) {
-            cleanup_isolation_regions(dev);
+            cleanup_isolation_regions(dev, false);
             return r;
         }
     }
@@ -1738,11 +1763,49 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
     return 0;
 }
 
+static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
+{
+    assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
+
+    return idx;
+}
+
 static int vhost_user_set_vring_kick(struct vhost_dev *dev,
                                      struct vhost_vring_file *file)
 {
-    int ret = vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, file);
+    struct vhost_user *u = dev->opaque;
+    int svq_idx = file->index - dev->vq_index;
+    VhostShadowVirtqueue *svq = NULL;
+    struct vhost_vring_file vr_file = *file;
+    int ret;
+
+    vhost_user_get_vq_index(dev, file->index); /* bounds checking */
+
+    if (u->user->memory_isolation) {
+        svq = g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, svq_idx);
+        vhost_svq_set_svq_kick_fd(svq, file->fd);
+
+        if (file->fd != -1) {
+            if (!svq->hdev_kick.initialized) {
+                ret = event_notifier_init(&svq->hdev_kick, 0);
+                if (ret < 0) {
+                    event_notifier_cleanup(&svq->hdev_kick);
+                    error_report("Failed to create kick event notifier");
+                    return ret;
+                }
+            }
+
+            vr_file.fd = event_notifier_get_fd(&svq->hdev_kick);
+        } else {
+            event_notifier_cleanup(&svq->hdev_kick);
+        }
+    }
+
+    ret = vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, &vr_file);
     if (ret < 0) {
+        if (svq != NULL) {
+            event_notifier_cleanup(&svq->hdev_kick);
+        }
         return ret;
     }
 
@@ -1750,15 +1813,18 @@ static int vhost_user_set_vring_kick(struct vhost_dev *dev,
      * Inject a kick in case the back-end only starts vring processing upon
      * receiving a kick. The spec suggests this to improve compatibility.
      */
-    if (file->fd != -1) {
+    if (vr_file.fd != -1) {
         uint64_t val = 1;
         ssize_t nwritten;
 
         do {
-            nwritten = write(file->fd, &val, sizeof(val));
+            nwritten = write(vr_file.fd, &val, sizeof(val));
         } while (nwritten < 0 && errno == EINTR);
 
         if (nwritten < 0 && errno != EAGAIN /* back-end can already read */) {
+            if (svq != NULL) {
+                event_notifier_cleanup(&svq->hdev_kick);
+            }
             return -errno;
         }
     }
@@ -1769,7 +1835,35 @@ static int vhost_user_set_vring_kick(struct vhost_dev *dev,
 static int vhost_user_set_vring_call(struct vhost_dev *dev,
                                      struct vhost_vring_file *file)
 {
-    return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_CALL, file);
+    struct vhost_user *u = dev->opaque;
+    int svq_idx = file->index - dev->vq_index;
+    VhostShadowVirtqueue *svq = NULL;
+    struct vhost_vring_file vr_file = *file;
+    int ret;
+
+    vhost_user_get_vq_index(dev, file->index); /* bounds checking */
+
+    if (u->user->memory_isolation) {
+        svq = g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, svq_idx);
+        vhost_svq_set_svq_call_fd(svq, file->fd);
+
+        if (file->fd != -1) {
+            if (!svq->hdev_call.initialized) {
+                ret = event_notifier_init(&svq->hdev_call, 0);
+                if (ret < 0) {
+                    event_notifier_cleanup(&svq->hdev_call);
+                    error_report("Failed to create call event notifier");
+                    return ret;
+                }
+            }
+
+            vr_file.fd = event_notifier_get_fd(&svq->hdev_call);
+        } else {
+            event_notifier_cleanup(&svq->hdev_call);
+        }
+    }
+
+    return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_CALL, &vr_file);
 }
 
 static int vhost_user_set_vring_err(struct vhost_dev *dev,
@@ -2763,6 +2857,17 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
+static void vhost_user_init_svq(struct vhost_dev *dev, struct vhost_user *u)
+{
+    /*Modified from vhost-vdpa*/
+    u->iso_mem_ctx.shadow_vqs = g_ptr_array_new_full(dev->nvqs, vhost_svq_free);
+    for (int i = 0; i < dev->nvqs; i++) {
+        VhostShadowVirtqueue *svq;
+        svq = vhost_svq_new(NULL, NULL);
+        g_ptr_array_add(u->iso_mem_ctx.shadow_vqs, svq);
+    }
+}
+
 static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                                    Error **errp)
 {
@@ -2907,6 +3012,10 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     u->postcopy_notifier.notify = vhost_user_postcopy_notifier;
     postcopy_add_notifier(&u->postcopy_notifier);
 
+    if (vus->memory_isolation) {
+        vhost_user_init_svq(dev, u);
+    }
+
     return 0;
 }
 
@@ -2935,20 +3044,13 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
     g_free(u->region_rb_offset);
     u->region_rb_offset = NULL;
     u->region_rb_len = 0;
-    cleanup_isolation_regions(dev);
+    cleanup_isolation_regions(dev, false);
     g_free(u);
     dev->opaque = 0;
 
     return 0;
 }
 
-static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
-{
-    assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
-
-    return idx;
-}
-
 static int vhost_user_memslots_limit(struct vhost_dev *dev)
 {
     struct vhost_user *u = dev->opaque;

-- 
2.43.0


