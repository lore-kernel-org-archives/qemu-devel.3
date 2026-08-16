Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6371EC5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvahz-0001Vl-Gm; Sun, 16 Aug 2026 09:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahr-0001Uv-CY; Sun, 16 Aug 2026 09:15:20 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahp-0005TH-FK; Sun, 16 Aug 2026 09:15:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUeWSc/QBo+fWzjOO52yfgEpr7ZpajF8d+zZiymSkRTyQ8c8IokGI3FPVpl1l6aLze/mkzJxvqvrjy5PqgFK9qsTHLoagIsjSqelIQCr6j1ss+akqTkL3VJh6c3LVxXKoDw/+XWmNTc8duTmnt3ZgU123yzhlYxkbDy9GwkLa/n+6mT4U7ADtD0Yuod7Fba4pxnoycNyUaIv+4cqgn3OZrCNtURuT6+uyE55h7yIZFiRo9tB4ZkQn3I0xmegYdHrNzeUZ0PHiDBOkmN/ybL+jApnDNk7JbLHZMJ9/i6z4NOS0VZqWPhBXo1s0dtz41yGsz93sw8ywgLmmSg08lCT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCHTKbou4BSA2qbdBvnvattjKgEBgjPUyLaVqTwhw6I=;
 b=IGw68Sx0CcGxy/ouzmHFAH00ppn4Fog5NU4UYIYTcZNEBYlhVvdcGNjc/Du9Hel9xXXnPhQCNRVIPuQARhrU0O3tviN/o4A5xK/MzME8/nR4zPg0XTtkfx2EZCar1AK7NCli+BOtST3iGb6ikjIy+8aGDmsEbkrNMSBI3ZiFI47qqCPe0hblcaHP3c2svFW0g7GGqLUp7Ui+Lr5h2cTEnSlPkzWlVey0msq/EyiqPFeRIGb+0dY2CKRarq1kscn8Ma0JQ9CpCWsZHpfRxXMaQpQusyvcLEHEfDkPSFOKUDzHFXiMFeWfCmqNSt0eqtCgbXFXOETQrjSXXwmKEbf79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCHTKbou4BSA2qbdBvnvattjKgEBgjPUyLaVqTwhw6I=;
 b=XV+Dh4Hih11PC4s2TcgQ4aX44qGz/CTJQvlQYWEwSle/EBxwpfib/NeqARES3wnlvOlqdPVpY19ZUD94eL9WK3esXZMvypcmsWg4qQONfNmWpwWJ8dUkyrm9dXTQNlRa5inkwkP5Ul3DlQGIPmBrQIG5dv8mUXYn5rtiudkgrj/DhGVNA/JS+eRebnzLkBYWh5nMpr+18V6OP77MWxDdpCZhpnOO5fYkkGY969DptfCm848IVzRckODj3XCtzXR/UKLGSWGdQ6Tjb3oOyejWX2kYR9FxUvML/hh1ygJgQmbh/9tScDTBOSmPLs0+lcNxLGt8l8mZM+tbmR5wVlBQ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:06 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:05 +0000
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
Subject: [PATCH v2 00/20] hw/arm: Store the ARM boot info in the machine state
Date: Sun, 16 Aug 2026 21:12:30 +0800
Message-ID: <20260816131300.51799-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee0cb96-c37e-47d7-0609-08defb98637a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: M2gk43R7/GyQNznRSUACT11O9wxvtNRkJFoDbxV1vkO4q2hmwC/WdrKgXKQRX05WCPmvoTKE+PMcdKMq/N0BDTDTyHxgQAS4X1bwX9ka8PdAzDvbR11JtkoY1ZVELnEoMptBMCrnKwHaJs//MxYPsHtQUuUzouOlxeQF+wokzEpuZSQ7Qwyxax9J1vcXmoUhWvUXV41za6zCf+9yGTmfQBXpVGLGUWuahmEvSlNmjGzgeSKKZ1Ht8KhYozrGC5WtpXeYdCVcZEYDlhd/fUXVzT/mgs1A7Gh2Ro3vU3I1khMYDWc0sq16c52S/ntL2Q7BqTvETWS0QyoSILOhXrj4NoXwTXZiqYRG+LrQOJeRuj76H5USDUKCcebaKv0CCEdLEDPPFf5HEDq+F5njJxATjHfzPn06D2PgoYUCAhy7muMlR2Ti1TLB8Ud4GOMTDBwd1vLbI+XLSx5TmAPXTfEaB5icpi++7D9aNQsab13sZdFMIMT2v2lKrs0JYOZZX3jAoNa5vXXnKWsG+F6txA7TSE2FFc0ikFySbioFqbabMvbqm191KrpC4QEQmvrTJmUTkCXRKFzfgzgTXwT1r/pXTCMgzbDQ/HaU4e3ljXWqcnUOoS8qE7X0JGcIIWiBLJUT/N3aH4dDwD7tOMOIP30wmmUg8gCqzaWYOor/1VxSvYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LEseYNC8AP9JcDe9rNC/k5ku/w8nvkrMs3PF29VkpSfCAyxa9eLxjozw/BNd?=
 =?us-ascii?Q?sFkvBJIukqPPNBbmbU6vUNAcyVms8zaFaqNZbPaqkezWuw2tOsKONKlTVJXT?=
 =?us-ascii?Q?Hajr2AMjworcEmr3E50s990H1vB3nejGjsElxwlt4MSm9DegIhp6h1Uv0RbM?=
 =?us-ascii?Q?LeJO5zlE0IfIoAE7P7df5c7iIbqVDrWkk7rxWyk1AVkRYMj7lw4QazKODpVb?=
 =?us-ascii?Q?bOYbbvv7YULNXzHfUaaaHLkNZgMngwPukILIRQIxBu1giGnz99UvnKjKSVHW?=
 =?us-ascii?Q?oeZOUvFvzayf+iRo77rayFviVQ7uXK242KJw9sf++cqxVCRhSm/TFtOjVkJ0?=
 =?us-ascii?Q?Jpk54AgdAifLc20egyWJ1TRP0PM0cFRFe8JxgWPG57Mp6Lor8l+aRPJGznDv?=
 =?us-ascii?Q?b+19a4eRIu7DZVwUR2d5Twqm1VawbFB8TOmfMBqgQlYrhtxdcl8jwPwx5Ip7?=
 =?us-ascii?Q?CTjFhekGX9gtsEi2QQtgCtRwhc+d67on151yFCS3K78kaK/2FuTXbWaCrgOn?=
 =?us-ascii?Q?w3GJ8pSRFQC6yaUdVoZO9uOBIR0PFhFaRRHa2FsnyljIkjMWzEQZSZfe0wy2?=
 =?us-ascii?Q?c/z48hq9qNU9w59kFzCJLd6WPpKqO2HV91y0p0STHQCshBxTQCgNSmRm10Hm?=
 =?us-ascii?Q?szj0fEtmurAFMWJ8am2bD/SkFNsCDue272SsGu8jhZea1c9Bz5lK2Q/s2Ff3?=
 =?us-ascii?Q?QQoI/DMNkWUXqrLsm3SlFYZRSacpmEL1h0MbY9k1I3Tl1LIKDLfj6EePDBFP?=
 =?us-ascii?Q?nVrcY5E1GhzcZJYIU/5khj+RPyyTOle0A38fu2uchIbL/gWS6zVFk+eAymli?=
 =?us-ascii?Q?etvD9FAbrJxKOI+Vsr0tBQwgQu3sGNZzr5lTtU8xiZ3Eb9A+cSXtjeHHYUzy?=
 =?us-ascii?Q?cJycf/Y7nauhf+v2jocOSqsVUnb+46zUcCPh9SUiQNRvrqnYAl6dqVjCdaIb?=
 =?us-ascii?Q?+b5lw/iOUkTY03hMGPlPE5a6WLAS0Dynhkset4UWMOQOvSAhQPATc+AFlPhq?=
 =?us-ascii?Q?6eYxhFwALfAiC9AKixUsLh7FVcqqNig9+A8G691BEz9brFMR07UG/rkNth31?=
 =?us-ascii?Q?pVOl0f0F0CzufekGhMd/3zHwVEEqTv7CXRBd/Z1lx1QhwQRewp9JJgrGDFK7?=
 =?us-ascii?Q?q8wj4k+4M6a+Bxrx2oaa8xdUJ9acLbWAFe9rmsMtkEadDLzviH23tmZoVliI?=
 =?us-ascii?Q?Wkgpgy9fuYw2z87SS5BGw9EWEfW5LYDkyfo7PxfaPsYjQxo1QELG3o01Jrd6?=
 =?us-ascii?Q?yqh+iaqdPswPQT+lXX96KscVAdgwznq5oyv9NaiSeLRqUoewpJQ8cxCdQC3N?=
 =?us-ascii?Q?cxe8Gayeda2dC+8Kz4j03ZNGgYEUCEStC/6vbsrkjNZg+6Q2aMoZONuAvlAA?=
 =?us-ascii?Q?ouJNWI70ALNGLKk4Epkqmxn5y8IoSHq3RvGB0o02dsRsVNi08MMgId5VgoWu?=
 =?us-ascii?Q?szRTbttOsI0Jq3AStEZ0e4oo5WgZ48Zc+j5WfpyLu2QjhBT4rTN6s7mwiQsc?=
 =?us-ascii?Q?HbT0mecu62m4VnhM0UCyBZV8Kr8hk1RpwxOzHHGQHcb/nBBKhmdQkjPl7wHu?=
 =?us-ascii?Q?RhMTzDhZpFdEeqnEmyiP//s+pr1yErbY8MEhsw3+kUrhXAzT0nUrh+MYFwwB?=
 =?us-ascii?Q?HeumuXLp4nFGZzygZ28kDw1VQRQpyAaVs4PPjS0DExVtd2Ajr387+8NEEKcg?=
 =?us-ascii?Q?L7J85I1GO96LR2RWu8U/6OF/25iXzpo6E0yJCAQ5LSRRjPyIr+HTQkQ57xs2?=
 =?us-ascii?Q?hL9gmn4W82ZQjbM1QDb4xT8yGZG8ap0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee0cb96-c37e-47d7-0609-08defb98637a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:05.7299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpYgFgZc3wnCmpeSVtlrlRqZQOOX5WwFG+sN8msVc7KdgeL3JM45Z04l/0VsAKtJe9xOGBg5BYD0W2OQoSGKBqHt8wCY+06PPPhSyryuJ60=
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

Changes in v2:

Addressed 2 review comments from Peter:

- All assignments now use individual field writes (e.g.:
  bpms->bootinfo.loader_start = ...). This applies to: collie, cubieboard,
  exynos4, imx8mm-evk, integratorcp, kzm, mcimx7d-sabre, musicpal, npcm7xx,
  npcm8xx, omap_sx1, realview, sabrelite
- The following boards that previously used DEFINE_MACHINE_ARM/AARCH64 now
  use the macro DEFINE_MACHINE_EXTENDED() instead: bananapi_m2u,
  cubieboard, imx8mm-evk, integratorcp, mcimx7d-sabre, musicpal,
  orangepi-pc

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

 hw/arm/aspeed.c              | 17 +++++++----------
 hw/arm/aspeed_ast27x0-fc.c   | 13 ++++++-------
 hw/arm/bananapi_m2u.c        | 21 +++++++++++++++------
 hw/arm/collie.c              | 12 +++++-------
 hw/arm/cubieboard.c          | 21 +++++++++++++++------
 hw/arm/exynos4_boards.c      | 26 +++++++++++---------------
 hw/arm/imx25_pdk.c           | 11 +++++------
 hw/arm/imx8mm-evk.c          | 29 +++++++++++++++++++----------
 hw/arm/integratorcp.c        | 22 ++++++++++++++++------
 hw/arm/kzm.c                 | 12 +++++-------
 hw/arm/mcimx7d-sabre.c       | 28 +++++++++++++++++++---------
 hw/arm/musicpal.c            | 21 +++++++++++++++------
 hw/arm/npcm7xx.c             | 28 +++++++++++++---------------
 hw/arm/npcm7xx_boards.c      | 10 +++++-----
 hw/arm/npcm8xx.c             | 28 +++++++++++++---------------
 hw/arm/npcm8xx_boards.c      |  2 +-
 hw/arm/omap_sx1.c            | 19 +++++++++++++------
 hw/arm/orangepi.c            | 22 ++++++++++++++++------
 hw/arm/realview.c            | 27 ++++++++++++++++++---------
 hw/arm/sabrelite.c           | 22 ++++++++++------------
 hw/arm/versatilepb.c         | 16 ++++++++++++----
 hw/arm/xilinx_zynq.c         | 17 ++++++++---------
 include/hw/arm/aspeed.h      |  2 ++
 include/hw/arm/npcm7xx.h     | 10 ++++++++--
 include/hw/arm/npcm8xx.h     | 10 ++++++++--
 include/hw/arm/xilinx_zynq.h |  2 ++
 26 files changed, 267 insertions(+), 181 deletions(-)

---
base-commit: af06b5df2610fe5de6c02d17c17bced9e9f0d47d
branch: cleanup-arm-static-boot-info

-- 
2.53.0


