Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DC2C83F03
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 20:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWhgM-0002CN-0L; Tue, 01 Jul 2025 16:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgK-0002BX-FL; Tue, 01 Jul 2025 16:34:20 -0400
Received: from mail-bn7nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2009::606]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgI-0000h4-DH; Tue, 01 Jul 2025 16:34:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1cVvuE4RpYNJCNJ6Wqe0Cj5M8B/c592b+fkmO+eo+eL/2NW9BrF4APYWAWd6/aJ6er2bNCFHvWX6v/7V0uM45v+8E3hozfUV/vTnUMGwvLqZEN01114zlMPlX02NtasELER1ZRiE8yvl0WkIAzbxVCicNBKcVCkzJnTsOFRUNhb2S9NYOx9uPthFWQYpsfdE+2Z43AIE08JDOqXwSfLtNcmgGOrDcWsyiSGyA0/h0Fzy/C4xAEaqBm3iVsutAtPHyLaHwRc3HAfKNPxVPy81q1icYDCWVJN9804xzE32nSlm0rDMNEaWF7bwP3dWyuFFpz2XcI+ckkq2yqHIYCjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M0HHKyNOoKgs8j9u3/v1T3ayN2/DHjAmNq9kRSpQRg=;
 b=iWc+dJnfMP9DAytc3NL1YaMmgUPGr+lsn8xcjK10zuwz9WrwvggqzAzjoV68OuVWOBPkPUNQJ22rpEOmJuss7V6bUfYD70YeR1nBXjdsIUqyy2NypavjijeK4XcV+Gve/XCxenLTl/fc7I5y15AFXH+hZ41dH+p1Ra1b/UzGB7r9aZ6dLvndgJ9P3fox313mlkDUIVEhfV0VV/4MH6qT+n6eMFVsaOvd14+vyo/XzJZKhlbKg63JUO/2d/NtISVv6NQeE2vb9iCMWIs6CPWl0aYQe+m8/iyFUZLzt9gPV9pEbiqp9xGu16G/N6j1rMorvkEMCH/rmchJIPkrlFDh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M0HHKyNOoKgs8j9u3/v1T3ayN2/DHjAmNq9kRSpQRg=;
 b=ZPvH5SP51EvMdqkVqSHYhrnEA4WJAexDr6VJ6LxbbR41zVSjUwOh3nJ1EVC0kUD0iU92cCBnnTfEu6k9d5SXNsjLKQUuagNJtXGDZAsJqr8eXT61kWGBvZAW3L8F3P8pWv8hPcr8YQh2pqJnnHE21YScGflP4AAf2uKtwMruWqEXKGgiYRZFjFxtxh0/gFeyWGe53yyE7bAMVZhI8N1qVCxBBkS52OKxtB1U7n0Ef48/m6V7ud5Y76pZWHbAJj9TXsoE80Wf9cYj/SEF0MSaSWhBgu8pBI56ohfhXJKO0jC0wC+nmtCTPdrwO/UKECfKjAo/7VghIXyQq7Tc6akv9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 20:34:08 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 20:34:08 +0000
From: Ed Tanous <etanous@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Ed Tanous <etanous@nvidia.com>
Subject: [PATCH 4/4] hw/arm/aspeed: Add GB200 BMC target
Date: Tue,  1 Jul 2025 13:34:00 -0700
Message-ID: <20250701203400.71677-5-etanous@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701203400.71677-1-etanous@nvidia.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::21) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: dded34e5-243a-478e-4443-08ddb8dea149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kmdi2owb8i+z/PGGQycoc9TI0TG8SVZGkQhSIuGsnK2+suDFFsAR6DME+/ci?=
 =?us-ascii?Q?vbrsisgcz3SVclRBSXsk8AWgVk1ND8VUUawbgfoVb3U+PivR+IayZ1KV0kfx?=
 =?us-ascii?Q?nUiHFgJtYIMHm8IgkPWJ/VHRsSvtgpR7KHetGFuE95NRZL8uTGxcqFTKFubv?=
 =?us-ascii?Q?/5bj9EkCWWz3yAokLBU6wByw9W0QYuZMaDAK81433ambniaksoeZHP8sDq/k?=
 =?us-ascii?Q?oZPfGwEQID+vxYJKrg5eJk4fi8E7/5xvZjAeyezr5zEfN0jw1infR2NVrs+z?=
 =?us-ascii?Q?IdMKqaYJXAlugmMTfgnODEjXRJDW4+d9yQAZoB1V8WP04e963VpMq9E8NaO8?=
 =?us-ascii?Q?RhAW7IDMRKg4YrS4hA0MRRJicFoT3t3o+4f6DOiHuWIq6g8obGYbx8M1eG7j?=
 =?us-ascii?Q?NUVnzEUFJflOp5TvF/oKTUBP+ZNqlW0Av2U2b1pUHMfuFGZgC2AOMGtIFuuc?=
 =?us-ascii?Q?CkQbJUw9l3Re7BMaPHey48D1PrnRQbfvo/jHV++kbE9LYAOUUXaVC0LklElG?=
 =?us-ascii?Q?Z9aOy4hjTBsxMEiL+GQFMV12xzEei95P9VsGqwYTUIvfSpYgbMtPRbjpAwh6?=
 =?us-ascii?Q?LJyloc+l3//v2d8XHQmj2hghcuCPtuqHuzSnSaGtV90yU2p3onzOy3ZmL56L?=
 =?us-ascii?Q?e/Rd1gb3XLUtxPK1su5dLbvoTGV6U2vYQV/GDAcAtXqtG5mdFHk3kyke4ZN7?=
 =?us-ascii?Q?CTyKmUN54lfvYfHtTNvMmKnXVAHPLmETOXQdwS0t83RYW3PMdBY9lYvzPLzj?=
 =?us-ascii?Q?8E2/wwRxv25Ju4CrGBJeJKzcgrdZOoLuRVtl8ZK4wGTc9Uh5Gp9wELSNVTJg?=
 =?us-ascii?Q?sqFYRzL5+7VWL/rFVOf89F0nRSYF2mxtkKVfbiWxl61CJ1+Z55j27b91ZYNG?=
 =?us-ascii?Q?GVG1ST+J3JhAbfgVGPxKjSZ4SazwU9b2C5WXUpAnHBuvdWdSlREM20usoFY2?=
 =?us-ascii?Q?dG/Sbg6o4MDoFTyZOTdRZzyfzohaWld3Kj4ZT7oFMWULT93Jc/0Lto6WzAnd?=
 =?us-ascii?Q?vFPmHck8ZVtw8CdEIqU6iFjX6XqbniN/aFrE/PMC42xoLLkMh6omGCrRsjrs?=
 =?us-ascii?Q?kUrA7Xouz0wWHOqvE7sFEa7bcNo1oPHNBNVi6r01XnqlTlFe59aDFTPgKY+x?=
 =?us-ascii?Q?4BK6HQfNsAwV4FdMrKviYU16dN5zbzWJAGNN1SojdBUzV2SGksmBeMc1ztQI?=
 =?us-ascii?Q?+vk3wPUErPYSk6b6FwPIEc+xOCr6xY2mVlaRwI84UH/8ZKH9DeeZl8KhCbCP?=
 =?us-ascii?Q?xCHJr8pnIQebEZ8aRSxki1awSef9UZupt6O7E3z33U1m313Jri1+371rVroV?=
 =?us-ascii?Q?cmpOnAcy6DMLqIYwSvsdtinMrqM/gmIucgdtwWRU/Egm5zkQygIo1Up7rN3E?=
 =?us-ascii?Q?A+iIM1wIqd0ClaJ8O8ugSyFzee0ANhSIEzXx1Cf2w/QxrK7vWZpePA2Xb6t8?=
 =?us-ascii?Q?4iy89xhG1sY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hBabnvCxIPSe7eJPxhn+7Ymjrsb37k299+BQdx/rrUXJEcJ26xugQP3KnoX?=
 =?us-ascii?Q?q0pu+cXarQ4xxXU8RFNWYgtTptQJjqCMJEEQNSBEexMck9nOKoQdnudXEROd?=
 =?us-ascii?Q?VDF1uO2mGY7F6SW1HGpEWwnuhtfZHS+DAbvVscw/lfg0ZsWVacHwahliEQv5?=
 =?us-ascii?Q?O4aI9T1yrajhmYMBP64hBBpZLbYPMVFuV3oErXuYho22iX3fgMdUuHvTn9lc?=
 =?us-ascii?Q?BW/1cB1xUGWilpqzc1QtlhAMuxycrY0zo26ZKZ11vFPcVNsFAH3DkcQn7Ryr?=
 =?us-ascii?Q?aNTnBRVu+a4MXU0alLvooLq194ftkw2kRcrYs9LnLbP2J1pTstaAhg/fINEr?=
 =?us-ascii?Q?GnGngDrJJl6txGA33Lvtp+D+zYQPMxASPOphjjYZs2avAO0qmy81OCJz7uUt?=
 =?us-ascii?Q?VexTE1S3lA+T1OS1YHihMerpjafI+Sp62A0PhBf1ls+9RoHVGndnSeB7jhp4?=
 =?us-ascii?Q?u99SRHgcARrbTG1F2jH/mTcpwO7yo6mFSN0ApxDyAFZECsuv+JqnxqkWcCWG?=
 =?us-ascii?Q?s4aW4HdDRrpoCCBuc+hsm4vjY9vJsldH9eMu1AWR+6CIbR2510apzJKD78Vd?=
 =?us-ascii?Q?zKFurxzWALxZ1ZoIVzNXpL4ZJ3fTryGwhPHAQviTXkklb9tcUj2eqNEvaVRx?=
 =?us-ascii?Q?sav4APxaFQzLKbVDgLBTEolSEdnP0QB4WdnEhO5txgxqoK8XrLx0jfR8gGhZ?=
 =?us-ascii?Q?1E2YKpHQNuc8M+WYDmzxlqk6A97usmlE8qwXyY+fgSQKGFgq0fA25abVSY9y?=
 =?us-ascii?Q?vmvby+hP+q881JGtQS9WqhI1OtUDWMiVJ/suQEw3a+0QougQbu9u+MVwNBCH?=
 =?us-ascii?Q?d2352DO+aqCkAd2cMG1eY2Y7yVeRO7PwFjfh2X4ZXkr1wPjw3HaptQ18Zrp3?=
 =?us-ascii?Q?KLlYCiGlrcE97qFMgsbryuYtV2rd0stlh4h/Oy/oPo5wyK64zBNHfmIK6SSY?=
 =?us-ascii?Q?Pb4P6z07Clnh9JNz3TSPQ0wXjxm1irM9gv9QMbBQ1hE38pdr40cG9faHYh/J?=
 =?us-ascii?Q?arsfPYjC6fFyxRCmT2/6fFPWVers6CR7w80urqNooLykk4alqP4tAEUUUxDS?=
 =?us-ascii?Q?fFX5aEtJvJzqrnij1yTzaloO9uk27R/+///OmyPG0ULYLUkdpo2Bf0oPgNfH?=
 =?us-ascii?Q?3MOpxbIZhflO7xn/Frt3gJ2u1SjmC9ebZgdH3O15+suKHCMchHO6x6s4bl0X?=
 =?us-ascii?Q?mmnQuQ+lGhXXZ730EkhiR3+cGb7YMbVYF2KDDgbByPyeTUiiK1N2cdVgogeN?=
 =?us-ascii?Q?cS6EXk5V8LDXGcC+8/pxzNuMHKrVKP6DakaUrrkfCvE68abFummvbMv7gndT?=
 =?us-ascii?Q?Dq8aScIO/z3OmkmjpuYtU95Ur3EZq+ApaiByXs+4OP8u6z9ZUCVkF4Cby2NT?=
 =?us-ascii?Q?DxLKpwVa29qtX15u8oH9gF4UvJnTY3sC2wyQhUu72krTyWOk/iik35KJXG8D?=
 =?us-ascii?Q?sH+pyMNbRdK8gkN5SDeQVWDabwGaf3awlHbyr9OEpfOaKb41mDm1E5PoyaVg?=
 =?us-ascii?Q?zgaFqJdkOlf3UkVP+jilfrA9AzK0breFew2mQSL5QYeMYFLI2HtBpzSQFj1q?=
 =?us-ascii?Q?x8SotJqcealOoe2ednyxMzDEx4fzsKPNJaff2caq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dded34e5-243a-478e-4443-08ddb8dea149
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:34:08.6359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrtBJ8dEQDULETMPnI3TIrT6Outq+BYGJrxfkyRtsmwvGe4iGSp0Fv4J9mIQu/KSO6pqRZUvEVaClbPlpTtE3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27
Received-SPF: permerror client-ip=2a01:111:f403:2009::606;
 envelope-from=etanous@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

GB200nvl72 is a system for for accelerated compute.  This is a model for
the BMC target within the system.

Signed-off-by: Ed Tanous <etanous@nvidia.com>
---
 hw/arm/aspeed.c        | 79 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/aspeed_eeprom.c | 21 +++++++++++
 hw/arm/aspeed_eeprom.h |  3 ++
 3 files changed, 103 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 3ef7f6c5b2..98144ced86 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -19,6 +19,7 @@
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/gpio/pca9552.h"
+#include "hw/gpio/pca9554.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/sensor/tmp105.h"
 #include "hw/misc/led.h"
@@ -201,6 +202,10 @@ struct AspeedMachineState {
 #define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
 #define BLETCHLEY_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
 
+/* GB200NVL hardware value */
+#define GB200NVL_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
+#define GB200NVL_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
+
 /* Qualcomm DC-SCM hardware value */
 #define QCOM_DC_SCM_V1_BMC_HW_STRAP1  0x00000000
 #define QCOM_DC_SCM_V1_BMC_HW_STRAP2  0x00000041
@@ -647,6 +652,12 @@ static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
                             TYPE_PCA9552, addr);
 }
 
+static I2CSlave *create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
+{
+    return i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
+                            TYPE_PCA9554, addr);
+}
+
 static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1052,6 +1063,45 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
 }
 
+
+static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[15] = {};
+    DeviceState *dev;
+    for (int i = 0; i < sizeof(i2c) / sizeof(i2c[0]); i++) {
+        if ((i == 11) || (i == 12) || (i == 13)) {
+            continue;
+        }
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* Bus 5 Expander */
+    create_pca9554(soc, 4, 0x21);
+
+    /* Mux I2c Expanders */
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x72);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x73);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x75);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x76);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
+
+    /* Bus 10 */
+    dev = DEVICE(create_pca9554(soc, 9, 0x20));
+
+    /* Set FPGA_READY */
+    object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
+
+    create_pca9554(soc, 9, 0x21);
+    at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
+    at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
+
+    /* Bus 11 */
+    at24c_eeprom_init_rom(i2c[10], 0x50, 256, gb200nvl_bmc_fruid,
+                          gb200nvl_bmc_fruid_len);
+}
+
 static void fby35_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1587,6 +1637,31 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
+#define GB200NVL_BMC_RAM_SIZE ASPEED_RAM_SIZE(1 * GiB)
+
+static void aspeed_machine_gb200nvl_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Nvidia GB200NVL BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = GB200NVL_BMC_HW_STRAP1;
+    amc->hw_strap2 = GB200NVL_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66u51235f";
+    amc->spi_model = "mx66u51235f";
+    amc->num_cs    = 2;
+
+    amc->spi2_model = "mx66u51235f";
+    amc->num_cs2   = 1;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
+    amc->i2c_init  = gb200nvl_bmc_i2c_init;
+    mc->default_ram_size = GB200NVL_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+    aspeed_machine_ast2600_class_emmc_init(oc);
+}
+
 static void fby35_reset(MachineState *state, ResetType type)
 {
     AspeedMachineState *bmc = ASPEED_MACHINE(state);
@@ -1879,6 +1954,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_gb200nvl_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
index daa3d329d1..8bbbdec834 100644
--- a/hw/arm/aspeed_eeprom.c
+++ b/hw/arm/aspeed_eeprom.c
@@ -162,6 +162,25 @@ const uint8_t rainier_bmc_fruid[] = {
     0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
+const uint8_t gb200nvl_bmc_fruid[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x1f,
+    0x0f, 0xe6, 0xc6, 0x4e, 0x56, 0x49, 0x44, 0x49, 0x41, 0xc5, 0x50, 0x33,
+    0x38, 0x30, 0x39, 0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38,
+    0x30, 0x30, 0x31, 0x35, 0x30, 0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33,
+    0x38, 0x30, 0x39, 0x2d, 0x30, 0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30,
+    0xc0, 0x01, 0x01, 0xd6, 0x4d, 0x41, 0x43, 0x3a, 0x20, 0x33, 0x43, 0x3a,
+    0x36, 0x44, 0x3a, 0x36, 0x36, 0x3a, 0x31, 0x34, 0x3a, 0x43, 0x38, 0x3a,
+    0x37, 0x41, 0xc1, 0x3b, 0x01, 0x09, 0x19, 0xc6, 0x4e, 0x56, 0x49, 0x44,
+    0x49, 0x41, 0xc9, 0x50, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x42, 0x4d, 0x43,
+    0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x30,
+    0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30, 0xc4, 0x41, 0x45, 0x2e, 0x31,
+    0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38, 0x30, 0x30, 0x31,
+    0x35, 0x30, 0xc0, 0xc4, 0x76, 0x30, 0x2e, 0x31, 0xc1, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0xb4, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+
+};
+
 const size_t tiogapass_bmc_fruid_len = sizeof(tiogapass_bmc_fruid);
 const size_t fby35_nic_fruid_len = sizeof(fby35_nic_fruid);
 const size_t fby35_bb_fruid_len = sizeof(fby35_bb_fruid);
@@ -169,3 +188,5 @@ const size_t fby35_bmc_fruid_len = sizeof(fby35_bmc_fruid);
 const size_t yosemitev2_bmc_fruid_len = sizeof(yosemitev2_bmc_fruid);
 const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
 const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
+const size_t gb200nvl_bmc_fruid_len = sizeof(gb200nvl_bmc_fruid);
+
diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
index f08c16ef50..3ed9bc1d9a 100644
--- a/hw/arm/aspeed_eeprom.h
+++ b/hw/arm/aspeed_eeprom.h
@@ -26,4 +26,7 @@ extern const size_t rainier_bb_fruid_len;
 extern const uint8_t rainier_bmc_fruid[];
 extern const size_t rainier_bmc_fruid_len;
 
+extern const uint8_t gb200nvl_bmc_fruid[];
+extern const size_t gb200nvl_bmc_fruid_len;
+
 #endif
-- 
2.43.0


