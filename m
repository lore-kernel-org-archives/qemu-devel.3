Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F305CC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnym-0000I6-QP; Sun, 16 Feb 2025 18:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwy-0004sk-T8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:26 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwq-0006Vm-9e
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:24 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so5727098a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748074; x=1740352874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eXNRumtMCkrabiXY1R8vBAphXiwwXaPaRXCbLIwGcg4=;
 b=k7B2MT1vyKv26bZinMNpKHt5T2fMib/6j9gmMMV9Z0q9B6UJthKNUjqzcDh1qHPT8b
 Tjphg/Ba6j4k36sx2a29kP3ozaaGflTXDYmF7eylCcUhlkhAyr2nQagg/6auESU50fGv
 YUDBGg2bFoH8bER2rqsbDb+U4G+c1sEWpj7Q+XGjrs8u+91Zh6VT+G/52Y03NsN8RXCT
 0Z+0RBKsXQyWDtv2vxPt2oGxhMc3ecRQMSeh5hMrhqJqE7Kqh9UagtvpiBBRRxB0OG0J
 BtTEnGPkaVDJM7bY8JPWcgV9PhwoNVSz1xopYKwYWTNALK6hoHZG9V3HTywoPNmDIdFr
 VqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748074; x=1740352874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXNRumtMCkrabiXY1R8vBAphXiwwXaPaRXCbLIwGcg4=;
 b=gTNBL5SnxPRVvA8T73Ylo7tiLm25lUQnHxrbe1Ga+lPRZFO4RPhT0ezt/GRMYsImgg
 Kc0r5pfFc1rWgwvaM/0/JbOA6SmKx6odNBD+ktZ1l5ZKYgPr/c4PAH/mXb2j/fhaudk7
 qF3GlciGG3cTlzywezJT8O/N8WLNqGHkxellwH9gtHCfdTW2TUdp7DEbiQI6FbAeDDZs
 87vSBPHAHQDCl6QhHDanGulD2AjJHVTiIVkj4SwwaQASnKG3A7cw7QnJVNXhL/ck2EI1
 fFwvUQ0BSjUAddJIlevBArNzZdDpjhuZP4dJJ+rAw/gS6pvaCjPC2WVpGBYZTaKYNCJA
 Myig==
X-Gm-Message-State: AOJu0Yyr1SPlvBLumKxn1Sm4J7SVYCpchLLJs3lvkHaz9vRy8gA/lGsN
 ivReYEpby6yczTzn4NkqCvrz6jMaWAzOcCY4T497cXOLoCBGnYErCfFvk9PY+ivbnNrtENo1BPq
 R
X-Gm-Gg: ASbGncuMRAwCAJ4FMCwMuTFcScRujzHQxbe/t5+phC/SpFESf538sqJGsZv3ZwmIVGs
 9Tor1E+DBmNG2FvStSRae2Smhptt7w9UV7kd9nWM5gW5onS2Bj8BeMGl/L3tFcO5MnVe6I83uGo
 cw+N27e1eu1qwvxj4GmrcEZG3Rzhxr91XGnRg7w/xlF55BEOUN7Bm1ZdSw3ShXKZkvkzPNm1gan
 v0CB+qFjsr2N7o+vRgDduCmS3CoXfz/YgTRM7d7LVZq3bsp9Q5zwDpKkrNt/g5QJuO2TZXJvb11
 oVt8VvUpaAapWSIN6KPaSFT9jBExRuDwUKbyH2zY0t6ere0=
X-Google-Smtp-Source: AGHT+IHpgeE/N6/OfiOPz7Li0s4UYovbOAQv+BHCsw+h9VX33aJvYgp1XWovOpFwfnUb13SowC/WtQ==
X-Received: by 2002:a17:90b:3d86:b0:2f4:4500:bb4d with SMTP id
 98e67ed59e1d1-2fc40f233f9mr11664124a91.20.1739748074224; 
 Sun, 16 Feb 2025 15:21:14 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 156/162] tcg: Merge INDEX_op_st*_{i32,i64}
Date: Sun, 16 Feb 2025 15:10:05 -0800
Message-ID: <20250216231012.2808572-157-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 15 ++++----------
 tcg/optimize.c           | 28 +++++++------------------
 tcg/tcg-op.c             | 14 ++++++-------
 tcg/tcg.c                | 45 +++++++++++++---------------------------
 tcg/tci.c                | 36 +++++++++-----------------------
 tcg/tci/tcg-target.c.inc | 20 +++++++-----------
 6 files changed, 50 insertions(+), 108 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 6e8fcefaef..a22433d8b5 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -86,6 +86,10 @@ DEF(setcond, 1, 2, 1, TCG_OPF_INT)
 DEF(sextract, 1, 1, 2, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(shr, 1, 2, 0, TCG_OPF_INT)
+DEF(st8, 0, 2, 1, TCG_OPF_INT)
+DEF(st16, 0, 2, 1, TCG_OPF_INT)
+DEF(st32, 0, 2, 1, TCG_OPF_INT)
+DEF(st, 0, 2, 1, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
@@ -99,20 +103,9 @@ DEF(subb1o, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
 DEF(subbi, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN)
 DEF(subbio, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN | TCG_OPF_CARRY_OUT)
 
-/* load/store */
-DEF(st8_i32, 0, 2, 1, 0)
-DEF(st16_i32, 0, 2, 1, 0)
-DEF(st_i32, 0, 2, 1, 0)
-
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
-/* load/store */
-DEF(st8_i64, 0, 2, 1, 0)
-DEF(st16_i64, 0, 2, 1, 0)
-DEF(st32_i64, 0, 2, 1, 0)
-DEF(st_i64, 0, 2, 1, 0)
-
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, 0)
 DEF(extu_i32_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1da23755e3..cbc519624a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -30,14 +30,6 @@
 #include "tcg-internal.h"
 #include "tcg-has.h"
 
-#define CASE_OP_32_64(x)                        \
-        glue(glue(case INDEX_op_, x), _i32):    \
-        glue(glue(case INDEX_op_, x), _i64)
-
-#define CASE_OP_32_64_VEC(x)                    \
-        glue(glue(case INDEX_op_, x), _i32):    \
-        glue(glue(case INDEX_op_, x), _i64):    \
-        glue(glue(case INDEX_op_, x), _vec)
 
 typedef struct MemCopyInfo {
     IntervalTreeNode itree;
@@ -2926,19 +2918,16 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
     }
 
     switch (op->opc) {
-    CASE_OP_32_64(st8):
+    case INDEX_op_st8:
         lm1 = 0;
         break;
-    CASE_OP_32_64(st16):
+    case INDEX_op_st16:
         lm1 = 1;
         break;
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i32:
+    case INDEX_op_st32:
         lm1 = 3;
         break;
-    case INDEX_op_st_i64:
-        lm1 = 7;
-        break;
+    case INDEX_op_st:
     case INDEX_op_st_vec:
         lm1 = tcg_type_size(ctx->type) - 1;
         break;
@@ -3126,13 +3115,12 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_ld_vec:
             done = fold_tcg_ld_memcopy(&ctx, op);
             break;
-        CASE_OP_32_64(st8):
-        CASE_OP_32_64(st16):
-        case INDEX_op_st32_i64:
+        case INDEX_op_st8:
+        case INDEX_op_st16:
+        case INDEX_op_st32:
             done = fold_tcg_st(&ctx, op);
             break;
-        case INDEX_op_st_i32:
-        case INDEX_op_st_i64:
+        case INDEX_op_st:
         case INDEX_op_st_vec:
             done = fold_tcg_st_memcopy(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 680f752cf9..dfa5c38728 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1404,17 +1404,17 @@ void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_st8_i32, arg1, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
 }
 
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_st16_i32, arg1, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
 }
 
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_st, arg1, arg2, offset);
 }
 
 
@@ -1540,7 +1540,7 @@ void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st8_i64, arg1, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
     } else {
         tcg_gen_st8_i32(TCGV_LOW(arg1), arg2, offset);
     }
@@ -1549,7 +1549,7 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st16_i64, arg1, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
     } else {
         tcg_gen_st16_i32(TCGV_LOW(arg1), arg2, offset);
     }
@@ -1558,7 +1558,7 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st32_i64, arg1, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
     } else {
         tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
     }
@@ -1567,7 +1567,7 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
     } else if (HOST_BIG_ENDIAN) {
         tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset);
         tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset + 4);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 765885aecf..f752729f80 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1219,12 +1219,9 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_sextract, TCGOutOpExtract, outop_sextract),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
-    OUTOP(INDEX_op_st_i32, TCGOutOpStore, outop_st),
-    OUTOP(INDEX_op_st_i64, TCGOutOpStore, outop_st),
-    OUTOP(INDEX_op_st8_i32, TCGOutOpStore, outop_st8),
-    OUTOP(INDEX_op_st8_i64, TCGOutOpStore, outop_st8),
-    OUTOP(INDEX_op_st16_i32, TCGOutOpStore, outop_st16),
-    OUTOP(INDEX_op_st16_i64, TCGOutOpStore, outop_st16),
+    OUTOP(INDEX_op_st, TCGOutOpStore, outop_st),
+    OUTOP(INDEX_op_st8, TCGOutOpStore, outop_st8),
+    OUTOP(INDEX_op_st16, TCGOutOpStore, outop_st16),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_subbi, TCGOutOpAddSubCarry, outop_subbi),
     OUTOP(INDEX_op_subbio, TCGOutOpAddSubCarry, outop_subbio),
@@ -1246,7 +1243,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
     OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
     OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
-    OUTOP(INDEX_op_st32_i64, TCGOutOpStore, outop_st),
+    OUTOP(INDEX_op_st32, TCGOutOpStore, outop_st),
 #endif
 };
 
@@ -2464,24 +2461,19 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_or:
     case INDEX_op_setcond:
     case INDEX_op_sextract:
+    case INDEX_op_st8:
+    case INDEX_op_st16:
+    case INDEX_op_st:
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st_i32:
-        return true;
-
     case INDEX_op_brcond2_i32:
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
     case INDEX_op_ld32u:
     case INDEX_op_ld32s:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i64:
+    case INDEX_op_st32:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -4467,10 +4459,7 @@ liveness_pass_2(TCGContext *s)
                 arg_ts->state = 0;
 
                 if (NEED_SYNC_ARG(0)) {
-                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
-                                      ? INDEX_op_st_i32
-                                      : INDEX_op_st_i64);
-                    TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
+                    TCGOp *sop = tcg_op_insert_after(s, op, INDEX_op_st, 3);
                     TCGTemp *out_ts = dir_ts;
 
                     if (IS_DEAD_ARG(0)) {
@@ -4504,10 +4493,7 @@ liveness_pass_2(TCGContext *s)
 
                 /* Sync outputs upon their last write.  */
                 if (NEED_SYNC_ARG(i)) {
-                    TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
-                                      ? INDEX_op_st_i32
-                                      : INDEX_op_st_i64);
-                    TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
+                    TCGOp *sop = tcg_op_insert_after(s, op, INDEX_op_st, 3);
 
                     TCGOP_TYPE(sop) = arg_ts->type;
                     sop->args[0] = temp_arg(dir_ts);
@@ -5758,16 +5744,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_st32_i64:
+    case INDEX_op_st32:
         /* Use tcg_op_st w/ I32. */
         type = TCG_TYPE_I32;
         /* fall through */
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
+    case INDEX_op_st:
+    case INDEX_op_st8:
+    case INDEX_op_st16:
         {
             const TCGOutOpStore *out =
                 container_of(all_outop[op->opc], TCGOutOpStore, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 890ccbe85b..b08288e7d3 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -325,18 +325,6 @@ static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
     }
 }
 
-#if TCG_TARGET_REG_BITS == 64
-# define CASE_32_64(x) \
-        case glue(glue(INDEX_op_, x), _i64): \
-        case glue(glue(INDEX_op_, x), _i32):
-# define CASE_64(x) \
-        case glue(glue(INDEX_op_, x), _i64):
-#else
-# define CASE_32_64(x) \
-        case glue(glue(INDEX_op_, x), _i32):
-# define CASE_64(x)
-#endif
-
 /* Interpret pseudo code in tb. */
 /*
  * Disable CFI checks.
@@ -491,21 +479,20 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(tcg_target_ulong *)ptr;
             break;
-        CASE_32_64(st8)
+        case INDEX_op_st8:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             *(uint8_t *)ptr = regs[r0];
             break;
-        CASE_32_64(st16)
+        case INDEX_op_st16:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             *(uint16_t *)ptr = regs[r0];
             break;
-        case INDEX_op_st_i32:
-        CASE_64(st32)
+        case INDEX_op_st:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
-            *(uint32_t *)ptr = regs[r0];
+            *(tcg_target_ulong *)ptr = regs[r0];
             break;
 
             /* Arithmetic operations (mixed 32/64 bit). */
@@ -725,10 +712,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(int32_t *)ptr;
             break;
-        case INDEX_op_st_i64:
+        case INDEX_op_st32:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
-            *(uint64_t *)ptr = regs[r0];
+            *(uint32_t *)ptr = regs[r0];
             break;
 
             /* Arithmetic operations (64 bit). */
@@ -975,13 +962,10 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_ld16s:
     case INDEX_op_ld32u:
     case INDEX_op_ld:
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i32:
-    case INDEX_op_st_i64:
+    case INDEX_op_st8:
+    case INDEX_op_st16:
+    case INDEX_op_st32:
+    case INDEX_op_st:
         tci_args_rrs(insn, &r0, &r1, &s2);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %d",
                            op_name, str_r(r0), str_r(r1), s2);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index be9270a861..1fb7575061 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1173,7 +1173,7 @@ static const TCGOutOpLoad outop_ld32s = {
 static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
                      TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, INDEX_op_st8_i32, data, base, offset);
+    tcg_out_ldst(s, INDEX_op_st8, data, base, offset);
 }
 
 static const TCGOutOpStore outop_st8 = {
@@ -1184,7 +1184,7 @@ static const TCGOutOpStore outop_st8 = {
 static void tgen_st16(TCGContext *s, TCGType type, TCGReg data,
                       TCGReg base, ptrdiff_t offset)
 {
-    tcg_out_ldst(s, INDEX_op_st16_i32, data, base, offset);
+    tcg_out_ldst(s, INDEX_op_st16, data, base, offset);
 }
 
 static const TCGOutOpStore outop_st16 = {
@@ -1232,18 +1232,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
                        intptr_t offset)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_out_ldst(s, INDEX_op_st_i32, val, base, offset);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-        tcg_out_ldst(s, INDEX_op_st_i64, val, base, offset);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
+    TCGOpcode op = INDEX_op_st;
+
+    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+        op = INDEX_op_st32;
     }
+    tcg_out_ldst(s, op, val, base, offset);
 }
 
 static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
-- 
2.43.0


