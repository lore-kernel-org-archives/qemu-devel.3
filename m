Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D80EF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpX7-000760-95; Wed, 04 Mar 2026 11:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpX4-00073w-Nn
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:57:10 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpX1-0003xY-9H
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:57:10 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-65b9d8d6b7dso11658598a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643421; x=1773248221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8JBFWACv1j8RnRNzU3WVG0i9zfzm4NzlWXfncEOBU0=;
 b=FqPHkR52C45AR0KXKYV9yOYNTH7Teb+T1xHjfHP8DPGLO+8qquYR8A2V2wtUVxbfjs
 +PDd+YU+PPDuZQV+kkEHdrMybUNcFw8fy3BugF2a6/NVs9chN/7nVaQVmodjYYIgEI2l
 K6KSYHAxqC1XcUfX0vIIpDwLErRivFZyl9Dgjd6M7SvIedJp+XquCnVTU8SGlpfhzbq1
 J5gTjci1hbph9vgytWpdIuPaApz0UVIHuhQnbpRp/zZ1+ywN8Rf8pkZS94ON6lbVugIV
 27ob4z3EwOa/Gkv3wvfKt6s4fNk8GIXDZuB8lMOYSVqjqZBumV8KniMYrBTvBkNkdlZK
 F1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643421; x=1773248221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+8JBFWACv1j8RnRNzU3WVG0i9zfzm4NzlWXfncEOBU0=;
 b=esSPfuE5HZqTldDx4kBCeC99UFHjGnd8ubj8U/Irvh06wi/AXDSnxBILM1pownHQ33
 QHBYBp6nqYO+RKwzj++fvclAL/yGIiapqL1PgRszxNN3YaJZjdmPMqqrvogsDnaOg2Dz
 LGztGu9ZBezeUqoaUnK/oYpWfUZwn0qtSrleDyLK+zUFTDR34CBGPzPyePKZiUaKZaWw
 9X4f1/7RBQwTP5TCGKAxFsTnlmJzFqEwRCgLl2sSejQ+cVWout2X/f5fdjf7c4nPjdiN
 aFj9b8R4gx3zuis7hSjO/PwfBecIGdC2wgifYWMbiuEbA3DWP/sOtfuapCoV3ZzhgK5p
 fHkA==
X-Gm-Message-State: AOJu0YxFXeCiATB2pOkFi4wFpbfOcz7+wq85VapMQb1rVj0iVYzj2jvu
 w+wYfdWV+1Q2T6Yij0Rp7ywNST3Hg8HSgaGlOqQr99C5k7WV5bd1ENFmJxYiZ9PaIvwmNh5EFAB
 nNN7v
X-Gm-Gg: ATEYQzxhA0I3Zcq+jMrwphhyVAtavvHObYptviB9bH3or1V2lfjbPc0EGkWWcijakje
 FkJWvY+bb0NIsronlyFta5wmqLq7tSkHVIcTpbPyzqf+CKEGDehE10u3DHZns+gjqD762+LDsJJ
 8q2z0P4MiPkZ8YboNQnFxrAUOPl91G6pZN/JBQzJWn1PbirCuPQo98Vi4Fw7Y7puo+g3vSzkuVm
 i4YoBDgXiGAUaVVpiCgiX8SX5wZkFmPHPPwE9yBE+JtrEki8ZF+g5yCls4rvHfGcNQE8x/xnkbQ
 tZ6OyS8X46FKbFqgiJ8+YY3vobWimoFJoFZi5yXIGL6W3vsi5eiz7mpVPNVPg6TS8lnA+qpAkkz
 IUZJ2qbA9DJSQf6YIl6n1hYyQ5bdPlpIuQucu35uN2KJn7eKATLVLwJjXmg26zVNozbZIUnO9na
 UUr7DFH6L6GXVOXVreAKUEAMg=
X-Received: by 2002:a17:907:6d2a:b0:b8a:f9d7:1afe with SMTP id
 a640c23a62f3a-b93f159304bmr147707566b.57.1772643421094; 
 Wed, 04 Mar 2026 08:57:01 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ae6132asm773379966b.32.2026.03.04.08.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:57:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5683062D9E;
 Wed, 04 Mar 2026 16:50:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 18/20] virtio-gpu: Replace finish_unmapping with mapping_state
Date: Wed,  4 Mar 2026 16:50:40 +0000
Message-ID: <20260304165043.1437519-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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
---
 hw/display/virtio-gpu-virgl.c | 28 ++++++++++++++++++++++------
 hw/display/trace-events       |  2 +-
 2 files changed, 23 insertions(+), 7 deletions(-)

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


