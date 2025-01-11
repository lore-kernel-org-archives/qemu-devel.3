Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA76E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMX-00075A-8H; Sat, 11 Jan 2025 13:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMV-00073O-0l; Sat, 11 Jan 2025 13:37:31 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMT-0003v0-Hy; Sat, 11 Jan 2025 13:37:30 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso592343566b.1; 
 Sat, 11 Jan 2025 10:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620647; x=1737225447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLLW6tmRMTFVZiGC25lz3MV0RvDlnwjBxsbU4akQaSk=;
 b=YR7HI+f3Qyps7fkLsEbBWB/Qv/Di3VmpnMZP+jNZRDRFZASiHyBnDhA5uCRu1oSu9k
 Ao9+rVDy3C9YBjWE5bCc4XjaIEE70WHU3waxil2QHpPQXP1acgIwKLqtK9zpMYnOX91u
 qmyUZdD9m9hMeNCS2rOxJHH5VSIxy/ATi+ZB3f4d4cRjV+jjhUFyGP//0sr5N4FOGeh3
 F9om7mxXbM/qmrq3Y/7Wcas/Mf0G2Jm35W2d0Tq+8OPqBlo38sgYeFV4mIEgWJEWJOky
 FnA9OepOUbZxBM88hbesMNrze3nsvEEeKXpyF/D4FpMEBOf+0dA2FpX7vOS22DC9WVXz
 TD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620647; x=1737225447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLLW6tmRMTFVZiGC25lz3MV0RvDlnwjBxsbU4akQaSk=;
 b=olZ7/kFKp3fhGN/lg5UmQyJy+IwbbQNgBBQh9gN3gBWjatjCy9Sm0HYlA4FMvYaZQp
 61MX4PGq7tR+yqOxkm2mQJpZDQD660V4HqgePELPLQar7tbn3sH4J4tkjBhytVGCx/Ar
 4H+q24O7i0e+g+BKqcy2JEWPOGS2vmH1e06l85iK+WhbiO9ynOvmcPdzT9EVGL8xaUL/
 UBlURLFv5Q0yp3/Knujw9cPV8nVzMX4jcR4iBFYmIWME16+jPCNcQH8yi1bGEY5gphPa
 fF3Mh9OocDrtlROnKpVz7u/HNYLjA8JAh6lgBYzng9F7ZyZs1euyL5KV7BZRxHOUB6se
 a1bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUccsYoB4YvZ7D8NrRSPpypbKuUzi94L8M0LeuIcFKoXUaMwQbJyIPUCjzt7yDHEqYOcsBVkLouJw==@nongnu.org,
 AJvYcCVNtFSdz4lee050l88ZTBfl4+sYxBdt9pc9hhA1/4sH93e8YrLcqYIZi6oAwWT2umHKWtPt1oEgmJGyjw==@nongnu.org
X-Gm-Message-State: AOJu0Yzt8JbAFZTm0nirpN2MCqGdXoBmLhltyVBKLDX0iJJTSlYpf4em
 rTGZ63LaTQ8crQ4FYeogoZzXzgGsS8EDt3XUO2eKPxHDQDXSEBns8XP6QQ==
X-Gm-Gg: ASbGncvdTO2RRKUqFbzz/+/BjZHFBDL+eZrbNwP4HpX/pU+6fF5/XgiGNFQZtEO5WSi
 cFSaGpcBlw8DtqSHkiUco0Sv7Lm8bkKbllUg6ELwUgB8U8MEvAcHZRsNv0nlgiUglCBOf0y2HQY
 AbvdBcXf0vmEJicMclwmg1M3WgoutcZW5Eo5/jGRR19ZV2JqrExbaVSWowAcw77RAKwhoT9g8pc
 ZD6Mbh3chV9kmMsCtAsrslSF3PETk9eVH5d+s1RmLPA1FfhjBGlDz1zBxuz00Q1TbPgcsNFabHw
 oi2MKDPlisU0pZP3lPhOMAi538U1qVKr1C70TX2FFTQ=
X-Google-Smtp-Source: AGHT+IFfIeY0kZff+LsVPUs4g7pAiUNt3W/tztr0QvdXqp3P0RseQARjeV0Vx6rTXvE32g33Puv87A==
X-Received: by 2002:a17:907:948b:b0:aa6:6f92:74b1 with SMTP id
 a640c23a62f3a-ab2ab6fd565mr1258465766b.13.1736620646606; 
 Sat, 11 Jan 2025 10:37:26 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:25 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 05/13] hw/gpio/imx_gpio: Don't clear input GPIO values upon
 reset
Date: Sat, 11 Jan 2025 19:37:03 +0100
Message-ID: <20250111183711.2338-6-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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
2.48.0


