Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91AAC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aW-0005jP-ER; Thu, 03 Sep 2026 07:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aU-0005iQ-S4; Thu, 03 Sep 2026 07:26:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aT-0006k3-0S; Thu, 03 Sep 2026 07:26:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOjBd69L7Sq8MA+n73sZDP7+YxrvTL0sP1Lgeat7UYbRx8Od1vv+H3rwsE9kMS0qGOyDJXhtEssJJS5pVX0lOPR6HQj7Y60iSIY5/J23Ll6hwPUamBV4QQiHJLXCqGcYOTvLO947fRkvhjvqKnXpt1dPzkX6oXgRaftXpXLi2l2AEmLkCnBt5gWzHbk+iN2gSdNyl+68TxHovsLFNLrh4D4kIgNmox6Obbve1Q9HjFEcKEPZbAlTcxoM9tPUQXNg1MHoDq3ysiygQjOHG7O9yp5XVCKAmR6NLuwUr7CSulNRywlt2DabBtT75V/r4zt+Hd9a3voWK0mE6N7I/p1+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPEJQLUZkXmRM6XjN98FFMEdMGGjPzf37MKPgJnatgw=;
 b=w6DPKKZehlxbSYi/QO2ipdPR49yrODzcOIzDJnzfbHcdEtyqVJ3pItIlyg9xxRQv05maMGIItP5NUyNKpyicS6WSZfEVr+1j388WBnO5OIbmrs3uMztJX7oWQoKyHb4bHuP69VGrxZSwqdquq7A1m/3tsRDDpqS5e6V6QZa8fcVKKjosss/wFhfYDKosIjQFghO6NmKaBDKm2a5ISG7p3j3Bj3c5kip2RlZdHzCXooQbbpOCWrvLfpAfvf+5mC2FAIcDb4i6P97EjD+IkRrVovgahrqdmEZG4ecRHQ1Z/oS+NiBOuATGWpHNs/msnRSRA5GcH5WINo4/yAHFt550JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPEJQLUZkXmRM6XjN98FFMEdMGGjPzf37MKPgJnatgw=;
 b=BvsTkXJmv0huiNPxGQQhXQti2ro9RqzTgU7MmFIiBuH17r1g4NhC8wH21T1kbetkFf+pruTM6v6e0uldhCYpiB7wMDT8JI3UzCryntbxSrY4ZS7zmUeEJRqLOk9wpL8TQG65N9eY3bSBa+OCNUgAOiSviVv0fA6w0OOBn7WH+764/fgVnz8UeIaFwaeKMIyymYG0UfeZS5X/QdusW/6J2IYVkTubbcTae1K1fxdNMD7eK4gO7d017QGnSpF57aEm/noM0kCAhvptXLIkcPNgjLX/RCErCBvppV3yAThhApXXqsxiREtfCz+W4CfOeicGHJ6+OmrJykMDg2H7yUEEzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:22 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:22 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 16/33] hw/arm: phytium: Integrate the Phytium E2000 PBR
Date: Thu,  3 Sep 2026 19:24:56 +0800
Message-ID: <20260903112532.3276678-17-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 841da7b8-0038-4c8c-8e44-08df09ae2eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: HO8MPK+GazyZ8asE5r/DTJ44tHc0NHMHEH3wMulgv5pyOhJwHFf0sBg0Yn1A/Ettameh4T5NGuM/+BcXrTlsPTQ5LqGyD42ySokPQmYG4YgwFXLW4G46g3zwWHe6jo0SeUj6KFC9oAQ/d+stPZiTSXKoFLzl3UcLyHnBEnPsjKnUTrxnD/2crO4hbMzseWLZpAkCTIPdN3CZ/jKY27cpxebCG5Nt1VBfHAqQd9h8r56DXI4kqFLNl8qRXcbGgy/WtmvkgeX/Sztvvpjiw6ZSdLPbDzByCWmNo0me7UXYvX4pE8BVOhnC19Ni+T59o8+GeTTpDWjzfJZhrMoPiO/uVlZKZubFaHPrULLhfEhZqYqHfZ6f/rNWm/jge61K0iq7Y3R7FpMAimNiEZeH8nsLDnzCKiSogBwP7JaY3vt5StSQzu3kZSn69MwB84uuaQt6c0gT7+q8FjjkweK8/UcvEjSX85fuAdfVZ8hH9QKvj3uN3jFT3Xn+rKKRpzJyaZhg/WgVd1RNWzV3IxHQMNHI5F2yvR3Q8Dv+qqYCaksAiB9UQK+/HNsXIdeMwGpOkMVGYkGTOScOQlyrfFQDL9UO0t8+B/5R5SKcQmauTK+jIbu1zj7UNEKwvMDTgVvYoyu2w0ipmn+aUrf1CxwfPgt+CqlnswpX+mbGj/eqjgRVwes=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPbhf+M3e0M4220ZkHUFRTakMjzmpcAdDGvezKBFmWQy2/vuPjddqv44rIxK?=
 =?us-ascii?Q?KFYkm5TANJ8fIEkozpUInBFXzDdN/QBoNPaoQfkr9iOhHz3fAxx3EPTWNTmr?=
 =?us-ascii?Q?qGkf74TFgz1Ay4GLAeHaLmMSSrae/ACeFnnVZtaEXwZF/YiGzwG8g7BdSKlg?=
 =?us-ascii?Q?BtUr0h/npyfJFgT/ZvrjzeaWhE0F9JgQ8tfrTtVXrHz3+vSSSDkWD7Lb/y/G?=
 =?us-ascii?Q?JIcSF1pWnnAdedJRIGd/8fGJ6bmVfqNhLl6xoCZHVskRj950lAMORvKLhnwF?=
 =?us-ascii?Q?1DYgnR3b8xHhOOrlAUpx1KnJt+beLicqMUN3brqs68qhbpSS3PAv7fKY/p0S?=
 =?us-ascii?Q?R3GEAWO0C71lNCHcOEFh+u2rxN1dyavYRavHAeW/rqOKroKy/T1TwmRX5xvO?=
 =?us-ascii?Q?kLCJSBuVHz1dHVd08nGa/glQciIVXF7urj4Wr6n6KO26Bz22aKDelSV2sx7Q?=
 =?us-ascii?Q?VIrfh+dsDXwg//k3FiunZVVAzSyoPSpYqlvYNJ3GFslrN0y13PjWNboK10a/?=
 =?us-ascii?Q?SlzT4rnlAp2qbS+V+vzd8idNbwbhgC7FfnwD68z1segyDiGbpNSh78mnZDGU?=
 =?us-ascii?Q?tCskvdUZkQ80bzfWXDDqSaKpnEyG1UBfXZloEAYMoI06xD8sbyjv1pouzRBj?=
 =?us-ascii?Q?UkilfBulZksRhu7BajxjNsvZIPCOTUHFT5smD6we7if1GWaIQ2OW9tMiCa/M?=
 =?us-ascii?Q?Vhgg+5j4Ully2rkDJm7WGG4VZ1eMX6myA3XDWcBttojWsqysilpZzk1U5hHK?=
 =?us-ascii?Q?XtGKuYj0xkKGv4yDCB5KesM6Ex8ismJuWC9c1nCH54STyTpiV0L3XUhAoHu+?=
 =?us-ascii?Q?ulGLomuEOL2T+Y3Yrszs42+Hz9LXgHLBJAesOTXcCoL5LabO9Ir5ubgmhYQP?=
 =?us-ascii?Q?70WQMh2bwl+Xb/xfTAtYLvqOADH24dvKex23YBpT1MqGnC46jIR0XuUfsWGM?=
 =?us-ascii?Q?siCJmIc8pt3pcD7t0CU0ZpkCsK91pwaj6rfe91dIy3wn5m4avlBRRjRxGPEB?=
 =?us-ascii?Q?frtLbpICTVGP8nBRGFLgNO1VAsP+4yM/7cBY7z2NLCTO1/HNSnbWAJEVYU9R?=
 =?us-ascii?Q?y0OOohGbd72/ksY6z1Nx6XvlN5fUgO03CgHR0jvlTHAemTAi7nH6XqyeC+6p?=
 =?us-ascii?Q?YdRV4/372fSU0OJXXb0wlXAO5zcZbgR22jq3iwQIR0yFdnAN1XEv5yDFPhNw?=
 =?us-ascii?Q?MoDzL/mAY2Ye0z6OTLdTbPMgrXgDL2CHN1w7HmPIyBmy72p633KCYQqOYSbt?=
 =?us-ascii?Q?DmEQtiG92jiIjAL0He3m9hNgitwLDSnzqz5Q5s+hH07dsqQqL1UxZVEA3VVG?=
 =?us-ascii?Q?lL5Ld8ImYtZCzF0OW44gvCki1PwLSVLRdwjUC18STXDFYlLEin8IZkD/Q6i1?=
 =?us-ascii?Q?ZS1vsdydbgcmYKFndsf9QGePfB+IMfBsGjBzY0BN3vZS5b6x7QkArKOcxJek?=
 =?us-ascii?Q?G1yPNiY5FH5BIaBLW1kZuKi+0N3D10d8FguZ0WliEaL8RDYj3G8xaBkCj3eQ?=
 =?us-ascii?Q?Ydjj+WK0MmZhtUNTPBKolw+2X3AhClcHG2ksPczoMH/DpY+D01jfChaK5oud?=
 =?us-ascii?Q?nlxjO1907lA5/AVszFTDACOYI8QUSfiJ2n8BO1V0iCU040DuPG6kcPsxFvoX?=
 =?us-ascii?Q?PVTFW0hvGwQc32DdFqL/s/90oWk6FvYjdPrtQ7AjqbjEbclI19B3yEQIR4Zf?=
 =?us-ascii?Q?d0GcWyplMAbW5azlRgzLZ+eo3lRcd63tBaOSx5Me/dqO448yp1X9MeeR2z/e?=
 =?us-ascii?Q?syUsEZ2JqMULWkzAXCktOE4f1/sbjSU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841da7b8-0038-4c8c-8e44-08df09ae2eb6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:22.4120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdBaiuOoXK/yRlB87c/3Xbrn0jHDF9ADwAXgAJSgY4PlHqxDsGfp+zMMHMJbXioCXTeYPDZmKDMt0Ou+IuQHsWEReJATO8IXxIFhdEi8GIA=
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

Instantiate PBR in the Phytium Pi machine, map its status and boot
memories, provide the heterogeneous MPIDR topology, and connect all
CPU objects for reset-time handoff.

Use SD0 as the board firmware backend. Explicitly reject the unsupported
-bios and pflash interfaces.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/phytium_e2000.c | 97 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index c6d789bb04..e74a0328fe 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/cpu-common.h"
 #include "system/address-spaces.h"
 #include "system/kvm.h"
 #include "system/system.h"
@@ -20,6 +21,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/arm/machines-qom.h"
+#include "hw/block/flash.h"
 #include "hw/char/pl011.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
@@ -27,6 +29,7 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/misc/phytium_e2000_ddr.h"
 #include "hw/misc/phytium_e2000_mhu.h"
+#include "hw/misc/phytium_e2000_pbr.h"
 #include "hw/misc/unimp.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
@@ -96,8 +99,10 @@ struct PhytiumE2000State {
     struct arm_boot_info bootinfo;
     DeviceState *gic;
     DeviceState *qspi;
+    PhytiumE2000PBRState *pbr;
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
+    CPUState *cpu[PHYTIUM_E2000_NUM_CPUS];
     MemoryRegion scp_sram;
     MemoryRegion ram_low;
     MemoryRegion ram_high;
@@ -208,6 +213,17 @@ phytium_e2000_cpu_config[PHYTIUM_E2000_NUM_CPUS] = {
     },
 };
 
+static uint64_t phytium_e2000_cpu_mp_affinity(unsigned int cpu)
+{
+    /*
+     * E2000Q exposes one core in each of the first two clusters and two cores
+     * in the third cluster. Firmware stores these MPIDRs in its parameter
+     * tables, so a linear CPU index is not a valid affinity value.
+     */
+    g_assert(cpu < ARRAY_SIZE(phytium_e2000_cpu_config));
+    return phytium_e2000_cpu_config[cpu].mp_affinity;
+}
+
 static void phytium_e2000_create_its(PhytiumE2000State *s)
 {
     DeviceState *dev = qdev_new(its_class_name());
@@ -410,6 +426,15 @@ static void phytium_e2000_create_pcie(PhytiumE2000State *s)
     }
 }
 
+static void phytium_e2000_reject_legacy_firmware(MachineState *ms)
+{
+    if (ms->firmware || drive_get(IF_PFLASH, 0, 0)) {
+        error_report("phytium-pi: -bios and pflash firmware are not "
+                     "supported; use an if=sd,index=0 image");
+        exit(1);
+    }
+}
+
 static BlockBackend *phytium_e2000_sd_blk(int index)
 {
     DriveInfo *dinfo = drive_get(IF_SD, 0, index);
@@ -471,6 +496,47 @@ static void phytium_e2000_create_qspi(PhytiumE2000State *s)
         phytium_e2000_memmap[PHYTIUM_E2000_QSPI_DIRECT].base, 2);
 }
 
+static bool phytium_e2000_create_pbr(PhytiumE2000State *s)
+{
+    MachineState *ms = MACHINE(s);
+    DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_PBR);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    BlockBackend *boot_blk = NULL;
+    uint64_t cpu_mpidrs[PHYTIUM_E2000_NUM_CPUS];
+    int i;
+
+    if (!ms->kernel_filename) {
+        boot_blk = phytium_e2000_sd_blk(0);
+    }
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        cpu_mpidrs[i] = phytium_e2000_cpu_mp_affinity(i);
+    }
+
+    qdev_prop_set_string(dev, "boot-mode",
+                         PHYTIUM_E2000_PBR_BOOT_MODE_SD0);
+    phytium_e2000_pbr_configure(PHYTIUM_E2000_PBR(dev), boot_blk,
+                                phytium_e2000_memmap[
+                                    PHYTIUM_E2000_RAM].base,
+                                ms->ram_size, cpu_mpidrs, ms->smp.cpus);
+
+    /*
+     * PBR owns the status snapshot and both boot memories. The status block
+     * overlaps the broad board-control placeholder and therefore needs the
+     * higher mapping priority used by the previous status-only device.
+     */
+    object_property_add_child(OBJECT(s), "pbr", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_PBR_STATUS_BASE, 2);
+    sysbus_mmio_map(sbd, 1,
+                    phytium_e2000_memmap[PHYTIUM_E2000_BOOT_SRAM].base);
+    sysbus_mmio_map(sbd, 2,
+                    phytium_e2000_memmap[PHYTIUM_E2000_BOOT_IACC].base);
+    s->pbr = PHYTIUM_E2000_PBR(dev);
+
+    return phytium_e2000_pbr_firmware_loaded(s->pbr);
+}
+
 static void phytium_e2000_create_ddr_status(PhytiumE2000State *s)
 {
     DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_DDR);
@@ -570,7 +636,8 @@ static void phytium_e2000_create_ram(PhytiumE2000State *s)
         phytium_e2000_memmap[PHYTIUM_E2000_RAM_HIGH].base, &s->ram_high);
 }
 
-static void phytium_e2000_create_cpus(PhytiumE2000State *s)
+static void phytium_e2000_create_cpus(PhytiumE2000State *s,
+                                      bool firmware_loaded)
 {
     MachineState *ms = MACHINE(s);
     const CPUArchIdList *possible_cpus;
@@ -587,18 +654,30 @@ static void phytium_e2000_create_cpus(PhytiumE2000State *s)
                                 &error_abort);
         object_property_set_int(cpuobj, "cntfrq", PHYTIUM_E2000_GTIMER_HZ,
                                 &error_abort);
-        if (object_property_find(cpuobj, "has_el3")) {
+        if (!firmware_loaded && object_property_find(cpuobj, "has_el3")) {
             /*
              * The generic-loader U-Boot path starts after the EL3 firmware
              * stages that normally provide the Phytium SMC services.
              */
             object_property_set_bool(cpuobj, "has_el3", false, &error_abort);
         }
+        /*
+         * PBR releases only the primary MPIDR named in the firmware parameter
+         * header. Secondary CPUs remain powered off for later firmware or
+         * PSCI bring-up.
+         */
+        if (firmware_loaded &&
+            i != phytium_e2000_pbr_primary_cpu(s->pbr)) {
+            object_property_set_bool(cpuobj, "start-powered-off", true,
+                                     &error_abort);
+        }
         object_property_set_link(cpuobj, "memory", OBJECT(get_system_memory()),
                                  &error_abort);
         cs = CPU(cpuobj);
         cs->cpu_index = i;
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+        s->cpu[i] = cs;
+        phytium_e2000_pbr_connect_cpu(s->pbr, i, cs);
         object_unref(cpuobj);
     }
 }
@@ -606,6 +685,7 @@ static void phytium_e2000_create_cpus(PhytiumE2000State *s)
 static void phytium_pi_init(MachineState *ms)
 {
     PhytiumE2000State *s = PHYTIUM_PI(ms);
+    bool firmware_loaded;
     int i;
 
     if (kvm_enabled()) {
@@ -626,12 +706,15 @@ static void phytium_pi_init(MachineState *ms)
         exit(1);
     }
 
+    phytium_e2000_reject_legacy_firmware(ms);
+
     phytium_e2000_create_ram(s);
     phytium_e2000_create_unimplemented();
 
     phytium_e2000_create_qspi(s);
+    firmware_loaded = phytium_e2000_create_pbr(s);
 
-    phytium_e2000_create_cpus(s);
+    phytium_e2000_create_cpus(s, firmware_loaded);
     phytium_e2000_create_gic(s);
 
     phytium_e2000_create_scp_sram(s);
@@ -654,7 +737,7 @@ static void phytium_pi_init(MachineState *ms)
     s->bootinfo.board_id = -1;
     s->bootinfo.loader_start = phytium_e2000_memmap[PHYTIUM_E2000_RAM].base;
     s->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-    s->bootinfo.firmware_loaded = false;
+    s->bootinfo.firmware_loaded = firmware_loaded;
     arm_load_kernel(ARM_CPU(first_cpu), ms, &s->bootinfo);
 }
 
@@ -701,7 +784,11 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
     mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = PHYTIUM_E2000_NUM_CPUS;
     mc->default_cpus = PHYTIUM_E2000_NUM_CPUS;
-    mc->default_ram_size = 1 * GiB;
+    /*
+     * PBF/BL1 relocates to 0xf8c40000, which is outside a 1 GiB RAM window
+     * starting at 0x80000000. Two GiB is the minimum useful firmware default.
+     */
+    mc->default_ram_size = 2 * GiB;
     mc->default_ram_id = "phytium-e2000.ram";
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_SD;
-- 
2.53.0


