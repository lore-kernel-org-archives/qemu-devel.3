Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAEAC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb2C-0006kO-KY; Thu, 31 Jul 2025 17:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapJ-0000xi-UT
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:28:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapG-0007uf-49
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:28:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso993452f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997312; x=1754602112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6t4dl7I3YR65XFWp3ATfpWTUnCa6FCBH5piCnGFOEbA=;
 b=hcLRFd7LG5LdT8pYLlh8Duhk5IWGe4LDY6uzAvrL2ThIoWDPIslUof7ZGbWNFRmJHt
 hZDBS267Wo0+/wXx2hOEygGggy5gthro0lM9DDnL1MShaHfcik8bs/Ks19zlxC3OYjOM
 QzxVYwwKqwUnJ6BYmYEFo1u3gDpjyd6SsAd7DDqOjziVvzOeBFaFf3jISLzLfFkvgWJD
 yT/pXd1vLOhOlZQ/AZnSPGzweSEVn3lIh7AgVrZcr3AD/bTzhgJEg88XaUGnwvFCUvOs
 mBCR4+bjc2dWbvDiC7u3ciW3ttNloEl+W1LShTaMXFmW0ZVkebZzRmdz4vWJ90fCscLX
 0DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997312; x=1754602112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6t4dl7I3YR65XFWp3ATfpWTUnCa6FCBH5piCnGFOEbA=;
 b=etNBJrrb1s02dFys+7ptUaTZpgqTXGlIWEpLo6EmkbzXDbC6QZ+BYD4JMopd8Ra8rR
 5IFaAHGlJ6lRffoSN8qyaCLy+CRomwPSP1XBHPMIpFo7eLSE3mgPyDpQjFRdtnzWrhBZ
 r/p5JFyeVfTd8dJ75UEZ/eYGKeAkuXpXTB8lFDQIfxGFC9VSXlKOuB4OXPiprAljkhKW
 2vue8jApSLezkYjrmKNXF+DFgt+Wxc/ZWPwu6bAA4TEl/0jmYYdLKmPKsqe5Vvmx3C/3
 WB2krg+bVtncg14Un3QQXTDb4b+/UN6P7JdJ7RQ/HFayooW2xwa72cjokF4VWj4ZuSuJ
 VyfA==
X-Gm-Message-State: AOJu0Yx8MnKL4SldEhiYqqHBAYan1V+l6p9cj+MAy+I0BtP2lwqSnSCw
 yCR4FxlpWnIVWaWvG5cyM7pdYlOIk8BS77BuTkvS0+G0HW04iosTby0On7R0odkpk1VtNufYtVE
 6T9oq
X-Gm-Gg: ASbGncsxM+D17nfqUltg5JBDf0a/GJZBbrKcGamQVT1YLBdBQkyuknwGpmldw+LGltT
 p78KE/ZbRxPDFXZoYKQyylbYr8Wb+dO7dK1hwSDc2TixQqKgHAg75Q4Ms8ZrHd0Jcni4T+ZQRng
 DD1/HEI6z2YoGJE1t73s6PIL4b7OjppT40B9q6Z3WObxo+lQ75KgoWZ0aD0d99QokL7yH7vhz5Q
 1abb2gocJ6VYshUcRS6X3NX0Jz/DR1D918Hmk2O5Da4ZaNklOHYNu/goVokjLeSeUbLrIblKypU
 p8h0vgCCTP8r4hBjWEY3ineYECoeJbr5iWN+o5hSDTJ15FjY0casMcLBlS63LTLu0cow6nSdytj
 3l7ZVzwTboAYPGRuW6JHvY4u97mxqIvLE84zjDJzkLwuGPD8OGCZF/P9jm2sjB5q+u8kPUMfS
X-Google-Smtp-Source: AGHT+IGM+QiNhY0H45ZaQRrmD89B5BwUhnmLFBeQd7WGDM/NkhjCE7ccuf/oqIrRdRrJt9Ep5Af0Ow==
X-Received: by 2002:a5d:5f52:0:b0:3b7:8ed8:1c80 with SMTP id
 ffacd0b85a97d-3b79d41deaemr2663579f8f.3.1753997312008; 
 Thu, 31 Jul 2025 14:28:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4534b3sm3532176f8f.47.2025.07.31.14.28.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Jul 2025 14:28:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Weiwei Li <liwei1518@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 04/11] hw/sd/sdcard: Fill SPI response bits in card
 code
Date: Thu, 31 Jul 2025 23:27:59 +0200
Message-ID: <20250731212807.2706-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250731212807.2706-1-philmd@linaro.org>
References: <20250731212807.2706-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

ssi-sd.c contains the SPI link layer adaptation,
while sd.c contains all the SD card internal details.

We already handle the response values in sd.c, but
missed the SPI case. Complete them (fill R1, prepend
R1 in R3/R7 and always return something in SPI mode).
Remove all the duplication in ssi-sd.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c     | 31 +++++++++++++++---
 hw/sd/ssi-sd.c | 87 ++++----------------------------------------------
 2 files changed, 34 insertions(+), 84 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 22bdb4ca3ab..f7c231d9f30 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -731,10 +731,25 @@ static int sd_req_crc_validate(SDRequest *req)
 
 static size_t sd_response_r1_make(SDState *sd, uint8_t *response, size_t respsz)
 {
-    size_t rsplen = 4;
+    size_t rsplen;
 
-    assert(respsz >= 4);
-    stl_be_p(response, sd->card_status);
+    if (sd_is_spi(sd)) {
+        assert(respsz >= 1);
+        response[0] = sd->state == sd_idle_state
+                   && !FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP);
+        response[0] |= FIELD_EX32(sd->card_status, CSR, ERASE_RESET) << 1;
+        response[0] |= FIELD_EX32(sd->card_status, CSR, ILLEGAL_COMMAND) << 2;
+        response[0] |= FIELD_EX32(sd->card_status, CSR, COM_CRC_ERROR) << 3;
+        response[0] |= FIELD_EX32(sd->card_status, CSR, ERASE_SEQ_ERROR) << 4;
+        response[0] |= FIELD_EX32(sd->card_status, CSR, ADDRESS_ERROR) << 5;
+        response[0] |= FIELD_EX32(sd->card_status, CSR, BLOCK_LEN_ERROR) << 6;
+        response[0] |= 0 << 7;
+        rsplen = 1;
+    } else {
+        assert(respsz >= 4);
+        stl_be_p(response, sd->card_status);
+        rsplen = 4;
+    }
 
     /* Clear the "clear on read" status bits */
     sd->card_status &= ~CARD_STATUS_C;
@@ -746,6 +761,10 @@ static size_t sd_response_r3_make(SDState *sd, uint8_t *response, size_t respsz)
 {
     size_t rsplen = 4;
 
+    if (sd_is_spi(sd)) {
+        rsplen += sd_response_r1_make(sd, response, respsz);
+        response++;
+    }
     assert(respsz >= rsplen);
     stl_be_p(response, sd->ocr & ACMD41_R3_MASK);
 
@@ -771,6 +790,10 @@ static size_t sd_response_r7_make(SDState *sd, uint8_t *response, size_t respsz)
 {
     size_t rsplen = 4;
 
+    if (sd_is_spi(sd)) {
+        rsplen += sd_response_r1_make(sd, response, respsz);
+        response++;
+    }
     assert(respsz >= rsplen);
     stl_be_p(response, sd->vhs);
 
@@ -2261,7 +2284,7 @@ send_response:
         sd->data_offset = 0;
         /* fall-through */
     case sd_illegal:
-        rsplen = 0;
+        rsplen = sd_is_spi(sd) ? sd_response_r1_make(sd, response, respsz) : 0;
         break;
     default:
         g_assert_not_reached();
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 3aba0e08ffe..79b6d34a489 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -70,23 +70,6 @@ struct ssi_sd_state {
 #define TYPE_SSI_SD "ssi-sd"
 OBJECT_DECLARE_SIMPLE_TYPE(ssi_sd_state, SSI_SD)
 
-/* State word bits.  */
-#define SSI_SDR_LOCKED          0x0001
-#define SSI_SDR_WP_ERASE        0x0002
-#define SSI_SDR_ERROR           0x0004
-#define SSI_SDR_CC_ERROR        0x0008
-#define SSI_SDR_ECC_FAILED      0x0010
-#define SSI_SDR_WP_VIOLATION    0x0020
-#define SSI_SDR_ERASE_PARAM     0x0040
-#define SSI_SDR_OUT_OF_RANGE    0x0080
-#define SSI_SDR_IDLE            0x0100
-#define SSI_SDR_ERASE_RESET     0x0200
-#define SSI_SDR_ILLEGAL_COMMAND 0x0400
-#define SSI_SDR_COM_CRC_ERROR   0x0800
-#define SSI_SDR_ERASE_SEQ_ERROR 0x1000
-#define SSI_SDR_ADDRESS_ERROR   0x2000
-#define SSI_SDR_PARAMETER_ERROR 0x4000
-
 /* multiple block write */
 #define SSI_TOKEN_MULTI_WRITE   0xfc
 /* terminate multiple block write */
@@ -104,7 +87,7 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
 {
     ssi_sd_state *s = SSI_SD(dev);
     SDRequest request;
-    uint8_t longresp[16];
+    uint8_t longresp[5];
 
     /*
      * Special case: allow CMD12 (STOP TRANSMISSION) while reading data.
@@ -171,74 +154,18 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
             /* FIXME: Check CRC.  */
             request.cmd = s->cmd;
             request.arg = ldl_be_p(s->cmdarg);
-            DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
             s->arglen = sdbus_do_command(&s->sdbus, &request,
                                          longresp, sizeof(longresp));
-            if (s->arglen == 0) {
-                s->arglen = 1;
-                s->response[0] = 4;
-                DPRINTF("SD command failed\n");
-            } else if (s->cmd == 8 || s->cmd == 58) {
-                /* CMD8/CMD58 returns R3/R7 response */
-                DPRINTF("Returned R3/R7\n");
-                s->arglen = 5;
-                s->response[0] = 1;
-                memcpy(&s->response[1], longresp, 4);
-            } else if (s->arglen != 4) {
-                BADF("Unexpected response to cmd %d\n", s->cmd);
-                /* Illegal command is about as near as we can get.  */
-                s->arglen = 1;
-                s->response[0] = 4;
-            } else {
-                /* All other commands return status.  */
-                uint32_t cardstatus;
-                uint16_t status;
+            DPRINTF("CMD%d arg 0x%08x = %d\n", s->cmd, request.arg, s->arglen);
+            assert(s->arglen > 0);
                 /* CMD13 returns a 2-byte statuse work. Other commands
                    only return the first byte.  */
                 s->arglen = (s->cmd == 13) ? 2 : 1;
+            memcpy(s->response, longresp, s->arglen);
 
-                /* handle R1b */
-                if (s->cmd == 28 || s->cmd == 29 || s->cmd == 38) {
-                    s->stopping = 1;
-                }
-
-                cardstatus = ldl_be_p(longresp);
-                status = 0;
-                if (((cardstatus >> 9) & 0xf) < 4)
-                    status |= SSI_SDR_IDLE;
-                if (cardstatus & ERASE_RESET)
-                    status |= SSI_SDR_ERASE_RESET;
-                if (cardstatus & ILLEGAL_COMMAND)
-                    status |= SSI_SDR_ILLEGAL_COMMAND;
-                if (cardstatus & COM_CRC_ERROR)
-                    status |= SSI_SDR_COM_CRC_ERROR;
-                if (cardstatus & ERASE_SEQ_ERROR)
-                    status |= SSI_SDR_ERASE_SEQ_ERROR;
-                if (cardstatus & ADDRESS_ERROR)
-                    status |= SSI_SDR_ADDRESS_ERROR;
-                if (cardstatus & CARD_IS_LOCKED)
-                    status |= SSI_SDR_LOCKED;
-                if (cardstatus & (LOCK_UNLOCK_FAILED | WP_ERASE_SKIP))
-                    status |= SSI_SDR_WP_ERASE;
-                if (cardstatus & SD_ERROR)
-                    status |= SSI_SDR_ERROR;
-                if (cardstatus & CC_ERROR)
-                    status |= SSI_SDR_CC_ERROR;
-                if (cardstatus & CARD_ECC_FAILED)
-                    status |= SSI_SDR_ECC_FAILED;
-                if (cardstatus & WP_VIOLATION)
-                    status |= SSI_SDR_WP_VIOLATION;
-                if (cardstatus & ERASE_PARAM)
-                    status |= SSI_SDR_ERASE_PARAM;
-                if (cardstatus & (OUT_OF_RANGE | CID_CSD_OVERWRITE))
-                    status |= SSI_SDR_OUT_OF_RANGE;
-                /* ??? Don't know what Parameter Error really means, so
-                   assume it's set if the second byte is nonzero.  */
-                if (status & 0xff)
-                    status |= SSI_SDR_PARAMETER_ERROR;
-                s->response[0] = status >> 8;
-                s->response[1] = status;
-                DPRINTF("Card status 0x%02x\n", status);
+            /* handle R1b (busy signal) */
+            if (s->cmd == 28 || s->cmd == 29 || s->cmd == 38) {
+                s->stopping = 1;
             }
             s->mode = SSI_SD_PREP_RESP;
             s->response_pos = 0;
-- 
2.49.0


