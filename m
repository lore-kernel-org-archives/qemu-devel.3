Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F493C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwiA1-0005yD-FY; Wed, 19 Aug 2026 11:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwiA0-0005xM-Hk; Wed, 19 Aug 2026 11:25:00 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9y-0005np-8f; Wed, 19 Aug 2026 11:25:00 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31F4060AAA;
 Wed, 19 Aug 2026 15:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3CF1F000E9;
 Wed, 19 Aug 2026 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787153096;
 bh=M0g8prnLZTF2UJq7FAuexAvTsNGXlcwIKLz2CKU78aI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Mj9vJsW9tihBT7qT6SlhvPESbH0JkVbRmwWuREt3j47tIX/HeH8CH9FqpmhQBN8ry
 M37v7b1L//gPMiUfm0+1PxUP4uw9xZxEZQtdCc1GciyfRW2mXtKaIaRnp6b+3dyB19
 PU9j0/29xlreEzEUMSnqXEaNzhXodIj7QGlZlP9wP45tteczpvtH8Bzh5QAxkVXSEs
 5Vr5T2c2iK8IYb0rOINwJuDHWpv18oqpW+nDfgsb4WF6fkDLFLPbUW11oNOIv9zNT1
 wn8GlNwDc8PWVdPnQfqU0/X+gaeAqBE1alviAZz5oEtJEdjcsGv00gV1iWjwbL4gWz
 IdRs/aSTpE7AA==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 19 Aug 2026 17:24:08 +0200
Subject: [PATCH v2 6/7] hw/nvme: drop DMA-path IOV_MAX guard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-align-nvme-mdts-with-linux-v2-6-351ac2dfed64@samsung.com>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787153076; l=757;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=TerySl42tlCdTV7qZGn08VqgwSosK3aNu3nk1Pmru7o=;
 b=C8GPd1K9SHmzLDwFlU+ALqh2UCZpAn/YsnhxdbvMWMWNWprc08QsgIcNyy+PIBabBoh0or4ZO
 sGcoT/7d+jGC3mg30pYaHRiLvLWATiroagTfCXik3XY4Gx3RbrJ2xFb
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Gomez <da.gomez@samsung.com>

dma_blk_cb() now chunks at IOV_MAX, so the per-mapping cap on sg->qsg
in nvme_map_addr() is redundant. Drop it.

Suggested-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a24a674a4c5..7861d8f2521 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -872,10 +872,6 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *sg, hwaddr addr, size_t len)
         return NVME_INVALID_USE_OF_CMB | NVME_DNR;
     }
 
-    if (sg->qsg.nsg + 1 > IOV_MAX) {
-        goto max_mappings_exceeded;
-    }
-
     qemu_sglist_add(&sg->qsg, addr, len);
 
     return NVME_SUCCESS;

-- 
2.55.0


