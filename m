Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473F9C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsGT-0005zi-JG; Thu, 27 Jun 2024 12:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFw-0005X4-Jj
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:02 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFt-0000CX-Ik
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:56 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52e764bb3fbso666207e87.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506747; x=1720111547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e77sqfrLYi9SLwpkQhHOa0XqG0+lUrwsgw9mW5fMvkQ=;
 b=ggc2P4u3IjOoU4JlTkRifQ4Sm+phW9ER/OujPh5fOZJ8420FMX/nWeG+XikkPn/0D4
 0Dx/XOhatIb/JVd9Qc6L+qETZseyIz6pD/ArDdXOt4S0FDrSAZFA1ZR5nRCYd+KATf8c
 L5RPxx/CkLUJUEkKHImaTc5gaiNm29n61ZbwCUCHVLLB219W2kvuvtxv+3EKT/Q33HMq
 A9k9TCnQTUEoj8J1FZtxH2XOBatn5lUomEFroBoEa11alDAgd5YYZde8XdqixIpH0JJu
 9GA02bM6vYEMINMh9d7Skvlzj+3yzHa+InZliHghCI7DpXJBfZ/boMIE+qLA3a0/dYOF
 95rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506747; x=1720111547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e77sqfrLYi9SLwpkQhHOa0XqG0+lUrwsgw9mW5fMvkQ=;
 b=OjBVkggICJIueJYDMggihbIGTaxygjliZfuwFQN4hLO7YRDCxXKcRo6VgQWOuXblZH
 uvf5z6efiPK0qJRTQSA0s+yixtkns3co/EpeTdCGQtjTAQEELpKeIVY6pot2wyN/ZC4A
 jsVGYvG7WSPHs3bHZF6DwNeFnvF28x0kP2YR3ONbI3b4T9otvO8tgTt+3eCUChpyz2sb
 h4/CFEcwlDX6pjTi7r7TSxY372Mi3FbnHa0uvWnVqKR5aOhJhz6qSLS9Mf+9JoKYqBww
 SqO5EkqoGPKf/+Janir/ZqwqGKgv87cUH5TTiSamSzDSUoUWT5B12vQya1rf8AJLBLOW
 r0ug==
X-Gm-Message-State: AOJu0YzJ28tccxrFQBlaEcoxlGTG8GJ7JxiEQ4sgJM6Qk++eYFJMM+CG
 UMu9N18XUpdmZxKpNEK52K3cfmniF/XqJtDQ72tEMx3Wu5HsouUTAuzpQ5hP9GmSkcJeIEhOpSW
 wYAs=
X-Google-Smtp-Source: AGHT+IHTnYCAfH2gNGtq0Tnnwhf5aI2xB7gln1vrqJ/79CVpeaFepuwA45inXRvwNjoII3lJR63KKg==
X-Received: by 2002:a05:6512:3e24:b0:52c:dff5:8087 with SMTP id
 2adb3069b0e04-52ce185f998mr10762836e87.51.1719506746977; 
 Thu, 27 Jun 2024 09:45:46 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c842468dsm76663905e9.36.2024.06.27.09.45.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:45:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 12/21] hw/sd/sdcard: Add sd_cmd_PROGRAM_CSD handler (CMD27)
Date: Thu, 27 Jun 2024 18:43:35 +0200
Message-ID: <20240627164345.82192-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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
 hw/sd/sd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4650d20ee7..9d33113f11 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -243,7 +243,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
-        [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
+        [26]    = "MANUF_RSVD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
@@ -1514,6 +1514,12 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
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
@@ -1603,9 +1609,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    case 27:  /* CMD27:  PROGRAM_CSD */
-        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
-
     /* Write protection (Class 6) */
     case 28:  /* CMD28:  SET_WRITE_PROT */
         if (sd->size > SDSC_MAX_CAPACITY) {
@@ -2310,6 +2313,7 @@ static const SDProto sd_proto_spi = {
         [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2347,6 +2351,7 @@ static const SDProto sd_proto_sd = {
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


