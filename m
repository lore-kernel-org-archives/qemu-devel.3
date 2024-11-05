Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3FBD1268A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbK-0004Va-4N; Tue, 05 Nov 2024 06:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbH-0004UA-Dj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:55 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb7-00075V-1o
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:55 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so47252225e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805582; x=1731410382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gAa7nG8JV8MJXxE6NvLX8mZwE6oSHiLMecKFbVo5vN8=;
 b=mDfpy8dqOX5pF47aDLTTstM4YdSQ3aNKJ0V1Ybe8oZ7yciAW7eC9KkCiWTDJZ20h6o
 mmZ/q5lGkiwkXIn+keq/0lZcbt1FKYTPADdJP5cjG5n5VkC/ow7brjRZJ6gUe5CziZ1B
 /5zjtWdmHJodEAVCx5LNv341pq0jWBG+gaU2MZU4JEN5Ur9mm+RyHzVSUIhBj+haEHnX
 42myPRqBOKv4gOgGkf63BWdhWy5OP5px9D77OkcHuQD8Dn1pzZtNmLJTwfoApU6Sp9BX
 VHn9asWPBN/LVYheZabpQ5hemKeRJpJaMQYh1VIO6NBF00Ii/8oJYW7fTeWnx5NAPSoq
 0i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805582; x=1731410382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAa7nG8JV8MJXxE6NvLX8mZwE6oSHiLMecKFbVo5vN8=;
 b=P2b60Xd7GzI/E3S2M4v4JGgLmA8SUgEh+yfjZDugOSGJqYDzH+owwAIXzWJlbhRwrP
 MvSc5g7LDQFynY3ZLKEcfdHuQ51CWEt1GzecEANBOgluQDJc5RX2hl1m6luSZPqy6gVt
 FNw3/VsdFhI/mQah0rubafSS/bBjCYss8VB+4Yfg2R3SAGJ8rgLuN/6I/2Sx+J/wZMov
 HF1dfts1KZRobMeTR35QRYkNDJacuNEwatAZIvF61PyFD+/4fRldwgrEhWmz0C8Nd/Fj
 jvZqhrf1/im90MqtbOeaSyto6Kjq5POU0MxnRjCvsbUSApgPIodA0MWIgex7nTbbHS1r
 j8tQ==
X-Gm-Message-State: AOJu0YwkiqxMjJtNsM7hP2jkTmVIEmBJnlYe5XQPA1vt+jXuOBvnz7F/
 DggOQuo0T63XhQ8mds/Io7R979YB8onDzhzEvSbVCOi67od5lvM2IBkTbbrm7PgYdxhE1yxAAxL
 v
X-Google-Smtp-Source: AGHT+IHXIIGyjst7XGFfiW0Ea4gyGocZoKmL2KYpzBNPmBZY2ErKMll3qufKEtQonbTmnHu+7Oy1Zg==
X-Received: by 2002:a05:600c:190f:b0:431:6153:a246 with SMTP id
 5b1f17b1804b1-4327b6fd999mr166925635e9.13.1730805582193; 
 Tue, 05 Nov 2024 03:19:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/31] target/ppc: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:12 +0000
Message-Id: <20241105111935.2747034-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Set the 2-NaN propagation rule explicitly in env->fp_status
and env->vec_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-9-peter.maydell@linaro.org
---
 target/ppc/cpu_init.c          |  8 ++++++++
 fpu/softfloat-specialize.c.inc | 10 ++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9f..5c9dcd1f857 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7326,6 +7326,14 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->fp_status);
+    /*
+     * PowerPC propagation rules:
+     *  1. A if it sNaN or qNaN
+     *  2. B if it sNaN or qNaN
+     * A signaling NaN is always silenced before returning it.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
+    set_float_2nan_prop_rule(float_2nan_prop_ab, &env->vec_status);
 
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index a0c740e544d..8e3124c11a6 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -404,15 +404,9 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
-    || defined(TARGET_S390X)
+    || defined(TARGET_S390X) || defined(TARGET_PPC)
         g_assert_not_reached();
-#elif defined(TARGET_PPC) || defined(TARGET_M68K)
-        /*
-         * PowerPC propagation rules:
-         *  1. A if it sNaN or qNaN
-         *  2. B if it sNaN or qNaN
-         * A signaling NaN is always silenced before returning it.
-         */
+#elif defined(TARGET_M68K)
         /*
          * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
          * 3.4 FLOATING-POINT INSTRUCTION DETAILS
-- 
2.34.1


