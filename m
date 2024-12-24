Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DC2E7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBEC-0003cw-3u; Tue, 24 Dec 2024 15:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDb-0007GO-Tt
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:28 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDa-0002zt-6D
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:27 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21636268e43so70684755ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070965; x=1735675765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBCIoQniDOPCXed8/3lUiDnf86jkv18W9RdRy76zZxA=;
 b=EpHfixSyo8Faa66pziac9HuCTWLYbZrwKwE+1+DQKqGgfzNCo0MEyqVYMrVc0jF2LN
 N8hDBUFA/B5xTo2yF6oXxlK/TF70sDw1FDGf4rKP+gIXTMGdPu4JkWjDqxOpQIxwgVFT
 kGCuiVQeDCY8MaCqM5tMBwF4qC4HbmFEpcansymcC9I3TKgBVBNRQ50Zs82fvxAO6Tf+
 eutoD+ms8bE/HeYsCPGutqCYb5DpJ9dCy4r4zhcJTilMrHn9oEAjUy7V+jjTKxYr0qmA
 zMB8xgmAB8koaW6ZocK4qHVklowdO7DoJMKsQvmkwja7vWRtr/6yHFpPUvpofYf/6Onc
 gPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070965; x=1735675765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBCIoQniDOPCXed8/3lUiDnf86jkv18W9RdRy76zZxA=;
 b=GpvF71tyVDeHW6pDcfHSoIY6lyeJWwQ/cCVZ793t7l4ErNnZdjXjaZI9zoFSx+89kB
 8fBkuiKWhNciYVITuvb2xynnouP65kujfV5oWSVYGVWJY/eCYpR9vTol9qlih0a7fRzU
 qU+1nGCx29RaPkJyINaCAcYoNnib+4p/ufbHTUfkWsAI2p7sllAdV54yg0DVrJT+xXZ0
 IGpllbO8iTRfMFRNlQ5FxW1NNHnxUOCVXXmHhYiIIw9o/peC7UUivFvbhUQeHSSq6OF6
 M/uN6d21QtYBkxlHx3AVWRQyvfwG9gwba7bm+Y1Aaik51pE1Iz8hqFY2tz1SVm/emwuJ
 r0TA==
X-Gm-Message-State: AOJu0YxZYfckSUcHJfu++/uEdgBFb2J6IT+AtEoV/oKKOMzzmAafAZJr
 b+j4siBBVXrK4vhT7e8QO/PrqEf0QHzbYYpuBAsX/85fc/u+FQQ5YaPq5xXedJBpknH9SVxntIi
 SZqY=
X-Gm-Gg: ASbGncvjpxdV5kdn7/Yy2miZCm9XW/2oQTJumjtUAyQgG6ZsR2tBX5kVqGjUhClqRe2
 rGBSzKJtxZdmeLzYJ9hYMjf9lvQEtBBdwXqAX5jg4PZ3lRO/GPyFFaxzP9Xza8c1z5t5GnTIaSO
 aCY4b+H38Z/X8P7tfpXbG9xxBZ6V63O2zwq735LBfYQAu1GVHt5cdhULaUv6B9P+GTV/hcM9uaY
 w1oYZ9mhjVLasAirqbJOyEZDqEmyWjf11rNiTca475Q3a9ywVMxjanTnPyPB4h6pTefadctmsxu
 lS6FMt7ajJP0vdhyE0TzwHiZwQ==
X-Google-Smtp-Source: AGHT+IFpT5SJ5/A+GrfOeoK7DQ6JA+b4lWcJPELegzK02zTEKK1ip+FpOUq/IypTa+u+VGNAO1r4Rw==
X-Received: by 2002:a05:6a20:6f06:b0:1e1:9ba5:80d8 with SMTP id
 adf61e73a8af0-1e5e080df22mr25488906637.33.1735070965000; 
 Tue, 24 Dec 2024 12:09:25 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 65/72] target/hexagon: Use float32_muladd for
 helper_sffm[as]_lib
Date: Tue, 24 Dec 2024 12:05:14 -0800
Message-ID: <20241224200521.310066-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/op_helper.c | 105 +++++++++----------------------------
 1 file changed, 26 insertions(+), 79 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 53c65e852e..6da8db8ea5 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1059,24 +1059,6 @@ float32 HELPER(sffma)(CPUHexagonState *env, float32 RxV,
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
@@ -1098,78 +1080,43 @@ float32 HELPER(sffms)(CPUHexagonState *env, float32 RxV,
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


