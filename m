Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A248DC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDW-0004Qq-5v; Thu, 23 Jul 2026 11:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD6-0004BP-Jq; Thu, 23 Jul 2026 11:19:44 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD3-00084Z-NV; Thu, 23 Jul 2026 11:19:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnCuiXIuIggsZzmq9qoxUJ1roLaGhf9TSWdKx+Pz+hxwvjlBIdXpPK7Ep8n7Hk5nSzLU5nLm70afV3RUkhFDz0D65b6rArDiLd7lh1din0OVahNFFPx4tNbhxjertE0wQPU/IMY4PKyCR5zuYwpc+lR/B+iUpfG35oQ+7TMik/YXnDTGW35eT/rpx+svwV/vuqzirC0YWeXHkcO9r05YJoovA9EOwc99lhNTlXvnvnkjOo/GyCNjbVy7mRszJVb4dOP3faNRRYOcAf7ADh6zTkigoO5Ll5te/y8aJrAbks+pskdPyqH9Nkw9g2vc81bM87sA1IIAKNpfOyegG5Pn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdPHNrQ3n3OKUJHikSico2whZxJmvVuyzHmIDjf8nZE=;
 b=ZYfv6Ctzs3+rXiKHH4q7fb6Reo/tDyswgg9KZI/t7H9J0IzRC85/a0DI3bwxYj19FGQCFOvd+I/yH/ub6S8FLOfxMjTBTMvHRa5L6iwAH5SG0t05vjyVZcV7nswHnvwzHD0PKzJz+CVaHm9jdd5WUWqCyUXpLc3XorqYIKPJs35DNDpoAjkJTiVw86I9EMnxKwl2OyJzCc48RBvQd1emWck391dCE/JyeYLQ0Mrev1jg/RHT0wmjJXT3ninpwruN6yYTFlVXSBzGZioQEpAQ09s53M9KTNBYTe+DE+r2rILHscJx57jMRu90za92d2yYEx7JSAH7hIH0+ZlFV8Z5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdPHNrQ3n3OKUJHikSico2whZxJmvVuyzHmIDjf8nZE=;
 b=nl9tkxGMoKbiY7/6Tu8uSCy2PY0Lkt6fNTL3a1v7dOneuqswUA5lRjMAfbqaF4+lEu56chp76OM/+HDxUyMjuk/dRDkAspTZ2EPNN60jUp2+nnn5PUvW6EUO6DHGn/vyhwSe/UqTsQkwDMdh+99KSMfQfzvoIr4OeR4K0/HajpEUOfBQvnWn5vpHf0/1Cxvbnp7MGRcry+srnVy2ZqflqERIyi/GJVbrt9+Pjjp2Hz5ar8r0HJOtWbBg11xMExodkHbE/3UGg89Q3DHL1IwXts/utYuB74B4tTRyWCWQBrCbKqr20coWC9CgywPrqcmj6K9biQaz11uegDWV4jUGPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:34 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:34 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH 16/26] hw/rtc: Add PolarFire SoC RTC model
Date: Thu, 23 Jul 2026 23:18:43 +0800
Message-Id: <20260723151853.2143177-17-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 7791cdce-366e-446e-48e0-08dee8cdcd05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: SXrGjwjz12bY+mwZOWuxqvgtjap7kPUnHWha56Umc/EKIeayD0Uv5F+3XaTXIpDqIxKhPi7zy6NeGH0VmNx/wDsStj6dllmL8Ro3ZSQMOCtglj6iTUhRq0tBsU0dSLQsBlVudG+PYCZzs3o2357UlNnDJJJAYhmq/7Il3JUYtK/M48F0PQVD+LFwvMJV2Le+4KLBQ/fPmZE2cvunkHdX3J3ih1+D2ilozQFUS9SIcgMzIQyFtI7Vq67ggtuStQtNSoJBWaABKnXXR5LZyCm4//5/xV54M5AGuMyyi5SgAf+5M1ypEV+54fTY2d3WF8Ee5yhYYQGnK0Hru+6aKjsw+F4+7nExqlC2pHQAMLieL406qWBqbgBepwtUlD/GvDziBHo4LOg7954HAjHrmH5PjD/GPv6tHSvd+qdF72cAE2IHGq0lA6eOSA2Yp7mRbDvg4/t/iV53grIoxlAMHW3m1SeHemmLRul+70ZJSjuyyJ1TRzCzwvV/E/YuVVjcr+Ijqj3gIgDh4azpiPZGRY6CU16xTmTW+X74oMlQyZtMw4LdmVDVAiv/0BsXtkqveFWeikxkf4+x6p7/511XVSB1SvKkBEsZMQmXGvlGPYwQ3yiWZjqabddcNq9l5EWu2UL06QuOSuhiP75i06Y6IQ9VR666nW9SmQ4d59xkeii6JRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4PLI32tYXt3Veyh/m9s9cKsrcLq3VtcS5k9xE2/hqxRuc/g/CYTh+QHmPB5Z?=
 =?us-ascii?Q?sncP21e98Khd/1pcPhzhKnKrKhFZxYRUweoXo3nhxsjNHfqJUgdrGAq+N6K8?=
 =?us-ascii?Q?5sr+U8LrwzTlMzS4y9sucu7cEygzZVlDMRLP//IVlwziG5N1a832+lEmRmAk?=
 =?us-ascii?Q?yPKJvrHrzuvfXVmmfwmQeKsTX2chmKd6t2OZ3/MFLie+Q9mBQOKTGBVxfIQL?=
 =?us-ascii?Q?wT3BMbJcz3PwooQ3UMnH7Z1ARjcCYScM88NwhT4bih/zrWR/0fi0aO+YRbhI?=
 =?us-ascii?Q?CI8ueD78kmAS5CRvSFH7iFWMXTjIVue36IhubM8EqD2zd3tiH5YRlQ6rzBZj?=
 =?us-ascii?Q?biU2RBcoFV4HXbxvMeojYH7uU5JHxamb9B/exSGGiQHhfwoLPtUEy0uOne4a?=
 =?us-ascii?Q?iznZfMiwFhMqzovRjJv4RApqU7n5N/LAM04nmCKZfGuyvO+ylyjIRyYPlr5U?=
 =?us-ascii?Q?9/2x7oPqPTK0E/hvHaVWVcALyXgkFMK2YLfxgZlwq6QhygBC7suB8wjFzGGw?=
 =?us-ascii?Q?NIn0ua08f+VvnMnyo3ylGheVqZw81bIuxuQ7aDn1h93vlCUtVOGMVzl0Z9Qr?=
 =?us-ascii?Q?gvG642dm8bZnAj/MYjtsqSQDRiVIAGIXWoEZwCeHCLn7OUkduds534krR76N?=
 =?us-ascii?Q?f/k8SSJ2N6Cixdt9I3ubP3SbbZh2aZpP3KIUIbNuWAYRtWoNn708Lp9B7fq7?=
 =?us-ascii?Q?prYcsGd6Z2aokRmNt9ZD4gk8hMIcEN3nfN0nFetwNDhP3JK8HFxTuK9bMyG2?=
 =?us-ascii?Q?XOo9A4u2I/FvzgohWP37LwOkgKhWx++2tbgBbhLq9ADLpJWuc2g6extxQn7p?=
 =?us-ascii?Q?DvoUEo4U1zHB5QSWUKaUeWz+aZ9/Tn+V8Rn6ibtPmu/Y8UYOHBwF91I6sXow?=
 =?us-ascii?Q?57WJCKhGfKERTSeaoViCGEWr7GxIP4tjBhQ9pvhxlAgC4VI9KOksXNWlj/wY?=
 =?us-ascii?Q?elpQ0/WIdiTIaH4R0WHegeLwztpzBYEimDgB0rHP++WLbb589QVu3Cdt2lB2?=
 =?us-ascii?Q?uSicSLuzGf168Oy5ElJ02UF0YDQkNOnDCKMwUzv8RhZ6GBsrWbRLwWgpsyAx?=
 =?us-ascii?Q?V5FPGTQCbGHj9/SUgNQXIflVk6yGcbZUBwsUm3RDE+Rn5ApocxdfwfM2OOmO?=
 =?us-ascii?Q?vejVf8H60f02iu8Gl+isfghmTVpxS3laWD46zkJRpqW96dzuY+n9jRfkspeT?=
 =?us-ascii?Q?mVCBOk1DsXEr3eP9Cq5JLD7fodHYRGy3jFi+VPgEL3co2cH06Xa0Yhoni6Fl?=
 =?us-ascii?Q?k6vFpTABHrj9bJavpZ+pDeHMa855pZN3RSISeKX3PSnpBywiLr7llUiiWI55?=
 =?us-ascii?Q?6COVGU4iJg293aJ3Psur7ZKywq43IROnh6h1Enc/3wmcj1gnbNKc7pFFJi0D?=
 =?us-ascii?Q?R2/gscl/W0IrQDIon3GV7cgQYThg/W2tixOtL8ll0YwpVZ2V1US/i8JvPCeQ?=
 =?us-ascii?Q?8YzxQcHpTYWe9aiw+7aLtWu3FRkX0nsGIOxWceCwJd8tIVWL8sI/3BdUadQP?=
 =?us-ascii?Q?H1JepZmmw2Jwvx7hedQee4ep1WOYbl/lLiRNlIfsEL7tOFsB95zeyljb96P6?=
 =?us-ascii?Q?d+5N23U1dLIwcA9ee9Ke7kxwPZYzixuio9znpSDqXVpJqdyk4qLC/jHMso2g?=
 =?us-ascii?Q?R3PS7wg0sijqA8FaUCLvlyTm9YyFJzwrqEViCdAKHoVq2NSVBHyHs6bCGQXR?=
 =?us-ascii?Q?2ksL08BT4OvQLZvzrNg2dwl8Jyx3fqZCtrAg6IDNOISw4R1aoR8V8jM3aEqc?=
 =?us-ascii?Q?UdxJTXrdhiaD69OXsp4Ju+/W3etQFPo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7791cdce-366e-446e-48e0-08dee8cdcd05
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:34.1622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maZb+wn1KtnjkAVcpT/ekADXFcu+wh8mB2ww/+y4Py23iD1O8HrkrjTXDghmoKbdnyGmsliFgymJZ0O1+y+c0WD74kQuBIHLswp9dxePphQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
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

The PolarFire SoC exposes an RTC with binary and calendar modes,
programmable prescaling, alarms, and wakeup and match interrupts.

Add a standalone device model with explicit MMIO handling for time,
commands, alarms, interrupt state, reset, and migration. Add its
Kconfig and Meson entries and list it under the PolarFire SoC
maintainer section.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 MAINTAINERS                     |   2 +
 include/hw/rtc/mchp_pfsoc_rtc.h |  46 +++
 hw/rtc/mchp_pfsoc_rtc.c         | 479 ++++++++++++++++++++++++++++++++
 hw/rtc/Kconfig                  |   3 +
 hw/rtc/meson.build              |   1 +
 5 files changed, 531 insertions(+)
 create mode 100644 include/hw/rtc/mchp_pfsoc_rtc.h
 create mode 100644 hw/rtc/mchp_pfsoc_rtc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e36594d4fd..c4026832d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1772,12 +1772,14 @@ F: hw/misc/mchp_pfsoc_dmc.c
 F: hw/misc/mchp_pfsoc_ioscb.c
 F: hw/misc/mchp_pfsoc_l2cc.c
 F: hw/misc/mchp_pfsoc_sysreg.c
+F: hw/rtc/mchp_pfsoc_rtc.c
 F: include/hw/riscv/microchip_pfsoc.h
 F: include/hw/char/mchp_pfsoc_mmuart.h
 F: include/hw/misc/mchp_pfsoc_dmc.h
 F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_l2cc.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
+F: include/hw/rtc/mchp_pfsoc_rtc.h
 F: tests/qtest/mchp_pfsoc_l2cc_test.c
 
 Shakti C class SoC
diff --git a/include/hw/rtc/mchp_pfsoc_rtc.h b/include/hw/rtc/mchp_pfsoc_rtc.h
new file mode 100644
index 0000000000..17bc6ddcdc
--- /dev/null
+++ b/include/hw/rtc/mchp_pfsoc_rtc.h
@@ -0,0 +1,46 @@
+/*
+ * Microchip PolarFire SoC RTC
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RTC_MCHP_PFSOC_RTC_H
+#define HW_RTC_MCHP_PFSOC_RTC_H
+
+#include "hw/core/sysbus.h"
+#include "qemu/timer.h"
+#include "qom/object.h"
+
+#define TYPE_MCHP_PFSOC_RTC "mchp.pfsoc.rtc"
+OBJECT_DECLARE_SIMPLE_TYPE(MchpPfSoCRtcState, MCHP_PFSOC_RTC)
+
+#define MCHP_PFSOC_RTC_REGS 28
+
+struct MchpPfSoCRtcState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq_wakeup;
+    qemu_irq irq_match;
+    QEMUTimer *alarm_timer;
+
+    int64_t tick_offset;
+    int64_t tick_offset_vmstate;
+    uint64_t frozen_count;
+    uint64_t read_latch;
+    bool running;
+    bool alarm_enabled;
+    bool wakeup_pending;
+    bool match_pending;
+    bool updated;
+    bool read_latch_valid;
+
+    uint32_t regs[MCHP_PFSOC_RTC_REGS];
+};
+
+#endif /* HW_RTC_MCHP_PFSOC_RTC_H */
diff --git a/hw/rtc/mchp_pfsoc_rtc.c b/hw/rtc/mchp_pfsoc_rtc.c
new file mode 100644
index 0000000000..087fd1f5ce
--- /dev/null
+++ b/hw/rtc/mchp_pfsoc_rtc.c
@@ -0,0 +1,479 @@
+/*
+ * Microchip PolarFire SoC RTC
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
+#include "hw/rtc/mchp_pfsoc_rtc.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "system/rtc.h"
+#include "system/system.h"
+
+#define RTC_MMIO_SIZE               0x1000
+#define RTC_CONTROL_MASK            0x000007ff
+#define RTC_MODE_MASK               0x0000000f
+#define RTC_PRESCALER_MASK          0x03ffffff
+#define RTC_ALARM_UPPER_MASK        0x000007ff
+#define RTC_UPPER_MASK              0x3fffffff
+#define RTC_CALENDAR_MASK           0x000000ff
+
+#define RTC_CONTROL                 0x00
+#define RTC_CONTROL_START_RUNNING   BIT(0)
+#define RTC_CONTROL_STOP            BIT(1)
+#define RTC_CONTROL_ALARM_ON        BIT(2)
+#define RTC_CONTROL_ALARM_OFF       BIT(3)
+#define RTC_CONTROL_RESET           BIT(4)
+#define RTC_CONTROL_UPLOAD          BIT(5)
+#define RTC_CONTROL_DOWNLOAD        BIT(6)
+#define RTC_CONTROL_MATCH           BIT(7)
+#define RTC_CONTROL_WAKEUP_CLEAR    BIT(8)
+#define RTC_CONTROL_WAKEUP_SET      BIT(9)
+#define RTC_CONTROL_UPDATED         BIT(10)
+
+#define RTC_MODE                    0x04
+#define RTC_MODE_CLOCK_CALENDAR     BIT(0)
+#define RTC_MODE_WAKEUP_ENABLE      BIT(1)
+#define RTC_MODE_WAKEUP_RESET       BIT(2)
+#define RTC_MODE_WAKEUP_CONTINUE    BIT(3)
+
+#define RTC_PRESCALER               0x08
+#define RTC_ALARM_LOWER             0x0c
+#define RTC_ALARM_UPPER             0x10
+#define RTC_COMPARE_LOWER           0x14
+#define RTC_COMPARE_UPPER           0x18
+#define RTC_DATETIME_LOWER          0x20
+#define RTC_DATETIME_UPPER          0x24
+#define RTC_SECONDS                 0x30
+#define RTC_MINUTES                 0x34
+#define RTC_HOURS                   0x38
+#define RTC_DAY                     0x3c
+#define RTC_MONTH                   0x40
+#define RTC_YEAR                    0x44
+#define RTC_WEEKDAY                 0x48
+#define RTC_WEEK                    0x4c
+#define RTC_SECONDS_COUNT           0x50
+#define RTC_MINUTES_COUNT           0x54
+#define RTC_HOURS_COUNT             0x58
+#define RTC_DAY_COUNT               0x5c
+#define RTC_MONTH_COUNT             0x60
+#define RTC_YEAR_COUNT              0x64
+#define RTC_WEEKDAY_COUNT           0x68
+#define RTC_WEEK_COUNT              0x6c
+
+#define RTC_REG(offset) ((offset) / sizeof(uint32_t))
+
+static uint64_t mchp_pfsoc_rtc_get_count(MchpPfSoCRtcState *s)
+{
+    if (!s->running) {
+        return s->frozen_count;
+    }
+
+    return s->tick_offset +
+           qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+}
+
+static void mchp_pfsoc_rtc_set_count(MchpPfSoCRtcState *s, uint64_t count)
+{
+    if (s->running) {
+        s->tick_offset = (int64_t)count -
+            qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+    } else {
+        s->frozen_count = count;
+    }
+}
+
+static void mchp_pfsoc_rtc_update_irq(MchpPfSoCRtcState *s)
+{
+    qemu_set_irq(s->irq_wakeup, s->wakeup_pending);
+    qemu_set_irq(s->irq_match, s->match_pending);
+}
+
+static void mchp_pfsoc_rtc_schedule_alarm(MchpPfSoCRtcState *s);
+
+static void mchp_pfsoc_rtc_alarm(void *opaque)
+{
+    MchpPfSoCRtcState *s = opaque;
+    bool periodic = s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_WAKEUP_RESET;
+
+    s->alarm_enabled = periodic;
+    s->match_pending = true;
+    if (s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_WAKEUP_ENABLE) {
+        s->wakeup_pending = true;
+    }
+    if (s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_WAKEUP_RESET) {
+        mchp_pfsoc_rtc_set_count(s, 0);
+    }
+    if (!(s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_WAKEUP_CONTINUE)) {
+        s->frozen_count = mchp_pfsoc_rtc_get_count(s);
+        s->running = false;
+    }
+    mchp_pfsoc_rtc_update_irq(s);
+    if (periodic) {
+        mchp_pfsoc_rtc_schedule_alarm(s);
+    }
+}
+
+static void mchp_pfsoc_rtc_schedule_alarm(MchpPfSoCRtcState *s)
+{
+    uint64_t compare_mask;
+    uint64_t target;
+    uint64_t now;
+    uint64_t delta;
+
+    timer_del(s->alarm_timer);
+    if (!s->alarm_enabled || !s->running ||
+        (s->regs[RTC_REG(RTC_MODE)] & RTC_MODE_CLOCK_CALENDAR)) {
+        return;
+    }
+
+    compare_mask = s->regs[RTC_REG(RTC_COMPARE_LOWER)] |
+        ((uint64_t)(s->regs[RTC_REG(RTC_COMPARE_UPPER)] &
+                    RTC_UPPER_MASK) << 32);
+    if (compare_mask != MAKE_64BIT_MASK(0, 62)) {
+        return;
+    }
+
+    target = s->regs[RTC_REG(RTC_ALARM_LOWER)] |
+        ((uint64_t)(s->regs[RTC_REG(RTC_ALARM_UPPER)] &
+                    RTC_ALARM_UPPER_MASK) << 32);
+    now = mchp_pfsoc_rtc_get_count(s);
+    if (target <= now) {
+        mchp_pfsoc_rtc_alarm(s);
+        return;
+    }
+
+    delta = target - now;
+    if (delta > INT64_MAX / NANOSECONDS_PER_SECOND) {
+        return;
+    }
+    timer_mod(s->alarm_timer,
+              qemu_clock_get_ns(rtc_clock) + delta * NANOSECONDS_PER_SECOND);
+}
+
+static void mchp_pfsoc_rtc_control_write(MchpPfSoCRtcState *s,
+                                         uint32_t value)
+{
+    uint64_t count;
+
+    value &= RTC_CONTROL_MASK;
+    if (value & RTC_CONTROL_UPDATED) {
+        s->updated = false;
+    }
+    if (value & RTC_CONTROL_RESET) {
+        mchp_pfsoc_rtc_set_count(s, 0);
+        s->updated = true;
+    }
+    if (value & RTC_CONTROL_UPLOAD) {
+        count = s->regs[RTC_REG(RTC_DATETIME_LOWER)] |
+            ((uint64_t)(s->regs[RTC_REG(RTC_DATETIME_UPPER)] &
+                        RTC_UPPER_MASK) << 32);
+        mchp_pfsoc_rtc_set_count(s, count);
+        s->updated = true;
+    }
+    if (value & RTC_CONTROL_DOWNLOAD) {
+        count = mchp_pfsoc_rtc_get_count(s);
+        s->regs[RTC_REG(RTC_DATETIME_LOWER)] = count;
+        s->regs[RTC_REG(RTC_DATETIME_UPPER)] = count >> 32;
+    }
+    if ((value & RTC_CONTROL_START_RUNNING) && !s->running) {
+        s->tick_offset = (int64_t)s->frozen_count -
+            qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+        s->running = true;
+    }
+    if ((value & RTC_CONTROL_STOP) && s->running) {
+        s->frozen_count = mchp_pfsoc_rtc_get_count(s);
+        s->running = false;
+    }
+    if (value & RTC_CONTROL_ALARM_OFF) {
+        s->alarm_enabled = false;
+        s->wakeup_pending = false;
+        s->match_pending = false;
+        timer_del(s->alarm_timer);
+    } else if (value & RTC_CONTROL_ALARM_ON) {
+        s->alarm_enabled = true;
+    }
+    if (value & RTC_CONTROL_WAKEUP_CLEAR) {
+        s->wakeup_pending = false;
+        s->match_pending = false;
+    }
+    if (value & RTC_CONTROL_WAKEUP_SET) {
+        s->wakeup_pending = true;
+    }
+
+    mchp_pfsoc_rtc_update_irq(s);
+    mchp_pfsoc_rtc_schedule_alarm(s);
+}
+
+static uint32_t mchp_pfsoc_rtc_control_read(MchpPfSoCRtcState *s)
+{
+    uint32_t value;
+
+    value = s->running ? RTC_CONTROL_START_RUNNING : 0;
+    if (s->alarm_enabled) {
+        value |= RTC_CONTROL_ALARM_ON;
+    }
+    if (s->match_pending) {
+        value |= RTC_CONTROL_MATCH;
+    }
+    if (s->updated) {
+        value |= RTC_CONTROL_UPDATED;
+    }
+    return value;
+}
+
+static uint32_t mchp_pfsoc_rtc_datetime_lower_read(MchpPfSoCRtcState *s)
+{
+    s->read_latch = mchp_pfsoc_rtc_get_count(s);
+    s->read_latch_valid = true;
+    return (uint32_t)s->read_latch;
+}
+
+static uint32_t mchp_pfsoc_rtc_datetime_upper_read(MchpPfSoCRtcState *s)
+{
+    uint64_t count = s->read_latch_valid ? s->read_latch :
+                     mchp_pfsoc_rtc_get_count(s);
+
+    s->read_latch_valid = false;
+    return (count >> 32) & RTC_UPPER_MASK;
+}
+
+static uint64_t mchp_pfsoc_rtc_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    MchpPfSoCRtcState *s = opaque;
+
+    switch (offset) {
+    case RTC_CONTROL:
+        return mchp_pfsoc_rtc_control_read(s);
+    case RTC_DATETIME_LOWER:
+        return mchp_pfsoc_rtc_datetime_lower_read(s);
+    case RTC_DATETIME_UPPER:
+        return mchp_pfsoc_rtc_datetime_upper_read(s);
+    case RTC_MODE:
+    case RTC_PRESCALER:
+    case RTC_ALARM_LOWER:
+    case RTC_ALARM_UPPER:
+    case RTC_COMPARE_LOWER:
+    case RTC_COMPARE_UPPER:
+    case RTC_SECONDS:
+    case RTC_MINUTES:
+    case RTC_HOURS:
+    case RTC_DAY:
+    case RTC_MONTH:
+    case RTC_YEAR:
+    case RTC_WEEKDAY:
+    case RTC_WEEK:
+    case RTC_SECONDS_COUNT:
+    case RTC_MINUTES_COUNT:
+    case RTC_HOURS_COUNT:
+    case RTC_DAY_COUNT:
+    case RTC_MONTH_COUNT:
+    case RTC_YEAR_COUNT:
+    case RTC_WEEKDAY_COUNT:
+    case RTC_WEEK_COUNT:
+        return s->regs[RTC_REG(offset)];
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+                      "(size %d, offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, offset);
+        return 0;
+    }
+}
+
+static void mchp_pfsoc_rtc_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    MchpPfSoCRtcState *s = opaque;
+    bool update_alarm = false;
+
+    switch (offset) {
+    case RTC_CONTROL:
+        mchp_pfsoc_rtc_control_write(s, value);
+        return;
+    case RTC_MODE:
+        s->regs[RTC_REG(offset)] = value & RTC_MODE_MASK;
+        update_alarm = true;
+        break;
+    case RTC_PRESCALER:
+        s->regs[RTC_REG(offset)] = value & RTC_PRESCALER_MASK;
+        break;
+    case RTC_ALARM_LOWER:
+    case RTC_COMPARE_LOWER:
+        s->regs[RTC_REG(offset)] = value;
+        update_alarm = true;
+        break;
+    case RTC_ALARM_UPPER:
+        s->regs[RTC_REG(offset)] = value & RTC_ALARM_UPPER_MASK;
+        update_alarm = true;
+        break;
+    case RTC_COMPARE_UPPER:
+        s->regs[RTC_REG(offset)] = value & RTC_UPPER_MASK;
+        update_alarm = true;
+        break;
+    case RTC_DATETIME_LOWER:
+        s->regs[RTC_REG(offset)] = value;
+        break;
+    case RTC_DATETIME_UPPER:
+        s->regs[RTC_REG(offset)] = value & RTC_UPPER_MASK;
+        break;
+    case RTC_SECONDS:
+    case RTC_MINUTES:
+    case RTC_HOURS:
+    case RTC_DAY:
+    case RTC_MONTH:
+    case RTC_YEAR:
+    case RTC_WEEKDAY:
+    case RTC_WEEK:
+        s->regs[RTC_REG(offset)] = value & RTC_CALENDAR_MASK;
+        break;
+    case RTC_SECONDS_COUNT:
+    case RTC_MINUTES_COUNT:
+    case RTC_HOURS_COUNT:
+    case RTC_DAY_COUNT:
+    case RTC_MONTH_COUNT:
+    case RTC_YEAR_COUNT:
+    case RTC_WEEKDAY_COUNT:
+    case RTC_WEEK_COUNT:
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                      "(size %d, value 0x%" PRIx64
+                      ", offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, value, offset);
+        return;
+    }
+
+    if (update_alarm) {
+        mchp_pfsoc_rtc_schedule_alarm(s);
+    }
+}
+
+static const MemoryRegionOps mchp_pfsoc_rtc_ops = {
+    .read = mchp_pfsoc_rtc_read,
+    .write = mchp_pfsoc_rtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+};
+
+static void mchp_pfsoc_rtc_reset(DeviceState *dev)
+{
+    MchpPfSoCRtcState *s = MCHP_PFSOC_RTC(dev);
+    struct tm tm;
+
+    timer_del(s->alarm_timer);
+    s->running = true;
+    s->alarm_enabled = false;
+    s->wakeup_pending = false;
+    s->match_pending = false;
+    s->updated = false;
+    s->read_latch_valid = false;
+    memset(s->regs, 0, sizeof(s->regs));
+
+    qemu_get_timedate(&tm, 0);
+    s->tick_offset = mktimegm(&tm) -
+        qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+    s->frozen_count = 0;
+    s->read_latch = mchp_pfsoc_rtc_get_count(s);
+    mchp_pfsoc_rtc_update_irq(s);
+}
+
+static int mchp_pfsoc_rtc_pre_save(void *opaque)
+{
+    MchpPfSoCRtcState *s = opaque;
+    int64_t delta = qemu_clock_get_ns(rtc_clock) /
+                    NANOSECONDS_PER_SECOND -
+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
+                    NANOSECONDS_PER_SECOND;
+
+    s->tick_offset_vmstate = s->tick_offset + delta;
+    return 0;
+}
+
+static int mchp_pfsoc_rtc_post_load(void *opaque, int version_id)
+{
+    MchpPfSoCRtcState *s = opaque;
+    int64_t delta = qemu_clock_get_ns(rtc_clock) /
+                    NANOSECONDS_PER_SECOND -
+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
+                    NANOSECONDS_PER_SECOND;
+
+    s->tick_offset = s->tick_offset_vmstate - delta;
+    s->read_latch_valid = false;
+    mchp_pfsoc_rtc_update_irq(s);
+    mchp_pfsoc_rtc_schedule_alarm(s);
+    return 0;
+}
+
+static const VMStateDescription vmstate_mchp_pfsoc_rtc = {
+    .name = TYPE_MCHP_PFSOC_RTC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save = mchp_pfsoc_rtc_pre_save,
+    .post_load = mchp_pfsoc_rtc_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, MchpPfSoCRtcState,
+                             MCHP_PFSOC_RTC_REGS),
+        VMSTATE_INT64(tick_offset_vmstate, MchpPfSoCRtcState),
+        VMSTATE_UINT64(frozen_count, MchpPfSoCRtcState),
+        VMSTATE_BOOL(running, MchpPfSoCRtcState),
+        VMSTATE_BOOL(alarm_enabled, MchpPfSoCRtcState),
+        VMSTATE_BOOL(wakeup_pending, MchpPfSoCRtcState),
+        VMSTATE_BOOL(match_pending, MchpPfSoCRtcState),
+        VMSTATE_BOOL(updated, MchpPfSoCRtcState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void mchp_pfsoc_rtc_init(Object *obj)
+{
+    MchpPfSoCRtcState *s = MCHP_PFSOC_RTC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &mchp_pfsoc_rtc_ops, s,
+                          TYPE_MCHP_PFSOC_RTC, RTC_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq_wakeup);
+    sysbus_init_irq(sbd, &s->irq_match);
+    s->alarm_timer = timer_new_ns(rtc_clock, mchp_pfsoc_rtc_alarm, s);
+}
+
+static void mchp_pfsoc_rtc_finalize(Object *obj)
+{
+    MchpPfSoCRtcState *s = MCHP_PFSOC_RTC(obj);
+
+    timer_free(s->alarm_timer);
+}
+
+static void mchp_pfsoc_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, mchp_pfsoc_rtc_reset);
+    dc->vmsd = &vmstate_mchp_pfsoc_rtc;
+}
+
+static const TypeInfo mchp_pfsoc_rtc_info = {
+    .name = TYPE_MCHP_PFSOC_RTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MchpPfSoCRtcState),
+    .instance_init = mchp_pfsoc_rtc_init,
+    .instance_finalize = mchp_pfsoc_rtc_finalize,
+    .class_init = mchp_pfsoc_rtc_class_init,
+};
+
+static void mchp_pfsoc_rtc_register_types(void)
+{
+    type_register_static(&mchp_pfsoc_rtc_info);
+}
+
+type_init(mchp_pfsoc_rtc_register_types)
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 315b0e4ecc..0d53546adc 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -14,6 +14,9 @@ config M48T59
 config PL031
     bool
 
+config MCHP_PFSOC_RTC
+    bool
+
 config MC146818RTC
     depends on ISA_BUS
     bool
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index 6c87864dc0..4a666bfc94 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -3,6 +3,7 @@ system_ss.add(when: 'CONFIG_DS1338', if_true: files('ds1338.c'))
 system_ss.add(when: 'CONFIG_M41T80', if_true: files('m41t80.c'))
 system_ss.add(when: 'CONFIG_M48T59', if_true: files('m48t59.c'))
 system_ss.add(when: 'CONFIG_PL031', if_true: files('pl031.c'))
+system_ss.add(when: 'CONFIG_MCHP_PFSOC_RTC', if_true: files('mchp_pfsoc_rtc.c'))
 system_ss.add(when: ['CONFIG_ISA_BUS', 'CONFIG_M48T59'], if_true: files('m48t59-isa.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-rtc.c'))
 
-- 
2.34.1


