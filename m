Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278C2C04FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnqF-0003Zl-4d; Tue, 16 Apr 2024 14:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwnqB-0003Ys-NJ
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:47:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwnq6-00031G-I5
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:47:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-418a02562b3so4791455e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713293245; x=1713898045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xGn+yfMUz11JyYIw92kbWBG3cmCj73SLHNFhXZICy+A=;
 b=pCs3FpTHAOzE9KigXLe5mOORs24V/gHsE9FSUF+C0k7GZGAAKyvizpuEx1EMQ67U06
 CPgUCxDFpCQNTQRX1/ry82DzeKHmRivPz30pEDShi2CtaGHybiHFOf4fpB7iAht7Bt89
 6zR9mfYcSbVZM79/D7NCjuLD/NGeUSQEjNNlywY/4SV45L8wHBH0Fdf+qs11MTUXfrUV
 sncM3eKXQHUkPXAZtWJkQ48yL213HDQR8WDykEXvmBHSOqmb/xJL85GB/u4WOxNETh6h
 81NBa1488C9J7l2wykgGPxVK4MCv9ZomTdHIif0ukUlXJtwqkLh0cwJwTgVZYmQZl22N
 N2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713293245; x=1713898045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xGn+yfMUz11JyYIw92kbWBG3cmCj73SLHNFhXZICy+A=;
 b=s+tuDM6Gx2KkHap2J7rxslpAByKrWFy+VG7TvCvkFHKaJMGjxpFNY+tDVn+p3pmvw6
 66XN8UxEu2Ya7Gjn1LyDtWkVYOh7oTqLe0vc6skIyOW0R4iNCEr2gLnVq/njiYTe6o1R
 s0WNWI0sb6V7plViIfgDV+qGl5F2OJ/dcNeKRfE5bmjPcvd65vnrOmUD9iXfqg1xrHmA
 N8yIN46JN51s4WugARihMi6IGVWKHB0khmz9s9z6WP6F0Yb7v5TUD9lxLBxgYAlKlewX
 nHNXsuTj1igf5wOeSy3AypDDxxn4YOnTOfk2tZ4i3TbxVNSfgoWW8jVf12Cll4kqZbog
 TDcQ==
X-Gm-Message-State: AOJu0YzcVBxuIIZJX3xjFUqZAypZWoOKpz5jNMXGKXj3/5rrbtfbHqck
 tvFvVBlOl1SyCOIpzeQ2ay+SydnRcniYqgVGJa10bjl7ZBybdeSsAUWBT8zJzUPYIDKiGRK22zI
 N
X-Google-Smtp-Source: AGHT+IHc9Cr9JlX9kDpZ0pQjmz7zt77CFWxygaJ4KtwnQos7/bgIi88HQx1GzywBpIkj2VUduOA6aA==
X-Received: by 2002:a05:600c:1e1b:b0:418:6900:96af with SMTP id
 ay27-20020a05600c1e1b00b00418690096afmr4449823wmb.25.1713293244987; 
 Tue, 16 Apr 2024 11:47:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a05600c348d00b004186eb69a55sm7331020wmq.25.2024.04.16.11.47.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 11:47:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] hw/i2c: Convert to spec v7 (inclusive) terminology
Date: Tue, 16 Apr 2024 20:47:17 +0200
Message-ID: <20240416184722.28334-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Since v1:
- Convert TYPE_I2C_TARGET definition (Paolo)

Mechanical (mostly) conversion inspired by Wolfram [*] to
use inclusive terminology, similarly to the other renames
we did 3 years ago, shortly before the I2C spec v7 was
published.

This series convert core I2C. Following will convert the
devices and SMBus.

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


