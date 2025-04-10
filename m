Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5883DC369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qzg-0008NB-Bf; Thu, 10 Apr 2025 08:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u2qzc-0008HB-O1
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:26:52 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u2qzZ-0000bs-H9
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:26:52 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so1179873a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744288007; x=1744892807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UU0LoY4xVh4T7ejP0yIlqdytiVhNHfWI17GoV5hTncM=;
 b=STbQzh1Ft/ebX04UNM1hZRxV6bVX1JWtk8+dFpV6bsNhU+OvlvPFxsH6ZvPJBA0+NU
 Ta4OZhmbAbn5LfuBm8PXL+VLH3qmyDSQnTGLfWr34Iq+lvrupBOZcQgxunPuM9xAxFhB
 6kamiiG1YK/BwFV9KqoTWqgF71IwIfdmc+O1sPTC5ROqXJKqDjFTVM8caOgsapKaMGpy
 mSULDP4hC0YfBrOriVyOUbXYag4d4y1jp6z869CRTbnMnQwo2s1+DMWinwvfcrq6ORfB
 FTt/rUDtrS2Smyc+2CXJOUjlx8iS1Eo8GiYp7ebgFykHfNXJY+OGTFTTfEN47wTD1ni6
 ztpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744288007; x=1744892807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UU0LoY4xVh4T7ejP0yIlqdytiVhNHfWI17GoV5hTncM=;
 b=MXSEtWrW2lvDy4wLNqe45Vg3JEPegR82tRpSNcISOwZhaTBjvyvVgGhmsg450ijwj/
 QtVK8yloqCZqeTo9lDdp993/pMFRa7U2DXNiHU8gcTPeKMVopo+jzv1oF4ocQ4ujpm0H
 87hq8Lr1b4Gpi7LbAhgMSPs64Y60AQFZQiiETudCsG3wGW/aPlElODpyw7ByQkg2l33s
 NL3HKJAAHdURC7Stodujdlg09QNppLcAt/oaoSqeKBhpHZyiUs8xOuOAEHZkfhKWJxBD
 1wOePl9bpd5t2dyEdyHkUXl6dGN+9TlGLTguLQBAvz591t/0+JirJaWQeoNP1qu0WPj6
 ay9Q==
X-Gm-Message-State: AOJu0Yw8BIckbX326KCZo4q4ord497U26FxHwDRz7LB95DTrY/t4/0Im
 +XplidEIb6ydIlf/bHp4VC42F7M34o6pfBu4iBVemJ1ZYLvhtm6KMta4bVplLBBu0pnZsnkef8l
 7Zpc=
X-Gm-Gg: ASbGnctF27/UeRRq1hr5t1oQST+0gm4phToubMDkmV+lq7hb7iw56a5rCNpDbrS5Uuu
 uucBj37tqARX117jh6+HnPwh834ST8mL/xoNszHrXlXvt3wBuGYoycbfj56rcHCZ0vM+oIrZz3V
 gp4RIwXC+jyST6YMzvxeXFcnqM3p4KViIkTy6oSSRysplNCiEtmH+wBoy4LgM7JQCtgjVGLIYo4
 SCBAD4oHS0LItb3k0Kc0jIIhtj91nZkDRctGcozBPpgbIPpg13Rlkb17hEH9f3zcMyxR+j2WpXH
 StQNgZluorthyB9yfM7mwoZj8ClkALRE3PkRerSaMv4ETyWaH7hq49gR5302HMgeGrLKVFgunM3
 mdrhS1sgmMkRi/MEGaOb7J/M=
X-Google-Smtp-Source: AGHT+IGE0OklOYJxl0xznVlJ9Wxjr4RdbTuPQByO8hn5DmxoS4llFhKDSo9M7PhOcOWA+zPqoabgbw==
X-Received: by 2002:a17:907:3d4b:b0:ac7:cc25:9637 with SMTP id
 a640c23a62f3a-acabcb3ac4bmr294485066b.0.1744288007368; 
 Thu, 10 Apr 2025 05:26:47 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.109.242.94.tellas.gr.
 [109.242.94.194]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1be98c9sm271794866b.65.2025.04.10.05.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:26:47 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/3] hw/display: re-arrange memory region tracking
Date: Thu, 10 Apr 2025 15:26:36 +0300
Message-ID: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/exec/memory.h         |  1 +
 hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index d09af58c97..bb735a3c7e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -784,6 +784,7 @@ struct MemoryRegion {
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
γαῖα πυρί μιχθήτω


