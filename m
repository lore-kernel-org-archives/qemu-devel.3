Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4229DE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKl-0004A6-Pw; Wed, 08 Jan 2025 04:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKB-0003wx-Lr; Wed, 08 Jan 2025 04:26:03 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKA-0004nD-7O; Wed, 08 Jan 2025 04:26:03 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so28517611a12.1; 
 Wed, 08 Jan 2025 01:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328358; x=1736933158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+si41bX/Zyw/CBlcJY38zyFCCW9HNp1Mb/PQUkHCqIg=;
 b=bl9a6pJmBCz2wPv98EFhCkdqK+6YERKDtpcLD0JhYVFu4DwEhQMaoAL2ib5ETeXPdX
 83m8YNAl2kYVyS8Ape1DsfOOzDa+F9xNtKZp7Vluoybvc/IKLNE8VZndauooxmHxdlD3
 b54w2V9Z4HwdjzDZPBbboa/hn4F20ntV1moJJ1WRFboVDrcwAYR5YFx/Cfd41seA0ik5
 /+3AUWh1IFRIE4QqhfBg4AY8Bi0gfK9NFaQGkwMxVbdDCf2nQyfdXsvMIeBxpRjEI2nc
 c8X1WG5uMupsdc5dbatYxvaSvVuFoAAbrzwvhLMeuxgvo22JCnS5nytbFk0dpZKnPYyG
 3O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328358; x=1736933158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+si41bX/Zyw/CBlcJY38zyFCCW9HNp1Mb/PQUkHCqIg=;
 b=nlvYUMn0S8FS0vZKf6dAdXnePVt0h3LJmHLhfTt2M90+m/4Pxl5+YHi/NA7oAibtXj
 IhC7rlk+N43dub2VIVmKNYGTwatLTTegRtBB47Pojs/F289d7ii5qPnEIlzsJFd6Gim2
 k3GznbD8AoZ0hw+8lI0fahAhmFMKmruJFLaxSkbsj53CSMNw+OtdRS9H9hu5QHpEcQGC
 DlQAdkdgRv+tRsGyLTzMmTZnNvS4/JLW4GCmimGN8KpcnFUR8jpBi4LADbaR6mUXLoAS
 jbZUKd3F05RNJppvyXosegTAyagJ1dbrSQOGTQNN90g5YQ1uUkhyhdR0T9tjzRYYlCH3
 gT5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcD2nb2HjiBmnlM9Nz6Bqs6PEwmhLbU4oDyJv3Fd1L1DAOr1XVaA+nZ8kjjXQK9rU/ktaTMRVj7w==@nongnu.org,
 AJvYcCXdeWYAz86CseCzoszZvH7pSmxBXKWYBYjVPws0avs5yrIVe9jY3V0AAAEtvrGNPtMRaJtKM7GlCgKHKQ==@nongnu.org
X-Gm-Message-State: AOJu0YwOzYWj9z3agDSItRTSn/rABt0KPhaL4Ix43QcSE+J9JmPnimJb
 hZWcR6qBmwJw8SxR0xvnMwsGj5a0LenCxjOBD0OmAa1weovkzGQEitw7sLEd
X-Gm-Gg: ASbGncv11QuDQvfC64uQvDzHjHGtGD/wnY8A/7H51yJuxGpM1M6gBmp94qXno20Sd3O
 SE1Ty7Fwu/vNjwIBFqLw8U+U5GPnLwaNPRH5vKyMTTx0Sg8ioWihjyXsGzN+A8ETNkn35PBvLqE
 8TwLEC94C82pRFhCdmcr4HdQWOvSaoTNcrRufkUHEIkfjCkIFPEtdaMXV/O6a6UY8ePDlVjraU3
 mWOOSwirrQP49/6ZtY/Je3u+eDFo6SkhC0bvu0C7jEsG+tfPKib2xxZd1mOM6no5397HPPEYtL5
 sjhM4LDtuhp6gYgBvbOxcV9hArX6eM6Ts5BAzQ5BWu+9KgM=
X-Google-Smtp-Source: AGHT+IHTJKgXpBpaV9DwiHSMDTvrEBXWrZJ3MMT352iKGc38OyNTaSSgAOhnagmwbHEjmq9PrDB04Q==
X-Received: by 2002:a05:6402:388a:b0:5d1:2631:b897 with SMTP id
 4fb4d7f45d1cf-5d972e08403mr1799549a12.14.1736328357881; 
 Wed, 08 Jan 2025 01:25:57 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:25:57 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 06/14] hw/gpio/imx_gpio: Don't clear input GPIO values upon
 reset
Date: Wed,  8 Jan 2025 10:25:30 +0100
Message-ID: <20250108092538.11474-7-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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

Input GPIO values such as a present SD card may get notified before the GPIO
controller itself gets reset. Claring the input values thus loses data. Assuming
that input GPIO events are only fired when the state changes, the input values
shouldn't be reset.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/gpio/imx_gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 898f80f8c8..67c47a7280 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -302,7 +302,6 @@ static void imx_gpio_reset(DeviceState *dev)
 
     s->dr       = 0;
     s->gdir     = 0;
-    s->psr      = 0;
     s->icr      = 0;
     s->imr      = 0;
     s->isr      = 0;
-- 
2.47.1


