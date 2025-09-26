Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B642CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22aY-0006pz-PE; Fri, 26 Sep 2025 03:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aD-0006V1-U2; Fri, 26 Sep 2025 03:09:33 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zz-0006dB-4M; Fri, 26 Sep 2025 03:09:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTdPKygbAjgHBUtIMh6U4P8ReIrenTDJ1dg7XTRSEPQl1sVDxfSM0plNQziZoV4EbcxWQgKlc/n40n0g70eCP9NsyUE2/FfVzJsLJ8OHJKG5B7f2+Of4wdYMdgjEH+WajirRHlV7y7KHv5LKa8fb8xFiMG+GCZBnvXH/wS7ZQQD7JLO+L21mZvdvJsw4vHa8AGqGG1Lj5eozn1Z0NlZ7IPz6OcjPvMsPLCMOVQMXQBhgyjzk7TfT+N5bMMK7oD7wdVTn8Iq4ylD+53i085AXz2VuBKynlt/6Jx6KZCuKXP7+qFKxnL/1lckqvO8ln7j8HP7YOou7XhtfQMojgLR0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vvRAgIhdQFcbkRROWCBmGOGp37O15elrA0ixVp6CFA=;
 b=H7GpalPqdXUFIcGJsQsPAeKVABilfPJs3yvI0E23U4K0Q3VLHQ4ang9OPwA8BNvbirMbHcuLoG5gZKtU9htfr3AuAYsSf5fouyjxppDLxN8kt98CIjGzxIGN5K/Li72bdht9AUsuh78Dd5EgvqzYOPeO/FAs1nQ1hRlz0885NMMKwfClpUV/kEa0e9euxe70XdLUTvlGoSOxkAxRN8LiRqklSuiEPj4DfkHIYFwaj8BHTBMI+VISWly08hWYIyBZaO0L9xvL/oeIWjtgr7KJsiSBN5e7Q+r3v0HADDaw9n3tS+xRkJjwTXTYKMem8pappCkpGVBSZ4hvrYn3a/gOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vvRAgIhdQFcbkRROWCBmGOGp37O15elrA0ixVp6CFA=;
 b=dVMh68c7JLn9Y0dFbq+uXWi1ythC/jGH5LXN1oyOW1haZ8FuT4gy9906EFTRG3EJuaNrcdl+JTyP1iWfGmNRxlMPksw8K09n6WBiMGfWgyq2nk1T1Np8+rkqN/E0vI1GNeOSNXiUI+vWm/hzAj7r2+rfJ2SRnD/KpnqNWXOGuZc=
Received: from DM5PR07CA0085.namprd07.prod.outlook.com (2603:10b6:4:ae::14) by
 BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:09:09 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::ba) by DM5PR07CA0085.outlook.office365.com
 (2603:10b6:4:ae::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:58 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:57 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:56 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 25/47] hw/arm/xlnx-versal: add support for GICv2
Date: Fri, 26 Sep 2025 09:07:43 +0200
Message-ID: <20250926070806.292065-26-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 95770a04-56df-48b7-e539-08ddfccb965a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h+XHMVrqm5frBsL7DwkbGGtsENE0lBMUGoRiXbH5ZdGdBUxtr9teHMJcjrqq?=
 =?us-ascii?Q?8oo3GhWOk00ju/wjzb6NKfODoML38afIi5xUXFmllFOGkiIJl5DG97E4abrq?=
 =?us-ascii?Q?arX0o0B8NxCqivPCHDFlWE9d6SQdwwaN6moAF89f8Q7aJC7iJnWFCH8htyLb?=
 =?us-ascii?Q?70TlTqJVVlFpTpuDyqfjSProQBbIK1z3dRmwvlsltcKk3eY8Ntfb4ULCAQQJ?=
 =?us-ascii?Q?rFE8YaSzRlUx4RPW8lOsqTseXE5eznomUIdLUt1p2krmIkFeZ+7TvjWZXuHb?=
 =?us-ascii?Q?zgqMNxxAI3yWM4BFijAN2GQWDN0vwMv5tOOAzMPXo2qu7FRtYEf9kGEj9+Gt?=
 =?us-ascii?Q?vulofwGqo0c3OozlbkA7kGvThIstFx31EoAIwLB3u3k9Kxr6bNX/JaaniOY1?=
 =?us-ascii?Q?zgHvC+qmGp3p19q5W/ucoLQbpv3z67m0vBKWgSP4z27tWhcdrf4+N4lDxnlG?=
 =?us-ascii?Q?LIkd4/haNuWH2W9wvmiPRfNets+tJkCtdvdDYtlTa5wkj2FD8zK32klHTcnB?=
 =?us-ascii?Q?y7gWw81Nf6AuvVwKFSCJPn8EGvIU4zW6GIbfHmhTXawvjdgB1xKpd/Jve+HS?=
 =?us-ascii?Q?kYLxst8gU8NtFT/uarntMoZuQfdzfGZbLFcyjnT6NyqhnKAG1Foq8d38ls9u?=
 =?us-ascii?Q?ysejw8dAEjYwoHzsknNJfsuKlQhm35s8Oam60BWTq3O+yHLcuiN6jErtB+r1?=
 =?us-ascii?Q?fsJZNW5DuivlpGdhHVU+fd05gQLKyqtllN1nDSGLSoQBq6LkC/a6dS5jf4JN?=
 =?us-ascii?Q?S5l1bYVJFHUTw1tKOX9zYVFaU+Xuk6UUImlraBR5f2kTnCrAG4XI88rCd5NP?=
 =?us-ascii?Q?zW3CzCQCOTNeHQgdGS9DUlgR3aWwcBrclmAaHjWTNOZaejonPK4oFj+aox4X?=
 =?us-ascii?Q?SEcqGNnSYCtMDVifE7kntnRjrWhYcjoUnfwThFwMC4xa9/rTD+SxdWWotzUV?=
 =?us-ascii?Q?yYhmvucg7DyIFF786HoQdRLDkj0rTlL3cEv6d5uQXbkYnn5KLOrBf9S96eG3?=
 =?us-ascii?Q?A8pM2ItbiAskJskDsLsAeG59s25ZcD06mlhgx/bwMryySVVrhD/PZL/A5GEk?=
 =?us-ascii?Q?uk+Nlb0uHaoevmS1zBClXII2ZYjebL3G9Ywg7njCaQVR5yEDTqZBYPOOOzon?=
 =?us-ascii?Q?7O18CrGsCuTApdEMGY6yVMPfJ/AZg/jWkM4Y4E74e8+qjwMmkQjYFgiTxoYW?=
 =?us-ascii?Q?HCwz3AQExAay8224qoPJxtYhDLelOXpMN+cprO+wSQfnlGP5DUN2BHexkPn4?=
 =?us-ascii?Q?cNHQCGbPDP6HHH9R1v9JjUsK9kH8Fe0atByB2V65C07HUWxQIULle2dtPYdg?=
 =?us-ascii?Q?TLPqJnri52B8DN8G6Z+AexsZl70PXAJeWJlCivtEtwpLlZH/aW2PWu22HYfB?=
 =?us-ascii?Q?4DBGRlc89ABdxSrYlqqdiCwA5Y144UAuYl5A38Xtr4RjyMLumEjWfZYslsCE?=
 =?us-ascii?Q?ZnDz/4z2iM/HAFkHeCd+Er9gcQLLZLz3IxJq2926aMWcggEpK64pTjgRV0Ko?=
 =?us-ascii?Q?2kwt/l6OkCFVbDIBVST3wMgSF2lSMhsm/NT0VCD9x353QQ5f6LBgoaWD4IDr?=
 =?us-ascii?Q?+vm+VeQo2NwbLeSJ73s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:08.6766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95770a04-56df-48b7-e539-08ddfccb965a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=Luc.Michel@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 82 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 9256eceffc7..45ea47a8b97 100644
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
 
@@ -501,10 +503,14 @@ static void versal_create_gic_its(Versal *s,
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
@@ -540,49 +546,85 @@ static DeviceState *versal_create_gic(Versal *s,
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
2.51.0


