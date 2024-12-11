Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B16BE77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRq-0000Bc-Uv; Wed, 11 Dec 2024 11:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRp-0000B5-D3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:25 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRn-0007f3-DX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434e69857d9so5480595e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934022; x=1734538822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HwP8TsYkVd3ug07uHGZQT6C7fkoiKCntvbbFB7VRiRM=;
 b=DZHzssuVjca7VgnxECv0fUA6YJXkeZ2KptEetogI/nyuix2MSh41DGA6hADSGlu7SZ
 v1/Ioxs3omiAQPw9D23lfIvYjWqjYiY34Z9+JleNRWT21+GIQB3THprRnclsF51W1TLm
 1cwtytUVCbXMdZ0b4yTEHEfj9op/GmVwy9D0WI2feukE9ipPo+uRkwGXGi+kEfTfQSw9
 Gin4dwicjLO+sPIpxJ7o2lG5tpq/Fz6vBOENSyOgLXS00ABPEK+Y6SOTxp+c8DSP7RHY
 smen17Jjzs+zk5mMv2eCzNk+Zt6vu1hrgvb8NJ0XC+EOxqO4IRTw7RIybVg0g2nFuWI2
 KFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934022; x=1734538822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwP8TsYkVd3ug07uHGZQT6C7fkoiKCntvbbFB7VRiRM=;
 b=k4SEY/lxYhLGbrgxqQ7QdjAsuFIRuu39COWC/7Kb87o1WoKJI0QeFhYGSLJoNKLQS/
 7QILRGan25wZL+0DTRLx5u/ehxVZnMTjnF38PQJMhjloSKlFfW0mvsxvpdPgBf0pXeRR
 Ht9HQ0h3sU8Cb48amEL0SqhlY6z2HUMWOqs5p6tbWr0QKj7owdb8Dm19q9Dp5Kt8p09Q
 eGBmHZAGjdcUpYN4xjMfQE8+uIAxXXQuf+CqqIm6c2Tv2ZPIpYjLpuVbkM2F9TseoAEI
 9HMi2UoF+k6QoF/6UhdJ0QFsKVKVIC2YXNmD12qtjXLnMMIUjXprNDVHihYNrtkk+Ynv
 Ph4g==
X-Gm-Message-State: AOJu0YwRC+1r49zN9oVs8LvM8dfv6L9pEtBPEuwPEPRT8roSslJ/0Ob5
 qxCQkfLA0bEVDi5JuJCdYrU+jbewJukX6zalJ6YtwgUzyDgaUuM4VoCfMsdzSHXO74BSqoukIRQ
 A
X-Gm-Gg: ASbGnctT0yYXpB8hJKd759bg4M65CqkKq5DpxaUwEW/A2AxBCwzuOjPB/t3PWmJdOrc
 LDquik97dBiyabQ7DIe2b1jq8QM6qyHDI7Oe+nI+Lnzk2Nkh6atSgaLVG+hpZYW0CGm3yyrFUch
 ERmzOn/gw6tyt1K3uMTwZq0Cv7C9kaxBGfgocY/TNg7mRtbc6CsxWAloMCXiqNeFEXs8gEWQs7M
 UuRzSf+bXonbj/mypDtaeD/OOimbf1m0qoskKRNiXj1wQfMLzuzr/odjkLq
X-Google-Smtp-Source: AGHT+IHqujr6LDYPAIU588RSQdkszuKNI+S0uu5dToBz7fIob4k9VzuRud7sgur0CPV20l51Ob6Fzg==
X-Received: by 2002:a05:600c:1511:b0:434:9ce6:3ec with SMTP id
 5b1f17b1804b1-4361c5b1b37mr23498465e9.7.1733934021831; 
 Wed, 11 Dec 2024 08:20:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/72] target/arm: Set FloatInfZeroNaNRule explicitly
Date: Wed, 11 Dec 2024 16:19:02 +0000
Message-Id: <20241211162004.2795499-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Set the FloatInfZeroNaNRule explicitly for the Arm target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-6-peter.maydell@linaro.org
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


