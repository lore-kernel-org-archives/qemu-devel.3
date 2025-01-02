Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820CCE77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfY-0004vi-N7; Thu, 02 Jan 2025 13:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPen-0007Xt-9O
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:53 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPei-0006HQ-TI
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:53 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21634338cfdso227848705ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841448; x=1736446248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CV8HJEyEX5ItRU4uQz+8/aXsaJaBLDEn+F7xZFlqorw=;
 b=OHD8QQK4Emm4OEZ7inE1qSIPA+sdekdTUQwqthinn+JgNS6JLiqzQwKnwlzLmkk0ky
 ZvpQFoYk589klRdwmfCCVR5xLgEPFtnPzszePToRp3HT4U58p6XAQdnqbuDz3wmPCaM+
 oITQYRySTpiUbauhkAzKB8NBb6kM2ojE5iyLpTQBjCCa6ARZ5KzEKJi+owVpDvlULYNK
 Lkf/zCnAMn0mUSyDnn9th1Y+f7hQMGn1TDCwjbSMNesDa/twU/NkmyWAyN3ZRjx6nTcz
 RszeGzJyHSHg1fmth2FTzo/NFSuxytKAjZi4T5JUqrJuR3p8zR8BlzRQpGgKmZEfli4S
 AZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841448; x=1736446248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CV8HJEyEX5ItRU4uQz+8/aXsaJaBLDEn+F7xZFlqorw=;
 b=LZVZ2KRSOnySPhvftN31TRRUcuQ+q484I2CPdSjdHRs/gpn7DNgR7v1RK3tqOtGifa
 8k+CiFP8py8VcxMKaOIf/8Y/3PsPAsZOt69Zw2Ky8xpjs2PSrSBpjwQqOQwzAHRYPZwf
 qMAVMavKT1xBDoheJLOa1JKT4dZcvvdQsRmbwShINnqgLK5L55jzyrUbXGPBjK7WtngY
 EDCsZg1CQ0j0aol88c0olejJCMt6tXKUjkeFvjnO7lHmiQfqwxFMeJ0c3YndCwsYNIwR
 HDT+7S4Z+GeadzhZafjinZaOZoRyZ1foT1EbgL7oF9GRvsCHzTZ+EaV25iRq5VzFSOA/
 xFFg==
X-Gm-Message-State: AOJu0Yy344OzIXdToXpWvFzScdRr1flnCGYwbrAB0yPol00Yq/6PJUL2
 ddxCGsNfFWD4TiMO4LACBxa0hkt2Vz5JeQN2nckP9inf1jc9hgl36yyzHnKQCkMJmDRGR+k+gx+
 g
X-Gm-Gg: ASbGncu+BVn+6v1QfT9yfhKDPJagFHtad7KHHdNbTXz7SUcp1pQwkyXt1ojc4OfgQqp
 uxpBy3zVOnXQ0507JnebvnycnpGYek0tE5mOedkqCtd4lGA5P0MwDt5MBgWxiMInOO56G3kMKQP
 ZvU9W+3w0y4DVHhoGOZebepM+CiEInx+AwzOySAXQ7EcBWzYmebo15WryY53whFz1jFOFyxYWk4
 6mMyLcFjTFCn1bozwAQmhb9U01ztdmkJ2z6V6mVn5i/hdP1WKaiSK6pfO1RoQ==
X-Google-Smtp-Source: AGHT+IGBlErsnvz7yw7K/t+7pS5Dn3AEV+wykIEghLxhQToqhHEo/PF85W9RsOPmuePvLIrBFhFPfw==
X-Received: by 2002:a05:6a00:1a92:b0:725:e499:5b88 with SMTP id
 d2e1a72fcca58-72abdecb23fmr68737338b3a.25.1735841447223; 
 Thu, 02 Jan 2025 10:10:47 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 66/73] tcg: Merge brcond, setcond, negsetcond,
 movcond operations
Date: Thu,  2 Jan 2025 10:06:46 -0800
Message-ID: <20250102180654.1420056-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
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

For TCI, we're losing type information from the interpreter.
Add tci_setcond32 and tci_movcond32 in order to retain two
different comparison opcodes for a 64-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 14 +++-----
 target/sh4/translate.c           |  6 ++--
 tcg/optimize.c                   | 46 ++++++++------------------
 tcg/tcg-op.c                     | 16 ++++-----
 tcg/tcg.c                        | 56 ++++++++++++--------------------
 tcg/tci.c                        | 29 +++++++----------
 tcg/aarch64/tcg-target.c.inc     | 32 +++++-------------
 tcg/arm/tcg-target.c.inc         | 16 ++++-----
 tcg/i386/tcg-target.c.inc        | 20 +++++-------
 tcg/loongarch64/tcg-target.c.inc | 23 +++++--------
 tcg/mips/tcg-target.c.inc        | 18 ++++------
 tcg/ppc/tcg-target.c.inc         | 44 +++++++------------------
 tcg/riscv/tcg-target.c.inc       | 24 +++++---------
 tcg/s390x/tcg-target.c.inc       | 55 ++++++++++---------------------
 tcg/sparc64/tcg-target.c.inc     | 56 ++++++++++++++++----------------
 tcg/tci/tcg-target-opc.h.inc     |  2 ++
 tcg/tci/tcg-target.c.inc         | 53 ++++++++++++++++--------------
 17 files changed, 196 insertions(+), 314 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 964f919205..1b133a63ea 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -64,9 +64,11 @@ DEF(remu, 1, 2, 0, TCG_OPF_INT)
 DEF(div2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 
-DEF(setcond_i32, 1, 2, 1, 0)
-DEF(negsetcond_i32, 1, 2, 1, 0)
-DEF(movcond_i32, 1, 4, 1, 0)
+DEF(brcond, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | TCG_OPF_INT)
+DEF(setcond, 1, 2, 1, TCG_OPF_INT)
+DEF(negsetcond, 1, 2, 1, TCG_OPF_INT)
+DEF(movcond, 1, 4, 1, TCG_OPF_INT)
+
 /* load/store */
 DEF(ld_i32, 1, 1, 2, 0)
 DEF(st_i32, 0, 2, 2, 0)
@@ -81,8 +83,6 @@ DEF(extract_i32, 1, 1, 2, 0)
 DEF(sextract_i32, 1, 1, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
-DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
-
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -92,9 +92,6 @@ DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
-DEF(setcond_i64, 1, 2, 1, 0)
-DEF(negsetcond_i64, 1, 2, 1, 0)
-DEF(movcond_i64, 1, 4, 1, 0)
 /* load/store */
 DEF(ld_i64, 1, 1, 2, 0)
 DEF(st_i64, 0, 2, 2, 0)
@@ -115,7 +112,6 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5cb9ba9434..2ef48b1d17 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1995,7 +1995,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         if ((ld_dst == B11_8) + (ld_dst == B7_4) != 1 || mv_src >= 0) {
             goto fail;
         }
-        op_opc = INDEX_op_setcond_i32;  /* placeholder */
+        op_opc = INDEX_op_setcond;  /* placeholder */
         op_src = (ld_dst == B11_8 ? B7_4 : B11_8);
         op_arg = REG(op_src);
 
@@ -2030,7 +2030,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         if (ld_dst != B11_8 || ld_dst != B7_4 || mv_src >= 0) {
             goto fail;
         }
-        op_opc = INDEX_op_setcond_i32;
+        op_opc = INDEX_op_setcond;
         op_arg = tcg_constant_i32(0);
 
         NEXT_INSN;
@@ -2147,7 +2147,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond:
         if (st_src == ld_dst) {
             goto fail;
         }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index da3bec5d43..3061459944 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1495,14 +1495,14 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
         break;
 
     do_brcond_low:
-        op->opc = INDEX_op_brcond_i32;
+        op->opc = INDEX_op_brcond;
         op->args[1] = op->args[2];
         op->args[2] = cond;
         op->args[3] = label;
         return fold_brcond(ctx, op);
 
     do_brcond_high:
-        op->opc = INDEX_op_brcond_i32;
+        op->opc = INDEX_op_brcond;
         op->args[0] = op->args[1];
         op->args[1] = op->args[3];
         op->args[2] = cond;
@@ -1952,40 +1952,20 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
     if (ti_is_const(tt) && ti_is_const(ft)) {
         uint64_t tv = ti_const_val(tt);
         uint64_t fv = ti_const_val(ft);
-        TCGOpcode opc, negopc = 0;
         TCGCond cond = op->args[5];
 
-        switch (op->type) {
-        case TCG_TYPE_I32:
-            opc = INDEX_op_setcond_i32;
-            if (TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32)) {
-                negopc = INDEX_op_negsetcond_i32;
-            }
-            tv = (int32_t)tv;
-            fv = (int32_t)fv;
-            break;
-        case TCG_TYPE_I64:
-            opc = INDEX_op_setcond_i64;
-            if (TCG_TARGET_HAS_negsetcond(TCG_TYPE_I64)) {
-                negopc = INDEX_op_negsetcond_i64;
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-
         if (tv == 1 && fv == 0) {
-            op->opc = opc;
+            op->opc = INDEX_op_setcond;
             op->args[3] = cond;
         } else if (fv == 1 && tv == 0) {
-            op->opc = opc;
+            op->opc = INDEX_op_setcond;
             op->args[3] = tcg_invert_cond(cond);
-        } else if (negopc) {
+        } else if (TCG_TARGET_HAS_negsetcond(op->type)) {
             if (tv == -1 && fv == 0) {
-                op->opc = negopc;
+                op->opc = INDEX_op_negsetcond;
                 op->args[3] = cond;
             } else if (fv == -1 && tv == 0) {
-                op->opc = negopc;
+                op->opc = INDEX_op_negsetcond;
                 op->args[3] = tcg_invert_cond(cond);
             }
         }
@@ -2469,14 +2449,14 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
     do_setcond_low:
         op->args[2] = op->args[3];
         op->args[3] = cond;
-        op->opc = INDEX_op_setcond_i32;
+        op->opc = INDEX_op_setcond;
         return fold_setcond(ctx, op);
 
     do_setcond_high:
         op->args[1] = op->args[2];
         op->args[2] = op->args[4];
         op->args[3] = cond;
-        op->opc = INDEX_op_setcond_i32;
+        op->opc = INDEX_op_setcond;
         return fold_setcond(ctx, op);
     }
 
@@ -2771,7 +2751,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_andc_vec:
             done = fold_andc(&ctx, op);
             break;
-        CASE_OP_32_64(brcond):
+        case INDEX_op_brcond:
             done = fold_brcond(&ctx, op);
             break;
         case INDEX_op_brcond2_i32:
@@ -2837,7 +2817,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_mov_vec:
             done = fold_mov(&ctx, op);
             break;
-        CASE_OP_32_64(movcond):
+        case INDEX_op_movcond:
             done = fold_movcond(&ctx, op);
             break;
         case INDEX_op_mul:
@@ -2908,10 +2888,10 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(shr):
             done = fold_shift(&ctx, op);
             break;
-        CASE_OP_32_64(setcond):
+        case INDEX_op_setcond:
             done = fold_setcond(&ctx, op);
             break;
-        CASE_OP_32_64(negsetcond):
+        case INDEX_op_negsetcond:
             done = fold_negsetcond(&ctx, op);
             break;
         case INDEX_op_setcond2_i32:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 18839714f3..7dbc7b1ad6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -522,7 +522,7 @@ void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond_i32,
+        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond,
                                       arg1, arg2, cond, label_arg(l));
         add_as_label_use(l, op);
     }
@@ -545,7 +545,7 @@ void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i32(ret, 0);
     } else {
-        tcg_gen_op4i_i32(INDEX_op_setcond_i32, ret, arg1, arg2, cond);
+        tcg_gen_op4i_i32(INDEX_op_setcond, ret, arg1, arg2, cond);
     }
 }
 
@@ -563,7 +563,7 @@ void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i32(ret, 0);
     } else if (TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32)) {
-        tcg_gen_op4i_i32(INDEX_op_negsetcond_i32, ret, arg1, arg2, cond);
+        tcg_gen_op4i_i32(INDEX_op_negsetcond, ret, arg1, arg2, cond);
     } else {
         tcg_gen_setcond_i32(cond, ret, arg1, arg2);
         tcg_gen_neg_i32(ret, ret);
@@ -1087,7 +1087,7 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i32(ret, v2);
     } else {
-        tcg_gen_op6i_i32(INDEX_op_movcond_i32, ret, c1, c2, v1, v2, cond);
+        tcg_gen_op6i_i32(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
     }
 }
 
@@ -1865,7 +1865,7 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
                                    TCGV_HIGH(arg1), TCGV_LOW(arg2),
                                    TCGV_HIGH(arg2), cond, label_arg(l));
         } else {
-            op = tcg_gen_op4ii_i64(INDEX_op_brcond_i64, arg1, arg2, cond,
+            op = tcg_gen_op4ii_i64(INDEX_op_brcond, arg1, arg2, cond,
                                    label_arg(l));
         }
         add_as_label_use(l, op);
@@ -1902,7 +1902,7 @@ void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                              TCGV_LOW(arg2), TCGV_HIGH(arg2), cond);
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         } else {
-            tcg_gen_op4i_i64(INDEX_op_setcond_i64, ret, arg1, arg2, cond);
+            tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
         }
     }
 }
@@ -1945,7 +1945,7 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
         tcg_gen_neg_i32(TCGV_LOW(ret), TCGV_LOW(ret));
         tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_LOW(ret));
     } else if (TCG_TARGET_HAS_negsetcond(TCG_TYPE_I64)) {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond_i64, ret, arg1, arg2, cond);
+        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
     } else {
         tcg_gen_setcond_i64(cond, ret, arg1, arg2);
         tcg_gen_neg_i64(ret, ret);
@@ -2819,7 +2819,7 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i64(ret, v2);
     } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op6i_i64(INDEX_op_movcond_i64, ret, c1, c2, v1, v2, cond);
+        tcg_gen_op6i_i64(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 03e5a93600..f084b51a72 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2185,19 +2185,23 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_qemu_st_a64_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
+    case INDEX_op_brcond2_i32:
+    case INDEX_op_setcond2_i32:
+        return TCG_TARGET_REG_BITS == 32;
+
     case INDEX_op_add:
     case INDEX_op_and:
+    case INDEX_op_brcond:
     case INDEX_op_mov:
+    case INDEX_op_movcond:
     case INDEX_op_mul:
     case INDEX_op_neg:
     case INDEX_op_or:
+    case INDEX_op_setcond:
     case INDEX_op_sub:
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_brcond_i32:
-    case INDEX_op_movcond_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_st_i32:
     case INDEX_op_shl_i32:
@@ -2230,6 +2234,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return has_type && TCG_TARGET_HAS_muluh(type);
     case INDEX_op_nand:
         return has_type && TCG_TARGET_HAS_nand(type);
+    case INDEX_op_negsetcond:
+        return has_type && TCG_TARGET_HAS_negsetcond(type);
     case INDEX_op_nor:
         return has_type && TCG_TARGET_HAS_nor(type);
     case INDEX_op_not:
@@ -2242,8 +2248,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sub2:
         return has_type && TCG_TARGET_HAS_sub2(type);
 
-    case INDEX_op_negsetcond_i32:
-        return TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32);
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
         return TCG_TARGET_HAS_rot(TCG_TYPE_I32);
@@ -2259,13 +2263,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_ctpop_i32:
         return TCG_TARGET_HAS_ctpop(TCG_TYPE_I32);
 
-    case INDEX_op_brcond2_i32:
-    case INDEX_op_setcond2_i32:
-        return TCG_TARGET_REG_BITS == 32;
-
-    case INDEX_op_setcond_i64:
-    case INDEX_op_brcond_i64:
-    case INDEX_op_movcond_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_st_i64:
     case INDEX_op_shl_i64:
@@ -2280,8 +2277,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
-    case INDEX_op_negsetcond_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_negsetcond(TCG_TYPE_I64);
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rot(TCG_TYPE_I64);
@@ -2799,16 +2794,12 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                                                   op->args[k++]));
             }
             switch (c) {
-            case INDEX_op_brcond_i32:
-            case INDEX_op_setcond_i32:
-            case INDEX_op_negsetcond_i32:
-            case INDEX_op_movcond_i32:
+            case INDEX_op_brcond:
+            case INDEX_op_setcond:
+            case INDEX_op_negsetcond:
+            case INDEX_op_movcond:
             case INDEX_op_brcond2_i32:
             case INDEX_op_setcond2_i32:
-            case INDEX_op_brcond_i64:
-            case INDEX_op_setcond_i64:
-            case INDEX_op_negsetcond_i64:
-            case INDEX_op_movcond_i64:
             case INDEX_op_cmp_vec:
             case INDEX_op_cmpsel_vec:
                 if (op->args[k] < ARRAY_SIZE(cond_name)
@@ -2917,8 +2908,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             switch (c) {
             case INDEX_op_set_label:
             case INDEX_op_br:
-            case INDEX_op_brcond_i32:
-            case INDEX_op_brcond_i64:
+            case INDEX_op_brcond:
             case INDEX_op_brcond2_i32:
                 col += ne_fprintf(f, "%s$L%d", k ? "," : "",
                                   arg_label(op->args[k])->id);
@@ -3359,8 +3349,7 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     case INDEX_op_br:
         remove_label_use(op, 0);
         break;
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         remove_label_use(op, 3);
         break;
     case INDEX_op_brcond2_i32:
@@ -3458,8 +3447,7 @@ static void move_label_uses(TCGLabel *to, TCGLabel *from)
         case INDEX_op_br:
             op->args[0] = label_arg(to);
             break;
-        case INDEX_op_brcond_i32:
-        case INDEX_op_brcond_i64:
+        case INDEX_op_brcond:
             op->args[3] = label_arg(to);
             break;
         case INDEX_op_brcond2_i32:
@@ -5008,22 +4996,18 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     o_allocated_regs = s->reserved_regs;
 
     switch (op->opc) {
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         op_cond = op->args[2];
         break;
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
     case INDEX_op_cmp_vec:
         op_cond = op->args[3];
         break;
     case INDEX_op_brcond2_i32:
         op_cond = op->args[4];
         break;
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
     case INDEX_op_setcond2_i32:
     case INDEX_op_cmpsel_vec:
         op_cond = op->args[5];
diff --git a/tcg/tci.c b/tcg/tci.c
index 6fcd3c9643..7164072b1b 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -446,11 +446,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_l(insn, tb_ptr, &ptr);
             tb_ptr = ptr;
             continue;
-        case INDEX_op_setcond_i32:
+        case INDEX_op_tci_setcond32:
             tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
             regs[r0] = tci_compare32(regs[r1], regs[r2], condition);
             break;
-        case INDEX_op_movcond_i32:
+        case INDEX_op_tci_movcond32:
             tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
             tmp32 = tci_compare32(regs[r1], regs[r2], condition);
             regs[r0] = regs[tmp32 ? r3 : r4];
@@ -463,11 +463,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = tci_compare64(T1, T2, condition);
             break;
 #elif TCG_TARGET_REG_BITS == 64
-        case INDEX_op_setcond_i64:
+        case INDEX_op_setcond:
             tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
             regs[r0] = tci_compare64(regs[r1], regs[r2], condition);
             break;
-        case INDEX_op_movcond_i64:
+        case INDEX_op_movcond:
             tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
             tmp32 = tci_compare64(regs[r1], regs[r2], condition);
             regs[r0] = regs[tmp32 ? r3 : r4];
@@ -646,9 +646,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = sextract32(regs[r1], pos, len);
             break;
-        case INDEX_op_brcond_i32:
+        case INDEX_op_brcond:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
-            if ((uint32_t)regs[r0]) {
+            if (regs[r0]) {
                 tb_ptr = ptr;
             }
             break;
@@ -780,12 +780,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = sextract64(regs[r1], pos, len);
             break;
-        case INDEX_op_brcond_i64:
-            tci_args_rl(insn, tb_ptr, &r0, &ptr);
-            if (regs[r0]) {
-                tb_ptr = ptr;
-            }
-            break;
         case INDEX_op_ext_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int32_t)regs[r1];
@@ -1004,15 +998,14 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         info->fprintf_func(info->stream, "%-12s  %d, %p", op_name, len, ptr);
         break;
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         tci_args_rl(insn, tb_ptr, &r0, &ptr);
         info->fprintf_func(info->stream, "%-12s  %s, 0, ne, %p",
                            op_name, str_r(r0), ptr);
         break;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
+    case INDEX_op_tci_setcond32:
+    case INDEX_op_setcond:
         tci_args_rrrc(insn, &r0, &r1, &r2, &c);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
                            op_name, str_r(r0), str_r(r1), str_r(r2), str_c(c));
@@ -1113,8 +1106,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), pos, len);
         break;
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_tci_movcond32:
+    case INDEX_op_movcond:
     case INDEX_op_setcond2_i32:
         tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &c);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index dfe8c13c24..afb7bce479 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2346,37 +2346,25 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_cltz(s, ext, a0, a1, a2, c2, true);
         break;
 
-    case INDEX_op_brcond_i32:
-        a1 = (int32_t)a1;
-        /* FALLTHRU */
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         tcg_out_brcond(s, ext, a2, a0, a1, const_args[1], arg_label(args[3]));
         break;
 
-    case INDEX_op_setcond_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_setcond_i64:
+    case INDEX_op_setcond:
         tcg_out_cmp(s, ext, args[3], a1, a2, c2);
         /* Use CSET alias of CSINC Wd, WZR, WZR, invert(cond).  */
         tcg_out_insn(s, 3506, CSINC, TCG_TYPE_I32, a0, TCG_REG_XZR,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
         break;
 
-    case INDEX_op_negsetcond_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_negsetcond:
         tcg_out_cmp(s, ext, args[3], a1, a2, c2);
         /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
         tcg_out_insn(s, 3506, CSINV, ext, a0, TCG_REG_XZR,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
         break;
 
-    case INDEX_op_movcond_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         tcg_out_cmp(s, ext, args[5], a1, a2, c2);
         tcg_out_insn(s, 3506, CSEL, ext, a0, REG0(3), REG0(4), args[5]);
         break;
@@ -2960,10 +2948,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sub:
         return C_O1_I2(r, r, rA);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
         return C_O1_I2(r, r, rC);
 
     case INDEX_op_mul:
@@ -3001,12 +2987,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctz_i64:
         return C_O1_I2(r, r, rAL);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         return C_O0_I2(r, rC);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         return C_O1_I4(r, r, rC, rZ, rZ);
 
     case INDEX_op_qemu_ld_a32_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index d506880e52..faebedcd75 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1900,7 +1900,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond:
         /* Constraints mean that v2 is always in the same register as dest,
          * so we only need to do "if condition passed, move v1 to dest".
          */
@@ -2054,18 +2054,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond:
         c = tcg_out_cmp(s, args[2], args[0], args[1], const_args[1]);
         tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[3]));
         break;
-    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond:
         c = tcg_out_cmp(s, args[3], args[1], args[2], const_args[2]);
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c],
                         ARITH_MOV, args[0], 0, 1);
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
                         ARITH_MOV, args[0], 0, 0);
         break;
-    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond:
         c = tcg_out_cmp(s, args[3], args[1], args[2], const_args[2]);
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c],
                         ARITH_MVN, args[0], 0, 0);
@@ -2195,8 +2195,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_add:
     case INDEX_op_sub:
-    case INDEX_op_setcond_i32:
-    case INDEX_op_negsetcond_i32:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
         return C_O1_I2(r, r, rIN);
 
     case INDEX_op_and:
@@ -2225,13 +2225,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotr_i32:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond:
         return C_O0_I2(r, rIN);
     case INDEX_op_deposit_i32:
         return C_O1_I2(r, 0, rZ);
     case INDEX_op_extract2_i32:
         return C_O1_I2(r, rZ, rZ);
-    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond:
         return C_O1_I4(r, r, rIN, rIK, 0);
     case INDEX_op_add2:
         return C_O2_I4(r, r, r, r, rIN, rIK);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index fa8590a3b3..e49089450a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2859,17 +2859,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_modrm(s, OPC_POPCNT + rexw, a0, a1);
         break;
 
-    OP_32_64(brcond):
+    case INDEX_op_brcond:
         tcg_out_brcond(s, rexw, a2, a0, a1, const_args[1],
                        arg_label(args[3]), 0);
         break;
-    OP_32_64(setcond):
+    case INDEX_op_setcond:
         tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2, false);
         break;
-    OP_32_64(negsetcond):
+    case INDEX_op_negsetcond:
         tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2, true);
         break;
-    OP_32_64(movcond):
+    case INDEX_op_movcond:
         tcg_out_movcond(s, rexw, args[5], a0, a1, a2, const_a2, args[3]);
         break;
 
@@ -3721,8 +3721,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, 0, ci);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         return C_O0_I2(r, reT);
 
     case INDEX_op_bswap16_i32:
@@ -3754,14 +3753,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_deposit_i64:
         return C_O1_I2(q, 0, qi);
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
         return C_O1_I2(q, r, reT);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         return C_O1_I4(r, r, reT, r, 0);
 
     case INDEX_op_div2:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c0e1ce8090..4016a448a3 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1303,8 +1303,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_b(s, 0);
         break;
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
         break;
 
@@ -1613,13 +1612,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
+    case INDEX_op_setcond:
         tcg_out_setcond(s, args[3], a0, a1, a2, c2);
         break;
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         tcg_out_movcond(s, args[5], a0, a1, a2, c2, args[3], args[4]);
         break;
 
@@ -2230,8 +2227,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_qemu_st_a64_i128:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         return C_O0_I2(rZ, rZ);
 
     case INDEX_op_extu_i32_i64:
@@ -2305,10 +2301,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         /* Must deposit into the same register as input */
         return C_O1_I2(r, 0, rZ);
 
-    case INDEX_op_setcond_i32:
-        return C_O1_I2(r, rZ, ri);
-    case INDEX_op_setcond_i64:
-        return C_O1_I2(r, rZ, rJ);
+    case INDEX_op_setcond:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, rZ, ri)
+                : C_O1_I2(r, rZ, rJ));
 
     case INDEX_op_mul:
     case INDEX_op_mulsh:
@@ -2319,8 +2315,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_remu:
         return C_O1_I2(r, rZ, rZ);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         return C_O1_I4(r, rZ, rJ, rZ, rZ);
 
     case INDEX_op_ld_vec:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ac70a793f7..85414bb96b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2057,21 +2057,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
         break;
     case INDEX_op_brcond2_i32:
         tcg_out_brcond2(s, args[4], a0, a1, a2, args[3], arg_label(args[5]));
         break;
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         tcg_out_movcond(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
+    case INDEX_op_setcond:
         tcg_out_setcond(s, args[3], a0, a1, a2);
         break;
     case INDEX_op_setcond2_i32:
@@ -2193,8 +2190,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rem:
     case INDEX_op_remu:
     case INDEX_op_nor:
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
+    case INDEX_op_setcond:
         return C_O1_I2(r, rZ, rZ);
     case INDEX_op_muls2:
     case INDEX_op_mulu2:
@@ -2222,11 +2218,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rZ);
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         return C_O0_I2(rZ, rZ);
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         return (use_mips32r6_instructions
                 ? C_O1_I4(r, rZ, rZ, rZ, rZ)
                 : C_O1_I4(r, rZ, rZ, rZ, 0));
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 68f84342d8..421c0f89da 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3208,13 +3208,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond:
         tcg_out_brcond(s, args[2], args[0], args[1], const_args[1],
-                       arg_label(args[3]), TCG_TYPE_I32);
-        break;
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond(s, args[2], args[0], args[1], const_args[1],
-                       arg_label(args[3]), TCG_TYPE_I64);
+                       arg_label(args[3]), type);
         break;
     case INDEX_op_brcond2_i32:
         tcg_out_brcond2(s, args, const_args);
@@ -3338,20 +3334,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_setcond_i32:
-        tcg_out_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1], args[2],
+    case INDEX_op_setcond:
+        tcg_out_setcond(s, type, args[3], args[0], args[1], args[2],
                         const_args[2], false);
         break;
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1], args[2],
-                        const_args[2], false);
-        break;
-    case INDEX_op_negsetcond_i32:
-        tcg_out_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1], args[2],
-                        const_args[2], true);
-        break;
-    case INDEX_op_negsetcond_i64:
-        tcg_out_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1], args[2],
+    case INDEX_op_negsetcond:
+        tcg_out_setcond(s, type, args[3], args[0], args[1], args[2],
                         const_args[2], true);
         break;
     case INDEX_op_setcond2_i32:
@@ -3427,12 +3415,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_movcond_i32:
-        tcg_out_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1], args[2],
-                        args[3], args[4], const_args[2]);
-        break;
-    case INDEX_op_movcond_i64:
-        tcg_out_movcond(s, TCG_TYPE_I64, args[5], args[0], args[1], args[2],
+    case INDEX_op_movcond:
+        tcg_out_movcond(s, type, args[5], args[0], args[1], args[2],
                         args[3], args[4], const_args[2]);
         break;
 
@@ -4196,16 +4180,12 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctz_i64:
         return C_O1_I2(r, r, rZW);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         return C_O0_I2(r, rC);
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
         return C_O1_I2(r, r, rC);
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         return C_O1_I4(r, r, rC, rZ, rZ);
 
     case INDEX_op_deposit_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 4cbe1a1736..e9a874e424 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2277,23 +2277,19 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                         type == TCG_TYPE_I32);
         break;
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
         break;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
+    case INDEX_op_setcond:
         tcg_out_setcond(s, args[3], a0, a1, a2, c2);
         break;
 
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_negsetcond:
         tcg_out_negsetcond(s, args[3], a0, a1, a2, c2);
         break;
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         tcg_out_movcond(s, args[5], a0, a1, a2, c2,
                         args[3], const_args[3], args[4], const_args[4]);
         break;
@@ -2633,10 +2629,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_or:
     case INDEX_op_xor:
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
         return C_O1_I2(r, r, rI);
 
     case INDEX_op_andc:
@@ -2674,12 +2668,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctz_i64:
         return C_N1_I2(r, r, rM);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         return C_O0_I2(rZ, rZ);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         return C_O1_I4(r, r, rI, rM, rM);
 
     case INDEX_op_add2:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 519d7c082c..054e036168 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2567,20 +2567,20 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tgen_branch(s, S390_CC_ALWAYS, arg_label(args[0]));
         break;
 
-    case INDEX_op_brcond_i32:
-        tgen_brcond(s, TCG_TYPE_I32, args[2], args[0],
+    case INDEX_op_brcond:
+        tgen_brcond(s, type, args[2], args[0],
                     args[1], const_args[1], arg_label(args[3]));
         break;
-    case INDEX_op_setcond_i32:
-        tgen_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1],
+    case INDEX_op_setcond:
+        tgen_setcond(s, type, args[3], args[0], args[1],
                      args[2], const_args[2], false);
         break;
-    case INDEX_op_negsetcond_i32:
-        tgen_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1],
+    case INDEX_op_negsetcond:
+        tgen_setcond(s, type, args[3], args[0], args[1],
                      args[2], const_args[2], true);
         break;
-    case INDEX_op_movcond_i32:
-        tgen_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1],
+    case INDEX_op_movcond:
+        tgen_movcond(s, type, args[5], args[0], args[1],
                      args[2], const_args[2], args[3], const_args[3], args[4]);
         break;
 
@@ -2664,23 +2664,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_brcond_i64:
-        tgen_brcond(s, TCG_TYPE_I64, args[2], args[0],
-                    args[1], const_args[1], arg_label(args[3]));
-        break;
-    case INDEX_op_setcond_i64:
-        tgen_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1],
-                     args[2], const_args[2], false);
-        break;
-    case INDEX_op_negsetcond_i64:
-        tgen_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1],
-                     args[2], const_args[2], true);
-        break;
-    case INDEX_op_movcond_i64:
-        tgen_movcond(s, TCG_TYPE_I64, args[5], args[0], args[1],
-                     args[2], const_args[2], args[3], const_args[3], args[4]);
-        break;
-
     OP_32_64(deposit):
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[1]) {
@@ -3198,10 +3181,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotr_i32:
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_setcond_i32:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
         return C_O1_I2(r, r, rC);
 
     case INDEX_op_clz_i64:
@@ -3243,10 +3224,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sar_i32:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_brcond_i32:
-        return C_O0_I2(r, ri);
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rC);
+    case INDEX_op_brcond:
+        return (op->type == TCG_TYPE_I32
+                ? C_O0_I2(r, ri)
+                : C_O0_I2(r, rC));
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -3288,10 +3269,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, rZ, r);
 
-    case INDEX_op_movcond_i32:
-        return C_O1_I4(r, r, ri, rI, r);
-    case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rC, rI, r);
+    case INDEX_op_movcond:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I4(r, r, ri, rI, r)
+                : C_O1_I4(r, r, rC, rI, r));
 
     case INDEX_op_div2:
     case INDEX_op_divu2:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 0ee5fc3235..2e322eed87 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1421,17 +1421,33 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = ARITH_UDIVX;
         goto gen_arith;
 
-    case INDEX_op_brcond_i32:
-        tcg_out_brcond_i32(s, a2, a0, a1, const_args[1], arg_label(args[3]));
+    case INDEX_op_brcond:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_brcond_i32(s, a2, a0, a1, const_args[1], arg_label(args[3]));
+        } else {
+            tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
+        }
         break;
-    case INDEX_op_setcond_i32:
-        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, false);
+    case INDEX_op_setcond:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, false);
+        } else {
+            tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, false);
+        }
         break;
-    case INDEX_op_negsetcond_i32:
-        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, true);
+    case INDEX_op_negsetcond:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, true);
+        } else {
+            tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, true);
+        }
         break;
-    case INDEX_op_movcond_i32:
-        tcg_out_movcond_i32(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
+    case INDEX_op_movcond:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_movcond_i32(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
+        } else {
+            tcg_out_movcond_i64(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
+        }
         break;
 
     case INDEX_op_add2:
@@ -1500,18 +1516,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = SHIFT_SRAX;
         goto do_shift64;
 
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
-        break;
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, false);
-        break;
-    case INDEX_op_negsetcond_i64:
-        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, true);
-        break;
-    case INDEX_op_movcond_i64:
-        tcg_out_movcond_i64(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
-        break;
     case INDEX_op_muluh:
         tcg_out_arith(s, args[0], args[1], args[2], ARITH_UMULXHI);
         break;
@@ -1598,17 +1602,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
     case INDEX_op_sar_i64:
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
         return C_O1_I2(r, rZ, rJ);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         return C_O0_I2(rZ, rJ);
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         return C_O1_I4(r, rZ, rJ, rI, 0);
     case INDEX_op_add2:
     case INDEX_op_sub2:
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 2e19c8252b..8544654db8 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -9,3 +9,5 @@ DEF(tci_ld16s, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_ld32s, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_st8, 1, 1, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_st16, 1, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movcond32, 1, 4, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ea12768a8f..e85cbba0bb 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -92,8 +92,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i32:
     case INDEX_op_rotr_i64:
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
+    case INDEX_op_setcond:
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
     case INDEX_op_clz_i32:
@@ -102,8 +101,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctz_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         return C_O0_I2(r, r);
 
     case INDEX_op_add2:
@@ -119,8 +117,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_muls2:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, r, r);
 
@@ -643,16 +640,39 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_l(s, opc, arg_label(args[0]));
         break;
 
-    CASE_32_64(setcond)
+    case INDEX_op_setcond:
+        if (type == TCG_TYPE_I32) {
+            opc = INDEX_op_tci_setcond32;
+        }
         tcg_out_op_rrrc(s, opc, args[0], args[1], args[2], args[3]);
         break;
-
-    CASE_32_64(movcond)
     case INDEX_op_setcond2_i32:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
         tcg_out_op_rrrrrc(s, opc, args[0], args[1], args[2],
                           args[3], args[4], args[5]);
         break;
 
+    case INDEX_op_movcond:
+        if (type == TCG_TYPE_I32) {
+            opc = INDEX_op_tci_movcond32;
+        }
+        tcg_out_op_rrrrrc(s, opc, args[0], args[1], args[2],
+                          args[3], args[4], args[5]);
+        break;
+
+    case INDEX_op_brcond:
+        tcg_out_op_rrrc(s, (type == TCG_TYPE_I32
+                            ? INDEX_op_tci_setcond32 : INDEX_op_setcond),
+                        TCG_REG_TMP, args[0], args[1], args[2]);
+        tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
+        break;
+    case INDEX_op_brcond2_i32:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+        tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
+                          args[0], args[1], args[2], args[3], args[4]);
+        tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, arg_label(args[5]));
+        break;
+
     CASE_32_64(ld)
         switch (args[3]) {
         case MO_UB:
@@ -739,13 +759,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rrbb(s, INDEX_op_extract_i64, args[0], args[1], 32, 32);
         break;
 
-    CASE_32_64(brcond)
-        tcg_out_op_rrrc(s, (opc == INDEX_op_brcond_i32
-                            ? INDEX_op_setcond_i32 : INDEX_op_setcond_i64),
-                        TCG_REG_TMP, args[0], args[1], args[2]);
-        tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
-        break;
-
     case INDEX_op_neg:
     case INDEX_op_not:
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
@@ -776,14 +789,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                           args[3], args[4], args[5]);
         break;
 
-#if TCG_TARGET_REG_BITS == 32
-    case INDEX_op_brcond2_i32:
-        tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
-                          args[0], args[1], args[2], args[3], args[4]);
-        tcg_out_op_rl(s, INDEX_op_brcond_i32, TCG_REG_TMP, arg_label(args[5]));
-        break;
-#endif
-
     case INDEX_op_mulu2:
     case INDEX_op_muls2:
         tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], args[3]);
-- 
2.43.0


