Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E13C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3Gn-00086K-AH; Fri, 14 Jun 2024 05:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sI3Gk-00083Z-0U; Fri, 14 Jun 2024 05:30:50 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sI3Gi-0006xU-2k; Fri, 14 Jun 2024 05:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIEi3aYnoq2PDb0U91ltYlXPQ7ik2O/343krm3mcpm23X8z33wJDcowUB/OIRve4riBqhegarEd3VvIuVaW3Uae/ChNHQiB7+kVo+pcfe6JwXg8HdYXY9jhD9n3WDgGzphtjqzPBnozv3EOKsKV53ax2hbfB2wz8BUJ9BepboVowgtS3rVCcqPLGxWoYSvSKhA1Sub8scdprwgLw9a9/H2taetmL8AHZ1runNljQ/SkasWwH5n+ndQw2k1fM1174bDX3Pw9mEgLqCapnRf1VC8ytXdOOlHuDwPBeNBY2LR6aWDd+PNB9+FH9Cx5jOQJSQv95foSVavvpWMwS9AMW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udtUchIsxwxkw/3XJEDNabne9cLfPaVqH43DRZt+KSc=;
 b=dcjnhiiBT+PGa62Ece65jdE3rUOKAze2PTwqHpftACeVkpdEs54P/FkN0yPNFh7mDDiQAakiT1cDo5foeif8J94LprA2xZXSLzSUyeq5m21H9boPyg1NNN5h2Awk6iuoy757+kg6ov106mUo/3wjMmjuEV4b5nAmaWKy0LNsnTw82kjjwjyfU+CZojY71oLJ4xYk6ONt6ZpulRwUt+SnSY35gc4h7DLGitslZFu9RodIpa0GpclnZXUa1fHyMwvalBxxEvtwF5WEEdCAFSRNvKfXrclLTmMWibJqdfDlJb2uj1lO1Oh4HXRaJYtkzXDW6wVCtoin0gYIYvBsLXaaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udtUchIsxwxkw/3XJEDNabne9cLfPaVqH43DRZt+KSc=;
 b=rJvBO3+hEI90r8oQvYlq5S0JAhsSr6SZSuT1/tXpqeUanCoZChIKfiRG2rg0Z74nHPiFWP3sek8nKvUedNfcWdKrEII9lLO0aFe2WDaZSn5dmdmdUoifdjWMd7bcoCWFQBwWWvSFatACnWdIkW9iLx3JjbAbVEiKW4C//X8zhVI=
Received: from BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 09:30:42 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::ed) by BYAPR01CA0026.outlook.office365.com
 (2603:10b6:a02:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 09:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 09:30:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 04:30:41 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 14 Jun 2024 04:30:39 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>
Subject: [PATCH RFC 3/3] target/arm/debug_helper: Add fieldoffset for
 MDCCSR_EL0 reg
Date: Fri, 14 Jun 2024 15:00:26 +0530
Message-ID: <20240614093026.328271-4-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
References: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 428bbfbc-6052-43b9-92e2-08dc8c54a91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230035|36860700008|1800799019|376009|82310400021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PK3mDgAP8y03dU8dUhK7qmWMSoMHPxDv478xEsK8pdO45DTAl1/c0x2my42y?=
 =?us-ascii?Q?Q09ZDcfH2QeibkCwdsM7q/tEYFiFRDXRgsehJTfEDi/RpHkU4Kz1R2yYjp1A?=
 =?us-ascii?Q?CGq1ZkxoD18c6lUQ/tjG8ra6DwxPwxcTMGrtqmSEgHgPMd3c5Yr4cVF19wXl?=
 =?us-ascii?Q?pSJ8MKoNoONKyaPb+0mFuRdGl+qu8/65JWDvXmQsIrgnO4ezG0zP453D3yMh?=
 =?us-ascii?Q?5aDURl3QpnjNAvNR9Qft1y045OabRKcr/mfnUmxRhKJ3loyhFHpDmq4d3q8C?=
 =?us-ascii?Q?yt4oRjGLQdrzydfXwcOJhcVLyi9SC45xP1HF/Up3KX4mDvfQkdfGfDojaQ4b?=
 =?us-ascii?Q?GQmXJP3EeFRaQKmvxIfZfyim2Bk30l2bci1mjq25sccryGCDnONnS3F67zTW?=
 =?us-ascii?Q?703YMb3qL4uuZcgaDPckyfuLeMoVNUAafltN2eq9trbVZRkY5vh5mbET27dz?=
 =?us-ascii?Q?JCUm5iEyHQFmlFb7XP8ugqRtDkC8YEBvL18/Zu5UwwsouLODptkZjLCK65/B?=
 =?us-ascii?Q?I/Y5RlNHoLW5/9BAmwCTul9caVmLY/IIoQiwDD4VOh/uv0RS2ZlR6EMvbq3w?=
 =?us-ascii?Q?h7I4ZFc9uX8YXbLcaJzgsSaseyxmkV08od3SH6y0ejHzoubmT/o6LOIZaXtT?=
 =?us-ascii?Q?qOM+Rw+D7WBWiiB6Mhb7uPgFrjMhOkP2yjERVOMKeEV3L4Ah3t3LoUMyynBi?=
 =?us-ascii?Q?VH1ZXW7vz+CafYPAai3sjXjyr3d2CADoaiXwZyM7KuMmz9n81QogYoT2B3bv?=
 =?us-ascii?Q?n1MWIci+EWClC8nTFJ8Ouv9FiObjlHC8eNqpin9WFCMsiyt4dZyyB4X3EKaL?=
 =?us-ascii?Q?pzRH2lhmex8GUwWZWUuO7I124tMmxnv+i8tTHq+BPgOMZMMhCUOkABOEExAr?=
 =?us-ascii?Q?8nEuJsFNEtfEWocwI6x5mnfbyJrj8CW1Kj0KbdBOxtbZ1ge/YAzxa/lS6x8N?=
 =?us-ascii?Q?rVQjuWVeSTm8sSSRDw2tFqauNElJaqZMWE6b9mC3ony5pwLaDUczpYYvo3dW?=
 =?us-ascii?Q?7Q3x/ZMeduhwxv8PqBKkgj6h5zGBjtdrSqDZAMdnl8B468JUVSj1RHRX1Umt?=
 =?us-ascii?Q?3AjEpYEho2M6vnKv+SfdzqqJ14KQHlJFcnYhXOYfEfLWVaCDB/rLZBvVy63A?=
 =?us-ascii?Q?v+POn0AtMGeVWMxDRK1IdCPUG7NU/VTu3FylAper4+aFarXsSfo7NwLg3N6w?=
 =?us-ascii?Q?BxUOCgreCVZCFjhD0UvKATnmotpqtpMBS38XwFFeB/dHUh1NpmacmfI3KDoC?=
 =?us-ascii?Q?DcFM7StGbIx+Al5nB6HjF0/khbFydLQaVadBYV5bW0s0DNd+abN5cwBq208k?=
 =?us-ascii?Q?ik3fdyMjfPEOf/usJO1OlY+NYBt7ro1RugK+8CBWTuZx6X2noBFmlZ05KD1X?=
 =?us-ascii?Q?CShO7X2yRsRy9vtrSQ2KxotcGSV2ptN5lPTmFm0M4OnRT7kBPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230035)(36860700008)(1800799019)(376009)(82310400021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:30:41.9293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428bbfbc-6052-43b9-92e2-08dc8c54a91e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
Received-SPF: permerror client-ip=2a01:111:f403:2415::601;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

MDCCSR_EL0 is aarch64 varient of DBGDSCRint, so utilize the same cpreg
offset.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
---
 target/arm/debug_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 7d856acddf..5deafa4d1f 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -970,7 +970,7 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
     { .name = "MDCCSR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 1, .opc2 = 0,
       .access = PL0_R, .accessfn = access_tdcc,
-      .type = ARM_CP_CONST, .resetvalue = 0 },
+      .fieldoffset = offsetof(CPUARMState, cp15.mdscr_el1)}, /* Xilinx */
     /*
      * These registers belong to the Debug Communications Channel,
      * which is not implemented. However we implement RAZ/WI behaviour
-- 
2.34.1


