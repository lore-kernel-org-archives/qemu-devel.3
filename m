Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55A3CAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Uob-0000JD-NO; Wed, 24 Sep 2025 15:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ulz-0006wL-Tj
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:30 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujz-0007qn-AO
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:24 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3306d93e562so167200a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740477; x=1759345277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6J4KmIAWnxeyp1vUu6jNVKgoHne93MLkw2ueVRdbRs=;
 b=jN4EiVg1kPR3JGTsRMi+Dmyi2XZiIiuS8paStFpMApXqEl9MTel2AI11v9ffQm2WXj
 75TzVPTvqWloZQSn91BnxRWIK+R7Uw7wOWU7uCjQG+pdLZJ4TCRLebMQCBGsor7WsNqn
 XdTW36M1Xfn50ITIr+gjNxr3kRfVRqA3REgCGlJdcRVmRiM0+EqYJxeu0I1IIllYbbxK
 x8jy26oDqlJmEl2luZ3pUScZvQADBOcdYR99+vqxTRW/yjfOcvEtrBukFQi/RQUhHTyU
 5SYYabmuZ71dG7T8/DwirsKl5DmMYZprrTFZYCcDQAAaNL6kyyLvjX3I/ZkWETLIqfDt
 mvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740477; x=1759345277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6J4KmIAWnxeyp1vUu6jNVKgoHne93MLkw2ueVRdbRs=;
 b=i09JVGU96mzo7mcMhuToWdsox1JbYlAOB52ebgzCPv9t858dtW8/PCu8UjJQsyWwCE
 MgFcJJl/ICRaYuZtpeqGHWXDvLXrVwaR1cCRNpWF5QRpeBodzJypE/sEvbEzKcrF0Ov1
 QTDvTXXue6WbUB3YLwnhQpBVuTIRKi06XdzCuftIdEW0p3LDZs84UA6d8fhlNNgR2/Vk
 tVWf6IzGhC0l+h+X91kBQgjUnKKrDPwCuC1GxVKzsy39/u9VoM/qyUUKi+hlgIy87Jvd
 ANqYjC8pQt5pikowSyVfZh02ab4pkDL8pMmfas88zojsJYOVJ7iBmPoXR/4m/CoAA2bg
 TA3g==
X-Gm-Message-State: AOJu0YzR6EAW62p/zpru75xTz0ShVvggE5XxhCTSEzYiidGG8GS2/9tK
 gn5+efw/ugp1DPZaMuSYKYqf97lFNRSMwGsUj57RJkbWkUge1vwfcdKY14E1rzy2k2eS2CYgR4C
 vZqZb
X-Gm-Gg: ASbGncv+eWk18Vrc8btraq+8auwZ4aSmyZWedvA5wFLCRZcnlM6TuuqxIo1NzpYZuV6
 HXJ7CwedmzREXe54QxEkcBipD3mVN5K/7a/8NSK51tjETx4hRIs73x63EwabxHTVSpeu8kGorTV
 hpEFQk3NmECbc3pm6QlhUh/l+rwWn+uyeXJR0NmyxYL6TVt4OlkrtRyL0xDDW/pkHYIG9EkVTC6
 jIL+IJ6ZkPG9ObuQ39QhfaxFEzJAWFey37xJfLON1GGue77Es3Vx8WBcsV3nBCXxduUGH+pAIrF
 3wxvqdE8Db4KIVBi5xQ9pINwLlkoxCSyYmuRV0ZZkEJp5VSlHfgF8qDVgtemW1ILigoaQvpnXZE
 SEenZObekWq3nusyu0vYd6Ku67Lco
X-Google-Smtp-Source: AGHT+IFOlwEzkt4yrxK4rPCqXhdvz2+yfom4v9aYk5pFbmfeiOTGTDDGxNLlfBlICi19bTyHfrZ00A==
X-Received: by 2002:a17:90a:dfcd:b0:332:fb46:9a34 with SMTP id
 98e67ed59e1d1-3342a2c2a76mr890136a91.29.1758740476996; 
 Wed, 24 Sep 2025 12:01:16 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 13/32] hw/pci-host/astro: Don't call pci_regsiter_root_bus() in
 init
Date: Wed, 24 Sep 2025 12:00:46 -0700
Message-ID: <20250924190106.7089-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250918114259.1802337-3-peter.maydell@linaro.org>
---
 hw/pci-host/astro.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 859e308c57..1024ede7b6 100644
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


