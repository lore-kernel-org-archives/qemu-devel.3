Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEAEC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdrX-00011A-84; Fri, 21 Jun 2024 08:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKdrU-0000zw-U4; Fri, 21 Jun 2024 08:59:29 -0400
Received: from mail-bn8nam11on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2414::615]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKdrS-00011K-ES; Fri, 21 Jun 2024 08:59:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RavxIA3qFGHGKTGoLNErWwYJAr33KrSrQi4/CbYxWtvBaemf51BUc8hsC9aO2fh2UapQyDE9Wb3okEetQjoMYGTzKFc9zz0T9XTOn3aNsa7w8YvhZnOiCZstGjwodbKtE8NCVIBPo9dtjMiEVevBLumnW5T/1gqv6FUiw0CP4HliaZdn030IVT/RSkTITklRlnDR0wgyZGfVU2Nf2rnmPPi+xq+vumOzbGLTwXpvyodYMyHqFcm7a3WboC0v/5xZf4HRmybFHKPz2D/XuKnGJdUEataju+PacXUFpMNaISF50L0ZdR78tsysX5GHvPctN2z/QC6fiszbx+DgwG9Y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph4643cO025ca9eUYz9ivbIwo7EqfTmIm6Q+4fA0p8A=;
 b=GqMzNwWIN+uDnOk1GB7gL6O+rBAVaDh3tDv3S2jl3QUvWkOdkw7Yc3XZm8Nctj7CcCOLxea56ew0qJD2Vv8CLdMgqJYcPV8ZAZ9EOQB4hqszANpQ2KnfZ36zRcrhOokqZuZsweVxVxakm+epFNuhMPO3yIbSO8XQfOtMzvaPV5bbjArRi83UW7UtdMtz00Gh19Z3lBY+ejSk3WvnXkyuZDcW1m/nEHCsTbVwVvU2vHtxlkZiYIeFeSXPlKhi5UwVBjOcHAjk3k5w1J3Bdc9M4SBTR72eDXx2h1X/bOpPjf9PyIMCv+2trP5dYFGMWKhTHU1pXVh6F75jmX9w8FufJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph4643cO025ca9eUYz9ivbIwo7EqfTmIm6Q+4fA0p8A=;
 b=OJXcDcVGGpZeSGAG6BuYIyCgSbJCqs2iZFG4YuSkVdXlPASvDV8pFFW1LJ8qYO9VEglG2OTFTu7CO2WOKnWA8OI9Q2S2jVZzIret6N7ZYdFy9YhepCVd5Foz5vzs0k1o1ENp/PpiP6zzhDjyIZ/SqgnaAGLQ8hnpbTc9maUswG0=
Received: from CH2PR02CA0027.namprd02.prod.outlook.com (2603:10b6:610:4e::37)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 12:59:21 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::92) by CH2PR02CA0027.outlook.office365.com
 (2603:10b6:610:4e::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 12:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 12:59:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 07:59:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 07:59:19 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 21 Jun 2024 07:59:17 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>,
 <sai.pavan.boddu@amd.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v4 1/3] hw/misc/zynq_slcr: Add boot-mode property
Date: Fri, 21 Jun 2024 18:29:04 +0530
Message-ID: <20240621125906.1300995-2-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621125906.1300995-1-sai.pavan.boddu@amd.com>
References: <20240621125906.1300995-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: c052f004-7ccc-46b5-ebad-08dc91f1f7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|36860700010|1800799021|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3G9CSf9+n7ffGXgRq6P6MQYPlC31bOvnrMecGQ1c45N1/f1ytfWXbVUiThTH?=
 =?us-ascii?Q?MxEaAfN0qQN7WRgMIkWOjA2YtYAHOFJrOKw3KzaAuZaWXse7rEIziN0tHBgs?=
 =?us-ascii?Q?Fgf/xv5SthHfquVilBnoENsHXeEtyyg93bfrRg1ef0b4V898YMH6e6RB7lrS?=
 =?us-ascii?Q?lIz+VO2Lwouq5CWnjtraKd67OH0VhgzVo7PQT6VXazf/UZqMEJV+2f/2wRHp?=
 =?us-ascii?Q?NXZW54ztaCG3Y3QQTqXkZAjUqxanhcyiO/k0L4BhhxGbTlnfA4xXBfwG9gYy?=
 =?us-ascii?Q?7Kwq0DKGvq9NbpAad6nSFtZIGtUpjI8k7gXBuIhLuCVd1eNrApzfThlLF5SE?=
 =?us-ascii?Q?AbBdzlhIDKgzwX4SZE8ND9vEMpZx1nBolhYPOYmbUZ56vH0Qw2gpdSACuJoS?=
 =?us-ascii?Q?mvGQYOnqWZlwMSF+fJBKtS1nh8yKfj3x7D6QCky+hvDLZNSa8LNMqS7RbOGj?=
 =?us-ascii?Q?LVVl6CthuvOhBVJU+G2KDnHwCXbVVN7V72nsiBIlz6SpzE25fJNe4hhGokAo?=
 =?us-ascii?Q?q+i38z1lbzmQCjsQImU5050vGQNYdQiJ86dAblKIRfVqAOkzEILt5LF2ViDF?=
 =?us-ascii?Q?PgIuOdhtWuzeEqxSWuxvGxUTTzzlPAGzPTaa89qlfPCKfjfP1CU7fG2b/qFZ?=
 =?us-ascii?Q?3j27OludwIMQbnYa65BWmN/1yg42vkgGKxqXDTDgkN4AaVM7Jd9Wc11N7OU9?=
 =?us-ascii?Q?/7ydfgcqZgmlcNPtr9p35gQJ3nS0qCaH4v73bL70AatnggSwb9jzW6qgLCrP?=
 =?us-ascii?Q?6I1GiCtRS7Lk4OGbATmnBxPGqdcWW/MP6Rl9NG/ndwxFT6tXsOjpX2Dyq6mF?=
 =?us-ascii?Q?mrf66D+TP5/TUa+RxDtAlLrULhRdJ3SKMof4dJHU+Kwvy86nvxB34kB9usBg?=
 =?us-ascii?Q?DfItowdcu+NnwMtC8o6s0Ihe3aSLb/PT5vLYKU6uTomfjsCTjI226tw5rubV?=
 =?us-ascii?Q?o1OlRwkO+0pdJ5FUAmzMa2gXY+NhZVAL+d7l3MMth1JOA5y/K40oz1Ql3Y6+?=
 =?us-ascii?Q?a2B7JhAqI0QaSD78aiDDa2ax1c/QP25wCbmZVY6iyi47qUDi7YpdMheiAlRx?=
 =?us-ascii?Q?yyExPZjqJ6yw0XxCskYI+udNT1s4rmW0BxM0bm8HQkyvPBY/MPW7QkauooBk?=
 =?us-ascii?Q?v1fYFQOr6yB99PARTLKhH2wYhNBX8Tf9WyzXh1FePihf6QcIR+Ksajj5MtJK?=
 =?us-ascii?Q?Mhr0IgzTGRzGlJviAK3yig6Axa+Jo37LXFKTyG36zi339TOjqjthN+mBiJCh?=
 =?us-ascii?Q?bVJmaQZHKwIfCy4g5LHsNR7s69emYlT5nVB46O7Kk6KMKJ/yimIksea6fDQh?=
 =?us-ascii?Q?PBL1wKQ/8/A+CBoVzfSyDS/gh93ZJiuU+HD3rvUedu83R2JI8iK2FoGELUUd?=
 =?us-ascii?Q?7G5b6AsbJ33XY7BOpJzrAS6NEWFOT1RoCBLIFEVGAxdjqWi/AQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(36860700010)(1800799021)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:59:20.3576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c052f004-7ccc-46b5-ebad-08dc91f1f7bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206
Received-SPF: permerror client-ip=2a01:111:f403:2414::615;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

boot-mode property sets user values into BOOT_MODE register, on hardware
these are derived from board switches.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
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


