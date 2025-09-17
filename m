Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B42CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqej-0006uI-Pb; Wed, 17 Sep 2025 07:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbQ-0002mf-K1; Wed, 17 Sep 2025 07:45:38 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbL-0001rP-UC; Wed, 17 Sep 2025 07:45:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRg9Vl6uOhx0hVMtBp51I1zwK4jlUsep/dLWhiXfuXjXJE6Y3pQ0X4llZrGTkjazntV6Bg1NoDwFKSjaLp4wBoj3v6sG81zNoE/1w4hYLmqeFG2GjXSyuXqQfzpnEZlOva+oLrmeLkahIsu6NDfxyJyxrmr4ki7CXx5kDnqbfsxRvsssNctbVzfuS/uTQP+J5hrwe+wAANuBnEsNdC5kYWzm67h2guyV9Qc7/Xd6kwgvyAjoHdGPJFdaVbSSwBisY9PuPoPRTtwKBdnwBE/ZAb/ckHviSv0/vlgH3nLwvFRvelWWNfQbSGr7JoZ0p861YVRkVrw8qXXglwlUjtR4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIpIFyWDsQMW/60nqRlO4+3KjxVM9If+h5iV+l0Il7A=;
 b=Sxo/sErUNfsBZwEbzp/P8fhJBWwBva58jv4DYAGVx6zGfoeWnr5Lv5LUob3Tw88Sle8oXfwsi9NA3VbS6j38hRXgUc/2rMXXbBMa0/pp5DL4Gri/3DDpfpZOm/EtjNS3t1OYv8EWDGh6vtdc7lOr2fZ3MimB+t7ysR9wqrkC8HntQP5/Nf2JIDjB3qMhRhVYII6XE0//gu3uTf9joOLfu+tA3kBeW2GMr63lgaJIMEIsb7nkuwJ4jLvj97d+gbFyCmhcd9DTMkVHVpG1/XakKGG8hDC1SVuhsgFOgM8aoYSzAFWa1O0poRWV27G1S1KkE7dph3k0AwByitvb+jQN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIpIFyWDsQMW/60nqRlO4+3KjxVM9If+h5iV+l0Il7A=;
 b=TmA5+gLnCCVsc5bgk6fyowodpB1Zn06r2cVEUvAG9JXrAtW0liu/sfzVSkGu6tctK9cGHwC2JnmWm1RBVgB3p30jnnicTd5DakT7RhvNDfYkHievkQHPFQkSuPowsSR9hbwH6c0u5acsN6V8/qSHFJ7sJEJuI/3q299AibOYUAg=
Received: from SA1P222CA0117.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::23)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 11:45:23 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::17) by SA1P222CA0117.outlook.office365.com
 (2603:10b6:806:3c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 11:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 11:45:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 17 Sep
 2025 04:45:06 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Sep
 2025 06:45:05 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 17 Sep 2025 04:45:04 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 3/7] hw/core/register: remove the calls to
 `register_finalize_block'
Date: Wed, 17 Sep 2025 13:44:44 +0200
Message-ID: <20250917114450.175892-4-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917114450.175892-1-luc.michel@amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e9c9b8-e7be-48da-511e-08ddf5dfafa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3rC+Wygf76349wM9ZcLu1fZUjy3h81jvtOsy6gi8d1zThMpPZb89CHaC+fT6?=
 =?us-ascii?Q?P996p+X6JoNDLbZMQmxtZnzS9u4f9tHlEtyjHHxTEJ4EaqG4o478q1InovOm?=
 =?us-ascii?Q?2Xoy0ew34Sp0ExWGojDjBq0Ts2qWHOjAdos4Wi0Avz3636sRqsm+LyuXdvU6?=
 =?us-ascii?Q?/Ps5GrOHx4DYcanY2LYr2wtwyHwsoAp20B/TLutdNxjwjv8qip6F9n6eWRxR?=
 =?us-ascii?Q?fNtu6yOkdo+kEwG1w28ZOxPM7cz89oUOIwRUYkPY+4m8h/xl8vcYIoPDHNn0?=
 =?us-ascii?Q?J9MvAL3RbifUQPau0bgRicUucAbcziBKPJnWN3Lh2dfZTukDRZS3TdNMCjRz?=
 =?us-ascii?Q?2n2XQGXJfS8dsC5XnIb2N7+csOaL8/43xWjgDu0OxeqlOB/4IMBJat3augCW?=
 =?us-ascii?Q?AryrHfgdrCHhOrUGF8pYsg+/PK0M5htiKlAib2gAVJF0EjxJ5ZXaf3f9bMoj?=
 =?us-ascii?Q?nhs8N8+k0wUJ/wwb1S63GtzTzGXCOI4UNYRXgPTjCuvS/zJgZjmT645pPnPQ?=
 =?us-ascii?Q?PnJe3hIVpg/e+Om7A5vLLvFZzMaMpDPHKd2MaqOSLi1sMZcm1cBcpOo9r/B6?=
 =?us-ascii?Q?/cAaGGy2IvdtFQIW6FByTi3xh4MHLcF8rNV7kNK0reThVxs9oUoyE3HywQj7?=
 =?us-ascii?Q?niqhqPI4aUVZGoued0Ycn8iMlkH6Gpj4HCKSNa9EqN1ErS9DcQ2wl8M7ramA?=
 =?us-ascii?Q?D/dWes3c9eDpSSXXysmXRIW2S/Oag/4XBgUcAAq6iy+0QIRsVg1gP6mQGfSD?=
 =?us-ascii?Q?QW17PiHlWME1rnvWbJ3uQVvQn7griqVQl8HL2jvbsCnzcc0+jQgXBBbMO1Va?=
 =?us-ascii?Q?ZBnkxMx23PtNqnggOdTemUf5Gr5LgtwIO243dxmUIP866RHWGLG07PM4+7gH?=
 =?us-ascii?Q?sF9gxcGPJvN0poCeE8eFDdX1U+keGclQ4mfTrntchiScWsg9AGq/Cpg+fJCD?=
 =?us-ascii?Q?Bn3h8Z2+REwGUkjL8/ppwKoXne+K9xnjurr7gKeajb5SfqZx1+mpN3kXvhCb?=
 =?us-ascii?Q?ZdLzPj8zcbk8WCApbGocVoiqAbaoljqsQVsj9IcwP3pXzgfKty6iUevTrBz/?=
 =?us-ascii?Q?UNX39Cl2AkRtIGFdqMaozhfkLJgKCxRl2OZgu+T5rFe0YctofvKgNmkJa+Y9?=
 =?us-ascii?Q?TTy3XACtk7Ogo/ZbVQQCSqWIo/k8BI4dcugR6sEgE5wmusObDt61rlvFmud0?=
 =?us-ascii?Q?lZgEc2SjA4YgIG8DHxNm0Dwuw3Gs9HqXSaXQg4369iXcVojCDMy5SRyJY7Fl?=
 =?us-ascii?Q?rLsDYhqXPnMI4+/2GPbowunr+al05ye7OgZXdC5WBRMTzFwovmx3bH3KkYBq?=
 =?us-ascii?Q?Ugp3n/K0STMnUTbqqyh34MFnfvch+nuZvN6nEKHaZtnAJZlwEDHGCaetu1kG?=
 =?us-ascii?Q?c30O89VkPW15DLqIFEKqODqll+PQEVFPCsvTu9yQIBTEZhiepWQ3ezqZN5de?=
 =?us-ascii?Q?2UtyJA32tY65QbObg+Y5MrnRnrfjWLuxsnlfChSzRq7Q+j/cZFR9H2GJSX0v?=
 =?us-ascii?Q?bjQYttQbhRd6yoN6ZWc4wtsWkpnBna4uTvLR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:45:22.9287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e9c9b8-e7be-48da-511e-08ddf5dfafa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.50.1


