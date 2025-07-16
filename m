Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488CBC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubytR-0007Ph-3Y; Wed, 16 Jul 2025 05:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys3-0001uT-Cf; Wed, 16 Jul 2025 05:56:16 -0400
Received: from mail-bn8nam12on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2418::627]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyru-0006hQ-Fk; Wed, 16 Jul 2025 05:56:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyVL8PF/B0rihu/+vAzKInwy/4MW2Ucf5oB0c3M9B0SaZZorpzwiKuAHnaIdGP6dX7OOg0WluLHtu+C2KE2VuZr8eIKefYaXjobG+7nriHhSdnnmm+Rr9rwWiilkWLzi/yyKg81AMvn2VB5fzjygR+SZfKU8+uKkg48KSxj0i80Er+0kZpcI5bfDgRC/ElJfKGdeR1MuPHwwd1Z/9TqwXw9TOXUVWlb3MAMEgt3zYqJA871mwDZXa0t0zmM48EiHQoDCq0ztXTK7rax775vulu35j8yPpekBwFF7gA3vwXunqu2K8xRDK6MrwkEIlJQwJMsvatyLgpXoZ7Jxnv3vTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/gyMj8tWMv4kD4aVpib9a92r3vqZ5ln2qNiNgewUXE=;
 b=VEJaHLxf5ld06HQixtPjiJDUZ/3YAZtuCKxDsn4LWsk9ydCMCz3yolABFWe0U6pMnpBDbPhGVkqsr6JR6cdhMQzGg4z/SW1GRRBed9ndYzX26RiEcG4sJMT0w9wAnAkTGglFaCg/FmQHjSg2DKbo7R0csUDtXIfRg5tgp8U/HvUiMkZ0hTPEJQn/+Bu/Xfsge9qFb0M/MJCytcGmUlfm4AK2gXLXbtZbspE6FHiPgW1r1swPdXU0mR/gwFc1h0xJ4nJRiDX2TCO2bggUfw8sdsIAY/uU1wObCaMM6X7l/w8MTGn66txkBVSE8/CVEWs41A9Jr6n3kGbN2tX+9jSvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/gyMj8tWMv4kD4aVpib9a92r3vqZ5ln2qNiNgewUXE=;
 b=FtrwJTXOQkiJ3UYsxm41xhqDyyjnSUtzE0gGRhZi9QgJLFgjeQ9SahXFWkSFt+y6EAKnR4ehcGXtd//Zg24nlgQ+fSbcVD5NjHbkdteQ41OkqDDW6h1rY6BV9hifs1I65Kjg1IYct/KUY3mYXWUp16K9ARXtWSxS0wY8LMMqD5I=
Received: from BYAPR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:74::28)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 09:56:00 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::f7) by BYAPR05CA0051.outlook.office365.com
 (2603:10b6:a03:74::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.16 via Frontend Transport; Wed,
 16 Jul 2025 09:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 09:56:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:58 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:57 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 30/48] hw/arm/xlnx-versal: add the versal_get_num_cpu accessor
Date: Wed, 16 Jul 2025 11:54:12 +0200
Message-ID: <20250716095432.81923-31-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0827ebd6-8242-4e77-5c08-08ddc44ef7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cP/zyOwi7tgWVcd510qO6uU43/tKcIpEMJaZUUhIiP8uhUDuvWd2wPUKIl5z?=
 =?us-ascii?Q?iEKVp8dMWNSG6iFtUTOP1HQOUG708mQPYZc1p5YRKUAS+X/6AcuUqpI8FHb1?=
 =?us-ascii?Q?VVEDyoR6u5PECHe5HBvopi2mPoH5Mz7+39FEUYUUpPYUDqlf/OXNRuf8+NkY?=
 =?us-ascii?Q?ZmcZGUoefm1vXzhDZmw12hibZi7/f9M9DDp1svpnflmFn2cUhl/ws5SWJm8Y?=
 =?us-ascii?Q?oU8YT4zva3fWIWn23YRf2MuIKqMhmHqNLaY3k7EvhbW3IeYFu1mUfgn8eQt4?=
 =?us-ascii?Q?ey9vofcKktEWA4yc8HGkEapG3FGNc657KFTk3cCCwLVfHhkBNk+FdxWpY/fQ?=
 =?us-ascii?Q?+5ChMbCfsqJG/wIYDNut6/cgsRGCnJNz6s/uI0KC4mZ2iHEwYzxuIb3RdHNI?=
 =?us-ascii?Q?nA6B8EIruc2VNBNUEmKKNiYGB1QHpPLrKCe1wy0vLYPhp9Dy2KOqu65BF2K6?=
 =?us-ascii?Q?AkZ9UPP20nPhJzam5BL4WjtawB6mVyODnWb1mUY/H3qm9NzgRnCJ3ehDW2Vg?=
 =?us-ascii?Q?xmLFDS5qKG/9SovMu9d5INUJc4qGs8KTR1zixw7z6reLiv9dc9sNM5nLSLK1?=
 =?us-ascii?Q?vVlOAbPqMV0+u01rcG1h+KHowWT0lOtA44mrvLfSjGnTUOmynYDrGlqWI7po?=
 =?us-ascii?Q?QnLDdMv+CaGM9JKhtgbFGA4oAkE69ZnRH8egmiw25gsOcWSsXfWMUeGlE1p/?=
 =?us-ascii?Q?gI0cQTVs1BpJxAWC3aEb0ObVTL5BFA+I10ED7oxXMiVwYrm61kvheC4IugqW?=
 =?us-ascii?Q?gpinDlAbpdIFz8SuO+WAjt2P1nKj7nX+5Z6C6m/+3iH7J7N3P9+PQUM39fjt?=
 =?us-ascii?Q?2pFfWEIVAEcJlE9pyg3vw+Sp1tO110JZ6VAjIRU6oaOsS6rkPC28rQcVnzG8?=
 =?us-ascii?Q?N4Z2fH35MqbFDGlrpvFLHm1OXuM76q8f2BU/P/0nAqlmqNQ7W+kENY2JUuB1?=
 =?us-ascii?Q?klSvSWMWnHiSwnZmb3EbIU8prAH5YbijmMuihB0a9BhL2exL34XiWaAwN63h?=
 =?us-ascii?Q?SR9jSLO2QKgW/taWGL0Fx+KF6LwwHJZBunaM6fwi3CeZz8FHF8Td2jVnAPQm?=
 =?us-ascii?Q?FDq6FQXQxQh02IbSOkMf1HMSckn5kN2obLAbaJjpzD+sovGRQcyd/jb9z1Gp?=
 =?us-ascii?Q?/Hocalo0olRSYty8FxwVNTUSeqapkwOVbN0UQbHjHPeReWlEr7WTbnyV5mC9?=
 =?us-ascii?Q?NWS3juf+bcMDBFmQnH2oVpSbgeM/XsoNFts8eyUvwn/+kUpcGLIOJDJqo17C?=
 =?us-ascii?Q?CFbGpiHKsFAUJmVX6QXE2R8ZVAobCRxCUi2QExPpUrYZAqZY86VIhEVqSgQ1?=
 =?us-ascii?Q?aGudMe0UHHooAr+ZK2yXbpSO5er0LpjCWlT7JgFvNm/hQyD0PgVrcFyIYVj9?=
 =?us-ascii?Q?HttMNC/cPRfPXJ+o2ud1+oGWnQglkT0Rz/KuPDc6Y/1qZumnmi5xyRT1RZPb?=
 =?us-ascii?Q?/wt+HrexenZo+U26DpqLzmL75xfFCQMyV/u9wtCsrnAZ8Dqiv5xqIUG90s9J?=
 =?us-ascii?Q?9J0bDV15qVTe7fznbA5piZ1WQv0OvObXV944?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:00.0957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0827ebd6-8242-4e77-5c08-08ddc44ef7ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
Received-SPF: permerror client-ip=2a01:111:f403:2418::627;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Add the versal_get_num_cpu accessor to the Versal SoC to retrieve the
number of CPUs in the SoC. Use it in the xlnx-versal-virt machine.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/arm/xlnx-versal.h | 1 +
 hw/arm/xlnx-versal-virt.c    | 7 ++++---
 hw/arm/xlnx-versal.c         | 8 ++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index a3bc967c352..ffa7801b30f 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -77,10 +77,11 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
 
 qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx);
 hwaddr versal_get_reserved_mmio_addr(Versal *s);
 
+int versal_get_num_cpu(VersalVersion version);
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 7f40c197072..5e47a20922a 100644
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
index bf680077e48..5151822ad56 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1805,10 +1805,18 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s)
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
2.50.0


