Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E7CC02191
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcj6m-0001QU-4B; Tue, 28 Jan 2025 05:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj6A-0001Aa-Cf
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj66-0003aR-CK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:38 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436249df846so36373915e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061133; x=1738665933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXVaYgjVnVDD5iua1WW8j0IeQfgPY/QrMi/c0hN7fA0=;
 b=bAOFDtA4g+rPXcWYs7HuUTOMMwlvF+ybNE8I/eRwQXdx9XevaHS+tElu7lhUIKOv+O
 fCL3Ppfwrnxzp/ftsP+enVX+1l7WQtGNqeMs/+4+yunPA9aUXOQSShHUi0EWrHt5T4QP
 rnh+YDDCOKzBq8qvXDEemMQl/S7Lq0aviGJkJgZVrveivxv/jzXHHZFUAliFCJhgTn9X
 ZwKik8SdJT2xzXE7qkxI7uurZ5VdYCzD6a1OOXRXBL8G+/Yjsph60VHC8Xuyw3iGSHDL
 7i7+G9udeWc0IIAnamAXdenFzf7f+MvS3Xm58arBApYSSyruUAQrHIKEPJRSw4ocDNYQ
 rXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061133; x=1738665933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXVaYgjVnVDD5iua1WW8j0IeQfgPY/QrMi/c0hN7fA0=;
 b=cn7TqgSkqpYEuTNgUujVqyeg/DVe0RaHkXKT0XXux1bMtk22XawxlmNoGxim10ublR
 lVh2xLzHwCx97hgV2WXKd+BjpwnjLXHiruelFiLC7xKWQ8e0QObH7lbiHzGUxY4kchwm
 OEfmzC6Yu3H2IqaSU7V2rSDd1KvGp5FY0Hq4zzhuBH/Ekv4XNX/uVE2eCjbmCmBYCZpA
 ftzt9Fh8Qu2Al03UxpTA+9ZZZDt5GPvjdNSL878AhYL22Pjs7zIc2HSbF9huSdznL9Cd
 rb5fb/BxWbkq1iGYrC0Ern0PSgAcVklus+ztu9R7g/pzxChucWyy//LSE1AUsXsHajN0
 xNgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHNgXFMAQHYi1ngKh5fXeJh1IFDbDlDNybCRfgz4JZkZ0IQkHVQ5KxPSJ3Bgih4mMn3+LoHd0QFsjQ@nongnu.org
X-Gm-Message-State: AOJu0Ywt9Guh08S5OLZvSmMn5Qik6pDkkBO3CP+tMjaBD1kwPw/SqWiy
 Mcf1AUS8K4Q36dN1iP0avOEvjoKnAA+kMbUIojIYiDixjruIJS3ZD8JUdck1Qz4=
X-Gm-Gg: ASbGncupN8nCX0GnZHQKp0v3wdDhV80+0dulq2WHYgfKelxaqMTFpIBvNWjNn7uiNWm
 kZtGYKGwJR41GW2/e5gQZL1nTdN+6iPBTEfqSQjiN7FB4nSg3tnDsS4aWYV3j1FL8Vx+cpCvXCH
 wNsAxr22M7Ko+NH40i1t1mG1u4wnQAbli/UJPjib+P4R9oLY18y++4fAFC2PcxE3LSf7IJVfbO8
 wxly3omojj6FxwNZ8bgEGc8DVA3S/PKPrLDfba4yhamNI1EvrZruzRBeJRWP12yh1jrsG3FYmrE
 Hot8INZuV9De9qT7XDulL8PEfJZRRas=
X-Google-Smtp-Source: AGHT+IHdfdmcessB+hZG8W9W3RnvmRXTWvd0tabLhAzYELYnjqeYjVtbaB05wL7wh9Gg1ZzMVAyaGg==
X-Received: by 2002:a5d:648a:0:b0:38b:f44b:8663 with SMTP id
 ffacd0b85a97d-38bf57c0ac9mr37236217f8f.55.1738061132720; 
 Tue, 28 Jan 2025 02:45:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c418esm13920133f8f.95.2025.01.28.02.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:45:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 10/11] hw/sd: Remove unused legacy functions,
 stop killing mammoths
Date: Tue, 28 Jan 2025 10:45:18 +0000
Message-Id: <20250128104519.3981448-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128104519.3981448-1-peter.maydell@linaro.org>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 include/hw/sd/sdcard_legacy.h | 50 -----------------------
 hw/sd/omap_mmc.c              |  2 +-
 hw/sd/sd.c                    | 77 ++++-------------------------------
 3 files changed, 9 insertions(+), 120 deletions(-)
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
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index c1598135f44..d31456ad236 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -25,7 +25,7 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/arm/omap.h"
-#include "hw/sd/sdcard_legacy.h"
+#include "hw/sd/sd.h"
 
 typedef struct OMAPMMCState {
     SysBusDevice parent_obj;
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
2.34.1


