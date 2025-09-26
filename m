Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035FDCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22a8-0006PO-0A; Fri, 26 Sep 2025 03:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zs-0006Gr-Ds; Fri, 26 Sep 2025 03:09:13 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zc-0006ZF-Ll; Fri, 26 Sep 2025 03:09:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/LK7jnW4RhAwaqDCvfVIAkaIs0t70I0DgImJOOIPvRBBmYAk5fdzhTm301CEF6ncKCrHsmC5bIuvSg+RVpz2f96EYXtx82NxUqVs50h23p8qUyJNPc9brWOfXAIiQlgLH3yiVPkNH0C+OxtMLPHpXRBmBTB2cZiWrwvRxWpr5osgByrLtEjb5Nn3TGAWl48TZTu6AbvAYP5/IRPkIvhf18xNZBQ/FQZH7CUJpHHU1PTY+usyGNsN1BwJvc73/vcYD0F6adNm7Tf00M9XVDr8uzPLpUamQKgyO6cZhYo8EbCkqbv3ir7cok80zK4i8ifsw6Jt76cJcGvdQk2Zr6NsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTJi9ZV8VsXINLqiYwkmkhMWBE7A44nFnMeZNleDpdE=;
 b=ZKn585IlTsfSNsWu3jZwHZmpb0X69rm5lW1U3nz5grt/GTGpNs7Xgal/1Zj54ADotGlFGhg1jLPnBr8fT6/HKJzEa9vvZ751wX+GgZUIps92VELjswhPhFl2cfW/KViknUlgvYJybhfyM8d37+9mTlEiyq+WzzfYNTjuZdaSImH2spXFWXZ2Hoq5FcYNiuWND0zYhZ2S+797RPLAF/hcW9b2ffWbL6u9J5C9mmugfPodxPfbMP0VXREVba8cmA6Nu45Om9kY0B5ObDTS96wWn+N7PlLaEs63mdjtdsTbYBhNUpYKivyBSqp2c/PRbZT5z3P7NfGsjKyXmQHHqFpUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTJi9ZV8VsXINLqiYwkmkhMWBE7A44nFnMeZNleDpdE=;
 b=ZU7oulqVeR6Zc5s0gguwruwml3C+M438sRRtiermyo+km6UkpPn9hRC2zLEIiEqj67XgqNmLl/IPBrlWFh1yk81Nneg+KmFxfFeYuev5ByMvjKT0yJvp06sh7nz4z+JRkJVJaIl7Hpu4e55E9SxmBBfijCk4MBF6BfYrQUUCojU=
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 07:08:46 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::7e) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:33 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:32 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:31 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 11/47] hw/arm/xlnx-versal: ospi: refactor creation
Date: Fri, 26 Sep 2025 09:07:29 +0200
Message-ID: <20250926070806.292065-12-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: daa2e293-2a61-49d7-a3cd-08ddfccb892b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IyycZJTDE6k/Nz+T99NwdxdtVEBckg7KlOgl+evBpSbTTN8cGecyYCfi5cHg?=
 =?us-ascii?Q?Md6Pofq6+uoNoOBdgR0fDet9SSrxb3IZ0IW8qlzKhBSPtfjxHWAEplwC5Yhr?=
 =?us-ascii?Q?emPkeNdqqRRgNaYMPkKreitJnFQa2G89w+V9wsYf3G7/6xjmlExKB2VtdmTQ?=
 =?us-ascii?Q?qbzYQshoi8/FHXMTtn7LtT4C7r9PRBwnXQ9+foidlPTAS/BYvB02J0nNWAGC?=
 =?us-ascii?Q?NLub28Gyqg17agrK/3Shtc2Y8Ug8gj4LuFtUd4gLGaXUylU7PLNJmphOhSqW?=
 =?us-ascii?Q?MMsyJBeQ8xC7QM3h7JQdhorAOkZuS+w1ii9mf39qgopXKd+GFO8T2YdJ5RQT?=
 =?us-ascii?Q?9L3pgbBR2Vo5qQFlh+myh3eZDn9SjTnia5YpQb3zZTVs4bWrgwb0fU9GdqaG?=
 =?us-ascii?Q?36wyfykXCAoLtqWiFFLhMke5NQxorDp8wDx/f6Nkna05TGleVfJ3LCDqupAJ?=
 =?us-ascii?Q?j65Bdde0+HSo+3AhWM+3tgnw7hqDC0ioAmZ1BbjVfViuwLV/8a3KYV06NzV8?=
 =?us-ascii?Q?hkrDsc1B6S/MLfJKka37XDNI1jSQDM5quV3lHaI51E1ngm5tEPJAh4UeAsF/?=
 =?us-ascii?Q?Mbb3KsjFXicKTbUteGGAIozelmyHY8S3hg9em+mBDG9tnpMuHwb2eKNfG8KX?=
 =?us-ascii?Q?k0RylMcG168ZsUKe+WMMtNM1A/SwJhGNWTr3bCaMhwYlqfIU7PfcVggZMurm?=
 =?us-ascii?Q?q/r1h5W6qVDT5IyPu8Gh6IPjgvEVFTj33y2nI+1KGF9vYCvMEm/N6sJQtDAO?=
 =?us-ascii?Q?NglJt/Se+txwqs/AtPHIZusvwBbHU0r8D05TKoxBW5ve/ExyfnGrqhUhWelz?=
 =?us-ascii?Q?a1TCUXVS7EMjK85W8IbnBdFa6O8U8puX0HsZkPPmy5FD1gxK1quZMEkge6fn?=
 =?us-ascii?Q?BtIfbJddlcignXKKZqpXS9imyztGDxvMPJjXLlpX7pV+FH4C67zykHB6SoGt?=
 =?us-ascii?Q?dkr6Y8VZmGr6KAZHu5kBYaJ7peqSBB1Xsq6uKATPvJ/3jZmZ8xw49KY+emev?=
 =?us-ascii?Q?rYfeyx+UnttfzjUlnbzyCacRXFQtxjO2qnGQ5PQKXWweYr0fjPVA7LN3RSef?=
 =?us-ascii?Q?dg/c17I3HH8D3NU8XLH2Hqi8ntmzC52I0PuuwniOlqWy9tbS2/hiEJ4VYtrs?=
 =?us-ascii?Q?+349a5Wl0441BdFPf/6L8rp/2xZPtX9YVnIfPuHy89AApk/letIBYqI7PYan?=
 =?us-ascii?Q?Id9s75xO5S7NnbcKpe4VOcQ0/DDQBCi7OkKPbcigJjXnOLr7RiazvHONuMQK?=
 =?us-ascii?Q?COSEVMXPL8reSzhNDTmygUK/BLlhPRRjtneL34S8Sz1yP9Fhb/AX8LpOCA85?=
 =?us-ascii?Q?tduFmc3Cd08lSYO1c2ToPRU4qczahg2MZFu8gehmbXLNAjI4gI3+9t89ugTX?=
 =?us-ascii?Q?WsDGWfkhExDKJzRHIlz/X6U7R0ag94kMktU9mhKWqz8iDy3XKNQ5afcq2FeX?=
 =?us-ascii?Q?MYtcprDBAFD6pzEB5Z5pXo860wSJxMZdWl/B7HMsKYxOozUlgvwk4zq353XC?=
 =?us-ascii?Q?NAIgnoYjojxvRh0Q3zTEeJvjt/zbsF3w/oBo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:46.5583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daa2e293-2a61-49d7-a3cd-08ddfccb892b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

Refactor the OSPI controller creation using the VersalMap structure.

Note that the connection to the PMC IOU SLCR is removed for now and will
be re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  12 +--
 hw/arm/xlnx-versal-virt.c    |  41 ++++------
 hw/arm/xlnx-versal.c         | 142 ++++++++++++++++++++---------------
 3 files changed, 98 insertions(+), 97 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 79ca9b13321..b7ef255d6fd 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -18,12 +18,10 @@
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/nvram/xlnx-bbram.h"
-#include "hw/ssi/xlnx-versal-ospi.h"
-#include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/misc/xlnx-versal-trng.h"
 #include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
@@ -86,18 +84,10 @@ struct Versal {
 
     /* The Platform Management Controller subsystem.  */
     struct {
         struct {
             XlnxVersalPmcIouSlcr slcr;
-
-            struct {
-                XlnxVersalOspi ospi;
-                XlnxCSUDMA dma_src;
-                XlnxCSUDMA dma_dst;
-                MemoryRegion linear_mr;
-                OrIRQState irq_orgate;
-            } ospi;
         } iou;
 
         XlnxZynqMPRTC rtc;
         XlnxVersalTRng trng;
         XlnxBBRam bbram;
@@ -134,10 +124,12 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
     s->cfg.fdt = fdt;
 }
 
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
+void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
+                              BlockBackend *blk);
 
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index b6c49dafe09..a948e24aea0 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -46,12 +46,12 @@ struct VersalVirt {
 
     CanBusState **canbus;
 
     struct {
         bool secure;
+        char *ospi_model;
     } cfg;
-    char *ospi_model;
 };
 
 static void fdt_create(VersalVirt *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
@@ -379,19 +379,19 @@ static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
 
 static char *versal_get_ospi_model(Object *obj, Error **errp)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
 
-    return g_strdup(s->ospi_model);
+    return g_strdup(s->cfg.ospi_model);
 }
 
 static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
 
-    g_free(s->ospi_model);
-    s->ospi_model = g_strdup(value);
+    g_free(s->cfg.ospi_model);
+    s->cfg.ospi_model = g_strdup(value);
 }
 
 
 static void versal_virt_init(MachineState *machine)
 {
@@ -480,42 +480,31 @@ static void versal_virt_init(MachineState *machine)
         s->binfo.dtb_limit = 0x1000000;
     }
     arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
 
     for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
-        BusState *spi_bus;
-        DeviceState *flash_dev;
         ObjectClass *flash_klass;
-        qemu_irq cs_line;
         DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
+        BlockBackend *blk;
+        const char *mdl;
 
-        spi_bus = qdev_get_child_bus(DEVICE(&s->soc.pmc.iou.ospi), "spi0");
-
-        if (s->ospi_model) {
-            flash_klass = object_class_by_name(s->ospi_model);
+        if (s->cfg.ospi_model) {
+            flash_klass = object_class_by_name(s->cfg.ospi_model);
             if (!flash_klass ||
                 object_class_is_abstract(flash_klass) ||
                 !object_class_dynamic_cast(flash_klass, TYPE_M25P80)) {
                 error_report("'%s' is either abstract or"
-                       " not a subtype of m25p80", s->ospi_model);
+                       " not a subtype of m25p80", s->cfg.ospi_model);
                 exit(1);
             }
+            mdl = s->cfg.ospi_model;
+        } else {
+            mdl = "mt35xu01g";
         }
 
-        flash_dev = qdev_new(s->ospi_model ? s->ospi_model : "mt35xu01g");
-
-        if (dinfo) {
-            qdev_prop_set_drive_err(flash_dev, "drive",
-                                    blk_by_legacy_dinfo(dinfo), &error_fatal);
-        }
-        qdev_prop_set_uint8(flash_dev, "cs", i);
-        qdev_realize_and_unref(flash_dev, spi_bus, &error_fatal);
-
-        cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
-
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.pmc.iou.ospi),
-                           i + 1, cs_line);
+        blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
+        versal_ospi_create_flash(&s->soc, i, mdl, blk);
     }
 }
 
 static void versal_virt_machine_instance_init(Object *obj)
 {
@@ -540,11 +529,11 @@ static void versal_virt_machine_instance_init(Object *obj)
 
 static void versal_virt_machine_finalize(Object *obj)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
 
-    g_free(s->ospi_model);
+    g_free(s->cfg.ospi_model);
     g_free(s->canbus);
 }
 
 static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index f8291ac614b..964250bf151 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -32,10 +32,11 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
+#include "hw/ssi/xlnx-versal-ospi.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -93,10 +94,19 @@ typedef struct VersalMap {
     struct VersalEfuseMap {
         uint64_t ctrl;
         uint64_t cache;
         int irq;
     } efuse;
+
+    struct VersalOspiMap {
+        uint64_t ctrl;
+        uint64_t dac;
+        uint64_t dac_sz;
+        uint64_t dma_src;
+        uint64_t dma_dst;
+        int irq;
+    } ospi;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -126,10 +136,17 @@ static const VersalMap VERSAL_MAP = {
 
     .usb[0] = { .xhci = 0xfe200000, .ctrl = 0xff9d0000, .irq = 22 },
     .num_usb = 1,
 
     .efuse = { .ctrl = 0xf1240000, .cache = 0xf1250000, .irq = 139 },
+
+    .ospi = {
+        .ctrl = 0xf1010000,
+        .dac = 0xc0000000, .dac_sz = 0x20000000,
+        .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
+        .irq = 124,
+    },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -813,99 +830,78 @@ static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
 
     sysbus_connect_irq(sbd, 0,
                        qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 2));
 }
 
-static void versal_create_ospi(Versal *s, qemu_irq *pic)
+static DeviceState *versal_create_ospi(Versal *s,
+                                       const struct VersalOspiMap *map)
 {
     SysBusDevice *sbd;
     MemoryRegion *mr_dac;
-    qemu_irq ospi_mux_sel;
-    DeviceState *orgate;
+    DeviceState *dev, *dma_dst, *dma_src, *orgate;
+    MemoryRegion *linear_mr = g_new(MemoryRegion, 1);
 
-    memory_region_init(&s->pmc.iou.ospi.linear_mr, OBJECT(s),
-                       "versal-ospi-linear-mr" , MM_PMC_OSPI_DAC_SIZE);
+    dev = qdev_new(TYPE_XILINX_VERSAL_OSPI);
+    object_property_add_child(OBJECT(s), "ospi", OBJECT(dev));
 
-    object_initialize_child(OBJECT(s), "versal-ospi", &s->pmc.iou.ospi.ospi,
-                            TYPE_XILINX_VERSAL_OSPI);
+    memory_region_init(linear_mr, OBJECT(dev), "linear-mr", map->dac_sz);
 
-    mr_dac = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pmc.iou.ospi.ospi), 1);
-    memory_region_add_subregion(&s->pmc.iou.ospi.linear_mr, 0x0, mr_dac);
+    mr_dac = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_add_subregion(linear_mr, 0x0, mr_dac);
 
     /* Create the OSPI destination DMA */
-    object_initialize_child(OBJECT(s), "versal-ospi-dma-dst",
-                            &s->pmc.iou.ospi.dma_dst,
-                            TYPE_XLNX_CSU_DMA);
+    dma_dst = qdev_new(TYPE_XLNX_CSU_DMA);
+    object_property_add_child(OBJECT(dev), "dma-dst-dev", OBJECT(dma_dst));
+    object_property_set_link(OBJECT(dma_dst), "dma",
+                             OBJECT(get_system_memory()), &error_abort);
 
-    object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_dst),
-                            "dma", OBJECT(get_system_memory()),
-                             &error_abort);
+    sbd = SYS_BUS_DEVICE(dma_dst);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_dst);
-    sysbus_realize(sbd, &error_fatal);
-
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI_DMA_DST,
+    memory_region_add_subregion(&s->mr_ps, map->dma_dst,
                                 sysbus_mmio_get_region(sbd, 0));
 
     /* Create the OSPI source DMA */
-    object_initialize_child(OBJECT(s), "versal-ospi-dma-src",
-                            &s->pmc.iou.ospi.dma_src,
-                            TYPE_XLNX_CSU_DMA);
+    dma_src = qdev_new(TYPE_XLNX_CSU_DMA);
+    object_property_add_child(OBJECT(dev), "dma-src-dev", OBJECT(dma_src));
 
-    object_property_set_bool(OBJECT(&s->pmc.iou.ospi.dma_src), "is-dst",
-                             false, &error_abort);
+    object_property_set_bool(OBJECT(dma_src), "is-dst", false, &error_abort);
 
-    object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_src),
-                            "dma", OBJECT(mr_dac), &error_abort);
-
-    object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_src),
-                            "stream-connected-dma",
-                             OBJECT(&s->pmc.iou.ospi.dma_dst),
+    object_property_set_link(OBJECT(dma_src), "dma", OBJECT(mr_dac),
                              &error_abort);
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_src);
-    sysbus_realize(sbd, &error_fatal);
+    object_property_set_link(OBJECT(dma_src), "stream-connected-dma",
+                             OBJECT(dma_dst), &error_abort);
 
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI_DMA_SRC,
+    sbd = SYS_BUS_DEVICE(dma_src);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+
+    memory_region_add_subregion(&s->mr_ps, map->dma_src,
                                 sysbus_mmio_get_region(sbd, 0));
 
     /* Realize the OSPI */
-    object_property_set_link(OBJECT(&s->pmc.iou.ospi.ospi), "dma-src",
-                             OBJECT(&s->pmc.iou.ospi.dma_src), &error_abort);
+    object_property_set_link(OBJECT(dev), "dma-src",
+                             OBJECT(dma_src), &error_abort);
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.iou.ospi.ospi);
-    sysbus_realize(sbd, &error_fatal);
+    sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI,
+    memory_region_add_subregion(&s->mr_ps, map->ctrl,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI_DAC,
-                                &s->pmc.iou.ospi.linear_mr);
-
-    /* ospi_mux_sel */
-    ospi_mux_sel = qdev_get_gpio_in_named(DEVICE(&s->pmc.iou.ospi.ospi),
-                                          "ospi-mux-sel", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "ospi-mux-sel", 0,
-                                ospi_mux_sel);
+    memory_region_add_subregion(&s->mr_ps, map->dac,
+                                linear_mr);
 
     /* OSPI irq */
-    object_initialize_child(OBJECT(s), "ospi-irq-orgate",
-                            &s->pmc.iou.ospi.irq_orgate, TYPE_OR_IRQ);
-    object_property_set_int(OBJECT(&s->pmc.iou.ospi.irq_orgate),
-                            "num-lines", NUM_OSPI_IRQ_LINES, &error_fatal);
+    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", NUM_OSPI_IRQ_LINES,
+                            map->irq);
 
-    orgate = DEVICE(&s->pmc.iou.ospi.irq_orgate);
-    qdev_realize(orgate, NULL, &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(orgate, 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(dma_src), 0, qdev_get_gpio_in(orgate, 1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
 
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.ospi.ospi), 0,
-                       qdev_get_gpio_in(orgate, 0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_src), 0,
-                       qdev_get_gpio_in(orgate, 1));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_dst), 0,
-                       qdev_get_gpio_in(orgate, 2));
-
-    qdev_connect_gpio_out(orgate, 0, pic[VERSAL_OSPI_IRQ]);
+    return dev;
 }
 
 static void versal_create_cfu(Versal *s, qemu_irq *pic)
 {
     SysBusDevice *sbd;
@@ -1264,17 +1260,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < map->num_usb; i++) {
         versal_create_usb(s, &map->usb[i]);
     }
 
     versal_create_efuse(s, &map->efuse);
+    versal_create_ospi(s, &map->ospi);
 
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_bbram(s, pic);
     versal_create_pmc_iou_slcr(s, pic);
-    versal_create_ospi(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
@@ -1316,10 +1312,34 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
     }
 
     qdev_prop_set_drive(efuse, "drive", blk);
 }
 
+void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
+                              BlockBackend *blk)
+{
+    BusState *spi_bus;
+    DeviceState *flash, *ospi;
+    qemu_irq cs_line;
+
+    ospi = DEVICE(versal_get_child(s, "ospi"));
+    spi_bus = qdev_get_child_bus(ospi, "spi0");
+
+    flash = qdev_new(flash_mdl);
+
+    if (blk) {
+        qdev_prop_set_drive_err(flash, "drive", blk, &error_fatal);
+    }
+    qdev_prop_set_uint8(flash, "cs", flash_idx);
+    qdev_realize_and_unref(flash, spi_bus, &error_fatal);
+
+    cs_line = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(ospi),
+                       flash_idx + 1, cs_line);
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
 
     return map->num_canfd;
-- 
2.51.0


