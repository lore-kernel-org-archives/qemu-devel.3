Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C4AC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjntZ-0003EK-6C; Sun, 16 Feb 2025 18:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntA-0002AL-SG
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:30 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt6-000611-1x
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:28 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220d39a5627so54502065ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747842; x=1740352642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FJlPEkpIx6smHF2YKSru87UjA2EUsNB2PJe++VwUXkU=;
 b=dLPAAhO+8oLYeicrI/kH563LKk6LHCEWfXEOvRvfJTI/J4G4maggufH7nRHOVBPjNP
 9U8ZN7lTAn3JCGG+rofW9qRYmu8b4Ll8NPveiPdwYsfL7k34/YBhAzq8ZkurnIW6coBb
 6kL1eMKn84ZAC0PD+BRBtOULX43TVZ1f+ersM7xVwCW7kRq/GhNryeCFf8xfGyMPi4NM
 Ak4OSE4kbfva4fQbEkCena2O59VFisI0ZXdM3pXYodfEAwVimqr9vsKSQbQk21y5eMJA
 iqatXMKS/4IgivBM3uN9TVzi79H26qkjdyM1ERX1EhQe1XtM/yWa2gT3Wweutfq/g9Yj
 arRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747842; x=1740352642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJlPEkpIx6smHF2YKSru87UjA2EUsNB2PJe++VwUXkU=;
 b=owjh+pL7oPwSWKiQnfpy165JN1aSqqvk9VX7mLsZp0ZkiJ9KqBG7wpj87u4dDgHRUd
 eBI4NAvXFUdY1bu+3Q3M44YqgXDO6nVveTsMmmr47JyGJZaGsklVHP48c3JCttGIB1Cn
 P1n3o6XcabOHCpkfjli2rLK8uhIkCWb79t3SJzu3LkwbxvfVEeH8AEtqPzcfy7/TYPCh
 aByeDxUh1vuab/qAP3xTHjut0pQizgiMHzcPNIQB1oVj/IZ9Ex7uG6rasdn+o9SQV1ST
 khMWxSq0Yiz8MGQvUgSTYal3Tyn9E8kyMidm9mKV/3xG8reAnzOACdCSivxPXwvVJ5Z4
 0NLw==
X-Gm-Message-State: AOJu0YylWS7lfzxwJwfyoeuR2/IwLlhDyVUDFN3OoOuLpoTssxl6m69r
 lxbkau9SqBGsdgzMvixSRawvf8v+4A1thdj4LoUfjs7jiK/RmsM08i9b3x0CU+kst0tREmIZByV
 A
X-Gm-Gg: ASbGncuMN5iKg8NQZYwafoyAQOtFIUkuEzjTAbQuiBQAq1KRxhSJ44NwTja9NhgCw2U
 x2rGihmdWvK3Oh3v5K9kbkbexbSDv4SvCpCOvfhEV7wKCOfVeRaR8iC5WyIBkaVmPqKibCk43q9
 2cPIro3Q0agKviXrzFFMF27Vqjfb06xjVpqXg4vmu7ji/xXvRc7/zG4kyprUTff8x1mekY1M6IS
 XIy2/wkVmi7rEBtocKSI1UdFbeR4PpqlbHTX7IMeEVcpnn+y1QKIwtdhsoQlJvTlRI7MT4c2/tV
 ZhOPWwBSO/cHf7n3xpYg0R29Sxvk4rCKX2OU7vhcMjVmQb8=
X-Google-Smtp-Source: AGHT+IE5oEqmMuxzdenuC/LYxi7g8KvrwQAconLldKmxavHzUCWQO88obQIcykWQacogosygVTad7Q==
X-Received: by 2002:a17:902:ec8d:b0:215:a05d:fb05 with SMTP id
 d9443c01a7336-221040a91bbmr105990225ad.32.1739747841846; 
 Sun, 16 Feb 2025 15:17:21 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 091/162] tcg: Rename INDEX_op_bswap64_i64 to
 INDEX_op_bswap64
Date: Sun, 16 Feb 2025 15:09:00 -0800
Message-ID: <20250216231012.2808572-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index 3d3a95367e..0a81a115be 100644
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
@@ -5459,7 +5459,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


