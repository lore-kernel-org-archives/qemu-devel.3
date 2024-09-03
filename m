Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D88FCD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZlt-0001AA-G3; Tue, 03 Sep 2024 16:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slZlp-0000zi-4l
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:04:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slZln-0003P5-IJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:04:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so47840395e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725393894; x=1725998694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydW/DUmoEhTycpzh2ZqhDuCiUbu+QsaUgEgBthr/XBE=;
 b=tmJz+0iaAR2OskddzQDBGF3OchDkNScHMkRq7LBsDyiuju7bVvm6dXTl/Fo6PCyiW2
 2NKKXUSukgYOvcLmLe0NkySY0pORIMNitSeD5ikZx4AxPJAapcposE3C/MVXjp37TzPl
 rZjNsAAHDk9Qo71CZ11Ifx0ae+EnBdS/X3ToldViV10l0UhykvyJgDMe+zGJcOPAn5s5
 MFarTn2+eo1EOsKzZBvqLz+SDN2JjaGv6WBhtUrKY73uFRkMnyEAgIgN0ddg4oQ0imnW
 m3/nIWECOLdvlpZM7/AlVTp2DUvlPk+v/OA67dkEJ+dcQhcsNJbs1lEkhLTDWTCEbvz5
 qVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725393894; x=1725998694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydW/DUmoEhTycpzh2ZqhDuCiUbu+QsaUgEgBthr/XBE=;
 b=QpzmP5L4il6Cv5N0XwE1p52XwmHlbG2WKh5Laj+P3s7Vx9ecc3Rm0Qtp+MXnJU08NL
 A07pab/mrE4paSqNCDilRZylUDVRIwXNkdsyOiL6mT4zjkjXZLK8wVVTlWThJOzaRfde
 o+eO3toWAjdhV5uu4lW0pd//r/cBN6Oyn9y33r52JgMY22dAsdXbUcVuID/zLKL28b6D
 vvT4AqyK0mtqWTO0W3Lbv3ijz1I2tUAYUjoqOZnzdEBUcZcC5aPGmMV7lwVxWezoJqfO
 kBN0drl2roCdxC1bI8tFDuKKa2BY7en+zwHiQUbhpzcwAndo3bXDWlbxH3MIVmt9b/TX
 hUBg==
X-Gm-Message-State: AOJu0YyYpWGlRu3efKuc8YDcIL8yilHnaGMbSjwCZzbcy+vh6lVjrtIz
 6rtPJjNLfD3+HX94pDjJ6RVKQWxorBoC2bldk7r4yu++MVXouDRl0zfdcy66ZEH4txlvS37gjXx
 S
X-Google-Smtp-Source: AGHT+IEmKb/zUkaHjfxBhhWhFAZ/Vtm8EHLqzdNDMJPuDMAKsxSYFsS9atOljl3M6RKrBDMR0tVjCg==
X-Received: by 2002:a05:600c:5493:b0:428:52a:3580 with SMTP id
 5b1f17b1804b1-42c7b59e329mr72825255e9.3.1725393893472; 
 Tue, 03 Sep 2024 13:04:53 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb1ebsm181070985e9.3.2024.09.03.13.04.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 13:04:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 1/2] hw/sd: Remove legacy sd_set_cb()
Date: Tue,  3 Sep 2024 22:04:45 +0200
Message-ID: <20240903200446.25921-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903200446.25921-1-philmd@linaro.org>
References: <20240903200446.25921-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

sd_set_cb() was only used by omap2_mmc_init() which
got recently removed. Time to remove it. For historical
background on the me_no_qdev_me_kill_mammoth_with_rocks
kludge, see commit 007d1dbf72 ("sd: Hide the qdev-but-not-quite
thing created by sd_init()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdcard_legacy.h |  1 -
 hw/sd/sd.c                    | 30 ++++--------------------------
 2 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.h
index 0dc3889555..a121232560 100644
--- a/include/hw/sd/sdcard_legacy.h
+++ b/include/hw/sd/sdcard_legacy.h
@@ -36,7 +36,6 @@ SDState *sd_init(BlockBackend *blk, bool is_spi);
 int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
 void sd_write_byte(SDState *card, uint8_t value);
 uint8_t sd_read_byte(SDState *card);
-void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
 
 /* sd_enable should not be used -- it is only used on the nseries boards,
  * where it is part of a broken implementation of the MMC card slot switch
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a140a32ccd..8a30c61ce0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -112,10 +112,6 @@ typedef struct SDProto {
 struct SDState {
     DeviceState parent_obj;
 
-    /* If true, created by sd_init() for a non-qdevified caller */
-    /* TODO purge them with fire */
-    bool me_no_qdev_me_kill_mammoth_with_rocks;
-
     /* SD Memory Card Registers */
     uint32_t ocr;
     uint8_t scr[8];
@@ -169,8 +165,6 @@ struct SDState {
     uint32_t data_offset;
     size_t data_size;
     uint8_t data[512];
-    qemu_irq readonly_cb;
-    qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
     bool enable;
     uint8_t dat_lines;
@@ -889,17 +883,10 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
         trace_sdcard_ejected();
     }
 
-    if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
-        qemu_set_irq(sd->inserted_cb, inserted);
-        if (inserted) {
-            qemu_set_irq(sd->readonly_cb, readonly);
-        }
-    } else {
-        sdbus = SD_BUS(qdev_get_parent_bus(dev));
-        sdbus_set_inserted(sdbus, inserted);
-        if (inserted) {
-            sdbus_set_readonly(sdbus, readonly);
-        }
+    sdbus = SD_BUS(qdev_get_parent_bus(dev));
+    sdbus_set_inserted(sdbus, inserted);
+    if (inserted) {
+        sdbus_set_readonly(sdbus, readonly);
     }
 }
 
@@ -1027,18 +1014,9 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
     }
 
     sd = SD_CARD(dev);
-    sd->me_no_qdev_me_kill_mammoth_with_rocks = true;
     return sd;
 }
 
-void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
-{
-    sd->readonly_cb = readonly;
-    sd->inserted_cb = insert;
-    qemu_set_irq(readonly, sd->blk ? !blk_is_writable(sd->blk) : 0);
-    qemu_set_irq(insert, sd->blk ? blk_is_inserted(sd->blk) : 0);
-}
-
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
-- 
2.45.2


