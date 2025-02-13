Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C418FC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaAb-0004UA-G5; Thu, 13 Feb 2025 09:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAZ-0004TV-Os
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:24 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAX-0006nJ-AE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:23 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dc0cd94a6so520339f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739456780; x=1740061580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdbBccgNA9iD9ywHMcl4sf5pFjIJuIWSjvGN9CQVHH8=;
 b=hyDBOET7k6XIAVP4BjPI4cOX0wTucJVI4Km2Ynk8fUlGsrlHbAmhU0IczZIMsyo+aV
 +2erte1Iau7r3sZE+WWlgNiRWYy7p/FHbK6+FcIAz/AhLkSlidAaMdSO7GJVl8KomUC9
 hhonK9XIIZPLwKTrpOAqX2ZKIgRoWzytewYOBttA7qWBX1a2ncMVv+cIu1OTP2MrCX6P
 BdrkXY9WbTkAgMqeWnTYqd7rmAAEPBrB0nO6YWBQUjZoB6yyPnB2aTrK8eDzUOVHhS66
 9qlooSTvxeLcp5YXF1q+mdscSGN2QpXRYLE6KKxnFo8kLYLm1SDvhxdZxzqanSG2lldr
 zOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456780; x=1740061580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdbBccgNA9iD9ywHMcl4sf5pFjIJuIWSjvGN9CQVHH8=;
 b=rCKm+wbpc40CAESZ1GwkSu9hROpZbpUxVR62liRCg0I5CFr317j7xO9HO0uH1JTuKe
 q72BzX+hJCU+RNoYVVjZQiz9aXHumhuZ9DQTCikMO+SVpn0DY42FQ98KuIRn3mPyaMxt
 KxXVvCNXSJ+o/86fZw8r95GnHRwpfHwLdGq1Wuihk07TupgPjmuqOpStxcqlmu1+/6yJ
 TzxkH3YdLmvb7H3URd3wyseV7Fa+rIRR8LkHnvGE/TMJ8gy7Q39+9g1wKQcYLcg1t1Q9
 ONdJfbVPpILprV7HU2XhC7ieyuCIo1c/0rVQzjQ1WHoG7t635bUmUF0PO/iPz5tmgp9E
 //2Q==
X-Gm-Message-State: AOJu0YxmLAWZHJszZo9wNKvYL/r8O4aD0OhOn/VtEYlrz3r1B32dlLIz
 /jdxrYqxdYYrV1ezBxGRaXthnSX6UwlqCFgdmB+nb6ugYysVoGbaSjYEz/KGiNe2Gu/FSPFAUEF
 P
X-Gm-Gg: ASbGncuVTgeCXS+Jm1yeoOwzP5Yj5TiWsyYwji+AheaVJBBchIlZDQb79ePDBZZozlT
 S73d4Xszj6zNcEBgWpuFwgl6EtPWav6NyaYNxw7tT7q3dr+T0r3eGRfXBWZ7cOG0VexIFhcXq5h
 lyBtCAF5SysmKqlfAVG2E4qMREWOt/AbLx1KIpsbSwma8DdMBYcQuEFpLRlKaoYaj8i0TkSThlw
 rUUcqVXkifDB3PkNx39y0dQFmVeU0+GI5YiV8MxZQfOv7iBE+4YUQr4tpZ7mm6NYl0bGWSjHVkp
 cnNGWde6jm0mfSLq4huQdA==
X-Google-Smtp-Source: AGHT+IFCv/LpWJZ35XO+nPYxqsXyt6Ma4fU65mEUjPkkvqpihUgDvDmg9/nF26plWMteWjrFWc4gtg==
X-Received: by 2002:a05:6000:154c:b0:38d:df70:23e7 with SMTP id
 ffacd0b85a97d-38f245035f5mr3358807f8f.31.1739456779690; 
 Thu, 13 Feb 2025 06:26:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4335sm2093604f8f.15.2025.02.13.06.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:26:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 2/4] target/i386: Use correct type for
 get_float_exception_flags() values
Date: Thu, 13 Feb 2025 14:26:11 +0000
Message-ID: <20250213142613.151308-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213142613.151308-1-peter.maydell@linaro.org>
References: <20250213142613.151308-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The softfloat get_float_exception_flags() function returns 'int', but
in various places in target/i386 we incorrectly store the returned
value into a uint8_t.  This currently has no ill effects because i386
doesn't care about any of the float_flag enum values above 0x40.
However, we want to start using float_flag_input_denormal_used, which
is 0x4000.

Switch to using 'int' so that we can handle all the possible valid
float_flag_* values. This includes changing the return type of
save_exception_flags() and the argument to merge_exception_flags().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h        | 16 +++----
 target/i386/tcg/fpu_helper.c | 82 ++++++++++++++++++------------------
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index f0aa1894aa2..a2e4d480399 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -842,7 +842,7 @@ int64_t helper_cvttsd2sq(CPUX86State *env, ZMMReg *s)
 
 void glue(helper_rsqrtps, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
-    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
+    int old_flags = get_float_exception_flags(&env->sse_status);
     int i;
     for (i = 0; i < 2 << SHIFT; i++) {
         d->ZMM_S(i) = float32_div(float32_one,
@@ -855,7 +855,7 @@ void glue(helper_rsqrtps, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 #if SHIFT == 1
 void helper_rsqrtss(CPUX86State *env, ZMMReg *d, ZMMReg *v, ZMMReg *s)
 {
-    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
+    int old_flags = get_float_exception_flags(&env->sse_status);
     int i;
     d->ZMM_S(0) = float32_div(float32_one,
                               float32_sqrt(s->ZMM_S(0), &env->sse_status),
@@ -869,7 +869,7 @@ void helper_rsqrtss(CPUX86State *env, ZMMReg *d, ZMMReg *v, ZMMReg *s)
 
 void glue(helper_rcpps, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
-    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
+    int old_flags = get_float_exception_flags(&env->sse_status);
     int i;
     for (i = 0; i < 2 << SHIFT; i++) {
         d->ZMM_S(i) = float32_div(float32_one, s->ZMM_S(i), &env->sse_status);
@@ -880,7 +880,7 @@ void glue(helper_rcpps, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 #if SHIFT == 1
 void helper_rcpss(CPUX86State *env, ZMMReg *d, ZMMReg *v, ZMMReg *s)
 {
-    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
+    int old_flags = get_float_exception_flags(&env->sse_status);
     int i;
     d->ZMM_S(0) = float32_div(float32_one, s->ZMM_S(0), &env->sse_status);
     for (i = 1; i < 2 << SHIFT; i++) {
@@ -1714,7 +1714,7 @@ void glue(helper_phminposuw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 void glue(helper_roundps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
-    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
+    int old_flags = get_float_exception_flags(&env->sse_status);
     signed char prev_rounding_mode;
     int i;
 
@@ -1738,7 +1738,7 @@ void glue(helper_roundps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
 void glue(helper_roundpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
-    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
+    int old_flags = get_float_exception_flags(&env->sse_status);
     signed char prev_rounding_mode;
     int i;
 
@@ -1763,7 +1763,7 @@ void glue(helper_roundpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
 void glue(helper_roundss, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   uint32_t mode)
 {
-    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
+    int old_flags = get_float_exception_flags(&env->sse_status);
     signed char prev_rounding_mode;
     int i;
 
@@ -1788,7 +1788,7 @@ void glue(helper_roundss, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
 void glue(helper_roundsd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   uint32_t mode)
 {
-    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
+    int old_flags = get_float_exception_flags(&env->sse_status);
     signed char prev_rounding_mode;
     int i;
 
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 87fbc149d84..cd965a1f582 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -198,16 +198,16 @@ void cpu_init_fp_statuses(CPUX86State *env)
     set_float_ftz_detection(float_ftz_after_rounding, &env->sse_status);
 }
 
-static inline uint8_t save_exception_flags(CPUX86State *env)
+static inline int save_exception_flags(CPUX86State *env)
 {
-    uint8_t old_flags = get_float_exception_flags(&env->fp_status);
+    int old_flags = get_float_exception_flags(&env->fp_status);
     set_float_exception_flags(0, &env->fp_status);
     return old_flags;
 }
 
-static void merge_exception_flags(CPUX86State *env, uint8_t old_flags)
+static void merge_exception_flags(CPUX86State *env, int old_flags)
 {
-    uint8_t new_flags = get_float_exception_flags(&env->fp_status);
+    int new_flags = get_float_exception_flags(&env->fp_status);
     float_raise(old_flags, &env->fp_status);
     fpu_set_exception(env,
                       ((new_flags & float_flag_invalid ? FPUS_IE : 0) |
@@ -220,7 +220,7 @@ static void merge_exception_flags(CPUX86State *env, uint8_t old_flags)
 
 static inline floatx80 helper_fdiv(CPUX86State *env, floatx80 a, floatx80 b)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     floatx80 ret = floatx80_div(a, b, &env->fp_status);
     merge_exception_flags(env, old_flags);
     return ret;
@@ -240,7 +240,7 @@ static void fpu_raise_exception(CPUX86State *env, uintptr_t retaddr)
 
 void helper_flds_FT0(CPUX86State *env, uint32_t val)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     union {
         float32 f;
         uint32_t i;
@@ -253,7 +253,7 @@ void helper_flds_FT0(CPUX86State *env, uint32_t val)
 
 void helper_fldl_FT0(CPUX86State *env, uint64_t val)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     union {
         float64 f;
         uint64_t i;
@@ -271,7 +271,7 @@ void helper_fildl_FT0(CPUX86State *env, int32_t val)
 
 void helper_flds_ST0(CPUX86State *env, uint32_t val)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int new_fpstt;
     union {
         float32 f;
@@ -288,7 +288,7 @@ void helper_flds_ST0(CPUX86State *env, uint32_t val)
 
 void helper_fldl_ST0(CPUX86State *env, uint64_t val)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int new_fpstt;
     union {
         float64 f;
@@ -338,7 +338,7 @@ void helper_fildll_ST0(CPUX86State *env, int64_t val)
 
 uint32_t helper_fsts_ST0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     union {
         float32 f;
         uint32_t i;
@@ -351,7 +351,7 @@ uint32_t helper_fsts_ST0(CPUX86State *env)
 
 uint64_t helper_fstl_ST0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     union {
         float64 f;
         uint64_t i;
@@ -364,7 +364,7 @@ uint64_t helper_fstl_ST0(CPUX86State *env)
 
 int32_t helper_fist_ST0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int32_t val;
 
     val = floatx80_to_int32(ST0, &env->fp_status);
@@ -378,7 +378,7 @@ int32_t helper_fist_ST0(CPUX86State *env)
 
 int32_t helper_fistl_ST0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int32_t val;
 
     val = floatx80_to_int32(ST0, &env->fp_status);
@@ -391,7 +391,7 @@ int32_t helper_fistl_ST0(CPUX86State *env)
 
 int64_t helper_fistll_ST0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int64_t val;
 
     val = floatx80_to_int64(ST0, &env->fp_status);
@@ -404,7 +404,7 @@ int64_t helper_fistll_ST0(CPUX86State *env)
 
 int32_t helper_fistt_ST0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int32_t val;
 
     val = floatx80_to_int32_round_to_zero(ST0, &env->fp_status);
@@ -418,7 +418,7 @@ int32_t helper_fistt_ST0(CPUX86State *env)
 
 int32_t helper_fisttl_ST0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int32_t val;
 
     val = floatx80_to_int32_round_to_zero(ST0, &env->fp_status);
@@ -431,7 +431,7 @@ int32_t helper_fisttl_ST0(CPUX86State *env)
 
 int64_t helper_fisttll_ST0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int64_t val;
 
     val = floatx80_to_int64_round_to_zero(ST0, &env->fp_status);
@@ -527,7 +527,7 @@ static const int fcom_ccval[4] = {0x0100, 0x4000, 0x0000, 0x4500};
 
 void helper_fcom_ST0_FT0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
@@ -537,7 +537,7 @@ void helper_fcom_ST0_FT0(CPUX86State *env)
 
 void helper_fucom_ST0_FT0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
@@ -549,7 +549,7 @@ static const int fcomi_ccval[4] = {CC_C, CC_Z, 0, CC_Z | CC_P | CC_C};
 
 void helper_fcomi_ST0_FT0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int eflags;
     FloatRelation ret;
 
@@ -562,7 +562,7 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
 
 void helper_fucomi_ST0_FT0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int eflags;
     FloatRelation ret;
 
@@ -575,28 +575,28 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
 
 void helper_fadd_ST0_FT0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     ST0 = floatx80_add(ST0, FT0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
 void helper_fmul_ST0_FT0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     ST0 = floatx80_mul(ST0, FT0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
 void helper_fsub_ST0_FT0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     ST0 = floatx80_sub(ST0, FT0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
 void helper_fsubr_ST0_FT0(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     ST0 = floatx80_sub(FT0, ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
@@ -615,28 +615,28 @@ void helper_fdivr_ST0_FT0(CPUX86State *env)
 
 void helper_fadd_STN_ST0(CPUX86State *env, int st_index)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_add(ST(st_index), ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
 void helper_fmul_STN_ST0(CPUX86State *env, int st_index)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_mul(ST(st_index), ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
 void helper_fsub_STN_ST0(CPUX86State *env, int st_index)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_sub(ST(st_index), ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
 void helper_fsubr_STN_ST0(CPUX86State *env, int st_index)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_sub(ST0, ST(st_index), &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
@@ -861,7 +861,7 @@ void helper_fbld_ST0(CPUX86State *env, target_ulong ptr)
 
 void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     int v;
     target_ulong mem_ref, mem_end;
     int64_t val;
@@ -1136,7 +1136,7 @@ static const struct f2xm1_data f2xm1_table[65] = {
 
 void helper_f2xm1(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     uint64_t sig = extractFloatx80Frac(ST0);
     int32_t exp = extractFloatx80Exp(ST0);
     bool sign = extractFloatx80Sign(ST0);
@@ -1369,7 +1369,7 @@ static const struct fpatan_data fpatan_table[9] = {
 
 void helper_fpatan(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     uint64_t arg0_sig = extractFloatx80Frac(ST0);
     int32_t arg0_exp = extractFloatx80Exp(ST0);
     bool arg0_sign = extractFloatx80Sign(ST0);
@@ -1806,7 +1806,7 @@ void helper_fpatan(CPUX86State *env)
 
 void helper_fxtract(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     CPU_LDoubleU temp;
 
     temp.d = ST0;
@@ -1855,7 +1855,7 @@ void helper_fxtract(CPUX86State *env)
 
 static void helper_fprem_common(CPUX86State *env, bool mod)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     uint64_t quotient;
     CPU_LDoubleU temp0, temp1;
     int exp0, exp1, expdiff;
@@ -2050,7 +2050,7 @@ static void helper_fyl2x_common(CPUX86State *env, floatx80 arg, int32_t *exp,
 
 void helper_fyl2xp1(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     uint64_t arg0_sig = extractFloatx80Frac(ST0);
     int32_t arg0_exp = extractFloatx80Exp(ST0);
     bool arg0_sign = extractFloatx80Sign(ST0);
@@ -2148,7 +2148,7 @@ void helper_fyl2xp1(CPUX86State *env)
 
 void helper_fyl2x(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     uint64_t arg0_sig = extractFloatx80Frac(ST0);
     int32_t arg0_exp = extractFloatx80Exp(ST0);
     bool arg0_sign = extractFloatx80Sign(ST0);
@@ -2295,7 +2295,7 @@ void helper_fyl2x(CPUX86State *env)
 
 void helper_fsqrt(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     if (floatx80_is_neg(ST0)) {
         env->fpus &= ~0x4700;  /* (C3,C2,C1,C0) <-- 0000 */
         env->fpus |= 0x400;
@@ -2321,14 +2321,14 @@ void helper_fsincos(CPUX86State *env)
 
 void helper_frndint(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     ST0 = floatx80_round_to_int(ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
 void helper_fscale(CPUX86State *env)
 {
-    uint8_t old_flags = save_exception_flags(env);
+    int old_flags = save_exception_flags(env);
     if (floatx80_invalid_encoding(ST1) || floatx80_invalid_encoding(ST0)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
@@ -2366,7 +2366,7 @@ void helper_fscale(CPUX86State *env)
     } else {
         int n;
         FloatX80RoundPrec save = env->fp_status.floatx80_rounding_precision;
-        uint8_t save_flags = get_float_exception_flags(&env->fp_status);
+        int save_flags = get_float_exception_flags(&env->fp_status);
         set_float_exception_flags(0, &env->fp_status);
         n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
         set_float_exception_flags(save_flags, &env->fp_status);
@@ -3266,7 +3266,7 @@ void update_mxcsr_status(CPUX86State *env)
 
 void update_mxcsr_from_sse_status(CPUX86State *env)
 {
-    uint8_t flags = get_float_exception_flags(&env->sse_status);
+    int flags = get_float_exception_flags(&env->sse_status);
     /*
      * The MXCSR denormal flag has opposite semantics to
      * float_flag_input_denormal_flushed (the softfloat code sets that flag
-- 
2.43.0


