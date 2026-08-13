Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62037C5DF67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhx-00008A-Dl; Thu, 13 Aug 2026 11:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhw-00005m-04; Thu, 13 Aug 2026 11:51:04 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhu-00023y-84; Thu, 13 Aug 2026 11:51:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHf4BWa4/elHfeiXcwhXvsa1OCS8GMSj1h0rkA1ehMrWZpGfi9sbbA1odbHA4UBzHMFZMmTFRxXOq9Az/197tu1Y2AfxXHFHM+7OZTWtXBOl+6f8ygfHP2b1TGzm4wZoZOz9GyK5Fov1d2jn9CCu83HGQYl1NaGAgOS5ofau2exWBr3A++dqoeDSKK2WHp47E7d2mksmGG478iJvIRJY6LuuxDl2lhn8NLIWqtS+nbySrO14BJx++9MDtb96BpG8n6jOuVTXSWYgl8K988wV/2UTo3mCpVcPyWsbznCkfprHATRTQ7DPXFkla+sIyU35Mir+aMrlhRdHRByGDNNSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2eyqV+OureVzySuOHWXva0mzCFRoF+S0CMJlpfqJxY=;
 b=UODycsDMiRSzr2QwDA6axXx95XllVflL1jcWEx9BLwHTVl4C9gSKgRS79LX6B2Av9A3eYEKIavcrCFlHTMnKUtSyX6OSjDU9EUKopzy1tbnMVW7GPjb+ieeIkwU+1Xs0XP82VyaywtcYaJnlAwpm7Ec/+mEI7v6eMkZVqY+Ez4EDGZYei0d+v9RvN7dckMCwJ5PDL+bh8bF7rmvQfVqotIJCrHa9oN7orp1/Emf4mfySiB2/wu1yfLB0MeExrtUimmkS61aF6mcK20cXEMmdS74EXeRA03bMkve7Ro55DofhgrsG7TaqFhFaTWy0dKOvl53qgZy9KhYySZglGmZQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2eyqV+OureVzySuOHWXva0mzCFRoF+S0CMJlpfqJxY=;
 b=eLfTSEUPgLwgsZmYLPjrEdykGiuzDPVUVOkX25Bv4UbYEAQz1aDbrcaZwXITr/r51isWhh98BsjB5jwqkybUgIH/HmjecR80YswxaGUnvdwo0dfb3L2LEGbip2NKZ72hX3SVOCv2h+bm/65caAWEBf6rvSk1hP+cdcCVQ4WKv6lT3FdtyO9dsBSv9QImCIrHM6hd8YyamXBEWqe7+ugzxHWPQ9mj2Urh5o+0WY+4G+qCcqwcmL0PpRo8181m8BnbMhZT4d4BrLRhO4G5xpBRS5Ax8sPiPdlbMKSTxvWW/LAc40Bha+oaxW+uPoi4Mopoo3zdnEkbWGfxVSXalO1awg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7537.apcprd02.prod.outlook.com (2603:1096:101:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:50:55 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:54 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Subject: [PATCH 14/20] hw/arm: npcm8xx: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:49:02 +0800
Message-ID: <20260813154918.996812-15-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
References: <20260813154918.996812-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 997c243c-ed19-46e9-efed-08def952a8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eNozrVjRGDNmOVughZrRtK6tu1mZQbJmNYJwL00EqMlJKVqCH/oDvsJG+z6mKUxzoTmDaWfh4o9IeQJc5XyYU/e7HAFuh+IWWGc0IgrbzqxmzUJt2uq/NOw887Ho98HCwWD3SZNWn82YPTwGFQ5lKBNz739m5Umi3ufilgJ6iYWCtYMtxmO1mqVMqeZG1mNMl2iF2z98wsYp1LEii20/k2hT55JeA5QhSTKO1BsAbH4dMuBVIvZBqnT1+lU4K5mj6fPdQuErGI7jcx7Z1pVv24u+heAm9G/qu/EePLTqGIn5Joee8lW26QxpL2uur5YlLIChccLaMDcXWJfMuP6u1RRArZ80+p12z3nBmEvc4OHrZgbLB1Q7gw7nyEWR+kQsaJ1Dn9wIroHDsYWn23trFXc7qMjlnmuOks3BNdmRZKLA/33yZqe5QfL5fTbfDpO8wP4/s6pVHUcrTYmEFA8qlJCAwewEL0N7+/SQSSfstVg/ztJ+1z6pI4JmpYq//HIIk+HrCSVsyhKOJboRBbtPin3VnHVOWr75HA0dxHjjxueQXyGDt/T7tLoppZYlOoQzi3Xa9DKptyAv4AeK/kqEG2pCQtEPcR1/bCtQ+Vx3aqSUsZflb9PZAtVCfVrFzllqj9MEl09lENf2lZYDJhdEi0vRrggiOcBat9C1Xu5+KTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsfx8K/avTvOOBfrvLUO6XoFtti0Hwv7b+jNpBlMX2qBFzRDSiqv5Pit4Fa4?=
 =?us-ascii?Q?0R6kvbN6CHKFsXLaQ97wdY7vqOVE3U3Sw69mcBrEP38Tt4ZlE5W8WLJqmMBO?=
 =?us-ascii?Q?unL/IZ61lcPa4ClGiQhiWwGO3mEzCOYhYiS+Kf/QUbFBHxPH3TfQofpplUfN?=
 =?us-ascii?Q?t984FunR2Zd4ZRvDn2MkORgGc8DauFgOozfnjv3s8lOYZBx3v8kZOfgMipNa?=
 =?us-ascii?Q?c3AabLlDn1dtNAhbQN4TZZJZIxxkgDWzZg083cA1kMnxTcvDjwpaFRxD3RRE?=
 =?us-ascii?Q?sa966Y4NiA90M2oVQqteU78suJZbfd2MiJoDEEr1cLxHRFgv6YCS4rgL88pu?=
 =?us-ascii?Q?w31n6c/s6MYXYyPd0NW7If0kzst/oKr78C+jNSVYqYmtXB8lOn3k/eEoq6oA?=
 =?us-ascii?Q?SYY2TCB21uCGsCYbSEn0/EU3iPsWnKP+UURrTMsXndEfdcaeAtgWSLwBh1ml?=
 =?us-ascii?Q?00OnnTDtTbgt0cW3n2VRqXOfGGoSNc2qTUHiMtm3bB5aAXEnSkUrLeyUlhn+?=
 =?us-ascii?Q?ohZqTC40jLHqDWenV8tbJWWWhuHBJsPeK5s2A0X2Qsm9xQbCfikpHkT06r1C?=
 =?us-ascii?Q?lKntcOioPYGqyGUBqrmC7jz+D/ffd9Y6CEnDmf5R7R1VBvLAPOIjtUkHilQ5?=
 =?us-ascii?Q?kVgEDl4PmJmQ+omBzOSfwtPog9DiBz+6PyEUK6B0bxwOM1ePODEEsMYYCgc4?=
 =?us-ascii?Q?64zWxMoisxb4fJiMVoZmhrt8I1kxz8dH4uxaRQEpUGPZTC0zHYIRUcLuUdje?=
 =?us-ascii?Q?80XtkcYJfHEtTrPNzgHExFsLxIi07oaBUa5AA003Eo0gOlLqLcBZ82ObdvZA?=
 =?us-ascii?Q?NKHCqef9jGRZK6bSD+e6zboBBY5DBF1XUk35jVtem4U3RRqArhxRSf6xXE92?=
 =?us-ascii?Q?U5QDl0TvcVDkiR+ZA0pPTEcyU8INhxaP4fNdahwyFLR6I5W43VVT+14CFS1o?=
 =?us-ascii?Q?5+4VyVbD41rlnD96IrPY46QI2NlHnmIqaovz88Jd/eL3f6/QJuVJDpVqOoA1?=
 =?us-ascii?Q?8zz7p7HloIAr58FfLfUqi7ZM0od+HHK0+Ln888UVTyLCEKdkHwHIRcWXfWy/?=
 =?us-ascii?Q?h4F5ooENi0RqAQb61PTg6KKwyhK597Skc9wnPUxboZtbqiKEFfqyVFk26KUa?=
 =?us-ascii?Q?U3Oo3QVbvtatt67tTfjx4WhE1rgTJARURnzccLA6b1bFt/TIs9ZC+o7Or6Bk?=
 =?us-ascii?Q?XFK8hKKjWcaEYmPAaYwKduCQ4hQri0KBgilmLhLJloIrNuwKYNYyiWbQRBpB?=
 =?us-ascii?Q?hhdUHdYhDq0NSxnEngmIRj0tgA5uNXeAr6dUfatjcC4XIDpxhDiam76nkZRn?=
 =?us-ascii?Q?VczNM5Uz7zDiuabznzlGNeOUPlFemmz6bMh3H2DTjHRgkjy6N4lzpNviabL8?=
 =?us-ascii?Q?xYyqYS6Plyvr23DQHfWg/syHQ4aPdgq7IFLIRZg6XcxS01Qcw5Xh+DmCKupp?=
 =?us-ascii?Q?alITTsGNZb2DXg0B+w88q/e05GBF9G3gtOM0FbEFkr7o3DnGGy1FBLHcQcxX?=
 =?us-ascii?Q?GWnP2zp3qYptfkyDsDNaUye1sE9uUmJ2FcAxtyHJSLZMSiUChWytIxVSEufK?=
 =?us-ascii?Q?3OZjo2AAbszctDsUJtnGD1MC5fw3phtTeQER281Ukm0tkm5BiM/f5gZtfLgX?=
 =?us-ascii?Q?zgCN39wzAwY8yCV8vuKtFhdIEwxtQudo/TqcX9wMtogrrl2kYZnnejUnAhOv?=
 =?us-ascii?Q?1BRBH3w0IaHFvtpGX5znNMEC4YTLNKPyxWsF9io1mVQngzDGDx2bCkWrmSFQ?=
 =?us-ascii?Q?VlJTjAl9HPc7Tv9injA8WcJADlf6qIw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997c243c-ed19-46e9-efed-08def952a8b1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:54.7254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAuOdTL3b8nm6An1UONPGmBrgvKRz+cg79YSJWXbsbgBk2gIGbQzxANK4AIAA1F2owjev0ggdALJavB0s1nkvOhSzd489i1+D4XY+dfqFOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7537
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

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object inside
npcm8xx_load_kernel().

Let the caller own the boot info: the board stores it in its
NPCM8xxMachine and passes it to npcm8xx_load_kernel(), which only
fills in the SoC specific values.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/npcm8xx.c         | 30 +++++++++++++++---------------
 hw/arm/npcm8xx_boards.c  |  3 ++-
 include/hw/arm/npcm8xx.h | 10 ++++++++--
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 9ce6ea52d9..136a5a7324 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -357,22 +357,22 @@ static const struct {
     },
 };
 
-static struct arm_boot_info npcm8xx_binfo = {
-    .loader_start           = NPCM8XX_LOADER_START,
-    .smp_loader_start       = NPCM8XX_SMP_LOADER_START,
-    .smp_bootreg_addr       = NPCM8XX_SMP_BOOTREG_ADDR,
-    .gic_cpu_if_addr        = NPCM8XX_GICC_BA,
-    .secure_boot            = false,
-    .board_id               = -1,
-    .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
-    .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
-};
-
-void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc)
+void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc,
+                         struct arm_boot_info *binfo)
 {
-    npcm8xx_binfo.ram_size = machine->ram_size;
-
-    arm_load_kernel(&soc->cpu[0], machine, &npcm8xx_binfo);
+    *binfo = (struct arm_boot_info) {
+        .loader_start           = NPCM8XX_LOADER_START,
+        .smp_loader_start       = NPCM8XX_SMP_LOADER_START,
+        .smp_bootreg_addr       = NPCM8XX_SMP_BOOTREG_ADDR,
+        .gic_cpu_if_addr        = NPCM8XX_GICC_BA,
+        .secure_boot            = false,
+        .board_id               = -1,
+        .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
+        .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
+        .ram_size               = machine->ram_size,
+    };
+
+    arm_load_kernel(&soc->cpu[0], machine, binfo);
 }
 
 static void npcm8xx_init_fuses(NPCM8xxState *s)
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 042a928857..01c22dbde1 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -198,7 +198,8 @@ static void npcm845_evb_init(MachineState *machine)
     npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm845_evb_i2c_init(soc);
     npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
-    npcm8xx_load_kernel(machine, soc);
+    npcm8xx_load_kernel(machine, soc,
+                           &NPCM8XX_MACHINE(machine)->bootinfo);
 }
 
 static void npcm8xx_set_soc_type(NPCM8xxMachineClass *nmc, const char *type)
diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index a8377db490..676c82150d 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -23,6 +23,7 @@
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/intc/arm_gic_common.h"
 #include "hw/mem/npcm7xx_mc.h"
+#include "hw/arm/boot.h"
 #include "hw/misc/npcm_clk.h"
 #include "hw/misc/npcm_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
@@ -62,6 +63,7 @@ struct NPCM8xxMachine {
      */
     SplitIRQ            fan_splitter[NPCM8XX_NR_PWM_MODULES *
                                      NPCM7XX_PWM_PER_MODULE];
+    struct arm_boot_info bootinfo;
 };
 
 
@@ -122,11 +124,15 @@ OBJECT_DECLARE_TYPE(NPCM8xxState, NPCM8xxClass, NPCM8XX)
  * npcm8xx_load_kernel - Loads memory with everything needed to boot
  * @machine - The machine containing the SoC to be booted.
  * @soc - The SoC containing the CPU to be booted.
+ * @binfo - Caller owned boot info structure to be filled in.
  *
  * This will set up the ARM boot info structure for the specific NPCM8xx
  * derivative and call arm_load_kernel() to set up loading of the kernel, etc.
- * into memory, if requested by the user.
+ * into memory, if requested by the user.  The boot info is owned by the
+ * caller because arm_load_kernel() keeps a pointer to it for the lifetime
+ * of the CPUs.
  */
-void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc);
+void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc,
+                         struct arm_boot_info *binfo);
 
 #endif /* NPCM8XX_H */
-- 
2.53.0


