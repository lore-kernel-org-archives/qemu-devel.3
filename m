Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85D3C61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypMv-00061f-6f; Tue, 25 Aug 2026 07:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypM0-0005Da-26
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLy-0006Gb-7o
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKaNsru6hkhZt3cN1qHI96LC98GzN1H3C/XNNF5U03Q=;
 b=aQDKf3SxwHwiQe2zojtE5+hphD5jyCQta+mEvGoQCug9woJYkh5eQ3IYfQggpB3uyFDTd/
 JUAFRD5nBmElInTpOoPVaBP61Mi6xmUzHC/Oq6z5xnP9gurNNqwZHEDWaSLWCgfj1x4ElS
 aUiqiCGnWlO2lpt/iBGsNEovRLu4pH8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-sQ1R_VOtOBuWzDu7e0FbXw-1; Tue,
 25 Aug 2026 07:30:01 -0400
X-MC-Unique: sQ1R_VOtOBuWzDu7e0FbXw-1
X-Mimecast-MFC-AGG-ID: sQ1R_VOtOBuWzDu7e0FbXw_1787657400
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE8831954231; Tue, 25 Aug 2026 11:29:59 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 242F71955F0A; Tue, 25 Aug 2026 11:29:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:03 +0400
Subject: [GIT PULL 13/19] hw/display/virtio-gpu: Avoid creating empty udmabuf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-13-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5448;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Wqe+xF+yjNAiBPztDXQ8vnlkBdfrVe6QHG6gLhMbSQE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrVjh8UpAEhcTc7+sIly4FodjH/O2uiyrwdY
 xF+IWgKY0CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161QAKCRDa6OEJdZac
 5aHtD/9RLm4U35xF5YgLNdnqPvgDBzzZnqJU+vIRuqHbul5w94CFV3E5Uok8iFLPq0Idly5/AZz
 puZ78ViQ8q7HcArqGRWLVBUmliqdCRsp1eQD1KRiqAgayEQcWwtc83Yv6WDwORL6lprScjlPTqt
 2u27LGTiD4HCK2i6+xyk4kOnd1QQzK0MG4ko5As0aWgV4+7VXa6rb53m4BeI5bRiezFtEWw16OZ
 SoBVE0bLuQ9kQr6UEy6mmSq/IcBY6+Xh/msihbN8KPhsbA7D24dQqcEgsYXBk7WmMLz0r5IvNE9
 vSUfm8dFYzebJw/hLtPKQ4whWc3aMZAwMCscjJeDpSWp0jQWFfEtKuTPvYf03EJYImtdxDXlzX8
 3tSurIqozjvdxde1QDmwDL4OOzZmhEm0UoTnqWX7Qtzu13KndP+aiLYyOoRn2y0MqoR0LLw66yw
 M7T05zwcXixquoUZuMckdrp3IRR4oHA9pvmtpfMOACWyIQ+jdia99qntcO9/xHXEilyAA2sTv+m
 keTol+dXXUiCNRUx+2JHFcOIWus2AcNEbhhlZVjhO9mbqq/NVS5Q7gYIVuWDmCX9FAxJoa53qRH
 V+nypTBKI7PF3K1LTC/g4jHz3+YptKCtlMp3hPKovuDVoSUUx+nRWD8/31dd4uTBb6vuea0OVNY
 ZCzWaTNspabxN5g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The virtio specification allows creating a blob without backing storage
attached. However, virtio-gpu attempts to create an empty udmabuf for
such a blob. The ioctl fails with EINVAL and emits a spurious warning.
Avoid the invalid ioctl.

Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260825-dmabuf-v2-1-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 102 +++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 49 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9eb010082d0d..50c4dcd408bb 100644
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
+    if (cblob.nr_entries) {
+        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
+                                            cmd, &res->addrs, &res->iov,
+                                            &res->iov_cnt);
+        if (ret < 0) {
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            g_free(res);
+            return;
+        }
+
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
 
-    if (res->iov_cnt > 0 &&
-        iov_size(res->iov, res->iov_cnt) < res->blob_size) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: backing storage smaller than blob size\n",
-                      __func__);
-        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
-        virtio_gpu_cleanup_mapping(g, res);
-        g_free(res);
-        return;
-    }
-
-    virtio_gpu_init_udmabuf(res);
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
@@ -1389,8 +1391,6 @@ static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
         }
     }
 
-    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
-    g->hostmem += res->hostmem;
     return true;
 }
 
@@ -1469,6 +1469,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
+        QTAILQ_INSERT_HEAD(&g->reslist, res, next);
+        g->hostmem += hostmem;
         resource_id = qemu_get_be32(f);
     }
 
@@ -1528,36 +1530,38 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
         res->blob_size = qemu_get_be32(f);
         res->iov_cnt = qemu_get_be32(f);
 
-        res->addrs = g_try_new(uint64_t, res->iov_cnt);
-        res->iov = g_try_new(struct iovec, res->iov_cnt);
-        if (res->iov_cnt && (!res->addrs || !res->iov)) {
-            g_free(res->addrs);
-            g_free(res->iov);
-            g_free(res);
-            return -EINVAL;
+        if (res->iov_cnt) {
+            res->addrs = g_try_new(uint64_t, res->iov_cnt);
+            res->iov = g_try_new(struct iovec, res->iov_cnt);
+            if (!res->addrs || !res->iov) {
+                g_free(res->addrs);
+                g_free(res->iov);
+                g_free(res);
+                return -EINVAL;
+            }
+
+            /* read data */
+            for (i = 0; i < res->iov_cnt; i++) {
+                res->addrs[i] = qemu_get_be64(f);
+                res->iov[i].iov_len = qemu_get_be32(f);
+            }
+
+            if (iov_size(res->iov, res->iov_cnt) < res->blob_size) {
+                g_free(res->addrs);
+                g_free(res->iov);
+                g_free(res);
+                return -EINVAL;
+            }
+
+            if (!virtio_gpu_load_restore_mapping(g, res)) {
+                g_free(res);
+                return -EINVAL;
+            }
+
+            virtio_gpu_init_udmabuf(res);
         }
 
-        /* read data */
-        for (i = 0; i < res->iov_cnt; i++) {
-            res->addrs[i] = qemu_get_be64(f);
-            res->iov[i].iov_len = qemu_get_be32(f);
-        }
-
-        if (res->iov_cnt > 0 &&
-            iov_size(res->iov, res->iov_cnt) < res->blob_size) {
-            g_free(res->addrs);
-            g_free(res->iov);
-            g_free(res);
-            return -EINVAL;
-        }
-
-        if (!virtio_gpu_load_restore_mapping(g, res)) {
-            g_free(res);
-            return -EINVAL;
-        }
-
-        virtio_gpu_init_udmabuf(res);
-
+        QTAILQ_INSERT_HEAD(&g->reslist, res, next);
         resource_id = qemu_get_be32(f);
     }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


