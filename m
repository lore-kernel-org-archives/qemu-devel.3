Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B311C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5lc-0003hD-EZ; Fri, 28 Jun 2024 03:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lV-0003KN-Jz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lT-0004tJ-CF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-36733f09305so157204f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558681; x=1720163481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SnL/FPFYEQkll60HqwiRh6fnqmVJNFRbyEObo/B5eRw=;
 b=ujEncbw9XmjkuHZ7xGVWWM6IaX6oL7YVGHu89ayP473fgitrueG2tYjTWiWgxl6YBo
 kUjXiuGvP3iNZyIWF4lPGwT5xIREnvrnr3rSgreJfRuwE6dghvSn3ZftXujfGlETeof2
 dW1AMxnovWm0OsEmlq8ck2LSlS0+HvarSPSCZA5f+f02mjSELC6Zs6tjy+YmvI2ViQiO
 JJK7J109YVRWkf72P12vXGBt+gvZefkgO1QdZYtfxAU6POasDvccwsV/qYac+rf25+UE
 ce46ngnKk2dSDlNyNIdTsbroosLMbbLpWcjMLTMwzt+6yQ8F+2zUoBdBlKhvi/THiemU
 qWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558681; x=1720163481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnL/FPFYEQkll60HqwiRh6fnqmVJNFRbyEObo/B5eRw=;
 b=hhOF5rTJvAxeifH8GOb9+VyK1pNhKAyRsJbdta/rsws51Vsp0Ok36dNbvxJeYfgmTv
 t2Ejh6s1HA9RkkRYxVXGbE5cP1NtCXgEQ/1BG1k87OhG4yssiLH3iy1PtUTEXYr3h1ru
 qGOJiQVnuur6jBM9qiwjXWDD5PjK7RmgmnbA7xfxOTwPpICsaFvzIQ49m+gqczZA5cT9
 fB7y2q2Ij0FgmR7GVuJ07ZVKKo5H2O7OLGQ82sCX2B5IUSBHd3pcdrbgFFf7tNX8tkHw
 oNwX+HSZTF/tLWtQ7Ub9d6dEVV6XSeA2IrpkPTAVucNTKcPH2l0R51ie4y/d3YEpHd5I
 /fyg==
X-Gm-Message-State: AOJu0YzAcUWrXZMoz/tbzAtLeA3sQ0tSVMAFkB1npV2F7DHVty/OpLOl
 /QrLW26X1sI4a7HgxGbQl4/yd06KBPEkukGZPx930bcPu1ifwmAJz/EjPYw2mXDuxiZCcoenpvb
 I2sw=
X-Google-Smtp-Source: AGHT+IEdPfQtzHT3SW1bNTnrLeXlaKdEbOnvrUcXQ1V/JIg1OWzVcsNfQja1jqbKTl8VZJAjj1PKxw==
X-Received: by 2002:a05:6000:154d:b0:366:e7b5:3b49 with SMTP id
 ffacd0b85a97d-366e7b540a8mr15072878f8f.54.1719558681726; 
 Fri, 28 Jun 2024 00:11:21 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd6e5sm1352576f8f.4.2024.06.28.00.11.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:11:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 94/98] hw/sd/sdcard: add emmc_cmd_SEND_TUNING_BLOCK
 handler (CMD21)
Date: Fri, 28 Jun 2024 09:02:10 +0200
Message-ID: <20240628070216.92609-95-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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


