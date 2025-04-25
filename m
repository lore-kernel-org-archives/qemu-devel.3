Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990CDC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R9U-00084A-If; Fri, 25 Apr 2025 18:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7h-0005EB-9n
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7c-0001M1-6d
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:16 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af50f56b862so1965242a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618530; x=1746223330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WF67ueuhKM26IweYcsRK68pjEy1hwamFJBV6DBu/XkU=;
 b=BFEb5Fm67FKXzOAZCad3ClNtmvf+n23CunqT4AX4n1NjiOVZwTVdyxVm1jpWme3k+6
 +de3Ost6yoCIQQgzk+tNNfRipgolVeCnWDEtvbDpCRF2vqBFuk1owbAzXpVMU7O0+Hiv
 OyvV3W2tD2dRirnM463cCUvf6QgneDPYH1sb6+6exFB38Y7gdHbnuVgJvRHCNhjKbzlj
 /7V6TgyHzgyq8GsM0rW4EUITrQtSMjb3Wv8bLlQzy+WS4M5bltfgePCCV+YRp5AF/NSr
 SXODmGTCcgWS+BS1Qy9cEbbIMUJURq58S47vtLsXj+Npt/lB83o1W8P3wVN+cOebq5JK
 8D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618530; x=1746223330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WF67ueuhKM26IweYcsRK68pjEy1hwamFJBV6DBu/XkU=;
 b=YmngsyFICktq2jFoZpSI1hhGl3wqy453D2C2+8GPDVnwJ2eIQhKsB5SGN0+2AXBzJ/
 d7cZQFVY5q2ge27r9ysOLBF17It65OmO1QcTB+Lg9JFzX7gCDJlbC7lcHUMxMWwrTBYa
 f3sYJlmlwwV4GWD15AS7smbUBlz9d9pdoH8gkATizpDhffRPmngCsn2/d/VF5RKQI8K+
 FhmVjtyXK09tP7MSPLRkGSHy3BwgDpUAJEMi0ZfdR68lxp7ygDLODnQhkBJfh6L8yuox
 Z1RD8sQDFk12eNmOgZzZRZs49poPDEbG2FxmXswfDH2Le2DIit0luXffBzz9tRlqmmbK
 vBIA==
X-Gm-Message-State: AOJu0YxLN+tO/GUb9NzPcMt9u0Wz7x+ph4nhHlMvIW8adLWxtmT5EIbc
 dtQDKDJq7CzUHHoQ9zxpmGEdTeuBJ9Eocert1OZj9bYfY7CoJ7KluFecthi5f9+A/KNSUwezjs+
 H
X-Gm-Gg: ASbGncu2Gb7pLMMeZDE4+5jqY1+kFQOLdZvZUmYHWkEtDu+VBfhcgHFCfDpLexR3YqG
 BZhZTbsruzqJeY50SdhMm75/StGHFFy4W30Zq6Q28DqsyZqao6H77bZZWLiGz64xmvYBqi07fxQ
 b1r6OULEJRaMv46+Lc70fAvWzIhRXWs4YPFIsH02QGHYnh/bFv/Zy4JB3TtmsAvt2BBEDll1LUH
 h7Uj94g79XF11PI2B8cvEULAacFPJq9doAcrEUqZrEJVQmOs+5DF1UaLYF9cy82NKsLbmsUl1N5
 Vn2t/cCkY/Fp+EAZCrbZREihwUh0Hibp3yYtPn7V4cP10gCCyPa/Ho+MfR8pd5Xl9XR63J+jhCI
 =
X-Google-Smtp-Source: AGHT+IGO2LBEsjWaYjfGBAKH18s9My1GbdCpVdX910tl2cY/yegotTDVZ3WB+pEOASzsARH2MTo2qg==
X-Received: by 2002:a17:90a:d647:b0:2ff:5714:6a with SMTP id
 98e67ed59e1d1-30a01340e04mr1397318a91.19.1745618530384; 
 Fri, 25 Apr 2025 15:02:10 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 099/159] tcg: Convert sextract to TCGOutOpExtract
Date: Fri, 25 Apr 2025 14:53:53 -0700
Message-ID: <20250425215454.886111-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  4 ++
 tcg/aarch64/tcg-target.c.inc     | 18 +++++----
 tcg/arm/tcg-target.c.inc         | 21 ++++++-----
 tcg/i386/tcg-target.c.inc        | 63 ++++++++++++++++----------------
 tcg/loongarch64/tcg-target.c.inc | 49 ++++++++++++++-----------
 tcg/mips/tcg-target.c.inc        | 42 ++++++++++++---------
 tcg/ppc/tcg-target.c.inc         | 49 ++++++++++++++-----------
 tcg/riscv/tcg-target.c.inc       | 49 ++++++++++++++-----------
 tcg/s390x/tcg-target.c.inc       | 15 ++++----
 tcg/sparc64/tcg-target.c.inc     | 18 ++++++---
 tcg/tci/tcg-target.c.inc         | 11 +++---
 11 files changed, 188 insertions(+), 151 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ce0d862b19..7f5fa25062 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1111,6 +1111,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
     OUTOP(INDEX_op_setcond, TCGOutOpSetcond, outop_setcond),
+    OUTOP(INDEX_op_sextract_i32, TCGOutOpExtract, outop_sextract),
+    OUTOP(INDEX_op_sextract_i64, TCGOutOpExtract, outop_sextract),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -5518,6 +5520,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_extract:
+    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
         {
             const TCGOutOpExtract *out =
                 container_of(all_outop[op->opc], TCGOutOpExtract, base);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 6c9d6094a2..00400f6ea7 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2583,6 +2583,17 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tgen_extract,
 };
 
+static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          unsigned ofs, unsigned len)
+{
+    tcg_out_sbfm(s, type, a0, a1, ofs, ofs + len - 1);
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_sextract,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2668,11 +2679,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_dep(s, ext, a0, a2, args[3], args[4]);
         break;
 
-    case INDEX_op_sextract_i64:
-    case INDEX_op_sextract_i32:
-        tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
-        break;
-
     case INDEX_op_extract2_i64:
     case INDEX_op_extract2_i32:
         tcg_out_extr(s, ext, a0, a2, a1, args[3]);
@@ -3173,8 +3179,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index bc060b20f2..aebe48679c 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1020,12 +1020,12 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tgen_extract,
 };
 
-static void tcg_out_sextract(TCGContext *s, ARMCond cond, TCGReg rd,
-                             TCGReg rn, int ofs, int len)
+static void tgen_sextract(TCGContext *s, TCGType type, TCGReg rd, TCGReg rn,
+                          unsigned ofs, unsigned len)
 {
     if (use_armv7_instructions) {
         /* sbfx */
-        tcg_out32(s, 0x07a00050 | (cond << 28) | (rd << 12) | rn
+        tcg_out32(s, 0x07a00050 | (COND_AL << 28) | (rd << 12) | rn
                   | (ofs << 7) | ((len - 1) << 16));
         return;
     }
@@ -1034,17 +1034,24 @@ static void tcg_out_sextract(TCGContext *s, ARMCond cond, TCGReg rd,
     switch (len) {
     case 8:
         /* sxtb */
-        tcg_out32(s, 0x06af0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
+        tcg_out32(s, 0x06af0070 | (COND_AL << 28) |
+                  (rd << 12) | (ofs << 7) | rn);
         break;
     case 16:
         /* sxth */
-        tcg_out32(s, 0x06bf0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
+        tcg_out32(s, 0x06bf0070 | (COND_AL << 28) |
+                  (rd << 12) | (ofs << 7) | rn);
         break;
     default:
         g_assert_not_reached();
     }
 }
 
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_sextract,
+};
+
 
 static void tcg_out_ld32u(TCGContext *s, ARMCond cond,
                           TCGReg rd, TCGReg rn, int32_t offset)
@@ -2399,9 +2406,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_deposit(s, COND_AL, args[0], args[2],
                         args[3], args[4], const_args[2]);
         break;
-    case INDEX_op_sextract_i32:
-        tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
-        break;
     case INDEX_op_extract2_i32:
         /* ??? These optimization vs zero should be generic.  */
         /* ??? But we can't substitute 2 for 1 in the opcode stream yet.  */
@@ -2448,7 +2452,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_sextract_i32:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b26c93bdb1..6a5414ab3a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3180,6 +3180,38 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tgen_extract,
 };
 
+static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8s(s, type, a0, a1);
+            return;
+        case 16:
+            tcg_out_ext16s(s, type, a0, a1);
+            return;
+        case 32:
+            tcg_out_ext32s(s, a0, a1);
+            return;
+        }
+    } else if (ofs == 8 && len == 8) {
+        if (type == TCG_TYPE_I32 && a1 < 4 && a0 < 8) {
+            tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
+        } else {
+            tcg_out_ext16s(s, type, a0, a1);
+            tgen_sari(s, type, a0, a0, 8);
+        }
+        return;
+    }
+    g_assert_not_reached();
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_sextract,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -3369,35 +3401,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_sextract_i64:
-        if (a2 == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_I64, a0, a1);
-        } else if (a2 == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_I64, a0, a1);
-        } else if (a2 == 0 && args[3] == 32) {
-            tcg_out_ext32s(s, a0, a1);
-        } else {
-            g_assert_not_reached();
-        }
-        break;
-
-    case INDEX_op_sextract_i32:
-        if (a2 == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_I32, a0, a1);
-        } else if (a2 == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_I32, a0, a1);
-        } else if (a2 == 8 && args[3] == 8) {
-            if (a1 < 4 && a0 < 8) {
-                tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
-            } else {
-                tcg_out_ext16s(s, TCG_TYPE_I32, a0, a1);
-                tcg_out_shifti(s, SHIFT_SAR, a0, 8);
-            }
-        } else {
-            g_assert_not_reached();
-        }
-        break;
-
     OP_32_64(extract2):
         /* Note that SHRD outputs to the r/m operand.  */
         tcg_out_modrm(s, OPC_SHRD_Ib + rexw, a2, a0);
@@ -4001,8 +4004,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_extract2_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index f63d33e9ac..2ea5234097 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1816,6 +1816,33 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tgen_extract,
 };
 
+static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8s(s, type, a0, a1);
+            return;
+        case 16:
+            tcg_out_ext16s(s, type, a0, a1);
+            return;
+        case 32:
+            tcg_out_ext32s(s, a0, a1);
+            return;
+        }
+    } else if (ofs + len == 32) {
+        tcg_out_opc_srai_w(s, a0, a1, ofs);
+        return;
+    }
+    g_assert_not_reached();
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_sextract,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1844,26 +1871,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_srai_d(s, a0, a1, 32);
         break;
 
-    case INDEX_op_sextract_i64:
-        if (a2 + args[3] == 32) {
-            if (a2 == 0) {
-                tcg_out_ext32s(s, a0, a1);
-            } else {
-                tcg_out_opc_srai_w(s, a0, a1, a2);
-            }
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_sextract_i32:
-        if (a2 == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
-        } else if (a2 == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
-        } else {
-            g_assert_not_reached();
-        }
-        break;
-
     case INDEX_op_deposit_i32:
         tcg_out_opc_bstrins_w(s, a0, a2, args[3], args[3] + args[4] - 1);
         break;
@@ -2462,8 +2469,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld8u_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index dbb4b9355d..56c58bf82d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2221,6 +2221,30 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tgen_extract,
 };
 
+static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8s(s, type, a0, a1);
+            return;
+        case 16:
+            tcg_out_ext16s(s, type, a0, a1);
+            return;
+        case 32:
+            tcg_out_ext32s(s, a0, a1);
+            return;
+        }
+    }
+    g_assert_not_reached();
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_sextract,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2303,22 +2327,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                          args[3] + args[4] - 1, args[3]);
         break;
 
-    case INDEX_op_sextract_i64:
-        if (a2 == 0 && args[3] == 32) {
-            tcg_out_ext32s(s, a0, a1);
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_sextract_i32:
-        if (a2 == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
-        } else if (a2 == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
-        } else {
-            g_assert_not_reached();
-        }
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2376,7 +2384,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2388,7 +2395,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a8558a47b7..3d1ffa9130 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3434,6 +3434,33 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tgen_extract,
 };
 
+static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8s(s, type, a0, a1);
+            return;
+        case 16:
+            tcg_out_ext16s(s, type, a0, a1);
+            return;
+        case 32:
+            tcg_out_ext32s(s, a0, a1);
+            return;
+        }
+    } else if (ofs + len == 32) {
+        tcg_out_sari32(s, a0, a1, ofs);
+        return;
+    }
+    g_assert_not_reached();
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_sextract,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3555,26 +3582,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_sextract_i64:
-        if (args[2] + args[3] == 32) {
-            if (args[2] == 0) {
-                tcg_out_ext32s(s, args[0], args[1]);
-            } else {
-                tcg_out_sari32(s, args[0], args[1], args[2]);
-            }
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_sextract_i32:
-        if (args[2] == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_I32, args[0], args[1]);
-        } else if (args[2] == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_I32, args[0], args[1]);
-        } else {
-            g_assert_not_reached();
-        }
-        break;
-
 #if TCG_TARGET_REG_BITS == 64
     case INDEX_op_add2_i64:
 #else
@@ -4256,7 +4263,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -4266,7 +4272,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 85d978763c..dc2b487844 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2501,6 +2501,33 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tgen_extract,
 };
 
+static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8s(s, type, a0, a1);
+            return;
+        case 16:
+            tcg_out_ext16s(s, type, a0, a1);
+            return;
+        case 32:
+            tcg_out_ext32s(s, a0, a1);
+            return;
+        }
+    } else if (ofs + len == 32) {
+        tgen_sari(s, TCG_TYPE_I32, a0, a1, ofs);
+        return;
+    }
+    g_assert_not_reached();
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_sextract,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2600,26 +2627,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_sextract_i64:
-        if (a2 + args[3] == 32) {
-            if (a2 == 0) {
-                tcg_out_ext32s(s, a0, a1);
-            } else {
-                tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2);
-            }
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_sextract_i32:
-        if (a2 == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
-        } else if (a2 == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
-        } else {
-            g_assert_not_reached();
-        }
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
@@ -2871,8 +2878,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 96e2dc0ad5..ab178bebc8 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1587,8 +1587,8 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tgen_extract,
 };
 
-static void tgen_sextract(TCGContext *s, TCGReg dest, TCGReg src,
-                          int ofs, int len)
+static void tgen_sextract(TCGContext *s, TCGType type, TCGReg dest,
+                          TCGReg src, unsigned ofs, unsigned len)
 {
     if (ofs == 0) {
         switch (len) {
@@ -1606,6 +1606,11 @@ static void tgen_sextract(TCGContext *s, TCGReg dest, TCGReg src,
     g_assert_not_reached();
 }
 
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_sextract,
+};
+
 static void tgen_gotoi(TCGContext *s, int cc, const tcg_insn_unit *dest)
 {
     ptrdiff_t off = tcg_pcrel_diff(s, dest) >> 1;
@@ -2980,10 +2985,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(sextract):
-        tgen_sextract(s, args[0], args[1], args[2], args[3]);
-        break;
-
     case INDEX_op_mb:
         /* The host memory model is quite strong, we simply need to
            serialize the instruction stream.  */
@@ -3472,8 +3473,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_qemu_ld_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index cba1dd009c..0f2bec21e9 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1769,6 +1769,18 @@ static const TCGOutOpExtract outop_extract = {
     .out_rr = tgen_extract,
 };
 
+static void tgen_sextract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          unsigned ofs, unsigned len)
+{
+    tcg_debug_assert(ofs + len == 32);
+    tcg_out_arithi(s, a0, a1, ofs, SHIFT_SRA);
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_sextract,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1868,11 +1880,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_sextract_i64:
-        tcg_debug_assert(a2 + args[3] == 32);
-        tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
-        break;
-
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
@@ -1904,7 +1911,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_sextract_i64:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ede11d9e70..e013321ac7 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -57,8 +57,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
@@ -453,6 +451,11 @@ static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
     tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
 }
 
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tcg_out_sextract,
+};
+
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
     tcg_out_sextract(s, type, rd, rs, 0, 8);
@@ -1078,10 +1081,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
 
-    CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
-        tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
-        break;
-
     CASE_32_64(add2)
     CASE_32_64(sub2)
         tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],
-- 
2.43.0


