Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C671CD7831A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6IC-00045T-Qx; Mon, 02 Dec 2024 08:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Fv-0001nn-Ja
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:32 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6FT-00038X-P7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:04 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so1178672f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145237; x=1733750037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X86TKVmBDvN75raroOS5cqB5k378L/9aSAueAeunYPY=;
 b=xSTlkBXm0qr+JsuVwvnOKeMTwIvKiGUoF4Y98fLU/Am7p5w/vXO9XQpwj7D5KoEUOW
 yRs1TE3/rf0UHbCuh9gUg2XaAbm9l8VOTnL6wRYlmM4HqjzbOYeM8pumpfQduqNt2CVo
 EjmcaZGzO9golB5tBlhP16xQcfef2DFKPejDzOOhr1rKmQMvGrQUU+ng64n1ZU36oo2v
 QjR9XVoXKpG5XgfRilUdlkevRh1RQmoI62k3s1RKrJkdaMCgURukjK1qigNakLCVpneg
 l65LyXzI9LDYjEd+llFSsE2InqFpUI19lJ10P4ZBFFkQ9YhA3J2ID9DCgLBubuNNr5gQ
 TXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145237; x=1733750037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X86TKVmBDvN75raroOS5cqB5k378L/9aSAueAeunYPY=;
 b=FRuFAwU6Vna698l3lNu9bjsXRga6l/zw9DfpFL4+s9BRB6y4H+js9rXE3zhO9qztQV
 dSPLgGAeSKw4ikKpSJI1pmOU/FuBdxHUor6ZPbR1MqS5TnqVCoGdi1VQzaWtFkfXdCCE
 5tSTABpUvO+j8apIZXnwf3wkVCpr2caAKZGNOJmRV5GYQnpFPzkIap74Tgk2j/8nxX4c
 4KE2/NRnxSI6LAnen3U2DwNOKi6FVXHVYzWNYDoU5cK5bRsiFsjDO/cpHnVwb3ed322t
 uWOx4ZGQsDUz9Hvm6SYZOlAjnF5nBQ00QsSaGiVQzRga4BrTbZDCKJjx6uiaxylsjFgE
 l6uQ==
X-Gm-Message-State: AOJu0YxwZFmPedMJa86lTCe8XU3D7PUk1IwVlmJENVjAk+I6tFO0DP1M
 gHZnDwtjDvxZvszl0wJCC6bsuCKtyXx9HnsyxA8TKp/TIxuxsQlAYpAjRCWOJvRgTMElomxXkPK
 T
X-Gm-Gg: ASbGnctkwdYNaBs+aZL/NJkoZjgZKuLz5yjlp8Awa/eh/O0g/7CVySDnWf3QG+l4CYr
 Yzmu/qmcvY/RTkzTbzFVahQTULZhjFd2IOI3kXCXni7BHxmPv/Pndr6aE0iWDwGu+1e+P15a5aK
 HeJ/DIDkXg5XAwBfB5e1Q1b2ytjWv5aeYmF1bAbKqyLlWJ/K2T7JImoSFjeaxe0p3+E2nyfcu9K
 bcmIILfZ8WzEIXnTgU5fzIhtaC15ArmIxzutGwhvA4E6mubvkrlVhY=
X-Google-Smtp-Source: AGHT+IFdQQWgR/bNLUdTgu3F5FTRNJTdAqhmVVBqbLbMiui/GUGucj15DDJzu/49uD8zVv4Y52wGZQ==
X-Received: by 2002:a5d:47af:0:b0:385:ef39:6cd5 with SMTP id
 ffacd0b85a97d-385ef396e98mr4114344f8f.1.1733145236576; 
 Mon, 02 Dec 2024 05:13:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:13:56 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 05/54] target/arm: Set FloatInfZeroNaNRule
 explicitly
Date: Mon,  2 Dec 2024 13:12:58 +0000
Message-Id: <20241202131347.498124-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Set the FloatInfZeroNaNRule explicitly for the Arm target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c               | 3 +++
 fpu/softfloat-specialize.c.inc | 8 +-------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b954..ead39793985 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -173,11 +173,14 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
  *  * tininess-before-rounding
  *  * 2-input NaN propagation prefers SNaN over QNaN, and then
  *    operand A over operand B (see FPProcessNaNs() pseudocode)
+ *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
+ *    and the input NaN if it is signalling
  */
 static void arm_set_default_fp_behaviours(float_status *s)
 {
     set_float_detect_tininess(float_tininess_before_rounding, s);
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
+    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
 }
 
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index f5b422e07b5..b3ffa54f368 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,13 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_ARM)
-        /*
-         * For ARM, the (inf,zero,qnan) case returns the default NaN,
-         * but (inf,zero,snan) returns the input NaN.
-         */
-        rule = float_infzeronan_dnan_if_qnan;
-#elif defined(TARGET_MIPS)
+#if defined(TARGET_MIPS)
         if (snan_bit_is_one(status)) {
             /*
              * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
-- 
2.34.1


