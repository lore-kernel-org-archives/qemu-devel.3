Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F04AC624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qWT-0004K9-6P; Wed, 02 Sep 2026 15:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1qWQ-0004Jl-1T
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1qWO-000271-37
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788376879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbLCMWNmPBdl2Wk4lrVEwwfNX8cyJ+dKTeNJ77eaiLQ=;
 b=O+CVTjsxWrX6YIQwt76uvxp+aztNnQw5hT+VSeHPwtuhAcdxtb6TLnwRj8/qvPRi2nJqyP
 HRLcjF6V4ji3WyByNwfQHpTyG5GtctVWrqEMAZw1eIk+4vNwHz2TSfM/EMiberVgzKqQ9m
 1nDzYf6EFpOED0DQD+i0LoGHD7Nmo18=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-Q5NGRpAlOpCH3bTL0JeS9A-1; Wed,
 02 Sep 2026 15:21:14 -0400
X-MC-Unique: Q5NGRpAlOpCH3bTL0JeS9A-1
X-Mimecast-MFC-AGG-ID: Q5NGRpAlOpCH3bTL0JeS9A_1788376873
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 264151828B1D; Wed,  2 Sep 2026 19:21:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A2E23001D39; Wed,  2 Sep 2026 19:21:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v2 4/9] igb: Add VF post-load fixups for live migration
Date: Wed,  2 Sep 2026 21:20:49 +0200
Message-ID: <20260902192054.3329753-5-clg@redhat.com>
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

After restoring per-VF register state, propagate the VF's PVT shadow
values back into the PF's aggregate EIMS/EIAC/EIAM registers and
re-apply the VTIVAR interrupt vector routing to the shared IVAR0.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |  3 ++
 hw/net/igb_core.c      | 66 ++++++++++++++++++++++++++++++++++++++++++
 hw/net/igb_migration.c |  7 +++++
 3 files changed, 76 insertions(+)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 60724e2824ab..22e10e4e6d0b 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -145,4 +145,7 @@ igb_start_recv(IGBCore *core);
 
 IGBCore *igb_pf_get_core(void *pf);
 
+void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn);
+void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
+
 #endif
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 2a4883907353..01745fe756d0 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4552,3 +4552,69 @@ igb_core_post_load(IGBCore *core)
 
     return 0;
 }
+
+/*
+ * Propagate VF interrupt state to PF aggregates after loading VF
+ * registers. The load path writes directly to mac[] bypassing the
+ * register handlers that OR VF bits into EIMS/EIAC/EIAM. Also clear
+ * stale VF bits in EICR that may have been set by packets arriving
+ * between PF vmstate restore and VF state load.
+ */
+void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn)
+{
+    uint32_t shift = 22 - vfn * IGBVF_MSIX_VEC_NUM;
+    uint32_t vf_mask = 0x7 << shift;
+    uint32_t pvt_idx;
+
+    core->mac[EIMS] &= ~vf_mask;
+    pvt_idx = PVTEIMS0 + vfn * 0x40;
+    core->mac[EIMS] |= (core->mac[pvt_idx] & 0x7) << shift;
+
+    core->mac[EIAC] &= ~vf_mask;
+    pvt_idx = PVTEIAC0 + vfn * 0x40;
+    core->mac[EIAC] |= (core->mac[pvt_idx] & 0x7) << shift;
+
+    core->mac[EIAM] &= ~vf_mask;
+    pvt_idx = PVTEIAM0 + vfn * 0x40;
+    core->mac[EIAM] |= (core->mac[pvt_idx] & 0x7) << shift;
+
+    core->mac[EICR] &= ~vf_mask;
+}
+
+/*
+ * Re-apply VTIVAR -> IVAR0 interrupt routing. The L1 PF driver
+ * may have overwritten the shared IVAR0 entries with its own
+ * queue routing after L0 vmstate restore.
+ */
+void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn)
+{
+    uint32_t vtivar = core->mac[VTIVAR + vfn];
+    int n;
+    uint8_t ent;
+    uint32_t mask;
+
+    n = igb_ivar_entry_rx(vfn);
+    mask = 0xffU << (8 * (n % 4));
+    if (vtivar & E1000_IVAR_VALID) {
+        ent = E1000_IVAR_VALID |
+              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (vtivar & 0x7)));
+        core->mac[IVAR0 + n / 4] =
+            (core->mac[IVAR0 + n / 4] & ~mask) |
+            ((uint32_t)ent << (8 * (n % 4)));
+    } else {
+        core->mac[IVAR0 + n / 4] &= ~mask;
+    }
+
+    n = igb_ivar_entry_tx(vfn);
+    mask = 0xffU << (8 * (n % 4));
+    ent = vtivar >> 8;
+    if (ent & E1000_IVAR_VALID) {
+        ent = E1000_IVAR_VALID |
+              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (ent & 0x7)));
+        core->mac[IVAR0 + n / 4] =
+            (core->mac[IVAR0 + n / 4] & ~mask) |
+            ((uint32_t)ent << (8 * (n % 4)));
+    } else {
+        core->mac[IVAR0 + n / 4] &= ~mask;
+    }
+}
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index c34035974620..af7257ccc4fd 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -384,12 +384,19 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
 static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
 {
     int ret;
+    IGBCore *core = igbvf_get_core(s);
 
     ret = igb_core_vf_load_state(s, buf, size);
     if (ret < 0) {
         return ret;
     }
 
+    /*
+     * Post-load: sync VF interrupt and routing state to PF aggregates
+     */
+    igb_core_vf_propagate_irqs(core, s->vfn);
+    igb_core_vf_propagate_ivar(core, s->vfn);
+
     return 0;
 }
 
-- 
2.55.0


