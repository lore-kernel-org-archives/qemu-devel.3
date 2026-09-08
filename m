Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A22FC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHj-00081R-SF; Tue, 08 Sep 2026 06:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHj-00081C-2c; Tue, 08 Sep 2026 06:42:39 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHh-0006YC-5V; Tue, 08 Sep 2026 06:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYf9ktWHNrpU5W79WI6E0jsn4J/+QYrw1U6evWx4fh877aLsP8QY+ItCH9/zbJI7J9eyF+c7yOvjF80THxvKN51ST9VP+6WHvqeUDiWurIwZhwaVKNgsvY0RF5B7utCwJ+UBghJ0bLhfdcQKFaJ8nkWgo+GB6iVChXr87nsVKr+Z6HAxkBlkeTwZCUhH0tMfJTJj3qZiErYHp9Kq9ioXiMIEyg4I+Gl7KbbtBovjuQDq6FDPpPqRL3y7vUn9Nug2MhaSPGrxzyL0R5+PNMm5pbTz8+PyatUROJJz0P/JOpd9ZJt2nGROsVVDNKw+yec+RoMeQw/vk//7ZRZV7c1iBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8toI1acRAc3wCU9moEBZALZ5JtiKwQcFUW4z2ALqMGY=;
 b=MdC8Vm6Aos7xmNCyxy1NLnXTE46pU/R8Ds7UtP0r1ksqLUWK+ZyLdxA6IHu+T4GTnrwxyK5HLtW7IGgDPSKpd9Ornqe6HVvqs/cb55ffKg+JDkjFOxZmbXQykMb6OqwOT8dy7rUyDYa8KWHF2dJixD/sJFMXURqO5TKH4IePWZFFsX8AIaA16ivX15Wet1at/pO40wF//mRDBO9/UMRzX4B6K4MA/ZdabLiYM/xzRQL9KcVGN8Yu3HKNQ/29RUsjwytXZpcpHe1Z+OtO3RiIavfDN9PoDuRjr+/G1sGy2Eok91Y4wsM0+hUCFE0+M+3hHWM1epRG6A+aHqXrfegCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8toI1acRAc3wCU9moEBZALZ5JtiKwQcFUW4z2ALqMGY=;
 b=fLdavMrGYyFrwyMKDVym+KDCD54WTvqKDI7Y3A8PIQhH+2/lLKDvCbUBCyZUe2qRqzgYZHdgAXX35uBY21sZhKOZObfQrjpRxatvGTEqUIrzjoBnRHoSK/ngaYQjK8altcs4+9rHOtslir1k9mLI/hfyQgtgHeMx2kBPjDxhr/LBmu8uQb/tLSZsHlxgU8+UG94kykIqgRkOiusharuX1RLdEAX11mQLtoZW3qp+CEFR+IGDZGFCqHx2BNhG7/OPkSibmmpDKPgeLN/jDtA0Xzt9XIeHwFlbCsH5qSd3XjO7rYrz/f27pkJznrRS00asYTKfMhuFVayAbw0OnzIVww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:26 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:26 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 05/32] hw/arm: phytium: Connect Phytium E2000 MCI
 controllers
Date: Tue,  8 Sep 2026 18:41:14 +0800
Message-ID: <20260908104159.1621764-6-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b232b78-1ee2-43cd-d0f4-08df0d95dfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Xk6Bz2/xrtf/6Qz5WZ4lw16cYeSUx/AwtMbKZVIXE80wkrpBqmRoQyYeOr2gUHiOUQBUtFSwN+sl2fuUKe+1h+PvzZqPKnCfyWq5xUVsDbked25HHWPBw7qsAvF0rQWW2kp8AA1x+lAH0layH576mdOPUgWrxXItUY0sLTamTbdkaGWfsfKzQRCUeww/2bD9hXF6LVP9pVW9QDo9oa9QfgcJjGMkP51juAeKDq7U+kZgN98QLzlV0RFjHmj4ASpSbv6F58T6CNbKSvEfkswM4azrTpLyvFjnXThPmfLddxyVXB5O+qv3oq50gVFutvb1QbKJt7332Z0jdrtD0vO7YyW3+HWvjnMiFRQxYqxC7h54BwD7FJDMb8fn+wpc/7HImFfkGmurKXe+Gd/+4jurADYilIxBQhkPyJr5gVchxlyA/l1lJZ/nASp6XbuIW4qbnH4XV4r7S46DwtD55fpf+dwEjmuMpw3lt4BTuRnTyS1X74qTHsg94PQLG8JkIkk8cqfS65rw8pcVr0Rvi9iipmzYvWp07qqomxmnFOeBYjnpl9PtnuUdI0Z/ddQ20YZBLxB0xz9vztOady9lcemXAtCTf3ro1SLK75STv/sKQiYHzo/00WhrZu/y+AgZT09kdexnv/CPIuLOSniwXWx2d1hRulBRlwyHu7XFQ57CB3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzf3GpD1BCfgGeVnByIc7XSay0XBx1nfdXSosXYNMeNP5avugQ79FHiWk17t?=
 =?us-ascii?Q?XL0Wl8c5QgSt7XNArmCF7DxYLpX8ceHb82r9FVct0gAegxy8OrMlUvS8TW6g?=
 =?us-ascii?Q?FkZEvGrB592zDaMh/KPQ+l33VVpha/xd8pet7yZDbO5KsN0rtworRkfdbTjj?=
 =?us-ascii?Q?7QNPHmUCOHnFwHRGkxJOMCNYM/j/NelFukpd+Vjn359ixKuVfD/RT9cgTQXV?=
 =?us-ascii?Q?ioH9px6ZyV5mj+1MIy5urN1T94sNoZZrpjQqk71daPeXQAmnh+ji0/Bv+B/c?=
 =?us-ascii?Q?eY3LnXO1OHEPYYfldXr1zPCHml5DvL1TZXVoJrIKhNjvxNvytB+YARoRFBwX?=
 =?us-ascii?Q?+nqSVHE1jUSLgF6pWUBTlxDXmUun6Mew3e4+5gFm2lfkoEkqE5uuemTvYIX3?=
 =?us-ascii?Q?IMo8fBHALhvSh+tMF90L7ni+JHTpl4O+QVUNRexDGD5cY97cJmXOtwkzYBWr?=
 =?us-ascii?Q?Z6AfXOqrMabLSy5Gy7u4FrN2oAIU/lqkMGxcVYDklkb3LMzdjelUv+ZgKgJ7?=
 =?us-ascii?Q?YHhBVG6B+OuthqJRVdgY8ZuXDqZF81/N6fJV6X0IxCkL9e8bUAj9b+4a9uyQ?=
 =?us-ascii?Q?8HFQ7TpwUmhWZRjv1bk5Jf8wPzFr16ZAXx2aIqZfdN1Y/dPoQlKuJJPlP2Pq?=
 =?us-ascii?Q?3ZYo8kW/RhICduP83H7xXWhEzx6Ohe4Pjlaa7l9r9s6dgrp5Kwm4dCRDgl3D?=
 =?us-ascii?Q?rrFDEkFNuO3VtLaGjnK+XlTsiR1ycyLjl6vF7cHdbKzr3ITHw8hP0IJo/iJ1?=
 =?us-ascii?Q?GusGrDSyzVIyrPJetroVIjzqz4Ew9gMdM3/0NYZBCOON8xk1jUWOBV4FTGJJ?=
 =?us-ascii?Q?oxdp2/BXwcsPOt+OAnIgACMP78p0XYYiZrPx9jScIoyTadin4fp8e2BiFxaB?=
 =?us-ascii?Q?099nC7Ei9CZuHuW0jnUukWwykhOfH9jCA/T/bOY6/3apU91F2lWd1F64WVgL?=
 =?us-ascii?Q?EQVT5Ql+8U4GyGlC7crvjp9C3U8kuUw3IGJyw3kpKr+hpA/XG4/DZ7x3PXxC?=
 =?us-ascii?Q?njrdEjEdzhrEPWzKSc87PskT327TZSQPn77ti8qD+kcQ2+4GVWBzU6nbpSH2?=
 =?us-ascii?Q?EGuWPwEji4RKkIxhYf1HgVKz2OuQu9BWaWOTV1rrmizPeFTHDQ9Y0qZL4eIF?=
 =?us-ascii?Q?/oXNTkkzCZ/AucEp2MXW/1WA0YrTVBAcZmh8+yWZX+xgptWieoH/TToTBzKV?=
 =?us-ascii?Q?c2uRf9sIVRFb83NKnd3cIZFetbtjqMlBcQd62I8tZn1e96Z+nLd3sPsO30dr?=
 =?us-ascii?Q?cynGO8V2Q61fahnY4qpUJBPfx5EQjzlIeJ1VyHUTR6geBlaoR0vXEHPw0hGj?=
 =?us-ascii?Q?qvF8EXonpJvj1qAaXeWJErXBq+AiRMm9R9upd2i7bm26OQoON8L2N+13806i?=
 =?us-ascii?Q?zRfwDKy+UD3bNxPUm3cqo9V7qQ1GznfO6XgcNrCpOghbqpjflAJ2inCvIjoV?=
 =?us-ascii?Q?JuWYLHG90epHppTMiXs5w4PsxUe1tjKRuFu90r9Jk27FXAcwEuNAorxGToWj?=
 =?us-ascii?Q?i1dJtjCXUCSLJ/ybL3wy+3mu+sTdSM03NfVKUV9Gw/z9+LInO2zF9Z5o+DxK?=
 =?us-ascii?Q?EMOGKlhGbCw0ODblwANe++t0JInyyDes4wbGeauVBx3T4NsPlVldKLrQsNJ7?=
 =?us-ascii?Q?RNV/kwrPYn8BpSWDTv2aZuqXz3ivHsXHgAq+MrPY+sYICXqPMpubm4XZrwvz?=
 =?us-ascii?Q?+aJLoqmooK14tQiMSm7KXEI3n3LaZaCQY7qrPqRB7dVUBa6rTM1V7OF8NOcC?=
 =?us-ascii?Q?YmQ9cReR+ga73Zm0bd7yvSd2oVz0fao=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b232b78-1ee2-43cd-d0f4-08df0d95dfd5
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:26.7282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzN8SGOGCSEwrpKiWq0EvcOxMzdmXHq8RW4RusSXSHn8qNgl0VMfUv9uJdCaMAG+imqs8wXRnQWtrhStt64QmeeoXN8iHY7esvMtdc3Oi4Q=
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

Instantiate both E2000 MCI controllers at their low-peripheral
addresses, route their interrupts to the GIC, and create an SD
card on each exported bus. Map legacy IF_SD backends by controller
index so firmware and Linux use the same board-visible media topology.

Keep the broad unimplemented aperture underneath the concrete
devices and make SD the machine's default block interface.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move MCI controllers into the SoC and attach cards in the machine

 include/hw/arm/phytium_e2000.h |  9 ++++++
 hw/arm/phytium_e2000.c         | 56 ++++++++++++++++++++++++++++++++++
 hw/arm/phytium_e2000_machine.c | 19 ++++++++++++
 hw/arm/Kconfig                 |  1 +
 4 files changed, 85 insertions(+)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index dcb6c46272..e759d71746 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -14,15 +14,20 @@
 
 #include "hw/arm/boot.h"
 #include "hw/core/sysbus.h"
+#include "hw/sd/phytium_e2000_mci.h"
+#include "qemu/typedefs.h"
 #include "target/arm/cpu.h"
 
 #define TYPE_PHYTIUM_E2000_SOC "phytium-e2000-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000SoCState, PHYTIUM_E2000_SOC)
 
 #define PHYTIUM_E2000_NUM_CPUS 4
+#define PHYTIUM_E2000_NUM_MCIS 2
 
 enum {
     PHYTIUM_E2000_LOW_PERIPH,
+    PHYTIUM_E2000_MCI0,
+    PHYTIUM_E2000_MCI1,
     PHYTIUM_E2000_UART0,
     PHYTIUM_E2000_UART1,
     PHYTIUM_E2000_UART2,
@@ -52,6 +57,7 @@ struct PhytiumE2000SoCState {
     SysBusDevice parent_obj;
 
     DeviceState *gic;
+    PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     ARMCPU cpu[PHYTIUM_E2000_NUM_CPUS];
     unsigned int num_cpus;
 };
@@ -64,5 +70,8 @@ void phytium_e2000_soc_cpu_topology(unsigned int index,
                                     int64_t *core_id);
 ARMCPU *phytium_e2000_soc_cpu(PhytiumE2000SoCState *s,
                               unsigned int index);
+void phytium_e2000_soc_attach_sd_card(PhytiumE2000SoCState *s,
+                                      unsigned int index,
+                                      BlockBackend *blk);
 
 #endif
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index ccfd9bad7e..c618065ffe 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -24,6 +24,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/sd/sd.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
@@ -45,6 +46,8 @@
  */
 const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_LOW_PERIPH] =     { 0x28000000, 0x00100000 },
+    [PHYTIUM_E2000_MCI0] =           { 0x28000000, 0x00001000 },
+    [PHYTIUM_E2000_MCI1] =           { 0x28001000, 0x00001000 },
     [PHYTIUM_E2000_UART0] =          { 0x2800c000, 0x00001000 },
     [PHYTIUM_E2000_UART1] =          { 0x2800d000, 0x00001000 },
     [PHYTIUM_E2000_UART2] =          { 0x2800e000, 0x00001000 },
@@ -68,6 +71,11 @@ const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_RAM_HIGH] =       { 0x2000000000ULL, 0x180000000ULL },
 };
 
+static const int phytium_e2000_mci_irqmap[] = {
+    [0] = 72,
+    [1] = 73,
+};
+
 static const int phytium_e2000_uart_irqmap[] = {
     [0] = 83,
     [1] = 84,
@@ -374,6 +382,31 @@ static void phytium_e2000_create_pcie(PhytiumE2000SoCState *s)
     }
 }
 
+static void phytium_e2000_create_mci(PhytiumE2000SoCState *s, int index)
+{
+    PhytiumE2000MciState *mci =
+        PHYTIUM_E2000_MCI(qdev_new(TYPE_PHYTIUM_E2000_MCI));
+    DeviceState *dev = DEVICE(mci);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    MemoryRegion *iomem;
+    int map_idx = PHYTIUM_E2000_MCI0 + index;
+    g_autofree char *name = g_strdup_printf("mci%d", index);
+
+    /*
+     * MCI0 and MCI1 occupy the first two pages of the broad low-peripheral
+     * placeholder. Use a higher overlap priority so real command and data
+     * accesses reach the controller model.
+     */
+    s->mci[index] = mci;
+    object_property_add_child(OBJECT(s), name, OBJECT(mci));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    iomem = sysbus_mmio_get_region(sbd, 0);
+    memory_region_add_subregion_overlap(
+        get_system_memory(), phytium_e2000_memmap[map_idx].base, iomem, 1);
+    sysbus_connect_irq(sbd, 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_mci_irqmap[index]));
+}
+
 static void phytium_e2000_create_unimplemented(PhytiumE2000SoCState *s)
 {
     /*
@@ -461,6 +494,26 @@ ARMCPU *phytium_e2000_soc_cpu(PhytiumE2000SoCState *s,
     return &s->cpu[index];
 }
 
+void phytium_e2000_soc_attach_sd_card(PhytiumE2000SoCState *s,
+                                      unsigned int index,
+                                      BlockBackend *blk)
+{
+    BusState *bus;
+    DeviceState *card;
+
+    g_assert(index < ARRAY_SIZE(s->mci));
+    bus = BUS(dw_mci_get_bus(DW_MCI(s->mci[index])));
+
+    /*
+     * Always instantiate the socket-level card object. A missing backend then
+     * behaves as an empty slot, while if=sd,index=N gives firmware a real SD
+     * card on the matching physical MCI controller.
+     */
+    card = qdev_new(TYPE_SD_CARD);
+    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(card, bus, &error_fatal);
+}
+
 static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
 {
     PhytiumE2000SoCState *s = PHYTIUM_E2000_SOC(dev);
@@ -476,6 +529,9 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
     phytium_e2000_create_cpus(s);
     phytium_e2000_create_gic(s);
 
+    for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
+        phytium_e2000_create_mci(s, i);
+    }
     for (i = 0; i < PHYTIUM_E2000_NUM_UARTS; i++) {
         phytium_e2000_create_uart(s, i);
     }
diff --git a/hw/arm/phytium_e2000_machine.c b/hw/arm/phytium_e2000_machine.c
index 8a4f8d4275..7397c58a78 100644
--- a/hw/arm/phytium_e2000_machine.c
+++ b/hw/arm/phytium_e2000_machine.c
@@ -14,6 +14,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
+#include "system/block-backend-global-state.h"
 #include "system/kvm.h"
 #include "exec/hwaddr.h"
 #include "hw/arm/boot.h"
@@ -35,6 +36,23 @@ struct PhytiumPiMachineState {
     MemoryRegion ram_high;
 };
 
+static BlockBackend *phytium_e2000_sd_blk(int index)
+{
+    DriveInfo *dinfo = drive_get(IF_SD, 0, index);
+
+    return dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
+}
+
+static void phytium_e2000_attach_sd_cards(PhytiumPiMachineState *s)
+{
+    int i;
+
+    for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
+        phytium_e2000_soc_attach_sd_card(
+            &s->soc, i, phytium_e2000_sd_blk(i));
+    }
+}
+
 static void phytium_e2000_create_ram(PhytiumPiMachineState *s)
 {
     MachineState *ms = MACHINE(s);
@@ -95,6 +113,7 @@ static void phytium_pi_init(MachineState *ms)
                             TYPE_PHYTIUM_E2000_SOC);
     phytium_e2000_soc_configure(&s->soc, ms->smp.cpus);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+    phytium_e2000_attach_sd_cards(s);
 
     s->bootinfo.ram_size = ms->ram_size;
     s->bootinfo.board_id = -1;
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 84d0cefd81..8b865e4e30 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -136,6 +136,7 @@ config PHYTIUM_E2000
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PL011
+    select SD
     select UNIMP
 
 config REALVIEW
-- 
2.53.0


