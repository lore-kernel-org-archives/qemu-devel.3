Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267E0E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS1-0000GJ-Qx; Wed, 11 Dec 2024 11:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRv-0000Eb-Jd
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:31 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRu-0007hR-09
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3863703258fso522114f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934028; x=1734538828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MfZN52pgrp+/nZeB9BI1gMkKMPo4Kihy7pjqat+nckw=;
 b=E2JLlQaIAuqbzeFZ3JhjoeF/ZjSGhgRg9iv/883rK2P9H7etyeWzoeB6t63HAZvSz/
 ke5kJqqPk8mYvMsOL4OzDFhcNw45L/WxvJrz1Ma9LML3TlEtBimYShTi1B9h8jTJ2p0m
 KicPlSjcSY9eA4zs3kl6Zmq6BGhUZSM+GNU8sMKpwHzDPA8c4ybuPWHaRltR2CUAAaOp
 cHIL1PxLezMlF6golkUeaFPqe+oQJOGvnXnzWMyNr/KiS905ywMU/U0gmYxd5lxOps2o
 LOanluM08I/BjeUKeA6XIYWtkGlYL1KSnC02OCV84lv0698PnkgiQ8A5tb+gy37uqm+5
 hjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934028; x=1734538828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfZN52pgrp+/nZeB9BI1gMkKMPo4Kihy7pjqat+nckw=;
 b=PJ1ftIvQ2fVyWOLW7Ngv1LjY591iW1hOu5ik9Nv+rq/gjZD05ZsDmgImz2G/OzmVuZ
 00Duo02hGS4rQB188RGt4nlMYg/npA6tN+2L7d9kjzhEAVSRTCxh4Eh9fAPa3IOldWrL
 rlxjEF5xv1w+dqqJnI5xlv8rY5ri/k/t+4gVIAP6rY+c6X1WpTPIwfNXXEbe7kVI06t1
 EBJQp0H8+4Iu8T2r5VUSaBILM6qHw/yvxJm45gIRAde23lMLssAap64y0bR/7aBCqjpr
 DONaXj6jhnZaCNH9XMmJ2JP2RdOqSeRqFO14Z4Gaug6cGj+kcwvjmhKleoBxMm3Nk1TH
 r6Mg==
X-Gm-Message-State: AOJu0YxDyjNJFhdHtfRGqonswiNV3wuqQ4qFkC39CTgNhG8lB0lcXRUx
 RJOO/Tq5tyiYioc53V2w4iysCtClUdIk3mIqIhM8D9VWwXxAPOAmgwk9ix470Wnv4sF8hZjgWa/
 v
X-Gm-Gg: ASbGncvUN7i5iA0ZnEPBV9pt2nebjHytYqZdSOzQta4Et+TFEHj+P52NJgrhFc6Tpdm
 ObF+Mc5cWJk6BMbYuuE8kmTJYJ1CfOFo/KlpW0wAxLptZskbsmbX2j7o9sR6HO/QpYZDh9Dmcx5
 1Ozp5aHCjc495CXTIrfTfGJ/wFuaVbYeyiGnPcfjW/WnxBsKkgXmEHBkpo3okPVztJMa4oz/6qZ
 6jcUmTv7QUwJ6tUvgRw/vzJkCcdA4FUrfl3Q3IJGHAUHcfeuW7uxf7qcL+S
X-Google-Smtp-Source: AGHT+IGYPYT9QaEVX/rw9RpTTkQaovLiWIPuafnp3z7jNi3SJTpu3hXN+wWLOF6LW9Gvp4GxYA6oBA==
X-Received: by 2002:a5d:584a:0:b0:386:3afc:14a7 with SMTP id
 ffacd0b85a97d-3864de9e223mr2310317f8f.7.1733934028379; 
 Wed, 11 Dec 2024 08:20:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/72] target/loongarch: Set FloatInfZeroNaNRule explicitly
Date: Wed, 11 Dec 2024 16:19:09 +0000
Message-Id: <20241211162004.2795499-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Set the FloatInfZeroNaNRule explicitly for the loongarch target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-13-peter.maydell@linaro.org
---
 target/loongarch/tcg/fpu_helper.c | 5 +++++
 fpu/softfloat-specialize.c.inc    | 7 +------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index 21bc3b04a96..6a2c4b5b1db 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -32,6 +32,11 @@ void restore_fp_status(CPULoongArchState *env)
                             &env->fp_status);
     set_flush_to_zero(0, &env->fp_status);
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
+    /*
+     * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
+     * case sets InvalidOp and returns the input value 'c'
+     */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 }
 
 int ieee_ex_to_loongarch(int xcpt)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ad4f7096d09..05dec2fcb4c 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,12 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_HPPA) || \
-    defined(TARGET_LOONGARCH)
-        /*
-         * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
-         * case sets InvalidOp and returns the input value 'c'
-         */
+#if defined(TARGET_HPPA)
         rule = float_infzeronan_dnan_never;
 #endif
     }
-- 
2.34.1


