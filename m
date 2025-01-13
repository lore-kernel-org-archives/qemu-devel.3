Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C5EC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKtk-0005Zp-FL; Mon, 13 Jan 2025 08:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtV-0005Xe-9U
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:17 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtR-0007e9-TR
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:16 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so30905575e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776451; x=1737381251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tia5rX8C/kGupcBR+jKyRXuT0g6H4QmWSiamN2kqLi0=;
 b=lI7w9Q3+2e7u0iuV5utcD3uUW7wIXOpWJC//Afcgga7FkFMX5TJ2ZuVN4CxUDpGGUN
 x52nICG+8XFYRAnXEslrqbf9MIqTsubkC28Xb+5G2nz/arUA4Ln0iLbyBchHAtdEFeCX
 FI4q8bEtOyhY0QJqGmFhz7LDJRwuAVw2t5F9qPjZM2yY+gOuAlCKimiDry0X9lJPuR0t
 QZF5rE+SYC8xHvhfqzLvtPwl3qWmUV8X3PcDN4ePSFwN4Uov9Cf7/KDWHxCE1kQ2SCGw
 1NigMpp7JkCVrWYprQRJx+rqBlofSJOROfoEKtjDSeeoD6X+2zg2G7U8pV33Swl8VXj6
 kbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776451; x=1737381251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tia5rX8C/kGupcBR+jKyRXuT0g6H4QmWSiamN2kqLi0=;
 b=Gm+BUTqwgj0KWU+IL/E+BWdEpK85dmPuW3uWR67luhBrB3SqJzNurinOIi+LY+T0Z9
 eB7lJ7FiaGKEcFsVX7Z8dETi713UKhIUCSCPMC+uU0Fplb3F/lwbTxtr5y/1GDh1yi6U
 pjXpxu4Sqs3BwTyYYpmebif/g38nwXI+yDn845o3DKA1NAaioiqPnkz8NCjmQ4wmO5o6
 9wAegPFNy5gFGxIdJRJBwADeCebsmIMQqHuDZuuWBW6Gy1ftzIZ4u1eMXFKxOhodsxyw
 hrDprDHnjMf0Db2KhSiYUb7Q22nfM/Te++LEP1Pxu58Rdwne+JOfR28oaiy9nRcZZr9V
 Zsgg==
X-Gm-Message-State: AOJu0YypJIfhg/0ugYnWQSlu++o2Hde/4zTJ4XFTS9cRkF+sx90MaRam
 8oLQZeycozJGdZQVyfqzO55M3HCTn8gtBjwVAtAeMXICe9jmmNEJR960sxAH8yTvU55PWHJpqvH
 Y
X-Gm-Gg: ASbGnct4juYcsQ/DI8iARUMtARnbZEcI8Qzzb2n5a2yCyeoihyqXkHwPuJ4QCzC3PP5
 ZJmUKlvwRCiNjK5NXhAuowuJAtKrO3Zl2WSx7pnXbp5z1KM4JZ0NSpAL5VNUAXcd74SQrWI8KvP
 CckrAYhUiXMxkUO5TGOSFacrWjpsARolG7Jary8TT9ftuJ8iiaZeH08tvu3rooVPeo3AMJjNNzC
 2chMWnMTQmTfUmxpPAeuOSllgobVgcLqiud0ha/VeZIDrYJetAQPE6xVr4RzUE=
X-Google-Smtp-Source: AGHT+IEfpX5Qikn94X8xYjCoXF4qqTfOGtQeqb9iAy5Z2oSNEHgGCdnZY8BjfGDjC5yreGhr/0hIeQ==
X-Received: by 2002:a05:600c:214e:b0:436:e8b4:3cde with SMTP id
 5b1f17b1804b1-436e8b43d30mr173796465e9.14.1736776450757; 
 Mon, 13 Jan 2025 05:54:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] target-arm queue
Date: Mon, 13 Jan 2025 13:53:57 +0000
Message-Id: <20250113135408.3164401-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The following changes since commit 3214bec13d8d4c40f707d21d8350d04e4123ae97:

  Merge tag 'migration-20250110-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-01-10 13:39:19 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250113

for you to fetch changes up to 435d260e7ec5ff9c79e3e62f1d66ec82d2d691ae:

  docs/system/arm/virt: mention specific migration information (2025-01-13 12:35:35 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm_sysctl: fix extracting 31th bit of val
 * hw/misc: cast rpm to uint64_t
 * tests/qtest/boot-serial-test: Improve ASM
 * target/arm: Move minor arithmetic helpers out of helper.c
 * target/arm: change default pauth algorithm to impdef

----------------------------------------------------------------
Anastasia Belova (1):
      hw/arm_sysctl: fix extracting 31th bit of val

Peter Maydell (2):
      target/arm: Move minor arithmetic helpers out of helper.c
      tests/tcg/aarch64: force qarma5 for pauth-3 test

Philippe Mathieu-Daudé (4):
      tests/qtest/boot-serial-test: Improve ASM comments of PL011 tests
      tests/qtest/boot-serial-test: Reduce for() loop in PL011 tests
      tests/qtest/boot-serial-test: Reorder pair of instructions in PL011 test
      tests/qtest/boot-serial-test: Initialize PL011 Control register

Pierrick Bouvier (3):
      target/arm: add new property to select pauth-qarma5
      target/arm: change default pauth algorithm to impdef
      docs/system/arm/virt: mention specific migration information

Tigran Sogomonian (1):
      hw/misc: cast rpm to uint64_t

 docs/system/arm/cpu-features.rst                |   7 +-
 docs/system/arm/virt.rst                        |   4 +
 docs/system/introduction.rst                    |   2 +-
 target/arm/cpu.h                                |   4 +
 hw/core/machine.c                               |   4 +-
 hw/misc/arm_sysctl.c                            |   2 +-
 hw/misc/npcm7xx_mft.c                           |   5 +-
 target/arm/arm-qmp-cmds.c                       |   2 +-
 target/arm/cpu.c                                |   2 +
 target/arm/cpu64.c                              |  38 ++-
 target/arm/helper.c                             | 285 -----------------------
 target/arm/tcg/arith_helper.c                   | 296 ++++++++++++++++++++++++
 tests/qtest/arm-cpu-features.c                  |  15 +-
 tests/qtest/boot-serial-test.c                  |  23 +-
 target/arm/{op_addsub.h => tcg/op_addsub.c.inc} |   0
 target/arm/tcg/meson.build                      |   1 +
 tests/tcg/aarch64/Makefile.softmmu-target       |   3 +
 17 files changed, 377 insertions(+), 316 deletions(-)
 create mode 100644 target/arm/tcg/arith_helper.c
 rename target/arm/{op_addsub.h => tcg/op_addsub.c.inc} (100%)

