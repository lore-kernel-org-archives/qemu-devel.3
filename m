Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38290C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHb-0007yR-DK; Tue, 08 Sep 2026 06:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHa-0007xf-CK; Tue, 08 Sep 2026 06:42:30 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHY-0006YC-6c; Tue, 08 Sep 2026 06:42:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kqbqi6lpw0CaXr00D1/JTAfCxKhihs+hEGG2RCvLVjQXpazFVoGnjS5wNz8fs8XxQf/vABN9jY/hQSHMte5xwTVgjL/LaUqOzsPQydvJughxu+4N/u2y363SE8aTaebLDuSnh+8BXqJGIj9NobRq445QkpuAzdUuiEnhHsDnn5V78PH5TXlUGB9f9HvqV1F1IfXKE/10PdbrKUa/uKi4ITLM3wOOiHW/H6bdv2IX58bhGRmF2tlO+trEzF1Yuon0N0CQNP4xtO5zCrY0ifJoM7JM1GU43cZE+6hfTVIXlLEIW5KPZLGCSkD9bgdMHBFDtySZ0/m/MxEWZw2A/2dERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLCjJiFEqcIFZi8d+g7KubBEBGNQDrF9gTaJBD8Z9K8=;
 b=b1SFgBzLRBmvODalPNQgno0Pgo8NxWZFBD2THB+o/WqYpf+osqISy0ZpEO/P3tXUMaJgtewOUf+NplQjheutO1lsna53qeqRNS7uqz5qr1dyArfTzmyR7yD0+w4fcVhRWQqUNbVjtZEkuSdQHjcbJk1SUAjH4raSEJUgqH11kovkApLDDUl6KnH6plfzuXG19hafOUpc08Y618lujSxJLOdkJEOtvpm+xCsQjHwPoBZItYRNLxBIIKg2KOKx6dK7kKaqqjxh4ZsvugemgP4OOK7AE7n69KXam3EwNR4XEe0oSD5saM2/aFMzeZMilT8PxPCeNbJywYatcayz0ClHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLCjJiFEqcIFZi8d+g7KubBEBGNQDrF9gTaJBD8Z9K8=;
 b=o9cnqkS2Co/b1K33U6IkIdwAeanB8M38CGkB6peZh1RbVIcK3jd0vxnY8L2q1TqXvkkVgkDStZQLyWddgDDbQ2/ICnZire9rnePx2vhfiqXQXko3ehq6EkylDvG00X0EUwvq4YA4lz+hZQGSKtPBKFJrt2JNhkqJM/XmS76Un8It/QcjtREAM5am+PcCR8Kv+4ybMyi8KS/kJN4Tj2qSidHW2ALl7rviLXBiRxvqEgfWz6xxRvN/rdRv5jRgIl/PutwvSO7rfAWp5FnLvXohjcstJ4yCAVgIiKOzQm4ef9jwkNyL0yDfWIz4M/ywOi1smh6rGCszQbRKhfpYQoQcag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:21 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:21 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 02/32] hw/arm: phytium: Add Phytium E2000 PCIe host
Date: Tue,  8 Sep 2026 18:41:11 +0800
Message-ID: <20260908104159.1621764-3-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 880a0611-bbbc-4bc7-259d-08df0d95dcd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 4sC1zBWYXmRHDnEsCY/OMRZFlUeWEwU2t6jNr024LxLH/G/mRKKQDSSbTloZxb5uQ89rOmV2Awo15YPdxK216s38xPNvIs2s5D1SjnNEbLCfhvbs6KnHlH7dw6IB/Yt2pGZCwoiT1CJpvE2lMxWxLt9n84qA51yYlIsfVKTbFFMZxu9IR3OZiRitrIpVv62B0Y36Cgu8ctjly8lqLJzarlmhDNIz/BidmAanVo1oso1v1w8pZSG8tLFJywgBLtDU88hNFAtSSgvsWxs/ehvYdXuvTuDqnyqNbpd6VFYRUXCb5WaIrmp5Mx8WBkjadCIf9qm2OWoelpBwG2ihwVUWgNOYPnpRHmaIwKdIEO3vxVapR9FbOmLCajw5SRLt0HnKFpI9JBo/K/wQTnt401wDAS9nFJLsKLY+7xLxf1mUKhKsvvu7mZIi2/1qPWedXrFl31UWTo5MPytc3ScPcHeP3DNWlOiAABEp3MOFP/gHruBbS8ZjWTg9tORqmBB9AZGOHCxEY+55Fb2UGk7+FOfFmHTUjzyUHEapp5T9CDmHFZ7Z++rDxViiMpr8FpZaLVNotVB7V0TLurMVVw+izywaqmMzWGQ42lj/wqvJnTVPolO5R6lm3xzUlCq2RwbmHQFLu/DGYpPv+7qZXcOs9p0VIg+xPNPlxIp1IHqjsR0Fk+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uyv5LojBuL3AdgvMIAwvHNuieAsTc/oTDpbOyCqPqYQ+LLcjHpdEadWJ0kP+?=
 =?us-ascii?Q?3uenmFi61BxQHHW8sLou3TIaZ/ipS1PPRU5emx8/V+mBpFkLwEYV1r9HCuMS?=
 =?us-ascii?Q?B9ZO25jhYOswaslCHj7IL6PXzog3nEq+Og6fUUusQaecHflX+4HwiO80tE5E?=
 =?us-ascii?Q?m9EIUw9NTvdKhjecdor7iRXjy715s48CqSq9P9gmGfF1G6z/ZWqYq0eU8cKX?=
 =?us-ascii?Q?iltAnyPrC4g2Lsuasg7MEJeMs5BgeIxMSigsrwOkV3DauHX3UtRvlTHWzBKA?=
 =?us-ascii?Q?s2fFuJ2QBLKqKQWdjgGMXTKE3hBI7m8AfVGjbKD9oQ+GSBLl/dw9IpNHMVJB?=
 =?us-ascii?Q?pNLAF8+kIbmeWMux2aS9K1ua2QK8f9CN0EsOvATkh3M6of8InENQQJkmmrpq?=
 =?us-ascii?Q?NpgUV8hg0lcs9CKWZTSKe1iCQQiun9QmaFMyk7XTY/8sPki65igI/YcDiFtM?=
 =?us-ascii?Q?TXdtMglCHDbk79zdvgkf49OpWJ9TFhdj2jwZ22CARhkfwZpqUADiXRrpVg9p?=
 =?us-ascii?Q?oozkujMTBjrOBIFbX7e32J4blWx2wN80PH6I5itzg5GUq5I4kwdoHYpUovYj?=
 =?us-ascii?Q?5zOglaIE/nEsifI//F46xiB2Tar/GwIRx+OT5ONnUuU7S/Kc+0IE9EQetDKG?=
 =?us-ascii?Q?UJ/er6+lJ9Q5hAxzn7otxqytgoJIj7sM/V9SG3dFcnKaQf5adCXq9Vl15eit?=
 =?us-ascii?Q?lWPzHO8qf7Xedn6xr9H/YY1SELn660uSpAmWpB6YR4cpV+sUc7ALpEwMVBhK?=
 =?us-ascii?Q?9MI8US1hHx12j7AnXtQ4HffkVEPAgzR4LMej2PbvnWuz0QYX4z5txy/D9kd1?=
 =?us-ascii?Q?npqzBctLF99hERzd5tlBJmXZ34fVYX7w3cVQHM9saqFiq+ho9kEecNjgm4V1?=
 =?us-ascii?Q?zDweqW0UUTT0xgzPurZ2qLtJLc5ikdYyVVEM35fV/I3KjNfDdm7KFSPIrzp6?=
 =?us-ascii?Q?Bkc5uah2a8tuXYwD5g+PfaX7QxOgtQXt5bNO6lRTYDnN668k40R52zNx5400?=
 =?us-ascii?Q?3ur7iYgGQC91okQSoB6+g9qk02oaKpxrLQm5tdYARsOLIK6r83wQzN1rz/Fi?=
 =?us-ascii?Q?gDb9iEb5Bp/MX32ANH1ZX8FF7A1FTUR44DeOq5gp7k8hHiE70AYYyZbBHtpo?=
 =?us-ascii?Q?RRIvREiB7L8fHaPFIR158x0TnLTXfd7dOUxet7WMnMZMM7V74orH9Zpx3t9F?=
 =?us-ascii?Q?aKEHGs0ZjuswzGIewhZsPdxBzs0iLmJ7cG+i6rgoiHAayeDm1Ng50uD75Tvj?=
 =?us-ascii?Q?zP64scJsroPmF/jQwkcEIx8tiFHyr7I1zbYe8mUQmjNI8QjiDuoJntgZRTcn?=
 =?us-ascii?Q?mRvOwfgHPI+L58PrxaSOYOlQONikZbTkJnAA0Ftv7OrP2RPpvIa/6aPw6ZVN?=
 =?us-ascii?Q?8eSilgXSY6Q8aSi/NgWt+kGcPWLcIzvezWxr+IZhygPaLU4bAB8F5lk0YrVV?=
 =?us-ascii?Q?KhfkiyLv0bMiugHqfi07fRQG3Pd9zrhGtSNtOt3M/OcOueCNOuA3xDG8ku1i?=
 =?us-ascii?Q?CqNP+949LqF4q1HOGny+tJ9H5utY0TDCEOJc/c1yOXRV0qRL4SB0O1BslarQ?=
 =?us-ascii?Q?qywK+SB1H9FuVu/5/Z+m8qI/caHrq/tgCl7BvpkwFqn3WB21uUbTbesY6b0y?=
 =?us-ascii?Q?c0LuGJAz4FOnwvON+Hon2BnSbbMmld/6l7VWkqN5XixE2q++4zIZUaxYR+TU?=
 =?us-ascii?Q?2ZBBpi6Sn+xov8R2Hor5X53pRiQ+i3PONzGW3eEMdsbBuqyhQoAvc8MdbwZL?=
 =?us-ascii?Q?X/tduLkYgjnU9RQyYimCFIM7hsOlTn8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880a0611-bbbc-4bc7-259d-08df0d95dcd4
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:21.7394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vM/Di7P6sX/KpX3/viNSHJg1ObZ60NP5iPuf9S7+JQqs14UMU1eUDkASj7jD1aQ3uiV6hComfcp2shepRXZ3fZGsNzdzPzGBYPHnDUyvixc=
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

Changes in v2:
- Move the PCIe host into the E2000 SoC

 include/hw/arm/phytium_e2000.h |   6 ++
 hw/arm/phytium_e2000.c         | 111 +++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |   3 +
 3 files changed, 120 insertions(+)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index 466481f629..dcb6c46272 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -34,9 +34,15 @@ enum {
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
 
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 8c62d0dbdb..ccfd9bad7e 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -22,6 +22,8 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/misc/unimp.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/gpex.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
@@ -54,9 +56,15 @@ const MemMapEntry phytium_e2000_memmap[] = {
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
 
@@ -70,6 +78,13 @@ static const int phytium_e2000_uart_irqmap[] = {
     [6] = 107,
 };
 
+static const int phytium_e2000_pcie_irqmap[PCI_NUM_PINS] = {
+    [0] = 4,
+    [1] = 5,
+    [2] = 6,
+    [3] = 7,
+};
+
 typedef enum PhytiumE2000CPUModel {
     PHYTIUM_E2000_CPU_FTC310,
     PHYTIUM_E2000_CPU_FTC664,
@@ -275,6 +290,90 @@ static void phytium_e2000_create_unimplemented_region(
                             phytium_e2000_memmap[map_idx].base, -1000);
 }
 
+/* The vendor DT maps root-bus INTx solely by pin */
+static int phytium_e2000_pcie_map_irq(PCIDevice *pdev, int pin)
+{
+    return pin;
+}
+
+static void phytium_e2000_create_pcie(PhytiumE2000SoCState *s)
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
+    object_property_add_child(OBJECT(s), "pcie", OBJECT(dev));
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
 static void phytium_e2000_create_unimplemented(PhytiumE2000SoCState *s)
 {
     /*
@@ -285,6 +384,17 @@ static void phytium_e2000_create_unimplemented(PhytiumE2000SoCState *s)
     phytium_e2000_create_unimplemented_region(
         s, "low-peripheral", "phytium-e2000.low-peripheral",
         PHYTIUM_E2000_LOW_PERIPH);
+    /*
+     * PBF programs SoC-specific PCIe PHY and port controls before U-Boot
+     * enumerates ECAM. Their values do not affect the generic host bridge, so
+     * keep this control aperture visible without inventing register behavior.
+     */
+    phytium_e2000_create_unimplemented_region(
+        s, "pcie-control", "phytium-e2000.pcie-control",
+        PHYTIUM_E2000_PCIE_CTRL);
+    phytium_e2000_create_unimplemented_region(
+        s, "pcie-phy-control", "phytium-e2000.pcie-phy-control",
+        PHYTIUM_E2000_PCIE_PHY_CTRL);
     phytium_e2000_create_unimplemented_region(
         s, "board-control", "phytium-e2000.board-control",
         PHYTIUM_E2000_BOARD_CTRL);
@@ -369,6 +479,7 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < PHYTIUM_E2000_NUM_UARTS; i++) {
         phytium_e2000_create_uart(s, i);
     }
+    phytium_e2000_create_pcie(s);
 }
 
 static void phytium_e2000_soc_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 05676534c2..7bc85f4f9f 100644
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
 
-- 
2.53.0


