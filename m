Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDDEC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jr-000707-Mh; Fri, 28 Jun 2024 03:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jg-0006gJ-UE
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jf-0004W5-7a
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-36743abace4so850647f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558568; x=1720163368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bYEYJ2Wwx71dNKsAcy31SFsnrP/uSxrEAbuXlnudJVY=;
 b=b6fK9nKJAQuVa+5JRMI1sbIDNE0oZhKdSvfg/Xoz5CYCE00lKzV3UdAuR1bYppHhEa
 LX3aUVYLGuCca4tW3zqm4dlcqFR2QCKe4N0MJNHn5hhvjmnHg3C70hmM9yvULpbS3gQb
 NeBgelRDroMS3+7ZF65jgiQmw2sFKSc494SBKkrfZl8NxnXxZQt8PhCyp+3Y1JvF+uzE
 ZeCkET7qiVbH6rJ5owrYpNnLUIlf6ZJsGUOXA3RQ96Pn16PHPkZjJ6hetbPuPfiiHyLl
 WM2s1yFRaQucpoPyltiLRixDH06WgGcxbx+7SY+dsCtgnhIGSn3Bk/4k37mytuj98Ywh
 yY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558568; x=1720163368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYEYJ2Wwx71dNKsAcy31SFsnrP/uSxrEAbuXlnudJVY=;
 b=THKkoFtT4htcpkWSTG/tNLxwjnXZUid/oFjnxvHbeYRh3pHHqb+puIA2qL9UWj1ivt
 6vhkMokz+8Czc4akEZnHjZ+oVPCFLM3n49GaYnplwtfxFVL8QXp5Yox/BlZU3sacxHMd
 11RIuT8/8nljJS+66LOECAgH16+/DIrc0poAov0D4/LJEBGsFZQ8NJlRjNBNsBx0eun1
 YCni50UEBbTcDyo9mwe7iOOh6pEb2vfN+qRHh5rqDJNvpgFhr/yDbpPIFRC8AEsSGQPQ
 93gHVd14buORNe73T0Uz1Xw0MOtKJOi4jwhTF3i3a9/C4leiPhy1CfP0FXvQDpd632/z
 VhDA==
X-Gm-Message-State: AOJu0Yx7ak8qd69Zra0cGaBNa1NpgAHHtvyvv6ygDIYF9yhPwx+ZlmHW
 Zo2vhzufKRu7XfEae6kh3U0LRVtzDEodpwO+bofQ7iZvxSGKThgYpLgQUV4o9vx+EMn1RJauBD5
 7EGk=
X-Google-Smtp-Source: AGHT+IHcrWdP63Uw2K18kAzfw69VYhR2sZrOsMAQHi+ibEUcaAUxf7vEHNrzutMhVXBgS/2qtUaPRw==
X-Received: by 2002:a5d:64ea:0:b0:366:ea4a:17ec with SMTP id
 ffacd0b85a97d-3676096eb0emr802635f8f.2.1719558568647; 
 Fri, 28 Jun 2024 00:09:28 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c19eesm21379325e9.45.2024.06.28.00.09.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 72/98] hw/sd/sdcard: Add sd_acmd_SD_APP_OP_COND handler
 (ACMD41)
Date: Fri, 28 Jun 2024 09:01:48 +0200
Message-ID: <20240628070216.92609-73-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 82 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cd207a3090..167e1c517a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1704,6 +1704,50 @@ static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
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
@@ -1812,43 +1856,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
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
@@ -2379,6 +2386,7 @@ static const SDProto sd_proto_sd = {
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
+        [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
     },
 };
 
-- 
2.41.0


