Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09191E7717F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5I-0007BZ-0G; Sun, 08 Dec 2024 17:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5G-0007Aq-In
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:02 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5F-0006F8-08
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:02 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5f2b7a0387fso92037eaf.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698140; x=1734302940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGZ76CCO0E3ZRsJCJ0kN8XjjsbJn0MKiDssAdNgeYtw=;
 b=QUem7bu1jQqlCFBWjU8pKNvLhKcMfqyny0qKtf5pJMmWyyLga3b10iwEoFjFYUgkiS
 eAoupC8dssd/KR/KikxpFuPobc9gwWi7O2cXstd3BmvgVNtOtiPLi/OM09063tzg1WAo
 su+BLhqrvxA3qwhM5knxmz9AaNvdUPCj/d6SvQhNsbhzdcuLidzcRtQd3+Eg4T5ocj2L
 H7byHFey2sC3ONSiW5XRfLHDzdwQf6H8scSl68PdnizG4hMREINGWP5l2uy5deCc+we6
 JCrsANLLFvb6aZGCWLdDX7QxUolB/RA1Lkx+HQn3mV9kkf1xGZ8reFQqzNjjtugqwKVI
 hsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698140; x=1734302940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGZ76CCO0E3ZRsJCJ0kN8XjjsbJn0MKiDssAdNgeYtw=;
 b=Vk6ARzqA1cUbfKUqTqmFqdM9D2pJ3+UCkzZz8xU/LhLuahEaXAUw/o75mGa0opuV+a
 QttLGuUimyiQ04rBqgOtzPHCaowAlkB2gSNGJTKcazuKi4XqOqscX8P6Y7jjUQ6YLjYb
 JJ5pXetv8iJwflb/xGo0Sg1s+eTDUazipmMB4ZgpGWJklOc2/SRax+BPzNzSlo6Ksil2
 NduEL2zKFozoLvDPkFB8C1f2yOqE0ieMSTMI4O8GjFNk8xgpitPHtevqHJ6gxG7kZKsf
 aViUCGu7GPoY8RY1qGPsN6qnfMoqg35/L+nrX6gt+j9L6Kq5nRP5eSKH7MHLe270zgRi
 ctgQ==
X-Gm-Message-State: AOJu0Ywf/DCi6+D0KoDxmoHzaPLMsv5zCSLsxd6YN67yZx9G6nLBFIR8
 PyABCgzgeaub85cM0E9sNXPHFP3QyBFaxphdBLlO5YLo9J9rYkgKUDlUa9EzHBSnLwZrBw0o7qr
 Z9lz+oA==
X-Gm-Gg: ASbGnct/0reVt1um4U/7AWcG0PX10BMHBrqOkytqpSFF1Djoq0+sivfE20U5sniG2rj
 kJrSFOY3aIDEdAfStY6jquYLk5as1rZDfpV7JQy+1YzazXqs6iw7KNNMzdGhUsKgqGyTEAPrlo1
 oaGQohCoJIN968+z7syD+EFTcqIrvf2JB1xgyba9fC2eZwPa9od3rwZG/vKb7x4JZXMTuXFye6O
 NGRrpW3sCDHZW3W1Oj/nyxpr8dKtn/bvzaPfizKLbXBGWmqJN90kYhfX3dcxqXJdfdbi/ALYHKn
 RMqNJmbuY7lUuk1GjlYQfAXFCg/msarrp2om
X-Google-Smtp-Source: AGHT+IEb4H/Gj1x4FaPpM2hNfpifo9gCeabr3/DeMgcBpLma2CCOjQSlnEfSS4XB6j6Jkhng6mL1YQ==
X-Received: by 2002:a05:6820:552:b0:5f2:a054:9e65 with SMTP id
 006d021491bc7-5f2a0549e8amr2743782eaf.8.1733698139917; 
 Sun, 08 Dec 2024 14:48:59 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 11/17] target/hexagon: Use float32_muladd for
 helper_sffm[as]_lib
Date: Sun,  8 Dec 2024 16:48:38 -0600
Message-ID: <20241208224844.570491-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

There are multiple special cases for this instruction.
(1) The saturate to normal maximum instead of overflow to infinity is
    handled by the new float_round_nearest_even_max rounding mode.
(2) The 0 * n + c special case is handled by the new
    float_muladd_suppress_add_product_zero flag.
(3) The Inf - Inf -> 0 special case can be detected after the fact
    by examining float_flag_invalid_isi.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/op_helper.c | 105 +++++++++----------------------------
 1 file changed, 26 insertions(+), 79 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index eb010422bf..26e329f7b9 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1171,24 +1171,6 @@ float32 HELPER(sffma)(CPUHexagonState *env, float32 RxV,
     return RxV;
 }
 
-static bool is_zero_prod(float32 a, float32 b)
-{
-    return ((float32_is_zero(a) && is_finite(b)) ||
-            (float32_is_zero(b) && is_finite(a)));
-}
-
-static float32 check_nan(float32 dst, float32 x, float_status *fp_status)
-{
-    float32 ret = dst;
-    if (float32_is_any_nan(x)) {
-        if (extract32(x, 22, 1) == 0) {
-            float_raise(float_flag_invalid, fp_status);
-        }
-        ret = make_float32(0xffffffff);    /* nan */
-    }
-    return ret;
-}
-
 float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
                          float32 RsV, float32 RtV, float32 PuV)
 {
@@ -1210,78 +1192,43 @@ float32 HELPER(sffms)(CPUHexagonState *env, float32 RxV,
     return RxV;
 }
 
-static bool is_inf_prod(int32_t a, int32_t b)
+static float32 do_sffma_lib(CPUHexagonState *env, float32 RxV,
+                            float32 RsV, float32 RtV, int negate)
 {
-    return (float32_is_infinity(a) && float32_is_infinity(b)) ||
-           (float32_is_infinity(a) && is_finite(b) && !float32_is_zero(b)) ||
-           (float32_is_infinity(b) && is_finite(a) && !float32_is_zero(a));
+    int flags;
+
+    arch_fpop_start(env);
+
+    set_float_rounding_mode(float_round_nearest_even_max, &env->fp_status);
+    RxV = float32_muladd(RsV, RtV, RxV,
+                         negate | float_muladd_suppress_add_product_zero,
+                         &env->fp_status);
+
+    flags = get_float_exception_flags(&env->fp_status);
+    if (flags) {
+        /* Flags are suppressed by this instruction. */
+        set_float_exception_flags(0, &env->fp_status);
+
+        /* Return 0 for Inf - Inf. */
+        if (flags & float_flag_invalid_isi) {
+            RxV = 0;
+        }
+    }
+
+    arch_fpop_end(env);
+    return RxV;
 }
 
 float32 HELPER(sffma_lib)(CPUHexagonState *env, float32 RxV,
                           float32 RsV, float32 RtV)
 {
-    bool infinp;
-    bool infminusinf;
-    float32 tmp;
-
-    arch_fpop_start(env);
-    set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-    infminusinf = float32_is_infinity(RxV) &&
-                  is_inf_prod(RsV, RtV) &&
-                  (fGETBIT(31, RsV ^ RxV ^ RtV) != 0);
-    infinp = float32_is_infinity(RxV) ||
-             float32_is_infinity(RtV) ||
-             float32_is_infinity(RsV);
-    RxV = check_nan(RxV, RxV, &env->fp_status);
-    RxV = check_nan(RxV, RsV, &env->fp_status);
-    RxV = check_nan(RxV, RtV, &env->fp_status);
-    tmp = internal_fmafx(RsV, RtV, RxV, 0, &env->fp_status);
-    if (!(float32_is_zero(RxV) && is_zero_prod(RsV, RtV))) {
-        RxV = tmp;
-    }
-    set_float_exception_flags(0, &env->fp_status);
-    if (float32_is_infinity(RxV) && !infinp) {
-        RxV = RxV - 1;
-    }
-    if (infminusinf) {
-        RxV = 0;
-    }
-    arch_fpop_end(env);
-    return RxV;
+    return do_sffma_lib(env, RxV, RsV, RtV, 0);
 }
 
 float32 HELPER(sffms_lib)(CPUHexagonState *env, float32 RxV,
                           float32 RsV, float32 RtV)
 {
-    bool infinp;
-    bool infminusinf;
-    float32 tmp;
-
-    arch_fpop_start(env);
-    set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-    infminusinf = float32_is_infinity(RxV) &&
-                  is_inf_prod(RsV, RtV) &&
-                  (fGETBIT(31, RsV ^ RxV ^ RtV) == 0);
-    infinp = float32_is_infinity(RxV) ||
-             float32_is_infinity(RtV) ||
-             float32_is_infinity(RsV);
-    RxV = check_nan(RxV, RxV, &env->fp_status);
-    RxV = check_nan(RxV, RsV, &env->fp_status);
-    RxV = check_nan(RxV, RtV, &env->fp_status);
-    float32 minus_RsV = float32_sub(float32_zero, RsV, &env->fp_status);
-    tmp = internal_fmafx(minus_RsV, RtV, RxV, 0, &env->fp_status);
-    if (!(float32_is_zero(RxV) && is_zero_prod(RsV, RtV))) {
-        RxV = tmp;
-    }
-    set_float_exception_flags(0, &env->fp_status);
-    if (float32_is_infinity(RxV) && !infinp) {
-        RxV = RxV - 1;
-    }
-    if (infminusinf) {
-        RxV = 0;
-    }
-    arch_fpop_end(env);
-    return RxV;
+    return do_sffma_lib(env, RxV, RsV, RtV, float_muladd_negate_product);
 }
 
 float64 HELPER(dfmpyfix)(CPUHexagonState *env, float64 RssV, float64 RttV)
-- 
2.43.0


