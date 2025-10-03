Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22C6CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jLq-0007rd-6X; Fri, 03 Oct 2025 13:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKn-00064P-PO
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJw-0007lQ-Oh
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7811a5ec5b6so2834581b3a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511509; x=1760116309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EYwOjZZKwwI0dHfaQoLb4hH7oDROqsQz/u2HnYnk8o=;
 b=FFWxsCs+YTMAhypVWeXAOP84vQdhdUGOOcxGMZ0aB96+idjo4KBoH7J7N3Ki4yAy7l
 X1jTUFzvEau4aj4W1/+47yRmsTSRMbzYKEwRTicmspBYUBNB8fgYzm04MS+Nt9thURgE
 AC/rWTAjajOOu6iyr073MyyUU9EwnnHY/UayZJPCJTG9opUfZY1jF9DnLsjgLQ37TfwH
 /047Jm5DHI61WXtUKgVzWQXyZo37OOly1W9YkYztmrDAM1wNLViimoEi1xDcQlh0Gi97
 ZkfAJ75YXcS3CxkWnNfALSxJnTmfWosng5lLz2dlJmcncnOpTFCYP79HlhpWEM6Z4UiT
 RDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511509; x=1760116309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EYwOjZZKwwI0dHfaQoLb4hH7oDROqsQz/u2HnYnk8o=;
 b=cxiIz4ZGYeZ58tpxn9S+sIgsKcyNEKYcCAseUwyYXyErVDvr/1v00y3j0laH8TaCJD
 hJi6IGRViYwbSalYM2c6GaNxMRELvEMgCAFquw9FOizLZJDynnE4pDjWSxIldgfDrtXO
 vT91N14c+lE4OLD6wUifsdNBUyF0N6sGPUKU6b+vYyn9nEZl/u4IbckhFTuhz68B0J9T
 Q6NVBAtvmxMmppiwMb8N8g4b1V/PzoXM+wAUd9pG8tp3bdkQ9QSMydrqqNSeGdGhmdcC
 rkus8pzObcFJ0XvF7PCm88Ek7nU/pSD7BsPXOIRnP8SAFEtXwNzBZJ1i+dvXO7ij2xrx
 Wlgg==
X-Gm-Message-State: AOJu0YwtESX3v6Ml8/ZGrvVUAV119//X645YyMtiydO8hTHHgpxZypU+
 AxPv9OZ+nSeIUpaxs2d+ql15tUNy9ED7jxediZKqCikPoIzIU2PKLVty8I9PmgDITJNWuzT51lT
 j1XuxEsk=
X-Gm-Gg: ASbGncuOY9lfatM13jtWiTmPXSRkOURhbaeJepiB1+V50SFVx404ZM9OpcB/lMWkcvM
 4dBAmUocJ4q0O/MAL/OZBMAHrIjym9ajUF45G4xW/ljH2HSD+QFJ6Gp0Yc3Wqs5pdba5hs90TXu
 ffAxIECPqAQ2ewcNI1ELoj9PLUmr5kKSKGCjHwOEoXT8z+hyLaYsJ0hjMcvP3jHEHEocsqjtpTr
 qfXA+JFU65xN/3SVaHh6hJT1ArwYQ1aPlYGDe1kABLbocXSo4ajxpCe+PfIKvBH2nm4ZIUHQWyr
 1iNzBqa0cOGOT9SnzxtWRF7h2TYgcZ4i7Lx1uWfGd+yMaZfEcD4981g7hSnS7bbw2wkR+yC3Gmj
 h/SeuVcOjwkEgBvxXQn9aZNScs7H+g67YRe8tKI6xGWX4cXxUtgtdxxS3
X-Google-Smtp-Source: AGHT+IFtHFgpI7a/MAsPyvZvXZjhE5PkdeVoYH+XYa0RwpkqQvF31sUTQcW/d+faGpXdwu+6DdWTtw==
X-Received: by 2002:a05:6a20:914a:b0:246:3a6:3e47 with SMTP id
 adf61e73a8af0-32b61b4fd50mr5165303637.12.1759511509088; 
 Fri, 03 Oct 2025 10:11:49 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 52/73] target/arm: Implement GCSPOPCX
Date: Fri,  3 Oct 2025 10:07:39 -0700
Message-ID: <20251003170800.997167-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        | 17 +++++++++++
 target/arm/tcg/translate-a64.c | 56 ++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index ccf45fd136..6d9145109f 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -52,6 +52,7 @@ enum {
     ARM_CP_GCSPOPM               = 0x0009,
     ARM_CP_GCSPUSHX              = 0x000a,
     ARM_CP_GCSPOPX               = 0x000b,
+    ARM_CP_GCSPOPCX              = 0x000c,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 5b5b895a09..3795bf7f36 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -66,6 +66,19 @@ static CPAccessResult access_gcspushx(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_gcspopcx(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    /* Trap if lock not taken, and enabled. */
+    if (env->pstate & PSTATE_EXLOCK) {
+        int el = arm_current_el(env);
+        if (env->cp15.gcscr_el[el] & GCSCR_EXLOCKEN) {
+            return CP_ACCESS_EXLOCK;
+        }
+    }
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSCRE0_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 2,
@@ -120,6 +133,10 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
       .type = ARM_CP_GCSPUSHX },
+    { .name = "GCSPOPCX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 5,
+      .access = PL1_W, .accessfn = access_gcspopcx, .fgt = FGT_NGCSEPP,
+      .type = ARM_CP_GCSPOPCX },
     { .name = "GCSPOPX", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 6,
       .access = PL1_W, .type = ARM_CP_GCSPOPX },
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 08f9b214e2..d87133a3bc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2568,6 +2568,54 @@ static void gen_gcspushx(DisasContext *s)
     clear_pstate_bits(PSTATE_EXLOCK);
 }
 
+static void gen_gcspopcx(DisasContext *s)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int spsr_idx = aarch64_banked_spsr_index(s->current_el);
+    int spsr_off = offsetof(CPUARMState, banked_spsr[spsr_idx]);
+    int elr_off = offsetof(CPUARMState, elr_el[s->current_el]);
+    int gcscr_off = offsetof(CPUARMState, cp15.gcscr_el[s->current_el]);
+    int pstate_off = offsetof(CPUARMState, pstate);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp1 = tcg_temp_new_i64();
+    TCGv_i64 tmp2 = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPCX, 31));
+
+    /* The value at top-of-stack must be an exception token. */
+    tcg_gen_qemu_ld_i64(tmp1, gcspr, mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp1, 0b1001, fail_label);
+
+    /* Validate in turn, ELR ... */
+    tcg_gen_addi_i64(addr, gcspr, 8);
+    tcg_gen_qemu_ld_i64(tmp1, addr, mmuidx, mop);
+    tcg_gen_ld_i64(tmp2, tcg_env, elr_off);
+    tcg_gen_brcond_i64(TCG_COND_NE, tmp1, tmp2, fail_label);
+
+    /* ... SPSR ... */
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp1, addr, mmuidx, mop);
+    tcg_gen_ld_i64(tmp2, tcg_env, spsr_off);
+    tcg_gen_brcond_i64(TCG_COND_NE, tmp1, tmp2, fail_label);
+
+    /* ... and LR. */
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp1, addr, mmuidx, mop);
+    tcg_gen_brcond_i64(TCG_COND_NE, tmp1, cpu_reg(s, 30), fail_label);
+
+    /* Writeback stack pointer after pop. */
+    tcg_gen_addi_i64(gcspr, addr, 8);
+
+    /* PSTATE.EXLOCK = GetCurrentEXLOCKEN(). */
+    tcg_gen_ld_i64(tmp1, tcg_env, gcscr_off);
+    tcg_gen_ld_i64(tmp2, tcg_env, pstate_off);
+    tcg_gen_shri_i64(tmp1, tmp1, ctz64(GCSCR_EXLOCKEN));
+    tcg_gen_deposit_i64(tmp2, tmp2, tmp1, ctz64(PSTATE_EXLOCK), 1);
+    tcg_gen_st_i64(tmp2, tcg_env, pstate_off);
+}
+
 static void gen_gcspopx(DisasContext *s)
 {
     TCGv_i64 gcspr = cpu_gcspr[s->current_el];
@@ -2920,6 +2968,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspushx(s);
         }
         return;
+    case ARM_CP_GCSPOPCX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspopcx(s);
+        }
+        return;
     case ARM_CP_GCSPOPX:
         /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
         if (rt != 31) {
-- 
2.43.0


