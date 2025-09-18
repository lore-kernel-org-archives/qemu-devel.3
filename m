Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C29ACAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 11:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzD2t-0001Iy-0f; Thu, 18 Sep 2025 07:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzD2c-0001B8-29
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:43:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzD2Y-0003Fk-RU
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:43:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45dd7b15a64so7894695e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758195785; x=1758800585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URz5a5pFm7pKh9X7FQk4P9+y/EuFGtM2lJtZiSfIZsI=;
 b=N/gx0QPp1+AgWjUugpzkVogeXI2c1MAkrTOUPs4r+yQcERVqZ2x45sWXYiO42YoN3V
 YqRzdIAqs7gttqBYHFrDwnwgu/aGNRHjL4K8H11q+Q2GLpnw+bDUeCy5Akn0yab5JCip
 qZM13M2iKPVOhEH8ps05Ym+0/GZwdfRVQC7Rc2g5U/4VUPznp7hAkpX46tJwbVAY08la
 kHw8UInsCwKTl6JFNqvnu5Cd5iESvB08wPhkw1HHPQh4dF8DF+JjDDkqPSZdz7uXuU2G
 KCbD2oPTWU6nvljrHuimW5thVatbrMctU1brbPBN4QUBabaJZwy8dZsWnVClp6B72x3/
 /Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758195785; x=1758800585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URz5a5pFm7pKh9X7FQk4P9+y/EuFGtM2lJtZiSfIZsI=;
 b=lp7b7veyOttWXKdxRKudetEhV1og4U3eXnF2Jf5MmVYO0UOyNK7wEscF2krTXPR1XK
 zs+4P9b+eyA4VJymSnDyT9pif3hkfa2bXbT0u8EBSNd+9phrnwDhciRri1m02sSK9LAH
 r2s4e3nCaYf3LIVZ4lMADNENbJPIKk7XNIA6iNL6+tXlrtRHQiu2ptXLJyRNEiTfbnvB
 NVzll9OPhmayLqromIX6mX+zygzWuzNM7pqW2S2zX9TtOhfEETKaGbOn53amWg+g1Owp
 zp8eEPON1aLUNGkR8ex67E5bkfMhd8bHR1Egxh45Zr2XRjQyBL18xrLz6UCf9Xp7wuXY
 16JQ==
X-Gm-Message-State: AOJu0YwKEfdVrvH3z+B9sAoiJ0lTAC0Gen0yBRlcM7Wxx+3gs1voncLC
 b3OoYKGMSw1iI2IYyQl7tZGwX4F3gFF91I8kGsqCJbHeEffTrATrE8O0ls8D15ZYmCW8HwR3NhX
 Ndhus
X-Gm-Gg: ASbGnctx/2FmqfNgeZtwvqPVZ4DKvdRWqc42/Xszj4CkYscO9SQgK5h6USEViP4UQk0
 p9YKeDiwbz7uCfCYWP9Sdcefy6F/c4J61E2dLxz0d9hElA+ltB0NLd1NtR13Qp7kaBvfmkIftVK
 P4gBdVVkPEh8Qs3He7Hqw9DL/B4CUnu6QQXcdRKWvVuD5orCBmU87fQLJ/XJ2FnGkbQPJ5McYTv
 Scy5X7UkMs9YCUzXRv9UQpOF+o+DQK239b48ulcRGuGLVTPeXZsWrR/3sKcDvOFyCJwEpfKmaT4
 1rTOBFDjxxeptTAcmF1odDdgfS2dgTFSjUQjY+fh+/Rz8HxqPBWrt0a/b5U+iEFyS56bJsjOD1Y
 4h8Rk9/SSjk653O08FxcpxQ1pHxQYOTVlK3zC+os48i3IHik=
X-Google-Smtp-Source: AGHT+IHLbeZqpnkcMoAdKVV3qqJjSrwZAzMOnrOyyRLIHJQH6aulYez40ieTHLKtOY/SeWY6EQKnHA==
X-Received: by 2002:a05:600c:a415:b0:45b:92a6:63e3 with SMTP id
 5b1f17b1804b1-4652c9ee679mr22650965e9.9.1758195784907; 
 Thu, 18 Sep 2025 04:43:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46139122cb5sm76942665e9.8.2025.09.18.04.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 04:43:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 2/2] hw/pci-host/astro: Don't call pci_regsiter_root_bus() in
 init
Date: Thu, 18 Sep 2025 12:42:59 +0100
Message-ID: <20250918114259.1802337-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918114259.1802337-1-peter.maydell@linaro.org>
References: <20250918114259.1802337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In the astro PCI host bridge device, we call pci_register_root_bus()
in the device's instance_init. This is a problem for two reasons
 * the PCI bridge is then available to the rest of the simulation
   (e.g. via pci_qdev_find_device()), even though it hasn't
   yet been realized
 * we do not attempt to unregister in an instance_deinit,
   which means that if you go through an instance_init -> deinit
   lifecycle the freed memory for the host-bridge device is
   left on the pci_host_bridges list

ASAN reports the resulting use-after-free:

==1776584==ERROR: AddressSanitizer: heap-use-after-free on address 0x51f00000cb00 at pc 0x5b2d460a89b5 bp 0x7ffef7617f50 sp 0x7ffef7617f48
WRITE of size 8 at 0x51f00000cb00 thread T0
    #0 0x5b2d460a89b4 in pci_host_bus_register /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:608:5
    #1 0x5b2d46093566 in pci_root_bus_internal_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:677:5
    #2 0x5b2d460935e0 in pci_root_bus_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:706:5
    #3 0x5b2d46093fe5 in pci_register_root_bus /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:751:11
    #4 0x5b2d46fe2335 in elroy_pcihost_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci-host/astro.c:455:16

0x51f00000cb00 is located 1664 bytes inside of 3456-byte region [0x51f00000c480,0x51f00000d200)
freed by thread T0 here:
    #0 0x5b2d4582385a in free (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qemu-system-hppa+0x17ad85a) (BuildId: 692b49eedc6fb0ef618bbb6784a09311b3b7f1e8)
    #1 0x5b2d47160723 in object_finalize /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:734:9
    #2 0x5b2d471589db in object_unref /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:1232:9
    #3 0x5b2d477d373c in qmp_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:237:5

previously allocated by thread T0 here:
    #0 0x5b2d45823af3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qemu-system-hppa+0x17adaf3) (BuildId: 692b49eedc6fb0ef618bbb6784a09311b3b7f1e8)
    #1 0x79728fa08b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5b2d471595fc in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:767:15
    #3 0x5b2d47159409 in object_new_with_class /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:782:12
    #4 0x5b2d477d29a5 in qmp_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:206:11

Cc: qemu-stable@nongnu.org
Fixes: e029bb00a79be ("hw/pci-host: Add Astro system bus adapter found on PA-RISC machines")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3118
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/astro.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 859e308c577..1024ede7b68 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -424,22 +424,23 @@ static void elroy_reset(DeviceState *dev)
     }
 }
 
-static void elroy_pcihost_init(Object *obj)
+static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
 {
-    ElroyState *s = ELROY_PCI_HOST_BRIDGE(obj);
-    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    ElroyState *s = ELROY_PCI_HOST_BRIDGE(dev);
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Object *obj = OBJECT(s);
 
     /* Elroy config access from CPU.  */
-    memory_region_init_io(&s->this_mem, OBJECT(s), &elroy_chip_ops,
+    memory_region_init_io(&s->this_mem, obj, &elroy_chip_ops,
                           s, "elroy", 0x2000);
 
     /* Elroy PCI config. */
-    memory_region_init_io(&phb->conf_mem, OBJECT(phb),
-                          &elroy_config_addr_ops, DEVICE(s),
+    memory_region_init_io(&phb->conf_mem, obj,
+                          &elroy_config_addr_ops, dev,
                           "pci-conf-idx", 8);
-    memory_region_init_io(&phb->data_mem, OBJECT(phb),
-                          &elroy_config_data_ops, DEVICE(s),
+    memory_region_init_io(&phb->data_mem, obj,
+                          &elroy_config_data_ops, dev,
                           "pci-conf-data", 8);
     memory_region_add_subregion(&s->this_mem, 0x40,
                                 &phb->conf_mem);
@@ -447,8 +448,8 @@ static void elroy_pcihost_init(Object *obj)
                                 &phb->data_mem);
 
     /* Elroy PCI bus memory.  */
-    memory_region_init(&s->pci_mmio, OBJECT(s), "pci-mmio", UINT64_MAX);
-    memory_region_init_io(&s->pci_io, OBJECT(s), &unassigned_io_ops, obj,
+    memory_region_init(&s->pci_mmio, obj, "pci-mmio", UINT64_MAX);
+    memory_region_init_io(&s->pci_io, obj, &unassigned_io_ops, obj,
                             "pci-isa-mmio",
                             ((uint32_t) IOS_DIST_BASE_SIZE) / ROPES_PER_IOC);
 
@@ -459,7 +460,7 @@ static void elroy_pcihost_init(Object *obj)
 
     sysbus_init_mmio(sbd, &s->this_mem);
 
-    qdev_init_gpio_in(DEVICE(obj), elroy_set_irq, ELROY_IRQS);
+    qdev_init_gpio_in(dev, elroy_set_irq, ELROY_IRQS);
 }
 
 static const VMStateDescription vmstate_elroy = {
@@ -487,6 +488,7 @@ static void elroy_pcihost_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, elroy_reset);
+    dc->realize = elroy_pcihost_realize;
     dc->vmsd = &vmstate_elroy;
     dc->user_creatable = false;
 }
@@ -494,7 +496,6 @@ static void elroy_pcihost_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo elroy_pcihost_info = {
     .name          = TYPE_ELROY_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_init = elroy_pcihost_init,
     .instance_size = sizeof(ElroyState),
     .class_init    = elroy_pcihost_class_init,
 };
-- 
2.43.0


