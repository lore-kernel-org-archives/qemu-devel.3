Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0528CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSFq3-0001VD-Av; Wed, 27 May 2026 11:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSFq1-0001UF-Ar; Wed, 27 May 2026 11:06:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSFpx-0003dR-OX; Wed, 27 May 2026 11:06:29 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64RF5nBl078744
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 May 2026 00:06:08 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Dk9esH+Fk8rSH8ovg2aY7QTovyrHdSXzbZzrE1JpDmc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779894369; v=1;
 b=AXLaPuuo0kkDpmbonUcVDJztesV6GYeYIq93WRMHyGXYdXeFBZk82UynU1caXpxv
 1g7PFwFpgRCU00Bo8fbM9aKNxrJEWcaPLjOUZ1YzcAoq8wLn/oeJfF7bLOkmiw4Y
 k43ETfgOwYmm6/SozT2x0rMoWUbmFhJ+KSRy/RwunHpbJsQxayYjdPY8z6a6qbH3
 pTubvrTzis/hZa/vni8PdIs/AiPzNPYHsd1yuGnYfDTqd989rBWVju9XqHpV/eqE
 n1IGdsopCJcnOIVJ5wcf4OYCkIZQNg0TBYeOu8NtsVvqriYAYp8axZwsHIPFu89Z
 F8qsqvtuSosRBhsusF2/nw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 May 2026 00:05:44 +0900
Subject: [PATCH v7 4/5] hw/arm/virt: Relax the lower bound of HighMem MMIO
 region size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-virt-v7-4-42c4d18620b8@rsg.ci.i.u-tokyo.ac.jp>
References: <20260528-virt-v7-0-42c4d18620b8@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260528-virt-v7-0-42c4d18620b8@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=4988;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=IDqNDuoTnTZhnDAFjYZMWy3jwXqBtU4Lg6QQ0mAdB7A=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5Y4R9w1d0F595ezzF5PVb1uJ2KR7+fJosWbnnoovvGAm
 ODXphcdpSwMYlwMsmKKLClFu7k1oms/FSbEt8DMYWUCGcLAxSkAEzm8mpHhLsemY9f0nvHeWVEY
 /Fal/9fGPdpdZ0y35vf6930rqthZwPDf/WRWycN8/2WHElL6MrkC95V9jHTdUO+ScSi0+EnyjEh
 mAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
---
 docs/system/arm/virt.rst |  2 +-
 include/hw/arm/virt.h    |  1 +
 hw/arm/virt.c            | 22 ++++++++++++++--------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index f811e662d68d..c8284ce2fa0e 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -149,7 +149,7 @@ highmem-mmio
 
 highmem-mmio-size
   Set the high memory region size for PCI MMIO. Must be a power of 2 and
-  greater than or equal to the default size (512G).
+  greater than or equal to 64 KiB.
 
 gic-version
   Specify the version of the Generic Interrupt Controller (GIC) to provide.
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 6c8ba8f3185b..7aa289d3936f 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -143,6 +143,7 @@ typedef enum VirtGICType {
 struct VirtMachineClass {
     MachineClass parent;
     hwaddr min_highmem_base;
+    hwaddr high_pcie_mmio_size;
     bool no_tcg_its;
     bool no_highmem_compact;
     bool no_kvm_steal_time;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 78a85a966ad7..dd97b0dd6a42 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -222,8 +222,7 @@ static const MemMapEntry base_memmap[] = {
 };
 
 /* Update the docs for highmem-mmio-size when changing this default */
-#define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
-#define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
+#define MAX_DEFAULT_HIGH_PCIE_MMIO_SIZE (512 * GiB)
 
 /*
  * Highmem IO Regions: This memory map is floating, located after the RAM.
@@ -249,7 +248,7 @@ static MemMapEntry extended_memmap[] = {
     [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
-    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
+    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 0 },
     /* Any CXL Fixed memory windows come here */
 };
 
@@ -2448,9 +2447,14 @@ static void virt_set_high_memmap(VirtMachineState *vms,
 
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
 
@@ -3340,11 +3344,9 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
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
 
@@ -4271,6 +4273,8 @@ static void virt_instance_init(Object *obj)
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = vmc->high_pcie_mmio_size;
+
     /* EL3 is disabled by default on virt: this makes us consistent
      * between KVM and TCG for this board, and it also allows us to
      * boot UEFI blobs which assume no TrustZone support.
@@ -4372,6 +4376,8 @@ static void virt_machine_11_0_options(MachineClass *mc)
      * < 255GiB we keep the legacy memory map.
      */
     vmc->min_highmem_base = base_memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
+
+    vmc->high_pcie_mmio_size = MAX_DEFAULT_HIGH_PCIE_MMIO_SIZE;
 }
 DEFINE_VIRT_MACHINE(11, 0)
 

-- 
2.54.0


