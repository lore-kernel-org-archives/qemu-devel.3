Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE04C5AE59
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJHAs-0000xD-8d; Sun, 25 May 2025 15:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJHAq-0000wk-Mn
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:38:20 -0400
Received: from mail-bn7nam10on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2009::621]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJHAo-0000EQ-HR
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:38:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0vUHvXZMmnTLcOJ204qf7O8UaKU30g46NZx8R5LMbRKdfwS7VPNI6r/z5n4y3vEBFmVXjQa+hNFNHDc6EkMj47Qg33nsFik0A+V4t7r8WRntKQv/wukU+OVmZ/FTyMih72bT/lCixC7nNYsNRHAlshP1dvKMNot+wRo7cPhtasXsPin+mHUycy/z+2UEG3g75AeoqLH9R9I9u0lDTDSyxuyXufKzPBak7me8UGHd1F9HKlYyNtRkEFnsjY/D5dRetzVfDsXNhLdAafxDCaz31jICG9wHeJt6eKF1IE0Op6lOsgn1WhyJW6FxIHADYosAkZIcltt6baFOroeQ8a4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHOH2lbMGCFfCKnDmRxLa3KSTwAethD1pcyca6Hm+dE=;
 b=T9Go4H7AEwYO/utaDM1+IuWdM2KUaxlil6cN+2NL2TF7HAbCG6Klg4fTNhOZpnvVQjntGvV3m3LW38VtwitOesior5bz1iOHkbytawY1HEWGNTQC+i9SjyXYOpPNp/1yowXMGHm4AdB6n1EenTRHjdQSNYFgJoev9fHQzxzEXTr3OR4SpA9FUmHVSTn6IWxv/aarzsXsc66dFEez8DHnE4nd1Y+qigqyFYG3v1A5ZZAFdEcoDR2ZpvjExx7Ci+ZWkaXY3trLZpKGCcguoNyM/+7ShNvJNfjePeFq1rql/BIZupjZYZf3Tfizh5BFsKprMrrdQ9Vlda0ideAdmK7Asw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHOH2lbMGCFfCKnDmRxLa3KSTwAethD1pcyca6Hm+dE=;
 b=S+oyMhsuhXBrbtyeSjMON9x3Sk0Rp++ZY9noktq4fnMKAQJd3iF9lh+bIsX7RGCC5i2D6tuW4jRnOj2uc13V5uhT+IieJY2eGusQjT91A+yY8PhwNOduyAfAiJCBheV2glNaENe4gIzo+oLxeyVZ0ntm9E4PtqiFgQKI9Ry+XLM=
Received: from BN9PR03CA0724.namprd03.prod.outlook.com (2603:10b6:408:110::9)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Sun, 25 May
 2025 19:38:09 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::57) by BN9PR03CA0724.outlook.office365.com
 (2603:10b6:408:110::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Sun,
 25 May 2025 19:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 19:38:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:38:08 -0500
Date: Sun, 25 May 2025 21:38:01 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 09/10] target/microblaze: Drop DisasContext.r0
Message-ID: <aDNxmWl8I84mtwMw@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-10-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdb94ee-6f0a-4f89-14cc-08dd9bc3ad90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5fUS/fQdQmHu2VjR6yOx8S8yFJ/B+ho/Qnct9U9ft2VQLNruQyBzKWtxwvii?=
 =?us-ascii?Q?CsT30Fuso6XFEIJdAqytvGHOJwVJ7387bL/523fhTKkGG4EsJHYBFosYQHAg?=
 =?us-ascii?Q?llqrX3Lpu6bRb0eFLz5/MSFhyZUqWA5mFi8MOkJpATyXY+dgPSM5Zt5dXYgz?=
 =?us-ascii?Q?eaHGZKWq+RBz9wihoQMbHQ166b/3jeX8j23Zor157OYlgI8ScahcZeEhidux?=
 =?us-ascii?Q?e8N+J3ytw/I6Uy59DwDVC5znqQ0elRDkcapMdnwCa0UzBMSUZxaSWz4AdLrN?=
 =?us-ascii?Q?oGUTyDji8Qa7HajYpqZdASv23mjYnXaSDGGGgAKGVw8uKQsTr73ljiduF+M0?=
 =?us-ascii?Q?NHjFjNqByKTTnyPQ/Tif/cYJREdXtGEbD13ldgHroKfkpFM/598qbRNQRl5j?=
 =?us-ascii?Q?zblxjxupthE4ic9wnnbgqHt7mOP5NSItVI9VOJaAUBJliu4iGNfTH3BalYR2?=
 =?us-ascii?Q?SYp5CHet0WY9RU/WzriqdZnES/640V0SeGsVcp1J6kSLfPLh9ZBdUfITFv9d?=
 =?us-ascii?Q?yc7B+E7q+10FfC6yBd94OQW3+pCUpvQcxYztPXjjmM2TI/V2UF5K7F8OERD6?=
 =?us-ascii?Q?vnf7S/eVRU7yE5Z5F0gQVa5lgQzeKo1lKnPO8+rb6p4h43KJE6hgA1XnM9lj?=
 =?us-ascii?Q?LHCrT+H367sjui5LbRBWkEKZmvECec2xzV3wOJT0JkgCqmk0a/jTjODS9Msk?=
 =?us-ascii?Q?1VxLJc4b3cxaZ4lgVPUN3U/1WGHBgUS+ocPlf3X3J5758HHSZN34Sz8FSS84?=
 =?us-ascii?Q?ufGBCwGin2vyfBPY5ZUmv9UV8IVtuuc0NsHBQ3mLjQnMjEeeS6BkAKvIvwbe?=
 =?us-ascii?Q?mWdCnGxmFZNokEoSCv4GekuIraPw1jmyMa3HLMCXPTmWoG4eUaLmCTwOxTUL?=
 =?us-ascii?Q?2Wb4toPbctWW9vPulJd+eb9qze65UACxPoYTvWCNdnGSH6TGnQNJom/279Ww?=
 =?us-ascii?Q?IzdetbDPgihPDeczHapqOg6GGvlUslVH5DWhlWKObOb5jOE8CZ+O12I1A6ft?=
 =?us-ascii?Q?anGaqftc+6fnHJgnxNRYzjJeggTe9QPfvg8DyK/10PKIBBPnEkD8mUnR3Rok?=
 =?us-ascii?Q?kIN0Mp57CvWgeqv4b9r2o2OE255oFIlX9pVObyqCPVxVslHRYAApG8G86/Ok?=
 =?us-ascii?Q?iJUt94gySzReCWGdaCHSXQLyGnxNlJnv0HppWGjjj1O5Aggf1AdYdS/puiux?=
 =?us-ascii?Q?I2zBtQNSHWfyjMq4rEZnarC149JBR7hWrw/voNW4+H3wR723YIqfdMK74EAF?=
 =?us-ascii?Q?cztsC0zEJoy2FNCQICHX1UGLmbdFHfZozMG4MhAW/iJ1xQAw2ld1tgJGlCSV?=
 =?us-ascii?Q?rRdCM7k+e9K2+wL4nE/7DdKiSMMeFCmtsePOAsRydDXeWG7kQWBJZAgyWd9x?=
 =?us-ascii?Q?xxGX5HVDqBHrJ6vupEbOsK5o+E7kGX068TmN0yotCgPtqjHWnOD2i0CrLBDF?=
 =?us-ascii?Q?UmgVwbX12zWXw2ujq4E+GBYwF6t4GHfatWwJjAXbeg95gAfoSA0NqhpSBL4c?=
 =?us-ascii?Q?LCSAE7uk4I0BKhh9t5ok8tFTeidSOqFNMedk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:38:08.8862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdb94ee-6f0a-4f89-14cc-08dd9bc3ad90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569
Received-SPF: permerror client-ip=2a01:111:f403:2009::621;
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

On Sun, May 25, 2025 at 05:02:19PM +0100, Richard Henderson wrote:
> Return a constant 0 from reg_for_read, and a new
> temporary from reg_for_write.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  target/microblaze/translate.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index dc597b36e6..047d97e2c5 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -63,9 +63,6 @@ typedef struct DisasContext {
>      DisasContextBase base;
>      const MicroBlazeCPUConfig *cfg;
>  
> -    TCGv_i32 r0;
> -    bool r0_set;
> -
>      /* Decoder.  */
>      uint32_t ext_imm;
>      unsigned int tb_flags;
> @@ -179,14 +176,7 @@ static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
>      if (likely(reg != 0)) {
>          return cpu_R[reg];
>      }
> -    if (!dc->r0_set) {
> -        if (dc->r0 == NULL) {
> -            dc->r0 = tcg_temp_new_i32();
> -        }
> -        tcg_gen_movi_i32(dc->r0, 0);
> -        dc->r0_set = true;
> -    }
> -    return dc->r0;
> +    return tcg_constant_i32(0);
>  }
>  
>  static TCGv_i32 reg_for_write(DisasContext *dc, int reg)
> @@ -194,10 +184,7 @@ static TCGv_i32 reg_for_write(DisasContext *dc, int reg)
>      if (likely(reg != 0)) {
>          return cpu_R[reg];
>      }
> -    if (dc->r0 == NULL) {
> -        dc->r0 = tcg_temp_new_i32();
> -    }
> -    return dc->r0;
> +    return tcg_temp_new_i32();
>  }
>  
>  static bool do_typea(DisasContext *dc, arg_typea *arg, bool side_effects,
> @@ -1635,8 +1622,6 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
>      dc->cfg = &cpu->cfg;
>      dc->tb_flags = dc->base.tb->flags;
>      dc->ext_imm = dc->base.tb->cs_base;
> -    dc->r0 = NULL;
> -    dc->r0_set = false;
>      dc->mem_index = cpu_mmu_index(cs, false);
>      dc->jmp_cond = dc->tb_flags & D_FLAG ? TCG_COND_ALWAYS : TCG_COND_NEVER;
>      dc->jmp_dest = -1;
> @@ -1675,11 +1660,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
>          trap_illegal(dc, true);
>      }
>  
> -    if (dc->r0) {
> -        dc->r0 = NULL;
> -        dc->r0_set = false;
> -    }
> -
>      /* Discard the imm global when its contents cannot be used. */
>      if ((dc->tb_flags & ~dc->tb_flags_to_set) & IMM_FLAG) {
>          tcg_gen_discard_i32(cpu_imm);
> -- 
> 2.43.0
> 

