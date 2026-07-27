Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF06C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4P-0003Js-LK; Mon, 27 Jul 2026 01:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4E-00037W-Vp
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4C-0003V4-Ea
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIHHs32s1QVOrS+3x8DSNomksyIAyXwqLOWhx7sbx6k=;
 b=JGIS9bTt7PB2BowbpUQVE6a+F4spyUnQ20t1EAQhC29UIobQnUOtmcEviyJ2I1UVgwHlhi
 UuTQ7BSCoNTaztxjy2Gbzk7h+AY47EtzG87Qg7a5NtGR8oi0NhsFTwKHX6+u6+xUsFaHdi
 taQRi5LQDJM6/B/jXJ4QDlZPfNzpl78=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-9TUn0N-rOTG84aagrt-OCA-1; Mon,
 27 Jul 2026 01:39:54 -0400
X-MC-Unique: 9TUn0N-rOTG84aagrt-OCA-1
X-Mimecast-MFC-AGG-ID: 9TUn0N-rOTG84aagrt-OCA_1785130793
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB81A1955F1E; Mon, 27 Jul 2026 05:39:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A29CB1956088; Mon, 27 Jul 2026 05:39:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 03/11] igb: Add migration BAR with state machine
Date: Mon, 27 Jul 2026 07:39:27 +0200
Message-ID: <20260727053935.1392269-4-clg@redhat.com>
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

When x-vf-migration=on, register a 64KB migration BAR (BAR2) on each
emulated VF. This BAR implements a VFIO-like migration state machine
that the igb-vfio-pci variant driver uses to serialize/deserialize VF
device state during live migration.

The migration register region is laid out as:

  0x000  DEVICE_STATE       (RW)  - migration state machine control
  0x004  MIG_STATUS         (RO)  - status flags (DATA_AVAIL, ERROR,
                                    QUIESCED) + error code in [15:8]
  0x008  MIG_CAPS           (RO)  - advertised capabilities
  0x00C  MIG_VERSION        (RO)  - interface version
  0x010  DATA_SIZE          (RW)  - max state size at reset, actual after save
  0x014  DATA_XFER          (WO)  - trigger DMA save or DMA load
  0x018  DATA_BUF_ADDR_LO   (WO)  - low 32 bits of state DMA buffer
  0x01C  DATA_BUF_ADDR_HI   (WO)  - high 32 bits of state DMA buffer

State data is transferred via a driver-provided DMA buffer. The driver
writes its PF DMA address to DATA_BUF_ADDR_LO/HI and triggers the
transfer with DATA_XFER. The device DMA-writes the serialized state on
save and DMA-reads it on restore. DMA is performed through the PF
device (pcie_sriov_get_pf) because VFIO owns the VF's IOMMU domain.

VF state serialization is added in the next patch.

Assisted-by: Claude
Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/devices/igb-migration.rst |  43 ++++
 hw/net/igb_common.h                   |  11 +
 hw/net/igb_migration.h                |  52 +++++
 hw/net/igb_migration.c                | 293 ++++++++++++++++++++++++++
 hw/net/igbvf.c                        |  18 +-
 hw/net/trace-events                   |   8 +
 6 files changed, 416 insertions(+), 9 deletions(-)

diff --git a/docs/system/devices/igb-migration.rst b/docs/system/devices/igb-migration.rst
index 017b47c4544e..04c44ef072af 100644
--- a/docs/system/devices/igb-migration.rst
+++ b/docs/system/devices/igb-migration.rst
@@ -18,3 +18,46 @@ feature flags indicating which migration features are supported.
 
 This feature is experimental and the ``x-`` prefix indicates the interface
 may change.
+
+Migration BAR layout
+~~~~~~~~~~~~~~~~~~~~
+
+The migration BAR (BAR2, 64 KB) implements a VFIO-like state machine with
+the following register layout::
+
+  Offset  Name                Access  Description
+  0x000   DEVICE_STATE        RW      Migration state (RUNNING=2, STOP=1,
+                                      STOP_COPY=3, RESUMING=4, PRE_COPY=5)
+  0x004   STATUS              RO      Flags[2:0]: DATA_AVAIL, ERROR, QUIESCED
+                                      Error code[15:8] (when ERROR is set)
+  0x008   CAPS                RO      F_STATE, F_DIRTY, max_ranges[11:8],
+                                      pgsizes[31:12]
+  0x00C   VERSION             RO      Interface version (1)
+  0x010   DATA_SIZE           RW      Max state size at reset, actual after save
+  0x014   DATA_XFER           WO      Trigger DMA save or DMA load
+  0x018   DATA_BUF_ADDR_LO    WO      Low 32 bits of state DMA buffer address
+  0x01C   DATA_BUF_ADDR_HI    WO      High 32 bits of state DMA buffer address
+
+State transitions follow the VFIO migration state machine: the driver
+writes to ``DEVICE_STATE`` to move between states and reads ``STATUS``
+to check for completion.
+
+State data is transferred via a driver-provided DMA buffer. The driver
+writes its PF DMA address to ``DATA_BUF_ADDR_LO/HI`` and triggers the
+transfer with ``DATA_XFER``. The device DMA-writes the serialized state
+on save and DMA-reads it on restore. DMA is performed through the PF
+device because VFIO owns the VF's IOMMU domain.
+
+The state blob is a versioned sequence of register (offset, value)
+pairs.
+
+When ``STATUS`` has the ``ERROR`` bit set, bits [15:8] contain an error
+code identifying the failure::
+
+  0  (none)          No error
+  1  BAD_MAGIC       State blob magic mismatch
+  2  BAD_VERSION     State blob version mismatch
+  3  BAD_SIZE        State blob too large or empty
+  4  BAD_VFN         VF number mismatch (source != destination)
+  5  DMA_FAILED      DMA transfer to/from state buffer failed
+  6  NO_BUFFER       DATA_XFER without buffer address set
diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
index b316a5bcfa5c..01816e002c23 100644
--- a/hw/net/igb_common.h
+++ b/hw/net/igb_common.h
@@ -27,6 +27,7 @@
 #define HW_NET_IGB_COMMON_H
 
 #include "igb_regs.h"
+#include "igb_migration.h"
 
 #define TYPE_IGBVF "igbvf"
 
@@ -36,6 +37,16 @@
 #define IGBVF_MMIO_SIZE     (16 * 1024)
 #define IGBVF_MSIX_SIZE     (16 * 1024)
 
+struct IgbVfState {
+    PCIDevice parent_obj;
+    uint16_t vfn;
+
+    MemoryRegion mmio;
+    MemoryRegion msix;
+
+    IgbVfMigState mig;
+};
+
 #define defreg(x) x = (E1000_##x >> 2)
 #define defreg_indexed(x, i) x##i = (E1000_##x(i) >> 2)
 #define defreg_indexeda(x, i) x##i##_A = (E1000_##x##_A(i) >> 2)
diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index e79892436b21..739a189810b0 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -32,12 +32,64 @@
 #define IGB_MIG_CAP_OFF_BARID  8    /* offset within cap for BAR id */
 #define IGB_MIG_CAP_OFF_FLAGS  12   /* offset within cap for feature flags */
 
+/*
+ * Maximum serialized VF state size, sized to hold all per-VF
+ * registers plus TX context descriptors with room to spare.
+ */
+#define IGB_VF_STATE_MAX_SIZE   4096
+
+/*
+ * Migration BAR register offsets.
+ */
+#define IGB_MIG_DEVICE_STATE        0x000
+#define IGB_MIG_STATUS              0x004
+#define IGB_MIG_CAPS                0x008
+#define IGB_MIG_VERSION             0x00C
+#define IGB_MIG_DATA_SIZE           0x010
+#define IGB_MIG_DATA_XFER           0x014
+#define IGB_MIG_DATA_BUF_ADDR_LO    0x018
+#define IGB_MIG_DATA_BUF_ADDR_HI    0x01C
+
+/* DEVICE_STATE values - mirrors VFIO migration states */
+#define IGB_MIG_STATE_ERROR         0
+#define IGB_MIG_STATE_STOP          1
+#define IGB_MIG_STATE_RUNNING       2
+#define IGB_MIG_STATE_STOP_COPY     3
+#define IGB_MIG_STATE_RESUMING      4
+#define IGB_MIG_STATE_PRE_COPY      5
+
+/* MIG_STATUS bits */
+#define IGB_MIG_STATUS_DATA_AVAIL   (1u << 0)
+#define IGB_MIG_STATUS_ERROR        (1u << 1)
+
+/* MIG_STATUS error codes in bits [15:8], valid when ERROR bit is set */
+#define IGB_MIG_STATUS_ERR_SHIFT    8
+#define IGB_MIG_STATUS_ERR_MASK     (0xffu << IGB_MIG_STATUS_ERR_SHIFT)
+#define IGB_MIG_STATUS_ERR(code)    (IGB_MIG_STATUS_ERROR | \
+                                     ((uint32_t)(code) << IGB_MIG_STATUS_ERR_SHIFT))
+
+#define IGB_MIG_ERR_BAD_MAGIC       1
+#define IGB_MIG_ERR_BAD_VERSION     2
+#define IGB_MIG_ERR_BAD_SIZE        3
+#define IGB_MIG_ERR_BAD_VFN         4
+#define IGB_MIG_ERR_DMA_FAILED      5
+#define IGB_MIG_ERR_NO_BUFFER       6
+
 typedef struct IgbVfMigState {
     bool migration_cap;
     MemoryRegion mig_bar;
+
+    uint32_t mig_state;
+    uint8_t mig_error;
+    uint8_t mig_data[IGB_VF_STATE_MAX_SIZE];
+    uint32_t mig_data_size;
+    uint64_t mig_data_buf_addr;
 } IgbVfMigState;
 
+typedef struct IgbVfState  IgbVfState;
 void igb_pf_init_migration_bar(PCIDevice *dev);
 bool igbvf_add_migration_cap(PCIDevice *dev, Error **errp);
+void igbvf_mig_bar_init(IgbVfState *s);
+void igbvf_mig_state_reset(IgbVfState *s);
 
 #endif
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 794f1217d3e5..a0d044815fd9 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -7,9 +7,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie.h"
+#include "net/eth.h"
+#include "net/net.h"
 #include "igb_common.h"
+#include "igb_core.h"
 #include "igb_migration.h"
 #include "trace.h"
 
@@ -70,3 +74,292 @@ bool igbvf_add_migration_cap(PCIDevice *dev, Error **errp)
     trace_igbvf_mig_cap_add(pcie_sriov_vf_number(dev), offset);
     return true;
 }
+
+/*
+ * =====================================================================
+ * Per-VF state serialization / deserialization
+ * =====================================================================
+ */
+
+static int igb_core_vf_save_state(IgbVfState *s,
+                                  void *buf, size_t buf_size)
+{
+    int size = 0;
+
+    trace_igbvf_mig_save_state(s->vfn, size);
+    return size;
+}
+
+static int igb_core_vf_max_data_size(IgbVfState *s)
+{
+    int size = igb_core_vf_save_state(s, NULL, 0);
+
+    g_assert(size > 0 && size <= IGB_VF_STATE_MAX_SIZE);
+    return size;
+}
+
+static int igb_core_vf_load_state(IgbVfState *s,
+                                  const void *buf, size_t size)
+{
+    trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
+    return 0;
+}
+
+static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
+{
+    int ret;
+
+    ret = igb_core_vf_load_state(s, buf, size);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
+/* ================================================================
+ * Migration BAR register read/write handlers
+ * ================================================================ */
+
+static bool igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
+{
+    IgbVfMigState *ms = &s->mig;
+    uint32_t old = ms->mig_state;
+    int ret;
+
+    switch (new_state) {
+    case IGB_MIG_STATE_STOP:
+        if (old != IGB_MIG_STATE_RUNNING &&
+            old != IGB_MIG_STATE_STOP_COPY &&
+            old != IGB_MIG_STATE_RESUMING &&
+            old != IGB_MIG_STATE_ERROR) {
+            return false;
+        }
+        /* Restore DATA_SIZE to max, same as at reset */
+        ms->mig_data_size = igb_core_vf_max_data_size(s);
+        break;
+
+    case IGB_MIG_STATE_RUNNING:
+        if (old != IGB_MIG_STATE_STOP) {
+            return false;
+        }
+        break;
+
+    case IGB_MIG_STATE_STOP_COPY:
+        if (old != IGB_MIG_STATE_STOP) {
+            return false;
+        }
+        ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
+        if (ret < 0) {
+            ms->mig_error = -ret;
+            ms->mig_state = IGB_MIG_STATE_ERROR;
+            return false;
+        }
+        ms->mig_data_size = ret;
+        break;
+
+    case IGB_MIG_STATE_RESUMING:
+        if (old != IGB_MIG_STATE_STOP) {
+            return false;
+        }
+        memset(ms->mig_data, 0, sizeof(ms->mig_data));
+        ms->mig_data_size = 0;
+        break;
+
+    default:
+        trace_igbvf_mig_set_state_err(s->vfn, old, new_state);
+        return false;
+    }
+
+    ms->mig_state = new_state;
+    trace_igbvf_mig_set_state(s->vfn, old, new_state);
+    return true;
+}
+
+static uint32_t igbvf_mig_get_status(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+    uint32_t status = 0;
+
+    if (ms->mig_state == IGB_MIG_STATE_ERROR) {
+        status |= IGB_MIG_STATUS_ERR(ms->mig_error);
+    }
+    if (ms->mig_state == IGB_MIG_STATE_STOP_COPY && ms->mig_data_size > 0) {
+        status |= IGB_MIG_STATUS_DATA_AVAIL;
+    }
+
+    return status;
+}
+
+static void igbvf_mig_data_xfer(IgbVfState *s, uint32_t val)
+{
+    IgbVfMigState *ms = &s->mig;
+    MemTxResult r;
+    int ret;
+
+    if (!ms->mig_data_buf_addr) {
+        ms->mig_error = IGB_MIG_ERR_NO_BUFFER;
+        ms->mig_state = IGB_MIG_STATE_ERROR;
+        return;
+    }
+
+    switch (ms->mig_state) {
+    case IGB_MIG_STATE_STOP_COPY:
+        /* Save: DMA-write serialized state to driver buffer */
+        r = pci_dma_write(pcie_sriov_get_pf(PCI_DEVICE(s)),
+                          ms->mig_data_buf_addr,
+                          ms->mig_data, ms->mig_data_size);
+        if (r != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "igbvf: VF%u state write failed at 0x%" PRIx64 "\n",
+                          s->vfn, ms->mig_data_buf_addr);
+            ms->mig_error = IGB_MIG_ERR_DMA_FAILED;
+            ms->mig_state = IGB_MIG_STATE_ERROR;
+        }
+        break;
+
+    case IGB_MIG_STATE_RESUMING:
+        /* Restore: DMA-read state from driver buffer and deserialize */
+        if (ms->mig_data_size == 0 ||
+            ms->mig_data_size > sizeof(ms->mig_data)) {
+            ms->mig_error = IGB_MIG_ERR_BAD_SIZE;
+            ms->mig_state = IGB_MIG_STATE_ERROR;
+            break;
+        }
+
+        r = pci_dma_read(pcie_sriov_get_pf(PCI_DEVICE(s)),
+                         ms->mig_data_buf_addr,
+                         ms->mig_data, ms->mig_data_size);
+        if (r != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "igbvf: VF%u state read failed at 0x%" PRIx64 "\n",
+                          s->vfn, ms->mig_data_buf_addr);
+            ms->mig_error = IGB_MIG_ERR_DMA_FAILED;
+            ms->mig_state = IGB_MIG_STATE_ERROR;
+            break;
+        }
+
+        ret = igbvf_mig_load(s, ms->mig_data, ms->mig_data_size);
+        if (ret < 0) {
+            ms->mig_error = -ret;
+            ms->mig_state = IGB_MIG_STATE_ERROR;
+        }
+        break;
+
+    default:
+        break;
+    }
+}
+
+static uint64_t igbvf_mig_read(void *opaque, hwaddr addr, unsigned size)
+{
+    IgbVfState *s = opaque;
+    IgbVfMigState *ms = &s->mig;
+    uint64_t val = 0;
+
+    switch (addr) {
+    case IGB_MIG_DEVICE_STATE:
+        val = ms->mig_state;
+        break;
+    case IGB_MIG_STATUS:
+        val = igbvf_mig_get_status(s);
+        break;
+    case IGB_MIG_CAPS:
+        val = IGB_MIG_CAP_F_STATE;
+        break;
+    case IGB_MIG_VERSION:
+        val = IGB_MIG_CAP_VERSION;
+        break;
+    case IGB_MIG_DATA_SIZE:
+        val = ms->mig_data_size;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "igbvf: VF%u bad migration BAR read at 0x%"
+                      HWADDR_PRIx "\n", s->vfn, addr);
+        break;
+    }
+
+    trace_igbvf_mig_bar_read(s->vfn, addr, val);
+
+    return val;
+}
+
+static void igbvf_mig_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    IgbVfState *s = opaque;
+    IgbVfMigState *ms = &s->mig;
+
+    trace_igbvf_mig_bar_write(s->vfn, addr, val);
+
+    switch (addr) {
+    case IGB_MIG_DEVICE_STATE:
+        igbvf_mig_set_state(s, (uint32_t)val);
+        break;
+    case IGB_MIG_DATA_SIZE:
+        if (val <= sizeof(ms->mig_data)) {
+            ms->mig_data_size = (uint32_t)val;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "igbvf: VF%u DATA_SIZE %" PRIu64 " exceeds max %zu\n",
+                          s->vfn, val, sizeof(ms->mig_data));
+        }
+        break;
+    case IGB_MIG_DATA_XFER:
+        igbvf_mig_data_xfer(s, (uint32_t)val);
+        break;
+    case IGB_MIG_DATA_BUF_ADDR_LO:
+        ms->mig_data_buf_addr =
+            deposit64(ms->mig_data_buf_addr, 0, 32, val);
+        break;
+    case IGB_MIG_DATA_BUF_ADDR_HI:
+        ms->mig_data_buf_addr =
+            deposit64(ms->mig_data_buf_addr, 32, 32, val);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "igbvf: VF%u bad migration BAR write at 0x%"
+                      HWADDR_PRIx "\n", s->vfn, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps mig_bar_ops = {
+    .read = igbvf_mig_read,
+    .write = igbvf_mig_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Use the QEM-internal PCI_BASE_ADDRESS_MEM_ALWAYS_ON BAR type flag
+ * to keep the memory BAR always mapped.
+ */
+void igbvf_mig_bar_init(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+
+    memory_region_init_io(&ms->mig_bar, OBJECT(s), &mig_bar_ops, s,
+                          "igbvf-mig", IGB_MIG_BAR_SIZE);
+    pci_register_bar(PCI_DEVICE(s), IGB_MIG_BAR_IDX,
+                     PCI_BASE_ADDRESS_MEM_PREFETCH |
+                     PCI_BASE_ADDRESS_MEM_ALWAYS_ON,
+                     &ms->mig_bar);
+    trace_igbvf_mig_bar_init(s->vfn);
+}
+
+void igbvf_mig_state_reset(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+
+    ms->mig_state = IGB_MIG_STATE_RUNNING;
+    ms->mig_error = 0;
+    ms->mig_data_size = igb_core_vf_max_data_size(s);
+    ms->mig_data_buf_addr = 0;
+    memset(ms->mig_data, 0, sizeof(ms->mig_data));
+    trace_igbvf_mig_reset(s->vfn);
+}
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 94c9739cd58c..e9f9fc3369d8 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -53,15 +53,6 @@
 
 OBJECT_DECLARE_SIMPLE_TYPE(IgbVfState, IGBVF)
 
-struct IgbVfState {
-    PCIDevice parent_obj;
-
-    MemoryRegion mmio;
-    MemoryRegion msix;
-
-    IgbVfMigState mig;
-};
-
 static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
 {
     switch (addr) {
@@ -281,6 +272,10 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
         if (!igbvf_add_migration_cap(dev, errp)) {
             return;
         }
+
+        s->vfn = pcie_sriov_vf_number(dev);
+        igbvf_mig_bar_init(s);
+        igbvf_mig_state_reset(s);
     }
 
     if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
@@ -298,8 +293,13 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
 static void igbvf_qdev_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *vf = PCI_DEVICE(obj);
+    IgbVfState *s = IGBVF(obj);
 
     igb_vf_reset(pcie_sriov_get_pf(vf), pcie_sriov_vf_number(vf));
+
+    if (s->mig.migration_cap) {
+        igbvf_mig_state_reset(s);
+    }
 }
 
 static void igbvf_pci_uninit(PCIDevice *dev)
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 06d8848023e5..0b13a99b3f32 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -295,6 +295,14 @@ igb_wrn_rx_desc_modes_not_supp(int desc_type) "Not supported descriptor type: %d
 # igbvf.c
 igbvf_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
 igbvf_mig_cap_add(uint16_t vfn, int offset) "VF%u: added migration vendor cap at config offset 0x%x"
+igbvf_mig_bar_init(uint16_t vfn) "VF%u: migration BAR initialized"
+igbvf_mig_bar_read(uint16_t vfn, uint64_t addr, uint64_t val) "VF%u: BAR read addr=0x%"PRIx64" val=0x%"PRIx64
+igbvf_mig_bar_write(uint16_t vfn, uint64_t addr, uint64_t val) "VF%u: BAR write addr=0x%"PRIx64" val=0x%"PRIx64
+igbvf_mig_set_state(uint16_t vfn, uint32_t old_state, uint32_t new_state) "VF%u: state %u -> %u"
+igbvf_mig_set_state_err(uint16_t vfn, uint32_t old_state, uint32_t new_state) "VF%u: invalid transition %u -> %u"
+igbvf_mig_save_state(uint16_t vfn, uint32_t size) "VF%u: saved %u bytes of device state"
+igbvf_mig_load_state(uint16_t vfn, uint32_t size) "VF%u: loaded %u bytes of device state"
+igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
 
 # spapr_llan.c
 spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32
-- 
2.55.0


