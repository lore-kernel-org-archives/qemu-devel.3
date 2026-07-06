Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5D0C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wginr-0000nm-6c; Mon, 06 Jul 2026 08:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQX-0002sq-9m
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:33 -0400
Received: from [115.124.28.124] (helo=out28-124.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQR-0005Rv-99
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436273|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.0135109-3.74173e-05-0.986452;
 FP=7603985663140579731|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037021130;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.iEESttH_1783317367; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iEESttH_1783317367 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 06 Jul 2026 13:56:07 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Tina Zhang <zhang_wei@open-hieco.net>, Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: [PATCH v1 7/9] hw/i386: Apply AMD IOMMU HT GPA hole to Hygon
Date: Mon,  6 Jul 2026 13:55:28 +0800
Message-ID: <20260706055530.1752094-8-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.124 (deferred)
Received-SPF: pass client-ip=115.124.28.124;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-124.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2026 08:51:41 -0400
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

From: Tina Zhang <zhang_wei@open-hieco.net>

QEMU reserves the HyperTransport special GPA range near the 1 TiB
boundary only for AMD vCPUs.  That range is reserved by the AMD IOMMU
GPA layout, and Linux validates VFIO DMA mappings against IOMMU reserved
regions.

If guest RAM, hotplug address space, or 64-bit MMIO windows overlap the
range, VFIO DMA_MAP can fail with -EINVAL or the IOMMU can report faults
such as INVALID_DEVICE_REQUEST.

The Linux AMD IOMMU driver also handles Hygon systems and reserves the HT
range unless the IOMMU advertises FEATURE_HT_RANGE_IGNORE.  Treat Hygon
vCPUs as using the same AMD IOMMU HT GPA-hole layout in QEMU's PC memory
layout code.

This changes the guest physical memory map for Hygon, so gate the new
Hygon behavior with x-hygon-vendor-abi-fixes.  pc-11.0 and older machine
types keep the previous Hygon memory layout, while the existing
enforce_amd_1tb_hole compatibility keeps the old AMD behavior for pc/q35
<= 7.0.

Add functional coverage for Dhyana on the current q35 machine type and
for the pc-q35-11.0 compatibility case.

Signed-off-by: Yanjing Zhou <zhouyanjing@hygon.cn>
Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 hw/i386/pc.c                                  | 18 +++++++---
 .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++++++++++++++
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 11dade642f..4c029d6a4b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -735,6 +735,12 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 #define AMD_ABOVE_1TB_START  (AMD_HT_END + 1)
 #define AMD_HT_SIZE          (AMD_ABOVE_1TB_START - AMD_HT_START)
 
+static bool x86_cpu_has_amd_iommu_ht_gpa_hole(const X86CPU *cpu)
+{
+    return IS_AMD_CPU(&cpu->env) ||
+           (IS_HYGON_CPU(&cpu->env) && cpu->hygon_vendor_abi_fixes);
+}
+
 void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *system_memory,
                     MemoryRegion *rom_memory,
@@ -759,12 +765,14 @@ void pc_memory_init(PCMachineState *pcms,
     linux_boot = (machine->kernel_filename != NULL);
 
     /*
-     * The HyperTransport range close to the 1T boundary is unique to AMD
-     * hosts with IOMMUs enabled. Restrict the ram-above-4g relocation
-     * to above 1T to AMD vCPUs only. @enforce_amd_1tb_hole is only false in
-     * older machine types (<= 7.0) for compatibility purposes.
+     * The HyperTransport range close to the 1T boundary is reserved by the
+     * AMD IOMMU GPA layout.  Apply the ram-above-4g relocation only to vCPUs
+     * that use that layout. @enforce_amd_1tb_hole preserves older AMD
+     * machine types (<= 7.0), and x-hygon-vendor-abi-fixes preserves older
+     * Hygon machine types (<= 11.0).
      */
-    if (IS_AMD_CPU(&cpu->env) && pcmc->enforce_amd_1tb_hole) {
+    if (x86_cpu_has_amd_iommu_ht_gpa_hole(cpu) &&
+        pcmc->enforce_amd_1tb_hole) {
         /* Bail out if max possible address does not cross HT range */
         if (pc_max_used_gpa(pcms, pci_hole64_size) >= AMD_HT_START) {
             x86ms->above_4g_mem_start = AMD_ABOVE_1TB_START;
diff --git a/tests/functional/x86_64/test_mem_addr_space.py b/tests/functional/x86_64/test_mem_addr_space.py
index 61b4a190b4..e4b4aee008 100755
--- a/tests/functional/x86_64/test_mem_addr_space.py
+++ b/tests/functional/x86_64/test_mem_addr_space.py
@@ -208,6 +208,24 @@ def test_phybits_low_tcg_q35_71_amd(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    def test_phybits_low_tcg_q35_hygon(self):
+        """
+        Check that Dhyana on the default q35 machine follows the AMD IOMMU
+        HT reserved GPA range on new machine types.
+        """
+        self.ensure_64bit_binary()
+        self.set_machine('q35')
+        self.vm.add_args('-S', '-cpu', 'Dhyana,phys-bits=40',
+                         '-m', '512,slots=1,maxmem=976G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
+
     def test_phybits_ok_tcg_q35_70_amd(self):
         """
         Same as q35-7.0 AMD case except that here we check that QEMU can
@@ -225,6 +243,24 @@ def test_phybits_ok_tcg_q35_70_amd(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    def test_phybits_ok_tcg_q35_110_hygon(self):
+        """
+        Same as the default q35 Dhyana case except that here we check that
+        the q35-11.0 compatibility setting keeps the old memory layout.
+        """
+        self.ensure_64bit_binary()
+        self.set_machine('pc-q35-11.0')
+        self.vm.add_args('-S', '-cpu', 'Dhyana,phys-bits=40',
+                         '-m', '512,slots=1,maxmem=976G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
     def test_phybits_ok_tcg_q35_71_amd(self):
         """
         Same as q35-7.1 AMD case except that here we check that QEMU can
-- 
2.43.7


