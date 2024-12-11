Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8B0E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRw-0000Er-LM; Wed, 11 Dec 2024 11:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRs-0000CY-Rr
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRr-0007gb-7s
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361a50e337so11078715e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934025; x=1734538825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ec4PeXlmg7CtR/PXfmSknGAM8RrcTIj+cvTbuOFtEy4=;
 b=pSTaD1Nm43/gBYTdPld+9u59QRWGv8PjPYCTHMftgKH2i25lolhahKyLQxoU5n7RSq
 aqaHBrIhX+yCy0Q+WglIHkEQV6tA3gxEI44K7ZJsJp/5zPMjQmsSaj8O1g9gQa6cXHOj
 zqpaCuKE1Ehon6hiQUNnZHRSEpPRlUn+oS8ocDjWErCIgyCFUY6Luyhp1JpR1Z0uULhV
 ikntkT5wJo13kqQTSqCDXWiODen6jdPcuBx5zpMhVyOxvQd/JfPHiDMHhrfO9e/KIeGg
 jYk0oyTZmrb0o6/QQ5B2BGus5emN+gGFcgjE0p6Rex2sGY1dHepgOmZdqJKnjlCazplK
 uvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934025; x=1734538825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ec4PeXlmg7CtR/PXfmSknGAM8RrcTIj+cvTbuOFtEy4=;
 b=p5gIK55mq8hj8CKDgNDaRFh2TGTp1iaPtFSkB8gr5xjzZqlggyTNiHS2u2ttXmBTY8
 6H3/T0PiG6T9+JRiL/25+T4cY3Yq6mAkmH0GYpXnuz6xv6ATSYX73RlAhxZn6rAXKcox
 Z8AbJlYzoNg8ByVEcW4XIlhBs3Vxn0IOutCFLHia5//tbFgDxnFD1Lc2viAxM2AUnqkb
 jnoxDmyhelAi5mTIT0VxApNJdgpkg8zW/q8yCUA/idQRMnKfdYx+dCq75g8ZrBtTtEHQ
 XsHE4Sc9vBjI9tGcMgAHi3PUrg3HRUArhRPPC4COaSYU41rqUpFA64EwNu/TR2VTVAQF
 Tthw==
X-Gm-Message-State: AOJu0Yz9yZTAGGTaCycBXFqOf0sr+HDJVp2qjYcZYbE+OPtgsKOakN4H
 ZVAOllpZKeyTFG+9GkSN9pU72oSAg6dbYNmOSxrRDDS4GVDuzqPumyZsZlzjL8lqRhvPnPdt/hp
 z
X-Gm-Gg: ASbGnctWGYqD6efCpcXSj24svRWaTmRxi1WlV8XCty2ddXQuoAyEd03o8DC+jHmP6l/
 UOzKswwHckbfzg6gb2FALKbD+y3/PchkTzXIU6FU1Lcnb/ul+q7HS7xrdijfnIobVgSpTo2C+I+
 xxW9Qxnrx5XPobKcGaNlxhNJkk4MST8PA/e4CyqHtPmq8Q2HJiU1/nx27OXO22ju1UPID0f4Emp
 0Hj+asnWQEZXlWaH8GTgHM72QzJkqqtpNewNHlOGXy8ftPtWM1XvzKR6faR
X-Google-Smtp-Source: AGHT+IHJnppq2CoS0hE17Vt3ZVYBR9CTS+SmhdW4L/YKW64+BkqDPO0jnveWamUnTkaMbtUnm/vgmg==
X-Received: by 2002:a05:600c:1c82:b0:434:a04f:2557 with SMTP id
 5b1f17b1804b1-4361c396b7cmr27999955e9.4.1733934025481; 
 Wed, 11 Dec 2024 08:20:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/72] target/sparc: Set FloatInfZeroNaNRule explicitly
Date: Wed, 11 Dec 2024 16:19:06 +0000
Message-Id: <20241211162004.2795499-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Set the FloatInfZeroNaNRule explicitly for the SPARC target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-10-peter.maydell@linaro.org
---
 target/sparc/cpu.c             | 2 ++
 fpu/softfloat-specialize.c.inc | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dd7af86de73..61f2d3fbf23 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -814,6 +814,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
      * the CPU state struct so it won't get zeroed on reset.
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ba, &env->fp_status);
+    /* For inf * 0 + NaN, return the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index db9a466e05b..7e57e85348b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,8 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_SPARC) || \
-    defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
+#if defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
-- 
2.34.1


