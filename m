Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB14C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD0c-0007p8-HT; Fri, 07 Aug 2026 01:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wsD0a-0007ny-KQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:20:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wsD0W-0000PY-S4
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:20:40 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6775KGOO002853
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Aug 2026 14:20:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/DMFEFks+PFjHP9QG4E1HNwIJgAMVNcHnieMxAdqQS0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1786080023; v=1;
 b=FIaBXwbL6vPvCynAF5fEjB5C4MDWrnB97x7fkhaSSYoXCY22f8uNklzHIgH3pRKu
 0yX0XZ4iovYtmoiHVazKHBhr7If0Bx48tQoJETInT7QtT3mKmNz0QHh44YA9cehl
 /dwmyTKhAQCKUR2a9Dkwf6lw4ii7AN603VRYuPz4fWK4DnzE6s1BuACujynX1cQ/
 FYW/m+bCorXqfU3ZreHN7x1I8Rpoe7GkVPbyhTDquD1MHO7vTOF+csdGTXXjm7WG
 KLCsmEKv8EjVPl1JVpsrQXFGSLFmawF8/KVeRrM7UtbGh6tQESvx2rupetk8ybgh
 BI+euD8caj7UfpbzrQ/w5Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 07 Aug 2026 14:20:04 +0900
Subject: [PATCH 1/3] hw/display/virtio-gpu: Avoid creating empty udmabuf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-dmabuf-v1-1-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
References: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=5139;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=6Wq2ITWtcduknEMJiEZmdGQ+Jh8YXJdb/Pqp4k8Cxi4=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1ZpttBckc3q6gFvW7YKFJvZRFdWNH989tXzKuvLxwkqD
 7Qf/LbrKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmAhDMMN/Z9Wo7rdfrLzubk74
 5ZNrL1T59feTLeG3uEOL/L8oPnV9xciw8Znom6rXFypWhXdN931te8j52IE//x6qz0ksfdPP5X+
 XFQA=
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

The virtio specification allows creating a blob without backing storage
attached. However, virtio-gpu attempts to create an empty udmabuf for
such a blob. The ioctl fails with EINVAL and emits a spurious warning.
Avoid the invalid ioctl.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 94 ++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index fbb6fec7a0ad..6bd87d900170 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -363,27 +363,29 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     res->resource_id = cblob.resource_id;
     res->blob_size = cblob.size;
 
-    ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
-                                        cmd, &res->addrs, &res->iov,
-                                        &res->iov_cnt);
-    if (ret < 0) {
-        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
-        g_free(res);
-        return;
-    }
+    if (cblob.nr_entries) {
+        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
+                                            cmd, &res->addrs, &res->iov,
+                                            &res->iov_cnt);
+        if (ret < 0) {
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            g_free(res);
+            return;
+        }
 
-    if (res->iov_cnt > 0 &&
-        iov_size(res->iov, res->iov_cnt) < res->blob_size) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: backing storage smaller than blob size\n",
-                      __func__);
-        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
-        virtio_gpu_cleanup_mapping(g, res);
-        g_free(res);
-        return;
+        if (iov_size(res->iov, res->iov_cnt) < res->blob_size) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                        "%s: backing storage smaller than blob size\n",
+                        __func__);
+            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+            virtio_gpu_cleanup_mapping(g, res);
+            g_free(res);
+            return;
+        }
+
+        virtio_gpu_init_udmabuf(res);
     }
 
-    virtio_gpu_init_udmabuf(res);
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
@@ -1369,8 +1371,6 @@ static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
         }
     }
 
-    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
-    g->hostmem += res->hostmem;
     return true;
 }
 
@@ -1449,6 +1449,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
+        QTAILQ_INSERT_HEAD(&g->reslist, res, next);
+        g->hostmem += hostmem;
         resource_id = qemu_get_be32(f);
     }
 
@@ -1508,36 +1510,38 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
         res->blob_size = qemu_get_be32(f);
         res->iov_cnt = qemu_get_be32(f);
 
-        res->addrs = g_try_new(uint64_t, res->iov_cnt);
-        res->iov = g_try_new(struct iovec, res->iov_cnt);
-        if (res->iov_cnt && (!res->addrs || !res->iov)) {
-            g_free(res->addrs);
-            g_free(res->iov);
-            g_free(res);
-            return -EINVAL;
-        }
+        if (res->iov_cnt) {
+            res->addrs = g_try_new(uint64_t, res->iov_cnt);
+            res->iov = g_try_new(struct iovec, res->iov_cnt);
+            if (!res->addrs || !res->iov) {
+                g_free(res->addrs);
+                g_free(res->iov);
+                g_free(res);
+                return -EINVAL;
+            }
 
-        /* read data */
-        for (i = 0; i < res->iov_cnt; i++) {
-            res->addrs[i] = qemu_get_be64(f);
-            res->iov[i].iov_len = qemu_get_be32(f);
-        }
+            /* read data */
+            for (i = 0; i < res->iov_cnt; i++) {
+                res->addrs[i] = qemu_get_be64(f);
+                res->iov[i].iov_len = qemu_get_be32(f);
+            }
 
-        if (res->iov_cnt > 0 &&
-            iov_size(res->iov, res->iov_cnt) < res->blob_size) {
-            g_free(res->addrs);
-            g_free(res->iov);
-            g_free(res);
-            return -EINVAL;
-        }
+            if (iov_size(res->iov, res->iov_cnt) < res->blob_size) {
+                g_free(res->addrs);
+                g_free(res->iov);
+                g_free(res);
+                return -EINVAL;
+            }
 
-        if (!virtio_gpu_load_restore_mapping(g, res)) {
-            g_free(res);
-            return -EINVAL;
-        }
+            if (!virtio_gpu_load_restore_mapping(g, res)) {
+                g_free(res);
+                return -EINVAL;
+            }
 
-        virtio_gpu_init_udmabuf(res);
+            virtio_gpu_init_udmabuf(res);
+        }
 
+        QTAILQ_INSERT_HEAD(&g->reslist, res, next);
         resource_id = qemu_get_be32(f);
     }
 

-- 
2.55.0


