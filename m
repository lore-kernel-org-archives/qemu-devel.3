Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D026C54EDA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmXG-0000al-Dc; Wed, 21 May 2025 12:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmXC-0000Y2-3F
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:14 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX2-0006Bc-U3
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:13 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad51ba0af48so1115092766b.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845781; x=1748450581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prKtOm6WcF+MO/JIEf9B+KJu4Pq11tFhYp9uWEc/J/U=;
 b=X7gUsF4CDCkkn6R3Vk7QC7i1o4rOXnjuV8BfJngu6r98QEN3Jza7vsVwdlxwcwCe4G
 UATWs7uyZ+Ku0zOB6yzrqg9JcOZwneUBIi483O7XjMkH2JAdE2ZV7Qne4QA8ohlayNBO
 oUJdSATe3Z1ULtzSy54ApdHNvpQgWKt8DqQHR5L6/Tf7qkhUwYr+wzixpDZ4w0T7Zo5V
 pYqllZysPxxe5EYL5ZmnztVA2BoZeHzXAvtbye+cxtCOVFwpl3YK2UdJiGCuT7KQkm7F
 TE6eIFAA3LPTFoPhrPNlnAFJmBafE3X2y6Gs0gB8rIytfVKQ8StmfeILzdRnMDvxiweR
 V+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845781; x=1748450581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prKtOm6WcF+MO/JIEf9B+KJu4Pq11tFhYp9uWEc/J/U=;
 b=orxtfismlq12eUfQc3DOzosAjThsD2ostXehPmDUOOnz8KqJ7zQFFf7W67bEj9GmZm
 e4dfJGXhQYY0ASlibIPJNaUYGz0ytiUEP+jIHQYZL8q3f8dlHxi7sd4Sk9HdhKeFYAsp
 R2mWY20zGQdqyGWxHifGZtO2pB6oClD9CfzM9FByKecKSv7FeYwYQf2EdFBUDjaRrfCH
 j+Gu3bvlqbQO/JB8yLjDDP2meviWgJJBl/SMMbU5HD8PycxjQn2S3CNgTIZo1braYgIQ
 sMbFs7UAE31WbAxcX2dWEqirgLZ84MYn7plBSCrIUCNEA8NkHLUe+IinGE4FRcxPzPnw
 iWAA==
X-Gm-Message-State: AOJu0YwuiBw/L5K/5ABA11teVn7GbjqiqqtzqgTFWdwegGZOiWP84l9X
 cOdxjmaKqp7bEXNyxVdBgwK/6bz6mAdYiKda3vLGZghme+yyK3ggeo2UONf8LyBDu1A=
X-Gm-Gg: ASbGncuKFOKPMUNdaadTscYmTBjufxvokMTQhqwrkHGkchbYfLUz066+urlPuFSvUdy
 mRyRFVUQ9AXvg0uXuwCAjOpsQthtxg8pYv7xiYiV1lw36dYq6xq8+d/winbYnonbtzIs7/WnHZf
 tyZY6aMa4iN+elb5YWvyMczCjln40Pg4B1vhsPAKjVNBxRMsrtJWYvGxJpFn9qWS4VlwD8Tqcm0
 Yc11r/EEeZ5BtZ8l4CRwnJEOLA9zKE54LmioQdcZ89kA+md7EZ3Qd37cj2q/r1GxIxWbaW3Xtij
 ALekRLwJl2MR+Jnr48x3DEuPDpZqKu6s1m5Yw+OsKwnEpTJSmsXBtEaFORAj1/o=
X-Google-Smtp-Source: AGHT+IGDwfYt1DN9jIGOx0XsO2RSfvu00jcQDkb6KDTj4dmJF2gFYg/8jG5aiftzORhNcasR1F8heg==
X-Received: by 2002:a17:907:60d2:b0:ad5:54ec:6b3c with SMTP id
 a640c23a62f3a-ad554ec711bmr1487849966b.27.1747845781208; 
 Wed, 21 May 2025 09:43:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d06dcafsm945245966b.54.2025.05.21.09.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 139A15FA16;
 Wed, 21 May 2025 17:42:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 11/20] hw/display: re-arrange memory region tracking
Date: Wed, 21 May 2025 17:42:41 +0100
Message-Id: <20250521164250.135776-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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


