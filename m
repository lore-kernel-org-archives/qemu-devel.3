Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954AECC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuf9-0006Qn-9P; Wed, 14 Oct 2026 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueB-0005V7-5A
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGue9-0004ZN-KX
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=595O8+K/9C42+DRysyu4BvcnrUUkujwWh4BrgXVr9Dk=;
 b=R7BWvvm0YBXVXFKT3EjTEbdOZ0WD+pNInGRw/rnaeBorYK5tp8C1nXLhHzgwPxGZckPPwK
 0UUHTLfMSdgezIiYNPvMld5725sGRcDIFDzcGravQqNPGZMupSW9ybNteqh7KKZ0PhkxmO
 C8Dt/0b23oC9fyIGILHBt0s5fVQEj5w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-1wx39ydbNbq8q0eiKPueCA-1; Wed,
 14 Oct 2026 08:47:26 +0000
X-MC-Unique: 1wx39ydbNbq8q0eiKPueCA-1
X-Mimecast-MFC-AGG-ID: 1wx39ydbNbq8q0eiKPueCA_1791967645
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C1C419560BE; Wed, 14 Oct 2026 08:47:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26F5718001CA; Wed, 14 Oct 2026 08:47:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 07/17] igb: Add VF TX context state serialization
Date: Wed, 14 Oct 2026 10:46:45 +0200
Message-ID: <20261014084655.127254-8-clg@redhat.com>
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

Save and restore the per-queue TX context descriptors and in-flight
packet state for each of the VF's two TX queues. Without this, a
partially described packet would be malformed or dropped on the
destination after migration.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_migration.c | 64 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 831515639bd6..d0414ac89a28 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -37,12 +37,22 @@ typedef struct IgbMigRegPair {
 
 #define IGB_VF_MAX_FIXED_REGS     64
 
+typedef struct IgbMigTxCtx {
+    uint32_t ctx_desc[8];         /* 2 * adv_tx_context_desc (4 dwords each) */
+    uint32_t first_cmd_type_len;
+    uint32_t first_olinfo_status;
+    uint32_t first;
+    uint32_t skip_cp;
+} IgbMigTxCtx;
+
 typedef struct IgbMigBlob {
     uint32_t magic;
     uint32_t version;
     uint32_t vfn;
     uint32_t num_regs;
     IgbMigRegPair regs[IGB_VF_MAX_FIXED_REGS];
+    uint32_t num_tx_ctx;
+    IgbMigTxCtx tx_ctx[2];
 } IgbMigBlob;
 
 #define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
@@ -140,6 +150,23 @@ static int igb_vf_reg_list(uint16_t vfn, uint32_t *offsets)
     return n;
 }
 
+static void igb_core_vf_save_tx_ctx(IGBCore *core, int queue,
+                                    IgbMigTxCtx *tx)
+{
+    struct igb_tx *src = &core->tx[queue];
+
+    for (int i = 0; i < 2; i++) {
+        tx->ctx_desc[i * 4 + 0] = cpu_to_le32(src->ctx[i].vlan_macip_lens);
+        tx->ctx_desc[i * 4 + 1] = cpu_to_le32(src->ctx[i].seqnum_seed);
+        tx->ctx_desc[i * 4 + 2] = cpu_to_le32(src->ctx[i].type_tucmd_mlhl);
+        tx->ctx_desc[i * 4 + 3] = cpu_to_le32(src->ctx[i].mss_l4len_idx);
+    }
+    tx->first_cmd_type_len = cpu_to_le32(src->first_cmd_type_len);
+    tx->first_olinfo_status = cpu_to_le32(src->first_olinfo_status);
+    tx->first = cpu_to_le32(src->first);
+    tx->skip_cp = cpu_to_le32(src->skip_cp);
+}
+
 static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
 {
     int size = IGB_MIG_BLOB_SIZE;
@@ -147,6 +174,8 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
     IgbMigBlob *blob = buf;
     uint32_t offsets[IGB_VF_MAX_FIXED_REGS];
     int num_regs;
+    int q0 = s->vfn;
+    int q1 = s->vfn + IGB_NUM_VM_POOLS;
 
     num_regs = igb_vf_reg_list(s->vfn, offsets);
 
@@ -168,6 +197,10 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
         blob->regs[i].value = cpu_to_le32(core->mac[offsets[i]]);
     }
 
+    blob->num_tx_ctx = cpu_to_le32(2);
+    igb_core_vf_save_tx_ctx(core, q0, &blob->tx_ctx[0]);
+    igb_core_vf_save_tx_ctx(core, q1, &blob->tx_ctx[1]);
+
     trace_igbvf_mig_save_state(s->vfn, size);
     return size;
 }
@@ -203,9 +236,32 @@ static bool igb_core_vf_validate_regs(uint16_t vfn,
     return true;
 }
 
+static void igb_core_vf_load_tx_ctx(IGBCore *core, int queue,
+                                    const IgbMigTxCtx *tx)
+{
+    struct igb_tx *dst = &core->tx[queue];
+
+    /*
+     * Preserve the destination's tx_pkt - it's a host-side object,
+     * not guest state
+     */
+    for (int i = 0; i < 2; i++) {
+        dst->ctx[i].vlan_macip_lens = le32_to_cpu(tx->ctx_desc[i * 4 + 0]);
+        dst->ctx[i].seqnum_seed    = le32_to_cpu(tx->ctx_desc[i * 4 + 1]);
+        dst->ctx[i].type_tucmd_mlhl = le32_to_cpu(tx->ctx_desc[i * 4 + 2]);
+        dst->ctx[i].mss_l4len_idx  = le32_to_cpu(tx->ctx_desc[i * 4 + 3]);
+    }
+    dst->first_cmd_type_len = le32_to_cpu(tx->first_cmd_type_len);
+    dst->first_olinfo_status = le32_to_cpu(tx->first_olinfo_status);
+    dst->first = le32_to_cpu(tx->first);
+    dst->skip_cp = le32_to_cpu(tx->skip_cp);
+}
+
 static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
 {
     IGBCore *core = igbvf_get_core(s);
+    int q0 = s->vfn;
+    int q1 = s->vfn + IGB_NUM_VM_POOLS;
     const IgbMigBlob *blob = buf;
     uint32_t magic, version, saved_vfn, num_regs;
 
@@ -236,6 +292,11 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
         return -IGB_MIG_ERR_BAD_DATA;
     }
 
+    uint32_t num_tx = le32_to_cpu(blob->num_tx_ctx);
+    if (num_tx != 2) {
+        return -IGB_MIG_ERR_BAD_DATA;
+    }
+
     /*
      * Phase 2: Apply state.  All offsets and placements are
      * validated; writes cannot fail.
@@ -253,6 +314,9 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
         }
     }
 
+    igb_core_vf_load_tx_ctx(core, q0, &blob->tx_ctx[0]);
+    igb_core_vf_load_tx_ctx(core, q1, &blob->tx_ctx[1]);
+
     /* Propagate VTIVAR to IVAR0, skipped by direct core->mac[] write */
     igb_core_vf_propagate_ivar(core, s->vfn);
 
-- 
2.56.0


