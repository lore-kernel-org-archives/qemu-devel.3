Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D51C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 13:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0Hh-0003HA-Mt; Wed, 03 Jul 2024 09:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0HR-0003AP-D1
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0HP-0005GR-AJ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42574064b16so34794525e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720014251; x=1720619051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lheN2UZMBb1e7Ny7MPY0NhL8/gxKGWw4Q5bOqqSNEG0=;
 b=G5uoSqEAuFgnaZ+pQEnatBiEKDi/CbZunsjE8X2GsGdP1s5AI25QeMG/sIOrkln456
 JpY0Dva3h4maVR3ksJOh66p25gYoXM8KJZaUeG0Gch8u3jb1p4u2Zzr8sx01Gwk847Y7
 +6s72sy0uoQ9OhwpBFa/sTVGTgmqKv3ES/sq1VkhUmnPPT3ODFNVZKADN0eDGm/uQQiS
 YhKQgYnepSmmYA+YEhXM1MQ5dst9EgGRydSYenOD4OITkAFWZ4sR0gyLo6c1ptmM2gP1
 3evcIf7Vtgok5g9rFaJifOVHs9iqDLMpcLYGVs9C7UbwxrThzWeLJ/sBadkK72VNAT8u
 vf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720014251; x=1720619051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lheN2UZMBb1e7Ny7MPY0NhL8/gxKGWw4Q5bOqqSNEG0=;
 b=TK30HeN9YjU0GMIUUTw13B01v6O5cM3Qs/yRwXuz5IbsJDFLJwD4xhA+lV0exxw27R
 TWUNbBfsiZs+/Ee56sHBt/pQ5W14WlbFl3FlRphG158izzZIJUF3eB1NYuV5zdT+0LdG
 NOlOOmHzcyICRrmNTL79lW1mgB+mgeh+YRAYrL393N8+RCprA1sw5cI96Ld2fYlliCHi
 kalG8pIVEuipOAD0CrvRFhcSW5F9UlnMiR+A8c5xb39aNd1J0d7exTlFJo9ZUMfl8SIw
 MnqJa6n1PqUftMqwNuXtRZFGgdMbpR1MVolsqA3jhBMU/YIWfaAFN+2EgYu0dcBbsos6
 VOog==
X-Gm-Message-State: AOJu0Yx/n7D6iFlx37pKWBbx/opNxZK3UKcoV0q4MplQpy5M3tNkEGSO
 NGq3Ns+W5POepNHQwns+qHnC9CjrqxEF2Rp0tl3+G2sfPhNpZ4NNg08NC8nJp1J5OW0XDeI0dmA
 t
X-Google-Smtp-Source: AGHT+IHoDcKo33dvtZqXfXPEKAOjiZErtanGSQmkn6kUcsmoCxHBrHfV9tcwtfTunA8iAMwrApsjLQ==
X-Received: by 2002:a05:600c:1616:b0:425:6bea:8554 with SMTP id
 5b1f17b1804b1-4257a05fa13mr77764985e9.27.1720014251349; 
 Wed, 03 Jul 2024 06:44:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256f55c4b5sm226785945e9.43.2024.07.03.06.44.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 06:44:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v46 2/5] hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
Date: Wed,  3 Jul 2024 15:43:53 +0200
Message-ID: <20240703134356.85972-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703134356.85972-1-philmd@linaro.org>
References: <20240703134356.85972-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

"General command" (GEN_CMD, CMD56) is described as:

  GEN_CMD is the same as the single block read or write
  commands (CMD24 or CMD17). The difference is that [...]
  the data block is not a memory payload data but has a
  vendor specific format and meaning.

Thus this block must not be stored overwriting data block
on underlying storage drive. Handle as RAZ/WI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 54 ++++++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a08a452d81..04e8fdb262 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -243,7 +243,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
         [40]    = "DPS_spec",
-        [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
@@ -902,9 +901,6 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
-#define APP_READ_BLOCK(a, len)  memset(sd->data, 0xec, len)
-#define APP_WRITE_BLOCK(a, len)
-
 static void sd_erase(SDState *sd)
 {
     uint64_t erase_start = sd->erase_start;
@@ -1641,6 +1637,22 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD56 */
+static sd_rsp_type_t sd_cmd_GEN_CMD(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    /* Vendor specific command: our model is RAZ/WI */
+    if (req.arg & 1) {
+        memset(sd->data, 0, sizeof(sd->data));
+        return sd_cmd_to_sendingdata(sd, req, 0, NULL, 0);
+    } else {
+        return sd_cmd_to_receivingdata(sd, req, 0, 0);
+    }
+}
+
 /* CMD58 */
 static sd_rsp_type_t spi_cmd_READ_OCR(SDState *sd, SDRequest req)
 {
@@ -1836,22 +1848,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Application specific commands (Class 8) */
-    case 56:  /* CMD56:  GEN_CMD */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->data_offset = 0;
-            if (req.arg & 1)
-                sd->state = sd_sendingdata_state;
-            else
-                sd->state = sd_receivingdata_state;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
@@ -2187,11 +2183,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
-            APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
-            sd->state = sd_transfer_state;
-        }
+        sd_generic_write_byte(sd, value);
         break;
 
     default:
@@ -2233,6 +2225,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 22: /* ACMD22: SEND_NUM_WR_BLOCKS */
     case 30: /* CMD30:  SEND_WRITE_PROT */
     case 51: /* ACMD51: SEND_SCR */
+    case 56: /* CMD56:  GEN_CMD */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2260,15 +2253,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 56:  /* CMD56:  GEN_CMD */
-        if (sd->data_offset == 0)
-            APP_READ_BLOCK(sd->data_start, sd->blk_len);
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= sd->blk_len)
-            sd->state = sd_transfer_state;
-        break;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
         return 0x00;
@@ -2323,6 +2307,7 @@ static const SDProto sd_proto_spi = {
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
         [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
+        [56] = {8,  sd_spi, "GEN_CMD", sd_cmd_GEN_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {0,  sd_spi, "READ_OCR", spi_cmd_READ_OCR},
         [59] = {0,  sd_spi, "CRC_ON_OFF", spi_cmd_CRC_ON_OFF},
@@ -2383,6 +2368,7 @@ static const SDProto sd_proto_sd = {
         [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
         [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
+        [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
         [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
-- 
2.41.0


