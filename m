Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3FACC6B29
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGueZ-0005hp-QQ; Wed, 14 Oct 2026 04:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueD-0005Wo-8d
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueA-0004ZR-Ea
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lwU7Lm7Uh19FovhUkBJV4SoFJWR0MWrOz36CSE2t08=;
 b=OsghGbqu6gittjkbW778oQrwP9qAYuKItNMBkQrWPwLZxnJ7C5FZolTibLKff+96UIamep
 ddZxgYVU6DPPc+lP23PglFHrPGGR28AaQMEVpX0PxL07nNL0GGHQgXRka3/LjPcSYL3WQV
 z1HAwNFN57M2QScRT9x7Prno8o7GJEA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-5QxWv0kfMqevXYNz8pyRWA-1; Wed,
 14 Oct 2026 08:47:34 +0000
X-MC-Unique: 5QxWv0kfMqevXYNz8pyRWA-1
X-Mimecast-MFC-AGG-ID: 5QxWv0kfMqevXYNz8pyRWA_1791967653
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A5CA1956040; Wed, 14 Oct 2026 08:47:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D5921800642; Wed, 14 Oct 2026 08:47:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 10/17] igb: Save MTA/UTA hash tables and fixup on VF
 migration load
Date: Wed, 14 Oct 2026 10:46:48 +0200
Message-ID: <20261014084655.127254-11-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The MTA and UTA are PF-wide shared hash tables with no per-VF ownership
bits. A VF using multicast (VMOLR.ROMPE) or unicast (VMOLR.ROPE) hash
filtering relies on entries that may differ between source and
destination PFs.

Save both tables in the migration blob and compare them on load. If
the destination PF is missing entries that were present on the source,
warn and OR them into the destination, to prevent silent multicast
or unicast packet loss. Stale source entries may persist on the
destination until the L1 driver reprograms the tables.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_migration.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 hw/net/trace-events    |  1 +
 2 files changed, 78 insertions(+)

diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 7cebf3500c0f..42d2587149ef 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -60,6 +60,8 @@ typedef struct IgbMigBlob {
     IgbMigTxCtx tx_ctx[2];
     uint32_t num_vlvf;
     uint32_t vlvf[IGB_VF_MAX_VLVF_REGS];
+    uint32_t mta[E1000_MC_TBL_SIZE];
+    uint32_t uta[E1000_MC_TBL_SIZE];
 } IgbMigBlob;
 
 #define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
@@ -490,6 +492,22 @@ static int igb_core_vf_can_load_vlvf(IGBCore *core, uint16_t vfn,
     return 0;
 }
 
+static void igb_core_vf_save_hash_tables(IGBCore *core, uint16_t vfn,
+                                         IgbMigBlob *blob)
+{
+    for (int i = 0; i < E1000_MC_TBL_SIZE; i++) {
+        blob->mta[i] = cpu_to_le32(core->mac[MTA + i]);
+        blob->uta[i] = cpu_to_le32(core->mac[UTA + i]);
+
+        if (core->mac[MTA + i]) {
+            trace_igbvf_mig_save_hash_tables(vfn, "MTA", i, core->mac[MTA + i]);
+        }
+        if (core->mac[UTA + i]) {
+            trace_igbvf_mig_save_hash_tables(vfn, "UTA", i, core->mac[UTA + i]);
+        }
+    }
+}
+
 static void igb_core_vf_save_tx_ctx(IGBCore *core, int queue,
                                     IgbMigTxCtx *tx)
 {
@@ -546,6 +564,8 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
     blob->num_vlvf = cpu_to_le32(igb_core_vf_save_vlvf(core, s->vfn,
                                                         blob->vlvf));
 
+    igb_core_vf_save_hash_tables(core, s->vfn, blob);
+
     trace_igbvf_mig_save_state(s->vfn, size);
     return size;
 }
@@ -581,6 +601,61 @@ static bool igb_core_vf_validate_regs(uint16_t vfn,
     return true;
 }
 
+/*
+ * Extract a register from the incoming blob. Used in Phase 1
+ * validation where core->mac[] still holds the destination's state,
+ * not the source's.
+ */
+static uint32_t igb_core_vf_blob_get_reg(const IgbMigBlob *blob,
+                                         uint32_t offset)
+{
+    uint32_t num_regs = le32_to_cpu(blob->num_regs);
+
+    for (int i = 0; i < num_regs; i++) {
+        if (le32_to_cpu(blob->regs[i].offset) == offset) {
+            return le32_to_cpu(blob->regs[i].value);
+        }
+    }
+    return 0;
+}
+
+/*
+ * OR missing hash table entries from the source into the destination.
+ * MTA/UTA are PF-wide shared tables with no per-VF ownership, so
+ * entries present on the source may be absent on the destination.
+ */
+static bool igb_core_vf_fixup_hash_tables(IGBCore *core, uint16_t vfn,
+                                           const IgbMigBlob *blob)
+{
+    uint32_t vmolr = igb_core_vf_blob_get_reg(blob, VMOLR0 + vfn);
+    bool check_mta = vmolr & E1000_VMOLR_ROMPE;
+    bool check_uta = vmolr & E1000_VMOLR_ROPE;
+    bool fixed_up = false;
+
+    for (int i = 0; i < E1000_MC_TBL_SIZE; i++) {
+        uint32_t src_mta = le32_to_cpu(blob->mta[i]);
+        uint32_t src_uta = le32_to_cpu(blob->uta[i]);
+        uint32_t missing_mta = src_mta & ~core->mac[MTA + i];
+        uint32_t missing_uta = src_uta & ~core->mac[UTA + i];
+
+        if (missing_mta && check_mta) {
+            warn_report("igb: VF%u: MTA[%d] source 0x%x destination 0x%x"
+                        " (missing 0x%x, merged)",
+                        vfn, i, src_mta, core->mac[MTA + i], missing_mta);
+            core->mac[MTA + i] |= missing_mta;
+            fixed_up = true;
+        }
+        if (missing_uta && check_uta) {
+            warn_report("igb: VF%u: UTA[%d] source 0x%x destination 0x%x"
+                        " (missing 0x%x, merged)",
+                        vfn, i, src_uta, core->mac[UTA + i], missing_uta);
+            core->mac[UTA + i] |= missing_uta;
+            fixed_up = true;
+        }
+    }
+    return fixed_up;
+}
+
 static void igb_core_vf_load_tx_ctx(IGBCore *core, int queue,
                                     const IgbMigTxCtx *tx)
 {
@@ -705,6 +780,8 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
         }
     }
 
+    igb_core_vf_fixup_hash_tables(core, s->vfn, blob);
+
     /* Propagate VTIVAR to IVAR0, skipped by direct core->mac[] write */
     igb_core_vf_propagate_ivar(core, s->vfn);
 
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 23f6dbcfed82..a8cc72b69d0f 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -301,6 +301,7 @@ igbvf_mig_status(uint16_t vfn, uint32_t status) "VF%u: status 0x%x"
 igbvf_mig_set_state(uint16_t vfn, uint32_t old_state, uint32_t new_state) "VF%u: state %u -> %u"
 igbvf_mig_save_state(uint16_t vfn, uint32_t size) "VF%u: saved %u bytes of device state"
 igbvf_mig_load_state(uint16_t vfn, uint32_t size) "VF%u: loaded %u bytes of device state"
+igbvf_mig_save_hash_tables(uint16_t vfn, const char *name, int index, uint32_t value) "VF%u: %s[%d]=0x%x"
 igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
 
 # spapr_llan.c
-- 
2.56.0


