Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4738EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5iB-0003GY-Uz; Fri, 28 Jun 2024 03:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5i9-0003Am-1D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5i5-0003Q0-Mb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-362f62ae4c5so138207f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558471; x=1720163271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4nsIUIKAxv1jJ77cujJiWISIWdMZfiLK/guukYvkLv0=;
 b=q9vjo1UoOac/xLcjpH3EGY1j3jl2tMm6hQ7yV/a0z0tsooqehb6iVWNWLHVt04D/q9
 SoNvmJrnqFSP810Zo+NCgPK0HkHrJbnU62yqBmqZUPx6eUqwNgrXIN7DowuySIsHSNso
 /LkDnf/ilrmuiWVUtXFlOSbP79FAxhWjILHV9XPUc7qOAVm/r5v2xGUa3ppGinhwzi6A
 RZRAd65fDHT0z1z3vLOR9I8DSilApuhAbcGLbWsMBVdeSGoatiL5UyzPmZPErthjBfeM
 9UB7uZ8tJmPXPz/nSOD1XiL+l1cA56zbCeBskW/3e/2tuPJ4+OlPxLXscJv9H6opOoZu
 7F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558471; x=1720163271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nsIUIKAxv1jJ77cujJiWISIWdMZfiLK/guukYvkLv0=;
 b=d1IjzxomfKwiAXVJX/pOpM5JYE7cXCgSKn9e60D5nC9ZBdlCu9Wpc3CT5/5tIGFKCc
 kLEyWl/7TYRYINr2RI5bs0do4Fu5hd5kUjjnnrIuGSIZkEHgBOaU7hIvZvhFRkB/HjA+
 /zc5bGEGVEG4WPjS0O3jPyWANpFXY7eA1IooKvGRIrzkeVS7zWkZuvVT8AFvGDAfI57v
 y1Dk4IrtpXhkeoJ8/K2ef7i6bt5Z19EVoqLnPlgucTq36oFEJegHHNU8Fe+Tdg1O/xAX
 IDSj01lFE3WVSm3VIv+erIwCO2M/TuBg8b/vgPNunzcc//ptal2qvH0hwwjZ/HpMzmU4
 KurQ==
X-Gm-Message-State: AOJu0YzYvM6GHyfqwGE+RsE8lRXemPiiGld3vYMPywt3ULnGzn/1aXjn
 ZvagwftEMus08RapRKzeOrZ4gpANX8N8tjhPfFfrUcE+FarPyLSD56J46/pHYrmLa85IzPmOIJW
 RlfM=
X-Google-Smtp-Source: AGHT+IEDh1BSE+pOm64AXygsDlqGqoHSVvbNQSoclasLM3MAS/n0XQwUPoG0rpmvzMBlalAzZLuR3A==
X-Received: by 2002:a5d:63d1:0:b0:362:4679:b5a with SMTP id
 ffacd0b85a97d-36760a7832cmr575548f8f.16.1719558471647; 
 Fri, 28 Jun 2024 00:07:51 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd72asm1339592f8f.10.2024.06.28.00.07.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:07:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 53/98] hw/sd/sdcard: Add sd_cmd_SEND_STATUS handler (CMD13)
Date: Fri, 28 Jun 2024 09:01:29 +0200
Message-ID: <20240628070216.92609-54-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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


