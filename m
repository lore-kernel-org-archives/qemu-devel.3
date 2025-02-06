Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11ECC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6SZ-0007aq-S5; Thu, 06 Feb 2025 13:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6SQ-0007ZE-61
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:35 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6SO-0006kp-6M
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:33 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso8318395e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738865909; x=1739470709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oA7haI5LhG5r9smI/ATEoeTI8SYOBebnSO/8gJsVZP8=;
 b=AOH0adHkiHHzSmOIash2bPwxOUsq8TZOzMOFDfdIYD6gsVOp0OpKedGRnfj0xGMHWZ
 QaUwO/tefddmfJZ33cf7O2Vy6M96Gcl+A1P1aKbmcXuipovr4lE8fbRST81EwHAZUBda
 BlRH0Q/eMo8gPnyBRDnvCXTp+t1l0tyP5YEDXd8TaV973dohxC/Hczd3dqebx+eavq0M
 j+cdDEL3zceefoD3QeYxLWyDznqefELLVTy/ZnmmG3q97CPgIm9aMGhtAtKdNHbNr+Oq
 jBQ0s8iFqKvAwcYj0PSRqXMFQLoJaw7QmCAgfJtalct6hckCNaVb+uBHHoxTeZQ9UXmZ
 E9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738865909; x=1739470709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oA7haI5LhG5r9smI/ATEoeTI8SYOBebnSO/8gJsVZP8=;
 b=vSpyGgdFR8ZmLpcLiyDFt78Pw8MbGAPOnfPdz12SBwaaI4NIiMC8GZ84LNpJj7bcOR
 F5V2AAday3LnmQqOZrACT1NZ+5Hoc5+/TxIt3HX1KxObIALn/or3BZmv0h/tfkDfjtE1
 H341IJkoGmfD04GMmWTZatjsQmxhLRQvw/4rWrU4LwEKzTAKgdJkYXJosJ0FehpTyb+m
 3BSetTNiRbWUhlCXtZODChBfD03eHy8/QxPGU1JaIP+BVBfXpMgHWLlEwMhH7lNzxTac
 fuYBdyg0zOnojef1NnTRrDo+6YHumQg3BAATvNCJl2gANzOJ3rNws8yqMGefM8XDESNX
 A7OQ==
X-Gm-Message-State: AOJu0YxBc6EIVkE1vfZ1v5iajW5jsQlmF5fEziJYLELhvgX/QotklgAe
 8tdQfimJYF7AiAOL+3wIzkezT7g4/tLLPfVWB2mNMYBzuIKNyTgAC87kWAC0QDA0a8JWSrOL8qW
 Jdcs=
X-Gm-Gg: ASbGncu0MCYBpeDKCQDh2asRnwQ+b8W5mY4UfdaFbSJvBCcj5UY3/C7oqpUTx4/1dUQ
 6MJJWwyU5KA06QeJtdNWkmT0BkOaVNMUajSfSPBbsp7EDd2qkZ/EKKrng+GoGu3GxCoD4HpB7MQ
 g3VlJol5eORSs9oKJjvMa2FHi9ytwUnymRbdDZ8Etqs/2wbJCvtxiccWZ/8UEE5oZLnqPbD2akn
 eQ/GgUTNWIcu/HcomEUDMMAAE9iScLcNSw4/GugogrWErPLRAoljIqAQ7hAZ3lz3xQ0Fud43tMY
 V4wCs6gRkuZC5B9i7mqtV7OLUTD8OJ7kX6VcJJy2SWII4NqA+sdmum983Si/S6T7yw==
X-Google-Smtp-Source: AGHT+IEafAL2zqe9LiF8uiaXbSAc4SQr4atI4Wo+oHl1W+KmZGCN2yAGbll1nwyiVh1uRMYxOQAN9A==
X-Received: by 2002:a05:600c:4f50:b0:436:ed50:4f8a with SMTP id
 5b1f17b1804b1-439249841b4mr4224485e9.10.1738865909457; 
 Thu, 06 Feb 2025 10:18:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43907f19247sm58323555e9.1.2025.02.06.10.18.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 10:18:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] hw/riscv: Move few units to common_ss[]
Date: Thu,  6 Feb 2025 19:18:20 +0100
Message-ID: <20250206181827.41557-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Remove target-specificity in some units and move them to
the meson common_ss[] source set to build them once.

Philippe Mathieu-Daudé (7):
  MAINTAINERS: Unify Alistair's professional email address
  target/riscv: Move target-agnostic definitions to 'cpu-qom.h'
  hw/riscv/opentitan: Include missing 'exec/address-spaces.h' header
  hw/riscv/boot: Use 'hwaddr' type for firmware addresses
  hw/riscv/iommu: Reduce needs for target-specific code
  hw/riscv/hart: Make 'riscv_hart.h' header target-agnostic
  hw/riscv: Move few objects to common_ss[] to build them once

 MAINTAINERS                     | 12 +++++-----
 include/hw/riscv/boot.h         | 21 +++++++++--------
 include/hw/riscv/boot_opensbi.h | 14 ++++++------
 include/hw/riscv/riscv_hart.h   |  4 ++--
 target/riscv/cpu-qom.h          | 40 +++++++++++++++++++++++++++++++++
 target/riscv/cpu.h              | 24 --------------------
 target/riscv/cpu_bits.h         | 15 -------------
 hw/riscv/boot.c                 | 28 +++++++++++------------
 hw/riscv/opentitan.c            |  1 +
 hw/riscv/riscv-iommu-pci.c      |  5 +++--
 hw/riscv/riscv-iommu-sys.c      |  1 -
 hw/riscv/riscv-iommu.c          |  1 +
 hw/riscv/virt-acpi-build.c      |  1 +
 hw/riscv/meson.build            |  5 +++--
 14 files changed, 88 insertions(+), 84 deletions(-)

-- 
2.47.1


