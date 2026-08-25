Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8199C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypLN-0002NT-PF; Tue, 25 Aug 2026 07:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLH-00029Y-6d
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLE-0005ro-4j
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWIkY2mDIqLc80URhGK374g0ho5Fog2QF4giWIJoPQc=;
 b=Jl784Hd5C5iui56BNXBl3vNhAVp+smOPrJuTA5gce+GJHGTxkRTavSr/OeTAnMpkPCn97r
 wy521x99A9UWMfCFZ88IYf97R66D2lFjd++z8CPoi9VX8MvzovfbHIgkJ8euGkpM90gZcd
 dzTp+TtCsVUsLZ+YOqzArpa9eThHUNc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-h6L5c71uOwumOmmc64J_ig-1; Tue,
 25 Aug 2026 07:29:15 -0400
X-MC-Unique: h6L5c71uOwumOmmc64J_ig-1
X-Mimecast-MFC-AGG-ID: h6L5c71uOwumOmmc64J_ig_1787657354
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F29C2190FFB7; Tue, 25 Aug 2026 11:29:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3AC71803A44; Tue, 25 Aug 2026 11:29:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:20:55 +0400
Subject: [GIT PULL 05/19] virtio-gpu: use g_try_malloc to avoid
 guest-triggered abort
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-5-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9648;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Iqs48Jt6oUfR5yFt7ojHwnDuLBUUzo2gnDuVxagRfhU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrUL6Odt8SMBeYT5VZLT6d5Lj+5YggbdJkOd
 KXfOhl4L5+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161AAKCRDa6OEJdZac
 5TDXD/4+a54p5CIJrPl09EaxgQ5aJREKLNtMgQsfqK2WSgahUK2bU5JZtK1L/PrRKElTr5a//WH
 9TRBM2w0Ho1P0rX9we8i5YQx/poVN4bUYaztYtXWHTryg538tEi1iK7wP522drrG46jd1xJ1lwI
 5LADgn/Rvb9138pv3FSw9QvOTEEqyohwr480bexdZ+/amSQmWpf9leT7JBR6kyJAiCE1uurdVfV
 e+amdtBtwUcOKubxhwLmERj99CWds3plL1m7XznIgTczLqeWWWI1X61ZTJS1y+0mgP+L7kmokYf
 7kl2jcBDdHjPVi9mpWJb3kskFQo2Uez7wYUsA3giTuharcuShSUWs6s8xuTJIh9KHLA5H8atZVm
 67aEZjlRw3gNt6DseXhz7HJUhbQKXj5Ugh6N7czEsU4uCa18CU/woZB001HX+8m2kKPcSUcDQBY
 YL9crZzVPW++nKnTob1RrJB7FvSQ25d7c0Dz9fKdoFd39ARkqSpCGqZkc0PT6WMq7JzjNRzvzMt
 SIhAt/stUbX2c62GdpDIKjwSYt2inNZc0MUis06Y9pSZgfgu/kWhCNButIZEY65CHy5ram8K3eG
 kTETBtdF4xE7fIS/QwVvyhCzdfP6WzlaygJe9eIZ2i8iZvo8YbYaV9/pnql3SLCv3itm9VhA/Jq
 x93urgfkZ0OYwCQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failure
returns an error to the guest rather than crashing the host (glib
behaviour).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260805130141.211398-1-marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 25 +++++++++++++-------
 contrib/vhost-user-gpu/virgl.c          |  6 ++++-
 contrib/vhost-user-gpu/vugbm.c          |  5 +++-
 hw/display/virtio-gpu-rutabaga.c        | 14 +++++++++--
 hw/display/virtio-gpu-udmabuf.c         |  7 ++++--
 hw/display/virtio-gpu-virgl.c           |  6 ++++-
 hw/display/virtio-gpu.c                 | 42 ++++++++++++++++++++++++---------
 7 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index 786488150932..933bdbb671c0 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -487,7 +487,7 @@ vg_create_mapping_iov(VuGpu *g,
                       struct virtio_gpu_ctrl_command *cmd,
                       struct iovec **iov)
 {
-    struct virtio_gpu_mem_entry *ents;
+    g_autofree struct virtio_gpu_mem_entry *ents = NULL;
     size_t esize, s;
     int i;
 
@@ -498,17 +498,22 @@ vg_create_mapping_iov(VuGpu *g,
     }
 
     esize = sizeof(*ents) * ab->nr_entries;
-    ents = g_malloc(esize);
+    ents = g_try_malloc(esize);
+    if (!ents && esize) {
+        return -1;
+    }
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(*ab), ents, esize);
     if (s != esize) {
         g_critical("%s: command data size incorrect %zu vs %zu",
                    __func__, s, esize);
-        g_free(ents);
         return -1;
     }
 
-    *iov = g_new0(struct iovec, ab->nr_entries);
+    *iov = g_try_new0(struct iovec, ab->nr_entries);
+    if (!*iov && ab->nr_entries) {
+        return -1;
+    }
     for (i = 0; i < ab->nr_entries; i++) {
         uint64_t len = ents[i].length;
         (*iov)[i].iov_len = ents[i].length;
@@ -517,12 +522,10 @@ vg_create_mapping_iov(VuGpu *g,
             g_critical("%s: resource %d element %d",
                        __func__, ab->resource_id, i);
             g_free(*iov);
-            g_free(ents);
             *iov = NULL;
             return -1;
         }
     }
-    g_free(ents);
     return 0;
 }
 
@@ -828,8 +831,14 @@ vg_resource_flush(VuGpu *g,
                 PIXMAN_FORMAT_BPP(pixman_image_get_format(res->image)) / 8;
             size_t size = width * height * bpp;
 
-            void *p = g_malloc(VHOST_USER_GPU_HDR_SIZE +
-                               sizeof(VhostUserGpuUpdate) + size);
+            void *p = g_try_malloc(VHOST_USER_GPU_HDR_SIZE +
+                                   sizeof(VhostUserGpuUpdate) + size);
+            if (!p) {
+                pixman_region_fini(&region);
+                pixman_region_fini(&finalregion);
+                cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+                break;
+            }
             VhostUserGpuMsg *msg = p;
             msg->request = VHOST_USER_GPU_UPDATE;
             msg->size = sizeof(VhostUserGpuUpdate) + size;
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 550fd03bf5c4..20bae57d0fe4 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -209,7 +209,11 @@ virgl_cmd_submit_3d(VuGpu *g,
         return;
     }
 
-    buf = g_malloc(cs.size);
+    buf = g_try_malloc(cs.size);
+    if (!buf && cs.size) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+        return;
+    }
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
     if (s != cs.size) {
diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vugbm.c
index 710d54529779..e2d8385fd857 100644
--- a/contrib/vhost-user-gpu/vugbm.c
+++ b/contrib/vhost-user-gpu/vugbm.c
@@ -13,7 +13,10 @@
 static bool
 mem_alloc_bo(struct vugbm_buffer *buf)
 {
-    buf->mmap = g_malloc((uint64_t)buf->width * buf->height * 4);
+    buf->mmap = g_try_malloc((uint64_t)buf->width * buf->height * 4);
+    if (!buf->mmap && buf->width && buf->height) {
+        return false;
+    }
     buf->stride = buf->width * 4;
     return true;
 }
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index a054f8117f14..041216a10d04 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -366,10 +366,20 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
         return;
     }
 
-    buf = g_new0(uint8_t, cs.size);
+    buf = g_try_new0(uint8_t, cs.size);
+    if (!buf && cs.size) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+        return;
+    }
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
-    CHECK(s == cs.size, cmd);
+    if (s != cs.size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: size mismatch (%zu/%u)\n",
+                      __func__, s, cs.size);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
 
     rutabaga_cmd.ctx_id = cs.hdr.ctx_id;
     rutabaga_cmd.cmd = buf;
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 5f08c855dde1..816f52a51457 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -39,8 +39,11 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
         return;
     }
 
-    list = g_malloc0(sizeof(struct udmabuf_create_list) +
-                     sizeof(struct udmabuf_create_item) * res->iov_cnt);
+    list = g_try_malloc0(sizeof(struct udmabuf_create_list) +
+                         sizeof(struct udmabuf_create_item) * res->iov_cnt);
+    if (!list) {
+        return;
+    }
 
     for (i = 0; i < res->iov_cnt; i++) {
         rcu_read_lock();
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 6e298f997d66..9bda572426b2 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -620,7 +620,11 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
         return;
     }
 
-    buf = g_malloc(cs.size);
+    buf = g_try_malloc(cs.size);
+    if (!buf && cs.size) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+        return;
+    }
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
     if (s != cs.size) {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index fbb6fec7a0ad..9eb010082d0d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -892,7 +892,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
     }
 
     esize = sizeof(*ents) * nr_entries;
-    ents = g_malloc(esize);
+    ents = g_try_malloc(esize);
+    if (!ents && esize) {
+        return -1;
+    }
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    offset, ents, esize);
     if (s != esize) {
@@ -913,6 +916,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
         hwaddr len;
         void *map;
 
+        /* TODO: a common DMA map SG helper */
         do {
             len = l;
             map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
@@ -921,20 +925,27 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
             if (!map) {
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
                               " element %d\n", __func__, e);
-                virtio_gpu_cleanup_mapping_iov(g, *iov, v);
-                g_free(ents);
-                *iov = NULL;
-                if (addr) {
-                    g_free(*addr);
-                    *addr = NULL;
-                }
-                return -1;
+                goto err;
             }
 
             if (!(v % 16)) {
-                *iov = g_renew(struct iovec, *iov, v + 16);
+                struct iovec *new_iov;
+                new_iov = g_try_renew(struct iovec, *iov, v + 16);
+                if (!new_iov) {
+                    dma_memory_unmap(VIRTIO_DEVICE(g)->dma_as, map, len,
+                                     DMA_DIRECTION_TO_DEVICE, len);
+                    goto err;
+                }
+                *iov = new_iov;
                 if (addr) {
-                    *addr = g_renew(uint64_t, *addr, v + 16);
+                    uint64_t *new_addr;
+                    new_addr = g_try_renew(uint64_t, *addr, v + 16);
+                    if (!new_addr) {
+                        dma_memory_unmap(VIRTIO_DEVICE(g)->dma_as, map, len,
+                                         DMA_DIRECTION_TO_DEVICE, len);
+                        goto err;
+                    }
+                    *addr = new_addr;
                 }
             }
             (*iov)[v].iov_base = map;
@@ -952,6 +963,15 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
 
     g_free(ents);
     return 0;
+
+err:
+    virtio_gpu_cleanup_mapping_iov(g, *iov, v);
+    *iov = NULL;
+    if (addr) {
+        g_clear_pointer(addr, g_free);
+    }
+    g_free(ents);
+    return -1;
 }
 
 void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,

-- 
2.55.0.543.g5ebe2ebe4ea8


