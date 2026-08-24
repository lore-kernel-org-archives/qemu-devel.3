Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258B6C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 04:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyMjH-0006ed-Bb; Mon, 24 Aug 2026 00:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wyMj8-0006Ym-GU
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 00:56:06 -0400
Received: from [115.124.28.146] (helo=out28-146.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wyMiy-00039A-VX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 00:56:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436326|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.014778-0.000114728-0.985107;
 FP=7604025245577005523|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033037026024;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=8; RT=8; SR=0;
 TI=SMTPD_---.ivXOSsw_1787547224; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.ivXOSsw_1787547224 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 24 Aug 2026 12:53:44 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 08/10] hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
Date: Mon, 24 Aug 2026 12:53:12 +0800
Message-ID: <20260824045314.162941-9-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824045314.162941-1-zhang_wei@open-hieco.net>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.146 (deferred)
Received-SPF: pass client-ip=115.124.28.146;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-146.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

pc_memory_init() avoids the AMD IOMMU HyperTransport range below 1 TiB
only for AMD vCPUs.  Dhyana therefore allows RAM, hotplug address space,
or 64-bit PCI MMIO to overlap 0xfd00000000-0xffffffffff.

Linux supports Dhyana platforms in the AMD IOMMU driver.  The driver
reports this range as reserved unless the IOMMU advertises
FEATURE_HT_RANGE_IGNORE.  A VFIO device cannot DMA to guest addresses
that QEMU places in the reserved range: VFIO_DMA_MAP may fail with
-EINVAL, or the IOMMU may report an INVALID_DEVICE_REQUEST fault.

Apply the AMD IOMMU HT GPA layout to Hygon vCPUs.  When the possible
address space reaches the reserved range, move RAM above 4 GiB to 1 TiB;
also expose the range as reserved in E820 when the vCPU can address it.

Changing the GPA layout affects migration, so enable the Hygon behavior
through x-hygon-vendor-abi-fixes.  pc-11.1 and older machine types retain
their previous Hygon layout.  The existing enforce_amd_1tb_hole setting
continues to preserve the AMD layout of pc/q35 machine types through 7.0.

Add functional tests for Dhyana with pc-q35-11.2 and with pc-q35-11.1
compatibility.

Signed-off-by: Yanjing Zhou <zhouyanjing@hygon.cn>
Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 hw/i386/pc.c                                  | 26 ++++++++++----
 .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++++++++++++++
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2b4e322b2f..1220dbd79c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -738,6 +738,24 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 #define AMD_ABOVE_1TB_START  (AMD_HT_END + 1)
 #define AMD_HT_SIZE          (AMD_ABOVE_1TB_START - AMD_HT_START)
 
+/*
+ * The HyperTransport range close to the 1 TiB boundary is unique to AMD
+ * and Hygon hosts with IOMMUs enabled.  Restrict RAM-above-4G relocation
+ * to above 1 TiB to AMD and Hygon vCPUs only.  @enforce_amd_1tb_hole is
+ * false in machine types through 7.0 and @x-hygon-vendor-abi-fixes is
+ * false in machine types through 11.1, for compatibility purposes.
+ */
+static bool x86_cpu_has_iommu_ht_gpa_hole(const PCMachineClass *pcmc,
+                                           const X86CPU *cpu)
+{
+    if (!pcmc->enforce_amd_1tb_hole) {
+        return false;
+    }
+
+    return IS_AMD_CPU(&cpu->env) ||
+           (IS_HYGON_CPU(&cpu->env) && cpu->hygon_vendor_abi_fixes);
+}
+
 void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *system_memory,
                     MemoryRegion *rom_memory,
@@ -761,13 +779,7 @@ void pc_memory_init(PCMachineState *pcms,
 
     linux_boot = (machine->kernel_filename != NULL);
 
-    /*
-     * The HyperTransport range close to the 1T boundary is unique to AMD
-     * hosts with IOMMUs enabled. Restrict the ram-above-4g relocation
-     * to above 1T to AMD vCPUs only. @enforce_amd_1tb_hole is only false in
-     * older machine types (<= 7.0) for compatibility purposes.
-     */
-    if (IS_AMD_CPU(&cpu->env) && pcmc->enforce_amd_1tb_hole) {
+    if (x86_cpu_has_iommu_ht_gpa_hole(pcmc, cpu)) {
         /* Bail out if max possible address does not cross HT range */
         if (pc_max_used_gpa(pcms, pci_hole64_size) >= AMD_HT_START) {
             x86ms->above_4g_mem_start = AMD_ABOVE_1TB_START;
diff --git a/tests/functional/x86_64/test_mem_addr_space.py b/tests/functional/x86_64/test_mem_addr_space.py
index 61b4a190b4..fa6c603b96 100755
--- a/tests/functional/x86_64/test_mem_addr_space.py
+++ b/tests/functional/x86_64/test_mem_addr_space.py
@@ -208,6 +208,24 @@ def test_phybits_low_tcg_q35_71_amd(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    def test_phybits_low_tcg_q35_112_hygon(self):
+        """
+        Same as q35-7.1 AMD case except that here we check that Dhyana
+        follows the same AMD IOMMU HT reserved GPA range with q35-11.2.
+        """
+        self.ensure_64bit_binary()
+        self.set_machine('pc-q35-11.2')
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
 
+    def test_phybits_ok_tcg_q35_111_hygon(self):
+        """
+        Same as q35-7.1 Dhyana case except that here we check that the
+        q35-11.1 compatibility setting keeps the old memory layout.
+        """
+        self.ensure_64bit_binary()
+        self.set_machine('pc-q35-11.1')
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


