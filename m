Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4820C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1tn-0001tR-Ck; Sat, 08 Mar 2025 16:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rp-0005sy-Fa
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:38:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rl-00042d-DK
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bc30adad5so17911745e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469872; x=1742074672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0Bj6u5XWk2deTKslAV1isfZbUtFm4cHL8zSvqgOqZ4=;
 b=ICssHP8GDR9s84FTt2chVMNbElp5iTX8Ec/9I22dK47yvv8BbaRXW3t6aA2dcQSSY/
 /KTeSM1JG5BLsP3BudR+veD5fHYR4JrTfNPFOllkwxe3sJH51pws/gGb8/yBrEu1bUk2
 gpw+yq9vKLtoW0yjOiv2boc7EvepSPp+qUUdT+mwOkYjVCsI3DyDZnMLPhXw83Jwe9a6
 vhzOh5Oiz6uW0M9QqpX6cLyMnqOEOXesRrIW8A7DDQVJQkige/9SHhI3/xRvxOm4cVS2
 UlugNRwZ1usYw6kQM1CpdXtLKaCjNFy552T6jVMM5fLDmKxkQLwI7VjhnKXsnx0l/dtE
 4m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469872; x=1742074672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0Bj6u5XWk2deTKslAV1isfZbUtFm4cHL8zSvqgOqZ4=;
 b=q5XEmWmMK5TKk49w2U5mPD4gW+EsXS6w/nCR+G1NzfGAF70f2fJ3jT3uSh8b5t16Sg
 YDMG9Qd1CYb775Gl5oNs9HwDfhragpccAGSQkOmX1G7/5BYsfGLMb+J3BVrLpoia7Uzj
 CHUe9Qogbm5Rox0tv1cblA2tCG8rSNDDbRCptvNKk0DSDXljI8dWDnHV48+cBifzfKuj
 lbuSJrW6LeR7tCBAj5uJvcGALJhyBY4gaFdT328XdCmue14q32DoL/BVhn6U9mmSnTub
 YOsdFzegW+DWeQdvdVLjTBLnV8Z7nu/bAldOs2nWcDY47fCq5q3uppX5GIc13pzt4MQW
 NJMg==
X-Gm-Message-State: AOJu0Yzhz4BhTYb1k2zNPdOmwRrCPG9xTInn6PD2Kawpu0nZc3SqEHz/
 hfuMZnyIrdaIu9sC4T0tNv8qcSanSRWaaspHLbctPHfMVEzQUN2iJ+6tH/zyLvGvBQjTs62Al88
 UwZY=
X-Gm-Gg: ASbGncs7VSvTXl7hm4ZNJfUFeyZaVzGBrLUI27QbEbaRhGY9MyKJweo/NUXDKUCmOX8
 ydUt8T8AqdgeojDQtPt8pStxgzDz+pLj5BpL1l8fe4JEFzIcuXAKlM87voqroF/o6xn48xrSuz0
 IsBMoo2EdgJg8wzDXmL38KdJqZli+5kurimI24megP+X01RLbEcxvJBnhLw53IXYhc54nc7a+VE
 5iqGbK8Z518lqccOcuCFNZ0rQ+449MLlomUTNwGcIOySEDr2BgXDpzDwj2tYrRyGQMIWOf6AxQF
 L5tKaMS7BtxAXR4CGVYOfFdm6GQLbHyyrZbEcWWlCEENDrPZJ5vG2/7WZxdDbDwtPPKcz7zggVG
 6N5WDtLn2oQ+7sNdzO3I=
X-Google-Smtp-Source: AGHT+IGtBMnaxwa3hdQ1HgjKCiqG1eNMEWIHiorop/FgpCgWEUTP3TmitBETn/eJaHfUhXtTzb0JuA==
X-Received: by 2002:a5d:59af:0:b0:390:de66:cc0c with SMTP id
 ffacd0b85a97d-39132de1bbcmr5447541f8f.46.1741469871767; 
 Sat, 08 Mar 2025 13:37:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2b8bsm9963609f8f.64.2025.03.08.13.37.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 13/14] hw/sd/sdhci: Implement Freescale eSDHC as
 TYPE_FSL_ESDHC
Date: Sat,  8 Mar 2025 22:36:39 +0100
Message-ID: <20250308213640.13138-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
index eb8380187b5..966a1751f50 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -162,6 +162,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
 DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
                        TYPE_SYSBUS_SDHCI)
 
+#define TYPE_FSL_ESDHC "fsl-esdhc"
+
 #define TYPE_IMX_USDHC "imx-usdhc"
 
 #define TYPE_S3C_SDHCI "s3c-sdhci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 234a6e4a1fe..d5cc0bf1458 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1653,7 +1653,37 @@ static void sdhci_bus_class_init(ObjectClass *klass, void *data)
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
 
@@ -1983,6 +2013,11 @@ static const TypeInfo sdhci_types[] = {
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


