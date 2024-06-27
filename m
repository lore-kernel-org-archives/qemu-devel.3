Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6522C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsf2-0007Uj-Ro; Thu, 27 Jun 2024 13:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsez-0007Mu-Hv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:11:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsev-00024s-3z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:11:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3626c29d3f0so4320061f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508302; x=1720113102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtkOlWWAl+ZO/rW9NaCd8yU+f3fnPw9yKybdzc1seps=;
 b=LFxi6UZTzQPP+HiVBGfYDtJZFI+eUYLjSUBPcPywkbiRyAgXH5YMWjprRMqnQooZz9
 ZY3tjGaCRQAy6TTl6TqVW9ECs1n0waIhMamtnhoBx5FABR/G3xiYZuzFJodDh7y2BLZ8
 +ZA/qnJ0HC/Vkq0tlCuMM5idLEisR0WvfF2EQ/BIo8dywg+1GcipN/BSufg7/wHCQbOU
 lzgZzVqGs0RAK/PCW50XECLBpsdm+DeSz7TAImDr3jG1HhSIEkC8b4FSA8TDUGARmZSb
 0JDSU1W5fWMlJl81l+yY4B28EzG3cGrO8O1s1KXx8N5WFMSrDFguYqZYHzYr+iOM3Fsq
 T45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508302; x=1720113102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtkOlWWAl+ZO/rW9NaCd8yU+f3fnPw9yKybdzc1seps=;
 b=tEzH1Aan8HTBNpZQE3GM2It90qccgO4joFTu7a+ImOWJDIQl2U83oI+sQJjG1pE1SS
 iHLXXvfdzF0dwtJsdkvqzeA2LMXaaTqbEz3Rp+fPymCV6j6bVcGZ6/GMBqbt3lSkad5c
 Gy5WnaOh9FjLIxgqRMAcS+RUdKiPza8vnXJeMVFjkadN3F6MuDBYXuusPB4+QMWRk7Vm
 sGVURVA4T/BMMLptL4lQtmHWoQqdyxUoI9/M3JLswxjM1qPnZVzhle3/Tl/X90YYEBfg
 +d0thT4h2L/K2D0a4yk+OWo3TfjV7pFrebfHwfwU/tpZfVCLkivH811WwPsm6s9RA+Kl
 2t4g==
X-Gm-Message-State: AOJu0Ywp9VweRsqfgJPmYGA4Zo/QdMKZjvVYDjgtHqv2ioUVeSdZXcX4
 XX9NWgtiARjrQhPRyNMCYdA2eouTeJNRfmnRMrlYzvvu3JIufnMcCgq52Et1DfP0xRAYcvq5fxf
 vQyA=
X-Google-Smtp-Source: AGHT+IGEbc31zb3KBR06wNiyvJHpxUbo/nPUl8YyefpupXii3Nsr6sUeTOAkp80bbqCW2wJTCE7q5g==
X-Received: by 2002:a05:6000:4021:b0:364:d2b6:4520 with SMTP id
 ffacd0b85a97d-366e937af09mr14977181f8f.0.1719508302067; 
 Thu, 27 Jun 2024 10:11:42 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c0f5sm2518803f8f.4.2024.06.27.10.11.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:11:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 03/19] hw/sd/sdcard: Basis for eMMC support
Date: Thu, 27 Jun 2024 19:10:43 +0200
Message-ID: <20240627171059.84349-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h |  3 +++
 hw/sd/sd.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 0d6d9e452b..d35a839f5e 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -96,6 +96,9 @@ OBJECT_DECLARE_TYPE(SDState, SDCardClass, SD_CARD)
 #define TYPE_SD_CARD_SPI "sd-card-spi"
 DECLARE_INSTANCE_CHECKER(SDState, SD_CARD_SPI, TYPE_SD_CARD_SPI)
 
+#define TYPE_EMMC "emmc"
+DECLARE_INSTANCE_CHECKER(SDState, EMMC, TYPE_EMMC)
+
 struct SDCardClass {
     /*< private >*/
     DeviceClass parent_class;
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 92ac57a648..249fad0468 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2379,6 +2379,13 @@ static const SDProto sd_proto_sd = {
     },
 };
 
+static const SDProto sd_proto_emmc = {
+    /* Only v4.5 is supported */
+    .name = "eMMC",
+    .cmd = {
+    },
+};
+
 static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
@@ -2504,6 +2511,28 @@ static void sd_spi_class_init(ObjectClass *klass, void *data)
     sc->proto = &sd_proto_spi;
 }
 
+static void emmc_realize(DeviceState *dev, Error **errp)
+{
+    SDState *sd = SD_CARD(dev);
+
+    if (sd->spec_version == SD_PHY_SPECv2_00_VERS) {
+        error_setg(errp, "eMMC can not use spec v2.00");
+        return;
+    }
+
+    sd_realize(dev, errp);
+}
+
+static void emmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDCardClass *sc = SD_CARD_CLASS(klass);
+
+    dc->desc = "eMMC";
+    dc->realize = emmc_realize;
+    sc->proto = &sd_proto_emmc;
+}
+
 static const TypeInfo sd_types[] = {
     {
         .name           = TYPE_SD_CARD,
@@ -2519,6 +2548,11 @@ static const TypeInfo sd_types[] = {
         .parent         = TYPE_SD_CARD,
         .class_init     = sd_spi_class_init,
     },
+    {
+        .name = TYPE_EMMC,
+        .parent = TYPE_SD_CARD,
+        .class_init = emmc_class_init,
+    },
 };
 
 DEFINE_TYPES(sd_types)
-- 
2.41.0


