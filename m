Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A606EC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5hG-0005zv-Mp; Fri, 28 Jun 2024 03:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5hE-0005uM-5E
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5hC-0003LW-A5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-364cdfdaf91so199383f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558416; x=1720163216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jc7tRSVNH3DRf6qJ+0mDK79EZ4kJyviqTLrANC5etLY=;
 b=CLZ7MwrVsWTKgGY6+qcJodqzdaDfOrC3SoeSH5q9SjpkIGwYx1oHNsoGmIWpSyxH3V
 O4WxF7Tsd6v7RH5KgqSE0mzDx/6rGjuzpD5h+eSt6jaZLgrc6AW8N6baVVkJd8k/0/IG
 N52rtPRacRomG+C/CHWPwN8YvtEXJejn3Wis7KQ2geGNDC1luD3EBgla8tdU8SYiSWsH
 Q6PQnC/1Z/hhEW3VRT+WAWr5jyLChII/4nYL/zYwgW7tORHn37NOmrrVgw1pNyAbHm2y
 IYdXSrTAsyG2XAhsiSH1HIhQ4oCXYTAybyeWgcLi9jyV47obTcdWwwHObvLv1+3v7KP7
 ajog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558416; x=1720163216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jc7tRSVNH3DRf6qJ+0mDK79EZ4kJyviqTLrANC5etLY=;
 b=XwWLO221NPqHqqV5uxeQshUzejDqpd7xmEkwyh91KjVfsOX/Pypx9c8JrzqmmTXtCx
 U8QTu2h/VHKlz94KwcJg60N3sdrNekmvDECQmI2liW4VNICLmX4XgoIs15oKftawUTKE
 Q3Mu9p0/XjyTqL47qggNunn0QJM80IjYXz4yd+HPdFZUbrCxxKaDsKpDOiHAWLXTo+hD
 tkXtY1BxeMHf65K/63w5fYGLtOeHH6E510yWvMSBRBhlTkYJUUkijAtZxZ/w+DryBNEo
 Gv0D9UUeuGAktB1XbnKu5cGOasoNCw+Rz1b6pNzmFLbXztOgSfX3uNlScz4epqz75Sk/
 6zLQ==
X-Gm-Message-State: AOJu0Yx/YUHxXApWnEzy7fln4JWOajjAgLHzyDy1srMNtan0umeXSPeM
 mTstBEPZhrx0kLZsGwSA2k9fi0VGKBorhRm1sudRRRcftxaQt53n4B8MT6Q0x+V53O85loGv9v6
 tOi0=
X-Google-Smtp-Source: AGHT+IGr7U8zQUy6BNOqTGAr1kC2P8tYcsD5sBulbzK8KIX218a2+URteH1/G2YswZkLc69lXOEKlQ==
X-Received: by 2002:a5d:43c7:0:b0:362:a5b2:b62a with SMTP id
 ffacd0b85a97d-366e9573b02mr8500792f8f.33.1719558416294; 
 Fri, 28 Jun 2024 00:06:56 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba2dsm1335705f8f.73.2024.06.28.00.06.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 48/98] hw/sd/sdcard: Add sd_cmd_DE/SELECT_CARD handler
 (CMD7)
Date: Fri, 28 Jun 2024 09:01:24 +0200
Message-ID: <20240628070216.92609-49-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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


