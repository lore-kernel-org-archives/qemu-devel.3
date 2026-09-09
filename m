Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B096C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NCi-0006Tr-E2; Wed, 09 Sep 2026 14:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBx-0006AB-Rx; Wed, 09 Sep 2026 14:38:42 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBv-000741-94; Wed, 09 Sep 2026 14:38:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 578FA40A43;
 Wed,  9 Sep 2026 18:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAE91F000FF;
 Wed,  9 Sep 2026 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788979117;
 bh=INPL6GjU3It09px70eSyFlscorg/ibGtabVxCQM6X0k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DmBXRgsXfna6UbgBC1+RU73gkl24xex5f+aDQ5C5+kvXVaNNKTmKWLyZjp7MJsrWB
 DrOP0aYZMm7pGksBWGAPEOoh9rX2wuhKI4dktb2Jzv33JiCX4uuTFvSM8Ll6qaCoRx
 CxQz2PNcsVCXzxm+GzwqvO370dKyrY6vp6g7gVvzfzDxQERog9wS9VJwpgYL0Z8pEM
 TI52aV0B5NjZZA0GVRQcIdrN0g0gY0nWZoJDJZbmrQF/W6+WhnEpcOC6M+rauySwwf
 zQHvm44lkAf1gyzTy2YSkauo2RGU2Wy0nS6gRw/wjribQDFRFY73kniyZJUpZ1awOn
 CA1sqMPibdqbA==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 09 Sep 2026 20:36:55 +0200
Subject: [PATCH v3 6/7] hw/nvme: drop DMA-path IOV_MAX guard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-align-nvme-mdts-with-linux-v3-6-1cee970cc8c8@samsung.com>
References: <20260909-align-nvme-mdts-with-linux-v3-0-1cee970cc8c8@samsung.com>
In-Reply-To: <20260909-align-nvme-mdts-with-linux-v3-0-1cee970cc8c8@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788979097; l=860;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=mJPV5DYqQ9EMwh9VaXYQAglb51wnFe8RlqnU1YjGlcs=;
 b=vjSRHMZhl3NcsH1zm2kZylOvj2H+gwYf0zcEWV7sH0mtj4KOlnUpPR/gASJMml4KSyZ8R1xuf
 HSDsq2EN3CSA69/jc5i/5OwjaP8TgA2/Zl6B91oKcdLxc+iodIl2N8Q
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Reviewed-by: Keith Busch <kbusch@kernel.org>
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


