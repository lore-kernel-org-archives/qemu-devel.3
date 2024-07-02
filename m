Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D8FC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZnF-0003x3-QB; Tue, 02 Jul 2024 05:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZn6-0003bV-FZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZn0-0001bS-Hn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-424ad991cbbso30465105e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912424; x=1720517224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+J0uE60QAC1qoAu1BGNiyLRNnbj4AKJfrIlOAls69nY=;
 b=d1RkojE2GZXXd0dT+7G/E4XwvI4oT5mW4uRxKYqvoHIGLnryxg/cI7H13mpMYUDCZY
 tJN4nPUXz/gazASCoquH8OSgSW3htcyW4fw4b5JMhsJTu10q0yTcZTVmHwZBM6i+UWhk
 B5q6QJnU81uGnPHyEXgvPOrnYWScTEOwD15es6TM49L/gxCmUpltoN35rZ7qemZxqTup
 CXw9QJ4i9tIwu1kJ/8iHZinGylDUPYeiMq/fOBu3Sz01e3was1USCaV/Tu9MeRdocVa2
 prTN9zVTeZNTjB0SAtvpaBePe2ZVoiYKAPzZ+4kkFV/Byj1nl08m+CwnBqSk1ZSEeaUX
 v/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912424; x=1720517224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+J0uE60QAC1qoAu1BGNiyLRNnbj4AKJfrIlOAls69nY=;
 b=Pf7mm81Khyk5JcjPaKDsgRWHeiIW0gsKL2poHYTtavQLyDJnYHOdLFT8SMvYK/Bcim
 UIiJS8w2i5d3SuhyX9EEn+Q8U6YqU4g68WF0wrujXWen7oo6RrHJZiTuQEVa+DUvKRSN
 s4luGLZPEylgCykCvGVpwkXbWWt21uxE3RgKAvMxWKDHL0Jbbg7xeIX2hzYUxghN70vJ
 SV1LvY09MirPZkQhB0czYM5uUIXulWjvLOe4KNJIBWRBdcG++OlWaltFsqGLZnK08//9
 TnjuFuZCLbBhO+04gMI/rpfTUg+IGAuma9cbZJFT1FKUkiYc8UlE9COBDjOVWJoKnvWS
 EYFg==
X-Gm-Message-State: AOJu0YznzEaRBKBY5+u/SdW2y+K0az5Zb5ozOlwWr0ZTjlDhtWatjrzy
 OGNk818iVjk03h2WemDQGZdIGAcTCxMHJ0kUWsIIZMzr3E4isBNUf1rFvZlycoeufz46VhfTCnq
 h
X-Google-Smtp-Source: AGHT+IE0GNWZsLo+UWrWMvHEuKZhvhr4acQ+G6U+ZaNdBoiiSKAWSE4s9We1O8QPZjHSVpHLwhj8HQ==
X-Received: by 2002:a7b:cd92:0:b0:425:781b:9802 with SMTP id
 5b1f17b1804b1-4257a02b746mr53594915e9.12.1719912424299; 
 Tue, 02 Jul 2024 02:27:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b099c72sm188322485e9.37.2024.07.02.02.27.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:27:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 63/67] hw/sd/sdcard: Add sd_acmd_SEND_NUM_WR_BLOCKS handler
 (ACMD22)
Date: Tue,  2 Jul 2024 11:20:46 +0200
Message-ID: <20240702092051.45754-64-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Message-Id: <20240628070216.92609-71-philmd@linaro.org>
---
 hw/sd/sd.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8b31e0b41c..6e9ab92a1a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -261,7 +261,7 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-        [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
+                                            [23] = "SET_WR_BLK_ERASE_COUNT",
         [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
@@ -1670,6 +1670,13 @@ static sd_rsp_type_t sd_acmd_SD_STATUS(SDState *sd, SDRequest req)
                                  sd->sd_status, sizeof(sd->sd_status));
 }
 
+/* ACMD22 */
+static sd_rsp_type_t sd_acmd_SEND_NUM_WR_BLOCKS(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_sendingdata(sd, req, 0,
+                                 &sd->blk_written, sizeof(sd->blk_written));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1794,18 +1801,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_cmd_to_sendingdata(sd, req, 0,
-                                         &sd->blk_written,
-                                         sizeof(sd->blk_written));
-
-        default:
-            break;
-        }
-        break;
-
     case 23:  /* ACMD23: SET_WR_BLK_ERASE_COUNT */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2330,6 +2325,7 @@ static const SDProto sd_proto_spi = {
     },
     .acmd = {
         [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
+        [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
@@ -2387,6 +2383,7 @@ static const SDProto sd_proto_sd = {
     .acmd = {
         [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
+        [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
     },
 };
 
-- 
2.41.0


