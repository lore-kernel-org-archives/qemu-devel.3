Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFB1C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZnP-0004Mi-4Y; Tue, 02 Jul 2024 05:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZnM-00048m-S7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZnH-0001e3-Tu
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so27653545e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912441; x=1720517241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTfJi1XXPwjhNkGNkal4TzGgTuML6EnycC4lcNZtgo8=;
 b=CBwQ0OZkk7/tFY46puxOCIC0bBA6X4svmNXDYNblC/AyxQCbHLoPWQNQiA/Pe02ljW
 lsPpBHSOh10gZkftO4eCU+Bmc0bzFi835FXF3tJFfUjAcxOCWffpFSO2fwrnPT3AEOHJ
 iS2n6yuf8GIgBqXd3ytRY6Vxwn+I02sk0lrEB/CyILOrwVhD1eVAPM5rDm6YnGa7/zN0
 tGIQCBQHEa9y4TQ1jyhTuK8ItjBILaJHqeyYJ1nX+HqtW18D6DVhl6qUviINY59v6NiS
 uMSLsImFyBdchsS00hQW+/vsE4DV/DpDQDGW1xPweoHmdqrIE73mhO4KPQjK+id1QXnO
 i1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912441; x=1720517241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PTfJi1XXPwjhNkGNkal4TzGgTuML6EnycC4lcNZtgo8=;
 b=vgTkINFTR2KJ5TyE4VYJq8KkCT6DGaq93O5pObsi05OGowGmy72qRE1y2uBlG48fnv
 Xh/XqHZ6vQApTtMZZBxy9y+8cwU7YwO5DoxBno5ZQUJdUCSrkskpoW+my9j5uzYlKoIG
 pF0SB5xpYb0LJJGHAp41f3QIozwrJaeE06oLNl9Q13UFl+Xg1bL3E3ifI1inNsMNgPZf
 zXHsmzE31MqNWEDLXLdWDPCD+8judOHbgXfGmL7FIAuUHl9IXQN/zjUJRrot19Q7LcBb
 TCUyubxZLGjsIF+FsLl7nWpoRApmd/BfVe9Doog9vEVXYEdO/f41Nieu7spU9ZkF7mi1
 I9CA==
X-Gm-Message-State: AOJu0Yy7LhZZ4ViGIhnu9PNvWDD1M6VIqVJquduwLdlVqAC2Lvwk8S6L
 X9tzo6AoRxScuZ2rhPhEMGkF4IFSFav+B46Y4GW4nFx5C26h2SZe7IhF5P5rUv0p+/+27nXzfcL
 y
X-Google-Smtp-Source: AGHT+IGOeRJgRSWkn3ykXy3d50nETswJ4Qnpj1U/l3bx2mrOEKV/8YAQpnLh1+4DPJTm7v0UXLQmew==
X-Received: by 2002:a05:600c:3b07:b0:425:6979:9b5f with SMTP id
 5b1f17b1804b1-4257a009c28mr54331655e9.6.1719912441249; 
 Tue, 02 Jul 2024 02:27:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257d0d38bbsm106943455e9.38.2024.07.02.02.27.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:27:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 66/67] hw/sd/sdcard: Add sd_acmd_SET_CLR_CARD_DETECT handler
 (ACMD42)
Date: Tue,  2 Jul 2024 11:20:49 +0200
Message-ID: <20240702092051.45754-67-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Message-Id: <20240628070216.92609-74-philmd@linaro.org>
---
 hw/sd/sd.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 207deb07e6..698d64d2cb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -261,7 +261,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-        [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
         [54] = "SECU_spec",
@@ -1729,6 +1728,17 @@ static sd_rsp_type_t sd_acmd_SD_APP_OP_COND(SDState *sd, SDRequest req)
     return sd_r3;
 }
 
+/* ACMD42 */
+static sd_rsp_type_t sd_acmd_SET_CLR_CARD_DETECT(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    /* Bringing in the 50KOhm pull-up resistor... Done.  */
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1853,17 +1863,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 42:  /* ACMD42: SET_CLR_CARD_DETECT */
-        switch (sd->state) {
-        case sd_transfer_state:
-            /* Bringing in the 50KOhm pull-up resistor... Done.  */
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 51:  /* ACMD51: SEND_SCR */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2333,6 +2332,7 @@ static const SDProto sd_proto_spi = {
         [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [42] = {8,  sd_spi, "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
     },
 };
 
@@ -2392,6 +2392,7 @@ static const SDProto sd_proto_sd = {
         [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
+        [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
     },
 };
 
-- 
2.41.0


