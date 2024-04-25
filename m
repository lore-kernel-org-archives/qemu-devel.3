Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CFBC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYI-0008QK-8p; Wed, 24 Apr 2024 20:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXo-0008GD-Ju
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:57 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXk-0006Gr-2H
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e4f341330fso4000355ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003250; x=1714608050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CtiaqvwuVu2PCvk8ws+dlqlBGpei7mPxycYtflKdoaA=;
 b=vjDc9dgYkt9Syyp8O9u7Xc8u6Fi4OPPp98TicdCcVNL+Prw2O5WzGdyD8/v5iznX2h
 CAezVcRTS/fOewYOeX/ZnWXGr9/T6BKxyYzMKrA0P/IdsaUjxGARynPz+0DffhilGMiW
 kIRQ6c7JdxCb+aLv7nC1BVgamaSum7soIqi6Wkkq2N/pXDA4XIRXKR6cqSBENVCmVaf0
 iYfAo0jww2wfjlEEwVHCuDZPapc8FmbbgvScaBnQxB6cHTfs66w2mHSgAscZRaScKcpr
 vXh1Nwup6XanU2BqL8WRAPHr/LD7wM9sJ87aOCcSuGs2gOwLkCB1tgUL0c5KLS7B0j/K
 aOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003250; x=1714608050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CtiaqvwuVu2PCvk8ws+dlqlBGpei7mPxycYtflKdoaA=;
 b=X9OXepqq/S0ruPS2z4tK5g03PcZLxWmdmU/xvv6vEmiQlY9bzq+zV2bA6pCXnadxGN
 xwaTDdwpuWLKbGQFkZnJP+xaP5izHPWXXBsqsNN8oFeBNR3Kx/pXSUbIbgCMaLgO7X2Z
 6jp18HllI3hkCHJeWmo9L/prAi/4lmhMV3Q3BWDH9/XX00Cv6r7C3otZb4Ih91E4zayJ
 4tzIfyffDcWSB8xDGpk06xFwwXUQ3wcHo1w0CA1MmSem++EnCAEwoEibljABNWfTuLG6
 f7Xy1lu6owiSYjrUkrjXXWpWYRWLDOT5uHoVGwXW/YlyoHw6+G2dptAhqxpg1rZ74EPX
 0rGA==
X-Gm-Message-State: AOJu0YwKp4Q356B54DBz+qNrddqSh3mYjfkoSWKacfI0RdWDRq2zOUWL
 6C87Z87n4GOzwjKBSulqjlFR2f8cqoqPJnxMpgSBFE36YlKTP0RgiVX9yijR45LJvosF34js8A1
 G
X-Google-Smtp-Source: AGHT+IHMGRcqFyXWAVOIeUuQXwJ4FAb4WWkb3W/Vi9DC8iCu+Duj1kWdljUXQ1A4ACcqWYYnAjBshg==
X-Received: by 2002:a17:902:ba93:b0:1e4:7adf:b85d with SMTP id
 k19-20020a170902ba9300b001e47adfb85dmr3604361pls.17.1714003249957; 
 Wed, 24 Apr 2024 17:00:49 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/45] target/hppa: Use registerfields.h for FPSR
Date: Wed, 24 Apr 2024 17:00:03 -0700
Message-Id: <20240425000023.1002026-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Define all of the context dependent field definitions.
Use FIELD_EX32 and FIELD_DP32 with named fields instead
of extract32 and deposit32 with raw constants.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        | 25 +++++++++++++++++++++++++
 target/hppa/fpu_helper.c | 26 +++++++++++++-------------
 target/hppa/translate.c  | 18 ++++++++----------
 3 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 01dc8781a5..c0da9e9af6 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -24,6 +24,7 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "qemu/interval-tree.h"
+#include "hw/registerfields.h"
 
 /* PA-RISC 1.x processors have a strong memory model.  */
 /* ??? While we do not yet implement PA-RISC 2.0, those processors have
@@ -158,6 +159,30 @@
 #define CR_IPSW          22
 #define CR_EIRR          23
 
+FIELD(FPSR, ENA_I, 0, 1)
+FIELD(FPSR, ENA_U, 1, 1)
+FIELD(FPSR, ENA_O, 2, 1)
+FIELD(FPSR, ENA_Z, 3, 1)
+FIELD(FPSR, ENA_V, 4, 1)
+FIELD(FPSR, ENABLES, 0, 5)
+FIELD(FPSR, D, 5, 1)
+FIELD(FPSR, T, 6, 1)
+FIELD(FPSR, RM, 9, 2)
+FIELD(FPSR, CQ, 11, 11)
+FIELD(FPSR, CQ0_6, 15, 7)
+FIELD(FPSR, CQ0_4, 17, 5)
+FIELD(FPSR, CQ0_2, 19, 3)
+FIELD(FPSR, CQ0, 21, 1)
+FIELD(FPSR, CA, 15, 7)
+FIELD(FPSR, CA0, 21, 1)
+FIELD(FPSR, C, 26, 1)
+FIELD(FPSR, FLG_I, 27, 1)
+FIELD(FPSR, FLG_U, 28, 1)
+FIELD(FPSR, FLG_O, 29, 1)
+FIELD(FPSR, FLG_Z, 30, 1)
+FIELD(FPSR, FLG_V, 31, 1)
+FIELD(FPSR, FLAGS, 27, 5)
+
 typedef struct HPPATLBEntry {
     union {
         IntervalTreeNode itree;
diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 576f283b04..deaed2b65d 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -30,7 +30,7 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
 
     env->fr0_shadow = shadow;
 
-    switch (extract32(shadow, 9, 2)) {
+    switch (FIELD_EX32(shadow, FPSR, RM)) {
     default:
         rm = float_round_nearest_even;
         break;
@@ -46,7 +46,7 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
     }
     set_float_rounding_mode(rm, &env->fp_status);
 
-    d = extract32(shadow, 5, 1);
+    d = FIELD_EX32(shadow, FPSR, D);
     set_flush_to_zero(d, &env->fp_status);
     set_flush_inputs_to_zero(d, &env->fp_status);
 }
@@ -57,7 +57,7 @@ void cpu_hppa_loaded_fr0(CPUHPPAState *env)
 }
 
 #define CONVERT_BIT(X, SRC, DST)        \
-    ((SRC) > (DST)                      \
+    ((unsigned)(SRC) > (unsigned)(DST)  \
      ? (X) / ((SRC) / (DST)) & (DST)    \
      : ((X) & (SRC)) * ((DST) / (SRC)))
 
@@ -73,12 +73,12 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
     }
     set_float_exception_flags(0, &env->fp_status);
 
-    hard_exp |= CONVERT_BIT(soft_exp, float_flag_inexact,   1u << 0);
-    hard_exp |= CONVERT_BIT(soft_exp, float_flag_underflow, 1u << 1);
-    hard_exp |= CONVERT_BIT(soft_exp, float_flag_overflow,  1u << 2);
-    hard_exp |= CONVERT_BIT(soft_exp, float_flag_divbyzero, 1u << 3);
-    hard_exp |= CONVERT_BIT(soft_exp, float_flag_invalid,   1u << 4);
-    shadow |= hard_exp << (32 - 5);
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_inexact,   R_FPSR_ENA_I_MASK);
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_underflow, R_FPSR_ENA_U_MASK);
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_overflow,  R_FPSR_ENA_O_MASK);
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_divbyzero, R_FPSR_ENA_Z_MASK);
+    hard_exp |= CONVERT_BIT(soft_exp, float_flag_invalid,   R_FPSR_ENA_V_MASK);
+    shadow |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
     env->fr0_shadow = shadow;
     env->fr[0] = (uint64_t)shadow << 32;
 
@@ -378,15 +378,15 @@ static void update_fr0_cmp(CPUHPPAState *env, uint32_t y,
     if (y) {
         /* targeted comparison */
         /* set fpsr[ca[y - 1]] to current compare */
-        shadow = deposit32(shadow, 21 - (y - 1), 1, c);
+        shadow = deposit32(shadow, R_FPSR_CA0_SHIFT - (y - 1), 1, c);
     } else {
         /* queued comparison */
         /* shift cq right by one place */
-        shadow = deposit32(shadow, 11, 10, extract32(shadow, 12, 10));
+        shadow = (shadow & ~R_FPSR_CQ_MASK) | ((shadow >> 1) & R_FPSR_CQ_MASK);
         /* move fpsr[c] to fpsr[cq[0]] */
-        shadow = deposit32(shadow, 21, 1, extract32(shadow, 26, 1));
+        shadow = FIELD_DP32(shadow, FPSR, CQ0, FIELD_EX32(shadow, FPSR, C));
         /* set fpsr[c] to current compare */
-        shadow = deposit32(shadow, 26, 1, c);
+        shadow = FIELD_DP32(shadow, FPSR, C, c);
     }
 
     env->fr0_shadow = shadow;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c996eb9823..4b9092b1cf 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4322,29 +4322,28 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 
         switch (a->c) {
         case 0: /* simple */
-            tcg_gen_andi_i64(t, t, 0x4000000);
-            ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
-            goto done;
+            mask = R_FPSR_C_MASK;
+            break;
         case 2: /* rej */
             inv = true;
             /* fallthru */
         case 1: /* acc */
-            mask = 0x43ff800;
+            mask = R_FPSR_C_MASK | R_FPSR_CQ_MASK;
             break;
         case 6: /* rej8 */
             inv = true;
             /* fallthru */
         case 5: /* acc8 */
-            mask = 0x43f8000;
+            mask = R_FPSR_C_MASK | R_FPSR_CQ0_6_MASK;
             break;
         case 9: /* acc6 */
-            mask = 0x43e0000;
+            mask = R_FPSR_C_MASK | R_FPSR_CQ0_4_MASK;
             break;
         case 13: /* acc4 */
-            mask = 0x4380000;
+            mask = R_FPSR_C_MASK | R_FPSR_CQ0_2_MASK;
             break;
         case 17: /* acc2 */
-            mask = 0x4200000;
+            mask = R_FPSR_C_MASK | R_FPSR_CQ0_MASK;
             break;
         default:
             gen_illegal(ctx);
@@ -4361,11 +4360,10 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
     } else {
         unsigned cbit = (a->y ^ 1) - 1;
 
-        tcg_gen_extract_i64(t, t, 21 - cbit, 1);
+        tcg_gen_extract_i64(t, t, R_FPSR_CA0_SHIFT - cbit, 1);
         ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
     }
 
- done:
     return nullify_end(ctx);
 }
 
-- 
2.34.1


