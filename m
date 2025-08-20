Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECEBCA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeAY-0007BB-Ov; Wed, 20 Aug 2025 04:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAV-00071t-Fj; Wed, 20 Aug 2025 04:27:39 -0400
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAO-000168-Ck; Wed, 20 Aug 2025 04:27:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiH4Dm2CvAHc7YzNzrC7oipmY+GLoOvWIVMk6F7AcUYRuSkmzMu6UO2OuAG1LDhvDMDQn9q6k/IQM2ZqJC+WWU121AD9F0OXKXPJNwjvOCSq5F9vg/YzBveewbqUWubji+FxJ2cSt/1SxbAgWHCBjhslHHSSn1sArUmKzBanqQs2YXiox8obvhWn/gzCyZpqFdqgQusX4q320CDRwF+KciBF/gkwtynoOPFwSwY1OpOmhx7U3rSaGF9j/gufH8sZrVmb78C9vG1WLFAq1HZmmJcLIpHj6Dh5tjU962uAWdNSB4c0SioG5SXnC8EVg4vYQ7NXHMxeZNkFjQABzPtTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi9vcjT3D6gXjk+gRD8Ca0EoiElfrEN7auSwXgrYnzA=;
 b=isTtH17WMZTG1EHb8aXzlSQsSze+6ht1qhhh0Zurzsgen9mtpZXcxFegoX4gijKj/kymTRa3/DXoiRvn+gtbsPqK07gHboA6dFZihU4dcQjNJ8ciLF+QBMm+STqjip3lB6x+Q+tOHUTNWEWNKPJ5F9GwhFQX0d10L3mntL+IHlH1Fu6EAT2SOdYjtW0b6X/ttDjJ72FE2lT4ZWCn2tEFj2WeDefgMRCAUAlMFqX1PLH/PLq1KVfnmAq0HPjBDkfmCPiKkjY76uRJHQ5dH4YazEl08M26kjt1qDbYYGQbwRH/xd/dTkKdU2JKhWeohqF3KsfRjC+bx3sb7rnqCmoGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi9vcjT3D6gXjk+gRD8Ca0EoiElfrEN7auSwXgrYnzA=;
 b=A7c+c1KFa3unpy46haQg1bdb0q9A38Hxf8nYh20uMbnXu9Ic3epYamL0XzzfNYiowK5LHdm+Y3jzT+lU4p2yyKWeTEWy/6DIP7Uvj6G22XVMeqr4bfou7gcHD9zIujjNSRzSVg6Il1AXLzGbHFoZ6e2DgyZaJNGvgQ73VECh+AA=
Received: from MW4PR03CA0342.namprd03.prod.outlook.com (2603:10b6:303:dc::17)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Wed, 20 Aug
 2025 08:27:22 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::d5) by MW4PR03CA0342.outlook.office365.com
 (2603:10b6:303:dc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:27:17 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:15 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 35/47] hw/arm/xlnx-versal: tidy up
Date: Wed, 20 Aug 2025 10:25:34 +0200
Message-ID: <20250820082549.69724-36-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a2d3fb-f0b6-4760-e95e-08dddfc362c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uvZgF8FghISpm2vzUnR+Pr6lnkodOKuEZxoiZs1jmSkZIN8lIRWPywqYAqrm?=
 =?us-ascii?Q?nJ7bgEJwP9IQbtgiRv4BxUjR9vo0d04tlK0LV6ZISA9rW4B8PTFdP6KYGTGe?=
 =?us-ascii?Q?Ag3F6+tQfs8SFJr0SyASh0Mr99jy+8lzfHuA47eI+ZwdLpLIBXrRig3zEMGR?=
 =?us-ascii?Q?DmixDa+I37inVpmAWNS8a+ZqCpeQ+QIE8/KykmCsHbhdnEAjdAG+V4RcKVkx?=
 =?us-ascii?Q?hIRlZlWUIDX+z8efr0dquGYk2fDmtFWvUSZiYKGvJ+e3yo1GQr8iRhWUni/X?=
 =?us-ascii?Q?BSkZBRutHTfUN6PAXD5Eyfsx6Hrf/B3ruMVce8lRym0eSQQYPglBBtp4F33Q?=
 =?us-ascii?Q?KVhxYDRlcWol5zc6GktFw6nANz4nUuBThipozMeHqNXlbMdhl0N5cG8xWtWx?=
 =?us-ascii?Q?k6ZIfbPc1sRwofcCI+NxkZ5q2oHtVQKogVrm7fQ5UgGCYGq6ohjsS74jtjlH?=
 =?us-ascii?Q?8cu68EPlfF06S9BOTD0ck2vxkATlxFK1vbf4x2EeXILmSKjuRXC1GHJ1jYgE?=
 =?us-ascii?Q?AvaXXutMwceBhc3ftOG8aAFPDOxW1fsfKSBH7o3Wt5wESZxiDXnVmXbEvwwS?=
 =?us-ascii?Q?t92LUN6FX5oYxV5wJ5MIHgZxmqTW6wCgMe4rxxqwp2gUVnk8YBsddf7u9dt5?=
 =?us-ascii?Q?Vo+Z5BGFaZULvYXFHXRsskJR2zBt+qAwH0WO/RUEmU4dt4YQ3KoKcQRun0Oy?=
 =?us-ascii?Q?Y5QurfkGgqct6rwLC5ssUvIUgGRXzuCO0G5Xeai3Fc7iZL+HU66b+P9+nXGe?=
 =?us-ascii?Q?g9R65VkY+xrZefXmn52W8NMUasdIbLtphWUPiwKBkOwCjqhwiDbvA2/R1NnK?=
 =?us-ascii?Q?KEENy0AfzdmdJnsKV0o/MBzMcRt8rEWnbUVYGVtB+PkR2DTXi+EYCwjlnnWd?=
 =?us-ascii?Q?8CeKpu7kdgFtFYHfu5RIwGJajZvQ25e4slVZHuQPofm4aQVH2Iittr2bD6Cx?=
 =?us-ascii?Q?RHYwl5qgC+aZ2xrp2mrlJYPK9QfNP5qLmUptHCm+cbvINaSPvMzRmT7d++Hj?=
 =?us-ascii?Q?hQJBiSBsDoZu5xZtga4B/gedqu0abvOxgNuT/QTetvnH+zX4TRC5rwbj/TkI?=
 =?us-ascii?Q?WdwI9RVbu7JbxGhnRQ+G9DpxnyohwOk61y4dREu0XXeUV46MPgVYpft3fnOI?=
 =?us-ascii?Q?sDxPfTfeaSVFQUDSkM0iXLug1V31HvE6oHAH70kkUta1q7j9FMcbLjb+MTZ9?=
 =?us-ascii?Q?yZ+FFjG7IPO/7khnMSqs9USb0jc49vgph/GyY0BYV4cHwykUoWokwznjXniP?=
 =?us-ascii?Q?6fTdQy0CksTHczB8CJHnR2eY3YnDWCf+Lu1seKv3khXdGWDvBj96Lk4vATX3?=
 =?us-ascii?Q?UntIWDPUiup++oIxGqqVd9WZ4GzznenVz762+l38uXdLoH7bDa25fUNMYBCl?=
 =?us-ascii?Q?hcd2GGA9eJFFPoBiDIKN4rSgiwkmSJCPOpmjAOP5P1yvr6rdwidclMHVZ0t1?=
 =?us-ascii?Q?nMVxGHlxQKxj/4nycf4fWCD84IqyWFdPWNInNvTQYx/O/6EaJGZDoqozyAW1?=
 =?us-ascii?Q?E0u83ycSc/l3kCYWi4T/hHDTcCAcf5Dr+IeM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:22.3628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a2d3fb-f0b6-4760-e95e-08dddfc362c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
Received-SPF: permerror client-ip=2a01:111:f403:2412::601;
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

Remove now unused macros in xlnx-versal.[ch]. Those macros have been
replaced by the VersalMap structure that serves as a central description
for the SoC. The ones still in use in the versal_unimp function are
inlined.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h | 204 -----------------------------------
 hw/arm/xlnx-versal.c         |  28 ++---
 2 files changed, 7 insertions(+), 225 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 3be9f0a5550..bdfab2a5426 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -21,22 +21,10 @@
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
 OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 
-#define XLNX_VERSAL_NR_ACPUS   2
-#define XLNX_VERSAL_NR_RCPUS   2
-#define XLNX_VERSAL_NR_UARTS   2
-#define XLNX_VERSAL_NR_GEMS    2
-#define XLNX_VERSAL_NR_ADMAS   8
-#define XLNX_VERSAL_NR_SDS     2
-#define XLNX_VERSAL_NR_XRAM    4
-#define XLNX_VERSAL_NR_IRQS    192
-#define XLNX_VERSAL_NR_CANFD   2
-#define XLNX_VERSAL_CANFD_REF_CLK (24 * 1000 * 1000)
-#define XLNX_VERSAL_NR_CFRAME  15
-
 struct Versal {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
@@ -81,198 +69,6 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s);
 
 int versal_get_num_cpu(VersalVersion version);
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
-/* Memory-map and IRQ definitions. Copied a subset from
- * auto-generated files.  */
-
-#define VERSAL_CRL_IRQ             10
-#define VERSAL_UART0_IRQ_0         18
-#define VERSAL_UART1_IRQ_0         19
-#define VERSAL_CANFD0_IRQ_0        20
-#define VERSAL_CANFD1_IRQ_0        21
-#define VERSAL_USB0_IRQ_0          22
-#define VERSAL_GEM0_IRQ_0          56
-#define VERSAL_GEM0_WAKE_IRQ_0     57
-#define VERSAL_GEM1_IRQ_0          58
-#define VERSAL_GEM1_WAKE_IRQ_0     59
-#define VERSAL_ADMA_IRQ_0          60
-#define VERSAL_XRAM_IRQ_0          79
-#define VERSAL_CFU_IRQ_0           120
-#define VERSAL_PMC_APB_IRQ         121
-#define VERSAL_OSPI_IRQ            124
-#define VERSAL_SD0_IRQ_0           126
-#define VERSAL_EFUSE_IRQ           139
-#define VERSAL_TRNG_IRQ            141
-#define VERSAL_RTC_ALARM_IRQ       142
-#define VERSAL_RTC_SECONDS_IRQ     143
-
-/* Architecturally reserved IRQs suitable for virtualization.  */
-#define VERSAL_RSVD_IRQ_FIRST 111
-#define VERSAL_RSVD_IRQ_LAST  118
-
-#define MM_TOP_RSVD                 0xa0000000U
-#define MM_TOP_RSVD_SIZE            0x4000000
-#define MM_GIC_APU_DIST_MAIN        0xf9000000U
-#define MM_GIC_APU_DIST_MAIN_SIZE   0x10000
-#define MM_GIC_APU_REDIST_0         0xf9080000U
-#define MM_GIC_APU_REDIST_0_SIZE    0x80000
-
-#define MM_UART0                    0xff000000U
-#define MM_UART0_SIZE               0x10000
-#define MM_UART1                    0xff010000U
-#define MM_UART1_SIZE               0x10000
-
-#define MM_CANFD0                   0xff060000U
-#define MM_CANFD0_SIZE              0x10000
-#define MM_CANFD1                   0xff070000U
-#define MM_CANFD1_SIZE              0x10000
-
-#define MM_GEM0                     0xff0c0000U
-#define MM_GEM0_SIZE                0x10000
-#define MM_GEM1                     0xff0d0000U
-#define MM_GEM1_SIZE                0x10000
-
-#define MM_ADMA_CH0                 0xffa80000U
-#define MM_ADMA_CH0_SIZE            0x10000
-
-#define MM_OCM                      0xfffc0000U
-#define MM_OCM_SIZE                 0x40000
-
-#define MM_XRAM                     0xfe800000
-#define MM_XRAMC                    0xff8e0000
-#define MM_XRAMC_SIZE               0x10000
-
-#define MM_USB2_CTRL_REGS           0xFF9D0000
-#define MM_USB2_CTRL_REGS_SIZE      0x10000
-
-#define MM_USB_0                    0xFE200000
-#define MM_USB_0_SIZE               0x10000
-
-#define MM_TOP_DDR                  0x0
-#define MM_TOP_DDR_SIZE             0x80000000U
-#define MM_TOP_DDR_2                0x800000000ULL
-#define MM_TOP_DDR_2_SIZE           0x800000000ULL
-#define MM_TOP_DDR_3                0xc000000000ULL
-#define MM_TOP_DDR_3_SIZE           0x4000000000ULL
-#define MM_TOP_DDR_4                0x10000000000ULL
-#define MM_TOP_DDR_4_SIZE           0xb780000000ULL
-
-#define MM_PSM_START                0xffc80000U
-#define MM_PSM_END                  0xffcf0000U
-
-#define MM_CRL                      0xff5e0000U
-#define MM_CRL_SIZE                 0x300000
-#define MM_IOU_SCNTR                0xff130000U
-#define MM_IOU_SCNTR_SIZE           0x10000
-#define MM_IOU_SCNTRS               0xff140000U
-#define MM_IOU_SCNTRS_SIZE          0x10000
-#define MM_FPD_CRF                  0xfd1a0000U
-#define MM_FPD_CRF_SIZE             0x140000
-#define MM_FPD_FPD_APU              0xfd5c0000
-#define MM_FPD_FPD_APU_SIZE         0x100
-
-#define MM_PMC_PMC_IOU_SLCR         0xf1060000
-#define MM_PMC_PMC_IOU_SLCR_SIZE    0x10000
-
-#define MM_PMC_OSPI                 0xf1010000
-#define MM_PMC_OSPI_SIZE            0x10000
-
-#define MM_PMC_OSPI_DAC             0xc0000000
-#define MM_PMC_OSPI_DAC_SIZE        0x20000000
-
-#define MM_PMC_OSPI_DMA_DST         0xf1011800
-#define MM_PMC_OSPI_DMA_SRC         0xf1011000
-
-#define MM_PMC_SD0                  0xf1040000U
-#define MM_PMC_SD0_SIZE             0x10000
-#define MM_PMC_BBRAM_CTRL           0xf11f0000
-#define MM_PMC_BBRAM_CTRL_SIZE      0x00050
-#define MM_PMC_EFUSE_CTRL           0xf1240000
-#define MM_PMC_EFUSE_CTRL_SIZE      0x00104
-#define MM_PMC_EFUSE_CACHE          0xf1250000
-#define MM_PMC_EFUSE_CACHE_SIZE     0x00C00
-
-#define MM_PMC_CFU_APB              0xf12b0000
-#define MM_PMC_CFU_APB_SIZE         0x10000
-#define MM_PMC_CFU_STREAM           0xf12c0000
-#define MM_PMC_CFU_STREAM_SIZE      0x1000
-#define MM_PMC_CFU_SFR              0xf12c1000
-#define MM_PMC_CFU_SFR_SIZE         0x1000
-#define MM_PMC_CFU_FDRO             0xf12c2000
-#define MM_PMC_CFU_FDRO_SIZE        0x1000
-#define MM_PMC_CFU_STREAM_2         0xf1f80000
-#define MM_PMC_CFU_STREAM_2_SIZE    0x40000
-
-#define MM_PMC_CFRAME0_REG          0xf12d0000
-#define MM_PMC_CFRAME0_REG_SIZE     0x1000
-#define MM_PMC_CFRAME0_FDRI         0xf12d1000
-#define MM_PMC_CFRAME0_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME1_REG          0xf12d2000
-#define MM_PMC_CFRAME1_REG_SIZE     0x1000
-#define MM_PMC_CFRAME1_FDRI         0xf12d3000
-#define MM_PMC_CFRAME1_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME2_REG          0xf12d4000
-#define MM_PMC_CFRAME2_REG_SIZE     0x1000
-#define MM_PMC_CFRAME2_FDRI         0xf12d5000
-#define MM_PMC_CFRAME2_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME3_REG          0xf12d6000
-#define MM_PMC_CFRAME3_REG_SIZE     0x1000
-#define MM_PMC_CFRAME3_FDRI         0xf12d7000
-#define MM_PMC_CFRAME3_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME4_REG          0xf12d8000
-#define MM_PMC_CFRAME4_REG_SIZE     0x1000
-#define MM_PMC_CFRAME4_FDRI         0xf12d9000
-#define MM_PMC_CFRAME4_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME5_REG          0xf12da000
-#define MM_PMC_CFRAME5_REG_SIZE     0x1000
-#define MM_PMC_CFRAME5_FDRI         0xf12db000
-#define MM_PMC_CFRAME5_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME6_REG          0xf12dc000
-#define MM_PMC_CFRAME6_REG_SIZE     0x1000
-#define MM_PMC_CFRAME6_FDRI         0xf12dd000
-#define MM_PMC_CFRAME6_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME7_REG          0xf12de000
-#define MM_PMC_CFRAME7_REG_SIZE     0x1000
-#define MM_PMC_CFRAME7_FDRI         0xf12df000
-#define MM_PMC_CFRAME7_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME8_REG          0xf12e0000
-#define MM_PMC_CFRAME8_REG_SIZE     0x1000
-#define MM_PMC_CFRAME8_FDRI         0xf12e1000
-#define MM_PMC_CFRAME8_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME9_REG          0xf12e2000
-#define MM_PMC_CFRAME9_REG_SIZE     0x1000
-#define MM_PMC_CFRAME9_FDRI         0xf12e3000
-#define MM_PMC_CFRAME9_FDRI_SIZE    0x1000
-#define MM_PMC_CFRAME10_REG         0xf12e4000
-#define MM_PMC_CFRAME10_REG_SIZE    0x1000
-#define MM_PMC_CFRAME10_FDRI        0xf12e5000
-#define MM_PMC_CFRAME10_FDRI_SIZE   0x1000
-#define MM_PMC_CFRAME11_REG         0xf12e6000
-#define MM_PMC_CFRAME11_REG_SIZE    0x1000
-#define MM_PMC_CFRAME11_FDRI        0xf12e7000
-#define MM_PMC_CFRAME11_FDRI_SIZE   0x1000
-#define MM_PMC_CFRAME12_REG         0xf12e8000
-#define MM_PMC_CFRAME12_REG_SIZE    0x1000
-#define MM_PMC_CFRAME12_FDRI        0xf12e9000
-#define MM_PMC_CFRAME12_FDRI_SIZE   0x1000
-#define MM_PMC_CFRAME13_REG         0xf12ea000
-#define MM_PMC_CFRAME13_REG_SIZE    0x1000
-#define MM_PMC_CFRAME13_FDRI        0xf12eb000
-#define MM_PMC_CFRAME13_FDRI_SIZE   0x1000
-#define MM_PMC_CFRAME14_REG         0xf12ec000
-#define MM_PMC_CFRAME14_REG_SIZE    0x1000
-#define MM_PMC_CFRAME14_FDRI        0xf12ed000
-#define MM_PMC_CFRAME14_FDRI_SIZE   0x1000
-#define MM_PMC_CFRAME_BCAST_REG       0xf12ee000
-#define MM_PMC_CFRAME_BCAST_REG_SIZE  0x1000
-#define MM_PMC_CFRAME_BCAST_FDRI      0xf12ef000
-#define MM_PMC_CFRAME_BCAST_FDRI_SIZE 0x1000
-
-#define MM_PMC_CRP                  0xf1260000U
-#define MM_PMC_CRP_SIZE             0x10000
-#define MM_PMC_RTC                  0xf12a0000
-#define MM_PMC_RTC_SIZE             0x10000
-#define MM_PMC_TRNG                 0xf1230000
-#define MM_PMC_TRNG_SIZE            0x10000
 #endif
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index c513d28c8d4..aef53876f26 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -16,11 +16,10 @@
 #include "qobject/qlist.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "system/system.h"
-#include "hw/arm/boot.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
@@ -49,17 +48,10 @@
 #include "hw/core/split-irq.h"
 #include "target/arm/cpu.h"
 #include "hw/cpu/cluster.h"
 #include "hw/arm/bsa.h"
 
-#define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
-#define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
-#define GEM_REVISION        0x40070106
-
-#define VERSAL_NUM_PMC_APB_IRQS 18
-#define NUM_OSPI_IRQ_LINES 3
-
 /*
  * IRQ descriptor to catch the following cases:
  *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
  */
 FIELD(VERSAL_IRQ, IRQ, 0, 16)
@@ -1361,11 +1353,11 @@ static DeviceState *versal_create_ospi(Versal *s,
 
     memory_region_add_subregion(&s->mr_ps, map->dac,
                                 linear_mr);
 
     /* OSPI irq */
-    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", NUM_OSPI_IRQ_LINES,
+    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", 3,
                             map->irq);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(orgate, 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(dma_src), 0, qdev_get_gpio_in(orgate, 1));
     sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
@@ -1622,22 +1614,16 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
 static void versal_unimp(Versal *s)
 {
     DeviceState *slcr;
     qemu_irq gpio_in;
 
-    versal_unimp_area(s, "psm", &s->mr_ps,
-                        MM_PSM_START, MM_PSM_END - MM_PSM_START);
-    versal_unimp_area(s, "crf", &s->mr_ps,
-                        MM_FPD_CRF, MM_FPD_CRF_SIZE);
-    versal_unimp_area(s, "apu", &s->mr_ps,
-                        MM_FPD_FPD_APU, MM_FPD_FPD_APU_SIZE);
-    versal_unimp_area(s, "crp", &s->mr_ps,
-                        MM_PMC_CRP, MM_PMC_CRP_SIZE);
-    versal_unimp_area(s, "iou-scntr", &s->mr_ps,
-                        MM_IOU_SCNTR, MM_IOU_SCNTR_SIZE);
-    versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps,
-                        MM_IOU_SCNTRS, MM_IOU_SCNTRS_SIZE);
+    versal_unimp_area(s, "psm", &s->mr_ps, 0xffc80000, 0x70000);
+    versal_unimp_area(s, "crf", &s->mr_ps, 0xfd1a0000, 0x140000);
+    versal_unimp_area(s, "apu", &s->mr_ps, 0xfd5c0000, 0x100);
+    versal_unimp_area(s, "crp", &s->mr_ps, 0xf1260000, 0x10000);
+    versal_unimp_area(s, "iou-scntr", &s->mr_ps, 0xff130000, 0x10000);
+    versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps, 0xff140000, 0x10000);
 
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_sd_emmc_sel,
                             "sd-emmc-sel-dummy", 2);
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_qspi_ospi_mux_sel,
                             "qspi-ospi-mux-sel-dummy", 1);
-- 
2.50.1


