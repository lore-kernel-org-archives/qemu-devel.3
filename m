Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFBFC282E3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWd-0005be-SD; Tue, 04 Mar 2025 20:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUo-0002yk-3f
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:27 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUk-0007EN-4K
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:24 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so6218155e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137860; x=1741742660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAGfCuU3Kbhb9h0Vekx8SOe9ZIxHfI7sjhoEbEJI7Ok=;
 b=hubTVO4R2p4r1S8gLTr3+QZlWXp5e8Oopx8eAOfNG7BWMlOy8WmoCLwX1vuy25cYNC
 Ky3Gq2uBYX2LNhJ6BkBpYoCIozd3Q56YPj5uL4dwevhUvIXbOiG1ugkWo/XarqwCS4G3
 2wbg+WnitPfFlMKAM5/NcAmDPiCBjBiOiQcdUgLybzPXMioou4qCepDPH5yZTKTOS6Tv
 GF9oK12jCmgpCj/7n6vlP7zO33/tSekZDpnohGC89VN97X+b4vrcbvDJBFcWsnhWf9G0
 oFZte12l6EACbw62RfAuCt1S2wBkWfqJmYjvM/cG3ZFgrti4Hk4oTL6HGa0+znDYD9g4
 p5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137860; x=1741742660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAGfCuU3Kbhb9h0Vekx8SOe9ZIxHfI7sjhoEbEJI7Ok=;
 b=e5NlyD7rnfAoo5S80kKYaNNnEEqssGwcf+p90zQG61vwd2epSierzMEzts2i7FtNiw
 3k0czleK6+OQdGdE8Q/ihmxsikwaODi950d1lkabbajIqH/w0lWnegBDqJZMTnmiHjM1
 gwXfYPeZZ6Q3GfqUaUy4NelXg44HXz2RbS3ms2u7wX3S7HOuFY0hU1eNMKWWQXFAmdov
 2Jsvas1Uk7UK9/iOVbTX3fYFnoDdaF+eOTyFwj7yJG5zCz1dln5tPFnk0Kv0gnGzZoxA
 XRiePZSHAQLelggHVTtKF+OGmj62FxM2XhuyDBPCyg3dfN9MDMkE70W+G+a3kdg0QTVF
 3SFA==
X-Gm-Message-State: AOJu0YzT7APCHsUHxp880nuZvvVY0C5AcVkSiEg2n3bWv52ntgc+Yznk
 HbBT2E4/yVxGqJ4ygQ1SpVW3nKSYfPlCpTf2Lq9VA4r+peD12oX/G7O2xegtKNq/M86EmUmomo0
 Y9Yw=
X-Gm-Gg: ASbGncsmZiqt973V1q7jImXMGpc7zsgMPGYThsNtAQMv+xUt4PluG2MnGDA2TZS5qaf
 0d4kxL5txBYbPNF6nQNxlLIT/wuV1ifpovKUX2YNvKQ9DAjQ+sL4J8HiQR46iGnZqlVJn9taPjm
 QP+1WzXStJcFfMxpCc83Ly4ho0IwILXSnHWY+8I1uKXvpEoyyB2wPb6Byauba//eCnhloMZyaUU
 8HM4v4XHP7AOJCZFHv945EXELHbE+qqnJu2yPU0uShm86nxxi5xwkQ8EK35K/Hed3pPwAgeA0P3
 ifHXqMy1ktU5tIZPqQzMeLhtR3zLg9Xq+sSlGFmaKwNki5wEsSGikaiVejwmR5UVRGkA3dDbu3O
 wk8urbnlWHj44StXX2LI=
X-Google-Smtp-Source: AGHT+IEeaMdkz+OCDDar26RrJDW6XKvyYLGDFccIYNMjGIaCbM++RD13r2zkzb8ETUGgc67yotR0IA==
X-Received: by 2002:a05:6000:4025:b0:390:f6aa:4e6f with SMTP id
 ffacd0b85a97d-3911f714de9mr847057f8f.10.1741137860151; 
 Tue, 04 Mar 2025 17:24:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d773sm19173652f8f.81.2025.03.04.17.24.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/41] hw/misc/macio: Improve trace logs
Date: Wed,  5 Mar 2025 02:21:44 +0100
Message-ID: <20250305012157.96463-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add macio_gpio_read trace event and use that in macio_gpio_read()
instead of macio_gpio_write. Also change log message to match
macio_timer_{read,write}.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250222122850.9D8B84E603D@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/macio/gpio.c       | 2 +-
 hw/misc/macio/trace-events | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 7cad62819a0..4364afc84af 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -135,7 +135,7 @@ static uint64_t macio_gpio_read(void *opaque, hwaddr addr, unsigned size)
         }
     }
 
-    trace_macio_gpio_write(addr, val);
+    trace_macio_gpio_read(addr, val);
     return val;
 }
 
diff --git a/hw/misc/macio/trace-events b/hw/misc/macio/trace-events
index ad4b9d1c08e..055a407aebb 100644
--- a/hw/misc/macio/trace-events
+++ b/hw/misc/macio/trace-events
@@ -18,7 +18,8 @@ macio_timer_read(uint64_t addr, unsigned len, uint32_t val) "read addr 0x%"PRIx6
 macio_set_gpio(int gpio, bool state) "setting GPIO %d to %d"
 macio_gpio_irq_assert(int gpio) "asserting GPIO %d"
 macio_gpio_irq_deassert(int gpio) "deasserting GPIO %d"
-macio_gpio_write(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64" value: 0x%"PRIx64
+macio_gpio_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
+macio_gpio_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
 
 # pmu.c
 pmu_adb_poll(int olen) "ADB autopoll, olen=%d"
-- 
2.47.1


