Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B351D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Tp-0007PG-Cx; Mon, 02 Dec 2024 08:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Go-0002gd-E7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:27 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GX-0003F9-TW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:20 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a45f05feso53395565e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145258; x=1733750058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Xzjo6YdgDduUN5CW5xi57KmQUyStE6Nvif1Jh7XAts=;
 b=ahiOZbe06EmPSuPcGXwQhqFef0Eu+i8SCB/Ljpbe87FrZrjqz24s5nok8C9A+NfDS/
 U/YELyk2mcvT5rlNwcTI8R1F2xV/NIwhMc5VSCOnFTLz2Q6AarGMVeP54zzBHoJeUUF0
 zZcIieJRHsZGql0R54tuJkFVsN6oZ4P+uHr8Pz+n0Qv9/RmdGd92HyfhBjdb0VURShPR
 XmjPpTGDiS6QFFmPJ/T54CM75FpHmFzv7pbJE9ppwBmbP5unxSBW0NHviP4xk4bNY0dz
 PjDbX9BOOMe799sPx0morxahNsnk7gnkmeAFX1lB5Z7NpmB/jg7J4aQKBG7XCaghWlOg
 HJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145258; x=1733750058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Xzjo6YdgDduUN5CW5xi57KmQUyStE6Nvif1Jh7XAts=;
 b=FU7gmLPFSpYwvfLyryKVBN396dQDnjxa3Q/YJOFgz9LMu7OunUeMS+H2MGNEz+CLq0
 iruwHcQEC5c8zYnFx6Yta/uT+Sqc35+hla8OUkXub6JKbr6ZhCi/3qG3hVh1mot5v7M2
 DV8q/R+aLnIXx4Au8A9I/u/SwLXCFBGiQXQ47qIQj78NCeYND+rkgK+0ZNZbrEJz/IHa
 WefWrRP4C3pdm5aLywBhHL87VIDKr0P03A/5DltYrdJUkE13JA9U1UiY7rBWJ7R/a6kO
 JvRoYP9cYs41BWAJhlkOubo7wH9oVQCusXE1vVKL2ZEbgDXV0cV3rPG2LRt8fO3lis0l
 DAiQ==
X-Gm-Message-State: AOJu0Yz1eoXBdi8m1FkGu+YdVGyhbPf5oSZarXVHx76HJmdLoOaLKFkF
 U0i0rBoqpxbWr1Pn0wlsT8Ve9MCuGxHOPtLe0anrsd6+wHg+C6BSU2N1b3+mhP+cwoAzyRApWB9
 b
X-Gm-Gg: ASbGncsWGKvjLFwSrMXzsKp6bnwseUXhKku7zrJddyzMhKx3LEz5wM0uklrtCeYllbN
 qVYuaeIYA+HLlbhD7Vi8bLijmz+Jg+/oTaSvwbckbCX/fuUyO2nc+a4EoJmVsVWa9muFUAbp63x
 mLQYthMIMi+zNQ6LR05iMi0u1hSxFUGmO3RvB6KVs8QT+7vrVXjJ2cMuylMD0MOV0ojQeHyemGM
 IMI+bSBiOM7dqPava/vGNxS+MMcziXQsCFWPOpLUQ0p7HeYsb6379M=
X-Google-Smtp-Source: AGHT+IGVRwQv64xZT/ys+pYM7FLew3XpNvoLwo0JpRjreFc4Elcn+x+eqDZ6C7lHAc4rYFvS+ozJRw==
X-Received: by 2002:a05:600c:4f85:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-434a9dfbb05mr223665295e9.32.1733145256407; 
 Mon, 02 Dec 2024 05:14:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:16 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 17/54] target/arm: Set Float3NaNPropRule explicitly
Date: Mon,  2 Dec 2024 13:13:10 +0000
Message-Id: <20241202131347.498124-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Set the Float3NaNPropRule explicitly for Arm, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c               | 5 +++++
 fpu/softfloat-specialize.c.inc | 8 +-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ead39793985..c81f6df3fca 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -173,6 +173,10 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
  *  * tininess-before-rounding
  *  * 2-input NaN propagation prefers SNaN over QNaN, and then
  *    operand A over operand B (see FPProcessNaNs() pseudocode)
+ *  * 3-input NaN propagation prefers SNaN over QNaN, and then
+ *    operand C over A over B (see FPProcessNaNs3() pseudocode,
+ *    but note that for QEMU muladd is a * b + c, whereas for
+ *    the pseudocode function the arguments are in the order c, a, b.
  *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
  *    and the input NaN if it is signalling
  */
@@ -180,6 +184,7 @@ static void arm_set_default_fp_behaviours(float_status *s)
 {
     set_float_detect_tininess(float_tininess_before_rounding, s);
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
 }
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b4f3f0efa82..3a2d0444475 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -505,13 +505,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     }
 
     if (rule == float_3nan_prop_none) {
-#if defined(TARGET_ARM)
-        /*
-         * This looks different from the ARM ARM pseudocode, because the ARM ARM
-         * puts the operands to a fused mac operation (a*b)+c in the order c,a,b
-         */
-        rule = float_3nan_prop_s_cab;
-#elif defined(TARGET_MIPS)
+#if defined(TARGET_MIPS)
         if (snan_bit_is_one(status)) {
             rule = float_3nan_prop_s_abc;
         } else {
-- 
2.34.1


