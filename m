Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3D7CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9l-0004Qk-Lq; Wed, 20 Aug 2025 04:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9j-0004P3-If; Wed, 20 Aug 2025 04:26:52 -0400
Received: from mail-bn8nam11on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2414::605]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9g-0000xS-WF; Wed, 20 Aug 2025 04:26:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW3W1Q7OKVvL3VlCzouYfQPEJvSNj/ao9+F/L6ht2AT2q05JgGJAxpYDirCvKIsUCU9nTIVPjyV07jHoyn0k2EvxVYDxHBCzqj1U0WDU1r+l99fhJbE7wlXq6u3yAFfnuiQhoi8tvuPhr0m7ig5fJT7wzjfGO2Ge7R9zOkfeLfjaGaF028rMIDOMi2Dy7HPxiUHDH/Nu3cEgP2Z/tzb9byFtr+ceyCJpuu61h8x5wiXUKZiCo1y2S4pzD8+mIuLN94nBaGGZX/kJdLiDyqEf9kGfGZgjpQroa1hcoaVpJ/lZkFhekTLW95c88b1SDJq6FRCOA8CYXvspm19M2p4F4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvBhc1xcchn6NlVjkVJ1U0/AKo5axIcwbDMShqbYs5w=;
 b=MjbxzWE5HSwSTMKq5oF00mpsDf/LjM6i2DJC0e8trCodUO4bOHyHp9Ge1VfGyQHFLgSDlseEHollChRKeytJzIx8BaviO6hrpQ1jWaO+Lf6Ye4iohql9SHAzXp4xolEcZnpY2p8ZmQhprWFzf8TDHzLAf30RgLdI3GqLZ0dpyWR9viBPuLiVSdrmhSmO1pzpDxi0ZyJ967jMsMx8YZEAnbwZn8isbp2t1L9NRzm1H8hyXaYdsdJrjiFjbI6d91vbHcx1zZr5k7wFIv1Rl8svnYPKZWYc332mY9n3X5rAeyC8B7jliz0EAwr3hegKRnPnK3YJaHq8T0bvqzB+JZU2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvBhc1xcchn6NlVjkVJ1U0/AKo5axIcwbDMShqbYs5w=;
 b=rFl6/dKIuzrvTpZ9U4VsAHfMHd9zJDFVDDMKOrCAA+kaNW003S5vfWkdnLhU1gFkH5ePbl8Rnjl7je9YmxwFJpB0pD5r20HpLxGaaOh+3H2OEwByM1DmfhFtvJJqbaN5QKMMGvDJGEKhJ8ar2HSrFwmZLuLND8mdn2utxG5SAVk=
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 08:26:44 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::ae) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:43 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:41 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 18/47] hw/arm/xlnx-versal: crl: refactor creation
Date: Wed, 20 Aug 2025 10:25:17 +0200
Message-ID: <20250820082549.69724-19-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 86734cd8-f6db-48f5-9053-08dddfc34bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ngzPAh1Qm0+BWln2DCuJzLvH9LCo+DPuVhwNtw8uKC3TXZNiYrKxEHg84v0P?=
 =?us-ascii?Q?npvum6yJi1qxxEoL5cupOEpkjrMlqAdURMtRi7jKnzwfvZzwxrCb+TMGipFR?=
 =?us-ascii?Q?6AMggOIBdC52ihRwOSEoUzFk6Kv7YkW1oxWZiLQ2NHrHLA78/qlW6u3u/Q3I?=
 =?us-ascii?Q?4XWur84HIVEKhOCm+J3noHl/cXEBy8Yvi/HJffv4mjYsrnJWwXYSGWCwOBLw?=
 =?us-ascii?Q?OoR/tOyQ58CURCZms5JFbfhqTyPRmtDLwEJl5FLM8M8m7LVaMvwtTY+is8cb?=
 =?us-ascii?Q?ffrNOtE5lXvLNs5p3JoajEc5jH6/ZdTXdfvdwUB4vKIe9dM9O+OU4Ybtd/LM?=
 =?us-ascii?Q?H/4ruYe5mPfezKayGlaDtWU8Ob+G9jtFb/5vTyIUzxUahDz0EHoXDNQMRTVq?=
 =?us-ascii?Q?k9VD/IgbnG/arEoRQEjXmMjWyeL8UEBklXxbeoNcbY6DMIhumaHKmVJbMDdB?=
 =?us-ascii?Q?6wetxZu+8Uo6Abbw2l0/PZGWRHr9v+/ko5MJToapQ+RP4to2PYI159cgD6KK?=
 =?us-ascii?Q?kg7Ve3YbTehNWlARix7weBng6E5gnv0ccMrmHO+POQ0B+uriF3Iiheg/5axc?=
 =?us-ascii?Q?N57UlhgFvF1/Ubtv/ajr4pqjylfU2QbYtMBcCPaShc7skZsviCbQwEa8qHg0?=
 =?us-ascii?Q?EnVWWSSDlKpZcY03UxdVJPrfSmr5ktJ5HN8VWF5jbyOypxD816CMDvjsXh0J?=
 =?us-ascii?Q?I+irp0ThGq6p3wZk2qF5K5jt5nK10EHxfdz4EMpAxkXs3emOycdcGspWDSPT?=
 =?us-ascii?Q?e1eGYR9Mk5a6qJsW5StTOogkX6nJE+hmxUAyASW+Vct8ByP8EEqoHkLU3Fio?=
 =?us-ascii?Q?JkuxiHDW3Q0OO+mc+fORtCpyZRce4JFaw3fUUAZb2ANT2J4oq/FF/m9IvqbT?=
 =?us-ascii?Q?qozmdE/i636+8pDBjErrNW7q7Xcu7ZbJipMZf0rg20xkulT3uznwmpwu76bf?=
 =?us-ascii?Q?65NIAdaHigrVQk/QxaWFc5PyZUwr9aaXXPvVfRQ+sqA3v3pyGnkyqntS8ADn?=
 =?us-ascii?Q?f3cUF0dvT+uXLMcz51fUJ3/25vmGYNrY/mKFF7bTsXxplpu7Gt9HUI1eSZXg?=
 =?us-ascii?Q?iqV/r+2NmYN6RCDnUcJ9UW4wWM9xR9KGNmGo3sMdMXgQLdyHK0MJmmjM2P8F?=
 =?us-ascii?Q?TtgVl+N+Srkd/y8/BStyBYZa2D30wi5uT5eCW7UF8gTgYBUA4xj+VJU4dujs?=
 =?us-ascii?Q?62x4dXzDRtuKNnlQk2S0ygPRC1JYFIYHogly2zvYCYpdQQgU02TVwpNU0C8Z?=
 =?us-ascii?Q?VdS9Q+Hbk7HS6D0QlOn/BvMq4sT8xGuBhf8NFyKOciPuUl4wppMk0hBp12fY?=
 =?us-ascii?Q?oEMWtSp7G0TiTJdNUkloFyUyii7tqhgwozEYu1q8GxVkEo/4LRbb9YKP6jdZ?=
 =?us-ascii?Q?TWjAVjgb0gYIQAo3q2aDiunS3LnSUpRApIgq9EFGX04VispIqsU69sDZ3x8O?=
 =?us-ascii?Q?6lisTSOPZTnvo8C42QqjVK3LSC716UQUpXkCxSPiFO7WWogQ+Wr1i48U707b?=
 =?us-ascii?Q?HNT8WEjN0j633jvtgsWUhqFyZ9coNTucwFBt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:44.1201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86734cd8-f6db-48f5-9053-08dddfc34bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
Received-SPF: permerror client-ip=2a01:111:f403:2414::605;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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
index 2128dbbad92..ff55ec62301 100644
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
@@ -1106,31 +1111,28 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
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
@@ -1327,12 +1329,12 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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


