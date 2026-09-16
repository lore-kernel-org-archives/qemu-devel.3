Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51E8C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lbM-0008M7-4U; Wed, 16 Sep 2026 05:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lbK-0008Le-Ih; Wed, 16 Sep 2026 05:06:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lbI-00070Q-8l; Wed, 16 Sep 2026 05:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549558; bh=+gzfoz3x3bDrUody7yIvT4bORUvW2sx+TMx20Vu8V90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bSLYG43ktLm2EXavob/lgXi/ERe1x6Jsra7U4MjutmigdgwPEsj+Zal7E5YQiwlEM
 aO7RniWvCTusIe3l6NRbpL0FIbD5K66km3RL5Efp81zvsg4kUR8CdPQ5DvPcyvMCYv
 UoTbdjx11jUp6QunShkJhWyW8LbHNr6o1oX8SCyYQnr5c+8epenUn5fMCjTtxIQmeo
 Xc/gSdir7yOKHsWP4diVo1H5NY01+MKpZXtOElxJrN+nU/TZy6t6QImerKw2Pz8MCo
 V+MpPY7542fYL49VHmRa8Ov1/Mq+NlgBut1+ucnHfFwVRSeQhZ5Nriy92z+ysGVWJ+
 FkvCgMXYUlJ6g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 66BD21D56B6;
 Wed, 16 Sep 2026 12:05:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 12408429DFE;
 Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0689F5A75D; Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 02/57] virtio-gpu: use g_try_malloc to avoid
 guest-triggered abort
Date: Wed, 16 Sep 2026 12:03:26 +0300
Message-ID: <20260916090516.677749-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failure
returns an error to the guest rather than crashing the host (glib
behaviour).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260805130141.211398-1-marcandre.lureau@redhat.com>
(cherry picked from commit eb2b3a1fa807f47515a1d86e434c60c981310bcd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index 78648815093..933bdbb671c 100644
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
index 550fd03bf5c..20bae57d0fe 100644
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
index 710d5452977..e2d8385fd85 100644
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
index fd55656c114..8f12290f188 100644
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
index 20884f397e9..b1519254582 100644
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
index 789b7e3e9b7..b3ca806e2cb 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -621,7 +621,11 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
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
index 01675c87deb..d6f83da852a 100644
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
2.47.3


