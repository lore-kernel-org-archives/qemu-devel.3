Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5776FCC068
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybIl-0004sZ-JO; Fri, 06 Mar 2026 14:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybId-0004rI-Bm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:57:28 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybIa-0001Wr-J6
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:57:26 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439c4a93841so2772002f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772827041; x=1773431841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/UXjFf9Bz2RP8j5199U69kamuhlHWXflthUc5X+lt0=;
 b=OCJnQaJ5ViR3bt7gsbwh+ywJW/KFPdraSrKkYoqlKsY5T1PmZZTidy+pj0vGjK+di+
 VM+Gc59BNlm9o47+Ebj8GJwsQjQnVHUOSxXdbR5/M1b3OE9wTn6NKA14JG5H8vI5Uvx9
 K/cK2BcW49KbHUkdoV6jO46w9flP8K+H+EbQ8GOknbBOapT0xQV1/g3xfbgQx3eDW/kn
 M+kbufW5Ddo9gm00AwNSsIZ3BkMd1vylQlPLQIRdO71K3Kv1na8xB5xbs8vDlJiXttGI
 ReOwO977cxKG7H8s5o5aTtKJuG11C+9nuJMmEVHjvgHPt6UucihYwduPRt/9N7fkxCjM
 be4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772827041; x=1773431841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G/UXjFf9Bz2RP8j5199U69kamuhlHWXflthUc5X+lt0=;
 b=GyovMym3YhmKdc1X98pMlnzNR+iBb5/y4MWLMTnAOZrqea5lAFCnahZH+Hck/sKSWA
 UV3UTmEXImhUwqwMiouBcUByEkpmqqfZgTz6ymZkGqjeMX4ckbSn9UljBdpv53buNz8D
 Q769TeeLyyQ92HtESodYWtRGWR1wlgYtuY2PjHUjq5hZiDR1NwpFFljERppZfuncnQOy
 s+9xWknvRr4xxk+6K8HeG3fAlpqGWaH4wHGgaZfBKsqRXjluROj6DGy/UJw+3SnJP8AE
 9sKCjVqJa/6lWFPMIneYE8wHfxbHoSvpGPAuld4m4EeYCb1SaR65WYH6M0Vb+da167IT
 7fmQ==
X-Gm-Message-State: AOJu0YzoCWW18o4OeVo+eGPPxGHWSq4/7rnWXQ3U/Am7Vxy5KvJ994u8
 0ODr6ZnN4/rUbusHENuiYqBUssvPlNB0simijycwBFAj8r6qEu2/O0lE9yprgsUjpdA=
X-Gm-Gg: ATEYQzyajWzi3NgmMZH/caEcPy878BKZet1EM+/3XKBLLquV2p8df2O95+lQaqVDqGV
 G9css8WMrUycBzOx+jMvHWFm48r0rZejrN/bTqGLNmcft9hMoY4yb7178VX6lcMLJcVm5d7EPbs
 ZPdmd0HUSKQP/EXGgEzlTd4WPnFcN+8FwgAOf+aHiiTPMs/JLcN0S2NbTHbzOHV9BjJTjmazYhX
 k+JDY3e9wQtkYVT0O3lCAR4CF+IIeYiPRuU/gT9SiIEhah1hWujqumngF6bLVPqclXa5OSVFnzD
 2Lpa9AKl/23FfksS7ALaXdCQtzf4Q954zc5qW4xla3mjqAQ3CXmqXZy3cdutTGYb9uANY0ZQe8F
 vParfi6Rd1f1GAhCTMh8V2JMrRgoX5H4QSNOyRm3bUisy8LTV0h0BjlHgzN1V2wUf+rq6EG+pOd
 KuQWEvU8FKc72SU9QvsPWSj0M=
X-Received: by 2002:a05:6000:400e:b0:439:b0ed:2afe with SMTP id
 ffacd0b85a97d-439da348192mr5251923f8f.11.1772827041166; 
 Fri, 06 Mar 2026 11:57:21 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae4b860sm6284687f8f.36.2026.03.06.11.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:57:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B0350689E1;
 Fri, 06 Mar 2026 19:50:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 18/20] virtio-gpu: Replace finish_unmapping with mapping_state
Date: Fri,  6 Mar 2026 19:50:45 +0000
Message-ID: <20260306195048.2869788-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Allow virtio_gpu_virgl_unmap_resource_blob() to be invoked while async
unmapping is in progress. Do it in preparation to improvement of virtio-gpu
resetting that will require this change.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-17-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-19-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f4d1113827e..d1b5162f440 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -68,11 +68,17 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 #endif
 
 #if VIRGL_VERSION_MAJOR >= 1
+enum virtio_gpu_virgl_hostmem_region_mapping_state {
+    VIRTIO_GPU_MR_MAPPED,
+    VIRTIO_GPU_MR_UNMAP_STARTED,
+    VIRTIO_GPU_MR_UNMAP_COMPLETED,
+};
+
 struct virtio_gpu_virgl_hostmem_region {
     Object parent_obj;
     MemoryRegion mr;
     struct VirtIOGPU *g;
-    bool finish_unmapping;
+    enum virtio_gpu_virgl_hostmem_region_mapping_state mapping_state;
 };
 
 #define TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION "virtio-gpu-virgl-hostmem-region"
@@ -109,7 +115,7 @@ static void virtio_gpu_virgl_hostmem_region_finalize(Object *obj)
         return;
     }
 
-    vmr->finish_unmapping = true;
+    vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_COMPLETED;
 
     b = VIRTIO_GPU_BASE(vmr->g);
     b->renderer_blocked--;
@@ -167,6 +173,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     object_initialize_child(OBJECT(g), name, vmr,
                             TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION);
     vmr->g = g;
+    vmr->mapping_state = VIRTIO_GPU_MR_MAPPED;
 
     mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(vmr), "mr", size, data);
@@ -195,7 +202,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
 
     vmr = to_hostmem_region(res->mr);
 
-    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr, vmr->finish_unmapping);
+    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr,
+                                        vmr->mapping_state);
 
     /*
      * Perform async unmapping in 3 steps:
@@ -206,7 +214,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
      *    asynchronously by virtio_gpu_virgl_hostmem_region_finalize().
      * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
      */
-    if (vmr->finish_unmapping) {
+    switch (vmr->mapping_state) {
+    case VIRTIO_GPU_MR_UNMAP_COMPLETED:
         res->mr = NULL;
         g_free(vmr);
 
@@ -217,15 +226,22 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
                           __func__, strerror(-ret));
             return ret;
         }
-    } else {
-        *cmd_suspended = true;
+        break;
 
+    case VIRTIO_GPU_MR_MAPPED:
         /* render will be unblocked once MR is freed */
         b->renderer_blocked++;
 
+        vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_STARTED;
+
         /* memory region owns self res->mr object and frees it by itself */
         memory_region_del_subregion(&b->hostmem, mr);
         object_unparent(OBJECT(vmr));
+
+        /* Fallthrough */
+    case VIRTIO_GPU_MR_UNMAP_STARTED:
+        *cmd_suspended = true;
+        break;
     }
 
     return 0;
diff --git a/hw/display/trace-events b/hw/display/trace-events
index e323a82cff2..4bfc457fbac 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -39,7 +39,7 @@ virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h)
 virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h, uint32_t d) "res 0x%x, fmt 0x%x, w %d, h %d, d %d"
 virtio_gpu_cmd_res_create_blob(uint32_t res, uint64_t size) "res 0x%x, size %" PRId64
 virtio_gpu_cmd_res_map_blob(uint32_t res, void *vmr, void *mr) "res 0x%x, vmr %p, mr %p"
-virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, bool finish_unmapping) "res 0x%x, mr %p, finish_unmapping %d"
+virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, int mapping_state) "res 0x%x, mr %p, mapping_state %d"
 virtio_gpu_cmd_res_unref(uint32_t res) "res 0x%x"
 virtio_gpu_cmd_res_back_attach(uint32_t res) "res 0x%x"
 virtio_gpu_cmd_res_back_detach(uint32_t res) "res 0x%x"
-- 
2.47.3


