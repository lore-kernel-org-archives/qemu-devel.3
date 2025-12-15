Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F3CD5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 19:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEQO-0001CB-5m; Mon, 15 Dec 2025 14:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVEQK-000154-C9
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:40:00 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVEQG-0006Xr-QZ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=9F56ezpJQPKpkmce3eQhs7nQ1rueuwE3dX3pcpOdYMo=; b=nRnYEZzB6aAtKLI
 0X9dajtCTFNDmHbvFop3dswpx4omYEEhH7n2bgTsrRoUPRpmm5XwchBuMS8VCT4T5beY5b0dZD42m
 saIBgVlpti2cpQNJh9Q+sUvB8Ryqe5mQjD6UtDKyp8vebivKWwc2h0vx21Wk2DqmRvdrZHmyuvHio
 5Y=;
Date: Mon, 15 Dec 2025 20:42:55 +0100
Subject: [PATCH v2 6/7] hw/riscv: Fix IOMMU PAS capability to 56 bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-phys_addr-v2-6-633aa1d922cd@rev.ng>
References: <20251215-phys_addr-v2-0-633aa1d922cd@rev.ng>
In-Reply-To: <20251215-phys_addr-v2-0-633aa1d922cd@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replaces the only remaining use of TARGET_PHYS_ADDR_SPACE_BITS for RISCV
with the fixed size of the riscv64 physical address space.

Better would be to somehow determine if a 32-bit or 64-bit cpu is
running and set accordingly, but I'm not sure how that would be done
from the device instance init function. This field is unused anyway.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/riscv/riscv-iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f8656ec04b..573c536824 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2448,9 +2448,15 @@ static void riscv_iommu_instance_init(Object *obj)
     /* Enable translation debug interface */
     s->cap = RISCV_IOMMU_CAP_DBG;
 
-    /* Report QEMU target physical address space limits */
-    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
-                       TARGET_PHYS_ADDR_SPACE_BITS);
+    /*
+     * Report QEMU target physical address space limits.
+     *
+     * Currently set to the riscv64 limit of 56 bits (44 bit PPN),
+     * riscv32 would use 34 bits (22 bit PPN).
+     *
+     * This field is currently unused.
+     */
+    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS, 56);
 
     /* TODO: method to report supported PID bits */
     s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */

-- 
2.51.0


