Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC59C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQf-00057m-46; Mon, 10 Jun 2024 02:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQV-0004QH-KX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:44 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQT-0004cQ-QA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:43 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52c32d934c2so1558414e87.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000559; x=1718605359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+GiPim6gWmrm3Tb8xJuU7kWpbX6sNLw7skHH6nD9WA=;
 b=S7O8eL54P4j7Mk58p+kPwlw5q2HrLNNUjJXOx/8O8Tg/ai2mYxSslbRsCwKwgM0SxO
 TAGm7lYXDf/2G1Eb08KJ7AsaPvuIBr2w3mq+c3PLg9JujH2vNs94f6qef2OPPMIlYIhd
 Rb2j7ofkNG9QUap/QhxB8xsX9AAKBxXBgqrzKSv6/ovhsn9c5cvmgCCe3VMt4TtaqvlU
 dSpwt6oYyhngrz7Hp6uRMfOBya3L7EKjGeDaqesEEY20Bmv9SmzsLYa+am6HWRK5VR3F
 zVppbP83CfXbRFTnnquZcUS7PyLViuotJ+L3NTclPJXF/TuUDhmtuJAr+n2YtmiCp+j9
 pq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000559; x=1718605359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+GiPim6gWmrm3Tb8xJuU7kWpbX6sNLw7skHH6nD9WA=;
 b=mpEImv56HWGLVwh1xNYtkphCZ62qB3huWVsqs0dLPZRkvNxSwV3JboNkUPIc5DhGwe
 hQP9NA9M2lOavkFztvV4kPKNpLV7lPK/rNgaYGM899/OOj6eAXlR0uFfe9p5XVgFCNcA
 D2+XeooFwkGCX5hMYFaiW9MpgZoBZ85y9FC2QcM/nEdIetm74AdL3TpiLTJzw5kIGP+M
 Ah0NeQDeCuflNp4/BUKauvUInSDrkt3xlRFoyDyfSsEB27aIWGTc8Uk8+9P/y5xxa5sH
 nGVK1Dcaam/YOCwCNzWDKSyonjjHW4VgeIOplBzrRUXk/sTerLIhLZze8h6Tf6l+ZaTM
 Zi+g==
X-Gm-Message-State: AOJu0YyPSa18j9L84zKmQTwHNsj0PBRvA6k7V6mrV76RWVkLVhBFgZNE
 ZlwK1HRbpxkpUaKhYP2p3SmBw4NQ9LsEVBogk95uzM23nIKW6CCxdBTF1KXFb9oumvP9hpv2kOS
 d
X-Google-Smtp-Source: AGHT+IHoE/OzbbRKiP8SSdNJRizLdhdlesPbtarUGWmpkEG/Vs2E529qu6iFfhcoVdTlI2jZVbGk/Q==
X-Received: by 2002:ac2:5f7a:0:b0:52c:84b9:1bb3 with SMTP id
 2adb3069b0e04-52c84b91e8bmr1639342e87.0.1718000559204; 
 Sun, 09 Jun 2024 23:22:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421e2cbc602sm17616515e9.22.2024.06.09.23.22.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:38 -0700 (PDT)
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
Subject: [PATCH 16/26] hw/ppc: Avoid using Monitor in pnv_psi_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:54 +0200
Message-ID: <20240610062105.49848-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/pnv_psi.h |  2 +-
 hw/ppc/pnv.c             | 10 +++++++---
 hw/ppc/pnv_psi.c         |  9 +--------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 2a6f715350..cf7f95a6b1 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -110,6 +110,6 @@ typedef enum PnvPsiIrq {
 #define PSIHB9_IRQ_PSU          13
 #define PSIHB9_NUM_IRQS         14
 
-void pnv_psi_pic_print_info(Pnv9Psi *psi, Monitor *mon);
+void pnv_psi_pic_print_info(Pnv9Psi *psi, GString *buf);
 
 #endif /* PPC_PNV_PSI_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7e6f923c7e..4a1a302a25 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -812,12 +812,11 @@ static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
     g_autoptr(HumanReadableText) info = NULL;
 
     pnv_xive_pic_print_info(&chip9->xive, buf);
+    pnv_psi_pic_print_info(&chip9->psi, buf);
 
     info = human_readable_text_from_str(buf);
     monitor_puts(mon, info->human_readable_text);
 
-    pnv_psi_pic_print_info(&chip9->psi, mon);
-
     object_child_foreach_recursive(OBJECT(chip),
                          pnv_chip_power9_pic_print_info_child, mon);
 }
@@ -862,9 +861,14 @@ static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
 static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
 {
     Pnv10Chip *chip10 = PNV10_CHIP(chip);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     pnv_xive2_pic_print_info(&chip10->xive, mon);
-    pnv_psi_pic_print_info(&chip10->psi, mon);
+
+    pnv_psi_pic_print_info(&chip10->psi, buf);
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     object_child_foreach_recursive(OBJECT(chip),
                          pnv_chip_power9_pic_print_info_child, mon);
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 922ac07b2f..18cc76a7e4 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -25,8 +25,6 @@
 #include "qemu/module.h"
 #include "sysemu/reset.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
-#include "monitor/monitor.h"
 
 
 #include "hw/ppc/fdt.h"
@@ -978,11 +976,9 @@ static void pnv_psi_register_types(void)
 
 type_init(pnv_psi_register_types);
 
-void pnv_psi_pic_print_info(Pnv9Psi *psi9, Monitor *mon)
+void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
 {
     PnvPsi *psi = PNV_PSI(psi9);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     uint32_t offset =
         (psi->regs[PSIHB_REG(PSIHB9_IVT_OFFSET)] >> PSIHB9_IVT_OFF_SHIFT);
@@ -990,7 +986,4 @@ void pnv_psi_pic_print_info(Pnv9Psi *psi9, Monitor *mon)
     g_string_append_printf(buf, "PSIHB Source %08x .. %08x\n",
                            offset, offset + psi9->source.nr_irqs - 1);
     xive_source_pic_print_info(&psi9->source, offset, buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
-- 
2.41.0


