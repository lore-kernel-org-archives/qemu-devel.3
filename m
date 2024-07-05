Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4EBC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr2o-0001Vm-2b; Fri, 05 Jul 2024 18:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr2m-0001Vb-Ue
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:04:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr2l-00079q-95
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:04:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-426526d3051so8424415e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217077; x=1720821877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZpEuDggFW7opC4Oq/ai95MlIGz+5rZSkJhhlvzF8oM=;
 b=bFdrks0ENwjrOZh0OXzTMKh78hC/QRl6u7dmHrszJWPmiJpgZApOY1YBkC+P5Tw6ws
 ZjiA8Gazyicbe+lPsyPa41h94ZXl4Coz8a3fbxXH6kqUexJYgO8KmBf9PTEF/uBPnOdd
 w5h6cAAcy7Gy7EZLHwtHkgrXYJnNC8mAsn9CwH1m4wCoyExsXRx461gyd0C1nTEFp/id
 eQ+8pBJvt74O474ja0P/s7Hvt+e+iRrWlyReMUEujAOpOmtA5SjjanWqxjyTJr3afQqQ
 m87fMpmmy8W2nZM95jW0uS0m8CzXSUfkZRJPp0ybcedcI4K1ooq10fyW4/TGhOkALNq5
 exCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217077; x=1720821877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ZpEuDggFW7opC4Oq/ai95MlIGz+5rZSkJhhlvzF8oM=;
 b=Gf1CAR8sW65VlYbUZwzZeXvs8I3Ss9TYTQqGzrmSNjn3y+zIxpVanzbXWlFXbkA/Lt
 Rj8shd9dQCRcxv+npADJ9CHmem0LZSgZ31asmUqBqrD3Fcqx8Eb2yJP4WwG0r8OudDxI
 SHF49v5ObkE3TLa/7FyimXRxw94PZ95TLTvtNAM4429k1dmh5+GAIWAcjAWpC9fiN1QB
 lIQ2EyOicdRiWG9FIpZ/sJxrzMk1fGGIgY6Y8lJxSli3sXOv+4RBw1uND5vy8iwMuolE
 iIk/Dl9hnMJICoQVYD6YcRNpVU503QBFkiyrmNlmywgSaEq8xqQ1DDo09Dovkt3j6v3N
 Xf+w==
X-Gm-Message-State: AOJu0Yyxjqn/3957pAAGTJEUK0XJvN++vpvfAgSScYBcpw+BAbbAzWk+
 G8qGh+YpegVyVwUTabQ+c6wM0FsNEolfZBZNvhh1rH7Q0Ih/Com3QpeFjd2tm0SciM3BiUBknzf
 b
X-Google-Smtp-Source: AGHT+IEfQpwarlnX8U2qyQzympgicOfvug6RD9tch6ygNAzj2xw75i7hg/gs3YUnR0Q3fjst+HxLEw==
X-Received: by 2002:a05:600c:783:b0:426:52a5:1ca4 with SMTP id
 5b1f17b1804b1-42652a51d3bmr24871565e9.21.1720217077267; 
 Fri, 05 Jul 2024 15:04:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d510bsm76226505e9.3.2024.07.05.15.04.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:04:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/16] SD/MMC patches for 2024-07-06
Date: Sat,  6 Jul 2024 00:04:18 +0200
Message-ID: <20240705220435.15415-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The following changes since commit f2cb4026fccfe073f84a4b440e41d3ed0c3134f6:

  Merge tag 'pull-maintainer-july24-050724-1' of https://gitlab.com/stsquad/qemu into staging (2024-07-05 09:15:48 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/sdmmc-20240706

for you to fetch changes up to 0bcea3f74b04cdc23ecd6822bea7e46a55eb4be7:

  hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from TYPE_SD_CARD (2024-07-05 23:55:02 +0200)

----------------------------------------------------------------
SD/MMC patches queue

- Use published card address (RCA) in qtest/npcm7xx_sdhci
- Have cards use random RCA
- Use SD spec v3.01 by default
- Convert GEN_CMD to sd_generic_read/write_byte style
- Extract SDMMC_COMMON abstract QDev parent from SD_CARD
- Few housekeeping

----------------------------------------------------------------

Philippe Mathieu-Daudé (16):
  hw/sd/sdhci: Log non-sequencial access as GUEST_ERROR
  hw/sd/npcm7xx_sdhci: Use TYPE_SYSBUS_SDHCI definition
  tests/qtest/npcm7xx_sdhci: Access the card using its published address
  hw/sd/sdcard: Generate random RCA value
  hw/sd/sdcard: Remove leftover comment about removed 'spi' Property
  hw/sd/sdcard: Use spec v3.01 by default
  hw/sd/sdcard: Rename sd_cmd_SEND_OP_COND handler
  hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
  hw/sd/sdcard: Remove sd_none enum from sd_cmd_type_t
  hw/sd/sdcard: Remove noise from sd_acmd_name()
  hw/sd/sdcard: Remove noise from sd_cmd_name()
  hw/sd/sdcard: Remove default case in read/write on DAT lines
  hw/sd/sdcard: Trace length of data read on DAT lines
  hw/sd/sdcard: Cover more SDCardStates
  hw/sd/sdcard: Introduce set_csd/set_cid handlers
  hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from TYPE_SD_CARD

 hw/sd/sdmmc-internal.h           |   3 +
 include/hw/sd/sd.h               |   3 +-
 tests/qtest/libqos/sdhci-cmd.h   |   2 +
 hw/core/machine.c                |   1 +
 hw/sd/core.c                     |  29 ++---
 hw/sd/npcm7xx_sdhci.c            |   3 +-
 hw/sd/sd.c                       | 177 +++++++++++++++----------------
 hw/sd/sdhci.c                    |   5 +-
 tests/qtest/npcm7xx_sdhci-test.c |   8 +-
 hw/sd/trace-events               |   3 +-
 10 files changed, 124 insertions(+), 110 deletions(-)

-- 
2.41.0


