Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BA8CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0e6-0000M0-DS; Fri, 12 Sep 2025 06:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cf-0006jf-Fx; Fri, 12 Sep 2025 06:03:17 -0400
Received: from mail-sn1nam02on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2406::604]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cT-0001KI-9u; Fri, 12 Sep 2025 06:03:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzmV2Zgc+wey9KK1vI616i7Blm43BE1A8V4X6AO0cvHynUjuI7Vrm8FpIj7NHzV+T0W0mxIPaO83Gl7iSpm+CIVvJYMnywt60rdP2BQzMgExiLgYy2ssKKyqz8WbWhj8ZZnaTRpujiWMO5JSG7yvrQYq//pi7uD/oKywVFyxAk/2/PqJpcnsQ5vyCpnUZMuDzL6a0XXx4BcxnKA1zjWczUW1J37lXzWeaXJZoauxowrU9UN3Wvo3oPKqT2I24TFUtKilTqtwLB2j7ZMdl23KIZWEyY7NJM9cqPgXcJqiMhUIn4/zhyap1r86Fk4aIpbJKlvDy9CpAQdoYxeeo+tUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL0HLo6fgkjZuzfK6SKgZyWYR+8hr7wJ4lMUO/Evj+M=;
 b=J8r2FT8Tyv+40WydSphpj9lybLBUwpONNrvc0roUCaUcuQtJcKrVjabT2OEZTWBfHlcVrvKUDoVH/SMtvs6G1kN6ZlmTSS2Nd6L+qIGnZ4ledS5AFP6+L7GLvEyZyCSVug+ZgVvo1hIx/XBUaWaUySIh6XNsaOP4msFprnZYH5i/4Zpg6bZy9IuwKEwW1/h770h7MKzbEQr5obXuTbHH66PIpP5VlCJhWl6cBKtNVrTKMPXmu1gfo1UtrOETEIGMofPh6+NGIWA2DS4LtkbfmMZlWtkIvf0mXqFc/p+L0l1pmQw1gHD/XeHsNGNzNk4yZ3bk+WQSfA5rTXE26VndhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL0HLo6fgkjZuzfK6SKgZyWYR+8hr7wJ4lMUO/Evj+M=;
 b=uWtEC5h3h2yGr/ECBJL3ES/Kj9FXbZk2e+c3Mz+mnd0HMoz5lXF4qjnkz8QLvuEGcCOm/xZ6oN3tHjSOrEJKCayv4ZW2D3hDl8Ddh2NXUee3Fk2MLH8y+ShZfiPyW2SLj4Y+pjRTezj6CCvjRjepj9nSu+YEja5aPY88hU8BZCg=
Received: from DS7PR05CA0023.namprd05.prod.outlook.com (2603:10b6:5:3b9::28)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:59 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8e) by DS7PR05CA0023.outlook.office365.com
 (2603:10b6:5:3b9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 10:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:03 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:02 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:01 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Francisco Iglesias <francisco.iglesias@xilinx.com>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Alistair
 Francis" <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH v5 23/47] hw/intc/arm_gicv3: Introduce a 'first-cpu-index'
 property
Date: Fri, 12 Sep 2025 12:00:32 +0200
Message-ID: <20250912100059.103997-24-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: af1fb954-faa6-4f10-63e7-08ddf1e38dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X0VapExJY7u6wknGPEBeJhA4YhQt6ijxWeyGblHXs6s6ZQjTUnbkX2eD8BAy?=
 =?us-ascii?Q?UJPvbBEO9BL4st+S4QOR9SNDVewdN6f9PnOCR4E5vePl2TTTWM/Ddl3Hn43M?=
 =?us-ascii?Q?zMi/JgKr8Mr4T0a+2fK1esBNfRBwCXs++fodhYkCJd5xyis8Xx1WXYvC6hOZ?=
 =?us-ascii?Q?diYlsskUQz5vevC7t5Gl+JTgyTebqlTxGwNAujl26QQgPnXv5VwRpAykJ+im?=
 =?us-ascii?Q?bowB/tjHKh/goHSP0ToSeMmp1L/yP4MYCg4TNLDN4XiGiTsy2ap3GxggnCmG?=
 =?us-ascii?Q?/4xyi2/qEH1ltdpDM9EwVmg0XihXHVawu7Y2aiCyfsBpBjAoKsuDJlaNwisf?=
 =?us-ascii?Q?xSt6dDyH2PDA/q+k4+tckk9bKjCpu5Khwrq9t4nAg5pRXRItqTt5btL/lbN+?=
 =?us-ascii?Q?Wd0ENYAXJXJF92m2PAf43w0d664S99ZKOIIDT9GmRWkNRLz3+wQO3ok2I96O?=
 =?us-ascii?Q?86d6yY3z0+D8dFO1vt68mi3OL2TXPh3ZzjOkRjeu4VppHo2YHixPaWle8cRl?=
 =?us-ascii?Q?R8M54npKE0GOGh9R/NYfN+LzTEB3Yzuu/Ak5ti5xNfss6x2ZtYwPXIzAKG54?=
 =?us-ascii?Q?30TeEGJKVljec7xyfhcftcEcSW8Og4Mpp/vDO8wlrdlkBcV0VY5lmfdx/LUg?=
 =?us-ascii?Q?+yD+5cvebROg0H8aX2bdXuwePlau371dqRZkxAcTOF09nxf/ODYXg5pvIz5c?=
 =?us-ascii?Q?q3l14t7HDlsJ8vB370LNPicbH0Orw4LWHMLAdOdjqg4ZhP1mx6/1j5buhuPI?=
 =?us-ascii?Q?uDhvM+gQ9dJJyJiVLxHxJIQ+FOkUDnKo9r5ltfcnoJiru4LHk2hHnMfK6Nkm?=
 =?us-ascii?Q?c40EfRz9KJynudT1dYMindCWUEeC/PIxgmJQDjtqkQzQWb/QwwAvka0LuisF?=
 =?us-ascii?Q?o1BSeqqYr/uqlLMb2J8IMnc4mkRGwVIsiAcjROAXQcVhRe9MtKyDJrjc2J9i?=
 =?us-ascii?Q?a3SmD1MujC+2zg+HfwLTsgAHlLH/F+NZaMIHjVmQl4lRXj9JsonJey0HaT30?=
 =?us-ascii?Q?2CKoqJL4JoeMICox2u+Y7UBhTLyP9q+h2DLolh35S9WJMklOSsJDkaXnPIXC?=
 =?us-ascii?Q?MhCKvUJrzm7OsHjXQgRIlPdX2iuvC0jPD0HJZW84lOU9DfZYVOWPhp0YzSa9?=
 =?us-ascii?Q?ykNTqX8yFuZiAeBIGz8NjxuwgQXkRc3PGJ7ElKeInQmwpFDHxyKxkgnL216D?=
 =?us-ascii?Q?TjCR+XYakAAM5/aHlQZYbdHNOO4EVfdqWOVFE18snBE86cf5djKgN7dB+n5S?=
 =?us-ascii?Q?0PiW6Z+/BzFaoOiUhAdOiy7ciQVPbJehQ1pI9hp95cJBnr4YJfI2xJfDK/ts?=
 =?us-ascii?Q?jj0MZttdQ2Mutz3xuIh/9fkJ9TSX7IW/H4dqsss54QMG4no4au1ZTgTTdsB9?=
 =?us-ascii?Q?MnSB5pjh0/VahQ4ERIuce/knDyUqTw1vDBO/DDdjMCIitC+b8JK1wdXwpaQg?=
 =?us-ascii?Q?2DFFpC0bW4xn2h36a2koClkdsKk0y8tUQwF7YFhmIdyjroWbDe68SmMxpDR0?=
 =?us-ascii?Q?WJGnInYYdfT/69FsV3VQfrz4I70k9Wukwsse?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:59.3621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1fb954-faa6-4f10-63e7-08ddf1e38dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
Received-SPF: permerror client-ip=2a01:111:f403:2406::604;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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
Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
2.50.1


