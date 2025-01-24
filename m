Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B06C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMZf-0005xo-3W; Fri, 24 Jan 2025 11:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYb-00046u-NL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:21 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYZ-0005aE-Qw
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:21 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso16862125e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736157; x=1738340957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PiLPZstDGoHVEw4k0zndELCSvoWxaQNvBqkGl85q8fo=;
 b=PDEil/hnVZBwb7un3GVKnymTi/m65MuAVOaov9sAVVQrTn9G0Mq9BoErkjn6g0oyeB
 zgMi5B52KCA7MugR00CyKQ9ImI4lmlegkdieJrGBP4QHWKjWm1tWBggsRjkziT8MDNrm
 SNJzIx/DaKY+acNgkVRLpZzTFbFw0t5vYrw8HM+MTKOTAfY6x2pXZRXqqcVVfviQeX6G
 iOkKuLndU8sd86vkx6xmKSLvSar+wP5xsJbqgNPZBlAGnFVICBlxEjvYgc3mHLaONtAh
 9x7PDSxf5fTSOxZgepQVmxFckV49+n1bbCLTeOO6/NYJnhMbm6voxa8aG4FQcM1iyhw3
 fkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736157; x=1738340957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiLPZstDGoHVEw4k0zndELCSvoWxaQNvBqkGl85q8fo=;
 b=jJVhNVnGNFlN5LZT/pRO5himEuUWvCF4ixDZDfWS4pjuoxlesXOnmZcAOIs5lDACAq
 kzADaR3PAYo8fu1Nfx0sQrMiHACg2H1MFOlRuAdd2dekjS4wFEHR2fyHsvM8dGjewozd
 J/lJRJwCkZ6xGhu6bLI5fDAcREN5CqOEEZXDspK6DgwW0qAkEvHSp7I7xyFbEYjPRB0U
 pWmP/D+NyhkeLMNlV5UK7HhQOST+l5yHr/SLrG1WQH/yy2NyHHaG3vr8I+Cjv9MVtDwr
 ADS7yeQQJtYAfFHB0CqVFOACeKi9ual6NRFdeOrk3U2GyCCOzsF3K9JPhJbckbg3GO8W
 5UAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoNiy6A2bjGymPaCcSzcHa78JF9DUqYXR8ABNE3e3V/OA7aAvmxSJrg77Mw/QUzlaWvcWUD4nfnXkT@nongnu.org
X-Gm-Message-State: AOJu0Yx/6LG19L0jVtVLX0/LHyEud1QMCjMZS4y2Y0v4Uc/9AChLDkZI
 o9GCLr2J8t8ZlbQYNcBuyJ2qurVbzeuupwc+WPYU73t8iNsFiN9eWdAAq9vtC1Y=
X-Gm-Gg: ASbGncs8IbBou1sW2827oBA0q/U8kQONfjDMF6G/LKuNWPyGEy8tpfxHxsVEp5IByPt
 sq35l6ThCQo/AiISmfgk8YwTpzvAL/KsWi9hCgA33Hk30mJFH4Ndaybhv32O7jYnLjI8VVrUTCv
 4Jg1qv/UG2/xaemGUGSFg0QXm5EJK1eSxw/uzTrQLb7+28D0jfdqHRLaQ1PZMpDxkEqNI9lFrDe
 GBIshzO1b3J5WPmEyXgKsvldpG3agJTKgcBZVq18Eiar0lkmT4UtGoynrcXu+neZjJ6oyQO1Tf3
 3mbowICEiaw=
X-Google-Smtp-Source: AGHT+IH8vW2zGbyI6YfIRJFqhYwR3Q2FByZh1dFVLYtRyYi31QTPTmpPQ1r3CvDQ1NMunz6L2ws2kw==
X-Received: by 2002:a05:600c:3d05:b0:434:f767:68ea with SMTP id
 5b1f17b1804b1-438b0dc9532mr152363795e9.5.1737736157421; 
 Fri, 24 Jan 2025 08:29:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 31/76] target/arm: Add FPCR.AH to tbflags
Date: Fri, 24 Jan 2025 16:27:51 +0000
Message-Id: <20250124162836.2332150-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We are going to need to generate different code in some cases when
FPCR.AH is 1.  For example:
 * Floating point neg and abs must not flip the sign bit of NaNs
 * some insns (FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS, and various
   BFCVT and BFM bfloat16 ops) need to use a different float_status
   to the usual one

Encode FPCR.AH into the A64 tbflags, so we can refer to it at
translate time.

Because we now have a bit in FPCR that affects codegen, we can't mark
the AArch64 FPCR register as being SUPPRESS_TB_END any more; writes
to it will now end the TB and trigger a regeneration of hflags.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/translate.h     | 2 ++
 target/arm/helper.c            | 2 +-
 target/arm/tcg/hflags.c        | 4 ++++
 target/arm/tcg/translate-a64.c | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7ba227ac4c5..c8b44c725d0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3197,6 +3197,7 @@ FIELD(TBFLAG_A64, NV2, 34, 1)
 FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
 /* Set if FEAT_NV2 RAM accesses are big-endian */
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
+FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index ec4c0cf03fc..c37c0b539e2 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -155,6 +155,8 @@ typedef struct DisasContext {
     bool nv2_mem_e20;
     /* True if NV2 enabled and NV2 RAM accesses are big-endian */
     bool nv2_mem_be;
+    /* True if FPCR.AH is 1 (alternate floating point handling) */
+    bool fpcr_ah;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 40bdfc851a5..7d95eae9971 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4848,7 +4848,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = aa64_daif_write, .resetfn = arm_cp_reset_ignore },
     { .name = "FPCR", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 0, .crn = 4, .crm = 4,
-      .access = PL0_RW, .type = ARM_CP_FPU | ARM_CP_SUPPRESS_TB_END,
+      .access = PL0_RW, .type = ARM_CP_FPU,
       .readfn = aa64_fpcr_read, .writefn = aa64_fpcr_write },
     { .name = "FPSR", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 1, .crn = 4, .crm = 4,
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index f03977b4b00..b3a78564ec1 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -404,6 +404,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
     }
 
+    if (env->vfp.fpcr & FPCR_AH) {
+        DP_TBFLAG_A64(flags, AH, 1);
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a47fdcd2e48..556da6d23cd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9666,6 +9666,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->nv2 = EX_TBFLAG_A64(tb_flags, NV2);
     dc->nv2_mem_e20 = EX_TBFLAG_A64(tb_flags, NV2_MEM_E20);
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
+    dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


