Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDB6FD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d2-0001Io-Uh; Tue, 10 Mar 2026 18:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cu-0001Fv-NR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:34 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cr-00073c-9m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:32 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 ef8cb5a096bd0b111214fe5b7167cad5f7917c3de0449a8d432d9c13c6c82cb5 with SMTP id
 69b09bf5026b9427582cbc13; Tue, 10 Mar 2026 22:32:21 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181941;
 bh=RyVAKJLMo0aGuRn7813OVY/29sKqnOGraCtDLeWGLNE=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=UcznkTtFzyqtnembeK67LuDN3PcwvImRqjSWchU/RJeyyqMZUg99ffxTMCiLbihq4
 iS5BW6XSgBiBxQMBAF3MJyLx8OFcrLdLHHCYN2oqRPENEkqixZ5/42nLVUeAS6eBDF
 6xyxrh+NPU+sr1y9SUFP7pepBcic9+1UZApK3CL0fBWTPL/RmzALXDirjJNU1TlmAT
 tude8J68qWqby5h5ptkWlV66jxtYyUnPINWWnFLpHHTfBADlhpc3lVzw3/5slduJaO
 A4ue+bembmOEhUfcRDfTYdl6wblSYHuibMRWG6IXRKkx9w2J5JcodYyILfi9FWI1SG
 nQisK1ID7R/Ww==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:47 -0500
Subject: [PATCH 07/15] hw/alpha: Use QOM composition for the Typhoon
 chipset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-7-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5491; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=t9rEAymgy1ah9FBlM7UtLVNH7ETZR6oaCjVJ6+nJg6U=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP5oXHqhdY+n89cLC8TfV9/gY0xYNPfedPe3c9ZpH
 zT918O7raOUhUGMi0FWTJHl8lmJsw65u7vSVv64DzOHlQlkCAMXpwBMxOonI8P86e6f97yvOqHj
 Vmr69VWs17/uoEaZ7MWPbhVf9Zm/56gLI8PVVY5fLrH1RpUfETv86dsEtRNrp5u8e7+24IwfT37
 a//9cAA==
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

Export the QOM declaration of TyphoonState by moving it out of
hw/alpha/typhoon.c into hw/alpha/alpha_sys.h. Keep its definition
encapsulated.

Define ClipperMachineState with a TyphoonState member.

Move the instantiation of Typhoon out of typhoon_init() into the
Clipper machine and add it as a QOM child object of Clipper.

For now, add TyphoonState pointer as a parameter of typhoon_init().

Note: Eventually, typhoon_init() will be split into Typhoon's
instance_init and realize hooks; this is an intermediate commit
to that end.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h |  4 +++-
 hw/alpha/dp264.c     | 31 ++++++++++++++++++++++++++++---
 hw/alpha/typhoon.c   | 12 +++---------
 3 files changed, 34 insertions(+), 13 deletions(-)

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
index b2ef423f93..c9d639eb7b 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -18,6 +18,15 @@
 #include "hw/isa/superio.h"
 #include "qemu/datadir.h"
 
+#define TYPE_CLIPPER_MACHINE MACHINE_TYPE_NAME("clipper")
+OBJECT_DECLARE_SIMPLE_TYPE(ClipperMachineState, CLIPPER_MACHINE)
+
+struct ClipperMachineState {
+    MachineState parent_obj;
+
+    TyphoonState *typhoon;
+};
+
 static uint64_t cpu_alpha_superpage_to_phys(void *opaque, uint64_t addr)
 {
     if (((addr >> 41) & 3) == 2) {
@@ -46,6 +55,7 @@ static int clipper_pci_map_irq(PCIDevice *d, int irq_num)
 
 static void clipper_init(MachineState *machine)
 {
+    ClipperMachineState *cms = CLIPPER_MACHINE(machine);
     ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
@@ -64,6 +74,11 @@ static void clipper_init(MachineState *machine)
     uint64_t kernel_entry, kernel_low, kernel_high;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    Object * const typhoon_obj = object_new(TYPE_TYPHOON_PCI_HOST_BRIDGE);
+    TyphoonState * const typhoon = TYPHOON_PCI_HOST_BRIDGE(typhoon_obj);
+    cms->typhoon = typhoon;
+    object_property_add_child(OBJECT(machine), "typhoon", typhoon_obj);
+
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
     for (i = 0; i < smp_cpus; ++i) {
@@ -93,7 +108,7 @@ static void clipper_init(MachineState *machine)
      * the minimum PCI device IdSel is 1.
      */
     pci_bus = typhoon_init(machine->ram, &isa_irq, &rtc_irq, cpus,
-                           clipper_pci_map_irq, PCI_DEVFN(1, 0));
+                           clipper_pci_map_irq, PCI_DEVFN(1, 0), typhoon);
 
     /*
      * Init the PCI -> ISA bridge.
@@ -218,8 +233,9 @@ static void clipper_init(MachineState *machine)
     }
 }
 
-static void clipper_machine_init(MachineClass *mc)
+static void clipper_machine_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "Alpha DP264/CLIPPER";
     mc->init = clipper_init;
     mc->block_default_type = IF_IDE;
@@ -230,4 +246,13 @@ static void clipper_machine_init(MachineClass *mc)
     mc->default_nic = "e1000";
 }
 
-DEFINE_MACHINE("clipper", clipper_machine_init)
+static const TypeInfo clipper_types[] = {
+    {
+        .name = TYPE_CLIPPER_MACHINE,
+        .parent = TYPE_MACHINE,
+        .instance_size = sizeof(ClipperMachineState),
+        .class_init = clipper_machine_init,
+    },
+};
+
+DEFINE_TYPES(clipper_types);
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 5789829818..b0eb4e415c 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -18,7 +18,6 @@
 #include "hw/core/qdev-properties.h"
 
 
-#define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
 #define TYPE_TYPHOON_IOMMU_MEMORY_REGION "typhoon-iommu-memory-region"
 
 typedef struct TyphoonCchip {
@@ -50,8 +49,6 @@ typedef struct TyphoonPchip {
     TyphoonWindow win[4];
 } TyphoonPchip;
 
-OBJECT_DECLARE_SIMPLE_TYPE(TyphoonState, TYPHOON_PCI_HOST_BRIDGE)
-
 struct TyphoonState {
     PCIHostState parent_obj;
 
@@ -836,18 +833,15 @@ static void typhoon_alarm_timer(void *opaque)
 
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
 
     s->cchip.misc = 0x800000000ull; /* Revision: Typhoon.  */

-- 
2.53.0


