Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344C2C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnr2-0003b6-Mr; Sun, 16 Feb 2025 18:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqD-00019C-2m
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:26 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnq1-0005TT-A9
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:22 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so5314392a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747650; x=1740352450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rtLHXA13mkUmYzNTuWijRJvMWqY2p+oYvsw4Tv6yzEo=;
 b=Z5GR+I1c0irwcvSPkv4ZlDVCb6Br8USJ1xjC7MymDGY697/4Y4vTUTx8x+l4WACU1n
 1b5cXwBh0O14379oMxhX4TUlgWkdqjEo3VDgSVGJJ6sUQKubDTULQ+WJYDbPlVqPhdWd
 zU/XYWn3GQbOvN+TUwsuPQMs9izBKjTkz0XR1HvPnuTf/6/0Lo2eZoX6bFUZxIgUK+LI
 yzEC1wfxitQoFeQwr8Q1th6Vzw9KnDneCwnXv2z3vD9TQnWBQlpfjlgWLDgsBTsvIBgN
 GYSXb2WJ4xjQVXD77vlmw04ejhNKN0bovWA2RZJa9hjaa1ofSZe2cldltjgzq+Bvvima
 JX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747650; x=1740352450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rtLHXA13mkUmYzNTuWijRJvMWqY2p+oYvsw4Tv6yzEo=;
 b=hKvGp1IM4cURNZ8QfAlw6J5qY8rm08SmfGmU/JvheQAPCe3yxuQdcN3SF8fJYU0u/k
 QHhicvakuD5emTZuJ+S37KnvIv4z14QsIwWYTBfVkMqhhhvut24KX2FOTs815Z4K5M+A
 O/q6UsggwOkztfqpcGhYesDAQuAd/rG2YOaaeS1VZCQAlkaTAU/TnI/0KFAlmEdU+XTC
 fAoHkVTThpVNtvrgmYkskcM+fKiV/uyly4g9wiXL0kKeXIGDu9S66OUhGYq/fRDj/1CO
 BKJ2duoSIgkN/OeUkUqchZpj5kQFr3+aG8PiRVHxEleabjI+mHdktvYc49BG4UVqLtWz
 Y2lA==
X-Gm-Message-State: AOJu0YzkzG3kDLpCr6Di6SlkJjqCXlXXAdKujRkMPCZKcTOzBs/O5gcL
 VR48H/bxVxJmDQPQm5bfdjlJr705FEih3d+vd+cYNDC72nXZdDlFAYlgBJKZrraTt0zfKOgmdOV
 z
X-Gm-Gg: ASbGnctl6EIoB1JQPhInMUqzoOXWSfYS6JBw9Z1Gi0TED4sZzHfEx6wFsHPnB9betAk
 Ck0PF90NWq+3iplNTUJtMDtxCzf4qmMFtAxMFvD6BJMyL2kMbys2dRkwUOP7+RH+ooN3ocmOWa9
 yK/3mUklshJ57r12MbxkfezUgrx6sc42qDI/bc5MSwFgJkf8C+SicR0XpmzRNG3+IOU2gw1SBBO
 yQEc9LAVhvS+yKP0jETajjGMp9LFPg4UKROLDO49aygRuo+yzsueemXhniRSWfQc8OBHACldFK9
 IzXHwe0dhl5O34D3hFlIRF34MbaHRT/Kkt/ubX/OS/15ss4=
X-Google-Smtp-Source: AGHT+IH/WTlzhwTO9NqZOGZ/pe9bEyxWGHxNu20lzA6yWepmPzBa1AdKSYna4lvPtTAPiE/kb2h3Mw==
X-Received: by 2002:a17:90b:2f85:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-2fc407915f8mr14607893a91.0.1739747649795; 
 Sun, 16 Feb 2025 15:14:09 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 075/162] tcg: Convert setcond, negsetcond to TCGOutOpSetcond
Date: Sun, 16 Feb 2025 15:08:44 -0800
Message-ID: <20250216231012.2808572-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 tcg/mips/tcg-target-con-set.h    |   2 +-
 tcg/sparc64/tcg-target-con-set.h |   1 -
 tcg/tcg.c                        |  31 ++++++++
 tcg/aarch64/tcg-target.c.inc     | 121 ++++++++++++++++++++-----------
 tcg/arm/tcg-target.c.inc         | 117 +++++++++++++++++++++---------
 tcg/i386/tcg-target.c.inc        |  57 +++++++++++----
 tcg/loongarch64/tcg-target.c.inc |  51 +++++++++----
 tcg/mips/tcg-target.c.inc        |  39 +++++-----
 tcg/ppc/tcg-target.c.inc         |  61 ++++++++++------
 tcg/riscv/tcg-target.c.inc       |  52 +++++++++----
 tcg/s390x/tcg-target.c.inc       |  64 +++++++++-------
 tcg/sparc64/tcg-target.c.inc     |  69 +++++++++++++-----
 tcg/tci/tcg-target.c.inc         |  49 +++++++------
 13 files changed, 477 insertions(+), 237 deletions(-)

diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index 248bc95d9b..67dfab2aed 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -23,8 +23,8 @@ C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rJ)
+C_O1_I2(r, r, rz)
 C_O1_I2(r, r, rzW)
-C_O1_I2(r, rz, rz)
 C_O1_I4(r, rz, rz, rz, 0)
 C_O1_I4(r, rz, rz, rz, rz)
 C_O2_I1(r, r, r)
diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 85dcfbc375..ca7bbf0a2f 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -15,7 +15,6 @@ C_O0_I2(rz, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rJ)
-C_O1_I2(r, rz, rJ)
 C_O1_I4(r, rz, rJ, rI, 0)
 C_O2_I2(r, r, r, r)
 C_O2_I4(r, r, rz, rz, rJ, rJ)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 58f764c8a4..e73942deae 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1003,6 +1003,14 @@ typedef struct TCGOutOpUnary {
     void (*out_rr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1);
 } TCGOutOpUnary;
 
+typedef struct TCGOutOpSetcond {
+    TCGOutOp base;
+    void (*out_rrr)(TCGContext *s, TCGType type, TCGCond cond,
+                    TCGReg ret, TCGReg a1, TCGReg a2);
+    void (*out_rri)(TCGContext *s, TCGType type, TCGCond cond,
+                    TCGReg ret, TCGReg a1, tcg_target_long a2);
+} TCGOutOpSetcond;
+
 typedef struct TCGOutOpSubtract {
     TCGOutOp base;
     void (*out_rrr)(TCGContext *s, TCGType type,
@@ -1047,6 +1055,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
+    OUTOP(INDEX_op_negsetcond_i32, TCGOutOpSetcond, outop_negsetcond),
+    OUTOP(INDEX_op_negsetcond_i64, TCGOutOpSetcond, outop_negsetcond),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
@@ -1056,6 +1066,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
     OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
+    OUTOP(INDEX_op_setcond_i32, TCGOutOpSetcond, outop_setcond),
+    OUTOP(INDEX_op_setcond_i64, TCGOutOpSetcond, outop_setcond),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -5470,6 +5482,25 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        {
+            const TCGOutOpSetcond *out =
+                container_of(all_outop[op->opc], TCGOutOpSetcond, base);
+            TCGCond cond = new_args[3];
+
+            tcg_debug_assert(!const_args[1]);
+            if (const_args[2]) {
+                out->out_rri(s, type, cond,
+                             new_args[0], new_args[1], new_args[2]);
+            } else {
+                out->out_rrr(s, type, cond,
+                             new_args[0], new_args[1], new_args[2]);
+            }
+        }
+        break;
 
     default:
         if (def->flags & TCG_OPF_VECTOR) {
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 46ad91f40e..2524e73ff4 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1356,25 +1356,37 @@ static inline void tcg_out_dep(TCGContext *s, TCGType ext, TCGReg rd,
     tcg_out_bfm(s, ext, rd, rn, a, b);
 }
 
+static void tgen_cmp(TCGContext *s, TCGType ext, TCGCond cond,
+                     TCGReg a, TCGReg b)
+{
+    if (is_tst_cond(cond)) {
+        tcg_out_insn(s, 3510, ANDS, ext, TCG_REG_XZR, a, b);
+    } else {
+        tcg_out_insn(s, 3502, SUBS, ext, TCG_REG_XZR, a, b);
+    }
+}
+
+static void tgen_cmpi(TCGContext *s, TCGType ext, TCGCond cond,
+                      TCGReg a, tcg_target_long b)
+{
+    if (is_tst_cond(cond)) {
+        tcg_out_logicali(s, I3404_ANDSI, ext, TCG_REG_XZR, a, b);
+    } else if (b >= 0) {
+        tcg_debug_assert(is_aimm(b));
+        tcg_out_insn(s, 3401, SUBSI, ext, TCG_REG_XZR, a, b);
+    } else {
+        tcg_debug_assert(is_aimm(-b));
+        tcg_out_insn(s, 3401, ADDSI, ext, TCG_REG_XZR, a, -b);
+    }
+}
+
 static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGCond cond, TCGReg a,
                         tcg_target_long b, bool const_b)
 {
-    if (is_tst_cond(cond)) {
-        if (!const_b) {
-            tcg_out_insn(s, 3510, ANDS, ext, TCG_REG_XZR, a, b);
-        } else {
-            tcg_out_logicali(s, I3404_ANDSI, ext, TCG_REG_XZR, a, b);
-        }
+    if (const_b) {
+        tgen_cmpi(s, ext, cond, a, b);
     } else {
-        if (!const_b) {
-            tcg_out_insn(s, 3502, SUBS, ext, TCG_REG_XZR, a, b);
-        } else if (b >= 0) {
-            tcg_debug_assert(is_aimm(b));
-            tcg_out_insn(s, 3401, SUBSI, ext, TCG_REG_XZR, a, b);
-        } else {
-            tcg_debug_assert(is_aimm(-b));
-            tcg_out_insn(s, 3401, ADDSI, ext, TCG_REG_XZR, a, -b);
-        }
+        tgen_cmp(s, ext, cond, a, b);
     }
 }
 
@@ -2433,6 +2445,59 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_cset(TCGContext *s, TCGCond cond, TCGReg ret)
+{
+    /* Use CSET alias of CSINC Wd, WZR, WZR, invert(cond).  */
+    tcg_out_insn(s, 3506, CSINC, TCG_TYPE_I32, ret, TCG_REG_XZR,
+                 TCG_REG_XZR, tcg_invert_cond(cond));
+}
+
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_cmp(s, type, cond, a1, a2);
+    tgen_cset(s, cond, a0);
+}
+
+static void tgen_setcondi(TCGContext *s, TCGType type, TCGCond cond,
+                          TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_cmpi(s, type, cond, a1, a2);
+    tgen_cset(s, cond, a0);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, rC),
+    .out_rrr = tgen_setcond,
+    .out_rri = tgen_setcondi,
+};
+
+static void tgen_csetm(TCGContext *s, TCGType ext, TCGCond cond, TCGReg ret)
+{
+    /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
+    tcg_out_insn(s, 3506, CSINV, ext, ret, TCG_REG_XZR,
+                 TCG_REG_XZR, tcg_invert_cond(cond));
+}
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_cmp(s, type, cond, a1, a2);
+    tgen_csetm(s, type, cond, a0);
+}
+
+static void tgen_negsetcondi(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_cmpi(s, type, cond, a1, a2);
+    tgen_csetm(s, type, cond, a0);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, rC),
+    .out_rrr = tgen_negsetcond,
+    .out_rri = tgen_negsetcondi,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2507,26 +2572,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_brcond(s, ext, a2, a0, a1, const_args[1], arg_label(args[3]));
         break;
 
-    case INDEX_op_setcond_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_setcond_i64:
-        tcg_out_cmp(s, ext, args[3], a1, a2, c2);
-        /* Use CSET alias of CSINC Wd, WZR, WZR, invert(cond).  */
-        tcg_out_insn(s, 3506, CSINC, TCG_TYPE_I32, a0, TCG_REG_XZR,
-                     TCG_REG_XZR, tcg_invert_cond(args[3]));
-        break;
-
-    case INDEX_op_negsetcond_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_negsetcond_i64:
-        tcg_out_cmp(s, ext, args[3], a1, a2, c2);
-        /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
-        tcg_out_insn(s, 3506, CSINV, ext, a0, TCG_REG_XZR,
-                     TCG_REG_XZR, tcg_invert_cond(args[3]));
-        break;
-
     case INDEX_op_movcond_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3114,12 +3159,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rC);
-
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(r, rC);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 93c07880f1..56a4166e02 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1216,31 +1216,48 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
     }
 }
 
-static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
-                           TCGArg b, int b_const)
+static TCGCond tgen_cmp(TCGContext *s, TCGCond cond, TCGReg a, TCGReg b)
 {
+    if (is_tst_cond(cond)) {
+        tcg_out_dat_reg(s, COND_AL, ARITH_TST, 0, a, b, SHIFT_IMM_LSL(0));
+        return tcg_tst_eqne_cond(cond);
+    }
+    tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, a, b, SHIFT_IMM_LSL(0));
+    return cond;
+}
+
+static TCGCond tgen_cmpi(TCGContext *s, TCGCond cond, TCGReg a, TCGArg b)
+{
+    int imm12;
+
     if (!is_tst_cond(cond)) {
-        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b, b_const);
+        tcg_out_dat_IN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b);
         return cond;
     }
 
-    cond = tcg_tst_eqne_cond(cond);
-    if (b_const) {
-        int imm12 = encode_imm(b);
-
-        /*
-         * The compare constraints allow rIN, but TST does not support N.
-         * Be prepared to load the constant into a scratch register.
-         */
-        if (imm12 >= 0) {
-            tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, a, imm12);
-            return cond;
-        }
+    /*
+     * The compare constraints allow rIN, but TST does not support N.
+     * Be prepared to load the constant into a scratch register.
+     */
+    imm12 = encode_imm(b);
+    if (imm12 >= 0) {
+        tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, a, imm12);
+    } else {
         tcg_out_movi32(s, COND_AL, TCG_REG_TMP, b);
-        b = TCG_REG_TMP;
+        tcg_out_dat_reg(s, COND_AL, ARITH_TST, 0,
+                        a, TCG_REG_TMP, SHIFT_IMM_LSL(0));
+    }
+    return tcg_tst_eqne_cond(cond);
+}
+
+static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
+                           TCGArg b, int b_const)
+{
+    if (b_const) {
+        return tgen_cmpi(s, cond, a, b);
+    } else {
+        return tgen_cmp(s, cond, a, b);
     }
-    tcg_out_dat_reg(s, COND_AL, ARITH_TST, 0, a, b, SHIFT_IMM_LSL(0));
-    return cond;
 }
 
 static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
@@ -2170,6 +2187,52 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void finish_setcond(TCGContext *s, TCGCond cond, TCGReg ret, bool neg)
+{
+    tcg_out_movi32(s, tcg_cond_to_arm_cond[tcg_invert_cond(cond)], ret, 0);
+    tcg_out_movi32(s, tcg_cond_to_arm_cond[cond], ret, neg ? -1 : 1);
+}
+
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    cond = tgen_cmp(s, cond, a1, a2);
+    finish_setcond(s, cond, a0, false);
+}
+
+static void tgen_setcondi(TCGContext *s, TCGType type, TCGCond cond,
+                          TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    cond = tgen_cmpi(s, cond, a1, a2);
+    finish_setcond(s, cond, a0, false);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, rIN),
+    .out_rrr = tgen_setcond,
+    .out_rri = tgen_setcondi,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    cond = tgen_cmp(s, cond, a1, a2);
+    finish_setcond(s, cond, a0, true);
+}
+
+static void tgen_negsetcondi(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    cond = tgen_cmpi(s, cond, a1, a2);
+    finish_setcond(s, cond, a0, true);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, rIN),
+    .out_rrr = tgen_negsetcond,
+    .out_rri = tgen_negsetcondi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2264,20 +2327,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = tcg_out_cmp(s, args[2], args[0], args[1], const_args[1]);
         tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[3]));
         break;
-    case INDEX_op_setcond_i32:
-        c = tcg_out_cmp(s, args[3], args[1], args[2], const_args[2]);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c],
-                        ARITH_MOV, args[0], 0, 1);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
-                        ARITH_MOV, args[0], 0, 0);
-        break;
-    case INDEX_op_negsetcond_i32:
-        c = tcg_out_cmp(s, args[3], args[1], args[2], const_args[2]);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c],
-                        ARITH_MVN, args[0], 0, 0);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
-                        ARITH_MOV, args[0], 0, 0);
-        break;
 
     case INDEX_op_brcond2_i32:
         c = tcg_out_cmp2(s, args, const_args);
@@ -2378,10 +2427,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_negsetcond_i32:
-        return C_O1_I2(r, r, rIN);
-
     case INDEX_op_brcond_i32:
         return C_O0_I2(r, rIN);
     case INDEX_op_deposit_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index cb09427c58..d4549a4c52 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1679,10 +1679,11 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
-                            TCGArg dest, TCGArg arg1, TCGArg arg2,
-                            int const_arg2, bool neg)
+static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGArg arg2,
+                            bool const_arg2, bool neg)
 {
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
     int cmp_rexw = rexw;
     bool inv = false;
     bool cleared;
@@ -1757,7 +1758,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
     case TCG_COND_LT:
         /* If arg2 is 0, extract the sign bit. */
         if (const_arg2 && arg2 == 0) {
-            tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32, dest, arg1);
+            tcg_out_mov(s, type, dest, arg1);
             if (inv) {
                 tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, dest);
             }
@@ -1793,6 +1794,42 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
     }
 }
 
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, false, false);
+}
+
+static void tgen_setcondi(TCGContext *s, TCGType type, TCGCond cond,
+                          TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, true, false);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(q, r, reT),
+    .out_rrr = tgen_setcond,
+    .out_rri = tgen_setcondi,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, false, true);
+}
+
+static void tgen_negsetcondi(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, true, true);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(q, r, reT),
+    .out_rrr = tgen_negsetcond,
+    .out_rri = tgen_negsetcondi,
+};
+
 #if TCG_TARGET_REG_BITS == 32
 static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
@@ -3091,12 +3128,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond(s, rexw, a2, a0, a1, const_args[1],
                        arg_label(args[3]), 0);
         break;
-    OP_32_64(setcond):
-        tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2, false);
-        break;
-    OP_32_64(negsetcond):
-        tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2, true);
-        break;
     OP_32_64(movcond):
         tcg_out_movcond(s, rexw, args[5], a0, a1, a2, const_a2, args[3]);
         break;
@@ -3934,12 +3965,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i64:
         return C_O1_I2(q, 0, qi);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        return C_O1_I2(q, r, reT);
-
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, reT, r, 0);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c4f908f3ae..c5b7508305 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -675,6 +675,42 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_setcond(s, cond, dest, arg1, arg2, false, false);
+}
+
+static void tgen_setcondi(TCGContext *s, TCGType type, TCGCond cond,
+                          TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_setcond(s, cond, dest, arg1, arg2, true, false);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_setcond,
+    .out_rri = tgen_setcondi,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_setcond(s, cond, dest, arg1, arg2, false, true);
+}
+
+static void tgen_negsetcondi(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_setcond(s, cond, dest, arg1, arg2, true, true);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_negsetcond,
+    .out_rri = tgen_negsetcondi,
+};
+
 static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
                             TCGReg c1, tcg_target_long c2, bool const2,
                             TCGReg v1, TCGReg v2)
@@ -1801,15 +1837,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_revb_d(s, a0, a1);
         break;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond(s, args[3], a0, a1, a2, c2, false);
-        break;
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        tcg_out_setcond(s, args[3], a0, a1, a2, c2, true);
-        break;
-
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         tcg_out_movcond(s, args[5], a0, a1, a2, c2, args[3], args[4]);
@@ -2446,12 +2473,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         /* Must deposit into the same register as input */
         return C_O1_I2(r, 0, rz);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rJ);
-
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, rz, rJ, rz, rz);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f6593b2627..ec75981aac 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -952,15 +952,20 @@ static void tcg_out_setcond_end(TCGContext *s, TCGReg ret, int tmpflags)
     }
 }
 
-static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
-                            TCGReg arg1, TCGReg arg2)
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg ret, TCGReg arg1, TCGReg arg2)
 {
     int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2);
     tcg_out_setcond_end(s, ret, tmpflags);
 }
 
-static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
-                               TCGReg arg1, TCGReg arg2)
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, rz),
+    .out_rrr = tgen_setcond,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg ret, TCGReg arg1, TCGReg arg2)
 {
     int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2);
     TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
@@ -978,6 +983,11 @@ static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, rz),
+    .out_rrr = tgen_negsetcond,
+};
+
 static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
                            TCGReg arg2, TCGLabel *l)
 {
@@ -1041,10 +1051,11 @@ static int tcg_out_setcond2_int(TCGContext *s, TCGCond cond, TCGReg ret,
         break;
 
     default:
-        tcg_out_setcond(s, TCG_COND_EQ, TCG_TMP0, ah, bh);
-        tcg_out_setcond(s, tcg_unsigned_cond(cond), TCG_TMP1, al, bl);
+        tgen_setcond(s, TCG_TYPE_I32, TCG_COND_EQ, TCG_TMP0, ah, bh);
+        tgen_setcond(s, TCG_TYPE_I32, tcg_unsigned_cond(cond),
+                     TCG_TMP1, al, bl);
         tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP0);
-        tcg_out_setcond(s, tcg_high_cond(cond), TCG_TMP0, ah, bh);
+        tgen_setcond(s, TCG_TYPE_I32, tcg_high_cond(cond), TCG_TMP0, ah, bh);
         tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
         break;
     }
@@ -2291,14 +2302,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_movcond(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond(s, args[3], a0, a1, a2);
-        break;
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        tcg_out_negsetcond(s, args[3], a0, a1, a2);
-        break;
     case INDEX_op_setcond2_i32:
         tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
@@ -2391,12 +2394,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, rz, rz);
-
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rz);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index f2cb45029f..0a66351124 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1926,8 +1926,8 @@ static TCGReg tcg_gen_setcond_xor(TCGContext *s, TCGReg arg1, TCGArg arg2,
 }
 
 static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
-                            TCGArg arg0, TCGArg arg1, TCGArg arg2,
-                            int const_arg2, bool neg)
+                            TCGReg arg0, TCGReg arg1, TCGArg arg2,
+                            bool const_arg2, bool neg)
 {
     int sh;
     bool inv;
@@ -2072,6 +2072,42 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     }
 }
 
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, false, false);
+}
+
+static void tgen_setcondi(TCGContext *s, TCGType type, TCGCond cond,
+                          TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, true, false);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, rC),
+    .out_rrr = tgen_setcond,
+    .out_rri = tgen_setcondi,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, false, true);
+}
+
+static void tgen_negsetcondi(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, true, true);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, rC),
+    .out_rrr = tgen_negsetcond,
+    .out_rri = tgen_negsetcondi,
+};
+
 static void tcg_out_bc(TCGContext *s, TCGCond cond, int bd)
 {
     tcg_out32(s, tcg_to_bc[cond] | bd);
@@ -3465,22 +3501,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_setcond_i32:
-        tcg_out_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1], args[2],
-                        const_args[2], false);
-        break;
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1], args[2],
-                        const_args[2], false);
-        break;
-    case INDEX_op_negsetcond_i32:
-        tcg_out_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1], args[2],
-                        const_args[2], true);
-        break;
-    case INDEX_op_negsetcond_i64:
-        tcg_out_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1], args[2],
-                        const_args[2], true);
-        break;
     case INDEX_op_setcond2_i32:
         tcg_out_setcond2(s, args, const_args);
         break;
@@ -4276,11 +4296,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(r, rC);
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rC);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rC, rZ, rZ);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 071be449f6..05114b5c5f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1325,6 +1325,24 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_setcond(s, cond, dest, arg1, arg2, false);
+}
+
+static void tgen_setcondi(TCGContext *s, TCGType type, TCGCond cond,
+                          TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_setcond(s, cond, dest, arg1, arg2, true);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_setcond,
+    .out_rri = tgen_setcondi,
+};
+
 static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
                                TCGReg arg1, tcg_target_long arg2, bool c2)
 {
@@ -1363,6 +1381,24 @@ static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_negsetcond(s, cond, dest, arg1, arg2, false);
+}
+
+static void tgen_negsetcondi(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_negsetcond(s, cond, dest, arg1, arg2, true);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_negsetcond,
+    .out_rri = tgen_negsetcondi,
+};
+
 static void tcg_out_movcond_zicond(TCGContext *s, TCGReg ret, TCGReg test_ne,
                                    int val1, bool c_val1,
                                    int val2, bool c_val2)
@@ -2485,16 +2521,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
         break;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond(s, args[3], a0, a1, a2, c2);
-        break;
-
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        tcg_out_negsetcond(s, args[3], a0, a1, a2, c2);
-        break;
-
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         tcg_out_movcond(s, args[5], a0, a1, a2, c2,
@@ -2837,12 +2863,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rI);
-
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(rz, rz);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 18b83d5899..3c04b87109 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1370,9 +1370,9 @@ static int tgen_cmp(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
     return tgen_cmp2(s, type, c, r1, c2, c2const, need_carry, &inv_cc);
 }
 
-static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
-                         TCGReg dest, TCGReg c1, TCGArg c2,
-                         bool c2const, bool neg)
+static void tgen_setcond_int(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg c1, TCGArg c2,
+                             bool c2const, bool neg)
 {
     int cc;
 
@@ -1464,6 +1464,42 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
     tcg_out_insn(s, RRFc, LOCGR, dest, TCG_TMP0, cc);
 }
 
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tgen_setcond_int(s, type, cond, dest, arg1, arg2, false, false);
+}
+
+static void tgen_setcondi(TCGContext *s, TCGType type, TCGCond cond,
+                          TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tgen_setcond_int(s, type, cond, dest, arg1, arg2, true, false);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, rC),
+    .out_rrr = tgen_setcond,
+    .out_rri = tgen_setcondi,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tgen_setcond_int(s, type, cond, dest, arg1, arg2, false, true);
+}
+
+static void tgen_negsetcondi(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tgen_setcond_int(s, type, cond, dest, arg1, arg2, true, true);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, rC),
+    .out_rrr = tgen_negsetcond,
+    .out_rri = tgen_negsetcondi,
+};
+
 static void tgen_movcond_int(TCGContext *s, TCGType type, TCGReg dest,
                              TCGArg v3, int v3const, TCGReg v4,
                              int cc, int inv_cc)
@@ -2825,14 +2861,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tgen_brcond(s, TCG_TYPE_I32, args[2], args[0],
                     args[1], const_args[1], arg_label(args[3]));
         break;
-    case INDEX_op_setcond_i32:
-        tgen_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1],
-                     args[2], const_args[2], false);
-        break;
-    case INDEX_op_negsetcond_i32:
-        tgen_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1],
-                     args[2], const_args[2], true);
-        break;
     case INDEX_op_movcond_i32:
         tgen_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1],
                      args[2], const_args[2], args[3], const_args[3], args[4]);
@@ -2910,14 +2938,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tgen_brcond(s, TCG_TYPE_I64, args[2], args[0],
                     args[1], const_args[1], arg_label(args[3]));
         break;
-    case INDEX_op_setcond_i64:
-        tgen_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1],
-                     args[2], const_args[2], false);
-        break;
-    case INDEX_op_negsetcond_i64:
-        tgen_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1],
-                     args[2], const_args[2], true);
-        break;
     case INDEX_op_movcond_i64:
         tgen_movcond(s, TCG_TYPE_I64, args[5], args[0], args[1],
                      args[2], const_args[2], args[3], const_args[3], args[4]);
@@ -3434,12 +3454,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rC);
-
     case INDEX_op_brcond_i32:
         return C_O0_I2(r, ri);
     case INDEX_op_brcond_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 41c4e77466..dcbe6a8f47 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -714,7 +714,7 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
 }
 
 static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
-                                TCGReg c1, int32_t c2, int c2const, bool neg)
+                                TCGReg c1, int32_t c2, bool c2const, bool neg)
 {
     /* For 32-bit comparisons, we can play games with ADDC/SUBC.  */
     switch (cond) {
@@ -788,7 +788,7 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
 }
 
 static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
-                                TCGReg c1, int32_t c2, int c2const, bool neg)
+                                TCGReg c1, int32_t c2, bool c2const, bool neg)
 {
     int rcond;
 
@@ -822,6 +822,53 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg ret, TCGReg c1,
+                            TCGArg c2, bool c2const, bool neg)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_setcond_i32(s, cond, ret, c1, c2, c2const, neg);
+    } else {
+        tcg_out_setcond_i64(s, cond, ret, c1, c2, c2const, neg);
+    }
+}
+
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, false, false);
+}
+
+static void tgen_setcondi(TCGContext *s, TCGType type, TCGCond cond,
+                          TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, true, false);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_setcond,
+    .out_rri = tgen_setcondi,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, false, true);
+}
+
+static void tgen_negsetcondi(TCGContext *s, TCGType type, TCGCond cond,
+                             TCGReg dest, TCGReg arg1, tcg_target_long arg2)
+{
+    tcg_out_setcond(s, type, cond, dest, arg1, arg2, true, true);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_negsetcond,
+    .out_rri = tgen_negsetcondi,
+};
+
 static void tcg_out_addsub2_i32(TCGContext *s, TCGReg rl, TCGReg rh,
                                 TCGReg al, TCGReg ah, int32_t bl, int blconst,
                                 int32_t bh, int bhconst, int opl, int oph)
@@ -1711,12 +1758,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_brcond_i32:
         tcg_out_brcond_i32(s, a2, a0, a1, const_args[1], arg_label(args[3]));
         break;
-    case INDEX_op_setcond_i32:
-        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, false);
-        break;
-    case INDEX_op_negsetcond_i32:
-        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, true);
-        break;
     case INDEX_op_movcond_i32:
         tcg_out_movcond_i32(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
         break;
@@ -1758,12 +1799,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_brcond_i64:
         tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
         break;
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, false);
-        break;
-    case INDEX_op_negsetcond_i64:
-        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, true);
-        break;
     case INDEX_op_movcond_i64:
         tcg_out_movcond_i64(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
         break;
@@ -1837,12 +1872,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, rz, rJ);
-
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(rz, rJ);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2eb323b5c5..1b75aba698 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -77,10 +77,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, r, r);
@@ -942,6 +938,32 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_setcond_i32
+                     : INDEX_op_setcond_i64);
+    tcg_out_op_rrrc(s, opc, dest, arg1, arg2, cond);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_setcond,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tgen_setcond(s, type, cond, dest, arg1, arg2);
+    tgen_neg(s, type, dest, dest);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_negsetcond,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -958,27 +980,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_l(s, opc, arg_label(args[0]));
         break;
 
-    CASE_32_64(setcond)
-        tcg_out_op_rrrc(s, opc, args[0], args[1], args[2], args[3]);
-        break;
-
     CASE_32_64(movcond)
     case INDEX_op_setcond2_i32:
         tcg_out_op_rrrrrc(s, opc, args[0], args[1], args[2],
                           args[3], args[4], args[5]);
         break;
 
-    case INDEX_op_negsetcond_i32:
-        tcg_out_op_rrrc(s, INDEX_op_setcond_i32,
-                        args[0], args[1], args[2], args[3]);
-        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
-        break;
-    case INDEX_op_negsetcond_i64:
-        tcg_out_op_rrrc(s, INDEX_op_setcond_i64,
-                        args[0], args[1], args[2], args[3]);
-        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
-        break;
-
     CASE_32_64(ld8u)
     CASE_32_64(ld8s)
     CASE_32_64(ld16u)
@@ -1005,9 +1012,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     CASE_32_64(brcond)
-        tcg_out_op_rrrc(s, (opc == INDEX_op_brcond_i32
-                            ? INDEX_op_setcond_i32 : INDEX_op_setcond_i64),
-                        TCG_REG_TMP, args[0], args[1], args[2]);
+        tgen_setcond(s, type, args[2], TCG_REG_TMP, args[0], args[1]);
         tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
         break;
 
-- 
2.43.0


