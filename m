Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F20C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAnjb-0003PN-6B; Sun, 27 Sep 2026 08:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnjZ-0003Ow-9s; Sun, 27 Sep 2026 08:11:57 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnjW-0001i2-E0; Sun, 27 Sep 2026 08:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQfma9N4cpV02jSdI8MNR+HCcTSgWelyQJfVVY+NgvxWmOTCdpkpGoOD1Cnpya6woehhRUIfnrBL2QCxyZoYC0WutwtbXAc5B39rptV8JYbHX0655fYpM3ZhW+4/EIO4PlIGAB4bAfVMSWv8/4SsV8Yq7j6eLCRSz5OcuD3NcX8ASZEEDgV1rbWY0BzPIPEVFEHiQhrEsG/BuIZFcA+JooPIcMkFwUPyxWXkUxOCD6HESr9zMVIyXw3OlK5erdc0f2vgfbgzNddT/SCJ6WWlgxfaG4JDtOKk+xF1z8wqKPLG2iflqoHd4obAGZoME3DPneaHh6yOpTIAbrFP9TJm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYISzz3BASxIfYt2XLm6pgU61rixsd3tatrcsKcdmZA=;
 b=PxlS8k+inUdbwaP6JRWLSH9Ep8wcHYjrTTCG4qlSrc7bwN5S1NUvBPKZBVqssHUWp/tXCnZKOA7xAJ562QL+HM25nHrgQNjsfvWyU0+L7Lo58bzr2DENaL76i3GWsODYi+xR8C1zNm4HXXV0qcGOpuXsF4CNAtW2A9olMH4lWVgUOvES/Qs9Gmojz/+aKkhttIgfSTT0nuomklnVvwzcDruV7LeowOleOWpUCUu7liADh/gVghN9iZA5SuqpPFyJioTRVUJ53mkGPHXpqIdSLeF+6bkQ4EUiAi1J6uG3Qeh9zCpDmXNsEUU2NdZRFns0gmurcjueV9U/yrE+g/yNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYISzz3BASxIfYt2XLm6pgU61rixsd3tatrcsKcdmZA=;
 b=Iwoyl84fPltFpIvK61BdzkmELYWVBZYeM5S25lrtOYkTbOkZwUhfy80O5+goGvS0co2XFaABj689+w48uY1k7TKzrQ9G6J5t//QwF30I7BdAmwWaVu+aurjZPQmvMNijBtT2ts/Ubl3RENwMsW32tOXBeHJG2zv0swsx/fXZBX6RRC/3mbDCdCPX+8ydMGFhJ6aVigHNiWbs08/sIBkFnSb7MPXjKwyI8bw6u9sCtefxvb7cuCNFNm3kmTv1ce6chmIQm+/qlDErm74wgUyM9QFCn97AUGxLaW72eUVZQn70CaVo7IHEkDCEdoOR4kSGMdsy+/JilnKzJzDD15TF7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by SEZPR02MB7365.apcprd02.prod.outlook.com (2603:1096:101:1f6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 12:11:47 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 12:11:47 +0000
Date: Sun, 27 Sep 2026 20:11:41 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 6/6] tests/tcg/riscv64: Add tests for SiFive int8
 matmul extensions
Message-ID: <arkH39PkZWjekd-z@MacBook-Pro-4.local>
References: <20260927082534.3228237-1-max.chou@sifive.com>
 <20260927082534.3228237-7-max.chou@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927082534.3228237-7-max.chou@sifive.com>
X-ClientProxiedBy: PH7P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::16) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|SEZPR02MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 00495a23-b0e9-4d81-2fc3-08df1c90810d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|4143699003|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 2XJDQQQPO4DvEAj1j9DBWYmj+eRGbrVhJi8LEVk8q8+FkMeW5ctV2WCuc32jwmCRcmArWcAI17AEVIcUHUxvgTqCaQnqzfg2Fl+SFbPMGmHYnPdlgaeS1ZbKQobi7am0u6+d4phcmuLem1/JX2nZTZK8NeKWwwn56dt5lcdnBhh6aPKfhfYckuBOvXHr55f/FZezXJoT+gy0WmDBpeaXeUiUUFSBFTUPoiYsZ0QDmJ3cXJaSehhhmqPiydJjC+YqvIyWmA+a4W3IaasVnPavVMcLL0CUbrBzwu05Rc8OoK+On+tmfnErRGxek3qFlUW4V969NpuJxvx42ZGfU0Rbo+2IzlkGj4Iz4vEysKmR1JioIdIgo77m/Hn+dOO1iRWe7v+GtBIdC9gpGAlPnYWl9a8gDYclmiPteYXY/UhT4sv3c1Wk5fN3Jl6XYhSkzcQ1lf+qtwL1joS/Hi/Y9V7vyNAR9ak1/+3l2PgIgMcXDeyO0kjJoEhrNWkYh2zjfKuN+E5ciX0g7dT/TAwEok4TBiY96z+7MnZ759is8gncH+hHZ9sk//LlMAxpIYbUKwU8biH6pjw6nmUzbb+8YECd9u06YnSOJk5c6DAqbgLT8O17V4NjRrhwyQj/jZdfAv8dve//5J6Kq3RW5PHVDAg5PhkXjPtRr0phsJAKrlkc6C8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSdN/VEaH3qpxKP3O1PRYJSXBRRM9noCaOc7c6AkDVqjn5Tav/W9QfXm2Gsn?=
 =?us-ascii?Q?V2xcx9rslU33EdTn7cExsTGVNJwPmDEateovC35/hpRTY0XJVAqQpNszHgM3?=
 =?us-ascii?Q?MIhOYZMqp8aD1dLrme2CeedwaxqEAlNnwwz0c0msX5SnXb6zfgBE68fVvX/b?=
 =?us-ascii?Q?GU0NXhU1006UxBz5vkOOWuqAqw9zApxNRs0QktqsEL1ZUWkT9VjgDAs09FRN?=
 =?us-ascii?Q?lekZdGSECawBcVA8COyA5Yft9tuVExJlfWSrzyxrigylk0LfDJdxUrhG7K8o?=
 =?us-ascii?Q?Eg+nxF9C1SLp7fo7rU41ZuURRqN5TCRvRHuBMzQsfE4nLP6cY19q2/PZYtBE?=
 =?us-ascii?Q?2Or8BWCo2SEBy0md4GD76RCf8L6L2bttNbKuM19ERsCGxF/c8jjNHfBiRyB9?=
 =?us-ascii?Q?DEGZ1laxhavYHJaojH8dcqxRAv9ba3sw5iHBp1e8GVQDYZ5+8hSKchuroceB?=
 =?us-ascii?Q?THQ/UWvCG/jIs5DY94a57NLh1vpEhqLfPK1mVq+hUe7+qeitz+iC+0ODbaYy?=
 =?us-ascii?Q?Wo2i2PtwgPlqrZuG/6vD/wBd1RXEsl1ib0bNxChmZ3HJgIQCTpLwYrzqq5MG?=
 =?us-ascii?Q?lOkOZacnTw52I2uvsLGEVLbhDj2hhpu213Xto52ERe6YGHzsly49u6r7uPvE?=
 =?us-ascii?Q?iHj/zLQM/7rpN6DqylH1PyNTY0F0n6CNJ4NLQIUjPhsfbrUI1xJplv4qv0hT?=
 =?us-ascii?Q?juTs8+VQ1Uouw/PmC2oQJViDpBw5UiKQjbllWNTFGJDcArzsL+BaE1rxVR0s?=
 =?us-ascii?Q?bv/N//QcOqnDaEGR1rRk6V0fy7vvm5AwAheeiRzVp9Q96mgPJFbV+0QGKcWO?=
 =?us-ascii?Q?aGPQSQjC1XQvintCz2LbJzmwRZ9EahKMslMfHsKkZDKNp6hPmI8gt5PXZQzR?=
 =?us-ascii?Q?SeGfLWwXv5rSQub9qyKhINm+Ack7JRYpNHksIWCQsGx0ps4GKPTjTMtrE/5M?=
 =?us-ascii?Q?y8USfB9Yru4TJFTKgcbGvXeQGrXmxcgBop/PGHnr29RMOEkJzDsrcr6QAsrl?=
 =?us-ascii?Q?iEdpiH62V7hlk3THznupArlj7RVUJhWjd15tbLD0jepNJdpfJjPIKHZi5tyr?=
 =?us-ascii?Q?Kbs9saNtI9KviKsd2hCb+ZVxD8UISS7vpEW7g4IEUllyBWKs7X+LqES4jTz5?=
 =?us-ascii?Q?QfMq5KCX29iEUX9dBtqXzZ6zmMpmi7bZryDErFxpiedABZCFs9cznhFQQtbn?=
 =?us-ascii?Q?UrkLOB6h3uin9MYLjAVpeTuGmt78rna+OW6zUOg+qrdg6L4E2FtT5HH6TZsB?=
 =?us-ascii?Q?H7AQ3D0dFNM4+Jm4rhK3CTQMVn7HF4xCijl5d2nCpt35wWEPUM73LI1f5OoV?=
 =?us-ascii?Q?KPIygl/Nzp6vnHHuS8pEzYEMlElEoufyLLTo8lrlGC0ot7RHjDl8wQFF9I34?=
 =?us-ascii?Q?Yk1zkuWNanjP/xThk9pqVnmV9pfLhrh+xIIOI6tY7obffATcOaQ1zTqIX7Er?=
 =?us-ascii?Q?9SInUHW45u2sL6mh+dWc4VTexdzMUrsBmz1I8N7uFqKZTk/VtMIA5WpXrEvs?=
 =?us-ascii?Q?5OOKA6dGe6F3YBm0hWsTOnGRWjDzQaleS5PKy+dNyrB5P0tbHX5+azBkf/g2?=
 =?us-ascii?Q?9IZjwH+p9k2BcdC9WAqLdDbGKNiKSajeabAi7SB7+nTkCY1p9OLpzTjwJ6yf?=
 =?us-ascii?Q?zYOUi5GFz5QOZ/4N+pUF7Oz5RT/bzRq7eD/DBhLYE1LEPUNZbI8QrTowDKbm?=
 =?us-ascii?Q?qJ/L3Xxjue5tCSAFdH1uY6Z61H0jBb0u/D2N7FXdz9GJ0fjpxZv4gNws1SiI?=
 =?us-ascii?Q?Gje4cdHhvySeYbpdetapJj0Wl0uPA+0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00495a23-b0e9-4d81-2fc3-08df1c90810d
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 12:11:47.8167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXQtCPOobt/ARLoyjEratbXxHZ4pQXhKqN0kDmCcSYaFJ14hVDBhkjB+fTSLNlYfZHMMs9H93ZkHmKvYi7KrfsHCyebA+HQoULNCEA2iSOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7365
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

On Sun, Sep 27, 2026 at 04:25:34PM +0800, Max Chou wrote:
> Add a test that exercises all SiFive int8 matrix-multiply instructions
> from the Xsfvqmaccqoq and Xsfvqmaccdod extensions.
> 
> For each tile shape the test covers the four signedness variants
> (sf.vqmaccu / sf.vqmacc / sf.vqmaccus / sf.vqmaccsu) and the
> reserved-encoding path: with vl set to a value that is not a multiple
> of the tile size the helper raises an illegal-instruction exception.
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  MAINTAINERS                          |   1 +
>  tests/tcg/riscv64/system/meson.build |   7 +
>  tests/tcg/riscv64/test-xsfvqmacc.S   | 260 +++++++++++++++++++++++++++
>  3 files changed, 268 insertions(+)
>  create mode 100644 tests/tcg/riscv64/test-xsfvqmacc.S
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index be1c505ac20..9bf7f46fc24 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -407,6 +407,7 @@ F: target/riscv/xsf.decode
>  F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
>  F: target/riscv/tcg/xsf_helper.c
>  F: disas/riscv-xsf*
> +F: tests/tcg/riscv64/test-xsfvqmacc.S
>  
>  RENESAS RX CPUs
>  R: Yoshinori Sato <yoshinori.sato@nifty.com>
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 2aca68e0782..7f861212366 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -62,6 +62,13 @@ tests += {
>    }
>  }
>  
> +tests += {
> +  'test-xsfvqmacc.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'rv64,v=true,vlen=256,xsfvqmaccdod=true,xsfvqmaccqoq=true', qemu_args],
> +  }
> +}
> +
>  if 'qemu-system-riscv64' in emulators
>    tcg_tests += {
>      'riscv64-softmmu': {
> diff --git a/tests/tcg/riscv64/test-xsfvqmacc.S b/tests/tcg/riscv64/test-xsfvqmacc.S
> new file mode 100644
> index 00000000000..a116712e502
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-xsfvqmacc.S
> @@ -0,0 +1,260 @@
> +/*
> + * Test the SiFive Xsfvqmaccqoq/Xsfvqmaccdod custom int8 matrix-multiply
> + * extensions.
> + *
> + * The eight instructions widen 8-bit integer inputs to 32 bits and perform
> + * a matrix-multiply-accumulate into a vector of int32 accumulators:
> + *
> + *   C[j] += A * B[j]
> + *
> + * Xsfvqmaccqoq (4x8x4): A is 4x8, B[j] is 8x4, C[j] is 4x4 int32. One matrix
> + * operation is performed per 32 elements of vl (TILE_SIZE = 32).
> + * Xsfvqmaccdod (2x8x2): A is 2x8, B[j] is 8x2, C[j] is 2x2 int32. One matrix
> + * operation is performed per 16 elements of vl (TILE_SIZE = 16).
> + *
> + * The input tiles below contain bytes >= 0x80 so that each signedness
> + * variant produces a distinct result; the expected int32 tiles were computed
> + * with an independent reference model of the specification. The accumulators
> + * are cleared before every operation, so the expected value is the pure
> + * matrix product.
> + *
> + * Test exits via semihosting with status 0 on success, or the 1-based index
> + * of the first failing operation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +	.option arch, +v
> +	.option norvc
> +
> +	.text
> +
> +/*
> + * Run one 4x8x4 operation: load the 32-byte A and B tiles, clear the 4x4
> + * int32 accumulator (vd = v4:v5, EMUL = 2), execute the op, then compare the
> + * 16 int32 results against the expected tile.
> + */
> +.macro RUN_QOQ id, word, exp
> +	li	a2, 32
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	la	t1, a_qoq
> +	vle8.v	v1, (t1)
> +	la	t1, b_qoq
> +	vle8.v	v2, (t1)
> +	vsetvli	t0, x0, e32, m2, ta, ma
> +	vmv.v.i	v4, 0
> +	li	a2, 32
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	.word	\word
> +	vsetvli	t0, x0, e32, m2, ta, ma
> +	la	t1, result
> +	vse32.v	v4, (t1)
> +	la	a0, result
> +	la	a1, \exp
> +	li	a2, 16
> +	li	t6, \id
> +	call	check_words
> +.endm
> +
> +/*
> + * Run one 2x8x2 operation: load the 16-byte A and B tiles, clear the 2x2
> + * int32 accumulator (vd = v4, EMUL = 1), execute the op, then compare the
> + * 4 int32 results against the expected tile.
> + */
> +.macro RUN_DOD id, word, exp
> +	li	a2, 16
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	la	t1, a_dod
> +	vle8.v	v1, (t1)
> +	la	t1, b_dod
> +	vle8.v	v2, (t1)
> +	vsetvli	t0, x0, e32, m1, ta, ma
> +	vmv.v.i	v4, 0
> +	li	a2, 16
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	.word	\word
> +	vsetvli	t0, x0, e32, m1, ta, ma
> +	la	t1, result
> +	vse32.v	v4, (t1)
> +	la	a0, result
> +	la	a1, \exp
> +	li	a2, 4
> +	li	t6, \id
> +	call	check_words
> +.endm
> +
> +	.global _start
> +_start:
> +	/* Enable the vector unit (mstatus.VS = Initial). */
> +	li	t0, 1 << 9
> +	csrs	mstatus, t0
> +
> +	/* Route synchronous traps to trap_handler (mtvec direct mode). */
> +	la	t0, trap_handler
> +	csrw	mtvec, t0
> +
> +	RUN_QOQ	1, 0xF220A25B, exp_qoq_u	/* sf.vqmaccu.4x8x4  */
> +	RUN_QOQ	2, 0xF620A25B, exp_qoq_s	/* sf.vqmacc.4x8x4   */
> +	RUN_QOQ	3, 0xFA20A25B, exp_qoq_us	/* sf.vqmaccus.4x8x4 */
> +	RUN_QOQ	4, 0xFE20A25B, exp_qoq_su	/* sf.vqmaccsu.4x8x4 */
> +	RUN_DOD	5, 0xB220A25B, exp_dod_u	/* sf.vqmaccu.2x8x2  */
> +	RUN_DOD	6, 0xB620A25B, exp_dod_s	/* sf.vqmacc.2x8x2   */
> +	RUN_DOD	7, 0xBA20A25B, exp_dod_us	/* sf.vqmaccus.2x8x2 */
> +	RUN_DOD	8, 0xBE20A25B, exp_dod_su	/* sf.vqmaccsu.2x8x2 */
> +
> +	/*
> +	 * Illegal-instruction reporting test (op 9).
> +	 *
> +	 * When vl is not a multiple of the tile size the instruction is
> +	 * reserved and the helper raises an illegal-instruction exception at
> +	 * runtime.
> +	 */
> +	la	t1, trap_mtval
> +	sd	zero, 0(t1)
> +	la	t1, trap_mcause
> +	sd	zero, 0(t1)
> +	/* vl = 16 is not a multiple of the 4x8x4 tile size (32 elements). */
> +	li	a2, 16
> +	vsetvli	t0, a2, e8, m1, ta, ma
> +	.word	0xF220A25B		/* sf.vqmaccu.4x8x4, traps */
> +	/* The handler skips the faulting insn, so control resumes here. */
> +	li	a0, 9			/* fail code for this check */
> +	la	t1, trap_mcause
> +	ld	t2, 0(t1)
> +	li	t3, 2			/* RISCV_EXCP_ILLEGAL_INST */
> +	bne	t2, t3, _exit
> +	la	t1, trap_mtval
> +	ld	t2, 0(t1)
> +	li	t3, 0xF220A25B
> +	bne	t2, t3, _exit
> +
> +	li	a0, 0
> +	j	_exit
> +
> +/*
> + * Machine-mode trap handler: record mcause and mtval, then advance mepc
> + * past the 4-byte faulting instruction and return.
> + */
> +	.balign	4
> +trap_handler:
> +	csrr	t4, mcause
> +	la	t5, trap_mcause
> +	sd	t4, 0(t5)
> +	csrr	t4, mtval
> +	la	t5, trap_mtval
> +	sd	t4, 0(t5)
> +	csrr	t4, mepc
> +	addi	t4, t4, 4
> +	csrw	mepc, t4
> +	mret
> +
> +/*
> + * check_words(a0 = result, a1 = expected, a2 = word count).
> + * Returns to the caller if every word matches; otherwise exits with the
> + * operation index held in t6.
> + */
> +check_words:
> +1:	beqz	a2, 2f
> +	lw	t2, 0(a0)
> +	lw	t3, 0(a1)
> +	bne	t2, t3, 3f
> +	addi	a0, a0, 4
> +	addi	a1, a1, 4
> +	addi	a2, a2, -1
> +	j	1b
> +2:	ret
> +3:	mv	a0, t6
> +	j	_exit
> +
> +/* Exit through the semihosting SYS_EXIT_EXTENDED call with a0 as the code. */
> +_exit:
> +	la	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	8
> +semiargs:
> +	.space	16
> +result:
> +	.space	64
> +trap_mcause:
> +	.space	8
> +trap_mtval:
> +	.space	8
> +
> +/*
> + * A (4x8, row-major) in bytes [0, 32) of vs1.
> + */
> +a_qoq:
> +	.byte	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x80
> +	.byte	0xFF, 0x01, 0x00, 0x02, 0x7F, 0x03, 0x04, 0x05
> +	.byte	0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x08
> +	.byte	0x00, 0x00, 0x81, 0x00, 0x00, 0x02, 0x00, 0x03
> +/*
> + * B (8x4, row-major) in bytes [0, 32) of vs2.
> + */
> +b_qoq:
> +	.byte	0x01, 0x02, 0x03, 0x04
> +	.byte	0x05, 0x06, 0x07, 0x08
> +	.byte	0x80, 0x7F, 0xFF, 0x01
> +	.byte	0x00, 0x10, 0x20, 0x30
> +	.byte	0x02, 0x02, 0x02, 0x02
> +	.byte	0xFE, 0x01, 0x00, 0x7F
> +	.byte	0x03, 0x00, 0x81, 0x04
> +	.byte	0x40, 0x50, 0x60, 0x70
> +/*
> + * A (2x8, row-major) in bytes [0, 16) of vs1.
> + */
> +a_dod:
> +	.byte	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x80
> +	.byte	0xFF, 0x7F, 0x00, 0x02, 0x81, 0x03, 0x04, 0x05
> +/*
> + * B (8x2, row-major) in bytes [0, 16) of vs2.
> + */
> +b_dod:
> +	.byte	0x01, 0x02
> +	.byte	0x80, 0x7F
> +	.byte	0x03, 0xFF
> +	.byte	0x00, 0x10
> +	.byte	0x02, 0xFE
> +	.byte	0x7F, 0x01
> +	.byte	0x81, 0x04
> +	.byte	0x40, 0x50
> +
> +	.balign	4
> +exp_qoq_u:
> +	.word	0x0000279e, 0x000029db, 0x0000371f, 0x00003bf7
> +	.word	0x00000648, 0x000004b5, 0x00000826, 0x0000091f
> +	.word	0x00007be0, 0x00002030, 0x000074f0, 0x000042f0
> +	.word	0x0000433c, 0x000040f1, 0x0000819f, 0x000002cf
> +exp_qoq_s:
> +	.word	0xffffde9e, 0xffffd9db, 0xffffcd1f, 0xffffcbf7
> +	.word	0x00000248, 0x000002b5, 0x00000126, 0x0000051f
> +	.word	0xffffebe0, 0x00002030, 0xffffd4f0, 0x000042f0
> +	.word	0x0000403c, 0xffffc1f1, 0x0000019f, 0x000001cf
> +exp_qoq_us:
> +	.word	0x00001e9e, 0x000029db, 0x00002d1f, 0x00003bf7
> +	.word	0x00000348, 0x000004b5, 0x00000426, 0x0000091f
> +	.word	0xffffebe0, 0x00002030, 0xffffd4f0, 0x000042f0
> +	.word	0xffffc03c, 0x000040f1, 0x0000009f, 0x000002cf
> +exp_qoq_su:
> +	.word	0xffffe79e, 0xffffd9db, 0xffffd71f, 0xffffcbf7
> +	.word	0x00000548, 0x000002b5, 0x00000526, 0x0000051f
> +	.word	0x00007be0, 0x00002030, 0x000074f0, 0x000042f0
> +	.word	0xffffc33c, 0xffffc1f1, 0xffff829f, 0x000001cf
> +exp_dod_u:
> +	.word	0x00002795, 0x00003155, 0x00004642, 0x0000c2c0
> +exp_dod_s:
> +	.word	0xffffde95, 0xffffd955, 0xffffc042, 0x000041c0
> +exp_dod_us:
> +	.word	0x00001e95, 0x00002955, 0xffffc342, 0x000041c0
> +exp_dod_su:
> +	.word	0xffffe795, 0xffffe155, 0x00004342, 0xffffc2c0
> -- 
> 2.43.0
> 

