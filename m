Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F199EC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs9V-0001Ak-C9; Thu, 27 Jun 2024 12:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs9U-00018M-Hk
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs9S-0006sv-R2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-354b722fe81so5420883f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506352; x=1720111152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hugKoDWkNwghwH1h1z7n8tbSuuJya6Cw/1S35GizWg=;
 b=IZkqlfHn2xRbZiTMTpxadh8ibDKPx4JoyV7me9WQwHciw729I9kPF+N3LSSpOS4VTt
 rNE61ayGllO1s+yEDEJi4dGx8vm3H55L0np98B29mkwOLlEXwsoN8ieyuc/jyx/z7Uz+
 bYY5XAUeVnLMtm1D0QRo2Y3mgYeb+q2f/qc9NSJ4eRay+o2X7qtC4Eue9jANfH8+V1Gs
 l/RFfwnGffPFUStRjHUrtXXnvUFc2ABk9OONnySjidFDiQt4HNs5bUkbf9+MR8cBffuo
 qH9E97YjsOkTu+n1HBrwuPAt0z8Hv7mNurp5UxghlyC1stFoSJ+PsZ+WnIN315JrHVSu
 5LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506352; x=1720111152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hugKoDWkNwghwH1h1z7n8tbSuuJya6Cw/1S35GizWg=;
 b=cI71m+tdvBaToZloEDNcHcAgTzUQSnDO1p96oUR0vYOOgirbt8pyCrw00Ncxxirq9R
 Za/f7hOdBWrvtr5XuujxmmsAelxQ9GVqVfo+IVRMUCRtoAL3KHkqZALm6IjzyjURVHiv
 Q29vy4M5Q8w2h1NDqT5ZUb6DouBk13/UN3kF3L3IBwrgr52CgbRYu8rrLoN7SD76la1i
 0u3ckrFEXFAZxl0bkuzSAjT0/QW1ZAuMxhEQVbwOPZ0ykRmrGqnYcruDVn8thwZ962wD
 cyChElKk0WoF2AehxxseuMFDVgfGqEKSjOH9ondymZ6htHXQ2QHObNr+O+9w3vjoSpCD
 ALXQ==
X-Gm-Message-State: AOJu0YxO1/o1cC/9q7XlPDhc+RtkaDw2lRRCor7ZObPbUkEOpIC48ZX+
 YlU3uYR3riPyTV/Mpei02S8YIdJ+C5/J6FjEegA/yuH/IOSS9paspaX+pAjQTSCuxjpByKWYzIc
 14U8=
X-Google-Smtp-Source: AGHT+IHiRvZE5umc0s9ZHDgHFXiV7jcjsQQkSpQ9P4dX0L5s2m/JtYZUx896sYCUBp9zHhiuzqfbjg==
X-Received: by 2002:a05:6000:d0a:b0:362:80af:1adc with SMTP id
 ffacd0b85a97d-366e4f00a9fmr9077082f8f.53.1719506352181; 
 Thu, 27 Jun 2024 09:39:12 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674369ed92sm2384487f8f.105.2024.06.27.09.39.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:39:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 02/11] hw/sd/sdcard: Pass SDState as argument to
 sd_[a]cmd_name()
Date: Thu, 27 Jun 2024 18:38:34 +0200
Message-ID: <20240627163843.81592-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163843.81592-1-philmd@linaro.org>
References: <20240627163843.81592-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
---
 hw/sd/sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 93a4a4e1b4..f4bdd12b26 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -233,7 +233,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
     return response_name[rsp];
 }
 
-static const char *sd_cmd_name(uint8_t cmd)
+static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
          [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
@@ -272,7 +272,7 @@ static const char *sd_cmd_name(uint8_t cmd)
     return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
 }
 
-static const char *sd_acmd_name(uint8_t cmd)
+static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
          [6] = "SET_BUS_WIDTH",
@@ -1281,7 +1281,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     uint64_t addr;
     uint32_t data;
 
-    sd->last_cmd_name = sd_cmd_name(req.cmd);
+    sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
      * However there is no ACMD55, so we want to trace this particular case.
      */
@@ -1748,7 +1748,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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


