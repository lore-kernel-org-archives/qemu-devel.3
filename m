Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FD01076386
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7z0X-00015j-AC; Wed, 01 Apr 2026 13:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w7z09-0000pj-Nn
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:05:11 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w7z07-0007sm-AM
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:05:09 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 657e51e36a66f18c38ea7955c08c805cbc6585bdd20ef3000326122a1a6815cb with SMTP id
 69cd503a2c50a55f4d6cb994; Wed, 01 Apr 2026 17:04:58 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1775063097;
 bh=AJlzKuAkDZcYrX0s+aHJjENlPGBg3C9Smuh0yRglnGM=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:From:Reply-to:
 Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=CwVlYMPOUNoEgWUY/HBh6nhPVCL+eTs1aZrWumY46c0Ui3EZw/DAUCz1Heiyr9Bi7
 5RsejjGjMQkzMJfa/0tJkcUm+5Wk+0uzip5zJ3w/RuiBNhAgWJk9XWLvDLPa0OIr8G
 XMdQfBaRrx+jfGBu3zESoDw8X2AEYWInPI1ArSZlvfRNZXuwsFLl8O0sOKrubf/GJE
 u0079rRjhlZ1jifT4skJ0joDtNPVL0Xz9ykweSKFiqsKw0tA3seXwaj7Ui+l0Ta8jO
 5xnp1XTOxdvr3iuUv/6g9gZrI14bNgxSWVajIkB3r38OfL9GbvEKU0JdEJayIis4HZ
 XmsXlxkOaCPUQ==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: "Yodel Eldar" <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [RFC PATCH 1/4] alpha: Define Typhoon instance_init
Date: Wed,  1 Apr 2026 12:04:51 -0500
Message-ID: <20260401170454.32045-2-yodel.eldar@yodel.dev>
In-Reply-To: <20260401170454.32045-1-yodel.eldar@yodel.dev>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h |  4 +++-
 hw/alpha/dp264.c     |  8 +++++++-
 hw/alpha/typhoon.c   | 24 ++++++++++++------------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 6e6691d116..247a52b776 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -8,9 +8,11 @@
 #include "hw/core/boards.h"
 #include "hw/intc/i8259.h"
 
+#define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
+OBJECT_DECLARE_SIMPLE_TYPE(TyphoonState, TYPHOON_PCI_HOST_BRIDGE)
 
 PCIBus *typhoon_init(MemoryRegion *, qemu_irq *, qemu_irq *, AlphaCPU *[4],
-                     pci_map_irq_fn, uint8_t devfn_min);
+                     pci_map_irq_fn, uint8_t devfn_min, TyphoonState *);
 
 /* alpha_pci.c.  */
 extern const MemoryRegionOps alpha_pci_ignore_ops;
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 2ab3c14747..ce2f8765cd 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -49,6 +49,7 @@ static void clipper_init(MachineState *machine)
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    Object *typhoon_obj;
     AlphaCPU *cpus[4];
     PCIBus *pci_bus;
     PCIDevice *pci_dev;
@@ -62,6 +63,10 @@ static void clipper_init(MachineState *machine)
     uint64_t kernel_entry, kernel_low;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    typhoon_obj = object_new_with_props(TYPE_TYPHOON_PCI_HOST_BRIDGE,
+                                        OBJECT(machine), "typhoon",
+                                        &error_fatal, NULL);
+
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
     for (i = 0; i < smp_cpus; ++i) {
@@ -87,7 +92,8 @@ static void clipper_init(MachineState *machine)
      * the minimum PCI device IdSel is 1.
      */
     pci_bus = typhoon_init(machine->ram, &isa_irq, &rtc_irq, cpus,
-                           clipper_pci_map_irq, PCI_DEVFN(1, 0));
+                           clipper_pci_map_irq, PCI_DEVFN(1, 0),
+                           TYPHOON_PCI_HOST_BRIDGE(typhoon_obj));
 
     /*
      * Init the PCI -> ISA bridge.
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 7722d4fd00..26580664d8 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -17,7 +17,6 @@
 #include "alpha_sys.h"
 
 
-#define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
 #define TYPE_TYPHOON_IOMMU_MEMORY_REGION "typhoon-iommu-memory-region"
 
 typedef struct TyphoonCchip {
@@ -49,8 +48,6 @@ typedef struct TyphoonPchip {
     TyphoonWindow win[4];
 } TyphoonPchip;
 
-OBJECT_DECLARE_SIMPLE_TYPE(TyphoonState, TYPHOON_PCI_HOST_BRIDGE)
-
 struct TyphoonState {
     PCIHostState parent_obj;
 
@@ -819,25 +816,27 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
 
+static void typhoon_pcihost_instance_init(Object *obj)
+{
+    TyphoonState *s = TYPHOON_PCI_HOST_BRIDGE(obj);
+
+    s->cchip.misc = 0x800000000ull; /* Revision: Typhoon.  */
+    s->pchip.win[3].wba = 2;        /* Window 3 SG always enabled. */
+}
+
 PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
                      qemu_irq *p_rtc_irq, AlphaCPU *cpus[4],
-                     pci_map_irq_fn sys_map_irq, uint8_t devfn_min)
+                     pci_map_irq_fn sys_map_irq, uint8_t devfn_min,
+                     TyphoonState *s)
 {
     MemoryRegion *addr_space = get_system_memory();
-    DeviceState *dev;
-    TyphoonState *s;
+    DeviceState *dev = DEVICE(s);
     PCIHostState *phb;
     PCIBus *b;
     int i;
 
-    dev = qdev_new(TYPE_TYPHOON_PCI_HOST_BRIDGE);
-
-    s = TYPHOON_PCI_HOST_BRIDGE(dev);
     phb = PCI_HOST_BRIDGE(dev);
 
-    s->cchip.misc = 0x800000000ull; /* Revision: Typhoon.  */
-    s->pchip.win[3].wba = 2;        /* Window 3 SG always enabled. */
-
     /* Remember the CPUs so that we can deliver interrupts to them.  */
     for (i = 0; i < 4; i++) {
         AlphaCPU *cpu = cpus[i];
@@ -931,6 +930,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
 static const TypeInfo typhoon_pcihost_info = {
     .name          = TYPE_TYPHOON_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
+    .instance_init = typhoon_pcihost_instance_init,
     .instance_size = sizeof(TyphoonState),
 };
 
-- 
2.53.0


