Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC7CC87FD3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb9c-00029T-Ee; Thu, 31 Jul 2025 17:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapp-0002Nq-8B
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:29:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapn-00080x-8n
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:29:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b78127c5d1so700490f8f.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997345; x=1754602145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkfojtDXr6zwonVIseoNjUuQeq8ucsw9ORq6akfX5/M=;
 b=OWg/+3+0R1P8mFX5Zf2GngkiPgG6h5086aj8l9mmvkaDo1ICccDswyTpbOeVxVF49L
 7q6VEiRozLk6hTYKeVU8hW+WBW7PcUw45kywgDaetyUCoP3ykkr5rbuQmlZlQx0koCpi
 Kw9AplVdiIH0x3NoEWsCr9e0meOwQtBG5rIEfqXnxtLDm+8UWflT83mt2FbnArTR1xSF
 lDHKAN1cSxNd0pzovMHmJu1ZnDRqhVzw3FcHXIYVA67vv+M4aVt+tw7A2DsEDkdN6KjL
 HPkywPwqObGTecwpcNyND6GFmCOWSGf+xZGNjh3n39905tOebvpiwKMh5On0KPPl7sIR
 eRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997345; x=1754602145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkfojtDXr6zwonVIseoNjUuQeq8ucsw9ORq6akfX5/M=;
 b=TT6lSz5RcQ1jcjCpP/rpLhtWIbo3Oqr9qZgTXUMgJvGGZq8/Me+0u4nAivEYxmJsQ1
 46WH6bK1WZK2WDXjBEuvw4NRTjIvbMooznEZYHoIXEdbe3LJkdIN1XC5iOF1m2C6IuJa
 cguOJ21H3dJ/v0AxY5ECVqRAjTDmlBW6VqrtH7wJ1l2bUuycjTVbBtl1qeEqF4iufJH3
 ofzCEOL7jMmrgwKe51T+F6uTtHGR0XQi1fz1oxtD42wMT2KxclZj++BvCg8ggJ8+FhcT
 kC3EDVHEzmNrLO2rpoXe7SiE0+qfGTN+E++hAEQDhvshLfq/nut47+r/vYz14CHVGdYK
 FnFw==
X-Gm-Message-State: AOJu0YydRU7fSEk9QuScODglNYMoAF8pTVsIlnpV4lfvppBdbhJUk864
 Rk3J5gckEvjSwq3AhZslEpnllgNbaRHWBUNebZ/l9kdY1BcJhzI+OLW/EnOGtk/YUbhSTRFbN+R
 PkKrg
X-Gm-Gg: ASbGncua3pBbSNzPVCtUJZ+4G+CTmzJxyajfUGc2VAUyEmcbkY8LZuxfa2QGSRfIagp
 Zm1rkt0tTzRb5aIv+UA4IR1WPBk8iUxw27JYY3YmFIwqdztjWRlUVhGbOEnyy4jMY3tIcP4KDnS
 VsaNxDMGzW0nwqGQK/uprsv5eZw8gjYFVNlzQ0QKJPwaZXBCz+h1JZDXGFWlVDzOrqBiAkfuvzm
 HRMJ4n168Nc4v/pYnc5yYCnvPWZ5HODkQW3WKJI/U0dpflJX3ysNW30HUsv1Vp1ZunfKX5F01MN
 IWZu2rUdnib6aNHhXvXmbZNxF3GXgFllbSj67HB/U7E9X26GYZr32VTUQE/Km5MXCngEZRwsGiO
 SNp8x/z9j0mcbbowMRcIm/YRYzFHW4ywgohcbZcYRETaf/vcxz5YF0RCKhmoXnG1qvwujvpnM
X-Google-Smtp-Source: AGHT+IFTg5TVHjqICL1gUuWHychv/Y2cIfzg20vD3ayHi+07K+yPwnhHsov8RNS0EkC7qS1XHW3N6A==
X-Received: by 2002:a5d:649a:0:b0:3b8:d3b4:2c4a with SMTP id
 ffacd0b85a97d-3b8d3b42e23mr51514f8f.17.1753997345292; 
 Thu, 31 Jul 2025 14:29:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c51e2sm3482337f8f.32.2025.07.31.14.29.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Jul 2025 14:29:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Weiwei Li <liwei1518@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 10/11] hw/sd/sdcard: Remove SDState::mode field
Date: Thu, 31 Jul 2025 23:28:05 +0200
Message-ID: <20250731212807.2706-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250731212807.2706-1-philmd@linaro.org>
References: <20250731212807.2706-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
---
 hw/sd/sd.c         | 35 +++++++++++++++++------------------
 hw/sd/trace-events |  4 ++--
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 79395f7c5bb..42bf286b64a 100644
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
 
@@ -1013,7 +1009,7 @@ static const VMStateDescription sd_vmstate = {
     .minimum_version_id = 2,
     .pre_load = sd_vmstate_pre_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(mode, SDState),
+        VMSTATE_UNUSED(4),
         VMSTATE_INT32(state, SDState),
         VMSTATE_UINT8_ARRAY(cid, SDState, 16),
         VMSTATE_UINT8_ARRAY(csd, SDState, 16),
@@ -1313,7 +1309,7 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
-                  sd->proto->name, req.cmd, sd_mode_name(sd->mode),
+                  sd->proto->name, req.cmd, sd_mode_name(sd_mode(sd)),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1473,7 +1469,7 @@ static sd_rsp_type_t emmc_cmd_sleep_awake(SDState *sd, SDRequest req)
 /* CMD6 */
 static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
 {
-    if (sd->mode != sd_data_transfer_mode) {
+    if (sd_mode(sd) != sd_data_transfer_mode) {
         return sd_invalid_mode_for_cmd(sd, req);
     }
     if (sd_is_spi(sd)) {
@@ -1646,7 +1642,7 @@ static sd_rsp_type_t sd_cmd_STOP_TRANSMISSION(SDState *sd, SDRequest req)
 /* CMD13 */
 static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
 {
-    if (sd->mode != sd_data_transfer_mode) {
+    if (sd_mode(sd) != sd_data_transfer_mode) {
         return sd_invalid_mode_for_cmd(sd, req);
     }
 
@@ -1672,7 +1668,7 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
 /* CMD15 */
 static sd_rsp_type_t sd_cmd_GO_INACTIVE_STATE(SDState *sd, SDRequest req)
 {
-    if (sd->mode != sd_data_transfer_mode) {
+    if (sd_mode(sd) != sd_data_transfer_mode) {
         return sd_invalid_mode_for_cmd(sd, req);
     }
     switch (sd->state) {
@@ -2078,7 +2074,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     if (req.cmd != 55 || sd->expecting_acmd) {
         trace_sdcard_normal_command(sd->proto->name,
                                     sd->last_cmd_name, req.cmd,
-                                    req.arg, sd_state_name(sd->state));
+                                    req.arg,
+                                    sd_mode_name(sd_mode(sd)),
+                                    sd_state_name(sd->state));
     }
 
     /* Not interpreting this as an app command */
@@ -2164,7 +2162,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
 {
     sd->last_cmd_name = sd_acmd_name(sd, req.cmd);
     trace_sdcard_app_command(sd->proto->name, sd->last_cmd_name,
-                             req.cmd, req.arg, sd_state_name(sd->state));
+                             req.cmd, req.arg,
+                             sd_mode_name(sd_mode(sd)),
+                             sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
     if (sd->proto->acmd[req.cmd].handler) {
@@ -2264,7 +2264,6 @@ static size_t sd_do_command(SDState *sd, SDRequest *req,
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


