Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB99CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22a6-0006NM-Ez; Fri, 26 Sep 2025 03:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a0-0006Kg-Sn; Fri, 26 Sep 2025 03:09:21 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zj-0006bK-UW; Fri, 26 Sep 2025 03:09:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqJu36QU7sBEycfYXNkv3teW9esui78OwFXkJX1UR5Qn/NxuK2p6EgLz77tfa034ki9EQidf+PUt4v/fyb4skxmvtE298wTN+LHtxkYcwXrrcaB7DxhFVvwqp8+aNq4muGKJysw7RluD/g4+SttElzR/5Y09jgm5v7SEJBzZKXNiE24o9ejIEaIMQCLF/ICsy7LgxaAMzmvFAS+cbJGfPF2qLD3jEjMDgiO1vODh1eubmdlQl2Sem1x0plsb1LGOdHDSZkX2L27gNhv0uGEFyycOiMts8xL2+s4AlK67D9HwX8cEtma9JNPT+zw9Gmorh9KX90IRygNFWD6i5zCW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKBl44ppiIblCP4dpE8xpK5LjXPs/rd3Ok1iiuREK1I=;
 b=egvaVEYUALiF/TxxmXS8N2dO+PYZytqU07MjdVZISrwO9YRnxrFjW1fsk9iuRacIMMqaWv8B2Wx0DSrX0QCd3xxbYswuChbbDJlfuOqiljD/OfifLOps35UTKj42Wt9+68A9O5CRVv2ZdgzgxCo0wMwkdh9WsOoVmafQPC2NjLjKbir3dNJ9+bz3bFHL3UFcAHgWkaj7DwGolJG5+jlvB//1h/lj9J60m6N70yyF2qOTkI+28IcG3LlQjq/sWhoN5epxaXGEvDW7oHp0CStGZ3dlbUD9C6vZq1LfMokklb6ltay7pTT4RnfZen1u0PlGcwHSYxZYLq5HcJB9fLn2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKBl44ppiIblCP4dpE8xpK5LjXPs/rd3Ok1iiuREK1I=;
 b=QS9/WgCX/axStSiLNc4/kyTZhiIbTK906N6uuk78eKWqX/nW7jJmNG/1CFE0JiOuvJmsVASsxhHp96cthIwDBjGBDj6LjUto+OrBdnWao7uIOekwrd9GqYR3cy6XhptymFhsT8GTFaP23Kc0K27drANjl9GLRbBJed4yMGLux3w=
Received: from SN6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:805:66::41)
 by BN7PPF521FFE181.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 07:08:54 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:805:66:cafe::d2) by SN6PR08CA0028.outlook.office365.com
 (2603:10b6:805:66::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:43 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:43 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:42 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 17/47] hw/arm/xlnx-versal: cfu: refactor creation
Date: Fri, 26 Sep 2025 09:07:35 +0200
Message-ID: <20250926070806.292065-18-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1a4cd7-0bcb-4034-6bb9-08ddfccb8d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XoHBZCAtz1uQTi5Q7tU68pOC1MMlzYKcrZymVRikQHzC3ReAiydWlTdr3Mv/?=
 =?us-ascii?Q?upxoFbLUAhGQPJvaMuJQrEG6NoxC5ApAzUpqyK+z8xtH5Mpt8xKYaVAnrxIT?=
 =?us-ascii?Q?iNeFkkzA+OnlAeD6AnKGxzk61eKo2Pxog0masKo+cJREW2Ak7/nlZwGlBNeR?=
 =?us-ascii?Q?BBJCRcWPnZ+PdS/pKvykSeD4rzi6hUG3VD6yit9tBDlj72CJJQi7U4gnX9Oi?=
 =?us-ascii?Q?VgDvm87p3QcbarGpnPOp7O26Os7UMjpSfyzPY7TEerjnc461Op20MqnBZv1B?=
 =?us-ascii?Q?AViQbqRFbhwndXW17jGEaqrsV/mZtswSMw1bNocTYLsmFWx4HWvs5E2RaK3O?=
 =?us-ascii?Q?5wZRbHrciJmJ7VwBPP8k/4YEZOvMjWXxkakKN3npbLex7OkAEUXhNaggb/ar?=
 =?us-ascii?Q?tUv8KLdtBWLhoFzPldvTE/1hAyz6NWpfrf9eSrn5JvsB+vpRfknKgzaV2YL4?=
 =?us-ascii?Q?eerquch+T/BAwTss3QtlmdqvjdeZ0rv+OipQyQzAXRKs1g54eMF1x42BgD9S?=
 =?us-ascii?Q?Xob1u6Kn4Ga5TJz6gsLVbMJ8jC429Exqf2TLI4lz/8aXkcGbupQ1n9xsrM3h?=
 =?us-ascii?Q?tP3XA5+6h8aOWpoflSjNnGNs0bf8AtXaLM0HCM3Pd4lkKwKxompD9p7Edq2p?=
 =?us-ascii?Q?aZQsjsh8AB/f6T8zOwOzBGDUPsTOy4QuWYjp4q+nc5+2H0g4UUmpBuI+PWLn?=
 =?us-ascii?Q?tMvkOOlFmFDqjGPZdxWrOrC0cCztJhDWjhK2SkJdNGtshV3IRpIPOYwkyBdI?=
 =?us-ascii?Q?3lND/9sLTcCg8vFeHFpZOt5lYaH50lpyR8JiFf3XEA/IdXPFSAeknPxCLvaU?=
 =?us-ascii?Q?RhpzlRnJTD67ODG+tIvlIhLtTIFHbJzeUZCKX5GVN1pfqGDXfPQFDghTr5L1?=
 =?us-ascii?Q?Di1xoqWmkqXdLsdZng/5qYTb8oLjqXgrQJIwTw8RTyA8vUuoSpny8LWBkgUf?=
 =?us-ascii?Q?MUHAh2z+21uWDPPl4Go/nzyB9GjPT4cT9P+N9hEedOweXzZbcCBHW/Woof8Y?=
 =?us-ascii?Q?VncCRwH2ODPJXP+WeT7yJGhRhkZrGtMT99D717NQY9rvXcLV/G0fdlQwDuip?=
 =?us-ascii?Q?NfVEFO+rBh1vwKba2x4IT+iz+EhiER7UhhnRpbffDqzbCoh0V6+JXBYJOeRJ?=
 =?us-ascii?Q?q/VktjjOZ4nA5fs94UfTSCYDqX+63hfX2ELWxbmeJCZA0rUswGSBzITPC7yT?=
 =?us-ascii?Q?le2Rpe6KtlopMhsw90r/AyZq5u+BEzaKD3X4v5RMQcgeOfecxX+uhoVmTuz/?=
 =?us-ascii?Q?2p0bQk5ooJh0+o6UZW8b9Y8y9nMSJJUy2b5nCvRSde5L1R4QR/ZacukFQL4I?=
 =?us-ascii?Q?mJSDV7IQyetajUSN7MZ+u1ZU6fhqHTB91a3QriaS4PMPmyzwcccnsxQURbs0?=
 =?us-ascii?Q?oqV8ZczwR/vwRFqmlK4vPcyofxVSny2IOMI9ezVzoXvX84U4zJfAyMTe6JZ9?=
 =?us-ascii?Q?xtVM58eJyqOAHlKJLEGwgU6ppHAxJmJva6Mom3sLaGxMVrDO0l8Lfc+wc0BV?=
 =?us-ascii?Q?kmCA/joeZA5apLQw5BFC9I6LdLBQ61JAq4/P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:53.5834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1a4cd7-0bcb-4034-6bb9-08ddfccb8d59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Refactor the CFU device creation using the VersalMap structure. All
users of the APB IRQ OR gate have now been converted. The OR gate device
can be dropped.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  14 --
 hw/arm/xlnx-versal.c         | 258 ++++++++++++++++-------------------
 2 files changed, 115 insertions(+), 157 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index abdbed15689..5a685aea6d4 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -13,17 +13,14 @@
 #ifndef XLNX_VERSAL_H
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
-#include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qom/object.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "net/can_emu.h"
-#include "hw/misc/xlnx-versal-cfu.h"
-#include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
 OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
@@ -76,21 +73,10 @@ struct Versal {
         } rpu;
 
         XlnxVersalCRL crl;
     } lpd;
 
-    /* The Platform Management Controller subsystem.  */
-    struct {
-        XlnxVersalCFUAPB cfu_apb;
-        XlnxVersalCFUFDRO cfu_fdro;
-        XlnxVersalCFUSFR cfu_sfr;
-        XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
-        XlnxVersalCFrameBcastReg cframe_bcast;
-
-        OrIRQState apb_irq_orgate;
-    } pmc;
-
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
     } phandle;
 
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 9b1e0d46f1b..81adf8d35b6 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -37,10 +37,13 @@
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/misc/xlnx-versal-trng.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
+#include "hw/misc/xlnx-versal-cfu.h"
+#include "hw/misc/xlnx-versal-cframe-reg.h"
+#include "hw/or-irq.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -128,10 +131,28 @@ typedef struct VersalMap {
     struct VersalRtcMap {
         VersalSimplePeriphMap map;
         int alarm_irq;
         int second_irq;
     } rtc;
+
+    struct VersalCfuMap {
+        uint64_t cframe_base;
+        uint64_t cframe_stride;
+        uint64_t cfu_fdro;
+        uint64_t cframe_bcast_reg;
+        uint64_t cframe_bcast_fdri;
+        uint64_t cfu_apb;
+        uint64_t cfu_stream;
+        uint64_t cfu_stream_2;
+        uint64_t cfu_sfr;
+        int cfu_apb_irq;
+        int cframe_irq;
+        size_t num_cframe;
+        struct VersalCfuCframeCfg {
+            uint32_t blktype_frames[7];
+        } cframe_cfg[15];
+    } cfu;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -176,10 +197,26 @@ static const VersalMap VERSAL_MAP = {
     .trng = { 0xf1230000, 141 },
     .rtc = {
         { 0xf12a0000, OR_IRQ(121, 2) },
         .alarm_irq = 142, .second_irq = 143
     },
+
+    .cfu = {
+        .cframe_base = 0xf12d0000, .cframe_stride = 0x1000,
+        .cframe_bcast_reg = 0xf12ee000, .cframe_bcast_fdri = 0xf12ef000,
+        .cfu_apb = 0xf12b0000, .cfu_sfr = 0xf12c1000,
+        .cfu_stream = 0xf12c0000, .cfu_stream_2 = 0xf1f80000,
+        .cfu_fdro = 0xf12c2000,
+        .cfu_apb_irq = 120, .cframe_irq = OR_IRQ(121, 3),
+        .num_cframe = 15,
+        .cframe_cfg = {
+            { { 34111, 3528, 12800, 11, 5, 1, 1 } },
+            { { 38498, 3841, 15361, 13, 7, 3, 1 } },
+            { { 38498, 3841, 15361, 13, 7, 3, 1 } },
+            { { 38498, 3841, 15361, 13, 7, 3, 1 } },
+        },
+    },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -750,31 +787,10 @@ static void versal_create_sdhci(Versal *s,
     qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, map->irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
-static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
-{
-    DeviceState *orgate;
-
-    /*
-     * The VERSAL_PMC_APB_IRQ is an 'or' of the interrupts from the following
-     * models:
-     *  - RTC
-     *  - BBRAM
-     *  - PMC SLCR
-     *  - CFRAME regs (input 3 - 17 to the orgate)
-     */
-    object_initialize_child(OBJECT(s), "pmc-apb-irq-orgate",
-                            &s->pmc.apb_irq_orgate, TYPE_OR_IRQ);
-    orgate = DEVICE(&s->pmc.apb_irq_orgate);
-    object_property_set_int(OBJECT(orgate),
-                            "num-lines", VERSAL_NUM_PMC_APB_IRQS, &error_fatal);
-    qdev_realize(orgate, NULL, &error_fatal);
-    qdev_connect_gpio_out(orgate, 0, pic[VERSAL_PMC_APB_IRQ]);
-}
-
 static void versal_create_rtc(Versal *s, const struct VersalRtcMap *map)
 {
     SysBusDevice *sbd;
     MemoryRegion *mr;
     g_autofree char *node;
@@ -989,158 +1005,115 @@ static DeviceState *versal_create_ospi(Versal *s,
     sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
 
     return dev;
 }
 
-static void versal_create_cfu(Versal *s, qemu_irq *pic)
+static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
 {
     SysBusDevice *sbd;
-    DeviceState *dev;
+    Object *container;
+    DeviceState *cfu_fdro, *cfu_apb, *cfu_sfr, *cframe_bcast;
+    DeviceState *cframe_irq_or;
     int i;
-    const struct {
+
+    container = object_new(TYPE_CONTAINER);
+    object_property_add_child(OBJECT(s), "cfu", container);
+    object_unref(container);
+
+    /* CFU FDRO */
+    cfu_fdro = qdev_new(TYPE_XLNX_VERSAL_CFU_FDRO);
+    object_property_add_child(container, "cfu-fdro", OBJECT(cfu_fdro));
+    sbd = SYS_BUS_DEVICE(cfu_fdro);
+
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, map->cfu_fdro,
+                                sysbus_mmio_get_region(sbd, 0));
+
+    /* cframe bcast */
+    cframe_bcast = qdev_new(TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
+    object_property_add_child(container, "cframe-bcast", OBJECT(cframe_bcast));
+
+    /* CFU APB */
+    cfu_apb = qdev_new(TYPE_XLNX_VERSAL_CFU_APB);
+    object_property_add_child(container, "cfu-apb", OBJECT(cfu_apb));
+
+    /* IRQ or gate for cframes */
+    cframe_irq_or = qdev_new(TYPE_OR_IRQ);
+    object_property_add_child(container, "cframe-irq-or-gate",
+                              OBJECT(cframe_irq_or));
+    qdev_prop_set_uint16(cframe_irq_or, "num-lines", map->num_cframe);
+    qdev_realize_and_unref(cframe_irq_or, NULL, &error_abort);
+    versal_qdev_connect_gpio_out(s, cframe_irq_or, 0, map->cframe_irq);
+
+    /* cframe reg */
+    for (i = 0; i < map->num_cframe; i++) {
         uint64_t reg_base;
         uint64_t fdri_base;
-    } cframe_addr[] = {
-        { MM_PMC_CFRAME0_REG, MM_PMC_CFRAME0_FDRI },
-        { MM_PMC_CFRAME1_REG, MM_PMC_CFRAME1_FDRI },
-        { MM_PMC_CFRAME2_REG, MM_PMC_CFRAME2_FDRI },
-        { MM_PMC_CFRAME3_REG, MM_PMC_CFRAME3_FDRI },
-        { MM_PMC_CFRAME4_REG, MM_PMC_CFRAME4_FDRI },
-        { MM_PMC_CFRAME5_REG, MM_PMC_CFRAME5_FDRI },
-        { MM_PMC_CFRAME6_REG, MM_PMC_CFRAME6_FDRI },
-        { MM_PMC_CFRAME7_REG, MM_PMC_CFRAME7_FDRI },
-        { MM_PMC_CFRAME8_REG, MM_PMC_CFRAME8_FDRI },
-        { MM_PMC_CFRAME9_REG, MM_PMC_CFRAME9_FDRI },
-        { MM_PMC_CFRAME10_REG, MM_PMC_CFRAME10_FDRI },
-        { MM_PMC_CFRAME11_REG, MM_PMC_CFRAME11_FDRI },
-        { MM_PMC_CFRAME12_REG, MM_PMC_CFRAME12_FDRI },
-        { MM_PMC_CFRAME13_REG, MM_PMC_CFRAME13_FDRI },
-        { MM_PMC_CFRAME14_REG, MM_PMC_CFRAME14_FDRI },
-    };
-    const struct {
-        uint32_t blktype0_frames;
-        uint32_t blktype1_frames;
-        uint32_t blktype2_frames;
-        uint32_t blktype3_frames;
-        uint32_t blktype4_frames;
-        uint32_t blktype5_frames;
-        uint32_t blktype6_frames;
-    } cframe_cfg[] = {
-        [0] = { 34111, 3528, 12800, 11, 5, 1, 1 },
-        [1] = { 38498, 3841, 15361, 13, 7, 3, 1 },
-        [2] = { 38498, 3841, 15361, 13, 7, 3, 1 },
-        [3] = { 38498, 3841, 15361, 13, 7, 3, 1 },
-    };
+        DeviceState *dev;
+        g_autofree char *prop_name;
+        size_t j;
 
-    /* CFU FDRO */
-    object_initialize_child(OBJECT(s), "cfu-fdro", &s->pmc.cfu_fdro,
-                            TYPE_XLNX_VERSAL_CFU_FDRO);
-    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_fdro);
+        dev = qdev_new(TYPE_XLNX_VERSAL_CFRAME_REG);
+        object_property_add_child(container, "cframe[*]", OBJECT(dev));
 
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_FDRO,
-                                sysbus_mmio_get_region(sbd, 0));
+        sbd = SYS_BUS_DEVICE(dev);
 
-    /* CFRAME REG */
-    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
-        g_autofree char *name = g_strdup_printf("cframe%d", i);
+        for (j = 0; j < ARRAY_SIZE(map->cframe_cfg[i].blktype_frames); j++) {
+            g_autofree char *blktype_prop_name;
 
-        object_initialize_child(OBJECT(s), name, &s->pmc.cframe[i],
-                                TYPE_XLNX_VERSAL_CFRAME_REG);
-
-        sbd = SYS_BUS_DEVICE(&s->pmc.cframe[i]);
-        dev = DEVICE(&s->pmc.cframe[i]);
-
-        if (i < ARRAY_SIZE(cframe_cfg)) {
-            object_property_set_int(OBJECT(dev), "blktype0-frames",
-                                    cframe_cfg[i].blktype0_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype1-frames",
-                                    cframe_cfg[i].blktype1_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype2-frames",
-                                    cframe_cfg[i].blktype2_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype3-frames",
-                                    cframe_cfg[i].blktype3_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype4-frames",
-                                    cframe_cfg[i].blktype4_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype5-frames",
-                                    cframe_cfg[i].blktype5_frames,
-                                    &error_abort);
-            object_property_set_int(OBJECT(dev), "blktype6-frames",
-                                    cframe_cfg[i].blktype6_frames,
+            blktype_prop_name = g_strdup_printf("blktype%zu-frames", j);
+            object_property_set_int(OBJECT(dev), blktype_prop_name,
+                                    map->cframe_cfg[i].blktype_frames[j],
                                     &error_abort);
         }
+
         object_property_set_link(OBJECT(dev), "cfu-fdro",
-                                 OBJECT(&s->pmc.cfu_fdro), &error_fatal);
+                                 OBJECT(cfu_fdro), &error_abort);
 
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
-        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].reg_base,
+        reg_base = map->cframe_base + i * map->cframe_stride * 2;
+        fdri_base = reg_base + map->cframe_stride;
+        memory_region_add_subregion(&s->mr_ps, reg_base,
                                     sysbus_mmio_get_region(sbd, 0));
-        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].fdri_base,
+        memory_region_add_subregion(&s->mr_ps, fdri_base,
                                     sysbus_mmio_get_region(sbd, 1));
-        sysbus_connect_irq(sbd, 0,
-                           qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate),
-                                            3 + i));
-    }
-
-    /* CFRAME BCAST */
-    object_initialize_child(OBJECT(s), "cframe_bcast", &s->pmc.cframe_bcast,
-                            TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
+        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(cframe_irq_or, i));
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.cframe_bcast);
-    dev = DEVICE(&s->pmc.cframe_bcast);
-
-    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
-        g_autofree char *propname = g_strdup_printf("cframe%d", i);
-        object_property_set_link(OBJECT(dev), propname,
-                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
+        prop_name = g_strdup_printf("cframe%d", i);
+        object_property_set_link(OBJECT(cframe_bcast), prop_name,
+                                 OBJECT(dev), &error_abort);
+        object_property_set_link(OBJECT(cfu_apb), prop_name,
+                                 OBJECT(dev), &error_abort);
     }
 
-    sysbus_realize(sbd, &error_fatal);
-
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_REG,
+    sbd = SYS_BUS_DEVICE(cframe_bcast);
+    sysbus_realize_and_unref(sbd, &error_abort);
+    memory_region_add_subregion(&s->mr_ps, map->cframe_bcast_reg,
                                 sysbus_mmio_get_region(sbd, 0));
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_FDRI,
+    memory_region_add_subregion(&s->mr_ps, map->cframe_bcast_fdri,
                                 sysbus_mmio_get_region(sbd, 1));
 
-    /* CFU APB */
-    object_initialize_child(OBJECT(s), "cfu-apb", &s->pmc.cfu_apb,
-                            TYPE_XLNX_VERSAL_CFU_APB);
-    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_apb);
-    dev = DEVICE(&s->pmc.cfu_apb);
-
-    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
-        g_autofree char *propname = g_strdup_printf("cframe%d", i);
-        object_property_set_link(OBJECT(dev), propname,
-                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
-    }
-
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_APB,
+    sbd = SYS_BUS_DEVICE(cfu_apb);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, map->cfu_apb,
                                 sysbus_mmio_get_region(sbd, 0));
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM,
+    memory_region_add_subregion(&s->mr_ps, map->cfu_stream,
                                 sysbus_mmio_get_region(sbd, 1));
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM_2,
+    memory_region_add_subregion(&s->mr_ps, map->cfu_stream_2,
                                 sysbus_mmio_get_region(sbd, 2));
-    sysbus_connect_irq(sbd, 0, pic[VERSAL_CFU_IRQ_0]);
+    versal_sysbus_connect_irq(s, sbd, 0, map->cfu_apb_irq);
 
     /* CFU SFR */
-    object_initialize_child(OBJECT(s), "cfu-sfr", &s->pmc.cfu_sfr,
-                            TYPE_XLNX_VERSAL_CFU_SFR);
+    cfu_sfr = qdev_new(TYPE_XLNX_VERSAL_CFU_SFR);
+    object_property_add_child(container, "cfu-sfr", OBJECT(cfu_sfr));
+    sbd = SYS_BUS_DEVICE(cfu_sfr);
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_sfr);
-
-    object_property_set_link(OBJECT(&s->pmc.cfu_sfr),
-                            "cfu", OBJECT(&s->pmc.cfu_apb), &error_abort);
-
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_SFR,
+    object_property_set_link(OBJECT(cfu_sfr),
+                            "cfu", OBJECT(cfu_apb), &error_abort);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
                                 sysbus_mmio_get_region(sbd, 0));
 }
 
 static void versal_create_crl(Versal *s, qemu_irq *pic)
 {
@@ -1362,14 +1335,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
                                                        "ospi-mux-sel", 0));
 
     versal_create_bbram(s, &map->bbram);
     versal_create_trng(s, &map->trng);
     versal_create_rtc(s, &map->rtc);
+    versal_create_cfu(s, &map->cfu);
 
-    versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_crl(s, pic);
-    versal_create_cfu(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
-- 
2.51.0


