Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41F0C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZnK-0003yx-Fn; Tue, 02 Jul 2024 05:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZnH-0003xX-Lp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:24 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZnB-0001dk-Re
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:22 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ce6c8db7bso5944624e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912436; x=1720517236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKLmaY+ITMzDV6voXczq+aWnHEY0UJpGnuJKCBTpGi4=;
 b=IYmr69RpYj5bWzrFg7bj+sneEJYkSHz2PcPccAcVZGLVOGRcyMZvNlP9nYI4hTtNAd
 hant+LvxeYEzX9qEYun/BTchsfcOdIMkcoBp+xI1oL8+CS2ETr94HzGfHCREMqiNoMlb
 vm4AkuOi8IjSIDkE6SaNgClsO+mlBb8pa47VsZ/NJ1uTX2RB3lANciIZifa7qx3SjF6W
 zhFuic1DhVRmdAwPgxmbT1ZEzxz7C3LdFzjwGHPNrSxZ9xueK9qTbNtcNSZu0HwGa5Gm
 iLJ5E2+s5bP3JDfuCkj6mL7wdccCfGpOU4O4yEqdikSqSX5fJP95JWe28a0A0fV2a1Sv
 H7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912436; x=1720517236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKLmaY+ITMzDV6voXczq+aWnHEY0UJpGnuJKCBTpGi4=;
 b=R3cBaAwKMMNImi87X8N43wjoPC4344ysL0NFuT8kjVCBDr/318QYzWVwlmjUflU2bh
 0jhDnjQqESD3VNwg7h5GYskHzn0sY9ugeb5B2nxf0qsTEHESs05aBmiytnmRW7XIlD0U
 0X98fyeNtDOkGCp8VQIjFc3fNX1vCzOx9O79Z0uPM8K1QBW5oI2CHqUXIM+eF0aL5zU2
 vTah4Bh1ObMrytG61khbzRRpJAM5oo+AU02fj+EvgI+6g4BtndXwTcJlZjFnS0nr5YUT
 st6o5LqsHeyuAnSSQzkRUVHIGEDtAbDGm+ph3ICP5Q2OGB9VmQ5QONn+aC3txnqE1CQl
 6WIw==
X-Gm-Message-State: AOJu0YwayrY0pW86as3U8ppaqxx+g8aLpQeNQ/Y/VkH0LRTh0F3utKXH
 7NkOOTSbcbx7l909ygxvAAnotxPE0jOq8Tg1RCXNs93g2sYBKYOuXVRnLWvPJbYS5GZO6fc2mey
 U
X-Google-Smtp-Source: AGHT+IH3kMT2O5M51MLz3PZLAULw6Lx4xthbIJ64f2gGfGLBc8vKJc+okJg0iAQtuWI1V9ZHAreJ9g==
X-Received: by 2002:a05:6512:12d1:b0:52c:e11e:d493 with SMTP id
 2adb3069b0e04-52e8267b901mr5492188e87.26.1719912435873; 
 Tue, 02 Jul 2024 02:27:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c1018sm188560715e9.40.2024.07.02.02.27.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:27:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 65/67] hw/sd/sdcard: Add sd_acmd_SD_APP_OP_COND handler (ACMD41)
Date: Tue,  2 Jul 2024 11:20:48 +0200
Message-ID: <20240702092051.45754-66-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-73-philmd@linaro.org>
---
 hw/sd/sd.c | 82 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c56790f091..207deb07e6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1685,6 +1685,50 @@ static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD41 */
+static sd_rsp_type_t sd_acmd_SD_APP_OP_COND(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_idle_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    /*
+     * If it's the first ACMD41 since reset, we need to decide
+     * whether to power up. If this is not an enquiry ACMD41,
+     * we immediately report power on and proceed below to the
+     * ready state, but if it is, we set a timer to model a
+     * delay for power up. This works around a bug in EDK2
+     * UEFI, which sends an initial enquiry ACMD41, but
+     * assumes that the card is in ready state as soon as it
+     * sees the power up bit set.
+     */
+    if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
+        if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
+            timer_del(sd->ocr_power_timer);
+            sd_ocr_powerup(sd);
+        } else {
+            trace_sdcard_inquiry_cmd41();
+            if (!timer_pending(sd->ocr_power_timer)) {
+                timer_mod_ns(sd->ocr_power_timer,
+                             (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+                              + OCR_POWER_DELAY_NS));
+            }
+        }
+    }
+
+    if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
+        /*
+         * We accept any voltage.  10000 V is nothing.
+         *
+         * Once we're powered up, we advance straight to ready state
+         * unless it's an enquiry ACMD41 (bits 23:0 == 0).
+         */
+        sd->state = sd_ready_state;
+    }
+
+    return sd_r3;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1809,43 +1853,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 41:  /* ACMD41: SD_APP_OP_COND */
-        if (sd->state != sd_idle_state) {
-            break;
-        }
-        /* If it's the first ACMD41 since reset, we need to decide
-         * whether to power up. If this is not an enquiry ACMD41,
-         * we immediately report power on and proceed below to the
-         * ready state, but if it is, we set a timer to model a
-         * delay for power up. This works around a bug in EDK2
-         * UEFI, which sends an initial enquiry ACMD41, but
-         * assumes that the card is in ready state as soon as it
-         * sees the power up bit set. */
-        if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
-            if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
-                timer_del(sd->ocr_power_timer);
-                sd_ocr_powerup(sd);
-            } else {
-                trace_sdcard_inquiry_cmd41();
-                if (!timer_pending(sd->ocr_power_timer)) {
-                    timer_mod_ns(sd->ocr_power_timer,
-                                 (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
-                                  + OCR_POWER_DELAY_NS));
-                }
-            }
-        }
-
-        if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
-            /* We accept any voltage.  10000 V is nothing.
-             *
-             * Once we're powered up, we advance straight to ready state
-             * unless it's an enquiry ACMD41 (bits 23:0 == 0).
-             */
-            sd->state = sd_ready_state;
-        }
-
-        return sd_r3;
-
     case 42:  /* ACMD42: SET_CLR_CARD_DETECT */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2384,6 +2391,7 @@ static const SDProto sd_proto_sd = {
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
+        [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
     },
 };
 
-- 
2.41.0


