Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6577BC4452D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 02:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmMJ0-0007OX-PY; Tue, 21 Jul 2026 22:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wmMIy-0007Nn-CL; Tue, 21 Jul 2026 22:03:28 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wmMIw-000309-G2; Tue, 21 Jul 2026 22:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYHKK9U/ADN0qffEFIe9kZsBL7q2MTmlhJR/KAWeipin2eZgYBf+KeupQ7VDtjb++jmcr6WT7BjNnbiEpXihPK140bTevVCmfjvlYx8x0kqm0i9cn8JisFaWboHGNI5goWOIBhHNw/1f0e15gQWSMcm3QSVOyW+yXypNM3bmpycfQzlJHgX9sRuFQzn+1qENA6St0vtp2xLw22nioxsyHDQbQx9LXAqOi728ApvAE0QGm0pNyuS1xUO/9U8tH+yXG6D7Do9UuBCG8vHiQWbvWlXGBhdTq1REsJBv4SAC7QibSe7UmlNKMZuFQ5sSGz32evOaY/U/NJ1j6gqFP7tnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYDFSw6dg80ql8qkSiIqg6vPTreUJQU1Qtey6ExF41A=;
 b=Od26Pw3YI0v7JGTZKq3YleDZABet/CV6b2Q6EByKURI20ePhOve0zCMpJjA2D9HYteCN6VaQSg47oCDjSgJOBcFRVbguzbzR+Vn3lVW56N6L1zJ/oNKi4f7djn+Unk3/0KsCx74TPlYXn9O9vym34FUaGGD0IXGCyCZOJCVSaMbA4lE2VXRmGIPDlitaAjxe5pZgJLGNSnXpeO8FVlu6j5U7T1gzGuPbtn7oZ6n23vOGGEm/KPaomPartq7Y7DjH4a1EpCDajeuIWAZB4qq7hh7gLRzhahhdUFB00epERXZcP9RcF9pFyKQ9lgbdzmh7N0mcA52ZJY8n98YmNp4qaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYDFSw6dg80ql8qkSiIqg6vPTreUJQU1Qtey6ExF41A=;
 b=uZRLxqIU+7OhOtyjTmZwUOgbKxkIMe9IWRC3WDjWxTgXogTOuywtPP9LnvEQrhZ3y2WyFBhC+sgAkfztKehzlrxZUzAUzNtJuElx+w8QejlKZ0F8WGF33taohMsVm7ctubHt2Ct7/1xVoaGddZI8MuEAtSJru30TRDsqK6X9gl6o2eVE74ZAD2LzBWxqILU9Zt3F1772NU0dk75s0PR1RuYlsrGpnHaVvuZ6X7gaQlq4sJl3g1WBFNwhvdGdyO09Dl0M5fW0B56gcJ5WjIUCgbRvNrXN7spv9+/EFjh67u9W4SUo4HGNc3q4OYDUQ30cygAxbulyDfloMmBc2aiGIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB7908.apcprd02.prod.outlook.com (2603:1096:405:b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 02:03:17 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 02:03:17 +0000
Date: Wed, 22 Jul 2026 10:03:11 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, farosas@suse.de,
 lvivier@redhat.com, caojunze424@gmail.com
Subject: Re: [PATCH 0/7] K230: add gsdma and decomp_gzip
Message-ID: <amAic0uJsYmM8IZl@ChaodeMacBook-Pro.local>
References: <20260721161335.73872-1-dingtao0430@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721161335.73872-1-dingtao0430@163.com>
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 002fbfa2-64c3-46c0-e6a3-08dee7956573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|34096008|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JBddcd1OK1pvL2Sn4SyzvcqlzA3a0bZh9OjhEG85nCLA0F5ctSp2yjGLHxGu2zgseSG/aYfqtRnSRR+mrqgeUpmjDohF2Z2PiEC2Kr849HZxXziO9qRI+5k5fQffKVUA07aJfOgksKDQEc6rgKn4rtUOzvn3HyDtL5TdPRNnExL1y8YjZk4EtYGq3LUbjRQz3XGCpP3C26PJzqEmJJZEY529V41u/LLoZaqYBv5WJ4qrG/KwmeJZnwf8/nk1a11luWx2/0RpEggumcuq2QxSf9uSbBypSk0PZpoYvXHAdE7oy0Vu6vpPsjknjwZtXolKCy0ZNZR7qZqdprmbEhKPd63t4ym0X2NlmhM7Upf2Sb9ijXepZ4dcy9sBmi46qCYx7eQUcBR8AcIsZa/Es6gYiKDXEBDCs/8x6jjTgBJn+EwvEK1+Gc6LrTmHvDj2q70/3BiIN8CT1lz4GlwfU0xoFt0Bp2EvBzX0v6ILBm6uIYwr5DWksZ6CuY2LW49JqO1WhFVgwo9CGiSGCYaDigv+bmJMKa1jwIRw7tim2hlo1ULHbpS5OtVVOh+m52GYYvbu9BOh6Z5/pMLAG48iAWvR0A2PPLGGlTITevXsib8Yqtg4GiuCSixp7tYqKq1CI7YRLcqz3XKnMf/H/aK1JvCJJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(34096008)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SATt9O9ktNpVbJZs7rVKCXNWUl7WhvOxTByh/vu9tJ5DmzgQspAJVdKV04JW?=
 =?us-ascii?Q?GTF18dBWqUKtevqGmlS8k833B98SR9KjCYVsJAEwwbuKdCCRIH7lAPaF3C/k?=
 =?us-ascii?Q?E1f5/cysSdE5mqOaVBg6I9GOVcxFcjM0lDhC18ecSwxSUaOB27KDW5NonuIw?=
 =?us-ascii?Q?M96cSH/lxBXvrP5ia0Q8vqY3sOmb4wW9wSeqWziXe0EEBvO+WJm6WVgi1Kce?=
 =?us-ascii?Q?p/m86m63SnvnoJn0gAB08R3xIiQmSRGLh3foFsrjIrk4dPQQ1AITCgw9M4a4?=
 =?us-ascii?Q?lk3gM+bVPc2/HmtKDC8N2/rW4+kdjHXCU80ZLTfOjMWfKx2p5Gza6E3VI3Cm?=
 =?us-ascii?Q?Mi8tVzWL36xhz9M9E1IZl8mEYBWUFrsp8GijJuWMPpEr5R2faP2bW8HZUXL7?=
 =?us-ascii?Q?h4W4A7ctGe59jnzkg1Bxqw+zCwdBJ/84f0Lx5TyAuif1cOxn7pL8KXH4QNlz?=
 =?us-ascii?Q?336rHFO9fgbnTYxfbG/ai+ByGzjkfRzcBzK6o8HqHVm3BBEOh3wfASCEI+dn?=
 =?us-ascii?Q?EL7ivoJqKQlcTDi+mcDRPjK/ZxvK6BikODOY+0KC+u7p+X6ftxONDR2xCsDG?=
 =?us-ascii?Q?/O/C2iSLJo4Wn7t3x+Vkv2e9TH8B1YrhDt0x9o7vqkLn63c8tRTifJNNzM0n?=
 =?us-ascii?Q?RGMd5EPtWoJhIfMErmiTv640FKQ2E3ajHX9ctzgme5jkytjPzWibj07U7p7b?=
 =?us-ascii?Q?DLOK9dzkydT/Vy+IvkvljdRKyqtiuJHR38tBky6yoQ/1iB3CX+ZYZMCNy20+?=
 =?us-ascii?Q?CxJkLk//yiHIFEXAteUiX7OOI0J98pi9J8orsj8p4WwmR/n4DTXpjhhe7+3R?=
 =?us-ascii?Q?+NSlogLrsvbaiXJ/YP/A/pkTEF8PYWcFgbIA7bIDIzUXH6KMAhn1M9Fvx1pX?=
 =?us-ascii?Q?cLIIOA50cLChm3KpaEOgfFYUsnBT94BdWE53YlJP+en11MpwFhpdLqKcrKK/?=
 =?us-ascii?Q?KCBGZIcM0G0CnbDFipFDrwSMXEU5eo5EQxr+33fNunIIYedvvTPffTB45Xd0?=
 =?us-ascii?Q?mnobgRaVhiePOQiNbvfAEQ98Ercq4WFw5yjBE33zp//JKlJaMxSEdNoVHVxY?=
 =?us-ascii?Q?uZwebv/PF7ahRsn7m8iuFXo+89KxQLJJK5r30hO5+Pj51BC8X6Jee1eGN3ET?=
 =?us-ascii?Q?XuXPRAmPUGCJUwTgfMCXIBerClC/0rHyLDUxoYgUHUtj8ROXRuihqSQl4Rgb?=
 =?us-ascii?Q?WK5Co0thalL2HU3YVUg5sZdJYPOwAme+l2bSwFhaJf/2JUTcFb93dR47b1Hu?=
 =?us-ascii?Q?He4Phb4DuPEIwcNRju6XZH87ERHSwdZnF/DUUIsKRDXNKm6Z7rFdKUai1FDP?=
 =?us-ascii?Q?r59C0QVOqtVR6wCnUWhEEzPoCOMZCOyXb8qGH7VgaY2zb7ChXHVPSQsw+GJ7?=
 =?us-ascii?Q?ft4++z9O3DpL+lQLcpXkoGYdCw5zpKU8tMj3QZ5XuoauDQ+/Nlyvt2d0K2zh?=
 =?us-ascii?Q?GWHCGqRzDCy+bkSwDKVCfc5OGK4tmngYaaco1tnUDIjcl6RnE9x3SV68b/6i?=
 =?us-ascii?Q?A5Ue0yOwXn41LutMzJ71TqT5DEe/X7faRSkxhn8zzZrhZri+aFvtnuWoPlcI?=
 =?us-ascii?Q?XqrwomekIvEBfeg7JXp9qaxJakmyr2ay1r9M+ZF4YiIo7OctwivfXTGpNVG5?=
 =?us-ascii?Q?slkpemXFpINFr1bdzOVaPIFXFse1KrvSDMu/2M/0FTHGCw6buiaTeVwB3Auu?=
 =?us-ascii?Q?Gp2inP9mIBwiq7ANXd5+hmcUKEqdaGBTikOmx2sUaIXzI++4CAbKCNr0/LX1?=
 =?us-ascii?Q?gq3kBrnv/w86U8d7WqhyWcXINiwuD20=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002fbfa2-64c3-46c0-e6a3-08dee7956573
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 02:03:17.2999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNUaMPBVh7GMP/KkWCALRfYaYeQLZL4eshiVPWK7n20BW36cnGlLiod3df9iHQkFqxwYFq+kfsLiYrQ4gvBkvmQvM7Y75TJeOo+F4coaD+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7908
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

Hi Tao,

On Wed, Jul 22, 2026 at 12:13:28AM +0800, Tao Ding wrote:
> Hi all,
> 
> This patch series adds GSDMA and Decomp_gzip to the K230 board.
> Enable k230 to use k230_unzip to decompress files during the u-boot phase.
> 
Thanks for the contribution!

I believe you need to update the K230 documentation. If peripheral modeling
for things like UNGIP and GSDMA has been added, could the boot flow in the
firmware linux booting path be simplified to better align with the hardware's
actual boot process?

cc Junze, Can you help review this? Thanks!


Thanks,
Chao
> This series includes the following features:
> 
> *patch1: add K230 gsdma which supports sdma, gdma is temporarily not supported
> *patch2: add gsdma to K230 board
> *patch3: add K230 gsdma qtest
> *patch4: add K230 decomp_gzip which decompress data work with sdma
> *patch5: add decomp_gzip to K230 board
> *patch6: add K230 decomp_gzip qtest
> *patch7: add a noc-stub region in K230 board
> 
> Thanks
> 
> Tao Ding (7):
>   hw/dma: add K230 gsdma
>   hw/riscv: k230: add gsdma in K230 board
>   tests/qtest: add test for K230 gsdma
>   hw/misc: add K230 decomp gzip
>   hw/riscv: k230: add decomp gzip in K230 board
>   tests/qtest: add test for K230 decomp gzip
>   hw/riscv: k230: add a noc stub region in K230 board
> 
>  hw/dma/Kconfig                      |   3 +
>  hw/dma/k230_gsdma.c                 | 532 ++++++++++++++++++++++++++++
>  hw/dma/meson.build                  |   1 +
>  hw/dma/trace-events                 |   6 +
>  hw/misc/Kconfig                     |   3 +
>  hw/misc/k230_decomp_gzip.c          | 498 ++++++++++++++++++++++++++
>  hw/misc/meson.build                 |   1 +
>  hw/misc/trace-events                |   4 +
>  hw/riscv/Kconfig                    |   2 +
>  hw/riscv/k230.c                     |  38 +-
>  include/hw/dma/k230_gsdma.h         | 128 +++++++
>  include/hw/misc/k230_decomp_gzip.h  |  92 +++++
>  include/hw/riscv/k230.h             |   5 +
>  tests/qtest/k230-decomp-gzip-test.c | 181 ++++++++++
>  tests/qtest/k230-gsdma-test.c       | 201 +++++++++++
>  tests/qtest/meson.build             |   2 +-
>  16 files changed, 1689 insertions(+), 8 deletions(-)
>  create mode 100644 hw/dma/k230_gsdma.c
>  create mode 100644 hw/misc/k230_decomp_gzip.c
>  create mode 100644 include/hw/dma/k230_gsdma.h
>  create mode 100644 include/hw/misc/k230_decomp_gzip.h
>  create mode 100644 tests/qtest/k230-decomp-gzip-test.c
>  create mode 100644 tests/qtest/k230-gsdma-test.c
> 
> 
> base-commit: bd6079a7a1d14de0918a7715ef6db85dc32de3bb
> -- 
> 2.43.0
> 

