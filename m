Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2DBC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WZe-00047z-Jf; Fri, 04 Sep 2026 12:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZX-0003v3-Ll; Fri, 04 Sep 2026 12:15:25 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZV-0008SI-TV; Fri, 04 Sep 2026 12:15:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmmhRDkC0ow9Y39cnx3Fi1lNXB3zGkY6s9pWOuIELb2dcTspX+cP4j4Q2V8IpFzP1h4sleIoFEdhI07M/B0PwndQvyk4c4L6vvrZGYZZ7DJN7V9j43Fmcuh/YesIkeAYwKRipMxH2eKjb/o/Jy27+vk1KP0naz27itLPKoCD/jeiGiNi1ELVUzBx8O9K8FaLW426JH6xYpR9Xt7gTQUnE+axb04U1VYOe6rdqN5jROK/6lgS4e5EFQw1uFzy+cJtSHL8VTk23HKsqi5YC+WhDRuWbdb95myF1jllFbNVMKeAbA/UebmrVOkq9zr9YALWwjDluK7O99PBjBwmZapAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKw5bKnICsLQpHcRDdRP4OIxtO2VXVQ4UdCGkcKiDAs=;
 b=aq9zFmz18NcRogKFHbHwh9Uclpq6uXypS25QWvcP3sFfgaYhUflljxazOxIORcTAkmGqs/kD59LuHrKuUnsH4vceuQtvbMIJhPlLYEugbWsZAIR1DG4C2JO+2KxN5zLvDguQdcWFOyuycmstqvvJBozJAis2fEJ4eIgeJFsK0dTcC2DMs/Dt0tm5Tnnkx+6m6tixdXLHndfTiXAflUch+/zZRqUk/9iWJpmSGDbDG0ReKq0NAUvCol7vGWcvn0kcLDmWF0kx59lRltiDoCEVn2X0W7dhzUW5NQ+pFJV3WgUB1HdIM/VaHBbCYTfKMWK7zv2YgHJioYm9U2QZvh4mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKw5bKnICsLQpHcRDdRP4OIxtO2VXVQ4UdCGkcKiDAs=;
 b=IxMfeHZGXPTQx6rMG7MlXZ1MA/XspCpCTGYjf0WVFuClKs3cXked4bpRtfIi9LaLb8J0M00Su7+VyrkgVV0ycOJSFpZAes9fPiHdsHDzI37OJOGDoGetrg/rSy17ATTHI5Eir7/LgpmPJwtO5Dkq5fCG576o90x7jGgYRNr3U+f8zOXtVWwSWM85DY8q3hPlZkbbHm8hOWLWPtiOP7a1DZ62iCMA9sZNxVHIIImSi0XP9T+cMRAvmOTP071MGNnJDc5zREMjR0XMPVjceRtn8+Ikvmp/lThwiTlvy5ABkSn7AEI+N5aLefZfZYPm3OF0PYd8NXxp1x1Youmo4/lE1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:15 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:15 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 04/10] hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
Date: Sat,  5 Sep 2026 00:14:27 +0800
Message-ID: <20260904161438.3838261-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161438.3838261-1-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea19f3d-e47a-4e90-4c9f-08df0a9fb46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: da8IVdmu7xOtmttTm6g/2Hm9hsC+scyu5stvsAYnZU0evdGul5sKTeHVECfROrwVP/DlrxNSqHhtQJdZq5wW5Lvy4wKtl+GP4vVB308TjOHE030JWpR2ceuVAvSeiTRFzT/X7AQJbtbemlA8d6gBRLauWG0c71S07eYqQ/FS3xCb93exVswt/uokxysDI/PnlCHNzfSBN7cf40D6XIdTdBWxX0S3ldSVpu7wieI8z1XREL1n+XXj6D3xw5JaJbShYwBbPUCtXe2xSPbIJpuhOtERnAsxz7ia8agMiHU7unEHDvJ3KeN8zDSw3Z4+0dapDQYLaef8UegoJy/lMQbktCYEJnLP2UvUEKpcBQsvgAmHpp0O+n9Izo70BoeF+xPIBCz3UW40aPOvr6TzmD/5Lo1E/Ip1dE5m0hwkdsJL4GdUXZu0dYfQVWdtcaTKTFsNSOYp1weqjS+aZHi03aUH+rb+NAxm4YLJcF304NXTWnTNw/Ux1anOYFQX8TgDbvJUB/s5vHdBKn/RQ0EKt6zBO/L4uvASyi4bVF8ODuaLelWechN0DiyH3F+Kelck5a5dJ15d6YT7VsKibjifU9bW5h9E5IWuVTAoJQ1ezNKum0i2a1Fw0TnbPVY8JamvDwQS4htkXmUeVH+zrkPz/R8eKtkWNfCxLmH1unyaMdhOZ+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hW989v9hF+UlWrCqAERy35itYcH2wAb78x3T90BNNHExQDReBDyCD7yspkfq?=
 =?us-ascii?Q?y4lTyC/zX6KSHfvOh3ouqI5R/4oxhH8bg3zCS0SMUny3P+FsDefY0taakaic?=
 =?us-ascii?Q?MMUReqZv1s832pOvIviJ4Sdaa54LRVRPVsHn8SdvA5FB0ddbGns1GdB9r5T3?=
 =?us-ascii?Q?uIrdPcerZ0Den0M08Uwo3aeeOdzbfBGat2Cp4rChzy+0C2U9GX6cC1kJjCTE?=
 =?us-ascii?Q?jtAfCK/mIHJaoARXyAy8mkGXSmsCwEegRGK/omIWSrh7zpbRpplvzIMEeaBl?=
 =?us-ascii?Q?emEtQy5KzIA1VwoBvLNwmboa9etTzvhMkNI8rE/wvqKY7d/rAdSZRvgEuZRk?=
 =?us-ascii?Q?bbfXeI2508Hs038t9PRICJHcm/4d4N0CRwqad81nmUJzeyazDKPzmaElVJh+?=
 =?us-ascii?Q?qRKQ8JswkUtlZnRKayeOOlsGNufp4CB2ePYhx5/FB3O+Aj+rytj5e7DU+BKe?=
 =?us-ascii?Q?ZTN/CoostwbwIF0QHJVylszFdOIw37XnwDbq8FRLYtiOftJxwbpy2fCDeDZt?=
 =?us-ascii?Q?NqYk5YT5nfEVqXDywcL6sq6BFc5rkJiw7vlgSAwOYnOG+c+qr4p9wX/TJYh4?=
 =?us-ascii?Q?cUYd0hjvwMCWjtA030vveUqI3p1Kf+eFrivRVv5O7/SvPqHahIZcgaPw16cm?=
 =?us-ascii?Q?sZDVNLz16O0tMIoagyvuGvO/KtuQRmx+o9wxRJYOJqyHfSFL0Z4z3891XEmQ?=
 =?us-ascii?Q?fuFkYIovSPGJ5s5W2zLkunMNKbrUhXxSK991ottJsSPLbbdndDY67oTP3IQK?=
 =?us-ascii?Q?czG4juvPbjOjqYFqtpxBCDsM+hraGkR8IFsTvTx23i8ZRchfERRq3bWvyJYI?=
 =?us-ascii?Q?BW5tJ34yTxe2jdOt4QLBXuVZHhKrGndR9D44/g2lb4Z3gI96Ipos7xjKQNKZ?=
 =?us-ascii?Q?EaUCcZ2E1dAgD4sozTI6N8A8zWgJNyIGPOk7S4gYE6O5DN/DM8Za47TlzWkC?=
 =?us-ascii?Q?eVfgdqxGJ5QKUtqYdlTPb7PyiVqoLgDROg+Zce5Qb4LZTuANBR3EssvVzdqQ?=
 =?us-ascii?Q?2WlU5uDWBGgwQDWO/GWINeqQ/VOKyVBynlr/jd2pzn/omzC5eWysVdFXWPSL?=
 =?us-ascii?Q?zXiSz5Y3PSoLQIZTVehQf63aMqVkTp9mATbCEErKuCj7/y2+ve+8sYdmNeVJ?=
 =?us-ascii?Q?uixC0VpX6DPB7IiqINPejE4YRU2KSnlG6Qp/UQ8BmkJEDEE4XhzRXLb1rB6U?=
 =?us-ascii?Q?DNM6qIEe0hTHakoC/kX+Drenz/MZyNVGctmqYg5wT0D8cQONAIv/Z8yoDtHV?=
 =?us-ascii?Q?i0n8hL/n31IHr0nn8wK+Jg7U/JpsYh/c1k3MV7sBwRkBS9C5NYVlO+WZY1/J?=
 =?us-ascii?Q?cNd2TeUpANMeGtJLJ0X6zVxDXr6w82b5Zt9eFG3sEtEUUNC3cWt3Q+fBVgNW?=
 =?us-ascii?Q?2sB2mjGR9Y+tFxVWQjJJ1RXL4oGd0fHM44DVwNEsp5g3yT8/Jf9IaNbtRDy+?=
 =?us-ascii?Q?2e2iVXvT9pxQRxB36utCSriw5lJ3h/5I6OkxG38UAFLZCPqucsuGPZGkrQi7?=
 =?us-ascii?Q?6WaNknFP41kggxVFWcfU4W5dkrX5JL/TvMg3rFL8ULVACCWWuiAXUpVLTY5j?=
 =?us-ascii?Q?KrZxYSVhC6FrkorHt7OWw+xPYDNKpAYtDwiZI00BkTxKEbDKHcF8SiiDMzOz?=
 =?us-ascii?Q?gP08r6rQ0neeERjb/0rRvsuxIOr0Ajhf+/Efeh3jaSVwCLFjj4dGRAZz0w9F?=
 =?us-ascii?Q?zu7r48WeuvSraZBSorq2sd2I7gGT/rBdJ+BfCJ07v+BNmJap5/LdAk+bqSp4?=
 =?us-ascii?Q?df1cfYi0G/99reOKpTF1umpHd4A0Ct0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea19f3d-e47a-4e90-4c9f-08df0a9fb46f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:15.4280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iO6i4O95FnODbNnEKnZKRKMq/XxL2A5CsC7lafAVzl6Hiq7ruZ+2+qC0QSCBxjre3xCylx+SrVvzXOKlj4627JeNo4PkMe738qVCykXhbUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

U-Boot probes DRAM size from the MMDC MDCTL and MDMISC registers.
The existing unimplemented region returns zero, so U-Boot cannot
derive a geometry matching the RAM mapped by the machine.

Replace the placeholder with a small read-only model. Use the
8-bank, 16-bit DDR3 layout of the EVK and derive the row count
from the machine RAM size.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 include/hw/arm/fsl-imx6ul.h |  2 ++
 hw/arm/fsl-imx6ul.c         | 63 +++++++++++++++++++++++++++++++++++--
 hw/arm/mcimx6ul-evk.c       |  2 ++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 6205fe6b77..bc0baca721 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -90,9 +90,11 @@ struct FslIMX6ULState {
     MemoryRegion       caam;
     MemoryRegion       ocram;
     MemoryRegion       ocram_alias;
+    MemoryRegion       mmdc;
 
     uint32_t           phy_num[FSL_IMX6UL_NUM_ETHS];
     bool               phy_connected[FSL_IMX6UL_NUM_ETHS];
+    uint64_t           ram_size;
 };
 
 enum FslIMX6ULMemoryMap {
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 74c1a30959..473269fcea 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -25,17 +25,75 @@
 #include "hw/core/boards.h"
 #include "system/system.h"
 #include "qemu/error-report.h"
+#include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "target/arm/cpu-qom.h"
 
 #define NAME_SIZE 20
 
+#define MMDC_MDCTL  0x00
+#define MMDC_MDMISC 0x18
+
+static uint32_t fsl_imx6ul_mmdc_mdctl(uint64_t ram_size)
+{
+    unsigned int size_bits;
+    unsigned int row;
+
+    /*
+     * Use the EVK's 8-bank, 16-bit DDR3 geometry and vary the row count
+     * so firmware observes no more memory than QEMU mapped
+     */
+    ram_size = pow2floor(MAX(ram_size, 16 * MiB));
+    size_bits = 63 - clz64(ram_size);
+
+    if (size_bits == 24) {
+        return BIT(31) | BIT(19);
+    }
+
+    row = MIN(size_bits - 25, 7);
+    return BIT(31) | (row << 24) | BIT(20) | BIT(19);
+}
+
+static uint64_t fsl_imx6ul_mmdc_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    FslIMX6ULState *s = opaque;
+
+    switch (offset) {
+    case MMDC_MDCTL:
+        return fsl_imx6ul_mmdc_mdctl(s->ram_size);
+    case MMDC_MDMISC:
+        /* EVK reset geometry: 8 banks, bank interleaving and RALAT 5 */
+        return 0x1740;
+    default:
+        return 0;
+    }
+}
+
+static void fsl_imx6ul_mmdc_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+}
+
+static const MemoryRegionOps fsl_imx6ul_mmdc_ops = {
+    .read = fsl_imx6ul_mmdc_read,
+    .write = fsl_imx6ul_mmdc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void fsl_imx6ul_init(Object *obj)
 {
     FslIMX6ULState *s = FSL_IMX6UL(obj);
     char name[NAME_SIZE];
     int i;
 
+    memory_region_init_io(&s->mmdc, obj, &fsl_imx6ul_mmdc_ops, s,
+                          "imx6ul.mmdc", FSL_IMX6UL_MMDC_CFG_SIZE);
+
     object_initialize_child(obj, "cpu0", &s->cpu,
                             ARM_CPU_TYPE_NAME("cortex-a7"));
 
@@ -228,8 +286,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * MMDC
      */
-    create_unimplemented_device("a7mpcore-mmdc", FSL_IMX6UL_MMDC_CFG_ADDR,
-                                FSL_IMX6UL_MMDC_CFG_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                FSL_IMX6UL_MMDC_CFG_ADDR, &s->mmdc);
 
     /*
      * OCOTP
@@ -745,6 +803,7 @@ static const Property fsl_imx6ul_properties[] = {
                      true),
     DEFINE_PROP_BOOL("fec2-phy-connected", FslIMX6ULState, phy_connected[1],
                      true),
+    DEFINE_PROP_UINT64("ram-size", FslIMX6ULState, ram_size, 128 * MiB),
 };
 
 static void fsl_imx6ul_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 40071d2c7b..bbc964a3f7 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -44,6 +44,8 @@ static void mcimx6ul_evk_init(MachineState *machine)
     object_property_set_uint(OBJECT(s), "fec2-phy-num", 1, &error_fatal);
     object_property_set_bool(OBJECT(s), "fec1-phy-connected", false,
                              &error_fatal);
+    object_property_set_uint(OBJECT(s), "ram-size", machine->ram_size,
+                             &error_fatal);
     qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
-- 
2.53.0


