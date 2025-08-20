Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B8FCA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeAT-0006vv-KW; Wed, 20 Aug 2025 04:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAQ-0006oi-Th; Wed, 20 Aug 2025 04:27:35 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAL-00015d-4U; Wed, 20 Aug 2025 04:27:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpabievTpSKK38c+RldX2WEeRfjG4tZKv5BPAyptqMQlGET4jkNriYpNiaHmzCEU1eKZaSraYnJxsftqvoFt6NhoeiRo1bVFwzXN3nUZzMpxhC8id/RvBvmjezBO3vGuABLoBtPNKLiajj6KqUDhvq/G9ubafhE/fK8GGML/5PDUAxYFprWoiH9uREuBvFErGWR8mkHMAgDSg3bGjf09O9D+ieVtBRfYwpzz7sLkxSAhnhCksAKQqWTz4yE3J/JrSRYP6DeUiz3Gt6h120YLOg6gs2/ZSoEs/7ClmhZ6oauCccT+hHMibGahozZ/UWyRH6BQU1nx18Aakb8ZrESC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeknBS1WO1irgBrpmTh8AdKB0mtjTa4zyagA1vL8a3U=;
 b=nfIM8aCDsprlAWHT73QruiRXNWYZVLeAYZQEry4N9J34ze+MSJPuyFnwOMvQl5rMjGYvT7Lxh9KSSYFy0uOE52eLo4cAO1+Ee4lQnxAgBRXgfNZEE7qFaXDYOjhfggIr6vBdKLK+4a+CeVh6aqXPrdqlMIIpVJqF7MTKT551CwmmoNIAIffRGWvluHTLUbGrMp7iR11+Ac3wkNXjzTaVrMIe21ZXWxdBWK6eZvueLxkep04WcJJSSCntLBYte1zyMOgb3S/xxlpXI980He5ZSbm1ILlLFR4R1ERA5n4zNn0eNh+0ch7gcsBE8IY2nlA3DBi19/ROq6tuBgjUEr6Kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeknBS1WO1irgBrpmTh8AdKB0mtjTa4zyagA1vL8a3U=;
 b=Zv98mFJemORuG6QDhV9VhNHzYIG9PAGPbNA5QrjlrnAmsWguOmt2p25ew6TXAyHz73CRLVtFx+9rPL0nR5STacO7hEkkNGxzdFKcTE/He8RWqZtE5kwM3fzITcvuLeMP0YFUlxs5kciRVwmdKx/mI1Gta1jPAhRlc5yPwgWl3jM=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 08:27:15 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::9a) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:04 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:03 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 29/47] hw/arm/xlnx-versal: add the versal_get_num_cpu
 accessor
Date: Wed, 20 Aug 2025 10:25:28 +0200
Message-ID: <20250820082549.69724-30-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d25445-d821-48e9-35ac-08dddfc35e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dYX3XxAhZLmdf6wpSUO8KJFzvxjuQceVoaDsX3W6+Ff51DliTd0fXIk+wZni?=
 =?us-ascii?Q?Ck/vPYMIu6z/sz48dD5Wg3l1oPErZW7At0sTB5HBiMQwA77IZTh+j15jLOr2?=
 =?us-ascii?Q?79txhSmqlX5xSvcwl/YS2AUoyVvIHBJdg+16V309GkFTn8+dsxuEqaFwWfZk?=
 =?us-ascii?Q?1M0RQfRodpUTu6OffcdYoTbB4tkQ7WGOCtmqMmq1NLBvcAHXDeEPPr51aTaX?=
 =?us-ascii?Q?+DruFtjtVUujt6jb0HB8t+BaZ37+bFtxVgq7+kZEeuEHL55Wb9a6JqAO5W2Z?=
 =?us-ascii?Q?MXO34bXQd0cHO2Ia+JcJEXjb10ru0bOHHqA0ngK3iPDGpYK1Z9wGvVTElC1+?=
 =?us-ascii?Q?oVg7kv7G4+2X2qPzqJPUqLDPoScq1tjen2EMh8SHwmYkguOKqdZ7s1EWoYSd?=
 =?us-ascii?Q?UDUrBNY32y7ojx/d7AvgnekU4zhp8XztrtFclIF9k8xPDnyC3bvf1msD4SOR?=
 =?us-ascii?Q?JTcxR4XVwgLeFSZnxzqF7/2p3heoCGAutljGd3S7TXK8HlNVCR7EtVMUiHDz?=
 =?us-ascii?Q?bPz3YDUJFLig3s862cTMTdforzTVts5x5frJNIY3EIQTX1aeKhziT/dyiD/y?=
 =?us-ascii?Q?1OakhsxC+IMzttN2faxyY7kIfhiioDF9922QdO5eQF7I6O81gvDwO/KkY7kp?=
 =?us-ascii?Q?/bWYLfOCv9KNx1AvpBGDVtB+etUyoy+gNB/ge0/pwMUBJICJZGAnwqQliUWo?=
 =?us-ascii?Q?QzzPNDScwB3r+72EB2FMReUkRFgLWYAYASINi+bbXxD3sYlI1jWqhenLSIji?=
 =?us-ascii?Q?s0/SJoNjOVVHwpWM1yTMZpGK1De79DT+X6QE9Apnn57mRb+0HJkUj07GDEnP?=
 =?us-ascii?Q?+phU5SdQC5SacjoKMZTlTc8x8SZGXJV5X/SkrMXXwJIU6jszemT4xovOoDUz?=
 =?us-ascii?Q?lmVvaRy3J8FQVk3bBNb9XRIU1/HqE+cE1AjKq3WwfPpC8Uq4IiJfC5kGnpS+?=
 =?us-ascii?Q?hH8Fa0gDw5OFlLrol1JhhUcIO8ImzkEONOdw/XpxlU6DJRE71SRL3bqLwi+T?=
 =?us-ascii?Q?MESAf1aixs1yAW39WR1i1WJPPeD/OF3uEqsvhnRobBnNu6bamH99NqkOx8Mt?=
 =?us-ascii?Q?cP4DrkkNhPFxEBSZRl5FKOdHo3LqHps1sCQquMM7CWI/cFUZUzJXjpq8HDkb?=
 =?us-ascii?Q?qFnze+1JsmxIi7ae7HitHgu32Bnaz1B4A2I9aovP97dUXD55oTgFsUiIA88u?=
 =?us-ascii?Q?W0ERMlqrdTh8V5Duj897OdmpG5CoHFr2exZKxJKBmJ1UFBpcIogUSVumDOYd?=
 =?us-ascii?Q?BXWnRrEC0rOYslEUo0AFPp5pzSxm/RKU3DRJBD6VlYIWGmowghfUfoiRJy9q?=
 =?us-ascii?Q?KXI3evhEugnuXPa86lXCRvRhrMg2WxT6cBmi/6oQYnFZmfT1AH4XY9deZVJY?=
 =?us-ascii?Q?cN5Ke/ZdwlewfN0Ak28lVI8FdXffkFxyn5QGNdXN6hFaFEnIIfPwsRgls1kz?=
 =?us-ascii?Q?/lRefnPnUbQgjn3WApZyIsAMfXPmaCygNg+57Nsdcc82jARfArfbJ2TXn37V?=
 =?us-ascii?Q?Zd/IKPlNwkXwx25cMkw2JIuca5aCwORglkQp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:14.4808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d25445-d821-48e9-35ac-08dddfc35e0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
Received-SPF: permerror client-ip=2a01:111:f403:2418::600;
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
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
index 2ca4a80dd00..0f114ade652 100644
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
2.50.1


