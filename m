Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2C6C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZly-0008Mi-Db; Tue, 02 Jul 2024 05:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZln-0008Dr-Km
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZla-0000md-WC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-425624255f3so23638235e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912337; x=1720517137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsTleHfMR+jNkMLGT2+7/tT9zaWyW/qieWJj1402poE=;
 b=ai7gSsbeUAUQy6vTqJLuFmpcdNT4cfbH9xG19nt958Fu1zPGtHSYZoNWG3z10bI7pt
 2VsgJCTHvjDOePfi2tRKj+whjmNqLz5reAq6CzOwaRL7pVsdgbNyAYiPXKa7j9NF9NUA
 KxBWwBZbSvfqSoLUwSPmoFTAG5QQ5z7q3n1dyWdc+66zzQLAQEkbss0MrNDsNojCI84i
 LiS7NgSF9sGVLX4XlOtxbX0Z8m7mxJ1jpPXodbU/8eJU97cQ38gJEYRM/Nck2JBYGoSo
 ilDVuQ2+75Qzdppx3pkJrS1+bNmTFTx+o5Vtl6B4jChQLCBJGzVZ1WafDQIZUVhQzp3K
 R3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912337; x=1720517137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsTleHfMR+jNkMLGT2+7/tT9zaWyW/qieWJj1402poE=;
 b=A880bi18W3PlSNyYmPHQZSQd5y4YkFk9trh00pU9BxXHRf/gvD6wVYKQi31xf9+XX/
 PcNQabNJswV4ZmQ41jBdPt6NW1PTc8QRb7c+D1TwWB+t4cVOkFD2HlJg7kiH2LgRMir2
 E/tu+8sPtpEV6QUSrk0ex1r8aD1OMjxSNzuHOypJJdb8sWcddfaYR7DrS116vCsFzWCb
 +ePyUiIalmm+VMLnRwz+s/melU8peBeF7/xOXgObTlZqY11tI+Rmy8bAmSL98W7aqP0y
 ESzgXQjC0uvrx+27NC+vH2sdI4ryJIFvFoR3IVBWxkkECMyd/oByO1kchFUEuDzo+N5f
 Mjaw==
X-Gm-Message-State: AOJu0Yx1usO15toaHnH/duZuvWabBVR3oIEW+3YSWjZS3cltpHsWVJsV
 slXn3zj3Gz5pED9aTvd6OWb386J0lmJZYM4YoXjmqwCe9dhJbIvgB/Ly8ovtebEo9uBEl2RO6QV
 M
X-Google-Smtp-Source: AGHT+IFzjoPEp8O6Na1biHYX9+V4IgZCs6fFuB2Q6sZY6c4L5D1bjqvU3vxhdPq+3y3IvC4zBw7Zmw==
X-Received: by 2002:a05:600c:4749:b0:425:8cc0:58b6 with SMTP id
 5b1f17b1804b1-4258cc058e4mr4313835e9.14.1719912337363; 
 Tue, 02 Jul 2024 02:25:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42577a0c286sm97143495e9.0.2024.07.02.02.25.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 48/67] hw/sd/sdcard: Add sd_cmd_GO_INACTIVE_STATE handler
 (CMD15)
Date: Tue,  2 Jul 2024 11:20:31 +0200
Message-ID: <20240702092051.45754-49-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Message-Id: <20240628070216.92609-55-philmd@linaro.org>
---
 hw/sd/sd.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 426144c659..56b4b274a1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                            [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
@@ -1394,6 +1393,30 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
     return sd_req_rca_same(sd, req) ? sd_r1 : sd_r0;
 }
 
+/* CMD15 */
+static sd_rsp_type_t sd_cmd_GO_INACTIVE_STATE(SDState *sd, SDRequest req)
+{
+    if (sd->mode != sd_data_transfer_mode) {
+        return sd_invalid_mode_for_cmd(sd, req);
+    }
+    switch (sd->state) {
+    case sd_standby_state:
+    case sd_transfer_state:
+    case sd_sendingdata_state:
+    case sd_receivingdata_state:
+    case sd_programming_state:
+    case sd_disconnect_state:
+        break;
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    if (sd_req_rca_same(sd, req)) {
+        sd->state = sd_inactive_state;
+    }
+
+    return sd_r0;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1459,17 +1482,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     }
 
     switch (req.cmd) {
-    /* Basic commands (Class 0 and Class 1) */
-    case 15:  /* CMD15:  GO_INACTIVE_STATE */
-        if (sd->mode != sd_data_transfer_mode) {
-            return sd_invalid_mode_for_cmd(sd, req);
-        }
-        rca = sd_req_get_rca(sd, req);
-        if (sd->rca == rca) {
-            sd->state = sd_inactive_state;
-        }
-        return sd_r0;
-
     /* Block read commands (Class 2) */
     case 16:  /* CMD16:  SET_BLOCKLEN */
         switch (sd->state) {
@@ -2326,6 +2338,7 @@ static const SDProto sd_proto_sd = {
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


