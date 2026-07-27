Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830ACC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4N-0003B3-1D; Mon, 27 Jul 2026 01:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4C-00037Q-QZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4A-0003Ur-PO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxrGdQ0nIXwDaXRl/lGKYpcwFMhthuZPnFSAeFGQRn4=;
 b=iOqZ7ywjCxQlTC+/hey2r7Ck8dJNXEStcZvnivGoEeeAk1FTnst4K2Z3gwNe3JfIydFO1L
 91aRmtzZhhOMAc9OUgrJ8zKHM2LumMPsmh/Em2Q7yDtwfeKNAewYTrcJR1cfSvE3eJZOVM
 Q+yCjNdG0Ld4b+bY5JUm4OBuVJt1b0c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-_sSkTS18M1ucnfoaP7jurg-1; Mon,
 27 Jul 2026 01:39:50 -0400
X-MC-Unique: _sSkTS18M1ucnfoaP7jurg-1
X-Mimecast-MFC-AGG-ID: _sSkTS18M1ucnfoaP7jurg_1785130789
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30F6C195605A; Mon, 27 Jul 2026 05:39:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 888231956088; Mon, 27 Jul 2026 05:39:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 02/11] igb: Add x-vf-migration property and
 vendor-specific capability for IGBVF
Date: Mon, 27 Jul 2026 07:39:26 +0200
Message-ID: <20260727053935.1392269-3-clg@redhat.com>
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
References: <20260727053935.1392269-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Add a PF-level "x-vf-migration" boolean property (default off) that,
when enabled, causes each emulated VF to advertise a vendor-specific
PCI capability in its config space. The variant driver igb-vfio-pci
probes for this capability at bind time and uses its presence to
enable migration support.

The capability is a 16-byte vendor-specific capability (PCI_CAP_ID_VNDR)
containing a magic value ("MIGB"), the BAR index where the migration
region will be mapped, and feature flags indicating which migration
features are supported.

Assisted-by: Claude
Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS                           |  6 +++
 docs/system/device-emulation.rst      |  1 +
 docs/system/devices/igb-migration.rst | 20 ++++++++
 docs/system/devices/igb.rst           |  6 +++
 hw/net/igb_migration.h                | 43 ++++++++++++++++
 hw/net/igb.c                          | 12 +++++
 hw/net/igb_migration.c                | 72 +++++++++++++++++++++++++++
 hw/net/igbvf.c                        | 11 ++++
 hw/net/meson.build                    |  2 +-
 hw/net/trace-events                   |  1 +
 10 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/devices/igb-migration.rst
 create mode 100644 hw/net/igb_migration.h
 create mode 100644 hw/net/igb_migration.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a28935c89866..6d29b905c47c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2765,6 +2765,12 @@ F: tests/functional/x86_64/test_netdev_ethtool.py
 F: tests/qtest/igb-test.c
 F: tests/qtest/libqos/igb.c
 
+igb VF migration
+M: Cédric Le Goater <clg@redhat.com>
+S: Maintained
+F: hw/net/igb_migration.*
+F: docs/system/devices/igb-migration.rst
+
 eepro100
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 40054bb7dfcc..75f423b795cd 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -90,6 +90,7 @@ Emulated Devices
    devices/cxl.rst
    devices/emmc.rst
    devices/igb.rst
+   devices/igb-migration.rst
    devices/ivshmem-flat.rst
    devices/ivshmem.rst
    devices/keyboard.rst
diff --git a/docs/system/devices/igb-migration.rst b/docs/system/devices/igb-migration.rst
new file mode 100644
index 000000000000..017b47c4544e
--- /dev/null
+++ b/docs/system/devices/igb-migration.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. _igb-migration:
+
+igb VF Migration
+----------------
+
+The igb device supports an experimental VF migration interface that allows
+the ``igb-vfio-pci`` variant driver to migrate VF state during live
+migration. This is enabled with the ``x-vf-migration`` property::
+
+  -device igb,x-vf-migration=on,...
+
+When enabled, each emulated VF advertises a vendor-specific PCI capability
+(cap id 0x09) with a magic signature (``0x4D494742`` / "MIGB") that the
+variant driver probes at bind time. The capability contains an interface
+version number, the BAR index hosting the migration register region, and
+feature flags indicating which migration features are supported.
+
+This feature is experimental and the ``x-`` prefix indicates the interface
+may change.
diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
index 50f625fd77e4..00271dbc92c3 100644
--- a/docs/system/devices/igb.rst
+++ b/docs/system/devices/igb.rst
@@ -64,6 +64,12 @@ command:
 
   pyvenv/bin/meson test --suite thorough func-x86_64-netdev_ethtool
 
+VF Migration (experimental)
+===========================
+
+See :ref:`igb-migration` for details on the experimental VF live migration
+interface.
+
 References
 ==========
 
diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
new file mode 100644
index 000000000000..e79892436b21
--- /dev/null
+++ b/hw/net/igb_migration.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU Intel 82576 SR/IOV VF Migration Support
+ *
+ * Copyright (c) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef IGB_MIGRATION_H
+#define IGB_MIGRATION_H
+
+#include "hw/pci/pci_device.h"
+
+/* Migration BAR definitions */
+#define IGB_MIG_BAR_IDX   (2)
+#define IGB_MIG_BAR_SIZE  (64 * 1024)
+
+/*
+ * Vendor-specific PCI capability for migration discovery.
+ *
+ * The igb-vfio-pci variant driver probes for this at bind time.
+ * If present, the driver knows the emulated VF supports migration.
+ */
+#define IGB_MIG_CAP_MAGIC    0x4D494742  /* "MIGB" */
+#define IGB_MIG_CAP_VERSION  1
+
+#define IGB_MIG_CAP_F_STATE  (1u << 0)   /* device state serialization */
+#define IGB_MIG_CAP_F_DIRTY  (1u << 1)   /* dirty page tracking */
+
+#define IGB_MIG_CAP_SIZE     16
+#define IGB_MIG_CAP_OFF_MAGIC  4    /* offset within cap for magic field */
+#define IGB_MIG_CAP_OFF_BARID  8    /* offset within cap for BAR id */
+#define IGB_MIG_CAP_OFF_FLAGS  12   /* offset within cap for feature flags */
+
+typedef struct IgbVfMigState {
+    bool migration_cap;
+    MemoryRegion mig_bar;
+} IgbVfMigState;
+
+void igb_pf_init_migration_bar(PCIDevice *dev);
+bool igbvf_add_migration_cap(PCIDevice *dev, Error **errp);
+
+#endif
diff --git a/hw/net/igb.c b/hw/net/igb.c
index c076807e7110..b43235996db2 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -57,6 +57,7 @@
 
 #include "igb_common.h"
 #include "igb_core.h"
+#include "igb_migration.h"
 
 #include "trace.h"
 #include "qapi/error.h"
@@ -69,6 +70,7 @@ struct IGBState {
     PCIDevice parent_obj;
     NICState *nic;
     NICConf conf;
+    bool vf_migration;
 
     MemoryRegion mmio;
     MemoryRegion flash;
@@ -459,6 +461,15 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
     pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MSIX_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
         IGBVF_MSIX_SIZE);
+    /*
+     * When VF migration support is enabled, register an additional VF
+     * BAR for the migration register region. The variant driver
+     * discovers this via a vendor-specific PCI capability that points
+     * to this BAR.
+     */
+    if (s->vf_migration) {
+        igb_pf_init_migration_bar(pci_dev);
+    }
 
     igb_init_net_peer(s, pci_dev, macaddr);
 
@@ -597,6 +608,7 @@ static const VMStateDescription igb_vmstate = {
 static const Property igb_properties[] = {
     DEFINE_NIC_PROPERTIES(IGBState, conf),
     DEFINE_PROP_BOOL("x-pcie-flr-init", IGBState, has_flr, true),
+    DEFINE_PROP_BOOL("x-vf-migration", IGBState, vf_migration, false),
 };
 
 static void igb_class_init(ObjectClass *class, const void *data)
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
new file mode 100644
index 000000000000..794f1217d3e5
--- /dev/null
+++ b/hw/net/igb_migration.c
@@ -0,0 +1,72 @@
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
+#include "trace.h"
+
+
+
+/*
+ * 32-bit prefetchable BAR. A 64-bit BAR2 would consume BAR2+BAR3, but
+ * BAR3 is already used for MSI-X (IGBVF_MSIX_BAR_IDX = 3).
+ *
+ *   BAR   Index       Type            Size   Purpose
+ *   BAR0  0+1    64-bit prefetchable  16 KB  MMIO registers
+ *   BAR2  2      32-bit prefetchable  64 KB  Migration
+ *   BAR3  3+4    64-bit prefetchable  16 KB  MSI-X table + PBA
+ *   BAR5  5      -                    -      Unused
+ */
+void igb_pf_init_migration_bar(PCIDevice *dev)
+{
+    pcie_sriov_pf_init_vf_bar(dev, IGB_MIG_BAR_IDX,
+                              PCI_BASE_ADDRESS_MEM_PREFETCH,
+                              IGB_MIG_BAR_SIZE);
+}
+
+/*
+ * Add vendor-specific PCI capability that the variant driver probes for.
+ *
+ * Layout (16 bytes):
+ *   [0]  cap_id      (PCI_CAP_ID_VNDR = 0x09)
+ *   [1]  next_cap
+ *   [2]  cap_len     (16)
+ *   [3]  version     (IGB_MIG_CAP_VERSION)
+ *   [4-7]  magic     (IGB_MIG_CAP_MAGIC, little-endian)
+ *   [8-11] bar_id    (IGB_MIG_BAR_IDX, little-endian)
+ *   [12-15] flags    (feature flags, little-endian)
+ */
+bool igbvf_add_migration_cap(PCIDevice *dev, Error **errp)
+{
+    int offset;
+
+    offset = pci_add_capability(dev, PCI_CAP_ID_VNDR, 0,
+                                IGB_MIG_CAP_SIZE, errp);
+    if (offset < 0) {
+        return false;
+    }
+
+    /* Length and version in the standard cap flags word */
+    pci_set_byte(dev->config + offset + PCI_CAP_FLAGS,
+                 IGB_MIG_CAP_SIZE);
+    pci_set_byte(dev->config + offset + PCI_CAP_FLAGS + 1,
+                 IGB_MIG_CAP_VERSION);
+
+    pci_set_long(dev->config + offset + IGB_MIG_CAP_OFF_MAGIC,
+                 IGB_MIG_CAP_MAGIC);
+    pci_set_long(dev->config + offset + IGB_MIG_CAP_OFF_BARID,
+                 IGB_MIG_BAR_IDX);
+    pci_set_long(dev->config + offset + IGB_MIG_CAP_OFF_FLAGS,
+                 IGB_MIG_CAP_F_STATE);
+
+    trace_igbvf_mig_cap_add(pcie_sriov_vf_number(dev), offset);
+    return true;
+}
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 9a165c7063ee..94c9739cd58c 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -47,6 +47,7 @@
 #include "net/net.h"
 #include "igb_common.h"
 #include "igb_core.h"
+#include "igb_migration.h"
 #include "trace.h"
 #include "qapi/error.h"
 
@@ -57,6 +58,8 @@ struct IgbVfState {
 
     MemoryRegion mmio;
     MemoryRegion msix;
+
+    IgbVfMigState mig;
 };
 
 static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
@@ -272,6 +275,14 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
         hw_error("Failed to initialize PCIe capability");
     }
 
+    s->mig.migration_cap = object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
+                                                "x-vf-migration", &error_abort);
+    if (s->mig.migration_cap) {
+        if (!igbvf_add_migration_cap(dev, errp)) {
+            return;
+        }
+    }
+
     if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
                                  "x-pcie-flr-init", &error_abort)) {
         pcie_cap_flr_init(dev);
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
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 001a20b0e2ac..06d8848023e5 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -294,6 +294,7 @@ igb_wrn_rx_desc_modes_not_supp(int desc_type) "Not supported descriptor type: %d
 
 # igbvf.c
 igbvf_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
+igbvf_mig_cap_add(uint16_t vfn, int offset) "VF%u: added migration vendor cap at config offset 0x%x"
 
 # spapr_llan.c
 spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32
-- 
2.55.0


