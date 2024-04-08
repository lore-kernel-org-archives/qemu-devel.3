Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED497C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 21:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtwce-00052q-QP; Mon, 08 Apr 2024 17:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtwcd-00052a-NG
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 17:33:47 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtwca-0007Q6-5V
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 17:33:47 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-516c97ddcd1so5561452e87.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712612022; x=1713216822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8a7JsFSg5n4fyKI9/vFc7JRhzCVDrS8NSR69Pi2X1a8=;
 b=N5xzHIlQVuWfxuYmrAEIADv5lOnqU3hnsyb+5kkGfTeNcO3kscPBwi3gk30/xyBxcY
 s/DcjPx3N1sJqfv1uleQNrOS5JS+htLLmZaCzL0IfoGic06SMYKYJ8oUpAQGVvkyJ3GB
 Ub3ZpwYEzL/qpmmSwziYZJ4/wDJhywxadPdWbjUXbSv41Oo+45qQsxtI7uvhU71jl0uE
 stItA987n5lbRjEb7GqNDfVDMIStBMRIjJcsqV0IBrWn5R4IIC3lYkwQcOcDX1OEX3Iw
 E4ph/OX64eC7q0SVsZYHlurlJKySUGbv64sfiG89VE3iZ0MGLSo7oV+NtIPJOmSJdTWo
 nPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712612022; x=1713216822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8a7JsFSg5n4fyKI9/vFc7JRhzCVDrS8NSR69Pi2X1a8=;
 b=qbV1Gmb+v4TEw+fEcf90pSh0QZyXmDtpVW4Fific+bd6/ZCxcEUaS2XGmKiTLtOdC9
 jldkm20ye1nUmrdsuoVFLDSafK+zFUowN8yeCNIFK5cnUA/xU42216x6hglH1rIY3Bwl
 yQcLh5bdjCr5tpxs9zGMXMCZ1UXM/owZrj3+blcB5B7mVqUSb61wstJpyHnR/A+RUfXW
 2ujDKGfyhJ558DGTs74nadRNNLblTDiHgDg6FAEohSyo4Hqn0Q8pRF0oTuLGj0CUPW/Q
 CNRyPQbDmJqSFir8zKdhXoIjg9vxEvDH9E6jJRdR+MOu7CJ7Y6UHiIZVC4Ay8PgKD8n6
 1i3Q==
X-Gm-Message-State: AOJu0YwkXD4TTkkZIWynL3yui/6oBTIh+tbMgZgkATXNJ690nb3L4x+4
 E8MaLf7QyeRk7acNrgjGiabYp/x41YZ4g4DXNMICIGFW8fAhw53+OIfOZVpPCWqucY9SW1fkhot
 Q
X-Google-Smtp-Source: AGHT+IF3Yi1Ii93nom+QO9NSGOcfc3nPWe54/hXieaigrdw8R7wpRufdSdqlTC8F3vYPqr484VkjWQ==
X-Received: by 2002:ac2:52a7:0:b0:516:d126:71a4 with SMTP id
 r7-20020ac252a7000000b00516d12671a4mr5771981lfm.5.1712612021773; 
 Mon, 08 Apr 2024 14:33:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 r20-20020a170906549400b00a51f2b5b1fcsm114746ejo.75.2024.04.08.14.33.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 14:33:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 0/4] hw/i2c: Convert to spec v7 (inclusive)
 terminology
Date: Mon,  8 Apr 2024 23:33:34 +0200
Message-ID: <20240408213339.83149-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

Mechanical (mostly) conversion inspired by Wolfram [*] to
use inclusive terminology, similarly to the other renames
we did 3 years ago, shortly before the I2C spec v7 was
published.

Posted as RFC to get feedback, if no objection I plan to
finish the conversion (SMBus and rest if hw/i2c/).

[*] https://lore.kernel.org/all/20240322132619.6389-1-wsa+renesas@sang-engineering.com/

Philippe Mathieu-Daudé (4):
  hw/i2c: Fix checkpatch block comment warnings
  hw/i2c: Fix checkpatch line over 80 chars warnings
  hw/i2c: Convert to spec v7 terminology (automatically)
  hw/i2c: Convert to spec v7 terminology (manually)

 include/hw/display/i2c-ddc.h     |   2 +-
 include/hw/gpio/pca9552.h        |   2 +-
 include/hw/gpio/pca9554.h        |   2 +-
 include/hw/i2c/aspeed_i2c.h      |   4 +-
 include/hw/i2c/i2c.h             | 123 ++++++-------
 include/hw/i2c/i2c_mux_pca954x.h |   2 +-
 include/hw/i2c/smbus_slave.h     |   4 +-
 include/hw/nvram/eeprom_at24c.h  |   8 +-
 include/hw/sensor/tmp105.h       |   2 +-
 hw/arm/aspeed.c                  | 290 +++++++++++++++++--------------
 hw/arm/bananapi_m2u.c            |   2 +-
 hw/arm/cubieboard.c              |   2 +-
 hw/arm/musicpal.c                |   6 +-
 hw/arm/npcm7xx_boards.c          |  44 ++---
 hw/arm/nseries.c                 |   6 +-
 hw/arm/pxa2xx.c                  |  36 ++--
 hw/arm/realview.c                |   2 +-
 hw/arm/spitz.c                   |  12 +-
 hw/arm/stellaris.c               |   2 +-
 hw/arm/tosa.c                    |  14 +-
 hw/arm/versatilepb.c             |   2 +-
 hw/arm/vexpress.c                |   2 +-
 hw/arm/z2.c                      |  20 +--
 hw/audio/wm8750.c                |  18 +-
 hw/display/ati.c                 |   4 +-
 hw/display/i2c-ddc.c             |  10 +-
 hw/display/sii9022.c             |  16 +-
 hw/display/sm501.c               |   2 +-
 hw/display/ssd0303.c             |  14 +-
 hw/display/xlnx_dp.c             |   2 +-
 hw/gpio/max7310.c                |  14 +-
 hw/gpio/pca9552.c                |  14 +-
 hw/gpio/pca9554.c                |  14 +-
 hw/gpio/pcf8574.c                |  12 +-
 hw/i2c/aspeed_i2c.c              |  16 +-
 hw/i2c/core.c                    |  90 +++++-----
 hw/i2c/i2c_mux_pca954x.c         |   6 +-
 hw/i2c/imx_i2c.c                 |   2 +-
 hw/i2c/smbus_slave.c             |  12 +-
 hw/input/lm832x.c                |  14 +-
 hw/misc/axp2xx.c                 |  14 +-
 hw/misc/i2c-echo.c               |  14 +-
 hw/nvram/eeprom_at24c.c          |  26 +--
 hw/ppc/e500.c                    |   2 +-
 hw/ppc/pnv.c                     |   4 +-
 hw/ppc/sam460ex.c                |   2 +-
 hw/rtc/ds1338.c                  |  14 +-
 hw/rtc/m41t80.c                  |  12 +-
 hw/rtc/twl92230.c                |  16 +-
 hw/sensor/dps310.c               |  14 +-
 hw/sensor/emc141x.c              |  16 +-
 hw/sensor/lsm303dlhc_mag.c       |  16 +-
 hw/sensor/tmp105.c               |  16 +-
 hw/sensor/tmp421.c               |  20 +--
 hw/tpm/tpm_tis_i2c.c             |  12 +-
 55 files changed, 541 insertions(+), 506 deletions(-)

-- 
2.41.0


