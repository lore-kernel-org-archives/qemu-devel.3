Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7209AC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZkc-0003rW-2h; Tue, 02 Jul 2024 05:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkT-0003Rt-RM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkO-00009v-6w
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so18826665e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912261; x=1720517061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdXTl1syEL0/e8CCzGe/VrOY/+llJ3nM1VXYbHMVSR0=;
 b=DYwc7CYYNFvDiz9Dgt7ncebHM/JYq9uePATOHkIyREeahMg85ql0CwS1TaE2kPA96+
 xwfhPCbMCltBa264HJB0qytorVKsWIAh4J7ckrO18onot9zytC36Yav9E3u2NdjvgeEM
 y4iaeh3mcYTbpD8Zr+azM2DtVcpIJ9nc+draIWfruVI5Mz7q8nRCKWdyId29Q9MKgTHx
 X/aDE0e7xpz2d4nfRNiQTAHJ81A2Gkcxla0fgLRRKShaWmGYTOZg+9pYppcVJ77QR6lW
 bfPR/efmF1XEwcPi9W+q18820MS/mCh/JVa0dQmTBr9dN/3NqTZoKE2vsv8ns4pukacV
 o2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912261; x=1720517061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdXTl1syEL0/e8CCzGe/VrOY/+llJ3nM1VXYbHMVSR0=;
 b=Sbxr9BWjrxqLgOHHsz0qqyr4Lozk/3RvS8AvYyternmZ4zw6jfH3H7d8QPQp+U5OFy
 fTHsxJtBugshTI20WU9r2DlNW1MMtHgikcLEImzmKJSkW488RBZ+H/n+08T6IAJlQhmp
 VxFx7/F45S667sNS0ibn4TXiikeE3pEU1NGlrL4QDFaAsWqoW/TNkRrsqtOKdAZ/S4Ra
 z7WqY92mb4VBaLjHhmaAjZzJrF7UZGDovdIHpQVn7o42wJG6A/b65tKB1wpCfIDgRnDD
 59nyWF24hGRvGfk8pyls2x7Gap5AYRu31lLKnE6YNjsjCmGfnUVU9e0bquwat8s6pxVZ
 QskA==
X-Gm-Message-State: AOJu0YyrP/hAeKfHUbivIWMTzKDDgHlYmjspWEHzRJcGVeKJEWooCuZH
 bZoSe87dC/JE4PYVz5JFRj+adazPW5+/QaLO48Jcb7DQQR1s57nZYzxf9q1MPljOf0+rPbU9dLd
 7
X-Google-Smtp-Source: AGHT+IFnVf/7K/MK9YzmRLKdP4X0dYe8K/UtmoegoKop9lMclKrQAv38jwTpHLLe1tkeUDNuyfC6Qw==
X-Received: by 2002:a05:600c:4a07:b0:421:29cd:5c95 with SMTP id
 5b1f17b1804b1-4257a00674amr72069225e9.10.1719912261581; 
 Tue, 02 Jul 2024 02:24:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3912asm195612945e9.10.2024.07.02.02.24.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:24:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 35/67] hw/sd/sdcard: Store command class in SDProto
Date: Tue,  2 Jul 2024 11:20:18 +0200
Message-ID: <20240702092051.45754-36-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Store the command class altogether with the other command
fields (handler, name and type).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-42-philmd@linaro.org>
---
 hw/sd/sd.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9f257906b5..68e6944263 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -94,6 +94,7 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
 typedef struct SDProto {
     const char *name;
     struct {
+        const unsigned class;
         const sd_cmd_type_t type;
         const char *name;
         sd_cmd_handler handler;
@@ -349,13 +350,6 @@ static void sd_set_mode(SDState *sd)
     }
 }
 
-static const int sd_cmd_class[SDMMC_CMD_MAX] = {
-    0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
-    2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
-    5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
-    7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
-};
-
 static uint8_t sd_crc7(const void *message, size_t width)
 {
     int i, bit;
@@ -1298,7 +1292,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         sd->multi_blk_cnt = 0;
     }
 
-    if (sd_cmd_class[req.cmd] == 6 && FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
+    if (sd->proto->cmd[req.cmd].class == 6 && FIELD_EX32(sd->ocr, OCR,
+                                                         CARD_CAPACITY)) {
         /* Only Standard Capacity cards support class 6 commands */
         return sd_illegal;
     }
@@ -1883,6 +1878,8 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
 
 static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
 {
+    unsigned cmd_class;
+
     /* Valid commands in locked state:
      * basic class (0)
      * lock card class (7)
@@ -1897,7 +1894,12 @@ static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
     if (cmd == 16 || cmd == 55) {
         return true;
     }
-    return sd_cmd_class[cmd] == 0 || sd_cmd_class[cmd] == 7;
+    if (!sd->proto->cmd[cmd].handler) {
+        return false;
+    }
+    cmd_class = sd->proto->cmd[cmd].class;
+
+    return cmd_class == 0 || cmd_class == 7;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req,
@@ -2275,22 +2277,22 @@ void sd_enable(SDState *sd, bool enable)
 static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
-        [0]  = {    sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
-        [1]  = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
     .acmd = {
-        [41] = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
 
 static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
-        [0]  = {    sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
-        [2]  = {    sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
-        [3]  = {    sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
-        [19] = {    sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
-        [23] = {    sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
+        [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
+        [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
     },
 };
 
-- 
2.41.0


