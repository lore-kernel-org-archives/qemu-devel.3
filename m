Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1C5C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZlY-0007Iz-2j; Tue, 02 Jul 2024 05:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlV-0007Gp-P0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlR-0000Kh-Ip
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so27643685e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912326; x=1720517126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01K5Fpbyc/Wo8G4gat2aNkWhP6GApv43W9gex3KjoA4=;
 b=l/7ZckfmQuOxDaDpadrInrH27qXXzF7C0GsJ/Kw7hCtQ6JigmKQkxIOKE00kP8N7rU
 z+oNwLaqaMSAuNsYgWMRb7ysphIKUgybhrAZZD3gpO6vVtAy6JMiWJNt1U4B0nzbR2nu
 kU2L55MvVgbrODAnyXOqLYPrBdAr7TCI2FMJNeZdoOgx5aJdmEGDLSecvhiUlqypS2vD
 vpzlEJS0UrpApAwks8dcDmL89x8N+kDnz8338AaC+w3z5X8XTPxufF0fa69mlv+zOclM
 hUUqRitfcy8rbYfrpSwhB0JLR+WyKDuSDvVUrsNH2YfAt8iH17vHRtZb5kx/W07bBvCY
 GYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912326; x=1720517126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01K5Fpbyc/Wo8G4gat2aNkWhP6GApv43W9gex3KjoA4=;
 b=gwIWL4xvcwyP0vTp/u4nbLrigfi3TXJ7JKytX+8Sg5Xfo3AnM5hyy+ovcQ7op4/XHx
 gnv/ERYmwpQGH4/Ynz1LNJJY9/tP9kWGw/hetmaUzPLPA2SoWJzU9PnZgIYLDJYHm8zI
 iE3k9Szvdjv6wvEnkq9XFss765NCzWMzjc47ZKzGrfgFaxyXwX8ciEuuzmg7pRxbbVfO
 e3eJo1vXfblxGFnZNSnJBOZgT1/zfs+Qgq6hyoGxj9bFowy5u/S6MFPpd+v2usCk+NH6
 lOgVLZzcEy3vRtoAE1OIE6HXRcJ2L60/cstBh5MUM2/RLuQmaiyBA2dljGczNfm4O2D+
 wSBA==
X-Gm-Message-State: AOJu0YzrCg3JAHHX8op5uqgfGpn6WtuwPahYcPsYQIpIYdmWmiNAWEBP
 k6y5M5tmCukNqEx15rGRowcNveZTrvy08Fmqv5otRFZOA1oBaqMnFh9/e8Nem3vBkgA0nX0aphX
 g
X-Google-Smtp-Source: AGHT+IEfBQVB963G217cvWZyECBbUl5n1F1H6/fqFpesdeJB7HoL5+PyYhU+vsBNr4jMYgnpsmY3uA==
X-Received: by 2002:a05:6000:2c5:b0:365:32e0:f757 with SMTP id
 ffacd0b85a97d-367757214bdmr4490900f8f.50.1719912325832; 
 Tue, 02 Jul 2024 02:25:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675f9dfbdbsm12298117f8f.103.2024.07.02.02.25.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 46/67] hw/sd/sdcard: Add sd_cmd_STOP_TRANSMISSION handler
 (CMD12)
Date: Tue,  2 Jul 2024 11:20:29 +0200
Message-ID: <20240702092051.45754-47-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Message-Id: <20240628070216.92609-53-philmd@linaro.org>
---
 hw/sd/sd.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 49fc79cf8a..0a554d30a2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-        [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
+                                            [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
@@ -1352,6 +1352,23 @@ static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
     return sd_req_rca_same(sd, req) ? sd_r2_i : sd_r0;
 }
 
+/* CMD12 */
+static sd_rsp_type_t sd_cmd_STOP_TRANSMISSION(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_sendingdata_state:
+        sd->state = sd_transfer_state;
+        return sd_r1b;
+    case sd_receivingdata_state:
+        sd->state = sd_programming_state;
+        /* Bzzzzzzztt .... Operation complete.  */
+        sd->state = sd_transfer_state;
+        return sd_r1;
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1418,23 +1435,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 12:  /* CMD12:  STOP_TRANSMISSION */
-        switch (sd->state) {
-        case sd_sendingdata_state:
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        case sd_receivingdata_state:
-            sd->state = sd_programming_state;
-            /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
     case 13:  /* CMD13:  SEND_STATUS */
         rca = sd_req_get_rca(sd, req);
         if (sd->mode != sd_data_transfer_mode) {
@@ -2280,6 +2280,7 @@ static const SDProto sd_proto_spi = {
         [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
         [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
         [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
+        [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2308,6 +2309,7 @@ static const SDProto sd_proto_sd = {
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
+        [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


