Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F421C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4V-0003bl-EQ; Mon, 27 Jul 2026 01:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4S-0003WV-UR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4O-0003k8-TM
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhtBfEWfcH0eCIwUfpQ2j9BpkmYL2KbQaPZ7lhlJ9Ok=;
 b=OITKzrO/lif84/WOvHu5/RhlaY6RQ3ayCXkchPUI+EkVlJ7SztWHm9BrUKMVpjdMPIBSnM
 fMJwTalkZWnPV2if7NuIT5+Rd/GfWxBi9gH5iR9QAT4fI+bSc+hPZnHjxm725vHSfjWGYW
 0tsR5xX8L0m1mh6JVXDMpSyu8Df6GZo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-OMazQusDOVaf88AaEFwGew-1; Mon,
 27 Jul 2026 01:40:04 -0400
X-MC-Unique: OMazQusDOVaf88AaEFwGew-1
X-Mimecast-MFC-AGG-ID: OMazQusDOVaf88AaEFwGew_1785130803
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 022541800605; Mon, 27 Jul 2026 05:40:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A2151956088; Mon, 27 Jul 2026 05:40:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 06/11] igb: Add dirty page tracking for IGBVF migration
Date: Mon, 27 Jul 2026 07:39:30 +0200
Message-ID: <20260727053935.1392269-7-clg@redhat.com>
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
References: <20260727053935.1392269-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend the migration BAR with dirty page tracking registers:

  0x020  DIRTY_PGSIZE        (RW)  - dirty tracking page granularity
  0x024  DIRTY_CTRL          (WO)  - 0=DISABLE, 1=ENABLE, 2=QUERY
  0x028  DIRTY_RANGE_IOVA_LO (WO)  - low 32 bits of tracked range start
  0x02C  DIRTY_RANGE_IOVA_HI (WO)  - high 32 bits of tracked range start
  0x030  DIRTY_RANGE_SIZE    (WO)  - tracked range size in bytes
  0x034  DIRTY_BUF_ADDR_LO   (WO)  - low 32 bits of shared buffer address
  0x038  DIRTY_BUF_ADDR_HI   (WO)  - high 32 bits of shared buffer address
  0x03C  DIRTY_STATUS        (RO)  - result of last DIRTY_CTRL

The CAPS register advertises the maximum number of ranges and
supported page sizes. The driver enables tracking on IOVA ranges
via DIRTY_CTRL and queries dirty bitmaps through a shared buffer.
As for state transfers, dirty buffer DMA is performed through the
PF device (pcie_sriov_get_pf).

Each tracked range maintains its own bitmap scoped to its boundaries.
DMA paths (TX/RX data, descriptor writeback) are instrumented to
record the touched pages. This enables the PRE_COPY state where the
driver iterates on dirty pages while the VM continues to run.

Assisted-by: Claude
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/devices/igb-migration.rst |  73 +++++
 hw/net/igb_core.h                     |   2 +
 hw/net/igb_migration.h                |  82 ++++++
 hw/net/igb_core.c                     |  48 ++--
 hw/net/igb_migration.c                | 367 +++++++++++++++++++++++++-
 hw/net/igbvf.c                        |   4 +
 hw/net/trace-events                   |   7 +
 7 files changed, 562 insertions(+), 21 deletions(-)

diff --git a/docs/system/devices/igb-migration.rst b/docs/system/devices/igb-migration.rst
index 04c44ef072af..4a3a93f01dfc 100644
--- a/docs/system/devices/igb-migration.rst
+++ b/docs/system/devices/igb-migration.rst
@@ -37,6 +37,14 @@ the following register layout::
   0x014   DATA_XFER           WO      Trigger DMA save or DMA load
   0x018   DATA_BUF_ADDR_LO    WO      Low 32 bits of state DMA buffer address
   0x01C   DATA_BUF_ADDR_HI    WO      High 32 bits of state DMA buffer address
+  0x020   DIRTY_PGSIZE        RW      Dirty tracking page granularity
+  0x024   DIRTY_CTRL          WO      0=DISABLE, 1=ENABLE, 2=QUERY
+  0x028   DIRTY_RANGE_IOVA_LO WO      Low 32 bits of tracked range start
+  0x02C   DIRTY_RANGE_IOVA_HI WO      High 32 bits of tracked range start
+  0x030   DIRTY_RANGE_SIZE    WO      Tracked range size in bytes
+  0x034   DIRTY_BUF_ADDR_LO   WO      Low 32 bits of shared buffer address
+  0x038   DIRTY_BUF_ADDR_HI   WO      High 32 bits of shared buffer address
+  0x03C   DIRTY_STATUS        RO      Result of last DIRTY_CTRL (0=OK, 1-5=error)
 
 State transitions follow the VFIO migration state machine: the driver
 writes to ``DEVICE_STATE`` to move between states and reads ``STATUS``
@@ -61,3 +69,68 @@ code identifying the failure::
   4  BAD_VFN         VF number mismatch (source != destination)
   5  DMA_FAILED      DMA transfer to/from state buffer failed
   6  NO_BUFFER       DATA_XFER without buffer address set
+
+Dirty page tracking
+~~~~~~~~~~~~~~~~~~~
+
+The migration interface supports per-VF dirty page tracking, advertised
+by the ``F_DIRTY`` flag in ``CAPS``. This allows the variant driver to
+enter ``PRE_COPY`` state (``DEVICE_STATE`` = 5) while the VM continues
+to run, iterating on dirty pages to reduce the final stop-and-copy
+window.
+
+The device maintains one dirty tracking engine per range, each with its
+own bitmap scoped to the range boundaries. The ``CAPS`` register
+advertises the maximum number of ranges (``max_ranges`` in bits [11:8])
+and supported page sizes (bits [31:12]).
+
+Dirty tracking is controlled through the ``DIRTY_CTRL`` register:
+
+- **ENABLE** (1): the driver programs a tracked range via
+  ``DIRTY_RANGE_IOVA_LO/HI`` + ``DIRTY_RANGE_SIZE`` then writes
+  ``DIRTY_CTRL=ENABLE``. The device allocates a fixed-size bitmap for
+  the range and begins recording pages touched by DMA (TX data, RX
+  data, descriptor writeback). The page granularity is set by
+  ``DIRTY_PGSIZE`` (default 4096). After each ENABLE the driver reads
+  ``DIRTY_STATUS`` to check for errors.
+- **DISABLE** (0): tears down all ranges and stops tracking.
+- **QUERY** (2): the driver writes (IOVA, size, page_size) into a
+  shared buffer registered via ``DIRTY_BUF_ADDR_LO/HI`` (PF DMA
+  address, as for state transfers), then writes
+  ``DIRTY_CTRL=QUERY``. The device finds the matching range, copies
+  the dirty bitmap into the shared buffer, clears the tracked bits,
+  and sets the buffer's completion status.
+
+``DIRTY_STATUS`` values after each ``DIRTY_CTRL`` write::
+
+  0  OK               Success
+  1  TOO_MANY_RANGES  Exceeds max_ranges from CAPS
+  2  BAD_RANGE        Invalid range (zero size)
+  3  BAD_PGSIZE       Invalid or misaligned page size
+  4  NOT_ENABLED      Query without prior enable
+  5  NO_BUFFER        Query without shared buffer
+
+Dirty query shared buffer
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The shared buffer used for dirty queries is registered via
+``DIRTY_BUF_ADDR_LO/HI`` (PF DMA address). It is cache-line aligned
+(64 bytes) to separate driver-written request fields from
+device-written completion fields::
+
+  Offset  Field              Written by  Description
+  0x00    iova               driver      Query range start
+  0x08    size               driver      Query range size
+  0x10    page_size          driver      Page granularity
+  0x14    flags              driver      Reserved (must be 0)
+  0x18    reserved[10]       -           Pad to 64-byte cache line
+  0x40    status             device      0 = pending, 1 = complete
+  0x44    bitmap_size        device      Bytes written to bitmap
+  0x48    dirty_page_count   device      Number of set bits in bitmap
+  0x4C    reserved[12]       -           Pad to 64-byte cache line
+  0x80    bitmap[]           device      Dirty page bitmap
+
+The driver fills the request fields, issues ``DIRTY_CTRL=QUERY``, and
+polls ``status`` for completion. The device reads the request, writes
+the dirty bitmap and completion fields via DMA, then sets
+``status = 1``.
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 150567eb346d..50cee2c7683c 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -83,6 +83,8 @@ struct IGBCore {
         struct NetTxPkt *tx_pkt;
     } tx[IGB_NUM_QUEUES];
 
+    IGBVfDirtyState vf_dirty[IGB_MAX_VF_FUNCTIONS];
+
     struct NetRxPkt *rx_pkt;
 
     bool has_vnet;
diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index 739a189810b0..a2e7b363cb04 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -27,6 +27,12 @@
 #define IGB_MIG_CAP_F_STATE  (1u << 0)   /* device state serialization */
 #define IGB_MIG_CAP_F_DIRTY  (1u << 1)   /* dirty page tracking */
 
+/* MIG_CAPS register layout (read-only, offset 0x008) */
+#define IGB_MIG_CAPS_MAX_RANGES_SHIFT  8
+#define IGB_MIG_CAPS_MAX_RANGES_MASK   (0xfu << 8)   /* bits [11:8] */
+#define IGB_MIG_CAPS_MAX_RANGES        4
+#define IGB_MIG_CAPS_PGSIZES_MASK      0xfffff000u    /* bits [31:12] */
+
 #define IGB_MIG_CAP_SIZE     16
 #define IGB_MIG_CAP_OFF_MAGIC  4    /* offset within cap for magic field */
 #define IGB_MIG_CAP_OFF_BARID  8    /* offset within cap for BAR id */
@@ -49,6 +55,14 @@
 #define IGB_MIG_DATA_XFER           0x014
 #define IGB_MIG_DATA_BUF_ADDR_LO    0x018
 #define IGB_MIG_DATA_BUF_ADDR_HI    0x01C
+#define IGB_MIG_DIRTY_PGSIZE        0x020
+#define IGB_MIG_DIRTY_CTRL          0x024
+#define IGB_MIG_DIRTY_RANGE_IOVA_LO 0x028
+#define IGB_MIG_DIRTY_RANGE_IOVA_HI 0x02C
+#define IGB_MIG_DIRTY_RANGE_SIZE    0x030
+#define IGB_MIG_DIRTY_BUF_ADDR_LO   0x034
+#define IGB_MIG_DIRTY_BUF_ADDR_HI   0x038
+#define IGB_MIG_DIRTY_STATUS        0x03C
 
 /* DEVICE_STATE values - mirrors VFIO migration states */
 #define IGB_MIG_STATE_ERROR         0
@@ -75,6 +89,50 @@
 #define IGB_MIG_ERR_DMA_FAILED      5
 #define IGB_MIG_ERR_NO_BUFFER       6
 
+/*
+ * DIRTY_CTRL register values. Write one of these to control
+ * the dirty page tracking state machine.
+ */
+#define IGB_MIG_DIRTY_CTRL_DISABLE   0
+#define IGB_MIG_DIRTY_CTRL_ENABLE    1
+#define IGB_MIG_DIRTY_CTRL_QUERY     2  /* query-and-clear */
+
+/* DIRTY_STATUS register values (read-only, cleared on next DIRTY_CTRL write) */
+#define IGB_MIG_DIRTY_STATUS_OK              0
+#define IGB_MIG_DIRTY_STATUS_TOO_MANY_RANGES 1
+#define IGB_MIG_DIRTY_STATUS_BAD_RANGE       2
+#define IGB_MIG_DIRTY_STATUS_BAD_PGSIZE      3
+#define IGB_MIG_DIRTY_STATUS_NOT_ENABLED     4
+#define IGB_MIG_DIRTY_STATUS_NO_BUFFER       5
+
+#define IGB_MIG_DIRTY_DEFAULT_PGSIZE  4096
+
+/*
+ * Dirty query shared buffer layout - DMA between driver and device.
+ * The driver writes request fields, kicks DIRTY_CTRL=QUERY, and the
+ * device reads the request, fills bitmap + completion via DMA. Each
+ * section is cache-line aligned (64 bytes).
+ */
+struct igb_mig_dirty_query {
+    /* Cache line 0: request (written by driver) */
+    uint64_t iova;
+    uint64_t size;
+    uint32_t page_size;
+    uint32_t flags;
+    uint32_t reserved0[10];
+
+    /* Cache line 1: completion (written by device) */
+    uint32_t status;
+    uint32_t bitmap_size;
+    uint32_t dirty_page_count;
+    uint32_t reserved1[12];
+
+    /* Cache line 2+: bitmap (written by device) */
+    uint8_t bitmap[];
+};
+
+#define IGB_MIG_DIRTY_STATUS_COMPLETE  1
+
 typedef struct IgbVfMigState {
     bool migration_cap;
     MemoryRegion mig_bar;
@@ -84,6 +142,12 @@ typedef struct IgbVfMigState {
     uint8_t mig_data[IGB_VF_STATE_MAX_SIZE];
     uint32_t mig_data_size;
     uint64_t mig_data_buf_addr;
+
+    uint32_t mig_dirty_pgsize;
+    uint64_t mig_dirty_range_iova;
+    uint32_t mig_dirty_range_size;
+    uint64_t mig_dirty_buf_addr;
+    uint32_t mig_dirty_status;
 } IgbVfMigState;
 
 typedef struct IgbVfState  IgbVfState;
@@ -92,4 +156,22 @@ bool igbvf_add_migration_cap(PCIDevice *dev, Error **errp);
 void igbvf_mig_bar_init(IgbVfState *s);
 void igbvf_mig_state_reset(IgbVfState *s);
 
+typedef struct IGBVfDirtyRange {
+    uint64_t iova;
+    uint64_t size;
+    uint64_t page_size;
+    unsigned long *bitmap;
+    uint64_t nbits;
+} IGBVfDirtyRange;
+
+typedef struct IGBVfDirtyState {
+    uint32_t num_ranges;
+    IGBVfDirtyRange ranges[IGB_MIG_CAPS_MAX_RANGES];
+} IGBVfDirtyState;
+
+typedef struct IGBCore IGBCore;
+void igb_core_dirty_track_dma(IGBCore *core, int vfn,
+                              dma_addr_t addr, dma_addr_t len);
+void igb_core_vf_dirty_disable(IgbVfState *s);
+
 #endif
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 2565dd7f96d3..03c349575c0a 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -824,6 +824,14 @@ igb_rx_ring_init(IGBCore *core, E1000E_RxRing *rxr, int idx)
     rxr->i      = &i[idx];
 }
 
+static inline void
+igb_pci_dma_write(IGBCore *core, PCIDevice *dev, int vfn,
+                  dma_addr_t addr, const void *buf, dma_addr_t len)
+{
+    pci_dma_write(dev, addr, buf, len);
+    igb_core_dirty_track_dma(core, vfn, addr, len);
+}
+
 static uint32_t
 igb_txdesc_writeback(IGBCore *core, dma_addr_t base,
                      union e1000_adv_tx_desc *tx_desc,
@@ -847,13 +855,15 @@ igb_txdesc_writeback(IGBCore *core, dma_addr_t base,
 
     if (tdwba & 1) {
         uint32_t buffer = cpu_to_le32(core->mac[txi->dh]);
-        pci_dma_write(d, tdwba & ~3, &buffer, sizeof(buffer));
+        igb_pci_dma_write(core, d, txi->idx % IGB_NUM_VM_POOLS,
+                          tdwba & ~3, &buffer, sizeof(buffer));
     } else {
         uint32_t status = le32_to_cpu(tx_desc->wb.status) | E1000_TXD_STAT_DD;
 
         tx_desc->wb.status = cpu_to_le32(status);
-        pci_dma_write(d, base + offsetof(union e1000_adv_tx_desc, wb),
-            &tx_desc->wb, sizeof(tx_desc->wb));
+        igb_pci_dma_write(core, d, txi->idx % IGB_NUM_VM_POOLS,
+                          base + offsetof(union e1000_adv_tx_desc, wb),
+                          &tx_desc->wb, sizeof(tx_desc->wb));
     }
 
     return igb_tx_wb_eic(core, txi->idx);
@@ -1264,6 +1274,7 @@ typedef struct IGBPacketRxDMAState {
     size_t iov_ofs;
     bool do_ps;
     bool is_first;
+    int vfn;
     IGBBAState bastate;
     hwaddr ba[IGB_MAX_PS_BUFFERS];
     IGBSplitDescriptorData ps_desc_data;
@@ -1590,7 +1601,8 @@ igb_write_rx_descr(IGBCore *core,
 
 static inline void
 igb_pci_dma_write_rx_desc(IGBCore *core, PCIDevice *dev, dma_addr_t addr,
-                          union e1000_rx_desc_union *desc, dma_addr_t len)
+                          union e1000_rx_desc_union *desc, dma_addr_t len,
+                          int vfn)
 {
     if (igb_rx_use_legacy_descriptor(core)) {
         struct e1000_rx_desc *d = &desc->legacy;
@@ -1598,11 +1610,12 @@ igb_pci_dma_write_rx_desc(IGBCore *core, PCIDevice *dev, dma_addr_t addr,
         uint8_t status = d->status;
 
         d->status &= ~E1000_RXD_STAT_DD;
-        pci_dma_write(dev, addr, desc, len);
+        igb_pci_dma_write(core, dev, vfn, addr, desc, len);
 
         if (status & E1000_RXD_STAT_DD) {
             d->status = status;
-            pci_dma_write(dev, addr + offset, &status, sizeof(status));
+            igb_pci_dma_write(core, dev, vfn,
+                              addr + offset, &status, sizeof(status));
         }
     } else {
         union e1000_adv_rx_desc *d = &desc->adv;
@@ -1611,11 +1624,12 @@ igb_pci_dma_write_rx_desc(IGBCore *core, PCIDevice *dev, dma_addr_t addr,
         uint32_t status = d->wb.upper.status_error;
 
         d->wb.upper.status_error &= ~E1000_RXD_STAT_DD;
-        pci_dma_write(dev, addr, desc, len);
+        igb_pci_dma_write(core, dev, vfn, addr, desc, len);
 
         if (status & E1000_RXD_STAT_DD) {
             d->wb.upper.status_error = status;
-            pci_dma_write(dev, addr + offset, &status, sizeof(status));
+            igb_pci_dma_write(core, dev, vfn,
+                              addr + offset, &status, sizeof(status));
         }
     }
 }
@@ -1737,9 +1751,9 @@ igb_write_hdr_frag_to_rx_buffers(IGBCore *core,
 {
     assert(data_len <= pdma_st->rx_desc_header_buf_size -
                        pdma_st->bastate.written[0]);
-    pci_dma_write(d,
-                  pdma_st->ba[0] + pdma_st->bastate.written[0],
-                  data, data_len);
+    igb_pci_dma_write(core, d, pdma_st->vfn,
+                      pdma_st->ba[0] + pdma_st->bastate.written[0],
+                      data, data_len);
     pdma_st->bastate.written[0] += data_len;
     pdma_st->bastate.cur_idx = 1;
 }
@@ -1804,10 +1818,10 @@ igb_write_payload_frag_to_rx_buffers(IGBCore *core,
             data,
             bytes_to_write);
 
-        pci_dma_write(d,
-                      pdma_st->ba[pdma_st->bastate.cur_idx] +
-                      pdma_st->bastate.written[pdma_st->bastate.cur_idx],
-                      data, bytes_to_write);
+        igb_pci_dma_write(core, d, pdma_st->vfn,
+                          pdma_st->ba[pdma_st->bastate.cur_idx] +
+                          pdma_st->bastate.written[pdma_st->bastate.cur_idx],
+                          data, bytes_to_write);
 
         pdma_st->bastate.written[pdma_st->bastate.cur_idx] += bytes_to_write;
         data += bytes_to_write;
@@ -1908,6 +1922,7 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
 
     rxi = rxr->i;
     rx_desc_len = core->rx_desc_len;
+    pdma_st.vfn = rxi->idx % IGB_NUM_VM_POOLS;
     pdma_st.rx_desc_packet_buf_size = igb_rxbufsize(core, rxi);
     pdma_st.rx_desc_header_buf_size = igb_rxhdrbufsize(core, rxi);
     pdma_st.iov = net_rx_pkt_get_iovec(pkt);
@@ -1944,7 +1959,8 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
                            etqf, ts,
                            &pdma_st,
                            rxi);
-        igb_pci_dma_write_rx_desc(core, d, base, &desc, rx_desc_len);
+        igb_pci_dma_write_rx_desc(core, d, base, &desc, rx_desc_len,
+                                  rxi->idx % IGB_NUM_VM_POOLS);
         igb_ring_advance(core, rxi, rx_desc_len / E1000_MIN_RX_DESC_LEN);
     } while (pdma_st.desc_offset < pdma_st.total_size);
 
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 4f123df6795d..9a9ce902bb4a 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -8,6 +8,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/units.h"
+#include "qemu/bitmap.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie.h"
 #include "net/eth.h"
@@ -69,7 +71,7 @@ bool igbvf_add_migration_cap(PCIDevice *dev, Error **errp)
     pci_set_long(dev->config + offset + IGB_MIG_CAP_OFF_BARID,
                  IGB_MIG_BAR_IDX);
     pci_set_long(dev->config + offset + IGB_MIG_CAP_OFF_FLAGS,
-                 IGB_MIG_CAP_F_STATE);
+                 IGB_MIG_CAP_F_STATE | IGB_MIG_CAP_F_DIRTY);
 
     trace_igbvf_mig_cap_add(pcie_sriov_vf_number(dev), offset);
     return true;
@@ -399,6 +401,161 @@ static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
     return 0;
 }
 
+/*
+ * =====================================================================
+ * Per-VF dirty page tracking
+ * =====================================================================
+ *
+ * All VF DMA writes in igb_core.c go through igb_pci_dma_write(),
+ * which calls igb_core_dirty_track_dma() to mark the target page in a
+ * per-range bitmap before performing the actual DMA.
+ *
+ * The IGBCore::vf_dirty[] bitmaps live in IGBCore so they are easily
+ * accessible from the core TX and RX paths without reaching back into
+ * VF state.
+ */
+
+void igb_core_dirty_track_dma(IGBCore *core, int vfn,
+                              dma_addr_t addr, dma_addr_t len)
+{
+    IGBVfDirtyState *ds = &core->vf_dirty[vfn];
+    bool matched = false;
+    uint32_t i;
+
+    if (!ds->num_ranges) {
+        return;
+    }
+
+    trace_igb_core_dirty_track_dma(vfn, addr, len);
+
+    for (i = 0; i < ds->num_ranges; i++) {
+        IGBVfDirtyRange *r = &ds->ranges[i];
+        uint64_t r_end = r->iova + r->size;
+        uint64_t dma_end = addr + len;
+        uint64_t start, end, start_page, end_page, page;
+
+        if (addr >= r_end || dma_end <= r->iova) {
+            continue;
+        }
+
+        matched = true;
+        start = MAX(addr, r->iova);
+        end = MIN(dma_end, r_end);
+
+        start_page = (start - r->iova) / r->page_size;
+        end_page = (end - 1 - r->iova) / r->page_size;
+
+        for (page = start_page; page <= end_page; page++) {
+            if (page < r->nbits) {
+                set_bit(page, r->bitmap);
+            }
+        }
+    }
+
+    if (!matched) {
+        trace_igb_core_dirty_track_dma_drop(vfn, addr, len);
+    }
+}
+
+static IGBVfDirtyState *igb_core_vf_dirty_state(IgbVfState *s)
+{
+    IGBCore *core = igbvf_get_core(s);
+    return &core->vf_dirty[s->vfn];
+}
+
+#define IGB_MIG_DIRTY_MAX_PAGES      ((256 * GiB) / (4 * KiB))
+
+static uint32_t igb_core_vf_dirty_enable(IgbVfState *s, uint64_t pgsize,
+                                  uint64_t range_iova, uint64_t range_size)
+{
+    IGBVfDirtyState *ds = igb_core_vf_dirty_state(s);
+    IGBVfDirtyRange *r;
+
+    if (ds->num_ranges >= IGB_MIG_CAPS_MAX_RANGES) {
+        return IGB_MIG_DIRTY_STATUS_TOO_MANY_RANGES;
+    }
+
+    if (!range_size) {
+        return IGB_MIG_DIRTY_STATUS_BAD_RANGE;
+    }
+
+    if (!pgsize || (range_iova % pgsize) || (range_size % pgsize)) {
+        return IGB_MIG_DIRTY_STATUS_BAD_PGSIZE;
+    }
+
+    if (range_size / pgsize > IGB_MIG_DIRTY_MAX_PAGES) {
+        return IGB_MIG_DIRTY_STATUS_BAD_RANGE;
+    }
+
+    r = &ds->ranges[ds->num_ranges];
+    r->iova = range_iova;
+    r->size = range_size;
+    r->page_size = pgsize;
+    r->nbits = range_size / pgsize;
+    r->bitmap = bitmap_new(r->nbits);
+    ds->num_ranges++;
+    return IGB_MIG_DIRTY_STATUS_OK;
+}
+
+void igb_core_vf_dirty_disable(IgbVfState *s)
+{
+    IGBVfDirtyState *ds = igb_core_vf_dirty_state(s);
+    uint32_t i;
+
+    for (i = 0; i < ds->num_ranges; i++) {
+        IGBVfDirtyRange *r = &ds->ranges[i];
+
+        g_free(r->bitmap);
+        r->bitmap = NULL;
+        r->nbits = 0;
+    }
+    ds->num_ranges = 0;
+}
+
+static bool igb_core_vf_dirty_enabled(IgbVfState *s)
+{
+    IGBVfDirtyState *ds = igb_core_vf_dirty_state(s);
+    return !!ds->num_ranges;
+}
+
+static bool igb_core_vf_dirty_query(IgbVfState *s,
+                             void *buf, size_t buf_size, size_t *out_size,
+                             uint64_t range_iova, uint64_t range_size)
+{
+    IGBVfDirtyState *ds = igb_core_vf_dirty_state(s);
+    uint32_t i;
+
+    for (i = 0; i < ds->num_ranges; i++) {
+        IGBVfDirtyRange *r = &ds->ranges[i];
+        uint64_t start_page, range_pages, count;
+
+        if (range_iova < r->iova ||
+            range_iova + range_size > r->iova + r->size) {
+            continue;
+        }
+
+        start_page = (range_iova - r->iova) / r->page_size;
+        range_pages = (uint64_t)range_size / r->page_size;
+        count = MIN(range_pages, (uint64_t)buf_size * 8);
+
+        memset(buf, 0, buf_size);
+
+        if (start_page < r->nbits) {
+            uint64_t avail = r->nbits - start_page;
+            uint64_t n = MIN(count, avail);
+
+            bitmap_copy_with_src_offset(buf, r->bitmap, start_page, n);
+            bitmap_clear(r->bitmap, start_page, n);
+        }
+
+        *out_size = bitmap_empty(buf, count) ? 0 : DIV_ROUND_UP(count, 8);
+        return true;
+    }
+
+    *out_size = 0;
+    return false;
+}
+
 /* ================================================================
  * Migration BAR register read/write handlers
  * ================================================================ */
@@ -410,25 +567,53 @@ static bool igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
     int ret;
 
     switch (new_state) {
+    case IGB_MIG_STATE_PRE_COPY:
+        if (old != IGB_MIG_STATE_RUNNING) {
+            return false;
+        }
+        /*
+         * Take an initial snapshot so DATA_SIZE reflects the actual
+         * state size and DATA_AVAIL is set for the driver.
+         */
+        ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
+        if (ret < 0) {
+            ms->mig_error = -ret;
+            ms->mig_state = IGB_MIG_STATE_ERROR;
+            return false;
+        }
+        ms->mig_data_size = ret;
+        break;
+
     case IGB_MIG_STATE_STOP:
         if (old != IGB_MIG_STATE_RUNNING &&
             old != IGB_MIG_STATE_STOP_COPY &&
+            old != IGB_MIG_STATE_PRE_COPY &&
             old != IGB_MIG_STATE_RESUMING &&
             old != IGB_MIG_STATE_ERROR) {
             return false;
         }
         /* Restore DATA_SIZE to max, same as at reset */
         ms->mig_data_size = igb_core_vf_max_data_size(s);
+        if (old == IGB_MIG_STATE_PRE_COPY ||
+            old == IGB_MIG_STATE_STOP_COPY ||
+            old == IGB_MIG_STATE_ERROR) {
+            igb_core_vf_dirty_disable(s);
+        }
         break;
 
     case IGB_MIG_STATE_RUNNING:
-        if (old != IGB_MIG_STATE_STOP) {
+        if (old != IGB_MIG_STATE_STOP &&
+            old != IGB_MIG_STATE_PRE_COPY) {
             return false;
         }
+        if (old == IGB_MIG_STATE_PRE_COPY) {
+            igb_core_vf_dirty_disable(s);
+        }
         break;
 
     case IGB_MIG_STATE_STOP_COPY:
-        if (old != IGB_MIG_STATE_STOP) {
+        if (old != IGB_MIG_STATE_STOP &&
+            old != IGB_MIG_STATE_PRE_COPY) {
             return false;
         }
         ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
@@ -466,7 +651,8 @@ static uint32_t igbvf_mig_get_status(IgbVfState *s)
     if (ms->mig_state == IGB_MIG_STATE_ERROR) {
         status |= IGB_MIG_STATUS_ERR(ms->mig_error);
     }
-    if (ms->mig_state == IGB_MIG_STATE_STOP_COPY && ms->mig_data_size > 0) {
+    if ((ms->mig_state == IGB_MIG_STATE_STOP_COPY ||
+         ms->mig_state == IGB_MIG_STATE_PRE_COPY) && ms->mig_data_size > 0) {
         status |= IGB_MIG_STATUS_DATA_AVAIL;
     }
 
@@ -486,6 +672,30 @@ static void igbvf_mig_data_xfer(IgbVfState *s, uint32_t val)
     }
 
     switch (ms->mig_state) {
+    case IGB_MIG_STATE_PRE_COPY:
+        /*
+         * Re-snapshot device state so the driver can read a fresh
+         * copy on each pre-copy iteration.
+         */
+        ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
+        if (ret < 0) {
+            ms->mig_error = -ret;
+            ms->mig_state = IGB_MIG_STATE_ERROR;
+            return;
+        }
+        ms->mig_data_size = ret;
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
     case IGB_MIG_STATE_STOP_COPY:
         /* Save: DMA-write serialized state to driver buffer */
         r = pci_dma_write(pcie_sriov_get_pf(PCI_DEVICE(s)),
@@ -547,7 +757,9 @@ static uint64_t igbvf_mig_read(void *opaque, hwaddr addr, unsigned size)
         val = igbvf_mig_get_status(s);
         break;
     case IGB_MIG_CAPS:
-        val = IGB_MIG_CAP_F_STATE;
+        val = IGB_MIG_CAP_F_STATE | IGB_MIG_CAP_F_DIRTY |
+            (IGB_MIG_CAPS_MAX_RANGES << IGB_MIG_CAPS_MAX_RANGES_SHIFT) |
+            (1u << 12);  /* 4K page size supported */
         break;
     case IGB_MIG_VERSION:
         val = IGB_MIG_CAP_VERSION;
@@ -555,6 +767,19 @@ static uint64_t igbvf_mig_read(void *opaque, hwaddr addr, unsigned size)
     case IGB_MIG_DATA_SIZE:
         val = ms->mig_data_size;
         break;
+    case IGB_MIG_DIRTY_PGSIZE:
+        val = ms->mig_dirty_pgsize ? ms->mig_dirty_pgsize
+            : IGB_MIG_DIRTY_DEFAULT_PGSIZE;
+        break;
+    case IGB_MIG_DIRTY_BUF_ADDR_LO:
+        val = (uint32_t)ms->mig_dirty_buf_addr;
+        break;
+    case IGB_MIG_DIRTY_BUF_ADDR_HI:
+        val = (uint32_t)(ms->mig_dirty_buf_addr >> 32);
+        break;
+    case IGB_MIG_DIRTY_STATUS:
+        val = ms->mig_dirty_status;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "igbvf: VF%u bad migration BAR read at 0x%"
@@ -567,6 +792,106 @@ static uint64_t igbvf_mig_read(void *opaque, hwaddr addr, unsigned size)
     return val;
 }
 
+static uint32_t igbvf_mig_dirty_count(const void *bitmap, size_t size)
+{
+    const unsigned long *p = bitmap;
+    size_t n = size / sizeof(unsigned long);
+    uint32_t count = 0;
+
+    for (size_t i = 0; i < n; i++) {
+        count += ctpopl(p[i]);
+    }
+    return count;
+}
+
+static void igbvf_mig_dirty_query(IgbVfState *s, uint64_t pgsize)
+{
+    IgbVfMigState *ms = &s->mig;
+    PCIDevice *dev = pcie_sriov_get_pf(PCI_DEVICE(s));
+    uint64_t buf_addr = ms->mig_dirty_buf_addr;
+    uint64_t range_iova = 0, range_size = 0;
+    uint32_t bmp_bytes;
+    size_t out_size;
+    g_autofree void *bitmap = NULL;
+    bool valid;
+
+    ldq_le_pci_dma(dev,
+                   buf_addr + offsetof(struct igb_mig_dirty_query, iova),
+                   &range_iova, MEMTXATTRS_UNSPECIFIED);
+    ldq_le_pci_dma(dev,
+                   buf_addr + offsetof(struct igb_mig_dirty_query, size),
+                   &range_size, MEMTXATTRS_UNSPECIFIED);
+
+    bmp_bytes = DIV_ROUND_UP(range_size / pgsize, 8);
+    bitmap = g_malloc0(bmp_bytes);
+
+    valid = igb_core_vf_dirty_query(s, bitmap, bmp_bytes, &out_size,
+                                    range_iova, range_size);
+
+    if (valid && out_size) {
+        if (pci_dma_write(dev,
+                    buf_addr + offsetof(struct igb_mig_dirty_query, bitmap),
+                    bitmap, out_size)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "igbvf: VF%u dirty bitmap write failed at 0x%" PRIx64 "\n",
+                s->vfn, buf_addr);
+            valid = false;
+        }
+    }
+
+    uint32_t dirty_pages = valid ? igbvf_mig_dirty_count(bitmap, out_size) : 0;
+
+    stl_le_pci_dma(dev,
+                   buf_addr + offsetof(struct igb_mig_dirty_query, bitmap_size),
+                   valid ? out_size : 0, MEMTXATTRS_UNSPECIFIED);
+    stl_le_pci_dma(dev,
+                   buf_addr + offsetof(struct igb_mig_dirty_query, dirty_page_count),
+                   dirty_pages, MEMTXATTRS_UNSPECIFIED);
+    stl_le_pci_dma(dev,
+                   buf_addr + offsetof(struct igb_mig_dirty_query, status),
+                   valid ? IGB_MIG_DIRTY_STATUS_COMPLETE : 0,
+                   MEMTXATTRS_UNSPECIFIED);
+
+    trace_igbvf_mig_dirty_query(s->vfn, (uint64_t)out_size, dirty_pages);
+}
+
+static void igbvf_mig_dirty_ctrl(IgbVfState *s, uint32_t val)
+{
+    IgbVfMigState *ms = &s->mig;
+    uint64_t pgsize = ms->mig_dirty_pgsize
+        ? ms->mig_dirty_pgsize : IGB_MIG_DIRTY_DEFAULT_PGSIZE;
+
+    switch (val) {
+    case IGB_MIG_DIRTY_CTRL_ENABLE:
+        ms->mig_dirty_status = igb_core_vf_dirty_enable(s, pgsize,
+                                      ms->mig_dirty_range_iova,
+                                      ms->mig_dirty_range_size);
+        if (ms->mig_dirty_status) {
+            break;
+        }
+        trace_igbvf_mig_dirty_enable(s->vfn, pgsize,
+                                     ms->mig_dirty_range_size / pgsize);
+        break;
+    case IGB_MIG_DIRTY_CTRL_DISABLE:
+        igb_core_vf_dirty_disable(s);
+        ms->mig_dirty_status = IGB_MIG_DIRTY_STATUS_OK;
+        trace_igbvf_mig_dirty_disable(s->vfn);
+        break;
+    case IGB_MIG_DIRTY_CTRL_QUERY:
+        if (!igb_core_vf_dirty_enabled(s)) {
+            ms->mig_dirty_status = IGB_MIG_DIRTY_STATUS_NOT_ENABLED;
+            break;
+        }
+        if (!ms->mig_dirty_buf_addr) {
+            ms->mig_dirty_status = IGB_MIG_DIRTY_STATUS_NO_BUFFER;
+            break;
+        }
+        igbvf_mig_dirty_query(s, pgsize);
+        ms->mig_dirty_status = IGB_MIG_DIRTY_STATUS_OK;
+        break;
+    }
+}
+
 static void igbvf_mig_write(void *opaque, hwaddr addr, uint64_t val,
                              unsigned size)
 {
@@ -599,6 +924,31 @@ static void igbvf_mig_write(void *opaque, hwaddr addr, uint64_t val,
         ms->mig_data_buf_addr =
             deposit64(ms->mig_data_buf_addr, 32, 32, val);
         break;
+    case IGB_MIG_DIRTY_PGSIZE:
+        ms->mig_dirty_pgsize = (uint32_t)val;
+        break;
+    case IGB_MIG_DIRTY_CTRL:
+        igbvf_mig_dirty_ctrl(s, (uint32_t)val);
+        break;
+    case IGB_MIG_DIRTY_RANGE_IOVA_LO:
+        ms->mig_dirty_range_iova =
+            deposit64(ms->mig_dirty_range_iova, 0, 32, val);
+        break;
+    case IGB_MIG_DIRTY_RANGE_IOVA_HI:
+        ms->mig_dirty_range_iova =
+            deposit64(ms->mig_dirty_range_iova, 32, 32, val);
+        break;
+    case IGB_MIG_DIRTY_RANGE_SIZE:
+        ms->mig_dirty_range_size = (uint32_t)val;
+        break;
+    case IGB_MIG_DIRTY_BUF_ADDR_LO:
+        ms->mig_dirty_buf_addr =
+            deposit64(ms->mig_dirty_buf_addr, 0, 32, val);
+        break;
+    case IGB_MIG_DIRTY_BUF_ADDR_HI:
+        ms->mig_dirty_buf_addr =
+            deposit64(ms->mig_dirty_buf_addr, 32, 32, val);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "igbvf: VF%u bad migration BAR write at 0x%"
@@ -643,5 +993,12 @@ void igbvf_mig_state_reset(IgbVfState *s)
     ms->mig_data_size = igb_core_vf_max_data_size(s);
     ms->mig_data_buf_addr = 0;
     memset(ms->mig_data, 0, sizeof(ms->mig_data));
+
+    igb_core_vf_dirty_disable(s);
+    ms->mig_dirty_pgsize = 0;
+    ms->mig_dirty_range_iova = 0;
+    ms->mig_dirty_range_size = 0;
+    ms->mig_dirty_buf_addr = 0;
+    ms->mig_dirty_status = IGB_MIG_DIRTY_STATUS_OK;
     trace_igbvf_mig_reset(s->vfn);
 }
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index e9f9fc3369d8..398306d3bfc6 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -306,6 +306,10 @@ static void igbvf_pci_uninit(PCIDevice *dev)
 {
     IgbVfState *s = IGBVF(dev);
 
+    if (s->mig.migration_cap) {
+        igb_core_vf_dirty_disable(s);
+    }
+
     pcie_aer_exit(dev);
     pcie_cap_exit(dev);
     msix_unuse_all_vectors(dev);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 0b13a99b3f32..95fdea89d49c 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -303,6 +303,13 @@ igbvf_mig_set_state_err(uint16_t vfn, uint32_t old_state, uint32_t new_state) "V
 igbvf_mig_save_state(uint16_t vfn, uint32_t size) "VF%u: saved %u bytes of device state"
 igbvf_mig_load_state(uint16_t vfn, uint32_t size) "VF%u: loaded %u bytes of device state"
 igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
+igbvf_mig_dirty_enable(uint16_t vfn, uint64_t pgsize, uint64_t nbits) "VF%u: dirty tracking enabled pgsize=%"PRIu64" nbits=%"PRIu64
+igbvf_mig_dirty_disable(uint16_t vfn) "VF%u: dirty tracking disabled"
+igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages) "VF%u: dirty query returned %"PRIu64" bytes, %u dirty pages"
+
+# igb_core.c - VF migration diagnostics
+igb_core_dirty_track_dma(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA addr=0x%"PRIx64" len=%"PRIu64
+igb_core_dirty_track_dma_drop(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA dropped addr=0x%"PRIx64" len=%"PRIu64" no matching range"
 
 # spapr_llan.c
 spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32
-- 
2.55.0


