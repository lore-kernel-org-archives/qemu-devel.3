Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA5AC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4u-0004F0-Hb; Mon, 27 Jul 2026 01:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4g-0003uM-Ul
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4e-0003lo-RJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHRXSzNCTNiD560sOJzof2nGp13HSfDabGJCc6oJh3o=;
 b=KxtjYB+iSI/PTJ4V9nVT9HIiaiI/aqHvOVJsBWJH0Etb1HnNCf3wreEwJtN8EB6Gtfxyq6
 MfjS5Twf28qgYraNh2nKGFtLLqZiiTBejMagOW1Ii7Rzy/wObT0pBXbANfPcNSaI883NfC
 ItiMpq3pOK5tdY9Gv9IVff19R8U1vIs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-DFZmoylRNZOUohgeFLEL4A-1; Mon,
 27 Jul 2026 01:40:20 -0400
X-MC-Unique: DFZmoylRNZOUohgeFLEL4A-1
X-Mimecast-MFC-AGG-ID: DFZmoylRNZOUohgeFLEL4A_1785130819
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1A551944D2A; Mon, 27 Jul 2026 05:40:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 240991956088; Mon, 27 Jul 2026 05:40:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 11/11] igb: Add migration statistics registers to VF
 migration BAR
Date: Mon, 27 Jul 2026 07:39:35 +0200
Message-ID: <20260727053935.1392269-12-clg@redhat.com>
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
References: <20260727053935.1392269-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add read-only statistics registers to the migration BAR at 0x100-0x11C
for monitoring dirty page tracking and DMA activity per VF.

The dma_writes counter is also reported in the dirty query buffer so
the driver gets it alongside the bitmap without an extra MMIO read.

Counters are reset on first DIRTY_CTRL=ENABLE or device reset, so the
driver can read final values after DIRTY_CTRL=DISABLE.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/devices/igb-migration.rst | 24 ++++++++++-
 hw/net/igb_core.h                     |  1 +
 hw/net/igb_migration.h                | 22 +++++++++-
 hw/net/igb_migration.c                | 59 +++++++++++++++++++++++++--
 hw/net/trace-events                   |  2 +-
 5 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/docs/system/devices/igb-migration.rst b/docs/system/devices/igb-migration.rst
index 0e34e4b9fc68..3f861eed59cd 100644
--- a/docs/system/devices/igb-migration.rst
+++ b/docs/system/devices/igb-migration.rst
@@ -127,7 +127,9 @@ device-written completion fields::
   0x40    status             device      0 = pending, 1 = complete
   0x44    bitmap_size        device      Bytes written to bitmap
   0x48    dirty_page_count   device      Number of set bits in bitmap
-  0x4C    reserved[12]       -           Pad to 64-byte cache line
+  0x4C    reserved           -           Padding
+  0x50    dma_writes         device      Total DMA writes since enable
+  0x58    reserved[10]       -           Pad to 64-byte cache line
   0x80    bitmap[]           device      Dirty page bitmap
 
 The driver fills the request fields, issues ``DIRTY_CTRL=QUERY``, and
@@ -135,6 +137,26 @@ polls ``status`` for completion. The device reads the request, writes
 the dirty bitmap and completion fields via DMA, then sets
 ``status = 1``.
 
+Migration statistics
+~~~~~~~~~~~~~~~~~~~~
+
+The migration BAR includes read-only statistics counters in a dedicated
+aperture at offset ``0x100``. These counters provide a live
+per-migration-cycle view of activity without requiring a
+``DIRTY_CTRL=QUERY``::
+
+  Offset  Name                       Description
+  0x100   MIG_STAT_DMA_WRITES        Total DMA write operations tracked
+  0x104   MIG_STAT_DMA_BYTES_LO      Total DMA bytes written (low 32 bits)
+  0x108   MIG_STAT_DMA_BYTES_HI      Total DMA bytes written (high 32 bits)
+  0x10C   MIG_STAT_DIRTY_PAGES_SET   Dirty pages marked since enable
+  0x110   MIG_STAT_DIRTY_PAGES_CLR   Dirty pages cleared by queries
+  0x114   MIG_STAT_DIRTY_PAGE_COUNT  Current dirty pages (set minus cleared)
+  0x118   MIG_STAT_DIRTY_QUERY_CNT   Number of QUERY operations
+
+All counters are reset on first ``DIRTY_CTRL=ENABLE`` or device reset,
+so the driver can read final values after ``DIRTY_CTRL=DISABLE``.
+
 Testing setup
 ~~~~~~~~~~~~~
 
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 07b4270708c4..91796aec8d7a 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -84,6 +84,7 @@ struct IGBCore {
     } tx[IGB_NUM_QUEUES];
 
     IGBVfDirtyState vf_dirty[IGB_MAX_VF_FUNCTIONS];
+    IgbVfMigStats vf_mig_stats[IGB_MAX_VF_FUNCTIONS];
 
     struct NetRxPkt *rx_pkt;
 
diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index 414412f6392e..6d2e3442781f 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -64,6 +64,15 @@
 #define IGB_MIG_DIRTY_BUF_ADDR_HI   0x038
 #define IGB_MIG_DIRTY_STATUS        0x03C
 
+/* Migration statistics registers (read-only) */
+#define IGB_MIG_STAT_DMA_WRITES       0x100
+#define IGB_MIG_STAT_DMA_BYTES_LO     0x104
+#define IGB_MIG_STAT_DMA_BYTES_HI     0x108
+#define IGB_MIG_STAT_DIRTY_PAGES_SET  0x10C
+#define IGB_MIG_STAT_DIRTY_PAGES_CLR  0x110
+#define IGB_MIG_STAT_DIRTY_PAGE_COUNT 0x114
+#define IGB_MIG_STAT_DIRTY_QUERY_CNT  0x118
+
 /* DEVICE_STATE values - mirrors VFIO migration states */
 #define IGB_MIG_STATE_ERROR         0
 #define IGB_MIG_STATE_STOP          1
@@ -126,7 +135,9 @@ struct igb_mig_dirty_query {
     uint32_t status;
     uint32_t bitmap_size;
     uint32_t dirty_page_count;
-    uint32_t reserved1[12];
+    uint32_t reserved1;
+    uint64_t dma_writes;
+    uint32_t reserved2[10];
 
     /* Cache line 2+: bitmap (written by device) */
     uint8_t bitmap[];
@@ -154,6 +165,15 @@ typedef struct IgbVfMigState {
     uint32_t mig_dirty_status;
 } IgbVfMigState;
 
+typedef struct IgbVfMigStats {
+    uint32_t dma_writes;
+    uint64_t dma_bytes;
+    uint32_t dirty_pages_set;
+    uint32_t dirty_pages_cleared;
+    uint32_t dirty_page_count;
+    uint32_t dirty_query_count;
+} IgbVfMigStats;
+
 typedef struct IgbVfState  IgbVfState;
 void igb_pf_init_migration_bar(PCIDevice *dev);
 bool igbvf_add_migration_cap(PCIDevice *dev, Error **errp);
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index fce661f68e3d..7fce8d535909 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -458,6 +458,7 @@ void igb_core_dirty_track_dma(IGBCore *core, int vfn,
                               dma_addr_t addr, dma_addr_t len)
 {
     IGBVfDirtyState *ds = &core->vf_dirty[vfn];
+    IgbVfMigStats *stats = &core->vf_mig_stats[vfn];
     bool matched = false;
     uint32_t i;
 
@@ -465,6 +466,8 @@ void igb_core_dirty_track_dma(IGBCore *core, int vfn,
         return;
     }
 
+    stats->dma_writes++;
+    stats->dma_bytes += len;
     trace_igb_core_dirty_track_dma(vfn, addr, len);
 
     for (i = 0; i < ds->num_ranges; i++) {
@@ -486,7 +489,10 @@ void igb_core_dirty_track_dma(IGBCore *core, int vfn,
 
         for (page = start_page; page <= end_page; page++) {
             if (page < r->nbits) {
-                set_bit(page, r->bitmap);
+                if (!test_and_set_bit(page, r->bitmap)) {
+                    stats->dirty_pages_set++;
+                    stats->dirty_page_count++;
+                }
             }
         }
     }
@@ -510,6 +516,15 @@ static uint32_t igb_core_vf_dirty_enable(IgbVfState *s, uint64_t pgsize,
     IGBVfDirtyState *ds = igb_core_vf_dirty_state(s);
     IGBVfDirtyRange *r;
 
+    /*
+     * Reset stats on first enable so the driver can read them after
+     * disable
+     */
+    if (ds->num_ranges == 0) {
+        memset(&igbvf_get_core(s)->vf_mig_stats[s->vfn], 0,
+               sizeof(IgbVfMigStats));
+    }
+
     if (ds->num_ranges >= IGB_MIG_CAPS_MAX_RANGES) {
         return IGB_MIG_DIRTY_STATUS_TOO_MANY_RANGES;
     }
@@ -561,7 +576,9 @@ static bool igb_core_vf_dirty_query(IgbVfState *s,
                              void *buf, size_t buf_size, size_t *out_size,
                              uint64_t range_iova, uint64_t range_size)
 {
-    IGBVfDirtyState *ds = igb_core_vf_dirty_state(s);
+    IGBCore *core = igbvf_get_core(s);
+    IGBVfDirtyState *ds = &core->vf_dirty[s->vfn];
+    IgbVfMigStats *stats = &core->vf_mig_stats[s->vfn];
     uint32_t i;
 
     for (i = 0; i < ds->num_ranges; i++) {
@@ -587,6 +604,13 @@ static bool igb_core_vf_dirty_query(IgbVfState *s,
             bitmap_clear(r->bitmap, start_page, n);
         }
 
+        {
+            uint32_t cleared = bitmap_count_one(buf, count);
+            stats->dirty_pages_cleared += cleared;
+            stats->dirty_page_count -= MIN(stats->dirty_page_count, cleared);
+            stats->dirty_query_count++;
+        }
+
         *out_size = bitmap_empty(buf, count) ? 0 : DIV_ROUND_UP(count, 8);
         return true;
     }
@@ -881,6 +905,7 @@ static void igbvf_mig_data_xfer(IgbVfState *s, uint32_t val)
 static uint64_t igbvf_mig_read(void *opaque, hwaddr addr, unsigned size)
 {
     IgbVfState *s = opaque;
+    IgbVfMigStats *stats = &igbvf_get_core(s)->vf_mig_stats[s->vfn];
     IgbVfMigState *ms = &s->mig;
     uint64_t val = 0;
 
@@ -915,6 +940,27 @@ static uint64_t igbvf_mig_read(void *opaque, hwaddr addr, unsigned size)
     case IGB_MIG_DIRTY_STATUS:
         val = ms->mig_dirty_status;
         break;
+    case IGB_MIG_STAT_DMA_WRITES:
+        val = stats->dma_writes;
+        break;
+    case IGB_MIG_STAT_DMA_BYTES_LO:
+        val = (uint32_t)stats->dma_bytes;
+        break;
+    case IGB_MIG_STAT_DMA_BYTES_HI:
+        val = (uint32_t)(stats->dma_bytes >> 32);
+        break;
+    case IGB_MIG_STAT_DIRTY_PAGES_SET:
+        val = stats->dirty_pages_set;
+        break;
+    case IGB_MIG_STAT_DIRTY_PAGES_CLR:
+        val = stats->dirty_pages_cleared;
+        break;
+    case IGB_MIG_STAT_DIRTY_PAGE_COUNT:
+        val = stats->dirty_page_count;
+        break;
+    case IGB_MIG_STAT_DIRTY_QUERY_CNT:
+        val = stats->dirty_query_count;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "igbvf: VF%u bad migration BAR read at 0x%"
@@ -942,6 +988,7 @@ static uint32_t igbvf_mig_dirty_count(const void *bitmap, size_t size)
 static void igbvf_mig_dirty_query(IgbVfState *s, uint64_t pgsize)
 {
     IgbVfMigState *ms = &s->mig;
+    IgbVfMigStats *stats = &igbvf_get_core(s)->vf_mig_stats[s->vfn];
     PCIDevice *dev = pcie_sriov_get_pf(PCI_DEVICE(s));
     uint64_t buf_addr = ms->mig_dirty_buf_addr;
     uint64_t range_iova = 0, range_size = 0;
@@ -982,12 +1029,17 @@ static void igbvf_mig_dirty_query(IgbVfState *s, uint64_t pgsize)
     stl_le_pci_dma(dev,
                    buf_addr + offsetof(struct igb_mig_dirty_query, dirty_page_count),
                    dirty_pages, MEMTXATTRS_UNSPECIFIED);
+    stq_le_pci_dma(dev,
+                   buf_addr + offsetof(struct igb_mig_dirty_query, dma_writes),
+                   stats->dma_writes,
+                   MEMTXATTRS_UNSPECIFIED);
     stl_le_pci_dma(dev,
                    buf_addr + offsetof(struct igb_mig_dirty_query, status),
                    valid ? IGB_MIG_DIRTY_STATUS_COMPLETE : 0,
                    MEMTXATTRS_UNSPECIFIED);
 
-    trace_igbvf_mig_dirty_query(s->vfn, (uint64_t)out_size, dirty_pages);
+    trace_igbvf_mig_dirty_query(s->vfn, (uint64_t)out_size, dirty_pages,
+                                stats->dma_writes);
 }
 
 static void igbvf_mig_dirty_ctrl(IgbVfState *s, uint32_t val)
@@ -1135,6 +1187,7 @@ void igbvf_mig_state_reset(IgbVfState *s)
     ms->mig_dirty_range_size = 0;
     ms->mig_dirty_buf_addr = 0;
     ms->mig_dirty_status = IGB_MIG_DIRTY_STATUS_OK;
+    memset(&igbvf_get_core(s)->vf_mig_stats[s->vfn], 0, sizeof(IgbVfMigStats));
     ms->mig_saved_vfre = true;
     ms->mig_saved_vfte = true;
     trace_igbvf_mig_reset(s->vfn);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 1e38d9ab3697..76584b43bf19 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -305,7 +305,7 @@ igbvf_mig_load_state(uint16_t vfn, uint32_t size, bool vfre, bool vfte) "VF%u: l
 igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
 igbvf_mig_dirty_enable(uint16_t vfn, uint64_t pgsize, uint64_t nbits) "VF%u: dirty tracking enabled pgsize=%"PRIu64" nbits=%"PRIu64
 igbvf_mig_dirty_disable(uint16_t vfn) "VF%u: dirty tracking disabled"
-igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages) "VF%u: dirty query returned %"PRIu64" bytes, %u dirty pages"
+igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages, uint64_t dma_writes) "VF%u: dirty query returned %"PRIu64" bytes, %u dirty pages (dma_writes=%"PRIu64")"
 
 # igb_core.c - VF migration diagnostics
 igb_core_dirty_track_dma(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA addr=0x%"PRIx64" len=%"PRIu64
-- 
2.55.0


