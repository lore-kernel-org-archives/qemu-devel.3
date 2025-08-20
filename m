Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFDBCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9c-0004HR-FX; Wed, 20 Aug 2025 04:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9b-0004H7-L9; Wed, 20 Aug 2025 04:26:43 -0400
Received: from mail-mw2nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2412::629]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9Y-0000td-Pb; Wed, 20 Aug 2025 04:26:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruPl9EXPUNaYQFjdsym0tQO07ImlzleQDon/LZw56RZ6p+gVZ5GCUVWiVCdcCE0MWhmtsHFKIsgO5cq9stCPwv7t+RaAVeTnTSi2oxj7bvlhaFoZl3W5xxBaws7gYtGjLsDQG+eXZF/YpGMguYFnnD21s/EfcJc2p3+w7/ytALniQ/CVKPBEFrGix/wPPb+DSfd2oCkTdHKkTnR8KjOwG6TWH7b8AbJt/BboOmmhMO7tx8I6Xo1U5hyS5NiykAS6fMwxAqWqNgjVjMgeIEkGCyxAobek+sm+GA9eEz/kyavT2GTnXiktxDcmbR2zY/QBIFjJbPVFlWlXzj/4eafpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3f7fwPaAVSpjkCZsB7ZAE9zGWM3nym2eh9zb+J1pLo=;
 b=kqjGw+MqnQ3wnQZ4z+fBWsTPVPU/bLHpDUrf3eiORXp1JFcZe4enPXjXrF7jlJYFxy0VxPNzJ3dDN3ihr2TV7Tz60yKzGAQQ3VETMAn+3EQOaHvbXFsG8+5wXRU6/8pxJUBsvTi2T+6EeIzJhi2oCQjJa8bXj6YsgXRGk+xMTyEMhH9Ot7nT5PMf/u2zdA5MJB/FEJqwq4ZMnEWjXAYugd3SUWy5mXnysIg5kQP2xceZoz1XbMqMzPNH/f/FKAMxoGPfOlduBxRh5IrRxzNf1ni9Dw+TRoXHemrd57pX9mZEVTF4ny6oaYPs0jfmu5SYMydEVnQKYEAY1giivzgiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3f7fwPaAVSpjkCZsB7ZAE9zGWM3nym2eh9zb+J1pLo=;
 b=AV7CG3rW8gHsm9yPki+LPaUtubMrVqJ3hE3rIpFHB9qyhga2HUmifohxReGOFesx3Tcs/vrw4r19Of79hsLx9fo77+0jII7LD9aElOBTb0EEukqYkpfSy9xVjvadfJTWyGKgNRT1UkSrXGx4HjfgguKhLRXklKY6X/8P23aCnGU=
Received: from MW4PR04CA0343.namprd04.prod.outlook.com (2603:10b6:303:8a::18)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:26:33 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::3e) by MW4PR04CA0343.outlook.office365.com
 (2603:10b6:303:8a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:31 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:30 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 12/47] hw/arm/xlnx-versal: VersalMap: add support for OR'ed
 IRQs
Date: Wed, 20 Aug 2025 10:25:11 +0200
Message-ID: <20250820082549.69724-13-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cd2e34-baaf-4b0c-413e-08dddfc34548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qOqaPgb5g4heP5NZTzJKUAB+8sywEidIwfF7b1eQ8EURY+QBYStS+ALQ3E3L?=
 =?us-ascii?Q?u2LEnmieu+M4vLm8Ks0QnCG3AN0tzDSYBpqDrnFEKBFt7Q6/dwXQHRKw0Jj3?=
 =?us-ascii?Q?fFOjC7grqEfxrljDyQvVc7Hgeo6+ZeaPt0Aqa7Ub8D/AQe6QIVxfAhlbUEZA?=
 =?us-ascii?Q?t1YZDlmMA48HhYvdH2822r1f1TbVAWNxTUA252MGGLIE3jW4t62YdFHmfPjS?=
 =?us-ascii?Q?wdIZFfGmBSbdvSZ7XBPjlACVw4R4M+zNtghbPNoWsu3o/iE412qQd0AQf64h?=
 =?us-ascii?Q?vPuwAEJozfZDPQX/0j743MwOnZC/HrpAX2Cndouwmk72ZuJMsZNI6t8b7Rey?=
 =?us-ascii?Q?n0D/Pzzxql1g8mbFk0y+J05XDmygKJ4AtGU5fUSqB9j+/WlVVaDODm3EcDIv?=
 =?us-ascii?Q?1Lu9Jxw0C9LN1j8Rk468OKjHa1xBBFBfaH4UanGHNLbmHiifk/Vsxf+MlN/s?=
 =?us-ascii?Q?xw2m4gVwBiPQr+gyrwOpAeflVkU9TjEOn1PO8qjywy41w3G27f+howNQTbEZ?=
 =?us-ascii?Q?fMZs61M7l9OCLFNrtJ9fBarqDMusdKtshRHStnU+RfdWBr9CQZEMYMRbydoi?=
 =?us-ascii?Q?9+jycKRdeokxP0F46JAQLoko5YjXdwALsbHga2CFomE58Ef35uHGzj3b1k9M?=
 =?us-ascii?Q?VamdJtkyWzPLp1Bl1519YyXjA9LAVmvSS04adwAYyDaMCykkq0KEyKulIb+A?=
 =?us-ascii?Q?nImwSoFUGk7SpdsSJBYL2h5KW1pqxr/fxixYLl3Ah+YwzJSM8xsRmshWd5Iq?=
 =?us-ascii?Q?ymzZ1kG5bBp+qYjU1Hlkfhu9Bqwe9jHBoK9JinjeOvoPg8MCWpTPtlpPGpTb?=
 =?us-ascii?Q?i0nmKC7lxOCFzBjZPF8FQOWiiu8ZNHCTWNIuImxnw614DmKC3iy0pAeut2KI?=
 =?us-ascii?Q?jHxLwVTGaWmR5ndFdCd+Xkn4iUBQwE2zXzwnPPhcndHWgMyBAJkChzim6Ltf?=
 =?us-ascii?Q?hnONCTCk/Hog6LJK7mCLs1Yu1eH0S4A1m5zzrpMprdc/jcWKQAaAPuDrUVnB?=
 =?us-ascii?Q?aDCdgi7c0XdlCm5BVenqgDRIWT0UGg6w+s+0cEHM/zdmMSmtfMj0zKbnK7lP?=
 =?us-ascii?Q?CDxGpXCHe1oFYSn3duUztxw/2qWFcF4zd9exTyY88S5DYGHFbS8DYdvEAeKl?=
 =?us-ascii?Q?dWRvZbCn1gzl5WQCPJnNKiLWLfmC4lTU5hrhlLJyk/iYE0+YKY8Y5en3UJPr?=
 =?us-ascii?Q?tALUvh0scUDSkgyVr3nMXvDikD2+YPG3wImOii8ffNHc7vQrMf8wNEvsbtJd?=
 =?us-ascii?Q?TgrnYtLPd4FUI1vYd/pqM8sV0ACoRODDVwr87kXpFsNxzHKEWxdcSHxOyRAp?=
 =?us-ascii?Q?Rw1eTK1bo97aiOEvEEqyX3dpWd9L7H9NQUS8+UkPST/f3UH0mZFRbwVPktlK?=
 =?us-ascii?Q?Ry880nltjfJtaPyIS11zX6ErKs4qOhWn9+oYG6PFDNFECMsH2kM6EjP31knY?=
 =?us-ascii?Q?6Sw5VnabHqLX1OQ2XROKwOBTYmRbrxoEbqDkARWwRDflFfi+T5Bd8RAlT0KU?=
 =?us-ascii?Q?KtXAGZd2W9Th+lrXmwWFe2sM5fNHVqkCSIPz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:32.9116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cd2e34-baaf-4b0c-413e-08dddfc34548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
Received-SPF: permerror client-ip=2a01:111:f403:2412::629;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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


