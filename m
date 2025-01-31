Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D6C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFS-0005Py-MC; Fri, 31 Jan 2025 16:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyFO-0004hU-2q
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:18 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyFM-00082E-08
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:17 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso18803785e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357694; x=1738962494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDN1ii+damKmSXlqt4UdR7pxlDb9QSMG1FV0pXZv6Hg=;
 b=yj+M4P0VGlnUbcHhRR1CNkJvsQdAKUEeVjFVwIz13mbKtRX8IAvYFQsksBTeEBEa9K
 kOMOUka2CYlReOsUGiu6EPqwfIsOgoFyIKyZfmuZp6v8v7SAw9FevOcvnlwY0y9PsjMm
 l+qu7CH6zWD7cW1st1Kk6F8R3P1Uva5AKhxD2gN2uygnxtcgAg2+9zPmJLzLNYKI+4Ca
 w1U7vZU8S7UA2hJvAog78Dj+e2gncQPMOJA6UKHdoNWIvYKcHCPnFc78tggb9BQV3HGj
 7hz4tzBjglF9FNR04EH7ufa6dtYGE75EUd8JRsBr8WY2idfcXf7vaYmFG//pSsKW2AXt
 ZnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357694; x=1738962494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tDN1ii+damKmSXlqt4UdR7pxlDb9QSMG1FV0pXZv6Hg=;
 b=bprCnGNrmaUVPIAxkVNrVJ9DgR5ABMNGUT304MScbs/XwBHC4UIErxjgjBdy2b0zna
 co3OMbIV3lA5KgOuGLX8VjlRjLnN96afosq1Go7544phLJxZyFlc/SFepVlFnNbJvOow
 9OIYR5xPyx9KO8aJt9UJdAAs27z45slOOHtTZvN/VOGz0zcyp3GwApSwTMwQj3KLGJ1c
 nfPWQEJxZVgT9gjdIORuPUgeQ7PjfzJfu3z3K6CkmirqIUe+9oeA2AmTEbZsKqpUZSw0
 3wX1DNETW2xKX6l75Jr4XDYXfkxPMb2uP/tx8l3IsDPqEM0Bzkpn/ak84Bnu0L52WplW
 zLdg==
X-Gm-Message-State: AOJu0YwETWO7E9TnaaPJ+Lk+DkVe71/xxh3jcKnnnu+UeLFr0YeSn/0u
 CfD3N/z5Q4H8HsqIhMicwpqe1YageVTFjUYwSjN1NcuOX31zJvyKBiFx8lPGCO87H92i7bTec7z
 KRYc=
X-Gm-Gg: ASbGncs9ZwP/0qTeQmaX2HZDZBggHuwxifFUslx5cPF4JgvUkraZWkrbdIv5NlvSdYm
 PtjeJ4LAdaRRC3J/c2DwdBWDED+KCZodDL5ETCEh1xcmYAcMQJDNdJt5H//jPEqkRD3ncIlJwc6
 /5AElKB+W4WjM497CMWeYcyY36I2GeJHHeLf++V96K93ljru8jsWlVkTj7NajOFSa6d6Cddih47
 DWyU2C+M79ixCmGGFlw0VN5Y/z5yK9nT2gBG15cIe+VY05r6V5ZjHkEFSAvgKBPxfU29e6xZvTz
 uXE/losEmI5CaOAudcRyfYfR2DdSOiQDbuo8I3fbeS3chs+fJp8dFN8e7CcnXhCQlA==
X-Google-Smtp-Source: AGHT+IG9qIupilbrznjln/sH9wbHLvz7f9wdU6hQY37W+0GrsOiKaB2CMUVk+lbqW5dCwb3oqGaPuA==
X-Received: by 2002:a05:600c:4e01:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438dc34b179mr133719435e9.0.1738357694143; 
 Fri, 31 Jan 2025 13:08:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102ee0sm5681437f8f.37.2025.01.31.13.08.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:08:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 35/36] hw/sd: Remove unused legacy functions,
 stop killing mammoths
Date: Fri, 31 Jan 2025 22:05:18 +0100
Message-ID: <20250131210520.85874-36-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The sdcard_legacy.h header defines function prototypes for the "legacy"
SD card API, which was used by non-qdevified SD controller models.
We've now converted the only remaining non-qdev SD controller, so
we can drop the legacy API.

Entirely unused functions:
  sd_init(), sd_set_cb(), sd_enable()

Functions which now become static inside sd.c (they are the
underlying implementations of methods on SDCardClass):
  sd_do_command(), sd_write_byte(), sd_read_byte()

Removal of sd_init() means that we can also remove the
me_no_qdev_me_kill_mammoth_with_rocks flag, the codepaths that were
only reachable when it was set, and the inserted_cb and readonly_cb
qemu_irq lines that went with that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250128104519.3981448-11-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdcard_legacy.h | 50 -----------------------
 hw/sd/sd.c                    | 77 ++++-------------------------------
 2 files changed, 8 insertions(+), 119 deletions(-)
 delete mode 100644 include/hw/sd/sdcard_legacy.h

diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.h
deleted file mode 100644
index 0dc38895551..00000000000
--- a/include/hw/sd/sdcard_legacy.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * SD Memory Card emulation (deprecated legacy API)
- *
- * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS''
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- * PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
- * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-#ifndef HW_SDCARD_LEGACY_H
-#define HW_SDCARD_LEGACY_H
-
-#include "hw/sd/sd.h"
-
-/* Legacy functions to be used only by non-qdevified callers */
-SDState *sd_init(BlockBackend *blk, bool is_spi);
-int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
-void sd_write_byte(SDState *card, uint8_t value);
-uint8_t sd_read_byte(SDState *card);
-void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
-
-/* sd_enable should not be used -- it is only used on the nseries boards,
- * where it is part of a broken implementation of the MMC card slot switch
- * (there should be two card slots which are multiplexed to a single MMC
- * controller, but instead we model it with one card and controller and
- * disable the card when the second slot is selected, so it looks like the
- * second slot is always empty).
- */
-void sd_enable(SDState *card, bool enable);
-
-#endif /* HW_SDCARD_LEGACY_H */
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f781fd1641d..74bb7f39bbf 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -39,7 +39,6 @@
 #include "hw/registerfields.h"
 #include "system/block-backend.h"
 #include "hw/sd/sd.h"
-#include "hw/sd/sdcard_legacy.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
@@ -120,10 +119,6 @@ typedef struct SDProto {
 struct SDState {
     DeviceState parent_obj;
 
-    /* If true, created by sd_init() for a non-qdevified caller */
-    /* TODO purge them with fire */
-    bool me_no_qdev_me_kill_mammoth_with_rocks;
-
     /* SD Memory Card Registers */
     uint32_t ocr;
     uint8_t scr[8];
@@ -177,8 +172,6 @@ struct SDState {
     uint32_t data_offset;
     size_t data_size;
     uint8_t data[512];
-    qemu_irq readonly_cb;
-    qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
     bool enable;
     uint8_t dat_lines;
@@ -892,17 +885,10 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
         trace_sdcard_ejected();
     }
 
-    if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
-        qemu_set_irq(sd->inserted_cb, inserted);
-        if (inserted) {
-            qemu_set_irq(sd->readonly_cb, readonly);
-        }
-    } else {
-        sdbus = SD_BUS(qdev_get_parent_bus(dev));
-        sdbus_set_inserted(sdbus, inserted);
-        if (inserted) {
-            sdbus_set_readonly(sdbus, readonly);
-        }
+    sdbus = SD_BUS(qdev_get_parent_bus(dev));
+    sdbus_set_inserted(sdbus, inserted);
+    if (inserted) {
+        sdbus_set_readonly(sdbus, readonly);
     }
 }
 
@@ -1000,48 +986,6 @@ static const VMStateDescription sd_vmstate = {
     },
 };
 
-/* Legacy initialization function for use by non-qdevified callers */
-SDState *sd_init(BlockBackend *blk, bool is_spi)
-{
-    Object *obj;
-    DeviceState *dev;
-    SDState *sd;
-    Error *err = NULL;
-
-    obj = object_new(is_spi ? TYPE_SD_CARD_SPI : TYPE_SD_CARD);
-    dev = DEVICE(obj);
-    if (!qdev_prop_set_drive_err(dev, "drive", blk, &err)) {
-        error_reportf_err(err, "sd_init failed: ");
-        return NULL;
-    }
-
-    /*
-     * Realizing the device properly would put it into the QOM
-     * composition tree even though it is not plugged into an
-     * appropriate bus.  That's a no-no.  Hide the device from
-     * QOM/qdev, and call its qdev realize callback directly.
-     */
-    object_ref(obj);
-    object_unparent(obj);
-    sd_realize(dev, &err);
-    if (err) {
-        error_reportf_err(err, "sd_init failed: ");
-        return NULL;
-    }
-
-    sd = SD_CARD(dev);
-    sd->me_no_qdev_me_kill_mammoth_with_rocks = true;
-    return sd;
-}
-
-void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
-{
-    sd->readonly_cb = readonly;
-    sd->inserted_cb = insert;
-    qemu_set_irq(readonly, sd->blk ? !blk_is_writable(sd->blk) : 0);
-    qemu_set_irq(insert, sd->blk ? blk_is_inserted(sd->blk) : 0);
-}
-
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
@@ -2196,8 +2140,8 @@ static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
     return cmd_class == 0 || cmd_class == 7;
 }
 
-int sd_do_command(SDState *sd, SDRequest *req,
-                  uint8_t *response) {
+static int sd_do_command(SDState *sd, SDRequest *req,
+                         uint8_t *response) {
     int last_state;
     sd_rsp_type_t rtype;
     int rsplen;
@@ -2349,7 +2293,7 @@ static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
     return false;
 }
 
-void sd_write_byte(SDState *sd, uint8_t value)
+static void sd_write_byte(SDState *sd, uint8_t value)
 {
     int i;
 
@@ -2478,7 +2422,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
     }
 }
 
-uint8_t sd_read_byte(SDState *sd)
+static uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
     const uint8_t dummy_byte = 0x00;
@@ -2561,11 +2505,6 @@ static bool sd_data_ready(SDState *sd)
     return sd->state == sd_sendingdata_state;
 }
 
-void sd_enable(SDState *sd, bool enable)
-{
-    sd->enable = enable;
-}
-
 static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
-- 
2.47.1


