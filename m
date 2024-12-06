Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A391E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOt2-0006Mx-Fl; Thu, 05 Dec 2024 22:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOsr-0006HV-VM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:20:04 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOso-0006Aw-R0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:20:01 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71d4d0516e6so885337a34.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733455196; x=1734059996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXtQ2J2gXZQnpl5TMdFaAQCMXFAj8tQs4pJNt4mkpI8=;
 b=Ad27ElR4kX+KGppnKHsxFh1TE/gVrhgl9MBh5hcJAFGWR3V7Re2IPR+NvvTmhzE7qy
 VKJjY4qs7atJH4aGZkViLfTTQnVU4qjnmgL0nIYJg6AHCrP50ffTFGGY01OrQOa6qJCD
 waZwXiPIqa0n6oQzQlMWQLiiohVaP+sBePJrCECbjY9C+MGbt4WRWo1XpN08B3E/FN9Q
 T6QAMIHNxNhdfuWkFWJEfl+OspcL6gdb4BkjQAwsDXwnrWJCQbPgD70gv45A0cp7dtlH
 fWbAtulwH6rDQVA7aHg8/hJ237uZmSzGQRFqvC7xuq3ZgGY1ObFaGJ8jTSm9GqM6vrkj
 Ooaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733455196; x=1734059996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXtQ2J2gXZQnpl5TMdFaAQCMXFAj8tQs4pJNt4mkpI8=;
 b=csegKL8w1EHGEv/nvsmqBjN4D8hbKJ7XdZolfnrE9HLcsTESgawl2+yjBm4ZAZsf/f
 7d8Slr9KVqewi+qcgTpqVLlbBV674mLTPutLIxC6+7Zh2CsXzly2q/wEiGxiE4Iw5N/g
 ANVCyLsxsKX9BXpyr+jw2vPRrVtnJQFUdn416JiGOGxrx0BsFmkFZHk75CBtj3qDq4Zm
 83BknHOQtpIwAwaQU9tCoFArQt1zAMVT2HL99AjjAaiknUzh9EWurKYA2VZp685wkMwp
 ryeBOqEhEOUoZj7SsZD9GNWc0A+OwstoLe/E047580f43I5zXkvXSrSlfdhtXdxdRx/t
 GqJA==
X-Gm-Message-State: AOJu0YzRJ8BTBeIqEsHj11fojPdEcdLaou+sDs6mL2iy0GmnQg22QJRr
 QZh2Vm10YnnpUfV86K+VaU9DnxEcHpn174bHLUDOsxpW+bNroJ+00wg429OSCxlge1PHb+u4Q65
 t87IsTuDK
X-Gm-Gg: ASbGnctZrDwqiANX1+0b8m+bTw0PMWpSOjF5pA8rtZn4oQmdFfLA1s5dnnxaTh9xx9m
 Wbk+ecQNBkwuc5Pf0MBR+JDNWY0Q6nYtJIzuYQHqWc9J0KEjd3d6Bao5VEVhey/L7wTPKrXzHa+
 YMjm2FRFt1uuIl0K3BwN1Y12/8tb9ZXwIxaIH32q8I5Sfxyp7Z2d0vbePgvrJsRkRAMd9eTlyL3
 h0STKMRfJtLkmZcsJjnQ/akV5ZqL4ojBdGn19VBRd0li7twXn6jRwKD0Dit9JRIOuK8UAiqceBx
 5clKfocwBlBL1pT/gpFwMru4tsh8TZYsNESc
X-Google-Smtp-Source: AGHT+IFEdscCnfy9m8J2qfc3GYDj2rftjzCeD06y9GVWHFoikz7InwfvrIwqKWlSn6F3HNPk3fuy2A==
X-Received: by 2002:a05:6830:2b12:b0:718:194d:8a6 with SMTP id
 46e09a7af769-71dcf568f53mr1906897a34.28.1733455196322; 
 Thu, 05 Dec 2024 19:19:56 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793255bbsm541045eaf.40.2024.12.05.19.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:19:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 1/2] target/arm: Use float_status in helper_fcvtx_f64_to_f32
Date: Thu,  5 Dec 2024 21:19:51 -0600
Message-ID: <20241206031952.78776-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206031952.78776-1-richard.henderson@linaro.org>
References: <20241206031952.78776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Pass float_status not env to match other functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    | 2 +-
 target/arm/tcg/helper-a64.c    | 3 +--
 target/arm/tcg/translate-a64.c | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 26e327af3a..0c120bf388 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -44,7 +44,7 @@ DEF_HELPER_FLAGS_3(rsqrtsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
 DEF_HELPER_FLAGS_2(frecpx_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
 DEF_HELPER_FLAGS_2(frecpx_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
 DEF_HELPER_FLAGS_2(frecpx_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
-DEF_HELPER_FLAGS_2(fcvtx_f64_to_f32, TCG_CALL_NO_RWG, f32, f64, env)
+DEF_HELPER_FLAGS_2(fcvtx_f64_to_f32, TCG_CALL_NO_RWG, f32, f64, fpst)
 DEF_HELPER_FLAGS_3(crc32_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(crc32c_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(advsimd_maxh, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ff48bac1a8..35dce4bef3 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -384,10 +384,9 @@ float64 HELPER(frecpx_f64)(float64 a, float_status *fpst)
     }
 }
 
-float32 HELPER(fcvtx_f64_to_f32)(float64 a, CPUARMState *env)
+float32 HELPER(fcvtx_f64_to_f32)(float64 a, float_status *fpst)
 {
     float32 r;
-    float_status *fpst = &env->vfp.fp_status;
     int old = get_float_rounding_mode(fpst);
 
     set_float_rounding_mode(float_round_to_odd, fpst);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 59df99d502..6286e4fda3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9102,7 +9102,7 @@ static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
      * with von Neumann rounding (round to odd)
      */
     TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_fcvtx_f64_to_f32(tmp, n, tcg_env);
+    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_FPCR));
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
-- 
2.43.0


