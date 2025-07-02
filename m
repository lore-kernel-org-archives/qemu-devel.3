Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDE6C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwhf-0002DO-M9; Wed, 02 Jul 2025 08:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgI-0008Ep-18
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:18 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg0-00017k-Jf
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:17 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2efdd5c22dfso2467922fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459694; x=1752064494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+lupzC8Nu+x6L4j8uN4IOKjMC3Hrdrd0rgOJMj14KY=;
 b=FkHAhu2hr7awrIX8lrqveKNCHUEhVtWKgiVco6/uPf1mG6X96hN/pdRJ6WIvYR0Nwf
 ORIYIhRi9pQV2wA0HniO8bVnSnfV/zVSnsFGi7AaZ08q4ZBZSgIF2q/R51rqyC3zhNtm
 Zu4U2lERib1sufbDPNRvO7bhiipUqtbYkd1IBP07C8j8LjIQfUkyceRr52f8k7FZvEAr
 eC+pk4I7R/irkqFEhwvOb1V6wMFGUoaN0DR/7Gsi+aiAS4ENKF/TEvdiGZRJp9MEEsDh
 QLffhAjIoecZPs4jxgb5CsCxF88C6yuP9gphByfR9xGzmC9qWsfp2rya5EogmO7bkYy6
 DEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459694; x=1752064494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+lupzC8Nu+x6L4j8uN4IOKjMC3Hrdrd0rgOJMj14KY=;
 b=FNkMRmC1RrjJhHMxRLCT0NyfjVloZdDu3vou/m75CrdaxSPLEQU75QuC/dWrlAGlcl
 ZgrfkL+HvP8xD4Ct3/64KJVuhCyUSNCqU6jUlK7HY9Zuob20iTkMgAaVUluWrFUz6EHw
 d5rFlnqrHlWI/JgAWM68Xm1xutrBtI3MkFjTRtte7HKsB8056tF1UlbAzaq6Z42jVT6M
 wXbe4Fvde55Z5O7ltBzYUw2bN29RzFP2bcCkNzAI2ta1U4+D2nUkGiH6O6lQqYaSdds3
 1+Rgfm1vnGOfaYnwntxo07FVixqB/QDLzowFQh5YwxP7Hq+69QWOacBYYCNj8dnY4FCJ
 D8JQ==
X-Gm-Message-State: AOJu0Yy2N3OfM3vdm90qGsq795diWzB2s+GcShVuf9qTT6gYDImGKWHM
 IrX5nRIkR/LusXwEY9gzQQTvI4mvBjKA5qapTZGPsUIxBVloSNVCkxobfPqEBhGpKQdBIGqLqog
 1xrym71A=
X-Gm-Gg: ASbGncuHQ8ybSz/3IooMbLsNjRK51a+7gyRQY/w1oPwrzqBivKYprWFdkdzSHA18rXX
 cY5Xc5m83asSpVS/xWl15sSY6tu8D9g9xswVb6I6QE7VYZOxYgTlWjAdOpv6liiNpzwciMv9NI6
 3lqugYnD49cZUcWOpCv3x+lGYU1s7WDFwIjcTcCxAKW6Yl0zIMUccdfl+fRCnGjIaaUxqP/bMBJ
 LEHNzDjO7wRp0X18tHcRTCsQeFOzFNDXHPqv4Bo4p4iWb/ZwbEjv55+8kZYhvgaKFBk4TSy1AYf
 DAeEsJkmizsu6ijSc1NZ9np6DZ/W8hMjAcZidqKsjoZL1atlx67GvXOO7g6njOfoHb9uxUrWPVC
 lm77k
X-Google-Smtp-Source: AGHT+IFxJHu3ymQagzf9ZcTE8mYuH1eB+t9WTVQwmTGvbHLhKmbK7lYoTY4LciRD8Pv7oRRKc15ztQ==
X-Received: by 2002:a05:6870:8091:b0:2d5:2191:c8b3 with SMTP id
 586e51a60fabf-2f5c7cc9cf0mr2245013fac.29.1751459693588; 
 Wed, 02 Jul 2025 05:34:53 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 33/97] target/arm: Tighten USDOT (vectors) decode
Date: Wed,  2 Jul 2025 06:33:06 -0600
Message-ID: <20250702123410.761208-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Rename to USDOT_zzzz_4s and force size=2 during decode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 4 ++--
 target/arm/tcg/sve.decode      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 56353b3bb4..c82a0f771d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7151,8 +7151,8 @@ static gen_helper_gvec_4 * const sqrdcmlah_fns[] = {
 TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
            sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
-TRANS_FEAT(USDOT_zzzz, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
-           a->esz == 2 ? gen_helper_gvec_usdot_4b : NULL, a, 0)
+TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_usdot_4b, a, 0)
 
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 51847ea56e..401c025852 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1599,7 +1599,7 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
 ## SVE mixed sign dot product
 
-USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
+USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating point matrix multiply accumulate
 BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=1
-- 
2.43.0


