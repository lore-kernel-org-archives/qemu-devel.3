Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3274ACA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yG-0001Q6-Jj; Thu, 21 Aug 2025 09:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yB-0001Nv-28; Thu, 21 Aug 2025 09:04:44 -0400
Received: from mail-co1nam11on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2416::602]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y4-0002u2-EB; Thu, 21 Aug 2025 09:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vxzj3mjoDB6luHdD2fo1kOFO/Jn6OUFhfWOSerxIKIoGoJVdGa2av0+id2ft1zIcsCcueGUj2DECN40ft8qB4+aQK0dozI6Lbgu+nrWLhHfgcXd2ztHP+Zb6iBj9HToNc6OEwPnTL/j/K4Sjob+4mQKILb3BnCwb51Vt44xZBf61Vqhc8tOwFh6C9wr4MDk8XpCif1+dEqh+O0jXCbVAOl67ID7Zkrb7wID7i0lunLd3DpSjc7gGoFPDfpnpU/vQ1ldpslQlo2Eem4/87wYBvVrE5VXEdD4ANuXS9X7mRlfPCWwFPSCfTDGut7ywXaCc7r35hxAHaN/ASHKvYRHkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3f7fwPaAVSpjkCZsB7ZAE9zGWM3nym2eh9zb+J1pLo=;
 b=j+dZDQy7/AcMGe2F0CeNRwCcGfCI5rQUd/H4z/iAYBlIw6bkQIBgPZAUTGdx2OWYI031/SU5QI21hZJX3gvP6Zojzo/kc+Ze1aesYc4Z3G5GR2fHPbAXKy7Ojq1UXG0hRvJsdKHHL9yiR3SUiqAsToDNdLm9pwqyvqzlBjJaOde+J4948YBcWjuuyl6Ro6a7f4iqL6l5EibCSq20ApV4diiVDa3kiBEnLISInl9747nO0rUmc+YGE5G60jPuT1udAtrVBuiB+dtoJkq/iMqXQW+tlQEgkpNUxwqrVpFGq9jX6B8wjHwMj0khqkWn/Pt9eAa4kkCOV/vqyV1TTTrOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3f7fwPaAVSpjkCZsB7ZAE9zGWM3nym2eh9zb+J1pLo=;
 b=cpVY27XqYTfkfOkn0KLeTanZcWFFI4Ncc4TG8m2DqHZBaMEQysvBKtfw7XVtotdHuFpOnf3Olpz/Evg6h7h630oPPeMYaM7L0Xlvnf3G1/Qw7MDxnIL12ROn+/NWp8HTC3YQkw1qDNY8qRttLNgjdIiXVoZhlRoBPzaDEIcOn2Q=
Received: from SA9PR13CA0069.namprd13.prod.outlook.com (2603:10b6:806:23::14)
 by DS0PR12MB8479.namprd12.prod.outlook.com (2603:10b6:8:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 13:04:28 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::95) by SA9PR13CA0069.outlook.office365.com
 (2603:10b6:806:23::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.9 via Frontend Transport; Thu,
 21 Aug 2025 13:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:04:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:25 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:23 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 12/47] hw/arm/xlnx-versal: VersalMap: add support for OR'ed
 IRQs
Date: Thu, 21 Aug 2025 15:03:11 +0200
Message-ID: <20250821130354.125971-13-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4dc744-e124-4dd7-c66d-08dde0b34335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vX5h+l7MmQAM+/NGk+IuVWr4cDQVdjrBoVU2mNBpRsm2DGpE4/63WlfNq03n?=
 =?us-ascii?Q?9k0+tHjbVfE9xBqkt6pQTupGWiVOc5wQyX26B/NPI71I865nHbmlhgjrf0Np?=
 =?us-ascii?Q?/r03Iq7szWyonBKv6rwnZLWPuISPRV3q8/cgJEO7ll41MYl2+D+tHZkgFCYb?=
 =?us-ascii?Q?XYN4gBf17KZfUwqpbX4YWAhek5qb9QUs5wlPeSTrUlpepizy1WtDhIOQbDuZ?=
 =?us-ascii?Q?NHSE9r1NcFqxYPq4UHLY6bO/3tmvNwkffZMPrVG07c5I0O5C+tSQn0DA/DAx?=
 =?us-ascii?Q?F2zWkMTk3ePSjqDr3G28t+7K4aKmw+BhHc9DuqH3KB9+FuhukrNOoyNoUzWR?=
 =?us-ascii?Q?xmOkjmx43A8XzsDQZSSyT6fbnmLy+VhQr+UmIWAiebY5WLTIStxAx1nIwn5s?=
 =?us-ascii?Q?Mi+7N7edN4o6LwXxlyJmU0Eccq9DmWGHLP8463PBWa6LDY3YczEmNrJPVpoV?=
 =?us-ascii?Q?Joc8XhqeRMefoB7Zl3NDcKzdBdPIvAMsXxEWiZ0Ukfa/h5BdVSaQebJm3Vml?=
 =?us-ascii?Q?lNiRmgkKv0YTUW7mafbiaZsmjaeQtvFdr8oMDZNDgyK4/loBk/NiSW+nGg5w?=
 =?us-ascii?Q?m74huNxchnTaM9OF5YJYLNcfKJH41l3TJPztcvXVAkPtU/cMdT62iy/+EMOZ?=
 =?us-ascii?Q?vjtquU97LdKJYW9gr+cBb9fMdZ/8sOHoCWpwnitCjV0knI5FN+Zo2hc9IvVq?=
 =?us-ascii?Q?JLgo5vhQKpWisf8r2z7cOPWoTB2rcajAh9Q6Umz03hgataH33cS8r6c/7GY2?=
 =?us-ascii?Q?VlRzF1pH+XTREm+OzA/fr+vUEyz+7RqjVK3s47yCeiyMrY+KwUAPFgxwQy3H?=
 =?us-ascii?Q?2Kbr8mFUPZqd2odC1uiBSgnLiNXPgLIg3iMzbqk/PUbjoAupg+inGGbSL7Yc?=
 =?us-ascii?Q?zN6Q6svlA27KZ8DQVS1MwBWick6rCB2JOaudSJwr6LLh0v8sklpwKNwxSacJ?=
 =?us-ascii?Q?4tjTvlkXB99tFFAyh1mQ5QptNqZR1xc0SQlczIZ7gC+zGBTpwWeMI/8oKfSb?=
 =?us-ascii?Q?g1YHv+BWwpebMhodBgYaXeLZ3UmdcndEGf3XHwT4sL9M6+EPt0qymiymHHWW?=
 =?us-ascii?Q?6L6kzyVAD0+neHizTawd/WyZ4sGru+Us6GDw0BmnlR60Miv5NrJ14CDhr63x?=
 =?us-ascii?Q?NLS4GN5kZX6UsYR3ksxQzMYr7XdxaojgwPynEPj/dl55Cxo4e8Y/7FusfgDo?=
 =?us-ascii?Q?gj6CNMcooDDr2Fe5gMOLiKRMx1R4W2CvwfCE9Yy+MCSrJCmKE7ItINZrO1km?=
 =?us-ascii?Q?F8VCAi2+dQov+2VDvQKR9EHD2Z4OaY1ztiNKOy3iFIIDZdJdZAwkhzunVpZ8?=
 =?us-ascii?Q?JvBvN1wA9Y4DtFas+jWfM2ETx6Wip3aKM/whci3nS/hHz91dXKJc0/s+M3Sj?=
 =?us-ascii?Q?I06T7XebydtYYmCZIe0V3Yy2zBSlY0b69KrRtxOhervvx+Ur8sWv4UyPUZbU?=
 =?us-ascii?Q?geTuJr5dkP2oy8YulycmLUeSnpXEOiLUwUoouGXXwfBZq8kRsK7st9C9fRNG?=
 =?us-ascii?Q?BU3wx8v8mcqUbU7oHV/SRhDrgkkxlzkabGOJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:28.7163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4dc744-e124-4dd7-c66d-08dde0b34335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479
Received-SPF: permerror client-ip=2a01:111:f403:2416::602;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
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
2.50.1


