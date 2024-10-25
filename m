Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE254D0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L3u-00046D-RA; Fri, 25 Oct 2024 10:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3s-00042v-4j
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3l-0007mm-KH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so20390635e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865580; x=1730470380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxpTyYZBHeinKYjs0KLdQZTFPyy0lkXjTFzf5hZbbFo=;
 b=CGBuWOgnxSzMdPYu0Rqs/8R6Pw7jLtC2XSAHErJjZbnCk75QLKtNPWZlryveWc0Ile
 8V0uW9QhvS1i9bzN67Xkl3k8KZAzaZVGiLeC9Uy+KEp1uJ+O88fJM9nmTi7rgAXLnYl1
 TuSuikrcAK7V12/E9k6/cpFuxzbC4gHCCKr3tYZAhjvywF6djZoX+qQg7UcVzoSA0LIT
 DqYKreg8VrONjmnCnNcS2Prx9ZsCD6nVzgLLMxNP+S46puGCq1w4Rvmzg8648k9Ze1sR
 I94Z22WNprp5IfK2t0L4oZvUnmdGlM2Ok2c/JpRBN0GPWncUOSMY0zA+dCPvAiAvVkFP
 R7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865580; x=1730470380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oxpTyYZBHeinKYjs0KLdQZTFPyy0lkXjTFzf5hZbbFo=;
 b=G+B9gMOZs4tGVGMRPIb0rEzKxO0lvxZEGi4FnSyOzxDdcDDcVYkD6bAMqDp6J0aXqA
 4DDb8uXwgHcey+AIL22r8rGHetFnmvNWkC+Px9AmhhNBTv9WVxu6cEx8VUYM2zOwgjJH
 e4NeGEBO7MraixUCuCHUIWCllPUlQjaZoCMLIox3K9JGR570uh82l31KiDyiGWNji4Bd
 apu37jyb0oSTNcxSTb5u3M7FpVdMs7EboSnsfAI+S7N0aKLGmXzvXaf/wqcpGnUntiU6
 88S7H+x/mEDMNu20xjz5TrnGYhLG5fR6tvo56FXYvvPmpMSnlhfUjf66ib8CI+CdHGr4
 F4oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXPWGFVi1/fCPJJs0bfVYrNA2bxGymiuoVLR3ujuTFSxM17Yf8NzDJJVt7GskVmGv0fjwCSLQWlncG@nongnu.org
X-Gm-Message-State: AOJu0YyjQrWL02OHU7qXJZ6DkZYPh7IpRsJJV1D/utI4SmLWvh5MNUkR
 +S8GZEp3aHmLV80Vp8RcrlxMSiAY4nfvgbYBgbL3XYhLNhzc7DzK1/dDgGzGV/A=
X-Google-Smtp-Source: AGHT+IFmo0A/cK7mxek7qVmenyHyXSHRnCM6HvcgZruK2l+y0NWBmuNTPj3PU5VnMspDYKzexoWsSw==
X-Received: by 2002:a05:600c:511c:b0:42f:823d:dddd with SMTP id
 5b1f17b1804b1-4318423b856mr71363435e9.27.1729865580016; 
 Fri, 25 Oct 2024 07:13:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:12:59 -0700 (PDT)
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
Subject: [PATCH 04/21] target/mips: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:37 +0100
Message-Id: <20241025141254.2141506-5-peter.maydell@linaro.org>
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

Set the 2-NaN propagation rule explicitly in the float_status words
we use.

For active_fpu.fp_status, we do this in a new fp_reset() function
which mirrors the existing msa_reset() function in doing "first call
restore to set the fp status parts that depend on CPU state, then set
the fp status parts that are constant".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


