Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993A0C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubysW-0002dh-CP; Wed, 16 Jul 2025 05:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrX-0001Pt-IZ; Wed, 16 Jul 2025 05:55:47 -0400
Received: from mail-dm6nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2413::601]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrS-0006aj-Cv; Wed, 16 Jul 2025 05:55:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnmBcFWIHArue4bW+WkZkpbut2O3X3NLXHKkgMj4d6mu3QAUxiFnHmel19P5a2RJ/gSwCB7bcr6jctaYiucxYAmLM99AwVfci/9L7Y91TLEf85zJaDGoCvDwsshfgQ5lUIHmgloelg8lw32mOS7wlkYY92BajNMwpr1vIDVrWQe3aUwYrOKz2ZleWUOxPWj8/DCDSBu6zxs44Hyapjz4DsiQ5v/UeJdKwJQznS8Jnoyz7YsHDiSHB6OS3Wp7muv5nswQssF463jv/Hmh/iDzLMZP84gS4AjHQIjHdoSMpzcmW35jN6wpx3KbkBzBrIzIIpOxkzR6g5qpX0tH9VdP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXsl3SjjX0N5tMU941Au+SvhyXL+SMpN8vzCBh/5ywc=;
 b=XzyT9h2T/ERTOweQ2JC5KPnRmk1R/KDj2rWb1VZlW/0XYj+HP388CUgZKskYL65AwuxfBqFZXnX6GW5KiUMZQ23yANVl4S/Pkl/zchLqnthQOVtpcKb+O3rY4p/sc9Jo4v7Xest8Cav2DPQBGJyvwplp4zzGBQmJ+WDKJGGfdXnoYYw+PkD1Pgs33A/0hPsRpJMnDwUDJbbtJZCP2fZl7zBH+2bsIousDsWO+maoX478vzmTlhheR0DPtwbOEpzqfDHr/NibSsI+fk8kTeUsd8UdIyr2btlNXpBCDhU4iCFMeZBNKFbaOYwd+bQvmkkENVPWA6rTg15DWcjddvxccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXsl3SjjX0N5tMU941Au+SvhyXL+SMpN8vzCBh/5ywc=;
 b=RoyJ/Or2gpXSAn+67ADPfUVptL1wZTwpDXThXJTYV1ytnT3UPjx9HUgC9ts3R8QaAiJsblObo+4c7khPl4+R62L9cXfYgXtLIEQ0C0rJ4KKLHBnTWRtkNc1wIm3T/F3vf/Wan9c5khnnpfcOENlspzFFcG1/kVgKE3CQOw0wbaI=
Received: from SJ0PR03CA0127.namprd03.prod.outlook.com (2603:10b6:a03:33c::12)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 09:55:34 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::86) by SJ0PR03CA0127.outlook.office365.com
 (2603:10b6:a03:33c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 09:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:23 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:22 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 13/48] hw/arm/xlnx-versal: VersalMap: add support for OR'ed
 IRQs
Date: Wed, 16 Jul 2025 11:53:55 +0200
Message-ID: <20250716095432.81923-14-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6bb4ff-0f57-442b-9885-08ddc44ee830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wdxNCFPTLLGUNzqwN6wpY6eYMCIv4Uto0DCD026KSjOF+RBFhK1yXf7fOSAZ?=
 =?us-ascii?Q?GyKDx74+JhGBCEZqo2JTc85Cyp838XWfENRtU3Igy94louErnW5Vyn+BMw8R?=
 =?us-ascii?Q?nPMWxRixYuliujtGHnsqL+/p1kh2KAlMvh5KCklSxMNDFmMLJj/5/GWNnVOn?=
 =?us-ascii?Q?mudHruYmKBEY31PsbU9g14loa44rjwelbFYX/j70ZA+OpHNQsk6AQe2C+Bez?=
 =?us-ascii?Q?k1cJ1NE2RNZ1ZastjzfiBRFBydvmoBHo0ba1qyRYvC2DEf8jAE7j/ncZEIf4?=
 =?us-ascii?Q?Qq8HhdBsdOsVc6nb2f3D54hPFowqgmul6M+UwyL6JqQgxePCNssd30bgx383?=
 =?us-ascii?Q?xFnmUqCIKLGeq6bFS9wt0r4DJMjCPqsHSIZXrIf3JsljSANHz6pFwB2je5he?=
 =?us-ascii?Q?zHaHSlccYs673k6QAB+Y2S4GZztZ55T9ltAHe03wLvmF5PSyHPQkIwV9+Jzy?=
 =?us-ascii?Q?0wOxJTSxvRLCY8u5Q8ikjOQigfPYrzHwbruzR+Y+P5XpYUl/tJUEXjDYJ0fX?=
 =?us-ascii?Q?Dx1O+EuPBe1FUUmGzgHCiH6RRK8y7ds3n7rGgG0zODoOki/YWh19j+4Muj9I?=
 =?us-ascii?Q?qc7GqHi3HjCCrYkHwnvtmRJAQYSERmzHt2SYlccGbEPRBEB7b/0VJYHA/KDR?=
 =?us-ascii?Q?9KSCJyc9RX9hJkGiDj1NTDD1hf9wxPgR6llBkpaAnCamG6eRJgllKXrrXXTU?=
 =?us-ascii?Q?y3MYrY5fgHkFotAk/KN9kPv6Z1fHzOciUSbJbEiQDv+uf7VIgHAHyaLsNKuD?=
 =?us-ascii?Q?tAZD0e8RBzT0JbCWfWbXrSMy+Df4QZpIp6g0DLFl94Z+ArxJtSAmkXZAWrKk?=
 =?us-ascii?Q?IidW2Di1KUghVxxYKNLUjXWhqxY4A03xlqOJhZNWkoqm/9Xn1xUJTXWg4UUz?=
 =?us-ascii?Q?obzSQPmcErEAU6XZ5KTGJBMkrqZOCWH3ZHTGJtr3pYxN+50+mr07NSXRqpXF?=
 =?us-ascii?Q?jgUXTyEjwDN5cbij6a5Dl6OXjiFxEZzuWsEaSVONE43857B1VziPMkl5M/4z?=
 =?us-ascii?Q?uF7aF+gl+LCVlNd0vlrjqmXIzr1ZinUA4Ya+n3VTI8rmAhNqfLwh4Hsxp/ls?=
 =?us-ascii?Q?uNNDAyRMQG32iLnWN256dJ5TaqSRpbPf6Yp9ltGIiP50eMP2sM0H8zBsO2up?=
 =?us-ascii?Q?WM0TGtrrsacOFuVq17Hk/6S9nE3oN6VguLzgZWKiSbmh7vzv54L6m6cPOMc0?=
 =?us-ascii?Q?H7nltdl3k92gJ+bGo4YzgSly3qM2ZsWpVq/i1rzYK6MrUGK2HIzDxnaOoPRT?=
 =?us-ascii?Q?qVHYITFdNmGGX7BgcLJ2b2ptuLVLpNuJbI49J7AZ82iNRlI8jKnkf115fLAs?=
 =?us-ascii?Q?gW7vDSqgSSTfRs2BQ8fypEvxmTiJ73pFC/laGqHDFMAAgLx3/K28CuhDvBtM?=
 =?us-ascii?Q?5+JZgTFW6F3FBj/rwtVS4eIL86hKrqJPNU5T0YjRu6RJm8thVwBZJw0Guvj0?=
 =?us-ascii?Q?PP+u1JySbG/Yhwz3mIy5xT4tGd6XhOxGZfZW+AuH4ClXxMBlnM1rucz1CVp4?=
 =?us-ascii?Q?LOL0jjIbPDh1HH6oZDcXi0tvC56TCo0WtwHj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:33.7128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6bb4ff-0f57-442b-9885-08ddc44ee830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
Received-SPF: permerror client-ip=2a01:111:f403:2413::601;
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

Improve the IRQ index in the VersalMap structure to turn it into a
descriptor:
   - the lower 16 bits still represent the IRQ index
   - bit 18 is used to indicate a shared IRQ connected to a OR gate
   - bits 19 to 22 indicate the index on the OR gate.

This allows to share an IRQ among multiple devices. An OR gate is
created to connect the devices to the actual IRQ pin.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/arm/xlnx-versal.c | 62 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 58176fa11e5..89c93278336 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -41,10 +41,21 @@
 #define GEM_REVISION        0x40070106
 
 #define VERSAL_NUM_PMC_APB_IRQS 18
 #define NUM_OSPI_IRQ_LINES 3
 
+/*
+ * IRQ descriptor to catch the following cases:
+ *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
+ */
+FIELD(VERSAL_IRQ, IRQ, 0, 16)
+FIELD(VERSAL_IRQ, ORED, 18, 1)
+FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
+
+#define OR_IRQ(irq, or_idx) \
+    (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
+
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
 } VersalSimplePeriphMap;
 
@@ -172,13 +183,56 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
     g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
 
     return versal_get_child(s, n);
 }
 
+/*
+ * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
+ * used to return the corresponding or gate input IRQ. The or gate is created if
+ * not already existant.
+ *
+ * Or gates are placed under the /soc/irq-or-gates QOM container.
+ */
+static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
+                                          qemu_irq target_irq)
+{
+    Object *container = versal_get_child(s, "irq-or-gates");
+    DeviceState *dev;
+    g_autofree char *name;
+    int idx, or_idx;
+
+    idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
+    or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
+
+    name = g_strdup_printf("irq[%d]", idx);
+    dev = DEVICE(object_resolve_path_at(container, name));
+
+    if (dev == NULL) {
+        dev = qdev_new(TYPE_OR_IRQ);
+        object_property_add_child(container, name, OBJECT(dev));
+        qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
+        qdev_realize_and_unref(dev, NULL, &error_abort);
+        qdev_connect_gpio_out(dev, 0, target_irq);
+    }
+
+    return qdev_get_gpio_in(dev, or_idx);
+}
+
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
-    return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
+    qemu_irq irq;
+    bool ored;
+
+    ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
+
+    irq = qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
+
+    if (ored) {
+        irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
+    }
+
+    return irq;
 }
 
 static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
                                       int sbd_idx, int irq_idx)
 {
@@ -1209,10 +1263,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
     if (s->cfg.fdt == NULL) {
         int fdt_size;
@@ -1223,10 +1278,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
     s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
     s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
 
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
+
+    container = object_new(TYPE_CONTAINER);
+    object_property_add_child(OBJECT(s), "irq-or-gates", container);
+    object_unref(container);
+
     versal_create_rpu_cpus(s);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
-- 
2.50.0


