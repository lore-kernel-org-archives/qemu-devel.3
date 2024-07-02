Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23699C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZnE-0003tx-Ak; Tue, 02 Jul 2024 05:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZn8-0003de-3y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZn6-0001bf-Bc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:13 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3636c572257so2884571f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912430; x=1720517230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRpXZ/lTgoptLk88HU8T9HvMCsCj/dqSxIEhw3vh1zM=;
 b=lswc24F04AUHre/zz29IdQAuPV8CngBhD2htQO6DLp7AS1uRHpZ85S5lLKrx/o7KC2
 0T2z6BigeoMCxRScna7wPad7LlAfHaQwStHQjpklPtTIfK6ee+N+o900qFwvS11Q8dBm
 vDZphwwlbR+KEke7/riD1CdbSGTf6Q7Dps6/nvvfOFoX3eWZ2GuPjxMLsPbwL0zfryKm
 ynLzAE37DSjk4o+As1rSz++J8xyQkJaoUahVTclZ1ROUs3ISA+cMtUYtXeRvlnV1180/
 9nu4oigWtxi68Ad7u1XbgO8W1MZrrvgIppnLZeNmr6z8TH583ORMOGgtQRUnX4iqwERo
 Ir9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912430; x=1720517230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRpXZ/lTgoptLk88HU8T9HvMCsCj/dqSxIEhw3vh1zM=;
 b=N4ODmxOmdL0ruQNaVva3gTTjDdZOjZ+ui1qkHUVuGVGo/2NqfA5FPY7beQ4a3TXIdJ
 POLqzJ557SBdIx9rN0jBQTt93qnjpMHciiZiTQpX+7hwpIpzTdGKP1CoW6Oa3EZzeEZA
 YLBONXmcMtoN0CVn9E2nqi9AKQTKekV5Gq2pQcaooUVYDc1WZ1ui6Ma2sDkdmaS6aQFC
 WpDXxlihWWIRdAN91sgyevSQaDZlncs1JvXoMwPOl/8JBSIEWs3bqijHxSOo7YbzgF3e
 iCihcD7eUpykAEtZhHFFZsS2s/147mPQPvA8cYLGRl9g+I/D9VScEF1N7dcTIeXAgU7S
 68kQ==
X-Gm-Message-State: AOJu0YwSnS7nWN1GSIYfIlGz9R170VJBOyo0N7e5CMey1yNyrE+Yt4Fu
 T6Yv90sWg1GVCHWOzPmb2AMicZYeok5m4QrKl9kTkyCHE/oEzP7Y26KKb5fzNz2qgrUzsk9/drG
 m
X-Google-Smtp-Source: AGHT+IEZXEHap4xri+I5Xb4g8doNQkjYmzkHuzKPHx4ovB7KZ/l44wn1OaeLXHLBQiHiuQw0QnGMCQ==
X-Received: by 2002:a5d:6d04:0:b0:367:4dce:1ff4 with SMTP id
 ffacd0b85a97d-36775699516mr6639342f8f.14.1719912430016; 
 Tue, 02 Jul 2024 02:27:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc412sm12724646f8f.70.2024.07.02.02.27.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:27:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 64/67] hw/sd/sdcard: Add sd_acmd_SET_WR_BLK_ERASE_COUNT handler
 (ACMD23)
Date: Tue,  2 Jul 2024 11:20:47 +0200
Message-ID: <20240702092051.45754-65-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Message-Id: <20240628070216.92609-72-philmd@linaro.org>
---
 hw/sd/sd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6e9ab92a1a..c56790f091 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -261,7 +261,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-                                            [23] = "SET_WR_BLK_ERASE_COUNT",
         [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
@@ -1677,6 +1676,15 @@ static sd_rsp_type_t sd_acmd_SEND_NUM_WR_BLOCKS(SDState *sd, SDRequest req)
                                  &sd->blk_written, sizeof(sd->blk_written));
 }
 
+/* ACMD23 */
+static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1801,16 +1809,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 23:  /* ACMD23: SET_WR_BLK_ERASE_COUNT */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 41:  /* ACMD41: SD_APP_OP_COND */
         if (sd->state != sd_idle_state) {
             break;
@@ -2326,6 +2324,7 @@ static const SDProto sd_proto_spi = {
     .acmd = {
         [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
+        [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
@@ -2384,6 +2383,7 @@ static const SDProto sd_proto_sd = {
         [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
+        [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
     },
 };
 
-- 
2.41.0


