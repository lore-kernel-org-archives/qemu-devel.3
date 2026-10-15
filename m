Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33EACC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHNmb-00062g-57; Thu, 15 Oct 2026 11:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xHNmX-000626-AW; Thu, 15 Oct 2026 11:54:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xHNmT-0006Cg-1z; Thu, 15 Oct 2026 11:54:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwYVRRmCZZamX/w9oUu22lUi62rZjTlO5V7uWohNEA2RyJuBcE/ZcIg3ibqkrxex2OvCaVB+j3k3rt+sj6BRhySeZvjieBUvbuscpbTGq5ApmWkOcwAifkM5w3WnxxV0S26VtbvSJOrRE3uKQiFkfEVI/EKZ+bPzIiZny/IlhBkrn7rQF0B1aNtuYpJ+x/HQZ1hm4o8JMpuByWTHQMPJd2x7frhhkCkHaIkDh/dZe9fFmTwkNpwnojjdqTpBEV1voGsN5pBp2VACOU2VC1hPGIzl9lMmswi+znG7jfVBaoJjXuUcgjRzGx4RrhDaZZONE2gqRzms/NMZDO60k+Pf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0Mct45QeQYO8ZTmYoscK1uLveZRZIjzbZ+gEAHr2Ng=;
 b=neDfyl1s8ctpHps4V31gXJh1RCvYlShz/gWorz1GLeJrsycbOpTLBoOjqGNItaKFx5UJbe4uTXvPfrCTkAee5qULpqKTGfRsayrzhgjTLRQt6K0CWgUPUl6/rVmtj0pnnDxw2kNsetUbqniD2J9Cpcdi7OkK3QVyRm3OqLKz4KoYHSJKke4idhBrSNllTFnVdbnuu5waa8OTP0DhBAS6X0D4wEAiuoAOo98kpTWqGYBxtBuiNQRkTu7DjD8vnGplXYrIpuTiWUjCC6s3hRKIUa0d1e8PPqqwXIOJGue6ppWOf+DWROEwX/65cOI579U4AOOEni6g90MdbVcPE8jQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0Mct45QeQYO8ZTmYoscK1uLveZRZIjzbZ+gEAHr2Ng=;
 b=aPn9OzNikMx34jYACZqeTd5cPcLeCp/gEI1P0wUX2eYTfSRmDPWaBqA+Qt4i8O66tKxcgAtWd7m6SeH+lQCHa49Epi5PtQCKSWrdmp+VcOj9T7qwezvsPI12GLCn+rSfTt+ExGQMLkYhg7ZdHPpfI7A3WgTKXwIup0oqbQJ15MojPel1UcyZZxsXDJju9fyd+B9/Z8H8vRbltjyLfEK89PvM/rAwetHpU9H4ct6UM6Z0DjSoYjyfXGoHFWCtB7XkPOiW/AP4U6q7Wnpt+wiXyJH/8MTJ5tOq+VY7FtrpQnWIwyX0NfhxBbFgvPHr9ULS5wXf/Ss2EsT+yEY+35xM7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYPPR02MB8820.apcprd02.prod.outlook.com (2603:1096:405:31a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 15:54:00 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 15:53:59 +0000
Date: Thu, 15 Oct 2026 23:53:51 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Mingliang Liu <liumingliang.dev@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, richard.henderson@linaro.org, 
 Zhibo Hong <hongzhibo@bytedance.com>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4 1/3] target/riscv: Add support for the Zvabd extension
Message-ID: <atD2-yGmEYHkFXSf@MacBook-Pro-4.local>
References: <20261015134337.3354723-1-liumingliang.dev@bytedance.com>
 <20261015134337.3354723-2-liumingliang.dev@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015134337.3354723-2-liumingliang.dev@bytedance.com>
X-ClientProxiedBy: PH7P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::29) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYPPR02MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: f90e4279-8aa9-44a8-b3a2-08df2ad486ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|23010399003|56012099006|18002099003|22082099003|3023799007|6133799003|4143699003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: /oj4v9kxGgxUYo0QyfB80sWDFTXa/k8kdI7a0N+UkbUCBT/bu+y9uWRf0i719nqz1s8FNF8AsM5Ql/DICMZGtBBHXcO7cqTX5v3ojVx5PZspiUgSdDuI8DQnDs1ZatnI/B3FmsxRlaheN39J3IAlOi9LSwAAT9XqUpl/NFwPpw8dfrvQq1VXIAXOGKk4NEftN5txPzyMAxHwBohyGR3gjBEgpFQfjuoqUDNULYJKUHbu7atWOQgDmmx4h+GbOX/jYYzM3v3TGCLWSigTIGLJro8nnh0ar3b5OZBg1yhBpt5D059eE1kZY2FlsBmLPOCEJI0tVAmeagvaRF3eSVJBWKUfdlmliH2yq8c3ovm0hklmWia2qKgevilcp133UlMG/3uCBRUNBpPc3i5RtnWXxu6WwK5HCRQ1rjl+uNqSeZpHe8DvJDibpc/1R3H07nRBUlMYKO1aX+n9lCJ9FjWElcz0okifSzRgcMaLavv80x0U2XrmYuU09gWMLRFOeR13La/qOCnlDYM4D3DzKdCWowUCR97eU3z5RM2pcUZNJZ4rDL7Jp2+PisSvKnZ2s/Z2bJUTEM3KP3Z+tRCSUDAntvNqOgO7YjJ//qxJNX93FYBW7CdC1tViq/FhGWloKHVdbkzqYVGnnWSWXObLL1u9SuebVk28O6Zbo1ClHi/WQZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(3023799007)(6133799003)(4143699003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+w59CstGp7EYSdXd9C5u/kBFemhih4AyfCa/fFZLz6MYdSSL3BP5JGLK/bQ?=
 =?us-ascii?Q?46Vjryime742bcmpM99yvdhhJD5gQRio/O+cHIWC6/9Fmy5N6z51tIZCzH4P?=
 =?us-ascii?Q?Tug+L7Eg59ALVKcWUQurdaexR/XFVi+em/WPOdqQKV7yJBpJ+N6064b+GmZe?=
 =?us-ascii?Q?xKT/tY0Kj7uk2JIkC7+yGnnHgU6C623y0vyU8IuJ/r05Z9SBJOXTsANuui1L?=
 =?us-ascii?Q?5xz9GXRjpTkVYS9jfSuYe8folF78N3ZfpPtkFikflteZsVX9U9DiMQ27nEes?=
 =?us-ascii?Q?C5UbJkRmJi/A83sOEA6oPygofmfsMqlP3+73Q/BZgcnXj/v6uHOQfrzYyQaC?=
 =?us-ascii?Q?azFa+83HI8twPEmWgRTckn9vZW0aQMKcgHIrvKDjpm5MU8Xiy4Zw/sC2KmjW?=
 =?us-ascii?Q?YMx5cDWf2jGntoCRQgVogjnTKDqRRnAL1ddOB9VukE/qhxV33RVzYoTr1iEN?=
 =?us-ascii?Q?Kq3VkMQJVJjcRLzj7vQF5E4/34GOPwIZWqSB0NuyxdntPq1MktkMJTK2QPCv?=
 =?us-ascii?Q?pwSvksbzbdp6CXFbuJ0TE788d1hlKgRECU0nkgtUOxBOu4g3q17owo6kbKJD?=
 =?us-ascii?Q?w20judrZ1Y7pWmBQVE40/Fgjlbv/PjPLZIa3EdfJnPluT5XtO5p4uY2NFe9Z?=
 =?us-ascii?Q?P5bXpZQbkrj62B0tZewBfP/0dwHCQcKT4Rs4K6TnZf73bfB17R1aKux5CWv/?=
 =?us-ascii?Q?NV6mCdVQDhi9UfMHeSNmq+wEFXtPoLShk9fZsKbYtqMMkmqKr6qcCN8ZTtke?=
 =?us-ascii?Q?cZ2MD2EZlffAejaCmGlY8sqGB1VOkCD0BKdDYJEpKPS/ER+UV/pTFhHvLJpO?=
 =?us-ascii?Q?EuH8tD5WEdg0RK0tdcHFEtQ6zRUyVx2EzTkZMek9C1lDpVlC20T7wBYUgUWe?=
 =?us-ascii?Q?DwOtyhpd6r0bqKYg1CClnani0QxgSltndmgyjVbD2PUqWXT/ok2E0Q/ekTEb?=
 =?us-ascii?Q?fxfm3Ba1ZOFBkyw6DGWyUWqoJ+xNoDD0VZwG4ButVEO8E1Jx0K5ZdM2O1LTY?=
 =?us-ascii?Q?I7tH7nR+b5GcSCDZ6oONaEexlVdmHklE6QLwAHuGNV/NZjtGibBRXDAJKrlD?=
 =?us-ascii?Q?4RfwQoJ53ESvgo3LA713p+mLtA5PVar6MsMjoLJRz6ljq0W3B8CL0j/nWSDa?=
 =?us-ascii?Q?efGYoFRk3F1j0gI/8u3o71cxXr7faMQW/dtpSxplSJe/ePX58KT4EXAoVKpF?=
 =?us-ascii?Q?bA4P0u0dSKvCrVOWUQHMQkiXUhtMOqs/j3KbMDBMwzz3AYXofGQ9IYrBXWOO?=
 =?us-ascii?Q?TkvZBwCW5tbnpPkLoasNSXQUcFmMPH1x1Gv3CCboIaihwHvtpqVjRjVJAQVb?=
 =?us-ascii?Q?1VXG3PYAVc0ng242eVNqAc19hGPKUvRFLgL0vs0YNQtDdJ9M2k4dkO8+C/dM?=
 =?us-ascii?Q?FOYk2gCkkBT1NeQPA7EMB9wARcQRxCcN6vDhZkt+RYzMRFFsDli8M5cumizB?=
 =?us-ascii?Q?RUuuiJK32XWoTokICzXmtVcFp+xFip/KtvwAYYCl2CguBCH+XHeqIatd4poc?=
 =?us-ascii?Q?rVKLM7zgq3CuFoI5lOLVM0k7GB8vUlsQU/GDFH0r6ghZEZvx2/fU0RFaEsKF?=
 =?us-ascii?Q?EF62bQeFjR59454CcvaVZ/qjAEAV9ia7+lzftYsixBGxBRtPItb5uuOyF1CB?=
 =?us-ascii?Q?J4bABUIsf7tqgefivfiQS98eXTfnm5p0sygRRUFuK7OxqyCZW5QjvLeMV5I0?=
 =?us-ascii?Q?WfIjVERiL9eHjFcD0gbKyMtgzU/n3s0idn7Ih92dSkdpXy/nA0OKvHEBIp55?=
 =?us-ascii?Q?D0uSnJIYizUQHNf0tBSQ+Y2Xt3ES6lI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90e4279-8aa9-44a8-b3a2-08df2ad486ce
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:53:59.6238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPFX58qrB504xR+t2CAY2LDUxqO9NKbqftyC2tPXwpZc289twzKTaamrM39JvNo1pfGkF7Awq5cBiUMh+ltbjiR+Vsoq4VuOGZfq08ZEl3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8820
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Oct 15, 2026 at 09:43:35PM +0800, Mingliang Liu wrote:
> From: Zhibo Hong <hongzhibo@bytedance.com>
> 
> The draft Zvabd extension version 0.9 provides vector integer
> absolute-difference operations for image, video, and other
> data-processing workloads. It introduces eight new instructions:
> 
>   - vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW values from
>     8 through ELEN, with SEW 64 requiring Zve64x.
>   - vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support SEW 8
>     and 16 and accumulate into a double-width destination.
> 
> This patch implements the extension, including instruction decoding,
> TCG translation, and helper functions. This implementation targets
> version 0.9, whose instruction encodings differ from version 0.7.
> 
> The specification is under review at:
> https://github.com/riscv/riscv-isa-manual/pull/3279
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Zhibo Hong <hongzhibo@bytedance.com>
> Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
Tested-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  disas/riscv-op.c.inc                        |  8 +++
>  disas/riscv.c                               |  8 +++
>  target/riscv/cpu.c                          |  1 +
>  target/riscv/cpu_cfg_fields.h.inc           |  1 +
>  target/riscv/helper.h                       | 26 ++++++++++
>  target/riscv/insn32.decode                  | 10 ++++
>  target/riscv/tcg/insn_trans/trans_rvv.c.inc | 45 +++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                  |  6 +++
>  target/riscv/tcg/vector_helper.c            | 56 +++++++++++++++++++++
>  9 files changed, 161 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index 1d334e4857..07b56f5d52 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -490,6 +490,10 @@ OP(vaadd_vv, "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
>  OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
>  OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> @@ -861,6 +865,10 @@ OP(vsuxei16_v, "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>  OP(vsuxei32_v, "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>  OP(vsuxei64_v, "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>  OP(vsuxei8_v, "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vwabda_vv, "vwabda.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwabda_vx, "vwabda.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwabdau_vv, "vwabdau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwabdau_vx, "vwabdau.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vwadd_vv, "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>  OP(vwadd_vx, "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>  OP(vwadd_wv, "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index e85dbac035..b0102e47bc 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2024,6 +2024,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 48: return &op_vwredsumu_vs;
>                  case 49: return &op_vwredsum_vs;
>                  case 53: return &op_vwsll_vv;
> +                case 61: return &op_vwabda_vv;
> +                case 62: return &op_vwabdau_vv;
>                  }
>                  break;
>              case 1:
> @@ -2166,6 +2168,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                          break;
>                      }
>                      break;
> +                case 21: return &op_vabd_vv;
> +                case 22: return &op_vabdu_vv;
>                  case 23:
>                      if ((inst >> 25) & 1) {
>                          return &op_vcompress_vm;
> @@ -2351,6 +2355,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 46: return &op_vnclipu_wx;
>                  case 47: return &op_vnclip_wx;
>                  case 53: return &op_vwsll_vx;
> +                case 61: return &op_vwabda_vx;
> +                case 62: return &op_vwabdau_vx;
>                  }
>                  break;
>              case 5:
> @@ -2427,6 +2433,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                          }
>                      }
>                      break;
> +                case 21: return &op_vabd_vx;
> +                case 22: return &op_vabdu_vx;
>                  case 32: return &op_vdivu_vx;
>                  case 33: return &op_vdiv_vx;
>                  case 34: return &op_vremu_vx;
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index da4c1a090b..e08cb2f356 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -220,6 +220,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),
>      ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),
>      ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_ztso),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvabd, PRIV_VERSION_1_13_0, ext_zvabd),
>      ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
>      ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
>      ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index f91c780299..6f567612fa 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -83,6 +83,7 @@ BOOL_FIELD(ext_zve32x)
>  BOOL_FIELD(ext_zve64f)
>  BOOL_FIELD(ext_zve64d)
>  BOOL_FIELD(ext_zve64x)
> +BOOL_FIELD(ext_zvabd)
>  BOOL_FIELD(ext_zvbb)
>  BOOL_FIELD(ext_zvbc)
>  BOOL_FIELD(ext_zvkb)
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index aab92bf132..b7acb6fdc9 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1350,6 +1350,32 @@ DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
>  DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
>  DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>  
> +/* Zvabd Extension */
> +DEF_HELPER_6(vabd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +
>  /* CFI (zicfiss) helpers */
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_1(ssamoswap_disabled, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index aa02dae3c9..288ce8a554 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1086,3 +1086,13 @@ sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
>  sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
>  sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
>  sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
> +
> +# *** Zvabd Extension ***
> +vabd_vv       010101 . ..... ..... 010 ..... 1010111 @r_vm
> +vabd_vx       010101 . ..... ..... 110 ..... 1010111 @r_vm
> +vabdu_vv      010110 . ..... ..... 010 ..... 1010111 @r_vm
> +vabdu_vx      010110 . ..... ..... 110 ..... 1010111 @r_vm
> +vwabda_vv     111101 . ..... ..... 000 ..... 1010111 @r_vm
> +vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
> +vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
> +vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index a22e2cae6c..14ef961607 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4091,3 +4091,48 @@ GEN_INT_EXT_TRANS(vzext_vf8, 3, 2)
>  GEN_INT_EXT_TRANS(vsext_vf2, 1, 3)
>  GEN_INT_EXT_TRANS(vsext_vf4, 2, 4)
>  GEN_INT_EXT_TRANS(vsext_vf8, 3, 5)
> +
> +/* Zvabd Extension */
> +#define GEN_ABD_CHECK(NAME, CHECK_FN, MAX_SEW)                       \
> +static bool NAME(DisasContext *s, arg_rmrr *a)                       \
> +{                                                                    \
> +    return CHECK_FN(s, a) && s->cfg_ptr->ext_zvabd &&                \
> +           s->sew <= MAX_SEW &&                                      \
> +           (s->sew != MO_64 || s->cfg_ptr->ext_zve64x);              \
> +}
> +GEN_ABD_CHECK(vabd_vv_check, opivv_check, MO_64)
> +GEN_ABD_CHECK(vabd_vx_check, opivx_check, MO_64)
> +GEN_ABD_CHECK(vwabd_vv_check, opivv_overwrite_widen_check, MO_16)
> +GEN_ABD_CHECK(vwabd_vx_check, opivx_overwrite_widen_check, MO_16)
> +
> +GEN_OPIVV_TRANS(vabd_vv, vabd_vv_check)
> +GEN_OPIVX_TRANS(vabd_vx, vabd_vx_check)
> +GEN_OPIVV_TRANS(vabdu_vv, vabd_vv_check)
> +GEN_OPIVX_TRANS(vabdu_vx, vabd_vx_check)
> +
> +#define GEN_ABD_OPIVV_WIDEN_TRANS(NAME, CHECK)                          \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    static gen_helper_gvec_4_ptr * const fns[2] = {                     \
> +        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                   \
> +    };                                                                  \
> +    return s->sew <= MO_16 && do_opivv_widen(s, a, fns[s->sew], CHECK); \
> +}
> +
> +#define GEN_ABD_OPIVX_WIDEN_TRANS(NAME, CHECK)                          \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    if (CHECK(s, a)) {                                                  \
> +        static gen_helper_opivx * const fns[2] = {                      \
> +            gen_helper_##NAME##_b, gen_helper_##NAME##_h,               \
> +        };                                                              \
> +        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm,                \
> +                           fns[s->sew], s);                             \
> +    }                                                                   \
> +    return false;                                                       \
> +}
> +
> +GEN_ABD_OPIVV_WIDEN_TRANS(vwabda_vv, vwabd_vv_check)
> +GEN_ABD_OPIVX_WIDEN_TRANS(vwabda_vx, vwabd_vx_check)
> +GEN_ABD_OPIVV_WIDEN_TRANS(vwabdau_vv, vwabd_vv_check)
> +GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b68160af83..be2332083c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -731,6 +731,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if ((cpu->cfg.ext_zvabd) && !cpu->cfg.ext_zve32x) {
> +        error_setg(errp,
> +                   "Zvabd extensions require V or Zve* extensions");
> +        return;
> +    }
> +
>      if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
>          if (cpu_cfg_ext_is_user_set(cpu, CPU_CFG_OFFSET(ext_zicntr))) {
>              error_setg(errp, "zicntr requires zicsr");
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 0d1e4e0964..917a48b510 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -5911,3 +5911,59 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
>  GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
>  GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
>  GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
> +
> +/* Zvabd Extension */
> +#define DO_ABD(N, M)  (N > M ? N - M : M - N)
> +#define DO_ABDACC(N, M, D) (DO_ABD(N, M) + D)
> +
> +RVVCALL(OPIVV2, vabd_vv_b, OP_SSS_B, H1, H1, H1, DO_ABD)
> +RVVCALL(OPIVV2, vabd_vv_h, OP_SSS_H, H2, H2, H2, DO_ABD)
> +RVVCALL(OPIVV2, vabd_vv_w, OP_SSS_W, H4, H4, H4, DO_ABD)
> +RVVCALL(OPIVV2, vabd_vv_d, OP_SSS_D, H8, H8, H8, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_b, OP_SSS_B, H1, H1, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_h, OP_SSS_H, H2, H2, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_w, OP_SSS_W, H4, H4, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_d, OP_SSS_D, H8, H8, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_b, OP_UUU_B, H1, H1, H1, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_h, OP_UUU_H, H2, H2, H2, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_w, OP_UUU_W, H4, H4, H4, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_d, OP_UUU_D, H8, H8, H8, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_b, OP_UUU_B, H1, H1, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_h, OP_UUU_H, H2, H2, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_w, OP_UUU_W, H4, H4, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_d, OP_UUU_D, H8, H8, DO_ABD)
> +
> +RVVCALL(OPIVV3, vwabda_vv_b, WOP_SSS_B, H2, H1, H1, DO_ABDACC)
> +RVVCALL(OPIVV3, vwabda_vv_h, WOP_SSS_H, H4, H2, H2, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabda_vx_b, WOP_SSS_B, H2, H1, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabda_vx_h, WOP_SSS_H, H4, H2, DO_ABDACC)
> +RVVCALL(OPIVV3, vwabdau_vv_b, WOP_UUU_B, H2, H1, H1, DO_ABDACC)
> +RVVCALL(OPIVV3, vwabdau_vv_h, WOP_UUU_H, H4, H2, H2, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabdau_vx_b, WOP_UUU_B, H2, H1, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabdau_vx_h, WOP_UUU_H, H4, H2, DO_ABDACC)
> +
> +GEN_VEXT_VV(vabd_vv_b, 1)
> +GEN_VEXT_VV(vabd_vv_h, 2)
> +GEN_VEXT_VV(vabd_vv_w, 4)
> +GEN_VEXT_VV(vabd_vv_d, 8)
> +GEN_VEXT_VX(vabd_vx_b, 1)
> +GEN_VEXT_VX(vabd_vx_h, 2)
> +GEN_VEXT_VX(vabd_vx_w, 4)
> +GEN_VEXT_VX(vabd_vx_d, 8)
> +GEN_VEXT_VV(vabdu_vv_b, 1)
> +GEN_VEXT_VV(vabdu_vv_h, 2)
> +GEN_VEXT_VV(vabdu_vv_w, 4)
> +GEN_VEXT_VV(vabdu_vv_d, 8)
> +GEN_VEXT_VX(vabdu_vx_b, 1)
> +GEN_VEXT_VX(vabdu_vx_h, 2)
> +GEN_VEXT_VX(vabdu_vx_w, 4)
> +GEN_VEXT_VX(vabdu_vx_d, 8)
> +
> +GEN_VEXT_VV(vwabda_vv_b, 2)
> +GEN_VEXT_VV(vwabda_vv_h, 4)
> +GEN_VEXT_VX(vwabda_vx_b, 2)
> +GEN_VEXT_VX(vwabda_vx_h, 4)
> +GEN_VEXT_VV(vwabdau_vv_b, 2)
> +GEN_VEXT_VV(vwabdau_vv_h, 4)
> +GEN_VEXT_VX(vwabdau_vx_b, 2)
> +GEN_VEXT_VX(vwabdau_vx_h, 4)
> -- 
> 2.39.5

