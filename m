Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD57C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY6s-00035L-W7; Wed, 10 Jul 2024 10:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY6W-0001Au-Lq
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:15:38 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY6J-0004CJ-74
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:15:30 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eaa89464a3so67345151fa.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720620914; x=1721225714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkDhVRq7nOrp337t4BirLj66Emh0tyYky1+9xyZk6N0=;
 b=mBEglw/vxaYJTQyGjFtmt4wRkJb33G63aDCZfvJbMRmvZHQ3OBWQ/FMzNV8zpgDsk0
 rEws8b5OGmEOPs5K+15fq89DqSYZHr9B4VKAEd60tbuFs/dwrIuqUfwv8zTEm9EjLiur
 H5kh2Ld+KHMip2fDmSCtVVkNPC9ckpWwqsZ/GXUNA4IiNQw9EwE/+mlJggFEVfTgP6to
 w1W2ClnMN9hxecqEJewF3zu5IiJyoTo1YBAzI+qvdOZDzSez9LJ+1gZYR93DKvCU6+ZK
 1OrE1KwpEwPML/j4gOnZGihLUfLP96if31tw1x4hRP177OEY8iago/1LjH1CzysQ1Flc
 bAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720620914; x=1721225714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkDhVRq7nOrp337t4BirLj66Emh0tyYky1+9xyZk6N0=;
 b=E+X/efofXzf0pDLyUQSS+eoB71L6uBnxLWJDiy0sCD6r+NdxHdOk2PbcA1dnxf6jMK
 KIOORyQFXQ/8BhmQZnfHYb7Z5nhCBT5z+CTkg27H8+35r0ZDXXy5sm67UEl5vvSVjfSA
 WZQgm5GhBcI78gpENA11T5oSi+DGsAOfC+jl4nSPw/tX1dPxDa1cb+4nfbBG9narUiA1
 IsUaVYjep2IuQ5iOgvJYkY72IP0cid7JkncJNiSrkUA+9ofcwxAmmME5fO78AnsU88MV
 TRPImvyRVdpnZmx2NGLk7pYcJxNdS82Mpw4S09T13WCafaiG5qeqnLU2Yq32wWLK3iWB
 fLBQ==
X-Gm-Message-State: AOJu0YzvcYporX1k/yirneWVmt8kxQ6pr5IXOH57I9VCrHSDTL47Gun4
 dk0E0AgF9DEA611GEIDMqRtBT8aniI15cnOaCSygPXcGNX+61FBKMICekK+vUF5HHMQOsz/2MxU
 k
X-Google-Smtp-Source: AGHT+IHmW6W3R2Mlc6AHsVYFpU68k0NIZresqSdsEt9yGjslc6KJXVNCmJThUQZpSktbUx2C/H96sQ==
X-Received: by 2002:a05:651c:2129:b0:2ee:87ef:825a with SMTP id
 38308e7fff4ca-2eeb3198757mr41817341fa.53.1720620914561; 
 Wed, 10 Jul 2024 07:15:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42662315363sm163329185e9.26.2024.07.10.07.15.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 07:15:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v48 10/12] hw/sd/sdcard: Implement eMMC 'boot-mode'
Date: Wed, 10 Jul 2024 16:14:06 +0200
Message-ID: <20240710141408.69275-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710141408.69275-1-philmd@linaro.org>
References: <20240710141408.69275-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Spec v4.3 chapter 7.2.2 "Boot operation":

  If the CMD line is held LOW for 74 clock cycles and more
  after power-up before the first command is issued, the
  slave recognizes that boot mode is being initiated and
  starts preparing boot data internally.

Track uptime since last reset, add the sd_uptime_ns() helper.

When the first command is received, check at least 74 clocks
are elapsed (during the identification phase, at a 10kHz rate)
then enable BOOT_MODE in the Ext_CSD register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c         | 38 ++++++++++++++++++++++++++++++++++++++
 hw/sd/trace-events |  1 +
 2 files changed, 39 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 57a9eb91d0..c2ea942389 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -163,6 +163,8 @@ struct SDState {
      */
     bool expecting_acmd;
     uint32_t blk_written;
+    int64_t reset_time_ns;
+    uint32_t cmd_count;
 
     uint64_t data_start;
     uint32_t data_offset;
@@ -352,6 +354,11 @@ static uint8_t sd_crc7(const void *message, size_t width)
     return shift_reg;
 }
 
+static int64_t sd_uptime_ns(SDState *sd)
+{
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - sd->reset_time_ns;
+}
+
 /* Operation Conditions register */
 
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
@@ -479,6 +486,10 @@ static void emmc_set_cid(SDState *sd)
 #define CMULT_SHIFT     9        /* 512 times HWBLOCK_SIZE */
 #define WPGROUP_SIZE    (1 << (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT))
 
+#define OD_FREQ_MIN_HZ   10000
+#define OD_FREQ_MAX_HZ  400000
+#define BOOT_MODE_DELAY_CYCLES_MIN 74
+
 static const uint8_t sd_csd_rw_mask[16] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
@@ -797,6 +808,8 @@ static void sd_reset(DeviceState *dev)
 
     sect = sd_addr_to_wpnum(size) + 1;
 
+    sd->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    sd->cmd_count = 0;
     sd->state = sd_idle_state;
 
     /* card registers */
@@ -905,6 +918,18 @@ static const VMStateDescription emmc_extcsd_vmstate = {
     },
 };
 
+static const VMStateDescription sdmmc_uptime_cmdcnt_vmstate = {
+    .name = "sd-card/uptime-command_count-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_needed_for_emmc,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT64(reset_time_ns, SDState),
+        VMSTATE_UINT32(cmd_count, SDState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int sd_vmstate_pre_load(void *opaque)
 {
     SDState *sd = opaque;
@@ -953,6 +978,7 @@ static const VMStateDescription sd_vmstate = {
     .subsections = (const VMStateDescription * const []) {
         &sd_ocr_vmstate,
         &emmc_extcsd_vmstate,
+        &sdmmc_uptime_cmdcnt_vmstate,
         NULL
     },
 };
@@ -1925,6 +1951,16 @@ static sd_rsp_type_t sd_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
         sd->state = sd_ready_state;
     }
 
+    if (sd_is_emmc(sd) && sd->cmd_count == 1) {
+        int64_t clk_cycles = sd_uptime_ns(sd) / OD_FREQ_MIN_HZ;
+
+        trace_sdcard_ext_csd_bootmode(sd_uptime_ns(sd), clk_cycles,
+                                      clk_cycles > BOOT_MODE_DELAY_CYCLES_MIN);
+        if (clk_cycles > BOOT_MODE_DELAY_CYCLES_MIN) {
+            sd->ext_csd[EXT_CSD_PART_CONFIG] |= (1 << 3);
+        }
+    }
+
     return sd_r3;
 }
 
@@ -2107,6 +2143,8 @@ int sd_do_command(SDState *sd, SDRequest *req,
         return 0;
     }
 
+    ++sd->cmd_count;
+
     if (sd->state == sd_inactive_state) {
         rtype = sd_illegal;
         goto send_response;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 5dfe6be7b7..7d0de368aa 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -57,6 +57,7 @@ sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
 sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint64_t size, uint32_t blklen) "%s %20s/ CMD%02d ofs %"PRIu32" size %"PRIu64" blklen %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
+sdcard_ext_csd_bootmode(int64_t uptime_ns, int64_t clk_cycles, unsigned enabled) "%"PRId64" ns, %"PRId64" cycles, boot mode: %u"
 
 # pxa2xx_mmci.c
 pxa2xx_mmci_read(uint8_t size, uint32_t addr, uint32_t value) "size %d addr 0x%02x value 0x%08x"
-- 
2.41.0


