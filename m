Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADACCC3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTn92-000632-6Q; Tue, 16 Jul 2024 14:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8Z-0004HW-JI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8X-0007On-OV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4267345e746so40641595e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721155372; x=1721760172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xO0vtOu4MZR3bds8QyFz198ibx2ClbqyzFm/x8wCZ8=;
 b=Kn2h2/WMh/xdfirvXLrw8Fi83WqSn8wMGHhvriP99L0ifRZ0rvplUFmqGkx2ilqBY6
 7s+5AeNmt4hm/QdHLIuIHwlzQgVlpXT0tFZZetnIdtsRzh2UKk7fBWmMoRk9QPApjesm
 1PblavISBObqSiT7sSgel8/Skz28fjpov22KqhROWTzCKAvZvE5KNwDrch4QWUv7PrfL
 Oak7gc1sAQDFgKdPBN0CFsY8Q0pQDumRdni4k8Tw2Q0y+HkIVkKTraa94K80Nr/LfSPu
 ppck85GIeDODTj3sThDjDNAtTBVd9UYxa18RbrwLvhz7gi/Hl9cs6vkgUHgIkTZUIUkg
 KjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155372; x=1721760172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xO0vtOu4MZR3bds8QyFz198ibx2ClbqyzFm/x8wCZ8=;
 b=VRyKvwPY1InZeKlVnUpbPhY2G7l1dDRkENNVf/QOIWN67FAnuJia5RDqkXzJZ0cuGV
 K6/qtOmMaMpquji2JeHNeeQ+IjgEQIuk8Ok0W17brbAnQA1jG7vgSzH9E875oybIv950
 4qHguDhjZVC8IboWcXhPW0qsG7ONOwpMHrn78XEOfsg+EJSgPbH3ElSaGkiNR4HvcxJa
 5320xnjvrtFBwFtHVSgsTeEnOLn02nhuoEJ1HUKDOKCX4V8LAjyRVAQ+95KiLMtZN/b0
 nrugq1OqNyixeRt9Mc15cyV0DQQJbwyBUIYxPaqG15BVyDdVXRBJ2JFefvy6M7PxbYVX
 WUwA==
X-Gm-Message-State: AOJu0Yzmb6FF7YJe1AfPrEUQG0fUHjZYZJRf7KlUo8rp0o6rQP6c+V3q
 xn20Vx9+r2YBnHXvLIbt68Bod6UDewU7xFJyD9bD5N5uqZpF8NzI4ZygDl9JbWnzq23fMyVnEuH
 UbmSz2Q==
X-Google-Smtp-Source: AGHT+IF8m521XToL/8kZC1OY4u/L0sWo+B+iJYZT5SksMNsYLEJNczblchCoGkjpWQ0mrWDp0DLHTA==
X-Received: by 2002:a5d:5244:0:b0:360:7812:6abc with SMTP id
 ffacd0b85a97d-3682635a551mr1895130f8f.60.1721155371927; 
 Tue, 16 Jul 2024 11:42:51 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb99fsm9718418f8f.84.2024.07.16.11.42.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:42:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/11] hw/sd/sdcard: Add mmc SWITCH function support (CMD6)
Date: Tue, 16 Jul 2024 20:41:43 +0200
Message-ID: <20240716184144.42463-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716184144.42463-1-philmd@linaro.org>
References: <20240716184144.42463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
[PMD: Convert to SDProto handlers, add trace events]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240712162719.88165-11-philmd@linaro.org>
---
 hw/sd/sd.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/sd/trace-events |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d49b144214..1f16c16fd1 100644
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
+static void emmc_function_switch(SDState *sd, uint32_t arg)
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
+        emmc_function_switch(sd, req.arg);
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


