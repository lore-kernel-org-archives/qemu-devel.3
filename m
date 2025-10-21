Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA02ACCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJGH-0004ja-BR; Tue, 21 Oct 2025 16:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGG-0004jS-Pm
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGE-00012f-MN
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:16 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso1511955e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079632; x=1761684432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6GDqFIZkytfcW4kR5euLzra3hfD6+X1ZoENb96SSNU8=;
 b=AF6Vm/v3B0KERVcM2OmZ/ChGBnwOdUxjmF433tnzMTNlgcqF2LigSWZ714Kei2hF8+
 NJ0Gf9+8TTlnYgMj4fWKyZTKjmciOcLVAzjtNABPGQ5AXY02fm1A1aRiNe/1J9PLOPOg
 XYgGhtwBR4B2EIx6Rmr5c4EIDIV1GheEejNBibLouxkaEiedSZYvgmY4YHxhNQGAtDMe
 eAi1b6bGL6sFDJtLJYORpVuyXkTed6VVtNjd1GlHgRQoyfONl7R/suekImsed+4hiAmj
 rsXIAN9i109VkJvYxtAHNxO+lytOgYzCo/Kv3yySP0tcCw45OB4bubeST9Mk7vIjPdEl
 n6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079632; x=1761684432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GDqFIZkytfcW4kR5euLzra3hfD6+X1ZoENb96SSNU8=;
 b=PNSAmoLm2A2XlziinFlRU96XAtyWQKWoP3m9FH7vFVytqGFQ1obBOhNTl4wThCkTeq
 RD/jk+Mf/fo/xtimuKI9mtHTrpRp5nHfVXk+XW3TeakOYweg2+sThNC7dgzJuDyziy+9
 SEPmzDAViTxxAOXhlFFrAmSHwz2KBFJo5HEQcKZ0tHys8I6d2kpNC8Dg8Vbt2dBpa1gx
 zTLtPrFpm2iE9J67yQkEhwLx+xbtWvLhg50CJNWzvfnhd2ZwkQNMstmZjSIC3db2tnRh
 ospKm5f4GIzeke5GTA2oCT9kXLuVMGArFua4+Bh8c0V1pDKoUOpQX2ednA1YgsbMQ0bj
 VNmA==
X-Gm-Message-State: AOJu0YwnJRlWY1DRzMqFXYjDfM16NXO5xZSQzyBMg0s3f9pcMgYcq+Fy
 TyN2j/4c+Jn7c1Yk/g/XvcvVBSRhZLmossnyPh7FCUPt3HpNxsekTEE+r1thd3NSazaHeYIpNAv
 6vMJLXW0=
X-Gm-Gg: ASbGncvE23X79BgWMUD4lKyxUa5znG9PaVcgbHJQvg9WfFczNtKRnerXFnGAHA9WCwM
 7vNjY+qsKJ/hwHz6bQqCDtfqUNKNOAtuw905jyGqE70KNix8+ohObtuHfjQHf886aBTyD1S68Tn
 oXgBt4NG3fq8MIx1LUHYQoJ+ma3jrvMYnDybVHlOD34ip9jjSwSgYoQZkhsEzlSZjUNmIGbjJKf
 ggUVNwLY1PKEbKf0Np50dYoh03Do3SHKw0EdFsfmJwVE57/NpLjfygkD5V1PB1SANeLsLco3rGd
 DXKyAITX1siX7e6ctOnwoh3rjRoTKB7JHBON3YGqCeh5nwNFW6Shm1VZhYVQlYHrEy/Kwsmxw2y
 R8Ebm23udcqXnnohQ9IQfgRMllvy1GjMfJgVs/8wAdHYbw5+Ps+YCVwWV8HUtv0d/k9fLuz7ZaY
 QZ5K/XdVxXwxJOaKyxax308p1KZPDCcsZw3mq5q+o5QsIQyUAwBw==
X-Google-Smtp-Source: AGHT+IE42lrk0VVa9u4lEB+uqAtfl2H5oSiNZG2YNil9EoQHDy5k26EvsQoHAzkKM9uzGUrQzjT0Rw==
X-Received: by 2002:a05:600c:24e:b0:46f:b42e:e363 with SMTP id
 5b1f17b1804b1-475c3eedebbmr5646545e9.20.1761079632299; 
 Tue, 21 Oct 2025 13:47:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b1260sm11158005e9.13.2025.10.21.13.47.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/45] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
Date: Tue, 21 Oct 2025 22:46:16 +0200
Message-ID: <20251021204700.56072-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
call target_arch() to detect which target is being run at runtime.
Register virtio_mem_legacy_guests_properties[] at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20250502214551.80401-5-philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 76 ++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index f16445b9347..ae7c13e33cf 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -34,13 +34,21 @@
 
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
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return true;
+    default:
+        return false;
+    }
+}
 
 /*
  * Let's not allow blocks smaller than 1 MiB, for example, to keep the tracking
@@ -144,7 +152,6 @@ static uint64_t virtio_mem_default_block_size(RAMBlock *rb)
     return MAX(page_size, VIRTIO_MEM_MIN_BLOCK_SIZE);
 }
 
-#if defined(VIRTIO_MEM_HAS_LEGACY_GUESTS)
 static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
 {
     /*
@@ -155,7 +162,6 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
     return !qemu_ram_is_shared(rb) && qemu_ram_get_fd(rb) < 0 &&
            qemu_ram_pagesize(rb) == qemu_real_host_page_size();
 }
-#endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
 
 /*
  * Size the usable region bigger than the requested size if possible. Esp.
@@ -983,28 +989,28 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
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
@@ -1701,16 +1707,17 @@ static const Property virtio_mem_properties[] = {
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
@@ -1862,6 +1869,9 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
+    if (virtio_mem_has_legacy_guests()) {
+        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
+    }
     dc->vmsd = &vmstate_virtio_mem;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.51.0


