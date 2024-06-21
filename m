Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83038C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZJ0-0007xV-1x; Fri, 21 Jun 2024 04:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIx-0007rj-IY
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIv-0008V2-Jz
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-354b722fe81so1221535f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957248; x=1719562048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BD5fgdTJlgw33/dLpV9SeOJ7ak0nlluyPy+d+qp00Qk=;
 b=hM3GHUMJ9PdoqSZD++4sL3kv6mxU3qSv0iZiqa3INmwKsYMdCHvN/K6c7MvpIPVBDy
 vO9ZAAHpnPH9CcYlKCP8VUBv1sq7uKFyIr96PqMW50DOxLHcsM+RUVxUcAWGp0Sy5mdb
 K8Mm5omdnTwou4K3/s193qRye9mfh0pk5uq9Cidxi5yyYS1uunVdJnVyWpl4x1zzJsLg
 SRJc0TRuP/k1WQPxs3IKkYuRvsLJjkTO/EWEiQ7X1V5SwnJquAodYZH+ps1nBY9L0NOe
 xc40+OksW3OHR8oNQSwVu8e4w6qDL9VnN+OppJvGnM7q5U0aZr+byLCsAnxQCR64NnLM
 XiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957248; x=1719562048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BD5fgdTJlgw33/dLpV9SeOJ7ak0nlluyPy+d+qp00Qk=;
 b=kMEsyuizBOXW9OKZMcumpPR8RkMVNysStaW0usTuXZDSrI5Ijtcoe0efy9QOIoXgC3
 sNdfWimCEwfdjNfwWF+3jU08nDPVAqNCRuSf++hxlouFh+gCmt/LnqtRmDzBDHTHcQyI
 yl15KaJ1zc1OVji1Y78SVOREcYZ1XZ9Ic8V7HRSrV4vB4qwY8AYS0hAJowRMDKn6xkv4
 5YWqhRI7NABP3z8LY3FT3X6oe2egLevQE9F6pXgrz7DcvYHJRV1CQmf+l/6MSZQYnmPE
 2HltKiReaTqiIxSn2GfdEeix5EUUcn4/1tjMoAf2eb5j3zWnTYlWZvoGGgAsXNrmgLRW
 aKOw==
X-Gm-Message-State: AOJu0YxUDgo35+NrxzfoZYCM01tIwetryDY9hHAvHz1YYmdpIon0J0y3
 YeW+CfLys3n6mwJSON2dpuP5pdlS5oaP+LlLFMmagmCxQ1IPLSlMN8TZqaze9RS1eDJXz4wwPQi
 a
X-Google-Smtp-Source: AGHT+IGs1dUHmkoTFTraeGbYeE5Zge/cXEHuVGEngA0g1QEe1p9s5TZgeMuTVov03vxwy/TJtm0jaQ==
X-Received: by 2002:adf:f04e:0:b0:35f:10cf:6068 with SMTP id
 ffacd0b85a97d-363178984bdmr5650663f8f.27.1718957247616; 
 Fri, 21 Jun 2024 01:07:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c7c6esm966353f8f.103.2024.06.21.01.07.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 15/23] hw/sd/sdcard: Only call sd_req_get_rca() where RCA is
 used
Date: Fri, 21 Jun 2024 10:05:46 +0200
Message-ID: <20240621080554.18986-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It will be useful later to assert only AC commands
(Addressed point-to-point Commands, defined as the
'sd_ac' enum) extract the RCA value from the command
argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bc47ae36bc..cb9d85bb11 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1102,7 +1102,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
-    uint16_t rca = sd_req_get_rca(sd, req);
+    uint16_t rca;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
     sd->last_cmd_name = sd_cmd_name(req.cmd);
@@ -1160,6 +1160,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
         case sd_standby_state:
             if (sd->rca != rca)
@@ -1214,6 +1215,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_r7;
 
     case 9:  /* CMD9:   SEND_CSD */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
         case sd_standby_state:
             if (sd->rca != rca)
@@ -1237,6 +1239,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 10:  /* CMD10:  SEND_CID */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
         case sd_standby_state:
             if (sd->rca != rca)
@@ -1277,6 +1280,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 13:  /* CMD13:  SEND_STATUS */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->mode) {
         case sd_data_transfer_mode:
             if (!sd_is_spi(sd) && sd->rca != rca) {
@@ -1291,6 +1295,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 15:  /* CMD15:  GO_INACTIVE_STATE */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->mode) {
         case sd_data_transfer_mode:
             if (sd->rca != rca)
@@ -1523,6 +1528,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
         case sd_ready_state:
         case sd_identification_state:
-- 
2.41.0


