Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D386C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5iW-0004JN-DV; Fri, 28 Jun 2024 03:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iU-00043z-SZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:19 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iS-0004Mr-HS
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:18 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-36743a79dceso862856f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558492; x=1720163292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QJ6b4+TolgSwbj9JxT9jbN1DwNz8KwrcgVlUMC5kG7c=;
 b=yF1LgLycPUkPkjC23NTg/Kw3PQnWYW7TW+raxudZ1SYEGn3wNAaHEh+iFzV6R+vp+x
 /d7k2z/4tWfRycuc+RUO1B9xWQwkomNlMoSmKLX388yjf62H1Tcoq6Kzv1RbsE0b06n/
 NOMWF1AN1LnBvds6W09cNDq/vzO5Ve3nXDpzIK4JjkT2MghI0SW93UXVHqBPm1tM9FEf
 n2ubpn1DL3M8z4aEMafVqGFjsweC/gdHHYvUHsyb8Aqk718CpbRtSTVgtIEDUvOGStUf
 6PnCt3Uuz6HCzkDAtJnc/15fajsIpu+QOCjCtZL2ivkGKjsk9KUwEdg9WRMjCdIEziPT
 1W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558492; x=1720163292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJ6b4+TolgSwbj9JxT9jbN1DwNz8KwrcgVlUMC5kG7c=;
 b=ZOe+ElfUa9dOqiCRicAEhJLIGSuXvL2Nw3wVhYF6aIOJcUeYNDMwhBkR2hspH5gVGC
 am0TcocrR2cmTLp3r/JjSxJTojARSN4OAmHdNauuPxcEVgteG1mDdT7KBfOVWFLv2njP
 81nHlHav9vdFWWf5WWU1WIw25wkVyp0tGNL0gJhxKPtLzn3Pxq9ZPVpLkFoJUiJYbVGE
 dnZzDNiBGkXKEiHe84IQFnHCcuf0daqyjrBfA81gj+vJ1MLPNHFuRI7tRJHnjkqrixr4
 76qZoWGqn9iDcl/DrjyytIU4lw/ugR51dGCgGgINQ3Qni49AgBufYl/KmBQvUh7RRp7Y
 fDCQ==
X-Gm-Message-State: AOJu0YzI70EZXu7r21rOPHvYAh7lN8zWXWpTpCX6L6HrJf/orSC4J5tp
 haRNxl3HmrsRNtemcekVzG+fN8jzWp/5UXx6anSkcg4REttM0gGaYJgGmKcKWDGJ2xWQtJy46Yt
 rHIc=
X-Google-Smtp-Source: AGHT+IE2YnA9q7Pd8hbEuqa1S2LVxssZOxGpDGXypgbY/Lcv710m/dhLwKvKy4MydWO/B1KOh0celg==
X-Received: by 2002:a5d:554b:0:b0:366:ee81:b87c with SMTP id
 ffacd0b85a97d-36760a7dd7cmr624079f8f.15.1719558492192; 
 Fri, 28 Jun 2024 00:08:12 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1030dfsm1320674f8f.100.2024.06.28.00.08.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 57/98] hw/sd/sdcard: Add sd_cmd_WRITE_SINGLE_BLOCK handler
 (CMD24)
Date: Fri, 28 Jun 2024 09:01:33 +0200
Message-ID: <20240628070216.92609-58-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
 hw/sd/sd.c | 57 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e2a7ed8b45..4650d20ee7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -242,7 +242,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
-        [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
+                                            [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
@@ -1487,6 +1487,33 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD24 */
+static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
+{
+    uint64_t addr;
+
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    addr = sd_req_get_address(sd, req);
+    if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr, sd->blk_len)) {
+        return sd_r1;
+    }
+
+    if (sd->size <= SDSC_MAX_CAPACITY) {
+        if (sd_wp_addr(sd, addr)) {
+            sd->card_status |= WP_VIOLATION;
+        }
+    }
+    if (sd->csd[14] & 0x30) {
+        sd->card_status |= WP_VIOLATION;
+    }
+
+    sd->blk_written = 0;
+    return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1544,32 +1571,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     /* Block write commands (Class 4) */
-    case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-
-            if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr,
-                                  sd->blk_len)) {
-                return sd_r1;
-            }
-
-            if (sd->size <= SDSC_MAX_CAPACITY) {
-                if (sd_wp_addr(sd, sd->data_start)) {
-                    sd->card_status |= WP_VIOLATION;
-                }
-            }
-            if (sd->csd[14] & 0x30) {
-                sd->card_status |= WP_VIOLATION;
-            }
-            sd->blk_written = 0;
-            return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
-
-        default:
-            break;
-        }
-        break;
-
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
@@ -2308,6 +2309,7 @@ static const SDProto sd_proto_spi = {
         [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
         [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2344,6 +2346,7 @@ static const SDProto sd_proto_sd = {
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


