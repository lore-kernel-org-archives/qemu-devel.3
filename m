Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C587C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jq-0006w2-Bk; Fri, 28 Jun 2024 03:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jP-0006SE-R2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:15 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jL-0004Uu-1K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-361785bfa71so247274f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558548; x=1720163348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Ij5pjsDB8qqEoSZ8JFKxxVUAdb9cjcc9vXzXqWT+4A=;
 b=YSSVVsps4rooW9wzr5BbqAvhACRp0P1t+yaSXQ3Nd3/81wSKPNRZxWfpu59wFWn0K5
 St9FUU/AWUs4/LHA//LcI3yQ/Jo34ZB+S/JsKtBTtd8bif7jHkjUmKuEaRLkzdhKeryc
 CsUkvMeuf3HoHQutknPmmITcDQEcQMrMgMc2pOVAlw9E3m6LtmzfgO33gUdca4CVxYw6
 xfXpo+fU3yW0jCaI33JhHXDGfD6XZi5IanXcYod5hNR0oyX9TuIQ8BthOdsoJ8geAP6J
 eVTq1goAti3MJa3z13CTxmieGvzqFQ38oN9kUuTT9n43VRyTSH+uIa5mc2+x1OjAU74P
 mP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558548; x=1720163348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Ij5pjsDB8qqEoSZ8JFKxxVUAdb9cjcc9vXzXqWT+4A=;
 b=iti1GxJYxBVM3Wx1z0kjQg6tCjTirag2HNMya9a9Wn4j2e0iv/e0DKwGFa0YPfY9qx
 0tadRcG8zo5/qABlaDDs2GaZMtjWH7UoJI8QbVKDevPc2IAtFWgoLxjOLxE52UcUD905
 s2vqGSFTjVe6VyuA2gMs7m/rLRQ/tj8D9s8JhVfrUUJdZLkZfJYkp3VlTkMm7P7rxhFK
 Hj08nl0F6YyZeLcrP1cOT5z/BJ0hiKjHrMDCO0cSjPnUw+GDKcWyetzjlLBqvvH5yJmO
 Kzu32F3meFZ7uESmceKZldoThysJeEgaGFyzHqr06IK2rEj4hO6gdccQ5QJ7S2Cb4pts
 Fk4Q==
X-Gm-Message-State: AOJu0YyFh2f5I3Y0Rg7nIuCqlDV254dEGv4cQDWNNcaCHlBE/wG+TPkB
 m9ovOBOZrS8zAm0PWrjzlZcqNSSO7KR8sF6ASR4gVXuhBtjG0X3PbNhwIIL+6S0mQyVNyr+iC29
 sMH0=
X-Google-Smtp-Source: AGHT+IHKgTDR1NXoZ/WXzwyiUiJ/6c+4yGUauxFibBnZbPLRb2QZ/rBkMbxpY9P9fpLlCH2ZBntNTA==
X-Received: by 2002:adf:ec49:0:b0:367:4dbb:ed4e with SMTP id
 ffacd0b85a97d-3674dbbee7bmr2581759f8f.0.1719558548547; 
 Fri, 28 Jun 2024 00:09:08 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d18sm1326195f8f.106.2024.06.28.00.09.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 68/98] hw/sd/sdcard: Add sd_acmd_SET_BUS_WIDTH handler
 (ACMD6)
Date: Fri, 28 Jun 2024 09:01:44 +0200
Message-ID: <20240628070216.92609-69-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
 hw/sd/sd.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2f853a89d1..0310a5a3a1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -260,7 +260,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
-         [6] = "SET_BUS_WIDTH",
         [13] = "SD_STATUS",
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
@@ -1672,6 +1671,18 @@ static sd_rsp_type_t spi_cmd_CRC_ON_OFF(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD6 */
+static sd_rsp_type_t sd_acmd_SET_BUS_WIDTH(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd->sd_status[0] &= 0x3f;
+    sd->sd_status[0] |= (req.arg & 0x03) << 6;
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1780,18 +1791,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 6:  /* ACMD6:  SET_BUS_WIDTH */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->sd_status[0] &= 0x3f;
-            sd->sd_status[0] |= (req.arg & 0x03) << 6;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 13:  /* ACMD13: SD_STATUS */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2385,6 +2384,9 @@ static const SDProto sd_proto_sd = {
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
+    .acmd = {
+        [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
+    },
 };
 
 static void sd_instance_init(Object *obj)
-- 
2.41.0


