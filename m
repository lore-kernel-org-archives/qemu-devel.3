Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CEECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22b7-0007Ri-Sl; Fri, 26 Sep 2025 03:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aI-0006as-Rl; Fri, 26 Sep 2025 03:09:38 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a5-0006es-BI; Fri, 26 Sep 2025 03:09:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2snoqrNK5ErskbuHnZEchvnvKvoDAbj3OHWdrdkwbFjhqSiz4AAjIQOzZBADjOv5FiXP3Zv4PdKF/OuAhs8eiTt29oXDuX0FAaAbTXGLkI5wltbCp6al+4RZIWvNdvr9/tLB9DNHy7NFQ7SbjkBXeo9ppMGLbIThcuHQSF8fUNlpVfUKkh3o9HUghHakOITXUqF87Y0zOKjaWvFFmu5sOy+TrzA8uGP1UbH0ThnbI5L8whtNVf2Cgvj2uoouBvwbuuY8uUhGLgBCCPrZyU0F3yssGI0/r2EqcdNDd2KMxS0uvcjbefV4YJ9mgL+6sykQSrl5tHI5XWV/16YrIjuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLcjApvT/voasPEUpYT2A+kNZtHbz3NCbHhsD42HX6k=;
 b=vQkGGiWNhKDeaqNRcH+HTXjeqduIyILRMAEmgtldCG+glJeCWs3qtb8qZU/yEyZjMBuT4gC6giWBnPeWO7GdEv63vy5SPwn7p8Bv7H4ri0GPsqbOZ/Md3deMyU65/+0IHysO4QB4PnjZ803SLehHy3c4NG/778VNfmSaaZcJRY1xUZkuluNVOZxVsTbTWBpc4XPt/jfsELi0UHqWqPM/AcNvFwftIs6iQNNtshRm3WaJcMTLW8hPtzp1EWB/m42BecHkW57ZLrJgGqHAJ3ptG3fTBg91ikNcY74o0xlGvERwhGq8zpsS1g6f2HeERkmElTMBq2KYXJ8jmjhQHTm5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLcjApvT/voasPEUpYT2A+kNZtHbz3NCbHhsD42HX6k=;
 b=KnJrcHN/b751oGlL4oJoWTXfSnQUolmfYDfRyM8O1MQOCJUiPsTfOWTrPjSLj+D1xdVOPaz5uzgW749c4le8jmJatFWckSS/gRDboaN4NBGPQjGP3ROWBzpqepC+e9I7ZQSO4W3GuC5i6yTmbR1OcNgzJRvDvXTGOOqOxfxlwKQ=
Received: from PH8PR21CA0019.namprd21.prod.outlook.com (2603:10b6:510:2ce::9)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:09:16 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::ec) by PH8PR21CA0019.outlook.office365.com
 (2603:10b6:510:2ce::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Fri,
 26 Sep 2025 07:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:59 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:59 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:58 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 26/47] hw/arm/xlnx-versal: rpu: refactor creation
Date: Fri, 26 Sep 2025 09:07:44 +0200
Message-ID: <20250926070806.292065-27-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: f2909f30-8998-482a-a19d-08ddfccb9aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bv3j6dG4ZwxBSBBF9uW9sFW2kjzMZvM0LJokUypMaFIFEImvUOFdHjTe3cfB?=
 =?us-ascii?Q?HZj1ENOqi3QJGxxbMNP8ZuDZ5goIHbmYTOhtWcFiwgN12vzkEV1P49OKvFpf?=
 =?us-ascii?Q?iwVo+dOJBO7981kNksUlm8p/UwZn384MvYMSbTeV0jv+LtQAhTgdSbkhbnTx?=
 =?us-ascii?Q?PGaSP/w1oaEunN63WbY+clvvUf/B1e/iF7RzFC6C4NPNEHBJ7o6w1N5OAeX6?=
 =?us-ascii?Q?rAq18+L2+6MMJ8Co81c041LgFnj6jyZbYivdzxnb2hucB0K5UVYPz9Ba1Jqt?=
 =?us-ascii?Q?dNlP5dbApLlwjqsNfiFPEVGk7vUr/WNpCz4ILALt41ystZHtAv5KIAKIQ19T?=
 =?us-ascii?Q?rZAsg6SRebhFN+Y/Lu/mc4/jh7x2B+6RGlvH0CayFFq8gNy8qzT7+Zt8Eold?=
 =?us-ascii?Q?HIeTDC8xdx+LmB+NZaLIfyGBgxrB/1ZLPNjwi4J4UATWWl57vnmQpVoS5lRM?=
 =?us-ascii?Q?dFVvrNjveWDW5zZ0G5owTTCosVgDg3qmCc3vnA0FAnDj2lEr7D8HRVBdlD20?=
 =?us-ascii?Q?BBDxov6CU4vIshQqSZyEzitEJ2sEY8OwlHA119vNDnH5T2m7tjDOSYVD/mWA?=
 =?us-ascii?Q?cr15qHvZpsEs1Z0XOTSwC/rqbKBc3gsT2I+pWGychqN3zIwmwb1PnvJznF5h?=
 =?us-ascii?Q?zli4q/9KPNVk/Pf6+eba21F85GiShof1XgqWmb5wLPDceZ9kxoO2qA3Ei5BU?=
 =?us-ascii?Q?UvNsBep1vDZ0GuVXZu2LSNWjUCC5Ys81M5QoK1biVmxTAUvqhjnYYOdl++lD?=
 =?us-ascii?Q?FogwZGNrKZyVK6TgBDYUShp1gqTmEt/hL/+kFK+Asw8WROHxBXlgXjAxg017?=
 =?us-ascii?Q?iHxQilyIuPM+PAqdp93BF88bED2e6ARYhn5fk6nx1gKZrV/8dIxCazhmydrU?=
 =?us-ascii?Q?8WMJy80IUkYGArD8Ixkr+YVmiAEDMzAqZfWJo3MhHIQNI9n/9qf9L/XcATn0?=
 =?us-ascii?Q?2TwuI+kGNmkSrfFVhUHSoXfiBGsnQAtwODAlr2RFr/kJH9JSz8IbmayQDXTH?=
 =?us-ascii?Q?Z792p6P14/IVPx6U1XcIFamM0s3l1kZUdNluuNxDMZIaJ2h4k90veUhQxZZJ?=
 =?us-ascii?Q?vKMUyS3RnGNteaUzPFtf1B3by5xzUZBGec1C2YoYdbXW6XEEgjB9CFzHWXja?=
 =?us-ascii?Q?n21zWMez5s0nXnN2h6z9RJ5qKj+TDKDBnhQcj0d/PiGC8UGmc0IKfET1V16J?=
 =?us-ascii?Q?2elCCZHw/QIxzW6Q2c2gRmIE7W33MqVcQhL8NQ2at3bATF8n5czE7KuUdtSv?=
 =?us-ascii?Q?kUmv7u9rOuCh0f49ZcM1hpUkYLLSQzWhuNysG/YiWHRjrTrrhrQThLymQwkB?=
 =?us-ascii?Q?iLE+UlHkqHHmRw5307Dtm3KLLHx5GE0ucwdnXtnWR9u85RP/7JPs4j5miWXs?=
 =?us-ascii?Q?L7VLJ1Fe354nyvIf010/hNZkfW0IS2F7bMlHRf1uQFTSOskod/yV1LWfGld5?=
 =?us-ascii?Q?HRUOfhRmdM9oUzhU4phBvizWxq5STc+fAda0V5/tYbRaJSPfcWs84sMqAOO9?=
 =?us-ascii?Q?NpF2BY23ESnJgSIYltsdpPUwvdxgZQwEl4PeUhia1He4nJiMMPRNzX3eKPLu?=
 =?us-ascii?Q?LBFqX88YWSWEvjLrToo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:15.8853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2909f30-8998-482a-a19d-08ddfccb9aa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Refactor the RPU cluster creation using the VersalMap structure. This
effectively instantiate the RPU GICv2 which was not instantiated before.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 27594f78c8f..5958e712519 100644
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
index 45ea47a8b97..e89c66313c1 100644
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
@@ -1634,11 +1629,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
 
     versal_create_cpu_cluster(s, &map->apu);
-    versal_create_rpu_cpus(s);
+    versal_create_cpu_cluster(s, &map->rpu);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
 
@@ -1690,12 +1685,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
@@ -1802,14 +1795,11 @@ int versal_get_num_sdhci(VersalVersion version)
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
2.51.0


