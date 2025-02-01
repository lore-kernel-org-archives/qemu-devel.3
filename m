Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA50C02194
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY1-00069U-G5; Sat, 01 Feb 2025 11:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXq-00061y-3H
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXn-00014t-Ls
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so29994545e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428029; x=1739032829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L7uKkKWQlS5GpTv1NC+SMpvmOAGKUISLYBC7KsY2snw=;
 b=EzYpY0Q1T0hy3Hil0B9w8cq3MqmGFQVEIHaah45sAX5XGZwakdMCCYzQbLzxAxPLNB
 EaMS4imCdNlwnHIwyTFGO/YHq0Iswq59dS/TixcpYp9YAPpS8LiBqdPU5XtidK+NQc91
 370GMJdcN9CmM/C8mjdEYmXVT9VQ+COVX9sm/UB3TjWTiHqIEOSwL32LUEpgDBcKtTVU
 jLwUt7qB6i96izeK6iQiUU7sHeOITUOv9ujaiArsQUq4eaOTNaKyEWYu1b1n4psBkKfP
 g6IXT8AFT4YIwO6iK7/O9o0aPsxyp21kB2ppkV/mNFoKL9tOVDHG9fNCIwzsiVkIISmT
 +EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428029; x=1739032829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7uKkKWQlS5GpTv1NC+SMpvmOAGKUISLYBC7KsY2snw=;
 b=a8vBJ2WBhxSovnjdq6p8/RdNz1U7EJEIos/Av68+C5b5q2ycYOlTVlV53njI9m1xzb
 4iGKfn7jEu1bF1O4LV92tcKHebvUjRE7eKWOw8JlL2J+FE9vMdsEIpDsxs61TxIH91iy
 zyzNJST+LqOjdo7kD3XICF9ziCwF6FttxTAamDHqzcu0INswJtTsjWZpj91GvTTOJxkm
 EKSnxbY9ZGGCxMwZNBn+iljChF7ks0oCNBHcU9bgbhK32ysejWFmioUzJktvGsTyaqWv
 P8NasIFWBkqe9xP0RDMz2VLKmGWM1c81mv8C2Dy1bmWJpv23rEgvzoCl2S5VP3mQErhJ
 yB3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG/wBuIrli7lSNpk8GTtSxpuOuUwYE+Fv/NPY82DnA0l96/1IK3Dr7CUxM0ELyzhwkT2Nw1agYULMi@nongnu.org
X-Gm-Message-State: AOJu0YytBYXHSaK9DsYDPKQ5eU7t7WrSJmb3irF9p1CI2XXNXCjfFYO8
 4Dr0CJg0459SQPUFVa8Gn3Egj69zBiQ5y5d5nEClY8kDb041gLtcA3WVdtRDXi+3DeozLh5I/sv
 Z
X-Gm-Gg: ASbGncuvZQyPkiWVvCBoGyeUFHEFX48QIGx2UysOBJ6vfnuLwax/JvlQSC4iyXKcBtp
 MopSgShMEcwgPxeGqKbmbPkCP8tFsaVG1bu4BHkohyg5puw8V3jRO5tDQN57rMzvMLDZJrZ/Bgd
 /iDaYrEW2fFouXZqmzGpqBLYQp1eIn7UuW6sYTjy1a/fxe2SV2OOHZR6V8cRuqYE1cVApof8h89
 fvGoDoCHjNOEovlAPsW1uV76otKfm6n6ok4KfV0AgH/OJkM9TzUQY5YI3NXlLP1WBSV3qNL7pn1
 9M5B92JaLnPPcO4GbTEw
X-Google-Smtp-Source: AGHT+IGPSO/YslVHUxaPJdG4BuKFyAqJ0GQy4sbnlvPZNSXhb3EGsTKUolJs08lBmhCzZKQIry0PWg==
X-Received: by 2002:a05:600c:4e0c:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-438dc3a8faemr140034065e9.2.1738428028928; 
 Sat, 01 Feb 2025 08:40:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/69] target/arm: Add FPCR.AH to tbflags
Date: Sat,  1 Feb 2025 16:39:13 +0000
Message-Id: <20250201164012.1660228-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 084ee63d990..1fc4fdd7794 100644
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
index 0b76a2cdb78..ac4e8f8ec4a 100644
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


