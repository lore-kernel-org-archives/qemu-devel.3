Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC22DCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50b-0004wD-16; Thu, 21 Aug 2025 09:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zA-0002Qx-22; Thu, 21 Aug 2025 09:05:44 -0400
Received: from mail-dm6nam12on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2417::622]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yw-0003EQ-Na; Thu, 21 Aug 2025 09:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJO60vfBOjbbar+Xc/u9Ar10bsHhVeZ2j1yRf866V9P8xjSt1h5JwLN6yYkILWEUyb/a0rrjKN7QE0o8esQdmEg5F2JX+tEiaQv+YRtTimblVP2vE7nBA+MX5rioNGDx8de+J1GsqBH9nmQJ8sylbqWlQrMZwrL7cdf3rIKfK0ao0shMjvIkDbkxKUujyfgOKMEdBukCq8RtRc2E/+mjWTgnzCoDirDCq5RbzIfFeGWAS3EE+LAm2VQ2T+I9K3MZixGLkgqT5Pxb9JszXMMyYG/fmB1BH28R1Ahz09YPubUQwsPvSiPFmYmCMIhubxJf/kUH3hG29cB8gJueVyMXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBrcGIi9g7dlVdXs0dxFhtF9X9CmiCfPpxFfkOtH0LE=;
 b=U8X7bXytQ13RqkGb22LqjPX2aAd+SAnrEETo2buNnC8ypqQe1zxiG00WECGsnFejujHaDrSxMeJ2kuUTP1YB5ZLL7FgFhi8TXV04s/cWLEsZeBzk7or1FWIvrmwT8/TddjAw73Z5SNEIdMNkpKX+8dqyVLaWYmK/4fQhXPlYo10rYyWtd7lgPbQdf63v+ouVrEyrQvSoMBG10KR+636o4Q0ze7nIzUAV+59Psk4Dp8GXeggtTP9YIa7LXeldjAIM/mP77ASdbHRV+4Y54hfUasIyQ8NoIH5SK5+ZTgaSa1/aQRKMGqFm3YAF+cJ9Cb5xJ1DjKVU2isc3hx4oDPd5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBrcGIi9g7dlVdXs0dxFhtF9X9CmiCfPpxFfkOtH0LE=;
 b=Okeb4akXT9qJfWWB+R1uYdSh8lxsW2JNSA2GmTY9ARsFcEsIre0oVrkzOrtYGToHSQSyU8GCBkBtGCnNtQ04og/ArkKtmCJ4/W95nN6fju0P2beRfnW+Esi5yX0IDJ15px6To2v0wVmkdJc8f5hi/UbIJ9cZ2f4y3QcuzzwxD6c=
Received: from SA9PR13CA0052.namprd13.prod.outlook.com (2603:10b6:806:22::27)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:05:19 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com (2603:10b6:806:22::4)
 by SA9PR13CA0052.outlook.office365.com (2603:10b6:806:22::27) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.8
 via Frontend Transport; Thu, 21 Aug 2025 13:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:05:09 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:07 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 35/47] hw/arm/xlnx-versal: tidy up
Date: Thu, 21 Aug 2025 15:03:34 +0200
Message-ID: <20250821130354.125971-36-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: e88c8796-1940-4a33-2741-08dde0b3613e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?umFWtTLePM7YHt6NS8h9HH0Y+huCR2xaHT29wsoFESvBgc5kS8lmz0yJWEFv?=
 =?us-ascii?Q?3MRRzQNiyxKKJjaxGeo3R3czVHzNb0jeHjuqDCLR03whzpugKlpbtU8Ybke3?=
 =?us-ascii?Q?MmMYAVIZAWSyBGv5lbQHd+KKWPXppBjaApn7Apccb3kDX0fEWR3hvSKnUTi0?=
 =?us-ascii?Q?f2WoUDsYxTDSa+8LzVXFLR9wIoNWGaRh0mQD0ISQhHlbUfnZy9AVCCL1vq93?=
 =?us-ascii?Q?uX1ROFFLgcjKu1htzjUMx6EYbRN6KQOPZd3HCYJvXjJNRtcdwWR/PSF33ufq?=
 =?us-ascii?Q?URbmFaDKSwXafo1NVcZPORkdjmtfFPdGdV6ii9HEiuJpGOfb5D1hqEqRYAbe?=
 =?us-ascii?Q?VSnnaJfkQXnwwPOdyFj/Duo1DqU2q3HvZ5sqlZBHGKX3cbPWnKOkDdkeu3kF?=
 =?us-ascii?Q?T1tGTLpLr+gx0MidxMkWsJG/i93ZpfYYYggetd8/+G0sEpgGjaeHTYn2DC0I?=
 =?us-ascii?Q?QOd9yXelfyZLF1PYeUUyfmIC6767DLdNmBI6B4bHbHyawwefUUJVGL9vsVP9?=
 =?us-ascii?Q?26RYv1tqy1fDwvTTp/hlrnsH3N2SB9VvpnTtyGybNxsHSA+gskvDXJheO/cq?=
 =?us-ascii?Q?Nj1Gj/GRBVkRfmJUJTIroXSP9TJh+O8JYQRHBc/tf8KYUnsr2y7+CkJXqn3J?=
 =?us-ascii?Q?7H+GrGMV/Yxz9wklAotqWOFNa4wsJcOwazdif7O3a5H89+fvXmG9LD8FZUzN?=
 =?us-ascii?Q?pM2FIbNqIV9GL7ce4BBBYNvK4FbZqaHWnr99M/TbhHO6Sd9NNH7SwyutFeFW?=
 =?us-ascii?Q?Y5Ms859N3fGoalcmMfp6Qe+QR1LZcDC6zmM2mzb2RZAF8kzFBLR6ClggkrFY?=
 =?us-ascii?Q?ls42Ubm07pZBqJ6Fii0p/hA7tE5hmIb36jsq00xFwV4W3kYI+5mtzy20mXrk?=
 =?us-ascii?Q?OY0bSsAXdeUjAObsN9Co1VoimmUBlmTwtYeXmCVSoMQnGvrbOdpFER16tg4v?=
 =?us-ascii?Q?8asD28PH0nnHQsHKDnTBx1Tv7oD+iuQMWCCae4yysXM5w2lbwY7kR6n3OS2W?=
 =?us-ascii?Q?cSZHhgaAkOXQZ/J/iZ8sr/01fu50WqW1spjGVEeEOfeepuxgH8s7+UDn3R6o?=
 =?us-ascii?Q?e1vWIxDDB+KkErIP17C0xmg7PH12S0wErGxY+laqulghKJ3L8tc9zUdDVzPj?=
 =?us-ascii?Q?ev+fa2GsBcWPZDxibEmsW9sEVGO7v8ejgdRYefTnsryMU2EYo4z4to7kQoeR?=
 =?us-ascii?Q?wOKtvbAD0G2Ufpy8pLfGs5wvQQip0/sN5V19tCcaJnvJKjXK4uag2MjQaaPW?=
 =?us-ascii?Q?89ADt6FRTdLHHNVujSaSmwNW8lA5vfpIrq5SCkh1v1dYPVYwcxrzHEA8/nE1?=
 =?us-ascii?Q?Yg6lE60nm9XTzbsHhTXXMy6ziAzktqq8PZ+ip+zDCqCsMhgzgtVHmEIxWmUb?=
 =?us-ascii?Q?3njt//B8y5AIMDKjLCTNi5ufFD3OMr41pai0O1SnnVIP/F94H9QDSK9E5Jwh?=
 =?us-ascii?Q?MYV+mvFo9KyuBKPRKH/kC7Yjrvgxn2+qvbi5j778kll8mwVNU/nAZUXD8nr3?=
 =?us-ascii?Q?Xh1DrvP/KNy8hrnomN5am5wwkcJUL2KGsgsS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:19.1052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88c8796-1940-4a33-2741-08dde0b3613e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
Received-SPF: permerror client-ip=2a01:111:f403:2417::622;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
index 28db3f263c6..a5e6b1a9019 100644
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
@@ -1356,11 +1348,11 @@ static DeviceState *versal_create_ospi(Versal *s,
 
     memory_region_add_subregion(&s->mr_ps, map->dac,
                                 linear_mr);
 
     /* OSPI irq */
-    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", NUM_OSPI_IRQ_LINES,
+    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", 3,
                             map->irq);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(orgate, 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(dma_src), 0, qdev_get_gpio_in(orgate, 1));
     sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
@@ -1617,22 +1609,16 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
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


