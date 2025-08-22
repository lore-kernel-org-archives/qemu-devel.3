Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61749CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTW6-0007tB-Q4; Fri, 22 Aug 2025 11:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTW5-0007rl-0o; Fri, 22 Aug 2025 11:17:21 -0400
Received: from mail-bn8nam12on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62a]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVw-0007BK-9z; Fri, 22 Aug 2025 11:17:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m++MTCsALTelYhxYXhzoT4tBqJxhamKFUZ2ovg4zbqXfl2vp08h87ER6cwa98pA9aSD+V7y5r0i0Zg5Wt8L02I2nGKLmrZ5pm4ZmfW+mm5AgP4MsdQIgH040Idph9EZb90RAa66nTdwnj1fjRhbiderySRtYYbn2pmzwFapLXSinosGbjFxJdwcJPdwx+ff5ZRzdxAZpusmChF4zKb5VvaYWeEeKBcsxgXEpUXla4r/GqDzx+v0EiU+KiJS4bQMpwTN8ahPBrPpIFV/Jaz5TfDt66fz+Bvvdy7zd7CNQgQLCsLfGNBaGIA1aaRBRZXPefPp7FrXLxGTE5F/zwEtqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQoM5bl5cXTqQ0Vd9sbYZWZ3ak8n0+c/gHfcKSVZbzY=;
 b=wPvfIlsutJukXLAWQd5WlNPZrmNVSRW8C7gZcoRWIztvK9nnFmNGhmma0wszUWIkWt5V1nNrwffLG+xXQ9MO/r3aqb1ag4/zasxuNO1yQ15C4Clz73us4sc1WSyleob4L15K82fKAXsQDmoElVMRfyCGmkIW6Rs98fSVOBuXphMnGdQMgZhD6hsRe6RJWM2VfRZDGtGBa/FFaA331/6SUU+51+ZfAdAtiez+kRPkjtIAzDUht1NaIcya12g190KaVUgo/tUqpge9zwHrkpjbeGYPzbA6M6cOKh19LKd9249ILwhc8Z7z4hGW+XOEVpKmQYVC92t5fnHUM+cPoUUFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQoM5bl5cXTqQ0Vd9sbYZWZ3ak8n0+c/gHfcKSVZbzY=;
 b=VuW/uZl5B1su8sQ7qrERLpcNGHicrlgF8Gm4fBGHnTy2Puc1EVgmBglnrFhpvTpWiXX4M7WWc8bU0RnEXFxU7GtH6QZ4NJmfJh+SbL93stDPAkgocnuShP2hv6IlIbgs5iSVOL/otrOOEyrCxTHiCzuz3VyoBEKv9oKnbsQP4Vs=
Received: from SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::13)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 15:17:01 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::9) by SJ0P220CA0029.outlook.office365.com
 (2603:10b6:a03:41b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:00 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:58 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 18/47] hw/arm/xlnx-versal: crl: refactor creation
Date: Fri, 22 Aug 2025 17:15:43 +0200
Message-ID: <20250822151614.187856-19-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 3394c735-9459-4e7e-ac17-08dde18ef1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eMTREfdKlaO8cMdIi2SqBsozPFgWmT+lwGtpGIJXbVnOvV4oTGCDaEkW80dZ?=
 =?us-ascii?Q?BQSu0SHFqK3yanwgImVLDJprgbiafDlAgAKQxAzNfD/c140HOxruQeYk7BBE?=
 =?us-ascii?Q?7Jxb5ApaXJ4jBiK24p8DCt4yker6YwzJddRaBoYgZsmZbqO4KDWX6Xp7/7q1?=
 =?us-ascii?Q?KOMnhEPK4CPOmlYfiP8vgyuJFY+fr7U20WXpf2huoQGA/CI4RTFbgMwmId5D?=
 =?us-ascii?Q?t5mMiZnjOCDSQ9fqf8d9EbvaTakxHgBnOwPoHE+cfRL7ilrWiHtBrlLpepnW?=
 =?us-ascii?Q?++Aogkg2quHHurQ8SIEhqH1pVSkCoifLqVhB/AKbdb8It1sQwsHdHefoo1tq?=
 =?us-ascii?Q?5DEm2cnl1Z4J1H7sM+068lWnJ+UyD6WXkI7MZ9IhsJ09biJ+6+feIDnEU+uR?=
 =?us-ascii?Q?byjeuWhLl2wuzEIr91y0/ghJHHjmSqDyBqchOLf2YkExa4eqM8dZWdTCA5jd?=
 =?us-ascii?Q?Zr+twoBB0coa7n2wNATp7zvnjkhI+8P4pcZVOBT1F1TQHme7OB/2uyujFvZv?=
 =?us-ascii?Q?U7JGQ2dURr80q2e2JW5HhZLzHauS5cGHgMiIhd8FE60Fi/w/t+OBXT7gsnQS?=
 =?us-ascii?Q?Iv73PI92t/1V95JHkEk/VHTHnrqY0pK4WKZmnCKAI9ERjey57vRZUuE+HCdl?=
 =?us-ascii?Q?yfc+6i8Kj7Z2kA0LbVLcZy13cXFsMr2e/cydMWRkyAkGWbb6SLxOiORw1fuk?=
 =?us-ascii?Q?oXVNR91GceENSEwRXVOuZI7cg0ARuv5vG/fXYTWeqrGnBuehZg/bWRBNialR?=
 =?us-ascii?Q?fxRJAqM53sefKbj+d/UGhSEQIUO1W1MAgF5jL+1ro9PyJ2wEgCSZDMMcQGP9?=
 =?us-ascii?Q?W2TcdFGhW7vqRWXKMdvr/68ppDQr3hYb/kbIMDR5Zmi59KVMWZDNlvYAoN6z?=
 =?us-ascii?Q?Ez7Iph5ZP410lCBa55WeAtckJj2+SP+XZMrOWJW7AW6cvxzzKrCuXgujLaoG?=
 =?us-ascii?Q?AZpFpfos7k54SLS6S3If49alZPMThWJjgETx+LW4W2ywnHIqxaGIJa08J4oi?=
 =?us-ascii?Q?PIqM4lxthYWrFfHWpkttskh+49v6LOGgzcfBs5Ki+75iXNITl6+8L6G3h2RI?=
 =?us-ascii?Q?Nb24A38X2sguQxpQrotPxDG1nev3wRMzXn2u/NnMlzBcUpHDzJcG9AKM/f7B?=
 =?us-ascii?Q?LMVL4ckBZbA/809CDYdbYUWtr23C6IDflImByl8TzZxvi7Z0QmDpnh+DR/5f?=
 =?us-ascii?Q?foFF7TJID9i3Htlx5f89sx0HheJavYMab+7p4NTErcZQtYza3N3jCvc8usfK?=
 =?us-ascii?Q?vYWzFDyKZ7j0N+UKI9wniRIort1mf7Am6nx2GrtRkmHW3ZUTiRvlDu17lzDe?=
 =?us-ascii?Q?lKJ4TV5Qy9ItU8mptxa5dvHao3SIy4Bp6Fo9v+x2dI2LOCRgFaZddLOGsbdk?=
 =?us-ascii?Q?Svxb5qJC+TcSDGvioB8vTGpJOEJZ6ZAkLe6NwNZY/AI10aaUXmnGkktzJ4Ld?=
 =?us-ascii?Q?4FQrmv0rXua+OI34TuTdzOugRCIY+bYOi/qd2AhrORGgKZyDEVeJ1kfGNwYn?=
 =?us-ascii?Q?tMQFjmRaNCCIL8fUHGwBson/sr5H6xsV1j5q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:01.5875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3394c735-9459-4e7e-ac17-08dde18ef1f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
Received-SPF: permerror client-ip=2a01:111:f403:2418::62a;
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
index bee0b2bb39d..1ef12de4c8f 100644
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


