Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1482C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 03:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4sO0-0003mb-Nd; Thu, 10 Sep 2026 23:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4sNd-0003gY-IR; Thu, 10 Sep 2026 23:56:49 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4sNb-0000Cb-Al; Thu, 10 Sep 2026 23:56:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqKo7QcHTiIJv/hvrCTWZwQbFsocPy8sV9NrcVGsaEMJhT4D9p1kw/RSAdnM9KVkHlKYLaEbcwSH3tUAcMI9AYXkelbjUni+Gz/UkmjkXMfWN/F/CzwQkk9l8lJV95XKPp7SftDG9MncJS2gPvmsE94qaNZ3CnaEnYrf5UT07fOuTpuXOFq6URZ9X1NNnbCPtAtrCmubj/phAr/WDtCH6CEuxcD5O8gSPiDukoS99e4bHeasTVYW9weuAvJmZ4/QVJHzzegHnHNF0JLewcW1sUP0oT3a/vK0Y/MVwM2pFfGQoWbrKnCqVfVoLTzTg4qTyiFxmBMnNbvAKj6QAxViig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUApQ8WAVUNCLYhAKmtzH/owmA94vhJ+LubAY7KLexw=;
 b=QdmDUY4KI5j2G8GWqUqgFxf2kHaxX6Ihk+0Iov4dWbdVrOwz3Lk3vwQV3BLIePBjM0uJ/2ofeUX4rZUBllX3yUWswmDRWL0PdjEfsRiymrp6xhCx91VBezUEB216FV0R0HTm3y77pbJIdBZV75tgYr5pIprIisinkI9A74vEZ1sLtNq/2DDxMpH8FTrxks/wkd8TpbYF3grRTT/zpgZPdBcYjdAs6fSGhKquGmSMQP4ygN77WEaDGnSUztEdywOsecRq3Ze6dv+NIIyCw4LdJObDaedWH/5YytLwqnE15K8ONCjrd8oKqT5SPqpIrCORLlaSedii0EjreS/2GL2bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUApQ8WAVUNCLYhAKmtzH/owmA94vhJ+LubAY7KLexw=;
 b=TY9ZLtOXKR3lTPp7rbDjW6q6Gxjn7o2EtH+xQIJFp0k+OaJIMRwfSBv7baa08hOX5cY4YRh8mSPw/R9WCVQvJi3Lhs6KhUaAFuTamTv0G58l/pCpt4nta2mTfTCqhikHhaoHGoXhK2HqLqW6egzJloFa9lqjLJtUEOoBqZakJtiDtR5hUhO10US02J6+fU01O67rUFqcoFRUReXyjZvcwz3ob6MkRtgL4ZfhndTIQE0AG4HOn0U4OXSIKCsFhuVQlu5P+0IoY4WC5rpZXGP4fVY4j758y/YCuz4FALK/c05l3LGpZ6uvN+8e+BXMyYcI9UlghlRus64FrTmC42PVkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6454.apcprd02.prod.outlook.com (2603:1096:820:cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 03:56:42 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 03:56:42 +0000
Date: Fri, 11 Sep 2026 11:56:37 +0800
From: Chao Liu <chao.liu@processmission.com>
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2 04/14] target/riscv: Preserve MINH on delegated config
 reads
Message-ID: <aqN7zJNGnex7oTSA@MacBook-Pro-4.local>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-4-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-riscv-pmu-correctness-v2-4-5da5159a0c64@linux.alibaba.com>
X-ClientProxiedBy: PH7P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::6) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: e65ae033-077b-4eb2-f128-08df0fb8b079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RffFNb1qLs90DSx2fsyrqbSGM5Rsu44jUmF3N+8NYJf9wbyfUpIHnS3Zf/UnmN90lqcAtInB3tsHEhF5CW2YvzOB9M1bcpyn+f3wmK0Wihy58ym6hd7PK05uPVPHjTcOT2kgQS7MjeaJyAf6Xhf7H/1in88VQGeVN2awzk9Ftoo4q64nT3N7nuTjwxLETSNTyn/Quwr6DiHFxObpu38Xk0kUGB0uRVRm+5qMtPXgOH14Iuficw/DEnFjjzCYxfogoDCzc88S9T5NtADWReF0oF/FLzsnly+u8yD6Sxa05jZ3wyepz1aM+ySRgrQ6OKbr61TDSDdMLqGuLQTwgQl13P7kXIlekrVRwrgfJkUFM9IfINqnmNs+Ns0HdWpesGhEKpxQitatDqfx9BlfZZs4ylr+bueyIQP8Lj9s6NKBVg+3sIzg1gRmS3asErv5tA3S1lJFjDtx82K7hOd8IDkTgNQZ5kNWKVlhfqJEwC0dSn/4bww1cX3mUqkNlxiJ7p9N/NQ2/STA63b3Pf3p3EDvFIMVFaFKCNedDwZFgGZra8S8Bfsjmmx9TcM7AMhS6GNDKdpBlhv0C0i459F1wz4NrPp+nM7zb26sxG8OHz8sb+aAVItgCyDRToohkgVcGIUi+ik0gGTsKWISOiGpoE3C27lfrI6bi6Rf0+dLjS/9uk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3wFBuLk6iX5z5MLnpmGjogJc/VxUt3jU11loQRUTpK8GmgPx3OyjHF3MdqPq?=
 =?us-ascii?Q?hBhOn4mutt/j2+LbGkoEV2CoS6r5NUpk/plysU9qv03tVOp45fxek2OjTRUE?=
 =?us-ascii?Q?+/DT1gbig3HX5wrCFkOtRCDhlKtzqBx/uv0aHA8AXtsC8WePmxRBlyrPnD4y?=
 =?us-ascii?Q?QeZlpOW4mOBTvA/QZwX9+IrVv8OzUjpsbuS2ps72B1fo041/4vXtC71WxcFd?=
 =?us-ascii?Q?gu7dDNJ8/nnAZB8thwG4+mJpJ1wcHcgVtamDYBGaW1PQq+3oBZsMqsm3d6xP?=
 =?us-ascii?Q?HZegUikLC/Szq6eEtNloLvTYbJ5Q3pzDuWAu8XvkzeoZcHhWhAR58ctSGEKR?=
 =?us-ascii?Q?q/FZQrB8/krXsDWQ19dH6oX26effbRIUrGUTzA5dBewmiJd4h9a1/tVXqiAu?=
 =?us-ascii?Q?12NO0jm2nqCDHKE6F6DkGwLqHIZb6UZ/G99fGCquHT+65y9KiMk2a/zr78qv?=
 =?us-ascii?Q?MqFs9y+G70OE9ILLHmPzzz4U6u23d+YXpjtZqODxoUDZwNjAlejIyp3DG7ji?=
 =?us-ascii?Q?VY5CN6uwXps8F/ysdHV5d3arhNi+rB2a3rVZQYvvC5TCDwqckF3SnCSHGwzT?=
 =?us-ascii?Q?fnNKkMS8viUz4QZLriHz3gPp8sv9PNfYDwrDuqTmjWej5H9hjQoWfzhPYecV?=
 =?us-ascii?Q?Ll2IsxIe4LzD0nP3xe+Dg4vScbuVoriQS6Ru9Lk9a+WQ9UKup9bK+6bJq/m/?=
 =?us-ascii?Q?lYP177D/9BAg/zrUSDJY0GbGvUK5KY2O6tsurXAOJnLoqe25HfSQdA62ZAXA?=
 =?us-ascii?Q?a6DWfustIRAGvQhC3Z0EHX2WHVOtcIx/QKez1wDuhHHC0OeXvk3BR5nEzajO?=
 =?us-ascii?Q?IRPkpOo9FZyE5hUuMZTSIcIFfjboK3c0gzGv3STuFV+jRBB/d2McWQP6aCje?=
 =?us-ascii?Q?Zuhu+n6LyOD5HD6JAweMeIGPxZ/XKVQ3e72xr0KZHnElQqN/GqZIvO8D9rU9?=
 =?us-ascii?Q?GanNN63gEc80ySjY1cYxMFk+3v9aFRXmrAgkk1aSn3/u4EdQpMLqJDVNQx+Q?=
 =?us-ascii?Q?FRVeirs41RYsxJDbGeiEfcwKKs/86SeZwesSb1DrXkHfYKvFRo0ciA8rWySQ?=
 =?us-ascii?Q?voWSCLam43gDWe3/vivMXhYETX+zhMD2YPgGisE2GhSO4v+o69IqiAAgrBDy?=
 =?us-ascii?Q?D9kKl55hmt137DLGNFcwHSFxJdfj4yXPcNGmwpZwLB1nm5CR4GWnFwcxM/I5?=
 =?us-ascii?Q?x2u4eS4PVhjgNgawIyaR2JGDFUl7Oe7rZ7H20dv47ZlOM+e7hOqcKWMs19d3?=
 =?us-ascii?Q?RE2xPOZ9ai+Zr05ZBzCSleXRAhpcbo67p9k+IPyuvK0aIM7P757XPdZco23b?=
 =?us-ascii?Q?YPcFy1kz4jVWXy+AtFkBJjnizYVpoDMpEPUYJ5C64VhRk7p75b0JLyylMKZW?=
 =?us-ascii?Q?QYy/eEp7o/FlYQD5uKavKq6WrfLB0Yxlj7QxCDAj8jDyvQhx41RIM2YVF9V9?=
 =?us-ascii?Q?igjmncKbCPO6VZ84zLy2E3LVyQ9+cQ1BY1z8UgnCKIoDnZs/kTfNSSA4plfY?=
 =?us-ascii?Q?cuT+RL04TPSpfjvIMNTx3YKBUlkRkrl6tLih5b3LDXmMlLaouTYnPufaiPPk?=
 =?us-ascii?Q?AQ0D3OmkMtzshm4DaA8rRrENqncvsoIy4RFHr0Fv//ABoNmBiYu/BBy9dNbP?=
 =?us-ascii?Q?Olm5IkevlOHPorC+6fR7OEyR+JmpoGtVokpCyFbl6XPuqwmZ0MuWwj6GJkWj?=
 =?us-ascii?Q?IQToeTeg7N1ExetibO+Ju3Lm91LY+e2jh8UTrPPSh+KEhcg9EPjEktslvcQe?=
 =?us-ascii?Q?wo6hl+RwgHhlzjJMy81N3sHDdM4tgaI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65ae033-077b-4eb2-f128-08df0fb8b079
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 03:56:42.0716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwIr22kED78gJQstLK/KcX1QkF5aLdstCK7r3uJWUSD92GL84tnBrTNJhSIiFQ/fwuzbi/xUNiN1qFxoqmZoYXVtN2+zcDRQUvdmGp30jUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6454
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

On Thu, Sep 10, 2026 at 10:39:41PM +0800, TANG Tiancheng wrote:
> Smcdeleg requires MINH to read as zero through sireg*. The RV64 callback
> masks it by modifying the machine register; the RV32 high-half callback
> does not mask it.
> 
> Return a masked copy without changing mcyclecfg or minstretcfg. Test both
> configuration registers on RV32 and RV64.
> 
> Fixes: d9fa41e10156 ("target/riscv: Bugfix make bit 62 read-only 0 for sireg* cfg CSR read")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/tcg/csr.c                 |  8 ++--
>  tests/tcg/riscv32/smcdeleg-minh-rv32.S | 78 ++++++++++++++++++++++++++++++++++
>  tests/tcg/riscv32/system/meson.build   |  7 +++
>  tests/tcg/riscv64/smcdeleg-minh.S      | 78 ++++++++++++++++++++++++++++++++++
>  tests/tcg/riscv64/system/meson.build   |  7 +++
>  5 files changed, 174 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 60caee32dc0cf5b6a8492e0cf8ff15f71acc2087..57030724f85a897e21e5082b9857411b50f932ac 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1607,7 +1607,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
>              wr_mask &= ~MCYCLECFG_BIT_MINH;
>              env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
>          } else {
> -            *val = env->mcyclecfg &= ~MHPMEVENT_BIT_MINH;
> +            *val = env->mcyclecfg & ~MCYCLECFG_BIT_MINH;
>          }
>          break;
>      case 2:             /* INSTRETCFG */
> @@ -1616,7 +1616,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
>              env->minstretcfg = (new_val & wr_mask) |
>                                 (env->minstretcfg & ~wr_mask);
>          } else {
> -            *val = env->minstretcfg &= ~MHPMEVENT_BIT_MINH;
> +            *val = env->minstretcfg & ~MINSTRETCFG_BIT_MINH;
>          }
>          break;
>      default:
> @@ -1642,7 +1642,7 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
>              cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
>              env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, cfgh);
>          } else {
> -            *val = cfgh;
> +            *val = cfgh & ~MCYCLECFGH_BIT_MINH;
>          }
>          break;
>      case 2:          /* INSTRETCFGH */
> @@ -1652,7 +1652,7 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
>              cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
>              env->minstretcfg = deposit64(env->minstretcfg, 32, 32, cfgh);
>          } else {
> -            *val = cfgh;
> +            *val = cfgh & ~MINSTRETCFGH_BIT_MINH;
>          }
>          break;
>      default:
> diff --git a/tests/tcg/riscv32/smcdeleg-minh-rv32.S b/tests/tcg/riscv32/smcdeleg-minh-rv32.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..db467b95cf1441e3440f59097401cf6956d294d3
> --- /dev/null
> +++ b/tests/tcg/riscv32/smcdeleg-minh-rv32.S
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/* CSR numbers for older assemblers. */
> +#define CSR_SISELECT         0x150
> +#define CSR_SIREG5           0x156
> +#define CSR_MENVCFGH         0x31a
> +#define CSR_MCYCLECFGH       0x721
> +#define CSR_MINSTRETCFGH     0x722
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global	_start
> +_start:
> +	/*
> +	 * Failure bits:
> +	 * 0: delegated cyclecfgh exposes MINH
> +	 * 1: reading delegated cyclecfgh clears mcyclecfgh.MINH
> +	 * 2: delegated instretcfgh exposes MINH
> +	 * 3: reading delegated instretcfgh clears minstretcfgh.MINH
> +	 */
> +	li	t4, 0
> +	li	t0, 1
> +	slli	t0, t0, 30		/* MINH in the high half */
> +	csrw	CSR_MCYCLECFGH, t0
> +	csrw	CSR_MINSTRETCFGH, t0
> +	li	t1, 1
> +	slli	t1, t1, 28		/* menvcfgh.CDE */
> +	csrw	CSR_MENVCFGH, t1
> +	li	t1, 5			/* Delegate cycle and instret. */
> +	csrw	mcounteren, t1
> +
> +	/* Check the delegated view, then the underlying machine register. */
> +	li	t1, 0x40		/* siselect: cycle */
> +	csrw	CSR_SISELECT, t1
> +	csrr	t1, CSR_SIREG5
> +	and	t1, t1, t0
> +	sltu	t1, zero, t1
> +	or	t4, t4, t1
> +	csrr	t1, CSR_MCYCLECFGH
> +	and	t1, t1, t0
> +	sltu	t1, zero, t1
> +	xori	t1, t1, 1
> +	slli	t1, t1, 1
> +	or	t4, t4, t1
> +
> +	li	t1, 0x42		/* siselect: instret */
> +	csrw	CSR_SISELECT, t1
> +	csrr	t1, CSR_SIREG5
> +	and	t1, t1, t0
> +	sltu	t1, zero, t1
> +	slli	t1, t1, 2
> +	or	t4, t4, t1
> +	csrr	t1, CSR_MINSTRETCFGH
> +	and	t1, t1, t0
> +	sltu	t1, zero, t1
> +	xori	t1, t1, 1
> +	slli	t1, t1, 3
> +	or	t4, t4, t1
> +
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sw	t0, 0(a1)
> +	sw	t4, 4(a1)
> +	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence. */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	8
> diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
> index 16f9a06c9485ed75b3d127d6b9d090f5eaad4486..cfe2d854b729a8dfdbce2373e73b91b470db6b4e 100644
> --- a/tests/tcg/riscv32/system/meson.build
> +++ b/tests/tcg/riscv32/system/meson.build
> @@ -22,6 +22,13 @@ tests += {
>    },
>  }
>  
> +tests += {
> +  'smcdeleg-minh-rv32.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', qemu_args],
> +  },
> +}
> +
>  if 'qemu-system-riscv32' in emulators
>    tcg_tests += {
>      'riscv32-softmmu': {
> diff --git a/tests/tcg/riscv64/smcdeleg-minh.S b/tests/tcg/riscv64/smcdeleg-minh.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..38d3c30f0afaa416a46322f2b892e5969172a60f
> --- /dev/null
> +++ b/tests/tcg/riscv64/smcdeleg-minh.S
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/* CSR numbers for older assemblers. */
> +#define CSR_SISELECT         0x150
> +#define CSR_SIREG2           0x152
> +#define CSR_MENVCFG          0x30a
> +#define CSR_MCYCLECFG        0x321
> +#define CSR_MINSTRETCFG      0x322
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global	_start
> +_start:
> +	/*
> +	 * Failure bits:
> +	 * 0: delegated cyclecfg exposes MINH
> +	 * 1: reading delegated cyclecfg clears mcyclecfg.MINH
> +	 * 2: delegated instretcfg exposes MINH
> +	 * 3: reading delegated instretcfg clears minstretcfg.MINH
> +	 */
> +	li	t4, 0
> +	li	t0, 1
> +	slli	t0, t0, 62		/* MINH */
> +	csrw	CSR_MCYCLECFG, t0
> +	csrw	CSR_MINSTRETCFG, t0
> +	li	t1, 1
> +	slli	t1, t1, 60		/* menvcfg.CDE */
> +	csrw	CSR_MENVCFG, t1
> +	li	t1, 5			/* Delegate cycle and instret. */
> +	csrw	mcounteren, t1
> +
> +	/* Check the delegated view, then the underlying machine register. */
> +	li	t1, 0x40		/* siselect: cycle */
> +	csrw	CSR_SISELECT, t1
> +	csrr	t1, CSR_SIREG2
> +	and	t1, t1, t0
> +	sltu	t1, zero, t1
> +	or	t4, t4, t1
> +	csrr	t1, CSR_MCYCLECFG
> +	and	t1, t1, t0
> +	sltu	t1, zero, t1
> +	xori	t1, t1, 1
> +	slli	t1, t1, 1
> +	or	t4, t4, t1
> +
> +	li	t1, 0x42		/* siselect: instret */
> +	csrw	CSR_SISELECT, t1
> +	csrr	t1, CSR_SIREG2
> +	and	t1, t1, t0
> +	sltu	t1, zero, t1
> +	slli	t1, t1, 2
> +	or	t4, t4, t1
> +	csrr	t1, CSR_MINSTRETCFG
> +	and	t1, t1, t0
> +	sltu	t1, zero, t1
> +	xori	t1, t1, 1
> +	slli	t1, t1, 3
> +	or	t4, t4, t1
> +
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	t4, 8(a1)
> +	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence. */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 668a9a76070b6f16087b08ea84683d883312e951..5d91381c62d77ae7e37c129112d6367f692df660 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -75,6 +75,13 @@ tests += {
>    },
>  }
>  
> +tests += {
> +  'smcdeleg-minh.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', qemu_args],
> +  },
> +}
> +
>  if 'qemu-system-riscv64' in emulators
>    tcg_tests += {
>      'riscv64-softmmu': {
> 
> -- 
> 2.43.0
> 

