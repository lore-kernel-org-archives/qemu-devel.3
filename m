Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D29FC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsEX-0001i4-Kl; Thu, 27 Jun 2024 12:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEV-0001a0-Gn
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:27 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsET-0008Au-NA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:27 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52cd8897c73so7311177e87.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506663; x=1720111463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stDFUWod5392Ne89qirOgTqrrl6jkkp2/YnCFIJD5bc=;
 b=uR8iUqh/rxJK6fhXos8edbhZSqRkR0UFQ9VftEQ8O7xZOtt8IRROLcpGczkZidLpZe
 ajg/xACH3XCosB21kf4bQRJTyFpHlsOnvholhbsFWgxw3lq4qbXoK1fqFSP+Z6O1I3n5
 MjWjab0eru/Z/d38qVFOa5WlgkyuMAeUN0QXIGBOCLrmALEQaQTwwuLBUrmZci4aSwJs
 mKJ17QgOT/x9mNnwgonvtiz6AQRn6jd5fvpeaV4Z7n0OCpePhfRYLocTLBrrfYARAUlS
 1km0fUX1UN2REJsnhnCacd0IvvRIudASZ5ubGpA/ceHTQl8WDz1f7js5crnuB3/RLrqN
 UgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506663; x=1720111463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stDFUWod5392Ne89qirOgTqrrl6jkkp2/YnCFIJD5bc=;
 b=Q7Ab5LxeQ8jnuudcgFOt43GJIHuO01DRf6hx4UEOloHVmjlVr6Ha/i84nN3/0IukgP
 oV5LFc9V1SKHOEW069gdyP0QHXrSOQijUvoaKbOeXpY3yqzpJjIF5Ll5Vg12qojM3bwi
 xk4uq2UY0LgJ+JZqsu2LBOHFKuaF4zjxb60Fs3CMIXx+CFMW0WYlpJCt/SL1GEcPrjOT
 czR0KZ/K5ABa9/tkUV1cI9Lxk09yntoM5A530uIb1BI5L9vbbB9bB86/ZBWIxQUxFKUN
 2yqh3o4twIUDXfsaqQNP1e/G3TkR7j+tP9HC6P0SYQJNhbUUhveynhpzFYBs4Dh2Pdx3
 T8gQ==
X-Gm-Message-State: AOJu0YxGkGoPkmzPxBYvj6LvBme5FI3Pp2O1nqHq1gRx39N7B+Pp+ho0
 ltu3unhPErPGDo8to9mW/QurQG8yBwrAhLgzPjjXUXXUr/457h0fyGT+Il+LNPq/WTadfbhsPIc
 UXVQ=
X-Google-Smtp-Source: AGHT+IHK5BHUTYakSbe85zRjUcpk17gxZivMQkq41xJ8x/KtCgBwBbg4bElSk35l8tbD2jJf2P2Pvg==
X-Received: by 2002:a05:6512:324a:b0:52c:818c:13b8 with SMTP id
 2adb3069b0e04-52ce1832529mr7940761e87.4.1719506661337; 
 Thu, 27 Jun 2024 09:44:21 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8469016sm73473605e9.41.2024.06.27.09.44.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:44:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 03/21] hw/sd/sdcard: Add sd_cmd_SEND_IF_COND handler (CMD8)
Date: Thu, 27 Jun 2024 18:43:26 +0200
Message-ID: <20240627164345.82192-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6ad98db981..e2f7e99ea2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
+                                             [9]    = "SEND_CSD",
         [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
@@ -1303,6 +1303,27 @@ static sd_rsp_type_t sd_cmd_DE_SELECT_CARD(SDState *sd, SDRequest req)
     return sd_invalid_state_for_cmd(sd, req);
 }
 
+/* CMD8 */
+static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
+{
+    if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
+        return sd_cmd_illegal(sd, req);
+    }
+    if (sd->state != sd_idle_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    sd->vhs = 0;
+
+    /* No response if not exactly one VHS bit is set.  */
+    if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
+        return sd_is_spi(sd) ? sd_r7 : sd_r0;
+    }
+
+    /* Accept.  */
+    sd->vhs = req.arg;
+    return sd_r7;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1369,24 +1390,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 8:  /* CMD8:   SEND_IF_COND */
-        if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
-            break;
-        }
-        if (sd->state != sd_idle_state) {
-            break;
-        }
-        sd->vhs = 0;
-
-        /* No response if not exactly one VHS bit is set.  */
-        if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
-            return sd_is_spi(sd) ? sd_r7 : sd_r0;
-        }
-
-        /* Accept.  */
-        sd->vhs = req.arg;
-        return sd_r7;
-
     case 9:  /* CMD9:   SEND_CSD */
         rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
@@ -2278,6 +2281,7 @@ static const SDProto sd_proto_spi = {
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
+        [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2302,6 +2306,7 @@ static const SDProto sd_proto_sd = {
         [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
+        [8]  = {0,  sd_bcr,  "SEND_IF_COND", sd_cmd_SEND_IF_COND},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
-- 
2.41.0


