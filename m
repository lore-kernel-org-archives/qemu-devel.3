Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CB4E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 06:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKuBG-0003d7-3o; Tue, 10 Dec 2024 01:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKuBE-0003cY-4U; Tue, 10 Dec 2024 01:57:12 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKuBC-0001DI-4J; Tue, 10 Dec 2024 01:57:11 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso2890560a12.3; 
 Mon, 09 Dec 2024 22:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733813828; x=1734418628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bfwyOxfasb7nX9j/6qEDSxMu8LL4XpjvlQPOVooAa24=;
 b=bhs6qQ+Xxznn/LVOhUBcQYZq5R72MZxeYhzVbLJwzZdu4Ph9whaKWn+UsD0qVIZ/if
 UtTfeodgIGYndAYwP0lsgV6hWgfAmyEE2GhtAfXG3MBJdmyQLwqdkgaNeqaQHugGpyXY
 id0/fhQjSrFe1N4JPTlg0+uvs0Yid7yyIFtM6DxN+pog7vJa2Cx5luzzjDQKDT9bAOqp
 pQjk+OqIFI0av2l6lyt9XqZMOIXKsrkLwAyXsh3tpFvhqzpFnh7T5Z+wtMV4LA4IYttR
 V06DdRn3cLvX57Zdki7rhVgKPL50fkH+kSQ45DaLZ+x+9eJamoQ+OqoqkG+d1MZbhXJ0
 DDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733813828; x=1734418628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfwyOxfasb7nX9j/6qEDSxMu8LL4XpjvlQPOVooAa24=;
 b=HiBwVajA68X15HAMBJOluDjhidehc5wOj1syUN5sAsYYo0XYWNDfhn2e/v/u08XlMO
 eyfs2YbS6dX6fP+f7/OKCYR9NkCILDWMv8bQQoQX7WWVi7pAIHvGQ4iSpwa/eoG96N1v
 9D/H8c1qyY2dzcrRNPAJzCd/uGiSD0O0D6419HXQnLFB/I5xvAmAdGGBFM0Wskf+sjn9
 fYb4YJHb2nOWnfDUp+5CTMmCIZtl1bQHWPbul/y4fKToSf9Q/pU20R6FqPjx0E1VhlRr
 Ft0bbSZKbybQLUNjnKL2yDu1Gf3KJtRF6f0MlZt9Z/A7HhdTdkRURcn8Jqbz4S4quCl8
 HArw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd6zsA1M4KywlDzRWjaoWbUHoBL8+1jO318ECCWAXf4F+KitzyQW0A//xzC8xYjoOR9JQXlVpNPRHi@nongnu.org
X-Gm-Message-State: AOJu0Yy4V8TiKf1c6KjRDZW3TYdqX/OKIgtkVdy0HefLw7Ad9p22Vdkp
 23iFh46XUGBHS+LCiTJ14gDgm9cSzJgwTCtJNa3yD4H17SzTPnvmEUiEsw==
X-Gm-Gg: ASbGncuLO/D5Xds2aV5UyyxkP7FP25tKxY50rQLqwgqrpC2AVWRJvYYOY3ub2Oan9fE
 jVOshtH54J2BkUtSHYpp32vcYoDfDy7pJyUzTC9OE403UCMEbHoOvtLeY7qmsq4qEyD7gg/WEll
 XtCUHAsv4jdzo3tw4AfkzdcJJx9Qkr8ACPhJ1Ta5FI8Gd2BWYzJwCRYtVJjaPGH+DO/FuYtne9l
 asi6FVTKEN+6YTPVism+jLAIVD2jVqe8S8d9oU4rSceDub52GSmI7TISSFJ
X-Google-Smtp-Source: AGHT+IFjWG+ujIrbPr5X+xdQJuwBRL1K6NcCA/p+1XW7xaW1fROdiA57Wx2uK6zEkmLQ3W8S2yhybw==
X-Received: by 2002:a17:902:e546:b0:216:393b:23c9 with SMTP id
 d9443c01a7336-216393b29c5mr145994715ad.29.1733813827706; 
 Mon, 09 Dec 2024 22:57:07 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-216338fee40sm45951735ad.94.2024.12.09.22.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 22:57:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Subject: [PATCH] ppc/pnv/phb4: Add pervasive chiplet support to PHB4/5
Date: Tue, 10 Dec 2024 16:56:59 +1000
Message-ID: <20241210065659.1322405-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
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

Each non-core chiplet on a chip has a "pervasive chiplet" unit and its
xscom register set. This adds support for PHB4/5.

skiboot reads the CPLT_CONF1 register in __phb4/5_get_max_link_width(),
which shows up as unimplemented xscom reads. Set a value in PCI CONF1
register's link-width field to demonstrate skiboot doing something
interesting with it.

In the bigger picture, it might be better to model the pervasive
chiplet type as parent that each non-core chiplet model derives from.
For now this is enough to get the PHB registers implemented and working
for skiboot, and provides a second example (after the N1 chiplet) that
will help if the design is reworked as such.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/pci-host/pnv_phb4.h |  5 ++++
 include/hw/ppc/pnv_xscom.h     |  4 +++
 hw/pci-host/pnv_phb4_pec.c     | 55 +++++++++++++++++++++++++++++++++-
 hw/ppc/pnv.c                   |  8 +++++
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 8abee78e4d4..8a80c0c667a 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -13,6 +13,7 @@
 #include "hw/pci-host/pnv_phb.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_nest_pervasive.h"
 #include "hw/ppc/xive.h"
 #include "qom/object.h"
 
@@ -174,6 +175,9 @@ struct PnvPhb4PecState {
     uint32_t index;
     uint32_t chip_id;
 
+    /* Pervasive chiplet control */
+    PnvNestChipletPervasive nest_pervasive;
+
     /* Nest registers, excuding per-stack */
 #define PHB4_PEC_NEST_REGS_COUNT    0xf
     uint64_t nest_regs[PHB4_PEC_NEST_REGS_COUNT];
@@ -196,6 +200,7 @@ struct PnvPhb4PecState {
 struct PnvPhb4PecClass {
     DeviceClass parent_class;
 
+    uint32_t (*xscom_cplt_base)(PnvPhb4PecState *pec);
     uint32_t (*xscom_nest_base)(PnvPhb4PecState *pec);
     uint32_t xscom_nest_size;
     uint32_t (*xscom_pci_base)(PnvPhb4PecState *pec);
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 648388a5995..a927aea1c09 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -126,6 +126,8 @@ struct PnvXScomInterfaceClass {
 #define PNV9_XSCOM_PEC_PCI_BASE   0xd010800
 #define PNV9_XSCOM_PEC_PCI_SIZE   0x200
 
+#define PNV9_XSCOM_PEC_NEST_CPLT_BASE  0x0d000000
+
 /* XSCOM PCI "pass-through" window to PHB SCOM */
 #define PNV9_XSCOM_PEC_PCI_STK0   0x100
 #define PNV9_XSCOM_PEC_PCI_STK1   0x140
@@ -197,6 +199,8 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
+#define PNV10_XSCOM_PEC_NEST_CPLT_BASE 0x08000000
+
 #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
 #define PNV10_XSCOM_PEC_PCI_SIZE   0x200
 
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index ce8e228f987..533c8a26131 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -197,6 +197,9 @@ static PnvPHB *pnv_pec_default_phb_realize(PnvPhb4PecState *pec,
     return phb;
 }
 
+#define   XPEC_P9_PCI_LANE_CFG                  PPC_BITMASK(10, 11)
+#define   XPEC_P10_PCI_LANE_CFG                 PPC_BITMASK(0, 1)
+
 static void pnv_pec_realize(DeviceState *dev, Error **errp)
 {
     PnvPhb4PecState *pec = PNV_PHB4_PEC(dev);
@@ -211,6 +214,43 @@ static void pnv_pec_realize(DeviceState *dev, Error **errp)
 
     pec->num_phbs = pecc->num_phbs[pec->index];
 
+    /* Pervasive chiplet */
+    object_initialize_child(OBJECT(pec), "nest-pervasive-common",
+                            &pec->nest_pervasive,
+                            TYPE_PNV_NEST_CHIPLET_PERVASIVE);
+    if (!qdev_realize(DEVICE(&pec->nest_pervasive), NULL, errp)) {
+        return;
+    }
+
+    /* Set up pervasive chiplet registers */
+    /*
+     * Most registers are not set up, this just sets the PCI CONF1 link-width
+     * field because skiboot probes it.
+     */
+    if (pecc->version == PNV_PHB4_VERSION) {
+        /*
+         * On P9, PEC2 has configurable 1/2/3-furcation).
+         * Make it trifurcated (x8, x4, x4) to match pnv_pec_num_phbs.
+         */
+        if (pec->index == 2) {
+            pec->nest_pervasive.control_regs.cplt_cfg1 =
+                    SETFIELD(XPEC_P9_PCI_LANE_CFG,
+                             pec->nest_pervasive.control_regs.cplt_cfg1,
+                             0b10);
+        }
+    } else if (pecc->version == PNV_PHB5_VERSION) {
+        /*
+         * On P10, both PECs are configurable 1/2/3-furcation).
+         * Both are trifurcated to match pnv_phb5_pec_num_stacks.
+         */
+        pec->nest_pervasive.control_regs.cplt_cfg1 =
+                SETFIELD(XPEC_P10_PCI_LANE_CFG,
+                         pec->nest_pervasive.control_regs.cplt_cfg1,
+                         0b10);
+    } else {
+        g_assert_not_reached();
+    }
+
     /* Create PHBs if running with defaults */
     if (defaults_enabled()) {
         g_assert(pec->num_phbs <= MAX_PHBS_PER_PEC);
@@ -291,9 +331,16 @@ static Property pnv_pec_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+#define XPEC_PCI_CPLT_OFFSET                        0x1000000ULL
+
+static uint32_t pnv_pec_xscom_cplt_base(PnvPhb4PecState *pec)
+{
+    return PNV9_XSCOM_PEC_NEST_CPLT_BASE + XPEC_PCI_CPLT_OFFSET * pec->index;
+}
+
 static uint32_t pnv_pec_xscom_pci_base(PnvPhb4PecState *pec)
 {
-    return PNV9_XSCOM_PEC_PCI_BASE + 0x1000000 * pec->index;
+    return PNV9_XSCOM_PEC_PCI_BASE + XPEC_PCI_CPLT_OFFSET * pec->index;
 }
 
 static uint32_t pnv_pec_xscom_nest_base(PnvPhb4PecState *pec)
@@ -322,6 +369,7 @@ static void pnv_pec_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, pnv_pec_properties);
     dc->user_creatable = false;
 
+    pecc->xscom_cplt_base = pnv_pec_xscom_cplt_base;
     pecc->xscom_nest_base = pnv_pec_xscom_nest_base;
     pecc->xscom_pci_base  = pnv_pec_xscom_pci_base;
     pecc->xscom_nest_size = PNV9_XSCOM_PEC_NEST_SIZE;
@@ -350,6 +398,10 @@ static const TypeInfo pnv_pec_type_info = {
 /*
  * POWER10 definitions
  */
+static uint32_t pnv_phb5_pec_xscom_cplt_base(PnvPhb4PecState *pec)
+{
+    return PNV10_XSCOM_PEC_NEST_CPLT_BASE + XPEC_PCI_CPLT_OFFSET * pec->index;
+}
 
 static uint32_t pnv_phb5_pec_xscom_pci_base(PnvPhb4PecState *pec)
 {
@@ -374,6 +426,7 @@ static void pnv_phb5_pec_class_init(ObjectClass *klass, void *data)
     static const char compat[] = "ibm,power10-pbcq";
     static const char stk_compat[] = "ibm,power10-phb-stack";
 
+    pecc->xscom_cplt_base = pnv_phb5_pec_xscom_cplt_base;
     pecc->xscom_nest_base = pnv_phb5_pec_xscom_nest_base;
     pecc->xscom_pci_base  = pnv_phb5_pec_xscom_pci_base;
     pecc->xscom_nest_size = PNV10_XSCOM_PEC_NEST_SIZE;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 22c67e82aa7..820eabf30a8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1755,6 +1755,7 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
     for (i = 0; i < chip->num_pecs; i++) {
         PnvPhb4PecState *pec = &chip9->pecs[i];
         PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
+        uint32_t pec_cplt_base;
         uint32_t pec_nest_base;
         uint32_t pec_pci_base;
 
@@ -1767,9 +1768,12 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
             return;
         }
 
+        pec_cplt_base = pecc->xscom_cplt_base(pec);
         pec_nest_base = pecc->xscom_nest_base(pec);
         pec_pci_base = pecc->xscom_pci_base(pec);
 
+        pnv_xscom_add_subregion(chip, pec_cplt_base,
+                 &pec->nest_pervasive.xscom_ctrl_regs_mr);
         pnv_xscom_add_subregion(chip, pec_nest_base, &pec->nest_regs_mr);
         pnv_xscom_add_subregion(chip, pec_pci_base, &pec->pci_regs_mr);
     }
@@ -2030,6 +2034,7 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
     for (i = 0; i < chip->num_pecs; i++) {
         PnvPhb4PecState *pec = &chip10->pecs[i];
         PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
+        uint32_t pec_cplt_base;
         uint32_t pec_nest_base;
         uint32_t pec_pci_base;
 
@@ -2042,9 +2047,12 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
             return;
         }
 
+        pec_cplt_base = pecc->xscom_cplt_base(pec);
         pec_nest_base = pecc->xscom_nest_base(pec);
         pec_pci_base = pecc->xscom_pci_base(pec);
 
+        pnv_xscom_add_subregion(chip, pec_cplt_base,
+                 &pec->nest_pervasive.xscom_ctrl_regs_mr);
         pnv_xscom_add_subregion(chip, pec_nest_base, &pec->nest_regs_mr);
         pnv_xscom_add_subregion(chip, pec_pci_base, &pec->pci_regs_mr);
     }
-- 
2.45.2


