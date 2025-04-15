Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A0DC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mHb-0003li-3m; Tue, 15 Apr 2025 15:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m9N-0005dx-WA
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8S-00062e-0z
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:41 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so5367817b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745971; x=1745350771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKKBCenfXbWJr8fzMnuGP8q1iw4IelJjEW9DoHdkWxg=;
 b=Oow58xxm8+3fIOToZGJLHCj/sSnsNVYVMwW3Orv9d+z0iGVd+PBwNApJuSN3g5ieIq
 zLJDp0mTVPDgVmNiDvVxz10dxe8mJfkb3oLJeEOh1WDiG492dDQqlJ1/C/OrZjPt0slg
 te58m4/4Sb0pRfhgvEYQvFdESkDp6zQAJEklVtWQ57Hv7IibIpy1VUQhFFJkG1L4ax9o
 vHhBV2P4uoIVlnwXP6tSqCEA/TTOKyKiWqI6lFI8RfW6pYyzJHRIilC8UJ7pKm0Bdmc+
 Yaw46wLJmcnrLZF+K7c20kaqjpfSRijxo/r9PF/nzY7jZQL95rUOPfyHiaWxxWCCsE3H
 wz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745971; x=1745350771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKKBCenfXbWJr8fzMnuGP8q1iw4IelJjEW9DoHdkWxg=;
 b=FNPtlaUX2ranDcQtRuuuBIls73l6uJCUvTT1CqH4k51vLupYxr4KGkky30vP6Wqij5
 5zsBd3QOuBTnNkBpMcyHwNNs8Qaa4k6i1LiB7+6PJmBV/o/+8kVIS6VlaEexbk1I7+HL
 IgVrkzscQOhIZtc8bV9YbcDDNe/z2zoCn+cmKXN8ms/Sqmij6qunElhOvOMg/40F7Npy
 kOruUdyD0U8rMuu6Xnm0wnfW8Y0GuCDGfZEi5Dl7zJe0AYVp6lM/4ZhUnIodgeDaASb8
 JCT8JCeRoLMDvS8Xc97YaRNEQU4/wFlRfiIBTiXEJwZ+UYjxsnppS4SprwcpORMsi22Y
 xbFg==
X-Gm-Message-State: AOJu0YyyiebwGXaoforeWB8zy7SFnR7Hq9NVm8478X+gIo9s9/WvQSwf
 UzynBygYb8nACchNmablWdjQ5noY44gCvhViJp4DBWl3W8YTdVzJzWqqPP0pmfd+pvrh0N/XM9s
 w
X-Gm-Gg: ASbGncu1ojYbmh5Q8s9bmVXLCpNgXOyPDFZuoHqXbFPVFjVKXw7KGgWL30lzyH77tA9
 HyHDRgxyi+UKGRfft+m1DvQ5PaSE0ccGxw6PT/wEOHORd8y5bp4jY9eFGxDaxOKMuSFrUejaVQ1
 xi2o0JL8Vt/HDKwpoyCVZLnE2dQazKO36bfQzPuaEBm44iOdBsxjNncIGpc+jRgPjlpJVvzQvH0
 /tcdWwYkG4daRSuI6mGAGxn/uZYghXzAwKzRrSkrgp3M0Fn/I7ESQTlEXP+IfcxFs3nEUL4NzgX
 OJ9hadUXOeTTrVXaex946uD1NTcarol5tXqPoWHPFRR1N8AVg7a8qi+Xs96ypVKADQNis6OmwvY
 =
X-Google-Smtp-Source: AGHT+IETrAJ2ZFM5/WVmwscDIYxA1P5Sfs+F2tk8xwoOb+nq0siTqpF2gU9ffWCehJ9k5TxkZwgtww==
X-Received: by 2002:a05:6a00:1253:b0:736:b402:533a with SMTP id
 d2e1a72fcca58-73c1f8c6a38mr803505b3a.1.1744745971322; 
 Tue, 15 Apr 2025 12:39:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233553fsm9228554b3a.172.2025.04.15.12.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:39:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 163/163] tcg: Remove tcg_out_op
Date: Tue, 15 Apr 2025 12:25:14 -0700
Message-ID: <20250415192515.232910-164-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
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
index 823bcc6cfc..35a30f893d 100644
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
@@ -5918,12 +5915,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index 7b78ab67f4..2d7598d755 100644
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
index 49522dcd72..b5d00876cb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2030,13 +2030,6 @@ static const TCGOutOpStore outop_st = {
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
index 123e74290a..c0dd9636d9 100644
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
index 49a4f4f281..09380799e9 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2069,13 +2069,6 @@ static const TCGOutOpStore outop_st = {
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


