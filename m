Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC6FD12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbH-0004UB-LX; Tue, 05 Nov 2024 06:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbC-0004SH-L8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:50 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb7-00075O-0N
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:50 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539f4d8ef84so6731376e87.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805582; x=1731410382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fPC7kSUfAWbQOqemhG63/yTJ4GpbFp+SBxN/5tQNobY=;
 b=dzOgXCcgHEW+8rxmzgs0Vzjz0pkcTioDTpRNs0AYS+572n16EII4kp5sCtGl4VucKY
 769TfT3xddNPOAqu9WqSDdr9w66nwXRvDVVR0+QmuHMriiD9O+vIk3Lu+WBnzzVEkQt7
 cMipmIxLp2YesQZpKCSPhDiHHY/D2tWGeqG5WqjLVMRfD+PEUb48uX3gUhfdeM1u1Cvn
 xHtwemrRBK53XkcP07bH2McoEv38QpOzasO0ioKnqzUvG260dU4I+AvmP2uP2ci1MJtc
 Z9WvcSnnojB5ka+MGZWPLZfg66EEHrXVIPTYuGGrGrmzj7hjwAChSbGuH29cAi7F622D
 lyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805582; x=1731410382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPC7kSUfAWbQOqemhG63/yTJ4GpbFp+SBxN/5tQNobY=;
 b=WvM7bNXVH9j1TKOV3kyixAvOf6KX/yEeMWRYviWmVUbKpXdUKJlolYpjHOMv1WMGTK
 hvNaXqvzbtSOO7ajHsCyffHQpe7VHgdh4O+cqxI6K7Qf1F5kS/FGlaw6WTIsDxqKo5Jw
 7KMh+1av/mbzPkAFVl3d1JTFQUlGK7K8wvwJAEfemvRksRndnD+M+FzFYTpMXltvBVkm
 tNRLAasB7TAenmQJpkZqR8HxjvXbNf8rDm9e7Q/JjQkP6G8zqAitiwWZUnWOlx8v67Ku
 krVhx+APogOo9NN9P6jh1pk6xFwKETESpa4ROv/JwaIKeZZ8/9oRU3YanmWFBTxB9uo2
 Gmlg==
X-Gm-Message-State: AOJu0YyU9tU0Irm8hRK4MbbEJVUrJFezJZ/EqCr8vpwiy3iYZB5uWnU3
 u+nihVaUQUvY+dDWCXsVP+i2turLszqyqZYbNns7xw82ExzKHbkUZZyrJbmUJGf8bFBGij5yPTo
 5
X-Google-Smtp-Source: AGHT+IEZBL2KvCZ5hNHY0TSdCY5sEDnOsqlkcBG6qLXCNvrUODHLPqAs9euvnaMhGjKqpKSVx3NOOw==
X-Received: by 2002:a05:6512:2398:b0:53c:74a7:43e1 with SMTP id
 2adb3069b0e04-53c79e2f714mr9855513e87.13.1730805581677; 
 Tue, 05 Nov 2024 03:19:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/31] target/s390x: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:11 +0000
Message-Id: <20241105111935.2747034-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

Set the 2-NaN propagation rule explicitly in env->fpu_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-8-peter.maydell@linaro.org
---
 target/s390x/cpu.c             | 1 +
 fpu/softfloat-specialize.c.inc | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4e41a3dff59..514c70f3010 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -205,6 +205,7 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
         /* tininess for underflow is detected before rounding */
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
+        set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fpu_status);
        /* fall through */
     case RESET_TYPE_S390_CPU_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 4e51cf8d083..a0c740e544d 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -403,10 +403,9 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 #if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
-    || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
+    || defined(TARGET_S390X)
         g_assert_not_reached();
-#elif defined(TARGET_S390X)
-        rule = float_2nan_prop_s_ab;
 #elif defined(TARGET_PPC) || defined(TARGET_M68K)
         /*
          * PowerPC propagation rules:
-- 
2.34.1


