Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D355FCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXI-0000he-4Z; Fri, 22 Aug 2025 11:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWN-0007yJ-Kl; Fri, 22 Aug 2025 11:17:42 -0400
Received: from mail-sn1nam02on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2406::619]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTW8-0007Cc-QF; Fri, 22 Aug 2025 11:17:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6hYC1wZicalsVXh7mM9DTY26djsye1MjkHBYKmyWNpMovBOK4lcOQXw7Q6Xh9W2M1XWWwHHZY2Gzbomx2Ei+GAqBwNnGTc+PM21uGkxnNTecFkzxIc6z7O4S3WTlZW/rICaj/y63HAbPgI4XqBsxFZP5fu3gMcbug+CC1JMli4W555JJPrXTmiYEXRWN3WUYpRfCGBETNUdvdPQUBLseRdf3mlAlgDSPDui1nVdNxnwZ+Ew/94AL5G+sfY/pyVlg7PBT5JFcG6KMAvUW+uDVXS9zV8dgMJzJGhRGMCvOQrTQxfol4VNQMkOXxkYlYfaezFYLBUJDFoGyPAhd3te2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IQLt2wCCFjyrfKFnInf8pvwrIeaRfFvTLNV7leq058=;
 b=GaycGWG5s8iwSCkJcBLaw3e3MUdyMCE4XPexw+8FlylGNqauP31u9djspbHAP/Jb+R/YQxqtbTvFS5+QuiCUO0oEbwzKDRGL+5Zpl/hvocApcERjG7Z74JUWgzpU+qhD5BIjrLOZP5LkZXxoueHvXpg8DFCF+nJ+17TzjRLvFzhUtEtRqmfc77d9U0KF1J9c44hhaaHtjvEQsNhdOZAdar3Bmkkn3Muin484DsHvYxrJnUuIXyVZ9eVnAvdwEJ7redxxvskiMARL4P5VM/xonl5S8ETcWPm8+6pmwdYpvK4fteswk8nSU9Ysyetxg4XuIaYMoPmPskKPr4RGCp+lVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IQLt2wCCFjyrfKFnInf8pvwrIeaRfFvTLNV7leq058=;
 b=F64i9EoFw7k8R2w4b8BoaAKpMPK5JEeOvGs4UsXmP1cAyU1F/VXe/eSoOAaRhI0YFQEReqjzqXNp1NCjJHTciMoQjGhmy0Ddkk4j8KRnRAQNZEYXUMey2NIAGd3e/SRekSO3W+3wVF/VpITWrgWrNvF4gtLq9hrfft8OnwqiBb4=
Received: from DSZP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::9) by
 CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Fri, 22 Aug 2025 15:17:17 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::63) by DSZP220CA0008.outlook.office365.com
 (2603:10b6:5:280::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:16 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:15 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 26/47] hw/arm/xlnx-versal: rpu: refactor creation
Date: Fri, 22 Aug 2025 17:15:51 +0200
Message-ID: <20250822151614.187856-27-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d95a3eb-ea71-431e-a5aa-08dde18efb63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XAVexVLnSxQQMzcOghll5aBcUu9bJ+Kda/C2G4kkMaSs4mac36OjjaG+YTNM?=
 =?us-ascii?Q?NpJQ1d/EvIu2w11SqciQR8hfBPANbr6j+Ml3eSnEPZxZZK23baMgMs2bdyWT?=
 =?us-ascii?Q?8BMOey02fpGeGa20qiCGVpSW1T2oQGOhRoe+SQTjUv4JUcHHZvKE3JkAEClx?=
 =?us-ascii?Q?MxXhLhlII0bVmlaFrt8YVNcW8U/8+2pXGsPSV1HrYSH35pahzu1qyaWmgZi0?=
 =?us-ascii?Q?LL/s6eIGywHQERTI3Zq0g+8iTx1lmGKpcqdjd58xfxoaRPw6GZ+5V5ScPL0Z?=
 =?us-ascii?Q?tH2ezrclKCM47rVl/xx66uQW/9toahkRnYucbEVqktRKgfHcAKSjIbrX2T4G?=
 =?us-ascii?Q?zYZbDREK7jHWqbbZdu20C23kV+tgmaojw4l0sXHaEK+AEG84+aoLokcI7NS+?=
 =?us-ascii?Q?5JQcR9be0F+UNbBBagQ/Jyrd3ypauMdW4TjV5rXQvGqrwFl2TjelGY7QIkL+?=
 =?us-ascii?Q?hrOEv1pvCvJ0xEAUlyBA1vOzl1nvkBtbKGUeSzsAk7AncaivxH1e5jLk59KA?=
 =?us-ascii?Q?ypSHfPJr9k8KtmC0C9uFtuaKPiuDzv9euZCQH73+BafOmBHfiKX0aVrFTwgF?=
 =?us-ascii?Q?rn9lOn/ZoHnMhfZ+LTelpZcImoR7M5d8QqO5EtjJg8mA3gafCA24pt7uGZY2?=
 =?us-ascii?Q?UtGRcgUVZfi4FAbfkvVp+xBGReRP8LhpeszZA/SNLZgHZ6W/eF2qSEPfljD/?=
 =?us-ascii?Q?BlDCP/czaS8+9KPsxbzHLg8A3gjCMopO9MyJnqd3ko3tGDeZuUZ62NQvqGIr?=
 =?us-ascii?Q?RLpsCZn5rrPrIDc/KSoQrs1+NyDSi4fD4tL/sYjaCC22eMCmVpXxT4GxpUC1?=
 =?us-ascii?Q?YGzZFTzPCkP5tq2kow44UiHxJ9ScDeAWgWCo4Edej9MueM3BskMxOGWhef+N?=
 =?us-ascii?Q?OTDobbxRyepiTNKKLNAezEJD7sssJ5Hlh1r7vanoWuTT4CjZwD2EVFZzS4if?=
 =?us-ascii?Q?R6kAmfd17JHhBtzx12DNg8uQynpEpLjiSxpgDDHO3Bz3yrj+qwxxhuTR9x3W?=
 =?us-ascii?Q?6coGA9kJg/a3JmaieGxCha7RmUby2xO6qd0J3EsM4Q9d5bIIlLOZoidSiM+4?=
 =?us-ascii?Q?w0J0oY20T+LjgmqOX30rKlxx7av0DAl/3T3citc7h8Bo4LAQnkQwz9LFCSZ+?=
 =?us-ascii?Q?kkH6NQE/GKp+RKwVPzjK7OzKJ4gVUIWwnP1N8VICtRlk3y4WpZ03+aPwwKhr?=
 =?us-ascii?Q?romQju8JuE27LUDoxAGZE8yaIyMzpX90V4NOHcPmkEW1R47oHFEfBEV5JJeH?=
 =?us-ascii?Q?vaL92eMt9JJOJOE3GPibUGtL9LJOYTMDr0i9h2tI8+ZkTvFIdbDcpbumlUYp?=
 =?us-ascii?Q?Uufy8tGAwK1EBz63KqggurR/uwObb7W4ZQ3Yalrjv7UUvs4jRPQUk7SN8OBj?=
 =?us-ascii?Q?syupIiPUtiIkjQNYB5TnjcnCniIL2OammUPEtpHY7wY1mneSTMdIBEaiX2oK?=
 =?us-ascii?Q?NbKt+0JYWlISUqmmlmkZRXvbo4A0gZIgPxiw5KIhr1R++uLhgiOpdy4VKz7M?=
 =?us-ascii?Q?EK+LbWvaHJJ8xhbCEagGT5h5nx5LkRUtMI4I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:17.4890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d95a3eb-ea71-431e-a5aa-08dde18efb63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107
Received-SPF: permerror client-ip=2a01:111:f403:2406::619;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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
index 96e687abcf8..2f0b4c845a6 100644
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
@@ -1638,11 +1633,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
 
     versal_create_cpu_cluster(s, &map->apu);
-    versal_create_rpu_cpus(s);
+    versal_create_cpu_cluster(s, &map->rpu);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
 
@@ -1694,12 +1689,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
@@ -1806,14 +1799,11 @@ int versal_get_num_sdhci(VersalVersion version)
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


