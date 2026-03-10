Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8560EFD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d5-0001KV-3C; Tue, 10 Mar 2026 18:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05d0-0001HN-4D
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:38 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cx-00074c-4n
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:37 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 a80a098b0b20435d5e3b6571d60b7bf087a8e860b48c64cee4a9d43aab0abc8a with SMTP id
 69b09bf8257cb0394ecd1758; Tue, 10 Mar 2026 22:32:24 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181943;
 bh=wCmB93SEiP7BIq/6m0Q34ZyrlzS8KHnOC09TEB31F2M=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=FJxZTvAW/C3+Csz6mEZYaRTHpP42+M6Rel3BQ1w0reQkUrLtcdRNx+ulnau4+ppf1
 mzDCt0AQ/Yc9p95M75IUJ2WloiFIyhPCBWEUR4Pa8a9W/UIuc8JGCrbxDhg+W3Cnk1
 JG7nyGWJRRBefI3YPAqcGPx++02Hqty85NY21s3eTFiY+8lA985X57zwfaHY7FvNC5
 r1ECuzncM71w/jv/trEf1KnXRht0pcA7eYK/As187pntZn2SLmRrLmOV2RBcmxAROY
 xf3TFul3KqsJO0tJd29s5hlCzE7OCNfOIVsiwJ8/khdlLc5zJVrZXlMpl1PMVIIopD
 qDycQXtLp45VQ==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:55 -0500
Subject: [PATCH 15/15] hw/alpha: Split typhoon_init() into instance_init
 and realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-15-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11873;
 i=yodel.eldar@yodel.dev; h=from:subject:message-id;
 bh=91hfeNLjqZM4ynIx2IcMnyPuufJ0oupi4ZMCknnkWuI=;
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP5077HUs/MJdfGVf3/N1uRb+mHRJHHvM1F8aZEHP
 SqdH90701HKwiDGxSArpshy+azEWYfc3V1pK3/ch5nDygQyhIGLUwAmom3A8Jtdp+BW0dV7l81u
 3bm8Uf2MfqWVsO6FFZXrSxmvz9vz7vp/Robl4k9eHHw7q3F1YVbSM5FIFotvT94oahn7f1/9mPH
 /k4e8AA==
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that all of typhoon_init() inputs are either QOM link
properties or subclass members, split it between Typhoon's
instance_init and realize hooks.

Replace its invocation in clipper_init() with
sysbus_realize_and_unref().

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h |   2 -
 hw/alpha/dp264.c     |   2 +-
 hw/alpha/typhoon.c   | 219 ++++++++++++++++++++++++++-------------------------
 3 files changed, 114 insertions(+), 109 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 27c3a72b13..fcc3abe95c 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -20,8 +20,6 @@ typedef struct TyphoonClass {
 
 OBJECT_DECLARE_TYPE(TyphoonState, TyphoonClass, TYPHOON_PCI_HOST_BRIDGE)
 
-void typhoon_init(TyphoonState *);
-
 #define TYPHOON_PROP_RAM "ram"
 #define TYPHOON_PCI_BUS_NAME "pci"
 
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 92a15b0239..c59528174f 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -111,7 +111,7 @@ static void clipper_init(MachineState *machine)
      * Init the chipset.  Because we're using CLIPPER IRQ mappings,
      * the minimum PCI device IdSel is 1.
      */
-    typhoon_init(typhoon);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(typhoon), &error_fatal);
     pci_bus = PCI_BUS(object_resolve_path_component(typhoon_obj,
                                                     TYPHOON_PCI_BUS_NAME));
 
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 55f3aae584..e7a0bbfc1c 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -833,112 +833,6 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
 
-void typhoon_init(TyphoonState *s)
-{
-    TyphoonClass *tc = TYPHOON_PCI_HOST_BRIDGE_GET_CLASS(s);
-    MemoryRegion *addr_space = get_system_memory();
-    DeviceState *dev = DEVICE(s);
-    PCIHostState *phb;
-    PCIBus *b;
-    int i;
-
-    assert(tc->sys_map_irq != NULL);
-
-    phb = PCI_HOST_BRIDGE(dev);
-
-    s->cchip.misc = 0x800000000ull; /* Revision: Typhoon.  */
-    s->pchip.win[3].wba = 2;        /* Window 3 SG always enabled. */
-
-    /* Remember the CPUs so that we can deliver interrupts to them.  */
-    for (i = 0; i < 4; i++) {
-        AlphaCPU *cpu = s->cchip.cpu[i];
-        if (cpu != NULL) {
-            cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                                 typhoon_alarm_timer,
-                                                 (void *)((uintptr_t)s + i));
-        }
-    }
-
-    /*
-     * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
-     * but the address space hole reserved at this point is 8TB.
-     */
-    memory_region_add_subregion(addr_space, 0, s->ram);
-
-    /* TIGbus, 0x801.0000.0000, 1GB.  */
-    /*
-     * ??? The TIGbus is used for delivering interrupts, and access to
-     * the flash ROM.  I'm not sure that we need to implement it at all.
-     */
-
-    /* Pchip0 CSRs, 0x801.8000.0000, 256MB.  */
-    memory_region_init_io(&s->pchip.region, OBJECT(s), &pchip_ops, s, "pchip0",
-                          256 * MiB);
-    memory_region_add_subregion(addr_space, 0x80180000000ULL,
-                                &s->pchip.region);
-
-    /* Cchip CSRs, 0x801.A000.0000, 256MB.  */
-    memory_region_init_io(&s->cchip.region, OBJECT(s), &cchip_ops, s, "cchip0",
-                          256 * MiB);
-    memory_region_add_subregion(addr_space, 0x801a0000000ULL,
-                                &s->cchip.region);
-
-    /* Dchip CSRs, 0x801.B000.0000, 256MB.  */
-    memory_region_init_io(&s->dchip_region, OBJECT(s), &dchip_ops, s, "dchip0",
-                          256 * MiB);
-    memory_region_add_subregion(addr_space, 0x801b0000000ULL,
-                                &s->dchip_region);
-
-    /* Pchip0 PCI memory, 0x800.0000.0000, 4GB.  */
-    memory_region_init(&s->pchip.reg_mem, OBJECT(s), "pci0-mem", 4 * GiB);
-    memory_region_add_subregion(addr_space, 0x80000000000ULL,
-                                &s->pchip.reg_mem);
-
-    /* Pchip0 PCI I/O, 0x801.FC00.0000, 32MB.  */
-    memory_region_init_io(&s->pchip.reg_io, OBJECT(s), &alpha_pci_ignore_ops,
-                          NULL, "pci0-io", 32 * MiB);
-    memory_region_add_subregion(addr_space, 0x801fc000000ULL,
-                                &s->pchip.reg_io);
-
-    b = pci_register_root_bus(dev, TYPHOON_PCI_BUS_NAME,
-                              typhoon_set_irq, tc->sys_map_irq, s,
-                              &s->pchip.reg_mem, &s->pchip.reg_io,
-                              tc->devfn_min, 64, TYPE_PCI_BUS);
-    phb->bus = b;
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    /* Host memory as seen from the PCI side, via the IOMMU.  */
-    memory_region_init_iommu(&s->pchip.iommu, sizeof(s->pchip.iommu),
-                             TYPE_TYPHOON_IOMMU_MEMORY_REGION, OBJECT(s),
-                             "iommu-typhoon", UINT64_MAX);
-    address_space_init(&s->pchip.iommu_as, MEMORY_REGION(&s->pchip.iommu),
-                       "pchip0-pci");
-    pci_setup_iommu(b, &typhoon_iommu_ops, s);
-
-    /* Pchip0 PCI special/interrupt acknowledge, 0x801.F800.0000, 64MB.  */
-    memory_region_init_io(&s->pchip.reg_iack, OBJECT(s), &alpha_pci_iack_ops,
-                          b, "pci0-iack", 64 * MiB);
-    memory_region_add_subregion(addr_space, 0x801f8000000ULL,
-                                &s->pchip.reg_iack);
-
-    /* Pchip0 PCI configuration, 0x801.FE00.0000, 16MB.  */
-    memory_region_init_io(&s->pchip.reg_conf, OBJECT(s), &alpha_pci_conf1_ops,
-                          b, "pci0-conf", 16 * MiB);
-    memory_region_add_subregion(addr_space, 0x801fe000000ULL,
-                                &s->pchip.reg_conf);
-
-    /*
-     * For the record, these are the mappings for the second PCI bus.
-     * We can get away with not implementing them because we indicate
-     * via the Cchip.CSC<PIP> bit that Pchip1 is not present.
-     */
-    /* Pchip1 PCI memory, 0x802.0000.0000, 4GB.  */
-    /* Pchip1 CSRs, 0x802.8000.0000, 256MB.  */
-    /* Pchip1 PCI special/interrupt acknowledge, 0x802.F800.0000, 64MB.  */
-    /* Pchip1 PCI I/O, 0x802.FC00.0000, 32MB.  */
-    /* Pchip1 PCI configuration, 0x802.FE00.0000, 16MB.  */
-}
-
 static void typhoon_pcihost_init(Object *obj)
 {
     TyphoonState *s = TYPHOON_PCI_HOST_BRIDGE(obj);
@@ -955,6 +849,118 @@ static void typhoon_pcihost_init(Object *obj)
     qdev_init_gpio_in_named(dev, typhoon_set_isa_irq, TYPHOON_GPIO_ISA_IRQ, 1);
     qdev_init_gpio_in_named(dev, typhoon_set_timer_irq, TYPHOON_GPIO_RTC_IRQ,
                             1);
+
+    s->cchip.misc = 0x800000000ull; /* Revision: Typhoon.  */
+    s->pchip.win[3].wba = 2;        /* Window 3 SG always enabled. */
+
+    /* TIGbus, 0x801.0000.0000, 1GB.  */
+    /*
+     * ??? The TIGbus is used for delivering interrupts, and access to
+     * the flash ROM.  I'm not sure that we need to implement it at all.
+     */
+
+    /* Pchip0 CSRs, 0x801.8000.0000, 256MB.  */
+    memory_region_init_io(&s->pchip.region, OBJECT(s), &pchip_ops, s, "pchip0",
+                          256 * MiB);
+
+    /* Cchip CSRs, 0x801.A000.0000, 256MB.  */
+    memory_region_init_io(&s->cchip.region, OBJECT(s), &cchip_ops, s, "cchip0",
+                          256 * MiB);
+
+    /* Dchip CSRs, 0x801.B000.0000, 256MB.  */
+    memory_region_init_io(&s->dchip_region, OBJECT(s), &dchip_ops, s, "dchip0",
+                          256 * MiB);
+
+    /* Pchip0 PCI memory, 0x800.0000.0000, 4GB.  */
+    memory_region_init(&s->pchip.reg_mem, OBJECT(s), "pci0-mem", 4 * GiB);
+
+    /* Pchip0 PCI I/O, 0x801.FC00.0000, 32MB.  */
+    memory_region_init_io(&s->pchip.reg_io, OBJECT(s), &alpha_pci_ignore_ops,
+                          NULL, "pci0-io", 32 * MiB);
+
+    /* Host memory as seen from the PCI side, via the IOMMU.  */
+    memory_region_init_iommu(&s->pchip.iommu, sizeof(s->pchip.iommu),
+                             TYPE_TYPHOON_IOMMU_MEMORY_REGION, OBJECT(s),
+                             "iommu-typhoon", UINT64_MAX);
+    address_space_init(&s->pchip.iommu_as, MEMORY_REGION(&s->pchip.iommu),
+                       "pchip0-pci");
+}
+
+static void typhoon_pcihost_realize(DeviceState *dev, Error **errp)
+{
+    TyphoonClass *tc = TYPHOON_PCI_HOST_BRIDGE_GET_CLASS(dev);
+    TyphoonState *s = TYPHOON_PCI_HOST_BRIDGE(dev);
+    MemoryRegion *addr_space = get_system_memory();
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
+    PCIBus *b;
+    int i;
+    const char *typename = object_get_typename(OBJECT(s));
+
+    if (s->cchip.cpu[0] == NULL) {
+        error_setg(errp, "%s: \"cchip.cpu[0]\" link is not set", typename);
+        return;
+    }
+
+    if (s->ram == NULL) {
+        error_setg(errp, "%s: \"ram\" link is not set.", typename);
+        return;
+    }
+
+    if (tc->sys_map_irq == NULL) {
+        error_setg(errp, "%s: \"sys_map_irq\" setter has not been called.",
+                   typename);
+        return;
+    }
+
+    b = pci_register_root_bus(dev, TYPHOON_PCI_BUS_NAME,
+                              typhoon_set_irq, tc->sys_map_irq, s,
+                              &s->pchip.reg_mem, &s->pchip.reg_io,
+                              tc->devfn_min, 64, TYPE_PCI_BUS);
+    phb->bus = b;
+
+    /* Remember the CPUs so that we can deliver interrupts to them.  */
+    for (i = 0; i < 4; i++) {
+        AlphaCPU *cpu = s->cchip.cpu[i];
+        if (cpu != NULL) {
+            cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                            typhoon_alarm_timer,
+                                            (void *)((uintptr_t)s + i));
+        }
+    }
+    /*
+     * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
+     * but the address space hole reserved at this point is 8TB.
+     */
+    memory_region_add_subregion(addr_space, 0, s->ram);
+
+    memory_region_add_subregion(addr_space, 0x80180000000ULL,
+                                &s->pchip.region);
+
+    memory_region_add_subregion(addr_space, 0x801a0000000ULL,
+                                &s->cchip.region);
+
+    memory_region_add_subregion(addr_space, 0x801b0000000ULL,
+                                &s->dchip_region);
+
+    memory_region_add_subregion(addr_space, 0x80000000000ULL,
+                                &s->pchip.reg_mem);
+
+    memory_region_add_subregion(addr_space, 0x801fc000000ULL,
+                                &s->pchip.reg_io);
+
+    pci_setup_iommu(b, &typhoon_iommu_ops, s);
+
+    /* Pchip0 PCI special/interrupt acknowledge, 0x801.F800.0000, 64MB.  */
+    memory_region_init_io(&s->pchip.reg_iack, OBJECT(s), &alpha_pci_iack_ops,
+                          b, "pci0-iack", 64 * MiB);
+    memory_region_add_subregion(addr_space, 0x801f8000000ULL,
+                                &s->pchip.reg_iack);
+
+    /* Pchip0 PCI configuration, 0x801.FE00.0000, 16MB.  */
+    memory_region_init_io(&s->pchip.reg_conf, OBJECT(s), &alpha_pci_conf1_ops,
+                          b, "pci0-conf", 16 * MiB);
+    memory_region_add_subregion(addr_space, 0x801fe000000ULL,
+                                &s->pchip.reg_conf);
 }
 
 static const Property typhoon_properties[] = {
@@ -967,6 +973,7 @@ static void typhoon_pcihost_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->user_creatable = false;
+    dc->realize = typhoon_pcihost_realize;
 
     device_class_set_props(dc, typhoon_properties);
 }

-- 
2.53.0


