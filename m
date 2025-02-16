Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF7AC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrV-0004lF-BV; Sun, 16 Feb 2025 18:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpi-0000jB-KV
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:57 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpf-0005Q0-4s
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:54 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220d398bea9so52015625ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747629; x=1740352429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MTeyNnYMcJoFGfCu75H00zu2zIesosemZyQstNSTgFY=;
 b=mnlIAwF45SukF47wGjSvn3iyo2QhDOS8HfHoy7JXtduXfE+Gu7aFfaNl9Fems3gHzz
 DZC0k9TwI/iZBotkVtktsIoug1O2WJbS2jyfACT+0jga5RQluHHL3+3nFSj0FXsab/M6
 +mjpeGQBo+v0izAD7I7wKcqipxImFGuoXZsMAlDPbCT772lyf8/QD6d9jspwFV0ZGt8t
 3pVfa2tFrwT4SV1jrNYUo3Yfh5ooSFyGN/L4cP69TtaN7Z43gEqHsQGlRMxgm2PpotGD
 kzUYjWCmbLUGNmRdvVhImoD+MIiF/Vc5Eero1dOmXyLa8grF2hZEp7H6OPGVXGvMaYy5
 x77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747629; x=1740352429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTeyNnYMcJoFGfCu75H00zu2zIesosemZyQstNSTgFY=;
 b=fEylYOYUyAao+wTAYUW+UZhSOYdvPVSmrocY9kOwllSHw2yujx2eKtZj6vQcm1/tTb
 lXlpZta9KnfAfV88nwPX03aWkxyz9rHlKL1MAUcoWVqz5zwXXsZ9OP2a4P2V+6Xe2uZ+
 R+sZ+VRowr6fkEKcrNnFx5PCiul6qCt6p0F1/ShucvXjad0b7gL+f18kckz3YexT5LuG
 4gXWavVWWFL52ZQNmGWiV5Bim+zXwxFVAH2DTl2NuMBzgzMFPg79L/yqiwtA3Kp0ps0L
 dnDCbGyCSc+A3CcMUs6SWR0ylsStcNERFkFi4tIY58FjbQ1df9OqriwHCTyTTKfZF2nW
 VjeQ==
X-Gm-Message-State: AOJu0YyccFqW2BvV7QX4RkTGcO+puwPJ+6gdRAszXLxq3/Day1S4JBtZ
 jP1LWIHg+W2MV8pJpL1DxgA6eZHHTH7Jptparob6NuajItXCsuzThVM+v/WdzlYorz+3gEXfuh7
 k
X-Gm-Gg: ASbGncv8tfvvcRuCA/XgbbC3sH4UknlW31z6eBzRR3Uwk0XswJFbaQkopLDcWy/8I6d
 8Un/Rg+J2n/FIW28+H8FT43kNnfSYEDV2FnSEzE9CI+7zzLRUa/+WTkJ80z3udcdnV+dkDFotNS
 qqjMmkfmT0vWncb6PMdHu5GAK2xUpKwAcnQXsToAzjc2+j1OmdGPorpJ0HN5sLAvKaT78GUt1AS
 d+v2URQNkdoQBxVgMsN+ExXIheh0d8WBLYkt/xRonmyLC/iQPQlJm5JN1hVFOGLQsNluLKrBS23
 BZymTNhWkMNsjPPKg0aT7OCPSPDtvHedJWTM6m2HV0MtgSY=
X-Google-Smtp-Source: AGHT+IFl5B/EwK6JeWkbWLqm88J2OhgOENivF+qo6MXJUWG06WWmRR3hyc+rLP3Y1HcfzYq0Zn7YSw==
X-Received: by 2002:a17:903:7cb:b0:220:e8a1:c819 with SMTP id
 d9443c01a7336-221040bdb89mr95695475ad.34.1739747629567; 
 Sun, 16 Feb 2025 15:13:49 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 046/162] tcg: Convert divu2 to TCGOutOpDivRem
Date: Sun, 16 Feb 2025 15:08:15 -0800
Message-ID: <20250216231012.2808572-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 tcg/i386/tcg-target-has.h        |  2 --
 tcg/loongarch64/tcg-target-has.h |  2 --
 tcg/riscv/tcg-target-has.h       |  2 --
 tcg/s390x/tcg-target-has.h       |  2 --
 tcg/tcg-has.h                    |  7 -------
 tcg/tcg-op.c                     |  8 +++----
 tcg/tcg.c                        |  8 +++----
 tcg/aarch64/tcg-target.c.inc     |  4 ++++
 tcg/arm/tcg-target.c.inc         |  4 ++++
 tcg/i386/tcg-target.c.inc        | 20 +++++++++++-------
 tcg/loongarch64/tcg-target.c.inc |  4 ++++
 tcg/mips/tcg-target.c.inc        |  4 ++++
 tcg/ppc/tcg-target.c.inc         |  4 ++++
 tcg/riscv/tcg-target.c.inc       |  4 ++++
 tcg/s390x/tcg-target.c.inc       | 36 +++++++++++++++-----------------
 tcg/sparc64/tcg-target.c.inc     |  4 ++++
 tcg/tci/tcg-target.c.inc         |  4 ++++
 17 files changed, 69 insertions(+), 50 deletions(-)

diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 121fb95ee0..aee6066579 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,7 +26,6 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_div2_i32         1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
@@ -43,7 +42,6 @@
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_div2_i64         1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 96a99b6d4c..aecd2879b8 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -12,7 +12,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
@@ -29,7 +28,6 @@
 /* 64-bit operations */
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index ae6624b9a4..e5861e5260 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -12,7 +12,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
@@ -28,7 +27,6 @@
 
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 64f1805641..d61cc7a144 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,7 +29,6 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_div2_i32       1
 #define TCG_TARGET_HAS_rot_i32        1
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
@@ -45,7 +44,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
-#define TCG_TARGET_HAS_div2_i64       1
 #define TCG_TARGET_HAS_rot_i64        1
 #define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 9680ccfc53..bae9918024 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -14,7 +14,6 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_div_i64          0
 #define TCG_TARGET_HAS_rem_i64          0
-#define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
@@ -33,12 +32,6 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
-#ifndef TCG_TARGET_HAS_div2_i32
-#define TCG_TARGET_HAS_div2_i32         0
-#endif
-#ifndef TCG_TARGET_HAS_div2_i64
-#define TCG_TARGET_HAS_div2_i64         0
-#endif
 #ifndef TCG_TARGET_HAS_rem_i32
 #define TCG_TARGET_HAS_rem_i32          0
 #endif
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f95beb8b5d..5511106554 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -637,7 +637,7 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (tcg_op_supported(INDEX_op_divu2_i32, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5_i32(INDEX_op_divu2_i32, ret, t0, arg1, zero, arg2);
@@ -657,7 +657,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (tcg_op_supported(INDEX_op_divu2_i32, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5_i32(INDEX_op_divu2_i32, t0, ret, arg1, zero, arg2);
@@ -2005,7 +2005,7 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i64) {
+    } else if (tcg_op_supported(INDEX_op_divu2_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5_i64(INDEX_op_divu2_i64, ret, t0, arg1, zero, arg2);
@@ -2025,7 +2025,7 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
-    } else if (TCG_TARGET_HAS_div2_i64) {
+    } else if (tcg_op_supported(INDEX_op_divu2_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5_i64(INDEX_op_divu2_i64, t0, ret, arg1, zero, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f0d1e60a5d..43122a97c6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1029,6 +1029,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
+    OUTOP(INDEX_op_divu2_i32, TCGOutOpDivRem, outop_divu2),
+    OUTOP(INDEX_op_divu2_i64, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -2272,8 +2274,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
         return TCG_TARGET_HAS_rem_i32;
-    case INDEX_op_divu2_i32:
-        return TCG_TARGET_HAS_div2_i32;
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
         return TCG_TARGET_HAS_rot_i32;
@@ -2331,8 +2331,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
         return TCG_TARGET_HAS_rem_i64;
-    case INDEX_op_divu2_i64:
-        return TCG_TARGET_HAS_div2_i64;
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
         return TCG_TARGET_HAS_rot_i64;
@@ -5461,6 +5459,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_divs2:
+    case INDEX_op_divu2_i32:
+    case INDEX_op_divu2_i64:
         {
             const TCGOutOpDivRem *out =
                 container_of(all_outop[op->opc], TCGOutOpDivRem, base);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index ea5766414d..456159cdc6 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2183,6 +2183,10 @@ static const TCGOutOpBinary outop_divu = {
     .out_rrr = tgen_divu,
 };
 
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 33cb5495a8..a20ee0ce0f 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1903,6 +1903,10 @@ static const TCGOutOpBinary outop_divu = {
     .out_rrr = tgen_divu,
 };
 
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d15e4ab62a..2d4c5bc46c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2653,6 +2653,18 @@ static const TCGOutOpBinary outop_divu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_divu2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a4)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_DIV, a4);
+}
+
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_O2_I3(a, d, 0, 1, r),
+    .out_rr01r = tgen_divu2,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2859,10 +2871,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(divu2):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_DIV, args[4]);
-        break;
-
     OP_32_64(shl):
         /* For small constant 3-operand shift, use LEA.  */
         if (const_a2 && a0 != a1 && (a2 - 1) < 3) {
@@ -3798,10 +3806,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, reT, r, 0);
 
-    case INDEX_op_divu2_i32:
-    case INDEX_op_divu2_i64:
-        return C_O2_I3(a, d, 0, 1, r);
-
     case INDEX_op_mulu2_i32:
     case INDEX_op_mulu2_i64:
     case INDEX_op_muls2_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index deaf475c03..2f9b0969ee 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1350,6 +1350,10 @@ static const TCGOutOpBinary outop_divu = {
     .out_rrr = tgen_divu,
 };
 
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 1d78edd78d..f4eb098135 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1758,6 +1758,10 @@ static const TCGOutOpBinary outop_divu = {
     .out_rrr = tgen_divu,
 };
 
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 1eb3e785c0..8b14d57d1c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2988,6 +2988,10 @@ static const TCGOutOpBinary outop_divu = {
     .out_rrr = tgen_divu,
 };
 
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_O1_I2(r, r, r),
     .out_rrr = tgen_eqv,
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 19c690c1c2..72910b0f25 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2025,6 +2025,10 @@ static const TCGOutOpBinary outop_divu = {
     .out_rrr = tgen_divu,
 };
 
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index b434ce423a..9af626eec2 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2272,6 +2272,23 @@ static const TCGOutOpBinary outop_divu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_divu2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a4)
+{
+    tcg_debug_assert((a1 & 1) == 0);
+    tcg_debug_assert(a0 == a1 + 1);
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRE, DLR, a1, a4);
+    } else {
+        tcg_out_insn(s, RRE, DLGR, a1, a4);
+    }
+}
+
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_O2_I3(o, m, 0, 1, r),
+    .out_rr01r = tgen_divu2,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2549,14 +2566,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_divu2_i32:
-        tcg_debug_assert(args[0] == args[2]);
-        tcg_debug_assert(args[1] == args[3]);
-        tcg_debug_assert((args[1] & 1) == 0);
-        tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RRE, DLR, args[1], args[4]);
-        break;
-
     case INDEX_op_shl_i32:
         op = RS_SLL;
         op2 = RSY_SLLK;
@@ -2717,13 +2726,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
         break;
 
-    case INDEX_op_divu2_i64:
-        tcg_debug_assert(args[0] == args[2]);
-        tcg_debug_assert(args[1] == args[3]);
-        tcg_debug_assert((args[1] & 1) == 0);
-        tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RRE, DLGR, args[1], args[4]);
-        break;
     case INDEX_op_mulu2_i64:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert((args[1] & 1) == 0);
@@ -3398,10 +3400,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rC, rI, r);
 
-    case INDEX_op_divu2_i32:
-    case INDEX_op_divu2_i64:
-        return C_O2_I3(o, m, 0, 1, r);
-
     case INDEX_op_mulu2_i64:
         return C_O2_I2(o, m, 0, r);
     case INDEX_op_muls2_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 472ccd7608..a4659653b3 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1389,6 +1389,10 @@ static const TCGOutOpBinary outop_divu = {
     .out_rri = tgen_divui,
 };
 
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 6646be224d..27271c178c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -676,6 +676,10 @@ static const TCGOutOpBinary outop_divu = {
     .out_rrr = tgen_divu,
 };
 
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


