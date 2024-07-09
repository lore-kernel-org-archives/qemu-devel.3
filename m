Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9DCC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCkf-0000vY-I2; Tue, 09 Jul 2024 11:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkd-0000jL-FQ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:31 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCka-0006Pp-D1
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:31 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so18543071fa.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538846; x=1721143646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wJ5lOyeKuAdtY89+hnEzjIVRBYuAVyLYyRgy5UbxAE=;
 b=hVndUIm/Xg31HQbSY0OG7nh8Zngf6P+sYMVQa11nKs1EiTZWWbsPvLd2+1Eah02Ub2
 09T/E1Qql3J1WyoQpKF6As5JfefxyEGSTHkIsJT/J3600XEdE+jMgZVI6KuyOMvpLGdX
 8h47GOzVw6nmiyEc5r7b8e55I5KW5ZiZWO0eFjfBdjctatFlbayEbjv5IRFIxLXhu6YZ
 hdhvpNiE830gMJpo3dT8le0UU/1Nm4z2p9uDH2evx99Rgkwek5ZiLeflsHoYeWfbBSdC
 hV9Je17jp+nlegTATbwxdScj7MWme8DyE9EYutzAQ1Lve72s7wSQJPPGuVKD+eJzUfWP
 4F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538846; x=1721143646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wJ5lOyeKuAdtY89+hnEzjIVRBYuAVyLYyRgy5UbxAE=;
 b=ESxcr6VcDZ16D3C0JaXsQx28QGuMQD7cESoI0lHbSTFrMsW91qoWwkLHXgKT37aQli
 nY8xjDr2FLUI1ZWQQaAUgCaJ1VTGZGEQZhqxiJ1ntBksAGeArpuoyWscl3SVjPVhO9Lv
 4Adxrx0azztSt0ksGTouksYjOu+9X5loy4ZNxuu0LVJ8OSO5gXbn7g0/FEuYX8XFOwvi
 F3P6ba/YTyYLsmDkM93qKUf9qR91EzlWYDw8XO76WQ7RXJ48L+NctOhSL3fnYdix7VZC
 GoGrmyZGgw0gN/9q/pnlZ/UjSaVOi1PeR4QbB6OdXsV7l1MCIPoZDzXalWG4W0w4iRDB
 h7ng==
X-Gm-Message-State: AOJu0Yyv/eR3p3pgPQl9vMG8tFz+igr/sNbHkX2ufGWvLm07gyZ49Zpt
 ky51gFG4nmH1ku2bVQBSmoFU2d0qXvG3L+P1VL642ZrX3AbS7uHTtcxGW0seVvqzTNlgSPEoFVl
 Z
X-Google-Smtp-Source: AGHT+IHFTTY947JzlGNKCYTAmdf9b+lfGgD6UHY2uilFzI0AFIm/dOMb7RZ17NN0FVUZlLZ+ERELvQ==
X-Received: by 2002:a2e:9b86:0:b0:2ec:1708:4daf with SMTP id
 38308e7fff4ca-2eeb319887amr18505731fa.47.1720538846212; 
 Tue, 09 Jul 2024 08:27:26 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427165c69f0sm23171695e9.30.2024.07.09.08.27.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Subject: [PATCH v47 14/19] hw/sd/sdcard: Add mmc SWITCH function support (CMD6)
Date: Tue,  9 Jul 2024 17:25:51 +0200
Message-ID: <20240709152556.52896-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

switch operation in mmc cards, updated the ext_csd register to
request changes in card operations. Here we implement similar
sequence but requests are mostly dummy and make no change.

Implement SWITCH_ERROR if the write operation offset goes beyond
length of ext_csd.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/sd/trace-events |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a391f12b2a..beb8e2730a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -642,6 +642,7 @@ static bool sd_req_rca_same(SDState *s, SDRequest req)
 FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
 FIELD(CSR, APP_CMD,                     5,  1)
 FIELD(CSR, FX_EVENT,                    6,  1)
+FIELD(CSR, SWITCH_ERROR,                7,  1)
 FIELD(CSR, READY_FOR_DATA,              8,  1)
 FIELD(CSR, CURRENT_STATE,               9,  4)
 FIELD(CSR, ERASE_RESET,                13,  1)
@@ -1091,6 +1092,47 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
     return ret;
 }
 
+enum ExtCsdAccessMode {
+    EXT_CSD_ACCESS_MODE_COMMAND_SET = 0,
+    EXT_CSD_ACCESS_MODE_SET_BITS    = 1,
+    EXT_CSD_ACCESS_MODE_CLEAR_BITS  = 2,
+    EXT_CSD_ACCESS_MODE_WRITE_BYTE  = 3
+};
+
+static void mmc_function_switch(SDState *sd, uint32_t arg)
+{
+    uint8_t access = extract32(arg, 24, 2);
+    uint8_t index = extract32(arg, 16, 8);
+    uint8_t value = extract32(arg, 8, 8);
+    uint8_t b = sd->ext_csd[index];
+
+    trace_sdcard_switch(access, index, value, extract32(arg, 0, 2));
+
+    if (index >= 192) {
+        qemu_log_mask(LOG_GUEST_ERROR, "MMC switching illegal offset\n");
+        sd->card_status |= R_CSR_SWITCH_ERROR_MASK;
+        return;
+    }
+
+    switch (access) {
+    case EXT_CSD_ACCESS_MODE_COMMAND_SET:
+        qemu_log_mask(LOG_UNIMP, "MMC Command set switching not supported\n");
+        return;
+    case EXT_CSD_ACCESS_MODE_SET_BITS:
+        b |= value;
+        break;
+    case EXT_CSD_ACCESS_MODE_CLEAR_BITS:
+        b &= ~value;
+        break;
+    case EXT_CSD_ACCESS_MODE_WRITE_BYTE:
+        b = value;
+        break;
+    }
+
+    trace_sdcard_ext_csd_update(index, sd->ext_csd[index], b);
+    sd->ext_csd[index] = b;
+}
+
 static void sd_function_switch(SDState *sd, uint32_t arg)
 {
     int i, mode, new_func;
@@ -1402,6 +1444,19 @@ static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
     return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
 }
 
+static sd_rsp_type_t emmc_cmd_SWITCH(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_transfer_state:
+        sd->state = sd_programming_state;
+        mmc_function_switch(sd, req.arg);
+        sd->state = sd_transfer_state;
+        return sd_r1b;
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD7 */
 static sd_rsp_type_t sd_cmd_DE_SELECT_CARD(SDState *sd, SDRequest req)
 {
@@ -2581,6 +2636,7 @@ static const SDProto sd_proto_emmc = {
         [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {0,  sd_ac,   "SLEEP/AWAKE", emmc_cmd_sleep_awake},
+        [6]  = {10, sd_adtc, "SWITCH", emmc_cmd_SWITCH},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [8]  = {0,  sd_adtc, "SEND_EXT_CSD", emmc_cmd_SEND_EXT_CSD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 5dfe6be7b7..43671dc791 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -57,6 +57,8 @@ sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
 sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint64_t size, uint32_t blklen) "%s %20s/ CMD%02d ofs %"PRIu32" size %"PRIu64" blklen %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
+sdcard_ext_csd_update(unsigned index, uint8_t oval, uint8_t nval) "index %u: 0x%02x -> 0x%02x"
+sdcard_switch(unsigned access, unsigned index, unsigned value, unsigned set) "SWITCH acc:%u idx:%u val:%u set:%u"
 
 # pxa2xx_mmci.c
 pxa2xx_mmci_read(uint8_t size, uint32_t addr, uint32_t value) "size %d addr 0x%02x value 0x%08x"
-- 
2.41.0


