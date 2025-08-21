Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC0BCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yJ-0001Rz-Jc; Thu, 21 Aug 2025 09:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y4-0001Kl-HV; Thu, 21 Aug 2025 09:04:36 -0400
Received: from mail-dm6nam12on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2417::615]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4xz-0002tt-Ur; Thu, 21 Aug 2025 09:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pT/HZuW3pyWszE+7Eajw3g+VjTWSKEd3jtLXsRESBbPCPDmtAZlKDAKjhPUzMh13OV64IbodS+AaUNyDiR3mAT8qjHgcWJDDCKKiBaWgIo3iAuMjkr8u01+V1cf+mDsmSMKDjxQlv9/2gaMjrwo2JvVKnhBp3U4loCQd4c4VemIWfCQvKC+n50AS+zawxZEWLZgs51pC02mKLgfO8xcP9GDBbbNKeQjX4jZNAOah/C7M/XFLERg0bP6we4FGHOUcnqkOdzHyLjaHeFK4qEyrY1QIvYXVc8QZpQgwxE5l8U7EpRBGzm0OoNMooP+TZPEZvCRC7KjjJLZLDEQ4BWH7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ANfHm4D/tSsBD7os2oiUUL97TnKf4TZA59ScZR96tU=;
 b=s+cOIZEJL3Iej4MZGcMuseTU9HjhDWq8/FgpD4cGi7eIGPW7/ErGf50TksX1T1wmCu7++GkAfcu9lBF7osxeajTDbKCh5B8+qoqSWj0T89a5rTJo9fpiHJvFWM2onsmUOAKDJ+YzFnbWwoNJIsjqTKljvl5jmimpMjd8LIMDglRtvOSsOAlvpZPd0DQl6Ts6oazuKGPCoYeP3bLqkf+ciX8n931FUaco4RyVwn4YxDFBHta5Y4cNJJP3WpYxjn3drHW1eEFwqbVUcKjkF3BZ/GZpGIMd/5kFTzmW8LE38iYo0W5w/g5VoNF6k8+f3r4UuFwpXrEgYjbzlEdCfIyn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ANfHm4D/tSsBD7os2oiUUL97TnKf4TZA59ScZR96tU=;
 b=ksL8+PHn191xc4GhBzY+41YV9NSjqOk6yiTcS2/sZ1HDvYa4Bk5EzNGCqSq7u5bb7AM9x5SNdfk/gzsXAg3CR+BZXiq9zCt+Fm7E5WRnCGCZ6jFObrPNaTJBfGYsMAsvKYrCUH7ZcxKR5O5x18hosfpPEIefKzcl0YY/m5p1oao=
Received: from SA9PR13CA0068.namprd13.prod.outlook.com (2603:10b6:806:23::13)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 13:04:25 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::d1) by SA9PR13CA0068.outlook.office365.com
 (2603:10b6:806:23::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Thu,
 21 Aug 2025 13:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:04:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:23 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:21 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 11/47] hw/arm/xlnx-versal: ospi: refactor creation
Date: Thu, 21 Aug 2025 15:03:10 +0200
Message-ID: <20250821130354.125971-12-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: 05102774-52ee-4291-6e66-08dde0b340bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0aK3t8nhKiHN/+FLjwLdAzSu7E9INk46qgBC0/w07icXJ+B8XYBYMDj8jGd7?=
 =?us-ascii?Q?5+a3kTWlTQsJWjFxyrjJ4JDTkH6WSPM3xxxeomqTa5ZQL+4t7unL7Cp5PhVe?=
 =?us-ascii?Q?ArnA2zxAxoa2+yqeAux20xLffZmFsf9ImbZzKWmAHdHJlpwjjxByIYRDiuH/?=
 =?us-ascii?Q?xoiKXFPi2/K25bWRrjQdwt2GNkbtw2cH6o2ZmFF3uYNkkJCqAdX6CxvOdTYv?=
 =?us-ascii?Q?ga9W5L3vFTCCZ2Ms+AerzL4ZGjA4hfL1rmuMXac6lwFeBlcaBPHNVqZ+ELmU?=
 =?us-ascii?Q?bO/kMVtuiXFg9C7YzIuozkcme68PFmwwNlWiL2XynriE1OnO/VpjByrOADXW?=
 =?us-ascii?Q?MD++cyugOdFySCwZ/p4zatBi4/XLdYuDsYfam3scEifsOPEg4jKKoVFhyOxT?=
 =?us-ascii?Q?6yxMu9kYQyMYJ2gadwRSpJ0vRJAqEG93UUfGmdEA+lVkXdx1i1luBFIc5hMU?=
 =?us-ascii?Q?sUI2tswFs+2ecYeLXfNzKTbPEPHBBEseTO33QtuFF+wMKJnk++Tg5c7q5FtI?=
 =?us-ascii?Q?Djo93IDUTjr8QOvWYMMkRdPzo6AONtaOap5uONSN+3Vm63mVjzhONfh+Wizu?=
 =?us-ascii?Q?WMNjtwfTcJnUOZbAFLiy8Er2oHImwp3EIT4JRa4lVbpr80LQS3W96wIEq2Ya?=
 =?us-ascii?Q?bu0GpVHRoju6cP5j1BajblwlN2eqansOuib94KG2WnE7RM0l8pK+MdrKGw1U?=
 =?us-ascii?Q?usSEGgR9WBVThT4pzMyMLCd13cf8YtxwjfLIvIv7BHUodfJ0FjMkMITvqBzl?=
 =?us-ascii?Q?Q+7lNvNK4yYqU4Q4+QaXy4GRgFBRAHcnsDCtQ7xBkrShpW5arjP4iZGmmM7T?=
 =?us-ascii?Q?G7kz+dM+/fsBQecSLEQ9FPdGEx/HOFA2QJHr9PMfdHeNP+cbmSCa9GHXYeHx?=
 =?us-ascii?Q?9c8m+cQ/dyAde7WXdh3p4L/UQKVW5xvRbvZVkMeyD9B5WnlVgDI8eXVvccIC?=
 =?us-ascii?Q?TQ2iG0zHbzj2WVsobVTsc9/3yMCp1+myW3KKgWQfyBAROfVDk/1KSMPb9JGR?=
 =?us-ascii?Q?5fHLr3YkdL2YzBp234xwg+b/Djlo9QiOpVpjhuOZLVpxUkRQUpLFFlnR3FIR?=
 =?us-ascii?Q?T10JxXD87amC4vaQfBvu5IJ8BWRKbLKiTTPHN0/wQpzEg3Z5bUMsd9ej0fLZ?=
 =?us-ascii?Q?36KqlaDM36GAN7IUhN9GiKLfXkfB142RhuTJGlGfmkEDSB+zYh6k6usOlr4A?=
 =?us-ascii?Q?Db6uExiAX7JTk+4yLP4ndikB3vu+XWI8yDmGKfXhEjf1x4100FXh0Vf81qZi?=
 =?us-ascii?Q?WLHtBnJMVN9yCzNDLkqaxRA4C2m91ooJY3DYKEQ6b329wKQx1NkPbOQ1Mo0H?=
 =?us-ascii?Q?y838ZvYuI8Unb4uL73fWygsWZzXhbjftY9rh81DhSBkuGxUpa2N61HO+pF91?=
 =?us-ascii?Q?kuLbw5xJC/o3FOPZLoixUsEwuu7ly8E+HB0i3ylbVcgo3xccg4wWdSl3Kx4u?=
 =?us-ascii?Q?7sGcWoD83ZO+p1Kk9rv8KWBWwETUQAuVwR8NHhvnDzRkff6/1MKrnYTRWyoJ?=
 =?us-ascii?Q?INdadQtpvrN/iqnXY5aSzeUTyKzhnugy3l7n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:24.5678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05102774-52ee-4291-6e66-08dde0b340bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8
Received-SPF: permerror client-ip=2a01:111:f403:2417::615;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index f8e9a269b50..c5dcd57d1dd 100644
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
index ed202b0fcda..58176fa11e5 100644
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
@@ -807,99 +824,78 @@ static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
 
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
@@ -1256,17 +1252,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
 
@@ -1308,10 +1304,34 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
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
2.50.1


