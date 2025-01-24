Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257EAC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMaA-0006xx-0Z; Fri, 24 Jan 2025 11:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYQ-0003vs-HS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:12 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYM-0005V4-T8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd730so16567515e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736144; x=1738340944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ctBdNSCgNxxr/c+03Jcl4N1Ew17aMUfE9iGYWizzwVk=;
 b=YxKEfvmXa9Y9G64ZnuDpcY9yti4X5TcJ4OeKS7yeUa+t9Xqw6jKjckSLjqS1X/AjWO
 pSKJy3HtVwrJdJUw8YT3Gamyr+Nytk+CJNLuksxUfmwbO+a+7JwJA8v/S+88YxSloW7b
 mpX56ixk1biWCHRGwtyDMLRmPZOrAZnif2D1rrpGRaZFPzxFyhKF70tpxJwHjFzzV5ZC
 VVSBRzdZCTUeRTIGKj/vkCskxjkc0yoG0zSFWexB/A/WvxqABxGs2rPUi3Q0Q9gJZLol
 Tjj4YyFbpItr5ur1hSIcGvhuZogBcQm9nLrf//9Tsd+WOmfvQIiPQPTDkXKSPYClMVWW
 6a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736144; x=1738340944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctBdNSCgNxxr/c+03Jcl4N1Ew17aMUfE9iGYWizzwVk=;
 b=SVA5M5Vjph+0Uw5kxnWlM8BRYiACFYHLJExScBHG3noWehudR4cn15b3oFHO4YmsgI
 YVJmNZh25EMTMd69iOkrwOdqUVlD2C+NuwZAuMdGbQpeHbIdg/vl25+NKDNCeyWT7zdO
 6K6QTozzQ9HBC5Xi4u9gGtmTHz30SZHJFISP+PGwLTO0DYOs/LGwlzT0gYYZptQBT0p8
 +b4UZ3kJh2W7SOMEq7fIspdVP7T3rfhmlCbSftmQBehyaExvovYmA+MKFBysWUj15B0j
 TH5qh37JJEl9tmnIYc5P9QXWL27QnuKue+o2uHkmm2x5cMPxoEPJOVgNXQm5Gn8IsTXa
 Pqug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmdlWtBXHZXlsk/x+zHDCuB1kZw5A+4LQH/vw9koXwhBdYjHzECJ3OQ3XcH+3PD+G3aT93elRjlNPA@nongnu.org
X-Gm-Message-State: AOJu0YxjTuxiAk82OpQLy2ele7v++O3WxRBYZaHVn0z7yrtm6ZY24mtJ
 PlZtwtOSgQJ0QndEnKto9IKL4Eo7Uq1Qlonkkpo2OWzpEjA01BBLqEwXlmToyUxbD2N2vzuHHRM
 u
X-Gm-Gg: ASbGncsjAAvHBh0Nsu03KuOdILtSQROW4kkuEXd5jvAiCwgNBr3CNMzFbJNjh6RW/GI
 TV7u7YPPaUEsyjznjfpF1V3cPeyh7WYIbKfAGPkOtJF4R4LYnvQFLXKHQPmxhw1cdd0xtgCPmuZ
 7fwWYaAOUNxejKrbwQM6EH4yoFtczh14+8F7nW1blh0TtB2H/kQUfFiNhAli3997gNwF34hBib0
 849tBQrba+dWtK0QN9uZGsTJuuAQdYxM69zyBpRp4uyD/jQ2mXkXLcdPe7pDUSLldOrt/YqJ1uU
 wbZk88EXa3U=
X-Google-Smtp-Source: AGHT+IEKbiXuaiClPeUPft+hCuS3T+a5vtfwIB1kOzJVaCeaZL898Tvq9MpGqfpNsR2kNySl+2Ql5Q==
X-Received: by 2002:a05:600c:5112:b0:434:a5bc:70fc with SMTP id
 5b1f17b1804b1-438913cfa0emr282088945e9.8.1737736143921; 
 Fri, 24 Jan 2025 08:29:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 21/76] fpu: Fix a comment in softfloat-types.h
Date: Fri, 24 Jan 2025 16:27:41 +0000
Message-Id: <20250124162836.2332150-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In softfloat-types.h a comment documents that if the float_status
field flush_to_zero is set then we flush denormalised results to 0
and set the inexact flag.  This isn't correct: the status flag that
we set when flush_to_zero causes us to flush an output to zero is
float_flag_output_denormal_flushed.

Correct the comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat-types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 4a806e3981a..c177923e319 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -312,7 +312,7 @@ typedef struct float_status {
     Float3NaNPropRule float_3nan_prop_rule;
     FloatInfZeroNaNRule float_infzeronan_rule;
     bool tininess_before_rounding;
-    /* should denormalised results go to zero and set the inexact flag? */
+    /* should denormalised results go to zero and set output_denormal_flushed? */
     bool flush_to_zero;
     /* should denormalised inputs go to zero and set input_denormal_flushed? */
     bool flush_inputs_to_zero;
-- 
2.34.1


