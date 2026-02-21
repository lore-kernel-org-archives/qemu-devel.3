Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B6AC61DE4
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk58-0003zT-CW; Sat, 21 Feb 2026 05:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk52-0003gP-Dc; Sat, 21 Feb 2026 05:19:21 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4z-0004hB-U6; Sat, 21 Feb 2026 05:19:20 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXnJihhplpVrBVBw--.3782S2;
 Sat, 21 Feb 2026 18:19:13 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXMO6ehplpg04cAA--.34423S3;
 Sat, 21 Feb 2026 18:19:10 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 28/31] hw/arm/smmuv3: Select sec-sid from PCI property and
 validate SECURE_IMPL
Date: Sat, 21 Feb 2026 18:19:07 +0800
Message-Id: <20260221101907.2997408-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXMO6ehplpg04cAA--.34423S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUATQAAsf
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AFyxAFWfXFWfKryfuFW5GFg_yoWxXF1kpF
 W8AFn8tryUGF93ursayw4293WYqan7GF1fJrW3ua95C347JrykJr40kw12vrWDWrWqya17
 ZayIgFWDur17ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

For future RME-DA + TDISP, this will need to become dynamic: the effective
state for PCIe requests is derived from PCIe IDE/TDISP T/XT
(e.g. SEC_SID = (XT || T) ? Realm : Non-secure), so we'll switch from a
static property to a runtime per-device state update when that plumbing
is added.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 37 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3.c              | 34 ++++++++++++++++++++++++++++++++-
 include/hw/arm/smmu-common.h |  2 ++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 5dece2024a4..b0a238abe93 100644
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
@@ -1071,14 +1072,50 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
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
index 0b8ea922851..57a063b5e5d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1116,7 +1116,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s = sdev->smmu;
     uint32_t sid = smmu_get_sid(sdev);
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
+    SMMUSecSID sec_sid = sdev->sec_sid;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
@@ -1509,6 +1509,36 @@ static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
     return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
 }
 
+static bool smmuv3_validate_sec_sid(SMMUState *bs, SMMUDevice *sdev,
+                                    int bus_num)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    bool secure_as_available = bs->secure_memory &&
+                               bs->secure_memory_as.root != NULL;
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
+    if (!secure_as_available) {
+        error_report("Invalid sec-sid value 'secure' for PCI device "
+                     "%02x:%02x.%x: secure-memory address space is not "
+                     "configured",
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
@@ -2664,6 +2694,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     SMMUv3Class *c = ARM_SMMUV3_CLASS(klass);
+    SMMUBaseClass *sbc = ARM_SMMU_CLASS(klass);
 
     dc->vmsd = &vmstate_smmuv3;
     resettable_class_set_parent_phases(rc, NULL, NULL, smmu_reset_exit,
@@ -2673,6 +2704,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, smmuv3_properties);
     dc->hotpluggable = false;
     dc->user_creatable = true;
+    sbc->validate_sec_sid = smmuv3_validate_sec_sid;
 
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index d05cf6ae53b..c74f66a1bb9 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -144,6 +144,7 @@ typedef struct SMMUDevice {
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


