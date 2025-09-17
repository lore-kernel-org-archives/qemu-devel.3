Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76001CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqfx-0008RW-0F; Wed, 17 Sep 2025 07:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbY-0002os-8i; Wed, 17 Sep 2025 07:45:46 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqbW-0001uo-99; Wed, 17 Sep 2025 07:45:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjHTpwBEmVpOpxCkYRYt3HF8oxH5p80Qqeu+qH2OACd/At44Lv7aLeS2ppmQtjWspYjRmvGz+dZonN77xTE/GUOvcrsaz4TpWKziYqVQ/DUQS5g1fSgozApVZxUkxSZdnMhoAw4mL4de2Zth5ZGi1U2SOp83uBFIj+np4xeod+zSWW6LYMWb093VXb+LQw7UMoYanVcbGRyizNpkLNetNtYx20oMtICMGxGtbLeipA0SwIeMHZvK31+NFFDgIJtm8YyY4OhJ7JRG/9Gk5Kh3aaW2WE/Gh/iIPa3SyafFPFES3m+IpQhN/vnKuAFmb6nLvRcK4wqKBh+2h6BZrJSILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZora/Zm43hZ9643nj+hTtT2IUx/bOkEz1T3ktd0VFo=;
 b=ptS1VYrd5ALU/JAslmO+nzLNDKWiBF0+EtO47vt3a8jj9gGeFpQwBki8HJukZHkv5eD+XhnS9krnUyX70e990d0gMElhwSUNYd4Jk5b8nrv7wTZjD7VRv2U/Kl6/1Y1qhaC6BkMKjvL8QngesTF90ayM77UC0vpLkephukJJ7ppIXfQxO2MfKT54LkRdBFIDhdfNpoIjw2D8rWKoYk+wk+mZc5lgdEBxuDBwNBKXzu6bfSr6wch7oElgHnfmev1bWrISmdKAVQqpyZJNmZM2rEpbBQOytmIjGuxFXtoWxeXSofPqkVRaN1FeypRx4BYagKOO/NDnzIXltctg1B3I7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZora/Zm43hZ9643nj+hTtT2IUx/bOkEz1T3ktd0VFo=;
 b=uF/Kr8adLD1H137VD8JLJRMdGCdGN5LRUk2OlNwlux0aV7hxOGZwaTdY6OKNMLw/F2pWtr6pzyX28CvrLyemKk9tVhhMPvUp+9I68pAUSJF99c1XY32GZWxCd3g9BhgC3Rh+lFWcgtSzxjYd8DE5NO52UFjG9/pHW8b4RfMZ3TE=
Received: from SJ2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:a03:505::7)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 11:45:34 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::f7) by SJ2PR07CA0014.outlook.office365.com
 (2603:10b6:a03:505::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 11:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 11:45:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 04:45:12 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 04:45:07 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 17 Sep 2025 04:45:06 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 4/7] hw/core/register: remove the `register_finalize_block'
 function
Date: Wed, 17 Sep 2025 13:44:45 +0200
Message-ID: <20250917114450.175892-5-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917114450.175892-1-luc.michel@amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3f1090-fc67-4009-8522-08ddf5dfb5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x/iHGVXAzN7rjfWQm3kkdrsOFCeSLEnXYEUCGrovXjdJf6u9c69CkzhddjGt?=
 =?us-ascii?Q?FlmnV6ON8RSrYWr/5rw/IYYjdmNEX3o9A2EO09CG/yBuz69/vMbAEK6dcjKt?=
 =?us-ascii?Q?d/UNG1M/+4p+tS8XBJfYfsmLxTPldDLvIDAFQuTkPTOW6JcueYOoqTEV5kMu?=
 =?us-ascii?Q?lRcbkdGwS5ywRBTVkIWiYq7TXYxE/L3chJhEeXCeGiJ2YdLlhCtOGISeJjtf?=
 =?us-ascii?Q?J7mNESdYMfI3Hwdo/5yQ+5so7hNpSJYI8EW/jP1SHedODdr0laF2+2J/Tdxi?=
 =?us-ascii?Q?x0/XpLFoEB3J6NeUlXaCgFFCKQQLwyKIFUIPu0hEcFCyP5jdBfz0h8Sq7h+E?=
 =?us-ascii?Q?jqiu6kEIgtvSwiysoZagF4zXPhJT7KA1PHDKrtx/HaAheHnmUyQxvTJJklwe?=
 =?us-ascii?Q?kjyuMQ9OqrXfeh6Gtz4NIRSEDcK8ydrGthMz6p4h9X78uW03krsK60qLF6mh?=
 =?us-ascii?Q?9VGFmoGPbna+scV4bVBO0JVCqP+g8Y88YZ1o1HKF1vYnL7o2UW8FtLpthoDe?=
 =?us-ascii?Q?2KMAYTEn6/Iwor24SFr+xc2o2KDLUGI4NTZrbqZrk2mBdrBh9zMF8kH8AfpE?=
 =?us-ascii?Q?lAKSRzbOaBTrv4EQRoM3bokVIqU259JtMY35jrHJWzW1W69JLJsQhnllW7tO?=
 =?us-ascii?Q?N75VLfIiBNWyNpvuIpxArvUuvHD3sgTamV9UIy3V21fYO8POUbdqFnvN6cOV?=
 =?us-ascii?Q?lRdXMdfZToHOxu6pQeHqpva8roPTbwF1U0qL8/Pyl3por+2CWGVQQN26naTa?=
 =?us-ascii?Q?AfPlMXVyWnYXxHZTgzMZMgaaqgtRTQBaYR+FAjNPTlOzfxiVSQfJ+Us/u+24?=
 =?us-ascii?Q?qgvMTy4bSf3qubx7AV3/ANeEFTD2ylyTIe8DhzK2jslfAMhqAbRmZPVuaUHi?=
 =?us-ascii?Q?bto+jPqJ784z19CdqQz+dI5bwrlqsZxC7amVec2ySlZ/BHt+MWrBLElVEnTm?=
 =?us-ascii?Q?KuPjfdFovEVM2vdG37KldUOYKSldJtxMigbu0wQd+WLutsMgdu+cW06G+/cN?=
 =?us-ascii?Q?Tk98YXFpe3dwEjainjUYbtpGiLs0/iSHQZhFMsQtbBMTfgv5oPVZu0THyNBo?=
 =?us-ascii?Q?NtlmoVW/8BfJcjx0uc1/Q/3iBV2/Cp0p8cOwVS3z+x95SAo9Kl6XDWeK5SoM?=
 =?us-ascii?Q?gEaLIPKGA7Bxb5JttlXWroBJwybwuiA68Hm7qO4clkREsGIfwNfJzQ2ERTeX?=
 =?us-ascii?Q?In40vTmEWiJiPpvrAC1aBN95dsNxyi/RfsSz/y1nH4Yh1YZc8xo5MFXa8KSG?=
 =?us-ascii?Q?gsT3FGVhaz6qG04alM0ktzgvKjILDBnrVqeyVLxEnrdecYpL3Rux79wQd9xd?=
 =?us-ascii?Q?ztv4huTZXSBnhFpIAKlqmRG9zoQ0YRx6xOmFNYsAI7UzOWavqCtP8qj3d2q1?=
 =?us-ascii?Q?dLtrDZ6vOw+bQpD8jtfd2KoxLDUnBuPw/OVFxaH1DCFAhOJtHT4O88JWDUdw?=
 =?us-ascii?Q?jPEhcPpWNYJM2+LoV2lRPR6ny4yY2rI9KVHao/KNWKGLW1chdenEdhVIJEms?=
 =?us-ascii?Q?+0qnrySfFyRIa4osv9ULa1srdq15Pdh8xDyz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:45:33.4613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3f1090-fc67-4009-8522-08ddf5dfb5f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Luc.Michel@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This function is now unused. Drop it.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/register.h | 14 --------------
 hw/core/register.c    |  4 ----
 2 files changed, 18 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index 65c82600e06..7b0f4c8b7a6 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -207,20 +207,6 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
                                          uint64_t *data,
                                          const MemoryRegionOps *ops,
                                          bool debug_enabled,
                                          uint64_t memory_size);
 
-/**
- * This function should be called to cleanup the registers that were initialized
- * when calling register_init_block32(). This function should only be called
- * from the device's instance_finalize function.
- *
- * Any memory operations that the device performed that require cleanup (such
- * as creating subregions) need to be called before calling this function.
- *
- * @r_array: A structure containing all of the registers, as returned by
- *           register_init_block32()
- */
-
-void register_finalize_block(RegisterInfoArray *r_array);
-
 #endif
diff --git a/hw/core/register.c b/hw/core/register.c
index 4d1cce02a55..6cfcfcd2b14 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -321,14 +321,10 @@ static void register_array_finalize(Object *obj)
 
     object_unparent(OBJECT(&r_array->mem));
     g_free(r_array->r);
 }
 
-void register_finalize_block(RegisterInfoArray *r_array)
-{
-}
-
 static const TypeInfo register_array_info = {
     .name  = TYPE_REGISTER_ARRAY,
     .parent = TYPE_OBJECT,
     .instance_size = sizeof(RegisterInfoArray),
     .instance_finalize = register_array_finalize,
-- 
2.50.1


