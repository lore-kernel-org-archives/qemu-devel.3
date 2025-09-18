Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315EECAC5A8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 11:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzD2r-0001IH-O5; Thu, 18 Sep 2025 07:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzD2a-0001As-3l
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:43:12 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzD2X-0003Fa-3c
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:43:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee1317b1f7so316330f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758195783; x=1758800583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWkgFNC+jur1aVnj5eLcsF5YoLOAdEb5+NXpGnTJPbE=;
 b=UpECUGDF45l8emj4zAYXoAeyat03nCmtcOtpPKnSASaWOrXnRjHBFyILqnClZ0e7hY
 g+nqUfT987xygZhp3d+6cMvjLYhDApPtvE4FDrIqg8F/N9JyzrQDnnseO52aFFT0fXNN
 K9lp+Ugo7h9UpYhO6zqrC2SQTHsP4ar/afEyMwmKSgtMzUsUSUhMgGtZTvda6CaMxPjM
 +4ihH7zauH6PJbTsINtOOvldS/0v5foNvtr23CUaNRcsZeOvQkiJZr1R/OFRgFQ9QWqo
 XWgBT+hi6vbvPwCE/bPbOG+0Wf5XhMf5K6XzEXMt76+9vkxTZsOmvl1AFEleleWYoxrx
 s1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758195783; x=1758800583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWkgFNC+jur1aVnj5eLcsF5YoLOAdEb5+NXpGnTJPbE=;
 b=qU2mBr8liISMIcxC+A41Ww6q/J+Bi+MtTlpu8cqUPpzfLsjJH75O5tb6R9k5F743//
 fKykQQmqxROq9CqVJrHb5H+lZfeEKeZdpyENAp8ChUhrf+KvnYj4O16W6zGVFuxoxZo1
 iVWEyrSBBNOhKngqXMb9VgSG3O9tk+80wHkpw+6v1CsZBCUCOQ6+cwmlb87H46Q26hO+
 gdYsrGR3rA9fHnnBqTsmm2hrB1LcWSzyxUkMb+/Ce5RBqF1mImEe3y/cDykU4EdbAqFK
 jPt9/P0IW6Y+TiZqpDMF90WzJMAOTkDdpTelc05KGN1NGwcTbVUhQ2ks4Ut0ZvbJyG8m
 ovqQ==
X-Gm-Message-State: AOJu0Yyak6hhbpJw1/nCF2spH8QG1MeJ4edwT1jKrqCaRd0quzZUDHJF
 fuN4f3uRSbzcNVM0O9Do9OLtRVRdOfEgko2NB7uqDYks+O6qluxqKX040xQVa8exz2qrEUpUWvk
 zYheD
X-Gm-Gg: ASbGnctwv59G4u0ba+vVkKV+aupd/6GzCXsiBC0vuA4V5q8QCk+TRApddVwRXMOoEWp
 Hc28NMyUgp1WbJtArWNHzbSBP11vEtwLDMpZ5PRlmUiEHS7Cdn2gV1vaQDtzpunpYR7OA1lIsuu
 b22AYnd7pyJve/Li1ov9Srq3wiUyKcs81QCnWs+QTIp4VXeEX3OBoAgdgpjO4/50O7xnpZCGiV8
 5OlhEZs01Q2d3u4tENcnbuqxMyCCV9GbW3F7A9gtXfvRlbHYDIV+QyKzKzE7tXj+eGca99XZs7n
 rvLWGKJi04p0foJ6xvEyknfVi8QjwMP0e8nq+8tAuVgzNSQfTUHpJeBZu1V7hssX0xOBLF+Jdzo
 wc5SiMtGe35/qbnrwU5A2ImZKgf5vNrHZAY9r8AOJ3UgIwDw=
X-Google-Smtp-Source: AGHT+IHES93PHIesoKtD6QTjYMqSXi6h58qw9jGDGIa57HovkdWrI77fpVYNjMl3Sqtx5Aus1rnGSQ==
X-Received: by 2002:a5d:5f96:0:b0:3ee:1357:e18f with SMTP id
 ffacd0b85a97d-3ee1357e41emr1390985f8f.12.1758195783277; 
 Thu, 18 Sep 2025 04:43:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46139122cb5sm76942665e9.8.2025.09.18.04.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 04:43:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 1/2] hw/pci-host/dino: Don't call pci_register_root_bus() in
 init
Date: Thu, 18 Sep 2025 12:42:58 +0100
Message-ID: <20250918114259.1802337-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918114259.1802337-1-peter.maydell@linaro.org>
References: <20250918114259.1802337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
---
 hw/pci-host/dino.c | 90 +++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 49 deletions(-)

diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 11b353be2ea..924053499c1 100644
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


