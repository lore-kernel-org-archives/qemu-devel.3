Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4962CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkPi-0008Ks-NR; Wed, 03 Sep 2025 06:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPW-0008BB-PM
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPP-0008A4-7s
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b79ec2fbeso42993305e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894081; x=1757498881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DEdnXetstwiME2PMs47ROkMyVNCZIiKy5VUOukcBJ8=;
 b=KqVo+Maz2mXpYYxxDjA6+Io23lh63BA4oOFFmrk2q/LElsL5f6fRZUwwH+pAQwGtbo
 OaNXkK+ba6qozCB8B8utOxj19sNmVoSpT6iZY8coflr7mjLw33FuD7HRWnzsupErXY48
 bohEJlbwCpDG/2j6c5nZmN5grh7nuCBZByJMjNH5MVK0iqNFIpidd70p2qH25xVrFAIa
 V7DoEc0YFPGB43oDg2L5CXWYTcNoIYFhwPrI/Wjcdg9zVT8s4yEzt7OiGdQv+4sRCfdu
 GMGg+Bwnsd+ohGwBTS0bFZSNOpEmK1RM7dvEbosuLFZG3i8Ni0D7OkBhtGQp/kc3Jv9T
 HyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894081; x=1757498881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DEdnXetstwiME2PMs47ROkMyVNCZIiKy5VUOukcBJ8=;
 b=hefqWtIm9fTSODAdVzH0lS8a4mJH3mEGuvqg8fihLJfr/jUG3zFSFFYmtEg2sqhLAC
 Cx/FSWKj4zkVKKTlWX0iYkmLd1pSMwNC6RzqoD1cwnZLUwzck9uqzGLTRlxunrpH8+b/
 92riIm5haROsCrKdNCwvtcbfA8RAYbV0Tf5JS7XKnxusPuvBkz4heZvkZnxrjMZ5g4wa
 1vSSM7fKF9jNOGaHMDfLgPJMEwp/rh7hFbo4jBYx7pwDls2XwN8LHkRQ4lm926U+XCnS
 ZXveMxwaCD1ueokybNrRsoJr5xqLRvT/rNK5mdEYwtz3qtWv4kBENj6LWhUxuiDqzD3a
 8FMQ==
X-Gm-Message-State: AOJu0YwMQR9gfotHda7XWVTAW4w/4kIsp0H1CDf9KmFokhLDB/X9W6TS
 C5upcaZHu2ftz4jKNteoPPaMq2CUygx/tuPxB/1Xihx8GmQXSQVC7AXk1FVdKfYcxnqnnZ7EMX6
 JzBh5GqM=
X-Gm-Gg: ASbGnctRGmtM/Aqt683koVpTTsjRiFPN0WTti4cgEkq8nOn9l1wf+3nvYVMFtSdkOLe
 qDo/Wnft+WNXATy0T9Nafrqg7Ktt4WWHtg5TK5DoPDoOdKSxldhtwJFprVhtRbpVriAa70L1SB4
 lotfCn2qlN/+pS5O1mMkPpAvz2sZOrz/Gj34IjpANuUcO30/dCMI3dJ5C161cohDAhP5V+RxZPb
 fGK3bB2Y4p5WUqXFFLtbsZl3moeBFEbMwDfIjL9K4mwUbE7JKG7XUO9ex2pjp6PYc7GSByS01I9
 PRK23O9qPMBMi9Lcnl1EEEUuszICx5dxGvnlLenKNIU4Q39FVZqiDk04q1OK1l1nF4yz6TsqS0Y
 KrC0RqM+6DyrKMzDbR/vI6NrF1QMjdOw3jZUr6TIh4e6F4JUwvFGl5NnGfurEYq/pTkKb9sePzn
 szj/rqJQ==
X-Google-Smtp-Source: AGHT+IH0sZUfnQmTQp0oWjjR1Ndf6XSsEI1Wriw4ISiO4FOqTOUjqjT43dbZ41Li00nA4nDt3osdRA==
X-Received: by 2002:a05:600c:a46:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45b8558a78cmr139432685e9.17.1756894081370; 
 Wed, 03 Sep 2025 03:08:01 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab093sm245312015e9.22.2025.09.03.03.07.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:08:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 03/24] target/arm/hvf: Check hv_vcpu_set_vtimer_mask()
 returned value
Date: Wed,  3 Sep 2025 12:06:39 +0200
Message-ID: <20250903100702.16726-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

hv_vcpu_set_vtimer_mask() returns a hv_return_t enum type
(defined in <Hypervisor/hv_error.h>). Assert we succeeded,
as we are not ready to handle any error path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 65ac0bd71aa..1b59cc0eb04 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1906,7 +1906,8 @@ static void hvf_sync_vtimer(CPUState *cpu)
 
     if (!irq_state) {
         /* Timer no longer asserting, we can unmask it */
-        hv_vcpu_set_vtimer_mask(cpu->accel->fd, false);
+        r = hv_vcpu_set_vtimer_mask(cpu->accel->fd, false);
+        assert_hvf_ok(r);
         cpu->accel->vtimer_masked = false;
     }
 }
-- 
2.51.0


