Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD00C4451C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmRF2-0004jb-P1; Wed, 22 Jul 2026 03:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmRF0-0004iW-Pl
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:19:42 -0400
Received: from mail-westcentralusazon11010009.outbound.protection.outlook.com
 ([40.93.198.9] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmREx-0006Cx-9j
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:19:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6rD5JpLTQFhvjK+3+eX+lAmHZOEPgjVHw6JjVnhqdsaJ+IQ9UkKQcDU6vTyFo6LmHqEhrC76tHzIHgDmGML6f2jR1xIZnM+4w3ZWnmRKIiYxsQCMvRKNpHEpZIfaETShQUCeFw1gAuIi1HeFiCM8hKyaIp0VTHDtT4y61Hr4wHhFIA3movHeYhmwjuDr6TReIRsQ7OyYgqcSLxiwe00+2GyxDlG7y9xPkNjsxibYY8pBOKxiWHaBRyDdJmDqqN3DUNZv8iTu3QbS3V4DfItzGNByd5YNYmx3okBwzK26K4QI+F8arNJSDjHCtUHO6eZ+5HLJiG9pkVolVOuD9Xp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N3JWiUCYbn5vSzwb6sdPAkBdVCPj1PARCD2qm/INlU=;
 b=u3Wf++XkrHLo7zLRKHrtkNAvE04OIiHrqm57/zbm9BJ/coDxynjB56fASA7MQYNEQLy368vt0uje3IlatLT3g1Rh38HO+I6obbkvxTN1NrghFMoWEAKlEEkzH2OpHPkSaegv17s1Xj+LS+uyaaBenmlgnGkRYFNzIa9xASYyAeUcIK9GuC+IMJl0/xmbkbb1iaGJ/x+nnpNfhYeUSfdCsTok9fZFL/p+FD/ApdzOEY+IsxUcDNb95CJdQQPjTvchK6YCkCrOSdWv9a/wwVV9sKKErtpsjkCzYYOmGlqv/iHKT37rh8Rp0tG/iC6QHwY4ads0wA1kSOFEafLZ7DA6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N3JWiUCYbn5vSzwb6sdPAkBdVCPj1PARCD2qm/INlU=;
 b=P5LpdUp4aufb0e5B1xay3BVO4ghbtT7R4mV478+Gdra+1u+y0+G0gt6iXqin7EzsfDkCQ2lEj9BbeWcXVoq2as2LKAWW01K+VzCXPAVhrrl95CUYm2548yEcTRfJnzCjwo8T9LKHssKyNF8Ji+uqI9GLXge0LXUK3e6vdDHQZyg=
Received: from DS1PR04CA0021.namprd04.prod.outlook.com (2603:10b6:8:243::16)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:14:30 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:8:243:cafe::1f) by DS1PR04CA0021.outlook.office365.com
 (2603:10b6:8:243::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 07:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 07:14:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 02:14:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 02:14:29 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 02:14:28 -0500
Date: Wed, 22 Jul 2026 09:14:21 +0200
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, Richard Henderson <richard.henderson@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, Frederic Konrad
 <frederic.konrad@amd.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH] target/microblaze/translate: fix reversed load/store
 translation
Message-ID: <amBtzTFzNTPbEYB9@XFR-LUMICHEL-L2.amd.com>
References: <20260710072348.3575-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710072348.3575-1-luc.michel@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 681cb6c6-76b3-42cd-f071-08dee7c0df48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|10067099003|11063799006|56012099006|18092099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 50Fb5C0cXlbdknw88hSz2lsRsBdnpM/rRvFbkmRE+yX+dw63cdDfwGRUMXhrOOGsFYRINWaOCmCnQGgk64r5we7Cuo3I2tLAhrEInExrHwQOVYm2PyzW1AU0zZgTbyfHqJ/9GItsvyCBLWtDcjH4ybNgJsC1B7GC2J0ggiQ1v6/LtDDjCPXm/A1pFMa0OnyaSFlPKyoEhHg73n1oep23Ic4nKK7WrOvevocixRh9rnaw8+4iwoQqvFk88G4Qa0gf/hJTh+Soj5UGh/LpH9MyqrW4nInfUBmaS1FD5NjbvdWtKGrEvcbNnM1oAvuD3P/nKcd0HY+4NkuJ7c6t9O4zw6xDQFH98S6+IpbR1sR1EOEChpPmFRbO+AeWA9xXwuuzA3ygNVSXsnQ1+dSR7tfWpCW62KkIcxp7Fd466x3ZTz70PbfoaUCJvTeqxE8RMTytKFcSIaMnKqb34deGVZa/Q3H4/RcEEgdoDMogGuf7yjBKyyij4sJTfcXKKazju0McVNH4RSY8ARxtm+IHFSBfeZbmwniV8C79ANvmjlHwva4ovcJoIblHyEGMSsxu2G1GEJpGWUwIIJwda/JgWDl2KWZvqGv+JlOrjz7vws+unWLQbQckqwTSY+Avtl9wKK/Qa7zjaPlHNT2VzGwsGkEWX5iKwtGY5PDDnxjTEyr1ykdaZ1pqYwyWNly6Zw3CGYQnsahYT81BKfzD89HZF+AeYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18092099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vvRvm8DyduzdBbosRUmvesGzKudPPOfJuiHmz4tEmyBFb9O1JQSDqmQpm5k/LcW6BYWUg+TVXGzEumverBueVhWpC2lQzCjNXlyr2a0vYdyffN7dADNQVQ7kKKYTkie7UPnEeAdsvblCrNxf3tztZHpcRrHI4MPdU8EFO2AKSLKn262pv31dYiH/4pJP3UUCjcwB3mzUKohKG6TYzOVnHq1i/r3l14FMucMy+dLeRl9ARF8F6xvpDj0LHTOAzAfETtB3IjWxFyuMpswHucMNQSGKBaixCT7rU3T+jtYkS2Nv8W2pWGJuPiL3THhhR2eqwpWLUVJ6jKBLk+kBnGQ+DTBh/9tLLEgJDwvFcD2vkTxtNMKip13YszENF/TzCM/qY26RwtA2Y0b6mpaIs1q7tzbpvzbzGlke+vDlBXtQgj19YC0awgNJkQ/KFbDS5S0X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:14:29.8232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681cb6c6-76b3-42cd-f071-08dee7c0df48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
Received-SPF: permerror client-ip=40.93.198.9; envelope-from=Luc.Michel@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

Gentle ping. The fix just consist in allocating a new TCG temp for the
address if we need to modify it.

Thanks

Luc

On 09:23 Fri 10 Jul     , Luc Michel wrote:
> Since 36a9529e60e0 the TCGv returned by compute_ldst_addr_type{a,b} for
> the address can be a target register or a constant. However
> do_{load,store} might modify it in the case of a reversed load/store.
> 
> Fix this by factoring out the reversed access logic and copying the
> address in a new TCGv_i32 if it needs to be modified.
> 
> Fixes: 36a9529e60e0 (target/microblaze: Simplify compute_ldst_addr_type{a,b})
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>  target/microblaze/translate.c | 56 ++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 8b219afb5dd..9fb84e1bf9f 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -701,30 +701,47 @@ static void gen_alignment_check_ea(DisasContext *dc, TCGv_i64 ea, int rb,
>  static inline MemOp mo_endian(DisasContext *dc)
>  {
>      return dc->cfg->endi ? MO_LE : MO_BE;
>  }
>  
> +static void handle_reversed_access(MemOp *mop, TCGv_i32 *addr)
> +{
> +    MemOp size = *mop & MO_SIZE;
> +
> +    /*
> +     * When doing reverse accesses we need to do two things.
> +     *
> +     * 1. Reverse the address wrt endianness.
> +     * 2. Byteswap the data lanes on the way back into the CPU core.
> +     *
> +     * Use a new TCGv_i32 to modify the address because the current one might be
> +     * a register or a constant.
> +     */
> +
> +    if (size > MO_8) {
> +        *mop ^= MO_BSWAP;
> +    }
> +
> +    if (size < MO_32) {
> +        TCGv_i32 new_addr = tcg_temp_new_i32();
> +
> +        tcg_gen_xori_i32(new_addr, *addr, 3 - size);
> +        *addr = new_addr;
> +    }
> +}
> +
>  static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>                      int mem_index, bool rev)
>  {
> +#ifndef CONFIG_USER_ONLY
>      MemOp size = mop & MO_SIZE;
> +#endif
>  
>      mop |= mo_endian(dc);
>  
> -    /*
> -     * When doing reverse accesses we need to do two things.
> -     *
> -     * 1. Reverse the address wrt endianness.
> -     * 2. Byteswap the data lanes on the way back into the CPU core.
> -     */
>      if (rev) {
> -        if (size > MO_8) {
> -            mop ^= MO_BSWAP;
> -        }
> -        if (size < MO_32) {
> -            tcg_gen_xori_i32(addr, addr, 3 - size);
> -        }
> +        handle_reversed_access(&mop, &addr);
>      }
>  
>      /*
>       * For system mode, enforce alignment if the cpu configuration
>       * requires it.  For user-mode, the Linux kernel will have fixed up
> @@ -864,27 +881,18 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
>  }
>  
>  static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>                       int mem_index, bool rev)
>  {
> +#ifndef CONFIG_USER_ONLY
>      MemOp size = mop & MO_SIZE;
> +#endif
>  
>      mop |= mo_endian(dc);
>  
> -    /*
> -     * When doing reverse accesses we need to do two things.
> -     *
> -     * 1. Reverse the address wrt endianness.
> -     * 2. Byteswap the data lanes on the way back into the CPU core.
> -     */
>      if (rev) {
> -        if (size > MO_8) {
> -            mop ^= MO_BSWAP;
> -        }
> -        if (size < MO_32) {
> -            tcg_gen_xori_i32(addr, addr, 3 - size);
> -        }
> +        handle_reversed_access(&mop, &addr);
>      }
>  
>      /*
>       * For system mode, enforce alignment if the cpu configuration
>       * requires it.  For user-mode, the Linux kernel will have fixed up
> -- 
> 2.53.0
> 

-- 

