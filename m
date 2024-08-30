Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8AACA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 04:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjt3y-0005mZ-Az; Fri, 30 Aug 2024 00:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1sjt3q-0005f3-TS; Fri, 30 Aug 2024 00:16:35 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1sjt3n-0001go-68; Fri, 30 Aug 2024 00:16:34 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3ZNCXR9Fm8s5CAg--.6149S2;
 Fri, 30 Aug 2024 12:16:23 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC34bGOR9FmmakpAA--.16568S5;
 Fri, 30 Aug 2024 12:16:23 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com, quic_llindhol@quicinc.com,
 peter.maydell@linaro.org, marcin.juszkiewicz@linaro.org
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 chenbaozi@phytium.com.cn, wangyinfeng@phytium.com.cn,
 shuyiqi@phytium.com.cn, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH 2/2] hw/arm/sbsa-ref: Support CXL Fixed Memory Window
Date: Fri, 30 Aug 2024 12:15:57 +0800
Message-Id: <20240830041557.600607-3-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC34bGOR9FmmakpAA--.16568S5
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWbQ2MkCXQAAs1
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AryrWr17Zw4ftw17Cw4xXrb_yoW3CF45pF
 s8uw43Wr48GFWvvrs2qayDJF15urWkCayjkrZrCrs29F17Kr18Xr4DKayYyFyUJrWDKry8
 Z3WxZr1Fva15Zw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to provide CFMWs on sbsa-ref, this extends 1TB space
from the hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory
Window. 0xA0000000000 is chosen as the base address of this
space because of 3 reasons:

1) It is more suitable to choose a static address instead of that
implementation in virt, since a dynamic address space layout of
sbsa-ref is not appropriate for its original purpose as a reference
platform.

2) The Hotplug Memory address range should in the range of maximum
addressable range of sbsa-ref platform(0x10000000000-0x80ffffffffff).
It is satisfied the requirements of memory hotplug in linux kernel.

3) The start pfn of CFMW should exceed the reserved_pfn_range for
onlined numa node.

Based on 'cxl_fmws_link_targets', this adds a new function
'sbsa_cxl_fmws_link_targets' for binding cfmws.target with the default
pxb-cxl-bus on sbsa-ref.

In addition, this also adds 'create_cxl_fixed_window_region' which
based on 'machine_set_cfmw' to support creating a static cfmw region on
sbsa-ref.

Thus, to run sbsa-ref with a cxl device could use:
qemu-system-aarch64 \
-machine sbsa-ref \
-cpu cortex-a57 \
-smp 4 \
-m 4G \
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \
-object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
-device cxl-type3,bus=cxl.0,volatile-memdev=mem2,id=cxl-mem1 \
-hda ubuntu.ext4 \
-pflash SBSA_FLASH0.fd \
-pflash SBSA_FLASH1.fd \

I'm not sure if the new space layout would bring a series of bad
influence, this patch is here to hopefully some comments to guide me!

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/arm/sbsa-ref.c                   | 73 +++++++++++++++++++++++++++++
 hw/cxl/cxl-host-stubs.c             |  1 +
 hw/cxl/cxl-host.c                   |  2 +-
 hw/pci-bridge/pci_expander_bridge.c |  1 -
 include/hw/cxl/cxl_host.h           |  1 +
 include/hw/pci/pci_bridge.h         |  1 +
 6 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index dc924d181e..b10865920e 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -100,6 +100,7 @@ enum {
     SBSA_AHCI,
     SBSA_XHCI,
     SBSA_CXL_HOST,
+    SBSA_CXL_FIXED_WINDOW,
 };
 
 struct SBSAMachineState {
@@ -152,6 +153,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
     [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
     [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
+    /* 1TB CXL FIXED WINDOW space */
+    [SBSA_CXL_FIXED_WINDOW] =   { 0xA0000000000ULL, 0x10000000000ULL },
 };
 
 static const int sbsa_ref_irqmap[] = {
@@ -734,6 +737,72 @@ static void create_cxl_host_reg_region(SBSAMachineState *sms)
     memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_CXL_HOST].base, mr);
 }
 
+static void create_cxl_fixed_window_region(SBSAMachineState *sms, MemoryRegion *mem)
+{
+    char cxl_host[] = "pxb-cxl-bus.0";
+    CXLFixedMemoryWindowOptionsList *list;
+    hwaddr base, end;
+    GList *it;
+    strList host_target = { NULL, cxl_host };
+    CXLFixedMemoryWindowOptions sbsa_ref_cfmwoptions = {
+        .size = 1 * TiB,
+        .has_interleave_granularity = false,
+        .targets = &host_target,
+    };
+    CXLFixedMemoryWindowOptionsList sbsa_ref_cfmwlist = { NULL, &sbsa_ref_cfmwoptions };
+
+    for (list = &sbsa_ref_cfmwlist; list; list = list->next) {
+        cxl_fixed_memory_window_config(&sms->cxl_devices_state, list->value, &error_fatal);
+    }
+
+    base = sbsa_ref_memmap[SBSA_CXL_FIXED_WINDOW].base;
+    end = base + sbsa_ref_memmap[SBSA_CXL_FIXED_WINDOW].size;
+
+    for (it = sms->cxl_devices_state.fixed_windows; it; it = it->next) {
+        CXLFixedWindow *fw = it->data;
+        if (base + fw->size > end) {
+            error_report("CFMWS does not fit under PA limit");
+            exit(EXIT_FAILURE);
+        }
+
+        fw->base = base;
+        memory_region_init_io(&fw->mr, OBJECT(sms), &cfmws_ops, fw,
+                                "cxl-fixed-memory-region", fw->size);
+
+        memory_region_add_subregion(mem, fw->base, &fw->mr);
+        base += fw->size;
+    }
+}
+
+static void sbsa_cxl_fmws_link_targets(SBSAMachineState *sms,
+                                CXLState *cxl_state, Error **errp)
+{
+    PXBCXLDev *pxb =  PXB_CXL_DEV(pci_bridge_get_device(sms->cxlbus));
+    if (cxl_state && cxl_state->fixed_windows) {
+        GList *it;
+
+        for (it = cxl_state->fixed_windows; it; it = it->next) {
+            CXLFixedWindow *fw = it->data;
+            int i;
+
+            for (i = 0; i < fw->num_targets; i++) {
+                Object *o;
+                bool ambig;
+
+                o = object_resolve_path_type(fw->targets[i],
+                                             TYPE_PXB_CXL_BUS,
+                                             &ambig);
+                if (!o) {
+                    error_setg(errp, "Could not resolve CXLFM target %s",
+                               fw->targets[i]);
+                    return;
+                }
+                fw->target_hbs[i] = pxb;
+            }
+        }
+    }
+}
+
 static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 {
     const SBSAMachineState *board = container_of(binfo, SBSAMachineState,
@@ -869,8 +938,12 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_cxl_host_reg_region(sms);
 
+    create_cxl_fixed_window_region(sms, sysmem);
+
     cxl_hook_up_pxb_registers(sms->bus, &sms->cxl_devices_state, &error_fatal);
 
+    sbsa_cxl_fmws_link_targets(sms, &sms->cxl_devices_state, &error_fatal);
+
     create_secure_ec(secure_sysmem);
 
     sms->bootinfo.ram_size = machine->ram_size;
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index cae4afcdde..d523be24a2 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -11,5 +11,6 @@
 void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
+void cxl_fixed_memory_window_config(CXLState *cxl_state, CXLFixedMemoryWindowOptions *object, Error **errp) {};
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e9f2543c43..d408c7db15 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -22,7 +22,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 
-static void cxl_fixed_memory_window_config(CXLState *cxl_state,
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
                                            CXLFixedMemoryWindowOptions *object,
                                            Error **errp)
 {
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 0411ad31ea..f5431443b9 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
                          TYPE_PXB_CXL_BUS)
 
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index c9bc9c7c50..5fbf5a9347 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -16,6 +16,7 @@
 void cxl_machine_init(Object *obj, CXLState *state);
 void cxl_fmws_link_targets(CXLState *stat, Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+void cxl_fixed_memory_window_config(CXLState *cxl_state, CXLFixedMemoryWindowOptions *object, Error **errp);
 
 extern const MemoryRegionOps cfmws_ops;
 
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 5cd452115a..5456e24883 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -102,6 +102,7 @@ typedef struct PXBPCIEDev {
     PXBDev parent_obj;
 } PXBPCIEDev;
 
+#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 #define TYPE_PXB_DEV "pxb"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
 
-- 
2.34.1


