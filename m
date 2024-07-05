Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AA0C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3V-0002lw-EV; Fri, 05 Jul 2024 18:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3T-0002b7-UN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:23 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3R-0007ao-Ti
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:23 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ee4ae13aabso21280081fa.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217119; x=1720821919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9D/WC7IdxNIJk6AHwWA75pe1sGPv4JT8i2Sn6RjhLY=;
 b=UPJVTWigr1nz7qhxhxMLkMl1QnA3dyjWaAoAJRDVuFg+kaT1u1+/TSDXnZNAH33Ihi
 mAGrRfvHpr21hmPYvQ4UHbJTsjXaC1XIIbllppPpMAQHhLKaRBoykH70EIr2zII+ndGs
 dgpTXwgpYEd8sCBNNXZWIIK7eMYGsRfhb6CNSAJLv+KYPHF6XjC+rR1Zgz5NkhLA1EOF
 SJzldqAPgZ1iJc0GUK2tNm8nsebRJLEvA9Fzj7TqTGre2qr7SWdCoPAxBeRABpDEZf2J
 ILODxWy4R9b8EYcfQuPZjk66pC/UUbucbnrL9NBr+9uX2QuhSjirDz2SBUlebsCFhLA5
 KHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217119; x=1720821919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9D/WC7IdxNIJk6AHwWA75pe1sGPv4JT8i2Sn6RjhLY=;
 b=Pc+uhe3DOiS7RMHW4WNmu9yFTuuGYqk581HFv1zRpFFjLl9NLCf2l7x6dkZW5wB7Eh
 C/FZ/kOsbHvTCyxlJ+M+7Aih1ijxIa1jhYj4k1G8VsIL+JGsJtM0w6pnDuM5tzazNzVf
 dkBnR7unoJj4NNf/SFgrwqPTKA4PTgFi+ec4Y8jK5pIUHJBAXGrdBK+LmvIbVqmUpAf+
 uVFKmn84X+b6pPNuZwGLVLjsf0ky8RCpaMe9cn3AbXblMgkRbijfnaR4TpplQHVrh+O+
 3CBivt4jgg7RTIYCak20rFkPBg5CxkRoVSvv+HxAhmQBn1O+Cyu0bU3fiFuK07M0u6jF
 qVUA==
X-Gm-Message-State: AOJu0YxzB3oswiKJaR7/xYC7BzMdEvgZkzB7STE3SJqyYzzw6ETIBipA
 B27rSw2u0QiMANOYJ72SLwzFgoPfRIvGwhFOGf3gwt/j/hAM4VwLE0sVJ4WV9SvipWzUJzzX6u+
 F
X-Google-Smtp-Source: AGHT+IG1NrXTtvKE0/gC2BkJSpVAcK3dCnqIch9eydENs2uP9aw6rKTl7r+NTujlIH08W+Ca5Wqgkg==
X-Received: by 2002:a2e:bb85:0:b0:2ee:8817:422b with SMTP id
 38308e7fff4ca-2ee8ed8f728mr32341751fa.19.1720217119568; 
 Fri, 05 Jul 2024 15:05:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f23c1sm75363905e9.28.2024.07.05.15.05.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/16] hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
Date: Sat,  6 Jul 2024 00:04:26 +0200
Message-ID: <20240705220435.15415-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
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

"General command" (GEN_CMD, CMD56) is described as:

  GEN_CMD is the same as the single block read or write
  commands (CMD24 or CMD17). The difference is that [...]
  the data block is not a memory payload data but has a
  vendor specific format and meaning.

Thus this block must not be stored overwriting data block
on underlying storage drive. Handle as RAZ/WI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240703134356.85972-3-philmd@linaro.org>
---
 hw/sd/sd.c | 54 ++++++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8618c2bcf0..10f2764a53 100644
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


