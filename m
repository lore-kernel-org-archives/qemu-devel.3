Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB31C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jo-0006rO-5V; Fri, 28 Jun 2024 03:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jX-0006bC-6B
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jV-0004Vd-7i
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-36703b0f914so172885f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558558; x=1720163358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JLfOaKjryvDgm8/tAb2iA3e2u5r9x8cBXXCm9JQWcag=;
 b=Ux03+hN1ZtWU/gSoD7ZOEx7TXMudkX7MctjdrjSEfQ8HN+shCGtYYr4cVDG7M+szVJ
 8MpsKlU0CDqu/h8PUBq0t+kEFz/8BVYjw0rdziHPcYXZQU1Su3w2LpKXd/l28TXX2xYQ
 b9Oq45GXiLfhXVuoC4S5f7b+t5bKIGqkpc3RTrrr7w1j4TNlLs2HKPkqKE/NlT74ce3S
 a0D4x9wAMlOeq24Q7b7+9ZeuvLnFXKCTrhz6DB4lg8RSXU+AyiqJe0opk8CGxNZURSEK
 3gfeMab7qLDONWYAEjKdoWUtlKws4ssfQ7cKX79snF9EWfOZ37s9jg3dRZH6t8QTnI5o
 +LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558558; x=1720163358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLfOaKjryvDgm8/tAb2iA3e2u5r9x8cBXXCm9JQWcag=;
 b=wHV0EJ1JD3t+EhehBJw/ruD/8e/4qkhstPoJSj4UQY2QEk47d+t26CujQxvcy7x8QN
 cuXhyKEb8g7pScQB8dqhgSAx4dzsdjyu3+Qh8h2Dkl9AuGkTmXlFatBq9kUqJXPCR/xu
 ps4iep7+jk9SQIRXY2YxUhMxDvTElAq+Kj2I4WZVQxTY+0KcdnkdUR/m4BP4AusM+S+6
 7O/XcYbW9/4U93+h5FaWsH0XcdbGie5x4+NkUPSbyXfJ7+Qc0o9JFrn2zDlRIz6h5L6R
 EQ0pV1YZiZHe+92VHOLH+9EpQXW/QuSXiAqmVYHG0+EWK9XmA+b8zGkKthehuVrvaGFY
 MxBA==
X-Gm-Message-State: AOJu0YyRD7YRCsXALPT3eSanA0zs6vgGWq9tkPzrPLO3Jz9L7cAkbFtG
 Rwz24M5hjP+0h0eOf4/W7hYTDYpBto2hkaEOsyIADXjpFcD7z46b/ON7z5XjsKI21inleYK6p2b
 ruLU=
X-Google-Smtp-Source: AGHT+IG0wzb+OZ4o4GbKETOWxUdtSOh4ZKppIq35Z0XpEtYCy7qhhYoBJIgf7pxCWfydtDu0jvaa3A==
X-Received: by 2002:a5d:47a8:0:b0:366:ee84:6a77 with SMTP id
 ffacd0b85a97d-36760a63045mr718077f8f.3.1719558558689; 
 Fri, 28 Jun 2024 00:09:18 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a94csm21291405e9.33.2024.06.28.00.09.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 70/98] hw/sd/sdcard: Add sd_acmd_SEND_NUM_WR_BLOCKS
 handler (ACMD22)
Date: Fri, 28 Jun 2024 09:01:46 +0200
Message-ID: <20240628070216.92609-71-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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
 hw/sd/sd.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5323a42df2..9d66c3715a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -263,7 +263,7 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-        [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
+                                            [23] = "SET_WR_BLK_ERASE_COUNT",
         [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
@@ -1689,6 +1689,13 @@ static sd_rsp_type_t sd_acmd_SD_STATUS(SDState *sd, SDRequest req)
                                  sd->sd_status, sizeof(sd->sd_status));
 }
 
+/* ACMD22 */
+static sd_rsp_type_t sd_acmd_SEND_NUM_WR_BLOCKS(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_sendingdata(sd, req, 0,
+                                 &sd->blk_written, sizeof(sd->blk_written));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1797,18 +1804,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_cmd_to_sendingdata(sd, req, 0,
-                                         &sd->blk_written,
-                                         sizeof(sd->blk_written));
-
-        default:
-            break;
-        }
-        break;
-
     case 23:  /* ACMD23: SET_WR_BLK_ERASE_COUNT */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2324,6 +2319,7 @@ static const SDProto sd_proto_spi = {
     },
     .acmd = {
         [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
+        [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
@@ -2382,6 +2378,7 @@ static const SDProto sd_proto_sd = {
     .acmd = {
         [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
+        [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
     },
 };
 
-- 
2.41.0


