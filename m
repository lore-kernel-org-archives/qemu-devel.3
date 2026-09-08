Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C74C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tI3-0008Sk-Ho; Tue, 08 Sep 2026 06:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI1-0008QO-L6; Tue, 08 Sep 2026 06:42:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHz-0006ZW-1F; Tue, 08 Sep 2026 06:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1z9oYlryw9XrkCF5qZK5KaH/JPQYOzMNSGiI7fmY6bxHFzq+b9CMVNVUzbwSoRx41aDpaY6yccuHD7ZpbneWD8rkmYxGr5AU1tnLNNdT9KNF/ryofIQVtD5GPu7ZyiEGLpKCK8DMuiEgjVjqgv/CQDSt7R1pKZF1dgwHjgkEuEir5BaNd7dKXNjuonwhmB3kGPhllpw9mPd71HfyU+AuihJ16keUwYBUxUfETgsWGVKLhd3bnmeY+2gUFFQkwWgUV0ElxK0gf0c7u2/gKOLojaEy/1HlNQT6eEtabV/Ec/nuFPsu6oXmQ2Mvjo6+wG9FGUboeAnaxtQ3N95UfIzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehGDTOvrLzALgZLkhXUF0nIR0T+vcPJnbyTRi8i7a8k=;
 b=jOoZof38mhPy7wEtTajhX9HDent7YiC4f4uXaYHrPMlHyaXA8QR5y+/mfT205lNRuprDHiAzUrZ+mlHM3Vgjwghap0qBFLODRfjQ9/Sa3Zlta0RYy0aBOxicvQAJBOLNHAHLGn6QKH2e/jiu7G+toe3Ltmfm80nuIKGhOshv9tvzYXTy3DI0bxb2M/G+9R8/xtxro+pfzA65JAVwP3gYO0fnaY4cQd2qihky/VF0Jd5FYcVslSdBEaeb9HGiHj1enY98StC8HVCCi61THy5oFzN9k4h7zoSYeMsFj+cnBkSHvF+8qxgIGCExRlw6QJmG79HL4LYHxzo8UMe0HACOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehGDTOvrLzALgZLkhXUF0nIR0T+vcPJnbyTRi8i7a8k=;
 b=W1CMK6iyLoZBiUcBO4A+68bg734V/qn2BB+VQbJmd23kbQ9pMct556TtIkLgxvQeUT/ZzfW6om2Cu0NyzTZe6FoZEHQHgzQ9BvWeYPJbQOKvPEZ6F73Df0ou8sNDzmnW/rKkAU3Zfzh656/iKQ8EEGOwk3U9ul67BMNPFsvvOkuC9DKMWuyVedHuYMEOUk6O2d3RgbZsL3HIrnw6kIfCwUu1GqU718nTx7aLeyCXPC9U8fYAkTBw64BT9mgEwOOqQ38aF0CMBkZV2Sp8QBHO4A/ZbgLWWrVdzG551FaXJANauob5mqPnGQbCvC5vUkaWN5pzk4djCCetcuCBeOuKGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:37 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:37 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 12/32] hw/ssi: Add Phytium E2000 QSPI controller
Date: Tue,  8 Sep 2026 18:41:21 +0800
Message-ID: <20260908104159.1621764-13-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 83c38969-57a0-4417-2b44-08df0d95e647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: /lg2907GY/GT/MkLFKzcfd633PQeoMS0POIlS1LHKQzPZuRLFc+uaFwCPv2XLPtQY0vDQTv829fHMcH4OOT7QHbdiO6KUsCwvfsPkcoXZGz+qnft+ly2IT40J7aJu+8TRBkkIkXhPePgNN0b2lZgmWiASpU3PPFiC2A4JGJdlLX33V1Zvc+fGbmCVgAXxwk6rFUc8hqLLybsYbmZ48MeOudhmfnr9Fxu+kiTViulA5bKQT74MtL5jh2Pni3cwgWViU87PwG52tLKJznb3PW6WBaGA32IYIDUHlSy/UPk8DCqsbZ6GtNP7dxcZ1kdRlNJtuxE304y3IzfRgnWesf9KswahNlfpmhukEGH8GWAsUdYk+lJevCXFgRrrNjJ8nHucabBnK16xYICZFmGMYM34FmpDArOeYLW85hAd3Jf4YQmzz0aJFc3RHP3kIfEHPOHclH/yN2KMoEIwT5/kXaAVCYe6wLBGpDEpDVRnJIF6X8+qLy3Mi4mTfsvYNFPaSCwd+3k6tlRQkExt3X7URxyLy4aeFrhLXDY8JMgxm4f5FvhvYT2c53xPnbQxpSLYtulWBTbXi2ObrRwU+RxQurxTFBiZFjLHto6i+XoljxjrraOB6g5FAOXIk7t/AkUOnGTVXKme+YlDmbD1KDjehj9ThvRAu3X8bUogMveXm4c6Ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mlDsinwUWe2w7UnhVzKj6yIjfR90iHMrp9JDXZSuJT0HeIUNY5PfSoCyf658?=
 =?us-ascii?Q?BElm0Lg3nZJxUuX0B/+ZA8HKiY3PyCOSxFSr79/1eHOx3JBlEzERNcSbXggI?=
 =?us-ascii?Q?booAE0IUSI5cWubYlK1bPiXifwBLf0YbS5QH98L7u/tShPL4UTDQoKZXsVj8?=
 =?us-ascii?Q?eoTXfWTO6izuN4ZrO7Qfo/W3vhaUd6WK4Xel7kIZSYxGPf3tEhzk+H5/aOEv?=
 =?us-ascii?Q?If4EeRiu6O43tBqp9wUgDqMQOlz8UXNKBIGNh4bvx3OtT/iZ1iZ1H/0Tv0QP?=
 =?us-ascii?Q?S1iMzar52sMJ+w8JplNaz384CYvBfW6jIbXt10+Dp15EmGkp8hKyYtF0CSsA?=
 =?us-ascii?Q?lQYw2DGsdAndG5mmwDYa5+80SAKhwtrNoqofaV4JK9bEXNS/RiaD9QCtp0a9?=
 =?us-ascii?Q?F83MeqsyXTwxwOM+b6t7tb7Gs352/57QWgTEvzgZ8YBAMY+JSAyJaTsqBN21?=
 =?us-ascii?Q?EmtpRqFhPXYZxryy3LI2mDx5EaunuR7wYXbXpFU0Z1Ia84aLUjF1VpyRlzA3?=
 =?us-ascii?Q?VWjMLCiEZBXczCUeZWFBHlgtCHAuI4hCo63G+5RAknHeMAZRdvuQ/0LyOuUR?=
 =?us-ascii?Q?Rawx9+euRXcz6XmBkR6bhZ2PE55zPe5ZLfh8oJ2NVR+nAav2CkYgvkKhbQNd?=
 =?us-ascii?Q?5bw66tw9IIVPVtCM9X2KBcTCllldk/1+UrQ3rqNHtZVImT0MmdDa+Prmx71I?=
 =?us-ascii?Q?RP1Y0/l+XN8ll3ZlKFEk+AC4e1cgIGAJsZrz2YdyJWWQZ/C7mgTIqcQqJUpz?=
 =?us-ascii?Q?xKiQezP/XxRuQ/foO6HdWO4Tg/uXFvog7LtpfnmMVaePSrwi4JVtHRwUJiRz?=
 =?us-ascii?Q?V42LnIlK/abpMwjPFB7+lj1YtPxpYyuxvHhJubp1wjKyk/97qYuIqR7Wzsxs?=
 =?us-ascii?Q?YhLEVW/lVpqpcyi47O9yVNe1S4fJJKZNZPnqjyArIb2FmHvIGg3I2QVTvL7P?=
 =?us-ascii?Q?mXundblr7hdFcm5ydiGRHagYHLxl9nhZnAf6jI3WOsgo6G2zyx/t8aniE6n0?=
 =?us-ascii?Q?xhGisDmveuE7swb+GE7drgfhTRdOaKp5AvCUzTjxYXQSy+UluxL29f3UZ0wW?=
 =?us-ascii?Q?H9RBEyovYhnjwmKEPaYINE3iXWh/0kDo/mtXNrAJiMjSRRw/x37E/HtYXa+K?=
 =?us-ascii?Q?WgWQQIZMRVfW6op46h9V4yFTSTFegQQ/kkoHY+EX3WGm4/P0nUueLQRhaE0A?=
 =?us-ascii?Q?OCB3mQ4UPdALqgBKd9BGQb1AeNR30Zep2oWmKqJ/U7WNPvuMqaxKjll5m3LA?=
 =?us-ascii?Q?ksVOY19G3GD6l2uxkeTSNkAkaxHz+pGEQyg9sr+XiMbdCQwOnSckU6cg47Pr?=
 =?us-ascii?Q?IpZJphUJ7nh73TWpQwDkkrdgjVg2oju8LZ4f3Xd/Oesc1CMLH6XxgWq55xLe?=
 =?us-ascii?Q?K268E2HILYYFBpl6GR8SsqlVKVp/Gz/ps/7pC0KGCOXD8cS6/GOFboeKhCRN?=
 =?us-ascii?Q?Bn4SLuvis/MKwdOrHDYXeA7kzIVf1D++AODQ9bVnvqZ5veMeFMQaotTmGc7C?=
 =?us-ascii?Q?5PUtHy+zBITHciLjm06jKTRMEBPOYF8a+dls6UMcuMpsKYkvl64PKX0DscJ8?=
 =?us-ascii?Q?0f/5+ngIqGT9ZxkaXNBkSCppE6Bt2YME5bQqNpFT4LlwxJbzLLYTfTF/Tyx5?=
 =?us-ascii?Q?7TxNC2ZmR2XdNhlTAmVwjgFaow4bQiOs8EKjrYZL9JN2EAb45cb6UmOkNj/F?=
 =?us-ascii?Q?fQw3HxCVJ5FKk/woN0fRsn6GX3IkDtdinorCzZK54cMvB02ZXN5vf8gyJwxa?=
 =?us-ascii?Q?ACUvY6hpUD/kfTp9Zyxlr+GOjVW7jIU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c38969-57a0-4417-2b44-08df0d95e647
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:37.5686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ST/wEjVGQk5iv6fwkW0WKyEHBcIqjF7iHtLl7u5NYivyQxjr3OPHL0gRnYTqblRb3KPEmaNvJ9CycEQyZ+m8s8A9f+r8FTCfma2PNB4rIoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
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

Phytium E2000Q integrates a QSPI controller which seems to be an
in-house IP. This adds a model for it with command-port and
direct-map paths, and exposes an SSI bus and chip-select output.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 include/hw/ssi/phytium_qspi.h |  23 ++
 hw/ssi/phytium_qspi.c         | 398 ++++++++++++++++++++++++++++++++++
 hw/ssi/Kconfig                |   5 +
 hw/ssi/meson.build            |   1 +
 4 files changed, 427 insertions(+)
 create mode 100644 include/hw/ssi/phytium_qspi.h
 create mode 100644 hw/ssi/phytium_qspi.c

diff --git a/include/hw/ssi/phytium_qspi.h b/include/hw/ssi/phytium_qspi.h
new file mode 100644
index 0000000000..c6534af16d
--- /dev/null
+++ b/include/hw/ssi/phytium_qspi.h
@@ -0,0 +1,23 @@
+/*
+ * Phytium E2000 QSPI controller
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SSI_PHYTIUM_QSPI_H
+#define HW_SSI_PHYTIUM_QSPI_H
+
+#include "hw/core/sysbus.h"
+
+#define TYPE_PHYTIUM_E2000_QSPI "phytium-e2000-qspi"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000QSPIState, PHYTIUM_E2000_QSPI)
+
+#define PHYTIUM_E2000_QSPI_REG_SIZE    0x1000
+#define PHYTIUM_E2000_QSPI_DIRECT_SIZE 0x10000000
+
+#endif
diff --git a/hw/ssi/phytium_qspi.c b/hw/ssi/phytium_qspi.c
new file mode 100644
index 0000000000..da7dce1d46
--- /dev/null
+++ b/hw/ssi/phytium_qspi.c
@@ -0,0 +1,398 @@
+/*
+ * Phytium E2000 QSPI controller
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
+#include "hw/ssi/phytium_qspi.h"
+
+#include "hw/core/register.h"
+#include "hw/core/irq.h"
+#include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+REG32(FLASH_CAP, 0x00)
+REG32(RD_CFG, 0x04)
+    FIELD(RD_CFG, CMD, 24, 8)
+    FIELD(RD_CFG, ADDR_SEL, 19, 1)
+    FIELD(RD_CFG, LATENCY, 18, 1)
+    FIELD(RD_CFG, DUMMY, 4, 5)
+REG32(WR_CFG, 0x08)
+    FIELD(WR_CFG, CMD, 24, 8)
+    FIELD(WR_CFG, ADDR_SEL, 4, 1)
+    FIELD(WR_CFG, MODE, 3, 1)
+REG32(FLUSH, 0x0c)
+REG32(CMD_PORT, 0x10)
+    FIELD(CMD_PORT, CMD, 24, 8)
+    FIELD(CMD_PORT, CS, 19, 2)
+    FIELD(CMD_PORT, CMD_ADDR, 15, 1)
+    FIELD(CMD_PORT, LATENCY, 14, 1)
+    FIELD(CMD_PORT, DATA_XFER, 13, 1)
+    FIELD(CMD_PORT, ADDR_SEL, 12, 1)
+    FIELD(CMD_PORT, DUMMY, 7, 5)
+    FIELD(CMD_PORT, RW_NUM, 3, 3)
+REG32(ADDR_PORT, 0x14)
+REG32(HD_PORT, 0x18)
+REG32(LD_PORT, 0x1c)
+REG32(FUN_SET, 0x20)
+REG32(WIP, 0x24)
+REG32(WP, 0x28)
+REG32(MODE, 0x2c)
+REG32(LEGACY_CTRL, 0x30)
+
+#define PHYTIUM_E2000_QSPI_R_MAX     (A_LEGACY_CTRL / sizeof(uint32_t) + 1)
+#define PHYTIUM_E2000_QSPI_PAGE_SIZE 256
+
+struct PhytiumE2000QSPIState {
+    SysBusDevice parent_obj;
+
+    uint32_t regs[PHYTIUM_E2000_QSPI_R_MAX];
+    RegisterInfo regs_info[PHYTIUM_E2000_QSPI_R_MAX];
+    MemoryRegion direct_mr;
+    SSIBus *spi;
+    qemu_irq cs;
+    uint8_t write_buffer[PHYTIUM_E2000_QSPI_PAGE_SIZE];
+    uint32_t write_address;
+    uint16_t write_len;
+    bool write_pending;
+    bool resetting;
+};
+
+static void phytium_e2000_qspi_select(PhytiumE2000QSPIState *s)
+{
+    qemu_irq_lower(s->cs);
+}
+
+static void phytium_e2000_qspi_deselect(PhytiumE2000QSPIState *s)
+{
+    qemu_irq_raise(s->cs);
+}
+
+static void phytium_e2000_qspi_send_address(PhytiumE2000QSPIState *s,
+                                            uint32_t address,
+                                            unsigned int length)
+{
+    int shift;
+
+    for (shift = (length - 1) * 8; shift >= 0; shift -= 8) {
+        ssi_transfer(s->spi, extract32(address, shift, 8));
+    }
+}
+
+static void phytium_e2000_qspi_send_dummy(PhytiumE2000QSPIState *s,
+                                          unsigned int cycles)
+{
+    unsigned int i;
+
+    for (i = 0; i < DIV_ROUND_UP(cycles, 8); i++) {
+        ssi_transfer(s->spi, 0);
+    }
+}
+
+static void phytium_e2000_qspi_exec_port(PhytiumE2000QSPIState *s)
+{
+    uint32_t cfg = s->regs[R_CMD_PORT];
+    uint64_t tx = s->regs[R_LD_PORT] |
+                  ((uint64_t)s->regs[R_HD_PORT] << 32);
+    uint64_t rx = 0;
+    unsigned int cs = FIELD_EX32(cfg, CMD_PORT, CS);
+    unsigned int length;
+    unsigned int i;
+
+    if (cs != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: command selects unwired CS%u\n",
+                      TYPE_PHYTIUM_E2000_QSPI, cs);
+        s->regs[R_LD_PORT] = 0;
+        s->regs[R_HD_PORT] = 0;
+        return;
+    }
+
+    phytium_e2000_qspi_select(s);
+    ssi_transfer(s->spi, FIELD_EX32(cfg, CMD_PORT, CMD));
+
+    if (FIELD_EX32(cfg, CMD_PORT, CMD_ADDR)) {
+        length = FIELD_EX32(cfg, CMD_PORT, ADDR_SEL) ? 4 : 3;
+        phytium_e2000_qspi_send_address(s, s->regs[R_ADDR_PORT], length);
+    }
+
+    if (FIELD_EX32(cfg, CMD_PORT, LATENCY)) {
+        phytium_e2000_qspi_send_dummy(
+            s, FIELD_EX32(cfg, CMD_PORT, DUMMY) + 1);
+    }
+
+    if (FIELD_EX32(cfg, CMD_PORT, DATA_XFER)) {
+        length = FIELD_EX32(cfg, CMD_PORT, RW_NUM) + 1;
+        for (i = 0; i < length; i++) {
+            rx = deposit64(rx, i * 8, 8,
+                           ssi_transfer(s->spi, extract64(tx, i * 8, 8)));
+        }
+    }
+
+    phytium_e2000_qspi_deselect(s);
+    s->regs[R_LD_PORT] = extract64(rx, 0, 32);
+    s->regs[R_HD_PORT] = extract64(rx, 32, 32);
+}
+
+static void phytium_e2000_qspi_ld_post_write(RegisterInfo *reg,
+                                             uint64_t value)
+{
+    PhytiumE2000QSPIState *s = PHYTIUM_E2000_QSPI(reg->opaque);
+
+    /*
+     * LD_PORT is the final staging write and commits the command assembled in
+     * CMD_PORT, ADDR_PORT, HD_PORT, and LD_PORT. register_reset() invokes the
+     * same callback, so suppress SPI side effects while installing defaults.
+     */
+    if (!s->resetting) {
+        phytium_e2000_qspi_exec_port(s);
+    }
+}
+
+static void phytium_e2000_qspi_flush_write_buffer(PhytiumE2000QSPIState *s)
+{
+    uint32_t cfg = s->regs[R_WR_CFG];
+    unsigned int address_len;
+    unsigned int i;
+
+    if (!s->write_pending) {
+        return;
+    }
+    if (!FIELD_EX32(cfg, WR_CFG, MODE)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: FLUSH with direct writes disabled\n",
+                      TYPE_PHYTIUM_E2000_QSPI);
+        return;
+    }
+
+    phytium_e2000_qspi_select(s);
+    ssi_transfer(s->spi, FIELD_EX32(cfg, WR_CFG, CMD));
+    address_len = FIELD_EX32(cfg, WR_CFG, ADDR_SEL) ? 4 : 3;
+    phytium_e2000_qspi_send_address(s, s->write_address, address_len);
+    for (i = 0; i < s->write_len; i++) {
+        ssi_transfer(s->spi, s->write_buffer[i]);
+    }
+    phytium_e2000_qspi_deselect(s);
+
+    s->write_pending = false;
+    s->write_address = 0;
+    s->write_len = 0;
+}
+
+static uint64_t phytium_e2000_qspi_flush_pre_write(RegisterInfo *reg,
+                                                   uint64_t value)
+{
+    PhytiumE2000QSPIState *s = PHYTIUM_E2000_QSPI(reg->opaque);
+
+    if (value & BIT(0)) {
+        phytium_e2000_qspi_flush_write_buffer(s);
+    }
+    return 0;
+}
+
+static const RegisterAccessInfo phytium_e2000_qspi_regs_info[] = {
+    { .name = "FLASH_CAP", .addr = A_FLASH_CAP,
+      .rsvd = 0xfffc0000 },
+    { .name = "RD_CFG", .addr = A_RD_CFG },
+    { .name = "WR_CFG", .addr = A_WR_CFG,
+      .rsvd = 0x00fffc00 },
+    { .name = "FLUSH", .addr = A_FLUSH,
+      .rsvd = 0xfffffffe,
+      .pre_write = phytium_e2000_qspi_flush_pre_write },
+    { .name = "CMD_PORT", .addr = A_CMD_PORT,
+      .rsvd = BIT(23) },
+    { .name = "ADDR_PORT", .addr = A_ADDR_PORT },
+    { .name = "HD_PORT", .addr = A_HD_PORT },
+    { .name = "LD_PORT", .addr = A_LD_PORT,
+      .post_write = phytium_e2000_qspi_ld_post_write },
+    { .name = "FUN_SET", .addr = A_FUN_SET },
+    { .name = "WIP", .addr = A_WIP,
+      .rsvd = 0x00ffffe0 },
+    { .name = "WP", .addr = A_WP,
+      .rsvd = 0xfffc0000 },
+    { .name = "MODE", .addr = A_MODE,
+      .rsvd = 0xffff0000 },
+    { .name = "LEGACY_CTRL", .addr = A_LEGACY_CTRL,
+      .rsvd = 0xfffffeff },
+};
+
+static const MemoryRegionOps phytium_e2000_qspi_regs_ops = {
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
+static uint64_t phytium_e2000_qspi_direct_read(void *opaque, hwaddr address,
+                                               unsigned int size)
+{
+    PhytiumE2000QSPIState *s = opaque;
+    uint32_t cfg = s->regs[R_RD_CFG];
+    uint64_t value = 0;
+    unsigned int address_len;
+    unsigned int i;
+
+    phytium_e2000_qspi_select(s);
+    ssi_transfer(s->spi, FIELD_EX32(cfg, RD_CFG, CMD));
+    address_len = FIELD_EX32(cfg, RD_CFG, ADDR_SEL) ? 4 : 3;
+    phytium_e2000_qspi_send_address(s, address, address_len);
+
+    if (FIELD_EX32(cfg, RD_CFG, LATENCY)) {
+        phytium_e2000_qspi_send_dummy(
+            s, FIELD_EX32(cfg, RD_CFG, DUMMY) + 1);
+    }
+
+    for (i = 0; i < size; i++) {
+        value = deposit64(value, i * 8, 8, ssi_transfer(s->spi, 0));
+    }
+    phytium_e2000_qspi_deselect(s);
+
+    return value;
+}
+
+static void phytium_e2000_qspi_direct_write(void *opaque, hwaddr address,
+                                            uint64_t value,
+                                            unsigned int size)
+{
+    PhytiumE2000QSPIState *s = opaque;
+    uint32_t cfg = s->regs[R_WR_CFG];
+    unsigned int i;
+
+    if (!FIELD_EX32(cfg, WR_CFG, MODE)) {
+        return;
+    }
+
+    /*
+     * The direct aperture accepts multiple CPU stores for one page program.
+     * Buffer them until FLUSH supplies the transaction boundary required by
+     * the flash command.
+     */
+    if (!s->write_pending) {
+        if ((address & ~(PHYTIUM_E2000_QSPI_PAGE_SIZE - 1)) !=
+            ((address + size - 1) &
+             ~(PHYTIUM_E2000_QSPI_PAGE_SIZE - 1))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: direct write crosses a flash page\n",
+                          TYPE_PHYTIUM_E2000_QSPI);
+            return;
+        }
+        s->write_pending = true;
+        s->write_address = address;
+        s->write_len = 0;
+    } else if (address != s->write_address + s->write_len ||
+               (s->write_address &
+                (PHYTIUM_E2000_QSPI_PAGE_SIZE - 1)) +
+               s->write_len + size > PHYTIUM_E2000_QSPI_PAGE_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: non-contiguous direct writes before FLUSH\n",
+                      TYPE_PHYTIUM_E2000_QSPI);
+        return;
+    }
+
+    for (i = 0; i < size; i++) {
+        s->write_buffer[s->write_len++] = extract64(value, i * 8, 8);
+    }
+}
+
+static const MemoryRegionOps phytium_e2000_qspi_direct_ops = {
+    .read = phytium_e2000_qspi_direct_read,
+    .write = phytium_e2000_qspi_direct_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+};
+
+static void phytium_e2000_qspi_reset(DeviceState *dev)
+{
+    PhytiumE2000QSPIState *s = PHYTIUM_E2000_QSPI(dev);
+    size_t i;
+
+    s->resetting = true;
+    for (i = 0; i < ARRAY_SIZE(phytium_e2000_qspi_regs_info); i++) {
+        register_reset(&s->regs_info[
+            phytium_e2000_qspi_regs_info[i].addr / sizeof(uint32_t)]);
+    }
+    memset(s->write_buffer, 0, sizeof(s->write_buffer));
+    s->write_address = 0;
+    s->write_len = 0;
+    s->write_pending = false;
+    s->resetting = false;
+    phytium_e2000_qspi_deselect(s);
+}
+
+static void phytium_e2000_qspi_init(Object *obj)
+{
+    PhytiumE2000QSPIState *s = PHYTIUM_E2000_QSPI(obj);
+    RegisterInfoArray *reg_array;
+
+    s->spi = ssi_create_bus(DEVICE(obj), "spi");
+    qdev_init_gpio_out_named(DEVICE(obj), &s->cs, "cs", 1);
+
+    reg_array = register_init_block32(
+        DEVICE(obj), phytium_e2000_qspi_regs_info,
+        ARRAY_SIZE(phytium_e2000_qspi_regs_info), s->regs_info, s->regs,
+        &phytium_e2000_qspi_regs_ops, false,
+        PHYTIUM_E2000_QSPI_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+
+    memory_region_init_io(&s->direct_mr, obj,
+                          &phytium_e2000_qspi_direct_ops, s,
+                          TYPE_PHYTIUM_E2000_QSPI ".direct",
+                          PHYTIUM_E2000_QSPI_DIRECT_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->direct_mr);
+}
+
+static const VMStateDescription phytium_e2000_qspi_vmsd = {
+    .name = TYPE_PHYTIUM_E2000_QSPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, PhytiumE2000QSPIState,
+                             PHYTIUM_E2000_QSPI_R_MAX),
+        VMSTATE_UINT8_ARRAY(write_buffer, PhytiumE2000QSPIState,
+                            PHYTIUM_E2000_QSPI_PAGE_SIZE),
+        VMSTATE_UINT32(write_address, PhytiumE2000QSPIState),
+        VMSTATE_UINT16(write_len, PhytiumE2000QSPIState),
+        VMSTATE_BOOL(write_pending, PhytiumE2000QSPIState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void phytium_e2000_qspi_class_init(ObjectClass *klass,
+                                          const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &phytium_e2000_qspi_vmsd;
+    device_class_set_legacy_reset(dc, phytium_e2000_qspi_reset);
+}
+
+static const TypeInfo phytium_e2000_qspi_info = {
+    .name = TYPE_PHYTIUM_E2000_QSPI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000QSPIState),
+    .instance_init = phytium_e2000_qspi_init,
+    .class_init = phytium_e2000_qspi_class_init,
+};
+
+static void phytium_e2000_qspi_register_types(void)
+{
+    type_register_static(&phytium_e2000_qspi_info);
+}
+
+type_init(phytium_e2000_qspi_register_types)
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1..202c81c5ac 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -9,6 +9,11 @@ config SIFIVE_SPI
 config SSI
     bool
 
+config PHYTIUM_E2000_QSPI
+    bool
+    select REGISTER
+    select SSI
+
 config XILINX_SPI
     bool
     select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea200..c76945ddf4 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000_QSPI', if_true: files('phytium_qspi.c'))
-- 
2.53.0


