Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2B0C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYGt-0004Oi-Od; Thu, 13 Aug 2026 12:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGI-0003kV-R5; Thu, 13 Aug 2026 12:26:36 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGG-0001Ln-Ru; Thu, 13 Aug 2026 12:26:34 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBnbBg18H1qUiRvAw--.34360S2; 
 Fri, 14 Aug 2026 00:26:29 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwBXQw8H1q7SwjAA--.59184S5;
 Fri, 14 Aug 2026 00:26:28 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 24/28] hw/arm/smmuv3: Select sec-sid from PCI property and
 validate SECURE_IMPL
Date: Fri, 14 Aug 2026 00:26:22 +0800
Message-Id: <20260813162624.2809349-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBXQw8H1q7SwjAA--.59184S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HsgAAsl
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AFyxAFWfXFyfXrykWr13twb_yoW3CrykpF
 WUJF45KrW8GF93AFs3tw429a1Yqws7W3W5JrW3Kas5C34Utr18Jr4vka4YvrZ8WrW5Aa17
 ZayIgFWDur12yrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Parse each PCI device's sec-sid property during SMMU device initialization
and cache it in SMMUDevice::sec_sid. Support "non-secure" and "secure",
default to non-secure when unspecified, and reject invalid values with an
explicit error. Use sdev->sec_sid in smmuv3_translate() to select the
register bank instead of hardcoding the non-secure context.

Keep sec-sid parsing in smmu-common, and add a SMMUv3-specific validation
hook to enforce architectural constraints: fail fast when sec-sid=secure
while SMMU_S_IDR1.SECURE_IMPL is 0 or secure AS is not available.

Typically, SEC_SID is a system-defined attribute (e.g. sideband or tied-off)
rather than something a PCIe endpoint can freely toggle in pre-RME scenario.
So this PCI sec-sid property is used as a static platform/testing knob to
drive the SMMU bank selection.

For future RME-DA and TDISP support, this static property will need to be
replaced by runtime platform plumbing that derives the effective SEC_SID
from the device security assignment.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmu-common.c         | 37 ++++++++++++++++++++++
 hw/arm/smmuv3.c              | 61 +++++++++++++++++++++++++++++++++++-
 include/hw/arm/smmu-common.h |  2 ++
 3 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e8a1ed65c19..4a94799fb0d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -21,6 +21,7 @@
 #include "exec/target_page.h"
 #include "hw/core/cpu.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_device.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/jhash.h"
@@ -1100,14 +1101,50 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
     return NULL;
 }
 
+static SMMUSecSID smmu_parse_pci_sec_sid(PCIDevice *pdev, int bus_num,
+                                         int devfn)
+{
+    const char *sec_sid;
+
+    if (!pdev || !pdev->sec_sid) {
+        return SMMU_SEC_SID_NS;
+    }
+
+    sec_sid = pdev->sec_sid;
+    if (!strcmp(sec_sid, "non-secure")) {
+        return SMMU_SEC_SID_NS;
+    }
+    if (!strcmp(sec_sid, "secure")) {
+        return SMMU_SEC_SID_S;
+    }
+
+    error_report("Invalid sec-sid value '%s' for PCI device %02x:%02x.%x; "
+                 "allowed values: non-secure or secure (case-sensitive)",
+                 sec_sid, bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn));
+    exit(EXIT_FAILURE);
+}
+
 void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn)
 {
     static unsigned int index;
     g_autofree char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn,
                                             index++);
+    SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(s);
+    PCIDevice *pdev;
+    int bus_num;
+
     sdev->smmu = s;
     sdev->bus = bus;
     sdev->devfn = devfn;
+    sdev->sec_sid = SMMU_SEC_SID_NS;
+
+    bus_num = pci_bus_num(bus);
+    pdev = pci_find_device(bus, bus_num, devfn);
+    sdev->sec_sid = smmu_parse_pci_sec_sid(pdev, bus_num, devfn);
+    if (sbc->validate_sec_sid &&
+        !sbc->validate_sec_sid(s, sdev, bus_num)) {
+        exit(EXIT_FAILURE);
+    }
 
     memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
                              s->mrtypename, OBJECT(s), name, UINT64_MAX);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e5f0bc18415..a755f1ebd69 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -43,6 +43,12 @@
                                         ((ptw_info).stage == SMMU_STAGE_2 && \
                                         (cfg)->s2cfg.record_faults))
 
+enum {
+    SMMU_IOMMU_IDX_NS,
+    SMMU_IOMMU_IDX_S,
+    SMMU_IOMMU_IDX_NUM,
+};
+
 /**
  * smmuv3_trigger_irq - pulse @irq if enabled and update
  * GERROR register in case of GERROR interrupt
@@ -1157,6 +1163,33 @@ static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
     }
 }
 
+static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
+{
+    if (attrs.unspecified) {
+        return SMMU_IOMMU_IDX_NS;
+    }
+    return attrs.secure ? SMMU_IOMMU_IDX_S : SMMU_IOMMU_IDX_NS;
+}
+
+static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
+{
+    return SMMU_IOMMU_IDX_NUM;
+}
+
+static AddressSpace *smmuv3_bypass_target_as(SMMUv3State *s,
+                                             SMMUSecSID sec_sid,
+                                             int iommu_idx)
+{
+    g_assert(iommu_idx >= SMMU_IOMMU_IDX_NS &&
+             iommu_idx < SMMU_IOMMU_IDX_NUM);
+
+    if (smmu_sec_sid_is_secure(sec_sid) &&
+        iommu_idx == SMMU_IOMMU_IDX_S) {
+        return smmu_get_address_space(&s->smmu_state, SMMU_SEC_SID_S);
+    }
+    return smmu_get_address_space(&s->smmu_state, SMMU_SEC_SID_NS);
+}
+
 /* Entry point to SMMU, does everything. */
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                       IOMMUAccessFlags flag, int iommu_idx)
@@ -1164,7 +1197,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s = sdev->smmu;
     uint32_t sid = smmu_get_sid(sdev);
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUSecSID sec_sid = sdev->sec_sid;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
@@ -1181,6 +1214,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     };
     SMMUTLBEntry *cached_entry = NULL;
 
+    entry.target_as = smmuv3_bypass_target_as(s, sec_sid, iommu_idx);
+
     qemu_mutex_lock(&s->mutex);
 
     if (!smmu_enabled(s, sec_sid)) {
@@ -1611,6 +1646,26 @@ static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
     return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
 }
 
+static bool smmuv3_validate_sec_sid(SMMUState *bs, SMMUDevice *sdev,
+                                    int bus_num)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    if (sdev->sec_sid != SMMU_SEC_SID_S) {
+        return true;
+    }
+
+    if (!smmu_hw_secure_implemented(s)) {
+        error_report("Invalid sec-sid value 'secure' for PCI device "
+                     "%02x:%02x.%x: S_IDR1.SECURE_IMPL is 0, so only "
+                     "non-secure is allowed",
+                     bus_num, PCI_SLOT(sdev->devfn), PCI_FUNC(sdev->devfn));
+        return false;
+    }
+
+    return true;
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -2823,6 +2878,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     SMMUv3Class *c = ARM_SMMUV3_CLASS(klass);
+    SMMUBaseClass *sbc = ARM_SMMU_CLASS(klass);
 
     dc->vmsd = &vmstate_smmuv3;
     resettable_class_set_parent_phases(rc, NULL, NULL, smmu_reset_exit,
@@ -2832,6 +2888,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, smmuv3_properties);
     dc->hotpluggable = false;
     dc->user_creatable = true;
+    sbc->validate_sec_sid = smmuv3_validate_sec_sid;
 
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
@@ -2905,6 +2962,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = smmuv3_translate;
     imrc->notify_flag_changed = smmuv3_notify_flag_changed;
+    imrc->attrs_to_index = smmuv3_attrs_to_index;
+    imrc->num_indexes = smmuv3_num_indexes;
 }
 
 static const TypeInfo smmuv3_type_info = {
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index a21c6061808..9da54221f20 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -134,6 +134,7 @@ typedef struct SMMUDevice {
     void               *smmu;
     PCIBus             *bus;
     int                devfn;
+    SMMUSecSID         sec_sid;
     IOMMUMemoryRegion  iommu;
     AddressSpace       as;
     uint32_t           cfg_cache_hits;
@@ -204,6 +205,7 @@ struct SMMUBaseClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
+    bool (*validate_sec_sid)(struct SMMUState *s, SMMUDevice *sdev, int bus_num);
 
 };
 
-- 
2.34.1


