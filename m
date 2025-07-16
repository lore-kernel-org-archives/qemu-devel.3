Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA449C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyt1-0005UW-Qf; Wed, 16 Jul 2025 05:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrr-0001bw-IM; Wed, 16 Jul 2025 05:56:06 -0400
Received: from mail-dm6nam10on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrn-0006fL-Vv; Wed, 16 Jul 2025 05:56:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIY/GyM4AAFQVSan1xRqt+cv1vWhOcn+W8tgFEaEHRw5qpwiW8V2e5KMksgRd5Kok5U0QbJ3X+1cvOPR53EpNS+hGcZla53fzOXdlg0ZlNUFl0TIRipewOD9vAVkVwh4sDmo8y3oktKGef4XzizmZqcca/csi7n240885O1FNybxfnVbS5c1QmeldSckMrMuwf3qHESyM9L/zm8tRq4pSEn1fSxPBQk5htK6ZckLsKVWjkD2JDxF763WlPA3jlcaP7G8TDAKipZx/fZ/SFlFxBod1+GZTJOoS/WRTLCczXplrKUlRdEPJYLX4P8jweP6wuRTdQWJg7ICBSdI7jUhKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM6IjVaqkqi6uJg6w+vsgX802T9W2dL1c0CVNRCj92Y=;
 b=N4f40dsyUXEmDJKHqFvw+jPhpCtFAgwlCPbSzTtvu968fzFXeYhzM1cvRmoeOtrO/FR7C44r9dEgAeY2LI3/AU9Eu8jhsz1UFbQW9hRm0Y5ZSuP/NoKOhtpMAyNYH1om2y92Kpz0bi/h6J5u8zWqpUYwlu5UsjM2VoF2tMk43Tv22ejYoAwjLNOxMnmyqYnGUgZZdXKzVSb71lvb+Au2CB1kPl3hf8J+jyNQJGAKC+/AKi3+AQMU3jnFtuC/KKB5SK0GNjJ+R0aR/bEZDd+d6mWvO9UnMuZvDDLywtXDANJUR/oMTuM8OE/UPLM3I8+5lx1ew6ndGs0mif9j3xJKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM6IjVaqkqi6uJg6w+vsgX802T9W2dL1c0CVNRCj92Y=;
 b=PWmePTKamBUOL++KtWXFukSvntZeDVVzLo2h1KGLa/LsDcg1pjgNTxiUD0BF+yJxkKBvkWc0gnMvL88OC4Xz5V3wDiTgHF3+VPEmJ6UbIfqPe8FKD8hpv9qlHWMncc12HFfR/xWeWU8TVPgP4S+00yrYW32bO9hn/px2L80QPu0=
Received: from DM5PR08CA0041.namprd08.prod.outlook.com (2603:10b6:4:60::30) by
 IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 09:55:52 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::be) by DM5PR08CA0041.outlook.office365.com
 (2603:10b6:4:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 09:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:50 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:49 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 26/48] hw/arm/xlnx-versal: add support for GICv2
Date: Wed, 16 Jul 2025 11:54:08 +0200
Message-ID: <20250716095432.81923-27-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: d692df3e-b991-4667-7bc7-08ddc44ef2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i2BjjSGRQwHKwVU1xUAHzQIaAzq6knBxgTwVwNA3s+tWas+LZEPcl9zjfIom?=
 =?us-ascii?Q?LmFLZ0ygqf5YWx7Pde2BUX7oVIGvvDehISYdvQ63XRl46/ILIhTC5wgFmPEt?=
 =?us-ascii?Q?+c6oTQMLxR9iySXg7cXbrrp5zxRaB2J1tFhMaM/xqRUBnh7rFAh+XCf8iyGk?=
 =?us-ascii?Q?ESfnsX8ThehGN/NmEJwh3bf1pTXvmafWu+Uy6lF8w/ShI2WoJTJbX/Zurhvs?=
 =?us-ascii?Q?DLyTShSs3GGk40Uitw1Zv6lBOrDkXRweCOw8O80isI0Bu8oK9+gcKe2FzY94?=
 =?us-ascii?Q?TMd7+bEqhgpmqVrpicaiP0cnISZ+wk8PULjIVY9UtBQbr8OC7u+yt9uXTwIt?=
 =?us-ascii?Q?u/OQMpCOo5FoFi5YtKoDi1JxV15SnFHMsrBfXpc02EXp8VgFxD+V4WcgnHFW?=
 =?us-ascii?Q?YgKXFTBHHAX63zY80jRjSy72iJQRpAUQmUbGvXhQOyahoRWKGKdDbMCrGKSD?=
 =?us-ascii?Q?18gqaeym5oL5tJ5diUkZXDsGadGkd054sAHLW2SoXfSQuIVAR7kpQSndWIGu?=
 =?us-ascii?Q?dmvXOjrWbgLFU2Felzncjc1+hMafDHTd5Le9GOoxr3An06F2+kZbNz+wd81R?=
 =?us-ascii?Q?HLK34yB36N/iVUttnW5zMM3g7BW21cn/AQqQDiZGXx++Ro+UcR/37Egqt4dX?=
 =?us-ascii?Q?nmcZYNTUIkwRdmyUAZXzopkr+HCSNEMAVxLt5iPQP7yx4rJh57iv222fVBRa?=
 =?us-ascii?Q?hGeX0L+OMQxm2L2mZowb9k/NpPXfgfs2AIlkDktvC/u7VROXgJA3+XWaZAyy?=
 =?us-ascii?Q?ajnYPu+m9xYkDg8taXW/S7esFhZph0WtXKuS+Qdq+1vHezf9hCUYO5DUTcpy?=
 =?us-ascii?Q?WyllX3o/t6/d5XeEBNv0YSeyYLsm46/CbJBZmSO5Ex/cyLMHnoRfSjwZTSwb?=
 =?us-ascii?Q?6JK6GA9MmFJZMMj1VQVbKdyiAS32et6PRS0CL6Ll5EP8+Rl03qxVgaCRWr/p?=
 =?us-ascii?Q?dsd4bffZoeOdsdA+jsfuPjEYyMb/r6iKYsSJ7nqVGIOcnGp76d3oY49bJPei?=
 =?us-ascii?Q?9FI5VF1a2wZSJslmKJmBbvAP8ue7NM878J3UHcOZU6Yfwj2pm38FalYyRN3U?=
 =?us-ascii?Q?ey/0yO3lLpdU4pBNNePrb59UHWBXw+AHB648ocIMKFsN1X/tNOdd+Ys6gV4O?=
 =?us-ascii?Q?wbLIellKszexiPjbTGueFPkepu572ETGrq1/9+owAq+yFI+zjDG90mtrTbx/?=
 =?us-ascii?Q?VdPKp6rD4xAIBAaPfV2/Pp5/56C0dV7c2UF5eNflmyVkQpLoDmnZnp5ZzHEN?=
 =?us-ascii?Q?XtevJnhSO+rcRLrjKE8y//jrbTxCgNy/XstENimSvXJqMdrFm4UWiikwH4IO?=
 =?us-ascii?Q?TUgD6dI8trMVBR7kwYOoT7NiPRBhVYXBYUpwvwZp3FYB6IGsqJxP2CmwWorp?=
 =?us-ascii?Q?hKVJk5QdCiG5gj5Q0vHio2/rh7KE9j+kro3eyn7AYC0U0QTZoZdPBJM6gBYh?=
 =?us-ascii?Q?GfAD7T4NlgX+Yz+BYdxyXHWFfR6lxXpUy+KO9SbrCrDbqhhcYcU7uGi2WJxd?=
 =?us-ascii?Q?Rijf+ltxP/2PtnPmk6cVshxWx9+eeGSu49bV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:51.6302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d692df3e-b991-4667-7bc7-08ddc44ef2d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
Received-SPF: permerror client-ip=2a01:111:f403:2413::61f;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Add support for GICv2 instantiation in the Versal SoC. This is in
preparation for the RPU refactoring.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/arm/xlnx-versal.c | 82 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 58cd874f81f..771f6108558 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -43,10 +43,11 @@
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/intc/arm_gic.h"
 #include "hw/core/split-irq.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
@@ -72,10 +73,11 @@ typedef struct VersalSimplePeriphMap {
 
 typedef struct VersalGicMap {
     int version;
     uint64_t dist;
     uint64_t redist;
+    uint64_t cpu_iface;
     uint64_t its;
     size_t num_irq;
     bool has_its;
 } VersalGicMap;
 
@@ -504,10 +506,14 @@ static void versal_create_gic_its(Versal *s,
     DeviceState *dev;
     SysBusDevice *sbd;
     g_autofree char *node_pat = NULL, *node = NULL;
     const char compatible[] = "arm,gic-v3-its";
 
+    if (map->gic.version != 3) {
+        return;
+    }
+
     if (!map->gic.has_its) {
         return;
     }
 
     dev = qdev_new(TYPE_ARM_GICV3_ITS);
@@ -543,49 +549,85 @@ static DeviceState *versal_create_gic(Versal *s,
                                       int first_cpu_idx,
                                       size_t num_cpu)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
-    QList *redist_region_count;
     g_autofree char *node = NULL;
     g_autofree char *name = NULL;
-    const char compatible[] = "arm,gic-v3";
+    const char gicv3_compat[] = "arm,gic-v3";
+    const char gicv2_compat[] = "arm,cortex-a15-gic";
+
+    switch (map->gic.version) {
+    case 2:
+        dev = qdev_new(gic_class_name());
+        break;
+
+    case 3:
+        dev = qdev_new(gicv3_class_name());
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 
-    dev = qdev_new(gicv3_class_name());
     name = g_strdup_printf("%s-gic[*]", map->name);
     object_property_add_child(OBJECT(s), name, OBJECT(dev));
     sbd = SYS_BUS_DEVICE(dev);
-    qdev_prop_set_uint32(dev, "revision", 3);
+    qdev_prop_set_uint32(dev, "revision", map->gic.version);
     qdev_prop_set_uint32(dev, "num-cpu", num_cpu);
     qdev_prop_set_uint32(dev, "num-irq", map->gic.num_irq + 32);
-
-    redist_region_count = qlist_new();
-    qlist_append_int(redist_region_count, num_cpu);
-    qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
-
     qdev_prop_set_bit(dev, "has-security-extensions", true);
-    qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
-    object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
     qdev_prop_set_uint32(dev, "first-cpu-index", first_cpu_idx);
 
+    if (map->gic.version == 3) {
+        QList *redist_region_count;
+
+        redist_region_count = qlist_new();
+        qlist_append_int(redist_region_count, num_cpu);
+        qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
+        qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
+        object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr),
+                                 &error_abort);
+
+    }
+
     sysbus_realize_and_unref(sbd, &error_fatal);
 
     memory_region_add_subregion(mr, map->gic.dist,
                                 sysbus_mmio_get_region(sbd, 0));
-    memory_region_add_subregion(mr, map->gic.redist,
-                                sysbus_mmio_get_region(sbd, 1));
+
+    if (map->gic.version == 3) {
+        memory_region_add_subregion(mr, map->gic.redist,
+                                    sysbus_mmio_get_region(sbd, 1));
+    } else {
+        memory_region_add_subregion(mr, map->gic.cpu_iface,
+                                    sysbus_mmio_get_region(sbd, 1));
+    }
 
     if (map->dtb_expose) {
-        node = versal_fdt_add_subnode(s, "/gic", map->gic.dist, compatible,
-                                      sizeof(compatible));
+        if (map->gic.version == 3) {
+            node = versal_fdt_add_subnode(s, "/gic", map->gic.dist,
+                                          gicv3_compat,
+                                          sizeof(gicv3_compat));
+            qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
+                                         2, map->gic.dist,
+                                         2, 0x10000,
+                                         2, map->gic.redist,
+                                         2, GICV3_REDIST_SIZE * num_cpu);
+        } else {
+            node = versal_fdt_add_subnode(s, "/gic", map->gic.dist,
+                                          gicv2_compat,
+                                          sizeof(gicv2_compat));
+            qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
+                                         2, map->gic.dist,
+                                         2, 0x1000,
+                                         2, map->gic.cpu_iface,
+                                         2, 0x1000);
+        }
+
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
-        qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
-                                     2, map->gic.dist,
-                                     2, 0x10000,
-                                     2, map->gic.redist,
-                                     2, GICV3_REDIST_SIZE * num_cpu);
         qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
                                GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
-- 
2.50.0


