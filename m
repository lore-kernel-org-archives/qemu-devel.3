Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA724FCC062
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybCN-0004Bd-UB; Fri, 06 Mar 2026 14:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCL-00049Y-Ha
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:57 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCG-0000Pt-OL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:56 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso3880502f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826651; x=1773431451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6hymyS/XV95BcDo7HFmoPR2rakOhmcWotYixkOfleY=;
 b=Z8yPgVtkfllI05/0PiXSnxd3Y2fA19sDaXNuZc6T+o1ROPMRv642WVWjeBrqGn0QSx
 dFydUl+nBUE4Qpl9Hjg2ejC2pu2J/Vkh1sGyi2i5ZZ+EPfAhJOWHemVbPHqtE3JKWIC4
 BErc+XptwWt5PpLq++R7wSgjZf1djbbtLQ9k1GtAjTbkxL6ph1+fAIs4EWfVUJi0Twlg
 pHQiKyoU5UVEXLVku83DmYZ6C5ev2jfUAq5ga2OVwX9+/LCyZ/bMN233pUIe15E4Xgmn
 +QePpDELTLM0S2GYVjfH4NOYQCTMJAA1AhEueQ0lQbnconMkz1FAmdcJgqOnJpYQFlSf
 ADwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826651; x=1773431451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E6hymyS/XV95BcDo7HFmoPR2rakOhmcWotYixkOfleY=;
 b=o0H2Yi7TaixQKBXoMAX4PhgZMwuJHulSN1YBp6AlulvEvwZhqb+/J31x2NJjAgcLl1
 REKz6mE1i0rHBLk5F2WkS/AEpjxNa0JRlqNz4OdeEzVKXI4YmlrLSKmkvbk8DAFLi63K
 SuiJu3qNWGfN9Ln5rC4GKSyZVZB8a1jekmQlaeeEP8kN0E0R9W2PbjT/OSO00PAuvMlw
 Lc1vGwX3WsvRJ69cDRBnMTPaAINJ+3ubej6I3umM3Mh8+at1P0NsMb93VpPARv6506LP
 8HGWWzEFOe/QKGeNcmGAjHsNl/67bH3Frnp6ZcGbSwm3SO+YFtw6DvF72tkPcsti3dch
 TBPw==
X-Gm-Message-State: AOJu0YzenTDUp1NnFzykBQ+8rv7DRl6PfAPX0HBelxKrBUd2ee0+KNL4
 +4a4+fcWSW6zmfBxs/VxsZUF59zc7H8r+yskHoeDTpAfsU86p/6T3i4RvEotJtLRg9k=
X-Gm-Gg: ATEYQzzqOLGlvo5V1nNejan7n4FTq4D9MTFVWQxwxKSa0agF7AtIK1/+k8BoYlwQsBB
 D0YBnTWnwYny/CoWjVaX4IJqyVy1Z+Waoe95WQeS3Q/98pRDM/H16GS4qpvGa58oEuR8tN1oMN7
 m1OmWYc4nX0umBmruEdWTKWPGtJmB7CCFOCgf4NNfM+POhAyXPdAlNur+iMHSl6VDZXKJbs9Edw
 xoxPqYHyzqEMMl7UpHRHlfEokr47xljK+TkHnnWdxORVMV06qzdDRePuqdLRQ2Vj0QVzECMbd0Z
 SqiGRHwkxRHt4T4GrrWUBcwUMtVkr4rhv8B7kMgt5v+Frh6ITDvs3KcAL3Gj/G+LPDCcpHUNsZo
 59P4UPUCsNYAE2pXx18+mqJ2ey11UJiMIMf29AKdBSiGELB4NS7nkWUIttcgjchAsVCxrO6YBZP
 ULnWgU9L3TNfnFl7wb2bSJ3PI=
X-Received: by 2002:a05:6000:2410:b0:439:c20e:5ed1 with SMTP id
 ffacd0b85a97d-439da5555f2mr6091522f8f.12.1772826650675; 
 Fri, 06 Mar 2026 11:50:50 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2bdf8sm6206702f8f.25.2026.03.06.11.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C816689D1;
 Fri, 06 Mar 2026 19:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PULL 02/20] virtio-gpu: Fix scanout dmabuf cleanup during resource
 destruction
Date: Fri,  6 Mar 2026 19:50:29 +0000
Message-ID: <20260306195048.2869788-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Dongwon Kim <dongwon.kim@intel.com>

When a virtio-gpu resource is destroyed, any associated udmabuf must be
properly torn down. Currently, the code may leave dangling references
to dmabuf file descriptors in the scanout primary buffers.

This patch updates virtio_gpu_fini_udmabuf to:
1. Iterate through all active scanouts.
2. Identify dmabufs that match the resource's file descriptor.
3. Close the dmabuf and invalidate the resource's FD reference to
   prevent use-after-free or double-close scenarios.
4. Finally, trigger the underlying udmabuf destruction.

This ensures that the display backend does not attempt to access
memory or FDs that have been released by the guest or the host.

Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-ID: <20260304203230.1955266-1-dongwon.kim@intel.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 58e0f91fda6..65312f869dd 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -357,7 +357,8 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
 /* virtio-gpu-udmabuf.c */
 bool virtio_gpu_have_udmabuf(void);
 void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res);
+void virtio_gpu_fini_udmabuf(VirtIOGPU *g,
+                             struct virtio_gpu_simple_resource *res);
 int virtio_gpu_update_dmabuf(VirtIOGPU *g,
                              uint32_t scanout_id,
                              struct virtio_gpu_simple_resource *res,
diff --git a/hw/display/virtio-gpu-udmabuf-stubs.c b/hw/display/virtio-gpu-udmabuf-stubs.c
index f692e135103..85d03935a33 100644
--- a/hw/display/virtio-gpu-udmabuf-stubs.c
+++ b/hw/display/virtio-gpu-udmabuf-stubs.c
@@ -12,7 +12,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     /* nothing (stub) */
 }
 
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
+void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
 {
     /* nothing (stub) */
 }
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d804f321aa3..74b6a7766af 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -151,13 +151,6 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     res->blob = pdata;
 }
 
-void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
-{
-    if (res->remapped) {
-        virtio_gpu_destroy_udmabuf(res);
-    }
-}
-
 static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
 {
     struct virtio_gpu_scanout *scanout;
@@ -169,6 +162,26 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
     g_free(dmabuf);
 }
 
+void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
+{
+    int max_outputs = g->parent_obj.conf.max_outputs;
+    int i;
+
+    for (i = 0; i < max_outputs; i++) {
+        VGPUDMABuf *dmabuf = g->dmabuf.primary[i];
+
+        if (dmabuf &&
+            qemu_dmabuf_get_num_planes(dmabuf->buf) > 0 &&
+            qemu_dmabuf_get_fds(dmabuf->buf, NULL)[0] == res->dmabuf_fd &&
+            res->dmabuf_fd != -1) {
+            qemu_dmabuf_close(dmabuf->buf);
+            res->dmabuf_fd = -1;
+        }
+    }
+
+    virtio_gpu_destroy_udmabuf(res);
+}
+
 static VGPUDMABuf
 *virtio_gpu_create_dmabuf(VirtIOGPU *g,
                           uint32_t scanout_id,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91ca2a7..b2af861f0d8 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -902,7 +902,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
     res->addrs = NULL;
 
     if (res->blob) {
-        virtio_gpu_fini_udmabuf(res);
+        virtio_gpu_fini_udmabuf(g, res);
     }
 }
 
-- 
2.47.3


