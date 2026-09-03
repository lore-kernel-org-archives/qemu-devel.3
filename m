Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2C1C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25ad-0005ns-Rr; Thu, 03 Sep 2026 07:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25ac-0005n2-G5; Thu, 03 Sep 2026 07:26:42 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aa-0006k3-Tc; Thu, 03 Sep 2026 07:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ4x1AxaS1AmNM8xvXzrroBINDajTsZa5SNaFQ3UdbpxEShae1N+2op5NJf7dQRpZQNNaAuvtCmJuIYNPsYEtoqOJ/Ll2a1Kj/CakX8RXfSdzhQ7sGEL9SBbi9YRJTvGz4RAerm0PVY2RV2HdwA2/o+hDQnDXDbCgaaPOohXaiE/y2Wa6q1ltnQgupCZRzkk+4DWcj1S5eQ0W9sBnDgEDgI5p7cIRXaocdm0tY6QVTjiOkia7NIKIxKBedpmWf/MvtvQK7z0sgH4SRhJNlTC3r4zfaTLwT+AEnTbX0xETRS0IdbHrkocRKr/5YL1fvUnSuPhoBBvONekY2uA3rgDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3WO6DcIpiQ5XZRKrT1GUrBUkt9/ySiPZ85pHZypglc=;
 b=odPgRgquUaN5IVLlDHnBx7oa92jXSzHV0eJN2KHi5BBMSe9txGaISw/Ey8wuYbLcynmYdOWlMIR0LISNOOGY5wmxim56He4kfdgAvAK0Bzv2rrox6dp4FpfQolcSQFlZUm8Xdng0xsXkHlYDJHXytapoi10Utokf33M2idtJBWyzZ+WxY1yKebDZlY5gUX5/mqcdpPN+v5VBZ/X90EkIIhSY6m3IAVr8ohwMhUZ7zqAoglnPQHsiEsobFhm5NlZTzrOjS9+jqjBWLoDnHHfmdnGt7wV4FyaHLsCdqYBORqClPepXCXrPptUNhSDf5z/hjsKhdUnNYfj6L3LGJWXr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3WO6DcIpiQ5XZRKrT1GUrBUkt9/ySiPZ85pHZypglc=;
 b=slTUDhH/NOHRe6j9xYxc2XanHCSP+kmub0tq9vU0Lw540U/UEmvFNSCIkRHHe7uZ1pfcjQG7uumIlTc4z9OFXKEgVrS8iUQx9xVCOLUdf0cMDPIJ6dfEZpNV+xLjrGuE0wkKaRMU9PCkNYDI08u10V8nbip4MpdrAwmvhILixAJ5m1BINWgKyLFcsOptOBPaomjaqVFsIdb0p4wE7/EsvLKEWbFuv8cSI6B0bhRr84sRHIX5mqv34DJC54TSjuuBKx2FCARJV91YQG4aLwnvi3ltN9iOlnqGQyJW7aaZtz4NKf9XZVNlyyfpuqZf0KcAyfJA+MCBhsWZqNzpJguleA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:29 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 20/33] hw/arm: phytium: Connect the Phytium E2000 I2C
 controller
Date: Thu,  3 Sep 2026 19:25:00 +0800
Message-ID: <20260903112532.3276678-21-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSNPR02MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 8120b1a5-eb0d-4178-ac05-08df09ae332a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: L10sMUhQ1l38XiRTH/Btief9QQOBqn0altipIFAw7LMx6ZvvfpwFshvZjXp++zk1MQo5IafkkEUG5lzHwxo1Lf7zhYxCGI8OLmBcXw2sAFWTvQe6KFWSFvO37zfpi2jyielNnV4Fx7gRpv5Puwzt1EAMsN+LlrxqQodJSShuskCEfYqTfslmI7Q0v1mvVtDnhASk6EZQhzKgRpaYFIVLSTZtwk5DlFOtyeTk37zHCBmtnf2Iz7D/MhR6h24J42r5F+nq5ybkkSNzf8zv++VrFSoaTHrBabnk2XVTapxpM2S1+a309Nbp+8/5/jfeLGsiLb6KHpgBdkGUr/5QsBst/lUFp8LlG/2DqRxBDDo3NYFT9Xci9kwYEQ6Xj8LgePnDkwEIZyzdleJDnKpnpt+JKLaxKYDhuAGCbyKPaWpz+6UpaozZSZ/x9G/wv8hSggepCdMOArYE+LaR5FVmDjS0aFj1g+ky/dfYiJ9zew13OrvgWpp5X6lnCW9C1mU+eti4wUJExRfc4gCmbzK2xTrt5sriPydYGOlrFUZwEZpgKCMwL1W/E+bESNjD+f1OHl8JqSrXZ01vzJlU1gdldRdj7oDlFKDyTY4cgQLgwY34xooh1mlrhZ4+Vmp6XjEKyA9g7W8eswkc689rfVM5oByW3UC1A1rJiNc21aT1Y4k3W3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OQf87btsVs6iSXN8VUgK11yj6VUp+t8tc3IoLsw9gIxNUjRytz+iQQpONzcn?=
 =?us-ascii?Q?E3/1qmoUKtJb7sQrso+ZJBhGuuhJKbENTgC0Fh9A3+HsIab5VOfGleLw8B2w?=
 =?us-ascii?Q?M2ShcZcrgBOPk48smJ3JLIbJ/k989y32Om8/yeoKDk/zllvtdN3xyP/qKudV?=
 =?us-ascii?Q?uOqYEl7u6+8bX07xg1tSBOc1mTQ4fCHT5CljX1TrCv7786t0BQ+JCdJ8hAej?=
 =?us-ascii?Q?XpkYQjyLUgJ7JJdWLSdaA8BQdnb/tNynVlDiqfQxzt0o6kgBkbdBceGpZ56m?=
 =?us-ascii?Q?CwK22MIJKTC4bH4GU+cYHttVfF9m9lfx4ED9RYPGKOwZXEkrlokSVY9Ch7dH?=
 =?us-ascii?Q?oRys56u3nTT67Zf1bOcc9amEitdJfKkuSaI2QiIeDepxd/jVEkv0aPktLRyC?=
 =?us-ascii?Q?2smSKGqLQa/0Mi7b7Mj/O0c8Y9qoXkqQExLjWo62lpGrl2GLM1xdLNJnqKp9?=
 =?us-ascii?Q?DCLIvHLVesWI+lI0vcqOcRHQvEpCwM0no3fEcAFrJfJiSqgO02uccCCZm73k?=
 =?us-ascii?Q?Sn/hXWa4nljqkdK6vSQo8x/SqG6Ve5Jh2LK0azS9+SX4jPCG0pjiE98WPqQ2?=
 =?us-ascii?Q?2vzKIalqK95VIM9fYCFdU/eONCwFOUyvkHdtoCse6lO2ddj3uSXh+l0Rx+zj?=
 =?us-ascii?Q?elwNiKDHB+dJFxealVA/bgiWaMpdYO1GMGe9D/gfGIoV+Dva6kpeb7zQ1LOp?=
 =?us-ascii?Q?GMs0IoPXpLtMLKGgbSU6iqXxdYpwDGFmW6AGoaZmqKzxcBJ/NW2l5TbQ58KU?=
 =?us-ascii?Q?zPVq4xKrvJWh1sc0TXCRrV2QE5+w7ZqvGvUHUb8v/8zTeF2NABTTiYCykcN4?=
 =?us-ascii?Q?mRI73WpfSvXB4ydC/i7H5E95vdgkd6qR6uQIpDkv4LMqLAZxQbyY1tK23eS5?=
 =?us-ascii?Q?RDAbCxS8/hrkOesiSBiZo1q/dtUOsBZeLifAbSmdT/MY+GJvaaGySj4jcWhU?=
 =?us-ascii?Q?sXPP2w0sKepJQy5Zw6gmGK8c6dOjV4T+2doYX/2pg2nH/UvnOxhWoAwSfBur?=
 =?us-ascii?Q?u+nQeUkoFfpbnHnKZ5hZxx8hQSbCQbJoRGwLf/2tM5z9jdsA05NAXP+od4J5?=
 =?us-ascii?Q?w55SPbwY2Y4hwaeRRbGsFg4qAHMAk90qJX3Qy54AXRhyQshLASZhrDFmy4TH?=
 =?us-ascii?Q?AmNhhYxnDPIuurTYKFn2/ADVOFzJJCMxUJ59/EcIdIPGDJyWJmdUzVcdZS1f?=
 =?us-ascii?Q?dXZg79S4eQ4lMW/+T/a+1r/bj9yHW10E7KntJyXszKM5XhZqe19c0zRHtw5+?=
 =?us-ascii?Q?yK6zdJa95TsYmOKvRNINVme722Y9G7Z91zqKU5ja1IZvs5jDXnIr/LcL60uz?=
 =?us-ascii?Q?GUHMA66QgIU8H5/VplEzrCWETu3M+OATmjcP8kjqNHi5gi2TT7NOLY/ZFscF?=
 =?us-ascii?Q?3oiFiUQAwsHQc9hi6ZFpRIgbXfED/2DWOnm0mTlTz5KYV4hjj8y75tYVPYaV?=
 =?us-ascii?Q?VakHCXnrVnTEZfpIYixVbo+HPkkHnYmSO5sSQI1Gs5xTDApfjwdpkN1hEaYw?=
 =?us-ascii?Q?toKCWrzAg56bImtje/DX6LZy1wQsJVHtgsGhreiSROJ1FQCpzSpk6S4OuVWI?=
 =?us-ascii?Q?hldkyS9n0pJHF2W+1TXVrtc/dDzIQYAIhLiBjD+piocrcvqkt4QxG1q4hYZm?=
 =?us-ascii?Q?KoI4cKaAwCxqDYeMrwLwKQYPWAtI6Mwc3gcLEtpueAgqOuQd1TJHKs0XSw5a?=
 =?us-ascii?Q?jz7OgDzYrmd5gJoRgbBDUL5CL9CwPV3WoPWyoJOh5CQW7eO/o7IfL2P+3RRg?=
 =?us-ascii?Q?QzU8JLHQXzofSvdeW4ej561zj+t72f4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8120b1a5-eb0d-4178-ac05-08df09ae332a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:29.8603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZSDYscFMalao9ab7+r3usveEdW7gpZCefYsztM9sCYgmYw7BFq5pwRj6GhrZAyc5/l1G9QZBcnBOK0amXLdpiuNzb+WUTonTvsF726nZWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8962
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

Instantiate DesignWare-compatible I2C controller in the shared E2000
machine initialization and wire its documented interrupt.

Leave board-specific I2C slave devices unmodeled.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |  1 +
 hw/arm/phytium_e2000.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 891d09e86b..7edf1bcb21 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -133,6 +133,7 @@ config PHYTIUM_E2000
     imply PCI_DEVICES
     select ARM_GIC
     select CADENCE
+    select DESIGNWARE_I2C
     select DW_MCI
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index fe362dd4bd..8194afb6c3 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -27,6 +27,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/i2c/designware_i2c.h"
 #include "hw/misc/phytium_e2000_ddr.h"
 #include "hw/misc/phytium_e2000_mhu.h"
 #include "hw/misc/phytium_e2000_pbr.h"
@@ -78,6 +79,7 @@ enum {
     PHYTIUM_E2000_UART4,
     PHYTIUM_E2000_UART5,
     PHYTIUM_E2000_UART6,
+    PHYTIUM_E2000_I2C,
     PHYTIUM_E2000_CLK_CTRL,
     PHYTIUM_E2000_SYSTEM_CTRL,
     PHYTIUM_E2000_GIC_DIST,
@@ -141,6 +143,7 @@ static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_UART3] =          { 0x2800f000, 0x00001000 },
     [PHYTIUM_E2000_UART4] =          { 0x28014000, 0x00001000 },
     [PHYTIUM_E2000_UART5] =          { 0x2802a000, 0x00001000 },
+    [PHYTIUM_E2000_I2C] =            { 0x28030000, 0x00001000 },
     [PHYTIUM_E2000_UART6] =          { 0x28032000, 0x00001000 },
     [PHYTIUM_E2000_CLK_CTRL] =       { 0x28100000, 0x00001000 },
     [PHYTIUM_E2000_SYSTEM_CTRL] =    { 0x30000000, 0x00001000 },
@@ -182,6 +185,8 @@ static const int phytium_e2000_uart_irqmap[] = {
     [6] = 107,
 };
 
+static const int phytium_e2000_i2c_irq = 106;
+
 static const uint8_t phytium_e2000_gem_num_queues[] = { 8, 4, 4, 4 };
 
 static const int phytium_e2000_gem_irqmap[PHYTIUM_E2000_NUM_GEMS]
@@ -328,6 +333,19 @@ static void phytium_e2000_create_uart(PhytiumE2000State *s, int index)
         qdev_get_gpio_in(s->gic, phytium_e2000_uart_irqmap[index]));
 }
 
+static void phytium_e2000_create_i2c(PhytiumE2000State *s)
+{
+    DeviceState *dev = qdev_new(TYPE_DESIGNWARE_I2C);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    object_property_add_child(OBJECT(s), "i2c", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0,
+        phytium_e2000_memmap[PHYTIUM_E2000_I2C].base, 1);
+    sysbus_connect_irq(sbd, 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_i2c_irq));
+}
+
 static void phytium_e2000_create_gem(PhytiumE2000State *s, int index)
 {
     DeviceState *dev = qdev_new(TYPE_CADENCE_GEM);
@@ -801,6 +819,7 @@ static void phytium_e2000_init(MachineState *ms)
     for (i = 0; i < PHYTIUM_E2000_NUM_UARTS; i++) {
         phytium_e2000_create_uart(s, i);
     }
+    phytium_e2000_create_i2c(s);
     for (i = 0; i < PHYTIUM_E2000_NUM_GEMS; i++) {
         phytium_e2000_create_gem(s, i);
     }
-- 
2.53.0


