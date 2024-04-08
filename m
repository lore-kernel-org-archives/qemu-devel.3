Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E0FC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpon-0001ne-JL; Mon, 08 Apr 2024 10:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtpoY-0001g5-P3
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:17:39 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtpoV-0002xV-VH
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:17:38 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d87660d5dbso22289361fa.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712585852; x=1713190652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0UPUS6B8fn4peMJtb8NBu9x0+Ma6yL7q2dFjDj2dHM=;
 b=LSeYys5BGQu24Pq4BayAUEbiqv01yuxq4lUqsaQbLkMix6LVmTu2p41BqgfOpfyQNK
 ryjf6hS7tCxJP3SinRioCahtJ2itjMdHfl3iN0+N4r0cTQzJVanUDD5GC47BVirdBhIr
 iSUaIhiUQTPletkX5ujFGyn1bhrT4Kg8OLVhkCcgB2jJpS9siGwyJ7yrGfPUjOfKBp14
 UsndyD1V0FMRQRvzFKQrVeIvz7SWbl2kjMLlZjM4j4tXKHnIPyhSlIq8SCsAMr189HkH
 mNraB6XgOCQioDADVuzlR7c/kFFqFsPVQ13bfJsVXnCMVCGjhyxzERZgKF/wg8MNORmO
 p4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585852; x=1713190652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0UPUS6B8fn4peMJtb8NBu9x0+Ma6yL7q2dFjDj2dHM=;
 b=Td66TJgS73Kd49iRnJjWw610kMAHsuyuG6WHAVkgpIzao1RxCwEaY6F4Y+u7LEtSGg
 ThbClmbK98Zbjwxt3aHtAdJ5n8cK2MfmRL/SyYFdlVDPzXsedtCtRvUH2WDSuch8lXGA
 8dP5Dy6BIZ13UjXygSqGjh0zXr7WhXNSeZ355TEw8GavEXYxLM8zXF60WynZhayoUR6Q
 SnfwzGpbvgu7Sr7MqtFeqO6rw0eOpX72GnYKN+TMwpr/zi3P/A5DMYnAiApy4ELbircw
 9Z9t27zgcXrwTn7RpCruo8oXrEP98ltBTrL5ieI/4t9lKmxjHVqqLHuUQ+oiWiPZc7NI
 6sng==
X-Gm-Message-State: AOJu0YwJuom/lSsPqZjGWegP1/UYjJGNP/XvKcoBxysPNxbAn1AgH1f3
 pDQcZmKIC8/OuLy4+F8WZHAhFCEZfyt3byq2UhYbltbwKhW0E1a9PtvbBGOxCbBC6e3pvLz7aH/
 P
X-Google-Smtp-Source: AGHT+IF1qDQN4FpawTyG5l+AZ5jaeVkWal0BZgP4mizfese9A8aA0Wy5h8ef64YWEw/4ZwxN8ae1iQ==
X-Received: by 2002:a05:6512:4896:b0:516:d250:86bd with SMTP id
 eq22-20020a056512489600b00516d25086bdmr5722907lfb.44.1712585852562; 
 Mon, 08 Apr 2024 07:17:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a0564020e8100b005682a0e915fsm4138014eda.76.2024.04.08.07.17.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 07:17:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org
Subject: [PATCH-for-9.1 2/2] hw/sd/sdcard: Assert @data_offset is in range
Date: Mon,  8 Apr 2024 16:17:17 +0200
Message-ID: <20240408141717.66154-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408141717.66154-1-philmd@linaro.org>
References: <20240408141717.66154-1-philmd@linaro.org>
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

Prevent out-of-bound access with assertions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 16d8d52a78..c081211582 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1875,6 +1875,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
+        assert(sd->data_offset < sizeof(sd->data));
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
@@ -1901,6 +1902,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
                 }
             }
         }
+        assert(sd->data_offset < sizeof(sd->data));
         sd->data[sd->data_offset++] = value;
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
@@ -1925,6 +1927,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
+        assert(sd->data_offset < sizeof(sd->data));
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sizeof(sd->cid)) {
             /* TODO: Check CRC before committing */
@@ -1944,6 +1947,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 27:  /* CMD27:  PROGRAM_CSD */
+        assert(sd->data_offset < sizeof(sd->data));
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sizeof(sd->csd)) {
             /* TODO: Check CRC before committing */
@@ -1968,6 +1972,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
+        assert(sd->data_offset < sizeof(sd->data));
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
@@ -1979,6 +1984,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
+        assert(sd->data_offset < sizeof(sd->data));
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sd->blk_len) {
             APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
@@ -2046,6 +2052,7 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     case 13:  /* ACMD13: SD_STATUS */
+        assert(sd->data_offset < sizeof(sd->sd_status));
         ret = sd->sd_status[sd->data_offset ++];
 
         if (sd->data_offset >= sizeof(sd->sd_status))
@@ -2055,6 +2062,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
         if (sd->data_offset == 0)
             BLK_READ_BLOCK(sd->data_start, io_len);
+        assert(sd->data_offset < sizeof(sd->data));
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= io_len)
@@ -2069,6 +2077,7 @@ uint8_t sd_read_byte(SDState *sd)
             }
             BLK_READ_BLOCK(sd->data_start, io_len);
         }
+        assert(sd->data_offset < sizeof(sd->data));
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= io_len) {
@@ -2089,10 +2098,12 @@ uint8_t sd_read_byte(SDState *sd)
         if (sd->data_offset >= SD_TUNING_BLOCK_SIZE - 1) {
             sd->state = sd_transfer_state;
         }
+        assert(sd->data_offset < sizeof(sd_tuning_block_pattern));
         ret = sd_tuning_block_pattern[sd->data_offset++];
         break;
 
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
+        assert(sd->data_offset < sizeof(sd->sd_status));
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= 4)
@@ -2100,6 +2111,7 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     case 30:  /* CMD30:  SEND_WRITE_PROT */
+        assert(sd->data_offset < sizeof(sd->data));
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= 4)
@@ -2107,6 +2119,7 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     case 51:  /* ACMD51: SEND_SCR */
+        assert(sd->data_offset < sizeof(sd->scr));
         ret = sd->scr[sd->data_offset ++];
 
         if (sd->data_offset >= sizeof(sd->scr))
@@ -2116,6 +2129,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 56:  /* CMD56:  GEN_CMD */
         if (sd->data_offset == 0)
             APP_READ_BLOCK(sd->data_start, sd->blk_len);
+        assert(sd->data_offset < sizeof(sd->data));
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= sd->blk_len)
-- 
2.41.0


