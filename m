Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18426C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4b-0002pf-E2; Fri, 25 Apr 2025 17:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4K-0001jC-Gi
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4H-0000qv-I1
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22409077c06so44288665ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618324; x=1746223124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZryJBQkGl8ZJnT4kJFtTxmPhSogRsDoz8AWqfGxuzZc=;
 b=SxPFAt6W39amsGcwB535EM4XfR5YtCRCqef5zZ57JZN9WSmbWtcSqO66B1RrLhWOhP
 GheX9dZUy2QG50ddpl88G19NUsu3xlB68DeJXe3UQNBO6HaJNzcNrYpYo350mSInM3Rg
 Ujyz37GXba6l7wEZxfCnAf4AJEdVjf/X8kuSZzlCdH6O9kMMASX588nbKIsKIuRMq06t
 89ItEZ/VgYZVWSiYfPLlvUXh54Z3gMnRlcFN60RSMO7HzDSeKKa+lGle7ePLboy9JcMG
 O7FIMtVlvlncL2nqprbf6NQo65kUf9EjUtXPcWYhX/W+u5ZT77rP4+IGGuuttHwpoASk
 Dx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618324; x=1746223124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZryJBQkGl8ZJnT4kJFtTxmPhSogRsDoz8AWqfGxuzZc=;
 b=YH9MEnQw0TLKUmZO3ut82vrnBq9k1+OvjcYEEoLTF9Um89g/2HCKVI5I4znhlhKFY+
 5s8rlNDcNFPPwZoBj/lx1EN/pzwICSBcxgAutPaCpt7ZaJDSoMw5oEq96KSF0BdvPYoj
 pva4o6MlJ16GLRpYX0/u5sKl751N6W8lBtpSGzk1uq1H1x5ZvOPGYmuZVtadEtLLfK3q
 uTXGzQ76wM2sd3xdDEWwIT5YrYaYbyc3X5tqvZvNOb6X6Xu73kx5hLzqg64jRJyFuN2N
 njSoafuZA1+648XAKBdCZw5IOcuGJ0wZnKkjar6QIhk4/PjGaURLfiFg87uweKMGmbJ3
 ZWPQ==
X-Gm-Message-State: AOJu0YwLp9PUqkSKLckak7rmAqQiA1z5ZwkZuau/sfPS6vLwyoWpluPp
 uvo9uSLqZCRRDFcj8Gd32DIUnDbazMgx/0xBZuiMggMgOfgKjZ8UgK91mFCEUKqZdyUlvwAU4Yc
 8
X-Gm-Gg: ASbGnctdKDgxPHffGRGXOzIJx7QwKFUuf2mDR1USua6gk5TOjEh6gRqUvGwk4b7YnAA
 CRnF4qvy21xf+Jad8STRbVOdrxTN4OGyKRVCAXbqXxoVmIDHailKYDBfdbfPTKZjc/ahG2nP9Jd
 4FccBmGWFetaY25klqiJvCLzWbapKUGtAghgiosRkDbxxBKa2hh+3TS4h+olYTih9inycCh/jYu
 1u8kjqS4RQLK+r1fLeRP5Xk3C4J9+x/5x6bn4NPU7IKggtwe5XAnG+9vppsr4Ro3u4eRoTwwDdN
 VN0bm12z/H8GCo7LbK6ENM5zi3OXTAdqvk0fHCO4YeDsJhxH565ebr4ReqCTcch6fqkasXUatUg
 =
X-Google-Smtp-Source: AGHT+IGEeALd0j1soMrP1HhupjRzgBQkeHwXt9IbVKa/krEhnp108TAS6EbMi5k3QHwhRlM4Y6km/A==
X-Received: by 2002:a17:903:18b:b0:223:5ace:eccf with SMTP id
 d9443c01a7336-22dbf5fa8bcmr57048865ad.25.1745618323743; 
 Fri, 25 Apr 2025 14:58:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 062/159] tcg: Merge INDEX_op_sar_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:16 -0700
Message-ID: <20250425215454.886111-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 12 ++++++------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 12 ++++--------
 docs/devel/tcg-ops.rst   |  4 ++--
 tcg/tci/tcg-target.c.inc |  3 +--
 7 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 35e0be8f80..cb8c134e94 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -58,6 +58,7 @@ DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(remu, 1, 2, 0, TCG_OPF_INT)
+DEF(sar, 1, 2, 0, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
@@ -76,7 +77,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, 0)
 DEF(rotr_i32, 1, 2, 0, 0)
 DEF(deposit_i32, 1, 2, 2, 0)
@@ -115,7 +115,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(sar_i64, 1, 2, 0, 0)
 DEF(rotl_i64, 1, 2, 0, 0)
 DEF(rotr_i64, 1, 2, 0, 0)
 DEF(deposit_i64, 1, 2, 2, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 43db079693..f94be19b72 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -458,10 +458,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (uint64_t)x >> (y & 63);
 
-    case INDEX_op_sar_i32:
-        return (int32_t)x >> (y & 31);
-
-    case INDEX_op_sar_i64:
+    case INDEX_op_sar:
+        if (type == TCG_TYPE_I32) {
+            return (int32_t)x >> (y & 31);
+        }
         return (int64_t)x >> (y & 63);
 
     case INDEX_op_rotr_i32:
@@ -2600,7 +2600,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
     }
 
     switch (op->opc) {
-    CASE_OP_32_64(sar):
+    case INDEX_op_sar:
         /*
          * Arithmetic right shift will not reduce the number of
          * input sign repetitions.
@@ -3027,7 +3027,7 @@ void tcg_optimize(TCGContext *s)
             break;
         CASE_OP_32_64(rotl):
         CASE_OP_32_64(rotr):
-        CASE_OP_32_64(sar):
+        case INDEX_op_sar:
         case INDEX_op_shl:
         case INDEX_op_shr:
             done = fold_shift(&ctx, op);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ef8cf5a1ac..43848ebc4f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -511,7 +511,7 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_sar_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_sar, ret, arg1, arg2);
 }
 
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1624,7 +1624,7 @@ void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sar_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
     } else {
         gen_helper_sar_i64(ret, arg1, arg2);
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ffe9efbf79..8f67107190 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1042,8 +1042,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
-    OUTOP(INDEX_op_sar_i32, TCGOutOpBinary, outop_sar),
-    OUTOP(INDEX_op_sar_i64, TCGOutOpBinary, outop_sar),
+    OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -5421,8 +5420,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
+    case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 376b1b1ece..2a2f216898 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -625,9 +625,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] >> (regs[r2] % TCG_TARGET_REG_BITS);
             break;
-        case INDEX_op_sar_i32:
+        case INDEX_op_sar:
             tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int32_t)regs[r1] >> (regs[r2] & 31);
+            regs[r0] = ((tcg_target_long)regs[r1]
+                        >> (regs[r2] % TCG_TARGET_REG_BITS));
             break;
 #if TCG_TARGET_HAS_rot_i32
         case INDEX_op_rotl_i32:
@@ -787,10 +788,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-        case INDEX_op_sar_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int64_t)regs[r1] >> (regs[r2] & 63);
-            break;
 #if TCG_TARGET_HAS_rot_i64
         case INDEX_op_rotl_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -1073,12 +1070,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
+    case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index f9fd4b0087..be82fed41a 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -389,10 +389,10 @@ Shifts/Rotates
      - | *t0* = *t1* >> *t2* (unsigned)
        | Unspecified behavior for negative or out-of-range shifts.
 
-   * - sar_i32/i64 *t0*, *t1*, *t2*
+   * - sar *t0*, *t1*, *t2*
 
      - | *t0* = *t1* >> *t2* (signed)
-       | Unspecified behavior if *t2* < 0 or *t2* >= 32 (resp 64)
+       | Unspecified behavior for negative or out-of-range shifts.
 
    * - rotl_i32/i64 *t0*, *t1*, *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index f50a2d6574..feaa13dff0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -779,7 +779,7 @@ static void tgen_sar(TCGContext *s, TCGType type,
         tcg_out_ext32s(s, TCG_REG_TMP, a1);
         a1 = TCG_REG_TMP;
     }
-    tcg_out_op_rrr(s, glue(INDEX_op_sar_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_sar = {
@@ -897,7 +897,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
-- 
2.43.0


