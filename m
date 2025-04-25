Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DFDC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBr-0006r4-7j; Fri, 25 Apr 2025 18:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RBF-0004Y8-8p
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RBC-0001wZ-Hv
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so3089337b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618752; x=1746223552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBEegdRGRZ2HBxKX6riLJO9s4P0HZLe93Z7qeplLMOM=;
 b=O/0iAwy4NqlyhHGP7O+bBYESw4wMez0fD5R4lCF8lkfoKi4QMkmL/ZmY04/WwAZEmc
 zzxwuoyK0er8ewS0Z0ojQV7fjnnlFrseymKLbhNoQpQHxIjO4oyqP2ZLbEduV/aqKjow
 xs0Ft38XHpulMn4bVvu2SdDGNf7ufm+RAPQSRK9oavj7WjtKjDCNcJFz3mUl0xltRVJh
 bFiBPGxg9BRESE0ibZD7cNRJxkkk1zOSwGpBccqK4dfU77/vIRlbnVP04MG/zViFIeRZ
 6sxvURMn3uyDEmVh6R7iUQCKBuvKA7HbaE+jZZ+VL66Rr4cBoZHlyLsHRSCGp3sh8CpU
 GfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618752; x=1746223552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBEegdRGRZ2HBxKX6riLJO9s4P0HZLe93Z7qeplLMOM=;
 b=UZVm8rlb5FjBosv46NDggOTSTs6/xaVN5axHO9TbnkTeo69WVmaqYbXYtX+Y8RTWQb
 0pwh+B+JcZi47mrzA88bYCgVdhGqE/vb2IjLZVCFtjdkzwH4ekFz3qs0yOhpnzlW/OXy
 ErRwpsudm33mH94pfj2FnagxxHox/jP1YSbX4qoUnO+kmfFrdkDE/Eq04vs6shkY4xWu
 rUOsr4RBNH76vqEdlzogopIFdNXJyAAaUR9AHI7z+P+afYwe+AdnC90uER2lVUP3xzyf
 UHwi4b1ky1inNh7ayHcL1zTHIYlpSUXNU12C5MEYjuLdNs3nNInGNtWTV8ZTg4fTIaeS
 e9Rg==
X-Gm-Message-State: AOJu0Yz1dH4dI+jgwQcLn90CiBlu+JgeIr87e2TUJQVWjn2g48yj0LV9
 0EVbveZtlyr4l+Pq8hhMducb0PCgC5uKlYLO8dw6ewN1A+ega9ogaJ2swQqJ2bKnIbpm/7kTIMH
 g
X-Gm-Gg: ASbGncuSgg/ie2ad1Qo3k3vLOJdgeRKUL/WyKiPISvZTWI3HFi75/Gq8eaL1ID4Y2nN
 sMTJxUsBoL4bWgv3Sn7gTCIshXKr+Pra8TEScM/A5X16FWQbkjf+/J1aOpjmtxGlqdNxNjcQBX/
 a+TJM2/KjiG+45slV4QMix+tadR8vtTOflnFHYonV12QUWQbJSBfNaFYGUqITUoj1yXAe49b3uh
 lb7hEL+NPTU3igeKkOKXsxaXph+DIVCOE83HSMWO4Eei22FaTO90Vw7GH6Z8rPIwvCythMMhvZh
 i6lcUL6zA5Sg1YeM4KSfSGjIJYQYPd+N2vZz7KzQPWGccMQ0V6sxZ+EwItJvKy30H5ByvxB+aa8
 =
X-Google-Smtp-Source: AGHT+IGYqE2N64/3KQQ7+NtDWa3TW1jXkBrHRDcVgdCA9fp3zrzMTZxSquBNvcxK1Sqmue54Bl7AoA==
X-Received: by 2002:a05:6a00:2e22:b0:736:6d4d:ffa6 with SMTP id
 d2e1a72fcca58-73fd89798f5mr4825832b3a.15.1745618751745; 
 Fri, 25 Apr 2025 15:05:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 159/159] tcg: Remove tcg_out_op
Date: Fri, 25 Apr 2025 14:54:53 -0700
Message-ID: <20250425215454.886111-160-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

All integer opcodes are now converted to TCGOutOp.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 12 +++---------
 tcg/aarch64/tcg-target.c.inc     |  7 -------
 tcg/arm/tcg-target.c.inc         |  7 -------
 tcg/i386/tcg-target.c.inc        |  7 -------
 tcg/loongarch64/tcg-target.c.inc |  7 -------
 tcg/mips/tcg-target.c.inc        |  7 -------
 tcg/ppc/tcg-target.c.inc         |  7 -------
 tcg/riscv/tcg-target.c.inc       |  7 -------
 tcg/s390x/tcg-target.c.inc       |  7 -------
 tcg/sparc64/tcg-target.c.inc     |  7 -------
 tcg/tci/tcg-target.c.inc         |  7 -------
 11 files changed, 3 insertions(+), 79 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 302f7025e7..c4e866e9c3 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -138,9 +138,6 @@ static void tcg_out_mb(TCGContext *s, unsigned bar);
 static void tcg_out_br(TCGContext *s, TCGLabel *l);
 static void tcg_out_set_carry(TCGContext *s);
 static void tcg_out_set_borrow(TCGContext *s);
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS]);
 #if TCG_TARGET_MAYBE_vec
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src);
@@ -5920,12 +5917,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     default:
-        if (def->flags & TCG_OPF_VECTOR) {
-            tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
-                           TCGOP_VECE(op), new_args, const_args);
-        } else {
-            tcg_out_op(s, op->opc, type, new_args, const_args);
-        }
+        tcg_debug_assert(def->flags & TCG_OPF_VECTOR);
+        tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
+                       TCGOP_VECE(op), new_args, const_args);
         break;
     }
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index be1ca74bc4..e56dc135b6 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2897,13 +2897,6 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 014a441420..447e43583e 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2640,13 +2640,6 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 9f294f28ed..09fce27b06 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3602,13 +3602,6 @@ static const TCGOutOpStore outop_st = {
     .out_i = tgen_st_i,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static int const umin_insn[4] = {
     OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
 };
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c74ddee644..e5580d69a8 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2042,13 +2042,6 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 1f12500344..2c0457e588 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2444,13 +2444,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 824cced94a..2e94778104 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3828,13 +3828,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index eca1283742..f9417d15f7 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2642,13 +2642,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a316c8de41..7ca0071f24 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3160,13 +3160,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d1dd0fa33c..83167aa29d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2074,13 +2074,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 50e205211d..35c66a4836 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1235,13 +1235,6 @@ static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
         TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_st2,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
                        intptr_t offset)
 {
-- 
2.43.0


