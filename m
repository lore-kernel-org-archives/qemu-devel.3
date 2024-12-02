Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B9ED7831F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6UT-0000mc-6A; Mon, 02 Dec 2024 08:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gl-0002cA-3v
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GW-0003N9-Tq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:16 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e06af753so1546861f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145277; x=1733750077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0Xx5AyANaS6WVZhR0dQwQ3Dsfoy1K8k2mwf7TXf+0Q=;
 b=pn7j5F7MxljhAZcshslSRKChxuW/28uW28iSKscwQRhLg+R2SyiZuoQmoxEWMx6pRR
 uhIv1Qa7dKbK0EKq4lsnoofjRHHNxdOaKuBD3gqYn+7PZXFsAaFHrmgpbUhn5cH1TOdB
 ZWtKTGRSBOMTHgz941HE3I+cqtN/JzYyFIaCph1REBVxSvj4Ae2lkc6XxyT2ei94IqCM
 52zbtyJs3nGUkrv/V6+hQMAEmx/iylGc0mbjVsOvUS4sUmDeIR1deMVf38zfPK3b9yQ9
 2u2vwwHAWfbotBwTmegttbyoPZmY59jfsrV+W2GIAUKbKOU+HS0nyI5WIJVKOcoQHeK3
 70wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145277; x=1733750077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0Xx5AyANaS6WVZhR0dQwQ3Dsfoy1K8k2mwf7TXf+0Q=;
 b=spUu6StNBS8dYsY1xLvA1uSPzzncYQ/PZiijocBv/s/TA1njmGMo610+sYFtCKoUhK
 IV+omU0LVvA9ppI8tHwXeTNnA3SlSrVituUqa/8ilyhJplk23h6imgsE7xgHRMTzp7T8
 H+6saVNWmNJUrGHWg1rCmDukWZVpM7uCyaPZsf0PYYrnG5WS2CUB8UJHLn1H1Ozyjafc
 nq+afNPEiMF0h3wh1usbxe8uEUvWaP/9A16+wFWyZtVqEThGZalFxlgoDJUPQpmAgeW8
 WvhL6n2bdP0S0zstun261SqAE8udqhXSP2jgxC/jkIHDwjvNRzSPxdkGBJEC0tblQg/6
 WCpw==
X-Gm-Message-State: AOJu0YxGdLBUfnEVGS4OyLBZ6zELne2f4sIDafatHq9bp/zP256ojgQz
 k+2Db8Nk2JElGzToWwwZ6gTtbqTxnhHrM498sSlJSumwQn2+HrqajOdvaoDoefROkFfQiBu1Yms
 O
X-Gm-Gg: ASbGncvRjVbcyrXDHDVyRZTh8Woo22CtCvnasE3WmXxR7MRtcs1Dmo+4C6evcsZ0X9r
 jjB8QjmKg/MhTBlmrkoYzoFbHOMm19r6cUmwvvc8FA3Bl1pjMd5WthVh8q0LWGO3GXloLyzVgos
 MfCHtqpHmPcZF6vJv43Y63oYliMRJCy4tB2oCp5Wyiaq8dHCdbqOsEGxde3U9qaHeTkixGoIWik
 3AmBqTTyJ+M593IOp0t8xRzgPmkqP6qn1iyjMndNxofodc23xNQXA4=
X-Google-Smtp-Source: AGHT+IF7/dDg8KXtRoJE3fE/ctSGSHBQI+1um0ZFXkjxt7vXDSSfH94Og34g1HVsiH7CtOchKtbbog==
X-Received: by 2002:a5d:5f8d:0:b0:385:f2a2:50df with SMTP id
 ffacd0b85a97d-385f2a253a2mr3340910f8f.27.1733145275906; 
 Mon, 02 Dec 2024 05:14:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:35 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 29/54] target/loongarch: Use normal float_status
 in fclass_s and fclass_d helpers
Date: Mon,  2 Dec 2024 13:13:22 +0000
Message-Id: <20241202131347.498124-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

In target/loongarch's helper_fclass_s() and helper_fclass_d() we pass
a zero-initialized float_status struct to float32_is_quiet_nan() and
float64_is_quiet_nan(), with the cryptic comment "for
snan_bit_is_one".

This pattern appears to have been copied from target/riscv, where it
is used because the functions there do not have ready access to the
CPU state struct. The comment presumably refers to the fact that the
main reason the is_quiet_nan() functions want the float_state is
because they want to know about the snan_bit_is_one config.

In the loongarch helpers, though, we have the CPU state struct
to hand. Use the usual env->fp_status here. This avoids our needing
to track that we need to update the initializer of the local
float_status structs when the core softfloat code adds new
options for targets to configure their behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
It would be nice to get the riscv fclass_s etc also not to use a
stunt float_status, but plumbing the env through would require
fiddling with the macro magic, and in practice for the is_quiet_nan
functions it works out OK.
---
 target/loongarch/tcg/fpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index 37a48599366..aea5e0fe5e6 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -359,8 +359,7 @@ uint64_t helper_fclass_s(CPULoongArchState *env, uint64_t fj)
     } else if (float32_is_zero_or_denormal(f)) {
         return sign ? 1 << 4 : 1 << 8;
     } else if (float32_is_any_nan(f)) {
-        float_status s = { }; /* for snan_bit_is_one */
-        return float32_is_quiet_nan(f, &s) ? 1 << 1 : 1 << 0;
+        return float32_is_quiet_nan(f, &env->fp_status) ? 1 << 1 : 1 << 0;
     } else {
         return sign ? 1 << 3 : 1 << 7;
     }
@@ -378,8 +377,7 @@ uint64_t helper_fclass_d(CPULoongArchState *env, uint64_t fj)
     } else if (float64_is_zero_or_denormal(f)) {
         return sign ? 1 << 4 : 1 << 8;
     } else if (float64_is_any_nan(f)) {
-        float_status s = { }; /* for snan_bit_is_one */
-        return float64_is_quiet_nan(f, &s) ? 1 << 1 : 1 << 0;
+        return float64_is_quiet_nan(f, &env->fp_status) ? 1 << 1 : 1 << 0;
     } else {
         return sign ? 1 << 3 : 1 << 7;
     }
-- 
2.34.1


