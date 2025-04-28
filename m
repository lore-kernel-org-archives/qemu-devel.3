Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AD6C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O5o-0000pe-8d; Mon, 28 Apr 2025 09:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O55-0007ue-5A
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:31 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O50-00037g-SM
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5f4d0da2d2cso9075131a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845165; x=1746449965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prKtOm6WcF+MO/JIEf9B+KJu4Pq11tFhYp9uWEc/J/U=;
 b=JYR4ScJ4o0Eaf/t8uzCG9Iv8kQv+vZEbIG5Q91rPJfl+q56UmMBSY7pHixpO6eKTX9
 rWOvvTX4wuiqSUtKCa6lEd+kGiQ/QbpsFhVeERrOFYwmesHq20kUwL3qez8pJmrL6VF+
 nuyCv3lSEn0+UOGnoDiJR9dwPLl6wHBD/hNouQqXH4B+bLsgb2JSBKmPgUiGICHmLBfi
 EhgKPvQdRQCsk4owsZ3rRbg/tPug1Go7qa9lB6knhwdZolgLI2CorK+kpZN//5pABLLB
 OrpB/ewmAipEqORdg+RmfZHT2WtHXywpdZ8anjjilgeGjf8y5nWW9qByJpFtghBX42Jg
 j6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845165; x=1746449965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prKtOm6WcF+MO/JIEf9B+KJu4Pq11tFhYp9uWEc/J/U=;
 b=vNJGRr8zMCDyHZW/lMB+rynxvkx5jTGvPv4sx2NbZfZIXMiYsBSw68d6LFQ+SyheIw
 W+BYj4g9zF4M1zHhOOeSEuPP9DazkWGHdZPGYfphzeY9NtvOVkS+P59E9r68diD7REIy
 9Qe0uuE7EgVf2OkXWRcLLqaSSUJBqo2HrZx+rVNw+iEsxcMLzObgoA2TfxuKam2t6fSS
 z0e3uxRgZSBmYHL3TVkGWvLiBsIs1yvcTAYk4kwGwXv6/JUpTdAD4PBBw6hn1ZuR6Oo9
 pSAVdkK4wM1Z4sFIJBOwECwzuaECo5Sok42uMxquDZcdKwWc4s/+eW4mYs0mZVyoC6ja
 ABIQ==
X-Gm-Message-State: AOJu0YyWj+f9ahKdKFPca+PC5RHzBYXeLPl4LqFJrVILhYgPEap9JsEj
 mBs/iVMOIyf6shTienxOgzIZND7h3L+vbbzy1GMaNDDLU893NbEwgq4rWpr3Ixk=
X-Gm-Gg: ASbGnctvQeo5DZPwa7ieZg1wemMCS/qI66jlSn2lpitxIG9lLFUnZoq1qEua7ZPcnqT
 udiyoRkMFlzc9u2RyWlIa2UZzkyro/Dac704fMM0OrU9xszNpWpVviRy0v2lhPZ7PBL/irLaBdZ
 +SRf+oM+tAQhMbNCSP8/Bbci3YdJK/I0rJbL8hw7I2dkZUXvVDErLswuGEnQSPe+dSbX+Qt/Pjz
 ZhbgeNh4IRrvUcJ5kSQOftOpQTurAEcZ14Ojcp2v0y83901rdJJT9W+LIjRDGn7GSNL9u+L2C0T
 7ZzBpJTnVfHUGEu5qP2pTCj8PBHJVXSg7miIqXaTQ3w=
X-Google-Smtp-Source: AGHT+IGzAX+aRTF0EET+3PaTwDDE/fPb/NKX1yXORuWXmXnUA2BFIOrNj6J6V61RJrSP+CORgBVvaA==
X-Received: by 2002:a05:6402:278e:b0:5f2:f29c:b98c with SMTP id
 4fb4d7f45d1cf-5f73984e3eemr7678441a12.32.1745845164918; 
 Mon, 28 Apr 2025 05:59:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7011fc361sm5820327a12.16.2025.04.28.05.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF9935FAEF;
 Mon, 28 Apr 2025 13:59:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 7/9] hw/display: re-arrange memory region tracking
Date: Mon, 28 Apr 2025 13:59:16 +0100
Message-Id: <20250428125918.449346-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125918.449346-1-alex.bennee@linaro.org>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org
---
 include/system/memory.h       |  1 +
 hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index fbbf4cf911..b3cef1acb5 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -783,6 +783,7 @@ struct MemoryRegion {
     DeviceState *dev;
 
     const MemoryRegionOps *ops;
+    /* opaque data, used by backends like @ops */
     void *opaque;
     MemoryRegion *container;
     int mapped_via_alias; /* Mapped via an alias, container might be NULL */
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 145a0b3879..71a7500de9 100644
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
 
     return 0;
@@ -142,16 +136,15 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
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
 
     /*
      * Perform async unmapping in 3 steps:
-- 
2.39.5


