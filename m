Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFC1C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZld-0007cq-CY; Tue, 02 Jul 2024 05:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlb-0007X5-MZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlV-0000SU-HR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-365663f51adso2403940f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912331; x=1720517131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8u75s6/EWdwDgm8HUCe5acoVohaEm/dxjOCFeqWaIc=;
 b=Ti3q5STmBqozmz6qOelHkKVFAewkGkscXME5i42wQSmmEuwUxx0j2J5HCKLpUrRFmX
 zur3JGI0sgnoFj5HxMAgBOl8H6Vp7rosDpnAOWC/Ucm71AW2XLWVhv/D4mXNpB+vsj+s
 Zon8RLJtIiB5qpbhi7HlutZlcUsWyR+tP0VV6g+FVKmXOn5LUqZW+IV81HBAqSPeMN0c
 i16D66TKSrHBq920v8ceKrLtpDz7MMD6jguV/gf+S6dPyoCfH2va4GH+nD84XrA54W+m
 SYnPlI51qmEJlFlVdkF+PymO0WVksjth4y8uNQxia5ZLb6+Sis27R1vi9ulyVZCL6t/g
 5G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912331; x=1720517131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8u75s6/EWdwDgm8HUCe5acoVohaEm/dxjOCFeqWaIc=;
 b=asVIcVwod8UfypO/Bu3ayrru89oL0P/2+9sZ93N2KSCb7EGn68Zy1CSB7KWjwQnGZh
 lvBncI1vN4r3kkMN8k9LAGjkvx+jI9Kmepymtc2MANIZHx52CeV6EXHimQyDB1jpOyhm
 trvNGQXbV5asbeOXaVv1oJPkr8KaNPUwoEdj24YhxanrF75FR9WhhrQ7uxWFG9qoypF7
 RTk2zb7OuEt1TlEimEXII/9ZPayfc8ywDUIgKpYRyxw3zjXXQfmv3USgy5j18me7+lL8
 3hx6OtmQogoYTqLlrJVViCgyOdC/O710KA2aCkGQxt/aVLexC8i2uq2t75Af51O2ItsJ
 RT4Q==
X-Gm-Message-State: AOJu0YzYVE8+1YUS063IQO/JftR8cdydk75YMNFAAcYwwzLIIA83rA3V
 TLkBbRWgm/xQAguhw2lMzzgPkuuvo0zj54tplwjbO+D5lw1D9P2KvNsbniFRlVZr971rs3MY7IX
 0
X-Google-Smtp-Source: AGHT+IEMpVIJNhkOERdqcahe+12W9P219x8HUxqmknrIYJyPgHp5xUqUO1GEVGqsL+wJqShpydTP1w==
X-Received: by 2002:a5d:61cf:0:b0:367:31e0:950c with SMTP id
 ffacd0b85a97d-367756bb627mr4769624f8f.37.1719912331568; 
 Tue, 02 Jul 2024 02:25:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd60dsm12680069f8f.2.2024.07.02.02.25.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 47/67] hw/sd/sdcard: Add sd_cmd_SEND_STATUS handler (CMD13)
Date: Tue,  2 Jul 2024 11:20:30 +0200
Message-ID: <20240702092051.45754-48-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
Message-Id: <20240628070216.92609-54-philmd@linaro.org>
---
 hw/sd/sd.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0a554d30a2..426144c659 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                            [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
@@ -1369,6 +1368,32 @@ static sd_rsp_type_t sd_cmd_STOP_TRANSMISSION(SDState *sd, SDRequest req)
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
@@ -1435,17 +1460,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
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
@@ -2281,6 +2295,7 @@ static const SDProto sd_proto_spi = {
         [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
         [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
         [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
+        [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2310,6 +2325,7 @@ static const SDProto sd_proto_sd = {
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
+        [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


