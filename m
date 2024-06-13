Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544E8C27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmVc-0000dZ-Vw; Thu, 13 Jun 2024 11:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sHmVb-0000c2-1N; Thu, 13 Jun 2024 11:37:03 -0400
Received: from mail-mw2nam04on20624.outbound.protection.outlook.com
 ([2a01:111:f403:240a::624]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sHmVY-000203-V7; Thu, 13 Jun 2024 11:37:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fResP65SgStRNizV2fUeNG6m9IMomhoPfpdLBKy38SV3kJ6PI82WS/E58O9ZuBYcPqjItHAqWyGmGjAtP52GT0uFywTlqLOlC65qAKh4bPZN2hp42xSaPDM7yhFpdj7mmcrbc24JD5OjmCPTj1FVR88eRU2ECcvLzZ1FhRnx4EKG3Tpgl3FbI/Dfyz53CM4n1o3ijcXCI0/zNh4kmSc9qrcnFTe9v3UFwFwTbiedLpNJOPNMONhe4/3nMfNVPWRw0GSkPt3e5OdZgXvILkBgxE7BoiYmzRC/ppg1nisY5s1Z6pWTXixeHVFY/f8glhaGyChzAuPo60Tf5GZaPlrwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX/Y6uk4jJ/XZMkCaFCAc/LiQ0d91jKbpfc4sXBK6ik=;
 b=d3sFGRHKRm7MnXbLLFsFPT2ao3gvwB2zQaIuRH3zJtWINYMWvqiErZnAQnikQy85neaQ2O9jku1wANosV/bRrN99B23/U8hJKXLJvXIst7YcAh63FH0qBOSUS+J9meCDVsYtSO1s3udpZ1NJKc2o1J7w77ED05n0cQtP5jojUDjdOopmndCIh/3D/8ksU+rRl1vUHyKyEi964cqZuHETaZ2MqxQFiNLCYTPZGAvSxOceiKDwPj28UO5c6rfctbPI8tFnApCkfLbTxzMgShOVarFGbOYd53ENkcin6CyIM3vgAkjLnBdeOQPvnXNNtjpfD+xqmHluQXdSdKEdgW5ncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX/Y6uk4jJ/XZMkCaFCAc/LiQ0d91jKbpfc4sXBK6ik=;
 b=gEEBv+Ig6wtXQ6vojxuv8rW90XBNKNZ2DeNuUyjhqXAIk/R3WxTktEZPDC/ucsqz0+xjdOQV1XNvvHgptztFq+kDELnZcLgfH3bSKIJTFoZv3VDOc5ap5iC+A3xnqnmqp+C129DpyQls4uq858DE4nJZlRJ+TtarMotoxlJmpeU=
Received: from PH7P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::11)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 15:36:53 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::16) by PH7P221CA0015.outlook.office365.com
 (2603:10b6:510:32a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 15:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 15:36:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 10:36:50 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 13 Jun 2024 10:36:48 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>,
 <francisco.iglesias@amd.com>
Subject: [PATCH 1/2] hw/misc/zynq_slcr: Add BootMode property
Date: Thu, 13 Jun 2024 21:06:37 +0530
Message-ID: <20240613153638.3858853-2-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613153638.3858853-1-sai.pavan.boddu@amd.com>
References: <20240613153638.3858853-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: b36ad8f8-15cb-4f09-99bb-08dc8bbea62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230035|36860700008|82310400021|1800799019|376009; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F89XbOcfGaK8nWYSxIig0VORhkRjOslm1+KMz7Q3/5hkm3U1obmTpnillu8n?=
 =?us-ascii?Q?UHxHtNRCH9F3TNvsIiDGK/2XKpFvf23XFew0fHr7UhYs9UTlPmLnyCu8eyGQ?=
 =?us-ascii?Q?7j69f26NA7Qjw8W9YxBLIsEKV4G5hVzrCTPEa5d8fu0p5s/vmrvOZ6tzCNDa?=
 =?us-ascii?Q?omJlBz8LiO4Z2jIzGZjUxeT7tuLucoDQssMaTnv4qpOcNxDT8wmTHAI19K94?=
 =?us-ascii?Q?AcbskGoOLCCGKD6vDktg2mlj1Yq344YYvnWMyiUNuRsfU/4d5GOZQjWd23Se?=
 =?us-ascii?Q?iBGRah9gRaA49S+hfcDjZPiPUmobm3BzaTbCw3lr0R3ua4J1oxEZqDSbjcIp?=
 =?us-ascii?Q?N/2dxuSkxGNbgVydTjBqlv4AJBR62afZNo43QoAgjyf+iEvFkTTSZt9vLl3k?=
 =?us-ascii?Q?VgTirZ12Urye2+/gyo53SSy2v2qsXj+8esWtI08s8H9sH72WWx6Th0E3YBUH?=
 =?us-ascii?Q?NtauBKs4/bQEeKntDfbUg10XxAwvZ38RkOmCP+JwnZeWeMlAw19PdMYSmKL8?=
 =?us-ascii?Q?t8hZ/utd+fHsXhoH449bKX5+GQKd+FmWKGn3nxX1sVLT/Hsdw3IUvBHOV/ey?=
 =?us-ascii?Q?UM+CHq1hex1/SQLJiuu7MVsTb5VA5sEap9fkO4ME4KQ2xeOPWi8yFGYZBxwt?=
 =?us-ascii?Q?FhpGY35UtM1pXEMm2SUiWrqdy2wSoUzsATQP3pEqLL1HvZPWx4o12dh1rtly?=
 =?us-ascii?Q?PSbQMtaUEcsRA3JqsH5nYK+aq/ucOt6LQDfg1EWfyH66Dfc8pE0R1MZlLN3Z?=
 =?us-ascii?Q?q0FtditO4hc7Bc++r5YKEKDdWolH+yPCfDSFAjI4gfsifcfnepkg35RVVjO8?=
 =?us-ascii?Q?AX07af/3bL/a8lHjrp053T+qrVeuOWV2tC+Eg1UOZjOqxZS/telDkDW8vWD3?=
 =?us-ascii?Q?WFf8ZmmRHP4CRy9DWSBSJfIaDLIjDSuIsMyLJFstgRJveCxdk0QAQO7NrT8O?=
 =?us-ascii?Q?IhOQMo5qaD6gyyDj4NfqLAcUHMHsKKqTOjgvbesv7zt1ws6/tAiHNUEpyWBG?=
 =?us-ascii?Q?m/OysiEn37LPBu8OliSuHyD0IDVvT29oyO7vBO+hoW8SLexs21+SwrYnCtEr?=
 =?us-ascii?Q?pwXK7x5LGdGV6bvRkqiQOA3UYOasauJXqueH7AIltgRStjGKk6LMC4crYFWW?=
 =?us-ascii?Q?cQztjly25orNDizU/7VhzKPwATupUiflWC0K+MKLj4k0UFDJyQH8rcM9M/sx?=
 =?us-ascii?Q?W2gHfz2IiPAzg/Px2TGesdVqRQ0JrJ/nzrcGXP8CPpjtDWcpV+k3S3dQO4Hm?=
 =?us-ascii?Q?Amo1RltZ0eXf1+EooecatvJOeHZVPwJWFohEkkFKauzlLCD/JmaNAu/vMdgo?=
 =?us-ascii?Q?swgN8ZA+Lqz1aYC93sNv1hu9RFhjKVrTdzaA3UYFya6g/JGh/wR0mrokUHxi?=
 =?us-ascii?Q?IUnARdBJOCQOzFLrqvTPBfW5iHFfGPLTtJL3L7mFzkXz5blyrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:36:52.5321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36ad8f8-15cb-4f09-99bb-08dc8bbea62d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
Received-SPF: permerror client-ip=2a01:111:f403:240a::624;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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
 hw/misc/zynq_slcr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 3412ff099e..72703e92a5 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -24,6 +24,7 @@
 #include "hw/registerfields.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
 
 #ifndef ZYNQ_SLCR_ERR_DEBUG
 #define ZYNQ_SLCR_ERR_DEBUG 0
@@ -121,6 +122,7 @@ REG32(RST_REASON, 0x250)
 
 REG32(REBOOT_STATUS, 0x258)
 REG32(BOOT_MODE, 0x25c)
+    FIELD(BOOT_MODE, BOOT_MODE, 0, 4)
 
 REG32(APU_CTRL, 0x300)
 REG32(WDT_CLK_SEL, 0x304)
@@ -195,6 +197,7 @@ struct ZynqSLCRState {
     Clock *ps_clk;
     Clock *uart0_ref_clk;
     Clock *uart1_ref_clk;
+    uint8_t BootMode;
 };
 
 /*
@@ -371,7 +374,7 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
     s->regs[R_FPGA_RST_CTRL]  = 0x01F33F0F;
     s->regs[R_RST_REASON]     = 0x00000040;
 
-    s->regs[R_BOOT_MODE]      = 0x00000001;
+    s->regs[R_BOOT_MODE]      = s->BootMode & R_BOOT_MODE_BOOT_MODE_MASK;
 
     /* 0x700 - 0x7D4 */
     for (i = 0; i < 54; i++) {
@@ -610,6 +613,11 @@ static const VMStateDescription vmstate_zynq_slcr = {
     }
 };
 
+static Property zynq_slcr_props[] = {
+    DEFINE_PROP_UINT8("boot-mode", ZynqSLCRState, BootMode, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void zynq_slcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -619,6 +627,7 @@ static void zynq_slcr_class_init(ObjectClass *klass, void *data)
     rc->phases.enter = zynq_slcr_reset_init;
     rc->phases.hold  = zynq_slcr_reset_hold;
     rc->phases.exit  = zynq_slcr_reset_exit;
+    device_class_set_props(dc, zynq_slcr_props);
 }
 
 static const TypeInfo zynq_slcr_info = {
-- 
2.34.1


