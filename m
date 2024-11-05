Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2996ED1268B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbM-0004X7-VB; Tue, 05 Nov 2024 06:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbJ-0004V7-7u
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb9-00076C-KB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:56 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso43681035e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805585; x=1731410385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OblJVNrVRdiqCsRdbj7zFz9kFn0JIzHW6PAymqxC+rA=;
 b=SSxRxscLSli4bZwkW4fQr4ak5TXcF8Wu3ZtXxuKynLCYecD9QrFgXeZr3tZxLe3qZU
 dqfTmjGDZ+R8b9EAvN8coKMc0spR7qg77SBLlW9VHAawVOz/YI8OLbK5fDlC0hZDebNi
 TGZAAiVoATCO+Tm+hTG+Eq/F+1XcWzFVd8CS8Dw3TcnvUDgneKRRjQfKs/72zIICVDVh
 REmeV3qkMLwt3jwWOIpHmvU+Nl4K7uMoLoObY87+2oiss43TyyXbyI4MkItWup87CfcB
 ejXkD50l/eMCxrtC6hRYrSbI3yVuS36Bi2Qv39eo0q55OPi7WXmaAUvQVBNcjw2yuKGY
 MStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805585; x=1731410385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OblJVNrVRdiqCsRdbj7zFz9kFn0JIzHW6PAymqxC+rA=;
 b=p12qhTtN8yjPEgbZvlK97TDfzwxIkG2D1V5Klb7HLPAYe0b3dipkNtxUHTYswxh6SP
 m5tQE3APBIh5ASzk0tnn9G4Utlg8k6JiBCs4roWZHGqOQvcgIgqpfFGpyqAYaR1SuHU/
 n6lJemQtzMK+lNXUWb2NRJ18VYV/sjX5pSmVS8IT9D9HuqjJiCaNCU6YESKWKabm5RLp
 LWb7xRqU1eupqLwP1xeoGNigdB4tX0RgpDxAcOKYQBjni1PVgi1eSxwt69cXudX/r0x5
 4ycrE5pm8cWeU+ZAG24UmWFwhZtGUsZufNKnoxVPaM6NFqv+WbCut7mBHkwEZjVkW6Wd
 Fr+g==
X-Gm-Message-State: AOJu0Yw1RM5Aw+b5wW3DFGsT5tuR+7JRZnyFprfnni61brlzmT0yPL+6
 fK+082NYunLWUKj6EhieRHWLaMwN5ZdJ2uKlgzgRj+IMC8RCXD55RQdjGUMWlbcR9eYg+Vy44KZ
 2
X-Google-Smtp-Source: AGHT+IFYrKiadGITU6TXJdjXlbF57kQb895A3Ogu4PVIWkJQxzsrum4CHRAt4R2xz153/GDFkzR/eA==
X-Received: by 2002:a05:600c:46c8:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-4319acb17a9mr329516995e9.16.1730805584815; 
 Tue, 05 Nov 2024 03:19:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/31] target/xtensa: Factor out calls to set_use_first_nan()
Date: Tue,  5 Nov 2024 11:19:17 +0000
Message-Id: <20241105111935.2747034-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

In xtensa we currently call set_use_first_nan() in a lot of
places where we want to switch the NaN-propagation handling.
We're about to change the softfloat API we use to do that,
so start by factoring all the calls out into a single
xtensa_use_first_nan() function.

The bulk of this change was done with
 sed -i -e 's/set_use_first_nan(\([^,]*\),[^)]*)/xtensa_use_first_nan(env, \1)/'  target/xtensa/fpu_helper.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-14-peter.maydell@linaro.org
---
 target/xtensa/cpu.h        |  6 ++++++
 target/xtensa/cpu.c        |  2 +-
 target/xtensa/fpu_helper.c | 33 +++++++++++++++++++--------------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 9f2341d8563..77e48eef19c 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -802,4 +802,10 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
 XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type,
                                         Clock *cpu_refclk);
 
+/*
+ * Set the NaN propagation rule for future FPU operations:
+ * use_first is true to pick the first NaN as the result if both
+ * inputs are NaNs, false to pick the second.
+ */
+void xtensa_use_first_nan(CPUXtensaState *env, bool use_first);
 #endif
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a08c7a0b1f2..6f9039abaee 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -134,7 +134,7 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
     cs->halted = env->runstall;
 #endif
     set_no_signaling_nans(!dfpu, &env->fp_status);
-    set_use_first_nan(!dfpu, &env->fp_status);
+    xtensa_use_first_nan(env, !dfpu);
 }
 
 static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 381e83ded83..50a5efa65e2 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -57,6 +57,11 @@ static const struct {
     { XTENSA_FP_V, float_flag_invalid, },
 };
 
+void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
+{
+    set_use_first_nan(use_first, &env->fp_status);
+}
+
 void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
 {
     static const int rounding_mode[] = {
@@ -171,87 +176,87 @@ float32 HELPER(fpu2k_msub_s)(CPUXtensaState *env,
 
 float64 HELPER(add_d)(CPUXtensaState *env, float64 a, float64 b)
 {
-    set_use_first_nan(true, &env->fp_status);
+    xtensa_use_first_nan(env, true);
     return float64_add(a, b, &env->fp_status);
 }
 
 float32 HELPER(add_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    xtensa_use_first_nan(env, env->config->use_first_nan);
     return float32_add(a, b, &env->fp_status);
 }
 
 float64 HELPER(sub_d)(CPUXtensaState *env, float64 a, float64 b)
 {
-    set_use_first_nan(true, &env->fp_status);
+    xtensa_use_first_nan(env, true);
     return float64_sub(a, b, &env->fp_status);
 }
 
 float32 HELPER(sub_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    xtensa_use_first_nan(env, env->config->use_first_nan);
     return float32_sub(a, b, &env->fp_status);
 }
 
 float64 HELPER(mul_d)(CPUXtensaState *env, float64 a, float64 b)
 {
-    set_use_first_nan(true, &env->fp_status);
+    xtensa_use_first_nan(env, true);
     return float64_mul(a, b, &env->fp_status);
 }
 
 float32 HELPER(mul_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    xtensa_use_first_nan(env, env->config->use_first_nan);
     return float32_mul(a, b, &env->fp_status);
 }
 
 float64 HELPER(madd_d)(CPUXtensaState *env, float64 a, float64 b, float64 c)
 {
-    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    xtensa_use_first_nan(env, env->config->use_first_nan);
     return float64_muladd(b, c, a, 0, &env->fp_status);
 }
 
 float32 HELPER(madd_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
 {
-    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    xtensa_use_first_nan(env, env->config->use_first_nan);
     return float32_muladd(b, c, a, 0, &env->fp_status);
 }
 
 float64 HELPER(msub_d)(CPUXtensaState *env, float64 a, float64 b, float64 c)
 {
-    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    xtensa_use_first_nan(env, env->config->use_first_nan);
     return float64_muladd(b, c, a, float_muladd_negate_product,
                           &env->fp_status);
 }
 
 float32 HELPER(msub_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
 {
-    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    xtensa_use_first_nan(env, env->config->use_first_nan);
     return float32_muladd(b, c, a, float_muladd_negate_product,
                           &env->fp_status);
 }
 
 float64 HELPER(mkdadj_d)(CPUXtensaState *env, float64 a, float64 b)
 {
-    set_use_first_nan(true, &env->fp_status);
+    xtensa_use_first_nan(env, true);
     return float64_div(b, a, &env->fp_status);
 }
 
 float32 HELPER(mkdadj_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    xtensa_use_first_nan(env, env->config->use_first_nan);
     return float32_div(b, a, &env->fp_status);
 }
 
 float64 HELPER(mksadj_d)(CPUXtensaState *env, float64 v)
 {
-    set_use_first_nan(true, &env->fp_status);
+    xtensa_use_first_nan(env, true);
     return float64_sqrt(v, &env->fp_status);
 }
 
 float32 HELPER(mksadj_s)(CPUXtensaState *env, float32 v)
 {
-    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    xtensa_use_first_nan(env, env->config->use_first_nan);
     return float32_sqrt(v, &env->fp_status);
 }
 
-- 
2.34.1


