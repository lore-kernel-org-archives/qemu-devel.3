Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F28CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4zG-0002d8-VR; Thu, 21 Aug 2025 09:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yn-0001pm-1u; Thu, 21 Aug 2025 09:05:21 -0400
Received: from mail-bn1nam02on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2407::608]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yb-0003C1-Qt; Thu, 21 Aug 2025 09:05:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIXmK4P8kBk8Bq2ZmJue+z/ymmLPL39u4dMTahFQzEyOY0nQC6jL6nECu/InM1xZIuXPNw5bDOJKj1gEDj0/a45exn0oxFwVH0tJlaZJ2oZDD9wg2p+Kuo2oWORRDTi7wE5/qRjKTPWyCXdHDxyUvH1SFUEdKke0p9NvLsMJkvWkbXpQKQeGUcil2yaSBb73204CgIxXlHV9AQ2BbxpHbrkatMgl466KXlLb5TN5HljHnZe96nqGM2o1Bog84gh6fu86dVZXHsOgWzDnot450oC77ASYCcnQ/N7eB3BFsINI7nHNCq3aGvicD4ViDQI7u/XjPRcm+o/JzYrvfwp6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNSn71sOES7CzqJCS9IPqYj7f24MY+auLsE02FbqXKw=;
 b=mJQkn/nVe5TGTQMIf1WnLAPRDfOSN91Su/4rm+ziRQG0PvzqTpXvMXMXmdC5xjUn2fjnTVJQflKF+lMWFuAsMUWGCvAzkEYwiqNgS9JlixQhChx3bbseFMEFqdzojYIp0GogKCUnVhneUVD/SmXPaw+Rzz5wILVcCCGP0cNUACABealKoSAHRLrjA6nILgsmSyWmVygU2xq7GG5PWWaddxYosxLMH/ygL70jmu1CM6XHsNqHA7OOybiOEKZSKs2rWw/I007Vhn6wP5BniwOgrrMiMJ285mXWNkCBIEes/uJyr5F41RmiEFQc8itfv61kweY8tY1UJ8mroNw3LXPL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNSn71sOES7CzqJCS9IPqYj7f24MY+auLsE02FbqXKw=;
 b=wI+wM6aXZOaTzsy2jqgrFsM68QvKwbeEz7c6X7pfBVLiwfBywSqvgf2WpHzjPRikwNAl5gykWecWniPEKj+4TIGZcMBJGPNk3chlCEG/BRkruXSnliTBM5ji64BYqB021ipT9XjVr6MHNyYmRKeTKuB+9xB+DhplmZvYPW+BwkI=
Received: from SJ0PR03CA0284.namprd03.prod.outlook.com (2603:10b6:a03:39e::19)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:05:01 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::1a) by SJ0PR03CA0284.outlook.office365.com
 (2603:10b6:a03:39e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:05:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:51 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:49 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 26/47] hw/arm/xlnx-versal: rpu: refactor creation
Date: Thu, 21 Aug 2025 15:03:25 +0200
Message-ID: <20250821130354.125971-27-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: dc01b0d4-82bb-44b2-aa29-08dde0b356b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SP9LmfV2gnFvM+cPu509x6s3ewBWLIrbl/q7bFeo2prQa35uDBKq1+gxACcH?=
 =?us-ascii?Q?vKMGC/ErmZXjfDSuPxLlmiHbquWjSclMIv9frzTYqNIBSSi0PL48t4a9rqGo?=
 =?us-ascii?Q?8xn5LokAFPrMgAXNBThkGJFsXe04rbq5kfZyd6bHLrSmmgSpTbROCOp57GP2?=
 =?us-ascii?Q?+NnwDO0hbKbskASZhCuLHyzwe+veLLhyKexiQPU0e1AO04yjHWEVYXMLHkhJ?=
 =?us-ascii?Q?dTWSAi4OoDpebePe4WaSSONxsxD/klUR+zHYd2GM0o4llfsM9r6cLy6xjSBs?=
 =?us-ascii?Q?oAGYngm1jCNhRHIg1yoZb1ZmiH2vyqHUvk6HlmjSwA1106uiqU6fL0Z4vm0R?=
 =?us-ascii?Q?8iOGhd2+QDLKlzsq+UHqbnybBW2kgpogaIrTOfWw4IKQYYGQ5HyL8Q+j5Bib?=
 =?us-ascii?Q?cx9TQevOt9HCKiipFqq+pUPxY+0gAnP3VWurOzNbyo4wp5IbRJJVJ7txLeWh?=
 =?us-ascii?Q?87WNoazVJr7EPMo1h5DVEb5Gw6+iY5xSfqWlNEbgyvzS+FzfDsS1AX2ThR1t?=
 =?us-ascii?Q?s/qxNxTT3QWQI3xwDb7DPm46PsAAckN5JSn+HL42zLk3qt+TlKcZ1XanZ/88?=
 =?us-ascii?Q?5ul/RRre8hrswPa9FkqhH1/D3b2a3/f/fiQXNSsTuXFf/RZ9mQOewB1CBSgJ?=
 =?us-ascii?Q?lziFAvYk+1GSl4e3Rqjj45Wzzaz8+SPE32c7WNtg3U8jzh1g5qUVNySyi/V7?=
 =?us-ascii?Q?4KY3vbee8pJe9NBMOJVYgxF/dCkW0cj9SsK/tHyFDYoOVBD/IggdxZ0tJHxJ?=
 =?us-ascii?Q?sL498qi7zS27akCfxTsCjA2t0/4ce12wyQcPXhYGnYK3NgY02xLbSzqearNb?=
 =?us-ascii?Q?YsiAJUEgbQfG1yKqbwXpJ5JwVeV/EUAXEkfmMrYCe/YhUkt4vXw4xjHDJJza?=
 =?us-ascii?Q?cVZf2kTd2VuuJuU6wK38ifSZ8qLtuDnufML8zcKF0ATGGx8oJ2HVBVf0HIUZ?=
 =?us-ascii?Q?8rldT/7tLhP/SGXOw9EkqZAoeiz8NBdR95KxP54Olp4xzDizbTvgZnaaHbNF?=
 =?us-ascii?Q?gpV/sq7B8lDPhpoPiOy1KI52wsdtUOoE7Q0so0t9fOuEBH0bNyiISHKVbqQP?=
 =?us-ascii?Q?llGEAxzLu4MfIpHHR76ggl/anjvyFO3BaconzcSeGA9MUpwcFP8+Vn6wQXyg?=
 =?us-ascii?Q?Jm9vA59NbRmXl7sk7v+4X1LpO7VQ27Al0e0RRLlKuabEPNBDNpXiYWA22Scg?=
 =?us-ascii?Q?LdxiMdCyejxjuRYPH3jNenxH6x0aiMRrEhaPNrtXH62lYQ3yc7iaZ/nmbpdJ?=
 =?us-ascii?Q?qeF78A2ivTx/wlrxbsH8lx7Ewz47JFyx5SwpROxtLrwU1U63POp0EKC7F59L?=
 =?us-ascii?Q?W7HYC4PqO0TmGWxYq+hxkvR2F5rQoMDe8HyKgJ+v7/W9mpN3FbVcITqRWGL+?=
 =?us-ascii?Q?LPy2vFngkCMFMqkkajqk257k8gxjzJEJN6a7uCKcYhZuRyaToUcJ0V9UGCcH?=
 =?us-ascii?Q?+vhpylTBBM6U0MvKiH1j7/fV4vLrQwe+j3jEELC0m0z6vVtn2WgdcAwJwmrg?=
 =?us-ascii?Q?80oTucSbRNjm3cM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:01.3372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc01b0d4-82bb-44b2-aa29-08dde0b356b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
Received-SPF: permerror client-ip=2a01:111:f403:2407::608;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Refactor the RPU cluster creation using the VersalMap structure. This
effectively instantiate the RPU GICv2 which was not instantiated before.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h | 11 -------
 hw/arm/xlnx-versal-virt.c    |  1 +
 hw/arm/xlnx-versal.c         | 60 +++++++++++++++---------------------
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 984f9f2ccdd..0a91ec7ae36 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -12,14 +12,12 @@
 
 #ifndef XLNX_VERSAL_H
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
-#include "hw/cpu/cluster.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
-#include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
 OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 
@@ -50,19 +48,10 @@ struct Versal {
         MemoryRegion mr_ddr_ranges[4];
     } noc;
 
     struct {
         MemoryRegion mr_ocm;
-
-        /* Real-time Processing Unit.  */
-        struct {
-            MemoryRegion mr;
-            MemoryRegion mr_ps_alias;
-
-            CPUClusterState cluster;
-            ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
-        } rpu;
     } lpd;
 
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index c2cf69e2c14..a3945625014 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -22,10 +22,11 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
 #include "target/arm/multiprocessing.h"
 #include "qom/object.h"
+#include "target/arm/cpu.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(VersalVirt, XLNX_VERSAL_VIRT_MACHINE)
 
 #define XLNX_VERSAL_NUM_OSPI_FLASH 4
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 0137c81c57d..ed9449685be 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -45,10 +45,12 @@
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/core/split-irq.h"
+#include "target/arm/cpu.h"
+#include "hw/cpu/cluster.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -105,10 +107,11 @@ typedef struct VersalCpuClusterMap {
     enum StartPoweredOffMode start_powered_off;
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
     VersalCpuClusterMap apu;
+    VersalCpuClusterMap rpu;
 
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
 
     VersalSimplePeriphMap canfd[4];
@@ -224,10 +227,31 @@ static const VersalMap VERSAL_MAP = {
             .has_its = true,
             .its = 0xf9020000,
         },
     },
 
+    .rpu = {
+        .name = "rpu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-r5f"),
+        .num_cluster = 1,
+        .num_core = 2,
+        .qemu_cluster_id = 1,
+        .mp_affinity = {
+            .base = 0x100,
+            .core_shift = ARM_AFF0_SHIFT,
+            .cluster_shift = ARM_AFF1_SHIFT,
+        },
+        .start_powered_off = SPO_ALL,
+        .dtb_expose = false,
+        .gic = {
+            .version = 2,
+            .dist = 0xf9000000,
+            .cpu_iface = 0xf9001000,
+            .num_irq = 192,
+        },
+    },
+
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
 
     .canfd[0] = { 0xff060000, 20 },
@@ -804,39 +828,10 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
         qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
                          compatible, sizeof(compatible));
     }
 }
 
-static void versal_create_rpu_cpus(Versal *s)
-{
-    int i;
-
-    object_initialize_child(OBJECT(s), "rpu-cluster", &s->lpd.rpu.cluster,
-                            TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->lpd.rpu.cluster), "cluster-id", 1);
-
-    for (i = 0; i < ARRAY_SIZE(s->lpd.rpu.cpu); i++) {
-        Object *obj;
-
-        object_initialize_child(OBJECT(&s->lpd.rpu.cluster),
-                                "rpu-cpu[*]", &s->lpd.rpu.cpu[i],
-                                XLNX_VERSAL_RCPU_TYPE);
-        obj = OBJECT(&s->lpd.rpu.cpu[i]);
-        object_property_set_bool(obj, "start-powered-off", true,
-                                 &error_abort);
-
-        object_property_set_int(obj, "mp-affinity", 0x100 | i, &error_abort);
-        object_property_set_int(obj, "core-count", ARRAY_SIZE(s->lpd.rpu.cpu),
-                                &error_abort);
-        object_property_set_link(obj, "memory", OBJECT(&s->lpd.rpu.mr),
-                                 &error_abort);
-        qdev_realize(DEVICE(obj), NULL, &error_fatal);
-    }
-
-    qdev_realize(DEVICE(&s->lpd.rpu.cluster), NULL, &error_fatal);
-}
-
 static void versal_create_uart(Versal *s,
                                const VersalSimplePeriphMap *map,
                                int chardev_idx)
 {
     DeviceState *dev;
@@ -1632,11 +1627,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
 
     versal_create_cpu_cluster(s, &map->apu);
-    versal_create_rpu_cpus(s);
+    versal_create_cpu_cluster(s, &map->rpu);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
 
@@ -1682,12 +1677,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
                            MM_OCM_SIZE, &error_fatal);
 
     memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
-    memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
-                                        &s->lpd.rpu.mr_ps_alias, 0);
 }
 
 DeviceState *versal_get_boot_cpu(Versal *s)
 {
     return DEVICE(versal_get_child_idx(s, "apu-cluster/apu", 0));
@@ -1794,14 +1787,11 @@ int versal_get_num_sdhci(VersalVersion version)
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
     size_t i, num_can;
 
-    memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
-    memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
-                             "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
     s->intc = g_array_new(false, false, sizeof(DeviceState *));
 
     num_can = versal_get_map(s)->num_canfd;
     s->cfg.canbus = g_new0(CanBusState *, num_can);
 
-- 
2.50.1


