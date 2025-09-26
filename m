Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24F4CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22aI-0006b4-Uy; Fri, 26 Sep 2025 03:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aB-0006Rp-0I; Fri, 26 Sep 2025 03:09:31 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zz-0006cv-6e; Fri, 26 Sep 2025 03:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/cEvj5ZUbtzNM/qfHVXBijVQvthlJbQaRJ3lYQdxbJwmXCkyI82IE0ZuEGerMg6eLpJmhGU5JCMShlQAF68x2LDAgzrl7OY5ULwPhwDKZxT7dABAr6I+O7oHBmb05SH3ynI1EPZiV9yum0BP9AT4ocXYvF8dV+X0pYtE0VVUY1LwV/trkIzatp4RRwcFS4DWtXtglXt6NYsRxjY4zUw9AQUBy8P00sTOFFV/1TiTX7RZlDDca1EHP/1LvstVhUVmvTV2yz6o38ebNPH9vXiSk9CBKSrhPjPb/Pqm5SXp0YShX9qDwyI2vE6OPMEgGZKllOOk551VSECzR/iL6Ucuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkRodudH8Jye8paCMNL7PBlrhzURZlDkKjEwTybFI/I=;
 b=RO0ivUthoQu/aohMbSawba2FOFg3M0Q6EKZCdces9hSiivWIiJI2kaztD72vHhpWyeclJ4oUfQ/pSMaMYavUJyQIScENPJDYbtWMnKNtPbQLVCsMRS8nIzqhlfnnppr8eMmVwIqoqHt1x3RTRtKM4iNWHRMX3WefI4y8TSAW+x6+R174fuj//JO/G3tJ0bs+IZaABThmzOYqCGHyA1IFkIanLvQ0iRFdDXzWmCbNQTCv4uOXla1oUGni5mvsPFS2mkDVHg7GNJv+owzCyP8VNCKOpAKtNYgLHBgCi4CQT4uuvzKYtpmcUZgH8h76fBTbQuWgE4BiV6g6KMm7r3w/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkRodudH8Jye8paCMNL7PBlrhzURZlDkKjEwTybFI/I=;
 b=tLyIwfNtltvwKjU9z4PKRTl7W9ft23/SYieUBkh6qNowC+e2KJIFNr8fdHMdSRnyA6KS9b3ZV+Yg13Uid3a4MPZq0CrACPtTrqsLYKFUHBDtWW9BbavmlpZQAvM3YkMtMy0HlksaMxVU1bG2M8urk+UwAGt/Vg0hVNVIIeHFH9w=
Received: from DS7PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:2a::25) by
 IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 07:09:05 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::3) by DS7PR06CA0007.outlook.office365.com
 (2603:10b6:8:2a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:54 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:54 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:52 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Francisco Iglesias <francisco.iglesias@xilinx.com>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Alistair
 Francis" <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH v6 23/47] hw/intc/arm_gicv3: Introduce a 'first-cpu-index'
 property
Date: Fri, 26 Sep 2025 09:07:41 +0200
Message-ID: <20250926070806.292065-24-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 6756fa02-a23f-4fad-8d24-08ddfccb94a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nck5lmXMkbCtyZ0/Syp2ZJwiqMYaWhhSXXz4Qz7BlK8IvTsBh3O3DiYgZyAR?=
 =?us-ascii?Q?mfwN44nNM8hi4NnyHHn/tqCHajY2t84sJtP4Fr3dQcMufmLUP4Vli5qDueMn?=
 =?us-ascii?Q?8LHaNnhcQ07UtILOIjXRrBdzj2tinG46Hk4fa+CgTKwSzoXQFfjzlQN/SM+S?=
 =?us-ascii?Q?nIJOqRVbTN2idMnNbKDuhtbynZeiC/ySiL+u1EQ9SEBrPjMgk67YwhUiR0/K?=
 =?us-ascii?Q?zhW3l7zDfloCXFsDoSoTr1ba8kSGW84lGr70SZe6blrBmMImKf1n4vhPswIt?=
 =?us-ascii?Q?KwDwZddmng69ug43QR/xesLrN33VgcgqgXiDJg/qauDJaJ4pC5FKA7/FR/rq?=
 =?us-ascii?Q?I9WssO7/Vpqs0VUqUJAoeJ/EGrhiQ4MnFwbCeZg9guHjfz8SFqFHo/Q/1rGj?=
 =?us-ascii?Q?8ZBzdYTujL1PS2g96Ak+M4jww6Iqt0KF1lF7mPUAi0VubT7xHSQjlKHsZpRR?=
 =?us-ascii?Q?OuBY/6IwSp2o9wicQ4w3stYLZLyd2BeLpLE39rVrPQAWQoECT7AmdLYkungq?=
 =?us-ascii?Q?rqXDVXQjgdWqTZ97UrNz3r68CLbJNwFqmuu6waL7hrY9x70fIJtLxgeW+Ynb?=
 =?us-ascii?Q?5+XFa2FZtaZVYPy3dIsAFWtoiq6HGivx5MLUPZtlX53Ip4bQH8sToipD9or0?=
 =?us-ascii?Q?SGFLE8SNyKQ+8mJRrC3bEknpWoNBkWc14gWzwwe0vkkFioalQ3nFeLn8gVw1?=
 =?us-ascii?Q?X6dVwMuGGWwx5k2yKRcsbTmDxDduWocg8U+5OjxE9Iy3YiwleDCFlClIQyy7?=
 =?us-ascii?Q?+bMIZ1R1FaytZKWlBl8b8avz0xmCFoaKVJu3QaI5GIXAmNKF2pbikiAYIfHD?=
 =?us-ascii?Q?z2l/AjTvFkBd5fDhLGadntlT8ugdt9O9S1rorh0G+URnLw/5tB2hfi4+/4Qh?=
 =?us-ascii?Q?UXSV8ixby13tNGN/LNC6I2t914syFLVNA64g0VXSEbSx62hdRO+veIdVngPP?=
 =?us-ascii?Q?/GwFmGisvm5YEcT09P2PcajWnJT7eWAgFUlxPMWd9MDScxOpMvReVYTgC9BS?=
 =?us-ascii?Q?6x4h2bo/OC1ydQhPKa8/U+rpPqcavq51i0MAw5W+XDV+lisSmk+69xZAoXdP?=
 =?us-ascii?Q?Mw8jloNGj1OX/lxE7XLIVcWq2iJrchWVmz8lYQ2SFuSKUKLkydsaqNOw0lAs?=
 =?us-ascii?Q?/b/1qL9E5CA5IDUEdnlDjMrPcJl6hRxv94mdBlWnZhIuQPKwPLjsPCdA89JF?=
 =?us-ascii?Q?yTta6N/3TcXwqe4PFcfO+ito9Apuo9+DuHPwOGOau29Ljdnd+gXH9zhN/2Qn?=
 =?us-ascii?Q?Njie6NQen8fkn5QKT9qjVBgi7YcgvYgudVDIXlHIy1ixbsn4HU4UbWTytT2c?=
 =?us-ascii?Q?eo+vnzkkgRBXsGd5lMELYXFwAr6tkdqQqei2k6Q/frptSwFVJFrUvaI1OGNU?=
 =?us-ascii?Q?RBUF7zQ0v1HZWDWvP69w+TeJjU7KtLIDBEwCDCGPAuLXwW3bBfYJsgjwA+bB?=
 =?us-ascii?Q?3rTT2iTrHp5BsGQtv0UQK1MUruHvWcVqoZqEQpL+VT/F8Yj5gel2yaLLtsy3?=
 =?us-ascii?Q?UoqyaUtKZtwhYIsrj2BGQxY7PNQpidoLKrIM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:05.7972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6756fa02-a23f-4fad-8d24-08ddfccb94a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
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

From: Francisco Iglesias <francisco.iglesias@xilinx.com>

Introduce a 'first-cpu-index' property for specifying the first QEMU CPU
connected to the GICv3. This makes it possible to have multiple instances
of the GICv3 connected to different CPU clusters.

For KVM, mark this property has unsupported. It probably does not make
much sense as it is intented to be used to model non-SMP systems.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/intc/arm_gicv3_common.h | 1 +
 hw/intc/arm_gicv3_common.c         | 3 ++-
 hw/intc/arm_gicv3_cpuif.c          | 2 +-
 hw/intc/arm_gicv3_kvm.c            | 6 ++++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 572d971d22c..38aa1961c50 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -227,10 +227,11 @@ struct GICv3State {
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
index 0cd14d78a75..9829e2146da 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -819,10 +819,16 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
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
2.51.0


