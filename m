Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80851CD37AC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZlx-0001Un-5c; Tue, 03 Sep 2024 16:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slZlv-0001Ot-KO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:05:03 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slZlt-0003Pa-5Y
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:05:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42bbdf7f860so39314065e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725393898; x=1725998698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAxEM68rZRReOy0Hx27Eldyt4CC8Kb4K0r03wDQB1D4=;
 b=T1+t2bKdpyqGtiEiM/Yz6HNXQ4jmykdUsxAUKGu+0ZrxAknQ2+9gBmGs+rRAwXyHDQ
 CYQ4t15IgPtwdb4aNDttYjDaB5j3aTTddOl79Ff8esBUYn8vnTwrj4P6G7CO9TkbDfBW
 gMERf+ydgrtnqhnYCEiNeFb8ndtBWFbkODyi/TAfbB2qjo85EzWEG1wfXMJfvwckg1S5
 YieqHM+7YFZLVxPyaNZTl7FvaYcOxHyLvHPtOHdWsIW+3HcsUfPmcyCIMw4nciAq4jU8
 Ruu4PO6vIhnG/BYZR8i+1sCpTJAgYNglJMCBTyN/wSWSjQuDtZXI7OmChBtUgFwAoaoa
 081Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725393898; x=1725998698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAxEM68rZRReOy0Hx27Eldyt4CC8Kb4K0r03wDQB1D4=;
 b=hlcwE4KPhMVk30MXzqZzCpJd0s757bza1jOVoSa7R4WxqZsjXpe154ykh8eeNgrinh
 gj7mJBKkdWf1myGfJjUiPrImUJAemtok/+wsk/LQyMg2IvQOCYVubd93ibcsq3TEUtQ9
 TmuLD2wZFeBKoCd72RM6nxkQoUuX5YwMBsvt6qUSSbOZ1MWQ6oCPpCaB+ypZ41bMq0WR
 WE6lStFJ0ng4o6pGkY5/o2/nDgZtzU7HtbY0TW9Jh46kogEOQrs46U6HNUl9whkV6Twe
 kY1s8Tmtz46/e5wrW/syRFfPCgVZnNB1kTX7WoNg3DTH8H0a0b0griB281m6WOLkLkA6
 3sjw==
X-Gm-Message-State: AOJu0YwfAAIpt4ceLuOgjoN4yQVmiFXaVWIurHgQRUR9kS3LfVkCIXoB
 LsHpImh+yj1qt3sx6YZVeUFeC/vaHzNlqHIeGCGQHAxb31XlVAgXlGt0Tc8VH5sPghWVzTnFFa0
 f
X-Google-Smtp-Source: AGHT+IHPH3vMf1GwR5SZ1/kYdugc/s4ilrGaNvDiff8BRWwF1YOAocvc725Dcbf4La8REuZ1fhgo6g==
X-Received: by 2002:a5d:6d08:0:b0:374:cd1b:e10d with SMTP id
 ffacd0b85a97d-374cd1be31bmr4002534f8f.61.1725393898312; 
 Tue, 03 Sep 2024 13:04:58 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c8e4f1b3sm7407458f8f.27.2024.09.03.13.04.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 13:04:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 2/2] hw/sd: Remove legacy sd_enable()
Date: Tue,  3 Sep 2024 22:04:46 +0200
Message-ID: <20240903200446.25921-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903200446.25921-1-philmd@linaro.org>
References: <20240903200446.25921-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

sd_enable() was only used by omap_mmc_enable() which
got recently removed. Time to remove it.

Since the SDState::enable boolean is now always %true,
we can remove it and simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h            |  1 -
 include/hw/sd/sdcard_legacy.h |  9 ---------
 hw/sd/sd.c                    | 20 ++++++--------------
 3 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index d35a839f5e..aa0f229747 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -127,7 +127,6 @@ struct SDCardClass {
     void (*set_voltage)(SDState *sd, uint16_t millivolts);
     uint8_t (*get_dat_lines)(SDState *sd);
     bool (*get_cmd_line)(SDState *sd);
-    void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
     void (*set_cid)(SDState *sd);
diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.h
index a121232560..82b62e87d1 100644
--- a/include/hw/sd/sdcard_legacy.h
+++ b/include/hw/sd/sdcard_legacy.h
@@ -37,13 +37,4 @@ int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
 void sd_write_byte(SDState *card, uint8_t value);
 uint8_t sd_read_byte(SDState *card);
 
-/* sd_enable should not be used -- it is only used on the nseries boards,
- * where it is part of a broken implementation of the MMC card slot switch
- * (there should be two card slots which are multiplexed to a single MMC
- * controller, but instead we model it with one card and controller and
- * disable the card when the second slot is selected, so it looks like the
- * second slot is always empty).
- */
-void sd_enable(SDState *card, bool enable);
-
 #endif /* HW_SDCARD_LEGACY_H */
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8a30c61ce0..0c681da432 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -166,7 +166,6 @@ struct SDState {
     size_t data_size;
     uint8_t data[512];
     QEMUTimer *ocr_power_timer;
-    bool enable;
     uint8_t dat_lines;
     bool cmd_line;
 };
@@ -285,12 +284,12 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 
 static uint8_t sd_get_dat_lines(SDState *sd)
 {
-    return sd->enable ? sd->dat_lines : 0;
+    return sd->dat_lines;
 }
 
 static bool sd_get_cmd_line(SDState *sd)
 {
-    return sd->enable ? sd->cmd_line : false;
+    return sd->cmd_line;
 }
 
 static void sd_set_voltage(SDState *sd, uint16_t millivolts)
@@ -974,7 +973,7 @@ static const VMStateDescription sd_vmstate = {
         VMSTATE_UINT32(data_offset, SDState),
         VMSTATE_UINT8_ARRAY(data, SDState, 512),
         VMSTATE_UNUSED_V(1, 512),
-        VMSTATE_BOOL(enable, SDState),
+        VMSTATE_UNUSED(sizeof(bool)),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -2177,7 +2176,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
     sd_rsp_type_t rtype;
     int rsplen;
 
-    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable) {
+    if (!sd->blk || !blk_is_inserted(sd->blk)) {
         return 0;
     }
 
@@ -2328,7 +2327,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
 {
     int i;
 
-    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
+    if (!sd->blk || !blk_is_inserted(sd->blk))
         return;
 
     if (sd->state != sd_receivingdata_state) {
@@ -2460,7 +2459,7 @@ uint8_t sd_read_byte(SDState *sd)
     uint8_t ret;
     uint32_t io_len;
 
-    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
+    if (!sd->blk || !blk_is_inserted(sd->blk))
         return dummy_byte;
 
     if (sd->state != sd_sendingdata_state) {
@@ -2536,11 +2535,6 @@ static bool sd_data_ready(SDState *sd)
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
@@ -2700,7 +2694,6 @@ static void sd_instance_init(Object *obj)
 
     sd->proto = sc->proto;
     sd->last_cmd_name = "UNSET";
-    sd->enable = true;
     sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
 }
 
@@ -2809,7 +2802,6 @@ static void sdmmc_common_class_init(ObjectClass *klass, void *data)
     sc->read_byte = sd_read_byte;
     sc->receive_ready = sd_receive_ready;
     sc->data_ready = sd_data_ready;
-    sc->enable = sd_enable;
     sc->get_inserted = sd_get_inserted;
     sc->get_readonly = sd_get_readonly;
 }
-- 
2.45.2


