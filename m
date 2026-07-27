Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCECC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4U-0003ZU-Fp; Mon, 27 Jul 2026 01:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4N-0003G8-Tp
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4M-0003jR-8I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k0a1wivckEfS8wGNJKXHzTIYJDleTc2ip6NMFUsCIMc=;
 b=iUshBrrXsWa5ID9BmlqIJA6qvRjB2+DRCz9tL51VKXO5z2XWixgqx9jEUr3kqTPodiyIb2
 lJ/gkIw4jKt1T0bTCNFPh7KbWoxv3VPrrqwH4X/qbvUewrAZYUVhDQu6OBVKzCSUQHkwhS
 ZrdBzU393CO/VPEUfV262N1f71fA6fs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-FZ_DUatdMBypug5zSgj6tw-1; Mon,
 27 Jul 2026 01:40:01 -0400
X-MC-Unique: FZ_DUatdMBypug5zSgj6tw-1
X-Mimecast-MFC-AGG-ID: FZ_DUatdMBypug5zSgj6tw_1785130800
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D95871955F22; Mon, 27 Jul 2026 05:39:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71EC31956088; Mon, 27 Jul 2026 05:39:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 05/11] igb: Add VF post-load fixups for live migration
Date: Mon, 27 Jul 2026 07:39:29 +0200
Message-ID: <20260727053935.1392269-6-clg@redhat.com>
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
References: <20260727053935.1392269-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Add post-load fixups in igbvf_mig_load() to propagate VF interrupt
state that the register load path bypasses by writing directly to
mac[] without triggering register handler side effects.

igb_core_vf_propagate_irqs() ORs PVT shadow values back into the PF
aggregates (EIMS/EIAC/EIAM) and clears stale VF bits from EICR.

igb_core_vf_propagate_ivar() re-applies VTIVAR routing to the shared
IVAR0 entries that the L1 PF driver may have overwritten after L0
vmstate restore.

Assisted-by: Claude
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |  2 ++
 hw/net/igb_core.c      | 56 ++++++++++++++++++++++++++++++++++++++++++
 hw/net/igb_migration.c |  7 ++++++
 3 files changed, 65 insertions(+)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 58d4f57c99bb..150567eb346d 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -144,4 +144,6 @@ void
 igb_start_recv(IGBCore *core);
 
 IGBCore *igb_pf_get_core(void *pf);
+void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn);
+void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
 #endif
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 45d8fd795b84..2565dd7f96d3 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4550,3 +4550,59 @@ igb_core_post_load(IGBCore *core)
 
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
+    uint32_t pvt_idx;
+
+    pvt_idx = PVTEIMS0 + vfn * 0x40;
+    core->mac[EIMS] |= (core->mac[pvt_idx] & 0x7) << shift;
+    pvt_idx = PVTEIAC0 + vfn * 0x40;
+    core->mac[EIAC] |= (core->mac[pvt_idx] & 0x7) << shift;
+    pvt_idx = PVTEIAM0 + vfn * 0x40;
+    core->mac[EIAM] |= (core->mac[pvt_idx] & 0x7) << shift;
+
+    core->mac[EICR] &= ~(0x7 << shift);
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
+    if (vtivar & E1000_IVAR_VALID) {
+        n = igb_ivar_entry_rx(vfn);
+        ent = E1000_IVAR_VALID |
+              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (vtivar & 0x7)));
+        mask = 0xffU << (8 * (n % 4));
+        core->mac[IVAR0 + n / 4] =
+            (core->mac[IVAR0 + n / 4] & ~mask) |
+            ((uint32_t)ent << (8 * (n % 4)));
+    }
+
+    ent = vtivar >> 8;
+    if (ent & E1000_IVAR_VALID) {
+        n = igb_ivar_entry_tx(vfn);
+        ent = E1000_IVAR_VALID |
+              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (ent & 0x7)));
+        mask = 0xffU << (8 * (n % 4));
+        core->mac[IVAR0 + n / 4] =
+            (core->mac[IVAR0 + n / 4] & ~mask) |
+            ((uint32_t)ent << (8 * (n % 4)));
+    }
+}
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 61cf155a188d..4f123df6795d 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -382,6 +382,7 @@ static int igb_core_vf_load_state(IgbVfState *s,
 
 static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
 {
+    IGBCore *core = igbvf_get_core(s);
     int ret;
 
     ret = igb_core_vf_load_state(s, buf, size);
@@ -389,6 +390,12 @@ static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
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


