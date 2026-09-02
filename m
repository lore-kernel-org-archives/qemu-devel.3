Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE41C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qWY-0004Kz-Uj; Wed, 02 Sep 2026 15:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1qWV-0004KQ-7s
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1qWS-00027w-1N
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788376883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2cjxw29/2X2+wcUsPPPggkx+sFbB/T9xSUUV0h+cG0=;
 b=FB5ShBmeOrHNRP2MM7m2Qdo2tuyFkmqIln9ysHnSN4pkvUItPcV8FXqqMQA4/bL1qGtn1X
 7VE3oK5aHDaCUiRJBlfdftGMDTqk0i3cD6fpkV+jwzRuJVkhI9vrVc39u8CThxn+NNIpP3
 D8y0MKkBK+5+y4Ua90U6mHyEunp4/Bk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-U7eqF4t_OHqX2d_q07Y_BA-1; Wed,
 02 Sep 2026 15:21:20 -0400
X-MC-Unique: U7eqF4t_OHqX2d_q07Y_BA-1
X-Mimecast-MFC-AGG-ID: U7eqF4t_OHqX2d_q07Y_BA_1788376879
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB5A019540C1; Wed,  2 Sep 2026 19:21:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D5163000DA3; Wed,  2 Sep 2026 19:21:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v2 6/9] igb: Quiesce VFs on STOP and include PF enable
 state in migration
Date: Wed,  2 Sep 2026 21:20:51 +0200
Message-ID: <20260902192054.3329753-7-clg@redhat.com>
In-Reply-To: <20260902192054.3329753-1-clg@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Quiesce VFs by clearing their VFRE/VFTE bits on transitions to STOP
(from RUNNING, PRE_COPY, or ERROR) and to STOP_COPY (from PRE_COPY).
This prevents further DMA while device state is being serialized.
Restore the saved VFRE/VFTE state on STOP->RUNNING so the VF can
resume normal operation.

Include the per-VF VFRE/VFTE enable bits in the migration blob so the
destination knows whether receive and transmit were active before
quiesce. On reset, both default to true.

Add a QUIESCED bit to the STATUS register so the driver can confirm
DMA has been drained before reading device state.

Clear the VFLRE (VF Level Reset Event) bit before restoring state on
the destination to prevent the PF watchdog from seeing a stale reset
indication and overwriting the loaded registers.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_migration.h |  6 ++-
 hw/net/igb_migration.c | 86 +++++++++++++++++++++++++++++++++++++++++-
 hw/net/trace-events    |  6 ++-
 3 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index 996de2d2f50b..2bb9a0ed36ce 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -24,7 +24,8 @@
  *   +0x0C  CAPS                       (RO: F_STATE[0], F_DIRTY[1],
  *                                      max_ranges[11:8], pgsize[16:12])
  *   +0x10  CTRL                       (WO: doorbell command)
- *   +0x14  STATUS                     (RO: state[7:0], error_code[15:8])
+ *   +0x14  STATUS                     (RO: state[7:0], error_code[15:8],
+ *                                      QUIESCED[16])
  *   +0x18  BUF_ADDR_LO                (RW: shared buffer GPA low)
  *   +0x1C  BUF_ADDR_HI                (RW: shared buffer GPA high)
  *   +0x20  DATA_SIZE                  (RO: max state blob size in bytes)
@@ -69,6 +70,7 @@
 #define IGB_MIG_STATUS_ERROR_CODE_SHIFT 8
 #define IGB_MIG_STATUS_ERR(code) \
     ((uint32_t)(code) << IGB_MIG_STATUS_ERROR_CODE_SHIFT)
+#define IGB_MIG_STATUS_QUIESCED         (1u << 16)
 
 /* Device states (based on VFIO migration v2) */
 #define IGB_MIG_STATE_ERROR             0
@@ -114,6 +116,8 @@ typedef struct IgbVfMigState {
     uint32_t mig_data[IGB_VF_STATE_MAX_SIZE / sizeof(uint32_t)];
     uint32_t mig_data_size;
     uint64_t mig_data_buf_addr;
+    bool mig_saved_vfre;
+    bool mig_saved_vfte;
 } IgbVfMigState;
 
 /*
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index cfa73673e39a..435bd0d1623b 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -58,6 +58,8 @@ typedef struct IgbMigBlob {
     IgbMigRegPair ra[IGB_VF_MAX_RA_REGS];
     uint32_t num_tx_ctx;
     IgbMigTxCtx tx_ctx[2];
+    uint32_t vfre;
+    uint32_t vfte;
 } IgbMigBlob;
 
 #define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
@@ -210,6 +212,7 @@ static void igb_core_vf_save_tx_ctx(IGBCore *core, int queue,
 static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
 {
     int size = IGB_MIG_BLOB_SIZE;
+    IgbVfMigState *ms = &s->mig;
     IGBCore *core = igbvf_get_core(s);
     IgbMigBlob *blob = buf;
     uint32_t offsets[IGB_VF_MAX_FIXED_REGS];
@@ -248,7 +251,12 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
     igb_core_vf_save_tx_ctx(core, q0, &blob->tx_ctx[0]);
     igb_core_vf_save_tx_ctx(core, q1, &blob->tx_ctx[1]);
 
-    trace_igbvf_mig_save_state(s->vfn, size);
+    blob->vfre = cpu_to_le32(ms->mig_saved_vfre);
+    blob->vfte = cpu_to_le32(ms->mig_saved_vfte);
+
+    trace_igbvf_mig_save_state(s->vfn, size, ms->mig_saved_vfre,
+                               ms->mig_saved_vfte,
+                               core->mac[VFRE]);
     return size;
 }
 
@@ -291,6 +299,7 @@ static uint32_t igb_vf_relocate_offset(uint32_t offset,
 
 static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
 {
+    IgbVfMigState *ms = &s->mig;
     IGBCore *core = igbvf_get_core(s);
     uint32_t src_offsets[IGB_VF_MAX_FIXED_REGS];
     uint32_t dst_offsets[IGB_VF_MAX_FIXED_REGS];
@@ -379,7 +388,12 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
     igb_core_vf_load_tx_ctx(core, q0, &blob->tx_ctx[0]);
     igb_core_vf_load_tx_ctx(core, q1, &blob->tx_ctx[1]);
 
-    trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
+    ms->mig_saved_vfre = !!le32_to_cpu(blob->vfre);
+    ms->mig_saved_vfte = !!le32_to_cpu(blob->vfte);
+
+    trace_igbvf_mig_load_state(s->vfn, (uint32_t)size,
+                               ms->mig_saved_vfre,
+                               ms->mig_saved_vfte);
     return 0;
 }
 
@@ -388,6 +402,12 @@ static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
     int ret;
     IGBCore *core = igbvf_get_core(s);
 
+    /*
+     * Pre-load: Clear the VFLRE bit before restoring state so the PF
+     * watchdog does not overwrite what we are about to load.
+     */
+    core->mac[VFLRE] &= ~BIT(s->vfn);
+
     ret = igb_core_vf_load_state(s, buf, size);
     if (ret < 0) {
         return ret;
@@ -759,6 +779,45 @@ static uint8_t igbvf_mig_cmd_load(IgbVfState *s)
     return 0;
 }
 
+/* Quiesce a VF by disabling its RX and TX at the PF level. */
+static void igb_core_vf_quiesce(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+    IGBCore *core = igbvf_get_core(s);
+
+    ms->mig_saved_vfre = !!(core->mac[VFRE] & BIT(s->vfn));
+    ms->mig_saved_vfte = !!(core->mac[VFTE] & BIT(s->vfn));
+
+    core->mac[VFRE] &= ~BIT(s->vfn);
+    core->mac[VFTE] &= ~BIT(s->vfn);
+    trace_igbvf_mig_quiesce(s->vfn, core->mac[VFRE], core->mac[VFTE]);
+}
+
+static void igb_core_vf_unquiesce(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+    IGBCore *core = igbvf_get_core(s);
+    bool re = ms->mig_saved_vfre;
+    bool te = ms->mig_saved_vfte;
+
+    if (re) {
+        core->mac[VFRE] |= BIT(s->vfn);
+    } else {
+        core->mac[VFRE] &= ~BIT(s->vfn);
+    }
+    if (te) {
+        core->mac[VFTE] |= BIT(s->vfn);
+    } else {
+        core->mac[VFTE] &= ~BIT(s->vfn);
+    }
+
+    trace_igbvf_mig_unquiesce(s->vfn, core->mac[VFRE], core->mac[VFTE]);
+
+    if (re) {
+        igb_start_recv(core);
+    }
+}
+
 static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
 {
     IgbVfMigState *ms = &s->mig;
@@ -779,6 +838,11 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
             old == IGB_MIG_STATE_ERROR) {
             igb_core_vf_dirty_disable(s);
         }
+        if (old == IGB_MIG_STATE_RUNNING ||
+            old == IGB_MIG_STATE_PRE_COPY ||
+            old == IGB_MIG_STATE_ERROR) {
+            igb_core_vf_quiesce(s);
+        }
         /* Restore DATA_SIZE to max, same as at reset */
         igbvf_mig_update_data_size(s, igb_core_vf_max_data_size(s));
         break;
@@ -791,6 +855,9 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
         if (old == IGB_MIG_STATE_PRE_COPY) {
             igb_core_vf_dirty_disable(s);
         }
+        if (old == IGB_MIG_STATE_STOP) {
+            igb_core_vf_unquiesce(s);
+        }
         break;
 
     case IGB_MIG_STATE_STOP_COPY:
@@ -798,6 +865,9 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
             old != IGB_MIG_STATE_PRE_COPY) {
             return IGB_MIG_ERR_BAD_STATE;
         }
+        if (old == IGB_MIG_STATE_PRE_COPY) {
+            igb_core_vf_quiesce(s);
+        }
         ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
         if (ret < 0) {
             return -ret;
@@ -840,6 +910,16 @@ static void igbvf_mig_update_status(IgbVfState *s, uint8_t err)
         status = IGB_MIG_STATE_ERROR | IGB_MIG_STATUS_ERR(err);
     }
 
+    /*
+     * QUIESCED tells the driver it is safe to read device state.
+     * In STOP and STOP_COPY, igb_core_vf_quiesce() has already
+     * cleared VFRE/VFTE so no further VF DMA can occur.
+     */
+    if (ms->mig_state == IGB_MIG_STATE_STOP ||
+        ms->mig_state == IGB_MIG_STATE_STOP_COPY) {
+        status |= IGB_MIG_STATUS_QUIESCED;
+    }
+
     pci_set_long(dev->config + IGB_MIG_DVSEC_OFFSET + IGB_MIG_STATUS, status);
 }
 
@@ -977,6 +1057,8 @@ void igbvf_mig_state_reset(IgbVfState *s)
     ms->mig_data_buf_addr = 0;
     igbvf_mig_update_data_size(s, igb_core_vf_max_data_size(s));
     memset(ms->mig_data, 0, sizeof(ms->mig_data));
+    ms->mig_saved_vfre = true;
+    ms->mig_saved_vfte = true;
 
     pci_set_long(PCI_DEVICE(s)->config +
                  IGB_MIG_DVSEC_OFFSET + IGB_MIG_BUF_ADDR_LO, 0);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index c606191df2ef..eb5c61a8f6fb 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -297,14 +297,16 @@ igbvf_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
 
 # igb_migration.c
 igbvf_mig_set_state(uint16_t vfn, uint32_t old_state, uint32_t new_state) "VF%u: state %u -> %u"
-igbvf_mig_save_state(uint16_t vfn, uint32_t size) "VF%u: saved %u bytes of device state"
-igbvf_mig_load_state(uint16_t vfn, uint32_t size) "VF%u: loaded %u bytes of device state"
+igbvf_mig_save_state(uint16_t vfn, int size, bool vfre, bool vfte, uint32_t reg_vfre) "VF%u: saved %d bytes vfre=%d vfte=%d VFRE=0x%x"
+igbvf_mig_load_state(uint16_t vfn, uint32_t size, bool vfre, bool vfte) "VF%u: loaded %u bytes vfre=%d vfte=%d"
 igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
 igbvf_mig_dirty_enable(uint16_t vfn, uint64_t pgsize, uint64_t nbits) "VF%u: dirty tracking enabled pgsize=%"PRIu64" nbits=%"PRIu64
 igbvf_mig_dirty_disable(uint16_t vfn) "VF%u: dirty tracking disabled"
 igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages) "VF%u: dirty query returned %"PRIu64" bytes, %u dirty pages"
 igb_core_dirty_track_dma(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA addr=0x%"PRIx64" len=%"PRIu64
 igb_core_dirty_track_dma_drop(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA dropped addr=0x%"PRIx64" len=%"PRIu64" no matching range"
+igbvf_mig_quiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: quiesce VFRE=0x%x VFTE=0x%x"
+igbvf_mig_unquiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: unquiesce VFRE=0x%x VFTE=0x%x"
 
 # spapr_llan.c
 spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32
-- 
2.55.0


