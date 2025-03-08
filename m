Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF021C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 19:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqzSb-0007vQ-M7; Sat, 08 Mar 2025 14:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzSO-0007j1-4b
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzSK-0003fY-Mb
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:03:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a823036so24828035e9.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741460607; x=1742065407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVOO+KOKZ3d7DAin1HuzOowHrfcYHXZ8ykM+c1XZbKY=;
 b=fth54c2r1QJZu+IEBe3PaTHBdIkGuJ0dm035QJonEBZPXNFZ6YhYobkOQEz3lBScO3
 6pvKNR4lJSL0ZeKbTbIQ+cCFxn/2n8fsociN4p0QhRFmmkr9mjqbUUcZk5KaIbvCCPpf
 rQpxXHgveOrGaRZlGDtzrvgjFw5cZ2XZS2/ludtuV7NxadVeV1CU7/s0EQGv96LFKCBm
 p8/n2XtyxDzBmjb4ZAvzhnxg4IiUmtYxjZEJzxUYlJiAGAADzgth1V3rFw/0wViek2v5
 ixJWyf5sfqNU/jdG3qC65o70/s8YzR9QBp7gVew6ZRa/S7eGNheYGNfbfnbL/LcT6RHw
 zGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460607; x=1742065407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVOO+KOKZ3d7DAin1HuzOowHrfcYHXZ8ykM+c1XZbKY=;
 b=Hl0fTqV2xqALLz4lOMBWoOOyPGetqfspcC9HdVkQwzzId5I407w/nxYA2V+LfFdwkd
 Q2lM55K54unUtU3JuIgtUUlp6YIKBOnfDCqfMRdcEFRnvZBNBUdoetgdBXQtZo61G7ky
 gPyrPef/vdoyDqTuH0ZXo06LJbYz8ZEgTGEGnxaTsXIOph5CQS3PEeVKL8ez/hD4ZFeN
 e4/GNPBy5Hur1Umm2Q4XeUZw2l6iG8ibqkykp6iYjPXIPZUDHwbBOtGxPN4gpT+UsQli
 ouyYP0HPpeemY5ihJbIx25Ol/Py/GXFN6QQfoUpsOuXsd/oZ8pLYd5ktvQVM8F+9RS3G
 0A8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzD6oJrdWsGkFKi831POguXUF5yGeMbOjNmyvTICVgjF51AgxmR2p6KSKJ/aef+8bHLsJkGTmrvYRb@nongnu.org
X-Gm-Message-State: AOJu0YzkTYqzBUfGJsFZ7yVW8Svsz8jiXbB+VNALZQy4d+Klzajsj94Q
 U6HejqcFdL3iCUoOh+8LWA1gf7kG1lozOERS9LUmbqCLIkS/YQZXmmRo1yqlJxk=
X-Gm-Gg: ASbGncvL14D5RjzFa7XSFY/syMPrQhnQneHkfB3qz64NQcHrlgNM88IWcevKRAP7YJs
 ZxlgYkTvkwvGgxG9MIwehnhN94ASXVWmiorw4v0/aTb+zDnk6QaBc6tWqd9IXDuI+nW3hWiNyxH
 Qh3tMVFC3rf8mp2d7hMVRDH7Y0W+dZpYGgrP3IOafTTOuCCTKdeQZNOMYWC15z24RfvAuq77V+L
 pL55x7mhDNnLbZmkQ6GWgkrbm8YhN8zu4ww9vCxr+uxj5+9/m9qsu4MSpjCzpTdJqJyEq9Fck/9
 hNnV6JlAaV5mKr++3a9xdGrh5T2Rd1Z6Wx8k82bZB+iprYUz47CxG8Aa+wYnTmzORGXZOFut4wn
 v4hsG11u7fqORRyfGjleaIptZXDavjQ==
X-Google-Smtp-Source: AGHT+IGZHSWxXsqeojMrckI//i5cN5T0tUksqSbOEJbdow1NHIrqOub4VC6CeswuqKYhLaMd/MO2XQ==
X-Received: by 2002:a05:600c:2e49:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-43cec0adf09mr11917065e9.6.1741460606973; 
 Sat, 08 Mar 2025 11:03:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292b06sm121601615e9.14.2025.03.08.11.03.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 11:03:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/12] hw/sd/sdhci: Implement Freescale eSDHC as
 TYPE_FSL_ESDHC
Date: Sat,  8 Mar 2025 20:02:29 +0100
Message-ID: <20250308190230.7508-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308190230.7508-1-philmd@linaro.org>
References: <20250308190230.7508-1-philmd@linaro.org>
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

Per the MPC8569E reference manual, its SDHC I/O range is 4KiB
wide, mapped in big endian order, and it only accepts 32-bit
aligned access. Set the default register reset values.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index e24392eb10d..0e9d3b10d1b 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -161,6 +161,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
 DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
                        TYPE_SYSBUS_SDHCI)
 
+#define TYPE_FSL_ESDHC "fsl-esdhc"
+
 #define TYPE_IMX_USDHC "imx-usdhc"
 
 #define TYPE_S3C_SDHCI "s3c-sdhci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index cda608f8ec2..a78cff40fb1 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1644,7 +1644,37 @@ static void sdhci_bus_class_init(ObjectClass *klass, void *data)
     sbc->set_readonly = sdhci_set_readonly;
 }
 
-/* --- qdev i.MX eSDHC --- */
+/* --- Freescale eSDHC (MPC8569ERM Rev.2 from 06/2011) --- */
+
+static const MemoryRegionOps fsl_esdhc_mmio_ops = {
+    .read = sdhci_read,
+    .write = sdhci_write,
+    .valid = {
+        .min_access_size = 4,
+        .unaligned = false
+    },
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsl_esdhc_class_init(ObjectClass *oc, void *data)
+{
+    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
+
+    sc->iomem_size = 0x1000;
+    sc->io_ops = &fsl_esdhc_mmio_ops;
+    sc->ro.capareg = 0x01e30000;
+    sc->reset.sdmasysad = 8;
+    sc->reset.blkcnt = 8;
+    sc->reset.prnsts = 0xff800000;
+    sc->reset.hostctl1 = 0x20; /* Endian mode (address-invariant) */
+    sc->reset.clkcon = 0x8000;
+    sc->reset.norintstsen = 0x013f;
+    sc->reset.errintstsen = 0x117f;
+
+    sdhci_common_class_init(oc, data);
+}
+
+/* --- qdev i.MX uSDHC --- */
 
 #define USDHC_MIX_CTRL                  0x48
 
@@ -1974,6 +2004,11 @@ static const TypeInfo sdhci_types[] = {
         .class_size = sizeof(SDHCIClass),
         .class_init = sdhci_sysbus_class_init,
     },
+    {
+        .name = TYPE_FSL_ESDHC,
+        .parent = TYPE_SYSBUS_SDHCI,
+        .class_init = fsl_esdhc_class_init,
+    },
     {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
-- 
2.47.1


