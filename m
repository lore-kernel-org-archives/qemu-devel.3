Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EDBC531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmomC-0005Ma-L6; Thu, 23 Jul 2026 04:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmomA-0005JO-HS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:27:31 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wmom8-0006P4-3D
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:27:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q80mO0x7b87R+4hOkjb6BeJS2Dm5rxjkBSu5WhiR3eD+9kuk/S+9wlFVWNQzomYwhJ6tEX5wfhrF1oYkHIx0OidVTSgqFWXyVsb7bfNXGIIMtl2kqCQAXwTbU8bLVPz14j/M4n8q99H9iOzHvuYl9n1VyD3eUa2pUK5Gyxxvza+HxCjj5lnhQ5NmV0K+gGP6eqg60xUayvBXgVriOTzTmGR4HCP6ccqoKkoQ1Zn0nScb6QAoElddYjk9orqJpvxv6S1cjF+btLYUXhktoZk0Z7KwvAqNp4jZa7clAEdDxqJSmSM8vlCloAq0nobrnXko7KPeFdhSQELdcoxD+W9QHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcraXMSVVrhkyMp2awax9m3eJCxGWAFZt/sxX50he2c=;
 b=FZivI1SlxUEGNbF2GV434fSsSymSpFoLr/za8wDC5GrkWw0EOdbHy6wC4Y/82s7ejKnjFF7md5Cg2uHl50JZpY8wsO5bvuPXR38gLDZ9wYIQzd/n78Q6Rc6kP6fBOzHsPLZq0XjN9O0dwOODNKoLY6i74B6slju5Vc2pq+yFX5zYhcwDViHpHaE96g6r1Rh+Y1V/ePSUuRzzzejss2C+0OVwTfEajDiyWiiUOiCZC1lY+GFsZ0hFDT/Nez7GX8OGTGC6JMCrFg1PVUF6eoCu9rsE1yuv6EGxSxDBPFZnIdtto30i8mivXr9YJ/mZEVxMjWhc8HXCqomMyAtL5dtM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcraXMSVVrhkyMp2awax9m3eJCxGWAFZt/sxX50he2c=;
 b=VFkPpizSm4Bgmx1Sh7oqks+6/tx+9sdGiC1Z0G22tNSGdnaB7pN1RxSUj4N4SU/rF8zxv5htjj4CeElXHScsQAf6fkxIEdG339o2wjD3jXAIYkhcTpUUNDOS1lL/PV0TWKhcv80gT3FVspDjbA2GueSSNy5ewaiHBscJpAWsBbU=
Received: from SJ0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:a03:2ef::30)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 08:27:15 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::86) by SJ0PR03CA0205.outlook.office365.com
 (2603:10b6:a03:2ef::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 08:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 08:27:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 03:27:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 01:27:14 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 03:27:13 -0500
Date: Thu, 23 Jul 2026 10:27:11 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
CC: <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 4/7] target/microblaze: Set MO_ENDIAN in
 do_load/do_store callers
Message-ID: <amHQX7auIZj6Z5Lv@XFR-LUMICHEL-L2.amd.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
 <20260722160807.24031-5-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722160807.24031-5-philmd@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a10f45-db2a-4dd5-95c4-08dee89433d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: m3tZCR7cL9UDpG7/fxT+vYUO3elBNiC7MWZev+CfNbhvPx/2Ty18xnTJEbaqYuBw/64I0zOyWrirp0rzZx6D9cVIsJTdrfbj0EFvdJgXv+2o7ICRyg9RXT69ZY+7gg/z2BWMl2fRZNWuut2xyj1zPxI4CVdvRr+5ROgxJ8oYDM2EKLJIakh732T0BTJQ7BKr9IKgkr4PZ+Be35Jx12u+rwolq4WqAOGLaovjyqXvd5HLMgUmt22WYJvGyL3YW5SYdumG/nLkFZvjLQydFKh8IR+M6ThZBD3rGzG3G+D/4wcy1LMGpuiK/ixczvkVAQ0LbPfixHk2xfa6YXvNUYhjfG8A3vszZ88NPtO9uA3qkD8O9XZlKUdJcJ6cdfXnAgpGDrcVCjWyAXN3hKtLhAk07WHlheigP3Sg88cxf0X0ifqysSvXb/d6C4ah96lD9dmANQ2LjGPw6510xBF4PJnxQ8fGWjWRGX+Z9t86PXrd1eBSzWj6HDoL2ay5Mzwt+OEAnepV3VrIpFkBlLM1viyTrqwUVsTXvtRO6BY3hXBUFkDxjShbMqkUDGTg2ISx4OpawLk8ktUuyP+jaMe71949NQ59g6UJnlw4t9mYb2hwFM4gKMukvf1zHzmNczIhMDGscLltjzm20GTnMQmhKgsajm5ghiF8vwjP6WGxS8mOQXqg5TdCG82KL/G3d49212FEtczGA/j26P8z/uW8H2kmhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RtrATKGEcsJI1jm55ksAX7SGU1ItOczGtQVhifuVXQHs8ACbNM/xy0nHc0aG7atxHxT258E+j/27B6l9mE7wy4xG7VC3QreNC9LQgVwCytthqQugpnek7PMXNqlT8O6PkW89cfkxiFHTvVKE9fr4WiDyswpnkO7PAGUBFJQ6QOJ09OyqkS5tr1eQe1NJUO55cg/q4M0Xqa0Rt8sgqtr+nQceOa7IWhqwzDAcwsN4vxYvyj4VnALAPY7L/oAJGMdjDgRRyrS/2fhr1SfFgOWDvjSKV2JluhxbQ3elN7PHgciDuqX3cVnxOEoilJGYXMtD1UWMyiMVLB8fsAA3C+K2JMNwGGaLQv2DfMJDaveZ5QP0RjxfRVzRCv7qFG//VSnt8wrUoiigqd0pGohND2GWb2u9vDFTjAe0kngBvJFpQ96Q7NRzeqQ+LGS2Et0QRvHB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:27:15.4415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a10f45-db2a-4dd5-95c4-08dee89433d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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
> Again set the MO_ENDIAN bit in the caller rather than the
> callee, allowing to further simplify.

I'm not sure I see the benefit of this one. Instead of having the
mo_endian() call in two places, you end up having it in four places.

Add to this my previous remarks on patch 1 where this is replaced with a
`mop ^= mo_endian(dc)' plus a comment expliciting things, I guess I
would leave this in do_load/do_store.

-- 
Luc

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/microblaze/translate.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 3f2de375d97..d4826981913 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -716,8 +716,6 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>  {
>      MemOp size = mop & MO_SIZE;
>  
> -    mop |= mo_endian(dc);
> -
>      /*
>       * When doing reverse accesses we need to byteswap the data
>       * lanes on the way back into the CPU core.
> @@ -749,13 +747,13 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>  static bool trans_ld_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, mop, dc->mem_index);
> +    return do_load(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
>  }
>  
>  static bool trans_ld_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_load(dc, arg->rd, addr, mop, dc->mem_index);
> +    return do_load(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
>  }
>  
>  TRANS(lbu,  trans_ld_typea, MO_UB)
> @@ -839,8 +837,6 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>  {
>      MemOp size = mop & MO_SIZE;
>  
> -    mop |= mo_endian(dc);
> -
>      /*
>       * When doing reverse accesses we need to byteswap the data
>       * lanes on the way back into the CPU core.
> @@ -872,13 +868,13 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
>  static bool trans_st_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, mop, dc->mem_index);
> +    return do_store(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
>  }
>  
>  static bool trans_st_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
>  {
>      TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_store(dc, arg->rd, addr, mop, dc->mem_index);
> +    return do_store(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
>  }
>  
>  TRANS(sb,   trans_st_typea, MO_UB)
> -- 
> 2.53.0
> 

-- 

