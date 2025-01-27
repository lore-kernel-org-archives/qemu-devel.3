Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3386EC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYV2-0006b4-Qx; Mon, 27 Jan 2025 18:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUn-0006PC-Sx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:23 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUk-0005bd-PP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:20 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso6677529a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020377; x=1738625177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irI8P1SvOCgzRxiQPiYVSipG0XrpLXOcoub7PbBmjSc=;
 b=p0l7aAM0QFI77tgWNLudYX/wZvL1K9uKMZAfndGJzD6NzTGNCySGuBm+PKnvGXbI+H
 XGTIteIXQ5xd5iSh1F4sOIA3h5xwS2WwTofhFPkrA0nIEEEGxXDSmh7KimVBPvcAfhcH
 Ul0HAvZ2u+QMSi9/mOMIiU7Amt7PahooMM1RdGZ0qYu9FyuZBNSg8bVLV9/3GmBiRCqp
 crDl0rrG0xHLCGmBXlt650Khms+Q1WxOHFtZYUOQyhmopSFOimSoiB1leQVzX4XNMOQT
 fKduoqyg0BGL3xF8Zii1E2SEtZ7VIVUABrbDEozLGeyvVfPBD3LsISvtQ2VS4ZUjAGmT
 cakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020377; x=1738625177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irI8P1SvOCgzRxiQPiYVSipG0XrpLXOcoub7PbBmjSc=;
 b=XJrhwD+wlMqynGbcXM+zrZBMVxt9IvGJyzYR7C+gWQnfXkc91GPr6s6EYVONir5nDt
 CSvUZMZxmQAVn17iuIpH6xGJRCv87H72FoXV9/YsfyVn+fkURty+3aNdyDPUG2bygQRM
 zeNb5RjHh2b+jR7LZrEAVLw1SO1jYMyLAXXIu/ZtHovUgdbYlTP/dUw683sJ7UgOvvnb
 pil/zMB1+We+N1lZ2ppIzCtuTbT2CLYJHRIRWZo4J92fyngL9R0rCP56ySdQqDxLTKk4
 d9j5TXnrHuxIJFbJiFTtrzdVysOKM4aZbtezlgTuOOFsk8io6v6p22T774REYLJgKOzZ
 VO/g==
X-Gm-Message-State: AOJu0YznpjAq3iNxXvdxTgoFc4ZZab50a99WHJIx5cBTNMP6n46ezVDY
 n/y6VSzl8zpE0R88IEaMXmuNYJlTGK5IlF2W0MOqjKYREqvDs/K2gCQO3iXCBtKE+76jsegcGnx
 K
X-Gm-Gg: ASbGnctLGztriOHi6+Xi4CR+wkxjUWYU/hmydjoRUGc29DG8KlPyA9Ww/Hvf5MHv72j
 sNqqey6fnHB7Vue2yzrVB8tmYSBD0neB7wwh7WFVBLo4N3awllh7U/JOhMsUxirfp/umD0bXZKP
 nTI8bCL2gVAUuaJOqenCUYUMxJ0G4J9TLMqIS+OzIuTRphjs7Ae7wdfXwzVlyVjdHEqssNaQVgy
 Evfp7ZAvzq7vqO1sw2FgdzUZI2vypwj+nFn5IWMVTuFuyztUy3eF8q5d3JyWfh+cFbtv5EMfUqg
 0RVfH3JX6R6lM6mWnZ1csx1V0GDCkCniOoWT+WE=
X-Google-Smtp-Source: AGHT+IFSmjYO2G9ZguIpPRZJ/fGCXcDc4Ru/ONOpL6ZvEtht6d37sXuciu1w7n7QlWBif3UVNqXs0g==
X-Received: by 2002:a17:90b:540d:b0:2ea:3f34:f190 with SMTP id
 98e67ed59e1d1-2f782d36025mr59846369a91.25.1738020377423; 
 Mon, 27 Jan 2025 15:26:17 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 14/22] target/arm: Remove fp_status_a32
Date: Mon, 27 Jan 2025 15:25:56 -0800
Message-ID: <20250127232604.20386-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace with fp_status[FPST_A32].  As this was the last of the
old structures, we can remove the anonymous union and struct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h        |  7 +------
 target/arm/cpu.c        |  2 +-
 target/arm/vfp_helper.c | 18 +++++++++---------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 05a58de045..e6513ef1e5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -687,12 +687,7 @@ typedef struct CPUArchState {
         uint32_t scratch[8];
 
         /* There are a number of distinct float control structures. */
-        union {
-            float_status fp_status[FPST_COUNT];
-            struct {
-                float_status fp_status_a32;
-            };
-        };
+        float_status fp_status[FPST_COUNT];
 
         uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
         uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 777e5f5dd8..180e11c5d7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -550,7 +550,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index e0d0623097..a2775a2e8d 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -117,7 +117,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
     uint32_t a32_flags = 0, a64_flags = 0;
 
-    a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_A32]);
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
     /* FZ16 does not generate an input denormal exception.  */
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A32_F16])
@@ -153,7 +153,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      * values. The caller should have arranged for env->vfp.fpsr to
      * be the architecturally up-to-date exception flag information first.
      */
-    set_float_exception_flags(0, &env->vfp.fp_status_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
@@ -196,7 +196,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             i = float_round_to_zero;
             break;
         }
-        set_float_rounding_mode(i, &env->vfp.fp_status_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
@@ -214,10 +214,10 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
         /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
     }
     if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
         /*
@@ -230,7 +230,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
@@ -495,8 +495,8 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
 DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status[FPST_A32_F16])
-DO_VFP_cmp(s, float32, float32, fp_status_a32)
-DO_VFP_cmp(d, float64, float64, fp_status_a32)
+DO_VFP_cmp(s, float32, float32, fp_status[FPST_A32])
+DO_VFP_cmp(d, float64, float64, fp_status[FPST_A32])
 #undef DO_VFP_cmp
 
 /* Integer to float and float to integer conversions */
@@ -1383,7 +1383,7 @@ uint64_t HELPER(fjcvtzs)(float64 value, float_status *status)
 
 uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
 {
-    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status_a32);
+    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status[FPST_A32]);
     uint32_t result = pair;
     uint32_t z = (pair >> 32) == 0;
 
-- 
2.43.0


