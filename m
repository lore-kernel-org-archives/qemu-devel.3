Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60A2C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHo-00085H-BQ; Tue, 08 Sep 2026 06:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHm-00083U-FP; Tue, 08 Sep 2026 06:42:42 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHk-0006ZW-II; Tue, 08 Sep 2026 06:42:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzIedOL20duh+M3kNKMDwBoIP/JpFEVym7RJxPnmWfdOkP2jfseitrNR3UDT+jqmvlCn66zhWcFu7/dleKdpzWF32xDwEQpstDSOroe6cgY3JgNNitjGUXZvrgx1PkwUTtsTlJWdVQHOzl0avnZMDYgdzNzs08MPrT83HP10YMkHFTV2S6ic2U9habrGl0hUwo1TQjA2gRNXoFWh5Jjwb25/GzWq7e63oV1S/htWh8Ahro3HDrfIEecHfiAR30YwSQxUopaUdUfN3t46OLTpkDmt6kxbKSnTXRufqJdyRzbVMglmnbAm89MU6VTA9z4SQZwz2Ku1Kl51r8Z5DcYRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGqVQAGR6ZHeEoqVtAVcBnIuIoEIw8XAcGVfIaVS72c=;
 b=G1V7MUma4+oY+rGJF3CGYUq60AJvXoXsJ9X6essbxe45BQ/8Mq127yljhNscDQ/w8A7Lz8COkYajDncA7iIQXsnLELjCjTcAjsrxt0oNr9qVe6ajl4OLA7yJgMENVd59mGEW6zgo6l1h452gsUOkQcTmMhEExBfj79wb2oMtaUlsXfcrL/aPJHZhgALi2k46b/bSwgkCr33IHgrOiaHQoT87l3LRJYZFhvHrUxopOG9m5cEUwuPlK47BY1NVptTVAUuI5d7FUVyh17M3J7kT9hMUYMiiH6ybTi1R/sYvGQvLiOny+HyqPNjmcmbllT74U3BmVzBv3TeIkx2/vWICzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGqVQAGR6ZHeEoqVtAVcBnIuIoEIw8XAcGVfIaVS72c=;
 b=ajWZKibhsO8EPkPl6KgGqpMdYR9/dpKLYASAZfjF6EydwHYM9amLm7JQMG9eTIBCVtrivUCGxlSSKIvkVyK0PyKdG0Ha+N2XX8Etzt9TsMqcije9ErapZ4y4ukNXh3mv6RphMUnvgawh//m+qSecgHK/sYH7nN32Sy2qmHW9i75UImlqv0EgWw8fSW4asE7MdGEcLdEtaRfkUpM8VY2ZtDCOgRqBHNE3eaVWFtq1RVznVMU8IJpY4S5/Py4wdhn09ZlUOF2ub7/lELTVHhIHz3BS3T5Miq9EVk5pi8qSKX6zn68P1JH7dOghMEOsug1udzp+DSUm/YaeIn8dTyWQdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:25 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:25 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 04/32] hw/sd: Add Phytium E2000 MCI controller
Date: Tue,  8 Sep 2026 18:41:13 +0800
Message-ID: <20260908104159.1621764-5-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: f674db14-42a0-46d0-9cd0-08df0d95ded5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: ryfHxw2LBs2yCdQNSrP0UP04d5KjqvcTcOzB8SWyL40A5z8Xie+6yCloqu9zODXkB1w/4C8qtPwK2j2zJ8DHUyT+DBMfi062ih+rJHR7oiDOVxKmHbOx0kxxlnncnKqYWCrnOTx+Q/E6m1PkUOWMKRW6/Ksk8NoN6zSiNzy0bmG8IaEFwSD8NV1H48rSrsdV7H8dMwnXo3DDhjvCEoSpwFFCcmLRZGONNfbvOGLS+XG1aFOLcMfGO+r088+QdMQtRb6mCsvJCHiYaixlVQ9ZoJUg/1vMx3L8i+JzrVYIIxuiWsVKrobgunEdeZOGjfs+0psbGuBXEJUKqYt1H5IxdxsVi9iWHrOc3/anptqGJH3lV5B3aY2j95os+DZHSwiexjySbVi4nIgeDN7rHONd1NauYk2inCcC7mzT9ofUQH4atsYKueGvogbQZoHS5RrMkLPXOkyNuZIUkYb2xf+FuTaFNCxMOewbwX4Ewecfobpo1LDfyYgAAuFUv80r/+uAwuDBLCv+WwFvlB4MzGDY9u0Fk4vRcGRdG7MLfjb2hVpO//U0yVOnrmGWeBAUrh/dyWgYBaiA2FC5HTkZynH/2bw0q6LzVi8bKBgu3vnPDWp++KElJRw/zo2wu1yhLfrjV347gxVzRFt57NmOyXy1sj65SIlckPENC91EuJmq3wY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1hfe4AbwekLhn/sDYWi8fR/1HpVR3eIlc5q/OUQLo2WO2shtHMl6dEfEWbD?=
 =?us-ascii?Q?rQxKvlmWKC8TwvbNn4Bt5XXmWqHM98Wp3M31GaxALLPa1nbNYfR4w/tQ/fT4?=
 =?us-ascii?Q?1JcdaBddSLGRuJwoB2X76/C0nn2UsrbcQlThwiWrmjUu3LhJ0v0WsE9tRZdk?=
 =?us-ascii?Q?PgDP6SRyi2kjUQG+Hlcpfq4vdSdd1+wg/4DZfAoiIs7HEve7NNN8C2YB/YI4?=
 =?us-ascii?Q?0WvTzPQyo/DXyySex4xYi0UNx8cnPXr8IsUDJQfsW83ykTZpmg2Lp74mUUt/?=
 =?us-ascii?Q?YRQiDmkWVZZip0+sLfDR6Mq6kv/qRAEKDw8ruPeePt3kiQBIBuD/sW6dCifT?=
 =?us-ascii?Q?25yOhnnYDkOX7MQtrPvDQpJpB1bI0J44I+Cl3z82qSm1XbW+VrSwNGtkDi3Z?=
 =?us-ascii?Q?yUmqMxktbAzINfsBIJ3QQcz8br5eNM1rHhfEMIpHqnR/bqc9r7o87VrScdP+?=
 =?us-ascii?Q?IX6lilDC1lKnW49iPtTlnhn/W7pDKSnDQ7ttJVgIUuM/llWROj9VBquCpALc?=
 =?us-ascii?Q?49GZOi7RmHKrVdrnm0oOT9jNsLYPgj/yVtO/uDep0ft8TS8YdwjrplctUBba?=
 =?us-ascii?Q?G7sa2NHFOaaNmahVzfyCTllTzFcrdD0wei/2TWkYLirN9wKXnKnZMIzgYCp3?=
 =?us-ascii?Q?z09wOI0h7l96hUkfU/Wu7gGaeR36aaLad2u/QHUVj9KqQ26L2AKIjnvipl3a?=
 =?us-ascii?Q?j1qKgfCDvvYVQsag1VaSIRzPdDXx7Y1/0fmPiQOQNuqd7tvIwRRLRQ5MSoI8?=
 =?us-ascii?Q?6qWwwomy6ph98/yPst3GxrIRN5mJBylkDEGPtiYnni+7GJ81SPbZGsApWIYm?=
 =?us-ascii?Q?Cq13czWlAHp8LgyJVixUm8FljuAbWndxMparHyt99gcBzAgfHaOKZMwYST7v?=
 =?us-ascii?Q?B7bBj2BpKTaRjd3G6kPz2Gm+Go+B8xFox0DEtOta5pMGCarrKLreYacggOxD?=
 =?us-ascii?Q?uZyK64/J0OtWEr+I7G/inQEdvE1CaeP/krzPvpWQuVuGFRFUnaXQ6/IhQFWF?=
 =?us-ascii?Q?C6ywmV5dXmN98kigSAamhRh3gjxFwduaInnj0Qwq8967yWmpVcPzJws+8c28?=
 =?us-ascii?Q?kIFbbcDv13J9HquOQ3Cg+bl6suUISsAkSAEHlsciIclBBiQlpMqsv2WSUk7R?=
 =?us-ascii?Q?2u1NUY7tJmwBqt9o0QFyECaHOGVNGQSm2qT7jHgGmmJhGIXIIXOW0UrSDcvE?=
 =?us-ascii?Q?XyC5fskL7ko6yLUzksm62oXfa74KutwnVxhJ2ePRaUPmSGMrjI9ruBPm5j8S?=
 =?us-ascii?Q?LScLBseKLlvvCwvs3Ryg0r6PmAaPLrBAGMxmTGTyG9QV7hG87TnehAA5EKK7?=
 =?us-ascii?Q?qXYy5XnMs7AAiRTj5wYfaNn7q9tSxo+fkIbhg3gmA7qRN9xFQI1KnFwp4cjk?=
 =?us-ascii?Q?KpJLTr+x+HbOjIdh7w+b3upJ08CkKZzv86I4BYKkYGs29rHdJOnMTJj5kzPr?=
 =?us-ascii?Q?G1D6f5L/oxqTyPKKb+rNlxdGcbc5YWakWvoEvUjAd4epwdSEjGh9Pzc24UVJ?=
 =?us-ascii?Q?5cwFT0oexah0Ru8ycyHClBLMF21CEeL6toVghVQ1IdC/amGWE9vP+zu7lByU?=
 =?us-ascii?Q?jGPCCQMA1IhWIo3wxXid8DEz+bH1OEfrKL1VUf2i81AjQofuI9BnfALM6fux?=
 =?us-ascii?Q?UPyyVruaO52QuVY9y+UIWeqch7ohz/GTho2Evyt47uDDERKL8+h9MFBZ797w?=
 =?us-ascii?Q?R9lLm1G3LPMVCzXKXeQhRQEQFwCqgxvDxcgABanCAAu+MVtGkLC2jgBkArcY?=
 =?us-ascii?Q?giF0CLrc37g/6nl59gZ3bHV5VCSUmOE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f674db14-42a0-46d0-9cd0-08df0d95ded5
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:25.0544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydUL9xrpWpDTwvDYHNz47Cbv8m7lCc419uzQIGc0Waqwiar/qPhqM2IEg2yhUu+41s5A3CEJAqqguD6XKrWJUpz/htbnnDFLmW5odPx+G2o=
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

Model the E2000 SD/MMC controller as a subclass of the reusable
DesignWare MCI implementation. Supply the E2000 hardware configuration,
FIFO depth, data window, clock-ready behavior, and vendor divider
register while inheriting the standard command and DMA paths.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 include/hw/sd/phytium_e2000_mci.h | 21 +++++++
 hw/sd/phytium_e2000_mci.c         | 95 +++++++++++++++++++++++++++++++
 hw/arm/Kconfig                    |  1 +
 hw/sd/meson.build                 |  1 +
 4 files changed, 118 insertions(+)
 create mode 100644 include/hw/sd/phytium_e2000_mci.h
 create mode 100644 hw/sd/phytium_e2000_mci.c

diff --git a/include/hw/sd/phytium_e2000_mci.h b/include/hw/sd/phytium_e2000_mci.h
new file mode 100644
index 0000000000..cc6fce06d0
--- /dev/null
+++ b/include/hw/sd/phytium_e2000_mci.h
@@ -0,0 +1,21 @@
+/*
+ * Phytium E2000 SD/MMC controller
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SD_PHYTIUM_E2000_MCI_H
+#define HW_SD_PHYTIUM_E2000_MCI_H
+
+#include "hw/sd/dw_mci.h"
+#include "qom/object.h"
+
+#define TYPE_PHYTIUM_E2000_MCI "phytium-e2000-mci"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000MciState, PHYTIUM_E2000_MCI)
+
+#endif
diff --git a/hw/sd/phytium_e2000_mci.c b/hw/sd/phytium_e2000_mci.c
new file mode 100644
index 0000000000..84cfc213de
--- /dev/null
+++ b/hw/sd/phytium_e2000_mci.c
@@ -0,0 +1,95 @@
+/*
+ * Phytium E2000 extension to the Synopsys DesignWare MCI
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
+#include "hw/sd/phytium_e2000_mci.h"
+
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+
+#define PHYTIUM_E2000_MCI_CCLK_RDY       0x058
+#define PHYTIUM_E2000_MCI_CLK_DIVIDER    0x114
+#define PHYTIUM_E2000_MCI_VERID          0x280a
+#define PHYTIUM_E2000_MCI_HCON           (BIT(27) | BIT(7))
+#define PHYTIUM_E2000_MCI_DATA_OFFSET    0x200
+#define PHYTIUM_E2000_MCI_FIFO_DEPTH     512
+
+struct PhytiumE2000MciState {
+    DwMciState parent_obj;
+};
+
+/*
+ * The vendor driver polls CCLK_RDY after programming its private divider.
+ * QEMU has no controller clock tree, so completion is immediate while the
+ * divider remains ordinary storage for firmware readback.
+ */
+static bool phytium_e2000_mci_read(DwMciState *s, hwaddr offset,
+                                   uint64_t *value, unsigned size)
+{
+    if (size != sizeof(uint32_t)) {
+        return false;
+    }
+
+    switch (offset) {
+    case PHYTIUM_E2000_MCI_CCLK_RDY:
+        *value = 1;
+        return true;
+    case PHYTIUM_E2000_MCI_CLK_DIVIDER:
+        *value = s->regs[offset / sizeof(uint32_t)];
+        return true;
+    default:
+        return false;
+    }
+}
+
+static bool phytium_e2000_mci_write(DwMciState *s, hwaddr offset,
+                                    uint64_t value, unsigned size)
+{
+    if (size != sizeof(uint32_t)) {
+        return false;
+    }
+
+    switch (offset) {
+    case PHYTIUM_E2000_MCI_CCLK_RDY:
+        return true;
+    case PHYTIUM_E2000_MCI_CLK_DIVIDER:
+        s->regs[offset / sizeof(uint32_t)] = value;
+        return true;
+    default:
+        return false;
+    }
+}
+
+static void phytium_e2000_mci_class_init(ObjectClass *klass, const void *data)
+{
+    DwMciClass *dmc = DW_MCI_CLASS(klass);
+
+    dmc->verid = PHYTIUM_E2000_MCI_VERID;
+    dmc->hcon = PHYTIUM_E2000_MCI_HCON;
+    dmc->data_offset = PHYTIUM_E2000_MCI_DATA_OFFSET;
+    dmc->fifo_depth = PHYTIUM_E2000_MCI_FIFO_DEPTH;
+    dmc->vendor_read = phytium_e2000_mci_read;
+    dmc->vendor_write = phytium_e2000_mci_write;
+}
+
+static const TypeInfo phytium_e2000_mci_info = {
+    .name = TYPE_PHYTIUM_E2000_MCI,
+    .parent = TYPE_DW_MCI,
+    .instance_size = sizeof(PhytiumE2000MciState),
+    .class_init = phytium_e2000_mci_class_init,
+};
+
+static void phytium_e2000_mci_register_types(void)
+{
+    type_register_static(&phytium_e2000_mci_info);
+}
+
+type_init(phytium_e2000_mci_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7bc85f4f9f..84d0cefd81 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -132,6 +132,7 @@ config PHYTIUM_E2000
     depends on TCG && AARCH64
     imply PCI_DEVICES
     select ARM_GIC
+    select DW_MCI
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PL011
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index d7b97cdca4..5792d0c923 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -6,6 +6,7 @@ system_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
 system_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))
 
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_mmc.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_mci.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_sdhost.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
-- 
2.53.0


