Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2B0C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYPA-0002GQ-1v; Mon, 10 Jun 2024 02:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYP8-0002F8-3q
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYP6-0004Iy-AM
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35e5604abdcso3012911f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000474; x=1718605274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVbnHAOwxyh5BXz5KtV5BYAwaSvMfBTicRK4fg5tgIw=;
 b=SWp31WF48przDB7ggWxz5F0h/5Hs4cAWlO4gw9/D4Ew82+S2k6KpZ1jT9yHq05xIcU
 70al6mHq1hkESfeNvmQi8RFml0owHg36kR/VrqMel3Md/ujqspfZXerpcXTwvDOI05wY
 MmZmEK7VCkG6GrVDn7jIeV5El3Vp3t/NcjLIAUNoE6Syeo1cvDSyyyyujri/U5kdw+cF
 18Ug8/xdgxOffxoE1CGbt8xhwFteVk/s0Te05W7xf28JG2Rfyf9L6icYD1byCSKqVY+g
 +3X6a1uUyZbSfLPWi0/oXXzyZ8erLKy/Cv56vNtiEcJYeU4bbrfyp2vV1rdu967RbIL8
 X9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000474; x=1718605274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVbnHAOwxyh5BXz5KtV5BYAwaSvMfBTicRK4fg5tgIw=;
 b=SHG8eyzwSPT3nqISoILE7pt6HbFDabaX9EQVo9Cel5686FJyK7F+u14QNJFxHoZrqZ
 pMa7+be1363uzd3/kTV5IJ5MXO2yZpoe2s1aDbZISpxrSxA63g/tQmQU9NkddjhrVXqC
 UyqCqY0RZ2Lr6biSPv7efcf11E06wOllmnGPaACtwmKxsTSF4V1e4t5fOSR44bWVx4nw
 DrxmX+9mdBq/uTDpGBfIoK+HYMl0qziCvN2okFoa/YsLILHppX43+UykJUNLaOO71lzv
 H71tT8aenXh9g8ajpGdHUWxta2AZPsPrSV91ncnCspdhRfG1adRCfAXYSHDIdVfiVrUk
 9fFw==
X-Gm-Message-State: AOJu0YzKG+Z6HvzwPcYrbN5G3wtDmJZM960ak7d1mDTB5oDQ3i/e64jU
 tJkzG25/2WCbf389pXYZ+0xRElz30x5nD6+U8fEHg+z8WzqqyIV57YmCaHXYCi29mt32EEAhEa1
 8
X-Google-Smtp-Source: AGHT+IHtSZj3tg6m3/bsuHoH5/qnLqErnfICEhdOkfVIaJ3/85YW8rYN/ExJ+baQj6DqOFvgD6lNVw==
X-Received: by 2002:a5d:4dce:0:b0:35f:9ab:d06c with SMTP id
 ffacd0b85a97d-35f09abd1c7mr6504377f8f.5.1718000473976; 
 Sun, 09 Jun 2024 23:21:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1f109346sm3338253f8f.27.2024.06.09.23.21.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:21:13 -0700 (PDT)
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
Subject: [PATCH 01/26] hw/ppc: Avoid using Monitor in
 pnv_phb3_msi_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:39 +0200
Message-ID: <20240610062105.49848-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
 include/hw/pci-host/pnv_phb3.h |  2 +-
 hw/pci-host/pnv_phb3_msi.c     | 21 ++++++++++-----------
 hw/ppc/pnv.c                   |  8 +++++++-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/hw/pci-host/pnv_phb3.h b/include/hw/pci-host/pnv_phb3.h
index d62b3091ac..24ca3dddaa 100644
--- a/include/hw/pci-host/pnv_phb3.h
+++ b/include/hw/pci-host/pnv_phb3.h
@@ -40,7 +40,7 @@ void pnv_phb3_msi_update_config(Phb3MsiState *msis, uint32_t base,
 void pnv_phb3_msi_send(Phb3MsiState *msis, uint64_t addr, uint16_t data,
                        int32_t dev_pe);
 void pnv_phb3_msi_ffi(Phb3MsiState *msis, uint64_t val);
-void pnv_phb3_msi_pic_print_info(Phb3MsiState *msis, Monitor *mon);
+void pnv_phb3_msi_pic_print_info(Phb3MsiState *msis, GString *buf);
 
 
 /*
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index a6d827f903..77d673da54 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -13,7 +13,6 @@
 #include "hw/pci-host/pnv_phb3.h"
 #include "hw/ppc/pnv.h"
 #include "hw/pci/msi.h"
-#include "monitor/monitor.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/reset.h"
@@ -316,13 +315,13 @@ static void pnv_phb3_msi_register_types(void)
 
 type_init(pnv_phb3_msi_register_types);
 
-void pnv_phb3_msi_pic_print_info(Phb3MsiState *msi, Monitor *mon)
+void pnv_phb3_msi_pic_print_info(Phb3MsiState *msi, GString *buf)
 {
     ICSState *ics = ICS(msi);
     int i;
 
-    monitor_printf(mon, "ICS %4x..%4x %p\n",
-                   ics->offset, ics->offset + ics->nr_irqs - 1, ics);
+    g_string_append_printf(buf, "ICS %4x..%4x %p\n",
+                           ics->offset, ics->offset + ics->nr_irqs - 1, ics);
 
     for (i = 0; i < ics->nr_irqs; i++) {
         uint64_t ive;
@@ -335,12 +334,12 @@ void pnv_phb3_msi_pic_print_info(Phb3MsiState *msi, Monitor *mon)
             continue;
         }
 
-        monitor_printf(mon, "  %4x %c%c server=%04x prio=%02x gen=%d\n",
-                       ics->offset + i,
-                       GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
-                       GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
-                       (uint32_t) GETFIELD(IODA2_IVT_SERVER, ive) >> 2,
-                       (uint32_t) GETFIELD(IODA2_IVT_PRIORITY, ive),
-                       (uint32_t) GETFIELD(IODA2_IVT_GEN, ive));
+        g_string_append_printf(buf, "  %4x %c%c server=%04x prio=%02x gen=%d\n",
+                               ics->offset + i,
+                               GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
+                               GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
+                               (uint32_t) GETFIELD(IODA2_IVT_SERVER, ive) >> 2,
+                               (uint32_t) GETFIELD(IODA2_IVT_PRIORITY, ive),
+                               (uint32_t) GETFIELD(IODA2_IVT_GEN, ive));
     }
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec..5356a4e295 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -38,6 +38,7 @@
 #include "hw/loader.h"
 #include "hw/nmi.h"
 #include "qapi/visitor.h"
+#include "qapi/type-helpers.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "hw/ipmi/ipmi.h"
@@ -774,8 +775,13 @@ static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
     for (i = 0; i < chip8->num_phbs; i++) {
         PnvPHB *phb = chip8->phbs[i];
         PnvPHB3 *phb3 = PNV_PHB3(phb->backend);
+        g_autoptr(GString) buf = g_string_new("");
+        g_autoptr(HumanReadableText) info = NULL;
+
+        pnv_phb3_msi_pic_print_info(&phb3->msis, buf);
+        info = human_readable_text_from_str(buf);
+        monitor_puts(mon, info->human_readable_text);
 
-        pnv_phb3_msi_pic_print_info(&phb3->msis, mon);
         ics_pic_print_info(&phb3->lsis, mon);
     }
 }
-- 
2.41.0


