Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329B3D42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuJC-00045i-4i; Tue, 12 Nov 2024 12:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHh-0003Kg-8r; Tue, 12 Nov 2024 12:02:48 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHf-0001Us-Ov; Tue, 12 Nov 2024 12:02:33 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-211a4682fcaso15906785ad.2; 
 Tue, 12 Nov 2024 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430949; x=1732035749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46KVdS+/Hw1rTusRxdJmkbj33EFntnxAICo5vL0yryE=;
 b=SKamliY2Z/SHtUcHtJ54vNfIxmzTdVAC/4nOhO7g1q1PxJgHyrTNw4OhZyFmHBRF7D
 QzESEDIYgQrgw1Zku/kMIAGnYzLlxSkJGLw2w4Eb4oawoEdQ9mbeucw7QOx4wgYhSDhg
 bwLIJkxECsmfsh8RcHbdi9IyuIWEHJzNfZTz2rQIWfXSlwmt3vFPeNfTW7g5OkbGFMw0
 Y4Vb/UAeeZDXrjc/e1nQkRFlNzaBwWaKFr5fbqqBRPe8u0zND1g4hphM9RHmGF03jTrB
 e9kul5tdGIlQZQLVCKY+64QDepRXvFf3inolzWS7p+GprK0PA5cR0FyOisL4QjxUfpC8
 qz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430949; x=1732035749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=46KVdS+/Hw1rTusRxdJmkbj33EFntnxAICo5vL0yryE=;
 b=CKxUtmNWjQfnKGCIInTfJQ3sfClzK7skTsxVoGrjPZ1CfQ5gDumuBvRnXRMotGzBsr
 Rca6EUZRtR3C5DUjYVG0FQay1eNqJpR/ZcB3pJgI9uge3nhmDz2gIqsEhHFWq+0hkA+P
 Aznz6/NNfybI17lcw8rHg3dAUPZQLM/H4/Iszef0dpIL1SLmFan/8JcaORhxpr8DhG2R
 mr9dyRc7h76vcbLtX6+1acNAu9ZnNhG618qzCTzIBZrtJRTOxRX4nOexg9csfhQLEtXh
 SV3FI5R432RI2aLJlJD91N1M3/sgMKpwX6eXxThVy6wtRSH0VxwU9rnOAQyZsGZtO6/R
 jC2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcC7KjkIBH0pEznK5B6myajmicIK9NKd8HwGhmp5PLprYK/Hw9nqsDCEfQGZNpHiv0j1JK6OkD5g==@nongnu.org
X-Gm-Message-State: AOJu0Yy/E1f/R2j7MCLvNzWl0UabQCN5iAA+dLF9Ho+W2VAgI2ILMtne
 18dh/mV863a30ux+NL5FySFQ3PZjqKQumxYhqtUpjRXmn1NAPxr51iRmVA==
X-Google-Smtp-Source: AGHT+IE9eoYQ2NAHlYG9Cnav4fTYVd5p31IH4zKONO59XzhMVlljLu6kBC95Eb4P1aK/0Q2cUPr4rQ==
X-Received: by 2002:a17:903:11c9:b0:20c:cccd:17a3 with SMTP id
 d9443c01a7336-2118359c11amr235120975ad.46.1731430948985; 
 Tue, 12 Nov 2024 09:02:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177cfb0ecsm95635775ad.0.2024.11.12.09.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 09:02:28 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RESEND PATCH 08/10] aspeed: Add uhci support for ast2400 and ast2500
Date: Tue, 12 Nov 2024 09:01:50 -0800
Message-ID: <20241112170152.217664-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112170152.217664-1-linux@roeck-us.net>
References: <20241112170152.217664-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add UHCI support for ast2400 and ast2500 SoCs. With this patch,
the UHCI port is successfully enabled on the ast2500-evb machine.

Note that the EHCI controller on AST2400 and AST2500 does not support
companion mode, so the UHCI controller is instantiated as stand-alone
device and creates an additional USB bus.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since RFC:
- Rebased to v9.1.0-1673-g134b443512
- Added Reviewed-by: tag
- Added explanation for not using EHCI companion mode

 hw/arm/aspeed_ast2400.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index ecc81ecc79..8a5d21459d 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -31,6 +31,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
     [ASPEED_DEV_FMC]    = 0x1E620000,
     [ASPEED_DEV_SPI1]   = 0x1E630000,
     [ASPEED_DEV_EHCI1]  = 0x1E6A1000,
+    [ASPEED_DEV_UHCI]   = 0x1E6B0000,
     [ASPEED_DEV_VIC]    = 0x1E6C0000,
     [ASPEED_DEV_SDMC]   = 0x1E6E0000,
     [ASPEED_DEV_SCU]    = 0x1E6E2000,
@@ -68,6 +69,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
     [ASPEED_DEV_SPI2]   = 0x1E631000,
     [ASPEED_DEV_EHCI1]  = 0x1E6A1000,
     [ASPEED_DEV_EHCI2]  = 0x1E6A3000,
+    [ASPEED_DEV_UHCI]   = 0x1E6B0000,
     [ASPEED_DEV_VIC]    = 0x1E6C0000,
     [ASPEED_DEV_SDMC]   = 0x1E6E0000,
     [ASPEED_DEV_SCU]    = 0x1E6E2000,
@@ -107,6 +109,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_DEV_FMC]    = 19,
     [ASPEED_DEV_EHCI1]  = 5,
     [ASPEED_DEV_EHCI2]  = 13,
+    [ASPEED_DEV_UHCI]   = 14,
     [ASPEED_DEV_SDMC]   = 0,
     [ASPEED_DEV_SCU]    = 21,
     [ASPEED_DEV_ADC]    = 31,
@@ -199,6 +202,8 @@ static void aspeed_ast2400_soc_init(Object *obj)
                                 TYPE_PLATFORM_EHCI);
     }
 
+    object_initialize_child(obj, "uhci", &s->uhci, TYPE_ASPEED_UHCI);
+
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
     object_initialize_child(obj, "sdmc", &s->sdmc, typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
@@ -393,6 +398,15 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
                            aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
     }
 
+    /* UHCI */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uhci), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->uhci), 0,
+                    sc->memmap[ASPEED_DEV_UHCI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uhci), 0,
+                       aspeed_soc_get_irq(s, ASPEED_DEV_UHCI));
+
     /* SDMC - SDRAM Memory Controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
-- 
2.45.2


