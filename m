Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E6FC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 09:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrR5-00047p-5G; Wed, 19 Jun 2024 05:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sJrR2-00046Y-Jw; Wed, 19 Jun 2024 05:16:56 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sJrR0-0003rA-Dy; Wed, 19 Jun 2024 05:16:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAT4A1WUpTEDbO1pqFWt/SG3t5Fo7uARFWDKY4fwMv0V3IylHsWMHwL2esE/ufWCp7Mz1TKWNIIsphrOJBRjv3kf4N2GpCCDstwZNNF1et7I8Dq2PKQpO7rNp3o3wo8keRgmzGVPV9tf5KwImQKZZM3VkTVoYWhuPnHVLJZ/XsHqrtc/SrIKlouOQCoxxuvl9DblYSZdIdsJBX+8Z4UnO9J7ZamXeiWpX4Gn68kpvSeoGZHRInkkeCPEayR76ObJpa5vx498EYf7FQld0bzzvsb7nbFa4FSMv1pJKJEKXqh4H6cJT5+j6QrMJxhJWTcsGHGM0T04916EqLYZQApi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WN67zXjHmDGowiH2idVIydJ1Mr0xx31g4bqPPMHYsw=;
 b=Wtd4igSS+Kc0BKmcsY6GAj9d6dbVEWlUNn4dr2C+rWNUJwnb+S09V9MC/sRfXS75VzUFCD5lr7UXwve102Hc1JFGzi8TA9c+iF3yUZABlzkeuKEJv61+LcV/q02Fu9x+sYGhvq+j0pB08uUYYG8kp6jNBUqViiuJylgFDjm1viC3mK9dz+x9KUYIVzsUIAaY/Vs6Xq67ccDsDJzd6t0I3G8aKjeVvXaQ1sL1l76CWxqH6xk/llt0Z2X2k4BZdEbfe+98JV2udL7qWEi+tNLDIJ9qNn4JV4uOLe6ekdjlbPm5/nnVlc3LepJxDJlpZeTd3x2rkxT8qaTqugKJWAnSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WN67zXjHmDGowiH2idVIydJ1Mr0xx31g4bqPPMHYsw=;
 b=x6WFh3mX1y6CqqZat/RaQ/V83odv8ZESFD+TskUNt2PnVMQYhn5fa1EZt3EPPK14VoSQahUmcyqzoKBIwxzZ8k+cgkzZZN+6AT+OyewnP0gl0IaivgQfP2DysXP4dPY+Zi3+B1Y739HHc5jSz51hxi+7smHH9nNfvBgovRf6gIk=
Received: from BL0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:91::24)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:16:49 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::ae) by BL0PR05CA0014.outlook.office365.com
 (2603:10b6:208:91::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Wed, 19 Jun 2024 09:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:16:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 04:16:48 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 19 Jun 2024 04:16:47 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>
Subject: [PATCH v2 1/3] hw/misc/zynq_slcr: Add BootMode property
Date: Wed, 19 Jun 2024 14:46:30 +0530
Message-ID: <20240619091632.2825550-2-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619091632.2825550-1-sai.pavan.boddu@amd.com>
References: <20240619091632.2825550-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: d05d77a5-d018-4c56-8987-08dc90408cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mTZaVEqdlp51MyquSdtChUjHtk0YnNGqvTKgD++yCPC/7pS6oBZoXgpt+uIF?=
 =?us-ascii?Q?9Y67WDq6227UIWdWBWOXLgaG540zcfoJmBBAZflZPHhxpy9qsap/USFvRD2D?=
 =?us-ascii?Q?jSXbzjIZoQLZFOw6u5ZZq857DceX9kpk0c95QzxhkZpXkvS2lpjZXqVIPhM/?=
 =?us-ascii?Q?GQfvzN0gxGqdf+uwitI1FFjMA25AOyCLHni817wdCwjgNaD3j4HRgCZqVoEO?=
 =?us-ascii?Q?PCA+cQnJpsIAXcFrvrxx9wZBTpeifcqK0wSjWhv9I/h0Z2VhGVGOSVYhXarY?=
 =?us-ascii?Q?diHjSE0fQRVgqRrz5qMdLdrUA/cJw3H2ehe9huZdVTfQ2fbLjBk+zuLtxlwh?=
 =?us-ascii?Q?1E9DpBPdmY5EkrCI956CqKfQQ+AOnuUZSX6tn1xyZYCmVRpmZHYFRjlDo8Bd?=
 =?us-ascii?Q?orpFKyizJzgG3QIaeeSu6uNNUEZtS5WAea5tcWNKqp119eRLTFe22th08Ydv?=
 =?us-ascii?Q?XNsHmOrHroriGH942NAYyZmqa0SmmtSLIESg7zk9xEGb6eKF9XPH42ysMT3f?=
 =?us-ascii?Q?uK9AZ0ZA6pT13f1AEoAujkoMZXfVmBbeReeYZZHTIjkUc2PIHakgP10dVMgh?=
 =?us-ascii?Q?KsPQimriP3Swpk2tq3MXmLjffB7fFxJLGtunUffz4O9dPwmH2Y22/qW0E3nr?=
 =?us-ascii?Q?p9kgaQ4S4IVs7f8ONm+kOSFpt4w2qKwDFQ4pZ7j88GxNQn0cPS3q11khXOcT?=
 =?us-ascii?Q?8MQh+YJyjfA9c9epAntEygZ61276a8/78L/bj0ijJuew6qvtAMXQLPPprFD7?=
 =?us-ascii?Q?ELaDqI7Byq9ceYJnDgGBCVZbCSpQr3qkR2OIrTPZ2Etmx6Faj1K7yRXS2OdT?=
 =?us-ascii?Q?l2VLrheVepfiq5+HbTjNEm7E+dVl0Fw1SpugqgA6B5M/CG7JVHxAceCCnihZ?=
 =?us-ascii?Q?jLV9xBcUEkqQ/+UuuqD1DuGBoDz+Xn2U7YBNDaxKWSr08Bxc0wyFZn2VLktg?=
 =?us-ascii?Q?ux21G9UMOz92EwaWnN+Ijay6WnOYlXWsCm7TRoMz8984NoT+gFiCFp1fO36t?=
 =?us-ascii?Q?5Jq9fcCj0aRjDps9i3MPwqHEdHNuJ7p6/vswUHOSqpM3gHHIKBltQHD2h5qz?=
 =?us-ascii?Q?GieArgvGcU2suif3ul7iyaq3w/DIjxFJ4TvRsfguE7lLnan05TNPDJrPLO4A?=
 =?us-ascii?Q?cujynmjWMGwQnWVrMQ3XgCQfp16yIOlQP7n/Va4vHc2A/LC/ULsHwlpLGuqu?=
 =?us-ascii?Q?UG5Z9lF1uEiozIi4CHJ+SHoQyoVhKLNdjeTTKzT2jMCbLN2+PLpW/wGcgWcQ?=
 =?us-ascii?Q?VgzyDXGBNfLmQfSF7tUo1PB3gF/lg3TuWM97Jgqce3k6fxkrseV+89UrfZqS?=
 =?us-ascii?Q?KHngsKztxkEROImMVM1natQJHruJYdSB6gM/U0HhDSRZxvLT7c7sPLMytx57?=
 =?us-ascii?Q?iWlKbYaOz+rxkNQIj8+QLEecXf1u5m80AUolfALCKI/kxzsn0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:16:49.4909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05d77a5-d018-4c56-8987-08dc90408cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
Received-SPF: permerror client-ip=2a01:111:f403:2417::601;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

BootMode property sets user values into BOOT_MODE register, on hardware
these are derived from board switches.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
---
 hw/misc/zynq_slcr.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 3412ff099ea..ad814c3a79b 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -24,6 +24,8 @@
 #include "hw/registerfields.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
 
 #ifndef ZYNQ_SLCR_ERR_DEBUG
 #define ZYNQ_SLCR_ERR_DEBUG 0
@@ -121,6 +123,7 @@ REG32(RST_REASON, 0x250)
 
 REG32(REBOOT_STATUS, 0x258)
 REG32(BOOT_MODE, 0x25c)
+    FIELD(BOOT_MODE, BOOT_MODE, 0, 4)
 
 REG32(APU_CTRL, 0x300)
 REG32(WDT_CLK_SEL, 0x304)
@@ -195,6 +198,7 @@ struct ZynqSLCRState {
     Clock *ps_clk;
     Clock *uart0_ref_clk;
     Clock *uart1_ref_clk;
+    uint8_t boot_mode;
 };
 
 /*
@@ -371,7 +375,7 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
     s->regs[R_FPGA_RST_CTRL]  = 0x01F33F0F;
     s->regs[R_RST_REASON]     = 0x00000040;
 
-    s->regs[R_BOOT_MODE]      = 0x00000001;
+    s->regs[R_BOOT_MODE]      = s->boot_mode & R_BOOT_MODE_BOOT_MODE_MASK;
 
     /* 0x700 - 0x7D4 */
     for (i = 0; i < 54; i++) {
@@ -588,6 +592,15 @@ static const ClockPortInitArray zynq_slcr_clocks = {
     QDEV_CLOCK_END
 };
 
+static void zynq_slcr_realize(DeviceState *dev, Error **errp)
+{
+    ZynqSLCRState *s = ZYNQ_SLCR(dev);
+
+    if (s->boot_mode > 0xF) {
+        error_setg(errp, "Invalid boot mode %d specified", s->boot_mode);
+    }
+}
+
 static void zynq_slcr_init(Object *obj)
 {
     ZynqSLCRState *s = ZYNQ_SLCR(obj);
@@ -610,15 +623,22 @@ static const VMStateDescription vmstate_zynq_slcr = {
     }
 };
 
+static Property zynq_slcr_props[] = {
+    DEFINE_PROP_UINT8("boot-mode", ZynqSLCRState, boot_mode, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void zynq_slcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_zynq_slcr;
+    dc->realize = zynq_slcr_realize;
     rc->phases.enter = zynq_slcr_reset_init;
     rc->phases.hold  = zynq_slcr_reset_hold;
     rc->phases.exit  = zynq_slcr_reset_exit;
+    device_class_set_props(dc, zynq_slcr_props);
 }
 
 static const TypeInfo zynq_slcr_info = {
-- 
2.34.1


