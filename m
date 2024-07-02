Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37771C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZl7-0004X1-2U; Tue, 02 Jul 2024 05:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZky-0004QZ-7h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkw-0000Dj-Do
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42574064b16so24385845e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912297; x=1720517097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LarMpzFABrHElvj3cOvSN3U3cpCJlLI7z8esfggSjk=;
 b=OrGmEDNd822MH6A7DGmq8OKRX75lhOREqiRvseth7JjbMsaN6dXhEhcJKqEnxUPHPt
 HLURdfR1fFdmPSVVcgYgLdGXmljuJcRcQD3Emi+WGooCDBMrl0LSKANG3+ZWMbl7PxFA
 COksc+ly9ZswI5zNSPBpb015tUxf1EXA+EmCeLPr8n9Dg8IomEUCrKYsrufLwuJ4Aar+
 70R+zr68ym9t+kv1ghf0nJ9/lW/xK1SPBjaRB7bLkSFvaO7nlVQieaekpa35rO7LWGqa
 /XbvrcL+clCqbbf079NLt9WGogu4gmwj66xgJMQAMQKmm78kY6txpvCGIc9lh61mb+ph
 p97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912297; x=1720517097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LarMpzFABrHElvj3cOvSN3U3cpCJlLI7z8esfggSjk=;
 b=nVcsVzqaFudC7Auimu2ZQnYa6Fj5ciMrwcBOUATIFm4zvNGfE4/4ZvtHefIdMesCol
 ZL4MOn/K6R8FE6r6s5X9P1nHQuLx2Y3SRGWFRoKYmw0X/zmJnGAvCfh3Ea8GiWbo7yzd
 eZM5IiJEi9L/GAbv0eAsb6YfTeLepXfINS453NAGSoapDsmIeTgWXlX1e8/7HJYzVx59
 FqiIZW54hfohxCbPpdQj+ZUWsajeZu9CemgRbRAzRSM1xyH8Ydlr6CzClGfcrzt6e25c
 gH/kX79qzy7fpFHmVfcWFO6klK43KYn9LbdRz+8xsp0Dxi1Si03KyKRxo654b1BwzzcY
 +DUw==
X-Gm-Message-State: AOJu0YzGX9e4fP9oJ88O/H3HIwM6iglmTRgRH2sNaoQv4YS0xRGWGFE5
 QyhJE10WfGekbQKeVXIC0yL3/WQFXbxuDbF2/cvD14YSHhrEQhTygHohOu3depVm4kaFIc9quip
 g
X-Google-Smtp-Source: AGHT+IEUXztbBcGE0JhzTpba+nC9tjJkmtWNOharmNNmU3m/AD+xUCngFmVFG58S+E5PcKmdNVmCIg==
X-Received: by 2002:a05:600c:4814:b0:425:7693:3a38 with SMTP id
 5b1f17b1804b1-4257a074b37mr57811185e9.36.1719912296856; 
 Tue, 02 Jul 2024 02:24:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af59732sm190276995e9.11.2024.07.02.02.24.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:24:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 41/67] hw/sd/sdcard: Add sd_cmd_SWITCH_FUNCTION handler (CMD6)
Date: Tue,  2 Jul 2024 11:20:24 +0200
Message-ID: <20240702092051.45754-42-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-48-philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 54b9ec72e4..5aa63f732f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
+                                             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
         [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
@@ -1236,6 +1236,20 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD6 */
+static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
+{
+    if (sd->mode != sd_data_transfer_mode) {
+        return sd_invalid_mode_for_cmd(sd, req);
+    }
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd_function_switch(sd, req.arg);
+    return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1302,17 +1316,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 6:  /* CMD6:   SWITCH_FUNCTION */
-        if (sd->mode != sd_data_transfer_mode) {
-            return sd_invalid_mode_for_cmd(sd, req);
-        }
-        if (sd->state != sd_transfer_state) {
-            return sd_invalid_state_for_cmd(sd, req);
-        }
-
-        sd_function_switch(sd, req.arg);
-        return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
-
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
         rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
@@ -2268,6 +2271,7 @@ static const SDProto sd_proto_spi = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
+        [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2290,6 +2294,7 @@ static const SDProto sd_proto_sd = {
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
+        [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
-- 
2.41.0


