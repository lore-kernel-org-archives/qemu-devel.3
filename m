Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B705DC0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5J-0006No-EW; Tue, 11 Feb 2025 11:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5H-0006NC-8o
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:03 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5D-000318-QQ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:02 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394a823036so17350545e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291158; x=1739895958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dM05yax/yOR1dNSXH7LQ6wcIVot/e2PVCR/pWphSyGk=;
 b=U3aCY2U9XWlgRgO4uUpsy7vgoUjAFwSVFuzfi1dZhiyO9mb7MQGmpLHs80kpzC5lMe
 2bflCdxpjjydqSVDvVJRyUEHEK1yeAx9yIqowXbmKpo+N5rFAma36Jr9nJ/ao3ytdEnk
 y8EC+nnwQ6dCqzxpQxNDHotwF+pU53u5mCS/NP2+w6lPo1jVV7RI8kO33R4RhImiUltg
 HuxwvpMG9eRZbHkeClgZEwreIYPCjSDw/hpN5j0VfW5IlLJivCGA0QvJNAhYhej1XZV4
 t1lUKo6MB7kmuujB+a3r/vQq9PRzM3d4k13Go31btY3qRP/GvDegUlVuJWEG33xp5QJb
 L+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291158; x=1739895958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dM05yax/yOR1dNSXH7LQ6wcIVot/e2PVCR/pWphSyGk=;
 b=vSvluY48fAzguijhVJgt77pP21Kf7N3tXSxpSGmQktzrAJ4iMKZbQux3ldbNLfmFk+
 cjxKEo2VnjCt+rooDvKBbHry7x9VjcByxodg5n+utNsQKoFVCoW124pgEmkzp2KrqauR
 4Fpuiqe+wHM8mQU0VqWUFVj0LjeVPy1WUeI8WKKvxjZnwH2OpKkYclzD0z5tu4c7pUbf
 qthfr4M+6tDFs1EEhWLr8lOf6YERCtek7wFqzW6Uumek3/D9ptF3eQSJuYF8bsROAQjt
 cVgor/9oRVcZxsm+KxDK9h1KntezESzH9NBlglv8ghDLBu9ByS4QixMDeIid5xBxgbXf
 35Xg==
X-Gm-Message-State: AOJu0YxkBKlaMXMwfEOCgxtNw84nUsfFqg+ILK/FtlwEYBn9ld9L3pXC
 RhLzTwgb+ctzzXi1NWUsf7qoJnmahwT0v88p/ygxXPnldTASZ7lhBjABWEBJiMUrz09/RhJC8uY
 w
X-Gm-Gg: ASbGnctVv53j0nNSYa9GoWIHzPPFQS9qM+9omupMaAxQ+BzoR3IRBceUwVUX2PJuyg4
 DfKvoHbyfgDpr1PqnLTixzhtvuO3MgwUBUDyajBSQWTY1/O9BCRoXQfybR7uDHKHiMOjC3AdECJ
 0bmWPRMNVXPn71AuGZzeg13tJ/HKi5OPtU7qlrrc3d++pBxEYg8yiswq/rZuIATwhkoTBw+xKyp
 mmssoIRdV0QvOaJjL7Q+uvZQLQuIm4Bjj/BgQual+WzZowG/KRdRgshv01vK6I0T+BAbD5e3BLN
 0vnUn/D1jsHTh3uZwYxT
X-Google-Smtp-Source: AGHT+IFxMFRZQluesQWSShBt5KDNypMKiuSxDZ/xwThGTjfrdLouYjlzbZicIl4sQiLlILYd+ktubw==
X-Received: by 2002:a05:600c:1f85:b0:436:30e4:459b with SMTP id
 5b1f17b1804b1-4392499962dmr165184815e9.18.1739291158167; 
 Tue, 11 Feb 2025 08:25:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.25.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:25:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/68] target/alpha: Don't corrupt error_code with unknown
 softfloat flags
Date: Tue, 11 Feb 2025 16:24:47 +0000
Message-Id: <20250211162554.4135349-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In do_cvttq() we set env->error_code with what is supposed to be a
set of FPCR exception bit values.  However, if the set of float
exception flags we get back from softfloat for the conversion
includes a flag which is not one of the three we expect here
(invalid_cvti, invalid, inexact) then we will fall through the
if-ladder and set env->error_code to the unconverted softfloat
exception_flag value.  This will then cause us to take a spurious
exception.

This is harmless now, but when we add new floating point exception
flags to softfloat it will cause problems.  Add an else clause to the
if-ladder to make it ignore any float exception flags it doesn't care
about.

Specifically, without this fix, 'make check-tcg' will fail for Alpha
when the commit adding float_flag_input_denormal_used lands.


Fixes: aa3bad5b59e7 ("target/alpha: Use float64_to_int64_modulo for CVTTQ")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/fpu_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 63d9e9ce39c..f810a9b6a47 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -476,6 +476,8 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
             exc = FPCR_INV;
         } else if (exc & float_flag_inexact) {
             exc = FPCR_INE;
+        } else {
+            exc = 0;
         }
     }
     env->error_code = exc;
-- 
2.34.1


