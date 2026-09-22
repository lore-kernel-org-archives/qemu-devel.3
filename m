Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D24AC982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8w0y-0003Up-TN; Tue, 22 Sep 2026 04:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x8w0w-0003Ud-Pm; Tue, 22 Sep 2026 04:38:10 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x8w0u-0008T2-FH; Tue, 22 Sep 2026 04:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX/qVaI5MXscaEgC9MTZdCPMP0dM19fq9K7Vdsd0xC4RgNPKqdS4Aa8x65vd0C49ikN9homo/JpaBpSg8KcBKPGxohgRb4ZGKA+HFvmcToKLT2yiJkwee8xLsLJpSYAM90hqJ8yEZautde+eYZTGSQaVwvrUtAWo0B77JXgnnK3wNhiBku72rzRDHRT181oZmNMvzPc759SzezEXEB62bwuP+0kkAo0ns6PQt295PVRGphx7Gg+xkYJoIYNybn4dRjFlNwv1Ec4rj1/asAXI+GymtaOML5Zk89paypmV+BKyfmhrggU95mECvSIpRePDVrT+1A0xfVfUUyUmGC3mFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LC7Wbjl1jT4E4L2v6rG/w9jsLIkx0LxIwlp3Yb9uiBs=;
 b=G7ekdDa3wXxo2AyXrmkFTp78x2R8h7gNbAqhsNEddQoxplfUFcKUJLckDyGCoyM0B/iV8esaAPwghMPnLhN9zudHudlnjFgpLIf8NXaImG0s+KEte6yMmOm9TCd/b49t5xNF910EIg3CbJ6vNbCcGmGPvj4sN2Z09/v8Pg5U2pbPumU53RLATu7ilnz3uaOwYTPgLSDftj7hBF0lN9cWosYscmAa5rnm6N+B/hFBapDYEXXoqbRzurvufnbN8I3exHu9PCugn/z4cBpTedOGIJKVyFBGBYlabNbyAnYpg3r2yFyQ+qMKO4W2TO1MkzUYRswJBVtVllpB8hM1QyiNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC7Wbjl1jT4E4L2v6rG/w9jsLIkx0LxIwlp3Yb9uiBs=;
 b=ELpMB2fNE1XSQB7y/w9Zs6b4TdozYAQ3592kWs1XcOgBs7si7goW7iihyjIu9nnNfvrpam6vN3OqTr5NzpP3mc2aiqnNxhwubzF2/q7lywW4SuG3f3pbmfrlLQAsI7LCajIET8ve+GD9M4d8vFAqUR789hkmOE6IK1gTNcsJooa7ACmXoy5No6a6d+CqwJQPaC2qnK97/FxLBhVdfGtk2Ly49iZApeZHeOeGMFeehz0MkgGihR0biq36BLkqnsgBbY1R6xWxFIN9NKotVRVa6yfDjkyQY87Lw+PSLSv8hUdqBBSc457EUFc0TzQNRa6LGzN9tnKpk0VoRhmWw78YQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB5939.apcprd02.prod.outlook.com (2603:1096:400:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 08:37:51 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:37:51 +0000
Date: Tue, 22 Sep 2026 16:37:41 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Shunchao Hu <hushunchao@bosc.ac.cn>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Tianze Wu <wutianze@ict.ac.cn>
Subject: Re: [PATCH] target/riscv: add hgatp-specific WARL legalization
Message-ID: <arIUSjCzSzp5jcrg@MacBook-Pro-4.local>
References: <20260920-riscv-hgatp-warl-v1-1-2e52f78c8027@bosc.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-riscv-hgatp-warl-v1-1-2e52f78c8027@bosc.ac.cn>
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dded50e-2cd7-499b-64b0-08df1884c8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cbvWWJkab98FCOySKLH35sT+SXjmhkyMM+2WjhWPJZka1bE7NdJ5WSptgIOtRQuADJItxSHp5h2kMdAkeoQ2VjU0nNq0yycZeWmW7Ext+jZCvMLbs4ONrLoYzxaPS34zB/45LPPJuLgo1UVxohsHqW6pROC+UqIpnA6iCXCVZ3lm2t17ECnzuslYVDiIsLxysQ5psQ62UHJBDPdEaxGyEv90JPJGO0WCJz3Neon+Uy32uwhVpA/95dlRaFHJ/tPXHPjTL7zs8jKh+Wr68IYuJFsb7O3iloe7XCqxCyKjaOWIgGDJ7BE12XikH8VGj2i56UZvN0JUXuy7nGl++k2oBDxd0o2Ef90GKtiqPdAmdqVYgprPPKBmI7lXdUcevw5qMOTyOBzg7jZi7LmLvuB5CfSL2qf8U4SuoLurwoTc4WKwW9Pw2mRAleaQ8Smuhr4IGk03eS2or5Ln8Nu6MJgoCbZScso4aYkxZsf9QZ0iEb0Hv7KcUS5XPCotcKEUaVqb6gjfF6MQCaDc+Bien3VJ3zMB/66ypL/Xk6jne5TqWipxUhLeVRVEm7X6YP7haM+ei8nSulh9Mwsoq7MfH08moAgauWSaDZmMIdsgLPh8mULAPn6+tsMQ+DZO02u/a6DC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q1vX0NRLsF4djpv10PYK3qutvKE3EwPvS6APNSe2tTecOCxe0S0EadfDvW6H?=
 =?us-ascii?Q?Qf/qA1n3bbIQHtI55xmzSBMbixA8xO8VmVhDIOhlNISA3n71cdA+89ru5VYu?=
 =?us-ascii?Q?CktwnNPqagMWVkZrEqDaKCBDnp6FNQCTpl4s82foDR9fQp/oEJO9ZfyM/sMX?=
 =?us-ascii?Q?bzUBwGb/Sryos1+n154CaXk1P+JjdiD4VRddLqk+q67qMeh5nED72S1ypLu9?=
 =?us-ascii?Q?CoFZ0OGahtZjEbDsI+k5tQNeZ7gVR+wTvvrNdf4Yu1f2IaxAUSC8u4CBfIrm?=
 =?us-ascii?Q?Pn5sArTHOqDa/UbcSKwJeXJmZRpgS8XckOcVo03vatqfTCMUpxIrPRNjiBat?=
 =?us-ascii?Q?RNjNd287irQRvKloOtBFJ66uVi8q8+vDD7rJ1w1XHUNnTqT+oVujlBztAPZI?=
 =?us-ascii?Q?agLIgOMYm4C9OXqbpk3yIL8ArOuW/iPAH4NBhjfhCMr445uTd90YurD0LVT2?=
 =?us-ascii?Q?Er0oYK8tvo+Y2OnmwxGotZ6epoLxKXa/QFPLRo+V6G2XKxa1j0bvqsYqacp4?=
 =?us-ascii?Q?2V+dmZMvJBz+KIi7gdNyj7pSQqJnVYglYdW5fxAbueNkxj55WKAze2PPM1Q2?=
 =?us-ascii?Q?A9Awa7OOHr8VoQ2o5lxJ/FTUOYsfCeXpeuz7asG8W6qBcKv8I8dyiiwAVCQA?=
 =?us-ascii?Q?uc8tOBnpI1lU8at/uPbSTNZCEliNqW1P4THNqZCdd4nhP39jQ24sVhXg6Q+d?=
 =?us-ascii?Q?k2PAdujp5oij5DAZVaXcKDG7Y3ww11VA3RCQ0tabdEOiEruo6LftNXt/dFAq?=
 =?us-ascii?Q?hX1qM4VlyrdGT7hlzZOmuIKjdbE5U6OnwF2DOqpXspOfpfETD5bfjp8IAA2P?=
 =?us-ascii?Q?oSDYUybRHi/YYPU6swu4KjXalGnXhs4PQt3MxhwMnunD3i61EQWnl8Ow0Zkn?=
 =?us-ascii?Q?8I5hE9BRNUWWjaVcwsZEx4abJIbekLTwADEEWJfcKYA03rWFqAt6E1pMO5n7?=
 =?us-ascii?Q?dc9cgNLUSFSMSwXH1mltkr1XifYzX/Lokzg+lAAOCnRGDdcr54Uot2jpV9pf?=
 =?us-ascii?Q?+BPrvyeZvL0UFdXSVse/ZV2gR5hZ8Mr2nQF/SJQS9RuUkI1BHF3WHp9vkjxm?=
 =?us-ascii?Q?gFTTaju/Rgfv4yHZkdLh14mxMQzCE7lL92H+yX26Kn+nJXmozVJtJTTk6DkH?=
 =?us-ascii?Q?2O6bQ8zzf/Nx5cxviO2zXdKI0RMshki9BietKUuccTZh+TZhgXffXnjgFLPQ?=
 =?us-ascii?Q?BXyu6wgDA1WSzzRp6UBh1nuHfEc1ySS6pjGzoGvh0ZLDLBRmp8Mr83QKtn2E?=
 =?us-ascii?Q?rgLlZs3Q5eBwTYM7WJWwUNE9358EN6VzeyP8UzCgVzq+zcRVqw0q4X3cbOSJ?=
 =?us-ascii?Q?Ls1QZYBx5nhOImQf2aZgVs4DY8MK7lyI+BkOh2/GiAMGWVXTY3KPIMV3lpkn?=
 =?us-ascii?Q?blqi3QCBrLGjLQtSHjDJbs75A9pFpq0JSKJaG1xfS2uWZ4420ieMXkX2ifcI?=
 =?us-ascii?Q?rn/0H2w0kMOiiwy8yuVG8XwsJvPCGq9lt6uzZcl5luefC6uL4A8nraDc+iMi?=
 =?us-ascii?Q?JIjGgJk7NTKroj60NvkPsfANpJNEEf8iQ9QAKNmxWI9D3ErqCz6yJxWoJGfp?=
 =?us-ascii?Q?yBNnjiv5MgbMnE3ts0IRX/7aCt5/rSTFF4EElqEDrbtPviOgAbGu/Hh2Nar3?=
 =?us-ascii?Q?ZMBG3pXaAG0furqF2EMoiaKPSBpTlJZHuhgbLWEidNM+l+0Lx2VoFnHa1BF9?=
 =?us-ascii?Q?5VskbjH9CbWUelioZjdL88gH/KMRUTtjMMhPd/kPNQdZ14GhfhL4ZZCkRJtk?=
 =?us-ascii?Q?XR5Yfdzv0AtF1wjpBfKsOBFb5/pPGVQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dded50e-2cd7-499b-64b0-08df1884c8b8
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:37:51.1010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gDIuBHm1IxIpSRg0Q//9Und6dg8iO0i1pFBFmLMrTzb292BggHlDPc2T9LHJYzV/La5rsfD0BlbTaDQ2VSgHHPC2aR4Ieb6jUOE+5p//ME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5939
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sun, Sep 20, 2026 at 10:39:39PM +0800, Shunchao Hu wrote:
> According to the Hypervisor Extension in RISC-V spec:
> - VMIDMAX is 7 bits for RV32 and 14 bits for RV64
> - the fields of hgatp are WARL in the normal way
> - the lowest two bits of the physical page number
>   (PPN) in hgatp always read as zeros
> 
> These behaviors differ from those of the satp CSR,
> so hgatp cannot reuse legalize_xatp(). Add a dedicated
> legalize_hgatp() helper to implement the hgatp-specific
> WARL semantics.
> 
> Co-authored-by: Tianze Wu <wutianze@ict.ac.cn>
> Signed-off-by: Tianze Wu <wutianze@ict.ac.cn>
> Signed-off-by: Shunchao Hu <hushunchao@bosc.ac.cn>
> ---
>  target/riscv/cpu_bits.h |  8 ++++++++
>  target/riscv/tcg/csr.c  | 43 +++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index c01050ce2b..c4a914411b 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -711,6 +711,14 @@ typedef enum {
>  #define SATP64_ASID         0x0FFFF00000000000ULL
>  #define SATP64_PPN          0x00000FFFFFFFFFFFULL
>  
> +/* hgatp CSR field masks */
> +#define HGATP32_MODE        SATP32_MODE
> +#define HGATP32_VMID        0x1FC00000
> +#define HGATP32_PPN         SATP32_PPN
> +#define HGATP64_MODE        SATP64_MODE
> +#define HGATP64_VMID        0x03FFF00000000000ULL
> +#define HGATP64_PPN         SATP64_PPN
> +
>  /* RNMI mnstatus CSR mask */
>  #define MNSTATUS_NMIE       0x00000008
>  #define MNSTATUS_MNPV       0x00000080
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 061bc9db77..ef08600ca7 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -5050,17 +5050,56 @@ static RISCVException read_hgeip(CPURISCVState *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>  
> +static target_ulong hgatp_mask(CPURISCVState *env)
> +{
> +    target_ulong mask;
> +
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        mask = HGATP32_MODE | HGATP32_VMID | HGATP32_PPN;
> +    } else {
> +        mask = HGATP64_MODE | HGATP64_VMID | HGATP64_PPN;
> +    }
> +
> +    /* G-stage x4 root page tables are always 16 KiB aligned. */
> +    return mask & ~(target_ulong)3;
> +}
> +
> +static target_ulong legalize_hgatp(CPURISCVState *env,
> +                                   target_ulong old_hgatp,
> +                                   target_ulong val)
> +{
> +    target_ulong mode_mask = riscv_cpu_mxl(env) == MXL_RV32 ?
> +                             HGATP32_MODE : HGATP64_MODE;
> +    target_ulong hgatp = val & hgatp_mask(env);
> +    target_ulong mode = get_field(hgatp, mode_mask);
> +
> +    /*
> +     * Unlike satp, an unsupported hgatp.MODE does not discard the whole
> +     * write.  Keep the old MODE while accepting the other WARL fields.
> +     */
> +    if (!validate_vm(env, mode)) {
> +        hgatp = set_field(hgatp, mode_mask,
> +                          get_field(old_hgatp, mode_mask));
> +    }
Looks good to me. One thing I want to note is that the RISC-V H Extension Spec
does not actually define how an unsupported hgatp.MODE write should be handled.
It only says that the write must not be ignored ad it is for satp, and similar
WARL, see:

    A write to hgatp with an unsupported MODE value is not ignored as it is for satp.
    Instead, the fields of hgatp are WARL in the normal way, when so indicated [1].

So keeping the old MODE is a valid choice, but not the only one. Could we make
the comment a bit more neutral?

[1]: https://docs.riscv.org/reference/isa/v20260120/priv/hypervisor.html#norm:hgatp-mode_warl

Thanks,
Chao
> +
> +    if (hgatp != old_hgatp) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    return hgatp;
> +}
> +
>  static RISCVException read_hgatp(CPURISCVState *env, int csrno,
>                                   target_ulong *val)
>  {
> -    *val = env->hgatp;
> +    *val = env->hgatp & hgatp_mask(env);
>      return RISCV_EXCP_NONE;
>  }
>  
>  static RISCVException write_hgatp(CPURISCVState *env, int csrno,
>                                    target_ulong val, uintptr_t ra)
>  {
> -    env->hgatp = legalize_xatp(env, env->hgatp, val);
> +    env->hgatp = legalize_hgatp(env, env->hgatp, val);
>      return RISCV_EXCP_NONE;
>  }
>  
> 
> ---
> base-commit: c1c18d1e640b64292859ce9f30f3c344edfb0294
> change-id: 20260920-riscv-hgatp-warl-1e48fd321188
> 
> Best regards,
> --  
> Shunchao Hu <hushunchao@bosc.ac.cn>
> 

