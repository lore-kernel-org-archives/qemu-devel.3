Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E192C38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr40-0005ZP-Ky; Fri, 05 Jul 2024 18:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3z-0005W2-Nu
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3r-0007kd-Pt
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-367a3d1a378so1067750f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217146; x=1720821946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Fo92bzXq4eAEZevJy+NJbZOPajl0wf8VkKPf0JYwAk=;
 b=AAwaXhnkXFpSujaa1CT/6ogU45jwfaCLwvNlRkuXOuxirg/rt4rgYl6ggPsoJpPb3f
 3rvbLxbhVfD92vA/I3R382Ydj0XKZjNj0yItrF//uETe4fhR3+qO/L1/TfWFqUWe9LAd
 ZIEacLW/+cwKl1TQpsAzSUmk9956p5dUO4SfdRo4Ccijw7olKME5HOpWJk0wbSdf50hy
 RO2m/fG6QvTeWkL+QH1VGKkc83k8rBxttKcsslScwBr5EK+JoViExmxK+C0OaEGccRv+
 go3bdzXowlRSMse4SyCfuT+PaKXNX+7PmH6HvxeRhdlCLX18hVLi//KJ40CHIiWydcU6
 sg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217146; x=1720821946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Fo92bzXq4eAEZevJy+NJbZOPajl0wf8VkKPf0JYwAk=;
 b=myUJ/Y4GCl4ayN+15R4Ut98W0UINJkdMFaAFqcGyxPKqe3e4rNJnbVu8hpBSORsyX8
 TSyPx27C5mIf+79sOg9nb5SJQtIJhPJVR2mpNnUUtRgbMSxogOa0ShBi9/FYKrp4Pnex
 VUsT5RuAfkLxVzKBv4NmQ4XOh+VjFgezBC+gnRwMtDCm1aVw4ZpTx7JP1/Fwa8mDyqgA
 JVuadnfusH53dYfLcUGqsK1/pK2YWQ7Y/agO1y3DRbA3hVvbH1j6G4aF+zPXVXf7CRFd
 pp/DOm13qggQsulBp5acv18UCoFloY/gDLiAF6OGa2MfOFQz+asvnclv2V23AlmssxoW
 K4Ww==
X-Gm-Message-State: AOJu0YycKbzQkaO+ugqFqGWpUKUxDXWEZMWaGCpHymkvi72aAKnwd6ev
 mWmDrFjcy7w7kNx1kiYGrC4aSxXb3S3W0OX50qugcebCIDxhdzNSGEAuVudQKc33KdH4EqO+HNk
 D
X-Google-Smtp-Source: AGHT+IEp+VfYKTQDX1MpmRphU3mqu6ri+OqVgTxq8mKZZA6kbdbAcc7cNWliLoMFBW2Tf5qrk8oA8g==
X-Received: by 2002:adf:e34c:0:b0:367:9b1e:7b3b with SMTP id
 ffacd0b85a97d-3679dd7192dmr4987912f8f.59.1720217146052; 
 Fri, 05 Jul 2024 15:05:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264aa07a95sm73359535e9.1.2024.07.05.15.05.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 13/16] hw/sd/sdcard: Trace length of data read on DAT lines
Date: Sat,  6 Jul 2024 00:04:31 +0200
Message-ID: <20240705220435.15415-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Some commands expect less than BLOCK_LENGTH.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-80-philmd@linaro.org>
---
 hw/sd/sd.c         | 4 ++--
 hw/sd/trace-events | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3f495f91fe..9e6b9c9c63 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2193,8 +2193,8 @@ uint8_t sd_read_byte(SDState *sd)
     io_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
-                           sd->last_cmd_name,
-                           sd->current_cmd, sd->data_offset, io_len);
+                           sd->last_cmd_name, sd->current_cmd,
+                           sd->data_offset, sd->data_size, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 6a51b0e906..5dfe6be7b7 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -55,7 +55,7 @@ sdcard_req_addr(uint32_t req_arg, uint64_t addr) "req 0x%" PRIx32 " addr 0x%" PR
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
-sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint32_t length) "%s %20s/ CMD%02d ofs %"PRIu32" len %" PRIu32
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint64_t size, uint32_t blklen) "%s %20s/ CMD%02d ofs %"PRIu32" size %"PRIu64" blklen %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # pxa2xx_mmci.c
-- 
2.41.0


