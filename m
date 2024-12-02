Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DAAD7831F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Sh-0006eH-7C; Mon, 02 Dec 2024 08:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GV-0002Ht-5K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:07 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GL-0003DH-Dy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:01 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so1479620f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145251; x=1733750051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfWcIGFElRwNWX99Qr3KLu7RlocWXtaK9gnVDhRhWYA=;
 b=rYQ36UQvq20BFoIwyg6hoYkYGV8DeYO09OMqwHm8ugzvZa+nEmEIBID3q/LizzDC/w
 4gd/zq2lCO0KOfhCDU0cc0F1GTHbL4kemj877E8buveriIBx6wfyFd+HJrBkIt26KWC9
 O4LVUwDblY9DH446hR9UnHbKMmjrFXpX65whF9DimMD5kFErOUjDd/3REnTvrzuyg6i1
 M4SJjUWn4IwP44HQ+pTeLtyIvwbKjxSqDD5BCYPipW8L5ldYobnhbQS0+ooEzPK16ZGP
 eVfksAbkapwhlkIE/wq+pFaQqBWOvb3CMUUcDUES9VumGyuq/3sjCcV3WYU3cZc5ugVX
 aoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145251; x=1733750051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfWcIGFElRwNWX99Qr3KLu7RlocWXtaK9gnVDhRhWYA=;
 b=g3wOjQ0a+qPWv6aO35/02+8+TxCQz9nILylKw1PHVZA66/SpfIx42ipBWHM6wDXPMl
 GLDdWQPWeCW6UJ7gJ6EPuTx145lNeSbbcctx7MuWKaPFlCVH4ezroOnINQ6NMpOPQ0Xy
 NCBcsgQ5LqbCsnc6XOg78EZhun2menNq0BBBITPi6q/A/uLVO1BJceZZTYxJTx7jif0b
 1E5obqZNnH5csrVy68vwvYmnqZ4vGVsuKl6w4akbvLr5ZWO96vksSfegkfOfR6lZ4k1p
 FgyTsd6rDvvGWeG9rZizNbUjnmkG5dEG+EtzkLYY6pLBgAIul/WBHUoV82Y1+Pzhv60y
 YfAA==
X-Gm-Message-State: AOJu0Yy2KvUJbIyNAK3X9Pj4F0rAkao1kDwjobDmuSK+BnI0KwyGLOES
 f/lDOXVSIrQ/QRROx3oe1oQrN6P6PU257Jefu5ZXhjvtJhozdPJYEujveSPnE05UfP9dHScsUgV
 0
X-Gm-Gg: ASbGncuek4A+gOBgaRBjeRjgUGZ0mjsjiWNKciHgHL1IpH4aG91R597JMX/uKMsOFek
 gvPNDsCCvDLkY1Nsrxkl5mnMQEV5TTvyr49kYS3ZQ+uTUVjGkLPHcXUZKX+2B1dCgbBjdS5jot5
 JVw3ShCx/X40AXxf53ZmISAfBpFKgKCkj4mMfRY3V5nRQInKXZ5NPZcqoVNzvWflMsJovgZjOnN
 J7mNoVkRR4OJNZpWmTmn/WI1lTbLkpzFCDWzI5MlEIeBJDTm8cywYU=
X-Google-Smtp-Source: AGHT+IFl5ZKDcFMgGIc5LeK51D4mmt2uCTorCPud1MxCTo9j54Y0ZSTaNWqE25haKOFhN7LIYZOF9w==
X-Received: by 2002:a5d:6485:0:b0:385:e176:4420 with SMTP id
 ffacd0b85a97d-385e1764637mr9309692f8f.10.1733145251088; 
 Mon, 02 Dec 2024 05:14:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:10 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 12/54] target/loongarch: Set FloatInfZeroNaNRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:05 +0000
Message-Id: <20241202131347.498124-13-peter.maydell@linaro.org>
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


