Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1ED606A330
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGHr-0000u2-Vt; Sat, 14 Nov 2026 11:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGHp-0000mW-MO; Sat, 14 Nov 2026 11:07:29 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGHn-0001Mg-FW; Sat, 14 Nov 2026 11:07:29 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwC3vNA9h_hqzjEqBg--.58221S2; 
 Sun, 15 Nov 2026 00:07:25 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwR3Y6h_hql9v6AA--.34438S3;
 Sun, 15 Nov 2026 00:07:23 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 31/35] hw/arm/smmuv3: Select sec-sid from PCI property and
 validate SECURE_IMPL
Date: Sun, 15 Nov 2026 00:07:22 +0800
Message-Id: <20261114160722.3629356-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwR3Y6h_hql9v6AA--.34438S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBWAAAs9
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3KF1ktw1rXFy5WrWfCFW8tFb_yoWDWFW3pF
 WUAFnIqr4UGFn3AFs3tw429a15Xan7WF1rKry3Ka95C347Jr17Xr1vkw1Yvr9rWFWUZw47
 ZayIgrW5Cr42y3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Read each PCI device's sec-sid property in smmu-common and cache the
corresponding SEC_SID in SMMUDevice::sec_sid, defaulting to Non-secure
when the property is unset. The PCI property setter validates explicit
values. Use sdev->sec_sid in smmuv3_translate() to select the register
bank instead of hardcoding the Non-secure context.

Add a SMMUv3-specific compatibility check through
PCIIOMMUOps.supports_address_space(). Reject sec-sid=secure when
SMMU_S_IDR1.SECURE_IMPL is 0 or SMMUv3 acceleration is enabled.
Propagate errors through errp so incompatible PCI hotplug requests
fail without terminating QEMU.

Typically, SEC_SID is a system-defined attribute (e.g. sideband or tied-off)
rather than something a PCIe endpoint can freely toggle in pre-RME scenario.
So this PCI sec-sid property is used as a static platform/testing knob to
drive the SMMU bank selection.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/smmu-common.h |  8 +++++
 hw/arm/smmu-common.c         | 65 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.c        |  2 +-
 hw/arm/smmuv3.c              | 48 +++++++++++++++++++++++++-
 4 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index a21c6061808..c94bce0e04f 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -50,6 +50,8 @@ typedef enum SMMUSecSID {
 
 MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid);
 ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid);
+int smmu_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs);
+int smmu_num_indexes(IOMMUMemoryRegion *iommu);
 
 /*
  * Page table walk error types
@@ -134,6 +136,7 @@ typedef struct SMMUDevice {
     void               *smmu;
     PCIBus             *bus;
     int                devfn;
+    SMMUSecSID         sec_sid;
     IOMMUMemoryRegion  iommu;
     AddressSpace       as;
     uint32_t           cfg_cache_hits;
@@ -204,6 +207,8 @@ struct SMMUBaseClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
+    bool (*validate_sec_sid)(struct SMMUState *s, SMMUSecSID sec_sid,
+                            int bus_num, int devfn, Error **errp);
 
 };
 
@@ -221,6 +226,9 @@ SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
 /* Initialize SMMUDevice handle associated to a SMMUPciBus */
 void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
 
+bool smmu_supports_address_space(PCIBus *bus, void *opaque, int devfn,
+                                Error **errp);
+
 
 static inline bool smmu_sec_sid_is_secure(SMMUSecSID sec_sid)
 {
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 0408fd25b3a..eec270dac1d 100644
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
@@ -91,6 +92,19 @@ AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid)
     g_assert_not_reached();
 }
 
+int smmu_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
+{
+    if (attrs.unspecified) {
+        return SMMU_SEC_SID_NS;
+    }
+    return attrs.secure ? SMMU_SEC_SID_S : SMMU_SEC_SID_NS;
+}
+
+int smmu_num_indexes(IOMMUMemoryRegion *iommu)
+{
+    return SMMU_SEC_SID_NUM;
+}
+
 /* IOTLB Management */
 
 static guint smmu_iotlb_key_hash(gconstpointer v)
@@ -1096,15 +1110,52 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
     return NULL;
 }
 
+static SMMUSecSID smmu_parse_pci_sec_sid(PCIDevice *pdev)
+{
+    if (!pdev || !pdev->sec_sid ||
+        !strcmp(pdev->sec_sid, "non-secure")) {
+        return SMMU_SEC_SID_NS;
+    }
+
+    assert(!strcmp(pdev->sec_sid, "secure"));
+    return SMMU_SEC_SID_S;
+}
+
+bool smmu_supports_address_space(PCIBus *bus, void *opaque, int devfn,
+                                Error **errp)
+{
+    SMMUState *s = opaque;
+    SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(s);
+    int bus_num = pci_bus_num(bus);
+    PCIDevice *pdev = pci_find_device(bus, bus_num, devfn);
+    SMMUSecSID sec_sid = smmu_parse_pci_sec_sid(pdev);
+
+    return !sbc->validate_sec_sid ||
+           sbc->validate_sec_sid(s, sec_sid, bus_num, devfn, errp);
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
 
+    bus_num = pci_bus_num(bus);
+    pdev = pci_find_device(bus, bus_num, devfn);
+
+    sdev->sec_sid = smmu_parse_pci_sec_sid(pdev);
+    /* Also check devices realized before the SMMU was attached. */
+    if (sbc->validate_sec_sid) {
+        sbc->validate_sec_sid(s, sdev->sec_sid, bus_num, devfn, &error_fatal);
+    }
+
     memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
                              s->mrtypename, OBJECT(s), name, UINT64_MAX);
     address_space_init(&sdev->as, MEMORY_REGION(&sdev->iommu), name);
@@ -1129,18 +1180,32 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
 {
     SMMUState *s = opaque;
     SMMUPciBus *sbus = smmu_get_sbus(s, bus);
+    SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(s);
     SMMUDevice *sdev;
+    PCIDevice *pdev;
+    SMMUSecSID sec_sid;
+    int bus_num;
 
     sdev = sbus->pbdev[devfn];
     if (!sdev) {
         sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
         smmu_init_sdev(s, sdev, bus, devfn);
+    } else {
+        bus_num = pci_bus_num(bus);
+        pdev = pci_find_device(bus, bus_num, devfn);
+        sec_sid = smmu_parse_pci_sec_sid(pdev);
+
+        if (sbc->validate_sec_sid) {
+            sbc->validate_sec_sid(s, sec_sid, bus_num, devfn, &error_fatal);
+        }
+        sdev->sec_sid = sec_sid;
     }
 
     return &sdev->as;
 }
 
 static const PCIIOMMUOps smmu_ops = {
+    .supports_address_space = smmu_supports_address_space,
     .get_address_space = smmu_find_add_as,
 };
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 6fac9420cdf..5a0a689ebc9 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -899,7 +899,7 @@ static bool smmuv3_accel_supports_as(PCIBus *bus, void *opaque, int devfn,
         }
         return false;
     }
-    return true;
+    return smmu_supports_address_space(bus, opaque, devfn, errp);
 }
 /*
  * Find or add an address space for the given PCI device.
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0c367dc5221..04955d0691b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1162,6 +1162,20 @@ static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
     }
 }
 
+static AddressSpace *smmuv3_bypass_target_as(SMMUv3State *s,
+                                             SMMUSecSID sec_sid,
+                                             int iommu_idx)
+{
+    g_assert(iommu_idx >= SMMU_SEC_SID_NS &&
+             iommu_idx < SMMU_SEC_SID_NUM);
+
+    if (smmu_sec_sid_is_secure(sec_sid) &&
+        iommu_idx == SMMU_SEC_SID_S) {
+        return smmu_get_address_space(&s->smmu_state, SMMU_SEC_SID_S);
+    }
+    return smmu_get_address_space(&s->smmu_state, SMMU_SEC_SID_NS);
+}
+
 /* Entry point to SMMU, does everything. */
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                       IOMMUAccessFlags flag, int iommu_idx)
@@ -1169,7 +1183,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s = sdev->smmu;
     uint32_t sid = smmu_get_sid(sdev);
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUSecSID sec_sid = sdev->sec_sid;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
@@ -1186,6 +1200,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     };
     SMMUTLBEntry *cached_entry = NULL;
 
+    entry.target_as = smmuv3_bypass_target_as(s, sec_sid, iommu_idx);
+
     qemu_mutex_lock(&s->mutex);
 
     if (!smmu_enabled(s, sec_sid)) {
@@ -1461,6 +1477,32 @@ static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
     return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
 }
 
+static bool smmuv3_validate_sec_sid(SMMUState *bs, SMMUSecSID sec_sid,
+                                    int bus_num, int devfn, Error **errp)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    if (sec_sid != SMMU_SEC_SID_S) {
+        return true;
+    }
+
+    if (s->accel) {
+        error_setg(errp, "PCI device %02x:%02x.%x: sec-sid=secure "
+                   "is not supported with SMMUv3 acceleration",
+                   bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn));
+        return false;
+    }
+
+    if (!smmu_hw_secure_implemented(s)) {
+        error_setg(errp, "PCI device %02x:%02x.%x: sec-sid=secure "
+                   "requires S_IDR1.SECURE_IMPL=1",
+                   bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn));
+        return false;
+    }
+
+    return true;
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -2567,6 +2609,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     SMMUv3Class *c = ARM_SMMUV3_CLASS(klass);
+    SMMUBaseClass *sbc = ARM_SMMU_CLASS(klass);
 
     dc->vmsd = &vmstate_smmuv3;
     resettable_class_set_parent_phases(rc, NULL, NULL, smmu_reset_exit,
@@ -2576,6 +2619,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, smmuv3_properties);
     dc->hotpluggable = false;
     dc->user_creatable = true;
+    sbc->validate_sec_sid = smmuv3_validate_sec_sid;
 
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
@@ -2649,6 +2693,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = smmuv3_translate;
     imrc->notify_flag_changed = smmuv3_notify_flag_changed;
+    imrc->attrs_to_index = smmu_attrs_to_index;
+    imrc->num_indexes = smmu_num_indexes;
 }
 
 static const TypeInfo smmuv3_type_info = {
-- 
2.34.1


