Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D7AC79FAD
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHf-0007zd-BU; Tue, 08 Sep 2026 06:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHd-0007z7-GE; Tue, 08 Sep 2026 06:42:33 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHa-0006Xy-CT; Tue, 08 Sep 2026 06:42:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTUAHL4lKcXAJpKtASv7LQd47jIjN90+aS4m42xTHoRCaECT8aJWFMlpj6/1xucSkY0J1BGwHeKH2klf5kvp4+RehVpaJNNAXomNy21ELlIfXQLW5omLPYiMLIGFYdgKDGreH5sKobzYV0b7VGF3uknZQexHixYnmgen+6Zs6TEwUfjyqhE/ym9/Ceyebrxfs2xzSwB8CfNkColDGNBFqrNaBu1yz0lfyPLmo1ftltP08LsPOXv0mPtI+6WUnE5+7HG/OiOepy/VyDRvtg9NKLRcPAIqDbo4Y6Gemn+JITc1V4NEeL/e4T1ZmC+TZT/eUypXkrIA4NU2QIkDATT3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk30QK155yVZFueYTOfsjoH6nNsTfDilk4zWO0jr5og=;
 b=AN2u95J3ro/EmzBPLMS40UBmWcsEF8Syf+aYRixyUR7Vq185XY2vxu3Y3P08ezXuUWXUP9tofS34/zaHkzHYmr0kl6Ik8Q2AKuMkk0xzwCghsowOXSBoQfazr86xKESG4Ft192neDHuovWAcfqNl1DzKTZn8yhaOqMP49rumZS6WTYcsrQAYCu25KQh2LbujSyarN/Dk1SAoeUNu1MWULCuogk2C/a68VXZAdh15ggSycDDMeYQ+vjZt2ZqduNmLnFTsrShk67iF7yFOm1x/e2EUOv+hha7tbFB5PmE5pRVLmq/Mizxsg1WfG0DJyYRQfdMuZ6EhVHV8qeFZpehnkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk30QK155yVZFueYTOfsjoH6nNsTfDilk4zWO0jr5og=;
 b=O/V0EGoA1fUkjFN6bvcNVXwyNw64VspfBbHG6hHRF/AVl3JcX7qxb6HQvp61c9cStfQm4kfYP3fBhIAP7KeeRHCewhXlj43BsGxhh7rTnbrqeZCGZ3+rQ/uJIQZs/mjpaY1vMLk5PbgIV4tXgw+Xg+5TBJ+S+BLLN69b2ul9PX9tC5XGJDyZCscOmoU3dxmg6EzHUKbggcIn+VnStB9MXhuNEv7bqq8ckX7E8dCVd0JuXCA/0GNMxZ0liKwn4lybLrmr0GFDgX0sbethGdbTXV9xlr884n/ahAlGi8H2VJOOpQUamDh9KHyUlFFeC2rnc6lgH9e+odDFy0oOsAUBDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB8780.apcprd02.prod.outlook.com (2603:1096:101:2cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:20 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:20 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 01/32] hw/arm: Add Phytium E2000 SoC and Phytium Pi machine
Date: Tue,  8 Sep 2026 18:41:10 +0800
Message-ID: <20260908104159.1621764-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 98df67c1-c798-4bfd-c792-08df0d95dbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: gFxc/vpKmFGZSCD30prSDaBYCoxu6FpLj/IZ36/LornGOnoTq9IibLwEOVWL19LturwD08hVQD8hDIkS+zhbZ7JKQ/7dyqS6a1rLXM6xRKH/zV6rEShtNnr+NiYvXwVjzuxI8nGcrUlqEjzckOAKzfs2wa8KSIx7bMiZF2R7e7Ym4EdEL0K+GOL8Pvwt6K/hKTwgXgRnEe8yRhSBasrrFzIoyXX2Wbo9ICpx9Ow4u514rla8Ab3A/AkzACc15Q3EYc2/PHyx0Dsw8EUj/aWh8+Hgwt0UQYPaLkXcRvHl4sDMHQO+3ahIUAEjFKvj4TvQd7UMrx07B9Smd7dv0fflMf85rA5j4yECZZ9hIc3etka5dxs6cS7ryyTyep9URjri+MR74rdIRFw/hf91x0NqNgzGT7WUQPfQHiIq9cs1rcVKGow7oHI0vfSNMgHZDNgk/9f4iyK1hR4A4TJF50YxNUCdfly43gRUxmbIt2qqgPSK0Md9TbkdpoRc791zt5rKJfqI4CQDJlYKHrzUvUV+CaCthk4X+H58HE9XITooLDoPhBZd7t1kf+SGr27ITuTmO8J/QUTAKNrjin4WXxKFlPVku5owfeBCEaH8yxuU0LIIhqsChui/LOysOw0OsBxaP28Q5+ylrLYdsZ8N3HnHgzu/138TNsL3ftnry4zWReM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qd+OxB6JXMvQZ/QB3VjuHen7dj30fhBEKUKryk5nKGJWYDskiGT49QdgMXM?=
 =?us-ascii?Q?wjb4pvI4ZtNHCNAGu9GHmki3J4lBv94UY681fqpAKs2hd8uf2qCrmrj3riw0?=
 =?us-ascii?Q?b4dyvy639pkPqaM8h3de+dVap3mD3QSw10UdTRwj9CXVz0tzEcotnULuRD0N?=
 =?us-ascii?Q?caq1xLLo5fxTTzAyKAz8OabAfxFhrhFXp6akKRjKzaPidHOEw19ucnC16yHR?=
 =?us-ascii?Q?B6FXOnsSSxspM9KD43LtDvhucs/Fk+wpFQ3/joit7d9ykV7xyllaziznlGPo?=
 =?us-ascii?Q?R0jKn6I9FZHDyehNgckuFFXFs8k1W6eB/q71OW8hPzPnTMnTnPLvRtZe8hh5?=
 =?us-ascii?Q?9HswK6b2GE3CDaVlN63pb2Xm9g5bcOiqsnQojxeAof2Y+aI5uLOT2rFU+Nvc?=
 =?us-ascii?Q?jh06P3nmeaZAx3JNJwMQvj9qasih4gjABybGoC0T1mR/AgnltJTOMX27ajKZ?=
 =?us-ascii?Q?f9/z7UYreFxF418gFSJC8jQRj6il8kLMZSnnQmubVlfC+YCxoePyesTnLncn?=
 =?us-ascii?Q?TvjvxZhc07aaZd0jUcA5dndYOT2zHN6QAJRVMmPD7Iw78GCdQ77c/ujjykMu?=
 =?us-ascii?Q?wAMdmRQHacJICZ3vB3hoYC7zxOno6yjLjMHTdmqsXCYArvwdKT0mVYDK9qQr?=
 =?us-ascii?Q?ooKYY6eZLcbyL69YKq/uITmm8EFxr1GVLyfi539+8kQHU96NsutfNozTaR6f?=
 =?us-ascii?Q?Pm5uG9iaIUKv1vYUp1BSwVoGstn9P+gwEhGS/8qhufoBa6Vmku4fwMOMO9H9?=
 =?us-ascii?Q?+UPe+ixDCwU5ls6I5eA5mYnAKtE3PKyB/hez30pa1WuqwO/qA4DI+TdkJkYj?=
 =?us-ascii?Q?a02oastjnfSA6ypV7xjbA9qJqTrZq7nLt/eKVuyxsoxVoTKbpQxu6IT3Dd4Q?=
 =?us-ascii?Q?4OyxbV3DPDkFWWKuBFcM0y3mwPecsRcL1nClNefsEeVwgDXg4hJIO1Z4jLwD?=
 =?us-ascii?Q?d+G8d/pPv2HIr5QOiufbTU3x/hlN5HCO09IoeYdCCbxtpHPvQZ84qR+NedZC?=
 =?us-ascii?Q?SIR1PQ4oRZfYzeXNmz5bDIsP8Q9qnOT6c6dNbFes1qaZ3+gWa/krZXkl20lo?=
 =?us-ascii?Q?5X3Z8pHF2Xn/gkqC7MTxUZYJcVO5xoFmvyrEg8JB5Qnfs1OMSCJAdNE5NS8G?=
 =?us-ascii?Q?70K0KclPWTUx/KjyYsK3HHsBP2T0x3ImvvF/QwcgMk6O4Pw4LZspG4eEBskf?=
 =?us-ascii?Q?neSGDADtUJEsqLWvQJAqHTvlAm85/tGenlbfHwoI6FL7ASs92fdDCrK2nm0m?=
 =?us-ascii?Q?gC3njH8D9A6SMYsK/5wV3nGHACmk7yNdDLCVnIvcBG3wT7vajGYapKPS4zzJ?=
 =?us-ascii?Q?OHoN2ckD8fKOtSMc5HfI/AXxKAphhQ3BpsIpMARCV1fvfyuSrObsJU7rCMWO?=
 =?us-ascii?Q?sENj6xteyKGx6O/WWqOdnCMSsAOhB+2sfZpUSQ81t5qXWRBc0sxQI99AGwOF?=
 =?us-ascii?Q?VzejjrrpO8XGid41khUZMOFnmEBKxkuYEfLe8u9qomhK96DKlg7c/X3Vpu+y?=
 =?us-ascii?Q?efBptPh9p6VILcZIHZjlr7mIkR0YVabT9CaH48HLFbi/L8cEyyxU/OnIXZcd?=
 =?us-ascii?Q?3uGlIOM2PUDywGIWfOCs8HE8nawVuFrhYdGIQ6FlW7rdkLwV5xbBPNh+3AGM?=
 =?us-ascii?Q?ymx+qKXevaDxEIvabzNVc73YVPYWb1uRnIqLMFoem20gZSl2pWRNaR7amzJh?=
 =?us-ascii?Q?X9jel2ccJAUfi5d/4oKJ6ZTfDzeqJqgnvyR+2Q+YUcQtGwCoajhssoHSsD2p?=
 =?us-ascii?Q?hMdga0Sode17z9pp9Z/Vg12MpEk+kHM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98df67c1-c798-4bfd-c792-08df0d95dbdc
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:20.1666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyiEWvKG/DDQcgM+zCiDan0voUrcFul1WAf5zX2MhjPp9o+13Jy8zCbvFmGZ40iEEFeX+AFbFqFAjyS3qjOCrVmFSxHrtoxiXv6cldGBSao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB8780
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add a reusable E2000 SoC QOM device and the Phytium Pi board
machine. The SoC owns the heterogeneous CPU complex, GICv3/ITS,
PL011 UARTs, and the initial unimplemented register windows, while
the machine owns RAM and embeds the SoC as a child.

Instantiate Cortex-A72 CPU objects inside the SoC and apply the FTC310
and FTC664 identity fields before realization. Add conservative RAZ/WI
and NOP stubs for the E2000 system registers used by EL3 firmware.
Keeping this configuration local avoids exposing SoC-specific CPU
types through the global ARM CPU list.

Describe the CPUs as three non-uniform clusters matching the vendor
Linux device tree. Preserve the board CPU slot order so firmware MPIDR
0x200 maps to QEMU CPU index 2.

Reject KVM because the machine requires the heterogeneous FTC CPU
configuration applied to the Cortex-A72 TCG cores. Its firmware path
also depends on EL3 and Phytium-specific system registers that Arm KVM
cannot provide.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Split the board machine from a reusable E2000 SoC QOM device
- Make the SoC own its CPU, GIC, UART, and register-window children
- Configure FTC cores locally from the Cortex-A72 CPU type
- Explain why the machine is restricted to TCG

 include/hw/arm/phytium_e2000.h |  62 ++++++
 hw/arm/phytium_e2000.c         | 393 +++++++++++++++++++++++++++++++++
 hw/arm/phytium_e2000_machine.c | 171 ++++++++++++++
 hw/arm/Kconfig                 |   8 +
 hw/arm/meson.build             |   4 +
 5 files changed, 638 insertions(+)
 create mode 100644 include/hw/arm/phytium_e2000.h
 create mode 100644 hw/arm/phytium_e2000.c
 create mode 100644 hw/arm/phytium_e2000_machine.c

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
new file mode 100644
index 0000000000..466481f629
--- /dev/null
+++ b/include/hw/arm/phytium_e2000.h
@@ -0,0 +1,62 @@
+/*
+ * Phytium E2000 SoC model
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_PHYTIUM_E2000_H
+#define HW_ARM_PHYTIUM_E2000_H
+
+#include "hw/arm/boot.h"
+#include "hw/core/sysbus.h"
+#include "target/arm/cpu.h"
+
+#define TYPE_PHYTIUM_E2000_SOC "phytium-e2000-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000SoCState, PHYTIUM_E2000_SOC)
+
+#define PHYTIUM_E2000_NUM_CPUS 4
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
+extern const MemMapEntry phytium_e2000_memmap[];
+
+struct PhytiumE2000SoCState {
+    SysBusDevice parent_obj;
+
+    DeviceState *gic;
+    ARMCPU cpu[PHYTIUM_E2000_NUM_CPUS];
+    unsigned int num_cpus;
+};
+
+void phytium_e2000_soc_configure(PhytiumE2000SoCState *s,
+                                 unsigned int num_cpus);
+void phytium_e2000_soc_cpu_topology(unsigned int index,
+                                    uint64_t *mp_affinity,
+                                    int64_t *cluster_id,
+                                    int64_t *core_id);
+ARMCPU *phytium_e2000_soc_cpu(PhytiumE2000SoCState *s,
+                              unsigned int index);
+
+#endif
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
new file mode 100644
index 0000000000..8c62d0dbdb
--- /dev/null
+++ b/hw/arm/phytium_e2000.c
@@ -0,0 +1,393 @@
+/*
+ * Phytium E2000 SoC model
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
+#include "qemu/bitops.h"
+#include "qapi/error.h"
+#include "system/address-spaces.h"
+#include "system/system.h"
+#include "exec/hwaddr.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/phytium_e2000.h"
+#include "hw/char/pl011.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/misc/unimp.h"
+#include "qobject/qlist.h"
+#include "qom/object.h"
+#include "target/arm/cpu.h"
+#include "target/arm/cpu-features.h"
+#include "target/arm/cpu-qom.h"
+#include "target/arm/cpregs.h"
+#include "target/arm/gtimer.h"
+
+#define PHYTIUM_E2000_NUM_IRQS        256
+
+#define PHYTIUM_E2000_NUM_UARTS       7
+
+#define PHYTIUM_E2000_GTIMER_HZ       50000000
+
+/*
+ * Keep the physical addresses used by the vendor firmware even before every
+ * device behind them is modeled. In particular, boot SRAM carries PBR/PBF
+ * handoff data and IACC is the fixed execution window for system firmware.
+ */
+const MemMapEntry phytium_e2000_memmap[] = {
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
+typedef enum PhytiumE2000CPUModel {
+    PHYTIUM_E2000_CPU_FTC310,
+    PHYTIUM_E2000_CPU_FTC664,
+} PhytiumE2000CPUModel;
+
+typedef struct PhytiumE2000CPUConfig {
+    PhytiumE2000CPUModel model;
+    uint64_t mp_affinity;
+    int64_t cluster_id;
+    int64_t core_id;
+} PhytiumE2000CPUConfig;
+
+static const ARMCPRegInfo phytium_e2000_cp_reginfo[] = {
+    /*
+     * The E2000 EL3 firmware touches implementation-defined CPU registers
+     * during the PBF/BL1 cache and core setup. QEMU does not model these
+     * controls, so expose conservative RAZ/WI stubs for the boot firmware.
+     *
+     * PBF reads these identification and cluster controls after writing
+     * them. Returning zero preserves the reset state without claiming that
+     * QEMU implements the associated cache or coherency controls.
+     */
+    { .name = "E2000_CPUID_CTL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 1, .crn = 15, .crm = 1, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST | ARM_CP_NO_RAW,
+      .resetvalue = 0 },
+    { .name = "E2000_CLUSTER_CTL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 1, .crn = 11, .crm = 8, .opc2 = 6,
+      .access = PL1_RW, .type = ARM_CP_CONST | ARM_CP_NO_RAW,
+      .resetvalue = 0 },
+    /*
+     * The remaining controls are only programmed as part of firmware setup.
+     * Accept the writes without retaining state because no modeled CPU
+     * behavior depends on their values.
+     */
+    { .name = "E2000_EL1_CTL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 2, .crn = 15, .crm = 15, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_NOP | ARM_CP_NO_RAW },
+    { .name = "E2000_EL2_CTL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 15, .crm = 15, .opc2 = 0,
+      .access = PL2_RW, .type = ARM_CP_NOP | ARM_CP_NO_RAW },
+    { .name = "E2000_EL2_CTL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 15, .crm = 2, .opc2 = 4,
+      .access = PL2_RW, .type = ARM_CP_NOP | ARM_CP_NO_RAW },
+    { .name = "E2000_EL3_CTL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 15, .opc2 = 0,
+      .access = PL3_RW, .type = ARM_CP_NOP | ARM_CP_NO_RAW },
+};
+
+static const PhytiumE2000CPUConfig
+phytium_e2000_cpu_config[PHYTIUM_E2000_NUM_CPUS] = {
+    {
+        .model = PHYTIUM_E2000_CPU_FTC664,
+        .mp_affinity = 0x000,
+        .cluster_id = 0,
+        .core_id = 0,
+    },
+    {
+        .model = PHYTIUM_E2000_CPU_FTC664,
+        .mp_affinity = 0x100,
+        .cluster_id = 1,
+        .core_id = 0,
+    },
+    {
+        .model = PHYTIUM_E2000_CPU_FTC310,
+        .mp_affinity = 0x200,
+        .cluster_id = 2,
+        .core_id = 0,
+    },
+    {
+        .model = PHYTIUM_E2000_CPU_FTC310,
+        .mp_affinity = 0x201,
+        .cluster_id = 2,
+        .core_id = 1,
+    },
+};
+
+static void phytium_e2000_configure_cpu(ARMCPU *cpu,
+                                        PhytiumE2000CPUModel model)
+{
+    ARMISARegisters *isar = &cpu->isar;
+
+    define_arm_cp_regs(cpu, phytium_e2000_cp_reginfo);
+
+    switch (model) {
+    case PHYTIUM_E2000_CPU_FTC310:
+        /* FTC310 cores identify with the FTC303 part number */
+        cpu->dtb_compatible = "phytium,ftc310";
+        cpu->midr = 0x700f3034;
+        SET_IDREG(isar, ID_AA64ISAR0, 0x00011100012120);
+        cpu->isar.mvfr0 = 0x10110222;
+        cpu->ctr = FIELD_DP64(cpu->ctr, CTR_EL0, L1IP, 2); /* VIPT */
+        break;
+    case PHYTIUM_E2000_CPU_FTC664:
+        cpu->dtb_compatible = "phytium,ftc664";
+        cpu->midr = 0x701f6643;
+        SET_IDREG(isar, ID_AA64ISAR0, 0x00000100012120);
+        cpu->isar.mvfr0 = 0x10111222;
+        cpu->ctr = FIELD_DP64(cpu->ctr, CTR_EL0, L1IP, 3); /* PIPT */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void phytium_e2000_create_its(PhytiumE2000SoCState *s)
+{
+    DeviceState *dev = qdev_new(its_class_name());
+
+    object_property_add_child(OBJECT(s), "gic-its", OBJECT(dev));
+    object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(s->gic),
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
+                    phytium_e2000_memmap[PHYTIUM_E2000_GIC_ITS].base);
+}
+
+static void phytium_e2000_create_gic(PhytiumE2000SoCState *s)
+{
+    SysBusDevice *gicbusdev;
+    QList *redist_region_count;
+    int i;
+
+    s->gic = qdev_new(gicv3_class_name());
+    object_property_add_child(OBJECT(s), "gic", OBJECT(s->gic));
+    qdev_prop_set_uint32(s->gic, "revision", 3);
+    qdev_prop_set_uint32(s->gic, "num-cpu", s->num_cpus);
+    qdev_prop_set_uint32(s->gic, "num-irq", PHYTIUM_E2000_NUM_IRQS + 32);
+    qdev_prop_set_bit(s->gic, "has-security-extensions", true);
+    qdev_prop_set_bit(s->gic, "has-lpi", true);
+
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, s->num_cpus);
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
+    for (i = 0; i < s->num_cpus; i++) {
+        DeviceState *cpudev = DEVICE(&s->cpu[i]);
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
+        sysbus_connect_irq(gicbusdev, i + s->num_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicbusdev, i + 2 * s->num_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicbusdev, i + 3 * s->num_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+
+    phytium_e2000_create_its(s);
+}
+
+static void phytium_e2000_create_uart(PhytiumE2000SoCState *s, int index)
+{
+    int map_idx = PHYTIUM_E2000_UART0 + index;
+    DeviceState *dev = qdev_new(TYPE_PL011);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    g_autofree char *name = g_strdup_printf("uart%d", index);
+
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
+    qdev_prop_set_chr(dev, "chardev", serial_hd(index));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map(sbd, 0, phytium_e2000_memmap[map_idx].base);
+    sysbus_connect_irq(sbd, 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_uart_irqmap[index]));
+}
+
+static void phytium_e2000_create_unimplemented_region(
+    PhytiumE2000SoCState *s, const char *child_name, const char *region_name,
+    int map_idx)
+{
+    DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+
+    object_property_add_child(OBJECT(s), child_name, OBJECT(dev));
+    qdev_prop_set_string(dev, "name", region_name);
+    qdev_prop_set_uint64(dev, "size", phytium_e2000_memmap[map_idx].size);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0,
+                            phytium_e2000_memmap[map_idx].base, -1000);
+}
+
+static void phytium_e2000_create_unimplemented(PhytiumE2000SoCState *s)
+{
+    /*
+     * Preserve the SoC address map while individual boot-critical devices are
+     * introduced. More specific devices may overlap these low-priority
+     * catch-all regions without silently accepting accesses elsewhere.
+     */
+    phytium_e2000_create_unimplemented_region(
+        s, "low-peripheral", "phytium-e2000.low-peripheral",
+        PHYTIUM_E2000_LOW_PERIPH);
+    phytium_e2000_create_unimplemented_region(
+        s, "board-control", "phytium-e2000.board-control",
+        PHYTIUM_E2000_BOARD_CTRL);
+}
+
+static void phytium_e2000_create_cpus(PhytiumE2000SoCState *s)
+{
+    int i;
+
+    for (i = 0; i < s->num_cpus; i++) {
+        const PhytiumE2000CPUConfig *config =
+            &phytium_e2000_cpu_config[i];
+        ARMCPU *cpu = &s->cpu[i];
+        Object *cpuobj = OBJECT(cpu);
+        CPUState *cs = CPU(cpu);
+
+        object_initialize_child(OBJECT(s), "cpu[*]", cpu,
+                                ARM_CPU_TYPE_NAME("cortex-a72"));
+
+        phytium_e2000_configure_cpu(cpu, config->model);
+
+        object_property_set_int(cpuobj, "mp-affinity",
+                                config->mp_affinity, &error_abort);
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
+        cs->cpu_index = i;
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+    }
+}
+
+void phytium_e2000_soc_configure(PhytiumE2000SoCState *s,
+                                 unsigned int num_cpus)
+{
+    s->num_cpus = num_cpus;
+}
+
+void phytium_e2000_soc_cpu_topology(unsigned int index,
+                                    uint64_t *mp_affinity,
+                                    int64_t *cluster_id,
+                                    int64_t *core_id)
+{
+    const PhytiumE2000CPUConfig *config;
+
+    g_assert(index < ARRAY_SIZE(phytium_e2000_cpu_config));
+    config = &phytium_e2000_cpu_config[index];
+    *mp_affinity = config->mp_affinity;
+    *cluster_id = config->cluster_id;
+    *core_id = config->core_id;
+}
+
+ARMCPU *phytium_e2000_soc_cpu(PhytiumE2000SoCState *s,
+                              unsigned int index)
+{
+    g_assert(index < s->num_cpus);
+    return &s->cpu[index];
+}
+
+static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
+{
+    PhytiumE2000SoCState *s = PHYTIUM_E2000_SOC(dev);
+    int i;
+
+    if (!s->num_cpus || s->num_cpus > PHYTIUM_E2000_NUM_CPUS) {
+        error_setg(errp, "E2000 SoC CPU count must be between 1 and %d",
+                   PHYTIUM_E2000_NUM_CPUS);
+        return;
+    }
+
+    phytium_e2000_create_unimplemented(s);
+    phytium_e2000_create_cpus(s);
+    phytium_e2000_create_gic(s);
+
+    for (i = 0; i < PHYTIUM_E2000_NUM_UARTS; i++) {
+        phytium_e2000_create_uart(s, i);
+    }
+}
+
+static void phytium_e2000_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = phytium_e2000_soc_realize;
+}
+
+static const TypeInfo phytium_e2000_soc_info = {
+    .name = TYPE_PHYTIUM_E2000_SOC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000SoCState),
+    .class_init = phytium_e2000_soc_class_init,
+};
+
+static void phytium_e2000_soc_register_types(void)
+{
+    type_register_static(&phytium_e2000_soc_info);
+}
+
+type_init(phytium_e2000_soc_register_types);
diff --git a/hw/arm/phytium_e2000_machine.c b/hw/arm/phytium_e2000_machine.c
new file mode 100644
index 0000000000..8a4f8d4275
--- /dev/null
+++ b/hw/arm/phytium_e2000_machine.c
@@ -0,0 +1,171 @@
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
+#include "exec/hwaddr.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/phytium_e2000.h"
+#include "hw/core/boards.h"
+#include "qom/object.h"
+#include "target/arm/cpu-qom.h"
+
+#define TYPE_PHYTIUM_PI MACHINE_TYPE_NAME("phytium-pi")
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumPiMachineState, PHYTIUM_PI)
+
+struct PhytiumPiMachineState {
+    MachineState parent_obj;
+
+    struct arm_boot_info bootinfo;
+    PhytiumE2000SoCState soc;
+    MemoryRegion ram_low;
+    MemoryRegion ram_high;
+};
+
+static void phytium_e2000_create_ram(PhytiumPiMachineState *s)
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
+static void phytium_pi_init(MachineState *ms)
+{
+    PhytiumPiMachineState *s = PHYTIUM_PI(ms);
+
+    /*
+     * KVM cannot provide the heterogeneous FTC CPU configuration applied to
+     * the Cortex-A72 TCG cores. The firmware path also requires EL3 and
+     * Phytium-specific system registers that KVM cannot provide.
+     */
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
+
+    object_initialize_child(OBJECT(s), "soc", &s->soc,
+                            TYPE_PHYTIUM_E2000_SOC);
+    phytium_e2000_soc_configure(&s->soc, ms->smp.cpus);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+
+    s->bootinfo.ram_size = ms->ram_size;
+    s->bootinfo.board_id = -1;
+    s->bootinfo.loader_start =
+        phytium_e2000_memmap[PHYTIUM_E2000_RAM].base;
+    s->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    s->bootinfo.firmware_loaded = false;
+    arm_load_kernel(phytium_e2000_soc_cpu(&s->soc, 0), ms, &s->bootinfo);
+}
+
+static const CPUArchIdList *phytium_e2000_possible_cpu_arch_ids(
+    MachineState *ms)
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
+        CPUArchId *cpu_slot = &ms->possible_cpus->cpus[i];
+
+        cpu_slot->type = ARM_CPU_TYPE_NAME("cortex-a72");
+        phytium_e2000_soc_cpu_topology(i, &cpu_slot->arch_id,
+                                       &cpu_slot->props.cluster_id,
+                                       &cpu_slot->props.core_id);
+        cpu_slot->props.has_cluster_id = true;
+        cpu_slot->props.has_core_id = true;
+        cpu_slot->props.has_thread_id = true;
+        cpu_slot->props.thread_id = 0;
+    }
+
+    return ms->possible_cpus;
+}
+
+static void phytium_pi_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a72"),
+        NULL,
+    };
+
+    mc->init = phytium_pi_init;
+    mc->desc = "Phytium Pi board (Phytium E2000Q)";
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a72");
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
+    .instance_size = sizeof(PhytiumPiMachineState),
+};
+
+static void phytium_pi_machine_init(void)
+{
+    type_register_static(&phytium_pi_info);
+}
+
+type_init(phytium_pi_machine_init);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index eae06369b0..05676534c2 100644
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
index bcc068de04..85e5020e94 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -10,6 +10,10 @@ arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'
 arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
+arm_common_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files(
+  'phytium_e2000.c',
+  'phytium_e2000_machine.c',
+))
 arm_common_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_common_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_common_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
-- 
2.53.0


