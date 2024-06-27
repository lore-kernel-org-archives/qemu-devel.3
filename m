Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBF1C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsEc-00022A-SM; Thu, 27 Jun 2024 12:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEa-0001tH-Nx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEZ-0008Bf-06
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35f06861ae6so6152198f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506669; x=1720111469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRCv4iSMQzY9gbLa0i76FE3UzK8b0j6S+r+3bKGRI48=;
 b=TqIuMSbi+27TP3tS2J2+MoHiRVuBUs/aUGpHwloam7zdQaZRDHx2AVvXcKQg1TgaNo
 UIzXVdi81KwIONCES3WfYNlUBOcWnSMqQOI2VTaJmTKN1B1oJzFphtFf4TL/GlWXok6B
 Dzr8UZsETmncGbnq+vsjhukwVKA8oiAEjuaW34mdao/qzHw1EhEU8tL3TzCLoPHAJpi+
 hYghPeAyNVnyA5LMrnohA22By+qzH+1MoLNOVwAzVZaNBVIPkdfAHrw4cAtLHr8s2Rs4
 1dn0pAFAz2GD3q52krp5ce8pdkeSQIQCfxvwJSESZJ8FT7PUGcrjWfwcQu2J9Y4/kje9
 Kn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506669; x=1720111469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRCv4iSMQzY9gbLa0i76FE3UzK8b0j6S+r+3bKGRI48=;
 b=rppdgoK/gRv1pXU5+FrbwZVaXXi6Nz/0i19MSxnF93m0DjI3F8twqt/iLKLkpY5utU
 S2PNVjsGpRVJHcn2ySBmcaSGOXObrk6A1xUOth2JlD5rbX3UHuBFOLWrpl5HtoKinjpK
 LnryJNKJftax3e0nt0/6zYYJ9767y00yzhQ5zXE4pqQBpYo9zWgTAjgC07N4z+Jy8ZgU
 v9Fi5AvoGFbJtAm/3JhuqP6MsQl0rXL/FvGTaAIWUcmTbzL5/sFjgCEH6anH+babvRjM
 yKVdRrgMlSghVZGxomKSOEURNPWvVicbDMHIIp7ssX7xAZo60NMU7b2N5WdIRwGRM8x9
 sW9Q==
X-Gm-Message-State: AOJu0YxGSVslNd4sOw6pdeGEMHiE0lDmzt6JwzpkJw3EIt/Qpat3NAVr
 MXmvxD0sjfS3WkNanl3Jsl14Ih1JDfKacmupf9nrjYwHiWJjGV1BkKIOkEyksHcunfw19JZTwGG
 hx94=
X-Google-Smtp-Source: AGHT+IGURTpalTnmgQ3zk2gHgGiZScRcjIb5Jomw70YGorp6z7VhZlUHLxMHgofMtedELOUBXw8NKA==
X-Received: by 2002:a5d:59a8:0:b0:365:aad:2f5f with SMTP id
 ffacd0b85a97d-366e9569f3fmr13621867f8f.29.1719506669304; 
 Thu, 27 Jun 2024 09:44:29 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8251dc1sm74315795e9.17.2024.06.27.09.44.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:44:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 04/21] hw/sd/sdcard: Add sd_cmd_SEND_CSD/CID handlers (CMD9 &
 CMD10)
Date: Thu, 27 Jun 2024 18:43:27 +0200
Message-ID: <20240627164345.82192-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/sd/sd.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e2f7e99ea2..bd7c7cf518 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,8 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                             [9]    = "SEND_CSD",
-        [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
@@ -1324,6 +1322,26 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
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
@@ -1393,12 +1411,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -1414,12 +1426,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -2307,6 +2313,8 @@ static const SDProto sd_proto_sd = {
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


