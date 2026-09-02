Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD401C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qWd-0004MG-8R; Wed, 02 Sep 2026 15:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1qWb-0004Li-2A
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1qWY-0002Bz-TE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788376889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqAuP8/AUKso6DNaTPVzD0YdIlJ4B9ZHtCScu1u/1Ls=;
 b=Tc16akwaUDqi0YYpQ+GWj5qwF5TDLu+zAfvj4jN2DnggJK33re3APGI7O3UXLrLcmbjuMf
 WW7dCXQmW+exyjq7ATw7hYqj/Vvc1NDznAXdUC8IjSGBMgTKrtBbWl1A9VO1MSJgyQMrNz
 FJSywiZS/bePB2yvg+KiUva7SG2Wf4Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-E4QF9d7KOMqpbu34inp1dw-1; Wed,
 02 Sep 2026 15:21:25 -0400
X-MC-Unique: E4QF9d7KOMqpbu34inp1dw-1
X-Mimecast-MFC-AGG-ID: E4QF9d7KOMqpbu34inp1dw_1788376884
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 109361801315; Wed,  2 Sep 2026 19:21:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA4DB3000DA3; Wed,  2 Sep 2026 19:21:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v2 8/9] igb: Add dirty page tracking statistics
Date: Wed,  2 Sep 2026 21:20:53 +0200
Message-ID: <20260902192054.3329753-9-clg@redhat.com>
In-Reply-To: <20260902192054.3329753-1-clg@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Counters are reset on first DIRTY_ENABLE or device reset, so the
driver can read final values after DIRTY_DISABLE.

AI-used-for: code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |  1 +
 hw/net/igb_migration.h | 22 ++++++++++++++
 hw/net/igb_migration.c | 65 ++++++++++++++++++++++++++++++++++++++++--
 hw/net/trace-events    |  2 +-
 4 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 7d6f44b7ffe9..380cc88b7959 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -103,6 +103,7 @@ struct IGBCore {
     int64_t timadj;
 
     IGBVfDirtyState vf_dirty[IGB_MAX_VF_FUNCTIONS];
+    IgbVfMigStats vf_mig_stats[IGB_MAX_VF_FUNCTIONS];
 };
 
 void
diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index 2bb9a0ed36ce..b334bb8f78ba 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -64,6 +64,7 @@
 #define IGB_MIG_CMD_DIRTY_ENABLE        4
 #define IGB_MIG_CMD_DIRTY_DISABLE       5
 #define IGB_MIG_CMD_DIRTY_QUERY         6
+#define IGB_MIG_CMD_GET_STATS           7
 
 /* STATUS register: state in [7:0], error code [15:8] */
 #define IGB_MIG_STATUS_STATE_MASK       0xFF
@@ -111,6 +112,15 @@ typedef struct IGBVfDirtyState {
     uint32_t num_ranges;
 } IGBVfDirtyState;
 
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
@@ -149,6 +159,18 @@ struct igb_mig_dirty_query {
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
index 46299ff77ab9..2504d5bd308b 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -438,6 +438,7 @@ void igb_core_dirty_track_dma(IGBCore *core, int vfn,
                               dma_addr_t addr, dma_addr_t len)
 {
     IGBVfDirtyState *ds = &core->vf_dirty[vfn];
+    IgbVfMigStats *stats = &core->vf_mig_stats[vfn];
     bool matched = false;
     uint32_t i;
 
@@ -447,6 +448,9 @@ void igb_core_dirty_track_dma(IGBCore *core, int vfn,
 
     trace_igb_core_dirty_track_dma(vfn, addr, len);
 
+    stats->dma_writes++;
+    stats->dma_bytes += len;
+
     for (i = 0; i < ds->num_ranges; i++) {
         IGBVfDirtyRange *r = &ds->ranges[i];
         uint64_t r_end = r->iova + r->size;
@@ -466,7 +470,10 @@ void igb_core_dirty_track_dma(IGBCore *core, int vfn,
 
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
@@ -493,6 +500,15 @@ static uint32_t igb_core_vf_dirty_enable(IgbVfState *s, uint64_t pgsize,
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
@@ -635,12 +651,14 @@ static IGBVfDirtyRange *igb_core_vf_dirty_range_valid(IGBVfDirtyState *ds,
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
 
@@ -686,6 +704,10 @@ static uint8_t igbvf_mig_cmd_dirty_query(IgbVfState *s)
 
     dirty_pages = bitmap_count_one(bitmap, range_size / range->page_size);
 
+    stats->dirty_pages_cleared += dirty_pages;
+    stats->dirty_page_count -= MIN(stats->dirty_page_count, dirty_pages);
+    stats->dirty_query_count++;
+
     val32 = cpu_to_le32(out_size);
     address_space_write(&address_space_memory,
                         buf_addr + offsetof(struct igb_mig_dirty_query,
@@ -696,8 +718,13 @@ static uint8_t igbvf_mig_cmd_dirty_query(IgbVfState *s)
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
 
@@ -898,6 +925,32 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
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
@@ -955,6 +1008,10 @@ static void igbvf_mig_cmd_ctrl(IgbVfState *s, uint32_t val)
         err = igbvf_mig_cmd_dirty_query(s);
         break;
 
+    case IGB_MIG_CMD_GET_STATS:
+        err = igbvf_mig_cmd_get_stats(s);
+        break;
+
     default:
         err = IGB_MIG_ERR_UNK_CMD;
         break;
@@ -1059,6 +1116,8 @@ void igbvf_mig_state_reset(IgbVfState *s)
     memset(ms->mig_data, 0, sizeof(ms->mig_data));
     ms->mig_saved_vfre = true;
     ms->mig_saved_vfte = true;
+    memset(&igbvf_get_core(s)->vf_mig_stats[s->vfn], 0,
+           sizeof(IgbVfMigStats));
 
     pci_set_long(PCI_DEVICE(s)->config +
                  IGB_MIG_DVSEC_OFFSET + IGB_MIG_BUF_ADDR_LO, 0);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index eb5c61a8f6fb..6c2c5493094a 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -302,7 +302,7 @@ igbvf_mig_load_state(uint16_t vfn, uint32_t size, bool vfre, bool vfte) "VF%u: l
 igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
 igbvf_mig_dirty_enable(uint16_t vfn, uint64_t pgsize, uint64_t nbits) "VF%u: dirty tracking enabled pgsize=%"PRIu64" nbits=%"PRIu64
 igbvf_mig_dirty_disable(uint16_t vfn) "VF%u: dirty tracking disabled"
-igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages) "VF%u: dirty query returned %"PRIu64" bytes, %u dirty pages"
+igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages, uint64_t dma_writes) "VF%u: dirty query returned %"PRIu64" bytes, %u dirty pages (dma_writes=%"PRIu64")"
 igb_core_dirty_track_dma(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA addr=0x%"PRIx64" len=%"PRIu64
 igb_core_dirty_track_dma_drop(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA dropped addr=0x%"PRIx64" len=%"PRIu64" no matching range"
 igbvf_mig_quiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: quiesce VFRE=0x%x VFTE=0x%x"
-- 
2.55.0


