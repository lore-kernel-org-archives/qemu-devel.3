Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCC9C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzL8-0002zR-SS; Tue, 25 Feb 2025 13:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJT-0008Vq-87
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:50 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJI-0002GK-7A
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-439a2780b44so37957655e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506734; x=1741111534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n9X7WqybANNyt1qb+lqodX4BPVnY7VWQUsDRyTEDBdo=;
 b=sUPVJTn8AZr2Ayq2UUVGlZJZL1WVipLxi/1Ymsa6qF21tR9nADtKZEHIDMeC85eTJL
 ENa4WV2Uafwazc4Pgbb7NwkU6FN1Kyt0CqFbVN6FEt/TJg6c/yaDJqO8hLea4iIcliQY
 ceqYKnGgSo79F9ddgT8xW6VJJSUnLaFRRdekla95Yy1oeBSDUpnae8To9wZsSd3YXEel
 CcJWy79P9vgovKWI0Lx+o35BqOP8ClGrKGlanYZtN7aBy4OhzmxWk3PS4t/c2w5oQAfe
 0GFbnWl+N56VN8FjpTC4VceESj6zZRcQVpyJYMLEBbla32khMtWUYK3hJCu/laL2S1je
 1e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506734; x=1741111534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9X7WqybANNyt1qb+lqodX4BPVnY7VWQUsDRyTEDBdo=;
 b=eXwsWPve1cCbgGeYkmFxY3aO1d1fT6wI8i9OCGoJdhYUZ0hAShjCucyF5yIbKrooYb
 9jnyGV6h6GZSFbHr1BTbKva2y4h0nM4cMqjtsc2jvN3bXA0NoSgpT5qh4l2Urj1AQcYq
 OStjR3dORwxGnmT0KSrZmK5PTll7NWADNt30hIj34b84HNVzlFm2h2WQlIYMUXZYiuht
 eEOvUiL8pBEZmcKmQijv+8fsmLr4wX3atCVeemaMVP0LmUPvOz2PSSt5NYMFzGnLWUwK
 VWy+0CWnenpVekqv82sIDcZPuNoQgv7VQu7pu2PJ3m7D/06zdidyfrlStCT+G8er7v+r
 6ppA==
X-Gm-Message-State: AOJu0Ywre/uExpYcq/kUeJ2UfzUJMPq1qV+6QUBZ3qcJH5Hke1s5y1kL
 ZsF8NJQX08lgoIL414bUpnTK+cVfkvvbj1OOPmvMzjSpYlxiMmekarLz8qbyVn12ajRi9BB5uva
 r
X-Gm-Gg: ASbGnct1yRW/Pb9Ps4RBRsZG97Z+6OMakg5gLo2CK/1F1+sC+nq4y1mvZugwcJW4KCD
 8Z8IK0pY9lomTQN7W1cNOYO89jxLL1YrD94FbhjpfqNTBq8poquc/uixmbqSrsuQ4izRZgweZkX
 iFiKr4OXjg/Quk05SfejZQoFi8HkVeJZyRlXAb/0E9ABX8hoN8MrkvMcHdIc1KbGkR70L15DXmr
 vgm6YjYPryaZPRzFjmyx9K+xjeCjSA8f3v3NxxEff0u5eqJFmohUISkaT6lx4e7aPkGkE/qxZKY
 B4BJTQvN1lR3wlAs1QMo968Cmr2pN8sa
X-Google-Smtp-Source: AGHT+IFiajoFTn45KP0ephC4iZJAdsY9knpjqTD6+5u08UdWM+LiULOT2LyVlxvmEligs7461XmKtg==
X-Received: by 2002:a05:600c:5125:b0:439:9828:c422 with SMTP id
 5b1f17b1804b1-43ab8fea14fmr4793565e9.18.1740506734429; 
 Tue, 25 Feb 2025 10:05:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/43] fpu: Don't compile-time disable hardfloat for PPC targets
Date: Tue, 25 Feb 2025 18:04:45 +0000
Message-ID: <20250225180510.1318207-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

We happen to know that for the PPC target the FP status flags (and in
particular float_flag_inexact) will always be cleared before a
floating point operation, and so can_use_fpu() will always return
false.  So we speed things up a little by forcing QEMU_NO_HARDFLOAT
to true on that target.

We would like to build softfloat once for all targets; that means
removing target-specific ifdefs.  Remove the check for TARGET_PPC;
this won't change behaviour because can_use_fpu() will see that
float_flag_inexact is clear and take the softfloat path anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250224111524.1101196-12-peter.maydell@linaro.org
Message-id: 20250217125055.160887-10-peter.maydell@linaro.org
---
 fpu/softfloat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b299cfaf860..b38eea8d879 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -220,11 +220,9 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
  * the use of hardfloat, since hardfloat relies on the inexact flag being
  * already set.
  */
-#if defined(TARGET_PPC) || defined(__FAST_MATH__)
 # if defined(__FAST_MATH__)
 #  warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
     IEEE implementation
-# endif
 # define QEMU_NO_HARDFLOAT 1
 # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
 #else
-- 
2.43.0


