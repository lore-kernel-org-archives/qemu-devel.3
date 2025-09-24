Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A30DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnP-0007y8-GF; Wed, 24 Sep 2025 15:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uly-0006w8-1h
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujw-0007qW-SK
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:23 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77f32d99a97so180704b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740476; x=1759345276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fs/q0rs/kOkmjXcrgH6awTg2fJnB2s2tZwNblJ3ZTbY=;
 b=ptZnEFLZ1+g84jvNoGUkwJSW78ElKDy6EcCF8Yz3ptfI+Bs6iqlC738j19WbSMkN52
 IU8wRGtrlJjNRuM9aOVya4rVreSiaiVd7GymH7bgTe6NRjYtRHKMbZLLrfSXEW8IXNXV
 TaDAzRCJfNhT7OTBOkDsCOFD65aAE+VvOXhTgcXwr5OC2hK0U379RK/wfpeKDNoMoq97
 ZJ8UwnldSutojhakUu7x7SHAY6lBh5j44uj14zunIgLt2Bp/gmSjVZRul6UjGtuShWHO
 +DfgxlCYBV4BK6DYHsm3H4hy6adnflrGtb7+lll2xGEo1MY1PJ3wGJg04kXMmwSva1FF
 /IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740476; x=1759345276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fs/q0rs/kOkmjXcrgH6awTg2fJnB2s2tZwNblJ3ZTbY=;
 b=iMJ3n4GzeqKnJfQjkkRYnWWM6Ed7bbPs2fn8ygvMy/MSdnyk2zASBD87YifqRiEU3f
 T9aUgWRLATfT2I9V8ui3I49FCXsexJo2jqn29DT9nobuAn1PYdF09Vs+IFSfGwr30COH
 5uLIY0z77Ckt0Ozle4Vo9jWKZyJkTYqjX2exSzUf3c4CQxc2LoH9jGIYQqXZ5KnjZ5M6
 9rm+I7+VMgSCqF/PStKzywYsts7Q52pqIl+y6EKLTP9DLQD1/Fuh1iQnN0Jld9btwqfM
 s4rh+pKKu19+150bk+RgBruoY6sFW0puP6JjMcCigtgvOQ7tLHkAVjV0GOqs/QIhFAx1
 /b0Q==
X-Gm-Message-State: AOJu0Yw3J+Ii8OGaYq9FEv9G8ozXdS7l6biIUx585JXrp+PLmLLlsNiQ
 KNBt0RouDLxJVaJwWvMkA9tB2ge8ww804E3jyHLFyM6cu3/IyT9NtCkAzZAggm7eIt0LhIPaxtd
 hMCEv
X-Gm-Gg: ASbGnct9Xr8KvaA2tNWX+eXcd2QeHjKGxTcWpoHzreTnsMsnO+ubGPNuSsePrSP1c1N
 rYrB1yMCUIhXZuQI8PQBsDTIFFmDIPI+n+Nv7MwiZN3Y8XPv6db9+VklVi0pLsEl/uhrncXit+y
 jnOzBA98dt64TqWn5ML6gmUhCHnKDsWHr0xpDncXS4ewTYETGyqqV0jAkS6I8t+ib0Z76Ro0EG6
 kR08BkvqlEN375lQ23qVqUWMQdNjFldj+yNeauOBnvMIG0XaBv3FrwFGZj2rkkx66ote968Q4ZG
 kP5mQrPodAt7ThXBgUkuNJNYRTqGvTI1fpFFafwv3aEf22hyrAfAoq1XSx1v47ckKql5K2aEy7i
 3X4CXq1uS+JYO8dp9Y2DbOO1XemQZ
X-Google-Smtp-Source: AGHT+IGM2AmeyYdx7c8vUPHYNt+SfvlVO3qYOkFbVSYvNx5qHTvhCTMraa+6zRNZ7B1yFMrVfMr9pg==
X-Received: by 2002:a17:90b:4d0a:b0:32e:a54a:be53 with SMTP id
 98e67ed59e1d1-3342a2608eamr688377a91.16.1758740476313; 
 Wed, 24 Sep 2025 12:01:16 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 12/32] hw/pci-host/dino: Don't call pci_register_root_bus() in
 init
Date: Wed, 24 Sep 2025 12:00:45 -0700
Message-ID: <20250924190106.7089-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

In the dino PCI host bridge device, we call pci_register_root_bus()
in the device's instance_init. This is a problem for two reasons
 * the PCI bridge is then available to the rest of the simulation
   (e.g. via pci_qdev_find_device()), even though it hasn't
   yet been realized
 * we do not attempt to unregister in an instance_deinit,
   which means that if you go through an instance_init -> deinit
   lifecycle the freed memory for the host-bridge device is
   left on the pci_host_bridges list

ASAN reports the resulting use-after-free:

==1771223==ERROR: AddressSanitizer: heap-use-after-free on address 0x527000018f80 at pc 0x5b4b9d3369b5 bp 0x7ffd01929980 sp 0x7ffd01929978
WRITE of size 8 at 0x527000018f80 thread T0
    #0 0x5b4b9d3369b4 in pci_host_bus_register /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:608:5
    #1 0x5b4b9d321566 in pci_root_bus_internal_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:677:5
    #2 0x5b4b9d3215e0 in pci_root_bus_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:706:5
    #3 0x5b4b9d321fe5 in pci_register_root_bus /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:751:11
    #4 0x5b4b9d390521 in dino_pcihost_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci-host/dino.c:473:16

0x527000018f80 is located 1664 bytes inside of 12384-byte region [0x527000018900,0x52700001b960)
freed by thread T0 here:
    #0 0x5b4b9cab185a in free (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qemu-system-hppa+0x17ad85a) (BuildId: ca496bb2e4fc750ebd289b448bad8d99c0ecd140)
    #1 0x5b4b9e3ee723 in object_finalize /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:734:9
    #2 0x5b4b9e3e69db in object_unref /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:1232:9
    #3 0x5b4b9ea6173c in qmp_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:237:5
    #4 0x5b4b9ec4e0f3 in qmp_marshal_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qapi/qapi-commands-qdev.c:65:14

previously allocated by thread T0 here:
    #0 0x5b4b9cab1af3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/qemu-system-hppa+0x17adaf3) (BuildId: ca496bb2e4fc750ebd289b448bad8d99c0ecd140)
    #1 0x799d8270eb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5b4b9e3e75fc in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:767:15
    #3 0x5b4b9e3e7409 in object_new_with_class /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/object.c:782:12
    #4 0x5b4b9ea609a5 in qmp_device_list_properties /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:206:11

where we allocated one instance of the dino device, put it on the
list, freed it, and then trying to allocate a second instance touches
the freed memory on the pci_host_bridges list.

Fix this by deferring all the setup of memory regions and registering
the PCI bridge to the device's realize method.  This brings it into
line with almost all other PCI host bridges, which call
pci_register_root_bus() in realize.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3118
Fixes: 63901b6cc4d8b4 ("dino: move PCI bus initialisation to dino_pcihost_init()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250918114259.1802337-2-peter.maydell@linaro.org>
---
 hw/pci-host/dino.c | 90 +++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 49 deletions(-)

diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 11b353be2e..924053499c 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -413,6 +413,47 @@ static void dino_pcihost_reset(DeviceState *dev)
 static void dino_pcihost_realize(DeviceState *dev, Error **errp)
 {
     DinoState *s = DINO_PCI_HOST_BRIDGE(dev);
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
+
+    /* Dino PCI access from main memory.  */
+    memory_region_init_io(&s->this_mem, OBJECT(s), &dino_chip_ops,
+                          s, "dino", 4096);
+
+    /* Dino PCI config. */
+    memory_region_init_io(&phb->conf_mem, OBJECT(phb),
+                          &dino_config_addr_ops, DEVICE(s),
+                          "pci-conf-idx", 4);
+    memory_region_init_io(&phb->data_mem, OBJECT(phb),
+                          &dino_config_data_ops, DEVICE(s),
+                          "pci-conf-data", 4);
+    memory_region_add_subregion(&s->this_mem, DINO_PCI_CONFIG_ADDR,
+                                &phb->conf_mem);
+    memory_region_add_subregion(&s->this_mem, DINO_CONFIG_DATA,
+                                &phb->data_mem);
+
+    /* Dino PCI bus memory.  */
+    memory_region_init(&s->pci_mem, OBJECT(s), "pci-memory", 4 * GiB);
+
+    phb->bus = pci_register_root_bus(DEVICE(s), "pci",
+                                     dino_set_irq, dino_pci_map_irq, s,
+                                     &s->pci_mem, get_system_io(),
+                                     PCI_DEVFN(0, 0), 32, TYPE_PCI_BUS);
+
+    /* Set up windows into PCI bus memory.  */
+    for (int i = 1; i < 31; i++) {
+        uint32_t addr = 0xf0000000 + i * DINO_MEM_CHUNK_SIZE;
+        char *name = g_strdup_printf("PCI Outbound Window %d", i);
+        memory_region_init_alias(&s->pci_mem_alias[i], OBJECT(s),
+                                 name, &s->pci_mem, addr,
+                                 DINO_MEM_CHUNK_SIZE);
+        g_free(name);
+    }
+
+    pci_setup_iommu(phb->bus, &dino_iommu_ops, s);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->this_mem);
+
+    qdev_init_gpio_in(dev, dino_set_irq, DINO_IRQS);
 
     /* Set up PCI view of memory: Bus master address space.  */
     memory_region_init(&s->bm, OBJECT(s), "bm-dino", 4 * GiB);
@@ -444,54 +485,6 @@ static void dino_pcihost_unrealize(DeviceState *dev)
     address_space_destroy(&s->bm_as);
 }
 
-static void dino_pcihost_init(Object *obj)
-{
-    DinoState *s = DINO_PCI_HOST_BRIDGE(obj);
-    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    int i;
-
-    /* Dino PCI access from main memory.  */
-    memory_region_init_io(&s->this_mem, OBJECT(s), &dino_chip_ops,
-                          s, "dino", 4096);
-
-    /* Dino PCI config. */
-    memory_region_init_io(&phb->conf_mem, OBJECT(phb),
-                          &dino_config_addr_ops, DEVICE(s),
-                          "pci-conf-idx", 4);
-    memory_region_init_io(&phb->data_mem, OBJECT(phb),
-                          &dino_config_data_ops, DEVICE(s),
-                          "pci-conf-data", 4);
-    memory_region_add_subregion(&s->this_mem, DINO_PCI_CONFIG_ADDR,
-                                &phb->conf_mem);
-    memory_region_add_subregion(&s->this_mem, DINO_CONFIG_DATA,
-                                &phb->data_mem);
-
-    /* Dino PCI bus memory.  */
-    memory_region_init(&s->pci_mem, OBJECT(s), "pci-memory", 4 * GiB);
-
-    phb->bus = pci_register_root_bus(DEVICE(s), "pci",
-                                     dino_set_irq, dino_pci_map_irq, s,
-                                     &s->pci_mem, get_system_io(),
-                                     PCI_DEVFN(0, 0), 32, TYPE_PCI_BUS);
-
-    /* Set up windows into PCI bus memory.  */
-    for (i = 1; i < 31; i++) {
-        uint32_t addr = 0xf0000000 + i * DINO_MEM_CHUNK_SIZE;
-        char *name = g_strdup_printf("PCI Outbound Window %d", i);
-        memory_region_init_alias(&s->pci_mem_alias[i], OBJECT(s),
-                                 name, &s->pci_mem, addr,
-                                 DINO_MEM_CHUNK_SIZE);
-        g_free(name);
-    }
-
-    pci_setup_iommu(phb->bus, &dino_iommu_ops, s);
-
-    sysbus_init_mmio(sbd, &s->this_mem);
-
-    qdev_init_gpio_in(DEVICE(obj), dino_set_irq, DINO_IRQS);
-}
-
 static const Property dino_pcihost_properties[] = {
     DEFINE_PROP_LINK("memory-as", DinoState, memory_as, TYPE_MEMORY_REGION,
                      MemoryRegion *),
@@ -511,7 +504,6 @@ static void dino_pcihost_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo dino_pcihost_info = {
     .name          = TYPE_DINO_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_init = dino_pcihost_init,
     .instance_size = sizeof(DinoState),
     .class_init    = dino_pcihost_class_init,
 };
-- 
2.43.0


