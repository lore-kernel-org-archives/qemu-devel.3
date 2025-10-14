Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A60CCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cxa-000826-R9; Tue, 14 Oct 2025 07:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxS-0007vj-Qt
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:47 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxP-00082G-IC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:46 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-62fc28843ecso7852949a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440361; x=1761045161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NoJP0MdnaIgzVa6mb0U/qUkjWQ3CrMo7a6Lc8hlUXFM=;
 b=lZwevKR7jskyYteWRSfABota1x+rNb+2OunhsVYzwPtr/CGpnsGrKEbGxJvsXhHvDl
 rXJwaukhBg/aTGSpHRrOEPdIHQpjWfktRaRZDgNZLePmcFPvzSMts2bJyGfIgZPTcbqI
 0YJ0t0vM+zQ49tFcFpznNqYUMFnkPHTw42YhAJpyH7rfuLz3jgYX/Evn96o90l0PY3en
 w1VykwLTx+lwCniJciQTFJUgZ5e89QvhtsxikcDIXpsr+/Y9IVz/nNjJQahRr/EIOHEs
 scn8noeHh1lZOvYgZR8BVcQ4G1FJXS2mzuYTBHk0aMvE4G5ppbbKtjqO2ynoQ7MkzMvL
 CHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440361; x=1761045161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NoJP0MdnaIgzVa6mb0U/qUkjWQ3CrMo7a6Lc8hlUXFM=;
 b=p1i/Xm+Kn+rB6W1pARjdG4dZxh/AJaPKHy9noz2/gQJXlaoCShUSsmiq3JDc0gRW12
 P2mSOdyxyD2CTPoDlv293YJCd4DrLOAksATRWIuxjt9hT0jYUgwCKlGibGB6Z6RRv6Fn
 5fDrbbHeRV3obrF74sqqKlXxQcxTYzmexjx8IglHQmJcynogKQ5v7kdW0uKP4CgJTZg4
 Pa48Q6Lju0K/Y/8bn4znZjkXhbwEGteUxAworjG2EDN+SPNfaWxNPWTw9Sr7Y775G2Px
 v52j65JScFpJXdffZJmjQ+xbm9sas56Yd/X6aCgUAM/XwH+nItfAGLLUMCF5Ohzf9kZX
 MXSg==
X-Gm-Message-State: AOJu0Yx42VLve17F8OrGaobNZze/+964qpQ3Cv7HDNsNXmrsKb/gR6YB
 T2arH4CZohB/kVCf5t2zhjdRCW7fio+kyyZ37xnKY97Upw+PjPi8GpJt4Tnk7xiGKUI=
X-Gm-Gg: ASbGncvki+xUWbiVH7qz5B0G2OZh6avfxYIA8sDfR7nq62ZAQc9TDD/WL1H/mABPIKk
 3zLdxoqw5YhCT7f/QbzfRruw4lPKYzSQQ4UR1EmjGeroRr4BpXU+UTETCxeDwUhGwxpNehGSaM8
 4+jG1TfAhE1w7ELn/Ez4U/rP0KngWc/8zhl4uDXkdsQS/LJbhMtlGUSMdED5gEF+WD/+epE8Nz1
 fI2ERs2Lp3bi99n3s5K+Ti5utjkPoTnuW8mhpNHSRDzpOUxGWvolBoiMVcFqedPbXTxAX9XFK4k
 91LQBByKi6pL8eSMhLwlUg2lZ2zso4C3VcC+uVysvIjXKR/3+ffioHI34T1o+lTYcEaiFYO3TjB
 YJ7WOnCTWFIqhvoZ5btctR7iiWd6fSagZFWcBgPSX8ExEDg==
X-Google-Smtp-Source: AGHT+IEEf0cmj0UjYmzy09K38Axqy31HrXext/x0fJxlbgQTyvwc8uEMlOwEx0k6w0wT5tHLXSOefQ==
X-Received: by 2002:a17:907:9448:b0:b40:a71b:151f with SMTP id
 a640c23a62f3a-b50ac1c4e7cmr2772602866b.30.1760440361138; 
 Tue, 14 Oct 2025 04:12:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d9525bd1sm1119289266b.81.2025.10.14.04.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:12:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8456E5F9F7;
 Tue, 14 Oct 2025 12:12:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 5/8] hw/display: re-arrange memory region tracking
Date: Tue, 14 Oct 2025 12:12:31 +0100
Message-ID: <20251014111234.3190346-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014111234.3190346-1-alex.bennee@linaro.org>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QOM objects can be embedded in other QOM objects and managed as part
of their lifetime but this isn't the case for
virtio_gpu_virgl_hostmem_region. However before we can split it out we
need some other way of associating the wider data structure with the
memory region.

Fortunately MemoryRegion has an opaque pointer. This is passed down to
MemoryRegionOps for device type regions but is unused in the
memory_region_init_ram_ptr() case. Use the opaque to carry the
reference and allow the final MemoryRegion object to be reaped when
its reference count is cleared.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-10-alex.bennee@linaro.org>
---
 include/system/memory.h       |  1 +
 hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3bd5ffa5e0d..3349a5185a0 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -843,6 +843,7 @@ struct MemoryRegion {
     DeviceState *dev;
 
     const MemoryRegionOps *ops;
+    /* opaque data, used by backends like @ops */
     void *opaque;
     MemoryRegion *container;
     int mapped_via_alias; /* Mapped via an alias, container might be NULL */
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 07f6355ad62..0ef0b2743fe 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -52,17 +52,11 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 
 #if VIRGL_VERSION_MAJOR >= 1
 struct virtio_gpu_virgl_hostmem_region {
-    MemoryRegion mr;
+    MemoryRegion *mr;
     struct VirtIOGPU *g;
     bool finish_unmapping;
 };
 
-static struct virtio_gpu_virgl_hostmem_region *
-to_hostmem_region(MemoryRegion *mr)
-{
-    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
-}
-
 static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
 {
     VirtIOGPU *g = opaque;
@@ -73,14 +67,12 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
 static void virtio_gpu_virgl_hostmem_region_free(void *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
-    struct virtio_gpu_virgl_hostmem_region *vmr;
+    struct virtio_gpu_virgl_hostmem_region *vmr = mr->opaque;
     VirtIOGPUBase *b;
     VirtIOGPUGL *gl;
 
-    vmr = to_hostmem_region(mr);
-    vmr->finish_unmapping = true;
-
     b = VIRTIO_GPU_BASE(vmr->g);
+    vmr->finish_unmapping = true;
     b->renderer_blocked--;
 
     /*
@@ -118,8 +110,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
 
     vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
     vmr->g = g;
+    mr = g_new0(MemoryRegion, 1);
 
-    mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
@@ -131,7 +123,9 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
      * command processing until MR is fully unreferenced and freed.
      */
     OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
+    mr->opaque = vmr;
 
+    vmr->mr = mr;
     res->mr = mr;
 
     trace_virtio_gpu_cmd_res_map_blob(res->base.resource_id, vmr, mr);
@@ -144,16 +138,15 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
                                      struct virtio_gpu_virgl_resource *res,
                                      bool *cmd_suspended)
 {
-    struct virtio_gpu_virgl_hostmem_region *vmr;
     VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
     MemoryRegion *mr = res->mr;
+    struct virtio_gpu_virgl_hostmem_region *vmr;
     int ret;
 
     if (!mr) {
         return 0;
     }
-
-    vmr = to_hostmem_region(res->mr);
+    vmr = mr->opaque;
 
     trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr, vmr->finish_unmapping);
 
-- 
2.47.3


