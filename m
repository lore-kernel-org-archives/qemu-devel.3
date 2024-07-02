Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29386C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZlJ-0005tj-MX; Tue, 02 Jul 2024 05:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlF-0005by-Sl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:17 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlD-0000Hw-Rf
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36786081ac8so217682f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912314; x=1720517114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+3xD1MV1Oqr8vKeJ5znDbygAt0rxvWxpBRrwLtzXO8=;
 b=H+6Tt3s4xAdHftTiPowqHvL7FnsI8x4whdmO2HUzPl736tqYS5+uqkN0CJbOsMYYlc
 kJBJfBZhSzTMMgXitm9k+/rX7m1nsHa2zBmHJdUDkJbFHf/QsuCIMV6PfgVZY2Vp+yEE
 Yos9Qc4f/IpRI2YmCIZow/GSZPDaOpoFgLSKTvP+PVS1trDyum/XbwLIcNaHBHolJNRI
 IblIzjcrhrL1dWikdwycvd7/+TfA/0Mhg/xXgG2fg2CkWhFE1lw0TvSasNRgwTOhe6cx
 geoEkJTcCtZiVKwgv7t6db/gKJca4yd9bANGu904oxyKDd6qp6QL08mR57ZLpRrHOsoU
 /LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912314; x=1720517114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+3xD1MV1Oqr8vKeJ5znDbygAt0rxvWxpBRrwLtzXO8=;
 b=lUuJvSYUUXf5YHnnmK6G4ZyrtPNESh3mEHePrB0UMFA8DjIDB5wQEVJXzxDJaIWNMl
 2Tc1LTLuvxHY+iF4C8GV4KHND3gNaICPm1ktfiBndaCLBVqjDtDJw0dePbYlIxKP79Vv
 PKb7zZSKbEfRuqsNr/6mbGcvAp2Mw3gO8ETsX8GjeHN9T2cRRAkVFfaigOQVF1+y+Uv1
 P0BtkdalUppbKaE/LN9zQMwpoCFNRj+9D9PPdIlz1E6m8nB0etvn8AOh+kP4KR0tKJtl
 Zsz3RSWacPHAbRosQxk3LPvxOmFY51aHl3BnZHoyZ7M3EkjsvRBskrg/6E/veUANQCJ6
 YhiQ==
X-Gm-Message-State: AOJu0YyhLoqFQOfxQ04ROfTZELTYaSFH1+zWeDnzDDu4AKiSr8p0muVo
 SM4WckcksV3NDXUSvgh6AQDTovvUx8V0x/YSsj81OChtI8JQL10ndbear0I0nwrKs3xvjOGo7/m
 9
X-Google-Smtp-Source: AGHT+IHyg+gQTo7k4Gzso6YixN8mZa7IdJEtZ+TWiil2fggGkPGBr9i3qolDSalVcpOHKSEbZXoyFw==
X-Received: by 2002:a5d:5f4e:0:b0:35f:10ac:ea50 with SMTP id
 ffacd0b85a97d-367756cf30amr6092659f8f.37.1719912314122; 
 Tue, 02 Jul 2024 02:25:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9148sm12607592f8f.34.2024.07.02.02.25.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 44/67] hw/sd/sdcard: Add sd_cmd_SEND_CSD/CID handlers (CMD9 &
 CMD10)
Date: Tue,  2 Jul 2024 11:20:27 +0200
Message-ID: <20240702092051.45754-45-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Message-Id: <20240628070216.92609-51-philmd@linaro.org>
---
 hw/sd/sd.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1bde4c9f7f..e372f88073 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,8 +237,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                             [9]    = "SEND_CSD",
-        [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
@@ -1316,6 +1314,26 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
     return sd_r7;
 }
 
+/* CMD9 */
+static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    return sd_req_rca_same(sd, req) ? sd_r2_s : sd_r0;
+}
+
+/* CMD10 */
+static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    return sd_req_rca_same(sd, req) ? sd_r2_i : sd_r0;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1385,12 +1403,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 9:  /* CMD9:   SEND_CSD */
         rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
-        case sd_standby_state:
-            if (sd->rca != rca)
-                return sd_r0;
-
-            return sd_r2_s;
-
         case sd_transfer_state:
             if (!sd_is_spi(sd)) {
                 break;
@@ -1406,12 +1418,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 10:  /* CMD10:  SEND_CID */
         rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
-        case sd_standby_state:
-            if (sd->rca != rca)
-                return sd_r0;
-
-            return sd_r2_i;
-
         case sd_transfer_state:
             if (!sd_is_spi(sd)) {
                 break;
@@ -2309,6 +2315,8 @@ static const SDProto sd_proto_sd = {
         [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [8]  = {0,  sd_bcr,  "SEND_IF_COND", sd_cmd_SEND_IF_COND},
+        [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
+        [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
-- 
2.41.0


