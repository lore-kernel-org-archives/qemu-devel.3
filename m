Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E83D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbA-0004RV-Kl; Tue, 05 Nov 2024 06:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb8-0004Qo-HM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:46 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb5-000754-AH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:46 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539fe76e802so6123558e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805580; x=1731410380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xz2c4FWC4m4OfIHVNBzr5/hraJmE26SETciSZUO8ixw=;
 b=Usod8TzeFkKfK+aRAsfSVlW2Npskf6cNUQdOpU5/eFkhoWfClPtIEtrE1u9zSXzLpT
 TutL2nGv26mAatEZHeE026H7S+yrd4YKU86vDC2S+dUaUOV5i8+YTAP+bpcmgaHlJE/4
 3kvh8ERFjE83voM9RF02p7n6XiW1OLloxpsey1rtWPeB+EPrmaLbbqLBgrqvB1uF4TS/
 dquHfsVYMi9VAPOlLXt/nphJS+2iTUdM0SvEO/X3xm2zP+3r5uVkitedgbW/AmRdmM/X
 I06/2CusmXPwk71+B7fZY0KTfVomSLDITenuk0wnx9n9H8ub5FrBoLi5tBaeuPdrSz2/
 rR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805580; x=1731410380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xz2c4FWC4m4OfIHVNBzr5/hraJmE26SETciSZUO8ixw=;
 b=t1IbQdximgOCxQt041mTLyHci/7DEZSYGW8eQkc/IuF3FM9q6C8KoUtiAWFyxDLwde
 AyA18l2ihWnD8f+h+GkhHr9NJBY+RONlAp7AxEAGxqaJ3GAq6LuPfCj0floWRYlzrhZZ
 YkBa0DrOpRy/q+Qp6+M3pdeebnWBbMbmpttHyC1FxUYRSRQqPL7GOSy/i+2MhBYHFzhp
 Gxcd7dJIh22w6zsoaVO6fykxdpWaqNqFsFHJvvcD3uGPreZ/B+7JgDcDOpK0WNqGqf7y
 XjBBJ/9X17CZ+//Xafytjd2g/YHOKW1FrM5bWcG87IdWRoDPPe/A1BmkHNkA2oRa0Ola
 nf4w==
X-Gm-Message-State: AOJu0YyhYQshjvrfjSUTY9xOebjabV9WUVR0pN+JCwnlIpC0EWtQf8gS
 oSZ38YOMxCRifD1FbHB19JamQLafdjwwQr30qH9Pxs/ByWn+7nQLTLuWOISEulcMmmx4wlU4E+C
 4
X-Google-Smtp-Source: AGHT+IGvBwMDyXDdguNux4vrMti8kgjqpW+XGtn5IzjCOZ/ZyZHa0opJsVHJ63ISIcd0yOaVtG1uWA==
X-Received: by 2002:a05:6512:b11:b0:535:d4e9:28bf with SMTP id
 2adb3069b0e04-53d65e12357mr7811286e87.46.1730805580065; 
 Tue, 05 Nov 2024 03:19:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/31] target/mips: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:08 +0000
Message-Id: <20241105111935.2747034-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

Set the 2-NaN propagation rule explicitly in the float_status words
we use.

For active_fpu.fp_status, we do this in a new fp_reset() function
which mirrors the existing msa_reset() function in doing "first call
restore to set the fp status parts that depend on CPU state, then set
the fp status parts that are constant".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241025141254.2141506-5-peter.maydell@linaro.org
---
 target/mips/fpu_helper.h       | 22 ++++++++++++++++++++++
 target/mips/cpu.c              |  2 +-
 target/mips/msa.c              | 17 +++++++++++++++++
 fpu/softfloat-specialize.c.inc | 18 ++----------------
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index ad1116e8c10..7c3c7897b45 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -44,6 +44,28 @@ static inline void restore_fp_status(CPUMIPSState *env)
     restore_snan_bit_mode(env);
 }
 
+static inline void fp_reset(CPUMIPSState *env)
+{
+    restore_fp_status(env);
+
+    /*
+     * According to MIPS specifications, if one of the two operands is
+     * a sNaN, a new qNaN has to be generated. This is done in
+     * floatXX_silence_nan(). For qNaN inputs the specifications
+     * says: "When possible, this QNaN result is one of the operand QNaN
+     * values." In practice it seems that most implementations choose
+     * the first operand if both operands are qNaN. In short this gives
+     * the following rules:
+     *  1. A if it is signaling
+     *  2. B if it is signaling
+     *  3. A (quiet)
+     *  4. B (quiet)
+     * A signaling NaN is always silenced before returning it.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab,
+                             &env->active_fpu.fp_status);
+}
+
 /* MSA */
 
 enum CPUMIPSMSADataFormat {
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 9724e71a5e0..d0a43b6d5c7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -407,9 +407,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     msa_reset(env);
+    fp_reset(env);
 
     compute_hflags(env);
-    restore_fp_status(env);
     restore_pamask(env);
     cs->exception_index = EXCP_NONE;
 
diff --git a/target/mips/msa.c b/target/mips/msa.c
index 61f1a9a5936..9dffc428f5c 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -49,6 +49,23 @@ void msa_reset(CPUMIPSState *env)
     set_float_detect_tininess(float_tininess_after_rounding,
                               &env->active_tc.msa_fp_status);
 
+    /*
+     * According to MIPS specifications, if one of the two operands is
+     * a sNaN, a new qNaN has to be generated. This is done in
+     * floatXX_silence_nan(). For qNaN inputs the specifications
+     * says: "When possible, this QNaN result is one of the operand QNaN
+     * values." In practice it seems that most implementations choose
+     * the first operand if both operands are qNaN. In short this gives
+     * the following rules:
+     *  1. A if it is signaling
+     *  2. B if it is signaling
+     *  3. A (quiet)
+     *  4. B (quiet)
+     * A signaling NaN is always silenced before returning it.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab,
+                             &env->active_tc.msa_fp_status);
+
     /* clear float_status exception flags */
     set_float_exception_flags(0, &env->active_tc.msa_fp_status);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 70cd3628b54..c60b999aa3d 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -402,24 +402,10 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
         /* target didn't set the rule: fall back to old ifdef choices */
 #if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
-    || defined(TARGET_TRICORE) || defined(TARGET_ARM)
+    || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS)
         g_assert_not_reached();
-#elif defined(TARGET_MIPS) || defined(TARGET_HPPA) || \
+#elif defined(TARGET_HPPA) || \
     defined(TARGET_LOONGARCH64) || defined(TARGET_S390X)
-        /*
-         * According to MIPS specifications, if one of the two operands is
-         * a sNaN, a new qNaN has to be generated. This is done in
-         * floatXX_silence_nan(). For qNaN inputs the specifications
-         * says: "When possible, this QNaN result is one of the operand QNaN
-         * values." In practice it seems that most implementations choose
-         * the first operand if both operands are qNaN. In short this gives
-         * the following rules:
-         *  1. A if it is signaling
-         *  2. B if it is signaling
-         *  3. A (quiet)
-         *  4. B (quiet)
-         * A signaling NaN is always silenced before returning it.
-         */
         rule = float_2nan_prop_s_ab;
 #elif defined(TARGET_PPC) || defined(TARGET_M68K)
         /*
-- 
2.34.1


