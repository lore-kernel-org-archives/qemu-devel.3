Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAABCE7FDDC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn13Q-0002Hp-8V; Mon, 02 Feb 2026 16:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn12T-0000cc-KX; Mon, 02 Feb 2026 16:01:01 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn12R-0004J5-JJ; Mon, 02 Feb 2026 16:00:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B38C11851A6;
 Mon, 02 Feb 2026 23:57:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7247F35B31D;
 Mon, 02 Feb 2026 23:58:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 26/74] tcg/optimize: Fix a_mask computation for orc
Date: Mon,  2 Feb 2026 23:57:37 +0300
Message-ID: <20260202205833.941615-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

In computing a_mask, for or, we remove the bits from t1->o_mask
which are known to be zero.  For orc, the bits known to be zero
are the inverse of those known to be one.

Cc: qemu-stable@nongnu.org
Fixes: cc4033ee47c ("tcg/optimize: Build and use zero, one and affected bits in fold_orc")
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 08b12bfb8f532dbc62e35c31d081ede1aa12098b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1f95da487b..db1d89396b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2360,7 +2360,7 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     s_mask = t1->s_mask & t2->s_mask;
 
     /* Affected bits are those not known one, masked by those known one. */
-    a_mask = ~t1->o_mask & t2->o_mask;
+    a_mask = ~t1->o_mask & ~t2->o_mask;
 
     return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
-- 
2.47.3


