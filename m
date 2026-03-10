Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF060FD88C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d4-0001Jm-Jl; Tue, 10 Mar 2026 18:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cy-0001GW-HT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:37 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cw-000748-3b
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:36 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 59befe239210a9067304c1807e217930d26569ebb6d96a1813f799eec60f96ca with SMTP id
 69b09bf7257cb0394ecd10f9; Tue, 10 Mar 2026 22:32:23 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181942;
 bh=hQaP5s3ISCv4eAllTXeIOtMsXtpjISci5pifsWQo1QE=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=LxzinN8gx+LSq+8gkz+8m9XSkP7jNgW5E4kdDLE5jYnIak60AKqhFUblaUmwdLcrn
 //2sFRV56+MMSn4oHjTIKDXGt1jdf9GW4JG8D41FTO1KpU3WP1DO/Syd/FRFJBXhha
 gXBvNq145WyuBOVj4NQAq2NyFJmrPWMLf/M5j8QH2Onv2Pob+bTToLMLlkNGmYAHyc
 JbNeW4A+510RtRFakqux1gLTG2o2+pOOdllxetYaID5KcAMCSDALN4mvUB5/Myqnu0
 ithswY4QEZC3xS7MEuM6p1Fkyulu07jk4WQh03L3amIxs9L47BOshDAnw6Lko7qoec
 +qmnx4fhZQRAQ==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:52 -0500
Subject: [PATCH 12/15] hw/alpha: Move PCI IRQ mapping to TyphoonClass subclass
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-12-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4969; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=vDZXyJH4edZYehJqPMXlDN152GUNXimB25E96Z1r70Q=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP4kwlxe3jt15bwwm7N1iW/lpwnn/G2dkyhvxzTlY
 Pm3sNlKHaUsDGJcDLJiiiyXz0qcdcjd3ZW28sd9mDmsTCBDGLg4BWAiLqqMDNf/O6bcuOM2mcfK
 VZRlJod0e1pK0quHe7nYFxl5eV9ZvZGRYcNxgcDuJybnGrN+fqj627PQ5/aG8NDdoUaiL8Rzjyn
 o8AEA
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

Introduce a Clipper-specific subclass of TyphoonClass, and set
the pci_map_irq_fn class member in the subclass init.

Since the board must provide the PCI IRQ mapping to the Typhoon,
mark the base Typhoon type as abstract.

Eliminate the pci_map_irq_fn parameter of typhoon_init().

Note: This commit brings us closer to the splitting of typhoon_init()
into instance_init and realize hooks.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h |  4 +++-
 hw/alpha/dp264.c     | 19 +++++++++++++++++--
 hw/alpha/typhoon.c   |  9 ++++++---
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 794a47127d..fdfe96dcb4 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -13,11 +13,13 @@
 
 typedef struct TyphoonClass {
     PCIHostBridgeClass parent_class;
+
+    pci_map_irq_fn sys_map_irq;
 } TyphoonClass;
 
 OBJECT_DECLARE_TYPE(TyphoonState, TyphoonClass, TYPHOON_PCI_HOST_BRIDGE)
 
-PCIBus *typhoon_init(pci_map_irq_fn, uint8_t devfn_min, TyphoonState *);
+PCIBus *typhoon_init(uint8_t devfn_min, TyphoonState *);
 
 #define TYPHOON_PROP_RAM "ram"
 
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index a7fc137e70..8c3c8fec67 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -21,6 +21,8 @@
 #define TYPE_CLIPPER_MACHINE MACHINE_TYPE_NAME("clipper")
 OBJECT_DECLARE_SIMPLE_TYPE(ClipperMachineState, CLIPPER_MACHINE)
 
+#define TYPE_TYPHOON_PCIHOST_CLIPPER "typhoon-pcihost-clipper"
+
 struct ClipperMachineState {
     MachineState parent_obj;
 
@@ -72,7 +74,7 @@ static void clipper_init(MachineState *machine)
     uint64_t kernel_entry, kernel_low, kernel_high;
     unsigned int smp_cpus = machine->smp.cpus;
 
-    Object * const typhoon_obj = object_new(TYPE_TYPHOON_PCI_HOST_BRIDGE);
+    Object * const typhoon_obj = object_new(TYPE_TYPHOON_PCIHOST_CLIPPER);
     TyphoonState * const typhoon = TYPHOON_PCI_HOST_BRIDGE(typhoon_obj);
     cms->typhoon = typhoon;
     object_property_add_child(OBJECT(machine), "typhoon", typhoon_obj);
@@ -109,7 +111,7 @@ static void clipper_init(MachineState *machine)
      * Init the chipset.  Because we're using CLIPPER IRQ mappings,
      * the minimum PCI device IdSel is 1.
      */
-    pci_bus = typhoon_init(clipper_pci_map_irq, PCI_DEVFN(1, 0), typhoon);
+    pci_bus = typhoon_init(PCI_DEVFN(1, 0), typhoon);
 
     /*
      * Init the PCI -> ISA bridge.
@@ -251,6 +253,14 @@ static void clipper_machine_init(ObjectClass *oc, const void *data)
     mc->default_nic = "e1000";
 }
 
+static void typhoon_pcihost_clipper_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    TyphoonClass *tc = TYPHOON_PCI_HOST_BRIDGE_CLASS(oc);
+
+    tc->sys_map_irq = clipper_pci_map_irq;
+}
+
 static const TypeInfo clipper_types[] = {
     {
         .name = TYPE_CLIPPER_MACHINE,
@@ -258,6 +268,11 @@ static const TypeInfo clipper_types[] = {
         .instance_size = sizeof(ClipperMachineState),
         .class_init = clipper_machine_init,
     },
+    {
+        .name = TYPE_TYPHOON_PCIHOST_CLIPPER,
+        .parent = TYPE_TYPHOON_PCI_HOST_BRIDGE,
+        .class_init = typhoon_pcihost_clipper_class_init,
+    },
 };
 
 DEFINE_TYPES(clipper_types);
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 8745025319..b261dd7bc5 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -833,15 +833,17 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
 
-PCIBus *typhoon_init(pci_map_irq_fn sys_map_irq, uint8_t devfn_min,
-                     TyphoonState *s)
+PCIBus *typhoon_init(uint8_t devfn_min, TyphoonState *s)
 {
+    TyphoonClass *tc = TYPHOON_PCI_HOST_BRIDGE_GET_CLASS(s);
     MemoryRegion *addr_space = get_system_memory();
     DeviceState *dev = DEVICE(s);
     PCIHostState *phb;
     PCIBus *b;
     int i;
 
+    assert(tc->sys_map_irq != NULL);
+
     phb = PCI_HOST_BRIDGE(dev);
 
     s->cchip.misc = 0x800000000ull; /* Revision: Typhoon.  */
@@ -899,7 +901,7 @@ PCIBus *typhoon_init(pci_map_irq_fn sys_map_irq, uint8_t devfn_min,
                                 &s->pchip.reg_io);
 
     b = pci_register_root_bus(dev, "pci",
-                              typhoon_set_irq, sys_map_irq, s,
+                              typhoon_set_irq, tc->sys_map_irq, s,
                               &s->pchip.reg_mem, &s->pchip.reg_io,
                               devfn_min, 64, TYPE_PCI_BUS);
     phb->bus = b;
@@ -978,6 +980,7 @@ static const TypeInfo typhoon_pcihost_info = {
     .instance_init = typhoon_pcihost_init,
     .class_size    = sizeof(TyphoonClass),
     .class_init    = typhoon_pcihost_class_init,
+    .abstract      = true,
 };
 
 static void typhoon_iommu_memory_region_class_init(ObjectClass *klass,

-- 
2.53.0


