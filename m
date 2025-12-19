Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E500E66891
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 22:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWiua-0001jz-6j; Fri, 19 Dec 2025 17:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuO-0001gR-SI
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:14 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuM-0004yX-6v
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:11 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-649e28dccadso3352052a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 14:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766183108; x=1766787908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsjIGYpY3rtNIwVVB461L5eAVGLk+UOcl2XZVc+t3W0=;
 b=VNQzSfzJiaS5bFI6t4gLQ1I+5Q4iFkMwMmzWDlnx9WoR65/LWfmOvWHvX6MRxHUPW4
 hhkhYM6snKf/sv1rvzjUSnHoEMg3wuQ90KpyBvdWQXvhcVWi/rC0Ej0JPR7s0EyBKSe9
 h8siXadGA+NBZvakgQwcHXtlg/00fJxkv1wZiZxTXK2p00+oN+Ko7pwrURZhsB33Cep0
 ihht1z4Fa71T5TSDJx269p9jqd8MElo4jpvxiAwAH8/iS4HB1mn8oy1KcOQeTCXyu4Da
 85rUqxPm9uKMLmULpfx/fiIde6ksHKwioHNU0Ny1T5Gvc/Gbzdjc0BcATlX7nhukgfsg
 0JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766183108; x=1766787908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PsjIGYpY3rtNIwVVB461L5eAVGLk+UOcl2XZVc+t3W0=;
 b=liocKc0Ph7uvNzefnHK8OyA95vxBKN1eenGh24sLIE/UCVd6d9PLjFOmhkXmgVDAJ4
 /mO9ykhpBCP0LqvJFJdz7vxlSQmwmeGy0EyAbjChmJkNXrYmXVYD/La/XIjxl8UHNYOW
 OnPOYtJCIaw7RXAc6KdrjBjxhL9A2LV6fQ7zmjgLZAB2N/HxN6USdYa8I3V76ntpqJM8
 kIjYgjuSSgTi3U8eVy94kSwRsjtgj3qOgCbOF7QtY48vIWDRB6zdCp+cIOsGkaESuNDD
 n9Te5YetlAAFaEVDMeCFKBMiGyr1i1XlJwCTQD72mo3fhokQeSRqiI4CE0mfVXMsUjzm
 zHsQ==
X-Gm-Message-State: AOJu0YxJ91F/oxHdgsBAuHBQLMEqFjnBAXmLzKqkx9DEwdPvjC+0q7gO
 Dvz3I5Bj5RsI/97BWX/yjp11Bivy41veLJffXItZ+B3TfOFWhWYMC0npBejKoX52
X-Gm-Gg: AY/fxX5tKnRocj71BVWZw/PHfEHw17sMDpBgyapivsIqvmAS9cGDQCDGVj6RUvLRbko
 jQylhJf2RUzBXqQiVXIOtAF5BYL0Y594HhgKzDlSItzQmFznc3+IiYmZjOy0CIz3Owygrtt1zUv
 SIwnDN2th3r7sgJOqn/sbiJ8/XuyFyBw4BiZk6f3H9BgITgp3kxAx4G2iy7Ste35qFaHJGVNx9i
 w74qcDukz0huH9pbti2Fnk/EWpkRxxymfnyrWakb45qnijPVFFGmd8V7tBw1AWK6EMCmKfY1dde
 luV9FtaIrX1DQb2LX9kEUpkcr/V0o6ZDDE7Et+0gXeCjm9CLESfslMjJljX7SMiHJHt5za6wIrH
 CZZqee/14AQArsI7LOZSCd7thDvu/Hpj1Q/a+VNkw7qJzZ5BrXuzE6na/OzVVqhl8EFhIti4d71
 flRKnY5wAdsPJ0ewkmval+SuEL54mWy7SlyGQg2xtc8ajxYvSg7vUcgFpHwinG5Q==
X-Google-Smtp-Source: AGHT+IFENmk4HCzm/JILXlQmeTX33uH9eqgTDu0gRXkbRZJlMfnhZ6jnNKRPZxXdz5KhTbh1D6GOPA==
X-Received: by 2002:a05:6402:1ecf:b0:649:cb90:2858 with SMTP id
 4fb4d7f45d1cf-64b8ecaf225mr4636069a12.28.1766183108219; 
 Fri, 19 Dec 2025 14:25:08 -0800 (PST)
Received: from thinkpad-t470s.. (93-138-210-222.adsl.net.t-com.hr.
 [93.138.210.222]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599605sm3237440a12.23.2025.12.19.14.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 14:25:07 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: ruslan_ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
Subject: [RFC PATCH 2/6] hw/arm/smmu-common: add integration with simple bus
Date: Fri, 19 Dec 2025 23:24:35 +0100
Message-ID: <20251219222439.2497195-3-ruslan_ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>

Until now SMMU could only be created for PCIe bus.

This patch adds support to assotiate SMMU with simple
bus in case SMMU created with type: 'generic-primary-bus'.

The 'primary-bus' is now renamed to 'pci-primary-bus'
to avoid confusion.

Signed-off-by: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/arm/smmu-common.c         | 69 ++++++++++++++++++++++++++++++------
 hw/arm/virt.c                |  2 +-
 hw/core/bus.c                | 13 +++++++
 include/hw/arm/smmu-common.h | 22 +++++++++---
 include/hw/qdev-core.h       | 12 +++++++
 5 files changed, 103 insertions(+), 15 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 62a7612184..52ef49d7f6 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qemu/jhash.h"
 #include "qemu/module.h"
+#include "hw/qdev-core.h"
 
 #include "qemu/error-report.h"
 #include "hw/arm/smmu-common.h"
@@ -824,7 +825,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
 /**
  * The bus number is used for lookup when SID based invalidation occurs.
  * In that case we lazily populate the SMMUPciBus array from the bus hash
- * table. At the time the SMMUPciBus is created (smmu_find_add_as), the bus
+ * table. At the time the SMMUPciBus is created (pci_smmu_find_add_as), the bus
  * numbers may not be always initialized yet.
  */
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
@@ -847,7 +848,7 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
     return NULL;
 }
 
-static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *pci_smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
 {
     SMMUState *s = opaque;
     SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
@@ -870,6 +871,7 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
         sdev->smmu = s;
         sdev->bus = bus;
         sdev->devfn = devfn;
+        sdev->pcie_device = true;
 
         memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
                                  s->mrtypename,
@@ -883,8 +885,48 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
     return &sdev->as;
 }
 
-static const PCIIOMMUOps smmu_ops = {
-    .get_address_space = smmu_find_add_as,
+static AddressSpace *bus_smmu_find_add_as(BusState *bus, void *opaque, int devid)
+{
+    SMMUState *s = opaque;
+    SMMUBus *sbus = g_hash_table_lookup(s->smmu_bus_by_busptr, bus);
+    SMMUDevice *sdev;
+    static unsigned int index;
+
+    if (!sbus) {
+        sbus = g_malloc0(sizeof(SMMUBus) +
+                         sizeof(SMMUDevice *) * SMMU_DEVID_MAX);
+        sbus->bus = bus;
+        g_hash_table_insert(s->smmu_bus_by_busptr, bus, sbus);
+    }
+
+    sdev = sbus->pbdev[devid];
+    if (!sdev) {
+        char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devid, index++);
+
+        sdev = sbus->pbdev[devid] = g_new0(SMMUDevice, 1);
+
+        sdev->smmu = s;
+        sdev->bus = bus;
+        sdev->devfn = devid;
+
+        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
+                                 s->mrtypename,
+                                 OBJECT(s), name, UINT64_MAX);
+        address_space_init(&sdev->as,
+                           MEMORY_REGION(&sdev->iommu), name);
+        trace_smmu_add_mr(name);
+        g_free(name);
+    }
+
+    return &sdev->as;
+}
+
+static const PCIIOMMUOps pci_smmu_ops = {
+    .get_address_space = pci_smmu_find_add_as,
+};
+
+static const BusIOMMUOps bus_smmu_ops = {
+    .get_address_space = bus_smmu_find_add_as,
 };
 
 SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid)
@@ -926,7 +968,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
 {
     SMMUState *s = ARM_SMMU(dev);
     SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(dev);
-    PCIBus *pci_bus = s->primary_bus;
+    PCIBus *pci_bus = s->pci_primary_bus;
     Error *local_err = NULL;
 
     sbc->parent_realize(dev, &local_err);
@@ -939,6 +981,11 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
                                      g_free, g_free);
     s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
 
+    if (s->generic_primary_bus ) {
+        bus_setup_iommu(s->generic_primary_bus, &bus_smmu_ops, s);
+        return;
+    }
+
     if (!pci_bus) {
         error_setg(errp, "SMMU is not attached to any PCI bus!");
         return;
@@ -962,10 +1009,10 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
             }
         }
 
-        if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+        if (s->pci_smmu_per_bus) {
+            pci_setup_iommu_per_bus(pci_bus, &pci_smmu_ops, s);
         } else {
-            pci_setup_iommu(pci_bus, &smmu_ops, s);
+            pci_setup_iommu(pci_bus, &pci_smmu_ops, s);
         }
         return;
     }
@@ -991,9 +1038,11 @@ static void smmu_base_reset_exit(Object *obj, ResetType type)
 
 static const Property smmu_dev_properties[] = {
     DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
-    DEFINE_PROP_BOOL("smmu_per_bus", SMMUState, smmu_per_bus, false),
-    DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
+    DEFINE_PROP_BOOL("pci_smmu_per_bus", SMMUState, pci_smmu_per_bus, false),
+    DEFINE_PROP_LINK("pci-primary-bus", SMMUState, pci_primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
+    DEFINE_PROP_LINK("generic-primary-bus", SMMUState, generic_primary_bus,
+                     TYPE_BUS, BusState *),
 };
 
 static void smmu_base_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 25fb2bab56..d9d7b982b3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3050,7 +3050,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                        "iommu=smmuv3" : "virtio-iommu");
         } else if (vms->iommu == VIRT_IOMMU_NONE) {
             /* The new SMMUv3 device is specific to the PCI bus */
-            object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
+            object_property_set_bool(OBJECT(dev), "pci_smmu_per_bus", true, NULL);
         }
     }
 }
diff --git a/hw/core/bus.c b/hw/core/bus.c
index bddfc22d38..6d1483fdbd 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -80,6 +80,19 @@ bool bus_is_in_reset(BusState *bus)
     return resettable_is_in_reset(OBJECT(bus));
 }
 
+void bus_setup_iommu(BusState *bus, const BusIOMMUOps *ops, void *opaque)
+{
+    /*
+     * If called, bus_setup_iommu() should provide a minimum set of
+     * useful callbacks for the bus.
+     */
+    assert(ops);
+    assert(ops->get_address_space);
+
+    bus->iommu_ops = ops;
+    bus->iommu_opaque = opaque;
+}
+
 static ResettableState *bus_get_reset_state(Object *obj)
 {
     BusState *bus = BUS(obj);
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 80d0fecfde..670ae46930 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -27,6 +27,8 @@
 #define SMMU_PCI_DEVFN_MAX                  256
 #define SMMU_PCI_DEVFN(sid)                 (sid & 0xFF)
 
+#define SMMU_DEVID_MAX                      256
+
 /* VMSAv8-64 Translation constants and functions */
 #define VMSA_LEVELS                         4
 #define VMSA_MAX_S2_CONCAT                  16
@@ -120,12 +122,13 @@ typedef struct SMMUTransCfg {
 
 typedef struct SMMUDevice {
     void               *smmu;
-    PCIBus             *bus;
+    void               *bus;
     int                devfn;
     IOMMUMemoryRegion  iommu;
     AddressSpace       as;
     uint32_t           cfg_cache_hits;
     uint32_t           cfg_cache_misses;
+    bool               pcie_device;
     QLIST_ENTRY(SMMUDevice) next;
 } SMMUDevice;
 
@@ -134,6 +137,11 @@ typedef struct SMMUPciBus {
     SMMUDevice   *pbdev[]; /* Parent array is sparse, so dynamically alloc */
 } SMMUPciBus;
 
+typedef struct SMMUBus {
+    BusState     *bus;
+    SMMUDevice   *pbdev[]; /* Parent array is sparse, so dynamically alloc */
+} SMMUBus;
+
 typedef struct SMMUIOTLBKey {
     uint64_t iova;
     int asid;
@@ -154,14 +162,16 @@ struct SMMUState {
     MemoryRegion iomem;
 
     GHashTable *smmu_pcibus_by_busptr;
+    GHashTable *smmu_bus_by_busptr;
     GHashTable *configs; /* cache for configuration data */
     GHashTable *iotlb;
     SMMUPciBus *smmu_pcibus_by_bus_num[SMMU_PCI_BUS_MAX];
     PCIBus *pci_bus;
     QLIST_HEAD(, SMMUDevice) devices_with_notifiers;
     uint8_t bus_num;
-    PCIBus *primary_bus;
-    bool smmu_per_bus; /* SMMU is specific to the primary_bus */
+    PCIBus *pci_primary_bus;
+    bool pci_smmu_per_bus; /* SMMU is specific to the pci_primary_bus */
+    BusState *generic_primary_bus;
 };
 
 struct SMMUBaseClass {
@@ -183,7 +193,11 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
 /* Return the stream ID of an SMMU device */
 static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 {
-    return PCI_BUILD_BDF(pci_bus_num(sdev->bus), sdev->devfn);
+    if (sdev->pcie_device) {
+        return PCI_BUILD_BDF(pci_bus_num(sdev->bus), sdev->devfn);
+    } else {
+        return sdev->devfn;
+    }
 }
 
 /**
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e3862279da..2092450b90 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -954,6 +954,18 @@ bool device_is_in_reset(DeviceState *dev);
  */
 bool bus_is_in_reset(BusState *bus);
 
+/**
+ * bus_setup_iommu() - Set up IOMMU operations for a bus
+ * @bus: the bus to configure
+ * @ops: IOMMU operations structure containing callback functions
+ * @opaque: opaque data passed to IOMMU operation callbacks
+ *
+ * Configure IOMMU operations for the specified bus. The ops structure
+ * must contain at least the get_address_space callback. The opaque
+ * parameter is passed through to the operation callbacks.
+ */
+void bus_setup_iommu(BusState *bus, const BusIOMMUOps *ops, void *opaque);
+
 /* This should go away once we get rid of the NULL bus hack */
 BusState *sysbus_get_default(void);
 
-- 
2.43.0


