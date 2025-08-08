Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF8EC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNVt-0003ic-E0; Fri, 08 Aug 2025 09:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNVK-0003Xo-PT
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:51:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNVF-0002HT-0D
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:51:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-459e3926cbbso10800765e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754661082; x=1755265882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yp5m4fBeXwoDwGsolCybQprn+LgJAPEoEeKEA8EAqcs=;
 b=XuaBiGNa5pp9iCF4vSkda8Tfep44dqeoPdjhACcAr2eflB2iE60DlkbaMZdUnl0srK
 waUyVhAzDdBZRxwlY1PvhkLFdOT2mWbSAsJh/cbkOfe64+LZ6fgJFnk2DxN0zG7g5yrC
 YKWsTW0MB9QqxmT2BEzDlMJEwtTSeIu8irLBklEnL73GMTDZXKSVcvSiDy0rjRz/w3cX
 XBHGWjpx6R9IZams1VhrhgIc+LOFd61gbZA5XueRzVkDqlGdmdRqjBARn4og9iLGM43j
 /B4j3uYCZRgxJ+reaSLIgPcmrzqFgEACPBfgyrmVnnkr6/NTGCSvI6jiTyYzKnBJyuvR
 ybjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754661082; x=1755265882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yp5m4fBeXwoDwGsolCybQprn+LgJAPEoEeKEA8EAqcs=;
 b=g737XzZLEMyUNBcqmMXQp+54mAEzdxniMqUS8mxSkIvSUfwZEqjrBAzuGzXf79/hH8
 oKucU262s16c2fpAsEej5lTtLpIM6T6fgCr1vWMdNxfb6gmCuvPBI4rzqNVozCRGzlsD
 rokNEh19bnNC8OsqMwJVrXYUpCsy78G5jzmlHKNaLAW2+8/a1eHcMB4An0UgTFN+haxl
 4YcH0dcnBx91GKnoMZQD9Da2MkBG6OtV0wpoghRRCq+HGxkJLKhJHyy489uVh9SmcYgN
 N9xX1K2ZgZFsa2TI0a1wU1PMHR+zUA52RgiBf/7bl8dw8V4TAR49xEoOuSOftr6X/5hX
 BPdA==
X-Gm-Message-State: AOJu0YzcC4yFqo3/hYGZTD4v5W+KywRMXN3R+288cCAVjshYc5ayxWrk
 h6r6jG7FbXsycTUc3NwkeknWK3zTYK0/qHLyQRIjwYWmsge+KMVOeYPskZriwpTtGi12W9mqRCX
 tq8EP
X-Gm-Gg: ASbGncvAc71vqhIDXOuoZNusvwEBdcCMlvzRvvbP+U7TLNq6y2MHdKXfpRumvt3SUY1
 jR640PevQsd7fW0Na/nFQ6hkPpXlB+wfaHmfWEj36QfgJ56Ofky+5c7xO8iAdL9WTdvu1L4+rwy
 opN+dYj30gJO7NzojHibpY4E1r4ATqcLEHw4eNcVPQ9/tbvX8C6Qzb6rSOvvG1tC8wNkoUa49oX
 eCcSNdu1rzrjVW63rMEYOVcQtMcWjvEEiL8K5rEgXh0c6RQnPRm9f36WmHLHC2+A/wxemZx0evQ
 Ks82juFiWbkRy94tjkly1aCWNY8sz2uLOAMCHrQnhjhDbP1ZtbWh5624cjSOCeeonkJH0pZth9G
 gVxXfGoM0cJnCzWcS/lQQDuwTZbJOXl5qvfcOuTjSwNlsKxwTfPTmNSX+EVrrc0YLmrFy/U29
X-Google-Smtp-Source: AGHT+IH3QzYs9RNN20Qu6V7lCJ2JNao/2tPqE48hw5Wq0pUV7w8Xs6EwFYfGdwSp2ie8wCIX589xjw==
X-Received: by 2002:a05:600c:b93:b0:459:d408:d890 with SMTP id
 5b1f17b1804b1-459f4fc4a95mr26491155e9.33.1754661082297; 
 Fri, 08 Aug 2025 06:51:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585430csm136755615e9.11.2025.08.08.06.51.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Aug 2025 06:51:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-block@nongnu.org
Subject: [PATCH-for-10.1 1/2] hw/sd/ssi-sd: Return noise (dummy byte) when no
 card connected
Date: Fri,  8 Aug 2025 15:51:14 +0200
Message-ID: <20250808135115.77310-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808135115.77310-1-philmd@linaro.org>
References: <20250808135115.77310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Commit 1585ab9f1ba ("hw/sd/sdcard: Fill SPI response bits in card
code") exposed a bug in the SPI adapter: if no SD card is plugged,
we shouldn't return any particular packet response, but the noise
shifted on the MISO line. Return the dummy byte, otherwise we get:

  qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion `s->arglen > 0' failed.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/ssi-sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 594dead19ee..3aacbd03871 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -89,6 +89,10 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
     SDRequest request;
     uint8_t longresp[5];
 
+    if (!sdbus_get_inserted(&s->sdbus)) {
+        return SSI_DUMMY;
+    }
+
     /*
      * Special case: allow CMD12 (STOP TRANSMISSION) while reading data.
      *
-- 
2.49.0


