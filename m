Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A277C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJKB-0008Il-Ss; Mon, 12 Jan 2026 09:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJk-0007lf-58
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:52 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJg-0001ZC-20
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:51 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so943943366b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229686; x=1768834486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FukVwTxoJHIN3FNbcOHO2weFoJlsrxf5RmTepg8qvQg=;
 b=KhkhYIkUkZDRe4vrPe32L6ODkp9qM/CaKkJTekNl4ju3xkeRltXI37rHRlSCX+Bt6G
 0MwD73JqXw8z8PPZJ/VKA5SsCQe5oUnAsGAMyBhsw6mGu4eZF784UxXTd/w38xqEcWBl
 LnZEm5T4uQG/rj1C6+EpSHz/7ihfo+pWNJZ793lPOfpwSL0hGSj/2fpazmDqHVzivXgj
 T+VelILRcUjDuVC9dMcamoNCKYzUEaDCEMZ2K1ea2hCeFkDjZgS57QhjqR/hXEKYhZRO
 7Qx7BKi+eu4iFlv7MiaFCHaALJEm8EwoK5L9H+21yrHQ8bY9cKoOFbHFJ40jhC+uQKEX
 fXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229686; x=1768834486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FukVwTxoJHIN3FNbcOHO2weFoJlsrxf5RmTepg8qvQg=;
 b=uBvPJi69LidiFvEbaxxYROQzHmxDneqTbB79BNUFNJ3uWi9JZrwgtsb6bg3Ut0vtFL
 FWaZOw+Q8vrWaKu6OA7KYC9gEoDkVAFzcV+VsKO8fRpZ+cOrB0wBiFFTDN3uzMgh5/fp
 jbXBSKEbPj8rzVsw+bqXDfWljPKyH9ARQlaW7hoGyTgLPSyUat8+eNggq3z9yMzaw/2O
 1INuuyIHvHyQmTSGJ8iPz2vWTfujQu5U/FsJQ96yV79ySDO3tpUtX0Sz951BkJcJ8481
 hneWb+drkVsETwCSTahcPWnD+qNwdcDZqq59+C+B4t6F/nKyncZyCsKPlDofl76DjixG
 vTRg==
X-Gm-Message-State: AOJu0Ywzlsh/PqTOSnDL/nsxKyl6HXcwwoFX7vmq+u5nnHtshnLVYeHr
 i8+qtzgXT10erySMD+Oc+HCZGxJHbF4fNKJJ98s/e/ZeGJ2x73X9Tw7uElWtYeoJ
X-Gm-Gg: AY/fxX7t9M8UmDCa4K1Uvb8h0LIUEkZwCmxuoXGHHoIHbDggawsg3wdxyoo30bsPzEP
 rXrtXnVzTLDPxEGpdNOYWk/a65qbYmjL8QqNhHhfPKeHNEnGE53Ts2cvHulml3CYgeJp/JTBuX5
 2vBrHq+NykcAsV3oh4GY1Izb05XO/ZG4eWanzdi/vJjbSQJivVXcAJkl2boxiKIfGhi1f7NAwD7
 nzj6XAjtjF8URw3mZMgKW8lFm39mutmdnuhnJo7MReMfMMZo7foofjtjJ+C7Wa0qBuX4Hakij8f
 z8Ww5NfAT2Rmc+czqkGlkqZSvZXNxWJO6kevTlu8FQqV65+B9jvCfMzlZ8f39jFDEHejRwQk3ms
 FG6u8XmyW97b1bl5XSqULOv89jnpQID8n3isAhDxNDkVMh2mV9hlgU4ICZunubEmPQrSfBrTi2q
 9VNWb0iCPycftti3G7Aq3fvUZEI5aZ+Ns8kn108zcIQJGsI/+LXMlusqezVM4rxsQl4HRQ+rX1
X-Google-Smtp-Source: AGHT+IEyXT6Z2o39BteTzkxetNHbnp+sLXbZ+aq+UjAQcUtQp+l2biGMItp19RwvYrc73lEUdbJANA==
X-Received: by 2002:a17:906:ef0d:b0:b76:bcf5:a38a with SMTP id
 a640c23a62f3a-b8444b8adafmr1794843066b.0.1768229685983; 
 Mon, 12 Jan 2026 06:54:45 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:45 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 08/14] hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE
Date: Mon, 12 Jan 2026 15:54:12 +0100
Message-ID: <20260112145418.220506-9-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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

For now, TYPE_FSL_ESDHC_BE is basically a big-endian variant of
TYPE_IMX_USDHC. It will be used in the e500 machines in the next step which
prevents Linux to flood the console with "mmc0: Internal clock never
stabilised" messages.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 32962c210d..3eb0684a89 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -128,6 +128,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
 DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
                          TYPE_SYSBUS_SDHCI)
 
+#define TYPE_FSL_ESDHC_BE "fsl-esdhc-be"
+
 #define TYPE_IMX_USDHC "imx-usdhc"
 
 #define TYPE_S3C_SDHCI "s3c-sdhci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 531dd3c291..6277abe870 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1871,6 +1871,32 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     }
 }
 
+static const MemoryRegionOps esdhc_mmio_be_ops = {
+    .read = esdhc_read,
+    .write = esdhc_write,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsl_esdhc_be_init(Object *obj)
+{
+    SDHCIState *s = SYSBUS_SDHCI(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->io_ops = &esdhc_mmio_be_ops;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    qdev_prop_set_uint8(dev, "sd-spec-version", 2);
+    qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
+}
+
 static const MemoryRegionOps usdhc_mmio_ops = {
     .read = esdhc_read,
     .write = esdhc_write,
@@ -1965,6 +1991,11 @@ static const TypeInfo sdhci_types[] = {
         .instance_finalize = sdhci_sysbus_finalize,
         .class_init = sdhci_sysbus_class_init,
     },
+    {
+        .name = TYPE_FSL_ESDHC_BE,
+        .parent = TYPE_SYSBUS_SDHCI,
+        .instance_init = fsl_esdhc_be_init,
+    },
     {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
-- 
2.52.0


