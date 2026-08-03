Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E7AC55174
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 02:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqiOG-0007zO-3Q; Sun, 02 Aug 2026 22:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wqiO8-0007s9-MZ; Sun, 02 Aug 2026 22:26:49 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wqiO7-0000IX-1L; Sun, 02 Aug 2026 22:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd29ThTRdAt/SMqtvfxW4CVRVS19Ifz1w1PFgOk2cDJou8dzyXerQCg0kOnc2axIcU8a92+43/UWl6fuw30BPJzSptwsYPftBUMTa3VVncuCjry8CBGXYj/AMxldcGzcvnf85f3zmxnLtjIVXaVoQnTPWP+/94xmq0dki+yUi3dVftsMqjAmPM8mqHnjewCa3EP+vNZiEBIuVcu50kTXqA+4XdmuMNGOzIyoBdHSxK1ovySQElGvzVSJT0rtGNReVuEo9x4JPalPe2Wa2wc2+154/iJOeYVjA2iwAQi6QNRRZb/ycQeUFzzSqh+LAOwu79zEuh189vNwpuWFvdvZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyAMD8oIuoShfV7ldIz8VkU8p7TY2Rm+eY9hGI3xCK4=;
 b=idxTJaG2EhX4cJMbGNKZrdqwN5cdjYxntXmBtZ8KRyKF4OO1YwhbQBoizZNZJMoggneFHq3TgRWrOQzT2wVTq9MR5Eo4cb+rBjmbf/oDW/HbZdEWhZnvdNljuwjVl7Lps0yWCQjBGjkflwnkY+AEyTnRkn698qgDXwMOXIYE7HJQqoGNpy4sIWUW6NBhrvNaMDaJuFu1S55x0V3p2rZp92Eu2nKXU/j3BQnX2WnoiGtbtepU3pmuh5F8aJR00cAM6bhoKHCQc/KIffv+R53sHHYT0/Tljb3UTL/NszerUIVsJJz+3C/1/iGByhUHDTWXb7o1XJLbE4nOaxRJtoPzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyAMD8oIuoShfV7ldIz8VkU8p7TY2Rm+eY9hGI3xCK4=;
 b=sJRxi9mM52E672CgkviMxXw0KVuzuRT3Z94Lp9KJmmjjxPzBhgM8JfC2dvojJFzjOPo1MHu7MzYpWIHkJSI7uvHIxo27mBFjMuQdHJqAVsvKFYnEYQM1Q9z3low0xH24zr69D3MEa9kbCXRE0nrDvudWG9xQxc04BibF28w5dHtS1QKLBfl/0BeP4LAmR80/AcKA3OozK++dYy7/HV5h9KqsoPCQxzAY3V42WvH5lb9YGs7i30ACFP+b+ClDIUwRim9Gn2fGTDqSBgK+u4MV2M2s5+CzvMMJfVcaKVo13dgtB0a+3eUlgMpdwRClfDMKuv1t4WsV1JtAuc3lmE14QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6426.apcprd02.prod.outlook.com (2603:1096:820:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 02:26:39 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 02:26:39 +0000
Date: Mon, 3 Aug 2026 10:26:35 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Molly Chen <xiaoou@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 18/18] target/riscv: Remove Zbkb dependency from P
 extension to align with the spec
Message-ID: <am_8SpKAh78-bKBy@ChaodeMacBook-Pro.local>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <c2c9fd17d043449e94d6a63206696d50e1f4a257.1784280142.git.xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2c9fd17d043449e94d6a63206696d50e1f4a257.1784280142.git.xiaoou@iscas.ac.cn>
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 758c8fd7-0a7a-4f2a-5128-08def106a637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: xzk2YzNudK83bX0kkPdGXMAjT8A4CH6puOjxWdX0+h5VZVjIgG3ZqA20U1roOj/iITv+R6tAoTks8Gt6HlamqkNGC9icbU9arU94/Q/cTWVeTx1QJEg/Duyll81M7STT8VhcNL1CPbxuNRZfzBMsqPkzEyTeGeREWB6/j5Dc7lHPQdECNPtsGo9MjT4S84C41dY2C28IHGqk/5WPP5iLW/eV96guVoCxnWGIhRT3kwNoymy+QdFEePGbTVpKXD+dlkUEloFN4R3FR5fb2Viflv85Ezetrrsqwh7kV89QJgpkoz589tGWIxiv8Zz28OqhQ/6nIpqkfRjnL8Vtiq5M7tAw7fSKX/BNrQ4P8RFF8+9NA6GyNAJFCkDe7loPOtSrAkZ3EW8ZuqV2XWXo5WFusSG5IFi3bTl7vWNR55Z1U/iFHcUG1r04G4zoc6ZaFRePx/rI6yyNUq/QAQ7ItM95wK884aityzZkEJ/Pyp+2OVStYm6XN+IQb3dYS3JN/IS3OK73QxIXb9pJYWT1O4UNR5LmFzThPdXWaCo2IR6xQiFPC0BN27vv/ajqe/7r87XK46cTTe0w8fmebQBij3O/vFR+6vAZgj9oMwz17gyqLzbUrmhAoU83NI2edfyYpLG1SdD13iKcDPiMPZXIy2a7f+5Pzr4PR04fj+H+vp2lxsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4ok9Q8yYMLzfWQSZIfO8KhfQh/0bhSd41s1o98Kka8Ump3AdIMA7XzOXQ4S?=
 =?us-ascii?Q?sB/rLMtcIHGeaRfXiY9Xe+/+WM1JMV1wF6K9hKFwOSzCSBWuMEWwIZ8B3U75?=
 =?us-ascii?Q?sBeOP1iZ9+Kh0Q7KpyS0Sf9FwWCBm0bUE+omGOoZjWbW0RHPXV26RhT4ycav?=
 =?us-ascii?Q?F72FMukDccfD26vQRBm1gBKuHpTs+Na4qeBEw/PWRExk8lcWMSo7blXtTzM8?=
 =?us-ascii?Q?Pqqb5z2JLipi2KyfkUZEl4y1e39QuaQV38VZK2eu9YQhYKTwQRyowBfaCEc4?=
 =?us-ascii?Q?oVJOBSYufnXzonCTguIE7OA+kEclBxvWiiIHdvI9oLLS0XGUbB2/AQugJ4X6?=
 =?us-ascii?Q?pkJLMnVDiyq7zYrTobmsYDlqhKVI3Rd1dLfoKuENDXhFx4veCdmaO0bbQqPl?=
 =?us-ascii?Q?5RN+85FMW8SoQiq7eOP6LCO9f5jRraDny11+fDYK6t40sI82ICddmy1FuJCM?=
 =?us-ascii?Q?NwBpyMr63GX5htfInq6hZkBei8m52keJwRG8/5Ooop3eaSspA/nkbNqkN1vq?=
 =?us-ascii?Q?Z7ucakJXWYJS/x2pJAaJK001HUw7oldsoFrFmho2qG2nB3XSqYHidmtmfazH?=
 =?us-ascii?Q?U49nkxgtasnqcockji5ZEfbvdwwhT+/9hht608o3GwNN2y2TAuG3cVaQBrm0?=
 =?us-ascii?Q?au0+rpzCdEEQsWsFRsqUAI3Mj82quM/YVW6/AyO8gvVYB9wzaSeDlczNgP8d?=
 =?us-ascii?Q?3QoDuyzvBIS/CD3ZkM8U83P+QCKpXwF81aL+NugBp0cxS4KeeCwWvUA87En/?=
 =?us-ascii?Q?1IRZAR9qRJVFwat2lMetYPBfc1WDgmFLdmnJoG5yqIjb4Hu3AtvqD0Xo9B2Q?=
 =?us-ascii?Q?uCFxwa6NF1mMW6PjshSuSYmejuDT99hSZKbdVU0MYbrgp+5oT/KabAXkd+Tc?=
 =?us-ascii?Q?jUaoTNyvOOFk5FTMYN8hCkG+IoqkBwetLC7+HQ7Ps5ezNavmFAZWeNbAAiNi?=
 =?us-ascii?Q?KLDJhW9Tkm1Qa32FcyUkIA6aSjJjq2iXaUQPlvxuclwvTs1kJ8W2AAFBRjD6?=
 =?us-ascii?Q?xaQxjpy148sn7xaWcAWZblQ1eufWi4lyQ5q3Lz4oPQRdm8hWlN5iF7EAQ3Ru?=
 =?us-ascii?Q?sUVs4TZwf+CBbkN4XYzsKxE9kj2EXoND0XgTbNNeVK35BV6SvzuW1rvcT1Ku?=
 =?us-ascii?Q?BrsUQtgNDHsZYJEb3vjcahYLzosPd79vpPfoXA4M6E6F2WzYiwWKRgsVnFKg?=
 =?us-ascii?Q?cs+SqdRG27uj5fDTWjFPzMb+V4+nhlNa+j1Q8JFkfjUbrfpJnoNDVcHiIrhx?=
 =?us-ascii?Q?Ejb0cEvFF0UzJZRQfdr9+sI6HV2nhvwxv9nbwbz7gYg5pWx2iPFgnvK1ivm+?=
 =?us-ascii?Q?b3HRJzW7d9cbGTr8LCXCu7SFBOsvC7KfCVuHfxDMxZ/O6sh6PFtnC4mKgVkY?=
 =?us-ascii?Q?HXU/CHfZePSkTtYZNUcJ1jI580Yf4mSeXjyn7IhFaok6pBI/WVWPqVzgKxFj?=
 =?us-ascii?Q?qqtjBV8hF0vKn4rDg8a2VGHj8LX7iDi3nywj/EsQP8kSYexewpg1iz5QpC7D?=
 =?us-ascii?Q?LBaZ6WrSoM9Plghswwtz907YjgcRhiGnpQCtkZ5LhIKXDO7TcqEt3oxJqCqa?=
 =?us-ascii?Q?g7VvHHZW9pJgFFbrEUFJOviWMXHMMlX5P0MJkVLSAF32HvriNgp3BjDsjNGZ?=
 =?us-ascii?Q?JO05K5hSZbt8SuEkdEF6Mym6Ktdu3I5FSzEv21x2QMNhKLscPq8WhNKdDzhT?=
 =?us-ascii?Q?3dMX/sLJfo9wkKTpyD9oG3knMy30sqMWQhkCKa6M3oXnXKldfi3P5mm8jBun?=
 =?us-ascii?Q?1bLPrZn3E3uRCei1O/tu79uE/zr1q3U=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758c8fd7-0a7a-4f2a-5128-08def106a637
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 02:26:39.5521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vo81e1aV1wIxjBF+3bjBciF797coSO7dcyyMJCAfOExBULfE/vabZQQFJY77NpQ0bk3m4DZnyh1/Mb50nhnOB26wgSN4jjMGKFnU2BTfKWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6426
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

On Fri, Jul 17, 2026 at 10:07:11AM +0800, Molly Chen wrote:
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/tcg/insn_trans/trans_rvb.c.inc | 4 +++-
>  target/riscv/tcg/insn_trans/trans_rvp.c.inc | 2 +-
>  target/riscv/tcg/tcg-cpu.c                  | 6 ++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
> index e4dcc7c9913..af53eb4fe4b 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvb.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
> @@ -527,7 +527,9 @@ static bool trans_brev8(DisasContext *ctx, arg_brev8 *a)
>  
>  static bool trans_pack(DisasContext *ctx, arg_pack *a)
>  {
> -    REQUIRE_ZBKB(ctx);
> +    if (!has_ext(ctx, RVP) && !ctx->cfg_ptr->ext_zbkb) {
> +        return false;
> +    }
>      return gen_arith(ctx, a, EXT_NONE, gen_pack, NULL);
>  }
>  
> diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
> index e33e0ec110a..8c5b52ca970 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
> @@ -1386,4 +1386,4 @@ GEN_DWS_REG_OP(psll_dws, gen_shift, EXT_NONE, tcg_gen_shl_tl)
>  GEN_DWS_REG_OP(psrl_dws, gen_shift, EXT_ZERO, tcg_gen_shr_tl)
>  GEN_DWS_REG_OP(psra_dws, gen_shift, EXT_SIGN, tcg_gen_sar_tl)
>  
> -GEN_DW_PAIR_ARITH(ppaire_dh, REQUIRE_ZBKB(ctx); , EXT_NONE, gen_pack)
> +GEN_DW_PAIR_ARITH(ppaire_dh, , EXT_NONE, gen_pack)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 1665583accf..36b0196a626 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -563,10 +563,8 @@ static void riscv_cpu_validate_p(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> -    if (!(cpu->cfg.ext_zmmul && cpu->cfg.ext_zba && cpu->cfg.ext_zbb &&
> -          cpu->cfg.ext_zbkb)) {
> -        error_setg(errp, "P extension requires zmmul, zba, zbb and zbkb "
> -                         "extensions");
> +    if (!(cpu->cfg.ext_zmmul && cpu->cfg.ext_zba && cpu->cfg.ext_zbb)) {
> +        error_setg(errp, "P extension requires zmmul, zba and zbb extensions");
>          return;
>      }
>  }
> -- 
> 2.34.1
> 

