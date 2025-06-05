Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5F9C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQn-00073S-LE; Thu, 05 Jun 2025 12:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQk-00071M-Us
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:03 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQi-0007wu-AW
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:02 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-602c4eae8d5so2272929a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140818; x=1749745618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuoxJAauenUw51/a95JHVEM0kV+U0SuU6MJAfDpHlJw=;
 b=IP05flmSjXuwV5SQpDp92hSyS3F2MCj7QspieGG/92bqM9UwdAHwN12PyQj7FQ5TVB
 nlbHRlPkIJhalkQBFv2X8cja7MEuh1XUOg15Sx4Izjt1GNY47ITVjuRSSgMSr7e8XMQf
 irjPALEDOzbLORdI6i7uUPIchhhnm/zDLCISPbIMwIq5GfTgu8wdk7AocIZEpEHm5Fez
 lEaRdvTxjYECJ3O9sKWA9HZwwYzncp7m6DoAjaUJVImjKwOHJqm/yb98h5cSpfBuCfVI
 d1nyBLUbMR8hnNRpa4/PNhj7kN9iPoui38gQyOycF9xW5hfO+36iEBwlvuddUk+OH6oM
 4WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140818; x=1749745618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuoxJAauenUw51/a95JHVEM0kV+U0SuU6MJAfDpHlJw=;
 b=DG0w4Rm8CxtJcIgxDhxLeaL/tGq2EJXqtZ/ge2DFdLh6/16bxCUtCj0JDXH3jLAxdM
 A44lHbjKE+gADzA1W+2LmxsPvwRLMoqt4kKP6+GYJ8YRS70u64zKPgQNukT+1RR0Y3XK
 Rm7Qbp/AXx+K9/7anPR6Ayyni9U9ynH5nzcoRfkDPBTH40Dfe90BddnY5Ptg72tPYxer
 gKnRvTkwFzTZOLtFn3l5S81WoG1kk36r4YqkACrgObF1HmVzQPNlAmdhxvGfqDp3TR3D
 iU3BMWOofjnVuZ1+Owu6/b9Aly/Miecuqt7/n83o1lFoIK1UeQt1Fi/4AdplcV3pzJ3f
 kjUA==
X-Gm-Message-State: AOJu0YwOVnoI6MSCeUt7+efwW4RoF/A5Ca+4TwLW0DWeJHWCBf1PPHD6
 HgspEpLLEpDM8nEw/PzKL2B31wwgz5vB8NS93Q5OeQxZoOUroLbRFKbM8AYiz3wkqsc=
X-Gm-Gg: ASbGncu4lve2jcBP4qZvdP2akAZDF7W6WavYGl3k4tCjyJswvhxT1FaB4PbWewdZZ2x
 BMEZUpgoK0fyhQfGkS8QTjyYp7x823wVvxEN4DszyCEo56GqnCqRAwLwTuqEh2dqRtj5/sb6m0l
 UEvctdgVZrpZiwsyyTuRUZ1IcdAYZVfkPKyWfXDGolaVbaBji0ALJ6qeMsdxjbDVVYw5d3M4b0J
 ZTt/UMify2mwxJ/+MHxncTtK++5/HsuedBBIa/9xff1b39dS7XRd7QrYQSxXMHyw7U890MFZXft
 nClzcQxyM4yqSy4TKIYGIOxL7eJhLatJLp2EzdD0T5wUL2KExOU0bGtbNaVYZPQ=
X-Google-Smtp-Source: AGHT+IEJiMfFPZ4doLC3e+IOxQOjubWJRzLqc7Ljwl0LZFm+hHKK+8S6Dw0Y7ghatlGybMQmxqj+5w==
X-Received: by 2002:a05:6402:50cf:b0:601:470b:6d47 with SMTP id
 4fb4d7f45d1cf-60722629489mr3955407a12.1.1749140818353; 
 Thu, 05 Jun 2025 09:26:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607341e69fbsm619851a12.47.2025.06.05.09.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3AA3E5F82A;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 09/17] hw/display: re-arrange memory region tracking
Date: Thu,  5 Jun 2025 17:26:42 +0100
Message-ID: <20250605162651.2614401-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-10-alex.bennee@linaro.org>

diff --git a/include/system/memory.h b/include/system/memory.h
index fc35a0dcad..90715ff44a 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
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
2.47.2


