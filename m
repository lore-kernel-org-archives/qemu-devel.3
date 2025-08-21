Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D87CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4y6-0001Mk-VT; Thu, 21 Aug 2025 09:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4y0-0001IY-8k; Thu, 21 Aug 2025 09:04:32 -0400
Received: from mail-mw2nam10on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61b]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4xw-0002tO-B1; Thu, 21 Aug 2025 09:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgX6en8dfmlXxk4Y7NiV/7IfpF2z5kK+Ip8R0t9uvcYyIwn61h80O9xJ8Bl5SmxesXpWMD2c+N5EEnsRa4Mdifz2+/izu1VJ+pSqqXoICgjiPRCPAPTukXq+N9DGY7LdpbBi4OX0kQlngD8PjWn3olOEpkpFOBQ9wDptG37Qr4MRWyIwsqIrm34PxD/S66PNnhwFT/mDfOcH36EJhV3PexiM0621Dpr4l3BrhzOQZ5Tovsqb5stJpHhTgPiaNevjELwd2p4a8gtmxvW1LuqfhEBLLIZEs+Iq4EgR7ideRtuTkmXhsAnJI+qgID8cjMu3Ln4TG3FZtb0TJN+tjoy0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MmsMDrzNaK8w+Q2e6xoLEPE4G6b/z0vt/aHTSny0CA=;
 b=Kr9BRj0av3BmLPXhon74DKYt5UbQ0PLv3Ayvtg/3Mi2wYMVc5rT5oTMctJRwgRSUuU/oEOa6M9woXbuETu25yuGQAEbBWKDbffYfCJtZ62hHvU5NEcJV4Q1yYHhZVxQM5BUetUgWkNDgQaYQ+aJqs4gC+L8mBfs2Zpluxz8P4BTAT74AwIbMYLSCZtix7Aa99k7bvbyLXTI9BSdnR9iV9FsLNU7xJGejBBV6SdFjd+lokCxAGzah9XaFlQIfenKpVyOXwc2an3dhx7lgzgGSdzhvyjZkQZTjWOa+um0X/Gas1vW7Ijq/LbbZ6gyreUlkLMkZ8Qz1RMueePN6xdjvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MmsMDrzNaK8w+Q2e6xoLEPE4G6b/z0vt/aHTSny0CA=;
 b=IML+FRpl7PspzyfZQTCQT5YyIWtlaHBEGe6wceLs5RIXmLnxp5WXm8ihvZb50tUCaUPCUTNxvN2XZ2Frd58p/dCDqzL/F2+dC2U5bvVNesDBz1vqzZstXr2cT8aNaBlBo7KbpfRUz+GxaC6AgU43X1VQujwQhnYHlezrZJPUCYg=
Received: from SA9PR10CA0004.namprd10.prod.outlook.com (2603:10b6:806:a7::9)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Thu, 21 Aug
 2025 13:04:12 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::f8) by SA9PR10CA0004.outlook.office365.com
 (2603:10b6:806:a7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:04:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:10 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:08 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 04/47] hw/arm/xlnx-versal: canfd: refactor creation
Date: Thu, 21 Aug 2025 15:03:03 +0200
Message-ID: <20250821130354.125971-5-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b61921-a6a2-4c22-11d4-08dde0b339ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1JYacRgBGB5joGOQ6+7Pn1SQ3z3ppFQNPDzEs2NRvO+OdutSedYHbf5NkYCX?=
 =?us-ascii?Q?cE/7a67U33/SUjNPXQp+KASd+aSBpbVpaQTloKXgbr39aIpbXaM/DNxALvga?=
 =?us-ascii?Q?LmJ8Ob3AuzkQmgECAOHVei/Pm+6dxIZ3sFFMZ9pw8OvyD82cXmaj226BPs+6?=
 =?us-ascii?Q?fJDVU6gsnPIiM+1QCFNfAJg3ybmiC1fE/OKOWDxEiigkCexL2K5nMJBMTowM?=
 =?us-ascii?Q?mTvfEDeAUaahKncXvCPX9HS+NzKYhtxEwRyCRN/Scv+zGvQRgOeQODUx7E43?=
 =?us-ascii?Q?YcTLLcaO6rbFNAVQICHaZrmF+dtai1d5paNl6nmxqTgSKYTC4R7iptHixOrm?=
 =?us-ascii?Q?JtQ5DuK+5JNZFcOEwlZP8AKYiI4DlZ0pvZEkLb0hNws3AW6CogKKHN6xLr00?=
 =?us-ascii?Q?/49CIZhFC2sYqJjRnYkD7qabs88QjmVPNCoNahp5TEBkPY0d7DKkzhXXESYm?=
 =?us-ascii?Q?/xdfOLjfx7LmiKgOcQXgAx9r9BXTnj/6/3DkoSQU/8U2xsAb5feyHVYlLz/k?=
 =?us-ascii?Q?+PyGdPwouHZDnYATBaFeR0znVRL6pnVWWIuFXOAPsSDeNX5aah/NGSb7keGi?=
 =?us-ascii?Q?ZufXKj7ozy/1BNUWa1VD1PUm/EKyjezBV++pKUoWpTpiF5AwsKdLS8WosUd2?=
 =?us-ascii?Q?PQ95Qs/tlzzoKzDqAovtYfvv757brSp4idFlwnpcEaAA8tRc3sNT3QsTYjFF?=
 =?us-ascii?Q?peYSvnxMFzj0inOcBDR/xPgz4/2sUly5d2hCMdiXpe9Z2830snO7ZuPHEtdz?=
 =?us-ascii?Q?vtLd2h/jCV444mqK8RWObEFYRmD3WA4iRMVTJ/6TsLmOo0oVU39mMKgEYaCz?=
 =?us-ascii?Q?DePD4IVeYo5GCeNZyM0gccKNJwt9Q9VJoJN+xENs0UQTXxaA0EY3Po2iMFxf?=
 =?us-ascii?Q?Xk1rS2chRjFKRhr3XlchMAkIq/qpCBCRZ26avy9vO2GJt4/EWxtlq53ESD8i?=
 =?us-ascii?Q?eJ3th1UkOYTrfOf6tXysz3llxTVdGTpg8ToboK3WBJD4Vqr8WpuDBprfCzif?=
 =?us-ascii?Q?/fdlsDK0/IxYdrt4QwC8a5NamcMhnt+1AETC88O+R2HPZZX7umFaeXM0R4DJ?=
 =?us-ascii?Q?gU5fsy+XGkUAIRqJl0lASDEPoWBkbRmIMMB/+OV0vheOvZHCXXp65H+qLtav?=
 =?us-ascii?Q?TTx8OtCqVXHuP6O8YGvQfntJu2c3VeaBo3NmmQvOtakPXbrc+d325yBQSAfp?=
 =?us-ascii?Q?uLZwsqr5k9Ahh0eT6zOxNB8ws87j2FeLh6QaZBYV00WEXtHNFG0HpKLLHIeF?=
 =?us-ascii?Q?THVbYd/T9TH+3S6SJBbAXvldnaV3stfB3nK47Vz7Hnt7i8bmfNmh3VXc59ws?=
 =?us-ascii?Q?jyFWGgM9YkQsd/7GUx9b6XhNTEJHAp9SoQmqSva73nbORewia/nNNJRjSDgf?=
 =?us-ascii?Q?OYI8HO4Sv9n6i+1KZfVD4FOcJmoW63jGWes8xhGBqYxMPcEn05bXVwwhWHvU?=
 =?us-ascii?Q?yVwGzuFcJ4MYYY4kMkq18m5So96qU2a/B+ej64dvTdJfFMWa6AjfEj1B7dGq?=
 =?us-ascii?Q?o3YkjJSzgkbBIw9wTR2JDE3ZRcZbKWH0sg9M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:12.7097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b61921-a6a2-4c22-11d4-08dde0b339ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
Received-SPF: permerror client-ip=2a01:111:f403:2412::61b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Refactor the CAN controllers creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

The xlnx-versal-virt machine now dynamically creates the correct amount
of CAN bus link properties based on the number of CAN controller
advertised by the SoC.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  7 +--
 hw/arm/xlnx-versal-virt.c    | 73 ++++++++++--------------------
 hw/arm/xlnx-versal.c         | 86 +++++++++++++++++++++++++-----------
 3 files changed, 87 insertions(+), 79 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b01ddeb1423..007c91b596e 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -29,11 +29,11 @@
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/misc/xlnx-versal-trng.h"
-#include "hw/net/xlnx-versal-canfd.h"
+#include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
@@ -81,12 +81,10 @@ struct Versal {
         struct {
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
             OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
-            CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
-            XlnxVersalCANFDState canfd[XLNX_VERSAL_NR_CANFD];
         } iou;
 
         /* Real-time Processing Unit.  */
         struct {
             MemoryRegion mr;
@@ -139,10 +137,11 @@ struct Versal {
         uint32_t clk_125mhz;
     } phandle;
 
     struct {
         MemoryRegion *mr_ddr;
+        CanBusState **canbus;
         void *fdt;
     } cfg;
 };
 
 struct VersalClass {
@@ -155,10 +154,12 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 {
     g_assert(!qdev_is_realized(DEVICE(s)));
     s->cfg.fdt = fdt;
 }
 
+int versal_get_num_can(VersalVersion version);
+
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
 #define VERSAL_GIC_MAINT_IRQ        9
 #define VERSAL_TIMER_VIRT_IRQ       11
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 06cc5bae8b0..e189800a5a8 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -41,15 +41,15 @@ struct VersalVirt {
         uint32_t ethernet_phy[2];
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
         uint32_t usb;
         uint32_t dwc;
-        uint32_t canfd[2];
     } phandle;
     struct arm_boot_info binfo;
 
-    CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
+    CanBusState **canbus;
+
     struct {
         bool secure;
     } cfg;
     char *ospi_model;
 };
@@ -207,42 +207,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
     qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
     g_free(name);
 }
 
-static void fdt_add_canfd_nodes(VersalVirt *s)
-{
-    uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
-    uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
-    unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
-    const char clocknames[] = "can_clk\0s_axi_aclk";
-    int i;
-
-    /* Create and connect CANFD0 and CANFD1 nodes to canbus0. */
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        char *name = g_strdup_printf("/canfd@%" PRIx64, addrs[i]);
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        qemu_fdt_setprop_cell(s->fdt, name, "rx-fifo-depth", 0x40);
-        qemu_fdt_setprop_cell(s->fdt, name, "tx-mailbox-count", 0x20);
-
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addrs[i], 2, size[i]);
-        qemu_fdt_setprop_string(s->fdt, name, "compatible",
-                                "xlnx,canfd-2.0");
-
-        g_free(name);
-    }
-}
-
 static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
                                      uint32_t phandle)
 {
     char *name = g_strdup_printf("%s/fixed-link", gemname);
 
@@ -659,19 +627,22 @@ static void versal_virt_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "xlnx-versal", &s->soc,
                             TYPE_XLNX_VERSAL);
     object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
                              &error_abort);
-    object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
-                             &error_abort);
-    object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
-                             &error_abort);
+
+    for (i = 0; i < versal_get_num_can(VERSAL_VER_VERSAL); i++) {
+        g_autofree char *prop_name = g_strdup_printf("canbus%d", i);
+
+        object_property_set_link(OBJECT(&s->soc), prop_name,
+                                 OBJECT(s->canbus[i]),
+                                 &error_abort);
+    }
 
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     fdt_add_gem_nodes(s);
-    fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
     fdt_add_sd_nodes(s);
@@ -753,30 +724,34 @@ static void versal_virt_init(MachineState *machine)
 }
 
 static void versal_virt_machine_instance_init(Object *obj)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+    size_t i, num_can;
+
+    num_can = versal_get_num_can(VERSAL_VER_VERSAL);
+    s->canbus = g_new0(CanBusState *, num_can);
 
     /*
-     * User can set canbus0 and canbus1 properties to can-bus object and connect
-     * to socketcan(optional) interface via command line.
+     * User can set canbusx properties to can-bus object and optionally connect
+     * to socketcan interface via command line.
      */
-    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
-                             (Object **)&s->canbus[0],
-                             object_property_allow_set_link,
-                             0);
-    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
-                             (Object **)&s->canbus[1],
-                             object_property_allow_set_link,
-                             0);
+    for (i = 0; i < num_can; i++) {
+        g_autofree char *prop_name = g_strdup_printf("canbus%zu", i);
+
+        object_property_add_link(obj, prop_name, TYPE_CAN_BUS,
+                                 (Object **) &s->canbus[i],
+                                 object_property_allow_set_link, 0);
+    }
 }
 
 static void versal_virt_machine_finalize(Object *obj)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
 
     g_free(s->ospi_model);
+    g_free(s->canbus);
 }
 
 static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 87468cbc291..5dccf231942 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -25,10 +25,11 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 #include "system/device_tree.h"
 #include "hw/arm/fdt.h"
 #include "hw/char/pl011.h"
+#include "hw/net/xlnx-versal-canfd.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -41,16 +42,23 @@ typedef struct VersalSimplePeriphMap {
 } VersalSimplePeriphMap;
 
 typedef struct VersalMap {
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
+
+    VersalSimplePeriphMap canfd[4];
+    size_t num_canfd;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
+
+    .canfd[0] = { 0xff060000, 20 },
+    .canfd[1] = { 0xff070000, 21 },
+    .num_canfd = 2,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -284,40 +292,46 @@ static void versal_create_uart(Versal *s,
     if (chardev_idx == 0) {
         qemu_fdt_setprop_string(s->cfg.fdt, "/chosen", "stdout-path", node);
     }
 }
 
-static void versal_create_canfds(Versal *s, qemu_irq *pic)
+static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
+                                CanBusState *bus)
 {
-    int i;
-    uint32_t irqs[] = { VERSAL_CANFD0_IRQ_0, VERSAL_CANFD1_IRQ_0};
-    uint64_t addrs[] = { MM_CANFD0, MM_CANFD1 };
+    SysBusDevice *sbd;
+    MemoryRegion *mr;
+    g_autofree char *node;
+    const char compatible[] = "xlnx,canfd-2.0";
+    const char clocknames[] = "can_clk\0s_axi_aclk";
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.canfd); i++) {
-        char *name = g_strdup_printf("canfd%d", i);
-        SysBusDevice *sbd;
-        MemoryRegion *mr;
+    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XILINX_CANFD));
+    object_property_add_child(OBJECT(s), "canfd[*]", OBJECT(sbd));
 
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.canfd[i],
-                                TYPE_XILINX_CANFD);
-        sbd = SYS_BUS_DEVICE(&s->lpd.iou.canfd[i]);
+    object_property_set_int(OBJECT(sbd), "ext_clk_freq",
+                            25 * 1000 * 1000 , &error_abort);
 
-        object_property_set_int(OBJECT(&s->lpd.iou.canfd[i]), "ext_clk_freq",
-                                XLNX_VERSAL_CANFD_REF_CLK , &error_abort);
+    object_property_set_link(OBJECT(sbd), "canfdbus", OBJECT(bus),
+                             &error_abort);
 
-        object_property_set_link(OBJECT(&s->lpd.iou.canfd[i]), "canfdbus",
-                                 OBJECT(s->lpd.iou.canbus[i]),
-                                 &error_abort);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-        sysbus_realize(sbd, &error_fatal);
+    mr = sysbus_mmio_get_region(sbd, 0);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
 
-        mr = sysbus_mmio_get_region(sbd, 0);
-        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
 
-        sysbus_connect_irq(sbd, 0, pic[irqs[i]]);
-        g_free(name);
-    }
+    node = versal_fdt_add_simple_subnode(s, "/canfd", map->addr, 0x10000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "rx-fifo-depth", 0x40);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "tx-mailbox-count", 0x20);
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_25mhz, s->phandle.clk_25mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                     clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
 static void versal_create_usbs(Versal *s, qemu_irq *pic)
 {
     DeviceState *dev;
@@ -1046,11 +1060,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
 
-    versal_create_canfds(s, pic);
+    for (i = 0; i < map->num_canfd; i++) {
+        versal_create_canfd(s, &map->canfd[i], s->cfg.canbus[i]);
+    }
+
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
     versal_create_sds(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
@@ -1074,28 +1091,43 @@ static void versal_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
     memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
+int versal_get_num_can(VersalVersion version)
+{
+    const VersalMap *map = VERSION_TO_MAP[version];
+
+    return map->num_canfd;
+}
+
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
+    size_t i, num_can;
 
     memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
+
+    num_can = versal_get_map(s)->num_canfd;
+    s->cfg.canbus = g_new0(CanBusState *, num_can);
+
+    for (i = 0; i < num_can; i++) {
+        g_autofree char *prop_name = g_strdup_printf("canbus%zu", i);
+
+        object_property_add_link(obj, prop_name, TYPE_CAN_BUS,
+                                 (Object **) &s->cfg.canbus[i],
+                                 object_property_allow_set_link, 0);
+    }
 }
 
 static const Property versal_properties[] = {
     DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
-                      TYPE_CAN_BUS, CanBusState *),
-    DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
-                      TYPE_CAN_BUS, CanBusState *),
 };
 
 static void versal_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-- 
2.50.1


