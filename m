Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D746C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmp0t-0007eT-Nl; Thu, 23 Jul 2026 04:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wmp0r-0007dC-QM; Thu, 23 Jul 2026 04:42:41 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wmp0p-0008Fl-HL; Thu, 23 Jul 2026 04:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz0qvf0gxNjsOmX4Qv0kdM4tbNETDp/5Wrlx94rCXbqoAN4pzPi1Jupda09tVze2xeVEtuluiSe2RnPyuT+4Fqs1s8GglloB6r/Khwte00jmEP+MaGxpiNEbVlt4pZTN3k7Zn3TU6ubAemfghxRTVyaD4MTXPtSWTxTB/Tc12ep7fSQ/xs3DXS3ZoPBxN5LcPDjkGJ8idxz69LdtQMRY9OTM6YeuobNzosxYY+1TR1UzQ7nMdxlkx2UgDPNBVU2SxUw+plMA2+RmGcSu/FeNaokEfTdkhLaRyXXuSeHW4JqYNKiEsOMduqIgcKFlQdzqcaNjoGc0YP4E4tVVVncIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPexuC0rWc58ggh8Z+6Kzm3BTb+evRJGSHxXN5a+M6M=;
 b=dpYxJz/m5ncPzrT9+rRosfyp4+0UmAs5t9J1F508ZVoksFabVlcK2MCzQujA/JSOVBMF897f+VtsmXV0Uiwv2tSF5HmP2bpHF3YajC9QiMfaAuX9tJwRMPckkLJFBlcNqTVlqFylxUnf5L2BwHh4Sc9mhe9aUROpOmZv1f0zTD8It/jhjL/Nuv4FcQ/sdgmt6kmuwKOG3snWNeb26XBPineHB/8UL+nOACotsLdOHglwt2xC1feVGCg/zawcaPUg/GPEVrColUoghaUvAKJSw3fKhTzomm9mhUGqyKqT2PXT+mcciUdcIQas2G6OaHLEsVYbmV7+gOlFCHpqLdRpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPexuC0rWc58ggh8Z+6Kzm3BTb+evRJGSHxXN5a+M6M=;
 b=cEqOWRVXJENj7JYwnI1jMLf10/l1FsfEc5Rfo8ojLOni2A8rG4pjYl8rpItXh6D0yK6G/SMnoW6FtivJ3Jn1BBQUAkNNQ3qYtjBpYVnsMMiOqfOOI11haNKcHX4xraXSxdwLSWCie8guIYYH+PCVkUVjxgPYKjeSOK5fajb0MGGhmXzXC5AgGbAaq6IPaV6ksCJY4V29kBRNWaQyBxOjbvo5f4ALda3XGC3oct+udeITlKmByxmwfDcnFYrx3bu+HzwicK3rRoSPm2m2oymIqgGJL9jk5qhLraHwPDd+HOcypWqyZ7RyjNXE1t1pAQ5aDLs4rwQglEUsd26uIh3Exg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by KUXPR02MB9071.apcprd02.prod.outlook.com (2603:1096:d10:5c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:42:34 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 08:42:34 +0000
Date: Thu, 23 Jul 2026 16:42:28 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Junze Cao <caojunze424@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 3/3] tests/qtest: Add K230 DDR controller tests
Message-ID: <amHT6_8b9qEbtGO8@ChaodeMacBook-Pro.local>
References: <20260716132423.931427-1-caojunze424@gmail.com>
 <20260716132423.931427-4-caojunze424@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716132423.931427-4-caojunze424@gmail.com>
X-ClientProxiedBy: PH8PR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::11) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|KUXPR02MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 362cdfb1-4259-418e-5680-08dee8965781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|1800799024|366016|7416014|376014|23010399003|4143699003|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZRy2jN9hAuvjmcZY0OPq6hUHa9pntkUTqmDnwZZLTa5piDxYRnxNEGBsGlI9+UMbsMbXpP1p1SDNVPlngJTZ0Dp3r7y8Xf0tjgmrbhXYBWRgpbuUxUwHxIfbLgki9jG3CLlaJcfJxIjWXVo5F/Y2p5t9QH/TDANuGfqNhqHDl5KeZgwCOxSvnliPO6qD73KtgHyRSk5gS/qd6i9CSXkmJd8QIlBo8djnP5vYiED3W+/SGUuMWAAEr4ZMfDiNjUnWZRxs2JRjWbkoHuotulJlGm1DlPc/va6pQnTYwJFEDr/3d04v9aEA8+mqgEQu1hIcu7mFCGRI3rUwiTgNVPIZdfD+hIWwOB7AG1tn8swpm50N/VaquEH7KsFBbbN3FWXYS0uVNcoTdWdx2LM/c4T6/U8l9shOLxGVppOfFiwrQ6sm12aqGhXaMa3Jn+crb6iVoCQYw6A5eI90VDjMMoJN9BTyA4viWPOf+YeuFNp0zOrD0J9qAvoV0Ja2bCJ4xamTKPgtoHy67cMrQRDq8lvhW4S3+/LziG6C+3sxl+sxASTgRFMdek3DwtToi6vTYdpNYhPAXsW1C8v2yei+cr0LhIzRHwy0kf1OnL+F1XbbyLPwI25+bJdciJnR+rSIn1j2z852e3MFYkhUHtKzB3/GXYoS+71QGAlnrHt5Y0dpCLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(1800799024)(366016)(7416014)(376014)(23010399003)(4143699003)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbH47nUAlpBYYZZUgTj5VuX6i+55WcFv1E6MpuheSp0i54H7JAP1lGa0lMS8?=
 =?us-ascii?Q?eZASDtvrEf12uvEdHIUHOejpiY+IqmC2fnbL/laPyaNpZvE4y59JrGBt6ioi?=
 =?us-ascii?Q?IsSOQtVdOo1wckZNzNjeWneAVcgQndG+nuXhEZvPMmgFJyXBs3sosq84a1Y/?=
 =?us-ascii?Q?6WstIbl9mtByN4qH3aLmxToG0mwnX+B+7/Cmr7MpSD3mm4JKG9+ETY3O3jKy?=
 =?us-ascii?Q?713xcca/1J6Ot+9yGZEh/6fIB8drdl8VcjOH5cyQygl4C/6L5wNTNF3ndBEU?=
 =?us-ascii?Q?hqTEDMX0t7fzDhY1/FApuBNn0cR23SHH/rjlCWkkFd4BwIZQJKKeXp3LlX4e?=
 =?us-ascii?Q?ogU4jrXc93u9z/5Lcb/yn1lm/JUcSg53JsQW8QbjSP0CqN2aRspsiwIGpxog?=
 =?us-ascii?Q?gpK41lswdEx5GLy7oOtlFagDwZtSKOynvRTwW/4qC+Jhlhlpw/ZBpZT9U+OD?=
 =?us-ascii?Q?7fYsGjzOTlbIVp6eeLhOnF9TJ589pne0YJpdKOLN7gRjzc4H5bI7U1FNvK1k?=
 =?us-ascii?Q?t7DD+H0blHRcItyCMFzkLfhcFubJ8Lys3k42mrtAmhS/N25sInByTFumbg3M?=
 =?us-ascii?Q?A8tLfLTZoPLZ+N/MDJtFkrJ587GJo3W3Qi300ydcR+4SoVyKeme0reG84Es5?=
 =?us-ascii?Q?pQpCeKE7cRKlsB2u3NYni5C8fN7Gjd0PzlpKzHvx1MMdh0mF7nNExFHPg0X0?=
 =?us-ascii?Q?CdNwmP6/JS9B8+fz8Q7AYRMiTQQvGGIyc+WNpjHhpsMvLOZBXiF3rkCuKwar?=
 =?us-ascii?Q?QHOcMzKTa4WOb/sIk1bsQRAhjWXpXVkq4Kks4e0XnJpYVm55/T/xQwjN7PTb?=
 =?us-ascii?Q?r7s1J6XGYTNqGysKOaDMDoFs0bMKOiOxuI7p7QJyxmgGshKIlsHlxv8HKSgT?=
 =?us-ascii?Q?v0PegfUSfh5llydqwLvupnJ6eOUnm1A9NQ54lKBaFnul8xX98xeq4omsXTEh?=
 =?us-ascii?Q?Pz3vbwf6PuFsMTOPWpgqLDiVF+VQYO8s+EyW2LM28llRRSJfAUdosqNbD8z/?=
 =?us-ascii?Q?7AZUn4Fo+Ey/GmpnCsEdULIiBm3xxHz1zFCdPpsKM1bdpXguavZ94tiyuOyG?=
 =?us-ascii?Q?ZdDDEv1qi3B9wQwD1ovE8uDzudItj475w1jSOuxs2DymfxSqKKXlKLFQ/uvb?=
 =?us-ascii?Q?LGphbrdcRBFkBW/C+1trIcEYnW5VS5JU4qvnIhvsInGsGRg4kFTIB3p3uJuu?=
 =?us-ascii?Q?j3k6hD+P2baQADGwBxj8NHeb6LlmhHzsS3+5fWfcC7AX/5nYz9srEhhHhlFB?=
 =?us-ascii?Q?XG3RzAGEsbG9kz4hYUnuhK6AKzgubJ7eyPvN6hNAY44fmKiP1Q6fIEoMHomN?=
 =?us-ascii?Q?bFtTkDiLi6NCGDeA28SKQpGHHKSAeMeKHGPTF9If2yo4RqAY7aPqoPSgbjDQ?=
 =?us-ascii?Q?cLJujt8rEP/dMV2oIoy/fnw6AV6rAatVdIFLEdX+xwQMd0sxQh6G15QkZv66?=
 =?us-ascii?Q?WLzdNeMIobTSyDGhAu5A5VpcksGZRFZ+MIVb5N4V127Cz0/dzG1Of8g8Q1cU?=
 =?us-ascii?Q?sKK/yvbjlewKhl0TneOo1/x3GnqpT/Zv5pqhGObS85GO9dh4EAavGBNT6mPg?=
 =?us-ascii?Q?Wa3EllcD0Sn5s7rREe22ho6A0H89N/sHP9GZAo5/5WPmNL+XKAsni3AjzGe1?=
 =?us-ascii?Q?369YD5D0HuEJRDtoZsMHUxyCmnby5hhIdEU0YVAXh0kJsq29PRxmMPYTiLhN?=
 =?us-ascii?Q?YeE+waJPzPk2CnB9ho5Dtglbd55p06XcSS/ZukzAQLf7xbVglpaufc4TUV0S?=
 =?us-ascii?Q?h+cSkAw/dBngsobqlh5OHrXEykB23oc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362cdfb1-4259-418e-5680-08dee8965781
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:42:34.6280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSz0ngJZhIQdEtPSKTCd7NPwVOzzvruMSvWaaifwq6pE1qqmf79gnZ3C4jLU4r9yfgXNW3EkP/dM/2nGYJeAWs2Z4sFwNQmdntvJve++9+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9071
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

On Thu, Jul 16, 2026 at 09:24:23PM +0800, Junze Cao wrote:
> Add qtests for DDRC and PHY reset values, register access policy, the
> software-update handshake, and PHY register ownership.
> 
> Exercise PHY training and mailbox acknowledgement through the DFI
> initialization sequence. Include negative coverage to ensure DFI cannot
> complete before PHY training or enter Normal mode before completion is
> enabled.
> 
> Signed-off-by: Junze Cao <caojunze424@gmail.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  MAINTAINERS                 |   1 +
>  tests/qtest/k230-ddr-test.c | 226 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build     |   3 +-
>  3 files changed, 229 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/k230-ddr-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1cb3ef6c02..ace7def55e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1833,6 +1833,7 @@ F: include/hw/misc/k230_ddr.h
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
>  F: tests/functional/riscv64/test_k230.py
> +F: tests/qtest/k230-ddr-test.c
>  F: tests/qtest/k230-wdt-test.c
>  
>  RX Machines
> diff --git a/tests/qtest/k230-ddr-test.c b/tests/qtest/k230-ddr-test.c
> new file mode 100644
> index 0000000000..72362929bc
> --- /dev/null
> +++ b/tests/qtest/k230-ddr-test.c
> @@ -0,0 +1,226 @@
> +/*
> + * QTest testcase for the K230 DDR controller and PHY
> + *
> + * Exercises register access, reset, PHY ownership, training mailbox, and DFI
> + * initialization.
> + *
> + * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +#define K230_DDRC_BASE    UINT64_C(0x98000000)
> +#define K230_DDR_PHY_BASE UINT64_C(0x9a000000)
> +
> +#define K230_DDRC_MSTR    0x000
> +#define K230_DDRC_STAT    0x004
> +#define K230_DDRC_DRAMTMG4 0x110
> +#define K230_DDRC_DFIMISC 0x1b0
> +#define K230_DDRC_DFISTAT 0x1bc
> +#define K230_DDRC_SWCTL   0x320
> +#define K230_DDRC_SWSTAT  0x324
> +
> +#define K230_DDRC_STAT_OPERATING_MODE_MASK          0x7
> +#define K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK    0x1
> +
> +#define K230_DDR_PHY_CSR(index) \
> +    (K230_DDR_PHY_BASE + (uint64_t)(index) * sizeof(uint32_t))
> +
> +#define K230_DDR_PHY_ATX_IMPEDANCE      0x00043
> +#define K230_DDR_PHY_TX_IMPEDANCE_CTRL1 0x10049
> +#define K230_DDR_PHY_VREF_IN_GLOBAL     0x200b2
> +#define K230_DDR_PHY_MICRO_CONT_MUX_SEL 0xd0000
> +#define K230_DDR_PHY_TRAINING_STATUS    0xd0004
> +#define K230_DDR_PHY_TRAINING_ACK       0xd0031
> +#define K230_DDR_PHY_TRAINING_MESSAGE   0xd0032
> +#define K230_DDR_PHY_TRAINING_TRIGGER   0xd0099
> +
> +static void complete_phy_training(QTestState *qts)
> +{
> +    qtest_writel(qts,
> +                 K230_DDR_PHY_CSR(K230_DDR_PHY_MICRO_CONT_MUX_SEL), 1);
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 9);
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 1);
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 0);
> +}
> +
> +static void test_reset_and_register_access(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
> +                    ==, 0x01040000);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT),
> +                    ==, 0x00000000);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4),
> +                    ==, 0x05040405);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC),
> +                    ==, 0x00000001);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWCTL),
> +                    ==, 0x00000001);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
> +                    ==, 0x00000001);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_ATX_IMPEDANCE)),
> +                    ==, 0x03ff);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_TX_IMPEDANCE_CTRL1)),
> +                    ==, 0x0fff);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
> +                    ==, 0x0200);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_MSTR, 0x01040008);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
> +                    ==, 0x01040008);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_STAT, 0xffffffff);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT),
> +                    ==, 0x00000000);
> +
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL),
> +                 0xffffffff);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
> +                    ==, 0x7fff);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4, 0);
> +
> +    qtest_system_reset(qts);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
> +                    ==, 0x01040000);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4),
> +                    ==, 0x05040405);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
> +                    ==, 0x0200);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_software_update_handshake(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWCTL, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
> +                    ==, 0);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWCTL, 1);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
> +                    ==, 1);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
> +                    ==, 1);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_phy_ownership(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint64_t atx = K230_DDR_PHY_CSR(K230_DDR_PHY_ATX_IMPEDANCE);
> +    uint64_t mux = K230_DDR_PHY_CSR(K230_DDR_PHY_MICRO_CONT_MUX_SEL);
> +
> +    qtest_writel(qts, atx, 0x155);
> +    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x155);
> +
> +    qtest_writel(qts, mux, 1);
> +    qtest_writel(qts, atx, 0x2aa);
> +    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x155);
> +
> +    qtest_writel(qts, mux, 0);
> +    qtest_writel(qts, atx, 0x2aa);
> +    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x2aa);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_dfi_prerequisites(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDRC_BASE + K230_DDRC_DFISTAT) &
> +                    K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK,
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) &
> +                    K230_DDRC_STAT_OPERATING_MODE_MASK,
> +                    ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_dfi_complete_enable(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    complete_phy_training(qts);
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDRC_BASE + K230_DDRC_DFISTAT) &
> +                    K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK,
> +                    ==, 1);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) &
> +                    K230_DDRC_STAT_OPERATING_MODE_MASK,
> +                    ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_training_and_dfi_handshake(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    complete_phy_training(qts);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_STATUS)),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_MESSAGE)),
> +                    ==, 0x07);
> +
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_ACK), 0);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_STATUS)),
> +                    ==, 1);
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_ACK), 1);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DFISTAT),
> +                    ==, 1);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0);
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 1);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) & 0x7,
> +                    ==, 1);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-ddr/reset-and-register-access",
> +                   test_reset_and_register_access);
> +    qtest_add_func("/k230-ddr/software-update-handshake",
> +                   test_software_update_handshake);
> +    qtest_add_func("/k230-ddr/phy-ownership", test_phy_ownership);
> +    qtest_add_func("/k230-ddr/dfi-prerequisites", test_dfi_prerequisites);
> +    qtest_add_func("/k230-ddr/dfi-complete-enable",
> +                   test_dfi_complete_enable);
> +    qtest_add_func("/k230-ddr/training-and-dfi-handshake",
> +                   test_training_and_dfi_handshake);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 56ff860e21..dc110f72c8 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -297,7 +297,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>     ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ?
> +   ['k230-ddr-test', 'k230-wdt-test'] : [])
>  
>  qtests_hexagon = ['boot-serial-test']
>  
> -- 
> 2.53.0
> 

