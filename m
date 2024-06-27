Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE1C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsI5-0007yC-K8; Thu, 27 Jun 2024 12:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsH2-0006aW-7I
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:47:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsH0-0000Wz-DV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:47:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-361785bfa71so6178464f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506818; x=1720111618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6DmY6CGyXMJfzQtpsncnrmxkBN2T3nvO/hOHeba5R0=;
 b=MqPxBVp8I62O4EIDgFhykYvSoglO/gG+VPeRFXViwR7/1rQZpYl87O1gcinGAh5cPB
 7GaD864UkE9mNrCEoIqBdsARN7wz8STNCnDGfqzsmwmu/MvlFvREV8rMgv/CGfaY2IqL
 1Ek4vr0HDJE6YTiszw7gyH4xjRjshBSF6u8lD3/G/kDHsch+2dJ788uNoKnkM/UFh+jV
 MweoEyz4RWc/pZZKyoS14UU8Y+bcdFzi7txMf3lo4QBZD89F3Jk2nUFc+ZvLc9fVdGjR
 7EDlVub3WGhaU/M1SETo1lm79g406Vot1r8PzmADL2w3O3EbParUc5U93/yD1MFKlK0c
 pMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506818; x=1720111618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6DmY6CGyXMJfzQtpsncnrmxkBN2T3nvO/hOHeba5R0=;
 b=qMcT9oo03GiUnYA5FX+fLTchLHPMj2yS+5C4ULO0ektgaSeDrKoNXUPIKqDstcFNkR
 WiaY9GYFAPt/5tc7GIrvjwYXntpA3q2ebsQxR3CzF6tsWcE0FvTI7lYyq4zinhjyliX2
 5dcahE3XxivE/NOyZ/uZg8rZezzTmrneMV6jmWBNlUml1pm2HKKZAfNvK1SonnfvQgOb
 jbjAkGWp1H+66VbCcaw0y8jIrWlt60PfdtB1XbwQC9+/BWY8Wj3vIwClco9Yl9qawBIM
 P/fPzu+jZ8AbKa0GkzfdTTkH+LLWi87lXvoy54pvC3k1JcHxrMlN2evtTwmrC9q3ya8X
 xsNg==
X-Gm-Message-State: AOJu0YyPwb1d8+4xsdxWhHJKFTFZo/lSOINZM17v/vWpcSdprnWUaWBq
 6S1twQxs8HfwGvGqVTf6HHokQ8bQfQbHQB/6Aeyu+ArSauVeHO4n4xz+JOj3w9WG8PHWm3aZaZ6
 McY4=
X-Google-Smtp-Source: AGHT+IEy91KAsYZOW+ce9WLe8WFS5a/erVD373Kk7+ZZoaJfJ534wVWLYccPyx0Ex/eQ1P2svOoKuA==
X-Received: by 2002:adf:f043:0:b0:362:ebf5:3fd with SMTP id
 ffacd0b85a97d-366e7a0fc8bmr8917928f8f.30.1719506818516; 
 Thu, 27 Jun 2024 09:46:58 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c173sm2458889f8f.18.2024.06.27.09.46.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:46:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 19/21] hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
Date: Thu, 27 Jun 2024 18:43:42 +0200
Message-ID: <20240627164345.82192-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5461e56e17..50cee5ac40 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -245,7 +245,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
         [40]    = "DPS_spec",
-        [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
@@ -910,9 +909,6 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
-#define APP_READ_BLOCK(a, len)  memset(sd->data, 0xec, len)
-#define APP_WRITE_BLOCK(a, len)
-
 static void sd_erase(SDState *sd)
 {
     uint64_t erase_start = sd->erase_start;
@@ -1649,6 +1645,21 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD56 */
+static sd_rsp_type_t sd_cmd_GEN_CMD(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    if (req.arg & 1) {
+        return sd_cmd_to_sendingdata(sd, req, 0,
+                                     sd->vendor_data, sizeof(sd->vendor_data));
+    } else {
+        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->vendor_data));
+    }
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1737,21 +1748,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     /* Application specific commands (Class 8) */
-    case 56:  /* CMD56:  GEN_CMD */
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (req.arg & 1) {
-                return sd_cmd_to_sendingdata(sd, req, 0,
-                                             sd->vendor_data,
-                                             sizeof(sd->vendor_data));
-            }
-            return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->vendor_data));
-
-        default:
-            break;
-        }
-        break;
-
     case 58:    /* CMD58:   READ_OCR (SPI) */
         return sd_r3;
 
@@ -2323,6 +2319,7 @@ static const SDProto sd_proto_spi = {
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
         [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
+        [56] = {8,  sd_spi, "GEN_CMD", sd_cmd_GEN_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
     },
     .acmd = {
@@ -2376,6 +2373,7 @@ static const SDProto sd_proto_sd = {
         [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
         [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
+        [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
         [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
-- 
2.41.0


