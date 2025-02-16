Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8836C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnu9-0003v2-9d; Sun, 16 Feb 2025 18:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntA-0002AM-U8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:30 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt6-00061D-JZ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:28 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220c92c857aso58819175ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747842; x=1740352642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8UIDL/7PwKGq9u9ySTqpxKbvDhQ/7JwCw8+uyrNnNWw=;
 b=SeKo1RmmMYhSjqzjRrvjbHIE2IxScvbiNTCWUoox2zLAkzobXBdTJySKWIUQdYlRl1
 aZ/R3m7Y/K+VWbd4HothzdHBzHig/bX3sQEnLwptn//DU3h6ISiTNOEqRKS+wd4cUtKd
 n4z7aTEUiuRCDenbAuLuhSUwfMcrDPFGfTQAFOuLhUomgxU4piTiuuQ7q8oXlpNLQ1y/
 09/817iIH1Jbc5iy2t1GDNR4fC877oDPyd+rE8O5lbslapf419XI35n8NPKrLJUWMNWr
 nslzK0vUle4NR5LSHh4hiEGNSQkSmioT5fnFDKDOe4iO3X5RPtro355iSyM6ZS/Tn6yW
 5EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747842; x=1740352642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UIDL/7PwKGq9u9ySTqpxKbvDhQ/7JwCw8+uyrNnNWw=;
 b=WN9s+l/16JqZPBQydZHqQnL2lVlyPaCxh/pRmSBIq+gIcTl49UbOnPbP1Iimvz9/BV
 BCaow5bhvYIEPs0drSNGFx0hQShSVcoKABS1U3+Fdfipz4qmrdFZJQEsn3v3/xhxXQz9
 ohgODAzrH48RgZQ2Y1c9ZiVb84vQGDdGvvIOA0Uhfxm7wVp0rG/TAWrHSy7iD31tOiCy
 I+YBTwfJQErsKb7CYeobSkXO3QmWGwRM0twJ3wr0zZS2wqY5cB/0fu9TZrQC6p4shLCP
 H12ho69Z3RB2wgx0ikJi5387+uWNhFgO17kl4OM4lkrMKQX2d8MVVDjAGnIVbovs8Vae
 YG+Q==
X-Gm-Message-State: AOJu0Yxv1Mbo8QyDBgHd4aoU+Gw2SoxWNS+Z+gI4cR0Y800YUd00V15Y
 pineV39mvJ9xW1xg8m5XGMPJ+46w6800wo3nwgFXobfCvHZ6S3bakUZAsmGtgCPoPyxicUf7Jfk
 c
X-Gm-Gg: ASbGnctgPML/3lPoIFZWnRk67P3Zcj4dEhWLC0a0uwrzLGxH6hCt7LurTjPjlKiw8Gm
 mu7xrAzcPhVrq1WYfDC3I1WkPyFUUKP1nHJv0dU7ojaoFZHX8bZiJal43NnW+2jFJgL7q7xvk1D
 LPD745fSMFJ+Psp5kuca9CWxVTC+GkFkZhHwY7oF6EMdY+4aVrIyj11RDhCykiSoubtaSgp37Oq
 vaZTyLZ3O6lLprrQ+7PMvogUFaV072NqioQepu+D2gbz0VIL+AzzojmIaduZovObiXyp48+4AH3
 xDvrj3XlMHkpiOhS6RQHI4K/4qNfjQ1j0TOxY/WlMzZieOE=
X-Google-Smtp-Source: AGHT+IGHp9zhqR/c/w8FYavYa/ZfkCd8QZktr37XUf2lGgSTgzN9NFzpexzkASPzVP9dQcbLEUnG7A==
X-Received: by 2002:a17:902:da87:b0:21f:6dcf:fd2b with SMTP id
 d9443c01a7336-220d33a5209mr255383735ad.1.1739747842477; 
 Sun, 16 Feb 2025 15:17:22 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 092/162] tcg: Convert extract to TCGOutOpExtract
Date: Sun, 16 Feb 2025 15:09:01 -0800
Message-ID: <20250216231012.2808572-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 tcg/tcg.c                        | 20 +++++++++
 tcg/aarch64/tcg-target.c.inc     | 28 +++++++-----
 tcg/arm/tcg-target.c.inc         | 23 +++++-----
 tcg/i386/tcg-target.c.inc        | 77 +++++++++++++++++---------------
 tcg/loongarch64/tcg-target.c.inc | 33 +++++++-------
 tcg/mips/tcg-target.c.inc        | 35 +++++++--------
 tcg/ppc/tcg-target.c.inc         | 35 +++++++--------
 tcg/riscv/tcg-target.c.inc       | 54 +++++++++++-----------
 tcg/s390x/tcg-target.c.inc       | 14 +++---
 tcg/sparc64/tcg-target.c.inc     | 16 ++++---
 tcg/tci/tcg-target.c.inc         |  8 ++--
 11 files changed, 191 insertions(+), 152 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0a81a115be..a6e47664bb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1013,6 +1013,12 @@ typedef struct TCGOutOpDivRem {
                       TCGReg a0, TCGReg a1, TCGReg a4);
 } TCGOutOpDivRem;
 
+typedef struct TCGOutOpExtract {
+    TCGOutOp base;
+    void (*out_rr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                   unsigned ofs, unsigned len);
+} TCGOutOpExtract;
+
 typedef struct TCGOutOpMovcond {
     TCGOutOp base;
     void (*out)(TCGContext *s, TCGType type, TCGCond cond,
@@ -1085,6 +1091,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
+    OUTOP(INDEX_op_extract_i32, TCGOutOpExtract, outop_extract),
+    OUTOP(INDEX_op_extract_i64, TCGOutOpExtract, outop_extract),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -5499,6 +5507,18 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_extract_i32:
+    case INDEX_op_extract_i64:
+        {
+            const TCGOutOpExtract *out =
+                container_of(all_outop[op->opc], TCGOutOpExtract, base);
+
+            tcg_debug_assert(!const_args[1]);
+            out->out_rr(s, type, new_args[0], new_args[1],
+                        new_args[2], new_args[3]);
+        }
+        break;
+
     case INDEX_op_muls2:
     case INDEX_op_mulu2:
         {
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 79c0e2e097..6c9d6094a2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2567,6 +2567,22 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
+static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        uint64_t mask = MAKE_64BIT_MASK(0, len);
+        tcg_out_logicali(s, I3404_ANDI, type, a0, a1, mask);
+    } else {
+        tcg_out_ubfm(s, type, a0, a1, ofs, ofs + len - 1);
+    }
+}
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extract,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2652,16 +2668,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_dep(s, ext, a0, a2, args[3], args[4]);
         break;
 
-    case INDEX_op_extract_i64:
-    case INDEX_op_extract_i32:
-        if (a2 == 0) {
-            uint64_t mask = MAKE_64BIT_MASK(0, args[3]);
-            tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, mask);
-        } else {
-            tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
-        }
-        break;
-
     case INDEX_op_sextract_i64:
     case INDEX_op_sextract_i32:
         tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
@@ -3167,8 +3173,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 5ea0fb7fa8..5b67d2b457 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -987,19 +987,19 @@ static void tcg_out_deposit(TCGContext *s, ARMCond cond, TCGReg rd,
               | (ofs << 7) | ((ofs + len - 1) << 16));
 }
 
-static void tcg_out_extract(TCGContext *s, ARMCond cond, TCGReg rd,
-                            TCGReg rn, int ofs, int len)
+static void tgen_extract(TCGContext *s, TCGType type, TCGReg rd, TCGReg rn,
+                         unsigned ofs, unsigned len)
 {
     /* According to gcc, AND can be faster. */
     if (ofs == 0 && len <= 8) {
-        tcg_out_dat_imm(s, cond, ARITH_AND, rd, rn,
+        tcg_out_dat_imm(s, COND_AL, ARITH_AND, rd, rn,
                         encode_imm_nofail((1 << len) - 1));
         return;
     }
 
     if (use_armv7_instructions) {
         /* ubfx */
-        tcg_out32(s, 0x07e00050 | (cond << 28) | (rd << 12) | rn
+        tcg_out32(s, 0x07e00050 | (COND_AL << 28) | (rd << 12) | rn
                   | (ofs << 7) | ((len - 1) << 16));
         return;
     }
@@ -1008,17 +1008,24 @@ static void tcg_out_extract(TCGContext *s, ARMCond cond, TCGReg rd,
     switch (len) {
     case 8:
         /* uxtb */
-        tcg_out32(s, 0x06ef0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
+        tcg_out32(s, 0x06ef0070 | (COND_AL << 28) |
+                  (rd << 12) | (ofs << 7) | rn);
         break;
     case 16:
         /* uxth */
-        tcg_out32(s, 0x06ff0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
+        tcg_out32(s, 0x06ff0070 | (COND_AL << 28) |
+                  (rd << 12) | (ofs << 7) | rn);
         break;
     default:
         g_assert_not_reached();
     }
 }
 
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extract,
+};
+
 static void tcg_out_sextract(TCGContext *s, ARMCond cond, TCGReg rd,
                              TCGReg rn, int ofs, int len)
 {
@@ -2398,9 +2405,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_deposit(s, COND_AL, args[0], args[2],
                         args[3], args[4], const_args[2]);
         break;
-    case INDEX_op_extract_i32:
-        tcg_out_extract(s, COND_AL, args[0], args[1], args[2], args[3]);
-        break;
     case INDEX_op_sextract_i32:
         tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
@@ -2450,7 +2454,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
         return C_O1_I1(r, r);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 44bd62aae1..75c66915d2 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3138,6 +3138,47 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8u(s, a0, a1);
+            return;
+        case 16:
+            tcg_out_ext16u(s, a0, a1);
+            return;
+        case 32:
+            tcg_out_ext32u(s, a0, a1);
+            return;
+        }
+    } else if (TCG_TARGET_REG_BITS == 64 && ofs + len == 32) {
+        /* This is a 32-bit zero-extending right shift.  */
+        tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
+        tcg_out_shifti(s, SHIFT_SHR, a0, ofs);
+        return;
+    } else if (ofs == 8 && len == 8) {
+        /*
+         * On the off-chance that we can use the high-byte registers.
+         * Otherwise we emit the same ext16 + shift pattern that we
+         * would have gotten from the normal tcg-op.c expansion.
+         */
+        if (a1 < 4 && (TCG_TARGET_REG_BITS == 32 || a0 < 8)) {
+            tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
+        } else {
+            tcg_out_ext16u(s, a0, a1);
+            tcg_out_shifti(s, SHIFT_SHR, a0, 8);
+        }
+        return;
+    }
+    g_assert_not_reached();
+}
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extract,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3328,40 +3369,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_extract_i64:
-        if (a2 + args[3] == 32) {
-            if (a2 == 0) {
-                tcg_out_ext32u(s, a0, a1);
-                break;
-            }
-            /* This is a 32-bit zero-extending right shift.  */
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tcg_out_shifti(s, SHIFT_SHR, a0, a2);
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_extract_i32:
-        if (a2 == 0 && args[3] == 8) {
-            tcg_out_ext8u(s, a0, a1);
-        } else if (a2 == 0 && args[3] == 16) {
-            tcg_out_ext16u(s, a0, a1);
-        } else if (a2 == 8 && args[3] == 8) {
-            /*
-             * On the off-chance that we can use the high-byte registers.
-             * Otherwise we emit the same ext16 + shift pattern that we
-             * would have gotten from the normal tcg-op.c expansion.
-             */
-            if (a1 < 4 && a0 < 8) {
-                tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
-            } else {
-                tcg_out_ext16u(s, a0, a1);
-                tcg_out_shifti(s, SHIFT_SHR, a0, 8);
-            }
-        } else {
-            g_assert_not_reached();
-        }
-        break;
-
     case INDEX_op_sextract_i64:
         if (a2 == 0 && args[3] == 8) {
             tcg_out_ext8s(s, TCG_TYPE_I64, a0, a1);
@@ -3994,8 +4001,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 25adbb0609..42983aff3b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1787,6 +1787,22 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         unsigned ofs, unsigned len)
+{
+    if (ofs == 0 && len <= 12) {
+        tcg_out_opc_andi(s, a0, a1, (1 << len) - 1);
+    } else if (type == TCG_TYPE_I32) {
+        tcg_out_opc_bstrpick_w(s, a0, a1, ofs, ofs + len - 1);
+    } else {
+        tcg_out_opc_bstrpick_d(s, a0, a1, ofs, ofs + len - 1);
+    }
+}
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extract,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1816,21 +1832,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_srai_d(s, a0, a1, 32);
         break;
 
-    case INDEX_op_extract_i32:
-        if (a2 == 0 && args[3] <= 12) {
-            tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
-        } else {
-            tcg_out_opc_bstrpick_w(s, a0, a1, a2, a2 + args[3] - 1);
-        }
-        break;
-    case INDEX_op_extract_i64:
-        if (a2 == 0 && args[3] <= 12) {
-            tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
-        } else {
-            tcg_out_opc_bstrpick_d(s, a0, a1, a2, a2 + args[3] - 1);
-        }
-        break;
-
     case INDEX_op_sextract_i64:
         if (a2 + args[3] == 32) {
             if (a2 == 0) {
@@ -2455,8 +2456,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
     case INDEX_op_ld8s_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 85c9b5621a..37113f426e 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2209,6 +2209,23 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         unsigned ofs, unsigned len)
+{
+    if (ofs == 0 && len <= 16) {
+        tcg_out_opc_imm(s, OPC_ANDI, a0, a1, (1 << len) - 1);
+    } else if (type == TCG_TYPE_I32) {
+        tcg_out_opc_bf(s, OPC_EXT, a0, a1, len - 1, ofs);
+    } else {
+        tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU,
+                         a0, a1, len - 1, ofs);
+    }
+}
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extract,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2292,22 +2309,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                          args[3] + args[4] - 1, args[3]);
         break;
 
-    case INDEX_op_extract_i32:
-        if (a2 == 0 && args[3] <= 16) {
-            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, (1 << args[3]) - 1);
-        } else {
-            tcg_out_opc_bf(s, OPC_EXT, a0, a1, args[3] - 1, a2);
-        }
-        break;
-    case INDEX_op_extract_i64:
-        if (a2 == 0 && args[3] <= 16) {
-            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, (1 << args[3]) - 1);
-        } else {
-            tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU,
-                             a0, a1, args[3] - 1, a2);
-        }
-        break;
-
     case INDEX_op_sextract_i64:
         if (a2 == 0 && args[3] == 32) {
             tcg_out_ext32s(s, a0, a1);
@@ -2381,7 +2382,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
@@ -2394,7 +2394,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 083137d211..a8558a47b7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3417,6 +3417,23 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         unsigned ofs, unsigned len)
+{
+    if (ofs == 0 && len <= 16) {
+        tgen_andi(s, TCG_TYPE_I32, a0, a1, (1 << len) - 1);
+    } else if (type == TCG_TYPE_I32) {
+        tcg_out_rlw(s, RLWINM, a0, a1, 32 - ofs, 32 - len, 31);
+    } else {
+        tcg_out_rld(s, RLDICL, a0, a1, 64 - ofs, 64 - len);
+    }
+}
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extract,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3538,22 +3555,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_extract_i32:
-        if (args[2] == 0 && args[3] <= 16) {
-            tcg_out32(s, ANDI | SAI(args[1], args[0], (1 << args[3]) - 1));
-            break;
-        }
-        tcg_out_rlw(s, RLWINM, args[0], args[1],
-                    32 - args[2], 32 - args[3], 31);
-        break;
-    case INDEX_op_extract_i64:
-        if (args[2] == 0 && args[3] <= 16) {
-            tcg_out32(s, ANDI | SAI(args[1], args[0], (1 << args[3]) - 1));
-            break;
-        }
-        tcg_out_rld(s, RLDICL, args[0], args[1], 64 - args[2], 64 - args[3]);
-        break;
-
     case INDEX_op_sextract_i64:
         if (args[2] + args[3] == 32) {
             if (args[2] == 0) {
@@ -4255,7 +4256,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
@@ -4266,7 +4266,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 00b097d171..85d978763c 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2472,6 +2472,34 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 16:
+            tcg_out_ext16u(s, a0, a1);
+            return;
+        case 32:
+            tcg_out_ext32u(s, a0, a1);
+            return;
+        }
+    }
+    if (ofs + len == 32) {
+        tgen_shli(s, TCG_TYPE_I32, a0, a1, ofs);
+        return;
+    }
+    if (len == 1) {
+        tcg_out_opc_imm(s, OPC_BEXTI, a0, a1, ofs);
+        return;
+    }
+    g_assert_not_reached();
+}
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extract,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2572,30 +2600,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_extract_i64:
-        if (a2 + args[3] == 32) {
-            if (a2 == 0) {
-                tcg_out_ext32u(s, a0, a1);
-            } else {
-                tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2);
-            }
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_extract_i32:
-        switch (args[3]) {
-        case 1:
-            tcg_out_opc_imm(s, OPC_BEXTI, a0, a1, a2);
-            break;
-        case 16:
-            tcg_debug_assert(a2 == 0);
-            tcg_out_ext16u(s, a0, a1);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
-
     case INDEX_op_sextract_i64:
         if (a2 + args[3] == 32) {
             if (a2 == 0) {
@@ -2867,8 +2871,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2ed288cfe0..96e2dc0ad5 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1563,8 +1563,8 @@ static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
     tcg_out_risbg(s, dest, src, msb, lsb, ofs, z);
 }
 
-static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
-                         int ofs, int len)
+static void tgen_extract(TCGContext *s, TCGType type, TCGReg dest,
+                         TCGReg src, unsigned ofs, unsigned len)
 {
     if (ofs == 0) {
         switch (len) {
@@ -1582,6 +1582,11 @@ static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
     tcg_out_risbg(s, dest, src, 64 - len, 63, 64 - ofs, 1);
 }
 
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extract,
+};
+
 static void tgen_sextract(TCGContext *s, TCGReg dest, TCGReg src,
                           int ofs, int len)
 {
@@ -2975,9 +2980,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(extract):
-        tgen_extract(s, args[0], args[1], args[2], args[3]);
-        break;
     OP_32_64(sextract):
         tgen_sextract(s, args[0], args[1], args[2], args[3]);
         break;
@@ -3470,8 +3472,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 96ffba9af6..cba1dd009c 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1757,6 +1757,17 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         unsigned ofs, unsigned len)
+{
+    tcg_debug_assert(ofs + len == 32);
+    tcg_out_arithi(s, a0, a1, ofs, SHIFT_SRL);
+}
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extract,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1857,10 +1868,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_extract_i64:
-        tcg_debug_assert(a2 + args[3] == 32);
-        tcg_out_arithi(s, a0, a1, a2, SHIFT_SRL);
-        break;
     case INDEX_op_sextract_i64:
         tcg_debug_assert(a2 + args[3] == 32);
         tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
@@ -1897,7 +1904,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4fc857ad35..d8cf5d237b 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -57,8 +57,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
@@ -444,6 +442,11 @@ static void tcg_out_extract(TCGContext *s, TCGType type, TCGReg rd,
     tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
 }
 
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tcg_out_extract,
+};
+
 static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
                              TCGReg rs, unsigned pos, unsigned len)
 {
@@ -1078,7 +1081,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
 
-    CASE_32_64(extract)  /* Optional (TCG_TARGET_HAS_extract_*). */
     CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
         tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
         break;
-- 
2.43.0


