Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF39C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCkG-0006Nc-9y; Tue, 09 Jul 2024 11:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkE-0006D1-Ic
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkC-0006MU-Os
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36798ea618bso3445570f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538823; x=1721143623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vVlv/BXkUK0BZMTLjJTuTB4p5N98pUrM0E2su3U72g=;
 b=uPoXwasMe0ddcYPlET0kXhhY8dWX9ZAmX/eTktQzX2Yyandp+fcUFTnzmTCy+srJIp
 M5EDMUab+ZahLj8IRbDo1Udvsqqu+l1aR+TlJYS7gyH7hI+/ndikRw4MPv+ixousN6Jy
 64S6eb/coeZ5KO5TQBZFgxiCmo9EolKFu3+qTgCVrXMJfN5eYFCVynI/9tJ6UDillQOC
 /nhBd/JAOcphFDzBgUag3xURe1rXFw3kWSb18Q0nkAbI8BskhbMa8t1eOnmPJDILMuGV
 EckJUC1tWGMqLkMAtpYmAvm0sUpemj1hlJ6wqoEnZFR5McQsktnBI4siGKfCQIL40Dux
 pVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538823; x=1721143623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vVlv/BXkUK0BZMTLjJTuTB4p5N98pUrM0E2su3U72g=;
 b=W7WlUhxfDRPHgZEmH+ebFBRGLJ3dhEqByXI9EZ+Dd65+C841PTPERND05/itvD4HxY
 hmUkdNL81AjCB+6V0YppwRsOJqwgjfEjqLMLoWV0g8QsFQjRQm6yk6iw5oZZ2z/Zk+Ib
 Yx0CvEitx/xREQ/zHZagyXKk4osZnuod5u0B/A4ttKvIEgIWu7OuNxscpATEOaRSFFZe
 7p5w/QpW6bjd69bcfJ/+i9ykjaGcSiEn/jp3aCGNleTp/m/JLJhhu73SUEXOxSTzbDwn
 ykVuCqJUdfosI9FJf+MgJzgMzc866Zbe1x2oW4mRwzvRiAfNqhncUFwME36HE+5lF4Zv
 cgew==
X-Gm-Message-State: AOJu0YwdUb1C3BNfFA845ZeY4VdNGkGuYdzvU5xvIoeBrYCdPjF8Vsur
 CJqZ/l00GSg7NqKfZC4Gj0rDUYNezC7uNmeeQA+7VvSaGK3Lxk9ftj0wsHdKbzIEzvS0296IvO9
 x
X-Google-Smtp-Source: AGHT+IHCZupJ1C/WGW5wh3WtDatAUr35/Zy9x1C0RzU4cKBSyxjapjh1C4C3KpwECMOMXxdLrRVY1Q==
X-Received: by 2002:a5d:64e1:0:b0:367:9993:dce4 with SMTP id
 ffacd0b85a97d-367cea4659amr2374389f8f.13.1720538822686; 
 Tue, 09 Jul 2024 08:27:02 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde890f6sm2850969f8f.53.2024.07.09.08.27.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v47 10/19] hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler
 (CMD8)
Date: Tue,  9 Jul 2024 17:25:47 +0200
Message-ID: <20240709152556.52896-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Vincent Palatin <vpalatin@chromium.org>

The parameters mimick a real 4GB eMMC, but it can be set to various
sizes. Initially from Vincent Palatin <vpalatin@chromium.org>

eMMC CSD is similar to SD with an option to refer EXT_CSD for larger
devices.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
[PMD: Remove deprecated EXT_CSD_SEC_ERASE_MULT/EXT_CSD_SEC_TRIM_MULT]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index adba53e822..c809961418 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -124,6 +124,7 @@ struct SDState {
     uint16_t rca;
     uint32_t card_status;
     uint8_t sd_status[64];
+    uint8_t ext_csd[512];
 
     /* Static properties */
 
@@ -476,6 +477,50 @@ static const uint8_t sd_csd_rw_mask[16] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
 };
 
+static void mmc_set_ext_csd(SDState *sd, uint64_t size)
+{
+    uint32_t sectcount = size >> HWBLOCK_SHIFT;
+
+    memset(sd->ext_csd, 0, sizeof(sd->ext_csd));
+
+    sd->ext_csd[EXT_CSD_S_CMD_SET] = 0b1; /* supported command sets */
+    sd->ext_csd[EXT_CSD_HPI_FEATURES] = 0x3; /* HPI features  */
+    sd->ext_csd[EXT_CSD_BKOPS_SUPPORT] = 0x1; /* Background operations */
+    sd->ext_csd[241] = 0xA; /* 1st initialization time after partitioning */
+    sd->ext_csd[EXT_CSD_TRIM_MULT] = 0x1; /* Trim multiplier */
+    sd->ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] = 0x15; /* Secure feature */
+    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
+    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
+    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */
+    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit size */
+    sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x01; /* HC erase timeout */
+    sd->ext_csd[EXT_CSD_REL_WR_SEC_C] = 0x1; /* Reliable write sector count */
+    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x4; /* HC write protect group size */
+    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x8; /* Sleep current VCC  */
+    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x7; /* Sleep current VCCQ */
+    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x11; /* Sleep/Awake timeout */
+    sd->ext_csd[215] = (sectcount >> 24) & 0xff; /* Sector count */
+    sd->ext_csd[214] = (sectcount >> 16) & 0xff; /* ... */
+    sd->ext_csd[213] = (sectcount >> 8) & 0xff;  /* ... */
+    sd->ext_csd[EXT_CSD_SEC_CNT] = (sectcount & 0xff);       /* ... */
+    sd->ext_csd[210] = 0xa; /* Min write perf for 8bit@52Mhz */
+    sd->ext_csd[209] = 0xa; /* Min read perf for 8bit@52Mhz  */
+    sd->ext_csd[208] = 0xa; /* Min write perf for 4bit@52Mhz */
+    sd->ext_csd[207] = 0xa; /* Min read perf for 4bit@52Mhz */
+    sd->ext_csd[206] = 0xa; /* Min write perf for 4bit@26Mhz */
+    sd->ext_csd[205] = 0xa; /* Min read perf for 4bit@26Mhz */
+    sd->ext_csd[EXT_CSD_PART_SWITCH_TIME] = 0x1;
+    sd->ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] = 0x1;
+    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0x7;
+    sd->ext_csd[EXT_CSD_STRUCTURE] = 0x2;
+    sd->ext_csd[EXT_CSD_REV] = 0x5;
+    sd->ext_csd[EXT_CSD_RPMB_MULT] = 0x1; /* RPMB size */
+    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
+    sd->ext_csd[159] = 0x00; /* Max enhanced area size */
+    sd->ext_csd[158] = 0x00; /* ... */
+    sd->ext_csd[157] = 0xEC; /* ... */
+}
+
 static void emmc_set_csd(SDState *sd, uint64_t size)
 {
     int hwblock_shift = HWBLOCK_SHIFT;
@@ -512,6 +557,7 @@ static void emmc_set_csd(SDState *sd, uint64_t size)
         ((hwblock_shift << 6) & 0xc0);
     sd->csd[14] = 0x00;
     sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
+    mmc_set_ext_csd(sd, size);
 }
 
 static void sd_set_csd(SDState *sd, uint64_t size)
@@ -1405,6 +1451,17 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
     return sd_r7;
 }
 
+/* CMD8 */
+static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                 sd->ext_csd, sizeof(sd->ext_csd));
+}
+
 /* CMD9 */
 static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
 {
@@ -2334,6 +2391,7 @@ uint8_t sd_read_byte(SDState *sd)
                            sd->data_offset, sd->data_size, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
+    case 8:  /* CMD8:   SEND_EXT_CSD */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
     case 13: /* ACMD13: SD_STATUS */
@@ -2511,6 +2569,7 @@ static const SDProto sd_proto_emmc = {
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {0,  sd_ac,   "SLEEP/AWAKE", emmc_cmd_sleep_awake},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
+        [8]  = {0,  sd_adtc, "SEND_EXT_CSD", emmc_cmd_SEND_EXT_CSD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [11] = {1,  sd_adtc, "READ_DAT_UNTIL_STOP", sd_cmd_unimplemented},
-- 
2.41.0


