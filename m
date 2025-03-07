Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E662C35FF2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgMu-0006hN-R7; Fri, 07 Mar 2025 17:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMj-0006N9-UB
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:28 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMh-0003bm-3M
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:25 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so765215e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387221; x=1741992021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QySqG3zSy3Pvfq1KfaUgxmaXz+8tcYoh2JzWhFmGcNk=;
 b=gz3ZicF5B4xr8miq6EROllkKUaLLgIhOHB4VFnljfNzQXdr0qGykTA35pXAsuCVIAz
 q2BvVljt3Z13fvSIie2XDOQPvp54yUZSOKTY0G479k8fYAmxpmuAZfO80sSch2qIvLV7
 3SDsTV2ROIYkrWSZEALL60W4XSeZqYYtoHKrxlJbxHxLT+M7or8SVd0/gTsVtdPQWlRv
 yNURyDzrmulrOIU/p3ICtPGUPpOIqsB1v0vPC+JU9IdatdPXWWHrtESqnu+KfXGe+KHc
 USIvniABoefgWrfzKaTkpvj/827WyR07CGG1XbWJBjRQ8APi1s3gBOg0T351fFGi9Ytf
 E44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387221; x=1741992021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QySqG3zSy3Pvfq1KfaUgxmaXz+8tcYoh2JzWhFmGcNk=;
 b=JBZ1qNro2KRioDiZazcQ8TB5eVvAKz92rSDkElSicynhkms6JtxOgPQmtx8jtL3z9Q
 ada4EvY++qsRpPZZpUuf6s0vmJvyUoCIFPLnJMgrR5nQRlBGfQ6BfCd0ymUvpSU5XDWB
 SFXEYxC0wPdn/T/CN2zz9yBpngoPltk3sZE/KjzQDQeh41ArRdyQur95SbpYsoiG2eor
 vRZhrb/eO9Wuxfh7F7L9i6WQVDea79Fs9oT1v0sD2IagylErzygHFaEdKSiXc08zfL08
 14c+wuRDohsXVG0NMOOwUmEnMxOchdIZ87zL2xo6DMshfFMNt2P85XVDGPiAZ6FzbF7J
 PEsw==
X-Gm-Message-State: AOJu0Yz8m0zqiaH2br/sfPkxvKm9hl5XVWAzLDg91+arvPWM2j40sxPy
 VLU+hvk6pquSI0qqe7hMrps+XVkTMmLldfSj/bw8bQKWoF7M0mNSknGpEyjUAZLIV3CoQRQXukk
 exoA=
X-Gm-Gg: ASbGncv86U8sDRKFscoSZQmvvxxKNPd+/YpcHEUKJA4hGR29GTEuxA2p6sfms9d97N1
 PN5KDKQd53XTcsveAS9wqusySqt7+e+1GFVKLFQPY27vU2+5zja0MqUVm15shkinYEuAdNaf9VI
 VVchwwfig/C6tIFwo1L8RK7Ahiiom3OGgmiW6PNOr3y+DF9F7sHbeUoP0M4ZOvs7qTldr/9Bz3s
 LOfJlmvgfM1pZivSvLJkTpNXBXAq4WB+1q+hqZOD3oWP5aFFVuCHsryUFWHf/Ew5pAz8XSvHY5k
 tvTSl+keUhU9Xx4nTEn/CE/BiUU3sw02ZMgMWMk3syG3Dhf35FtmILRF/oNvVlxEEGxwaNNpOZT
 uMVuaADSzjKxZWxT0b74=
X-Google-Smtp-Source: AGHT+IEePJ2DBzbYOnHOK3/nOQOx67r9qAItOqsioIdBwpj9FSfUoGxyy4AuCLt9ldt5fb5F8BnNgg==
X-Received: by 2002:a05:600c:5107:b0:43b:cb05:f932 with SMTP id
 5b1f17b1804b1-43c5cf3cca8mr30089325e9.25.1741387220883; 
 Fri, 07 Mar 2025 14:40:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8dad73sm66358775e9.19.2025.03.07.14.40.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 14:40:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
Date: Fri,  7 Mar 2025 23:39:48 +0100
Message-ID: <20250307223949.54040-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307223949.54040-1-philmd@linaro.org>
References: <20250307223949.54040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 61 ++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 6ff9dab0f66..5288fe597b3 100644
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
@@ -1009,28 +1008,28 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
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
@@ -1723,16 +1722,17 @@ static const Property virtio_mem_properties[] = {
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
@@ -1885,6 +1885,9 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
+    if (virtio_mem_has_legacy_guests()) {
+        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
+    }
     dc->vmsd = &vmstate_virtio_mem;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.47.1


