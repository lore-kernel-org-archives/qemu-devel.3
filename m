Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C9AD42BB0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuC9-0003AB-8h; Tue, 12 Nov 2024 11:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuC4-000372-3d; Tue, 12 Nov 2024 11:56:44 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuC2-0000ge-Gs; Tue, 12 Nov 2024 11:56:43 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-723db2798caso5980957b3a.0; 
 Tue, 12 Nov 2024 08:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430600; x=1732035400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46KVdS+/Hw1rTusRxdJmkbj33EFntnxAICo5vL0yryE=;
 b=lUzmV3tWhfBuXFKD8E1AInd98yQZnrGxKCvV7H27MDlSfxprNd1yJ9el41hJqgfhlW
 gGQ6fsy7VdabSLZWMsOBjv7TKRJBZ67FzHhvyUPFzQdKkj0an13kDaRu19ND1o8dMZff
 jm1Ace3iZ1VVEjVtQ7cgo75tZgcADD7CRI6HThD6vPoVDMa3GQQIxqkFod3QDfZ6SEuW
 5bYQYxGmITWgfnw59MilRW8n1RmS3vJ8TmmAWXeDZjZ0chDQve/RHg/Xltbb7sleeluv
 kaE03rpHfQURAnmNSorJ22KBKOPBB0GTWqAhk2PBhSGA+iMd6pXDU7ZSLtzZ3C76KOp8
 T0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430600; x=1732035400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=46KVdS+/Hw1rTusRxdJmkbj33EFntnxAICo5vL0yryE=;
 b=MqNsLxUPQDvzYThEeSrjrUl9y0RWTruNXC2kIIzuF/zc7HUVZWqhaETSg5uDNBWtKR
 KwoSbcspDyi1MILdDqtWNrLom/Wfu4patBcgk/tNjXoLhOlhyscDUyZbI6tZZgq5ltTL
 ZT9ZCOAAFMzVdJsLgk5uhsJek3iEPWyxsxqh740FyjRGbYRJA+U5E9rxX1SQB9B3AHlE
 Wn7v+3wNFZsjx3a8jaGdbCoxpXsgvIzDkYHHY73/BkZa2IkcMdaDc+zE/+4I9PzYiv+z
 o0OFW6qxSURXiQOecfE2F81cM0WOR15VtUKFJVmSa7uXIu6mKzTanUMDVBsKCGiUDbhk
 Z9dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcrtlGRJa9f/3h0PYG1d8Qj9qqD7SxbHnMRIBExkFF85up1Qxt/tiap54HC2B1XsoXeSLX+f/0pQ==@nongnu.org
X-Gm-Message-State: AOJu0YwaGBFy0kvGxmWzG628zqdkchA9FY07rhCDU6LWjYyw77P9ngW/
 OSCumQmCU+SMjLbbRNSszbiGLjxWgJSOIfBM2+KIATospyNU+MJqbMIgZg==
X-Google-Smtp-Source: AGHT+IHZJP0zR7RLPTaXh+SIHLjflp8ROaco6QV6KqtdTXb17C1NkFLZIsIPXdzJYaPQFtb6zbMoAw==
X-Received: by 2002:a05:6a21:99a5:b0:1db:a33e:2c6 with SMTP id
 adf61e73a8af0-1dc5f90a50fmr4599060637.18.1731430600288; 
 Tue, 12 Nov 2024 08:56:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240785f8c6sm11396917b3a.35.2024.11.12.08.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:56:39 -0800 (PST)
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
Subject: [PATCH 08/10] aspeed: Add uhci support for ast2400 and ast2500
Date: Tue, 12 Nov 2024 08:56:17 -0800
Message-ID: <20241112165618.217454-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112165618.217454-1-linux@roeck-us.net>
References: <20241112165618.217454-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42d.google.com
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


