Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF26C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypMc-0005kW-Er; Tue, 25 Aug 2026 07:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypM7-0005RP-Br
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypM5-0006OK-Jc
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMCTKyk0xQSP+sGGG4Le4qa2X56Rh718aiy0BaZdxzo=;
 b=aB7kg35lzB9wUQv/cLhcKRTk6PYuDuN5kv0IdhHIGOdGUMrTnRW0An7dHjPL42jL9GJAm2
 eGppnWj+jDY/nYL2C0zlcgEXK6Q5ZTkqwge3vmHW332/OlY1WRAsCWM4tDSSDHhxs9lK8a
 0yrOazoS58iBTN6wtNoKrOweF8P4x+8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-RiYze-_eMOmRhcirdBau9Q-1; Tue,
 25 Aug 2026 07:30:09 -0400
X-MC-Unique: RiYze-_eMOmRhcirdBau9Q-1
X-Mimecast-MFC-AGG-ID: RiYze-_eMOmRhcirdBau9Q_1787657408
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BC091801337; Tue, 25 Aug 2026 11:30:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF78018005B3; Tue, 25 Aug 2026 11:30:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:05 +0400
Subject: [GIT PULL 15/19] hw/display/virtio-gpu: Propagate udmabuf errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-15-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4616;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tskiFGwxTjjrGkMNH6cShz4T8hqExo7Om4UviQ1KgG8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrV5C/n9i+XbGnT0kHILqkutpU1qvzJGdNSV
 ZucrbaDNYOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161QAKCRDa6OEJdZac
 5cOoD/9QDaXpzhSMF7HMp7aSHTsHZH6+q11u1OBig346tz8smuRbEERPA9PwZwRTlrGulhWdvED
 VMY8ZXkQ8MT1OlngvheAZetH3gW8Wsir/KDdY/Cg16P9+w3IpOaRVQFjnJTcFBopU6+nF0K9fJq
 H2vJSBa96Wq0j9QC8p3VCwSxJH36U9FeRU9zZkwSBcSjGKzoX+CrcKvN9zDvL+BxrlFgGdQ0U9k
 OfVbyBqgOThb39tDIp0wiIMOzruZA8+JGWi7EcaJrOms/E/oHzRv+MaNN63ZRE2phJmrzw6IW3E
 hQ706AwYVb6isuhtiLGV79bp46FrRZL7Y5so2zQocHPGhaOTp5hxHYmGn2IUjLphtYsPG7k7mDK
 T5j/OA54dgyIaE5SxpcuPLyvWoRUjtuqLmOwEpXqoStc8JkHjGAxtkWgWu95RwM1TDXnjajwMU3
 zw0tZzELIRHLp8SyJtDk3dQmdYZ8GvjgmAhnyTcRq6ch6JJU3kPVnZR4Gz/g7Jojac2v+DhtPFq
 EBz1vzd+lFyoVtIBa+r4wRM9ZdbA3zPAg9yOGRIdNWvQdKXq/EDvz0Ln6A5sAfggYJVId+4bcv7
 M2mrnVOCxmJr5rb7sI1MKRwhu2pVMCTZbS8D6l2BdFE3kS2dPteBUfC40iIqRTGZu2DCk/mRiwh
 eqC3kmXHV4ahFUQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Propagate udmabuf errors so that the requested operation will be
canceled instead of producing an incomplete result and the user can
notice the failure.

Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Fixes: 4ae1c5c7d6f3 ("hw/display/virtio-gpu: Initialize blob mapping for ATTACH_BACKING")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260825-dmabuf-v2-3-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-udmabuf-stubs.c |  3 ++-
 hw/display/virtio-gpu-udmabuf.c       |  8 +++++---
 hw/display/virtio-gpu.c               | 18 ++++++++++++++----
 include/hw/virtio/virtio-gpu.h        |  2 +-
 4 files changed, 22 insertions(+), 9 deletions(-)

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
index ba02ba9e8616..c230509852ff 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -131,7 +131,7 @@ bool virtio_gpu_have_udmabuf(void)
     return memfd_backend;
 }
 
-void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
+bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     void *pdata = NULL;
 
@@ -142,17 +142,19 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
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
index 50c4dcd408bb..7f3301a9ac57 100644
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
@@ -1045,8 +1050,9 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         return;
     }
 
-    if (!res->image) {
-        virtio_gpu_init_udmabuf(res);
+    if (!res->image && !virtio_gpu_init_udmabuf(res)) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        virtio_gpu_cleanup_mapping(g, res);
     }
 }
 
@@ -1558,7 +1564,11 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
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

-- 
2.55.0.543.g5ebe2ebe4ea8


