Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D9BCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4ys-0001px-94; Thu, 21 Aug 2025 09:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yS-0001aE-AM; Thu, 21 Aug 2025 09:05:01 -0400
Received: from mail-dm6nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2413::609]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yO-0002yy-51; Thu, 21 Aug 2025 09:04:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyPqCPWmkMAOoQYNUG/zd88u0GIZ3yX2Q4Iv1yYFLeYWNogpzTPnRhJsAdIv2Brwn2Hx3KoqLaRPpMG0QDaKO91irNH4FPVnKw5S1JEn/QopeDMrvjEt2ApTP9AzdnYUB8LXJx9rQ9R3RCyvlTF5u15PvfthLhvCe4xbvDadHGFoporhJ9lfwxhsvcqIytGH/cfLNTlZWD1dP2aLlaVfo5omSrD0eO2mlTCkfHEqzlhsooqF0th1WeYY9aXmCmBVMvGtOr1t5zEPiXhcVlTCd8hn6gLLb3GhCi9nJC9udaqusPIXEWlTA36j3RS9ODVos7KTswkhnOI4nObzArT0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/CiR/m0QYVHPXUrZ/QhRA+nHd23OFFeJe9NgJ9UWaM=;
 b=LNya3U3ueb+Kwa94fI6U9WuP+uvAcIdvKpRJ+UBI4FP2gqU0gkXIUUgP/d8atBujtu+ZCkJOEx9VfFkaTOYw4Nu+A8q5mjs/1yJOqFgHlt2zHpnFftP6VdtpjZM+EKnf6TfxbDk5n2OUjmNb1gnXYpH8W1pMeaD5WvLg0Nh/ap3hDv/fhKeBj7dOXVX1rsJJbpuX1yR7dFtrC/QmFh/dzvIixOqqrlo03NngUCRa4hZKVnCy3gjhF6Drawa48DEl49ILLVFcdPEsZASaK6qkZg3REfAoo6D5aazzmDllh5xkumdlahvXmCmzLpUB34rxOXUJZ+yay+gt6e01qlmJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/CiR/m0QYVHPXUrZ/QhRA+nHd23OFFeJe9NgJ9UWaM=;
 b=epos1f+SIXNahJj3trl6t9py9drK0j+qCnkIZpHC97E8oNHJMcrB4sfjYmV+YVPm25iCZTUSwHX4pmXJr1gxiEJxUcZDSA6JtrdHtghg2S2EywEujUdXz2I6OEUgivvaKoIN1fGq9bmTQZPGFb+qBFXiFs70MvE/munfmgsrqmg=
Received: from SJ0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:33a::25)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 13:04:48 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:33a:cafe::2c) by SJ0PR03CA0020.outlook.office365.com
 (2603:10b6:a03:33a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:04:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:45 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:43 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Francisco Iglesias <francisco.iglesias@xilinx.com>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Alistair
 Francis" <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH v3 23/47] hw/intc/arm_gicv3: Introduce a 'first-cpu-index'
 property
Date: Thu, 21 Aug 2025 15:03:22 +0200
Message-ID: <20250821130354.125971-24-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 122142d6-f7c3-4233-1e35-08dde0b34eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/OEhP7h+X1IWyqTMajJy0iowVKzZFLp6BBsmYfrc9zvQ2BqFDaff9MzpdTFv?=
 =?us-ascii?Q?9V1rbY9NJS600Zc0DglN9YWWbKlJ7WceijOF5GSIbB6xIW/4Scoig22/UWbY?=
 =?us-ascii?Q?yeZbJFIpZVDt8aP4zBm2z0zg83O0K7y05eOko6JD7Zi9ipM8nBqiSEY7fVkp?=
 =?us-ascii?Q?KThF6Gb9w5PItoubpYxoWxFbdkhni8cOXQdk3PQkA6HZFph01RadLzRrKVzz?=
 =?us-ascii?Q?qJ5TX3rMtNVr8mXZ39zg2anqtAXLRMk9ccSZCVjf+6qGjiz1HMw0mnlAmoyC?=
 =?us-ascii?Q?3ttuudYABgQsJRSTlO4ZbUU8Ns6lQHRUYzxSrZatbLBbI79MoUuFMV9TmK7j?=
 =?us-ascii?Q?JYxFw7bNsoaWXY24ViHZAlhhN33TM9pMSmtT5j69VdJlzFK3jHq7E+FFYBge?=
 =?us-ascii?Q?uepYkjQB9nBTnxvVs480cf1rT3grMozYXYLWUOITVnRjkAVDGlsXhg13jw3E?=
 =?us-ascii?Q?p9beqKeejm48FsEt+gFwn211X1bo+iagTZDIpBVcyVbBH3toJF1yO37V/CyX?=
 =?us-ascii?Q?Vc+M3vcp75D2nKYAyyQqkuNaEMA6usL2rL7LXt4nfrV10oGThxJxl5HiykF8?=
 =?us-ascii?Q?UkICNmTlJ0RAA3doZTUlwkeWMiYVaKPm4aL91LK4tqEXz4ImoJJxSqlOrobJ?=
 =?us-ascii?Q?YI9hVqeA21plXgrEoaCJ3d/5c5PwIVPYCcvBPhTUdZzmszRtbnnwzyoBtaNh?=
 =?us-ascii?Q?g+t90QCTXdI7J93BPOulxS+H0FzaYN+/o6j8WsFM8HQ/4xYy6Dci0ZUR7BG3?=
 =?us-ascii?Q?bgb7R+xaSlOFwmxD7hDZZGsU6qwhtmn+H1+peIciQhXaA3k663vUahpLVe9j?=
 =?us-ascii?Q?t/DR6kvy72zKpPo9Nd1sdHbtKtBFsoGIZDGZZxSVhvcSdKmbeM4aj0zb3ofS?=
 =?us-ascii?Q?O1gTiZBTYcu0qGQwdlJjBa/yb+DGzAfTJGv7OSDRBItT3ZDeEyvEowNZ6xVy?=
 =?us-ascii?Q?8SrdLY5QHEzbKf0N5cLDhZYHnd2otc3y8C9n8M3hoAxko6Yuwey+aNj6Xcby?=
 =?us-ascii?Q?uw3qh/Rep6lyFvreNJnmEMlUVfn2WcpPzI5kG4Cw5DocYAy96Chtz22s3FRC?=
 =?us-ascii?Q?UVb8O2sAnekgf2RktoDalFCbbvWz7rpPonSg5Ic+nRNVkzdk+6mqsouvSpNR?=
 =?us-ascii?Q?FLMUMwoGHe0bo6aH3t0XWTR78EIZJVtnMZ+MXsw8zY0XCVWL+1xzR9NnCNt5?=
 =?us-ascii?Q?wcyCiBbReEPenu6q4jLgPgzgwyYcb0miIDcqNmApEwX43JsQKhXbUQjVIs6z?=
 =?us-ascii?Q?Thh1VOORZt0KQ7a69YA3aTnD921kz6dQVdXJV2NJpt+8T1PJ4c/OPr/9ESLx?=
 =?us-ascii?Q?ZbDRFFGNP2gJrwOysha3+qMKW0y7sBgjheCn41pwWMORBce7sszaJvyLoKEQ?=
 =?us-ascii?Q?6HJJCpZdXpgrUX7X1PnJw9DRYd3WVS8T5Kw7tfHUjCbG+FEsf6mRKycL0PmQ?=
 =?us-ascii?Q?unznJh7VZ6IzbTfesT04k260U9UFZampH13vI9T+GDQcDcKSWYYvvQOrRuXV?=
 =?us-ascii?Q?TNbqORxqvqIdrfms9kxo0jsQK5EJO3VsD7RH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:47.9581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 122142d6-f7c3-4233-1e35-08dde0b34eb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
Received-SPF: permerror client-ip=2a01:111:f403:2413::609;
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


