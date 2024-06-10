Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15848C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYRT-0002mQ-6a; Mon, 10 Jun 2024 02:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYRR-0002ZV-94
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:41 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYRP-0004lV-CQ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:41 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52c85a7f834so1086768e87.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000615; x=1718605415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FsCsc3YL666+vUJoyQnqHvmBLXa/5gUhEMcQhABiuI=;
 b=fzVxKqRTiFb6tDTVLQ+IQgQBWumDvcG70FS3OOR003eBO4sKvbq4rundXroQzSC4JE
 /8Moh4JuFVm1t/Q6PPEV5Rsq88ThSvs4DvJ4a7JuES1YQXt7vm4QPOZfnI0FXJXpmmGw
 +j/Pho2ZSz2/tMzChaBR7JJvOvJnXhqoPfL6aOcj3CWnsuvyCygWWnhXDqownUV+NMdz
 Sc5wTZSp+WltEyG+2UBI+X0BZyMzwQdYWTg75yg2jiaQJ9wNgOL7UAFdgaTG/2wnIuea
 qZvgAUxVIwDwW+OMpuY2FRyOxNwk3doYMfZHwSkcxe9gIVsJ1lqQ3JewFjDbO5M3iRoV
 jABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000615; x=1718605415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FsCsc3YL666+vUJoyQnqHvmBLXa/5gUhEMcQhABiuI=;
 b=YlXoULzMJ/L2M60/MmTcpQoqFI20oPV828rCatkWsGTxkNAN2J80EYRVajzF6gGnHR
 8QpPcDd2RI/w/IgYxH6bl212qc7m8VXZSMsPUAorf/USruGgh8QZHK2DozvdjaX9Tmb6
 SFQ5kTIIiQnNpWh8gA5pG0YsCD/nUWCu9Ayl/lR4oexZUPQgj3VSU8hfjvcRuGtH7jh+
 VaGfxQf2PXc7cq/9qYMgkBzjekXc5d0wPbPMp8i4/C1HlpZRReOCUZWkcBzkTZwuCIn9
 4nrdqdiJJXo9jSg67SYWjshncN84snFHmsbxORZC8Czx/UqQBecQs09GFxOa37B3B37e
 dr8g==
X-Gm-Message-State: AOJu0YyaODs4kUXTgnTc9+mlJ3bdqR8cPfuj0oCTkIlPqdBGN7B6aHAG
 19ry97nQQPztRZ6+IpXVM2m+Hmwj9t9t9rZjKcBQTclyec79QRF/rzcmzyc8zS7dTk02PQFMaLc
 M
X-Google-Smtp-Source: AGHT+IFJE6KsXkm+pIQ4ypGCoi3IXg4MhSD53hzNF07NiG8mDI2SZZ1yPVDA+xQ1m3b1q3cVbZS4ew==
X-Received: by 2002:a05:6512:3c9e:b0:52c:8c91:da8d with SMTP id
 2adb3069b0e04-52c8c91dc01mr664820e87.66.1718000615237; 
 Sun, 09 Jun 2024 23:23:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2cd247sm133446155e9.40.2024.06.09.23.23.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:23:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 26/26] hw/ppc: Avoid using Monitor in pic_print_info()
Date: Mon, 10 Jun 2024 08:21:04 +0200
Message-ID: <20240610062105.49848-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
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


