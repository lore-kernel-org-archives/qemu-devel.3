Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF298C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubytL-00070N-LN; Wed, 16 Jul 2025 05:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrr-0001bx-IE; Wed, 16 Jul 2025 05:56:06 -0400
Received: from mail-dm6nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62d]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrn-0006fd-UF; Wed, 16 Jul 2025 05:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecJBuAEbvsGi7SEktYBs1bXGyEvMzZWknq6zp7WYtNfkUEo2l8RJwKbYT81upJfFwH6U23+V3ckZAyXgBnOoY6lVXubRWEMDqZ0lbyZTaZjIE0o5wk8zaPaKz7n4vFu7zYaADEYUIT4UYXZRk/1umvw+Du5CXhbLm1zzOt7MWrE4fcvE+HfS2f0VtLu0Xl5bK+Xx9s2mN7u+hktKDYd9YdOxL6X+P93mFScAHR66NA3bmV+zJ7HWEgxrnPJKQ8bvYF7LQX6CiGRt6E5/QmOjDDVPnI1putrjiR1qouWFuRgzx8O+budN2n/RysLlP0agpPcwp/xLhF6WFd4BrHuynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPNMAC11ud0HBQlAvwKbsCZ3d2P3OYQLHDKguYThcF4=;
 b=iwKcv0NyZt2Uw/xhF3GJV8ePGWYwLdRLlX50MZiS0jqMpLPWUBf3MKIcmUucDhbiioLFie2AiJ64KAGwzXcEit5gpqOuwf0jz4ozHNN3BBQysaUWrJWuw8YEiWsbqXG0yuCbecpY92WqO/6SJ4P75nLfA2eevbhQuPOK6sKe6ZBOMZyiTSntWCQfFZbCT7Rxy8sxnfxbNBboe1F30/GBtuRWxZLDEhx9nYgCW3mHy4/mS095YiyzX7rNUfrmK62UFa0MxgDPXSVrQgfgelJ9EpXn3YgOC3TS+XM2FxSzlwsn8Y5gQMZmegyoq5zRISs/UFqd7B6NQxS1Qu5GRgjvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPNMAC11ud0HBQlAvwKbsCZ3d2P3OYQLHDKguYThcF4=;
 b=E22A3xQ/7iL9oNe5QPy1SpCnCWHq7RelwBPO29IL26OYgNNABbKCrsBcML9y+/JbGb+wHJkxEzifhPE0tuZ1PM/4O+4qRLUqipQOROUiDAO2aHi0RaH63wPigf1qRj3LsoZKLwrBVQSEYSCdSoJxJKXJ6HgPhdFcXwx+kAAIdpU=
Received: from CH0PR03CA0409.namprd03.prod.outlook.com (2603:10b6:610:11b::17)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 09:55:53 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::95) by CH0PR03CA0409.outlook.office365.com
 (2603:10b6:610:11b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 09:55:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:52 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:51 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 27/48] hw/arm/xlnx-versal: rpu: refactor creation
Date: Wed, 16 Jul 2025 11:54:09 +0200
Message-ID: <20250716095432.81923-28-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: f725e1cf-ce8d-48bf-b246-08ddc44ef3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|30052699003|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jlSsrqrMlfSUWI8aqH9fme96LiUoyrdYUq1mySbuohvYrn1hWJAqNHCjrc7D?=
 =?us-ascii?Q?xZo/wo6N+VdJ3ty6ng6xy/YPCrrfCKYP1t27Ltu+VsQOSjYAxiiokytrIIS5?=
 =?us-ascii?Q?N1+jx5LmxRRrXjy9fMd4xOOpXfnoP6vZJBTbZLAiFCygz6XAUIAF0ctHhnYE?=
 =?us-ascii?Q?rBmuyfjYrm8S5HsCzMU501l3ox9UrwxmfSaVU+lxrkzgxvhgDd/kXdXturcp?=
 =?us-ascii?Q?FR49Y0pedzZ5Y4Sot6B2z3oywCAeQbi+CuiXh6Y3O7THs0lfHodnS7QFJT/e?=
 =?us-ascii?Q?MviGah0jKIMGnThuj3sYvCFtgHT7UJRDXqELVNYE8ZTSZ4vf5fuBwFJ1nByV?=
 =?us-ascii?Q?635G/0+Pbu2EVM7cHEm/bKvSlI7X0Xnb5ZElJzusZTyoTNhXnm9gJduJXrs7?=
 =?us-ascii?Q?8KwszGLT5zm1PqNmpeHDjgXBunAGGwOTYqnhc86uNIggDK3gdt7nx7U/c2ux?=
 =?us-ascii?Q?WOeJhHsr7MfupLkKeqRDqXsZRQP/F2CPxPsuTZ6VDxfvlE14Q+D5a32kEagX?=
 =?us-ascii?Q?39Aj5JWmKJef+032yTmVYzt0exIB7gx29Nv/Z0TQFf+qb5Y/H+JiqRUcsxml?=
 =?us-ascii?Q?YlpJzwfMzMZ6MFNT+DRxngHqsZyPkujSm4DZkScopjeZ3Kagvm0jG3j9erBK?=
 =?us-ascii?Q?eFsZqJSiNm5Kzl3sL35OqRx92Xm0+hLmDG+Sy5nnjeVQwlM0937eQAWF79f0?=
 =?us-ascii?Q?xikUCoPG8jtgylzo3qnJwt1CWiRE5LDbZYaYwWE5aQAQjLl3ixaYqPgy7dVF?=
 =?us-ascii?Q?U2m+uuVKgWhZ1yS8JDTS41CoXV9V1vCmx5UfTJl29cbOqyUPAF6py2Q995lZ?=
 =?us-ascii?Q?5kylb/zz/BZJ9sqTCt0W9G/c6muRP5ql0ptmHZGwYEsDGws9697oZq+45A55?=
 =?us-ascii?Q?bx7RihFtkZwSL6NzMwgULPVMIqm1sakqvhgpOSIIvULcnt+trL/PC1t/DbA7?=
 =?us-ascii?Q?cvo86pg7/HD/Oje4KBSxwpYpFzbQ7MAGDkz+sYShN31CYo9/te3AXqVsF8Ei?=
 =?us-ascii?Q?R/3Um9bdkEpeZ5yu9S44vRPk+y6l2uz/FNceLXkhrkB0S4s/3BsnnxpJMyZH?=
 =?us-ascii?Q?G7RKYaNLFhYFYEypJxdy9ifgAGQchNQamkpG3TSUD3XWw6nPOuzYdS5lUnj/?=
 =?us-ascii?Q?egXzwC+DJOEq5WRwYSvbUVHRx//oOSBBkfY+v4ydENkMSNP4N+r+70tpfW0W?=
 =?us-ascii?Q?Xcube5c9EvO5/IG+Wxlxiv1nne2DuRg3hT8cm7y1mMyLTqtNJ38ivWPvq85v?=
 =?us-ascii?Q?wilOFJ9ESoH2/q7mODGvxPWzX6xRRIsNl0q9b83kTAuLFySIxyFDaauuycXY?=
 =?us-ascii?Q?0U+d9YlWL+WmiDMoS1A9xknzI0+lWOVgrGd78KbCSXUlISUXG4xpkMC2vPC+?=
 =?us-ascii?Q?pTWNWwdKGFNiIggpTTVmrelkLG5xDpscA0uZk9xT5QaJo6hRhyzUhChwsiua?=
 =?us-ascii?Q?lDYnZY85FZJBTsGDekKjhgy+dbqj0bppL/B0v1+DRYqCuJy211Oe5fZfsZek?=
 =?us-ascii?Q?R+dtQk1I02SM6mzsCNZ0QiXCm5IpgVFjM2l9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(30052699003)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:53.4751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f725e1cf-ce8d-48bf-b246-08ddc44ef3ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
Received-SPF: permerror client-ip=2a01:111:f403:2417::62d;
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

Refactor the RPU cluster creation using the VersalMap structure. This
effectively instantiate the RPU GICv2 which was not instantiated before.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/arm/xlnx-versal.h | 11 -------
 hw/arm/xlnx-versal-virt.c    |  1 +
 hw/arm/xlnx-versal.c         | 60 +++++++++++++++---------------------
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9b11ffb845d..62b8d234ecb 100644
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
index 55159536ceb..cad345b98e0 100644
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
index 771f6108558..3905549b32e 100644
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
 
@@ -107,10 +109,11 @@ typedef struct VersalCpuClusterMap {
     enum StartPoweredOffMode start_powered_off;
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
     VersalCpuClusterMap apu;
+    VersalCpuClusterMap rpu;
 
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
 
     VersalSimplePeriphMap canfd[4];
@@ -227,10 +230,31 @@ static const VersalMap VERSAL_MAP = {
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
+            .core_mask = 0xff,
+            .core_shift = 0,
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
@@ -809,39 +833,10 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
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
@@ -1637,11 +1632,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
 
     versal_create_cpu_cluster(s, &map->apu);
-    versal_create_rpu_cpus(s);
+    versal_create_cpu_cluster(s, &map->rpu);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
 
@@ -1687,12 +1682,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
                            MM_OCM_SIZE, &error_fatal);
 
     memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
-    memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
-                                        &s->lpd.rpu.mr_ps_alias, 0);
 }
 
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
 {
     DeviceState *sdhci, *card;
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
2.50.0


