Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90DCC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsFD-000322-En; Thu, 27 Jun 2024 12:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsF4-0002kj-Hn
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsF1-0008GC-Oe
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42562fde108so11889375e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506698; x=1720111498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nsIUIKAxv1jJ77cujJiWISIWdMZfiLK/guukYvkLv0=;
 b=UruQF5cbgeA/L5pCkB3DUxvS9DQk4tL4W4GNTHhDhATFJ6nhL8Ydk2hI4jfbRaAQ/Z
 SeT8FWC2KBAB6OslKmyRBdJmkQ/0S214VLQWIznsunNEQ7suXqnmh+Dh6SF/DSv0TVm4
 s9p59KN+02fpQJtFj2xIj3w3TDAb/Uj4NSt//tf9wNYgJiHbGCNp2Ewu+lDQYnC830ab
 v+ssFVvRQxpDsb5KkOessV6YCvOwcBccnZ0uJ6Q3biwG1UpfyAbL5E3wbDnaN0gTLRCH
 /nw5LV9rng+a5zMCExWecIot0E0k/mPnxOZ+1GCsR+6V0MYyUM0NAa6Eiby0o0/6i/Z/
 eh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506698; x=1720111498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nsIUIKAxv1jJ77cujJiWISIWdMZfiLK/guukYvkLv0=;
 b=VEgh1QXoqunA0rNAMMYSIyJeWP8A8KqO7ZBh8I/FcPltBEt8L61BEEg2V7sV8Bwzzl
 VL/G8s16CDYa0JT0Iq4gnT0+kQxzMdJKFeta9BIon4Q9Q2w4p0sunNnJD9dnNbr4rbea
 QpNqdrq9HvDxm6Bf5KJ421G8uUB9j0rXmAcORqNBDZUSaT7h63xqgYkcEyaVkqpX6EjS
 zsvbz1DxXsz1eF5VT/pdHMmDSmQIcSwMf9PYMjNQnNfrxrl4Fjg6TrmAvko8d0h+OsST
 CNorg6ISDuYbX+PK+eBeD8vUz0DD2xX4UhCSMgGHqCJrXS0Hzw9DgLrGVGo15+SjHD6B
 uaSw==
X-Gm-Message-State: AOJu0YyUxn81As+XkJZK3wycG8L8xqUD8zWP9j8Ytnzjv13KHkxEQXNG
 QOHq78/B3vfacVPjhghIPaS6Mgzk82yuFVoeFCF0GTJHuF+7qL/Szlo4u33TaphKpSLlR+Dpjrq
 Z8cU=
X-Google-Smtp-Source: AGHT+IFJlrbc+L9YIL2JP6ybIuDikfbOScRuF4/dcK+k+qk6V8XzJaBC2hotD2O2AugyWh5HjZqsUg==
X-Received: by 2002:a7b:cb56:0:b0:423:6957:89bd with SMTP id
 5b1f17b1804b1-4248cc287b0mr104621225e9.12.1719506697908; 
 Thu, 27 Jun 2024 09:44:57 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256aed237dsm260235e9.0.2024.06.27.09.44.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:44:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 07/21] hw/sd/sdcard: Add sd_cmd_SEND_STATUS handler (CMD13)
Date: Thu, 27 Jun 2024 18:43:30 +0200
Message-ID: <20240627164345.82192-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
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
 hw/sd/sd.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1c092ab43c..bb80d11f87 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                            [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
@@ -1377,6 +1376,32 @@ static sd_rsp_type_t sd_cmd_STOP_TRANSMISSION(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD13 */
+static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
+{
+    if (sd->mode != sd_data_transfer_mode) {
+        return sd_invalid_mode_for_cmd(sd, req);
+    }
+
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
+
+    if (sd_is_spi(sd)) {
+        return sd_r2_s;
+    }
+
+    return sd_req_rca_same(sd, req) ? sd_r1 : sd_r0;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1443,17 +1468,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 13:  /* CMD13:  SEND_STATUS */
-        rca = sd_req_get_rca(sd, req);
-        if (sd->mode != sd_data_transfer_mode) {
-            return sd_invalid_mode_for_cmd(sd, req);
-        }
-        if (!sd_is_spi(sd) && sd->rca != rca) {
-            return sd_r0;
-        }
-
-        return sd_r1;
-
     case 15:  /* CMD15:  GO_INACTIVE_STATE */
         if (sd->mode != sd_data_transfer_mode) {
             return sd_invalid_mode_for_cmd(sd, req);
@@ -2279,6 +2293,7 @@ static const SDProto sd_proto_spi = {
         [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
         [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
         [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
+        [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2308,6 +2323,7 @@ static const SDProto sd_proto_sd = {
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
+        [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


