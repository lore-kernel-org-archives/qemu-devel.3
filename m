Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9839BC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnpz-0000sM-CQ; Sun, 16 Feb 2025 18:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpg-0000fb-FL
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:53 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpd-0005Pi-QH
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:52 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-221206dbd7eso9764135ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747628; x=1740352428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HbAiZbf/OAeyatngnnHTGCEcFy0AvJmNkc2gX2qK07Y=;
 b=wfJZGMq/XsMB30XB+N/3ZZHjCSyDTe3C5UsRjLkeRO0ESSx2zhMhb0FMvzydHTDyrq
 fnUoE0yRVERzcs0UWRS9yMx557ZOzNpZaE6nWstPHG1IeZDt1WTO5hEcMSypHVx8/q3t
 yDfj+sY9zzRC0gWe/zkJnPMRYxiUNQHTr91kQMyHCJOXY8RhxBzC11t4zvpYjYpJaPU2
 wh4Uvye1hIHVT/Lcqdw2UVANkEj9RBuLZ9Ke8ScAhSLGrtffzdTQkz72egKacxYqW/Ru
 hmJe4Uci0EXxMN2NDNOsgFCsxXL+oOPzrUvxlHBnOQrk6i39SHIqyKQILM7VXvx1AD6Y
 SU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747628; x=1740352428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbAiZbf/OAeyatngnnHTGCEcFy0AvJmNkc2gX2qK07Y=;
 b=veduLpy54CXDfudR7S4lXHad9BeYMJ8xEDx506Orq5o59BSraFzoviy5hU5zWXDkQD
 SaIEa4MYfNR34KJII7/gfB6sKyE01Qa2g96xpbwQ3p1lynjo85xbhwTelCQ9r7zJ1Eet
 DsqnYYRhYbxxwAXhUeepPmAUJC89RP480wHpkyhxm3q51MQy7Bnnte/F5zQZbUSgS+PK
 F2RkMK7jnR2pDTkR9mAF6pJoRdQAPsq7WRkXpsWqsu/axBFmqEXv/nBHklELbX66Wqpe
 CiTewnF9INP1I8ALRCGowGai9XylRNUH8xBuuR/pzy1Aoj6LYWQQxTXJG5mFmdcDihky
 zDpQ==
X-Gm-Message-State: AOJu0Yzgqi2o4MwzeddnCXajYd0iqQXEk84Wt/Eeqnrup9pnpY7y8rE4
 kSbBZZnvL6kB/fRenoaoz0Z6fxXseJNL6YhIwhynXXgsYaIhsavFcfl49yxlnUYdPeEFIqUJlwS
 K
X-Gm-Gg: ASbGnctI9wVhd4NU/yc8J2QSNxe3k9af/RqaH7GqfGgZ0xOzsJB1i/fLOhnZuzeGpt/
 ivm7iyaD7jDNGwin4DTOvybJRwNPW4Wogn+xh3ckWcBGy1uerHU1GPa9rI4Z/8saYmKvX/tY50T
 vAzRS8j/xby6dGHnJgGfYaFFwh0oy6dcCAEAt/5YeB4Qkt+h4Io4eRHukTuSHkN1j35Vf+iSg1s
 +9L6CPH4GC+k6CCumg6E7bER9clwT5Q++7z+sQUYLI48EQylrPeIK1hAkis+5/5XsqWbWsxb6pT
 yNiwMX7RTr/aKNw6tCv3mNQDtxOsPBhK06Hbb+bfHNMyJ3M=
X-Google-Smtp-Source: AGHT+IGutqS/hGYTYPWPI7VoR/0yxcvfKGJh+7FBcB4z7FKupQVKiNc0l/cLXe/o1mUmozBZnJXzkg==
X-Received: by 2002:a17:902:f68d:b0:220:d257:cdbd with SMTP id
 d9443c01a7336-2210409af84mr87812755ad.48.1739747627983; 
 Sun, 16 Feb 2025 15:13:47 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 044/162] tcg: Convert div2 to TCGOutOpDivRem
Date: Sun, 16 Feb 2025 15:08:13 -0800
Message-ID: <20250216231012.2808572-45-richard.henderson@linaro.org>
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
 tcg/tcg.c                        | 24 +++++++++++++++--
 tcg/aarch64/tcg-target.c.inc     |  4 +++
 tcg/arm/tcg-target.c.inc         |  4 +++
 tcg/i386/tcg-target.c.inc        | 17 ++++++++----
 tcg/loongarch64/tcg-target.c.inc |  4 +++
 tcg/mips/tcg-target.c.inc        |  4 +++
 tcg/ppc/tcg-target.c.inc         |  4 +++
 tcg/riscv/tcg-target.c.inc       |  4 +++
 tcg/s390x/tcg-target.c.inc       | 44 ++++++++++++++++----------------
 tcg/sparc64/tcg-target.c.inc     |  4 +++
 tcg/tci/tcg-target.c.inc         |  4 +++
 11 files changed, 88 insertions(+), 29 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7409aab2b8..b6843d5a19 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -986,6 +986,12 @@ typedef struct TCGOutOpBinary {
                     TCGReg a0, TCGReg a1, tcg_target_long a2);
 } TCGOutOpBinary;
 
+typedef struct TCGOutOpDivRem {
+    TCGOutOp base;
+    void (*out_rr01r)(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a4);
+} TCGOutOpDivRem;
+
 typedef struct TCGOutOpUnary {
     TCGOutOp base;
     void (*out_rr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1);
@@ -1022,6 +1028,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
+    OUTOP(INDEX_op_div2_i32, TCGOutOpDivRem, outop_divs2),
+    OUTOP(INDEX_op_div2_i64, TCGOutOpDivRem, outop_divs2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -2265,7 +2273,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
         return TCG_TARGET_HAS_rem_i32;
-    case INDEX_op_div2_i32:
     case INDEX_op_divu2_i32:
         return TCG_TARGET_HAS_div2_i32;
     case INDEX_op_rotl_i32:
@@ -2325,7 +2332,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
         return TCG_TARGET_HAS_rem_i64;
-    case INDEX_op_div2_i64:
     case INDEX_op_divu2_i64:
         return TCG_TARGET_HAS_div2_i64;
     case INDEX_op_rotl_i64:
@@ -5455,6 +5461,20 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_div2_i32:
+    case INDEX_op_div2_i64:
+        {
+            const TCGOutOpDivRem *out =
+                container_of(all_outop[op->opc], TCGOutOpDivRem, base);
+
+            /* Only used by x86 and s390x, which use matching constraints. */
+            tcg_debug_assert(new_args[0] == new_args[2]);
+            tcg_debug_assert(new_args[1] == new_args[3]);
+            tcg_debug_assert(!const_args[4]);
+            out->out_rr01r(s, type, new_args[0], new_args[1], new_args[4]);
+        }
+        break;
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
             tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 167c51c897..ea5766414d 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2168,6 +2168,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index c860df6045..33cb5495a8 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1886,6 +1886,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0ed0626871..d15e4ab62a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2637,6 +2637,18 @@ static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_divs2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a4)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IDIV, a4);
+}
+
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_O2_I3(a, d, 0, 1, r),
+    .out_rr01r = tgen_divs2,
+};
+
 static const TCGOutOpBinary outop_divu = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2847,9 +2859,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(div2):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IDIV, args[4]);
-        break;
     OP_32_64(divu2):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_DIV, args[4]);
         break;
@@ -3789,8 +3798,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, reT, r, 0);
 
-    case INDEX_op_div2_i32:
-    case INDEX_op_div2_i64:
     case INDEX_op_divu2_i32:
     case INDEX_op_divu2_i64:
         return C_O2_I3(a, d, 0, 1, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 8adcd030c5..deaf475c03 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1331,6 +1331,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 5bbb4d037e..1d78edd78d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1733,6 +1733,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b347595131..1eb3e785c0 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2972,6 +2972,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 74fa38d273..19c690c1c2 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2009,6 +2009,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index f55309f48e..b434ce423a 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2246,6 +2246,28 @@ static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_divs2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a4)
+{
+    tcg_debug_assert((a1 & 1) == 0);
+    tcg_debug_assert(a0 == a1 + 1);
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RR, DR, a1, a4);
+    } else {
+        /*
+         * TODO: Move the sign-extend of the numerator from a2 into a3
+         * into the tcg backend, instead of in early expansion.  It is
+         * required for 32-bit DR, but not 64-bit DSGR.
+         */
+        tcg_out_insn(s, RRE, DSGR, a1, a4);
+    }
+}
+
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_O2_I3(o, m, 0, 1, r),
+    .out_rr01r = tgen_divs2,
+};
+
 static const TCGOutOpBinary outop_divu = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2527,13 +2549,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_div2_i32:
-        tcg_debug_assert(args[0] == args[2]);
-        tcg_debug_assert(args[1] == args[3]);
-        tcg_debug_assert((args[1] & 1) == 0);
-        tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RR, DR, args[1], args[4]);
-        break;
     case INDEX_op_divu2_i32:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert(args[1] == args[3]);
@@ -2702,19 +2717,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
         break;
 
-    case INDEX_op_div2_i64:
-        /*
-         * ??? We get an unnecessary sign-extension of the dividend
-         * into op0 with this definition, but as we do in fact always
-         * produce both quotient and remainder using INDEX_op_div_i64
-         * instead requires jumping through even more hoops.
-         */
-        tcg_debug_assert(args[0] == args[2]);
-        tcg_debug_assert(args[1] == args[3]);
-        tcg_debug_assert((args[1] & 1) == 0);
-        tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RRE, DSGR, args[1], args[4]);
-        break;
     case INDEX_op_divu2_i64:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert(args[1] == args[3]);
@@ -3396,8 +3398,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rC, rI, r);
 
-    case INDEX_op_div2_i32:
-    case INDEX_op_div2_i64:
     case INDEX_op_divu2_i32:
     case INDEX_op_divu2_i64:
         return C_O2_I3(o, m, 0, 1, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 3a3372d7aa..472ccd7608 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1352,6 +1352,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rri = tgen_divsi,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu_rJ(TCGContext *s, TCGType type,
                          TCGReg a0, TCGReg a1, TCGArg a2, bool c2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index dfa8aecc7a..6646be224d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -658,6 +658,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


