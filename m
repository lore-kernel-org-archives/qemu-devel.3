Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C370DC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R14-0007ZR-El; Fri, 25 Apr 2025 17:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0s-0007Nk-7m
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0n-0000WJ-Lf
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so3080924b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618108; x=1746222908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdSWyqzZthKcVVs2nDt4mI1+pJgV9kYRwSyigqK8RCc=;
 b=zCD5k9qwgULB9z7422lna5H02CrvVaNXMt7svdY3XWdy20kEImeXJ7zGgx1ueyOSwe
 n0S/EeK8T3DAwtXm3GCQ6MmUTcZR71qiFZ1NriL5Nxgyx83U9G64/Uh13ScSQJFTXu9q
 aT6JGvGOn2L7zFWlDv5f+FepIzCiegrLXxvUjXDQToyVtJKm/dCPj0asc67ncDqGykKA
 WdaiORPRcVST2Y4HL5wIx7rU3Xfo1GFd4Z1hE7eN3TO0Kb4WXbtoGbL572cQ+BfyF6+y
 JrNO4//Mgk5ePs8fuqw74UX9SeqArTfW72PRkkcwq4ZpcGDX5hBZtiqzRQYSvLY1BVfs
 qfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618108; x=1746222908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdSWyqzZthKcVVs2nDt4mI1+pJgV9kYRwSyigqK8RCc=;
 b=m3/E/S8Bap4F/SyoYYmSgdNsP5ObeFVFfZMr7uISsiFciOQkfexXtACrUQiT6yzzqn
 edw3izoiMM22BexB5p5ku/2Zdk1o5QIkx5gLycYWvvMGucXdnv2yHTy9YCehEXzZgdQ3
 65LA8A5w00kz39VEPMxECsoUdDklYmSBxiACq7aDeDcyzBpVB0V4CTBcJFz11ahjk/i+
 G8eTwhHOJWzxdNJZLJgtcPXeVOHAexKqR6HeA/W1JoQodCEKMmqhB1cTog/VEHs8yxPy
 Pl09H1i6ZihnMvbbiRqQ6pruJ6FZAhzpy1MNNPlLqPLwx4JwYV5BG4Z3V+afvW/F6kUu
 w3yg==
X-Gm-Message-State: AOJu0YxJ8UbsYNc/ZRbpYKX1e7qwXYBQzxizYzM+D4w9tLuEOVx37xsa
 MSxtOsmkpGgKpHJM0KovRaxlq592CoesUMgOV+kKvahEEpf1MctEVaYN0tR7gSiPFWo3sZaTTp9
 +
X-Gm-Gg: ASbGncuI5D4KP3XgX7WpU0nRk6nrZW4vjQg1fu0uH2vkVdwGQ7P2iExgCUf10kYlL7V
 D76+jFzstiHc2WB7N9CDMxqJhmLmW6P/52Pajo9DMNku4vyOcSWIdBV9EQgBaPsQERuKN5LKfnu
 DBGyThs2jX3RbZD3myrJINl93AMO9mBZGmKCyPTx6RRXVn2R7+OEyZ7aUeaa7OvAZta0cuc8sMg
 g8p6iRf5p06L9ZwESP8b521dnIGjkpp+JHbTVm+Gs8h7W/8FARPuwYleiTUb4pVFR3owr8/osMi
 ikd+52lCFFbJUcrFJsL50aaKUSD005/CAgFqus6MPy76x3LaxZz4fFerQN/v0MaUwNIvZm2XEdw
 =
X-Google-Smtp-Source: AGHT+IHnfRr7E4fE1eiKWU7JCf6b+5v+hwYLMPedEDVcfsM9I4IuKqsJwx79Nmxvm50GhoKYeMLWHQ==
X-Received: by 2002:a05:6a21:4006:b0:1ee:e24d:8fe3 with SMTP id
 adf61e73a8af0-2045b6e7c7cmr5560282637.10.1745618107869; 
 Fri, 25 Apr 2025 14:55:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 017/159] tcg: Convert or to TCGOutOpBinary
Date: Fri, 25 Apr 2025 14:52:31 -0700
Message-ID: <20250425215454.886111-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 tcg/tcg.c                        |  4 +++
 tcg/aarch64/tcg-target.c.inc     | 31 ++++++++++++---------
 tcg/arm/tcg-target.c.inc         | 24 ++++++++++++----
 tcg/i386/tcg-target.c.inc        | 25 +++++++++++++----
 tcg/loongarch64/tcg-target.c.inc | 29 ++++++++++++--------
 tcg/mips/tcg-target.c.inc        | 25 ++++++++++++-----
 tcg/ppc/tcg-target.c.inc         | 29 ++++++++++++--------
 tcg/riscv/tcg-target.c.inc       | 29 ++++++++++++--------
 tcg/s390x/tcg-target.c.inc       | 47 +++++++++++++++++---------------
 tcg/sparc64/tcg-target.c.inc     | 23 ++++++++++++----
 tcg/tci/tcg-target.c.inc         | 14 ++++++++--
 11 files changed, 186 insertions(+), 94 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 38b2dd1c44..7357b5c127 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1007,6 +1007,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
+    OUTOP(INDEX_op_or_i32, TCGOutOpBinary, outop_or),
+    OUTOP(INDEX_op_or_i64, TCGOutOpBinary, outop_or),
 };
 
 #undef OUTOP
@@ -5441,6 +5443,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index c7167cad15..4b62e4e382 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2157,6 +2157,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, ORR, type, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_logicali(s, I3404_ORRI, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rL),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2238,17 +2256,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_or_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_or_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_ORRI, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3510, ORR, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_orc_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3016,8 +3023,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
     case INDEX_op_orc_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index feea82145a..0575d397c9 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1881,6 +1881,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_ORR, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_ORR, a0, a1, encode_imm_nofail(a2));
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1943,13 +1961,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[0], args[1], args[2], const_args[2]);
         }
         break;
-    case INDEX_op_or_i32:
-        c = ARITH_ORR;
-        goto gen_arith;
     case INDEX_op_xor_i32:
         c = ARITH_EOR;
-        /* Fall through.  */
-    gen_arith:
         tcg_out_dat_rI(s, COND_AL, c, args[0], args[1], args[2], const_args[2]);
         break;
     case INDEX_op_add2_i32:
@@ -2209,7 +2222,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
         return C_O1_I2(r, r, rI);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 33c1fcc717..813092622c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2633,6 +2633,26 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_OR + rexw, a0, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_OR + rexw, a0, a2, false);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2717,9 +2737,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(or):
-        c = ARITH_OR;
-        goto gen_arith;
     OP_32_64(xor):
         c = ARITH_XOR;
         goto gen_arith;
@@ -3645,8 +3662,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, 0, re);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b7d2984a8a..a7ead51263 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1332,6 +1332,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_or(s, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_ori(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1392,15 +1410,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-        if (c2) {
-            tcg_out_opc_ori(s, a0, a1, a2);
-        } else {
-            tcg_out_opc_or(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         if (c2) {
@@ -2300,8 +2309,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         /* LoongArch reg-imm bitops have their imms ZERO-extended */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ab57c78095..74eef1d3b3 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1712,6 +1712,24 @@ static const TCGOutOpBinary outop_andc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1785,14 +1803,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-        i1 = OPC_OR, i2 = OPC_ORI;
-        goto do_binary;
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         i1 = OPC_XOR, i2 = OPC_XORI;
-    do_binary:
         if (c2) {
             tcg_out_opc_imm(s, i2, a0, a1, a2);
             break;
@@ -2218,9 +2231,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rI);
     case INDEX_op_shl_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7b1a82c9fa..b638a5f813 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2954,6 +2954,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, OR | SAB(a1, a0, a2));
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_ori32(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3039,15 +3057,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i64:
-    case INDEX_op_or_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_ori32(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, OR | SAB(a1, a0, a2));
-        }
-        break;
     case INDEX_op_xor_i64:
     case INDEX_op_xor_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
@@ -4130,7 +4139,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_orc_i32:
     case INDEX_op_eqv_i32:
@@ -4172,7 +4180,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
         return C_O1_I2(r, rI, ri);
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rU);
     case INDEX_op_sub_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f637604e98..9bacd109d4 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2013,6 +2013,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2091,15 +2109,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         if (c2) {
@@ -2682,9 +2691,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e4b60d1924..9267aef544 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2242,6 +2242,31 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, OGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, OR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, ORK, a0, a1, a2);
+    }
+}
+
+static void tgen_ori_3(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    tgen_ori(s, a0, type == TCG_TYPE_I32 ? (uint32_t)a2 : a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rK),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori_3,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2310,17 +2335,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_ori(s, a0, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, OR, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, ORK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_xor_i32:
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
@@ -2561,15 +2575,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_ori(s, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, OGRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_xor_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -3282,10 +3287,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rK);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index fe9175aa1a..b01d55c80b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1333,6 +1333,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_OR);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_OR);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1390,9 +1408,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(or):
-        c = ARITH_OR;
-        goto gen_arith;
     OP_32_64(orc):
         c = ARITH_ORN;
         goto gen_arith;
@@ -1612,8 +1627,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_xor_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 92c588305a..6fdfcab061 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -101,8 +101,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_xor_i32:
@@ -668,6 +666,17 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_or_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_or,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -712,7 +721,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(or)
     CASE_32_64(xor)
     CASE_32_64(orc)      /* Optional (TCG_TARGET_HAS_orc_*). */
     CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
-- 
2.43.0


