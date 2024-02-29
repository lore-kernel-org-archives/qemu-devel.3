Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C973C54E55
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa8k-0001m3-O8; Thu, 29 Feb 2024 01:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa8i-0001ca-6M
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:43:32 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa8g-0005GA-5D
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709189010; x=1740725010;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bpiEWdbIOSB0Vk3WG0GrZLWQS9tv1g7VIXpQTZ0EQmE=;
 b=FhFiCG2ZwyL5B6xRivkIxTFwllIwN+mxZs+ggbwWUjq7Nh11oUImAWPc
 e4cZYimfoEuAWToJ9E7JHVhCuAkQmUVIETfm+XP8b4lhujBs0dhN2BY7a
 fj/O3Xsknqctpcw9yba1wdqdObZmsVUpz1TwXdVQd9UPi6KSyUvgoPNVA
 rbepuQHVbnbzMmyQ5FSQfpTmVYIDSw4fc3M3sRu/RIbH66ZlHHRvDml1C
 kCOAVwq23h/ZW0hI8ikjBQrRYVmnjEceyuDzorvgiYe1PUD886/uHHyJ0
 8TXXlqxlfcNg5TZPvStsVDqOnmkm8SZfFANFVnhpUshv408W/lUNZbdCE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3803155"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3803155"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:43:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8076227"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:43:23 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH v5 54/65] q35: Introduce smm_ranges property for q35-pci-host
Date: Thu, 29 Feb 2024 01:37:15 -0500
Message-Id: <20240229063726.610065-55-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229063726.610065-1-xiaoyao.li@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Isaku Yamahata <isaku.yamahata@linux.intel.com>

Add a q35 property to check whether or not SMM ranges, e.g. SMRAM, TSEG,
etc... exist for the target platform.  TDX doesn't support SMM and doesn't
play nice with QEMU modifying related guest memory ranges.

Signed-off-by: Isaku Yamahata <isaku.yamahata@linux.intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_q35.c          |  2 ++
 hw/pci-host/q35.c         | 42 +++++++++++++++++++++++++++------------
 include/hw/i386/pc.h      |  1 +
 include/hw/pci-host/q35.h |  1 +
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 45a4102e75f5..dc3f68676ea0 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -212,6 +212,8 @@ static void pc_q35_init(MachineState *machine)
                             x86ms->above_4g_mem_size, NULL);
     object_property_set_bool(phb, PCI_HOST_BYPASS_IOMMU,
                              pcms->default_bus_bypass_iommu, NULL);
+    object_property_set_bool(phb, PCI_HOST_PROP_SMM_RANGES,
+                             x86_machine_is_smm_enabled(x86ms), NULL);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 98d4a7c253a6..0b6cbaed7ed5 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -179,6 +179,8 @@ static Property q35_host_props[] = {
                      mch.below_4g_mem_size, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
                      mch.above_4g_mem_size, 0),
+    DEFINE_PROP_BOOL(PCI_HOST_PROP_SMM_RANGES, Q35PCIHost,
+                     mch.has_smm_ranges, true),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -214,6 +216,7 @@ static void q35_host_initfn(Object *obj)
     /* mch's object_initialize resets the default value, set it again */
     qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
                          Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
+
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         q35_host_get_pci_hole_start,
                         NULL, NULL, NULL);
@@ -476,6 +479,10 @@ static void mch_write_config(PCIDevice *d,
         mch_update_pciexbar(mch);
     }
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
                        MCH_HOST_BRIDGE_SMRAM_SIZE)) {
         mch_update_smram(mch);
@@ -494,10 +501,13 @@ static void mch_write_config(PCIDevice *d,
 static void mch_update(MCHPCIState *mch)
 {
     mch_update_pciexbar(mch);
+
     mch_update_pam(mch);
-    mch_update_smram(mch);
-    mch_update_ext_tseg_mbytes(mch);
-    mch_update_smbase_smram(mch);
+    if (mch->has_smm_ranges) {
+        mch_update_smram(mch);
+        mch_update_ext_tseg_mbytes(mch);
+        mch_update_smbase_smram(mch);
+    }
 
     /*
      * pci hole goes from end-of-low-ram to io-apic.
@@ -538,19 +548,21 @@ static void mch_reset(DeviceState *qdev)
     pci_set_quad(d->config + MCH_HOST_BRIDGE_PCIEXBAR,
                  MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT);
 
-    d->config[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_DEFAULT;
-    d->config[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_DEFAULT;
-    d->wmask[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_WMASK;
-    d->wmask[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_WMASK;
+    if (mch->has_smm_ranges) {
+        d->config[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_DEFAULT;
+        d->config[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_DEFAULT;
+        d->wmask[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_WMASK;
+        d->wmask[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_WMASK;
 
-    if (mch->ext_tseg_mbytes > 0) {
-        pci_set_word(d->config + MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
-                     MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
+        if (mch->ext_tseg_mbytes > 0) {
+            pci_set_word(d->config + MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
+                        MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
+        }
+
+        d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
+        d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
     }
 
-    d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
-    d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
-
     mch_update(mch);
 }
 
@@ -578,6 +590,10 @@ static void mch_realize(PCIDevice *d, Error **errp)
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
                              mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 5065590281a1..91be8e3b35b5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -161,6 +161,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 #define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
 #define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
 #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
+#define PCI_HOST_PROP_SMM_RANGES       "smm-ranges"
 
 
 void pc_pci_as_mapping_init(MemoryRegion *system_memory,
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index bafcbe675214..22fadfa3ed76 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -50,6 +50,7 @@ struct MCHPCIState {
     MemoryRegion tseg_blackhole, tseg_window;
     MemoryRegion smbase_blackhole, smbase_window;
     bool has_smram_at_smbase;
+    bool has_smm_ranges;
     Range pci_hole;
     uint64_t below_4g_mem_size;
     uint64_t above_4g_mem_size;
-- 
2.34.1


