Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04352E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 21:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLU8G-0006pQ-1d; Wed, 11 Dec 2024 16:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tLU8E-0006p3-Cf; Wed, 11 Dec 2024 16:20:30 -0500
Received: from mail-bn8nam04on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2408::60c]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tLU8B-0003nJ-MK; Wed, 11 Dec 2024 16:20:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4M55+E6HVpBI3gSifWgwdFwiVDgLOItSvDvxfapoIQz2tDGuvqcd3bpXI977Z/MTZecm4VgGWjpO/xQ68M3YGljpDTWOvCAUJDbe3MP6qIX+ujJVXc4vm1zYD3cQfin2rJOCWtaiQFoO/Qp130kMxulWKm9Wt156XTkV35NQJ0IV1e17jZHWEaShIpQgrqJxm4+HpKOYMMwe6/gNz6tqFadEAYMV1I8EEM2VTlV82SjOArcN5TsOvCpYCInNFCBpU2HTHgD6mcu15dY/ixoKNsRd6ei4SImWFp06ip3xMQx+S7eiKjD6ujBlrthGIQeqFxbD7V9A1mFhKNz1588Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBq1fkGpqYwoSlGE6gmA03v/TYvex1GA5CtsDM4punA=;
 b=yBkszLo1Kdj+4+PLfZ8g8ZSeo/5vvkRAU/FWLdCKcZmRmPKSzt72Zpyq+cmAj60E9swF+wLFYGgj4R/I6gGHcN2VuZ7fqJ7jUKd0W6Ds2q1bC3xuK5SyChUdDx6mI3bjN1orFMORISvsO3DhS75lWu75R4PVzBrGgaiQj1IJCxwTnIjtBmR4AIOXKBqROMYZEpUPEtOWBKbLetPswPBA8b3xmLriyLJmGCXl6HdRy4CAWyxnlq70ymbfwScg+b7ZHXatstUyKWjBVBVxQ3s9jiErgfs8iNsPOlioEjDa5VI5tmxX22PhXVc3gCK64JYnFu41nW9pdFM4eeBWjyl48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBq1fkGpqYwoSlGE6gmA03v/TYvex1GA5CtsDM4punA=;
 b=EOWcCvKW6LRYl//pPBVUjY9rsRbEiKUh5Zfm8FtY+tiMss0f7aErx9SFTPcbNbKGE+rdvRIQCj+j9x+8/ZrstHWq9d6sKRBool0hsOJRnZHXwk8eiD/6rK5WnZPvOTobJIC1qWPwa2fnxhn1O/Ys+dPG8ca0KhVyBtJugCMVYVc=
Received: from MN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:208:52d::21)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 11 Dec
 2024 21:20:14 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::6c) by MN0PR04CA0022.outlook.office365.com
 (2603:10b6:208:52d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Wed,
 11 Dec 2024 21:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Wed, 11 Dec 2024 21:20:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 15:20:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 15:20:13 -0600
Received: from xfr-fkonrad-l1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Dec 2024 15:20:11 -0600
From: Frederic Konrad <fkonrad@amd.com>
To: <qemu-riscv@nongnu.org>
CC: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-devel@nongnu.org>,
 <francisco.iglesias@amd.com>, <Luc.Michel@amd.com>, Frederic Konrad
 <fkonrad@amd.com>
Subject: [PATCH 0/3] riscv misaligned accesses
Date: Wed, 11 Dec 2024 22:19:30 +0100
Message-ID: <20241211211933.198792-1-fkonrad@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: fkonrad@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 4325f022-167d-43cb-2d53-08dd1a299a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XovrBPwhTkuYCQm+Gxpqf3OtbRLc5iA5NaxG8zMSgccSfukFDSNTtr5yGdbs?=
 =?us-ascii?Q?cG9gHGyBT4Go0dIx8NBk6DwTqvWp5lrum/lbcmdFWXCFSokCR1i56GCyIpnL?=
 =?us-ascii?Q?MNZ09XnHatlEDOrYcsBPTYyrGjDsdXHcQntketP/WXHjyDzF6GM9EdFTwFxf?=
 =?us-ascii?Q?nwwk3JRgbQodIIFNyKPcGFLTlba/fM4DLY8HDqOpYX4he4kalfrNhg1tKgPI?=
 =?us-ascii?Q?b1khG2oYcw3hA1+RvRs6uqxUYntl/jojEBpZeZb8GgBuoO5v01ubUs68DGuK?=
 =?us-ascii?Q?usXCYKnyXCj/zAvihkCj12S6BeG5vFSLCjlMZdnt660nL6zsuX2PfYPExsm6?=
 =?us-ascii?Q?9bUxrLvm6jupgEBwSRH6F2Q8V6wk/WVrD9C8sxcA+XxHzkpQ/yhAMxiDT/Mp?=
 =?us-ascii?Q?zEGRRy9Is8svas6SIvlFfAdrOEHi5pWqgVnFNo3wk/sh3zotzBjO/tmiYYJ7?=
 =?us-ascii?Q?BS8TmZLJXp4wgUiArO1hh278zid3JD4rEvF5x55PdioEJtrCe7owcg7gFkaF?=
 =?us-ascii?Q?20gMPfb6wUGNuCqCMhqPLUXLoZwzkXVzerhpxKrCmMJ0iR08LevjYZ0IY1W6?=
 =?us-ascii?Q?UzTZkS/Ob5rra9/VBnRJ6YP5OYzP1drgZq5rmqeL74y90VO+CI1WUwdG+LYJ?=
 =?us-ascii?Q?4iVTLuEg3z07o6Ult5/art1C/0vGy8P1+UhFWZ1sXuNxdB4cdhx+Q6Q/+uTy?=
 =?us-ascii?Q?ri3xBHwmBrtfwkeAfv4nlrRNJOY3/4velRC2JuAduJOVaJCZtWUiTK/LfGjV?=
 =?us-ascii?Q?7qWEQEUl/yURdo9cVn1gTIa9oNQJ5c6adWGKfUISjhKH4Uf+Pid18gWxeviY?=
 =?us-ascii?Q?GDqqDXcWtd77McdVF3pd0WXaiXkaQLffmto/a+dXuGnMo3bwwZBaxcURn1/j?=
 =?us-ascii?Q?YaCgAEpMBg9yMEHx23EtRYVShLKs/7+wJ1fvKMm/PKYmO39N1w14M8LJhYXT?=
 =?us-ascii?Q?0CNQCSq7caEkQRN5hkdC8AZkLJ7E9oSx5Th0Q4s1PTBCw+60tVQ9KUqySMiM?=
 =?us-ascii?Q?nxVFrQ/i3bKkulV073isXxdINsv6ZtqyCNE8jJuEF/lOanNVbmG03m1VL8Af?=
 =?us-ascii?Q?gpoQNVrcxBTtzyvFT7E3aEznEkrKNeFbTu2VZTCB4vFx/8eesRN2LB2J2bcf?=
 =?us-ascii?Q?2aueHAokGnUOsfokClCvHLxVfjGe/HJuTyy7UkSH294gmu/N8Vijuy6KVlLd?=
 =?us-ascii?Q?+Wn7gDrE5LJXx8kcWPwkQwYghiYiZzydrjvTwAI9GKTMzo3T3Z9x5c1ksG9k?=
 =?us-ascii?Q?2UlCrEyQ9ymSfMvP6B0mT4sp8P13rS/1p/Jk9F7h7unYj68i2vlciMwlHTR2?=
 =?us-ascii?Q?cvHPNYhbkVKYfFCr7dl2S7BX6UQ9+85PEqlBWdMEgZR+KkGRGxhQPB484arL?=
 =?us-ascii?Q?Gls6wTD+BFbg7FJD/wesAQy/tOBKWR1F2TO6V1kI0FSFjb9VUOKYpGPdbQ9g?=
 =?us-ascii?Q?cpE/92hsnaqUxZwAmQ09hcAJiJcCBO8C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 21:20:14.0977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4325f022-167d-43cb-2d53-08dd1a299a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
Received-SPF: permerror client-ip=2a01:111:f403:2408::60c;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

I fell into some strangeness while using RISCV:
 * firstly the rvi stores / loads don't seem to generate a trap when doing a
   misaligned access, which is something we would like to happen.  According
   to the documentation an EEI may or may no guarantee misaligned loads and
   stores are handled invisibly.  Thus PATCH 1 adds an option for enabling
   those traps, and PATCH 2 raise it when enabled and Zama16B (which implies
   atomicity for misaligned access within 16bytes boundary) is disabled.

 * secondly about the conditional store: the documentation states that the
   Zalrsc extension requires that the address held in rs1 is naturally aligned
   to the size of the operand.  The current implementation doesn't do that check
   if the store doesn't happen, so the third PATCH fixes that behavior so that a
   misaligned trap will happen if the address is not naturally aligned even if
   the store shouldn't happen.

Best Regards,
Fred

Frederic Konrad (3):
  target/riscv: add a trap-misaligned-access property
  target/riscv: generate misaligned access trap for rvi insn
  target/riscv: fix the trap generation for conditional store

 target/riscv/cpu.c                      |  5 +++++
 target/riscv/cpu_cfg.h                  |  1 +
 target/riscv/insn_trans/trans_rva.c.inc | 19 +++++++++++++++++++
 target/riscv/insn_trans/trans_rvi.c.inc |  7 +++++++
 4 files changed, 32 insertions(+)

-- 
2.43.5


