Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015E1CE7AA3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smY2n-0002g1-0Y; Fri, 06 Sep 2024 08:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2O-00016O-Ia; Fri, 06 Sep 2024 08:26:05 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2M-00024R-Up; Fri, 06 Sep 2024 08:26:04 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7c6aee8e8daso1451812a12.0; 
 Fri, 06 Sep 2024 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725625560; x=1726230360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/CG8oTE97MQ3mzxYzcnj6JCXco3Y8qe4hbK/c5UiUk=;
 b=ZecGtxnjVmkBONNyQavxipqkT8rvW3mPfx4EDvFwUGJLfoKI/ioIqaE1zC+DjFdBoh
 2dpWq1FDoV0A0qPU7bhpUkEiUoDIRPHi27vR98tFBklreMFafMi4L0uOWYkvHjf+/LM5
 cIWx8hrWjmRGBj8M6lCAs43H2kCz90M+rRarlM0RABb+cJM2OqsV4JriTCYPXgkRJLv6
 zctCVEI0uq553rs6VruJyoewqOhgFYJ9jXctL9SK2Cf47p3Ummekg5278HOdC0svlzw0
 D5/gKBpOiIz2MDz7EI7Sho0KJ/Xgxj3zvNpc6LeZ6mh2XrHzH/BlZnuJDMV1Xu+3NBic
 y8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725625560; x=1726230360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T/CG8oTE97MQ3mzxYzcnj6JCXco3Y8qe4hbK/c5UiUk=;
 b=oeH201ld8WCNp1SYj/umeDwpWGQLlzsTz2ZE+GD7fHJTnrtQAEcfNp2k36I59BNRrh
 t+dc+rew7JZf92SJA6Epr5Z2h6EcCgSmp0OwWqwFYGE2XDubsj8zhOLDNX6VAqB7RHvu
 GEz12QQywjdorKnc3d+26d9IQJNasyR8syc5mK/lqwbHi9SM5dMec3IJFYGnN4HzJvJs
 wmSfsRsbpEb8Lc1im6VHRkSwREpW9H+YEIBHvT2BmL3yvd6TMce9x0vhvVO7bkm6YMwA
 WP9V1sDb6CGpqpUfoRkwzuqOkRQURokd61bX7cag7Aat2YH6BzvWRXq+Otoed/eqPqrs
 GmLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrGf6vhdQR3mIq09WDRWskd/9jxzcH7zkGu0LmtGwBRlaxZ8eYNU2vPH8jsfPe4T25My4DXx/sKw==@nongnu.org
X-Gm-Message-State: AOJu0YzZYpGPIAAPiPzeqjHGtZDGVQPKP9CptvipwEbt9LTPMjOYSkkE
 dSbrIeNk5JAbms6uLM8RsAdkaBoqxgmMDcFxvusPU8GZAwduOL5AITeCEA==
X-Google-Smtp-Source: AGHT+IGDSQlvrSIHoAD8lUmh2/QIQUt4vAb/eNqXr63/ROl0+Kir9TEnva/GB6yBgAwHQFSThoxTJA==
X-Received: by 2002:a17:90b:4a89:b0:2d3:df93:1e5f with SMTP id
 98e67ed59e1d1-2dad4dddd89mr2666007a91.6.1725625560566; 
 Fri, 06 Sep 2024 05:26:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc1105fesm1412060a91.43.2024.09.06.05.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:26:00 -0700 (PDT)
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
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 8/8] aspeed: Add uhci support for ast2400 and ast2500
Date: Fri,  6 Sep 2024 05:25:42 -0700
Message-ID: <20240906122542.3808997-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906122542.3808997-1-linux@roeck-us.net>
References: <20240906122542.3808997-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Enable UHCI support for ast2400 and ast2500 SoCs. With this patch,
the UHCI port is successfully instantiated on the ast2500-evb machine.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/aspeed_ast2400.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index d125886207..93bfe3e3dd 100644
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


