Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FC2D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6N3-0000sA-Gh; Mon, 02 Dec 2024 08:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GR-0002GW-Fe
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:02 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GL-0003Cq-9o
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:58 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385d6e36de7so3706040f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145250; x=1733750050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLWBUHvjOah3un3/57/rPBpB/Wh0uSx2UDmLN935xs0=;
 b=Z+s9kM6o4IBZk836N4o9ecJvAypQIOlWG/105jsJUpLKV1Rld8ejoM+QtqvDoeICts
 Y9H7IJi/6EZ+YAXOj52YJyO+2FInYs2FmAEbhvkgAyX/toedAbAWbiCC6O8gRk6ps4EU
 wYggH4FXSoVpTSHEF18RnWTvuO1E87o/e8X2VI3nTeEo4G31Q43//pWQrSDkb2jVqDWe
 qdLQsDmYe1rNiRbMtyQTVig6lrvDZNpDWgpoZ5e9vMTQPDXUF+gafPeGLb06/ENAA0FY
 //w9SypIbO0TtODNr0mK5qK4kUqKKPtgjhvwT/66qBjy7wlZ8T+TticMXAFvUj8Q0t60
 kSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145250; x=1733750050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLWBUHvjOah3un3/57/rPBpB/Wh0uSx2UDmLN935xs0=;
 b=Szn1mckTmFb0mvkipwVrE0CJaqFROJ0NLTI/Q3YHz79cit3zjlB/k8UL4Z3Sf9rSap
 DYbZho2AFTYofxJ0BuYF7CzUQiL8DtuoXeNIp8oTGZ5xJ/6v3FH2E9SYuRGVnl/alzL6
 9JU2R1E1D34H7C1rjkLxBwzsAW49/9Pd5hjUIt0S60cEEvSMXOHC8iw7ijOXWyionLC4
 p4mX/D3ulpBx/gm1eElgasI4ekq7mBxryyy/SXNRVVgz4XAWMBxR5eS3xLANprUGrzlw
 kuaWDW47d/3QR7+Yg9Xvj6OSssJTe4cvDbaCDKd2qdoKFlzYKd+AGw8RuFcCNIX5xuCC
 KZCQ==
X-Gm-Message-State: AOJu0YxUBzCZAcM7c23kgI4WOurp4MDE8vMqiHe3EAPfTCrR9ixegbKV
 iGSs8TVTM0vHN/EdnauGtgDrcYV3Rf5JBghxBR4gJLZFnvz87qjGXfiETWDJmMEaOnQom6/wJSY
 B
X-Gm-Gg: ASbGncuMBujYvhxbv/Qjr6m2++WgtwIYgCyBrDwEQQR+A3yViF3hpa45MYOBaU+RjI5
 cHUmXWQJa84KO9BESD7rLSgGQOTToam80bVl1BwzmyNmKkdEEhMW3PKKuxH9W7wheDUXMT9f+Wo
 YfTNob/2mGSE+uzLOaMb2m/G0GZW6SguAA4U78M74Tu4O+8D2/llFWYzF77+SrAjHeEsP3xJMZx
 kPW7lnQd4slY205M6ffvcU4GeDeN8QSFb+yXp1vyMM8LGh3UIPJcD4=
X-Google-Smtp-Source: AGHT+IF0Hwpzg6dNKKvHLMYzIyDSn83uORY7RarpqFUSX/f91/tb9XChu0z+5QbApuX4pt02PA7YMw==
X-Received: by 2002:a5d:6f12:0:b0:385:f996:1b8e with SMTP id
 ffacd0b85a97d-385f9961e8emr1313251f8f.16.1733145250043; 
 Mon, 02 Dec 2024 05:14:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 11/54] target/x86: Set FloatInfZeroNaNRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:04 +0000
Message-Id: <20241202131347.498124-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Set the FloatInfZeroNaNRule explicitly for the x86 target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v1->v2: Update the comment to give the info from the x86
spec rather than a TODO comment saying we need to check it...
---
 target/i386/tcg/fpu_helper.c   | 7 +++++++
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 53b49bb2977..a98b4f67ff0 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -173,6 +173,13 @@ void cpu_init_fp_statuses(CPUX86State *env)
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->mmx_status);
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->sse_status);
+    /*
+     * Only SSE has multiply-add instructions. In the SDM Section 14.5.2
+     * "Fused-Multiply-ADD (FMA) Numeric Behavior" the NaN handling is
+     * specified -- for 0 * inf + NaN the input NaN is selected, and if
+     * there are multiple input NaNs athey are selected in the order a, b, c.
+     */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 3062d19402d..ad4f7096d09 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -490,7 +490,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
          * Temporarily fall back to ifdef ladder
          */
 #if defined(TARGET_HPPA) || \
-    defined(TARGET_I386) || defined(TARGET_LOONGARCH)
+    defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
          * case sets InvalidOp and returns the input value 'c'
-- 
2.34.1


