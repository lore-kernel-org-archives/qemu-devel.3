Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46762C52D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlA6-00070p-9m; Tue, 13 Aug 2024 02:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdlA1-0006si-QF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9y-0006RQ-IT
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-710ffaf921fso1188935b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531053; x=1724135853;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z/MFYpSKsxurDELJiU0C9WDyT7OyUExUvk7brt45XRg=;
 b=zrFHdys5Vjr8ss2Z17QjD2GDB7xL8Y8BSWfn2TMS5SwArgKHPMXLGer24lYLbIMrIx
 VrqzvKKbAqogZZimQs0F4klxab4hlrXTEC/+JzZBgbPyioAi8sw3KoVxp9XLxUSUUm1n
 Wl4Md+k/2wlFSIaJK+d9i6yCW+EQTyI7oG4rYCyUtGi08cjOS6q5jogKLy/yMaxmIq6B
 iwBN6J31H6VuUHUSytMgM5Cd8KP1vc4kD6mmN99ylUDl9C70UqRjx2l5MRhJM0hCgNtZ
 QMr2lz26sAb/P5muFuFhjzJLQeHO4RVKwhgFbrtAdxJmCZU9L/7H94M33FHwtd2F9FYA
 0xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531053; x=1724135853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/MFYpSKsxurDELJiU0C9WDyT7OyUExUvk7brt45XRg=;
 b=Eiuus1v9dFSKOkEB16ZU6H0bLilgmwB0tMJsMZMJmtb55S/4kq8cNgpeAUdzPOPI2R
 ZlekB6/FqvvbFUGxgpG3LoT1/i6c+svR1y65wlNA3oZ/mSm2bkvFF9PbV1swRvsplH/2
 O9RY69P1Eg1ITBnFJk1bavAsKM6LFXzHM1jeDDirO79Vu717eHSnqxAdqPIOzdOY68EM
 OwmfTKWgjvQH95HVfAD5Yx+UXlSXBAqWklvAcId9ky4VURx1uTdndCt0Wi2X5UpVccut
 vw2Y/SYNrGfiiClctkVL5nIqp0X0/gHfRjPG60GhFS6gfHYBbdX8i+aqu1RMbmSHAfnh
 a5Kw==
X-Gm-Message-State: AOJu0YwgDqCvMnS3yZyCRYR7V21NvzUSAhMimEYPKtUjdxDByAPmNO+J
 PTCP94+ZKCrpP+2b43G1/yoJigRxkfdThBvlkrR0E5SV24nGLX+7UkuBNo3f5js=
X-Google-Smtp-Source: AGHT+IE4CxSswGjjZxdpxn6ph8hVIMTXl+WiphPoNgJhi3EyKkmDOc1PLtcZCemtHKCmXAm1129hbA==
X-Received: by 2002:a05:6a00:170a:b0:708:41c4:8849 with SMTP id
 d2e1a72fcca58-71256fa3249mr3203455b3a.9.1723531053087; 
 Mon, 12 Aug 2024 23:37:33 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-710e5ab7ba6sm4980054b3a.209.2024.08.12.23.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:37:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:37:04 +0900
Subject: [PATCH for-9.2 v7 5/9] pcie_sriov: Allow user to create SR-IOV device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-sriov-v7-5-8515e3774df7@daynix.com>
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
In-Reply-To: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

A user can create a SR-IOV device by specifying the PF with the
sriov-pf property of the VFs. The VFs must be added before the PF.

A user-creatable VF must have PCIDeviceClass::sriov_vf_user_creatable
set. Such a VF cannot refer to the PF because it is created before the
PF.

A PF that user-creatable VFs can be attached calls
pcie_sriov_pf_init_from_user_created_vfs() during realization and
pcie_sriov_pf_exit() when exiting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h |   6 +-
 include/hw/pci/pcie_sriov.h |  18 +++
 hw/pci/pci.c                |  62 ++++++----
 hw/pci/pcie_sriov.c         | 279 +++++++++++++++++++++++++++++++++++---------
 4 files changed, 286 insertions(+), 79 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 8fa845beee5e..1d31099dd4dc 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -38,6 +38,8 @@ struct PCIDeviceClass {
     uint16_t subsystem_id;              /* only for header type = 0 */
 
     const char *romfile;                /* rom bar */
+
+    bool sriov_vf_user_creatable;
 };
 
 enum PCIReqIDType {
@@ -167,6 +169,8 @@ struct PCIDevice {
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
+
+    char *sriov_pf;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
@@ -199,7 +203,7 @@ static inline int pci_is_express_downstream_port(const PCIDevice *d)
 
 static inline int pci_is_vf(const PCIDevice *d)
 {
-    return d->exp.sriov_vf.pf != NULL;
+    return d->sriov_pf || d->exp.sriov_vf.pf != NULL;
 }
 
 static inline uint32_t pci_config_size(const PCIDevice *d)
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index c5d2d318d330..f75b8f22ee92 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -18,6 +18,7 @@
 typedef struct PCIESriovPF {
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
+    bool vf_user_created; /* If VFs are created by user */
 } PCIESriovPF;
 
 typedef struct PCIESriovVF {
@@ -40,6 +41,23 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
                                 MemoryRegion *memory);
 
+/**
+ * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-created
+ *                                              VFs.
+ * @dev: A PCIe device being realized.
+ * @offset: The offset of the SR-IOV capability.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: The size of added capability. 0 if the user did not create VFs.
+ *         -1 if failed.
+ */
+int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
+                                                 uint16_t offset,
+                                                 Error **errp);
+
+bool pcie_sriov_register_device(PCIDevice *dev, Error **errp);
+void pcie_sriov_unregister_device(PCIDevice *dev);
+
 /*
  * Default (minimal) page size support values
  * as required by the SR/IOV standard:
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0956fe5eb444..e693f5b1e044 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,6 +85,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -959,13 +960,8 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
         dev->config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
     }
 
-    /*
-     * With SR/IOV and ARI, a device at function 0 need not be a multifunction
-     * device, as it may just be a VF that ended up with function 0 in
-     * the legacy PCI interpretation. Avoid failing in such cases:
-     */
-    if (pci_is_vf(dev) &&
-        dev->exp.sriov_vf.pf->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+    /* SR/IOV is not handled here. */
+    if (pci_is_vf(dev)) {
         return;
     }
 
@@ -998,7 +994,8 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
     }
     /* function 0 indicates single function, so function > 0 must be NULL */
     for (func = 1; func < PCI_FUNC_MAX; ++func) {
-        if (bus->devices[PCI_DEVFN(slot, func)]) {
+        PCIDevice *device = bus->devices[PCI_DEVFN(slot, func)];
+        if (device && !pci_is_vf(device)) {
             error_setg(errp, "PCI: %x.0 indicates single function, "
                        "but %x.%x is already populated.",
                        slot, slot, func);
@@ -1283,6 +1280,7 @@ static void pci_qdev_unrealize(DeviceState *dev)
 
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
+    pcie_sriov_unregister_device(pci_dev);
 
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -1314,7 +1312,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     pcibus_t size = memory_region_size(memory);
     uint8_t hdr_type;
 
-    assert(!pci_is_vf(pci_dev)); /* VFs must use pcie_sriov_vf_register_bar */
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
     assert(is_power_of_2(size));
@@ -1325,7 +1322,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     assert(hdr_type != PCI_HEADER_TYPE_BRIDGE || region_num < 2);
 
     r = &pci_dev->io_regions[region_num];
-    r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
     r->type = type;
     r->memory = memory;
@@ -1333,22 +1329,35 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                         ? pci_get_bus(pci_dev)->address_space_io
                         : pci_get_bus(pci_dev)->address_space_mem;
 
-    wmask = ~(size - 1);
-    if (region_num == PCI_ROM_SLOT) {
-        /* ROM enable bit is writable */
-        wmask |= PCI_ROM_ADDRESS_ENABLE;
-    }
-
-    addr = pci_bar(pci_dev, region_num);
-    pci_set_long(pci_dev->config + addr, type);
+    if (pci_is_vf(pci_dev)) {
+        PCIDevice *pf = pci_dev->exp.sriov_vf.pf;
+        assert(!pf || type == pf->exp.sriov_pf.vf_bar_type[region_num]);
 
-    if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
-        r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-        pci_set_quad(pci_dev->wmask + addr, wmask);
-        pci_set_quad(pci_dev->cmask + addr, ~0ULL);
+        r->addr = pci_bar_address(pci_dev, region_num, r->type, r->size);
+        if (r->addr != PCI_BAR_UNMAPPED) {
+            memory_region_add_subregion_overlap(r->address_space,
+                                                r->addr, r->memory, 1);
+        }
     } else {
-        pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
-        pci_set_long(pci_dev->cmask + addr, 0xffffffff);
+        r->addr = PCI_BAR_UNMAPPED;
+
+        wmask = ~(size - 1);
+        if (region_num == PCI_ROM_SLOT) {
+            /* ROM enable bit is writable */
+            wmask |= PCI_ROM_ADDRESS_ENABLE;
+        }
+
+        addr = pci_bar(pci_dev, region_num);
+        pci_set_long(pci_dev->config + addr, type);
+
+        if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
+            r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+            pci_set_quad(pci_dev->wmask + addr, wmask);
+            pci_set_quad(pci_dev->cmask + addr, ~0ULL);
+        } else {
+            pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
+            pci_set_long(pci_dev->cmask + addr, 0xffffffff);
+        }
     }
 }
 
@@ -2109,6 +2118,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    if (!pcie_sriov_register_device(pci_dev, errp)) {
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 2daea6ecdb6a..f5b83a92a00c 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -15,11 +15,12 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
-#include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
 #include "trace.h"
 
+static GHashTable *pfs;
+
 static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
 {
     for (uint16_t i = 0; i < total_vfs; i++) {
@@ -31,14 +32,43 @@ static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
     dev->exp.sriov_pf.vf = NULL;
 }
 
-bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
-                        const char *vfname, uint16_t vf_dev_id,
-                        uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride,
-                        Error **errp)
+static void register_vfs(PCIDevice *dev)
+{
+    uint16_t num_vfs;
+    uint16_t i;
+    uint16_t sriov_cap = dev->exp.sriov_cap;
+
+    assert(sriov_cap > 0);
+    num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+
+    trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
+                             PCI_FUNC(dev->devfn), num_vfs);
+    for (i = 0; i < num_vfs; i++) {
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
+    }
+
+    pci_set_word(dev->wmask + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+}
+
+static void unregister_vfs(PCIDevice *dev)
+{
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+    uint16_t i;
+
+    trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
+                               PCI_FUNC(dev->devfn));
+    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
+    }
+
+    pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
+}
+
+static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
+                                      uint16_t vf_dev_id, uint16_t init_vfs,
+                                      uint16_t total_vfs, uint16_t vf_offset,
+                                      uint16_t vf_stride, Error **errp)
 {
-    BusState *bus = qdev_get_parent_bus(&dev->qdev);
-    int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
@@ -88,6 +118,28 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
 
+    return true;
+}
+
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+                        const char *vfname, uint16_t vf_dev_id,
+                        uint16_t init_vfs, uint16_t total_vfs,
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp)
+{
+    BusState *bus = qdev_get_parent_bus(&dev->qdev);
+    int32_t devfn = dev->devfn + vf_offset;
+
+    if (pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
+
+    if (!pcie_sriov_pf_init_common(dev, offset, vf_dev_id, init_vfs,
+                                   total_vfs, vf_offset, vf_stride, errp)) {
+        return false;
+    }
+
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
 
     for (uint16_t i = 0; i < total_vfs; i++) {
@@ -117,7 +169,22 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
 {
     uint8_t *cfg = dev->config + dev->exp.sriov_cap;
 
-    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
+    if (dev->exp.sriov_pf.vf_user_created) {
+        uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+        uint16_t total_vfs = pci_get_word(dev->config + PCI_SRIOV_TOTAL_VF);
+        uint16_t vf_dev_id = pci_get_word(dev->config + PCI_SRIOV_VF_DID);
+
+        unregister_vfs(dev);
+
+        for (uint16_t i = 0; i < total_vfs; i++) {
+            dev->exp.sriov_pf.vf[i]->exp.sriov_vf.pf = NULL;
+
+            pci_config_set_vendor_id(dev->exp.sriov_pf.vf[i]->config, ven_id);
+            pci_config_set_device_id(dev->exp.sriov_pf.vf[i]->config, vf_dev_id);
+        }
+    } else {
+        unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
+    }
 }
 
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
@@ -150,69 +217,173 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
                                 MemoryRegion *memory)
 {
-    PCIIORegion *r;
-    PCIBus *bus = pci_get_bus(dev);
     uint8_t type;
-    pcibus_t size = memory_region_size(memory);
 
-    assert(pci_is_vf(dev)); /* PFs must use pci_register_bar */
-    assert(region_num >= 0);
-    assert(region_num < PCI_NUM_REGIONS);
+    assert(dev->exp.sriov_vf.pf);
     type = dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];
 
-    if (!is_power_of_2(size)) {
-        error_report("%s: PCI region size must be a power"
-                     " of two - type=0x%x, size=0x%"FMT_PCIBUS,
-                     __func__, type, size);
-        exit(1);
-    }
+    return pci_register_bar(dev, region_num, type, memory);
+}
 
-    r = &dev->io_regions[region_num];
-    r->memory = memory;
-    r->address_space =
-        type & PCI_BASE_ADDRESS_SPACE_IO
-        ? bus->address_space_io
-        : bus->address_space_mem;
-    r->size = size;
-    r->type = type;
-
-    r->addr = pci_bar_address(dev, region_num, r->type, r->size);
-    if (r->addr != PCI_BAR_UNMAPPED) {
-        memory_region_add_subregion_overlap(r->address_space,
-                                            r->addr, r->memory, 1);
-    }
+static gint compare_vf_devfns(gconstpointer a, gconstpointer b)
+{
+    return (*(PCIDevice **)a)->devfn - (*(PCIDevice **)b)->devfn;
 }
 
-static void register_vfs(PCIDevice *dev)
+int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
+                                                 uint16_t offset,
+                                                 Error **errp)
 {
-    uint16_t num_vfs;
+    GPtrArray *pf;
+    PCIDevice **vfs;
+    BusState *bus = qdev_get_parent_bus(DEVICE(dev));
+    uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+    uint16_t vf_dev_id;
+    uint16_t vf_offset;
+    uint16_t vf_stride;
     uint16_t i;
-    uint16_t sriov_cap = dev->exp.sriov_cap;
 
-    assert(sriov_cap > 0);
-    num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (!pfs || !dev->qdev.id) {
+        return 0;
+    }
 
-    trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
-                             PCI_FUNC(dev->devfn), num_vfs);
-    for (i = 0; i < num_vfs; i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
+    pf = g_hash_table_lookup(pfs, dev->qdev.id);
+    if (!pf) {
+        return 0;
     }
 
-    pci_set_word(dev->wmask + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+    if (pf->len > UINT16_MAX) {
+        error_setg(errp, "too many VFs");
+        return -1;
+    }
+
+    g_ptr_array_sort(pf, compare_vf_devfns);
+    vfs = (void *)pf->pdata;
+
+    if (vfs[0]->devfn <= dev->devfn) {
+        error_setg(errp, "a VF function number is less than the PF function number");
+        return -1;
+    }
+
+    vf_dev_id = pci_get_word(vfs[0]->config + PCI_DEVICE_ID);
+    vf_offset = vfs[0]->devfn - dev->devfn;
+    vf_stride = pf->len < 2 ? 0 : vfs[1]->devfn - vfs[0]->devfn;
+
+    for (i = 0; i < pf->len; i++) {
+        if (bus != qdev_get_parent_bus(&vfs[i]->qdev)) {
+            error_setg(errp, "SR-IOV VF parent bus mismatches with PF");
+            return -1;
+        }
+
+        if (ven_id != pci_get_word(vfs[i]->config + PCI_VENDOR_ID)) {
+            error_setg(errp, "SR-IOV VF vendor ID mismatches with PF");
+            return -1;
+        }
+
+        if (vf_dev_id != pci_get_word(vfs[i]->config + PCI_DEVICE_ID)) {
+            error_setg(errp, "inconsistent SR-IOV VF device IDs");
+            return -1;
+        }
+
+        for (size_t j = 0; j < PCI_NUM_REGIONS; j++) {
+            if (vfs[i]->io_regions[j].size != vfs[0]->io_regions[j].size ||
+                vfs[i]->io_regions[j].type != vfs[0]->io_regions[j].type) {
+                error_setg(errp, "inconsistent SR-IOV BARs");
+                return -1;
+            }
+        }
+
+        if (vfs[i]->devfn - vfs[0]->devfn != vf_stride * i) {
+            error_setg(errp, "inconsistent SR-IOV stride");
+            return -1;
+        }
+    }
+
+    if (!pcie_sriov_pf_init_common(dev, offset, vf_dev_id, pf->len,
+                                   pf->len, vf_offset, vf_stride, errp)) {
+        return -1;
+    }
+
+    for (i = 0; i < pf->len; i++) {
+        vfs[i]->exp.sriov_vf.pf = dev;
+        vfs[i]->exp.sriov_vf.vf_number = i;
+
+        /* set vid/did according to sr/iov spec - they are not used */
+        pci_config_set_vendor_id(vfs[i]->config, 0xffff);
+        pci_config_set_device_id(vfs[i]->config, 0xffff);
+    }
+
+    dev->exp.sriov_pf.vf = vfs;
+    dev->exp.sriov_pf.vf_user_created = true;
+
+    for (i = 0; i < PCI_NUM_REGIONS; i++) {
+        PCIIORegion *region = &vfs[0]->io_regions[i];
+
+        if (region->size) {
+            pcie_sriov_pf_init_vf_bar(dev, i, region->type, region->size);
+        }
+    }
+
+    return PCI_EXT_CAP_SRIOV_SIZEOF;
 }
 
-static void unregister_vfs(PCIDevice *dev)
+bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
 {
-    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
-    uint16_t i;
+    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
+        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
 
-    trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn));
-    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
+    if (dev->sriov_pf) {
+        PCIDevice *pci_pf;
+        GPtrArray *pf;
+
+        if (!PCI_DEVICE_GET_CLASS(dev)->sriov_vf_user_creatable) {
+            error_setg(errp, "user cannot create SR-IOV VF with this device type");
+            return false;
+        }
+
+        if (!pci_is_express(dev)) {
+            error_setg(errp, "PCI Express is required for SR-IOV VF");
+            return false;
+        }
+
+        if (!pci_qdev_find_device(dev->sriov_pf, &pci_pf)) {
+            error_setg(errp, "PCI device specified as SR-IOV PF already exists");
+            return false;
+        }
+
+        if (!pfs) {
+            pfs = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL);
+        }
+
+        pf = g_hash_table_lookup(pfs, dev->sriov_pf);
+        if (!pf) {
+            pf = g_ptr_array_new();
+            g_hash_table_insert(pfs, g_strdup(dev->sriov_pf), pf);
+        }
+
+        g_ptr_array_add(pf, dev);
     }
 
-    pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
+    return true;
+}
+
+void pcie_sriov_unregister_device(PCIDevice *dev)
+{
+    if (dev->sriov_pf && pfs) {
+        GPtrArray *pf = g_hash_table_lookup(pfs, dev->sriov_pf);
+
+        if (pf) {
+            g_ptr_array_remove_fast(pf, dev);
+
+            if (!pf->len) {
+                g_hash_table_remove(pfs, dev->sriov_pf);
+                g_ptr_array_free(pf, FALSE);
+            }
+        }
+    }
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -308,7 +479,7 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize)
 
 uint16_t pcie_sriov_vf_number(PCIDevice *dev)
 {
-    assert(pci_is_vf(dev));
+    assert(dev->exp.sriov_vf.pf);
     return dev->exp.sriov_vf.vf_number;
 }
 

-- 
2.46.0


