Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5B7CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN9u-00013J-RE; Wed, 07 Oct 2026 04:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI6G-0001Tf-IQ; Tue, 06 Oct 2026 23:14:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI62-0000uV-6F; Tue, 06 Oct 2026 23:13:41 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXkxd2BnbwpQDEaqG+WwM16SZBUY5dPcNB/BcR33+rUrHKIVFMshp8eqH2EcshgL9uAsxlGGthSbAlle+PuH35XFilTzW1JkOtoXbFlyJSlwuMmXjUjhCDP2FIYQ3QPTUg6KyR16TgNvPoycGMGJeACUZG1SnQvLBRnhFeML7n0uXLV+lbtZK179P8szD6Xidw2j3k9m4rDMkALLAAMPU0ygX+54cN7OEgDnfWMvU/togHCasg8aTk8A4EsTjtpzlSZ/3Jmx160frFvbXsxyBeUyhNDV0OUrxLjF6jks/LjIxqvHe6bL1Bb2QF47HLsL0kVSM6q4EhOmq22VxWPa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLlKr4lKAg92QjBB+UP/4YXjTOka20b78DQt0uFW/Uc=;
 b=ahkkyDk/MB+M8vsjz8Zf7wMOPgsBD/qzFcrPhbTQ16wbmBxtNbqW1PYwqeTUMMXfKQJkkKxfa/JOU0Z3sWSg9eDcWLutBZ6DjO1NhrptPLOm+AIUOZkzHFlywFeCQqEbjmTVYeDgswvl1kEpeEbNMK7/zaE/S3cBN0zRnIHpsf9iIoI5SQN8sYrJGkfIgn9M9WDOzFJGXxzZq9qzhTuHFffp/dyV5s6CNylPbLTmtCE9Hr17W06IeR1svZLyl/MFiZdihrwpNMjxRsD/I/bl36yosSUey0HH0XXvKKFWDitxcDZ72s6gvYRoTutxpO6DNzZR27HVwFrN1fCwyL4T4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLlKr4lKAg92QjBB+UP/4YXjTOka20b78DQt0uFW/Uc=;
 b=V/0iizIBJhaBhngKNWlZtqkaET5575PlMXMaW61TyV3aI0rb82/JutaYcKSmTn594j8TQNkUgKe3VFELZTWVOiujWiE2f3nKTWz4AjiJXImxz0w5sMQQfNTzcspIhumpnW0Tt7wrVnflfboXbOyj6d2cS66ASate4rlPhzJs7cJVVq5N0E7MxJdh2P5F1K8EroBPn41SsJ6fkpacNjyUx2hli1oHmsQtUan5MXTVX2juZsNi8AooRvKCj3zwhsrEoiMQSS3q0F8zM19tpZF6duvgUOVdSJBGjsoLnzUXDkBIiZbaxixIrroRDMSp0gcqKfmUxUbdDEyzCWAPXKdwKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:38 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:38 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 12/17] target/ppc: Split the ISA 2.05 instruction feature group
Date: Tue,  6 Oct 2026 17:49:07 +0800
Message-ID: <20261006094921.110871-13-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: d34e0233-9957-4d94-ee28-08df238f46ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|6133799003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: emLaAxq99+K+yrEYthRKPpyMp2iGcw/+7oREPOA6JiwYLnOHBh2qzjKqLinT1mV3qrIyZJONdiovvklcin/GpsJs+XCIivDw73LGWBFGXKBCVorFjui2BRiyQ9oGLq6Sm56PnggoHB3sW2tMcPTk9p0aeB73sKe0wP/dLJPdWszD3YZiLSmongIp9ryGEF/LCuHyGXstuzzVDcKElNtHrQ8KcHzKs8WbBC3xPehxLLsDzlfkfv5YaWWLUoblk28U6+fOPbaa7Q7Z/ASNxQwtkn99nJ3YKTCWZhTxYxYpMmxx8AlrmVQhKjVmp/HPgEeYgIRRKfpq8K8u3aqELCy9UbVvTxfhr61smIj/Fu3lOXHRS6K52khThlYoqcNWMmyK3Wm/V/QuqHSbGV/LCMqNGFtCwK7wYr01gOkMzing0YIzAxDvbktiemUXKQksBpAXQMGVvE2gHscYB/eULUpZPUE2pexSzZMzrTyD5qJQRfWqZRBt/Z3s8vcrqJojz4Euo38nY3RUG7lB4Srgfmo8QBL+3vdx9dy0FKjJJ1e5KoArZpmJ3XFDxAR4JVlaBbT/AIY0LuezYBk0YB3/RlEkhxAb0xiR4ADH+WEy9o4QndW8XBa/X3nlyP4RkGy4l5NQ7RTHLHbuklz+GdibLVvLmnRmQgOqsq5DqsLECMJVUXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4yeKUzsIbFpAJiGuJ+g6Vo7ElwaJJO7L2Y9CZp7goVJ2V2ElwftmxNyWYrbC?=
 =?us-ascii?Q?WB1Whjsys48ALUcjRdxTdBAhqE2wKieYuV3rTYc2XHEcHfDcAC1PjcI0WEHB?=
 =?us-ascii?Q?yuVAfQ8iBTXdJAtpGjOQv+tG+5M5eyuxj88G37UaAVUlE4Dd5ItS4fJatca2?=
 =?us-ascii?Q?qtKHna8gCmd8PC3Z6R8c9xEcmeiL8MD4JBmkmd8lucHCGBPIhCSBK4/Ey9RK?=
 =?us-ascii?Q?eHNxEMhFLaVBBjexJshSqiRirXuozTDeSwEWUM95WFsjAbQ++IkF5jc5bhw+?=
 =?us-ascii?Q?wKIeXDk5N59uIRjvpAwitQpVc5EOaF6hMsRMOjs2ZD17UN1vwObcA7x7mMou?=
 =?us-ascii?Q?btoCOcGeZBCJakK2zf+d4VrU25Dk1R3eqHhzYaqqfEKphRoCOGPFk2tGP0U5?=
 =?us-ascii?Q?MziU5JWrbnD9nhUqbFwhEZDHbIx0/Ogl9sgJ79DJB60vXqmhTm8+Zwy9i5a+?=
 =?us-ascii?Q?dItd73TyzM1eLgTv0lBAFed9DuuPTQ3C9+nUSf5nGW7GRQaMQP8QidtZQifj?=
 =?us-ascii?Q?91VrUZ7WyzLsexgcp2gjuKf73BgmIZU8jjt4NhF+5KAziT/oWQ12W9f2ciNq?=
 =?us-ascii?Q?DuRJNMLqnQKgY46j/ilpxtBQoqXvRXKlE6J1UL8PR+LNplseXwD9LDgiHwK2?=
 =?us-ascii?Q?U9dV9ZIce/y4XTbsjOkIF4fcKx+oI5T8dv5bY98Fl/rR0+kLaSf6+WqxYCrI?=
 =?us-ascii?Q?HJFGWHU8wf9fNPWaXtdl3TY6ZBcvNwuY3S8Oo3k8EFSIKBV7YVDO/1/dwnc4?=
 =?us-ascii?Q?tXszskNBD+W4DsBRJA0yjgtU4I1lYCkiWTaezKV5VjZsU++xTXBsHemNC1yx?=
 =?us-ascii?Q?1S2lwLfv8fRyxAnkdUkRgep4AgR518YfYzqLz30jS9iT98UydQo2TXqcvts5?=
 =?us-ascii?Q?6lbLkYWK0fXFV2A3GJ6bpyQ9syzV5t482G8qMlOH79ONNXdMBaOuJBpeRYuG?=
 =?us-ascii?Q?ADKrTRsPLIojuTPecn1Ly0/3FErQqi09oXalC6iEX4i6boPSm/kKKI/35sCS?=
 =?us-ascii?Q?Fe0iccLIex6E8MT+VmXboo9kmqhrCQxSJW8DjbYrjgk9D+rp6HkehfJ39Gxq?=
 =?us-ascii?Q?VbdH8IGH3DuoYDrcUg5w2QV/u/r/9ht7CkMlVdiNmA6en7+vqgagYJJRZ23S?=
 =?us-ascii?Q?ZpulpE5xk7bQuINeQ9y3ezCF6AElDBLl1ZBp2auIkTV719+3kk6qrk/oiknz?=
 =?us-ascii?Q?UAjmumGdllnFhY9aWe9fJAjd19ujRkSdk7HQoBn/dGFR2pDkveph+PjRT0H1?=
 =?us-ascii?Q?zi/5+QR91TSDyNg9hWNQMQGHjbEhcakoB4g20Bg7pmoijvIDung/JKOSb/Xz?=
 =?us-ascii?Q?eurz9Zfbf6XXBJLMJyPG+7aN0gXI1uybnXAISrkY04/BKSgd4qAULww41lvw?=
 =?us-ascii?Q?C2ERVIdfrv5XcK+VHQlyboV6H0iY0COnbUGJrgY5tLJcRlCPUmHjPjAl7plt?=
 =?us-ascii?Q?mTBNoej2ZE178We3j5tuwIqt6lQUfFDtZj70FeIx+oupuYfPxhUOTZRZfX7t?=
 =?us-ascii?Q?5gyJF5VWoMs5FnAqKjZ7Et9FBI+b1Te1rT5D+1MwEaXKHdpSUZausDlHuFGU?=
 =?us-ascii?Q?y2/CtiHiNCv/dWGYa4DGwITXnWubQIohlGvbNAK/fE1Lp7KGCgZp57e6CwzU?=
 =?us-ascii?Q?WqX5x91CpJWdTANJSauZ1/YTa3YcE0u78/qud4XEG9h2C+tXHoLzap6uIjOP?=
 =?us-ascii?Q?wxxRie7h54AyVHE+bwSuZFpaOa9dRSYpiFgO1yEZ/QOXj59Elm0ByLYNoMOj?=
 =?us-ascii?Q?sQZD1jWbktRq1l96U3ZD9muFf2pJogU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d34e0233-9957-4d94-ee28-08df238f46ce
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:38.6596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VffU77MihN5uXG/+hUD2grOHGEi02X/R0cly31uDMPTZtJqcSp6BKvB+uNnpxJZYuYXWcrKjipsO6QgUAmLWQDQNQBjPfulDsndpZSX3IWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
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

The ISA 2.05 flag couples integer instructions to floating-point
instructions and extended FPSCR access. The e5500 and e6500 implement
cmpb and parity instructions but lack these floating-point features,
so enabling the entire group cannot describe their hardware.

Give byte comparison, parity, copy sign, integer word loads, paired
floating-point transfers and extended FPSCR access separate flags.
Keep the existing capabilities of POWER7 and later models, and include
all new flags in the TCG supported instruction mask.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu.h                           | 20 ++++++++++++++++----
 target/ppc/cpu_init.h                      |  5 ++++-
 target/ppc/cpu_init.c                      | 10 ++++++++--
 target/ppc/translate.c                     | 10 ++++++----
 target/ppc/translate/fixedpoint-impl.c.inc |  6 +++---
 target/ppc/translate/fp-impl.c.inc         |  8 ++++----
 target/ppc/translate/fp-ops.c.inc          |  9 ++++++---
 7 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b716ccf540..78fa4653fb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2568,8 +2568,8 @@ enum {
     PPC2_PRCNTL        = 0x0000000000000008ULL,
     /* Byte-reversed, indexed, double-word load and store                    */
     PPC2_DBRX          = 0x0000000000000010ULL,
-    /* Book I 2.05 PowerPC specification                                     */
-    PPC2_ISA205        = 0x0000000000000020ULL,
+    /* ISA 2.05 cmpb */
+    PPC2_CMPB_ISA205   = 0x0000000000000020ULL,
     /* POWER ISA 2.07                                                        */
     PPC2_ISA207        = 0x0000000000000040ULL,
     /* ISA 2.06B bpermd                                                      */
@@ -2602,15 +2602,27 @@ enum {
     PPC2_PPE42X        = 0x0000000000100000ULL,
     /* PPE42XM instructions                                                  */
     PPC2_PPE42XM       = 0x0000000000200000ULL,
+    /* ISA 2.05 prtyw and prtyd */
+    PPC2_PRTY_ISA205   = 0x0000000000800000ULL,
+    /* ISA 2.05 fcpsgn */
+    PPC2_FCPSGN_ISA205 = 0x0000000001000000ULL,
+    /* ISA 2.05 lfiwax */
+    PPC2_LFIWAX_ISA205 = 0x0000000002000000ULL,
+    /* ISA 2.05 floating-point pair loads and stores */
+    PPC2_FP_PAIR_ISA205 = 0x0000000004000000ULL,
+    /* ISA 2.05 FPSCR access through the W and L fields */
+    PPC2_FPSCR_EXT_ISA205 = 0x0000000008000000ULL,
 
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
-                        PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
+                        PPC2_CMPB_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
                         PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
                         PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
                         PPC2_BCDA_ISA206 | PPC2_PPE42 | PPC2_PPE42X | \
-                        PPC2_PPE42XM)
+                        PPC2_PPE42XM | PPC2_PRTY_ISA205 | \
+                        PPC2_FCPSGN_ISA205 | PPC2_LFIWAX_ISA205 | \
+                        PPC2_FP_PAIR_ISA205 | PPC2_FPSCR_EXT_ISA205)
 };
 
 /*****************************************************************************/
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
index 4ba559d8af..e70f1baa74 100644
--- a/target/ppc/cpu_init.h
+++ b/target/ppc/cpu_init.h
@@ -17,7 +17,10 @@
 #define PPC_INSNS_FLAGS2_POWER_COMMON                                \
     (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
      PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
-     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_ISA205 |         \
+     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
+     PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205 |                          \
+     PPC2_FCPSGN_ISA205 | PPC2_LFIWAX_ISA205 |                      \
+     PPC2_FP_PAIR_ISA205 | PPC2_FPSCR_EXT_ISA205 |                   \
      PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |                   \
      PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5077f3300e..f2a342b076 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6220,7 +6220,10 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, const void *data)
                        PPC_SEGMENT_64B | PPC_SLBI |
                        PPC_POPCNTB | PPC_POPCNTWD |
                        PPC_CILDST;
-    pcc->insns_flags2 = PPC2_VSX | PPC2_DFP | PPC2_DBRX | PPC2_ISA205 |
+    pcc->insns_flags2 = PPC2_VSX | PPC2_DFP | PPC2_DBRX |
+                        PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205 |
+                        PPC2_FCPSGN_ISA205 | PPC2_LFIWAX_ISA205 |
+                        PPC2_FP_PAIR_ISA205 | PPC2_FPSCR_EXT_ISA205 |
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
                         PPC2_FP_TST_ISA206 | PPC2_FP_CVT_S64 |
@@ -6381,7 +6384,10 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
     pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 | PPC2_ISA205 | PPC2_FP_CVT_S64 |
+                        PPC2_FP_TST_ISA206 | PPC2_FP_CVT_S64 |
+                        PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205 |
+                        PPC2_FCPSGN_ISA205 | PPC2_LFIWAX_ISA205 |
+                        PPC2_FP_PAIR_ISA205 | PPC2_FPSCR_EXT_ISA205 |
                         PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
                         PPC2_BCDA_ISA206;
     pcc->msr_mask = (1ull << MSR_SF) |
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 467b8f3d4e..c00581fc36 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4403,7 +4403,7 @@ static bool trans_ICBIEP(DisasContext *ctx, arg_X_ea *a)
 static void gen_dform39(DisasContext *ctx)
 {
     if ((ctx->opcode & 0x3) == 0) {
-        if (ctx->insns_flags2 & PPC2_ISA205) {
+        if (ctx->insns_flags2 & PPC2_FP_PAIR_ISA205) {
             return gen_lfdp(ctx);
         }
     }
@@ -4415,7 +4415,7 @@ static void gen_dform3D(DisasContext *ctx)
 {
     if ((ctx->opcode & 3) == 0) { /* DS-FORM */
         /* stfdp */
-        if (ctx->insns_flags2 & PPC2_ISA205) {
+        if (ctx->insns_flags2 & PPC2_FP_PAIR_ISA205) {
             return gen_stfdp(ctx);
         }
     }
@@ -4429,9 +4429,11 @@ GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 /* handles lfdp, lxsd, lxssp */
-GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000,
+              PPC_NONE, PPC2_FP_PAIR_ISA205),
 /* handles stfdp, stxsd, stxssp */
-GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000,
+              PPC_NONE, PPC2_FP_PAIR_ISA205),
 GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
 GEN_HANDLER(mfspr, 0x1F, 0x13, 0x0A, 0x00000001, PPC_MISC),
 GEN_HANDLER(mftb, 0x1F, 0x13, 0x0B, 0x00000001, PPC_MFTB),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index c3d8bbf267..0c6ec91400 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1545,7 +1545,7 @@ static bool trans_XOR(DisasContext *ctx, arg_XOR *a)
 
 static bool trans_CMPB(DisasContext *ctx, arg_CMPB *a)
 {
-    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    REQUIRE_INSNS_FLAGS2(ctx, CMPB_ISA205);
     gen_helper_CMPB(cpu_gpr[a->ra], cpu_gpr[a->rt], cpu_gpr[a->rb]);
     return true;
 }
@@ -1636,7 +1636,7 @@ static bool trans_PRTYW(DisasContext *ctx, arg_PRTYW *a)
     TCGv rs = cpu_gpr[a->rs];
     TCGv t0 = tcg_temp_new();
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    REQUIRE_INSNS_FLAGS2(ctx, PRTY_ISA205);
     tcg_gen_shri_tl(t0, rs, 16);
     tcg_gen_xor_tl(ra, rs, t0);
     tcg_gen_shri_tl(t0, ra, 8);
@@ -1652,7 +1652,7 @@ static bool trans_PRTYD(DisasContext *ctx, arg_PRTYD *a)
     TCGv t0 = tcg_temp_new();
 
     REQUIRE_64BIT(ctx);
-    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    REQUIRE_INSNS_FLAGS2(ctx, PRTY_ISA205);
     tcg_gen_shri_tl(t0, rs, 32);
     tcg_gen_xor_tl(ra, rs, t0);
     tcg_gen_shri_tl(t0, ra, 16);
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index e0d9fa2e24..fef770368a 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -324,7 +324,7 @@ TRANS(FNABS, do_move_b, 1ULL << 63, tcg_gen_ori_i64);
 static bool trans_FCPSGN(DisasContext *ctx, arg_FCPSGN *a)
 {
     TCGv_i64 t0, t1, t2;
-    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    REQUIRE_INSNS_FLAGS2(ctx, FCPSGN_ISA205);
     REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
@@ -592,13 +592,13 @@ static void gen_mtfsf(DisasContext *ctx)
     flm = FPFLM(ctx->opcode);
     l = FPL(ctx->opcode);
     w = FPW(ctx->opcode);
-    if (unlikely(w & !(ctx->insns_flags2 & PPC2_ISA205))) {
+    if (unlikely(w & !(ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
     if (!l) {
         t0 = tcg_constant_i32(flm << (w * 8));
-    } else if (ctx->insns_flags2 & PPC2_ISA205) {
+    } else if (ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205) {
         t0 = tcg_constant_i32(0xffff);
     } else {
         t0 = tcg_constant_i32(0xff);
@@ -627,7 +627,7 @@ static void gen_mtfsfi(DisasContext *ctx)
     }
     w = FPW(ctx->opcode);
     bf = FPBF(ctx->opcode);
-    if (unlikely(w & !(ctx->insns_flags2 & PPC2_ISA205))) {
+    if (unlikely(w & !(ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-ops.c.inc
index 9bc9c3a3c3..e6a0d88dd4 100644
--- a/target/ppc/translate/fp-ops.c.inc
+++ b/target/ppc/translate/fp-ops.c.inc
@@ -1,14 +1,17 @@
 GEN_HANDLER_E(lfdepx, 0x1F, 0x1F, 0x12, 0x00000001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER_E(lfiwax, 0x1f, 0x17, 0x1a, 0x00000001, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(lfiwax, 0x1f, 0x17, 0x1a, 0x00000001,
+              PPC_NONE, PPC2_LFIWAX_ISA205),
 GEN_HANDLER_E(lfiwzx, 0x1f, 0x17, 0x1b, 0x1, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_HANDLER_E(lfdpx, 0x1F, 0x17, 0x18, 0x00200001, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(lfdpx, 0x1F, 0x17, 0x18, 0x00200001,
+              PPC_NONE, PPC2_FP_PAIR_ISA205),
 
 #define GEN_STXF(name, stop, opc2, opc3, type)                                \
 GEN_HANDLER(name##x, 0x1F, opc2, opc3, 0x00000001, type),
 
 GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
 GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001,
+              PPC_NONE, PPC2_FP_PAIR_ISA205),
 
 GEN_HANDLER(mcrfs, 0x3F, 0x00, 0x02, 0x0063F801, PPC_FLOAT),
 GEN_HANDLER(mtfsb0, 0x3F, 0x06, 0x02, 0x001FF800, PPC_FLOAT),
-- 
2.53.0


