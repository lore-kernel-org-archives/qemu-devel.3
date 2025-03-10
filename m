Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C564C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQi7-0004qw-01; Sun, 09 Mar 2025 20:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQg7-0002MZ-5H
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQg3-0007Tv-Vh
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:29 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3913fdd003bso397810f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565246; x=1742170046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CV9763Q2OclYQny8AL1J9alx4TgqLIH5/4iLk98ggU=;
 b=CHZcEKiftzUvXVBTyVosVoBdYFfo/XtsPlWZX0tYfrRMAKFRWG8ZqCsEdQ6yg5sZnS
 M4Jk2hDD8jN2OXYVIhD6kKHSV37jvSkk5Dk6hv7ZXyaFU6YnWJiJBkLesSgrJeFG4ne5
 xpo/q22yy+UU/Vg+M5iYiSFPu+bL9mrPbtEr76xq0E2HfknJtescw53A37RZVjVZjDZQ
 dKtYo12zOvvbf9bUm71zSremsthgxLpnulvsccwc3luuWdWJF+00loUhxiWDihDHAaDx
 EYluIFuIAn2IL/GrJOauf4VPvyrtIpURgt+oeDB/NOPl6GfNn8krVjtYnepoLAp+XZVn
 pvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565246; x=1742170046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/CV9763Q2OclYQny8AL1J9alx4TgqLIH5/4iLk98ggU=;
 b=aPSSp4VdqBST+1aChlYZF+ViUjg4XrzPdR7NlAMpyw4ny7OJRGT5gJ8QPxYTZGbM4G
 ol3dmOpTNQEccM31Scw/ZdtBifeb1xEfbnrboNKBRTjeJXu5Yyu2249R0vzLFFOQOjQ9
 iApW29ZL2W8QMze/3O5OdxTmNMn1TtIjvxcXq40Lim/wn021L+rpxswhS7KM8TT/Ivmo
 gPNsioy6+H/XYqw9KG1c7JMNklEd6t745093wZGol0t55RiNiNb5YB8+XtuTuoyBZTMk
 TNrSSszaAWD6PXY4aqwZowJu11uqY/kXRcB/cOsy3FDLPjOxHWYkvGgKk29Ady5BNZzd
 GBkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsPtT9g0ZWzRZvfTHMsgdrAAcNZSOhBiNLhAHEOPzOwNg8Y8pq7PSPlFaEwUDbyOGmjtKefSdkX9pI@nongnu.org
X-Gm-Message-State: AOJu0YxmL5s3OVK6Mtc00ZcWpWdAFi87WvguoCizMapv6LXtmCyTpl1C
 BohWwokwMXZrq52Qwgl5vQEB8xpBCUCeC+YWJY9J/dmHporMnY52k8d378O36jI=
X-Gm-Gg: ASbGncsEsi5RMaruXd7tMgMTFVzPIo3dxsLfKaTAdkR8vloGtL4wutpBIvKgcBYLr38
 Bb5quFZnSU0dZtkCJA4+j6Q8U9fKSTimVk2JMTwClSw3uhDr7IoKGDiPt9lU6xtoEzbVzLqZEBX
 ZAsrtZVVZrjnt66CzvAoRT++zlVbyveKsUwHDkoQzLKp3Au3YQf768V9gpdyHdwy3d7F3+pAkPS
 5+Wqh1NoIKQFYbHTwiShI+PPP76JNqn9yiEUdLWv5cQWtEFCNZ3rB7byhY0cjOXAfF4hfJ0AVwm
 otpv7cF7nL0CIxFaB+rV8AAM8POcT3uh4+VmqP3CanSIbDTRVKPPDCC8DuWf+D/3nioCUnXOVnA
 DjMilIpUXhBg5Jd5UcJ8=
X-Google-Smtp-Source: AGHT+IFoClJlyOuPr/WDQ5vRdtBR9j8N75yyvLBubt7FhRw7WVZWafOinlTST1Q/gVsTUdybjUNFUA==
X-Received: by 2002:a5d:6c6a:0:b0:38d:dc03:a3d6 with SMTP id
 ffacd0b85a97d-3913aed81aamr4029381f8f.4.1741565246349; 
 Sun, 09 Mar 2025 17:07:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f57sm13217968f8f.91.2025.03.09.17.07.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:07:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 12/14] hw/sd/sdhci: Implement Freescale eSDHC as
 TYPE_FSL_ESDHC
Date: Mon, 10 Mar 2025 01:06:18 +0100
Message-ID: <20250310000620.70120-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Per the MPC8569E reference manual, its SDHC I/O range is 4KiB
wide, mapped in big endian order, and it only accepts 32-bit
aligned access. Set the default register reset values.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 44 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index b21adcab670..e8fced5eedc 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -171,6 +171,8 @@ DECLARE_CLASS_CHECKERS(SDHCIClass, PCI_SDHCI,
 #define TYPE_SYSBUS_SDHCI "generic-sdhci"
 OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
 
+#define TYPE_FSL_ESDHC "fsl-esdhc"
+
 #define TYPE_IMX_USDHC "imx-usdhc"
 
 #define TYPE_S3C_SDHCI "s3c-sdhci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f731b1a141a..47e4bd1a610 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1667,7 +1667,44 @@ static void sdhci_bus_class_init(ObjectClass *klass, void *data)
     sbc->set_readonly = sdhci_set_readonly;
 }
 
-/* --- qdev i.MX eSDHC --- */
+/* --- Freescale eSDHC (MPC8569ERM Rev.2 from 06/2011) --- */
+
+static const MemoryRegionOps fsl_esdhc_mmio_ops = {
+    .read = sdhci_read,
+    .write = sdhci_write,
+    .valid = {
+        /*
+         * Per the reference manual (chapter 16):
+         *
+         * All eSDHC registers must be accessed as aligned 4-byte quantities.
+         * Accesses to the eSDHC registers that are less than 4-bytes are not
+         * supported.
+         */
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
 
@@ -1997,6 +2034,11 @@ static const TypeInfo sdhci_types[] = {
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


