Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F400CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yQ-0001Zd-46; Thu, 21 Aug 2025 09:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yM-0001UZ-LS; Thu, 21 Aug 2025 09:04:54 -0400
Received: from mail-dm6nam12on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2417::606]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yK-0002y1-4z; Thu, 21 Aug 2025 09:04:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3p0kO2T4EwTwK2TjgP9QbyN31QgXvSyTo3cfI/nV3XbiO7fw+pbwbbuwUH1RAj1v03iSd6QdXnFw08uIMuhjXsfUGulHWjMfgdf+k9QTw3xsQ8tcK+YrzR+hs4zPCGLEm8hK+yxzi25Hp1BwIaTpmZFizKQfDDptHxzf2xHQtFTw/H2Ga7mewnsvTB8s/fTZY5vuL+AuiEgHHXstxfG6k171qmvlDuANEIcepEst+9p7KtFU6dUy0gVkE5obFcpuFPr+UIaMqqT1OLvMvX5Ncnuj3g707RrdLb9dYEJAZuP2Ebk7nBzCw5QjzXJLG48+N4lHklaj641BfzvULoiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNWduSBV8NkrwuPDaj+EggYnq7LegiXiIxLEwIRxMAU=;
 b=uQ7urpaG8OnNfFiTKeCe7ZMU3YuJJn2LP96uniB+OaUI/H5Z27phjkUcNHWbHG9WPaCtpccnznXQo+n5JskpGST4iwN/0QTlRzkdQ7TW1PYG89gwNQmC+RF1U8KtpQnfPj9MJIjjiBsC3Ns94rBRp0hPjLyr+PMpg6LvI7DV3QM6H4xEbbqEi37hzvQFW/x+MCIOQf8Bv+rcEX2Bg1H/8KlkUqhJ7Ln7oJgksjGY3msRCx0mV9QGkQ9/7ZX71BdBsQ1BrAKrEjaL86GFrieErNXVsHYXo78Kpip28+xXwAx6wx4rCh62rdVnJvQKR7egnOuZeCPYs6SH+SInYnj+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNWduSBV8NkrwuPDaj+EggYnq7LegiXiIxLEwIRxMAU=;
 b=ZGbIWqGjg4Zl3LYqKFAjvfQ529/MMLb0mTlSAt7b1S5qctnXmvbOiB9iavQkXRocMYJ+BQImiJ2OWAPfG4ziJZKW13DwZvGzhoddLC2wXIdvVOWOZsbdPEuOXhnS62kZ9RKJTL5nEpLh7nRYu2aGmYLkfBymX1bOGj6mXObOtH8=
Received: from PH7P220CA0112.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::33)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:04:45 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::ec) by PH7P220CA0112.outlook.office365.com
 (2603:10b6:510:32d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:43 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:42 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 22/47] hw/arm/xlnx-versal: instantiate the GIC ITS in the
 APU
Date: Thu, 21 Aug 2025 15:03:21 +0200
Message-ID: <20250821130354.125971-23-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d49eab1-9c04-454f-9d49-08dde0b34cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Au6czG75jZIx6LemAvG1Bwt0vG127rp8JapjA9YZER8H13g8EGJEa+UStvxP?=
 =?us-ascii?Q?HGsPFAQ8aIR+XCRgxjdT3eWoGMqtMMUF1vc1Bioh4xQNpIRCrprDayixLd4y?=
 =?us-ascii?Q?weC9SmjcqbRnKAqS3mIt7jjijjRv8sb0FOZAtPPgNGnSHud1cXYfOAwEwPCz?=
 =?us-ascii?Q?OAeFcAwF0ogqsBNjNA7u0cS0q/R8rU4XAppuFQjuAi9GF3C9j4vk+lLfejkd?=
 =?us-ascii?Q?dItO35DUCzvpXYyL1+2lnkSDEKCuTjmPPt3JgnutkAjeS09eUw+3IEqUs2xk?=
 =?us-ascii?Q?rFETF2+lrLVyKujOKRjpUh1Xi9us6lQV/aVDI1ATtt7+p041WcVj3JSamzJ5?=
 =?us-ascii?Q?ru9uqM2Iw4FhpoTWaOVJbtLQWMwqrH5t10pjPKYfHpv165KsewLiVHcgqOTF?=
 =?us-ascii?Q?wqygkIvKcJH7tLKdYdxh3DBcEG3qUNNPKK7mBICev/DN+ecKsl+O+WoY82vS?=
 =?us-ascii?Q?FMIknmuS3agTxaSuxnMsFBDsLSUS3H7hgiTadhdiyzrnfkDZBl5amkR+3apw?=
 =?us-ascii?Q?XVmVkgfu86aRIcpUQWfTQLZQ7Y/xRMcfjwr+fmUZyrB+K0D3eph9W2KoYDbL?=
 =?us-ascii?Q?bm0dIqGGyJWvzOyi/37nToicAnxn3kyYRRMmke1FSBb2EfRBe72ZaBUBx0W8?=
 =?us-ascii?Q?2rnefO6yfjZwf0d6hPNa8gq9EwZBj3vMd9Opup2HZoTt3jC++JqX/lDuLttg?=
 =?us-ascii?Q?3xo2zfCD3EViJoEzIPtgld1uzAkIWYdtV57MI7pnpTAswGpmn4r92BCh+iW7?=
 =?us-ascii?Q?nFl/EseGCQAll5UEqxb0BCCJHj9RyvRkk1NLqRHtMUHzIZcAKzHlOykmFGFQ?=
 =?us-ascii?Q?ggVJFxGundtZuFCSBh6JoYTDT+ijbofD66GwRVO0nC1tN1XNYqwNaKnY8UKB?=
 =?us-ascii?Q?AmVj31dVqa7Lxu3FHn4P/ap4meyreiRdr2d0VgMptwm16uGWMul/MzZ7lZw+?=
 =?us-ascii?Q?ad6xZjTA6HLkNI4/NDEBe6YqheQBEngtV1wCgMX2xVOvOaRmwukDpv+0vPAB?=
 =?us-ascii?Q?Ldx2kXvJ1HtV0fXCDwMqKxddu0XpBdI1bOhjOJzIcjneaD8taQaftvJ8Viwu?=
 =?us-ascii?Q?1J775sQjdvfimFl+M/q17a8noM2xa/TRuq3W4TP2RlcEJZbXEaEK1usIghQl?=
 =?us-ascii?Q?2uT42kodIYvnIW4WWfuIoOkshK7JJJSvfc/O0cVVNC+z+Fu8xz2VWr7rsk/a?=
 =?us-ascii?Q?4wtjATbeIQDWIhiESoOiQyTFBEI1PewD5SqVI00Xd7jWgMXXkCLnghAOPlu2?=
 =?us-ascii?Q?yP2vZ3zIks64pA0t3G2vcSGhdfBOIGL/FN7gkPkmce80wSU3nQLHcuQbi+Ah?=
 =?us-ascii?Q?2PXnCo4f4bWDb2gJL0RvkLo8HE8kksa/8Vx4TrQc1utNp40jo01xDGWbEy2s?=
 =?us-ascii?Q?WaimqXaIQvnTxCMXMD5yuSPCqxzU4EGxyHAlf6zJFgCzZrUI/yG+vqqu2veG?=
 =?us-ascii?Q?tcOm5ASyY1vmisFLxdQ9gya26nD+WEpVlYaTePnEMYbODKMh/U7LFfSfj0Z5?=
 =?us-ascii?Q?bQViE9wFkr+jRSs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:45.0716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d49eab1-9c04-454f-9d49-08dde0b34cff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716
Received-SPF: permerror client-ip=2a01:111:f403:2417::606;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Add the instance of the GIC ITS in the APU.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 6374a8de4c7..d11ff5aaf24 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -42,10 +42,11 @@
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/intc/arm_gicv3_its_common.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -70,11 +71,13 @@ typedef struct VersalSimplePeriphMap {
 
 typedef struct VersalGicMap {
     int version;
     uint64_t dist;
     uint64_t redist;
+    uint64_t its;
     size_t num_irq;
+    bool has_its;
 } VersalGicMap;
 
 enum StartPoweredOffMode {
     SPO_SECONDARIES,
     SPO_ALL,
@@ -213,10 +216,12 @@ static const VersalMap VERSAL_MAP = {
         .gic = {
             .version = 3,
             .dist = 0xf9000000,
             .redist = 0xf9080000,
             .num_irq = 192,
+            .has_its = true,
+            .its = 0xf9020000,
         },
     },
 
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -449,10 +454,52 @@ static MemoryRegion *create_cpu_mr(Versal *s, DeviceState *cluster,
     memory_region_add_subregion(mr, 0, root_alias);
 
     return mr;
 }
 
+static void versal_create_gic_its(Versal *s,
+                                  const VersalCpuClusterMap *map,
+                                  DeviceState *gic,
+                                  MemoryRegion *mr,
+                                  char *gic_node)
+{
+    DeviceState *dev;
+    SysBusDevice *sbd;
+    g_autofree char *node_pat = NULL, *node = NULL;
+    const char compatible[] = "arm,gic-v3-its";
+
+    if (!map->gic.has_its) {
+        return;
+    }
+
+    dev = qdev_new(TYPE_ARM_GICV3_ITS);
+    sbd = SYS_BUS_DEVICE(dev);
+
+    object_property_add_child(OBJECT(gic), "its", OBJECT(dev));
+    object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(gic),
+                             &error_abort);
+
+    sysbus_realize_and_unref(sbd, &error_abort);
+
+    memory_region_add_subregion(mr, map->gic.its,
+                                sysbus_mmio_get_region(sbd, 0));
+
+    if (!map->dtb_expose) {
+        return;
+    }
+
+    qemu_fdt_setprop(s->cfg.fdt, gic_node, "ranges", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, gic_node, "#address-cells", 2);
+    qemu_fdt_setprop_cell(s->cfg.fdt, gic_node, "#size-cells", 2);
+
+    node_pat = g_strdup_printf("%s/its", gic_node);
+    node = versal_fdt_add_simple_subnode(s, node_pat, map->gic.its, 0x20000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop(s->cfg.fdt, node, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#msi-cells", 1);
+}
+
 static DeviceState *versal_create_gic(Versal *s,
                                       const VersalCpuClusterMap *map,
                                       MemoryRegion *mr,
                                       size_t num_cpu)
 {
@@ -474,10 +521,11 @@ static DeviceState *versal_create_gic(Versal *s,
     redist_region_count = qlist_new();
     qlist_append_int(redist_region_count, num_cpu);
     qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
     qdev_prop_set_bit(dev, "has-security-extensions", true);
+    qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
     object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
 
     sysbus_realize_and_unref(sbd, &error_fatal);
 
     memory_region_add_subregion(mr, map->gic.dist,
@@ -499,10 +547,12 @@ static DeviceState *versal_create_gic(Versal *s,
                                GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
+    versal_create_gic_its(s, map, dev, mr, node);
+
     return dev;
 }
 
 static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
                                DeviceState *gic, DeviceState *cpu, size_t idx,
-- 
2.50.1


