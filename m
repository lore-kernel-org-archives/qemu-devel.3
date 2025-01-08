Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9845AE7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKk-00049N-Rx; Wed, 08 Jan 2025 04:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKE-0003xZ-1U; Wed, 08 Jan 2025 04:26:07 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKA-0004ne-IK; Wed, 08 Jan 2025 04:26:04 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so22353553a12.1; 
 Wed, 08 Jan 2025 01:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328359; x=1736933159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzIHVth2Q+M+ogDlevmRB8q7SrBSOXFLndAovQfPST0=;
 b=WZssVDQmV1F49VgbILRqFoTXrPql8SpKzdyGAzQU54eLAPe8usUM7UiFRaAh+SGuHj
 fzJVVboHuXB3XrWMxrU5372SRnS207Qe0Zq9HBvgL6cpm8KdvZRqa899Eb3gBEmwVc/X
 GSkvX6XuGs8+rv+AgiP6+jUt4/lXHPU2qSgRCWvMdo1sN/Iou/POeHlIY5evS2zRufXn
 y9R0gPjpIxZIiUhMO01x0OkCLnBf7XueX3cvLZI3H02BzDqve8DCfR7Qh2MoqDmlreXD
 4FYZm9//wZ8xUo7S69qJs6L+FNElxk/G/Snr7kuTe+iTklWjFNeRZZaTZzVrpiXNK1Pm
 SsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328359; x=1736933159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzIHVth2Q+M+ogDlevmRB8q7SrBSOXFLndAovQfPST0=;
 b=WoesRx+W5wcVAg1gySepAYxJU2j7lbX9HxwXZoXYGrTktWqLfJNNy4NibpJ6Y/cm39
 atdwHzFVwaSTPIszvax4WIaEBPnHqGi73Df9X15am3StHoJRknHX+5wsVMapZNJhBC4h
 DTeUXIDp/8SomV0u7DM3JlbLCfsGUmnDgzWxnZ5hok+QxbliD9ka32hQp2lQzDnhphB+
 t/Nc4u+n6jiNV/N972GKXKJ0KbC5rT4jmWjwXzEzyWUEVswUobSD0Ph+QMz9VIuUAaXi
 m4Lv9mdSZ2++pwmtuNRWZDbSN7cj9NZL/xxrDR7+9+Jdqp8+cWYZNmttjmjCdp6excz0
 7L0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbJaN759HpjA4UjR7zjjQdrO+oAe9yDUZWgQLrlrUZW54bTG5rXeRLVDKA1vsn9Qr0JFsmnhTSW/+ctw==@nongnu.org,
 AJvYcCXeo/UTWA4a3Xlxf+RWw1Hg4zKiH8arntSQ1taR2/OZ2GZMEfUNDqFwQ/sbXgSti7cF0D+CXp43tw==@nongnu.org
X-Gm-Message-State: AOJu0YwAa5yJ2FxajmNPomvC9gxtFJeLTW8/Xp/p0NH5licq+aA6+L+k
 Itf5oMgyEmXEaNE9IU+V0iKUe5i4RB1leRhrcNu6aFkSWuzACmJ564dqTkET
X-Gm-Gg: ASbGncs/BLaNKNqTgBHJlKzQA3+iolGti5wJV98EGfmf7NOqcbIbeH28m/FHLxkb4kH
 yrik/Dtc+xK9Gjx/SNbIj4GmazOdGGMEgatzTAAs/mxvH72Zi7UZwiilAJPNLJjoE2irnmHLoGt
 l5BQ5fOyenTVGa0Cv9KmKj5QtpDzIIr/870yPjZdv8UduxALNjj0ZC4P2In5XtbIchf36FCyf/g
 boN2Ter+ZUY1STy2OnXFMk2DSACnlL8XfOqVYUlQzMC+5H+reUxL6FbCZGOinBnjyl5hRvUmXxM
 pyIBqcdJsOuyxsI7WQIx9IShMETm4GZhPIcETL8Ktki5paU=
X-Google-Smtp-Source: AGHT+IG2Kdx4wMWM1JP9cUKXUCLFi2g52GRY7FjrQqyWacC/8sgNyDN2R5uZ2JVdLyaInljYOm9vIQ==
X-Received: by 2002:a05:6402:3225:b0:5d3:cf08:d64d with SMTP id
 4fb4d7f45d1cf-5d972e6f2d4mr1759834a12.32.1736328359089; 
 Wed, 08 Jan 2025 01:25:59 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:25:58 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 07/14] hw/sd/sd: Remove legacy sd_set_cb() in favor of GPIOs
Date: Wed,  8 Jan 2025 10:25:31 +0100
Message-ID: <20250108092538.11474-8-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Commit ce5dd27534b0 "hw/sd: Remove omap2_mmc device" removed the last user of
sd_set_cb(). Rework this functionality into GPIOs.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/sd/sdcard_legacy.h |  1 -
 hw/sd/sd.c                    | 31 ++++++++++++++-----------------
 2 files changed, 14 insertions(+), 18 deletions(-)

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
index 0330d432fd..aa8d86e1af 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -820,6 +820,16 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
     return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
 }
 
+static bool sd_get_inserted(SDState *sd)
+{
+    return sd->blk && blk_is_inserted(sd->blk);
+}
+
+static bool sd_get_readonly(SDState *sd)
+{
+    return sd->wp_switch;
+}
+
 static void sd_reset(DeviceState *dev)
 {
     SDState *sd = SDMMC_COMMON(dev);
@@ -865,16 +875,9 @@ static void sd_reset(DeviceState *dev)
     sd->dat_lines = 0xf;
     sd->cmd_line = true;
     sd->multi_blk_cnt = 0;
-}
 
-static bool sd_get_inserted(SDState *sd)
-{
-    return sd->blk && blk_is_inserted(sd->blk);
-}
-
-static bool sd_get_readonly(SDState *sd)
-{
-    return sd->wp_switch;
+    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd));
+    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd));
 }
 
 static void sd_cardchange(void *opaque, bool load, Error **errp)
@@ -1034,14 +1037,6 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
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
@@ -2727,6 +2722,8 @@ static void sd_instance_init(Object *obj)
     sd->last_cmd_name = "UNSET";
     sd->enable = true;
     sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
+    qdev_init_gpio_out_named(DEVICE(sd), &sd->inserted_cb, "cd", 1);
+    qdev_init_gpio_out_named(DEVICE(sd), &sd->readonly_cb, "wp", 1);
 }
 
 static void sd_instance_finalize(Object *obj)
-- 
2.47.1


