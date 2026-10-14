Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016C3CC6B29
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGufA-0006ag-Q3; Wed, 14 Oct 2026 04:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueU-0005h1-B5
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueR-0004ah-R7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+o+Marw5FWNlQbRhb4nqCDgNy13bdt7p4Qdx355J3m4=;
 b=WL3lkOlCIznY9PxoSqf/vHlF1mPXKXzoRL9GpYO63EpPjqcX7vzicP6wbdvHI00LqBTjFs
 vSYR3FoPkYlVRmF6SdrW1xWHsZS33ztnqaBY06CEQOx2rqE3itrstqzQpjkCTqKpbIMF95
 LIaHdAGvLzNEs0pj2BvsIOJ+I0mb7W4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-Gjj-AP9LPJyZj5_0OLUesQ-1; Wed,
 14 Oct 2026 08:47:49 +0000
X-MC-Unique: Gjj-AP9LPJyZj5_0OLUesQ-1
X-Mimecast-MFC-AGG-ID: Gjj-AP9LPJyZj5_0OLUesQ_1791967668
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6F5F180061E; Wed, 14 Oct 2026 08:47:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78EF71800345; Wed, 14 Oct 2026 08:47:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 15/17] igb: Add dirty page tracking statistics
Date: Wed, 14 Oct 2026 10:46:53 +0200
Message-ID: <20261014084655.127254-16-clg@redhat.com>
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

Add a GET_STATS command (cmd 7) to the migration DVSEC for monitoring
dirty page tracking and DMA activity per VF. The device DMA-writes an
igb_mig_stats_resp struct to the shared buffer.

The dma_writes counter is also reported in the dirty query buffer so
the driver gets it alongside the bitmap without an extra config read.

Counters are reset on first DIRTY_ENABLE, so the driver can read
final values after DIRTY_DISABLE.

AI-used-for: code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |  1 +
 hw/net/igb_migration.h | 22 +++++++++++++++
 hw/net/igb_migration.c | 63 ++++++++++++++++++++++++++++++++++++++++--
 hw/net/trace-events    |  2 +-
 4 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 75780f68dffb..e09cac48d7b1 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -103,6 +103,7 @@ struct IGBCore {
     int64_t timadj;
 
     IGBVfDirtyState vf_dirty[IGB_MAX_VF_FUNCTIONS];
+    IgbVfMigStats vf_mig_stats[IGB_MAX_VF_FUNCTIONS];
 };
 
 void
diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index 96dfe99468d1..3cb197036705 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -66,6 +66,7 @@
 #define IGB_MIG_CMD_DIRTY_ENABLE        4
 #define IGB_MIG_CMD_DIRTY_DISABLE       5
 #define IGB_MIG_CMD_DIRTY_QUERY         6
+#define IGB_MIG_CMD_GET_STATS           7
 
 /* STATUS register: state in [7:0], error code [15:8] */
 #define IGB_MIG_STATUS_STATE_MASK       0xFF
@@ -101,6 +102,15 @@
 /* Shared buffer constants */
 #define IGB_VF_STATE_MAX_SIZE           4096
 
+typedef struct IgbVfMigStats {
+    uint64_t dma_writes;
+    uint64_t dma_bytes;
+    uint32_t dirty_pages_set;
+    uint32_t dirty_pages_cleared;
+    uint32_t dirty_page_count;
+    uint32_t dirty_query_count;
+} IgbVfMigStats;
+
 typedef struct IgbVfMigState {
     uint32_t mig_state;
     uint32_t mig_data[IGB_VF_STATE_MAX_SIZE / sizeof(uint32_t)];
@@ -157,6 +167,18 @@ struct igb_mig_dirty_query {
     uint8_t bitmap[];
 };
 
+/*
+ * GET_STATS:    device writes igb_mig_stats_resp to buffer.
+ */
+struct igb_mig_stats_resp {
+    uint64_t dma_writes;
+    uint64_t dma_bytes;
+    uint32_t dirty_pages_set;
+    uint32_t dirty_pages_cleared;
+    uint32_t dirty_page_count;
+    uint32_t dirty_query_count;
+};
+
 typedef struct IGBCore IGBCore;
 typedef struct IgbVfState IgbVfState;
 
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index ab80dbb5c6c6..77ae25347eaa 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -854,6 +854,7 @@ void igb_core_dirty_track_dma(IGBCore *core, int vfn,
                               dma_addr_t addr, dma_addr_t len)
 {
     IGBVfDirtyState *ds = &core->vf_dirty[vfn];
+    IgbVfMigStats *stats = &core->vf_mig_stats[vfn];
     bool matched = false;
     uint32_t i;
 
@@ -863,6 +864,9 @@ void igb_core_dirty_track_dma(IGBCore *core, int vfn,
 
     trace_igb_core_dirty_track_dma(vfn, addr, len);
 
+    stats->dma_writes++;
+    stats->dma_bytes += len;
+
     for (i = 0; i < ds->num_ranges; i++) {
         IGBVfDirtyRange *r = &ds->ranges[i];
         uint64_t r_end = r->iova + r->size;
@@ -882,7 +886,10 @@ void igb_core_dirty_track_dma(IGBCore *core, int vfn,
 
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
@@ -909,6 +916,15 @@ static uint32_t igb_core_vf_dirty_enable(IgbVfState *s, uint64_t pgsize,
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
         return IGB_MIG_ERR_TOO_MANY_RANGES;
     }
@@ -1058,12 +1074,14 @@ static IGBVfDirtyRange *igb_core_vf_dirty_range_valid(IGBVfDirtyState *ds,
 static uint8_t igbvf_mig_cmd_dirty_query(IgbVfState *s)
 {
     IgbVfMigState *ms = &s->mig;
+    IgbVfMigStats *stats = &igbvf_get_core(s)->vf_mig_stats[s->vfn];
     IGBVfDirtyState *ds = &igbvf_get_core(s)->vf_dirty[s->vfn];
     uint64_t buf_addr = ms->mig_data_buf_addr;
     uint64_t range_iova = 0, range_size = 0;
     IGBVfDirtyRange *range;
     uint32_t bmp_bytes, dirty_pages;
     uint32_t val32;
+    uint64_t val64;
     size_t out_size;
     g_autofree void *bitmap = NULL;
 
@@ -1109,6 +1127,10 @@ static uint8_t igbvf_mig_cmd_dirty_query(IgbVfState *s)
 
     dirty_pages = bitmap_count_one(bitmap, range_size / range->page_size);
 
+    stats->dirty_pages_cleared += dirty_pages;
+    stats->dirty_page_count -= MIN(stats->dirty_page_count, dirty_pages);
+    stats->dirty_query_count++;
+
     val32 = cpu_to_le32(out_size);
     address_space_write(&address_space_memory,
                         buf_addr + offsetof(struct igb_mig_dirty_query,
@@ -1119,8 +1141,13 @@ static uint8_t igbvf_mig_cmd_dirty_query(IgbVfState *s)
                         buf_addr + offsetof(struct igb_mig_dirty_query,
                                             dirty_page_count),
                         MEMTXATTRS_UNSPECIFIED, &val32, sizeof(val32));
-
-    trace_igbvf_mig_dirty_query(s->vfn, (uint64_t)out_size, dirty_pages);
+    val64 = cpu_to_le64(stats->dma_writes);
+    address_space_write(&address_space_memory,
+                        buf_addr + offsetof(struct igb_mig_dirty_query,
+                                            dma_writes),
+                        MEMTXATTRS_UNSPECIFIED, &val64, sizeof(val64));
+    trace_igbvf_mig_dirty_query(s->vfn, (uint64_t)out_size, dirty_pages,
+                                stats->dma_writes);
     return 0;
 }
 
@@ -1381,6 +1408,32 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
     return 0;
 }
 
+static uint8_t igbvf_mig_cmd_get_stats(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+    IgbVfMigStats *stats = &igbvf_get_core(s)->vf_mig_stats[s->vfn];
+    struct igb_mig_stats_resp resp;
+    MemTxResult r;
+
+    if (!ms->mig_data_buf_addr) {
+        return IGB_MIG_ERR_NO_BUFFER;
+    }
+
+    resp.dma_writes = cpu_to_le64(stats->dma_writes);
+    resp.dma_bytes = cpu_to_le64(stats->dma_bytes);
+    resp.dirty_pages_set = cpu_to_le32(stats->dirty_pages_set);
+    resp.dirty_pages_cleared = cpu_to_le32(stats->dirty_pages_cleared);
+    resp.dirty_page_count = cpu_to_le32(stats->dirty_page_count);
+    resp.dirty_query_count = cpu_to_le32(stats->dirty_query_count);
+
+    r = address_space_write(&address_space_memory, ms->mig_data_buf_addr,
+                            MEMTXATTRS_UNSPECIFIED, &resp, sizeof(resp));
+    if (r != MEMTX_OK) {
+        return IGB_MIG_ERR_DMA_FAILED;
+    }
+    return 0;
+}
+
 static void igbvf_mig_update_status(IgbVfState *s, uint8_t err)
 {
     IgbVfMigState *ms = &s->mig;
@@ -1442,6 +1495,10 @@ static void igbvf_mig_cmd_ctrl(IgbVfState *s, uint32_t val)
         err = igbvf_mig_cmd_dirty_query(s);
         break;
 
+    case IGB_MIG_CMD_GET_STATS:
+        err = igbvf_mig_cmd_get_stats(s);
+        break;
+
     default:
         err = IGB_MIG_ERR_UNK_CMD;
         break;
diff --git a/hw/net/trace-events b/hw/net/trace-events
index a171888db380..ea006fd4399f 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -305,7 +305,7 @@ igbvf_mig_save_hash_tables(uint16_t vfn, const char *name, int index, uint32_t v
 igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
 igbvf_mig_dirty_enable(uint16_t vfn, uint64_t pgsize, uint64_t nbits) "VF%u: dirty tracking enabled pgsize=%"PRIu64" nbits=%"PRIu64
 igbvf_mig_dirty_disable(uint16_t vfn) "VF%u: dirty tracking disabled"
-igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages) "VF%u: dirty query returned %"PRIu64" bytes, %u dirty pages"
+igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages, uint64_t dma_writes) "VF%u: dirty query returned %"PRIu64" bytes, %u dirty pages (dma_writes=%"PRIu64")"
 igb_core_dirty_track_dma(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA addr=0x%"PRIx64" len=%"PRIu64
 igb_core_dirty_track_dma_drop(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA dropped addr=0x%"PRIx64" len=%"PRIu64" no matching range"
 igbvf_mig_quiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: quiesce VFRE=0x%x VFTE=0x%x"
-- 
2.56.0


