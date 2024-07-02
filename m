Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5206C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZm4-00006O-2k; Tue, 02 Jul 2024 05:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlp-0008GZ-2Q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:53 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZln-0000w9-3v
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:52 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ed5ac077f5so47037461fa.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912349; x=1720517149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5p+b2GGIVB5B1uUI5bQzO6xootFfyz2SaKoSXjhZWM=;
 b=M7vsy5SH6Ljk8CryGjxsjsX7PLGWUBS9IF8sQZBf401amNd3Dtt+Y9lOhuB72xrvoq
 usCO5Qr2Tw92IcKvTs3lIk9V2Me3tSwhlAbv2fLjSgAIBouv/oafgn8l+JqZ84IxX6FZ
 0wSEF4SYBso/1fhltduNMsVdgDNs8IzpMU0PyBGVuFBv++DJ++CCweZIaO7h8Ox03Sgt
 YyGrLcZaemmwbKzd7nXlLoLVmvdcP7+4WVg0+rw4VHtn7D+UJ05m8klGJ66us4ipienl
 4298nTEap0tMqxfvhvHh65gY1mujyjT95T8HDkZ7aP+L52HnynmI1Ced8wNyVjJUz5x7
 Dz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912349; x=1720517149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5p+b2GGIVB5B1uUI5bQzO6xootFfyz2SaKoSXjhZWM=;
 b=ekIMdzKorFQZTEDz189ReRqVOEM3XB4DqwfXhlaFzgKDiy91IBSvbtrmaobtkzbFJG
 xIToROYpiF4W/sx5J3OJYTDkLve0IaSYvQXaGPMhfy6sq366LsTlFdvQbGCEjha3UML4
 cxkTD5T5L9tsg65MxdGb4Z9H1Vbx9PMAvmotGyTWooDwtC/O3+XG3f9pYoNqNnN9VO1o
 EdFzAchGwsCKXvioq0Xnfy9M7zuWrQfym+oybrcTdu8FpAL3QxU9c65trmE+bmoLDv+f
 V5VLgroKHpHcBlSJgjMi6pwgDJF+C4ELGJFNprPnX3xpC21z/m5cOFFWZnDt6trPab4r
 nkew==
X-Gm-Message-State: AOJu0YyXtHFjKgNeVRwzYLapFq6LcwGpMfb/rsrLaLrnnkd2NO2zmElu
 2hDsup6qRU98hcnw8Rli5QVgjUnvQK9jeRtp3GrzsmEdhwr2xhvzp8TcjqK0X0xHPFKGJ15QR41
 D
X-Google-Smtp-Source: AGHT+IH3QmGxiGUz3HgOO+z8oPYesObID/Qo33axEbUDp4AJPKvyjD1mbBnpjV+nTXFzCTS0za+jRA==
X-Received: by 2002:a2e:9dcf:0:b0:2ec:520d:f1dd with SMTP id
 38308e7fff4ca-2ee5e3594damr49077951fa.3.1719912349094; 
 Tue, 02 Jul 2024 02:25:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097fd4sm188808705e9.29.2024.07.02.02.25.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 50/67] hw/sd/sdcard: Add sd_cmd_READ_SINGLE_BLOCK handler
 (CMD17)
Date: Tue,  2 Jul 2024 11:20:33 +0200
Message-ID: <20240702092051.45754-51-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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
Message-Id: <20240628070216.92609-57-philmd@linaro.org>
---
 hw/sd/sd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 335b3e03db..3f5cc0c55c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                            [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
@@ -1433,6 +1432,24 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD17 */
+static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDState *sd, SDRequest req)
+{
+    uint64_t addr;
+
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    addr = sd_req_get_address(sd, req);
+    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
+        return sd_r1;
+    }
+
+    sd_blk_read(sd, addr, sd->blk_len);
+    return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1499,22 +1516,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Block read commands (Class 2) */
-    case 17:  /* CMD17:  READ_SINGLE_BLOCK */
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-
-            if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
-                return sd_r1;
-            }
-            sd_blk_read(sd, addr, sd->blk_len);
-            return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
-
-        default:
-            break;
-        }
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
@@ -2308,6 +2309,7 @@ static const SDProto sd_proto_spi = {
         [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
         [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
+        [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2340,6 +2342,7 @@ static const SDProto sd_proto_sd = {
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
         [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
+        [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


