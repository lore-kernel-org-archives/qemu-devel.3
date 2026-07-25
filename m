Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F2CC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 19:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnhwB-00019t-Bx; Sat, 25 Jul 2026 15:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnhw9-00019a-HH
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 15:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnhw7-0006gP-59
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 15:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785007285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1SG1k7ljUeh2tl+SR1D86CRQVo1BsP4xiodUwPTlXPY=;
 b=HIZfbTvmBlgyhOup/LLDDgzdb+nSsw4JfVrgrmx3FUL/PRXhdie91/eZ3RWDPTHMt7CutF
 9LU255jqtiP8ryeCrqmZI9CDGoNtYHMGOfsY8geORJydVDqg6NBBZ1Su+byaq+vOUrgcvI
 0j6U1UHJ4RuLHfqRolYe0npykJ49zJg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-kUs-0GmAPaWsabnO4NcC8Q-1; Sat,
 25 Jul 2026 15:21:23 -0400
X-MC-Unique: kUs-0GmAPaWsabnO4NcC8Q-1
X-Mimecast-MFC-AGG-ID: kUs-0GmAPaWsabnO4NcC8Q_1785007282
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB7C918001D7; Sat, 25 Jul 2026 19:21:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C3AF30001A2; Sat, 25 Jul 2026 19:21:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com, mst@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH] virtio-gpu: use g_try_malloc to avoid guest-triggered abort
Date: Sat, 25 Jul 2026 23:21:16 +0400
Message-ID: <20260725192116.291685-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failure
returns an error to the guest rather than crashing the host (glib
behaviour).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 25 +++++++++++++++++--------
 contrib/vhost-user-gpu/virgl.c          |  6 +++++-
 contrib/vhost-user-gpu/vugbm.c          |  5 ++++-
 hw/display/virtio-gpu-rutabaga.c        | 14 ++++++++++++--
 hw/display/virtio-gpu-virgl.c           |  6 +++++-
 hw/display/virtio-gpu.c                 |  5 ++++-
 6 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index ee9858c397ce..3d9c103ff88f 100644
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
+    if (!ents) {
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
+    if (!*iov) {
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
index 550fd03bf5c4..a9d22bb0fdd9 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -209,7 +209,11 @@ virgl_cmd_submit_3d(VuGpu *g,
         return;
     }
 
-    buf = g_malloc(cs.size);
+    buf = g_try_malloc(cs.size);
+    if (!buf) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+        return;
+    }
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
     if (s != cs.size) {
diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vugbm.c
index 710d54529779..c05e3fd31746 100644
--- a/contrib/vhost-user-gpu/vugbm.c
+++ b/contrib/vhost-user-gpu/vugbm.c
@@ -13,7 +13,10 @@
 static bool
 mem_alloc_bo(struct vugbm_buffer *buf)
 {
-    buf->mmap = g_malloc((uint64_t)buf->width * buf->height * 4);
+    buf->mmap = g_try_malloc((uint64_t)buf->width * buf->height * 4);
+    if (!buf->mmap) {
+        return false;
+    }
     buf->stride = buf->width * 4;
     return true;
 }
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index e28aad94eead..c2a0babd47bf 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -360,10 +360,20 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
         return;
     }
 
-    buf = g_new0(uint8_t, cs.size);
+    buf = g_try_new0(uint8_t, cs.size);
+    if (!buf) {
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
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index d9e5b0110497..52f6dcf5d24a 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -615,7 +615,11 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
         return;
     }
 
-    buf = g_malloc(cs.size);
+    buf = g_try_malloc(cs.size);
+    if (!buf) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+        return;
+    }
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
     if (s != cs.size) {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 4582444893bf..fed71131f346 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -892,7 +892,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
     }
 
     esize = sizeof(*ents) * nr_entries;
-    ents = g_malloc(esize);
+    ents = g_try_malloc(esize);
+    if (!ents) {
+        return -1;
+    }
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    offset, ents, esize);
     if (s != esize) {
-- 
2.55.0


