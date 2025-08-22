Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8749CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXC-0000L9-3I; Fri, 22 Aug 2025 11:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWI-0007vc-Vd; Fri, 22 Aug 2025 11:17:37 -0400
Received: from mail-bn7nam10on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2009::620]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTW8-0007CV-58; Fri, 22 Aug 2025 11:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAbR+MKMBQQBKwSmS0G4iIxMS8wWnwmSeMmru0lSWhxX5g4Gfks8kZOIXB/V02rg17JIxpz8N+3W6rds35Vb5QbOPp/3EM/C84uPMW32pmSZFDeohjQH4DzJkJYha6taLJpAAJYj0A/GHlY/fi1KiHhXtyJw/3PNk/0n4LzVM9wToRbFTq5rLdd9EqwEJNoigAZcLVtd5OzwS0MLylamloa7/dGqWjTBUHPOEOgoQNbGiVSrA/nkMDYP8qWtTpp6JZyN921JFzp6p3JAOl/SYlxIrDntbYZdKQnB4fDHcs/7q/rziarcET7KCuR2MjBgksBoSWYLv0pjcNaWj1V6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/CiR/m0QYVHPXUrZ/QhRA+nHd23OFFeJe9NgJ9UWaM=;
 b=IAPHSdeKX7Vd9E4hdk1mg3tqTYqmE++fcCWCNBkwo+P19LaUiMo4FjQaWTJ1b+PzBdSVy91MB/9awzCayeFXyzxX0+eNHkee1qs1iJIQuR4g3atxo6Tjv1HGA6VrPIIlGghrfdnTNy2ZRRJ/91rllMMfzVcCIYnJxR90nDZxeDBJA4m4yyMw3NIJts3x6cunNSI9lcwClnMKYNGcrrgbi6XwGoeSQh9NCSdd74qtrRDL37gq9kVU2LnnF2zNP9Yp7Vhc/lNPJeXOB3Vg+rEThx8DjhcO4f2bmIyjMlCw7tSqHx6XUI50rtD75Fs0RU/vfunbDPdmmZfiRYmu1eVIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/CiR/m0QYVHPXUrZ/QhRA+nHd23OFFeJe9NgJ9UWaM=;
 b=U8LxHopvcBMJE7NkW/1x5JI8QbMB99O5JcVkGFla+RKdF8em/4UTWNqckLz6k/hV1ryWsk1JF4yGHC62Ha2Oj35FM03EdfjqujS6BC3+BtC+8A9E0GEcWWVMNPtN1eRjxxCFChhOhwbn+n/LU59Md2+owSup+dvz+YepbdgvhB4=
Received: from CH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:610:32::6)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 15:17:15 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::f8) by CH0PR07CA0001.outlook.office365.com
 (2603:10b6:610:32::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:10 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:08 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Francisco Iglesias <francisco.iglesias@xilinx.com>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Alistair
 Francis" <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH v4 23/47] hw/intc/arm_gicv3: Introduce a 'first-cpu-index'
 property
Date: Fri, 22 Aug 2025 17:15:48 +0200
Message-ID: <20250822151614.187856-24-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: a52e0c50-a8ab-4c8b-2339-08dde18efa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AsZiniGJYqObnmvUM20f4xPZutZN6stkcV11tqvgmiGttcLj0wT1cNIJaQbU?=
 =?us-ascii?Q?XJYld7FZqeLYKZRk8k4ha4NfUzgyZhjgG81vJZ4uikYqK/U65yD2/lMTDgQq?=
 =?us-ascii?Q?YoegP0A8y5aISVbpdJ2YwGDqvkt3hKGIuh4kgd8rAWI14mWUYCn9V58GBskQ?=
 =?us-ascii?Q?XUuS8lFkcc3/LEWja2e4+iVlF9CgPBo6XbmClJs9zeafh2BLgsGRPO0Ww0sl?=
 =?us-ascii?Q?XpBlZc/B7oYaMcJqtW4sfQRVSy6HgX+EYUVDOQR1/JnWvW9MP355Bdk2/G4Z?=
 =?us-ascii?Q?IZ0lYUbY2xyEfZL91oA7TsLmqnF2F9EhPNyqUz/xbXngjXw3duiSP2AyVZ7G?=
 =?us-ascii?Q?gzB6VdM6JxRVVLZYmBu/6VcWz0m9Mdllpj/yHWaWEeg2yPMP4SgFRFAyjTEP?=
 =?us-ascii?Q?O6yVoKSm7i6RNlk9J1kuWxf4BmzLs7L6CZcsr+2km0jcWW9qyeYdS1sLnbYf?=
 =?us-ascii?Q?/DO40r+QMwpa6uIvfD6XzCqP6oBgsVuWenkJrCk6PTEWC6EvX/tzMMzSDnIM?=
 =?us-ascii?Q?tdlFfN0sDhn0jb2HVSzkj2MVMSvbFnMxmv1k7AVJO8SUweTLl1FDpE6u7dME?=
 =?us-ascii?Q?Ip5k0axZ6GkMJMcaCIkVTPe9utMuJfYUFbStGKPY7w+iaUdL5032W0xxwvBP?=
 =?us-ascii?Q?aF+6QjyNZHl0fYu40Pdx1+fDr7gJ9lB+Rqj3D+odOMeTyl6Julk+3XsFSPWW?=
 =?us-ascii?Q?2czd9kazUSgkQinAPO8wZIFw87+8+OzPhrQ9TvFd4VwDLECVzpme2JJA1Vx6?=
 =?us-ascii?Q?VU3sRJJIunGum2RNeQM1Z1tLaCBYZ1TCJk5e52Am2HbkcjO1J+58tBrUcPym?=
 =?us-ascii?Q?iZv+wMJrl/jeAMvt4mNrHwHuKiP2WBXhKm7zpnYVURxP0RGlHfy0xaAw+zfw?=
 =?us-ascii?Q?gtvEsGVRxr0qHCbtLBh1mSuUDV/us+tRWmW8IIYYyE9KW8k0aj3B2iqiAkpP?=
 =?us-ascii?Q?PNJG+mphRmW1dmtOdeIt9aJ8M6BgcLyTt0yKiEb7PGGDZqoSydlsDPO3Eqrr?=
 =?us-ascii?Q?hqDznzTDMkU1cedI78OQ0Lhc9M/c5NG6RFnH83twQdWEdewAbQzzMeK8SqGg?=
 =?us-ascii?Q?cY8pd0QBrHTGy9+T9RyScyOjhlgYX8lLH4j2fDzB2pQI14S1G+C+joAfrYtN?=
 =?us-ascii?Q?26rNSs1UkYHYbAqRDLg8OU1A6JAMmJr6WyQc7mmK0AJNnEcUaIaDi2h5uK1Q?=
 =?us-ascii?Q?I2GcINSzYEB2+83Xs9HH2IpqBARXyF4nQoZgo6Yfl924iH6/qMy3RQeij4RG?=
 =?us-ascii?Q?iQyQcFOxgGVS7vfxds/vh3nCPedEPivPekKd1UotKTqq+39xk6tvFa5C+gD8?=
 =?us-ascii?Q?+oFPadCxeaiAd21VJYVnrQQ6qyT3N0cxhShx+sG80R1/8YgsqviohLYWvnNd?=
 =?us-ascii?Q?1UR6iaji3IzebMBgREAiSkiQAO8gIluLumhmunURI0QW9zLFjXBaJr3kauCV?=
 =?us-ascii?Q?Q9ak4xDlC5MLC1codfz34flYh0ZHVRKUWqWs8EVPXswzdsTWBuNpKkg+mjZd?=
 =?us-ascii?Q?ZcSBCB8s9qkLwC2QqYjY2Oq8ozQlqPwEhiko?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:15.6674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52e0c50-a8ab-4c8b-2339-08dde18efa4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
Received-SPF: permerror client-ip=2a01:111:f403:2009::620;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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


