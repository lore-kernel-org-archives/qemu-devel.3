Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C03C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZlB-0004qu-2L; Tue, 02 Jul 2024 05:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZl5-0004Um-Jm
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZl2-0000Ef-KF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-366e70d0330so2486945f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912302; x=1720517102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zo/bpULpmegEUncNLm6vCJ+QfqrrZDPASrwEVg/COu8=;
 b=aJ2g79RxCsa1dDDOqTWfJ61gH3zda79vXbSDY6xigtVDNR55JTIrxLHQfyPrZc0VYA
 7KgQrJfqw63Hc707nkg6g7a9XNMX7O6z1ZaQcrFkjnfrNhRkeEKSEOAZ5wlGTZe+UHU9
 lFh8IHYYy9/VrPWzBZS87qp7PQfb6Whlxng0+uI6jdNc4dprGjh/DE9eswzgFJObSYLO
 kBVKecHeXCLiBWNnmMSFG3sBjJVSgKm4JdDS6uhrtmlHKkjhZFvGFB2JzXPRKRfHw4a2
 qBz3HtZrcawZG1R/ve+psI6dW4uVvIWayXzvfZ46yuD778AeaN1UuUEURpB2v4pAPYXn
 1ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912302; x=1720517102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zo/bpULpmegEUncNLm6vCJ+QfqrrZDPASrwEVg/COu8=;
 b=qtV21RWrtf+S2/nneM1SHUdija29TZJjI49humYJFdD+iM5Lb0pxqtG7ycF2VK7C+c
 u3cY5XcNmFhOKBQRzUHxIy7fgdfbkvcCed/Yurb09Hf/RnYL7qIYnpqVTWY1c2kO2V3u
 sx5BOtl/MbXkcFtE8c/mvZyc1ohvOGSbzhWZPL9LKiWdJ/YCD5dOmKnUgWPgQYD4f/kT
 PkyrQyTYykD8sc+Oa3Lb/eCvE+zHSj+vKsx37qsSoHpN0GnqUnExXXV6Ehx4KuRQUZtu
 90Viq9SeDy9y3T+UBwV7mXo7gLgf3+Dyol+or5WaxmBlR4b0TKg7SYrCJ1XCFNtESw9O
 fM2Q==
X-Gm-Message-State: AOJu0Yx+P6s+ocOEOFpXUS2kLEZfPI2v3qq6otstqy/EvMacXF3L6zju
 mDN8kZUQZ1WSLQQnov8mIFb/PqtbDu+iek0hIYZgmK/76bJMxxI2WyLq583CQF0NURDSxOHelaT
 b
X-Google-Smtp-Source: AGHT+IFF4Lmherb6wypgMxaSxmALyoC2BPIoYQD15lNxfSxvf5wP7rwoP8iyzTAv29AXBNuk6x3I9Q==
X-Received: by 2002:a05:6000:18a1:b0:366:ebf5:c6cc with SMTP id
 ffacd0b85a97d-367757214e0mr5316534f8f.50.1719912302643; 
 Tue, 02 Jul 2024 02:25:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc4c9sm12636424f8f.86.2024.07.02.02.25.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 42/67] hw/sd/sdcard: Add sd_cmd_DE/SELECT_CARD handler (CMD7)
Date: Tue,  2 Jul 2024 11:20:25 +0200
Message-ID: <20240702092051.45754-43-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-Id: <20240628070216.92609-49-philmd@linaro.org>
---
 hw/sd/sd.c | 85 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5aa63f732f..f83ae4ed18 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
         [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
@@ -554,6 +553,11 @@ static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
     }
 }
 
+static bool sd_req_rca_same(SDState *s, SDRequest req)
+{
+    return sd_req_get_rca(s, req) == s->rca;
+}
+
 /* Card Status register */
 
 FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
@@ -1250,6 +1254,47 @@ static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
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
@@ -1316,43 +1361,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
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
@@ -2295,6 +2303,7 @@ static const SDProto sd_proto_sd = {
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
+        [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
-- 
2.41.0


