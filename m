Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1FDFB5EA8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 03:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2LBv-00087s-VP; Mon, 16 Mar 2026 23:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w2LBv-00087j-1q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:33:59 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w2LBt-00008F-3j
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:33:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773718403; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fa/GTFaX1/ass1qmMTR65grzbHeDpRDMY8kZrBB51lqgWIL6d6WhUd50LVCubMe0fqBVRTVI33ojBU0PqQ84T2rLRL3uNBvpNGzg5UM40nM+q/V64VMZME1kIeeZk/Y8O57OVbqvvM4gfhjfpyLbDcKxAlzjecsXYDAlSBNOUXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773718403;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8k5It4q+xFLxZOvwSdGfsRa0V4tnBY9OqsmZUuJiXRg=; 
 b=TPrUT2BzLPQFnC4Z3OhQWFbBPwx0uTXhXFR1061Zl0Tl//8IjdJ4EHhJiEQSGwL+VPepkJtx3sKEWzxe0lOGfePAQvZFRjPi9wiIAGuIG5ShQ0sJp6SNXeg4U5qqh+oMfPJYXHaUrrco12jVSYTt4j0yjok5A5MOocMCotZXiJ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773718403; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=8k5It4q+xFLxZOvwSdGfsRa0V4tnBY9OqsmZUuJiXRg=;
 b=dSN1vnGgO2HZ7mO4+p6gswPIQOpGBzSifDl7gxf0bAGA2jKfnfz+m+85SXo0klKM
 6QZ3/EPY7bGMZKcsozXYcXU2w2Bda7T1DtgMhB2OtHrnyiK46guFFwET+v1Xh0QAoiL
 y1z2BR2FDYM9puLLzJLiRBLR31JwpCDW9rqa0INU=
Received: by mx.zohomail.com with SMTPS id 1773718401060491.58571380308786;
 Mon, 16 Mar 2026 20:33:21 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Cc: qemu-devel@nongnu.org,
	Li Chen <me@linux.beauty>
Subject: [PATCH 2/3] cxl: alias fixed memory windows to RAM under KVM
Date: Tue, 17 Mar 2026 11:33:02 +0800
Message-ID: <20260317033304.3185291-3-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317033304.3185291-1-me@linux.beauty>
References: <20260317033304.3185291-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

CXL fixed memory windows are currently modeled as an I/O MemoryRegion, so
KVM treats the whole range as MMIO. After Linux onlines the window as
system RAM, normal CPU stores can land in the window and trigger KVM
instruction emulation. Instructions like XSAVEC are not supported by the
emulator and abort the VM with a KVM internal error.

Turn the fixed window into a container that always contains the existing
MMIO dispatcher, and add an optional RAM alias overlay when the window
maps linearly to a Type-3 volatile memdev.

Signed-off-by: Li Chen <me@linux.beauty>
---
 hw/cxl/cxl-host-stubs.c   |   1 +
 hw/cxl/cxl-host.c         | 189 +++++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl.h      |   5 +
 include/hw/cxl/cxl_host.h |   1 +
 4 files changed, 194 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index c015baac81..e7e955121f 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -16,5 +16,6 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
     return base;
 };
 void cxl_fmws_update_mmio(void) {};
+void cxl_fmws_update_mappings(void) {};
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f3479b1991..7f6974626e 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -10,6 +10,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "system/kvm.h"
 #include "system/qtest.h"
 #include "hw/core/boards.h"
 
@@ -22,6 +23,164 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 
+static void cxl_fmw_disable_direct(CXLFixedWindow *fw)
+{
+    if (!fw->direct_target_mr) {
+        return;
+    }
+
+    memory_region_transaction_begin();
+    if (fw->direct_mapped) {
+        memory_region_del_subregion(&fw->mr, &fw->direct_mr);
+    }
+    object_unparent(OBJECT(&fw->direct_mr));
+    memory_region_transaction_commit();
+
+    fw->direct_mapped = false;
+    fw->direct_target_mr = NULL;
+    fw->direct_target_offset = 0;
+}
+
+static bool cxl_hdm_decoder_simple_target(uint32_t *cache_mem, hwaddr base,
+                                         hwaddr size, uint8_t *target)
+{
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+    unsigned int hdm_count;
+    uint32_t cap, global_ctrl;
+    int i;
+
+    global_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_GLOBAL_CONTROL);
+    if (!FIELD_EX32(global_ctrl, CXL_HDM_DECODER_GLOBAL_CONTROL,
+                    HDM_DECODER_ENABLE)) {
+        return false;
+    }
+
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
+                                                 CXL_HDM_DECODER_CAPABILITY,
+                                                 DECODER_COUNT));
+    for (i = 0; i < hdm_count; i++) {
+        uint32_t low, high, ctrl;
+        uint64_t decoder_base, decoder_size;
+        uint32_t tlo;
+        uint8_t iw;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
+        decoder_base = (low & 0xf0000000) | ((uint64_t)high << 32);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
+        decoder_size = (low & 0xf0000000) | ((uint64_t)high << 32);
+
+        if (decoder_base != base || decoder_size != size) {
+            continue;
+        }
+
+        ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
+        if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
+            continue;
+        }
+
+        iw = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
+        if (iw != 0) {
+            return false;
+        }
+
+        tlo = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_TARGET_LIST_LO +
+                       i * hdm_inc);
+        *target = extract32(tlo, 0, 8);
+        return true;
+    }
+
+    return false;
+}
+
+static bool cxl_fmw_enable_direct(CXLFixedWindow *fw)
+{
+    CXLComponentState *hb_cstate;
+    PCIHostState *hb;
+    PCIDevice *rp, *d;
+    CXLType3Dev *ct3d;
+    MemoryRegion *target_mr = NULL;
+    hwaddr target_offset = 0;
+    uint32_t *cache_mem;
+    uint8_t target;
+    Error *local_err = NULL;
+
+    if (!kvm_enabled()) {
+        return false;
+    }
+
+    if (fw->num_targets != 1) {
+        return false;
+    }
+
+    if (!fw->base || !fw->target_hbs[0] ||
+        !fw->target_hbs[0]->cxl_host_bridge) {
+        return false;
+    }
+
+    hb = PCI_HOST_BRIDGE(fw->target_hbs[0]->cxl_host_bridge);
+    if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
+        return false;
+    }
+
+    hb_cstate = cxl_get_hb_cstate(hb);
+    if (!hb_cstate) {
+        return false;
+    }
+
+    cache_mem = hb_cstate->crb.cache_mem_registers;
+    if (!cxl_hdm_decoder_simple_target(cache_mem, fw->base, fw->size,
+                                       &target)) {
+        return false;
+    }
+
+    rp = pcie_find_port_by_pn(hb->bus, target);
+    if (!rp) {
+        return false;
+    }
+
+    d = pci_bridge_get_sec_bus(PCI_BRIDGE(rp))->devices[0];
+    if (!d) {
+        return false;
+    }
+
+    if (!object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
+        return false;
+    }
+    ct3d = CXL_TYPE3(d);
+
+    if (!cxl_type3_get_window_vmem_mapping(ct3d, fw->base, fw->size,
+                                           &target_mr, &target_offset,
+                                           &local_err)) {
+        error_free(local_err);
+        return false;
+    }
+    error_free(local_err);
+
+    if (fw->direct_mapped && fw->direct_target_mr == target_mr &&
+        fw->direct_target_offset == target_offset) {
+        return true;
+    }
+
+    cxl_fmw_disable_direct(fw);
+
+    memory_region_init_alias(&fw->direct_mr, OBJECT(fw),
+                             "cxl-fixed-memory-region.direct", target_mr,
+                             target_offset, fw->size);
+    memory_region_transaction_begin();
+    memory_region_add_subregion_overlap(&fw->mr, 0, &fw->direct_mr, 1);
+    memory_region_transaction_commit();
+
+    fw->direct_mapped = true;
+    fw->direct_target_mr = target_mr;
+    fw->direct_target_offset = target_offset;
+
+    return true;
+}
+
 static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
 {
@@ -432,6 +591,25 @@ void cxl_fmws_update_mmio(void)
     object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map, NULL);
 }
 
+void cxl_fmws_update_mappings(void)
+{
+    GSList *cfmws_list, *iter;
+    CXLFixedWindow *fw;
+
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        fw = CXL_FMW(iter->data);
+        if (!cxl_fmw_enable_direct(fw)) {
+            cxl_fmw_disable_direct(fw);
+        }
+    }
+    g_slist_free(cfmws_list);
+}
+
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 {
     GSList *cfmws_list, *iter;
@@ -454,8 +632,15 @@ static void cxl_fmw_realize(DeviceState *dev, Error **errp)
 {
     CXLFixedWindow *fw = CXL_FMW(dev);
 
-    memory_region_init_io(&fw->mr, OBJECT(dev), &cfmws_ops, fw,
-                          "cxl-fixed-memory-region", fw->size);
+    memory_region_init(&fw->mr, OBJECT(dev), "cxl-fixed-memory-region",
+                       fw->size);
+    memory_region_init_io(&fw->io_mr, OBJECT(dev), &cfmws_ops, fw,
+                          "cxl-fixed-memory-region.io", fw->size);
+    memory_region_add_subregion(&fw->mr, 0, &fw->io_mr);
+
+    fw->direct_mapped = false;
+    fw->direct_target_mr = NULL;
+    fw->direct_target_offset = 0;
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &fw->mr);
 }
 
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 998f495a98..1ccd0f7e5f 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -38,6 +38,11 @@ typedef struct CXLFixedWindow {
     uint8_t enc_int_gran;
     /* Todo: XOR based interleaving */
     MemoryRegion mr;
+    MemoryRegion io_mr;
+    MemoryRegion direct_mr;
+    MemoryRegion *direct_target_mr;
+    hwaddr direct_target_offset;
+    bool direct_mapped;
     hwaddr base;
 } CXLFixedWindow;
 #define TYPE_CXL_FMW "cxl-fmw"
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 21619bb748..7d5a384838 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -18,6 +18,7 @@ void cxl_fmws_link_targets(Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
 void cxl_fmws_update_mmio(void);
+void cxl_fmws_update_mappings(void);
 GSList *cxl_fmws_get_all_sorted(void);
 
 extern const MemoryRegionOps cfmws_ops;
-- 
2.52.0


