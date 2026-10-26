Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87768606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8IdJtxW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHh8-0006Ec-N5; Mon, 26 Oct 2026 06:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHgx-0006AJ-DQ; Mon, 26 Oct 2026 06:12:35 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHgv-0001NW-TH; Mon, 26 Oct 2026 06:12:35 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDCDC60A54;
 Mon, 26 Oct 2026 10:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C9B1F01825;
 Mon, 26 Oct 2026 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009552;
 bh=vWwa32j8gqW/BGnuGUJYyRd/cyPt+GTkzx72/xj8p5o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=i8IdJtxWCTdUcSG9ucC99+VQa7s82x3ZzXx0YCA6cXqIgsDsyVlGZLaTD0XiGm1qM
 P4/gA2dIYcXTlS2TtTSNHwKx5feBQeWTCVoqBT5c8uxvNGaPsVLC3rUiD8ziwZ3qYp
 4SMgx+BRFaRgId/BbqbCrtAt/vS8RvuPXwt+bmVmD/bZGxe1s/DIvG5YVOjQVGUgup
 v9ssFHMbD//1uBHyih9HZBm2CpeDI8DY/zezvYQkJAbs0qajDdZSzzKjRatzzTflkd
 w9GkW5mOby6k43ujRSuD+pH6oI6RrZUijntKPQsmV9tuzdIWMhI4eeHFhrV6cBpPsh
 MMFgrVKohexqg==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:11:13 +0100
Subject: [PATCH RESEND v3 5/7] hw/nvme: clamp mdts and zasl shifts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-align-nvme-mdts-with-linux-v3-5-a33bd7c32df9@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009536; l=1925;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=P3M5trZXx+I01N7XIbqs4pDOOYXgogrXBuZfM7d0mDw=;
 b=Ao4A2ab9UkjbucNIXClLI7VtWda9hrr4iwb6TQJluvcLWPyNuMrkpwwao1eUUaHxGJXmxrlKS
 +AuDFICMf2kADM6yPLDRBUogaFKj+Hby1YtX3RVKo9NtwucbnU09700
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=172.105.4.254; envelope-from=da.gomez@kernel.org;
 helo=tor.source.kernel.org
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

Once dma_blk_cb() chunks at IOV_MAX, a later patch drops the current
mdts 2 MiB cap, allowing mdts (and zasl, which may be as large as mdts)
to essentially be 32 or more. Ensure shifting doesn't go out of range
by adding a static inline helper that clamps to UINT64_MAX when mdts or
zasl shift operations exceed uint64_t width.

Fixes error with ubsan enabled and large mdts:
../hw/nvme/ctrl.c:1685:36: runtime error: shift exponent 32 is too large
for 32-bit type 'unsigned int'

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4893cf7e741..a24a674a4c5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1713,11 +1713,18 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
     }
 }
 
+static inline uint64_t nvme_max_data_transfer_size(NvmeCtrl *n, uint8_t exp)
+{
+    unsigned shift = n->page_bits + exp;
+
+    return shift >= 64 ? UINT64_MAX : 1ULL << shift;
+}
+
 static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
 {
     uint8_t mdts = n->params.mdts;
 
-    if (mdts && len > n->page_size << mdts) {
+    if (mdts && len > nvme_max_data_transfer_size(n, mdts)) {
         trace_pci_nvme_err_mdts(len);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -3809,7 +3816,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
             }
 
             if (n->params.zasl &&
-                data_size > (uint64_t)n->page_size << n->params.zasl) {
+                data_size > nvme_max_data_transfer_size(n, n->params.zasl)) {
                 trace_pci_nvme_err_zasl(data_size);
                 return NVME_INVALID_FIELD | NVME_DNR;
             }

-- 
2.56.0


