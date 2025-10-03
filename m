Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24D2CCD183
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jM4-00088W-HM; Fri, 03 Oct 2025 13:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKr-00068z-4F
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJx-0007jU-JH
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so3463721b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511505; x=1760116305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHz5PjQI7kMwAWAwhgAFBeJni6qiau6T1zMgHVqw5D0=;
 b=bhq5hPT8cCe3HlLgP5TEFYlKBY4vkgGevcpH0lvrjppjiUpZgzX+cngaBku8rjQNVV
 namfFvyb2aFIvIDxLR6KocjIOrPzvS3lL3w7d0YBds+patql2BrGFdXSDIzTr1taC8to
 RRAODkx/mjXCg/4ehLbROW8znlv/92YlKilK3wh2cowOQ1YiVOmdYp1BPDfS05RyUS8f
 wXqToYJyqjmzz6ThB75ugBsx+WoNOh6MeMZ64p6UAPxqGNk2s8M3A0HmnVv9s94R7jTs
 bZfVA5U9/WMDKrcegUfRn7LxlmCPDkhs8CUyz9GDb/ec71F4OpN2QnRX+MyHH+0IPlZE
 LNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511505; x=1760116305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHz5PjQI7kMwAWAwhgAFBeJni6qiau6T1zMgHVqw5D0=;
 b=DPQ6MySZYxfzgQN+q/NmdOD4DSYs5P2ig7wkOhWV2LNiCNfhYPNMiicMgKt0hnqM8y
 TmCCTzVn2vIBhI0AqVyFe9LtNrx29mtgNrz88zyfdyTuavyqcTMFIWahEUNIcdhEDWAu
 xqyhqSRaGb4a2nOrIMK/s+o/h12UYWkQ2ta0GiCTeCuUJkQWAd1qeROBcNm7wE4JNiC/
 zslcN4J6BfjluVdEHWAM0woFSvGCbzop5AtIECHJLXFxo7fyHvqPUQh4EmkkT2E5gJde
 yerI++1TIM2PCQRg3w8CK7cxgWW9YcQDS/ebbDd5IcybphznwyhkMw/7Bn7C80hnpips
 jSRA==
X-Gm-Message-State: AOJu0Yx7UhYE+fYUkHdCV7vZ+0uOLrzX7dbw4kOJGcjUHwDJ/RSu3+km
 lUfUhicL08jGMHyawljROGiCwwjNot9pRD3gXBJqTTY7WX8s3QTfb0y+Q6dvyWif764yGqRVOP2
 jPTZ8p4w=
X-Gm-Gg: ASbGncvQ0bpPRIufTc/jCFRQST9ynmBTaXyq4iPBZ/+lMV5uK1OqXWMepHZk3AG2fGy
 dBTPy0Ulo9qCKeCmv9MwmMHbEeA3Mnb2nHdcMAig1k96chLKtpU5Q6h3PgUKSyOWO/4DJIbQhxB
 Lbq+7Zcw2V5jMlSP7ngRHLRWEftYbKe0Er0FfafAYCzh0xEzJvhuHpTpQPxE85R4PSu6KADVGfx
 dDNw1FM7uzjrGafOAsQ3Po4guVZ6Jwh/92HQgp3ZUvxhnOMaM3ewNRgN/vHyOkIChDUZpeH1BUN
 eo+Lb8vSkSZtGsBfT5b6NHzD90GUKWEgHJqV+VjPqJRyPqoFx+Y02nkAMntxGd4gK/EbkgTPxfe
 9bP2EcjcSKntEDks5gNXcIC4EhhBX4sNXau1n0yhoZQHAVMn7t1qSsDg9
X-Google-Smtp-Source: AGHT+IHirQxN4+K2ODu7O9IQZGXalWjD72bboF2oz2nKeIRNI5XrtNobSb2yIK+7Se4tTCWBiw6GAQ==
X-Received: by 2002:a05:6a00:4f95:b0:781:4f6:a409 with SMTP id
 d2e1a72fcca58-78c98a74e74mr4495509b3a.11.1759511505192; 
 Fri, 03 Oct 2025 10:11:45 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 48/73] target/arm: Implement GCSPUSHM
Date: Fri,  3 Oct 2025 10:07:35 -0700
Message-ID: <20251003170800.997167-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index a79f00351c..d22ae383cd 100644
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
index 1ff041811d..cc5a0b86e4 100644
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
index 38a1f51ed5..4fb73f821b 100644
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


