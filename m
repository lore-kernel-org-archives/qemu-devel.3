Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3282CD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwSJ-0006SH-LR; Fri, 29 May 2026 08:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wSwSH-0006Rm-N5; Fri, 29 May 2026 08:36:50 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wSwSG-0002vL-9E; Fri, 29 May 2026 08:36:49 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BE1760236;
 Fri, 29 May 2026 12:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E841C1F00893;
 Fri, 29 May 2026 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780058207;
 bh=vWX+aCGUN0nyDUMTOBtZsMjzDDdS+F7PiXVMD31IlEY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BorNcytenQrDq2hvTfcUGFgnqFmEFLcfuM1qisKXQ+Gsj7V6qBexIb65VMIYX0uwD
 LZ+GDolByrcAF+xq304ttXbFPtFnyb/tbHLZDZPjAoAj/nF0LTENB38xAM/nQKuQ5j
 XXKT9lEI6NhkExRYDnJ1GCD9qiQV8wKMRa/Nr4bf2W/pVUt+EJQ1fJ9LdRyPvAHjeD
 tSP+jx0kuSPX/KOuohf41FwNhzGIwBnsQjINWegBwVU+g7twHBax6dd7S8bddyPEWy
 uPcn+gW44dzK3C1++HVNOlieiPrhoqtZVLSgo1qva139q6JtawBD/nti7TOBgyCvSL
 2A0RbB5heNVeg==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Fri, 29 May 2026 14:36:14 +0200
Subject: [PATCH 2/3] hw/nvme: drop DMA-path IOV_MAX guard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-align-nvme-mdts-with-linux-v1-2-221d4d21ab43@samsung.com>
References: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
In-Reply-To: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780058199; l=757;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=C5o8/kA1EvnBtxf5b9vk3fcSsWWupu+9S2HofLXNrhQ=;
 b=ckv22RzTXhG5G4yzWG4jdVwav36JSNiGFAE5fQ77LRsZIOy/RiFX3IBT1Yr7ppweBuBSElLpi
 uw5T/lI9WZdClO5gCADecvPSPiDXYYbGTmmmsbIk12pRcdJJDolPDEd
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
index be6c7028cb5..00995d9808f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -866,10 +866,6 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *sg, hwaddr addr, size_t len)
         return NVME_INVALID_USE_OF_CMB | NVME_DNR;
     }
 
-    if (sg->qsg.nsg + 1 > IOV_MAX) {
-        goto max_mappings_exceeded;
-    }
-
     qemu_sglist_add(&sg->qsg, addr, len);
 
     return NVME_SUCCESS;

-- 
2.53.0


