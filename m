Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB76CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTW3-0007pf-M7; Fri, 22 Aug 2025 11:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVp-0007ey-Mm; Fri, 22 Aug 2025 11:17:05 -0400
Received: from mail-dm6nam10on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2413::628]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVi-000797-9r; Fri, 22 Aug 2025 11:17:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPASaWLiuXfa7Gaj7ebiraADuykdXVDNbHyBqh8rZqibZmYz9epMokKW8EYLlPkv9f7tuHy8d+UkhSHjn0ush4ucpKaIE2prBLjoFKrwyX2d+i+ezRTqsaf+7a9OpBT1n52zpeJifFbDMGSHZt+LSd3qvM/FdCS7VWpdFN/w0PuDFP0xdxCCkENAttDQ0/xsDvltozVtGk4es8/0gftbR9P8asgcZOo+LYx1TmnQQw8o6aHbIqJT8ZMGyCSG0PQgDIGtgLKUzc0ZMKONmZkkbzbJX0tv0R1tzAhr/i6/eA3QJ5sYUa/FWvSL/8/xv6PFOPwFThkqUlgQNxsBnWG4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfK9PYBMgv+CTdcHuYYAzkmbkIF52TuNUTQyrY9jOhY=;
 b=Qn5MZn6ahgPtSsdCW5hrETbDw2DfLOfPVguGD0FhctJOHYJwPjZ4TcG6nHVrFSu9BbAz9fbGj3gfmkB7oUlgWuSVdSfNZXztu+pxUxlBmvgpDmBeerxv5FCuX4cgNu+12lES/lUWSrALQYNJ1lAU9PZtNhocIBuJhbna8hgrf1slIGGX1UQQfKkSqkqzBoErYr44vhj32VE6aL+tHIaZw4fqmr2x/XEuvihm9PTV3AKcMlO4ay1KPzOYSApHBD4TV1Y9BjCb6OdHPh+pH69vq1dNtJwcPA1jw+iwNiAvjwBN6Gaqjh9jnuzgnQOjhc6P4oHy1BCK91RR0Q05BDh6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfK9PYBMgv+CTdcHuYYAzkmbkIF52TuNUTQyrY9jOhY=;
 b=vB8bmhcKb9J2SVD/geAvMqkKrhqRqT38ZRfqnsKd0vGP5FLJt0lKgtAcR6fnN6khFARF/P+/rCzulyi2rFYXiaFg2D16fAHVeQScoGONuW5XoiZPBP9sk8djLjtl1zIUt0qpTCUZBHBY4SqiPgU5eR5cYEWhVFxAvfK3+MOpn/4=
Received: from CH5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610:1f0::21)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 15:16:50 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::f0) by CH5PR05CA0016.outlook.office365.com
 (2603:10b6:610:1f0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.10 via Frontend Transport; Fri,
 22 Aug 2025 15:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:48 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:46 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 12/47] hw/arm/xlnx-versal: VersalMap: add support for OR'ed
 IRQs
Date: Fri, 22 Aug 2025 17:15:37 +0200
Message-ID: <20250822151614.187856-13-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: c95b0989-ef45-468b-54ae-08dde18eeac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xnMgZYY1cbuSTzYtDP37DyAcX8XNsCTvD9O+He33G00rpucCvrIEQypK3rG5?=
 =?us-ascii?Q?iRPA0nsEnFA1AjTSePT8ySCx35jHMIMQaIyIJ0qziqB1zLLTZ9NB/o4RQoDs?=
 =?us-ascii?Q?wQAFO6XtE1NlNWjCz6aivMpaRniQZfplHhOJ9+qJZ7aOByjYQiVY/SXuvhTE?=
 =?us-ascii?Q?uol6N0cOqYHofHZlydwl6LBNHzjSVe7heBE1uWHIe9Fo+yE0HCTqVhocpNvU?=
 =?us-ascii?Q?+8LcU2aiU3tobPYkDEay1hAylTdnXWa7y0B5kQaxd58ikOYU7BtaVwge9h/6?=
 =?us-ascii?Q?dZnts8SQVRxsFkFP7+MqYm01OIbSlKnjXoYpSdyt3EZdfl8oSZ0uUPi+Be9b?=
 =?us-ascii?Q?07ZXZk5RmdQxK8nTjGrkKIFn+Zj/0H2kjT+BQRjmc7j4jIGWdXfBvQFBvXkc?=
 =?us-ascii?Q?gb6ZcNgQ4XjyIWubWSmxVk/alLkQZlNUc350knLQ2Y6j6APMpnK5POjWtyX9?=
 =?us-ascii?Q?N3HsNSMAH4FVrafs5AUjqjpc/j9/EvpiXtEvywz9d4OmHO3FivqbDlsKUzRL?=
 =?us-ascii?Q?bUqlK2BT+7GRNrDb3899Cxjjvct/QZOMUML7uIc4ZtPoaPmCo2Kf10PT7nmw?=
 =?us-ascii?Q?jGsYTYpCWxp/tyn4uLDXoHt3EVHnuU7fIRLmuJQ/+UMCmAxwV25RWlB9WQsx?=
 =?us-ascii?Q?92wKykYScIEluzGIoi8ueQ+QNelDQ+t5tK/iRjVcoVgQJvN5PTr2K7CPQtsq?=
 =?us-ascii?Q?hV7FW9RkIJwrLeK43DR39JHFsGMunCMGez/okVgxiPRRb1l126LdoI1iAWtY?=
 =?us-ascii?Q?GAvULEF79H7b87beygYNB/zkNFekZHvVE5TF7ZhKMN6m67q2i0rTl1FlBM7N?=
 =?us-ascii?Q?aI/9he+7usdSTAMlBJRqP2XkeafhsbJiS35ci0F4LJtmMc1YU0N3fKOO9p0c?=
 =?us-ascii?Q?vevY1BGYEO0CX8MKHAZcpZF7FlVdrgEIBdfnqXWU1nqN4vz7rTFMcrt3qXhl?=
 =?us-ascii?Q?J8YGQXspN3E/xKiCkLkDGDl9g8yr3Uc9wiegpTfkQyq2jmnwmvJT7m2zCW23?=
 =?us-ascii?Q?mM9aISLQMOKbu1rthI4dbAJ0j6k+8LJxqF44YYxXqZiAsI/nuHlcYeuXUgSr?=
 =?us-ascii?Q?VLlJ49KRIayzfO7Xs6JS9QaxVcqp6vDjLqzGvHhG9eJU964YGqQFW7A1pgfa?=
 =?us-ascii?Q?LPQ3s8y2FAXIYj5Hjeln+XhBP0tTi8rzgO+HgkO4b+U57PqAfuvd9OYeBhbD?=
 =?us-ascii?Q?osw9hPNO/CAtdnyD/4lIdqSpQo/JBfMItqB5kqflpVL/kYeZIDqjQdRh63yl?=
 =?us-ascii?Q?bu1SxxpfaqVe0ImVL6A/w5AmGhx7dZNqPJe6v2NtHvQwU+xpPXSXlbiq1y+Z?=
 =?us-ascii?Q?gnTzQWGGDqE5w8qALZXXNlegfRnvGR35qamKoS+knRYt5OiI6dqqTrAV0K6o?=
 =?us-ascii?Q?PwH5NUSFwaFj+6CUG1kLgmiOO7ttqJ9LEWiUVzgs9pngxDh2HQmtq34u66WB?=
 =?us-ascii?Q?QWolFpz79mkS1F8c2KkNLT+DbCNW+NtnVC6yXrqkF/P+isGYx41ewARlXnuM?=
 =?us-ascii?Q?vpMr2yC6MqRmi03xs0IrzmlKuOOJFUQ3qWaL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:49.6007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c95b0989-ef45-468b-54ae-08dde18eeac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
Received-SPF: permerror client-ip=2a01:111:f403:2413::628;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 hw/arm/xlnx-versal.c | 63 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 56022021766..2474f8f25db 100644
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
 
@@ -172,13 +183,57 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
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
+    irq = qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic),
+                           FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
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
@@ -1215,10 +1270,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
     if (s->cfg.fdt == NULL) {
         int fdt_size;
@@ -1229,10 +1285,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
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


