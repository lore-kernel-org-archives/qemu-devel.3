Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31033CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6P24-0002TB-QR; Wed, 08 Oct 2025 03:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P22-0002SS-7e
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:18 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P20-0004oY-Hq
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:17 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-421851bca51so4615305f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759910174; x=1760514974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ceB6CEwigXu9v8u7/ZKBoHe9+YaWRag0U3dHdP3Njc=;
 b=Ohk5/jmXlPLy+5Ui2SFc2RCV16qvbF6sEvXoCtzX8tofxu6O51V0x4uIia2JQ6jSKc
 88vZC2j+HaHlN9YD46pHMHD6z8iUWrD0ZysTq9Ipi8myQV3V96+NyZxdBSHsjGWtQfb5
 R7dOmYJUMf6CvbhbS7lsrcBsTdCNl1llRsLc2nhlWAxT5vf8jdEFogKgFQytIKnNz51a
 Yfpd4Om1Gj+qd8lZQRLwag5YpADEoyghK/fvGku9iGCPPVvDTEBJuFf+LBu2kW/jm7lt
 TFYebKdJqHxWwljunI3XdMOoyytC57q8CDr1zYbRzw+7vlpKIwp6JnGKwKISgRCu8I+/
 MKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759910174; x=1760514974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ceB6CEwigXu9v8u7/ZKBoHe9+YaWRag0U3dHdP3Njc=;
 b=IRY+eGklB9K9fvRuRyAnXYKgKcqTroYCsHjMg+ebi8hjhc+FrsZfVrLMpzlW2r3AZw
 YdnaZ/t+m21GL69KDEU31pqGx6Fs95GbTu0Tv/aWcFf+F0TRbOIcj4ePVAEzLtyYtiQM
 xY/u62kVmDXusmJstCtUjkstji9SypT1YmvN5wO9vcUk10s5T51atGkvAPTwMQlT3yHN
 s4A8mVcGbVVQ1sgFZ5RlaDjY8Mwmyh/Id24RTYSch+8pWcfF7cUj3TVs+n9R/5IgrZYz
 Xmjwo6DOr8x8oew1R3zHJFoOo6Y5FD9JhN3rP6CatFQYs8u13trYuLVMyq4eUvbuMKlO
 mKEg==
X-Gm-Message-State: AOJu0Yy0wxpMWtoHktqmFX0O97jCo1bUuFrSZ710oQAzCEi/uPfgU1ze
 Cf2R4KkIa6Qv6wGjxIRri8gyy24MjnJgbSWIKbzKJLBOEm4akHdYtsgXRykvmvO5dApkH0jgGyR
 ic60YhieRjQ==
X-Gm-Gg: ASbGncuHXtq+IfzHJbuY0FyqRol0xv0zVsGIJzvz8fpDoeNLzpCS2//0AsT6Prp7TmZ
 53PtleyZsj0qulHLj2TPjxLhIPWWuJa+SD45A/jUIsPbymiuibL2bwjWrtKSJ+EuvEXV0qnO164
 BA4PTiPjhHKY9+3rsL+gEiGzNqjQ9Ldag0C2yMvNiGBDzEWX1+xwvBf1XevxHxpxEUNAZQHsWA+
 WMEjHW0ZJ4E4nSSLI3fSDvWcZfY3meUnkI6Vb6hC6z4EOlrNn6SOolEEwaInMoINLUU23Phh0I5
 WdFYOn61lMauJ5EubCQ902eKJpeUNM2g3iDv/iWESyTpyareneXLcmAiLBcCQw78SdaJS1/BLok
 +qbIcEoDTwwDEZbAywkS5JG0tjLDEVtsJ2K81TziOdZmdN0mEzFwaeal7159dBhwn62rcE5+FC9
 uJijwEM9otvl4gKQS10aBmaEAH
X-Google-Smtp-Source: AGHT+IEAIK7kK/yhq4kEkLfpw8Jdcy9QVXis1nGat4XYWGCHDFHUQ7Q2NXax0QPeVrOTv5eieaPXkQ==
X-Received: by 2002:a05:6000:4305:b0:3e7:63dc:1ff6 with SMTP id
 ffacd0b85a97d-42666ab88cemr1053953f8f.8.1759910173924; 
 Wed, 08 Oct 2025 00:56:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c21302sm26368545e9.14.2025.10.08.00.56.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 00:56:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] target/openrisc: Remove all uses of target_[u]long types
Date: Wed,  8 Oct 2025 09:56:04 +0200
Message-ID: <20251008075612.94193-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Remove all the target_[u]long uses in OpenRISC frontend.

Philippe Mathieu-Daudé (7):
  target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()
  target/openrisc: Do not use target_ulong for @mr in MTSPR helper
  target/openrisc: Remove unused cpu_openrisc_map_address_*() handlers
  target/openrisc: Remove target_ulong use in raise_mmu_exception()
  target/openrisc: Use vaddr type for $pc jumps
  target/openrisc: Inline tcg_gen_trunc_i64_tl()
  target/openrisc: Replace target_ulong -> uint32_t

 target/openrisc/cpu.h        |  31 +--
 target/openrisc/helper.h     |   8 +-
 target/openrisc/fpu_helper.c |   8 +-
 target/openrisc/machine.c    |  20 +-
 target/openrisc/mmu.c        |   7 +-
 target/openrisc/sys_helper.c |   7 +-
 target/openrisc/translate.c  | 396 +++++++++++++++++------------------
 7 files changed, 233 insertions(+), 244 deletions(-)

-- 
2.51.0


