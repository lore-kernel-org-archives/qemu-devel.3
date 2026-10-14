Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044F1CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuew-0005v2-RP; Wed, 14 Oct 2026 04:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueD-0005Wn-89
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGue9-0004ZJ-DT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFWUKH2yvTE2qXkLbAJ6mhYut9W43/WbY2IFGiCLzSw=;
 b=e4cyatg9UDZyxmpWRYeb4oW7ZaWxUw1e4gv7YsgYmajY306RAc23f++aMhY5EbUO+AUWT0
 3eXdW7c7HX4137087PmbUQffvLMpRGBeBBkX/nhzKS7d3pPKq1rZ/q8Og995y8leyOHg4r
 tVLPpQhhW9cjX00rWUWE8p6FUW163TM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-MXg-YrwnMXqhQJht3cN0JA-1; Wed,
 14 Oct 2026 08:47:29 +0000
X-MC-Unique: MXg-YrwnMXqhQJht3cN0JA-1
X-Mimecast-MFC-AGG-ID: MXg-YrwnMXqhQJht3cN0JA_1791967648
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3DF6180059A; Wed, 14 Oct 2026 08:47:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C642718001CA; Wed, 14 Oct 2026 08:47:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 08/17] igb: Add VF RA entries state serialization
Date: Wed, 14 Oct 2026 10:46:46 +0200
Message-ID: <20261014084655.127254-9-clg@redhat.com>
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

The receive address (RA) table is scanned linearly by the hardware
during RX filtering, so slot indices are irrelevant to the VF. The
PF driver picks the slot when the VF requests a MAC address via the
mailbox.

On save, scan the RA/RA2 banks for entries whose pool bits include
this VF. On load, clear this VF's stale RA entries from the
destination (removing only this VF's pool bit, keeping entries shared
with other VFs). Then place each saved entry by MAC address match or
free slot.

Add dry-run validation that simulates the post-clear table state and
verifies every saved entry can be placed before any state is modified.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_migration.h |   1 +
 hw/net/igb_migration.c | 222 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 223 insertions(+)

diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index d05252992f9e..676ec2d78301 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -77,6 +77,7 @@
 #define IGB_MIG_ERR_BAD_VERSION         7
 #define IGB_MIG_ERR_BAD_VFN             8
 #define IGB_MIG_ERR_BAD_DATA            9
+#define IGB_MIG_ERR_UNSUPPORTED         10
 
 /* Shared buffer constants */
 #define IGB_VF_STATE_MAX_SIZE           4096
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index d0414ac89a28..57d750c06f4e 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie.h"
 #include "net/eth.h"
@@ -36,6 +37,7 @@ typedef struct IgbMigRegPair {
 } IgbMigRegPair;
 
 #define IGB_VF_MAX_FIXED_REGS     64
+#define IGB_VF_MAX_RA_REGS        48  /* (16 + 8) RA entries * 2 (RAL+RAH) */
 
 typedef struct IgbMigTxCtx {
     uint32_t ctx_desc[8];         /* 2 * adv_tx_context_desc (4 dwords each) */
@@ -51,6 +53,8 @@ typedef struct IgbMigBlob {
     uint32_t vfn;
     uint32_t num_regs;
     IgbMigRegPair regs[IGB_VF_MAX_FIXED_REGS];
+    uint32_t num_ra;
+    IgbMigRegPair ra[IGB_VF_MAX_RA_REGS];
     uint32_t num_tx_ctx;
     IgbMigTxCtx tx_ctx[2];
 } IgbMigBlob;
@@ -150,6 +154,201 @@ static int igb_vf_reg_list(uint16_t vfn, uint32_t *offsets)
     return n;
 }
 
+static const struct {
+    uint32_t base;
+    int count;
+} ra_banks[] = {
+    { RA,  16 },
+    { RA2,  8 },
+};
+
+static int igb_core_vf_save_ra(IGBCore *core, uint16_t vfn,
+                               IgbMigRegPair *regs)
+{
+    uint32_t vf_pool_bit = E1000_RAH_POOL_1 << vfn;
+    int n = 0;
+
+    for (int i = 0; i < ARRAY_SIZE(ra_banks); i++) {
+        for (int j = 0; j < ra_banks[i].count; j++) {
+            uint32_t ral_off = ra_banks[i].base + j * 2;
+            uint32_t rah_off = ra_banks[i].base + j * 2 + 1;
+            uint32_t rah_val = core->mac[rah_off];
+
+            if ((rah_val & E1000_RAH_AV) && (rah_val & vf_pool_bit)) {
+                regs[n].offset = cpu_to_le32(ral_off);
+                regs[n].value = cpu_to_le32(core->mac[ral_off]);
+                n++;
+                regs[n].offset = cpu_to_le32(rah_off);
+                regs[n].value = cpu_to_le32(rah_val);
+                n++;
+            }
+        }
+    }
+    return n;
+}
+
+/*
+ * Remove this VF's pool bit from all RA entries. If no pool bits
+ * remain the entry is unused; clear it entirely. This preserves other
+ * VFs' entries that may share the same RA slot (e.g. a multicast
+ * address used by multiple VFs).
+ */
+static void igb_core_vf_clear_ra(IGBCore *core, uint16_t vfn)
+{
+    uint32_t vf_pool_bit = E1000_RAH_POOL_1 << vfn;
+
+    for (int i = 0; i < ARRAY_SIZE(ra_banks); i++) {
+        for (int j = 0; j < ra_banks[i].count; j++) {
+            uint32_t ral_off = ra_banks[i].base + j * 2;
+            uint32_t rah_off = ra_banks[i].base + j * 2 + 1;
+            uint32_t rah_val = core->mac[rah_off];
+
+            if (!(rah_val & E1000_RAH_AV) || !(rah_val & vf_pool_bit)) {
+                continue;
+            }
+
+            rah_val &= ~vf_pool_bit;
+            if (!(rah_val & E1000_RAH_POOL_MASK)) {
+                core->mac[ral_off] = 0;
+                core->mac[rah_off] = 0;
+            } else {
+                core->mac[rah_off] = rah_val;
+            }
+        }
+    }
+}
+
+/*
+ * The hardware scans all RA/RA2 entries during RX filtering and
+ * the VF driver has no awareness of which slot is used, so the L1
+ * PF driver picks the slot.  So the slot index is meaningless
+ * across migration; only the MAC + pool bit matters.
+ *
+ * For each saved entry:
+ *   1. Find a destination slot with the same MAC and add this VF's
+ *      pool bit (preserves other VFs sharing the address).
+ *   2. Otherwise allocate a free slot.
+ *   3. Reject if the RA table is full.
+ */
+static int igb_core_vf_load_ra(IGBCore *core, uint16_t vfn,
+                                const IgbMigRegPair *ra_pairs,
+                                uint32_t num_ra)
+{
+    uint32_t vf_pool_bit = E1000_RAH_POOL_1 << vfn;
+
+    /* RA entries are saved as (RAL, RAH) pairs */
+    for (uint32_t p = 0; p + 1 < num_ra; p += 2) {
+        uint32_t saved_ral = le32_to_cpu(ra_pairs[p].value);
+        uint32_t saved_rah = le32_to_cpu(ra_pairs[p + 1].value);
+        uint16_t saved_mac_hi = saved_rah & 0xFFFF;
+        int match = -1;
+        int free_slot_bank = -1;
+        int free_slot_idx = -1;
+
+        for (int i = 0; i < ARRAY_SIZE(ra_banks); i++) {
+            for (int j = 0; j < ra_banks[i].count; j++) {
+                uint32_t ral_off = ra_banks[i].base + j * 2;
+                uint32_t rah_off = ra_banks[i].base + j * 2 + 1;
+                uint32_t rah_val = core->mac[rah_off];
+
+                if (rah_val & E1000_RAH_AV) {
+                    if (core->mac[ral_off] == saved_ral &&
+                        (rah_val & 0xFFFF) == saved_mac_hi) {
+                        match = rah_off;
+                        break;
+                    }
+                } else if (free_slot_bank < 0) {
+                    free_slot_bank = i;
+                    free_slot_idx = j;
+                }
+            }
+            if (match >= 0) {
+                break;
+            }
+        }
+
+        if (match >= 0) {
+            core->mac[match] |= vf_pool_bit;
+        } else if (free_slot_bank >= 0) {
+            uint32_t ral_off = ra_banks[free_slot_bank].base +
+                               free_slot_idx * 2;
+            uint32_t rah_off = ral_off + 1;
+            core->mac[ral_off] = saved_ral;
+            core->mac[rah_off] = (saved_rah & 0xFFFF) |
+                                 E1000_RAH_AV | vf_pool_bit;
+        } else {
+            return -IGB_MIG_ERR_BAD_DATA;
+        }
+    }
+    return 0;
+}
+
+/*
+ * Dry-run check: can all saved RA entries be placed after clearing
+ * this VF's pool bits?  Simulates the clear+load without writing.
+ *
+ * After clear, sole-owner entries are zeroed (becoming free slots)
+ * and shared entries just lose this VF's pool bit but keep their MAC.
+ * For each saved entry we check whether a MAC match survives in the
+ * post-clear state; entries that do not match need a free slot.
+ */
+static int igb_core_vf_can_load_ra(IGBCore *core, uint16_t vfn,
+                                   const IgbMigRegPair *ra_pairs,
+                                   uint32_t num_ra)
+{
+    uint32_t vf_pool_bit = E1000_RAH_POOL_1 << vfn;
+    int free_slots = 0;
+
+    for (int i = 0; i < ARRAY_SIZE(ra_banks); i++) {
+        for (int j = 0; j < ra_banks[i].count; j++) {
+            uint32_t rah_off = ra_banks[i].base + j * 2 + 1;
+            uint32_t rah_val = core->mac[rah_off];
+
+            if (!(rah_val & E1000_RAH_AV)) {
+                free_slots++;
+            } else if ((rah_val & vf_pool_bit) &&
+                       !(rah_val & ~vf_pool_bit & E1000_RAH_POOL_MASK)) {
+                free_slots++;
+            }
+        }
+    }
+
+    for (uint32_t p = 0; p + 1 < num_ra; p += 2) {
+        uint32_t saved_ral = le32_to_cpu(ra_pairs[p].value);
+        uint16_t saved_mac_hi = le32_to_cpu(ra_pairs[p + 1].value) & 0xFFFF;
+        bool found = false;
+
+        for (int i = 0; i < ARRAY_SIZE(ra_banks) && !found; i++) {
+            for (int j = 0; j < ra_banks[i].count; j++) {
+                uint32_t ral_off = ra_banks[i].base + j * 2;
+                uint32_t rah_off = ra_banks[i].base + j * 2 + 1;
+                uint32_t rah_val = core->mac[rah_off];
+
+                if (!(rah_val & E1000_RAH_AV)) {
+                    continue;
+                }
+                /* Sole-owner entries will be zeroed by clear */
+                if ((rah_val & vf_pool_bit) &&
+                    !(rah_val & ~vf_pool_bit & E1000_RAH_POOL_MASK)) {
+                    continue;
+                }
+                if (core->mac[ral_off] == saved_ral &&
+                    (rah_val & 0xFFFF) == saved_mac_hi) {
+                    found = true;
+                    break;
+                }
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
@@ -201,6 +400,8 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
     igb_core_vf_save_tx_ctx(core, q0, &blob->tx_ctx[0]);
     igb_core_vf_save_tx_ctx(core, q1, &blob->tx_ctx[1]);
 
+    blob->num_ra = cpu_to_le32(igb_core_vf_save_ra(core, s->vfn, blob->ra));
+
     trace_igbvf_mig_save_state(s->vfn, size);
     return size;
 }
@@ -297,6 +498,17 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
         return -IGB_MIG_ERR_BAD_DATA;
     }
 
+    uint32_t num_ra = le32_to_cpu(blob->num_ra);
+    if (num_ra > IGB_VF_MAX_RA_REGS || (num_ra & 1)) {
+        return -IGB_MIG_ERR_BAD_DATA;
+    }
+    if (num_ra > 0) {
+        int ret = igb_core_vf_can_load_ra(core, s->vfn, blob->ra, num_ra);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     /*
      * Phase 2: Apply state.  All offsets and placements are
      * validated; writes cannot fail.
@@ -317,6 +529,16 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
     igb_core_vf_load_tx_ctx(core, q0, &blob->tx_ctx[0]);
     igb_core_vf_load_tx_ctx(core, q1, &blob->tx_ctx[1]);
 
+    igb_core_vf_clear_ra(core, s->vfn);
+    if (num_ra > 0) {
+        int ret = igb_core_vf_load_ra(core, s->vfn, blob->ra, num_ra);
+        if (ret < 0) {
+            error_report("igb: VF%u: RA load failed after pre-validation",
+                         s->vfn);
+            return ret;
+        }
+    }
+
     /* Propagate VTIVAR to IVAR0, skipped by direct core->mac[] write */
     igb_core_vf_propagate_ivar(core, s->vfn);
 
-- 
2.56.0


