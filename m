Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C07CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22ca-0001Hg-NM; Fri, 26 Sep 2025 03:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aZ-0006vy-QN; Fri, 26 Sep 2025 03:09:55 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aJ-0006iX-Nn; Fri, 26 Sep 2025 03:09:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUul+bje+ycWfIV6cZBACvTAdAuLzoVFbRzvuJOEPPoVgpCs1juKY0QBs5UdP0Qc0KoS5/tMQkzABJXdFWxjfCVY8x8Y/X+Byaof2FClb9TXvFAKLkqsMgjSNlGp5aoYnQ/hp72DWNS0W7+3SaX8A+ADQ78yZsDeK52qkxJxjIgNKpD79g8xKCBRZ2gsx3lbTz1ap5EIpPlZVNIdt2oIicyDR5tGyPg8R0wuVYyNjvshiBRXG7z7nd912pRqrmmTtkucrXku9y54lPuPlcYfPu3jGRF2i8vXtu9l48XSWm/06kg8syG2AwNxCrRo1N6kiaQrdiMSQZVyGYtxSsV1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52EAfxloTuCcqZd/ZXbay3mtKNB3Yan8g9J7JOyLfiY=;
 b=H1e9c29jgl0OB2eBSVqa1x9mXZH0QRWCcwui2X8N+NyeoW3KKjg09lAGahLDACEhQncZc2lQu8wyXu8gcgjr8Bpv7VRaggJpWx5Ja1bNd+Md4+rmu+8n+1cBqGL/PITzB6SBZp2YArQHdpVRFWdgPh+/CloCVGCKBOkjY4NI3YOZAAA9p6sTBAC85WL9XQ8PMLS6PJfaCy2ZH43JJlDNML93Z1W7LbB62h9bhICiOekEoA0XNMQoAj5VXQ5o05LTcSj7GNGJtrWp5NgLGBts7yznNst/dQDrUZgV83cv6GgXK2RSC5OtVyxB/tPls5o2b6h5Ihqktg3bg0rbKsjWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52EAfxloTuCcqZd/ZXbay3mtKNB3Yan8g9J7JOyLfiY=;
 b=KiGMLewx6ruvylgCxgmKsl/gxex7ZnNhlQm000oK1MsYmSVaw9xOTSVMuZxId4vvP6Lb6GAOBYXs/lksPtYtYp/IkQ2KlbXttuQkFksJBZ1iT1H1NuD9dgzMvzfZtLB0QhTdAtYkSMGiN/B2BdlwTVHJGGeOWRdlyv4YfElkkb0=
Received: from DS7PR03CA0237.namprd03.prod.outlook.com (2603:10b6:5:3ba::32)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 07:09:30 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::fb) by DS7PR03CA0237.outlook.office365.com
 (2603:10b6:5:3ba::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Fri,
 26 Sep 2025 07:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:20 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:20 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:19 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 38/47] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Date: Fri, 26 Sep 2025 09:07:56 +0200
Message-ID: <20250926070806.292065-39-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3064fbcd-cb42-43cd-c6b4-08ddfccba36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XkvXbIuv02tRXOqyLzptHZC5ualfAjx1By4J9UVEhchHNXRC81rZLp0Iieaa?=
 =?us-ascii?Q?ufmQA8g5L2xlQKiJF7MlKkq9HcPmXQNsD+cLgTPTftRiVenMK6yYiSPu6Tq+?=
 =?us-ascii?Q?SoymDbcCU6feMM97DaEzF5V70jdDGAgBPSnbTqrQMJsG9J0uY1GaO0akhP8a?=
 =?us-ascii?Q?r3MiG48oRzSe2Bt+ZcThlGTZ6l5Ziszf4hvWKhRVnOPwRJ2sEXmwQ8hCU1mF?=
 =?us-ascii?Q?MVd4Lp7mCERse+GGRRDdtclzqjWVStx79c24at5kPvgz6H4j7bmV2w4WoV0y?=
 =?us-ascii?Q?dbiN2uu1EcEhBOEXXDIGkS485pwHT2VmEB7Z/lEtw0c4khGoz4a5qSxMhn99?=
 =?us-ascii?Q?i3bzbbAEV+QlsZYb0E4mgryA+Y9AZyQJ+xAGULV5btmyoGtuAkTAuP+GKB7S?=
 =?us-ascii?Q?RnLefqxKM/wTlR6fbdpvtd3vCGij3KyjwrpkthOPusvMMXM5tsrhUfpN2j9K?=
 =?us-ascii?Q?e58zxAGcsWKypAlMMHbRSqxKNNLqL4wWoDN25EKEFqkKi5nC2oWuST/RD9iS?=
 =?us-ascii?Q?l7TwlatvZjG97aiykElSQx4rtDpUAKnkkF3vanBWpcO4DxDBHFD2fNfqCHHO?=
 =?us-ascii?Q?7J+lh/bjw+ZhUUpymP7Ro4Bthp8ckTHjzBz7UKdtyQkiUYcN9uOA6jLEvOiX?=
 =?us-ascii?Q?Ety/Uqb/Q/zvuMYL/0mdglpsTpp68DWFKSomm2CEPzi9ad8vxNvRNMKwVHbI?=
 =?us-ascii?Q?luJ9qkzlmYl5nLltx3ZR0jRA5/z/aFJPb1kXlt8KWKeF16zSGbbvaAbmVDOQ?=
 =?us-ascii?Q?/WhIiXRzuINw7d3wJV/IwHnWwMkrg+nsoZaU16Zt8TDHd27Y71W14m2Emlph?=
 =?us-ascii?Q?0WtzfyXiKa5VHBttAa4zI6qKWtk5Ct5fORo4g2KBroNMKFMc8sSOmw16umxU?=
 =?us-ascii?Q?lsfmMDMaOySZuUhnxHgPLQOaGVRgR5Y0zdhZwm+fGLKX5qHToJoxZtBtvn82?=
 =?us-ascii?Q?/wCphmfOpsO6XFoYWU+5XBIVovyGKFOzNO/K7AxSky+KynZUFV8NUyZ9GUph?=
 =?us-ascii?Q?iqUJYExEKxCcrlj7RyvSySrbYqHZJ1ZPHzBIx+oWW4iBBKgzCtSNoGDBF+QP?=
 =?us-ascii?Q?hcby6yn30P42hEulyrA3lmHW6ParYVTjdhjrEmQ10HeXdKbV1jOU5OSCkbu2?=
 =?us-ascii?Q?wmp41p4YONBllbd6c6VobR0Uu+Qij8KjpkihEo5l8K8bsNMgNYf6M2sS3wZU?=
 =?us-ascii?Q?n3HkgzoH6B6vI7dxskjQYTojzP6E8aUglP9I4fQXmgfGMZaUWrFEPrl8ZBFV?=
 =?us-ascii?Q?1jN92nD56EdpVJPY0IRVEyxtYPNMQOhW3hJvy7DetY0SIlnlqGCaizc/hj7z?=
 =?us-ascii?Q?YaJ9rs0yQlqxiGo4vfdMwFGlBG/1Uyz2BwhFZ0WgFXAnup+KbDUUmAPE3xkm?=
 =?us-ascii?Q?zS8pS3dMZVUF4fzBzOIgaBrvNNfLFYNzVAqxEysHFCsVs3eJdNakqq9/CrNj?=
 =?us-ascii?Q?n7AU5yPE/S1hquHT5ClilnK+/cX7wCD6xXNE7KWb6Nlhm4HoOLj6shuv8gil?=
 =?us-ascii?Q?PSEe+Ivpc+HVqOxwmyx95KOQqqhoVwtDk82J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:30.6116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3064fbcd-cb42-43cd-c6b4-08ddfccba36d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the target field in the IRQ descriptor. This allows to target an IRQ
to another IRQ controller than the GIC(s). Other supported targets are
the PMC PPU1 CPU interrupt controller and the EAM (Error management)
device. Those two devices are currently not implemented so IRQs
targeting those will be left unconnected. This is in preparation for
versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3d960ed2636..64744401182 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -50,18 +50,30 @@
 #include "hw/cpu/cluster.h"
 #include "hw/arm/bsa.h"
 
 /*
  * IRQ descriptor to catch the following cases:
+ *   - An IRQ can either connect to the GICs, to the PPU1 intc, or the the EAM
  *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
  */
 FIELD(VERSAL_IRQ, IRQ, 0, 16)
+FIELD(VERSAL_IRQ, TARGET, 16, 2)
 FIELD(VERSAL_IRQ, ORED, 18, 1)
 FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
 
+typedef enum VersalIrqTarget {
+    IRQ_TARGET_GIC,
+    IRQ_TARGET_PPU1,
+    IRQ_TARGET_EAM,
+} VersalIrqTarget;
+
+#define PPU1_IRQ(irq) ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
+#define EAM_IRQ(irq) ((IRQ_TARGET_EAM << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
 #define OR_IRQ(irq, or_idx) \
     (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
+#define PPU1_OR_IRQ(irq, or_idx) \
+    ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | OR_IRQ(irq, or_idx))
 
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
 } VersalSimplePeriphMap;
@@ -412,19 +424,27 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
  * Or gates are placed under the /soc/irq-or-gates QOM container.
  */
 static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
                                           qemu_irq target_irq)
 {
+    static const char *TARGET_STR[] = {
+        [IRQ_TARGET_GIC] = "gic",
+        [IRQ_TARGET_PPU1] = "ppu1",
+        [IRQ_TARGET_EAM] = "eam",
+    };
+
+    VersalIrqTarget target;
     Object *container = versal_get_child(s, "irq-or-gates");
     DeviceState *dev;
     g_autofree char *name;
     int idx, or_idx;
 
     idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
     or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
 
-    name = g_strdup_printf("irq[%d]", idx);
+    name = g_strdup_printf("%s-irq[%d]", TARGET_STR[target], idx);
     dev = DEVICE(object_resolve_path_at(container, name));
 
     if (dev == NULL) {
         dev = qdev_new(TYPE_OR_IRQ);
         object_property_add_child(container, name, OBJECT(dev));
@@ -436,16 +456,33 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
     return qdev_get_gpio_in(dev, or_idx);
 }
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
+    VersalIrqTarget target;
     qemu_irq irq;
     bool ored;
 
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    irq = versal_get_gic_irq(s, irq_idx);
+    switch (target) {
+    case IRQ_TARGET_EAM:
+        /* EAM not implemented */
+        return NULL;
+
+    case IRQ_TARGET_PPU1:
+        /* PPU1 CPU not implemented */
+        return NULL;
+
+    case IRQ_TARGET_GIC:
+        irq = versal_get_gic_irq(s, irq_idx);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
     }
 
-- 
2.51.0


