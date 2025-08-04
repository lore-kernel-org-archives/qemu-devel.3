Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB142C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwf8-00072Z-A8; Mon, 04 Aug 2025 10:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivKP-0008Fl-T4
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivKM-0008RJ-E5
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so30997735e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754314448; x=1754919248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=71w1yPowl9RTO7KXVQBpxY+KjMD4LfNAuPnGUS2NDmc=;
 b=QzGPIriIqe0tXAXXFnBE4lNL2OMBGoTOkqmwK6+a2xd4bsZV+rVbM1tp9ANFhtKBqd
 05LXmBB9HSJxHdTAI9mOO2h/f6KC4eESi+IodonNs4ns2SBAvOSsw7BNTsCxI7EOYFUM
 rk5p3RAAN6UKl9plNwlaL17xJnImg8S7oKlq5+QlQm7u3M0V1TzcLfeq7Idofy/UXoDg
 ybWJYAQ9kiaFTxA7H131Kh1tKJUedTUjuClZDNgmRO0DCWBgl3xCkE1bonPvtFd0ph9W
 PVKDjyO0KSFAObwGEM8A61q1Trc0tzL06yN3APs7xja2KIfKWpHiMHUBA9339+EfJcky
 9LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314448; x=1754919248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=71w1yPowl9RTO7KXVQBpxY+KjMD4LfNAuPnGUS2NDmc=;
 b=hd7cqteyuOAseDSzANPzWVW2nlp4zSYMCw+5u7+qnKUU2AGHZroSvU8G/9KNu5xk/D
 AF2V5pbNffNMPIJrFIxgp5Lhre16TL+JDmIGM8sN0/hksH976IjK+OwdZlGHmksQ6OeM
 103pu6vJxd6r9boLM3hOTonhZhcHynNhoprSUtPMDSR8LoWUb94AZWUfg4+Ul7pkB5TV
 2ublTCh5XXgDrQ0dTla1Vq6pXmrfnSjffPOgVq3C4PjBbNQ/nnxHbt1v71weWkwxiup+
 OWFUoqx/S7O27yzQB8G8Wt6VZOu3n5DF0CXUuSwLJjHkOC39yuhblIXd0DyfWwPNjJEM
 6ZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUitXc/xg+LKxRPU0cI3d9Ug7I8hky0iANhYecX0h+NRGSt4S4FpM+WBEv+BmnP4UqBNNzJad3lhDkX@nongnu.org
X-Gm-Message-State: AOJu0YxQ2j8Y5t+xNS9pOuIsaRTBxgTTIUneBcvGKAH03dwgnM8XTKMA
 RgLmHiC0ckLA5BaCfPBnHNHZVpqF2QEda5SYLrDO+nO7fYy4qVEOC8xyDqxMaHDgzSY=
X-Gm-Gg: ASbGnctrsFQSMWXb3A9POlyeauyZkrhrKZGLxY1/lcHHzzW5L2VrjgEI8NF0G1+87bI
 dFDsdGuNEoNW1rKYm6GB9AGaifiCSh7e82EpVdluSTfJV3kRDaNxo/PKVXS/3pgRF87kThvoBiH
 mbtWkEu3nX9k2FJqu959oXaT1ArPRhXRgc5gY037S6L7aMKnyDg1I74fhEL+EQEdzh86Gg9YRTW
 JZ1shdZ+Qqv79VV47v16sHgAiLILmgz1X3Avmm2MGV5/E4CgSG2Zv3K/Cm1xxXhwaEIUQM3/VLF
 +F82/UkEIW1FDM6eZoZcmtqKfJMM152tgFxp56nTXngd5p0pOVqZBLiCoV0iZMiJmFovU2oDkeY
 PaNupH2veh3ChBS2oabRhTKwHti/R5fogSFpEoU462AuppHzOvlQGCAKAsS0w6yR/NcTHBulg
X-Google-Smtp-Source: AGHT+IGbVe31gT//v4a6/azroTh7Glf6nat9vb1d57UA4WFAUaQNKmwJd3Tn0DGKUg0tri+n8dAMsg==
X-Received: by 2002:a05:600c:1e8c:b0:456:11cc:360d with SMTP id
 5b1f17b1804b1-458b69de114mr73176085e9.9.1754314448442; 
 Mon, 04 Aug 2025 06:34:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dfa64da0sm12464425e9.3.2025.08.04.06.34.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Aug 2025 06:34:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-10.1 v2 00/11] hw/sd: Fix SD cards in SPI mode
Date: Mon,  4 Aug 2025 15:33:54 +0200
Message-ID: <20250804133406.17456-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
- new patch factoring sd_response_size() out (Richard)

This series fix a pair of issues with SD cards used wired
via a SPI link / controller.

Such mode implementation was minimal. I was testing it with
the ARM Gumstix machines, but we remove them in the v9.2.0
release (commit a2ccff4d2bc ), so they bit-rotted.

Although the series looks big, I shrinked it a lot to have
the minimum amount of meaningful changes. Other changes
added during debugging will be shared later, as I believe
they will still be useful to debug other future issues.

The last patch add testing coverage, to avoid further bitrot.

Regards,

Phil.

Philippe Mathieu-Daudé (11):
  hw/sd/sdcard: Do not ignore errors in sd_cmd_to_sendingdata()
  hw/sd/sdcard: Factor sd_response_size() out
  hw/sd/sdbus: Provide buffer size to sdbus_do_command()
  hw/sd/sdcard: Fill SPI response bits in card code
  hw/sd/sdcard: Implement SPI R2 return value
  hw/sd/sdcard: Use complete SEND_OP_COND implementation in SPI mode
  hw/sd/sdcard: Allow using SWITCH_FUNCTION in more SPI states
  hw/sd/sdcard: Factor spi_cmd_SEND_CxD() out
  hw/sd/sdcard: Disable checking STBY mode in SPI SEND_CSD/CID
  hw/sd/sdcard: Remove SDState::mode field
  tests/functional: Test SD cards in SPI mode (using sifive_u machine)

 MAINTAINERS                               |   1 +
 include/hw/sd/sd.h                        |  23 ++-
 hw/sd/allwinner-sdhost.c                  |   7 +-
 hw/sd/bcm2835_sdhost.c                    |   7 +-
 hw/sd/core.c                              |   5 +-
 hw/sd/omap_mmc.c                          |   5 +-
 hw/sd/pl181.c                             |   6 +-
 hw/sd/sd.c                                | 198 ++++++++++++++++------
 hw/sd/sdhci.c                             |   6 +-
 hw/sd/ssi-sd.c                            | 100 ++---------
 hw/sd/trace-events                        |   4 +-
 tests/functional/meson.build              |   1 +
 tests/functional/test_riscv64_sifive_u.py |  51 ++++++
 13 files changed, 249 insertions(+), 165 deletions(-)
 create mode 100755 tests/functional/test_riscv64_sifive_u.py

-- 
2.49.0


