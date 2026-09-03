Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2710DC624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25a9-0005Ut-GP; Thu, 03 Sep 2026 07:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25a7-0005To-MX; Thu, 03 Sep 2026 07:26:11 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25a5-0006gK-0M; Thu, 03 Sep 2026 07:26:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpMOWse5/rcTlopzSpVHNLr6zBitJbXknLKYsJV6CTJjEO1vf1/Wri+V9ngn+Gflzm9KUe/OAjBU9boOr40jkFXkQ4QUZhAFQZHCcLUmLLtBsn/r879GfmxK8mO8wAZbrckZtkp7XT+G5BUZVTgtLunTiVG/tnTgyA2StPYGL0l9KNJFOpHQY875LrLCbM9LZuv7BYa/JCAEDz5pSmSoOcYLIIWAcpvshgh6pZhRty7js0RbYu1WHb21JgzU1XuSWa7Oh4RUo7bIU2iyuUkgxg0GJpWLzmoyulYTIDwqN2Wpj4ZpDZK5XHC2QEqwbrmJePq9Oyh/n+16MigyD+mEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX96mZt1R/wbnG4n+EbhSsTnbIITaxhh65tuvEiD1XI=;
 b=qbubApfI2+lB6ZjzJOBSmremGYppviorDbNSupCzDY4ej5ptPliqFiC5UAra1ADB/8ps7N5/7akfjB8M+Ur8sWfwfjv3dWyJMo+hEGldEe0nzHRVg6VT+E3pRNePJYgQxudOiHjDKh9nMCPrdaPF3y/dK5sGLBrmArYHY6lTEB0aWBsh5TX3QRvfhjmOzcX2hSJADH/avVz+qJznJ39YqoMCQWqzn0LHaYNx6tX8+FZWaskECK30kd6gX2HW6y/eNaVr7etOuHTn19tgB5iZuIp0BbyNPow/dPzQ+U5WY98szJbE4vUi3t3vrGxnkEIVY323K9HGFoDeaWhd0Wk7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX96mZt1R/wbnG4n+EbhSsTnbIITaxhh65tuvEiD1XI=;
 b=ABi3aZKAnOzX9szRniW9VD1FFXqnuMmLj0EMuSkAu8WLsfVAUwhV15srIf0seGTRSopQoDSkSKr54tZBswCRwazHzI7kcyB4MwqvNOm67UATHkCda8h0IVqu08ee6oNb80BgvzkShEBAlU5Kejq1A6J/PsO8BtXCk9HeIkVswbkrcmq9jq5y/9d9jZzE9OZmabzAsYrejHFR7DguhrcuKWTwGgBJkmwQNVJ4Q0+jKqkpXaR9eevZWk13JwaBVfJBngT84RtC0Q8EzimlRNsamH1S1k87JoougF5LLJxLLGyrk3QBQop9nANLmbQCHiZjnG47oOCcuEbIYsERk7OeuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:25:55 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:25:55 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 02/33] hw/arm: Add basic Phytium Pi machine
Date: Thu,  3 Sep 2026 19:24:42 +0800
Message-ID: <20260903112532.3276678-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: c63ae4d6-9e0d-47c7-6678-08df09ae1e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6Ik0S8q/johx/09bGvmFuwASZ4HFTmvPRW67XKx8yZkjUjHTxV1BF17ZORBeLlCmDwUzjmErhjNVYDMdo7fQd4+iWMpzTDl5PWTqZuQ2x8u3bhnDUGr/+jRRKZhmLeSwiyx4FqQt5bXV8pUH8tqT4W8/B1DypLJlHFJlmJQodxyyzS1Oh2WWJEKfRFKldQlktaUAxo+gOzTVoRGPQKbjNdboh/zgdLCaYvNzObs8ktkLw4QZ8nqbppMpF5RsPMKnnj9qdCvJX8En6PQZYEuXTJVx33LjK75OjjS1Dr3XUCRCDeKTIqA0bIWx/hYwResKZYRKwIIZAIFr1yAWuP5JOlYvbZ4AHhWwCJfJrXr76jx0y7u22l6FjMICfZTYeZtqPiT5fuhbh0VTDpJDFPnJ7CxG9HmPjOWqi0BSqfOoDYMME6u7ilqLd/oxpftN2Qm4u5Rdw6FayaWqlG+iiMFolF61GbVBGW32jo2GSsZx+jbahD4HHbxrD0kUVxLCxnYg3WOMMa6tTHx/l2z59gApgqArv22z2eROjlgwhWhFOcBnT/ZjRsQLcZvewNpvR9i16PxTyBosi9Sy+TuKJRM4DW9NvT5jJPkzwm2EuBKELVsuBpBFVNxd3ivnAg0ARO3s3k0jdizKzcJyWxv4pxoADpjAsqiCouZ26aznJ5ofQN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9u5/3S7jbp6oeW2LyNiOjkE8GoLZBo3XekidnyweHKWwkDgR8UGJrcYPMHmt?=
 =?us-ascii?Q?eQ23jGUD25fcMG6tucF+tve1nTPXystNv69zYrTsbV6Q6zcn2sMBWhdYsxuN?=
 =?us-ascii?Q?EVT+qdMl5zakMv4XK49gj/HIaTVIBjU4msQGY7D3eiz3NRpWDTeu/CpJLzRr?=
 =?us-ascii?Q?hdCX2/QLWs6v4eSAkka1OqgyRy0fA7WJXIKkvqV343MdIle7nlC/JNaxYu1B?=
 =?us-ascii?Q?Z59WUqCz4AHuEfWXgw6LzN/GRLLT0CkvodVowJ0TVNoCliHCSd4d9o2PATVg?=
 =?us-ascii?Q?QKyBDn3nYDFcBie0+dA9b+40RtLuL8ox5kOctYBNxalt0yjjQsjW+npAa349?=
 =?us-ascii?Q?PoGqrElIi8F0IbJXIgXtrmwK9pDfEKYkmmuag8Ts7q9WgebVGHB3AUKjkN8n?=
 =?us-ascii?Q?+NIT6bs0dP/qEAyi06btsCqYuKtRrvsdKKyaJf95BZJpx2is2UoHNs2zmV9+?=
 =?us-ascii?Q?AOyeqBksELyoVhcWxHRexcXDUtRadkTJ2tLFtSTC3e57VMTo4ooWx6VOtjt3?=
 =?us-ascii?Q?ed1uMlo86x5tsu2Ps5QjFI9dWwFmQZ607ANdBC2Zs+J4A5VGvqWn06rwO+MM?=
 =?us-ascii?Q?hr5NRGu8PgY1G+rGHeEiAZo3PoCZrk2UczzNCvh4OnRvVpUyYkMVkZsUGXcb?=
 =?us-ascii?Q?LNahRNgG7TYhMxNGnJCGIxxO3dkJHnocWr0YOwj9XX6i3bFf6BHTuRzrZ32j?=
 =?us-ascii?Q?LbBQ4kc/R7vrVMZKmxZzIozC9KaxpOx9AclzadYmmNLhY9a3AwQq1RSvNCdS?=
 =?us-ascii?Q?1B+NbTk4EKuKdJWOJSEkOW/FYEX+Pbc+f/nrNiYUvht8319J8irJ5Sdja0L8?=
 =?us-ascii?Q?8KxuNzxH/d+P+YCx1fWFyqnYhnvQbZSvMLyy9M9TlTItTY3ntaT/In7VYAjg?=
 =?us-ascii?Q?xOb1aQWM03BeFsqy7lnCjxfAbl+IQj0tIqgZ7t0xoGLkdxa8INq5V48UhDd9?=
 =?us-ascii?Q?i9i+6QM1mtXVwFyr/bX/dm2ZHyPQw5x9OppW3/uScKGEtxUOR0VYk06WQ3bA?=
 =?us-ascii?Q?Ri4Bvd7O1qg+8AHrQA4w1E6Qq2AaTZodhJ3hhB94XkeKnEpFwddRSAlOxuVH?=
 =?us-ascii?Q?neFvGsEsw/mra2WAE8eG2Yjo99hdaFeEnup09NzZZeYND130mnKxZs9UHZjT?=
 =?us-ascii?Q?G5O57TLukneqwmAh+4Etn0FbHnsOqvk5GMBIwkKJYax6L6BtX2Wfoetunurk?=
 =?us-ascii?Q?5CqcAM5cIj2ThTs/PVOOi/WWUbVqrgAYIx05LDRr+6BlKw5D7o8hL2SPnrrf?=
 =?us-ascii?Q?iXm6VwvuNC380SvhYpJDtHY6qzA25fJ54v4iCyimviejpvNNkESwDV/WFNl1?=
 =?us-ascii?Q?/MfKGsV7BO6jGxK2qBahsGPWfV3iJCOXTQQgbgyKb/sT2a0dJI/EuOOIsOel?=
 =?us-ascii?Q?ocTzTCw6FdlSmLGxH0KKCgGTaArSYdjnMql+dgxWRQ60NjulBLZWz3jEPYFY?=
 =?us-ascii?Q?Ppp4PluP1yVG4kPFQdCLDXSjeQCUrOhQ9BYz9X4ujeF1MDk4CG3vqL9Hfskg?=
 =?us-ascii?Q?SkcfrN40Xxldt0MCJiCMmckCfU82IL/Fx58Y0IeZbShyOaDcA3rbim090Iy9?=
 =?us-ascii?Q?7kTlaOJemnpTy4XLvo0PZombo+lOqjE0gNKeB4PSbef/8Lx4vO4SmwgltCfo?=
 =?us-ascii?Q?uZFjmUoOmTrc8BM0Bu4awlKcltVsyE9giyv4cnjseOWr6xxn2ri0N9wfM5qM?=
 =?us-ascii?Q?rwrEwaAGgD0B2eFThzhjx878ypMOqYG2EuSRtjHBStmNDkNqXg9vvZxYrBWe?=
 =?us-ascii?Q?axFn8IeMu1h03PDuqIvugnPUWU6wGfc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63ae4d6-9e0d-47c7-6678-08df09ae1e94
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:25:55.3312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNA4mgvNtPcgPSW999ROfQr0rDbkJHT430SIW0012KmKh9/wL+Z/XwLcH53+A1eA3GrYCF7IVwVNnoSg/aXa+VHu2bCQTric3OODIPkaUzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the base topology for the Phytium Pi board built around the
E2000Q SoC, with two FTC310 and two FTC664 CPUs, RAM, GICv3/ITS,
and PL011 UARTs.

Describe the CPUs as three non-uniform clusters matching the vendor
Linux device tree. Preserve the board CPU slot order so firmware
MPIDR 0x200 maps to QEMU CPU index 2.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |   8 +
 hw/arm/meson.build     |   1 +
 hw/arm/phytium_e2000.c | 406 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 415 insertions(+)
 create mode 100644 hw/arm/phytium_e2000.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5db7ce057f..20863b5847 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -126,6 +126,14 @@ config OMAP
     select SD
     select SERIAL_MM
 
+config PHYTIUM_E2000
+    bool
+    default y
+    depends on TCG && AARCH64
+    select ARM_GIC
+    select PL011
+    select UNIMP
+
 config REALVIEW
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 78acb04c8b..6f685b414d 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -10,6 +10,7 @@ arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'
 arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
+arm_common_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000.c'))
 arm_common_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_common_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_common_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
new file mode 100644
index 0000000000..defc265a5d
--- /dev/null
+++ b/hw/arm/phytium_e2000.c
@@ -0,0 +1,406 @@
+/*
+ * Phytium E2000 board models
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "system/address-spaces.h"
+#include "system/kvm.h"
+#include "system/system.h"
+#include "exec/hwaddr.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/char/pl011.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/misc/unimp.h"
+#include "qobject/qlist.h"
+#include "qom/object.h"
+#include "target/arm/cpu.h"
+#include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
+
+#define TYPE_PHYTIUM_PI MACHINE_TYPE_NAME("phytium-pi")
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000State, PHYTIUM_PI)
+
+#define PHYTIUM_E2000_NUM_CPUS        4
+#define PHYTIUM_E2000_NUM_IRQS        256
+
+#define PHYTIUM_E2000_NUM_UARTS       7
+
+#define PHYTIUM_E2000_GTIMER_HZ       50000000
+
+enum {
+    PHYTIUM_E2000_LOW_PERIPH,
+    PHYTIUM_E2000_UART0,
+    PHYTIUM_E2000_UART1,
+    PHYTIUM_E2000_UART2,
+    PHYTIUM_E2000_UART3,
+    PHYTIUM_E2000_UART4,
+    PHYTIUM_E2000_UART5,
+    PHYTIUM_E2000_UART6,
+    PHYTIUM_E2000_GIC_DIST,
+    PHYTIUM_E2000_GIC_ITS,
+    PHYTIUM_E2000_GIC_REDIST,
+    PHYTIUM_E2000_BOOT_SRAM,
+    PHYTIUM_E2000_BOARD_CTRL,
+    PHYTIUM_E2000_BOOT_IACC,
+    PHYTIUM_E2000_RAM,
+    PHYTIUM_E2000_RAM_HIGH,
+};
+
+struct PhytiumE2000State {
+    MachineState parent;
+    struct arm_boot_info bootinfo;
+    DeviceState *gic;
+    MemoryRegion ram_low;
+    MemoryRegion ram_high;
+};
+
+/*
+ * Keep the physical addresses used by the vendor firmware even before every
+ * device behind them is modeled. In particular, boot SRAM carries PBR/PBF
+ * handoff data and IACC is the fixed execution window for system firmware.
+ */
+static const MemMapEntry phytium_e2000_memmap[] = {
+    [PHYTIUM_E2000_LOW_PERIPH] =     { 0x28000000, 0x00100000 },
+    [PHYTIUM_E2000_UART0] =          { 0x2800c000, 0x00001000 },
+    [PHYTIUM_E2000_UART1] =          { 0x2800d000, 0x00001000 },
+    [PHYTIUM_E2000_UART2] =          { 0x2800e000, 0x00001000 },
+    [PHYTIUM_E2000_UART3] =          { 0x2800f000, 0x00001000 },
+    [PHYTIUM_E2000_UART4] =          { 0x28014000, 0x00001000 },
+    [PHYTIUM_E2000_UART5] =          { 0x2802a000, 0x00001000 },
+    [PHYTIUM_E2000_UART6] =          { 0x28032000, 0x00001000 },
+    [PHYTIUM_E2000_GIC_DIST] =       { 0x30800000, 0x00020000 },
+    [PHYTIUM_E2000_GIC_ITS] =        { 0x30820000, 0x00020000 },
+    [PHYTIUM_E2000_GIC_REDIST] =     { 0x30880000, 0x00080000 },
+    [PHYTIUM_E2000_BOOT_SRAM] =      { 0x30c00000, 0x00100000 },
+    [PHYTIUM_E2000_BOARD_CTRL] =     { 0x31800000, 0x01400000 },
+    [PHYTIUM_E2000_BOOT_IACC] =      { 0x38000000, 0x08000000 },
+    [PHYTIUM_E2000_RAM] =            { 0x80000000, 0x80000000 },
+    [PHYTIUM_E2000_RAM_HIGH] =       { 0x2000000000ULL, 0x180000000ULL },
+};
+
+static const int phytium_e2000_uart_irqmap[] = {
+    [0] = 83,
+    [1] = 84,
+    [2] = 85,
+    [3] = 86,
+    [4] = 92,
+    [5] = 103,
+    [6] = 107,
+};
+
+typedef struct PhytiumE2000CPUConfig {
+    const char *type;
+    uint64_t mp_affinity;
+    int64_t cluster_id;
+    int64_t core_id;
+} PhytiumE2000CPUConfig;
+
+static const PhytiumE2000CPUConfig
+phytium_e2000_cpu_config[PHYTIUM_E2000_NUM_CPUS] = {
+    {
+        .type = ARM_CPU_TYPE_NAME("phytium-ftc664"),
+        .mp_affinity = 0x000,
+        .cluster_id = 0,
+        .core_id = 0,
+    },
+    {
+        .type = ARM_CPU_TYPE_NAME("phytium-ftc664"),
+        .mp_affinity = 0x100,
+        .cluster_id = 1,
+        .core_id = 0,
+    },
+    {
+        .type = ARM_CPU_TYPE_NAME("phytium-ftc310"),
+        .mp_affinity = 0x200,
+        .cluster_id = 2,
+        .core_id = 0,
+    },
+    {
+        .type = ARM_CPU_TYPE_NAME("phytium-ftc310"),
+        .mp_affinity = 0x201,
+        .cluster_id = 2,
+        .core_id = 1,
+    },
+};
+
+static void phytium_e2000_create_its(PhytiumE2000State *s)
+{
+    DeviceState *dev = qdev_new(its_class_name());
+
+    object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(s->gic),
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
+                    phytium_e2000_memmap[PHYTIUM_E2000_GIC_ITS].base);
+}
+
+static void phytium_e2000_create_gic(PhytiumE2000State *s)
+{
+    MachineState *ms = MACHINE(s);
+    SysBusDevice *gicbusdev;
+    QList *redist_region_count;
+    int i;
+
+    s->gic = qdev_new(gicv3_class_name());
+    qdev_prop_set_uint32(s->gic, "revision", 3);
+    qdev_prop_set_uint32(s->gic, "num-cpu", ms->smp.cpus);
+    qdev_prop_set_uint32(s->gic, "num-irq", PHYTIUM_E2000_NUM_IRQS + 32);
+    qdev_prop_set_bit(s->gic, "has-security-extensions", true);
+    qdev_prop_set_bit(s->gic, "has-lpi", true);
+
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, ms->smp.cpus);
+    qdev_prop_set_array(s->gic, "redist-region-count", redist_region_count);
+
+    object_property_set_link(OBJECT(s->gic), "sysmem",
+                             OBJECT(get_system_memory()), &error_fatal);
+
+    gicbusdev = SYS_BUS_DEVICE(s->gic);
+    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+    sysbus_mmio_map(gicbusdev, 0,
+                    phytium_e2000_memmap[PHYTIUM_E2000_GIC_DIST].base);
+    sysbus_mmio_map(gicbusdev, 1,
+                    phytium_e2000_memmap[PHYTIUM_E2000_GIC_REDIST].base);
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
+        int intidbase = PHYTIUM_E2000_NUM_IRQS + i * GIC_INTERNAL;
+        static const int timer_irq[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+        };
+
+        for (int irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                qdev_get_gpio_in(s->gic, intidbase + timer_irq[irq]));
+        }
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
+            qdev_get_gpio_in(s->gic, intidbase + ARCH_GIC_MAINT_IRQ));
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+            qdev_get_gpio_in(s->gic, intidbase + VIRTUAL_PMU_IRQ));
+
+        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicbusdev, i + ms->smp.cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicbusdev, i + 2 * ms->smp.cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicbusdev, i + 3 * ms->smp.cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+
+    phytium_e2000_create_its(s);
+}
+
+static void phytium_e2000_create_uart(PhytiumE2000State *s, int index)
+{
+    int map_idx = PHYTIUM_E2000_UART0 + index;
+    DeviceState *dev = qdev_new(TYPE_PL011);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    qdev_prop_set_chr(dev, "chardev", serial_hd(index));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map(sbd, 0, phytium_e2000_memmap[map_idx].base);
+    sysbus_connect_irq(sbd, 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_uart_irqmap[index]));
+}
+
+static void phytium_e2000_create_unimplemented(void)
+{
+    /*
+     * Preserve the SoC address map while individual boot-critical devices are
+     * introduced. More specific devices may overlap these low-priority
+     * catch-all regions without silently accepting accesses elsewhere.
+     */
+    create_unimplemented_device(
+        "phytium-e2000.low-peripheral",
+        phytium_e2000_memmap[PHYTIUM_E2000_LOW_PERIPH].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_LOW_PERIPH].size);
+    create_unimplemented_device(
+        "phytium-e2000.board-control",
+        phytium_e2000_memmap[PHYTIUM_E2000_BOARD_CTRL].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_BOARD_CTRL].size);
+}
+
+static void phytium_e2000_create_ram(PhytiumE2000State *s)
+{
+    MachineState *ms = MACHINE(s);
+    uint64_t low_size =
+        MIN(ms->ram_size, phytium_e2000_memmap[PHYTIUM_E2000_RAM].size);
+    uint64_t high_size = ms->ram_size - low_size;
+
+    /*
+     * Keep the machine RAMBlock contiguous for migration, but expose it in
+     * the two physical windows implemented by E2000. The high alias resumes
+     * at low_size, so the intervening PCIe hole consumes no guest RAM.
+     */
+    memory_region_init_alias(&s->ram_low, OBJECT(s),
+        "phytium-e2000.ram-low", ms->ram, 0, low_size);
+    memory_region_add_subregion(get_system_memory(),
+        phytium_e2000_memmap[PHYTIUM_E2000_RAM].base, &s->ram_low);
+
+    if (!high_size) {
+        return;
+    }
+
+    memory_region_init_alias(&s->ram_high, OBJECT(s),
+        "phytium-e2000.ram-high", ms->ram, low_size, high_size);
+    memory_region_add_subregion(get_system_memory(),
+        phytium_e2000_memmap[PHYTIUM_E2000_RAM_HIGH].base, &s->ram_high);
+}
+
+static void phytium_e2000_create_cpus(PhytiumE2000State *s)
+{
+    MachineState *ms = MACHINE(s);
+    const CPUArchIdList *possible_cpus;
+    int i;
+
+    possible_cpus = MACHINE_GET_CLASS(ms)->possible_cpu_arch_ids(ms);
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        Object *cpuobj = object_new(possible_cpus->cpus[i].type);
+        CPUState *cs;
+
+        object_property_set_int(cpuobj, "mp-affinity",
+                                possible_cpus->cpus[i].arch_id,
+                                &error_abort);
+        object_property_set_int(cpuobj, "cntfrq", PHYTIUM_E2000_GTIMER_HZ,
+                                &error_abort);
+        if (object_property_find(cpuobj, "has_el3")) {
+            /*
+             * The generic-loader U-Boot path starts after the EL3 firmware
+             * stages that normally provide the Phytium SMC services.
+             */
+            object_property_set_bool(cpuobj, "has_el3", false, &error_abort);
+        }
+        object_property_set_link(cpuobj, "memory", OBJECT(get_system_memory()),
+                                 &error_abort);
+        cs = CPU(cpuobj);
+        cs->cpu_index = i;
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+        object_unref(cpuobj);
+    }
+}
+
+static void phytium_pi_init(MachineState *ms)
+{
+    PhytiumE2000State *s = PHYTIUM_PI(ms);
+    int i;
+
+    if (kvm_enabled()) {
+        error_report("phytium-pi: KVM is not supported");
+        exit(1);
+    }
+
+    if (ms->smp.cpus > PHYTIUM_E2000_NUM_CPUS) {
+        error_report("phytium-pi supports at most %d CPUs",
+                     PHYTIUM_E2000_NUM_CPUS);
+        exit(1);
+    }
+
+    if (ms->ram_size >
+        phytium_e2000_memmap[PHYTIUM_E2000_RAM].size +
+        phytium_e2000_memmap[PHYTIUM_E2000_RAM_HIGH].size) {
+        error_report("phytium-pi supports at most 8 GiB RAM");
+        exit(1);
+    }
+
+    phytium_e2000_create_ram(s);
+    phytium_e2000_create_unimplemented();
+
+    phytium_e2000_create_cpus(s);
+    phytium_e2000_create_gic(s);
+
+    for (i = 0; i < PHYTIUM_E2000_NUM_UARTS; i++) {
+        phytium_e2000_create_uart(s, i);
+    }
+
+    s->bootinfo.ram_size = ms->ram_size;
+    s->bootinfo.board_id = -1;
+    s->bootinfo.loader_start = phytium_e2000_memmap[PHYTIUM_E2000_RAM].base;
+    s->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    s->bootinfo.firmware_loaded = false;
+    arm_load_kernel(ARM_CPU(first_cpu), ms, &s->bootinfo);
+}
+
+static const CPUArchIdList *phytium_e2000_possible_cpu_arch_ids(MachineState *ms)
+{
+    int i;
+
+    if (ms->possible_cpus) {
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * ms->smp.max_cpus);
+    ms->possible_cpus->len = ms->smp.max_cpus;
+
+    for (i = 0; i < ms->possible_cpus->len; i++) {
+        const PhytiumE2000CPUConfig *config = &phytium_e2000_cpu_config[i];
+
+        ms->possible_cpus->cpus[i].type = config->type;
+        ms->possible_cpus->cpus[i].arch_id = config->mp_affinity;
+        ms->possible_cpus->cpus[i].props.has_cluster_id = true;
+        ms->possible_cpus->cpus[i].props.cluster_id = config->cluster_id;
+        ms->possible_cpus->cpus[i].props.has_core_id = true;
+        ms->possible_cpus->cpus[i].props.core_id = config->core_id;
+        ms->possible_cpus->cpus[i].props.has_thread_id = true;
+        ms->possible_cpus->cpus[i].props.thread_id = 0;
+    }
+
+    return ms->possible_cpus;
+}
+
+static void phytium_pi_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        /* The machine assigns the FTC310 slots independently */
+        ARM_CPU_TYPE_NAME("phytium-ftc664"),
+        NULL,
+    };
+
+    mc->init = phytium_pi_init;
+    mc->desc = "Phytium Pi board (Phytium E2000Q)";
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("phytium-ftc664");
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->max_cpus = PHYTIUM_E2000_NUM_CPUS;
+    mc->default_cpus = PHYTIUM_E2000_NUM_CPUS;
+    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_id = "phytium-e2000.ram";
+    mc->minimum_page_bits = 12;
+    mc->block_default_type = IF_SD;
+    mc->no_cdrom = 1;
+    mc->possible_cpu_arch_ids = phytium_e2000_possible_cpu_arch_ids;
+}
+
+static const TypeInfo phytium_pi_info = {
+    .name = TYPE_PHYTIUM_PI,
+    .parent = TYPE_MACHINE,
+    .class_init = phytium_pi_class_init,
+    .instance_size = sizeof(PhytiumE2000State),
+    .interfaces = aarch64_machine_interfaces,
+};
+
+static void phytium_pi_machine_init(void)
+{
+    type_register_static(&phytium_pi_info);
+}
+
+type_init(phytium_pi_machine_init);
-- 
2.53.0


