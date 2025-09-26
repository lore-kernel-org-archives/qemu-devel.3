Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F33CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22bD-0007pM-9k; Fri, 26 Sep 2025 03:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aR-0006kn-SP; Fri, 26 Sep 2025 03:09:49 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aC-0006fv-EN; Fri, 26 Sep 2025 03:09:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxqDEuV76Yv9TYcpBKesLlQeUKnMWYeNuklXA894Igz60zHlf2HXruJR5UEAut6qnjFKDzIOvs99vqBZSs+mBhhb+yru5ZyAR42Ax2Xcg6JjzUXa1PK55ho1x3SD9jJ2TAyip7kUXZuTCEFGerp8ehIuNlqCno8+cUGKyGG2qeJYSesO/7UhO0B1OCc70TAblukEUoXb/ckbH5OHea0fCekITyC2wDQbbaG0cDP9pbY55eii20R5KUCT06o/V1F5phLjPGY3HA/I85DeW7Seh7MatnPTntr70GRiXyZOE9pR9gsumd/UUgpBGpzFcovvlcS6ly85jBAz6O+AGS8Erg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewkhA1z+AJfskjZhDIKmjnsIrBCDi0uNVS4+zddpMIU=;
 b=nlleaN7cF+AhxhbfVfkkIRaiaColVLwN4X1XjzKGCtv+E/2Zw04Gr4pgUWt40hl9TqjTrO2QUsjRAGLrB0CiTjB6z9zJa3I/Dmpl/3PE6ErE19/mrSOWco1/i6ofTHTNpydJX/WfraGwPyrt7kx5Um0R8h7za7H8UcE9D2+z1uoxNNBNEXH5zg1UQ9b01WzhXO9eUYBXDU2F5h+HnLc1Q9Ig2KDQClWOXTAXwuVrhAa9kXf+P4uzBLIEhKarFvo2yQsNZiVmCSQWV5YK1t/BRvWu1pvFg2CU2r4BzDCJyvUnW3k4KmG6PgOJC5aF1lSBYBVvkg8kW+soNaBAH0FdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewkhA1z+AJfskjZhDIKmjnsIrBCDi0uNVS4+zddpMIU=;
 b=tM9BFJydBsBGB8opeNgayhEWfM7zgKHSk9CfYpFRiOtK4ffAUYuez2Kv75qIPkwjK1RRxRCwRaiUkJpMwVss8oJIJ+JqS/FGrrgZCwzuN3bFzHgSKA22lVP+nv7Mp5nJ/aegWYuYqcweEjr88uCFsQsi2FwotCRiK9jn5EEZZ1A=
Received: from DM5PR07CA0096.namprd07.prod.outlook.com (2603:10b6:4:ae::25) by
 DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 07:09:17 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::16) by DM5PR07CA0096.outlook.office365.com
 (2603:10b6:4:ae::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:04 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:04 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:03 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 29/47] hw/arm/xlnx-versal: add the versal_get_num_cpu
 accessor
Date: Fri, 26 Sep 2025 09:07:47 +0200
Message-ID: <20250926070806.292065-30-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8f7c8c-e67a-47e2-6626-08ddfccb9b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YN3Rl692LNoMrbtyE5vKK/50l+QJ0MyuXLX3AC+IBbnN0b1WIkuQIwgluWD9?=
 =?us-ascii?Q?tYC1B5TijdxGy8ocMuTS0CRv067xC9fTj78gie5SKLEaU5brRW/Wo4L6vss3?=
 =?us-ascii?Q?Qsdv2ghAbPz6yy2QUX6gqrlvc/WGhYKsxLn1XJoQDPG4EC8jr9IxXjUdP90g?=
 =?us-ascii?Q?lafSXkOPm5VQOImIark1QTtwqKUFAm6R4FotdsUeoGjnNMHcUHrMDut0Quxf?=
 =?us-ascii?Q?NiYp74DR2Ha3Xj2+HVUJXtu7a1j1mqpj8uKvV+pGFb97M082XQk40mfL7G9Z?=
 =?us-ascii?Q?OxnXVbYRpT1o6otOh3q3fx19v0yRwwR9paIhnfWMhVdGdDzfKTNjMGu0JGrv?=
 =?us-ascii?Q?Z1EiSLQEjkGANVdSEHa3iRYVNX8LGfPIItvpCZrNYUucH8qgwPIoYXHZ6CEu?=
 =?us-ascii?Q?GMq0vr4/YTh1MrwUl6dvS13LJYQJjyBGftIVSKbuCcpaE03ltTSQ9apBgZD3?=
 =?us-ascii?Q?aoXrZCM3xiqhE/hEbU5rqFKCGYZloV0QD1kEPGrrihJCuvhgsXxsFP9Ibr1q?=
 =?us-ascii?Q?fiEJAuiUfpaXfGxolc6YTvHhRgI9DEcGOTMn9rNvvthRk4ghOJQVJrGrlQIO?=
 =?us-ascii?Q?epxgknW2KaRCJARdaYGD6QsZmQ085O5BKCkbM10v7UENlaEPfeTUN/wqRg9t?=
 =?us-ascii?Q?24guash2xRHb5n87w5CjSdbYIc9UtJ6/e3+GS64+Ft+xVhZqslzkQHJKhWc3?=
 =?us-ascii?Q?Wlu9Uj5t+WfZ8SVj7OX+Qf/6tTVjA37OvR/F91KnQL/iuxHFTQHIcouE/F21?=
 =?us-ascii?Q?d6FXHDUqwB+lLdQ4HjHYHIuEcy5ra03ws0+cFztWmdBoUSD1a2bM7IhSapMK?=
 =?us-ascii?Q?WAO6NTQePgY6EEtBIAwTxRPD4MltI7FmTToD+PHvV3CYYWl6rhKpRCDQTuB0?=
 =?us-ascii?Q?DTk1bFlBmfC+qdQP7S0ubw+EH/A1e94sKlY2pzWa2LfsIKusULwKuzU5ZHmD?=
 =?us-ascii?Q?FqO79+n+XlhGuSSm0IvhXAOjTomNkhOlvZxNqtBtBgu2hhwTNB+CUBfxokWi?=
 =?us-ascii?Q?N7M1+ndzOjMSP62c/OVgL4dZ0TdYbQTd05eKSIZZV+czrCDCX9MN5hnew4g1?=
 =?us-ascii?Q?alklW+gnMqRgQ/yQJqQLU6nS3vtwWfX1X+g/MOeh6ECuhpiLW6aitmD6S0nx?=
 =?us-ascii?Q?iYe6ooZ4J1Ou47zqYBNnj7uZsGkvMZJH15mLz4hlJ023FLpXlfgety/CuuxO?=
 =?us-ascii?Q?C6qzC6CzAXIZLYjrMjDYifEYhidMZIndQ8mhr+Y5f5as0z+00lMuBIt2H7ti?=
 =?us-ascii?Q?qjoYGMCwD3BWBrKSBh49SKSk+psoxBDBQir7MqCCkXXqXVPiMjoHbzI4kQul?=
 =?us-ascii?Q?RODHveipBtxHjg+snGphBAvsbo27DTzh6Co4mod7bBGCS7J4Tfvzd7KHnsVZ?=
 =?us-ascii?Q?3aMBMs+pdy3x96maQ7v0LrZzZPumH6SAuJJ9m70XRS8H+AlnDUPI1XXT+luv?=
 =?us-ascii?Q?/igk9HvDfqIRwnBAf8fcp6S1JBY9v0EyddY4GWLm4ZFGyFzZp+mhLRV0k6U7?=
 =?us-ascii?Q?eOjOfKyiDklFABWeEE231VwoXT2xtu9xf1DS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:17.1412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8f7c8c-e67a-47e2-6626-08ddfccb9b66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Luc.Michel@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
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

Add the versal_get_num_cpu accessor to the Versal SoC to retrieve the
number of CPUs in the SoC. Use it in the xlnx-versal-virt machine.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h | 1 +
 hw/arm/xlnx-versal-virt.c    | 7 ++++---
 hw/arm/xlnx-versal.c         | 8 ++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 39bc414c85c..7bdf6dab629 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -78,10 +78,11 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
 
 qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx);
 hwaddr versal_get_reserved_mmio_addr(Versal *s);
 
+int versal_get_num_cpu(VersalVersion version);
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index ad7b3135a67..274a7ef9889 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -344,16 +344,17 @@ static void versal_virt_machine_finalize(Object *obj)
 }
 
 static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    int num_cpu = versal_get_num_cpu(VERSAL_VER_VERSAL);
 
     mc->desc = "Xilinx Versal Virtual development board";
     mc->init = versal_virt_init;
-    mc->min_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
-    mc->max_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
-    mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
+    mc->min_cpus = num_cpu;
+    mc->max_cpus = num_cpu;
+    mc->default_cpus = num_cpu;
     mc->no_cdrom = true;
     mc->auto_create_sdcard = true;
     mc->default_ram_id = "ddr";
     object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
                                    versal_set_ospi_model);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index f1b704175ff..2e28b807d71 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1813,10 +1813,18 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s)
     const VersalMap *map = versal_get_map(s);
 
     return map->reserved.mmio_start;
 }
 
+int versal_get_num_cpu(VersalVersion version)
+{
+    const VersalMap *map = VERSION_TO_MAP[version];
+
+    return map->apu.num_cluster * map->apu.num_core
+        + map->rpu.num_cluster * map->rpu.num_core;
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
 
     return map->num_canfd;
-- 
2.51.0


