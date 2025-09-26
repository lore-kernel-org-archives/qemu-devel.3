Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94064CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22ZK-0005te-TK; Fri, 26 Sep 2025 03:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZH-0005qW-3Q; Fri, 26 Sep 2025 03:08:35 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZB-0006Wo-G4; Fri, 26 Sep 2025 03:08:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUx2ipWHpkhgnvqfVkI8H9J4bK2djCFMQVvMBHFRfpv60mQtEYf+giommgCQy+ar7EEIjSphNsq4Lbep9/xjPd3bqZcMMD1lXRjHdoOu4bM2nnXiA4UPOArK98er/FRsSpwhRNR3DaFJCv/1FnUgUtnZJRKC7t9FbzycODiCw9WlNq5eQszY1vj6AMMRH1i/yMAmvGih8QQqPm9fNW4pSbvVXPJmAW2J8W7z55iDoxRg7v5vtZQPxXTctq1mGge3cjD+RprvKvQi0JG/qqdX7RWkQbThFLdtn/qAafeWdSZUk/BkxLYJZjrKpCWUaJY0uWuz894NT4Rm8Wuk+I2p4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIrAjLTbwa9OuTdFkOuau2VIvTslwCE/4KxSn/GCzIs=;
 b=IxqIaCs3T2p3JikqEboSCKtIoNoc9kwHUHgP9G3Sg9Kg4lUW9aPThDH+zc+46mmk/ANAuZKUIf9tcIx7h0/2kp/pzaJHRZmdYCHqE7Kp+7Y8ld6AJADbxFs8wrqqgkhRqtqIbKxhgAZdFatFLoU8+Oq35r+RhZS7BzJ64f05elC8Kdlvt6CnNww+sMPkC38vVNF6jvpn9yPezVWhUsuiTxM7Hsj0uSIuDpdAQeN3knju2Aobcj7yttRD6efPmuao2HSJ1Nxfq6FFUYTEf8Rb+x9puOzAqJ/T3eKC8nom3LDf9+8dsATx3hyNis5tAfcZ99nOBk1RIobCdEYgbRltJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIrAjLTbwa9OuTdFkOuau2VIvTslwCE/4KxSn/GCzIs=;
 b=LhmBrkzNytVlUk+Ii/jgVSsyD9fEe6LHEdOLdpzG/ekQUpFePZ6BfOjt2d2r2ByxUmcPkdyH9j8Sc2hSI3yxjfTXVVUs0A4HGOxtip9EOK7qctyI2w2cJOWka+maInrAiYmpyvbTaLxk2YYQYlHxr24BnLyMeZqjaIg4EX60KMo=
Received: from CH2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:59::24)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:08:19 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::44) by CH2PR03CA0014.outlook.office365.com
 (2603:10b6:610:59::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Fri,
 26 Sep 2025 07:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:17 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:17 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:15 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Date: Fri, 26 Sep 2025 09:07:20 +0200
Message-ID: <20250926070806.292065-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3799dc-7681-4029-8b38-08ddfccb790a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bwoqnzGkcFdB543Efgd1WGDpZJ+WOu+AEoqrIpa2SLv9me/22nXI5AjYfzQ3?=
 =?us-ascii?Q?TK6R8DNIEluNKJFLZJ9N1bwCjvxLtVMhu3d3CHsXlgqsid0qc3udy8DMwEsJ?=
 =?us-ascii?Q?JSkkqHwNurxAceCPm3iE5fI88LJg4EtCWC/HU50NO4CUlAqC0L1QXB4Vfcp4?=
 =?us-ascii?Q?AZztkz9h02vpnQiRwppmo5H/OyIrohv1JOztDpXEtMwkr52pIqFJyOeadNch?=
 =?us-ascii?Q?Ql4vJzw7pLdRdbR68k1xOo8vPb0maDwsXOM38p6qIkPiuc0YXgvOSnftHERZ?=
 =?us-ascii?Q?qZ9DGhmVrtyGbg5lNqadcC4azaamYj8prlxWgzQQ6cSJEetEH4cqeakO60jG?=
 =?us-ascii?Q?EAhKRjJcPvhEEtIaVxg2uMLhxHdgfbwmsZlxC/ShvymMMNi9Rsi6C1vQg9xy?=
 =?us-ascii?Q?13xe/OzViih+8Szm6O7w7y/qJQyJ7pR128Yd2xzS+WWDZqAEDPRt6BwbPDiP?=
 =?us-ascii?Q?Mf5ldR0Tp+2HK6PvAXxChQbd+XTm8hLFIMd8LTeqa5NjtiNlkk2QQVnC8Ftx?=
 =?us-ascii?Q?7YhEOB9hJUbaY7arFmSggPJ9x9J7JaTjcCn0Q/saN/Gt9Dsqrl3+l8G8NwDa?=
 =?us-ascii?Q?sx4OSL+j11lryqMr8+fedmczF9tnFeucFY877hcH70KLS4aziVgJjNRlnjvP?=
 =?us-ascii?Q?majO5PxrCFB1ZVbY7bX6QKjmmPc5JV+26gmhOMQzX4qHvhqDJP2kn4Ko7Hh4?=
 =?us-ascii?Q?i6/ne3i++9ZYqiZtqbiRmcc1WELeD2vBabwbYQ3ZiqlpeNwvJuj06Eu2dRP1?=
 =?us-ascii?Q?ScyFhX9hqNT2fhN/BzOmNIiHdwMD/q3/R2ZZ3/qW9Fu8a5SIvK4DCVZgzjhT?=
 =?us-ascii?Q?E+uZ39XROGRfDhpu0wYELaJENSIl37rccw8mSE8gVpQ6u0nnGRbFOAIEKulX?=
 =?us-ascii?Q?3KX53fWLBZs5vTJ+WtoLLTc5wOKZj6INyZ8SESRvW1chokmVGj1al36XQcyq?=
 =?us-ascii?Q?Hsaei+DnnWokcy9Cj+73Pg8Oo7NS3tqd/KyoqUk0nRC3vJ+gK4+fRlwKiWLh?=
 =?us-ascii?Q?pM2pJUXYPrDuWeGaujqS/WpJps0id22hozGsLBpH11CtPD8qC8WAjCSVeLBV?=
 =?us-ascii?Q?sQl5u24NRyNs7TqMCedNrND4e4fN1ULBJwQDX9R1kc/KSEV+OM+JDQ60cDfB?=
 =?us-ascii?Q?nktTfCXHDo+cN6DwgAT9WT3qntzQCcPy6u3BOOYBcfH/mAS5+Q9HmAb1yPls?=
 =?us-ascii?Q?tkzEWQ+ftbUyrLmyxgW+yAWGl01XrUCt1fp/8/375vpMALD1Fejc9y/8qN6c?=
 =?us-ascii?Q?eVmcgy63M5yRFGXqJDWmYjxbxDk8/iDagewPX7st9vpnEvab73dqjGcBwHpd?=
 =?us-ascii?Q?tkR+jBDkXEU66liEw6QUgA+JEJF/rh9P1cNrFTAV/YEfiJIaUq9CTM/RfAfy?=
 =?us-ascii?Q?jq6XLXcF9HL54coMdcR+NZA6vm/1AwDHw39R5SqFXpAsWGc1Bv8zyWFc8cBD?=
 =?us-ascii?Q?9ptHSbt+pZsJdMbGAvS8zBN962dlwFZHI01tcbOnPbar8iiNIE5iZ1P88SzE?=
 =?us-ascii?Q?YHwU6gcPPbBxEzeyztrUmPZq0/nLKtj/W2NgvPeoBvAzsrLrEP1flc4PHS3L?=
 =?us-ascii?Q?V3ibe1VZVNOEmvb1jqk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:19.4982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3799dc-7681-4029-8b38-08ddfccb790a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=Luc.Michel@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The following commits will move FDT creation logic from the
xlnx-versal-virt machine to the xlnx-versal SoC itself. Prepare this by
passing the FDT handle to the SoC before it is realized.

For now the SoC only creates the two clock nodes. The ones from the
xlnx-versal virt machine are renamed with a `old-' prefix and will be
removed once they are not referenced anymore.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h | 12 ++++++++++++
 hw/arm/xlnx-versal-virt.c    |  9 ++++++---
 hw/arm/xlnx-versal.c         | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 1f92e314d6c..f2a62b43552 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -134,21 +134,33 @@ struct Versal {
         XlnxVersalCFrameBcastReg cframe_bcast;
 
         OrIRQState apb_irq_orgate;
     } pmc;
 
+    struct {
+        uint32_t clk_25mhz;
+        uint32_t clk_125mhz;
+    } phandle;
+
     struct {
         MemoryRegion *mr_ddr;
+        void *fdt;
     } cfg;
 };
 
 struct VersalClass {
     SysBusDeviceClass parent;
 
     VersalVersion version;
 };
 
+static inline void versal_set_fdt(Versal *s, void *fdt)
+{
+    g_assert(!qdev_is_realized(DEVICE(s)));
+    s->cfg.fdt = fdt;
+}
+
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
 #define VERSAL_GIC_MAINT_IRQ        9
 #define VERSAL_TIMER_VIRT_IRQ       11
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index adadbb72902..d1c65afa2ac 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -1,9 +1,10 @@
 /*
  * Xilinx Versal Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 or
  * (at your option) any later version.
@@ -695,14 +696,16 @@ static void versal_virt_init(MachineState *machine)
                              &error_abort);
     object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
                              &error_abort);
     object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     fdt_create(s);
+    versal_set_fdt(&s->soc, s->fdt);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
+
     fdt_add_gem_nodes(s);
     fdt_add_uart_nodes(s);
     fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
@@ -712,12 +715,12 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
-    fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
-    fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
+    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
+    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     /* Make the APU cpu address space visible to virtio and other
      * modules unaware of multiple address-spaces.  */
     memory_region_add_subregion_overlap(get_system_memory(),
                                         0, &s->soc.fpd.apu.mr, 0);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 4da656318f6..3b596219561 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -22,10 +22,12 @@
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
+#include "system/device_tree.h"
+#include "hw/arm/fdt.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -917,15 +919,37 @@ static void versal_unimp(Versal *s)
     qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
                                 SYSBUS_DEVICE_GPIO_IRQ, 0,
                                 gpio_in);
 }
 
+static uint32_t fdt_add_clk_node(Versal *s, const char *name,
+                                 unsigned int freq_hz)
+{
+    uint32_t phandle;
+
+    phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
+
+    qemu_fdt_add_subnode(s->cfg.fdt, name);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "phandle", phandle);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "clock-frequency", freq_hz);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "#clock-cells", 0x0);
+    qemu_fdt_setprop_string(s->cfg.fdt, name, "compatible", "fixed-clock");
+    qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
+
+    return phandle;
+}
+
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
 
+    g_assert(s->cfg.fdt != NULL);
+
+    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
+    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
+
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
     versal_create_uarts(s, pic);
     versal_create_canfds(s, pic);
-- 
2.51.0


