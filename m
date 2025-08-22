Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58A1CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVq-0007f4-1Q; Fri, 22 Aug 2025 11:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVl-0007cd-SP; Fri, 22 Aug 2025 11:17:04 -0400
Received: from mail-mw2nam04on20614.outbound.protection.outlook.com
 ([2a01:111:f403:240a::614]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVg-00078U-1I; Fri, 22 Aug 2025 11:17:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsX1X3exYA17Ia6KpPGTI+YK3y2nsFzQdYNZc3+fFr/w/zxUlu37vMZ5HhCWAcIJFX9iRxRTs3oyEC0ZECojoJyHEGdqhffRoNOjPSJTcBWf8IQENv/QTymmnMYq1epSELKB13wNCInG1kIF8FCDdoXfmjQNJbgVV2GgWskYhsgaRLM1YGNCFR0PaeTw1UnjJfAHU3bf0jFZAlK4+/yHZYxFlpndIeD6MIYvvqQmSVurWR3k6fmnt3XZBHSXfdWQOfDh05KV0tG5AA/efjh7Oxs2PmLZ5PcHDbRh9Xeuszt0kAapaj/Ll5+ELAI6kV1EKJk6Yz3qzLwT0ZVARvPQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GVFOpgD5cuikSEHQnTlkIGLIKuGLmmyHuPo24qKSiU=;
 b=vdHUH0mzqI8DFzX3sjoj5fqJ1fpbz7adGIAEOxVYSWaLEo1/fOskmGJ10zGLr7Vnk0xHXumHrYuPDx975amF1mdvVExhqq4dFEJQvvECDtZvTEX/tpIUUdKVQh4Ib6VTWiUJyPNzXPZJmOmvcRnOIkre83tH0bqTigfCAB6BZvlBDTt1GeFbwq6va7iJF+k8OzvnJlQgVWhvvZZ22Sg93YBilZfgfHo4kJS8ciiZMArdq4mAgFfqlitw4Cps7u/sI76Zu138ADBd1il4/ArqnB6ccrG1fUnXZM03V1I0tFsJTJRmVGAHcTm6aEMXYQbqg4se/wbArAC7mOTYHbDimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GVFOpgD5cuikSEHQnTlkIGLIKuGLmmyHuPo24qKSiU=;
 b=jDEsADdimHYs46lzc46kffCWmD8tgL3mpvTeiW4WhHHpeS1k9GRQs7Vp4rRV/z9D5iX0IwwNhHLnKEkWwD72/edhRmlP4fLhpkEwx5/9MHSTrqcFyfptzrU00rVhB31zIAh28GeW/1rEph71Dy/iqe6/UvSWUNwR0Y1VYYbQiH0=
Received: from DS7PR05CA0100.namprd05.prod.outlook.com (2603:10b6:8:56::23) by
 SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 15:16:47 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::d0) by DS7PR05CA0100.outlook.office365.com
 (2603:10b6:8:56::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Fri,
 22 Aug 2025 15:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:46 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:44 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 11/47] hw/arm/xlnx-versal: ospi: refactor creation
Date: Fri, 22 Aug 2025 17:15:36 +0200
Message-ID: <20250822151614.187856-12-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 715b441c-16ad-476c-8b8d-08dde18ee950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4OJ8LFtKX8n710haIq1WhWx5xNBRbaBO+AKrYmZeF0R+l8gtgoIVg6Kiehgq?=
 =?us-ascii?Q?j4AIm/FwGpccVhq3UbxqFOpWP6zkkPzxEmgqzbdfVFHonRRMtZ5AxVzw/2lD?=
 =?us-ascii?Q?sIY6RJHA7yXFjg91QFfOm7/EsDHos4VBk9T6moAjQ+ZdFlIlAboerEyKHNES?=
 =?us-ascii?Q?PoocycXfejUgX2MQTpgNkodEH1XU6y/fumddEryxvEYbc6A43+YCNoKKvhfc?=
 =?us-ascii?Q?tUk8xkVogtdHOgnQMEqCZQFdj8EvKSqAx3VmcWGo6tmgEjCJuGX2as93Skap?=
 =?us-ascii?Q?RrYbPYCyu70pLrgDrDGNWv2+FAeQP+IB5lZG6Uqv6M6xMGCrTcltJ2ZUngbV?=
 =?us-ascii?Q?o6eIfijlSY1lmG0of1dyr8eoK8PnFEsKeTgVKXNwVw3nZ4ZBVilQr4NJ5s64?=
 =?us-ascii?Q?P3i7bPESYQVxGsF/nIZ9TSsA6sRMshRj8S3aNsXnhxNb2ENXoO5M/1/zKNIh?=
 =?us-ascii?Q?rP8SEQa3S3VotH/uujnXayza0G+i7+c/JnLgUN/FdAGve9pD7qGXgCFRlKFw?=
 =?us-ascii?Q?wSfBro+b9fsxpWv788M0SU9SnhFGjHg2BRkSrKuM5R95oxfg/DAOA6D7DpKV?=
 =?us-ascii?Q?dWHH9P1+eOSnfHgvzP5sEmlU+MWq9fqgAx+mp+LE/65xlFbvXSOPVKq4NJxK?=
 =?us-ascii?Q?6P8gy6OWxKOfdpGSjV8j2rxhEnHRQs++QqML7NqmbEYTCkBC4KnrHo+LpZA1?=
 =?us-ascii?Q?5+LYs6xYMk/qqWbl1TTzxkesIevlu35OdeVcsphUm3eQw4rttbLXmvmhWvdd?=
 =?us-ascii?Q?PxrtZRdUpQrf8r/w6pX9Kcat5RNVq+q1+PQ6STG1wSCZD5L1QWt0ZnN2T44o?=
 =?us-ascii?Q?Crsv+sxpJadiI6HE4iYH8zF6kJ2SzcxulnXOTIw0MUDWegLBynxbt6pPqKJh?=
 =?us-ascii?Q?XQSP1kdbn5WOcMHbZPkUV0LmQspYyev2sb6czDRUD/hqxgxmp9SH8hWOX+tf?=
 =?us-ascii?Q?1uQBitSzoEEzlai13yAh4hfZGyg/BB0Ab7JlqxkqTIbJfuk1z7EpjcTDjjB3?=
 =?us-ascii?Q?e4FqERdA+NVGSvSMuKKIsHpOWapd5jC2EAVxtC6d3cJxBlhdUFcOpywciH1d?=
 =?us-ascii?Q?XMu5PYSevqctVWzTPNWsQuYrbgiNxq03wVK4Bx4yyaYDiVY3nxKqzyiVR0NC?=
 =?us-ascii?Q?jl5Gzqui+DkM/4yvgG9F91tx8KTq4tkoIvW4VxaixRWItNiqm2BrGuvYaU+z?=
 =?us-ascii?Q?Bs08FDRkljeHoCIk3kzN4tIhNCkv1QvV16mqqVcL3glJa4mOUYiPJSc2laSt?=
 =?us-ascii?Q?bsrxtgDseAqx+SqFVmgtR4ctFG0Vi06xx5kgN4+2VBo2gD7Y0JF+xtgXSOFa?=
 =?us-ascii?Q?mQOvQsDbZVqvyGmueMfg3rjz23vt9M+bI7m8hTweeZDS5qNcNQZ4q9WS4IpM?=
 =?us-ascii?Q?tzMtt2KS+4NBCIoqMJbMDN+04BIa0MRk0qzb7EFJNVqeyNMS8v5Km5SXw5iN?=
 =?us-ascii?Q?YYLlO2SKdSyaxgThQXzuorvHMnuabTIhHbaF+jfWaDlCp35IrIxP3cquqsI+?=
 =?us-ascii?Q?kauPavmn19rMu/5cs+5oHAYFcehtaa/xcC++?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:47.1647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 715b441c-16ad-476c-8b8d-08dde18ee950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
Received-SPF: permerror client-ip=2a01:111:f403:240a::614;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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
index 1d3c08e1920..56022021766 100644
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
@@ -1268,17 +1264,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
 
@@ -1320,10 +1316,34 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
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


