Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BB2C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5vd-0001iQ-Sq; Wed, 16 Jul 2025 13:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc5vY-0001gX-II
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:28:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc5vW-00006X-OU
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:28:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4560d176f97so1125645e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752686896; x=1753291696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zfdOUM49AERFEXBtCOKeieddkFu03hCWo6FYXNJke2A=;
 b=Xz3F+PkYjaFKqPRKBAHhBnWUxPT8VPZrt4Cx7ncKKwkOcdEOePH/RhPDcIzzQy7xM0
 3T0YzBxLNzoKBrR0WbNZTWZln6xZKd73PHRbq92Ca/a5wa2zntYcDLIiX9PP0DAgrD62
 Cq9leII6Gd1HT2w5aoIp2e6Mve+vpQjijtgFwLA76VijTPzFLE8gQtc2E0mIKRT9VwRl
 Z9mO1P+mShS9gBVmVtYY7WGKz4lea5MnpqMKuLr5v3IAHEOIXo1H+49GSLP8+qytqQdi
 koaBxTTVIblx6nCyPS3H6iQGJ6JrQxSAtaZzoLXpxTDHIERb//MqAO5HNOFIFR6HzA2k
 iJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752686896; x=1753291696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zfdOUM49AERFEXBtCOKeieddkFu03hCWo6FYXNJke2A=;
 b=A4mkSExvhkV7fJTSF13usZ8rQDs3No50X9uxkyuA/3ma+2lZGsQQKPp1WDkOnHLxMv
 6hXtB7xi4kc8sEzCe4Xlb4R4IGIH/Jdh2ju/FPwp6Tg3BpNzeweMzb+VSpy3+icZOR9S
 PXw0CA03HoVjeJ/aaQAsh/EEcSZhW6BrrycrJnAYJ5cH85/Ill27m9gRKD5CFaLd9Df8
 AtnMWZ9VcOqyzpTKUwbh+/IcIcydck0ac/eQHYc6L6SBizJ4mHGIHt/dGjyKUDthdanC
 XElG/JTTc3LT9wkGT7widLF3c0UanWYFWa5f3SofvxrCKBl6iR8DaCtvgK22xoimFmCm
 n82w==
X-Gm-Message-State: AOJu0YxeBYI/6tIy0E5Lb045PG6v6f+9gm8d+13xMFt9GqdAJWhPqWE9
 3bAcUlSRG+65V02rv+g4rDYKST7LhJSWzx7IqvJbHXBOMrK6nr2OrK3oFHbm1O42dY4YBUCnZf3
 dD74IlHc=
X-Gm-Gg: ASbGncutBGMOhp8Wjk+YBYVBRWZ5vYa3UYasTKZha2GOVUez+/pYbULizL007+UB+bt
 IpJdzA34sfVujjZDQQxMA7GpH1zGsFj0V7gfKf50tRnisA4itv/ddKXjrqL+rXKwgm6f3R5PJsR
 ar9oe6ZOo4qxzbqR6VKhPxSZZ9p6K6xIjKIL/7grOxrZaRPO0vjhEH2QlBj7ITTG/EsvXUO1DBa
 kqPFp2sJMf65561syx0xtYydSgH4ah4Mei2VuxxrIRm1mtRtmNjTTNGR9eNj7HbfN2x5dgzbdDS
 jLt9djs3TclqpMO01YC2RG87kzAC2DCLC9+cpngluP3k6kpPQznEmqBrV7clvHLwQg+ffsUsLMC
 CA1EOFVoE/G9gFF4ye+Dw8MRJaL0TyMsbwnpzpnsKVLVMRQrKrZcd+b1guFvH2e3IOLGFlNhU
X-Google-Smtp-Source: AGHT+IEnQpaKgxrMbeoDi1PApgvzv0TxJCGw3XJhrpzOHlnbGg4/nxjdKi7XEZtpHAUDfKCughKksA==
X-Received: by 2002:a05:6000:4383:b0:3a5:27ba:479c with SMTP id
 ffacd0b85a97d-3b60e50ff53mr2777751f8f.43.1752686895804; 
 Wed, 16 Jul 2025 10:28:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14d12sm18627471f8f.70.2025.07.16.10.28.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 16 Jul 2025 10:28:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/3] accel/hvf: Do not abort in
 hvf_arm_get_*_ipa_bit_size()
Date: Wed, 16 Jul 2025 19:28:10 +0200
Message-ID: <20250716172813.73405-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Have get_physical_address_range() return when HVF is not
usable, allowing to try another accelerator if requested
with '-accel hvf:tcg', reported here:
https://gitlab.com/qemu-project/qemu/-/issues/2981

Philippe Mathieu-Daudé (3):
  accel/hvf: Display executable bit as 'X'
  accel/hvf: Do not abort in hvf_arm_get_*_ipa_bit_size()
  hw/arm/virt: Warn when HVF doesn't report IPA bit length

 target/arm/hvf_arm.h | 11 +++++++++++
 accel/hvf/hvf-all.c  |  2 +-
 hw/arm/virt.c        |  8 ++++++--
 target/arm/hvf/hvf.c |  8 ++------
 4 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.49.0


