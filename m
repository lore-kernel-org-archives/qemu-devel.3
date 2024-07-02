Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2DEC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZkN-0003Do-3L; Tue, 02 Jul 2024 05:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZk9-000300-Jg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:11 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZk7-0007zq-Sc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:09 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ec1ac1aed2so46136821fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912244; x=1720517044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kI14nFtkmVuLlf2mzl5p+7UiBT46U4YhEycE/q3yJNg=;
 b=WYLbpYjVP3MPqj7HcQuYGd6E9nuBdcqLXrbVOrWUJ2o3uuUS1yxoaoAAaihL6ckaBy
 0llCqb0rDxIMyCX1SY51ZLRKwwKwdxe8GHa/wzZD+ZpaJpOdIMJ4bkUmmtmExmlKe22u
 Zbu151gd3xb9Ek8Z2dyhWN7QHyKuRdEjIB369Qyp9OfDBdg8b2xvTSb2Li2kuwXWaEby
 CYuwcfpQE+qkr2NkFMdZ86bE++/A+ijl1tWvlwguFKP0MqiHN7Ryzo5rUa0O60f0CtHT
 kZwhk9kyR88vl/DkQFZwwDFpEIv3ZVEYAgMAh8+n9fODEONnI0qdzodXHRhWZY5spJ1C
 4CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912244; x=1720517044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kI14nFtkmVuLlf2mzl5p+7UiBT46U4YhEycE/q3yJNg=;
 b=AUodriWVxWqk8CVeVzDqQL/a3exEZpXPQdWrgeqhF+XEyRtiwBv7jSrFFoDLU+ZgLR
 7OcWKJToXT5iWuDkKS3djPuN7f3JMwIdHk85KA/rnLN73/ypGfz9L8z+X9KZJZTBpzPC
 NaPq6KHYvS5bJPyhYsDbNCqshKZNQeeV56q8eAZxrY04qAL1Z6BWHRLdOcLmnx2vOX+h
 UAs0kuqeWNUzkfs6IrrZjnygVarJM6KOyWtCm+v0h4LHNev9cl9h3N5elaWg8valO2RD
 6URR7vYnkvNg0nXnfLh9Kes39tjUXrjjwDtrbKF9yWYhYWDPAkMeQuPtpXtpJGLtNbxa
 FNwA==
X-Gm-Message-State: AOJu0Ywk5js3x35Cg7NBFDDfiwyRqy14EoAJZt49I8wtlx3WwwsRq0pN
 MbNsMc64dntQHAL/WgO7E/oB4IJ1hKLZruFFuPhFwb/ojQfPQiuOfp51nUsdfMgEgXsSyx9vdWN
 X
X-Google-Smtp-Source: AGHT+IHu7MCC2sXjyjB8GzH1+Yq1QSSBOOgFtATuG3kI63+roFHZD0hExAfHlZWtyBObQWf0GQxkBQ==
X-Received: by 2002:a2e:6817:0:b0:2ec:514f:89b3 with SMTP id
 38308e7fff4ca-2ee5e3b37b2mr51963261fa.28.1719912243896; 
 Tue, 02 Jul 2024 02:24:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09aa32sm189836575e9.34.2024.07.02.02.24.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:24:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 32/67] hw/sd/sdcard: Prepare SDProto to contain more fields
Date: Tue,  2 Jul 2024 11:20:15 +0200
Message-ID: <20240702092051.45754-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Convert array of command handlers to array of structures.
The structure contains the command handler. No logical
change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-39-philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5b356f0be8..fb82bc9aa3 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -93,8 +93,9 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
 
 typedef struct SDProto {
     const char *name;
-    sd_cmd_handler cmd[SDMMC_CMD_MAX];
-    sd_cmd_handler acmd[SDMMC_CMD_MAX];
+    struct {
+        sd_cmd_handler handler;
+    } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
 } SDProto;
 
 struct SDState {
@@ -1297,8 +1298,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_illegal;
     }
 
-    if (sd->proto->cmd[req.cmd]) {
-        return sd->proto->cmd[req.cmd](sd, req);
+    if (sd->proto->cmd[req.cmd].handler) {
+        return sd->proto->cmd[req.cmd].handler(sd, req);
     }
 
     switch (req.cmd) {
@@ -1745,8 +1746,8 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
-    if (sd->proto->acmd[req.cmd]) {
-        return sd->proto->acmd[req.cmd](sd, req);
+    if (sd->proto->acmd[req.cmd].handler) {
+        return sd->proto->acmd[req.cmd].handler(sd, req);
     }
 
     switch (req.cmd) {
@@ -2269,22 +2270,22 @@ void sd_enable(SDState *sd, bool enable)
 static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
-        [0]         = sd_cmd_GO_IDLE_STATE,
-        [1]         = spi_cmd_SEND_OP_COND,
+        [0]  = {sd_cmd_GO_IDLE_STATE},
+        [1]  = {spi_cmd_SEND_OP_COND},
     },
     .acmd = {
-        [41]        = spi_cmd_SEND_OP_COND,
+        [41] = {spi_cmd_SEND_OP_COND},
     },
 };
 
 static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
-        [0]         = sd_cmd_GO_IDLE_STATE,
-        [2]         = sd_cmd_ALL_SEND_CID,
-        [3]         = sd_cmd_SEND_RELATIVE_ADDR,
-        [19]        = sd_cmd_SEND_TUNING_BLOCK,
-        [23]        = sd_cmd_SET_BLOCK_COUNT,
+        [0]  = {sd_cmd_GO_IDLE_STATE},
+        [2]  = {sd_cmd_ALL_SEND_CID},
+        [3]  = {sd_cmd_SEND_RELATIVE_ADDR},
+        [19] = {sd_cmd_SEND_TUNING_BLOCK},
+        [23] = {sd_cmd_SET_BLOCK_COUNT},
     },
 };
 
-- 
2.41.0


