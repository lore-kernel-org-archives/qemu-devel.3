Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F18C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilhE-00044Z-7q; Sun, 12 Jul 2026 00:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilhC-000409-WF; Sun, 12 Jul 2026 00:21:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilhB-0007C3-9b; Sun, 12 Jul 2026 00:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=0GuRFwIHnwinAmrPlPvfywXOhf75SQ9j6sHIL3hche0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Oie6y211My/MM/oCy1rcbohpdQK1FTbpgRpqrKuVc/mrO7CYl6UUYBez3aK0REISX
 W0NDM1NG0zOvLNWKMstRVsSPTHgnEvUE+HJq8HFm4oCbi0WPB2Fn1Z4yUCP0pn/xDz
 SGX7SLHNab2gBvpdebKrS18pRDAWt0KXxqX0hVP3YoZcryB51knSVwU8A/Foc7aGEI
 VsPMifYgXdOeQR03luB31mYB/XVfUKBKQasBU/XhvqJCkJm0iMJqfF+zZ86TT1tMBf
 /iQwpy8az+l+ptNbQiE2csNUXEHd+Oul2C8CDFaUpYHeXFHjDNYFP0exCXl2paomQR
 l2Pz428p8205A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1B19C1C0C15;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4EFB93EB975;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9E2161342D; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Randy Schifflin <randy.schifflin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 58/75] target/sh4: fixup tcg for sh4 fipr/ftrv
 instructions
Date: Sun, 12 Jul 2026 07:15:16 +0300
Message-ID: <20260712041539.108341-58-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
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
index d70587f328d..bc3b7c44dde 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -485,7 +485,7 @@ void helper_ftrv(CPUSH4State *env, uint32_t n)
     float32 p;
 
     bank_matrix = (env->sr & FPSCR_FR) ? 0 : 16;
-    bank_vector = (env->sr & FPSCR_FR) ? 16 : 0;
+    bank_vector = (env->sr & FPSCR_FR) ? 16 + n : n;
     set_float_exception_flags(0, &env->fp_status);
     for (i = 0 ; i < 4 ; i++) {
         r[i] = float32_zero;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bcdd5588183..6286862241e 100644
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
@@ -1746,22 +1741,22 @@ static void _decode_opc(DisasContext * ctx)
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


