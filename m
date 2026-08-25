Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA7AC61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylbv-0005Hc-MD; Tue, 25 Aug 2026 03:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wylbt-0005G9-1E
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:30:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wylbq-00026q-Dh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:30:16 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67P7TsR4057787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 25 Aug 2026 16:30:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=E4hfWxBm6wqd5SXrXy04REShDseQ3XN91pTMGVvRSV0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1787643003; v=1;
 b=vu+itbHBngqEP8DVtN471B0gCLwN9O1/D748va4GvOiPo07eEJXwEtiX2cmXPn0a
 dbW1okFS1uE1F070PcoS0tSlqf60iDrwZ7k53rQn9HKAnE3P1lrMGbSoRDembypC
 IG3t1tENoJdcXYURbs1P2kmo+B+l79dcKQZYYZZYQnfrZ8kLIXjvo5qFuaEsmyXO
 xnmCbvhI6G23Tcm4sOml0Ptj1X7825m2C7It9QA0ots1f4G+eGXNn0dDUjHb3SNX
 2XvPNTuobHL+Ye3Zg+AHWoHzOe/4LfJEnZajq6nD9do5O8bolCCXlt7I0EO+8tLS
 RiE248scQHf1FSkD7O4lnA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 25 Aug 2026 16:28:47 +0900
Subject: [PATCH v2 1/5] hw/display/virtio-gpu: Avoid creating empty udmabuf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-dmabuf-v2-1-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
References: <20260825-dmabuf-v2-0-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825-dmabuf-v2-0-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=5355;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=mKLvuCDlxGKxhjP68r0N13Lt+Y4djUit3/oL3/Aua9o=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1avS+mRL3MefziXPOv2nqSMjW3Trc78XnjojuzR9dcXl
 JR8t2ZM7yhlYRDjYpAVU2RJKdrNrRFd+6kwIb4FZg4rE8gQBi5OAZjITwmGf5p7r/+R0jqZt1XH
 7sF0mYZNF7kzmKXKfhVuztbn+/HzcDMjw4KvDXai3u0ZdczPdiXG/tV+1OShGK/X7LdLaMrnS5v
 WMwIA
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

Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 94 ++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index fbb6fec7a0ad..ccfc1814d514 100644
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
+                          "%s: backing storage smaller than blob size\n",
+                          __func__);
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


