Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F85CCE7A9C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 09:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJq49-0007B5-Sl; Fri, 14 Nov 2025 04:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vJq40-0006zZ-Bg; Fri, 14 Nov 2025 04:25:54 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vJq3w-00062G-Id; Fri, 14 Nov 2025 04:25:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MixVrzGo2Hzb9Px36E6trTw6gzU3ZKaE7uYZUaU4zZpGvsIRtHchoQrNtwIpTL540ccrLwZaPRqx2gpXSuMECtkPMi9suDMx1q9olDJyyYCcr/aRTA5+2NflqKKzSP4H11KMhnY35u80araUM/nva8QqS5ugD+ZrilvYB/CUIobJVnOxiCnfL3Mun7ReKlTH849PNX6MULOXrWmMKEg9julVfTRj4xjBCJbmarlxyeRdhHNgpR1xqtHQgbGoS+VkTcdU5kTsgD4HjG+QZdNI/aKfahDB8MR22ppucQcYomgStFp/NdXW/k/YYbvgz4Arlmnf7bci37E9S1wGrmS3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQpsEFrMAOhDNkkTnfpDUT2cVsCffa2CmTEnfEu8HsE=;
 b=NLJYiHZkeqAkhuyZfBfcMwBgY41VfnxR/XD0gBTT6PIHa7jtSUjUtzHamEKxhqWrnmNQ2xmsLekYiFlDfuikAocLIkzf0LxuBACzdjt0n/DrL1snY7VoCyUwjzxdocZD2Oz8UAL2Vkq2MjkTPu7ZUukLEIbtJku4bjPU1AtakDDyGqzfMLKIn+gLIDyqYF8QdsCxms6aekyeHeDXpEE29HRvBKk6NqW4EOU67+dWroL/nTd67NZUHK9lWQBmLf15I203NYGsFziBhAWRyA+GE64QeOVlgIYa2e129Yi7eVyrhAeO7Igp+e1hV3ZHaBM5geCkM+3jXLuYMQnyMKmd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQpsEFrMAOhDNkkTnfpDUT2cVsCffa2CmTEnfEu8HsE=;
 b=TtpGim6a6uADPLdCgXF+DTvqXQBGi8Kg2zfgCME54Bq0Qo8Z0GW005GzwjjxEwZpSQ8YCzEUSmYR/NH0VE/9/DqhivgCCmb/07DoVOi1WwcEt9NN1iFqyKQWzZs9St4A7qh7ijbhWzp8vxvo/yCBoOXk7d17ZUaBJl2L+vmFDEE=
Received: from SJ0PR05CA0201.namprd05.prod.outlook.com (2603:10b6:a03:330::26)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:25:38 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::ae) by SJ0PR05CA0201.outlook.office365.com
 (2603:10b6:a03:330::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.7 via Frontend Transport; Fri,
 14 Nov 2025 09:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 09:25:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 14 Nov
 2025 01:25:36 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Nov
 2025 03:25:37 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 14 Nov 2025 01:25:35 -0800
Date: Fri, 14 Nov 2025 10:25:34 +0100
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, "Daniel Henrique
 Barboza" <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: Re: [PATCH 0/9] RISC-V CPU time source interface
Message-ID: <aRb1jmwXE18JB2_g@XFR-LUMICHEL-L2.amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251107102340.471141-1-luc.michel@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcb77b7-d4ab-4716-e5c1-08de235fc622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vh2nK16K+Z5BJuD5kxdErFpNOTgV74LInd4SB/5OICFJjiwm3JwQeZ6hxHAI?=
 =?us-ascii?Q?cZvVpR+O5UzXrsR4rDDy8OsvDppgewyztoFdDiSphQikGOo/FRoVDmJ4b487?=
 =?us-ascii?Q?UAHPWvS9t/I1aRU4cABN07QNdDnxxJOQf71UpHWPAp+MH8QBKGzlT92UQ/V/?=
 =?us-ascii?Q?loQoNnCghOq9f6qbcTMVZyz1wYmQ5ovdW/eDa2WWVlLocwhE4a3hGZgUphoy?=
 =?us-ascii?Q?QVgIOr0kB4n6SLAwRk6TvEZj8zeLtwp6i02nZrEhNN2eUvsGCVuwFtt59XnB?=
 =?us-ascii?Q?OkHFn6iC2dXZP0F/Dz5G52goGJyBENoPf7RcjmEw/MM2NTGguMwDIwLw/gYS?=
 =?us-ascii?Q?vBm42ASwGPAglegBdM3ju7CeNLBFbFSt8RJuNuCx/uhwMxt86S/emQrI9Fbt?=
 =?us-ascii?Q?Oj8ZDyQbsWPjHR7DWYfDw+ekoGwujg5cN1TSdIfkgjj9S4eGcl9bUIlOrRAC?=
 =?us-ascii?Q?Sj+v6c8pv5Ljcre+E/rYvDcy5zXD7TmJCUYoO20hVr4V09a9BRhPwMp8iLYE?=
 =?us-ascii?Q?RHztrYdATt4CgyBAhpdVYlsScr/JOwZtDNTbnf+Z604subdquyyd8hZC/7h5?=
 =?us-ascii?Q?/6jcC7eW3dp5xpWgjvAXUicqWOkP4tKpkQ5GNPcANugVqltUFMH6KfI5vurt?=
 =?us-ascii?Q?QH5sO1JuKYPfaUBR8vprZGVNc/q/eapyhEkR2itTA9Av/RKdFk3L17dnxN0V?=
 =?us-ascii?Q?YX/NsuDhJkC2yfgZy5UCqfPLQO/hEdrE8KIsiQlPpD7nYzuRdqJS73pW5K69?=
 =?us-ascii?Q?c8ZTO7y44UNgS8zhdpz0t5eW6B+QZnoyGjnZ0AzgGe09EQShpfEluT9wHhd3?=
 =?us-ascii?Q?g8y30aqgvTvJYZpbLpo1UjlBEkSt6gGqYSX3Ws+sElDxwDbApZxsUnERnUDG?=
 =?us-ascii?Q?JyKrkxQVP0JxIOrG2wHwRiiA4KEYd6X2Z2G6P0x8Ej8F7SBhcQ46F4lbaXCM?=
 =?us-ascii?Q?CgZgPEJEJlCnNl6v2Y86R7VygWNp9Jb9hFSxC12xfpCBThAxY8hmN4HxXaIm?=
 =?us-ascii?Q?DOQgzHVdbt0wj1/vUEd3vj07IsUr7Si063s4GxJKm01S46w4SIKtj0JeyEso?=
 =?us-ascii?Q?q53oIZNUKKbYCdff+Yk4DzSYWrb83uIoTJyOHCf2GGx5F+J/AEkpM8HPbsnQ?=
 =?us-ascii?Q?lrQ+bFn/6RctQOYKYG6Rd16XhaZTbwmKs6p2JnHD1DWwRewVIUhF+QiUcs2J?=
 =?us-ascii?Q?XY3zvqe1giDjalnQecQW4r3yrtmGak0ogZXfUlfDF9oR3HwYITPLLX2UiW+P?=
 =?us-ascii?Q?7l/ztimtvD9xkpalxY4Q9TXf7LQIuHJOa6Q7n+ADsGywl56CqJRaclYHPg9u?=
 =?us-ascii?Q?F9nMamULf6S3YM01p09eVtBEcjtFWAzdD+lvTeGhkga38gv9YZufgDSQ/j+M?=
 =?us-ascii?Q?ezWIlDsZkTNLGG0MaFqkkYNhjcHgEt/8i0Ts5E+WsS3leCjfGFI+L/LeJvK6?=
 =?us-ascii?Q?JyaRI6552T4FVNtQ8t4JcYN/CKfMw88mqDmsKQXLExJNclOC5B5p6NizNIi/?=
 =?us-ascii?Q?6tOysF409nNehUKZKKT4qnXSJzHdldJZU6DaACx9bbw5dJF5RFcx91cOUrI4?=
 =?us-ascii?Q?GQVaMOcSr2CSsU9chZg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:25:38.4897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcb77b7-d4ab-4716-e5c1-08de235fc622
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11:23 Fri 07 Nov     , Luc Michel wrote:
> Hello,
> 
> By working locally on a RISC-V CPU with the sstc extension, I noticed
> that the sstc code (the `riscv_timer_write_timecmp' function) was
> implicitly assuming that the object behind the env->rdtime_fn callback
> was a ACLINT. This is not a correct assumption from the point of view of
> the riscv_cpu_set_rdtime_fn function API since env->rdtime_fn_arg is a
> `void *' and is not required to be a ACLINT.
> 
> I reworked this and ended up with this series. It introduces the
> RISCVCPUTimeSrcIf interface to replace the env->rdtime_fn callback and
> break this dependency. This interface provides a mean to retrieve the
> number of ticks (same as the rdtime_fn callback), and the tick frequency
> that `riscv_timer_write_timecmp' needs.
> 
> This will effectively allow other platforms with CPUs and the sstc
> extension but no ACLINT to provide their own time source. For now only
> the ACLINT implements this interface.
> 
> The last two patches enhance the interface with a tick change notifier
> registering mechanism. This allows the time source user (the CPU) to get
> notified when the time source tick counter gets asynchronously modified
> (reset to 0, ...), i.e., when the time register is written to. This is
> then implemented in the ACLINT so that it does not have to include
> time_helper.h and tinker with the CPU internals. This again will allow
> new sources to be implemented more easily. It also ease maintenance by
> keeping internal CPU mechanics contained into the RISC-V target code and
> avoid potential duplication.
> 
> Note that I would have liked to put the time_src interface as a qdev
> link property on the CPU but given the current state of the various
> RISC-V machines, this is not easy to do. Most of the time the CPU gets
> realized before the ACLINT so it is too late to set the link property.
> This would require further refactoring.
> 
> Tested using `make check' and by booting Linux v6.17.6 in the virt
> machine with 4 CPUs. I can see an initial `time' register write
> (probably initial reset or OpenSBI) that correctly notifies the CPUs.
> 
> Thanks
> 
> Luc

Hi,

Ping, patches missing review: 8 and 9.

Thanks

-- 
Luc

> 
> Luc Michel (9):
>   target/riscv: drop unused include directive in time_helper.c
>   hw/intc/riscv_aclint: fix coding style
>   hw/intc/riscv_aclint: rename cpu_riscv_read_rtc to
>     riscv_aclint_mtimer_get_ticks
>   target/riscv: add the RISCVCPUTimeSrcIf interface
>   hw/intc/riscv_aclint: implement the RISCVCPUTimeSrcIf interface
>   target/riscv: replace env->rdtime_fn with a time source
>   hw/intc/riscv_aclint: riscv_aclint_mtimer_get_ticks: get rid of void*
>     argument
>   target/riscv: RISCVCPUTimeSrcIf: add register_time_change_notifier
>   hw/intc/riscv_aclint: implement the register_time_change_notifier
>     method
> 
>  include/hw/intc/riscv_aclint.h |  1 +
>  target/riscv/cpu-qom.h         | 41 ++++++++++++++++++
>  target/riscv/cpu.h             |  9 ++--
>  target/riscv/time_helper.h     | 27 ++++++++++++
>  hw/intc/riscv_aclint.c         | 76 ++++++++++++++++++++++++----------
>  target/riscv/cpu_helper.c      |  7 ----
>  target/riscv/csr.c             | 24 +++++------
>  target/riscv/time_helper.c     | 42 +++++++++++++++----
>  8 files changed, 173 insertions(+), 54 deletions(-)
> 
> -- 
> 2.51.0
> 

-- 

