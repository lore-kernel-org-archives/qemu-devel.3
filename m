Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C87C79F88
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJb-0004rk-P8; Fri, 04 Sep 2026 11:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJa-0004kI-4Y; Fri, 04 Sep 2026 11:58:54 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJX-0004Pg-I2; Fri, 04 Sep 2026 11:58:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4e+92eqejm0a/tJ0ubY5jdh0lleomgGEwag8T0mv0sXsELUf+NpcC5XbI3FUaZLK9SQz8+RtqlDH8axCiz2BStdMf+Xd1LEo/EoHBKv+8P7SGxDldSIWOfcDQjzJs511VTZrgvaE2sK8bDeljKwkJyl7lmL+A9wVvSwl5ayrZOu97oqeScPFF9EgkEpwa1FKiv/ekD1f101GH4xwT6pQBO1aVHqEyELcbCwZ9FUUBltXu0Kyyj++CmHGNJb5lMvxoPI4t3SV/t/sT0HEwYq5XSaBX60y1OsJUMbqHKZLySJrpskivc6AJckOIqlSjwg/3rqtmm/w4gz7P9wJc8CvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnNbYLxrgPQyKK42YTTbg07Sc7zXV92pUkmG/CAh7QU=;
 b=cG6sCW3HqXrk8VYvilNlMkhHkc0GDHTM86MkwS4OcU9r9ess8+coLgYPF1QZywGx29/vXyiSgKBbgpzv+N128nzXsu+bs5mq+aVY+oHcIDelL2NHftJSTa3nGFpY3TEkVFk+kPfkC8hgl1J6wnNB7KfC69hc7mAS9bE7nu0aK+YMk6yTJ5q7e/FBpgXfe5g0+r+c9VWcJM23y5vlwsOVa/DUt0BtwRzNG8tbmijsvPpy2JNPVLkCLjOO9fuV5WLmFmDR2Mgd0eSNis9IZ5NqrrReeykC/vqSOM+s8kr9IkBSNksakawzXFfsT2Ts5CTkHKuVQPZII4gZL3HQmHZngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnNbYLxrgPQyKK42YTTbg07Sc7zXV92pUkmG/CAh7QU=;
 b=mkkcv40bFdf7wXvjsf7GvbVTSv6Ba+lieExc//vYOqR+qZ5E8X/SJrOhM2fBHnSZ3rIVWVyM7evBep6kr6lwK9DkurfTQ/OArXfq28uW0iDqwpHJNF+DXO09iGCgpn5A4Alg4TouXeNZ6L2cHR0dDmYSvuIJ8wAPBjhnt5hpvLK8kE3CjfGMg8sgnhNzNPuHN0/xx0/sMY8IpXW+D4LSaWyep+hWUfVi09JHsqwf2x/V/QmHK9lDqBpAHfzzpiF2gwj/TH1ovm7LlMUMNlfdPq8Te72G8UUPrBXl6rBf9dKnOnOIP6B4lIS6kz/1TYNvvKHwvJDFLuJDcH4YRlx3/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:40 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:40 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 08/24] tests/qtest: add Cadence SDHCI ADMA pacing/MMIO
 reproducer
Date: Fri,  4 Sep 2026 23:57:27 +0800
Message-ID: <20260904155758.3833179-9-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8262e97e-da9e-4b7e-f42e-08df0a9d62e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|5023799004|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QjmyJ8zGgGBkZ2SLDNqsvqLXNP5Rs/P3y+1rAlcwY3wkH2ISaghi7CqYcrW9H/PA9ZsU0dfX3duSX/+omaI4MoTgtZ971V/G3iTIZ/Dm7yFtAn3F5DZllUuazyNXuuqrgyUDECyPc9ktkqzFyHz4aNyj2GrDfrQFRwMYOqO3gbWhqqDTHu0cDKPrs3Qk/E3LLis6g4f4Sz4wrpOGVG8FytFsyG6Ap8+2hiKJsz9hx3Hu/K6e2c9k+wsmIjLl30kzCscj7m5g58t5FGkaaMxEMI08LqrK46AuXt0t/yFgO0mVjmDjlQr9jabvrFnCVIDsL6BaYV3HduePcz3NXs/xeyekHwIeIx1p5xPx6ANS2tpvx+oNYRaIa8SD4EpfNecKGkHvRbhInYgbWjWMN54zwE3pvynprMir6X4fKaDZPHe5UOcNX6LmkZajU0DnvG+9NQg7Qi7BFDiWtIk6yLaxW34iK0IKbR8XoGXOnpCMPpIQlVdwGprRh8mVOBaRQ8k0C4aqJHskIV604UvHy3Ub8arbemWXxQ/wEnnkgdUG1aY09nlKMNOsKKy5QJKRnyaBEuN0CcOXjftkj3+aorNgJhfc6cPKIdLb6GidaCkeqsLaNdfL4pvUJULY7eMo0Rerb+/wMfW53KHt85B/7EpPEEGEAxLeS9/feJ9KuTfeSC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+3qpbmGmmnzMUx8UOqCezSektUY0U5Rc6IXNCdELcTMHWQGMR9aFUdBG3Sl4?=
 =?us-ascii?Q?aJbM3DwfzMDGwtUbxxO62kT1Capu0s3GkrHT0mw929u/Ncluv+JAb31ddmPN?=
 =?us-ascii?Q?WzM3eLmxU1hvyPNp+BCw4fn7I9IZP1yVBeeHPLo7ClScl71mAGhca1u/rS+y?=
 =?us-ascii?Q?LUGKAdE/WSskaE16fu+70FtZUqbPgLMU3bwT6uQNcLwJTGu+uvwWlQrxPncx?=
 =?us-ascii?Q?8uai5Z9mRWHJ0gJmn6Xzqcnkcx9y6iTcdXpmN9+MrsXmDO5AOguu6HPLUf8w?=
 =?us-ascii?Q?y1ylAwsoaTqbOZTQnrgLKqO4qirkUcx2fQWX/62bcrhyJ6JvByOyGDUc+gOq?=
 =?us-ascii?Q?irLxwOHfGeaRxzqrsOdgn1ErE58j54yE3JtsZUH/x75fmDuluOYPq0ClyA+N?=
 =?us-ascii?Q?9XkFxILFEAlljlTwMaWIbg2WASfh6aBdiU4fSNjrmZpc7hr7yUkY62cshyf2?=
 =?us-ascii?Q?l44UQFT6B7YFuccWVRUMrFNPfv8RerI8+31vetCwqTzdE3rmRaKFj+1tWFHP?=
 =?us-ascii?Q?Mtfc6AkfQ5WpBdulX2QKpBvEN2ASge97uQlCH+PubWT8iYACYdlh4anr6SZk?=
 =?us-ascii?Q?pBQrx9bAyJ2gY3xoRKibBnWmnizTUFSDKG+2zxq3VJrLSMGsI8FuVCSAQqeM?=
 =?us-ascii?Q?+hO+CFNvNHQWlnPeWald7Nvegaot2EfCClF1O+P6pZMQMV1LiNETan0IIuis?=
 =?us-ascii?Q?2FKRQwrYogOyItHQzvzE1fYpl6yEnKAIlQJFaK4Nwf5f25EdRockSu56QCCS?=
 =?us-ascii?Q?6SLcikF95sUkAOsm60y2Ohku2sBLA+WdO9NtcufCU0lCYI7TL20XclGQJsh4?=
 =?us-ascii?Q?UQajFIZ9X3O6obxrjLmaCRNsqRq+OLq6j892L/ti8CYXF5UCHSHyEDfn+Jw0?=
 =?us-ascii?Q?PMm3jZDI+m5T536Y9fsEtkW9S1i0xpIfz8TzrEIV2hljNWr4livGZPC/iYpR?=
 =?us-ascii?Q?rRbVqkpHvioCip0tn63HzSUuYADCZZR3iSSHrKAJbzLkooTZJ9h9+qIyzgUO?=
 =?us-ascii?Q?niqp1UweX8Qjb8kIlmzlhEqWY5053/w2gae+Z+ALZPNI/x5lGAY6Xk7WrZJM?=
 =?us-ascii?Q?kvfmeGv2PXaAYQl7gvi+jOWK24yVLDUCB5LTpkDOgTar+Z8pa9jb3gW7w+j/?=
 =?us-ascii?Q?sHjxKHqGZ9U9l34zvnojU+/vz1b0pif6dkBuF/TW/0STNlc3cmFog9owwN02?=
 =?us-ascii?Q?lC6eygXAu/Dbrs3y8+9qGfn3ze9OemyEyVi6e7qTZb5nm32Ne8GnynQ7dr2Z?=
 =?us-ascii?Q?4qrZZIe4zV2mljLpRF5XsiF3qlMJ3B+X7csos9wdYFKOZ7SNWRjEK8m3D5MI?=
 =?us-ascii?Q?TQMKPQ/1e7SnEqZgRdEsYVD/mXGhCizJYQ2PFeqs+c/cfM/HTaL7PCsEp4rU?=
 =?us-ascii?Q?Xx0SEPlBcviVxjlOzi8sEfXuLuhEORxvNLlxNVSG69lmh/28TW/77pZeeW5x?=
 =?us-ascii?Q?RHbzJOpGo9J6T1Y5z3TVFGU8a9EsRPHpAt+x04EJ/sKI0QK1veCuSTA88LvQ?=
 =?us-ascii?Q?8yhtWxICW9OHbIVOChMjl/n6qLQ0mM6yPsnyCXMh4mijhHmnNvY2fWWVs8zl?=
 =?us-ascii?Q?8ssirC7kpBOO69Fv2XMmvpRWMeZiwEW/CA1ge7c+dADLoQ5Xl68k5Jqh+p4e?=
 =?us-ascii?Q?lpscbTzUVtaeEjPt2Qon0hmIBG0t+fj95om3Z3h/NKLHuJRFH9/jOz3/nCQY?=
 =?us-ascii?Q?/VFj91ryvnbDOrFif6x6ai4LxdC4bkWql0H5MtYEsRYkbQXiGLZyLyuHw/2U?=
 =?us-ascii?Q?ULx3RSFBKsTfZRf3s5I9WzjnRB8DSQQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8262e97e-da9e-4b7e-f42e-08df0a9d62e5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:39.6642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22qMXOxZGwytlMvpATBGrie9TvcXGFthN3EPVQVDi6Gzfr/o4fo4Lcxql63zNG96Gf4TT4Qw5H5erYs6GcPh90+MteoGDIcUrQGrWu+57/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
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

From: Wadim Mueller <wafgo01@gmail.com>

Add an image-free qtest for the microchip-icicle-kit machine that drives
the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
(hw/sd/cadence_sdhci.c, SRS window at 0x20008200) directly over MMIO
under "-accel qtest", where QEMU_CLOCK_VIRTUAL only advances when the
test steps it.

It reproduces two aspects of the ADMA2 engine objectively, without any
guest firmware:

  1. Pacing: a 12-descriptor (> SDHC_ADMA_DESCS_PER_DELAY) non-interrupt
     ADMA2 CMD18 read completes after a model-dependent number of
     SDHC_TRANSFER_DELAY virtual-clock steps, which the test reports.

  2. MMIO coupling: a chain carrying a DMA-boundary interrupt descriptor
     yields mid-chain and reschedules on the virtual clock. With the
     clock frozen, a bare interrupt-status read must not itself resume or
     complete the transfer. This asserts the behaviour intended by "Run
     ADMA independently of MMIO": it passes on the fixed model and fails
     on a model that resumes ADMA from an MMIO read.

The SD bring-up (CMD0/CMD8/ACMD41/CMD2/CMD3/CMD7/CMD16) and the ADMA2
descriptor-table layout mirror the pattern already used by the SDHCI
device model; SDHCI register offsets and ADMA attribute bits are
reproduced locally because sdhci-internal.h is not standalone-includable
from a qtest.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
[bmeng: strengthen checks, reuse SDHCI helpers, verify data]
Signed-off-by: Bin Meng <bin.meng@processmission.com>


---

Changes in v2:
- Assert bounded ADMA pacing and MMIO-independent progress
- Reuse existing SDHCI definitions and command helpers
- Verify transferred data against a known image pattern

 MAINTAINERS                      |   1 +
 tests/qtest/cadence-sdhci-test.c | 282 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   3 +-
 3 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/cadence-sdhci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b7319d3d0..58425dcad4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2419,6 +2419,7 @@ F: include/hw/sd/sd*
 F: hw/sd/core.c
 F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
+F: tests/qtest/cadence-sdhci-test.c
 F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
 F: tests/qtest/xilinx-zynq-sdhci-test.c
diff --git a/tests/qtest/cadence-sdhci-test.c b/tests/qtest/cadence-sdhci-test.c
new file mode 100644
index 0000000000..71c1e53333
--- /dev/null
+++ b/tests/qtest/cadence-sdhci-test.c
@@ -0,0 +1,282 @@
+/*
+ * QTest for Cadence SDHCI ADMA2 pacing / MMIO coupling on the Microchip
+ * PolarFire SoC Icicle Kit (microchip-icicle-kit).
+ *
+ * Drives the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
+ * directly over MMIO under "-accel qtest", where QEMU_CLOCK_VIRTUAL only
+ * advances when the test steps it; no guest firmware runs.
+ *
+ * Copyright (c) 2026 Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/sdhci.h"
+#include "hw/sd/sdhci-internal.h"
+
+#include "libqtest.h"
+#include "libqos/sdhci-cmd.h"
+
+/*
+ * Use the controller definitions and command helper shared with the existing
+ * SDHCI qtests so this reproducer stays in sync with the device model.
+ */
+
+/* Cadence maps the generic SDHCI (SRS) register window at base + 0x200 */
+#define SDHCI_BASE        (0x20008000ULL + 0x200)
+
+/* Scratch in PolarFire DRAM (base 0x80000000): descriptor table + target */
+#define ADMA_TABLE_ADDR   0x82000000ULL
+#define ADMA_BUF_ADDR     0x82100000ULL
+
+#define BLK_LEN           512
+#define NDESC             12      /* > SDHC_ADMA_DESCS_PER_DELAY (5) */
+#define INT_DESC          5       /* ADMA interrupt descriptor */
+#define TRANSFER_SIZE     (NDESC * BLK_LEN)
+
+/* CMDREG response-type encodings (bits [1:0]) */
+#define RESP_NONE         0x0000
+#define RESP_R2           0x0001  /* 136-bit */
+#define RESP_R48          0x0002  /* 48-bit */
+#define RESP_R1B          0x0003  /* 48-bit with busy */
+
+#define ACMD41_ARG        0x40FF8000u   /* HCS + 3.3-3.6V window */
+#define CMD8_ARG          0x000001AAu   /* VHS 2.7-3.6V + check pattern */
+
+static void fill_pattern(uint8_t *buf, size_t len)
+{
+    for (size_t i = 0; i < len; i++) {
+        buf[i] = (i * 13 + 7) & 0xff;
+    }
+}
+
+static void write_pattern(int fd)
+{
+    g_autofree uint8_t *buf = g_malloc(TRANSFER_SIZE);
+    ssize_t written;
+
+    fill_pattern(buf, TRANSFER_SIZE);
+    written = pwrite(fd, buf, TRANSFER_SIZE, 0);
+    g_assert_cmpint(written, ==, TRANSFER_SIZE);
+}
+
+static void check_adma_data(QTestState *qts)
+{
+    g_autofree uint8_t *actual = g_malloc(TRANSFER_SIZE);
+    g_autofree uint8_t *expected = g_malloc(TRANSFER_SIZE);
+
+    fill_pattern(expected, TRANSFER_SIZE);
+    qtest_memread(qts, ADMA_BUF_ADDR, actual, TRANSFER_SIZE);
+    g_assert_cmpmem(actual, TRANSFER_SIZE, expected, TRANSFER_SIZE);
+}
+
+/* Issue an SD command and wait (bounded) for Command Complete */
+static uint16_t sd_cmd(QTestState *qts, uint8_t cmd, uint32_t arg,
+                       uint16_t flags)
+{
+    uint16_t sts = 0;
+    int i;
+
+    sdhci_cmd_regs(qts, SDHCI_BASE, 0, 0, arg, 0,
+                   ((uint16_t)cmd << 8) | flags);
+
+    for (i = 0; i < 1000; i++) {
+        sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+        if (sts & SDHC_NIS_CMDCMP) {
+            break;
+        }
+    }
+    g_assert_cmphex(sts & SDHC_NIS_CMDCMP, ==, SDHC_NIS_CMDCMP);
+
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);  /* w1c */
+    return sts;
+}
+
+/* Bring the SD card from idle to transfer state */
+static void sd_bring_up_card(QTestState *qts)
+{
+    uint32_t rca;
+
+    g_assert_cmphex(qtest_readl(qts, SDHCI_BASE + SDHC_PRNSTS) &
+                    SDHC_CARD_PRESENT, ==, SDHC_CARD_PRESENT);
+
+    qtest_writeb(qts, SDHCI_BASE + SDHC_SWRST, SDHC_RESET_ALL);
+    qtest_writew(qts, SDHCI_BASE + SDHC_CLKCON,
+                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_SDCLK_EN);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_ERRINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSIGEN, 0xffff);
+
+    sd_cmd(qts, 0,  0x00000000, RESP_NONE);  /* GO_IDLE_STATE */
+    sd_cmd(qts, 8,  CMD8_ARG,   RESP_R48);   /* SEND_IF_COND */
+    sd_cmd(qts, 55, 0x00000000, RESP_R48);   /* APP_CMD */
+    sd_cmd(qts, 41, ACMD41_ARG, RESP_R48);   /* SD_SEND_OP_COND */
+    sd_cmd(qts, 2,  0x00000000, RESP_R2);    /* ALL_SEND_CID */
+    sd_cmd(qts, 3,  0x00000000, RESP_R48);   /* SEND_RELATIVE_ADDR */
+
+    rca = qtest_readl(qts, SDHCI_BASE + SDHC_RSPREG0) >> 16;  /* R6 */
+
+    sd_cmd(qts, 7,  rca << 16,  RESP_R1B);   /* SELECT_CARD */
+    sd_cmd(qts, 16, BLK_LEN,    RESP_R48);   /* SET_BLOCKLEN */
+}
+
+/*
+ * Build a 32-bit ADMA2 table: per 8-byte entry word0 = (len << 16) | attr,
+ * word1 = target address.  When int_desc >= 0 that descriptor also carries
+ * the ADMA descriptor interrupt attribute, so the model yields mid-chain
+ * (rescheduling on QEMU_CLOCK_VIRTUAL) instead of running to completion.
+ */
+static void build_adma_table(QTestState *qts, int int_desc)
+{
+    for (int i = 0; i < NDESC; i++) {
+        uint8_t attr = SDHC_ADMA_ATTR_VALID | SDHC_ADMA_ATTR_ACT_TRAN;
+        uint32_t addr = (uint32_t)(ADMA_BUF_ADDR + (uint64_t)i * BLK_LEN);
+
+        if (i == int_desc) {
+            attr |= SDHC_ADMA_ATTR_INT;
+        }
+        if (i == NDESC - 1) {
+            attr |= SDHC_ADMA_ATTR_END;
+        }
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8,
+                     ((uint32_t)BLK_LEN << 16) | attr);
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8 + 4, addr);
+    }
+}
+
+/* Program the ADMA2 engine, descriptor pointer and transfer geometry */
+static void program_adma_read(QTestState *qts)
+{
+    qtest_writeb(qts, SDHCI_BASE + SDHC_HOSTCTL, SDHC_CTRL_ADMA2_32);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR, (uint32_t)ADMA_TABLE_ADDR);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR + 4,
+                 (uint32_t)(ADMA_TABLE_ADDR >> 32));
+    qtest_writel(qts, SDHCI_BASE + SDHC_BLKSIZE, BLK_LEN | (NDESC << 16));
+    qtest_writew(qts, SDHCI_BASE + SDHC_TRNMOD,
+                 SDHC_TRNS_DMA | SDHC_TRNS_BLK_CNT_EN |
+                 SDHC_TRNS_READ | SDHC_TRNS_MULTI);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ARGUMENT, 0);  /* start block 0 */
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);
+    qtest_memset(qts, ADMA_BUF_ADDR, 0xa5, TRANSFER_SIZE);
+}
+
+/* CMD18 READ_MULTIPLE_BLOCK with data present -> kicks off ADMA */
+static void kick_cmd18(QTestState *qts)
+{
+    qtest_writew(qts, SDHCI_BASE + SDHC_CMDREG,
+                 (18 << 8) | SDHC_CMD_DATA_PRESENT | RESP_R48);
+}
+
+/* Start a card-carrying icicle machine and bring the card to "tran" */
+static QTestState *icicle_start(char **tmp)
+{
+    int fd;
+    GError *err = NULL;
+    QTestState *qts;
+
+    fd = g_file_open_tmp("icicle-sdhci-XXXXXX.raw", tmp, &err);
+    g_assert_no_error(err);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(ftruncate(fd, 1 * 1024 * 1024), ==, 0);
+    write_pattern(fd);
+    close(fd);
+
+    qts = qtest_initf("-machine microchip-icicle-kit -accel qtest "
+                      "-display none -drive if=sd,file=%s,format=raw", *tmp);
+    sd_bring_up_card(qts);
+    return qts;
+}
+
+/*
+ * Facet 1 -- pacing.  A non-interrupt chain completes after a bounded number
+ * of SDHC_TRANSFER_DELAY steps.  With 12 descriptors and a quota of five per
+ * batch, completion requires exactly three virtual-clock steps.
+ */
+static void test_adma_pacing(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    const int expected_steps = DIV_ROUND_UP(NDESC,
+                                            SDHC_ADMA_DESCS_PER_DELAY);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, -1);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <=, expected_steps);
+    }
+
+    g_assert_cmpint(steps, ==, expected_steps);
+    g_assert_cmphex(sts & SDHC_NIS_TRSCMP, ==, SDHC_NIS_TRSCMP);
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+    check_adma_data(qts);
+
+    g_test_message("ADMA %d descriptors: %d clock steps to Transfer Complete",
+                   NDESC, steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+/*
+ * Facet 2 -- MMIO coupling (regression for "Run ADMA independently of MMIO").
+ * With the clock frozen, a bare interrupt-status read must not resume the
+ * transfer left pending by the mid-chain interrupt descriptor: Transfer
+ * Complete must still be clear.  A model that resumes ADMA from an MMIO read
+ * completes it on that bare read and fails the assertion.
+ */
+static void test_adma_mmio_coupling(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, INT_DESC);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+    qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+
+    sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+    g_assert_cmphex(sts & (SDHC_NIS_DMA | SDHC_NIS_TRSCMP), ==,
+                    SDHC_NIS_DMA);
+
+    sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+    g_assert_cmphex(sts & (SDHC_NIS_DMA | SDHC_NIS_TRSCMP), ==,
+                    SDHC_NIS_DMA);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <, 1000);
+    }
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+    check_adma_data(qts);
+
+    g_test_message("ADMA coupling: %d clock steps to complete after bare read",
+                   steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/microchip/icicle/sdhci/adma-pacing", test_adma_pacing);
+    qtest_add_func("/microchip/icicle/sdhci/adma-mmio-coupling",
+                   test_adma_mmio_coupling);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e7fea8c180..abe73370b6 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -304,7 +304,8 @@ qtests_riscv32 = \
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ?
-   ['mchp_pfsoc_l2cc_test'] : []) + \
+   ['cadence-sdhci-test',
+    'mchp_pfsoc_l2cc_test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-- 
2.53.0


