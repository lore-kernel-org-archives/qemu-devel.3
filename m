Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED56E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMY-00077d-T6; Sat, 11 Jan 2025 13:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMV-00073c-Ns; Sat, 11 Jan 2025 13:37:31 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMU-0003vD-5e; Sat, 11 Jan 2025 13:37:31 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaeecbb7309so568967166b.0; 
 Sat, 11 Jan 2025 10:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620648; x=1737225448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwaUYglCz5HiwshtDxMwHXFy/Vt9VTZk7BnhuaVWzvw=;
 b=SuPuejRkb7fDDFdM/moA3irk6BRSLKbjABuONAm/wiAIPh0n5x5a1kSJVVFCHYtGKi
 ML2hk8CT2UCPEj8p6RuTxP/h29ut4u27DF1iBCUuDBlhtD4aHtvNI26Yn4iQlAhyTQuO
 TiYWkPzeE7gqbLpOg6D93MAc4UArH2g/uAXgM90lH7lG2hRIqgxToJjZfgH5YbFPgPUO
 VeyOJxyAPNUrJM8AcQiABQ4O438Mz4TTbpqc208KebXsFxYieiKaGOKPZt/1NFWvXAmC
 t/3ZOi/UIXi/Zz0ClhNuEuLdphdNYTyFWUNfJlVwfuCXUnZme7Yxq7VA10FiXZq0XYeD
 2WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620648; x=1737225448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwaUYglCz5HiwshtDxMwHXFy/Vt9VTZk7BnhuaVWzvw=;
 b=MW3UCqPgmkl2ial6U/M4Yx13FgBNzNgLs6+iX8ZmQuJNN3WU8mM3oywNq+/Wkygb8M
 jUqGygX35nTVMo9Vc2FlNToeZZS+LMAxZWYG+eZyHrAhmsCrGSWHMYTmIi1esjPGZoQV
 0z9A8MzmN4h6vSXgsdZ5U/zrL2oyq8xvth+TOtZsZZ8t2r3dxLEggYMph/MxP7XsrLJq
 lL6kMdQL40pl0RqTVMBg29VCmR5NNKHjMpFDw+VcFI9hAJLHsZScDDQoijZ34XXZ0Ph5
 BXvD9ZNdX/TpSmQ54dpzsXi3m+l+K1iDNuXd1MWFPjbQtGYzh+lB3tKazReoIdk7xkbI
 z/gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhSR9zuRDxZigCsKH8rim1UrvKXJTmc3xOy52JgZA6C6IXHEBvK4ruI5uKtsuzARN0hKtc80fS2w==@nongnu.org,
 AJvYcCXvUFjSPNQBxHoKJi76LZEowhFjCEsBN/80QuA894e+jLoOIw/z1XeA3KCvrhczrF+giZCSD4CtDArvqw==@nongnu.org
X-Gm-Message-State: AOJu0YwTjqc164HoWh0eTHrZJ4q5e0FE48ouo+PH7FmaBKxdvUB7yYr2
 eM9ODGXi754tEdsxLKzbqOpgRBPHF5kTstDXWq9JNea/x3h7Ht27YIFb/Q==
X-Gm-Gg: ASbGncvrlGvbB+kHO9za4b3PFmpaQ6k2l6yMIzFpxdozA8i+k/iQHZJZ0UYA9g79LWs
 YwvREkHTkbs6jI7P2qlHsXs0irmS6fFEeN1fu8toOYrj5tOEUVM0j3qF6lEx90RBBifn0a6F8tT
 9bJeakdmihRkxNDYks5s3siNkISxdOvfzLhJI2yxEJ8iZplHADl+H4UyXfKZr1yJQaSTeRWhVS2
 JuSCrcYUk196hNnO/CVO/3SWyyA+DsaaJxQ4VsBwlEIqr1R15pk8G9VlrT9KxnV9WPaHl/hYdqd
 7WTi9yAnGCzgg2RFRDOms9MsooToKY7ggnzBIEdeluE=
X-Google-Smtp-Source: AGHT+IGg6A43GqG+fKlJLbkXIsfEFKKzZHDVcgaPh9VZcMTtDZyP5x9WlL/UlqvbyGnHh219Vq4D3w==
X-Received: by 2002:a17:907:6090:b0:aa6:7354:e926 with SMTP id
 a640c23a62f3a-ab2ab748ed0mr1428185366b.36.1736620647533; 
 Sat, 11 Jan 2025 10:37:27 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:27 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 06/13] hw/sd/sd: Remove legacy sd_set_cb() in favor of GPIOs
Date: Sat, 11 Jan 2025 19:37:04 +0100
Message-ID: <20250111183711.2338-7-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.48.0


