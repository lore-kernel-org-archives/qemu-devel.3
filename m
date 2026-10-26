Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA05606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgsIntWt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHhC-0006Fp-Nh; Mon, 26 Oct 2026 06:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHh0-0006Ax-05; Mon, 26 Oct 2026 06:12:38 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHgy-0001Nz-JC; Mon, 26 Oct 2026 06:12:37 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B270760A5E;
 Mon, 26 Oct 2026 10:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7141F01825;
 Mon, 26 Oct 2026 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009555;
 bh=S0fdWmsjQVimjx4RguH5u/kypT/0IJXeTNpDUxgLK+o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HgsIntWtpSS1z9YuV0ovQpRzR6k/CieeeTZLytyoB0n+2UNfrg4IEIfWvjzRh1M2c
 2Zon7RspkDVqYgEOFMVA6HCcevRMORFXRQ8DP324x9/DpNhtFamb9EldBY9nWMPcEv
 77BiWTocHoqUwjdWxmxHGaWcEuyUW6Bvh5rf0fBh6/2ygrwCCpGUQTCLo9hj9jspM/
 Uz6GKA5i1dax0z/0uus3BOK+YtXjl8jrG3gnRc4ks/C82AeYztZiAJZgb58R2Onnq3
 1vJqHvgLV5CPgIQIf6HsL/kRdrMMJQcn3ti4BrTokhxNu4ARf1G7IF8iCm6ZNVX3db
 ee3VQLrDVHrEg==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:11:14 +0100
Subject: [PATCH RESEND v3 6/7] hw/nvme: drop DMA-path IOV_MAX guard
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-align-nvme-mdts-with-linux-v3-6-a33bd7c32df9@samsung.com>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
In-Reply-To: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009536; l=860;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=zX25pTXk66/7k/5MFGIXlpIzUDoLSNAlcaSnFdF/5QE=;
 b=lDUy1DcNfiIUGIPO1AdYUr1yeEXRmSwcXgIBvtfNRjZffxwtlRXvDzpqHSHJGJSuq01XfCb+A
 zM11Braco+eCxFt75GYeMNIjLQML3WQARe+ENyLAcSVON0DwBh359LZ
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0


