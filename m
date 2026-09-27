Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF35C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAncu-0001DI-Uw; Sun, 27 Sep 2026 08:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnan-0008UX-Q4; Sun, 27 Sep 2026 08:02:57 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnaj-0000N3-TS; Sun, 27 Sep 2026 08:02:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dx+hZfR6axZTsmzGy5K9qUd6YVuHV6rf5vYb0H3XgjOiDy8Yokd8M75rQ42XnXL/aVVU66TxA7K8OHFu2vnfGCuoCTbXJtcF1CrTVr/QjaNFaYwHH9/cFIFAr1G73S3ZnX7ACTMMkhgqI5r/fOJeA8MZm8DQy5wF6uegTRVbXeep33Rm2lew0mb3i6/mSSDc9q6vlvcnpRib08p7GQRi+577+EeSVbxDU/Le7dK3M9SpBEMZaUslFlh4kdssGZxcoghX30ljGsmrqjHFbNSHdxf7sU0tBQaP5gWcGOVb9Kgx21JNejEEM60fWkJS0cMRHvbOMExq1HJvftuN0qR3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daKLMM9J/Ri1HcwU4dB01UGVCDSQ2tqZy1sjXxSkGOc=;
 b=ZmPOidL9fKwDNcKEgqGFMyRH7dAsdSOv6YM9AdtSBvRj69bB7vCx9u5Uqc3dL1uyv1tt2x9outqsTtGjfY++D4OQJcu6jHv/PjCGxbK88arE9qdyRx6HTztr1o+rhK/hP2Cqvx6DBugC6y62ZyHSquc13dECjNOWaMMM9uQMKWhQ6rQBVPOBZQvWlKiCsAP6wQBTl0qPKUmx456Ve9Ill4V+rYHRePw3D1zm72TTcriM8olcoIeg0p0D30reqa+57hUCjJucX25YsqDo55s0JfJb1FLnWV/jQQpcriLPeY4CkqspCbtGEKOB/zVQB3pLBER2O2WomVwHAweYqsel9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daKLMM9J/Ri1HcwU4dB01UGVCDSQ2tqZy1sjXxSkGOc=;
 b=jkS83LyQr+F/kGYY9BNxFYecEocr+xwrBHi93UdEnSjg1S3Hei66HY0QGhew1q+ncHAdhdfuNzhNNN34B14dgajWY+2mGVhf3RE8bF3b1WSVeU3pLJpb0ph+EHatNHAtoo3D5uJ4NMzNiZnPTPslkMuliLC98e1IfDrGI/6gMXIbjWmzgCyuozE1OW2useCL2GsEA1bLsFCbgJCMOchOegtqd3sQ71MXoYv2/1AUuGlbK4hIHxwJqM9v9mPXHIhHCDSHSnDZZ5OoN8YsrBsu/FzheJts8cieJce5cvB4dnFT/VfCAf4h+8MHpDzaWIMS51MVecYMlFhOFVv+rFW+7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by KL1PR02MB7331.apcprd02.prod.outlook.com (2603:1096:820:11b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 12:02:45 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 12:02:45 +0000
Date: Sun, 27 Sep 2026 20:02:39 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jason Chien <jason.chien@sifive.com>
Subject: Re: [PATCH v4 5/6] disas/riscv: Add disassembler support for
 Xsfvqmaccdod/Xsfvqmaccqoq
Message-ID: <arkF1wgQYpYLDo9i@MacBook-Pro-4.local>
References: <20260927082534.3228237-1-max.chou@sifive.com>
 <20260927082534.3228237-6-max.chou@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927082534.3228237-6-max.chou@sifive.com>
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|KL1PR02MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2cf2fb-37c4-4b83-5b66-08df1c8f3dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|3023799007|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: XhOhfAkdVBlR6i7kQO+2+90vVK1wjUaV8Iu/pdEFFxaQSYSTmTw7rLPU/S/DwRp6UZ6Hfr+af2tchl/piBwdsLuZ4h8hhf1Mq2EZrmuROs3uw1oqSGryDwIaT88bPpaSuVS5zXkadQ+wjtdPtPgc/duqJqp3rUxbQHIfz+fh0TQc/ngQU31zTAH/vjoEflr9W7m/Yf8nlYF0VF4ubH63D5Uex746KiWfGZag2Dvy0lheYGop7y5fLmF5fq9mD0X4OjV6hNQty6orOUmwh9meMZ8VoW+2QAZ4TkN3VstKq0EH35JB6DOEmy4YWos7RJYWvJfD0pLFeA2kznFPZjBgVzcqsFr4e9MZwGVCIUXEkVdk4fgnkgUjjhlWU6Py2EzRjRM6/bPgSgbNwXVZplZ3WVwLMO69H8Vw0iLixlqUDA4yHRGogffHG0RgufvNhbohgf2Q+b32/w6fFawHtLTM4fRIeZewESA9mIKFFvXY0ys3R5T7ekCqieKn1SG4o8ntYXgyBjNT8t57hrELU/t9uRYUTgqP6x5P1VvxGLJyo2ZTL4Pl6PJ4Cum3tH29+hhQkl0AOeK+vYQyn1Gy/sNeEkSGvMGq1UeOsN8nTpZ3xduD0BrAW+X4x5Mvxc2IHSvYCRV56L8w1Rs4N4Qh0wFnuD3ob4kG+S1DcyV8/H6yDwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzmhrc8Zp+/CIXEaaKtEVYpy5IO4rwS2DcYaxtwNcFwz/3NptG0EBJh+opWQ?=
 =?us-ascii?Q?i9W+G65h47vwI+om5lMa/YO7U9lRzWLDMrwdphO/qTONS2lIl4v8ac7NcZs1?=
 =?us-ascii?Q?cZJWDzoGeUY57IvwGgbLPK7SayIZLWu4iAZVeLxKLq6awlcL0Okw0zur8OSk?=
 =?us-ascii?Q?aiRJisWgpbHdp2WFUzXUEqUU9EfEIkU5sum+rzKEgDAtXakHqRRdV1FGiikg?=
 =?us-ascii?Q?onUTG/li+eroSZEi2STXaPdzr8G9BjReas4YcERwtrhOb3X4ocQquxsQki83?=
 =?us-ascii?Q?QDww8aSRtrVBCkcl+Eckx3NemBeitvgZXuedQ2sIXJ8e38Y8beoE5bsjVHmE?=
 =?us-ascii?Q?97tb8t5R3Sz4xLhvWs2hAPW9BXLdkOEUStWfOBHftBHuWMv2Mx495mxg3Hez?=
 =?us-ascii?Q?JMTHxHkzQ+pjBNDdCV+iPpIHBLR72NEmpJoMG0LSSD3Xwo2rN/lFJv+QdBK7?=
 =?us-ascii?Q?SMOQ2hJPuyx5KJnePvTdEG32qWZn4mpON1vHwrAT/qgBDIIe96tSMWlbxD/V?=
 =?us-ascii?Q?CR8L38jTl2Dp2HXa4JIeChGQxbCgthRBRFPA/YUIf07jfT3dO5R8tTtKd2Z2?=
 =?us-ascii?Q?qXWob0/gVsfL+RTXS5ikxuFwdXzEd/SqTubvuN1rC3tYzxAEwjaHNk9Gloxy?=
 =?us-ascii?Q?r7oqYnnKveL8m65eI6JUPVHo5Og6k5GbP3nPnZCxeJLgWrxETQZ0RBwn0Ln2?=
 =?us-ascii?Q?887w9dm/E8TUo6nkr4QHaCjetuny5Z3VAckyNMvTV3sQusA/Cbk75ZBSVVKG?=
 =?us-ascii?Q?Q4oONiLQaJNvER5bgLtO9KEY7XjzEzh+3/rgduBRbgkt14mHKe6274LFpUf8?=
 =?us-ascii?Q?viOezA/MK1GmUQa6IF9OCyE43eo7IpuTy6rnN1qEFeFVXKKmXGSOEDgdEcei?=
 =?us-ascii?Q?0ePdFUOzdDXxDP9mVc/s5ppeGgxBssx02YdBLPZ+E0sRS8z8MpDxHImNRnKp?=
 =?us-ascii?Q?D0busgWKSDYAlgoXQWWv3IH5rBrEit0kupHTkxjxSmYjyPP24ME7PGQFifZZ?=
 =?us-ascii?Q?pNvgMOdnIWc8QlQvxZmdOyXxCYottBrxfgPhJjMKxeJ5hi5sjeeUZqCQY7Le?=
 =?us-ascii?Q?mWZ5Cyr12QJICyRMYzf5zuGgAju/ibf0U/K+/vpxIEHepK/3eBUy3Ixnng/U?=
 =?us-ascii?Q?xrLCwCZ8JD6z27Q7YE1QTHg+KkH6KuV1cJHjbEymDoQZDDOvyg+bdxPorall?=
 =?us-ascii?Q?TYIA+wQurvfsTZjo1rVX9YVsHkUkeROonJbhcBRLMEHglCRi17NrYxvtF69m?=
 =?us-ascii?Q?mr28LLLn6wAzXSdKvkASOAb1HeQOSGRPc0wod79S3ogskR4FLXptPA7oS07j?=
 =?us-ascii?Q?0uFEkcyPoVy+iyUL23C1tkrV+cGgP4ss11o9Z+HOuNRKjAEeSuz/nuKsMs/B?=
 =?us-ascii?Q?mKlDbca+5EOHSSj1vPndmWdsUrdMfNe0CkMPYkMbYlQLCTxtsIohVd8MIc7I?=
 =?us-ascii?Q?mi6vLZfVVqLVuLN8ESu0AZVsIw2cvaWzuW5rPfrgmixWEjMi4v9M7HyLnxiI?=
 =?us-ascii?Q?RhSTU4SsQ2i85+TU1GpgXJZgmYIotZu20c8c9HkyEyCcOcyMnCp5kD5IRCNm?=
 =?us-ascii?Q?TTRGCOeI2DpYQOjy/VUXjeeY1/mdNZCWRipOFs3+bsAhu6VdJ2rbENJKy4Ny?=
 =?us-ascii?Q?Swu5W4HOEhQJwanMQFElPxayfffXYmsIqRnXzSBytTis9bsv8fdpWCwm7Zfs?=
 =?us-ascii?Q?Tha5xmBel5Y/X8HdzYkzAwbmH0Bp66KuXFZJmqfUIcU8W0G+ubzGm87rDd4F?=
 =?us-ascii?Q?KEgJdEH7IDWQ77xRh7/j+sWGQcf2A2E=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2cf2fb-37c4-4b83-5b66-08df1c8f3dbf
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 12:02:45.2200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J95U23nIkTLH1JaLr9F7xiWm8giEao3N2AFa4ejGFFEEjofLiVtqVK4zd4u+iE4hcFfufwp2mcyD4bjMs7wqEyOM//7CMVVUFyyy+Sz/Cik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7331
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, Sep 27, 2026 at 04:25:33PM +0800, Max Chou wrote:
> From: Jason Chien <jason.chien@sifive.com>
> 
> Add disassembler support for all SiFive custom int8 matrix-multiply
> instructions: sf.vqmacc{u,,us,su}.4x8x4 and sf.vqmacc{u,,us,su}.2x8x2.
> 
> These instructions share opcode 0b1011011 and funct3 0b010, and are
> distinguished by funct6: 60-63 for the 4x8x4 (Xsfvqmaccqoq) tile and
> 44-47 for the 2x8x2 (Xsfvqmaccdod) tile.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  MAINTAINERS              |  1 +
>  disas/meson.build        |  3 ++-
>  disas/riscv-xsf-op.c.inc | 11 +++++++++
>  disas/riscv-xsf.c        | 49 ++++++++++++++++++++++++++++++++++++++++
>  disas/riscv-xsf.h        | 16 +++++++++++++
>  disas/riscv.c            |  2 ++
>  disas/riscv.h            |  1 +
>  7 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 disas/riscv-xsf-op.c.inc
>  create mode 100644 disas/riscv-xsf.c
>  create mode 100644 disas/riscv-xsf.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a3a8199840f..be1c505ac20 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -406,6 +406,7 @@ S: Supported
>  F: target/riscv/xsf.decode
>  F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
>  F: target/riscv/tcg/xsf_helper.c
> +F: disas/riscv-xsf*
>  
>  RENESAS RX CPUs
>  R: Yoshinori Sato <yoshinori.sato@nifty.com>
> diff --git a/disas/meson.build b/disas/meson.build
> index b382550e41f..9b14adf4f1b 100644
> --- a/disas/meson.build
> +++ b/disas/meson.build
> @@ -8,7 +8,8 @@ common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files(
>      'riscv.c',
>      'riscv-xthead.c',
>      'riscv-xventana.c',
> -    'riscv-xlrbr.c'
> +    'riscv-xlrbr.c',
> +    'riscv-xsf.c'
>  ))
>  common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
>  common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
> diff --git a/disas/riscv-xsf-op.c.inc b/disas/riscv-xsf-op.c.inc
> new file mode 100644
> index 00000000000..c8daa7ebef8
> --- /dev/null
> +++ b/disas/riscv-xsf-op.c.inc
> @@ -0,0 +1,11 @@
> +/* Xsfvqmaccqoq */
> +OP(sf_vqmaccu_4x8x4, "sf.vqmaccu.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
> +OP(sf_vqmacc_4x8x4, "sf.vqmacc.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
> +OP(sf_vqmaccus_4x8x4, "sf.vqmaccus.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
> +OP(sf_vqmaccsu_4x8x4, "sf.vqmaccsu.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
> +
> +/* Xsfvqmaccdod */
> +OP(sf_vqmaccu_2x8x2, "sf.vqmaccu.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
> +OP(sf_vqmacc_2x8x2, "sf.vqmacc.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
> +OP(sf_vqmaccus_2x8x2, "sf.vqmaccus.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
> +OP(sf_vqmaccsu_2x8x2, "sf.vqmaccsu.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
> diff --git a/disas/riscv-xsf.c b/disas/riscv-xsf.c
> new file mode 100644
> index 00000000000..745fcc8efda
> --- /dev/null
> +++ b/disas/riscv-xsf.c
> @@ -0,0 +1,49 @@
> +/*
> + * QEMU RISC-V Disassembler for xsf (SiFive vendor extensions).
> + *
> + * Copyright (c) 2023 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "disas/riscv.h"
> +#include "disas/riscv-xsf.h"
> +
> +#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
> +#include "riscv-xsf-op.c.inc"
> +#undef OP
> +
> +const rv_opcode_data *decode_xsf(rv_decode *dec, rv_isa isa)
> +{
> +    rv_inst inst = dec->inst;
> +
> +    switch ((inst >> 0) & 0b1111111) {
> +    case 0b1011011:
> +        switch ((inst >> 12) & 0b111) {
> +        case 0b010:
> +            switch ((inst >> 26) & 0b111111) {
> +            case 0b101100:
> +                return &op_sf_vqmaccu_2x8x2;
> +            case 0b101101:
> +                return &op_sf_vqmacc_2x8x2;
> +            case 0b101110:
> +                return &op_sf_vqmaccus_2x8x2;
> +            case 0b101111:
> +                return &op_sf_vqmaccsu_2x8x2;
> +            case 0b111100:
> +                return &op_sf_vqmaccu_4x8x4;
> +            case 0b111101:
> +                return &op_sf_vqmacc_4x8x4;
> +            case 0b111110:
> +                return &op_sf_vqmaccus_4x8x4;
> +            case 0b111111:
> +                return &op_sf_vqmaccsu_4x8x4;
> +            }
> +            break;
> +        }
> +        break;
> +    }
> +
> +    return NULL;
> +}
> diff --git a/disas/riscv-xsf.h b/disas/riscv-xsf.h
> new file mode 100644
> index 00000000000..b15b7aa97c8
> --- /dev/null
> +++ b/disas/riscv-xsf.h
> @@ -0,0 +1,16 @@
> +/*
> + * QEMU disassembler -- RISC-V specific header (xsf*).
> + *
> + * Copyright (c) 2023 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef DISAS_RISCV_XSF_H
> +#define DISAS_RISCV_XSF_H
> +
> +#include "disas/riscv.h"
> +
> +const rv_opcode_data *decode_xsf(rv_decode *, rv_isa);
> +
> +#endif /* DISAS_RISCV_XSF_H */
> diff --git a/disas/riscv.c b/disas/riscv.c
> index ef8b7ff20f9..d755172164a 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -27,6 +27,7 @@
>  #include "disas/riscv-xthead.h"
>  #include "disas/riscv-xventana.h"
>  #include "disas/riscv-xlrbr.h"
> +#include "disas/riscv-xsf.h"
>  
>  /* register names */
>  
> @@ -3456,6 +3457,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
>              { has_xtheadsync_p, decode_xtheadsync },
>              { has_XVentanaCondOps_p, decode_xventanacondops },
>              { has_xlrbr_p, decode_xlrbr },
> +            { has_xsf_p, decode_xsf },
>          };
>  
>          for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
> diff --git a/disas/riscv.h b/disas/riscv.h
> index b0269bb709f..4f1ffc4ae02 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -262,6 +262,7 @@ typedef struct {
>  #define rv_fmt_vd_vs2_imm_vm          "O\tD,F,im"
>  #define rv_fmt_vd_vs2_uimm            "O\tD,F,u"
>  #define rv_fmt_vd_vs2_uimm_vm         "O\tD,F,um"
> +#define rv_fmt_vd_vs1_vs2             "O\tD,E,F"
>  #define rv_fmt_vd_vs1_vs2_vm          "O\tD,E,Fm"
>  #define rv_fmt_vd_rs1_vs2_vm          "O\tD,1,Fm"
>  #define rv_fmt_vd_fs1_vs2_vm          "O\tD,4,Fm"
> -- 
> 2.43.0
> 

