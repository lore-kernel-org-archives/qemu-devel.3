Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B54C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZnD-0003lE-BF; Tue, 02 Jul 2024 05:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmw-0003U1-Nn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmu-0001ap-It
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:01 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3627ef1fc07so2285135f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912418; x=1720517218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9keY/jFkvIiFyvDvTcECImv8SUtBS1LmlJu/B1CPmg=;
 b=y/sFqRp3U2tafWxzAb45mUtjulRJX7UbH86PRxqwNjIeAYb//htCIfCOjkK4jHupNZ
 j5XPeGsyEe0HRg5ZXnyvJI9AXT7xIku2vSCgL3Gz1HiFLEydWtpRbTjyRvzlmW3b84UP
 6CNDiGpzDRYrPSeFSjePp1E/nsqf/oEXnCA+Zxr34Vj/azRwI8C652wNyJmdcoHf2vm3
 jWaobB1E4tcsFvELVwJzgf79gKnC+OYCQR0QkFkOxh5oUm4gLw6abeaUhbIutbDfWpuX
 dhitcGDEjg7rjBjrmYKb2WzRYnpaNmpqrONFHXnL7uEOfNtPiuWnhwa84Q5qyukpVvIl
 fu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912418; x=1720517218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9keY/jFkvIiFyvDvTcECImv8SUtBS1LmlJu/B1CPmg=;
 b=SLz8BuWS8/VIlS7rv7xwiE3F55GJYwSI+beER1acX4giGxsKmV5PiJbWHa29VvyYuL
 wN6VwAKe8Rdje8RC5+AjAYhFNNTlUm4ArCPu6EEZQ3U7ef/CVVbnXfppvgLI2t1274T5
 Bv4g5hyZ4mef2l/5ts7XyKGn9zEEeaxHI8KTEPLt/kf+5QrVDQ0mJxRvaF/PE/rwsVt4
 XBqBNFxgV+RH4i2M+VwjBftfkFPY9d+zpX2nr2BUpp4S4AkAhDoeJN/iU+68n4e5wrun
 crgrHOoyPAp27MCOw++ZuEQkWhALsOjm5j0GF+B6EQPEcVj17IvLQJHiTpJgBYoekMT4
 p2aw==
X-Gm-Message-State: AOJu0YzzWVgSRHG5t9yntbJxmX7d5f2FTqsCC2o9XRxD/fr3nzoVrSN9
 kkxogalsxxxvUurixGyXZmAWzEj50xpltVzB08giSnTjQTgB5hnt9Atm2qZCEwpT7DJAj+3AniL
 2
X-Google-Smtp-Source: AGHT+IGvxkxSk8Eegssxrv4wxbRqzr9HwIlRLTM5alQnUdx1p6tHLij3oCUWb8vkhCg+VxgLL3vWxA==
X-Received: by 2002:adf:cc81:0:b0:367:3b0:f8f6 with SMTP id
 ffacd0b85a97d-367756c7313mr4734925f8f.36.1719912418576; 
 Tue, 02 Jul 2024 02:26:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9b1dsm12716767f8f.42.2024.07.02.02.26.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 62/67] hw/sd/sdcard: Add sd_acmd_SD_STATUS handler (ACMD13)
Date: Tue,  2 Jul 2024 11:20:45 +0200
Message-ID: <20240702092051.45754-63-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-Id: <20240628070216.92609-70-philmd@linaro.org>
---
 hw/sd/sd.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fed95563b8..8b31e0b41c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -258,7 +258,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
-        [13] = "SD_STATUS",
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
@@ -1664,6 +1663,13 @@ static sd_rsp_type_t sd_acmd_SET_BUS_WIDTH(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD13 */
+static sd_rsp_type_t sd_acmd_SD_STATUS(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_sendingdata(sd, req, 0,
+                                 sd->sd_status, sizeof(sd->sd_status));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1788,18 +1794,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 13:  /* ACMD13: SD_STATUS */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_cmd_to_sendingdata(sd, req, 0,
-                                         sd->sd_status,
-                                         sizeof(sd->sd_status));
-
-        default:
-            break;
-        }
-        break;
-
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2335,6 +2329,7 @@ static const SDProto sd_proto_spi = {
         [59] = {0,  sd_spi, "CRC_ON_OFF", spi_cmd_CRC_ON_OFF},
     },
     .acmd = {
+        [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
@@ -2391,6 +2386,7 @@ static const SDProto sd_proto_sd = {
     },
     .acmd = {
         [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
+        [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
     },
 };
 
-- 
2.41.0


