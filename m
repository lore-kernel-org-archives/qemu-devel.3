Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1776FC61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn44-0005Bm-DT; Tue, 25 Aug 2026 05:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn3y-0005As-Rk; Tue, 25 Aug 2026 05:03:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn3w-00035W-Dx; Tue, 25 Aug 2026 05:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=JSZXwK4+6k+78w6kfR4yQo2p73K16SeORqVZ/qOnfTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DqcjkPh+7/Hz11y1D03//KuiUCMpH2Accq51Lj43ORT/M9+N+j3rPDyrNI0dnh2I3
 kOyGMWhogsv9CGHzdJN66reNU/hc0/+bkgMNhv3ZwenXLlmO9fDso7j+gnUsoPSrVY
 qDj3RwWm1HVeUE3eEaJexPiubmmLe2KbnbEdM5YRAL7QYAR9FQbdrICuwUIVHCMyIP
 g0U31Jkof0BXinbqeLRLjwT4wz5AesC9J3io8ABZ4rM6R0Fw6xh7DQKxIv+sY3+1w0
 BUSKAX92X5cxtcpRqHdSDo4f2dxTDO+iQoA/OD5g5k4dcWOEJC7DU0527CvqmaUsCN
 SLo62SIG/vk3w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 365BC1CE3AD;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2296E41616F;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A8EE232543; Tue, 25 Aug 2026 12:02:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Jacob Young <jacobly@ziglang.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 163/196] tcg/optimize: Fix s_mask computation for
 shifts
Date: Tue, 25 Aug 2026 12:01:20 +0300
Message-ID: <20260825090157.471948-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Skip s_mask computation for logical right shift.

Cc: qemu-stable@nongnu.org
Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
Reported-by: Jacob Young <jacobly@ziglang.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 5fe51606146cbf04dac07bf27256febbe56881e7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index acaf96d73c0..c266cfe99c9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2628,8 +2628,17 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
 
         z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
         o_mask = do_constant_folding(op->opc, ctx->type, o_mask, sh);
-        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
 
+        if (op->opc == INDEX_op_shr) {
+            /*
+             * Logical right shift will force the sign bit zero.
+             * Don't bother computing s_mask and let fold_masks
+             * recompute from z_mask.
+             */
+            return fold_masks_zo(ctx, op, z_mask, o_mask);
+        }
+
+        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
         return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
     }
 
diff --git a/tests/tcg/i386/test-i386-opt-shr.c b/tests/tcg/i386/test-i386-opt-shr.c
new file mode 100644
index 00000000000..9fb8d420223
--- /dev/null
+++ b/tests/tcg/i386/test-i386-opt-shr.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Regression test for tcg optimize vs sign bit repetition counting. */
+
+#include <assert.h>
+
+int main()
+{
+#ifndef __x86_64__
+    char test;
+
+    asm("movw $0x4000, %%ax\n\t"
+        "addw %%ax, %%ax\n\t"
+        "cwtl\n\t"
+        "shrl %%eax\n\t"
+        "cmpw $-0x3fff, %%ax\n\t"
+        "setnl %%al"
+        : "=a"(test));
+    assert(!test);
+#endif
+    return 0;
+}
-- 
2.47.3


