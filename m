Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C316E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRt-0000Cm-Vc; Wed, 11 Dec 2024 11:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRq-0000BL-2W
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRo-0007fN-Fb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so7262085e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934023; x=1734538823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T/PmqSLjuyiOzk/RkL1cFPZCkALByoouQahg0DiW16g=;
 b=l8qIUgEeOYe/EvV3VkTMhjUTIAHvnYeJEVd2A5wjg3N50ZJNzPPN8+/ZcsMv6R3UL8
 Zy2ul6waB+3/UHVCwSqa+cI2EmgZHva/mNsjOQfet38ug3sga5UzPmH2t1lNFcOYNeRU
 GYR3xS/N5f4rA2xIdWPqnvXoyUVTqUat08T79FwN6+zUAUFMoCZEcturVs1UBi2/GT1d
 bvByc/gEBMeAWQXu/MG7vznJpo0mSIHxadVB4dh0t+Cp7vLxnLopF3+6VJEJqd+PANht
 jdt8Xny0uhEyXLACyfpOwj7VIrDJ4dXxarShR5tgJ7iTkXlgKZ32X0I9jFQhRXDmgp1j
 sCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934023; x=1734538823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/PmqSLjuyiOzk/RkL1cFPZCkALByoouQahg0DiW16g=;
 b=T4w6CdzS2ABRxO4SPZkVpmJTewEW2FZhECzSNNsPitWZFq8Kd6wFPfh+okEMQGp9/7
 eHR8hrdx5UqEmmpHWMhURkRY/RkTyrjKZ79YC+iKPLk/zb5xdXvldWf2TCLn3F8kWn7V
 Lj6a+jtn6+whMxCFQAbPOjJnpguotswQVp2RwYiaVEi+Sj+wH2rZRvuVs5TSHlq7MaC7
 qAoB8XtM9cy7DSAn8arlbURYB/hNb/s/qoPzQlQoqEYqsrB26FhoFF8d8A1Rr0jyNCm+
 D3+873ZtbDcZv6RvWLnFX21ZaSrTrgqw5s6eCVJSqtgwG7lTLEHIKOPcGx/YzUKFA22h
 k0cQ==
X-Gm-Message-State: AOJu0Yyp801vbO5X8oRPna+Oe9YdTODSRaXYvj9onDcA4E3FUEgT/4D2
 qYyRDQiLhoF/Z4MaX7Ea9L8ufMHZmChPmqEnmyApXZNTx9wAZidI4p4TCgy2UL/wIkGy4EgCf7k
 o
X-Gm-Gg: ASbGncvCa2ayAinoKwPsCaJkYgCmG6jlkSkSKkP/uR3LMPzmYhQIGR7XzfO7QYlFC0K
 V+kxOpNIXgcqrXX5ynkfyfC7ZCPvn9apaCGZTRwbKcat4Iz7zLhrihiaf4SpqObuXqMa4RewFpa
 i1AvE7sBY7XbiLsP6qb0opeBWI3XdSq7FLy1DqlI228SGOACf2K3hDU1U7/ZRbIWZCy/YoLXT3D
 cDvxZ5jy9xpswAOznikn35IuCVMendYbuZN8M7K5Jjb0HsvdsOX/vVvvzIo
X-Google-Smtp-Source: AGHT+IENWHEbPOToQMg1n+P3JqdsMMU4m6oSTj89JukkVcbaSoqCzOlwawBzWI8aM7UhsVYPCcwzow==
X-Received: by 2002:a05:600c:4e50:b0:431:5df7:b310 with SMTP id
 5b1f17b1804b1-43622832e88mr2956715e9.8.1733934022728; 
 Wed, 11 Dec 2024 08:20:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/72] target/s390: Set FloatInfZeroNaNRule explicitly
Date: Wed, 11 Dec 2024 16:19:03 +0000
Message-Id: <20241211162004.2795499-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
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

Set the FloatInfZeroNaNRule explicitly for s390, so we
can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-7-peter.maydell@linaro.org
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


