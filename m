Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC64C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63AQ-0003nR-Eo; Mon, 14 Sep 2026 05:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AO-0003kI-Jr; Mon, 14 Sep 2026 05:40:00 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AM-0001Pu-D9; Mon, 14 Sep 2026 05:40:00 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9ddbx024283
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:39:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fI6zN79jfBGi+L3Td61Zz6e7OLIaZEQsRuz39mXpBVU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378783; v=1;
 b=lFMceb35UZ4B8fYadUmkDibBMSYg+kRBQrDRB21lupK/p9N26ewCVVf23WsMqf5t
 2QYHq95zMzbF/JszR9SsKhOjJq4OiV1FVJOV5gYVY5agrSP4qO+vRTL7w1WyRt1B
 n5M082UX1EKNk6tchnnDdqyVeDoPUCVnBv9++CdqUsDBJkWGWNK3SeECgnGGdlfZ
 rXeqs+hGyelZV7lF/NjuHNz5AiPmcn2ECcOk3aGrYT7TgvD9cZHOv3dJ6zgPuQke
 8vSL52jHFQRCfnsxjgU+A071H7jbtsk6oOvy2Id22OmWotMU5gmBSlN5A1+6JLQD
 4nnmc5D1RIfOS5mMk1GDRA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:39:25 +0900
Subject: [PATCH v8 4/5] hw/arm/virt: Relax the lower bound of HighMem MMIO
 region size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-virt-v8-4-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
References: <20260914-virt-v8-0-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260914-virt-v8-0-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6510;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=wuTRxCxhydGTqRRCJsLNW+znjiBP5ZwcMYZTDMar85w=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9byAzdv8P3MEpSMkW/2/VnfcaDg+sSEHLl9dxjcd3UGr
 Jm9yoiho5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCIPVRj+mXD86Pc+/0dlXQPr
 s8O2ojPdp5x/M7OuItX8oMQavqsLZRn+Z6x7d20Rq+S1ZcJR8nrLgsNZmQ61W73StkiUn3xhnuF
 fHgA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Relax the lower bound of the HighMem MMIO region size to make it more
likely that the region fits in the PA space.

The lower bound was especially problematic on Apple M2. The current
lower bound, 512 GiB, is too big to fit in the limited PA space on the
hardware. That makes the HighMem MMIO region unavailable and limits the
PCIe MMIO space to the base MMIO region. The base MMIO region is not big
enough to contain a large hostmem window configured for virtio-gpu-gl-pci
with DRM native context, for example.

Relax the lower bound to 64 KiB, matching the memory map comment that
says "devices should generally be placed at multiples of 0x10000, to
accommodate guests using 64K pages." Also, automatically lower the
default HighMem MMIO region size to fit in the PA space for the latest
machine version; the older machine versions retain the previous default
HighMem MMIO region size for compatibility.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/system/arm/virt.rst |  2 +-
 include/hw/arm/virt.h    |  2 ++
 hw/arm/virt.c            | 29 +++++++++++++++++++----------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 5f6dd1797862..c31fd8c98aa0 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -150,7 +150,7 @@ highmem-mmio
 
 highmem-mmio-size
   Set the high memory region size for PCI MMIO. Must be a power of 2 and
-  greater than or equal to the default size (512G).
+  greater than or equal to 64 KiB.
 
 gic-version
   Specify the version of the Generic Interrupt Controller (GIC) to provide.
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3f1eb0583c94..4766d797ecd1 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -146,6 +146,7 @@ typedef enum VirtGICType {
 struct VirtMachineClass {
     MachineClass parent;
     hwaddr min_highmem_base;
+    hwaddr high_pcie_mmio_size;
     bool no_tcg_its;
     bool no_highmem_compact;
     bool no_kvm_steal_time;
@@ -186,6 +187,7 @@ struct VirtMachineState {
     VirtMSIControllerType msi_controller;
     uint16_t virtio_iommu_bdf;
     struct arm_boot_info bootinfo;
+    hwaddr high_pcie_mmio_size;
     MemMapEntry *memmap;
     char *pciehb_nodename;
     const int *irqmap;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 79a896ee578b..1de47e0d4e90 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -223,8 +223,7 @@ static const MemMapEntry base_memmap[] = {
 };
 
 /* Update the docs for highmem-mmio-size when changing this default */
-#define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
-#define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
+#define MAX_DEFAULT_HIGH_PCIE_MMIO_SIZE (512 * GiB)
 
 /*
  * Highmem IO Regions: This memory map is floating, located after the RAM.
@@ -250,7 +249,7 @@ static MemMapEntry extended_memmap[] = {
     [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
-    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
+    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 0 },
     /* Any CXL Fixed memory windows come here */
 };
 
@@ -2496,9 +2495,14 @@ static void virt_set_high_memmap(VirtMachineState *vms,
 
     for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
         region_enabled = virt_get_high_memmap_enabled(vms, i);
-        region_base = ROUND_UP(base, extended_memmap[i].size);
         region_size = extended_memmap[i].size;
 
+        if (i == VIRT_HIGH_PCIE_MMIO && !region_size) {
+            region_size = CLAMP(pow2floor(BIT_ULL(pa_bits) - base),
+                                64 * KiB, MAX_DEFAULT_HIGH_PCIE_MMIO_SIZE);
+        }
+
+        region_base = ROUND_UP(base, region_size);
         vms->memmap[i].base = region_base;
         vms->memmap[i].size = region_size;
 
@@ -2530,6 +2534,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     hwaddr base, device_memory_base, device_memory_size, memtop;
     int i;
 
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = vms->high_pcie_mmio_size;
     vms->memmap = extended_memmap;
 
     for (i = 0; i < ARRAY_SIZE(base_memmap); i++) {
@@ -3368,7 +3373,8 @@ static void virt_get_highmem_mmio_size(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
-    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    uint64_t size = vms->high_pcie_mmio_size;
 
     visit_type_size(v, name, &size, errp);
 }
@@ -3377,6 +3383,7 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
+    VirtMachineState *vms = VIRT_MACHINE(obj);
     uint64_t size;
 
     if (!visit_type_size(v, name, &size, errp)) {
@@ -3388,15 +3395,13 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
         return;
     }
 
-    if (size < DEFAULT_HIGH_PCIE_MMIO_SIZE) {
-        char *sz = size_to_str(DEFAULT_HIGH_PCIE_MMIO_SIZE);
+    if (size < 64 * KiB) {
         error_setg(errp, "highmem-mmio-size cannot be set to a lower value "
-                         "than the default (%s)", sz);
-        g_free(sz);
+                         "than 64 KiB");
         return;
     }
 
-    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
+    vms->high_pcie_mmio_size = size;
 }
 
 static char *virt_get_msi(Object *obj, Error **errp)
@@ -4372,6 +4377,8 @@ static void virt_instance_init(Object *obj)
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
+    vms->high_pcie_mmio_size = vmc->high_pcie_mmio_size;
+
     /* Default allows ITS instantiation if available */
     vms->msi_controller = VIRT_MSI_CTRL_AUTO;
     /* Allow ITS emulation if the machine version supports it */
@@ -4457,6 +4464,8 @@ static void virt_machine_11_1_options(MachineClass *mc)
      * < 255GiB we keep the legacy memory map.
      */
     vmc->min_highmem_base = base_memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
+
+    vmc->high_pcie_mmio_size = MAX_DEFAULT_HIGH_PCIE_MMIO_SIZE;
 }
 DEFINE_VIRT_MACHINE(11, 1)
 

-- 
2.55.0


