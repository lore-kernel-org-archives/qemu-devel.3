Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A4AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25bT-0007aW-TC; Thu, 03 Sep 2026 07:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25bN-0007Iy-Hy; Thu, 03 Sep 2026 07:27:31 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25bG-0006vi-S4; Thu, 03 Sep 2026 07:27:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2q6ggYuhbJoXQnCYwo8mLORFSiFL40oPzFzuaVBBcqiwC/q6ChKl6XOyHUR6t26WNB7SDWQhfnkU7yT/SV5aNCEKcO3JYF7iTkK6FhNH1kzqnsLc3xEJTOcfJZ5BPClB8RDsZ5SQzRkJcr7JT9QhsF6nkrwG3Ic5DmtnaDA5WWJgvyzos9BK96FB0nQN4j82tHTaVK+tsIf3ESfwVWEUL7z2+FiB0kjwpZMvWTKRk8EQZhBE6wbxB5y6oTU1Y/0m8Gq7vRL0gWGjoTDOimsNUu7gF4DtvLrkB9c8ByBQ1IqCcaU0QIzwmPslmKmyrUeobTGgYBPRUerS57CimZg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD0PTM4uKACa5Bhot53aAPioMLPtM1D+QwJJssxP9zY=;
 b=ryf4yGpYALSAEFIPiul6NsAoGamkeu3tA3GL5UNdlXj5W0uM0dGnvcn4e6BzLJlm6edV/mlPiMhVb8tKx87m2QkesNlDvFDiCiu1+7VHE+bj7bEK2ATZjdKdd/zczF3317bHQeAdu5y39STz8uOs6mJvXF1J0F3ref7BtoML6X6yjbbh5wDW/MjuJ7158bQXj3v65khXni2UaOFPgcWtaxAWpJNQKugMgROpl8yxy3MtFErR1+bkwdvy/aABRx8JUJ5ZZrNiSLmA83Y8cH9dStSc/WuGb+icwIFre/t3w9uF7RvrZ9tTTm4vA2hLeiPVOEr64Hd9PQlsJJEZ47fOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD0PTM4uKACa5Bhot53aAPioMLPtM1D+QwJJssxP9zY=;
 b=UpJ3MeA2naQ+xfWBVmtZo3MArHFnfOORB7xgd+RSQIFr/o5XGTn4W9PXphZ5OWcFpt1XZfC4pKFIwvs2V+oAvvl0yq94OmT0Ytn552IaFmvNpz2ZOZ/U3ZF/K01vzl3WJ3Ig8De4EFRnGanryGFlSEY07v1Jg4sDpVPFBMgvJUlSK8PmPJIzzfy+2hrkr37TkxMTsWDVaWVW1ufTdbNdCIxGLngRSXZ63G6ajrFdh1Id0i8RG1PZsokf5Y7yG/nl19+JMwHuraz3MDdrP0wXsNvmmMA5gUZpkazkfXzn0sgYYLBQX4xXro+dHFbEEnLyHk3AfpMTFrEK7m9RCNAwZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by PS1PPFF2E6AB00E.apcprd02.prod.outlook.com (2603:1096:308::2b1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:27:18 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:27:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 30/33] hw/arm: phytium: Connect the Phytium E2000 SMMUv3
Date: Thu,  3 Sep 2026 19:25:10 +0800
Message-ID: <20260903112532.3276678-31-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|PS1PPFF2E6AB00E:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d215ad-1222-4a94-f752-08df09ae3e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|3023799007|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lUz0fNo1h2MqqqhAXRj1yaxB8L6RDPnMsat2uy4DhgFE2X9Ptk1mLiazLVVAwM4Kl+akvKrYWtXvRCM32bovtgoOwD2fxodP+bZua+SMNCNZrIcGEErg7zogt7NqxjBiFJXu/Ty0CMQJrnUZZll5eaV5BYkWQddAvqb+XLJIXuRba7IAySotTrC12cz3/qfAcCIxgRJkjZlSGoo/uMpG7Vy0EceSbfVzkrhfFwFO/1zz/ohAezg4m9o/ukKnn7GDBhPYwFX9qKwUGt6FS8O1XRExiP2MBTd437INmbuAxrfoPB2nQig3n8WC5QkUq9pqUeEINwcIGa2AAusTuSAMThtIO2hLZLymkfs5XxoneQOeTZJPcu4WD2K5pNPhD3owKewuhNSUz4iMU7kZANQqb/pQZygpN4GEd/j5k6gIhNS9j3bytwlwE82UwCk2KXnvBMAwGVdhPdNfST0eK+NME491zd/+zqg1CYpH9TWWHaIc8z54LOfk+ekefVCgd59Lt5bSerWEiQ5WqyL4eifpta0ZAm6Cu7ACBIE5t1MlKOK7/ENol8kGpGkgvcR4NVC8apHFKyK8FluMB7sMAm8ez3BvzfrFgtxlGcXwJOJ5iW5EbkL0pNcNozqjPhCbWX6RBqkILsm9Dl7AcpNYWlyuPH4kEC26seVBkSJbvmi7j3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j1sswyUOqpapErUs8/6AWOgY1KYzFyIjtt0YFdbgPxiVeAcKUhP7Yqtuky/D?=
 =?us-ascii?Q?9JJ60c65JL2yOf8W/RKY29h7PZ3k0aZHufEHwNn2VUCuuAUKZMbSeEB6QCpq?=
 =?us-ascii?Q?ruWNAGKSsmKPeTvvU3JNWo1/ViFAPMJ/7VjtDMTnG9LR/Es0lbjUL/wjOq+v?=
 =?us-ascii?Q?m5sonM7FrtkYlrsSf2CddiyXEWRMLcvMNtPp7Cl8+mmBHoWFdTnselKvKrRD?=
 =?us-ascii?Q?tGd5tXxBRFksb72ETSDSnbCtFoSOkrvPnSU3Awz6S/a/W52clqy2taR6/sKA?=
 =?us-ascii?Q?W7PSH9pa691tKDX534pxUU0hhVTaU3e/qDbZn+tme70oxBBMvSi557Uf81la?=
 =?us-ascii?Q?1BTylfgjetAKE0nhD5iPWJ0DwGuCH2bvpPVvgs0YKmigO+rfCL3TuRY7UR+E?=
 =?us-ascii?Q?w6Atq3btsxH2fGQPkY3hB8i74o83huEE6YnFbx/f+ROgfdXB8i/jfnXiIhwp?=
 =?us-ascii?Q?c5XsTVAMQqIV65bbtVl+Or8h2XQvqkPc6GV5nb9T7suYaTlDs6w+wQJvodZj?=
 =?us-ascii?Q?ZO4aP0CW6WOXxq/UTOTj4UnVmp0HWziXSCyWduOEs+ku0jN3nJZn6OK0Jc83?=
 =?us-ascii?Q?bTb+RrT5C7WbSCapX1Ifu6R8+Z7WTs+tn3/wWwiUfTVu3POP9RIsY+7hkxKv?=
 =?us-ascii?Q?SCMZqW0vh2ocmvgAPHxkPOc4GdwkKfGht8a99qti2a6ntkWqXG2DpAaLUe2C?=
 =?us-ascii?Q?O04f4+idNCVX5G7e+Tud6F0G+WfVeGImuJ/1Pyk4Y8IX+xMnuYocjRRNJmcR?=
 =?us-ascii?Q?4ZShZ2eXeETibdDgQXEvOAFMFsqgNVf3lY7dgc1vw8bvpYGyxziaWuoC2BnS?=
 =?us-ascii?Q?kZ6ZtG6vefcKVFQI23lNRVwJg50/lCdIBsoHVLkecnYLUC+SmBxR6uR6GOaK?=
 =?us-ascii?Q?TzSUxO5JmfbGu0VOVDk7iqI84AR2kXKP4NAeFe2ERjc2wAja9XtEWXehxV4h?=
 =?us-ascii?Q?BCPrAe48bcnSFDuu92BL/iSFIhh04hT/8ZLDLt0erQgJ4CxzfcTkqWjT7lmp?=
 =?us-ascii?Q?k5CkIUm77IsvcbRGRF9Jv8TUeRwZhx6J6Ymju6700QQZtdtpnb8hzpkCAWUy?=
 =?us-ascii?Q?a06oNJq49HwnndeiBtL6IWI0kY7nC+XS7WX2/vMaMV9NqaopcFvkJz12RnUX?=
 =?us-ascii?Q?gm8mWwinOHk87fnzM6TqBtjS60XCEtHRICmucl3FWGJXu8xDD3KmVLkm/KF5?=
 =?us-ascii?Q?tq/DRfmRIF9hsgb5sqGiqn3wsG196bnWPXbVxIvlf7np+ivT8a/QF7GEFTrv?=
 =?us-ascii?Q?rsMGwkni4ZmZqTUh4pZPloJ3R8lQjV3KKWap8+4gAjQsDhqqPJvKNTzSizpL?=
 =?us-ascii?Q?ui3NtpmPd9wUjJ2o9DusKpZhnxx5hxkRDpzMZbwnRXR2SjevimlMz7qDAq3U?=
 =?us-ascii?Q?eBsMP+RyJ9Eb9R7s/xMNvoGN4Me+j1xjsJrXuWu7MHUsEQ8K4asFpPQEQVbd?=
 =?us-ascii?Q?PKF8FnvFSuhlVpuaDIWSPKlmAZSz8CjjMPgNgcY5sUmJk1jXSTwxCwXoeHme?=
 =?us-ascii?Q?m7YRVNn066YIgmQL299oz7FN6K58m3O5/m63iIEleXCZP0zH+SLYroUwPvt2?=
 =?us-ascii?Q?VuMzITm273yy2YNlTPlG+0dPnCthnzON/eMxqCGoX6ivt8HpDDvbPFATf+J9?=
 =?us-ascii?Q?Xr43pIMMASy12F7+X1DBh/jAfZr6OmG0aC6/fvLAowsZwYRnIDwUYWZqR418?=
 =?us-ascii?Q?nNAS8ryk2zhr61TGHH2WoyFvX5J4Qji37o+06cN0y+ByJqzrKreOI0de6mgJ?=
 =?us-ascii?Q?S9v3/jpJOQb3HVngZikxt+kXmw9KSgI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d215ad-1222-4a94-f752-08df09ae3e68
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:48.7318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggAdaPGE+SpEGyHKYKG8O0A48+K7NAcrPg9igu0h9V/plEsx39TO21umbfpwWLhuEpXjgQM3ABjL8MeNco48+EZ0qrnNPuCfyHK0/bM7b3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFF2E6AB00E
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

The vendor device tree routes PCIe DMA through an Arm SMMUv3, but
its MMIO range currently reaches an unimplemented placeholder. Linux
therefore reports that the IOMMU has no translation support.

Attach the generic SMMUv3 model to the GPEX root bus with the
documented interrupt wiring and document stage-1 DMA translation
support.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |  1 +
 hw/arm/phytium_e2000.c | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 11c16bbebc..ea16a8b3f4 100644
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
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index cfd1ca70c9..8ffd566b36 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -22,6 +22,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/arm/machines-qom.h"
+#include "hw/arm/smmuv3.h"
 #include "hw/block/flash.h"
 #include "hw/char/pl011.h"
 #include "hw/core/boards.h"
@@ -69,6 +70,7 @@ OBJECT_DECLARE_TYPE(PhytiumE2000State, PhytiumE2000MachineClass,
 #define PHYTIUM_E2000_NUM_SATA_PORTS  1
 #define PHYTIUM_E2000_SATA_BOOT_AHCI  1
 #define PHYTIUM_E2000_NUM_GEMS        4
+#define PHYTIUM_E2000_NUM_SMMU_IRQS   4
 
 #define PHYTIUM_E2000_MHU_BASE        0x32a00000
 #define PHYTIUM_E2000_SCP_SRAM_BASE   0x32a10000
@@ -212,6 +214,14 @@ static const int phytium_e2000_uart_irqmap[] = {
 
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
@@ -472,7 +482,7 @@ static int phytium_e2000_pcie_map_irq(PCIDevice *pdev, int pin)
     return pin;
 }
 
-static void phytium_e2000_create_pcie(PhytiumE2000State *s)
+static PCIBus *phytium_e2000_create_pcie(PhytiumE2000State *s)
 {
     DeviceState *dev = qdev_new(TYPE_GPEX_HOST);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
@@ -546,6 +556,29 @@ static void phytium_e2000_create_pcie(PhytiumE2000State *s)
             qdev_get_gpio_in(s->gic, phytium_e2000_pcie_irqmap[i]));
         gpex_set_irq_num(GPEX_HOST(dev), i, phytium_e2000_pcie_irqmap[i]);
     }
+
+    return PCI_HOST_BRIDGE(dev)->bus;
+}
+
+static void phytium_e2000_create_smmu(PhytiumE2000State *s, PCIBus *bus)
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
 
 static void phytium_e2000_reject_legacy_firmware(
@@ -951,6 +984,7 @@ static void phytium_e2000_init(MachineState *ms)
     PhytiumE2000MachineClass *pemc =
         PHYTIUM_E2000_MACHINE_GET_CLASS(ms);
     bool firmware_loaded;
+    PCIBus *pcie_bus;
     int i;
 
     if (kvm_enabled()) {
@@ -1020,7 +1054,8 @@ static void phytium_e2000_init(MachineState *ms)
         phytium_e2000_create_gem(s, i);
     }
 
-    phytium_e2000_create_pcie(s);
+    pcie_bus = phytium_e2000_create_pcie(s);
+    phytium_e2000_create_smmu(s, pcie_bus);
 
     s->bootinfo.ram_size = ms->ram_size;
     s->bootinfo.board_id = -1;
-- 
2.53.0


