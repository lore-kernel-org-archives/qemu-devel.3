Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7FFC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZn3-0003WE-N9; Tue, 02 Jul 2024 05:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmt-0003RQ-2M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:59 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmo-0001ab-W6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:58 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52cd87277d8so4045842e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912413; x=1720517213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h18ZtpFi+1EoV+so/iHct3tNt9L7cd1pp1ExoGu8rMs=;
 b=C2GxE5xuqfGYHJyRLMvWg5Tq0e66WahRs68NIRafEyj3Hx1uLoHjmBQwsKPdC9Qksu
 +p4VaNYoTCIK/qoyqBOot/roZi2fL/tCMMzcw9IturaXoYSaK3SNX7jMrI/0EBdkNHjp
 knaqsQfjx61J4dh3koHtZBh1Lgzlhg7+RpmdX6uqhAk1LgeTh6/yD99RHXol0V0AjCDo
 SJB7mtehNfDfn7nrXCdELyzXU5DDciBcOX2o1w+D08e6nm6UCbOiN3/VMtbsH/gBKxSz
 keCjXLCtrsdbxm1sDy4pvDgyqM0EmQvWekMnhqcpg+cd8L2M62AnJHqly6SBMQgMPPyt
 OlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912413; x=1720517213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h18ZtpFi+1EoV+so/iHct3tNt9L7cd1pp1ExoGu8rMs=;
 b=L3J5CoqT9kdprcdISIBDQwnRPZtx0qCDNtjY3aZz94lRq9HOAl/dT0/6qdf9ic4UV4
 remy7i8V6sK2Blu/iv3PM2UJD3aNMT6kIuIF2Cxlvvbltckfqx2zYcNM6f/0sB750sk2
 LdTC/Uqeu5uADKvZAx5t7SfihJrwht6BnMZHFN/5/k20R4K5QJIRj4t3i4Kw3YBPYLrK
 GMt263DHjiJ+7SHFc0R+qinISvsCZ31g5buvLGf723NGqj1wQ2hhQqUmckRfzzq6LMka
 SFZl5z76wXS4XYjXt739nrZoGoKUlUGV4K654JMXgLXXr1xXAmN3OpO421s3RNe9+4ys
 uDqQ==
X-Gm-Message-State: AOJu0Yz5EpJ8tT/QvsrBiMPmYI42Ij2LK6Wqw+KkOPWQifSrVobQuXQU
 kEEs2VokB3nM2s5IlF+WBj56ZPzZsXUb2SovaVJeKqf6bNEL2G9sRIVPGokSIWNUfnLvbULBMuu
 m
X-Google-Smtp-Source: AGHT+IH95KeFwQt41rkKiFODOChYMkaC8QROLUSPjYZG8CzeWR5COP9wgNYXHpJc12qPd+0TvJFPxg==
X-Received: by 2002:a05:6512:6c7:b0:52c:e16e:6033 with SMTP id
 2adb3069b0e04-52e826513edmr5820126e87.2.1719912412816; 
 Tue, 02 Jul 2024 02:26:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9b1dsm12716474f8f.42.2024.07.02.02.26.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 61/67] hw/sd/sdcard: Add sd_acmd_SET_BUS_WIDTH handler (ACMD6)
Date: Tue,  2 Jul 2024 11:20:44 +0200
Message-ID: <20240702092051.45754-62-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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
Message-Id: <20240628070216.92609-69-philmd@linaro.org>
---
 hw/sd/sd.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 31cebe609c..fed95563b8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -258,7 +258,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
-         [6] = "SET_BUS_WIDTH",
         [13] = "SD_STATUS",
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
@@ -1653,6 +1652,18 @@ static sd_rsp_type_t spi_cmd_CRC_ON_OFF(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD6 */
+static sd_rsp_type_t sd_acmd_SET_BUS_WIDTH(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd->sd_status[0] &= 0x3f;
+    sd->sd_status[0] |= (req.arg & 0x03) << 6;
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1777,18 +1788,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 6:  /* ACMD6:  SET_BUS_WIDTH */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->sd_status[0] &= 0x3f;
-            sd->sd_status[0] |= (req.arg & 0x03) << 6;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 13:  /* ACMD13: SD_STATUS */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2390,6 +2389,9 @@ static const SDProto sd_proto_sd = {
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
+    .acmd = {
+        [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
+    },
 };
 
 static void sd_instance_init(Object *obj)
-- 
2.41.0


