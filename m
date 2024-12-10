Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC363E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xa-0004V5-7r; Tue, 10 Dec 2024 11:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xO-0003fU-6Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:30 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xM-0006Vy-5p
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:29 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30219437e63so25663751fa.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847566; x=1734452366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UXwx0kDopuEVwiBnbW88lWarbgL+jsSQVFPQ+k0F70=;
 b=I2evV/m3VJZxMfOCGB2GL2GfF0ibnDBMXbUpAYJpAfzZLhvlj2L3gGT1fWtPZtu58j
 BZ0lN1EWIKxpoS3prLEY+4qaT5bZMq/jc3WjSOJZFJd01OLzrdVJj5B3vi6q+kXfXthe
 86b+ElBHelwa/7YvdhPnTjr5bj59KiiAXUjEYgpckZ7s+C7AAYtOuGOpQCdLatYqqq1A
 5K+UF6cBpCGVfE6E4bdj8HP7cNKD7sT/hi0sPKYo51QuqKJCBi0/cyFb8dJwM1tU3MkG
 Q0F4GmCynbNrEqduBBWQSz2pkwTcnGd3wmOAeRfVSwGy5FL0PTLlnFadRTKRc54HrU80
 CEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847566; x=1734452366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UXwx0kDopuEVwiBnbW88lWarbgL+jsSQVFPQ+k0F70=;
 b=UbSpZywDIxxonuawomAKwebALKLk+50IkJjWFQa4vn1bYIuuMlxF9FGNlNPOIR08yo
 SBFDp3eZBdVikuiGaXM3I3kvmEKfwIqsi5kCUsceNxQ8j46r1izpZcbnH2g07DzruHEY
 dYAiexa0vNJ0FDjmr20N/jwZkzqCG9BIYBj13CGMBhU0REGS9m9TCxl0ZMEcAioWDgsi
 40JPqH4NYILJLCjkNyzIVQRQNVGwgqFXrzQC2LEHGli61o6Sd5wGEz2PKSf88vtw/rN+
 YbSD/6NuDW7Oyy3ZQ8D0cFy9rjIedfcCpI5PN0fY7r2x9TYGqaT5QsY05ox2LgansqGB
 FOPw==
X-Gm-Message-State: AOJu0Yxv7VbzIuiVrdVezS8UceSFHGbNn6jcbgffnz6Zf68A64JND5Ra
 xxhpi64HLNmDmwUfOkKd2QTPYpC+1uoxMkMIc+P+i2BCafHcxZdKJfnylwN6gcbAjCEU/iNuwWd
 d1a6+Z3BK
X-Gm-Gg: ASbGncsfMvPQh7abWIFHeaE1LarZWevLWakIsOAQW0NW2fHGq/nrSXz0EjA5J+k0Gaj
 5OxFjRh9k23RMc+Sq5prBZzm2s31vCyAFvVWvC6iXcDit86WFrs9UPRP5G784jNeoDJcSiV+Amc
 LXbQmdoSmeLoec9aMXsz6saLAEre1Ysrgllq6R6v/K2JQ5j2ZsVpw9LZO7SfVcbvY57rQXkVFIR
 CcKfWq9ae1hPf2/Qa0p4V4rQM6BMJs6hF73iab1U9NP4ELQgTwFP02nnoo=
X-Google-Smtp-Source: AGHT+IFLVxOZtLOUlsGIcuqq99m8tUsqXwgaeIFyag996JKjMIHVljupwiM8gUjN/Wl6QXZ7RdjS+A==
X-Received: by 2002:a05:6512:1250:b0:540:2223:9b1c with SMTP id
 2adb3069b0e04-540251fd730mr1441112e87.25.1733847566392; 
 Tue, 10 Dec 2024 08:19:26 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 26/69] target/arm: Remove helper_sqrt_f16
Date: Tue, 10 Dec 2024 10:16:50 -0600
Message-ID: <20241210161733.1830573-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
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

This function is identical with helper_vfp_sqrth.
Replace all uses.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    |  1 -
 target/arm/tcg/helper-a64.c    | 11 -----------
 target/arm/tcg/translate-a64.c |  4 ++--
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 481007bf39..203b7b7ac8 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -80,7 +80,6 @@ DEF_HELPER_2(advsimd_rinth_exact, f16, f16, ptr)
 DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
 DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
 DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
-DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
 
 DEF_HELPER_2(exception_return, void, env, i64)
 DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 8f42a28d07..3f4d7b9aba 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -915,17 +915,6 @@ illegal_return:
                   "resuming execution at 0x%" PRIx64 "\n", cur_el, env->pc);
 }
 
-/*
- * Square Root and Reciprocal square root
- */
-
-uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
-{
-    float_status *s = fpstp;
-
-    return float16_sqrt(a, s);
-}
-
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
     uintptr_t ra = GETPC();
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e278c0d87b..e6878abd35 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8354,7 +8354,7 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     switch (opcode) {
     case 0x3: /* FSQRT */
         fpst = fpstatus_ptr(FPST_FPCR_F16);
-        gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
+        gen_helper_vfp_sqrth(tcg_res, tcg_op, fpst);
         break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
@@ -10976,7 +10976,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
             case 0x7f: /* FSQRT */
-                gen_helper_sqrt_f16(tcg_res, tcg_op, tcg_fpstatus);
+                gen_helper_vfp_sqrth(tcg_res, tcg_op, tcg_fpstatus);
                 break;
             default:
                 g_assert_not_reached();
-- 
2.43.0


