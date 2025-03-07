Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560DBC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIJ-0000w0-Vo; Fri, 07 Mar 2025 10:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIF-0000us-9C
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:20 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIC-000898-7i
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:18 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so1927703f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360034; x=1741964834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dJa7xFMSJ9Cj8sAYI9y1hV/NskVbtE4S9vRHsNQbdj8=;
 b=XSrxlXKZDWZghH/3DjN+v7VrXSUicoODJzOBNQUNbkH8n9JW9D5UllUJJw5GBnFRNF
 xUdYs2pYnm1PWhLxgGCfPvF1+zlBKWVdHs6RvGD0x5RfJsBV4EEARMGpNls1ymFI8xR+
 QPodK6eWVZWoXqfAfwlpwevuOArkn/wIcN6msUZvRSnEa5rUWWg+iSAjR2V0Gb0EOvEw
 q7CEX/P9z0HQd+oFNAwpGhA3PTRiv7uq935zN2rgl+jIKXIuX7TQc3PDKEarYeVj6PZ7
 Ct7wh7NvxlbhZwgaeddPvsbvcZNBaSV8xe4QKwaPFCyyJxyq8XzCTe+qhwJS31kEknVY
 ARYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360034; x=1741964834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJa7xFMSJ9Cj8sAYI9y1hV/NskVbtE4S9vRHsNQbdj8=;
 b=PVwUCa4Ikzz0xX+r/SSBTCFxWZ2qLHoIGBoosr23zByCJcks6CivJF0RBxyKvQCPKN
 ejUa1yY11FkwNAFTXgyqJ0CJrnjYT/TgIYcd1w21g4MjkpSdWV2Hxse8TIqGfSC6zHrt
 xmU6gxQoSGZsLYeAhvRseLTnqjsSjg4/t48SpUOnLRyF49cjgEijb3G1DGbUSk7ahf/K
 3fO2y5SRcVmHnTF3ed824TgHlyaHg0jgJVcor/GZ0QopYT7gbbECSzuaEFFAAxi2MtQi
 J/i+918QBtkREsLgzq/smnz0J9zTDTmHt95yBWqDUbAgarrofbgURsd3gbR5EO2Sa2Ys
 cTxQ==
X-Gm-Message-State: AOJu0YyvXsJgn4lnDmMKEhzuL7+4VkAhrNHVo0fPSW+jD8OC1qWv/vRr
 M5CSVt+W5zuEB3lerKAvG16CQ3L+8ol7RQ3xEBnQhvz7yXE86iZW3bUrO1qB8ZKZaOZKW55viw0
 x
X-Gm-Gg: ASbGnctgfVp/ATlXDSLDzEU52uk9zpeH8FMgHNXUJaEVD+Y67SwFcBhE1CUB4qxt4iq
 pquYMOW44R8VCoYNDwT87UeMS9IqS7tFVvvj+oQCDjz2IE0jzjOuxMNWthrSd6DV5I0lAeOxCsv
 3CgBLowN+/yA8MpeOVbmdzBfrzc4d84NRMaZwtiMfLhmU3b0TL6IFdMPbdqA8ZZ4E8UmVHEoj74
 EbmZjJdOsyYXvKqf2jH91lwMytq/PO2n33irygIH+yCrlMdzND2cNjgaENGlwAiEcB4dT1fyTHC
 Rdhb5sRxOesUhpQ2yKsUbbAVVwHGGBYbD4KG1i1TISdmvFfgr1E=
X-Google-Smtp-Source: AGHT+IHP7D6KsDUOeNhHxc9V30FkxjqXeBIloOt+xMSXLkwTuYXHlPRQ8GjCqG2VQLEBocoq4cbTdA==
X-Received: by 2002:a5d:6d0f:0:b0:390:e46f:4454 with SMTP id
 ffacd0b85a97d-39132d72c52mr3186094f8f.32.1741360033505; 
 Fri, 07 Mar 2025 07:07:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] hw/gpio: npcm7xx: fixup out-of-bounds access
Date: Fri,  7 Mar 2025 15:06:49 +0000
Message-ID: <20250307150708.3222813-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Patrick Venture <venture@google.com>

The reg isn't validated to be a possible register before
it's dereferenced for one case.  The mmio space registered
for the gpio device is 4KiB but there aren't that many
registers in the struct.

Cc: qemu-stable@nongnu.org
Fixes: 526dbbe0874 ("hw/gpio: Add GPIO model for Nuvoton NPCM7xx")
Signed-off-by: Patrick Venture <venture@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250226024603.493148-1-venture@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/npcm7xx_gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
index 23e67424c9f..2916056fae6 100644
--- a/hw/gpio/npcm7xx_gpio.c
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -220,8 +220,6 @@ static void npcm7xx_gpio_regs_write(void *opaque, hwaddr addr, uint64_t v,
         return;
     }
 
-    diff = s->regs[reg] ^ value;
-
     switch (reg) {
     case NPCM7XX_GPIO_TLOCK1:
     case NPCM7XX_GPIO_TLOCK2:
@@ -242,6 +240,7 @@ static void npcm7xx_gpio_regs_write(void *opaque, hwaddr addr, uint64_t v,
     case NPCM7XX_GPIO_PU:
     case NPCM7XX_GPIO_PD:
     case NPCM7XX_GPIO_IEM:
+        diff = s->regs[reg] ^ value;
         s->regs[reg] = value;
         npcm7xx_gpio_update_pins(s, diff);
         break;
-- 
2.43.0


