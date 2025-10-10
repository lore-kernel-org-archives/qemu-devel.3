Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44A0CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqJ-0007E4-U6; Fri, 10 Oct 2025 09:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqB-000729-QE
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpN-0003yR-2f
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so960447f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101584; x=1760706384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DIQMuibNNz2umv8aVbc23A1gLvp13ZKOlMOT1YNAnOM=;
 b=FCAP6xfLwW5noTwWb1qJC1u85N3FtxPytUz6Kii3KEZk0f5OrnM1wD7JUlTCjZFdqx
 arybvnPoZMLq/Kpo+5LRfXIrS63FFbL5MSU6q1EWhIe7lfGtM5GmLS+2Qx5ImmvHTVmH
 S93PN6GMqWlvQCzwSQQsBhofctiatUzHCVCOUEVMYfbSuMhPlYTXRRFRNImQi43YWSnr
 FD/duiITplH6eZDOuryv6quKtsS01AS/5GwlOZOUG3r3xoivmpezgZKKAHWgnKPQn3ZK
 R81fLL3InZ7NjQXG2v/eOH92s+SgmeUqSvpIk3nHLjZAX+wlDHQppU/ZtmAMHhG7HRuY
 oydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101584; x=1760706384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIQMuibNNz2umv8aVbc23A1gLvp13ZKOlMOT1YNAnOM=;
 b=b2LGHt47JLUa7hNheIzAhMFMhX5JF7TkMGDyWQ9h0kkXaNfJCOzBVZQd7IQmB+y/oE
 UvOEOmngV8K5OKcfvQ4SGPvoVTnKayfmATRW3omg8JMWPog0EsqRag/F+7fmLRM+T3PW
 d/q/aU/qZreo/fGEmzyZ44bwWZs9EcqfanTUkeNgrEo0mFfyJl3lG2UrOdYwzGhiWPSN
 C4H31tl/VcHhBhhIbb57KZneNgR02YpR2f0p8VwmdrEefGg/y04xRXeW2okbf3uqxqFR
 Wkj2mkmMhcRSSXPrW3LyZ9aMq+pRAgl0/vIJV17ubQP5S6xQiPblqxI5T1W4W05RH5CO
 Unbw==
X-Gm-Message-State: AOJu0YxG2bDLdC9+5gVULwwutugx9TvqtwsvquVTe57l7ORBkR0A8Ylz
 0aylgRV0AhG9G4G/0Ec0Huajs9czHhTn4uWuUWNBjg43upQQ+F3YbGWn5Cu2T619LVVmsINbu56
 WQ67F
X-Gm-Gg: ASbGnctEfowFpw0+NEatS1fo9PM53ZURZh+Z3uiPeggH12eRifevtUp4jDwQp8fgEuH
 8kH3aqyN1Z+5A6vUSW5S+ZiV4n+nkPzEjwy0RprIMXujFCAZhllUkYlVop/AJCcsRzzvqrMyxi4
 SCy6srBYwOfkF/Kh6eQVpoGux4bwSnJ+eFYODEoLu58Ib9EuwQ0Cy5WSjtg3qu9bR3JCWh6D4S6
 LMV/P/pXbhRUR96TOrXnCCcU9lpgdpBJoaNTL506qucBwiHSCfhEWFwP+jflxB74W8qR+RkHSCP
 IKuqrFMC17D4o7KrhhMt9shCwDl9XkrDLA2pTv5oIZxX3oQL7hC5H4earXmOLoJuGwImXBx5kip
 E5tb3ew+LJvNFWkoaZUrCfVoZTOCiQ7Xh3f3+JiE1ZpbA55DQHKBBsdWvVPu9tg==
X-Google-Smtp-Source: AGHT+IHqf06bEvvGVQBVg5wVFndAb8XBdlyHJMHioeq1NgQ+wUCAVQ9I3s9HD/ip4gwDeuIxZk+6gQ==
X-Received: by 2002:a05:6000:2301:b0:425:72cd:8364 with SMTP id
 ffacd0b85a97d-4266e8e1afamr7831486f8f.53.1760101584290; 
 Fri, 10 Oct 2025 06:06:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/76] target/arm: Implement GCSPUSHM
Date: Fri, 10 Oct 2025 14:04:59 +0100
Message-ID: <20251010130527.3921602-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-49-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            |  3 +++
 target/arm/cpregs-gcs.c        | 15 +++++++++++++++
 target/arm/tcg/translate-a64.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index a79f00351c8..d22ae383cdb 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -47,6 +47,8 @@ enum {
     ARM_CP_DC_ZVA                = 0x0005,
     ARM_CP_DC_GVA                = 0x0006,
     ARM_CP_DC_GZVA               = 0x0007,
+    /* Special: gcs instructions */
+    ARM_CP_GCSPUSHM              = 0x0008,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -871,6 +873,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, DVPRCTX),
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
+    DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 1ff041811d2..cc5a0b86e4b 100644
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
@@ -85,6 +95,11 @@ static const ARMCPRegInfo gcs_reginfo[] = {
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
index 38a1f51ed5e..625563d95be 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -26,6 +26,7 @@
 #include "cpregs.h"
 
 static TCGv_i64 cpu_X[32];
+static TCGv_i64 cpu_gcspr[4];
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
@@ -2803,6 +2827,11 @@ static void handle_sys(DisasContext *s, bool isread,
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


