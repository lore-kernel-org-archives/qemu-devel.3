Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59812C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKFF0-0002Yl-Hg; Thu, 20 Jun 2024 06:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKFEs-0002ST-Ku; Thu, 20 Jun 2024 06:41:58 -0400
Received: from mail-bn8nam11on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2414::625]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKFEq-0005WV-B5; Thu, 20 Jun 2024 06:41:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoCCuNle2tJ7MXYXECOGKfwQ4bpprSKsfjkS7ChA6yill/dIbaEHfFIerEiNDK+fqRCfodbUjI1+iuAWO6wQfvpVU8iD8lUtpjFvs4UTtB1ya2O7jrygjjeCDpsXNgGU889Q6auN6GJoYGpbds8dbtdWm1JDj/aP9zf6WnikLcO7ORN5486JB0RPatopGzw/ys4VN8HzYcF7ouSqssT/dc2D+JNlnhrr9YDKaRJP3vpsiIFiKZkfueGAEgQF/nONmx1FK3d4sFTDhP8fD9hcb/fS85bhVLMHSs/RNfycXEO8/AAqyuH7ioX8YOiitYR62o8nIgR+YDvI+UTcpOo3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYBn8cCYSZrcur3F/f8p6OefFN+BgWWm0p4D6nqogtA=;
 b=nsMcgNiS9GTChgP8sAtBDtkUgXUO5ZRINndnlvMPI3LR3+2L5aN8CjxPeuazuzejQRORCr2ptvzevHhX2kZrJnXVvQvGndcQ2O6t8ryMI+91rhCpyCqCn4A2udQhv2PJJO+LhhgfYQEHqOCh7JKH1TtgEIQeWO34yInGbhURbBYybP6K2yV7kY3112pYLebG21ehlM0FLLnF0NBhsSFpxeYkSiHa3MEGjkls5/rXLGj/9Cnt0Poq0NI9SsuzPJZfqR/e8IJxF0TCbCp4MG9ke/R+42clTFjbL3ktTLDdkeAvKcJZq6RBxp0qtqrF9M9aeGD0iyQk+y40kOAJVmCFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYBn8cCYSZrcur3F/f8p6OefFN+BgWWm0p4D6nqogtA=;
 b=lkfGVFZ73aixBik9ZzGZeLX04KN0NBp6lKyz1TvVa4QL3AXJXjUCzsEMlkoGe3wiZadZq9X8/Gc9TctuWmxJIjW4DZK7b8+Ypf5/uJYeeSrpBjRSz+4aHzwtDgNDEOJYdjRlYrCgfqYpguPuztPKBEVppN21Mvo++QKTzzk7W20=
Received: from BYAPR05CA0093.namprd05.prod.outlook.com (2603:10b6:a03:e0::34)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 10:41:52 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::e4) by BYAPR05CA0093.outlook.office365.com
 (2603:10b6:a03:e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 10:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 10:41:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 05:41:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 05:41:49 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 20 Jun 2024 05:41:48 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>, "Edgar E .
 Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v3 1/3] hw/misc/zynq_slcr: Add boot-mode property
Date: Thu, 20 Jun 2024 16:11:37 +0530
Message-ID: <20240620104139.217908-2-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
References: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 661a38b3-3bdd-4201-bde8-08dc91159895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M0rzBIpGCAIeYfsPU9oYhG7pKnE1bUGmZeYVYgGD/uLUefo7VBnwVRLpJuP/?=
 =?us-ascii?Q?babykBshBPy6rbVa7CZepe2cft98RLqQ6QjmgYPlzTheACM6n6c4RPds+0NL?=
 =?us-ascii?Q?c6Mg/tanRo3sE1l+gXqfzG/bcumsFkeTEHG2Oh+WI2BOqWzVdJBhnZCIpDTI?=
 =?us-ascii?Q?TqNMQOjBBmi2nnmXKbwAMlgA81v0hJ1apHix1fVqpkByh8XA+lQws3qLL3it?=
 =?us-ascii?Q?jVepkM9KOOCdH0XxTUAhltQWX+hzGR914kaazhE9tKgI6CfPGYckhy4a+evj?=
 =?us-ascii?Q?Z9KBXYAdqEMkLjGdmpkIfQvhGoFS03Isi4E3G3w2eWBdtWCuEYBh8zcDFzLF?=
 =?us-ascii?Q?je4uVr5QUTOjkFXYTLdjFoCiTnxXyQbUiegPG/wn55D3vZJYFc2JQ0JRQN5k?=
 =?us-ascii?Q?+H1Z9Hr32X8Cd07OuAAXGCC++uNKZaaGLzdpF+gyugkO8f679EMLH8Rl5PN7?=
 =?us-ascii?Q?93ZhmGOR21FGNPofXxI8SVTLBUHOy30czNVxfo0TkhY/JV3bhXf5zZYK9qRq?=
 =?us-ascii?Q?iTdoGG8bLEEXrYpC4VbgnsV76n56RCv5RtWrHY8ZzjJdyX5U/eVJiBpLVfdj?=
 =?us-ascii?Q?Va90bijAScAa6xlzHqQltTqMQmCuM4MowqTN0/WJ5+FsyB81UCRNWIsB6C6O?=
 =?us-ascii?Q?FVVAq4abIaGXyKPW5hnIIx6O/E92HmZ7aJIj/+68hvcIxsPWOk7TNfl2bTGE?=
 =?us-ascii?Q?nTlbXBmKkTpzUAk6oPq2mjzVy23khhq5Wb4ES/SjPRkHFdenSumTa30ucUjg?=
 =?us-ascii?Q?dzO0FppUEuC0S4u6DedfZL2qbH+J45ksYxVxIH5/PfOAu4y3iWFXGjObEC2/?=
 =?us-ascii?Q?7108DmwNneqaVwsGPtdvXwSpKTVOeIE7TLGZuFJ4CaT5zf1x10ufahayJDzZ?=
 =?us-ascii?Q?7AKUNwc+BS7eNDlJu3cTovoFr0a5yrR+kP8gqFpkANvSka5wso72puqHPkar?=
 =?us-ascii?Q?nN1iA0jv5JHvaAINB0QFlbPAiDLs36HZnnAhdP+T6alDuEVWAlnrMmPEDzHt?=
 =?us-ascii?Q?G6fNH1pz1e554w8zBtDMDe/rwAPofZJKAJSOw0984EE04c47U+njaChx0q38?=
 =?us-ascii?Q?KgTs9JAfGs94QjkQ8pu13EIDSeuaXxkR0p6MDoWZ7v1Oq5GoRnMvEC1AT+Ou?=
 =?us-ascii?Q?kM5sFuJPwZ5ITZ2t7AMd1TZCZYVfGBlJUjgRxvUT7bBihwC8ASkvfHQEMvTN?=
 =?us-ascii?Q?accezW6jKhxnD0sMQkSr2VnYqlBAxrA7PEFXf4OgXVo8L0Je1xw4UZEK2Kl3?=
 =?us-ascii?Q?HbXgFQ34WUaimMCFusrmALhsxXTuZz+08F4cbc91uAYCbdXfsax6N6qUKoTN?=
 =?us-ascii?Q?rsKHly286v7wqQ/yS7uaG3198bcheihwhA36LJU09vxqLKzvS9eGqWNb7xl8?=
 =?us-ascii?Q?PEPF7qA9IMRdqxKy+Lj5FaDkm6NHBiTCDG9o2QEStnaKcHby2w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 10:41:51.8340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661a38b3-3bdd-4201-bde8-08dc91159895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
Received-SPF: permerror client-ip=2a01:111:f403:2414::625;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

boot-mode property sets user values into BOOT_MODE register, on hardware
these are derived from board switches.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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


