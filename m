Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307EFC369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qzf-0008Mz-Bm; Thu, 10 Apr 2025 08:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u2qzc-0008Hg-V1
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:26:53 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u2qza-0000cA-Ji
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:26:52 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so127923966b.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744288008; x=1744892808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fwtPVaNJ5K53jGTJmVbhavIXJpRTSlA72tE2QPYneE=;
 b=j9yoOYj/wrwHkVlpzQGgrDQq4o2yBxEM+FaOxtd+kur4W4qfWwlqhYfKqDdduvrV8D
 ScjH+epuQM1Sjkpz63qfEkH6yP+IJMgFVX5vh2TVHR4pHhkxT7q3PBRMuI+JFxcDyp4Z
 X0TSG5RHGEAQxV01zZ+600glplSnEL5r5FyV/8e/LCmoZE2QeNvt3McPCsO2LsX+I70k
 tIaE3oNVgMfv2R5CqCLv4oqw6Q4zkzT8/d+oUXjtPXXetJK9fDVqo/3N3uL52l8fUb9o
 WmCToJr1KrO3IiOH2Bau0kLY1i3IJ0nR6GHoOXZS5ulT/lYMIYGSWOS+L727cqF3sRUM
 w+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744288008; x=1744892808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fwtPVaNJ5K53jGTJmVbhavIXJpRTSlA72tE2QPYneE=;
 b=frMBoPW+Ut3josbHRegMKQKQEkbtXAfKustPqWe6F1pSeV8pkYVp3fLOi5oLepQsx/
 1ob06eEFoM191uUcPLOUW1zx6JNVCv/kSlPebLyWstVpd3FWYj7EA38zSXE1Fx45ksgk
 zgPAAeCK3ECPzOTzxg5+rcwF23RTX1HhF7Y85GCpd7rckWG5VcC6VkpTLHywB1ct8Djq
 2nrL6X5APg0MplZsFNeFkCUligwnMA3YZ3/i8scm1k+pC/qQwdfQ2M1vx0WVRUvUbwC1
 c+LCU3vKejYxIkCI2mSnt2ExYxVffg3vzo3B95e1EhSu5TJmGbXQxnSpj+w6/j2dxoim
 QarA==
X-Gm-Message-State: AOJu0YwS2g/51qPSUHW4c40FlKmOklNQXQSPkvVVimDYizMH3ICnAx7b
 q5BYfUoHgqiDsHlQqKBcjpCg82Gy4eaBbiq33sHqnCgj8VLsh0FMFS8HVRDvNTlkwbkU8AFrmDm
 Jv14=
X-Gm-Gg: ASbGncsBSKSzB2emov5UOoubzG/hwo6mcf/NkLEh3oVI/OkCnkNBNTI0MvcD4WbIcaE
 qAOJSA9KCizkcQRhlvXPYpOlw7Dkdz1gbpWLY1PnG2nheExuXxt1DDZq8Lt6pR8t78ANeTmubok
 fYJly0CPwDDLSbeHLT/wyZBS+M714lSS7/MGPLY50pIdcrnv0GWMLZshuVl5uXjDMV+o2d+SuGq
 TtEtMHvoaeARVdIcLJz4e+iSuaquUYQ7Od9PsAZLxWOWivhxbtA8Ghd2hhDUnNIYnLkyQTkdfAk
 MsR6UY9sMMVoCXZGqshWcT99JY1OlZQZtA9VjV8BIhDIXA/qe+HCgfbZZ3qfbkY1hKhkYXZOBLM
 mjTlp2WGO6l47CL3/0zQxedkTGDzmtl7p2g==
X-Google-Smtp-Source: AGHT+IEVWrtIGiywGQebG8b0rIOOx5SzFQLqHRJoqjEdDXBzCQcKWDaktUk790mJ6ScBMU3aAVa6vg==
X-Received: by 2002:a17:907:a05:b0:ac7:3912:5ea8 with SMTP id
 a640c23a62f3a-acac036336bmr155940966b.61.1744288008453; 
 Thu, 10 Apr 2025 05:26:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.109.242.94.tellas.gr.
 [109.242.94.194]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1be98c9sm271794866b.65.2025.04.10.05.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:26:48 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/3] virtio-gpu: fix hang under TCG when unmapping blob
Date: Thu, 10 Apr 2025 15:26:37 +0300
Message-ID: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

This commit fixes an indefinite hang when using VIRTIO GPU blob objects
under TCG in certain conditions.

The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
MemoryRegion and attaches it to an offset on a PCI BAR of the
VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
it.

Because virglrenderer commands are not thread-safe they are only
called on the main context and QEMU performs the cleanup in three steps
to prevent a use-after-free scenario where the guest can access the
region after it’s unmapped:

1. From the main context, the region’s field finish_unmapping is false
   by default, so it sets a variable cmd_suspended, increases the
   renderer_blocked variable, deletes the blob subregion, and unparents
   the blob subregion causing its reference count to decrement.

2. From an RCU context, the MemoryView gets freed, the FlatView gets
   recalculated, the free callback of the blob region
   virtio_gpu_virgl_hostmem_region_free is called which sets the
   region’s field finish_unmapping to true, allowing the main thread
   context to finish replying to the command

3. From the main context, the command is processed again, but this time
   finish_unmapping is true, so virgl_renderer_resource_unmap can be
   called and a response is sent to the guest.

It happens so that under TCG, if the guest has no timers configured (and
thus no interrupt will cause the CPU to exit), the RCU thread does not
have enough time to grab the locks and recalculate the FlatView.

That’s not a big problem in practice since most guests will assume a
response will happen later in time and go on to do different things,
potentially triggering interrupts and allowing the RCU context to run.
If the guest waits for the unmap command to complete though, it blocks
indefinitely. Attaching to the QEMU monitor and force quitting the guest
allows the cleanup to continue.

There's no reason why the FlatView recalculation can't occur right away
when we delete the blob subregion, however. It does not, because when we
create the subregion we set the object as its own parent:

    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);

The extra reference is what prevents freeing the memory region object in
the memory transaction of deleting the subregion.

This commit changes the owner object to the device, which removes the
extra owner reference in the memory region and causes the MR to be
freed right away in the main context.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 71a7500de9..8fbe4e70cc 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     vmr->g = g;
     mr = g_new0(MemoryRegion, 1);
 
-    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
 
-- 
γαῖα πυρί μιχθήτω


