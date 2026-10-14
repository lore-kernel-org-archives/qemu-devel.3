Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD55CCC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuem-0005iy-Ku; Wed, 14 Oct 2026 04:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueK-0005ZZ-Ul
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueJ-0004a5-5L
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weYNgF9+56KYGJ1jmV7oNRyWQIz7MbqGlNWsKqCt10E=;
 b=UBkDmSmP+gOLS+mUmZTw98kdkrhT/3fs3EMn89R6VfSPcYR2vLHyl/fFWMuxejCChNT+TU
 D8wJUpV1lm4dlZN2olGqfvmsf9aMIFH3/KewfpxR8rDT//cXRsy34ikrISOQiGFwqBFyuS
 Taq9nOJ8wHc3JQXlYVe+aM2rdS01mJI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-bKLuOSWwPlq2saB6v_gULQ-1; Wed,
 14 Oct 2026 08:47:41 +0000
X-MC-Unique: bKLuOSWwPlq2saB6v_gULQ-1
X-Mimecast-MFC-AGG-ID: bKLuOSWwPlq2saB6v_gULQ_1791967660
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B17EB195608E; Wed, 14 Oct 2026 08:47:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC7B51800642; Wed, 14 Oct 2026 08:47:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 12/17] igb: Quiesce VFs on STOP and include PF enable
 state in migration
Date: Wed, 14 Oct 2026 10:46:50 +0200
Message-ID: <20261014084655.127254-13-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Quiesce VFs by clearing VFRE/VFTE on transitions to STOP or
STOP_COPY, preventing DMA while device state is serialized. Restore
saved VFRE/VFTE on STOP->RUNNING.

Include per-VF VFRE/VFTE enable bits in the migration blob so the
destination can restore the pre-quiesce state. Add a QUIESCED bit to
STATUS for the driver to confirm DMA has drained. Clear VFLRE before
state restore on the destination to prevent stale reset indications.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_migration.h |  6 ++-
 hw/net/igb_migration.c | 86 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index 4968798509aa..841fc512d228 100644
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
  *   +0x20  DATA_SIZE                  (RO: state blob size in bytes)
@@ -71,6 +72,7 @@
 #define IGB_MIG_STATUS_ERROR_CODE_SHIFT 8
 #define IGB_MIG_STATUS_ERR(code) \
     ((uint32_t)(code) << IGB_MIG_STATUS_ERROR_CODE_SHIFT)
+#define IGB_MIG_STATUS_QUIESCED         (1u << 16)
 
 /* Device states (based on VFIO migration v2) */
 #define IGB_MIG_STATE_ERROR             0
@@ -104,6 +106,8 @@ typedef struct IgbVfMigState {
     uint32_t mig_data[IGB_VF_STATE_MAX_SIZE / sizeof(uint32_t)];
     uint32_t mig_data_size;
     uint64_t mig_data_buf_addr;
+    bool mig_saved_vfre;
+    bool mig_saved_vfte;
 } IgbVfMigState;
 
 #define IGB_MIG_DIRTY_DEFAULT_PGSIZE        4096
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index efa2f5a8d333..80098e62daea 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -64,6 +64,8 @@ typedef struct IgbMigBlob {
     uint32_t vlvf[IGB_VF_MAX_VLVF_REGS];
     uint32_t mta[E1000_MC_TBL_SIZE];
     uint32_t uta[E1000_MC_TBL_SIZE];
+    uint32_t vfre;
+    uint32_t vfte;
 } IgbMigBlob;
 
 #define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
@@ -530,6 +532,7 @@ static void igb_core_vf_save_tx_ctx(IGBCore *core, int queue,
 static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
 {
     int size = IGB_MIG_BLOB_SIZE;
+    IgbVfMigState *ms = &s->mig;
     IGBCore *core = igbvf_get_core(s);
     IgbMigBlob *blob = buf;
     uint32_t offsets[IGB_VF_MAX_FIXED_REGS];
@@ -568,7 +571,12 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
 
     igb_core_vf_save_hash_tables(core, s->vfn, blob);
 
-    trace_igbvf_mig_save_state(s->vfn, size);
+    blob->vfre = cpu_to_le32(ms->mig_saved_vfre);
+    blob->vfte = cpu_to_le32(ms->mig_saved_vfte);
+
+    trace_igbvf_mig_save_state(s->vfn, size, ms->mig_saved_vfre,
+                               ms->mig_saved_vfte,
+                               core->mac[VFRE]);
     return size;
 }
 
@@ -681,6 +689,7 @@ static void igb_core_vf_load_tx_ctx(IGBCore *core, int queue,
 
 static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
 {
+    IgbVfMigState *ms = &s->mig;
     IGBCore *core = igbvf_get_core(s);
     int q0 = s->vfn;
     int q1 = s->vfn + IGB_NUM_VM_POOLS;
@@ -787,13 +796,25 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
     /* Propagate VTIVAR to IVAR0, skipped by direct core->mac[] write */
     igb_core_vf_propagate_ivar(core, s->vfn);
 
-    trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
+    ms->mig_saved_vfre = !!le32_to_cpu(blob->vfre);
+    ms->mig_saved_vfte = !!le32_to_cpu(blob->vfte);
+
+    trace_igbvf_mig_load_state(s->vfn, (uint32_t)size,
+                               ms->mig_saved_vfre,
+                               ms->mig_saved_vfte);
     return 0;
 }
 
 static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
 {
     int ret;
+    IGBCore *core = igbvf_get_core(s);
+
+    /*
+     * Pre-load: Clear the VFLRE bit before restoring state so the PF
+     * watchdog does not overwrite what we are about to load.
+     */
+    core->mac[VFLRE] &= ~BIT(s->vfn);
 
     ret = igb_core_vf_load_state(s, buf, size);
     if (ret < 0) {
@@ -1169,6 +1190,43 @@ static uint8_t igbvf_mig_cmd_load(IgbVfState *s, uint32_t data_size)
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
+    /* Interrupt mask restore and pending cause re-raise added later. */
+}
+
 static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
 {
     IgbVfMigState *ms = &s->mig;
@@ -1189,6 +1247,11 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
             old == IGB_MIG_STATE_ERROR) {
             igb_core_vf_dirty_disable(s);
         }
+        if (old == IGB_MIG_STATE_RUNNING ||
+            old == IGB_MIG_STATE_PRE_COPY ||
+            old == IGB_MIG_STATE_ERROR) {
+            igb_core_vf_quiesce(s);
+        }
         /* Restore DATA_SIZE to default max */
         igbvf_mig_update_data_size(s, igb_core_vf_max_data_size(s));
         break;
@@ -1201,6 +1264,9 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
         if (old == IGB_MIG_STATE_PRE_COPY) {
             igb_core_vf_dirty_disable(s);
         }
+        if (old == IGB_MIG_STATE_STOP) {
+            igb_core_vf_unquiesce(s);
+        }
         break;
 
     case IGB_MIG_STATE_STOP_COPY:
@@ -1208,8 +1274,14 @@ static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
             old != IGB_MIG_STATE_PRE_COPY) {
             return IGB_MIG_ERR_BAD_STATE;
         }
+        if (old == IGB_MIG_STATE_PRE_COPY) {
+            igb_core_vf_quiesce(s);
+        }
         ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
         if (ret < 0) {
+            if (old == IGB_MIG_STATE_PRE_COPY) {
+                igb_core_vf_unquiesce(s);
+            }
             return -ret;
         }
         igbvf_mig_update_data_size(s, ret);
@@ -1251,6 +1323,16 @@ static void igbvf_mig_update_status(IgbVfState *s, uint8_t err)
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
     trace_igbvf_mig_status(s->vfn, status);
 }
-- 
2.56.0


