Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E94C369C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m5U-0007eE-EH; Tue, 15 Apr 2025 15:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzC-00082b-MX
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:23 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly5-0000kP-HE
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:21 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3081f72c271so5106354a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745338; x=1745350138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7glXkVpkr1KJGXaAaG3GGMojMN4/iysHQLSTTlES9qk=;
 b=ctxjDyAQRQwU5NOmzKk33E1KX4uNuKtgODKrwUsvQ5N2UfKAB4E5AP/DB6TZlasKMG
 06QoO0+sO2dIYPzlm96YrA5CgGe9dLdfEEsQ22aZXktWlcW4HIuXdJNbC/1kLjFCYrwR
 IQEbyHleyTJfNm36L+sZ9nUC5lgs5Sp3EFNBl7d8uuRUQfQK2psW2ypTBcnlYc9MGCKZ
 qDZUQcBnGl/xjg/iHSfZ/bX27hEtIaM6lwM/WpSQavRsR1B2AKNm80p37YamuKy2W98X
 D8+LS2cqQkqNF1aecv/FdIcSHrjlV6BjP1NY0MeLgqRkGPj+ilq0KgThDUOMzSk89vCE
 BQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745338; x=1745350138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7glXkVpkr1KJGXaAaG3GGMojMN4/iysHQLSTTlES9qk=;
 b=aMGPVC6iFojU8nfQK8VqOGPGWLa6Nbs3dJD9/TJcYP6MIwwFTfbE2u9sI1Lk7oGlLa
 DovEY9Yu6M0WBCxkp0JAepE9BbzHMD2iIQTm5DP1rL2yF7NITs3W0gNq0MEsCoi6pDZV
 RPDpOHzqpNRRicRXddBBqTw56mSuTOeAunitnw7WJhvwukLvo0seeaqhIegMTigreyQo
 h9AfhU2rS6fBHaqSeYK+BAJZ3/GBzRj0cRWGPrnlosU+7fS6lNW+hg4yZKpW9LJ/q98r
 xM1Aekw/l1oDsa425sMmLT/5poyGot/HgZiP/5GDR0rQs6SjgtNSKavyKry4WIaeLeer
 fluw==
X-Gm-Message-State: AOJu0YzywmXgcF7KhvFdTHrsASDkq9FN0BGgigpCuERGZybtWcpaJaCJ
 q1BmrCycB3877LPjWPrfJbsRBsTq0tjzJLA8hz3CEO+PyX8WEMY00wsE8td9PenOTlLGRqpYJzP
 6
X-Gm-Gg: ASbGncvk+6vNImt2ogRlz2w4L1HXXG7ClJY3vomWwas4gaAHtrZyeqxemRR5hKWhZgo
 C2XIn00th6+cbNXovYZIdYmrhSEGN0QyNlA4AGEjsB8z93bPRb2woBbDhESBYrk58WTIItKTsYz
 FDT29hnCSSPCZi4QUgNmXw2WTZlZpZeO5rjrCTqzPz+fTeAJEzzXApLcXDmn7Gw7qnqz3D1J6Mp
 zS4BTjMp03bjku5ifexF+3l0ZnXb1sqbJDfS8SQ5ieXOTifPdZaSIkhVToJRkL5O/vwr1AW4QvK
 hWhZnT5lTu1NIGDgB9hHKWBbkI7oGdaY/PXD3fcaCJKHrQktiRXS6V53RG3fGNNHQPDzzo79Fic
 =
X-Google-Smtp-Source: AGHT+IGwZWhHdcYdjOhyTya/VNRAlT6CRIKmMuBS2xhzH+3RAeoXWrg5WAFbpOhezs/G6EW5PvXaaw==
X-Received: by 2002:a17:90b:5108:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-3085ef36625mr573251a91.19.1744745337989; 
 Tue, 15 Apr 2025 12:28:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.28.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:28:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 047/163] tcg: Convert divu2 to TCGOutOpDivRem
Date: Tue, 15 Apr 2025 12:23:18 -0700
Message-ID: <20250415192515.232910-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
index f6192142ba..1f95c9c3f7 100644
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
@@ -5470,6 +5468,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index ff750e2df8..b2c08bba3e 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1897,6 +1897,10 @@ static const TCGOutOpBinary outop_divu = {
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
index 9238e0e8e4..0e6b743fb2 100644
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
index adbc7ee39d..280afbf297 100644
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


