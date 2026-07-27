Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924B2C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4e-0003qb-34; Mon, 27 Jul 2026 01:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4Y-0003lt-OJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4X-0003lM-4w
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBUiIomosN7SjHQH0P/1cm4lrkCiBywj3i72g0UpvMM=;
 b=Fa3DvNGtT7nPyRlX1VEM8iOpng0ZfP7Q1PPSlwOJH5EacMNaVWD7GKttNG5Wj28aNfykw2
 MzWL5OJ4OLBBvnA5LHSx5Y7HuKqpbXoe5WYsp8octmlN7dQjfc4Ggan3P5WlbXsRqRm92N
 MttYNuXoohNdCVdtGN1uBKCGkqZ19Vo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-dMegtwUyMIqv7NDgodClOA-1; Mon,
 27 Jul 2026 01:40:10 -0400
X-MC-Unique: dMegtwUyMIqv7NDgodClOA-1
X-Mimecast-MFC-AGG-ID: dMegtwUyMIqv7NDgodClOA_1785130809
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 305531955F29; Mon, 27 Jul 2026 05:40:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89B1E1955F74; Mon, 27 Jul 2026 05:40:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 08/11] igb: Fix post-migration RX ring deadlock
Date: Mon, 27 Jul 2026 07:39:32 +0200
Message-ID: <20260727053935.1392269-9-clg@redhat.com>
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

After migration, the VF unquiesce path calls igb_start_recv() to kick
RX processing. This does not trigger an interrupt, so NAPI stays idle
and the RX ring is never replenished.

Replace igb_start_recv() with igb_core_vf_rearm_irqs(): re-apply the
VF's PVT shadow register into the PF aggregates, then raise interrupt
causes via igb_set_eics(). This follows the normal EICR -> EIMS ->
MSI-X routing. NAPI wakes, replenishes the ring via
igbvf_alloc_rx_buffers(), and writes RDT - breaking the deadlock.

The PVT re-application is needed because the L1 PF driver's normal
interrupt handling may have cleared EIMS between state load and
unquiesce.

Assisted-by: Claude
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |  1 +
 hw/net/igb_core.c      | 12 ++++++++++++
 hw/net/igb_migration.c |  2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 50cee2c7683c..3db520048732 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -147,5 +147,6 @@ igb_start_recv(IGBCore *core);
 
 IGBCore *igb_pf_get_core(void *pf);
 void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn);
+void igb_core_vf_rearm_irqs(IGBCore *core, uint16_t vfn);
 void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
 #endif
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 03c349575c0a..1621ee6602d5 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4589,6 +4589,18 @@ void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn)
     core->mac[EICR] &= ~(0x7 << shift);
 }
 
+/*
+ * Re-apply VF interrupt enables to PF aggregates and raise interrupt
+ * causes to wake NAPI so it replenishes the ring after migration.
+ */
+void igb_core_vf_rearm_irqs(IGBCore *core, uint16_t vfn)
+{
+    uint32_t shift = 22 - vfn * IGBVF_MSIX_VEC_NUM;
+
+    igb_core_vf_propagate_irqs(core, vfn);
+    igb_set_eics(core, EICS, 0x7 << shift);
+}
+
 /*
  * Re-apply VTIVAR -> IVAR0 interrupt routing. The L1 PF driver
  * may have overwritten the shared IVAR0 entries with its own
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 187077c14c48..a0b4a52c865f 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -630,7 +630,7 @@ static void igb_core_vf_unquiesce(IgbVfState *s)
     trace_igbvf_mig_unquiesce(s->vfn, core->mac[VFRE], core->mac[VFTE]);
 
     if (re) {
-        igb_start_recv(core);
+        igb_core_vf_rearm_irqs(core, s->vfn);
     }
 }
 
-- 
2.55.0


