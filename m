Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4980C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwen-0004dx-KV; Mon, 04 Aug 2025 10:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivLD-0001Au-9Y
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:35:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivLA-0000DA-3D
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:35:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-458a84e2917so37079375e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754314499; x=1754919299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJW4OSIhB86Z3E7sE7FAciHI/FDvbdGcS4/yRYjL4Pw=;
 b=WgBGisQ2ujYiONe9MgWwfBz63jvd38kq1mINO/BJkV1mVkvX5+KcfBAczMHmiHg7Q9
 NuAIrDvCDVm51GkYXkHsf4NsSTFZZa6qKQOBas6LwAW7fnFfMBcMdD5GIkLTecXZbiT+
 /iz89xOIkTmFbsNku8lnLCAuxb9xhSmvyeW1AoryWXfJQHX3nU5cbpMbaqo5YhJmg+B2
 Ouc7jwcn4J3JvYufcJsFUuHtt4xadVQtU64fOuhmHdPKA2KT4RR96X79dcN2qVBXIIXy
 L3E3/dtbQs2FTuTgs7ZWOgAoMks2CUZ/jEOXRLLH8kchhQK+GXQWny4gnzK4Njs/V1Ow
 oztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314499; x=1754919299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJW4OSIhB86Z3E7sE7FAciHI/FDvbdGcS4/yRYjL4Pw=;
 b=aXJOAOBH9zoqS1YDozCaqfdeCQ2MwekT1Eynfgi8W4O8Yqnn5exG4MDgHqoWTo+YCn
 bRaOSHwWAFgil95gegvv1R3QoEEClmejSeZcwCd1wNIpVqjtMGUlKI0UfwV/n5gs+y3O
 P8yuHJpB+DFYmFgs2CbXEpvKDiELITAeEoo93a4RmlNWH16na46lpWL57L6uia4h7okV
 41ZC2GWebuRQosViE5eVMt9TrmREAPRkxc/X1ua49y7JVEW3u4jaMcHxnlzVbi53c0cP
 x9+7EH1CgYzXFJoB3Pod48Aaa2x1BUodYGFIFghvE57HxgXdZgoH5tP136DTXohwd73u
 E8oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi70IhrE8+MQh4ZtFhS5PEnXnOeovyGq8OiKJ5ttugzgg7nNeOM14hZe9uSJ7LBtGqqD+noe0jO8qO@nongnu.org
X-Gm-Message-State: AOJu0Yz8heiqb+nGnutUK2VEeLzBEybEU1tfZyz5Wc+qqNOIV6xsldV0
 aDzlgn00tPYtmaBu0MJStiCf5ScdFwpJei5PGVZFGkPGrCCq2H62oaA5DzGQ9mUD2dQ=
X-Gm-Gg: ASbGncu6feJqoaB7bArfzeKCrg0NOa5dXUDegFCQEN7K+d4THlptN7i7VS/d4YAsMcy
 EF0Sf+bmckKU5gbhRHIaO+HSkyto6meMcEr45hhxp6XoXPTwUbFWkYzAZzeHKJYVtnJlUGQSjgK
 KZTWbnwb05r1FWlfk3UmzH2G8LL3bkirC8AuEUKNcMBzKHc9IiO1CEATsBPz/rBS4/p9oGp6ZDJ
 meQhU8CdGuZSYk4HOwOhQjaPA9RB56DChBANzi975RPlS3nqsNxQCr4B8t1l8NdVmU37si4qoNy
 1pCIRCxMExpz2BRpvYozcjrD+qb+rbGFlwOr+PM9bju6i5xAuTaK6gSfmRkVPcHZHl6GS3xrRWZ
 EU8qUbclZigVs2M0ypB2eo2e82OTcMJcADZkdEUgzZqaVhrNwIVnmcS27oPl1GZkZfyLcyp3S
X-Google-Smtp-Source: AGHT+IHKJUBmR307X/q9ya205/rCJmw7SH8sTjBp6J99IXlayrKpnRflC5pX8VPm6dw5CzpSprPYhA==
X-Received: by 2002:a05:600c:5248:b0:459:d4b5:623a with SMTP id
 5b1f17b1804b1-459d4b56388mr42037755e9.9.1754314498528; 
 Mon, 04 Aug 2025 06:34:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458af917d20sm78852095e9.2.2025.08.04.06.34.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Aug 2025 06:34:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-10.1 v2 10/11] hw/sd/sdcard: Remove SDState::mode field
Date: Mon,  4 Aug 2025 15:34:04 +0200
Message-ID: <20250804133406.17456-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804133406.17456-1-philmd@linaro.org>
References: <20250804133406.17456-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

SD card mode is a superset of its state (SDState::state),
no need to migrate it.

Use sd_mode() to get the SDCardModes from the SDCardStates.

Fixes: 50a5be6c3d5 ("hw/sd.c: add SD card save/load support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


