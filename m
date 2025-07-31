Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0597C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb0i-0003Ch-N8; Thu, 31 Jul 2025 17:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhaox-0008Ex-J2
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:28:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhaot-0007pP-Fn
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:28:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso2619115e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997289; x=1754602089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4rW26l1ud9Wfnd9RpVRyL7qycFijHbATbRRp9qeZyns=;
 b=kLQfttBjRdsL2wU8rTxER1bOyIQ5uOUVBWZBGTy2IdCZuy0cQFnWFwjKxZEzxN2ZDY
 X9HFTIqxuCN2tofeF8FqFEZhtvoEwG4aVRrs6WpuWNntvzDzbmZx+UzilCHmtppAZjow
 EFGUmqbzm/cE1D7El1KKjBvvmsIJ4jw8RMC4rTw+4RLtM9gAsZHxVqK16rBaf3pfTkka
 9EMnFmZS744zExcp0KZb9tI3XU4bRgfYFSSsc7gGh2xdMtHMmvpYLFugO53L8i1DzibM
 p1OrCDkwxVWxdnGFs0aZ8rxhYqzpR6TmMQSIkd+2dJjzpEHVpM+z2DbiSTHCzkYbBXEW
 KlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997289; x=1754602089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4rW26l1ud9Wfnd9RpVRyL7qycFijHbATbRRp9qeZyns=;
 b=ICq6RG58B3bgbxokIcrlBpgX4NgbGTa7WPSDhBYtUu7pqpeGx2CDhX7Y1Oi88aqiK7
 m8XDKPuCjHEG8qqhG2LeBk9l39eF4nhtgLZKFTPJcGvtXLMdENr+oXbbCYwqNDLfVMEZ
 E6r3VYQDO+wklBLlUtcusgnNyHP3qbvhnomLxt8VMuceun2J1EClBhCPA07N4LRrZVlO
 M1U69HIKVnLnAW0kEPjuyapE3xri7h3/II/g3Vf+RaB1USs/04GOXnFr58xK5TwVsSbQ
 uf4PhRelKbxhgoqNDS3skKmRLRW/YzF9XyxyHpt3MOQ+p1WYrdWOjmwPoMpBb+dX+LVA
 xaJA==
X-Gm-Message-State: AOJu0YxCG7MvQo21oKSZjHLAZ/DVhgZeQygizumgKErrpm9BFiPptFCY
 qz6xYRaRYhAJpzMY/VTwChuhpm1ckYMY2FNQ/pRMB9psFxS2A0qSjjmLV0bCco7bYhn2YO4d8Tj
 CN1mr
X-Gm-Gg: ASbGncvDosEpAFdeA/73NuSrkiHzB19lNe0YeFtUehS88nDlI0s279Vq3xrVqz6i0ev
 7ao43yi9gUUoclCQIF+nrO8FpCC5Bj94Rv298aQVel9ZYrsiBKvu9rHIOY9ezrWpYWEAcJGofiS
 72B+iXeJtFuh5lRSEzn+pDmy9ZKXTaBa1B9ajbcN9CedCYNE5bmUteIdBliZDi4aK4IUreDOYxt
 0kM8s5cJdF3xyP/J67+5khHXeRObwCVdIXqv7vipTKvXjKAosUG3Mh6TLfFL+4ILuz6BdZCQLJh
 45hff75HcDrXI1cdXCV+oFSTx7seb618Ps/T3e6KRnWLuSJzdR7iim9ppsucI+jbTG/UqI1vG/j
 DN1VqzkpluWDPaaBwomi6q28ksEldO7Smls7DL/JMCOTcN0CtAQOGn2s0Es4hCrntlBdHlI96
X-Google-Smtp-Source: AGHT+IGNzl4rHqWQuUXdfDwKPQIL/yr4xm1fSXN8V5qZ8dXCcqXi6wDeJw20xy8sUvmXMHmDChzwng==
X-Received: by 2002:a05:600c:8b63:b0:43c:fdbe:4398 with SMTP id
 5b1f17b1804b1-45892b93413mr80723945e9.6.1753997289525; 
 Thu, 31 Jul 2025 14:28:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dd375e0sm81527455e9.2.2025.07.31.14.28.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Jul 2025 14:28:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Weiwei Li <liwei1518@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 00/11] hw/sd: Fix SD cards in SPI mode
Date: Thu, 31 Jul 2025 23:27:55 +0200
Message-ID: <20250731212807.2706-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
  hw/sd/sdbus: Provide buffer size to sdbus_do_command()
  hw/sd/sdcard: Propagate response size to sd_response_r*_make()
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
 hw/sd/allwinner-sdhost.c                  |   5 +-
 hw/sd/bcm2835_sdhost.c                    |   5 +-
 hw/sd/core.c                              |   5 +-
 hw/sd/omap_mmc.c                          |   2 +-
 hw/sd/pl181.c                             |   4 +-
 hw/sd/sd.c                                | 202 +++++++++++++++-------
 hw/sd/sdhci.c                             |   4 +-
 hw/sd/ssi-sd.c                            |  96 ++--------
 hw/sd/trace-events                        |   4 +-
 tests/functional/meson.build              |   1 +
 tests/functional/test_riscv64_sifive_u.py |  51 ++++++
 13 files changed, 238 insertions(+), 165 deletions(-)
 create mode 100755 tests/functional/test_riscv64_sifive_u.py

-- 
2.49.0


