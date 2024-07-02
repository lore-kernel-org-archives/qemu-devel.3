Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E6AC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZm4-0000Ew-Ed; Tue, 02 Jul 2024 05:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZm0-0008UD-IU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZly-00012i-K8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42562fde108so28356865e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912360; x=1720517160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/UKK5N0qGd6voyebxVz2Nr3WQRgwbnXplKwK5vNXYE=;
 b=szd3ELL2cGpIPmqX5hw/lwOqF+fbb4CKnYub3mselaT46ja4t7wmHZNc47uoUqCcTo
 P2+QyfSYJsInW9R75L0QH1RVt0UY9k02gEHr/EWS/1lYcpk1Q4HoMbNzhWjhONXUi/m5
 r4EAHk6I7iY/yAo6zJWgc9y2n3pjd2cq3Sp/ZD7ttx0R/ZVVl5eTBaVQ50TJqhAh+vZq
 T2l682jzNMWuq6N3eAM71SR4XIPEnmreIVnz2G7iaalsmFZc4YqtSluanttfdO+aAK/+
 Fx1L4h9Z6K41Df0vKQ8zd8BKtk16sCZOR1keGn3f1wR0QjtdytRAKp9O1R0nMORNjVQB
 EK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912360; x=1720517160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/UKK5N0qGd6voyebxVz2Nr3WQRgwbnXplKwK5vNXYE=;
 b=HK9oREaMwx8Yr5DoJkTU+QYpPmlGekcOnPPhqRmVoMC5L05gPfKp20/IHfh+YFWsdj
 1icEk3ozzZ8PyYcWETIfIRgNr9T01NHrj9xmoApGdtVKOd4WchoFJF9H7qcx65+x4QHT
 rnCMZIO/R5DkHgwPRG/rCNKS7l0pipe3xB/yVjNlFvMPKMLVQfPAoOOuW53aMntyOMJS
 TVFY9izSIMCUAXrWEYFrWjrjd0xmUB4KK6gSFS0RNcRfpAWzTbgLzPR5EZQt0vnNiZed
 7xr9e2yKAOwwlTwusUeyjwzXz3PGEMTaoG/HsFbPFgZkQhec+/2czk4dp+8+Qsz+nqcT
 R96g==
X-Gm-Message-State: AOJu0Yy8RVDQI+cpf9cdsMv0ZU5z+WZpk+i4P+e2ZeouUR21VgYLr7W/
 QwHOCMHuD+FMzcpRRTnjbXyAd8937EosjoUC7L92GGCF3e119xCoiKP2CSuDb5OWWIGk6CxhIVf
 p
X-Google-Smtp-Source: AGHT+IEuEkTFKY+GsFMfDa2eaJssxS1ajtteMArpwzJzJBnHB3MRwbnfwy8O00Fm5VWiYvcIp9AicA==
X-Received: by 2002:a05:600c:63c8:b0:425:7974:2266 with SMTP id
 5b1f17b1804b1-4257a03a58amr55725555e9.24.1719912360730; 
 Tue, 02 Jul 2024 02:26:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257dee5f2asm100810435e9.22.2024.07.02.02.25.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 52/67] hw/sd/sdcard: Add sd_cmd_PROGRAM_CSD handler (CMD27)
Date: Tue,  2 Jul 2024 11:20:35 +0200
Message-ID: <20240702092051.45754-53-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Message-Id: <20240628070216.92609-59-philmd@linaro.org>
---
 hw/sd/sd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 02a1203691..e1c799c117 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
-        [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
+        [26]    = "MANUF_RSVD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
@@ -1506,6 +1506,12 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 }
 
+/* CMD27 */
+static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1595,9 +1601,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    case 27:  /* CMD27:  PROGRAM_CSD */
-        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
-
     /* Write protection (Class 6) */
     case 28:  /* CMD28:  SET_WRITE_PROT */
         if (sd->size > SDSC_MAX_CAPACITY) {
@@ -2312,6 +2315,7 @@ static const SDProto sd_proto_spi = {
         [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2349,6 +2353,7 @@ static const SDProto sd_proto_sd = {
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


