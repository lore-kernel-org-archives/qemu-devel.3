Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDFCD690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0g-00037T-8J; Thu, 28 Nov 2024 05:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzc-000239-2n
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:29 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzV-0000UQ-Sc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:27 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so6031025e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790600; x=1733395400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwvjGP9nM6OJvLHzJNmFilwr8r1rRnLYpGXxx9aO2ss=;
 b=bc7XbSw7JmslW5r7TtdXWYR2SfJ4nDiNkjnxEwrcn5LnbCtNc/pZW0QSXq16CEQ/8f
 646c6CZpuBY5EcWE7AgfwY+7MgzH4roWngeCATm0OP1CgqRrjVSoB9DR23+79BK70Ny/
 zFIoSOOLiETkxSuQtrO00u5nXALZXhv6ipNOwJTlkybQZu0rT3mKA8qfIfpU30oPbERD
 wVH1H7EfJI3uJoWqBjERIBAn1Rc+aI6MOxqfUE0SrnEJNmN/rSNBJlO6DcwvE0W0GMRX
 1cTps8O7qy2UnydIPZIFiJzbmddoRs0aikVbEewyuvvzaA2HO5jTe7lPc3j9vxtTUaMK
 TJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790600; x=1733395400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwvjGP9nM6OJvLHzJNmFilwr8r1rRnLYpGXxx9aO2ss=;
 b=ZpogHrLvLS1bsil1QpyPDogX+lAfNVU/qBLR1OH3VVt7VjS+03QF+x8VozoORlYFRa
 Fuzp9vaSNyTNMqb+D8A4KAD/3BEyPVemMOKHJNaOF0Jo7SO3uxtpf+v8L5zIoBJ64BxT
 ANpdsgBZ29KBfa36MUC5bOaGmyVGqt4BM78BJgDP9+UCCz9OTf7ZY278kpu8PKbigb3W
 o4C9PvLWnBXKy3jVO7SpactVE9wI7gFA0yE+RNAEbKdX5g5NWs0GDCgR1C+PPEWsBSQi
 8mo/DZrUXVqpadPlBLe4zorjNHOeBYckYuiMAngjbaMlwQnqp4d2rbLbXeP8nvKBbsdT
 0Alg==
X-Gm-Message-State: AOJu0YwClo5rsiJV2KvCHcXvvqZ05a8GWFfxFT2ssUyqR0Dg85IzfFWq
 9ewfkNBul3aI83gWn16dvWrz7be4bl2XA3TsdfkRffBVNh5WN66rUQf3twnN/+61jrZtu8A+zwn
 v
X-Gm-Gg: ASbGncuQ7z9b7JYkAos/qOlGBcqcv6PqoK/Ghhs0HpCWjpwAN/pdZjAKsXHa162O5+U
 q85ghRfuFUbVKJ5vqfb4OTqk2ZNfmy4wb1/XMQ44tAnARpNoZTICkOd8qjH27OtCYdzKldooqEf
 Qgvrimf1y+6gErrqy0JSu0ywsT0UWGhaT66+HejSm3t93UHfVKIOYGqykoH/D8Laya73v0VssOz
 4kLl6835H6X5lAeoaV/Q/LiPK5cZa8f59MyMn9GAyao0nI4OSUcGFA=
X-Google-Smtp-Source: AGHT+IF8avi9FU8kPgaxxBYqDyIzAMA/ClbqF7FGpSE026N6UfXClh07JepyogBPwI7n2/nj2x37LA==
X-Received: by 2002:a05:600c:474c:b0:431:1868:417f with SMTP id
 5b1f17b1804b1-434a9dce659mr70149485e9.17.1732790600234; 
 Thu, 28 Nov 2024 02:43:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:19 -0800 (PST)
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
Subject: [PATCH for-10.0 08/25] target/mips: Set FloatInfZeroNaNRule explicitly
Date: Thu, 28 Nov 2024 10:42:53 +0000
Message-Id: <20241128104310.3452934-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
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

Set the FloatInfZeroNaNRule explicitly for the MIPS target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/mips/fpu_helper.h       |  9 +++++++++
 target/mips/msa.c              |  4 ++++
 fpu/softfloat-specialize.c.inc | 16 +---------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index 7c3c7897b45..be66f2f813a 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -28,6 +28,7 @@ static inline void restore_flush_mode(CPUMIPSState *env)
 static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
     bool nan2008 = env->active_fpu.fcr31 & (1 << FCR31_NAN2008);
+    FloatInfZeroNaNRule izn_rule;
 
     /*
      * With nan2008, SNaNs are silenced in the usual way.
@@ -35,6 +36,14 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
      */
     set_snan_bit_is_one(!nan2008, &env->active_fpu.fp_status);
     set_default_nan_mode(!nan2008, &env->active_fpu.fp_status);
+    /*
+     * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
+     * case sets InvalidOp and returns the default NaN.
+     * For MIPS systems that conform to IEEE754-2008, the (inf,zero,nan)
+     * case sets InvalidOp and returns the input value 'c'.
+     */
+    izn_rule = nan2008 ? float_infzeronan_dnan_never : float_infzeronan_dnan_always;
+    set_float_infzeronan_rule(izn_rule, &env->active_fpu.fp_status);
 }
 
 static inline void restore_fp_status(CPUMIPSState *env)
diff --git a/target/mips/msa.c b/target/mips/msa.c
index 9dffc428f5c..cc152db27f9 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -74,4 +74,8 @@ void msa_reset(CPUMIPSState *env)
 
     /* set proper signanling bit meaning ("1" means "quiet") */
     set_snan_bit_is_one(0, &env->active_tc.msa_fp_status);
+
+    /* Inf * 0 + NaN returns the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never,
+                              &env->active_tc.msa_fp_status);
 }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 2023b2bd632..db9a466e05b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,21 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_MIPS)
-        if (snan_bit_is_one(status)) {
-            /*
-             * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
-             * case sets InvalidOp and returns the default NaN
-             */
-            rule = float_infzeronan_dnan_always;
-        } else {
-            /*
-             * For MIPS systems that conform to IEEE754-2008, the (inf,zero,nan)
-             * case sets InvalidOp and returns the input value 'c'
-             */
-            rule = float_infzeronan_dnan_never;
-        }
-#elif defined(TARGET_SPARC) || \
+#if defined(TARGET_SPARC) || \
     defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
-- 
2.34.1


