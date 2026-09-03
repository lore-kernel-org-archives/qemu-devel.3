Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2313BC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25a7-0005Tr-SL; Thu, 03 Sep 2026 07:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25a7-0005Tb-04; Thu, 03 Sep 2026 07:26:11 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25a4-0006f9-U8; Thu, 03 Sep 2026 07:26:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMt+NNaHxhN1vZ9Widn6x7EEkeLgPXaCx83w0B/ANfYsDSoci5HnDriZxkjISnZtTNKa/7VD/ivXjOvEyX9UjxDCZ1bX4oHt46e6BpMTj3U43fomUHvCNSrjw8jAohevxDxTAcJlrr1N+EeaQufB3uXTZTIJositY09XA5kyJHYomQhWtU3rD64sVAkMz/5rZ0B6gHyKbmLouxpmdji3xiqCw0Uv7Jp2CfAKNzvxLS0x+wz7ggm1xVA1Yg4Mcd/ZDGDRnJzuecCXgf27Gq+3ioxdf00h3B9ohhG267s2hbR5PrkyCxzgMXTsjHoNkL5oIXKK19dMlsxjNBhDv7lnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs8i7lnDNzaOhIBGDLGDuLdsJvjxFRUwbju3AA6pexw=;
 b=X1GDLRY1ZBgDJSc0bFRcdBy5Ox7SimjqKLKE+8AL5mVaC33XY00sHoEQcPOaq73hGAj+Zn1TNC07/80QYV6x0ybLQBFo86lrBBhI9bKoaKBrWnSbHCy0COLEVFbu39ugUeROrveVMBo9cZ6/lXoRStZpBAiBTxtqX7JQ3Ntaj3BBY6L1vBiTwQU7j6KDmJm+cTeiX6bU3gW86ab/Qvnc7uwLnq6j9f7ykSqKpn1jU3MMoW36DSTd7kc4HNbDgqkUTeIRvXNp59sFi//SOBYDQvCDQCZgkbITuEB9Qxo9vZH/foJdj0lqje9ynuDmQTAGk7fdc4Ubg+XyB7a6sRaxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs8i7lnDNzaOhIBGDLGDuLdsJvjxFRUwbju3AA6pexw=;
 b=O9i4i92AkMhhPW8zjZLB3nMV1uujCaOhoQQF4LPqLumcmBJJvfXNgP7EPqGz/1dgllw7wPcD+JrmsR5KodXqTkYd9PgoZDXZlE36LYZGOI8EzWbLKZO3f1x/4yiysxg21WZVHewU6nnP7vaF9dN2jimTE7bF4x2D68k3Q30zASe6H4BskZN7+pPDa/jqpos2xR0UG+iPAMGltH1empbpkFY3md3EIFscZ+lXYcOWLnwp5XWx/4Q+mHoWnxva/sUtVscawRSMXWaSLINwoYm3t1ia5RsieJSPzXfxXn5QsLTsNFrX3VbKdfmJyWJwoUZJ8EZB7xDLAFR2oS8tGFgGfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:25:57 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:25:57 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 03/33] hw/arm: phytium: Add Phytium E2000 PCIe host
Date: Thu,  3 Sep 2026 19:24:43 +0800
Message-ID: <20260903112532.3276678-4-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 978bcbe5-bc0e-405c-d8c1-08df09ae1fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|5023799004|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: WpkLAY90whhNV1VNNvXUCIhurqbwelPDnennIsDZbzMEoPCOz86YrAgSEaKkauhuvyRtgmNBswBt+E0wsA4EZI0fp9hJ8Q7AxXYSCTqybNbWd4IpqJg5RoKtYxRwWcYBYIZhIRaqXMT+Mcmiy8kQtUulyQQYAGj9GhXtWZgWqjvfoH4ErIG/mq/RBvrPl4xbJjne5jloXfIzJHslcJ43DYAtqqAaiWzUN4kS0DLa+rwUqtlunxtc+Ir+Tlex9VhKCIImGAuqYfKDSd+jZdt+28VjK7/+hZTkC36J2TUOFQ3aAEjqeljb8pfGrKyzeUGbuoRwjjK+Rzx44T36QEjf8rvqEyyMTWZ+Y25NL/qM5zcBuOc+VRbOx9JdsGX6gqOsH+HVCpBqpC5ySEmPmVPe4dO7R4nG8MYcTZdcvP5ApU+PJ3AhMIt8jvFroWyWzTYh/KTfjOSDYsfDcKV1ArfacoXx1hferZKyxLkdJ90SpIPccn6ZF/vHa6ilB5IMou8aHcxZrYeqNZf3tarIE8yKofynveFByi2jj5fdcDvq4/m0ykfJeoH+KYtPGOu+FI0MIL3haPHlFSSJFkW3cAWr7tEIfQHbyBvEt0U4HOTDcMszf7J3NI+XGio4KYOIHK2syCU9AJy9vboH/TQ6DmY4/GwNpYKx/bDpj48Q8JGQBnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SU5TU/4Bs01QuBNF2YumSjKgT0CP8d99vRQGXyHoDk5gfJny/E/5sHUchND6?=
 =?us-ascii?Q?JByBDv9ELLfa25/k6ysTx2o+aYiAYbnFn4K8PbkEeuyQiqKqxe5RV96GnMi1?=
 =?us-ascii?Q?fn5fN9rdKdjRqlawG6PoxmqNr7u/UluyrgMJJDDkMqOc89/YXVcbwoLK1KqW?=
 =?us-ascii?Q?5r+d5mMnhxYMfNsru4aCdpcvrFPAJ2OHf6YbXVCW7fEU8K1juD/ZbasBG7Z9?=
 =?us-ascii?Q?cHDSDX9kS0ie8v8cX/1POzDepBJJwVhjBqCkL//YfTEGHVQIyUwAKCNRf9ih?=
 =?us-ascii?Q?tNYnOcexd5ZvQQFVi4aJydtI+ruQBvMo4dDt8Beb75pbujlb+/MMlET5KWiZ?=
 =?us-ascii?Q?KmSgK3bykBP57J01v4Qdp7/3BPCQPCF7mGjXdQfKv3H57w/IKnJPH0Tf0Vzy?=
 =?us-ascii?Q?xiCD/Wo68T2hELEfCXqCvclqVXnX26ujvdKNmAVHbYg/voC9wd09TElvDthn?=
 =?us-ascii?Q?CRJj0jGRkm6kIru60r4BjA2c9nNjz3tFSesGoJDwLOUrnOzAnD88Y6MgahgZ?=
 =?us-ascii?Q?DRpD29kDqLwIus84zzjoLHEiur7jVs0WfHTG/KVrdnPk4QLsQLvrde2cWTa1?=
 =?us-ascii?Q?2F3rWVAnfDVWhcNMQIzRUrjZik/xfdg8Xa2b2FAoksEjf0X5IBuQl4ZrA9nf?=
 =?us-ascii?Q?V0+wPYX6AdlN3faDzTAmMa9zeGeq7bX0sChietnNXu3Vtu5/vKBRZzGNflJM?=
 =?us-ascii?Q?dLupAer2vDqg25411/UdbqhgCOPDckc6N0vMWUsP7SoNIdaf75FpJuwI3z/8?=
 =?us-ascii?Q?89wwSdMq59OgSeLH7J8nPMwh7WjxFhsXEUFsv2jqUik9JyYY3wFVaE9l1JSy?=
 =?us-ascii?Q?gZQ1Nt77afnei8g7sSAsVhRbRgu0r9K1Ql1IKi6wtVMc3+2EYb3PMYJx8EWw?=
 =?us-ascii?Q?rivurjM0OW1oFvZO4enIRSpRV1Y7soBGobYs8QpCRFp0u14UgvAx+8xQP8Go?=
 =?us-ascii?Q?5wlfwZF6uSaPXWmElsxV/JmMTHzUd9pZJlI7xVc0SqEd3q1XXh/+TA0GD2Pe?=
 =?us-ascii?Q?O0A7g1B+wosDJzECAs3emqSndAEyZ/v1e4DzggMUJYmKi6yRrq/neTrLPIeh?=
 =?us-ascii?Q?RiFN1bijFlVmgS58VhkNarWCPZUOdcbft5w9ZbINKHW79TDUGQwuLsKFtJEt?=
 =?us-ascii?Q?vAoiceaDfS66N5y8g3Y1uRohj+D4wfQqrmluGjW8SNhu3/NNGTDsGosb4Uzl?=
 =?us-ascii?Q?/kCgnT5/s34adjXIm+xC9ZkluAwyGFVtXUqiIJRp1QgUkAPGAR/0RnpK2J7E?=
 =?us-ascii?Q?RteIIr9sj+iMSqQ9eYcpjVg3rp0X1d3RS3cd7uuf0KOOPMiCJlFYF22b5lJ5?=
 =?us-ascii?Q?8RWx9D8hgWhaQ/j1b0iLQ3hM4veV6tLzi4LIQc9zS92xcBdAg/S7qig0zFIc?=
 =?us-ascii?Q?j1zonM8i503UA9IvYpXNYjfe5kKpLRrMrUq/DcD8Sy8LxNw0OLYihoPEOOQb?=
 =?us-ascii?Q?IZxtO+SWp1ok1EQBBy74KDlJvo27aY4EssuTiztegL6PGmnf1RBLuLXy8Yyd?=
 =?us-ascii?Q?WVcimYV/bvYbzYxiBfR6uQrbElQCxAm1v1gBvKImuOwZwDRqsfKRiNY+F9sk?=
 =?us-ascii?Q?lffA70Md8XWHnGXRRZ+KDpvxpLsroEBrxAp5pZOi1Vffzgg5u25Fukg7tBb/?=
 =?us-ascii?Q?yepTYKaZ1zVuvQXWUPsGNE21lB8bydqs2pwq+lvXeV7gTYOaOsA8Ou5cpprY?=
 =?us-ascii?Q?tL7k33rjOmW7DygP6knkl3WBSCrp4BABFaTP8ysBZvQFg9rfUlAhiQpbwQOY?=
 =?us-ascii?Q?dLwnQV+aQLgAWFvn/wHh9flxysQ6RtI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978bcbe5-bc0e-405c-d8c1-08df09ae1fbc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:25:57.2757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQUN48RrngzxxImHgkmT7srBGaFrPf+X1ucUJ5lPYQs7iUqaD7BiU7Yxwv1uMSzDv0ci6C79dERiSe/rvzwcRXiiY08hcEacw/t2Cvqso/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
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

Add the E2000 GPEX host with ECAM, PIO, and 32-bit and 64-bit MMIO
windows. Connect MSI through the ITS and route the four INTx outputs
to GIC SPI 4 through 7.

The vendor device tree masks out the slot number and maps each
interrupt pin directly to the corresponding SPI. Override the GPEX
root-bus IRQ mapper so it selects an output solely by pin. Standard
PCI-to-PCI bridge swizzling remains unchanged.

Expose the SoC-specific PCIe port and PHY control apertures as
low-priority unimplemented regions. Firmware programs these windows
before enumerating ECAM, but their state does not affect the generic
host bridge.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |   3 ++
 hw/arm/phytium_e2000.c | 118 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 20863b5847..e68f137a66 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -130,7 +130,10 @@ config PHYTIUM_E2000
     bool
     default y
     depends on TCG && AARCH64
+    imply PCI_DEVICES
     select ARM_GIC
+    select PCI_EXPRESS
+    select PCI_EXPRESS_GENERIC_BRIDGE
     select PL011
     select UNIMP
 
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index defc265a5d..aac798aa07 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -26,6 +26,8 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/misc/unimp.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/gpex.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
@@ -55,9 +57,15 @@ enum {
     PHYTIUM_E2000_GIC_ITS,
     PHYTIUM_E2000_GIC_REDIST,
     PHYTIUM_E2000_BOOT_SRAM,
+    PHYTIUM_E2000_PCIE_CTRL,
+    PHYTIUM_E2000_PCIE_PHY_CTRL,
     PHYTIUM_E2000_BOARD_CTRL,
     PHYTIUM_E2000_BOOT_IACC,
+    PHYTIUM_E2000_PCIE_ECAM,
+    PHYTIUM_E2000_PCIE_PIO,
+    PHYTIUM_E2000_PCIE_MMIO,
     PHYTIUM_E2000_RAM,
+    PHYTIUM_E2000_PCIE_MMIO_HIGH,
     PHYTIUM_E2000_RAM_HIGH,
 };
 
@@ -87,9 +95,15 @@ static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_GIC_ITS] =        { 0x30820000, 0x00020000 },
     [PHYTIUM_E2000_GIC_REDIST] =     { 0x30880000, 0x00080000 },
     [PHYTIUM_E2000_BOOT_SRAM] =      { 0x30c00000, 0x00100000 },
+    [PHYTIUM_E2000_PCIE_CTRL] =      { 0x31000000, 0x00200000 },
+    [PHYTIUM_E2000_PCIE_PHY_CTRL] =  { 0x31500000, 0x00001000 },
     [PHYTIUM_E2000_BOARD_CTRL] =     { 0x31800000, 0x01400000 },
     [PHYTIUM_E2000_BOOT_IACC] =      { 0x38000000, 0x08000000 },
+    [PHYTIUM_E2000_PCIE_ECAM] =      { 0x40000000, 0x10000000 },
+    [PHYTIUM_E2000_PCIE_PIO] =       { 0x50000000, 0x00f00000 },
+    [PHYTIUM_E2000_PCIE_MMIO] =      { 0x58000000, 0x28000000 },
     [PHYTIUM_E2000_RAM] =            { 0x80000000, 0x80000000 },
+    [PHYTIUM_E2000_PCIE_MMIO_HIGH] = { 0x1000000000ULL, 0x1000000000ULL },
     [PHYTIUM_E2000_RAM_HIGH] =       { 0x2000000000ULL, 0x180000000ULL },
 };
 
@@ -103,6 +117,13 @@ static const int phytium_e2000_uart_irqmap[] = {
     [6] = 107,
 };
 
+static const int phytium_e2000_pcie_irqmap[PCI_NUM_PINS] = {
+    [0] = 4,
+    [1] = 5,
+    [2] = 6,
+    [3] = 7,
+};
+
 typedef struct PhytiumE2000CPUConfig {
     const char *type;
     uint64_t mp_affinity;
@@ -221,6 +242,88 @@ static void phytium_e2000_create_uart(PhytiumE2000State *s, int index)
         qdev_get_gpio_in(s->gic, phytium_e2000_uart_irqmap[index]));
 }
 
+/* The vendor DT maps root-bus INTx solely by pin */
+static int phytium_e2000_pcie_map_irq(PCIDevice *pdev, int pin)
+{
+    return pin;
+}
+
+static void phytium_e2000_create_pcie(PhytiumE2000State *s)
+{
+    DeviceState *dev = qdev_new(TYPE_GPEX_HOST);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    MemoryRegion *ecam_alias;
+    MemoryRegion *ecam_reg;
+    MemoryRegion *mmio_alias;
+    MemoryRegion *mmio_high_alias;
+    MemoryRegion *mmio_reg;
+    int i;
+
+    /*
+     * GPEX owns generic ECAM, PIO, and MMIO containers. The aliases below
+     * place those containers at the E2000 physical windows that U-Boot scans
+     * and that the SDK device tree publishes to Linux.
+     *
+     * The MMIO container is indexed by PCI bus address, so each alias uses
+     * the physical window base as its source offset to preserve a 1:1 mapping
+     * between CPU and PCI addresses.
+     */
+    qdev_prop_set_uint64(dev, PCI_HOST_ECAM_BASE,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_ECAM].base);
+    qdev_prop_set_uint64(dev, PCI_HOST_ECAM_SIZE,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_ECAM].size);
+    qdev_prop_set_uint64(dev, PCI_HOST_PIO_BASE,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_PIO].base);
+    qdev_prop_set_uint64(dev, PCI_HOST_PIO_SIZE,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_PIO].size);
+    qdev_prop_set_uint64(dev, PCI_HOST_BELOW_4G_MMIO_BASE,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO].base);
+    qdev_prop_set_uint64(dev, PCI_HOST_BELOW_4G_MMIO_SIZE,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO].size);
+    qdev_prop_set_uint64(dev, PCI_HOST_ABOVE_4G_MMIO_BASE,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO_HIGH].base);
+    qdev_prop_set_uint64(dev, PCI_HOST_ABOVE_4G_MMIO_SIZE,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO_HIGH].size);
+
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    pci_bus_map_irqs(PCI_HOST_BRIDGE(dev)->bus,
+                     phytium_e2000_pcie_map_irq);
+
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(sbd, 0);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "phytium-pcie-ecam",
+        ecam_reg, 0, phytium_e2000_memmap[PHYTIUM_E2000_PCIE_ECAM].size);
+    memory_region_add_subregion(get_system_memory(),
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_ECAM].base, ecam_alias);
+
+    mmio_alias = g_new0(MemoryRegion, 1);
+    mmio_reg = sysbus_mmio_get_region(sbd, 1);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "phytium-pcie-mmio",
+        mmio_reg,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO].size);
+    memory_region_add_subregion(get_system_memory(),
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO].base,
+        mmio_alias);
+
+    mmio_high_alias = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(mmio_high_alias, OBJECT(dev),
+        "phytium-pcie-mmio-high", mmio_reg,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO_HIGH].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO_HIGH].size);
+    memory_region_add_subregion(get_system_memory(),
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_MMIO_HIGH].base,
+        mmio_high_alias);
+
+    sysbus_mmio_map(sbd, 2, phytium_e2000_memmap[PHYTIUM_E2000_PCIE_PIO].base);
+
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        sysbus_connect_irq(sbd, i,
+            qdev_get_gpio_in(s->gic, phytium_e2000_pcie_irqmap[i]));
+        gpex_set_irq_num(GPEX_HOST(dev), i, phytium_e2000_pcie_irqmap[i]);
+    }
+}
+
 static void phytium_e2000_create_unimplemented(void)
 {
     /*
@@ -232,6 +335,19 @@ static void phytium_e2000_create_unimplemented(void)
         "phytium-e2000.low-peripheral",
         phytium_e2000_memmap[PHYTIUM_E2000_LOW_PERIPH].base,
         phytium_e2000_memmap[PHYTIUM_E2000_LOW_PERIPH].size);
+    /*
+     * PBF programs SoC-specific PCIe PHY and port controls before U-Boot
+     * enumerates ECAM. Their values do not affect the generic host bridge, so
+     * keep this control aperture visible without inventing register behavior.
+     */
+    create_unimplemented_device(
+        "phytium-e2000.pcie-control",
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_CTRL].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_CTRL].size);
+    create_unimplemented_device(
+        "phytium-e2000.pcie-phy-control",
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_PHY_CTRL].base,
+        phytium_e2000_memmap[PHYTIUM_E2000_PCIE_PHY_CTRL].size);
     create_unimplemented_device(
         "phytium-e2000.board-control",
         phytium_e2000_memmap[PHYTIUM_E2000_BOARD_CTRL].base,
@@ -331,6 +447,8 @@ static void phytium_pi_init(MachineState *ms)
         phytium_e2000_create_uart(s, i);
     }
 
+    phytium_e2000_create_pcie(s);
+
     s->bootinfo.ram_size = ms->ram_size;
     s->bootinfo.board_id = -1;
     s->bootinfo.loader_start = phytium_e2000_memmap[PHYTIUM_E2000_RAM].base;
-- 
2.53.0


