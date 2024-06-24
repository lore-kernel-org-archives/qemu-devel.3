Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD94FC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjYc-0004OG-RD; Mon, 24 Jun 2024 09:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYB-00041k-U7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:08 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjY9-0005Yr-UK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:03 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52cdf4bc083so2683836e87.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234959; x=1719839759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqS+9elQ6EjTafFx/IwJ/1Wg3fHnvg3mIfJwf3uEmvY=;
 b=j6LrmzLp1nqmfhoMaLu63dcyl+6zSn0FVgkqczhcjradNyZjtfgYDXlFBmS16Xq7ln
 K5g+H/Cj6U5ubhnOqwMtFxsKfCdoUYAE6qUmhgNb0XSlLr7dcJTuSe4YIe+uH2qgKSe6
 OfApWZgt0b7UOHIsZ7DbmaRBvSMDXjguxBXV2ROzlSajGkmgT3wQDczLVZIntbu/3fLh
 EW8KhBx/LslVM99t/zpDCqOdwfJ52uHHV8yRLFY43WPAZg8IeaymZiS5zag5yogvwYWX
 YdVNVvVDubysueZryklvPs/4THOfl1F3/04gO1vRwAPlq+IvnT8nR/g1PRLUjWfnXF9U
 bPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234959; x=1719839759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eqS+9elQ6EjTafFx/IwJ/1Wg3fHnvg3mIfJwf3uEmvY=;
 b=jSExQW3aehf609BUqMPzFyM2x1CNpV8NGhaOKOkIC7mrx+HeCrcjNNVjcLBznTDOYc
 Uw8nu9HoBoiryTRiv12Ra/u2OfouKc4lgA3y4Nzw8AZKhsFtNYi4RztMQfx9z7wZcTWo
 nWpN0Nc/7JD+BJAD7m0rbkzVoe7ySVfpwMvIzlUoD2pBo3JYbFHhmUh9jms7EZ0irLGS
 13GoF2Zb5AnoFc85SA9qix6bE0wWqYD3io9VzpDR4BHAbhXFu7G/MvXj5i5hwK+OhJk1
 i2+FJlVW6e77EHuhrwLAZhh/AMoOnzj06ZrJJ4x5kZ4LB4geanmosfyJ3omBnChu5QBB
 Vh+Q==
X-Gm-Message-State: AOJu0Yw7qoe1hVqMxCZ7AaHxgrG9KtHAgCJOCvZbUWwRO3A/J+mLffJY
 2hAbtVPjWzAwjgaegBxui36p6oZPJpLiuljYIZ81NwGL7GQDy0PKBHGUYpZ1muvSxBuGuGOY6//
 F
X-Google-Smtp-Source: AGHT+IFyS54wSwLaWwP+A1nVE6XBR8GHOj8PUbJGl+3paXeYG7oVzZp8nmv92DfiyIdGzT+8VoUuUw==
X-Received: by 2002:a05:6512:1050:b0:52c:e012:efad with SMTP id
 2adb3069b0e04-52ce0610531mr4941757e87.12.1719234959448; 
 Mon, 24 Jun 2024 06:15:59 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248191116fsm139386125e9.37.2024.06.24.06.15.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/19] hw/sd/sdcard: Only call sd_req_get_rca() where RCA is
 used
Date: Mon, 24 Jun 2024 15:14:35 +0200
Message-ID: <20240624131440.81111-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

It will be useful later to assert only AC commands
(Addressed point-to-point Commands, defined as the
'sd_ac' enum) extract the RCA value from the command
argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-16-philmd@linaro.org>
---
 hw/sd/sd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b909a85d53..912b2f8984 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1105,7 +1105,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
-    uint16_t rca = sd_req_get_rca(sd, req);
+    uint16_t rca;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
@@ -1162,6 +1162,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
         case sd_standby_state:
             if (sd->rca != rca)
@@ -1216,6 +1217,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_r7;
 
     case 9:  /* CMD9:   SEND_CSD */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
         case sd_standby_state:
             if (sd->rca != rca)
@@ -1239,6 +1241,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 10:  /* CMD10:  SEND_CID */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
         case sd_standby_state:
             if (sd->rca != rca)
@@ -1279,6 +1282,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 13:  /* CMD13:  SEND_STATUS */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->mode) {
         case sd_data_transfer_mode:
             if (!sd_is_spi(sd) && sd->rca != rca) {
@@ -1293,6 +1297,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 15:  /* CMD15:  GO_INACTIVE_STATE */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->mode) {
         case sd_data_transfer_mode:
             if (sd->rca != rca)
@@ -1525,6 +1530,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
+        rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
         case sd_ready_state:
         case sd_identification_state:
-- 
2.41.0


