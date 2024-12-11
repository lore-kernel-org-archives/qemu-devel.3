Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093B2E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 21:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLU8Y-0006tY-3x; Wed, 11 Dec 2024 16:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tLU8W-0006so-64; Wed, 11 Dec 2024 16:20:48 -0500
Received: from mail-bn8nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2418::631]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tLU8U-0003pi-CC; Wed, 11 Dec 2024 16:20:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDKXePh+Mr0DrnlTLEtJd9ikSpFLKRU3OnQqza40H+B/bcGk62wQwlHAJ2CWrxDWuoilFrFrGCBh7OBzCt8sTFUGzgKqmj5bpACbIOQ/HuEm2wjGfV0ymcr7vr5TURXw8rjkRGmZWUfYZ+/N9Ma/ognrc40MD+1ECZ70X5wwA4STYVEZwV4nOJYoTq3jIgobkxYBzklj/fS9XfumuKtMpwGhO8Ye8Nb3AjvFhnJySnekFJ+4HdWCQoPAL1TUJAzpzHMg0OVfYPq/6exJBjh1k9JzTXiYRi2dBsAtiIWjO3liOdZyfZMGHINNcHmqy2eR6y2pCP4aotS8XOFspE+9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaAaRTi3NLHrA0ohGquj1DuS8rBISR27gG/q9lxfWLc=;
 b=auUyWGroqOYhpRcJB1KrvOggP4llbGBDq6wyuXiq6fjwAZxAC6aYcEx+hteQB3Gx9ng1NZUoaDGneCYxFTkxolXsL3Gd1jcrZlHG9vT/q6xOGOJiGU5K9owgroJ1fhd52ohQg1+n+sjZVdInX7bcrckyeTIgVinVNoK/IlfI//Vaw3upQX92j7U8SG0IkDSOjnYwA3Bc0jOqRCt72Go2fIYAmxL+mM3Vqus8kdAVxZkZ30u+KlPiUlb09fiQ5x2KbsRRmom9tgGTA7wC8a3EsI+rxI+NbDqwvnRk+g6KxQ58FgY3IFrMZNkn5qx+66RI7iftwZAK/qIDWh9U+PxYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaAaRTi3NLHrA0ohGquj1DuS8rBISR27gG/q9lxfWLc=;
 b=xgVpWTis7Msw1eNjWM0BTrej9n7167ih31451iYt9koKRR2F9jXN6Wl0buH+EtnwfnvCcMF1ITWcxSjgJNgmchKmoYlmNmJV4iBvO70cqZdnubfiFiB7QSRxxjQ1n9vxnxHmNY2oZ5Z8o+celJYgjtn++Hq6AOr1kLFzo0pnfRA=
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 21:20:38 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::1e) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 21:20:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Wed, 11 Dec 2024 21:20:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 15:20:35 -0600
Received: from xfr-fkonrad-l1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Dec 2024 15:20:33 -0600
From: Frederic Konrad <fkonrad@amd.com>
To: <qemu-riscv@nongnu.org>
CC: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-devel@nongnu.org>,
 <francisco.iglesias@amd.com>, <Luc.Michel@amd.com>, Frederic Konrad
 <fkonrad@amd.com>
Subject: [PATCH 3/3] target/riscv: fix the trap generation for conditional
 store
Date: Wed, 11 Dec 2024 22:19:33 +0100
Message-ID: <20241211211933.198792-4-fkonrad@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211211933.198792-1-fkonrad@amd.com>
References: <20241211211933.198792-1-fkonrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: fkonrad@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: bc21a525-fb35-48c4-6851-08dd1a29a88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JMLHe6A9iGBANo0UsVxynjXJYj7vYJegRw1zEb6NSMGdV9VwySxVpknUgZkJ?=
 =?us-ascii?Q?H9kaLbD4Y91iWvl8yb4afCQLj/lzQgi3RKjstCt9VLc6x72CayUsMj2+AKaU?=
 =?us-ascii?Q?+yM4XEOTzbxK1KzdPCQNREvx9RY+45N3vJEFazR3JmTeLD1L3NF32EqFAuvU?=
 =?us-ascii?Q?bS1X/VxA2KcVFn3+FQQorm5iOXurt6er3OCMNa5aT0rxWdm41iQiq8RzjU9G?=
 =?us-ascii?Q?ld3TpG/OLR9GyJp6K5yYFLeXmW74dVK41shSLOLi3hSeb8/zBTn8t0Bo3KBE?=
 =?us-ascii?Q?FxidkbxVbYVQqP8HR8ILZoQvmHdjdbXP8x1Ae7bg7w9ybQ8l9TdD80sZrDAd?=
 =?us-ascii?Q?mryHbzv+ixzuQnR24hAKmomupiF7MQyhg0OvvaO9AsnHFiUdGDCTmoHd1q9m?=
 =?us-ascii?Q?g0pyBYifp9S/aegYRbrOI1lwRun8bzCk5FI34qMc9so2zYbwOFITlV2rlnIt?=
 =?us-ascii?Q?HYbkPqszYC7xeST+BZgb7h99fQM5rPZkNFlN2lMBAI3Tp5UJpIFnAOI3U3MO?=
 =?us-ascii?Q?R2xNqmxrd2lVSGZKsINyhBvA6yGEPoQ1BBKy92uBY36Ep2Fqhcleb133MrDy?=
 =?us-ascii?Q?BukCwVZOIwcLY4AN5dCYYIyGpNd0eQNtXoNY/lk1/52JxvsU7yEhAIeHOiNV?=
 =?us-ascii?Q?WGCHpWd6rc3QdZLbPNCT8FlIznIdJdkYeydrq/96vIURPU6XMbWRcREBAV1C?=
 =?us-ascii?Q?TdWBndeyvk5HMaUEoSDMuItFmQAIXiZooatSasGvBwpxyGM4uVyMh5QjYs8A?=
 =?us-ascii?Q?eewEKpiGs7SLwvLN6lZv7fZ6w+lIPteP4Wb+LwxVZQ6Ix1WuVGVIGZnHXvg0?=
 =?us-ascii?Q?qqf0lAFIsbwcX9AI5Rb1PTnDxZiPMqjm2iLy8tDhHX/wMpFl+Ezt6LZhBaor?=
 =?us-ascii?Q?AihwdZ0bv3R0LC+zw4wTjAUt/Okb/U2/lypL+Y7FvDYGqoriLoIaL1+SUrx1?=
 =?us-ascii?Q?2ZtF4Dol7M5Hy3lltwpYsDb93cDtm9ofTx1w/WyCLox5C/ZHRT2THvRq029d?=
 =?us-ascii?Q?QbTAu8gOzCUOWqBd3iTz0pnvcbiUIwsjRKJ7Jcu3e8KoQB1lRzDSZDoqurjH?=
 =?us-ascii?Q?CMvgPaFPb+mxes1zTz3Kkc9q/Ll9KWoKx13ygVn5m/5y57GX/NX5TIrRbVJ6?=
 =?us-ascii?Q?8V9S79/W7d5aygQIN3ULA8oE15Y88Z8BQ4OmYKYc2TovUCa2FVwTy/734nAW?=
 =?us-ascii?Q?UJKUj4I1k18Ewb6Vu4S7VSaCjmgeZg9ihUNRrHDAor5jmno3YnrkiLIJh5Cb?=
 =?us-ascii?Q?Cya6nwRVrA4TpEQ7I5bbtb48vGmBdKtTuh7ogDV4/oOkXZZNLylf4N2LlLdZ?=
 =?us-ascii?Q?NOkNBjGEp84bhH+IJy92vGYVQpaP4kWxL3SDPG2Nm0/kib7GtpotWmg6jMv1?=
 =?us-ascii?Q?XYb7GA5f3MVsYtUwamjrnnEBK4CsgQmW+60bJNAL4hXSvUrszX9mbunuohvl?=
 =?us-ascii?Q?eibZhKF/fX9IxZ3rCZ3lvbUnSkcTvJph?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 21:20:37.9674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc21a525-fb35-48c4-6851-08dd1a29a88d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
Received-SPF: permerror client-ip=2a01:111:f403:2418::631;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

From Unpriviledged ISA manual:

"For LR and SC, the Zalrsc extension requires that the address held in rs1 be
naturally aligned to the size of the operand (i.e., eight-byte aligned for
doublewords and four-byte aligned for words). If the address is not naturally
aligned, an address-misaligned exception or an access-fault exception will be
generated. The access-fault exception can be generated for a memory access that
would otherwise be able to complete except for the misalignment, if the
misaligned access should not be emulated."

Here nothing checks that the address is naturally aligned, so this fixes that
wrong behavior by raising address-misaligned exception if the address in rs1
is not naturally aligned.

Signed-off-by: Frederic Konrad <fkonrad@amd.com>
---
 target/riscv/insn_trans/trans_rva.c.inc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 9cf3ae8019..30a047164c 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -58,11 +58,30 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
     TCGv dest, src1, src2;
+    TCGv tmp = tcg_temp_new();
+    TCGLabel *l3 = gen_new_label();
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
 
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
+    /*
+     * A misaligned store trap should be triggered even if the store should
+     * fail due to the reservation.
+     */
+    tcg_gen_andi_tl(tmp, src1, ~((uint64_t)0) << memop_alignment_bits(mop));
+    tcg_gen_brcond_tl(TCG_COND_EQ, tmp, src1, l3);
+
+    /*
+     * Store the faulty address, and the actual PC.  Then generate the
+     * exception.
+     */
+    tcg_gen_st_tl(src1, tcg_env, offsetof(CPURISCVState, badaddr));
+    gen_pc_plus_diff(cpu_pc, ctx, 0);
+    gen_helper_raise_exception(tcg_env,
+                               tcg_constant_i32(RISCV_EXCP_STORE_AMO_ADDR_MIS));
+
+    gen_set_label(l3);
     tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
 
     /*
-- 
2.43.5


