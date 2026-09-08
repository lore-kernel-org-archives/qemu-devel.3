Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0E1C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIP-0000gr-Vz; Tue, 08 Sep 2026 06:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIN-0000Zg-UQ; Tue, 08 Sep 2026 06:43:19 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIM-0006bO-1g; Tue, 08 Sep 2026 06:43:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qb3rg/OcOBKTMpTthQ9lKMnTA7mmvF3IzdVXlsYokR5UPWwH+qU2bUnhLXTzgo4u3v0qC+IIbXTxcnJN2syM/q+35sM5K0shxUReRogWTjSLWJcyeCh8B93k1jiTWMtRwueFs2SNzlie6wozm+4XZUAagsNdjLQMBDF5MFGQUVH2+FqILoNVinINKYGqxXkULEAUIZ8kNky83F/FCnAmuttDiwTsCvbdnwwRUY4uNXCIEdVSZoqObbw7aSKA0WV+oUtTIKcxpG7eAG4wG0UjjWepUumQEaN9pIxaV7K9D8GgXe14eXlbw7VMBYjX+mt7ek9Uf441cxTOnsngyrFJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgvwueYYGFr/+qNDJc1Q7StdtAXGmXrV/pS2H2FyQf4=;
 b=WbOkQ5L5E/iDazkkn5g6p9FVWsURzhUtP1u0kja2tV5grfCBGsLRPeHg5VW680rBmiTElJCL1spWnW53aSf5vTSwbKTGe5ZlZZg5QnenM9PLP4d6PznK9V/g/YCqiqw5X9iGqC2uB8gBgPkv+hGv8n/7SFOzXZrqp2S2yB4VzuWiY++Y4qOsKqTr/pNPsGOEmP8evoWnasn+za0pQK2p01oQ0Wv0yaYsW/d/xpqjIUzdj4UIAiAooSsdiV4ckwExJzeQiGxrS0h0CS1oPxfioOprm8CWC1zc1nueD/gVGUh24lOVJOl665iQm7gk7uT9WV9D+HX/+wfohrUkt1qaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgvwueYYGFr/+qNDJc1Q7StdtAXGmXrV/pS2H2FyQf4=;
 b=Ok88+bjrKMe0wcoKlUt/TKx9Wjmq+5xcr2EDKjslgJ+0KxPnIFY4m48lVL5rMLqSUIl54TMprKytXOwFcSBXDlMu3rgkgeJKfOy8QkyjYdyrEP2oZkyvPuJfXACofsXOblkjTgG1ybTr7YaeC3DsqJDEHLtugVNAukAuyezHqXk9pRXtH5o3hicMksMeoQmKv0nc5RO68NJQtV9ELKrCyuYNFKIEnMzfOkMfsqw4YmtPNRRsSt4tPCdnA/22y7EMJdM77wdsSsmsHJiDwzsF4JguLgtfWyqshmAlBUnFV8uogoTwrzOoUk4+DX+ukipO6B87PZskEtpGVMQ135tLIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:43:02 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:43:02 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 29/32] hw/arm: phytium: Connect the Phytium E2000 SMMUv3
Date: Tue,  8 Sep 2026 18:41:38 +0800
Message-ID: <20260908104159.1621764-30-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfffe73-ddfd-43b0-02f9-08df0d95f4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pFaLL0uXKlh52u9ICgpLFcEotaV6wF9k/yhhpAovTM30DSb1gDG6sGPAhEDkx0ZbrtDcMeX7c22ZLiVSfqHzksJs8Eqy+u42hSTNc6Y4/GIE2p3+vK+AYbhNwGisokT9lCaudcYktmdxXbVuMkWuHU5HdeNMGnerz0AhPf9ExrT6zptCa/GnL+A1bRUEiLIwYiKxu2vN7yPPXin4R/Xa3fTj2u594YhA6KCc7clBWzxpVnqz5Bar3DtoGK/QK7CE7mRj3uAxZBCxXF5FH9u6NUjzbEkwmcB0CgbNLxPeb96yhsrR7QUoPlCu01OhN8SgnsUxP726ZRG668cxYOec1xSPBIeWok9b8Nxiul4IR1H+ALbm65yIEtZGr3nyvNtFrAHRIfRzV/q+IQHvd77bTVuBc1MbKd8E3FXWuTXIk2C4pMxNu1fUNWOkUbc2N2VPgOrlHXlcCn7UIv+KiYYiqocZzbC8X32+IVWD3KSPqQCreDRct9JHAFDBaB6L7ebuIlMqMOG39xpeAm5IMZo5kINZ10PnUDa9AUImyvRHcAjQSpfVZ/bsjU7SmYFNXPDY2X9s1VYQ9N2UU5TLj3TmHYx7E4i0tBi6IKHg6uKPQjBOc2NEYUm+cajDPG2Yx40lyJ7Gw2Z4P4TmqvynJ33WlVf+hR9/GITvzRUamaKT/io=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1x6MlunFzx1hz+MhwVki1o7SZEqSTlKPn+S0Jc4TCpGO29sT+at8CJOXFIv?=
 =?us-ascii?Q?VKhGSN25KVXNJCPcKuEFCN97Vk40Y8UURARlfbp2HoWB83dW28TNXN32ONc5?=
 =?us-ascii?Q?rgF/WmwRtORNlgZ9oLaH0v/y2Nl/HXSxg71T53nsSIrSyYBIUSao/DRIFyim?=
 =?us-ascii?Q?Ukf9eltV8ISHH6jN45iE2FTTy4qOZd1FyMh9rFYoVZ87+XnivLKlWuIB8Wgi?=
 =?us-ascii?Q?yU/kT2cFrPRsTDmAhEHwBQPbS8BqHuuiabcck9ptok2KFYN5Dsn0dDmENt2j?=
 =?us-ascii?Q?Pg7ogRPWOTVFuGrC8IBWOo3+LLXEgqc2omJ/Hk85qHdFvBgSa8wBot8vMXCy?=
 =?us-ascii?Q?YQNgAYjdXus2Pv3gJKGvDpt4vvru1IzIBC/O8hXB7QsUvQzCOf5kc1HkoUbO?=
 =?us-ascii?Q?1ZMlVx1Zx+OpLp2XODBFb6WHzDvo/JPhqTtrDvjNjd6QUW+WbrZtoEO5Xm/e?=
 =?us-ascii?Q?h+lvPoKD31JVN4N3JX4JAvVrFFPuY1mHWEqwbIEbVe57vay3jvpXo5eWfSKw?=
 =?us-ascii?Q?+SbhSJEidWQlOQt1jEjOo5l/RfEIr+HzrUmhTc8AlQB7J43wYyb2zI9fW3zv?=
 =?us-ascii?Q?BLiPnpC4ihs+islNCKPp+4oi33Z0S+iDlG+CWGP9g2nh2EsItjATojO2fgq7?=
 =?us-ascii?Q?ayDCoe2EkwJClsdU86uZTg4pAVM4FiYoHzTO+w44jtwy3P81bffK+QD02Gat?=
 =?us-ascii?Q?W+1Ow6mU2f+iCjfp5NymB0nIrr3nWVtRV7gFmddngwIQlRRMTymXh1ieDvXC?=
 =?us-ascii?Q?60hDF4dn/3icS1NgSC+tZhYJF20lWb3Hoe6cwoY8uo2gHafnp3OCUtcnVf/Q?=
 =?us-ascii?Q?lcd64QTTfJFT2OC0RykLe2VUpdYHVjZed0JkqaOXrDzalk5lw+CzLtw80zFM?=
 =?us-ascii?Q?XFlcHz32AhWE0CO7OziJB8f6bENynHMXHqKs2nZ2UMXOR7uLH4CuqPgG4F7x?=
 =?us-ascii?Q?HZagyHYD8W6QukeONEKSREQY5swU+wKVUSlrxRngLb9Q5iKUwVT296wXmy5z?=
 =?us-ascii?Q?Ds899P4nuK2JPuA8RhGSfwI6IyKr+nlUJJ7b0ZPWFZqWMIXMf2YOY2CUNyYI?=
 =?us-ascii?Q?bPAG7snVH8VibIO+VsAFARLyEmiQYqcSL5f3Efkq1H5qmbHnnMDNFG6/UTkg?=
 =?us-ascii?Q?1wwgQvsfrZ3FcaLRN87sbt9ZDKRGn2jRQc7OzlzvNYu/9/jCS2mILF5A0S4C?=
 =?us-ascii?Q?yu7xbU0BxU1FYgdfG5ig/SDpioLFj0dYiprVCPrejhfEV8vgN19Ch4VfM/LK?=
 =?us-ascii?Q?bhJwXBwtPEYkJ4ejSAgNDYDZ6a7BRpmvXuo00Rb2ssq3MKjWHPutLD5c7JMx?=
 =?us-ascii?Q?c4Y03vYBNJ832Pi5qC4IbsVmjV91vXMMuIqjJ82adLB1Ac8Nopx41wdQwxrT?=
 =?us-ascii?Q?FmhBTv4CdlmCE5Z6Crjpo3HuPKF0dTwn/LXZTZUivfgDGbYuXjd4cfXYPy3c?=
 =?us-ascii?Q?Jmt7FgxAkAB7T6gyYi7Q1ZYc2mV/zcBnng0cfD/lJTVFjVeEnrH3m1k2pD6U?=
 =?us-ascii?Q?B06cf+4EeD3lGIVZnyAI+pOZ4Xgowsk2hB22z7le43MBy83Qo8lCT4UerBWB?=
 =?us-ascii?Q?DnufbFR8cUDvQF5KzTSXWoWS6CxxTFkab9hV+Ni4/H7tGN6wp2z4WcWaDwMB?=
 =?us-ascii?Q?ZG32r2mNiH108p2dLQYa4VNnBnIrAM5k68wWPq5l09aTX7PVMqMAs2ES5E6Q?=
 =?us-ascii?Q?Co1ldODVCcMCx5LgpnEZQfm+kgRd4dRdzUG131m6/q5VRXgWxEH1ew5JB8E6?=
 =?us-ascii?Q?IKncqN8c9HiGtkpybOxIiY/od/JdxX8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfffe73-ddfd-43b0-02f9-08df0d95f4f7
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:43:02.1907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkmHwjrS8rzUBo2IzK6pBD4jM4I2UT3OSOrepyvTqviUtGJLNQ2olmkgHzOwWu2UZEMfeD/vK/w72D3qXwZLabY4hf92lzWsPr/1HAm3AHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6579
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The vendor device tree routes PCIe DMA through an Arm SMMUv3, but
its MMIO range currently reaches an unimplemented placeholder. Linux
therefore reports that the IOMMU has no translation support.

Attach the generic SMMUv3 model to the GPEX root bus with the
documented interrupt wiring and document stage-1 DMA translation
support.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move SMMUv3 into the E2000 SoC

 hw/arm/phytium_e2000.c | 39 +++++++++++++++++++++++++++++++++++++--
 hw/arm/Kconfig         |  1 +
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index cb94318430..b4ccf71d0c 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -17,6 +17,7 @@
 #include "exec/hwaddr.h"
 #include "hw/arm/bsa.h"
 #include "hw/arm/phytium_e2000.h"
+#include "hw/arm/smmuv3.h"
 #include "hw/char/pl011.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/ide/ahci-sysbus.h"
@@ -49,6 +50,7 @@
 
 #define PHYTIUM_E2000_NUM_UARTS       7
 #define PHYTIUM_E2000_NUM_XHCIS       2
+#define PHYTIUM_E2000_NUM_SMMU_IRQS   4
 
 #define PHYTIUM_E2000_MHU_BASE        0x32a00000
 #define PHYTIUM_E2000_SCP_SRAM_BASE   0x32a10000
@@ -123,6 +125,14 @@ static const int phytium_e2000_uart_irqmap[] = {
 
 static const int phytium_e2000_i2c_irq = 106;
 
+/* Keep the architectural SMMUv3 output order aligned with the vendor DT */
+static const int phytium_e2000_smmu_irqmap[] = {
+    [SMMU_IRQ_EVTQ] = 240,
+    [SMMU_IRQ_PRIQ] = 239,
+    [SMMU_IRQ_CMD_SYNC] = 236,
+    [SMMU_IRQ_GERROR] = 242,
+};
+
 static const int phytium_e2000_xhci_irqmap[] = {
     [0] = 16,
     [1] = 17,
@@ -462,7 +472,7 @@ static int phytium_e2000_pcie_map_irq(PCIDevice *pdev, int pin)
     return pin;
 }
 
-static void phytium_e2000_create_pcie(PhytiumE2000SoCState *s)
+static PCIBus *phytium_e2000_create_pcie(PhytiumE2000SoCState *s)
 {
     DeviceState *dev = qdev_new(TYPE_GPEX_HOST);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
@@ -538,6 +548,29 @@ static void phytium_e2000_create_pcie(PhytiumE2000SoCState *s)
             qdev_get_gpio_in(s->gic, phytium_e2000_pcie_irqmap[i]));
         gpex_set_irq_num(GPEX_HOST(dev), i, phytium_e2000_pcie_irqmap[i]);
     }
+
+    return PCI_HOST_BRIDGE(dev)->bus;
+}
+
+static void phytium_e2000_create_smmu(PhytiumE2000SoCState *s, PCIBus *bus)
+{
+    DeviceState *dev = qdev_new(TYPE_ARM_SMMUV3);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    object_property_add_child(OBJECT(s), "smmu", OBJECT(dev));
+    object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
+                             &error_abort);
+    object_property_set_link(OBJECT(dev), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0,
+        phytium_e2000_memmap[PHYTIUM_E2000_SYSTEM_CTRL].base, 2);
+
+    for (i = 0; i < PHYTIUM_E2000_NUM_SMMU_IRQS; i++) {
+        sysbus_connect_irq(sbd, i,
+            qdev_get_gpio_in(s->gic, phytium_e2000_smmu_irqmap[i]));
+    }
 }
 
 static void phytium_e2000_create_mci(PhytiumE2000SoCState *s, int index)
@@ -858,6 +891,7 @@ void phytium_e2000_soc_attach_sata(PhytiumE2000SoCState *s,
 static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
 {
     PhytiumE2000SoCState *s = PHYTIUM_E2000_SOC(dev);
+    PCIBus *pcie_bus;
     int i;
 
     if (!s->num_cpus || s->num_cpus > PHYTIUM_E2000_NUM_CPUS) {
@@ -898,7 +932,8 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
         phytium_e2000_create_gem(s, i);
     }
 
-    phytium_e2000_create_pcie(s);
+    pcie_bus = phytium_e2000_create_pcie(s);
+    phytium_e2000_create_smmu(s, pcie_bus);
 }
 
 static void phytium_e2000_soc_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9b6a1f1d5b..f32ce34602 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -133,6 +133,7 @@ config PHYTIUM_E2000
     imply PCI_DEVICES
     select AHCI_SYSBUS
     select ARM_GIC
+    select ARM_SMMUV3
     select CADENCE
     select DESIGNWARE_I2C
     select DW_MCI
-- 
2.53.0


