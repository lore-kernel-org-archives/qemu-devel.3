Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47B9C5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvai7-0001b1-Ay; Sun, 16 Aug 2026 09:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaht-0001V0-Pw; Sun, 16 Aug 2026 09:15:22 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahs-0005TH-5s; Sun, 16 Aug 2026 09:15:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEQ/YutSbdwSiA62c72mkw4RioHAcRbyRiC6/feUzcmtGYvarSiUvFfgdqv3Dpb49kLxr270+KyO412MciRDFwt43UqlxLtpeLwQVzxAoOVE0+lEg4+6eQOtfG5Qv0rxFuvIlMyGWaUCa0rY8DEcdy81W3MPlddkDi6V/KcWRpVfdET4+LnHit817fnQ/zzcSzwstG2WpXxLWotb5roZIRI0sUtnYi8g1xAhsR8tbA71izyn0kBJ/66IocW+Ar4+d0moDLL45lrwuJ7HCK4BO+0yCbN57IE4az/dcnMWECaKFLaI2l5buDBa9lsPzuJ8DKwUI/KtWfNpgcsvkvpN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmlEv9nl1xY0eIcRl4LqtEwxfCVmFK4/Oq+FFSCYM2o=;
 b=IRFhl2pGTUAvdzG0WX5P3JOrxNG4wzoVIcOGTgdGDRCPc+zIeApGu0I82mOKOq7HIYBC8SlNJq9VETCA1oNtk4U6hB/aDRRGdYLh7uxjN055QtGV63l/J3d+Q+8ayQLt4uHT1fq6H/nQeKLKPwuqaWFeocV3Krik2tc+mLd9skChmy1VyWUSMWeJGZCrHU0o2CGaUENiK0ZiJ4uGzQp5oNNLtlqGNo292CfgLds4EiEMGAXMOgnwsQ6vZLJG9nqZdTFbYJrlS0OYRdc8eQ/z01/yhAiuxrB8HJqjinTnPgJLoEyhrgBDWUC3cJsfqUxkOwODXkwaqot8V2m2eU6Jqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmlEv9nl1xY0eIcRl4LqtEwxfCVmFK4/Oq+FFSCYM2o=;
 b=FAxZi8aUFwCq7OZiD+ywf08ev8zDIWERSJlxDSDOblewoALs8O1BFsM8a/7px8jo6cdtvACBAr6xmp4pFpr73rsiSJ5MydMInFJvw/z+mR7XisN+MDdy0n8b8MUN+8uy8wMdX4ZqX1q6WoBvsfCmmWLBl0Pb9quiiHSSLTgrSIdV1Q05qfDpi7pAMo8oPOkMSBCChQOvT1QuqeqLlvt2FxAfofxsJx4RHv6RqFYKozbM68laCSEV3QvsnF55JubRbCYMmQ7h21LgSpL9yPEBrD2x9bGL+QHI9EF8UB7N5w7N78BUD5saJKpnfG8K51kfPGrxpIywrqPGaRXBfVQ50A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:11 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:11 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 02/20] hw/arm: aspeed_ast27x0-fc: Store boot info in the
 machine state
Date: Sun, 16 Aug 2026 21:12:32 +0800
Message-ID: <20260816131300.51799-3-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52a06fc7-75ed-4a2e-11ab-08defb98671b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2QEbw5iWp9W3+M8r2uBgcpC8iDvNeVh7pcDKh4J0gFTIIcrOz0ZXPA5CXJ+Q/FxUdATHk5pAoJK7nOQ7dVAwZCdz4HIHE8uFpGp8+BWUYP7+SfDBPXl2Md0savbssLpYXw9ZbUPkzqUXLQ7D1R7KUFwGpOufIK0ujUklTbkdrGlIQFC228AuX5/Jqsh9TnhPiTPVaJpb2yJQ++J0DQAj2rBFvXAlDWGiMaXcb3+sAx3hqyWPNaBIF8RxXnP/bt4bbljiTt2SlZdlikOrLj1FRO9pkU12zZmEVzeFBvBNtsjry5R8bD4dbl5Dyng3KHIQGTHSNQO3z1Zg57aSprS4tLEOpvyOLkazHDcz7auJtA06GBjWLcUzdEivEe5U7YGXVDzfXjaSPFjn7Q/yaP5G+ElojqkbbNdp/YclmZBq4mvcqsw2bvhziXBOIL5TKBPmhcAbzJnioaDYWB0IOHA8ajxuFHJEH/3m2kch8m42WoKJCQuppR2LQkU3cAXKdoFPow4aYTIKQ0Rtc/FUIkY7N0GyjbunWyBH93EmbfN2fd8GROEIiXQNZB3p0Sh4IcHcbiGIKC//zV0dDDHoUFt9JZ+PGgR6wwmg3zM8L8pRriLdSP2iYkBxSCEmYYliKPNHQeQIoohFhoh+iw3i5UgfdVnRU+JAMan7z73NtaUxiuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zNtP3JMU8Io38oEM2iw3rKz1yseXIas7RTpmP/uGHXgB+xOJyMkLBvDydcXh?=
 =?us-ascii?Q?6Yq9+31zVGeufzwC7oQAQCpCmM5qrnouC/asTHfxc97huz/DquMKaHlf2/zi?=
 =?us-ascii?Q?fs4I6vkBStAwf5iG2k9XOu7cSIMaKzMOhmqujjJGXRGHlNnxxUa2mP4UVpKj?=
 =?us-ascii?Q?JlYgEDGiyWEROjMZKmO8FuHJ/x79fYoy/WsQX8+O+lVTF+d4Gwvh7aYv2PYf?=
 =?us-ascii?Q?7tSCjHuvOSqYDHGPrlUsKuW32PLEBgX4FVQ9/i8JleTC+Ls+p37hP+aRohGU?=
 =?us-ascii?Q?dwylSGIwhbkMeAWupVLeyTBkXnDkFVRO76QS1fgdgt2Kf3jh28CCE8t1O3Ur?=
 =?us-ascii?Q?biU2HaGxNaa1ejUvbXVA8g+JemD9Ei6XfvCH23mbBhxzqDBl5KfwhC3T80qy?=
 =?us-ascii?Q?YNBzcb/X6OyRjP+6GIp99oQsYqiV8CQQsKPOb/i/6V2dI7vjC6iMnglFecn4?=
 =?us-ascii?Q?jsfi9S4j0ODzYq4K9GeUNLO/xpx1hKQ+OJCsdWEAn0tRkWRAljQfew0536Ft?=
 =?us-ascii?Q?gaxIVSPRuzqY10HKwqzLOt4kOsd643p4fLFC5OlVzWT+53h75GDQaiJO1UAf?=
 =?us-ascii?Q?0Le78AjLnE6oPxfU6JHSNbNAzgvHOubAIxLFQmGQpIMGJaKgWGtSM54qdWly?=
 =?us-ascii?Q?FalRrSFPFzWjelYJX7xSDUY9RQOclBin+Wp8Z4vEmSNY9g3kFHPTJj+BcONh?=
 =?us-ascii?Q?/2vajrGkVLxdewGZXeySNEU1jFrApD7p+GMDIAyMLmrJE6RkVyU560ipvzC5?=
 =?us-ascii?Q?5TUExgKRMsl/B7PaFyPPyt+5/NMsCjJMHDZ+xwr/+/PuV9mNBJWtHAEDm5wa?=
 =?us-ascii?Q?ZNC0phw5MJyKgwn2RaKrkTOtq3wMh6CC0ydjuc8OMMdrByyfcFO8n1/8EhNg?=
 =?us-ascii?Q?3rSNikLMSaQtSI9XRi+m0ANByt/e6MQrqxz3lQQGLwzCdT2vgXMoQOlEPaq1?=
 =?us-ascii?Q?uTukeO0pk9fSIZ2pQuoaE2D7WAEWTj2bdyKaoWZinjbMJr3ncD6Q//siLhWz?=
 =?us-ascii?Q?1qvdyAEPwsELQOwO+m6lcma/7NMdYDAQUBrlaFdNcYwvkFzbZxNYI2SMjZSm?=
 =?us-ascii?Q?DJSI5CsHgBY87LJhhMPeVUBCXFetaotcoRrx6sDIU1LfGiDPaQeRqudfcnoj?=
 =?us-ascii?Q?SiZsv9GJQQDfmz0e7dMbYFfEtC37j5zyYZKhvsBKTFlBSv0V27Ba0U+3ZZSq?=
 =?us-ascii?Q?0wi2vzxAcTOAz+eO9ZTnquQ5Bgq2msPWHAqreABDsQMVSyrmTfivHHPC03sf?=
 =?us-ascii?Q?wPyyPtDLgkZou0+fbYZxWiBlnUxMitj0TC9nFiRYn70q71CnqRIoQIT2lh8h?=
 =?us-ascii?Q?8KwNGnDChoIEFbMfxKtZk7SWl/rWMdqbp4BhHpCQueHDWCohmx3gvTd4Rrad?=
 =?us-ascii?Q?Tt2kVCH9SL6E59zKsDNC/tQlvCihs63f8F2MEY2OTRkO3ywLOGR01xz+lLBD?=
 =?us-ascii?Q?eud/mD9rn8QtRau9p4dVo2Ey1kmriuJ/Dsqp+LraYPhLG2ZhNKlNr8m5I6VU?=
 =?us-ascii?Q?l1xsF/92tl6GExnvJvoaLD0YzCHBxvzMLHQY6EtAxAMzyCVzY10o5V5lR8Q3?=
 =?us-ascii?Q?AsNjXD2VBLtnk6j3RkY3GyBO8JTriGuM7lknuAH0vObGdZsmV/tXeQYTzXx0?=
 =?us-ascii?Q?IpDzdQJ1tHw5UiuwqP814ZBd/oeUojdF0LduAgQIVB4ZPmoZevHj2gvcPjpS?=
 =?us-ascii?Q?AOdj50AApWhTHBNSF35bFpTkujXyXFjMQ/ftqxAjK3b5xoo/ZsKcp8H/aXHQ?=
 =?us-ascii?Q?ImOmGEHBQpCPlVgpGgSo5Ocv2/5/ig4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a06fc7-75ed-4a2e-11ab-08defb98671b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:11.7233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAqBe7x8FzhjDxRAn+VBN/liTLv38+eHFI3VrYW92JXLg9TNLN++jpZluX8FzwDINPF/sdo/1Hjg5ga5vvQkwPnaYvNlfI8zwdvGUEPsJ0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
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
rather than to a file scoped static object.

Move the boot info into the existing Ast2700FCState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/aspeed_ast27x0-fc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 058cea42ed..ceeae336df 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -27,10 +27,6 @@
 #define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
 
-static struct arm_boot_info ast2700fc_board_info = {
-    .board_id = -1, /* device-tree-only board */
-};
-
 struct Ast2700FCState {
     MachineState parent_obj;
 
@@ -46,6 +42,8 @@ struct Ast2700FCState {
     Aspeed27x0SoCState ca35;
     Aspeed27x0CoprocessorState ssp;
     Aspeed27x0CoprocessorState tsp;
+
+    struct arm_boot_info bootinfo;
 };
 
 #define AST2700FC_BMC_RAM_SIZE (2 * GiB)
@@ -114,8 +112,9 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
     aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
 
-    ast2700fc_board_info.ram_size = machine->ram_size;
-    ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+    s->bootinfo.ram_size = machine->ram_size;
+    s->bootinfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+    s->bootinfo.board_id = -1; /* device-tree-only board */
 
     dev = ssi_get_cs(soc->fmc.spi, 0);
     fmc0 = dev ? m25p80_get_blk(dev) : NULL;
@@ -129,7 +128,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     bios_name = machine->firmware ?: VBOOTROM_FILE_NAME;
     aspeed_load_vbootrom(soc, bios_name, errp);
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &s->bootinfo);
 
     return true;
 }
-- 
2.53.0


