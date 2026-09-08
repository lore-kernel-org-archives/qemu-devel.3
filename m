Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A18C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIE-0000MX-Jw; Tue, 08 Sep 2026 06:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tID-0000Jt-3p; Tue, 08 Sep 2026 06:43:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIB-0006ZW-3O; Tue, 08 Sep 2026 06:43:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0cfdPngvSm45VTolTKtnw4uwMl1EQzeKqVdhfxjFvJprP5QnKiEOts1W+kgNXHjmu8d8ZFXgRGvmuuyg/iHY51UkdN9yW5F1ittxJW907xY3IPXf3Ygcgas5RWh6XhtxnHmh8rFP1QZxVZecPiSr0JFsnVGqMeMSdet9JPuPL0y7w99crrIXCeW6QGs9MIa3tcHOuctzlhC/kMFY08jDWVAEWH4ZGgLo3S8mk5MPWroGCgOuXuzdmXMHpIqHC0xkF4SMfuyvSMlmQa9d3RPNusUmAbAyE8oflmlwjbx5iH1N0CtbHfOTT9cZk5m974a/9qOXPJJwJ3BX4MpF9LbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMI2f09Vj66oLq86zkYSRKYrp5wwQ7xcflmxJClFwQY=;
 b=K413Y2Jy7YSC4HY3gHVgKWnBnoDMY3rUF8jL4FsUPXnZ64Noz9H4A38ccLFPlH3gvyd29sEpS74pFAfJlML1xRf8wr6k+olEEasCpXSnybOp6piifd2E5/ArdjVwAO9FWQa1PDADZhDRWOgA0+yLj51F7pD/uMVFHlXXmpi0OzdKUnA2cSQZ4iTQbul7WIlLSmqLuiou+6autNPBLJK0GL+AGmy7FySYm/hUuVxt75iq+qSXF/WtRzStYoU2O6Da06gnERyW78N37p5AOLBtIY5/Rg14r0gWcYaBtWKylvjPcxQhhLfHv9z/Pjhjc71oLGF9XkothkuOyGVJNJvXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMI2f09Vj66oLq86zkYSRKYrp5wwQ7xcflmxJClFwQY=;
 b=sYwXWhQ1jEuBnP/hxXPj+k4aCDKd9twUXd220rAxpFBAKO3r+gjdzgxDebV+uG7u8jNrNCf2Oy+2fYVJ73PK7tz/j3j5oQ7mj5vjFXnBiXHO071/43TOUWEaJ1KvojTHFjlxsb2yfeM1MvZP/5DUjTmfnWUBv9QgQuP9//w4tMJOL8Nm3MmKzClIaLRjELvwxIdIJfzS5J3zlvUSi3GzF71WTWWbQLb2VbS4Nhgs060So9/vpLA6x1lhks8SyT/yBlO0RE6S8DRBZ3SILT2EykZcGCWMleSYFLxCqB21nnZRCkwEoO3gCKAy6+8nbqW4zHKHZ8rMAqkY/wQW5MBYOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:54 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 21/32] hw/misc: Model the Phytium E2000 random generator
Date: Tue,  8 Sep 2026 18:41:30 +0800
Message-ID: <20260908104159.1621764-22-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 16b3e039-d294-4f86-28ca-08df0d95edf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: rpckdYMiCthl+GA8qAaI4QuLIyZCOdXlAA3GDiUM6Fw01+hTiGnluSXo1Njgl70thvADSAshVfk3wCPQYASeA7qd66C5N+g9hgkh6XjSCIpFiLt4XWYAPvQBWFgDHJY9+roYsFqnqkM8hHzCgCyMGiIbJ8zNgAGKRBbxxKinh9m4LRqVqAF7QoAXmxG0ZjLrZfiT6EJ60e2NQftIlAEJcqjZ1A04WmXdyrQtcuzZET7lGL8NMpz4TPOB5f+ZbMCGDVIPgMp538zMFzEPLzIv3xVvTQPRRCn9bNjNubf/OODMBmfpa7mKwXNgXseczMjfjZWBbIMW7ZqMcewBQCqS7U9TcjKu5wIACEnVe/q0dTTDxnu8A2wA2/w1nMvYVICXpEVs2/sdJrrmsIVj4YsYdqkvfordffc8ja6AHCuo2OGYybVBxaiSp8834ABIF/nLVkhvj63Wbs3VMYyIvFA547BRDx17fWJ7rlt7twc4bKjGNZIMxGtGrQzN7DfMrVTGC6w9cuwE7pitQW8ZP5/CXHbvJNvi2/Lrww3tLbjWXki4Cck3loruAJHf3U3tITNEJ8EbpPQIJ28O6ZStmgmw7WYXOtn/zPYv86ghwu0HdUZznUnDWrZ1yXJZ1t0WxEZc1mzqe3QLuoRIUohFQFeAxQsXMIKcf6gxfoz/wWIfiMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtDl6a+9X43nG7329ahmDet3FbaUO2UBbP1104TyEvTjZUWUdpLsk7JgXKfe?=
 =?us-ascii?Q?Pc/3PFbfSmZoBpulvED2nLvEg4Vz7ZOJloF7n4YoD67Lk//wFBErfgYHFC5a?=
 =?us-ascii?Q?qT2TNwiQf95dJUcb9Fxl7j8q9k/8p2bXqPzt+JMMrdiPFMGakblhptGYXkAK?=
 =?us-ascii?Q?t/HFjdKPrlpoznyhYm2aiHigSAbWxOkLm3DbRp1OvNMWCbGEfEMQRWMajZ7m?=
 =?us-ascii?Q?OIDFNf1RPxaNsEA/jSXnw/cMTng9r1nWXkY3kVzcyegLknu6Mq+UdmoML9Rm?=
 =?us-ascii?Q?wbvTFs9Za1q1NzcWAwyN2KZox4su03dLUdlQPoxthWU1UN5vihl9lza+/ayx?=
 =?us-ascii?Q?yEWJ/1b1imKktagAeK1XWGF0TCv0QTM2EF2vUtMpkgm/Y00sX2GPhRGgd10Q?=
 =?us-ascii?Q?Lr2TssW1ky9T0RVgXWR4Kvilh1NOH6NanuAqWlKjNJhtLUIo0ELRFxA2krZN?=
 =?us-ascii?Q?U5ugu9NXKO+jCBPoKut/PfKR9GmSPuPZ/K9o6oST1H6ovOtWd6PNLonGi1sk?=
 =?us-ascii?Q?099s0fat3KMVx8zNvgehVHmUWbFZiq4uv+B1VNXQZ4+sW7UVwGdWVKnZZTtp?=
 =?us-ascii?Q?UJj3Kghckq5I56E/ZwVgX4aSPE5Xje/alv0pV9sc+Xb2xdRZxtsJikNWv6J/?=
 =?us-ascii?Q?YcuHi9qW67JZGSHesJc1rPKXxCQy+UtxcUXhfqWbVpiCNuow6A5nPX6Zwlqz?=
 =?us-ascii?Q?ubDQtsHGEu2Z69WXFigBiikCVZbOFDVVtBDxmsq0RYuRlcSHpCT3lE+2K9jn?=
 =?us-ascii?Q?ETybFvevO5CvDm4O4lYG7c5EuoQpa+3mnneb7rZVsCvOXzXqp2y3ZuE+pXe6?=
 =?us-ascii?Q?nVUusfoE7vaLyhynj/IBvrDoA+9ACaogRvLBsMh60tzy3YvTTFbwWo0A34Vi?=
 =?us-ascii?Q?Ln60JzySJ8dOVlgtnWvzyCs+zVH0PdfLu7em0V6TbM0lIu70/EkQEwR5jkN+?=
 =?us-ascii?Q?6+ZuZzNxvxVu/D6iHwDKm++VdEiAJZDcmKoSJLt+wtZ/OdaC9A9TRcfozjL1?=
 =?us-ascii?Q?zMozNkjlwFM2lBvV3fglg803C5NZIb8XD6GdiAv7l3lG2oLYhnUwQEr675zK?=
 =?us-ascii?Q?RHfTIHrniQmoUzKr4VpYiYcm6r2nrcorDBnO+LNs36GUKjAW9/a3RrnTe6ZI?=
 =?us-ascii?Q?klhphMMRnGNRWIfxbq6W2oLYjC0lLPjWrs+m73FLybmXeap+m6ipgLl3lHlp?=
 =?us-ascii?Q?vcpL7/fNVqOUUVshry3V/jy2UL3tZcvHttOqMeeZ2E5SIA5pIpd6HZJOSSks?=
 =?us-ascii?Q?OCHFnErxSJ7dhwQxMMiFWYepvmco03JCHBVspW2zHRMlGFObzq5HyH4Ezdrg?=
 =?us-ascii?Q?XO06+QvWD3q4SyMTBGGjz0F+afJZkd65X6xEsmiTAO/+jczYai+DWP0nhufn?=
 =?us-ascii?Q?N+KfMZBh82g6brfHJMnwlGQ+pY5DfCqgLiRYr3a4AU00cYKg8bMdMkVh6gqh?=
 =?us-ascii?Q?MGfMgHvW1PzeBArwAJtoUeZSJKSR+56wXeeXhxgQoOexG8l6JCQvot8gC5Zu?=
 =?us-ascii?Q?IyMFxBzWrMH4RTw5ShuSgpvjp3ynX9hKCm8WXfncNU4sS/XsHo+qGi8nb77/?=
 =?us-ascii?Q?T8RG0ks+UzCG+L2KkSFR36oJdnvaWd0cQgXZCP6H9htljBsGfKRf42xllOTT?=
 =?us-ascii?Q?2FxKksPgu96vO8ktE8hsPeCQTbA9R6vdVAB0V5sStg+pU29h/mDpihgNFsQN?=
 =?us-ascii?Q?shl0yYoqxza2F9l14K5f7zFUZzL0gUnmfLqoma53El3jhgwC/hEJJoX5Em36?=
 =?us-ascii?Q?TJGu3Tm/+C4rvgGiM6gEbwSOvWJl2P8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b3e039-d294-4f86-28ca-08df0d95edf6
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:50.4351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZJsTQBuJOMPWnFuxxg40GXsWceS3D2pLL7FtCCb87st6r2rUtVftyRdTQ5gbH7mJiWDRGfXtMxa8J5AHjGqB0RNCrIWR9jc5f5d19RM5yA=
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

Implement the polled control, mode, status, data, and reseed registers
for the E2000 hardware RNG. Use the guest random source for data and
preserve deterministic replay.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 include/hw/misc/phytium_e2000_rng.h |  23 ++++
 hw/misc/phytium_e2000_rng.c         | 182 ++++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 3 files changed, 206 insertions(+)
 create mode 100644 include/hw/misc/phytium_e2000_rng.h
 create mode 100644 hw/misc/phytium_e2000_rng.c

diff --git a/include/hw/misc/phytium_e2000_rng.h b/include/hw/misc/phytium_e2000_rng.h
new file mode 100644
index 0000000000..d8c73e20a9
--- /dev/null
+++ b/include/hw/misc/phytium_e2000_rng.h
@@ -0,0 +1,23 @@
+/*
+ * Phytium E2000 random number generator
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_PHYTIUM_E2000_RNG_H
+#define HW_MISC_PHYTIUM_E2000_RNG_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_PHYTIUM_E2000_RNG "phytium-e2000-rng"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000RNGState, PHYTIUM_E2000_RNG)
+
+#define PHYTIUM_E2000_RNG_MMIO_SIZE 0x1000
+
+#endif
diff --git a/hw/misc/phytium_e2000_rng.c b/hw/misc/phytium_e2000_rng.c
new file mode 100644
index 0000000000..6862fb9ec6
--- /dev/null
+++ b/hw/misc/phytium_e2000_rng.c
@@ -0,0 +1,182 @@
+/*
+ * Phytium E2000 random number generator
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
+#include "hw/misc/phytium_e2000_rng.h"
+
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/guest-random.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define TRNG_CR             0x00
+#define TRNG_CR_RNGEN       BIT(0)
+#define TRNG_CR_ROSEN_MASK  MAKE_64BIT_MASK(4, 4)
+#define TRNG_CR_DIEN        BIT(16)
+#define TRNG_CR_ERIEN       BIT(17)
+#define TRNG_CR_IRQEN       BIT(24)
+#define TRNG_CR_MASK        (TRNG_CR_RNGEN | TRNG_CR_ROSEN_MASK | \
+                             TRNG_CR_DIEN | TRNG_CR_ERIEN | TRNG_CR_IRQEN)
+
+#define TRNG_MSEL           0x04
+#define TRNG_MSEL_PRNG      BIT(0)
+
+#define TRNG_SR             0x08
+#define TRNG_SR_DRDY        BIT(1)
+
+#define TRNG_DR             0x0c
+
+#define TRNG_RESEED         0x40
+
+struct PhytiumE2000RNGState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t control;
+    uint32_t mode;
+};
+
+static bool phytium_e2000_rng_enabled(PhytiumE2000RNGState *s)
+{
+    return s->control & TRNG_CR_RNGEN;
+}
+
+static uint64_t phytium_e2000_rng_read(void *opaque, hwaddr offset,
+                                       unsigned int size)
+{
+    PhytiumE2000RNGState *s = opaque;
+    uint32_t value;
+
+    switch (offset) {
+    case TRNG_CR:
+        return s->control;
+    case TRNG_MSEL:
+        return s->mode;
+    case TRNG_SR:
+        /*
+         * Generation takes zero virtual time, so DRDY is reasserted as soon
+         * as the guest acknowledges the previous batch.
+         */
+        return phytium_e2000_rng_enabled(s) ? TRNG_SR_DRDY : 0;
+    case TRNG_DR:
+        if (!phytium_e2000_rng_enabled(s)) {
+            return 0;
+        }
+        qemu_guest_getrandom_nofail(&value, sizeof(value));
+        return value;
+    case TRNG_RESEED:
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+}
+
+static void phytium_e2000_rng_write(void *opaque, hwaddr offset,
+                                    uint64_t value, unsigned int size)
+{
+    PhytiumE2000RNGState *s = opaque;
+
+    switch (offset) {
+    case TRNG_CR:
+        s->control = value & TRNG_CR_MASK;
+        break;
+    case TRNG_MSEL:
+        s->mode = value & TRNG_MSEL_PRNG;
+        break;
+    case TRNG_SR:
+        break;
+    case TRNG_DR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only data register\n",
+                      DEVICE(s)->canonical_path);
+        break;
+    case TRNG_RESEED:
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps phytium_e2000_rng_ops = {
+    .read = phytium_e2000_rng_read,
+    .write = phytium_e2000_rng_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void phytium_e2000_rng_reset(Object *obj, ResetType type)
+{
+    PhytiumE2000RNGState *s = PHYTIUM_E2000_RNG(obj);
+
+    s->control = 0;
+    s->mode = 0;
+}
+
+static const VMStateDescription phytium_e2000_rng_vmsd = {
+    .name = TYPE_PHYTIUM_E2000_RNG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(control, PhytiumE2000RNGState),
+        VMSTATE_UINT32(mode, PhytiumE2000RNGState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void phytium_e2000_rng_init(Object *obj)
+{
+    PhytiumE2000RNGState *s = PHYTIUM_E2000_RNG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &phytium_e2000_rng_ops, s,
+                          TYPE_PHYTIUM_E2000_RNG,
+                          PHYTIUM_E2000_RNG_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void phytium_e2000_rng_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->desc = "Phytium E2000 random number generator";
+    dc->vmsd = &phytium_e2000_rng_vmsd;
+    rc->phases.enter = phytium_e2000_rng_reset;
+}
+
+static const TypeInfo phytium_e2000_rng_info = {
+    .name = TYPE_PHYTIUM_E2000_RNG,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000RNGState),
+    .instance_init = phytium_e2000_rng_init,
+    .class_init = phytium_e2000_rng_class_init,
+};
+
+static void phytium_e2000_rng_register_types(void)
+{
+    type_register_static(&phytium_e2000_rng_info);
+}
+
+type_init(phytium_e2000_rng_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 8579004e88..60f36fa80a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -19,6 +19,7 @@ system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_ddr.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_mhu.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_pbr.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_rng.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
-- 
2.53.0


