Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80C2C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdi-0005zE-9Q; Wed, 14 May 2025 07:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdW-0005um-Gh
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdQ-0006B9-Fx
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V7Zupo9TXzFoN57AunOFGKvoge5PaWmgERKBYSwltWU=;
 b=OvHZmltNM8UI+7pZfqXWrZAodkB72fAfkZP6yIyCeSgTCP68GBSWCBveMcLmWjaeyZzZl8
 WtZ5vpS8NWTlkGQ2nl4u81roEmWohVbF7jYl8GJ/dJZYx9IAkBXMefrIXG09+v+ZjT2i3Q
 RZpAEUI5XxK56lloQCpmSLWgY6xIl/4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-e-DLj64jPCaWqTthRmhcbQ-1; Wed, 14 May 2025 07:50:50 -0400
X-MC-Unique: e-DLj64jPCaWqTthRmhcbQ-1
X-Mimecast-MFC-AGG-ID: e-DLj64jPCaWqTthRmhcbQ_1747223449
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so35321995e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223448; x=1747828248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7Zupo9TXzFoN57AunOFGKvoge5PaWmgERKBYSwltWU=;
 b=WXlPeanW9OxoeiaCZrlYx/WayzYWnySuJltDWNRPKzb2z+cEAtSU3wZUrXmzz3M5d+
 Gqb8Fi5Gw5vrEmcvzeiQfvFTO2puAirTLLoeXJcpFhzQYU+8OUEAJsk/q5sE6cZX2oM7
 35NR9UaGazPj5KP6BSbTsAu7wVNI5K3njCqohDoV9gEhgI5dpnFDYOBT7Xxrljfa0FIN
 fe86d7ZHYAurkySDVxqfThzC3KYfontc4r9t/piH1iVBf58YxbMBL9AeHb2wHe8n4JJA
 O0Z5du71NpIdiO11vewEdLoG96yVMXrIXdcpDBhPhEX8mEuH6tbZIpMjOs0Cm/LzAUy0
 MsYw==
X-Gm-Message-State: AOJu0YwScQ7st9czvBFIDNfXqAEH32QLw3CoOk47/RoINChuBKMLy0oT
 mBjHYCEvYfpq7Wg9ffY+m8HlK+s+phyDVZKAMpOjFbL6ADaGEYnMgufZb6LUWGgMN8q0SQgxQTg
 hM9Ytp0EQ/C1KTXimowAN0aaVcKEI3r44AkSLGFoO4QhOUk35qG4AOS5pRe8/gkK975yNaH/DpK
 jr7M647BG0Kwap6RkeXCNIQIf+SQ/9fw==
X-Gm-Gg: ASbGnct0PJkouVajgfHOdByJ3F62nycB5B2uJMJj0r3ToA/ikU2zOAmeLPZGvnpqCCh
 mM96b5rdnnZy5yHV5zuNMW/KxmM0OndyEHy8ANWcpSJTJzX4Vh3OGYKhQX4G06kwFXn2TJSnAbr
 iGt4pRIPK/6o6bdlEmgO64j6DOach82WOzVDh1mBY7qI4ERGuw4pN2PDjnmBIKxQcvQKEh6J/0w
 JHDZvr5FpFVGEFq+Q5x1IPiZBzmvqpF8h+B4Ha2sWU+SMF4ZRuF5UrVbzraW3IBIkCX/WegdWqp
 Q/vI3Q==
X-Received: by 2002:a05:600c:3d0c:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-442f20db193mr30206995e9.14.1747223448083; 
 Wed, 14 May 2025 04:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmrfl3MCljC2ppQUdj6MHzN9h2q4LtNoYCsEfRjo9FWtM3Qr+3gDM8CX3oEgNQ3aSNpqicUQ==
X-Received: by 2002:a05:600c:3d0c:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-442f20db193mr30206655e9.14.1747223447573; 
 Wed, 14 May 2025 04:50:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39e853asm27343315e9.26.2025.05.14.04.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:47 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 12/27] pcie_sriov: Allow user to create SR-IOV device
Message-ID: <19e55471d4e8a494cfda7470e701829e3a873bdc.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A user can create a SR-IOV device by specifying the PF with the
sriov-pf property of the VFs. The VFs must be added before the PF.

A user-creatable VF must have PCIDeviceClass::sriov_vf_user_creatable
set. Such a VF cannot refer to the PF because it is created before the
PF.

A PF that user-creatable VFs can be attached calls
pcie_sriov_pf_init_from_user_created_vfs() during realization and
pcie_sriov_pf_exit() when exiting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250314-sriov-v9-5-57dae8ae3ab5@daynix.com>
Tested-by: Yui Washizu <yui.washidu@gmail.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_device.h |   6 +-
 include/hw/pci/pcie_sriov.h |  18 +++
 hw/pci/pci.c                |  62 +++++---
 hw/pci/pcie_sriov.c         | 288 ++++++++++++++++++++++++++++--------
 4 files changed, 291 insertions(+), 83 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 345b12eaac..e41d95b0b0 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -38,6 +38,8 @@ struct PCIDeviceClass {
     uint16_t subsystem_id;              /* only for header type = 0 */
 
     const char *romfile;                /* rom bar */
+
+    bool sriov_vf_user_creatable;
 };
 
 enum PCIReqIDType {
@@ -177,6 +179,8 @@ struct PCIDevice {
      * realizing the device.
      */
     uint32_t max_bounce_buffer_size;
+
+    char *sriov_pf;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
@@ -209,7 +213,7 @@ static inline int pci_is_express_downstream_port(const PCIDevice *d)
 
 static inline int pci_is_vf(const PCIDevice *d)
 {
-    return d->exp.sriov_vf.pf != NULL;
+    return d->sriov_pf || d->exp.sriov_vf.pf != NULL;
 }
 
 static inline uint32_t pci_config_size(const PCIDevice *d)
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index c5d2d318d3..f75b8f22ee 100644
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
index 039cf1e256..de07096347 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -101,6 +101,7 @@ static const Property pci_props[] = {
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
     DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
                      max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
+    DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
     DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
                     QEMU_PCIE_EXT_TAG_BITNR, true),
     { .name = "busnr", .info = &prop_pci_busnr },
@@ -1112,13 +1113,8 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
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
 
@@ -1151,7 +1147,8 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
     }
     /* function 0 indicates single function, so function > 0 must be NULL */
     for (func = 1; func < PCI_FUNC_MAX; ++func) {
-        if (bus->devices[PCI_DEVFN(slot, func)]) {
+        PCIDevice *device = bus->devices[PCI_DEVFN(slot, func)];
+        if (device && !pci_is_vf(device)) {
             error_setg(errp, "PCI: %x.0 indicates single function, "
                        "but %x.%x is already populated.",
                        slot, slot, func);
@@ -1439,6 +1436,7 @@ static void pci_qdev_unrealize(DeviceState *dev)
 
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
+    pcie_sriov_unregister_device(pci_dev);
 
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -1470,7 +1468,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     pcibus_t size = memory_region_size(memory);
     uint8_t hdr_type;
 
-    assert(!pci_is_vf(pci_dev)); /* VFs must use pcie_sriov_vf_register_bar */
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
     assert(is_power_of_2(size));
@@ -1482,7 +1479,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
 
     r = &pci_dev->io_regions[region_num];
     assert(!r->size);
-    r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
     r->type = type;
     r->memory = memory;
@@ -1490,22 +1486,35 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                         ? pci_get_bus(pci_dev)->address_space_io
                         : pci_get_bus(pci_dev)->address_space_mem;
 
-    wmask = ~(size - 1);
-    if (region_num == PCI_ROM_SLOT) {
-        /* ROM enable bit is writable */
-        wmask |= PCI_ROM_ADDRESS_ENABLE;
-    }
+    if (pci_is_vf(pci_dev)) {
+        PCIDevice *pf = pci_dev->exp.sriov_vf.pf;
+        assert(!pf || type == pf->exp.sriov_pf.vf_bar_type[region_num]);
 
-    addr = pci_bar(pci_dev, region_num);
-    pci_set_long(pci_dev->config + addr, type);
-
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
 
@@ -2272,6 +2281,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
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
index a5b546abe8..08f707e847 100644
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
@@ -31,13 +32,43 @@ static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
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
     int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
@@ -94,6 +125,28 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
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
@@ -123,7 +176,22 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
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
@@ -156,69 +224,173 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
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
-
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
+    return pci_register_bar(dev, region_num, type, memory);
 }
 
-static void register_vfs(PCIDevice *dev)
+static gint compare_vf_devfns(gconstpointer a, gconstpointer b)
 {
-    uint16_t num_vfs;
-    uint16_t i;
-    uint16_t sriov_cap = dev->exp.sriov_cap;
-
-    assert(sriov_cap > 0);
-    num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-
-    trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
-                             PCI_FUNC(dev->devfn), num_vfs);
-    for (i = 0; i < num_vfs; i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
-    }
-
-    pci_set_word(dev->wmask + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+    return (*(PCIDevice **)a)->devfn - (*(PCIDevice **)b)->devfn;
 }
 
-static void unregister_vfs(PCIDevice *dev)
+int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
+                                                 uint16_t offset,
+                                                 Error **errp)
 {
-    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+    GPtrArray *pf;
+    PCIDevice **vfs;
+    BusState *bus = qdev_get_parent_bus(DEVICE(dev));
+    uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+    uint16_t vf_dev_id;
+    uint16_t vf_offset;
+    uint16_t vf_stride;
     uint16_t i;
 
-    trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn));
-    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
+    if (!pfs || !dev->qdev.id) {
+        return 0;
     }
 
-    pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
+    pf = g_hash_table_lookup(pfs, dev->qdev.id);
+    if (!pf) {
+        return 0;
+    }
+
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
+}
+
+bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
+{
+    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
+        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
+
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
+    }
+
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
@@ -314,7 +486,7 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize)
 
 uint16_t pcie_sriov_vf_number(PCIDevice *dev)
 {
-    assert(pci_is_vf(dev));
+    assert(dev->exp.sriov_vf.pf);
     return dev->exp.sriov_vf.vf_number;
 }
 
-- 
MST


