Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE009D7831F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6UD-0008Pw-Oz; Mon, 02 Dec 2024 08:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gk-0002Zg-5p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:22 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GS-0003HZ-Tj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:10 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso2608735f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145267; x=1733750067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buw3vsQorwZwaR50k4S9PXYAF2rd+6sbEuYUjFK5KVQ=;
 b=q344wjlfB1syk2rTk4pJiuBHFfBB2Lr1jBeBCPA3syz1s5a57MzcPeWEce/kqWNDij
 3wt3nT+pPZ/txGt0YyQGHMcgDa6Y4x2gM5vCBWRbGuavUdBXn7xiv3oZqXTU7XUoDmJR
 RbZfa5YUIEN4vq9V+e8xQ2UpKjdJgk/oIMtS2CEBSP74uvHiZRz3qY39qjvyb8TTO/Ex
 X+6C6WQFo2zUDCEAbzc2nhRYLKnIGaFHfkA+ltRr+ZS0SYrCmaIk5yVORC44OEAWg/As
 Mkl0kChUs4QhI9f/qBM2BNFeVfQ2OjoyATgITf0O/yCkqc4lOsCdHdYrlrDikKarX1Dk
 Tkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145267; x=1733750067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=buw3vsQorwZwaR50k4S9PXYAF2rd+6sbEuYUjFK5KVQ=;
 b=OXNj5VFSq3oLYwkuBxNFUhAhTaqta4D8CC6mi2bbvaXR4zEa91zIYYNTvKgYgIpYHT
 OKodpmkERtl4Lfnpw0Ll8DZI8tw+dTSX747TB+CBxTmaxHNJzynm4Ggdy7fxAZCYtTud
 tO1FtmGPvAJbEXLp7p398/HccIHGT1qtVYTPlYdjeT9LMwh9KZsJ+k4JDoaJvdyBMsfN
 F6SfoZmzzIMrulx1Cl+KtQbklsGMlXra7UgGiVSdbWdvthzV6cKEOQ4QvqiRszCipsNO
 +O9feNu63fNZHvKVK42XrFzWCX1+IAOmEBBdpDE04t0Vncrro8kXkJpeY1Whf09RItJH
 wDRA==
X-Gm-Message-State: AOJu0YwAdQyzLn47Poq6jHSxQoq0Jkp1zauRA6q20PLq97awHxgwEyww
 JA3ACY4g3zxMlwI/wXmIOT9XW1EckVWhhVf2j4cMG166ZgOeKCSYPZsHhGMqHJNB81i43AJyqE2
 V
X-Gm-Gg: ASbGnct1ew6UnzOX7dKgZW9FI2CKm9UpFpu4O+hM9QIZ6da3BvyuBeFcVIAW6AHcS/u
 vrm5k7TlyyxhLBv71RBaEKO2BJ8ludFGrV0vFyH9iiNO8nmBGQkX2J3Pc95CQE/5V9FbXRBCluW
 95li1d2/ujoVbi6Wp7jbShTw1heBZgQMQTH1hlzGqxGKr+G8wVdpIVbNrym2RGOpU7roAqMq4aU
 pJGTzaxdBAHr8CVefnmIoptYdC4oO5bplI+zxGumUL8Ut/KtJalgeY=
X-Google-Smtp-Source: AGHT+IHx8PwM6AIzlpEzsxr8J+LyWnE7HUOX8ZkDkwcjSfEuU/Kwyf4EVLl7tEc4KnIW1/2mwf+TIw==
X-Received: by 2002:a5d:47cb:0:b0:382:22c6:7bcb with SMTP id
 ffacd0b85a97d-385c6eb4c32mr20727841f8f.3.1733145266761; 
 Mon, 02 Dec 2024 05:14:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:26 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 21/54] target/sparc: Set Float3NaNPropRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:14 +0000
Message-Id: <20241202131347.498124-22-peter.maydell@linaro.org>
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

Set the Float3NaNPropRule explicitly for SPARC, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c             | 2 ++
 fpu/softfloat-specialize.c.inc | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 61f2d3fbf23..0f2997a85e6 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -814,6 +814,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
      * the CPU state struct so it won't get zeroed on reset.
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ba, &env->fp_status);
+    /* For fused-multiply add, prefer SNaN over QNaN, then C->B->A */
+    set_float_3nan_prop_rule(float_3nan_prop_s_cba, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 8a36280df1a..c4d8d085a98 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -511,8 +511,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_SPARC)
-        rule = float_3nan_prop_s_cba;
 #elif defined(TARGET_XTENSA)
         if (status->use_first_nan) {
             rule = float_3nan_prop_abc;
-- 
2.34.1


