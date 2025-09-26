Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA7CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22aD-0006Uy-Qm; Fri, 26 Sep 2025 03:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a5-0006NJ-Al; Fri, 26 Sep 2025 03:09:25 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zn-0006b1-IC; Fri, 26 Sep 2025 03:09:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxk7SDwzOQ6qFFK0q2B+QNP2SJmbI2SjVbfB4K7AnC5KralxkT3YBegEOSWaSJvTdxBge6Tq4RC2wtrpD0akwCO8lgsAb+Re9VaMDXtjDlERus9JSQJDxK8iIdBbO/Ksfm1TZHTIThA37CRMvALFm7W8T+aShZfP/liaVLR7KpeuVEmlhmmhYGfH4od7mqD/eZEyFPothP8Nr2yaO4dzVXae+Hzy8ur/+OBsUROrZU555+n+KyhgoOwyYvt7fywk7G54W3kJWJZDu/Sp/tR5FBVSOuqo+6fy2KH8GKBBMTRUbmUbvOOsc3gsuh4xq/6cQUvD1GgBdfvQZ3d2EVa+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCE5TWKyfTOLKrm7F9YbWZ5y8wQp+9n7IkavwZSLRLw=;
 b=xRGWv09Z2UrVzUHG+QK5Az4JwrfYKqgHCd1hlfMME2O0Eleoan+FUcDlhmkHyz76fL4fILX/7WkWGhiMW0fB8+rSsClcpv5FTTXykNl+PVaTsp8laU4Sw/+PLkY73QMI1KDFM/tzsq7rJNB2UGBxMo4+zeoov1Uh92fHOnksQwVzAMCK3lmz4VgBFSv7+6jgTNdjWXTkwfy2ynjQsrqFWaG+rSH/0oEZho4BmrROQ2lVdYkHVmrXSb5IA8l1R1Jbmxorl+GLmPVUr/tHakI9CoaqTPYAxPUpi8ALCVGbhm8JEqLUBq1X9Tb+8IVGSWhLlBP7f6vqdHcQdYM3Q+tzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCE5TWKyfTOLKrm7F9YbWZ5y8wQp+9n7IkavwZSLRLw=;
 b=ZJy1bMh4N5uZMCwUO/w75OZ8hkZq0+xaApbsh+wpg/SI1o8KBgAdrezSyXxM/2Ct3VGwlq5QOJNy8YY9ZlqWMcn3nk5hfnJd/Ek3UnsnvVlPWlgQ6zQcsIYINJk0Se8ceHKTSpsZVQ804hc4HULDAsvNQJDGYxkFuATX27o35uc=
Received: from SN6PR08CA0018.namprd08.prod.outlook.com (2603:10b6:805:66::31)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:08:56 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:805:66:cafe::59) by SN6PR08CA0018.outlook.office365.com
 (2603:10b6:805:66::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 07:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:45 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:08:45 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:43 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 18/47] hw/arm/xlnx-versal: crl: refactor creation
Date: Fri, 26 Sep 2025 09:07:36 +0200
Message-ID: <20250926070806.292065-19-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 0486e84d-f639-47fd-1ea9-08ddfccb8eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LImvLA4ih8ro3DHBTOn8WmWshFsgiODft2oqpVCcCrRHsudNYX4z9zQm35Y4?=
 =?us-ascii?Q?RjRoTzDmqGig1HHQb+1MiCyvEo0gMWzgTF1EZ1I4Vj2CwI/aKScEtGlc+2N0?=
 =?us-ascii?Q?TVHr8U6ygOJw19SMrFtiCVakzrUKBWyILNyb5wyh1Wg9MK+6CXs/pJrQNqxL?=
 =?us-ascii?Q?YFAnaAwjB4+I05WadF+prPQJblBFCISFyKdGvbBw5iCxELPx/R7P0pJFWRtc?=
 =?us-ascii?Q?rf9nyGE4Hyj+qDTODRpfxU2FIolj3El2Ui+XVW1fEPPuYuvVgvP2Hp1h2C0/?=
 =?us-ascii?Q?UrFlGGY3mf8xMC8qHb/VD/e/e+vNcacvcZ88LW7FsoBMC6MRIjoyxgkqa58E?=
 =?us-ascii?Q?/5aWjM2Q4LluOdH8lePDbowt58eWavo7xDl/fIadAxWHe9WYbyeQ23/nNtdq?=
 =?us-ascii?Q?3VNyWt7R3+7zOyBy+MAn0aQDxue8O+VUKaJ4kCBzo6c4YbaMw4xrTpoTo7Cq?=
 =?us-ascii?Q?emV2xrxtCmfPAMvKdUNpHNmOnxDQkPLXKwGT4VQh7/2TwuZmqu7qmXO0mM5T?=
 =?us-ascii?Q?YTiS5mPdosScqlH4+3NjE6KhYBMn9s8T2nsp+KlYGYEBmf+erkZ/JuVKbGr1?=
 =?us-ascii?Q?P+yZhuN+2qvQ2nXeA4sFu4RA3LNj61VG0MK2D71Lzdy8kJu/zvgRb/ViQrR0?=
 =?us-ascii?Q?L9CA7XoriIJUNQlKT4Qy0Zk/kuIdWl6XQbC91CbcqkXAqDyAe+mDdfm5f3j1?=
 =?us-ascii?Q?ZmaJObl3pE9rnE1GvD1Kx7+TgsCUkRe5TJ631BDWtqsSZ83cN+bXAi+STQ9b?=
 =?us-ascii?Q?dAUJZThxtU7QXVXX7/CTFWoMiOx/XwBJUMTHJOECk1pukLP6ATZt4xXiTZIW?=
 =?us-ascii?Q?pPi2GZr4SocC/GmdQopGsC8DoOdBT4jlIMPEk9k///3t61FJ6liZVrWyo9Vl?=
 =?us-ascii?Q?L8NDipAYFlspkQ9Y/Dx0NY3ETZRtW0B0mCSKQjmZO9QUk6pgSMWXy3cWwg9i?=
 =?us-ascii?Q?T07vX5YqPq406wdd163DHiQ9Jf/R8oSwdL4nQFpOIsmUXvNDPIngfAuRwpdM?=
 =?us-ascii?Q?j7DK5f/KLjWXgwuZCGiCllV7FCYpZmBggveRlUGLW3Yjfi11+iKMwR6mTPe8?=
 =?us-ascii?Q?7o5eTFXB3ibcPNRF5MzT+tWnffb0IFjmEWzgPOO94tXcifMvmIQIu4cdlMME?=
 =?us-ascii?Q?2sNZidkn+sEJ4IjVnP1iFDLhKHCvwevcvCkLlKx3DmxnKKY4vlq9jT/WVxe5?=
 =?us-ascii?Q?ZaQaKfcUcxgBMTfz3EDLwxyD9jLmiUKNk3CVZpZ9M90FejjLBecoUQPPGUSr?=
 =?us-ascii?Q?p0D9ggwvNnpRTfCWUsfUyO50oMwc95a6+vwHwuHzpYzkjE/WJAt/xgvrNniA?=
 =?us-ascii?Q?eVQjd2A7y634g+ZoFjH2e8vXOFAEmbDEVUYKNVWimV/JIG3W4dQWTLmrWaUS?=
 =?us-ascii?Q?Mvq+S9RFtImTVW6L1heX8VSSp3UtQqpqb4qU+3Iid9kIOfhX0R5d3L8X8Iol?=
 =?us-ascii?Q?802eoMifxNU/eMozuAb1MnXludM01a1TjzMIvU3fjJUz0cl5nIyLi2CWqY0l?=
 =?us-ascii?Q?AfBqLEGTaoR4LUXcQ64CN3rkBPhPXeh8Oo1TVjFPfXOdtMJh5Ht3ghurv2CT?=
 =?us-ascii?Q?64k/l22kws+njHoMhhc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:56.2162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0486e84d-f639-47fd-1ea9-08ddfccb8eeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=Luc.Michel@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index 81adf8d35b6..f5f98a3030d 100644
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
@@ -1336,12 +1338,12 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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
2.51.0


