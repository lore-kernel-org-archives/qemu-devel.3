Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC127C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O5Z-0000Cc-E0; Mon, 28 Apr 2025 09:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O56-0007yB-Ho
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:32 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O52-00038S-0f
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:32 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acb39c45b4eso752545766b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845166; x=1746449966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vC8n191P5j8mUKL+6H7GfxpWwzkXlFDtmwixiEivZfA=;
 b=LtbM9zZAjmrx8EPgUFzb4dwTkeIhqbUPaHQ8zrSMnBMSP9Ti1EBkrlViXT4GEk3Bd0
 RtVT3VZHOOD7iyHbZ3/tiIKFjuj+1vdWpC+gnHactdN+hAr/rR3xCa5y5m5r6nBeyQJw
 zYwDZNA7ENipR08B+UJfNFKv61ITw0t/nYGheA3quvhrTy5uk6EsQcfXfpcxnWd/hdym
 +L8xonNM7mKLRwCBN9YWYH2ZY+pTPu9X5f5QCUNZACzIPMtzcYNm0c4IbA50wyK4+YUY
 wN9W3RhHDIsJXtmfCiX33HOAQ461RgZTvK3slBCmmTDvzSuQomnXwqiVt6k1tKsNZGT3
 v2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845166; x=1746449966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vC8n191P5j8mUKL+6H7GfxpWwzkXlFDtmwixiEivZfA=;
 b=I5nQPThjYVFX7Q6/gxKUb2l5Zjh5JwE37CV2YhX+lqXbeC2Zl+HSuLaMaSZ6lDsKpl
 qTFnh7jWUXourDOFyw1tQ9Hb0IksvWXfmCw2X6CvtIykYAXKX6jmqtoE95h+i8ShzRN7
 GkeysOtHftvSMJZsNZpylLLIYO6mUlZ560tdI9dYUH2LM2TL/x+u4V56niS7RoeqFDb5
 Uf5Jq4w7OgLDDwfBev1IuNulYtBnYuQyDehi4Vt9Aey+jgZsLIeQngQQL5hVf69p3En7
 TjAu/xPNi8BbNgEAlQtn4v1tJ2McFm7ySGeHA9Ptjgn+6wKbCu9yQa+roXEeIfXtYQEC
 NxHg==
X-Gm-Message-State: AOJu0YwbFGVL44PRcgpomCTyYJrT5VHprdvz+zJkkLY/5efd+20bGLYj
 GGkh9BaTJ6RKIO4kNS0lV55B1kOtxBFrsQEGnO6K0Sl9IuWeAOXtTCsvEI2q5RE=
X-Gm-Gg: ASbGnctMx/d8kJ/JoUJEhUZIx4hch1PBKX3bypaK44jco45JduAmeCltU/ZgrVuuibO
 +ir5j8jnx4TJR72u4cbdx3bi6leeCkIwGa1YR+mhY6oYrPRIONAvHzPZqg1gzWg++EgSjqqKS7w
 mMeYUb1B3meaJXyfGIhi/zvADppvAflolPPx1m6bd/rJ1UgG3ft3yi/RakdLHHbPgJlSkR4i2mm
 xhLRLHmknRZaWelFmagh9VSqZWaoaYb7cW2mRma8EOy9hKj9sNYn8yK80Pt2dmyLsnL9q5ePk6C
 4E0X+w1bjAPYszQ6sLwOpgY5UmZjsudGyGV1ONiFdueyqOxotogcAw==
X-Google-Smtp-Source: AGHT+IED1VGhWqCdajh1Q5+7Cw2W1bP5Mo1Pw7eAQUzkWrCu2Ac7PFkEvBkH9u2TAvelW25TVOfLaQ==
X-Received: by 2002:a17:907:2d94:b0:ace:6703:3cd5 with SMTP id
 a640c23a62f3a-ace73a45cd7mr1155454166b.19.1745845166242; 
 Mon, 28 Apr 2025 05:59:26 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e41b7f9sm623625266b.6.2025.04.28.05.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 032375FAF0;
 Mon, 28 Apr 2025 13:59:19 +0100 (BST)
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
Subject: [PATCH 8/9] virtio-gpu: fix hang under TCG when unmapping blob
Date: Mon, 28 Apr 2025 13:59:17 +0100
Message-Id: <20250428125918.449346-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125918.449346-1-alex.bennee@linaro.org>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org
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
2.39.5


