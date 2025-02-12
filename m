Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00142C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiB5s-0002FG-EZ; Wed, 12 Feb 2025 06:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB5p-0002EQ-GK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:39:50 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB5j-0000Zn-IL
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:39:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43937cf2131so26800605e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739360380; x=1739965180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mEUX3qY75fsXd/SIMG1U80ZMnDgC2FfV0nZrMVlIheQ=;
 b=IObPy7KLcj3hV1yfbX0rNGRyYkyttzPHEycUx/0aku7yptfTZo3+OyUmUFoFY3WEoH
 fPCM0fJIH9wknbGrt5ipX4chqAMKKKlkzGpMiQJSWqDK1BtVQd7W31BOUHA1HAVj+UG4
 UyHhKvneSXqEfVgMeIUgoau4lg7c2Lw7pHVJQnubJRcA+7BGz8Yl/f2bZE1VYbKxpW2D
 z5D5iqVRm7VFVbBDl28y0BhWR3vmn4o8xguyszksVxs1rPvF+Ikmo19BZZ6wO9RsoZxI
 Xmr1zJ/qleDZDrkW3lv1muBM9aDO9/pTd+Ofnzmpr88h4GlxJlrgLq26HBmnXi2M+JQN
 QX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360380; x=1739965180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mEUX3qY75fsXd/SIMG1U80ZMnDgC2FfV0nZrMVlIheQ=;
 b=rNWQm6xhwE9gRXfVUu0buTAYcysTb30WfOE8k+fABI5+BmDX9/oO9rXZJEecdQB4/2
 KDYuEIjZjtvfjvtq69pjy/gCQvZYsWDJPuwzbsMXu3FkexezIaMaIf0noUoFdO2+JgTq
 Uym7XJgd8uoTVc/RrLASkuW+LoRJlIAaHOM6PQn6ew4qKcEawyYaeZbDU7ubmoG9OQ9E
 C45js4jFi7+wKhqjYpJbwjta3vbMQFLCMjNs73y98fW+CebV4x70ji71zMdVPFaPZE4a
 FClCWpV1pj9aX3KQN7UHJUi7dTaYlpfRT5+tqkUm5cDNV6dEqYJZe+seEwCbrP/8a7Tb
 hRjQ==
X-Gm-Message-State: AOJu0YzAQR5T2g1RYRawDFqa5halVck6ILqG6+VBS1eKt0Kue2D8y2QG
 rHyweGW22D8fTljmZ/SS9DOGbrK/nNjsYiJsXhyHtjw111hv6VnXL+m16Lct9fVdt+I14QuZUZs
 /D00=
X-Gm-Gg: ASbGnctbIryJwjyyxz9+aqYtfbZc0WVzBOgzC9dq64EhHG+INmkvhF3M851qXwv7JF/
 LrqXwd7003/orAUABKeelPkD94fsR7WeUFcsAOZPrsDow0tmu8L2UXRncF/DAPMsqlNmqgvXmVg
 HaJHELELCmy0PxFY4CIMTQ2iHF4//SFr3WU0tKpeIjDudmZ4+KnfbeMwNyWDBgs0xGzb/Ogy0r6
 ENuo9E+F+wKlt5CblaXNX07oAjPU9U9PulKe1nug8BBpum8WcnUrpaLzleRKND3amxzG9lgSKTu
 Hrf5Sal85YlsMhE3TBmuaU8Ubc2ja44hPyaJ0V65o6CA7OjpsFbYCwyULRm4K/8BUA==
X-Google-Smtp-Source: AGHT+IGiPOKE5tGuWBcONNAS1mB8UGkRPdODUB+yaTglzhr5xSQiwZic+w4sPo83XiYKE1oyWF30eA==
X-Received: by 2002:a05:6000:1faa:b0:38d:e9dd:bc88 with SMTP id
 ffacd0b85a97d-38dea3c33f4mr2183502f8f.7.1739360380324; 
 Wed, 12 Feb 2025 03:39:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f1f27e612sm861398f8f.93.2025.02.12.03.39.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:39:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowang@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 0/5] hw: More DEVICE_ [NATIVE -> LITTLE] _ENDIAN conversions
Date: Wed, 12 Feb 2025 12:39:33 +0100
Message-ID: <20250212113938.38692-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

When devices are only built for little-endian targets,
DEVICE_NATIVE_ENDIAN expand to DEVICE_LITTLE_ENDIAN.
Replace by the latter to simplify.

Philippe Mathieu-Daudé (5):
  hw/arm: Mark Allwinner Technology devices as little-endian
  hw/mips: Mark Boston machine devices as little-endian
  hw/mips: Mark Loonson3 Virt machine devices as little-endian
  hw/pci-host: Mark versatile regions as little-endian
  target/i386: Mark WHPX APIC region as little-endian

 hw/arm/allwinner-a10.c         |  2 +-
 hw/arm/allwinner-h3.c          |  8 ++++----
 hw/arm/allwinner-r40.c         |  2 +-
 hw/i2c/allwinner-i2c.c         |  2 +-
 hw/intc/allwinner-a10-pic.c    |  2 +-
 hw/mips/boston.c               |  6 +++---
 hw/mips/loongson3_virt.c       |  4 ++--
 hw/misc/allwinner-a10-ccm.c    |  2 +-
 hw/misc/allwinner-a10-dramc.c  |  2 +-
 hw/misc/allwinner-cpucfg.c     |  2 +-
 hw/misc/allwinner-h3-ccu.c     |  2 +-
 hw/misc/allwinner-h3-dramc.c   |  6 +++---
 hw/misc/allwinner-h3-sysctrl.c |  2 +-
 hw/misc/allwinner-r40-ccu.c    |  2 +-
 hw/misc/allwinner-r40-dramc.c  | 10 +++++-----
 hw/misc/allwinner-sid.c        |  2 +-
 hw/misc/allwinner-sramc.c      |  2 +-
 hw/net/allwinner-sun8i-emac.c  |  2 +-
 hw/net/allwinner_emac.c        |  2 +-
 hw/pci-host/versatile.c        |  4 ++--
 hw/rtc/allwinner-rtc.c         |  2 +-
 hw/sd/allwinner-sdhost.c       |  2 +-
 hw/ssi/allwinner-a10-spi.c     |  2 +-
 hw/timer/allwinner-a10-pit.c   |  2 +-
 hw/watchdog/allwinner-wdt.c    |  2 +-
 target/i386/whpx/whpx-apic.c   |  2 +-
 26 files changed, 39 insertions(+), 39 deletions(-)

-- 
2.47.1


