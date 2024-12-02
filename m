Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EC5D7831A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6IW-00054E-CP; Mon, 02 Dec 2024 08:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GE-0001xE-Im
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Fz-0003FT-DB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:34 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4349fb56260so36521485e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145259; x=1733750059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qV7tBbcBhiVlOigWvkNnjFqiUrRYKt540d7v7M5Z7xA=;
 b=m9DVwWRQ/aZJ7h3LixRp+C0QBEr2jx8nswDxpQTP+DuU7qE7VJvPFgxVnOzOK0doeG
 Ykc+aF986m/YxVeA89febleUxsbxojzfPvzRfLTjJSLWaau5PxG2F9JvojjZJ7Q+ibc+
 0+/Fog0tDn0tOBRFk/s6Y/hQtOdzpTJo0T+8D2pDrpIsVUHJA7gJXUs3bwWm3OKNLXlW
 0QMGs+KKSwuXcOnB63xmweNlOOYhMRj9legZ7xnZL6hXcXIbN2Y0zoTpmpGd7Fr64uwV
 lBghmG+9c8xgN4qOTVjg2Y8ZseVpQGLNcKlzsaX8otq1hv63Qt16AM1rtOIyqPPl8uuG
 fJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145259; x=1733750059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qV7tBbcBhiVlOigWvkNnjFqiUrRYKt540d7v7M5Z7xA=;
 b=VVU3OdIyTJDgIHqMw7n75DMdAtLxIwRGfzzTHDXdKJ7vkIgEgc7/nJN/cuvwvhL23o
 cqabE6IgoyzTGajezewfed6Z2xwX1cH7GwOo5eh6OJK2yGLinkmStVKPyOhPxVThMVGv
 ry4WDsTEoYPE5dZbZbwoFs1JOYv3qpz7b4IBCL1qLnB7NbS0C/opO74Jn3VQwJdlmElj
 ny8HAHEbjzJkeV7+JUs6i+Er9ieUtaakcCC/LE7KH62hTqna1dk6l14XAK8IHBCoK62y
 JUeJZWYQjKpSgxj02ecTsvmhcGPa3W4PXou1R/FmwrfTMTrL7+oJWv6bLOlQzCCsuwyd
 ejaw==
X-Gm-Message-State: AOJu0YyFNlOAexzA+xeahx48sNIOWJo0/IlfQMjFq+lOMbOxS+JtcDDM
 2xOAYIdAPJs+XwnAJDVDoAuhCKUv30WN5xe7o/WRiffc1b2pUq+rRTI6fnM2DhkfHjvE3btVsD+
 m
X-Gm-Gg: ASbGnctr6/6/YkB7paE8K2lTIXAe/b3WIb6UikD3FYPGtfc273Xe7Sc6PpYlCFiyVaC
 odF0XrcOZ9r8LXhCR+pK4/a8bn644KOF8x1MSjv1Bb8X9Jyzgduz4RrfJReZrmb5VJ9P11iuc86
 SCrY8nad9SwG7o8Z0wejiXcwWQk5Hs17cr+N3l+34YWs0XPMO2H2eyEJ/w1LZ4PFL6slddy8ZDr
 NnPslxDfqOFpLTOc5uoBhuOHEm55QOoKnaoa0G+VBws35d49e50xHA=
X-Google-Smtp-Source: AGHT+IFJClLlHD9zixmJJD7I8t9nu49gsXOm/M1tFSQat4cWaHqcdDYrHisGj/PdsQjH2SFUjBshhw==
X-Received: by 2002:a05:600c:198c:b0:431:52f5:f48d with SMTP id
 5b1f17b1804b1-434a9dfee3cmr216628145e9.31.1733145258795; 
 Mon, 02 Dec 2024 05:14:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:18 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 18/54] target/loongarch: Set Float3NaNPropRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:11 +0000
Message-Id: <20241202131347.498124-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Set the Float3NaNPropRule explicitly for loongarch, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/fpu_helper.c | 1 +
 fpu/softfloat-specialize.c.inc    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index 6a2c4b5b1db..37a48599366 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -37,6 +37,7 @@ void restore_fp_status(CPULoongArchState *env)
      * case sets InvalidOp and returns the input value 'c'
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, &env->fp_status);
 }
 
 int ieee_ex_to_loongarch(int xcpt)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 3a2d0444475..d610f460026 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -511,8 +511,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_LOONGARCH64)
-        rule = float_3nan_prop_s_cab;
 #elif defined(TARGET_PPC)
         /*
          * If fRA is a NaN return it; otherwise if fRB is a NaN return it;
-- 
2.34.1


