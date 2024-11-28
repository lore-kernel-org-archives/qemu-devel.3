Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D31D690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0g-00039S-Id; Thu, 28 Nov 2024 05:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzd-00023P-S7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:31 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzY-0000Vs-9i
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:29 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3825a721ae5so422569f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790602; x=1733395402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Xo5Wy1Oob5f6vaToYcDecYPVf+U4Qw0T3qC57WwruI=;
 b=Nc0exO5CcK0xhlJS5GQsHiePdPyGAvqMFIN5ofovibiY/falTMXd3f7b00K93gRsX8
 vrnURcg5pbS1czGhdlZhktGwvOp8OdzIOdvm3jesdj7yzvzmChYbE+EmrehEhEFGoB/D
 z13IMLzIx0GDgXMX/y+N8MRy6/MoiAVDg4/2/diF4Kw1SoxrYyRabGVwcDLagSdGB7aR
 kluFCVDuwYzACvOO/h2bXYZCTMoILj8ai6lW9HrXp7i4LWoWS7QunWlcJXbGqhoH5Sfu
 gNVbD5rt5Fjm32IWpZMyasuanQtnp/1EO0T2jva7Q2Goe4AuTkB0LLZRNjpK+1Uch4Yq
 id5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790602; x=1733395402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Xo5Wy1Oob5f6vaToYcDecYPVf+U4Qw0T3qC57WwruI=;
 b=HhfvYWIsdpXJPfOLd24ljyMi7MHPMiQqLXmWnODSttzSUcjCWTR3WX3euyDtuXZWeJ
 46Ynp5Ld4vzutU8Kav1PX/RYh4xcZzLcr6rtT6AYovRWafYaozHnXXQywA7I88rrrmyl
 GSFEeonTB/BrLzBlvYjqVqdX9t/oneqB8z2uMVZ+t1DqSDOT+2E7tM9+UZH3T1jECTB2
 JecoX0FeNHrOMnMVOXyZOO1BTTtI8rLZ5mN5kobU9NNaGRMqDlgGoI4geStlCpgQZoIr
 6YN/Muu61zJ6sdJc5KG0TqX9vvVwsnxg4E/drVu/cnDR01Rn6y6UvYlYNrGwdE2fr4o6
 3s6A==
X-Gm-Message-State: AOJu0Yz2ksG0Qfprdj8+s5XWm5KttcLCzCbSclh6yg8nDGnUG5xigVt3
 59gpPME/LqetEZUY1P9tuB4gt55eQGYmnWdwjcUSbdDCvZUjubqjRGUZ5hxtK5qDKvVTISkzQTW
 k
X-Gm-Gg: ASbGncu0kOhG0V2zedOgsSs/mwrD7fnm6Gi44FAUUTI17+Bu1uZXmH4jfcLSaizXmzs
 ql/fjC9tJpquEOoTY5wnLRJYUfZgavm91OXpAQsLxl+N78dbl8Om+PbkqfOG/YK4br0D9TJUujy
 IZhnvoFJ/PU24ZXVAJkyTL2t/KzOBJKDZz7EfUu7ad3rnjVJQuk5q+wr8eyYZfHzqtsBmyjXE7J
 bKKWU4ZUyXHBL3oP4ExF/NUPahbEIcS3Yn4u6TcqZBlXUg34HFa0yQ=
X-Google-Smtp-Source: AGHT+IE0L4AkhdeezeQ/JD+j+p6w163oimx4niPfIoKvMFa1FON378FyJti0jZc6IH0q84O2KRaDnQ==
X-Received: by 2002:a05:6000:2cd:b0:382:3210:a965 with SMTP id
 ffacd0b85a97d-385cbda22bfmr2394884f8f.24.1732790602080; 
 Thu, 28 Nov 2024 02:43:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:21 -0800 (PST)
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
Subject: [PATCH for-10.0 10/25] target/xtensa: Set FloatInfZeroNaNRule
 explicitly
Date: Thu, 28 Nov 2024 10:42:55 +0000
Message-Id: <20241128104310.3452934-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Set the FloatInfZeroNaNRule explicitly for the xtensa target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/xtensa/cpu.c            | 2 ++
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 6f9039abaee..3163b758235 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -133,6 +133,8 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
     reset_mmu(env);
     cs->halted = env->runstall;
 #endif
+    /* For inf * 0 + NaN, return the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     set_no_signaling_nans(!dfpu, &env->fp_status);
     xtensa_use_first_nan(env, !dfpu);
 }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 7e57e85348b..3062d19402d 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,7 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
+#if defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
-- 
2.34.1


