Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28647C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUI-00077z-2A; Fri, 08 Mar 2024 10:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUG-00074o-IU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:20 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUE-0004GL-Fu
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:20 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412e784060cso19993675e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913016; x=1710517816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vVfHWVPkxi2wh7WqjAz+1EOfuVUJp8wfd6+RDwEh8pM=;
 b=YRhNH8jXGH2Y4lj+m4uHGouA4BXoG5bfYtc4hkjksm127e4gVES0Kvo06Ut1dCb/OG
 navVjLLI7i4De9Uxo7qPhZv8wK8B8JV7+wuJtoxu7Rzh2rQoW5W0g4q30RhYSWQ/aB2F
 QVCDvn0mTg8ZydeEdjNWUagsvrULqjRLBZn1lvniWTKUKpLCDjMUHYZBJvPAj/x9BrFD
 zbrLzdwvCkmEUXDHnsKOAeuYnJy44/emPV5lym/G7QP6iXbzCN4/KYtzqrwu94IP0IZ+
 tppMuOq3e80X9gKi/Avh3b9crpYCv2GjEYUUNL77ql55KpVZLf/O55XFUXptdBV/q0y+
 Wbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913016; x=1710517816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vVfHWVPkxi2wh7WqjAz+1EOfuVUJp8wfd6+RDwEh8pM=;
 b=kB9hMiaTDRMtkLBivopet0AB/YN88gmNcXjUSxMAdd01vng0waKmmm5oMZ0XS4UAQt
 xBKvaUgZsl1y0+xeznMx1cQVmUtcjNMmbin23z0FTguqLqEKAGb4kwlS+fq0sgfn+HOk
 rzpAxQ255/pxVsBBWtgkd4Mvn8q9nKpKom0iBumH1WJBQYZIubpYZjXoKwolvBkC3b64
 l1b7dk4s5qpV+tizJFrZXomlwcU5D5jJWVCFLjXUSAic65wUpaEG70NqAJF89pJrnTr5
 NLVzewvWMjHwWbLYHx/eY5X1Zuybs03rALEblKfcUvj1b8ca/mFt0dp/0C9TzokQhztx
 fVJA==
X-Gm-Message-State: AOJu0YxqSECL6Ic1nvzXejfJ/uQoT/grF7t6PsO+psXEihcWozbBPYJp
 WKBhqDe4Ll+KL6ktP82kd3LTNvvdxiL8cmTGNwlPjS1LebjEB7ns1m+7vGjZbNGoANo1PsBf0Sf
 b
X-Google-Smtp-Source: AGHT+IFutqlX4Jc39L6F+FZeaW0ocbKRwNs9mOjszg9f8IQol03zJZysR1qw4XEQVkfB04VifOFIUA==
X-Received: by 2002:a05:6000:82:b0:33e:1e0e:17c9 with SMTP id
 m2-20020a056000008200b0033e1e0e17c9mr672201wrx.14.1709913016339; 
 Fri, 08 Mar 2024 07:50:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] target-arm queue
Date: Fri,  8 Mar 2024 15:50:01 +0000
Message-Id: <20240308155015.3637663-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:

  Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240308

for you to fetch changes up to bbf6c6dbead82292a20951eb1204442a6b838de9:

  target/arm: Move v7m-related code from cpu32.c into a separate file (2024-03-08 14:45:03 +0000)

----------------------------------------------------------------
target-arm queue:
 * Implement FEAT_ECV
 * STM32L4x5: Implement GPIO device
 * Fix 32-bit SMOPA
 * Refactor v7m related code from cpu32.c into its own file
 * hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later

----------------------------------------------------------------
Inès Varhol (3):
      hw/gpio: Implement STM32L4x5 GPIO
      hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
      tests/qtest: Add STM32L4x5 GPIO QTest testcase

Peter Maydell (9):
      target/arm: Move some register related defines to internals.h
      target/arm: Timer _EL02 registers UNDEF for E2H == 0
      target/arm: use FIELD macro for CNTHCTL bit definitions
      target/arm: Don't allow RES0 CNTHCTL_EL2 bits to be written
      target/arm: Implement new FEAT_ECV trap bits
      target/arm: Define CNTPCTSS_EL0 and CNTVCTSS_EL0
      target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling
      target/arm: Enable FEAT_ECV for 'max' CPU
      hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later

Richard Henderson (1):
      target/arm: Fix 32-bit SMOPA

Thomas Huth (1):
      target/arm: Move v7m-related code from cpu32.c into a separate file

 MAINTAINERS                        |   1 +
 docs/system/arm/b-l475e-iot01a.rst |   2 +-
 docs/system/arm/emulation.rst      |   1 +
 include/hw/arm/stm32l4x5_soc.h     |   2 +
 include/hw/gpio/stm32l4x5_gpio.h   |  71 +++++
 include/hw/misc/stm32l4x5_syscfg.h |   3 +-
 include/hw/rtc/sun4v-rtc.h         |   2 +-
 target/arm/cpu-features.h          |  10 +
 target/arm/cpu.h                   | 129 +--------
 target/arm/internals.h             | 151 ++++++++++
 hw/arm/stm32l4x5_soc.c             |  71 ++++-
 hw/gpio/stm32l4x5_gpio.c           | 477 ++++++++++++++++++++++++++++++++
 hw/misc/stm32l4x5_syscfg.c         |   1 +
 hw/rtc/sun4v-rtc.c                 |   2 +-
 target/arm/helper.c                | 189 ++++++++++++-
 target/arm/tcg/cpu-v7m.c           | 290 +++++++++++++++++++
 target/arm/tcg/cpu32.c             | 261 ------------------
 target/arm/tcg/cpu64.c             |   1 +
 target/arm/tcg/sme_helper.c        |  77 +++---
 tests/qtest/stm32l4x5_gpio-test.c  | 551 +++++++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/sme-smopa-1.c    |  47 ++++
 tests/tcg/aarch64/sme-smopa-2.c    |  54 ++++
 hw/arm/Kconfig                     |   3 +-
 hw/gpio/Kconfig                    |   3 +
 hw/gpio/meson.build                |   1 +
 hw/gpio/trace-events               |   6 +
 target/arm/meson.build             |   3 +
 target/arm/tcg/meson.build         |   3 +
 target/arm/trace-events            |   1 +
 tests/qtest/meson.build            |   3 +-
 tests/tcg/aarch64/Makefile.target  |   2 +-
 31 files changed, 1962 insertions(+), 456 deletions(-)
 create mode 100644 include/hw/gpio/stm32l4x5_gpio.h
 create mode 100644 hw/gpio/stm32l4x5_gpio.c
 create mode 100644 target/arm/tcg/cpu-v7m.c
 create mode 100644 tests/qtest/stm32l4x5_gpio-test.c
 create mode 100644 tests/tcg/aarch64/sme-smopa-1.c
 create mode 100644 tests/tcg/aarch64/sme-smopa-2.c

