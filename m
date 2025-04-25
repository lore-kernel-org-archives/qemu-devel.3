Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A403CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RA9-0001VB-OC; Fri, 25 Apr 2025 18:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7g-00059O-7Q
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7a-0001Lj-QY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so31144335ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618529; x=1746223329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gn/6S5dumOZWGqZ4h03QsITqkcZXRk207ZSRCsT+qrs=;
 b=QXxImCWRoE9AMHr1P8hK7dlCF4Zbt+Ndc5llmzLKwO+p8yTMD85C2PTNYvW2pujE9d
 JV5n5cV3LM8fQY/UfMB1bIQqMOdXMVwaVtHeHhecs8KhgRQERorjCB7MDPNO6UiBr1FA
 wCCVmX3i1yHnsBn6RA+yFhuH+OwVvMX/3KB65mYik5YAnEpwswV/a3be1HScWdbYqd5t
 jgs93C1HflAPfbW6JUmVpAudmAnVeIO2tD9uQRNupXJVuNS+yJowO5ZhDoa4ECEdpoNt
 ol7r9iUIZD2lhWI6D2nHF4Fse8z+1yKE+CocfMS+cdBFNnUvjdy9Z/Tf5EKxeoehCEfU
 1azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618529; x=1746223329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gn/6S5dumOZWGqZ4h03QsITqkcZXRk207ZSRCsT+qrs=;
 b=I9BlrosNJAQBV3iXDQpjPVQL1PUaeUSBCIBzwob+igSM/yM3wvAlvvDg1AKkUhEwTi
 m5ZaMbcB2hvkjJ6oQl98XRWCppGt3lyuq85MhIJ4wWAC/R9+xdDa4ZUyzkrAp6x82vaO
 P+q2md1v2UTF7NoSD28X2S1RT4NS++GUGlAnO52NeGcgbeDLiZQYHsVOof0eZP6pWyLK
 btdZBteUdvrIqNeSCchcs0GRMwCNGGQzss0DYw3OYMZpVwiP7aU8F1RIoy4UA6xqMG1Q
 ri43qWac70dNhUMR4R8Nacc9djJOStiW+oealqwYNaNSBBPTdVZDM53bukmw5OfPgsy7
 NcyQ==
X-Gm-Message-State: AOJu0Yz8nEaGq+1CfzNzU0YxqGoh3ub2NG18KM721E+yixJE3KQTZ9S/
 BWLKGw8vHJNNVnFJqwkDyR4yjsZ+u3qT6PTXHofvHL6tSZIuCpsBYHo+yB3toF3Ef7wtiCD3do7
 M
X-Gm-Gg: ASbGnctW/1ResZAuEWPKfhzy3gFh993g3BELmbm5YVpBik8edXonvfyuJVjAh5OSAnW
 SmNz+podavarm3hS7m/VM0EUu9LeovtZmgdOIZlTMC+7vdmYyrRJkEPClIiU9z2bpEQzHdcYiqZ
 +FsSPNIEpodQ4WxiZLf/K8YbZXeM85ur3cHlf6Oe4FLTpm3K6J4DnNv2fVm76ht6XCogaRUycRq
 zmk20R84tRY9boZq+dQkGI2RsrcjAyelEQU8/pXGv0OeX1jasi4mleFGD+NPBJ2Q8WAIo9GGOsI
 4g1pmwn+sRZE0LcZ1ugE9njX+vZIeiBZfs9XPowB7ilHAADncrkq0zo+e3vYQOU3SEYDC3msFPM
 =
X-Google-Smtp-Source: AGHT+IFCbUy49Ll93JEbF83rWO3Gjbp/3DPu9S9kxnqAdh1Gv5gnCkLVc2WHq1uRiESsU6t04OMeCA==
X-Received: by 2002:a17:902:c411:b0:226:30f6:1639 with SMTP id
 d9443c01a7336-22dbf640365mr55360665ad.51.1745618528964; 
 Fri, 25 Apr 2025 15:02:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 097/159] tcg: Convert extract to TCGOutOpExtract
Date: Fri, 25 Apr 2025 14:53:51 -0700
Message-ID: <20250425215454.886111-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
index 1ba86dd515..36c5e9c847 100644
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
@@ -5511,6 +5519,18 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index 3bbc28c63c..bc060b20f2 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -981,19 +981,19 @@ static void tcg_out_deposit(TCGContext *s, ARMCond cond, TCGReg rd,
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
@@ -1002,17 +1002,24 @@ static void tcg_out_extract(TCGContext *s, ARMCond cond, TCGReg rd,
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
@@ -2392,9 +2399,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_deposit(s, COND_AL, args[0], args[2],
                         args[3], args[4], const_args[2]);
         break;
-    case INDEX_op_extract_i32:
-        tcg_out_extract(s, COND_AL, args[0], args[1], args[2], args[3]);
-        break;
     case INDEX_op_sextract_i32:
         tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
@@ -2444,7 +2448,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
         return C_O1_I1(r, r);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 347e01c076..b26c93bdb1 100644
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
index f3b2f709d2..f63d33e9ac 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1799,6 +1799,22 @@ static const TCGOutOpUnary outop_not = {
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
@@ -1828,21 +1844,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2461,8 +2462,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
     case INDEX_op_ld8s_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index baaf0e416b..dbb4b9355d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2203,6 +2203,23 @@ static const TCGOutOpUnary outop_not = {
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
@@ -2286,22 +2303,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2375,7 +2376,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
@@ -2388,7 +2388,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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


