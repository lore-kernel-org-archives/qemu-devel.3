Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FE3C5AE59
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJHDC-0001gh-D1; Sun, 25 May 2025 15:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJHDA-0001fc-D3
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:40:44 -0400
Received: from mail-mw2nam12on20608.outbound.protection.outlook.com
 ([2a01:111:f403:200a::608]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJHD8-0000Yq-85
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:40:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjgrQjBXQoPLBnUbkPxHnMWZpnPKjS9R2tCNwZrCepYEID5MWDCO/5rno51sVGiYlBSr0GSGXRzLK/AgG+Adr1ib1IQLWs4aJ0WedsNjmZtgIeFLvPLmXTraW7XUtWpWBYjVcVoKGruit94R9vYNe7xitmP5tYh8cU7Aw3rJcKyyX1bFbeOsUtgsDMMj6v8LrOSrE7iB+efj9ckB3Pak+iNk2qsuCUxAZ+JoyOXyMYFIntPL/X5es8+wB3ARFZKdQkBtG3JsG2V6f1TaArkpVkmqpya8FO0gmlauQGfQxVM8D1mu6Z6EcpfixxQnieQJMJz8ogNHvHiOyr9hXddkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgbKqfxjrCVWhHqdb7Igrz7KH9ySuu8mP1eUeQlNwlg=;
 b=R+Vsup6+U5ywtNCQtX/DLWG2aPvWr06LyZ1tUbGzh5Vro9ELMHQ2NmxrNqXQ+2ugIL2VM8wP7ePBTmBrRc+aQVUdkmY9BzUxLOfsgwJQB6QaIhMNxgi76eECvvn+E4Im2dYXmbKWkC1PUiMi7X/xVDP5HTtqt20h/5to5bNOWSGXM+AOvEGqmOtfvKyblUu0ZwDuWH9+U691zzE8jSzOhSHSfmo82dr27oLiB7YriCJHEkXNwvUXkjJJ7CszR2KVWadt0cElh7YSXWIk7v9aZbNvDNFqP4yU1z0b4Q+tnQVIUWb/Wtd5gTgGdAG8J5/KOx1AQyCSW5+gyjE4edQM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgbKqfxjrCVWhHqdb7Igrz7KH9ySuu8mP1eUeQlNwlg=;
 b=XbZEMhfgh3hlCmE0mlcaioTY6hIY7yJgwHu/iAwqnUJkqJD2OdPyySrY/bPEFX8gFu0z5uUNmzKeH+0d2V+ZD1249MmGCAAFGeMR1NOLUyI6n3MQK8GDqJsqH/Tv/0MeqHtRNZnKdc0Nj0v0lj/0XbgMtVbDgaenJz+lK0z45Gk=
Received: from MW4PR03CA0165.namprd03.prod.outlook.com (2603:10b6:303:8d::20)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 19:40:33 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::aa) by MW4PR03CA0165.outlook.office365.com
 (2603:10b6:303:8d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Sun,
 25 May 2025 19:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8813.0 via Frontend Transport; Sun, 25 May 2025 19:40:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:40:31 -0500
Date: Sun, 25 May 2025 21:40:24 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 10/10] target/microblaze: Simplify
 compute_ldst_addr_type{a,b}
Message-ID: <aDNyKBHXVXsiE4Vv@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-11-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-11-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dde0d89-2ecb-4f0f-54a8-08dd9bc40321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J1FJMKV4iU7DDMj5qJqQXzEb+xdQYAiLhBlrRAQM97USoXilNppBcYwVPcUT?=
 =?us-ascii?Q?YOUuHrGS1bVPKANynC6R93eaQiVgMRxa0hqVh4wdJQQ4LDwdSqivHWQvBnHi?=
 =?us-ascii?Q?Ddr9x67RaqLmX6RLWlUH3zclUutjwhbwDIlQugn9aYz8MFWXcJNnlipUixU8?=
 =?us-ascii?Q?3R0a5cZtEwPG1XlVhUnADg849jPBQJNC8QUFV6VAwdxM1P/32B8wZaxEjIWx?=
 =?us-ascii?Q?bp+lqXCJBDXLcVSNLU1UjpNSyf4o28LO8foa3Vj8jIhYo+vQncfVtB1q2bdO?=
 =?us-ascii?Q?SQ5+y7JROajsdAPCK85X5bo4udDIGmWEslNUJtiBNPIMro0uZ/bub18PBzcu?=
 =?us-ascii?Q?Fu+pHgf85GkWW3bA1stcMuQWJo/V54tIX/LQoyVdtS4PslFL8dQQnR/aS6Ht?=
 =?us-ascii?Q?zJnn0loI3yk+xDSTM1TZPdDEHqy91p1dZNnBp2M/A99WRRK+KdUu6lZYtywv?=
 =?us-ascii?Q?uoL9gZ7AOLHhDKKryttS0x/Lnk6JO792QedRtN8Zr6Ji0AvdG0cmT+RblGU+?=
 =?us-ascii?Q?bxhq1ECvQ0N5UHDQfjcnpSsD2zKHbaOpn3iZhy56hTKM612rYnQDQupfG6hI?=
 =?us-ascii?Q?vynSW7mOq7aDfV5rkOUoOWH4NSrja9TPWk/caVBBAc0NV4hrj47k+JpnXBeC?=
 =?us-ascii?Q?A9bQ3BEqKd/Ul1Dnb0PcVelgL0CSNPx4J7NWpkpkzJ/4YmDrozEdgR/BJ4vb?=
 =?us-ascii?Q?Qc27jt9jXmSI2rtcuIQbMKJDiUIQNmol3yABETYQKj/h5RX/7BXSxconBAE7?=
 =?us-ascii?Q?OH1WypC54aWIDfZ8+7A3BhRpUtsbVdWLJOsbzdpxnFiPWlIDGkY24afGDvdq?=
 =?us-ascii?Q?dz0hODfI2owNXtmVJ9KIjas9HdUFMIMyDl+9ybL7TelvWEU94XqQgQqh2eDA?=
 =?us-ascii?Q?sGPB3BHQdOkrwU84jsvKQnhGXdqGLIWsvTgLcQGLRDED776mmT1TZlJF/bCT?=
 =?us-ascii?Q?ek0sVUS2tVfipauDhParvNVy0ZhxkR1XrOStuYMvIVLVUYNvW9cjJcInbkGT?=
 =?us-ascii?Q?TxLsoXNPIyojIxJHW0tqh82fJ0dXbAXkOj6nAoye43loGQDDt3qIV+zze9ao?=
 =?us-ascii?Q?eFptuLP4cpL1wAogZOQwABGdVanay1h+znPp2Wf0P9DMCvOL2nlFuP7VuNf9?=
 =?us-ascii?Q?w2PD5DNvfmXIWAG7gWYEVjf/fdBCFAxaFveOKzgvl12CuFOPcdKNZjKmZKmR?=
 =?us-ascii?Q?S3siG2OIRgzWyI/zhIDPRv8fCg5/M59/QtxASECMS5UGVOjHGXarzQm6ErjQ?=
 =?us-ascii?Q?D/ROLf1VF+kvi8zmjNzhnHeB2yDGFBJzcrF8io6r3Mw4kJvA3XyJWs+2Jc2s?=
 =?us-ascii?Q?WzMqZFFvwRb6b7Bb3iUi23MF7wHdYbWimao75E4lqmvYHYbYjzAPidAprKYc?=
 =?us-ascii?Q?YYgsPXdwE/DVF96dIKn4V00wlIYFl//rgnlmUdIRVyw6mHQrXXZJg9dfyTTj?=
 =?us-ascii?Q?zkjTmnew6UGG1zEzrg483XazLGeeQfbEbN3Wz3ptUdHyqp/QhRUnYQIvG7ea?=
 =?us-ascii?Q?OO8X3Odgn0Ia9TDHzj56l6n8jgJa2w/won/W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:40:32.3634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dde0d89-2ecb-4f0f-54a8-08dd9bc40321
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
Received-SPF: permerror client-ip=2a01:111:f403:200a::608;
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

On Sun, May 25, 2025 at 05:02:20PM +0100, Richard Henderson wrote:
> Require TCGv_i32 and TCGv be identical, so drop
> the extensions.  Return constants when possible
> instead of a mov into a temporary.  Return register
> inputs unchanged when possible.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  target/microblaze/translate.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 047d97e2c5..5098a1db4d 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -606,19 +606,18 @@ DO_TYPEBI(xori, false, tcg_gen_xori_i32)
>  
>  static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
>  {
> -    TCGv ret = tcg_temp_new();
> +    TCGv ret;
>  
>      /* If any of the regs is r0, set t to the value of the other reg.  */
>      if (ra && rb) {
> -        TCGv_i32 tmp = tcg_temp_new_i32();
> -        tcg_gen_add_i32(tmp, cpu_R[ra], cpu_R[rb]);
> -        tcg_gen_extu_i32_tl(ret, tmp);
> +        ret = tcg_temp_new_i32();
> +        tcg_gen_add_i32(ret, cpu_R[ra], cpu_R[rb]);
>      } else if (ra) {
> -        tcg_gen_extu_i32_tl(ret, cpu_R[ra]);
> +        ret = cpu_R[ra];
>      } else if (rb) {
> -        tcg_gen_extu_i32_tl(ret, cpu_R[rb]);
> +        ret = cpu_R[rb];
>      } else {
> -        tcg_gen_movi_tl(ret, 0);
> +        ret = tcg_constant_i32(0);
>      }
>  
>      if ((ra == 1 || rb == 1) && dc->cfg->stackprot) {
> @@ -629,15 +628,16 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
>  
>  static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
>  {
> -    TCGv ret = tcg_temp_new();
> +    TCGv ret;
>  
>      /* If any of the regs is r0, set t to the value of the other reg.  */
> -    if (ra) {
> -        TCGv_i32 tmp = tcg_temp_new_i32();
> -        tcg_gen_addi_i32(tmp, cpu_R[ra], imm);
> -        tcg_gen_extu_i32_tl(ret, tmp);
> +    if (ra && imm) {
> +        ret = tcg_temp_new_i32();
> +        tcg_gen_addi_i32(ret, cpu_R[ra], imm);
> +    } else if (ra) {
> +        ret = cpu_R[ra];
>      } else {
> -        tcg_gen_movi_tl(ret, (uint32_t)imm);
> +        ret = tcg_constant_i32(imm);
>      }
>  
>      if (ra == 1 && dc->cfg->stackprot) {
> -- 
> 2.43.0
> 

