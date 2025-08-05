Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A766C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLWe-0000MH-3E; Tue, 05 Aug 2025 13:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWY-0000CY-Lv
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWW-0004zS-Gs
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-458b2d9dba5so25589225e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415146; x=1755019946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCsykQ2VuZzMPof/8vWp/dCBSb3JyYkVdmGb1zUy7Oc=;
 b=xMQoH1BqqnFhXR24DZlakoeEJ+/ebDf7CtQkrG/YOKR2AIMtujirsJCSW3pFE8h+hG
 /caE0B3pXp9ZwSWX9ydSiGVXXgzfUS0mt/nrSeD5v+eZ9ho3+zDRlxkkRpgHUXdeL/Oo
 krhiR/oENKlAgqJkA6BrBZrSkK+LNOBSLergamlF/0ixrb6XzQAX0/Kh46szqlRQUYVI
 /Jp0dui+GXogaB18zngT7Op6FbsQSe/kqGnQT5i1lQ7mJQXnWXu/67OjjY+oBv+GIg+e
 K5R6kxPGrVLx/NwJNlpJXRfv2WWUPMW1fzQTZQUdSKqRO9x62iSRqcHNeH3zWW1jHoR/
 384Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415146; x=1755019946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCsykQ2VuZzMPof/8vWp/dCBSb3JyYkVdmGb1zUy7Oc=;
 b=nELkbudJ/XY87fmjvFjauPMDaUZ3DTISLqHvcjGirbNdNBAjmvwsApB/7QPhxDod7r
 TdB7UnwLntm3Me0z4YcLrACXrbMmle1wfuZtR6hlv8eAvBOtFNqaUQek7txDnUXG+Meb
 vYV57zp5l9PLM3J/Tz4or/QBSr3fhAieJTgPsI4XuMsNN+GrEXUGp2IR78BRjXcDv2gc
 25ID5xrfvbrv3CTYZRJlfMk3F1CfibpaH6bJI63lbSqvUUZbah0zlxkUyfVWpz42ujch
 oPb4VGMBHyz1EwMqAl0M/rflCmvtIj0y1CHRNGOWRhNxlQwvWpK+1PgGsHFUy+iaIQFX
 Aksg==
X-Gm-Message-State: AOJu0Yzfttr3CvrRtgSHedDRz71S6eVLSdvUOD6d3OB14z1BvNJhU5g/
 3EMLCFTVh81lOsq+ShKiE2cQg9AeKsdVaMQ3FS3WJIgEDsJdV9T7aVAqGo3mJ6nCbX+bMsNWVJb
 4itiT
X-Gm-Gg: ASbGnctuWrq1EgXZWpV95sawisWthqFQ4F43/tg2exBif5c8khhkpHssdBzNq0LLkyy
 /pi4zwCSWS/mMlWCuhbFrFRt2ckymDgw2IfX83Mpy9EuPCEgWDLZWX5NEmLteMiU9A5gjVFL2/F
 nK3sEkCkneuzOmKPoWUCLX9TMS55VjW5Sp0oDg0JscYwu0CNdMnFhT2kEci757BE4NpKnB41hVX
 X3wYlsRyNedhUl5MMfzeupU+d8AdRJp0txds9xHlfTV7Pk1H4+yMXvSMcby7Y6FMwUsnHowNiaI
 gqOLQAS3FxoDKG2RaDUUbqPKWrPerNY3yr0YJ81ACk2T31AerSldsXN6DnAS6zVTXKE+ktJS6Ut
 7lAX2AWSs1l4QG0njNPbgIqG9rjFcI13xvvEeZUyjwT6Xh6clAstueiOqe+tbAL2q1W0MYEFNgV
 8+RdYurZE=
X-Google-Smtp-Source: AGHT+IHjFF0zMk+d1nq9vXjKddf/Mz6oEZ0HpI3zaVM4rogSYQAD52IVAouF6gCkzCm0yhW8nhr9uQ==
X-Received: by 2002:a05:600c:3224:b0:442:e9eb:1b48 with SMTP id
 5b1f17b1804b1-458b716c2d0mr67636975e9.24.1754415146289; 
 Tue, 05 Aug 2025 10:32:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e58553f8sm13491375e9.14.2025.08.05.10.32.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:32:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 10/13] hw/sd/sdcard: Remove SDState::mode field
Date: Tue,  5 Aug 2025 19:31:31 +0200
Message-ID: <20250805173135.38045-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

SD card mode is a superset of its state (SDState::state),
no need to migrate it.

Use sd_mode() to get the SDCardModes from the SDCardStates.

Fixes: 50a5be6c3d5 ("hw/sd.c: add SD card save/load support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250804133406.17456-11-philmd@linaro.org>
---
 hw/sd/sd.c         | 35 +++++++++++++++++------------------
 hw/sd/trace-events |  4 ++--
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 22f30997713..8c290595f01 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -147,7 +147,6 @@ struct SDState {
 
     /* Runtime changeables */
 
-    uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
     uint32_t vhs;
     bool wp_switch;
@@ -315,27 +314,24 @@ static void sd_set_voltage(SDState *sd, uint16_t millivolts)
     }
 }
 
-static void sd_set_mode(SDState *sd)
+static enum SDCardModes sd_mode(SDState *sd)
 {
     switch (sd->state) {
     case sd_inactive_state:
-        sd->mode = sd_inactive;
-        break;
-
+        return sd_inactive;
     case sd_idle_state:
     case sd_ready_state:
     case sd_identification_state:
-        sd->mode = sd_card_identification_mode;
-        break;
-
+        return sd_card_identification_mode;
     case sd_standby_state:
     case sd_transfer_state:
     case sd_sendingdata_state:
     case sd_receivingdata_state:
     case sd_programming_state:
     case sd_disconnect_state:
-        sd->mode = sd_data_transfer_mode;
-        break;
+        return sd_data_transfer_mode;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -1025,7 +1021,7 @@ static const VMStateDescription sd_vmstate = {
     .minimum_version_id = 2,
     .pre_load = sd_vmstate_pre_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(mode, SDState),
+        VMSTATE_UNUSED(4),
         VMSTATE_INT32(state, SDState),
         VMSTATE_UINT8_ARRAY(cid, SDState, 16),
         VMSTATE_UINT8_ARRAY(csd, SDState, 16),
@@ -1325,7 +1321,7 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
-                  sd->proto->name, req.cmd, sd_mode_name(sd->mode),
+                  sd->proto->name, req.cmd, sd_mode_name(sd_mode(sd)),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1485,7 +1481,7 @@ static sd_rsp_type_t emmc_cmd_sleep_awake(SDState *sd, SDRequest req)
 /* CMD6 */
 static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
 {
-    if (sd->mode != sd_data_transfer_mode) {
+    if (sd_mode(sd) != sd_data_transfer_mode) {
         return sd_invalid_mode_for_cmd(sd, req);
     }
     if (sd_is_spi(sd)) {
@@ -1658,7 +1654,7 @@ static sd_rsp_type_t sd_cmd_STOP_TRANSMISSION(SDState *sd, SDRequest req)
 /* CMD13 */
 static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
 {
-    if (sd->mode != sd_data_transfer_mode) {
+    if (sd_mode(sd) != sd_data_transfer_mode) {
         return sd_invalid_mode_for_cmd(sd, req);
     }
 
@@ -1684,7 +1680,7 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
 /* CMD15 */
 static sd_rsp_type_t sd_cmd_GO_INACTIVE_STATE(SDState *sd, SDRequest req)
 {
-    if (sd->mode != sd_data_transfer_mode) {
+    if (sd_mode(sd) != sd_data_transfer_mode) {
         return sd_invalid_mode_for_cmd(sd, req);
     }
     switch (sd->state) {
@@ -2090,7 +2086,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     if (req.cmd != 55 || sd->expecting_acmd) {
         trace_sdcard_normal_command(sd->proto->name,
                                     sd->last_cmd_name, req.cmd,
-                                    req.arg, sd_state_name(sd->state));
+                                    req.arg,
+                                    sd_mode_name(sd_mode(sd)),
+                                    sd_state_name(sd->state));
     }
 
     /* Not interpreting this as an app command */
@@ -2176,7 +2174,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
 {
     sd->last_cmd_name = sd_acmd_name(sd, req.cmd);
     trace_sdcard_app_command(sd->proto->name, sd->last_cmd_name,
-                             req.cmd, req.arg, sd_state_name(sd->state));
+                             req.cmd, req.arg,
+                             sd_mode_name(sd_mode(sd)),
+                             sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
     if (sd->proto->acmd[req.cmd].handler) {
@@ -2276,7 +2276,6 @@ static size_t sd_do_command(SDState *sd, SDRequest *req,
     }
 
     last_state = sd->state;
-    sd_set_mode(sd);
 
     if (sd->expecting_acmd) {
         sd->expecting_acmd = false;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index db0644256d9..8d49840917e 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -37,8 +37,8 @@ sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of
 sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
 
 # sd.c
-sdcard_normal_command(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t arg, const char *state) "%s %20s/ CMD%02d arg 0x%08x (state %s)"
-sdcard_app_command(const char *proto, const char *acmd_desc, uint8_t acmd, uint32_t arg, const char *state) "%s %23s/ACMD%02d arg 0x%08x (state %s)"
+sdcard_normal_command(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t arg, const char *mode, const char *state) "%s %20s/ CMD%02d arg 0x%08x (mode %s, state %s)"
+sdcard_app_command(const char *proto, const char *acmd_desc, uint8_t acmd, uint32_t arg, const char *mode, const char *state) "%s %23s/ACMD%02d arg 0x%08x (mode %s, state %s)"
 sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
 sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
-- 
2.49.0


