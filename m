Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2395ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cD2-00011p-Ce; Wed, 08 Oct 2025 18:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCk-0000TL-RE
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:15 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCM-0007NX-MU
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:14 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so224888b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960788; x=1760565588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auRhuZBR4mYBcBfeKBalVDKijSH+/N0/0EXrRkaOPlI=;
 b=gPcB9Kqh9KcF33rmgdYNZdGF3MtcIT4PmhH4HHeUeBeBnHaTb8tUHTDpUlIxP+u5VG
 iDAfb4QSSQsjUEIyGv7a9i+0UDIh3z/BvTQkV8CsCKaMsdeHUi/U5u6ii0w3NTS3KGuz
 0zo5Le9Slzs1HzjqK8PjSyMo60uu2vuRrchXlj/TiotV6WXxrxu/rLvl9v47b130HFe3
 Vgvpsj618lYzoFi3XBsnJjfl2dDktjBr2cjuwhpWpztHY486w+QvZSi+Wr2kdOxGyQiy
 MXPz0wZkKgQEj/ifZQ7RvfzUh33rTQAkFAoqC4cAFOQAg5SGyOwmmv2fwQ7EMjclRGse
 pSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960788; x=1760565588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=auRhuZBR4mYBcBfeKBalVDKijSH+/N0/0EXrRkaOPlI=;
 b=Vd3SymwDHOBZ9PTqkxgbBYiyNmRR2T4CUF6uDkY0zJoY1xyneNP7Fswyr1MoH0YJez
 IyWSlzmjhCNfCAmzKW0RJv2Tum7ed57wMZm9ODZ6G1Mm/8ep8sx6gnayJ75SmtP/PscK
 G10FDgisBWNgz4cp0Q/Rv5IVQiUt0ckCOpJ8zne5a7Gd0G7jCDr1JhWp7pyJi7OR41ZI
 6ThtJoXyImztF/+5WcppboZLAAeTImCkpexGmkEB+bkbqwlTOQm5iwaYHekQCV3a+UjF
 oYmS/eOh3/6Mdqk2NNuqki/dLN0Ov812symXiCP3DzZq4aP2q6l2iy6OK0HP3Cz3Y+KO
 y/IQ==
X-Gm-Message-State: AOJu0YxGeQUU33Dv589k1uGb9M5SBh9yQ4zW5Q4pW0TZcuvvAubcOdT/
 mav5j8GT70g4lZr9rf7K2T2C3ldVYrUniASTQQ4zzrWRxbHho2YpdLbvh3oNPc0xGHZIupuV4ig
 IV9d4G6w=
X-Gm-Gg: ASbGncsb8dOjaL+2wrD4fyqdtc7yMS4bSHxMsFt0QDNm6x3lkgRsy5WOH3PrFErciTD
 fURUISg3wU/nUYg2iJuyd6PwoJF+1KJvIiIE2eUJ+rXwiicH8EWx6eIJ/FVqAeEvZslt+TBcCZ1
 4Cl/aStkG3Lka6Fr/Y1cP3RBdm4GYaF/mB5hHnK8Ew/cDsgk/HUPLLiC8nFdhhzGWfi+CDOxCbQ
 aZ3QX4jZZduc5b0rJYO6CJBYdh89vpLw/VzVSXzTl5iJUWIgTvtTUgfRSWm5TwkSAOLrZC53Ziw
 AB+IfP9xq/2saBNYm0DcWg41mEH6eFd4A6xa+YSgUmpEUZh3XxUDfPBYzUyuryX2RVXPZ5vqHIh
 ZPFrIN/mdR/oNdYV426WRB+3flRGaMzJJCfS+I2F2KRu8msYK+JDBqg9g
X-Google-Smtp-Source: AGHT+IGjD8I/W+xWuykNE+5vpilwrC2C8TEzckPp1Rqhv/+eIIfBUnK6m+160iWWSQmE+c8/utQkyg==
X-Received: by 2002:a05:6a00:886:b0:77f:449f:66b0 with SMTP id
 d2e1a72fcca58-793883dad54mr6441319b3a.32.1759960787373; 
 Wed, 08 Oct 2025 14:59:47 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 50/73] target/arm: Implement GCSPUSHX
Date: Wed,  8 Oct 2025 14:55:50 -0700
Message-ID: <20251008215613.300150-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 target/arm/cpregs.h            |  2 ++
 target/arm/cpregs-gcs.c        | 17 ++++++++++++++++
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 81d8f0e32b..909916b7fd 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -50,6 +50,7 @@ enum {
     /* Special: gcs instructions */
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
+    ARM_CP_GCSPUSHX              = 0x000a,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -875,6 +876,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
     DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
+    DO_REV_BIT(HFGITR, NGCSEPP),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 15d383b2a4..e6c7025d02 100644
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
@@ -103,6 +116,10 @@ static const ARMCPRegInfo gcs_reginfo[] = {
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
index 7783273cc1..0df1916d28 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2539,6 +2539,35 @@ static void gen_gcspopm(DisasContext *s, int rt)
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
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2856,6 +2885,14 @@ static void handle_sys(DisasContext *s, bool isread,
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


