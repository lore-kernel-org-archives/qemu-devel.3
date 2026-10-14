Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA230CC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuey-0005wh-Ko; Wed, 14 Oct 2026 04:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueF-0005YO-NS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueD-0004Za-12
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nnv2Ido8yJh2Wdyw9LwIuuKdA7O+s2rbmSxYa/jZd1w=;
 b=ImgpWvEdL7m+7xpSegzVfEqiVL2L3EFYo500DJlg+iUyojQHEIMecx51gFMQK/tTzm+Bqb
 2m5F3mhgBF1ne0Vik3LhtWwsLRDwbbUvgnOJPlctnTjVZWbcWjMeA5AB+7l2CnXiVUtLWt
 Xa6ct8/30XFNw8EMrC1rOFXrORQyHkk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-lSZhv8gMM1Wu5lIxwKjIAQ-1; Wed,
 14 Oct 2026 08:47:37 +0000
X-MC-Unique: lSZhv8gMM1Wu5lIxwKjIAQ-1
X-Mimecast-MFC-AGG-ID: lSZhv8gMM1Wu5lIxwKjIAQ_1791967656
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39C2D180044D; Wed, 14 Oct 2026 08:47:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC2161800495; Wed, 14 Oct 2026 08:47:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 11/17] igb: Add dirty page tracking for IGBVF migration
Date: Wed, 14 Oct 2026 10:46:49 +0200
Message-ID: <20261014084655.127254-12-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Add per-VF dirty page tracking using bitmaps allocated per IOVA range.
The DMA data path is instrumented via igb_core_dirty_track_dma() calls
at all five DMA write sites: TX descriptor writeback (head pointer and
status), RX descriptor writeback, RX header fragment, and RX payload
fragment.

The migration DVSEC exposes DIRTY_ENABLE, DIRTY_DISABLE and DIRTY_QUERY
commands. Range parameters and query results are exchanged through the
shared DMA buffer.

Add the PRE_COPY device state to support pre-copy live migration with
concurrent dirty tracking. PRE_COPY transitions:
 - RUNNING -> PRE_COPY
 - PRE_COPY -> STOP, RUNNING, STOP_COPY

Dirty tracking is automatically disabled when leaving PRE_COPY or
STOP_COPY.

AI-used-for: code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |   4 +
 hw/net/igb_migration.h |  67 ++++++++-
 hw/net/igb_core.c      |  42 ++++--
 hw/net/igb_migration.c | 330 ++++++++++++++++++++++++++++++++++++++++-
 hw/net/trace-events    |  11 +-
 5 files changed, 432 insertions(+), 22 deletions(-)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index e066b9e029fd..5a15433da2c2 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -40,6 +40,8 @@
 #ifndef HW_NET_IGB_CORE_H
 #define HW_NET_IGB_CORE_H
 
+#include "igb_migration.h"
+
 #define E1000E_MAC_SIZE         (0x8000)
 #define IGB_EEPROM_SIZE         (1024)
 
@@ -99,6 +101,8 @@ struct IGBCore {
     void (*owner_start_recv)(PCIDevice *d);
 
     int64_t timadj;
+
+    IGBVfDirtyState vf_dirty[IGB_MAX_VF_FUNCTIONS];
 };
 
 void
diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index 676ec2d78301..4968798509aa 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -21,7 +21,8 @@
  *   +0x04  DVSEC header 1             (len | rev | vendor_id)
  *   +0x08  DVSEC header 2             (DVSEC ID)
  *   +0x0A  Reserved                   (padding for DWORD alignment)
- *   +0x0C  CAPS                       (RO: F_STATE[0])
+ *   +0x0C  CAPS                       (RO: F_STATE[0], F_DIRTY[1],
+ *                                      max_ranges[11:8], pgsize[16:12])
  *   +0x10  CTRL                       (WO: doorbell command)
  *   +0x14  STATUS                     (RO: state[7:0], error_code[15:8])
  *   +0x18  BUF_ADDR_LO                (RW: shared buffer GPA low)
@@ -44,6 +45,14 @@
 
 /* CAPS register layout */
 #define IGB_MIG_CAP_F_STATE             (1u << 0)
+#define IGB_MIG_CAP_F_DIRTY             (1u << 1)
+#define IGB_MIG_CAPS_MAX_RANGES_SHIFT   8
+#define IGB_MIG_CAPS_MAX_RANGES         4
+#define IGB_MIG_CAPS_PGSIZE_SHIFT       12
+#define IGB_MIG_CAPS_PGSIZE_4K          (1u << 12)
+#define IGB_MIG_CAPS_PGSIZE_64K         (1u << 16)
+#define IGB_MIG_CAPS_PGSIZE_MASK        (IGB_MIG_CAPS_PGSIZE_4K | \
+                                         IGB_MIG_CAPS_PGSIZE_64K)
 
 /* CTRL register: command in [7:0] */
 #define IGB_MIG_CTRL_CMD_MASK           0xFF
@@ -53,6 +62,9 @@
 #define IGB_MIG_CMD_SET_STATE           1
 #define IGB_MIG_CMD_SAVE                2
 #define IGB_MIG_CMD_LOAD                3
+#define IGB_MIG_CMD_DIRTY_ENABLE        4
+#define IGB_MIG_CMD_DIRTY_DISABLE       5
+#define IGB_MIG_CMD_DIRTY_QUERY         6
 
 /* STATUS register: state in [7:0], error code [15:8] */
 #define IGB_MIG_STATUS_STATE_MASK       0xFF
@@ -66,6 +78,7 @@
 #define IGB_MIG_STATE_RUNNING           2
 #define IGB_MIG_STATE_STOP_COPY         3
 #define IGB_MIG_STATE_RESUMING          4
+#define IGB_MIG_STATE_PRE_COPY          5
 
 /* Error codes */
 #define IGB_MIG_ERR_UNK_CMD             1
@@ -78,6 +91,10 @@
 #define IGB_MIG_ERR_BAD_VFN             8
 #define IGB_MIG_ERR_BAD_DATA            9
 #define IGB_MIG_ERR_UNSUPPORTED         10
+#define IGB_MIG_ERR_TOO_MANY_RANGES     11
+#define IGB_MIG_ERR_BAD_RANGE           12
+#define IGB_MIG_ERR_BAD_PGSIZE          13
+#define IGB_MIG_ERR_NOT_ENABLED         14
 
 /* Shared buffer constants */
 #define IGB_VF_STATE_MAX_SIZE           4096
@@ -89,6 +106,51 @@ typedef struct IgbVfMigState {
     uint64_t mig_data_buf_addr;
 } IgbVfMigState;
 
+#define IGB_MIG_DIRTY_DEFAULT_PGSIZE        4096
+
+typedef struct IGBVfDirtyRange {
+    uint64_t iova;
+    uint64_t size;
+    uint64_t page_size;
+    unsigned long *bitmap;
+    uint64_t nbits;
+} IGBVfDirtyRange;
+
+typedef struct IGBVfDirtyState {
+    IGBVfDirtyRange ranges[IGB_MIG_CAPS_MAX_RANGES];
+    uint32_t num_ranges;
+} IGBVfDirtyState;
+
+/*
+ * DMA buffer layouts for dirty tracking commands.
+ *
+ * DIRTY_ENABLE: driver writes igb_mig_dirty_enable_req to buffer
+ *               before cmd.
+ * DIRTY_QUERY: driver writes iova/size fields, device writes
+ *              response + bitmap.
+ */
+struct igb_mig_dirty_enable_req {
+    uint32_t len;
+    uint32_t flags;
+    uint64_t pgsize;
+    uint64_t range_iova;
+    uint64_t range_size;
+    uint32_t reserved[4];
+};
+
+struct igb_mig_dirty_query {
+    uint32_t len;
+    uint32_t flags;
+    uint64_t iova;
+    uint64_t size;
+    uint32_t bitmap_size;
+    uint32_t dirty_page_count;
+    uint64_t dma_writes;
+    uint32_t reserved[6];
+    uint8_t bitmap[];
+};
+
+typedef struct IGBCore IGBCore;
 typedef struct IgbVfState IgbVfState;
 
 bool igbvf_add_migration_dvsec(IgbVfState *s, Error **errp);
@@ -96,4 +158,7 @@ uint32_t igbvf_mig_config_read(IgbVfState *s, uint32_t addr, int size);
 bool igbvf_mig_config_write(IgbVfState *s, uint32_t addr, uint32_t val,
                             int size);
 
+void igb_core_dirty_track_dma(IGBCore *core, int vfn,
+                              dma_addr_t addr, dma_addr_t len);
+
 #endif
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index ef941ecb86b4..452bae06ee92 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -824,6 +824,16 @@ igb_rx_ring_init(IGBCore *core, E1000E_RxRing *rxr, int idx)
     rxr->i      = &i[idx];
 }
 
+static inline void
+igb_pci_dma_write(IGBCore *core, PCIDevice *dev,
+                  dma_addr_t addr, const void *buf, dma_addr_t len)
+{
+    pci_dma_write(dev, addr, buf, len);
+    if (pci_is_vf(dev)) {
+        igb_core_dirty_track_dma(core, pcie_sriov_vf_number(dev), addr, len);
+    }
+}
+
 static uint32_t
 igb_txdesc_writeback(IGBCore *core, dma_addr_t base,
                      union e1000_adv_tx_desc *tx_desc,
@@ -847,13 +857,15 @@ igb_txdesc_writeback(IGBCore *core, dma_addr_t base,
 
     if (tdwba & 1) {
         uint32_t buffer = cpu_to_le32(core->mac[txi->dh]);
-        pci_dma_write(d, tdwba & ~3, &buffer, sizeof(buffer));
+        igb_pci_dma_write(core, d,
+                          tdwba & ~3, &buffer, sizeof(buffer));
     } else {
         uint32_t status = le32_to_cpu(tx_desc->wb.status) | E1000_TXD_STAT_DD;
 
         tx_desc->wb.status = cpu_to_le32(status);
-        pci_dma_write(d, base + offsetof(union e1000_adv_tx_desc, wb),
-            &tx_desc->wb, sizeof(tx_desc->wb));
+        igb_pci_dma_write(core, d,
+                          base + offsetof(union e1000_adv_tx_desc, wb),
+                          &tx_desc->wb, sizeof(tx_desc->wb));
     }
 
     return igb_tx_wb_eic(core, txi->idx);
@@ -1598,11 +1610,12 @@ igb_pci_dma_write_rx_desc(IGBCore *core, PCIDevice *dev, dma_addr_t addr,
         uint8_t status = d->status;
 
         d->status &= ~E1000_RXD_STAT_DD;
-        pci_dma_write(dev, addr, desc, len);
+        igb_pci_dma_write(core, dev, addr, desc, len);
 
         if (status & E1000_RXD_STAT_DD) {
             d->status = status;
-            pci_dma_write(dev, addr + offset, &status, sizeof(status));
+            igb_pci_dma_write(core, dev,
+                              addr + offset, &status, sizeof(status));
         }
     } else {
         union e1000_adv_rx_desc *d = &desc->adv;
@@ -1611,11 +1624,12 @@ igb_pci_dma_write_rx_desc(IGBCore *core, PCIDevice *dev, dma_addr_t addr,
         uint32_t status = d->wb.upper.status_error;
 
         d->wb.upper.status_error &= ~E1000_RXD_STAT_DD;
-        pci_dma_write(dev, addr, desc, len);
+        igb_pci_dma_write(core, dev, addr, desc, len);
 
         if (status & E1000_RXD_STAT_DD) {
             d->wb.upper.status_error = status;
-            pci_dma_write(dev, addr + offset, &status, sizeof(status));
+            igb_pci_dma_write(core, dev,
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
+    igb_pci_dma_write(core, d,
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
+        igb_pci_dma_write(core, d,
+                          pdma_st->ba[pdma_st->bastate.cur_idx] +
+                          pdma_st->bastate.written[pdma_st->bastate.cur_idx],
+                          data, bytes_to_write);
 
         pdma_st->bastate.written[pdma_st->bastate.cur_idx] += bytes_to_write;
         data += bytes_to_write;
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 42d2587149ef..efa2f5a8d333 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -9,6 +9,8 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "qemu/bitmap.h"
+#include "qemu/units.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie.h"
 #include "net/eth.h"
@@ -801,6 +803,292 @@ static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
     return 0;
 }
 
+/*
+ * Per-VF dirty page tracking
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
+#define IGB_MIG_DIRTY_MAX_PAGES      ((256ULL * GiB) / (4 * KiB))
+
+static uint32_t igb_core_vf_dirty_enable(IgbVfState *s, uint64_t pgsize,
+                                         uint64_t range_iova,
+                                         uint64_t range_size)
+{
+    uint32_t caps = pci_get_long(PCI_DEVICE(s)->config +
+                                 IGB_MIG_DVSEC_OFFSET + IGB_MIG_CAPS);
+    IGBVfDirtyState *ds = igb_core_vf_dirty_state(s);
+    IGBVfDirtyRange *r;
+
+    if (ds->num_ranges >= IGB_MIG_CAPS_MAX_RANGES) {
+        return IGB_MIG_ERR_TOO_MANY_RANGES;
+    }
+
+    if (!range_size || range_iova + range_size < range_iova) {
+        return IGB_MIG_ERR_BAD_RANGE;
+    }
+
+    /* Validate page size against CAPS supported page size bitmask */
+    if (!is_power_of_2(pgsize) || !(pgsize & (caps & IGB_MIG_CAPS_PGSIZE_MASK))) {
+        return IGB_MIG_ERR_BAD_PGSIZE;
+    }
+
+    if ((range_iova % pgsize) || (range_size % pgsize)) {
+        return IGB_MIG_ERR_BAD_PGSIZE;
+    }
+
+    if (range_size / pgsize > IGB_MIG_DIRTY_MAX_PAGES) {
+        return IGB_MIG_ERR_BAD_RANGE;
+    }
+
+    for (int i = 0; i < ds->num_ranges; i++) {
+        if (ranges_overlap(range_iova, range_size,
+                           ds->ranges[i].iova, ds->ranges[i].size)) {
+            return IGB_MIG_ERR_BAD_RANGE;
+        }
+    }
+
+    r = &ds->ranges[ds->num_ranges];
+    r->iova = range_iova;
+    r->size = range_size;
+    r->page_size = pgsize;
+    r->nbits = range_size / pgsize;
+    r->bitmap = bitmap_new(r->nbits);
+    ds->num_ranges++;
+    return 0;
+}
+
+static void igb_core_vf_dirty_disable(IgbVfState *s)
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
+    trace_igbvf_mig_dirty_disable(s->vfn);
+}
+
+static bool igb_core_vf_dirty_enabled(IgbVfState *s)
+{
+    return igb_core_vf_dirty_state(s)->num_ranges > 0;
+}
+
+static void igb_core_vf_dirty_query(IGBVfDirtyRange *r,
+                                    uint64_t range_iova, uint64_t range_size,
+                                    void *buf, size_t buf_size,
+                                    size_t *out_size)
+{
+    uint64_t start_page = (range_iova - r->iova) / r->page_size;
+    uint64_t range_pages = range_size / r->page_size;
+    uint64_t count = MIN(range_pages, (uint64_t)buf_size * 8);
+
+    memset(buf, 0, buf_size);
+
+    if (start_page < r->nbits) {
+        uint64_t avail = r->nbits - start_page;
+        uint64_t n = MIN(count, avail);
+
+        bitmap_copy_with_src_offset(buf, r->bitmap, start_page, n);
+    }
+    *out_size = bitmap_empty(buf, count) ? 0 : DIV_ROUND_UP(count, 8);
+}
+
+static void igb_core_vf_dirty_query_commit(IGBVfDirtyRange *r,
+                                           uint64_t range_iova,
+                                           uint64_t range_size)
+{
+    uint64_t start_page = (range_iova - r->iova) / r->page_size;
+
+    if (start_page < r->nbits) {
+        uint64_t avail = r->nbits - start_page;
+        uint64_t range_pages = range_size / r->page_size;
+        uint64_t n = MIN(range_pages, avail);
+
+        bitmap_clear(r->bitmap, start_page, n);
+    }
+}
+
+static uint8_t igbvf_mig_cmd_dirty_enable(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+    struct igb_mig_dirty_enable_req req;
+    MemTxResult r;
+    uint32_t status;
+
+    if (!ms->mig_data_buf_addr) {
+        return IGB_MIG_ERR_NO_BUFFER;
+    }
+
+    r = address_space_read(&address_space_memory, ms->mig_data_buf_addr,
+                           MEMTXATTRS_UNSPECIFIED, &req, sizeof(req));
+    if (r != MEMTX_OK) {
+        return IGB_MIG_ERR_DMA_FAILED;
+    }
+
+    /* TODO: validate req.len and req.flags */
+
+    status = igb_core_vf_dirty_enable(s, le64_to_cpu(req.pgsize),
+                                      le64_to_cpu(req.range_iova),
+                                      le64_to_cpu(req.range_size));
+    if (status != 0) {
+        return status;
+    }
+    trace_igbvf_mig_dirty_enable(s->vfn, le64_to_cpu(req.pgsize),
+                                 le64_to_cpu(req.range_size) /
+                                 le64_to_cpu(req.pgsize));
+    return 0;
+}
+
+static IGBVfDirtyRange *igb_core_vf_dirty_range_valid(IGBVfDirtyState *ds,
+                                                      uint64_t range_iova,
+                                                      uint64_t range_size)
+{
+    if (!range_size) {
+        return NULL;
+    }
+
+    for (uint32_t i = 0; i < ds->num_ranges; i++) {
+        IGBVfDirtyRange *r = &ds->ranges[i];
+
+        if (range_iova >= r->iova &&
+            range_iova + range_size <= r->iova + r->size &&
+            QEMU_IS_ALIGNED(range_iova, r->page_size) &&
+            QEMU_IS_ALIGNED(range_size, r->page_size)) {
+            return r;
+        }
+    }
+    return NULL;
+}
+
+static uint8_t igbvf_mig_cmd_dirty_query(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+    IGBVfDirtyState *ds = &igbvf_get_core(s)->vf_dirty[s->vfn];
+    uint64_t buf_addr = ms->mig_data_buf_addr;
+    uint64_t range_iova = 0, range_size = 0;
+    IGBVfDirtyRange *range;
+    uint32_t bmp_bytes, dirty_pages;
+    uint32_t val32;
+    size_t out_size;
+    g_autofree void *bitmap = NULL;
+
+    if (!buf_addr) {
+        return IGB_MIG_ERR_NO_BUFFER;
+    }
+
+    if (!igb_core_vf_dirty_enabled(s)) {
+        return IGB_MIG_ERR_NOT_ENABLED;
+    }
+
+    address_space_read(&address_space_memory,
+                       buf_addr + offsetof(struct igb_mig_dirty_query, iova),
+                       MEMTXATTRS_UNSPECIFIED, &range_iova, sizeof(range_iova));
+    range_iova = le64_to_cpu(range_iova);
+    address_space_read(&address_space_memory,
+                       buf_addr + offsetof(struct igb_mig_dirty_query, size),
+                       MEMTXATTRS_UNSPECIFIED, &range_size, sizeof(range_size));
+    range_size = le64_to_cpu(range_size);
+
+    range = igb_core_vf_dirty_range_valid(ds, range_iova, range_size);
+    if (!range) {
+        return IGB_MIG_ERR_BAD_RANGE;
+    }
+
+    bmp_bytes = BITS_TO_LONGS(range_size / range->page_size) *
+        sizeof(unsigned long);
+    bitmap = g_malloc0(bmp_bytes);
+
+    igb_core_vf_dirty_query(range, range_iova, range_size,
+                            bitmap, bmp_bytes, &out_size);
+
+    if (out_size) {
+        if (address_space_write(&address_space_memory,
+                                buf_addr +
+                                offsetof(struct igb_mig_dirty_query, bitmap),
+                                MEMTXATTRS_UNSPECIFIED, bitmap, out_size)) {
+            return IGB_MIG_ERR_DMA_FAILED;
+        }
+    }
+
+    igb_core_vf_dirty_query_commit(range, range_iova, range_size);
+
+    dirty_pages = bitmap_count_one(bitmap, range_size / range->page_size);
+
+    val32 = cpu_to_le32(out_size);
+    address_space_write(&address_space_memory,
+                        buf_addr + offsetof(struct igb_mig_dirty_query,
+                                            bitmap_size),
+                        MEMTXATTRS_UNSPECIFIED, &val32, sizeof(val32));
+    val32 = cpu_to_le32(dirty_pages);
+    address_space_write(&address_space_memory,
+                        buf_addr + offsetof(struct igb_mig_dirty_query,
+                                            dirty_page_count),
+                        MEMTXATTRS_UNSPECIFIED, &val32, sizeof(val32));
+
+    trace_igbvf_mig_dirty_query(s->vfn, (uint64_t)out_size, dirty_pages);
+    return 0;
+}
+
 /*
  * Migration command handlers
  */
@@ -821,7 +1109,8 @@ static uint8_t igbvf_mig_cmd_save(IgbVfState *s)
     MemTxResult r;
     int ret;
 
-    if (ms->mig_state != IGB_MIG_STATE_STOP_COPY) {
+    if (ms->mig_state != IGB_MIG_STATE_STOP_COPY &&
+        ms->mig_state != IGB_MIG_STATE_PRE_COPY) {
         return IGB_MIG_ERR_BAD_STATE;
     }
 
@@ -890,22 +1179,33 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
     case IGB_MIG_STATE_STOP:
         if (old != IGB_MIG_STATE_RUNNING &&
             old != IGB_MIG_STATE_STOP_COPY &&
+            old != IGB_MIG_STATE_PRE_COPY &&
             old != IGB_MIG_STATE_RESUMING &&
             old != IGB_MIG_STATE_ERROR) {
             return IGB_MIG_ERR_BAD_STATE;
         }
+        if (old == IGB_MIG_STATE_PRE_COPY ||
+            old == IGB_MIG_STATE_STOP_COPY ||
+            old == IGB_MIG_STATE_ERROR) {
+            igb_core_vf_dirty_disable(s);
+        }
         /* Restore DATA_SIZE to default max */
         igbvf_mig_update_data_size(s, igb_core_vf_max_data_size(s));
         break;
 
     case IGB_MIG_STATE_RUNNING:
-        if (old != IGB_MIG_STATE_STOP) {
+        if (old != IGB_MIG_STATE_STOP &&
+            old != IGB_MIG_STATE_PRE_COPY) {
             return IGB_MIG_ERR_BAD_STATE;
         }
+        if (old == IGB_MIG_STATE_PRE_COPY) {
+            igb_core_vf_dirty_disable(s);
+        }
         break;
 
     case IGB_MIG_STATE_STOP_COPY:
-        if (old != IGB_MIG_STATE_STOP) {
+        if (old != IGB_MIG_STATE_STOP &&
+            old != IGB_MIG_STATE_PRE_COPY) {
             return IGB_MIG_ERR_BAD_STATE;
         }
         ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
@@ -923,6 +1223,12 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
         igbvf_mig_update_data_size(s, 0);
         break;
 
+    case IGB_MIG_STATE_PRE_COPY:
+        if (old != IGB_MIG_STATE_RUNNING) {
+            return IGB_MIG_ERR_BAD_STATE;
+        }
+        break;
+
     default:
         return IGB_MIG_ERR_BAD_STATE;
     }
@@ -971,6 +1277,18 @@ static void igbvf_mig_cmd_ctrl(IgbVfState *s, uint32_t val)
         err = igbvf_mig_cmd_load(s, arg);
         break;
 
+    case IGB_MIG_CMD_DIRTY_ENABLE:
+        err = igbvf_mig_cmd_dirty_enable(s);
+        break;
+
+    case IGB_MIG_CMD_DIRTY_DISABLE:
+        igb_core_vf_dirty_disable(s);
+        break;
+
+    case IGB_MIG_CMD_DIRTY_QUERY:
+        err = igbvf_mig_cmd_dirty_query(s);
+        break;
+
     default:
         err = IGB_MIG_ERR_UNK_CMD;
         break;
@@ -1009,8 +1327,10 @@ bool igbvf_add_migration_dvsec(IgbVfState *s, Error **errp)
     /* DVSEC header 2: DVSEC ID */
     pci_set_word(dev->config + offset + 0x8, IGB_MIG_DVSEC_ID);
 
-    /* CAPS: features (state migration only) */
-    caps = IGB_MIG_CAP_F_STATE;
+    /* CAPS: features | max_ranges | supported page sizes (4K) */
+    caps = IGB_MIG_CAP_F_STATE | IGB_MIG_CAP_F_DIRTY |
+           (IGB_MIG_CAPS_MAX_RANGES << IGB_MIG_CAPS_MAX_RANGES_SHIFT) |
+           IGB_MIG_CAPS_PGSIZE_4K;
     pci_set_long(dev->config + offset + IGB_MIG_CAPS, caps);
 
     /*
diff --git a/hw/net/trace-events b/hw/net/trace-events
index a8cc72b69d0f..a171888db380 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -299,10 +299,17 @@ igbvf_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
 igbvf_mig_cmd(uint16_t vfn, uint32_t cmd, uint32_t arg, uint32_t state) "VF%u: cmd %u arg %u (mig_state=%u)"
 igbvf_mig_status(uint16_t vfn, uint32_t status) "VF%u: status 0x%x"
 igbvf_mig_set_state(uint16_t vfn, uint32_t old_state, uint32_t new_state) "VF%u: state %u -> %u"
-igbvf_mig_save_state(uint16_t vfn, uint32_t size) "VF%u: saved %u bytes of device state"
-igbvf_mig_load_state(uint16_t vfn, uint32_t size) "VF%u: loaded %u bytes of device state"
+igbvf_mig_save_state(uint16_t vfn, int size, bool vfre, bool vfte, uint32_t reg_vfre) "VF%u: saved %d bytes vfre=%d vfte=%d VFRE=0x%x"
+igbvf_mig_load_state(uint16_t vfn, uint32_t size, bool vfre, bool vfte) "VF%u: loaded %u bytes vfre=%d vfte=%d"
 igbvf_mig_save_hash_tables(uint16_t vfn, const char *name, int index, uint32_t value) "VF%u: %s[%d]=0x%x"
 igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
+igbvf_mig_dirty_enable(uint16_t vfn, uint64_t pgsize, uint64_t nbits) "VF%u: dirty tracking enabled pgsize=%"PRIu64" nbits=%"PRIu64
+igbvf_mig_dirty_disable(uint16_t vfn) "VF%u: dirty tracking disabled"
+igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages) "VF%u: dirty query returned %"PRIu64" bytes, %u dirty pages"
+igb_core_dirty_track_dma(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA addr=0x%"PRIx64" len=%"PRIu64
+igb_core_dirty_track_dma_drop(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA dropped addr=0x%"PRIx64" len=%"PRIu64" no matching range"
+igbvf_mig_quiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: quiesce VFRE=0x%x VFTE=0x%x"
+igbvf_mig_unquiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: unquiesce VFRE=0x%x VFTE=0x%x"
 
 # spapr_llan.c
 spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32
-- 
2.56.0


