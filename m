Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6D7C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJH9D-0008Eq-UY; Sun, 25 May 2025 15:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH97-0008Ed-QR
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:36:33 -0400
Received: from mail-co1nam11on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62f]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH96-0008SZ-1i
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:36:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf6Jblcato3OrHJNzBh6CbkAK+zN0gqMXaCiWFTwIdrbgYJc/2Sso7tFSLUFZD3rvK0i+Iq+drT7qFkUmZNOwCb6YqwMicYxm19ttiYLaOR7kAi6ZFByZ3jZXJH0c8SN3+HsLjw0IVCwPRVzkQluYu6JTnM3RHX47DPv/F/TkCAUKMewoaZM3ZQbeg8Z6ZKpvTJGS05f9xrCGtD4EVV3sfGKnRwVLYs7pAOTXjfGwKuU2zRtV6I9rw3c+zfBOIzXgvv5nJIe6vmxeQh+r2ySmOohH5SgYEmEqLg/bD0j7Yoa2lrrHX0u2VGKeLylbWsNp1dGvbsrtikKNN4wNMPFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bfcIQu+v0RMHM7B0kaqKOvQH44wVmzA88V9Llnj964=;
 b=MWypKmrd1QbHdCLXmf11SPbk7313jmCJsak81Nz0b/KtfzTUInAOM84m/c6EZigLdd38DQgnscitemnXnJWmKaxV1T/91iZU+d/Hd1wNqIxHrglJJciIDQtNeO5sQgDuCezhVtH0S5uCgr3C/fFpoSP/In86URrjksErEQW7shht7tq1fSgbWT29CQYzY4FxHlavL94P1DJxpw+KkSsIyoisGOG0eh8Oe7OBx6TF/b22LLrvf5ceif2GfsFyl5TgMdeLxRMab+ZnaVDugh96NlrIMlbD5IPolXYVUvgC2M3bYwUcTSNCEY6evG3b+22r8t0ine3em+eNMvu7Z5pbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bfcIQu+v0RMHM7B0kaqKOvQH44wVmzA88V9Llnj964=;
 b=rPmEMfgnd0/dTWg/yB3nW/xzv95ajag1os9b+wlWwluzGVXJQ2+FCeyQUtOBOABn/2zkjNM/h4KjIWa9B3TKd0Qn/dZE807feSdPu7wcfwxNDqEQM/wlfPPAlYX0zOlhuPERbx8V4LHo59Kqr6TpkwS45aFoKepPjDniAWFISck=
Received: from BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::10)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sun, 25 May
 2025 19:36:25 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::17) by BL1P223CA0039.outlook.office365.com
 (2603:10b6:208:5b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Sun,
 25 May 2025 19:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 19:36:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:36:24 -0500
Date: Sun, 25 May 2025 21:36:22 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 07/10] target/microblaze: Fix printf format in
 mmu_translate
Message-ID: <aDNxNs8zjkvrcQfS@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-8-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-8-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8dfb84-119c-4c19-0301-08dd9bc36f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6IlwXBBGSfcXeYMXfhfMfVulAUNtkXvs4Bz/vxNtd0gyIPPCmUeqcl0XZsFw?=
 =?us-ascii?Q?8kbZBTFEWaMOIXpn4f6+T3ZOFhP/mUvKrkcohT0x7dDxuU28kMV0csf7WsZL?=
 =?us-ascii?Q?07I3gnBE6RXoleskW2Nu/yQItvzGWV/YI0IFvDcVsLLsAGCmZzFHMi8wm4dz?=
 =?us-ascii?Q?izeQjLZkzK74ZKfsc+MxW7l49CRDXaoza2h1kUQYRrl80IcJKray27libiOx?=
 =?us-ascii?Q?oNhZS07+A6V82ZvrPcKGFYRhjPTLQXiytiH3LKC1hQkFzPve9kAvQsfUDTGI?=
 =?us-ascii?Q?K3/e9JLxZbQ/yXK23yFiZSN9VlEChS6MOHDTU032ljm2QB3klAf85FDz2g1R?=
 =?us-ascii?Q?FxC3jEuUd4rWOaJzResnN0HQNd+rX3pjnqla+upFBRFk8iPGGld6czK8a17g?=
 =?us-ascii?Q?O+qB6SzeUBPd7Vshf09aTs/Gm+vGJFba956StUV8kG39U9odq79n8ya4Xiyv?=
 =?us-ascii?Q?FymY/70xroh0E0f2rwqGNv8htWk23rdKTipMhzBEEHlMySQMakPfyaAjJ9j5?=
 =?us-ascii?Q?nwzKXzIFO5Ay/oJHu14PQqpJAziF4/1aJEQ9hWN87admYBSQKjTh3ldyqfyW?=
 =?us-ascii?Q?7Xx8F6iAWr1QpZ1YWeXYT2OpDm+XMLQJ31A7JaO21Pe6tuu+tkD+vlZzIOvn?=
 =?us-ascii?Q?N2lEldvkM2JpWq96v4psC05+N9Pw9Ffsgt5sWrzfOW6zT8km1kGymP88WRJF?=
 =?us-ascii?Q?CYk7WoP09ZCaxwE2NL8m0VPdJLGjb/EZpyQSwqTS7Ln4vbhlYN3dx2vKiEdU?=
 =?us-ascii?Q?FBkrwjm674OpiqP7VopA9VzZosMDdYKz3ndULokx/tIa8wC/2jjRWDcWJiR/?=
 =?us-ascii?Q?jlAjibhRGXWPwriMtDU84yWeh5FoB8pdOkTubsPwPGSRrOEHURLMwvvTTXhg?=
 =?us-ascii?Q?MnbbI0EQ4DIHMqnD1k4Z17SKWx5273V6eoGZtaDCmYdXN6sgpyCjJ3PlqAgZ?=
 =?us-ascii?Q?KnKJSLVyhPj+NlIb/7H6+y/iH0hkl8uRKkzcaMbzIy5fZW12rS3QApXoSScQ?=
 =?us-ascii?Q?ow0KBUsrqBh46h6Cw4y+TiIfWadEPPG2Tosl0O+ai5oeouia/ob1qlg2T4Li?=
 =?us-ascii?Q?vWzsY8Q0chfNSOI3+b7ya3LzuqT97npXJKnoOEGH/7r/sUivRLGAG/h04HGZ?=
 =?us-ascii?Q?K3W3gkov1XnAuFrW5fPDkqZK05H6/guAGOCc0AUjCyW3o3Oq9OGDOouXcWAH?=
 =?us-ascii?Q?12lGtlrr0S6Pt0EPU0ayN0+jsbK5AjZxNNwN6qyJXcveMsjqMRGYbrNwh+5z?=
 =?us-ascii?Q?ruEnaH/TUbyJR8gq6CPR7K6mRlPfP4Z6jnzHua0wBWM1LOX3zWewrKdirxeL?=
 =?us-ascii?Q?TA4yX9QCoaLvKYO6zvt6nWk7O5KGr0wXyewQJCnf9mpIVCh2qqCeN4z5Nc4J?=
 =?us-ascii?Q?m0y3t+BCAuso8Ks53gRR8iIaVK2BM6qSUr8PygFLXT6RneTezvMgRA+rjCA8?=
 =?us-ascii?Q?BcfYaBn15MjKjb3B7zug1CNEf2lJ2IqekcwYEiFzikCO035/XcC7LLw4YeVC?=
 =?us-ascii?Q?5d+Oa/XPhMU98/fi6fK238d4DFsBrzT5FUf4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:36:24.9000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8dfb84-119c-4c19-0301-08dd9bc36f95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9
Received-SPF: permerror client-ip=2a01:111:f403:2416::62f;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Sun, May 25, 2025 at 05:02:17PM +0100, Richard Henderson wrote:
> Use TARGET_FMT_lx to match the target_ulong type of vaddr.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/microblaze/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index 95a12e16f8..8703ff5c65 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -172,7 +172,8 @@ unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
>      }
>  done:
>      qemu_log_mask(CPU_LOG_MMU,
> -                  "MMU vaddr=%" PRIx64 " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
> +                  "MMU vaddr=0x" TARGET_FMT_lx
> +                  " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
>                    vaddr, rw, tlb_wr, tlb_ex, hit);
>      return hit;
>  }
> -- 
> 2.43.0
> 

