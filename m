Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C178BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22b2-0007Mn-OI; Fri, 26 Sep 2025 03:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aP-0006fD-9X; Fri, 26 Sep 2025 03:09:45 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a3-0006eL-RS; Fri, 26 Sep 2025 03:09:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooeBmyEv5P1JI8ufONZTVFD1pey+vjwWsr7WfLe2miiKVESj39LkS/wsTbK8aNaRvsJNAXOkv91n+ePLZZqj8mbwRZOtwGduB/dyqOFzHqMFANzk/X2eYWt9wPwlhvaG7xvvCAqPnPiYE4ZSp10tD4qN6uopj85QnYs82RS/oUHvDg4c0VE35OMrWgC/QiUxsrYML0aB3U+uvDQticYKK7SsmMrWePcFKKKslv2Yr3KKK0IfMy20Et6q5fJnQPUy9gyji4ZyixO1J9Z+gtd/v1D8JSa7iOgvLyQ2D1T9SRBa+0S0EinzCTvA0+F8g9jjLdPMWrFy0JeY4WIUfPWCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuNfOPbtmUU0NzATPSi1sheQ7yByB9Rhxf8jjs1CbYU=;
 b=alq8KHHzUEVSc42oklFxOTevv7B7oATr4lx7Gpbdr62rm4W3Rji04VxYQq8pWU+oc41tvriVoQbOgZDcCD5WksfUCgV5ORYBR6UUuEZdn6jHJ4Ks5367OxQfBcGRjA3gM4eJ/KUHvfu6I6tpjoV4DLifnEKmFkMacaad72M7rLbq+39ciSw007R4YCPbLdxW7fduPRpAGg426jXPG8TaLB/7oIB7aXi6KBTLzwmwwqwj0jjaP0bkmGhKqAtWGGClhqvpekEYk1jNQUjnU2A3EPuBh/HYCHen+lsNg0DO1AfSvyXQxT1r571LOG7qZZ0tby5oDcFYoMoKQwLey+djHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuNfOPbtmUU0NzATPSi1sheQ7yByB9Rhxf8jjs1CbYU=;
 b=wV3Yqtb96yrGu9/ou7ZBZ3XyEqAGFQqyW/nBlpXWs9blwDeoU06ZekCHyBfOnddZIhiNHl5LIcksg26886I53mAyoe5qevGpcGy77uVIkEHg0LJGW80A1Hj/OzLjMz8ALUADonXXVEI8ToOBAiHIMLhVGtVasXFcBflwNQVqLww=
Received: from SA0PR11CA0164.namprd11.prod.outlook.com (2603:10b6:806:1bb::19)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:09:12 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::61) by SA0PR11CA0164.outlook.office365.com
 (2603:10b6:806:1bb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Fri,
 26 Sep 2025 07:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:56 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:08:55 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:54 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 24/47] hw/arm/xlnx-versal: add support for multiple GICs
Date: Fri, 26 Sep 2025 09:07:42 +0200
Message-ID: <20250926070806.292065-25-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: e944ceba-6b00-4907-4ca5-08ddfccb9879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7FWX0e+L7yRictyW1VfrH3JTvfo6HrIFkQAUqZ6TRLEhlVObd5Cou90w9oxB?=
 =?us-ascii?Q?VDL6t0i/NU62SJr0vWVv8ga+xWyDHHIfVyt17qA/wmjqyhe/RRIj11aIgucC?=
 =?us-ascii?Q?dNmMNWKvkrQRiIEv47q/PLwnBxl2j7IemJjgGJH8GL6lZEia1sEzhq5lI8iO?=
 =?us-ascii?Q?uxWgmDuIhFCu5Gr30LNqpygAKisBf6rJ8OoC9fTltFrxo6cN5QG6LFY8mGUM?=
 =?us-ascii?Q?LuxL4MsabXfZRLqVgcfGAiwC2wQVNcyJu6wwGtddYkNst8SOYzSIO3h63h7h?=
 =?us-ascii?Q?P8ZedKw1U2mJgcVI3J1tv0cKdhI+YZJAK8V4BFqQ/of1wz4LIFYa0wSQ83bA?=
 =?us-ascii?Q?j5iM3gdW/VRJrlFP53WTXsaiJSyZbOfgkMRm2VZHsYBkIWxId4G84pyZdKV4?=
 =?us-ascii?Q?/BHSwmeXDO8qWNfhxZ/LEJc0y8se8QaILfuu8VoS83NhBtstzg5TNa2co2kc?=
 =?us-ascii?Q?A42f3R371vNU3N9CcbWqpL4cUc7pG2TfmoerNBv6jO/NnQd1j4VYA3i2aJP8?=
 =?us-ascii?Q?iS1ioHaTVd2aHulcTHTNkSlYjLinG+hMgWnRJcSCY+GQJSocY5P0zy9S3NUX?=
 =?us-ascii?Q?m/zFVJmC458jy1ct5SWKO2kbQTJk3EjpUuY5dc+OBK75Ivjsoa9WxkcVRuAX?=
 =?us-ascii?Q?+XjHWiKNr+ZeRCJHFvf+abpy/nB/6wEJ+22e/NmZjizpXLGiRRExQsdw44jh?=
 =?us-ascii?Q?gcwHcvC59Q/qQZZY9/fZKCkCSYBidpsg/1EorEqM5Tl0CB57zHDYGwGhf/Xl?=
 =?us-ascii?Q?8W4O3anryMqGkDjRgmrwEA1D6T+7i6Zsy8KSaik2tiiOVPG2CEpUfcaWnTYz?=
 =?us-ascii?Q?4fP7z8m0AfMHW9gvkbz1Rl8IaTFsa1CF4HWgjQVBdhNr078gx9pbwzsopdCJ?=
 =?us-ascii?Q?aDeiLRRp085NfFvl/jfWNz+2Y4CtkcCB3WHw0CdjzjAGa0vICFhq9ydmx1P/?=
 =?us-ascii?Q?wXxPIbq4c0sFLQJ137yO8/oVME+wVbAuDVpZMOaI9//XewYcSjN8Pzy/yPpy?=
 =?us-ascii?Q?isgEzoaJLTsT/lDmw0c//hG1sCtpgW0ewnO7v9Yd094++dBvHxwSsP71kxQQ?=
 =?us-ascii?Q?SBVm07Ui7sRqA95l4Lm9I6fa9xXAg6Jkp3VdadMd4yV8Ix2XSEkBiNkmuCo3?=
 =?us-ascii?Q?c+5e11vBasOevixYeggU+NBDLvFcEe8Rh9bMkNU+8DkVDPYuVSwBuLO/yERR?=
 =?us-ascii?Q?fMtp5GgbNuHyjku8pNr+A4Dtibl9g5P9SaiuPUyQhz0KXkFuirwua3gWQfHn?=
 =?us-ascii?Q?1fKkYAShq6OOwvaxOF9/C7EeWFQPxKHNga9Jx26eeJ2qTijvMBzY0VZaEqUI?=
 =?us-ascii?Q?/6BOlt476dT+aTLr8iCkvXgT4FiT5GtXb4RgpyFyxomVsejQc2+rD2RoZK91?=
 =?us-ascii?Q?89LpfkC4VxZ2Lis8K64nbK/i82fp56kFf5JQ/dx74tEFa6/nbP9rj/PPnhsF?=
 =?us-ascii?Q?fqpgo5Ef7nRZfsFqOWSnVm0Z0XvEuKykhT6g68ZrCLEZ0StyCNVXY3wBCLtI?=
 =?us-ascii?Q?C4zCEZ9PHWeqOHtCMl9JgKhkIMkrrhFI/aATJCPZGIn6fq1FgBp8/ct70d07?=
 =?us-ascii?Q?gcpK/4XWjn/Y4L09W5k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:12.2393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e944ceba-6b00-4907-4ca5-08ddfccb9879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Luc.Michel@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The Versal SoC contains two GICs: one GICv3 in the APU and one GICv2 in
the RPU (currently not instantiated). To prepare for the GICv2
instantiation, add support for multiple GICs when connecting interrupts.

When a GIC is created, the first-cpu-index property is set on it, and a
pointer to the GIC is stored in the intc array. When connecting an IRQ,
a TYPE_SPLIT_IRQ device is created with its num-lines property set to
the number of GICs in the SoC. The split device is used to fan out the
IRQ to all the GICs.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  1 +
 hw/arm/xlnx-versal.c         | 56 +++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9d9ccfb0014..984f9f2ccdd 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -40,10 +40,11 @@ OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 struct Versal {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
+    GArray *intc;
     MemoryRegion mr_ps;
 
     struct {
         /* 4 ranges to access DDR.  */
         MemoryRegion mr_ddr_ranges[4];
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e03411bc212..9256eceffc7 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -43,10 +43,11 @@
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/core/split-irq.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -315,10 +316,47 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
     g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
 
     return versal_get_child(s, n);
 }
 
+/*
+ * The SoC embeds multiple GICs. They all receives the same IRQ lines at the
+ * same index. This function creates a TYPE_SPLIT_IRQ device to fan out the
+ * given IRQ input to all the GICs.
+ *
+ * The TYPE_SPLIT_IRQ devices lie in the /soc/irq-splits QOM container
+ */
+static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
+{
+    DeviceState *split;
+    Object *container = versal_get_child(s, "irq-splits");
+    int idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
+    g_autofree char *name = g_strdup_printf("irq[%d]", idx);
+
+    split = DEVICE(object_resolve_path_at(container, name));
+
+    if (split == NULL) {
+        size_t i;
+
+        split = qdev_new(TYPE_SPLIT_IRQ);
+        qdev_prop_set_uint16(split, "num-lines", s->intc->len);
+        object_property_add_child(container, name, OBJECT(split));
+        qdev_realize_and_unref(split, NULL, &error_abort);
+
+        for (i = 0; i < s->intc->len; i++) {
+            DeviceState *gic;
+
+            gic = g_array_index(s->intc, DeviceState *, i);
+            qdev_connect_gpio_out(split, i, qdev_get_gpio_in(gic, idx));
+        }
+    } else {
+        g_assert(FIELD_EX32(irq_idx, VERSAL_IRQ, ORED));
+    }
+
+    return qdev_get_gpio_in(split, 0);
+}
+
 /*
  * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
  * used to return the corresponding or gate input IRQ. The or gate is created if
  * not already existant.
  *
@@ -351,16 +389,14 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
     qemu_irq irq;
     bool ored;
-    DeviceState *gic;
 
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    gic = DEVICE(versal_get_child_idx(s, "apu-gic", 0));
-    irq = qdev_get_gpio_in(gic, FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
+    irq = versal_get_gic_irq(s, irq_idx);
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
     }
 
@@ -499,10 +535,11 @@ static void versal_create_gic_its(Versal *s,
 }
 
 static DeviceState *versal_create_gic(Versal *s,
                                       const VersalCpuClusterMap *map,
                                       MemoryRegion *mr,
+                                      int first_cpu_idx,
                                       size_t num_cpu)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
     QList *redist_region_count;
@@ -523,10 +560,11 @@ static DeviceState *versal_create_gic(Versal *s,
     qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
     qdev_prop_set_bit(dev, "has-security-extensions", true);
     qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
     object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
+    qdev_prop_set_uint32(dev, "first-cpu-index", first_cpu_idx);
 
     sysbus_realize_and_unref(sbd, &error_fatal);
 
     memory_region_add_subregion(mr, map->gic.dist,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -549,10 +587,12 @@ static DeviceState *versal_create_gic(Versal *s,
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
     versal_create_gic_its(s, map, dev, mr, node);
 
+    g_array_append_val(s->intc, dev);
+
     return dev;
 }
 
 static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
                                DeviceState *gic, DeviceState *cpu, size_t idx,
@@ -606,13 +646,15 @@ static inline void versal_create_and_connect_gic(Versal *s,
                                                  MemoryRegion *mr,
                                                  DeviceState **cpus,
                                                  size_t num_cpu)
 {
     DeviceState *gic;
+    int first_cpu_idx;
     size_t i;
 
-    gic = versal_create_gic(s, map, mr, num_cpu);
+    first_cpu_idx = CPU(cpus[0])->cpu_index;
+    gic = versal_create_gic(s, map, mr, first_cpu_idx, num_cpu);
 
     for (i = 0; i < num_cpu; i++) {
         connect_gic_to_cpu(map, gic, cpus[i], i, num_cpu);
     }
 }
@@ -1537,10 +1579,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
     s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
     s->phandle.gic = qemu_fdt_alloc_phandle(s->cfg.fdt);
 
+    container = object_new(TYPE_CONTAINER);
+    object_property_add_child(OBJECT(s), "irq-splits", container);
+    object_unref(container);
+
     container = object_new(TYPE_CONTAINER);
     object_property_add_child(OBJECT(s), "irq-or-gates", container);
     object_unref(container);
 
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
@@ -1718,10 +1764,11 @@ static void versal_base_init(Object *obj)
 
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
+    s->intc = g_array_new(false, false, sizeof(DeviceState *));
 
     num_can = versal_get_map(s)->num_canfd;
     s->cfg.canbus = g_new0(CanBusState *, num_can);
 
     for (i = 0; i < num_can; i++) {
@@ -1735,10 +1782,11 @@ static void versal_base_init(Object *obj)
 
 static void versal_base_finalize(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
 
+    g_array_free(s->intc, true);
     g_free(s->cfg.canbus);
 }
 
 static const Property versal_properties[] = {
     DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
-- 
2.51.0


