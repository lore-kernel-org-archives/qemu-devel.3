Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5CFCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cq-0007BU-CK; Fri, 12 Sep 2025 06:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cZ-0006P1-Lk; Fri, 12 Sep 2025 06:03:11 -0400
Received: from mail-dm6nam11on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2415::613]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cS-0001J5-AA; Fri, 12 Sep 2025 06:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eU1nn5rJnTb0zW4XIkmLAcR82+2A7oCe7lLdgSgNmRHiafMkCItXNMbERWxK7W8f5A4ypvwDlVXDqwSuWSVlPPIZ1OKw9tDo97jKZMmW9J9zRkl2L1wWlDZR+UIc0+e2tYEILsNDE10h9L9PzmRYnngVKfRoJtYu/qWeRCQfvEiNBCIzFL4VbhdL4474tGUuhQteHzLdP8H2VS1WwBJjlN7bwuA2P9mWW5fCwNikfVjcwUjcD4PjDqdCGoInnnAJMAJtEDsl94o6wZZpsyVTuzjU+WYbqfnpudmL8QdC4+5u7SuuowwDhEZWgxCedw638tvddlgOL44yV6umAG0Ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iupsSuxYjctGt1yGelVSdg9rUT5o+j9thWZDSyxhdJY=;
 b=IFQ/E5Vuhr7/2amyGrQw8l5MHoXUo5ts082BBtazVrvsGI6uUGKJ0fU2NnrG0mWYkY8y/BMLDJzQANzYliP3Eaa64wU0VFP4eEEf4ioEzfixSTXO47UStG5tAJ+yh01A8aWrD6FpKx7FfBfdMQuahVi01JybTsfVWQpHsbkzzTLGqgXgIXOW0/ohQ+Kl7N9v0woqSrW2xKaprA8GpnNu0FUlZDmrALJWFlaDoQ0W4nkdX/DalctXEJFMN3VFRI1P/vqGmJ7qA9nprLekiBDNQpgAnWJ241HPwQz7zRjNcWafMbM8Dqyi4+FfCS6gdgnSBvS0xz1LPmkAA3LkWMlniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iupsSuxYjctGt1yGelVSdg9rUT5o+j9thWZDSyxhdJY=;
 b=1pK5kuLWdty1Q9rMlv072h/AZCSaQpEUzmWzeD0pe+fVGoTigqNwAhL2s8rNPr5fa6PF7TQLwx2+UupbTgir/rcMXwxTb/Q7W9wBuljjNumxrJUiwK8ucFGNSeJultQM8CqwTc+MZXlqklZmPfziDJ7QOxiLifqvOKwBRA8LmS4=
Received: from DM6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:5:177::25)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:54 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::79) by DM6PR02CA0048.outlook.office365.com
 (2603:10b6:5:177::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:54 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:01:53 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:52 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 18/47] hw/arm/xlnx-versal: crl: refactor creation
Date: Fri, 12 Sep 2025 12:00:27 +0200
Message-ID: <20250912100059.103997-19-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 734caec6-05ec-41fe-55a0-08ddf1e38a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jXh4pO9Q0Khkp9j4PYGmS2giEl5WZLBCtiWOIh3cfcG6KjQe2HKQovJMRNSu?=
 =?us-ascii?Q?mTeZVuhfWeLCcNuhZwELJ7u5OFa2OCqwiqKwNrTeuwPkAiSnFbgkUpNZKnfS?=
 =?us-ascii?Q?UvTO7TK5gX4wW928e6Cr43E3wfvtx7qg1V5cINoXGHZeJNYKiWCER+//yJCR?=
 =?us-ascii?Q?z0iPsLwkYy2+IPMuiu5A6kl3mtYVVpgi2r9mq+VuZzhP2BeTO78fHXIzI8Bb?=
 =?us-ascii?Q?eG7n5CqXkRLh88Nn9F7rwqBeeBjnrq7CqDxrA30vf9suumS1+9RcBiZzqyzG?=
 =?us-ascii?Q?9oKutFT428mjSlmi7JYUfjuAoJI/UdTGQTj4Sikf0wNotnvxa1FgIieDrHlf?=
 =?us-ascii?Q?vbh7oAgweCmmcJ9/FNJJP4q2Xa8/o0/nRAav6LFPbo3vhF2NoPWVair9B6ac?=
 =?us-ascii?Q?yNGiEhQl+6fBKLM4asssyuWsEqzfy0w4MR4NoUXooqNbp98YGsguDqjQkfz1?=
 =?us-ascii?Q?1HDKUTsSda5/R6mp6RF0QA/5ZzCZAlsMzFDeNUgR5AdukwwAKhjiYfK+gd3J?=
 =?us-ascii?Q?Ybwwtscd1+/EgpepDsCGIfgcRXNQ87BjtdXzdCPxCdce5DcRabBlsMfr3nSS?=
 =?us-ascii?Q?BtrIUw0hl0qVhDayhKnXpJDX/Hch6WrBAlklZ5DMyJF0AdREqeflgFQSsgKE?=
 =?us-ascii?Q?b8hHM/XAmgHH8xKIhm6qz/2qFxNr67Am8mNZg9ln77wFCpE0vt/JjeowLIvW?=
 =?us-ascii?Q?1yOoKm1J7mbFtocd2hEXRRUbmMoDg16qMKTTZOL8DA8IOFvku5aXPsrSfsXv?=
 =?us-ascii?Q?Bv8n2v7Rda1RJZemWH1GyFwmUm+7+gsV+8XokZ+cudylT0UGiaRgoHuVa6DQ?=
 =?us-ascii?Q?wmwggRbYGuzGkpIBhYIrEOQKSCPqieb3lX8oKh1dJCUkXfXGZGUuEEPtLeCy?=
 =?us-ascii?Q?6DzkkOYUaUXMNaDMgce0mwp60yTknFs1hCmflWDKRxCFjfHC3JFwEy8zWK25?=
 =?us-ascii?Q?Vs8u/UadirHn0GTRLYeU19TvGQmtb37AXYU1VsiTXUuYf1eQgaBPIdhjPxJB?=
 =?us-ascii?Q?N0/HAlmYf1umKFqZ3p0O+V9dqs6HIQ1Ohv/vQhtTiW3x2moWM53BiQgyZPdA?=
 =?us-ascii?Q?oaZpBklMW2usiXzlWtFTiMF6RYOXjiEWUs3mTLIuvZLMEIn8KQYw5I0+RTOe?=
 =?us-ascii?Q?H9umHtnanmCpcRq/7ALuJYc/sAOFJDfM/Muv1JZtYGDRRqk4kf7+so4rEKIL?=
 =?us-ascii?Q?UO6drSm3/q9jZdTrnZTbs9IpofGg8Tull/f6YY3vn94nhFPHouWaJJIzyRhC?=
 =?us-ascii?Q?BghuBzN2nTEt+Fd3Em2v4fjPWvIncZ1QBqN8Ik46iX0s7ypLhu1prLgI1mH5?=
 =?us-ascii?Q?JVunLzkohHDT6UbQ6Kq+IP9y4/ff0S/jVI51fbv7CQv/jBJaTT5F5dwfUM0D?=
 =?us-ascii?Q?uctxW50sISfeTP1Pg1sfUnldwAZHQR8xBHd4Jkylfl/f7zUJfSQCLIpTHS+N?=
 =?us-ascii?Q?4Y4rja+/vlOWf+Hwb632zOgqoWVrUdKMvLnZSmvdCnHAE6W4p1YOpCTx1SlW?=
 =?us-ascii?Q?Y9rc4tfke5U6jv7R/tn/SIKaJwCUIgHZe8CI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:54.0270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 734caec6-05ec-41fe-55a0-08ddf1e38a90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
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

Refactor the CRL device creation using the VersalMap structure. The
connections to the RPU CPUs are temporarily removed and will be
reintroduced with next refactoring commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  3 ---
 hw/arm/xlnx-versal.c         | 36 +++++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 5a685aea6d4..d3ce13e69de 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -15,11 +15,10 @@
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qom/object.h"
-#include "hw/misc/xlnx-versal-crl.h"
 #include "net/can_emu.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
@@ -69,12 +68,10 @@ struct Versal {
             MemoryRegion mr_ps_alias;
 
             CPUClusterState cluster;
             ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
         } rpu;
-
-        XlnxVersalCRL crl;
     } lpd;
 
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 9e96c6541b8..e1f93dbb09c 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -40,10 +40,11 @@
 #include "hw/misc/xlnx-versal-trng.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
+#include "hw/misc/xlnx-versal-crl.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -149,10 +150,12 @@ typedef struct VersalMap {
         size_t num_cframe;
         struct VersalCfuCframeCfg {
             uint32_t blktype_frames[7];
         } cframe_cfg[15];
     } cfu;
+
+    VersalSimplePeriphMap crl;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -213,10 +216,12 @@ static const VersalMap VERSAL_MAP = {
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
         },
     },
+
+    .crl = { 0xff5e0000, 10 },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -1113,31 +1118,28 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
     sysbus_realize_and_unref(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
                                 sysbus_mmio_get_region(sbd, 0));
 }
 
-static void versal_create_crl(Versal *s, qemu_irq *pic)
+static inline void versal_create_crl(Versal *s)
 {
-    SysBusDevice *sbd;
-    int i;
+    const VersalMap *map;
+    const char *crl_class;
+    DeviceState *dev;
 
-    object_initialize_child(OBJECT(s), "crl", &s->lpd.crl,
-                            TYPE_XLNX_VERSAL_CRL);
-    sbd = SYS_BUS_DEVICE(&s->lpd.crl);
+    map = versal_get_map(s);
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.rpu.cpu); i++) {
-        g_autofree gchar *name = g_strdup_printf("cpu_r5[%d]", i);
+    crl_class = TYPE_XLNX_VERSAL_CRL;
+    dev = qdev_new(crl_class);
+    object_property_add_child(OBJECT(s), "crl", OBJECT(dev));
 
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.rpu.cpu[i]),
-                                 &error_abort);
-    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_CRL,
-                                sysbus_mmio_get_region(sbd, 0));
-    sysbus_connect_irq(sbd, 0, pic[VERSAL_CRL_IRQ]);
+    memory_region_add_subregion(&s->mr_ps, map->crl.addr,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
 }
 
 /* This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
  */
@@ -1340,12 +1342,12 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     versal_create_bbram(s, &map->bbram);
     versal_create_trng(s, &map->trng);
     versal_create_rtc(s, &map->rtc);
     versal_create_cfu(s, &map->cfu);
+    versal_create_crl(s);
 
-    versal_create_crl(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
-- 
2.50.1


