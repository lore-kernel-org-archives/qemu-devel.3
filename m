Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE4FC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 16:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujgYE-00075z-6r; Wed, 06 Aug 2025 11:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfph-000145-Cm; Wed, 06 Aug 2025 11:13:39 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpd-0006Ee-8G; Wed, 06 Aug 2025 11:13:35 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXX7cXcZNoaSrWBA--.36S2;
 Wed, 06 Aug 2025 23:13:27 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXIQnfcJNos_oJAA--.14849S10;
 Wed, 06 Aug 2025 23:13:26 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 07/11] hw/arm/smmuv3: Add separate address space for secure SMMU
 accesses
Date: Wed,  6 Aug 2025 23:11:30 +0800
Message-Id: <20250806151134.365755-8-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXIQnfcJNos_oJAA--.14849S10
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HKgAAs+
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKr15AF13XFy5Kr4UGw4fuFg_yoWxCFW7pF
 Z3CrZxt3yYka1xArZ3Xr1ku3W8C3s5WFyUGrZ7CwnYkF13Xr13ArsFk345G34kCry8ta1x
 ZF17Zr4fX3WYq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 11:27:14 -0400
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

According to the Arm architecture, SMMU-originated memory accesses,
such as fetching commands or writing events for a secure stream, must
target the Secure Physical Address (PA) space. The existing model sends
all DMA to the global address_space_memory.

This patch introduces the infrastructure to differentiate between secure
and non-secure memory accesses. A weak global symbol,
arm_secure_address_space, is added, which can be provided by the
machine model to represent the Secure PA space.

A new helper, smmu_get_address_space(), selects the target address
space based on the is_secure context. All internal DMA calls
(dma_memory_read/write) are updated to use this helper. Additionally,
the attrs.secure bit is set on transactions targeting the secure
address space.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 10 +++++++++-
 hw/arm/smmuv3.c              | 24 ++++++++++++------------
 hw/arm/virt.c                |  5 +++++
 include/hw/arm/smmu-common.h | 13 +++++++++++++
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 28d6d1bc7f..0877248a88 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -29,6 +29,14 @@
 #include "hw/arm/smmu-common.h"
 #include "smmu-internal.h"
 
+/* Global state for secure address space availability */
+bool arm_secure_as_available;
+
+void smmu_enable_secure_address_space(void)
+{
+    arm_secure_as_available = true;
+}
+
 /* IOTLB Management */
 
 static guint smmu_iotlb_key_hash(gconstpointer v)
@@ -341,7 +349,7 @@ static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
         (MemTxAttrs) { .unspecified = true };
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = ldq_le_dma(&address_space_memory, addr, pte, attrs);
+    ret = ldq_le_dma(smmu_get_address_space(is_secure), addr, pte, attrs);
 
     if (ret != MEMTX_OK) {
         info->type = SMMU_PTW_ERR_WALK_EABT;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index bcf06679e1..69b19754f1 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -128,8 +128,8 @@ static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd, bool is_secure)
         (MemTxAttrs) { .secure = 1 } :
         (MemTxAttrs) { .unspecified = true };
 
-    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
-                          attrs);
+    ret = dma_memory_read(smmu_get_address_space(is_secure), addr, cmd,
+                          sizeof(Cmd), attrs);
     if (ret != MEMTX_OK) {
         return ret;
     }
@@ -152,8 +152,8 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in, bool is_secure)
     for (i = 0; i < ARRAY_SIZE(evt.word); i++) {
         cpu_to_le32s(&evt.word[i]);
     }
-    ret = dma_memory_write(&address_space_memory, addr, &evt, sizeof(Evt),
-                           attrs);
+    ret = dma_memory_write(smmu_get_address_space(is_secure), addr, &evt,
+                           sizeof(Evt), attrs);
     if (ret != MEMTX_OK) {
         return ret;
     }
@@ -360,8 +360,8 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
     trace_smmuv3_get_ste(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
-                          attrs);
+    ret = dma_memory_read(smmu_get_address_space(attrs.secure), addr, buf,
+                          sizeof(*buf), attrs);
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -409,8 +409,8 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
     }
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
-                          attrs);
+    ret = dma_memory_read(smmu_get_address_space(cfg->secure), addr, buf,
+                          sizeof(*buf), attrs);
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -740,8 +740,8 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         l2_ste_offset = sid & ((1 << sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
         /* TODO: guarantee 64-bit single-copy atomicity */
-        ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
-                              sizeof(l1std), attrs);
+        ret = dma_memory_read(smmu_get_address_space(is_secure), l1ptr,
+                              &l1std, sizeof(l1std), attrs);
         if (ret != MEMTX_OK) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
@@ -1143,7 +1143,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUTranslationStatus status;
     SMMUTransCfg *cfg = NULL;
     IOMMUTLBEntry entry = {
-        .target_as = &address_space_memory,
+        .target_as = smmu_get_address_space(false),
         .iova = addr,
         .translated_addr = addr,
         .addr_mask = ~(hwaddr)0,
@@ -1295,7 +1295,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
     }
 
     event.type = IOMMU_NOTIFIER_UNMAP;
-    event.entry.target_as = &address_space_memory;
+    event.entry.target_as = smmu_get_address_space(is_secure);
     event.entry.iova = iova;
     event.entry.addr_mask = num_pages * (1 << granule) - 1;
     event.entry.perm = IOMMU_NONE;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f..bb40f133f2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -92,6 +92,8 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
+AddressSpace arm_secure_address_space;
+
 static GlobalProperty arm_virt_compat[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -2212,6 +2214,9 @@ static void machvirt_init(MachineState *machine)
         memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
                            UINT64_MAX);
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
+        address_space_init(&arm_secure_address_space, secure_sysmem,
+                           "secure-memory-space");
+        smmu_enable_secure_address_space();
     }
 
     firmware_loaded = virt_firmware_init(vms, sysmem,
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5d15a1212b..597c5ef6c9 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -23,6 +23,19 @@
 #include "hw/pci/pci.h"
 #include "qom/object.h"
 
+extern AddressSpace __attribute__((weak)) arm_secure_address_space;
+extern bool arm_secure_as_available;
+
+void smmu_enable_secure_address_space(void);
+
+static inline AddressSpace *smmu_get_address_space(bool is_secure)
+{
+    if (is_secure && arm_secure_as_available) {
+        return &arm_secure_address_space;
+    }
+    return &address_space_memory;
+}
+
 #define SMMU_PCI_BUS_MAX                    256
 #define SMMU_PCI_DEVFN_MAX                  256
 #define SMMU_PCI_DEVFN(sid)                 (sid & 0xFF)
-- 
2.34.1


