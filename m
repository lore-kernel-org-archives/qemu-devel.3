Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D04C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZlA-0004qH-Rv; Tue, 02 Jul 2024 05:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkn-0004Ly-DK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkl-0000C9-O7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so23572085e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912285; x=1720517085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNA/X248tgmPgC0TxVdzd0n0o4N/WEHWfZeXeWaMVQw=;
 b=ByagCKsjdwfkyV+Vm9i340lQTR5n6pv4HyoSVXW32zPeK64r9BGhM+AGJ4m+Gt7wzJ
 6CanE+NVIZQV09YUMePb0NQdruzG5LAXOnWHWA4yPl5fERnIA9UOvKVYg5U/fGEu9m05
 VRzOA0suIqUiy+s3OG7jOEQJ457QNLALFK5AUv2LJqUlnF/UkqiHWl+QFHopXKoMXP0m
 J59IaarKeJ0DcwZ3rMZJm/bPU0IlwXREjq6wSi0bNWlEg3DLf6SvlzqI4AObrycIptw2
 TN0UAZFJch+I9uTXsA4sz50VRuWpte0jq3XQ8UhMLXrcrFDtfqhxLVRy+yi7+GxqNmbK
 cCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912285; x=1720517085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNA/X248tgmPgC0TxVdzd0n0o4N/WEHWfZeXeWaMVQw=;
 b=TpjJ4exkBpKZoXZOhOn//ujiWykLoCm6yCGpkgDh/ieUTBDyQyxHcln095TkHBh0o1
 ddfvXroNhJoYnOME50d9CF7kUC/w4ibxPGkq3qvR2gJdVFEmtgg2CRSeHtkuuNIDv6ey
 CfJ8c4Kc4aKMh4V1fND9geTpzq30554q0Du2CdTKiaWzabIyNcxk9R0Rx8xrkZRo+FZP
 zx0hsWPFvmNRN7qzDHmQuKw+LYcwYpJODSdMIDFoy+TcmZ5g7SlTzWqsdSY2D3PPPEPE
 K1MBGRBtzxQIb5Hw+Dz7I7vERzjGwqL/4jNRO7I0No/YSoarK7+fX0eMyr8GTQnN6c4N
 j1Qg==
X-Gm-Message-State: AOJu0YzSZah6LoAN51qASck4f4LidMRkMjHgB38t+uJNGTl/Oy4P5yhF
 0k4Q0PHCa19doGXDob95g7yLTdnFthsw3BwMka6cnYVWHZTlbikU4oLYfVCMqrvpCMH7Y9vcOVv
 L
X-Google-Smtp-Source: AGHT+IFDOy2D0nol22G8v++qQr49h+TJLsObC59NMG8pPQjH4YRAoSyqMERlhjpLUGxA1DuS6f8wHg==
X-Received: by 2002:a05:600c:3552:b0:425:7c42:d24b with SMTP id
 5b1f17b1804b1-4257c42d3a0mr62065735e9.18.1719912285154; 
 Tue, 02 Jul 2024 02:24:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36789fd7a0esm830044f8f.104.2024.07.02.02.24.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:24:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 39/67] hw/sd/sdcard: Register SDIO optional handlers
Date: Tue,  2 Jul 2024 11:20:22 +0200
Message-ID: <20240702092051.45754-40-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

See "SD Input/Output Card Specification" v1.00.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-46-philmd@linaro.org>
---
 hw/sd/sd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f8672b6603..e050f3d5ef 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                             [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
         [10]    = "SEND_CID",
@@ -257,7 +256,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
         [50]    = "SW_FUNC_RSVD",
-        [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
@@ -2272,6 +2270,9 @@ static const SDProto sd_proto_spi = {
     .cmd = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
+        [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
+        [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
@@ -2285,6 +2286,7 @@ static const SDProto sd_proto_sd = {
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
+        [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
@@ -2296,6 +2298,8 @@ static const SDProto sd_proto_sd = {
         [47] = {1,  sd_adtc, "Q_WR_TASK", sd_cmd_optional},
         [48] = {1,  sd_adtc, "READ_EXTR_SINGLE", sd_cmd_optional},
         [49] = {1,  sd_adtc, "WRITE_EXTR_SINGLE", sd_cmd_optional},
+        [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
+        [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
-- 
2.41.0


