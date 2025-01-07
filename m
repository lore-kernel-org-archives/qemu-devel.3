Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B50EE7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bj-0005iF-E8; Tue, 07 Jan 2025 03:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ah-0000ii-9i
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:32 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aW-0003QM-LS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21634338cfdso1926195ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237119; x=1736841919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTr4p2Tjb+75asMEDtFIj/1tlXTFqb/C9OC2Vdukr3g=;
 b=SyWXhFQM4OI6IhS9VzOTAUDdWZg9Q6bncxrWVrOSMbZQtpcp7GABI/+7zRBjYBSV3Z
 4hjUmpsSM9dq4KbWHcP7V/L6AibnoUEKJqhIFcEEtFcGPmAkH470yXDxjgqXPzHF6u5S
 Eu0FH5MOv8qqJghhWIDOp1uMgcMS58HwuMn5w6Lu6O5k9T8Z5UtLoWbYvpUTKu5VMKIn
 Z04hI8Q6rKpSe7wg4DLykoXrUZJi1+h2S2g5oDtKK6SJtR/MFHMbKCqiv3uTYtcr4XXV
 RD3Dm/NPpuXlyZ85lkMQKkk0x1/kCPcnWi2UXjPy3Up8cENirAU6RrsvfeVnPkP/2R/g
 6RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237119; x=1736841919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTr4p2Tjb+75asMEDtFIj/1tlXTFqb/C9OC2Vdukr3g=;
 b=PazRJTCNvzSW1YxT7C1s7QuUnU4Op/GG313LCae4p/cb9VjsndzbLa+3hdTqWOwGU+
 3uy07aRohU9rx+NxxiFQHh1N3r+59s/9pICoHOaPIpVliaPda6R4anlh+72N0K87gvOO
 igdiIiM04V7b5SD2OFb3o6GDq82om5im7q9E4dvKTrs/fWIQYNFuLBoWvo/1ERZMX2Bx
 qYCr9JNLxbwtnni626256xdgG8PINc/BumB/45ZWSbePF03Xxaa3fOZF8hfuA+Getr8Y
 sJaHB8Ux4DLgEknR7ONvjpkLdqwXYyP0hB2YgPgkwuOQIe3OAdT3k9hC6itW62lTw2/h
 3nag==
X-Gm-Message-State: AOJu0YxRCLOquJ8vO/cfMnuy0jzhFFcgVV4ZcjyAn+mAuvONAsEUW1H0
 D2WRMd/K4TO3agn85AKIyKCA513dQJsNYlQikHxfexITsqumzu/uRhAck/p4wC9rTzGnGStc/b0
 w
X-Gm-Gg: ASbGnctWZF2hqMch+O7LPt9bCgY2hFSo0IeWCpK9BLy/pJUl875xL9mBH5iDCehh0O+
 87fazxbepLvcbgv4TL9plFaOXhcRyWOFvv1rRB9pM5yCj14R/UkzGcJNvpWYidJjALbUacT8R25
 2aoATAdMsgKxiN70pCalMEMkU8KLYgllzBCpnJ8MYarZwaYo4jAdtGeKnhv9wL8hqSVyoni62An
 skIIxbPzs+aJXsuQTaASWhxSC+GOtcgd0mZ0edznaJ2KkLen+hBUX/yyfYGLS9bv4Jv2g73kmMi
 QSTws2vzag6E41+OCg==
X-Google-Smtp-Source: AGHT+IH6/8CmM5h0iPRv16yQXK7a5hUHTpesQVnpjqcLycURqUFrLDBa3pIhM2ZinCM9AVv3XqdJ/Q==
X-Received: by 2002:a05:6a00:300e:b0:725:e057:c3dd with SMTP id
 d2e1a72fcca58-72abdeb7adfmr87969949b3a.22.1736237119227; 
 Tue, 07 Jan 2025 00:05:19 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 61/81] tcg: Merge INDEX_op_or_{i32,i64}
Date: Tue,  7 Jan 2025 00:00:52 -0800
Message-ID: <20250107080112.1175095-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 include/tcg/tcg-opc.h    | 3 +--
 target/sh4/translate.c   | 4 ++--
 tcg/optimize.c           | 6 ++++--
 tcg/tcg-op.c             | 4 ++--
 tcg/tcg.c                | 9 +++------
 tcg/tci.c                | 5 ++---
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 33c10cacf6..f3321822f2 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -42,6 +42,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(or, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -64,7 +65,6 @@ DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 DEF(div2_i32, 2, 3, 0, 0)
 DEF(divu2_i32, 2, 3, 0, 0)
-DEF(or_i32, 1, 2, 0, 0)
 DEF(xor_i32, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
@@ -124,7 +124,6 @@ DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 DEF(div2_i64, 2, 3, 0, 0)
 DEF(divu2_i64, 2, 3, 0, 0)
-DEF(or_i64, 1, 2, 0, 0)
 DEF(xor_i64, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index acc6b92f18..17e09f3d2a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1949,7 +1949,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         op_opc = INDEX_op_xor_i32;
         goto do_reg_op;
     case 0x200b: /* or Rm,Rn */
-        op_opc = INDEX_op_or_i32;
+        op_opc = INDEX_op_or;
     do_reg_op:
         /* The operation register should be as expected, and the
            other input cannot depend on the load.  */
@@ -2119,7 +2119,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_or_i32:
+    case INDEX_op_or:
         if (op_dst != st_src) {
             goto fail;
         }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3c9f74e4dd..b84bdb989e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -425,7 +425,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_and_vec:
         return x & y;
 
-    CASE_OP_32_64_VEC(or):
+    case INDEX_op_or:
+    case INDEX_op_or_vec:
         return x | y;
 
     CASE_OP_32_64_VEC(xor):
@@ -2946,7 +2947,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64_VEC(not):
             done = fold_not(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(or):
+        case INDEX_op_or:
+        case INDEX_op_or_vec:
             done = fold_or(&ctx, op);
             break;
         CASE_OP_32_64_VEC(orc):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d87bd13375..6807f4eebd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -436,7 +436,7 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_or_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_or, ret, arg1, arg2);
 }
 
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1585,7 +1585,7 @@ void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_or_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
     } else {
         tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ab4646e20e..1edb422fff 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -994,8 +994,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_or_i32, TCGOutOpBinary, outop_or),
-    OUTOP(INDEX_op_or_i64, TCGOutOpBinary, outop_or),
+    OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
 };
 
 #undef OUTOP
@@ -2212,6 +2211,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_mov:
+    case INDEX_op_or:
         return has_type;
 
     case INDEX_op_setcond_i32:
@@ -2228,7 +2228,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -2308,7 +2307,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
@@ -5428,8 +5426,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
+    case INDEX_op_or:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index b7023648ff..2c0366e2dd 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -549,7 +549,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & regs[r2];
             break;
-        CASE_32_64(or)
+        case INDEX_op_or:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | regs[r2];
             break;
@@ -1139,12 +1139,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_or:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
     case INDEX_op_orc_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 9d0fc35a70..c8b0d8c631 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -691,7 +691,7 @@ static const TCGOutOpBinary outop_andc = {
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_or_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_or, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_or = {
-- 
2.43.0


