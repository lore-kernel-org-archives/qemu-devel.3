Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEDACA0EFA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9y-0004mw-V8; Wed, 20 Aug 2025 04:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9u-0004jN-H2; Wed, 20 Aug 2025 04:27:02 -0400
Received: from mail-bn8nam11on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2414::611]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9s-0000zy-1V; Wed, 20 Aug 2025 04:27:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIJbmPu8stTehTuZOsrkEe+5fDuhlyuOHs1yDbqO4j8ISYb/7PT2CBE4GKWttD8iZSnL8oDL+bSt0caYKwuPiIPbi9DLL9jc8Y7BtsLIFfFws4SXjSBr4lsYpnrNhDQLGn6UXSICiJuDwHCjBgalhnkxcmheDeoBbPExF2wvpatLcW2HH84x4b8eAGiBv1Bb5RoE+Jm3Imzgwvo49tTEttznsiSjEi+AsPZoezqk3Fivw0I/E5HcxOjarLY8VkgWI5H4jVBfmICFJgyzjkP1o2NvZLNIjjLWNmgbjlhgxUqBBQpHqzGzOOG1Vt+BTliu4JUGAvbZ7no9kBkvF9E3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/CiR/m0QYVHPXUrZ/QhRA+nHd23OFFeJe9NgJ9UWaM=;
 b=iOrx2JF8cq+ExCO9gRPA9f0TQnNzhjKrVwkE6HH8IjmNIlCtJijOgWGbJx5K1k1gH4ivbMkUko6jAfwAtO+W237vNc6Rvd1HAqffdRF/lNuo56fDhXUV6Aajoebjh1QfONZx0dzMfZVuccwUg9VHjdrKz/R09kkROFoZFaGEQVhdBuvnZsIeh9OY+FlLfoYLyPuL4GY06SlfqA6pUTN3gk3SL3Ln1TZYGFpLxcoloANzZQ7/77ZkOrrawAgRgH+33k90do0Tm3XfVrV08xPiVRuWjWyOfHv22FzFtjmW6ypQ4jdiCQJzU+YajkTeXRBzvc6BbCz0LiZ/9jo+VglaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/CiR/m0QYVHPXUrZ/QhRA+nHd23OFFeJe9NgJ9UWaM=;
 b=Ta6zDg1B1MNSHenPUlWR9DHhbj5617rP0kNwrm1NYimkZvl4VB6TRDqJ13vYQUcCfSUEiW8dIS12+DZ76Qg3wbzxVdaa0IXQy1A1HSbTDQznypWuO36xVHEIcsxA/e4Vj5mTj9RdUI9tMyVc9RO3TuJfFh9AdS/lAWgAxJvjx6E=
Received: from MW4PR03CA0093.namprd03.prod.outlook.com (2603:10b6:303:b7::8)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Wed, 20 Aug
 2025 08:26:54 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::ee) by MW4PR03CA0093.outlook.office365.com
 (2603:10b6:303:b7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:52 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:51 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Francisco Iglesias <francisco.iglesias@xilinx.com>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Alistair
 Francis" <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 23/47] hw/intc/arm_gicv3: Introduce a 'first-cpu-index'
 property
Date: Wed, 20 Aug 2025 10:25:22 +0200
Message-ID: <20250820082549.69724-24-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 1814cfee-d733-4d12-0018-08dddfc35214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MCYZOrAxP4pkw9W8PxFpRj3G4w4XA568iTYXCH9rTrQqO4EIp4Xsy4Px9NHi?=
 =?us-ascii?Q?fXn0x7uiFGFW3PAut5FHDeAfg/lNaIIFVtPO05CGwtPp8E33vMUTyzUHdei4?=
 =?us-ascii?Q?zgeSmTx1RfXPveMSe1Rf0bLTbcgXGd+VvMPr8zcZJhjSeuh9quv7Z5lyIROq?=
 =?us-ascii?Q?zg+I+OiMae3FM4XKYyvREMTH/jCMY7uWFCuG8tCirmQVugTdwDGsI6djvuWs?=
 =?us-ascii?Q?eX73QHk/Q8lQKtHkTkfx5um+aargFu8ejgBpESLdbCBNjJwmcWFRx90DEnEo?=
 =?us-ascii?Q?IgbIIxp5LZiewQrVc8B07VGWD9KWNGmpCsSaNjWovQ5USkJHTLMQNuLlBO/T?=
 =?us-ascii?Q?MaACJwzuu10y9YKExX32By7hrK48uzdQpNwL2aEoPH406flmKc4cAkkw0GEh?=
 =?us-ascii?Q?7cGEU+tfs4yQnwJMyiQg7QO6d9x4zDNLsPaTaM0TMmgCRtrEV5axX0dJre4A?=
 =?us-ascii?Q?VniVVQPZf64nSkiuiuKka/a65XHPvlxnvF7Wj9fLDN6N22m7UenA0srH7c/4?=
 =?us-ascii?Q?RfkOw5Cb9X9UMrWVvGnr9P7CpVNHVOUcp4RuteiBhEX1tITNZK98pGamSdy0?=
 =?us-ascii?Q?RsHkKwoBwU1qwHmid2/5NnFd93c8QnEMo7Lg+rTI3mq2CtLIxgmAFkZzBMAV?=
 =?us-ascii?Q?NZ2NzJXGv/BWUXElTF0UBWHN3GCwkd1AjehGOdT/FyKrMUGJdc1X3jC6Aakw?=
 =?us-ascii?Q?y73ww5BwrBKGiZZ3VO1bj0/aa0qXz6bjdu/BsiucS0GcrU9ZHiXm81Zucabn?=
 =?us-ascii?Q?+cGBTToi8rigJEoL4xkSSAemJSCjCpo7PPxlsXOmmWtEhH8fPn7HKdz3Pp6x?=
 =?us-ascii?Q?HTwSOg7PuzlVfJrDNH29JEKQVHt3uPEkPab7zhaYlQoXcX8uIxj7X1haVHQG?=
 =?us-ascii?Q?YrpiQSSaiehfCJv5JjUbT+0gzTUkiFR/KXLdCuch26qgEBt6lVu8LTmK9uB9?=
 =?us-ascii?Q?Ql+KbFbiq1Uo1gR9XTGiBinwERpcomKKwE4CHaQWZi8f/B+s9q5nb0guW13f?=
 =?us-ascii?Q?VqjmW4hcGGaa9NCcQA0BqbrP9y/+FA4VYHljwd8du2j13WYqrmk6vxs8oZug?=
 =?us-ascii?Q?zQg82S2IANGdE4Y7wZyj7G1mfM/WSwimC6rv9bIP6oTbLKqhBghQhquCZ5bo?=
 =?us-ascii?Q?dHTFcz+dCnqUdi9+23nNvicVZM+VnI2/wZ/8fU1CBZfhKtQzi/GnIkLKf2oi?=
 =?us-ascii?Q?hnV6YrNwuba3+oipVmHqgyB9EULlhwfHLhLB1FMf2AWBI7uxXzcpzm09KbO9?=
 =?us-ascii?Q?fAfuiMpT2C1v/K1tq86osu6StN/qgqFRaUrt2ogh+boqAw8zTttZaM3s/nlW?=
 =?us-ascii?Q?I0+e7CrrByCuJTM+0QqBowtkQto001g4XJ5xOxxPhBTPwsnrxoMVseEVcRZk?=
 =?us-ascii?Q?CBXUbqaJUnCytkpEGQC9XKxna4l47rm9Pgu6JnEXpd8jcs155G3iQH6gbKdk?=
 =?us-ascii?Q?gK7dwUxS/CaZ/2FrFLUpco/643twflSpDhYaJXitJBl/2hTINyXKpIZc3Yk3?=
 =?us-ascii?Q?SBMuZRMvEjkkpobrdglJfw4YjE5g603qYgRY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:54.3797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1814cfee-d733-4d12-0018-08dddfc35214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
Received-SPF: permerror client-ip=2a01:111:f403:2414::611;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

From: Francisco Iglesias <francisco.iglesias@xilinx.com>

Introduce a 'first-cpu-index' property for specifying the first QEMU CPU
connected to the GICv3. This makes it possible to have multiple instances
of the GICv3 connected to different CPU clusters.

For KVM, mark this property has unsupported. It probably does not make
much sense as it is intented to be used to model non-SMP systems.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/intc/arm_gicv3_common.h | 1 +
 hw/intc/arm_gicv3_common.c         | 3 ++-
 hw/intc/arm_gicv3_cpuif.c          | 2 +-
 hw/intc/arm_gicv3_kvm.c            | 6 ++++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index c18503869f9..3c2ed30de71 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -226,10 +226,11 @@ struct GICv3State {
     MemoryRegion iomem_dist; /* Distributor */
     GICv3RedistRegion *redist_regions; /* Redistributor Regions */
     uint32_t *redist_region_count; /* redistributor count within each region */
     uint32_t nb_redist_regions; /* number of redist regions */
 
+    uint32_t first_cpu_idx;
     uint32_t num_cpu;
     uint32_t num_irq;
     uint32_t revision;
     uint32_t maint_irq;
     bool lpi_enable;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e438d8c042d..2d0df6da86c 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -434,11 +434,11 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     }
 
     s->cpu = g_new0(GICv3CPUState, s->num_cpu);
 
     for (i = 0; i < s->num_cpu; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = qemu_get_cpu(s->first_cpu_idx + i);
         uint64_t cpu_affid;
 
         s->cpu[i].cpu = cpu;
         s->cpu[i].gic = s;
         /* Store GICv3CPUState in CPUARMState gicv3state pointer */
@@ -620,10 +620,11 @@ static const Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_BOOL("force-8-bit-prio", GICv3State, force_8bit_prio, 0),
     DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
                       redist_region_count, qdev_prop_uint32, uint32_t),
     DEFINE_PROP_LINK("sysmem", GICv3State, dma, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_UINT32("first-cpu-index", GICv3State, first_cpu_idx, 0),
 };
 
 static void arm_gicv3_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 4b4cf091570..1af7690b958 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -3022,11 +3022,11 @@ void gicv3_init_cpuif(GICv3State *s)
      * registers with the CPU
      */
     int i;
 
     for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
+        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(s->first_cpu_idx + i));
         GICv3CPUState *cs = &s->cpu[i];
 
         /*
          * If the CPU doesn't define a GICv3 configuration, probably because
          * in real hardware it doesn't have one, then we use default values
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 6166283cd1a..e6a09c9b7d0 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -807,10 +807,16 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     if (s->nmi_support) {
         error_setg(errp, "NMI is not supported with the in-kernel GIC");
         return;
     }
 
+    if (s->first_cpu_idx != 0) {
+        error_setg(errp, "Non-zero first-cpu-idx is unsupported with the "
+                   "in-kernel GIC");
+        return;
+    }
+
     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
 
     for (i = 0; i < s->num_cpu; i++) {
         ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
 
-- 
2.50.1


