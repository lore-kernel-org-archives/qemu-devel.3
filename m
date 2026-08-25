Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF877C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp6N-0000Ox-Dk; Tue, 25 Aug 2026 07:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6K-0000Nx-U0; Tue, 25 Aug 2026 07:13:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6J-0008Cm-CL; Tue, 25 Aug 2026 07:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656395; bh=YDBmE+Ss8Tj0goodTURvX5uHHCAWDc0xm5dtYHEnSPI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KdywXH1WQMULZbuaYPO8iVIROIL2i3BepONgnSOAuDnJJ3hKCqIjgbpUNRU71z14x
 0cUitrmSOrtJeO/RzY/Uh/FcaZWRWdwMrazfNUSFYhlTqRyZEJaU/H9vofNkUsBwLU
 v+ktCXNbRnjk2B68Wmy3NKS1otdE0BMmKEYt3X0guYogs28U5qoTHDe60x3QQaFIQp
 EfrXuwWYllZ1VVduYZ4zAfzKTTITDUqZnZdD7WGfnagqQAmOFmkTWiNvSwb2NaP2wu
 JvdAKu1fr2C8Xe4qLGGPJ9y8dnqPM5ZgC0UMxjwUmkEQ63J6iifwlg9AJRFrA+f3dv
 23IXgD8tH9aww==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F1C041CE4A4;
 Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 15E73416270;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 630C23258B; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Jacob Young <jacobly@ziglang.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 136/166] tcg/optimize: Fix s_mask computation for
 shifts
Date: Tue, 25 Aug 2026 14:11:32 +0300
Message-ID: <20260825111206.482723-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
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
(Mjt: back-port to 10.0 across v10.0.0-1791-g03329e3ce460
 "tcg/optimize: Build and use o_bits in fold_shift"
 and v10.0.0-425-g74dbd36f1f87 "tcg: Merge INDEX_op_shr_{i32,i64}")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1b9553737e2..c7c16518f08 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2602,8 +2602,17 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
         int sh = ti_const_val(t2);
 
         z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
-        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
 
+        if (op->opc == INDEX_op_shr_i32 || op->opc == INDEX_op_shr_i64) {
+            /*
+             * Logical right shift will force the sign bit zero.
+             * Don't bother computing s_mask and let fold_masks
+             * recompute from z_mask.
+             */
+            return fold_masks_z(ctx, op, z_mask);
+        }
+
+        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
         return fold_masks_zs(ctx, op, z_mask, s_mask);
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


