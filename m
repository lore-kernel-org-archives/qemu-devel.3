Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E262CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22Za-00067A-LF; Fri, 26 Sep 2025 03:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZX-00065L-Kx; Fri, 26 Sep 2025 03:08:52 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22ZS-0006Xv-6M; Fri, 26 Sep 2025 03:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FE4yRR5oJSKTS2kTDbr8mmqsyDmrOUWg/Tw9KHnziCHvS6wc5CE8Vj31lb9WMFPVoYsJJ9exi/FHyUftSQ+09Oe8hjgrUgz4Y2SKi2w8/3zmvmB/cAFSlPwRn+IEuCrpMhDdEfhztINRLzVVJq0GHWTZkx0vkbjnFTo24F1eBu7zDLuOtBL//deMO7mGtW6cdzhZj0XhQyUDEGEUzzv1EN8Wrk7aShgeta5oTF1y1j26T+FDOJrxVW3Y4AFzodze+1S7eYPN6Bo5Xv94yhYn3h8EKubixVp4DVevMZ8lbV5+Wi4zO9Bp9gJH2e0lWSLZgmQxfUW3kvZpTzACLxcHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGEbNuli7Y7CUexZsnZuXSBvrGRBnQ3fLU/LH0Zuwds=;
 b=r52PzDaVlRuj04UJOZ5rgEgF2Jc+mLQtOg03Cn8suFUAR/Tp0mjaPffcQVUpXYbxt6PqEsvZ4OdX9/mBCy2PrHmdB4zbY3KS8cBipbn+uNFqXFxzyrhkNT7TzHKsTN0t3GI+IaiVHdM06TiFo6aay/x3w2gHvlfJ8YNtXLLYkSPOX6mtTOEzYgSaTZ/nNBF3YfDYIqc6tkZhUTTDKZNAfEKK1373rD30Xz3SBEKKwEgnz3YzwTjrnu911UW2l6IVyoffibn38oUOSBSKhNSWKr7JFrCCducPKGCXkg1Hoy0dM/Dehb8kAmDPY3aKQw1iM+U+C8VjjAWrrbAiUAIggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGEbNuli7Y7CUexZsnZuXSBvrGRBnQ3fLU/LH0Zuwds=;
 b=CGKv8RJbH6Ux3/iE6gWfcYKsIdLGXJLQIvYzShkjxboCQ31K3/67Kp+SW4XrMIhj46bf4MZKMs2JGs8Uux2nNjoqgArXv9fLWk1afE4cxWC898BsCh87TLbypPunOOQlBPuvsQmhTQKThyHRge6ljoTYNcdvBNb54pK0azXluEI=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 07:08:33 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::93) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Fri,
 26 Sep 2025 07:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:20 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:20 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:19 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 04/47] hw/arm/xlnx-versal: canfd: refactor creation
Date: Fri, 26 Sep 2025 09:07:22 +0200
Message-ID: <20250926070806.292065-5-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c99f17-ab0e-4250-fc63-08ddfccb8105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmFObE8xdGVEdER4N2Z4cUpPNFRqd2R4bG4vUkx5Wk1DSmJjM1JDZG00WDUw?=
 =?utf-8?B?azFlUFZGS1JscHI4RWU3WVIrOURvSGJadzViRFpzSVEvczBUVmdVVU42UGlX?=
 =?utf-8?B?aVlvOGN5bUtqU2pzTWdQNGN4OGsvUERPd05VMndrWDY4NUVLVlcyc1hjWVdO?=
 =?utf-8?B?SFRBajIxQXF2T0t1Q3dwT3lzU0VmUXdQQXBBUGdxdWd1NUVjbzZoUWEzZnlo?=
 =?utf-8?B?VTZneDBvSHFBZmh4dXNxQ0czMFZLL2F5MjhGL0l2L1FuYmlFVXZDTlhqUEJV?=
 =?utf-8?B?Yk1RdGZxaFZTK1NTZytTUlZwQVJIZlMrcnBCbGFvN3A4QTd3cTJObFVodU9h?=
 =?utf-8?B?WkVPcFNJTkZLRUhkNDdhVnBsS0luYUhlU1FzWGkzSTVuUmk2TzVWaTYyRk0r?=
 =?utf-8?B?VXBhMmlwRkxUeTNyUkNqWWJZZnM3VUpDcm50NUo1SVFRT0U0dkxzSUN1ZzNU?=
 =?utf-8?B?REp0Sy9IODNob1ZmSnpYMkQwSXRVQ2pyOUdRL2hxVUNoRVUyK005V1VUSHM2?=
 =?utf-8?B?TlVTcFU1akR2TXlRSE5uVEJTREhPbkZiaDNlMEcyOXFhZkdOdUExWCtLc09a?=
 =?utf-8?B?Y0FHNE9ib3MyeGdJQWxmaklSSDZPWmRwa1ZsMDk4Q1oyZzE3VXRPb3VLMmp2?=
 =?utf-8?B?SVozaHhtQ1pSOXpWQTMzbFZsekFnT0R4TitoUXZjUDlsajI0MHFKYWhmSTVN?=
 =?utf-8?B?Tno2ZlpucDNWSmlNbTZpOUZoblEvTk5BQ0VqVHZGWE9FQnJJd1kxcnBWR2Iv?=
 =?utf-8?B?RWE1eC9RRmZjMHRkNkt5YVVhdjV2M29SbnFXbFdxdUVGQTk2cGFNV0FQeUpT?=
 =?utf-8?B?dGtYTUhacHBkeW5CamhWT1dqZkowa1ZTY3BVM3FrT0FrVUd0V3dBWjJZY0JD?=
 =?utf-8?B?bzRSdVVTdWoyZmlGMVZKaVA2L1QxaFNlTDZLYlFYdlBnVU45TXlsNC9nSXQ2?=
 =?utf-8?B?WWFIU0VJN2o4c05yWk5uK3k1Ulo3bldHbnlTR2svNHBvbFlsMWo1ZWRmNjBI?=
 =?utf-8?B?eFpzV0RRWk5qc2I1K2FrejBCVmtKVXZUd2VRbG1oNWZOMklDaVo5MDRDSnNB?=
 =?utf-8?B?a281aHVpWE5Sb2lxNmgvU0pPUmtxbFErYTlwOHVuSzdoVHhqbi9jbmNHZm9W?=
 =?utf-8?B?andmUFh4SkZDbm9ENi9GbGxJVUhLSnppaUdseXh4SmlzNE1LNXRNRkEyNGpO?=
 =?utf-8?B?ME9zd3pQcFdtWko3UVh6TzJtVnNOd2J3b1YrenNiR0JlRXNpYWQ1WFMyYTRB?=
 =?utf-8?B?SThlTE50NnNWYys2bTJFRDdzTTRVNE5oNHNxcUhHc1RXOXdLeThHVStNUEVH?=
 =?utf-8?B?YnRTdHZWcVBTL0djVS9sMTNDZDNxQ3dIby9CcEZ6UktoNjQvY3FPVFJMRFA1?=
 =?utf-8?B?eFoyc2tOTWpMb0Z5L2FPUXZEUmR3OFJFcGsrbzFiZVZVeVNGM09Qa0lBdE96?=
 =?utf-8?B?Z254eWt3V3RlZ3U4NndlMk9PcGpZWWxWMXI0dC9VbjB4bUtHMjIwRFlJbE95?=
 =?utf-8?B?QjRJR3ZFTDBpV01vZmFxSXZSQ2QwN3I4QTFGdlliNlpIRS92bzJ6dTdSRDg3?=
 =?utf-8?B?dXorM3RLalhGS2IyRkhnTG44c0FFaFVPeFZ6MzlFbGpVVURCM3pWaFQxQ2p1?=
 =?utf-8?B?dWFnT011SSsvaUlTdUVLRzJNRDlWc3E0eFFXTnNZTFdBZnk3QzVuZ0psVm9u?=
 =?utf-8?B?TDNBM3VObEhja29TMHQ3dzVydEprUC9uc1RKb0diWTV5L2w3cm5pazhVSnB2?=
 =?utf-8?B?dG02VG91UExoYmNtUG16dk5xK3pWUmV3b3J3S0t3dy9TMEpYcERoZUN2cHE4?=
 =?utf-8?B?aTJreHMrSXlzM3grMUF4UUR0eGVGNWVic1dmb29KWVhxS0NrbE5nVDd3SUZy?=
 =?utf-8?B?YUJEb2MyUEtIdlVoMmhYM1o1aFlVMFIxemNLSm9UZTVqaWlESDhuSEZuREFr?=
 =?utf-8?B?RkJhdkNYZzRCQzVTejhVSGMzcURXZVluUi9ZTEp0b0YvaXk4VXVFRE52SXU0?=
 =?utf-8?B?N3ZlNkZ1M0pJYng1TTNiaktZOHlQMXR3M0s2Sy9vZkdzUHRycUhxelNsKzVJ?=
 =?utf-8?B?azA3RHV4T1UyalVsaFNod3RGaUpvd2R1WXJvVXZRNnFNYmpxdS9rNFdUcmlm?=
 =?utf-8?Q?0Zzo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:32.8954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c99f17-ab0e-4250-fc63-08ddfccb8105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Luc.Michel@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Refactor the CAN controllers creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

The xlnx-versal-virt machine now dynamically creates the correct amount
of CAN bus link properties based on the number of CAN controller
advertised by the SoC.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  7 +--
 hw/arm/xlnx-versal-virt.c    | 73 +++++++++-------------------
 hw/arm/xlnx-versal.c         | 94 +++++++++++++++++++++++++-----------
 3 files changed, 95 insertions(+), 79 deletions(-)

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
index e1deae11317..334252564be 100644
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
 
@@ -659,22 +627,25 @@ static void versal_virt_init(MachineState *machine)
 
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
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
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
index b16af79e8a9..3d2e33d3dac 100644
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
@@ -1042,11 +1056,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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
@@ -1070,28 +1087,50 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
+}
+
+static void versal_base_finalize(Object *obj)
+{
+    Versal *s = XLNX_VERSAL_BASE(obj);
+
+    g_free(s->cfg.canbus);
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
@@ -1111,10 +1150,11 @@ static void versal_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo versal_base_info = {
     .name = TYPE_XLNX_VERSAL_BASE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Versal),
     .instance_init = versal_base_init,
+    .instance_finalize = versal_base_finalize,
     .class_init = versal_base_class_init,
     .class_size = sizeof(VersalClass),
     .abstract = true,
 };
 
-- 
2.51.0


