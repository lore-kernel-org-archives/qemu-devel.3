Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641EEE95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBZ-0000zH-7H; Wed, 04 Feb 2026 05:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBB-0000W5-0R
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaB9-00040I-FT
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7Atyj11676Wf8rX59hlQrA0WLzWIVMmtBR8jsGIaSM=;
 b=JjEWuxSSOvtr6reUohtrScTCDs9T7mPxAp6xo4iIYuVs0u6J+fPHVB/ghRBXJxkfcKQ601
 6y8GAy4y2urH85d89l4RbCa8Krf5dngEv/KPo9oarKwcwXp9LzEmFXK5AZlBVo38KC7+Lh
 6We40JZZLf2HiCxOaD7simbTTjom0XY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-w38JhJYaNEO7I8g-Fxsc9Q-1; Wed,
 04 Feb 2026 05:32:07 -0500
X-MC-Unique: w38JhJYaNEO7I8g-Fxsc9Q-1
X-Mimecast-MFC-AGG-ID: w38JhJYaNEO7I8g-Fxsc9Q_1770201126
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8620C1956060; Wed,  4 Feb 2026 10:32:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15A2E18003F6; Wed,  4 Feb 2026 10:32:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/45] hw/arm/aspeed_ast2600: Expand RC_H PCIe MMIO window to
 0x60000000 - 0x80000000
Date: Wed,  4 Feb 2026 11:31:03 +0100
Message-ID: <20260204103136.1795455-13-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Historically, the ASPEED PCIe driver supported both RC_L and RC_H, with RC_L
using MMIO window 0x60000000 - 0x70000000 and RC_H using 0x70000000 - 0x80000000.

Mainline Linux has dropped RC_L support and now supports RC_H only, updating
RC_H to use a single combined MMIO window 0x60000000 - 0x80000000.

Update the AST2600 QEMU model accordingly by moving PCIE_MMIO1 base to
0x60000000 and increasing the aliased MMIO size to 0x20000000.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260127032348.2238527-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 4c5a42ea1742..efb1d8c0637c 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -81,7 +81,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_FSI1]      = 0x1E79B000,
     [ASPEED_DEV_FSI2]      = 0x1E79B100,
     [ASPEED_DEV_I3C]       = 0x1E7A0000,
-    [ASPEED_DEV_PCIE_MMIO1] = 0x70000000,
+    [ASPEED_DEV_PCIE_MMIO1] = 0x60000000,
     [ASPEED_DEV_SDRAM]     = 0x80000000,
 };
 
@@ -303,14 +303,14 @@ static uint64_t aspeed_calc_affinity(int cpu)
  *
  * Model scope / limitations:
  *   - Firmware supports RC_H only; this QEMU model does not support RC_L.
- *   - RC_H uses PHY1 and the MMIO window [0x70000000, 0x80000000]
+ *   - RC_H uses PHY1 and the MMIO window [0x60000000, 0x80000000]
  *     (aka MMIO1).
  *
  * Indexing convention (this model):
  *   - Expose a single logical instance at index 0.
  *   - pcie[0] -> hardware RC_H (PCIe1)
  *   - phy[0]  -> hardware PHY1
- *   - mmio.0 -> guest address range MMIO1: 0x70000000-0x80000000
+ *   - mmio.0 -> guest address range MMIO1: 0x60000000-0x80000000
  *   - RC_L / PCIe0 is not created and mapped.
  */
 static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
@@ -346,7 +346,7 @@ static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
     memory_region_init_alias(&s->pcie_mmio_alias[0], OBJECT(&s->pcie[0].rc),
                              "aspeed.pcie-mmio", mmio_mr,
                              sc->memmap[ASPEED_DEV_PCIE_MMIO1],
-                             0x10000000);
+                             0x20000000);
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_PCIE_MMIO1],
                                 &s->pcie_mmio_alias[0]);
-- 
2.52.0


