Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51072C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCjQ-00030D-1t; Tue, 09 Jul 2024 11:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjN-0002sz-Fm
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:13 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjK-0006Bb-Iy
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:13 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eea7e2b0e6so30248081fa.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538768; x=1721143568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qg1OvvbVnYB9NkPyvKNWOuJA/h7PKPgrnxpR3YQLVd8=;
 b=qe79qGCD1MrbcMPa5Gab6KXm3Nom68m4Ba/FUfPkxD7HRbaDMnBpmf71NCmQsMPoaj
 Em3nKRdpmg4bPTlFPRbRj80Z7OfYIHDFpHlxu612pdUb3Sw1LeV2x0KkEu5VuM/Oszim
 jycivY+2dXA4noodsz11gZrjS4gnMkGuORWQqzc1xORX7c/uf5gDmxiOYyqU3uX7H4Ls
 3bGHS+tcrTODHJRjROmtEts6eA+lO/ZJyiGMRn5MkiKp1JFlnNR6OziIn8f9yZmECK2u
 ELYneF1zN0D1ZqUSlsP7BmwTFGW4UfsQ3Cnhjz5Gb4Av2vDRU6lvn0ZD20OfG3imsJ+R
 s91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538768; x=1721143568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qg1OvvbVnYB9NkPyvKNWOuJA/h7PKPgrnxpR3YQLVd8=;
 b=DQqTKTqnqAzI+PEcgi5jS4xnlIp3zSUO4/qLhSEeVvN1FDqXI+j+6FWl/NYDt46nCU
 ksT68T+t6JKnUeA7bNjMkL4AuZ5wk2dgepKKFvv0I/r4QGDCv+dtcHjnNf1Fzdy7Jslg
 7Aueicf+eYeAq1ilnrSzM46zAvIKBD9KrOiwaStGolIor8oKeV9T+rQ+iXB2GWmiNQWq
 A+z/fNZ1VklQDQsLx1QScyA/RppMpxANTYQ4jwlF3X+X0YAa7vr94UH6UKqgT5i89vTE
 m/FR99dfw5DMBr15H31gyrEjIksZZEVbSHt2IcvKCrT/Jclxe28lL47y/Ed7fQlql7/H
 TzDw==
X-Gm-Message-State: AOJu0YxcTi5W10mpTR63o4O96fp5ZYIE+TcL4kcRMQhtVivMBkJahPOd
 Fr/HHd3qXWD2EZntRehhs8tXJYZ6oEKC5jhw3km4it8BQFViZthYe45G+EG04je06h201ramoqk
 q
X-Google-Smtp-Source: AGHT+IFmIVKvM5DozlK0UPcmolaNhLC/d1xOCEZGb/JK1Jxz+uVEXYB+M+Z+K0XWZu/hUqfIrT8Ybw==
X-Received: by 2002:a2e:3014:0:b0:2ec:543f:6013 with SMTP id
 38308e7fff4ca-2eeb30d9814mr18582841fa.13.1720538766585; 
 Tue, 09 Jul 2024 08:26:06 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6f5f25sm46032035e9.26.2024.07.09.08.26.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:26:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v47 01/19] hw/sd/sdcard: Basis for eMMC support
Date: Tue,  9 Jul 2024 17:25:38 +0200
Message-ID: <20240709152556.52896-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add basis for supporting eMMC.

Since eMMC are soldered on boards, it is not user-creatable.

Currently TYPE_EMMC is just a stub, so disabled (marked abstract).

RCA register is initialized to 1, per spec v4.3,
chapter 8.5 "RCA register":

  The default value of the RCA register is 0x0001.
  The value 0x0000 is reserved to set all cards into
  the Stand-by State with CMD7.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h |  3 +++
 hw/sd/sd.c         | 50 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

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
index d6a07f0ade..91a73aea8d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2,6 +2,8 @@
  * SD Memory Card emulation as defined in the "SD Memory Card Physical
  * layer specification, Version 2.00."
  *
+ * eMMC emulation defined in "JEDEC Standard No. 84-A43"
+ *
  * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
  * Copyright (c) 2007 CodeSourcery
  * Copyright (c) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
@@ -169,12 +171,18 @@ struct SDState {
 static void sd_realize(DeviceState *dev, Error **errp);
 
 static const SDProto sd_proto_spi;
+static const SDProto sd_proto_emmc;
 
 static bool sd_is_spi(SDState *sd)
 {
     return sd->proto == &sd_proto_spi;
 }
 
+static bool sd_is_emmc(SDState *sd)
+{
+    return sd->proto == &sd_proto_emmc;
+}
+
 static const char *sd_version_str(enum SDPhySpecificationVersion version)
 {
     static const char *sdphy_version[] = {
@@ -697,7 +705,7 @@ static void sd_reset(DeviceState *dev)
     sd->state = sd_idle_state;
 
     /* card registers */
-    sd->rca = 0x0000;
+    sd->rca = sd_is_emmc(sd) ? 0x0001 : 0x0000;
     sd->size = size;
     sd_set_ocr(sd);
     sd_set_scr(sd);
@@ -2375,6 +2383,13 @@ static const SDProto sd_proto_sd = {
     },
 };
 
+static const SDProto sd_proto_emmc = {
+    /* Only v4.3 is supported */
+    .name = "eMMC",
+    .cmd = {
+    },
+};
+
 static void sd_instance_init(Object *obj)
 {
     SDState *sd = SDMMC_COMMON(obj);
@@ -2446,6 +2461,15 @@ static void sd_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void emmc_realize(DeviceState *dev, Error **errp)
+{
+    SDState *sd = SDMMC_COMMON(dev);
+
+    sd->spec_version = SD_PHY_SPECv3_01_VERS; /* Actually v4.3 */
+
+    sd_realize(dev, errp);
+}
+
 static Property sdmmc_common_properties[] = {
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     DEFINE_PROP_END_OF_LIST()
@@ -2457,6 +2481,10 @@ static Property sd_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static Property emmc_properties[] = {
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void sdmmc_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2509,6 +2537,20 @@ static void sd_spi_class_init(ObjectClass *klass, void *data)
     sc->proto = &sd_proto_spi;
 }
 
+static void emmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
+
+    dc->desc = "eMMC";
+    dc->realize = emmc_realize;
+    device_class_set_props(dc, emmc_properties);
+    /* Reason: Soldered on board */
+    dc->user_creatable = false;
+
+    sc->proto = &sd_proto_emmc;
+}
+
 static const TypeInfo sd_types[] = {
     {
         .name           = TYPE_SDMMC_COMMON,
@@ -2530,6 +2572,12 @@ static const TypeInfo sd_types[] = {
         .parent         = TYPE_SD_CARD,
         .class_init     = sd_spi_class_init,
     },
+    {
+        .name           = TYPE_EMMC,
+        .parent         = TYPE_SDMMC_COMMON,
+        .class_init     = emmc_class_init,
+        .abstract       = true, /* FIXME: Remove once model fully functional */
+    },
 };
 
 DEFINE_TYPES(sd_types)
-- 
2.41.0


