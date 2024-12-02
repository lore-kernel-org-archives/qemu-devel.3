Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E16D78322
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Yd-0001Ak-Ck; Mon, 02 Dec 2024 08:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6HB-0003Iu-Cg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:49 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GZ-0003CZ-1r
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434acf1f9abso38904465e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145249; x=1733750049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAvUlUwIT6mon/4ZVWSLpgO6VDhWersS5LUlGU6M2Ag=;
 b=hRopcZuPcswnNGhkXpoSRR8R5Y3zE99SgaCXyQGfyZWKsSOiPjWu1mMXz89sHoy/6G
 JTa9SEPc+rQLp8fQJ3aNp5pm5nCpVWPbyLht7HCAPG6WEr1OssdGWRPOun7Uqnbdi5wO
 WyuYdoomVrgBGp/iMi0DR3Eq2+E5G5LQVMHS8kecF5lVt4zCJtbX0EEqC9ZfSijWy+c4
 5+tpxbC/yhiSDf7uKHkJwT5vj7U4qgSVdZVkpqaEToskNJmrXIq1bcQGei5wxxyxXt1B
 6rFa6k9Sei0ktXJk25ufIzQVIiED03PRXKqacqFGKBuuD2q/5eF5HBaH9aBTJ4vmJ7An
 C3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145249; x=1733750049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAvUlUwIT6mon/4ZVWSLpgO6VDhWersS5LUlGU6M2Ag=;
 b=juuxeZHHRHrh9m8xfdART51JfopRtpAK01y5ooe/v7N6O2ftZibrtgtolqFTrc6vON
 uM3EpjEha7UHCV96Cbk+NSHunkspTZyAAg6AfIbcBnhJmnu+mS2t0LfmPkhCpNEg06uc
 uQSl5gM7fMSv+xLECDv8+T4obhKvbsLabtGDOQ/GvBs1IckV7Dusd74FcBQvO8O26hks
 TCwVlY6GsSlLefr8KXUl4CgNMl3tEFMhMolrZKAE46WWTj9H9f/ChKNa+RJLpQ5FUjb4
 kbfNcI2PJmq3bgaNigIO9Aedez8dbVpucZ2dnnlIxIg/u8jhgQY1nLw1bqr2YOVt2GeY
 7iEw==
X-Gm-Message-State: AOJu0YybnCTuv3lKw1uncPub9R62XdVhQNmnDEWnBw7z193gD10Aq+UX
 q1SScs8DhXnn24xVc3f/j7gjlGWyHD/eFVkLehqEcETZmdhAI8dXXvng7IJDYDFQJgNMla+b6jO
 m
X-Gm-Gg: ASbGncuxTHQ0xkaQsTGxGlXOeW4/Qkz9G3mHb6HDTud24bDKtNnyxrlmtxD4Z+ZkJ5/
 23UEay804Hdy5Psrmokri+bLDHy3m9p8lEqKk/uoK+v9lfxRsOHBr4BhrX9QDolYSVEO6xqyF0C
 mu8IbDTaPEUjMo1vWHn0q5t+9p2AaYbfOf/wHezjGidCDqORbuZR+mu7qza5j9zEIksRdB3m2Hb
 Cba2In3V81TNxKs8njpJEa2jby6GJXZJdtEFj9fD6ZC9bMmk4+wOBY=
X-Google-Smtp-Source: AGHT+IE5iv5s3mrYdQc2+fXd2f07qSrhY020mcYzc/+Y1BJ5GlK97WEz6OPBovtSk3AryeNH6ag8Ug==
X-Received: by 2002:a05:6000:4710:b0:385:e013:73f0 with SMTP id
 ffacd0b85a97d-385e0137516mr12146642f8f.59.1733145248867; 
 Mon, 02 Dec 2024 05:14:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:08 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 10/54] target/xtensa: Set FloatInfZeroNaNRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:03 +0000
Message-Id: <20241202131347.498124-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


