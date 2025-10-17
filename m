Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2CBCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nAd-0005Vw-HA; Fri, 17 Oct 2025 12:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAX-0005Sc-JY; Fri, 17 Oct 2025 12:19:06 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAO-0007dN-AA; Fri, 17 Oct 2025 12:19:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwavOdsx+r1HhY8ZLLmgfvdcC07KJ+Hk4X17ls+L9Fm1iIdLbHe1VhlwwmqlDaqVtMLHWIEemJNh8szquIHstSDZSR8AqU+MciNPwqxOFEpeTHxN6XwneT0HUG3R7I8lrX3NGKuZRivpVXKQcH3UD8xRDzMy+hlVsqBw0k1UfmDiLwcHtMpqmdI4WLQaH8+3qZAAMP/XhrR/r6FFfIH8BGkYYQrLdZPUgDWe0OPJddN2z+eDGq01h7DsoVURLti89aJAbN8glM56ILJP5kKZWlnz4fhmsiZ4qoGPVs28FlUJyrSyt9uXtCxT053/pQLptjoSiltKf6JMNSsDOC4sOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOEOYx4MrjjaLF0Z1zZAB4qtICOXxN/H4XWiXH96VGk=;
 b=LSJ1U8oe4iUTHJpYQVZZsPeNmWoUeA0lbAH3w+stD7mB1p/Qew3BHntmXexAd63T83Kb82nAIaiiSLygn3Bdag2RfJB+8ObJNCIFsTbD3SlyTa0YZwNwbqlWha52v0+Eg8KLV7UDIci0hNDLpG5lVjJ1YR9iT/OHriitVm+Ycc2ClMHPNg64mmFm8TDSAuLkN0ZPuV2bHGd1eVZsQSL5MB/u2f/W0978i/Jfug9GIZx/Q4wzyUolK87xzG+Pr3gNJla889XnXx1aUgTy6V8WIr61atARECR0/LXtCehZidVWXKb0X7qvAL32rZf/Z8yIq/R2uaX+gSaFBCuxG29IIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOEOYx4MrjjaLF0Z1zZAB4qtICOXxN/H4XWiXH96VGk=;
 b=l63FU7VQe91OmUpAZlTX9aLEn2Q5d+N6mmAhgcmp2dR1xQMw6kd81jTAsGe/qFRroJrJxcXpiXRFsi/exrorp2VVVBhMFqjkSDJ8l8eOj70Zjdqd2/HgrCGz5UVhEpenW/+B6nlnkyjfvrEdSsvtQ+JvG6ZxsQ7OWa4ERpJwzxM=
Received: from BN9PR03CA0164.namprd03.prod.outlook.com (2603:10b6:408:f4::19)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 16:18:37 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::ae) by BN9PR03CA0164.outlook.office365.com
 (2603:10b6:408:f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 16:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 16:18:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 17 Oct
 2025 09:18:36 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Oct
 2025 11:18:35 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Fri, 17 Oct 2025 09:18:34 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Alistair
 Francis" <alistair.francis@wdc.com>
Subject: [PATCH v3 3/6] hw/core/register: remove the calls to
 `register_finalize_block'
Date: Fri, 17 Oct 2025 18:18:02 +0200
Message-ID: <20251017161809.235740-4-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017161809.235740-1-luc.michel@amd.com>
References: <20251017161809.235740-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: f52f2feb-10c4-4a9f-51fb-08de0d98d3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uGMG7JuZb8I4RJS/0rS7+MfrdHjSJgk8XMW/aHKLuVMbQCuhIh3PZ+FlfcNF?=
 =?us-ascii?Q?psx6nPfTCzP1mYcljWPeYRmFOQP3z7xYyXaFE6ZII/T1/k/mnyHeXFgtJ2EQ?=
 =?us-ascii?Q?wcs31oaCBxG5wD6Ol5xHuoONHQihva5TLgeDcZEDC56yZr0ASQ66LPGDbt5E?=
 =?us-ascii?Q?WqU4l6+qoXLV0TrbdDv4jdSmmg7jHDUrLpCqA9Ru0XnX0xyJukhcrHWL4NM1?=
 =?us-ascii?Q?5wgi5UNgrvLLb+TDWDEVIXY1TwFhWOqHfla+M4QJWoUFA4kZqNd69lWnPBto?=
 =?us-ascii?Q?ziMTMXznhfUPBTQdrtdM71T6KLzCTlWzdy7izR2lsNpuxd2YRP/0Hj8dsV1g?=
 =?us-ascii?Q?Vqi0HoM4RTtceUvmQgFUrrSu6dTN2kWbNvzbVBxHi4JgqEbht9p6B39EmL9v?=
 =?us-ascii?Q?5dywVEieVX4SEkZEIqy/KJB7NUmJ7X5GYNFsD0hq9zPFxF5IIl/KTlPOW9SE?=
 =?us-ascii?Q?F1E7zfs4DH4hZIsof4MmjMm26QX4jWiRY3Xc2xO0AmsvTkZp/gPrYQDYO72w?=
 =?us-ascii?Q?QCCuT0UZYzgEsCe6PHdAJqka1pSH8IOdBd6GsUWDi8pNMydgZ4hM2OBiaj/G?=
 =?us-ascii?Q?GhFQn3DqK1VUslXFAdZKwTPsYGzRwGKsnmX8S2CpA/gzXMzAjDP5mgHOnl4/?=
 =?us-ascii?Q?yYsf3tYyLmk/kzBvvcN49FAEoVjKjOdHo21zlzaRp0YdKu5FrsrZDG3M4BRO?=
 =?us-ascii?Q?91pRzhSQvOahD5xQXG4r+Wt5taUb5gxGFJ5vp4rHi+5aXswkg7oM8aPDsZsZ?=
 =?us-ascii?Q?189uU59BGXCjSN2rVKNCn8hHAldY9JnDK4JDKjRqK7pKVfLqRxHRLoaWQ+G1?=
 =?us-ascii?Q?ToPc102YxVNLHUrKKbB+eVYndLf6HswgA0+TPJBiBJxb1lhTdvCQP4n+AhYt?=
 =?us-ascii?Q?WBFLP38jJiVpxgd8t0lkvjio8lPMLa3AP1FXScLnBXMSIYERU++nzkDaRjo7?=
 =?us-ascii?Q?FuDqBj1pBr/RKNhmGyf3vRw6SK+C54wbyAD1WnWL/rxH+LPbwSC/bQAfXvaV?=
 =?us-ascii?Q?4DdI3XA9Z65Q1zcU3F8I0SDlmYuwb/42wPQD/ol4LvER5d/J322DI2cLvh3V?=
 =?us-ascii?Q?Cmi0+x6bA47ZgrKXhbGmXKeC6oNGVIghLahiUFZiDGfP+zyIaEiaNdFGrX4T?=
 =?us-ascii?Q?6ZLE5Ls608ukA++bHZT1qFqsnw920tIDa4INa7eUxTJlFjuDQVLeIv5yRupQ?=
 =?us-ascii?Q?dzzvBZ7BfTc84Lzm07CHdLU6Kq8221lCrZBi/7wTnUhV5+SWvqQ0dr5BgGs9?=
 =?us-ascii?Q?+mV1Vc8OHc1dnKutIYL+4fLKthG1tzPdB1JUXsmA1PhAF8tU5Qd/SrJZ7ENx?=
 =?us-ascii?Q?Z0BjJ9yoKTNS2hG3tnVlzABqACorzQCYaP0z64w9OzE537AzU9+20QGBo1eP?=
 =?us-ascii?Q?NqMl3doJfke/TKS1sgZYljsIE/efPXDVa+EjU9F6C8G8BWL1wZTuE08UmSEm?=
 =?us-ascii?Q?trBGuBHldWI4C8vd20sELj8hPXUr5vcD2IXC5RN5MwnOJZA1us3yl8zlUqIx?=
 =?us-ascii?Q?zy1w05aut7M4/OLjyEwW4EmvY1+79aE2E/wKh6S5tBctGtNOZk5M85dEISEh?=
 =?us-ascii?Q?S7rGcQyY5QZZwoPkn+4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:18:37.0303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52f2feb-10c4-4a9f-51fb-08de0d98d3ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Luc.Michel@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

This function is now a no-op. The register array is parented to the
device and get finalized when the device is.

Drop all the calls to `register_finalize_block'. Drop the
RegisterInfoArray reference when it is not used elsewhere in the device.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/misc/xlnx-versal-crl.h      |  1 -
 include/hw/misc/xlnx-versal-xramc.h    |  1 -
 include/hw/misc/xlnx-zynqmp-apu-ctrl.h |  1 -
 include/hw/misc/xlnx-zynqmp-crf.h      |  1 -
 include/hw/nvram/xlnx-bbram.h          |  1 -
 hw/misc/xlnx-versal-crl.c              | 38 +++++++++++---------------
 hw/misc/xlnx-versal-trng.c             |  1 -
 hw/misc/xlnx-versal-xramc.c            | 12 ++------
 hw/misc/xlnx-zynqmp-apu-ctrl.c         | 12 ++------
 hw/misc/xlnx-zynqmp-crf.c              | 12 ++------
 hw/nvram/xlnx-bbram.c                  | 13 ++-------
 hw/nvram/xlnx-versal-efuse-ctrl.c      |  1 -
 hw/nvram/xlnx-zynqmp-efuse.c           |  8 ------
 13 files changed, 28 insertions(+), 74 deletions(-)

diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index f6b8694ebea..49ed500acde 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -531,11 +531,10 @@ REG32(VERSAL2_RST_OCM, 0x3d8)
 #define VERSAL2_CRL_R_MAX (R_VERSAL2_RST_OCM + 1)
 
 struct XlnxVersalCRLBase {
     SysBusDevice parent_obj;
 
-    RegisterInfoArray *reg_array;
     uint32_t *regs;
 };
 
 struct XlnxVersalCRLBaseClass {
     SysBusDeviceClass parent_class;
diff --git a/include/hw/misc/xlnx-versal-xramc.h b/include/hw/misc/xlnx-versal-xramc.h
index d3d1862676f..35e4e8b91dd 100644
--- a/include/hw/misc/xlnx-versal-xramc.h
+++ b/include/hw/misc/xlnx-versal-xramc.h
@@ -88,10 +88,9 @@ typedef struct XlnxXramCtrl {
     struct {
         uint64_t size;
         unsigned int encoded_size;
     } cfg;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[XRAM_CTRL_R_MAX];
     RegisterInfo regs_info[XRAM_CTRL_R_MAX];
 } XlnxXramCtrl;
 #endif
diff --git a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
index c3bf3c1583b..fbfe34aa7e5 100644
--- a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
+++ b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
@@ -83,11 +83,10 @@ struct XlnxZynqMPAPUCtrl {
     qemu_irq irq_imr;
 
     uint8_t cpu_pwrdwn_req;
     uint8_t cpu_in_wfi;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[APU_R_MAX];
     RegisterInfo regs_info[APU_R_MAX];
 };
 
 #endif
diff --git a/include/hw/misc/xlnx-zynqmp-crf.h b/include/hw/misc/xlnx-zynqmp-crf.h
index 02ef0bdeeee..c746ae10397 100644
--- a/include/hw/misc/xlnx-zynqmp-crf.h
+++ b/include/hw/misc/xlnx-zynqmp-crf.h
@@ -201,11 +201,10 @@ REG32(RST_DDR_SS, 0x108)
 struct XlnxZynqMPCRF {
     SysBusDevice parent_obj;
     MemoryRegion iomem;
     qemu_irq irq_ir;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[CRF_R_MAX];
     RegisterInfo regs_info[CRF_R_MAX];
 };
 
 #endif
diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index 58acbe9f51b..af90900bfc6 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -45,11 +45,10 @@ struct XlnxBBRam {
 
     uint32_t crc_zpads;
     bool bbram8_wo;
     bool blk_ro;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[RMAX_XLNX_BBRAM];
     RegisterInfo regs_info[RMAX_XLNX_BBRAM];
 };
 
 #endif
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 10e6af002ba..5987f32c716 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -632,21 +632,21 @@ static const MemoryRegionOps crl_ops = {
 static void versal_crl_init(Object *obj)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
     XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
     int i;
 
-    xvcb->reg_array =
-        register_init_block32(DEVICE(obj), crl_regs_info,
-                              ARRAY_SIZE(crl_regs_info),
-                              s->regs_info, s->regs,
-                              &crl_ops,
-                              XLNX_VERSAL_CRL_ERR_DEBUG,
-                              CRL_R_MAX * 4);
+    reg_array = register_init_block32(DEVICE(obj), crl_regs_info,
+                                      ARRAY_SIZE(crl_regs_info),
+                                      s->regs_info, s->regs,
+                                      &crl_ops,
+                                      XLNX_VERSAL_CRL_ERR_DEBUG,
+                                      CRL_R_MAX * 4);
     xvcb->regs = s->regs;
-    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 
     for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
         object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
                                  (Object **)&s->cfg.rpu[i],
@@ -686,21 +686,22 @@ static void versal_crl_init(Object *obj)
 static void versal2_crl_init(Object *obj)
 {
     XlnxVersal2CRL *s = XLNX_VERSAL2_CRL(obj);
     XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
     size_t i;
 
-    xvcb->reg_array = register_init_block32(DEVICE(obj), versal2_crl_regs_info,
-                                            ARRAY_SIZE(versal2_crl_regs_info),
-                                            s->regs_info, s->regs,
-                                            &crl_ops,
-                                            XLNX_VERSAL_CRL_ERR_DEBUG,
-                                            VERSAL2_CRL_R_MAX * 4);
+    reg_array = register_init_block32(DEVICE(obj), versal2_crl_regs_info,
+                                      ARRAY_SIZE(versal2_crl_regs_info),
+                                      s->regs_info, s->regs,
+                                      &crl_ops,
+                                      XLNX_VERSAL_CRL_ERR_DEBUG,
+                                      VERSAL2_CRL_R_MAX * 4);
     xvcb->regs = s->regs;
 
-    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
 
     for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
         object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
                                  (Object **)&s->cfg.rpu[i],
                                  qdev_prop_allow_set_link_before_realize,
@@ -748,16 +749,10 @@ static void versal2_crl_init(Object *obj)
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG);
     }
 }
 
-static void crl_finalize(Object *obj)
-{
-    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_versal_crl = {
     .name = TYPE_XLNX_VERSAL_CRL,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
@@ -802,11 +797,10 @@ static void versal2_crl_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo crl_base_info = {
     .name          = TYPE_XLNX_VERSAL_CRL_BASE,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XlnxVersalCRLBase),
     .class_size    = sizeof(XlnxVersalCRLBaseClass),
-    .instance_finalize = crl_finalize,
     .abstract      = true,
 };
 
 static const TypeInfo versal_crl_info = {
     .name          = TYPE_XLNX_VERSAL_CRL,
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index f34dd3ef352..2b573a45bdb 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -625,11 +625,10 @@ static void trng_init(Object *obj)
 
 static void trng_finalize(Object *obj)
 {
     XlnxVersalTRng *s = XLNX_VERSAL_TRNG(obj);
 
-    register_finalize_block(s->reg_array);
     g_rand_free(s->prng);
     s->prng = NULL;
 }
 
 static void trng_reset_hold(Object *obj, ResetType type)
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index 07370b80c0d..d90f3e87c74 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -188,28 +188,23 @@ static void xram_ctrl_realize(DeviceState *dev, Error **errp)
 
 static void xram_ctrl_init(Object *obj)
 {
     XlnxXramCtrl *s = XLNX_XRAM_CTRL(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
 
-    s->reg_array =
+    reg_array =
         register_init_block32(DEVICE(obj), xram_ctrl_regs_info,
                               ARRAY_SIZE(xram_ctrl_regs_info),
                               s->regs_info, s->regs,
                               &xram_ctrl_ops,
                               XLNX_XRAM_CTRL_ERR_DEBUG,
                               XRAM_CTRL_R_MAX * 4);
-    sysbus_init_mmio(sbd, &s->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 }
 
-static void xram_ctrl_finalize(Object *obj)
-{
-    XlnxXramCtrl *s = XLNX_XRAM_CTRL(obj);
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_xram_ctrl = {
     .name = TYPE_XLNX_XRAM_CTRL,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
@@ -239,11 +234,10 @@ static const TypeInfo xram_ctrl_info = {
     .name              = TYPE_XLNX_XRAM_CTRL,
     .parent            = TYPE_SYS_BUS_DEVICE,
     .instance_size     = sizeof(XlnxXramCtrl),
     .class_init        = xram_ctrl_class_init,
     .instance_init     = xram_ctrl_init,
-    .instance_finalize = xram_ctrl_finalize,
 };
 
 static void xram_ctrl_register_types(void)
 {
     type_register_static(&xram_ctrl_info);
diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
index e85da32d99c..08777496d56 100644
--- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
+++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
@@ -177,20 +177,21 @@ static void zynqmp_apu_handle_wfi(void *opaque, int irq, int level)
 }
 
 static void zynqmp_apu_init(Object *obj)
 {
     XlnxZynqMPAPUCtrl *s = XLNX_ZYNQMP_APU_CTRL(obj);
+    RegisterInfoArray *reg_array;
     int i;
 
-    s->reg_array =
+    reg_array =
         register_init_block32(DEVICE(obj), zynqmp_apu_regs_info,
                               ARRAY_SIZE(zynqmp_apu_regs_info),
                               s->regs_info, s->regs,
                               &zynqmp_apu_ops,
                               XILINX_ZYNQMP_APU_ERR_DEBUG,
                               APU_R_MAX * 4);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->reg_array->mem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_imr);
 
     for (i = 0; i < APU_MAX_CPU; ++i) {
         g_autofree gchar *prop_name = g_strdup_printf("cpu%d", i);
         object_property_add_link(obj, prop_name, TYPE_ARM_CPU,
@@ -206,16 +207,10 @@ static void zynqmp_apu_init(Object *obj)
                              "CPU_POWER_STATUS", 4);
     /* wfi_in is used as input from CPUs as wfi request. */
     qdev_init_gpio_in_named(DEVICE(obj), zynqmp_apu_handle_wfi, "wfi_in", 4);
 }
 
-static void zynqmp_apu_finalize(Object *obj)
-{
-    XlnxZynqMPAPUCtrl *s = XLNX_ZYNQMP_APU_CTRL(obj);
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_zynqmp_apu = {
     .name = TYPE_XLNX_ZYNQMP_APU_CTRL,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
@@ -239,11 +234,10 @@ static const TypeInfo zynqmp_apu_info = {
     .name              = TYPE_XLNX_ZYNQMP_APU_CTRL,
     .parent            = TYPE_SYS_BUS_DEVICE,
     .instance_size     = sizeof(XlnxZynqMPAPUCtrl),
     .class_init        = zynqmp_apu_class_init,
     .instance_init     = zynqmp_apu_init,
-    .instance_finalize = zynqmp_apu_finalize,
 };
 
 static void zynqmp_apu_register_types(void)
 {
     type_register_static(&zynqmp_apu_info);
diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
index cccca0e814e..d9c1bd50e4f 100644
--- a/hw/misc/xlnx-zynqmp-crf.c
+++ b/hw/misc/xlnx-zynqmp-crf.c
@@ -209,28 +209,23 @@ static const MemoryRegionOps crf_ops = {
 
 static void crf_init(Object *obj)
 {
     XlnxZynqMPCRF *s = XLNX_ZYNQMP_CRF(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
 
-    s->reg_array =
+    reg_array =
         register_init_block32(DEVICE(obj), crf_regs_info,
                               ARRAY_SIZE(crf_regs_info),
                               s->regs_info, s->regs,
                               &crf_ops,
                               XLNX_ZYNQMP_CRF_ERR_DEBUG,
                               CRF_R_MAX * 4);
-    sysbus_init_mmio(sbd, &s->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
     sysbus_init_irq(sbd, &s->irq_ir);
 }
 
-static void crf_finalize(Object *obj)
-{
-    XlnxZynqMPCRF *s = XLNX_ZYNQMP_CRF(obj);
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_crf = {
     .name = TYPE_XLNX_ZYNQMP_CRF,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
@@ -253,11 +248,10 @@ static const TypeInfo crf_info = {
     .name              = TYPE_XLNX_ZYNQMP_CRF,
     .parent            = TYPE_SYS_BUS_DEVICE,
     .instance_size     = sizeof(XlnxZynqMPCRF),
     .class_init        = crf_class_init,
     .instance_init     = crf_init,
-    .instance_finalize = crf_finalize,
 };
 
 static void crf_register_types(void)
 {
     type_register_static(&crf_info);
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 5702bb3f310..22aefbc240d 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -454,30 +454,24 @@ static void bbram_ctrl_realize(DeviceState *dev, Error **errp)
 
 static void bbram_ctrl_init(Object *obj)
 {
     XlnxBBRam *s = XLNX_BBRAM(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
 
-    s->reg_array =
+    reg_array =
         register_init_block32(DEVICE(obj), bbram_ctrl_regs_info,
                               ARRAY_SIZE(bbram_ctrl_regs_info),
                               s->regs_info, s->regs,
                               &bbram_ctrl_ops,
                               XLNX_BBRAM_ERR_DEBUG,
                               R_MAX * 4);
 
-    sysbus_init_mmio(sbd, &s->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
     sysbus_init_irq(sbd, &s->irq_bbram);
 }
 
-static void bbram_ctrl_finalize(Object *obj)
-{
-    XlnxBBRam *s = XLNX_BBRAM(obj);
-
-    register_finalize_block(s->reg_array);
-}
-
 static void bbram_prop_set_drive(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
 
@@ -540,11 +534,10 @@ static const TypeInfo bbram_ctrl_info = {
     .name          = TYPE_XLNX_BBRAM,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XlnxBBRam),
     .class_init    = bbram_ctrl_class_init,
     .instance_init = bbram_ctrl_init,
-    .instance_finalize = bbram_ctrl_finalize,
 };
 
 static void bbram_ctrl_register_types(void)
 {
     type_register_static(&bbram_ctrl_info);
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 90962198008..6f17f32a0c3 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -726,11 +726,10 @@ static void efuse_ctrl_init(Object *obj)
 
 static void efuse_ctrl_finalize(Object *obj)
 {
     XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
 
-    register_finalize_block(s->reg_array);
     g_free(s->extra_pg0_lock_spec);
 }
 
 static const VMStateDescription vmstate_efuse_ctrl = {
     .name = TYPE_XLNX_VERSAL_EFUSE_CTRL,
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index 5a218c32e84..ce35bb0cc1f 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -814,17 +814,10 @@ static void zynqmp_efuse_init(Object *obj)
 
     sysbus_init_mmio(sbd, &s->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 }
 
-static void zynqmp_efuse_finalize(Object *obj)
-{
-    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
-
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_efuse = {
     .name = TYPE_XLNX_ZYNQMP_EFUSE,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
@@ -855,11 +848,10 @@ static const TypeInfo efuse_info = {
     .name          = TYPE_XLNX_ZYNQMP_EFUSE,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XlnxZynqMPEFuse),
     .class_init    = zynqmp_efuse_class_init,
     .instance_init = zynqmp_efuse_init,
-    .instance_finalize = zynqmp_efuse_finalize,
 };
 
 static void efuse_register_types(void)
 {
     type_register_static(&efuse_info);
-- 
2.51.0


