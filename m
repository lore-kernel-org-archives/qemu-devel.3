Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166F4CA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeM-00040u-0P; Thu, 14 Aug 2025 09:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdD-0002aS-7s
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:36 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXd9-0005Eo-Rj
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:34 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e2ebe86ecso1164744b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176667; x=1755781467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNbTDmlYWVvmzgANCnheua5XzqfUi57qMv8FEbGAPF4=;
 b=vGVeME6uBJs17qa4D4Dau4dgrxATSMg2koOd84e1gTLDRwsK1JgKlNj2nmz2apBtT/
 ix4iohcOZmTAqTf5eGhd3tulcC5vWseg4jMZVPTo5fEM6rHYwdd0CPaVeqMBJb13tUm2
 kmamVqSd15kvlEPr5vbh9Vi1ecdw3iAkijkEYPDAjxmCmz/QZsM3L4DgM/QjdEssPzme
 89Md9ovtqucOOMUOfYPZZcDvNsaDNoI5Y1joPP0Ni4NfswjjKSjo6tdgJA7vGuNCLtke
 ynDRE9Z/jCn/lJ6dY1gXitAkgcd5aIxmoDc4KTj8jXGk/Msu4AA0U29o918Jp+V6wLOy
 UF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176667; x=1755781467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNbTDmlYWVvmzgANCnheua5XzqfUi57qMv8FEbGAPF4=;
 b=r76f2CCBkCVnFISIZzLpOMHY/dI6ibSeQVvtKmOkFAajtpLuOhkhIl/KC+P4X7dpY0
 v/EiSgf5YeoMroq37NbPu3BPNQVHyRyAU0gp7qYddz9ySzOJWgyyQtLRsLnqIbQeis2+
 TAtOsfJULGutSS8Q60wcQZiPh0Zcfu9mW06UbHJYF2EDRtG+Yg5Iz0ALtVfAWYjsmPo8
 SdRUyolSvptddLYjcIaOIv9x4iacMRq0cpe+wLnJihzgqap2tGOBo4FFnRtmZQEewnNY
 +flKoUdDshfiyqNA/mlMZDOpX8spVsSjTqboyXQ/eQXRd2t42oauK69n72AQwMVR5tYa
 0tUA==
X-Gm-Message-State: AOJu0Yw1VZiHRjtGwcGilx8wowQAInMNlRpC5+gabBO+YFtJYjp7wBDs
 fgWFROUAIaz5qBCL5LE1m97xZigN/hjfp5mt7wjnduglVk/3gD6FnngzsFF7Ssa9cZRJV3Mat7P
 vG/pdba0=
X-Gm-Gg: ASbGncsk0XtAlkadOEfrsH1M5QFunS/Kpd4Zb53SRNkjKa81FZxaYIfC6VLAh0fLimE
 E1kVAfj65HBY0sY3JNztDz/Qal+H98aclvlgBMMnh+78CvpHt+QlDSRhG2yiJa22jyWSdVZxuTQ
 emLeOJ0AR449coEnkeF5bIbPpp/xCnflELc1/ZyiFrt1va4aGqi/lBmID0pZk5tcm6XSmDST/9Q
 B3VHl/irTb6YUL3a3IsvhMKnaR0xuV5SOFpL6ZE4PA3i/v+Dt6t73vyVTYYcsk1TN4X7AqLDAd3
 fK+SRjhUg8GnFVSuPqs09jqVD8Em6dx1yhtqm8ehth7SJbzcs/9e8+gJAKNO+xlRjMLkloNs4Zb
 q2UOqBLmNMXK+QLmrNqqjIRhCNXuvtp+ImU+z/0MDytP0UVA=
X-Google-Smtp-Source: AGHT+IGfrDON/l96teX4hxiMx+0bA9hk3Vbkm5FNf+/2VwYcBrb2pbESzM2+q3uaYF8Tm67jaITQpA==
X-Received: by 2002:a05:6a20:1592:b0:240:750:58d with SMTP id
 adf61e73a8af0-240bd23b59emr4472078637.27.1755176665449; 
 Thu, 14 Aug 2025 06:04:25 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 61/85] target/arm: Implement GCSPUSHX
Date: Thu, 14 Aug 2025 22:57:28 +1000
Message-ID: <20250814125752.164107-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  2 ++
 target/arm/cpregs-gcs.c        | 17 ++++++++++++++++
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 9b19520346..3d76afd20b 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -49,6 +49,7 @@ enum {
     /* Special: gcs instructions */
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
+    ARM_CP_GCSPUSHX              = 0x000a,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -865,6 +866,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
     DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
+    DO_REV_BIT(HFGITR, NGCSEPP),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index fdefb2e17a..c688d0c391 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -53,6 +53,19 @@ static CPAccessResult access_gcspushm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_gcspushx(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    /* Trap if lock taken, and enabled. */
+    if (!(env->pstate & PSTATE_EXLOCK)) {
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
@@ -99,6 +112,10 @@ static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
       .access = PL0_R, .type = ARM_CP_GCSPOPM },
+    { .name = "GCSPUSHX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
+      .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
+      .type = ARM_CP_GCSPUSHX },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e0dddbdc25..75a6ff0452 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2531,6 +2531,35 @@ static void gen_gcspopm(DisasContext *s, int rt)
     tcg_gen_mov_i64(cpu_reg(s, rt), value);
 }
 
+static void gen_gcspushx(DisasContext *s)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int spsr_idx = aarch64_banked_spsr_index(s->current_el);
+    int spsr_off = offsetof(CPUARMState, banked_spsr[spsr_idx]);
+    int elr_off = offsetof(CPUARMState, elr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_addi_i64(addr, gcspr, -8);
+    tcg_gen_qemu_st_i64(cpu_reg(s, 30), addr, mmuidx, mop);
+
+    tcg_gen_ld_i64(tmp, tcg_env, spsr_off);
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(tmp, addr, mmuidx, mop);
+
+    tcg_gen_ld_i64(tmp, tcg_env, elr_off);
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(tmp, addr, mmuidx, mop);
+
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(tcg_constant_i64(0b1001), addr, mmuidx, mop);
+
+    tcg_gen_mov_i64(gcspr, addr);
+    clear_pstate_bits(PSTATE_EXLOCK);
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2818,6 +2847,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspopm(s, rt);
         }
         return;
+    case ARM_CP_GCSPUSHX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspushx(s);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


