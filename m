Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6B0CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN9I-0008Em-V5; Wed, 07 Oct 2026 04:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI7G-0001a9-OM; Tue, 06 Oct 2026 23:14:53 -0400
Received: from mail-japaneastazon11022111.outbound.protection.outlook.com
 ([52.101.126.111] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI6t-0001LI-Sh; Tue, 06 Oct 2026 23:14:33 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJotpMTgDYIUhZEtIC8/DdPgawS9xOyegt7msMHzUkgHhPkOWWXZUzSemRJPnz2b2AoXGdYPM/oygjBbHsiCMOA+w8gkfAHTTe2IIdufC3Px4tR5uvcKRk25EKz2x6G5ifpgOYIl4z7s5rONL7ntrsWUDYB3MdjrzLMKitDO2s5udT6+V6MLbZa32X1RGz/N0y8ZJ9+b8qaH61hXdHCnwKleie8Df9gYnom9vQo4WckUYsQl7qCQ9vPdzOuhWzZZbm+70Wkzh3gdgb/zbXMBS+TVPV3iiBPjU2BH17KfAouyAbwXWPTPsUD34nnBDMuWwYHl45s1WYneOHP7AI0B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah3poEIpc2yD/vwq3FqKTbiFaDCUNxc30HYKPV518nE=;
 b=YBvgnn3ujWNXqKKiquSLLRcILhZezQ5+BtHv1VHwxuKTZNEPmPgmiY843oWEDOOxBQcF41JupkT3cqu/37FJsUBLaAF5I9BYR4NoxNGDxEbKQPjC2Y3qUoskMyQF8k0VMkfEjUg6IKH4sFk9ILXRkU+sqaKBX+iosBPYZiNXjwvQSdNOyVwEkhM/Px8WGqxr5rOfUJSPRyuBoL7kc9NaihkXWKdDjdhi/Lmx1qyMo2/h5TXLUaz2NGxTrmZ1xk/Onq9NCdV3LYjdUv6wDGO9EmEjn5fUZf1W1uPTLWOFff9EwNfMLBvMKJx8b2E5o3mBASpNsrLRmR3YXJStFhcsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah3poEIpc2yD/vwq3FqKTbiFaDCUNxc30HYKPV518nE=;
 b=g37p0PuT6gic9pU9uKFCDZ7axvkMH+nKkqFcm3BbZkb82Ikalw4KG9ydjHAcey1eI+TnW3OMb40mFN+SuolMUjio79GGumqPxRjoQ6s/cI1mz3wuznuLy0cSKbyEh3ufOZVT0sjpB6zYUDtLhKdtDop3zRvkk+vZE3M7pZ3MS8v9hkjg8MXPxYvd6C5KaNUS3MySMlrwoxVy5T4of9HxMv5LtcZ98LE9GwvWTPYjRIgGPNgnJTAhZxAQKI2MB4T8ckyQBWTNUegzlBeAFJsWxBPhrvZWxWUEkatqLe8puT7KkEBEUUmsLGkeWaEKMVD+P9IkJdqFD+FBoyZqr558+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:44 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:44 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 14/17] target/ppc: Ignore FPSCR W/L fields on e500mc,
 e5500 and e6500
Date: Tue,  6 Oct 2026 17:49:09 +0800
Message-ID: <20261006094921.110871-15-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e65fdb5-b0ee-4818-baf6-08df238f4a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: kAhNJYltLDegI3t2P1MienqFvjhKuNTGMssOQ19WBxW3WzKi9BpfF8SDAkqVKgq91JeQLYRei89SyJVqxacVOZDM5d2Kue58QorFc5qgjq2J/SEW67jf4xAdaYgBUwAu/J+dgcFEmLEuFAb+K/cbAfAQxPEKPW00JMZpqk8kL3YLzlafgdWNUmnJZjEarHY1KsFNCQN/kepJli58pk3bfDGqoUl/UBwMVJUs9xxrS9OtSOd7uzTIuG5dQKzTXg+bD2nupN4Xl7svJ3NxkIfRI4u3tibPLU2qsj4QrG+gn8GyDS6PtFFCQTv2J7lln1wfW4K6ibcyqpB2iLCTCUd/VXk+kvi7JdlpqgzYVWuw3YF3yY/lp26yGWqywgg8dKrNJxuX24qH+sUXSb8+r7/EymJ5IZjVA/7emC/ylZRH03nQ2OqiYZ7xJa91v4Qhqtwub8hDGWd13xAAiUpo4NwM6tPrhrEaeWxKaSPrBv8V21ZRT8/zJXB/KDewem/mOTipHG+NnlDr/ONLqz3rY3Tu31fnZHZQn5J/9APpQvXjRpvGw6DRUMg9VyK4xSmGhhUMwID4FghFLUJ8VCEN5qYFkTKRyAY7kwvKCfpV/dSsADMdqzIMlJeuyb3iXj1cklF8Oe4RnKbLT2PE2UtUDxwpJhp1NnPmjlJW+F1OrT0+NsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MwkY21SKMpGaIk5ZpAKbfy3V+Tm2tfdpLaU0v1tGkOVW2WfgA9AeSQjZuX/?=
 =?us-ascii?Q?37MQzIMz2wwn7e5aH9yY83P3eJi6JN0XqiX21pHwN8QFUSK494QRepw6POdM?=
 =?us-ascii?Q?KU3yWuzUZkW3edt9RMvIf6XONZ61o3y3nzYTNBNWvdMn0Zp3rxaWZQ6pWnG4?=
 =?us-ascii?Q?WH+ykJoL0Zx9QdgZ1zXfkv0HqmTLYfSvMcbrmDuaTi0hSp67Joe2G00XKtpD?=
 =?us-ascii?Q?YiyEC+jPx4TiX4UQWlDuxVhSjVQjQSCpdRmffi/CyBflUTWTGZBsC9mRDNxg?=
 =?us-ascii?Q?+4f2ggIFhRSihZZR9aQx5UO/UNPrMUuS8CHsBOdQhgK+wm1XZ5M226x9tnJm?=
 =?us-ascii?Q?pMj/TALZS3N4XD8UWunaaBQOEakrqCRhRB7EL3prz0udR4TbGui0eas3ooe9?=
 =?us-ascii?Q?6AtuXL4+bnyFNmJ0+MHCmIJc+qDfyLMJuaWRGceIYrzbFin6XHIs2l6Sgeo5?=
 =?us-ascii?Q?abBWHGaH5t/07htELoP+EwZAiMcHnGcClJkGDFO54Q0Vp1dlcPx9903UJic6?=
 =?us-ascii?Q?j2WBu6Mm6vV3yzLN+BO7L9l5W1toSUhygzpeOOkk3BbkJmrsVAGahohxDlWm?=
 =?us-ascii?Q?ykmHOR1+QQSRieYVblWZ1yDp0fBD/08jWW8O7YrF3U2vXTA8JiY6UJIGB8Yu?=
 =?us-ascii?Q?p7/AtC0t7fHwx3wFu3ccN74OUw+4PPTCSdRCYeu+jh56003ygAhW0QluIfVS?=
 =?us-ascii?Q?Jp3gkwnP/KUEPV42P/fbxjEVJ3gc3Wf//apLI4dle9gIZqnMxwsUfYnWSddK?=
 =?us-ascii?Q?2RpOr3NwIzEnBWvm87MakiFe6mUVPUsXCOQX7ypihZtNQkpTRMv/EkyxkBSZ?=
 =?us-ascii?Q?a3ggl9fREjKaH9lLB09bzXbumIVM/DeUMPujPPZRajjzATbZsbLN24MVOtNL?=
 =?us-ascii?Q?K5ZXux2DWRgGQMqLtNuvCIT7htU+iMow8J3XadkdWNfXd6ka7/0k2+9eki9a?=
 =?us-ascii?Q?vHMDdwx4dLqFeIdqNwW8rrwQD2hH6x70D4Vgd2jpnbWCxJ2mvJl91gxQLeeR?=
 =?us-ascii?Q?WS7GTnzO2MUKgMM7RANsXyVjZQ55kIVXHEAy9o1xIncBpD/00J35sSUGDe4J?=
 =?us-ascii?Q?v8sZROmJndcdjpJLYoxG3Xi1jOLjaDQuFPERvzE2SKAhAYLAlXl9N92Y/f15?=
 =?us-ascii?Q?/LA24BllloRZi96GhRa5aQQvR5urgJ5qOF8pYKI1rJvsw0bNcDatNWPuNCr1?=
 =?us-ascii?Q?4DmPLT5Uo7gEfy2G0MPfLowvc7PBxRwZnF4Ocps1dGnAsJcmyrH5iWzVMOCR?=
 =?us-ascii?Q?aJRK/4QD6Ngn4np0oKzBB0JY8t7OBtjdXb9IzxZQ1yHJ1sHzr00rq8iFxytA?=
 =?us-ascii?Q?uCNd2tPGN6JfenTv5ru7NmSw0DhDes4saqDCcMiAhagZBqrIkHqmucpquGey?=
 =?us-ascii?Q?1NZZAj+hZ9uj1UmE0zWD/wK+7upMPKxpvHMTGFdBEDp0L67jsYOD1Lnx9rAL?=
 =?us-ascii?Q?QXsDcSEYMVzsrEuAg+lmZi34Co/BgrRsAFuy+o/hSfnhwblZBDDsS6dBr/9U?=
 =?us-ascii?Q?fKMKfT4tm92yDMG/5KUhNCFwRqe/ypBLIMQmAxyaL8tvYFo38D89qY2TfpjA?=
 =?us-ascii?Q?hUYdxgheUed3udn/IlnlA7+PWQrXHTekSqlHJlRCZrowQQdLt5R5oSZw/1Zz?=
 =?us-ascii?Q?urImDM2sFms1TafM7VXMyDraZZ2n0JCmaPPSElr/2oG0GMHVmjLCWTB8gCoa?=
 =?us-ascii?Q?maQK5p4IO8Wm6S4NE5a/Ot+FT22Gbs2JlOsdeaZFpuVI4ji4NWfadiQLG+Sr?=
 =?us-ascii?Q?ERHKyR5AkfFFrWuG6cw535eJBCewV1A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e65fdb5-b0ee-4818-baf6-08df238f4a2b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:44.3653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMsmvc4yLM6PEjRT2pKghM3njB1chwF2+plcHGZa4/BstiwGz9qVIqe6DRgvpV8AZYawfjQxAJGT4RKp2KWiWSBT4Xwwc5bq8Q5v17Qjw88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=52.101.126.111;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Table 3-1 of the e500mc, e5500 and e6500 reference manuals specifies
that mtfsfi ignores W and mtfsf ignores W and L, behaving as if these
fields were zero. The existing translation rejects W=1 without
extended FPSCR support and honors L=1, which does not match these
cores.

Add a processor behavior flag to ignore these fields without
advertising extended FPSCR support. Keep the ordinary field mask
and rounding-mode updates effective.

Reference:
- E500MCRM (Rev.3), section 3.1.1
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 3.1.1
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 3.1.1
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu.h                   | 2 ++
 target/ppc/cpu_init.c              | 9 ++++++---
 target/ppc/translate/fp-impl.c.inc | 6 ++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 78fa4653fb..edcb2ac5c7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -844,6 +844,8 @@ enum {
     POWERPC_FLAG_BHRB      = 0x01000000,
     /* Use PPE42-specific behavior                                           */
     POWERPC_FLAG_PPE42     = 0x02000000,
+    /* Treat FPSCR instruction W and L fields as zero */
+    POWERPC_FLAG_FPSCR_IGNORE_WL = 0x04000000,
 };
 
 /*
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1c02354e11..f38a67208d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -3188,7 +3188,8 @@ POWERPC_FAMILY(e500mc)(ObjectClass *oc, const void *data)
     /* FIXME: figure out the correct flag for e500mc */
     pcc->bfd_mach = bfd_mach_ppc_e500;
     pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
-                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
+                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK |
+                 POWERPC_FLAG_FPSCR_IGNORE_WL;
 }
 
 #ifdef TARGET_PPC64
@@ -3238,7 +3239,8 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, const void *data)
     /* FIXME: figure out the correct flag for e5500 */
     pcc->bfd_mach = bfd_mach_ppc_e500;
     pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
-                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
+                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK |
+                 POWERPC_FLAG_FPSCR_IGNORE_WL;
 }
 
 static void init_proc_e6500(CPUPPCState *env)
@@ -3288,7 +3290,8 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, const void *data)
     pcc->bus_model = PPC_FLAGS_INPUT_BookE;
     pcc->bfd_mach = bfd_mach_ppc_e500;
     pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
-                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_VRE;
+                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_VRE |
+                 POWERPC_FLAG_FPSCR_IGNORE_WL;
 }
 
 #endif
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index fef770368a..9937b2db50 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -592,6 +592,9 @@ static void gen_mtfsf(DisasContext *ctx)
     flm = FPFLM(ctx->opcode);
     l = FPL(ctx->opcode);
     w = FPW(ctx->opcode);
+    if (ctx->flags & POWERPC_FLAG_FPSCR_IGNORE_WL) {
+        l = w = 0;
+    }
     if (unlikely(w & !(ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
@@ -627,6 +630,9 @@ static void gen_mtfsfi(DisasContext *ctx)
     }
     w = FPW(ctx->opcode);
     bf = FPBF(ctx->opcode);
+    if (ctx->flags & POWERPC_FLAG_FPSCR_IGNORE_WL) {
+        w = 0;
+    }
     if (unlikely(w & !(ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
-- 
2.53.0


