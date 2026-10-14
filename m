Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976CBCC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuf4-00068E-O1; Wed, 14 Oct 2026 04:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueM-0005bH-DK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueK-0004aC-FU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vy0Tf7aWlxD9+XRsYRHPkPvTpIAuohr7R2Rk3JZXnSU=;
 b=SUhBM36+TQUUWBJdBkrwGsR3FR2bxV4tWGBYYm8YCkKf0K+paYZdkE+y4QZl5mRPnnF23p
 8LXKA+gE1rdTkk8uZ1x4RhnTBzQmC1sfuWGMANN5+dVWX1I24CQ+9nGuf8Sf1Rp6oATXT4
 SKCD3gpgFCn0cAPpy6hCWhvK2z3r0h8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-dAvgJxoaN4COjFxbWRRC-g-1; Wed,
 14 Oct 2026 08:47:44 +0000
X-MC-Unique: dAvgJxoaN4COjFxbWRRC-g-1
X-Mimecast-MFC-AGG-ID: dAvgJxoaN4COjFxbWRRC-g_1791967663
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AF65180058A; Wed, 14 Oct 2026 08:47:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F1F81800345; Wed, 14 Oct 2026 08:47:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 13/17] igb: Save and restore effective VF interrupt
 masks for migration
Date: Wed, 14 Oct 2026 10:46:51 +0200
Message-ID: <20261014084655.127254-14-clg@redhat.com>
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

The PVT shadow registers (PVTEIMS/PVTEIAC/PVTEIAM) record the last VF
write, not the effective accumulated state. The actual effective mask
lives in the PF aggregate EIMS/EIAC/EIAM registers.

Capture the VF's effective mask bits from the PF aggregates at quiesce
entry, before disabling VFRE/VFTE. Store them in the blob and restore
via igb_core_vf_restore_irqs() on unquiesce paths.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_migration.h |  3 ++
 hw/net/igb_migration.c | 68 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index 841fc512d228..96dfe99468d1 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -108,6 +108,9 @@ typedef struct IgbVfMigState {
     uint64_t mig_data_buf_addr;
     bool mig_saved_vfre;
     bool mig_saved_vfte;
+    uint32_t mig_saved_eims;
+    uint32_t mig_saved_eiac;
+    uint32_t mig_saved_eiam;
 } IgbVfMigState;
 
 #define IGB_MIG_DIRTY_DEFAULT_PGSIZE        4096
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 80098e62daea..72f01beb2ad0 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -66,6 +66,9 @@ typedef struct IgbMigBlob {
     uint32_t uta[E1000_MC_TBL_SIZE];
     uint32_t vfre;
     uint32_t vfte;
+    uint32_t eims_bits;
+    uint32_t eiac_bits;
+    uint32_t eiam_bits;
 } IgbMigBlob;
 
 #define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
@@ -574,6 +577,14 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
     blob->vfre = cpu_to_le32(ms->mig_saved_vfre);
     blob->vfte = cpu_to_le32(ms->mig_saved_vfte);
 
+    /*
+     * Save VF's effective interrupt mask bits captured at quiesce
+     * entry, before VFRE/VFTE were disabled.
+     */
+    blob->eims_bits = cpu_to_le32(ms->mig_saved_eims);
+    blob->eiac_bits = cpu_to_le32(ms->mig_saved_eiac);
+    blob->eiam_bits = cpu_to_le32(ms->mig_saved_eiam);
+
     trace_igbvf_mig_save_state(s->vfn, size, ms->mig_saved_vfre,
                                ms->mig_saved_vfte,
                                core->mac[VFRE]);
@@ -798,6 +809,9 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
 
     ms->mig_saved_vfre = !!le32_to_cpu(blob->vfre);
     ms->mig_saved_vfte = !!le32_to_cpu(blob->vfte);
+    ms->mig_saved_eims = le32_to_cpu(blob->eims_bits) & 0x7;
+    ms->mig_saved_eiac = le32_to_cpu(blob->eiac_bits) & 0x7;
+    ms->mig_saved_eiam = le32_to_cpu(blob->eiam_bits) & 0x7;
 
     trace_igbvf_mig_load_state(s->vfn, (uint32_t)size,
                                ms->mig_saved_vfre,
@@ -1190,12 +1204,58 @@ static uint8_t igbvf_mig_cmd_load(IgbVfState *s, uint32_t data_size)
     return 0;
 }
 
+/*
+ * Extended Interrupt registers
+ *
+ * EIMS Mask Set       enable interrupt vectors (unmasked)
+ * EIAC Auto Clear     auto-clear vectors in EICR on delivery
+ * EIAM Auto Mask      auto-mask vectors (clear EIMS) on delivery
+ *
+ * All three are PF-wide aggregate registers. Each VF owns 3 bits (one
+ * per MSI-X vector) at position (22 - vfn*3). The VF writes to PVT
+ * shadows (PVTEIMS etc.) which the register handler ORs into the
+ * aggregates but EIMC clears the aggregate without updating the
+ * shadow.
+ */
+static void igb_core_vf_save_irqs(IGBCore *core, uint16_t vfn,
+                                  uint32_t *eims, uint32_t *eiac,
+                                  uint32_t *eiam)
+{
+    uint32_t shift = 22 - vfn * IGBVF_MSIX_VEC_NUM;
+
+    *eims = (core->mac[EIMS] >> shift) & 0x7;
+    *eiac = (core->mac[EIAC] >> shift) & 0x7;
+    *eiam = (core->mac[EIAM] >> shift) & 0x7;
+}
+
+static void igb_core_vf_restore_irqs(IGBCore *core, uint16_t vfn,
+                                     uint32_t eims, uint32_t eiac,
+                                     uint32_t eiam)
+{
+    uint32_t shift = 22 - vfn * IGBVF_MSIX_VEC_NUM;
+    uint32_t vf_mask = 0x7u << shift;
+
+    core->mac[EIMS] = (core->mac[EIMS] & ~vf_mask) | ((eims & 0x7) << shift);
+    core->mac[EIAC] = (core->mac[EIAC] & ~vf_mask) | ((eiac & 0x7) << shift);
+    core->mac[EIAM] = (core->mac[EIAM] & ~vf_mask) | ((eiam & 0x7) << shift);
+    core->mac[EICR] &= ~vf_mask;
+}
+
 /* Quiesce a VF by disabling its RX and TX at the PF level. */
 static void igb_core_vf_quiesce(IgbVfState *s)
 {
     IgbVfMigState *ms = &s->mig;
     IGBCore *core = igbvf_get_core(s);
 
+    /*
+     * Capture effective interrupt mask bits from PF aggregates before
+     * quiescing.  PVT shadows only record the last write, not the
+     * accumulated state.
+     */
+    igb_core_vf_save_irqs(core, s->vfn,
+                          &ms->mig_saved_eims, &ms->mig_saved_eiac,
+                          &ms->mig_saved_eiam);
+
     ms->mig_saved_vfre = !!(core->mac[VFRE] & BIT(s->vfn));
     ms->mig_saved_vfte = !!(core->mac[VFTE] & BIT(s->vfn));
 
@@ -1224,7 +1284,13 @@ static void igb_core_vf_unquiesce(IgbVfState *s)
 
     trace_igbvf_mig_unquiesce(s->vfn, core->mac[VFRE], core->mac[VFTE]);
 
-    /* Interrupt mask restore and pending cause re-raise added later. */
+    /*
+     * Restore VF's effective interrupt mask bits into PF aggregate
+     * registers.
+     */
+    igb_core_vf_restore_irqs(core, s->vfn,
+                             ms->mig_saved_eims, ms->mig_saved_eiac,
+                             ms->mig_saved_eiam);
 }
 
 static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
-- 
2.56.0


