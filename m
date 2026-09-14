Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2076AC88E70
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63AQ-0003nS-Fq; Mon, 14 Sep 2026 05:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AO-0003lI-Un; Mon, 14 Sep 2026 05:40:01 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AM-0001Qc-Od; Mon, 14 Sep 2026 05:40:00 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9ddbw024283
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:39:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=hfXOxNhgyvb8AQCZcAX4QjuBjBcWOsa4u7uJV9L+VRw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378783; v=1;
 b=fJrMoCzVC1JdPbCzuFjYs/dUnBJ8EkL4XY4fb0kuryIwrBdb0+KXUILRiMXDYP9h
 QoFUtzlzZdOxNmoSCfw32zBZJyNGMLjb6ujOFlG2aHKKjvXA8A+y4mNSWfcKMaMb
 R/pH3N4Vx1L/z/lNsuy7UW//Qy9RXln5pDINVoIobzNaN+tf/Vu/2HG9HfqahrES
 wIm+UAstT64YQSp0UzddGhOUU7AXQsCbQ1Ueen+N1+d+kD2Hv5LUbn6OoFoJM4/T
 7WRWlOBLbxvdPjCygPg4JV2s4WHgt/ieFwkeq4xXuXyukD+uh3Y2XE9jWVfoDwZX
 kr+5KJWsDrr8g3snchGfqw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:39:24 +0900
Subject: [PATCH v8 3/5] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-virt-v8-3-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5693;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=WH/cPDbmNsqwg4tEuzyf+oCc5uuIlH5jH40f20cR0fs=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9byAzfvWOw4pftjTZL6woRkjcquZd1a4l9v1gnO0Gz/s
 WzTJZZlHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABPJUGBk+GGnM2eylMminvWP
 t/2YY/nOdI7hApkzV5L6NlZc7Unv/8jIsGyqe1bULZU3SlaPOvTD7s56GtwdYXNf7XRhSKwm56u
 TTAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Remove the lower bound of the Highmem IO Regions' addresses for the
latest machine version to increase the chance to fit the regions in the
PA space.

The lower bound was especially problematic when using virt-install on
Apple M2. virt-install 5.0.0 adds multiple pcie-root-port devices that
require sufficient space in the ECAM region. However, the Highmem ECAM
region did not fit in the limited PA space on the hardware, and the ECAM
region size was limited to 16 MiB. If virt-install had added more than
16 devices to the root bridge, the region overflowed, which prevented
edk2-stable202505 from scanning PCI devices, including the boot disk,
causing boot failures.

Ideally, a virtual machine with more than 16 devices added to the root
bridge should just work so that users and management layers do not have
to care whether they use constrained hardware.

The base address of the Highmem IO Regions was fixed when commit
f90747c4e8fb ("hw/arm/virt: GICv3 DT node with one or two redistributor
regions") added the first Highmem IO Region. Later, commit 957e32cffa57
("hw/arm/virt: Dynamic memory map depending on RAM requirements")
allowed moving the Highmem IO Regions to higher addresses to accommodate
RAM more than 255 GiB, but the lower bound remained to keep the legacy
memory map.

Remove the lower bound for the latest machine version to accommodate
more devices with the root bridge. Keeping the lower bound for the old
machine versions ensures the compatibility is still maintained.

The hardcoded memory map in tests/qtest/libqos/generic-pcihost.c is also
updated.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/arm/virt.h                |  1 +
 hw/arm/virt.c                        | 19 +++++++++++++------
 tests/qtest/libqos/generic-pcihost.c |  2 +-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a113c..3f1eb0583c94 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -145,6 +145,7 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
+    hwaddr min_highmem_base;
     bool no_tcg_its;
     bool no_highmem_compact;
     bool no_kvm_steal_time;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0871a35e11f7..79a896ee578b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -230,8 +230,7 @@ static const MemMapEntry base_memmap[] = {
  * Highmem IO Regions: This memory map is floating, located after the RAM.
  * Each MemMapEntry base (GPA) will be dynamically computed, depending on the
  * top of the RAM, so that its base get the same alignment as the size,
- * ie. a 512GiB entry will be aligned on a 512GiB boundary. If there is
- * less than 256GiB of RAM, the floating area starts at the 256GiB mark.
+ * ie. a 512GiB entry will be aligned on a 512GiB boundary.
  * Note the extended_memmap is sized so that it eventually also includes the
  * base_memmap entries (VIRT_HIGH_GIC_REDIST2 index is greater than the last
  * index of base_memmap).
@@ -2527,6 +2526,7 @@ static void virt_set_high_memmap(VirtMachineState *vms,
 static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
 {
     MachineState *ms = MACHINE(vms);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     hwaddr base, device_memory_base, device_memory_size, memtop;
     int i;
 
@@ -2553,8 +2553,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     /*
      * We compute the base of the high IO region depending on the
      * amount of initial and device memory. The device memory start/size
-     * is aligned on 1GiB. We never put the high IO region below 256GiB
-     * so that if maxram_size is < 255GiB we keep the legacy memory map.
+     * is aligned on 1GiB.
      * The device region size assumes 1GiB page max alignment per slot.
      */
     device_memory_base =
@@ -2572,8 +2571,8 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
         error_report("maxmem/slots too huge");
         exit(EXIT_FAILURE);
     }
-    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
-        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
+    if (base < vmc->min_highmem_base) {
+        base = vmc->min_highmem_base;
     }
 
     /* We know for sure that at least the memory fits in the PA space */
@@ -4448,8 +4447,16 @@ DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
 
 static void virt_machine_11_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_11_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
+
+    /*
+     * Do not put the high IO region below 256GiB so that if maxram_size is
+     * < 255GiB we keep the legacy memory map.
+     */
+    vmc->min_highmem_base = base_memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
 }
 DEFINE_VIRT_MACHINE(11, 1)
 
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index b77617524cac..287e8445ec5b 100644
--- a/tests/qtest/libqos/generic-pcihost.c
+++ b/tests/qtest/libqos/generic-pcihost.c
@@ -210,7 +210,7 @@ void qpci_init_generic(QGenericPCIBus *qpci, QTestState *qts,
     qpci->bus.pio_limit = 0x10000;
     qpci->bus.mmio_alloc_ptr = 0x10000000;
     qpci->bus.mmio_limit = 0x2eff0000;
-    qpci->ecam_alloc_ptr = 0x4010000000;
+    qpci->ecam_alloc_ptr = 0x90000000;
 
     qpci->obj.get_driver = qpci_generic_get_driver;
 }

-- 
2.55.0


