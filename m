Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04674C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5hp-0001Ri-Ao; Fri, 28 Jun 2024 03:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5hn-00018x-Ej
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:35 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5hl-0003N8-Ez
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:35 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ce6c8db7bso414747e87.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558451; x=1720163251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=stDFUWod5392Ne89qirOgTqrrl6jkkp2/YnCFIJD5bc=;
 b=IGh4WdiWtf6Eswub15uNZXUMbx65jLZv1GPLpv83tJX8/JPNqBMSG/BUdUyFh7aAMl
 GBgtys7jYirpXPZ6Jh4wfnZsYa9Wfz6lS6zYuGsc2f/6nLIgSvmoWimIlu5a0Jdqyx60
 Htzuwn9DhNykxZZOacqBkWO9knD3AQnGJa4WmsbQ/yxqPQsn670V5tQBP4vtq7T3pOuy
 8LC8vbXj9vbzRrpy+j9oX1B8JcowTjJ0qTYZN28jSx0DvT/uktmPd9ReqAb+Ua2KYqda
 cbxlxgxTUvoxDsPyNxWNdRdV+GdoIcZbNvrRedQiyZyVs/ga1RbVRtjS9aQVGiDKBySM
 8LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558451; x=1720163251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stDFUWod5392Ne89qirOgTqrrl6jkkp2/YnCFIJD5bc=;
 b=mQGvoDSQIUXiO/Lz3AejuE1bdNidwIsqhB4AGCJAXOprT3G7AhiTckCzJPZAEnJNuy
 OkSel2dSOSsugoAmZdEcL1Plzl7erQZ98TwbScUAPTdpOba6QhF0UBwnCwnts1yUKkeq
 KB6t/2GeChmoQ7m/h9QERaVAzIHshwzF81W6M1T6OHsQXDBNERWOwT8qhIxDUGRCMCPR
 EgE7dGkprQZ4yHrpr8xJMVxNMPbXejKDaJ9LL0yv7/Tpo+ru6T/qhNbO51QrH5Ay58Vs
 fAhWobgcRBZZKZdBOlj96md45qdYawx6hmJdWKDpqSwzBGoKnXtNN95IUws3PsuQZuXh
 JtLw==
X-Gm-Message-State: AOJu0YxV02v/quRSM/VchbMxL7/Nqqnkwjw2knWlGWOdPn+QUvsHXoc/
 FgfkZqaOKU4oss9v9ui0fgmIX4PxOCykba+o+8aqZaGxoFCyTbUHDdxIZAqsgUAk+L6kET5ceF6
 3f9U=
X-Google-Smtp-Source: AGHT+IEetVmMwCN2nFxV7eF7kMlplj9zum/wBHQiAE+W98JB8i/pI5JicY3LZdordKel/HGA/sVj3A==
X-Received: by 2002:ac2:5dd1:0:b0:52c:df86:68c6 with SMTP id
 2adb3069b0e04-52ce183517dmr9419984e87.16.1719558421421; 
 Fri, 28 Jun 2024 00:07:01 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc41esm1337522f8f.78.2024.06.28.00.07.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:07:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 49/98] hw/sd/sdcard: Add sd_cmd_SEND_IF_COND handler (CMD8)
Date: Fri, 28 Jun 2024 09:01:25 +0200
Message-ID: <20240628070216.92609-50-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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


