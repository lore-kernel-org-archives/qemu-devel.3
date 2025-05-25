Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9144CC54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJH2f-0004o6-It; Sun, 25 May 2025 15:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH2e-0004nx-DH
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:29:52 -0400
Received: from mail-bn7nam10on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2009::61e]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH2b-0007jo-WD
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:29:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tquYZOmv/l7GX1Ro5gi0Noy840YQ6w7WtFBTN0gRWliriz46MvAWvLeKcNe3OMTo9iYdiivd3cK8VfJ+x3W1dcWfmi2cEuwO/KDMjFkI2mGYgRrKrtJqhqFQMUVNRiOs31dBvviApNzx+yvQFs6juhOUPo4amvPpwBG88nQ4tHL1zuxHXj8DDTtloYX3PTGypJVTWQZaTdFtdVu43JZHBlNAaVEflQy2QLZxerhoS+d5C/JpD2/Q816+i9fBJuptdHGBdV4Ku9Vwj2/NcXZkMME4b2JvHDo44oboi5HFF5f8NxIw3aTD3crk/t+TBILVp5QSbli0PRa/dHlL3l4S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzq1ZljuGEa3K69hGahPWsxTZbAhzUErLpxlnx8p9lE=;
 b=TejpHxecA5QKYK7VFk3N7e9TXQ6bcDdHWBOFZlTxbt0jmPOw1S6sO1Mi0gGVgcVG/cT3WedQtVVDq5VtsA0p4wFmz4RIgFmT1mbuHkzS5r3jhWi8LvnueXoVNNfTRd3ajPi9uv853E69iVnRvq3K405iaZ5q+/vD3k2OjExlZ3dCWdBc46YvcWSC1o+wAP4OsMNhy9m2NgZLi7E6we/jYm0K8l4f3asJ+K/Kcw4fhGcDzL6aZ8CeSoaYEnVe2J6jF530aW0CnOqOYQtucIqmVsZFLJ4j8X1UM0aKa1JIMCyKMbu6skLM6aFkaKjNKqr8ssRSEj6I6Kxu1eEHak8gQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzq1ZljuGEa3K69hGahPWsxTZbAhzUErLpxlnx8p9lE=;
 b=oi/Auoe27WY1NfCTdncZeXNETnj9nwlDpxxcsPI6vBYx45Vzn62jGPKU8y/5gTBEdDpH8I2DuPZsqujnOhsKiLyyfcjYtifq2fTc6aJJKuNNUZiC4kjCuzzInY8ltvsI3azBXiuDmgeDxJ3gVGhFHSL1uHdNTp+s5hQkJpUu8aA=
Received: from MW4PR04CA0363.namprd04.prod.outlook.com (2603:10b6:303:81::8)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sun, 25 May
 2025 19:29:45 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::81) by MW4PR04CA0363.outlook.office365.com
 (2603:10b6:303:81::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Sun,
 25 May 2025 19:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 19:29:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:29:42 -0500
Date: Sun, 25 May 2025 21:29:41 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 03/10] target/microblaze: Split out
 mb_transaction_failed_internal
Message-ID: <aDNvpTmZ1NmfrzEw@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-4-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: d79c66dc-ed29-4329-7fb4-08dd9bc28113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1J6BPB50wLl2c0G/ONz6KUzYy3DVOs8ocQvFTeBwNcFAPR+mZujjzCxhgQAI?=
 =?us-ascii?Q?Sf8Qv0y07oy1Bdcuy2FgF2pVxUuSTTc8QIPqOYH0Vusiv9xsQiMZIFa86VjH?=
 =?us-ascii?Q?jAyQkrCy01JC5mxd3Fvb6vZwKbWTUoek7Pia+PzQP9r5J7oeKqovpLsaWghI?=
 =?us-ascii?Q?LBCSYPT5bePzOaf34/1OGr3wjEXUaAsrFj+KX1txuvEQppEA541Mz+vfsgqm?=
 =?us-ascii?Q?1JbFeZ+2Jqyk2n0WYO8UypXqe5vExgCGuJ4wz8QQQjApgor4uNtZHaNX+wZe?=
 =?us-ascii?Q?qbTV6Dv+qhJkTh/L2E5K6Pqxhl4mvnSi3jZCG8DQzYBdIwjxY8dfyZ/Ca+mK?=
 =?us-ascii?Q?f7jdldl+QpJJBKdUiapqWdlEF/RTe1TWvf/81U1y96aL0RCO3DXVx+YQ3j9y?=
 =?us-ascii?Q?+KTmWzcwjOp0nRCdQzgy5ADzPaiqw6GvaMU4NJWD4tTY1U8lAVA3iSCG+drO?=
 =?us-ascii?Q?vZVfI4JUzS7KzoWvRTA93Gy/xOJqQtGQ3LpHSQgiM5uB1UX2X9ECcV1y9Q4s?=
 =?us-ascii?Q?2QjJgW41/k1Oktvg4P7g2yh5FG9B/4s8qF+ab75HPT9Uu80W/Xb15AzirAug?=
 =?us-ascii?Q?ka+4z1LpPO9TG8un+1aTXyabvK/Uma2ev426AoJIa2X/riELGRx3Nq/epp5I?=
 =?us-ascii?Q?CGmQvpKnengbTmCvx/vKx4OdXVmL5hkNB0tI3q9FieN+TVKJEZDNqZ6MvjGt?=
 =?us-ascii?Q?/7y8dxdDQmYIW3LF7JqNmd0s2Ktgzjepjdn9CuAcOG1ZYZ+t/qUeCaqcs6+m?=
 =?us-ascii?Q?OCxYnhng954KfZ/DXkwMXedX+r21kJYvmgbGbd/iD03DUO0lzAXGHCTawIhT?=
 =?us-ascii?Q?TBolA/oWyZXSbcxz8VEmJHkEcEUc2LRhqFdqmvfmX1t5m7blk/7B9lwyYwYi?=
 =?us-ascii?Q?FkcXtxK7f9GOhtR2NxvzERI/Mu1RJPKmzCVywTBLX8FG2O0vIxdv/7o0ev+W?=
 =?us-ascii?Q?Gg4HzbdZZ9d4QRK3KgKmQK0Hf8rzNS8OQgvb1nZsZdAr2XxueH2iMh2272Yw?=
 =?us-ascii?Q?buCSWgt5g4qWql0siOXtnzw/GRoQWIiYiXlj7feLzPckLqp3bAGtsDWfeTl2?=
 =?us-ascii?Q?b+3utczoUXVli2J9vtOIcDRczKmIEPHsB2pLoxnLqjrVuyLW88okh0dtiwqB?=
 =?us-ascii?Q?Jr5RpLNS3tzcFqRm1HIAo4HXUZxgnXx6VVhbjdu2QUwFjhPxbsrTaXOrniUl?=
 =?us-ascii?Q?OWPeTu+dcgJyj/UHV40QXIAOtXjRQdaQ+Q9qoVICr4OYNO1ExQLtcHGZRiYT?=
 =?us-ascii?Q?q67OjU6IDHadRP2vv/S6mBDsiXb4vElN3Ky0SAiRy5jJoXAonKhd1yvOHBRG?=
 =?us-ascii?Q?WnLuI6m7Jg/QlM/AX/KlO+5KlgfvDnMvgUjRt97Mv+FK5McWtTQJuY7Mg/rP?=
 =?us-ascii?Q?9MrAH8dzwURzyUzO43POD0V3YpduSYHYPaENMDXLEZsFSXFpBw0yYDyVZ8JJ?=
 =?us-ascii?Q?zUewnH+JL/65wD+ErpiQCe1jhkP8GYhr8oQ8afthdswKJiBkgIw40uLU3r0e?=
 =?us-ascii?Q?kxHArCG/ET92BbBsUYuNSjgRrrqZAzGEK1mv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:29:44.6720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d79c66dc-ed29-4329-7fb4-08dd9bc28113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
Received-SPF: permerror client-ip=2a01:111:f403:2009::61e;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On Sun, May 25, 2025 at 05:02:13PM +0100, Richard Henderson wrote:
> Use an explicit 64-bit type for the address to store in EAR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/microblaze/op_helper.c | 70 +++++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 28 deletions(-)
> 
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 9e838dfa15..4c39207a55 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -393,38 +393,52 @@ void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
>      mmu_write(env, ext, rn, v);
>  }
>  
> +static void mb_transaction_failed_internal(CPUState *cs, hwaddr physaddr,
> +                                           uint64_t addr, unsigned size,
> +                                           MMUAccessType access_type,
> +                                           uintptr_t retaddr)
> +{
> +    CPUMBState *env = cpu_env(cs);
> +    MicroBlazeCPU *cpu = env_archcpu(env);
> +    const char *access_name = "INVALID";
> +    bool take = env->msr & MSR_EE;
> +    uint32_t esr = ESR_EC_DATA_BUS;
> +
> +    switch (access_type) {
> +    case MMU_INST_FETCH:
> +        access_name = "INST_FETCH";
> +        esr = ESR_EC_INSN_BUS;
> +        take &= cpu->cfg.iopb_bus_exception;
> +        break;
> +    case MMU_DATA_LOAD:
> +        access_name = "DATA_LOAD";
> +        take &= cpu->cfg.dopb_bus_exception;
> +        break;
> +    case MMU_DATA_STORE:
> +        access_name = "DATA_STORE";
> +        take &= cpu->cfg.dopb_bus_exception;
> +        break;
> +    }
> +
> +    qemu_log_mask(CPU_LOG_INT, "Transaction failed: addr 0x%" PRIx64
> +                  "physaddr 0x" HWADDR_FMT_plx " size %d access-type %s (%s)\n",
> +                  addr, physaddr, size, access_name,
> +                  take ? "TAKEN" : "DROPPED");
> +
> +    if (take) {
> +        env->esr = esr;
> +        env->ear = addr;
> +        cs->exception_index = EXCP_HW_EXCP;
> +        cpu_loop_exit_restore(cs, retaddr);
> +    }
> +}
> +
>  void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>                                 unsigned size, MMUAccessType access_type,
>                                 int mmu_idx, MemTxAttrs attrs,
>                                 MemTxResult response, uintptr_t retaddr)
>  {
> -    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> -    CPUMBState *env = &cpu->env;
> -
> -    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
> -                  " physaddr 0x" HWADDR_FMT_plx " size %d access type %s\n",
> -                  addr, physaddr, size,
> -                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
> -                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
> -
> -    if (!(env->msr & MSR_EE)) {
> -        return;
> -    }
> -
> -    if (access_type == MMU_INST_FETCH) {
> -        if (!cpu->cfg.iopb_bus_exception) {
> -            return;
> -        }
> -        env->esr = ESR_EC_INSN_BUS;
> -    } else {
> -        if (!cpu->cfg.dopb_bus_exception) {
> -            return;
> -        }
> -        env->esr = ESR_EC_DATA_BUS;
> -    }
> -
> -    env->ear = addr;
> -    cs->exception_index = EXCP_HW_EXCP;
> -    cpu_loop_exit_restore(cs, retaddr);
> +    mb_transaction_failed_internal(cs, physaddr, addr, size,
> +                                   access_type, retaddr);
>  }
>  #endif
> -- 
> 2.43.0
> 

