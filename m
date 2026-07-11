Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4882C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifpW-0006Sy-Bm; Sat, 11 Jul 2026 18:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpR-00062y-UH; Sat, 11 Jul 2026 18:05:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpP-0000h2-T4; Sat, 11 Jul 2026 18:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=Qr/i8I8IBEHoW3K54fVf/nBkolXXzPDq4ww5nE4cG6g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FIwlp9q4GeyqAkNgaLJYqJXK7F7f60twtZxoPxY4k7JbX3Tznj4dslOvP/pqAJ0La
 l0mCmSpEwhuDxXxpd+L5QNL4S05TU67yUSlS6987Bt68pnvv0eGN1acn60D0rz2gXN
 8fRlE1MPH/54hKuPxhw9KYqQ7ff98z2A1PjwSfKifgHNinEsM0ABpmAC7/llK2ojQW
 YSlkshuz+wP89UJTBe28m2OHF3/Q6/2iBoiAZkISHjjSw++3/q9mJdMT3NY6AQmL0N
 rFw0PQnp9QGU0I9cVSKm9QRLItmEiUYlIZqbzvVYQXROtI2F5PXeIevty0AbZnwiZ3
 7LZKwfICbD6jA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 90FEC1C0ACB;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4788B3EAF56;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D1B3713363; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Randy Schifflin <randy.schifflin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 64/81] target/sh4: fixup tcg for sh4 fipr/ftrv
 instructions
Date: Sun, 12 Jul 2026 00:58:42 +0300
Message-ID: <20260711215904.3757-64-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

From: Randy Schifflin <randy.schifflin@gmail.com>

Fixes TCG generation for sh4 `fipr` and `ftrv` instructions.
Updates the current logic for these instructions to check the
FPSCR register appropriately (according to the sh4 cpu manual, `fipr`
and `ftrv` are only defined when the FPSCR register PR flag is 0).
Also fixes the mth/nth-vector operands by multiplying by 4 to convert
to the correct floating point register offset.

Signed-off-by: Randy Schifflin <randy.schifflin@gmail.com>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Message-ID: <20260629-fixup-sh4-tcg-fpu-instructions-b4-v1-2-4356b305f971@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 614a52cf549e6aefa656634b4d3fa0d4686125c6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index cf0f80e4a54..7f8b27eabee 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -487,7 +487,7 @@ void helper_ftrv(CPUSH4State *env, uint32_t n)
     float32 p;
 
     bank_matrix = (env->sr & FPSCR_FR) ? 0 : 16;
-    bank_vector = (env->sr & FPSCR_FR) ? 16 : 0;
+    bank_vector = (env->sr & FPSCR_FR) ? 16 + n : n;
     set_float_exception_flags(0, &env->fp_status);
     for (i = 0 ; i < 4 ; i++) {
         r[i] = float32_zero;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index b1057727c55..3f018611316 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -377,11 +377,6 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
         goto do_illegal;                    \
     }
 
-#define CHECK_FPSCR_PR_1 \
-    if (!(ctx->tbflags & FPSCR_PR)) {       \
-        goto do_illegal;                    \
-    }
-
 #define CHECK_SH4A \
     if (!(ctx->features & SH_FEATURE_SH4A)) { \
         goto do_illegal;                      \
@@ -1740,22 +1735,22 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0xf0ed: /* fipr FVm,FVn */
         CHECK_FPU_ENABLED
-        CHECK_FPSCR_PR_1
+        CHECK_FPSCR_PR_0
         {
-            TCGv m = tcg_constant_i32((ctx->opcode >> 8) & 3);
-            TCGv n = tcg_constant_i32((ctx->opcode >> 10) & 3);
+            TCGv m = tcg_constant_i32(((ctx->opcode >> 8) & 3) << 2);
+            TCGv n = tcg_constant_i32(((ctx->opcode >> 10) & 3) << 2);
             gen_helper_fipr(tcg_env, m, n);
             return;
         }
         break;
     case 0xf0fd: /* ftrv XMTRX,FVn */
         CHECK_FPU_ENABLED
-        CHECK_FPSCR_PR_1
+        CHECK_FPSCR_PR_0
         {
             if ((ctx->opcode & 0x0300) != 0x0100) {
                 goto do_illegal;
             }
-            TCGv n = tcg_constant_i32((ctx->opcode >> 10) & 3);
+            TCGv n = tcg_constant_i32(((ctx->opcode >> 10) & 3) << 2);
             gen_helper_ftrv(tcg_env, n);
             return;
         }
-- 
2.47.3


