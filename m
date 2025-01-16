Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91726C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYO0R-0004tL-5b; Thu, 16 Jan 2025 06:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYO0M-0004sp-Hy
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:25:42 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYO0J-00047k-Pe
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:25:41 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso435918f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 03:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737026738; x=1737631538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VTwr/e1I4szihyzpahBXfCMlxZad4KaHUZ69+r4QFwA=;
 b=IDrxuzv6KEJZvA1QwwwYJ7hDd1h7zjU7z3LO2mML3ta9orPqUBeD5guK+8E5zWIGyH
 DRwOKc6wQYstASjUakmPYLpe35weybdqfiD7N5G9j7DQjplq+ofOBvF2sjFNvKKzqmuk
 vI/HXHGVv4MkaFSnZyLCuRI7xzvlgdDbnDe0dol4QlbyLJlSMGTz6GY4WABDCj3C1x0W
 45OIuazhNKmECU7cWfmqYOV7Jz1WAUX1EJeFqpd8Ea537TFGi51KrpeRd8fq0lv2gB4g
 AoenFQvbWim0GPaUB+DZeENr+D6bk9mL2E25QepwuyXTXTRvw0q5K0qUDo480Ki78MAa
 ud4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737026738; x=1737631538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VTwr/e1I4szihyzpahBXfCMlxZad4KaHUZ69+r4QFwA=;
 b=f1cdT+u85sO6M9J1rtr20kAUBBVI9vIwXpZQOWLABKa8CgxwdwJ0khw5U8YgzVBTnW
 FGKevPPId6Vh32w1H4i+NHusawX9Sv2k87q5zfuEKRlQKscaA3UekWRx7jUyc/V01cJ1
 JrM/9BHJvO+NuzE5D3xZpyMZoyqBGq+WEYkYvW1GSMWqUG6hArIUX/y9Pvkscim7dEyA
 3NIwFnC5AaQdH3zCiIZrVTw8Nv1PjIcKWit597w3ZsR5F2nXpd2mYhPAHlFnp/ukZ6lD
 39E6QvuBcOldudFjrDDAC4MmbbTtGyPMv9cXjdQc2BEcGcC9dspOgIMlzR9MmzzJMN1U
 p35w==
X-Gm-Message-State: AOJu0Yxvi1AdOqDWrGJxSqDdeP59Bi/PQaFFl4EXBy3G2WhqhRERndhA
 rQO4YogG4E+SmITd7ZZ30ceqivQFJNUh3YI5S9R+nE+T6MWXQFpj2h300bKwuf9WjFdoXEw+JE/
 K
X-Gm-Gg: ASbGncsO5/XDV1uGx55Bu2q+ZNQ2Al/RRBR6HSeAtiNTDBVCs2rcVpNS9Z2tVZ3ZwRO
 /f3cMXLfXa6tFcGbVes3Nd+erbSsLzpZ0h4zmKU85MP7G59gy4PjR6+xcZgDrE0hEzWT0BunWc6
 qMrpGK3XHwCpAOSIsewvoTNeFxBqZfVVvsmO3DwBYjF7f5zdPsHy6R7VFqIZhglb+MD+TRoa9Q6
 tejofY11mZwV9/808TOxL2ZXQZPnjHr7UYjBaY5+1G3RES/Kpd7Vy+LxtKFAWI=
X-Google-Smtp-Source: AGHT+IFZFyIZ9reVvc8HYpruJuqZG+svion1XqArveQaDwNcHJemLIPaH31T/yhzqELc8IUYmz+bnw==
X-Received: by 2002:a05:6000:1acc:b0:385:db39:2cf with SMTP id
 ffacd0b85a97d-38a872c943fmr26798292f8f.12.1737026738066; 
 Thu, 16 Jan 2025 03:25:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d154sm20636654f8f.10.2025.01.16.03.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 03:25:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] target/i386: Fix 0 * Inf + QNaN regression
Date: Thu, 16 Jan 2025 11:25:34 +0000
Message-Id: <20250116112536.4117889-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patchset fixes a regression that I introduced in my recent
refactoring of softfloat NaN handling, in commit 8adcff4ae7
("fpu: handle raising Invalid for infzero in pick_nan_muladd").
When I wrote that code I was under the impression that all
architectures would raise Invalid for the "inf * zero + NaN"
case of a fused multiply-add. However, IEEE 754-2008 makes this
impdef for QNaN: an architecture can choose whether to raise
Invalid or not.

For i386, SDM section 14.5.2 documents that for the 0 * Inf + NaN
case that it will only raise the Invalid exception when the input is
a signalling NaN, and so the behaviour change in 8adcff4ae7 that
caused it to raise Invalid also for the QNaN case is wrong.

The first commit here adds a knob to the softfloat code to
allow an architecture to disable the "raise Invalid" that is
the default, and makes x86 set that. The second commit is a
test case for x86 check-tcg that exercises this corner case.

We do not revert here the behaviour change for hppa, sh4 or tricore:
 * The sh4 manual is clear that it should signal Invalid
 * The tricore manual is a bit vague but doesn't say it shouldn't
 * The hppa manual doesn't talk about fused multiply-add corner
   cases at all

The test case also includes a disabled test for a different
x86 fma corner case; this is one that's not a regression. I've
left it in the test case code because it's the justification
for why the test harness has the support for testing fma insns
with FTZ set. I'm working on a fix for that but I don't think
it should be tangled up with fixing this regression.

thanks
-- PMM

Peter Maydell (2):
  target/i386: Do not raise Invalid for 0 * Inf + QNaN
  tests/tcg/x86_64/fma: Test some x86 fused-multiply-add cases

 include/fpu/softfloat-types.h    |  16 ++++-
 target/i386/tcg/fpu_helper.c     |   5 +-
 tests/tcg/x86_64/fma.c           | 109 +++++++++++++++++++++++++++++++
 fpu/softfloat-parts.c.inc        |   5 +-
 tests/tcg/x86_64/Makefile.target |   1 +
 5 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/x86_64/fma.c

-- 
2.34.1


