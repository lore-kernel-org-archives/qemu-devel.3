Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645CBE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 21:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLU8V-0006sn-Sn; Wed, 11 Dec 2024 16:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tLU8O-0006rh-D5; Wed, 11 Dec 2024 16:20:41 -0500
Received: from mail-dm3nam02on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2405::623]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tLU8M-0003ov-Ip; Wed, 11 Dec 2024 16:20:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b22NniYzQeuNsMsN8LogO/oJul5eaGOTEUHEC1lb3RSnbjmDsNF4j5csjDZurr9Y24qNXl4dsKCee2djTbKIs7Dj2P07QeXY21Nv7coAB25ik5ywavZ8UJwbdyOjuYlg1lmj1+LPS2Myfp4xzDNE68O5rIw+nlsdNCCD51hdOlLuUjjULcpZzU6IUfyYrxtSqX+r8Zq0/4MLHcw0FBcygLHYosb7nY58MPVVAqySIog4SHpmgTgxwqfzNjUJbGF7KpF84gmpctlvqiA8/5BrSkN04X//r2A6r7qzZ+8UVCuis5U6YXiYpJe3qVwgzD2T1oAx6WrHZN6tHP9XhOkgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jlOtH5K/+On6zKCmG2lOMZt1X/u9RImAghe+h5nwXQ=;
 b=FgoSCiQA89z8dgVDvH6FnETsd4f7O+ElHWGHaLIaDVq5UujcGWr9vDtIZltPjhm6gRxb8BFWfv6zbG60V8SqTCdBuEdxr6h5HMOvxH/qTEWMb/j51+28O8y4vEfwJrhBXnjKSaU8uuvkOXFrdMJbIys3dsaTHy8nk6mgXmVCTNEzIWYc/115+HfbxI/cu9ivWhnOLTYIgE5HHiNXdU/gfxgB44vcPsCnB9bX8aIQM8/ZPfbfJA+HToW3oeaknGnv0f6GfNAtBsdKcaOmo+4+iA4/k0LifRLuDXUMB3U1VNKk5y9pO89SguUZMpmhKj9/68tUp/XhwPjboyRlbZgcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jlOtH5K/+On6zKCmG2lOMZt1X/u9RImAghe+h5nwXQ=;
 b=OxwtZ8S/7fQVzafpsogyrBXZnIB2rymr0oCq7iGb2YdpzWuDJNnLXgnXf8QKqhFgSbaAf6nT8KP2DiEX/C4PwI7NuyF+lkojNnK95gbfgcLjnA3XXIE3MYfStT7YWbY0IaI2J6D/zRQtyGLHao1CAmyXpAfeqc7Mw63pW0OrNnA=
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 11 Dec
 2024 21:20:31 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::b) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 21:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Wed, 11 Dec 2024 21:20:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 15:20:29 -0600
Received: from xfr-fkonrad-l1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Dec 2024 15:20:27 -0600
From: Frederic Konrad <fkonrad@amd.com>
To: <qemu-riscv@nongnu.org>
CC: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-devel@nongnu.org>,
 <francisco.iglesias@amd.com>, <Luc.Michel@amd.com>, Frederic Konrad
 <fkonrad@amd.com>
Subject: [PATCH 2/3] target/riscv: generate misaligned access trap for rvi insn
Date: Wed, 11 Dec 2024 22:19:32 +0100
Message-ID: <20241211211933.198792-3-fkonrad@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211211933.198792-1-fkonrad@amd.com>
References: <20241211211933.198792-1-fkonrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: fkonrad@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6f7896-283e-4855-5ee7-08dd1a29a408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UbUmKHDiqhfRK9qXkMiPl2UI9+lsXG17Pu6u1uiu4qXhWj89rTcrujFTwoE7?=
 =?us-ascii?Q?OiEMIDcKGUg/NB/aE3n9Nud2P5g2cfyBoPU2CGQozS4rDez85PHZHMoYHxVc?=
 =?us-ascii?Q?0ZP9BJpuuvY6mJORW9amBcPr+S65QkcLpKpHCeCry9emiA7e2+VAVClkmZvS?=
 =?us-ascii?Q?Qd3QM8FXtlsYdL2DpEjd1uYyAzv6RaG4L35j1yr4rUzl1YzVPPkunG3D3WqI?=
 =?us-ascii?Q?VDExz0A5qt0BannnrAuWtZyM4fCXtiOb/mesyvxJxYYgG4hfd5Z3EUuRcBvq?=
 =?us-ascii?Q?vw5c6qfZfkp9Ylw+lcVp7NC30ueMyRQIvzgB1a7EgbYRw6zlql0BmFz5O9N+?=
 =?us-ascii?Q?U3/rReNK1568Ackq3oU/fkivek3aZrWjZ69Y/W6BujNajBkq8sVeClFUAINX?=
 =?us-ascii?Q?xezUrIUxzyduJ4o1D5YhLL5F4vUjslD0MxGi3rwjSMwRdrBtUkCmAinFduQ7?=
 =?us-ascii?Q?z7w6IM+NA2nsTYnoXnZ3AMAoAS9Uzf1Ud0+yRmDpjf+Bv1T1TT2VXUBHtR4X?=
 =?us-ascii?Q?NiAnWL9T3mPPjhOjYE4gElGidemGERoa6xjglUuYRg+dPtRVKNpDMqjaTBiU?=
 =?us-ascii?Q?8IPTsIPiXBHkkywhpbb+7z0muzaoQXeC6jsMYkbFqRXUqty9zmDZMYq1wYR6?=
 =?us-ascii?Q?iIRdjD7YYRB5cIevPOLUG811jiF+GdWP+GlP9EBjj7QgbRU1JRzY/SKprgQk?=
 =?us-ascii?Q?lGjomwQ836e9wSPReq2xArs3dJbrn1Ojn7MdX9BAXpAsPUL2KR+Ix12GXw7y?=
 =?us-ascii?Q?G/HBCf3/f9cXKqiMDMp20VPCUpKZmAbZepKp71PzyGet27eUQRI6xOxzOFKd?=
 =?us-ascii?Q?ZWBq10RT6Kvys3E7WtyORzCDHoBYe2dsfb+s+c9I5VDJzx3mibUILnvNmJL4?=
 =?us-ascii?Q?tBNX4MmIdya5FE95o37WTnJy0pBBsCasC/hDJO/I4cKHC+zXxItF7mUzsUJ4?=
 =?us-ascii?Q?/NcfdHa7iQD4/gg2zLesV27AZ7EdXC811r3Fnhm8NOllan56Nf70qHl9AFMV?=
 =?us-ascii?Q?9iAoxVGR9XIs/g2QDoRFExYtZLOw3JUBy7rLbuLQJKREebXuYDvvlIk2n7mn?=
 =?us-ascii?Q?Yy3eeZ5Zn+/gea/rHBIE5MUk8udNzNkFHQiOq3UVA+SAT5MPJGx/DHHLucXK?=
 =?us-ascii?Q?O5N+Ig4KTwOp+DSwXgRPan7fDo/HHK3CCJxVyZCtEm07TaihvBgZ9FqxDG3Z?=
 =?us-ascii?Q?XsmutkM9QF9GcQSjmgq89qILDAONQN93jdyPziDuay//qfuyamrzO2R3RkIf?=
 =?us-ascii?Q?Hc9h1IMlTdlLMKjYb6J+QyYZBvFqA6YLWpRgRtSzlk+7WxoWvDmok5FaxnV4?=
 =?us-ascii?Q?Bq85llo+jQ4+dHzIOpzesDAWbsqibua0krAw3HhKyYN//7150eTbALplgunT?=
 =?us-ascii?Q?otXAOiDXp+t3vJqqxGtN66FSgHC5sPrMblJoiR7byzw15HMRhPd3aQ761S8q?=
 =?us-ascii?Q?xfFVQU2V0pYTCj/nyGvILWL/7qdonhSL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 21:20:30.2909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6f7896-283e-4855-5ee7-08dd1a29a408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
Received-SPF: permerror client-ip=2a01:111:f403:2405::623;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

Now there is an option to enable misaligned accesses traps, check the alignment
during load and store for the RVI instructions.  Do not generate them if the
zama16b extension is there.

Signed-off-by: Frederic Konrad <fkonrad@amd.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 96c218a9d7..1283207fc7 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -323,6 +323,10 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     bool out;
 
+    if (ctx->cfg_ptr->trap_misaligned_access && !ctx->cfg_ptr->ext_zama16b) {
+        memop |= MO_ALIGN;
+    }
+
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -424,6 +428,9 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
+    if (ctx->cfg_ptr->trap_misaligned_access && !ctx->cfg_ptr->ext_zama16b) {
+        memop |= MO_ALIGN;
+    }
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
-- 
2.43.5


