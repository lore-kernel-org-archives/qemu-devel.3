Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893EEC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr4G-0006cU-GJ; Fri, 05 Jul 2024 18:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr4A-0006MU-Vy
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:06:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr47-0007lm-D5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:06:06 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-424a3ccd0c0so13648485e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217162; x=1720821962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hlkz3clXDCDO3v5Iog6G74XdcZ10dv/Csn6ZB+lh8og=;
 b=UsHAcBr2IX/k15lCaYs7K6Ke1R1mTfTe6HPPVlKUbC/FFe+WSO68SJpgpvSmjnHHjr
 8nmvFr7+lvNrzM+tYYJm/ftP0eUW613DZB9cSLzmo1C+HKttegJNKhxROeXYfvrDXg8b
 aJiknz5UNsSWyw3IAE/g2ABurZMRT1KdhRtN6bM9A1AN92pysY+oz2MbYpbJ/BkCN+Li
 1ZMIiOkmfU4B1oZvHtexkR+XCb64PjPcmFH6ur4Iz3LPI7R8uOhG1Arc6cG8w0gIzG+B
 CsIKTH9jKGTMdhCSfLRc5YP/HL18DulVAhty7O1/FkbieMyFv5BgcWZ/6kin/mbVeKbE
 Wj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217162; x=1720821962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hlkz3clXDCDO3v5Iog6G74XdcZ10dv/Csn6ZB+lh8og=;
 b=nMUMtMrEk7Y89N5+NqZGFEPJfVgYYZJ1OSmHk/MB2sdzNW1bBrhEsmkf4RzlNkP0lU
 mKol1AITvKIn3sP9Rm0cWnpRbXS9U4HUc2q+oA4eDND1btcM9MfsLQBCBrSDAIEtJK85
 SgFcKlidg2BejojO8xI1mzX8yB1iaV7gkZslBIrwLO73cfSQWvAkv3zdzLLJHrbdlhB5
 xKvyX59r1WJk7pnwe0EY2gex8bi9vQ/MlrMNQaVyHmIyHEy61RWDUc0H1jSJIYUeCAoz
 lBCgPdTcEr8o9ECqggsP2f6ekvU2ZzqSJTrdIAB7Q/2l8+TtUhIECrwZkNUWrl5oKMdu
 QT3g==
X-Gm-Message-State: AOJu0YwL0Rkq3yeCsh7f9akWFn44GC41mL+rQX7uL6qOEH7yUfbfMeEk
 OEa5HdyTnK4MbmxgjZ7+NYu8iVAjGDkK+30TTdI3AyTFHROEQ8lufUY1Qv0PWtdK7pd+qX/ZO3G
 1
X-Google-Smtp-Source: AGHT+IGQc5vesk+maRMpg4+4OEh5Hb+woNrZbtYXNWogN7i5i670aeOdxtMkFW31THOqThC6AY3/5g==
X-Received: by 2002:a05:600c:158b:b0:422:62db:5a02 with SMTP id
 5b1f17b1804b1-4264a4561d7mr39828355e9.32.1720217161638; 
 Fri, 05 Jul 2024 15:06:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d510bsm76253755e9.3.2024.07.05.15.06.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:06:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 16/16] hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from TYPE_SD_CARD
Date: Sat,  6 Jul 2024 00:04:34 +0200
Message-ID: <20240705220435.15415-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
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

In order to keep eMMC model simpler to maintain,
extract common properties and the common code from
class_init to the (internal) TYPE_SDMMC_COMMON.

Update the corresponding QOM cast macros.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240703134356.85972-6-philmd@linaro.org>
---
 hw/sd/sdmmc-internal.h |  3 +++
 hw/sd/core.c           | 29 ++++++++++++------------
 hw/sd/sd.c             | 51 +++++++++++++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index cc0b69e834..91eb5b6b2f 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -11,6 +11,9 @@
 #ifndef SDMMC_INTERNAL_H
 #define SDMMC_INTERNAL_H
 
+#define TYPE_SDMMC_COMMON "sdmmc-common"
+DECLARE_OBJ_CHECKERS(SDState, SDCardClass, SDMMC_COMMON, TYPE_SDMMC_COMMON)
+
 /*
  * EXT_CSD Modes segment
  *
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 52d5d90045..4b30218b52 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -24,6 +24,7 @@
 #include "hw/sd/sd.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "sdmmc-internal.h"
 #include "trace.h"
 
 static inline const char *sdbus_name(SDBus *sdbus)
@@ -39,7 +40,7 @@ static SDState *get_card(SDBus *sdbus)
     if (!kid) {
         return NULL;
     }
-    return SD_CARD(kid->child);
+    return SDMMC_COMMON(kid->child);
 }
 
 uint8_t sdbus_get_dat_lines(SDBus *sdbus)
@@ -48,7 +49,7 @@ uint8_t sdbus_get_dat_lines(SDBus *sdbus)
     uint8_t dat_lines = 0b1111; /* 4 bit bus width */
 
     if (slave) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(slave);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(slave);
 
         if (sc->get_dat_lines) {
             dat_lines = sc->get_dat_lines(slave);
@@ -65,7 +66,7 @@ bool sdbus_get_cmd_line(SDBus *sdbus)
     bool cmd_line = true;
 
     if (slave) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(slave);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(slave);
 
         if (sc->get_cmd_line) {
             cmd_line = sc->get_cmd_line(slave);
@@ -82,7 +83,7 @@ void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts)
 
     trace_sdbus_set_voltage(sdbus_name(sdbus), millivolts);
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         assert(sc->set_voltage);
         sc->set_voltage(card, millivolts);
@@ -95,7 +96,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
 
     trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg);
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         return sc->do_command(card, req, response);
     }
@@ -109,7 +110,7 @@ void sdbus_write_byte(SDBus *sdbus, uint8_t value)
 
     trace_sdbus_write(sdbus_name(sdbus), value);
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         sc->write_byte(card, value);
     }
@@ -121,7 +122,7 @@ void sdbus_write_data(SDBus *sdbus, const void *buf, size_t length)
     const uint8_t *data = buf;
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         for (size_t i = 0; i < length; i++) {
             trace_sdbus_write(sdbus_name(sdbus), data[i]);
@@ -136,7 +137,7 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
     uint8_t value = 0;
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         value = sc->read_byte(card);
     }
@@ -151,7 +152,7 @@ void sdbus_read_data(SDBus *sdbus, void *buf, size_t length)
     uint8_t *data = buf;
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         for (size_t i = 0; i < length; i++) {
             data[i] = sc->read_byte(card);
@@ -165,7 +166,7 @@ bool sdbus_receive_ready(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         return sc->receive_ready(card);
     }
@@ -178,7 +179,7 @@ bool sdbus_data_ready(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         return sc->data_ready(card);
     }
@@ -191,7 +192,7 @@ bool sdbus_get_inserted(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         return sc->get_inserted(card);
     }
@@ -204,7 +205,7 @@ bool sdbus_get_readonly(SDBus *sdbus)
     SDState *card = get_card(sdbus);
 
     if (card) {
-        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
         return sc->get_readonly(card);
     }
@@ -250,7 +251,7 @@ void sdbus_reparent_card(SDBus *from, SDBus *to)
         return;
     }
 
-    sc = SD_CARD_GET_CLASS(card);
+    sc = SDMMC_COMMON_GET_CLASS(card);
     readonly = sc->get_readonly(card);
 
     sdbus_set_inserted(from, false);
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 058a70a0f8..d6a07f0ade 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -679,8 +679,8 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
 
 static void sd_reset(DeviceState *dev)
 {
-    SDState *sd = SD_CARD(dev);
-    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
+    SDState *sd = SDMMC_COMMON(dev);
+    SDCardClass *sc = SDMMC_COMMON_GET_CLASS(sd);
     uint64_t size;
     uint64_t sect;
 
@@ -2377,8 +2377,8 @@ static const SDProto sd_proto_sd = {
 
 static void sd_instance_init(Object *obj)
 {
-    SDState *sd = SD_CARD(obj);
-    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
+    SDState *sd = SDMMC_COMMON(obj);
+    SDCardClass *sc = SDMMC_COMMON_GET_CLASS(sd);
 
     sd->proto = sc->proto;
     sd->last_cmd_name = "UNSET";
@@ -2388,14 +2388,14 @@ static void sd_instance_init(Object *obj)
 
 static void sd_instance_finalize(Object *obj)
 {
-    SDState *sd = SD_CARD(obj);
+    SDState *sd = SDMMC_COMMON(obj);
 
     timer_free(sd->ocr_power_timer);
 }
 
 static void sd_realize(DeviceState *dev, Error **errp)
 {
-    SDState *sd = SD_CARD(dev);
+    SDState *sd = SDMMC_COMMON(dev);
     int ret;
 
     switch (sd->spec_version) {
@@ -2446,20 +2446,23 @@ static void sd_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property sd_properties[] = {
-    DEFINE_PROP_UINT8("spec_version", SDState,
-                      spec_version, SD_PHY_SPECv3_01_VERS),
+static Property sdmmc_common_properties[] = {
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     DEFINE_PROP_END_OF_LIST()
 };
 
-static void sd_class_init(ObjectClass *klass, void *data)
+static Property sd_properties[] = {
+    DEFINE_PROP_UINT8("spec_version", SDState,
+                      spec_version, SD_PHY_SPECv3_01_VERS),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void sdmmc_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SDCardClass *sc = SD_CARD_CLASS(klass);
+    SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
 
-    dc->realize = sd_realize;
-    device_class_set_props(dc, sd_properties);
+    device_class_set_props(dc, sdmmc_common_properties);
     dc->vmsd = &sd_vmstate;
     dc->reset = sd_reset;
     dc->bus_type = TYPE_SD_BUS;
@@ -2476,6 +2479,16 @@ static void sd_class_init(ObjectClass *klass, void *data)
     sc->enable = sd_enable;
     sc->get_inserted = sd_get_inserted;
     sc->get_readonly = sd_get_readonly;
+}
+
+static void sd_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
+
+    dc->realize = sd_realize;
+    device_class_set_props(dc, sd_properties);
+
     sc->set_cid = sd_set_cid;
     sc->set_csd = sd_set_csd;
     sc->proto = &sd_proto_sd;
@@ -2490,7 +2503,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
 static void sd_spi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SDCardClass *sc = SD_CARD_CLASS(klass);
+    SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
 
     dc->desc = "SD SPI";
     sc->proto = &sd_proto_spi;
@@ -2498,14 +2511,20 @@ static void sd_spi_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo sd_types[] = {
     {
-        .name           = TYPE_SD_CARD,
+        .name           = TYPE_SDMMC_COMMON,
         .parent         = TYPE_DEVICE,
+        .abstract       = true,
         .instance_size  = sizeof(SDState),
         .class_size     = sizeof(SDCardClass),
-        .class_init     = sd_class_init,
+        .class_init     = sdmmc_common_class_init,
         .instance_init  = sd_instance_init,
         .instance_finalize = sd_instance_finalize,
     },
+    {
+        .name           = TYPE_SD_CARD,
+        .parent         = TYPE_SDMMC_COMMON,
+        .class_init     = sd_class_init,
+    },
     {
         .name           = TYPE_SD_CARD_SPI,
         .parent         = TYPE_SD_CARD,
-- 
2.41.0


