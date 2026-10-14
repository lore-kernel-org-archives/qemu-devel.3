Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51B2CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuf8-0006IN-QB; Wed, 14 Oct 2026 04:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueD-0005Wp-8f
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueB-0004ZW-6p
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dovLJmklrP/XG0/w/IlronUilMNkJNurI7qp8nUr/Mo=;
 b=b12GC4aTJndtpyoApsmDZAVR/2awf8fVFrKD3FY/EPfhEibgDhvmvrH9YH6/DDJvqqOO5A
 phCpUZTIe+hPfn9OS0gZTHt0GBuqwSp2HjySHh65tm90PzJFFbZ434bRxFEFG3LE32QQbr
 FT/jttPfUsRx0ViiDGG3rD84XLRcW9s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-nK0zHu00NxibmcwzZJ01hA-1; Wed,
 14 Oct 2026 08:47:31 +0000
X-MC-Unique: nK0zHu00NxibmcwzZJ01hA-1
X-Mimecast-MFC-AGG-ID: nK0zHu00NxibmcwzZJ01hA_1791967650
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A193B180061E; Wed, 14 Oct 2026 08:47:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71CD41800446; Wed, 14 Oct 2026 08:47:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 09/17] igb: Add VF VLAN filters (VLVF) serialization
Date: Wed, 14 Oct 2026 10:46:47 +0200
Message-ID: <20261014084655.127254-10-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VF VLAN filters are stored in the shared VLVF[0..31] table with
per-VF pool bits in the POOLSEL field.

On save, scan the 32 VLVF entries for this VF's pool bit and record
the VLVF register value in the migration blob. On load, clear this
VF's stale VLVF entries from the destination (removing only this VF's
pool bit, keeping entries shared with other VFs). Then place each
saved entry by VLAN ID match or free slot. Set the corresponding VFTA
bit so the global VLAN filter accepts frames for the restored VLANs.

Add dry-run validation that simulates the post-clear table state and
verifies every saved entry can be placed before any state is modified.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_migration.c | 166 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 57d750c06f4e..7cebf3500c0f 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -38,6 +38,7 @@ typedef struct IgbMigRegPair {
 
 #define IGB_VF_MAX_FIXED_REGS     64
 #define IGB_VF_MAX_RA_REGS        48  /* (16 + 8) RA entries * 2 (RAL+RAH) */
+#define IGB_VF_MAX_VLVF_REGS      E1000_VLVF_ARRAY_SIZE
 
 typedef struct IgbMigTxCtx {
     uint32_t ctx_desc[8];         /* 2 * adv_tx_context_desc (4 dwords each) */
@@ -57,6 +58,8 @@ typedef struct IgbMigBlob {
     IgbMigRegPair ra[IGB_VF_MAX_RA_REGS];
     uint32_t num_tx_ctx;
     IgbMigTxCtx tx_ctx[2];
+    uint32_t num_vlvf;
+    uint32_t vlvf[IGB_VF_MAX_VLVF_REGS];
 } IgbMigBlob;
 
 #define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
@@ -283,6 +286,93 @@ static int igb_core_vf_load_ra(IGBCore *core, uint16_t vfn,
     return 0;
 }
 
+/*
+ * Scan VLVF entries for VLAN memberships assigned to this VF.
+ * Each VLVF entry has a per-pool bitmask (POOLSEL); save entries
+ * where this VF's pool bit is set.
+ */
+static int igb_core_vf_save_vlvf(IGBCore *core, uint16_t vfn,
+                                 uint32_t *vlvf_out)
+{
+    uint32_t vf_pool_bit = BIT(vfn) << E1000_VLVF_POOLSEL_SHIFT;
+    int n = 0;
+
+    for (int i = 0; i < E1000_VLVF_ARRAY_SIZE; i++) {
+        uint32_t vlvf = core->mac[VLVF0 + i];
+
+        if ((vlvf & E1000_VLVF_VLANID_ENABLE) && (vlvf & vf_pool_bit)) {
+            vlvf_out[n++] = cpu_to_le32(vlvf);
+        }
+    }
+    return n;
+}
+
+/*
+ * Clear this VF's pool bit from all destination VLVF entries.
+ * If no pools remain after clearing, disable the entry entirely.
+ */
+static void igb_core_vf_clear_vlvf(IGBCore *core, uint16_t vfn)
+{
+    uint32_t vf_pool_bit = BIT(vfn) << E1000_VLVF_POOLSEL_SHIFT;
+
+    for (int i = 0; i < E1000_VLVF_ARRAY_SIZE; i++) {
+        uint32_t vlvf = core->mac[VLVF0 + i];
+
+        if (!(vlvf & E1000_VLVF_VLANID_ENABLE)) {
+            continue;
+        }
+
+        vlvf &= ~vf_pool_bit;
+        if (!(vlvf & E1000_VLVF_POOLSEL_MASK)) {
+            vlvf &= ~E1000_VLVF_VLANID_ENABLE;
+        }
+        core->mac[VLVF0 + i] = vlvf;
+    }
+}
+
+/*
+ * Restore VLVF entries by matching VLAN ID on the destination.
+ * Preserves other VFs' memberships and sets the VFTA bit so the
+ * global VLAN filter accepts frames for this VLAN.
+ */
+static int igb_core_vf_load_vlvf(IGBCore *core, uint16_t vfn,
+                                 const uint32_t *vlvf_in, uint32_t num)
+{
+    uint32_t vf_pool_bit = BIT(vfn) << E1000_VLVF_POOLSEL_SHIFT;
+
+    for (uint32_t i = 0; i < num; i++) {
+        uint32_t saved = le32_to_cpu(vlvf_in[i]);
+        uint16_t vlan_id = saved & E1000_VLVF_VLANID_MASK;
+        int match = -1;
+        int free_slot = -1;
+
+        for (int j = 0; j < E1000_VLVF_ARRAY_SIZE; j++) {
+            uint32_t vlvf = core->mac[VLVF0 + j];
+
+            if (vlvf & E1000_VLVF_VLANID_ENABLE) {
+                if ((vlvf & E1000_VLVF_VLANID_MASK) == vlan_id) {
+                    match = j;
+                    break;
+                }
+            } else if (free_slot < 0) {
+                free_slot = j;
+            }
+        }
+
+        if (match >= 0) {
+            core->mac[VLVF0 + match] |= vf_pool_bit;
+        } else if (free_slot >= 0) {
+            core->mac[VLVF0 + free_slot] =
+                E1000_VLVF_VLANID_ENABLE | vf_pool_bit | vlan_id;
+        } else {
+            return -IGB_MIG_ERR_BAD_DATA;
+        }
+
+        core->mac[VFTA + (vlan_id >> 5)] |= BIT(vlan_id & 0x1f);
+    }
+    return 0;
+}
+
 /*
  * Dry-run check: can all saved RA entries be placed after clearing
  * this VF's pool bits?  Simulates the clear+load without writing.
@@ -349,6 +439,57 @@ static int igb_core_vf_can_load_ra(IGBCore *core, uint16_t vfn,
     return 0;
 }
 
+/*
+ * Dry-run check: can all saved VLVF entries be placed after clearing
+ * this VF's pool bits?  Same logic as RA: sole-owner entries become
+ * free, shared entries keep their VLAN ID.
+ */
+static int igb_core_vf_can_load_vlvf(IGBCore *core, uint16_t vfn,
+                                     const uint32_t *vlvf_in, uint32_t num)
+{
+    uint32_t vf_pool_bit = BIT(vfn) << E1000_VLVF_POOLSEL_SHIFT;
+    int free_slots = 0;
+
+    for (int j = 0; j < E1000_VLVF_ARRAY_SIZE; j++) {
+        uint32_t vlvf = core->mac[VLVF0 + j];
+
+        if (!(vlvf & E1000_VLVF_VLANID_ENABLE)) {
+            free_slots++;
+        } else if ((vlvf & vf_pool_bit) &&
+                   !(vlvf & ~vf_pool_bit & E1000_VLVF_POOLSEL_MASK)) {
+            free_slots++;
+        }
+    }
+
+    for (uint32_t i = 0; i < num; i++) {
+        uint16_t vlan_id = le32_to_cpu(vlvf_in[i]) & E1000_VLVF_VLANID_MASK;
+        bool found = false;
+
+        for (int j = 0; j < E1000_VLVF_ARRAY_SIZE; j++) {
+            uint32_t vlvf = core->mac[VLVF0 + j];
+
+            if (!(vlvf & E1000_VLVF_VLANID_ENABLE)) {
+                continue;
+            }
+            if ((vlvf & vf_pool_bit) &&
+                !(vlvf & ~vf_pool_bit & E1000_VLVF_POOLSEL_MASK)) {
+                continue;
+            }
+            if ((vlvf & E1000_VLVF_VLANID_MASK) == vlan_id) {
+                found = true;
+                break;
+            }
+        }
+
+        if (!found) {
+            if (--free_slots < 0) {
+                return -IGB_MIG_ERR_UNSUPPORTED;
+            }
+        }
+    }
+    return 0;
+}
+
 static void igb_core_vf_save_tx_ctx(IGBCore *core, int queue,
                                     IgbMigTxCtx *tx)
 {
@@ -402,6 +543,9 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
 
     blob->num_ra = cpu_to_le32(igb_core_vf_save_ra(core, s->vfn, blob->ra));
 
+    blob->num_vlvf = cpu_to_le32(igb_core_vf_save_vlvf(core, s->vfn,
+                                                        blob->vlvf));
+
     trace_igbvf_mig_save_state(s->vfn, size);
     return size;
 }
@@ -509,6 +653,18 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
         }
     }
 
+    uint32_t num_vlvf = le32_to_cpu(blob->num_vlvf);
+    if (num_vlvf > IGB_VF_MAX_VLVF_REGS) {
+        return -IGB_MIG_ERR_BAD_DATA;
+    }
+    if (num_vlvf > 0) {
+        int ret = igb_core_vf_can_load_vlvf(core, s->vfn,
+                                             blob->vlvf, num_vlvf);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     /*
      * Phase 2: Apply state.  All offsets and placements are
      * validated; writes cannot fail.
@@ -539,6 +695,16 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
         }
     }
 
+    igb_core_vf_clear_vlvf(core, s->vfn);
+    if (num_vlvf > 0) {
+        int ret = igb_core_vf_load_vlvf(core, s->vfn, blob->vlvf, num_vlvf);
+        if (ret < 0) {
+            error_report("igb: VF%u: VLVF load failed after pre-validation",
+                         s->vfn);
+            return ret;
+        }
+    }
+
     /* Propagate VTIVAR to IVAR0, skipped by direct core->mac[] write */
     igb_core_vf_propagate_ivar(core, s->vfn);
 
-- 
2.56.0


