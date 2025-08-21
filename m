Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29893CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4zC-0002Vt-PF; Thu, 21 Aug 2025 09:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yh-0001l5-VD; Thu, 21 Aug 2025 09:05:17 -0400
Received: from mail-bn8nam11on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61c]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yX-00030z-Qo; Thu, 21 Aug 2025 09:05:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D78UlPNFgXT1d5dxkg9cAqv6/0CKbUOOJNd1zd5qBAR2goAb5EUSoSZSZ51kz+XivRoeiK9vz+PhdNGjgpR8NAz29UmMoSWGY3gpdXgVzYaZQ6Lif5CNFb5IAmQ2CBFuF5HOoiUJWsj6fBJfFwMlaGh9aPd1XyiZ0Q8x50b6X54AwQu0wB7jlopUgbwb9hdr6VuNrhDjUNoHE6pEChBkvaUYH5hjKrWposCmc1aC9YDNKWw+zlIL9hSyVKi5mefIoCEiEvrQWe9pAD6Qk8MHhVJx02DYOhxWwAicsM1GH8m1GZqe6hMbtsBGz6AE3v8u8FPFVhEdpfJg3t3RfLo7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4J71mwFNWBnWDLzz5Vq/TA+6amcFoA0sFKdXps1DNg=;
 b=nGACZDC4sn8hIBBF10AzAu+DnA3JmerObUbEhWPE18Q9xqn9mnOCnFw6JgrXwxr30OrtDYEm5plGp0Y0R6gD9Z/4l2GV3+dtJ9Qaw7w4B8LtHJcJ/Pr2bto8mg5UmVbzhRTfN5gpcp0gOfIskqWRsmFzvXnJbesjm6XlLbqLrsqcev7bJzad1QO38I2I4ndMXQRoilwwjGKsC+USjqXYg988UWmLBkPCX2bM/jAoe6vmyGlSB0E+cVsW48C65SwMPBe6HmWhezLK8nNAK7/9MmiRP+0WknbNSW3ER9LDOVIef8iiKzzq0gkLxPvLlnNAkxJypqg5GkicaTuaOw4zPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4J71mwFNWBnWDLzz5Vq/TA+6amcFoA0sFKdXps1DNg=;
 b=UZoX2Y8THJes++DioOK69NZZLgMPDXgOzUSn/1qZMsewL36vk0H8ovTmNZZQvaNpbLEUas1uxr+V95QIffpxgH24kAReZ3eoeGkVB/RS/mhnaTca7LXwbTxd3JsvElNebE1220ZLoDC2/+LC0hLVv9uND1JVGRg6FGVJYjHJJuQ=
Received: from SN7PR04CA0087.namprd04.prod.outlook.com (2603:10b6:806:121::32)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 13:05:00 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::29) by SN7PR04CA0087.outlook.office365.com
 (2603:10b6:806:121::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:57 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:55 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 29/47] hw/arm/xlnx-versal: add the versal_get_num_cpu
 accessor
Date: Thu, 21 Aug 2025 15:03:28 +0200
Message-ID: <20250821130354.125971-30-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d447ab-2f5c-4bcc-fa99-08dde0b355e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zukrpxwSMiC3jaX48B/1rQl4aP5N3XiqEovOEnmasvuuwtuCv9zNyBR2kh32?=
 =?us-ascii?Q?B1EWHRMDACrL0mEEZjgGn/1Aj2Kpx4TdM9Chk9LjYUmMZicDyNWa0ySsOyhK?=
 =?us-ascii?Q?mKViC0J4rw2rjafrTfhAUGYVVXePTl8n6Imps/QjAr+EqTrgsAIm7Yfx0bwQ?=
 =?us-ascii?Q?bXFW5pGcZdAdRZ3O7CkUMcYYVkxHlfw1ReUqAmGXlNV1OqFlSQ8/TWBwS113?=
 =?us-ascii?Q?80OYvgnnn8NfVpjo5GiRTAat5HGkfA39McULNfLAvmFabjNgG13A4z7zr1Rh?=
 =?us-ascii?Q?Uh6MVJXKiMNDQf9MqBK8kH2isDMQaDKVC1GFohEVMyj26AgNjrk/UUnN/3Bm?=
 =?us-ascii?Q?dOimrc2zh9YOSmPsXybnAxW8kxld3LEEmtTAMbJUsuDL1jexncr2AMLA98e8?=
 =?us-ascii?Q?qltX+3cAAOrpz2cvJZDp2YCDseFY1IOrO1Mkje3EIAI9Lis68ZGUqENkPNcG?=
 =?us-ascii?Q?2JcFUEQ3oTzodlyHEZ88X8OtufrzsNz2ckKZYN8wUYnB2sMd68Bs88kYY0SR?=
 =?us-ascii?Q?mfJIQN5sN342cpeWQEjuFrcxrSsOA2rxDk0UPg0X7/97++vDsT6mGPwkHvLH?=
 =?us-ascii?Q?tNp1/yzNKeuYMDIPEhHVvO4YjmOSkBIVS93CIzmeq4HOcoG/b1zgl4A7ayrh?=
 =?us-ascii?Q?mFoKWZHeYZjRGq8Vv3/caXI3SDCgY+VBQQbKrAi7k1BJneU95x8EjO3Mgehf?=
 =?us-ascii?Q?+PGArKdqA35HZ3wDk3i3IkhYmVII2MYipF3kzsr8sYgPSFahvMGgknn9znVE?=
 =?us-ascii?Q?S7zNNQ/A8zBmN4BlfPEJudNNGpnw77L4AXqM0GfXjf9lTEu+W2zwzalE9wcC?=
 =?us-ascii?Q?p5Zz7Q7tUiDpJFd4Dl6r3bwBPjQlgvGqrvOlOwXEQZACsQzdi2mn8TYuJEQU?=
 =?us-ascii?Q?gbQHHpN+Ur9LZLNpSogxmUo4isfap5GtCbYSqf8WR5S4w6kVVYbR19/+8lRH?=
 =?us-ascii?Q?CYcrUbh33TAdlJbr7IeFnLlCLhJw4Dh+0fkieYyZh243hwdUii5cjJYOOoSL?=
 =?us-ascii?Q?/ulEm4C1NY92+/kKMezSkbZhkWVYYDKy8deXfxH7wI9zMsNNgAIWlnf4S+ql?=
 =?us-ascii?Q?Ka8cZTOZ9ksXzagGeBEpO80gSRIAuFljZn68ST7vaR0Qwe4+IuF2/RKRLg5A?=
 =?us-ascii?Q?lrX/w07saZ0Q4PfcWJXsdazr5yW71qZoP578pM/795aZJ9Q7KLqrKoI7lOgA?=
 =?us-ascii?Q?m7d2DWeCd4iDwwf+lszSf0YdPzAdfwZBWonotbmjFOdQVkXzkkyRVRWxAmuX?=
 =?us-ascii?Q?8aVCteKE75zOimopJ2QWXNZRUrKUVeIvfEjjPuh7dQXbplkR3CEqDNVSS6iF?=
 =?us-ascii?Q?TfpR1cdaCQWYWFHHGHQL8lWMs4fbXLCs4Zx8OMWlIYdpexcAnBBo+xDb7oIw?=
 =?us-ascii?Q?hJdBHIRBLQU/CyRqbeNqokwwWD+NZk4heR/w1LbMtt7ZVayiwr5wNakRUOUJ?=
 =?us-ascii?Q?yGwKAgcr69HhRLl462OV29PFcFXBCSLDv+2xkp7Vw+odw1IsQcbVn9kDeXNh?=
 =?us-ascii?Q?U4pNZS/VmW7wU36IbLnYn3goZH1XLl7cCUc8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:00.0562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d447ab-2f5c-4bcc-fa99-08dde0b355e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
Received-SPF: permerror client-ip=2a01:111:f403:2414::61c;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index 9490c625816..59bd93223af 100644
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
index 00cea784442..0df2e9a3f6b 100644
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


