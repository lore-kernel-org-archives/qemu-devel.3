Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07CFC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyD7-0000ka-8N; Fri, 02 May 2025 17:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyD5-0000k7-M6
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:19 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyD3-0003Wt-Ig
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:19 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-acec5b99052so424762066b.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746222375; x=1746827175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9FlrQnjVSYEb0+dNGQFK1FqE6e7hFamBzmAqPtToxE=;
 b=bnbHW9LvXT9d8U2qt/BpzFDSoPthJNq3eK1pHnVI5mVQ8vhyjo3oaJY5xoBu7nN4a3
 Em3yYlHa6tcr8wiq8N+W31vQymrpSSsX9I1gd59mnArD4Nf9amNGIpRjNpUAwKtlchdX
 3z37XAq43/js1+n6Jx8PoQjnLfNRXLUSpfKKX58w7TD66pKMY/awD+lLRqv9RKWf71MR
 qWl4BtGrAtbbL2jGcu5niDoVw6fDKS2ebfMVLYYVrLAk++7CAm5rKNz/OMLVB8Y9uOHS
 UVpPyWEeI8OGlKZLhmbZzCDzpdYJ8HGgqM8jBXuJutcmdG6WsEKKNja2E0SbP2VWiaqr
 fcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222375; x=1746827175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9FlrQnjVSYEb0+dNGQFK1FqE6e7hFamBzmAqPtToxE=;
 b=DYxl/IuoDq6kOHWD2VCOGU1Jt8Dae9iVsB2dSBXj2pFERqubbJICVHLKt+lfiwhAQ5
 h9jL6nydcvbGyR4klIM1QsxnzgCogqxZ/b6qGSWZJaGtcTXEfkgFUsmBn2T0GMV6sGFI
 hMR9pPUR392nJWAgoCVSiQQ444gzxCIiqUJa2mDl1t6LkDWzg0+pTFaJxL7LwcZjVa7I
 wYZ7D/wANTrOmHJwMXueAXQ/JGSfxqdXnZVCUxlR4WHKTxNL3AyfV+y3jZsktjlBzqDA
 EgXzDkrpsanAKn1zdfd6fUURC0ldYBztCgzz2yzp5zkzGy7B6JOS7cl2+KRBBvjjekCr
 Mfng==
X-Gm-Message-State: AOJu0YyJI2EZfyG/ntoI1DHljI2uWFvrrR69LBdqaJMP11iVB91b38v0
 uWdsdJxtiP+6uzKbqwGbWeeDZMJypKQhlXI/EjyztDo66RAkXdTgqYeZhh5kJdVbMvMptZF0Bdh
 C
X-Gm-Gg: ASbGncug0B6WU1zmLYGBVOrL/ok/qkVBw16H4OghE0Jw95Himo3Tr735485F21VWbAb
 sOqd12WO5zIL4DSGVuNmS4PGmVSRbQOcTJHhIZvrJd3j5daxp7JHD5vBtickB5XCmtZcAckxfJ7
 wW95EVlRpTldAWq9muMaGWP15uFMY+VcPXyPnw657LT801gvsm74B323Bt0B3zGKV49ceX5ICti
 6Mi5gdgZ/orr9l97FItEh3gka5oL/Vp6uqpu5eGHgT5SVhjL3zjVFJLdC4vE+7XB18B/7zI6mue
 orTn8mZPan1Ag0k0NeCR9EjiNJlinYvEXx7SeDsOBt26dUrKu28jH+Mqw5ZZVlituZufBItBoOC
 DsFFHARknj2rn2cw=
X-Google-Smtp-Source: AGHT+IFZooM1Wz6pWGutx+mAfFy+qXL5NhJpZk0lWHJ/LqYR1suoJm2hnwWEVMZYv88VEOWzcHEUVw==
X-Received: by 2002:a17:907:d8e:b0:ac6:ecd8:a235 with SMTP id
 a640c23a62f3a-ad17adaeceamr440062066b.28.1746222375214; 
 Fri, 02 May 2025 14:46:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c02e5sm103375066b.95.2025.05.02.14.46.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 14:46:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 4/5] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
Date: Fri,  2 May 2025 23:45:50 +0200
Message-ID: <20250502214551.80401-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502214551.80401-1-philmd@linaro.org>
References: <20250502214551.80401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Check legacy guests support at runtime: instead of evaluating
the VIRTIO_MEM_HAS_LEGACY_GUESTS definition at compile time,
call target_system_arch() to detect which target is being run at
runtime. Register virtio_mem_legacy_guests_properties[] at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 77 ++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 02c47730ae8..4234396f774 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -15,6 +15,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #include "system/numa.h"
 #include "system/system.h"
 #include "system/reset.h"
@@ -33,13 +34,21 @@
 
 static const VMStateDescription vmstate_virtio_mem_device_early;
 
-/*
- * We only had legacy x86 guests that did not support
- * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE. Other targets don't have legacy guests.
- */
-#if defined(TARGET_X86_64) || defined(TARGET_I386)
-#define VIRTIO_MEM_HAS_LEGACY_GUESTS
-#endif
+static bool virtio_mem_has_legacy_guests(void)
+{
+    /*
+     * We only had legacy x86 guests that did not support
+     * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE. Other targets don't have
+     * legacy guests.
+     */
+    switch (target_system_arch()) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return true;
+    default:
+        return false;
+    }
+}
 
 /*
  * Let's not allow blocks smaller than 1 MiB, for example, to keep the tracking
@@ -143,7 +152,6 @@ static uint64_t virtio_mem_default_block_size(RAMBlock *rb)
     return MAX(page_size, VIRTIO_MEM_MIN_BLOCK_SIZE);
 }
 
-#if defined(VIRTIO_MEM_HAS_LEGACY_GUESTS)
 static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
 {
     /*
@@ -154,7 +162,6 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
     return !qemu_ram_is_shared(rb) && qemu_ram_get_fd(rb) < 0 &&
            qemu_ram_pagesize(rb) == qemu_real_host_page_size();
 }
-#endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
 
 /*
  * Size the usable region bigger than the requested size if possible. Esp.
@@ -1004,28 +1011,28 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     rb = vmem->memdev->mr.ram_block;
     page_size = qemu_ram_pagesize(rb);
 
-#if defined(VIRTIO_MEM_HAS_LEGACY_GUESTS)
-    switch (vmem->unplugged_inaccessible) {
-    case ON_OFF_AUTO_AUTO:
-        if (virtio_mem_has_shared_zeropage(rb)) {
-            vmem->unplugged_inaccessible = ON_OFF_AUTO_OFF;
-        } else {
-            vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
+    if (virtio_mem_has_legacy_guests()) {
+        switch (vmem->unplugged_inaccessible) {
+        case ON_OFF_AUTO_AUTO:
+            if (virtio_mem_has_shared_zeropage(rb)) {
+                vmem->unplugged_inaccessible = ON_OFF_AUTO_OFF;
+            } else {
+                vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
+            }
+            break;
+        case ON_OFF_AUTO_OFF:
+            if (!virtio_mem_has_shared_zeropage(rb)) {
+                warn_report("'%s' property set to 'off' with a memdev that does"
+                            " not support the shared zeropage.",
+                            VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
+            }
+            break;
+        default:
+            break;
         }
-        break;
-    case ON_OFF_AUTO_OFF:
-        if (!virtio_mem_has_shared_zeropage(rb)) {
-            warn_report("'%s' property set to 'off' with a memdev that does"
-                        " not support the shared zeropage.",
-                        VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
-        }
-        break;
-    default:
-        break;
+    } else {
+        vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
     }
-#else /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
-    vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
-#endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
 
     if (vmem->dynamic_memslots &&
         vmem->unplugged_inaccessible != ON_OFF_AUTO_ON) {
@@ -1718,16 +1725,17 @@ static const Property virtio_mem_properties[] = {
     DEFINE_PROP_BOOL(VIRTIO_MEM_PREALLOC_PROP, VirtIOMEM, prealloc, false),
     DEFINE_PROP_LINK(VIRTIO_MEM_MEMDEV_PROP, VirtIOMEM, memdev,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
-#if defined(VIRTIO_MEM_HAS_LEGACY_GUESTS)
-    DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, VirtIOMEM,
-                            unplugged_inaccessible, ON_OFF_AUTO_ON),
-#endif
     DEFINE_PROP_BOOL(VIRTIO_MEM_EARLY_MIGRATION_PROP, VirtIOMEM,
                      early_migration, true),
     DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
                      dynamic_memslots, false),
 };
 
+static const Property virtio_mem_legacy_guests_properties[] = {
+    DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, VirtIOMEM,
+                            unplugged_inaccessible, ON_OFF_AUTO_ON),
+};
+
 static uint64_t virtio_mem_rdm_get_min_granularity(const RamDiscardManager *rdm,
                                                    const MemoryRegion *mr)
 {
@@ -1880,6 +1888,9 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
+    if (virtio_mem_has_legacy_guests()) {
+        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
+    }
     dc->vmsd = &vmstate_virtio_mem;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.47.1


