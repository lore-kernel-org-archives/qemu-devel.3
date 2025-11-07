Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166C4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJda-0008VK-QE; Fri, 07 Nov 2025 05:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdY-0008Up-F1; Fri, 07 Nov 2025 05:24:08 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdV-0000qm-Og; Fri, 07 Nov 2025 05:24:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDyKxUT0FBCHadj2Qmo49ABH9I3CV7MsjUR1aX6cT/jubwZeOtZSrr+GNrfg+Au3AOw8LRb8AID4why7J8faPiwwUFnINT9SS25pKq/UF4u4BchFm5RYzp+6fmz5SrgabUnroxxBH9rzMOD7iMgDayws4mLQ9PVG5/wQNIyuXaZIbmIgY8+KQIliiDK/f+mKbmWdfacj7BrmDBzRZvi8EsLVD4n7zpSxniLp11oUkVjHxBqiAnP+KrTTp36/IOMAPO3w9uXN4/gpyeCl7cAQWT4++3CEMFhNsy+B5OWPiJZBDGSz7ADiNZa5sRrh6Ss7uMkAsL7ShIWlKNUEY1sx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1fBhH4wvYYIgfwEcdMGqV1WC0HnctYaPLB4w+8/KRE=;
 b=xrocWwLFERdj7UGzqVohyUJi1cggsoERdKqgx/Uo8MV3PrgCctxF9R/e5dnQXwZPblKtdgvLMYUNacHzIpOJk3YxzZVuVXyGxhIUh1CTd7TXlluvN8zd9AiHINGRTaAKoTJHeIxPbb6eDTI7AEsYxGZSiDM3ldmtVPIwaocdbp7mnu0pkFewQYeqOEa1v3cg0u8wGZS+As/I7br0UrkecnZ0NQqwxgcVrj6qJFEebKEmMDJgHNlPjE6lTFJz3OCZSlbr7B0gChuC6tE3CJZUKgDjVBdK27s777S3/vXJDYhAtRnzTsidVhWx4KbhV17Mv9xUQo90ydgHQl/TdxBBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1fBhH4wvYYIgfwEcdMGqV1WC0HnctYaPLB4w+8/KRE=;
 b=nGAygikxNRd0B4LTUS0m4IKwYs/+bDdqH6ERA4+ceu/uTvgdDWl8P89VNvzxru1hlgGVIvrRn2G6gAHf0hdTfi7hATy3XTcmPu9XbMMwNIvbjkzjMUb2MgUdJLQ3Rn3aJqjuLfv+HI4/m7Kd2I0+Nw45ILN1jDk4g/SSLPMaGyU=
Received: from MW4PR04CA0076.namprd04.prod.outlook.com (2603:10b6:303:6b::21)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:23:57 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::c8) by MW4PR04CA0076.outlook.office365.com
 (2603:10b6:303:6b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 10:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:23:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 02:23:55 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 04:23:55 -0600
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:23:54 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 0/9] RISC-V CPU time source interface
Date: Fri, 7 Nov 2025 11:23:26 +0100
Message-ID: <20251107102340.471141-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: db7281bf-aef6-4eba-d10b-08de1de7c215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sj0i1UHJhZ7dutWWGsmMOccFw2K9pQWDOqWmPhHyyfkTMowoki4MToCjWkyp?=
 =?us-ascii?Q?i+BU0k7GKUH0YItf0q0vLbjI3ZQx2dpTbqwR5tc1PS0Rl5fm4kZmXP+SKsTq?=
 =?us-ascii?Q?80522Lhsy5AnU0tT7bu9zM2C+EpM3aUoe2G6PvE023Fpe63rmCl0Q8D+KhFu?=
 =?us-ascii?Q?vQ1fGQ4V1HDRpPTWUi1ztR701WiPxxxyESBNsqkWMNdMp9/DlXGyV88YHnsI?=
 =?us-ascii?Q?bIDzScfj9UEFDQtyJ4RQ3SD+KpQcK9QhTHDQS6H8rO33JTxo9lvSe1nPiCqw?=
 =?us-ascii?Q?vDOzRIakeB4XIEwcpQokF4PIjtJiL1w3SS5vMpG4NadbpuN4nfC1H2WcH+jl?=
 =?us-ascii?Q?cPalyQs0ZRwcuL7gWmgMwtLaO/BLtn6E7f22t2bQsDVBXjzr52f6/+2ZWF7Q?=
 =?us-ascii?Q?+E91PkV68kQYkQQ8go/NlzgPlQiA5AeBzMADykzhlb/AUAL7fvLPI8NpImZp?=
 =?us-ascii?Q?+Us2gK8Uh5f6PlEIT2H52688HssUsFSWLT8o9lk+cSNurcsdfQ8snx5rYcBn?=
 =?us-ascii?Q?s6GroRo+smEVY+avPLApdQashiFLDy3UmtnnJl+AwKMQYlf67GUQcffcth/T?=
 =?us-ascii?Q?5Vq7eaw9niREJKg6wLbcQFFrMrMVea/K96HtOb4qkvLJFVNdQNkInZZytqdu?=
 =?us-ascii?Q?XJBbuVMBapY62OUHXN34sCWIbvuM3Lagn59mQVplSRauK1JfTo4ITx/6MbhA?=
 =?us-ascii?Q?jpkJKkpKZOHGdu3l2ohdu23ydo64ZVwkbJK2rZWnP+WLyIM+SY/TTwrvz9ip?=
 =?us-ascii?Q?sY4iKOTzpyrPbcsPztZvX6P+2yqBTqthDGN/0OTJguINb5uDaGWW76hJcLtT?=
 =?us-ascii?Q?JXs36G5sL2gp1iUo0umQw/dkIldaiM3+MwGFSwfO2lMcJ2zCwHEq/uSDDfYg?=
 =?us-ascii?Q?hmkqqbw6yvoJAMTnu2M04lizWZtWCVrjrCJDBgPXDGaHRB5UQh8jCHJAUUwn?=
 =?us-ascii?Q?3O24YTZeOwM7+4l6eGk9tXEKF0yA3nLkRw+FCgQ2xNxBHf2Fe+CFZHMyMpxd?=
 =?us-ascii?Q?7osh0E9yAJUDBHsqNL8obxM7+za41xPZYnedZ6SI9XJvtx4859bgMeO2xt00?=
 =?us-ascii?Q?38thaPS4K5nQr+3BJ2d3LGMrM7aGodz1UIGtBUzsOWWObYErfc48mKYPMT07?=
 =?us-ascii?Q?R0MgwyF34ATzk8/Fe2bCiaQPnIwX0wDnBjVCvP3W8OKd0u/Rc8AS3TFSiKTY?=
 =?us-ascii?Q?HdP5FVQDGoG5pVaN4sxeFfcWmjbDIkqgAY+diXXVno8sfSK2JB3doGVzAeen?=
 =?us-ascii?Q?HtSNKC0j1u62aWXef0ZRZnXVxou/DFMr3bP3VzfhZ26GcKaz42kSa01MiEWC?=
 =?us-ascii?Q?Pxx/ZX5ywuopypCLv7RcKk/xgaoEWXk/0t9cUyevhQLObU2nD/y1WCJCuT8e?=
 =?us-ascii?Q?xfbV2CoTsT8mcgf+eBX/nv8G5yEnQDNI2IHriW101nDmdM+efVVroC4pPBye?=
 =?us-ascii?Q?krG7mZtLMVCxOTifa54zqhuN5k7grFpHUIelXuauFwQSzxAAe6+xVKS7Q5NA?=
 =?us-ascii?Q?8esiTvXXgg6xarOOLpkN0bBaYz7JgQOka7dwdQIYTw6o6lpU8OErWvPKrVZG?=
 =?us-ascii?Q?JDMSkQW8JV1m9MD6ow4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:23:56.2712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7281bf-aef6-4eba-d10b-08de1de7c215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

Hello,

By working locally on a RISC-V CPU with the sstc extension, I noticed
that the sstc code (the `riscv_timer_write_timecmp' function) was
implicitly assuming that the object behind the env->rdtime_fn callback
was a ACLINT. This is not a correct assumption from the point of view of
the riscv_cpu_set_rdtime_fn function API since env->rdtime_fn_arg is a
`void *' and is not required to be a ACLINT.

I reworked this and ended up with this series. It introduces the
RISCVCPUTimeSrcIf interface to replace the env->rdtime_fn callback and
break this dependency. This interface provides a mean to retrieve the
number of ticks (same as the rdtime_fn callback), and the tick frequency
that `riscv_timer_write_timecmp' needs.

This will effectively allow other platforms with CPUs and the sstc
extension but no ACLINT to provide their own time source. For now only
the ACLINT implements this interface.

The last two patches enhance the interface with a tick change notifier
registering mechanism. This allows the time source user (the CPU) to get
notified when the time source tick counter gets asynchronously modified
(reset to 0, ...), i.e., when the time register is written to. This is
then implemented in the ACLINT so that it does not have to include
time_helper.h and tinker with the CPU internals. This again will allow
new sources to be implemented more easily. It also ease maintenance by
keeping internal CPU mechanics contained into the RISC-V target code and
avoid potential duplication.

Note that I would have liked to put the time_src interface as a qdev
link property on the CPU but given the current state of the various
RISC-V machines, this is not easy to do. Most of the time the CPU gets
realized before the ACLINT so it is too late to set the link property.
This would require further refactoring.

Tested using `make check' and by booting Linux v6.17.6 in the virt
machine with 4 CPUs. I can see an initial `time' register write
(probably initial reset or OpenSBI) that correctly notifies the CPUs.

Thanks

Luc

Luc Michel (9):
  target/riscv: drop unused include directive in time_helper.c
  hw/intc/riscv_aclint: fix coding style
  hw/intc/riscv_aclint: rename cpu_riscv_read_rtc to
    riscv_aclint_mtimer_get_ticks
  target/riscv: add the RISCVCPUTimeSrcIf interface
  hw/intc/riscv_aclint: implement the RISCVCPUTimeSrcIf interface
  target/riscv: replace env->rdtime_fn with a time source
  hw/intc/riscv_aclint: riscv_aclint_mtimer_get_ticks: get rid of void*
    argument
  target/riscv: RISCVCPUTimeSrcIf: add register_time_change_notifier
  hw/intc/riscv_aclint: implement the register_time_change_notifier
    method

 include/hw/intc/riscv_aclint.h |  1 +
 target/riscv/cpu-qom.h         | 41 ++++++++++++++++++
 target/riscv/cpu.h             |  9 ++--
 target/riscv/time_helper.h     | 27 ++++++++++++
 hw/intc/riscv_aclint.c         | 76 ++++++++++++++++++++++++----------
 target/riscv/cpu_helper.c      |  7 ----
 target/riscv/csr.c             | 24 +++++------
 target/riscv/time_helper.c     | 42 +++++++++++++++----
 8 files changed, 173 insertions(+), 54 deletions(-)

-- 
2.51.0


