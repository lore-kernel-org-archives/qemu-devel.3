Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89BECA0EFF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXO-00017F-8N; Fri, 22 Aug 2025 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWm-0008HV-Lr; Fri, 22 Aug 2025 11:18:05 -0400
Received: from mail-co1nam11on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62d]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWU-0007Et-A3; Fri, 22 Aug 2025 11:17:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT50u2pOrVbF4SNq1RJoScvu5oXN4uQ+fX3uuIake2tDk+DKybQD1fLYaeujeuz9N8LBFScGZJXU6UMaFcS0rn6CfSeaeibwccg1pVHR1GNHF8ZmqhJ3woZ8TZzOibCwDSNGZhFdlDTQiEZOKfPcaOKKmo48+pG6F6kHKPJUYud2CbAe+qlsDMCqMwYuwBpIv30m3W9bcptRNOhslPZdCBclKvTuExBKCsBmQBmfudB8C/WfLzfGYUfBBZvtD3WxPcjAb5pI3zOfstXgNPf6DB9yiQFbAIATwMryQP4bsc3kEJvVXEmeKotvhTykaV0vMFyeWGWsWlaruk+e1a1jjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7sDblw0h7Mzj5f41mX6s+GltxUkt6BbJnlj9XxKuSI=;
 b=tyNfMDOFlUpxgfrRpNmvsnsFT6KUiWWekgFGDIbh7uqvPGYfpxwXQMJFXvLWOnt3Vd9my6/Tz2XGSxJi7A8sYSgPHBixg10zKFKm1qgZMH89nWq831QoSzTS+50qQepcUjaR15XcCgA5O0Vc/FIwTl5527JRtZtQxiR9naFvJ8QlVy4lVGuR6UzzUrpBvje5+KnRMD77HkYMR9O9aYSM3tx67zHqIOZWxuDQB5FmMGXjQ5BXcR1Xau1qYBpnElEfGqRjX4ENftuzyqfjwYLtxChETfNJN2HqzAOSheMM3xRCjEzmf+rpevi4fzepGjrvreWqMKAab5BH1/jL5VmuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7sDblw0h7Mzj5f41mX6s+GltxUkt6BbJnlj9XxKuSI=;
 b=yq2f2fjNNy347Lu/D2STK6bXdunMy/MFwekj/yuQGYP7NxmMiZNT7hPBjBZCMCf5SGi64zmGKg3Bazk+bpfvqLv6xni5hOvk8xVMJdu//Ky6WaQeWzMxo9gE80ip/53YWR4a1L0CbY2j+CF7ijO3+ETZGNQHCzYSJKvBPPtu1DM=
Received: from DS7PR05CA0098.namprd05.prod.outlook.com (2603:10b6:8:56::8) by
 PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 15:17:36 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::4d) by DS7PR05CA0098.outlook.office365.com
 (2603:10b6:8:56::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Fri,
 22 Aug 2025 15:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:34 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:33 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 35/47] hw/arm/xlnx-versal: tidy up
Date: Fri, 22 Aug 2025 17:16:00 +0200
Message-ID: <20250822151614.187856-36-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d199dbc-0207-4f72-1296-08dde18f0648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/pGrV98sHXgxZ6BYa63IJJg838KKgNf2TgcuLNPFylxMpkP8G+V9ndXZoLbY?=
 =?us-ascii?Q?YtgjzLG+JuuJCtB1zWwwVx6ZfRxAVI4EN2LBsUP4KFcGM5N6/7HrPFxoJ433?=
 =?us-ascii?Q?mLakPiZjfdMjYMJ1IC+Np0vLPTxiTGJQ7nDjuJByEvtL0mQ7cNrAaw82jAU/?=
 =?us-ascii?Q?ohu6POfne5VMdXkfP2WuuxJJfqHuc5RdM0fqm+BM4V8uFy2bmHWmyrCaclNM?=
 =?us-ascii?Q?hCsS1iuOTmN1nKLBqtrZ9p1dvrE1f3aAqYr+nBnpOePWH9R7Oh3VlYwo9VEA?=
 =?us-ascii?Q?CEUVeZQoflJ3PbXqEQqmFm/2sqWkJ3bgQKp6YV7jN+cs5BUZO9UzOJgJiuYz?=
 =?us-ascii?Q?OANWB0Ex+FBvK4fRTToWqf/kqhJygIkkmSc/UYJpm/6SDX6bQrDVMCIaQyeg?=
 =?us-ascii?Q?U2YseRC6FycGpGuBY7vzlD8Al6MEnghjPplOjUlljVqNYtK05gCX5P6/T8Lf?=
 =?us-ascii?Q?7yOh5CoOxB5KQcyMjr9llR45nM2qC4P8+mvHqXam9FhuaGmL+xRJOPpTlWDB?=
 =?us-ascii?Q?L5IOoZ10yFKSdIHW3Ehj7wGwVYbQWbw9neTfEKIH6zAjk5JFUD1CqyUNg2vm?=
 =?us-ascii?Q?nlsk9T1SrIkD9JcECqjQfpxpAd53UAS4l8BKdvp2P4R/ShELCd8/8XWq1/P1?=
 =?us-ascii?Q?ENGJBGT1WsjP1F8uLBdNJXslayeD33q5Z1dzbtwSG4YdarAV3OhUmwTPBDip?=
 =?us-ascii?Q?rmr3y1S+dU4ha2+YRpH05yeLn9Zd3ko3P++iRwzC+wye2qSCXPE2HDWbg2v/?=
 =?us-ascii?Q?avSsrpQQM06mfDmh0oOhvnT+JPnp8UyFbpxblR7/4fkDsmREWArq25wT/5eS?=
 =?us-ascii?Q?YjwG0/MU+HyGfN9xFJPO34oTQr//p14m6JVpdQzqDt5Mrhrj0hbijtZrYpSK?=
 =?us-ascii?Q?tt7oGKNLg8PszSXBweaWTk1k+Grz1K4877FefgPSxNqYvNT1eXlaRA5iqHmE?=
 =?us-ascii?Q?PSuzWvLczSSJacYeL2xATqP9GO2tFYJX6/DVy1pPHxWKH6DoChWmllciVbET?=
 =?us-ascii?Q?0NJBOzT1RlUGGUEhgt8A6+TH+97wMPY3EVoPL9OYYxgIX9YWvsZTeNZIfj10?=
 =?us-ascii?Q?G6w9Ncny+jqdsjwkGqVbxw0IpyddjCknOjBb56lnbgBNAgjLVaEHL0uf54z4?=
 =?us-ascii?Q?srjI8hdJ1VaTzMyEBJf6jkoX3Ht6Me964QmDaXZpoYO9VmHKHm0JTLMkJ372?=
 =?us-ascii?Q?oBmESOoP+dawWbsmZ3gtHCXn8++cItTCGNIsx4J3OR629fZ/suwJv3WX8UYH?=
 =?us-ascii?Q?YdJqgxrnzkF+bVBduaGoY5u+0/lWPIm0Ms8zD6A0jDNBwC9M0hwZ+h/rQCoY?=
 =?us-ascii?Q?p/3qY+b8dgyOkD+uiAE/TN6FWfCEq+GdgGZB92xuRvleXUVtNV2PODiYO/EB?=
 =?us-ascii?Q?x4xillGCWhF47LB4zlMlGrYzrb5OGmu27emSA/U+OKyf5k/wVd1zBl7SMOnS?=
 =?us-ascii?Q?BM9lkdeyrIEQMKZQdS3HaSVKLy0j2Q6Oiz/XAOV/ulDeLDta9wJrPuLxXvdw?=
 =?us-ascii?Q?M1v12Q7fJTL247eKIbO6ie25njtl9hUA47v1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:35.7633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d199dbc-0207-4f72-1296-08dde18f0648
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
Received-SPF: permerror client-ip=2a01:111:f403:2416::62d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
index da0260b83de..b6cc71f7209 100644
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
@@ -82,198 +70,6 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s);
 
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
index 3b6413262f0..bd22962341e 100644
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
@@ -1362,11 +1354,11 @@ static DeviceState *versal_create_ospi(Versal *s,
 
     memory_region_add_subregion(&s->mr_ps, map->dac,
                                 linear_mr);
 
     /* OSPI irq */
-    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", NUM_OSPI_IRQ_LINES,
+    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", 3,
                             map->irq);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(orgate, 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(dma_src), 0, qdev_get_gpio_in(orgate, 1));
     sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
@@ -1623,22 +1615,16 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
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


