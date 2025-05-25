Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71103C5AE59
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJH8K-0007RH-5a; Sun, 25 May 2025 15:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH8F-0007Id-KM
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:35:39 -0400
Received: from mail-mw2nam12on20602.outbound.protection.outlook.com
 ([2a01:111:f403:200a::602]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH8D-0008Pr-Hs
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:35:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy7+AJT/nUZctyG65PMZUyDP//lk/tY+g9ZoCapsj3GRX+ueeLH0GbpZGPJQK7HBBjnBchHfZvCX1eyc5KtN3RtEsFnFEokUROeL0q9i7DvsZLcrLRseqiBZL8FVF8iaShmaiNPbIRaJkGk+TBcSr+wSBbtOhg1DLOfSrwSNwBgt/b+vENDirsK4xGPiEEwaxU/tanaD1U9Mw2t6CGKf6HR/s5BeHJP9pRI+BZ0lRmLhra1Yg5UOWrIWseOj8INzns4m35dJDCHhp2esx1yPzWUplp9YkKJxNuhraP/lEXZvHQ7JVUy9u4U4oX2jUHMXMfHUPAKwRR4q2E4GpvsePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY8gGmtJTKohbWpxVbUZXe9sF7YH2b/bHxdmyvflfro=;
 b=FdDBvdMvtSodUOXmBzfvp8d8cQJL+/sxxS48kwCz1wsapnndroJK//g6IrkO3y+HRlvwMYqP5Qvpdh/gBQadrpKr8FQmL7k+IBlCNGmOTKWuz6k31oYn7qmUDpAozTzzouypWYCkCXNtp8LbNrFZe6S+NbXjQT6rVV5JEjgdbVGtAjRZWiQXuACXZ7VHkPT7zsK4f8WKP8hbSqrWd7iHC+VpKv8Z0ODUzaZ5IHDmXIvmuz8x0MGRRgEszJSqlqul8/c/c+u9KvdYzjFQgt6JzbEy5AYjmofjx4yo5nwh9ty8kd/amZKPpAvKmmq+SAgWRZ1sde80hUNpvSHP6Kc26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY8gGmtJTKohbWpxVbUZXe9sF7YH2b/bHxdmyvflfro=;
 b=WSBl/k8k0HkamekW1m6yrrI2Y1aXKm3Du9/+bNMxaN4y3eTcRxXFx3AwiiNMvEbv43uCFhHkP8Ss+evdiBnscbdSs+hRx0eDeHQzSSOHVbg9HqdwRjvOTjlFwXGbyMkRfO4iV285RTVN5i0/dzzLocDBcQn0hxcT+XR9Llu6D10=
Received: from BL1PR13CA0418.namprd13.prod.outlook.com (2603:10b6:208:2c2::33)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Sun, 25 May
 2025 19:35:29 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::b8) by BL1PR13CA0418.outlook.office365.com
 (2603:10b6:208:2c2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.13 via Frontend Transport; Sun,
 25 May 2025 19:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 19:35:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:35:28 -0500
Date: Sun, 25 May 2025 21:35:26 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 06/10] target/microblaze: Use TCGv_i64 for
 compute_ldst_addr_ea
Message-ID: <aDNw_uoL1BDVpM_Z@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-7-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d150c23-7d5b-48d5-40b4-08dd9bc34e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pYeEkCKkRZXG+FKUpv6ba5ZAL2xlAUe1X+0e3tw54ZiKx41JcSWEJ3mVpVjU?=
 =?us-ascii?Q?v5kejYo/EggD/M2IrwfoqYLLMbMowgfzCxuHAIidjdNx6YQAECw8730kkeTZ?=
 =?us-ascii?Q?eZ6b2e9r+CEpUGhxMZ5D6T67hoThmpanz23BjD5ZVlciKMP4NrVX6O/9Y53T?=
 =?us-ascii?Q?DMys7FXIVVxgd1ZLPJ/G41Bk9Qy/1UBv6KaRZZY+mhM9zrWreLEuH8EqsDXO?=
 =?us-ascii?Q?nO85CQjP7o2mIAcQFuEKiRFpPyP7+CDRwiej67sc7Bl5cPNz04gtCg4gO9TU?=
 =?us-ascii?Q?c+7+pl8UN8ORHCLj80frt6FZKavnDaJm9HsfNg99dQfBzcJIQzCzuWGOe33b?=
 =?us-ascii?Q?3XqEgj7czy6p/m6j80hNQjMhqvVrfgF3AHV00Il5AVBfATYLvvCc1mMdOWuq?=
 =?us-ascii?Q?azcq/W2rAM3vOMAstCud0AFy0zOhfwx7nFywUPCyVIKrTkl8EZZgr5+38I2j?=
 =?us-ascii?Q?W7dbshYPRHpwH4lExDENBvrQubTf+sgVbH0kymx0nsqvXj5vRGP3dtGiT3GO?=
 =?us-ascii?Q?SdX7ZCc/QNPggY5sbDdk8PItomqY+BhniUs7+M0zOL9VvZxlCJhmKh2nDSm5?=
 =?us-ascii?Q?O/zM4ixI+Nh8p7EDbOl59oRKrngF50TsgQPVW2dojcrQz/mbSisDa3K1tYSU?=
 =?us-ascii?Q?cgoAnMYKXSG/5D5DuF7cNOHpAVtoXc5N5534tdEzrZ3hzHBqgM1Yha9rpys5?=
 =?us-ascii?Q?py5Ktb5JlQfVD2laOMLvmJgYovpPRaqLbVrzcrAC9sKNtejCivcCTiMSaJF9?=
 =?us-ascii?Q?Uwvrl/Nz+y+SeJZ1HfnHwCi0Tq4naAKoogpV3zPPKenMWhMBpsrcF7rm7E8S?=
 =?us-ascii?Q?k3T2DlFvZHH+uhseZYpkTSS6LIuV3CvlXnhKTf2JcMGWK/wbBoWbQws6rpLt?=
 =?us-ascii?Q?gnUUzvLlhf3oFT5gqNbxnMGoEIwPHwSGI1/J7T7+CpFij4V4QDfhyemA5Ieq?=
 =?us-ascii?Q?msTLQcvt8N6nZX60LOb1dRenzncHctKt9RVgEX3kJikub5zVk/Es3rNaWkEz?=
 =?us-ascii?Q?nZbtXSSUqhQuLl7KazuUxj4jXXSQoI2n4nm3Fq1THmXBBPFd+DAttGr5Zc8Y?=
 =?us-ascii?Q?60odxEv0GUxhVZ7eB71DsiMxORPfg6JdcgK5mN+LD/5EVnaBx0E10WAKBhVE?=
 =?us-ascii?Q?GdJROKrnZoul3ag0X0p2SNkzZ5gsdgEPp6E5YgaFrrW3wX/3VTfoKmKZmUJ9?=
 =?us-ascii?Q?Jmy90zRHrDKqM0Wy008nlSVjWSKLJ2tEGfxlD5/7jp0y/j/sN+EGKHhiETcJ?=
 =?us-ascii?Q?xGv+UDCkDENa5YnBE9Mbq94ACyeqhl/Hmv30WSO0mQjVA3qUPLx9McEKatVT?=
 =?us-ascii?Q?skrLB3SLpbNtSLwGjAfPz1mN2sd6hH0b8dpwkIu7fYTUK1gArg97i1dsDP3G?=
 =?us-ascii?Q?IfXNkW7D5HOzixP3Eau5QMCSexRbyJnEnLSj4fsGVHHdyrGF1lUMXdBb1bam?=
 =?us-ascii?Q?v6yYZqpNY3rDoQiMKXgmelmU/vUojgbyktkiP4uH9yMIcbpRXwxnAtncigme?=
 =?us-ascii?Q?dMwAY8Zns1KN3TfWr+t6tRJffYPReBko41rO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:35:29.0720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d150c23-7d5b-48d5-40b4-08dd9bc34e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
Received-SPF: permerror client-ip=2a01:111:f403:200a::602;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On Sun, May 25, 2025 at 05:02:16PM +0100, Richard Henderson wrote:
> Use an explicit 64-bit type for extended addresses.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/microblaze/translate.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index b1fc9e5624..dc597b36e6 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -660,23 +660,23 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
> +static TCGv_i64 compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
>  {
>      int addr_size = dc->cfg->addr_size;
> -    TCGv ret = tcg_temp_new();
> +    TCGv_i64 ret = tcg_temp_new_i64();
>  
>      if (addr_size == 32 || ra == 0) {
>          if (rb) {
> -            tcg_gen_extu_i32_tl(ret, cpu_R[rb]);
> +            tcg_gen_extu_i32_i64(ret, cpu_R[rb]);
>          } else {
> -            tcg_gen_movi_tl(ret, 0);
> +            return tcg_constant_i64(0);
>          }
>      } else {
>          if (rb) {
>              tcg_gen_concat_i32_i64(ret, cpu_R[rb], cpu_R[ra]);
>          } else {
> -            tcg_gen_extu_i32_tl(ret, cpu_R[ra]);
> -            tcg_gen_shli_tl(ret, ret, 32);
> +            tcg_gen_extu_i32_i64(ret, cpu_R[ra]);
> +            tcg_gen_shli_i64(ret, ret, 32);
>          }
>          if (addr_size < 64) {
>              /* Mask off out of range bits.  */
> @@ -781,7 +781,7 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
>  #ifdef CONFIG_USER_ONLY
>      g_assert_not_reached();
>  #else
> -    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> +    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
>      gen_helper_lbuea(reg_for_write(dc, arg->rd), tcg_env, addr);
>      return true;
>  #endif
> @@ -813,7 +813,7 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
>  #ifdef CONFIG_USER_ONLY
>      g_assert_not_reached();
>  #else
> -    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> +    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
>      gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, false);
>      (mo_endian(dc) == MO_BE ? gen_helper_lhuea_be : gen_helper_lhuea_le)
>          (reg_for_write(dc, arg->rd), tcg_env, addr);
> @@ -847,7 +847,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
>  #ifdef CONFIG_USER_ONLY
>      g_assert_not_reached();
>  #else
> -    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> +    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
>      gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, false);
>      (mo_endian(dc) == MO_BE ? gen_helper_lwea_be : gen_helper_lwea_le)
>          (reg_for_write(dc, arg->rd), tcg_env, addr);
> @@ -941,7 +941,7 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
>  #ifdef CONFIG_USER_ONLY
>      g_assert_not_reached();
>  #else
> -    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> +    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
>      gen_helper_sbea(tcg_env, reg_for_read(dc, arg->rd), addr);
>      return true;
>  #endif
> @@ -973,7 +973,7 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
>  #ifdef CONFIG_USER_ONLY
>      g_assert_not_reached();
>  #else
> -    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> +    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
>      gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, true);
>      (mo_endian(dc) == MO_BE ? gen_helper_shea_be : gen_helper_shea_le)
>          (tcg_env, reg_for_read(dc, arg->rd), addr);
> @@ -1007,7 +1007,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
>  #ifdef CONFIG_USER_ONLY
>      g_assert_not_reached();
>  #else
> -    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> +    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
>      gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, true);
>      (mo_endian(dc) == MO_BE ? gen_helper_swea_be : gen_helper_swea_le)
>          (tcg_env, reg_for_read(dc, arg->rd), addr);
> -- 
> 2.43.0
> 

