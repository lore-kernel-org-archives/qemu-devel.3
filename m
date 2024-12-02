Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160C8D7831E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6OF-0002Po-4M; Mon, 02 Dec 2024 08:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gb-0002Kx-8l
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:14 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GR-00039q-8H
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:09 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a95095efso30371055e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145238; x=1733750038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04rCvvMWBdPOtJMZYEuwTadqTTp/Q9o9M7TcBLMjcm0=;
 b=jG5Vec1C8aIKuiREfoyFismDEBmjKvlk+EeqewNeLcA1t+MjEeiV+0BYUeyMxdnvGX
 3dLfcflSsBqiccs3DTfLcCiYr5Rnn7IpimLRGXjSOSPfQZxPKtcs9LqriRAFYnd+76kv
 E17C8g1vmUoNwZ/b7G7DWcn3pZjPRRZHKPJGCOycHrMI+1fNHjT93ImWECFpatbKoh3G
 ZYztCpjvPnpyHQivw5xbKtruc5FnbPgZtUaXlXhpMxaNbkiuse/tA5+c824FJ3crUAga
 ZLQR0T4SAGTS6DDREsEwm1bt0FkOr95qgCtZ+SMcuFSyAGApG57cYvfIqvYQDutbb4yJ
 dwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145238; x=1733750038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04rCvvMWBdPOtJMZYEuwTadqTTp/Q9o9M7TcBLMjcm0=;
 b=dUA301o0rBS5sf1XJIcZhKQ0+3/8fBe1efCdL84W7RhJnQ9BajmduLQ89HGj4vNWVd
 cCa9Ijyfem9oQ1bL1mT9cfRn9txBBFXO1B+zddwv4HZJtLwm4L/8Y93AJoGhLEyR1kUS
 JnFB0Gq751RuVyGyWmZSsBVUbWjyoJaRjkUMqj7KyMIugMnpTdiT0HF7g3f93HBV0SXk
 8AVZUXn60MCv8amvwZ7wEC0RvKu/uck9BwSwsGBm/p4nmCcChCScMxa6XKQ61sMKQnX7
 zNik/a0ySBN8OZY+YN1sn+SSDFwuqjZJne2Qj/NUUakJ0HU6F5vlBgxf6SKs+aeNvGgF
 7Tog==
X-Gm-Message-State: AOJu0YxW1F7esyoIpeYra5aAjOnIkbzyuyg+vNI6kjvL9Kp3q/ksdgXR
 vRUgI3F0K22wac0hopq3eGelJjh91zDaNp8dIX6Zv+xPB7UZEXLTe5MBi6sRfnW0G0IeG94m5dT
 N
X-Gm-Gg: ASbGncs7u4gz632EmRQM6SCEOy4LUF+miSOYIUjJ3uomYyKpXuP24RL40lgCnE92SYO
 jTYTRo3M70MPpxYOecy0qZNwjXS/gH12/QwjPEm7YLOOVOb5SYj7lXd0msk/9e0xjyO6jxZ+vmK
 gTGUqhtZL2mHDru7FWQMd78EhT1oVwv1gEVImoLXX0fGByBvJqaMV9SjtbOHFxQTSRjESusF+T6
 JMx8MN6l7xMTElEAvFV7XNkkP/iaLXalLUiYERnYXy4VL5QfGZQr0s=
X-Google-Smtp-Source: AGHT+IEYDlhUZi9tNaFiTL1YEiPgH90/P6r0qgNvdF/ZYG+u30YboedBRcHxxQBWbNrDwYwgiOjJrg==
X-Received: by 2002:a05:6000:1ac9:b0:382:4abd:c3c9 with SMTP id
 ffacd0b85a97d-385cbd73eeemr16904034f8f.7.1733145237666; 
 Mon, 02 Dec 2024 05:13:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:13:57 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 06/54] target/s390: Set FloatInfZeroNaNRule
 explicitly
Date: Mon,  2 Dec 2024 13:12:59 +0000
Message-Id: <20241202131347.498124-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
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

Set the FloatInfZeroNaNRule explicitly for s390, so we
can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c             | 2 ++
 fpu/softfloat-specialize.c.inc | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 514c70f3010..d5941b5b9df 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -206,6 +206,8 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
         set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fpu_status);
+        set_float_infzeronan_rule(float_infzeronan_dnan_always,
+                                  &env->fpu_status);
        /* fall through */
     case RESET_TYPE_S390_CPU_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b3ffa54f368..db914ddbb1c 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -516,8 +516,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
          * a default NaN
          */
         rule = float_infzeronan_dnan_never;
-#elif defined(TARGET_S390X)
-        rule = float_infzeronan_dnan_always;
 #endif
     }
 
-- 
2.34.1


