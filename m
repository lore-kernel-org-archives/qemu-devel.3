Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EDCC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXlu-000882-Q1; Thu, 13 Aug 2026 11:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXlr-00080s-5S; Thu, 13 Aug 2026 11:55:07 -0400
Received: from mail-koreacentralazon11023107.outbound.protection.outlook.com
 ([40.107.44.107] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXlp-0003Ci-5l; Thu, 13 Aug 2026 11:55:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uer3DbMDHV1aXg49EBvBja42LK6T4IG+EoU+FroYX7eWIVgBlCz2/xtM6ptMiea+UT1mKJ6+r/E5iTTdBsko6oyRLfDO69LF+kHIRDeYbpnUdGTs+rPckVZQcK0mPK8Sv6vHWgpn5RWLVLqZoEi3IxxjJqNQxs6kQKT2xCY5qT/HqCk9wONB+aMRuU0LojQMSmTDNJJPKJWuOJHP5DkvItuqjMNnY644H+1E98y/GHZUlZgDgZEuY1SB+Xpyr3/dvQP87txjGrx2bwBwMpsgAek3EvXOGwPuJ76ZWFzKu8MT/TxUBl3H3K0Y57UNBr8UvLiuRUcpr9zWtv0M2LIGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8XCJvmUtHuq8mMKu0PwcsZYT2wNqfFDyJQu0xcNFQc=;
 b=jPiFDvpPhIK/0CpnC2+pN4llwx09fif0psKkPoJ9UrA3ktqV6B3KisjG6u/A4Dv3lBy3N4aPxu8EYo9cj/8ZqlD3dPCR1z791qXHvoA5pEJ66VNLnU/iODxeHWj2JUjDEv/P9Qlprl7A4qdITKa+h0UyzUzeN+VrN8FLVT4jGYlVilw2CI/YOmqDgVzu4o/HvAyAkEU79alA96gtyGgpqabG1A8/1jWOc2oubQl+0jSjnyPBMe16bTXtj9i7dInzNB/At98b5tXgxS5IrPOCWQ/EpbkLeJflWjJ4sMKX2FCJaIpc0x0T02bxU8ycfJVjXQyPynScNLnLYbb6upBV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8XCJvmUtHuq8mMKu0PwcsZYT2wNqfFDyJQu0xcNFQc=;
 b=GGVCC8y6Z9pV+WeBqswl+1KDh46zMzboK51gyPBvxNwmkUsCDZm9JCvCy9mKQs3hfIH+92SBbMH/9h9ybMEHVMUYSzzTJn6gusBSlYmV7HZHBldFIjVqBE28GvfzNBrH3jNBE83ur2/dYxfceOUADULChf9+HG8mcoZyV9q4+ygLJf0yu347dt0djHt22b9HvJ/XeIQlsIjHuk3/WU7xKNnr9jVp/RUEowd6cy2cFjLx4rP8527mKApPtPA8rXPgfmD5jaRM4rTG6bPvVcbY0T35hoSM2j4cUoEhzgf8D4AUU64NQYvm+/n4k6+L7gH6YcypCUhJH9f+FxiZCxac1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB5569.apcprd02.prod.outlook.com (2603:1096:400:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 15:49:53 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:49:53 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Hao Wu <wuhaotsh@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Troy Lee <leetroy@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 qemu-arm@nongnu.org
Subject: [PATCH 00/20] hw/arm: Store the ARM boot info in the machine state
Date: Thu, 13 Aug 2026 23:48:48 +0800
Message-ID: <20260813154918.996812-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: 96fe5235-6496-45ab-5048-08def952840c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Bj4cQUCnaiYKU/VO9JVdPwxQEe/UpdGHDUlYeRP0yNV0NeQNl8PcuUPd/chKDWhAv78q8o79bypJiY6DQSrDiHefha1RNpio0l4bjIi+G75WsZXaPmjDRUE3TWSoQOWJA8j7XS0YhHmi42eiOBYOW/gZUrNdfYL42k3VcQJBbkinPJJ+4C45M8ESsxG+4jUSus82ut68//LZUS3P1/M4/WpNV2nv5tn/YM7Yt0x3WzSqITP1Fgm+zGZbFKHja3rUC/VPqDrP7NzBip0ySQY46/PtePC5X//FhuN1q4WeVmPzxFYTz8ovo2/AkGlMXkB9ufsdSg2LdvPu+Gogs2QEpspmWyIo8j9gISU0DSpZOgXxlWvNLDTE02ZpYYqBT1lfO6XTPGWFQ0osVRay+6qDxVhM+jRaMTzFPTNg3emxJxlFjm/AYSuLJuH0Vp7S6lg7yS+7hoL9Mzg4h87W6MHPvOjMYguY9aKAIjT9D0rVUAJbJbZsOpiZZrLa4EjkDjnDYDn2NZyWrHcm4C6PfHWAJI6mbU6xsz4vpdng0tGsIv61nhMyW9YlB6XSDt2eQUN/hzfs+3Z/LjE+RAeB6Sp8tARXEK8w5t1yYsUqa13a0Yn8pw5WcLzZr2CJB+foeVFsrtE6I5wk1wc6UxH6BrryVPQf9hmZNXvw8mNo60ufoeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqL1u90+WqlRz5o/poZXRbqoSY7yjOpVsaH0sVR0nqHs8U5lmHGiJQD364Zz?=
 =?us-ascii?Q?tHyAgflyJG8+HmPsCUT0ztt1PeTH338AV5GS/V9JuwisJRWbnuZmFh9eOfjk?=
 =?us-ascii?Q?xdtAbJCcJeoB3XOqRpRTr1j2aw942fHbjm+05F2hxueBi5FQXqJBjQ6aZ+K2?=
 =?us-ascii?Q?dajHwuCS8VzdBHfczQtVx5eiEHzST2zOTAJyl7ErhVgQueiNEdUTVMaKX4Qx?=
 =?us-ascii?Q?FKCmjKGqtcjAzjZaQ/0OohjgJpTnF9DAiPYifPhzvS6wWmwza67Kz5smZ0ub?=
 =?us-ascii?Q?qsiGknplyxU3cCA887+KXt3bJCUzFLYN3MN+tqg7c2QKPmMbVCsLqcKpblTV?=
 =?us-ascii?Q?OeAl7YytMjJBjRi36fm4ofgkMQhuJAaVfJprju0OM5Pp2s8qPR6wWCpdEh0H?=
 =?us-ascii?Q?nEVPMyEXGDNo3899hg6KBZM8X7vPn8prrb3Md5C3gQRdmCWEe6FGjFRbqQna?=
 =?us-ascii?Q?6m2VVzQXwzcFtZG2nTT/HBZrgMcfJtzwVs5vuL7hKVt9Ie0mLd2/YiDS90re?=
 =?us-ascii?Q?Ax02k+TOYo+U9b2OfWwyc88T1TxlFO+bQX+d03/nJAM7ARZb3K+I2LH5froe?=
 =?us-ascii?Q?aJSj3dG4Ou52k8zKzeHZ/2Q6ffUh+OqiNfEbZCfSi/a9BgVDLecjdEPICdwT?=
 =?us-ascii?Q?RA0n4BRUef8vssHDoeyVVJvYfnxzFVuiBc12QAfnE/5jtIxZtZeD1+kMGZ3R?=
 =?us-ascii?Q?xL6QODSIb1Llt1jbZbr/CjDZpsOKr4/EADh2Zi+iQhChQC6RBwYXK3Dt5fli?=
 =?us-ascii?Q?/q7nIMQ9Pc4DqRQTgYUxwCcr+iDlnG76ISLlJl4rB9+CRucEKejOM8NYwf5f?=
 =?us-ascii?Q?glRvAfUAr/6ucmuxe0EMlKcj1dSDm5f70wxX2cwvy7/gBgEQbAWUoU3kUmNs?=
 =?us-ascii?Q?r8HGR/8XkJmBI3+9FWa7aBzItqWuj2GdXFM7ibY9rcSwL/gr1nEObCYwPvrp?=
 =?us-ascii?Q?2YY7O2LQ8brGzdxUQoGfK0gH1Zyf3ZrPvHNGniXqQMBCmgA6GTpivKDPQvly?=
 =?us-ascii?Q?DakXqnbL7PcDB4buvfWn4O/7NFy2bUyxtZSeygEH7qO9RlhH5FTvKnQVTq8O?=
 =?us-ascii?Q?pmYXynj8+kacqjh96362RJfF7rPn2DdlJ/A1eZgV6VfT1rAJnaewFgVEtzVK?=
 =?us-ascii?Q?8B2P7ucNe10MSNm6mws7818K+MB9gL26rFll3lYU3IHWZq+9EnELJe7dEobK?=
 =?us-ascii?Q?gsHBG+kAhNNv8ZbTXRrr5O80FaZ061WNExA2ZxD2oFNSd4gGbx8T1vGQLCmu?=
 =?us-ascii?Q?HWVDgabV2EXciQCRfdtlekPaxwiE35HRRjXxihBMDVnZnVaSDsefoQFLmFXo?=
 =?us-ascii?Q?3xOaKt+D2v5VvxPImyN4TDFowZhVj6JVA7Vf7JeF5cLkQPDDmdVq7RVEZZgX?=
 =?us-ascii?Q?4Ast5veR2/HuTKsORRjHjuUv4MR22v5GxW8aO8+B1GYQn87IcAKvNkM8bL58?=
 =?us-ascii?Q?AXizWGjW+2MLM+H+0P9KQDd78fkbdtGDyc5IIFZt8WlMFacHSQXBA2EUYXP6?=
 =?us-ascii?Q?upIsFoU0najnepn/8lo92T617OF3dOnDbWul9kPbPg+ChLxSBhCC52RtDhQP?=
 =?us-ascii?Q?S1VDtvNCRSSWO7GXqfyQ0Xe1jI6BU6tmtzimDNaiFoX8pb88g9dfA5h3MV2X?=
 =?us-ascii?Q?P3EO+S+o72YaLeEDr8Q4MFT7sTEV06Rd5/tUMmKFikGMvI2Gob86stftR2oe?=
 =?us-ascii?Q?XP+l2zECdDUvFccMuceHXi85Ua03d0aYGD/HQclo+JcZP2lguGhRTRdnOn9W?=
 =?us-ascii?Q?TPVT+P4JdQzTOjyEX29Ltx52UI053m8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fe5235-6496-45ab-5048-08def952840c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:49:53.3530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjiHrkpZD0EBQniypKMYW+wqVySOfcYyyDxBaRnOuVBpIGy4Ym5fFR1DEn2sYRfYt6yAqLth015n6DZvrtoAzFqaVfV4obppQ+zOPlW+PXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5569
Received-SPF: pass client-ip=40.107.44.107;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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


Most ARM board files declare their struct arm_boot_info as a static
object at file scope (or, occasionally, as a function-local static
inside the machine init function). arm_load_kernel() stashes a pointer
to that struct in every CPU and dereferences it from do_cpu_reset() on
each reset, so the boot info conceptually belongs to the machine for the
lifetime of the VM, not to a static object whose ownership is left
implicit.

This is a longstanding leftover pattern: modern machines such as virt,
raspi and xlnx-zcu102 already keep the boot info in their MachineState
subclass. This series converts the remaining machines that still use
a static object, moving the struct into their machine state so that its
lifetime and ownership match how arm_load_kernel() actually uses it.


Bin Meng (20):
  hw/arm: aspeed: Store boot info in the machine state
  hw/arm: aspeed_ast27x0-fc: Store boot info in the machine state
  hw/arm: bananapi_m2u: Store boot info in the machine state
  hw/arm: collie: Store boot info in the machine state
  hw/arm: cubieboard: Store boot info in the machine state
  hw/arm: exynos4_boards: Store boot info in the board state
  hw/arm: imx25_pdk: Store boot info in the board state
  hw/arm: imx8mm-evk: Store boot info in the machine state
  hw/arm: integratorcp: Store boot info in the machine state
  hw/arm: kzm: Store boot info in the board state
  hw/arm: mcimx7d-sabre: Store boot info in the machine state
  hw/arm: musicpal: Store boot info in the machine state
  hw/arm: npcm7xx: Store boot info in the machine state
  hw/arm: npcm8xx: Store boot info in the machine state
  hw/arm: omap_sx1: Store boot info in the machine state
  hw/arm: orangepi: Store boot info in the machine state
  hw/arm: realview: Store boot info in the machine state
  hw/arm: sabrelite: Store boot info in the machine state
  hw/arm: versatilepb: Store boot info in the machine state
  hw/arm: xilinx_zynq: Store boot info in the machine state

 hw/arm/aspeed.c              | 17 +++++++--------
 hw/arm/aspeed_ast27x0-fc.c   | 13 ++++++------
 hw/arm/bananapi_m2u.c        | 37 ++++++++++++++++++++++++++-------
 hw/arm/collie.c              | 14 ++++++-------
 hw/arm/cubieboard.c          | 38 +++++++++++++++++++++++++++-------
 hw/arm/exynos4_boards.c      | 26 +++++++++++------------
 hw/arm/imx25_pdk.c           | 11 +++++-----
 hw/arm/imx8mm-evk.c          | 34 +++++++++++++++++++++++++-----
 hw/arm/integratorcp.c        | 40 +++++++++++++++++++++++++++++-------
 hw/arm/kzm.c                 | 14 ++++++-------
 hw/arm/mcimx7d-sabre.c       | 36 +++++++++++++++++++++++++++-----
 hw/arm/musicpal.c            | 32 ++++++++++++++++++++++-------
 hw/arm/npcm7xx.c             | 28 ++++++++++++-------------
 hw/arm/npcm7xx_boards.c      | 15 +++++++++-----
 hw/arm/npcm8xx.c             | 30 +++++++++++++--------------
 hw/arm/npcm8xx_boards.c      |  3 ++-
 hw/arm/omap_sx1.c            | 21 +++++++++++++------
 hw/arm/orangepi.c            | 37 ++++++++++++++++++++++++++-------
 hw/arm/realview.c            | 30 +++++++++++++++++++--------
 hw/arm/sabrelite.c           | 24 +++++++++++-----------
 hw/arm/versatilepb.c         | 16 +++++++++++----
 hw/arm/xilinx_zynq.c         | 17 ++++++++-------
 include/hw/arm/aspeed.h      |  2 ++
 include/hw/arm/npcm7xx.h     | 10 +++++++--
 include/hw/arm/npcm8xx.h     | 10 +++++++--
 include/hw/arm/xilinx_zynq.h |  2 ++
 26 files changed, 382 insertions(+), 175 deletions(-)

---
base-commit: 539bc315538afe036a4b99088659aa82e3b489f2
branch: cleanup-arm-static-boot-info

-- 
2.53.0


