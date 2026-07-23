Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B315BC531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmoc2-00034g-Im; Thu, 23 Jul 2026 04:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmoc0-00033G-SJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:17:00 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmoby-000545-DT
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:17:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnGwOFyxMnfSkBzf3o37acyXX/evptFqI4+0CIj5hu6WJkTqsYcNtPZHCXvbsUq+f9mvtvzUY9ztjaLRJOI0gwAqL4580PvIyM2tex6JM4GecN04oTlbOiGoDDeSWxSHqAglGMkmOFOG9ui0OzFF7Lrt/VZeApn/SUMeeIcdrTuZu9vzmg49nyCqkN79vDN46sWmSgEm1C1v1jzQHUX64vpH1fZ2HR+nTqAPV7P+WZh1NjYOTTeS173qA9eODKkpOvyj3szTtap9eQpkDKZzXoZG+E/MgdH3kVbnbJe3IKznHqlGs2ZWQ60of+a2FO3syyXnzfIW6pEN2AYQCHM5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NblBCRrF86XjAL6RUouogtW7fqpZ1I76D39y3GsZQjE=;
 b=YY5bRyi8RKtwee4nM1ySOJZJ57WoXWIfE3rgC28VtI7JrQUqCFYCrjUL8cRyJX1D9AX1BUgNNG4k7jo60XT94rbNmayDiab84GyKnfpZVk/Q2UgJ+N8otjqFsP0sy6k7iQbWQwyw5HfiwanbTrwS1xtbnOs7Eb/XUljLntePcet7stg+1JdIJZHtleVI8wxXu8ZH4UgjkphkhCuTpPfbxm/kHevD1Xvi08L5nfs2FvCLdVS/XI5mX05TQHhZiXO66E4dzMqD9/yX/RqI6k0chNQ9fika0cU7WA0zL/vv/EEpkcOyjCgmUYvfx2m3jZedAxxb3t1+aLjDp3ar48vO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NblBCRrF86XjAL6RUouogtW7fqpZ1I76D39y3GsZQjE=;
 b=b4rErWWyegdsDYs8txTEFL+HVl5gTrIu3mOU13+CcPia97Jb72snMikq0yRU0xDBQ9xl+Ra+3iSyKNSObXmlKJsrFlr039+bcKOPNp6JiJwvnvs3htjxPdXoAvbK1vkSwENSYh2M51wv0prDY0m3Sx22ZOoXnP0NCn/jcns1qj8=
Received: from BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:16:52 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::72) by BN9PR03CA0229.outlook.office365.com
 (2603:10b6:408:f8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 08:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Thu, 23 Jul 2026 08:16:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 03:16:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 03:16:51 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 03:16:50 -0500
Date: Thu, 23 Jul 2026 10:16:48 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
CC: <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 2/7] target/microblaze: Use TRANS() macro for typeB
 load/store opcodes
Message-ID: <amHN8DbvLaTfvofG@XFR-LUMICHEL-L2.amd.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
 <20260722160807.24031-3-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722160807.24031-3-philmd@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ccb4de-1e29-46b5-f343-08dee892bff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: mTLmKrdTRqQfyRyFr4kuMRzY3pO5qhU6kCh7e9pKr5LVU7pixhMcoqbyadjOoA9GuoUrBH8OYCU7UhLbyGjgtih20506jrwUJ96vj2El2N+VMBGroa8X63cSKb3+anF1Xhifc5izDa6HxgeJ3k0KpBDRIk1y4WkF/Ac+L7UonYmM3m53NFgZdSrOvrtcz1iaQ+cQUWfXQhMRHQ4ajnyUrDNXuyTr4wqsRHhQKgQ3rfVDxCHHSjA4CNR9uO15qv/NOQ9om0c5Hchmv3fuMQ3F5Dc8y/LzjdExWjtg1z8n+l9ptFIqjnNGmuAl8iNoO5BmUnxOK6Q5ZCqqODUrbWHPYx2giZy5KbCC0DtKimWTewMgcXy0fC/y6WLiMMSpkPOJYp601nG+wQmsA5/IwqrKd1+AVVsZVX0Y9E4+/LITKOUhnsBrT3T2KtNJbnGRKrl+fuyJv2dGBXYIT/UwNVUiB1craDqlhB352LJTYYp6ryn1j+W/qFnqq9ZbJv/oCUNnmzt6nx4QCRpZQxxeXCEca6JMSqBdKAcx7V1pBNC8l2F7fAJO9WVDSxg6EWJznksmAo2hcvDmkpfS1PTlfXOXn25co0tbJ+aj8ZRGDmq+MGpKo90D/JdnI6Fb/xlyoj0xY2r+cGs28L2Qo8ULninEJYqmuS7Kn4nGzcT1vyp4IGrizqsZBf/aITn1qQdM4cYkrmGPLWFNfzegxubjW6xQMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jNeyVeu5va9S970YTeHfWZzXO/+rckrvm7UefBLd2km5iXl9n5zzb7MWRyuRiWpMYdNCS95R20+uDM3HC82dAju9/LHk6oZDHxPvbhn71g4PThy/ihYP9nJjHj+M6MphJP4V1dKMfex757PcYNR8zHAZ4iK56KpIQcOVsbrj4ijuOQnhxEgYthyJJm/qR8EZYMfJKPyhrS2MPURldw/TZkkY87Ma5p1FtYQRWaCzPVnHRTQJxMDid/EKzdV99fhfDooE01CWnFuGersoY/330lxXPJXEUIr8YG6hkgUnafz8ixYIGK/Fj6diFZdxnyXO1cnv0NdYxphqhyGiexAgAvDb7518xBRjhabdaziohcu5z2Eir8pN7YbIvbQ2KLTMuzd7TgsV2vP8Rj8CUtxK7z73V5x1BfE76qwTekLJckz3e2eJFgiWZmJgZSjXKjG+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:16:51.6064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ccb4de-1e29-46b5-f343-08dee892bff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Luc.Michel@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

On 18:08 Wed 22 Jul     , Philippe Mathieu-Daudé wrote:
> While being a no-op since the TRANS() macro expands to the
> same code, this is less code so less maintenance.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  target/microblaze/translate.c | 64 +++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 36 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 623980d0af5..a2a7ee8b9e0 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -253,6 +253,14 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
>      return true;
>  }
>  
> +/*
> + * Helpers for implementing sets of trans_* functions.
> + * Defer the implementation of NAME to FUNC, with optional extra arguments.
> + */
> +#define TRANS(NAME, FUNC, ...) \
> +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
> +    { return FUNC(ctx, a, __VA_ARGS__); }
> +
>  #define DO_TYPEA(NAME, SE, FN) \
>      static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
>      { return do_typea(dc, a, SE, FN); }
> @@ -738,6 +746,16 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>      return true;
>  }
>  
> +static bool trans_ld_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
> +{
> +    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> +    return do_load(dc, arg->rd, addr, mop, dc->mem_index);
> +}
> +
> +TRANS(lbui, trans_ld_typeb, MO_UB)
> +TRANS(lhui, trans_ld_typeb, MO_UW)
> +TRANS(lwi,  trans_ld_typeb, MO_UL)
> +
>  static bool trans_lbu(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> @@ -764,12 +782,6 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index);
> -}
> -
>  static bool trans_lhu(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> @@ -798,12 +810,6 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index);
> -}
> -
>  static bool trans_lw(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> @@ -832,12 +838,6 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index);
> -}
> -
>  static bool trans_lwx(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> @@ -893,6 +893,16 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>      return true;
>  }
>  
> +static bool trans_st_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
> +{
> +    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> +    return do_store(dc, arg->rd, addr, mop, dc->mem_index);
> +}
> +
> +TRANS(sbi,  trans_st_typeb, MO_UB)
> +TRANS(shi,  trans_st_typeb, MO_UW)
> +TRANS(swi,  trans_st_typeb, MO_UL)
> +
>  static bool trans_sb(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> @@ -919,12 +929,6 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index);
> -}
> -
>  static bool trans_sh(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> @@ -953,12 +957,6 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_shi(DisasContext *dc, arg_typeb *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index);
> -}
> -
>  static bool trans_sw(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> @@ -987,12 +985,6 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
>  #endif
>  }
>  
> -static bool trans_swi(DisasContext *dc, arg_typeb *arg)
> -{
> -    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index);
> -}
> -
>  static bool trans_swx(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -- 
> 2.53.0
> 

-- 

