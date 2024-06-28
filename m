Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905A4C30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5hA-0005b2-OQ; Fri, 28 Jun 2024 03:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5h9-0005Rn-Jr
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:55 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5h7-0003LJ-MM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:55 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52cd628f21cso267719e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558411; x=1720163211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=slgYteJmLjr8pI8aCW+CqOWuh6a3YgyVMIwY4xDIlZ4=;
 b=S23vbEg+XdRW0wj99fkHeskBPIiq98fmQTR1eJRcg3kakmUIxWTqdY/KBa9VoRb2tJ
 NlbepcIR+VNg72+9S+5ORWetZAOxLg4clvWFc0NZ7bQ9YJy8TrAhH+RW6UhYoxHqelke
 MnCEdV3lFWqoocYEReUf78wWq+Wvs8Qk0EbwFBZGSkUz9uTAUr3XqbAifc7HW2NVbVAW
 xA5CEvfAbRHnEMaVuPlw0E4VbcCgYlPP4C1KXu+osFTbVngjzIk6o/SgIQFspr2eN4pd
 LORd8e0F4md4NWkqbDCwGOKokm58PVwF/ZWlFzVRNMTYWcWcjTDZy/NFarK44UWSTXWP
 H25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558411; x=1720163211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slgYteJmLjr8pI8aCW+CqOWuh6a3YgyVMIwY4xDIlZ4=;
 b=RQh4+tpY7CMgg2ZLAfkgKQQPLex1WlD9DvsN1n5XIB0ZrFZcLRgH8DPFG7275AHEA0
 DWXlwMz/ncPhqJoj2rEKMQvmzjNgqYt9OWGpWc3kHVQ5ockrBh/1sfn6BWBQpa2uzDYr
 c+5PAiAPWeuNUFuzqWIZfRmk98Rklv6cFuD6tk5c+ZJG08IClzcWvpxtAEfsdLKgqgKE
 d3sKZ0OmsgepGN0Os/OmgLw2UWtucwZDdK2XE26L4OQqLU0Z+E6U44RUsEATSS9X6N0v
 xes4ppQCHX6Y3epBece4fAqspAWO9sb5HsV92OXXhVglUevTAGaovNJmilfvFayIoBcT
 5kyg==
X-Gm-Message-State: AOJu0YxBid5tzw8UpCq6v0/x0lQwbJgbeQfeG3CnW0rvjsHMwvVuaTdo
 fk8vS1jB6Cd/tRTpbptY0DpWbKMn+58U+lCJrQWDJNB0ECp144ZFSvSM/gt8BCFI18P7SGCS8GD
 h6PM=
X-Google-Smtp-Source: AGHT+IEbc9KgM+OWALUMuZ1NSage3UfZh0Ibx9VIlLL4bJoR4VOaMll1JwG9q2EgfBwsxFJuC7ZkNA==
X-Received: by 2002:ac2:4437:0:b0:52c:c9d1:ad32 with SMTP id
 2adb3069b0e04-52ce1835a80mr10135394e87.22.1719558411281; 
 Fri, 28 Jun 2024 00:06:51 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09890dsm21401375e9.36.2024.06.28.00.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 47/98] hw/sd/sdcard: Add sd_cmd_SWITCH_FUNCTION handler
 (CMD6)
Date: Fri, 28 Jun 2024 09:01:23 +0200
Message-ID: <20240628070216.92609-48-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e4941cfdab..61c9aff2fb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
+                                             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
         [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
@@ -1244,6 +1244,20 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD6 */
+static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
+{
+    if (sd->mode != sd_data_transfer_mode) {
+        return sd_invalid_mode_for_cmd(sd, req);
+    }
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd_function_switch(sd, req.arg);
+    return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1310,17 +1324,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 6:  /* CMD6:   SWITCH_FUNCTION */
-        if (sd->mode != sd_data_transfer_mode) {
-            return sd_invalid_mode_for_cmd(sd, req);
-        }
-        if (sd->state != sd_transfer_state) {
-            return sd_invalid_state_for_cmd(sd, req);
-        }
-
-        sd_function_switch(sd, req.arg);
-        return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
-
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
         rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
@@ -2266,6 +2269,7 @@ static const SDProto sd_proto_spi = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
+        [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2288,6 +2292,7 @@ static const SDProto sd_proto_sd = {
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
+        [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
-- 
2.41.0


