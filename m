Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89910D0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L48-0004LA-4X; Fri, 25 Oct 2024 10:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L41-0004D9-DL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3t-0007rO-78
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4316e9f4a40so21293275e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865588; x=1730470388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BczarKbZJDxbjH7vD9cLXbmuaONY9kegQ+oAgDMMF9U=;
 b=XKyCwuPgMRD5EESVEuJwYn4wbvkUiQHedOWBLth6UVHgYaoGkpqIlrjZvthKRk8Pwi
 27d9gA84vjU/1Th7GK+rMm+zx+F7sGP0BRkc7KQPczUWhHgwzRIqtBgRNMRciQhV8cIu
 WWwevhjPMGTTBO18ZRwdlrB7WqTUu7KEQjl3wg8eMaOJe7XxJ7eAGgRcGAFcPJX3Y7Zo
 H1kkG1iO+3xS5N83MyWM5JoVUROBc7AOxgwQNVk0Seuga4l0N7v0R9NZOc8+Ts1VNtpW
 WOfh8O5UuseMvNxxmkGdgcBlQi6vmETGjziQP1Hc3HQa4T7d9VcEtxJ2pZZMY5D8m2NF
 EfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865588; x=1730470388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BczarKbZJDxbjH7vD9cLXbmuaONY9kegQ+oAgDMMF9U=;
 b=Llp4FSyR3HPPNRnFccGxw9+wdjFWw9g3BdUnDw/uEg8St+ug57GCLJUzp3WbEMLtTR
 L7kUATDo3sQE3vMOCr0Pelg6UyDnI68ZHcwCqCcKrF1IF+cDVhmG/WymavvWCyxu/nVS
 aj6eDl8uypUVqLf+kcXaYwf/DPpTnllrlR6Yp4TeAdhNupvG7ydqg08+1ObYyEU/2rHd
 XtE3Xu/+KnKEXRAofGzJqHafErbvrtv1CU/f5DiyNGTygqcyv7ETLGjFue2XQSC4jA78
 4wpBR8wm5yNvdDVcEK1miNgg2PS2IcUBTnEY2B8onLVP9PEnT9VgjSKI+CT4vcVgAZ1x
 u4KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgacg4i3fOA6iqry6PS79ZJ/YUyyiAnnZppH3Z9s0BrNK8fK+fy9+2i+VLRVzSz2Ivol2MlsoUZN1K@nongnu.org
X-Gm-Message-State: AOJu0Yxc4SVhbgIGcqppKGpP44BXWqT3+Xqis2nyBH9RXYHxdSn5JWtC
 6+9/dIMjMEIQvDtuGRq0VmwkZx6MwqsgZ5XqqtpGBbRkrFYxk2lzwrENzzBX/Kk=
X-Google-Smtp-Source: AGHT+IGNNUYTl0oSNkkML3EYVg7ubOEefufl3uJ7Hu9oF+87c+QcxlU+fQ+f2iqHE1/Nl7pGgL9vYA==
X-Received: by 2002:a05:600c:1552:b0:42c:b750:1a1e with SMTP id
 5b1f17b1804b1-4318beb62e6mr50079065e9.0.1729865587749; 
 Fri, 25 Oct 2024 07:13:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 13/21] target/xtensa: Factor out calls to set_use_first_nan()
Date: Fri, 25 Oct 2024 15:12:46 +0100
Message-Id: <20241025141254.2141506-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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


