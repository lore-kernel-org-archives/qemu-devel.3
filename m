Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CB8C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylFp-0006R4-9B; Tue, 25 Aug 2026 03:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylFe-0006F1-1K; Tue, 25 Aug 2026 03:07:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylFb-0005up-DG; Tue, 25 Aug 2026 03:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641595; bh=C1EEvuRdTypbAga7ViYl8xmZ4WYNsvFyRaUby8PES1Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cd4eJA0WLObdJHh0YSSQQvCIhTXSNzM3JCNpCZUezYZqTIyj0dQEcAINkmzQ/dnxA
 6t78T9OynVEOlUlF2a9ODGwgoNWRDzcOsBaeIhDNzsdULIo6EQziSwExN0qNVcpcvh
 nhQJPJ0qDxmWQEO4IEL2bO2+X/SlFq4xWRxyCsf3YJaY7fcW0do0VXxS8DSI6fOdtk
 SiDnGyoZvFn1L77aFbCS5A2SPjSTorL2IAEJwCC46TwSkYFq68Vx1BB8fNaVpnKPUS
 JD7aYrhktskZ17gLr33iIT63jGexMGcKGwgbnJlEFk/1syIuKVoeNDhJC8P8aCawxH
 qacY6X9zrTVaw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E10821CE211;
 Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A5B8C415F8C;
 Tue, 25 Aug 2026 10:07:12 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 66EAB32402; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Jacob Young <jacobly@ziglang.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 44/91] tcg/optimize: Fix s_mask computation for
 shifts
Date: Tue, 25 Aug 2026 10:05:16 +0300
Message-ID: <20260825070619.174584-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
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
index ed2ff32ed2f..d12babad88f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2656,8 +2656,17 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
 
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


