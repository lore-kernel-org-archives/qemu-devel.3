Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D521CC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHt-00087x-AC; Tue, 08 Sep 2026 06:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHr-00087K-Aw; Tue, 08 Sep 2026 06:42:47 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHp-0006YC-3Q; Tue, 08 Sep 2026 06:42:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM8ivCP/XSYEcstu9X0CZ5r/QhaA/HKBUpadFAn8bdxTAWSONsp7v2J+le0SWEx2EMfFV43HiHUW9KaRBuX4A862Qppm4MsDtPmiIVDa0zol4acfskx1T6fuUHwLJw+YcFKQTPqhg0Um8Xu7fQQnXnqyo20BzrpyOjqW8OzEh6QCDqPI867r8OFUh2pgZHDywX/ZcYs888c3ltOE6SCN6wAgyzmcd3xd4qi4Tmh8meP2+5xEbVVXQOTl/tVrdhskzLHwiXAUDyZ8Hikvy0GnwId7wLdv/dqBHFVVuQyhCh9pLXCvNzI7ikj1J1yC0m8q3KLERkx0P1OYgfaNb3Tuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sd60m13spMxWaSdy+kBqx661DMQWqfTAZKidVOdx2oI=;
 b=WwZWkig3MznUuZad4ViInUbaAwQykQ77ybD6hRn3CAe0Y1HDZFxkUAmxcO0FmU7Ji0/HMeCwRCjEJRsVxlNwvaUPIZTxuvZOZ0oqZMit44lwztJnCP5cU+FPIsNqALA1WbpJEMqKXM01jh9oGu6vdijP+nJBzYXPkepHSwACk8evyW+D2Oi9PIlJHRF4vCKqnG6REduXK/L7UQHcEDbxhkSXQzm2koxXUjUM3YwePnJQOL8KXsGh8c90mnGowAOuzb91m/2Nx0ACLljNFhcQWSfHP79eusjcQsbGL9IshcNdScQJN3y+UKj3erYdbkqYKt1P6LOzaGDL0bg3NmRGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd60m13spMxWaSdy+kBqx661DMQWqfTAZKidVOdx2oI=;
 b=W3GSlS9jBXki7Ox5QyxjAjhG8Rsbwaf7sVzBOQCjRZl4FpcVOkUcVivYAsHyScYm3b1gUodd88C8FC/ZxAt6ZJTYllVCdreYETYL5qT6HliW7BuD8kWPdE/YAOkH97Gd0EJotFQlG47KdkLuIFEBs815WIP7jxnVp/uAI5It4q2mDHGIOd4f1ldpdZXW2mgDS95V7tsZuT4mlsbdWAP0o228/8qWD+h+tFyzUbUuw5iz2nFvwgZAAyGofTDklk6ut36JNqblZvRn7L2Xsk5rXRdkR7sSeJBTaNfDlncQUtO/E3ZcIohRxK6ZJApqQKFW9EFZh7Nb2muZioepMwRhUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:31 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:31 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 08/32] hw/misc: Add Phytium E2000 DDR controller
Date: Tue,  8 Sep 2026 18:41:17 +0800
Message-ID: <20260908104159.1621764-9-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: f6971723-63b7-4c6c-9551-08df0d95e2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: E+zXlsEK/ebwhpW9yaE9pUULxd9CqdX+6FQQ5kFYkm7t9VI5QFtaCj1d772xhrKE11HrJtYEU/WYGJzT7yoPKdfJzKu4EChp/u/roICsf5jQ1KxsqE68gmJfazpWq8KvoPei/U7lI8y5k8iNTMRjJnmOm4ERLleB9K3U9R783k1ZZSf3l34Xaxs6jlIuk2Xd1powSlXg4XRf9/V923IFgvHHJnRlSnQuIuEMTUrnyHvqerWjkkAs6f+hAlTse89ambbf8JOp/zB6iu9ECk85NhL8MFzMT85bKbPLJpH0dJ3qTKK9BxpXMFdNcB4vo0ORG2mZJzznErC0cDhDKNyt5ClpCe33dc+MQ7HqcMH9xHxjCzM7AZjTLSYCqhjmtbcSwn8BOsUzlDz7eupDO3lfdB/76l5sg2lxYb6kZWp4x/HL8YXSYHJ3j6rHifoRXXdYjAnza9QUgbohHtDZwYnP9chUuzhjfTiMM/So57Aev+Jkq3+LUZoqJW/hc4u6xTRsc9L31UCWFEJFPAKLuDZ2N5EM8Gj6w1AD05vUim4YGWkKkHkQCfTduc7oVSTH78c56iMouvCzlrMf86BHPgsV1v3b8phXYBV6dn71Zt6CZapIlVxhU4hmXj68iankY7YJ/1R/DvzmQ5nsmnVBLSi/CKtwLLilshMzhRHKciYcxoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RnqJ0IKcqHTYU9saQ7xy2oWXsnyK4INrBCVl9NwVmgmFF5tNAGQtFcD7DlBS?=
 =?us-ascii?Q?2lGtz6hShLujqaRwwNvtDgmrL82dTvLdlxP8PS5pBIBlc8plyDuWJFeD4s13?=
 =?us-ascii?Q?zOa7va0eNSG7Nem5qdsrbd64FrpNSt8eMgL+bGzmoDDZu/GPNaqHpF0Irevg?=
 =?us-ascii?Q?yJa1VhfyGauPNl8+b4jvjeilqXR9KU1bG/zPUhN4GiBjVMFQeoUVh9DEBv68?=
 =?us-ascii?Q?mszxTb/mmqO5y3onNRuLaC36oge8niQW4Ptuw6/OeU6IZ/T627SxqQwnwMxI?=
 =?us-ascii?Q?nqXMxCgkztjZD7t6uBD4gcvcXzrudRsP6+Z873kNlG/HWwzzUedF2tLtP+g7?=
 =?us-ascii?Q?kr0Gb/L3ITKkHgL9ZMtptkV8MPPe365winfmOW6Iw0VZwuVvDzNkC9+sogD6?=
 =?us-ascii?Q?M2pu/EWR4RaLzWeT/XT8crjKYyGZGku+/nTDubOGsKoJ41ORDNOZaZl/3UO4?=
 =?us-ascii?Q?438POKplEceSr2X4ujnTGTy3Fux0f2AiszCzcVyhr5KAu0ughXY5IkRBFuZ5?=
 =?us-ascii?Q?6hB0xgpwdbO8nnBfSlBXV53+JG1O5EMhM9r+7afI+YUinfp9YsC32bzHpl9q?=
 =?us-ascii?Q?O4vBJLd1pHA9WRHreECOBTx8jFudecRGtqN0eRkMtEBpbyEBnPoHer/rbOAd?=
 =?us-ascii?Q?HwY62zT+kGwkJORqkAeKYY2Qxh2ZQU9ErraX07SQEEoxWRPgctFpzmg9zjt9?=
 =?us-ascii?Q?g5PHJYvFeTuzkbCbM84WQ6031Kl+RRXCQcJ+C6xuuhLnNrOFrycSTfyJbbwE?=
 =?us-ascii?Q?xasoOcr8rNjwXYfQQkFo79WNxgODg8VnOURK2neoYue7Oly79yT/F9slQqnz?=
 =?us-ascii?Q?S33dMERoGpLfP1/BQi0iAeWLyI4M8+f2cHW/fMFX/7CEkA7IeXIwjIfiXPH3?=
 =?us-ascii?Q?55sbPEmgRN/LEHfLSTZ0fT+JHOwSNEgC/QbNYx550cxlZOCBWhAmnUreNF9P?=
 =?us-ascii?Q?rVdsu2X/PS4BZmVysCiZVwGORTEr/Ni536bJt4P/oojaTNw3ENwUBxT0Z4h/?=
 =?us-ascii?Q?dL+qkcMtuAb5nseez2voS5c2yzdtvMG/O/q4DCgA63tCkyb6afvL9sZplIxP?=
 =?us-ascii?Q?KmHzqPB145SB+q387S05jj/R/IEcUHCyL6v5WZgnBKI/Co9pJLhhZahtmFF9?=
 =?us-ascii?Q?bFNQnDTHlv0cNAofidnK/tvpjarumi3iGrJ7ICg8PHz55sVaY6JINS2M8dhZ?=
 =?us-ascii?Q?RI8wXmwaPMdZFwhrHkTMX0Fq1RbK2FO1oJ5Zwg280tMBANCUDiXmNYvAb8Hn?=
 =?us-ascii?Q?s4wsNDcKN47FbwpilCpUuaxnh9hhGpXEiW3EwUkxXCTgHvFB2uADKTJZ0cBI?=
 =?us-ascii?Q?vdzXID5N0GkJLc4KhwqsP429P+sSrxTrN6UITsqUTHeh2qLMdGR3aWPH0ZKJ?=
 =?us-ascii?Q?iDhc0+6aFxYxZXO4ajL6HClCAyiAWPGe2m53dpQpwFvs3AEt8WuW4t2S7ksK?=
 =?us-ascii?Q?0ZhENZqjLtMaDtrhAxiDnoSF/16yJ+EkrlXC7Oj4M8D0uoZ/EGfHgA4xiE0/?=
 =?us-ascii?Q?QEaXJCJ3nS7JgyB2E60QsRw9tzOIk3pDhaNgQlEISY8L+nLjVbUFfVdik4bk?=
 =?us-ascii?Q?H++WOND+UqhcVFYBwUTbPH6TnGLmXAphk/HqxxmwFvXMEkKKlorn/Ra3mh18?=
 =?us-ascii?Q?SBxnMz2K03370qVYyusGGlXR9oA4U605yMjMf5qE23a7XFVghwN5hSXNa1FE?=
 =?us-ascii?Q?ulH+40O8vjoaNzBqyYcXNbqXj8KgOe6cc0V0YTUp2cXj8lo2bu6jbNE4ttDM?=
 =?us-ascii?Q?+mrBsn203h+m5Ia0TvX1qIWlN18OS78=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6971723-63b7-4c6c-9551-08df0d95e2d8
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:31.8066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORiur8DmNmVNd+Z1E2cXu83Z/SNBSf3rbn6YcTNPrR2OBS6GcFZi8lAUAvXYS7R6oUcLldOl+0TGtDZk2CMzmGHf+Ti5tkJ3V9K2sj6Lx38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
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

Model the E2000 DDR initialization and training compatibility window.
Keep ordinary aligned registers as persistent storage and implement
the indirect selector/value interface used by the vendor PBF.

Return the expected initialization, PHY training, update, and BIST
results, including the training-error range. This models the firmware
contract without attempting a timing-accurate DDR PHY.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 include/hw/misc/phytium_e2000_ddr.h |  23 ++++
 hw/misc/phytium_e2000_ddr.c         | 197 ++++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 3 files changed, 221 insertions(+)
 create mode 100644 include/hw/misc/phytium_e2000_ddr.h
 create mode 100644 hw/misc/phytium_e2000_ddr.c

diff --git a/include/hw/misc/phytium_e2000_ddr.h b/include/hw/misc/phytium_e2000_ddr.h
new file mode 100644
index 0000000000..91dc661106
--- /dev/null
+++ b/include/hw/misc/phytium_e2000_ddr.h
@@ -0,0 +1,23 @@
+/*
+ * Phytium E2000 DDR training status
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_PHYTIUM_E2000_DDR_H
+#define HW_MISC_PHYTIUM_E2000_DDR_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_PHYTIUM_E2000_DDR "phytium-e2000-ddr"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000DDRState, PHYTIUM_E2000_DDR)
+
+#define PHYTIUM_E2000_DDR_MMIO_SIZE 0x400
+
+#endif
diff --git a/hw/misc/phytium_e2000_ddr.c b/hw/misc/phytium_e2000_ddr.c
new file mode 100644
index 0000000000..ab46a46961
--- /dev/null
+++ b/hw/misc/phytium_e2000_ddr.c
@@ -0,0 +1,197 @@
+/*
+ * Phytium E2000 DDR training status
+ *
+ * The vendor firmware accesses controller and PHY state through an indexed
+ * selector/value window. This functional model reproduces the completion and
+ * error predicates used during boot; it does not simulate analog DDR training
+ * or generate physical calibration results.
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
+#include "hw/misc/phytium_e2000_ddr.h"
+
+#include "hw/core/register.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+
+REG32(SELECTOR, 0x80)
+REG32(VALUE, 0x84)
+
+#define PHYTIUM_E2000_DDR_R_MAX                  \
+    (PHYTIUM_E2000_DDR_MMIO_SIZE / sizeof(uint32_t))
+/*
+ * Selectors encode a register index as a byte offset. PBF uses separate
+ * direct, indirect, and training banks distinguished by 0x800 and 0x1000
+ * index biases.
+ */
+#define PHYTIUM_E2000_DDR_SELECTOR(reg)          ((reg) * 4)
+#define PHYTIUM_E2000_DDR_INDIRECT_SELECTOR(reg) (((reg) + 0x800) * 4)
+#define PHYTIUM_E2000_DDR_TRAINING_SELECTOR(reg) (((reg) + 0x1000) * 4)
+#define PHYTIUM_E2000_DDR_TRAINING_ERR_FIRST     0xc72
+#define PHYTIUM_E2000_DDR_TRAINING_ERR_LAST      0xc79
+
+struct PhytiumE2000DDRState {
+    SysBusDevice parent_obj;
+
+    uint32_t regs[PHYTIUM_E2000_DDR_R_MAX];
+    RegisterInfo regs_info[PHYTIUM_E2000_DDR_R_MAX];
+    RegisterAccessInfo regs_access_info[PHYTIUM_E2000_DDR_R_MAX];
+};
+
+static uint64_t phytium_e2000_ddr_value_post_read(RegisterInfo *reg,
+                                                  uint64_t value)
+{
+    PhytiumE2000DDRState *s = PHYTIUM_E2000_DDR(reg->opaque);
+    uint32_t selector = s->regs[R_SELECTOR];
+
+    /*
+     * These fixed selectors are controller/PHY polls observed in the tested
+     * firmware. Return only the ready and completion bits that its loops
+     * require, without assigning behavior to the surrounding register bank.
+     */
+    switch (selector) {
+    case PHYTIUM_E2000_DDR_INDIRECT_SELECTOR(0xdc):
+        return BIT(0);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x256):
+        return BIT(0) | BIT(25);
+    case PHYTIUM_E2000_DDR_INDIRECT_SELECTOR(0x76):
+        return BIT(0) | BIT(14) | BIT(27);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x10f):
+        return 0x40U << 24;
+    case PHYTIUM_E2000_DDR_SELECTOR(0x229):
+        return BIT(0);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x257):
+        return BIT(3);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x255):
+        return BIT(16);
+    case PHYTIUM_E2000_DDR_SELECTOR(0x1d5):
+        return BIT(16) | BIT(24) | BIT(25);
+    default:
+        /*
+         * The training bank is read repeatedly for lane state and error
+         * summaries. Error selectors report no failure; the remaining values
+         * are deterministic so repeated sweeps see stable lane data.
+         */
+        if (selector >= PHYTIUM_E2000_DDR_TRAINING_SELECTOR(0) &&
+            selector < PHYTIUM_E2000_DDR_TRAINING_SELECTOR(0x1000)) {
+            uint32_t index = selector / sizeof(uint32_t) - 0x1000;
+
+            if (index >= PHYTIUM_E2000_DDR_TRAINING_ERR_FIRST &&
+                index <= PHYTIUM_E2000_DDR_TRAINING_ERR_LAST) {
+                return 0;
+            }
+            /*
+             * Preserve the masks and flag combinations checked by the PBF
+             * training algorithm for these recurring low-byte selectors.
+             */
+            if ((index & 0xff) == 0x34) {
+                return 0x00000fff;
+            }
+            if ((index & 0xff) == 0x38) {
+                return BIT(4) | BIT(5);
+            }
+            if ((index & 0xff) == 0x83) {
+                return 0;
+            }
+            if ((index & 0xff) == 0x3b) {
+                return 0x01234567U | BIT(26) | BIT(27);
+            }
+            return 0x01234567U;
+        }
+        /*
+         * Unclassified offsets retain ordinary register storage. This keeps
+         * setup writes readable without pretending they affect DDR timing.
+         */
+        return value;
+    }
+}
+
+static const MemoryRegionOps phytium_e2000_ddr_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void phytium_e2000_ddr_reset(DeviceState *dev)
+{
+    PhytiumE2000DDRState *s = PHYTIUM_E2000_DDR(dev);
+    int i;
+
+    for (i = 0; i < PHYTIUM_E2000_DDR_R_MAX; i++) {
+        register_reset(&s->regs_info[i]);
+    }
+}
+
+static void phytium_e2000_ddr_init(Object *obj)
+{
+    PhytiumE2000DDRState *s = PHYTIUM_E2000_DDR(obj);
+    RegisterInfoArray *reg_array;
+    int i;
+
+    /*
+     * Firmware may touch any word in this compact window before selecting a
+     * status source, so create registerinfo metadata for the full aperture and
+     * specialize only SELECTOR and VALUE.
+     */
+    for (i = 0; i < PHYTIUM_E2000_DDR_R_MAX; i++) {
+        s->regs_access_info[i].name = "DDR_STATUS";
+        s->regs_access_info[i].addr = i * sizeof(uint32_t);
+    }
+    s->regs_access_info[R_SELECTOR].name = "SELECTOR";
+    s->regs_access_info[R_VALUE].name = "VALUE";
+    s->regs_access_info[R_VALUE].ro = UINT32_MAX;
+    s->regs_access_info[R_VALUE].post_read =
+        phytium_e2000_ddr_value_post_read;
+
+    reg_array = register_init_block32(
+        DEVICE(obj), s->regs_access_info, PHYTIUM_E2000_DDR_R_MAX,
+        s->regs_info, s->regs, &phytium_e2000_ddr_ops, false,
+        PHYTIUM_E2000_DDR_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+}
+
+static const VMStateDescription phytium_e2000_ddr_vmsd = {
+    .name = TYPE_PHYTIUM_E2000_DDR,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, PhytiumE2000DDRState,
+                             PHYTIUM_E2000_DDR_R_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void phytium_e2000_ddr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &phytium_e2000_ddr_vmsd;
+    device_class_set_legacy_reset(dc, phytium_e2000_ddr_reset);
+}
+
+static const TypeInfo phytium_e2000_ddr_info = {
+    .name = TYPE_PHYTIUM_E2000_DDR,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000DDRState),
+    .instance_init = phytium_e2000_ddr_init,
+    .class_init = phytium_e2000_ddr_class_init,
+};
+
+static void phytium_e2000_ddr_register_types(void)
+{
+    type_register_static(&phytium_e2000_ddr_info);
+}
+
+type_init(phytium_e2000_ddr_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9790afa104..dca5f67ca9 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -16,6 +16,7 @@ system_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
 system_ss.add(when: 'CONFIG_INTEGRATOR_DEBUG', if_true: files('arm_integrator_debug.c'))
 system_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
 system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_ddr.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
-- 
2.53.0


