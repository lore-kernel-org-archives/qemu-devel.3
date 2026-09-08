Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37165C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHp-00086U-V3; Tue, 08 Sep 2026 06:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHo-00085G-8Z; Tue, 08 Sep 2026 06:42:44 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHl-0006YC-FE; Tue, 08 Sep 2026 06:42:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTQ94oriZICGRBKv8LeA//Gmfex2ciCg6xWzny4+P4plU8fP5qilEQvgZI2zCAnV66E6tTlTZPmRunFbz2+spVoEqmVkAYCJyHs5uP9J5CCglNiTdoeJ+z1o/9VaidFwZyI2gGVk1LD373f6Jy5Q2SOXjSsgpKLAGHyrfbcnI1hH+WATQpDb8saEUsPiBJdvrx+lADpExPt+rEDTOIDa6Ba9hpO9DR4kHxm5NGEPaCeW8Oos9xWOrAPNuvMvj2HQ6mudlhgam37HNvCnCOW/KIGue0lTrpPFwmyeZFGFTbSEMozYNlxiOsQ+Ja78LVBnE+tB1vf9I8OjH18Wk2l3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Oq+GvVJVlydmoyly+tGHe7nwWyfhIeBd2iXPv0eivg=;
 b=fx1qbBezT9dLS+MYCNMl/g1wQGCr0KSRdmrkKDVfddh4xrfKO9yqNLLBXWToDbKKDJGJzT5FYxPZ+wV+Y2YFsCnzcTFZ2jG3DC5BhWaWU9R3Rkrpg6KU0F4s9lYeXDQ4jC4/n0Waq7tYwewNBsKvoBL/M7TN4KQcM9yYkUJZtOAOlXQ2QYK65EA1XRZoLB89JWkpqMLn4YHSfED4coy4B6qrERp4335c4/rffbAFiDb801T019gy408YcynkU4jJG33mw1PCP8Xny04IybBeZLGZ6CWcXqEPtB+fbx9XcKXhqKgrI7Yy0lPHHmm4Ff/tTgnyT8litQ2RPivw4P00rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Oq+GvVJVlydmoyly+tGHe7nwWyfhIeBd2iXPv0eivg=;
 b=DHEn8E91Q0vO/5N3kFN4/ziCBxSe+ztFkFK/uXUHONv33XKhn5B7/4fUHuSx6STqSeQuAFEW1V+j7zSwbXG7I6BdQlcgTeiqLayuNRpBdGxO3UfM769w7WH/M3UJEsZgyGj6gPGK51ir7n3a/Ni3DhHWhS6kjbsHAQ+In3pLjwbMIULd8cmDVesG5KTGr6Ai2HPaH7r2NIaswBThXWdBFqFWcDFHGAgnBRxgl3owDHjsx1/Q3rCFklg3v99AaDikFW76hwX+WWvdfmjYA0loLS4QWZqmfXVUOlo2pbhdYq/n8W8iJImCwKytw0xcROE9C34yNTZHtUIJJ1n95SnCVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:29 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 06/32] tests/qtest: Add Synopsys DesignWare MCI coverage
Date: Tue,  8 Sep 2026 18:41:15 +0800
Message-ID: <20260908104159.1621764-7-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 316ff046-a02a-4650-dd31-08df0d95e11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: o7PvJHd1iedbFxhz7B3I7KsXdPeuoiFn0luHd5i0j2Ot+9CvuT099hoMay4Yhuva3GCeyuiuE4+PyNBzreKe8xA3ZRl1CuF+QtXWHvixnvWPM82hYinQIzB3WHeYvuVOiNRhdTnmk0gXiDyeB14kYd2RuHPcHdkortSOBEXtEqSaR3WP9KD1ADEPDAYPOEXlhPolqC982EIjAjynVLAo0LlqB6XvMIvIDK3wXqXY5A2Dyw5wox1/1YPoaYj9v33jv0HHNztWmIrE5aF82quDmCoY7BHY9eqTcYGg7ap4fgaWwANCSOPycfsLIm27fDiL05YeYwBaxyGiDdeok4+e9NQSLPtG2+SFivDGCoeQTBPtUskfQXOYMHefhGpgUTSkuNZgO97k8sofQSDRKjN8bpT9mHWZ40CiW5NhxFL8m9Q9gg4CkrVr5/wDEq6MykSmR4bsGu8k3Tfpo28ShDI2AhoyXy+dY5fetZ4gzyVCKawvSU92sgGmLg7HEunCynrK21/BILNz9TL+Kfz/EZGSnLlylNmpXTPYfSBJBytSRgiOXkYKWRen+uJ75dtIOwCiyHW8iSQEYWunpuVLiLpJyyM3XC4L6OdeVvjgf4b4v8HAc8hN1Z/fcQDVFleOCdy+GbrXYFLc2lG8yG9NGNiIdJEtyGktRrMEtMkTu5HtezA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SEyn4S/4Mqtgnu8Ab22I7U3xp0tbWFsMrjkNw1Rhb7NNrbFAkYCjvhe8oBEq?=
 =?us-ascii?Q?n+1m7dPxxwyBFklueNnh8QsADykqSilWTqkoZTxctQZ/vpaIf0Mcb+3S3hmj?=
 =?us-ascii?Q?hHQTniIUlmgcSyGcDtUdUv7H4Ylf3o0ifMTl9IcHUmCMP0omib2VnjctESyJ?=
 =?us-ascii?Q?6SpnTMrS7XW1pNmFEsrgV71C+LWfhSJ4rlIS4+/LWNKXXzTIDmZtRFVUi8Mc?=
 =?us-ascii?Q?d45KOdJHbCMtwZr64F6hk64Orq8FHe7IuFMZ2uT79hxWDH/bpn+/r6P/Q1Me?=
 =?us-ascii?Q?Gq4NM3t35mlWrRXhnmPQMrqxSwEGzd2AnhoYbNc8PFXLK+r2Z9YGRmAwQeAs?=
 =?us-ascii?Q?CJiectXPvevmSqO9TUDnqwUBIIEr0i3NH1OrjUd87sHdSEPyfRjnAYjollTN?=
 =?us-ascii?Q?m/hK6MOARRyhZfOUm1FKPNrs/gBI37mfxum1QEU48j/b3opi01Zhs7Gc9R8J?=
 =?us-ascii?Q?z59yo/L7dZP8P5q5e2+01MX2Mk1S++uMPMGwVxExr4UxvSyRtuW4t284XHcB?=
 =?us-ascii?Q?ZCjkcfaMNKUaPB1vGGPJxuKOShGVb7suoYPzh8c/nc4UQDBFwOFeX6MCNqcX?=
 =?us-ascii?Q?x76H2euTNCQEc+Ip4GC7DBoKjgT95sfYPLjBjogexV+uVVqEHDtTS5BtIH3S?=
 =?us-ascii?Q?FJbEQRKXRixgJBdeq3T+Z0Co4U5gwhgRVuuBcDcKppA8wU0D27alHPunkOvE?=
 =?us-ascii?Q?SrksTTclYPKo2AyhJ4rK8Zr1rJnlBtah0LTtHzRGKB56yhVY0M7wsvAACPdW?=
 =?us-ascii?Q?9NglbY+hI2QmJKUmuWahIumn5LPTEovB2Nu7YdXNeOwP0Z5W9mSVjLTTRzAK?=
 =?us-ascii?Q?52DZRZ54oh0C3QOM2GQgmx+PCvtYnfKgPW/o+5/2WNmbdQMndS2P/9tgWOC1?=
 =?us-ascii?Q?/gADd6fSJpTheO67NikmWmeyv3nQNpPK1fSL5/0T28TnZhOAVjV/jnVIQZ/N?=
 =?us-ascii?Q?k5wa9Y6jnTSKnmFRMhb19Mfr3dlOch87H/LAYTO2q2xSPcOi/IEXnSIeIEi1?=
 =?us-ascii?Q?75xNTqC7aTibimZ5hCyreq0rB5ldSjfgW19O0iTx0Gz6ka47UWX7nzpCCI4M?=
 =?us-ascii?Q?IDFGXFWuY82uAl1giF7e1OjGW2gphLI0+9ZfhN69AHHXn/aG+7SlZrwYC9z0?=
 =?us-ascii?Q?tJxJh6sNo7+BomO4WfqF1jn1GnheY7S7tzaBtVCG5Cw/eRGe5tOlXTRvlzn7?=
 =?us-ascii?Q?NTwSwQ5PsSJA+Qltai2vdWFXUTC6HjeWpCDVZTLT1KXDEMbtEvZSQBNk4w2Q?=
 =?us-ascii?Q?jvSl6UDHhxPXEe1/II+NkoegsyhA47TqFSMGon7O5BJhn5XM4WbRnRptffNe?=
 =?us-ascii?Q?hbJ1yWfXpihSx2YOHE6oOZbNpH0OeFWbhgFukLsOXKGvzWx1dW7+89xf4JJH?=
 =?us-ascii?Q?gm/YrLWQav0pVVpTJN4ENl6BSPNY7YfbrN9gWupBmhfa3vM6BEL5I9EbM4uz?=
 =?us-ascii?Q?QYZgkEx8Gj0Qo2qqhEzSR9Eqy9IYJNpuYr+XGp50tikQbx378mX8YQlS1LIn?=
 =?us-ascii?Q?eOJCv/6NJA6TeygtXKGKRfj1irENDnDBq1/nyFxCkxuKPwqhBDzbizTG5BdB?=
 =?us-ascii?Q?Xkp+LaoY8a7Z6kDhATIkq9sUuW2k3SaDOX83ZYz+huTrN2IsEWVnjsjn4ON7?=
 =?us-ascii?Q?6jFWianFBRXyxK03TwMMM9IiC2BjUY025p9IHvPl9E9G3FRMt4yWIsgTyQ/4?=
 =?us-ascii?Q?7tSZX3LU8IZY0PbOdrwfPJsHoGG1QuTYdYNcmVUOrKdwIwARc12saJ7HTrfL?=
 =?us-ascii?Q?jTyHH3Nt3l9KhruCXdPO35/4YTewaoE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316ff046-a02a-4650-dd31-08df0d95e11f
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:29.0480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwppw156bKJVQBnWr1tYdzzgQP31GFewLGt4Qpi5iXEYQ3oJWG7GZ6qLvdx0s7XBrskEIkjvwWDNEkSgUIky1gzaIqYmpcu50j5tyPVqSww=
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

Exercise the reusable DesignWare MCI behavior through the Phytium Pi
board integration. Cover register reset and interrupt handling, 64-bit
IDMAC write/read and suspend/resume paths, and FIFO PIO transfers
against an SD image.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Follow the MCI device into the E2000 SoC QOM subtree

 MAINTAINERS               |   1 +
 tests/qtest/dw_mci-test.c | 417 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build   |   1 +
 3 files changed, 419 insertions(+)
 create mode 100644 tests/qtest/dw_mci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 705a541b69..d577cdbda5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2419,6 +2419,7 @@ F: hw/sd/core.c
 F: hw/sd/dw_mci.c
 F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
+F: tests/qtest/dw_mci-test.c
 F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
 F: tests/qtest/xilinx-zynq-sdhci-test.c
diff --git a/tests/qtest/dw_mci-test.c b/tests/qtest/dw_mci-test.c
new file mode 100644
index 0000000000..5adfc0bfca
--- /dev/null
+++ b/tests/qtest/dw_mci-test.c
@@ -0,0 +1,417 @@
+/*
+ * QTests for the Synopsys DesignWare Multimedia Card Interface
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
+#include "qemu/bswap.h"
+#include "qemu/units.h"
+#include "libqtest.h"
+
+#define DW_MCI_BASE             0x28001000
+
+#define DW_MCI_CTRL             0x000
+#define DW_MCI_PWREN            0x004
+#define DW_MCI_TMOUT            0x014
+#define DW_MCI_BLKSIZ           0x01c
+#define DW_MCI_BYTCNT           0x020
+#define DW_MCI_INTMASK          0x024
+#define DW_MCI_CMDARG           0x028
+#define DW_MCI_CMD              0x02c
+#define DW_MCI_RESP0            0x030
+#define DW_MCI_MINTSTS          0x040
+#define DW_MCI_RINTSTS          0x044
+#define DW_MCI_STATUS           0x048
+#define DW_MCI_FIFOTH           0x04c
+#define DW_MCI_CDETECT          0x050
+#define DW_MCI_TCBCNT           0x05c
+#define DW_MCI_TBBCNT           0x060
+#define DW_MCI_DEBNCE           0x064
+#define DW_MCI_VERID            0x06c
+#define DW_MCI_HCON             0x070
+#define DW_MCI_RST_N            0x078
+#define DW_MCI_BMOD             0x080
+#define DW_MCI_PLDMND           0x084
+#define DW_MCI_DBADDRL          0x088
+#define DW_MCI_DBADDRU          0x08c
+#define DW_MCI_IDSTS            0x090
+#define DW_MCI_IDINTEN          0x094
+#define DW_MCI_DSCADDRL         0x098
+#define DW_MCI_DSCADDRU         0x09c
+#define DW_MCI_BUFADDRL         0x0a0
+#define DW_MCI_BUFADDRU         0x0a4
+#define DW_MCI_FIFO             0x200
+
+#define DW_MCI_CTRL_INT_ENABLE  BIT(4)
+#define DW_MCI_CTRL_USE_IDMAC   BIT(25)
+
+#define DW_MCI_CMD_RESP_EXP     BIT(6)
+#define DW_MCI_CMD_RESP_LONG    BIT(7)
+#define DW_MCI_CMD_DAT_EXP      BIT(9)
+#define DW_MCI_CMD_DAT_WR       BIT(10)
+#define DW_MCI_CMD_UPD_CLK      BIT(21)
+#define DW_MCI_CMD_START        BIT(31)
+
+#define DW_MCI_INT_CMD_DONE     BIT(2)
+#define DW_MCI_INT_DATA_OVER    BIT(3)
+#define DW_MCI_INT_RTO          BIT(8)
+
+#define DW_MCI_BMOD_ENABLE      BIT(7)
+
+#define DW_MCI_IDSTS_TI         BIT(0)
+#define DW_MCI_IDSTS_RI         BIT(1)
+#define DW_MCI_IDSTS_DU         BIT(4)
+#define DW_MCI_IDSTS_NI         BIT(8)
+#define DW_MCI_IDSTS_AI         BIT(9)
+
+#define DW_MCI_IDMAC_LD         BIT(2)
+#define DW_MCI_IDMAC_FS         BIT(3)
+#define DW_MCI_IDMAC_OWN        BIT(31)
+
+#define DW_MCI_DESC_ADDR        0x80010000
+#define DW_MCI_DATA_ADDR        0x80011000
+#define DW_MCI_READ_ADDR        0x80012000
+#define DW_MCI_BLOCK_SIZE       512
+#define DW_MCI_IMAGE_SIZE       (1 * MiB)
+
+static QTestState *dw_mci_start(const char *sd_path)
+{
+    if (sd_path) {
+        return qtest_initf("-machine phytium-pi -m 1G -display none "
+                           "-drive file=%s,format=raw,if=sd,index=1",
+                           sd_path);
+    }
+
+    return qtest_init("-machine phytium-pi -m 1G -display none");
+}
+
+static char *dw_mci_create_image(void)
+{
+    g_autoptr(GError) error = NULL;
+    char *path = NULL;
+    int fd;
+    int ret;
+
+    fd = g_file_open_tmp("dw-mci-XXXXXX", &path, &error);
+    g_assert_no_error(error);
+    g_assert_cmpint(fd, >=, 0);
+    ret = ftruncate(fd, DW_MCI_IMAGE_SIZE);
+    g_assert_cmpint(ret, ==, 0);
+    close(fd);
+
+    return path;
+}
+
+static uint32_t dw_mci_command(QTestState *qts, uint32_t index,
+                               uint32_t argument, uint32_t flags)
+{
+    uint32_t raw;
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_RINTSTS, UINT32_MAX);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CMDARG, argument);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CMD,
+                 DW_MCI_CMD_START | flags | index);
+    raw = qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS);
+    g_assert_cmphex(raw & DW_MCI_INT_CMD_DONE, ==, DW_MCI_INT_CMD_DONE);
+    g_assert_cmphex(raw & DW_MCI_INT_RTO, ==, 0);
+
+    return qtest_readl(qts, DW_MCI_BASE + DW_MCI_RESP0);
+}
+
+static void dw_mci_init_card(QTestState *qts)
+{
+    uint32_t rca;
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_PWREN, 1);
+    dw_mci_command(qts, 0, 0, 0);
+    dw_mci_command(qts, 55, 0, DW_MCI_CMD_RESP_EXP);
+    dw_mci_command(qts, 41, 0x41200000, DW_MCI_CMD_RESP_EXP);
+    dw_mci_command(qts, 2, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_RESP_LONG);
+    rca = dw_mci_command(qts, 3, 0, DW_MCI_CMD_RESP_EXP) & 0xffff0000;
+    g_assert_cmphex(rca, !=, 0);
+    dw_mci_command(qts, 7, rca, DW_MCI_CMD_RESP_EXP);
+    dw_mci_command(qts, 16, DW_MCI_BLOCK_SIZE, DW_MCI_CMD_RESP_EXP);
+}
+
+static void dw_mci_write_descriptor(QTestState *qts, uint32_t control,
+                                    uint32_t buffer)
+{
+    qtest_writel(qts, DW_MCI_DESC_ADDR, control);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 4, 0);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 8, DW_MCI_BLOCK_SIZE);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 12, 0);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 16, buffer);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 20, 0);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 24, 0);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 28, 0);
+}
+
+static void dw_mci_prepare_idmac(QTestState *qts, uint32_t interrupts)
+{
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CTRL,
+                 DW_MCI_CTRL_USE_IDMAC);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BMOD,
+                 DW_MCI_BMOD_ENABLE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BLKSIZ,
+                 DW_MCI_BLOCK_SIZE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BYTCNT,
+                 DW_MCI_BLOCK_SIZE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_DBADDRL,
+                 DW_MCI_DESC_ADDR);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_DBADDRU, 0);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_IDINTEN, interrupts);
+}
+
+static void test_registers_and_irq(void)
+{
+    QTestState *qts = dw_mci_start(NULL);
+
+    qtest_irq_intercept_out_named(qts, "/machine/soc/mci1", "sysbus-irq");
+
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_CTRL), ==,
+                    BIT(24));
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_STATUS) &
+                    (BIT(1) | BIT(2)), ==, BIT(1) | BIT(2));
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_TMOUT), ==,
+                    0xffffff40);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BLKSIZ), ==,
+                    DW_MCI_BLOCK_SIZE);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BYTCNT), ==,
+                    DW_MCI_BLOCK_SIZE);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_FIFOTH), ==,
+                    0x01ff0000);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_CDETECT), ==, 1);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DEBNCE), ==,
+                    0x00ffffff);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_VERID), ==,
+                    0x280a);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_HCON), ==,
+                    0x08000080);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RST_N), ==, 1);
+
+    /* Exercise the 64-bit IDMAC layout selected by HCON.ADDR_CONFIG */
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_DBADDRL,
+                 DW_MCI_DESC_ADDR + 3);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DBADDRL), ==,
+                    DW_MCI_DESC_ADDR);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_DBADDRU, 1);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DBADDRU), ==, 1);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_IDINTEN,
+                 DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDINTEN), ==,
+                    DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DSCADDRU), ==, 0);
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_RINTSTS, UINT32_MAX);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CMD,
+                 DW_MCI_CMD_START | DW_MCI_CMD_UPD_CLK);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_CMD_DONE, ==, 0);
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CTRL,
+                 DW_MCI_CTRL_INT_ENABLE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_INTMASK,
+                 DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CMD,
+                 DW_MCI_CMD_START | DW_MCI_CMD_RESP_EXP);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_MINTSTS), ==,
+                    DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_RINTSTS,
+                 DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_CTRL), ==,
+                    BIT(24));
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BMOD), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DBADDRL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DBADDRU), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDINTEN), ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_idmac_write_and_read(void)
+{
+    g_autofree char *sd_path = dw_mci_create_image();
+    uint8_t pattern[DW_MCI_BLOCK_SIZE];
+    uint8_t actual[DW_MCI_BLOCK_SIZE];
+    uint8_t zero[DW_MCI_BLOCK_SIZE] = { 0 };
+    QTestState *qts = dw_mci_start(sd_path);
+    uint32_t status;
+    size_t i;
+    ssize_t size;
+    int fd;
+
+    qtest_irq_intercept_out_named(qts, "/machine/soc/mci1", "sysbus-irq");
+    dw_mci_init_card(qts);
+
+    for (i = 0; i < sizeof(pattern); i++) {
+        pattern[i] = i ^ 0xa5;
+    }
+    qtest_memwrite(qts, DW_MCI_DATA_ADDR, pattern, sizeof(pattern));
+    dw_mci_write_descriptor(qts,
+                            DW_MCI_IDMAC_OWN | DW_MCI_IDMAC_FS |
+                            DW_MCI_IDMAC_LD,
+                            DW_MCI_DATA_ADDR);
+    dw_mci_prepare_idmac(qts, DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    dw_mci_command(qts, 24, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_DAT_EXP |
+                   DW_MCI_CMD_DAT_WR);
+
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_DESC_ADDR) &
+                    DW_MCI_IDMAC_OWN, ==, 0);
+    status = qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDSTS);
+    g_assert_cmphex(status & (DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI), ==,
+                    DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DSCADDRL), ==,
+                    DW_MCI_DESC_ADDR);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DSCADDRU), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BUFADDRL), ==,
+                    DW_MCI_DATA_ADDR);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BUFADDRU), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_DATA_OVER, ==, DW_MCI_INT_DATA_OVER);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_IDSTS,
+                 DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_memwrite(qts, DW_MCI_READ_ADDR, zero, sizeof(zero));
+    dw_mci_write_descriptor(qts,
+                            DW_MCI_IDMAC_OWN | DW_MCI_IDMAC_FS |
+                            DW_MCI_IDMAC_LD,
+                            DW_MCI_READ_ADDR);
+    dw_mci_prepare_idmac(qts, DW_MCI_IDSTS_RI | DW_MCI_IDSTS_NI);
+    dw_mci_command(qts, 17, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_DAT_EXP);
+    qtest_memread(qts, DW_MCI_READ_ADDR, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), pattern, sizeof(pattern));
+    status = qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDSTS);
+    g_assert_cmphex(status & (DW_MCI_IDSTS_RI | DW_MCI_IDSTS_NI), ==,
+                    DW_MCI_IDSTS_RI | DW_MCI_IDSTS_NI);
+    qtest_quit(qts);
+
+    fd = open(sd_path, O_RDONLY);
+    g_assert_cmpint(fd, >=, 0);
+    size = read(fd, actual, sizeof(actual));
+    close(fd);
+    g_assert_cmpint(size, ==, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), pattern, sizeof(pattern));
+    unlink(sd_path);
+}
+
+static void test_idmac_suspend_and_resume(void)
+{
+    g_autofree char *sd_path = dw_mci_create_image();
+    uint8_t pattern[DW_MCI_BLOCK_SIZE];
+    QTestState *qts = dw_mci_start(sd_path);
+    uint32_t status;
+    size_t i;
+
+    qtest_irq_intercept_out_named(qts, "/machine/soc/mci1", "sysbus-irq");
+    dw_mci_init_card(qts);
+
+    for (i = 0; i < sizeof(pattern); i++) {
+        pattern[i] = i ^ 0x69;
+    }
+    qtest_memwrite(qts, DW_MCI_DATA_ADDR, pattern, sizeof(pattern));
+    dw_mci_write_descriptor(qts, 0, DW_MCI_DATA_ADDR);
+    dw_mci_prepare_idmac(qts,
+                         DW_MCI_IDSTS_TI | DW_MCI_IDSTS_DU |
+                         DW_MCI_IDSTS_NI | DW_MCI_IDSTS_AI);
+    dw_mci_command(qts, 24, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_DAT_EXP |
+                   DW_MCI_CMD_DAT_WR);
+
+    status = qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDSTS);
+    g_assert_cmphex(status & (DW_MCI_IDSTS_DU | DW_MCI_IDSTS_AI), ==,
+                    DW_MCI_IDSTS_DU | DW_MCI_IDSTS_AI);
+    g_assert_cmphex((status >> 13) & 0xf, ==, 1);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_DATA_OVER, ==, 0);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_IDSTS,
+                 DW_MCI_IDSTS_DU | DW_MCI_IDSTS_AI);
+    g_assert_false(qtest_get_irq(qts, 0));
+    dw_mci_write_descriptor(qts,
+                            DW_MCI_IDMAC_OWN | DW_MCI_IDMAC_FS |
+                            DW_MCI_IDMAC_LD,
+                            DW_MCI_DATA_ADDR);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_PLDMND, 0);
+
+    status = qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDSTS);
+    g_assert_cmphex(status & (DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI), ==,
+                    DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_cmphex((status >> 13) & 0xf, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_DATA_OVER, ==, DW_MCI_INT_DATA_OVER);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
+    unlink(sd_path);
+}
+
+static void test_fifo_data_port(void)
+{
+    g_autofree char *sd_path = dw_mci_create_image();
+    uint8_t pattern[DW_MCI_BLOCK_SIZE];
+    uint8_t actual[DW_MCI_BLOCK_SIZE];
+    QTestState *qts = dw_mci_start(sd_path);
+    size_t i;
+    ssize_t size;
+    int fd;
+
+    dw_mci_init_card(qts);
+    for (i = 0; i < sizeof(pattern); i++) {
+        pattern[i] = i ^ 0x3c;
+    }
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BLKSIZ, DW_MCI_BLOCK_SIZE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BYTCNT, DW_MCI_BLOCK_SIZE);
+    dw_mci_command(qts, 24, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_DAT_EXP |
+                   DW_MCI_CMD_DAT_WR);
+    for (i = 0; i < sizeof(pattern); i += sizeof(uint32_t)) {
+        qtest_writel(qts, DW_MCI_BASE + DW_MCI_FIFO + (i % 64),
+                     ldl_le_p(pattern + i));
+    }
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_TCBCNT), ==,
+                    DW_MCI_BLOCK_SIZE);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_TBBCNT), ==,
+                    DW_MCI_BLOCK_SIZE);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_DATA_OVER, ==, DW_MCI_INT_DATA_OVER);
+    qtest_quit(qts);
+
+    fd = open(sd_path, O_RDONLY);
+    g_assert_cmpint(fd, >=, 0);
+    size = read(fd, actual, sizeof(actual));
+    close(fd);
+    g_assert_cmpint(size, ==, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), pattern, sizeof(pattern));
+    unlink(sd_path);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("dw-mci/registers-and-irq", test_registers_and_irq);
+    qtest_add_func("dw-mci/idmac-write-and-read", test_idmac_write_and_read);
+    qtest_add_func("dw-mci/idmac-suspend-and-resume",
+                   test_idmac_suspend_and_resume);
+    qtest_add_func("dw-mci/fifo-data-port", test_fifo_data_port);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c3593f7530..a7fc37e09d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -282,6 +282,7 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  (config_all_devices.has_key('CONFIG_PHYTIUM_E2000') ? ['dw_mci-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_ARM_VIRT') ?
    ['iommu-smmuv3-test'] : []) + \
-- 
2.53.0


