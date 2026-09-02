Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B33C624DA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qWH-0004Hx-HA; Wed, 02 Sep 2026 15:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1qWE-0004HQ-KC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1qWC-00025W-Gk
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788376867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xuq+U6rfrk8iRaF04vxMhoo21C+Y+dWpxjx6CV/2Bk=;
 b=BhsYdppGCyrWD5OaThkb1IfSL1zLMTOGr8M1EzW89tXCooxCY+74BkbGuvATSYvpqsthcJ
 QY3sKMED3OVfPJoMuMTYTsgoZOfVYD+azyb+5rhwuMMNUSEDeVXxmBtm3fQ6ReJfxkR6NZ
 wV90rSyGyB/LW5gc1CdyaYfFRl88bYE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-pK2BIEWGPZm_V0j_FWA76A-1; Wed,
 02 Sep 2026 15:21:05 -0400
X-MC-Unique: pK2BIEWGPZm_V0j_FWA76A-1
X-Mimecast-MFC-AGG-ID: pK2BIEWGPZm_V0j_FWA76A_1788376864
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4158197753D; Wed,  2 Sep 2026 19:21:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6564F3000DA3; Wed,  2 Sep 2026 19:21:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v2 1/9] igb: Add x-vf-migration property and DVSEC
 extended capability
Date: Wed,  2 Sep 2026 21:20:46 +0200
Message-ID: <20260902192054.3329753-2-clg@redhat.com>
In-Reply-To: <20260902192054.3329753-1-clg@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add an "x-vf-migration" property to the IGB PF device and expose a
DVSEC (Designated Vendor-Specific Extended Capability) at offset 0x160
in VF extended config space when migration is enabled.

The DVSEC provides the register interface for VF live migration:
 - CAPS:       supported features (state migration)
 - CTRL:       command doorbell
 - STATUS:     state and error reporting
 - BUF_ADDR:   shared DMA buffer address (GPA)

Move IgbVfState from igbvf.c to igb_common.h so it can be shared with
the migration module, and add the migration state field.

AI-used-for: code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS            |   5 ++
 hw/net/igb_common.h    |  16 +++++++
 hw/net/igb_migration.h |  72 ++++++++++++++++++++++++++++
 hw/net/igb.c           |   2 +
 hw/net/igb_migration.c | 106 +++++++++++++++++++++++++++++++++++++++++
 hw/net/igbvf.c         |  52 ++++++++++++++++----
 hw/net/meson.build     |   2 +-
 7 files changed, 245 insertions(+), 10 deletions(-)
 create mode 100644 hw/net/igb_migration.h
 create mode 100644 hw/net/igb_migration.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a49a40294eb..f88b526be238 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2816,6 +2816,11 @@ F: tests/functional/x86_64/test_netdev_ethtool.py
 F: tests/qtest/igb-test.c
 F: tests/qtest/libqos/igb.c
 
+igb VF migration
+M: Cédric Le Goater <clg@redhat.com>
+S: Maintained
+F: hw/net/igb_migration.*
+
 eepro100
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
index b316a5bcfa5c..f0e2529e757b 100644
--- a/hw/net/igb_common.h
+++ b/hw/net/igb_common.h
@@ -26,7 +26,9 @@
 #ifndef HW_NET_IGB_COMMON_H
 #define HW_NET_IGB_COMMON_H
 
+#include "hw/pci/pci_device.h"
 #include "igb_regs.h"
+#include "igb_migration.h"
 
 #define TYPE_IGBVF "igbvf"
 
@@ -154,4 +156,18 @@ uint64_t igb_mmio_read(void *opaque, hwaddr addr, unsigned size);
 void igb_mmio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size);
 void igb_vf_reset(void *opaque, uint16_t vfn);
 
+OBJECT_DECLARE_SIMPLE_TYPE(IgbVfState, IGBVF)
+
+struct IgbVfState {
+    PCIDevice parent_obj;
+
+    uint16_t vfn;
+    bool migration_enabled;
+
+    MemoryRegion mmio;
+    MemoryRegion msix;
+
+    IgbVfMigState mig;
+};
+
 #endif
diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
new file mode 100644
index 000000000000..3da28e11e49e
--- /dev/null
+++ b/hw/net/igb_migration.h
@@ -0,0 +1,72 @@
+/*
+ * QEMU Intel 82576 SR/IOV VF Migration Support
+ *
+ * Copyright (c) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_NET_IGB_MIGRATION_H
+#define HW_NET_IGB_MIGRATION_H
+
+#include "hw/pci/pci_device.h"
+
+/*
+ * Migration interface exposed as a DVSEC (Designated Vendor-Specific
+ * Extended Capability) in VF extended config space.
+ *
+ * DVSEC layout at IGB_MIG_DVSEC_OFFSET (0x160):
+ *
+ *   +0x00  PCIe extended cap header   (cap_id=0x23, ver=1, next)
+ *   +0x04  DVSEC header 1             (len | rev | vendor_id)
+ *   +0x08  DVSEC header 2             (DVSEC ID)
+ *   +0x0A  Reserved                   (padding for DWORD alignment)
+ *   +0x0C  CAPS                       (RO: F_STATE[0])
+ *   +0x10  CTRL                       (WO: doorbell command)
+ *   +0x14  STATUS                     (RO: state[7:0], error_code[15:8])
+ *   +0x18  BUF_ADDR_LO                (RW: shared buffer GPA low)
+ *   +0x1C  BUF_ADDR_HI                (RW: shared buffer GPA high)
+ */
+
+#define IGB_MIG_DVSEC_OFFSET    0x160
+#define IGB_MIG_DVSEC_SIZE      0x20
+#define IGB_MIG_DVSEC_VER       1
+#define IGB_MIG_DVSEC_ID        1
+
+/* Register offsets relative to DVSEC base */
+#define IGB_MIG_CAPS            0x0C
+#define IGB_MIG_CTRL            0x10
+#define IGB_MIG_STATUS          0x14
+#define IGB_MIG_BUF_ADDR_LO     0x18
+#define IGB_MIG_BUF_ADDR_HI     0x1C
+
+/* CAPS register layout */
+#define IGB_MIG_CAP_F_STATE             (1u << 0)
+
+/* STATUS register: state in [7:0], error code [15:8] */
+#define IGB_MIG_STATUS_STATE_MASK       0xFF
+#define IGB_MIG_STATUS_ERROR_CODE_SHIFT 8
+#define IGB_MIG_STATUS_ERR(code) \
+    ((uint32_t)(code) << IGB_MIG_STATUS_ERROR_CODE_SHIFT)
+
+/* Device states (based on VFIO migration v2) */
+#define IGB_MIG_STATE_ERROR             0
+#define IGB_MIG_STATE_STOP              1
+#define IGB_MIG_STATE_RUNNING           2
+#define IGB_MIG_STATE_STOP_COPY         3
+#define IGB_MIG_STATE_RESUMING          4
+
+typedef struct IgbVfMigState {
+    uint32_t mig_state;
+    uint64_t mig_data_buf_addr;
+} IgbVfMigState;
+
+typedef struct IgbVfState IgbVfState;
+
+bool igbvf_add_migration_dvsec(PCIDevice *dev, Error **errp);
+void igbvf_mig_state_reset(IgbVfState *s);
+uint32_t igbvf_mig_config_read(IgbVfState *s, uint32_t addr, int size);
+bool igbvf_mig_config_write(IgbVfState *s, uint32_t addr, uint32_t val,
+                            int size);
+
+#endif
diff --git a/hw/net/igb.c b/hw/net/igb.c
index c076807e7110..7268e5473fc3 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -79,6 +79,7 @@ struct IGBState {
 
     IGBCore core;
     bool has_flr;
+    bool vf_migration;
 };
 
 #define IGB_CAP_SRIOV_OFFSET    (0x160)
@@ -597,6 +598,7 @@ static const VMStateDescription igb_vmstate = {
 static const Property igb_properties[] = {
     DEFINE_NIC_PROPERTIES(IGBState, conf),
     DEFINE_PROP_BOOL("x-pcie-flr-init", IGBState, has_flr, true),
+    DEFINE_PROP_BOOL("x-vf-migration", IGBState, vf_migration, false),
 };
 
 static void igb_class_init(ObjectClass *class, const void *data)
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
new file mode 100644
index 000000000000..4dfebd82344c
--- /dev/null
+++ b/hw/net/igb_migration.c
@@ -0,0 +1,106 @@
+/*
+ * QEMU Intel 82576 SR/IOV VF Migration Support
+ *
+ * Copyright (c) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci_device.h"
+#include "hw/pci/pcie.h"
+#include "igb_common.h"
+#include "igb_migration.h"
+
+static void igbvf_mig_update_status(IgbVfState *s, uint8_t err)
+{
+    IgbVfMigState *ms = &s->mig;
+    PCIDevice *dev = PCI_DEVICE(s);
+    uint32_t status;
+
+    status = ms->mig_state & IGB_MIG_STATUS_STATE_MASK;
+
+    if (err) {
+        status = IGB_MIG_STATE_ERROR | IGB_MIG_STATUS_ERR(err);
+    }
+
+    pci_set_long(dev->config + IGB_MIG_DVSEC_OFFSET + IGB_MIG_STATUS, status);
+}
+
+
+bool igbvf_add_migration_dvsec(PCIDevice *dev, Error **errp)
+{
+    uint16_t offset = IGB_MIG_DVSEC_OFFSET;
+    uint32_t caps;
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_DVSEC, 1, offset,
+                        IGB_MIG_DVSEC_SIZE);
+
+    /* DVSEC header 1: length[31:20] | rev[19:16] | vendor_id[15:0] */
+    pci_set_long(dev->config + offset + 0x4,
+                 (IGB_MIG_DVSEC_SIZE << 20) |
+                 (IGB_MIG_DVSEC_VER << 16) |
+                 PCI_VENDOR_ID_INTEL);
+
+    /* DVSEC header 2: DVSEC ID */
+    pci_set_word(dev->config + offset + 0x8, IGB_MIG_DVSEC_ID);
+
+    /* CAPS: features (state migration only) */
+    caps = IGB_MIG_CAP_F_STATE;
+    pci_set_long(dev->config + offset + IGB_MIG_CAPS, caps);
+
+    /* STATUS: initial state is RUNNING */
+    pci_set_long(dev->config + offset + IGB_MIG_STATUS,
+                 IGB_MIG_STATE_RUNNING);
+
+    /* BUF_ADDR_LO and BUF_ADDR_HI are writable */
+    memset(dev->wmask + offset + IGB_MIG_BUF_ADDR_LO, 0xff, 4);
+    memset(dev->wmask + offset + IGB_MIG_BUF_ADDR_HI, 0xff, 4);
+
+    return true;
+}
+
+uint32_t igbvf_mig_config_read(IgbVfState *s, uint32_t addr, int size)
+{
+    PCIDevice *dev = PCI_DEVICE(s);
+
+    return pci_default_read_config(dev, addr, size);
+}
+
+bool igbvf_mig_config_write(IgbVfState *s, uint32_t addr, uint32_t val,
+                            int size)
+{
+    PCIDevice *dev = PCI_DEVICE(s);
+    uint32_t offset = addr - IGB_MIG_DVSEC_OFFSET;
+
+    switch (offset) {
+    case IGB_MIG_CTRL:
+        /* Command handling will be added in a later commit */
+        break;
+
+    case IGB_MIG_BUF_ADDR_LO:
+    case IGB_MIG_BUF_ADDR_HI:
+        pci_default_write_config(dev, addr, val, size);
+        break;
+
+    default:
+        break;
+    }
+
+    return true;
+}
+
+void igbvf_mig_state_reset(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+
+    ms->mig_state = IGB_MIG_STATE_RUNNING;
+    ms->mig_data_buf_addr = 0;
+
+    pci_set_long(PCI_DEVICE(s)->config +
+                 IGB_MIG_DVSEC_OFFSET + IGB_MIG_BUF_ADDR_LO, 0);
+    pci_set_long(PCI_DEVICE(s)->config +
+                 IGB_MIG_DVSEC_OFFSET + IGB_MIG_BUF_ADDR_HI, 0);
+
+    igbvf_mig_update_status(s, 0);
+}
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 9a165c7063ee..30dfdb574ac7 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -38,27 +38,21 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 #include "hw/core/hw-error.h"
 #include "hw/net/mii.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie.h"
+#include "hw/pci/pcie_sriov.h"
 #include "hw/pci/msix.h"
 #include "net/eth.h"
 #include "net/net.h"
 #include "igb_common.h"
 #include "igb_core.h"
+#include "igb_migration.h"
 #include "trace.h"
 #include "qapi/error.h"
 
-OBJECT_DECLARE_SIMPLE_TYPE(IgbVfState, IGBVF)
-
-struct IgbVfState {
-    PCIDevice parent_obj;
-
-    MemoryRegion mmio;
-    MemoryRegion msix;
-};
-
 static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
 {
     switch (addr) {
@@ -199,10 +193,35 @@ static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
     return HWADDR_MAX;
 }
 
+static bool igbvf_addr_in_dvsec(uint32_t addr, int len)
+{
+    return ranges_overlap(addr, len,
+                          IGB_MIG_DVSEC_OFFSET, IGB_MIG_DVSEC_SIZE);
+}
+
+static uint32_t igbvf_read_config(PCIDevice *dev, uint32_t addr, int size)
+{
+    IgbVfState *s = IGBVF(dev);
+
+    if (s->migration_enabled && igbvf_addr_in_dvsec(addr, size)) {
+        return igbvf_mig_config_read(s, addr, size);
+    }
+
+    return pci_default_read_config(dev, addr, size);
+}
+
 static void igbvf_write_config(PCIDevice *dev, uint32_t addr, uint32_t val,
     int len)
 {
+    IgbVfState *s = IGBVF(dev);
+
     trace_igbvf_write_config(addr, val, len);
+
+    if (s->migration_enabled && igbvf_addr_in_dvsec(addr, len)) {
+        igbvf_mig_config_write(s, addr, val, len);
+        return;
+    }
+
     pci_default_write_config(dev, addr, val, len);
     if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
                                  "x-pcie-flr-init", &error_abort)) {
@@ -282,13 +301,27 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
     }
 
     pcie_ari_init(dev, 0x150);
+
+    if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
+                                 "x-vf-migration", &error_abort)) {
+        s->vfn = pcie_sriov_vf_number(dev);
+        s->migration_enabled = true;
+        if (!igbvf_add_migration_dvsec(dev, errp)) {
+            return;
+        }
+    }
 }
 
 static void igbvf_qdev_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *vf = PCI_DEVICE(obj);
+    IgbVfState *s = IGBVF(vf);
 
     igb_vf_reset(pcie_sriov_get_pf(vf), pcie_sriov_vf_number(vf));
+
+    if (s->migration_enabled) {
+        igbvf_mig_state_reset(s);
+    }
 }
 
 static void igbvf_pci_uninit(PCIDevice *dev)
@@ -309,6 +342,7 @@ static void igbvf_class_init(ObjectClass *class, const void *data)
 
     c->realize = igbvf_pci_realize;
     c->exit = igbvf_pci_uninit;
+    c->config_read = igbvf_read_config;
     c->vendor_id = PCI_VENDOR_ID_INTEL;
     c->device_id = E1000_DEV_ID_82576_VF;
     c->revision = 1;
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 84f142df222a..bb4b449b25ba 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -11,7 +11,7 @@ system_ss.add(when: 'CONFIG_E1000_PCI', if_true: files('e1000.c', 'e1000x_common
 system_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('net_tx_pkt.c', 'net_rx_pkt.c'))
 system_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('e1000e.c', 'e1000e_core.c', 'e1000x_common.c'))
 system_ss.add(when: 'CONFIG_IGB_PCI_EXPRESS', if_true: files('net_tx_pkt.c', 'net_rx_pkt.c'))
-system_ss.add(when: 'CONFIG_IGB_PCI_EXPRESS', if_true: files('igb.c', 'igbvf.c', 'igb_core.c'))
+system_ss.add(when: 'CONFIG_IGB_PCI_EXPRESS', if_true: files('igb.c', 'igbvf.c', 'igb_core.c', 'igb_migration.c'))
 system_ss.add(when: 'CONFIG_RTL8139_PCI', if_true: files('rtl8139.c'))
 system_ss.add(when: 'CONFIG_TULIP', if_true: files('tulip.c'))
 system_ss.add(when: 'CONFIG_VMXNET3_PCI', if_true: files('net_tx_pkt.c', 'net_rx_pkt.c'))
-- 
2.55.0


