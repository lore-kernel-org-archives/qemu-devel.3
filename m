Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75138C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0b3-0001gF-3I; Mon, 17 Feb 2025 07:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0aa-0001bl-Tt
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:09 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0aV-0002FN-3g
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:07 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4395dddb07dso45059305e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796661; x=1740401461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgrJFLtgZpDkX4+1Ysq/dQP/f+mIraxTRZ9fUF0vhn4=;
 b=mr54D4Cg8d+USxb1vnFhSIgDkeGb431IMxiR8BL2M0JJ9/UXx3AWwUlOdDCSctgaIz
 44bpIiJ62wcxiYXQ8tdZJvIq0KXbRf3j8C/RshTESpfjIhSjcCGMXQpcfddc08VpECkr
 wcghPXNIP4zIBWRdmEm3W2He3tcCS36yxsijy5z2B9wsEcNYyM7f9083t2qjHdnGiLS/
 P0q0epOtWMhwVBH6DZTADVcrGF012ofRKsZlp0sD8wJwiRZCFFxG/zBFvXGsBexmhytS
 tx/nvDhaDSwj4nZkFN0UOcxm1Ej5eNBjDiZ2+ROhZ8d8Or2dbI6ZSyLySzEIOJsn25QC
 AP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796661; x=1740401461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgrJFLtgZpDkX4+1Ysq/dQP/f+mIraxTRZ9fUF0vhn4=;
 b=IRqblejlsceRHgipWuLn59QT+wqrUwqDnLJTltoH9/kSGLhsr6hZ26p4jbjLorWio0
 BTPBH5Ajdso5el/MZfZ+o/WqBoqDZiBm0FQarx7xuNpLgRtq4shUSv3iZ9ymqmS8Luf8
 Qze5SW7y8bny9fHuN1T9xVQ4uPMtKsCeVVjm4dbZXBgLtiwTAy9AIw6GkIyUSkJAuqxO
 eB3unobZc4GLglnTG84U00TkxC3t+2ZWt71B1mbfSZOg7mFh1xHaBOj0Uc8z3fuEblIn
 9mb8q63qwnl76ng6wz56f0nSKzeY6JI9Yn0R5eu24Mf3te2VQA/NE+SLnTbRZsVbzaRc
 eGhA==
X-Gm-Message-State: AOJu0YxpD4KZYvryqZgc0k8ZnSUx4qrfxos/PEj2P78wB62A4698Y19H
 I0U/66YKOkEL3yo/zaGCx4mfYzcjkakvwGSPwVoMG7jrvyR5jKygZifTwUjjkwzh8oTyNE2Y5bF
 N
X-Gm-Gg: ASbGncvEJRy5N8hbjsBThY1Q/hPLhaH/mHwnkJL9KVgifuyFiOcUZ8ft9fRVqUG1QDY
 4zT4Bnm/mxmHAy7YWl3jo1t3WcHGzMa1RiJcZfDPU66zrUx2WRKRIWI5Glqh/G3EvTQ9NYgZVKy
 hExVAiaxkhYmG+sCVvqn666l6QZDFBH37BVpSMtucgHaOiDEfL/FcSFYjYLS+Xfcw5Taj1YIvJ1
 u/Q8VpThPMR4+O7T/ntW4ihJtqnAH6R6kWt3WtCSSBT3/Uzwn15F4kMFhgTwIZYb2TVDRGL72d6
 Gy81Y65srS8SNktj6IDyKw==
X-Google-Smtp-Source: AGHT+IExcRKzam4m6iuxclkv1Kl2iueH/FCXP8QFxxbDee7SC9hVWZ2WaFPKQBc0NA07FuZ4RsUggQ==
X-Received: by 2002:a05:600c:358f:b0:439:62eb:3cc5 with SMTP id
 5b1f17b1804b1-4396e744cf9mr89088255e9.23.1739796660942; 
 Mon, 17 Feb 2025 04:51:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:51:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 03/10] target/i386: Avoid using floatx80_infinity global const
Date: Mon, 17 Feb 2025 12:50:48 +0000
Message-ID: <20250217125055.160887-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The global const floatx80_infinity is (unlike all the other
float*_infinity values) target-specific, because whether the explicit
Integer bit is set or not varies between m68k and i386.  We want to
be able to compile softfloat once for multiple targets, so we can't
continue to use a single global whose value needs to be different
between targets.

Replace the direct uses of floatx80_infinity in target/i386 with
calls to the new floatx80_default_inf() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index f112c6c6737..741af09f908 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1832,7 +1832,7 @@ void helper_fxtract(CPUX86State *env)
     } else if (floatx80_is_infinity(ST0)) {
         fpush(env);
         ST0 = ST1;
-        ST1 = floatx80_infinity;
+        ST1 = floatx80_default_inf(0, &env->fp_status);
     } else {
         int expdif;
 
@@ -2358,9 +2358,8 @@ void helper_fscale(CPUX86State *env)
                 float_raise(float_flag_invalid, &env->fp_status);
                 ST0 = floatx80_default_nan(&env->fp_status);
             } else {
-                ST0 = (floatx80_is_neg(ST0) ?
-                       floatx80_chs(floatx80_infinity) :
-                       floatx80_infinity);
+                ST0 = floatx80_default_inf(floatx80_is_neg(ST0),
+                                           &env->fp_status);
             }
         }
     } else {
-- 
2.43.0


