Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88ECC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY5S-0005O6-Ts; Wed, 10 Jul 2024 10:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5R-0005Ey-8U
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5O-0003oQ-Te
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-36796d2e5a9so4248276f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720620859; x=1721225659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+n7iA8FGhZGBefoarGDOiJy21w0ojlipWHKW8I5p4Y=;
 b=UQAz8XMIw/1TEXi0nbXIajjc4pCT7cAglQV8h/v1N7xyWFAYcSQQT7jlMlL+cRhlJp
 Wy9mDzca748iC6M7V7FHZSHDI3YJY2yyowkYqyR9p+Io5Esfam5+RaEKqXEdsg3Rhi2k
 TRCUC6CNIrhEaIBi3i3B9yjbStViFFCKa1YdH+onPZyEob635Tzoqf3pqmqqe1XK7Af6
 fM7slkUAafWk192TqZS/6jtkVrAydn6/TXeqxicD+1RtF2F8iFBUPspNxz3amit1H53q
 B9+7oBc/+MA3uA8/qntwrkxO1OwmGYYYDHjoYJS+Im6Fx0ZxO1UhQgsQ6N9YnGiwUd+J
 cN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720620859; x=1721225659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+n7iA8FGhZGBefoarGDOiJy21w0ojlipWHKW8I5p4Y=;
 b=j+ZF8qIS82aK4xdDg7j7isOxRTK6bVmz1yc+rmRRy13SmO5ftiZpu5RZQlc8q60+W8
 JpJUQ5mDruS8Z9163h/Ygyctbsdrws69EhUJbPQbeb5h66mofxk/leEH1Y2tSIPEd/Ov
 drT2RYjVxw6gaX8fEuPKypT28QwUuTv5JqYaPtUtkFS1EFueiT6GK9NuXI2/eCG1sVtf
 rMoHFjF3PaIFX0kX845e9AWxRmURdRDwX6h5ZJdGnQIpEHg7ofWFwltgJF+XLxE5NjmL
 H6EPIHWw8IlHCGLumyeP+MsmnGOkB+pVRYuEKbRBPN4Nx237zVSTH3WWXL9z5MQggOvM
 mp0A==
X-Gm-Message-State: AOJu0YxInKa8dFZBFOJnpqo3/5kcP5jVA2XVSWePimtx+/rFpSYtaK9a
 cL2KiDHnd/bkULMVXQwfqvV0/fOAhRXJ4lYnO85LzQ9a1mmUSkXV7gNcQisulMUb2Igv1raiR+A
 L
X-Google-Smtp-Source: AGHT+IHEmKsViy5gW8ZJF7bb5wzXJ8yTMMi98BAp7u1fQE1m221IcePuXQaYRF5zqE8sSRKGq2PDIw==
X-Received: by 2002:a5d:4e46:0:b0:367:9522:5e70 with SMTP id
 ffacd0b85a97d-367ceacb5c0mr4075492f8f.52.1720620859363; 
 Wed, 10 Jul 2024 07:14:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab16csm5390472f8f.93.2024.07.10.07.14.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 07:14:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v48 01/12] hw/sd/sdcard: Basis for eMMC support
Date: Wed, 10 Jul 2024 16:13:57 +0200
Message-ID: <20240710141408.69275-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710141408.69275-1-philmd@linaro.org>
References: <20240710141408.69275-1-philmd@linaro.org>
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

Since eMMC are soldered on boards, it is not user-creatable.

RCA register is initialized to 0x0001, per spec v4.3,
chapter 8.5 "RCA register":

  The default value of the RCA register is 0x0001.
  The value 0x0000 is reserved to set all cards into
  the Stand-by State with CMD7.

The CSD register is very similar to SD one, except
the version announced is v4.3.

eMMC CID register is slightly different from SD:
- One extra PNM (5 -> 6)
- MDT is only 1 byte (2 -> 1).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
TODO: comment magic CSD values?
---
 include/hw/sd/sd.h |   3 ++
 hw/sd/sd.c         | 107 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

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
index d6a07f0ade..a4b6c7baba 100644
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
@@ -438,6 +446,23 @@ static void sd_set_cid(SDState *sd)
     sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
 }
 
+static void emmc_set_cid(SDState *sd)
+{
+    sd->cid[0] = MID;       /* Fake card manufacturer ID (MID) */
+    sd->cid[1] = 0b01;      /* CBX: soldered BGA */
+    sd->cid[2] = OID[0];    /* OEM/Application ID (OID) */
+    sd->cid[3] = PNM[0];    /* Fake product name (PNM) */
+    sd->cid[4] = PNM[1];
+    sd->cid[5] = PNM[2];
+    sd->cid[6] = PNM[3];
+    sd->cid[7] = PNM[4];
+    sd->cid[8] = PNM[4];
+    sd->cid[9] = PRV;       /* Fake product revision (PRV) */
+    stl_be_p(&sd->cid[10], 0xdeadbeef); /* Fake serial number (PSN) */
+    sd->cid[14] = (MDT_MON << 4) | (MDT_YR - 1997); /* Manufacture date (MDT) */
+    sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
+}
+
 /* Card-Specific Data register */
 
 #define HWBLOCK_SHIFT   9        /* 512 bytes */
@@ -451,6 +476,44 @@ static const uint8_t sd_csd_rw_mask[16] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
 };
 
+static void emmc_set_csd(SDState *sd, uint64_t size)
+{
+    int hwblock_shift = HWBLOCK_SHIFT;
+    uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
+    uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
+
+    sd->csd[0] = (2 << 6) | (4 << 2);
+    sd->csd[1] = 0x07;
+    sd->csd[2] = 0x00;
+    sd->csd[3] = 0x32;
+    sd->csd[4] = 0x0f;
+    if (size <= 2 * GiB) {
+        /* use 1k blocks */
+        uint32_t csize1k = (size >> (CMULT_SHIFT + 10)) - 1;
+        sd->csd[5] = 0x5a;
+        sd->csd[6] = 0x80 | ((csize1k >> 10) & 0xf);
+        sd->csd[7] = (csize1k >> 2) & 0xff;
+    } else { /* >= 2GB : size stored in ext CSD, block addressing */
+        sd->csd[5] = 0x59;
+        sd->csd[6] = 0x8f;
+        sd->csd[7] = 0xff;
+        sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
+    }
+    sd->csd[8] = 0xff;
+    sd->csd[9] = 0xfc |     /* Max. write current */
+        ((CMULT_SHIFT - 2) >> 1);
+    sd->csd[10] = 0x40 |    /* Erase sector size */
+        (((CMULT_SHIFT - 2) << 7) & 0x80) | (sectsize >> 1);
+    sd->csd[11] = 0x00 |    /* Write protect group size */
+        ((sectsize << 7) & 0x80) | wpsize;
+    sd->csd[12] = 0x90 |    /* Write speed factor */
+        (hwblock_shift >> 2);
+    sd->csd[13] = 0x20 |    /* Max. write data block length */
+        ((hwblock_shift << 6) & 0xc0);
+    sd->csd[14] = 0x00;
+    sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
+}
+
 static void sd_set_csd(SDState *sd, uint64_t size)
 {
     int hwblock_shift = HWBLOCK_SHIFT;
@@ -697,7 +760,7 @@ static void sd_reset(DeviceState *dev)
     sd->state = sd_idle_state;
 
     /* card registers */
-    sd->rca = 0x0000;
+    sd->rca = sd_is_emmc(sd) ? 0x0001 : 0x0000;
     sd->size = size;
     sd_set_ocr(sd);
     sd_set_scr(sd);
@@ -2375,6 +2438,13 @@ static const SDProto sd_proto_sd = {
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
@@ -2446,6 +2516,15 @@ static void sd_realize(DeviceState *dev, Error **errp)
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
@@ -2457,6 +2536,10 @@ static Property sd_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static Property emmc_properties[] = {
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void sdmmc_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2509,6 +2592,23 @@ static void sd_spi_class_init(ObjectClass *klass, void *data)
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
+
+    sc->set_cid = emmc_set_cid;
+    sc->set_csd = emmc_set_csd;
+}
+
 static const TypeInfo sd_types[] = {
     {
         .name           = TYPE_SDMMC_COMMON,
@@ -2530,6 +2630,11 @@ static const TypeInfo sd_types[] = {
         .parent         = TYPE_SD_CARD,
         .class_init     = sd_spi_class_init,
     },
+    {
+        .name           = TYPE_EMMC,
+        .parent         = TYPE_SDMMC_COMMON,
+        .class_init     = emmc_class_init,
+    },
 };
 
 DEFINE_TYPES(sd_types)
-- 
2.41.0


