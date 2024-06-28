Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB5CC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5lS-00035j-UO; Fri, 28 Jun 2024 03:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lR-0002wR-9h
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:21 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lO-0004t1-Ts
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:20 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52cdf2c7454so490009e87.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558676; x=1720163476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O1uKT3cac0wmROcR+mzv/OARkq5bGqfifIlHFoP/L2c=;
 b=IJD8sMiQRu1MiNtdEsXbjGqRKjcnF8jFpxl/icunh4J9BXteDh70FJxODeDInxTnk2
 bOgBlrK/ff2rujFjwlAq1gGRJolUjjwt+7bV/DJ9zQ03GmjP6Hi5cWUnnA0Nxlhg4ene
 BIqxvQUa7ErECigxI6reYFXQBhHvasaWdoUIl/RzTh/ZcuoLov6qP7vDYruK+XbDQe6B
 G5Y6g3GP3ExMtGV8yK4vkSTgAjW2H+ROLJN+rtHP0muXMs1GADTCC8CFb7Zwcs0h94rU
 th48orZPSUIj6yB+uziPIzXW65pbNTdoBJfvvMUa2oIjBRXqmGe8Nt1M6PQiKpNsEgww
 j1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558676; x=1720163476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1uKT3cac0wmROcR+mzv/OARkq5bGqfifIlHFoP/L2c=;
 b=GWEJ4nLLGvP7HCh8twwXpm51oNTUjLSUep1iMp4KpDtEGBhx72q/AFGsAcy+N059fu
 SzVxntmOFvsiJqOqAv2FoZqGC7B5ob5zh31QKHf/EyRjLWOEyrT17MKhKcky4LFc7P7g
 OEKmMpq5mAfniK0KoF3vGymT4BTwybWvzPG+iCMhxjhW4GYjbPD0j+4VEwna012wbKNr
 h//MIbG0zSdgcg1LEkPGYOzofBFiQgmPWMOb3eBk86uLAHxE27urVzrFRheAsF1DQikn
 sb+IJXeAY0ZlCpmcyeT5Qf8SoOdNYKxbxe9x7ZFt8/wdXLaFC1K4s+YyTEZzdB06Hrkw
 SSYw==
X-Gm-Message-State: AOJu0Yx/ZxW3EzGtmMsWmcTdoaHvpr8A37YILzVmP2FB5WHQoH8S7bpY
 AzNK2ZRaFMpfaSVIvbDjXfr3pUGZMiZMXxaifRPcZdjLoYPj5/wqK0kwiKfzK6AtjF1tsa8ETp+
 dkZQ=
X-Google-Smtp-Source: AGHT+IHYrxt90sv5VjlZN1Jqjm/rAQK2+o3a0c1ToSe8ydfjT5XeAxwdC8yPkIdumm6ZNRDQcrstFA==
X-Received: by 2002:a05:6512:78e:b0:52c:a20e:4da4 with SMTP id
 2adb3069b0e04-52ce185ca1amr11570128e87.57.1719558676598; 
 Fri, 28 Jun 2024 00:11:16 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cff9sm21738595e9.3.2024.06.28.00.11.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:11:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH v42 93/98] hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler
 (CMD8)
Date: Fri, 28 Jun 2024 09:02:09 +0200
Message-ID: <20240628070216.92609-94-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
TODO simplify params, see:
https://lore.kernel.org/qemu-devel/54bc25fd-acea-44a3-b696-c261e7e9706d@kaod.org/
---
 hw/sd/sd.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 82e0b5838f..0561079eff 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -122,6 +122,7 @@ struct SDState {
     uint16_t rca;
     uint32_t card_status;
     uint8_t sd_status[64];
+    uint8_t ext_csd[512];
 
     /* Static properties */
 
@@ -460,6 +461,82 @@ static const uint8_t sd_csd_rw_mask[16] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
 };
 
+static void mmc_set_ext_csd(SDState *sd, uint64_t size)
+{
+    uint32_t sectcount = size >> HWBLOCK_SHIFT;
+
+    memset(sd->ext_csd, 0, sizeof(sd->ext_csd));
+
+    sd->ext_csd[EXT_CSD_S_CMD_SET] = 0x1; /* supported command sets */
+    sd->ext_csd[EXT_CSD_HPI_FEATURES] = 0x3; /* HPI features  */
+    sd->ext_csd[EXT_CSD_BKOPS_SUPPORT] = 0x1; /* Background operations */
+    sd->ext_csd[241] = 0xA; /* 1st initialization time after partitioning */
+    sd->ext_csd[EXT_CSD_TRIM_MULT] = 0x1; /* Trim multiplier */
+    sd->ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] = 0x15; /* Secure feature */
+    sd->ext_csd[EXT_CSD_SEC_ERASE_MULT] = 0x96; /* Secure erase support */
+    sd->ext_csd[EXT_CSD_SEC_TRIM_MULT] = 0x96; /* Secure TRIM multiplier */
+    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
+    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
+    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */
+    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit size */
+    sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x1; /* HC erase timeout */
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
+static void sd_emmc_set_csd(SDState *sd, uint64_t size)
+{
+    sd->csd[0] = 0xd0;
+    sd->csd[1] = 0x0f;
+    sd->csd[2] = 0x00;
+    sd->csd[3] = 0x32;
+    sd->csd[4] = 0x0f;
+    if (size <= 2 * GiB) {
+        /* use 1k blocks */
+        uint32_t csize1k = (size >> (CMULT_SHIFT + 10)) - 1;
+        sd->csd[5] = 0x5a;
+        sd->csd[6] = 0x80 | ((csize1k >> 10) & 0xf);
+        sd->csd[7] = (csize1k >> 2) & 0xff;
+    } else { /* >= 2GB : size stored in ext CSD, block addressing */
+        sd->csd[5] = 0x59;
+        sd->csd[6] = 0x8f;
+        sd->csd[7] = 0xff;
+        sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
+    }
+    sd->csd[8] = 0xff;
+    sd->csd[9] = 0xff;
+    sd->csd[10] = 0xf7;
+    sd->csd[11] = 0xfe;
+    sd->csd[12] = 0x49;
+    sd->csd[13] = 0x10;
+    sd->csd[14] = 0x00;
+    sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
+    mmc_set_ext_csd(sd, size);
+}
+
 static void sd_set_csd(SDState *sd, uint64_t size)
 {
     int hwblock_shift = HWBLOCK_SHIFT;
@@ -1364,6 +1441,17 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
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
@@ -2297,6 +2385,7 @@ uint8_t sd_read_byte(SDState *sd)
                            sd->data_offset, sd->data_size, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
+    case 8:  /* CMD8:   SEND_EXT_CSD */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
     case 13: /* ACMD13: SD_STATUS */
@@ -2474,6 +2563,7 @@ static const SDProto sd_proto_emmc = {
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {0,  sd_ac,   "SLEEP/AWAKE", emmc_cmd_sleep_awake},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
+        [8]  = {0,  sd_adtc, "SEND_EXT_CSD", emmc_cmd_SEND_EXT_CSD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
@@ -2649,6 +2739,7 @@ static void emmc_class_init(ObjectClass *klass, void *data)
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     sc->proto = &sd_proto_emmc;
+    sc->set_csd = sd_emmc_set_csd;
 }
 
 static const TypeInfo sd_types[] = {
-- 
2.41.0


