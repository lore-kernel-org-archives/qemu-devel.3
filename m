Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AB7CD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPf-000809-Cq; Sat, 16 May 2026 20:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOl-0007Dn-IX
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:31 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOd-00050G-If
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:26 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82f8893bff3so454062b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977817; x=1779582617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2YowRxNRLBYS6ametaessFL4W/WU5kteC+kwFAECtE=;
 b=xeLOwWsfGL19P0nfPJ4b/q2PdUeBL5L6xLi6Fi+7P0ur4TWgtgsWsTUdcAwwbymEuU
 MSL9F49YS+QtMhiFOun1z1RJFqL3wH9NpsOrbASwO7ryFv8B02JnmAyESl6ZfNQfuqxC
 mEcPTyU5Fh6aprXUcICkB7ofMAwvm9PQbDcCbqP4YxSPGBkLQoF65QTNBGv3A5p3+qa3
 bewbn9x6i0ZVroyJLlFz+uyxavw6Vk70sm5e230qKkmEi/ZHmbbhV+dIDTE3PXD85KJK
 yHV/9paxNbe+ly5tblWSgUZZ3VOM0+8IeLZ0ccGLsXLsbaF83DSMv0WfLA9yTTd2ZpPE
 i+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977817; x=1779582617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P2YowRxNRLBYS6ametaessFL4W/WU5kteC+kwFAECtE=;
 b=VudP0EPE8OAYRYsfoLHAPUhrQo7TDe1X98SgxmOBFEdbBMrnPGoIBpeMj6+dIgcfcz
 95DMC2/2g/Ma6cL3xaNwzonPGd4GLMTl2KctD7em1PE0lsOmcRjq7uc6WugUKuG0NJVo
 igzMyLRUq9QpepbsFOVb3Aul8rg8mfiHFNWd5WsIWUrA6n8I1ZiKsasF4E5EFq05j5AV
 HDQOV7JVOs94txiGnWZp8Atrtpu0sml784j12RWnaC+GuDsAqD6In/gaH9aOS1E4IDUE
 y7Jh0ieIpzcTlHJKKDjSeyFl50PGcwfc5kA5tQQTu2fuyBTFzoKhad+wUXD+P3O7IxJn
 QwhA==
X-Gm-Message-State: AOJu0Yxyqu3IdS+x4xKzSUZCjBRl4ve4Kkh0AEhBmUtJZSRaC+4TZMQf
 Qblfj0UV+8h1U9Fu7vU9M8yCSPVmJrTJTDAnmF5ESSs58FmRd2XaGEfEV9Tupl0w4V8i263TTIb
 cQ8kA
X-Gm-Gg: Acq92OGJhcu1urYF5e/fIyqFdkf8alRVdZN6bvAVxJvCa+2RM+qZkoSOjsMDpFCXAwK
 1+geedLgjgq9vNk6hi0n/gfiX+CMl33QzASe3okn1I9ILmnSE7RwPwYXUCPggGcB7y3uXfxrR3t
 zPHL675MlKT2+97N40Iu4VGdjTJdYFUKMLmLLH98093u0fxUQ7GVOy0wli4XnqfuuTTqkU6MfFv
 VtwQl5Dn1Strch9IcWjkycHpCJWggmXjjo6invhxb29cFHqCv547ygcN+mkqFAVj2TCIVCWfOb/
 oIa2EEEeQ7eyctQF/Wh8HufSMl8vCgGe/WIOhrRzoW8c/qna1i5H8Su78Fbyh2z3gGo67WkcUJU
 pcy7LGpHAcRWGitNQnly4bR74NVIvvCHGnOZXcGgy1H3oikCwqEn4EqiXaFTTpl8GJEHHIfmC4J
 wI/xMHfhGjZ1wN3o///1goch+AmnqR
X-Received: by 2002:a05:6a00:3005:b0:82f:6640:7229 with SMTP id
 d2e1a72fcca58-83f33d39f43mr10366946b3a.23.1778977815819; 
 Sat, 16 May 2026 17:30:15 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 13/63] target/arm: Add FPMR_EL to TBFLAGS
Date: Sat, 16 May 2026 17:29:12 -0700
Message-ID: <20260517003002.321430-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Prepare to perform access checks for direct and
indirect uses of FPMR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  1 +
 target/arm/tcg/translate.h     |  2 ++
 target/arm/tcg/hflags.c        | 41 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  1 +
 4 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c114510446..9e637c1d80 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2567,6 +2567,7 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 FIELD(TBFLAG_A64, GCS_EN, 41, 1)
 FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
+FIELD(TBFLAG_A64, FPMR_EL, 45, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 77fdc5f3a1..1648c2c96f 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -199,6 +199,8 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
+    /* FMPR exception EL or 0 if enabled. */
+    uint8_t fpmr_el;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 7e6f8d3647..6759b36f28 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -237,6 +237,43 @@ static int zt0_exception_el(CPUARMState *env, int el)
     return 0;
 }
 
+/*
+ * Return the exception level to which exceptions should be taken for FPMR.
+ * C.f. the ARM pseudocode function CheckFPMREnabled.
+ */
+static int fpmr_exception_el(CPUARMState *env, int el)
+{
+    switch (el) {
+    case 0:
+        if (el_is_in_host(env, el)) {
+            if (!(env->cp15.sctlr_el[2] & SCTLR_EnFPM)) {
+                return 2;
+            }
+            break;
+        }
+        if (!(env->cp15.sctlr_el[1] & SCTLR_EnFPM)) {
+            return 1;
+        }
+        /* fall through */
+    case 1:
+        if (!(arm_hcrx_el2_eff(env) & HCRX_ENFPM)) {
+            return 2;
+        }
+        break;
+    case 2:
+        break;
+    case 3:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_ENFPM)) {
+        return 3;
+    }
+    return 0;
+}
+
 static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
@@ -500,6 +537,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    if (cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
+        DP_TBFLAG_A64(flags, FPMR_EL, fpmr_exception_el(env, el));
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3c6559964b..b013dd51cb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10726,6 +10726,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->gcs_en = EX_TBFLAG_A64(tb_flags, GCS_EN);
     dc->gcs_rvcen = EX_TBFLAG_A64(tb_flags, GCS_RVCEN);
     dc->gcsstr_el = EX_TBFLAG_A64(tb_flags, GCSSTR_EL);
+    dc->fpmr_el = EX_TBFLAG_A64(tb_flags, FPMR_EL);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.43.0


