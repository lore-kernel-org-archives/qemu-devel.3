Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23269CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eG-0000zf-5l; Fri, 12 Sep 2025 06:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0ci-0006u6-Tn; Fri, 12 Sep 2025 06:03:20 -0400
Received: from mail-co1nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2416::606]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cV-0001LE-Ed; Fri, 12 Sep 2025 06:03:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBztXX7DSXWE2ZBiQPpioK3WolpEprZGW4UaepwJTwxVBLHkYbDqkM5tKsPJJ/n5RSTznBciC4elt58q1BHeuzWGrkFJS+0Os9/aRsj//Ez1bMc2WsRE0A6bkZFqVhOZqr4jgkBivcrHc/aMorhOi3vgBZqpt/t3l3rPnG034SocGvJqBws0LqLJpuj7/MszxoDCCQ0hnHdgaPlXpI5DQiMMu3k6p34TacM7v1BB2nkRcoH5qsrg4q/OQFiKFF2Z6N0JZDungoYteBvte6qzqY+nRQNRh7WkMLpF4mm2DWPF2StymsxgwR3c1I0RuxHK3ZCefKmG3qvyN00gfuspDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqgxBZAO8511gKWwPke67wknb/3x0Dt+P+73rMdb1Yk=;
 b=u+lm229wPq82EgLR0A3Z8iXpRGtOcKtuMkaEv3Xbq/jt5GoGuSWSbC4JGzRLYPCFvzsyjzMiepGwGok1wDzel+VLP2D59XkozgrxElvVSS5K/lHW75yxRz6+yfrgt3Krs+ohnYmFi2vOFHaaTaYCG9xX++Gk8/csWbvaO/C6pLtOwBV2IPA58lDNBDBnJG1ie8f0csabLUGhSm/Z1KmQ6ccpWgrkh5w3CXpbIwDMYb6JEUyLv9waRijlOlp0JYGQADn1DlKvdePQQYvfONw+HzcDcrWK1dJ7HbuvKobUjiywyFgSttzPJ1NsKNyELz+VzOi7EHdDkYnGcnIKSK1uWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqgxBZAO8511gKWwPke67wknb/3x0Dt+P+73rMdb1Yk=;
 b=a4hAoYtH5JDg+WCSaBaNyL+25vWP5Tu2us1sLBN4E04JKKdewDTSU+NXG0Hbj7ss63RgENJUQfMkAWs3Eh6vpK/DaWepEXfij69hfedDp9gjtLiR9+DA+cq3NZYa6WaCmISDCirRPGjEkkTabn3cXe1/83dLOdlcQH74heIDEEU=
Received: from DS2PEPF00004561.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::505) by IA0PPF80FB91A80.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 10:03:01 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:6) by DS2PEPF00004561.outlook.office365.com
 (2603:10b6:f:fc00::505) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 10:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:04 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:04 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:02 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 24/47] hw/arm/xlnx-versal: add support for multiple GICs
Date: Fri, 12 Sep 2025 12:00:33 +0200
Message-ID: <20250912100059.103997-25-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: 7206afe7-9087-4024-f0a1-08ddf1e38ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X4ihRSpBCw+xrdDGHXG/NVDFj5TYnH0PsvjDhsZm3Zx1CZ8ZYHgw19hEWtY1?=
 =?us-ascii?Q?6fDT/vVCls6kqwdO784rLXOCO1Mp0acjpnKzaR/z2Ibzpc85e5CF4RLgz7lB?=
 =?us-ascii?Q?kb7UysrwMZqjX2toUgol5UV0t+9Qw7HGZWcGSKIbHVcvfcWwBU/RV1sWjQqD?=
 =?us-ascii?Q?+/rvKCg9gP/N41yQhf8vRRWLcSWEMMrfOjNb+M+4pnCOxVu6UKSrHQYQMK5o?=
 =?us-ascii?Q?++4zmTvQvuxfQ2KYo1buhLc+Pmjxt2b3dAiV8616Na+nZDcD5EDGu18QexbK?=
 =?us-ascii?Q?CIvmkgqaM6Cr9tkPOxq62CDdpdzo2j/9UfkMnRTIyb15+Wfoa70uZ+Dk7WeV?=
 =?us-ascii?Q?nt93Qb6dKrgkYvkDEMmEpZtPKRn3JzurAuDgDtT04Yse5OtyPY83A/6sQEg4?=
 =?us-ascii?Q?o40JgGUma+Z3WB2XNtDfcRvavbKwZN06hp2eVXDiFUOEhSW8f3b1xy+7hPVz?=
 =?us-ascii?Q?WRln4gHrhiU5Yx+yR6Ik6wj6CSppprs3aNe91MNKfb/ahvIAHIw4mJXxYpQK?=
 =?us-ascii?Q?bvlQePxsQv5da6q7fx1rbeJyLm+vMbLtw2sV2HiLUmIj8tjsEUeEotwJaM/A?=
 =?us-ascii?Q?2I74PzMTfzoC37j673JicC+zG3bLFIt0kJhNo9PfCVwO0ji7rSCkORPD8wID?=
 =?us-ascii?Q?2uv/qq7ShDWcjaUlyChGjAQac8rgOmZDgXWbix7ANaX7+pnPiR2jz5w3ZYo0?=
 =?us-ascii?Q?ON6vuEbV2GehYkRw9rvUhgOGgTq1jFcYmgDfVAM9ge9hK/h3BqG66OjBZP9G?=
 =?us-ascii?Q?TBwZnCTJ6DInjAWUT/JwQiDhhNC0j5o/OI7kloQymUldAjTZWK/xHbFogiUA?=
 =?us-ascii?Q?zZFmE7zfQPLz67osi3LBXgmMXVVBdq/agDgIerUtTsdTUwqDPWHEF5mC7K8P?=
 =?us-ascii?Q?b8Ar3qLqtyS35jLu6K4rXxghPrlqiRRfbH+3eAGNuGWFNIqQJ7vGnWvEI4Cn?=
 =?us-ascii?Q?RNsffWWLe0fYc75YRmlDdiB6e7xUnyRl+TNaevAiYfqKmjlBEB2uxMTi1JTy?=
 =?us-ascii?Q?ueLUOt7mZuGNMYaWjuiGaaGsy80rxvdCTZyx+pOKzCU5KgYfT0uGGLNogoSV?=
 =?us-ascii?Q?7dTPIvjxZe+ARfc3DjZb5CJSEVdllA0M9dJdSy1iFbsYqJT2HQ6I9qjJR9Dr?=
 =?us-ascii?Q?Q/m2JC2ZnjAYKh68JtIfIaY7hY1EdnxCPZd3GRvPW1TW09Q3D1TIVDVjM1ly?=
 =?us-ascii?Q?XxPyvthP0t5IflBzWb7TG7aM9R2GEzy/jjDWTR/jtekFvsfB7G0yncHml8rp?=
 =?us-ascii?Q?NbvhJ7xtubf8pg3QDnG70EhOqbHoa5hMLfkJfv4gFWzxKdmn6kvDoEFM7Bx1?=
 =?us-ascii?Q?SnbdSTCMS07eEKlj8jLuhKn/OcJhOjAGtx8vhkJVcmY3A2kf6d5hmHnm3loq?=
 =?us-ascii?Q?SsQrvJszRqdkzbQxi6DIoqYioU5pWhk9qMevjaKFdQ63xgQueIgJzO/X47F4?=
 =?us-ascii?Q?ab9PLyaBPaa5CB2wtFZU21j3an/7FNuxyhgy/J5jZ3E3lp5yziPktJ0ruvku?=
 =?us-ascii?Q?QGHoCSdLe4esMvN3XZKLDqL/UamWZPZQiBet?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:01.0825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7206afe7-9087-4024-f0a1-08ddf1e38ec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80
Received-SPF: permerror client-ip=2a01:111:f403:2416::606;
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
index 6252e0742c4..1c79a3aa047 100644
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
@@ -1541,10 +1583,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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
@@ -1722,10 +1768,11 @@ static void versal_base_init(Object *obj)
 
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
+    s->intc = g_array_new(false, false, sizeof(DeviceState *));
 
     num_can = versal_get_map(s)->num_canfd;
     s->cfg.canbus = g_new0(CanBusState *, num_can);
 
     for (i = 0; i < num_can; i++) {
@@ -1739,10 +1786,11 @@ static void versal_base_init(Object *obj)
 
 static void versal_base_finalize(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
 
+    g_array_free(s->intc, true);
     g_free(s->cfg.canbus);
 }
 
 static const Property versal_properties[] = {
     DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
-- 
2.50.1


