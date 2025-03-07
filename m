Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7294DC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZTN-0006nG-Q6; Fri, 07 Mar 2025 10:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZR0-0005s5-BC
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQw-0004DO-2F
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so16802265e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360575; x=1741965375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1uU98vkFyVYQQHlVh6XdUyWkVqbT01dB2myaHB4+ng=;
 b=hixADkPqGy+G5+d9vJzySFznTTsVJRoZ8Qa5TxYdx6sgmH/MlsirMl2M2PcsHsr0sW
 ZE93RW604wcXTW8LcPty7BRRmV9jM0dqd1+gr+jEeU3TdVLoJVnfXHNvM5Tf8YUG07cT
 59D7+XQfsaYwd/Vb9D/teSivNC+PLq7c3xBN6sWUAx75R6FP8ki+TSESv4l3Z9mbUVpk
 4u6yNdOSIROEkphRwUI5e5xkZmRovWt6CW/aGroCETpWMCVOTCysT8dAMKsbmM8YhCKg
 p7MXpmftQyJcA5gn/iKE2FjPZ3XntVns8v/LwrO2EQEfImxDGV+pkh1lAxz4w7ZRmhBi
 5rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360575; x=1741965375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1uU98vkFyVYQQHlVh6XdUyWkVqbT01dB2myaHB4+ng=;
 b=MxxbFi13HQLDOLr8jq/lxJ9PxaI2UUJMA4h7sG7qXaU1/ukjjXH6VdDVB/5FWp5/BI
 4bTMGHHcJdyCoUHWw5tOiJ5KuOXrcpmsOKdcF8afwqHoichcKpcBUt2RFnM6CSnjYj7a
 L6JiL4byQEepbs/kvTdOO0+iEnBpn3B0Qzx5Mlqd//ngoPaAYUabmY5kVxszSnHyn9BQ
 a1iem4+5r4nFL1UMa8Kk6aCLadDzYT64rztZOEuaxSVIyl8B9aP+4oKj7hbaGJsH8R17
 C6FC8MV9+UHdPDw4k3vX7HVFc4R47kAN16sQzLn0vHgWYj1KsASMWXhkK0z7ImdjhXeg
 XGKg==
X-Gm-Message-State: AOJu0YzUOXe+U+K0UCs8Y2c8DPwNoUydLCsyww+8Lk8i9jDqulqh61DM
 gcQgVQ+zyk3MYf/WGrWGlNMsPh1o4Ta+jsdSLbRp/n8oe+K+6C9/bsPssoi0Ke1jMo+EoJPG65t
 USlk=
X-Gm-Gg: ASbGncv9onDLEHn30BCTAz4+Ye/t5BN3XVAppTvHH26mL5adBKgRI4bbFjXwbyvT3Uz
 3qbK44+N01zCQj4yHMogJn969WFZzTUCAv7ORR+hJG7QSF8NsgDUmQD0ffumzFpadbzcB83emvp
 eqipsRqE/KezS93VK3vLgJyXHnxf4QNIjgyklcN7eQn1CDYCzxWq9/zpgdShdQKpboSMXsm5Ojo
 q3WT9up2UGC81u2zC/McUpBG/jytI78TV+ECAc5DUxN+omZdz7oMgqaA7oLiTqTvEbicQ3fd0Zv
 GfvR25QH1VZI+87Ctdlt4VUmk64DWNYsZpOFVO5SBkFBDPZgUtypv8QXDoZ2uDVANwJaCSJwTuD
 RenfHj3Vb1+WHBWjteQA=
X-Google-Smtp-Source: AGHT+IFxsssKXyTBAAc5wmxVI2LqKPiz4QNbU3KOU0ehAcZnNyPixIzCcV4xZeSwxspKWLJeHqciQQ==
X-Received: by 2002:a05:600c:3b0e:b0:43b:d04a:3506 with SMTP id
 5b1f17b1804b1-43c686f703emr23532445e9.25.1741360575315; 
 Fri, 07 Mar 2025 07:16:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c10437dsm5715023f8f.99.2025.03.07.07.16.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 07:16:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
Date: Fri,  7 Mar 2025 16:15:42 +0100
Message-ID: <20250307151543.8156-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307151543.8156-1-philmd@linaro.org>
References: <20250307151543.8156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Use qemu_arch_available() to check at runtime if a target
architecture is built in.
Register virtio_mem_legacy_guests_properties[] at runtime.
Code churn in virtio_mem_device_realize() is due to re-indentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 61 ++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 8c40042108c..ea7229ce28c 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -38,9 +38,10 @@ static const VMStateDescription vmstate_virtio_mem_device_early;
  * We only had legacy x86 guests that did not support
  * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE. Other targets don't have legacy guests.
  */
-#if defined(TARGET_X86_64) || defined(TARGET_I386)
-#define VIRTIO_MEM_HAS_LEGACY_GUESTS
-#endif
+static bool virtio_mem_has_legacy_guests(void)
+{
+    return qemu_arch_available(QEMU_ARCH_I386);
+}
 
 /*
  * Let's not allow blocks smaller than 1 MiB, for example, to keep the tracking
@@ -144,7 +145,6 @@ static uint64_t virtio_mem_default_block_size(RAMBlock *rb)
     return MAX(page_size, VIRTIO_MEM_MIN_BLOCK_SIZE);
 }
 
-#if defined(VIRTIO_MEM_HAS_LEGACY_GUESTS)
 static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
 {
     /*
@@ -155,7 +155,6 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
     return !qemu_ram_is_shared(rb) && qemu_ram_get_fd(rb) < 0 &&
            qemu_ram_pagesize(rb) == qemu_real_host_page_size();
 }
-#endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
 
 /*
  * Size the usable region bigger than the requested size if possible. Esp.
@@ -1001,28 +1000,28 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
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
@@ -1715,16 +1714,17 @@ static const Property virtio_mem_properties[] = {
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
@@ -1877,6 +1877,9 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
+    if (virtio_mem_has_legacy_guests()) {
+        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
+    }
     dc->vmsd = &vmstate_virtio_mem;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.47.1


