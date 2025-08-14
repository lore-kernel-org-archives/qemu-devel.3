Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A60CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeC-0003hp-GM; Thu, 14 Aug 2025 09:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXd6-0002SA-13
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXd1-0005DX-An
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so1525288b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176659; x=1755781459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ry0ZsXjHszKipidyoRWNoHHhZAabsET+1FA/mv45g1c=;
 b=PL8v9ZUCMtpYMeclbrcetE3gygjgd2cxLLttp45cdTW/mBYoM+lSrEPOULPDgSXXu8
 dZDCtBcKmCNZoEtJrKingU7vrgXs5SKN6z1gF52t+J08ZItfh73VBXakBWYc4tUxPv0a
 FvObcCLVrbibeYglYmDp3vD3KFRzL6Ff5KDnPpaUEQxGRpmkSMK5C+giiG3jq9Tf18ag
 vQjC7ybwHwGw1E11cqmQ9w1Xqe7WBBPKqZIbB308ylKjUwX6Huaz6wdZdJK33M0Be+6W
 8HyOHlltF2KNHWEuO+IKDIy2a4UsE6U04zN7upOxOlWLJmlEiZQD6QCbWz8EgDmYS9SU
 d8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176659; x=1755781459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ry0ZsXjHszKipidyoRWNoHHhZAabsET+1FA/mv45g1c=;
 b=rLUEdh7DqBpayW5Ak3rTBQHVuhvC3/iayp1DUyhjk2wYuZ6bpVDRxyNZ0VW2Qowtab
 yUsYVlTh9T4Yy/Xxp3Ai4g/mXfsNO4AentQynJFYk0QD7YEkjP8D9aX9S165RU5HmEG1
 q45Qb5u3FiCZ0AXk+NyWn34znpDK44ssgH30cacNKKub9J5f2Ba6UV+pU3AyowM03icL
 i7ft1gkrWhFbeBzgmSzm0O8L7+KxyqvTE4XXO0/QHWVwFYSr8Tl2ouYbWaBudbqyG1Rc
 xKgSQxNTBRefGXN7EuYbDxTaSqPuUfGc/1ht7MNwkaYawdVaicuuFbJBM9ok6Uv6p9Nk
 M1Ig==
X-Gm-Message-State: AOJu0Yz58w0iW8IwgovEApe1fYMMwJxxyyuVrsiTf26OXeOEAr2aYIJz
 oRLr+zTfNtZsjYyPMIMGmAfaGjcJ7e/vNtuPEduV1yi267l3r4VAmSajC1BFpoBv0B0yDVUnLKO
 J47SCs0o=
X-Gm-Gg: ASbGnct6hmDPKUrOaq58us9xmBtgqSzuJyfBr43s7wlhOaiM4D+4Oxg+Rq7jVH4uAjP
 qrqD4ixo8C+ZkrqYVYG5bVR4lwnjRRzFwqlanEqZuspIU3o0Wqh3d3V8nO5LW3pfL3FT0PLf2QD
 SurEI8MgG8/bn08PvoPalXfwLwdsyNZK0/9P+rBwAYlizdpIrNVyn7hOCoKYX9/Wdq7fYWWrthQ
 WAlQKXQAi/m+AaVaklp/D15BrTV/59VlGmsQfff7Dc0MlwTkGYpckNAIgRStzM3mUHCGrluSne0
 QNGqmugklmezd78B9NnT3UYQMleMsbnKRHfpzRBPVzylSb0JiJOhTYiMyGWd7hTfArR+MwAzX7W
 iQP4wsORBrC3IzU5LPV2vwxOfValHqYO9JyrefFaInFILWVo=
X-Google-Smtp-Source: AGHT+IHcUiiGTiysj4DynzgleZ5bTP7cBa2fpAenTIDd1mKdI7UGnsVF2PmBzHEPTB7JGW7tEdHBjQ==
X-Received: by 2002:a05:6a20:914d:b0:240:177:e820 with SMTP id
 adf61e73a8af0-240bdfad251mr4230479637.13.1755176659166; 
 Thu, 14 Aug 2025 06:04:19 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 59/85] target/arm: Implement GCSPUSHM
Date: Thu, 14 Aug 2025 22:57:26 +1000
Message-ID: <20250814125752.164107-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/cpregs.h            |  3 +++
 target/arm/cpregs-gcs.c        | 15 +++++++++++++++
 target/arm/tcg/translate-a64.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 15894332b2..93358e6123 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -46,6 +46,8 @@ enum {
     ARM_CP_DC_ZVA                = 0x0005,
     ARM_CP_DC_GVA                = 0x0006,
     ARM_CP_DC_GZVA               = 0x0007,
+    /* Special: gcs instructions */
+    ARM_CP_GCSPUSHM              = 0x0008,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -861,6 +863,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, DVPRCTX),
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
+    DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 1a64acd584..d17c17dcb7 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -43,6 +43,16 @@ static void gcspr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value & ~7);
 }
 
+static CPAccessResult access_gcspushm(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    int el = arm_current_el(env);
+    if (!(env->cp15.gcscr_el[el] & GCSCR_PUSHMEN)) {
+        return CP_ACCESS_TRAP_BIT | (el ? el : 1);
+    }
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSCRE0_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 2,
@@ -81,6 +91,11 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 1,
       .access = PL3_RW, .writefn = gcspr_write,
       .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
+
+    { .name = "GCSPUSHM", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 0,
+      .access = PL0_W, .accessfn = access_gcspushm,
+      .fgt = FGT_NGCSPUSHM_EL1, .type = ARM_CP_GCSPUSHM },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 45ff7bb0b2..39b91eac6d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -26,6 +26,7 @@
 #include "cpregs.h"
 
 static TCGv_i64 cpu_X[32];
+static TCGv_i64 cpu_gcspr[32];
 static TCGv_i64 cpu_pc;
 
 /* Load/store exclusive handling */
@@ -77,6 +78,10 @@ static int scale_by_log2_tag_granule(DisasContext *s, int x)
 /* initialize TCG globals.  */
 void a64_translate_init(void)
 {
+    static const char gcspr_names[4][12] = {
+        "gcspr_el0", "gcspr_el1", "gcspr_el2", "gcspr_el3"
+    };
+
     int i;
 
     cpu_pc = tcg_global_mem_new_i64(tcg_env,
@@ -90,6 +95,13 @@ void a64_translate_init(void)
 
     cpu_exclusive_high = tcg_global_mem_new_i64(tcg_env,
         offsetof(CPUARMState, exclusive_high), "exclusive_high");
+
+    for (i = 0; i < 4; i++) {
+        cpu_gcspr[i] =
+            tcg_global_mem_new_i64(tcg_env,
+                                   offsetof(CPUARMState, cp15.gcspr_el[i]),
+                                   gcspr_names[i]);
+    }
 }
 
 /*
@@ -420,6 +432,18 @@ static MemOp check_ordered_align(DisasContext *s, int rn, int imm,
     return finalize_memop(s, mop);
 }
 
+static void gen_add_gcs_record(DisasContext *s, TCGv_i64 value)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+
+    tcg_gen_addi_i64(addr, gcspr, -8);
+    tcg_gen_qemu_st_i64(value, clean_data_tbi(s, addr), mmuidx, mop);
+    tcg_gen_mov_i64(gcspr, addr);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -2765,6 +2789,11 @@ static void handle_sys(DisasContext *s, bool isread,
             }
         }
         return;
+    case ARM_CP_GCSPUSHM:
+        if (s->gcs_en) {
+            gen_add_gcs_record(s, cpu_reg(s, rt));
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


