Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F399BD78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Ua-0001YK-Mf; Mon, 02 Dec 2024 08:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gl-0002c7-3T
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GX-0003YM-1m
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:17 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385eb7ee7e2so757757f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145295; x=1733750095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GcCmSt30lYdPKkQM5ubQPjbLlX8F5CbU10wVOuOifdc=;
 b=cBZvp4eV9TEsmZ74yRvBAdnusXyZRodVxTBZko2aXM7IfaTwnuhtUSIuM6p0DdU9/H
 eaH4tm/kucgSpiAcOlChL8uxmp11nfCNGypvjwBDpibAa1xEqHIoZ7ujYs57wJIBctoF
 bjR3QDi9c/JUgrCwi13c8rEO1BXJrNIPwklecJO+fZ1CZOzGhO+EieB05KbqjHeZ8ddz
 YmmoU2cVmWLNvxusjxxtWqpONn8n3ChjkwSG0PArhFqVU5K+BtVsZpnNvRDRDq/4c7Nz
 qO3mwFDyy03Jsl+JRQyXKaox/UN5PQWhgsAYPqQXERlTMqpMgGzW4LXXfaDAcIuJUQ50
 pdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145295; x=1733750095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GcCmSt30lYdPKkQM5ubQPjbLlX8F5CbU10wVOuOifdc=;
 b=cOHyBd9Wdgfx3FCsk6CT18xJgQsHSCca8SpJOgrdXCV4t9IchwAd8AM0sRgD8oxWUL
 lqe4lkll0NXWKZRSMRr/MvVbi5RkzcvALnRQigHsTg+5sKxi5K6JsWwmztxbrKbptKZi
 m5t8koMByMqR2/wYSKl2c4HxV8UOV5MzeYNBrDUtV2d9zmMyPks+CkYNu4TdHRuCaV7/
 czusWZVJXndC/VKIoyUf4G2KFAtbtOqW4C5J9yBWWdsrKKaMdn45eoEJdS4//HJK6veg
 Hjus/qPUAuSVXMVSC1AijfRgQSm2tjSBUcg4VyLQGPY3O4Rza47D0DrHVYL8J4J0HKY8
 nhfA==
X-Gm-Message-State: AOJu0YzL1m3oxPf3JEApjZwkNMVK6RWxxwNladwDfCe1gDhCUGXTfi8i
 rdrZR0VaD7Ppa09bcZLSXOLcc3AS8VL7IFnZaDfX8+cBT0Gil9ZmHoRkqlRbYTqjFylOqlO2+dH
 E
X-Gm-Gg: ASbGncvUbB7R3iXEsGDw5pHszHMHmpJ+7nfyzbfAqvSeVXB4faLi9U5EQGkmAWCK+VG
 GQ+t5aWRcz+9DzPkMxC/bw8Trc9L9n4WrEAr4EpDMU3KlYVaP2IGvSl76qc0lerBlrET8ajC4QX
 Tr29gLiPyyGno4PJcR72/3zYdbN+seT7JEzZFOJqYUEetqIJvEBg1RBBifN3rcbbb1e5mPxcA7K
 qRCWRVRKoMzenEofCM9BRAUxNOtDxD7fJDjXXRIL1Fd7gb8uZXWFYc=
X-Google-Smtp-Source: AGHT+IEMWA8R+sjb0UDNLKxMw0MrwaLmHVv03KFNhEwVlZ/CFQlwS2cTAsuf1zTSP6YRWuLQN4g/Sw==
X-Received: by 2002:a5d:47a7:0:b0:382:4f34:ef7f with SMTP id
 ffacd0b85a97d-385c6ec1011mr18645015f8f.31.1733145294496; 
 Mon, 02 Dec 2024 05:14:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:54 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 48/54] target/s390x: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:41 +0000
Message-Id: <20241202131347.498124-49-peter.maydell@linaro.org>
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

Set the default NaN pattern explicitly for s390x.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/s390x/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index e74055bad79..adb27504ad5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -209,6 +209,8 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
         set_float_3nan_prop_rule(float_3nan_prop_s_abc, &env->fpu_status);
         set_float_infzeronan_rule(float_infzeronan_dnan_always,
                                   &env->fpu_status);
+        /* Default NaN value: sign bit clear, frac msb set */
+        set_float_default_nan_pattern(0b01000000, &env->fpu_status);
        /* fall through */
     case RESET_TYPE_S390_CPU_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
-- 
2.34.1


