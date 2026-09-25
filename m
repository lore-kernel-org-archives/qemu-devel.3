Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F249C9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 23:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAF7Z-0006te-UE; Fri, 25 Sep 2026 19:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAF7X-0006tR-OZ; Fri, 25 Sep 2026 19:14:23 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAF7V-0006bb-Ao; Fri, 25 Sep 2026 19:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6ja7TxnWi0Y0GRLlEKt0o9wIrvUWL/SnVC3+sKGlepC1UKaZRlnokBfxwEGFFkK2xW9+C6GgIBIyt7BlUUy4qSjEEuJwJfwPu65pI3QaGMRX4KqCGatOwn3XMi5CtgDy3xsJUndC0HUXT+pVrUiC5HfqcLt6bl5px3LZ9iaG+blbFlfCS+fDj+eTSwX83fmwIzaPo2flZ+SbXv9QmZRTBRalVnrM5EnnKfaVZGewFZqXwI9ef33Op9MOP/gf74d09htOXCbgnxixW2ukMKnfOjgSnno+PJNVt5NQmRNLDGLBAO/8euQLPSfcPOyhB11DsvKzcEesxeYNBgR0vaacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJUMRwWkOCq7rf+irJn9o9t56bu0EonyEJOhK+by66E=;
 b=bZWmWTLLZAxLf/yF3gJ8uzWfNsP7e/AjKQjlklP5my7dRvv7+9ODPZ1L8gcUUC5tG+jP0ex/CmcTmZOjLG7niicQ4yKXYFl+yGkBNr8jHZ9hI0bN8YFOfdRz6JmmzvFfW9pjw8gvIkCdC7prP0AJ/3nyTFY1ZXjxke9EfRu0wT4hrXskz5NfxOTPwrG9ZXO0voY7ZZdx1NftLv/SRPWpx79cELBo5uwVVBB4j08b5FGG9vg1YaoyBHcdA8FwDvn2xhNfxIJoRRm/RtAtmYtJ0ezNACC3QaxMsEh6tvjx9aGu7fChNH1B3vuSwLdGTYfJzH/9Ro6ko+HSH0hg/718JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJUMRwWkOCq7rf+irJn9o9t56bu0EonyEJOhK+by66E=;
 b=XXGB3fsb+ABGuL14r30hELf57XAnJrRmVvrbKV3ze+nb8ts1eaDuZpsltEynNyHHhuqQR38DE7RZlAsxVaXBiOQ5ZOe+906AWfYQ285CU3CkNaWE6oE+oJc6ApZjIZNCWfJhCtCwzEbWeMAh3SxNbhWQOGq5AmD2PyNkdCrva8jkK4MSae/HjGt7CI90dSVdsUgoqxqz3hVuBe/pTR+3QUvfGM7DIZLSZVF9voXP4BgTAKW2B2bIzR4JUqb40LV4wL77iGeF2HMq1yS7vw2EQdfeBs8F5zxHC1hoX8j29IlTcqb+DQUPXd2jj8e8hGpuxlfFO21ckFHHli7uIV+w1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE3PR02MB9745.apcprd02.prod.outlook.com (2603:1096:101:322::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 23:14:11 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 23:14:11 +0000
Date: Sat, 26 Sep 2026 07:14:06 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Shunchao Hu <hushunchao@bosc.ac.cn>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Tianze Wu <wutianze@ict.ac.cn>
Subject: Re: [PATCH v2] target/riscv: add hgatp-specific WARL legalization
Message-ID: <arcAIT4Y9xdc3Dx0@MacBook-Pro-4.local>
References: <20260925-riscv-hgatp-warl-v2-1-2aa9aa7718cd@bosc.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-riscv-hgatp-warl-v2-1-2aa9aa7718cd@bosc.ac.cn>
X-ClientProxiedBy: SJ2P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::16) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE3PR02MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 90556d68-aec9-4302-65a6-08df1b5ab556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 99laHp6ooiq00R2laEDmRT5FUsNSZwL7Dhqs6xMVjinHWkBy+sEeqCCU5gnxTuH2+2sn20bBS0EMkIE1Tc2getQ+I5NvM2GRdpT2KIAU1FJrY2+QTWNF0u/J9pJ9NT27UIZg3Yu3ANjqIy1IqwiRKj4DvvX/krvT4a4P7U3kDumLFgHxM9BGP6Hb2X8qkGVC0gbxkDfRjXZX7NutFmTZID9irN4toTN9SNIQgU4ks4fBwfScYXcvGo8oF6buOUpcdJrVoB1bwpfwxs5MTS46x2r6XOuANIHZxP5DT9jMS/S4w4sl45UK4mhEmCuogM+FxEAA+rVxW/tZowC7ET9u1iQNpe7uxz71giwaR91EDJudyg+XNBdysMBq3dr5DM85e6XzITzZNdOcdERgByepyU94qyDxHXKy/ld1Ws0jzzs5URulhMMbNJg2k+55PuUPKKMCjkLEtN/5Zb+5Sysv0GoDTMDGYCI0xaSoxYOne9TcL2azOMT8xkoO6J/hxBGaf/WlMcC8WnoUQNT9hz0SEhT0x/WwZcHKn9SmmU5PEYYIGlv+DV2pcBd1p4NTykosNcf7iKRuU85VdaA0L1R0hHz1nvHeWU0ws7e21xHYC+0SjmtuJLauItLzDMEjqXAS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?87M8nw3QDpixodOyLRFxgqEc1ZUQHg76liPzukaI30BOqOh1iLwZO7F1GF0+?=
 =?us-ascii?Q?ilkUUUc2k8d/IVeJYN/VKXMjsYe8klFfNp7SSvC+tYylDFyVhi8zcIKiZVyg?=
 =?us-ascii?Q?p8k62PYDkkWcHT3jN0zaw02rzvnlwRK+S2ayYGWTKIBlrPp4Qq4iEmgxVnsx?=
 =?us-ascii?Q?GpZoaJQQi3uz/OPdtcclJ8Cp/u7t2WEf9uIKJzE7ot23yNgnDTSIrqeMuKcx?=
 =?us-ascii?Q?pjEzQBlwSUrfPOGY11cW9Q289uk2e3CJY1gtqVGZEJhLGXWpQ67WCIk9rgnb?=
 =?us-ascii?Q?qarAg2wzIQ8ANIViL/HQCpahEPwjoVLzuctjDZxPlU7/fDoxvfT9x5x6sfzO?=
 =?us-ascii?Q?2hEG/YvCoTf2gX+jIgC9BU3I+0SeMOpVwlah+3YE2jk4jZRoFjE6zgga87q6?=
 =?us-ascii?Q?13Ui4HKifuJTEJPZb0F/89v5U5UNyb5BEmXCjYoOoYfrLlh9zI+yMrVPwKGo?=
 =?us-ascii?Q?uXRUDy9tzqVXBWbsAN18S9R1zvhlF07/273hniorXHe3+Pr+/JaSwffJPPow?=
 =?us-ascii?Q?W+rQmrcHB0W6uIo0RL1wjL6VxK9YOaNNVkLJxY4/HSpCYQMnLNPTuNRBtnAu?=
 =?us-ascii?Q?iT+qN6MRcLyIhP1bJzZZL+uV7bK/9R32X84XYNjonWKzlkn3usDI/WyGjpev?=
 =?us-ascii?Q?bG3L8gf6jhMAgqhMNAolKBkzwt/VSuut6TmUDHui4r5hOzTCwDpvlyf7Syex?=
 =?us-ascii?Q?B2guDKmdEClFXDLuP2xWNne++doG3n/JELVf6fF1wLA6RUZr8gN7/HNnvuor?=
 =?us-ascii?Q?ZO2tlT8WXUv0Ch3NsYGumd57B5bi4xc0VmFSkf7qzvKLNwV2gaZJF/wtX3RR?=
 =?us-ascii?Q?Sxa3iDodJrdKaXNjLT6Zi8VldhVqfq9vgyaG5H35aIIS0XeT9nS3VCZ63Qx8?=
 =?us-ascii?Q?2wEU6PZeGPel8z0u3GDUfSNzXvAC4y6gYYm7H4DjHlGrOdzu25sdbG3Y2UWY?=
 =?us-ascii?Q?G6Bk6LW8qyuT8sVno5m8rSSHGbC/PAuKc+FlVRxRCIxRcRcKA2XP29JptCVQ?=
 =?us-ascii?Q?q9alW2ryAq6KJA9kHhAvLNpuPyIehxuQg+kAXXMpt6D2TbcnbEVqIhQK3YYC?=
 =?us-ascii?Q?Na+Oodd3DNtYw2I7s1k0+6nqeQ8U6myprxkYFRtogUZcNQF80NfUewuaLzPj?=
 =?us-ascii?Q?QDwZZMnCjUgV2StyHtqTxPo5yrvLP64unt+WO85cJPHx/RI0WqFl7qIsjoAp?=
 =?us-ascii?Q?yf2GQ6o5N7ReaokQGQbenZOrg9M2EvmrHtIUJJ5DsQOg0cf0BORyYa8I9O28?=
 =?us-ascii?Q?BICa+rBFo5wKsLK9lB6xUFf+4noHxebTZD+o/TyCMVWZZPHcWDQyfdjUw7iH?=
 =?us-ascii?Q?4fLoCLE+pcjgQR5hJt0FyIOstljIUmdxIQOajdh+rJRbq6FrQUCStrdcRbOb?=
 =?us-ascii?Q?Lyks3haCcy+t9xZgZvYMw5O3Xx6y1UqNSvDziPR0ZapYDXLYZM2+uGuwx93N?=
 =?us-ascii?Q?ZMyoQoqdj0w8woECMr3W6eIIUOP7lSAM9VWGWZ4onzUKN3aYHwPWumqCNUMn?=
 =?us-ascii?Q?7ooRVADDdmZIzzOIygxPnhxG28uYxS4feFtuA+UPvxiERTHZ9b4wlKCifpxT?=
 =?us-ascii?Q?8o3ENAuq+2UBDUY+bpXONnmvHpKxAyOa2HHMTmWXo4KdV2XbRoJrOGHD1VWz?=
 =?us-ascii?Q?X7M7y1XvrfopIgQKDbJiQCMFO92deo+ymV1aDswtqeAwD8nCjl803hI6ojcm?=
 =?us-ascii?Q?DkQg0LIvO/D+sBoQ6dgmA6xFBkqtJZTqycpt/6VQ/0DGtaxrM9TJvLpqWcfJ?=
 =?us-ascii?Q?Rr54wzyrwnFYbQQod/Dv+sR5u9+jgM8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90556d68-aec9-4302-65a6-08df1b5ab556
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 23:14:11.5069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsfRCeUXrXnS9OBAmMVTali9HhFFOsBzn7jVVFbTVQ1VawRBUAT1M63uwGfiteeEWBfNXqsz3x1sSWzUzCBDYaoYP6bkCDh2qYpomRJUlsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR02MB9745
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

Hi Shunchao,
On Fri, Sep 25, 2026 at 10:07:09PM +0800, Shunchao Hu wrote:
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
LGTM.

Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> Changes in v2:
> - Reword the comment to clarify that retaining the previous MODE is
>   QEMU's WARL legalization choice, not a requirement of the spec.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260920-riscv-hgatp-warl-v1-1-2e52f78c8027@bosc.ac.cn
> 
> To: qemu-devel@nongnu.org
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Chao Liu <chao.liu@processmission.com>
> Cc: qemu-riscv@nongnu.org
> ---
>  target/riscv/cpu_bits.h |  8 ++++++++
>  target/riscv/tcg/csr.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 52 insertions(+), 2 deletions(-)
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
> index 061bc9db77..fc7bd61073 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -5050,17 +5050,59 @@ static RISCVException read_hgeip(CPURISCVState *env, int csrno,
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
> +     * hgatp.MODE is a WARL field, so an unsupported value must be
> +     * legalized rather than causing the entire write to be ignored.
> +     * The specification does not require a particular legal value,
> +     * QEMU here chooses to keep the previous mode while accepting
> +     * writes to the remaining WARL fields.
> +     */
> +    if (!validate_vm(env, mode)) {
> +        hgatp = set_field(hgatp, mode_mask,
> +                          get_field(old_hgatp, mode_mask));
> +    }
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

