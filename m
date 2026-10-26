Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670F606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2YyOAj9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHhJ-0006P4-S8; Mon, 26 Oct 2026 06:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHh4-0006Ce-0f; Mon, 26 Oct 2026 06:12:42 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHh1-0001OI-CD; Mon, 26 Oct 2026 06:12:40 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7708A60A59;
 Mon, 26 Oct 2026 10:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62F61F01825;
 Mon, 26 Oct 2026 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009558;
 bh=FX33yl8f03YeP53nEewlk0wsJdBGqmmFMFXAM0JmX+Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=K2YyOAj9G+an7/xn9y86e0BHau/fbYD0eZ2TgbnK1WB1NS4m9T3jj9QlgZUTUIMCM
 jjGkw3rZHWPjsF3Di29zova75JT79sOr10BES7zXdzcFVnGOjMIAT2Druo49e1lErk
 TtOBiwaOD9phZ7R8n+Asc2J8R1lPBblz7kSGKrvBc4XasixZygREP8DxuRaofNE875
 uwPvjEUboXaG1pczObm/7H2L9F2Pn8ULbSBQfLzl/z3lp6YTR25XJ5LnBybr2xR1Z2
 GY6r4GqgzVFW9NZNtGSZolSoC8KqP1A5tDwt/rlKaUxHRBJo9h2e7R2uShOurfdkHI
 hPZcLT68rE1Vw==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:11:15 +0100
Subject: [PATCH RESEND v3 7/7] hw/nvme: cap mdts for CMB/PMR-only
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-align-nvme-mdts-with-linux-v3-7-a33bd7c32df9@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009536; l=1786;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=e3YU8tgAK5xQM5s1EgOEpZOiL9ncKXfABBtI2yAW4AA=;
 b=L1X1hu8gl62FBD1DtJjQHCzIqbi3Uee6YOmwr/LmxMRPCp93uk7/8/Q4HKRiD+4WAI1GFEXNi
 VxO5xzkQfMWDPHvR6E9mbPNGBF9DLVM2dvjIw3OR7gYhxprk4JGV2kb
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

Commit 53493c1f83 ("hw/nvme: cap MDTS value for internal limitation")
capped MDTS so the worst-case PRP count would fit in IOV_MAX, leaving
transfers limited to 2 MiB.

Now that dma_blk_cb() can batch IOs up to IOV_MAX instead of limiting
to IOV_MAX, remove it, except for CMB/PMR-only where the limit still
applies.

In addition, fix UB when mdts >= 31 by calculating the worst-case iovec
count with a width-bounded shift helper. Fixes error with ubsan:
    ../hw/nvme/ctrl.c:8638:33: runtime error: shift exponent 32 is too
    large for 32-bit type 'int'

Suggested-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7861d8f2521..f219bf524dd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8720,6 +8720,11 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
+static inline uint64_t nvme_mdts_max_iovs(uint8_t mdts)
+{
+    return mdts >= 64 ? UINT64_MAX : (1ULL << mdts) + 1;
+}
+
 static bool nvme_check_params(NvmeCtrl *n, Error **errp)
 {
     NvmeParams *params = &n->params;
@@ -8802,8 +8807,9 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         host_memory_backend_set_mapped(n->pmr.dev, true);
     }
 
-    if (!n->params.mdts || ((1 << n->params.mdts) + 1) > IOV_MAX) {
-        error_setg(errp, "mdts exceeds IOV_MAX");
+    if ((params->cmb_size_mb || n->pmr.dev) &&
+        (!params->mdts || nvme_mdts_max_iovs(params->mdts) > IOV_MAX)) {
+        error_setg(errp, "mdts=%u is incompatible with CMB/PMR", params->mdts);
         return false;
     }
 

-- 
2.56.0


