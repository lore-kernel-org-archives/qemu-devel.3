Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26817C9EC98
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJKD-0008Qv-CP; Mon, 12 Jan 2026 09:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJl-0007mS-4q
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:53 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJh-0001Zr-8H
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:52 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64b9230f564so9147792a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229687; x=1768834487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gfNu2eoKafa2xTyp6cd5sW3VFdprV5NhfouBXm89iM=;
 b=E/zjSJM/oS2PNakdyy89VuZet8g9kqDDElUqwiQeM6hvWPofTKWmc69de2D+pMV92k
 hCqjBqukwcG5WEPtqcGzbdfiu83zYvJRNDAHvmu3yBVxQaWELOpkssBgTTunONocQiJ6
 yZufXcnjntKbG2GBeZw0UNyAW5OLnmgTxfHvHxborUYshhvvnliBsZLBXsStxrKg3HgY
 5v24ppISyOxBLPdA22b6PyzyMjjGIOHKIo+JuIOWwdf49T1b2xtjV7egLC4NlNVauvcB
 pR9dwmZN0I9I/bil0kcdCfbMM6Tz18w/lBrOAH+q9SIBS3+WVyg8m8S4Cns89J0r5YNR
 ZI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229687; x=1768834487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3gfNu2eoKafa2xTyp6cd5sW3VFdprV5NhfouBXm89iM=;
 b=P9kHOvZR+w6DiPm2UYyU9sYvf2phIIlw+xfyxTRmr1fM4yJjya712hLNapNz7+AJ3L
 6h2RBcpEp61xGk2Gx+LIWWEJww8GOys+GAvbl4uuef1mRU5pRpRKQns5ZmY6yZ8jTGsE
 aEVThKBLoRDHIuPD0N7C0sUxoB3dMPj9PjhchKcqq0qmxBFjWViwuJWUgCdZV0zERTdf
 MKNplqvN3fH4+TKAYBvMCs8kXwObYcGE9OTFl+yNmJrwpfX5pOMaXJOT7BYfVpK5e/LS
 snd/2lEKisQRrpZ4Q1Q6N9kLoikamVeCEVd/WZLVwnw/tnepMc4Wgng4w9j7k60zTq7t
 YnaA==
X-Gm-Message-State: AOJu0YxrYI4YsKBKFdkUEp9oNQ1PNTGdLc0g8qJZGY6uiUSChe2SOPlI
 RQ9SnkbERoEpAKufdzARu5+/lB+bbqbaBBi8cqO4k6SBUyHAm8eQmDo7dibrtXJl
X-Gm-Gg: AY/fxX6YxFj2ug8UwBlvZYrOXqE1sTkGfr59woNasJdb/IevdbXbRVkqqFgtfbOB+BY
 Hs+/JLPOWZSM7qnl+CWHcegGJNkCphRKyf5S/c+AUJct33oFXzUQC4oemI15Jmg2zo2L+Ji3JQ3
 iXCFGWdMzdzHoHJmc8Emptt3ZlP6GE3Gb7E/l909XVq8Od1fVPtYAZGFZXWiHaCZVKUN69sKuDm
 AYkcOewl43MFc/HPmvtu44wdCFQHMqm8TMp0EI/cly3ESm5KnVPoX39CVuDuMh4XUhEMlt8bwJK
 QPcoLCwb+Q3IG7G3UL/tIL8OAPm4kn164fViJmAP0H3eas2kLziMq+7ayP8Q0GSSOlk0mGAHm/1
 iJelj3Sl5FMCTJeAESUKkQCzu0N54hTNett6vo25ZmlKkeAJUcmNE7HbzfEQdFkgPe1OikqDek+
 VriOPiF7mCZfwCzV4s5B4wKPy3PB0sZskA1nIgAeXOvTyJ2Sf9t/rcrMo+B0VE9mD47sZVSq9T
X-Google-Smtp-Source: AGHT+IFMIamXqw+EdfYyEpkguAEuYIlm9cWOuuK8QI923kT+LufonieaG7Q2PHX051hmXg91Mi2TVw==
X-Received: by 2002:a17:906:ef0c:b0:b83:246c:c514 with SMTP id
 a640c23a62f3a-b8444fce93fmr1824040566b.51.1768229687024; 
 Mon, 12 Jan 2026 06:54:47 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:46 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 09/14] hw/ppc/e500: Use TYPE_FSL_ESDHC_BE
Date: Mon, 12 Jan 2026 15:54:13 +0100
Message-ID: <20260112145418.220506-10-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

TYPE_FSL_ESDHC_BE maches real hardware more closely by reusing code of
TYPE_IMX_USDHC. For example, it fixes Linux to flood the guest console with
"mmc0: Internal clock never stabilised" messages in the QEMU advent calendar
2018 day 19 image.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index eb0d3a418e..d6ca2e8563 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1036,15 +1036,7 @@ void ppce500_init(MachineState *machine)
         memory_region_add_subregion(ccsr_addr_space, MPC85XX_ESDHC_REGS_OFFSET,
                                     sysbus_mmio_get_region(s, 0));
 
-        /*
-         * Compatible with:
-         * - SD Host Controller Specification Version 2.0 Part A2
-         * (See MPC8569E Reference Manual)
-         */
-        dev = qdev_new(TYPE_SYSBUS_SDHCI);
-        qdev_prop_set_uint8(dev, "sd-spec-version", 2);
-        qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
-        qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
+        dev = qdev_new(TYPE_FSL_ESDHC_BE);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDHC_IRQ));
-- 
2.52.0


