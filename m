Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB48C5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvai7-0001bi-N2; Sun, 16 Aug 2026 09:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai4-0001Yu-Pk; Sun, 16 Aug 2026 09:15:33 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai3-0005Tk-2k; Sun, 16 Aug 2026 09:15:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbmAJt6GUTcvGRAKTENgy2esw5ustGfOcXuCjziguoIuOcodXYPH8Eb4lAuNfSPIQqagMNbD51HWm2Dbt7sPR5Ffw812MwZCO/AfydXqjIHHpEEXB9IddjMbSaoMFWfNbVSAaY6K17hXBag4V/BK1Uk7Oc246RGZcmkeNmZA2Tq4ifRgZF+ZB0BrTgfSKkweHcdN5L4v2nkympaE53QuecXz5+XhXS3r/7kUcDwhzQYPguS2oQ5tiN3v9WNl91iwFMKCagCb5YaLfRAQpOvYfiKM8W5HMYL/e9RchqdBZAEr4v4Qy7FFRgmqsh7qWwfTDLCD0fJfl0jAn2DuPjPpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm9HFTlhoL9pj908e/5a7JaWL8BCyJLmlKR0BH0ITro=;
 b=ZKS7T1dtbbEiVGuMDYgaru2r45dWBbxqSF8/8//YCtwaLCEz2EIuh05jPL8Hf5bYGwfa5wNeRNhIc2Axm3Il0Lxvwsx8c5xb0+S2dHNP9e3KJqfZ8tFKuOq+CZP0CB740ucbOCKN3IhgHY0WW5cL9MX91rstFel095WNTEOK8cThVl80YKcyTZ3XM0B1ZpagTF5RCAFITtHKXtiLS2ov7GPu4rWqtJP1V+r/jFwLY1qLiZNdMl9/2lh/PN0wxeIaA+f7pbjLDeApUIAmCR4acpZKMvl3tCNYaOhdFwgjA9GCqrj4IPXcwZuTvmJjAhRTAmpKpznnqJPgDy+OMpyVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm9HFTlhoL9pj908e/5a7JaWL8BCyJLmlKR0BH0ITro=;
 b=jXPJkae+/go9BeNT+LAkGrhdrkoza4cKwVVtL3wvSQsljvOAgpFibkrReoLVvtDYQ1H6Cj3v1VdTc3rt6DuNdlpU7IgePn8j69HcrN0apqpWgli2B5yX/6K0/fZeVtR0uOZzzy3CuppfUa65tJD1b6/nZbZr462/dhK/F8H/MTwDQvXITFm52F8Pcsls8n36SyPpTDXS9ptFK5ANKEZVW4kic+R2v1h8Bpy+cFbGFBKc4kb+n/zoWXW1vaNDWslNK0hnxCG8lRBbFfCBV3zb8P77CaPtUxOxI18NVF1W56pqoKknddXfsiufOu1v9M7FeLqIjY8I7n+H+fo9STUvUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:22 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:22 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 08/20] hw/arm: imx8mm-evk: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:38 +0800
Message-ID: <20260816131300.51799-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816131300.51799-1-bin.meng@processmission.com>
References: <20260816131300.51799-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: 798f2df6-acf2-4293-f5d9-08defb986d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nJWpj4mV5htjuNFiJJee7iue6W3mpEXtwRxiy3728o3W4sSNAY5WI9bSxEWiE5XixsRsAQfGJoaCVsafYFjB6EuyOArpa6P+uZeK5cLBnB4Jguud9v5AMHw2o71TkJVs9IzomFc8DDVYWIffYBOLAvA4IqNBvlNoqTljXG47YgeZXEtmtb6lQNHB+UTIMnT6NDjlhw+wAf7NDpOAlpaee3rAEg2YLNOkGz2PO8BJ+SoxnHOTDEA2wLqwHF2TJU/RNluvZr3nR83Q9q5P/ca/JYYLGKcg4oQs40hl+q8YC3UXoa1eWQUOVByB0eiNpqXQBaSx76ktvjOj8KsLNLEBt1mk022p33kBixWpMxpeCL8y6ZMYRSQVu73m5Aq5ac55SdW1xlNVlmeERgkRcs3kjfyVIDNceSTgw/fNH+thiJflCQ+jFrpl7Tr7c9u4j8gtdIAsImdRNoatei9haBRDTkMepWOAWwKynb9xWQN9vzD3GZxj9fBK5G4zqN/QfDgeNKmF+URjnntvG4KO1RN7XSm93ZSkeJ48lJOvUoNYgTNCwrKJfsfT8JfeFrqxUy+ZRSJCS2Jf4d4QU2fAmqMWNZO4Nd6wUXDdUnObUi/dvQSSKU+JIw2WtnD6dnUlBJnnE9YEFFuqjL61P9y0cr8jfS5CSsu3KtUkcAu3y2fg97k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RC1kdkPzkH+nrSvC/yuaz9wtMe2Sf57/dExTdKS4KTV32EjMH+vJLJCidC8Q?=
 =?us-ascii?Q?O+oGfoaSLtSmgKBg+FcMb2Iwls1y+lw/ZMv/aGAcK1IXIbhoBxwoQHUyu1Ck?=
 =?us-ascii?Q?8FcUvhbbHVVe/PTYxsvd5kqMMPi1k6NCFcLbuQZccS+VWM8lDKhcgDG1CbsC?=
 =?us-ascii?Q?KcyDkCDC1IXygKlXP9AUn8/bTg0MXCN4oG2zI15VzyEUhcBS8WOQ8t9oM4DB?=
 =?us-ascii?Q?IaBWsmoIwYOxMuN42br/6YN6fLZg4iDZzxh0/hL1jD0+mzLYObhZstjZ3b8Q?=
 =?us-ascii?Q?oO658b2trjO/9T1eUgw8qy1xcdaV2DUS/TzWvQKFhwlNRwnEWbM2eF3BC2oB?=
 =?us-ascii?Q?Siar2BGL1TxfMRSN7+P8cqzyXsC2lzO7l9/XyXIxAE43NjCtWAADw42N3JWs?=
 =?us-ascii?Q?XsQ318BqL1rB9dIw7F4cdJ9O4RRRsLeLDOvBtFCz6wp2V8g0cPWaYVi3dVKJ?=
 =?us-ascii?Q?QhY1sKIxelMVysgLox+ejRdNH9IMkt7NqU8r22dyxbEWTMZv+ITdejym7LSl?=
 =?us-ascii?Q?cnakzx5NJ4PZLZoAHroepeqMiUgBAdjApOrUBC+Wd1PARFzKj8SKdhShA6v0?=
 =?us-ascii?Q?WkWUrr8sOJfSFZ6FsnYKxJCq7iOzSnAripnMhRarQpXAiBYGum4jfkzE1Zsy?=
 =?us-ascii?Q?TYnl/qm8NOWL30ncpf3DweQHWKKoD7pl4zaJjkznHIxqlr8oUUxjXDtKihlQ?=
 =?us-ascii?Q?olSCIWCa73erbqG15cNIllcO0Q8UdCPw6ATmBqQ8XrjP72ta8pCNxAXYem5H?=
 =?us-ascii?Q?HSeTbOg0qyv+T5gZbxbcD9PlSPBx17g4Rbs+kdTWz2hucOhiqy51hCkpZiQy?=
 =?us-ascii?Q?uP6nvmUQgmEonwF63uZ2oov+lT1EoH6t/qKx5BlnWLfzXaooplzVKH3ymb0S?=
 =?us-ascii?Q?UN0aAvFZ2EheFfeirMEA2eQhFMgdGKUUix/0JM5cu0fG5UomDhW46vMTvNnY?=
 =?us-ascii?Q?ingqBSPJxT1hkSGiYisrPfQlaf/Qk9tL4aPbQ8xbfoieox3yRNnONEO2dwVR?=
 =?us-ascii?Q?wr0AvNfMLPEBpAPWkw+V3p07l/YkbAkMCjA5evGKYb5eX3mNVw59Dmmts7eZ?=
 =?us-ascii?Q?py/z2e1dP0JjCCT03UNfOYAiTAV0rNyZgqyZKbMbI1LjKB8WpWEk1FpmmMOt?=
 =?us-ascii?Q?TPt+iP1WvlOYjVjt9aIkwHo5aLib9BwnV04ncmYG2hKmGlDEpvLOx6Cb4i9Y?=
 =?us-ascii?Q?h17Y+smTKOEX12oVjAGE8yrjnzwH6ANHdsHFmpJuEEhaPyQsLVRCZzJxi0PO?=
 =?us-ascii?Q?AtPb28IQkl/w/mLmSE6SgB/Zw3e2Cz51XOPmPYtg4fjvW+6+4MMsHyhoJ2Bo?=
 =?us-ascii?Q?/H73u8FEqnLDF2eF5w9vYDnptsKAGCEy0oVDaKGH+Gd0c6qDywOacxOJOwrH?=
 =?us-ascii?Q?JWBFylCZEboegfqOUA5LznRdtyVILJP4+TgStPrGbqPP4S1xm9WA1eRj1tHV?=
 =?us-ascii?Q?mc8PNzwOFV7Wkn0zxfD0NL4yNFYUD5ci+gUN9+ANp9gG1d0cW+P/MS+TZ5A2?=
 =?us-ascii?Q?4Wwrp3fCuFjYNjq19UR2j+Yel7Ps/MbQ68NwF/pOA6/u8hewAJ/TViM0EgcG?=
 =?us-ascii?Q?+itFTLzujNWLUU0C5dou38DU1xcI3KVt5y8zfdiklGqqHmJWuhW3fvDrKrd7?=
 =?us-ascii?Q?iXOjUDRuyKf7cSnV6GuthB3DTu/yrS8XdpJimMaTkNkAi11nqmqNvXtes5QD?=
 =?us-ascii?Q?6aHlM46YnbvKRWjBJ2FDnIRsTq/y+26ns/FRuv9b3Fe7bT+rzvX+vEOMHi95?=
 =?us-ascii?Q?AE3OK4cxH2HS10MHc80FLdWMPcoDi6o=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798f2df6-acf2-4293-f5d9-08defb986d76
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:22.4630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFlfiL0D3bwc6bKn43UG8V49zIRiPzkCpILQUI1HTFJfyH5ayltVNqMZN7lr52oanjcz4oKYelG8n5kVaQUE6l+NlUhuW5s3pXf7vmVUSk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
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

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a function scoped static object.

Move it into a new Imx8mmEvkMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_AARCH64 macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/imx8mm-evk.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 6b7774d3e2..019c609c54 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -20,6 +20,15 @@
 #include "qapi/error.h"
 #include <libfdt.h>
 
+#define TYPE_IMX8MM_EVK_MACHINE MACHINE_TYPE_NAME("imx8mm-evk")
+OBJECT_DECLARE_SIMPLE_TYPE(Imx8mmEvkMachineState, IMX8MM_EVK_MACHINE)
+
+struct Imx8mmEvkMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
+
 static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
     int i, offset;
@@ -60,7 +69,7 @@ static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
 static void imx8mm_evk_init(MachineState *machine)
 {
-    static struct arm_boot_info boot_info;
+    Imx8mmEvkMachineState *ims = IMX8MM_EVK_MACHINE(machine);
     FslImx8mmState *s;
 
     if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
@@ -69,13 +78,11 @@ static void imx8mm_evk_init(MachineState *machine)
         exit(1);
     }
 
-    boot_info = (struct arm_boot_info) {
-        .loader_start = FSL_IMX8MM_RAM_START,
-        .board_id = -1,
-        .ram_size = machine->ram_size,
-        .psci_conduit = QEMU_PSCI_CONDUIT_SMC,
-        .modify_dtb = imx8mm_evk_modify_dtb,
-    };
+    ims->bootinfo.loader_start = FSL_IMX8MM_RAM_START;
+    ims->bootinfo.board_id = -1;
+    ims->bootinfo.ram_size = machine->ram_size;
+    ims->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    ims->bootinfo.modify_dtb = imx8mm_evk_modify_dtb;
 
     s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
                                          "soc", &error_fatal, NULL));
@@ -103,7 +110,7 @@ static void imx8mm_evk_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->cpu[0], machine, &ims->bootinfo);
     }
 }
 
@@ -127,4 +134,6 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mm_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
+DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
+                        imx8mm_evk_machine_init, false,
+                        aarch64_machine_interfaces)
-- 
2.53.0


