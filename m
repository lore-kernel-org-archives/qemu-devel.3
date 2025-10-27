Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4396CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKKH-00071l-Kb; Mon, 27 Oct 2025 06:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDKK8-0006xH-FX; Mon, 27 Oct 2025 06:19:37 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDKK1-000583-9V; Mon, 27 Oct 2025 06:19:36 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59RAJBfT020236
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Oct 2025 19:19:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vwK46QBy577Hg17SvAZaD/3Q8x1F/+QxuUCuknFIQiU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761560360; v=1;
 b=S6ucNcFETSpSlJW/QKoKNY6+Sw3qZsD5vaQuEBV0lfCHjmRF0L3zNMsHLb6VVLaT
 pPFIkRCCmV0l84SObqmxj2bPdsrnBNseSfS3YGWB1GQ8f//8gYF1D5Xux1Ua1SxW
 M+71veoM40oMNTdArR0YZFHXY0EKDHM39saRQrZYlgHj0wyOc1+3fu6cjVdWF5jK
 fwiuFcPI1DZKpsZ+GIZRUgPnvMegEaJZ3kbJZiMO1MrP/tWU+ih/JCsLF2JppNku
 jsZPEai8ni2N3Uvbqut1fMTNMK4baDhvXSe9Q2/wuHUicfQNNvmLKoa2Y2kCUUzQ
 zDPTlwgcb0fhtRB7TPgP1A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Oct 2025 19:19:07 +0900
Subject: [PATCH v3 2/3] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-virt-v3-2-fa2a2f37e32d@rsg.ci.i.u-tokyo.ac.jp>
References: <20251027-virt-v3-0-fa2a2f37e32d@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251027-virt-v3-0-fa2a2f37e32d@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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
---
 include/hw/arm/virt.h                |  1 +
 hw/arm/virt.c                        | 16 ++++++++++++----
 tests/qtest/libqos/generic-pcihost.c |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 04a09af35406..1b1c4cda9c54 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -121,6 +121,7 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
+    hwaddr min_highmem_base;
     bool no_tcg_its;
     bool no_highmem_compact;
     bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a73..fcd3a3d624e2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1932,6 +1932,7 @@ static void virt_set_high_memmap(VirtMachineState *vms,
 static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
 {
     MachineState *ms = MACHINE(vms);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     hwaddr base, device_memory_base, device_memory_size, memtop;
     int i;
 
@@ -1958,8 +1959,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     /*
      * We compute the base of the high IO region depending on the
      * amount of initial and device memory. The device memory start/size
-     * is aligned on 1GiB. We never put the high IO region below 256GiB
-     * so that if maxram_size is < 255GiB we keep the legacy memory map.
+     * is aligned on 1GiB.
      * The device region size assumes 1GiB page max alignment per slot.
      */
     device_memory_base =
@@ -1977,8 +1977,8 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
         error_report("maxmem/slots too huge");
         exit(EXIT_FAILURE);
     }
-    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
-        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
+    if (base < vmc->min_highmem_base) {
+        base = vmc->min_highmem_base;
     }
 
     /* We know for sure that at least the memory fits in the PA space */
@@ -3536,9 +3536,17 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_2_options(mc);
     mc->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+
+    /*
+     * Do not put the high IO region below 256GiB so that if maxram_size is
+     * < 255GiB we keep the legacy memory map.
+     */
+    vmc->min_highmem_base = base_memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
 }
 DEFINE_VIRT_MACHINE(10, 1)
 
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index 4bbeb5ff508e..01d698a2490d 100644
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
2.51.0


