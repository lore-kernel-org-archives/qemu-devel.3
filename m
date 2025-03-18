Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E0C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWlk-0004yl-Ay; Tue, 18 Mar 2025 09:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWkJ-0002ny-Lb; Tue, 18 Mar 2025 09:12:40 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjk-0003yM-Gp; Tue, 18 Mar 2025 09:12:10 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac2bfcd2a70so774331966b.0; 
 Tue, 18 Mar 2025 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303522; x=1742908322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UXGlbIZhHPzWOxHT3393dj5S24d5ZRozakrW4r6Pfw=;
 b=fPgeE1Og8RDTltNPmsdxR6J5Z9UY+s7ySu3te7s8Za6b7r7/QlBk3PKDQdACvYxdhn
 DpRiRO0UCzGph/1WMy1fiAal+C0E5ilWr2SGUacRXPpDDYzC/rCOBONPYc5PXQvh8HMw
 qYSgc8S2fGMfmyz15/Sha1Y/mEmGuY5Lhs03b/x+RFesL0h6wopuiidF0b71kJ4NDUuQ
 QxNWVqmRCks1HC6FM2QzQuyosYYGP+JGUCetjA9XAOA1P9rEonlOQ8Uym7aaVPSB7GL7
 v8M6QgTX1LXsktuoaNIj7xBElf1xQAM7Ax0ErNIB9+JWuW5NRfRobXBvfyLxdyULU/Wx
 pDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303522; x=1742908322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UXGlbIZhHPzWOxHT3393dj5S24d5ZRozakrW4r6Pfw=;
 b=ZeK5LIY78haT249skBbyIyizTQLpkxm/Ep/qL6VphPHay83ADZ7wWf7PAuGofqAXY/
 kp0a7BkHeHaO/YKhhT9oWMhryHdp466Ylix2x/LwEn3o5VqK2TSA2NGqYjt6RmAk+xMk
 RepxWx4FSPD2NehUegNrmh7LtpmVI75j8HBf22qHQbD1SQY7ZkknjCsceUcI6Uu3I0G+
 g91kd5dONm3soXb/IZ/hgf2H42ZKAuNttMnY2GVLF3bqkN6fOyJaN0pEcLViYqff2DBE
 NMTsa7hbX8Gy16kFrnAJ9ESScgtyzUVxUzMzfTjY8zdpAIYQ6FNZxNnonQwKT8SG0+Rc
 lwGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGnfF2aOWNwFEhASmNuojkN0w12CJxbHDZzGV6gRIhC4UxY+3gf4h9QnP6lbdsGg2FoWzZgzlZhg==@nongnu.org
X-Gm-Message-State: AOJu0Yxf24RZqtIu9fab8j8myoqtqe8dm789KcXEL5Juomqkd7gJ4RP4
 R/wexanel9uqrKNc/JcutYftJpaBc4Rqywu3+mnjTagKdTHBzhl/XHVnSCQC
X-Gm-Gg: ASbGncsiUs+HAjLj0Ppa6oq3zAUvhDnzTpNqtdQt13lQKLeLlQ6OJV3emBR2oV4f8VZ
 WFg3z4OpEtRIzIw8QCN0TOjoNkNtO8hTYdEY08x4kMQe/5zRsu42IRL4a89GR/MJ56RSwxDLD1u
 Ou/cfYIfMfOwFtL/4gwVXMs5gg3UmxvxLRNJY75IFXxBoBPfY/OVeibHmQq+uaWHk0kPlIxNbxs
 W8fWmIaWMI2u6o/WZrXpIkeHJM+PX/N1TsTRwUOQfHcJOurMTaH/IrkseqBdy0VLZPninwEYJBG
 f87PO7/OfhAtXvOd5Rp+VZePQV8IihAwKQozdRHoewIRUA2Unhttd77ZoQe8Q6QAhTg=
X-Google-Smtp-Source: AGHT+IEEe6BEm8fwJ9kJVNEsUel1fGMglcmYM0sO/6G+h1kC5l8jLg7t138XNRLJslpExlgkwytbEQ==
X-Received: by 2002:a17:907:9712:b0:aae:e52f:3d36 with SMTP id
 a640c23a62f3a-ac3301e4c08mr1675086166b.6.1742303521946; 
 Tue, 18 Mar 2025 06:12:01 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:12:01 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 19/21] hw/arm/beckhoff_CX7200: Add CCAT to CX7200
Date: Tue, 18 Mar 2025 14:08:10 +0100
Message-ID: <20250318130817.119636-20-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

The Beckhoff CX7200 is based on the Xilinx Zynq-7000 SoC.
It integrates the Beckhoff Communication Controller (CCAT),
which is implemented as an FPGA within the Zynq's programmable
logic (PL).

This commit adds the CCAT as an MMIO device to the CX7200
machine in QEMU, enabling its emulation and interaction with
the system.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/arm/Kconfig           |  1 +
 hw/arm/beckhoff_CX7200.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a8648b9edf..782da4c22a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -327,6 +327,7 @@ config BECK_CX7200
     select XILINX_SPI
     select XILINX_SPIPS
     select ZYNQ_DEVCFG
+    select BECKHOFF_CCAT
 
 config ARM_V7M
     bool
diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
index 0f99cbf554..0fe03f570f 100644
--- a/hw/arm/beckhoff_CX7200.c
+++ b/hw/arm/beckhoff_CX7200.c
@@ -130,6 +130,17 @@ static void gem_init(uint32_t base, qemu_irq irq)
     sysbus_connect_irq(s, 0, irq);
 }
 
+static void ccat_init(uint32_t base)
+{
+    DeviceState *dev;
+    SysBusDevice *busdev;
+
+    dev = qdev_new("beckhoff-ccat");
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, base);
+}
+
 static inline int beckhoff_cx7200_init_spi_flashes(uint32_t base_addr,
                                         qemu_irq irq, bool is_qspi, int unit0)
 {
@@ -313,6 +324,8 @@ static void beckhoff_cx7200_init(MachineState *machine)
 
     gem_init(0xE000C000, pic[77 - IRQ_OFFSET]);
 
+    ccat_init(0x40000000);
+
     /*
      * Compatible with:
      * - SD Host Controller Specification Version 2.0 Part A2
-- 
2.49.0


