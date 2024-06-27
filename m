Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D5DC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsEQ-0001GZ-Op; Thu, 27 Jun 2024 12:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEJ-0001Ba-KO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEH-000897-5I
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-364cdfdaf91so5711219f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506651; x=1720111451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jc7tRSVNH3DRf6qJ+0mDK79EZ4kJyviqTLrANC5etLY=;
 b=DeROVQRInWWHS2lugoLkHBgCEcdo8VxLNzIP8fbcUBHGX0mZn8n0MklV5MC952HFxf
 23WziK6PVoht1PtNshCyEAweQ5fELKIMySn9O0KBe71MOxTSpZxQx+kh9OuGnMkXEA7u
 5VLyBEGXah8lolFvcSkzxF7jo7hPh9ZiMmnLDBUn9smwpwG6lUOH6B15+3im7IfhH8s2
 mygtQEMg3WE7XtyNzKu0DcqjYXCMAdN41x8jsHzrXxXfFrlJdeR2b3CtPIyB+dSoLrWp
 xb/62Cs7pQa7nlENS8CCjKKvS2efLqu07W65VTg6bNbPCM/Nz+UK1He5mQd+l4fKcExn
 XqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506651; x=1720111451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jc7tRSVNH3DRf6qJ+0mDK79EZ4kJyviqTLrANC5etLY=;
 b=QQa2rIc6Ynd8qYza7gdspEw4RxCtBjZ8D1k0YxCg15V7tABeFV7tDCSQYDp8dMUKd6
 IjgUFKjeYjyiBdcRFTQ0iiLo5o9RFpyvV38Etap/RLHnCT48v3Tz6y9Fsk2fS8lI/xFt
 ZFj1xtv37mt6oeW5V3e2HDGOohuAiigDN604x7ys5eG+d9BXo84e/FBHoNX1n4v9OiPS
 q5v9ieXJn6+jfIccmkMeOjqd4eJbPmOEspob6IQgME/yO53azzPiqEAkIrsXRlcMIHD1
 Ep4jCYTSs95JgBa8SB47WWU0Yr0UzPcN0ewaABrHHaeh7dbfpS84loAYRjjIAKK3CvOS
 Y0iQ==
X-Gm-Message-State: AOJu0YzpgWYlCq8AFx1kjEd5XpVgyFR1yaP0KIsGY8r9kU13lsNgGiDM
 sMEWtQvPvzVOmh01xKqmVHYwRLshw/tGdaVs7zptLMTAhPKEXxl/UH2oKCR52OX8UlFca2cLPMi
 YFjQ=
X-Google-Smtp-Source: AGHT+IGQD55REmzYWv+7IymkGTRx1MyLJbRyZ39xNnWJwQDmwHylYsF13ycPguaANLllCA0d9gjD8g==
X-Received: by 2002:a05:6000:1448:b0:367:4e05:bb7b with SMTP id
 ffacd0b85a97d-3674e05bca5mr1734006f8f.53.1719506651290; 
 Thu, 27 Jun 2024 09:44:11 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36743699ae0sm2370485f8f.66.2024.06.27.09.44.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:44:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 02/21] hw/sd/sdcard: Add sd_cmd_DE/SELECT_CARD handler (CMD7)
Date: Thu, 27 Jun 2024 18:43:25 +0200
Message-ID: <20240627164345.82192-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
 hw/sd/sd.c | 85 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 61c9aff2fb..6ad98db981 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
         [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
@@ -558,6 +557,11 @@ static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
     }
 }
 
+static bool sd_req_rca_same(SDState *s, SDRequest req)
+{
+    return sd_req_get_rca(s, req) == s->rca;
+}
+
 /* Card Status register */
 
 FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
@@ -1258,6 +1262,47 @@ static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
     return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
 }
 
+/* CMD7 */
+static sd_rsp_type_t sd_cmd_DE_SELECT_CARD(SDState *sd, SDRequest req)
+{
+    bool same_rca = sd_req_rca_same(sd, req);
+
+    switch (sd->state) {
+    case sd_standby_state:
+        if (!same_rca) {
+            return sd_r0;
+        }
+        sd->state = sd_transfer_state;
+        return sd_r1b;
+
+    case sd_transfer_state:
+    case sd_sendingdata_state:
+        if (same_rca) {
+            break;
+        }
+        sd->state = sd_standby_state;
+        return sd_r1b;
+
+    case sd_disconnect_state:
+        if (!same_rca) {
+            return sd_r0;
+        }
+        sd->state = sd_programming_state;
+        return sd_r1b;
+
+    case sd_programming_state:
+        if (same_rca) {
+            break;
+        }
+        sd->state = sd_disconnect_state;
+        return sd_r1b;
+
+    default:
+        break;
+    }
+    return sd_invalid_state_for_cmd(sd, req);
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1324,43 +1369,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 7:  /* CMD7:   SELECT/DESELECT_CARD */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->state) {
-        case sd_standby_state:
-            if (sd->rca != rca)
-                return sd_r0;
-
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        case sd_transfer_state:
-        case sd_sendingdata_state:
-            if (sd->rca == rca)
-                break;
-
-            sd->state = sd_standby_state;
-            return sd_r1b;
-
-        case sd_disconnect_state:
-            if (sd->rca != rca)
-                return sd_r0;
-
-            sd->state = sd_programming_state;
-            return sd_r1b;
-
-        case sd_programming_state:
-            if (sd->rca == rca)
-                break;
-
-            sd->state = sd_disconnect_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
     case 8:  /* CMD8:   SEND_IF_COND */
         if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
             break;
@@ -2293,6 +2301,7 @@ static const SDProto sd_proto_sd = {
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
+        [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
-- 
2.41.0


