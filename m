Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D35CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0dV-0007tA-KV; Fri, 12 Sep 2025 06:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0ci-0006u7-Ty; Fri, 12 Sep 2025 06:03:20 -0400
Received: from mail-dm6nam11on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2415::613]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cY-0001Lz-A8; Fri, 12 Sep 2025 06:03:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHJs45czZUrQYPTu2liBJDB/vXheNFMwiGT6lFSd+2Xu2ZQoI+3lV12UyS+mJpQLxVn+iYv8p4UCuOZQRBMoblzK1wlE2JkG/+7voptILrF2ABdgWVlvNg2xvqJjcrllwnCTVPA/w/B0X6S/hiYmw3+YIGKI0aT4oCn5oS2/svWwJ55arS3fApMFGoZWBuizV1A42qYlNCttsmzmsMpXO/9G3dYDEPFJZs2qbb36VbO2aOcV2V7NWuMmvPo7WZryPbEhJ8Bm5KD/iGDMj69brymRkyy7mh+nmwOdX3kfk0zxH0r+Kt+keWcLRbOHdYtVdofu9v7nmbF7qCzAEG5fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIL0n5YlaHa6E/6Kbc9pgtwwgxEUw2e0B47y4Uu+xbs=;
 b=P8Nmvy+ohnaOBs5yqj+OUY8CnYI8zeQEXiL6P0oa4rN3sFJwPqZLm9Ul9Gj3DpobQ4xq/CQozxdLMbiLZx3M+RPw2z5cRdFwQ6ChvV984c9U84CumseB5dQA2qF33tT0lalS6PRjFkeevh/Z60+p1V0M2Pb11ovsUWNyjO9L++2X8al+nFekzcZ85mIcj+OGgBG4bsBK2x+9fBhzyJH8360yq3eYyHbfwZuA3RR1v60MLddvORTSc7BVGStq6tBgIEqO7+PrJpsJMUkNc1IPekMUkJJTKovz5O8tv4sHzYl5XvwgcPCEWTubKkV7vIMtEoqb0YQGbiSgUcBjxkfDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIL0n5YlaHa6E/6Kbc9pgtwwgxEUw2e0B47y4Uu+xbs=;
 b=CHQ2IwM0wig1R8GMJdlctRQfVjdhdtH91w4f61csibIcN0ngcfLXX/LG0ZfQpMCJTIWjRxIJcRNq53DdPDC7y3qcDTfO/7tTd5X5Rtw3KkaUBc2Vy6cMKF978LDnvslPo7/RnGw9fuCGOZulT6yKRGVcbnOelfchP5877bzPPXY=
Received: from DS7P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::9) by
 MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 10:03:05 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::98) by DS7P220CA0012.outlook.office365.com
 (2603:10b6:8:1ca::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:13 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:13 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:11 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 29/47] hw/arm/xlnx-versal: add the versal_get_num_cpu
 accessor
Date: Fri, 12 Sep 2025 12:00:38 +0200
Message-ID: <20250912100059.103997-30-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fab1994-888b-4cfe-e660-08ddf1e39150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tNLYRqB/bBxs9CdrO9LDUS4G0RzUJhvFbvt9YDIboefN7GoJzFjjLnDgZR97?=
 =?us-ascii?Q?M+Vw+nmklSej52/dbiwzRx7iWB/km0sQjwfoJ0SzaCYDCao49Pybap16eguv?=
 =?us-ascii?Q?6ygBA8kC87+/Pn6VGttGHfH3cgtwTQ84dVudCvyE8Nr88DgFK5qCUTQ4SJ2S?=
 =?us-ascii?Q?X4rXMMUxqj/Xbrbtdf9qOSYuW+cuiLLQT0tGvQ20m8GGS7yvioHsSn4rW8Ml?=
 =?us-ascii?Q?ITI0RAHIy38643Ug4r2N2bZrG4XyLR3Gu0rRUpt15+59fMQ2hmO5ZyoGw3yY?=
 =?us-ascii?Q?uYloc/6GsMdCgsCj0qY/jM7mvGHRVswDmao8YmA5uM+W5fgBkUWZ6vOOy8u/?=
 =?us-ascii?Q?cBG/6wBa4lodr/s6oFJ0/TAxsqmBW8hOCF25nGeVDwDLYbrV8Au2+H9RRAeo?=
 =?us-ascii?Q?uwSP4OPGDUqagoIQAMEd9LFYcfmynhGlIoRPY8CgsSsbmvW3fLYj/UeauGOy?=
 =?us-ascii?Q?ZDY9mzHl7tvt89HT/3yBsbrRxU4DoNxAB41KPy7nKxkLf4wfMatLKgA/3DHs?=
 =?us-ascii?Q?iLZGOE/W8M5DFZ88Jwz2mignvFJdOHGr1Frn571M/O0MK4tIVM/YpHrRL93B?=
 =?us-ascii?Q?8NuTwHvDQNOssFgZjpD+j8GvmM1q+PcnCYNnfthUqyg120nF/0yxSGNU9pC+?=
 =?us-ascii?Q?4otdM1lNgc8ojEDzwb2IO8m/7JOVZdHZEg2iQsy71Z5oDQmKbG632EePf8+Q?=
 =?us-ascii?Q?W+oeW6R97rcv7qs73cHiQv57oRvwRpG9EEHrbiEDXt2GiuyIfoVYtVaRqjee?=
 =?us-ascii?Q?+8r2c2mpawIV8dLZkV4AzAWN13eqjCuKiGhCsos9WnnVdMubK3GY3JnehCcV?=
 =?us-ascii?Q?ya2gr4DY1s7vIJUzZI4GbgabMYfNiKXmnoKp5kCdA0d7jdD/WaI67mmDeaCi?=
 =?us-ascii?Q?tv+gNZS2lUmwnMIOJ03ULLg8FQ//3IEnWucOHwoQAPzwfBO0nKqVYkWY6uQP?=
 =?us-ascii?Q?XtSNGSmXIZ0TgeJf4Irs4oBfPhbuTF+/TJiFKhJvJEgQuw6KuuLkmVNWxQt7?=
 =?us-ascii?Q?bN/bz+XmORocjCGmkbCrSbRDDj/DFujy692heAM2wEruFus9ChjIZca7haZz?=
 =?us-ascii?Q?46TvcB1jR2IGY9/E+tuIpsEWaEpr2LC9l3ADeQGAP99GG2Mvj892nYbM0YUn?=
 =?us-ascii?Q?KSoXLpvaXVh5k/Q4f1JyM0iz1tsKhpFfuQDldQ/DUPwXT8z7VbyjiiIi0698?=
 =?us-ascii?Q?519lH/yuABGxMqGsnScjSH7eAyQJnrJBrGa3LGW/fo8PZT2wu82TyMN4BtMY?=
 =?us-ascii?Q?b4aLkUIuBeIhQ7r/HP5j2ziPOkI9bUs7x3xbMHhrTjfFzSaQSPfHb7rCLImD?=
 =?us-ascii?Q?i5JmY2SYTg9bqreICuBZR9V5DE6bf8DSpnyO15F7ZO8b1V7EacdXfRVINI4p?=
 =?us-ascii?Q?TiqOeRRdRR8PX0IgePdLzb6kmoIwjTmhcg1eMrFqvmjRTRSRBPEzmX1gps3c?=
 =?us-ascii?Q?Wi2QwjO9+c06UUJieTzRwoa2XIli99fdbxYnoTPFjjA/vOIsscvt5dFFgw9Z?=
 =?us-ascii?Q?Lxnv7a9NZznCSSO+rcNbCdIgrYlxFhwvJJ90?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:05.3541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fab1994-888b-4cfe-e660-08ddf1e39150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
Received-SPF: permerror client-ip=2a01:111:f403:2415::613;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
index f7680cc1254..940233aad06 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1817,10 +1817,18 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s)
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


