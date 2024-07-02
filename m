Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE1DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZk5-0002l4-LA; Tue, 02 Jul 2024 05:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZk2-0002cV-Qg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:02 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZk0-0007yl-34
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36743a79dceso2868045f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912238; x=1720517038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEAedVXIwS3IcpAZnKMoyPFq95SaykgChyIuzbCP5sU=;
 b=mFfZmIcRb182k8XU2MSD4LLGk+E4VaawF8OEu/5/h7z6fUbUTK0griavI9r17YJnR6
 xaw9J74svIT9mOCRLs5YLJa/B3MEtO2UcXEikjMXHHE8BraZR6w2TdN7Mcw8wFDaiJDW
 fszF3KyMzbPBDj57kSASVB6jKGDJNLaecCOy93M45QREhb0veIAAekNgTxx95eDoFCBT
 Qs9NFjKcCiBSQQQMdhi+qFUGszAYqp+Zui2zVe0bAh2VexlZQUsetDia3p1oW+UQ4eSF
 PNcQOOG+OhBZbnhpN4YQRs3hHYj8eF4Br3+DK+ceGuDQ/oMglsxkFN9AyC/fp/QKhnM3
 qjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912238; x=1720517038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEAedVXIwS3IcpAZnKMoyPFq95SaykgChyIuzbCP5sU=;
 b=O8GgkFqAl2OoxndHS4qIWxDTKdCElPDOZBorJu9oiecMFDdccjRKkhEalkToF2eSQx
 6fFtiphIcRbKe3jwG3iaDrDbfjA48AboP591gWXfbeoKH5HAFvHRqiSal/745TCtJFNO
 +3xKTh65CF2ScYQVlImjIRQ7ZIlnDD2Yjv+X+LAgZ/3J0XF4itDZoqR/1/HPQ7czONnB
 aVbWG0AAlS4D8RCsWK0IhG0zGrOJgta3U9Q4KCzu9xzEy26ZvJFO1sPG6q7xX3FI5f6L
 sifK3MQA0UBR/OIsoqP4NRn17Sld/OursP1VFeMdJzm9I8AWxdgLiGcKRE05usm3QM4y
 3vXg==
X-Gm-Message-State: AOJu0Yx9s7Y/eIaXnDMWOomyCt3oqBK982aG2fk4uG7zbwESCEixpNed
 laHDW2rZHiOpHeptjnMMzAREG9ZkkFQ4UJUWVHOY5hyCeopEakG39raaPmFvtTie/NA6wmJqd9z
 /
X-Google-Smtp-Source: AGHT+IGgBGHiqgKP1vhnRXRsamuG8T3I55KSZDSFwaWSovBXdIvQaF+YLMUtohvSIxpRzgcI4AJSqQ==
X-Received: by 2002:a05:6000:154e:b0:367:42ce:f004 with SMTP id
 ffacd0b85a97d-36760aa2ec0mr11625731f8f.23.1719912238218; 
 Tue, 02 Jul 2024 02:23:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8daasm12555614f8f.30.2024.07.02.02.23.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:23:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/67] hw/sd/sdcard: Pass SDState as argument to
 sd_[a]cmd_name()
Date: Tue,  2 Jul 2024 11:20:14 +0200
Message-ID: <20240702092051.45754-32-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

In order to access SDState::SDProto from sd_[a]cmd_name(),
pass SDState as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-38-philmd@linaro.org>
---
 hw/sd/sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 90bb47ad26..5b356f0be8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -230,7 +230,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
     return response_name[rsp];
 }
 
-static const char *sd_cmd_name(uint8_t cmd)
+static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
          [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
@@ -269,7 +269,7 @@ static const char *sd_cmd_name(uint8_t cmd)
     return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
 }
 
-static const char *sd_acmd_name(uint8_t cmd)
+static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
          [6] = "SET_BUS_WIDTH",
@@ -1273,7 +1273,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     uint64_t addr;
     uint32_t data;
 
-    sd->last_cmd_name = sd_cmd_name(req.cmd);
+    sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
      * However there is no ACMD55, so we want to trace this particular case.
      */
@@ -1740,7 +1740,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    sd->last_cmd_name = sd_acmd_name(req.cmd);
+    sd->last_cmd_name = sd_acmd_name(sd, req.cmd);
     trace_sdcard_app_command(sd->proto->name, sd->last_cmd_name,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
-- 
2.41.0


