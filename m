Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64FAC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHv-00089L-7m; Tue, 08 Sep 2026 06:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHt-00088F-Tr; Tue, 08 Sep 2026 06:42:49 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHs-0006ZW-Ba; Tue, 08 Sep 2026 06:42:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qml8wepkVJgelFJJJJACz745gS8llFc8E0v+GGLQfMmSHRAdt+2r4pNL80e2YX33T8QU82pcLMCuPLimjRqkDVS6R8kKy3WSbrWn+A7HAkvylgD3LTFl+fJKv8bxqS6VE3TQZHDZ2ZKeB3n+6g93YZWfA2rPOk1cMwzMXfZu1trIC4OMBYR8q89F4nv0l/J8snwEdfZE6L5H1wUgk/+cwx6eg2bDFNKsf0EBXW6mXquo4T2OCtdltuC+UdIUpc4+RSZB+I6F/MIfS/o2ipLxPPssyOi3lAvr0FjcZdHDU09J3VB455JcSeFp64P8Sz4MbwR9qmq0j+O0DN+Lwa929w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SelA9lmKcWlohQ3TChZKItjdiMZKDinOtJUF6LYVQNI=;
 b=qn2oibwdRdVY7/ggo2UhgJcFVObH0veVf4/Zx3qW75NASC1K0DI3TgD7Ib2BgdIMbKS/+DpPvn7UJAtFBrrHD/QqU/4bLREhWXogj+K8Y5wAjkXyl1QtPg9gEB2hXtvmGO5htPyldZBGbqRkpbInaWRsG6rHz7qPnTcfbvhqTZv4u5xwijW3b82IXai8gvJbDBEehT/ED71YzSwEow7OoxEZeQepVYvcDwRIgF7Z/p5ftPMA5pG3erX9d9gDpCjiVB6mV8aBn6sIvlkZkuAItVe49UKrCuOyOvqVKagci+egCjI9kIB1EkM2mo3rAqcenuCTohkDJE6FYflxyHffVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SelA9lmKcWlohQ3TChZKItjdiMZKDinOtJUF6LYVQNI=;
 b=mOLJDhUVwALYE2f3CsQhjOAeolPGfeg84TFT2Cj2SEslkUVvOfkFVJgD5B53/fBFxXZ8nhh8E+T+QTbZQLiPspSYaOETjkgpJZfZdY7l6KFJ5GSu65lyxElGd+RBHRzrHD25GiZM4ybUxBChs396/YuHXV1qmFGLq34VFRUH5eYAdvm1vmGunb/GciADDbBxcb1u4LfKHa63f6JwOzJj9taZ7PRQiI/jAKFdyLrqn4hoR9tozaJeyw5zubVlBTuCvoimErfq17YB+QzYA6fXBGzqEXpLNEOdFHQ8rjS48YP7RdRe5Bl9dFSAAPQvtO8EAIqTbmgS/jRLZyA/LQkKbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:36 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:36 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 11/32] hw/arm: phytium: Connect the Phytium E2000 MHU
Date: Tue,  8 Sep 2026 18:41:20 +0800
Message-ID: <20260908104159.1621764-12-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: c9b0e498-99ff-4471-f81e-08df0d95e564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: dloxZXL1gZV4RfpHr+RRijC10MOgKyxS2ZGd2hlmwFH5GbM2HcgLrMBRGHGGLQDWYyOhDTamTO/7HJpY8T2xLKdidA4+YQ/KY6hoXs0JynKvDosIqXzNag1Wx5Sh3wt2fkdW2KbNWniO+OfmE1+58onM9q4VuDFqgw/TDWMUmSoMayQ2zUBWMcfQx5DJdUFFQByKR2w7AdcZiFx8gqiBiXZdkzkHqsxGXFZaj/Z/FJ8ZImSaaw2g30iC3VYZq3s2xilRUR+zffTpNhvy+3N9bdrXDTeiw+pYTJ6sP5Y0+ZiLtORuwL8lITgZaYasRcqF+NH8tDTx1EYG8aVywgvv6KnTL/HeNb5c4avo9a6mR53COR9l0XFxYSW888NnP4F7d1F3yXzGEMmEflPi+uaAMvTwXP3RXRIjYpTQGfIUnoVAeEA25CNsJz0+kkGjrTjhEc2b2G+V/ebaTZW0bcoEEUbU0wJoNUDHxlsJvOqnckA9Eo2NozettDLtBaLfUt5V7P2aDuZqaMtLIlbjS6wAujI8Pr7QR6i7qV4AxB2acxaG5xHSbsiknsjMRKkdvm5aN+i9ePk1teFg1O0/1lIw6XCWc1UUXheNi5k38Svem5Ax5HOzYHE1NHGDOxM3789KBZA2Yrd8GCgWDP/uKU0O46zVuLL4t5MyfTJkdXzrCUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HNS3YRDEK6pv7tnAU71PHiyQNqqZ7MnMr6WKYllPl6skeGSwbYGTYL3+ZC/Q?=
 =?us-ascii?Q?FRMqSfQQmNKEwG9Qf1gj41XbfqiY6YtA860nJ0sJrikMTrpyZVos7tNTX0nC?=
 =?us-ascii?Q?i7nxZaQIOeZRczcZdCQ+F7HipjJGmxpC687eKtnhE0HfiM9sLzqE9jox6JIL?=
 =?us-ascii?Q?voIlcn/rXJgfI4f31xUA5mEG9VMQ9LpgrneoQJrrd7oZ/2Ghs05y/GFIIiVK?=
 =?us-ascii?Q?fQcXZTau1w565IGIibWPAK7UZfgr5LeGofvoP6XKjo4U+8LTn3q6TVl0Xq05?=
 =?us-ascii?Q?KDXCySiRyxv0LEIbUBuo2Kmok19ZOET1xtkYngwwTGKf0W6gaSwSh77avy+h?=
 =?us-ascii?Q?YdPqcC5bM5BUE2qrAEytknmOfJA1tdSC9q/ASR66k/z33wPCprhcQbn+sHaQ?=
 =?us-ascii?Q?KA39szIUrVZQ8VgS8KfSvLt+yXbvpFmXH9toPMMoOU4WXOBnaVNabrH+BII6?=
 =?us-ascii?Q?RsBTRbDdsBYrLQKDfoQw0mzA41/proJtqXRqhAumfP3CkhPkLOKaOIcC/G/p?=
 =?us-ascii?Q?bFojCb4OlVPfikvtT0lVO4e7XTvCR1t5TjfwuP4KgT+IsKU+WYu/M/bsC2QK?=
 =?us-ascii?Q?12aG32qmV98pqvRQx6gpWenldZK0N2JsT0sSNkCCOah0E4N9Sd9FC7M+/8Ze?=
 =?us-ascii?Q?5vHt9hyqrfjDvuzjgLOZpSRyLu0DiJFBX7AoD2MlQVp0SnvZiJUDQkbJsrVb?=
 =?us-ascii?Q?W15TonJip10C1kvWYYlmK6kzleJmC7rBxNpkFcKfTOWKzBGfF41Enp9/GX4E?=
 =?us-ascii?Q?klGkGjZz4+PPFs1HXzRUp6vdKJsHCqBEXIFUTxkBQ0+ysNFEyOsnDBysk1Q5?=
 =?us-ascii?Q?Pe+Eg4JFhJgf794CQOXifmt+I9wjaRo78jsmYwRtgV+UD+XnwgN2xH4jBgpx?=
 =?us-ascii?Q?VcCiWD1DMVZ1u6sTSGw0R80Whw2h6VLYS7j797nvs3/1LcFVbU8QX0u7nljz?=
 =?us-ascii?Q?Is6CiNAKcYeFVfKBVcboEizm2SCXDGqW7u03RYXAgN+c0jxBIEnvg9mGOapE?=
 =?us-ascii?Q?CPcHIJIV2m+sTQLEcp+SfnxBKtaTs2c8M7fsVOQSqhmmgupAso0iqzC25eBT?=
 =?us-ascii?Q?FY4xy5oNqUPSTu0u12/pOelpFKuGbqM3Yocafa3UT0EfqJl3ui578Yf2oQhZ?=
 =?us-ascii?Q?+4QOrMZfdLg/eLEEdD9rpr5sgFFvBY8CenG9iJdy7xxw5BrkpfHIMlnpPeUI?=
 =?us-ascii?Q?+KcuJL2mBUvW9yCnKZyjwHtX0TrXMV4x+twnsGWkmuv15xaK2nxDI5U0xNGD?=
 =?us-ascii?Q?hinaqIR4weDZMKxSCo7UnNXrsc/c3gXWrJAnKjsoFXtdTciQTHuepQQkTreE?=
 =?us-ascii?Q?0YsszO96kpQUcCPtQr0MipesgznejBj/PAlAQGqMHQCVsCfM9UMFG1lVTjN2?=
 =?us-ascii?Q?wpKPOdoguPIHvS7gkDUgVnL2oarkwuZqkvXqH59Mp52df4ea0V8BPaq0/wZM?=
 =?us-ascii?Q?Z7eoairFYW3JAzVbbXsCdmLsYmZdpTBIyMSU5Ap+m5cs4PPjP1M+x95Xoi7J?=
 =?us-ascii?Q?oJcZPzu9mb5kn51JvyalX2zkxe3EI4BdSnuMvp0bI9XF+9O6S8GZIXJikAG3?=
 =?us-ascii?Q?w0/lASFfqss8kL09FoIhkd0E5BDCUcsS2gGIToquKwZw9mYLh7YWinsOpTOH?=
 =?us-ascii?Q?AgZR2TIYRjggx/UJRXeh2SJ/AMuiYrIDpbiw+ASGTCOQhaGgYKHPWYhpIFV4?=
 =?us-ascii?Q?sNaanIKoU/oVZgPP6fWOGgmNNGiL5xKz3t1NNbfGWgCJANSeTz/EQJbSjSF4?=
 =?us-ascii?Q?3071JYftQ13gHvJ/Npuys+g856VlJTo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b0e498-99ff-4471-f81e-08df0d95e564
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:36.0781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsqEP4lzfxNptvrJCWqCFQkexoN0CtWsMRrCSBLdev9uI89abyZeZjJt1x5sHA7b2vdi+vAWH/VF4jyPSetgf7ptwMw8jgU6HDWESM8dE04=
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

Add the E2000 SCP SRAM window used for SCMI messages and map the MHU
doorbell into the board-control aperture.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move the MHU and SCP SRAM into the E2000 SoC

 include/hw/arm/phytium_e2000.h |  1 +
 hw/arm/phytium_e2000.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index a948c54f2c..40f91256a2 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -66,6 +66,7 @@ struct PhytiumE2000SoCState {
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
     ARMCPU cpu[PHYTIUM_E2000_NUM_CPUS];
+    MemoryRegion scp_sram;
     unsigned int num_cpus;
 };
 
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 9a0cc00c91..95ebf3c87b 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -22,6 +22,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/misc/phytium_e2000_ddr.h"
+#include "hw/misc/phytium_e2000_mhu.h"
 #include "hw/misc/unimp.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
@@ -40,6 +41,9 @@
 
 #define PHYTIUM_E2000_NUM_UARTS       7
 
+#define PHYTIUM_E2000_MHU_BASE        0x32a00000
+#define PHYTIUM_E2000_SCP_SRAM_BASE   0x32a10000
+#define PHYTIUM_E2000_SCP_SRAM_SIZE   0x2000
 #define PHYTIUM_E2000_DDR_STATUS_BASE 0x32b33000
 
 #define PHYTIUM_E2000_GTIMER_HZ       50000000
@@ -480,6 +484,34 @@ static void phytium_e2000_create_ddr_status(PhytiumE2000SoCState *s)
     sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_DDR_STATUS_BASE, 2);
 }
 
+static void phytium_e2000_create_scp_sram(PhytiumE2000SoCState *s)
+{
+    /*
+     * PBF exchanges SCMI messages and platform parameters through this SCP
+     * SRAM window. Map writable RAM over the board-control placeholder before
+     * the MHU doorbell starts completing requests in it.
+     */
+    memory_region_init_ram(&s->scp_sram, OBJECT(s),
+                           "phytium-e2000.scp-sram",
+                           PHYTIUM_E2000_SCP_SRAM_SIZE, &error_fatal);
+    memory_region_add_subregion_overlap(get_system_memory(),
+        PHYTIUM_E2000_SCP_SRAM_BASE, &s->scp_sram, 1);
+}
+
+static void phytium_e2000_create_mhu(PhytiumE2000SoCState *s)
+{
+    DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_MHU);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /*
+     * MHU is the notification side of the SCMI transport. The message body
+     * remains in SCP SRAM, so this device only owns the doorbell aperture.
+     */
+    object_property_add_child(OBJECT(s), "mhu", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_MHU_BASE, 2);
+}
+
 static void phytium_e2000_create_unimplemented(PhytiumE2000SoCState *s)
 {
     /*
@@ -602,6 +634,8 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
     phytium_e2000_create_cpus(s);
     phytium_e2000_create_gic(s);
 
+    phytium_e2000_create_scp_sram(s);
+    phytium_e2000_create_mhu(s);
     phytium_e2000_create_ddr_status(s);
 
     for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
-- 
2.53.0


