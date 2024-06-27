Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02ADC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMshN-0006v4-MR; Thu, 27 Jun 2024 13:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsh6-0006XY-Fu
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:14:03 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsgz-0002SG-Mt
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:14:00 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52cecba8d11so4035352e87.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508432; x=1720113232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnL/FPFYEQkll60HqwiRh6fnqmVJNFRbyEObo/B5eRw=;
 b=LqKrV1/8Nt+24RRG8sQRrIidDLpsyzjb6/ULsrAF4N795ceDGcQLV0OQQoWApl9htq
 Ry+v30QdJMd2OvnH5mIqEwyLBe7nIWYMziB7jlo9MjRImo1k9ZqbXGMDofNj98jT5Vi1
 IhtTuZ2XHsLls93IL+VyrawVn/Qayt4eyBOTTphuf7JdSilhXU/QBZwsjsNSzT+cp3cJ
 xqEImcB4sLJkk3NDeD5oI5AS6Ik9awTZhIM6eqnBrOGCTDYNzOH/yfpZpA5aSJfS5cqi
 Wdl7pM9CMxfBnqGQVAI5e9sJXwRHncJl6EhTlff0kCFzcXIRAApByqBtI0Z4d2zFrBq4
 vtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508432; x=1720113232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnL/FPFYEQkll60HqwiRh6fnqmVJNFRbyEObo/B5eRw=;
 b=HRJzSQbBM7XtIbvpVzkPUkEO7zaEOTsSPADwydD3sPyneDZic2vl70f39IEL2abE/9
 zCZAHRSG+0LxTerK/tSccxTQwVxEMjyhNmOf3JhqwHmjyF81ZYzeMwN9be42HwNdpHat
 VRdsr+BP3gwbpXZdPf4YpudV0XlYDgaggn+cDg/XN7Hf9XEDBwlDjXyw+w2x5YPiOdKj
 RWorwdDSF6iJRCssxeJ3BlIuzXCVgG6UDchvw0E5S6HCJ/xLBM0KBObUJ4e7oA1uRIA5
 4o45K6/yUoRpiPi3IxKG8NiEEZDzd8lNQCZwyM+E0FfvMD8YkOPtOat65WYnoZu0y7s7
 vOZg==
X-Gm-Message-State: AOJu0YwQz1sNreAQUCGFTJlYe3j1UjGwKWBrS/Bu/2f0e/3spum02S0N
 IYTi9ZBj1FGIFxK6SogxJj79px4XmusljdFya1H+e4TcfLWi6TPo/nl2FuGcybSruHFiR/0pBAi
 UQKY=
X-Google-Smtp-Source: AGHT+IGGn9O48kUWlz/aLcfZD5SGHJYXjy6QzYkvT1BPfNkZrQEo5uHaK+qnHboGnHwAWMR/DqhcpQ==
X-Received: by 2002:a05:6512:524:b0:52c:7f25:dbac with SMTP id
 2adb3069b0e04-52ce1834fe3mr8678776e87.20.1719508431740; 
 Thu, 27 Jun 2024 10:13:51 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b677sm969165e9.18.2024.06.27.10.13.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:13:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 15/19] hw/sd/sdcard: add emmc_cmd_SEND_TUNING_BLOCK
 handler (CMD21)
Date: Thu, 27 Jun 2024 19:10:55 +0200
Message-ID: <20240627171059.84349-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

MMC cards support different tuning sequence for entering HS200 mode.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdmmc-internal.h |  3 +++
 hw/sd/sd.c             | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index 20d85aea6d..a2769a80aa 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -108,4 +108,7 @@
 #define EXT_CSD_PART_CONFIG_EN_BOOT0    (0x1 << 3)
 #define EXT_CSD_PART_CONFIG_EN_USER     (0x7 << 3)
 
+#define EXT_CSD_BUS_WIDTH_8_MASK        0x4
+#define EXT_CSD_BUS_WIDTH_4_MASK        0x2
+
 #endif
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0561079eff..ae5e73175e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -698,6 +698,25 @@ static const uint8_t sd_tuning_block_pattern4[64] = {
     0xbb, 0xff, 0xf7, 0xff,     0xf7, 0x7f, 0x7b, 0xde
 };
 
+static const uint8_t mmc_tuning_block_pattern8[128] = {
+    0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
+    0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
+    0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
+    0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
+    0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
+    0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
+    0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
+    0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
+    0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
+    0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
+    0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
+    0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
+    0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
+    0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
+    0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
+    0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee
+};
+
 static int sd_req_crc_validate(SDRequest *req)
 {
     uint8_t buffer[5];
@@ -1603,6 +1622,26 @@ static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
                                  sizeof(sd_tuning_block_pattern4));
 }
 
+/* CMD21 */
+static sd_rsp_type_t emmc_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
+{
+    const uint8_t *buf;
+    size_t size;
+
+    if (sd->state != sd_transfer_state) {
+        sd_invalid_state_for_cmd(sd, req);
+    }
+
+    if (sd->ext_csd[EXT_CSD_BUS_WIDTH] & EXT_CSD_BUS_WIDTH_8_MASK) {
+        buf = mmc_tuning_block_pattern8;
+        size = sizeof(mmc_tuning_block_pattern8);
+    } else {
+        buf = sd_tuning_block_pattern4;
+        size = sizeof(sd_tuning_block_pattern4);
+    }
+    return sd_cmd_to_sendingdata(sd, req, 0, buf, size);
+}
+
 /* CMD23 */
 static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 {
@@ -2391,6 +2430,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 13: /* ACMD13: SD_STATUS */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
+    case 21: /* CMD21:  SEND_TUNING_BLOCK (MMC) */
     case 22: /* ACMD22: SEND_NUM_WR_BLOCKS */
     case 30: /* CMD30:  SEND_WRITE_PROT */
     case 51: /* ACMD51: SEND_SCR */
@@ -2573,6 +2613,7 @@ static const SDProto sd_proto_emmc = {
         [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [19] = {0,  sd_adtc, "BUSTEST_W", sd_cmd_unimplemented},
+        [21] = {2,  sd_adtc, "SEND_TUNING_BLOCK", emmc_cmd_SEND_TUNING_BLOCK},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [26] = {4,  sd_adtc, "PROGRAM_CID", mmc_cmd_PROGRAM_CID},
-- 
2.41.0


