Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91199C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mHX-0003fg-Gv; Tue, 15 Apr 2025 15:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m9j-0005es-Px
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:41:38 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8U-00068R-TX
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:45 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3f6ab1b8fc1so3143295b6e.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745990; x=1745350790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLO0Ih0RjBl0GWTUfeu4qjLF7pECJh2Z11pnIrnbAfw=;
 b=Lb8dzUdPACm9SL5OosZNqDmfdFdpAZIigiqxPzrVdyARS0Q6NVy216TYHIo1Xe9J/n
 ojuQt1YMP2bdaGIXmc2ADRyDgYCLddt9jUHSC1Ht89izRT5KKCbTwy3iFpRYefjv0kjh
 pQMqGWxQcbRbt3yTsrnOoLMhyFgOWKKn8ipUTzO4U1zRVf699VuLOLAjJfq4gEhMYFhB
 WQPhGBPnA2em79ff9D69OwD8X3OgCaZXv47BSzC5DzhpDjD4daxmiSs21oGmrnPLfyJU
 qPrYj6UYRIyrDpjjDQF/gBxsjkcfQ3VhXapU4vbivcLXtUGhq98Wa0N5OndWHpPClwxq
 Tdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745990; x=1745350790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLO0Ih0RjBl0GWTUfeu4qjLF7pECJh2Z11pnIrnbAfw=;
 b=IkCg0F9ybq5LvW9DkRrHzAnZ89Q6SW8DJSfJCp1T8+mNN0rVwgfI9KXnailgZFatol
 hU94mNDlab/3AfOQbapQasWuBJdaXAvGpUp7qJSK+DmhJKkNs9SHJ7hITJHDf6dqSCLE
 baC2+6Isoq5PcnA/tJ5DexWhEPB4dq5OoPytflaHcdT+NyziS8nAhY1hadoao3F/qlkY
 lRMJsgPcvIXM567X2epT8j+r8vFRFQGclq3O1wo4kWSJEa4eKbkHNvPWd0KyOpVZL1s2
 VlxYMmj1M7SklvptH8SdSiG0K2cUkLVe5HunS2cwB1GJx5ol1NZQdnO0XVR4aLCzoRLH
 iaBw==
X-Gm-Message-State: AOJu0YzaVJ8Rkzvvx1QUitpsXpCJaolHsMSRV/UiEV++/G8Lt+FTlhp7
 nehpDUCI+lh/Mkpu5jd7ZEP5J/9gvjUDW4du1Rbcs1SegBq3F2JyDjC1UgqljMuZCdFmo1gkyQL
 p
X-Gm-Gg: ASbGncu2Jdv3Yesgx8uW19DrGkJLA464oA3zysmIBJoSHZvcFnX+Ypb1U2XCTFMIKGv
 v9yPuO/yFfH0SnjsUVWJ+D/J12xmb58Wk2AG3M8FFrogG1nX0P7rjPC+2qxxdR82dvZJXp3QD3i
 xrz1p2rCjj0fUAhEnUxi5Q5nTGVHOFveOQabkQbIfS1OXLnHZY2UeYWqX8uNz8j1T1WOq6uEWmZ
 M/xvlgVmtuf9OvvqVNU8DYcWqDjhH1/gLTwegc9zcCBeDO8o7L2pZ09RTDSeqEAaEQT4BQRvBz5
 jHLxSro+KMyDfqNCNtkJAni8eWPkSJ7/FoXJccXXCGvZ3TIbMDtXXjf+ucPXyrxGiOD7YN/4On0
 =
X-Google-Smtp-Source: AGHT+IEbrPNP4pzDVYuL6Z8BmJSdNydmn4tZ3bg6tzoMdVUcmaM2ZH/vyLlcEHXABnaiFLKPrPODLw==
X-Received: by 2002:a17:902:f68f:b0:220:f59b:6e6 with SMTP id
 d9443c01a7336-22c318a6bedmr4778615ad.8.1744745554500; 
 Tue, 15 Apr 2025 12:32:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 092/163] tcg: Rename INDEX_op_bswap64_i64 to
 INDEX_op_bswap64
Date: Tue, 15 Apr 2025 12:24:03 -0700
Message-ID: <20250415192515.232910-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Even though bswap64 can only be used with TCG_TYPE_I64,
rename the opcode to maintain uniformity.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 6 +++---
 tcg/tcg-op.c             | 4 ++--
 tcg/tcg.c                | 6 +++---
 tcg/tci.c                | 4 ++--
 docs/devel/tcg-ops.rst   | 5 +++--
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 296dffe99a..1d27b882fe 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -45,6 +45,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(bswap16, 1, 1, 1, TCG_OPF_INT)
 DEF(bswap32, 1, 1, 1, TCG_OPF_INT)
+DEF(bswap64, 1, 1, 1, TCG_OPF_INT)
 DEF(clz, 1, 2, 0, TCG_OPF_INT)
 DEF(ctpop, 1, 1, 0, TCG_OPF_INT)
 DEF(ctz, 1, 2, 0, TCG_OPF_INT)
@@ -121,8 +122,6 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(bswap64_i64, 1, 1, 1, 0)
-
 DEF(add2_i64, 2, 4, 0, 0)
 DEF(sub2_i64, 2, 4, 0, 0)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index be9d09467d..87395f8ab5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -514,7 +514,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         x = bswap32(x);
         return y & TCG_BSWAP_OS ? (int32_t)x : x;
 
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         return bswap64(x);
 
     case INDEX_op_ext_i32_i64:
@@ -1568,7 +1568,7 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
         z_mask = bswap32(z_mask);
         sign = INT32_MIN;
         break;
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         z_mask = bswap64(z_mask);
         sign = INT64_MIN;
         break;
@@ -2858,7 +2858,7 @@ void tcg_optimize(TCGContext *s)
             break;
         case INDEX_op_bswap16:
         case INDEX_op_bswap32:
-        case INDEX_op_bswap64_i64:
+        case INDEX_op_bswap64:
             done = fold_bswap(&ctx, op);
             break;
         case INDEX_op_clz:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 27e700161f..ba062191ac 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2184,8 +2184,8 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
         tcg_gen_mov_i32(TCGV_HIGH(ret), t0);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-    } else if (tcg_op_supported(INDEX_op_bswap64_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap64_i64, ret, arg, 0);
+    } else if (tcg_op_supported(INDEX_op_bswap64, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3i_i64(INDEX_op_bswap64, ret, arg, 0);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3031582174..40c67dbc6f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1113,7 +1113,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
     OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
 #else
-    OUTOP(INDEX_op_bswap64_i64, TCGOutOpUnary, outop_bswap64),
+    OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
 #endif
 };
 
@@ -2939,7 +2939,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 break;
             case INDEX_op_bswap16:
             case INDEX_op_bswap32:
-            case INDEX_op_bswap64_i64:
+            case INDEX_op_bswap64:
                 {
                     TCGArg flags = op->args[k];
                     const char *name = NULL;
@@ -5467,7 +5467,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
diff --git a/tcg/tci.c b/tcg/tci.c
index 903f996f02..30928c3412 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -788,7 +788,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (uint32_t)regs[r1];
             break;
-        case INDEX_op_bswap64_i64:
+        case INDEX_op_bswap64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap64(regs[r1]);
             break;
@@ -1009,7 +1009,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap64_i64:
+    case INDEX_op_bswap64:
         tci_args_rr(insn, &r0, &r1);
         info->fprintf_func(info->stream, "%-12s  %s, %s",
                            op_name, str_r(r0), str_r(r1));
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index e89ede54fa..72a23d6ea2 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -431,10 +431,11 @@ Misc
          they apply from bit 31 instead of bit 15.  On TCG_TYPE_I32, the
          flags should be zero.
 
-   * - bswap64_i64 *t0*, *t1*, *flags*
+   * - bswap64 *t0*, *t1*, *flags*
 
      - | 64 bit byte swap. The flags are ignored, but still present
-         for consistency with the other bswap opcodes.
+         for consistency with the other bswap opcodes. For future
+         compatibility, the flags should be zero.
 
    * - discard_i32/i64 *t0*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index cbfe92adf3..4fc857ad35 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -930,7 +930,7 @@ static const TCGOutOpBswap outop_bswap32 = {
 #if TCG_TARGET_REG_BITS == 64
 static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
-    tcg_out_op_rr(s, INDEX_op_bswap64_i64, a0, a1);
+    tcg_out_op_rr(s, INDEX_op_bswap64, a0, a1);
 }
 
 static const TCGOutOpUnary outop_bswap64 = {
-- 
2.43.0


