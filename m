Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D32C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCO-0001Q8-QL; Tue, 11 Mar 2025 08:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCJ-0001LO-HD; Tue, 11 Mar 2025 08:59:03 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCE-0007rp-UE; Tue, 11 Mar 2025 08:59:03 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so9002009a91.2; 
 Tue, 11 Mar 2025 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697936; x=1742302736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSHGgwgOJ8bvFCtn77OMVeDfhzz9rRbWoztTbokAA7U=;
 b=cu0JLqMyW+QcWmnab3BDI9G0hYzqABrfUzVqDoSujd+j0njvwWp1PRL3vyGQCBnGXA
 AzQDnqF1pRX+nccz5DO0/l22i4DV2n7eSK5EXBCaSxqrLfFpms5shG93PLxrjOeOPiGL
 pSBO4iOLiAk25rtND/yn6mUe7Mk/PBXi3d1nX1whWcyLhrvZFjVK1qoG59+FPcBXqlXe
 08dKQ1JqUGknhVIL8MX9etlpL3O5rFZ8XD3P4+vDk441xOe/+ZYaf+l29hd8l7rzJFdg
 HH6JaRK4Dqev4iebAE461ANK9qlKOzu2eh7ceQEAyw3oWb5zeZ0gxFkbGxbBeMg7LR0V
 mKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697936; x=1742302736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSHGgwgOJ8bvFCtn77OMVeDfhzz9rRbWoztTbokAA7U=;
 b=IUlFPqJjfKF7tpVLs110+Fbe+cLpF8gqZEr4tF9nsaEmxxg2QSfFjkPWNUrAcyYU0Z
 dQkhq3NRK6z143p7KZ+WtCvdPzHK5d9zloSOF+wFGlCDot6cAlYs7jmw06dTmZLS+oFF
 1idA8GUSKzbh98pdEwV0WJQZWxgPOdJJEMvhtI25zV5wrx8aB/FhDaQtQYLlKdYaXmu5
 Zr59GCvCOUN9M93dKoZXGh6UmscKBC4OJdRPlVkktb8slDII5Mm4D+++YHFyV88E11QT
 m8VMwyFQ2jIh7wUnsOr7ZMO31Lpk56rtL1Mcp6bHY0fWsuVPJ7D1UNACBofl244OA5lE
 JWyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRbFAGUWm6S33l0Am1kemNLKlVGyxlSAY1vJpO4mXDVSSwH+83L+Ogqnbf4gZTEBGaM/sF3UUUwQ==@nongnu.org
X-Gm-Message-State: AOJu0YwT2ejgGXyRqLk/2jcGDXhBpNTBDHUqWgmX3CogZw4iRLx/hHmu
 rHfmHSNGWU30gJ0OanSeSU6F24lzSs4Cy0Q/d4SkyoB9gR18lPwYiPXa0A==
X-Gm-Gg: ASbGncvQ6vCKft5YAvZvlRIGsIRyAldkZWsiiW21rDSKTu9PTIchfIRtPImXuTQKJ8K
 O1RoDgzoLkqCl8s2SAf+UbPPPYrCiz69R4dNQRZzZWxQFjnEdYBq7S6pzkyXyYW2Ibw0tQNnhP4
 4uYLYKefnJXm5/RnF3T+v3U/ahPGluamRjkYSfRvVhCGVE96hozsxhAZcIz9ER4KRUBbqPR9eaH
 5hwIBZV1P2vy2/5QesfBcir60T1+TDo0JNqA7NjYVXSsZPbLED5KTe2Ro4IYFIX5IFfu4UOVbPv
 vL0pSbiu6DOLqRcYEAs+7Tt5ecILsQyoCsrVo+7n4Qpehu/L2jc=
X-Google-Smtp-Source: AGHT+IE0wNuDgcv5ZTW5TzeMwA7YKz9OzyNsRJualoW7aKYhS8N9K9b58RgfwuLSJQCx8Ar70CvUEg==
X-Received: by 2002:a17:90b:528e:b0:2fe:a336:fe63 with SMTP id
 98e67ed59e1d1-2ff7cef5ca6mr27094454a91.24.1741697935914; 
 Tue, 11 Mar 2025 05:58:55 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:58:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 06/72] ppc/pnv/phb4: Add pervasive chiplet support to PHB4/5
Date: Tue, 11 Mar 2025 22:57:00 +1000
Message-ID: <20250311125815.903177-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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
 hw/pci-host/pnv_phb4_pec.c     | 55 +++++++++++++++++++++++++++++++++-
 hw/ppc/pnv.c                   |  8 +++++
 include/hw/pci-host/pnv_phb4.h |  5 ++++
 include/hw/ppc/pnv_xscom.h     |  4 +++
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index a156839caf..cb8a7e3afa 100644
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
@@ -290,9 +330,16 @@ static const Property pnv_pec_properties[] = {
                      PnvChip *),
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
@@ -321,6 +368,7 @@ static void pnv_pec_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, pnv_pec_properties);
     dc->user_creatable = false;
 
+    pecc->xscom_cplt_base = pnv_pec_xscom_cplt_base;
     pecc->xscom_nest_base = pnv_pec_xscom_nest_base;
     pecc->xscom_pci_base  = pnv_pec_xscom_pci_base;
     pecc->xscom_nest_size = PNV9_XSCOM_PEC_NEST_SIZE;
@@ -349,6 +397,10 @@ static const TypeInfo pnv_pec_type_info = {
 /*
  * POWER10 definitions
  */
+static uint32_t pnv_phb5_pec_xscom_cplt_base(PnvPhb4PecState *pec)
+{
+    return PNV10_XSCOM_PEC_NEST_CPLT_BASE + XPEC_PCI_CPLT_OFFSET * pec->index;
+}
 
 static uint32_t pnv_phb5_pec_xscom_pci_base(PnvPhb4PecState *pec)
 {
@@ -373,6 +425,7 @@ static void pnv_phb5_pec_class_init(ObjectClass *klass, void *data)
     static const char compat[] = "ibm,power10-pbcq";
     static const char stk_compat[] = "ibm,power10-phb-stack";
 
+    pecc->xscom_cplt_base = pnv_phb5_pec_xscom_cplt_base;
     pecc->xscom_nest_base = pnv_phb5_pec_xscom_nest_base;
     pecc->xscom_pci_base  = pnv_phb5_pec_xscom_pci_base;
     pecc->xscom_nest_size = PNV10_XSCOM_PEC_NEST_SIZE;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 87607508c7..4407b3a1a2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1753,6 +1753,7 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
     for (i = 0; i < chip->num_pecs; i++) {
         PnvPhb4PecState *pec = &chip9->pecs[i];
         PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
+        uint32_t pec_cplt_base;
         uint32_t pec_nest_base;
         uint32_t pec_pci_base;
 
@@ -1765,9 +1766,12 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
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
@@ -2027,6 +2031,7 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
     for (i = 0; i < chip->num_pecs; i++) {
         PnvPhb4PecState *pec = &chip10->pecs[i];
         PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
+        uint32_t pec_cplt_base;
         uint32_t pec_nest_base;
         uint32_t pec_pci_base;
 
@@ -2039,9 +2044,12 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
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
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 8abee78e4d..8a80c0c667 100644
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
index 648388a599..a927aea1c0 100644
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
 
-- 
2.47.1


