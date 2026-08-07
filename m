Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369BBC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD0b-0007ok-Jx; Fri, 07 Aug 2026 01:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wsD0a-0007nx-Jz
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:20:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wsD0W-0000PV-S7
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:20:40 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6775KGOQ002853
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Aug 2026 14:20:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=v0puGW6cv/bqG3r5MU+ncqROmryZCJf16fjc/EC9je4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1786080024; v=1;
 b=Z8IJbwUK5fwtnh2NpNhK0/KgPNd3yapXcCbaw33n8FgxG1xN5CSRXnWVNkWXCk/c
 RFl9YL+qI04cuFbsNfRbmRtBHYieu3iITETFbF0ti4ILHr4m45ZGQ99n9mFUO9ML
 eeQT3fLKH13wogkr9oz4pZKPS27Oh0hWKIuaIJHUII48sKGOiGMMFi8MLmQqldT9
 CB4NyZzshmB7J/7TdjE4R/E1/WNU8LsSVFvMmHC6k4KmJNyykbh6S2vR98SOgDvn
 vB1x2dLO3RN3YsYdEzY/oIjNur8gIeXnlr8LoOthDkIeqIvtMPvnabuFgwxsbur4
 vRKyZOdj6vv1gZeY6G1cyQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 07 Aug 2026 14:20:06 +0900
Subject: [PATCH 3/3] hw/display/virtio-gpu: Propagate udmabuf errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-dmabuf-v1-3-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
References: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4223;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=RQTjTbwCzx9uh4qvfYCzSpRPd91h2SU8LWD2vO6zTCY=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1Zptsiln2su/um0fhxWYt7VxdD9rifAwyd1ovPqIouvD
 38mLt3fUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMBGJp4wM72RtvLjqcys/MIly
 sS1RujD1erpZx/2tzv+XmhvFr5z6juGv6K3AE6/Wll7IfbLqzJO1VcVfV9S+/frfKI49/8CqUkU
 nPgA=
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

Propagate udmabuf errors so that the requested operation will be
canceled instead of producing an incomplete result and the user can
notice the failure.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/virtio/virtio-gpu.h        |  2 +-
 hw/display/virtio-gpu-udmabuf-stubs.c |  3 ++-
 hw/display/virtio-gpu-udmabuf.c       |  8 +++++---
 hw/display/virtio-gpu.c               | 18 ++++++++++++++----
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 220231ec9d43..69b5ee2e382f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -388,7 +388,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
 
 /* virtio-gpu-udmabuf.c */
 bool virtio_gpu_have_udmabuf(void);
-void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
+bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
 void virtio_gpu_fini_udmabuf(VirtIOGPU *g,
                              struct virtio_gpu_simple_resource *res);
 int virtio_gpu_update_dmabuf(VirtIOGPU *g,
diff --git a/hw/display/virtio-gpu-udmabuf-stubs.c b/hw/display/virtio-gpu-udmabuf-stubs.c
index 85d03935a332..0883bf05fac1 100644
--- a/hw/display/virtio-gpu-udmabuf-stubs.c
+++ b/hw/display/virtio-gpu-udmabuf-stubs.c
@@ -7,9 +7,10 @@ bool virtio_gpu_have_udmabuf(void)
     return false;
 }
 
-void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
+bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     /* nothing (stub) */
+    return false;
 }
 
 void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 0377a9bcb406..399b71c9c4fb 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -128,7 +128,7 @@ bool virtio_gpu_have_udmabuf(void)
     return memfd_backend;
 }
 
-void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
+bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     void *pdata = NULL;
 
@@ -139,17 +139,19 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     } else if (res->blob_size) {
         virtio_gpu_create_udmabuf(res);
         if (res->dmabuf_fd < 0) {
-            return;
+            return false;
         }
         virtio_gpu_remap_udmabuf(res);
         if (!res->remapped) {
             virtio_gpu_destroy_udmabuf(res);
-            return;
+            return false;
         }
         pdata = res->remapped;
     }
 
     res->blob = pdata;
+
+    return true;
 }
 
 static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6bd87d900170..f901eb34f184 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -383,7 +383,12 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
             return;
         }
 
-        virtio_gpu_init_udmabuf(res);
+        if (!virtio_gpu_init_udmabuf(res)) {
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            virtio_gpu_cleanup_mapping(g, res);
+            g_free(res);
+            return;
+        }
     }
 
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
@@ -1025,8 +1030,9 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         return;
     }
 
-    if (!res->image) {
-        virtio_gpu_init_udmabuf(res);
+    if (!res->image && !virtio_gpu_init_udmabuf(res)) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        virtio_gpu_cleanup_mapping(g, res);
     }
 }
 
@@ -1538,7 +1544,11 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
                 return -EINVAL;
             }
 
-            virtio_gpu_init_udmabuf(res);
+            if (!virtio_gpu_init_udmabuf(res)) {
+                virtio_gpu_cleanup_mapping(g, res);
+                g_free(res);
+                return -EINVAL;
+            }
         }
 
         QTAILQ_INSERT_HEAD(&g->reslist, res, next);

-- 
2.55.0


