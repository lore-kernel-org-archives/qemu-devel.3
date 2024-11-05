Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E48D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbE-0004T5-IR; Tue, 05 Nov 2024 06:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbC-0004Rl-8X
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:50 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb7-00075a-TD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so47350065e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805583; x=1731410383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T+YjZ1qgd1ODXhl25u0D0zFyemAxEawOWnnVFrkVnTc=;
 b=v9C/XmfwYWZrPP3vQGqCAN5kIW66xGsiAJjZvG4hAmd27yXveoM/slkdRYVj1pPKg1
 TY7nfD9JtBnNbZlYR1b+ED1TYdKHbcrL9VCd2mUYr5SdtmtIxwe43wLcf3cBfGOeKFCn
 rG2GpCe6Jg7howRTLm0VUkgtxA5yohSTRYH8BovM+malQiRKSjxpBNZrji2OA0GIwqxI
 d5Kp2gjXv8O4hBIxkkpq6FbuFlR8/rmBPI5yS+pDnRLPMBmQOtqz9AzBfs6f3GBtH/jd
 0Fn71ecE3zHngo6la/qFEYqt1c0Wk3AZ2MaEcFRvASAk2AC6WgI4q/khipw+K1hf7B1I
 bkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805583; x=1731410383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+YjZ1qgd1ODXhl25u0D0zFyemAxEawOWnnVFrkVnTc=;
 b=c/cyc0ovJNsnwFVzpOXifu8hIoWyN2M6bPxUdt/UZV1rUfRvco3p4aoF2O4Ya3aoFR
 0diTiTxGN+h/U+CGdWqnFmRZnxLvyZQfUmAPkb7azLcySDo5wqtVW1ZU8xUHL22soWUB
 jtE4aibR0KhabKgK5AoTiiICEoV8DF/8qdXVux92dDZWRaasS3P5fz32uZjySPTL8nOv
 tde5S8jjKpeHEG6um8JI9Fo7UiqgE70GkdA4AHdZSve0xnSU+0UXnQyproONQCnn4CbD
 lrFlAXhJyeUTr6ROWjcg9CUFZ9ADHwdkXkUtH+bmh85D52gUHDYX3i1/UF8avu7i3hc4
 MAXA==
X-Gm-Message-State: AOJu0YxjI9RLfaW35Zv3XOU0iTS978zVdXbAbJqTB/gWeIXLZvOnQRhO
 tlmALqZi346AtNd9yPqhGzMb344STqQ/qsQSMvKCDomykUlaF7PdjZxSM5cJzO89ZEGhAhuBLRV
 3
X-Google-Smtp-Source: AGHT+IHwrg9/dhQDo8hV/3gW9tZ45xk6dy0K7clBx7fWWazjBZJOU7dHGEE8k8YF5iPtb28RgcU3qg==
X-Received: by 2002:a05:600c:4f8a:b0:431:51e5:2316 with SMTP id
 5b1f17b1804b1-4327b822402mr163588725e9.34.1730805582733; 
 Tue, 05 Nov 2024 03:19:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/31] target/m68k: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:13 +0000
Message-Id: <20241105111935.2747034-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Explicitly set the 2-NaN propagation rule on env->fp_status
and on the temporary fp_status that we use in frem (since
we pass that to a division operation function).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu.c              | 16 ++++++++++++++++
 target/m68k/fpu_helper.c       |  1 +
 fpu/softfloat-specialize.c.inc | 19 +------------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1d49f4cb238..5fe335558aa 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -93,6 +93,22 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
         env->fregs[i].d = nan;
     }
     cpu_m68k_set_fpcr(env, 0);
+    /*
+     * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
+     * 3.4 FLOATING-POINT INSTRUCTION DETAILS
+     * If either operand, but not both operands, of an operation is a
+     * nonsignaling NaN, then that NaN is returned as the result. If both
+     * operands are nonsignaling NaNs, then the destination operand
+     * nonsignaling NaN is returned as the result.
+     * If either operand to an operation is a signaling NaN (SNaN), then the
+     * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
+     * is set in the FPCR ENABLE byte, then the exception is taken and the
+     * destination is not modified. If the SNaN exception enable bit is not
+     * set, setting the SNaN bit in the operand to a one converts the SNaN to
+     * a nonsignaling NaN. The operation then continues as described in the
+     * preceding paragraph for nonsignaling NaNs.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
     env->fpsr = 0;
 
     /* TODO: We should set PC from the interrupt vector.  */
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 8314791f504..a605162b71f 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -620,6 +620,7 @@ void HELPER(frem)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
         int sign;
 
         /* Calculate quotient directly using round to nearest mode */
+        set_float_2nan_prop_rule(float_2nan_prop_ab, &fp_status);
         set_float_rounding_mode(float_round_nearest_even, &fp_status);
         set_floatx80_rounding_precision(
             get_floatx80_rounding_precision(&env->fp_status), &fp_status);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 8e3124c11a6..226632a4d10 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -404,25 +404,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
-    || defined(TARGET_S390X) || defined(TARGET_PPC)
+    || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K)
         g_assert_not_reached();
-#elif defined(TARGET_M68K)
-        /*
-         * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
-         * 3.4 FLOATING-POINT INSTRUCTION DETAILS
-         * If either operand, but not both operands, of an operation is a
-         * nonsignaling NaN, then that NaN is returned as the result. If both
-         * operands are nonsignaling NaNs, then the destination operand
-         * nonsignaling NaN is returned as the result.
-         * If either operand to an operation is a signaling NaN (SNaN), then the
-         * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
-         * is set in the FPCR ENABLE byte, then the exception is taken and the
-         * destination is not modified. If the SNaN exception enable bit is not
-         * set, setting the SNaN bit in the operand to a one converts the SNaN to
-         * a nonsignaling NaN. The operation then continues as described in the
-         * preceding paragraph for nonsignaling NaNs.
-         */
-        rule = float_2nan_prop_ab;
 #elif defined(TARGET_SPARC)
         /* Prefer SNaN over QNaN, order B then A. */
         rule = float_2nan_prop_s_ba;
-- 
2.34.1


