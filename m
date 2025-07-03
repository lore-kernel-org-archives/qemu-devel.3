Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED788C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXL9k-0003Hc-Jr; Thu, 03 Jul 2025 10:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXL9i-0003Gt-UU; Thu, 03 Jul 2025 10:43:18 -0400
Received: from mail-bn8nam11on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60a]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXL9c-0004DF-8T; Thu, 03 Jul 2025 10:43:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJQb4jZZc2jmfLaopij3UMB2VyXT0vgNZEl6JwxYVjhw5471hQzQ2jpvYIhp/7y1nmfT73xrCy/JjVTUfS2rpsXN+EYmD3OrlIwsgw1B4+6aFBDCw3BKE4sdhJon9trdAhm/NpIBGVRhShSaTMvfpVo/OEzsdcKIc3mkWu7xDrMYzE00BARUBfpjbAjXSUdRt9KoPq73NI7ay9rgNNf5h8e+nhdY4qgRO8nbOk23cX3M1xcvYYhuMKQ6smDhGom87aZAjsADuXXnXVnpaKASwHhw+lHp8fAVUDJ5YlQahw3Zlcdv5bvlFH1YyNMoVunvNU/OiJCCHj2K3zje3UJr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RMFeR/nU6PmGaeCB9106GiwyXanoBm7GEcsoPR1Xt4=;
 b=y3ubbPuh31UkcBQUhCyVlrPEwO9ccKPC24BJsHvv41wBsL2hWvZhmyrfDjMIs5SAIsSWFzryrao89F3WDXaIh07z7iK1NCZk+7B2Vl7tyFwDdFXLhk11RCGO2RBQvPxhb3K4V89nJKpYVqSiJpG1PKAQPZClpEW9TmKeHbbST1w0w2chf4d6SPDLhDOh5jsgQbDc4Dj/YyCbLUrjXhBP8BLFhCoetp+DT5R3tKahaCH/MQpW/PVryOQhDzo09Qz0pe4sXTxwC76rIWCKwvcfETAH5EaMV98Z7o4S50Gjmjn8UKf5cQVEqdCmCzojIPZWKHQd8y20PuFZeWTmztMUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RMFeR/nU6PmGaeCB9106GiwyXanoBm7GEcsoPR1Xt4=;
 b=C0SYTAcvNe6VFhkwVdawhCmGrmXYplTBVtII1fkeO9j7zASorHX9xdk6synMaIoQQaD1LKot+kb00cS/9GjEcsWNvA2SvF2UWSUgXR2Up07WHGpits88ywpeZNo9FVXtsvXBk5gdPVijeaGFH7mOuSUMtXKG790Bg3hH1dNy6XOltlRmh4H2qOL7stcrtTJds6S9OD+HBXE8nI84tyEgquMRrp0Y7hJQgZdh7GoTM6+GSYCAuUo1YXNN4peHvnFRHmACdBBxkBSUbpJpS6xQgR0MgCaoAdMcN69nVFvUAcQeKRoXz7kt+ctqc/2Tfy61BNjVVCj9ewgV9zL7yTTW7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 14:43:01 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 14:43:00 +0000
From: Ed Tanous <etanous@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ed Tanous <etanous@nvidia.com>
Subject: [PATCH v2 3/4] hw/arm/aspeed: Add GB200 BMC target
Date: Thu,  3 Jul 2025 07:42:48 -0700
Message-ID: <20250703144249.3348879-4-etanous@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703144249.3348879-1-etanous@nvidia.com>
References: <20250703144249.3348879-1-etanous@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: bb59d04c-d9c7-4964-6409-08ddba3fe8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hqPCA8NynUzBWtS9/LuVSE/gEhJrA+TljoH9veYUrVhwy4xtzdYRFvxTA8wj?=
 =?us-ascii?Q?a+ZAttvJ1Jn0hT60a3/W1jvnvh4kLgO5FOJIGw6GU02/gzN1uUzy4rzhNNhN?=
 =?us-ascii?Q?z3LSsOEwjAzUDiZjMvARkLjHGvJwWR3TPG1SFN2W8coI0xVLvt6kXj8OWfPi?=
 =?us-ascii?Q?kJ0TTGqPPYTtw0zZ/uejaA/9SRNgIv8Q2W2YUZ6i6qWYkNCiqcB/PmCrR12X?=
 =?us-ascii?Q?75yWQ1voyt4MeSE/GXc4flClrDxgzvmjJ+FMMx4+dGh5x3yrk9ufkLcTPCq6?=
 =?us-ascii?Q?u+VQi6ARSj8lhSMLWkR/MlCH8RXwtmVfTyp6muhXBRfIBjEjKsZeuoDknRYh?=
 =?us-ascii?Q?KZCJAvw8mipIzDOqyBNDlC007OZQwD1J87sDo9iPg++vwjetQqf9WOIEpQjq?=
 =?us-ascii?Q?d9ktODqvm6BcIWh+NTs7twGiiAk11xIDxxMJ9eP8y6yRv5N6psPa4BFU7y/a?=
 =?us-ascii?Q?2jg1X//T1TPV0YGefK8p/vBdpCFT4Es4KtQmF09kNdD0ESzYlRo3EJWNwJxT?=
 =?us-ascii?Q?xaDJLtykk7K2r1aPQothjZpqaspdS+ozAiWXsAxjiXByFxAFyTDqVcuCmEw2?=
 =?us-ascii?Q?mXPfZ7N+/lv4EaXR49XmKg9D3ucRw2UZ1P84f2KIc/Cta0CnNqwEDhhPuklk?=
 =?us-ascii?Q?ifRr8mBqWmHfogdmonm6GiK4JrFJdbaYczKPUa28w83oc3PL3Sf/BUjqh9ss?=
 =?us-ascii?Q?0K/zChGKbJ+XDCsSeq7uhWnKXFVCyx1IywJNxXwHKugZo+2xhdYgbVoyZdwy?=
 =?us-ascii?Q?3MDAHU9AIozXy7BXN9y/S6qlGVOaM3zOLlH9R7N1gG3wVjTGgzqCEhgLTUS+?=
 =?us-ascii?Q?1mz3DHFzvn61T/KuFbQ6thMY69JiAiGQe1aPzzbGyCopi9xD57UnoK/5yZZp?=
 =?us-ascii?Q?TV/QrZsHBLV3wM5o1djXF/He23cwY+Zvcuqjj9a4ZweGvZ4O0DCR+ZU4eEMH?=
 =?us-ascii?Q?LL1+pH9OEM/S+e8rpYxBong92g1fm53R0PWGffGLcT1jh4q8RaQljJ4lej8T?=
 =?us-ascii?Q?GNpMUQKBZ2J8k0pucwGAmlO1ZK3BMgxkfqO+7Wza7TgguVEJKqmc+Cr6Cl4r?=
 =?us-ascii?Q?ro1lVfY/F+Zndw/J12BXaSrYpWvCFdwncvit06Ghip+ijo6ZlwBefwC/rGze?=
 =?us-ascii?Q?o0UqggeMuW5hnjewtP141rN0/SOfEUdRJesSDpW/haEtfwnjCwiq+dejvROC?=
 =?us-ascii?Q?bks52hIpP+H599pgh9NIr/nlxBJNvoo3bSU0vh5B8FDbsK3U6wSvjkq2O7s7?=
 =?us-ascii?Q?UozEASJoqZmsXZKDwR1Kp4xrVW6abOZOZ09+TY/ztOtReRE2NeYa8pDM57jO?=
 =?us-ascii?Q?3uyhjtbzOFw1si6muLMoWZyGaEI6yAMnvdU9ty5Efy2Fs046y8eAf8ThIbiM?=
 =?us-ascii?Q?2Ui3dhfLAUAu07ttGmaOQGHB3HoAI0UsIowHO7KQx48FdGP+42D0cogQT3pt?=
 =?us-ascii?Q?ik30y4iIVFA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zi0Uh4My21WG+a8Woyth81OaRJFvDc4oZWeqtPIPxUfaRNrRVhV6vgIHlq31?=
 =?us-ascii?Q?GIZC2u70HYFUbx90HeJtQTOQoNPsMX2crf450EAr9515gyTuRDnRw/vRavkG?=
 =?us-ascii?Q?NiS3KuVv6RUp3yxcGeszRtwskjsvFiFBhaJxVxMsBZ3vg4utVNsmN9s1JHbw?=
 =?us-ascii?Q?NsDKIzv2PjHiDuuP/KsCfPwAVFeSmdzpDQbzAk0WCfjH9Y/uyBNkYnzCjYxN?=
 =?us-ascii?Q?FifxNjoKn5rt8cwK2XVkMZiBs5gg22TW1+xLJWtcW3C+jT+Jvg9GJrQXtBD0?=
 =?us-ascii?Q?a+d0NnR1aEHTrd/u09+f2uqhLCz2FKPsQ3qncF2hbXpBc3pJPvPOseeW7U9t?=
 =?us-ascii?Q?/3tTsPfmhCTr9ocHh1PneQcYBSRz4HGOibtp/QPJM9J1KDf17E9lMZLSGdBy?=
 =?us-ascii?Q?vTQdHaORd1c86fA8/7Aa9JL1AsTVAbJIQQiQyG9d3HIO2xGeZbI2oyKewOZP?=
 =?us-ascii?Q?aYsngoc4EZKv9OdQTgQYeYII42MDEkUrzedFGhWxEU0YUfyeIq76rhc2Icbi?=
 =?us-ascii?Q?hnkphQlgF8aPCz3KBpd7dczuxZ0ljqN34E2RQSCfCZP/1XcosbvBC2hTzmxX?=
 =?us-ascii?Q?IvuGLLucUaW54Wf6/hiVQgKcq9lBRlEZEkyfYsA+ZJhGx0KAntCAzrzxOi/j?=
 =?us-ascii?Q?bU+4OpEgThyy/PK9OxGXut+sRHI8PFv18FisVEZLCRSVvbOR4TFXT2/eqXK6?=
 =?us-ascii?Q?Lp0qudAfiin1EwUQZUOsUHu6831K6cOfDec3lttKY5cTabfyDtfZIzlJwkAc?=
 =?us-ascii?Q?rQYgqCuHEJpSsEIGzUV5HkLyqjI8cxd7AfrVQ/6v7TAUy05SQ2PdjL4qic9W?=
 =?us-ascii?Q?SzrZCMiNAQu+CQChdHdwHr78GfDfdIxQwcCHB+fUKbaTEY/wbV0EPBkVXpK6?=
 =?us-ascii?Q?33Hadnie7iUNDxz4URpoaO3b01XgQV84BWGCoZEF/q3HmZ45mfrHxzMAXXWA?=
 =?us-ascii?Q?5XEJC9KlKr8MURp4Q/nkxA/f7raJ+FiodYdq/cAoyXXj6jIevToRvW79Skta?=
 =?us-ascii?Q?J76ocvh9baHrr1coHmS8TA9AKe7c1OJ8KKPjWD1Z3Y/ZN8DOofe6KLWhH6ai?=
 =?us-ascii?Q?Cex4LfBsRQN/ylk/fVVFrep+YwhGvtG/hOyrbwvm+Yy5nm5vbcTNy1bCgHdM?=
 =?us-ascii?Q?7KRnPQPi5T5NID2gsW4zkEJbwo/7Q+GdqkIzoHLAdB9IQrknn7v3ZAqtzYZD?=
 =?us-ascii?Q?DhdXQIHqZv4oJ37nMNhuyG82Mw+zypQNfbhXMNjDiEPemj8qEe3xiLv7yR35?=
 =?us-ascii?Q?iGEClpFGCQyvWqxArTv5yNNtD144yxHo0H2d+3Mo4Jw1psF9rYzp6AAxgnLS?=
 =?us-ascii?Q?inSkN6VjVToVQrH9RxpfhVQ4y6jD1pjXlAKf8v+nlUWa3xFs0/m2c6CMrBBd?=
 =?us-ascii?Q?nX/IQzk7J6toxqGmtaW0Xbj9NJSeFzVmlTkg2+bkJmE+gnHTN6vTBdWHRAxF?=
 =?us-ascii?Q?2ZNymXujPiJ6tCesy+TyRGf6I54msMnuraz3l/9mbqyeKES8QDukwZf2iQoO?=
 =?us-ascii?Q?7uW9B8C4P5Mfr8hyjJvxRC0V0WqhqXGWAlqqYMGmKPsGAKaC6ZcD2G61Hqla?=
 =?us-ascii?Q?QeaIly3ObNyK1Vj/qgPxNcawYYAW+D1Pi2d6Wr52?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb59d04c-d9c7-4964-6409-08ddba3fe8bc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:43:00.9035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87f8HBmOMK+8UelxFm2ro9jaXazJDHBAjtsmVXLn+rVWCkfHfHQxPCNOe+9oeiqHLy6aDZB9z5C9iYcKl9ST3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
Received-SPF: permerror client-ip=2a01:111:f403:2414::60a;
 envelope-from=etanous@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

This is based on the device tree aspeed-bmc-nvidia-gb200nvl-bmc.dts
from:

[1] https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts

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


