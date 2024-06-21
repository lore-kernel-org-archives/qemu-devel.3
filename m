Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A6FC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZJS-0001b2-4d; Fri, 21 Jun 2024 04:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJQ-0001Vf-Ra
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:08:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJP-00008I-AZ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:08:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42189d3c7efso20039705e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957277; x=1719562077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8Diio2eGtW+VRAl1Her+CVl5IxHLJh1wYmmEzpfRJ8=;
 b=Iw73BHqqr3CHBjFySjYhwQKNHbBVkuoBgFzUPNwDoTmg4L7MTmn+jr0hhoOEzYaOst
 vk+lrrvRCu0yFzlqQiMUFvKMFuEIbHl8iItQ+evk9+HqyeofE5hZoNFdNzY3puu/54OP
 mPOld4QDWfZOwY+ORuWai9Xarfr7H/20d4ssH3lMgTnOku7qIrUpFKROOZhNjl2LYceN
 zkIOYDHlnZ9qfYZlYcTQ7V9RI7u5EQkSlHl8EooUezLNgmcJ0ZZSphI7ri99jd46+fTX
 mEsagSwgoY5Ug4IHG5rTsLu8nbBHOwDk2/GMtjJzIoYSj74FeJ1Ws/Vf8hjMNXA+qJzj
 y5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957277; x=1719562077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8Diio2eGtW+VRAl1Her+CVl5IxHLJh1wYmmEzpfRJ8=;
 b=Z49toVBGlRIY+YWc64iH7+51tadGahjdBXMk+UQCntkqpOs7kLGbdTYiuceHlywu/R
 If+9X5iTwnSfLROWliceUUd1Bv63Ai90OwoKeGb6c0CjVMKbMdiEU7CYZSO/zPAjkZNC
 ekiUibzCmK+iQfNloGc9FOXR3e/EZaAgGi4B1IEp4tPhwxnT9sfgSgiXbN6O3111N3SQ
 O4DNDMu+6mnVpj6nLbCzfsh2tCUfYigowSLNl8Cnny+IJEg6mzsf8f+XLKSzwFjegcEu
 OKbHmHr8Y/Bce4T4eKdEkJ0hpXqAFtxlAibUc6GgFeUPRP5Yi13Mnv6a7/ZU9GQ2m8b+
 BFRA==
X-Gm-Message-State: AOJu0YxfTQzNtKJc4ZSSP1RKQHBPhp/EX08Pde/S2zMbuLK9ZeGYO1et
 hygGT7dxpQaQO3LQ5mnBCjCzEcdsEwIbZ99VWUMlRpBf9o0satAhz4jBG4HCZAXtOdiwgbs6lEu
 4
X-Google-Smtp-Source: AGHT+IEGY/sOffNAlm0L6hs1HCXOupAQBozXZQvWcSSu1BvrD+/CmgdZLG0doOIOn5ib8WTG/fYKSQ==
X-Received: by 2002:a05:600c:4244:b0:421:f43d:dadd with SMTP id
 5b1f17b1804b1-4247529bce6mr76484775e9.33.1718957277672; 
 Fri, 21 Jun 2024 01:07:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d21264fsm54273835e9.44.2024.06.21.01.07.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH 20/23] hw/sd/sdcard: Add comments around registers and commands
Date: Fri, 21 Jun 2024 10:05:51 +0200
Message-ID: <20240621080554.18986-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ca2c903c5b..95e23abd30 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -317,6 +317,8 @@ static uint8_t sd_crc7(const void *message, size_t width)
     return shift_reg;
 }
 
+/* Operation Conditions register */
+
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
 FIELD(OCR, VDD_VOLTAGE_WINDOW,          0, 24)
@@ -366,6 +368,8 @@ static void sd_set_ocr(SDState *sd)
     }
 }
 
+/* SD Configuration register */
+
 static void sd_set_scr(SDState *sd)
 {
     sd->scr[0] = 0 << 4;        /* SCR structure version 1.0 */
@@ -388,6 +392,8 @@ static void sd_set_scr(SDState *sd)
     sd->scr[7] = 0x00;
 }
 
+/* Card IDentification register */
+
 #define MID     0xaa
 #define OID     "XY"
 #define PNM     "QEMU!"
@@ -413,6 +419,8 @@ static void sd_set_cid(SDState *sd)
     sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
 }
 
+/* Card-Specific Data register */
+
 #define HWBLOCK_SHIFT   9        /* 512 bytes */
 #define SECTOR_SHIFT    5        /* 16 kilobytes */
 #define WPGROUP_SHIFT   7        /* 2 megs */
@@ -482,6 +490,8 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
 }
 
+/* Relative Card Address register */
+
 static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
 {
     if (sd_cmd_type[req.cmd] == sd_ac || sd_cmd_type[req.cmd] == sd_adtc) {
@@ -490,6 +500,8 @@ static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
     return 0;
 }
 
+/* Card Status register */
+
 FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
 FIELD(CSR, APP_CMD,                     5,  1)
 FIELD(CSR, FX_EVENT,                    6,  1)
@@ -620,6 +632,8 @@ static void sd_reset(DeviceState *dev)
     sect = sd_addr_to_wpnum(size) + 1;
 
     sd->state = sd_idle_state;
+
+    /* card registers */
     sd->rca = 0x0000;
     sd->size = size;
     sd_set_ocr(sd);
@@ -1052,6 +1066,7 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+/* CMD0 */
 static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_inactive_state) {
@@ -1062,6 +1077,7 @@ static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
     return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
 
+/* CMD1 */
 static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
 {
     sd->state = sd_transfer_state;
@@ -1069,6 +1085,7 @@ static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD2 */
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
     switch (sd->state) {
@@ -1080,6 +1097,7 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD3 */
 static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
 {
     switch (sd->state) {
@@ -1094,6 +1112,7 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
     if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
@@ -1110,6 +1129,7 @@ static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD23 */
 static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 {
     if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
-- 
2.41.0


