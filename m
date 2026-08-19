Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84965C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwiA5-00062Q-O8; Wed, 19 Aug 2026 11:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwiA4-00060z-7U; Wed, 19 Aug 2026 11:25:04 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwiA2-0005oU-KR; Wed, 19 Aug 2026 11:25:03 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F09EE61126;
 Wed, 19 Aug 2026 15:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2A21F000E9;
 Wed, 19 Aug 2026 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787153100;
 bh=/8JZe4QUxylfRYcVX3vsTlHWrrEwATnl6VKsOCHBNJw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VGFZQTwA11ayTUPKVl6JGzpECKp66A5g/uWs5h8XjJAINi8Y6I7EspQCUHgJIAjuQ
 pae+l9R7GXNqdrYfN2jmSrSw75+/e53gNBdHKIFOGMmlt3RGF8dLdOkUpWaW3uMJUH
 a14eAEcvCFKMtKSBUp/7kpJkMgAuLLIX0sL8vsLOqZi9O56EqCqcMNE6H+tUqMqC8d
 gWiiHRZaaFbd+q/YMj5gFDeIPNrMGCrn73w1kwuYoLxgEmv56QQfav3xngDGZJtZSI
 vYlb1bqg+b9foM6+5bQgRMwKuVpouZ03AN4nnQg5PCu35y5PpWetQqekbzMqzlmCgw
 BBquylsmCXL5g==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 19 Aug 2026 17:24:09 +0200
Subject: [PATCH v2 7/7] hw/nvme: cap mdts for CMB/PMR-only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-align-nvme-mdts-with-linux-v2-7-351ac2dfed64@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787153076; l=1413;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=GbtsNLf3gaz/U4mHrWr6MfrBe4wgKrtKkyfeOVMbI0E=;
 b=4q1YzkQxCyTWHTefQjqobRiuWkfeQRB3gPlPSw33nBwAJ12bKA240LRFdy+S3M8LKv4qmgOfW
 VBHP02Fg8inCJbI816pYCPWC+DTvebgLOCoGIJCT9AJovQV2yrLmRhL
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

Commit 53493c1f83 ("hw/nvme: cap MDTS value for internal limitation")
capped MDTS so the worst-case PRP count would fit in IOV_MAX, leaving
transfers limited to 2 MiB.

Now that dma_blk_cb() can batch IOs up to IOV_MAX instead of limiting
to IOV_MAX, remove it, except for CMB/PMR-only where the limit still
applies.

In addition, fix UB when mdts >= 31 by dropping the shift and making the
cap explicit. Fixes error with ubsan:
    ../hw/nvme/ctrl.c:8638:33: runtime error: shift exponent 32 is too
    large for 32-bit type 'int'

Suggested-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7861d8f2521..ff7e4a055b8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8802,8 +8802,10 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         host_memory_backend_set_mapped(n->pmr.dev, true);
     }
 
-    if (!n->params.mdts || ((1 << n->params.mdts) + 1) > IOV_MAX) {
-        error_setg(errp, "mdts exceeds IOV_MAX");
+    /* 2^mdts + 1 must fit IOV_MAX */
+    if ((n->params.cmb_size_mb || n->pmr.dev) &&
+        (!n->params.mdts || (params->mdts > 9))) {
+        error_setg(errp, "mdts=%u is incompatible with CMB/PMR", params->mdts);
         return false;
     }
 

-- 
2.55.0


