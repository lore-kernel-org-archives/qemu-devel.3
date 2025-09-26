Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C080ACAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22a5-0006NI-2R; Fri, 26 Sep 2025 03:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zr-0006Gk-T6; Fri, 26 Sep 2025 03:09:13 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zd-0006ZK-0T; Fri, 26 Sep 2025 03:09:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1a102X6geQxRyHih4Wv5zhTI+Klkiz3NZe6lb6HNIDncR1ndZYe/HrptZQKLTT7eoEjfbxwgLNyqEyVVWiiUseJKyAyKZnI7/ARJf2r+OGnlW7yc+k0yo2HBlvG04jHTyWMHZEAB4W/n57pFEGjzjpBEcaXWO4U0ohb+YnkeuSuce41HWFEj1B8vZScN874688XzJBC2ztFWl8Wwuo7TwF8GE6GKzUipDa/+Y+PMXSJ/aFmVUYlpMEkiyUddpMO3rCj7ILSCQmr72wagBb1UyCIqBBmZi8fWcWuCqzOSM6/0CNFzyUsbiohCuZqIPlrzY1SPUiSAeY/YOKQWS93wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA2I3SXMLFxM2C8vz/2d6NHm3jQ22cD1YGfoIl1FS/8=;
 b=C0aQtq3BfZXSpqbagvnAQE4BkFVE/Z7/Hmge7OJ/8gAHwnZ93DXvNxWX85+i9m6GmIqCOsLJR57FeyzKIndw0oSCcekx2wnDfRLGYXcklwqIjdk2DUvo9fQ3ZMadb64xZnfZ49i+ZWwQbJvn5MeEgOW5r0S9XMSj/ltB97tmTmc/kypof9i6oc9GAALv7us5rN1ZTfdlxihgft954EnZdlTxyHcVpAspV1YfY8oe+UB5bG+8kqTF628B4rluKx0gtg5sVXxKz0h4gXxVO7u857yYqyeK0wpLTEd6jX5UnvFeMXGt5TV7c4Q55A3faj2yeX49wLsEBathNKw0v47Y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA2I3SXMLFxM2C8vz/2d6NHm3jQ22cD1YGfoIl1FS/8=;
 b=ubUSkK9a0GwIPf7782UsNjBj5Fm7K65VQjwpx2nX7te0ZVUjvJSbF0EAFO8dBChDWY1rMqjaAPDaM8uhKLZudfSWnw0xbLlcR2BhBR7I+9uorwOL7ZKye0PAYkKt1WOPR34R+Q30DbS6CBDAvR8UL95gATldC5uDfOM1/J1i9ho=
Received: from SA9PR13CA0112.namprd13.prod.outlook.com (2603:10b6:806:24::27)
 by BL4PR12MB9535.namprd12.prod.outlook.com (2603:10b6:208:591::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 07:08:46 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::5f) by SA9PR13CA0112.outlook.office365.com
 (2603:10b6:806:24::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:36 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:36 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:35 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 13/47] hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
Date: Fri, 26 Sep 2025 09:07:31 +0200
Message-ID: <20250926070806.292065-14-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|BL4PR12MB9535:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9b3c6d-6325-4420-b1bc-08ddfccb88a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A182rv7z1m30f0r/v7qQZ0hOCGVrz16vyKlh/a7wGMuxa+NYbt32aTWwyQlF?=
 =?us-ascii?Q?kJMPeovgxCosPn9T451A4uHiJ+oYKzpQuynIJR0z+WfVSxEZUDmaOkx7J9qv?=
 =?us-ascii?Q?akqt2zd/MjRZsIOqgHMos1PlpcTMIDDsN5/CH+T5FAEXdIWIYRMcg5wW8IqU?=
 =?us-ascii?Q?eMo7+ntssaGnnNfFJX+Kq+p5gMrEbpHgD496PXvHH8WNtDz2+PQ5dtv/QJoc?=
 =?us-ascii?Q?X960Zxt7TjaVmerr3ZUfvVpfp/ZXESuZftKVeXnur90AQl+BDialg+She6zb?=
 =?us-ascii?Q?KiE1SXPokG2Wkgnm/L7CaXdyugBN28ziIIPh6zBB07ZIzX23huDsylC1Gc/+?=
 =?us-ascii?Q?1+RlUqSnOGBPPE5Z9x7lK13cEm2YjSBA5jvucxtn5e7FOijh9iiO5/yzcuXJ?=
 =?us-ascii?Q?55P9mocMaMvdMn6mYha94l/HPVbYzKO/H/Oy/n7n4W3UUok2fF3t1E+9RKER?=
 =?us-ascii?Q?f2l//GzD+gryyZXXKtyayoXm7U9+Sezb/p3e2E+/IZDrs3Y6mG8CJ6iJBdAf?=
 =?us-ascii?Q?EmnbCp/5vDuSh4JPNN31li0d6I8rWmyis31UvmzLrWNJakvcwt7n7DNt6xB9?=
 =?us-ascii?Q?jrzjbf5hkSI6IBINFZo5ClLT9tQIjNhlAyH9GzpNfmihZnarjCn3s8Yj3O5Q?=
 =?us-ascii?Q?hQZ9v4Dwo4j3D9YuCxT7uUxeLTXbXHlOk9RdxXHT1iZ+URdobCmTaWdnke/o?=
 =?us-ascii?Q?lgfzv0NPt0i+tOPqQ+RApEnsQDnZPoI0FZPwpB7SWM1u/gUbFX17o+fplBBC?=
 =?us-ascii?Q?54Gfveqwqw9LzctykzsoA5wj6IkxN1y48DPuvsKiUiU8RMuBb7Z8bJv83/NM?=
 =?us-ascii?Q?0n7sAMLQPHXWiBOcRN7mZt/ayEx0SJdEooyyjvGm0Y/THV5jcuBV87vnxMDU?=
 =?us-ascii?Q?nW8O+Pa2oXyw+saMOghd/Vcbg5VElnxviHQ38ZgaJ5yemGr40uhAXp0faTYY?=
 =?us-ascii?Q?LISRtP0zmcoXbjjLXRk+23oeatJNBJCt3DVdK8jiratsavmmP2xUA96M4c8X?=
 =?us-ascii?Q?ALQRcHAHZxeYOa9YkEpl4DJ5o7a3KIp8PUV5iZGTL1KbmYrqUkq6peEEqOpE?=
 =?us-ascii?Q?CQZ8BOE/BFUOoPrwOO/AYETL7nBHhPT/UXk+87xdIShoVB7//grit9rCVE8S?=
 =?us-ascii?Q?eA5HnO26oFcahsEpA7ikiO2A6as1/KPSHYJJ8pkSyFIbItDE3x2nHPshvpgh?=
 =?us-ascii?Q?jBHyQ1CPzo2xKxnDq5Kpl9LNc8J8tMRpEdaJ/aEFKeyEVirBJh8MlWavkWaS?=
 =?us-ascii?Q?mWk/G77w5PMn0XHgRRapSTOdlgasIKtVXJ+ETbbMt8br7+EyPAdsy1fmDVyJ?=
 =?us-ascii?Q?/l7R134xl94amMox852rt8OKcscHzgDD6BRtCokoqzr/GTVfFep/Z4pkSeh0?=
 =?us-ascii?Q?OMxRECAyrB3CNmY5CDJ42fY/eajv8DEv7vXrg9ciT1NYAaxqMmphkAjFtBCX?=
 =?us-ascii?Q?pNMPMtzybTvIPc6HpSzIZ8uNfrPwvFXRXmP68gxyGNl38Q3CUTpbgJcEc1Yj?=
 =?us-ascii?Q?qGtlDsIc3y87cKKBXwu0kfW/K7iyaduzlKqD5gJqpbSReO58EtCtMSRyPuQ1?=
 =?us-ascii?Q?SCqSjk5+44e+KnxgscA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:45.6829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9b3c6d-6325-4420-b1bc-08ddfccb88a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9535
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Luc.Michel@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor the PMC IOU SLCR device creation using the VersalMap structure.
This is the first user of a shared IRQ using an OR gate. The OSPI
controller is reconnected to the SLCR.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  5 ----
 hw/arm/xlnx-versal.c         | 48 +++++++++++++++++++++---------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b7ef255d6fd..78442e6c2c5 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -19,11 +19,10 @@
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/misc/xlnx-versal-crl.h"
-#include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/misc/xlnx-versal-trng.h"
 #include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
@@ -82,14 +81,10 @@ struct Versal {
         XlnxVersalCRL crl;
     } lpd;
 
     /* The Platform Management Controller subsystem.  */
     struct {
-        struct {
-            XlnxVersalPmcIouSlcr slcr;
-        } iou;
-
         XlnxZynqMPRTC rtc;
         XlnxVersalTRng trng;
         XlnxBBRam bbram;
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index d3a084a0639..e71c774e72e 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -33,10 +33,11 @@
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
+#include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -114,10 +115,12 @@ typedef struct VersalMap {
         uint64_t dac_sz;
         uint64_t dma_src;
         uint64_t dma_dst;
         int irq;
     } ospi;
+
+    VersalSimplePeriphMap pmc_iou_slcr;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -154,10 +157,12 @@ static const VersalMap VERSAL_MAP = {
         .ctrl = 0xf1010000,
         .dac = 0xc0000000, .dac_sz = 0x20000000,
         .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
         .irq = 124,
     },
+
+    .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -868,25 +873,28 @@ static void versal_create_efuse(Versal *s,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(cache),
                                                        0));
     versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(ctrl), 0, map->irq);
 }
 
-static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
+static DeviceState *versal_create_pmc_iou_slcr(Versal *s,
+                                               const VersalSimplePeriphMap *map)
 {
     SysBusDevice *sbd;
+    DeviceState *dev;
 
-    object_initialize_child(OBJECT(s), "versal-pmc-iou-slcr", &s->pmc.iou.slcr,
-                            TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
+    dev = qdev_new(TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
+    object_property_add_child(OBJECT(s), "pmc-iou-slcr", OBJECT(dev));
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.iou.slcr);
-    sysbus_realize(sbd, &error_fatal);
+    sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_PMC_IOU_SLCR,
+    memory_region_add_subregion(&s->mr_ps, map->addr,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    sysbus_connect_irq(sbd, 0,
-                       qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 2));
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
+
+    return dev;
 }
 
 static DeviceState *versal_create_ospi(Versal *s,
                                        const struct VersalOspiMap *map)
 {
@@ -1208,10 +1216,11 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
                   "is not yet implemented\n");
 }
 
 static void versal_unimp(Versal *s)
 {
+    DeviceState *slcr;
     qemu_irq gpio_in;
 
     versal_unimp_area(s, "psm", &s->mr_ps,
                         MM_PSM_START, MM_PSM_END - MM_PSM_START);
     versal_unimp_area(s, "crf", &s->mr_ps,
@@ -1230,27 +1239,22 @@ static void versal_unimp(Versal *s)
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_qspi_ospi_mux_sel,
                             "qspi-ospi-mux-sel-dummy", 1);
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_irq_parity_imr,
                             "irq-parity-imr-dummy", 1);
 
+    slcr = DEVICE(versal_get_child(s, "pmc-iou-slcr"));
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "sd-emmc-sel-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "sd-emmc-sel", 0,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, "sd-emmc-sel", 0, gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "sd-emmc-sel-dummy", 1);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "sd-emmc-sel", 1,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, "sd-emmc-sel", 1, gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "qspi-ospi-mux-sel-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
-                                "qspi-ospi-mux-sel", 0,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, "qspi-ospi-mux-sel", 0, gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "irq-parity-imr-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
-                                SYSBUS_DEVICE_GPIO_IRQ, 0,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, SYSBUS_DEVICE_GPIO_IRQ, 0, gpio_in);
 }
 
 static uint32_t fdt_add_clk_node(Versal *s, const char *name,
                                  unsigned int freq_hz)
 {
@@ -1269,10 +1273,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 }
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
+    DeviceState *slcr, *ospi;
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
@@ -1321,17 +1326,20 @@ static void versal_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < map->num_usb; i++) {
         versal_create_usb(s, &map->usb[i]);
     }
 
     versal_create_efuse(s, &map->efuse);
-    versal_create_ospi(s, &map->ospi);
+    ospi = versal_create_ospi(s, &map->ospi);
+    slcr = versal_create_pmc_iou_slcr(s, &map->pmc_iou_slcr);
 
+    qdev_connect_gpio_out_named(slcr, "ospi-mux-sel", 0,
+                                qdev_get_gpio_in_named(ospi,
+                                                       "ospi-mux-sel", 0));
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_bbram(s, pic);
-    versal_create_pmc_iou_slcr(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
-- 
2.51.0


