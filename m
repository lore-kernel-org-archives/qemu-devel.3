Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6050EE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xh-0007ir-4D; Fri, 13 Dec 2024 12:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XD-00074t-Fr
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:04 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XA-0001XT-HE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:03 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361c705434so14792435e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111179; x=1734715979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ua6+mxEWQ1r/2XhLkCgBi1H+Sl0jSzIsEgqRdsyvm3M=;
 b=P9RuLjWs85451jV7rrCyban757iRrOxXqwp+l5/Jtc8ENjD8vad9GFz1m3Ki6F+SaR
 mBsQaU++yOIkDAogE02dc6jK5LsNwHlWR05FiQ15icl76Uaj7yPBKFmb/TfeufJ6G0YS
 JAGaBzU1V+dYMiMty3AOmbV1ZJdnFiQN3JrYGKG3XAEbiroi+z4VCFEqFTMVn8mTeI74
 DifDPgY7LCQhN8t5j1PftaBNMbd+YoKBZbjKh7pd9XHU5BvrHEUq7WeLvSguVWURcnX7
 w2Y0kBkvAquJ+BnScrohqXfguPnC5QTTLwTj8OQyszaOMAKRtJ4nTELQ90c52f4wEhDl
 EraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111179; x=1734715979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ua6+mxEWQ1r/2XhLkCgBi1H+Sl0jSzIsEgqRdsyvm3M=;
 b=r/VwsnXKFQvtdUxNsjiYKquXP95+Dcgcw3EryqoWQjsBu2NX+x1xdYty08QNlTo1xb
 1AxwkM+RedlMojr3AyJgb5b2ucb4TQYlwufEHiL7FTtXoiJ18FDt0dRWUnUYkwt8v7dB
 WKlgUfGbpEW2moUHVgQCla/tXXGanlc8zL9SZWzR0e2FSWfzjwgayjSYViElLngHSc2u
 oXebKoaklNYTiaM5S+mcmOmDUVtM2u/i9PTKj7iTdgISQFiRfpiq8ybcNTs+yf/9ioCQ
 RIBaVEIiBfKKWdit+CLwJZj+rmw3gJgPxysjRONuM+uuyUTF5ahXv9+OpWWYY7msCd9q
 IJqQ==
X-Gm-Message-State: AOJu0YwQFFTBVY8phCJI5bonnz0WfaCDdlaMoeeE/KuspJLsgAA2uYuY
 tQD62qybFwbhzRSzr7xHf5UvAAiftuJpgJqN8kNcXBZgEmjgbLeW6BOO6m/DFt9WJMYv+0+j164
 W
X-Gm-Gg: ASbGncuOUEvzQ3SrPmp+EAV9oHI1iymy0+Zh3syXq/TSiQ+OWka11+Se8snext9Howt
 IRa0FS2SlmS//uyLskhPlzAtArECqhMWkuz4iFw9ZZpmtXar1dyXaPN9Zxp1aaGKT9GfptyYkRZ
 cu0j55pcuxp05bOHAmerOlkuDw1wWodlg4kQVm5LsZRXROeVN/n7jyz3aBoL5ShCra/iyzRTYAz
 7J97ljmt5ZOVSM9EbHzCxnqLvXNT0mi6gu+aUj1HllIuEgetEhDjbELJUGMaA==
X-Google-Smtp-Source: AGHT+IFR2NEdwsizs5+tcsUO7bUGvaYlbCnRlx3CNBTwEw+vlTNm24PA3ZIDk6RL629etbrnA7l3Ow==
X-Received: by 2002:a5d:5f43:0:b0:385:f5b6:9c9d with SMTP id
 ffacd0b85a97d-38880ae0fc4mr2558873f8f.33.1734111178884; 
 Fri, 13 Dec 2024 09:32:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/85] target/arm: Remove helper_sqrt_f16
Date: Fri, 13 Dec 2024 17:31:30 +0000
Message-Id: <20241213173229.3308926-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

This function is identical with helper_vfp_sqrth.
Replace all uses.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-27-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h    |  1 -
 target/arm/tcg/helper-a64.c    | 11 -----------
 target/arm/tcg/translate-a64.c |  4 ++--
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 481007bf397..203b7b7ac82 100644
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
index 8f42a28d07b..3f4d7b9aba6 100644
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
index cfc73b8506d..2a5cb704752 100644
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
@@ -10978,7 +10978,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
             case 0x7f: /* FSQRT */
-                gen_helper_sqrt_f16(tcg_res, tcg_op, tcg_fpstatus);
+                gen_helper_vfp_sqrth(tcg_res, tcg_op, tcg_fpstatus);
                 break;
             default:
                 g_assert_not_reached();
-- 
2.34.1


