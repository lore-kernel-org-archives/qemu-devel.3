Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB2EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY73-0004HF-M4; Wed, 10 Jul 2024 10:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY69-0000ET-AW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:15:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY64-00040P-JS
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:15:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so5618835e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720620902; x=1721225702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7ehYhE9tvvAz6fFzsukIT0qODV6ZW2fst3dCf28V88=;
 b=F0kKCgN+8bBrYbgYxN+VMPC+Xyy9bifFZSHTHSWwd3xNjI2xE+ucm2ZeeGyJWphCth
 mBYi5D7WLEw4yFlToforyG4T4/mat51B6I4gM/i6KY2qISUb2FC5DhV5Qz3DjDwcSUEp
 EsETLhAxXSI2+N4Mx7lG3l8S5JQWYoLr5zxm01st1LDyGPK4wwyNTDqR3wae4i9AgYne
 TaA5gvlu/VMEFD3Z29qZ/vwh3U8B7/83HJxULo0uRwr75n1X+zvH8LlmHRF4k91DMmxL
 CaQdJesjq1IQmYmbkLms3blMM2hz6JaUhw+bs++1MPzzrNYNBKR8cffox7L2VZFwfMxW
 BnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720620902; x=1721225702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7ehYhE9tvvAz6fFzsukIT0qODV6ZW2fst3dCf28V88=;
 b=UUUvzDXzhLjoluDHpi+R7XIIcjzGwFjtNkUS6IgqQuOueJuEQI/dwpU7NuruwJ+O4A
 pf3iH2vPGst0PRDOCOiRqDJFYAzzkBq1SHzR1ULrSoLOzUpXRBJdvEiM4k37wSDDJ9kN
 j0Wcps4Qfon6GN7K/oGo/VC2Xr9fAoGmoJ9f6TWx+1jS1Hlx074yhHrdtq/xuPLQi0sp
 Wa7tMuqjhfq+eYfleFEwnxNPswdG69D9WPJRJaAv5MvOOgjw9icN2VbhBHX4CQgWEfOT
 URoduyFZiKq0uXZFzTnudATU3cW9fWg4Bc0ByuoUL+PLCdePSxDEzzDZ2bvVxbkP9u6z
 RAwQ==
X-Gm-Message-State: AOJu0Yw/iXMIzCoPGLw1/7R9mf95dpYyDqVyiux8peylQ1V/ng6/3Epe
 K1EObdy/PWEhTDKXr4h59HBtIB0YjTv0/AZSXGPZR3Xd10hMd6yba7GkS3exUR2iWWhoy9QkOUD
 s
X-Google-Smtp-Source: AGHT+IH3ezxkRs63BC0khqh9/EvuEPK07N77U5wpANA3gcoD/eBho3bhyfg4/+wBygz5EUZSzQ2KFw==
X-Received: by 2002:a05:600c:63ce:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-426722c5b9emr52177275e9.4.1720620902611; 
 Wed, 10 Jul 2024 07:15:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6e097bsm85083135e9.6.2024.07.10.07.15.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 07:15:02 -0700 (PDT)
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v48 08/12] hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler
 (CMD8)
Date: Wed, 10 Jul 2024 16:14:04 +0200
Message-ID: <20240710141408.69275-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710141408.69275-1-philmd@linaro.org>
References: <20240710141408.69275-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
sizes.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>

EXT_CSD values from Vincent's patch simplivied for Spec v4.3:

- Remove deprecated keys:
  . EXT_CSD_SEC_ERASE_MULT
  . EXT_CSD_SEC_TRIM_MULT

- Set some keys to not defined / implemented:
  . EXT_CSD_HPI_FEATURES
  . EXT_CSD_BKOPS_SUPPORT
  . EXT_CSD_SEC_FEATURE_SUPPORT
  . EXT_CSD_ERASE_TIMEOUT_MULT
  . EXT_CSD_PART_SWITCH_TIME
  . EXT_CSD_OUT_OF_INTERRUPT_TIME

- Simplify:
  . EXT_CSD_ACC_SIZE (6 -> 1)
      16KB of super_page_size -> 512B (BDRV_SECTOR_SIZE)
  . EXT_CSD_HC_ERASE_GRP_SIZE (4 -> 1)
  . EXT_CSD_HC_WP_GRP_SIZE (4 -> 1)
  . EXT_CSD_S_C_VCC[Q] (8 -> 1)
  . EXT_CSD_S_A_TIMEOUT (17 -> 1)
  . EXT_CSD_CARD_TYPE (7 -> 3)
      Dual data rate -> High-Speed mode

- Update:
  . EXT_CSD_CARD_TYPE (7 -> 3)
      High-Speed MultiMediaCard @ 26MHz & 52MHz
  . Performances (0xa -> 0x46)
      Class B at 3MB/s. -> Class J at 21MB/s
  . EXT_CSD_REV (5 -> 3)
      Rev 1.5 (spec v4.41) -> Rev 1.3 (spec v4.3)

- Use load/store API to set EXT_CSD_SEC_CNT

- Remove R/W keys, normally zeroed at reset
  . EXT_CSD_BOOT_INFO

Migrate the Modes segment (192 lower bytes) but not the
full EXT_CSD register, see Spec v4.3, chapter 8.4
"Extended CSD register":

  The Extended CSD register defines the card properties
  and selected modes. It is 512 bytes long. The most
  significant 320 bytes are the Properties segment, which
  defines the card capabilities and cannot be modified by
  the host. The lower 192 bytes are the Modes segment,
  which defines the configuration the card is working in.
  These modes can be changed by the host by means of the
  SWITCH command.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cf130ad1e3..e6f1cc2066 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -124,6 +124,13 @@ struct SDState {
     uint16_t rca;
     uint32_t card_status;
     uint8_t sd_status[64];
+    union {
+        uint8_t ext_csd[512];
+        struct {
+            uint8_t ext_csd_rw[192]; /* Modes segment */
+            uint8_t ext_csd_ro[320]; /* Properties segment */
+        };
+    };
 
     /* Static properties */
 
@@ -476,6 +483,36 @@ static const uint8_t sd_csd_rw_mask[16] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
 };
 
+static void mmc_set_ext_csd(SDState *sd, uint64_t size)
+{
+    uint32_t sectcount = size >> HWBLOCK_SHIFT;
+
+    memset(sd->ext_csd, 0, sizeof(sd->ext_csd));
+
+    /* Properties segment (RO) */
+    sd->ext_csd[EXT_CSD_S_CMD_SET] = 0b1; /* supported command sets */
+    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x0; /* Boot information */
+    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
+    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x1; /* Access size */
+    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x01; /* HC Erase unit size */
+    sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x01; /* HC erase timeout */
+    sd->ext_csd[EXT_CSD_REL_WR_SEC_C] = 0x1; /* Reliable write sector count */
+    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x01; /* HC write protect group size */
+    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x01; /* Sleep current VCC  */
+    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x01; /* Sleep current VCCQ */
+    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x01; /* Sleep/Awake timeout */
+    stl_le_p(&sd->ext_csd[EXT_CSD_SEC_CNT], sectcount); /* Sector count */
+    sd->ext_csd[210] = 0x46; /* Min write perf for 8bit@52Mhz */
+    sd->ext_csd[209] = 0x46; /* Min read perf for 8bit@52Mhz  */
+    sd->ext_csd[208] = 0x46; /* Min write perf for 4bit@52Mhz */
+    sd->ext_csd[207] = 0x46; /* Min read perf for 4bit@52Mhz */
+    sd->ext_csd[206] = 0x46; /* Min write perf for 4bit@26Mhz */
+    sd->ext_csd[205] = 0x46; /* Min read perf for 4bit@26Mhz */
+    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0b11;
+    sd->ext_csd[EXT_CSD_STRUCTURE] = 2;
+    sd->ext_csd[EXT_CSD_REV] = 3;
+}
+
 static void emmc_set_csd(SDState *sd, uint64_t size)
 {
     int hwblock_shift = HWBLOCK_SHIFT;
@@ -512,6 +549,7 @@ static void emmc_set_csd(SDState *sd, uint64_t size)
         ((hwblock_shift << 6) & 0xc0);
     sd->csd[14] = 0x00;
     sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
+    mmc_set_ext_csd(sd, size);
 }
 
 static void sd_set_csd(SDState *sd, uint64_t size)
@@ -847,6 +885,24 @@ static const VMStateDescription sd_ocr_vmstate = {
     },
 };
 
+static bool vmstate_needed_for_emmc(void *opaque)
+{
+    SDState *sd = opaque;
+
+    return sd_is_emmc(sd);
+}
+
+static const VMStateDescription emmc_extcsd_vmstate = {
+    .name = "sd-card/ext_csd_modes-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_needed_for_emmc,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(ext_csd_rw, SDState, 192),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int sd_vmstate_pre_load(void *opaque)
 {
     SDState *sd = opaque;
@@ -894,6 +950,7 @@ static const VMStateDescription sd_vmstate = {
     },
     .subsections = (const VMStateDescription * const []) {
         &sd_ocr_vmstate,
+        &emmc_extcsd_vmstate,
         NULL
     },
 };
@@ -1405,6 +1462,17 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
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
@@ -2334,6 +2402,7 @@ uint8_t sd_read_byte(SDState *sd)
                            sd->data_offset, sd->data_size, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
+    case 8:  /* CMD8:   SEND_EXT_CSD */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
     case 13: /* ACMD13: SD_STATUS */
@@ -2511,6 +2580,7 @@ static const SDProto sd_proto_emmc = {
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {0,  sd_ac,   "SLEEP/AWAKE", emmc_cmd_sleep_awake},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
+        [8]  = {0,  sd_adtc, "SEND_EXT_CSD", emmc_cmd_SEND_EXT_CSD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [11] = {1,  sd_adtc, "READ_DAT_UNTIL_STOP", sd_cmd_unimplemented},
-- 
2.41.0


