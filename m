Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF8BC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbL1-0006Ky-EB; Tue, 18 Jun 2024 12:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbL0-0006KU-BA
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKx-0007h5-Ey
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42172ed3597so35419755e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726733; x=1719331533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbhmY9JoTUClAzzbpCxEJXIDCxC/FdxyMxXmvUNLqdM=;
 b=XyY8y+Y/LJQahZi2bUle4r2HrSy7hIiI2K6N9qYaDwKGPmnwaaxvylooAW9unrDx4j
 xHyY54z+suKPoIjxx1L6J2g/atbclQ5lZY39DZV3C5vXUp2KNm2EV6qkIuyturJKezRn
 bG7dYABZhqU9BOis/RE4/NrOTFOzYTQnj9c9rSXnWtcaYOZuc4Z28v+lQAL5aA8aa2gf
 p/Je5G6FuNpxow6E6+I62Cg59ujaKJGOhyoLk0AlXSTPfqXpg95cB+rPtrdHRuEr9l5c
 UCweei7Js4iMYrUGMc2PZeh1H9xh0xZl6R86K5Pr082LdZSRn8dRmF5MbN6Y5o5FznDf
 B5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726733; x=1719331533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbhmY9JoTUClAzzbpCxEJXIDCxC/FdxyMxXmvUNLqdM=;
 b=RyFc7735OyCmw3EyBOEJimNBLdJc36RkRrq0ZmZ6Lq5brYa+iC48Oi9kXhc7UAQLIe
 WVwplDy+Ss57V2X0iO7EDc2m8jrPqwXpQUpnxFynHLfsvLDZlO6bFB+pQ/EhTDEORwxX
 jloOaYELifvw4L6ULoOb9MDe7NMjoKOB/bsHS4CMEIWZxSl8Wxa/Rxhi9Pz2l95w1cWf
 Cc7EGAhSIhjj+hFAwyKErQ5fNHnH4DMXsMzU+7xuiotNWXl8j/3PAFmN0QVXAzcOpysM
 5aUmNG2Z4z8X8wPraKaUj2V+Gf2WZ8zwrtwmuHKI/qK8t6rn0ydgFbS4I/Bya5ugXAYx
 6Dtg==
X-Gm-Message-State: AOJu0YxyiRcsB2QcfBHycY9bMqgFMA7YycF6vVqWor1+bxabsxX7bpOd
 AIlgqghEVG4MN4CMAI2BERL1tuYxavojkG3jWBXWX1O9XW8zf2I5WsOZAe4jWS/fPuQbhZEyYi6
 J
X-Google-Smtp-Source: AGHT+IEAZwPuZvTPbHI8UGIowH0oGtT9h40Jv2edv4W1O5steLdNIvr1J+/pnFh5yVMiuIjUUKlmvw==
X-Received: by 2002:a05:600c:1c93:b0:421:b906:8088 with SMTP id
 5b1f17b1804b1-4246f514b4fmr30171935e9.0.1718726733468; 
 Tue, 18 Jun 2024 09:05:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602ee95sm196650265e9.13.2024.06.18.09.05.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:05:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 50/76] hw/ppc: Avoid using Monitor in pic_print_info()
Date: Tue, 18 Jun 2024 18:00:12 +0200
Message-ID: <20240618160039.36108-51-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20240610062105.49848-27-philmd@linaro.org>
---
 include/hw/ppc/pnv_chip.h |  2 +-
 hw/ppc/pnv.c              | 29 +++++++----------------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index a5e428be7c..a4ed17ac59 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -154,7 +154,7 @@ struct PnvChipClass {
     void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, GString *buf);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
-    void (*pic_print_info)(PnvChip *chip, Monitor *mon);
+    void (*pic_print_info)(PnvChip *chip, GString *buf);
     uint64_t (*xscom_core_base)(PnvChip *chip, uint32_t core_id);
     uint32_t (*xscom_pcba)(PnvChip *chip, uint64_t addr);
 };
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9039c1777a..df74f032d7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -765,14 +765,11 @@ static ISABus *pnv_isa_create(PnvChip *chip, Error **errp)
     return PNV_CHIP_GET_CLASS(chip)->isa_create(chip, errp);
 }
 
-static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
+static void pnv_chip_power8_pic_print_info(PnvChip *chip, GString *buf)
 {
     Pnv8Chip *chip8 = PNV8_CHIP(chip);
     int i;
 
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
-
     ics_pic_print_info(&chip8->psi.ics, buf);
 
     for (i = 0; i < chip8->num_phbs; i++) {
@@ -782,9 +779,6 @@ static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
         pnv_phb3_msi_pic_print_info(&phb3->msis, buf);
         ics_pic_print_info(&phb3->lsis, buf);
     }
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 static int pnv_chip_power9_pic_print_info_child(Object *child, void *opaque)
@@ -801,19 +795,14 @@ static int pnv_chip_power9_pic_print_info_child(Object *child, void *opaque)
     return 0;
 }
 
-static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
+static void pnv_chip_power9_pic_print_info(PnvChip *chip, GString *buf)
 {
     Pnv9Chip *chip9 = PNV9_CHIP(chip);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     pnv_xive_pic_print_info(&chip9->xive, buf);
     pnv_psi_pic_print_info(&chip9->psi, buf);
     object_child_foreach_recursive(OBJECT(chip),
                          pnv_chip_power9_pic_print_info_child, buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 static uint64_t pnv_chip_power8_xscom_core_base(PnvChip *chip,
@@ -853,19 +842,14 @@ static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
     isa_realize_and_unref(dev, bus, &error_fatal);
 }
 
-static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
+static void pnv_chip_power10_pic_print_info(PnvChip *chip, GString *buf)
 {
     Pnv10Chip *chip10 = PNV10_CHIP(chip);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     pnv_xive2_pic_print_info(&chip10->xive, buf);
     pnv_psi_pic_print_info(&chip10->psi, buf);
     object_child_foreach_recursive(OBJECT(chip),
                          pnv_chip_power9_pic_print_info_child, buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 /* Always give the first 1GB to chip 0 else we won't boot */
@@ -2363,12 +2347,13 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj,
         PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[0], cpu,
                                                            buf);
     }
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
     for (i = 0; i < pnv->num_chips; i++) {
-        PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i], mon);
+        PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i], buf);
     }
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
-- 
2.41.0


