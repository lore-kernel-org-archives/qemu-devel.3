Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3421C79F8B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJp-00059Y-63; Fri, 04 Sep 2026 11:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJg-00053y-V1; Fri, 04 Sep 2026 11:59:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJe-0004Sx-84; Fri, 04 Sep 2026 11:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hu7Clq7gu0wtZcWWLnSVwY7dbV4OUeFzwUGhGEGrQmBzE65tQUngMekXmQayxSrIwn5dtj38fqLW3PxdF5IN5uBHCWEsRvpdEXrT4VCtQQomX8Zjv3DKPB+9PkQ1JVuFsulsBIT1OwuNbB6QU3vn4H5C+KLlYqY2LXv0EwI8Dl8Qanvs4b57AaBWS0NJKv+kSXvukmL0bGgCeFq81RZsNCoTNcfAaA4iq1QguBGKGfsqUweUXvLidTrxg2JkWes1tIM+xpDkLYwqjrOYWAoJoW8Bv5XwR9ul3Z99e+89LPLGRUOGPZCz80d9zpuqNoN3D0s3PT1+znWeAfP3AkMjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1c5GJ9VPPGPE9uEK5gMDBeqGhnOLRLClbJMfSxqgMk=;
 b=GHiVZQnuPLTBjdMQ5/m0YF+LL9d1CK1kWbJ2wZRB5H3rMLKmKFsySUbW3flLuDBpKXyvGlzwAzwUzGo8EgyhuNJvfQYGDPMtXCxPi4NPm6JDQ3glVV6D3QVcYtIm0hb/v+eRMgjDE3UQPFVoUNqd9gKKTglXiBfiUHjfkE6zNCa4nWe65mq54kWw5a2MChyEhKAaogLOJCXLph2tajA/Bt579ay7WhF4GgDoQRYbeog8eam7WINBVHbRSTXRPg2Ua9SJvl3mb9C138X/XZzXfudEFp6kYBmIKptAqqrYyKECsp0dLmz9xHlc5qsDPB+wuPpuHjVGzqR9q+hadNU8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1c5GJ9VPPGPE9uEK5gMDBeqGhnOLRLClbJMfSxqgMk=;
 b=foEYVYBSpwDWWvyfl8FRszmUVacYv29kyjV8mvUF1X8Hoz/s4CvpwDNUvHnhgC/OQHJLcZeP3yNNOCltdUkCCa2RhV3cCnkU+/mqx33Iw0siuu4DK16W5VcmmjctXzz0mxLcj4HtSu42Lc3kQdXApobF7l0F9aAE4uyLzUN1KAclovKCRvhXv0MF2IzbTzjtKc8sxhhpED+O6Z6l/OY2ACz9KS6oWsrlCMxCPFqIoXYCxtHE0m1y61pyJp4LfUwm2XgAPosEUsXUE+nlYapkV3KjgtvRngbkgPKhkEPSvuYpalxn/2Ssu76HXpxj72vfgmeIIB7RJxHSvCPKHqNDzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:51 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:51 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v2 13/24] hw/rtc: Add PolarFire SoC RTC model
Date: Fri,  4 Sep 2026 23:57:32 +0800
Message-ID: <20260904155758.3833179-14-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d45b2e-1983-42af-0043-08df0a9d69a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: yNbUEP/j3z/4X8A9J74j0r2khVBC7olSlE0KbzEcY3UWCG6gdbR0mrkoN/+Y12eQwGiscE6/FDFSl93Gf1gyGgQkJC8QalaGH7Tx605FSYqUqeu+czYod9E+Q4Z2zT+NBLm9yvTfsR7811Z40Nl3LkJ5dD4wcLAcqIXbYK1cZfV71jSdwM2BVJPQA5HsPdlj4dvBz/gY3UXsvsk1fijDr5wtgAcAA4inKbM+NVzCsl1FViHCMrb3QBUASC7TqxalM6skUjTM9g9nsy16v++BbwOzQVkhZ/RJVR+6xAob3Tk03VZ73xxpzYfvWHcHvM1ZnsTHOKeYa6onNDuSTKp6tMu88rARyv/7zc6bNSF2PEjRcxkr0SY6rqW4aHxcq9S+vk1X5jL0sfQ6pR3Z6+8MAWk5rwzyKuVgwOaVMiglBsQLIDoOV0EfoBYQFZaf2BFBy7tOn0qmBtXlxSI+5rz1VOYIYurJq1y0TNK5ZLtl6bIjIA0IlxGiM2AnojN5XG/KSCbzPdCwQNK20vfYDF7SiORFoxspSoroK/GI0LlYtvtfTKDB68osbU2dxtKCch+kPMe1xoyd/jfEL8VomJo04SHET0hScCLRHpTmSF1aDqn9jfjBFYlRC8yNA/isMsVR4/8ySs5zTdzLD9o+SCoKxMAYHnpEWSGYJDxF1s2dhsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DkGT0WKDFtAZDgKrBCy5GH5PxGeLanYHvFGxZeLrk05wukbmFnGuXyCTJQyt?=
 =?us-ascii?Q?1mNdiGkNd8gNjcxUNk+bQZ45aUZ5drSfF9kmCQPL54/nC43/KN0aktjen21O?=
 =?us-ascii?Q?flxfpAqbeogsLxvCH/xubt3kIVDHz1TU48csqICr7SMHl/PLC1rcwgTF4nWg?=
 =?us-ascii?Q?0h7v+czxpsbtfKSMpjFP+Bicku6ai+n5xuSAwkSz2GCIHNlGySGZ+lwEUA3l?=
 =?us-ascii?Q?gSbLPoUYXgaX9q3xJHWXFXwpn8CNOMGZQpb7d/KjvkCEI6rHwYTiVdX6MI44?=
 =?us-ascii?Q?cNyeDqbLoM0OxMC5+Rs67nxIbUyyH1vgKO+QILBOGUwU5Nns273Dzs0XOQsE?=
 =?us-ascii?Q?rHWev7RYXHo0Ecsw6tL1ZJYXb6G82gW63K00b3/aw87L1+fCPUl9BbgsD2GJ?=
 =?us-ascii?Q?R656ktsqiHl4Cl6qa4XIc3Va3o5M8rsf1ParK1xHnqmvyseC+ImXjTdsyoRZ?=
 =?us-ascii?Q?E3Ibfwd3IRA+LWSLmCBq0wf1NHdiN8P3aqxgqcYtTqs0/X0ZKhYi1vGJwFrO?=
 =?us-ascii?Q?nqagg/x49Uv+ngmr0nd7rYh74RWaJL4/Jf3LSd8JehHDjSKZ+srLAgcHlpLw?=
 =?us-ascii?Q?iB7rpyvmP9PCg0W88sL0RPesx9pVPZSLTWW0RtGygprGJm7miW7c5jzOu3Da?=
 =?us-ascii?Q?OsSa+D7IuZi++Z3lQrQz/SePf5ZeTdAL9SSA5g3D68+01eGA4cBALZ8Ra/S7?=
 =?us-ascii?Q?r0FYfBtLcehhGeEkWG5F+gbR24Yhu5TOZeaHS9PdnYjzUu3YuUnKesBXzWe6?=
 =?us-ascii?Q?D3HaLxVrRlainSU4MyeYQZIoU9dNM3/fUP4e/56qEs0d8YzF0S7QSRw9CDfz?=
 =?us-ascii?Q?ef9KELcTJyskYpQF6nI0wNVQ1Z6V9IBF3KGDSli6/EH/B4BDfdJ/fNmF4X4L?=
 =?us-ascii?Q?/CKyFhdZWt3xWuZopYhKyvJwAuwGCNrHVA8J5oLLBI2UAuef6wGyq7Vqq084?=
 =?us-ascii?Q?CZNaCfXTro69vK4Uz2QavLApiW98AnkPt1UarMHol1TZGsMntiG92/vls8id?=
 =?us-ascii?Q?m4C+DZymJdwlPCCwZt+PJFmpDq54NovT8QFjDX8n0vKvW9Bu/r5C89UMhLR9?=
 =?us-ascii?Q?dHXAxQPLPpGiE3hKrClQnszQmDKjYdliCfqU0DEX4FPT5BVlBgAWOqRvIDgd?=
 =?us-ascii?Q?ZvfOdyHfHz0DjDLeOVMw92IwOjNJGBnbPJNemON5L4wTq8jK3SchKe9ehY0G?=
 =?us-ascii?Q?dBKf/wXo1mt4EeP9SbGfLeoUPam0uwcHc980RwTelZoUQU79VB4G0xTTBkgX?=
 =?us-ascii?Q?boQv3bIVM+sjDwYsjSggF7s2jKxFF84t7l4zlF2KNlUthZToR2imrODp5HUM?=
 =?us-ascii?Q?xb1SfJT66U0fwdGZP0IiCmmYz2a7AoktGvdI0cjcO+RJEs9B0rPPu1ek5l10?=
 =?us-ascii?Q?HFvjHF1RH9a3uVw5pgxfPUVW4Opv4gJpPjsbLJCnr4uYQBLvDpVL+N57PhgY?=
 =?us-ascii?Q?GsP81J6fxJTSIjUoxUvQuNlnygMO1Agbu2N2xufa/qU8fDpLROsxV8tkzffP?=
 =?us-ascii?Q?oYUfBr7ClthrDt6NP2hfd4fOKXqS1bEaL9iLBtjxckVCLiFd3LTA/dH201W9?=
 =?us-ascii?Q?kU00r3ky3vudeeYnZQWNb3ky8I0kBE5pGC4doBWS4D/BfpNU60274sQ8hGOD?=
 =?us-ascii?Q?PQC/gJP1TUPVkPYo+rMRCArJpB3TnQhJNTsmYCE3wiqZ+ady3FKyVIhEQbsq?=
 =?us-ascii?Q?AB1XLBkg7HE7WYF3JVSOFNvPoF+F/2E/mK14BH/FETe3hoSTdWx+QdHKRlAH?=
 =?us-ascii?Q?gzUPgGw+XsTWqe+RV8yqAI11hBxoU7Q=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d45b2e-1983-42af-0043-08df0a9d69a5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:51.0103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prg+5S/iXWD1aIYm131TmBEuc0CbMrE9CWDJP01PLtmCrGp1HFtJCR/dJqa3ZYFD3lVHmGoakr8x81VeYMaP9rpwpt1BlopgHwWcL3DcrQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reset the device to its documented hardware values, with the binary
counter stopped at zero.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Reset the RTC to the documented hardware values
- Use the Resettable API instead of a legacy reset handler

 MAINTAINERS                     |   2 +
 include/hw/rtc/mchp_pfsoc_rtc.h |  46 +++
 hw/rtc/mchp_pfsoc_rtc.c         | 477 ++++++++++++++++++++++++++++++++
 hw/rtc/Kconfig                  |   3 +
 hw/rtc/meson.build              |   1 +
 5 files changed, 529 insertions(+)
 create mode 100644 include/hw/rtc/mchp_pfsoc_rtc.h
 create mode 100644 hw/rtc/mchp_pfsoc_rtc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 58425dcad4..adc4a41266 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1797,12 +1797,14 @@ F: hw/misc/mchp_pfsoc_dmc.c
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
index 0000000000..f5068b15ef
--- /dev/null
+++ b/hw/rtc/mchp_pfsoc_rtc.c
@@ -0,0 +1,477 @@
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
+static void mchp_pfsoc_rtc_reset_hold(Object *obj, ResetType type)
+{
+    MchpPfSoCRtcState *s = MCHP_PFSOC_RTC(obj);
+
+    timer_del(s->alarm_timer);
+    s->running = false;
+    s->alarm_enabled = false;
+    s->wakeup_pending = false;
+    s->match_pending = false;
+    s->updated = false;
+    s->read_latch_valid = false;
+    memset(s->regs, 0, sizeof(s->regs));
+
+    s->tick_offset = 0;
+    s->frozen_count = 0;
+    s->read_latch = 0;
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
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = mchp_pfsoc_rtc_reset_hold;
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
2.53.0


