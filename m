Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDA3D49775
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlX1-0001Vb-Dx; Sun, 01 Dec 2024 10:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWy-0001SK-S0
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:40 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWx-0004IB-4G
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:40 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71d4ff749baso1491009a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065598; x=1733670398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K05BccdsIU8t807GjcqZMY4bIXaGoBbAdQflnbBMnII=;
 b=JjdyRmeS/k9skGsEv/jM+Gl4cQMYE+tGvwCM6PPDxHsd7GrgTgPSsFSftQBjHmp7bw
 cReqOVJ/x72BREpdZ+EqyHd1Jz5yq6qeNicVbSRB+4DF9ZVes2WzEL76EydqMb7SVbwf
 G/ikNjviIJNRsp4CTjYKFxWt3J+xVAvLbjMU3FWTa9OM33D7IeCatnwm3BfFr1AXDqgS
 al+394kf/s5aDsQWjLDtImp/e6/xS//0hHdunPyhpTVpZ9U+b+Ul6m0S2CjnyZ1roCAu
 taKDp5MyOzLtdU2UeZFZM9OO07zBodVtrz7UEazkHS2SMFOMf8nVLy6O1fMz6GlWRLc0
 9jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065598; x=1733670398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K05BccdsIU8t807GjcqZMY4bIXaGoBbAdQflnbBMnII=;
 b=MPS/XonmDJHr4QYAFJCTzhF1nG667FPGhkea5g+M/Mj7BmaTAngWs186PcsUlIETCR
 0HdeZo3hpWjCocCH7YIFDTvgYFe5PB3dXWqu0VGxVeJnZx8YRcYxgSuzJmtAldBQ+B/g
 DYb04VVou226tRy9VVFGOZhWFi2Z4XTbgFszeH2jTFTYwewpIz2zVKiDe+f9o5hCqT86
 tlV4mAVfeR/0Wn9C7dGw3fE5aaQUKQQJpK4WXPbm4KH1sc5PexzUB21TJJ3pG+C5JzNx
 cfTYJlCXp+12VCd3k1XnRcdb+n4tPW89YwO3Wl1isiV1SIdHNlw//S6hxN6NAcn19SZf
 WEcA==
X-Gm-Message-State: AOJu0YzNEKUl9sWbpEh+TzZpWrfi6vm+ZMeYI/RK1XyaTgknVWrN7B5B
 1pEku0OMO6NfYu3/pgxwnVhbhwXpEbS1wSgTDqr1tLvEeh8bnhnS1t+RGfX79xjtLf6shX1Ls6U
 ncAg=
X-Gm-Gg: ASbGncucqD5shsUWbrmUmnZzYHdXP+90jygbHofVWfOVAOrV+JiF0D6h8YZLLr1a81Y
 16HZD4awChaFHtphZrFubKVXTbilkFDn6gIyn6OcqGZ4IXRT6e2ZQwvTgzTk3JJQlwZSfQmnpge
 dgSEQaaGMR1Bhag6ewoOiytC+LEiiTvoO+rIrx60TeiMf7DKmwMEHrL4g+xmhDKsKoyrGaYijMl
 NmGRI+1vKeYrqKoL8w3PcHCrckxeTYtcnDOJ7R7LsU0YtojowP/CoGEqphx6YuNjnzMO7Tw3iMZ
 GbHb1FQT+rplQ5At08OpEDg2xqOUiNpRljNe
X-Google-Smtp-Source: AGHT+IFicEXC/TOfFY+WrMKIWHsb9zmeb4LvxdlPoCqKMqHKuLRt8vF1ucCTbyGBUO0oAEA9tkO2rw==
X-Received: by 2002:a05:6830:925:b0:71d:4ec6:8600 with SMTP id
 46e09a7af769-71d65ca3b44mr18481534a34.13.1733065598024; 
 Sun, 01 Dec 2024 07:06:38 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 25/67] target/arm: Remove helper_sqrt_f16
Date: Sun,  1 Dec 2024 09:05:24 -0600
Message-ID: <20241201150607.12812-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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
index c976c15b08..4d945f2d5b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8358,7 +8358,7 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     switch (opcode) {
     case 0x3: /* FSQRT */
         fpst = fpstatus_ptr(FPST_FPCR_F16);
-        gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
+        gen_helper_vfp_sqrth(tcg_res, tcg_op, fpst);
         break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
@@ -10977,7 +10977,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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


