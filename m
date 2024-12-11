Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60011E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 21:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLU8M-0006rN-Bw; Wed, 11 Dec 2024 16:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tLU8G-0006pR-21; Wed, 11 Dec 2024 16:20:32 -0500
Received: from mail-bn8nam11on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60e]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tLU8D-0003nY-BU; Wed, 11 Dec 2024 16:20:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbumle3mnarAw5HA6IoS0sTdLGhBF+nFPFz6y+QPMuP3VwEjJQoSDrBdwyum172rgnRz/QiYsNcuKyxKI7bk58khoIfnMIJJ7veo+8xANlMJmbgGawJy3UyE1ZA92UShA4QXioGTxSW1FlnI9gGidHhO/sWAm5bHhXHuh5VQXY8/EEJTeO4hDqxqHFQQ98Or1eB0yX7BCy9Iye4frCXjvE/hu9tUBHpE72GPBC4Pnp6upUmPLLi6HmlSe8miLnV00L4uVRn/gFpI7GyCNiQ1c4xaVYIc335OaTbzmGSlsfvWFgc1CIRN4gRlV30Y/yrZcyFPFOk1JwybUz6y3Xj+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFfVfuEbS53ZsmtkqBIgnSIACUThQbtV5T06M7f+tvk=;
 b=dD+2cuMsaeWEENYx0eJ57KrzVUNPo52h43byEQe1bQlSoZFPpxpi12Z6XtO95txGHnZJZfIBk53OKtJLjybDL4bB1LKeZSfy+qpw70WxZ1TDjFKqc3AGgmAG8qtauKvtHirzWS3j/uL2WAY6JliowLoHn7KxbrYn3IG2eDgKaad5JP1VPDK7Gh76Wwq6vCUNpMGgb8ndr9/UdXnE5Do7jmMXTliEUTT1bvAN9Cg5UNWqS5zNTVQjJ3HjnjCXyil4DPOdhHIm0vjzT1sDcChUXDUHY8yPLlBt5V6W9ZO9gc4CvOVLstaZXBY1ewskpgjSZHa1EZUcR70d/zrUF6Qatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFfVfuEbS53ZsmtkqBIgnSIACUThQbtV5T06M7f+tvk=;
 b=etb/TsA9apU7BlaVQ+q1BWclOUFX44A9Jne88gDjfkI601t7x8MUyEYTscBGKGmaNi3a9lqWG6JYziKHz41kLf9P0A2lUxlFAoUJJbTA1xpWWl5uV4JNULgHDJtkQrlSqH4uXW3R3aH9xJW/YgRwBUPjNd9rLrjcBSj2Xawvl5Q=
Received: from BN1PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:e0::19)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 21:20:23 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::d6) by BN1PR10CA0014.outlook.office365.com
 (2603:10b6:408:e0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 21:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Wed, 11 Dec 2024 21:20:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 15:20:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 15:20:22 -0600
Received: from xfr-fkonrad-l1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Dec 2024 15:20:20 -0600
From: Frederic Konrad <fkonrad@amd.com>
To: <qemu-riscv@nongnu.org>
CC: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-devel@nongnu.org>,
 <francisco.iglesias@amd.com>, <Luc.Michel@amd.com>, Frederic Konrad
 <fkonrad@amd.com>
Subject: [PATCH 1/3] target/riscv: add a trap-misaligned-access property
Date: Wed, 11 Dec 2024 22:19:31 +0100
Message-ID: <20241211211933.198792-2-fkonrad@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211211933.198792-1-fkonrad@amd.com>
References: <20241211211933.198792-1-fkonrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: fkonrad@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d587469-8d12-4685-c6bd-08dd1a299fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?umf5xu8fPjbPy5cZ8GgflQrAnNIZY21qdRmZmcHfyaCoaEsxNlgUKqxtVJQC?=
 =?us-ascii?Q?QKkWHMBmTEbk+XX677FJNW7gr6QZGXk6CxzPc25sZLMWeX4AbQA6QwJQXX/t?=
 =?us-ascii?Q?1WLtyp0+h8ZK55BSeBuJgw4RGjuvkLV9E2UP33bq7xE6qT13qdu1JlroHRnR?=
 =?us-ascii?Q?xqRukaSXtVdWG5NVfzr6ZZKDjF5QJvVga1M9yNZuik6B/23G+scvk/rdE+Yq?=
 =?us-ascii?Q?ISgJoqFXZQF7evudBmQCRNzx710wP/PyFyywIjKuT0Vb2XwJXE/8zJXC6+R0?=
 =?us-ascii?Q?o/f0WhAg5DvjvcJa0klVZiIEwKqc99LDWE97uRUcxUFbWPy9U1PJKVFr+k/i?=
 =?us-ascii?Q?R4zLO3Me3eiZhlD/5iP5E8gpDdYoHUL4g44eiM4nL8gNq1l0T7RQk6g6HBih?=
 =?us-ascii?Q?iUEhFyRZT3EWiTgS55s0n2TP8PdYJEllafk0GBkYC58JSIyaCrsiS7DBQ0fq?=
 =?us-ascii?Q?TuvwDmcO4r+k8rUYBVpg2QHiEKXzUxxJi/575IOFoOOK0CFM0wAPgmIE6dhV?=
 =?us-ascii?Q?RrQr5GCXfy1y7WVP9dZNDONa4vlRN4YuMsp5ksCllla8GvgBZLbOUP4MBMKF?=
 =?us-ascii?Q?80tj3k4EG/f1gpPCgTxdrTcVn8x9veEJBEUXtcyQFtfgZiLFRXjXIRVc9KVB?=
 =?us-ascii?Q?ZFXC7Nwn2MlyAQe0NJdVfu0tfVbFIFehjw1R5O+V0wVQs26OEMkT/M6mefWw?=
 =?us-ascii?Q?I33zLzNIlTBvcDonmajH3usOqzaMvJspQjFyQ/k+ds0GJkT7KSZAiYrsz9EW?=
 =?us-ascii?Q?K1umFZjZYj1autpe+3ODdoRn9VEvZyfqffH0JxgIbSJYm4AOE+KbEnM8XTNX?=
 =?us-ascii?Q?MUeYx12DQHu9VgC5/WqCPCG6n8jXGhTOphkBoDfc2J7cQP14xlktuF4uNZU6?=
 =?us-ascii?Q?lryBTd3OjPiF7F9H9uTJcHahh5IbJ4uIyybyYOi2h4cQq+NTbo1IsQA5x1TM?=
 =?us-ascii?Q?B6jP2gEWyR+JLiGtTg/fJT6GUFaGaxfOoUc4CMRfgWPLg2oslifMjxUjtnZD?=
 =?us-ascii?Q?b07CprYDlaXPY5e1LkgZUBjiHXz4TNvpq1nJh0EtYjd2BVqVgnKbQYqUaklx?=
 =?us-ascii?Q?obrw1kj2dCIH6+UhcxSl/1tJfcsP8hUXVb77vuCW3fPNuunVUcotN83BWcf/?=
 =?us-ascii?Q?H4Ij028mShdcKFlMUXIb2q9aRld7rSrPtT8XmmYUcxzw+9Q08YfG9JuZSvvv?=
 =?us-ascii?Q?2qV0B5mUQ4REeKRJzpHNV1e9jLfqr1AEqoDllsTqwNLW2WU5LhbydklQSJLV?=
 =?us-ascii?Q?KQMyVnMU1m1QNEv1+NSvC1MZvNzwJ4XyRaSy6wIYWb5z89kynS6Ki2gc/P49?=
 =?us-ascii?Q?4IW74dauRRGhuflmeQjfeyBhjHW4nQAVQrcSP5dRuyMjUjdPkARnDQ6Fvs2F?=
 =?us-ascii?Q?xtLZO1cO4b9Nnx7mMhhd52uIsIR/Yq0CmYqLORSxwOm93O42mHfVSqJyFFWk?=
 =?us-ascii?Q?r4aG5V7/FxJHo983PHhBSLSixChhnAOT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 21:20:23.1168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d587469-8d12-4685-c6bd-08dd1a299fb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
Received-SPF: permerror client-ip=2a01:111:f403:2414::60e;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On riscv target, misaligned accesses are either authorized and implemented in
hardware, or unimplemented and generate a trap to be implemented in software.

At the moment misaligned accesses for rvi just succeed, the intention of this
new property is to let the user choose to have a trap when a misaligned access
happens.

Signed-off-by: Frederic Konrad <fkonrad@amd.com>
---
 target/riscv/cpu.c     | 5 +++++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b5..1696d3db2a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2697,6 +2697,11 @@ static Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
+    /*
+     * when set, misaligned accesses will generate a trap.
+     */
+    DEFINE_PROP_BOOL("trap-misaligned-access", RISCVCPU,
+                     cfg.trap_misaligned_access, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..cc560371a1 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -173,6 +173,7 @@ struct RISCVCPUConfig {
     bool pmp;
     bool debug;
     bool misa_w;
+    bool trap_misaligned_access;
 
     bool short_isa_string;
 
-- 
2.43.5


