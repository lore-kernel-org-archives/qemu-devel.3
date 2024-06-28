Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54515C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jO-0006Nz-01; Fri, 28 Jun 2024 03:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5j9-00066U-MY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:01 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5j7-0004Tj-3L
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:59 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52cdcd26d61so269891e87.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558533; x=1720163333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h6DmY6CGyXMJfzQtpsncnrmxkBN2T3nvO/hOHeba5R0=;
 b=pdiP6xIaJ326veRXGCoJjdhnMFWn7DtPh5GlW9mlz46TzMh8NILNBQX11RLBZqG5ve
 4YdnMpvFH+Ye4OnCpW0LHKhIHRr/vSuAXPkgCHnEKYMLKqiywzL04BlgB0RAO7ziuOKn
 nGTgcdAlh6udRFwAAIsTC+JVWfv2BGBWtS4NakerhW3QzMsXzLkoEgb2uE/69YKYO8An
 D4Hnlw85uoJIru673AQfXSx4SPd42D2t/F6K6jFUXkjVn0QATaen4/wIRoHxKgGZ2yXo
 rUu/osB99iGgBURozb08oM615FZZwP2JSA0NXNfLowijJBxqoXJco+i6DIOak2x/PN+I
 VYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558533; x=1720163333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6DmY6CGyXMJfzQtpsncnrmxkBN2T3nvO/hOHeba5R0=;
 b=ixskX+oWDtc+21Og7NC1RNDgf+i4zqiyTl8HM9KBa6P6Z20ZWSxaXXRmQ2mGwiEIC3
 VCb4YPE/2olroV66zSyFvA8HmtcfaLO4zIVV39sz+oLrWgqjEcJFrkkI6GcmmMvVhwY/
 QPPHkODiUGSRlTLCY4YznzPYJXTlmC2WOxgnT78V2zd2GnkjcaBb0FyWXks5lTnPBa9W
 IBK9m1zTETJ63RijcxuG9QrVtC/zHCjq8M/Fj8rSLGwewqWGs01vuyEaGYEhFhuoAO5h
 Goddgdb9OA0VyNT7SR3rpoNZznlkyogf5QKeAEb7f0QudbeIVUFUSFXN9DdPwaWWuLOf
 Tvcw==
X-Gm-Message-State: AOJu0YxmZ/x5PFsTgBghM/dOPsoBNJlfEjTNK4c1e4LiJt0HX4hYJ+ui
 4hZJSpvWPwVG+xfwAJDyTf3KMoemFky3DXmMsGuGQG5tua/5N98PcXZ6ZNbAVd15Hz3OXbt+yu4
 /T0k=
X-Google-Smtp-Source: AGHT+IFfejR4iJ7GMffQM4Pi3vAQ/OzXvgektCNw188GjoKbUdEFe4olrmCcf3lbqTalp0y05PE3Jw==
X-Received: by 2002:ac2:5f79:0:b0:52c:e3af:7c5c with SMTP id
 2adb3069b0e04-52ce3af7c8amr8324604e87.34.1719558532966; 
 Fri, 28 Jun 2024 00:08:52 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097c2asm21502445e9.38.2024.06.28.00.08.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 65/98] hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
Date: Fri, 28 Jun 2024 09:01:41 +0200
Message-ID: <20240628070216.92609-66-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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


