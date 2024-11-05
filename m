Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBEBD1268C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbI-0004US-DM; Tue, 05 Nov 2024 06:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbG-0004Tr-NB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:54 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbA-00076Z-Ll
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:54 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso44965805e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805586; x=1731410386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z6Sx5T7z3vX0Od3b8lOlnJtkNCiAtBmuCbivGnTfARs=;
 b=HzWhO/oor0StP1zWub0IsqUHL72wIxz0aM+1Qigc2XeZOswirZYo0KfFZB2Dg2NGTX
 4w6rErCQqUTZAzEgq+Az37XGSx51aRfXd05pkxpaCXn+1H1RrELOsw7G+N3QJ3mazySr
 n6jwXX8UGE0/ir2kOibuerSqGekieHO1uMDarjjhCL6a4RQ/xEq9f+qQT8m4qRykxj0u
 LcnEOzV+zuBsgytqWW5KGjKwWuYCNjXgp82Pj8Dpp7nC7gegm/MAQtw3M9i3zS+ICBCw
 mJby9Hhn6TNi/UnWzb240YMWklfynrGiFZxGNmolRodSRkWnxmYsaQP0OO1mC+9P8mDl
 Nu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805586; x=1731410386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6Sx5T7z3vX0Od3b8lOlnJtkNCiAtBmuCbivGnTfARs=;
 b=ny7p4F03EHpnmAvs/8CEToOZSdvvgACu+NATOuv9hISevhmkhtA6Ng9vKYRw5PxH0f
 k0TrxpcGfuB1O65640aW+FjEQOBEm2Yxp8U2u4H7UFGSckcsEsUkF2B99CHl5D78hu8r
 clLVeOYJ34qVwZeSci5aslQfrwSQaCKTqqjdZX5wJYcYj+prMspvnZhVww/YNPDIn+Zo
 maJy29JEkwAiizoCQ6lJmrxT9QOJJS0n5sTSJ6bZfQPcJwzW6ieyCtvw8iLH10xb2N/q
 jzDbOFVj/0paPXo/US7gL6xLZsd1RtSY1LQNclqEsb3AL23aQZH88KeK4E1a11drW1ZE
 o57Q==
X-Gm-Message-State: AOJu0Yy8USTXK1sC3/4rHy9YKr2AbzGguZoYBnVwVicQqvhrdlmUJQdJ
 L1VOMxEIR8GC7F9fxghxQhiihkFJhj4gndD98KXLAKFKtqY9vET9f54Yfl9K6kH3Yy7YIMAgwaL
 h
X-Google-Smtp-Source: AGHT+IGMOE80rOIpwfDdAfPFtvS5gRujaE5Wm4SQjOVpDOVzUFhjZWvZQHF9cFIumDS9cVJOy3pjbA==
X-Received: by 2002:a05:6000:4911:b0:37d:62ed:b66b with SMTP id
 ffacd0b85a97d-381c7ac79ccmr14564795f8f.52.1730805585886; 
 Tue, 05 Nov 2024 03:19:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/31] target/i386: Set 2-NaN propagation rule explicitly
Date: Tue,  5 Nov 2024 11:19:19 +0000
Message-Id: <20241105111935.2747034-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Set the NaN propagation rule explicitly for the float_status words
used in the x86 target.

This is a no-behaviour-change commit, so we retain the existing
behaviour of using the x87-style "prefer QNaN over SNaN, then prefer
the NaN with the larger significand" for MMX and SSE.  This is
however not the documented hardware behaviour, so we leave a TODO
note about what we should be doing instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-16-peter.maydell@linaro.org
---
 target/i386/cpu.h              |  3 +++
 target/i386/cpu.c              |  4 ++++
 target/i386/tcg/fpu_helper.c   | 40 ++++++++++++++++++++++++++++++++++
 fpu/softfloat-specialize.c.inc |  3 ++-
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 59959b8b7a4..c24d81bf31d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2614,6 +2614,9 @@ static inline bool cpu_vmx_maybe_enabled(CPUX86State *env)
 int get_pg_mode(CPUX86State *env);
 
 /* fpu_helper.c */
+
+/* Set all non-runtime-variable float_status fields to x86 handling */
+void cpu_init_fp_statuses(CPUX86State *env);
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
 void update_mxcsr_from_sse_status(CPUX86State *env);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3baa95481fb..3d2874cf784 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7200,6 +7200,10 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
 
     memset(env, 0, offsetof(CPUX86State, end_reset_fields));
 
+    if (tcg_enabled()) {
+        cpu_init_fp_statuses(env);
+    }
+
     env->old_exception = -1;
 
     /* init to reset state */
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index e1b850f3fc2..53b49bb2977 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -135,6 +135,46 @@ static void fpu_set_exception(CPUX86State *env, int mask)
     }
 }
 
+void cpu_init_fp_statuses(CPUX86State *env)
+{
+    /*
+     * Initialise the non-runtime-varying fields of the various
+     * float_status words to x86 behaviour. This must be called at
+     * CPU reset because the float_status words are in the
+     * "zeroed on reset" portion of the CPU state struct.
+     * Fields in float_status that vary under guest control are set
+     * via the codepath for setting that register, eg cpu_set_fpuc().
+     */
+    /*
+     * Use x87 NaN propagation rules:
+     * SNaN + QNaN => return the QNaN
+     * two SNaNs => return the one with the larger significand, silenced
+     * two QNaNs => return the one with the larger significand
+     * SNaN and a non-NaN => return the SNaN, silenced
+     * QNaN and a non-NaN => return the QNaN
+     *
+     * If we get down to comparing significands and they are the same,
+     * return the NaN with the positive sign bit (if any).
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
+    /*
+     * TODO: These are incorrect: the x86 Software Developer's Manual vol 1
+     * section 4.8.3.5 "Operating on SNaNs and QNaNs" says that the
+     * "larger significand" behaviour is only used for x87 FPU operations.
+     * For SSE the required behaviour is to always return the first NaN,
+     * which is float_2nan_prop_ab.
+     *
+     * mmx_status is used only for the AMD 3DNow! instructions, which
+     * are documented in the "3DNow! Technology Manual" as not supporting
+     * NaNs or infinities as inputs. The result of passing two NaNs is
+     * documented as "undefined", so we can do what we choose.
+     * (Strictly there is some behaviour we don't implement correctly
+     * for these "unsupported" NaN and Inf values, like "NaN * 0 == 0".)
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->mmx_status);
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->sse_status);
+}
+
 static inline uint8_t save_exception_flags(CPUX86State *env)
 {
     uint8_t old_flags = get_float_exception_flags(&env->fp_status);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b050c5eb04a..77ebc8216f6 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -405,7 +405,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
-    || defined(TARGET_SPARC) || defined(TARGET_XTENSA)
+    || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
+    || defined(TARGET_I386)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


