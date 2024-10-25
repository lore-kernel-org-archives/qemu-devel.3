Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4579CD0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L3t-00044u-Ii; Fri, 25 Oct 2024 10:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3p-000406-FI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3k-0007mD-R8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso27318895e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865579; x=1730470379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGwvRk7TZZeC43moIVYb7p9RL4z/VBbvk9hnG7xUO3c=;
 b=csU1314FYbm4YozNi99R86y+c/GF1E2b4jGCRATbeBgb8HKVNk/fBvz2dnq02NeeyJ
 x5lT6UADsEWBGk4QGftmz4W+JLAm+07Giahp1Uv2GkaBgIeMmTmBONPRZaL4kT3Gz1ft
 nMmDAx3DCRTyDVPRP4ehLMLzFrH9GIerqqM6QLoRRXLzRdPktSQvNQRglwt9pe89LEvV
 zVl6uHiGJeNtQZTI7yGfOqA5+X6IbNRpd5BnoGilMDl70XxgL1kz1IYt+YRFopy+zWH2
 Sx84BiLdoVSbl2kDPKECJcxZmDG47bll/3iP3JR8g5j4WdzbrLmgyT9OMadz4woJCBhX
 3Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865579; x=1730470379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGwvRk7TZZeC43moIVYb7p9RL4z/VBbvk9hnG7xUO3c=;
 b=OQBDU9SHA6jhwzBTBHQizxRVSy5hO+wMnzlqJ8iKBYl+JlGAJrdG9nOOi1CrkA8FbC
 DJ2951nee4JZrIwJPavuLWaH0qMgrYSQm2fiRIFuNSEJrDIZXwT074l/DgzCjw5NhgYV
 F9EURcGFVl7hePY/5Ujdgk59gghuCn7Um/0u7Pt52rLsVGPH7HIlkcACQ4ol6ofmid08
 Vrl3oTRz4jx1z/scm5DQpupkBaREKWFpVDxGon7TwDYRHqugq4RfWM2LCDsGUb9/3kSb
 +LEdad67TvrvCC5029HdDHjKhlCpVxUNGISUl8d8V7PMnmNbAykUM7282/AILQIq3w3N
 QWbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcxax5989PYRc+b2CzWfIysqhLb0R2C7xR9kvg5bYzn7zNYlC+BPEm+leqOZP13NtNkmc6oFsNQxlg@nongnu.org
X-Gm-Message-State: AOJu0YzalOeLZIsaaOAg6zJQESb8nTA4RaM/oJl5QYWmjGEHMdHrnps6
 q/fi4Bt11CQ/0kZvYHJgA9BycBUgi69n5QYR7ouT73bD6nsUQWCbzynMifo9Gm8=
X-Google-Smtp-Source: AGHT+IEYimKNM/5+v3TTeeUBvxWOef5wpaX97b0yuiLjdVPgKthFZTkVWfIVxbwFrprYwlrLlBD4eA==
X-Received: by 2002:a05:600c:1f09:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-43184241cc5mr111818875e9.26.1729865579076; 
 Fri, 25 Oct 2024 07:12:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:12:58 -0700 (PDT)
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
Subject: [PATCH 03/21] target/arm: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:36 +0100
Message-Id: <20241025141254.2141506-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
we use.  We wrap this plus the pre-existing setting of the
tininess-before-rounding flag in a new function
arm_set_default_fp_behaviours() to avoid repetition, since we have a
lot of float_status words at this point.

The situation with FPA11 emulation in linux-user is a little odd, and
arguably "correct" behaviour there would be to exactly match a real
Linux kernel's FPA11 emulation.  However FPA11 emulation is
essentially dead at this point and so it seems better to continue
with QEMU's current behaviour and leave a comment describing the
situation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/arm/nwfpe/fpa11.c   | 18 ++++++++++++++++++
 target/arm/cpu.c               | 25 +++++++++++++++++--------
 fpu/softfloat-specialize.c.inc | 13 ++-----------
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/linux-user/arm/nwfpe/fpa11.c b/linux-user/arm/nwfpe/fpa11.c
index 9a93610d245..8356beb52c6 100644
--- a/linux-user/arm/nwfpe/fpa11.c
+++ b/linux-user/arm/nwfpe/fpa11.c
@@ -51,6 +51,24 @@ void resetFPA11(void)
 #ifdef MAINTAIN_FPCR
   fpa11->fpcr = MASK_RESET;
 #endif
+
+  /*
+   * Real FPA11 hardware does not handle NaNs, but always takes an
+   * exception for them to be software-emulated (ARM7500FE datasheet
+   * section 10.4). There is no documented architectural requirement
+   * for NaN propagation rules and it will depend on how the OS
+   * level software emulation opted to do it. We here use prop_s_ab
+   * which matches the later VFP hardware choice and how QEMU's
+   * fpa11 emulation has worked in the past. The real Linux kernel
+   * does something slightly different: arch/arm/nwfpe/softfloat-specialize
+   * propagateFloat64NaN() has the curious behaviour that it prefers
+   * the QNaN over the SNaN, but if both are QNaN it picks A and
+   * if both are SNaN it picks B. In theory we could add this as
+   * a NaN propagation rule, but in practice FPA11 emulation is so
+   * close to totally dead that it's not worth trying to match it at
+   * this late date.
+   */
+  set_float_2nan_prop_rule(float_2nan_prop_s_ab, &fpa11->fp_status);
 }
 
 void SetRoundingMode(const unsigned int opcode)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1320fd8c8fe..2fd286972a9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -168,6 +168,18 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
+/*
+ * Set the float_status behaviour to match the Arm defaults:
+ *  * tininess-before-rounding
+ *  * 2-input NaN propagation prefers SNaN over QNaN, and then
+ *    operand A over operand B (see FPProcessNaNs() pseudocode)
+ */
+static void arm_set_default_fp_behaviours(float_status *s)
+{
+    set_float_detect_tininess(float_tininess_before_rounding, s);
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
+}
+
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
 {
     /* Reset a single ARMCPRegInfo register */
@@ -549,14 +561,11 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_inputs_to_zero(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status_f16);
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->vfp.fp_status);
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->vfp.standard_fp_status);
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->vfp.fp_status_f16);
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->vfp.standard_fp_status_f16);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status);
+    arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16);
+    arm_set_default_fp_behaviours(&env->vfp.standard_fp_status_f16);
+
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_arm_reset_vcpu(cpu);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index fae6794a152..70cd3628b54 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -402,19 +402,10 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
         /* target didn't set the rule: fall back to old ifdef choices */
 #if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
-    || defined(TARGET_TRICORE)
+    || defined(TARGET_TRICORE) || defined(TARGET_ARM)
         g_assert_not_reached();
-#elif defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA) || \
+#elif defined(TARGET_MIPS) || defined(TARGET_HPPA) || \
     defined(TARGET_LOONGARCH64) || defined(TARGET_S390X)
-        /*
-         * ARM mandated NaN propagation rules (see FPProcessNaNs()), take
-         * the first of:
-         *  1. A if it is signaling
-         *  2. B if it is signaling
-         *  3. A (quiet)
-         *  4. B (quiet)
-         * A signaling NaN is always quietened before returning it.
-         */
         /*
          * According to MIPS specifications, if one of the two operands is
          * a sNaN, a new qNaN has to be generated. This is done in
-- 
2.34.1


