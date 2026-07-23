Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6CDC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmoxL-0005ZS-8h; Thu, 23 Jul 2026 04:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmoxF-0005Yg-Lf
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:38:57 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmoxC-0007oe-3R
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:38:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQOPL6sLILDxSbfUgOP6D8lDIG8g069rrUXck3iQ6CwvmMQlVRUOJFsTWsLeJaY/MXVJlzF1aGUj8FJIjkYXKJvby+26CWV68PxPm+qch5FPFHrFSuNXSr3OjiUrWcInv3XSb52Xj6oihJSh+WaGhsIjodCE+CdhdT4rqpjUa8/WD+7CEJPWu88ni24mX62+o0/K+P4AHIU4P8JSlZ8L5Bwy44Lj77H3au1obB9+++7xk5JDjkYjJ8kkEpNzrH+TE/9sxmjDybQto9ieM5pdEwo005CYYKMLF47phZ+dmanehJkWGmpUPk1PuJTrxPS+e9A87wZyWMZ21ogIhYyunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8+Am0z8JGXXzatbOimqU9wqz+6jbcg0v7VVIFPKMO0=;
 b=Hz2ix3vSsC9TCiaUQvD8vnKZkFWlASqPqZ2/hFWMIUyKwN4zCCiiZ/14CF8ZnIkgMx29hqT1M4H8sZ9OVDb+t1yVYbYG+IbIYRH17q5Y1uZmcOn7kNtV4RaZI44LzEdSBQqpSefTQrNhUTx1RGeB1Rri4VUZVI4BVNyVSq5sQIcVpAeMGi/FcobZIZy1ujmxTgroaVkC3+aYCBF26Om8KOshx+geKuCZ4YP/dnnvGilNyJCbkIqxnPvGWeWVN1KshQvKclqzg/X5hGblhRTnmgdvQLWNHUy+DBely9lYjIySaicJk/xg2S8bZWr8n2umDdjSaawcGsjxOkb3RT83Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8+Am0z8JGXXzatbOimqU9wqz+6jbcg0v7VVIFPKMO0=;
 b=TAS/8dm7WD/XiQaXTdUA+EM2RtygjrhfB+Q6Et7P/jGc1LHE7VT/FkrZMawJ7W5H9Qbih/ym10n8RyGJjfeVSRhjtZpJdx1NgrQtwUeuOKNb1ZdW6w8KiW/lQPCHIngV7fvXjrGy6NSKlY3hKMISUJTOKTVN21XenQkp+gxQItI=
Received: from SN7PR04CA0234.namprd04.prod.outlook.com (2603:10b6:806:127::29)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:38:45 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::99) by SN7PR04CA0234.outlook.office365.com
 (2603:10b6:806:127::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 08:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 08:38:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 03:38:44 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 03:38:43 -0500
Date: Thu, 23 Jul 2026 10:38:41 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
CC: <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 6/7] target/microblaze: Factor reverse_ldst_addr()
 helper out
Message-ID: <amHTEbUl4clim9fw@XFR-LUMICHEL-L2.amd.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
 <20260722160807.24031-7-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722160807.24031-7-philmd@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e29de69-cef7-4a27-8500-08dee895cec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|18092099006|22082099003|6133799003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Nvao9VbDqW69cs+m9TWiabvg3FKJexTwDh5Nhe1fxrMrnqFDFEUtqcBXi/z76Cp3GGaOY5/WxzOD20lZOYiRu/xj+1WNuLUYf6fbM/FMHCr2kvQe/Ht3+edZQ7k133Q3H3P3Hftq0RAXG+gRpEK79DUCJFuF6q6+khDy+oex4rVUUUZ2FZflUXbftdmP9QXpThKJZuZF6p1D/vFAd23IUoXKRzb3jGlqftzJKPQH/wI2Jr8eFQROX5Et6hkBUjSZjVX0/LngfGKSXsJuneHfHL9+wfR9kJ1l+W9TMdmfGDl9TofsNBB1C1YV+JCgoR08wQd3n6kXc6ofVicwIhSRfTb65WKRn6XXDygZSVpfXA/G3g3jlkJQckQ4Mach6nfNlBWsBSkxnfikdF+zdDoNadexwWrd8eZ0F8GzzjPkNHv+HMJAa+2SeqnZGnYlv5frQFRECr52qn4tmfInuM1VLiPOPkRCfcJMmsmUgaNpwklbyuC2Zk2j0YIFSlmnr9+Nz03FDwd0feYlQvAhugzIl35flMMDntdrEgd2jh0AD8NodJL1ihcLEmsq2YgbYFyA6/eRg4HZu/sfM/BHM0C0WekFWrif2hgN2BSuqdnGU+kt1g+iX1YZ7IvHSmAH4y2bqKuMbqlpe518Pbb5t3pWZ/BLJAAOaH42xUAohTzsbMycMkpblx+kiSnsX2Zik4TzAvLJGE6qc+LAH10tyoBhAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(18092099006)(22082099003)(6133799003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zkQ0P8o2c0e6DGPHN53L4wgFtltRbKmTlyY5bjXcVGdXY9WwQ/vKcFwfRjFo69L3AAbksihUe6lPVwdpf+4Ti52DYBlXxcSi9TFjJRtBEw62S5VOep7hvewT3iKSnxqjhw9B7YfnYMokYM3kYylkLpJyL2xgP84mPO4iAtBsvc624ao+i+v017lp4aiQ9PknQMYRxsQUMfnkNT4w8wOfpxBn5dfeLYcB0rVHP3BR+h0sQ41DVQFyZ/N9LRLH2FNDMk+foR3QpMT4zNC8ragxiGUB0vRkpC8J04ihpkdP9jhb6L7DEMrT9QTZIZ+8y/iuvLPp1q/HFvz+mbgRlt8/lbl7jcjplvB5uaiVOmq3+uowsfcYbBiZ9xjv0tzNcEvSDE+Jmc2bALVN8dDB/tzm1p6V+hRFgfIQYxq7DDmmsQ/JsbOV2sAg/4r1rPFdQZFq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:38:44.9504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e29de69-cef7-4a27-8500-08dee895cec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

Hi Phil,

On 18:08 Wed 22 Jul     , Philippe Mathieu-Daudé wrote:
> Instead of burying the address reversion in the load/store
> opcode helpers, hoist that to compute_ldst_addr_type*(). Pass
> the necessary information with a MemOp argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/microblaze/translate.c | 64 +++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 581f4b48c92..8c530ed1191 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -607,7 +607,24 @@ static bool trans_wdic(DisasContext *dc, arg_wdic *a)
>  DO_TYPEA(xor, false, tcg_gen_xor_i32)
>  DO_TYPEBI(xori, false, tcg_gen_xori_i32)
>  
> -static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
> +static TCGv_i32 reverse_ldst_addr(TCGv_i32 addr, MemOp mop)
> +{
> +    MemOp mo_size = mop & MO_SIZE;
> +
> +    /*
> +     * When doing reverse accesses we need to byteswap the data
> +     * lanes on the way back into the CPU core.
> +     */
> +

You are missing the check against MO_SWAP. Here you are unconditionally
swapping all the addresses.

This is OK to check the MO_SWAP flag here because `mop' has not been
xor'ed with `mo_endian(dc)' yet. So a MO_SWAP flag set here means "we
are translating a reversed load/store".

> +    if (mo_size < MO_32) {
> +        tcg_gen_xori_i32(addr, addr, 3 - mo_size);
> +    }
> +
> +    return addr;
> +}
> +
> +static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb,
> +                                        MemOp mop)
>  {
>      TCGv_i32 ret;
>  
> @@ -622,6 +639,7 @@ static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
>      } else {
>          ret = tcg_constant_i32(0);
>      }
> +    ret = reverse_ldst_addr(ret, mop);
>  
>      if ((ra == 1 || rb == 1) && dc->cfg->stackprot) {
>          gen_helper_stackprot(tcg_env, ret);
> @@ -629,7 +647,8 @@ static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
>      return ret;
>  }
>  
> -static TCGv_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
> +static TCGv_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm,
> +                                        MemOp mop)
>  {
>      TCGv_i32 ret;
>  
> @@ -642,6 +661,7 @@ static TCGv_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
>      } else {
>          ret = tcg_constant_i32(imm);
>      }
> +    ret = reverse_ldst_addr(ret, mop);

As you noted previously typeb (load/store immediate) does not have
reversed variants. I guess you can drop this and even replace it with a
g_assert(!(mop & MO_SWAP)).

Thanks

Luc

>  
>      if (ra == 1 && dc->cfg->stackprot) {
>          gen_helper_stackprot(tcg_env, ret);
> @@ -714,24 +734,14 @@ static inline MemOp mo_endian(DisasContext *dc)
>  static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>                      int mem_index)
>  {
> -    MemOp size = mop & MO_SIZE;
> -
> -    /*
> -     * When doing reverse accesses we need to byteswap the data
> -     * lanes on the way back into the CPU core.
> -     */
> -    if (mop & MO_BSWAP) {
> -        if (size < MO_32) {
> -            tcg_gen_xori_i32(addr, addr, 3 - size);
> -        }
> -    }
> -
>      /*
>       * For system mode, enforce alignment if the cpu configuration
>       * requires it.  For user-mode, the Linux kernel will have fixed up
>       * any unaligned access, so emulate that by *not* setting MO_ALIGN.
>       */
>  #ifndef CONFIG_USER_ONLY
> +    MemOp size = mop & MO_SIZE;
> +
>      if (size > MO_8 &&
>          (dc->tb_flags & MSR_EE) &&
>          dc->cfg->unaligned_exceptions) {
> @@ -746,13 +756,13 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>  
>  static bool trans_ld_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
>  {
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> +    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb, mop);
>      return do_load(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
>  }
>  
>  static bool trans_ld_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
>  {
> -    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> +    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm, mop);
>      return do_load(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
>  }
>  
> @@ -815,7 +825,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
>  static bool trans_lwx(DisasContext *dc, arg_typea *arg)
>  {
>      const MemOp mop = mo_endian(dc) | MO_UL;
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> +    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb, mop);
>  
>      /* lwx does not throw unaligned access errors, so force alignment */
>      tcg_gen_andi_i32(addr, addr, ~3);
> @@ -835,24 +845,14 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
>  static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>                       int mem_index)
>  {
> -    MemOp size = mop & MO_SIZE;
> -
> -    /*
> -     * When doing reverse accesses we need to byteswap the data
> -     * lanes on the way back into the CPU core.
> -     */
> -    if (mop & MO_BSWAP) {
> -        if (size < MO_32) {
> -            tcg_gen_xori_i32(addr, addr, 3 - size);
> -        }
> -    }
> -
>      /*
>       * For system mode, enforce alignment if the cpu configuration
>       * requires it.  For user-mode, the Linux kernel will have fixed up
>       * any unaligned access, so emulate that by *not* setting MO_ALIGN.
>       */
>  #ifndef CONFIG_USER_ONLY
> +    MemOp size = mop & MO_SIZE;
> +
>      if (size > MO_8 &&
>          (dc->tb_flags & MSR_EE) &&
>          dc->cfg->unaligned_exceptions) {
> @@ -867,13 +867,13 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>  
>  static bool trans_st_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
>  {
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> +    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb, mop);
>      return do_store(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
>  }
>  
>  static bool trans_st_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
>  {
> -    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> +    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm, mop);
>      return do_store(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
>  }
>  
> @@ -936,7 +936,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
>  static bool trans_swx(DisasContext *dc, arg_typea *arg)
>  {
>      const MemOp mop = mo_endian(dc) | MO_UL;
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> +    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb, mop);
>      TCGLabel *swx_done = gen_new_label();
>      TCGLabel *swx_fail = gen_new_label();
>      TCGv_i32 tval;
> -- 
> 2.53.0
> 

-- 

