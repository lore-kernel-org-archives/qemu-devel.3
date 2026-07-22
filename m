Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5679CC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmX4q-0004kl-55; Wed, 22 Jul 2026 09:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1wmX4i-0004kQ-2e
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:33:28 -0400
Received: from mail-westcentralusazon11013012.outbound.protection.outlook.com
 ([40.93.201.12] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1wmX4Y-0002LI-Lx
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:33:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmO31/VZ0WEDSE1SDwAjbakr7k5Y2uDYowN6mAtVETETp35czsF+07u1Y3ppds9TuIGhXqpFRKE4DOdZFiz0DzZcDO8tRdtXWglyBLCjQm6E9nxT5ZfLjsimAjQZk7vYkNDIYB5h9KMyQDOwA4N5siM+rcPXvCIB0RstNLMpqq4TwtYmkCmF7rM6g4FFgCfnNNElzaXrSyytcboGiIxPdFDI0NQlsR660nUOcaNEbOKcNxtnUzHIHq1I6LyeSWl+L4aMyQu0KlAwYN7pxBnyp8JK7G8KV9iMzyOnivclsclF8eBsyxgLDUQ01ySS2J3XyCsrh9UW+125Y/1kg3BflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjL7SrnkZHmRBByH1egqD5E0Iil1yrVZCheQllCxLHU=;
 b=cdpevtJh3tE0nZqIKDUiUXXOOdlFqWw9Qw574KmYY+vYKHKey2lputrUAAOKrARdLUvKpVuEy18t0EnXg1ha4ZIQCuBbgIQ0R3Kxj7+sZ30MlM8NjIv4ALiDhCRzInO1JSA2XcL6j7onmHAbnA6T1rVHt2g4IZwOzjChA4jElHAur6Q7xYlEmuiBXkT4iFhLdtpsorIQY/WctWijdBwvp9MU4jZxzlY28NGCIgd+K/H4nmb5vHjj3FPBOopV0HP70/pwMKPBODvHufNN5WL5AApffr2g4DCz5tYmIrspFa2JxVkvGOt0+YEpuBv32DbPkA/47cKtFt8vuDMepKaSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjL7SrnkZHmRBByH1egqD5E0Iil1yrVZCheQllCxLHU=;
 b=NMhsLBvdr/ERAJb6V3l/OlNnF+lC+yK1ttHXRJRg8BciLNzjYhoB16PfIIAyVdru+l2+jMjDRKEWyPhg/YJ8SGgTXRdi3ni9HLNKHNUZmTMJ3wd/DMRCT1EHYeOCrK0phvq/wSnqpSaKK8IjOu8u4QTZqm/3tU7vx1lLYY62Dco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 13:28:10 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::ae79:f50b:b7a6:4cd8]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::ae79:f50b:b7a6:4cd8%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 13:28:09 +0000
Date: Wed, 22 Jul 2026 15:28:06 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH] target/microblaze/translate: fix reversed load/store
 translation
Message-ID: <amDFZs-XnqIn-poX@zapote>
References: <20260710072348.3575-1-luc.michel@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710072348.3575-1-luc.michel@amd.com>
User-Agent: Mutt/2.3.2+119 (db9200c7) (2026-05-16)
X-ClientProxiedBy: CPBP307CA0021.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::14) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 12665ef1-be52-4bfe-664f-08dee7f51249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18092099006|18002099003|11063799006|10067099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: K4Ya89lH1g0oAZte0QPA66Bb+1wD6/MkYc0HRlp+AZ5HfAVG6v2KosIzpIa46YlXJFXkCpnprb/KZl0xsQ9jVPIG7J4acwJAecJHFOB2Ok3Qr88ogAsWtfBuWwYU1n9Dz/s02Geuy+Cs/DzgnUooSmz+Hy9/oAbvCrrrvxuB+gmjik+/vSyHVhqoFSx0yzum1WZB/7zWoY+MPCI4dY6BRADfS0BwjqhB/hqukXURZkSZRGBuXq8q8kMBn1oH/QDKZDNj7rG6BLztdqhz0Eo1K/MEC4aCFgRhmWOkK2IDhCaoYDVzdaV1JYb1lUTZa5HmFSRNEy4PgverfPtpBeANUkmUqKuypCremMtMqGaUxhTZjhE55f6cbpfZ0FdYRHUBi/e7r4BexWQK/1aA3TfHlR00TaBYyigxg3MynSplcikFH0nNk6zyGPDrFQsLOZOT/advFtyGFrWAn6Xe/RtZO7WPkI2EbUa/Ps4tur1BUMWDUQQOdbNFLc5TE36ywugpfz57evKv2dUpLYyCM+b0QKAJxKe9kkHtFsmEeZ7YpC8p/HAAxIfw6W8+KiQaw/3j7AuPdPxjXXKzAfHtcil+RhoI3AaO/ebJ9e38kFp5qEhQa7XREwzeD0SmLIWLs4YMf0PojJIOnB0JxZ+KxYWWytR0hu5lGPuaASimm0aWdsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18092099006)(18002099003)(11063799006)(10067099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzGxsKpbT5eKzfIOyxuUwThJTFQsHokCnWLyvfsax7aINOXjsiF/dnSK0Jsb?=
 =?us-ascii?Q?uzLJBRqYKgq771o4YvhkaRuhhfasEhoT+U8TMDSxCZilUH/5J63+veSXcE7j?=
 =?us-ascii?Q?VecUGURCdP00hujKh6nVBfZiwV28v4QfKg0Gs1yYc/nf/BHzsFvmFJy1xV0j?=
 =?us-ascii?Q?CfusHlFqFhDFdAzab/hx3xwSupwYYpt6a+lvX2j/MIf96kX2j1qLAOfDPgzy?=
 =?us-ascii?Q?kM50fzs6QymVd+tU0/e6CDU+vZpr7BQmPQVv6UTpUGsFt1b4HYj1BDkygz16?=
 =?us-ascii?Q?MU+pqtjnlUXvLvqK6J4k4I3GLJAAhTD82f1MpjJbeLX2D9Iy58ViLP30Uqjh?=
 =?us-ascii?Q?CkZu9z4tnZc6cpqZ/1f6pc1F7kDUVZBaOsL3EcqQgO1s2X1DcgJiHsoj1G+e?=
 =?us-ascii?Q?AezUY2BoVDp867bUt84rh2/7sMJlPz5NKbjpYOeCEoodT4WKmAo5ZdPV2hr6?=
 =?us-ascii?Q?+2b2A3b1itJ1Ahooj0yKLwH4EmnX0EkRvzO+TLBKMCUMy0IOHN4xcxPhCkGY?=
 =?us-ascii?Q?WukCWNxc1u6xZM8ciPqPq6BwkOpx1j0AScaqGIbHPTsV6vmM7RAEpAAdEMt+?=
 =?us-ascii?Q?IsZTbkvlE+7Al6TMLGtXbBZjs+m5heQC6fVCDqybANMoDjA+bT3QG5rUdkQX?=
 =?us-ascii?Q?C6lrHTiwz9UjpWXTZwCzsrkDitKYdapU4f3pivDCjsr+NbyAQQw1vMj24OjM?=
 =?us-ascii?Q?DNSfWSMwIqLdKLDwlrsKDE9o8GumBT/aVnxJ1Aps78eQS5TjNLLC0Qvy36bE?=
 =?us-ascii?Q?QfHAvmPGdhnYO8IBEsf2/lwEq19f/VYa3z/rwZ9cDG5wIjdjt5egqUNfJGMc?=
 =?us-ascii?Q?TEMHbkltn8gVtD2wPvQvak9LNX0jkrEmSZ6NQNZH0XsNHcvBDEXB/qUSaxdB?=
 =?us-ascii?Q?TsFN4ceK5i0RCprLxJGo9sqKb73aNmfbCLsvhEZrcJqp7jYKwpb/6yt99giB?=
 =?us-ascii?Q?X823KFtV9S7wc5MbRGxaT5nBvOqOf/Mt3rwcBvmskWP0WB2TKXmbejfMkL0O?=
 =?us-ascii?Q?UVa7lgBTVcvnFIUn83WfJqVRg6xxdWE1ok5pPcoBWXLMVNqEVEKpc4OZPYCv?=
 =?us-ascii?Q?YPpr6SBWsPgmyv3Q3n3RYxFjKO1I5u6z/g/T4WU21tkv/0hBtDfCeeghkNms?=
 =?us-ascii?Q?Uj2dmRKRt6x2mt8Hf09UAFuSBqAs+x4LMjNzS6RYh+OUu3t4RdurBJOlQdpn?=
 =?us-ascii?Q?1nYAtXWZDLGFqgQ+EejktjFfg5+q5OVL6b+4EGhSHbz1+sSrpwlFg6jmqA/K?=
 =?us-ascii?Q?lTCdV/EHmQIk7gpISK4KYLILJ/m3upGlg6cjUTGhAB+uV7VqN636xgkCwCW+?=
 =?us-ascii?Q?cZM374JcODErcDpP2N26x6F45kR4r/wVypre8MA4OHYzT+cfYsZj19oF9BW6?=
 =?us-ascii?Q?dvS0XGuy1ySuB00whs/xR8oTg/zeOfAkAv1ylHoahbbB4KEpdV4qUTQ+pptd?=
 =?us-ascii?Q?0PDXeoUBFTmzlzkO0KKjFGVrUEzYi2ilptDKRrsFRTal3LWfa8sGKtVcRjZ3?=
 =?us-ascii?Q?2jkn/3yDLwXrU+TS5lqIH3k1ct/a45VaCGupYsIXJLkLzRzt/6Ncq0BSr+Kx?=
 =?us-ascii?Q?KZIMTc7MtE6K9cCrfLX+/pDQboiqTJXOmQLIp73XQqXTItSiq3SKGiC6frhU?=
 =?us-ascii?Q?zijU0kQFimXNmfyICYJ1wrXt3Duo2tirUvIB8dm0OrYpvhWAIG8xrEnUAres?=
 =?us-ascii?Q?2JERg5gOLiLon1Yc67iN1929NqdlZnhhABa/rcRnclQ9VPCy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12665ef1-be52-4bfe-664f-08dee7f51249
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:28:09.5501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilVIn+gMEg+4jY2pgLvxXsUokyF6904giPVD5cOG63Z7dbwg4Rrt1GE+cM4tIo8R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140
Received-SPF: permerror client-ip=40.93.201.12;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Fri, Jul 10, 2026 at 09:23:46AM +0200, Luc Michel wrote:
> Since 36a9529e60e0 the TCGv returned by compute_ldst_addr_type{a,b} for
> the address can be a target register or a constant. However
> do_{load,store} might modify it in the case of a reversed load/store.
> 
> Fix this by factoring out the reversed access logic and copying the
> address in a new TCGv_i32 if it needs to be modified.
> 
> Fixes: 36a9529e60e0 (target/microblaze: Simplify compute_ldst_addr_type{a,b})
> Signed-off-by: Luc Michel <luc.michel@amd.com>


LGTM!

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



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

