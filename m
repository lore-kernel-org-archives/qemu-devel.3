Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80206C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZln-0008B5-SW; Tue, 02 Jul 2024 05:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlk-000837-Q2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZli-0000vf-8g
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso34784425e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912343; x=1720517143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdTwu99eUQlsPY0aCQAbuEuylC9rmmKUSrJ2XBIqUJE=;
 b=t3dDEXFbeK4zBd3rEW3oXFsuB+PncLDZE3bDxYU+uM537pwOm+aDDnji9c3+vYDqfp
 D+rOJ4+bxUFruEILwGMjh8uCOAgIky7auDzY4hJpiaziq+kOkdWya8vwDO0qWAPkWluk
 ojJb7x/iwM1spUw2foA41G5Rx0AbGtNK9+WDl2nsSqMXCOJPQ62sD2ThBzmGUKwVlKu0
 gZ6OrNqvgEtJvjHOOZAR7nLH6/wWRRa/BCl/PEMidk77Q8zX68e+G4s48tk5rt5LmQQG
 IKtXflKmxBHvwY0k/m5qV3eVI5UM1xzUPjTxmQ0rPW33R+Z0cQPTL/aA8VNRUuxENZWO
 mOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912343; x=1720517143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LdTwu99eUQlsPY0aCQAbuEuylC9rmmKUSrJ2XBIqUJE=;
 b=bEwcnYRgRklcO9d3vWsAH4SNMrjLoHZCz3I68chiRGn9hPvQimBqV0EF0r2RabUSnZ
 L/kesI6icolYUuHL5zuLe6E3BqZlD/somQZ7s6zbjdsN+yZCciMjljFgH6DHzTLaASZm
 uX4PAb4ZfzRprOWdpwGMYx7adrKmy7gnM1pV0cs6usIAahXcnQ9/D4OK4xe/NCpa6Su1
 7wrvnmpXfbiL8F/+CFLZSCuvFBXSxlZww0JOeIJgB3lgzGHW3SQYTyL+qj1ujG5wvS3v
 HrKcaZq0jHruwqQwpaLO21YzwRShR4tDvBZHrMgTKNGECL+PfRCFygxjZjR688dj4ZoK
 2r5A==
X-Gm-Message-State: AOJu0YxOvffZnkyu9wLMDy84RyNXsYtvZlzHkMTUH6c0BLmTybahYWgP
 GZjywqZGNtCJVf3O0Mh5uc9fYS+VX2mqTC1Hy5zYCB19N5fbg9HV3mjivZRK7LoaWZCwooXOwG+
 8
X-Google-Smtp-Source: AGHT+IGEU+Nud7Xs+MIvPItnWhG1QYh/epmVB2HW46/JzE4C3B3EDrUcNP/MuvhJZvoU0Le5cHlbZA==
X-Received: by 2002:a05:600c:19cb:b0:424:aa40:88ae with SMTP id
 5b1f17b1804b1-42579ffcae6mr69016165e9.3.1719912343210; 
 Tue, 02 Jul 2024 02:25:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257fb4fabdsm96398635e9.46.2024.07.02.02.25.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 49/67] hw/sd/sdcard: Add sd_cmd_SET_BLOCKLEN handler (CMD16)
Date: Tue,  2 Jul 2024 11:20:32 +0200
Message-ID: <20240702092051.45754-50-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Message-Id: <20240628070216.92609-56-philmd@linaro.org>
---
 hw/sd/sd.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 56b4b274a1..335b3e03db 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-        [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
+                                            [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
@@ -1417,6 +1417,22 @@ static sd_rsp_type_t sd_cmd_GO_INACTIVE_STATE(SDState *sd, SDRequest req)
     return sd_r0;
 }
 
+/* CMD16 */
+static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    if (req.arg > (1 << HWBLOCK_SHIFT)) {
+        sd->card_status |= BLOCK_LEN_ERROR;
+    } else {
+        trace_sdcard_set_blocklen(req.arg);
+        sd->blk_len = req.arg;
+    }
+
+    return sd_r1;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1483,23 +1499,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Block read commands (Class 2) */
-    case 16:  /* CMD16:  SET_BLOCKLEN */
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (req.arg > (1 << HWBLOCK_SHIFT)) {
-                sd->card_status |= BLOCK_LEN_ERROR;
-            } else {
-                trace_sdcard_set_blocklen(req.arg);
-                sd->blk_len = req.arg;
-            }
-
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
@@ -2308,6 +2307,7 @@ static const SDProto sd_proto_spi = {
         [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
         [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2339,6 +2339,7 @@ static const SDProto sd_proto_sd = {
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
+        [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


