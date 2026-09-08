Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CC5C79FAE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHw-00089t-L8; Tue, 08 Sep 2026 06:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHu-000898-MV; Tue, 08 Sep 2026 06:42:50 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHs-0006YC-CU; Tue, 08 Sep 2026 06:42:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTrHmAYh3TzLWIXftahqUxnPBE9n5Uq9Z6qNrU2myOlIKhM0XdM8GukmwYR9uMfHvOLmA+xuLtjVd81kt7XFs3IQt3uMmdBfn2ju6MbzUYBviNiwTDZckWY/efjshlcZOLQo83/F7qRPbSIzLi99MhrQNZNJKvDGzoOPrV9VAftbL83PiXfd2T+YPxU2DSL/ykj8CtEVshNWXB9MX5MAQb5P9s7uufwnXw814NyCl9G6fkpedJTPYgTMFk5wkcfbJE1ZL33zCnXsrJ4UJFwSmjKB0tjIeZ+wM+AegCWiu8gyb4Df0gOUM7pe6aVTMVX+peNAuu79embjcCSKogQ18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62kIHUn/9r7Nz2RxxLMPHQXrNcKUDI0LgMnmN6EIa6w=;
 b=w08j+C3YO9i0bclYNAxNMXJr+Ex/cJRZSFRC+HSRLcOnBilQ2Z3pOkWHLlqpAFOUdZWECNIWJSamgeQnbPcB7ivdzPFebG9hTnksdTpKE9+c/1Ga0PF8uN2HuiOvevKK5X5xk8zr/6LLxj8DgInX1HAhQGpQW+AhguTRo3DKuIRdCFSEvDKYWDU3hF4OW14czOwfUC7Sfx2TJ3MBR2Fj7/HM+yQ+muEL/sERtg+pa4v0qbvovCKH/TbMH3qJ5Kq9caMpXp6StfgLK5Hs2n8Ec6F92Hih5AktN8rvGNA5TVr36UJ8ZqhVIJGJrs2ZF+IqcxPWMGD6dS9QN0CKXM6acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62kIHUn/9r7Nz2RxxLMPHQXrNcKUDI0LgMnmN6EIa6w=;
 b=p7HxF65Zdp1Lxc0gKpVe3cWz01u0Z9qCpI+/equ5pEDIFNRtATyEsdq//3waqdRfiPmJjOee1gfukkpOqUW1c/TwjCYs3EOuRqHF9l+oP/PKMn4gU8+/P+0kSwh4tjTr9CqxYKoR6Cs7936yuBrF6XaLm/TQBo0GDQoBD9np1BjpeyVldCDr9r/UkmUM+xhSc/Nrzc9d8KNN4QHdsUJd+2kGOk6YyDae8cz1M+5RQr9AMh9gggu5eJx0I7mIr57s+cShwGZ/Spw2QZNbMqwcblnMVBFsuvR/nSRGdZc3DbJPPWe8aIynKrOftd9i0K+EEHqI0VQEQD6RS2Z4DrIXGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:34 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:34 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 10/32] hw/misc: Add Phytium E2000 MHU doorbell
Date: Tue,  8 Sep 2026 18:41:19 +0800
Message-ID: <20260908104159.1621764-11-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: b4876f3b-b3fd-4b55-42e2-08df0d95e467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4Ic4lfgbBqZnLL7O95pSYoMmuUHM2gROYBpPEfIxBib9gombybInD0+vGkKznvlIclcH487ZpUdlKmHqUbnocYFlYbJWO/M+Zbgi7jRrcgWb02JWp+9VuA5KEwU+Zet+be7XRSF4MaqHBAEp9cK7Zf0czZ0YWEoAmBA9z0artNSsU2HG6gb7SzcdTTBuWQ8oGwBekCO1gikJEb/wtT0M5H6HxZztqJWuh5fascLHpO/w4Bw55oh2hXLT3uUq7qsi55F8qURamEe8aapk2wJd1jQ/ERpmjFH+TIGlR691IjCOyrNKe7g5xni3acmL9HK771ZmoTf1tDhEwekQNfgcwMEJx3My56EMQvMzgVrwPrr5L1GdJPbEkGck56catfJYCJY4NhE0R6Fj22t3PfF+7e4th0yxArHokhSP3Hy2vOakKFwAy1bdez5Ka5wz6+/hi9L3HDbOUjGCtpZYwPvf64bnqVLC6BQbmWLcG2eS6ZaFGRFRQZ75WJb7SVmWvN8HGxdJykV4MdABdaO+7e6GlFeWc7sB+TLgpfYR8WFOUXWszugt/9TbmmZPWILrQE9eilFnqKUZ9t2c4X4lyJ/mGL1IKV8aBCqPAhiECyYmDewkZ1UovEOZ4kjIP9x3G+4sNGgsYQYLi4cBDDv9a5V9CvO76AJH7T/j2oDrPyMcVTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KVID4dUkzV+ZC6RSaQgps8hsSuKgqmtIMAts9vxuCWjVjgfKACjPsVdeVM2z?=
 =?us-ascii?Q?qBZGcZnITaX8toLGrHO0U9F8nlUdNW96MrQ+uPkwuwqrTJTcM15VdeKNaCYy?=
 =?us-ascii?Q?0aFSzN/t9o0LCfn9gQXPN/GTEoMAtEQ+3etcYKde96JwYLgUli/mTUww1/xM?=
 =?us-ascii?Q?dlZ95dZSxVx0vt5Q7FaXNZ1WmNesVCR3AHfXcCCFCTdzNbYz0Qhgui91qGmi?=
 =?us-ascii?Q?t8K1uF+HUE/lCJ+kRXL6/+sIR6yrh18ApgrraE6OUbfxK6s2AkV4Y1+jMh80?=
 =?us-ascii?Q?PfpvYX6FJAhCtwC8F+SS8L5FMNlQRW2pF4jOX2c0fpoMIgiXSxk1KVflUebq?=
 =?us-ascii?Q?EYCL9eHHJ/xzDIUflWe0F3YpEtFoOW+ue9V4yKKBkCeLz73MSlBnlcpY9sEL?=
 =?us-ascii?Q?srw/VmqmD4BwaXCgw3ypjqB5XpknCKothwGCPyQYcj3JvRqqd9WBG38qg7et?=
 =?us-ascii?Q?zaEU4zJqcoc4WEo2oEFFm97SrdmF8NKy8Q5oKgxvusuhZUV4hymsfB1BtoVp?=
 =?us-ascii?Q?/ErFFc2WSiM3LQ75aPj2stVVFg8iDeQTPdswg6J8aBochkPRQNOiIZPyKEz8?=
 =?us-ascii?Q?AD+LeNKQRCUwQjXpj2vwYNHi6CfqBWimfa5jrXhMmdB5o6pH7d10VaXBvx5I?=
 =?us-ascii?Q?i8JbXcmvaTC2jswcEmnLdyf7g52Ihxhgqi4pT0KsHW/5SFW/zPYN/yaOauBA?=
 =?us-ascii?Q?cFVx+VhIeMDbGO8u+w9gz68+QoyM6KVyT0QOQ2r2Io+6LOf6xHV3HzMsA1zB?=
 =?us-ascii?Q?AbWKVJgfBFaywSvlkG5eFcB1QQpWdTqkddpzQyHyasaFtpI5Ad7frNvVv+SQ?=
 =?us-ascii?Q?oAZLYBbkpnDxi1DPHXYpjjS3peSQwYxTRC/bJr9mAJhuU8o5mwL/+4uO01Ih?=
 =?us-ascii?Q?foddu6HwhfMLdfS0kU0ooljnHE8emaUhrLRYiUYDmMXU6qJUHQgenBCftVqK?=
 =?us-ascii?Q?K2Uxofa/y3OTVKJSLUbaHTINQkZ+nyFu2459C06Gli4R1RE6FASxzmcL9WEL?=
 =?us-ascii?Q?MuheE5ZKEWExs4sOZlAYEX0+es1Lhu7jXSGPs2CJbYy2g1YNZ9A49ZUBFua/?=
 =?us-ascii?Q?aI4ywucK4/KPKCWXWUisRdX8cYm4A/xgjSKbbgmSU13c4atg+6DkqG0sq4Gm?=
 =?us-ascii?Q?rz0n5W+VLWjtYvEuc7aBAv+Io8S+Tzo4Sid4zvMRKE/a9vyOWNhS3xUVtvRx?=
 =?us-ascii?Q?FWUv1XIzTG44pJIKPpo+cSpl5U3tlCQBdtTJ7lRt1EeJLj7o3UOWO9keXi8U?=
 =?us-ascii?Q?SaYCnGRr6HZm+7+TzPOVMmT3kAb/3uxi6HgDWFtNjNGZdR0a2Dn/7sZ4N3qT?=
 =?us-ascii?Q?0ssLke+JyKFJdtUjV6UO1fuyvoiDnA5VN9/6gLMrsgjN3WDxPO+MJOz00pSI?=
 =?us-ascii?Q?4sm5f5d3EIP0IwSG9M1i5B5B1JDEPGbMYjHzZt9owx/3NnfoTDrFc9gkkEo9?=
 =?us-ascii?Q?ILeyDsqDm37e52tS6o8L0FmkKF7YHtMvm7xUxtgQQaWMCpEplV0sJguw+GBq?=
 =?us-ascii?Q?ZmtcYD9b3k586oHBcaMuNtTn2dMbbLGeYET2h44+2gmDG6L6N67DbgMTXC/h?=
 =?us-ascii?Q?p0rxmB4lHOWnE2tbn+4HHokQpWd7z+VklxAP1kJ1DYUtDbDrzkF4FdLbVW3O?=
 =?us-ascii?Q?093JlDbXfpk+LDzB2cJcj0qAsPgqy/s7K7cvTUh0KXPNP6ryR7Tj7j3QZwjE?=
 =?us-ascii?Q?C7Icd3CB4yjk0oaBXqW/BP/DsGLZP6+MYT37DT//kw3FSMrx56cVVoMqRSUQ?=
 =?us-ascii?Q?vwcyzRkDFk2w4JmV9aq/ZQEIGc1TTMU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4876f3b-b3fd-4b55-42e2-08df0d95e467
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:34.5366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9CJWcFDNKx4xETHJbI2jzB7fUkxtmPEdDGXR/mf+Eh7SmO1Cmb7FWhUctG2lq+HjUjEF6CgfJBj8ZevkP61MuDYbC+v0dili+12LDdju0U=
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

Add a model for the E2000 AP OS MHU channel used by vendor firmware.
Model its status, set and clear registers and complete nonzero
notifications by updating the shared SCMI mailbox.

The device also provides the mailbox seeding helper required by
the later PBR handoff. Board address mapping and SCP SRAM ownership
are intentionally left to a following machine-integration commit.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 include/hw/misc/phytium_e2000_mhu.h |  25 ++++
 hw/misc/phytium_e2000_mhu.c         | 185 ++++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 3 files changed, 211 insertions(+)
 create mode 100644 include/hw/misc/phytium_e2000_mhu.h
 create mode 100644 hw/misc/phytium_e2000_mhu.c

diff --git a/include/hw/misc/phytium_e2000_mhu.h b/include/hw/misc/phytium_e2000_mhu.h
new file mode 100644
index 0000000000..0527d6fe8d
--- /dev/null
+++ b/include/hw/misc/phytium_e2000_mhu.h
@@ -0,0 +1,25 @@
+/*
+ * Phytium E2000 MHU/SCMI doorbell
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_PHYTIUM_E2000_MHU_H
+#define HW_MISC_PHYTIUM_E2000_MHU_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_PHYTIUM_E2000_MHU "phytium-e2000-mhu"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000MHUState, PHYTIUM_E2000_MHU)
+
+#define PHYTIUM_E2000_MHU_MMIO_SIZE 0x1000
+
+void phytium_e2000_mhu_seed_mailbox(void);
+
+#endif
diff --git a/hw/misc/phytium_e2000_mhu.c b/hw/misc/phytium_e2000_mhu.c
new file mode 100644
index 0000000000..4ea23af900
--- /dev/null
+++ b/hw/misc/phytium_e2000_mhu.c
@@ -0,0 +1,185 @@
+/*
+ * Phytium E2000 MHU/SCMI doorbell
+ *
+ * This is a boot-oriented SCMI transport proxy. It acknowledges requests in
+ * shared SRAM so PBF can complete clock and platform setup; it is not a full
+ * SCMI protocol server.
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
+#include "hw/misc/phytium_e2000_mhu.h"
+
+#include "hw/core/register.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "system/address-spaces.h"
+
+#define PHYTIUM_E2000_PBF_SCMI_MBOX_BASE  0x32a10400
+#define PHYTIUM_E2000_SCMI_STATUS_OFFSET  0x04
+#define PHYTIUM_E2000_SCMI_LEN_OFFSET     0x14
+#define PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET 0x1c
+#define PHYTIUM_E2000_SCMI_STATUS_FREE    BIT(0)
+
+/*
+ * The SDK defines AP OS status/set/clear at 0x100/0x108/0x110 within a
+ * channel. PBF selects the channel at MHU offset 0x200, producing the global
+ * offsets below. Writes to AP_OS_SET are the request notification.
+ */
+REG32(AP_OS_STAT, 0x300)
+REG32(AP_OS_SET, 0x308)
+REG32(AP_OS_CLR, 0x310)
+
+#define PHYTIUM_E2000_MHU_R_MAX \
+    (PHYTIUM_E2000_MHU_MMIO_SIZE / sizeof(uint32_t))
+
+struct PhytiumE2000MHUState {
+    SysBusDevice parent_obj;
+
+    uint32_t regs[PHYTIUM_E2000_MHU_R_MAX];
+    RegisterInfo regs_info[PHYTIUM_E2000_MHU_R_MAX];
+};
+
+static void phytium_e2000_mhu_complete_scmi(void)
+{
+    uint8_t buf[sizeof(uint32_t)];
+    uint32_t len;
+
+    /*
+     * Preserve the caller's message length, but reserve one status word for
+     * the minimal success response returned in the payload.
+     */
+    address_space_read(&address_space_memory,
+                       PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
+                       PHYTIUM_E2000_SCMI_LEN_OFFSET,
+                       MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+    len = MAX(ldl_le_p(buf), (uint32_t)sizeof(uint32_t));
+
+    stl_le_p(buf, 0);
+    address_space_write(&address_space_memory,
+                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
+                        PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET,
+                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+    stl_le_p(buf, len);
+    address_space_write(&address_space_memory,
+                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
+                        PHYTIUM_E2000_SCMI_LEN_OFFSET,
+                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+    stl_le_p(buf, PHYTIUM_E2000_SCMI_STATUS_FREE);
+    /*
+     * Publish the free bit last. PBF polls this field as the ownership handoff
+     * and may consume the response immediately after observing it.
+     */
+    address_space_write(&address_space_memory,
+                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
+                        PHYTIUM_E2000_SCMI_STATUS_OFFSET,
+                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+}
+
+void phytium_e2000_mhu_seed_mailbox(void)
+{
+    /*
+     * PBR leaves the shared channel available before releasing PBF. Seed the
+     * same ownership and success state even before the first doorbell write.
+     */
+    phytium_e2000_mhu_complete_scmi();
+}
+
+static void phytium_e2000_mhu_doorbell_post_write(RegisterInfo *reg,
+                                                  uint64_t value)
+{
+    /*
+     * Complete requests synchronously because no separate SCP CPU executes in
+     * this model. Zero writes only update doorbell storage.
+     */
+    if (value) {
+        phytium_e2000_mhu_complete_scmi();
+    }
+}
+
+static const RegisterAccessInfo phytium_e2000_mhu_regs_info[] = {
+    /*
+     * The functional transport does not model an SCP interrupt line. STAT is
+     * therefore idle, SET completes the shared-memory transaction, and CLR
+     * remains ordinary register storage for the firmware acknowledge path.
+     */
+    { .name = "AP_OS_STAT", .addr = A_AP_OS_STAT,
+      .ro = UINT32_MAX },
+    { .name = "AP_OS_SET", .addr = A_AP_OS_SET,
+      .post_write = phytium_e2000_mhu_doorbell_post_write },
+    { .name = "AP_OS_CLR", .addr = A_AP_OS_CLR },
+};
+
+static const MemoryRegionOps phytium_e2000_mhu_ops = {
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
+static void phytium_e2000_mhu_reset(DeviceState *dev)
+{
+    PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(dev);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(phytium_e2000_mhu_regs_info); i++) {
+        register_reset(&s->regs_info[
+            phytium_e2000_mhu_regs_info[i].addr / sizeof(uint32_t)]);
+    }
+}
+
+static void phytium_e2000_mhu_init(Object *obj)
+{
+    PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(obj);
+    RegisterInfoArray *reg_array;
+
+    reg_array = register_init_block32(
+        DEVICE(obj), phytium_e2000_mhu_regs_info,
+        ARRAY_SIZE(phytium_e2000_mhu_regs_info), s->regs_info, s->regs,
+        &phytium_e2000_mhu_ops, false, PHYTIUM_E2000_MHU_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+}
+
+static const VMStateDescription phytium_e2000_mhu_vmsd = {
+    .name = TYPE_PHYTIUM_E2000_MHU,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, PhytiumE2000MHUState,
+                             PHYTIUM_E2000_MHU_R_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void phytium_e2000_mhu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &phytium_e2000_mhu_vmsd;
+    device_class_set_legacy_reset(dc, phytium_e2000_mhu_reset);
+}
+
+static const TypeInfo phytium_e2000_mhu_info = {
+    .name = TYPE_PHYTIUM_E2000_MHU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000MHUState),
+    .instance_init = phytium_e2000_mhu_init,
+    .class_init = phytium_e2000_mhu_class_init,
+};
+
+static void phytium_e2000_mhu_register_types(void)
+{
+    type_register_static(&phytium_e2000_mhu_info);
+}
+
+type_init(phytium_e2000_mhu_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index dca5f67ca9..149ec8e797 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -17,6 +17,7 @@ system_ss.add(when: 'CONFIG_INTEGRATOR_DEBUG', if_true: files('arm_integrator_de
 system_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
 system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_ddr.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_mhu.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
-- 
2.53.0


