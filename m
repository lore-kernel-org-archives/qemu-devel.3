Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98382C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmodN-0003uG-TI; Thu, 23 Jul 2026 04:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmodJ-0003sE-Qz
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:18:22 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmodH-0005Ch-OM
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:18:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urjxDdF7peXuOKCWF06FcvPH4ZStcGSXuBlKEUIu0dz7G4C8Gs3t9sFfY4VYMfPZacjRw+f2OjCE/8sLPPE54q2CjC8Itfoslaj8JC+IL/TuS4LjcIsUfQavvtroiBx2niiiaD556Kcevbnsq6LIl27CVbIJW8OUDtmNcQB4bSUfVLtBgamysbDe5SmmYyznI8RWb7h/TwBKhLH6gZT+EQsNQq9vD1LSUiHpwRx4LNGBYisOhgTDgEUmt5Ou9VRwN4yf9Ghu4vdPaLjGRnEMPm9xiDDAVtT7GFK8jw7g1sC3Zwa2VwcBswN6jT7NFQJQTtrHY2YhvqHoanvFIqv8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp7HFn5dQm3JGnC6c/jlK7ElRYoEO87x/SJHNR56DZ0=;
 b=gj1bSj0rV8zP9PtXil1mlINnzannhZWfy2uTWE5IzSCUHUN/k1OO89Y7KxsmdvQOpAU/powofj3KlTk+zNsqW7edihr6OY46dIDJDEMHE0ek2OrOjdXhoFt7jYxqirS3yLiJMyVVLQj9S/3FmbbodGxoDObgFRALOqHWTIaOnWIjelJuPohRM4CQGyRGlDiGNwCz3xLD/PPLsY+PLXOvvhEJLxRIvEQ27gWJ4h/RCGN4udkxRrH3k8LuD3ALr8w7F4E5M3TXtagvVKUdylroUSMrx0wRt0QtTDsTwavY8gHRv4WNbuHsGkrpBXo4L2cMsckPJNmIGTO/7xbX7DFbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp7HFn5dQm3JGnC6c/jlK7ElRYoEO87x/SJHNR56DZ0=;
 b=qTiWUaIvBWY5G4F1VqwjqkJpGQM9Xp3hZWHOnikQU6vu07RHUbbEB0xC9qdeGT5OGJ1i0mgWJwbjaMJ+2kbXIjXL4FiS33flmP0GKB0N97kV8+ii5CELqTDFbKRC8hvPoxFp2iMKSvlcFrJkkSxbb4AfFb9rBGS4xQOzg68rZRk=
Received: from DS7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::13) by
 SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:18:14 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::11) by DS7P220CA0009.outlook.office365.com
 (2603:10b6:8:1ca::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 08:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 08:18:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 03:18:13 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 03:18:12 -0500
Date: Thu, 23 Jul 2026 10:18:10 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
CC: <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 3/7] target/microblaze: Use TRANS() macro for typeA
 load/store opcodes
Message-ID: <amHOQkZ2TD-8gCJd@XFR-LUMICHEL-L2.amd.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
 <20260722160807.24031-4-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722160807.24031-4-philmd@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6319cd71-5e5b-4175-f26b-08dee892f13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: M5zXFyTKVjIqiGo3cBZ2oeCuo3lDucqIWGmwiTdr4PIRX25acXCyldBqvD+HsJyR6UVd/ENx4/mr9aQsHCfNu/TujIV+pseQEPBSg2vWKm2hbEt+1q8MX2ztqOhpnCUT2DqYwcqLEQQyBP9eQ8kAIWYkD228kQASjYSOj4LLqwY++fEW4oQUGCHej3UxhQC0icKTpyTYlch0DZXuRh8Zi6YoHkjh4MW7u82YvdGWXu3uw+PUhh/zgaxB5Pjcwf65/TlLqRouTukEIqW/9psMmwfKtSmRMFh/h3l2NTShRjX/WwGLoe/3MPHIGZa6YYIZ04aXl5ouU6BI0d+Q2NW41qE7QMjBGdsootiShbwMymXhybZTYNOT3CkW3Kc3MV4/i86dotby6DnA0g/ok+HOvyL367cRJzi5HZjFoxzybdSzJGLc55+O1xAE8I+cRmwdOEFjIsRrRSxj1B3NMznjxwgEJ8vAwzrdedKAhpRzs5kiWpsBMs/4we1l3esdNnjXIz9hcnL3RJ4xKWbvwyc+Om2R8msjmixedV8hRYHsQpMPXNgF05OrabuWhqeteLbeHb/VnHAZlicYczliReNpR/LvBCHdrPq2GTr4GBbPcgUpXYjczDqnQEMp1yM8NqpSTSH4iwQ7AAPxqyiOt2Nqv/vq26xIn684R1zNitkYyhTj0S6AuBryBXW/9gIfm+OMxAFA+cUpyidyHXWYqWTSeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TQe4s0C6ZPHakqkebokxBsfpr6aI/SrY0PJAkpZqfeh1POFWT87CTNynOJD051IHKzwc2atFN3ly/EK+wNfM//o5Zemu6YBD6f11k7Xm06305Oy/X9+VYi4Mx5cT/5vcYwwrSrEEbCEF44KJh4wKM4q0Levenmxjf8lWD6wURyE4mIYcVvdUs+RZaUduE5fvAa5royNKOlCvY/r5T+j+GjM2af2Zqjoo2rLewxB30FGq/FhWa6n/0n28GbtoTbpY3RSvcIBnr7rHdaW7ExEVNESy6TYMpKfcEP2fMpCMUMvkrE/c1huUdwEw0ErB8Ed2dAakSbn31iIg4tiDy8Rtc0ytmaxmH8qJZ7rv/6Y7+YwxAxbRxAqxM9pMt4bHDJ5/SwNHYwecrd5ikaZT9DhZmi+iePvt1ek2nRve5cwxop/0e/yo3z4seYt6trNMmMOc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:18:14.2504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6319cd71-5e5b-4175-f26b-08dee892f13b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Luc.Michel@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi Phil,

On 18:08 Wed 22 Jul     , Philippe Mathieu-Daudé wrote:
> While being a no-op since the TRANS() macro expands to the
> same code, this is less code so less maintenance.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/microblaze/translate.c | 96 +++++++++--------------------------
>  1 file changed, 24 insertions(+), 72 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index a2a7ee8b9e0..3f2de375d97 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -746,28 +746,28 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>      return true;
>  }
>  
> +static bool trans_ld_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
> +{
> +    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> +    return do_load(dc, arg->rd, addr, mop, dc->mem_index);
> +}
> +
>  static bool trans_ld_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
>      return do_load(dc, arg->rd, addr, mop, dc->mem_index);
>  }
>  
> +TRANS(lbu,  trans_ld_typea, MO_UB)
> +TRANS(lbur, trans_ld_typea, MO_UB ^ MO_BSWAP)

See my comment on patch 1. Otherwise for the refactoring part:

Reviewed-by: Luc Michel <luc.michel@amd.com>

>  TRANS(lbui, trans_ld_typeb, MO_UB)
> +TRANS(lhu,  trans_ld_typea, MO_UW)
> +TRANS(lhur, trans_ld_typea, MO_UW ^ MO_BSWAP)
>  TRANS(lhui, trans_ld_typeb, MO_UW)
> +TRANS(lw,   trans_ld_typea, MO_UL)
> +TRANS(lwr,  trans_ld_typea, MO_UL ^ MO_BSWAP)
>  TRANS(lwi,  trans_ld_typeb, MO_UL)
>  
> -static bool trans_lbu(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index);
> -}
> -
> -static bool trans_lbur(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UB ^ MO_BSWAP, dc->mem_index);
> -}
> -
>  static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
>  {
>      if (trap_userspace(dc, true)) {
> @@ -782,18 +782,6 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_lhu(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index);
> -}
> -
> -static bool trans_lhur(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UW ^ MO_BSWAP, dc->mem_index);
> -}
> -
>  static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
>  {
>      if (trap_userspace(dc, true)) {
> @@ -810,18 +798,6 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_lw(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index);
> -}
> -
> -static bool trans_lwr(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_UL ^ MO_BSWAP, dc->mem_index);
> -}
> -
>  static bool trans_lwea(DisasContext *dc, arg_typea *arg)
>  {
>      if (trap_userspace(dc, true)) {
> @@ -893,28 +869,28 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>      return true;
>  }
>  
> +static bool trans_st_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
> +{
> +    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> +    return do_store(dc, arg->rd, addr, mop, dc->mem_index);
> +}
> +
>  static bool trans_st_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
>      return do_store(dc, arg->rd, addr, mop, dc->mem_index);
>  }
>  
> +TRANS(sb,   trans_st_typea, MO_UB)
> +TRANS(sbr,  trans_st_typea, MO_UB ^ MO_BSWAP)
>  TRANS(sbi,  trans_st_typeb, MO_UB)
> +TRANS(sh,   trans_st_typea, MO_UW)
> +TRANS(shr,  trans_st_typea, MO_UW ^ MO_BSWAP)
>  TRANS(shi,  trans_st_typeb, MO_UW)
> +TRANS(sw,   trans_st_typea, MO_UL)
> +TRANS(swr,  trans_st_typea, MO_UL ^ MO_BSWAP)
>  TRANS(swi,  trans_st_typeb, MO_UL)
>  
> -static bool trans_sb(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index);
> -}
> -
> -static bool trans_sbr(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UB ^ MO_BSWAP, dc->mem_index);
> -}
> -
>  static bool trans_sbea(DisasContext *dc, arg_typea *arg)
>  {
>      if (trap_userspace(dc, true)) {
> @@ -929,18 +905,6 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_sh(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index);
> -}
> -
> -static bool trans_shr(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UW ^ MO_BSWAP, dc->mem_index);
> -}
> -
>  static bool trans_shea(DisasContext *dc, arg_typea *arg)
>  {
>      if (trap_userspace(dc, true)) {
> @@ -957,18 +921,6 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_sw(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index);
> -}
> -
> -static bool trans_swr(DisasContext *dc, arg_typea *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_UL ^ MO_BSWAP, dc->mem_index);
> -}
> -
>  static bool trans_swea(DisasContext *dc, arg_typea *arg)
>  {
>      if (trap_userspace(dc, true)) {
> -- 
> 2.53.0
> 

-- 

